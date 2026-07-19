Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC490C4450A
	for <u-boot@archiver.kernel.org>; Sun, 19 Jul 2026 02:00:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32B1080517;
	Sun, 19 Jul 2026 04:00:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F1F5846B0; Sun, 19 Jul 2026 04:00:15 +0200 (CEST)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 677B280398
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 04:00:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wlGot-000000001ql-0PEr; Sun, 19 Jul 2026 01:59:55 +0000
Date: Sun, 19 Jul 2026 02:59:52 +0100
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
Subject: [PATCH 6/9] video: rockchip: rk3568: ungate the HDMI controller clocks
Message-ID: <acea05b10adc77f4207271b2f6ff7aa19c5765fa.1784424101.git.daniel@makrotopia.org>
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

The RK3568 HDMI probe polled the PHY hot-plug-detect status but always
timed out ('hdmi can not get hpd signal', -ENODEV), so the controller
never probed and HDMI output was dead even with a monitor attached.

The HDMI controller clocks are never enabled: neither the dw_hdmi glue
nor the RK3568 clock driver manages the pclk_hdmi_host / clk_hdmi_sfr /
clk_hdmi_cec gates (CLKGATE_CON21 bits 3-5). clk_hdmi_sfr feeds the
controller/PHY logic that produces the HPD status and is parented off
xin24m, independent of the pclk_vo domain that VOP2 bring-up enables, so
it stayed gated: register reads returned a clean zero and the HPD bit
never asserted. Mainline Linux enables isfr/iahb before reading the same
HDMI_PHY_STAT0 HPD bit.

Ungate the three HDMI gates in rk3568_hdmi_probe() before probing the
controller.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/video/rockchip/rk3568_hdmi.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/video/rockchip/rk3568_hdmi.c b/drivers/video/rockchip/rk3568_hdmi.c
index c3f4504ca8f..7b2034d6b3f 100644
--- a/drivers/video/rockchip/rk3568_hdmi.c
+++ b/drivers/video/rockchip/rk3568_hdmi.c
@@ -7,12 +7,18 @@
 #include <dm.h>
 #include <dw_hdmi.h>
 #include <edid.h>
+#include <asm/arch-rockchip/clock.h>
+#include <asm/arch-rockchip/cru_rk3568.h>
 #include <asm/arch-rockchip/hardware.h>
 #include <asm/arch-rockchip/grf_rk3568.h>
 #include "rk_hdmi.h"
 
 #define RK3568_IO_DDC_IN_MSK             ((3 << 14) | (3 << (14 + 16)))
 
+/* CLKGATE_CON21: pclk_hdmi_host (b3), clk_hdmi_sfr (b4), clk_hdmi_cec (b5) */
+#define RK3568_HDMI_CLKGATE_CON		21
+#define RK3568_HDMI_CLKGATE_MSK		(0x7 << 3)
+
 static int rk3568_hdmi_enable(struct udevice *dev, int panel_bpp,
 			      const struct display_timing *edid)
 {
@@ -41,10 +47,21 @@ static int rk3568_hdmi_probe(struct udevice *dev)
 {
 	struct rk_hdmi_priv *priv = dev_get_priv(dev);
 	struct rk3568_grf *grf = priv->grf;
+	struct rk3568_cru *cru = rockchip_get_cru();
 
 	rk_hdmi_probe_regulators(dev, rk3568_hdmi_reg_names,
 				 ARRAY_SIZE(rk3568_hdmi_reg_names));
 
+	/*
+	 * Ungate the HDMI controller clocks. The RK3568 clock driver does
+	 * not manage these gates, and clk_hdmi_sfr in particular must be
+	 * running for the PHY hot-plug-detect status to be valid; without it
+	 * the HPD poll times out and the controller is not probed.
+	 */
+	if (cru)
+		rk_clrreg(&cru->clkgate_con[RK3568_HDMI_CLKGATE_CON],
+			  RK3568_HDMI_CLKGATE_MSK);
+
 	writel(RK3568_IO_DDC_IN_MSK, &grf->vo_con1);
 
 	return rk_hdmi_probe(dev);
-- 
2.55.0
