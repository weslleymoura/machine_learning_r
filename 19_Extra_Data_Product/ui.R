#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#


library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  headerPanel("Clustering app"),
  
  fileInput('myFile', 'Choose CSV File',
            accept=c('text/csv',
                     'text/comma-separated-values,text/plain',
                     '.csv')
  ),
  
  # Sidebar with a slider input for number of bins
  sidebarPanel(
    sliderInput("k",
                "Number of clusters:",
                min = 1,
                max = 10,
                value = 3)
  ),
  
  # Show a plot of the generated distribution
  mainPanel(
    tabsetPanel(
      tabPanel("Dataset", tableOutput("contents")),
      tabPanel("Cluster Plot", plotOutput("myPlot")),
      tabPanel("Silhueta", tableOutput("mySilhouette"))
    )
  )
)
)

