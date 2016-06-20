## This assignment uses data from the UC Irvine Machine Learning Repository, a popular repository for machine learning datasets. 
## In particular, we will be using the “Individual household electric power consumption Data Set” which I have made available on the course web site:
## Dataset: Electric power consumption [20Mb].
## Description: Measurements of electric power consumption in one household with a one-minute sampling rate over a period of almost 4 years. 
##              Different electrical quantities and some sub-metering values are available.
## The following descriptions of the 9 variables in the dataset are taken from the UCI web site:
## Date: Date in format dd/mm/yyyy
## Time: time in format hh:mm:ss
## Global_active_power: household global minute-averaged active power (in kilowatt)
## Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
## Voltage: minute-averaged voltage (in volt)
## Global_intensity: household global minute-averaged current intensity (in ampere)
## Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, 
##                 an oven and a microwave (hot plates are not electric but gas powered).
## Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, 
##                 a tumble-drier, a refrigerator and a light.
## Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.

## Set working directory to location of data file.
setwd("/Users/martin/data_science/Exploratory_Data_Analysis/week_1_project")

## Specfify data file name.
fn_house_power <- "household_power_consumption.txt"

## Read in all data (133 MB can be read in on my Mac).
## Note that in this dataset missing values are coded as ?, so ensure these are recognized as NA
house_power_total <- read.table(fn_house_power, header = TRUE, sep = ";", na.strings = "?")

## We will only be using data from the dates 2007-02-01 and 2007-02-02.
house_power <- subset(house_power_total, as.character(house_power_total$Date) %in% c("1/2/2007","2/2/2007"))
## Remove extra data from memory.
rm(house_power_total)

# Convert the Date and Time variables to Date/Time classes in R using strptime() functions.
house_power_time <- strptime(paste(house_power$Date, house_power$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")

## Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
## Open PNG device; create 'plot4.png' in my working directory
png(file = "plot4.png", width = 480, height = 480)
## Plot 4: Four Panels of Time Series
par(mfcol = c(2, 2))
## 1: Time Series of Global Active Power
plot(house_power_time, house_power$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power")
lines(house_power_time, house_power$Global_active_power)
## 2: Time Series of Sub Metering
plot(house_power_time, house_power$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
lines(house_power_time, house_power$Sub_metering_1, col = "black")
lines(house_power_time, house_power$Sub_metering_2, col = "red")
lines(house_power_time, house_power$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"), lty = 1, bty = "n")
## 3: Time Series of Voltage
plot(house_power_time, house_power$Voltage, type = "n", xlab = "datetime", ylab = "Voltage")
lines(house_power_time, house_power$Voltage)
## 4: Time Series of Global Reactive Power
plot(house_power_time, house_power$Global_reactive_power, type = "n", xlab = "datetime", ylab = "Global_reactive_power")
lines(house_power_time, house_power$Global_reactive_power)
## Close the PNG file device
dev.off()