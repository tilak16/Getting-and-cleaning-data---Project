##Project
library(data.table)
library(plyr)
rm(list=ls())
##READING IN ALL THE DATA

setwd("C:/Data/Vinayak data/CTS/Online courses/Getting and Cleaning data/Project/UCI HAR Dataset/test")
testdata<-read.table("X_test.txt")
testlabels<-read.table("y_test.txt")
subjecttest<-read.table("subject_test.txt")
setwd("C:/Data/Vinayak data/CTS/Online courses/Getting and Cleaning data/Project/UCI HAR Dataset/train")
traindata<-read.table("X_train.txt")
trainlabels<-read.table("y_train.txt")
subjecttrain<-read.table("subject_train.txt")
##FINISHED READING IN DATA

##COMBINING DATA INTO ONE VARIABLE

setwd("C:/Data/Vinayak data/CTS/Online courses/Getting and Cleaning data/Project/UCI HAR Dataset")
testtraindata<-rbind(traindata,testdata)
testtrainlabels<-rbind(trainlabels,testlabels)
subjecttesttrain<-rbind(subjecttrain,subjecttest)
##FINISHED COMBINING

##READING IN FEATURES

features<-read.table("features.txt",stringsAsFactors=FALSE)
names(testtraindata)<-features[,2]
##Added descriptive labels to the variable names
##FINISHED READING IN FEATURES

##EXTRACTING ONLY THOSE MEASUREMENTS THAT ARE EITHER MEAN OR STD DEV OF MEASUREMENTS

meanvariables<-grep('(\\bmean()\\b|\\bstd()\\b)',colnames(testtraindata), value=TRUE)
meanindex<-vector(mode = "numeric", length = length(meanvariables))
for(i in 1:length(meanvariables)){
  meanindex[i]=which(colnames(testtraindata)==meanvariables[i])
}
meandata<-testtraindata[,meanindex]
##FINISHED EXTRACTING MEAN AND STD DEV OF MEASUREMENTS...RESULTS IN MEANDATA

##RENAMING ACTIVITY LABELS USING DESCRIPTORS

testtrainlabels[testtrainlabels==1]<-"WALKING"
testtrainlabels[testtrainlabels==2]<-"WALKING_UPSTAIRS"
testtrainlabels[testtrainlabels==3]<-"WALKING_DOWNSTAIRS"
testtrainlabels[testtrainlabels==4]<-"SITTING"
testtrainlabels[testtrainlabels==5]<-"STANDING"
testtrainlabels[testtrainlabels==6]<-"LAYING"
##FINISHED RENAMING ACTIVITY LABELS

##INTEGRATING ACTIVITY LABELS AND SUBJECT LABELS AS FACTORS IN MEANDATA

meandata["activity_labels"]<-testtrainlabels
meandata["subject_labels"]<-subjecttesttrain
meandata$activity_labels<-as.factor(meandata$activity_labels)
meandata$subject_labels<-as.factor(meandata$subject_labels)
##FINISHED ADDING ACTIVITY LABELS AND SUBJECT LABELS AS FACTORS

##NEW DATA SET WITH AVERAGE OF EACH ACTIVITY FOR EACH SUBJECT

newdata<-ddply(meandata,c("activity_labels", "subject_labels"),colwise(mean))
write.csv(newdata,"tidydata.txt", row.names = FALSE)
