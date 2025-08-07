Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50231C87FCA
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 08:27:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91B68843E3;
	Thu,  7 Aug 2025 10:26:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="noin5pzU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6185B83AD5; Thu,  7 Aug 2025 09:46:50 +0200 (CEST)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D51183A43
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 09:46:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cn.liweihao@gmail.com
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b271f3ae786so536341a12.3
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 00:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754552806; x=1755157606; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0gZXbtcLGqYkRRe/zLhdfCn0GStHBeZVWNQOXENOy8o=;
 b=noin5pzU+icK0PFlP4+uJa7gxn9Iea5rk6+HAhYLllRZLnzCv0BE/KlvR2teOgDgDA
 2rFXUsVYw4OG4hmB8nAejjR3qaD0sifGG22iqqGh9sdz9ov9r3+TfVJg/Bl2sYfJyUvs
 ejw1EcIFt9u0jaOuMbS7I7g2mV/Msc3hxNboiDH07OX5YO+/DAQJPRuDAUUuVqRKK/N2
 8VLQGMlUbpxGtW/0+/eMxBERbn8qOU6eWbdqhMy5eEumRMVVmIdjoZClRXPwwKtSGLnw
 gm1iMFQWxXooIWC9Y9etnE+xkh9uIzZWVsaqN7jg8wL8uW+xpTFllO4tkHySmBr8thLr
 ISWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754552806; x=1755157606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0gZXbtcLGqYkRRe/zLhdfCn0GStHBeZVWNQOXENOy8o=;
 b=Li+cfxf2/tpWgKG+kzSpIlyuFtEkonYHxXfxd8OinwgXBVhtNHH5PaXDXpbecX35Mf
 SY/ItfXm7GrsMTFLfLKn6Pb4IsE3aEp25FW0YrZypUT7ej2VSKc7bOqMWUZoi0kBGwtV
 yInQBnaC8+namzQIC77jN47miGgrvFaFudiYYPbuBeqs2jNGg3C8NtiVafxVKDbZcFja
 dPWht1LxqShfABewLlJ9Mrj939DJMSdx5zGTS1LShdEwnoymFVLFMfcxuQHFS/RRZH3c
 xY3bs3EbbtTHW5rBtjK7O/B+tlAioOe2EEGO/qEYrSy7VjAhj/o2ZTJgVZy5Acrbt+ci
 yovQ==
X-Gm-Message-State: AOJu0YwRvduhy5HGVYRFyTP1WgPOO+Ghv+TzdncAHzwLJlcVvnv8ylMS
 kKpv6grPCO0BsKQXaf5lMBq+LlCKKTNH4qjDej85lylhkWMm+/RHAJzSMouC2Iol
X-Gm-Gg: ASbGncvIvUAInBYUz9nz0Wi7jbPlaFhunoB/5JqTpLq1mg/eMV2rLJ2hDQQw2enL6w5
 o+ZBg35QreoiYzzMQcwzT7+GprrICyJgOTbGtenuBPd4iyGx0zRBETYd+Xny4JSVlXpXngASSkG
 5WF83xz1Mvw2Bmqun3cLSmxePfoMymEGXX1eaSGq6irhkdCuWG8zA0Sy3TLrw8pTzZ63y60gvIW
 /D7V4JwFvQcZbZH5gD+hcVFnolOil/tvtHr1dbzHXTqVLL5fv38rVnqmhVDlq27Nx8cgICFjUtE
 vT24ghqIlSO9asuEBcQRXGY/yv1vKZor6uz7vNW8DX9jdOZ3x30T1zelIW1b/rOEze4R5xg+a0n
 K4l4LsI5uImlRKJ1XcH2ZWW9/GIRgIEk1kUf0
X-Google-Smtp-Source: AGHT+IHl3tl4TQRRoV9O7llG46MleI3Rt+EjBzh/b0MWmi8yEnA+5eokHPqM0J/wAU28Lh0/DhwfQg==
X-Received: by 2002:a17:90b:4a44:b0:321:380b:9e85 with SMTP id
 98e67ed59e1d1-32176326b55mr3024509a91.8.1754552805999; 
 Thu, 07 Aug 2025 00:46:45 -0700 (PDT)
Received: from localhost.localdomain ([218.90.41.167])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-320f4909b8bsm16809202a91.16.2025.08.07.00.46.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 00:46:45 -0700 (PDT)
From: WeiHao Li <cn.liweihao@gmail.com>
To: u-boot@lists.denx.de
Cc: antonio.borneo@foss.st.com, mk7.kang@samsung.com,
 gregkh@linuxfoundation.org, semen.protsenko@linaro.org,
 mikhail.kshevetskiy@iopsys.eu, bb@ti.com, justin.swartz@risingedge.co.za,
 lukasz.czechowski@thaumatec.com, robh@kernel.org, tharvey@gateworks.com,
 clement.legoffic@foss.st.com, marek.vasut@mailbox.org,
 dinesh.maniyam@altera.com, patrice.chotard@foss.st.com, festevam@gmail.com,
 jerome.forissier@linaro.org, quentin.schulz@cherry.de,
 andrew.goodbody@linaro.org, sumit.garg@kernel.org, ag.dev.uboot@gmail.com,
 rfried.dev@gmail.com, joe.hershberger@ni.com, jh80.chung@samsung.com,
 peng.fan@nxp.com, seanga2@gmail.com, lukma@denx.de,
 kever.yang@rock-chips.com, philipp.tomsich@vrull.eu, sjg@chromium.org,
 trini@konsulko.com, WeiHao Li <cn.liweihao@gmail.com>,
 muratdemirtas <muratdemirtaseu@outlook.com>, WeiHao Li <ieiao@outlook.com>
Subject: [PATCH 07/10] video: rockchip: vop add bridge support
Date: Thu,  7 Aug 2025 15:44:15 +0800
Message-Id: <20250807074419.336752-8-cn.liweihao@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250807074419.336752-1-cn.liweihao@gmail.com>
References: <20250807074419.336752-1-cn.liweihao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 07 Aug 2025 10:26:22 +0200
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

Signed-off-by: muratdemirtas <muratdemirtaseu@outlook.com>
Signed-off-by: WeiHao Li <ieiao@outlook.com>
---
 drivers/video/rockchip/rk_vop.c | 92 +++++++++++++++++++++++++--------
 1 file changed, 71 insertions(+), 21 deletions(-)

diff --git a/drivers/video/rockchip/rk_vop.c b/drivers/video/rockchip/rk_vop.c
index 17dfe62c9d..71786da77e 100644
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

