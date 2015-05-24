## read in all data & load dplyr library
     library("dplyr")
     features <- read.table("./dataset/features.txt")
     activity_labels <- read.table("./dataset/activity_labels.txt")
     subject_test <- read.table("./dataset/test/subject_test.txt")
     x_test <- read.table("./dataset/test/X_test.txt")
     y_test <- read.table("./dataset/test/y_test.txt")
     subject_train <- read.table("./dataset/train/subject_train.txt")
     x_train <- read.table("./dataset/train/X_train.txt")
     y_train <- read.table("./dataset/train/y_train.txt")
     
## STEP 4 !!!!! Update column names for each table, make feature names unique !!!!
     colnames(x_train) <- make.names(features[,2],unique = TRUE)
     colnames(x_test) <- make.names(features[,2], unique = TRUE)
     colnames(subject_test) <- "Subject"
     colnames(subject_train) <- "Subject"
     colnames(y_test) <- "Activity_Label"
     colnames(y_train) <- "Activity_Label"
     colnames(activity_labels) <- c("Activity_Label", "Activity")
     
## STEP 3 !!!!!!!! Uses descriptive activity names to name the activities in the data set !!!!!!!!
     
     y_test2 <- merge(y_test, activity_labels, by.x = "Activity_Label", by.y = "Activity_Label", all.x = TRUE)
     y_train2 <- merge(y_train, activity_labels, by.x = "Activity_Label", by.y = "Activity_Label", all.x = TRUE)

## Create a table for test data, and a second table for training data
     
     testdata <- cbind(subject_test, y_test2, x_test)
     traindata <- cbind(subject_train, y_train2, x_train)

## Add a new column to differentiate test vs train data and append all data to one table
     All_data <- rbind(testdata,traindata)

## STEP 2 !!!!!!!!!!!!!!Select only the mean & std columns to new table!!!!!!!!!!!!!
     
     all_data_clean <- select(All_data, 1,3,4, as.vector(grep("mean.|std", colnames(All_data), value = FALSE)))

## STEP 5 !!!!!!!! Summarize average of each variable for each activity and each subject.
     
     sorted_data <- group_by(all_data_clean, Subject, Activity) 
     summarized_data <- summarise_each(sorted_data, funs(mean))
