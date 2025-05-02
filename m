Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748B4C3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:49:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BA1E829A1;
	Fri,  2 May 2025 16:48:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hTvUASH6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D3C48212F; Fri,  2 May 2025 16:47:59 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67FA382153
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:47:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-8647e143f28so187385639f.1
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197274; x=1746802074; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ApvaUdJhDWREPUGZzdbAhquHrcZtWoKEWTZWk4Z/dBw=;
 b=hTvUASH6YqfCtSNnMlVr3yEa9KXPv7S01RgtGDCpbfbVhVQ/mxng82QzHRhH0XEw2A
 xbnCWzwPHqJ0qevtvs4GrKq9ri735c7OTsLY/TYwvdb+7i3yvCEjLSV78d5WS7PapxGd
 tX/kYfTmEzIZ36sR2P9LY6l7ouV8t7oeIdRnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197274; x=1746802074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ApvaUdJhDWREPUGZzdbAhquHrcZtWoKEWTZWk4Z/dBw=;
 b=EzVzqk7QSWQXw6uOb/nkWyDJkYeX0iwN0GlX6AGxx511hNnzExhs+5wSz6LoaHKL9M
 1qY5+SkZKtjvaSqmoCBoJme3fPvAol+Lnj4BcHHFAseKS/TmNsFv5LHBr500Bj0FFPyL
 aRkXAzGXKQDvjK/4tn2e2V+E0S/v2d+5ZoMcvngk/8Ktm1IP0QJ6IO4KemGgP18QG4qy
 Yu3LBVOgeGzcIS0tTtwMtnS6UJEXSzJ9FANPFeygCkBizkPdD9rCv3mWo6XTTtp2S860
 yUr+UTGbMo32o14+4AbCVe+BIow7zRhMUk6/OFdMIGYxyss93713jz5PkO/9bm14dQno
 TgTw==
X-Gm-Message-State: AOJu0YxeAizAcfwpfEIRiwnXbrZiqswrMw8OMorspEa7QXmx/GkwEaVp
 YrWVDWAPzsX+chHrzglznvhd66oQwrlXU7kbxbDTQtgCD6hnLp6oyziHbYEolqSPJWhg2iu/6/4
 =
X-Gm-Gg: ASbGncv+GXowcGjLxzfxbmxwasd82gU/bkNs/OTHNDBvQD/L5MTKMNpSX9j1vRByuda
 DTCcHYyAbzKNRv68FNCLgl/+eVDsmYQu3aWAcVwdYHvS6xUqXLHMY6SmiySMKoWFKZbHdwRCEDD
 4nmZw6uq4LP+Mu0BUqXxOADQtRejQxEpytzu1NNzvIu4UlroHIip6gMiKtTUtxmy28Wa+UzOoZC
 H2DjM9/z2y5O6GPGyi67Ms78aE+nRPEIYb8of47rHm17dMt3EvBKmHzLdXKdixF0qeG31gaO/qF
 DEUB/FJrvhjKToBrHWj/QCxiafdynXspQ/35JL8SFFb8hjlPvGc8vXTcHSiD0nQS/rr6GW+LPzP
 xaA==
X-Google-Smtp-Source: AGHT+IEr97PbOnxGYUshLcnHHWaj1aw5iYnEy44R+Xy7GjGEqEOZn8tvC3YdK10o5DVWbO5GBQ/11g==
X-Received: by 2002:a05:6602:2763:b0:864:ab75:758 with SMTP id
 ca18e2360f4ac-8669f99351emr490373739f.4.1746197273665; 
 Fri, 02 May 2025 07:47:53 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:47:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 16/60] video: Add a function to draw a rectangle
Date: Fri,  2 May 2025 08:46:14 -0600
Message-ID: <20250502144718.313633-17-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250502144718.313633-1-sjg@chromium.org>
References: <20250502144718.313633-1-sjg@chromium.org>
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

