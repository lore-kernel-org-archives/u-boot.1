Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B9F8CFD65D
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 16:23:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4B1784071;
	Wed,  7 Jan 2026 17:23:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JIig8hHw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C32B784064; Wed,  7 Jan 2026 17:22:33 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA6B983AAC
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 17:22:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-45358572a11so1359678b6e.3
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 08:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767802949; x=1768407749;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0iXUBATYAWFlNtRfuZITDlO2KTztQWjCGoloZhrn0cQ=;
 b=JIig8hHw5g9x77377bNFv5iN+oPqecw1idT+iCGKXi1mSMvZy2WqH93xBrdTJcUzYn
 Ww4Ukcb2WRiGicl9692SqOIyYWIxZdef+r0dREeXu5gAXhql5FPocFKp/nX2k5A3xyyv
 Z2prgxlSTOAuppgNM9gAX9R2bde66Rmx/TXpuTZfqa7P+zlsA9wBbALzmf3FvLVFEw+/
 dXhY8/neAs5RCCTUjlhyKQbAUzrbwtiaFH+oh1oMmFU7Z9NShX5YvgejaBxINCwE2AV0
 CO9HYbqW0qTe9UkIhmSQ2ZYhYVNdEJi4qaQk+0jvwv+kJ7jXvmWhFO2f13B6LtcuhTeE
 0kiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767802949; x=1768407749;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0iXUBATYAWFlNtRfuZITDlO2KTztQWjCGoloZhrn0cQ=;
 b=KWSMBopcz4SpTNYFh8v2U3Tc26ruYma+FSRDy9kfNC+Sheu5H1+liOM5t7XLbt+bXY
 SN4/Soiskjx0L4QtbYwTc3nvhuB3E+7C0LH5QDZyTWHBdS8T6jPvE20peZmAHYNYP9dn
 iUjMuJ/Ld9Rsbej2pKfP9Zk4LTRNe1vLjZN91rl+/qiLH4D3Tc045uKXnSEmSfGpN4WE
 XQ5th0YU2iNUHQdAAyJdlZhYSvWijToTCq/UIqHCzwRRoynFUAdtzt8FdHv+uaTMhtgR
 pfRRX5/iyd4sa27NlYxXCs0xfSli0JmMgu3iBideI7daZhkQCZqXSPnf1CApfv8PRvhe
 r80Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpxesWO0N5qJ+OfbVt33iAgdr0CgoI2iA0yh3gDvD/nMNX76Q0ReRkTxowafUUv+47scrNq9M=@lists.denx.de
X-Gm-Message-State: AOJu0Yy6CmiV7ptusB8YMNGKES4XuP0S4hs5nbZSrD3C2VVGmRWomqdq
 deDn7aJPL8Lzwdc4PnMsZblSox9y+4Kbb4e/oA2H0q07q40Mf23hFjGfQJpkUD6X5N4=
X-Gm-Gg: AY/fxX7IHmEJmhkxSwY6iPqFUwWwq1yyMv4f97y1yQPEVHhpC2l55fHCclA6nnIGssR
 q/9r9Sc364x3jlAAT5bTY9fZpsDzUofHe2MW0WWN/Juy5Bi6L3PWmxVtSR/Oq9rKkLDIiz7UbSR
 +RcsMx+P8CygUMEZK2V7pQKwh5NqlJVvuo8GpZKcgynIF34Zi7rnSKCPc4hEwZTQC9XdWBgE9Hx
 else7kQoZccphncxGi9LVo/F8obmFBgsPxhJOUHtctaYmevcZc55fX/2i6xHu2UVFKGXSNiTHrj
 HkLKJcXvor10KQO4C4pxjXq3WlQrc40nU0az39p2IxtZprjAKSCpHv4V9UL1RLy2SMKOIhthmal
 HV+Mn7/kdS2GFrIiwmGOL4s5P8adrS3XHMXIYsrPA3NAQX+5jNpRoYHdAWlnxN1Ek4TR4bxwHKH
 0kA+CHNIMDZOIpEbk=
X-Google-Smtp-Source: AGHT+IGPdV4dN9d2H8CgPi0kY4FPJ36dzBLgJYxjPHSdicTTane4dEVrVA6nJsXsS+fWza6DJKOMBw==
X-Received: by 2002:a05:6808:1907:b0:450:c63e:440 with SMTP id
 5614622812f47-45a6bf12ad2mr1528496b6e.66.1767802949350; 
 Wed, 07 Jan 2026 08:22:29 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f278:961a:494a:41af])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce4762eefbsm3958245a34.0.2026.01.07.08.22.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 08:22:28 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 07 Jan 2026 10:21:08 -0600
Subject: [PATCH v2 2/9] clk: mediatek: mt8365: fix missing and out of order
 clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-clk-mtk-mt8365-fixes-v2-2-3294a5d2f239@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5826; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=dpq5ZQMwvaanSPvhuQXU7x/uCM0I5mT7tXyPLEZ3+bA=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpXogOZGT3WicsDPem+LlmtmiORagBAJiO2lKxN
 Y/Z6H3Yr4+JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaV6IDhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AUTUH/0oyVZPV1jE5OiRCC7MtKJbFoB8EYWHEKPusyT6
 L5XiOEYwJCdQR+bxVT1570ao84/VFmYW9lh7zSqEF84t3S20pEH4zQmOrPmuWiUWIaHsqlv2ZQP
 YX6dtxjA9jmO2SQ7Grp/pmCUS+QqZQO+Cf6h6/FDQ7it7lxP+LpKX3exfOtw4h0h5qIBtmePzwr
 cdbkCkbTQCRijIVOdBihr05tQ2D+gTzWoBpqXVd7wEbD3R8t18baxM5h8QqK6O2mtX6Pzl5WjsX
 I1l1JsN8ECNLZhO6lt+HJS02HLf+5YKS2AwO+hYiPMd4E9BNrwtbYwWCitPd5l8xk/di+qW/C9e
 4OYc=
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

