getwd()
#"C:/Users/Reynaldo/Documents"

###########################
# 1. Merge the training and the test sets to create one data set.
###########################

## step 1: download zip file from website to new folder call: data
if(!file.exists("./data")) dir.create("./data")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/smartphone.zip")

## step 2: unzip data into data folder
Zipdata <- unzip("./data/smartphone.zip", exdir = "./data")

## step 3: load data into R and ger dimension of every new read
trainX <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
trainY <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
trainSubject <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
testX <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
testY <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
testSubject <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
dim(trainX) # 7352x561
dim(trainY) # 7352x1
dim(testX) # 2947x561
dim(testY) # 2947x1
dim(trainSubject) #7352x1
dim(testSubject) #2947x1


## step 4: merge train and test data
trainData <- cbind(trainSubject, trainY, trainX)
testData <- cbind(testSubject, testY, testX)
CompData <- rbind(trainData, testData)
dim(trainData) #get dimension 7352x563
dim(testData) #get dimension 2947x563
dim(CompData) #get dimension 10299x563
head(CompData,3) # view data

############################
# 2. Extract only the measurements on the mean and standard deviation for each measurement. 
############################

## step 1: load feature name into R
features <- read.table("./data/UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)[,2]

## step 2:  extract mean and standard deviation of each measurements
featureIndex <- grep(("mean\\(\\)|std\\(\\)"), features)
finalData <- CompData[, c(1, 2, featureIndex+2)]
colnames(finalData) <- c("subject", "activity", features[featureIndex])

############################
# 3. Uses descriptive activity names to name the activities in the data set
############################

## step 1: load activity  data (call: activityName) into R
activityName <- read.table("./data/UCI HAR Dataset/activity_labels.txt")

## step 2: replace 1 through 6 with activity names coming from activityName
finalData$activity <- factor(finalData$activity, levels = activityName[,1], labels = activityName[,2])

###############################
# 4. Appropriately labels the data set with descriptive variable names.
###############################

names(finalData) <- gsub("\\()", "", names(finalData))
names(finalData) <- gsub("^t", "time", names(finalData))
names(finalData) <- gsub("^f", "frequence", names(finalData))
names(finalData) <- gsub("-mean", "Mean", names(finalData))
names(finalData) <- gsub("-std", "Std", names(finalData))

###############################
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
###############################
library(dplyr)
groupData <- finalData %>%
        group_by(subject, activity) %>%
        summarise_each(funs(mean))

write.table(groupData, "./data/MeanData.txt", row.names = FALSE) # write out the 2nd dataset
