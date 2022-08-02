library(shiny)
library(tidyverse)

#####Import Data

dat <- read_csv(url("https://www.dropbox.com/s/uhfstf6g36ghxwp/cces_sample_coursera.csv?raw=1"))
dat <- dat %>% select(c("pid7","ideo5"))
dat <- drop_na(dat)



ui<- fluidPage(
  sidebarLayout(
    sidebarPanel(
      sliderInput(inputId = "slider", label = "Select Five Point Ideology (1 = Very Liberal, 5 = Very Conservative",
                  value = 1, min = 1, max = 5)
    ),
    plotOutput("plot")
  )
)
  
  
server <- function(input,output){
    output$plot <- renderPlot({
      plot_dat <- dplyr::filter(dat, ideo5 %in% input$slider)
      
      ggplot2::ggplot(dat = plot_dat, mapping = aes(x = pid7, y = ideo5)) +
        ggplot2::geom_col() +
        ggplot2::labs(x = "7 Point Party ID, 1=Very D, 7=Very R", y = "Count")
    })
}

shinyApp(ui,server)
