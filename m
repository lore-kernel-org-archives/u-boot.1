Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C598BC4450A
	for <u-boot@archiver.kernel.org>; Sun, 19 Jul 2026 02:03:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C51484A49;
	Sun, 19 Jul 2026 04:03:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D698984A4F; Sun, 19 Jul 2026 04:03:12 +0200 (CEST)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E414684A1A
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 04:03:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wlGp3-000000001r4-3r4N; Sun, 19 Jul 2026 02:00:06 +0000
Date: Sun, 19 Jul 2026 03:00:03 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tianling Shen <cnsztl@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Lukasz Majewski <lukma@denx.de>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Dang Huynh <dang.huynh@mainlining.org>,
 Daniel Golle <daniel@makrotopia.org>, Peng Fan <peng.fan@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>,
 u-boot@lists.denx.de
Subject: [PATCH 7/9] video: rockchip: rk3568: bring up the HDMI PHY reference
 clock
Message-ID: <aaaf6d082cbe34acd779af040306e582b91c8360.1784424101.git.daniel@makrotopia.org>
References: <cover.1784424101.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1784424101.git.daniel@makrotopia.org>
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

Add CLK_HDMI_REF support to the RK3568 PMU clock driver (route the mux to
HPLL and set the HPLL rate) and enable it from the HDMI driver: at probe
to a default rate, and at modeset to the pixel clock, matching mainline
Linux. The RK3568 HDMI PHY needs its reference clock running for output.

Note: this alone does not make hot-plug-detect work in U-Boot; the PHY
still reports no HPD (PHY_STAT0=0) with a monitor attached despite the
controller being live. The remaining HDMI PHY bring-up gap is unresolved.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/clk/rockchip/clk_rk3568.c    | 12 ++++++++++++
 drivers/video/rockchip/rk3568_hdmi.c | 24 +++++++++++++++++++++---
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
index c8e8e1d4f7d..61eb813577b 100644
--- a/drivers/clk/rockchip/clk_rk3568.c
+++ b/drivers/clk/rockchip/clk_rk3568.c
@@ -377,6 +377,10 @@ static ulong rk3568_pmuclk_get_rate(struct clk *clk)
 	case PCLK_PMU:
 		rate = rk3568_pmu_get_pmuclk(priv);
 		break;
+	case CLK_HDMI_REF:
+		rate = rockchip_pll_get_rate(&rk3568_pll_clks[HPLL],
+					     priv->pmucru, HPLL);
+		break;
 	default:
 		return -ENOENT;
 	}
@@ -408,6 +412,14 @@ static ulong rk3568_pmuclk_set_rate(struct clk *clk, ulong rate)
 		priv->hpll_hz = rockchip_pll_get_rate(&rk3568_pll_clks[HPLL],
 						      priv->pmucru, HPLL);
 		break;
+	case CLK_HDMI_REF:
+		/* clk_hdmi_ref is HPLL via PMU_CLKSEL_CON8 bit7 (0 = hpll) */
+		ret = rockchip_pll_set_rate(&rk3568_pll_clks[HPLL],
+					    priv->pmucru, HPLL, rate);
+		priv->hpll_hz = rockchip_pll_get_rate(&rk3568_pll_clks[HPLL],
+						      priv->pmucru, HPLL);
+		rk_clrsetreg(&priv->pmucru->pmu_clksel_con[8], BIT(7), 0);
+		break;
 	case CLK_RTC_32K:
 	case CLK_RTC32K_FRAC:
 		ret = rk3568_rtc32k_set_pmuclk(priv, rate);
diff --git a/drivers/video/rockchip/rk3568_hdmi.c b/drivers/video/rockchip/rk3568_hdmi.c
index 7b2034d6b3f..9b3e54ce6fd 100644
--- a/drivers/video/rockchip/rk3568_hdmi.c
+++ b/drivers/video/rockchip/rk3568_hdmi.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2024 - 2025 Dang Huynh <dang.huynh@mainlining.org>
  */
 
+#include <clk.h>
 #include <display.h>
 #include <dm.h>
 #include <dw_hdmi.h>
@@ -13,6 +14,9 @@
 #include <asm/arch-rockchip/grf_rk3568.h>
 #include "rk_hdmi.h"
 
+/* Default HDMI PHY reference rate to bring HPLL up for hot-plug detect */
+#define RK3568_HDMI_REF_DEFAULT		148500000
+
 #define RK3568_IO_DDC_IN_MSK             ((3 << 14) | (3 << (14 + 16)))
 
 /* CLKGATE_CON21: pclk_hdmi_host (b3), clk_hdmi_sfr (b4), clk_hdmi_cec (b5) */
@@ -23,6 +27,11 @@ static int rk3568_hdmi_enable(struct udevice *dev, int panel_bpp,
 			      const struct display_timing *edid)
 {
 	struct rk_hdmi_priv *priv = dev_get_priv(dev);
+	struct clk ref_clk;
+
+	/* Drive the PHY reference at the pixel clock for this mode */
+	if (!clk_get_by_name(dev, "ref", &ref_clk))
+		clk_set_rate(&ref_clk, edid->pixelclock.typ);
 
 	return dw_hdmi_enable(&priv->hdmi, edid);
 }
@@ -48,20 +57,29 @@ static int rk3568_hdmi_probe(struct udevice *dev)
 	struct rk_hdmi_priv *priv = dev_get_priv(dev);
 	struct rk3568_grf *grf = priv->grf;
 	struct rk3568_cru *cru = rockchip_get_cru();
+	struct clk ref_clk;
 
 	rk_hdmi_probe_regulators(dev, rk3568_hdmi_reg_names,
 				 ARRAY_SIZE(rk3568_hdmi_reg_names));
 
 	/*
 	 * Ungate the HDMI controller clocks. The RK3568 clock driver does
-	 * not manage these gates, and clk_hdmi_sfr in particular must be
-	 * running for the PHY hot-plug-detect status to be valid; without it
-	 * the HPD poll times out and the controller is not probed.
+	 * not manage these gates.
 	 */
 	if (cru)
 		rk_clrreg(&cru->clkgate_con[RK3568_HDMI_CLKGATE_CON],
 			  RK3568_HDMI_CLKGATE_MSK);
 
+	/*
+	 * Bring up the PHY reference clock (clk_hdmi_ref off HPLL) before
+	 * probing: the internal HDMI PHY needs its reference running for the
+	 * hot-plug-detect status to be valid, otherwise the HPD poll times
+	 * out and the controller is not probed. Mainline Linux likewise
+	 * enables this clock at probe.
+	 */
+	if (!clk_get_by_name(dev, "ref", &ref_clk))
+		clk_set_rate(&ref_clk, RK3568_HDMI_REF_DEFAULT);
+
 	writel(RK3568_IO_DDC_IN_MSK, &grf->vo_con1);
 
 	return rk_hdmi_probe(dev);
-- 
2.55.0
