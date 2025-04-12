Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 262BDC369B2
	for <u-boot@archiver.kernel.org>; Sat, 12 Apr 2025 14:32:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 727DA82EA5;
	Sat, 12 Apr 2025 16:31:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=riseup.net header.i=@riseup.net header.b="Ra/wCw9D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56AE282E40; Sat, 12 Apr 2025 16:31:52 +0200 (CEST)
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75A8882E6A
 for <u-boot@lists.denx.de>; Sat, 12 Apr 2025 16:31:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danct12@riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx1.riseup.net (Postfix) with ESMTPS id 4ZZbbR4BQVzDqND;
 Sat, 12 Apr 2025 14:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1744468307; bh=BKCjCitKSU+PTZAWQSwzqB+734fRMOc6WlysHuK9/pI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Ra/wCw9Dns/MZcB1bQ2fQyy8FvkqEW7yqOFEZF8zxZbWNb8RZRyfnBBY91yDkRIx6
 WtBm2PBDvNe3l/MADdJ97owG9TpAXWHGp/nzNc0vW3jZTjIoU8GnT8KGfCWQJNo8ii
 fw1KnUwsh9iy/h9sgoNpuoHTUQmSI46Uf/Ex0Tms=
X-Riseup-User-ID: 0B35697846CB9D14E0A536D8BB9C15CC242BD746988992E0D4951D53FFB4D4C8
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4ZZbbN0bVFzJtSD;
 Sat, 12 Apr 2025 14:31:43 +0000 (UTC)
From: Dang Huynh <danct12@riseup.net>
Date: Sat, 12 Apr 2025 21:27:12 +0700
Subject: [PATCH v3 10/12] video: rockchip: Add HDMI support for RK3568
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250412-vop2-pt2-v3-10-7c796db335e9@riseup.net>
References: <20250412-vop2-pt2-v3-0-7c796db335e9@riseup.net>
In-Reply-To: <20250412-vop2-pt2-v3-0-7c796db335e9@riseup.net>
To: Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Ondrej Jirman <megi@xff.cz>, 
 Dragan Simic <dsimic@manjaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, u-boot@lists.denx.de, 
 Piotr Zalewski <pZ010001011111@proton.me>, Dang Huynh <danct12@riseup.net>
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

HDMI on RK3568 is mostly simplified, all this does is enabling
DDC for display timings and HPD.

Signed-off-by: Dang Huynh <danct12@riseup.net>
---
 drivers/video/rockchip/Makefile      |  1 +
 drivers/video/rockchip/rk3568_hdmi.c | 71 ++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/drivers/video/rockchip/Makefile b/drivers/video/rockchip/Makefile
index 2f89a979a2848733be5a6d05817ad76ce3ad3a34..b751c969b46f1933e91a6c0434f31227a709d8e5 100644
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
index 0000000000000000000000000000000000000000..5578ea37243a5735713d92572639cdc8ba9865cf
--- /dev/null
+++ b/drivers/video/rockchip/rk3568_hdmi.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2024 Dang Huynh <danct12@riseup.net>
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
+	hdmi->i2c_clk_high = 0x71;
+	hdmi->i2c_clk_low = 0x76;
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
+	.priv_auto	= sizeof(struct rk_hdmi_priv),
+};

-- 
2.49.0

