Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3074CEB1060
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 15:34:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3960B84101;
	Tue, 10 Mar 2026 16:34:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rw7eMb3f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED45C840B5; Tue, 10 Mar 2026 16:34:19 +0100 (CET)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 216F584088
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 16:34:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-466ec4c6852so2055410b6e.3
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 08:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773156856; x=1773761656;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=T+z+WnU465BEKP5/B0SsmxOZ8W7NdHnBNuoEifVSwAU=;
 b=rw7eMb3fVDqmnLzgCRDWKWQqzcd+0utI+pzOWG5A8aF3NHS58Vi7S48/3BMoizKwbb
 0PtunEoXtk6nMy7/cPf1yrNTQscUSP+y3B8tMDErILpdbZBf6P3w22BSV3UR0rU2g2NK
 vRtYRXYg+a/ORHQ2LrcRuuO3so+Z40D4bUYfb52yf1AGTJDXjm8FnBtHjjiFB6ooEeNh
 lPtANT6igxImLT8T19XHzAETe4I2eRlpGqBVDjuSHa0/oPmLcO71ybRGOKJbYggfwBXo
 ti3WhCb1D6lPkNS7ry2qOjzTbpOB7zUUiurEUTNyyxtYYG1DzoA2/gldDoCfZIDdaglh
 wgPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773156856; x=1773761656;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=T+z+WnU465BEKP5/B0SsmxOZ8W7NdHnBNuoEifVSwAU=;
 b=tnKsm0bYhSbyGSkFHoyzrN7Hkk6eNaZEvCn3CWl8SWIbXdUo+pgTT4/TTkPURXSa5g
 FchvX4I2UQdCuwh1dYv/9rQkCjrso/kWsSRjtipPNUrP3KBNtHHLtAH9jimspWPDp/dk
 DMwmUi6dBRJQuZvIiVbXGEPS54I4YbJvdTHfzK3fPGEApI0MFlejBxV8Q9BwhsYFw42m
 NAKF0BGCQRlkN+3bWph+nYuf3H+Fta0ciw55dFhWR0ZfL0bOKsaa5F8eAdY+vxsai/ZM
 sqU52YVkLgAaFYeZrDrAjD9GB0uYXDD7YoNQvrlJ1bQIg8DqjGfb0CA2lSx8v29FkR7H
 xjZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmZZ5Co+vwfQa4ngELtYB58Oim4Tkv1XtKUttwpGjqMDMdOxBUasHIoFIBHoK+/pElX3/dq2k=@lists.denx.de
X-Gm-Message-State: AOJu0YxJkdwS1HI+xQ01Hjce03vmi5cqtq/NkU9aj+Usi/eHOgC5zMOJ
 //Ss00/GBCnUXQisgOKUFjM3yAimUVOqoYtoktqnJOggHxwnH0cU2xNjHNNFfoQgMiE=
X-Gm-Gg: ATEYQzw75LiZvXHMkAtaBvp4cNGqT3Zsd4jiH5wiDR1kXhlWCQ7NenAcd7UDWLEhNEJ
 2pm/VlFm2ull/drSAFnTiSUfIlFMD6DLcPprJ9n+AgHQQXtiP3LIK+v+gtDiBZWToqqcIBm0MqB
 phhWrgv1O2P2BH2m3hLkYJ1zCESekb3bKlEoWyuVPB4waiJqsx3KCMTYpyOhMIfSpuYTzWhP1jg
 CfqwwttTGeah+lLr3/vQg9ZtQ8i9yhAkBPgEKpT0wwNcKgmF5uUyMsFd9qF0AdPDAewXM2JKgxP
 HjxakEyCeN3lvtJo0w4UWsQh2kRxDfmvCY2b6kRNpSBXr1R2IyUEH3K55Z1kMQIhQ5hrvfOwHC3
 sDspnBl7dhbHe7yITNlV4Z9qbrLb7aeKQEqEvA3Grnjt5W3xKKkrZ0KRjl7UAVcyfB70YVL8mp8
 aNoFp/1SbyR9XAH7syGCgWoXrEBhkT
X-Received: by 2002:a05:6808:158c:b0:45c:881c:e0c0 with SMTP id
 5614622812f47-466dcb7baa7mr7795477b6e.47.1773156855728; 
 Tue, 10 Mar 2026 08:34:15 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:78e2:51e2:14b8:2e10])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-466ecbcec59sm6320968b6e.7.2026.03.10.08.34.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 08:34:15 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 10 Mar 2026 10:32:15 -0500
Subject: [PATCH 02/16] clk: mediatek: mt7622: convert CLK_XTAL to
 CLK_PAD_CLK25M
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-clk-mtk-parent-cleanup-v1-2-66175ca8f637@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11007;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=FGixxaby1liz1v9dMNyFMjuKxfI1J9t2YWLkJJJKi9w=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpsDmTWi1jRe9xnJvGCZf7MZ4Tqgup/wfPq2Pou
 Qu2sMoaA3KJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabA5kxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AY1QH+wbQjr1CVbBL1JqXKy376JhOKDJ3Z9yjqEXIyLR
 fyeJelRuEQhGBIJ+spSueRlU0eB//OsXY9bOenTVn7KbJWvfL6p4AbXJs4+Oe65NvsiScwFs1Ge
 /p9vgxGHwCFFNLH28B/82KvFlC7AKvuWu9S4X7ebwfJLWBdOzQlV+Tj3XIhQzS94R8O6b92EGun
 g0jXhUSEjBHYI/q3cnaB3NydYYTJ2OEf0PZJ9UhOtd9+msS2TiT1SpBZRMk8dx8WboUk4XgIpnh
 r+P5Mpsl4Bd5+FaKXraeYntARz1xp1kwXHDsWJ3ITVDx/m6VKkNOkGZL/7cfsdJy0FNGgeyIpIj
 tKOA=
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

Replace all uses of CLK_XTAL with CLK_PAD_CLK25M.

This avoids declaring the same parent clock two different ways and will
eventually let us remove CLK_PARENT_XTAL completely.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7622.c | 109 ++++++++++++++++++++------------------
 1 file changed, 56 insertions(+), 53 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index cb637981499..cecf1d3b91a 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -94,7 +94,7 @@ static const struct mtk_gate apmixed_cgs[] = {
 
 /* topckgen */
 #define FIXED_CLK0(_id, _rate)					\
-	FIXED_CLK(_id, CLK_XTAL, CLK_PARENT_XTAL, _rate)
+	FIXED_CLK(_id, CLK_PAD_CLK25M, CLK_PARENT_EXT, _rate)
 
 #define FACTOR0(_id, _parent, _mult, _div)			\
 	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_APMIXED)
@@ -103,7 +103,7 @@ static const struct mtk_gate apmixed_cgs[] = {
 	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_TOPCKGEN)
 
 #define FACTOR2(_id, _parent, _mult, _div)			\
-	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_XTAL)
+	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_EXT)
 
 static const struct mtk_fixed_clk top_fixed_clks[] = {
 	FIXED_CLK0(CLK_TOP_TO_U2_PHY, 31250000),
@@ -124,8 +124,8 @@ static const struct mtk_fixed_factor top_fixed_divs[] = {
 	FACTOR0(CLK_TOP_4MHZ, CLK_APMIXED_ETH1PLL, 1, 125),
 	FACTOR0(CLK_TOP_P0_1MHZ, CLK_APMIXED_ETH1PLL, 1, 500),
 	FACTOR1(CLK_TOP_TXCLK_SRC_PRE, CLK_TOP_SGMIIPLL_D2, 1, 1),
-	FACTOR2(CLK_TOP_RTC, CLK_XTAL, 1, 1024),
-	FACTOR2(CLK_TOP_MEMPLL, CLK_XTAL, 32, 1),
+	FACTOR2(CLK_TOP_RTC, CLK_PAD_CLK25M, 1, 1024),
+	FACTOR2(CLK_TOP_MEMPLL, CLK_PAD_CLK25M, 32, 1),
 	FACTOR1(CLK_TOP_DMPLL, CLK_TOP_MEMPLL, 1, 1),
 	FACTOR0(CLK_TOP_SYSPLL_D2, CLK_APMIXED_MAINPLL, 1, 2),
 	FACTOR0(CLK_TOP_SYSPLL1_D2, CLK_APMIXED_MAINPLL, 1, 4),
@@ -168,7 +168,7 @@ static const struct mtk_fixed_factor top_fixed_divs[] = {
 };
 
 static const struct mtk_parent axi_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK25M),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
 	TOP_PARENT(CLK_TOP_SYSPLL_D5),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
@@ -178,17 +178,17 @@ static const struct mtk_parent axi_parents[] = {
 };
 
 static const struct mtk_parent mem_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK25M),
 	TOP_PARENT(CLK_TOP_DMPLL),
 };
 
 static const struct mtk_parent ddrphycfg_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK25M),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
 };
 
 static const struct mtk_parent eth_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK25M),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
@@ -198,24 +198,24 @@ static const struct mtk_parent eth_parents[] = {
 };
 
 static const struct mtk_parent pwm_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK25M),
 	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
 };
 
 static const struct mtk_parent f10m_ref_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK25M),
 	TOP_PARENT(CLK_TOP_SYSPLL4_D16),
 };
 
 static const struct mtk_parent nfi_infra_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
-	XTAL_PARENT(CLK_XTAL),
-	XTAL_PARENT(CLK_XTAL),
-	XTAL_PARENT(CLK_XTAL),
-	XTAL_PARENT(CLK_XTAL),
-	XTAL_PARENT(CLK_XTAL),
-	XTAL_PARENT(CLK_XTAL),
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK25M),
+	EXT_PARENT(CLK_PAD_CLK25M),
+	EXT_PARENT(CLK_PAD_CLK25M),
+	EXT_PARENT(CLK_PAD_CLK25M),
+	EXT_PARENT(CLK_PAD_CLK25M),
+	EXT_PARENT(CLK_PAD_CLK25M),
+	EXT_PARENT(CLK_PAD_CLK25M),
+	EXT_PARENT(CLK_PAD_CLK25M),
 	TOP_PARENT(CLK_TOP_UNIVPLL2_D8),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
 	TOP_PARENT(CLK_TOP_UNIVPLL1_D8),
@@ -226,7 +226,7 @@ static const struct mtk_parent nfi_infra_parents[] = {
 };
 
 static const struct mtk_parent flash_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK25M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D80_D4),
 	TOP_PARENT(CLK_TOP_SYSPLL2_D8),
 	TOP_PARENT(CLK_TOP_SYSPLL3_D4),
@@ -237,61 +237,61 @@ static const struct mtk_parent flash_parents[] = {
 };
 
 static const struct mtk_parent uart_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK25M),
 	TOP_PARENT(CLK_TOP_UNIVPLL2_D8),
 };
 
 static const struct mtk_parent spi0_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK25M),
 	TOP_PARENT(CLK_TOP_SYSPLL3_D2),
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK25M),
 	TOP_PARENT(CLK_TOP_SYSPLL2_D4),
 	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL1_D8),
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK25M),
 };
 
 static const struct mtk_parent spi1_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK25M),
 	TOP_PARENT(CLK_TOP_SYSPLL3_D2),
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK25M),
 	TOP_PARENT(CLK_TOP_SYSPLL4_D4),
 	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL1_D8),
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK25M),
 };
 
 static const struct mtk_parent msdc30_0_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK25M),
 	TOP_PARENT(CLK_TOP_UNIVPLL2_D16),
 	TOP_PARENT(CLK_TOP_UNIV48M),
 };
 
 static const struct mtk_parent a1sys_hp_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK25M),
 	TOP_PARENT(CLK_TOP_AUD1PLL),
 	TOP_PARENT(CLK_TOP_AUD2PLL),
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK25M),
 };
 
 static const struct mtk_parent intdir_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK25M),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D2),
 	TOP_PARENT(CLK_TOP_SGMIIPLL),
 };
 
 static const struct mtk_parent aud_intbus_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK25M),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
 	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
 	TOP_PARENT(CLK_TOP_SYSPLL3_D2),
 };
 
 static const struct mtk_parent pmicspi_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK25M),
 	VOID_PARENT,
 	VOID_PARENT,
 	VOID_PARENT,
@@ -300,32 +300,32 @@ static const struct mtk_parent pmicspi_parents[] = {
 };
 
 static const struct mtk_parent atb_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK25M),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
 	TOP_PARENT(CLK_TOP_SYSPLL_D5),
 };
 
 static const struct mtk_parent audio_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK25M),
 	TOP_PARENT(CLK_TOP_SYSPLL3_D4),
 	TOP_PARENT(CLK_TOP_SYSPLL4_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL1_D16),
 };
 
 static const struct mtk_parent usb20_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK25M),
 	TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK25M),
 };
 
 static const struct mtk_parent aud1_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK25M),
 	TOP_PARENT(CLK_TOP_AUD1PLL),
 };
 
 static const struct mtk_parent asm_l_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK25M),
 	TOP_PARENT(CLK_TOP_SYSPLL_D5),
 	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
@@ -396,7 +396,7 @@ static const struct mtk_composite top_muxes[] = {
 /* infracfg */
 
 static const struct mtk_parent infra_mux1_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK25M),
 	APMIXED_PARENT(CLK_APMIXED_MAINPLL),
 	APMIXED_PARENT(CLK_APMIXED_MAIN_CORE_EN),
 	APMIXED_PARENT(CLK_APMIXED_MAINPLL),
@@ -460,8 +460,8 @@ static const struct mtk_gate_regs peri1_cg_regs = {
 	}
 #define GATE_PERI0(_id, _parent, _shift) \
 	GATE_PERI0_FLAGS(_id, _parent, _shift, CLK_GATE_SETCLR | CLK_PARENT_TOPCKGEN)
-#define GATE_PERI0_XTAL(_id, _parent, _shift) \
-	GATE_PERI0_FLAGS(_id, _parent, _shift, CLK_GATE_SETCLR | CLK_PARENT_XTAL)
+#define GATE_PERI0_EXT(_id, _parent, _shift) \
+	GATE_PERI0_FLAGS(_id, _parent, _shift, CLK_GATE_SETCLR | CLK_PARENT_EXT)
 
 #define GATE_PERI1(_id, _parent, _shift) {			\
 		.id = _id,					\
@@ -474,14 +474,14 @@ static const struct mtk_gate_regs peri1_cg_regs = {
 static const struct mtk_gate peri_cgs[] = {
 	/* PERI0 */
 	GATE_PERI0(CLK_PERI_THERM_PD, CLK_TOP_AXI_SEL, 1),
-	GATE_PERI0_XTAL(CLK_PERI_PWM1_PD, CLK_XTAL, 2),
-	GATE_PERI0_XTAL(CLK_PERI_PWM2_PD, CLK_XTAL, 3),
-	GATE_PERI0_XTAL(CLK_PERI_PWM3_PD, CLK_XTAL, 4),
-	GATE_PERI0_XTAL(CLK_PERI_PWM4_PD, CLK_XTAL, 5),
-	GATE_PERI0_XTAL(CLK_PERI_PWM5_PD, CLK_XTAL, 6),
-	GATE_PERI0_XTAL(CLK_PERI_PWM6_PD, CLK_XTAL, 7),
-	GATE_PERI0_XTAL(CLK_PERI_PWM7_PD, CLK_XTAL, 8),
-	GATE_PERI0_XTAL(CLK_PERI_PWM_PD, CLK_XTAL, 9),
+	GATE_PERI0_EXT(CLK_PERI_PWM1_PD, CLK_PAD_CLK25M, 2),
+	GATE_PERI0_EXT(CLK_PERI_PWM2_PD, CLK_PAD_CLK25M, 3),
+	GATE_PERI0_EXT(CLK_PERI_PWM3_PD, CLK_PAD_CLK25M, 4),
+	GATE_PERI0_EXT(CLK_PERI_PWM4_PD, CLK_PAD_CLK25M, 5),
+	GATE_PERI0_EXT(CLK_PERI_PWM5_PD, CLK_PAD_CLK25M, 6),
+	GATE_PERI0_EXT(CLK_PERI_PWM6_PD, CLK_PAD_CLK25M, 7),
+	GATE_PERI0_EXT(CLK_PERI_PWM7_PD, CLK_PAD_CLK25M, 8),
+	GATE_PERI0_EXT(CLK_PERI_PWM_PD, CLK_PAD_CLK25M, 9),
 	GATE_PERI0(CLK_PERI_AP_DMA_PD, CLK_TOP_AXI_SEL, 12),
 	GATE_PERI0(CLK_PERI_MSDC30_0_PD, CLK_TOP_MSDC30_0_SEL, 13),
 	GATE_PERI0(CLK_PERI_MSDC30_1_PD, CLK_TOP_MSDC30_1_SEL, 14),
@@ -495,7 +495,7 @@ static const struct mtk_gate peri_cgs[] = {
 	GATE_PERI0(CLK_PERI_I2C1_PD, CLK_TOP_AXI_SEL, 24),
 	GATE_PERI0(CLK_PERI_I2C2_PD, CLK_TOP_AXI_SEL, 25),
 	GATE_PERI0(CLK_PERI_SPI1_PD, CLK_TOP_SPI1_SEL, 26),
-	GATE_PERI0_XTAL(CLK_PERI_AUXADC_PD, CLK_XTAL, 27),
+	GATE_PERI0_EXT(CLK_PERI_AUXADC_PD, CLK_PAD_CLK25M, 27),
 	GATE_PERI0(CLK_PERI_SPI0_PD, CLK_TOP_SPI0_SEL, 28),
 	GATE_PERI0(CLK_PERI_SNFI_PD, CLK_TOP_NFI_INFRA_SEL, 29),
 	GATE_PERI0(CLK_PERI_NFI_PD, CLK_TOP_AXI_SEL, 30),
@@ -616,7 +616,8 @@ static const struct mtk_clk_tree mt7622_apmixed_clk_tree = {
 };
 
 static const struct mtk_clk_tree mt7622_infra_clk_tree = {
-	.xtal_rate = 25 * MHZ,
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.muxes_offs = CLK_INFRA_MUX1_SEL,
 	.gates_offs = CLK_INFRA_DBGCLK_PD,
 	.muxes = infra_muxes,
@@ -626,7 +627,8 @@ static const struct mtk_clk_tree mt7622_infra_clk_tree = {
 };
 
 static const struct mtk_clk_tree mt7622_peri_clk_tree = {
-	.xtal_rate = 25 * MHZ,
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.muxes_offs = CLK_PERIBUS_SEL,
 	.gates_offs = CLK_PERI_THERM_PD,
 	.muxes = peri_muxes,
@@ -636,7 +638,8 @@ static const struct mtk_clk_tree mt7622_peri_clk_tree = {
 };
 
 static const struct mtk_clk_tree mt7622_clk_tree = {
-	.xtal_rate = 25 * MHZ,
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.fdivs_offs = CLK_TOP_TO_USB3_SYS,
 	.muxes_offs = CLK_TOP_AXI_SEL,
 	.fclks = top_fixed_clks,

-- 
2.43.0

