#!/bin/bash

# パラメータ設定
MAX_TURNS=20
SLEEP_TIME=60

echo "レビュースクリプトを開始します..."

# 無限ループでclaudeコマンドを実行
while true; do
    # COMPLETE.mdファイルの存在確認
    if [ -f "COMPLETE.md" ]; then
        echo "レビュー完了しました。"
        notify-send "レビュー完了" "COMPLETE.mdが作成されました。レビューが完了しました。"
        exit 0
    fi
    
    claude --verbose -p --max-turns $MAX_TURNS --dangerously-skip-permissions < REVIEWER_PROMPT.md
    
    # claudeコマンドが0以外を返した場合もループを抜ける
    if [ $? -ne 0 ]; then
        echo "claudeコマンドがエラーで終了しました。レビュースクリプトを終了します。"
        notify-send "レビュースクリプト終了" "claudeコマンドがエラーで終了しました。"
        exit 1
    fi
    
    sleep $SLEEP_TIME
done