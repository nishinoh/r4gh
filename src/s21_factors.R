##### このファイルについて ===============================================
# 第21回(応用福祉調査 第6回)の配付用スクリプト
# 調査票(第20回の配付資料)の選択肢に合わせて、カテゴリ型の変数を factor にする関数を定義する
#
# 使い方
#   source("https://github.com/nishinoh/r4gh/raw/main/src/21_set_factors.R")
#   survey <- setSurveyFactors(survey_raw)
#
# 読み込んだままのデータ(survey_raw)は書き換えず、factor にしたデータを別に返す。
# survey_raw から作り直す限り、何度実行しても結果は同じになる。
#
# 原本は lec_ds リポジトリの src/21_set_factors.R。r4gh リポジトリに置いてURLから読み込ませる

setSurveyFactors <- function(data) {
	# factor にしたデータをもう一度渡すと、選択肢の対応が取れずに全て NA になってしまうので止める
	if (is.factor(data$q1)) {
		stop("このデータはすでに factor になっています。読み込んだままのデータ(survey_raw)を渡してください。")
	}

	data |>
		dplyr::mutate(
			# 問1 性別(カテゴリ型)
			q1 = factor(
				q1,
				levels = 1:4,
				labels = c("女性", "男性", "その他", "答えたくない")
			),
			# 問3 住まい(カテゴリ型)
			q3 = factor(
				q3,
				levels = 1:4,
				labels = c("実家", "下宿", "親戚の家", "その他")
			),
			# 問9 外食頻度(順序のあるカテゴリ型)。levels の順に並ぶので、調査票の選択肢の順に指定する
			q9 = factor(
				q9,
				levels = 1:5,
				labels = c("週2回以上", "週に1回程度", "月に2〜3回程度", "月に1回程度", "それ以下")
			)
		)
}
