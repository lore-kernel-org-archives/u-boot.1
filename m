Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E55DEB1070
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 15:34:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73623840DF;
	Tue, 10 Mar 2026 16:34:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="frk0fjsg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B37D83FED; Tue, 10 Mar 2026 16:34:21 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 075F983FBC
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 16:34:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-46703fb602fso846580b6e.0
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 08:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773156858; x=1773761658;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dXt13cfttwzWmsP2TCdDe4bMjnuzr7gtitn0unfKfAk=;
 b=frk0fjsgyHg+rcDkinKacPGAY976Zhp0gvUA7x7JSd4SRhelmWWGGDvFmnb7/RCySW
 E3hB7lFdfOildP7rfN2mhQR28xhCqjJoD6GyJ65IkPdOtIsocilAm7KHa0+mMtpc7Nmn
 4uAvEtK6Ofa9XynXQ0p9EiVPhS5Z/xbRTqZk+WhrTPevcD6b/bRyWqOsv5120Ih7kJQO
 CR5+Yi8rHmRWMQA9PBstHiLJpbXfLhMSlN417+06WUKY82sFpWocHAVkP1DpGWDWKj1S
 DEmymLR14bjZP5TVV7tj8gokiy9OYWDKenkTaIl3dSXUjvYHcK6bsXwaTDVFj9fPqQ/W
 ZVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773156858; x=1773761658;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dXt13cfttwzWmsP2TCdDe4bMjnuzr7gtitn0unfKfAk=;
 b=M4HOGGi+jCeDC5N6f3PTD1OctLNPnYS3aA1WLO8gTfXZ1+z6bc/MvVi8U33OMTy90X
 uuYIaE1iDcol352sHRFtDeI6eZNJCEGAkhsdc8S+3IT/5O664tusH3zjPojFiP1ru3NP
 mZYatZj0UJFY3iOHZxhXWIQwX222L4yw1ej5oV1voMug04oSlcQld4l+Z39hzN+ySl1P
 KHPY/OyaP55/wE0XDw4ogPczk8Qas+/n0boolS2SE6jiVvXtRya9AKYNGjcI5tur8xF2
 oFXEVt4IZXvJKlN+dmL0uYDdBSt3nNzLDaLB0mo7QyNAcGM4MIdrNJbIPPiPh8270M7m
 W73A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZlhU1lDlmlPFiGmuyNB5Kf+qMMv6KhLRY03pjfzIb6uFLlF8vv1A2Q0uwI3Op2sTaNLu7F7o=@lists.denx.de
X-Gm-Message-State: AOJu0Yx5JYfVVPdIqrqpuuiICSz5bpDrO3G19W6/RZekVFRpqQeXKppx
 ERRdiAL6Rumff1XNqDBXN2qyfAudT+0vTdI2sNV5fA3NkCO3e9RYHrU6lNqolcUeIYY=
X-Gm-Gg: ATEYQzxMchSH880IyFEsOpk5lNpFnZnwhcAAxH7rAfISzYZR/dbT98lD4O+O6lU3hm+
 EYPToeGUV2d97yKLb6AgWZHGKwj99CpEoFvc9nBP47jLv8pUiwWK4o1aB9pgKq7lIeg6pnJMe/J
 cvPp2i7zLa8uQ8JP3yXvFFQJZcCwMl4V11cJqprxJlTROTer3kabU2FsVjUFwDZOHUJDsIBCLwS
 KGjWv1h4QiHpYtiNp1loGK+3NaQu5b798y4ENoQO+8QwTbinymFL4HlDB77klaKHT9v5zs0Mlse
 Q7QfeBTYaMVLs54LoROOFwpK91xWVaKCSTQLdnf8AK+zBwqJarx+q3TkqqJrhjg5vS1zdz1CtfO
 y6I8+NzZooOWkaTBqHCkYM7saHNcIAXHtb1OeQhDnuUEm6XjpxMn9QSMM2EZiIceO54bQ3RLcJC
 GB+4Q6psDZQ4V4Tv+UyxTBXlj+357RqKcIHkaR6rk=
X-Received: by 2002:a05:6808:13d2:b0:44f:ec23:2375 with SMTP id
 5614622812f47-466dc9f4904mr7402031b6e.3.1773156857587; 
 Tue, 10 Mar 2026 08:34:17 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:78e2:51e2:14b8:2e10])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-466ecbcec59sm6320968b6e.7.2026.03.10.08.34.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 08:34:16 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 10 Mar 2026 10:32:16 -0500
Subject: [PATCH 03/16] clk: mediatek: mt7623: convert CLK_XTAL to
 CLK_PAD_CLK26M
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-clk-mtk-parent-cleanup-v1-3-66175ca8f637@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=15762;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=35pVBhCVUPk9DpeP9lF1Xkvn0nzuEZ4etPQvZ6EPkLY=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpsDmZNX8w0l3D9m4cvQIYvhX7rexDVm/qOqQx7
 w2CbSom0nSJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabA5mRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AuAsH/2xjuH6WLE0IUCdKdgJljAijsCAddC2Z9NcXsZT
 Mhvov881EGqfp7Tac8sxFyR5+FAlblrkucnY9Cup5aGbKTJGHIJhcIY7I37U9+OhWq2K0WB+byl
 hbxtABTN8NcHknOp0ySXq2Lug1sElngzglFyL8f5EzUj+Ef2i/SZbfes/VljY9DRfALXndNzq+T
 zTdAN8kHq8eqsk3gFZjNxjhx2dw7RQOn3Cgcdg7LzD8xeU5Joi1D6m8qUZWnrlqqC/d1TA+gkFF
 cCAxz9KD0cZlbG3TvIGtaFQMIUEkUOGR+D1PX1SZYPNbLxu3+i8ZNuEG682LfwWiVyJZDTdn/pr
 7IbY=
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

Replace all uses of CLK_XTAL with CLK_PAD_CLK26M.

This avoids declaring the same parent clock two different ways and will
eventually let us remove CLK_PARENT_XTAL completely.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7623.c | 135 +++++++++++++++++++-------------------
 1 file changed, 69 insertions(+), 66 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7623.c b/drivers/clk/mediatek/clk-mt7623.c
index 1c34bfbf596..41bd91a8e05 100644
--- a/drivers/clk/mediatek/clk-mt7623.c
+++ b/drivers/clk/mediatek/clk-mt7623.c
@@ -268,7 +268,7 @@ static const int top_id_offs_map[CLK_TOP_NR + 1] = {
 };
 
 #define FIXED_CLK0(_id, _rate)					\
-	FIXED_CLK(_id, CLK_XTAL, CLK_PARENT_XTAL, _rate)
+	FIXED_CLK(_id, CLK_PAD_CLK26M, CLK_PARENT_EXT, _rate)
 
 #define FACTOR0(_id, _parent, _mult, _div)			\
 	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_APMIXED)
@@ -277,7 +277,7 @@ static const int top_id_offs_map[CLK_TOP_NR + 1] = {
 	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_TOPCKGEN)
 
 #define FACTOR2(_id, _parent, _mult, _div)			\
-	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_XTAL)
+	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_EXT)
 
 static const struct mtk_fixed_clk top_fixed_clks[] = {
 	FIXED_CLK0(CLK_TOP_DPI, 108 * MHZ),
@@ -377,14 +377,14 @@ static const struct mtk_fixed_factor top_fixed_divs[] = {
 	FACTOR0(CLK_TOP_HADDS2PLL_98M, CLK_APMIXED_HADDS2PLL, 1, 3),
 	FACTOR0(CLK_TOP_HADDS2PLL_294M, CLK_APMIXED_HADDS2PLL, 1, 1),
 	FACTOR0(CLK_TOP_ETHPLL_500M, CLK_APMIXED_ETHPLL, 1, 1),
-	FACTOR2(CLK_TOP_CLK26M_D8, CLK_XTAL, 1, 8),
-	FACTOR2(CLK_TOP_32K_INTERNAL, CLK_XTAL, 1, 793),
+	FACTOR2(CLK_TOP_CLK26M_D8, CLK_PAD_CLK26M, 1, 8),
+	FACTOR2(CLK_TOP_32K_INTERNAL, CLK_PAD_CLK26M, 1, 793),
 	FACTOR1(CLK_TOP_AXISEL_D4, CLK_TOP_AXI_SEL, 1, 4),
 	FACTOR1(CLK_TOP_8BDAC, CLK_TOP_UNIVPLL_D2, 1, 1),
 };
 
 static const struct mtk_parent axi_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
 	TOP_PARENT(CLK_TOP_SYSPLL_D5),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
@@ -395,17 +395,17 @@ static const struct mtk_parent axi_parents[] = {
 };
 
 static const struct mtk_parent mem_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_DMPLL),
 };
 
 static const struct mtk_parent ddrphycfg_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
 };
 
 static const struct mtk_parent mm_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_VENCPLL),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
@@ -416,14 +416,14 @@ static const struct mtk_parent mm_parents[] = {
 };
 
 static const struct mtk_parent pwm_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL3_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL1_D4),
 };
 
 static const struct mtk_parent vdec_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_VDECPLL),
 	TOP_PARENT(CLK_TOP_SYSPLL_D5),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
@@ -435,18 +435,18 @@ static const struct mtk_parent vdec_parents[] = {
 };
 
 static const struct mtk_parent mfg_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MMPLL),
 	TOP_PARENT(CLK_TOP_DMPLL_X2),
 	TOP_PARENT(CLK_TOP_MSDCPLL),
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_SYSPLL_D3),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
 	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
 };
 
 static const struct mtk_parent camtg_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D26),
 	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
 	TOP_PARENT(CLK_TOP_SYSPLL3_D2),
@@ -456,12 +456,12 @@ static const struct mtk_parent camtg_parents[] = {
 };
 
 static const struct mtk_parent uart_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL2_D8),
 };
 
 static const struct mtk_parent spi_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_SYSPLL3_D2),
 	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
@@ -469,13 +469,13 @@ static const struct mtk_parent spi_parents[] = {
 };
 
 static const struct mtk_parent usb20_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL1_D8),
 	TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
 };
 
 static const struct mtk_parent msdc30_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MSDCPLL_D2),
 	TOP_PARENT(CLK_TOP_SYSPLL2_D2),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
@@ -484,7 +484,7 @@ static const struct mtk_parent msdc30_parents[] = {
 };
 
 static const struct mtk_parent aud_intbus_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
 	TOP_PARENT(CLK_TOP_SYSPLL3_D2),
 	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
@@ -493,7 +493,7 @@ static const struct mtk_parent aud_intbus_parents[] = {
 };
 
 static const struct mtk_parent pmicspi_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
 	TOP_PARENT(CLK_TOP_SYSPLL2_D4),
 	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
@@ -507,68 +507,68 @@ static const struct mtk_parent pmicspi_parents[] = {
 };
 
 static const struct mtk_parent scp_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
 	TOP_PARENT(CLK_TOP_DMPLL_D2),
 	TOP_PARENT(CLK_TOP_DMPLL_D4),
 };
 
 static const struct mtk_parent dpi0_tve_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MIPIPLL),
 	TOP_PARENT(CLK_TOP_MIPIPLL_D2),
 	TOP_PARENT(CLK_TOP_MIPIPLL_D4),
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_TVDPLL),
 	TOP_PARENT(CLK_TOP_TVDPLL_D2),
 	TOP_PARENT(CLK_TOP_TVDPLL_D4),
 };
 
 static const struct mtk_parent dpi1_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_TVDPLL),
 	TOP_PARENT(CLK_TOP_TVDPLL_D2),
 	TOP_PARENT(CLK_TOP_TVDPLL_D4),
 };
 
 static const struct mtk_parent hdmi_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_HDMIPLL),
 	TOP_PARENT(CLK_TOP_HDMIPLL_D2),
 	TOP_PARENT(CLK_TOP_HDMIPLL_D3),
 };
 
 static const struct mtk_parent apll_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_AUDPLL),
 	TOP_PARENT(CLK_TOP_AUDPLL_D4),
 	TOP_PARENT(CLK_TOP_AUDPLL_D8),
 	TOP_PARENT(CLK_TOP_AUDPLL_D16),
 	TOP_PARENT(CLK_TOP_AUDPLL_D24),
-	XTAL_PARENT(CLK_XTAL),
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 };
 
 static const struct mtk_parent rtc_parents[] = {
 	TOP_PARENT(CLK_TOP_32K_INTERNAL),
 	TOP_PARENT(CLK_TOP_32K_EXTERNAL),
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL3_D8),
 };
 
 static const struct mtk_parent nfi2x_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_SYSPLL2_D2),
 	TOP_PARENT(CLK_TOP_SYSPLL_D7),
 	TOP_PARENT(CLK_TOP_UNIVPLL3_D2),
 	TOP_PARENT(CLK_TOP_SYSPLL2_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
 	TOP_PARENT(CLK_TOP_SYSPLL4_D4),
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK26M),
 };
 
 static const struct mtk_parent emmc_hclk_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
 	TOP_PARENT(CLK_TOP_SYSPLL2_D2),
@@ -576,7 +576,7 @@ static const struct mtk_parent emmc_hclk_parents[] = {
 
 static const struct mtk_parent flash_parents[] = {
 	TOP_PARENT(CLK_TOP_CLK26M_D8),
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_SYSPLL2_D8),
 	TOP_PARENT(CLK_TOP_SYSPLL3_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
@@ -586,14 +586,14 @@ static const struct mtk_parent flash_parents[] = {
 };
 
 static const struct mtk_parent di_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_TVD2PLL),
 	TOP_PARENT(CLK_TOP_TVD2PLL_D2),
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK26M),
 };
 
 static const struct mtk_parent nr_osd_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_VENCPLL),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
@@ -604,38 +604,38 @@ static const struct mtk_parent nr_osd_parents[] = {
 };
 
 static const struct mtk_parent hdmirx_bist_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_SYSPLL_D3),
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D16),
 	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
 	TOP_PARENT(CLK_TOP_VENCPLL),
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK26M),
 };
 
 static const struct mtk_parent intdir_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_MMPLL),
 	TOP_PARENT(CLK_TOP_SYSPLL_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D2),
 };
 
 static const struct mtk_parent asm_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
 	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
 	TOP_PARENT(CLK_TOP_SYSPLL_D5),
 };
 
 static const struct mtk_parent ms_card_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL3_D8),
 	TOP_PARENT(CLK_TOP_SYSPLL4_D4),
 };
 
 static const struct mtk_parent ethif_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
 	TOP_PARENT(CLK_TOP_SYSPLL_D5),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
@@ -646,12 +646,12 @@ static const struct mtk_parent ethif_parents[] = {
 };
 
 static const struct mtk_parent hdmirx_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D52),
 };
 
 static const struct mtk_parent cmsys_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
@@ -661,18 +661,18 @@ static const struct mtk_parent cmsys_parents[] = {
 	TOP_PARENT(CLK_TOP_SYSPLL3_D2),
 	TOP_PARENT(CLK_TOP_SYSPLL2_D4),
 	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
-	XTAL_PARENT(CLK_XTAL),
-	XTAL_PARENT(CLK_XTAL),
-	XTAL_PARENT(CLK_XTAL),
-	XTAL_PARENT(CLK_XTAL),
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 };
 
 static const struct mtk_parent clk_8bdac_parents[] = {
 	TOP_PARENT(CLK_TOP_32K_INTERNAL),
 	TOP_PARENT(CLK_TOP_8BDAC),
-	XTAL_PARENT(CLK_XTAL),
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK26M),
+	EXT_PARENT(CLK_PAD_CLK26M),
 };
 
 static const struct mtk_parent aud2dvd_parents[] = {
@@ -681,7 +681,7 @@ static const struct mtk_parent aud2dvd_parents[] = {
 };
 
 static const struct mtk_parent padmclk_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D26),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D52),
 	TOP_PARENT(CLK_TOP_UNIVPLL_D108),
@@ -691,7 +691,7 @@ static const struct mtk_parent padmclk_parents[] = {
 };
 
 static const struct mtk_parent aud_mux_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_AUD1PLL_98M),
 	TOP_PARENT(CLK_TOP_AUD2PLL_90M),
 	TOP_PARENT(CLK_TOP_HADDS2PLL_98M),
@@ -791,8 +791,8 @@ static const struct mtk_gate_regs infra_cg_regs = {
 	}
 #define GATE_INFRA(_id, _parent, _shift) \
 	GATE_INFRA_FLAGS(_id, _parent, _shift, CLK_GATE_SETCLR | CLK_PARENT_TOPCKGEN)
-#define GATE_INFRA_XTAL(_id, _parent, _shift) \
-	GATE_INFRA_FLAGS(_id, _parent, _shift, CLK_GATE_SETCLR | CLK_PARENT_XTAL)
+#define GATE_INFRA_EXT(_id, _parent, _shift) \
+	GATE_INFRA_FLAGS(_id, _parent, _shift, CLK_GATE_SETCLR | CLK_PARENT_EXT)
 
 
 static const struct mtk_gate infra_cgs[] = {
@@ -800,8 +800,8 @@ static const struct mtk_gate infra_cgs[] = {
 	GATE_INFRA(CLK_INFRA_SMI, CLK_TOP_MM_SEL, 1),
 	GATE_INFRA(CLK_INFRA_QAXI_CM4, CLK_TOP_AXI_SEL, 2),
 	GATE_INFRA(CLK_INFRA_AUD_SPLIN_B, CLK_TOP_HADDS2PLL_294M, 4),
-	GATE_INFRA_XTAL(CLK_INFRA_AUDIO, CLK_XTAL, 5),
-	GATE_INFRA_XTAL(CLK_INFRA_EFUSE, CLK_XTAL, 6),
+	GATE_INFRA_EXT(CLK_INFRA_AUDIO, CLK_PAD_CLK26M, 5),
+	GATE_INFRA_EXT(CLK_INFRA_EFUSE, CLK_PAD_CLK26M, 6),
 	GATE_INFRA(CLK_INFRA_L2C_SRAM, CLK_TOP_MM_SEL, 7),
 	GATE_INFRA(CLK_INFRA_M4U, CLK_TOP_MEM_SEL, 8),
 	GATE_INFRA(CLK_INFRA_CONNMCU, CLK_TOP_WBG_DIG_416M, 12),
@@ -872,7 +872,7 @@ static const int peri_id_offs_map[] = {
 };
 
 static const struct mtk_parent uart_ck_sel_parents[] = {
-	XTAL_PARENT(CLK_XTAL),
+	EXT_PARENT(CLK_PAD_CLK26M),
 	TOP_PARENT(CLK_TOP_UART_SEL),
 };
 
@@ -904,8 +904,8 @@ static const struct mtk_gate_regs peri1_cg_regs = {
 	}
 #define GATE_PERI0(_id, _parent, _shift) \
 	GATE_PERI0_FLAGS(_id, _parent, _shift, CLK_GATE_SETCLR | CLK_PARENT_TOPCKGEN)
-#define GATE_PERI0_XTAL(_id, _parent, _shift) \
-	GATE_PERI0_FLAGS(_id, _parent, _shift, CLK_GATE_SETCLR | CLK_PARENT_XTAL)
+#define GATE_PERI0_EXT(_id, _parent, _shift) \
+	GATE_PERI0_FLAGS(_id, _parent, _shift, CLK_GATE_SETCLR | CLK_PARENT_EXT)
 
 #define GATE_PERI1(_id, _parent, _shift) {			\
 		.id = _id,					\
@@ -943,10 +943,10 @@ static const struct mtk_gate peri_cgs[] = {
 	GATE_PERI0(CLK_PERI_I2C0, CLK_TOP_AXI_SEL, 24),
 	GATE_PERI0(CLK_PERI_I2C1, CLK_TOP_AXI_SEL, 25),
 	GATE_PERI0(CLK_PERI_I2C2, CLK_TOP_AXI_SEL, 26),
-	GATE_PERI0_XTAL(CLK_PERI_I2C3, CLK_XTAL, 27),
-	GATE_PERI0_XTAL(CLK_PERI_AUXADC, CLK_XTAL, 28),
+	GATE_PERI0_EXT(CLK_PERI_I2C3, CLK_PAD_CLK26M, 27),
+	GATE_PERI0_EXT(CLK_PERI_AUXADC, CLK_PAD_CLK26M, 28),
 	GATE_PERI0(CLK_PERI_SPI0, CLK_TOP_SPI0_SEL, 29),
-	GATE_PERI0_XTAL(CLK_PERI_ETH, CLK_XTAL, 30),
+	GATE_PERI0_EXT(CLK_PERI_ETH, CLK_PAD_CLK26M, 30),
 	GATE_PERI0(CLK_PERI_USB0_MCU, CLK_TOP_AXI_SEL, 31),
 
 	GATE_PERI1(CLK_PERI_USB1_MCU, CLK_TOP_AXI_SEL, 0),
@@ -1012,7 +1012,8 @@ static const struct mtk_clk_tree mt7623_apmixedsys_clk_tree = {
 };
 
 static const struct mtk_clk_tree mt7623_topckgen_clk_tree = {
-	.xtal_rate = 26 * MHZ,
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.id_offs_map = top_id_offs_map,
 	.id_offs_map_size = ARRAY_SIZE(top_id_offs_map),
 	.fdivs_offs = top_id_offs_map[CLK_TOP_SYSPLL],
@@ -1062,7 +1063,8 @@ static int mt7623_topckgen_probe(struct udevice *dev)
 }
 
 static const struct mtk_clk_tree mt7623_clk_gate_tree = {
-	.xtal_rate = 26 * MHZ,
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 };
 
 static int mt7623_infracfg_probe(struct udevice *dev)
@@ -1072,6 +1074,8 @@ static int mt7623_infracfg_probe(struct udevice *dev)
 }
 
 static const struct mtk_clk_tree mt7623_clk_peri_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.id_offs_map = peri_id_offs_map,
 	.id_offs_map_size = ARRAY_SIZE(peri_id_offs_map),
 	.muxes_offs = peri_id_offs_map[CLK_PERI_UART0_SEL],
@@ -1080,7 +1084,6 @@ static const struct mtk_clk_tree mt7623_clk_peri_tree = {
 	.gates = peri_cgs,
 	.num_muxes = ARRAY_SIZE(peri_muxes),
 	.num_gates = ARRAY_SIZE(peri_cgs),
-	.xtal_rate = 26 * MHZ,
 };
 
 static int mt7623_pericfg_probe(struct udevice *dev)

-- 
2.43.0

