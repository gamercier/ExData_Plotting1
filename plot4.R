
# Project 1: Exploratory Data Analysis
# G. Mercier
# 2015-07-12

# plot 4: Four plots in a panel
# set working directory:

# Set working directory to local hub repository
HOME.dir <- Sys.getenv("HOME")
GIT.repo <- file.path(HOME.dir,"git","ExData_Plotting1")
setwd(GIT.repo)
print(paste("Set working directory to ",GIT.repo))

# Read the data
# Dataset: Electric power consumption
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#
# Content
# 1. Date: Date in format dd/mm/yyyy
# 2. Time: time in format hh:mm:ss
# 3. Global_active_power: household global minute-averaged active power (in kilowatt)
# 4. Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
# 5. Voltage: minute-averaged voltage (in volt)
# 6. Global_intensity: household global minute-averaged current intensity (in ampere)
# 7. Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the
#       kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas
#       powered).
# 8. Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the
#       laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
# 9. Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an
#       electric water-heater and an air-conditioner
#
# Data is unzipped in the working directory already
 
# Read and fix the data.
# Data of interest are dates 2007-02-01 and 2007-02-02

# Making the header line 0
# At line 66637 starts date 1/2/2007 (day/month/year)
# At line 69517 starts date 3/2/2007
# Data is collected each minute. So 2days*24hr/day*60min/hr = 2880

# Read only the necessary lines
# With option header=T, the header is line "0"
skip=66636    # will read line 66637
nrows = 2880
data <- read.csv("household_power_consumption.txt",header=T,sep=";",
                stringsAsFactors=F,na.strings=c("?"),skip=skip,nrows=nrows)

# Header was skipped. So, fix the names.
names(data) = c("Date","Time","Global_active_power",
                "Global_reactive_power","Voltage","Global_intensity",
                "Sub_metering_1","Sub_metering_2","Sub_metering_3")

# Reformat date and time data
data$Time <- strptime(paste(data$Date,data$Time),"%d/%m/%Y %H:%M:%S")
data$Date = as.Date(data$Date,"%d/%m/%Y")


# open device
png("./plot4.png",width=480,height=480)
par(mfrow=c(2,2))
# plot upper left corner 
plot(data$Time,data$Global_active_power,ylab="Global Active Power",xlab="", type="n")
lines(data$Time,data$Global_active_power)
# plot upper right corner
plot(data$Time,data$Voltage,ylab="Voltage",xlab="datetime",type="n")
lines(data$Time,data$Voltage)
# plot lower left corner
plot(data$Time,data$Sub_metering_1,ylab="Energy sub metering",xlab="", type="n")
lines(data$Time,data$Sub_metering_1)
lines(data$Time,data$Sub_metering_2,col="red")
lines(data$Time,data$Sub_metering_3,col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
      col=c("black","red","blue"),lty=1,bty="n")
# plot lower right corner
plot(data$Time,data$Global_reactive_power,ylab="Global_reactive_power",xlab="datetime", type="n")
lines(data$Time,data$Global_reactive_power)
dev.off()
