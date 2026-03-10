Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA98BEB1060
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 15:34:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68D5884090;
	Tue, 10 Mar 2026 16:34:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xmxvLZln";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D128583FBC; Tue, 10 Mar 2026 16:34:18 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4684D8405F
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 16:34:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-46726528f1cso365426b6e.0
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 08:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773156855; x=1773761655;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8pQRgBhUbGURSAnI65NV6WvnT6EZGHkw4LQBm3dbjnc=;
 b=xmxvLZlnMoNGmA/WF8Bcq+mXp7HecvNjoc6Z6pr2+ztr9y7TvZ7ahNK/Z1+ev9p8dv
 SZQa5zK5cOX5MWyhn2ATVDqTY9Q+vfqeTNZbU5xjpfNQduL7Zu/QikdNnIlapEoU0IZ1
 gUvdg9biMnqU/KDSLF7cCSbqIalJVMhEjiB1AZQAOaKZKPT0OCSqlE3+qe+U1oFmWV2W
 yDzb86EzjbRdfUxM5fUJU2aPuT5Vs5uvZk2Y765jbIz8UeKK2mbtd+FPmfTqnUjP5KPM
 fF32YDEljGi89OS2zh6rFFem6P/wThevsUaE/DgF9j2nmrsBuotWghA7Ad60ahhR02Kh
 tEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773156855; x=1773761655;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8pQRgBhUbGURSAnI65NV6WvnT6EZGHkw4LQBm3dbjnc=;
 b=dutBHAxfpgqjMP8SC17j0T5uNotOIOUBvfUw8CvVMdDDewMIvLf9FOiN0TTMB0WUd5
 mpRbReIiWbKY/jQm2WWi5tiWOubOT5f00fsR0fOIIzmbBLVF3hNEtDZr0/dEMzoiDZxf
 Ni18svVEAPTwIfwQYHAY+dnMb7SRwWnHbE2V1AFFVXz7iBLjTsyp4P0XKAj6L0+OV40J
 7Cv+8Eke4LCreoADITNOpJkolxBEvePfCEpVpOjQ2IdIjWvycu5gW+i1loESu56mSvUh
 pSi8BS8ePhGTkwOSNQ8CVaXR5fj7vvA3diU5Q1aTGoONiVJarnAvn2rJlv/88AS6t3Ic
 nixA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5ERDYdTRh0wlbM0rYTZoBM4PLNQhbxKPPyzGdP6z8cYU2QImRIUPcVsnY2VSVZrVwSqrpavs=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9a7dJPOdxa1b60eW71lpYBOlf96EQRc0Cu/sidl7MBq4hwrL0
 EzNov3Bf0+JCxhQ7k4piwIjbVRbea7Ins2QZBdUgZcMskp+Wu/DldNktFDaxTXjtNwk=
X-Gm-Gg: ATEYQzyyPvoGTI19fXWkTd0KPngzBxGu7PHB57dK4C2luV9gfu5N+nOBEwvzUSi/34Z
 ZM81PhroQAmgeMZEyyIzoMQ6CqlXUKimaDgF1CrCC5gUk8LJzOMNy7kJLBk57mLw/wNB3F57Ci9
 LrW9o3K9DBeTtGhSz67Fi55cBCgokayioxRl89oewnWBUSffEQZIKW+ey7Ll56Cwx4p3dAU3VGW
 hQ2+5NQFE4dgT6XM8c7+YvSpWX8VnwQTlDB7JtFGa1l4UHjpT6Oua+l3NBEAv3JjwZayaWOJ9hu
 IRETlA2y4An34KHuT9dAUqpvVAPavw53Q5hKtXy/VGpLy2RjI+r1hRGmN4sJ0MJaqYTFARGvKgS
 qa/zrGY6CSZl+3KbWh5uyRy+V094lIzNYW+ElfeHMCtfBLBPbkixik3pBUK8rn5hh0qWR6917v8
 PMx/AdxlBVZGspaXmOoPheLWdLPkYD
X-Received: by 2002:a05:6808:344b:b0:466:f57b:2ae5 with SMTP id
 5614622812f47-466f57b515cmr6233589b6e.47.1773156854823; 
 Tue, 10 Mar 2026 08:34:14 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:78e2:51e2:14b8:2e10])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-466ecbcec59sm6320968b6e.7.2026.03.10.08.34.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 08:34:14 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 10 Mar 2026 10:32:14 -0500
Subject: [PATCH 01/16] clk: mediatek: replace xtal2_rate with struct mtk_parent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-clk-mtk-parent-cleanup-v1-1-66175ca8f637@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=14471;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=RBDyN+fGvvldALq8CN55/PAr0FDH20kjGqy90KKJrrs=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpsDmMzPx8fh6OLelNrzq6RnSG2Auj4GQkNGqcp
 efjyQaVLVmJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabA5jBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AYKMH/jRJJe+pPLug4bSFwTXQ1MBx2Ln8K1671828o/3
 fBcGhGC+hOcOfVPgewbwmevf2uFHv7w6swdrYU/MP6XDzSn4XDstWgS4sqUHI/6GD30qmR3s2jV
 tUcGCZ2HJ19zbJUxzAr8kSvMMRYgZz5ChskbBwnxUbLD6/pzGqpbnApUKxugi3Jd5eCl319M/xZ
 rUUovDn5UJxSPpl1MueWwJPMBPWXRc8LJ+JjU/yWrBAGArArJQKbr8MSwU/utbGQhVre6U+Uu8u
 WqTq5Te7UBiQn0J+GHUfykX9q1V3SPJ7KIoBODgZ/1/RXLBUD2giBhiEwKf/POo67UzGOrja4LW
 pPq8=
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

Replace the hard-coded xtal rate for PLL parents with struct mtk_parent.

This avoids declaring the same clock rate in multiple places and will
allow future drivers to use an arbitrary clock.

The variable is renamed to something that better indicate what the field
is actually used for.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7622.c | 12 +++++++++++-
 drivers/clk/mediatek/clk-mt7623.c | 12 +++++++++++-
 drivers/clk/mediatek/clk-mt7629.c | 16 ++++++++++++++--
 drivers/clk/mediatek/clk-mt8183.c | 12 +++++++++++-
 drivers/clk/mediatek/clk-mt8188.c |  2 +-
 drivers/clk/mediatek/clk-mt8189.c |  4 +---
 drivers/clk/mediatek/clk-mt8195.c |  2 +-
 drivers/clk/mediatek/clk-mt8365.c |  2 +-
 drivers/clk/mediatek/clk-mt8512.c | 12 +++++++++++-
 drivers/clk/mediatek/clk-mt8516.c | 12 +++++++++++-
 drivers/clk/mediatek/clk-mt8518.c | 12 +++++++++++-
 drivers/clk/mediatek/clk-mtk.c    | 33 +++++++++++++++++++++++++--------
 drivers/clk/mediatek/clk-mtk.h    |  2 +-
 13 files changed, 110 insertions(+), 23 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index e9a3f8ef0ba..cb637981499 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -28,6 +28,14 @@
 #define MCU_BUS_MSK			GENMASK(10, 9)
 #define MCU_BUS_SEL(x)			((x) << 9)
 
+enum {
+	CLK_PAD_CLK25M,
+};
+
+static const ulong ext_clock_rates[] = {
+	[CLK_PAD_CLK25M] = 25 * MHZ,
+};
+
 /* apmixedsys */
 #define PLL(_id, _reg, _pwr_reg, _en_mask, _flags, _pcwbits, _pd_reg,	\
 	    _pd_shift, _pcw_reg, _pcw_shift) {				\
@@ -597,7 +605,9 @@ static const struct mtk_gate ssusb_cgs[] = {
 };
 
 static const struct mtk_clk_tree mt7622_apmixed_clk_tree = {
-	.xtal2_rate = 25 * MHZ,
+	.pll_parent = EXT_PARENT(CLK_PAD_CLK25M),
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.plls = apmixed_plls,
 	.gates_offs = CLK_APMIXED_MAIN_CORE_EN,
 	.gates = apmixed_cgs,
diff --git a/drivers/clk/mediatek/clk-mt7623.c b/drivers/clk/mediatek/clk-mt7623.c
index 9e1522d4615..1c34bfbf596 100644
--- a/drivers/clk/mediatek/clk-mt7623.c
+++ b/drivers/clk/mediatek/clk-mt7623.c
@@ -24,6 +24,14 @@
 #define AXI_DIV_MSK			GENMASK(4, 0)
 #define AXI_DIV_SEL(x)			(x)
 
+enum {
+	CLK_PAD_CLK26M,
+};
+
+static const ulong ext_clock_rates[] = {
+	[CLK_PAD_CLK26M] = 26 * MHZ,
+};
+
 /* apmixedsys */
 static const int pll_id_offs_map[] = {
 	[0 ... CLK_APMIXED_NR - 1]		= -1,
@@ -994,7 +1002,9 @@ static const struct mtk_gate hif_cgs[] = {
 };
 
 static const struct mtk_clk_tree mt7623_apmixedsys_clk_tree = {
-	.xtal2_rate = 26 * MHZ,
+	.pll_parent = EXT_PARENT(CLK_PAD_CLK26M),
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.id_offs_map = pll_id_offs_map,
 	.id_offs_map_size = ARRAY_SIZE(pll_id_offs_map),
 	.plls = apmixed_plls,
diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index 42670269d3e..beba7fc4abc 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -28,6 +28,14 @@
 #define MCU_BUS_MSK			GENMASK(10, 9)
 #define MCU_BUS_SEL(x)			((x) << 9)
 
+enum {
+	CLK_PAD_CLK20M,
+};
+
+static const ulong ext_clock_rates[] = {
+	[CLK_PAD_CLK20M] = 20 * MHZ,
+};
+
 /* apmixedsys */
 #define PLL(_id, _reg, _pwr_reg, _en_mask, _flags, _pcwbits, _pd_reg,	\
 	    _pd_shift, _pcw_reg, _pcw_shift) {				\
@@ -567,7 +575,9 @@ static const struct mtk_gate ssusb_cgs[] = {
 
 static const struct mtk_clk_tree mt7629_clk_tree = {
 	.xtal_rate = 40 * MHZ,
-	.xtal2_rate = 20 * MHZ,
+	.pll_parent = EXT_PARENT(CLK_PAD_CLK20M),
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.fdivs_offs = CLK_TOP_TO_USB3_SYS,
 	.muxes_offs = CLK_TOP_AXI_SEL,
 	.plls = apmixed_plls,
@@ -582,7 +592,9 @@ static const struct mtk_clk_tree mt7629_clk_tree = {
 
 static const struct mtk_clk_tree mt7629_peri_clk_tree = {
 	.xtal_rate = 40 * MHZ,
-	.xtal2_rate = 20 * MHZ,
+	.pll_parent = EXT_PARENT(CLK_PAD_CLK20M),
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.fdivs_offs = CLK_TOP_TO_USB3_SYS,
 	.muxes_offs = CLK_TOP_AXI_SEL,
 	.plls = apmixed_plls,
diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 54e31efd2ea..6158441fb95 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -17,6 +17,14 @@
 #define MT8183_PLL_FMAX		(3800UL * MHZ)
 #define MT8183_PLL_FMIN		(1500UL * MHZ)
 
+enum {
+	CLK_PAD_CLK26M,
+};
+
+static const ulong ext_clock_rates[] = {
+	[CLK_PAD_CLK26M] = 26 * MHZ,
+};
+
 /* apmixedsys */
 #define PLL(_id, _reg, _pwr_reg, _en_mask, _flags, _rst_bar_mask, _pcwbits, \
 	    _pcwibits, _pd_reg, _pd_shift, _pcw_reg, _pcw_shift) {	\
@@ -598,7 +606,9 @@ static const struct mtk_composite top_muxes[] = {
 
 static const struct mtk_clk_tree mt8183_clk_tree = {
 	.xtal_rate = 26 * MHZ,
-	.xtal2_rate = 26 * MHZ,
+	.pll_parent = EXT_PARENT(CLK_PAD_CLK26M),
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.fdivs_offs = CLK_TOP_CLK13M,
 	.muxes_offs = CLK_TOP_MUX_AXI,
 	.plls = apmixed_plls,
diff --git a/drivers/clk/mediatek/clk-mt8188.c b/drivers/clk/mediatek/clk-mt8188.c
index e4297c92bd9..ca5fa8af86e 100644
--- a/drivers/clk/mediatek/clk-mt8188.c
+++ b/drivers/clk/mediatek/clk-mt8188.c
@@ -85,7 +85,7 @@ static const struct mtk_pll_data apmixed_plls[] = {
 
 static const struct mtk_clk_tree mt8188_apmixedsys_clk_tree = {
 	.xtal_rate = 26 * MHZ,
-	.xtal2_rate = 26 * MHZ,
+	.pll_parent = EXT_PARENT(CLK_PAD_CLK26M),
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.plls = apmixed_plls,
diff --git a/drivers/clk/mediatek/clk-mt8189.c b/drivers/clk/mediatek/clk-mt8189.c
index bce54c9a45f..1f75d873516 100644
--- a/drivers/clk/mediatek/clk-mt8189.c
+++ b/drivers/clk/mediatek/clk-mt8189.c
@@ -1636,8 +1636,7 @@ static const struct mtk_gate mminfra_config_clks[] = {
 };
 
 static const struct mtk_clk_tree mt8189_apmixedsys_clk_tree = {
-	.xtal_rate = 26 * MHZ,
-	.xtal2_rate = 26 * MHZ,
+	.pll_parent = EXT_PARENT(CLK_PAD_CLK26M),
 	.ext_clk_rates = pad_clks,
 	.num_ext_clks = ARRAY_SIZE(pad_clks),
 	.plls = apmixed_plls,
@@ -1645,7 +1644,6 @@ static const struct mtk_clk_tree mt8189_apmixedsys_clk_tree = {
 };
 
 static const struct mtk_clk_tree mt8189_topckgen_clk_tree = {
-	.xtal_rate = 26 * MHZ,
 	.ext_clk_rates = pad_clks,
 	.num_ext_clks = ARRAY_SIZE(pad_clks),
 	.fdivs_offs = CLK_TOP_MAINPLL_D3,
diff --git a/drivers/clk/mediatek/clk-mt8195.c b/drivers/clk/mediatek/clk-mt8195.c
index 76ece913187..28b2e2f12ac 100644
--- a/drivers/clk/mediatek/clk-mt8195.c
+++ b/drivers/clk/mediatek/clk-mt8195.c
@@ -97,7 +97,7 @@ static const struct mtk_pll_data apmixed_plls[] = {
 
 static const struct mtk_clk_tree mt8195_apmixedsys_clk_tree = {
 	.xtal_rate = 26 * MHZ,
-	.xtal2_rate = 26 * MHZ,
+	.pll_parent = EXT_PARENT(CLK_PAD_CLK26M),
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.plls = apmixed_plls,
diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index 16531491a0f..15df6422661 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -75,7 +75,7 @@ static const struct mtk_pll_data apmixed_plls[] = {
 
 static const struct mtk_clk_tree mt8365_apmixed_tree = {
 	.xtal_rate = 26 * MHZ,
-	.xtal2_rate = 26 * MHZ,
+	.pll_parent = EXT_PARENT(CLK_PAD_CLK26M),
 	.ext_clk_rates = ext_clk_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clk_rates),
 	.plls = apmixed_plls,
diff --git a/drivers/clk/mediatek/clk-mt8512.c b/drivers/clk/mediatek/clk-mt8512.c
index de0d3eae7ee..f7d41f4cfdb 100644
--- a/drivers/clk/mediatek/clk-mt8512.c
+++ b/drivers/clk/mediatek/clk-mt8512.c
@@ -17,6 +17,14 @@
 #define MT8512_PLL_FMIN		(1500UL * MHZ)
 #define MT8512_CON0_RST_BAR	BIT(23)
 
+enum {
+	CLK_PAD_CLK26M,
+};
+
+static const ulong ext_clock_rates[] = {
+	[CLK_PAD_CLK26M] = 26 * MHZ,
+};
+
 /* apmixedsys */
 #define PLL(_id, _reg, _pwr_reg, _en_mask, _flags, _pcwbits, _pd_reg,	\
 	    _pd_shift, _pcw_reg, _pcw_shift, _pcw_chg_reg) {		\
@@ -786,7 +794,9 @@ static const struct mtk_gate infra_clks[] = {
 
 static const struct mtk_clk_tree mt8512_clk_tree = {
 	.xtal_rate = 26 * MHZ,
-	.xtal2_rate = 26 * MHZ,
+	.pll_parent = EXT_PARENT(CLK_PAD_CLK26M),
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.fdivs_offs = CLK_TOP_SYSPLL1_D2,
 	.muxes_offs = CLK_TOP_AXI_SEL,
 	.plls = apmixed_plls,
diff --git a/drivers/clk/mediatek/clk-mt8516.c b/drivers/clk/mediatek/clk-mt8516.c
index 6b30ea9ce4a..74966051b1c 100644
--- a/drivers/clk/mediatek/clk-mt8516.c
+++ b/drivers/clk/mediatek/clk-mt8516.c
@@ -16,6 +16,14 @@
 #define MT8516_PLL_FMAX		(1502UL * MHZ)
 #define MT8516_CON0_RST_BAR	BIT(27)
 
+enum {
+	CLK_PAD_CLK26M,
+};
+
+static const ulong ext_clock_rates[] = {
+	[CLK_PAD_CLK26M] = 26 * MHZ,
+};
+
 /* apmixedsys */
 #define PLL(_id, _reg, _pwr_reg, _en_mask, _flags, _pcwbits, _pd_reg,	\
 	    _pd_shift, _pcw_reg, _pcw_shift) {				\
@@ -738,7 +746,9 @@ static const struct mtk_gate top_clks[] = {
 
 static const struct mtk_clk_tree mt8516_clk_tree = {
 	.xtal_rate = 26 * MHZ,
-	.xtal2_rate = 26 * MHZ,
+	.pll_parent = EXT_PARENT(CLK_PAD_CLK26M),
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.fdivs_offs = CLK_TOP_DMPLL,
 	.muxes_offs = CLK_TOP_UART0_SEL,
 	.plls = apmixed_plls,
diff --git a/drivers/clk/mediatek/clk-mt8518.c b/drivers/clk/mediatek/clk-mt8518.c
index 34fa5a127d5..85cbb35446b 100644
--- a/drivers/clk/mediatek/clk-mt8518.c
+++ b/drivers/clk/mediatek/clk-mt8518.c
@@ -16,6 +16,14 @@
 #define MT8518_PLL_FMAX		(3000UL * MHZ)
 #define MT8518_CON0_RST_BAR	BIT(27)
 
+enum {
+	CLK_PAD_CLK26M,
+};
+
+static const ulong ext_clock_rates[] = {
+	[CLK_PAD_CLK26M] = 26 * MHZ,
+};
+
 /* apmixedsys */
 #define PLL(_id, _reg, _pwr_reg, _en_mask, _flags, _pcwbits, _pd_reg,	\
 	    _pd_shift, _pcw_reg, _pcw_shift) {				\
@@ -1494,7 +1502,9 @@ static const struct mtk_gate top_clks[] = {
 
 static const struct mtk_clk_tree mt8518_clk_tree = {
 	.xtal_rate = 26 * MHZ,
-	.xtal2_rate = 26 * MHZ,
+	.pll_parent = EXT_PARENT(CLK_PAD_CLK26M),
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.fdivs_offs = CLK_TOP_DMPLL,
 	.muxes_offs = CLK_TOP_UART0_SEL,
 	.plls = apmixed_plls,
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index fa4a84bfceb..0b6eb0dbc04 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -499,16 +499,21 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_priv *priv, u32 id,
  * @postdiv:	The post divider (output)
  * @freq:	The desired target frequency
  */
-static void mtk_pll_calc_values(struct mtk_clk_priv *priv, u32 id,
-				u32 *pcw, u32 *postdiv, u32 freq)
+static int mtk_pll_calc_values(struct mtk_clk_priv *priv, struct clk *clk,
+			       u32 *pcw, u32 *postdiv, u32 freq)
 {
 	const struct mtk_pll_data *pll;
-	unsigned long fmin;
+	const struct mtk_parent *parent = &priv->tree->pll_parent;
+	unsigned long xtal_rate, fmin;
 	u64 _pcw;
 	int ibits;
 	u32 val;
 
-	pll = &priv->tree->plls[id];
+	xtal_rate = mtk_find_parent_rate(priv, clk, parent->id, parent->flags);
+	if (IS_ERR_VALUE(xtal_rate))
+		return xtal_rate;
+
+	pll = &priv->tree->plls[clk->id];
 	fmin = pll->fmin ? pll->fmin : 1000 * MHZ;
 
 	if (freq > pll->fmax)
@@ -523,9 +528,11 @@ static void mtk_pll_calc_values(struct mtk_clk_priv *priv, u32 id,
 	/* _pcw = freq * postdiv / xtal_rate * 2^pcwfbits */
 	ibits = pll->pcwibits ? pll->pcwibits : INTEGER_BITS;
 	_pcw = ((u64)freq << val) << (pll->pcwbits - ibits);
-	do_div(_pcw, priv->tree->xtal2_rate);
+	do_div(_pcw, xtal_rate);
 
 	*pcw = (u32)_pcw;
+
+	return 0;
 }
 
 static ulong mtk_apmixedsys_set_rate(struct clk *clk, ulong rate)
@@ -533,11 +540,15 @@ static ulong mtk_apmixedsys_set_rate(struct clk *clk, ulong rate)
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
 	u32 pcw = 0;
 	u32 postdiv;
+	int ret;
 
 	if (!mtk_clk_id_is_pll(priv->tree, clk->id))
 		return -EINVAL;
 
-	mtk_pll_calc_values(priv, clk->id, &pcw, &postdiv, rate);
+	ret = mtk_pll_calc_values(priv, clk, &pcw, &postdiv, rate);
+	if (ret)
+		return ret;
+
 	mtk_pll_set_rate_regs(priv, clk->id, pcw, postdiv);
 
 	return 0;
@@ -546,8 +557,10 @@ static ulong mtk_apmixedsys_set_rate(struct clk *clk, ulong rate)
 static ulong mtk_apmixedsys_get_rate(struct clk *clk)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct mtk_parent *parent;
 	const struct mtk_pll_data *pll;
 	const struct mtk_gate *gate;
+	unsigned long xtal_rate;
 	u32 postdiv;
 	u32 pcw;
 
@@ -557,6 +570,11 @@ static ulong mtk_apmixedsys_get_rate(struct clk *clk)
 		return mtk_find_parent_rate(priv, clk, gate->parent, gate->flags);
 	}
 
+	parent = &priv->tree->pll_parent;
+	xtal_rate = mtk_find_parent_rate(priv, clk, parent->id, parent->flags);
+	if (IS_ERR_VALUE(xtal_rate))
+		return xtal_rate;
+
 	pll = &priv->tree->plls[clk->id];
 
 	postdiv = (readl(priv->base + pll->pd_reg) >> pll->pd_shift) &
@@ -566,8 +584,7 @@ static ulong mtk_apmixedsys_get_rate(struct clk *clk)
 	pcw = readl(priv->base + pll->pcw_reg) >> pll->pcw_shift;
 	pcw &= GENMASK(pll->pcwbits - 1, 0);
 
-	return __mtk_pll_recalc_rate(pll, priv->tree->xtal2_rate,
-				     pcw, postdiv);
+	return __mtk_pll_recalc_rate(pll, xtal_rate, pcw, postdiv);
 }
 
 static int mtk_apmixedsys_enable(struct clk *clk)
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 10a0723de47..682b4303585 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -234,7 +234,7 @@ struct mtk_gate {
 /* struct mtk_clk_tree - clock tree */
 struct mtk_clk_tree {
 	unsigned long xtal_rate;
-	unsigned long xtal2_rate;
+	const struct mtk_parent pll_parent;
 	/* External fixed clocks - excluded from mapping. */
 	const ulong *ext_clk_rates;
 	const int num_ext_clks;

-- 
2.43.0

