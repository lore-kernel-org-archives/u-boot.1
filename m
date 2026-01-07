Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC381CFD65D
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 16:24:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF144840AA;
	Wed,  7 Jan 2026 17:23:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tm//gjDY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8C8C8398C; Wed,  7 Jan 2026 17:22:35 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C49283AB0
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 17:22:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7c6d1ebb0c4so1602185a34.1
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 08:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767802952; x=1768407752;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7S76WTHfoE+pWwNF4PeKfY9TT5y0nWhvCvOYB8JXETM=;
 b=tm//gjDYnJzI5F8UuVyymv/qUVgAWXBCRXQHZKOp5iSTijRA8E0+vZSZE9nQEIuXp6
 dgs62vpbUkrS55JvOLvVsGAdmo1OqzD62WCPXunv+GtrzoE7U1Fq0aI5MKOI4OhPRys3
 QZKYj3b3nTjn8ImWfBZy9tO7QR9oi7QfQ+EeXNuW/epBmmxCzqFvmFBv47yUlAKdKNbw
 i49C/xTzGLnH7h6G0Aoaxb/Am1uUB0uFit0W0S8jzKMwX8NdFgRxbFRBhjhoQHsIeZVN
 zdJdcAcb6FShEHe0XBLw+4a4UttRYG3hzAnp2Ph9PvybMHUOcy4uUElPOeJMvdwa2Lij
 6CEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767802952; x=1768407752;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7S76WTHfoE+pWwNF4PeKfY9TT5y0nWhvCvOYB8JXETM=;
 b=VXQxYyr8BLfAR1BZu+pwIZWrKjSquaiQwmU/rTTEU+WRbvOEzdLCo9cAUhBu4kOZgf
 8FMEsUxsnRsKi8u+07uP9rV7KyrVRaSUyZlUNC6Ax8Q4VQ+5X6ttcl36c0iKfuaX/aSA
 dGGDono3Q6dtzxa3kAqU1JKm6RskyQ1SBknxf9sQ2II3YyIpw01aVXXc2RI5ElqDs5Cd
 MkPMU6d2NjKTC65wxCcceKAZHsXqCWjEFx4lJioXzPi7EHHoluOJlbZefIB50Oaqa4Io
 o70ISHhS0KEyRmQsTXJT0Pss4CNQc3Ps3sWQVwP/pQ76Fa0YjzFdsztJs31JKMcVTUuG
 xcSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXK9fBgYc2wpgSpT74brxWdMbwBee4F9iSeL8z1J55WXTOex4dMQMF5U5tw0/q7AQyiuXyYNo=@lists.denx.de
X-Gm-Message-State: AOJu0YypJUN2uy/Q56h5sEQglyFRmwKIjLwnwBejGBNHQytFV4IKrSs9
 XjELvmysurtTvphbZssBRzkxFBiY357p5H+x+aWoQwwMCqazf7U7/yNr5t/d1GktrQA=
X-Gm-Gg: AY/fxX4V6yRjMxA7wGFSNCHItuWY2ZnFn4Ha9pvr00HJg7GLHGhIFAxJ//5BjMMxSLd
 B69L0MhxKCfKaYgiJRN1vzJVVT0wTn/QENRHBrY+yx1eyzqp2xRTnXk2SWLA55KAhmHHbGvowDJ
 suHY24Frb3hE70uZZkCQ1EsGP1cw1bPzLtp9OsA7Naqiv60v9Z3oXODq+azh1KV0ZYKA3UNNuM6
 sfG0bXgg7fCRxOMP6DD3Ti2JWEIHo+OGdvlfS8im9SEntBwrHKIGNlWrOia4CEHzvJUx2huMaIQ
 D0wZxm5qRyEVrgrG4hh0rjHPddrTmGN/whD2CmqOr2scxyFe8m6wYr6azIShUKOtHql1B2WQMIN
 oNJSo18A9PaNjbmfWI/9ksJEjj5lSrrtBSB02x0Dpa5cf5dnKTfFNZg5PCQpt51RSLZHdL6kO1t
 p7SK5iXseu3hAlmVjEfTjyMZifKA==
X-Google-Smtp-Source: AGHT+IET7yhBPC0lOPTbTZnQjGHJyBxGEkN9/fArnTCPtF6ityuzsLmr60lHP9ZUnAdY5rD0g2AYtQ==
X-Received: by 2002:a05:6830:3491:b0:7ce:519d:10ad with SMTP id
 46e09a7af769-7ce519d1570mr1387572a34.5.1767802951945; 
 Wed, 07 Jan 2026 08:22:31 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f278:961a:494a:41af])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce4762eefbsm3958245a34.0.2026.01.07.08.22.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 08:22:31 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 07 Jan 2026 10:21:11 -0600
Subject: [PATCH v2 5/9] clk: mediatek: mt8365: fix some clock parents
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-clk-mtk-mt8365-fixes-v2-5-3294a5d2f239@baylibre.com>
References: <20260107-clk-mtk-mt8365-fixes-v2-0-3294a5d2f239@baylibre.com>
In-Reply-To: <20260107-clk-mtk-mt8365-fixes-v2-0-3294a5d2f239@baylibre.com>
To: Julien Masson <jmasson@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5687; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=cRmt4G6GnRvx5ikfKmXg6b9ic9pxDggwV98nL+KLV+o=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpXogiMSu5cFhLATGdcifkCCCDUjIySjx7Vf2ZB
 cUiLIt23k6JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaV6IIhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Ab80H+wd5e8yVur/VI8anb41NrjvuvrBlUmFXx2JKjIi
 7LAKQ6E1V+SMqherLc6nHMSkz4SstAhxyFpCAhpDwiG7eWtrYpEg4D84meehsllD5EYIzkBbr6n
 MR6+ZgJcn1m8BHfpipxoMF6Qvp5TYsdFFpj/pCSkB2IUUGq437du1j7C1MiSRweLNx7aL2odbp4
 fgtQouktFj8bhjaF7ffbdSnSjXTj2r96ge+nVXkNXzzMtvxDVlb6p0gAkN3KU4IBrknYpa2CC6y
 883hMF+EuXxixzPmvSyqPVMc0N7jiadXYKzSjR5DgoTQ1kLUgutZMmp8ScnEUkv49U1fhIgsTrJ
 RU3U=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Wed, 07 Jan 2026 17:23:20 +0100
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

Fix a number of clock parent definitions for MT8365 clocks. Most of
these are just informational or don't make a function change.

The clocks with the new PLL_FACTOR2 macro and the change in apu_parents
are fixing actual bugs.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8365.c | 48 ++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index 13f63d04ad0..4d0a0487b57 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -72,19 +72,25 @@ static const struct mtk_pll_data apmixed_plls[] = {
 	FIXED_CLK(_id, CLK_XTAL, CLK_PARENT_XTAL, _rate)
 
 #define FIXED_CLK1(_id, _rate)						\
-	FIXED_CLK(_id, CLK_TOP_CLK26M, CLK_PARENT_TOPCKGEN, _rate)
+	FIXED_CLK(_id, CLK_TOP_CLK_NULL, CLK_PARENT_TOPCKGEN, _rate)
 
 static const struct mtk_fixed_clk top_fixed_clks[] = {
 	FIXED_CLK0(CLK_TOP_CLK_NULL, 0),
-	FIXED_CLK0(CLK_TOP_I2S0_BCK, 26000000),
-	FIXED_CLK1(CLK_TOP_DSI0_LNTC_DSICK, 75000000),
-	FIXED_CLK1(CLK_TOP_VPLL_DPIX, 75000000),
-	FIXED_CLK1(CLK_TOP_LVDSTX_CLKDIG_CTS, 52500000),
+	FIXED_CLK1(CLK_TOP_I2S0_BCK, 26000000),
+	FIXED_CLK0(CLK_TOP_DSI0_LNTC_DSICK, 75000000),
+	FIXED_CLK0(CLK_TOP_VPLL_DPIX, 75000000),
+	FIXED_CLK0(CLK_TOP_LVDSTX_CLKDIG_CTS, 52500000),
 };
 
 #define PLL_FACTOR(_id, _name, _parent, _mult, _div)			\
 	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_APMIXED)
 
+#define PLL_FACTOR1(_id, _name, _parent, _mult, _div)			\
+	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_TOPCKGEN)
+
+#define PLL_FACTOR2(_id, _name, _parent, _mult, _div)			\
+	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_XTAL)
+
 static const struct mtk_fixed_factor top_divs[] = {
 	PLL_FACTOR(CLK_TOP_MFGPLL, "mfgpll_ck", CLK_APMIXED_MFGPLL, 1, 1),
 	PLL_FACTOR(CLK_TOP_SYSPLL_D2, "syspll_d2", CLK_APMIXED_MAINPLL, 1, 2),
@@ -120,20 +126,20 @@ static const struct mtk_fixed_factor top_divs[] = {
 	PLL_FACTOR(CLK_TOP_LVDSPLL_D4, "lvdspll_d4", CLK_APMIXED_LVDSPLL, 1, 4),
 	PLL_FACTOR(CLK_TOP_LVDSPLL_D8, "lvdspll_d8", CLK_APMIXED_LVDSPLL, 1, 8),
 	PLL_FACTOR(CLK_TOP_LVDSPLL_D16, "lvdspll_d16", CLK_APMIXED_LVDSPLL, 1, 16),
-	PLL_FACTOR(CLK_TOP_USB20_192M, "usb20_192m_ck", CLK_APMIXED_USB20_EN, 1, 13),
-	PLL_FACTOR(CLK_TOP_USB20_192M_D4, "usb20_192m_d4", CLK_TOP_USB20_192M, 1, 4),
-	PLL_FACTOR(CLK_TOP_USB20_192M_D8, "usb20_192m_d8", CLK_TOP_USB20_192M, 1, 8),
-	PLL_FACTOR(CLK_TOP_USB20_192M_D16, "usb20_192m_d16", CLK_TOP_USB20_192M, 1, 16),
-	PLL_FACTOR(CLK_TOP_USB20_192M_D32, "usb20_192m_d32", CLK_TOP_USB20_192M, 1, 32),
+	PLL_FACTOR(CLK_TOP_USB20_192M, "usb20_192m_ck", CLK_APMIXED_UNIVPLL, 1, 13),
+	PLL_FACTOR1(CLK_TOP_USB20_192M_D4, "usb20_192m_d4", CLK_TOP_USB20_192M, 1, 4),
+	PLL_FACTOR1(CLK_TOP_USB20_192M_D8, "usb20_192m_d8", CLK_TOP_USB20_192M, 1, 8),
+	PLL_FACTOR1(CLK_TOP_USB20_192M_D16, "usb20_192m_d16", CLK_TOP_USB20_192M, 1, 16),
+	PLL_FACTOR1(CLK_TOP_USB20_192M_D32, "usb20_192m_d32", CLK_TOP_USB20_192M, 1, 32),
 	PLL_FACTOR(CLK_TOP_APLL1, "apll1_ck", CLK_APMIXED_APLL1, 1, 1),
-	PLL_FACTOR(CLK_TOP_APLL1_D2, "apll1_d2", CLK_APMIXED_APLL1, 1, 2),
-	PLL_FACTOR(CLK_TOP_APLL1_D4, "apll1_d4", CLK_APMIXED_APLL1, 1, 4),
-	PLL_FACTOR(CLK_TOP_APLL1_D8, "apll1_d8", CLK_APMIXED_APLL1, 1, 8),
+	PLL_FACTOR1(CLK_TOP_APLL1_D2, "apll1_d2", CLK_TOP_APLL1, 1, 2),
+	PLL_FACTOR1(CLK_TOP_APLL1_D4, "apll1_d4", CLK_TOP_APLL1, 1, 4),
+	PLL_FACTOR1(CLK_TOP_APLL1_D8, "apll1_d8", CLK_TOP_APLL1, 1, 8),
 	PLL_FACTOR(CLK_TOP_APLL2, "apll2_ck", CLK_APMIXED_APLL2, 1, 1),
-	PLL_FACTOR(CLK_TOP_APLL2_D2, "apll2_d2", CLK_APMIXED_APLL2, 1, 2),
-	PLL_FACTOR(CLK_TOP_APLL2_D4, "apll2_d4", CLK_APMIXED_APLL2, 1, 4),
-	PLL_FACTOR(CLK_TOP_APLL2_D8, "apll2_d8", CLK_APMIXED_APLL2, 1, 8),
-	PLL_FACTOR(CLK_TOP_SYS_26M_D2, "sys_26m_d2", CLK_XTAL, 1, 2),
+	PLL_FACTOR1(CLK_TOP_APLL2_D2, "apll2_d2", CLK_TOP_APLL2, 1, 2),
+	PLL_FACTOR1(CLK_TOP_APLL2_D4, "apll2_d4", CLK_TOP_APLL2, 1, 4),
+	PLL_FACTOR1(CLK_TOP_APLL2_D8, "apll2_d8", CLK_TOP_APLL2, 1, 8),
+	PLL_FACTOR2(CLK_TOP_SYS_26M_D2, "sys_26m_d2", CLK_XTAL, 1, 2),
 	PLL_FACTOR(CLK_TOP_MSDCPLL, "msdcpll_ck", CLK_APMIXED_MSDCPLL, 1, 1),
 	PLL_FACTOR(CLK_TOP_MSDCPLL_D2, "msdcpll_d2", CLK_APMIXED_MSDCPLL, 1, 2),
 	PLL_FACTOR(CLK_TOP_DSPPLL, "dsppll_ck", CLK_APMIXED_DSPPLL, 1, 1),
@@ -141,7 +147,7 @@ static const struct mtk_fixed_factor top_divs[] = {
 	PLL_FACTOR(CLK_TOP_DSPPLL_D4, "dsppll_d4", CLK_APMIXED_DSPPLL, 1, 4),
 	PLL_FACTOR(CLK_TOP_DSPPLL_D8, "dsppll_d8", CLK_APMIXED_DSPPLL, 1, 8),
 	PLL_FACTOR(CLK_TOP_APUPLL, "apupll_ck", CLK_APMIXED_APUPLL, 1, 1),
-	PLL_FACTOR(CLK_TOP_CLK26M_D52, "clk26m_d52", CLK_XTAL, 1, 52),
+	PLL_FACTOR2(CLK_TOP_CLK26M_D52, "clk26m_d52", CLK_XTAL, 1, 52),
 };
 
 static const int axi_parents[] = {
@@ -422,7 +428,7 @@ static const int gcpu_cpm_parents[] = {
 static const int apu_parents[] = {
 	CLK_TOP_CLK26M,
 	CLK_TOP_UNIVPLL_D2,
-	CLK_APMIXED_APUPLL,
+	CLK_TOP_APUPLL,
 	CLK_TOP_MMPLL,
 	CLK_TOP_SYSPLL_D3,
 	CLK_TOP_UNIVPLL1_D2,
@@ -647,8 +653,8 @@ static const struct mtk_gate ifr_clks[] = {
 	GATE_IFR2(CLK_IFR_BTIF, CLK_TOP_AXI_SEL, 31),
 	/* IFR3 */
 	GATE_IFR3(CLK_IFR_SPI0, CLK_TOP_SPI_SEL, 1),
-	GATE_IFR3(CLK_IFR_MSDC0_HCLK, CLK_TOP_MSDC50_0_HC_SEL, 2),
-	GATE_IFR3(CLK_IFR_MSDC2_HCLK, CLK_TOP_MSDC2_2_HC_SEL, 3),
+	GATE_IFR3(CLK_IFR_MSDC0_HCLK, CLK_TOP_AXI_SEL, 2),
+	GATE_IFR3(CLK_IFR_MSDC2_HCLK, CLK_TOP_AXI_SEL, 3),
 	GATE_IFR3(CLK_IFR_MSDC1_HCLK, CLK_TOP_AXI_SEL, 4),
 	GATE_IFR3(CLK_IFR_DVFSRC, CLK_TOP_CLK26M, 7),
 	GATE_IFR3(CLK_IFR_GCPU, CLK_TOP_AXI_SEL, 8),

-- 
2.43.0

