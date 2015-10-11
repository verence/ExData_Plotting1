
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


# call for plotting graph plot3
plot3 <- function(data_plot){
  # set filename
  filename_plot <- "plot3.png"
  
  # add column
  data_plot$datetime <- paste(data_plot$Date, data_plot$Time,sep = " ")
  data_plot$timestamp<- strptime(data_plot$datetime, "%d/%m/%Y %H:%M:%S")
  
  # open output file 
  png(filename=filename_plot)
  
  # plot
  # get the range for the x and y axis
  #xrange <- range(data_plot$datetime)
  yrange <- range(data_plot$Sub_metering_1) 
  
  plot(x = data_plot$Sub_metering_1, type="l", col="black", ylim=yrange,
       ylab = "Energy sub metering",
       xlab = "",
       xaxt='n'
       )
  
  lines(data_plot$Sub_metering_2,
        col="red") 

  lines(data_plot$Sub_metering_3,
        col="blue") 
  
   
  
  # Make x axis using "Thu","Fri","Sat" labels
  midnight = length(d$Date)/2
  axis(1, at=c(0,
               midnight,
               length(d$Date)),
       lab=c("Thu","Fri","Sat")
  )
  
  legend(1850, 
         yrange[2], names(data_plot)[7:9],
         col=c("black","red","blue"),
         lty=1
         )
  

  
  # close output
  dev.off()
  data_plot
}


# plot graphs
data_hpc <- load_data()
plot3(data_hpc)