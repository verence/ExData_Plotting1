
# read file household_power_consumption.txt
load_data <- function(){
  library(data.table)
  library(dplyr)
  filename <- "household_power_consumption.txt"
  data <- fread(input =  filename,header = TRUE, sep = ';',colClasses = c("character",
                                                                          "character", 
                                                                          "numeric",
                                                                          "numeric",
                                                                          "numeric",
                                                                          "numeric",
                                                                          "numeric",
                                                                          "numeric",
                                                                          "numeric"))
  data_extract <- data[data$Date %in% c("1/2/2007","2/2/2007"),]
  
  # set numeric type
  data_extract <- transform(data_extract, Global_active_power = as.numeric(Global_active_power))
  data_extract <- transform(data_extract, Global_reactive_power = as.numeric(Global_reactive_power))
  data_extract <- transform(data_extract, Voltage = as.numeric(Voltage))
  data_extract <- transform(data_extract, Global_intensity = as.numeric(Global_intensity))
  data_extract <- transform(data_extract, Sub_metering_1 = as.numeric(Sub_metering_1))
  data_extract <- transform(data_extract, Sub_metering_2 = as.numeric(Sub_metering_2))
  data_extract <- transform(data_extract, Sub_metering_3 = as.numeric(Sub_metering_3))
  
}

# call for plotting graph plot1
plot1 <- function(data_plot){
  # set filename
  filename_plot <- "plot1.png"

  # open output file 
  png(filename=filename_plot)
  
  # plot
  hist(x <- data_plot$Global_active_power,
       main = "Global Active Power",
       xlab = "Global Active Power (kilowatts)",
       ylab = "Frequency",
       col = "red"
       )
  
  # close output
  dev.off()
}



# plot graphs
data_hpc <- load_data()
plot1(data_hpc)
