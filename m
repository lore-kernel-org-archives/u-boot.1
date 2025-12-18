Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99694D711CF
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 23:29:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BB5D839A8;
	Fri, 19 Dec 2025 00:28:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wPrOFx4B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15D87835FD; Fri, 19 Dec 2025 00:24:45 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D33D2835B3
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 00:24:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-450c9057988so744421b6e.1
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 15:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766100281; x=1766705081;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7S76WTHfoE+pWwNF4PeKfY9TT5y0nWhvCvOYB8JXETM=;
 b=wPrOFx4BkjrYPiDSDK3grltdUnvMAeZfifMQ3EgwvqVtF9R7LQUD6f7O6SAeHPLvN+
 UKo0eMk2jsdj0uvZQcRa6usAH2bc7/bAko7haUTVPuiqrHbYJdDogKXjfki3dhc1v0tL
 byopCRzjX7fL1AsedPMU8eirF1ERlWD6tlz0sRtrYXYH2Sz3CQbbMs3Q/5/3n7l/uMxo
 XmXi4Ib8F29JYTl0IuRqDOf97qHr/tTJs4zmpQCLL2RJjtz0XtDPPpRdTYue+fjFai+m
 EwBOQtTxVlqAjJ2utwWm4+NfHN4+gzL4X7+mTezR908S5zlGfaDlVj0d9FSUFE9CT6oM
 Okcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766100281; x=1766705081;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7S76WTHfoE+pWwNF4PeKfY9TT5y0nWhvCvOYB8JXETM=;
 b=QZvFfn4d8ejtImwEJRexGCbaalCZWj4oRNUmoGd0xZPSz4QPgWipduirOqAgNpW3Pc
 cbuOnuYzic9JPPulnCVD/4dxr2HN1TxNHoX5anSK2e74YFXS+xd/EFA6se7GIRbLksp6
 HnYVVFrUAzQTV15Vcry7j4pIDcWACUBpLx0XvsXyZ4lOlDO8VC7WVP7eCNGJBNw7eczT
 xkrVPCMCDNBhNH6pspNWEwdQJKnzQk3pwVZAenN88/ABZ03NoNpJ0/f3pvdWszWGqE2/
 QyXfNnTWRaGFm8QW/WA3I3dhgo2/wEi22TzmqqT4sHYUcJ/Y6xxBb9nmjjoEixJY7QPw
 fYTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgQJp1ehtu81PPOiFdrvbB6CW/77W+Dw8P/UW2AhMppMmte6uwNvPo1z/s0THB8bg7HN99mkg=@lists.denx.de
X-Gm-Message-State: AOJu0YwLKH30izXHpLL4GP/NfM5iPImfHhVQ62x6jwRlE2JfR5jCm9Sw
 SlGPRxOrzmhr+TOP7NORmqbcE81kcA9UOxUv8JHR9sILsJO4BFY6QyPGyO6Yy0PMozywpLG1zV8
 Tx16s
X-Gm-Gg: AY/fxX5jP2NBFSwH4aCGsOuFFkxALg+y4RE6HzFsY8a99e3b3DUXyGqJwE2ninXJHE6
 X+zPyOYdDtB0zsndpFfJIrKe1lTy584eDmy+ZRPq1G/cqfwnxOnxv8oVvFCmmcyCFkNaEeBNQKS
 9HLcDqZ7IoDKAk5wdQUTyb7TDFmsjo1b73ReQQvK84tJTJBcW96ZyJLeiYaZ/g1wuSuwVMK3OO4
 ieKkYRBCFDfoPbHrdmhba2BWBJuXOBZr1XVj2p1MFag+fiL4CRAplt390VRo2eZFKVGeA8g6Fga
 8bBB0ipjyl7MBB4Hrk7vxwqr4bpjU7efn7zxT8rpzBpWtO2RrXjJGhsdrcOduL6EoavpL7n8KFA
 p9h1t847FDKPXM4uImgclrLkiuvV8DLOkDRC/NXCznpYwBHoUkutD5NwxzF6vlLLxPO31TGBnj6
 XulYqk3ZIhjZ5/QTI=
X-Google-Smtp-Source: AGHT+IENrr265eq1uf2cM8rERMkYpGpRcBVabNE5Z/7a2ssqtH6g4+8/ZeVKkIAp2D3Cs0CgApf5fg==
X-Received: by 2002:a05:6808:17a4:b0:453:5828:a4b1 with SMTP id
 5614622812f47-457b2289542mr726451b6e.55.1766100281643; 
 Thu, 18 Dec 2025 15:24:41 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:67e5:27b0:56a0:f05d])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-457b3be228asm300334b6e.9.2025.12.18.15.24.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 15:24:41 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 18 Dec 2025 17:23:25 -0600
Subject: [PATCH 5/9] clk: mediatek: mt8365: fix some clock parents
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-clk-mtk-mt8365-fixes-v1-5-4f8ff0de3268@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5687; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=cRmt4G6GnRvx5ikfKmXg6b9ic9pxDggwV98nL+KLV+o=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpRI0QjblqcK/2J2GUMuJ6R1MIbaU3dV5Zg87Qk
 se8ai3sv2SJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaUSNEBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A7DwH/jXYk/hIZGgGp4hK5aZGqrqqAG7StltDOfXgDaD
 +fQpXS7/7IGTJkwec7Nm1sNXXKPYS7s6Qcaj3yZ+bYL7UWFoE/gyEZS4mrsCeE8/PJ8ixHbx8kq
 trZvY88IgF67wHAvy+ekgw4RO1vwGPQOcvGBrgb9htXh6Rs8JrQjgPSWs7HHGAtiyXLhPAHhS99
 1/LusXk7R9XmfqpqhkhMx+yKKbMg4CVl4IVaLCiYeEd524d97IYASfs3N11P2EFezte+nOj4l6p
 PgtLZEsmNggRGjVJSvMAbf91ggQ3Isc45M/t3cmOZdvg1A81C2JN+KT16qbFzk5DiBOKw2DC/8H
 TP6c=
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

