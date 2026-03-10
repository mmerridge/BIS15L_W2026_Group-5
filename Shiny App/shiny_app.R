
library(tidyverse)
library(janitor)
library(naniar)
library(ggmap)
library(lubridate)
library(shiny)
library(dplyr)
library(shinydashboard)
library(ggplot2)

microplastics <- read.csv("microplastics.csv")

ui <- dashboardPage(
  
  skin = "purple",
  
  dashboardHeader(title = "Fish Microplastics"),
  
  dashboardSidebar(
    
    selectInput("z",
                "Select a variable of interest",
                choices = c("color", "particle_type", "sample_type", "species"),
                selected = "color"),
    
    selectInput("x",
                "Select a variable of interest",
                choices = c("station", "species"),
                selected = "station")
  ),
  
  dashboardBody(
    
    plotOutput("plot", width = "1000px", height = "800px")
    
  )
)

server <- function(input, output, session) {
  
  output$plot <- renderPlot({
    
    microplastics %>%
      ggplot(aes(x = .data[[input$x]], fill = .data[[input$z]])) +
      geom_bar(position = "dodge") +
      theme_classic() +
      labs(x = input$x, fill = input$z)
    
  })
}

shinyApp(ui, server)

