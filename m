Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC93C02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 13:06:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B05F380771;
	Thu, 16 Jan 2025 14:05:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=riseup.net header.i=@riseup.net header.b="WBAzJo83";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6F0F80658; Thu, 16 Jan 2025 10:16:40 +0100 (CET)
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B43CA801B0
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 10:16:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danct12@riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx1.riseup.net (Postfix) with ESMTPS id 4YYcgS6hg5zDqnp;
 Thu, 16 Jan 2025 09:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1737018997; bh=gxfh8dvaNkvtlIy1U5hPRw5sNkPCFpLy39iWlovmm0k=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=WBAzJo83T/4n5Njv7ijD0Yugu3Sl1QufiySGkiI0fvEboNwLdbpPttW1dV+uuKXGB
 6a+7NI12tlHYSZwlscNfslAwClJcQVgc6Kwmaayx86Vzx53V+6u1uXUFBUQYGFqqvg
 duh8+QuFc6Lp87akd7948XhQfpzRZKNkKwtIOHJo=
X-Riseup-User-ID: 3FE3AD4DD1165D28901EC44837C549F34F4C1E90DBB4C59A3B98EC1194E00D13
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4YYcgQ1FLbzJq7r;
 Thu, 16 Jan 2025 09:16:33 +0000 (UTC)
From: Dang Huynh <danct12@riseup.net>
Date: Thu, 16 Jan 2025 16:15:55 +0700
Subject: [PATCH 06/10] video: rockchip: vop2: Add video bridge support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-vop2-pt2-v1-6-c9d646b53930@riseup.net>
References: <20250116-vop2-pt2-v1-0-c9d646b53930@riseup.net>
In-Reply-To: <20250116-vop2-pt2-v1-0-c9d646b53930@riseup.net>
To: Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Ondrej Jirman <megi@xff.cz>, 
 Dragan Simic <dsimic@manjaro.org>
Cc: u-boot@lists.denx.de, Dang Huynh <danct12@riseup.net>
X-Mailman-Approved-At: Thu, 16 Jan 2025 14:05:20 +0100
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

Add support for the MIPI DSI bridge driver that we have.

Signed-off-by: Dang Huynh <danct12@riseup.net>
---
 drivers/video/rockchip/rk_vop2.c | 89 ++++++++++++++++++++++++++++++----------
 1 file changed, 67 insertions(+), 22 deletions(-)

diff --git a/drivers/video/rockchip/rk_vop2.c b/drivers/video/rockchip/rk_vop2.c
index 21751342de2f079d884b5247ade696efb95131c7..369892d32a6ad3b23b9cf1ddb4922c5df309d5c4 100644
--- a/drivers/video/rockchip/rk_vop2.c
+++ b/drivers/video/rockchip/rk_vop2.c
@@ -13,10 +13,12 @@
 #include <dm/device_compat.h>
 #include <edid.h>
 #include <log.h>
+#include <panel.h>
 #include <regmap.h>
 #include <reset.h>
 #include <syscon.h>
 #include <video.h>
+#include <video_bridge.h>
 #include <asm/global_data.h>
 #include <asm/gpio.h>
 #include <asm/io.h>
@@ -253,12 +255,14 @@ static int rk_display_init(struct udevice *dev, ulong fbbase, ofnode vp_node)
 	int vop_id, port_id;
 	struct display_timing timing;
 	struct udevice *disp;
+	struct udevice *bridge;
 	int ret;
 	u32 remote_phandle;
 	struct display_plat *disp_uc_plat;
 	enum video_log2_bpp l2bpp;
 	ofnode remote;
 	const char *compat;
+	struct udevice *panel;
 	char dclk_name[9];
 	struct clk dclk;
 
@@ -319,8 +323,10 @@ static int rk_display_init(struct udevice *dev, ulong fbbase, ofnode vp_node)
 			return -EINVAL;
 		}
 
+		uclass_find_device_by_ofnode(UCLASS_VIDEO_BRIDGE, remote, &bridge);
+
 		uclass_find_device_by_ofnode(UCLASS_DISPLAY, remote, &disp);
-		if (disp)
+		if (disp || bridge)
 			break;
 	};
 	compat = ofnode_get_property(remote, "compatible", NULL);
@@ -359,27 +365,57 @@ static int rk_display_init(struct udevice *dev, ulong fbbase, ofnode vp_node)
 		return ret;
 	}
 
-	disp_uc_plat = dev_get_uclass_plat(disp);
-	debug("Found device '%s', disp_uc_priv=%p\n", disp->name, disp_uc_plat);
-	if (display_in_use(disp)) {
-		debug("   - device in use\n");
-		return -EBUSY;
-	}
+	if (bridge) {
+		/* video bridge detected, probe it */
+		ret = device_probe(bridge);
+		if (ret) {
+			printf("%s: device '%s' bridge won't probe (ret=%d)\n",
+			       __func__, dev->name, ret);
+			return ret;
+		}
 
-	disp_uc_plat->source_id = vop_id;
-	disp_uc_plat->src_dev = dev;
+		/* Attach the DSI controller and the display to the bridge. */
+		ret = video_bridge_attach(bridge);
+		if (ret) {
+			printf("Failed to attach video bridge: %d\n", ret);
+			return ret;
+		}
 
-	ret = device_probe(disp);
-	if (ret) {
-		debug("%s: device '%s' display won't probe (ret=%d)\n",
-		      __func__, dev->name, ret);
-		return ret;
-	}
+		/* Get the panel device (TODO: fetch it from the bridge somehow) */
+		ret = uclass_first_device_err(UCLASS_PANEL, &panel);
+		if (ret) {
+			printf("Panel device error: %d\n", ret);
+			return ret;
+		}
 
-	ret = display_read_timing(disp, &timing);
-	if (ret) {
-		debug("%s: Failed to read timings\n", __func__);
-		return ret;
+		ret = panel_get_display_timing(panel, &timing);
+		if (ret) {
+			debug("%s: Failed to read timings\n", __func__);
+			return ret;
+		}
+	} else {
+		disp_uc_plat = dev_get_uclass_plat(disp);
+		debug("Found device '%s', disp_uc_priv=%p\n", disp->name, disp_uc_plat);
+		if (display_in_use(disp)) {
+			debug("   - device in use\n");
+			return -EBUSY;
+		}
+
+		disp_uc_plat->source_id = vop_id;
+		disp_uc_plat->src_dev = dev;
+
+		ret = device_probe(disp);
+		if (ret) {
+			debug("%s: device '%s' display won't probe (ret=%d)\n",
+			      __func__, dev->name, ret);
+			return ret;
+		}
+
+		ret = display_read_timing(disp, &timing);
+		if (ret) {
+			debug("%s: Failed to read timings\n", __func__);
+			return ret;
+		}
 	}
 
 	/* Set clock rate on video port to display timings */
@@ -409,9 +445,18 @@ static int rk_display_init(struct udevice *dev, ulong fbbase, ofnode vp_node)
 
 	rkvop_mode_set(dev, &timing, vop_id, port_id, platdata);
 
-	ret = display_enable(disp, 1 << l2bpp, &timing);
-	if (ret)
-		return ret;
+	if (bridge) {
+		/* Attach the DSI controller and the display to the bridge. */
+		ret = video_bridge_set_backlight(bridge, 60);
+		if (ret) {
+			printf("Failed to start the video bridge: %d\n", ret);
+			return ret;
+		}
+	} else {
+		ret = display_enable(disp, 1 << l2bpp, &timing);
+		if (ret)
+			return ret;
+	}
 
 	uc_priv->xsize = timing.hactive.typ;
 	uc_priv->ysize = timing.vactive.typ;

-- 
2.48.1

