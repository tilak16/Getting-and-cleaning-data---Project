This file describes the transformations done to the data.

**Step 1:** 

We read in the data from both the test and train data sets. Both the acceleration, gyro data(X_test,X_train) and the activity data (y_test, y_train) are read in. In addition we read in the subject labels that identify the subject contributing to the data. The data labels stored in the features file is also read in. Please note that the inertial data is not of interest as they dont have the mean and std data.
**Step 2:**

The data labels that either have mean() or std() are the only ones of interest. Therefore, we use the grep function to identify either the mean() or std() variables. Once they are identified, we also find the column indices in the raw acceleration and gyro data.
**Step 3:**

We create a new table that has the mean() and std() data subset from the raw data.
**Step 4:**

We add the activity labels to this data after we convert them from numeric to more descriptive strings. We also add the subject labels, which are numeric. We explicitly make these variables as factors in the new table.
**Step 5:**

We calculate the average of the mean() and std() data for each activity and for each subject and store the results in a new table. Then we output a csv file with the tiday data.

