Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE804FCA19E
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 22:51:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0685A83F2A;
	Mon,  9 Mar 2026 23:51:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wzQpXsGv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E550183F8A; Mon,  9 Mar 2026 23:51:44 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CC1A83CF3
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 23:51:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-466f00535cfso1649983b6e.1
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 15:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773096700; x=1773701500;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eH6B4ikeR7COtLwhlWPZHoJcBFERNvU1JlNnUxyJAfE=;
 b=wzQpXsGvgr45IYggUqLnjIFoMDWwSOlAEcJvJjMkxsuf2H3XTEyNEF85MRkbVS4Kjv
 ubXLRKcIMnsAS+/89eUH9RpXRgaeMqVH8yvVt2gG5Ok1a9NjRHnAbwCJSWl1EBgcnEI9
 YU8HkLij4GYojcIegrn/kDyul4v6FoD7mzsg7WxlNKjf3HhvzuEiaC0KMZGFck1srqc8
 CY0jTdOLNwMn7g/Yyhlv0eGB/VdDzamKq8ixzm8weJ7teYoskxldjJRcPnGKkpBLqj/c
 lTwR57zY//d+ayd2HTEOmljm7AbfFfSIg5dKvCQNEc3bz/z8AIOKL9nzg6IcqdEH6658
 b6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773096700; x=1773701500;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eH6B4ikeR7COtLwhlWPZHoJcBFERNvU1JlNnUxyJAfE=;
 b=cadR5T8xH516UbLFs3SjodHq36T4FzkthLeG/wniuo7TxBSautiCxypi7qWZHNYlGk
 LyMQofDgkEzPxED8uQAomQKWb9rctacRRKat71GiNpESs5xStDA9J25oJ6X8y1tswJyY
 SOVhJA/zkjRuNfYGaZAc+jya1AqvIv0erQY0CIQfrZrYlZaD+ab+xk5z8k9AF77LhLPR
 YXmW6wrY0eCirhFx7BNkEMOyFBOWj+l7skKYq6O5Q/UKwnJYn5WhjcFm2WByJSMkJOyd
 2IWdH36cCG4eOmgtlA8dn5QzRwG7JQkVevfPG4V75Lcznmfrh4wMqwcyINLjuxXpWzH8
 aRNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzcC55YTAkTyrVRNh3g62yQj7spKwAAyTcFzFxvdT8S14nd8v9jiIM56KjKmKz24WC4wD3al0=@lists.denx.de
X-Gm-Message-State: AOJu0YwCgQ6IRkl9lPuY7TehnbZtOaQqFAOH+o95U0rNLFAu7Hd9UJqD
 Aw++UlMVxZdnsF3x8hPq4q9O6yNoavbh8jtm7doJgq26W7u/tkPTjgXs/0WNHaQLAxg=
X-Gm-Gg: ATEYQzyhTncF/pTLuQXhtu8bY3R5q1mZknQyMvwRfTNGZt8O9NpGz1LKNs7u+e2MXwl
 m5TQ3xa6HdizEvVdEgF1KGL7qUjhGq+IP4OoiF2qNziYbVxl9snVqVtdnoNnAaDbYXH/2Lk9xLr
 FTv5hvzTobtyof3WIjDj3WLOLsWDrCCRWJ4xFFrFSgacenWOCsBtA+Ns1H0Q6Eo1bO2czdnd/o5
 VG31Hh/ozAZY7o2OGTIe8U3EjAaY70aJWEhwUzYQVGjnruWjHZbfqUhreDaIizhwX+ewBKIq2DD
 Z6VbNinwikZglkFPY1Je2d/0Wd6u+d/3ASoKU3t43ySyMMPVR8YP9kh5Sma8OMus6Yk5xCMm6kw
 yOWH4mVczOXwHlwVwlyVqAag905BGkgSa/CAhhRkAKn/zt2Ps5OtchFxAILaky6PwWzYTiGYpLZ
 2f8Ggf0Kh7FzDS8la77SbTgJeu95hJ
X-Received: by 2002:a05:6808:2516:b0:467:1633:a1c3 with SMTP id
 5614622812f47-46716343491mr1388808b6e.12.1773096699978; 
 Mon, 09 Mar 2026 15:51:39 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:78e2:51e2:14b8:2e10])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-466dfac3adcsm6150626b6e.17.2026.03.09.15.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 15:51:38 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 09 Mar 2026 17:51:10 -0500
Subject: [PATCH 1/2] clk: mediatek: mt8188: use ext_clock_rates
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-clk-mtk-mt8188-drop-extra-top-clocks-v1-1-6ee4743a8465@baylibre.com>
References: <20260309-clk-mtk-mt8188-drop-extra-top-clocks-v1-0-6ee4743a8465@baylibre.com>
In-Reply-To: <20260309-clk-mtk-mt8188-drop-extra-top-clocks-v1-0-6ee4743a8465@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=51705;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=HkERVvDmE5V5x6pML1mMSliUAvqDi93tr/5iPUx4fkU=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpr07rb+qRmBprREQokALnwyNkelTolASJ/pQiL
 MJ4cA1/k5qJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaa9O6xYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AuAcIAJNqeX+bkZylm8svXmgBIIJ7nRqw68HgtXWXQd1
 aZpA+Wi9zdEnTKA7cEzL4XrhO436OMm7mr4IURhTO8vHuNdDZBEpgRf3eTM4pctwDSw+Zh+dKmp
 OiFJ1xwigE6s6bRwKb4lRB//6Xb8C+SD4Yuae3hSmo2cU/S0Pj7nCcAV2VnaRuKfCGuCh5ZLudY
 7hfCW4zy2nAsB4KOrlQexpaDYYCYZayLEGj8RfsoibRVV/iFcQT8KmKvR35VQaLuRGqYKRUBH//
 FPVLKxbKa8OlzZadjL0UMgrBBo/sR8Fkkr4sl5HGfmCnTEy7A+FwpoXBYUTTc7YgnhNj1MUrJdY
 +AXo=
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

Convert the mt8188 clock driver to use ext_clock_rates.

Now that we have the ext_clock_rates feature and also mux clock parents
have been converted to struct mtk_parent, we can remove the hack of
adding "missing" topckgen clocks. Instead we can use the proper parents.

The topckgen ID map is still needed though because the upstream
dt-bindings didn't use the conventional number ordering by clock type
for these.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8188.c | 741 ++++++++++++++++++++------------------
 1 file changed, 399 insertions(+), 342 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8188.c b/drivers/clk/mediatek/clk-mt8188.c
index 706390b6c6c..e4297c92bd9 100644
--- a/drivers/clk/mediatek/clk-mt8188.c
+++ b/drivers/clk/mediatek/clk-mt8188.c
@@ -19,14 +19,17 @@
 #define MT8188_PLL_FMAX		(3800UL * MHZ)
 #define MT8188_PLL_FMIN		(1500UL * MHZ)
 
-/* Missing topckgen clocks definition in dt-bindings */
-#define CLK_TOP_ADSPPLL		CLK_TOP_NR_CLK
-#define CLK_TOP_CLK13M		CLK_TOP_NR_CLK + 1
-#define CLK_TOP_CLK26M		CLK_TOP_NR_CLK + 2
-#define CLK_TOP_CLK32K		CLK_TOP_NR_CLK + 3
-#define CLK_TOP_IMGPLL		CLK_TOP_NR_CLK + 4
-#define CLK_TOP_MSDCPLL		CLK_TOP_NR_CLK + 5
-#define CLK_TOP_FULL_NR_CLK	CLK_TOP_NR_CLK + 6
+enum {
+	CLK_PAD_CLK32K,
+	CLK_PAD_CLK26M,
+	CLK_PAD_CLK13M,
+};
+
+static const ulong ext_clock_rates[] = {
+	[CLK_PAD_CLK32K] = 32000,
+	[CLK_PAD_CLK26M] = 26 * MHZ,
+	[CLK_PAD_CLK13M] = 13 * MHZ,
+};
 
 /* apmixedsys */
 #define PLL(_id, _reg, _pwr_reg, _en_mask, _flags, _pcwbits, _pd_reg,	\
@@ -83,6 +86,8 @@ static const struct mtk_pll_data apmixed_plls[] = {
 static const struct mtk_clk_tree mt8188_apmixedsys_clk_tree = {
 	.xtal_rate = 26 * MHZ,
 	.xtal2_rate = 26 * MHZ,
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.plls = apmixed_plls,
 	.num_plls = ARRAY_SIZE(apmixed_plls),
 };
@@ -97,9 +102,6 @@ static const struct mtk_fixed_clk top_fixed_clks[] = {
 	FIXED_CLK0(CLK_TOP_466M_FMEM, 533000000),
 	FIXED_CLK0(CLK_TOP_PEXTP_PIPE, 250000000),
 	FIXED_CLK0(CLK_TOP_DSI_PHY, 500000000),
-	FIXED_CLK0(CLK_TOP_CLK13M, 13000000),
-	FIXED_CLK0(CLK_TOP_CLK26M, 26000000),
-	FIXED_CLK0(CLK_TOP_CLK32K, 32000),
 };
 
 #define FACTOR0(_id, _parent, _mult, _div)	\
@@ -172,7 +174,6 @@ static const struct mtk_fixed_factor top_fixed_divs[] = {
 	FACTOR0(CLK_TOP_TVDPLL2_D4, CLK_APMIXED_TVDPLL2, 1, 4),
 	FACTOR0(CLK_TOP_TVDPLL2_D8, CLK_APMIXED_TVDPLL2, 1, 8),
 	FACTOR0(CLK_TOP_TVDPLL2_D16, CLK_APMIXED_TVDPLL2, 1, 16),
-	FACTOR0(CLK_TOP_MSDCPLL, CLK_APMIXED_MSDCPLL, 1, 1),
 	FACTOR0(CLK_TOP_MSDCPLL_D2, CLK_APMIXED_MSDCPLL, 1, 2),
 	FACTOR0(CLK_TOP_MSDCPLL_D16, CLK_APMIXED_MSDCPLL, 1, 16),
 	FACTOR0(CLK_TOP_ETHPLL_D2, CLK_APMIXED_ETHPLL, 1, 2),
@@ -191,7 +192,7 @@ static const struct mtk_fixed_factor top_fixed_divs[] = {
 };
 
 static const struct mtk_parent axi_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
 	TOP_PARENT(CLK_TOP_MAINPLL_D7_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
@@ -201,14 +202,14 @@ static const struct mtk_parent axi_parents[] = {
 };
 
 static const struct mtk_parent spm_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_ULPOSC1_D10),
 	TOP_PARENT(CLK_TOP_MAINPLL_D7_D4),
-	TOP_PARENT(CLK_TOP_CLK32K),
+	EXT_PARENT(CLK_PAD_CLK32K),
 };
 
 static const struct mtk_parent scp_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
 	TOP_PARENT(CLK_TOP_MAINPLL_D6),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
@@ -219,7 +220,7 @@ static const struct mtk_parent scp_parents[] = {
 };
 
 static const struct mtk_parent bus_aximem_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MAINPLL_D7_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
@@ -227,7 +228,7 @@ static const struct mtk_parent bus_aximem_parents[] = {
 };
 
 static const struct mtk_parent vpp_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
 	TOP_PARENT(CLK_TOP_MMPLL_D6_D2),
@@ -245,7 +246,7 @@ static const struct mtk_parent vpp_parents[] = {
 };
 
 static const struct mtk_parent ethdr_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
 	TOP_PARENT(CLK_TOP_MMPLL_D6_D2),
@@ -263,8 +264,8 @@ static const struct mtk_parent ethdr_parents[] = {
 };
 
 static const struct mtk_parent ipe_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
-	TOP_PARENT(CLK_TOP_IMGPLL),
+	EXT_PARENT(CLK_PAD_CLK26M),
+	APMIXED_PARENT(CLK_APMIXED_IMGPLL),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4),
 	TOP_PARENT(CLK_TOP_MMPLL_D6),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
@@ -278,7 +279,7 @@ static const struct mtk_parent ipe_parents[] = {
 };
 
 static const struct mtk_parent cam_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_TVDPLL1),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4),
 	TOP_PARENT(CLK_TOP_MMPLL_D4),
@@ -288,11 +289,11 @@ static const struct mtk_parent cam_parents[] = {
 	TOP_PARENT(CLK_TOP_MMPLL_D7),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
-	TOP_PARENT(CLK_TOP_IMGPLL),
+	APMIXED_PARENT(CLK_APMIXED_IMGPLL),
 };
 
 static const struct mtk_parent ccu_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4),
@@ -305,7 +306,7 @@ static const struct mtk_parent ccu_parents[] = {
 };
 
 static const struct mtk_parent ccu_ahb_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4),
@@ -318,8 +319,8 @@ static const struct mtk_parent ccu_ahb_parents[] = {
 };
 
 static const struct mtk_parent img_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
-	TOP_PARENT(CLK_TOP_IMGPLL),
+	EXT_PARENT(CLK_PAD_CLK26M),
+	APMIXED_PARENT(CLK_APMIXED_IMGPLL),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
@@ -334,14 +335,14 @@ static const struct mtk_parent img_parents[] = {
 };
 
 static const struct mtk_parent camtm_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
 };
 
 static const struct mtk_parent dsp_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
@@ -352,7 +353,7 @@ static const struct mtk_parent dsp_parents[] = {
 };
 
 static const struct mtk_parent dsp1_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
@@ -363,7 +364,7 @@ static const struct mtk_parent dsp1_parents[] = {
 };
 
 static const struct mtk_parent dsp2_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
@@ -374,7 +375,7 @@ static const struct mtk_parent dsp2_parents[] = {
 };
 
 static const struct mtk_parent dsp3_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
@@ -385,7 +386,7 @@ static const struct mtk_parent dsp3_parents[] = {
 };
 
 static const struct mtk_parent dsp4_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4),
@@ -396,7 +397,7 @@ static const struct mtk_parent dsp4_parents[] = {
 };
 
 static const struct mtk_parent dsp5_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4),
@@ -407,7 +408,7 @@ static const struct mtk_parent dsp5_parents[] = {
 };
 
 static const struct mtk_parent dsp6_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4),
@@ -418,7 +419,7 @@ static const struct mtk_parent dsp6_parents[] = {
 };
 
 static const struct mtk_parent dsp7_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
@@ -429,52 +430,52 @@ static const struct mtk_parent dsp7_parents[] = {
 };
 
 static const struct mtk_parent mfg_core_tmp_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D7),
 };
 
 static const struct mtk_parent camtg_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_192M_D8),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D8),
 	TOP_PARENT(CLK_TOP_UNIVPLL_192M_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL_192M_D10),
-	TOP_PARENT(CLK_TOP_CLK13M),
+	EXT_PARENT(CLK_PAD_CLK13M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_192M_D16),
 	TOP_PARENT(CLK_TOP_UNIVPLL_192M_D32),
 };
 
 static const struct mtk_parent camtg2_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_192M_D8),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D8),
 	TOP_PARENT(CLK_TOP_UNIVPLL_192M_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL_192M_D10),
-	TOP_PARENT(CLK_TOP_CLK13M),
+	EXT_PARENT(CLK_PAD_CLK13M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_192M_D16),
 	TOP_PARENT(CLK_TOP_UNIVPLL_192M_D32),
 };
 
 static const struct mtk_parent camtg3_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_192M_D8),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D8),
 	TOP_PARENT(CLK_TOP_UNIVPLL_192M_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL_192M_D10),
-	TOP_PARENT(CLK_TOP_CLK13M),
+	EXT_PARENT(CLK_PAD_CLK13M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_192M_D16),
 	TOP_PARENT(CLK_TOP_UNIVPLL_192M_D32),
 };
 
 static const struct mtk_parent uart_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D8),
 };
 
 static const struct mtk_parent spi_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MAINPLL_D5_D4),
 	TOP_PARENT(CLK_TOP_MAINPLL_D6_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
@@ -485,14 +486,14 @@ static const struct mtk_parent spi_parents[] = {
 };
 
 static const struct mtk_parent msdc5hclk_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
 };
 
 static const struct mtk_parent msdc50_0_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
-	TOP_PARENT(CLK_TOP_MSDCPLL),
+	EXT_PARENT(CLK_PAD_CLK26M),
+	APMIXED_PARENT(CLK_APMIXED_MSDCPLL),
 	TOP_PARENT(CLK_TOP_MSDCPLL_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D4),
 	TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
@@ -500,7 +501,7 @@ static const struct mtk_parent msdc50_0_parents[] = {
 };
 
 static const struct mtk_parent msdc30_1_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D7_D2),
@@ -508,7 +509,7 @@ static const struct mtk_parent msdc30_1_parents[] = {
 };
 
 static const struct mtk_parent msdc30_2_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D7_D2),
@@ -516,27 +517,27 @@ static const struct mtk_parent msdc30_2_parents[] = {
 };
 
 static const struct mtk_parent intdir_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
 };
 
 static const struct mtk_parent aud_intbus_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
 	TOP_PARENT(CLK_TOP_MAINPLL_D7_D4),
 };
 
 static const struct mtk_parent audio_h_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D7),
 	TOP_PARENT(CLK_TOP_APLL1),
 	TOP_PARENT(CLK_TOP_APLL2),
 };
 
 static const struct mtk_parent pwrap_ulposc_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_ULPOSC1_D10),
 	TOP_PARENT(CLK_TOP_ULPOSC1_D7),
 	TOP_PARENT(CLK_TOP_ULPOSC1_D8),
@@ -547,13 +548,13 @@ static const struct mtk_parent pwrap_ulposc_parents[] = {
 };
 
 static const struct mtk_parent atb_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
 };
 
 static const struct mtk_parent sspm_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MAINPLL_D7_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
@@ -567,7 +568,7 @@ static const struct mtk_parent sspm_parents[] = {
  * in dual output case, which would lead to corruption of functionality loss.
  */
 static const struct mtk_parent dp_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_TVDPLL2_D2),
 	TOP_PARENT(CLK_TOP_TVDPLL2_D4),
 	TOP_PARENT(CLK_TOP_TVDPLL2_D8),
@@ -575,7 +576,7 @@ static const struct mtk_parent dp_parents[] = {
 };
 
 static const struct mtk_parent edp_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_TVDPLL1_D2),
 	TOP_PARENT(CLK_TOP_TVDPLL1_D4),
 	TOP_PARENT(CLK_TOP_TVDPLL1_D8),
@@ -583,7 +584,7 @@ static const struct mtk_parent edp_parents[] = {
 };
 
 static const struct mtk_parent dpi_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_TVDPLL1_D2),
 	TOP_PARENT(CLK_TOP_TVDPLL2_D2),
 	TOP_PARENT(CLK_TOP_TVDPLL1_D4),
@@ -595,7 +596,7 @@ static const struct mtk_parent dpi_parents[] = {
 };
 
 static const struct mtk_parent disp_pwm0_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
 	TOP_PARENT(CLK_TOP_ULPOSC1_D2),
 	TOP_PARENT(CLK_TOP_ULPOSC1_D4),
@@ -604,7 +605,7 @@ static const struct mtk_parent disp_pwm0_parents[] = {
 };
 
 static const struct mtk_parent disp_pwm1_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
 	TOP_PARENT(CLK_TOP_ULPOSC1_D2),
 	TOP_PARENT(CLK_TOP_ULPOSC1_D4),
@@ -612,55 +613,55 @@ static const struct mtk_parent disp_pwm1_parents[] = {
 };
 
 static const struct mtk_parent usb_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D2),
 };
 
 static const struct mtk_parent ssusb_xhci_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D2),
 };
 
 static const struct mtk_parent usb_2p_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D2),
 };
 
 static const struct mtk_parent ssusb_xhci_2p_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D2),
 };
 
 static const struct mtk_parent usb_3p_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D2),
 };
 
 static const struct mtk_parent ssusb_xhci_3p_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D2),
 };
 
 static const struct mtk_parent i2c_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4_D8),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
 };
 
 static const struct mtk_parent seninf_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
@@ -671,7 +672,7 @@ static const struct mtk_parent seninf_parents[] = {
 };
 
 static const struct mtk_parent seninf1_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
@@ -682,7 +683,7 @@ static const struct mtk_parent seninf1_parents[] = {
 };
 
 static const struct mtk_parent gcpu_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MAINPLL_D6),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
 	TOP_PARENT(CLK_TOP_MMPLL_D5_D2),
@@ -690,7 +691,7 @@ static const struct mtk_parent gcpu_parents[] = {
 };
 
 static const struct mtk_parent venc_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MMPLL_D4_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D6),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
@@ -709,7 +710,7 @@ static const struct mtk_parent venc_parents[] = {
 };
 
 static const struct mtk_parent vdec_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
 	TOP_PARENT(CLK_TOP_MMPLL_D6_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D2),
@@ -722,65 +723,65 @@ static const struct mtk_parent vdec_parents[] = {
 	TOP_PARENT(CLK_TOP_MAINPLL_D4),
 	TOP_PARENT(CLK_TOP_TVDPLL2),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
-	TOP_PARENT(CLK_TOP_IMGPLL),
+	APMIXED_PARENT(CLK_APMIXED_IMGPLL),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
 	TOP_PARENT(CLK_TOP_MMPLL_D9),
 };
 
 static const struct mtk_parent pwm_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK32K),
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK32K),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D8),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
 };
 
 static const struct mtk_parent mcupm_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D7_D4),
 };
 
 static const struct mtk_parent spmi_p_mst_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
-	TOP_PARENT(CLK_TOP_CLK13M),
+	EXT_PARENT(CLK_PAD_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK13M),
 	TOP_PARENT(CLK_TOP_ULPOSC1_D8),
 	TOP_PARENT(CLK_TOP_ULPOSC1_D10),
 	TOP_PARENT(CLK_TOP_ULPOSC1_D16),
 	TOP_PARENT(CLK_TOP_ULPOSC1_D7),
-	TOP_PARENT(CLK_TOP_CLK32K),
+	EXT_PARENT(CLK_PAD_CLK32K),
 	TOP_PARENT(CLK_TOP_MAINPLL_D7_D8),
 	TOP_PARENT(CLK_TOP_MAINPLL_D6_D8),
 	TOP_PARENT(CLK_TOP_MAINPLL_D5_D8),
 };
 
 static const struct mtk_parent spmi_m_mst_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
-	TOP_PARENT(CLK_TOP_CLK13M),
+	EXT_PARENT(CLK_PAD_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK13M),
 	TOP_PARENT(CLK_TOP_ULPOSC1_D8),
 	TOP_PARENT(CLK_TOP_ULPOSC1_D10),
 	TOP_PARENT(CLK_TOP_ULPOSC1_D16),
 	TOP_PARENT(CLK_TOP_ULPOSC1_D7),
-	TOP_PARENT(CLK_TOP_CLK32K),
+	EXT_PARENT(CLK_PAD_CLK32K),
 	TOP_PARENT(CLK_TOP_MAINPLL_D7_D8),
 	TOP_PARENT(CLK_TOP_MAINPLL_D6_D8),
 	TOP_PARENT(CLK_TOP_MAINPLL_D5_D8),
 };
 
 static const struct mtk_parent dvfsrc_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_ULPOSC1_D10),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D8),
 	TOP_PARENT(CLK_TOP_MSDCPLL_D16),
 };
 
 static const struct mtk_parent tl_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
 };
 
 static const struct mtk_parent aes_msdcfde_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D6),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
@@ -789,14 +790,14 @@ static const struct mtk_parent aes_msdcfde_parents[] = {
 };
 
 static const struct mtk_parent dsi_occ_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
 };
 
 static const struct mtk_parent wpe_vpp_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
 	TOP_PARENT(CLK_TOP_MMPLL_D6_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D2),
@@ -814,60 +815,60 @@ static const struct mtk_parent wpe_vpp_parents[] = {
 };
 
 static const struct mtk_parent hdcp_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D8),
 	TOP_PARENT(CLK_TOP_MAINPLL_D5_D8),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
 };
 
 static const struct mtk_parent hdcp_24m_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_192M_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL_192M_D8),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D8),
 };
 
 static const struct mtk_parent hdmi_apb_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
 	TOP_PARENT(CLK_TOP_MSDCPLL_D2),
 };
 
 static const struct mtk_parent snps_eth_250m_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_ETHPLL_D2),
 };
 
 static const struct mtk_parent snps_eth_62p4m_ptp_parents[] = {
 	TOP_PARENT(CLK_TOP_APLL2_D3),
 	TOP_PARENT(CLK_TOP_APLL1_D3),
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_ETHPLL_D8),
 };
 
 static const struct mtk_parent snps_eth_50m_rmii_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_ETHPLL_D10),
 };
 
 static const struct mtk_parent adsp_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
-	TOP_PARENT(CLK_TOP_CLK13M),
+	EXT_PARENT(CLK_PAD_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK13M),
 	TOP_PARENT(CLK_TOP_MAINPLL_D6),
 	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
 	TOP_PARENT(CLK_TOP_ULPOSC1_D2),
 	TOP_PARENT(CLK_TOP_ULPOSC1),
-	TOP_PARENT(CLK_TOP_ADSPPLL),
+	APMIXED_PARENT(CLK_APMIXED_ADSPPLL),
 	TOP_PARENT(CLK_TOP_ADSPPLL_D2),
 	TOP_PARENT(CLK_TOP_ADSPPLL_D4),
 	TOP_PARENT(CLK_TOP_ADSPPLL_D8),
 };
 
 static const struct mtk_parent audio_local_bus_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
-	TOP_PARENT(CLK_TOP_CLK13M),
+	EXT_PARENT(CLK_PAD_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK13M),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
 	TOP_PARENT(CLK_TOP_MAINPLL_D7_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
@@ -881,46 +882,46 @@ static const struct mtk_parent audio_local_bus_parents[] = {
 };
 
 static const struct mtk_parent asm_h_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
 };
 
 static const struct mtk_parent asm_l_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
 };
 
 static const struct mtk_parent apll1_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_APLL1_D4),
 };
 
 static const struct mtk_parent apll2_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_APLL2_D4),
 };
 
 static const struct mtk_parent apll3_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_APLL3_D4),
 };
 
 static const struct mtk_parent apll4_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_APLL4_D4),
 };
 
 static const struct mtk_parent apll5_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_APLL5_D4),
 };
 
 static const struct mtk_parent i2so1_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_APLL1),
 	TOP_PARENT(CLK_TOP_APLL2),
 	TOP_PARENT(CLK_TOP_APLL3),
@@ -929,7 +930,7 @@ static const struct mtk_parent i2so1_parents[] = {
 };
 
 static const struct mtk_parent i2so2_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_APLL1),
 	TOP_PARENT(CLK_TOP_APLL2),
 	TOP_PARENT(CLK_TOP_APLL3),
@@ -938,7 +939,7 @@ static const struct mtk_parent i2so2_parents[] = {
 };
 
 static const struct mtk_parent i2si1_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_APLL1),
 	TOP_PARENT(CLK_TOP_APLL2),
 	TOP_PARENT(CLK_TOP_APLL3),
@@ -947,7 +948,7 @@ static const struct mtk_parent i2si1_parents[] = {
 };
 
 static const struct mtk_parent i2si2_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_APLL1),
 	TOP_PARENT(CLK_TOP_APLL2),
 	TOP_PARENT(CLK_TOP_APLL3),
@@ -956,7 +957,7 @@ static const struct mtk_parent i2si2_parents[] = {
 };
 
 static const struct mtk_parent dptx_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_APLL1),
 	TOP_PARENT(CLK_TOP_APLL2),
 	TOP_PARENT(CLK_TOP_APLL3),
@@ -965,7 +966,7 @@ static const struct mtk_parent dptx_parents[] = {
 };
 
 static const struct mtk_parent aud_iec_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_APLL1),
 	TOP_PARENT(CLK_TOP_APLL2),
 	TOP_PARENT(CLK_TOP_APLL3),
@@ -974,31 +975,31 @@ static const struct mtk_parent aud_iec_parents[] = {
 };
 
 static const struct mtk_parent a1sys_hp_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_APLL1_D4),
 };
 
 static const struct mtk_parent a2sys_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_APLL2_D4),
 };
 
 static const struct mtk_parent a3sys_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_APLL3_D4),
 	TOP_PARENT(CLK_TOP_APLL4_D4),
 	TOP_PARENT(CLK_TOP_APLL5_D4),
 };
 
 static const struct mtk_parent a4sys_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_APLL3_D4),
 	TOP_PARENT(CLK_TOP_APLL4_D4),
 	TOP_PARENT(CLK_TOP_APLL5_D4),
 };
 
 static const struct mtk_parent ecc_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
 	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
 	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
@@ -1007,8 +1008,8 @@ static const struct mtk_parent ecc_parents[] = {
 };
 
 static const struct mtk_parent spinor_parents[] = {
-	TOP_PARENT(CLK_TOP_CLK26M),
-	TOP_PARENT(CLK_TOP_CLK13M),
+	EXT_PARENT(CLK_PAD_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK13M),
 	TOP_PARENT(CLK_TOP_MAINPLL_D7_D8),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D8),
 };
@@ -1022,7 +1023,7 @@ static const struct mtk_parent ulposc_parents[] = {
 
 static const struct mtk_parent srck_parents[] = {
 	TOP_PARENT(CLK_TOP_ULPOSC1_D10),
-	TOP_PARENT(CLK_TOP_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 };
 
 static const struct mtk_composite top_muxes[] = {
@@ -1143,7 +1144,7 @@ static const struct mtk_composite top_muxes[] = {
 };
 
 static const int mt8188_id_top_offs_map[] = {
-	[0 ... CLK_TOP_FULL_NR_CLK - 1] = -1,
+	[0 ... CLK_TOP_NR_CLK - 1] = -1,
 	/* FIXED */
 	[CLK_TOP_ULPOSC1] = 0,
 	[CLK_TOP_MPHONE_SLAVE_BCK] = 1,
@@ -1151,202 +1152,198 @@ static const int mt8188_id_top_offs_map[] = {
 	[CLK_TOP_466M_FMEM] = 3,
 	[CLK_TOP_PEXTP_PIPE] = 4,
 	[CLK_TOP_DSI_PHY] = 5,
-	[CLK_TOP_CLK13M] = 6,
-	[CLK_TOP_CLK26M] = 7,
-	[CLK_TOP_CLK32K] = 8,
 	/* FACTOR */
-	[CLK_TOP_MAINPLL_D3] = 9,
-	[CLK_TOP_MAINPLL_D4] = 10,
-	[CLK_TOP_MAINPLL_D4_D2] = 11,
-	[CLK_TOP_MAINPLL_D4_D4] = 12,
-	[CLK_TOP_MAINPLL_D4_D8] = 13,
-	[CLK_TOP_MAINPLL_D5] = 14,
-	[CLK_TOP_MAINPLL_D5_D2] = 15,
-	[CLK_TOP_MAINPLL_D5_D4] = 16,
-	[CLK_TOP_MAINPLL_D5_D8] = 17,
-	[CLK_TOP_MAINPLL_D6] = 18,
-	[CLK_TOP_MAINPLL_D6_D2] = 19,
-	[CLK_TOP_MAINPLL_D6_D4] = 20,
-	[CLK_TOP_MAINPLL_D6_D8] = 21,
-	[CLK_TOP_MAINPLL_D7] = 22,
-	[CLK_TOP_MAINPLL_D7_D2] = 23,
-	[CLK_TOP_MAINPLL_D7_D4] = 24,
-	[CLK_TOP_MAINPLL_D7_D8] = 25,
-	[CLK_TOP_MAINPLL_D9] = 26,
-	[CLK_TOP_UNIVPLL_D2] = 27,
-	[CLK_TOP_UNIVPLL_D3] = 28,
-	[CLK_TOP_UNIVPLL_D4] = 29,
-	[CLK_TOP_UNIVPLL_D4_D2] = 30,
-	[CLK_TOP_UNIVPLL_D4_D4] = 31,
-	[CLK_TOP_UNIVPLL_D4_D8] = 32,
-	[CLK_TOP_UNIVPLL_D5] = 33,
-	[CLK_TOP_UNIVPLL_D5_D2] = 34,
-	[CLK_TOP_UNIVPLL_D5_D4] = 35,
-	[CLK_TOP_UNIVPLL_D5_D8] = 36,
-	[CLK_TOP_UNIVPLL_D6] = 37,
-	[CLK_TOP_UNIVPLL_D6_D2] = 38,
-	[CLK_TOP_UNIVPLL_D6_D4] = 39,
-	[CLK_TOP_UNIVPLL_D6_D8] = 40,
-	[CLK_TOP_UNIVPLL_D7] = 41,
-	[CLK_TOP_UNIVPLL_192M] = 42,
-	[CLK_TOP_UNIVPLL_192M_D4] = 43,
-	[CLK_TOP_UNIVPLL_192M_D8] = 44,
-	[CLK_TOP_UNIVPLL_192M_D10] = 45,
-	[CLK_TOP_UNIVPLL_192M_D16] = 46,
-	[CLK_TOP_UNIVPLL_192M_D32] = 47,
-	[CLK_TOP_APLL1_D3] = 48,
-	[CLK_TOP_APLL1_D4] = 49,
-	[CLK_TOP_APLL2_D3] = 50,
-	[CLK_TOP_APLL2_D4] = 51,
-	[CLK_TOP_APLL3_D4] = 52,
-	[CLK_TOP_APLL4_D4] = 53,
-	[CLK_TOP_APLL5_D4] = 54,
-	[CLK_TOP_MMPLL_D4] = 55,
-	[CLK_TOP_MMPLL_D4_D2] = 56,
-	[CLK_TOP_MMPLL_D5] = 57,
-	[CLK_TOP_MMPLL_D5_D2] = 58,
-	[CLK_TOP_MMPLL_D5_D4] = 59,
-	[CLK_TOP_MMPLL_D6] = 60,
-	[CLK_TOP_MMPLL_D6_D2] = 61,
-	[CLK_TOP_MMPLL_D7] = 62,
-	[CLK_TOP_MMPLL_D9] = 62,
-	[CLK_TOP_TVDPLL1_D2] = 64,
-	[CLK_TOP_TVDPLL1_D4] = 65,
-	[CLK_TOP_TVDPLL1_D8] = 66,
-	[CLK_TOP_TVDPLL1_D16] = 67,
-	[CLK_TOP_TVDPLL2_D2] = 68,
-	[CLK_TOP_TVDPLL2_D4] = 69,
-	[CLK_TOP_TVDPLL2_D8] = 70,
-	[CLK_TOP_TVDPLL2_D16] = 71,
-	[CLK_TOP_MSDCPLL] = 72,
-	[CLK_TOP_MSDCPLL_D2] = 73,
-	[CLK_TOP_MSDCPLL_D16] = 74,
-	[CLK_TOP_ETHPLL_D2] = 75,
-	[CLK_TOP_ETHPLL_D4] = 76,
-	[CLK_TOP_ETHPLL_D8] = 77,
-	[CLK_TOP_ETHPLL_D10] = 78,
-	[CLK_TOP_ADSPPLL_D2] = 79,
-	[CLK_TOP_ADSPPLL_D4] = 80,
-	[CLK_TOP_ADSPPLL_D8] = 81,
-	[CLK_TOP_ULPOSC1_D2] = 82,
-	[CLK_TOP_ULPOSC1_D4] = 83,
-	[CLK_TOP_ULPOSC1_D8] = 84,
-	[CLK_TOP_ULPOSC1_D7] = 85,
-	[CLK_TOP_ULPOSC1_D10] = 86,
-	[CLK_TOP_ULPOSC1_D16] = 87,
+	[CLK_TOP_MAINPLL_D3] = 6,
+	[CLK_TOP_MAINPLL_D4] = 7,
+	[CLK_TOP_MAINPLL_D4_D2] = 8,
+	[CLK_TOP_MAINPLL_D4_D4] = 9,
+	[CLK_TOP_MAINPLL_D4_D8] = 10,
+	[CLK_TOP_MAINPLL_D5] = 11,
+	[CLK_TOP_MAINPLL_D5_D2] = 12,
+	[CLK_TOP_MAINPLL_D5_D4] = 13,
+	[CLK_TOP_MAINPLL_D5_D8] = 14,
+	[CLK_TOP_MAINPLL_D6] = 15,
+	[CLK_TOP_MAINPLL_D6_D2] = 16,
+	[CLK_TOP_MAINPLL_D6_D4] = 17,
+	[CLK_TOP_MAINPLL_D6_D8] = 18,
+	[CLK_TOP_MAINPLL_D7] = 19,
+	[CLK_TOP_MAINPLL_D7_D2] = 20,
+	[CLK_TOP_MAINPLL_D7_D4] = 21,
+	[CLK_TOP_MAINPLL_D7_D8] = 22,
+	[CLK_TOP_MAINPLL_D9] = 23,
+	[CLK_TOP_UNIVPLL_D2] = 24,
+	[CLK_TOP_UNIVPLL_D3] = 25,
+	[CLK_TOP_UNIVPLL_D4] = 26,
+	[CLK_TOP_UNIVPLL_D4_D2] = 27,
+	[CLK_TOP_UNIVPLL_D4_D4] = 28,
+	[CLK_TOP_UNIVPLL_D4_D8] = 29,
+	[CLK_TOP_UNIVPLL_D5] = 30,
+	[CLK_TOP_UNIVPLL_D5_D2] = 31,
+	[CLK_TOP_UNIVPLL_D5_D4] = 32,
+	[CLK_TOP_UNIVPLL_D5_D8] = 33,
+	[CLK_TOP_UNIVPLL_D6] = 34,
+	[CLK_TOP_UNIVPLL_D6_D2] = 35,
+	[CLK_TOP_UNIVPLL_D6_D4] = 36,
+	[CLK_TOP_UNIVPLL_D6_D8] = 37,
+	[CLK_TOP_UNIVPLL_D7] = 38,
+	[CLK_TOP_UNIVPLL_192M] = 39,
+	[CLK_TOP_UNIVPLL_192M_D4] = 40,
+	[CLK_TOP_UNIVPLL_192M_D8] = 41,
+	[CLK_TOP_UNIVPLL_192M_D10] = 42,
+	[CLK_TOP_UNIVPLL_192M_D16] = 43,
+	[CLK_TOP_UNIVPLL_192M_D32] = 44,
+	[CLK_TOP_APLL1_D3] = 45,
+	[CLK_TOP_APLL1_D4] = 46,
+	[CLK_TOP_APLL2_D3] = 47,
+	[CLK_TOP_APLL2_D4] = 48,
+	[CLK_TOP_APLL3_D4] = 49,
+	[CLK_TOP_APLL4_D4] = 50,
+	[CLK_TOP_APLL5_D4] = 51,
+	[CLK_TOP_MMPLL_D4] = 52,
+	[CLK_TOP_MMPLL_D4_D2] = 53,
+	[CLK_TOP_MMPLL_D5] = 54,
+	[CLK_TOP_MMPLL_D5_D2] = 55,
+	[CLK_TOP_MMPLL_D5_D4] = 56,
+	[CLK_TOP_MMPLL_D6] = 57,
+	[CLK_TOP_MMPLL_D6_D2] = 58,
+	[CLK_TOP_MMPLL_D7] = 59,
+	[CLK_TOP_MMPLL_D9] = 60,
+	[CLK_TOP_TVDPLL1_D2] = 61,
+	[CLK_TOP_TVDPLL1_D4] = 62,
+	[CLK_TOP_TVDPLL1_D8] = 63,
+	[CLK_TOP_TVDPLL1_D16] = 64,
+	[CLK_TOP_TVDPLL2_D2] = 65,
+	[CLK_TOP_TVDPLL2_D4] = 66,
+	[CLK_TOP_TVDPLL2_D8] = 67,
+	[CLK_TOP_TVDPLL2_D16] = 68,
+	[CLK_TOP_MSDCPLL_D2] = 69,
+	[CLK_TOP_MSDCPLL_D16] = 70,
+	[CLK_TOP_ETHPLL_D2] = 71,
+	[CLK_TOP_ETHPLL_D4] = 72,
+	[CLK_TOP_ETHPLL_D8] = 73,
+	[CLK_TOP_ETHPLL_D10] = 74,
+	[CLK_TOP_ADSPPLL_D2] = 75,
+	[CLK_TOP_ADSPPLL_D4] = 76,
+	[CLK_TOP_ADSPPLL_D8] = 77,
+	[CLK_TOP_ULPOSC1_D2] = 78,
+	[CLK_TOP_ULPOSC1_D4] = 79,
+	[CLK_TOP_ULPOSC1_D8] = 80,
+	[CLK_TOP_ULPOSC1_D7] = 81,
+	[CLK_TOP_ULPOSC1_D10] = 82,
+	[CLK_TOP_ULPOSC1_D16] = 83,
 	/* MUX */
-	[CLK_TOP_AXI] = 88,
-	[CLK_TOP_SPM] = 89,
-	[CLK_TOP_SCP] = 90,
-	[CLK_TOP_BUS_AXIMEM] = 91,
-	[CLK_TOP_VPP] = 92,
-	[CLK_TOP_ETHDR] = 93,
-	[CLK_TOP_IPE] = 94,
-	[CLK_TOP_CAM] = 95,
-	[CLK_TOP_CCU] = 96,
-	[CLK_TOP_CCU_AHB] = 97,
-	[CLK_TOP_IMG] = 98,
-	[CLK_TOP_CAMTM] = 99,
-	[CLK_TOP_DSP] = 100,
-	[CLK_TOP_DSP1] = 101,
-	[CLK_TOP_DSP2] = 102,
-	[CLK_TOP_DSP3] = 103,
-	[CLK_TOP_DSP4] = 104,
-	[CLK_TOP_DSP5] = 105,
-	[CLK_TOP_DSP6] = 106,
-	[CLK_TOP_DSP7] = 107,
-	[CLK_TOP_MFG_CORE_TMP] = 108,
-	[CLK_TOP_CAMTG] = 109,
-	[CLK_TOP_CAMTG2] = 110,
-	[CLK_TOP_CAMTG3] = 111,
-	[CLK_TOP_UART] = 112,
-	[CLK_TOP_SPI] = 113,
-	[CLK_TOP_MSDC50_0_HCLK] = 114,
-	[CLK_TOP_MSDC50_0] = 115,
-	[CLK_TOP_MSDC30_1] = 116,
-	[CLK_TOP_MSDC30_2] = 117,
-	[CLK_TOP_INTDIR] = 118,
-	[CLK_TOP_AUD_INTBUS] = 119,
-	[CLK_TOP_AUDIO_H] = 120,
-	[CLK_TOP_PWRAP_ULPOSC] = 121,
-	[CLK_TOP_ATB] = 122,
-	[CLK_TOP_SSPM] = 123,
-	[CLK_TOP_DP] = 124,
-	[CLK_TOP_EDP] = 125,
-	[CLK_TOP_DPI] = 126,
-	[CLK_TOP_DISP_PWM0] = 127,
-	[CLK_TOP_DISP_PWM1] = 128,
-	[CLK_TOP_USB_TOP] = 129,
-	[CLK_TOP_SSUSB_XHCI] = 130,
-	[CLK_TOP_USB_TOP_2P] = 131,
-	[CLK_TOP_SSUSB_XHCI_2P] = 132,
-	[CLK_TOP_USB_TOP_3P] = 133,
-	[CLK_TOP_SSUSB_XHCI_3P] = 134,
-	[CLK_TOP_I2C] = 135,
-	[CLK_TOP_SENINF] = 136,
-	[CLK_TOP_SENINF1] = 137,
-	[CLK_TOP_GCPU] = 138,
-	[CLK_TOP_VENC] = 139,
-	[CLK_TOP_VDEC] = 140,
-	[CLK_TOP_PWM] = 141,
-	[CLK_TOP_MCUPM] = 142,
-	[CLK_TOP_SPMI_P_MST] = 143,
-	[CLK_TOP_SPMI_M_MST] = 144,
-	[CLK_TOP_DVFSRC] = 145,
-	[CLK_TOP_TL] = 146,
-	[CLK_TOP_AES_MSDCFDE] = 147,
-	[CLK_TOP_DSI_OCC] = 148,
-	[CLK_TOP_WPE_VPP] = 149,
-	[CLK_TOP_HDCP] = 150,
-	[CLK_TOP_HDCP_24M] = 151,
-	[CLK_TOP_HDMI_APB] = 152,
-	[CLK_TOP_SNPS_ETH_250M] = 153,
-	[CLK_TOP_SNPS_ETH_62P4M_PTP] = 154,
-	[CLK_TOP_SNPS_ETH_50M_RMII] = 155,
-	[CLK_TOP_ADSP] = 156,
-	[CLK_TOP_AUDIO_LOCAL_BUS] = 157,
-	[CLK_TOP_ASM_H] = 158,
-	[CLK_TOP_ASM_L] = 159,
-	[CLK_TOP_APLL1] = 160,
-	[CLK_TOP_APLL2] = 161,
-	[CLK_TOP_APLL3] = 162,
-	[CLK_TOP_APLL4] = 163,
-	[CLK_TOP_APLL5] = 164,
-	[CLK_TOP_I2SO1] = 165,
-	[CLK_TOP_I2SO2] = 166,
-	[CLK_TOP_I2SI1] = 167,
-	[CLK_TOP_I2SI2] = 168,
-	[CLK_TOP_DPTX] = 169,
-	[CLK_TOP_AUD_IEC] = 170,
-	[CLK_TOP_A1SYS_HP] = 171,
-	[CLK_TOP_A2SYS] = 172,
-	[CLK_TOP_A3SYS] = 173,
-	[CLK_TOP_A4SYS] = 174,
-	[CLK_TOP_ECC] = 175,
-	[CLK_TOP_SPINOR] = 176,
-	[CLK_TOP_ULPOSC] = 177,
-	[CLK_TOP_SRCK] = 178,
+	[CLK_TOP_AXI] = 84,
+	[CLK_TOP_SPM] = 85,
+	[CLK_TOP_SCP] = 86,
+	[CLK_TOP_BUS_AXIMEM] = 87,
+	[CLK_TOP_VPP] = 88,
+	[CLK_TOP_ETHDR] = 89,
+	[CLK_TOP_IPE] = 90,
+	[CLK_TOP_CAM] = 91,
+	[CLK_TOP_CCU] = 92,
+	[CLK_TOP_CCU_AHB] = 93,
+	[CLK_TOP_IMG] = 94,
+	[CLK_TOP_CAMTM] = 95,
+	[CLK_TOP_DSP] = 96,
+	[CLK_TOP_DSP1] = 97,
+	[CLK_TOP_DSP2] = 98,
+	[CLK_TOP_DSP3] = 99,
+	[CLK_TOP_DSP4] = 100,
+	[CLK_TOP_DSP5] = 101,
+	[CLK_TOP_DSP6] = 102,
+	[CLK_TOP_DSP7] = 103,
+	[CLK_TOP_MFG_CORE_TMP] = 104,
+	[CLK_TOP_CAMTG] = 105,
+	[CLK_TOP_CAMTG2] = 106,
+	[CLK_TOP_CAMTG3] = 107,
+	[CLK_TOP_UART] = 108,
+	[CLK_TOP_SPI] = 109,
+	[CLK_TOP_MSDC50_0_HCLK] = 110,
+	[CLK_TOP_MSDC50_0] = 111,
+	[CLK_TOP_MSDC30_1] = 112,
+	[CLK_TOP_MSDC30_2] = 113,
+	[CLK_TOP_INTDIR] = 114,
+	[CLK_TOP_AUD_INTBUS] = 115,
+	[CLK_TOP_AUDIO_H] = 116,
+	[CLK_TOP_PWRAP_ULPOSC] = 117,
+	[CLK_TOP_ATB] = 118,
+	[CLK_TOP_SSPM] = 119,
+	[CLK_TOP_DP] = 120,
+	[CLK_TOP_EDP] = 121,
+	[CLK_TOP_DPI] = 122,
+	[CLK_TOP_DISP_PWM0] = 123,
+	[CLK_TOP_DISP_PWM1] = 124,
+	[CLK_TOP_USB_TOP] = 125,
+	[CLK_TOP_SSUSB_XHCI] = 126,
+	[CLK_TOP_USB_TOP_2P] = 127,
+	[CLK_TOP_SSUSB_XHCI_2P] = 128,
+	[CLK_TOP_USB_TOP_3P] = 129,
+	[CLK_TOP_SSUSB_XHCI_3P] = 130,
+	[CLK_TOP_I2C] = 131,
+	[CLK_TOP_SENINF] = 132,
+	[CLK_TOP_SENINF1] = 133,
+	[CLK_TOP_GCPU] = 134,
+	[CLK_TOP_VENC] = 135,
+	[CLK_TOP_VDEC] = 136,
+	[CLK_TOP_PWM] = 137,
+	[CLK_TOP_MCUPM] = 138,
+	[CLK_TOP_SPMI_P_MST] = 139,
+	[CLK_TOP_SPMI_M_MST] = 140,
+	[CLK_TOP_DVFSRC] = 141,
+	[CLK_TOP_TL] = 142,
+	[CLK_TOP_AES_MSDCFDE] = 143,
+	[CLK_TOP_DSI_OCC] = 144,
+	[CLK_TOP_WPE_VPP] = 145,
+	[CLK_TOP_HDCP] = 146,
+	[CLK_TOP_HDCP_24M] = 147,
+	[CLK_TOP_HDMI_APB] = 148,
+	[CLK_TOP_SNPS_ETH_250M] = 149,
+	[CLK_TOP_SNPS_ETH_62P4M_PTP] = 150,
+	[CLK_TOP_SNPS_ETH_50M_RMII] = 151,
+	[CLK_TOP_ADSP] = 152,
+	[CLK_TOP_AUDIO_LOCAL_BUS] = 153,
+	[CLK_TOP_ASM_H] = 154,
+	[CLK_TOP_ASM_L] = 155,
+	[CLK_TOP_APLL1] = 156,
+	[CLK_TOP_APLL2] = 157,
+	[CLK_TOP_APLL3] = 158,
+	[CLK_TOP_APLL4] = 159,
+	[CLK_TOP_APLL5] = 160,
+	[CLK_TOP_I2SO1] = 161,
+	[CLK_TOP_I2SO2] = 162,
+	[CLK_TOP_I2SI1] = 163,
+	[CLK_TOP_I2SI2] = 164,
+	[CLK_TOP_DPTX] = 165,
+	[CLK_TOP_AUD_IEC] = 166,
+	[CLK_TOP_A1SYS_HP] = 167,
+	[CLK_TOP_A2SYS] = 168,
+	[CLK_TOP_A3SYS] = 169,
+	[CLK_TOP_A4SYS] = 170,
+	[CLK_TOP_ECC] = 171,
+	[CLK_TOP_SPINOR] = 172,
+	[CLK_TOP_ULPOSC] = 173,
+	[CLK_TOP_SRCK] = 174,
 	/* GATE */
-	[CLK_TOP_CFGREG_CLOCK_EN_VPP0] = 179,
-	[CLK_TOP_CFGREG_CLOCK_EN_VPP1] = 180,
-	[CLK_TOP_CFGREG_CLOCK_EN_VDO0] = 181,
-	[CLK_TOP_CFGREG_CLOCK_EN_VDO1] = 182,
-	[CLK_TOP_CFGREG_CLOCK_ISP_AXI_GALS] = 183,
-	[CLK_TOP_CFGREG_F26M_VPP0] = 184,
-	[CLK_TOP_CFGREG_F26M_VPP1] = 185,
-	[CLK_TOP_CFGREG_F26M_VDO0] = 186,
-	[CLK_TOP_CFGREG_F26M_VDO1] = 187,
-	[CLK_TOP_CFGREG_AUD_F26M_AUD] = 188,
-	[CLK_TOP_CFGREG_UNIPLL_SES] = 189,
-	[CLK_TOP_CFGREG_F_PCIE_PHY_REF] = 190,
-	[CLK_TOP_SSUSB_TOP_REF] = 191,
-	[CLK_TOP_SSUSB_PHY_REF] = 192,
-	[CLK_TOP_SSUSB_TOP_P1_REF] = 193,
-	[CLK_TOP_SSUSB_PHY_P1_REF] = 194,
-	[CLK_TOP_SSUSB_TOP_P2_REF] = 195,
-	[CLK_TOP_SSUSB_PHY_P2_REF] = 196,
-	[CLK_TOP_SSUSB_TOP_P3_REF] = 197,
-	[CLK_TOP_SSUSB_PHY_P3_REF] = 198,
+	[CLK_TOP_CFGREG_CLOCK_EN_VPP0] = 175,
+	[CLK_TOP_CFGREG_CLOCK_EN_VPP1] = 176,
+	[CLK_TOP_CFGREG_CLOCK_EN_VDO0] = 177,
+	[CLK_TOP_CFGREG_CLOCK_EN_VDO1] = 178,
+	[CLK_TOP_CFGREG_CLOCK_ISP_AXI_GALS] = 179,
+	[CLK_TOP_CFGREG_F26M_VPP0] = 180,
+	[CLK_TOP_CFGREG_F26M_VPP1] = 181,
+	[CLK_TOP_CFGREG_F26M_VDO0] = 182,
+	[CLK_TOP_CFGREG_F26M_VDO1] = 183,
+	[CLK_TOP_CFGREG_AUD_F26M_AUD] = 184,
+	[CLK_TOP_CFGREG_UNIPLL_SES] = 185,
+	[CLK_TOP_CFGREG_F_PCIE_PHY_REF] = 186,
+	[CLK_TOP_SSUSB_TOP_REF] = 187,
+	[CLK_TOP_SSUSB_PHY_REF] = 188,
+	[CLK_TOP_SSUSB_TOP_P1_REF] = 189,
+	[CLK_TOP_SSUSB_PHY_P1_REF] = 190,
+	[CLK_TOP_SSUSB_TOP_P2_REF] = 191,
+	[CLK_TOP_SSUSB_PHY_P2_REF] = 192,
+	[CLK_TOP_SSUSB_TOP_P3_REF] = 193,
+	[CLK_TOP_SSUSB_PHY_P3_REF] = 194,
 };
 
 static const struct mtk_gate_regs top0_cg_regs = {
@@ -1369,12 +1366,20 @@ static const struct mtk_gate_regs top1_cg_regs = {
 		.flags = CLK_GATE_NO_SETCLR | CLK_PARENT_TOPCKGEN, \
 	}
 
+#define GATE_TOP0E(_id, _parent, _shift) {			   \
+		.id = _id,					   \
+		.parent = _parent,				   \
+		.regs = &top0_cg_regs,				   \
+		.shift = _shift,				   \
+		.flags = CLK_GATE_NO_SETCLR | CLK_PARENT_EXT,	   \
+	}
+
 #define GATE_TOP1(_id, _parent, _shift) {			       \
 		.id = _id,					       \
 		.parent = _parent,				       \
 		.regs = &top1_cg_regs,				       \
 		.shift = _shift,				       \
-		.flags = CLK_GATE_NO_SETCLR_INV | CLK_PARENT_TOPCKGEN, \
+		.flags = CLK_GATE_NO_SETCLR_INV | CLK_PARENT_EXT,      \
 	}
 
 static const struct mtk_gate topckgen_cg_clks[] = {
@@ -1384,26 +1389,28 @@ static const struct mtk_gate topckgen_cg_clks[] = {
 	GATE_TOP0(CLK_TOP_CFGREG_CLOCK_EN_VDO0, CLK_TOP_VPP, 2),
 	GATE_TOP0(CLK_TOP_CFGREG_CLOCK_EN_VDO1, CLK_TOP_VPP, 3),
 	GATE_TOP0(CLK_TOP_CFGREG_CLOCK_ISP_AXI_GALS, CLK_TOP_VPP, 4),
-	GATE_TOP0(CLK_TOP_CFGREG_F26M_VPP0, CLK_TOP_CLK26M, 5),
-	GATE_TOP0(CLK_TOP_CFGREG_F26M_VPP1, CLK_TOP_CLK26M, 6),
-	GATE_TOP0(CLK_TOP_CFGREG_F26M_VDO0, CLK_TOP_CLK26M, 7),
-	GATE_TOP0(CLK_TOP_CFGREG_F26M_VDO1, CLK_TOP_CLK26M, 8),
-	GATE_TOP0(CLK_TOP_CFGREG_AUD_F26M_AUD, CLK_TOP_CLK26M, 9),
+	GATE_TOP0E(CLK_TOP_CFGREG_F26M_VPP0, CLK_PAD_CLK26M, 5),
+	GATE_TOP0E(CLK_TOP_CFGREG_F26M_VPP1, CLK_PAD_CLK26M, 6),
+	GATE_TOP0E(CLK_TOP_CFGREG_F26M_VDO0, CLK_PAD_CLK26M, 7),
+	GATE_TOP0E(CLK_TOP_CFGREG_F26M_VDO1, CLK_PAD_CLK26M, 8),
+	GATE_TOP0E(CLK_TOP_CFGREG_AUD_F26M_AUD, CLK_PAD_CLK26M, 9),
 	GATE_TOP0(CLK_TOP_CFGREG_UNIPLL_SES, CLK_TOP_UNIVPLL_D2, 15),
-	GATE_TOP0(CLK_TOP_CFGREG_F_PCIE_PHY_REF, CLK_TOP_CLK26M, 18),
+	GATE_TOP0E(CLK_TOP_CFGREG_F_PCIE_PHY_REF, CLK_PAD_CLK26M, 18),
 	/* TOP1 */
-	GATE_TOP1(CLK_TOP_SSUSB_TOP_REF, CLK_TOP_CLK26M, 0),
-	GATE_TOP1(CLK_TOP_SSUSB_PHY_REF, CLK_TOP_CLK26M, 1),
-	GATE_TOP1(CLK_TOP_SSUSB_TOP_P1_REF, CLK_TOP_CLK26M, 2),
-	GATE_TOP1(CLK_TOP_SSUSB_PHY_P1_REF, CLK_TOP_CLK26M, 3),
-	GATE_TOP1(CLK_TOP_SSUSB_TOP_P2_REF, CLK_TOP_CLK26M, 4),
-	GATE_TOP1(CLK_TOP_SSUSB_PHY_P2_REF, CLK_TOP_CLK26M, 5),
-	GATE_TOP1(CLK_TOP_SSUSB_TOP_P3_REF, CLK_TOP_CLK26M, 6),
-	GATE_TOP1(CLK_TOP_SSUSB_PHY_P3_REF, CLK_TOP_CLK26M, 7),
+	GATE_TOP1(CLK_TOP_SSUSB_TOP_REF, CLK_PAD_CLK26M, 0),
+	GATE_TOP1(CLK_TOP_SSUSB_PHY_REF, CLK_PAD_CLK26M, 1),
+	GATE_TOP1(CLK_TOP_SSUSB_TOP_P1_REF, CLK_PAD_CLK26M, 2),
+	GATE_TOP1(CLK_TOP_SSUSB_PHY_P1_REF, CLK_PAD_CLK26M, 3),
+	GATE_TOP1(CLK_TOP_SSUSB_TOP_P2_REF, CLK_PAD_CLK26M, 4),
+	GATE_TOP1(CLK_TOP_SSUSB_PHY_P2_REF, CLK_PAD_CLK26M, 5),
+	GATE_TOP1(CLK_TOP_SSUSB_TOP_P3_REF, CLK_PAD_CLK26M, 6),
+	GATE_TOP1(CLK_TOP_SSUSB_PHY_P3_REF, CLK_PAD_CLK26M, 7),
 };
 
 static const struct mtk_clk_tree mt8188_topckgen_clk_tree = {
 	.xtal_rate = 26 * MHZ,
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.id_offs_map = mt8188_id_top_offs_map,
 	.id_offs_map_size = ARRAY_SIZE(mt8188_id_top_offs_map),
 	.fdivs_offs = mt8188_id_top_offs_map[CLK_TOP_MAINPLL_D3],
@@ -1457,6 +1464,14 @@ static const struct mtk_gate_regs infra_ao4_cg_regs = {
 		.flags = CLK_GATE_SETCLR | CLK_PARENT_TOPCKGEN,	\
 	}
 
+#define GATE_INFRA_AO0E(_id, _parent, _shift) {			\
+		.id = _id,					\
+		.parent = _parent,				\
+		.regs = &infra_ao0_cg_regs,			\
+		.shift = _shift,				\
+		.flags = CLK_GATE_SETCLR | CLK_PARENT_EXT,	\
+	}
+
 #define GATE_INFRA_AO1(_id, _parent, _shift) {			\
 		.id = _id,					\
 		.parent = _parent,				\
@@ -1465,6 +1480,14 @@ static const struct mtk_gate_regs infra_ao4_cg_regs = {
 		.flags = CLK_GATE_SETCLR | CLK_PARENT_TOPCKGEN,	\
 	}
 
+#define GATE_INFRA_AO1E(_id, _parent, _shift) {			\
+		.id = _id,					\
+		.parent = _parent,				\
+		.regs = &infra_ao1_cg_regs,			\
+		.shift = _shift,				\
+		.flags = CLK_GATE_SETCLR | CLK_PARENT_EXT,	\
+	}
+
 #define GATE_INFRA_AO2(_id, _parent, _shift) {			\
 		.id = _id,					\
 		.parent = _parent,				\
@@ -1473,6 +1496,14 @@ static const struct mtk_gate_regs infra_ao4_cg_regs = {
 		.flags = CLK_GATE_SETCLR | CLK_PARENT_TOPCKGEN,	\
 	}
 
+#define GATE_INFRA_AO2E(_id, _parent, _shift) {			\
+		.id = _id,					\
+		.parent = _parent,				\
+		.regs = &infra_ao2_cg_regs,			\
+		.shift = _shift,				\
+		.flags = CLK_GATE_SETCLR | CLK_PARENT_EXT,	\
+	}
+
 #define GATE_INFRA_AO3(_id, _parent, _shift) {			\
 		.id = _id,					\
 		.parent = _parent,				\
@@ -1481,6 +1512,14 @@ static const struct mtk_gate_regs infra_ao4_cg_regs = {
 		.flags = CLK_GATE_SETCLR | CLK_PARENT_TOPCKGEN,	\
 	}
 
+#define GATE_INFRA_AO3E(_id, _parent, _shift) {			\
+		.id = _id,					\
+		.parent = _parent,				\
+		.regs = &infra_ao3_cg_regs,			\
+		.shift = _shift,				\
+		.flags = CLK_GATE_SETCLR | CLK_PARENT_EXT,	\
+	}
+
 #define GATE_INFRA_AO4(_id, _parent, _shift) {			\
 		.id = _id,					\
 		.parent = _parent,				\
@@ -1512,24 +1551,24 @@ static const struct mtk_gate infracfg_ao_clks[] = {
 	GATE_INFRA_AO0(CLK_INFRA_AO_UART2, CLK_TOP_UART, 24),
 	GATE_INFRA_AO0(CLK_INFRA_AO_UART3, CLK_TOP_UART, 25),
 	GATE_INFRA_AO0(CLK_INFRA_AO_UART4, CLK_TOP_UART, 26),
-	GATE_INFRA_AO0(CLK_INFRA_AO_GCE_26M, CLK_TOP_CLK26M, 27),
+	GATE_INFRA_AO0E(CLK_INFRA_AO_GCE_26M, CLK_PAD_CLK26M, 27),
 	GATE_INFRA_AO0(CLK_INFRA_AO_CQ_DMA_FPC, CLK_TOP_PAD_FPC, 28),
 	GATE_INFRA_AO0(CLK_INFRA_AO_UART5, CLK_TOP_UART, 29),
 	/* INFRA_AO1 */
-	GATE_INFRA_AO1(CLK_INFRA_AO_HDMI_26M, CLK_TOP_CLK26M, 0),
+	GATE_INFRA_AO1E(CLK_INFRA_AO_HDMI_26M, CLK_PAD_CLK26M, 0),
 	GATE_INFRA_AO1(CLK_INFRA_AO_SPI0, CLK_TOP_SPI, 1),
-	GATE_INFRA_AO1(CLK_INFRA_AO_MSDC0, CLK_TOP_CLK26M, 2),
+	GATE_INFRA_AO1E(CLK_INFRA_AO_MSDC0, CLK_PAD_CLK26M, 2),
 	GATE_INFRA_AO1(CLK_INFRA_AO_MSDC1, CLK_TOP_AXI, 4),
 	GATE_INFRA_AO1(CLK_INFRA_AO_MSDC2, CLK_TOP_AXI, 5),
 	GATE_INFRA_AO1(CLK_INFRA_AO_MSDC0_SRC, CLK_TOP_MSDC50_0, 6),
 	/* infra_ao_dvfsrc is for internal DVFS usage, should not be handled by Linux. */
-	GATE_INFRA_AO1(CLK_INFRA_AO_DVFSRC, CLK_TOP_CLK26M, 7),
+	GATE_INFRA_AO1E(CLK_INFRA_AO_DVFSRC, CLK_PAD_CLK26M, 7),
 	GATE_INFRA_AO1(CLK_INFRA_AO_TRNG, CLK_TOP_AXI, 9),
-	GATE_INFRA_AO1(CLK_INFRA_AO_AUXADC, CLK_TOP_CLK26M, 10),
+	GATE_INFRA_AO1E(CLK_INFRA_AO_AUXADC, CLK_PAD_CLK26M, 10),
 	GATE_INFRA_AO1(CLK_INFRA_AO_CPUM, CLK_TOP_AXI, 11),
-	GATE_INFRA_AO1(CLK_INFRA_AO_HDMI_32K, CLK_TOP_CLK32K, 12),
+	GATE_INFRA_AO1E(CLK_INFRA_AO_HDMI_32K, CLK_PAD_CLK32K, 12),
 	GATE_INFRA_AO1(CLK_INFRA_AO_CEC_66M_HCLK, CLK_TOP_AXI, 13),
-	GATE_INFRA_AO1(CLK_INFRA_AO_PCIE_TL_26M, CLK_TOP_CLK26M, 15),
+	GATE_INFRA_AO1E(CLK_INFRA_AO_PCIE_TL_26M, CLK_PAD_CLK26M, 15),
 	GATE_INFRA_AO1(CLK_INFRA_AO_MSDC1_SRC, CLK_TOP_MSDC30_1, 16),
 	GATE_INFRA_AO1(CLK_INFRA_AO_CEC_66M_BCLK, CLK_TOP_AXI, 17),
 	GATE_INFRA_AO1(CLK_INFRA_AO_PCIE_TL_96M, CLK_TOP_TL, 18),
@@ -1538,14 +1577,14 @@ static const struct mtk_gate infracfg_ao_clks[] = {
 	GATE_INFRA_AO1(CLK_INFRA_AO_ECC_66M_HCLK, CLK_TOP_AXI, 23),
 	GATE_INFRA_AO1(CLK_INFRA_AO_DEBUGSYS, CLK_TOP_AXI, 24),
 	GATE_INFRA_AO1(CLK_INFRA_AO_AUDIO, CLK_TOP_AXI, 25),
-	GATE_INFRA_AO1(CLK_INFRA_AO_PCIE_TL_32K, CLK_TOP_CLK32K, 26),
+	GATE_INFRA_AO1E(CLK_INFRA_AO_PCIE_TL_32K, CLK_PAD_CLK32K, 26),
 	GATE_INFRA_AO1(CLK_INFRA_AO_DBG_TRACE, CLK_TOP_AXI, 29),
-	GATE_INFRA_AO1(CLK_INFRA_AO_DRAMC_F26M, CLK_TOP_CLK26M, 31),
+	GATE_INFRA_AO1E(CLK_INFRA_AO_DRAMC_F26M, CLK_PAD_CLK26M, 31),
 	/* INFRA_AO2 */
 	GATE_INFRA_AO2(CLK_INFRA_AO_IRTX, CLK_TOP_AXI, 0),
 	GATE_INFRA_AO2(CLK_INFRA_AO_DISP_PWM, CLK_TOP_DISP_PWM0, 2),
 	GATE_INFRA_AO2(CLK_INFRA_AO_CLDMA_BCLK, CLK_TOP_AXI, 3),
-	GATE_INFRA_AO2(CLK_INFRA_AO_AUDIO_26M_BCLK, CLK_TOP_CLK26M, 4),
+	GATE_INFRA_AO2E(CLK_INFRA_AO_AUDIO_26M_BCLK, CLK_PAD_CLK26M, 4),
 	GATE_INFRA_AO2(CLK_INFRA_AO_SPI1, CLK_TOP_SPI, 6),
 	GATE_INFRA_AO2(CLK_INFRA_AO_SPI2, CLK_TOP_SPI, 9),
 	GATE_INFRA_AO2(CLK_INFRA_AO_SPI3, CLK_TOP_SPI, 10),
@@ -1564,14 +1603,14 @@ static const struct mtk_gate infracfg_ao_clks[] = {
 	GATE_INFRA_AO3(CLK_INFRA_AO_MD_MSDC0, CLK_TOP_MSDC50_0, 8),
 	GATE_INFRA_AO3(CLK_INFRA_AO_MSDC30_2, CLK_TOP_MSDC30_2, 9),
 	GATE_INFRA_AO3(CLK_INFRA_AO_GCPU, CLK_TOP_GCPU, 10),
-	GATE_INFRA_AO3(CLK_INFRA_AO_PCIE_PERI_26M, CLK_TOP_CLK26M, 15),
+	GATE_INFRA_AO3E(CLK_INFRA_AO_PCIE_PERI_26M, CLK_PAD_CLK26M, 15),
 	GATE_INFRA_AO3(CLK_INFRA_AO_GCPU_66M_BCLK, CLK_TOP_AXI, 16),
 	GATE_INFRA_AO3(CLK_INFRA_AO_GCPU_133M_BCLK, CLK_TOP_AXI, 17),
 	GATE_INFRA_AO3(CLK_INFRA_AO_DISP_PWM1, CLK_TOP_DISP_PWM1, 20),
 	GATE_INFRA_AO3(CLK_INFRA_AO_FBIST2FPC, CLK_TOP_MSDC50_0, 24),
 	/* infra_ao_dapc_sync is for device access permission control module */
 	GATE_INFRA_AO3(CLK_INFRA_AO_DEVICE_APC_SYNC, CLK_TOP_AXI, 25),
-	GATE_INFRA_AO3(CLK_INFRA_AO_PCIE_P1_PERI_26M, CLK_TOP_CLK26M, 26),
+	GATE_INFRA_AO3E(CLK_INFRA_AO_PCIE_P1_PERI_26M, CLK_PAD_CLK26M, 26),
 	/* INFRA_AO4 */
 	/* infra_ao_133m_mclk_set/infra_ao_66m_mclk_set are main clocks of peripheral */
 	GATE_INFRA_AO4(CLK_INFRA_AO_133M_MCLK_CK, CLK_TOP_AXI, 0),
@@ -1582,6 +1621,8 @@ static const struct mtk_gate infracfg_ao_clks[] = {
 
 static const struct mtk_clk_tree mt8188_infracfg_ao_clk_tree = {
 	.xtal_rate = 26 * MHZ,
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 };
 
 static const struct mtk_gate_regs peri_ao_cg_regs = {
@@ -1598,11 +1639,19 @@ static const struct mtk_gate_regs peri_ao_cg_regs = {
 		.flags = CLK_GATE_SETCLR | CLK_PARENT_TOPCKGEN,	\
 	}
 
+#define GATE_PERI_AOE(_id, _parent, _shift) {			\
+		.id = _id,					\
+		.parent = _parent,				\
+		.regs = &peri_ao_cg_regs,			\
+		.shift = _shift,				\
+		.flags = CLK_GATE_SETCLR | CLK_PARENT_EXT,	\
+	}
+
 static const struct mtk_gate pericfg_ao_clks[] = {
 	GATE_PERI_AO(CLK_PERI_AO_ETHERNET, CLK_TOP_AXI, 0),
 	GATE_PERI_AO(CLK_PERI_AO_ETHERNET_BUS, CLK_TOP_AXI, 1),
 	GATE_PERI_AO(CLK_PERI_AO_FLASHIF_BUS, CLK_TOP_AXI, 3),
-	GATE_PERI_AO(CLK_PERI_AO_FLASHIF_26M, CLK_TOP_CLK26M, 4),
+	GATE_PERI_AOE(CLK_PERI_AO_FLASHIF_26M, CLK_PAD_CLK26M, 4),
 	GATE_PERI_AO(CLK_PERI_AO_FLASHIFLASHCK, CLK_TOP_SPINOR, 5),
 	GATE_PERI_AO(CLK_PERI_AO_SSUSB_2P_BUS, CLK_TOP_USB_TOP_2P, 9),
 	GATE_PERI_AO(CLK_PERI_AO_SSUSB_2P_XHCI, CLK_TOP_SSUSB_XHCI_2P, 10),
@@ -1615,6 +1664,8 @@ static const struct mtk_gate pericfg_ao_clks[] = {
 
 static const struct mtk_clk_tree mt8188_pericfg_ao_clk_tree = {
 	.xtal_rate = 26 * MHZ,
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 };
 
 static const struct mtk_gate_regs imp_iic_wrap_cg_regs = {
@@ -1649,14 +1700,20 @@ static const struct mtk_gate imp_iic_wrap_en_clks[] = {
 
 const struct mtk_clk_tree mt8188_imp_iic_wrap_c_clk_tree = {
 	.xtal_rate = 26 * MHZ,
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 };
 
 const struct mtk_clk_tree mt8188_imp_iic_wrap_w_clk_tree = {
 	.xtal_rate = 26 * MHZ,
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 };
 
 const struct mtk_clk_tree mt8188_imp_iic_wrap_en_clk_tree = {
 	.xtal_rate = 26 * MHZ,
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 };
 
 static int mt8188_apmixedsys_probe(struct udevice *dev)

-- 
2.43.0

