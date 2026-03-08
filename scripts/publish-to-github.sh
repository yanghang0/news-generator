#!/bin/bash
# 新闻网页发布到GitHub脚本

echo "📰 新闻网页发布工具"
echo "===================="
echo ""

# 检查GitHub CLI是否安装
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI未安装"
    echo ""
    echo "请先安装GitHub CLI："
    echo "  macOS: brew install gh"
    echo "  Linux: sudo apt install gh"
    echo "  Windows: 下载 https://github.com/cli/cli/releases"
    echo ""
    echo "或者使用手动方法："
    echo "  1. 下载 news-page.tar.gz"
    echo "  2. 解压到本地"
    echo "  3. 访问 https://github.com/new 创建仓库"
    echo "  4. 上传 news.html 文件"
    exit 1
fi

# 检查是否已登录
if ! gh auth status &> /dev/null; then
    echo "❌ 未登录GitHub，请先运行：gh auth login"
    exit 1
fi

echo "✅ GitHub CLI已安装并登录"
echo ""

# 询问仓库名称
read -p "请输入仓库名称（默认：news-2026-03-08）: " REPO_NAME
REPO_NAME=${REPO_NAME:-news-2026-03-08}

echo ""
echo "📋 仓库名称: $REPO_NAME"

# 检查仓库是否已存在
if gh repo view "$REPO_NAME" &> /dev/null; then
    echo "⚠️  仓库已存在，将使用现有仓库"
    REPO_EXISTS=true
else
    echo "✨ 创建新仓库..."
    gh repo create "$REPO_NAME" --public --description "2026年3月8日 新闻汇总" --source=. --remote=origin --push
    REPO_EXISTS=false
fi

echo ""
echo "🎉 发布完成！"
echo ""
echo "🌐 仓库地址: https://github.com/$(gh auth whoami)/$REPO_NAME"
echo ""
echo "📖 查看网页:"
echo "   https://$(gh auth whoami).github.io/$REPO_NAME/news.html"
echo ""
echo "💡 提示："
echo "   - 如果仓库不存在，脚本会自动创建"
echo "   - 文件已推送到main分支"
echo "   - 网页链接将在几秒内生效"
