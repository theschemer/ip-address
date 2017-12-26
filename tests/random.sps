#!/usr/bin/env scheme-script
;; -*- mode: scheme; coding: utf-8 -*- !#
;; Copyright © 2017 Göran Weinholt <goran@weinholt.se>

;; Permission is hereby granted, free of charge, to any person obtaining a
;; copy of this software and associated documentation files (the "Software"),
;; to deal in the Software without restriction, including without limitation
;; the rights to use, copy, modify, merge, publish, distribute, sublicense,
;; and/or sell copies of the Software, and to permit persons to whom the
;; Software is furnished to do so, subject to the following conditions:

;; The above copyright notice and this permission notice shall be included in
;; all copies or substantial portions of the Software.

;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
;; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
;; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
;; THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
;; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
;; FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
;; DEALINGS IN THE SOFTWARE.
#!r6rs

(import (rnrs)
        (only (srfi :1 lists) iota)
        (srfi :27 random-bits)
        (srfi :78 lightweight-testing)
        (ip-address))

;;; Check that the string parsers don't crash on random input

(define (random-string)
  (call-with-string-output-port
    (lambda (p)
      (do ((len (random-integer 60))
           (i 0 (+ i 1)))
          ((= i len))
        (put-char p (integer->char (random-integer 128)))))))

(check (do ((i 0 (+ i 1)))
           ((= i 100000) #t)
         (string->ipv4 (random-string)))
       => #t)

(check (do ((i 0 (+ i 1)))
           ((= i 100000) #t)
         (string->ipv6 (random-string)))
       => #t)

;;; Check that the string formatters don't crash on random input

(define (random-bytevector len)
  (call-with-bytevector-output-port
    (lambda (p)
      (do ((i 0 (+ i 1)))
          ((= i len))
        (put-u8 p (random-integer 256))))))

(check (do ((i 0 (+ i 1)))
           ((= i 10000) #t)
         (assert (string? (ipv4->string (random-bytevector 4)))))
       => #t)

(check (do ((i 0 (+ i 1)))
           ((= i 10000) #t)
         (assert (string? (ipv6->string (random-bytevector 16)))))
       => #t)


(check-report)
(assert (check-passed? 4))
