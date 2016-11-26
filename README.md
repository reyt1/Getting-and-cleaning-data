Programming Assignments of Coursera.com online course: Getting and Cleaning Data
Reynaldo.

Assignment Submission Files

1.-  run_analysis.R

2.-  README.md

3.-  CodeBook.md


Download the dataset call: smartphone.zip in a new folder from this: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Unzip the data set into "the folder". If everythink is ok you will see a folder named UCI HAR.

Load R and set your working directory using setwd and check for the working directory using getwd.

Load the R script using call: run_analysis.R

Run the R script and after and send run_analysis.R, several step will running in R:
    1.- Load the activity and feature info.
    2.- Loads both the training and test datasets, keeping only those columns which reflect a mean or standard deviation
    3.- Loads the activity and subject data for each dataset, and merges those columns with the dataset
    4.- Merges the two datasets
    5.- Converts the activity and subject columns into factors
    6.- Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair

The end result is shown in the file MeanData.txt.
