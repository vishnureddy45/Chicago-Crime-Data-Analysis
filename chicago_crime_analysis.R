
##############################################################################

##Chicago Crime Data Analysis using R Language

##############################################################################

library(data.table)
library(ggplot2)

chiCrimes_total <- fread("Chicago_Crimes_2001_to_2018.csv")

head(chiCrimes_total)

#########################Data Cleaning#########################################

chiCrimes_total$Primary.Type <- gsub("(.*)NARCOTIC(.*)","NARCOTICS",chiCrimes_total$`Primary Type`)

chiCrimes_total$Primary.Type <- gsub("(.*)NON(.*)CRIMINAL(.*)","NON-CRIMINAL",chiCrimes_total$`Primary Type`)

chiCrimes_total$Primary.Type <- gsub("(.*)OFFENSE(.*)INVOLV(.*)CHILDREN","OFFENSE_CHILDREN",chiCrimes_total$`Primary Type`)

chiCrimes_total$Primary.Type <- gsub("(.*)INTERFERE(.*)WITH(.*)","INTERFERE_OFFICER",chiCrimes_total$`Primary Type`)

####first of all lets convert data into the format in which R can understand #############

dates <- as.Date(chiCrimes_total$Date, "%m/%d/%y")

chiCrimes_total$Month = months(dates)

chiCrimes_total$Weekday = weekdays(dates)

chiCrimes_total$Date = dates

class(chiCrimes_total$Date)

####now lets plot a crime trend from year 2002-2018 by ploting histogram and visualize the crime trends

hist(chiCrimes_total$Date, breaks=100)

table(chiCrimes_total$Month)

table(chiCrimes_total$Month)[which.min(table(chiCrimes_total$Month))]

####which weekday fewer motor vehicle theft occurs 

table(chiCrimes_total$Weekday)

table(chiCrimes_total$Weekday)[which.min(table(chiCrimes_total$Weekday))]

####Months having most Vehicle Theft 

table(chiCrimes_total$Month)[which.max(table(chiCrimes_total$Month))]

####Weekday having most vehicle Theft

table(chiCrimes_total$Weekday)[which.max(table(chiCrimes_total$Weekday))]

####Visualizing story in barplots 

barplot(table(chiCrimes_total$Month))

barplot(table(chiCrimes_total$Weekday))


topcrimelocation=sort(table(chiCrimes_total$LocationDescription))

####now lets search for top 5 crime locations

topcrimelocation=sort(table(chiCrimes_total$`Location Description`))


#barplot(tail(topcrimelocation), col="orange")

##############

topcrimelocation <- data.frame(tail(topcrimelocation))

myplot<-ggplot(data = topcrimelocation, aes(Var1, Freq)) + geom_bar(stat="identity",fill = "#A01D26")+
  xlab("Top Crime Locations") +
  ylab("quantity") +
  
  geom_text(aes(label = Freq, y = Freq + 0.05),
            position = position_dodge(0.9),#col = 'white',
            vjust = -1)


myplot + theme(panel.background = element_rect(fill = "#FDFFFF", colour = 'Black'))

##############

Top5 = subset(chiCrimes_total, `Location Description`=="STREET" | `Location Description`=="PARKING LOT/GARAGE(NON.RESID.)" | `Location Description`=="RESIDENCE" | `Location Description`=="SIDEWALK" | `Location Description`=="APARTMENT")

Top5$`Location Description` = factor(Top5$`Location Description`)

table(Top5$`Location Description`)

####which location having maximum thefts

table(Top5$`Location Description`)[which.max(table(Top5$`Location Description`))]

####which day most theft happened in STREET 

table(Top5$`Location Description`,Top5$Weekday)

STREET_weekdays=table(Top5$`Location Description`,Top5$Weekday)[5,]

STREET_weekdays

STREET_weekdays[which.max(STREET_weekdays)]

####which day less theft happened in STREET################

STREET_weekdays[(which.min(STREET_weekdays))]


table(chiCrimes_total$Year)

plot(table(chiCrimes_total$Year))

mean(table(chiCrimes_total$Year))

sd=sd(chiCrimes_total$Year)

samplemean=370595.4

plot(table(chiCrimes_total$Year))

Confidence_Interval.min=370595.4-sd

Confidence_Interval.min

Confidence_Interval.max=370595.4+sd

Confidence_Interval.max


############ 10 Most Frequently committed crimes :CHICAGO 2001-2018##############

chiCrimes_total <- cbind(chiCrimes_total,quantity=seq(1,1,nrow(chiCrimes_total)))

aggdata2 <- aggregate(quantity~Year+Primary.Type,data=chiCrimes_total,FUN=sum)

aggdata3 <- aggregate(quantity~Primary.Type, data=aggdata2,FUN=mean)

aggdata3 <- aggdata3[order(aggdata3$quantity,decreasing=TRUE),]

top10 <- aggdata3[1:10,]
top10

# with(top10,barplot(top10$quantity,col=c("violet","purple","blue","green","yellow","orange","red","lightblue","mistyrose","lightcyan"),main="The top ten crime types from 2001-2018 in Chicago", xlab="Crime Type",ylab="Average yearly occurrence"))
# legend("topright",lty="solid",col=c("violet","purple","blue","green","yellow","orange","red","lightblue","mistyrose","lightcyan"),legend=top10$Primary.Type)

myplot<-ggplot(data = top10, aes(Primary.Type, quantity)) + geom_bar(stat="identity",fill = "#A01D26")+
  xlab("10 Most Frequently committed crimes :CHICAGO 2001-2018") +
  ylab("Quantity") +
  
  geom_text(aes(label = quantity, y = quantity + 0.05),
            position = position_dodge(0.9),vjust = -1)

myplot + theme(panel.background = element_rect(fill = "#FDFFFF", colour = 'Black'))


