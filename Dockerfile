# Start with R version you are using - get this with `R.version` in R console 
# or `R --version` in the terminal
FROM rocker/r-ver:4.2.1

# Install some linux libraries that R packages need
RUN apt-get update && apt-get install -y libcurl4-openssl-dev libssl-dev libxml2-dev

# Use renv version 
ENV RENV_VERSION 0.16.0

# Install renv
RUN Rscript -e "install.packages('remotes', repos = c(CRAN = 'https://cloud.r-project.org'))"
RUN Rscript -e "remotes::install_github('rstudio/renv@${RENV_VERSION}')"

# Create a directory named after our project directory
#WORKDIR /docker-demo-dir

# Copy the lockfile over to the Docker image
COPY renv.lock renv.lock

# Install all R packages specified in renv.lock
RUN Rscript -e 'renv::restore()'

# Default to bash terminal when running docker image
CMD ["bash"]
