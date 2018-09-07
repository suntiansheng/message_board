library(shiny)

ui <- fluidPage(
  title = 'message board',
  sidebarLayout(
    wellPanel(
      textInput(inputId = 'message', label = 'Message', value = 'send a message here!'),
      dateInput('date', 'Date'),
      actionButton('send', 'Send the message')
      #submitButton('send', 'Send the message')
    ),
    
    mainPanel(
      DT::dataTableOutput('messagetable')
    )
  )
)

server <- function(input, output){
  nmes <- eventReactive(
    input$send,{
    message <- input$message
    date <- input$date
    d <- data.frame(message = message, date = date)
    readr::write_csv(d,'showtable.csv', append = T)
    showtable <- read.csv('showtable.csv')
    showtable
    }
  )
  output$messagetable <- DT::renderDataTable(nmes())
}

shinyApp(ui, server)
