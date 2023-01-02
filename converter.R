library(googledrive)

# authenticate yourself
drive_auth()

gdoc_to_rmd <- function(drive_id, output, verbose = TRUE, overwrite = FALSE) {
  
  # get the doc
  doc <- drive_get(as_id(drive_id))
  
  # specify tempdir location for writing 
  fp <- glue::glue("{getwd()}/{doc[[1]]}.docx")
  
  # create var with non-conflicting name
  out <- output
  
  # download to tempdir
  drive_download(doc, fp, overwrite = overwrite)
  
  # convert to markdown
  rmarkdown::pandoc_convert(
    fp,
    "markdown", 
    output = out
  )
  
  # cat to console if verbose
  if (verbose) {
    cat(readLines(out), sep = "\n")
  }
  
  # return lines as character string if so desired
  invisible(readLines(out))
}

drive_id <- "https://docs.google.com/document/d/11I0_ZVjS2o8AS5K-JttyHG-2_Z8g-xnH2sjIWR5i3V0"

example_doc <- gdoc_to_rmd(drive_id, 
                           verbose = TRUE,
                           overwrite = TRUE,
                           output = "metaanalizis.Rmd")

