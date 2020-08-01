install.packages("tidyverse")
library(tidyverse)
gp_hiv <- read_csv("indicator hiv estimated prevalence% 15-49.csv", col_names = TRUE, cols(.default = col_double(),
                                                                                           `Estimated HIV Prevalence% - (Ages 15-49)` = col_character(),
                                                                                           `1988` = col_logical(),
                                                                                           `1989` = col_logical()))
gp_hiv <- gp_hiv %>%
  rename(Country = "Estimated HIV Prevalence% - (Ages 15-49)")
head(gp_hiv)
gp_hiv <- gp_hiv %>%
  gather(key = year, value = prevalence, -Country)
gp_hiv
gp_hiv <- gp_hiv %>%
  mutate(year = as.numeric(year))
gp_hiv
sum(is.na(gp_hiv$Country))
sum(is.na(gp_hiv$year))
sum(is.na(gp_hiv$prevalence))
gp_hiv %>% filter(is.na(prevalence)) %>% summary()  
gp_hiv <- gp_hiv %>% filter(!is.na(prevalence)) 
sum(is.na(gp_hiv$prevalence)) 
gp_hiv <- gp_hiv %>% filter(year > 1990)
head(gp_hiv)
hiv_prevalence <- gp_hiv %>%
  group_by(Country) %>%
  summarise(MeanPrevalence = mean(prevalence))
write.csv(hiv_prevalence,file = "hiv_prevalence.csv") 
