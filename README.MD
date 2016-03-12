## run_analysis.R (Coursera assignment for Getting and Cleaning Data)

### IMPORTANT!!!!!!!
Before you start!!!!!!!
Set the rootdir to an directory on your computer

If you want the files in your current directory you can comment (##) these two lines (or delete them):

SET:
rootdir<-"C:\\Users\\Marc\\Documents\\R_Working_dir\\Getting_cleaning_data\\Assignment\\"
setwd(rootdir)
TO:
## rootdir<-"C:\\Users\\Marc\\Documents\\R_Working_dir\\Getting_cleaning_data\\Assignment\\"
## setwd(rootdir)

Input:https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Output: Dataframes runanalysis and groupbymean

This program: 
gets a zipfile
Unzips the file
Reads unzipped files
Makes 2 dataframes of these files

Dataframe 1:
     runanalysis
  This dataframe contains mean and standard daviation information 
  of various functions on a set of test en train data of a movement app on an Galaxy II smartphone

Dataframe 2:
     groupbymean
  This dataframe contains a summary of all values per subject per activity.


This directory contains 2 files:
1) run_analysis.R
	The program which does the above mentioned actions
2) run_analysis_codebook.txt
	An explanition of all the columns of the columns of the 2 dataframes.
3) README_from_the_original_files
	The readme of the original files.
