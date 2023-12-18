Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E67F1C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 19:12:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FCE087600;
	Mon, 18 Dec 2023 20:12:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="q8vtYhBM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30092876A2; Mon, 18 Dec 2023 20:12:08 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56C6E87600
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 20:12:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d3ad3ad517so6751365ad.0
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 11:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702926721; x=1703531521;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t5lvWoxoYLgIiTPq1Vjagg1G0LRczYhe09Qgo+afnmk=;
 b=q8vtYhBMf3K0bHWVTnSpYJtYqHGO7jTXFT40aThYeWXbYUwVDD0SiwFxhCif3/k5eZ
 5YYv8ukVkmvlcNByx5v+7nBzFD7zUxNzV0eKlOThPcFazC7yIjh37kTrcTvmJxvitIBP
 uKowKy+KwnDMvZx35uw16X1mmDmoq5E3a7log=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702926721; x=1703531521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t5lvWoxoYLgIiTPq1Vjagg1G0LRczYhe09Qgo+afnmk=;
 b=HJjugyMk2XK+AI66HhwomIDs2lyxTBPU/O3eRzRxdtyCfbc/MCNECyRFP+E52nI6Tv
 ifBZbULG/g3xG7/900D4rmF3IIyr2pC+sjQWGYRHQbDMuB8uauFG4WQt5kaJnjLde5kd
 0GFlz4mEH84CIAy4Iae/vxPJZkpjISlAAgIwpmVHPUfxfn672HwUnjhVVKYuEQ8+WXsR
 lPKh87/cWJq3X90CJKx7NnPt/q43NWnhm5OTz4ZnotgUuOa0FGIqVyx8rASSJa+QMrhc
 VulR9BmbvwFVwxlq57fygZWfTIb8SG8js02zm/Deyj2c3UkCnMBBnZ+vRS+6XhYHgjTi
 zehg==
X-Gm-Message-State: AOJu0YzWsGNf1GaQCW7xIRX2Hl9cMIx0IuiOyJwNiVGo/khRHKHn2Rlg
 TknUvIze1LmqvGy6CqLZNjsS/w==
X-Google-Smtp-Source: AGHT+IG6iyUCXjv6nr8/Q2/ZuwYuaaGiarBzl2ZNHYYfgUgr5bZDu0yuJwdJVexl6R6KJJvuTRnTvA==
X-Received: by 2002:a17:903:2446:b0:1d0:cec3:4569 with SMTP id
 l6-20020a170903244600b001d0cec34569mr9534050pls.100.1702926721079; 
 Mon, 18 Dec 2023 11:12:01 -0800 (PST)
Received: from localhost.localdomain ([49.205.242.204])
 by smtp.gmail.com with ESMTPSA id
 pt10-20020a17090b3d0a00b0028afd8b1e0bsm2873941pjb.57.2023.12.18.11.11.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 11:12:00 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Robin Murphy <robin.murphy@arm.com>, u-boot@lists.denx.de,
 Da Xue <da.xue@libretech.co>, Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH v2 09/17] clk: rockchip: rk3328: Add VOP clk support
Date: Tue, 19 Dec 2023 00:41:06 +0530
Message-Id: <20231218191114.129329-10-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218191114.129329-1-jagan@amarulasolutions.com>
References: <20231218191114.129329-1-jagan@amarulasolutions.com>
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

From: Jagan Teki <jagan@edgeble.ai>

VOP get and set clock would needed for VOP drivers.

Add support for it.

Signed-off-by: Jagan Teki <jagan@edgeble.ai>
---
Changes for v2:
- Add DCLK get rate

 .../include/asm/arch-rockchip/cru_rk3328.h    | 34 +++++++
 drivers/clk/rockchip/clk_rk3328.c             | 88 ++++++++++++++++++-
 2 files changed, 120 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3328.h b/arch/arm/include/asm/arch-rockchip/cru_rk3328.h
index 226744d67d..4ad1d33e05 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3328.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3328.h
@@ -62,6 +62,40 @@ check_member(rk3328_cru, sdmmc_ext_con[1], 0x39c);
 enum apll_frequencies {
 	APLL_816_MHZ,
 	APLL_600_MHZ,
+
+	/* CRU_CLK_SEL37_CON */
+	ACLK_VIO_PLL_SEL_CPLL		= 0,
+	ACLK_VIO_PLL_SEL_GPLL		= 1,
+	ACLK_VIO_PLL_SEL_HDMIPHY	= 2,
+	ACLK_VIO_PLL_SEL_USB480M	= 3,
+	ACLK_VIO_PLL_SEL_SHIFT		= 6,
+	ACLK_VIO_PLL_SEL_MASK		= 3 << ACLK_VIO_PLL_SEL_SHIFT,
+	ACLK_VIO_DIV_CON_SHIFT		= 0,
+	ACLK_VIO_DIV_CON_MASK		= 0x1f << ACLK_VIO_DIV_CON_SHIFT,
+	HCLK_VIO_DIV_CON_SHIFT		= 8,
+	HCLK_VIO_DIV_CON_MASK		= 0x1f << HCLK_VIO_DIV_CON_SHIFT,
+
+	/* CRU_CLK_SEL39_CON */
+	ACLK_VOP_PLL_SEL_CPLL		= 0,
+	ACLK_VOP_PLL_SEL_GPLL		= 1,
+	ACLK_VOP_PLL_SEL_HDMIPHY	= 2,
+	ACLK_VOP_PLL_SEL_USB480M	= 3,
+	ACLK_VOP_PLL_SEL_SHIFT		= 6,
+	ACLK_VOP_PLL_SEL_MASK		= 3 << ACLK_VOP_PLL_SEL_SHIFT,
+	ACLK_VOP_DIV_CON_SHIFT		= 0,
+	ACLK_VOP_DIV_CON_MASK		= 0x1f << ACLK_VOP_DIV_CON_SHIFT,
+
+	/* CRU_CLK_SEL40_CON */
+	DCLK_LCDC_PLL_SEL_GPLL		= 0,
+	DCLK_LCDC_PLL_SEL_CPLL		= 1,
+	DCLK_LCDC_PLL_SEL_SHIFT		= 0,
+	DCLK_LCDC_PLL_SEL_MASK		= 1 << DCLK_LCDC_PLL_SEL_SHIFT,
+	DCLK_LCDC_SEL_HDMIPHY		= 0,
+	DCLK_LCDC_SEL_PLL		= 1,
+	DCLK_LCDC_SEL_SHIFT		= 1,
+	DCLK_LCDC_SEL_MASK		= 1 << DCLK_LCDC_SEL_SHIFT,
+	DCLK_LCDC_DIV_CON_SHIFT		= 8,
+	DCLK_LCDC_DIV_CON_MASK		= 0xFf << DCLK_LCDC_DIV_CON_SHIFT,
 };
 
 void rk3328_configure_cpu(struct rk3328_cru *cru,
diff --git a/drivers/clk/rockchip/clk_rk3328.c b/drivers/clk/rockchip/clk_rk3328.c
index ef97381f0e..ee7edb9d10 100644
--- a/drivers/clk/rockchip/clk_rk3328.c
+++ b/drivers/clk/rockchip/clk_rk3328.c
@@ -581,6 +581,86 @@ static ulong rk3328_spi_set_clk(struct rk3328_cru *cru, uint hz)
 	return rk3328_spi_get_clk(cru);
 }
 
+#ifndef CONFIG_SPL_BUILD
+static ulong rk3328_vop_get_clk(struct rk3328_clk_priv *priv, ulong clk_id)
+{
+	struct rk3328_cru *cru = priv->cru;
+	u32 div, con, parent;
+
+	switch (clk_id) {
+	case ACLK_VOP_PRE:
+		con = readl(&cru->clksel_con[39]);
+		div = (con & ACLK_VOP_DIV_CON_MASK) >> ACLK_VOP_DIV_CON_SHIFT;
+		parent = GPLL_HZ;
+		break;
+	case ACLK_VIO_PRE:
+		con = readl(&cru->clksel_con[37]);
+		div = (con & ACLK_VIO_DIV_CON_MASK) >> ACLK_VIO_DIV_CON_SHIFT;
+		parent = GPLL_HZ;
+		break;
+	case DCLK_LCDC:
+		con = readl(&cru->clksel_con[40]);
+		div = (con & DCLK_LCDC_DIV_CON_MASK) >> DCLK_LCDC_DIV_CON_SHIFT;
+		parent = GPLL_HZ;
+		break;
+	default:
+		printf("%s: Unsupported vop get clk#%ld\n", __func__, clk_id);
+		return -ENOENT;
+	}
+
+	return DIV_TO_RATE(parent, div);
+}
+
+static ulong rk3328_vop_set_clk(struct rk3328_clk_priv *priv,
+				ulong clk_id, uint hz)
+{
+	struct rk3328_cru *cru = priv->cru;
+	int src_clk_div;
+	u32 con, parent;
+
+	src_clk_div = DIV_ROUND_UP(GPLL_HZ, hz);
+	assert(src_clk_div - 1 < 31);
+
+	switch (clk_id) {
+	case ACLK_VOP_PRE:
+		rk_clrsetreg(&cru->clksel_con[39],
+			     ACLK_VOP_PLL_SEL_MASK | ACLK_VOP_DIV_CON_MASK,
+			     ACLK_VOP_PLL_SEL_CPLL << ACLK_VOP_PLL_SEL_SHIFT |
+			     (src_clk_div - 1) << ACLK_VOP_DIV_CON_SHIFT);
+		break;
+	case ACLK_VIO_PRE:
+		rk_clrsetreg(&cru->clksel_con[37],
+			     ACLK_VIO_PLL_SEL_MASK | ACLK_VIO_DIV_CON_MASK,
+			     ACLK_VIO_PLL_SEL_CPLL << ACLK_VIO_PLL_SEL_SHIFT |
+			     (src_clk_div - 1) << ACLK_VIO_DIV_CON_SHIFT);
+		break;
+	case DCLK_LCDC:
+		con = readl(&cru->clksel_con[40]);
+		con = (con & DCLK_LCDC_SEL_MASK) >> DCLK_LCDC_SEL_SHIFT;
+		if (con) {
+			parent = readl(&cru->clksel_con[40]);
+			parent = (parent & DCLK_LCDC_PLL_SEL_MASK) >>
+				 DCLK_LCDC_PLL_SEL_SHIFT;
+			if (parent)
+				src_clk_div = DIV_ROUND_UP(GPLL_HZ, hz);
+			else
+				src_clk_div = DIV_ROUND_UP(GPLL_HZ, hz);
+
+			rk_clrsetreg(&cru->clksel_con[40],
+				     DCLK_LCDC_DIV_CON_MASK,
+				     (src_clk_div - 1) <<
+				     DCLK_LCDC_DIV_CON_SHIFT);
+		}
+		break;
+	default:
+		printf("%s: Unable to set vop clk#%ld\n", __func__, clk_id);
+		return -EINVAL;
+	}
+
+	return rk3328_vop_get_clk(priv, clk_id);
+}
+#endif
+
 static ulong rk3328_clk_get_rate(struct clk *clk)
 {
 	struct rk3328_clk_priv *priv = dev_get_priv(clk->dev);
@@ -649,7 +729,13 @@ static ulong rk3328_clk_set_rate(struct clk *clk, ulong rate)
 	case SCLK_SPI:
 		ret = rk3328_spi_set_clk(priv->cru, rate);
 		break;
+#ifndef CONFIG_SPL_BUILD
 	case DCLK_LCDC:
+	case ACLK_VOP_PRE:
+	case ACLK_VIO_PRE:
+		rate = rk3328_vop_set_clk(priv, clk->id, rate);
+		break;
+#endif
 	case SCLK_PDM:
 	case SCLK_RTC32K:
 	case SCLK_UART0:
@@ -664,11 +750,9 @@ static ulong rk3328_clk_set_rate(struct clk *clk, ulong rate)
 	case ACLK_PERI_PRE:
 	case HCLK_PERI:
 	case PCLK_PERI:
-	case ACLK_VIO_PRE:
 	case HCLK_VIO_PRE:
 	case ACLK_RGA_PRE:
 	case SCLK_RGA:
-	case ACLK_VOP_PRE:
 	case ACLK_RKVDEC_PRE:
 	case ACLK_RKVENC:
 	case ACLK_VPU_PRE:
-- 
2.25.1

