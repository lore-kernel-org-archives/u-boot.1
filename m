Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F6CC35FFC
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:57:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B05582033;
	Wed, 19 Mar 2025 15:55:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ETT34UQ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBC3781E60; Wed, 19 Mar 2025 15:55:54 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A56108206E
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:55:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cfb6e9031so41214015e9.0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396151; x=1743000951; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7eEspsTEAnPtQNdPpmIjYfsiogZtGlLoCRpXzW6Q/Zk=;
 b=ETT34UQ4m9NBlWye710lJxBeTzdD01GNloXYLCW11jGuwPwf1x/m5BEU32MXMP2WVJ
 yr49ZoxbbxQaSLde2fVOysBMMdQgPIz3YzjYaYIBVMzwxy15NGkwX9PYJE6zfcXLnQVA
 mLWBM1Qia4yt0ftOoAr7m5YbPZLUjBy4ZDIjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396151; x=1743000951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7eEspsTEAnPtQNdPpmIjYfsiogZtGlLoCRpXzW6Q/Zk=;
 b=sz+BHvYX6eWm1qMhOSRRxBuqOjRzJqyWC/l3sUOESNTvA2C+lgXkgib+xDzFDuZJpQ
 +8YpzbI/rC9/SCJCtQw7wQTSeBz0HKaZQhHirog58d1Bg3J74iidvO/uHoI85s2hMqe3
 fS4VsJAyPrEC8AIsRlroioPvciY6cAbqGT0nIBQdvLRF+TyIqJOnkZN8uxywcVJxzrhH
 X/pnijkg9rTsleIoEa5kWY6e0Tc1V4RWyz+6z/AG9bqmiZa3N1g/dp6ofaoB8+t7Xtzz
 B+X+P1h/Xrv+jWkgHrH61izPZtyfj9IACvndhM3N0tgxrnlPNRDBqC+4LJILCJ07fgS8
 6CEg==
X-Gm-Message-State: AOJu0YzCHaBH/gWGxktH03m2cIYeS+BsfUP9wm/KT7GLX/uUG7lyf3aZ
 lQlY4xqfyx5iG8mBhiVUGupeWYVf5Ae1rYlMtAwoPKcMYKIMp0ST25UuM5IuBryhPvMkvowJVwA
 =
X-Gm-Gg: ASbGncu95pQ8jh2eNG/fnZ+HxguCr5uz8MjUDRNjNk0yARp04LY/qv2QXZYoTWZx4+B
 uCjvThXUnX6PA2SZ273J6O8FaE30T6FMiXRLXYTkqae71ox5Q62S+iSHFbKBaX8uMfoLQ/fIIrW
 8/oytmdVQ5aGddtgzw0hwPbBPr9NJlXa8Uv1MabNkTPCiF8GPmtzgOYiGD/O38/NuaZFJVUa7Mu
 fJP8iMZoYblCt6yCvbT+kXKV7eGDpCXxwaiepQMfN8DU6hdR0M4iRaCfwa7LW9H9oAyPVVdh4Q6
 Hu6TtiflvQ9t9KtdggpE1qeB9mp79zuPEp7PZXOtuw==
X-Google-Smtp-Source: AGHT+IGmPa4XHi4fzq6Dar9nq5jQYrBTee7AXTcPYG0tmF6yg2EM5OViI9LtFvRkSrmT+EtFz4dnjw==
X-Received: by 2002:a05:600c:3b92:b0:439:9a40:aa0b with SMTP id
 5b1f17b1804b1-43d43882ebcmr25513785e9.25.1742396151439; 
 Wed, 19 Mar 2025 07:55:51 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.55.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:55:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Devarsh Thakkar <devarsht@ti.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Nikhil M Jain <n-jain1@ti.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 12/52] video: Add a function to draw a rectangle
Date: Wed, 19 Mar 2025 15:54:17 +0100
Message-ID: <20250319145512.2391122-13-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319145512.2391122-1-sjg@chromium.org>
References: <20250319145512.2391122-1-sjg@chromium.org>
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

Provide a way to draw an unfilled box of a certain width. This is useful
for grouping menu items together.

Add a comment showing how to see the copy-framebuffer, for testing.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/video/video-uclass.c | 36 ++++++++++++++++++++++++++++++++++++
 include/video.h              | 19 ++++++++++++++++++-
 test/dm/video.c              | 21 +++++++++++++++++++++
 3 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index db40744c196..780b2bc6125 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -26,6 +26,7 @@
 #ifdef CONFIG_SANDBOX
 #include <asm/sdl.h>
 #endif
+#include "vidconsole_internal.h"
 
 /*
  * Theory of operation:
@@ -216,6 +217,40 @@ int video_fill_part(struct udevice *dev, int xstart, int ystart, int xend,
 	return 0;
 }
 
+int video_draw_box(struct udevice *dev, int x0, int y0, int x1, int y1,
+		   int width, u32 colour)
+{
+	struct video_priv *priv = dev_get_uclass_priv(dev);
+	int pbytes = VNBYTES(priv->bpix);
+	void *start, *line;
+	int pixels = x1 - x0;
+	int row;
+
+	start = priv->fb + y0 * priv->line_length;
+	start += x0 * pbytes;
+	line = start;
+	for (row = y0; row < y1; row++) {
+		void *ptr = line;
+		int i;
+
+		for (i = 0; i < width; i++)
+			fill_pixel_and_goto_next(&ptr, colour, pbytes, pbytes);
+		if (row < y0 + width || row >= y1 - width) {
+			for (i = 0; i < pixels - width * 2; i++)
+				fill_pixel_and_goto_next(&ptr, colour, pbytes,
+							 pbytes);
+		} else {
+			ptr += (pixels - width * 2) * pbytes;
+		}
+		for (i = 0; i < width; i++)
+			fill_pixel_and_goto_next(&ptr, colour, pbytes, pbytes);
+		line += priv->line_length;
+	}
+	video_damage(dev, x0, y0, x1 - x0, y1 - y0);
+
+	return 0;
+}
+
 int video_reserve_from_bloblist(struct video_handoff *ho)
 {
 	if (!ho->fb || ho->size == 0)
@@ -479,6 +514,7 @@ int video_sync(struct udevice *vid, bool force)
 		video_flush_dcache(vid, true);
 
 #if defined(CONFIG_VIDEO_SANDBOX_SDL)
+	/* to see the copy framebuffer, use priv->copy_fb */
 	sandbox_sdl_sync(priv->fb);
 #endif
 	priv->last_sync = get_timer(0);
diff --git a/include/video.h b/include/video.h
index 0ec6b1ca289..9ea6b676463 100644
--- a/include/video.h
+++ b/include/video.h
@@ -249,7 +249,7 @@ int video_fill(struct udevice *dev, u32 colour);
 /**
  * video_fill_part() - Erase a region
  *
- * Erase a rectangle of the display within the given bounds.
+ * Erase a rectangle on the display within the given bounds
  *
  * @dev:	Device to update
  * @xstart:	X start position in pixels from the left
@@ -262,6 +262,23 @@ int video_fill(struct udevice *dev, u32 colour);
 int video_fill_part(struct udevice *dev, int xstart, int ystart, int xend,
 		    int yend, u32 colour);
 
+/**
+ * video_draw_box() - Draw a box
+ *
+ * Draw a rectangle on the display within the given bounds
+ *
+ * @dev:	Device to update
+ * @x0:		X start position in pixels from the left
+ * @y0:		Y start position in pixels from the top
+ * @x1:		X end position in pixels from the left
+ * @y1:		Y end position in pixels from the top
+ * @width:	width in pixels
+ * @colour:	Value to write
+ * Return: 0 if OK, -ENOSYS if the display depth is not supported
+ */
+int video_draw_box(struct udevice *dev, int x0, int y0, int x1, int y1,
+		   int width, u32 colour);
+
 /**
  * video_sync() - Sync a device's frame buffer with its hardware
  *
diff --git a/test/dm/video.c b/test/dm/video.c
index dd06b2f58e8..ecf74605b5c 100644
--- a/test/dm/video.c
+++ b/test/dm/video.c
@@ -902,3 +902,24 @@ static int dm_test_video_silence(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_video_silence, UTF_SCAN_FDT);
+
+/* test drawing a box */
+static int dm_test_video_box(struct unit_test_state *uts)
+{
+	struct video_priv *priv;
+	struct udevice *dev;
+
+	ut_assertok(video_get_nologo(uts, &dev));
+	priv = dev_get_uclass_priv(dev);
+	video_draw_box(dev, 100, 100, 200, 200, 3,
+		       video_index_to_colour(priv, VID_LIGHT_BLUE));
+	video_draw_box(dev, 300, 100, 400, 200, 1,
+		       video_index_to_colour(priv, VID_MAGENTA));
+	video_draw_box(dev, 500, 100, 600, 200, 20,
+		       video_index_to_colour(priv, VID_LIGHT_RED));
+	ut_asserteq(133, video_compress_fb(uts, dev, false));
+	ut_assertok(video_check_copy_fb(uts, dev));
+
+	return 0;
+}
+DM_TEST(dm_test_video_box, UTF_SCAN_FDT);
-- 
2.43.0

