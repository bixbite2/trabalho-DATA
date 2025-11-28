library(tidyverse)

# carregar dados
dados <- read_csv("../data/rpg_steam_clean.csv")

# criar faixas de anos
dados <- dados %>%
  mutate(
    faixa_ano = cut(
      release_year,
      breaks = c(1983, 2000, 2010, 2020, 2023),
      labels = c("1983–2000", "2001–2010", "2011–2020", "2021–2023"),
      include.lowest = TRUE
    )
  )

# tabela exploratória
dados %>% 
  group_by(faixa_ano) %>% 
  summarise(
    mean_players = mean(average_estimated_owners_number, na.rm=TRUE),
    median_players = median(average_estimated_owners_number, na.rm=TRUE),
    n = n()
  )

# boxplot
ggplot(dados, aes(faixa_ano, average_estimated_owners_number)) +
  geom_boxplot()

# salvar ambiente
save.image("../output/tables/DadosInferencia.RData")

