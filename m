Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DECBEC3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 17:00:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15B3182A8D;
	Mon,  5 May 2025 18:59:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=riseup.net header.i=@riseup.net header.b="Qz6CDT0p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2040482AB9; Mon,  5 May 2025 18:59:25 +0200 (CEST)
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 339BB82AA8
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 18:59:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danct12@riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx1.riseup.net (Postfix) with ESMTPS id 4Zrnn32DDKzDqdH;
 Mon,  5 May 2025 16:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1746464359; bh=1MBJCGjq3/4ZxIDIo8yMDhPsDqXqM/tEt3dUeXYVB7o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Qz6CDT0pO7paKNjVuSHJUa6XJ3EuOGzfivOyxLwQ4ysK8Kw+I0Hf4YWk7ZWuiH8+f
 2f7XCL1ftJMAOiFPx3O4RiRADpdgEDl14PQGTuDvjb1Fasl5kuArMIyg/iHgyvVZEV
 wT+xvk8Ycr8XQgkhRUrq0vKlkCYiOGW2adq9jP+s=
X-Riseup-User-ID: D604AA2635BA117CB4E389E0A20EB71337ED3469F3ECA62CE7930BD8B7D61D4B
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4Zrnmz64ZnzJsNx;
 Mon,  5 May 2025 16:59:15 +0000 (UTC)
From: Dang Huynh <danct12@riseup.net>
Date: Mon, 05 May 2025 23:58:26 +0700
Subject: [PATCH v4 10/12] video: rockchip: Add HDMI support for RK3568
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-vop2-pt2-v4-10-3b7c3ab1a617@riseup.net>
References: <20250505-vop2-pt2-v4-0-3b7c3ab1a617@riseup.net>
In-Reply-To: <20250505-vop2-pt2-v4-0-3b7c3ab1a617@riseup.net>
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
index 0000000000000000000000000000000000000000..104b734eeada92d1574b1ff6e7a314990fb732c7
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
2.49.0

