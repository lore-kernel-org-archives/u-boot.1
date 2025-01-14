Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DD5E77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 05:26:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08A688061B;
	Tue, 14 Jan 2025 06:26:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BI6VZlsd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B5558069A; Tue, 14 Jan 2025 06:26:27 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF66E8060C
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 06:26:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anarsoul@gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2166f1e589cso106879065ad.3
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 21:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736832383; x=1737437183; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2hs/It3A+yaKNCSWt5T1k8LetOtuEwLnxSQTOw6998I=;
 b=BI6VZlsdh+X7gjg71wdGy1gq5XNnMZDCYu0k+NxXzAQh2qFpytq/dz9YYnzRtsXtFv
 +STZyK80vATZ6mG/JhAdp48GUkEcr2N4ZS1g1gJSTXsIIYYV7mMbof0S1ELKXpgEbM/s
 6P2iG/quBVkF/bP2G1jamwRKuZsDK2/JIJfotpQybO0fAmr/xWqKUeNfhr5yGki1rzRm
 ocAFeqZwhRixebE0OHqMjN9awbbLX7dvPYUVyBxftP8tlxxFuyiFZ1fqn1ZBX4vNPv+H
 SlwOh7fWKJQT1W0BvcR0c+X7n7aCmeRC9zkswnrZoO2qnO3+BOFF203xU56NoyaTha2P
 tT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736832383; x=1737437183;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2hs/It3A+yaKNCSWt5T1k8LetOtuEwLnxSQTOw6998I=;
 b=TCNUL2jPcha0xfyP4grJVoDW6W7Ld4/lA6VbG+lEd8hnECDmObYOTgvwp4AGQ7XOgM
 b5EbEAxONY1NncN8dJF5t5P4jZ9CpXhe1JSsUJloo2nmvy2eEtSan/nxWDiZzoRBihBb
 VfrYXTtL2DQI7HPbnHYwS+wkRjkIqKqjBgc51bJBiw1gNnxC5sNZWONMxUq2pbj82kip
 7gOYuTXLPPXx5XsrQLa3p1W6i0O8+hlAVrRusJaIeFipsWtwagn0xspiN6yqqZXHk6KY
 Yd/XVyO1yhXTQR7cEE5R47qbSwYLoLGvQH8Cy8NpTyNkvKqcNJq6p/QNmxPir9j4pPiL
 8p+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZEt5fwiKd4jAFqemeGrir5/XNq8TUudU6Lqt93W9nw9XQAlYiH6BnUrOqPYDJ5pJyCI/vn9Q=@lists.denx.de
X-Gm-Message-State: AOJu0Yy0sSYzPhMFZVUDXtg93zu/3W+HqE/lGmAFAle8MbQ71FLCPJjl
 bm9Z+QurZbrBMASviynRKsp+XWKY4vDbqklxTieDrYAEEFbCzELq
X-Gm-Gg: ASbGncumoFHEfLF+RCNrp01ZVPjMFdS3V7iSy94Q6rWaOFP56akcg53I1nEsbzq/wWh
 I8aJIbuT6s/8fEAuexZ6n7Y62OJlnA1UuAawdwxWbnfnKTMsVD2LLpNj48Y/0oUT4P+loINiFG0
 EUKGhO1BCqHYXqk5lhuB4Dw9sImRg67y0cFOUAM/WzBdUW6gj3n1iA+n0jLSX17EiF4xjgG3Pfl
 /2WG4EcRLC3OOYQLa4rbVQ27QAS0/f99XY+Imz73a2p5VG7MA==
X-Google-Smtp-Source: AGHT+IHLwfjf93SXPCeS5srtlo34nV4DVDj2DysTgTiWBul85EypgOBIZUndztaVrH3y2z5/vlOd1Q==
X-Received: by 2002:a05:6a00:3e01:b0:725:e057:c3dd with SMTP id
 d2e1a72fcca58-72d21ff4b72mr33912124b3a.22.1736832383044; 
 Mon, 13 Jan 2025 21:26:23 -0800 (PST)
Received: from anarsoul-xps15.lan ([2604:3d08:7780:1ca9::398])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72d40548922sm6713357b3a.30.2025.01.13.21.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2025 21:26:22 -0800 (PST)
From: Vasily Khoruzhick <anarsoul@gmail.com>
To: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Anatolij Gustschin <agust@denx.de>,
 Dragan Simic <dsimic@manjaro.org>, Chen-Yu Tsai <wens@csie.org>,
 Christopher Obbard <chris.obbard@collabora.com>,
 Jagan Teki <jagan@edgeble.ai>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH 1/3] clk: rockchip: rk3328: use HDMIPHY PLL as a clock parent
 for VOP_DCLK
Date: Mon, 13 Jan 2025 21:24:19 -0800
Message-ID: <20250114052548.763611-1-anarsoul@gmail.com>
X-Mailer: git-send-email 2.47.1
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
2.47.1

