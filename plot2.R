#install.packages("dplyr")
library(dplyr)

#install.packages("tidyr")
library(tidyr)

#install.packages("lubridate")
library(lubridate)

# Load Data

Filepath <- "D://R//household_power_consumption.txt"

#Calculate nrows and skip values to load only the required data
#Data <- read.table(Filepath, sep = ";",stringsAsFactors =FALSE, nrows = 100000,
#                   header = TRUE)

#Data[,"Date"] <- as.Date(data[,"Date"],format = "%d/%m/%Y")
#nrows = length(which(Data[,"Date"] >= "2007-02-01" & Data[,"Date"] <= "2007-02-02"))
#skip = min(length(which(Data[,"Date"] >= "2007-02-01" & Data[,"Date"] <= "2007-02-02")))

#Load data from 2007-02-01 to 2007-02-02
Data <- read.table(Filepath, sep = ";",stringsAsFactors =FALSE, 
                   nrows = 2880, skip = 66637)

#Adding the column names
colnames(Data) <- read.table(Filepath, sep = ";",stringsAsFactors =FALSE, 
                             nrows = 1)

#Unify Date and Time columns 
Data <- unite(Data,"Date_Time",Date,Time,sep=" ")

#Set date language to English
Sys.setlocale("LC_TIME", "English")

#Conversion to Date/Time class
Data$Date_Time <- strptime(Data[,"Date_Time"], format = "%d/%m/%Y %T")

#Plot generation
with (Data, 
      {plot(Date_Time, Global_active_power,type="n", xlab ="",
            ylab = "Global Active Power (kilowatts)")
      lines(Date_Time, Global_active_power,type="l")
})
#Saving plot
dev.copy(png, file = "plot2.png",  width = 480, height = 480) 
dev.off()