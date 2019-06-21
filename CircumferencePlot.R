# Clear environment
rm(list = ls())

# Open packages
library(dplyr)
library(ggplot2)
library(lubridate)

# Import the csv file
library(readr)
maples <- read_csv("Maple Monitoring Clean Data 2014.csv")

# Make circumference a numeric variable
maples$Circumference <- as.numeric(maples$Circumference)
# change species to a factor
maples$Species <- as.factor(maples$Species)
# change urbanization to a factor
maples$Urbanization <- as.factor(maples$Urbanization)
# change habitat to a factor
maples$Habitat <- as.factor(maples$Habitat)
# change shading to a factor
maples$Shading <- as.factor(maples$Shading)
# change date to a date
maples$Date <- as.Date(maples$Date, "%m/%d/%Y")

# Histogram of circumferences
circhist <- ggplot(maples, aes(Circumference)) + 
  geom_histogram(stat = "count") +
  xlab("Circumference (inches)") +
  ylab("Number of Trees") +
  theme_minimal()


