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
(add-to-list 'default-frame-alist '(font . "Inconsolata-13"))
(set-face-attribute 'default nil :font "Inconsolata-13")

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;(use-package doom-themes
;  :ensure t
;  :config (progn
;            (load-theme 'doom-one t)
;            (add-hook 'find-file-hook 'doom-buffer-mode)))

(use-package dracula-theme
  :ensure t
  :config (load-theme 'dracula t))

(use-package rainbow-delimiters
  :ensure t
  :init (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

(use-package evil
  :ensure t
  :config (progn
	    (evil-mode 1)
            (defalias #'forward-evil-word #'forward-evil-symbol)))

(use-package evil-magit
  :ensure t)

(use-package evil-org
  :ensure t
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda ()
              (evil-org-set-key-theme))))

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

(use-package ivy-hydra
  :ensure t)

(use-package company
  :ensure t
  :init (global-company-mode)
  :config (setq company-idle-delay 0.2
                company-minimum-prefix-length 1))

(use-package company-jedi
  :ensure t
  :config (add-to-list 'company-backends 'company-jedi))

(use-package org
  :ensure t
  :init (setq org-agenda-window-setup 'current-window)
  :config (setq org-agenda-files '("~/org/gtd.org")
                org-capture-templates '(("t" "Todo" entry
                                         (file+headline "~/org/gtd.org" "Tasks")
                                         "* TODO %i%?")
                                        ("T" "Tickler" entry
                                         (file+headline "~/org/gtd.org" "Tickler")
                                         "* %i%? \n %U")))
  :bind (("C-c c" . org-capture)
         ("C-c a" . org-agenda)))

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
  :bind (("C-c m" . magit-status))
  :init (add-hook 'after-save-hook 'magit-after-save-refresh-status))

(use-package markdown-mode
  :ensure t
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "pandoc -c ~/.emacs.d/github-pandoc.css --from markdown_github -t html5 --mathjax --highlight-style pygments --standalone"))

(use-package pandoc-mode
  :ensure t
  :config (add-hook 'markdown-mode-hook 'pandoc-mode))

(use-package project
  :bind ("C-x f" . project-find-file))

(use-package which-key
  :ensure t
  :config (which-key-mode))

(use-package darkroom
  :ensure t)

(use-package web-mode
  :ensure t
  :mode (("\\.html?\\'" . web-mode))
  :config (setq web-mode-markup-indent-offset 2
                web-mode-code-indent-offset 2
                web-mode-css-indent-offset 2))

(use-package tex-site
  :ensure auctex
  :config (setq TeX-PDF-mode t
                ;TeX-command-force "LaTeX"
                TeX-view-program-list '(("PDF Viewer" "zathura %o"))))

;; Enable S-{left, right, up, down} to switch window focus
(windmove-default-keybindings)
;; Make windmove work in org-mode:
(add-hook 'org-shiftup-final-hook 'windmove-up)
(add-hook 'org-shiftleft-final-hook 'windmove-left)
(add-hook 'org-shiftdown-final-hook 'windmove-down)
(add-hook 'org-shiftright-final-hook 'windmove-right)

;; Write backup files to own directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "emacs-backups")))))

;; Write temp files to own directory
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name
                 (concat user-emacs-directory "auto-save")) t)))


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

;; prefer vertical splits if there is enough space
(setq split-height-threshold nil)
(setq split-width-threshold 160)

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
