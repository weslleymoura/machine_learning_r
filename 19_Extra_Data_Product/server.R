

#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(cluster)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  myData <- reactive({
    inFile <- input$myFile
    if (is.null(inFile)) return(NULL)
    data <- read.csv(inFile$datapath, header = TRUE)
    data
  })
  
  myCluster <- reactive({
    if (is.null(myData())) return(NULL)
    # generate clusters based on input$k from ui.R
    kmeans(myData(), input$k, iter.max = 10, nstart = 1)
  })
  
  mySilhouette <- reactive({
    if (is.null(myData())) return(NULL)
    
    dissE <- daisy(myData())
    sk <- silhouette(myCluster()$cluster, dissE)
    
    df <- data.frame(sk[,c(1,2,3)])
    df
  })
  
  
  output$contents <- renderTable({
    myData()
  })
  
  output$myPlot <- renderPlot({
    if (is.null(myData())) return(NULL)
    clusplot(myData(), myCluster()$cluster, color=TRUE, shade=TRUE, labels=2, lines=0, main="Identificação dos grupos")
  })
  
  output$mySilhouette <- renderTable({
    mySilhouette()
  })
  
})
