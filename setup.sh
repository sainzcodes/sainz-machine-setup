#!/bin/bash

# 🚀 Santiago Sainz AI - Perfect Terminal Setup for Claude Code
# Automated iTerm2 + Oh My Zsh + Powerlevel10k + Development Tools

set -e

echo "🚀 Setting up perfect terminal for Santiago Sainz AI startup development..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 1. Install iTerm2
print_status "Installing iTerm2..."
brew install --cask iterm2 2>/dev/null || print_warning "iTerm2 already installed"
print_success "iTerm2 ready"

# 2. Install Nerd Fonts
print_status "Installing Nerd Fonts..."
brew tap homebrew/cask-fonts 2>/dev/null || true
brew install --cask font-meslo-lg-nerd-font 2>/dev/null || print_warning "Font already installed"
brew install --cask font-fira-code-nerd-font 2>/dev/null || print_warning "Font already installed"
brew install --cask font-jetbrains-mono-nerd-font 2>/dev/null || print_warning "Font already installed"
print_success "Nerd Fonts installed"

# 3. Install Oh My Zsh (if not present)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    print_status "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    print_success "Oh My Zsh installed"
else
    print_warning "Oh My Zsh already installed"
fi

# 4. Install Powerlevel10k theme
print_status "Installing Powerlevel10k theme..."
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    print_success "Powerlevel10k installed"
else
    print_warning "Powerlevel10k already installed"
fi

# 5. Install essential zsh plugins
print_status "Installing zsh plugins..."

# zsh-autosuggestions
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

# zsh-syntax-highlighting
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

# zsh-completions
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-completions" ]; then
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-completions
fi

print_success "Zsh plugins installed"

# 6. Install better CLI tools
print_status "Installing better CLI tools..."
brew install eza bat fd ripgrep fzf jq tree htop git-delta 2>/dev/null || print_warning "Some tools already installed"
print_success "CLI tools installed"

# 7. Create optimized .zshrc
print_status "Creating optimized .zshrc configuration..."

cat > ~/.zshrc << 'EOF'
# 🚀 Santiago Sainz AI - Perfect Terminal Configuration
# Optimized for Claude Code development and startup productivity

# Path to oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-completions
    z
    docker
    npm
    node
    brew
    macos
)

source $ZSH/oh-my-zsh.sh

# ================================
# SANTIAGO SAINZ AI CONFIGURATION
# ================================

# Claude Code alias (using npx for reliability)
alias claude-code="npx @anthropic-ai/claude-code"
alias cc="npx @anthropic-ai/claude-code"

# Startup project shortcuts
alias santiago="cd ~/santiago-site && claude-code"
alias dashpro="cd ~/dashpro-landing && claude-code"
alias template="cd ~/dashpro-template && claude-code"
alias projects="cd ~ && ls -la | grep -E 'santiago|dashpro|PROJECT'"

# Enhanced CLI tools
alias ls="eza --icons --group-directories-first"
alias ll="eza -la --icons --group-directories-first"
alias tree="eza --tree --icons"
alias cat="bat"
alias find="fd"
alias grep="rg"

# Git shortcuts for fast development
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git log --oneline --graph"
alias gd="git diff"

# Development shortcuts
alias dev="npm run dev"
alias build="npm run build"
alias start="npm start"
alias test="npm test"
alias install="npm install"

# Quick project setup
alias new-project="mkdir -p ~/new-project && cd ~/new-project && git init && npm init -y"

# System shortcuts
alias reload="source ~/.zshrc"
alias edit-zsh="code ~/.zshrc"
alias update="brew update && brew upgrade && npm update -g"

# Business shortcuts
alias revenue="cat ~/PROJECT_TRACKER.md | grep -i revenue"
alias goals="cat ~/PROJECT_TRACKER.md | head -20"
alias tracker="code ~/PROJECT_TRACKER.md"

# PATH additions
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/lib/node_modules/.bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Environment variables for development
export EDITOR="code"
export BROWSER="open"
export TERMINAL="iterm"

# Node.js optimization
export NODE_OPTIONS="--max-old-space-size=4096"

# History optimization
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt SHARE_HISTORY

# Auto-completion optimization
autoload -U compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# FZF configuration for fuzzy finding
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Startup message
echo "🚀 Santiago Sainz AI Terminal Ready!"
echo "💡 Quick commands: santiago | dashpro | template | projects | revenue"
echo "🎯 Goal: $1000/month in 90 days"
EOF

print_success ".zshrc configuration created"

# 8. Create iTerm2 color scheme and settings
print_status "Creating iTerm2 configuration..."

# Create iTerm2 preferences directory
mkdir -p ~/Library/Preferences

# Create iTerm2 startup applescript
cat > ~/setup-iterm-settings.applescript << 'EOF'
tell application "iTerm"
    tell current session of current window
        set name to "Santiago Sainz AI Terminal"
    end tell
end tell
EOF

print_success "iTerm2 configuration ready"

# 9. Create Powerlevel10k configuration
print_status "Creating Powerlevel10k configuration..."

cat > ~/.p10k.zsh << 'EOF'
# Powerlevel10k configuration optimized for Santiago Sainz AI development
# Generated with Claude Code for maximum productivity

# Instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Left prompt elements
typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    dir                     # current directory
    vcs                     # git status
    prompt_char             # prompt symbol
)

# Right prompt elements
typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
    status                  # exit code of the last command
    command_execution_time  # duration of the last command
    background_jobs         # presence of background jobs
    node_version           # node.js version
    time                   # current time
)

# Visual style
typeset -g POWERLEVEL9K_MODE=nerdfont-complete
typeset -g POWERLEVEL9K_PROMPT_ON_NEWLINE=true
typeset -g POWERLEVEL9K_RPROMPT_ON_NEWLINE=false
typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=''
typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX='🚀 '

# Directory configuration
typeset -g POWERLEVEL9K_DIR_FOREGROUND=31
typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique
typeset -g POWERLEVEL9K_SHORTEN_DELIMITER=''

# Git configuration
typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND=76
typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=178
typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=39

# Node.js version
typeset -g POWERLEVEL9K_NODE_VERSION_FOREGROUND=70

# Time format
typeset -g POWERLEVEL9K_TIME_FORMAT='%D{%H:%M}'

# Instant prompt mode
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
EOF

# Add p10k config to .zshrc
echo -e "\n# Powerlevel10k configuration" >> ~/.zshrc
echo "[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh" >> ~/.zshrc

print_success "Powerlevel10k configured"

# 10. Install additional development tools
print_status "Installing additional development tools..."
npm install -g typescript prettier eslint @tailwindcss/cli vercel 2>/dev/null || print_warning "Some npm packages already installed"
print_success "Development tools installed"

# 11. Final setup
print_status "Performing final setup..."

# Make scripts executable
chmod +x ~/setup-iterm-settings.applescript 2>/dev/null || true

# Source the new configuration
source ~/.zshrc 2>/dev/null || true

print_success "✨ Perfect terminal setup complete!"

echo ""
echo "=================================="
echo "🎉 SANTIAGO SAINZ AI TERMINAL READY"
echo "=================================="
echo ""
echo "🚀 Quick Start Commands:"
echo "  santiago    - Open santiago-site in Claude Code"
echo "  dashpro     - Open dashpro-landing in Claude Code"
echo "  template    - Open dashpro-template in Claude Code"
echo "  projects    - List all startup projects"
echo "  revenue     - Check revenue progress"
echo ""
echo "💡 Enhanced Commands:"
echo "  ll          - Better file listing"
echo "  tree        - Directory tree view"
echo "  gs          - Git status"
echo "  dev         - npm run dev"
echo ""
echo "🎯 Business Goal: $1000/month in 90 days"
echo ""
echo "⚡ Next Steps:"
echo "1. Restart iTerm2 or run: exec zsh"
echo "2. Set iTerm2 font to 'MesloLGS NF' in Preferences"
echo "3. Configure Powerlevel10k: p10k configure"
echo "4. Start coding: santiago"
echo ""
echo "=================================="
EOF