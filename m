Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13CEEEB1060
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 15:35:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E7158412F;
	Tue, 10 Mar 2026 16:34:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FtU4/YK5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4E09840D7; Tue, 10 Mar 2026 16:34:26 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B71EB83FBC
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 16:34:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-466f00535cfso2175888b6e.1
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 08:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773156860; x=1773761660;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=l6Znakp35pa1PEVA4cOzIFA7wVPMwmBelYD6CUkDuTc=;
 b=FtU4/YK5+2qeYKjY/1/VhGrSdZTIhZotDuqNQ6h2j7Y8KAFrBH5hIzu3GlRUQc3Pjw
 9hf12FaYqXhY2V8+qPFA/QMBFxBwTaa6ZdO63bTeT8WPz51Iv8C2hNNRtnmPQXJU8Fm0
 4v7fG1wCpIOS4N2dUmLk9h4kaBnka4brOS+9/oyJmZwFXqWAon6s8ppSq4uiwzmNqecC
 p/YtYoqCQmm1cnb73c1dL1B8gU99/1UjKw3gaOOUQZR4suOJZJOtTh6rD8IgQdUfymh1
 HdLd4lzycnCV0EetCcjw5qtknbtPhxBb/gWYiPOsYV8ll7AinskOmbZpwBsg+fVAVNNn
 Id9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773156860; x=1773761660;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=l6Znakp35pa1PEVA4cOzIFA7wVPMwmBelYD6CUkDuTc=;
 b=W2Pdox2IlFMCoOxOu5Wp+9qSmkil+wGpkGc+nGg3QfAaan1iSNoKiDhf7don9BStjf
 E4P4lG8ZVpsZAEFoksulwxMHINu7hGL/S5DMByIqbVivdnF00nwgKXxlcdWHaY3zQEGa
 UOPfYsOaJvUQRloNV9VJyCpggrrSF1CIwrz+BIJT7ff55bPajL27sezKbMhjMYUlp27g
 IaW0TL6JUvilpqn0wyUuHI0RlRRshCLeOHgqpRtEYAs9c5CJ1FPTAGcx8AlTzsaxC1OY
 U4TNXG3MkcsBCNkH6LwJ6O12yUU71F2tLWhefCpsGmzWA5ZA266Qx6zAAlI9ydM2ZiK2
 5qfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdktQcZDa6hrMCZ4yw7kpNLTcvQnO89q9jkM17tLxNlNox3epoyHT5ET6UiYernG9qrCTIjQM=@lists.denx.de
X-Gm-Message-State: AOJu0YzB0oGwVl1q8lnr3EVcRILilRwH8jt475Vav8Wq7lg7t0VAGkpm
 evGp/Ij71B5vUw3Tz8mPjpZZJLUuP6o8Bq1nVGruDYFcC+jx9GhLu8Au9ovFdk+Mde0=
X-Gm-Gg: ATEYQzzXbXONKEIJlpVVamc+M7M7Dta1zAA2Fi9pwGtClsqeFdMs8bea0dvQk7QhXDb
 IzzUnEtn4SkS02/z9u04Y8lkhb3SUX1/Z5tZgsYzOSn1ZqkYsjsz46zBwx3RTNg4uBh2xuYITcz
 82kRH/qh4bL2rhLfPXqzc7JL+UPzCZDgDLd7RLVlCXV7YiONKC+R/sv4GFYGTrN/FHCdg4fBI4y
 W3FfsXcuJWJNUfouS2xT6d8xN8dSTZI23JcAM/l8GC+jPY5XMvyg/qL/l136f/GMLGLByHPbe7X
 tBYFaIpvl6MGJdTAJLEZqZvYne7HSPsqe3Rqc5OuXierHl2XyH7z2U51h/CnWSFkJMmNtBL39Ct
 iIRdEUV7nqYWpTXoKt009bvNBGMkNuP8g8MwAg/mnDBai1SOLMSjCcnrthKDJkwyvddYd9+3BnZ
 m6SDLttwomxXmXtkiOo1XN+bnuqWQc
X-Received: by 2002:a05:6808:11c5:b0:460:f435:2a70 with SMTP id
 5614622812f47-466dcb6b310mr8361043b6e.47.1773156860447; 
 Tue, 10 Mar 2026 08:34:20 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:78e2:51e2:14b8:2e10])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-466ecbcec59sm6320968b6e.7.2026.03.10.08.34.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 08:34:20 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 10 Mar 2026 10:32:18 -0500
Subject: [PATCH 05/16] clk: mediatek: mt7981: convert CLK_XTAL to
 CLK_PAD_CLK40M
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-clk-mtk-parent-cleanup-v1-5-66175ca8f637@baylibre.com>
References: <20260310-clk-mtk-parent-cleanup-v1-0-66175ca8f637@baylibre.com>
In-Reply-To: <20260310-clk-mtk-parent-cleanup-v1-0-66175ca8f637@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1989; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=A0+QFQXcH4OV/EvBKTMVbW37uUDlNLwCFGBgftT6t3U=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpsDmmxtixi94yfHEKTLZlrJsLAx3UhW2nSFNy6
 kJ26+NGhtaJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabA5phYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AZ24H/i/csXoQxK09ElyEOaC7FQWou+7xOrfJfEt3VG2
 mTKMoEQQ++ue4GrQp5Gr8+TeO/YZ8r9nfLzKoHp/5NzEGhl4hvTbkfpe3N25Xf9e5SYD65kJjiW
 iZPHyTsBo6ySAuaSGJ5AkYlxTS02E4G3VEQDv5ru/5vjMDnHsJT0kC9JTW58Q1HiSAnzpWdLTo0
 ehb0D/99Xr3wF+JPK3BSjEJIBMGtgZo2ZHu/L6qj/Q0gTtQAwDrdVA6QnRNU7JbsBg617yGHBK9
 wHLdxqd7YTDX7LDwRJR0QmPwwYxGQABV3wFXUHyRDJhfwD1y2BjFOUuFrDPYTFGR2GZI3p+eI1H
 Mrto=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Replace all uses of CLK_XTAL with CLK_PAD_CLK40M.

This will eventually let us remove CLK_PARENT_XTAL completely.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7981.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7981.c b/drivers/clk/mediatek/clk-mt7981.c
index 685abd844f2..8c2944b7fb3 100644
--- a/drivers/clk/mediatek/clk-mt7981.c
+++ b/drivers/clk/mediatek/clk-mt7981.c
@@ -18,8 +18,16 @@
 #define MT7981_CLK_PDN 0x250
 #define MT7981_CLK_PDN_EN_WRITE BIT(31)
 
+enum {
+	CLK_PAD_CLK40M,
+};
+
+static const ulong ext_clock_rates[] = {
+	[CLK_PAD_CLK40M] = 40 * MHZ,
+};
+
 #define FIXED_CLK0(_id, _rate)					\
-	FIXED_CLK(_id, CLK_XTAL, CLK_PARENT_XTAL, _rate)
+	FIXED_CLK(_id, CLK_PAD_CLK40M, CLK_PARENT_EXT, _rate)
 
 #define PLL_FACTOR(_id, _name, _parent, _mult, _div)                           \
 	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_APMIXED)
@@ -609,13 +617,16 @@ static const struct mtk_gate infracfg_gates[] = {
 };
 
 static const struct mtk_clk_tree mt7981_fixed_pll_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.fdivs_offs = CLK_APMIXED_NR_CLK,
-	.xtal_rate = 40 * MHZ,
 	.fclks = fixed_pll_clks,
 	.num_fclks = ARRAY_SIZE(fixed_pll_clks),
 };
 
 static const struct mtk_clk_tree mt7981_topckgen_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.fdivs_offs = CLK_TOP_CB_M_416M,
 	.muxes_offs = CLK_TOP_NFI1X_SEL,
 	.fclks = top_fixed_clks,
@@ -628,6 +639,8 @@ static const struct mtk_clk_tree mt7981_topckgen_clk_tree = {
 };
 
 static const struct mtk_clk_tree mt7981_infracfg_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.fdivs_offs = CLK_INFRA_66M_MCK,
 	.muxes_offs = CLK_INFRA_UART0_SEL,
 	.gates_offs = CLK_INFRA_GPT_STA,

-- 
2.43.0

