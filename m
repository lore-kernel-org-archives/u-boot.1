Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0541D12D6F
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 14:47:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0185484016;
	Wed,  3 Dec 2025 15:46:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="u1TPbx3Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51D4580077; Wed,  3 Dec 2025 11:19:57 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86A2583942
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 11:19:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b7636c96b9aso893484666b.2
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 02:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764757191; x=1765361991;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JOeTHcZJm84v6AVSdCqJLbhXseg1y978Zo23KePiGcU=;
 b=u1TPbx3YftMnvhy+sTvHfr3EL7qfJnAlUm89/x1zOG9k+saCUW+5xiHDiKY7EvZSUz
 ZBaWsa9kgIwaK2s7MGipWldox9LTPDArhf2iLDTGUfRyMossC6mE9ZooHnBhdBVUFku3
 3kuRLO0BUn6FurXekfJqUk78LUKoThH8f9pB3TtgsRpuODLXBpYAVRL38uv28ftna4p1
 T1wALEiQyjHK3Zx+aH6zY8VAg6uHIJ1+OYnBZ0r8MbGdEz8vWGQmT7nYAQWmy3H8VtLK
 LBkgbPF1a45GK+Ccdehx6+xSfLosqtDenWx+C5Tv2BM3nnPbACmmNMMDsb7efXjgN8Z3
 H8Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764757191; x=1765361991;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JOeTHcZJm84v6AVSdCqJLbhXseg1y978Zo23KePiGcU=;
 b=lB0LehlGq5UmdBM2goYM73JFQ2SbIxt+Rd8ZRjGdL5iT8nVcsPz14J8h5pIo5PomZs
 ABRmdaeHLOOzZGXAil99IzD93uvRU9yebTg8sB5UYswHhAFFaccdWWrXNYkFTbZ+OBqO
 5jRtA3BacqQCWoCMfPUMXM6aXhc2EEzDX7yTyTxFCrhif/K9owoOQ5uF6Jq1ktjqTiwa
 t8MxiAHzA0vNWOyY5URD0rxW9Hy7qpksulfHcwH+GB+hntM/87fUBDnNAcxavJZzRhfy
 ZvGzGxY8RLMbepUTMzVqR9e1ZLPr5ao6Yfi+vGm2UdqtFz4P9aXsS3G47c8+WW9Qjk2O
 Y2pA==
X-Gm-Message-State: AOJu0YwRLF5aaNsWa4fYuV62a5yQleyTCA8wJyxjmw5jESu131uik/el
 X5DhMYpoMRBQsPGZlrDtf92s1ZD9am3Vr5Ovr4+Cro0Ii8V+umiyYkWjEYCwYpxfInM=
X-Gm-Gg: ASbGnctyfgX4jXyydVB82KD4j/NXveY+OPGjdapl76KjfcAYpCabNRlc3oOhg6DIEN0
 NRTXnhTa/W/aCv+NY2OjR6isWeWD0MVGfxVqLd2ShtkqFFBfrOf+dxkKt8ppKBQJJAkp3fn4C/R
 LfO+ORrHVZIG+KpN5909E9BqKYtg3fLW418xmLuoGye75xroad7ZRMd7c9ANsI5WlBwgtIDmwLB
 7qEd6RqN1L1Vng5hXFj6SsD98NSq4/z22ZcDXfSgMXQSIyblRBBhyB27bi5E0h3XvDGSB7PGYHb
 1+1lUhk+vllxyeS2s73brMUViy0m66HJvRZ4mtAYLXKENvM2JLO5/KL9brCNnkI8HMuf1MK+Bp4
 9FaXZY29HpcFDET+tRWm9JiEqB1DvP2CvKp0nWUssofwt+NysxHy6zA+PwJxrYeD2CHugvBofB9
 A6EJxnedQ=
X-Google-Smtp-Source: AGHT+IFeU1wimzfy/ucebdL4HPp8SDxPmgoJM1DYAPDUsnpdqhRKwU+PGcDKemDhbfmNldqItYl40A==
X-Received: by 2002:a17:907:7252:b0:b72:b710:cbfd with SMTP id
 a640c23a62f3a-b79dc51d8b8mr158935566b.36.1764757190903; 
 Wed, 03 Dec 2025 02:19:50 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b76f5a7b4bcsm1722255766b.71.2025.12.03.02.19.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Dec 2025 02:19:50 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Wed, 03 Dec 2025 11:19:11 +0100
Subject: [PATCH v2 2/4] panel: Lightweight support of get_modes()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-topic-am33-evm-lcd-v2026-01-v2-2-262cf4f34eb5@baylibre.com>
References: <20251203-topic-am33-evm-lcd-v2026-01-v2-0-262cf4f34eb5@baylibre.com>
In-Reply-To: <20251203-topic-am33-evm-lcd-v2026-01-v2-0-262cf4f34eb5@baylibre.com>
To: u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Yannick Fertre <yannick.fertre@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Sukrut Bellary <sbellary@baylibre.com>, Fabio Estevam <festevam@gmail.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5681; i=msp@baylibre.com;
 h=from:subject:message-id; bh=gIItUWVlWaf6mlak4cmqN+nD4/KNhUP3z+ZCCDGTpjM=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkwDvq3zX/C0nDOKv8I25+DhyQ47Dp2NZQtIa1q1Sl33g
 XqUkZNSRykLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAEzkZgsjwxM3v8S3O3j/3t7c
 6/u/1lfix4m8CR8e7NF/Osvv/qFshThGho37OOQSjsnEy99w+KjXFpFftPXJCfvvqRKZJ3kWlxV
 OYQAA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Wed, 03 Dec 2025 15:46:17 +0100
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
index 6c5e2c000fc79f271876daa179455f16da5bc3af..65411efbddf60e11d13c9a91b308bd2ead88c6b1 100644
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

