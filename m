Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC124C4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 09:02:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 433C6876DD;
	Mon, 11 Dec 2023 10:01:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KP00wXGi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73FCA876C9; Mon, 11 Dec 2023 10:01:24 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23BC0876DC
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 10:01:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-28a1625b503so3679650a91.2
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 01:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702285280; x=1702890080;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uLXJwpbcaWQ+Pdp0+Q8qfhgd32qZtHwBmr+zOTFHryY=;
 b=KP00wXGi2XHt51Tt9iccKymWZQ113erl2uqwR7iXm7rt+5jRQsGUy9jvufOQFb5NFb
 8m7Tm0s/N6cRd20MWaXaA9pFAqAuYgVNp4+IKR99aT9gmkWxLJK9vSGBxAnjcFF6OcCA
 JHoeuN3BjXyaobAG0ONkSciBWq6/PRS2MuONo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702285280; x=1702890080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uLXJwpbcaWQ+Pdp0+Q8qfhgd32qZtHwBmr+zOTFHryY=;
 b=i2d6bBT3mpcTsBi7UT8JwyoYMdgFkU7Ztp1/0ePCZ8KzBNgTUQWRefFEsaNsLygPPF
 Xsib+IsCCx9/qJwwTIGWuXrRL1yfQLEizFzin4fQYdpLqv2+CJ3wujf99/2pg0EfoMv/
 NaSxOtZe0zCFuEGtFN3JF3YbRid33W29hmkaUO2PepUOS7LOXF2xaYlD2Yb+q8OU7gko
 OP/u6I1iDBpfgwWMbLLoYVzdt0MbTJ0mSgO/qNz+f3ffQJIMaa5rqxVtIkFjE7XBHfOx
 4h0JOLc4QAm+azerqb+Pl7snnuyDoIBqmHXfHkCEyZtbidR5E8YDlH0lW/ns/CVzlJsV
 u6PA==
X-Gm-Message-State: AOJu0YwLy4XHGdd2fBvSVGGwxDD+lVxolXNfosb/2oG9OEPAkCFTjKMF
 bnVWDbW1vqt/TodaPrBJ46Ch1w==
X-Google-Smtp-Source: AGHT+IERydaR1dLPa3aVbu1lerYMIZXCG9ITmqAqDB1yACHLDVLmK4uvbrryTsYlqwcOWOgeSA4g5Q==
X-Received: by 2002:a17:90a:51e2:b0:288:7c05:b249 with SMTP id
 u89-20020a17090a51e200b002887c05b249mr2904929pjh.81.1702285280466; 
 Mon, 11 Dec 2023 01:01:20 -0800 (PST)
Received: from localhost.localdomain ([49.205.242.204])
 by smtp.gmail.com with ESMTPSA id
 e21-20020a170902d39500b001cfb93fa4fasm6080779pld.150.2023.12.11.01.01.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 01:01:19 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: u-boot@lists.denx.de, Da Xue <da.xue@libretech.co>,
 Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH 09/17] clk: rockchip: rk3328: Add VOP clk support
Date: Mon, 11 Dec 2023 14:29:31 +0530
Message-Id: <20231211085939.5478-10-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231211085939.5478-1-jagan@amarulasolutions.com>
References: <20231211085939.5478-1-jagan@amarulasolutions.com>
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
 .../include/asm/arch-rockchip/cru_rk3328.h    | 34 ++++++++
 drivers/clk/rockchip/clk_rk3328.c             | 83 ++++++++++++++++++-
 2 files changed, 115 insertions(+), 2 deletions(-)

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
index ef97381f0e..7fcf84f08e 100644
--- a/drivers/clk/rockchip/clk_rk3328.c
+++ b/drivers/clk/rockchip/clk_rk3328.c
@@ -581,6 +581,81 @@ static ulong rk3328_spi_set_clk(struct rk3328_cru *cru, uint hz)
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
+	default:
+		debug("%s: Unsupported vop get clk#%ld\n", __func__, clk_id);
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
@@ -649,7 +724,13 @@ static ulong rk3328_clk_set_rate(struct clk *clk, ulong rate)
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
@@ -664,11 +745,9 @@ static ulong rk3328_clk_set_rate(struct clk *clk, ulong rate)
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

