;
; jcgrammx.asm - grayscale colorspace conversion (MMX)
;
; Copyright 2009 Pierre Ossman <ossman@cendio.se> for Cendio AB
; Copyright 2011 D. R. Commander
;
; Based on
; x86 SIMD extension for IJG JPEG library
; Copyright (C) 1999-2006, MIYASAKA Masaru.
; For conditions of distribution and use, see copyright notice in jsimdext.inc
;
; This file should be assembled with NASM (Netwide Assembler),
; can *not* be assembled with Microsoft's MASM or any compatible
; assembler (including Borland's Turbo Assembler).
; NASM is available from http://nasm.sourceforge.net/ or
; http://sourceforge.net/project/showfiles.php?group_id=6208
;
; [TAB8]

%include "jsimdext.inc"

; --------------------------------------------------------------------------

%define SCALEBITS	16

F_0_114	equ	 7471			; FIX(0.11400)
F_0_250	equ	16384			; FIX(0.25000)
F_0_299	equ	19595			; FIX(0.29900)
F_0_587	equ	38470			; FIX(0.58700)
F_0_337	equ	(F_0_587 - F_0_250)	; FIX(0.58700) - FIX(0.25000)

; --------------------------------------------------------------------------
	SECTION	SEG_CONST

	alignz	16
	global	EXTN(jconst_rgb_gray_convert_mmx)

EXTN(jconst_rgb_gray_convert_mmx):

PW_F0299_F0337	times 2 dw  F_0_299, F_0_337
PW_F0114_F0250	times 2 dw  F_0_114, F_0_250
PD_ONEHALF	times 2 dd  (1 << (SCALEBITS-1))

	alignz	16

; --------------------------------------------------------------------------
	SECTION	SEG_TEXT
	BITS	32

%include "jcgrymmx.asm"

%undef RGB_RED
%undef RGB_GREEN
%undef RGB_BLUE
%undef RGB_PIXELSIZE
%define RGB_RED 0
%define RGB_GREEN 1
%define RGB_BLUE 2
%define RGB_PIXELSIZE 3
%define jsimd_rgb_gray_convert_mmx jsimd_extrgb_gray_convert_mmx
%include "jcgrymmx.asm"

%undef RGB_RED
%undef RGB_GREEN
%undef RGB_BLUE
%undef RGB_PIXELSIZE
%define RGB_RED 0
%define RGB_GREEN 1
%define RGB_BLUE 2
%define RGB_PIXELSIZE 4
%define jsimd_rgb_gray_convert_mmx jsimd_extrgbx_gray_convert_mmx
%include "jcgrymmx.asm"

%undef RGB_RED
%undef RGB_GREEN
%undef RGB_BLUE
%undef RGB_PIXELSIZE
%define RGB_RED 2
%define RGB_GREEN 1
%define RGB_BLUE 0
%define RGB_PIXELSIZE 3
%define jsimd_rgb_gray_convert_mmx jsimd_extbgr_gray_convert_mmx
%include "jcgrymmx.asm"

%undef RGB_RED
%undef RGB_GREEN
%undef RGB_BLUE
%undef RGB_PIXELSIZE
%define RGB_RED 2
%define RGB_GREEN 1
%define RGB_BLUE 0
%define RGB_PIXELSIZE 4
%define jsimd_rgb_gray_convert_mmx jsimd_extbgrx_gray_convert_mmx
%include "jcgrymmx.asm"

%undef RGB_RED
%undef RGB_GREEN
%undef RGB_BLUE
%undef RGB_PIXELSIZE
%define RGB_RED 3
%define RGB_GREEN 2
%define RGB_BLUE 1
%define RGB_PIXELSIZE 4
%define jsimd_rgb_gray_convert_mmx jsimd_extxbgr_gray_convert_mmx
%include "jcgrymmx.asm"

%undef RGB_RED
%undef RGB_GREEN
%undef RGB_BLUE
%undef RGB_PIXELSIZE
%define RGB_RED 1
%define RGB_GREEN 2
%define RGB_BLUE 3
%define RGB_PIXELSIZE 4
%define jsimd_rgb_gray_convert_mmx jsimd_extxrgb_gray_convert_mmx
%include "jcgrymmx.asm"
