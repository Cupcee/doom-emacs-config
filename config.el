;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Samuel Piirainen"
      user-mail-address "samuel.piirainen@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

(setq doom-font (font-spec :family "Fira Code" :size 17)
      doom-variable-pitch-font (font-spec :family "Fira Code" :size 17))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-outrun-electric)

;; for doom-outrun-electric to highlight line better
(custom-set-faces
 '(region ((t (:background "#204052"))))
 '(hl-line ((t (:background "#251e4d")))))

;; better treemacs line highlight
(defface custom-line-highlight '((t (:background "#251e4d" :extend t))) "")
(add-hook
 'treemacs-mode-hook
 (defun channge-hl-line-mode ()
   (setq-local hl-line-face 'custom-line-highlight)
   (overlay-put hl-line-overlay 'face hl-line-face)
   (treemacs--setup-icon-background-colors)))
;;
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

(add-hook 'window-setup-hook #'toggle-frame-fullscreen)
;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(map! :map evil-window-map
      "SPC" #'rotate-layout
      ;; Navigation
      "<left>"     #'evil-window-left
      "<down>"     #'evil-window-down
      "<up>"       #'evil-window-up
      "<right>"    #'evil-window-right
      ;; Swapping windows
      "C-<left>"       #'+evil/window-move-left
      "C-<down>"       #'+evil/window-move-down
      "C-<up>"         #'+evil/window-move-up
      "C-<right>"      #'+evil/window-move-right)

;; C-u is too far away
(map! :map evil-normal-state-map
      "C-f"            #'evil-scroll-up)

;; evil-escape
(setq-default evil-escape-key-sequence "fd")
(setq-default evil-escape-delay 0.2)

;; use evil-escape in vterm
(after! evil-escape (delete 'vterm-mode evil-escape-excluded-major-modes))

;; finnish keyboard
(cond (IS-MAC
       (setq mac-option-modifier 'nil)
       (setq mac-command-modifier 'control)
       (setq mac-right-command-modifier 'nil)))

;; for nicer treemacs icons
(setq doom-themes-treemacs-theme "doom-colors")

(map! :leader
      ;; configurate multi-vterm
      :desc "New vterm"
      "o c" #'multi-vterm
      :desc "Next vterm"
      "o n" #'multi-vterm-next
      ;; add TAB as last buffer switch
      :desc "Switch to last buffer"
      "TAB" #'evil-switch-to-windows-last-buffer)

;; with typescript/js use local .prettierrc
(setq-hook! 'typescript-mode-hook +format-with-lsp nil)
(setq-hook! 'js2-mode-hook +format-with-lsp nil)

;; disable mouse to avoid lsp hints sometimes popping up
(mapc #'disable-mouse-in-keymap
  (list evil-motion-state-map
        evil-normal-state-map
        evil-visual-state-map
        evil-insert-state-map))

;; Enable time in the mode-line
(display-time-mode 1)
(defface egoge-display-time
   '((((type x w32 mac))
      ;; #060525 is the background colour of my default face.
      (:foreground "#060525" :inherit bold))
     (((type tty))
      (:foreground "blue")))
   "Face used to display the time in the mode line.")
 ;; This causes the current time in the mode line to be displayed in
 ;; `egoge-display-time-face' to make it stand out visually.
(setq display-time-string-forms
       '((propertize (concat " " 24-hours ":" minutes " ")
 		    'face 'egoge-display-time)))

;; Show battery
(display-battery-mode 1)

(custom-set-faces!
  '(flycheck-warning :underline (:color "#ffd400" :style line)))
