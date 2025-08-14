Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A32ECA0EE4
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 13:13:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C58E583959;
	Thu, 14 Aug 2025 15:13:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j4fCAy99";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E44FD83965; Thu, 14 Aug 2025 15:13:39 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F841838C7
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 15:13:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cn.liweihao@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-24457fe9704so6854665ad.0
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 06:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755177215; x=1755782015; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bIy9b7tGKTIXQvpPQzXtcU5TiX9XsiX3Gkf8OMBPhqU=;
 b=j4fCAy99EF/13y3mKor6nZVcV8NSBdBF9UGjGvBwp0byFoZFPi9dNr0yGlPRKJtl2M
 ByNu/ix6z4YMvqerHozwcN3Aa84pNBpVUnwc4XK7GVWjdPEpCN17VJTXo1JABNOks2Lf
 I23dsEjZoY8ngEM9fin5TqKFJu0AfghyZQZ0cgHoiwHFuQz+jx9BxvR5Dbbl/NXPchS0
 5nqnsvMerA5mDzapF5sb+cQRBg0hP3nRHrPkDXvg9N1w5L/rLkgJ7Is3HXQAM7/plWh1
 HoOaij8VgzyhMfZhPuIz4SIaovuVugb9AREdo4PmA6Y51RrVRrBZidfG9m5TD+Y+RT8C
 DOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755177215; x=1755782015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bIy9b7tGKTIXQvpPQzXtcU5TiX9XsiX3Gkf8OMBPhqU=;
 b=gBTLzqpSE32rElWYxWHOg9BLc9csuzX25GmDK5MgfhCGfjl6aMROeWwpb0lBIDR+pY
 xnLoHxzOEbuYP5kWkdZJKXqZmGKsLT2HmzhRDCTErtqeptdQRAr47HZVssU1UXIasqyN
 mhbvoVwTcgfgjJV5vfC0m2zooGgWh59yV6IGljIy8f/6JVQfOU6at4Gy+42RxsrdwTKP
 QOmQfELcZ2cTPX03OU4cVow8Jth6HSbfk+QpgaGug0liLSihdg2SlbosGbeb5rOReVCr
 3XqEYUhW6KhEhkKFcEDaW/PQvxOWQYDHu35W09n6fu+LWMketpz01Ejj1Zf3BQ72Zqdq
 IHtA==
X-Gm-Message-State: AOJu0YyOd6saxkftqJGJnz5D4Ih6ctI9zL8ErDO1Ok9nNXjlRMKQPVJN
 88guYD3AJh1fWzCAiyn7aUMk+Pf+aB1RN0yUoU1ZCNhcK7ZVrbyaHh/mfufgq4QMGqRYWTuL
X-Gm-Gg: ASbGncsqB5Fhzr8REixXYtW3FJ3eB/+phJHd/Eyv7Am5PIn1lN2iC1uxK3c/IupFBRb
 br62DVows9SjfYSkX+Q3m3yF55CtIIH0qU37yNbuZZ5ET6lfjT5R3GVscpQvxI79nvMR5C7g4al
 pXiPtNybVbcLJmV0F8MOY8KghZO9DSR7mPgfvs5l441cWKC+AX9Lk73jA1DT0aEi9FE/SBIpN6V
 ojaKx4QRigFLZExQxGNi6X1yCUnUDhWWIDqgo8BgL03GBy9TrqxrNsxdcV2HZcVFV5MV8gKEzsb
 Ebf7jjvQzUckCPJ73syA52X5h7hXM7VU75LET5lz2i2xlehBYHGdATvO/7nI1werKDqWnM0J/F0
 GqMFpFkjPoHBEybwBZDzEzs+7hLKIgjEY7l/1aQ==
X-Google-Smtp-Source: AGHT+IEtsPEakLXgD/GdsZmOFAvEtSmL05PnVd894h3Or0fk85kWcKZGW5HQF4K1PfrCeLwX5CohtQ==
X-Received: by 2002:a17:903:19c7:b0:244:5089:ff44 with SMTP id
 d9443c01a7336-244586b642bmr43986865ad.41.1755177214970; 
 Thu, 14 Aug 2025 06:13:34 -0700 (PDT)
Received: from localhost.localdomain ([104.28.159.212])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24300f8c9d1sm67902195ad.129.2025.08.14.06.13.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 06:13:34 -0700 (PDT)
From: WeiHao Li <cn.liweihao@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, lukma@denx.de, seanga2@gmail.com,
 ag.dev.uboot@gmail.com, muratdemirtaseu@outlook.com,
 WeiHao Li <cn.liweihao@gmail.com>
Subject: [PATCH 4/5] video: rockchip: Add bridge support for VOP
Date: Thu, 14 Aug 2025 21:12:36 +0800
Message-Id: <20250814131237.8135-5-cn.liweihao@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250814131237.8135-1-cn.liweihao@gmail.com>
References: <20250814131237.8135-1-cn.liweihao@gmail.com>
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

Rockchip VOP driver only support UCLASS_DISPLAY for now, It can't work
if SOC use dw-mipi with inno-dphy like RK3368.

This patch try to add UCLASS_VIDEO_BRIDGE support to let it support
dw-mipi-dsi-rockchip driver, will support SOC use dw-mipi with inno-dphy.

This patch basic same as muratdemirtas's github repository, just adjust
some code style.

Link: https://github.com/muratdemirtas/rockchip-rk3399-uboot-mipi-dsi

Signed-off-by: muratdemirtas <muratdemirtaseu@outlook.com>
Signed-off-by: WeiHao Li <cn.liweihao@gmail.com>
---
 drivers/video/rockchip/rk_vop.c | 92 +++++++++++++++++++++++++--------
 1 file changed, 71 insertions(+), 21 deletions(-)

diff --git a/drivers/video/rockchip/rk_vop.c b/drivers/video/rockchip/rk_vop.c
index 17dfe62c9..71786da77 100644
--- a/drivers/video/rockchip/rk_vop.c
+++ b/drivers/video/rockchip/rk_vop.c
@@ -14,6 +14,8 @@
 #include <reset.h>
 #include <syscon.h>
 #include <video.h>
+#include <video_bridge.h>
+#include <panel.h>
 #include <asm/global_data.h>
 #include <asm/gpio.h>
 #include <asm/io.h>
@@ -257,6 +259,8 @@ static int rk_display_init(struct udevice *dev, ulong fbbase, ofnode ep_node)
 	ofnode remote;
 	const char *compat;
 	struct reset_ctl dclk_rst;
+	struct udevice *bridge;
+	struct udevice *panel;
 
 	debug("%s(%s, 0x%lx, %s)\n", __func__,
 	      dev_read_name(dev), fbbase, ofnode_get_name(ep_node));
@@ -298,6 +302,10 @@ static int rk_display_init(struct udevice *dev, ulong fbbase, ofnode ep_node)
 			return -EINVAL;
 		}
 
+		uclass_find_device_by_ofnode(UCLASS_VIDEO_BRIDGE, remote, &bridge);
+		if (bridge)
+			break;
+
 		uclass_find_device_by_ofnode(UCLASS_DISPLAY, remote, &disp);
 		if (disp)
 			break;
@@ -326,27 +334,60 @@ static int rk_display_init(struct udevice *dev, ulong fbbase, ofnode ep_node)
 	}
 	debug("vop_id=%d\n", vop_id);
 
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
+			debug("%s: device '%s' bridge won't probe (ret=%d)\n",
+			      __func__, dev->name, ret);
+			return ret;
+		}
 
-	disp_uc_plat->source_id = remote_vop_id;
-	disp_uc_plat->src_dev = dev;
+		/* Attach the DSI controller and the display to the bridge. */
+		ret = video_bridge_attach(bridge);
+		if (ret) {
+			debug("Failed to attach video bridge: %d\n", ret);
+			return ret;
+		}
 
-	ret = device_probe(disp);
-	if (ret) {
-		debug("%s: device '%s' display won't probe (ret=%d)\n",
-		      __func__, dev->name, ret);
-		return ret;
-	}
+		/*
+		 * Get the panel device
+		 * TODO: Maybe fetch it from the bridge private data.
+		 */
+		ret = uclass_first_device_err(UCLASS_PANEL, &panel);
+		if (ret) {
+			debug("Panel device error: %d\n", ret);
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
+		disp_uc_plat->source_id = remote_vop_id;
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
 
 	ret = clk_get_by_index(dev, 1, &clk);
@@ -383,9 +424,18 @@ static int rk_display_init(struct udevice *dev, ulong fbbase, ofnode ep_node)
 
 	rkvop_enable(dev, fbbase, 1 << l2bpp, &timing, &dclk_rst);
 
-	ret = display_enable(disp, 1 << l2bpp, &timing);
-	if (ret)
-		return ret;
+	if (bridge) {
+		/* Attach the DSI controller and the display to the bridge. */
+		ret = video_bridge_set_backlight(bridge, 80);
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
2.39.5

