## Load all necessary libraries

library(data.table)
library(lubridate)
library(dplyr)

## Download and unzip file from URL, creating and setting working directory

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!dir.exists("~/R/ExData_Plotting1")) {dir.create("~/R/ExData_Plotting1")}
setwd("~/R/ExData_Plotting1")
download.file(url, destfile = "power.zip")
unzip("power.zip", junkpaths=TRUE)

## Reading in large dataset

filename <- "household_power_consumption.txt"
tmp <- fread(filename, na.strings = "?")

## Converting date column from character class to time,
## filtering only the rows for the two dates we need,
## then converting the time column from character to time - 
## by pasting the date and time together, we can plot all
## of our time-series data more easily.

tmp$Date <- dmy(df$Date)
df <- filter(tmp, (tmp$Date == "2007-02-01" | tmp$Date == "2007-02-02"))
df$Time <- as.ITime(df$Time)
df <- mutate(df, "FullDate" = as.POSIXct(paste(df$Date, df$Time), tz="UTC"))

## Getting large dataset out of memory

rm("tmp")

## Setting destination file

png("plot3.png")

## Sending plot

plot(df$FullDate, df$Sub_metering_1, type="l", ylab = "Energy sub metering", xlab = "")
lines(df$FullDate, df$Sub_metering_2, col = "red")
lines(df$FullDate, df$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1)

## Closing connection to save file

dev.off()