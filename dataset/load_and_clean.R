library(readr)
library(dplyr)
data <- read_csv("dataset/Mental_Health_Care_in_the_Last_4_Weeks.csv",show_col_types = FALSE)
data_clean <- data%>%
  select(-ncol(.), -(ncol(.)-1), -(ncol(.)-2))%>%
  na.omit(data)
saveRDS(data_clean, "dataset/cleaned_dataset.rds")
cleaned_data <- readRDS("dataset/cleaned_dataset.rds")


data_um <- read.csv('dataset/employment_state.csv', skip = 5, header = TRUE)
colnames(data_um)[1] <- "state"
data_um<- data_um%>%
  filter(state != "State" & state != "United States")%>%
  slice(1:(n() - 2))%>%
  mutate(
    X2022 = as.numeric(as.character(X2022)),
    X2021 = as.numeric(as.character(X2021)),
    X2020 = as.numeric(as.character(X2020))
  )
year_columns <- c("X2020", "X2021", "X2022")
# Keep the relevant columns only
data_um <- data_um %>%
  select(state, all_of(year_columns))
data_um <- data_um %>%
  mutate(Average = rowMeans(select(., c(X2022, X2021, X2020)), na.rm = TRUE))
saveRDS(data_um, "dataset/clean_unemployment.rds")