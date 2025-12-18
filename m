Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24E8D711CC
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 23:28:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85AFB838BB;
	Fri, 19 Dec 2025 00:28:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="j9CCDKN9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49A9F8389A; Fri, 19 Dec 2025 00:24:41 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1383B8309A
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 00:24:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-450c9057988so744397b6e.1
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 15:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766100278; x=1766705078;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0iXUBATYAWFlNtRfuZITDlO2KTztQWjCGoloZhrn0cQ=;
 b=j9CCDKN9s3lLkYpt41biXZdNW4bjDNP04gyfH4x4pN4bZgwPhpyBpi7hEaSzuwoVVU
 qHCG2ZwFTf8RRO1oqGijU5+OiMIMqMHx30uL46rBSwp7jZKAPR0Y75lngRth7XB9sKC/
 VHD0hsZoEMWDn9qkvMgLmuhGuKD3WLK75I/ioAzlRLkNNCmHM/7kxb3flt/84TLFY3Il
 Us2cHvgk8FUt2msTIx9KNayBuzf7aVGF2dERHcdoLSrWFlZFanMclWV7QIZdzXbssDAT
 YfSketuLVUSwNOCVWGb28JoSid0ccDV7VDTzlOhp5M8cH86fTbuni+0koWZaqR1HmXVh
 ppvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766100278; x=1766705078;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0iXUBATYAWFlNtRfuZITDlO2KTztQWjCGoloZhrn0cQ=;
 b=WKvdY+MEIDBzfTJQvgphhLiSWzDDP0CNu5FnV+kuHRnBO4I+3UiDPrU17NtIv3eBWz
 mN1DLDeepOHMZencFPEIHqlrHPVzd1PQUcM8GWZcxwh5I50Er8pFdA/rZpcfYP+ch0CG
 Lxs9QlTOqsYnX/KwENTOHnn8jQ/y61JrJvBV3fl6uJYU4gauneg2+3ZSfZc2Zg4lvgsK
 BMDTpdn1M09NJBsqruSZ78c7EKdBM4pMEr+RUIoKyDvTr3Ejv0jvKvyRtuLRD5a+Sp5v
 ZVpMlWq+KOaoHIyNBWsC70mfnH5BUxB6fnNuw6yDzNEp9FNfLWLtyvHGF3/KUaqiiQRL
 3vcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtd2gmb8y8ZSxmgOZMkfYyCvKPKK+RuMSJUhAXsvCB3+h65FKEQNzb9FM3RyUgpGkd7hmjFHM=@lists.denx.de
X-Gm-Message-State: AOJu0YzJPhs+yMkqvbHI+sS2hLZ06ZmTu87tXuYB8F0wpqqj3nxWalsL
 x094LkrdeSEhIFDxUXu9TJJdGHShggA+dx+O/t071+k7x3T/1nqWNcMiwn7ABphAxro=
X-Gm-Gg: AY/fxX5LFu7+pNOIZySD1Ox/Yp755pZ0lMxRDfY3MHBzC03itGQvt0SN3i0b4P86w1l
 mM2s1vdSi+C6dBudQsCJfUCR4ZHIobgmycBsKzF3fSwmVaaU+/DCpQuOjb28OYgxmexFXC0+JRs
 RUqIjhC2cRi3AI5I4z1pcbDBeHMwCZGCbPdP4hVdYsdoESnuKYXqmNq0bjR/XuBg2fDBEjuWrP4
 Wd5zgj/ua8guSo2O/QOcc1OMhzMqZCvNRMs13JUFl9Y3oHuOGxoGYRqbhZyq68O4H/qwHVChfdw
 IvpLzjHtf0fkRqXCZDus6Jk+343LHz0+3uxcOmVL8ZJfZbbhgj6e529D0UR8oivOCbZ24sgEJ1x
 AZjloYjfDInH1gaTMav5QjkyfLcia2WPA+GUn72C3aLNN1IYkOw0Lev0g/eEeclsFYQ+rYx97xD
 QcheI7wEyen549nZg=
X-Google-Smtp-Source: AGHT+IGcJHJ6VdRSAwvOdIgJdx37noFdvtdtmgWTXseEgwmhJxuf8oyS5zKVZitSCCA7hl+BaS51XQ==
X-Received: by 2002:a05:6808:219f:b0:450:d9ce:7d71 with SMTP id
 5614622812f47-457b2261c6dmr649573b6e.46.1766100277840; 
 Thu, 18 Dec 2025 15:24:37 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:67e5:27b0:56a0:f05d])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-457b3be228asm300334b6e.9.2025.12.18.15.24.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 15:24:36 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 18 Dec 2025 17:23:22 -0600
Subject: [PATCH 2/9] clk: mediatek: mt8365: fix missing and out of order clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-clk-mtk-mt8365-fixes-v1-2-4f8ff0de3268@baylibre.com>
References: <20251218-clk-mtk-mt8365-fixes-v1-0-4f8ff0de3268@baylibre.com>
In-Reply-To: <20251218-clk-mtk-mt8365-fixes-v1-0-4f8ff0de3268@baylibre.com>
To: Julien Masson <jmasson@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5826; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=dpq5ZQMwvaanSPvhuQXU7x/uCM0I5mT7tXyPLEZ3+bA=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpRIz7wB4wqGkEKAmKi48obT9F07BKFL7PIbmYg
 SL5BciKtdCJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaUSM+xYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A8bAH/RjIKZn3kQJIwvuGuSGLf6+i8l+hrU0Bf+Ii8LO
 s8pN5MP7TU6CWxhR82d1tSmyEcVR8MZJWlVU8QPcPxR88qrab0uhLUij2sbLWC+Eaf85prq9+B6
 M/LRKyDiXxwlbMhZRpdBkGugn5apGxAGQopsIw2wYTtHtG/AEe8ezw900vSki1HHX+l4iX5Cm4w
 CugH4Df5NMnYM0iQZ4/UZ99pZFBxvo6B5e8bC/wrOgfpd9MlAccyw2Yy5z8OIU4fcZrZi1taNEj
 314DtGArYZleEq+PPVXOZPnIC07FvardHG94Szyy6YZlSLOH5sfWRYDIrdHtpsbjdJtiNFAvcIR
 Uj7I=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Fri, 19 Dec 2025 00:28:35 +0100
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

Fix a few missing clocks and even more clocks in the incorrect order.
Since the clocks are looked up by index, having them out of order or
skipping an ID will lead to incorrect clocks being used.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8365.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index c88545fc7cf..b6332b14aea 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -80,7 +80,7 @@ static const struct mtk_fixed_clk top_fixed_clks[] = {
 	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_APMIXED)
 
 static const struct mtk_fixed_factor top_divs[] = {
-	PLL_FACTOR(CLK_TOP_SYS_26M_D2, "sys_26m_d2", CLK_XTAL, 1, 2),
+	PLL_FACTOR(CLK_TOP_MFGPLL, "mfgpll_ck", CLK_APMIXED_MFGPLL, 1, 1),
 	PLL_FACTOR(CLK_TOP_SYSPLL_D2, "syspll_d2", CLK_APMIXED_MAINPLL, 1, 2),
 	PLL_FACTOR(CLK_TOP_SYSPLL1_D2, "syspll1_d2", CLK_APMIXED_MAINPLL, 1, 4),
 	PLL_FACTOR(CLK_TOP_SYSPLL1_D4, "syspll1_d4", CLK_APMIXED_MAINPLL, 1, 8),
@@ -110,7 +110,6 @@ static const struct mtk_fixed_factor top_divs[] = {
 	PLL_FACTOR(CLK_TOP_UNIVPLL3_D4, "univpll3_d4", CLK_APMIXED_UNIVPLL, 1, 20),
 	PLL_FACTOR(CLK_TOP_MMPLL, "mmpll_ck", CLK_APMIXED_MMPLL, 1, 1),
 	PLL_FACTOR(CLK_TOP_MMPLL_D2, "mmpll_d2", CLK_APMIXED_MMPLL, 1, 2),
-	PLL_FACTOR(CLK_TOP_MFGPLL, "mfgpll_ck", CLK_APMIXED_MFGPLL, 1, 1),
 	PLL_FACTOR(CLK_TOP_LVDSPLL_D2, "lvdspll_d2", CLK_APMIXED_LVDSPLL, 1, 2),
 	PLL_FACTOR(CLK_TOP_LVDSPLL_D4, "lvdspll_d4", CLK_APMIXED_LVDSPLL, 1, 4),
 	PLL_FACTOR(CLK_TOP_LVDSPLL_D8, "lvdspll_d8", CLK_APMIXED_LVDSPLL, 1, 8),
@@ -128,6 +127,7 @@ static const struct mtk_fixed_factor top_divs[] = {
 	PLL_FACTOR(CLK_TOP_APLL2_D2, "apll2_d2", CLK_APMIXED_APLL2, 1, 2),
 	PLL_FACTOR(CLK_TOP_APLL2_D4, "apll2_d4", CLK_APMIXED_APLL2, 1, 4),
 	PLL_FACTOR(CLK_TOP_APLL2_D8, "apll2_d8", CLK_APMIXED_APLL2, 1, 8),
+	PLL_FACTOR(CLK_TOP_SYS_26M_D2, "sys_26m_d2", CLK_XTAL, 1, 2),
 	PLL_FACTOR(CLK_TOP_MSDCPLL, "msdcpll_ck", CLK_APMIXED_MSDCPLL, 1, 1),
 	PLL_FACTOR(CLK_TOP_MSDCPLL_D2, "msdcpll_d2", CLK_APMIXED_MSDCPLL, 1, 2),
 	PLL_FACTOR(CLK_TOP_DSPPLL, "dsppll_ck", CLK_APMIXED_DSPPLL, 1, 1),
@@ -484,7 +484,7 @@ static const struct mtk_composite top_muxes[] = {
 static const struct mtk_clk_tree mt8365_clk_tree = {
 	.xtal_rate = 26 * MHZ,
 	.xtal2_rate = 26 * MHZ,
-	.fdivs_offs = CLK_TOP_SYSPLL_D2,
+	.fdivs_offs = CLK_TOP_MFGPLL,
 	.muxes_offs = CLK_TOP_AXI_SEL,
 	.plls = apmixed_plls,
 	.fclks = top_fixed_clks,
@@ -540,16 +540,6 @@ static const struct mtk_gate_regs top2_cg_regs = {
 	}
 
 static const struct mtk_gate top_clk_gates[] = {
-	GATE_TOP0(CLK_TOP_CONN_32K, CLK_TOP_CLK32K, 10),
-	GATE_TOP0(CLK_TOP_CONN_26M, CLK_TOP_CLK26M, 11),
-	GATE_TOP0(CLK_TOP_DSP_32K, CLK_TOP_CLK32K, 16),
-	GATE_TOP0(CLK_TOP_DSP_26M, CLK_TOP_CLK26M, 17),
-	GATE_TOP1(CLK_TOP_USB20_48M_EN, CLK_TOP_USB20_192M_D4, 8),
-	GATE_TOP1(CLK_TOP_UNIVPLL_48M_EN, CLK_TOP_USB20_192M_D4, 9),
-	GATE_TOP1(CLK_TOP_LVDSTX_CLKDIG_EN, CLK_TOP_LVDSTX_CLKDIG_CTS, 20),
-	GATE_TOP1(CLK_TOP_VPLL_DPIX_EN, CLK_TOP_VPLL_DPIX, 21),
-	GATE_TOP1(CLK_TOP_SSUSB_TOP_CK_EN, CLK_TOP_CLK_NULL, 22),
-	GATE_TOP1(CLK_TOP_SSUSB_PHY_CK_EN, CLK_TOP_CLK_NULL, 23),
 	GATE_TOP2(CLK_TOP_AUD_I2S0_M, CLK_TOP_APLL12_CK_DIV0, 0),
 	GATE_TOP2(CLK_TOP_AUD_I2S1_M, CLK_TOP_APLL12_CK_DIV1, 1),
 	GATE_TOP2(CLK_TOP_AUD_I2S2_M, CLK_TOP_APLL12_CK_DIV2, 2),
@@ -559,6 +549,16 @@ static const struct mtk_gate top_clk_gates[] = {
 	GATE_TOP2(CLK_TOP_AUD_TDMIN_M, CLK_TOP_APLL12_CK_DIV5, 6),
 	GATE_TOP2(CLK_TOP_AUD_TDMIN_B, CLK_TOP_APLL12_CK_DIV5B, 7),
 	GATE_TOP2(CLK_TOP_AUD_SPDIF_M, CLK_TOP_APLL12_CK_DIV6, 8),
+	GATE_TOP1(CLK_TOP_USB20_48M_EN, CLK_TOP_USB20_192M_D4, 8),
+	GATE_TOP1(CLK_TOP_UNIVPLL_48M_EN, CLK_TOP_USB20_192M_D4, 9),
+	GATE_TOP1(CLK_TOP_LVDSTX_CLKDIG_EN, CLK_TOP_LVDSTX_CLKDIG_CTS, 20),
+	GATE_TOP1(CLK_TOP_VPLL_DPIX_EN, CLK_TOP_VPLL_DPIX, 21),
+	GATE_TOP1(CLK_TOP_SSUSB_TOP_CK_EN, CLK_TOP_CLK_NULL, 22),
+	GATE_TOP1(CLK_TOP_SSUSB_PHY_CK_EN, CLK_TOP_CLK_NULL, 23),
+	GATE_TOP0(CLK_TOP_CONN_32K, CLK_TOP_CLK32K, 10),
+	GATE_TOP0(CLK_TOP_CONN_26M, CLK_TOP_CLK26M, 11),
+	GATE_TOP0(CLK_TOP_DSP_32K, CLK_TOP_CLK32K, 16),
+	GATE_TOP0(CLK_TOP_DSP_26M, CLK_TOP_CLK26M, 17),
 };
 
 /* infracfg */
@@ -648,6 +648,7 @@ static const struct mtk_gate ifr_clks[] = {
 	GATE_IFR3(CLK_IFR_GCPU, CLK_TOP_AXI_SEL, 8),
 	GATE_IFR3(CLK_IFR_TRNG, CLK_TOP_AXI_SEL, 9),
 	GATE_IFR3(CLK_IFR_AUXADC, CLK_TOP_CLK26M, 10),
+	GATE_IFR3(CLK_IFR_CPUM, CLK_TOP_AXI_SEL, 11),
 	GATE_IFR3(CLK_IFR_AUXADC_MD, CLK_TOP_CLK26M, 14),
 	GATE_IFR3(CLK_IFR_AP_DMA, CLK_TOP_AXI_SEL, 18),
 	GATE_IFR3(CLK_IFR_DEBUGSYS, CLK_TOP_AXI_SEL, 24),
@@ -669,6 +670,7 @@ static const struct mtk_gate ifr_clks[] = {
 	GATE_IFR5(CLK_IFR_PWRAP_TMR, CLK_TOP_CLK26M, 12),
 	GATE_IFR5(CLK_IFR_PWRAP_SPI, CLK_TOP_CLK26M, 13),
 	GATE_IFR5(CLK_IFR_PWRAP_SYS, CLK_TOP_CLK26M, 14),
+	GATE_IFR5(CLK_IFR_MCU_PM_BK, CLK_TOP_AXI_SEL, 16),
 	GATE_IFR5(CLK_IFR_IRRX_26M, CLK_TOP_CLK26M, 22),
 	GATE_IFR5(CLK_IFR_IRRX_32K, CLK_TOP_CLK32K, 23),
 	GATE_IFR5(CLK_IFR_I2C0_AXI, CLK_TOP_I2C_SEL, 24),
@@ -680,8 +682,8 @@ static const struct mtk_gate ifr_clks[] = {
 	GATE_IFR5(CLK_IFR_APU_AXI, CLK_TOP_AXI_SEL, 30),
 	/* IFR6 */
 	GATE_IFR6(CLK_IFR_NFIECC, CLK_TOP_NFIECC_SEL, 0),
-	GATE_IFR6(CLK_IFR_NFI1X_BK, CLK_TOP_NFI2X_SEL, 1),
-	GATE_IFR6(CLK_IFR_NFIECC_BK, CLK_TOP_NFI2X_SEL, 2),
+	GATE_IFR6(CLK_IFR_NFIECC_BK, CLK_TOP_NFI2X_SEL, 1),
+	GATE_IFR6(CLK_IFR_NFI1X_BK, CLK_TOP_NFI2X_SEL, 2),
 	GATE_IFR6(CLK_IFR_NFI_BK, CLK_TOP_AXI_SEL, 3),
 	GATE_IFR6(CLK_IFR_MSDC2_AP_BK, CLK_TOP_AXI_SEL, 4),
 	GATE_IFR6(CLK_IFR_MSDC2_MD_BK, CLK_TOP_AXI_SEL, 5),

-- 
2.43.0

