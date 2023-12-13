#lang racket

(require racket/gui/easy
         racket/gui/easy/operator)

(struct tile (index ob) #:transparent)
(struct row (index tiles) #:transparent)

(define (tile->string tile-entry)
  (obs-peek (tile-ob tile-entry)))

(define (construct-obs-grid sizeX sizeY)
  (integer? integer? . -> . list?)

  (for/list ([rowIndex (in-range sizeY)])
    (row rowIndex 
         (for/list ([columnIndex (in-range sizeX)])
            (tile columnIndex (@ "../assets/"))))))

(define (draw-grid)
  (vpanel
    (list-view 
      (construct-obs-grid 5 5)
      #:key row-index
      (lambda (xKey @row)
        (hpanel
          (list-view
            (@row . ~> . row-tiles)
            #:key tile-index
            (lambda (yKey @tile)
              (image (@tile . ~> . tile->string)))))))))
  
(render
  (window
    #:title "Pokemon Map-Maker"
    (hpanel
      (draw-grid))))

