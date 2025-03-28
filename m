Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40520C3600C
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:09:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C95A81F71;
	Fri, 28 Mar 2025 14:07:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PpGfs+w5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C01B481F69; Fri, 28 Mar 2025 14:07:46 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 708C081F59
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:07:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-85e1b1f08a5so54685939f.2
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167261; x=1743772061; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ApvaUdJhDWREPUGZzdbAhquHrcZtWoKEWTZWk4Z/dBw=;
 b=PpGfs+w5yZjH/oWFnLNJn86ZbyPBH4mRjvGY/lm3V+YrlCPz449Rls9aDeFNdmWGRj
 /gjDohZX80e63I1vK6jBTgF90X6pES28jtheafM14HSLGoLOXWChf+Gd72Fxv+rYQ7lA
 8/PLCUovWTxSUapmlcodUNEB/BEHZuEybNK2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167261; x=1743772061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ApvaUdJhDWREPUGZzdbAhquHrcZtWoKEWTZWk4Z/dBw=;
 b=Altwb4erIvKT902ty2RUDB5LTYJs17qGf4daJxaHe+Ctq2SmSpMjyHpZ4oTSW4L4FZ
 snvaNqDp12iXMCmwui31xYy/SXo9MtzBnCieaVVOnThPgE7ZbhWhFGPsv2/dzBdK85VL
 jCi8B6gyLYZEoUF0PdrgPLja5XpGPZQSqUrsmIscnre0Bqr2FS1LYGaBaWt0tuRUFbp9
 F5wioIRVP7o7sbT0bAQzOA6bWk+JDyJ1OAbRTtIXpy7/p2g2y4gx1dDvZ6mTkHIGUQEQ
 CYLeEBuOpwexowRPVgWhiFLYFmSDEqRxjki8/hbEYbcEhclgRU5PLsLiU/HQGhx0r5xd
 lQng==
X-Gm-Message-State: AOJu0Yydc7Fhq0ItXP7I1aP0zVWeo/g5QZVZx2BWak100Ninl9b6JNJf
 gP06z60BL4Nios3SOGR0hJEFCGY/GLIlpm/puNQyY20sdEWqMJ3hq1fPJI9tUzB89t7eplv2dfE
 =
X-Gm-Gg: ASbGncv0YpPsuk0gmSylsgEqAs7r96JUYU2rTZLah3FJ42H3qEQj0lsGn9wxKwcqFB2
 R+1K0P5t5Ar5toaGU6e1uOXE1wVH9WsYc4ogkn1beKuRpftDpi5OJqQQw9IBP6hQI33qEwbT7XR
 VsykE5vsekyJRHUYIwj1fIwQFQV/DpUAeFXfado5VU/isbghq+6QbrVh0kcR2+n6fd6CB2EohuZ
 MmMeV/fqjcCJS26JN4b2BaM9vA8WA3dsobX3e+3Ck+FIUbaoyTxUkkBldts1G9rYEiFGcSJma01
 f540o8i8vHiGQFuYY+fN6hXzBs0mSe+IwzUcg5V54iBTLOSI9c/knzZ3urh2iDY0zrgBYS5zQ6g
 NvAYmkg==
X-Google-Smtp-Source: AGHT+IG7YrmatYFcJmCVoftz6ea4ZpmZsu0WoPgonY7zdflWzpKI9c0Oa4cWtIiz7Ld7RdjyXC42og==
X-Received: by 2002:a05:6e02:3207:b0:3d4:3cd7:d29c with SMTP id
 e9e14a558f8ab-3d5ccdd54cbmr74716845ab.11.1743167261445; 
 Fri, 28 Mar 2025 06:07:41 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.07.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:07:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Devarsh Thakkar <devarsht@ti.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 12/56] video: Add a function to draw a rectangle
Date: Fri, 28 Mar 2025 07:05:59 -0600
Message-ID: <20250328130713.2612648-13-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328130713.2612648-1-sjg@chromium.org>
References: <20250328130713.2612648-1-sjg@chromium.org>
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

(no changes since v1)

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

