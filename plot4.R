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

# define global parameters / plot arrangement
par(mfcol = c(2, 2), cex = 0.75)

# create plots

#plot 1
plot(d3$Time, d3$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

#plot 2
plot(d3$Time, d3$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
points(d3$Time, d3$Sub_metering_2, type = "l", col = "red")
points(d3$Time, d3$Sub_metering_3, type = "l", col = "blue")
legend("topright", bty = "n", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# plot 3
plot(d3$Time, d3$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

# plot 4
plot(d3$Time, d3$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

# Copy plot to PNG file
dev.copy(png, file = "plot4.png")

# Close PNG graphics device
dev.off()