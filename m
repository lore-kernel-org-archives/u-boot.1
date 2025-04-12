Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3982AC369B2
	for <u-boot@archiver.kernel.org>; Sat, 12 Apr 2025 14:32:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99F6A82DBC;
	Sat, 12 Apr 2025 16:31:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=riseup.net header.i=@riseup.net header.b="dmKFyg6j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70E6882D7C; Sat, 12 Apr 2025 16:31:40 +0200 (CEST)
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34A1382E17
 for <u-boot@lists.denx.de>; Sat, 12 Apr 2025 16:31:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danct12@riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx0.riseup.net (Postfix) with ESMTPS id 4ZZbbD3yJNz9wPG;
 Sat, 12 Apr 2025 14:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1744468296; bh=02S0+5nSd8PqAH712nuHQlsvVvjO9nyQPo1ivPEU3vc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=dmKFyg6jCDozWDSSLz2yowFhA3jQT8Ly7y96R5snuRV9ttPxcuaeLuiw/HLU9kxKt
 apLm6PZPndWHjLGrHDAKiyG1LuZKAFhJ91u3uYqA5+4txRe11Ij9k9+ohSHBQxFft+
 iPbEdlI6YSSYBol4h+lP7m2uHqdkZNZq76MYv0dM=
X-Riseup-User-ID: 8412563E9C19A0F556314A34DD81867BF706B86F4DB7E0EF16A714F536413C41
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4ZZbb84qc7zJtdD;
 Sat, 12 Apr 2025 14:31:32 +0000 (UTC)
From: Dang Huynh <danct12@riseup.net>
Date: Sat, 12 Apr 2025 21:27:09 +0700
Subject: [PATCH v3 07/12] video: rockchip: vop2: Add video bridge support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250412-vop2-pt2-v3-7-7c796db335e9@riseup.net>
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

Add support for video bridge to VOP2 so we can use the MIPI DSI
bridge driver that we have.

Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Dang Huynh <danct12@riseup.net>
---
 drivers/video/rockchip/rk_vop2.c | 81 +++++++++++++++++++++++++++++-----------
 1 file changed, 59 insertions(+), 22 deletions(-)

diff --git a/drivers/video/rockchip/rk_vop2.c b/drivers/video/rockchip/rk_vop2.c
index 3d64c0a32f8e9a6e479b9bc53afa0736118f08e6..01a2ad883923cc9865c85699d2ba2b196e9795f2 100644
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
@@ -288,6 +290,7 @@ static int rk_display_init(struct udevice *dev, ulong fbbase, ofnode vp_node)
 	int vop_id, port_id, win_id;
 	struct display_timing timing;
 	struct udevice *disp;
+	struct udevice *bridge;
 	int ret;
 	u32 remote_phandle;
 	struct display_plat *disp_uc_plat;
@@ -354,8 +357,11 @@ static int rk_display_init(struct udevice *dev, ulong fbbase, ofnode vp_node)
 			return -EINVAL;
 		}
 
+		if (IS_ENABLED(CONFIG_VIDEO_BRIDGE))
+			uclass_find_device_by_ofnode(UCLASS_VIDEO_BRIDGE, remote, &bridge);
+
 		uclass_find_device_by_ofnode(UCLASS_DISPLAY, remote, &disp);
-		if (disp)
+		if (disp || bridge)
 			break;
 	};
 	compat = ofnode_get_property(remote, "compatible", NULL);
@@ -393,27 +399,49 @@ static int rk_display_init(struct udevice *dev, ulong fbbase, ofnode vp_node)
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
+			dev_err(dev, "Failed to probe video bridge: %d\n", ret);
+			return ret;
+		}
 
-	disp_uc_plat->source_id = vop_id;
-	disp_uc_plat->src_dev = dev;
+		/* Attach the DSI controller and the display to the bridge. */
+		ret = video_bridge_attach(bridge);
+		if (ret) {
+			dev_err(dev, "Failed to attach video bridge: %d\n", ret);
+			return ret;
+		}
 
-	ret = device_probe(disp);
-	if (ret) {
-		debug("%s: device '%s' display won't probe (ret=%d)\n",
-		      __func__, dev->name, ret);
-		return ret;
-	}
+		ret = video_bridge_get_display_timing(bridge, &timing);
+		if (ret) {
+			dev_err(dev, "Failed to read timings: %d\n", ret);
+			return ret;
+		}
+	} else {
+		disp_uc_plat = dev_get_uclass_plat(disp);
+		debug("Found device '%s', disp_uc_priv=%p\n", disp->name, disp_uc_plat);
+		if (display_in_use(disp)) {
+			debug("   - device in use\n");
+			return -EBUSY;
+		}
 
-	ret = display_read_timing(disp, &timing);
-	if (ret) {
-		debug("%s: Failed to read timings\n", __func__);
-		return ret;
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
@@ -456,9 +484,18 @@ static int rk_display_init(struct udevice *dev, ulong fbbase, ofnode vp_node)
 
 	rkvop2_mode_set(dev, &timing, vop_id, port_id, platdata);
 
-	ret = display_enable(disp, 1 << l2bpp, &timing);
-	if (ret)
-		return ret;
+	if (bridge) {
+		/* Attach the DSI controller and the display to the bridge. */
+		ret = video_bridge_set_backlight(bridge, 60);
+		if (ret) {
+			dev_err(dev, "Failed to start the video bridge: %d\n", ret);
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
2.49.0

