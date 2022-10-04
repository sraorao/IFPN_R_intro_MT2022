###R for biologists
##Irina & Rao, 07/10/2022
library(tidyverse)
# library(dplyr) # if tidyverse not loaded
# library(ggplot2) # if tidyverse not loaded
# LOAD migmorph dataset ####
migmorph = read.csv("session_1/data/migmorph.csv", header = TRUE,
                      stringsAsFactors = FALSE)


# ggplot2 basics ####

# Base R plot
plot(x = migmorph$migration, y = migmorph$elongatedness, type = "p", col = "red")

# The same plot with ggplot2 (we are passing mapping argument to the ggplot function)
ggplot(data = migmorph, mapping = aes(x = migration, y = elongatedness)) +
  geom_point()

# the above code does the same as the following (we are passing mapping argument to the geom function)
ggplot(data = migmorph) +
  geom_line(mapping = aes(x = migration, y = elongatedness)) +
  geom_point(mapping = aes(x = migration, y = elongatedness), colour = "red")

# but geom_line() is not meaningful here
# let's set the colour of the dots to the cluster they are from
ggplot(data = migmorph) +
  geom_point(mapping = aes(x = migration, y = elongatedness, colour = cluster))

# How can this be improved? (hint: can we have a different colour for each cluster?)

# NOTE: the following will NOT work, it will give an error; how can you fix this?
migmorph %>%
  ggplot() +
  geom_point(mapping = aes(x = migration, y = elongatedness), colour = cluster)

# Q: What is the difference between the following two lines? Without running the code,
# can you tell which one will give you the expected result?
ggplot(iris) + geom_point(mapping = aes(x = Sepal.Length, y = Petal.Length, colour = "blue"))

ggplot(iris) + geom_point(mapping = aes(x = Sepal.Length, y = Petal.Length), colour = "blue")


# Building a plot step-by-step ####


plot(x = migmorph$migration, y = migmorph$elongatedness)

# 1 - make canvas
ggplot(date = migmorph)

# 2 - add mapping
ggplot(migmorph, aes(x = migration, y = elongatedness))

# 3 - add geom(s)
ggplot(migmorph, aes(x = migration, y = elongatedness)) +
  geom_point()

# 4 - add trendline
ggplot(migmorph, aes(x = migration, y = elongatedness)) +
  geom_point() +
  geom_smooth(method = "lm")

# 5 - change theme
ggplot(migmorph, aes(x = migration, y = elongatedness)) +
  geom_point() +
  geom_smooth(method = "lm") +
  theme_bw()

# 6 - add main title
ggplot(migmorph, aes(x = migration, y = elongatedness)) +
  geom_point() +
  geom_smooth(method = "lm") +
  theme_bw() +
  ggtitle("Migmorph dataset: Migration vs. morphology, coloured by cluster")

# 7 - change x and y labels
ggplot(migmorph, aes(x = migration, y = elongatedness)) +
  geom_point() +
  geom_smooth(method = "lm") +
  theme_bw() +
  ggtitle("Migmorph dataset: Migration vs. morphology, coloured by cluster") +
  labs(x = "Migration", y = "Morphology (elongatedness)")

# 8 - remove panel grid
ggplot(migmorph, aes(x = migration, y = elongatedness)) +
  geom_point() +
  geom_smooth(method = "lm") +
  theme_bw() +
  ggtitle("Migmorph dataset: Migration vs. morphology, coloured by cluster") +
  labs(x = "Migration", y = "Morphology (elongatedness)") +
  theme(panel.grid = element_blank())

# 9 - Colour points by cluster
ggplot(migmorph, aes(x = migration, y = elongatedness)) +
  geom_point(aes(colour = cluster)) +
  geom_smooth(method = "lm") +
  theme_bw() +
  ggtitle("Migmorph dataset: Migration vs. morphology, coloured by cluster") +
  labs(x = "Migration", y = "Morphology (elongatedness)") +
  theme(panel.grid = element_blank())

# 10 - store the plot in a variable
migration_vs_morphology = ggplot(migmorph, aes(x = migration, y = elongatedness)) +
  geom_point(aes(colour = cluster)) +
  geom_smooth(method = "lm") +
  theme_bw() +
  ggtitle("Migmorph dataset: Migration vs. morphology, coloured by cluster") +
  labs(x = "Migration", y = "Morphology (elongatedness)") +
  theme(panel.grid = element_blank())

print(migration_vs_morphology)
# 11 - save the plot to file (how can we fix the errors?)
ggsave()
ggsave("session2/results/migration_vs_morphology.pdf", 
       plot = migration_vs_morphology, width = 20, height = 5)
ggsave("session2/results/migration_vs_morphology.png", 
       plot = migration_vs_morphology)
ggsave("session2/results/migration_vs_morphology.svg", 
       plot = migration_vs_morphology)



