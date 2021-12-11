#ui.R
library(shiny)
library(dplyr)
library(shinycssloaders)
library(shinyjs)
library(ShinyRatingInput)

jsCode <-"shinyjs.reset_1 = function(params){$('.rating-symbol-foreground').css('width', params);}"

#static array for genre list
genre_list <- c("Select","Action", "Adventure", "Animation", "Childrens", 
                "Comedy", "Crime","Documentary", "Drama", "Fantasy",
                 "Horror", "Musical", "Mystery","Romance",
                 "Thriller", "War", "Western")



#shiny code to display web page
shinyUI(fluidPage(
  useShinyjs(),
  extendShinyjs(text = jsCode,functions = "reset_1"),
  tags$head(
    tags$style(
      HTML(".shiny-notification {
              height: 100px;
              width: 600px;
              background: blue;
              position:fixed;
              top: calc(50% - 50px);;
              left: calc(50% - 200px);;
            }
           "
      )
    )
  ),
  tabsetPanel( id = "tabs",
     tabPanel(h4("Application - Recommender - Genre Based"),
              wellPanel(style = "background-color: #0000FF; color: #FFFFFF",h3("Movie Recommendation Engine - Genre Based")),
              tags$style("body {background: url(http://www.wallpaperup.com/wallpaper/download/858715) no-repeat center center fixed;
                         background-size: cover; filter:grayscale(100%);}"),
              fluidRow(

                column(3, wellPanel(h4("Choose Movie Genres You May Like")),
                       #wellPanel(tableOutput("ui4"))
                      uiOutput("renderGenres")
                ),

                column(9,
                       wellPanel(h4("Popular Movies with Higher Average Rating for Chosen Genres!")),
                       wellPanel(tableOutput("table2") %>% withSpinner(color="yellow"))
                )
              )
     ),

    tabPanel(h4("Application - Recommender - Colloborative Filtering"),
              wellPanel(style = "background-color: #0000FF; color: #FFFFFF",h3("Movie Recommendation Engine - Colloborative Filtering")),
              tags$style("body {background: url(http://www.wallpaperup.com/wallpaper/download/858715) no-repeat center center fixed;
                         background-size: cover;   filter:grayscale(100%);}"),

             fluidRow(

                column(7, wellPanel(h4("Rate Movies You Like and then Click Fetch Recommendations or Click Reset")),
                       uiOutput("recommenderButton"),
                       uiOutput("renderMoviesForRatings")
                       ),
                
                column(5,
                       wellPanel(h4("You Might Like The Following Movies!")),
                       wellPanel(tableOutput("table")  %>% withSpinner(color="#0dc5c1") ))
              )
      )
    
  )
))
