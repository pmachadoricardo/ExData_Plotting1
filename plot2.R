# Set True for Windows OS
setInternet2(use = TRUE)

# Download dataset
fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./household_power_consumption.zip")
dateDownloaded <- date()

# Unzip dataset
unzip("./household_power_consumption.zip", exdir = "./")

# read data from file
data <- read.csv("household_power_consumption.txt", sep = ";", na.strings = "?", nrows = 100000)

# subselect first day of february
d1 <- data[data$Date == "1/2/2007", ]

# subselect second day of february
d2 <- data[data$Date == "2/2/2007", ]

# merge the two days
d3 <- rbind(d1, d2)

# convert Date and Time variables to Date/Time classes in R
d3$Date <- as.Date(d3$Date, "%d/%m/%Y")
e1 <- paste(d3$Date, d3$Time)
d3$Time <- strptime(e1, "%Y-%m-%d %H:%M:%S")

# set Locale
Sys.setlocale("LC_TIME", "English")


# create plot
plot(d3$Time, d3$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

# Copy plot to PNG file
dev.copy(png, file = "plot2.png")

# Close PNG graphics device
dev.off()