## run_analysis.R

### IMPORTANT!!!!!!!
### Before you start!!!!!!!
### Set the rootdir to an directory on your computer

## Input:https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## Output: Dataframes runanalysis and groupbymean

## This program: 
## gets a zipfile
## Unzip the file
## Reads unzipped files
## Makes 2 dataframes of these files

## Dataframe 1:
##     runanalysis
##  This dataframe contains mean and standard daviation information 
##  of various functions on a set of test en train data of a movement app on an Galaxy II smartphone

## Dataframe 2:
##     groupbymean
##  This dataframe contains a summary of all values per subject per activity.




## Get the dataset



## Set Rootdirectory
##------------------

rootdir<-"C:\\Users\\Marc\\Documents\\R_Working_dir\\Getting_cleaning_data\\Assignment\\"
setwd(rootdir)

## Get de ZIP file and unzip it
##-----------------------------

fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile ="uci_har_dataset.zip", mode = "wb")
unzip("uci_har_dataset.zip")

## Get the headers and activity values
##-------------------------------------

Datadir<-paste(rootdir,"\\UCI HAR Dataset",sep = "")
setwd(Datadir)
## Read headers
headers<-read.delim("features.txt",header = FALSE, sep="")
## Read the tested activities
activitylabels<-read.delim("activity_labels.txt",header = FALSE, sep="")


## Get the train data sets
##------------------------

setwd(paste(Datadir,"\\train",sep = ""))
## Read Observations
Xtrain<-read.delim("X_train.txt",header = FALSE, sep="")
## activities
Ytrain<-read.delim("y_train.txt",header = FALSE, sep="")
## Read subjects
subjtrain<-read.delim("subject_train.txt",header = FALSE, sep="")

## Get the test dataset
##---------------------

setwd(paste(Datadir,"\\test",sep = ""))
## Read Observations
Xtest<-read.delim("X_test.txt",header = FALSE, sep="")
## activities
Ytest<-read.delim("y_test.txt",header = FALSE, sep="")
## Read subjects
subjtest<-read.delim("subject_test.txt",header = FALSE, sep="")

## Merge the test data
##--------------------

## Add headers to the test data
names(Xtest)<-headers[,2]

## merge the activity labels to the test data
Ytest<-merge(Ytest,activitylabels,by.x="V1",by.y="V1")
names(Ytest)[2]<-"activity"
Xtest<-cbind(Xtest,Ytest["activity"])

## merge the subjects
names(subjtest)[1]<-"subject"
Xtest<-cbind(Xtest,subjtest)

## Merge the train data
##--------------------

## Add headers to the test data
names(Xtrain)<-headers[,2]

## merge the activity labels to the test data
Ytrain<-merge(Ytrain,activitylabels,by.x="V1",by.y="V1")
names(Ytrain)[2]<-"activity"
Xtrain<-cbind(Xtrain,Ytrain["activity"])

## merge the subjects
names(subjtrain)[1]<-"subject"
Xtrain<-cbind(Xtrain,subjtrain)

## merge training and test data
Xtotal<-rbind(Xtrain,Xtest)

## make a subset of only the means, Standard deviations and activity and subject
runanalysis<-Xtrain[,grep("[Mm]ean|[Ss]td|^activity$|^subject$",colnames(Xtrain), value = TRUE)]

## Change the column headers
colnames(runanalysis)<-gsub("-","",colnames(runanalysis))
colnames(runanalysis)<-gsub("\\(","",colnames(runanalysis))
colnames(runanalysis)<-gsub("\\)","",colnames(runanalysis))
colnames(runanalysis)<-tolower(gsub("\\,","",colnames(runanalysis)))

## create a dataset with the means per activity and subject

library(dplyr)

groupbymean <-    runanalysis %>% 
            group_by(activity,subject) %>% 
            summarise_each(funs(mean))
