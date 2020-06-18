
library(shiny)

shinyServer(function(input, output) {
    Orange$agesp <- ifelse(Orange$age - 800 > 0, Orange$age *10, 0)
    model1 <- lm(circumference ~ age, data = Orange)
    model2 <- lm(circumference ~ agesp + age, data = Orange)
    
    model1pred <- reactive({
        ageInput <- input$sliderAge
        predict(model1, newdata = data.frame(age = ageInput))
    })
    
    model2pred <- reactive({
        ageInput <- input$sliderAge
        predict(model2, newdata = 
                    data.frame(age = ageInput,
                               agesp = ifelse(ageInput - 800 > 0,
                                              ageInput *10, 0)))
    })
    
    output$plot1 <- renderPlot({
        ageInput <- input$sliderAge
        
        plot(Orange$age, Orange$circumference, xlab = "Age (days since start of study)", 
             ylab = "Circumference (mm)", bty = "n", pch = 16,
             xlim = c(100, 1600), ylim = c(25, 230))
        if(input$showModel1){
            abline(model1, col = "red", lwd = 2)
        }
        if(input$showModel2){
            model2lines <- predict(model2, newdata = data.frame(
                age = 100:1600, agesp = ifelse(100:1600 - 800 > 0, 100:1600 *10, 0)
            ))
            lines(100:1600, model2lines, col = "blue", lwd = 2)
        }
        legend(25, 230, c("Model 1 Prediction", "Model 2 Prediction"), pch = 16, 
               col = c("red", "blue"), bty = "n", cex = 1.2)
        points(ageInput, model1pred(), col = "red", pch = 16, cex = 2)
        points(ageInput, model2pred(), col = "blue", pch = 16, cex = 2)
    })
    
    output$pred1 <- renderText({
        model1pred()
    })
    
    output$pred2 <- renderText({
        model2pred()
    })
})
