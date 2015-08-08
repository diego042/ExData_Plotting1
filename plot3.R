# Course Project week1 Exploratory data analysis

require(lubridate) #work with date filtering

## Estimating the Size of a Table
## memory required = no. of column * no. of rows * 8 bytes/numeric
2075259*9*8/(10^6) #roughly estimate of size in MB

##downloading and reading the data
site<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(site,"electric.zip")
read.zip <- function(zipfile, row.names=NULL, dec=".") {
        # Create a name for the dir where we'll unzip
        zipdir <- tempfile()
        # Create the dir using that name
        dir.create(zipdir)
        # Unzip the file into the dir
        unzip(zipfile, exdir=zipdir)
        # Get the files into the dir
        files <- list.files(zipdir)
        # Throw an error if there's more than one
        if(length(files)>1) stop("More than one data file inside zip")
        # Get the full name of the file
        file <- paste(zipdir, files[1], sep="/")
        # Read the file
        read.csv(file, sep =";",header=T)
}
dat<-read.zip("electric.zip")

x <- paste(dat$Date, dat$Time)
dat$tempo<-strptime(x, "%d/%m/%Y %H:%M:%S")
dat2<-subset(dat,subset = year(dat$tempo)==2007 & month(dat$tempo)==2 & day(dat$tempo)<3)

png(file="plot3.png",width=480,height=480)
plot(dat2$tempo,as.numeric(paste(dat2$Sub_metering_1)), type="l",
     ylab="Energy sub metering", xlab="")
lines(dat2$tempo,as.numeric(paste(dat2$Sub_metering_2)), type="l", col="red")
lines(dat2$tempo,as.numeric(paste(dat2$Sub_metering_3)), type="l", col="blue")
legend("topright", # places a legend at the appropriate place
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),#puts text in thelegend
       lty=c(1,1,1), # gives the legend appropriate symbols (lines)
       lwd=c(1,1,1), col=c("black","blue","red"))#gives the legend lines the correct color and width
dev.off()
