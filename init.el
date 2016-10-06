(setq gc-cons-threshold 100000000)

;; no menu bar
(menu-bar-mode -1)

;; Disable tool bar
(tool-bar-mode -1)

;; disable scroll bars
(scroll-bar-mode -1)

;; No splash screen
(setq inhibit-splash-screen t)

;; no message on startup
(setq initial-scratch-message nil)

;; set font
(set-face-attribute 'default nil :font "Inconsolata-10")

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package doom-theme
  :load-path "elpa/doom-theme/"
  :config (load-theme 'doom-one t))

(use-package rainbow-delimiters
  :ensure t
  :init (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

(use-package evil
  :ensure t
  ;:init (setq evil-want-C-u-scroll t)
  :config (progn
	    (evil-mode 1)
            (defalias #'forward-evil-word #'forward-evil-symbol)))

(use-package evil-snipe
  :ensure t
  :init (setq evil-snipe-scope 'whole-buffer)
  :config (progn
            (evil-snipe-mode 1)
            (add-hook 'magit-mode-hook 'turn-off-evil-snipe-override-mode)))

(use-package evil-magit
  :ensure t)

(use-package elixir-mode
  :ensure t)

(use-package alchemist
  :ensure t
  :config (setq alchemist-mix-test-default-options "--no-start"))

(use-package swiper
  :ensure t)

(use-package counsel
  :ensure t
  :bind ("M-x" . counsel-M-x))

(use-package ivy
  :ensure t
  :init (setq ivy-use-virtual-buffers t
                ivy-height 10
                ivy-count-format "(%d/%d) ")
  :bind (("C-c C-r" . ivy-resume)
         :map ivy-minibuffer-map ("RET" . ivy-alt-done))
  :config (ivy-mode 1))

(use-package hydra
  :ensure t)

(use-package company
  :ensure t
  :init (global-company-mode))

(use-package org
  :ensure t
  :init (setq org-agenda-window-setup 'current-window))

(use-package linum
  :init (setq linum-format "%3d ")
  :config (add-hook 'prog-mode-hook 'linum-mode t))

(use-package yasnippet
  :ensure t
  :config (progn
	    (yas-reload-all)
	    (add-hook 'prog-mode-hook #'yas-minor-mode)))

(use-package magit
  :ensure t
  :init (add-hook 'after-save-hook 'magit-after-save-refresh-status))

;;(use-package git-gutter-fringe
;;  :ensure t
;;  :init (add-hook 'prog-mode-hook 'git-gutter-mode)
;;  :config
;;  (setq git-gutter:update-interval 1
;;        fringes-outside-margins t)
;;  (define-fringe-bitmap 'git-gutter-fr:added
;;    [224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224]
;;    nil nil 'center)
;;  (define-fringe-bitmap 'git-gutter-fr:modified
;;    [224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224]
;;    nil nil 'center)
;;  (define-fringe-bitmap 'git-gutter-fr:deleted
;;    [0 0 0 0 0 0 0 0 0 0 0 0 0 128 192 224 240 248]
;;    nil nil 'center))

;; Enable S-{left, right, up, down} to switch window focus
(windmove-default-keybindings)


;; Write backup files to own directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "emacs-backups")))))

;; Use X clipboard
(setq x-select-enable-clipboard t
      x-select-enable-primary t)

;; Disable blinking cursor
(blink-cursor-mode -1)

;; delete trailing whitespace in all modes
(add-hook 'before-save-hook #'delete-trailing-whitespace)

(setq-default indent-tabs-mode nil)

;; set encoding
(prefer-coding-system 'utf-8)

;; and tell emacs to play nice with encoding
(define-coding-system-alias 'UTF-8 'utf-8)
(define-coding-system-alias 'utf8 'utf-8)

;;keep cursor at same position when scrolling
(setq scroll-preserve-screen-position t)

;; scroll one line at a time
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time
(setq scroll-conservatively 10000)
(setq scroll-margin 3)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(alchemist-test-status-modeline nil)
 '(org-agenda-files (quote ("~/todo.org"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
