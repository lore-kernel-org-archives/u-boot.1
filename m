Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 705D2C44521
	for <u-boot@archiver.kernel.org>; Sun, 19 Jul 2026 01:59:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65D0F8467B;
	Sun, 19 Jul 2026 03:59:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F5DF8467B; Sun, 19 Jul 2026 03:59:20 +0200 (CEST)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCA0E8493F
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 03:59:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wlGo7-000000001pY-2SA6; Sun, 19 Jul 2026 01:59:07 +0000
Date: Sun, 19 Jul 2026 02:59:04 +0100
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
Subject: [PATCH 3/9] video: rockchip: Add HDMI support for RK3568
Message-ID: <55bba8f7c9f56e8a4b27da56a3bd596265bf00bf.1784424101.git.daniel@makrotopia.org>
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

From: Dang Huynh <dang.huynh@mainlining.org>

HDMI on RK3568 is mostly simplified, all this does is enabling
DDC for display timings and HPD.

Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
---
 drivers/video/rockchip/Makefile      |  1 +
 drivers/video/rockchip/rk3568_hdmi.c | 71 ++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)
 create mode 100644 drivers/video/rockchip/rk3568_hdmi.c

diff --git a/drivers/video/rockchip/Makefile b/drivers/video/rockchip/Makefile
index 2f89a979a28..b751c969b46 100644
--- a/drivers/video/rockchip/Makefile
+++ b/drivers/video/rockchip/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_DISPLAY_ROCKCHIP_LVDS) += rk_lvds.o
 obj-hdmi-$(CONFIG_ROCKCHIP_RK3288) += rk3288_hdmi.o
 obj-hdmi-$(CONFIG_ROCKCHIP_RK3328) += rk3328_hdmi.o
 obj-hdmi-$(CONFIG_ROCKCHIP_RK3399) += rk3399_hdmi.o
+obj-hdmi-$(CONFIG_ROCKCHIP_RK3568) += rk3568_hdmi.o
 obj-$(CONFIG_DISPLAY_ROCKCHIP_HDMI) += rk_hdmi.o $(obj-hdmi-y)
 obj-mipi-$(CONFIG_ROCKCHIP_RK3288) += rk3288_mipi.o
 obj-mipi-$(CONFIG_ROCKCHIP_RK3399) += rk3399_mipi.o
diff --git a/drivers/video/rockchip/rk3568_hdmi.c b/drivers/video/rockchip/rk3568_hdmi.c
new file mode 100644
index 00000000000..c3f4504ca8f
--- /dev/null
+++ b/drivers/video/rockchip/rk3568_hdmi.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2024 - 2025 Dang Huynh <dang.huynh@mainlining.org>
+ */
+
+#include <display.h>
+#include <dm.h>
+#include <dw_hdmi.h>
+#include <edid.h>
+#include <asm/arch-rockchip/hardware.h>
+#include <asm/arch-rockchip/grf_rk3568.h>
+#include "rk_hdmi.h"
+
+#define RK3568_IO_DDC_IN_MSK             ((3 << 14) | (3 << (14 + 16)))
+
+static int rk3568_hdmi_enable(struct udevice *dev, int panel_bpp,
+			      const struct display_timing *edid)
+{
+	struct rk_hdmi_priv *priv = dev_get_priv(dev);
+
+	return dw_hdmi_enable(&priv->hdmi, edid);
+}
+
+static int rk3568_hdmi_of_to_plat(struct udevice *dev)
+{
+	struct rk_hdmi_priv *priv = dev_get_priv(dev);
+	struct dw_hdmi *hdmi = &priv->hdmi;
+
+	hdmi->i2c_clk_high = 0x6c;
+	hdmi->i2c_clk_low = 0x7d;
+
+	return rk_hdmi_of_to_plat(dev);
+}
+
+static const char * const rk3568_hdmi_reg_names[] = {
+	"avdd-0v9",
+	"avdd-1v8"
+};
+
+static int rk3568_hdmi_probe(struct udevice *dev)
+{
+	struct rk_hdmi_priv *priv = dev_get_priv(dev);
+	struct rk3568_grf *grf = priv->grf;
+
+	rk_hdmi_probe_regulators(dev, rk3568_hdmi_reg_names,
+				 ARRAY_SIZE(rk3568_hdmi_reg_names));
+
+	writel(RK3568_IO_DDC_IN_MSK, &grf->vo_con1);
+
+	return rk_hdmi_probe(dev);
+}
+
+static const struct dm_display_ops rk3568_hdmi_ops = {
+	.read_edid = rk_hdmi_read_edid,
+	.enable = rk3568_hdmi_enable,
+};
+
+static const struct udevice_id rk3568_hdmi_ids[] = {
+	{ .compatible = "rockchip,rk3568-dw-hdmi" },
+	{ }
+};
+
+U_BOOT_DRIVER(rk3568_hdmi_rockchip) = {
+	.name = "rk3568_hdmi_rockchip",
+	.id = UCLASS_DISPLAY,
+	.of_match = rk3568_hdmi_ids,
+	.ops = &rk3568_hdmi_ops,
+	.of_to_plat = rk3568_hdmi_of_to_plat,
+	.probe = rk3568_hdmi_probe,
+	.priv_auto = sizeof(struct rk_hdmi_priv),
+};
-- 
2.55.0
