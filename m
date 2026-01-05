Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 643E6C79F8B
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 13:04:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBD2D83DBF;
	Mon,  5 Jan 2026 14:03:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wgykCios";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E95AB83D07; Mon,  5 Jan 2026 10:37:05 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EFDA83D13
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 10:37:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-430fbb6012bso11640547f8f.1
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 01:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767605822; x=1768210622;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VPjB7/zflWF74AbjXj6JOlfuKs3l9zOOnFTMRyELxxM=;
 b=wgykCiosTrLwv5PzZmATCbpCMbkpg3C1X4fe+AN+wAeesDbLliz+Eu8CWdnXYF3i0P
 7SKNbiQQtD0+BKRiAx5ICno2SOzgQUP2r0ws+p3Lgv45ppt60FQYrX7JkpYp9oEzg/kt
 Ci1thxE9OzvYg8TjqjUZFJsSRwdVU0h4CnA8STGJgeLqNujJqLJDf0P3dybg7Y/URVUA
 BbYeBz+EPhs47mFMrnpOmGHZks/xEb+1hCZC/j94WiqHlGz1yXjNpsL2pLXDu2xBXq0a
 OTlmIzBihC8iFywrzTy/k257RwdRpmNSsVam2pd+sEl2A7QfHvlhkDOje6Ld/baFvUxj
 Bfpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767605822; x=1768210622;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VPjB7/zflWF74AbjXj6JOlfuKs3l9zOOnFTMRyELxxM=;
 b=u/AS/VfDTkAFJfaIXfrrRFg8cGT4yECh7hxmh2CO4l5YyEztxqbfuv7fOjhmCzjPiQ
 XY8Q89sKbVnI47Gmu82NJRSCywHOu6Yj5/yd1mzsMaV49IPgo2VNtKxGXyOqJv4kFLID
 PMMfGXKSYugaFNEvH7IfZQGPwCuNmP109psEXCYwEwNCD0WVij35iQkmo6DO443nj2Py
 P8YYtZ3t/p0hAyxW6e7iSg5DbI7auDs0Ayec1Cn9vDGV5scqjSAX6dXY9jptpeRr2JVS
 vLqQPlzlVdRZCPQQCHAFiyn5PkHfUFTcINIHy2/87IY/TluWbY6uHPq9ovHCliTi5VIw
 QfBg==
X-Gm-Message-State: AOJu0YzslY9e8xpqGbzgkNWc2oOEdj49CKMdqq/pavAHLJc6Q0v55oAO
 RQ2C4XX23up3FsufT11gDZRzrZGJnQAvJhNTs0rpDdyfUvQYIfJpJOeUe3FMff3Vh/I=
X-Gm-Gg: AY/fxX65cwAhh9sz5WxJEv3FcaL7/jCjTVzzfiQmNLVrWC9EFkIruaI47Iyv+31jFZB
 LFeOCcFPMbx3t9Cp6v3nG9dcNChYtIDe5SdOXGyK+7NWVUM5nLVwCq4XzcS+5lahbhhat77kGaC
 oeDWEWJBR2/p0CceW6ZcOvFDLN6/GiANtYc+LiyMi9IRPeMuvN1G+8q2rQA7rQRltIe5YZxNONo
 ENtCIE5t83l6j42lvi2vSfJfayYdJGxgyrCHRzLRnZLFIYxlb5aw3LaugCH4m0KcylWvL0lxj6t
 WFMgv8ECClqm0YR20g/x7hvJovP/0gJLCGL4+EzqSxrT63itooz5Qc4+9BA5VLvBy3+D6Zr44dh
 X6GtvkuqzzepmUTh4gnN5GUiqv8LEpYVkTDA0z+or67NgG9RK5VhdB45Jdn83t2sWlnSmCRR17Q
 zDNB5A6Nv9
X-Google-Smtp-Source: AGHT+IFFU5mzMridQP6bl6vBb0fy//o08MTO/IlmIOGKGqvC0BdTjyKVxuHvkxHqY/2a89xnf8XncA==
X-Received: by 2002:a05:6000:250a:b0:431:66a:cbc4 with SMTP id
 ffacd0b85a97d-4324e4cc43dmr58385605f8f.17.1767605822422; 
 Mon, 05 Jan 2026 01:37:02 -0800 (PST)
Received: from localhost ([2001:4091:a246:82fd:4350:c3d9:84a3:70dd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea1afbfsm100715456f8f.9.2026.01.05.01.37.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 01:37:02 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 05 Jan 2026 10:36:27 +0100
Subject: [PATCH v4 2/4] panel: Lightweight support of get_modes()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-topic-am33-evm-lcd-v2026-01-v4-2-7617591b8159@baylibre.com>
References: <20260105-topic-am33-evm-lcd-v2026-01-v4-0-7617591b8159@baylibre.com>
In-Reply-To: <20260105-topic-am33-evm-lcd-v2026-01-v4-0-7617591b8159@baylibre.com>
To: u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Yannick Fertre <yannick.fertre@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Sukrut Bellary <sbellary@baylibre.com>, Fabio Estevam <festevam@gmail.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5730; i=msp@baylibre.com;
 h=from:subject:message-id; bh=l9yXpomwy6iu+FSkIB1gss4VS4x92gFZ/7Ah5pmSkAQ=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhszoNm2Z6AlTdpie6am7sXuu+/8zgYE6M19+31v7fv+5Z
 Tf277qv3VHKwiDGxSArpsjSmRia9l9+57HkRcs2w8xhZQIZwsDFKQATiUhl+Ged8IIhWKVJ6E2w
 m0LOuocX+z+2NJ08VzxHv+Pt24lqP9Yw/OGYO0NC227ehU3MD/ZO8C14MGXHZ47XfUWiBVET3ss
 Wy3ACAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 05 Jan 2026 14:03:25 +0100
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

Linux uses get_modes() to fetch all available panel modes from the
driver. This is also used to fetch the modes from Linux's simple panel
implementation where a list of drm_display_mode structs is used to
define the different possible panels.

To make our work easier, create a compatible way of fetching and
defining these modes in u-boot. get_modes() fetches the available modes
from the panel driver. The get_display_timing() call maps the
drm_display_mode properties to the display_timing struct. This call now
uses whatever panel operation is available, get_display_timing() or
get_modes().

Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 drivers/video/panel-uclass.c | 38 ++++++++++++++++++++++--
 include/panel.h              | 69 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+), 3 deletions(-)

diff --git a/drivers/video/panel-uclass.c b/drivers/video/panel-uclass.c
index 52a3466dc8c1203731dfcb62ebf4e63ed390bbb4..82e8339dde1bcd2cb8d93c7f7d75a29790089fb3 100644
--- a/drivers/video/panel-uclass.c
+++ b/drivers/video/panel-uclass.c
@@ -37,15 +37,47 @@ int panel_set_backlight(struct udevice *dev, int percent)
 	return ops->set_backlight(dev, percent);
 }
 
+static void drm_mode_to_display_timing(const struct drm_display_mode *mode,
+				       struct display_timing *timing)
+{
+	timing->pixelclock.typ = mode->clock * 1000; /* kHz to Hz */
+	timing->hactive.typ = mode->hdisplay;
+	timing->hfront_porch.typ = mode->hsync_start - mode->hdisplay;
+	timing->hsync_len.typ = mode->hsync_end - mode->hsync_start;
+	timing->hback_porch.typ = mode->htotal - mode->hsync_end;
+	timing->vactive.typ = mode->vdisplay;
+	timing->vfront_porch.typ = mode->vsync_start - mode->vdisplay;
+	timing->vsync_len.typ = mode->vsync_end - mode->vsync_start;
+	timing->vback_porch.typ = mode->vtotal - mode->vsync_end;
+
+	/* DRM_MODE_FLAG_* defines are already mapped to u-boot DISPLAY_FLAGS */
+	timing->flags = mode->flags;
+}
+
 int panel_get_display_timing(struct udevice *dev,
 			     struct display_timing *timings)
 {
 	struct panel_ops *ops = panel_get_ops(dev);
+	const struct drm_display_mode *modes;
+	int ret = -ENOSYS;
 
-	if (!ops->get_display_timing)
-		return -ENOSYS;
+	if (ops->get_display_timing) {
+		ret = ops->get_display_timing(dev, timings);
+		if (ret != -ENODEV)
+			return ret;
+	}
 
-	return ops->get_display_timing(dev, timings);
+	if (!ops->get_modes)
+		return ret;
+
+	ret = ops->get_modes(dev, &modes);
+	if (ret < 0)
+		return ret;
+	else if (ret == 0)
+		return -ENODEV;
+
+	drm_mode_to_display_timing(&modes[0], timings);
+	return 0;
 }
 
 UCLASS_DRIVER(panel) = {
diff --git a/include/panel.h b/include/panel.h
index e2764d72c57dcc4ae11d5f1553f1bfcd98996138..8d46fb26a07c2b1886a38f922eb6a90c3762ca38 100644
--- a/include/panel.h
+++ b/include/panel.h
@@ -7,6 +7,62 @@
 #ifndef _PANEL_H
 #define _PANEL_H
 
+#include <video.h>
+#include <fdtdec.h>
+
+/* DRM mode flags mapped to U-Boot DISPLAY_FLAGS for direct compatibility */
+#define DRM_MODE_FLAG_NHSYNC		DISPLAY_FLAGS_HSYNC_LOW
+#define DRM_MODE_FLAG_PHSYNC		DISPLAY_FLAGS_HSYNC_HIGH
+#define DRM_MODE_FLAG_NVSYNC		DISPLAY_FLAGS_VSYNC_LOW
+#define DRM_MODE_FLAG_PVSYNC		DISPLAY_FLAGS_VSYNC_HIGH
+#define DRM_MODE_FLAG_INTERLACE		DISPLAY_FLAGS_INTERLACED
+#define DRM_MODE_FLAG_DBLSCAN		DISPLAY_FLAGS_DOUBLESCAN
+#define DRM_MODE_FLAG_DBLCLK		DISPLAY_FLAGS_DOUBLECLK
+
+/**
+ * struct drm_display_mode - DRM kernel-internal display mode structure
+ *			     simplified for U-Boot
+ * @hdisplay: horizontal display size
+ * @hsync_start: horizontal sync start
+ * @hsync_end: horizontal sync end
+ * @htotal: horizontal total size
+ * @vdisplay: vertical display size
+ * @vsync_start: vertical sync start
+ * @vsync_end: vertical sync end
+ * @vtotal: vertical total size
+ *
+ * The horizontal and vertical timings are defined per the following diagram.
+ *
+ * ::
+ *
+ *
+ *               Active                 Front           Sync           Back
+ *              Region                 Porch                          Porch
+ *     <-----------------------><----------------><-------------><-------------->
+ *       //////////////////////|
+ *      ////////////////////// |
+ *     //////////////////////  |..................               ................
+ *                                                _______________
+ *     <----- [hv]display ----->
+ *     <------------- [hv]sync_start ------------>
+ *     <--------------------- [hv]sync_end --------------------->
+ *     <-------------------------------- [hv]total ----------------------------->*
+ */
+struct drm_display_mode {
+	unsigned int clock; /* in kHz */
+
+	u16 hdisplay;
+	u16 hsync_start;
+	u16 hsync_end;
+	u16 htotal;
+	u16 vdisplay;
+	u16 vsync_start;
+	u16 vsync_end;
+	u16 vtotal;
+
+	u32 flags;
+};
+
 struct panel_ops {
 	/**
 	 * enable_backlight() - Enable the panel backlight
@@ -34,6 +90,19 @@ struct panel_ops {
 	 */
 	int (*get_display_timing)(struct udevice *dev,
 				  struct display_timing *timing);
+
+	/**
+	 * get_modes() - Get display modes from panel
+	 *
+	 * Returns an array of display modes supported by the panel.
+	 * Similar to Linux's drm_panel_funcs->get_modes().
+	 *
+	 * @dev:	Panel device
+	 * @modes:	Pointer to an array of modes
+	 * @return number of modes if OK, -ve on error
+	 */
+	int (*get_modes)(struct udevice *dev,
+			 const struct drm_display_mode **modes);
 };
 
 #define panel_get_ops(dev)	((struct panel_ops *)(dev)->driver->ops)

-- 
2.51.0

