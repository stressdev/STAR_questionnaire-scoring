library(readr) #This is an R package that helps read in data from CSV files.

#This loads a the `score_questionnaire` function from this R file that you should have downloaded into the same folder as this example.
#A function is something like `mean`. In the background, a function is just a bunch of lines of code (commands) that run all together to accomplish a goal. 

#The `source` function runs the code in the file 'score_questionnaire.R'.
source('score_questionnaire.R')

#We use the function read_csv to load the data from the csv file you downloaded into a new variable called `my_data`. 
#The `na` argument in the read_csv function call tells it that the missing values in the csv file are represented 
#with either a blank entry ('') or the character string '999'. We use `c` to "combine", "collect", or "concatenate" several possible options together.
my_data <- read_csv('STARCHILD_DATA_2022-09-23_1924.csv', na = c('', '999'))

#Background: 
#An item is a prompt on a questionnaire that a participant responds to, e.g., "On a scale from 1-5 how sleepy are you today?"
#A column is a collection of responses from many people on many occasions to a particular item on a questionnaire.
#For example, the column named `ctq_1` is a collection of responses to the first item on the CTQ questionnaire. 
#We try to make the column names in our data files clear as to what items on which questionnaires they correspond to, 
#but always ask questions if you're unsure!

#This is the (beyond) meat of the work you're doing: your job is to use the paper for the assigned questionnaire to
#  - create a unique name for the questionnaire that we use later,
#      `name = 'ctq_physneg'`
#  - figure out what columns in the csv file correspond to the items that are used to compute the final sum score, 
#      `cols = c('ctq_1', 'ctq_2', 'ctq_4', 'ctq_6', 'ctq_26')`
#  - which of those columns, if any, should be reverse-coded,
#      `rev_score_cols = c('ctq_2', 'ctq_26')`
#  - what the minumum possible score for an item is,
#      `min = 1`
#  - and what the maximum possible score for an item is.
#      `max = 5`
#
#We put these all together in a list of options using the `list` function, and save it to a new variable called `scoring_params_list_ctq`.
#In this case, I've added a helpful suffix `_ctq` so that we know what questionnaire these parameters are for.
scoring_params_list_ctq <- list(name = 'ctq_physneg',
                            cols = c('ctq_1', 'ctq_2', 'ctq_4', 'ctq_6', 'ctq_26'),
                            rev_score_cols = c('ctq_2', 'ctq_26'), #if there are no reverse scored items, this should be `rev_score_cols = NULL`
                            min = 1,
                            max = 5)

#This next part is where we actually use the above parameters to score the questionnaire using the `score_questionnaire` function.
#Where does this function, score_questionnaire come from? This was created when we ran line 7.
#We save the scores generated by `score_questionnaire` are saved in the variable `ctq_physneg`
ctq_physneg <- score_questionnaire(x = my_data,
                                   cols = scoring_params_list_ctq$cols,
                                   rev_score_cols = scoring_params_list_ctq$rev_score_cols,
                                   min = scoring_params_list_ctq$min,
                                   max = scoring_params_list_ctq$max)

print(ctq_physneg)
hist(ctq_physneg)

