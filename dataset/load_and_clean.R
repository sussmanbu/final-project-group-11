library(readr)
library(dplyr)
data <- read_csv("dataset/Mental_Health_Care_in_the_Last_4_Weeks.csv",show_col_types = FALSE)
data_clean <- data%>%
  select(-ncol(.), -(ncol(.)-1), -(ncol(.)-2))%>%
  na.omit(data)
saveRDS(data_clean, "dataset/cleaned_dataset.rds")
cleaned_data <- readRDS("dataset/cleaned_dataset.rds")