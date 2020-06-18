#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

shinyUI(fluidPage(
    titlePanel("Predict Circumference from Age"),
    sidebarLayout(
        sidebarPanel(
            sliderInput("sliderAge", "What is the age of the tree?", 100, 1600, value = 500),
            checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
            checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE)
        ),
        mainPanel(
            plotOutput("plot1"),
            h3("Predicted Circumference from Model 1:"),
            textOutput("pred1"),
            h3("Predicted Circumference from Model 2:"),
            textOutput("pred2")
        )
    )
))
