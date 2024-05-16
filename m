Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989F6C25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 22:17:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1D1F884A1;
	Fri, 17 May 2024 00:16:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="k9+UmVxI";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="LhiZlSod";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 052CB8847C; Fri, 17 May 2024 00:16:51 +0200 (CEST)
Received: from fhigh2-smtp.messagingengine.com
 (fhigh2-smtp.messagingengine.com [103.168.172.153])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C21788489
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 00:16:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 7883C1140172;
 Thu, 16 May 2024 18:16:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Thu, 16 May 2024 18:16:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715897807;
 x=1715984207; bh=cx6KTyuWLtq92wkDpy0t17BPvamyQHPgH0ZYbGrOQgI=; b=
 k9+UmVxINPP+QRrr6vbfiu9/VSAF7b49oC4DJGhO/Z6ytXwy+pqwri92QpUwaqmE
 Uyc/xFSMOeovHnyaUMDeK5uHXQhWGfqlpFMkYMN3yk3EZAlbMIS0gEHWNunjuwhq
 JXnDgTxBMlKyKwaJHkM0n6If7pmgvCDtG3fST3grxZ2s9eF3CZnHNVfTKNGtU8Qt
 q1pDjpNrSgO/7MdJ5q5SD+r7bHrLVogFz6pLDDMJmOJGJPSiUYo+3psfmIPSG7g5
 2pRzMKZS9tOh1RNjglGxIwJXTFLSsfU2S9aZgIz4nBvzJMlJ9wHK9e7yLkjUKy80
 ezl3StpNLvOYjh4THurAfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715897807; x=
 1715984207; bh=cx6KTyuWLtq92wkDpy0t17BPvamyQHPgH0ZYbGrOQgI=; b=L
 hiZlSodq/4+f0H9f07JQ9vHFX7es85FTlwVhX7PDQPagX8vtwpR0ofr7vYi/ydAA
 oiKGY9sqOFBP125EavxRdeLcPB7z/AqlpXAaM4WJ6Jhly5RAW60ecIGFoWoyM+aT
 EMB1Gwcqph22fbuB/r/WjtN2QVQDbV6O8/pDu7OCxhU5I21XtUEOyMNQldohLJkQ
 4VvoHPs/g2MaYpVvtmOMmjXd6W41zSLJ8+/ppqhOhUawLKJ/2wV1XO0/dJHkdDC3
 ZYb7CcTiwQ0raq+F5jpCtIKdWHELDx6TnoEUQq1fZqozKGpJk+zloT2RVEYvXz2T
 K1Dl7GlRosIGHwNmyhMEA==
X-ME-Sender: <xms:z4VGZuNzeTYj8RiCfmFmkSCpJBw3T4Lm-MyBalN-Lku4EnMvadUeFg>
 <xme:z4VGZs9lDkcA4DYG5qIoyzlbyheZrWm5AydV1uiwF-Awp1W9MroYztcRMiIPibZwm
 1PojKjzolrhvzM91b0>
X-ME-Received: <xmr:z4VGZlSrzYTw9s6V9AJxyUqxdgRz0dmXR_c5GNrBSVAdKi_-Pn8GnAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehvddgtdeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:z4VGZuvW0mGPe0CVXvgQeL2xz3PJC6wTORokGtQU4fnBCY4_GbZQzg>
 <xmx:z4VGZmdoxDqtzv1k_irYWMK49ydmKXuk_yQl129dl9-MaeODXWtKRQ>
 <xmx:z4VGZi2aR42vNfeSEaB4it39H-swyMMnI2lx-gV58_-rqm1sVhM7Ew>
 <xmx:z4VGZq-kGhZ2ZTPYj2lX2LUWsRRcAguM9MUIU6OJ-sXdB-TuFypIuA>
 <xmx:z4VGZm6IxxvTjcjYbp-ddzu_2wYexcEXBSlyDt69_CukeoPUA8owK1_J>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 May 2024 18:16:46 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 16 May 2024 23:16:43 +0100
Subject: [PATCH 3/6] video: Rework pixel format handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240516-rework-video-format-v1-3-f69822b742a3@flygoat.com>
References: <20240516-rework-video-format-v1-0-f69822b742a3@flygoat.com>
In-Reply-To: <20240516-rework-video-format-v1-0-f69822b742a3@flygoat.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Anatolij Gustschin <agust@denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11394;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=otZHMksbPsU6qJ/VOMyrFf23Ej+VHX83CSs48DyjRKw=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjS31tOf8trzLwnPkNvubv9HUfcY53Gt8JWl/vXrbk+Md
 Ze4E3Wto5SFQYyDQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACaiPoeR4V/0Fo9D5w0Y4/6u
 q32wrvvKxOYE1p3iGl8PfTT8z+Wx8j0jw7mkHwYTZ3bs292lX6xc8ekR29WdNZcnnnzW8snWY+v
 SUk4A
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

Our current approach on naming pixel formats and handling them
is a little bit confusing, we don't consider endian for framebuffers.

Using Linux's naming approach instead to improve robustness of the
system, also consider both endians for all pixel formats.

Formats and RGB->Pixel conversion functions are stripped to
video_format.h so we can include them in sdl.c without pull in all
u-boot headers, and inline those conversion functions everywhere.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 drivers/video/console_truetype.c |   4 +-
 drivers/video/simplefb.c         |   2 +-
 drivers/video/video-uclass.c     |  38 +++------
 drivers/video/video_bmp.c        |   6 +-
 include/video.h                  |  31 +-------
 include/video_format.h           | 161 +++++++++++++++++++++++++++++++++++++++
 lib/efi_loader/efi_gop.c         |   2 +-
 7 files changed, 179 insertions(+), 65 deletions(-)

diff --git a/drivers/video/console_truetype.c b/drivers/video/console_truetype.c
index c435162d3f94..ac0556ba1352 100644
--- a/drivers/video/console_truetype.c
+++ b/drivers/video/console_truetype.c
@@ -397,7 +397,7 @@ static int console_truetype_putc_xy(struct udevice *dev, uint x, uint y,
 
 					if (vid_priv->colour_bg)
 						val = 255 - val;
-					if (vid_priv->format == VIDEO_X2R10G10B10)
+					if (vid_priv->format == VIDEO_XRGB2101010)
 						out = val << 2 | val << 12 | val << 22;
 					else
 						out = val | val << 8 | val << 16;
@@ -923,7 +923,7 @@ static int truetype_set_cursor_visible(struct udevice *dev, bool visible,
 				for (i = 0; i < width; i++) {
 					int out;
 
-					if (vid_priv->format == VIDEO_X2R10G10B10)
+					if (vid_priv->format == VIDEO_XRGB2101010)
 						out = val << 2 | val << 12 | val << 22;
 					else
 						out = val | val << 8 | val << 16;
diff --git a/drivers/video/simplefb.c b/drivers/video/simplefb.c
index cb518b149cb5..5bbde0e8a9f9 100644
--- a/drivers/video/simplefb.c
+++ b/drivers/video/simplefb.c
@@ -72,7 +72,7 @@ static int simple_video_probe(struct udevice *dev)
 	} else if (strcmp(format, "a2r10g10b10") == 0 ||
 		   strcmp(format, "x2r10g10b10") == 0) {
 		uc_priv->bpix = VIDEO_BPP32;
-		uc_priv->format = VIDEO_X2R10G10B10;
+		uc_priv->format = VIDEO_XRGB2101010;
 	} else {
 		log_err("%s: invalid format: %s\n", __func__, format);
 		return -EINVAL;
diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index ff1382f4a43b..513766b30fb1 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -65,13 +65,6 @@ struct video_uc_priv {
 	ulong video_ptr;
 };
 
-/** struct vid_rgb - Describes a video colour */
-struct vid_rgb {
-	u32 r;
-	u32 g;
-	u32 b;
-};
-
 void video_set_flush_dcache(struct udevice *dev, bool flush)
 {
 	struct video_priv *priv = dev_get_uclass_priv(dev);
@@ -259,7 +252,7 @@ int video_clear(struct udevice *dev)
 	return 0;
 }
 
-static const struct vid_rgb colours[VID_COLOUR_COUNT] = {
+static const struct video_rgb colours[VID_COLOUR_COUNT] = {
 	{ 0x00, 0x00, 0x00 },  /* black */
 	{ 0xc0, 0x00, 0x00 },  /* red */
 	{ 0x00, 0xc0, 0x00 },  /* green */
@@ -281,30 +274,17 @@ static const struct vid_rgb colours[VID_COLOUR_COUNT] = {
 u32 video_index_to_colour(struct video_priv *priv, enum colour_idx idx)
 {
 	switch (priv->bpix) {
+	case VIDEO_BPP8:
+		if (CONFIG_IS_ENABLED(VIDEO_BPP8))
+			return video_rgb_to_pixel8(priv->format, colours[idx]);
+		break;
 	case VIDEO_BPP16:
-		if (CONFIG_IS_ENABLED(VIDEO_BPP16)) {
-			return ((colours[idx].r >> 3) << 11) |
-			       ((colours[idx].g >> 2) <<  5) |
-			       ((colours[idx].b >> 3) <<  0);
-		}
+		if (CONFIG_IS_ENABLED(VIDEO_BPP16))
+			return video_rgb_to_pixel16(priv->format, colours[idx]);
 		break;
 	case VIDEO_BPP32:
-		if (CONFIG_IS_ENABLED(VIDEO_BPP32)) {
-			switch (priv->format) {
-			case VIDEO_X2R10G10B10:
-				return (colours[idx].r << 22) |
-				       (colours[idx].g << 12) |
-				       (colours[idx].b <<  2);
-			case VIDEO_RGBA8888:
-				return (colours[idx].r << 24) |
-				       (colours[idx].g << 16) |
-				       (colours[idx].b << 8) | 0xff;
-			default:
-				return (colours[idx].r << 16) |
-				       (colours[idx].g <<  8) |
-				       (colours[idx].b <<  0);
-			}
-		}
+		if (CONFIG_IS_ENABLED(VIDEO_BPP32))
+			return video_rgb_to_pixel32(priv->format, colours[idx]);
 		break;
 	default:
 		break;
diff --git a/drivers/video/video_bmp.c b/drivers/video/video_bmp.c
index ad512d99a1b9..83380a87fd2b 100644
--- a/drivers/video/video_bmp.c
+++ b/drivers/video/video_bmp.c
@@ -80,7 +80,7 @@ static void write_pix8(u8 *fb, uint bpix, enum video_format eformat,
 			*fb++ = cte->red;
 			*fb++ = cte->green;
 			*fb++ = cte->blue;
-		} else if (eformat == VIDEO_X2R10G10B10) {
+		} else if (eformat == VIDEO_XRGB2101010) {
 			*(u32 *)fb = get_bmp_col_x2r10g10b10(cte);
 		} else if (eformat == VIDEO_RGBA8888) {
 			*(u32 *)fb = get_bmp_col_rgba8888(cte);
@@ -385,7 +385,7 @@ int video_bmp_display(struct udevice *dev, ulong bmp_image, int x, int y,
 							(bmap[0] >> 3);
 						bmap += 3;
 						fb += 2;
-					} else if (eformat == VIDEO_X2R10G10B10) {
+					} else if (eformat == VIDEO_XRGB2101010) {
 						u32 pix;
 
 						pix = *bmap++ << 2U;
@@ -422,7 +422,7 @@ int video_bmp_display(struct udevice *dev, ulong bmp_image, int x, int y,
 		if (CONFIG_IS_ENABLED(BMP_32BPP)) {
 			for (i = 0; i < height; ++i) {
 				for (j = 0; j < width; j++) {
-					if (eformat == VIDEO_X2R10G10B10) {
+					if (eformat == VIDEO_XRGB2101010) {
 						u32 pix;
 
 						pix = *bmap++ << 2U;
diff --git a/include/video.h b/include/video.h
index 4d8df9baaada..d22d6ce5fd3c 100644
--- a/include/video.h
+++ b/include/video.h
@@ -8,6 +8,8 @@
 #define _VIDEO_H_
 
 #include <stdio_dev.h>
+#include <video_format.h>
+#include <asm/byteorder.h>
 
 struct udevice;
 
@@ -44,35 +46,6 @@ enum video_polarity {
 	VIDEO_ACTIVE_LOW,	/* Pins are active low */
 };
 
-/*
- * Bits per pixel selector. Each value n is such that the bits-per-pixel is
- * 2 ^ n
- */
-enum video_log2_bpp {
-	VIDEO_BPP1	= 0,
-	VIDEO_BPP2,
-	VIDEO_BPP4,
-	VIDEO_BPP8,
-	VIDEO_BPP16,
-	VIDEO_BPP32,
-};
-
-/*
- * Convert enum video_log2_bpp to bytes and bits. Note we omit the outer
- * brackets to allow multiplication by fractional pixels.
- */
-#define VNBYTES(bpix)	((1 << (bpix)) / 8)
-
-#define VNBITS(bpix)	(1 << (bpix))
-
-enum video_format {
-	VIDEO_UNKNOWN,
-	VIDEO_RGBA8888,
-	VIDEO_X8B8G8R8,
-	VIDEO_X8R8G8B8,
-	VIDEO_X2R10G10B10,
-};
-
 /**
  * struct video_priv - Device information used by the video uclass
  *
diff --git a/include/video_format.h b/include/video_format.h
new file mode 100644
index 000000000000..34a0609765c9
--- /dev/null
+++ b/include/video_format.h
@@ -0,0 +1,161 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#ifndef _VIDEO_FORMAT_H_
+#define _VIDEO_FORMAT_H_
+
+#include <compiler.h>
+
+/*
+ * Bits per pixel selector. Each value n is such that the bits-per-pixel is
+ * 2 ^ n
+ */
+enum video_log2_bpp {
+	VIDEO_BPP8 = 3,
+	VIDEO_BPP16,
+	VIDEO_BPP32,
+};
+
+/*
+ * Convert enum video_log2_bpp to bytes and bits. Note we omit the outer
+ * brackets to allow multiplication by fractional pixels.
+ */
+#define VNBYTES(bpix)	((1 << (bpix)) / 8)
+
+#define VNBITS(bpix)	(1 << (bpix))
+
+/* Struct video_rgb - Describes a video colour, always 8 bpc */
+struct video_rgb {
+	uint8_t r;
+	uint8_t g;
+	uint8_t b;
+};
+
+/* Naming respects linux/include/uapi/drm/drm_fourcc.h */
+enum video_format {
+	VIDEO_DEFAULT = 0,
+	VIDEO_RGB332,		/* [7:0] R:G:B 3:3:2 */
+	VIDEO_RGB565,		/* [15:0] R:G:B 5:6:5 little endian */
+	VIDEO_RGB565_BE,	/* [15:0] R:G:B 5:6:5 big endian */
+	VIDEO_XRGB8888,		/* [31:0] x:R:G:B 8:8:8:8 little endian */
+	VIDEO_BGRX8888,		/* [31:0] B:G:R:x 8:8:8:8 little endian */
+	VIDEO_XRGB8888_BE = VIDEO_BGRX8888,
+	VIDEO_XBGR8888,		/* [31:0] x:B:G:R 8:8:8:8 little endian */
+	VIDEO_RGBA8888,		/* [31:0] R:G:B:A 8:8:8:8 little endian */
+	VIDEO_XRGB2101010,	/* [31:0] x:R:G:B 2:10:10:10 little endian */
+	VIDEO_XRGB2101010_BE,	/* [31:0] x:R:G:B 2:10:10:10 big endian */
+	VIDEO_FMT_END
+};
+
+/**
+ * video_rgb_to_pixel8() - convert a RGB color to a 8 bit pixel's
+ * memory representation.
+ *
+ * @video_format Format of pixel
+ * @rgb          RGB color
+ * Return:	 color value
+ */
+static inline uint8_t video_rgb_to_pixel8(enum video_format format,
+					  struct video_rgb rgb)
+{
+	switch (format) {
+	case VIDEO_DEFAULT:
+	case VIDEO_RGB332:
+		return ((rgb.r >> 5) << 5) |
+		       ((rgb.g >> 5) << 2) |
+		       (rgb.b >> 6);
+	default:
+		break;
+	}
+	return 0;
+}
+
+/**
+ * video_rgb_to_pixel16() - convert a RGB color to a 16 bit pixel's
+ * memory representation.
+ *
+ * @video_format Format of pixel
+ * @rgb          RGB color
+ * Return:	 color value
+ */
+static inline uint16_t video_rgb_to_pixel16(enum video_format format,
+					    struct video_rgb rgb)
+{
+	unsigned int val = 0;
+
+	/* Handle layout first */
+	switch (format) {
+	case VIDEO_DEFAULT:
+	case VIDEO_RGB565:
+	case VIDEO_RGB565_BE:
+		val = ((rgb.r >> 3) << 11) |
+		      ((rgb.g >> 2) <<  5) |
+		      ((rgb.b >> 3) <<  0);
+		break;
+	default:
+		break;
+	}
+
+	/* Then handle endian */
+	switch (format) {
+	case VIDEO_RGB565_BE:
+		return cpu_to_be16(val);
+	default:
+		return cpu_to_le16(val);
+	}
+
+}
+
+/**
+ * video_rgb_to_pixel32() - convert a RGB color to a 32 bit pixel's
+ * memory representation.
+ *
+ * @video_format Format of pixel
+ * @rgb          RGB color
+ * Return:	 color value
+ */
+static inline uint32_t video_rgb_to_pixel32(enum video_format format,
+					    struct video_rgb rgb)
+{
+	unsigned int val = 0;
+
+	/* Handle layout first */
+	switch (format) {
+#ifdef __LITTLE_ENDIAN
+	case VIDEO_DEFAULT:
+#endif
+	case VIDEO_XRGB8888:
+		val = (rgb.r << 16) | (rgb.g << 8) | rgb.b;
+		break;
+#ifdef __BIG_ENDIAN
+	case VIDEO_DEFAULT:
+#endif
+	case VIDEO_BGRX8888:
+		val = (rgb.b << 24) | (rgb.g << 8) | (rgb.r << 8);
+		break;
+	case VIDEO_XBGR8888:
+		val = (rgb.b << 16) | (rgb.g << 8) | rgb.b;
+		break;
+	case VIDEO_RGBA8888:
+		val = (rgb.r << 24) | (rgb.g << 16) | (rgb.b << 8) | 0xff;
+		break;
+	case VIDEO_XRGB2101010:
+	case VIDEO_XRGB2101010_BE:
+		val = (rgb.r << 22) | (rgb.g << 12) | (rgb.b << 2);
+	default:
+		break;
+	}
+
+	/* Then handle endian */
+	switch (format) {
+	case VIDEO_XRGB2101010_BE:
+		return cpu_to_be32(val);
+	default:
+		return cpu_to_le32(val);
+	}
+
+	return 0;
+}
+#endif
diff --git a/lib/efi_loader/efi_gop.c b/lib/efi_loader/efi_gop.c
index 41e12fa72460..fec48804a472 100644
--- a/lib/efi_loader/efi_gop.c
+++ b/lib/efi_loader/efi_gop.c
@@ -531,7 +531,7 @@ efi_status_t efi_gop_register(void)
 	gopobj->info.height = row;
 	if (bpix == VIDEO_BPP32)
 	{
-		if (format == VIDEO_X2R10G10B10) {
+		if (format == VIDEO_XRGB2101010) {
 			gopobj->info.pixel_format = EFI_GOT_BITMASK;
 			gopobj->info.pixel_bitmask[0] = 0x3ff00000; /* red */
 			gopobj->info.pixel_bitmask[1] = 0x000ffc00; /* green */

-- 
2.34.1

