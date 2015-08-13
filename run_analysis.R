##Download Files
if(!file.exists("./data")){dir.create("./data")}
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile="./data/smartphones.zip")
unzip(zipfile="./data/smartphones.zip",exdir="./data")

##Reading data from zip file
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
SubjectTest <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
SubjectTrain <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
Labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")[,2]
Features <- read.table("./data/UCI HAR Dataset/features.txt")[,2]


##Labeling data and calculating mean and standard deviation
data_mean_std <- grepl("mean|std", Features)
names(x_test) = Features
x_test = x_test[,data_mean_std]
y_test[,2] = Labels[y_test[,1]]
names(y_test) = c("Activity_ID", "Activity_Label")
names(SubjectTrain) = "Subject"
TestData <- cbind(as.data.table(SubjectTest), y_test, x_test)
names(x_train) = Features
x_train = x_train[,data_mean_std]
y_train[,2] = Labels[y_train[,1]]
names(y_train) = c("Activity_ID", "Activity_Label")
names(SubjectTrain) = "Subject"
TrainData <- cbind(as.data.table(SubjectTrain),y_train,x_train)
DataSet <- rbind(TestData, TrainData)
write.table(DataSet, file="./data/final_data.txt", row.names = FALSE)
