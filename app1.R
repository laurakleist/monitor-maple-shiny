library(shiny)
library(dplyr)
library(ggplot2)
library(readr)
library(lubridate)

source("CircumferencePlot.R")
#maples <- read_csv('Maple Monitoring Clean Data 2014.csv')

ui <- fluidPage(
  titlePanel("Tree Circumference"),
  sidebarLayout(
    sidebarPanel(
      fluidRow(
        column(3,
               selectInput("species",
                           label = "Species",
                           choices = c("Norway Maple",
                                       "Red Maple",
                                       "Silver Maple",
                                       "Sugar Maple"),
                           selected = "Norway Maple")),
        column(3,
               sliderInput("date",
                           label = "Date",
                           min = as.Date("9/3/2014", "%m/%d/%Y"),
                           max = as.Date("11/21/2014", "%m/%d/%Y"),
                           value = as.Date("9/3/2014"),
                           timeFormat = "%m/%d/%Y"))
      ),
      fluidRow(
        column(3,
               selectInput("habitat",
                           label = "Habitat Type",
                           choices = c("Developed Area",
                                       "Home Lawn",
                                       "Natural Setting",
                                       "School Garden",
                                       "School Lawn",
                                       "School Paved Area"),
                           selected = "Developed Area")),
        column(3,
               h5("Urban Area"),
               helpText("Is the tree within 100 feet of a building, concrete, or asphalt?"),
               radioButtons("urbanization",
                            label = NULL,
                            choices = c("Yes", "No"),
                            selected = "No"))
      ),
      fluidRow(
        column(3,
               selectInput("shading",
                           label = "Shading",
                           choices = c("Shaded",
                                       "Partially Shaded",
                                       "Open"),
                           selected = "Shaded"))
      )
    ),
    mainPanel(plotOutput("maplehist"))
  )
)

server <- function(input, output) {
  output$maplehist <- renderPlot({
    switch(input$species,
           "Norway Maple" = filter(maples, Species == "Norway Maple"),
           "Red Maple" = filter(maples, Species == "Red Maple"),
           "Silver Maple" = filter(maples, Species == "Silver Maple"),
           "Sugar Maple" = filter(maples, Species == "Sugar Maple"))
    switch(input$habitat,
           "Developed Area" = filter(maples, Habitat == "City or Community Park (developed)"),
           "Home Lawn" = filter(maples, Habitat == "Home lawn"),
           "Natural Setting" = filter(maples, Habitat == "Natural Setting (non-developed park, refuge, nature center, open space, forest)"),
           "School Garden" = filter(maples, Habitat == "School garden"),
           "School Lawn" = filter(maples, Habitat == "School lawn"),
           "School Paved Area" = filter(maples, Habitat == "School paved area"))
    switch(input$urbanization,
           "Yes" = filter(maples, Urbanization == "Yes"),
           "No" = filter(maples, Urbanization == "No"))
    switch(input$shading,
           "Shaded" = filter(maples, Shading == "Shaded (less than 2hr per day of direct sun)"),
           "Partially Shaded" = filter(maples, Shading == "Partially Shaded (2-5hr per day of direct sun)"),
           "Open" = filter(maples, Shading == "Open (more than 5hr per day of direct sun)"))
    circhist
  })
}

shinyApp(ui = ui, server = server)