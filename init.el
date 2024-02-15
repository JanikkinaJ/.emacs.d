;; setup straight https://github.com/radian-software/straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; use straight automatically when using use-package 
(setq straight-use-package-by-default t)

;; Don't show the splash screen
(setq inhibit-startup-message t)

;; change the look
(tool-bar-mode -1) ; remove tool bar
(scroll-bar-mode -1) ; remove scroll bar
(global-display-line-numbers-mode 1)
(set-face-attribute 'default nil :height 170) ;;(height / 10 = normal font)

;; enable recent files
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)

;; theme
(use-package exotica-theme)
(load-theme 'exotica t)

;; ======== https://github.com/emacs-evil/evil
;; evil vim
;; ========
(unless (package-installed-p 'evil)
  (use-package evil))

;; required packages
(use-package goto-chg)
(require 'evil)
(evil-mode 1)

;; ==================================================
;; Ivy (completion) https://github.com/abo-abo/swiper
;; ==================================================
(use-package ivy)
(use-package counsel)
(ivy-mode)
(counsel-mode)

;; ==================
;; personal functions
;; ==================
(defun reload-config ()
  (interactive)
  (load-file "~/.emacs.d/init.el"))

(defun edit-config ()
  (interactive
  (find-file "~/.emacs.d/init.el")))

;; ========= https://github.com/justbur/emacs-which-key
;; which key
;; =========
(use-package which-key)
(require 'which-key)
(which-key-mode)

;; ===============
;; new keybindings
;; ===============
(use-package general)

(general-create-definer my-leader-def
  :prefix "SPC")

(my-leader-def
  :keymaps 'normal
  ;; bind "SPC a"
  "f s" 'save-buffer
  "." 'find-file
  "f r" 'recentf-open
  ;; window commands
  "w d" 'evil-window-delete
  "w h" 'evil-window-new 
  "w v" 'evil-window-vnew
  "w j" 'evil-window-up
  "w k" 'evil-window-down
  "w h" 'evil-window-left
  "w l" 'evil-window-right
  ;; config commands
  "c r" 'reload-config
  "c e" 'edit-config)
  
;; change which key description
(which-key-add-key-based-replacements
  "SPC f" "files")
(which-key-add-key-based-replacements
  "SPC c" "config")
(which-key-add-key-based-replacements
  "SPC w" "window")

