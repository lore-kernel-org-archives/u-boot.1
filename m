Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39E4C3600B
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 22:51:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 981E181CFD;
	Sun, 23 Mar 2025 23:51:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BW61ch3f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8D6081DCC; Sun, 23 Mar 2025 23:51:47 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5241881B5B
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 23:51:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anarsoul@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22438c356c8so69398785ad.1
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 15:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742770304; x=1743375104; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hftko0HkFgFXFwlULQibkQ7vkz//i2rQaFNEHv9PLoA=;
 b=BW61ch3fyXsW/23avQdD+M33dS9sWHwHMKH6T/AcuSsZj5uvY814tuTKhstzPWuD3c
 1FoKsLeU8QQ0Rcut0Zv4mRQo3IB9MXaXiadX1J5rQqtJfif7Jvb2/SEQVToyeOVnzWmX
 Hl8VqO4SzTRKNUDZtS1pli2WEXPaFhiPMt760Dd5O93GDfVryEq3V1Ijzkchkt2zaXFq
 8YXStQtBYMhgo3giiGl9mGo0NpLDuOchGqMDdvHlC7jdnpVc2UclM0QeorJfc8djUMyI
 nF14hAKlYPV5nbGCasAkS2xozqD2NC5el8BNlNO1zaeihFUnkw0k3iX7fpTfHEOZATey
 mMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742770304; x=1743375104;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hftko0HkFgFXFwlULQibkQ7vkz//i2rQaFNEHv9PLoA=;
 b=iIgCY7i5TImPLyheruBFYlwk/tlsGNF1ylCMQiQokW00/ntvDLglkzQ46sD1CcAJUC
 vsLLjsDsQeFzEK7G0xe45rW30j062fUZSl2lpRTWv+rr13msv1DN2D5DfQkywA/3CggV
 8e4eHAx+Q1cSm60LJTygcXHRVveY/B8o8ssejpzkM0Uz6Jfe11Btq83gyplY0KWY0a0D
 c+Fd1hxWDKlhsGoSYKD1SS/9xOEml3ucnVFMTYr987ubIGuMGnBf1i4LHasTs+ZJYrBd
 0EnQ+VSEU65rb3RkAYt7XNhjdyWYofcNwvLzwTHkOby6/Rl006WaWCPDk8jhRkcjxCQi
 a8DQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZSmwqVc0PL8S51yitUJTL1kfDCuk/kwINEByUbefBKV8wGiPPKzyMZrYoTh8Jbkqdlgg0nRA=@lists.denx.de
X-Gm-Message-State: AOJu0YynytM2XLDdheCds+Wtsd0jsjs4d6KPsYYOnMHdFrcdsiI4I/7z
 is1TshMM+z6vdA4yDPPzoyx+Y2cJy2sZ8oVya/aGHQdITGzjte2M
X-Gm-Gg: ASbGnctXhaVaDPMtFQDKRVYbXRkM2DqR3A4EpBPOGrjH9TV0hvhYtdP1GVG7rQprapP
 Ik4jcwSoNPxb2oJ+DJtWLEEICTvkqH+u25pxGXfEDUagleadKWGElTHocIgukrdYQbzUEH9jO/X
 mGyK9dBro8WzJzBVUijRWvcRVv5xFTv57k4JktGP77iHQ/N+hVFhslrooJa1x0lt1Ythjsrf8hk
 TwLqI2w2vC4LcTPSL2P07HXUvG398NCFtvPOMofcvbmpGSkoWIw6cb8WPTCQlE7c6vlQvDljD3x
 5ecSLa81h8oJXp11wTvOu2cfYChhZJAq41Kaag2y58WIwjc=
X-Google-Smtp-Source: AGHT+IG8JmkH8Z5cRCwgQm9NVwciCnMg0xCxIAFOn51noxNG0StxjIq286U4L0C4L6S9+j9/fAlhZA==
X-Received: by 2002:a05:6a00:3a04:b0:736:32d2:aa93 with SMTP id
 d2e1a72fcca58-73905a24c12mr19311780b3a.20.1742770303412; 
 Sun, 23 Mar 2025 15:51:43 -0700 (PDT)
Received: from anarsoul-xps15.lan ([2001:569:7d4f:2900::398])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73905fab628sm6368536b3a.6.2025.03.23.15.51.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Mar 2025 15:51:42 -0700 (PDT)
From: Vasily Khoruzhick <anarsoul@gmail.com>
To: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Anatolij Gustschin <agust@denx.de>,
 Jagan Teki <jagan@edgeble.ai>, Quentin Schulz <quentin.schulz@cherry.de>,
 u-boot@lists.denx.de
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH v2 1/3] clk: rockchip: rk3328: use HDMIPHY PLL as a clock
 parent for VOP_DCLK
Date: Sun, 23 Mar 2025 15:50:56 -0700
Message-ID: <20250323225134.2369473-1-anarsoul@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The only video mode that currently works on rk3328 in u-boot is 1080p,
because it uses GPLL for VOP_DCLK clock parent.

Linux driver uses HDMIPHY PLL as a clock parent for VOP_DCLK, since using
GPLL or CPLL is not feasible due these PLL being used as a clock parent
for other devices. It would be cumbersome to recalculate dividers
for the rest of the devices, and u-boot doesn't do it anyway. As a
result, u-boot is not able to set desired dot clock for most
resolutions.

Switch to using HDMIPHY as a clock parent for VOP_DCLK

Tested with 768p, 1080p, 1440p monitors.

Fixes: 92edae779f8c ("clk: rockchip: rk3328: Add VOP clk support")
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
v2: no change

 drivers/clk/rockchip/clk_rk3328.c | 76 +++++++------------------------
 1 file changed, 16 insertions(+), 60 deletions(-)

diff --git a/drivers/clk/rockchip/clk_rk3328.c b/drivers/clk/rockchip/clk_rk3328.c
index 7701a9734ee..537af6b3290 100644
--- a/drivers/clk/rockchip/clk_rk3328.c
+++ b/drivers/clk/rockchip/clk_rk3328.c
@@ -79,6 +79,12 @@ enum {
 	PLL_MODE_SLOW			= 0,
 	PLL_MODE_NORM,
 
+	/* MISC_CON */
+	HDMIPHY_24M_SEL_SHIFT		= 13,
+	HDMIPHY_24M_SEL_MASK		= 1 << HDMIPHY_24M_SEL_SHIFT,
+	HDMIPHY_24M_SEL_PCLK		= 0,
+	HDMIPHY_24M_SEL_24MHZ		= 1,
+
 	/* CLKSEL_CON0 */
 	CLK_CORE_PLL_SEL_APLL		= 0,
 	CLK_CORE_PLL_SEL_GPLL,
@@ -583,41 +589,11 @@ static ulong rk3328_spi_set_clk(struct rk3328_cru *cru, uint hz)
 }
 
 #ifndef CONFIG_XPL_BUILD
-static ulong rk3328_vop_get_clk(struct rk3328_clk_priv *priv, ulong clk_id)
-{
-	struct rk3328_cru *cru = priv->cru;
-	u32 div, con, parent;
-
-	switch (clk_id) {
-	case ACLK_VOP_PRE:
-		con = readl(&cru->clksel_con[39]);
-		div = (con & ACLK_VOP_DIV_CON_MASK) >> ACLK_VOP_DIV_CON_SHIFT;
-		parent = GPLL_HZ;
-		break;
-	case ACLK_VIO_PRE:
-		con = readl(&cru->clksel_con[37]);
-		div = (con & ACLK_VIO_DIV_CON_MASK) >> ACLK_VIO_DIV_CON_SHIFT;
-		parent = GPLL_HZ;
-		break;
-	case DCLK_LCDC:
-		con = readl(&cru->clksel_con[40]);
-		div = (con & DCLK_LCDC_DIV_CON_MASK) >> DCLK_LCDC_DIV_CON_SHIFT;
-		parent = GPLL_HZ;
-		break;
-	default:
-		printf("%s: Unsupported vop get clk#%ld\n", __func__, clk_id);
-		return -ENOENT;
-	}
-
-	return DIV_TO_RATE(parent, div);
-}
-
 static ulong rk3328_vop_set_clk(struct rk3328_clk_priv *priv,
 				ulong clk_id, uint hz)
 {
 	struct rk3328_cru *cru = priv->cru;
 	int src_clk_div;
-	u32 con, parent;
 
 	src_clk_div = DIV_ROUND_UP(GPLL_HZ, hz);
 	assert(src_clk_div - 1 < 31);
@@ -636,42 +612,25 @@ static ulong rk3328_vop_set_clk(struct rk3328_clk_priv *priv,
 			     (src_clk_div - 1) << ACLK_VIO_DIV_CON_SHIFT);
 		break;
 	case DCLK_LCDC:
-		con = readl(&cru->clksel_con[40]);
-		con = (con & DCLK_LCDC_SEL_MASK) >> DCLK_LCDC_SEL_SHIFT;
-		if (con) {
-			parent = readl(&cru->clksel_con[40]);
-			parent = (parent & DCLK_LCDC_PLL_SEL_MASK) >>
-				 DCLK_LCDC_PLL_SEL_SHIFT;
-			if (parent)
-				src_clk_div = DIV_ROUND_UP(GPLL_HZ, hz);
-			else
-				src_clk_div = DIV_ROUND_UP(GPLL_HZ, hz);
-
-			rk_clrsetreg(&cru->clksel_con[40],
-				     DCLK_LCDC_DIV_CON_MASK,
-				     (src_clk_div - 1) <<
-				     DCLK_LCDC_DIV_CON_SHIFT);
-		}
+		/* Set HDMIPHY clock output to pixel clock */
+		rk_clrsetreg(&cru->misc, HDMIPHY_24M_SEL_MASK,
+			     HDMIPHY_24M_SEL_PCLK << HDMIPHY_24M_SEL_SHIFT);
+		/* Set HDMIPHY as a parent of DCLK_LCDC, and set all divisors to 1 */
+		rk_clrsetreg(&cru->clksel_con[40],
+			     DCLK_LCDC_DIV_CON_MASK | DCLK_LCDC_SEL_MASK | CLK_HDMIPHY_DIV_CON_MASK,
+			     (1 - 1) << CLK_HDMIPHY_DIV_CON_SHIFT |
+			     DCLK_LCDC_SEL_HDMIPHY << DCLK_LCDC_SEL_SHIFT |
+			     (1 - 1) << DCLK_LCDC_DIV_CON_SHIFT);
 		break;
 	default:
 		printf("%s: Unable to set vop clk#%ld\n", __func__, clk_id);
 		return -EINVAL;
 	}
 
-	return rk3328_vop_get_clk(priv, clk_id);
+	return hz;
 }
 #endif
 
-static ulong rk3328_hdmiphy_get_clk(struct rk3328_cru *cru)
-{
-	u32 div, con;
-
-	con = readl(&cru->clksel_con[40]);
-	div = (con & CLK_HDMIPHY_DIV_CON_MASK) >> CLK_HDMIPHY_DIV_CON_SHIFT;
-
-	return DIV_TO_RATE(GPLL_HZ, div);
-}
-
 static ulong rk3328_clk_get_rate(struct clk *clk)
 {
 	struct rk3328_clk_priv *priv = dev_get_priv(clk->dev);
@@ -701,9 +660,6 @@ static ulong rk3328_clk_get_rate(struct clk *clk)
 	case SCLK_SPI:
 		rate = rk3328_spi_get_clk(priv->cru);
 		break;
-	case PCLK_HDMIPHY:
-		rate = rk3328_hdmiphy_get_clk(priv->cru);
-		break;
 	case SCLK_USB3OTG_REF:
 		rate = OSC_HZ;
 		break;
-- 
2.49.0

