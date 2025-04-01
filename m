Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B22DC36017
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 17:32:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE90C81F4D;
	Tue,  1 Apr 2025 19:31:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iedvARHn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8E79820F0; Tue,  1 Apr 2025 19:31:03 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D3E982107
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 19:31:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-3031354f134so7631424a91.3
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 10:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743528659; x=1744133459; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7eEspsTEAnPtQNdPpmIjYfsiogZtGlLoCRpXzW6Q/Zk=;
 b=iedvARHnyg1L3rpGebephaPekPzML3pg3AGLuahGgQRWOw2vTgODjJihikoHPoPEEx
 xNWxsrztIJSbXgCriuiPcE3eUOoAa1MIvB99ADHGolI4YgxRBaNoLuJ7GFMYU6A1LnuA
 3Lgb2NMXqMDNVpSinbTnipSQP7b9J2tZwS510=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743528659; x=1744133459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7eEspsTEAnPtQNdPpmIjYfsiogZtGlLoCRpXzW6Q/Zk=;
 b=pmoeTcaE94eS2S/u/zGrsbzVsSp7zYrBXXTQ8zxHQuI1aA8b0/mzO3WS4Iv7y+LMY0
 zgiO7o2SaKd45armd1L0FoBg5Ir8rvB5fO/pWZdApDnLgjPvxIMeg2sL0r4XCZlzZr/w
 7U/naNOWwFrtMHBzS+wBxxPSDKzbNqD4JqocRLeF6PCCAaeruR4tfJ5hJqGr/JYgKN5v
 u/Dt7D3wzJ/abEf7ElAqd91oZIqcg9d8ZfMc44QwDXpNKdBfP+dKsGIrcCIkAPXXggk/
 vLzKnO/HhLNFfQ0632FB66TDGSuYL6tdIPoS0fTs01WTq6WQj1nQv9vqGpn/AhouqHkG
 S46g==
X-Gm-Message-State: AOJu0YwwGtcx4wgWz5nYkjBJvQ+nRzcbIqbIGe+haL/GLqJspwmbmYaS
 hX1MFtDOekpR68XzIiKroO08tt10VvyPtaixM2RetuKe2GRb5WE1wIhacLFwA0EIOKhq6aktkuy
 W+Q==
X-Gm-Gg: ASbGncuF594nixTC320bhMf6tG/z09Bujkehto7OBpu4JaLG1SrUfnQCrJRBNQWvCGP
 WTwV0orza+/X/upi1WAcuk0K4h5OJG98hoJA+simxcogMD7VC0SrH1Z9rH/BHN31/w9q/zG7ySz
 35+rL4/ahw8grRpp7/f6ObdFwaFQtGNAfsWFwoRyigJI4WGljq+Lcr+AkHnRhkwaMRwoESjpYK6
 urL6F2x9K2I6AaCbTl7Go8cFM/ZhBfUYjdnRJWOjmw1pzz0GA/rx4kkXtcQep3DBkE77KaQXFmF
 BwgNhtp+2RZ3dexRe9J+wXorQ9Jgj+qC6m2UhO8QUOE=
X-Google-Smtp-Source: AGHT+IEQZAduIVBaMY6nst6njblzw/lFBSRZ3X1u1NvOZ/qq7Q8RoSYzDSSzDl2LRSJKeUkxsyDYfg==
X-Received: by 2002:a17:90b:3644:b0:305:5f32:d9f5 with SMTP id
 98e67ed59e1d1-3055f32da23mr5911896a91.7.1743528658964; 
 Tue, 01 Apr 2025 10:30:58 -0700 (PDT)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3039dfd48e2sm11958976a91.9.2025.04.01.10.30.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 10:30:58 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Devarsh Thakkar <devarsht@ti.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Nikhil M Jain <n-jain1@ti.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 12/13] video: Add a function to draw a rectangle
Date: Wed,  2 Apr 2025 06:29:43 +1300
Message-ID: <20250401172948.1236000-13-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250401172948.1236000-1-sjg@chromium.org>
References: <20250401172948.1236000-1-sjg@chromium.org>
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

