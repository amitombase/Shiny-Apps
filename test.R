library(shiny)
ui <- fluidPage(
  checkboxGroupInput("variable", "Select IEC Classes for TI",c("A Plus" = "ap","A" = "a","B" = "b","C"="c"), 
                     selected = c("A Plus" = "ap")),
  plotOutput("plotmeanTI",width = "100%")
)

server <- function(input, output, session){
  
  
  output$plotmeanTI <- renderPlot({
    f1 <- function(nm1){
      switch(nm1,
             ap = lines(TI_plot[[1]],TI_plot$NTM_A_Plus_mean,col=6),
             a = lines(TI_plot[[1]],TI_plot$NTM_A_mean,col=2),
             b = lines(TI_plot[[1]],TI_plot$NTM_B_mean,col=3),
             c = lines(TI_plot[[1]],TI_plot$NTM_C_mean,col=4)
             
      )
      
    }
    
    if(is.null(input$variable)) {
      plot(TI_plot[[1]], TI_plot[[2]],t='o',ylim=c(0,1),xaxs="i",
           xlab="Mean Wind Speed", ylab="<TI>")
    }    else {
      plot(TI_plot[[1]], TI_plot[[2]],t='o',ylim=c(0,1),xaxs="i",
           xlab="Mean Wind Speed", ylab="<TI>")
      f1(input$variable)
      
    }
  })
  
}

shinyApp(ui=ui,server=server)