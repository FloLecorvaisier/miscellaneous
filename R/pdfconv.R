pdfconv = function(file, o.dir, keep.tex = F, keep.fig = F) {
  wd = getwd()
  if (file.exists(paste0(file, ".Rnw"))) {
    input = paste0(wd, "/", file, ".Rnw")
    output = paste0(wd, "/", o.dir, "/", gsub(".*/", "\\1", file), ".tex")
    system(paste0("cd ", wd))
    writeLines(c(paste0("setwd('", wd, "/", o.dir, "')"),
                 paste0("knitr::knit2pdf(input = '", input, "',"),
                 paste0("                output = '", output, "',"),
                 "                compiler = 'pdflatex')"), "temp_pdf.R")
    system("Rscript temp_pdf.R")
    file.remove("temp_pdf.R")
    if (keep.tex == F) { # Removes the .tex file
      file.remove(paste0(wd, "/", o.dir, "/", gsub(".*/", "\\1", file), ".tex"))
    }
    if (keep.fig == F) { # Remoes the 'figure' folder
      unlink(paste0(wd, "/", o.dir, "/figure"), recursive = T)
    }
  }
  else print(paste0("Error: file '", file, ".Rnw' does not exist"))
}
