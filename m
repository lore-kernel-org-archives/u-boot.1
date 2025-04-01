Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1520C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 17:30:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81C2981F4D;
	Tue,  1 Apr 2025 19:30:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oKC+WDp4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36CAD82006; Tue,  1 Apr 2025 19:30:18 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 966ED8205A
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 19:30:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3014678689aso8195775a91.0
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 10:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743528613; x=1744133413; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6YbyRgRGIZbHYqo7kqTfLFuOlGgo+1+OfkPr1SpfUPI=;
 b=oKC+WDp4rMFuRvf2536g5cJ1a7iAN73a4jztkyX5mrlvnD7PuI8T/UMsDWMVmm/HqI
 kAlUs+2vKi4NztdIhhgeVbHxj9eoC1lzDHe3iz7PfFnCv1+pJ1nnTvL1/OIOvA6A42dB
 XPOUIBh/QqQ0FK+w6UsEk5AUVba4Yd9ZgSPbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743528613; x=1744133413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6YbyRgRGIZbHYqo7kqTfLFuOlGgo+1+OfkPr1SpfUPI=;
 b=lfSRAekjJdmPy949ciGjVPJYJM+W8mTDBjPAXmrO1/2irJ8mB9ElJ8H2wOYt6s81C5
 bvSpFJmI+BQsAcwV1KSGT7cfo43sX90qMeiJet4dSTGIelKDuMwJ+HvCst0HoUlHlV2M
 X1f3t1lbKi8MkqB8eiN0P4x+WqfhwvAjVjGlN6QJa4S15ssCmCGBGEVwRSgbGlHPqsg1
 8UiPXbpzO3zvikrEyak8Xf+A5deDHD1hjo1LnlfNIc305qUAhdrtsIhWdfBneM2XHdI4
 YY9uLxF32Aqp6P/0yFdwOa7SdeoGmHF0Q0V97DFaV3My4rmeiS6Id0+gOUONjop/mIbx
 Sb7g==
X-Gm-Message-State: AOJu0YzJ9oRu76hvsQ6KyrofsCGr3tkVY4U/+bAkvWG6+JBV+Iv0HWln
 gcilXXPmkCCSWJcCCSlpUkSNP17yG60/QRND1+6I+tD5IwSDpFxXhQmbqApz/hJZ56+7dfMel/6
 Hng==
X-Gm-Gg: ASbGnctHVD/BO/+7X+Ov7IK5jkF241VLTwkxw3j66sKxFFqEdx0m5yBe10cvd5ibDpw
 yGzjsvH9D31lKlhPqhE1rnGTSoMMr4FBPPBsZleP7WJiCsLY3DFox2KcYKyk7FbwqUk5WockywB
 gb3vElwQHZ4A4m5sjdQpMJB6wsAIvE3+Wmzx/OEwn8hkEDGp5rPzcO1tbB8M7ROnZUGkSN5stDQ
 HBqAzO4p3LhUCfi3sinq5W2aYPKGFvKU/V+O7I9QmSOKK3l8IZt6CdWYSymlxGhqUVnCU+UmWlF
 cosbMPm2E/H11QMf4zltWt/Ed7fVsGSedY1TDqimHyE=
X-Google-Smtp-Source: AGHT+IFXDqgzRWqww3wTRQvtEI2BV3pNojqjRdQJyeAgbij5IYtkyJNZbITmtB3jhMhKLfTVXtBqWA==
X-Received: by 2002:a17:90b:1b08:b0:2ee:ed1c:e451 with SMTP id
 98e67ed59e1d1-305320af3aamr19621019a91.15.1743528613049; 
 Tue, 01 Apr 2025 10:30:13 -0700 (PDT)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3039dfd48e2sm11958976a91.9.2025.04.01.10.30.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 10:30:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Devarsh Thakkar <devarsht@ti.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Nikhil M Jain <n-jain1@ti.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/13] video: Make white-on-black a video-device property
Date: Wed,  2 Apr 2025 06:29:33 +1300
Message-ID: <20250401172948.1236000-3-sjg@chromium.org>
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

The CONFIG_WHITE_ON_BLACK setting is hard-coded at build-time. It is
useful to be able to control this when showing menus.

Create a property to hold this information, using the CONFIG as the
initial value.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/expo.c                  |  2 +-
 boot/scene.c                 |  8 ++++----
 drivers/video/video-uclass.c | 16 +++++++++++++++-
 include/video.h              | 12 ++++++++++++
 4 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/boot/expo.c b/boot/expo.c
index 786f665f53c..8ce645e5a8f 100644
--- a/boot/expo.c
+++ b/boot/expo.c
@@ -194,7 +194,7 @@ int expo_render(struct expo *exp)
 	u32 colour;
 	int ret;
 
-	back = CONFIG_IS_ENABLED(SYS_WHITE_ON_BLACK) ? VID_BLACK : VID_WHITE;
+	back = vid_priv->white_on_black ? VID_BLACK : VID_WHITE;
 	colour = video_index_to_colour(vid_priv, back);
 	ret = video_fill(dev, colour);
 	if (ret)
diff --git a/boot/scene.c b/boot/scene.c
index 3290a40222a..15e7a8b3387 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -330,8 +330,9 @@ static void scene_render_background(struct scene_obj *obj, bool box_only)
 	enum colour_idx fore, back;
 	uint inset = theme->menu_inset;
 
+	vid_priv = dev_get_uclass_priv(dev);
 	/* draw a background for the object */
-	if (CONFIG_IS_ENABLED(SYS_WHITE_ON_BLACK)) {
+	if (vid_priv->white_on_black) {
 		fore = VID_DARK_GREY;
 		back = VID_WHITE;
 	} else {
@@ -344,7 +345,6 @@ static void scene_render_background(struct scene_obj *obj, bool box_only)
 		return;
 
 	vidconsole_push_colour(cons, fore, back, &old);
-	vid_priv = dev_get_uclass_priv(dev);
 	video_fill_part(dev, label_bbox.x0 - inset, label_bbox.y0 - inset,
 			label_bbox.x1 + inset, label_bbox.y1 + inset,
 			vid_priv->colour_fg);
@@ -408,7 +408,8 @@ static int scene_obj_render(struct scene_obj *obj, bool text_mode)
 			struct vidconsole_colour old;
 			enum colour_idx fore, back;
 
-			if (CONFIG_IS_ENABLED(SYS_WHITE_ON_BLACK)) {
+			vid_priv = dev_get_uclass_priv(dev);
+			if (vid_priv->white_on_black) {
 				fore = VID_BLACK;
 				back = VID_WHITE;
 			} else {
@@ -416,7 +417,6 @@ static int scene_obj_render(struct scene_obj *obj, bool text_mode)
 				back = VID_BLACK;
 			}
 
-			vid_priv = dev_get_uclass_priv(dev);
 			if (obj->flags & SCENEOF_POINT) {
 				vidconsole_push_colour(cons, fore, back, &old);
 				video_fill_part(dev, x - theme->menu_inset, y,
diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index 1e385f12f8e..db40744c196 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -343,7 +343,7 @@ void video_set_default_colors(struct udevice *dev, bool invert)
 	struct video_priv *priv = dev_get_uclass_priv(dev);
 	int fore, back;
 
-	if (CONFIG_IS_ENABLED(SYS_WHITE_ON_BLACK)) {
+	if (priv->white_on_black) {
 		/* White is used when switching to bold, use light gray here */
 		fore = VID_LIGHT_GRAY;
 		back = VID_BLACK;
@@ -580,6 +580,18 @@ static void video_idle(struct cyclic_info *cyc)
 	video_sync_all();
 }
 
+void video_set_white_on_black(struct udevice *dev, bool white_on_black)
+{
+	struct video_priv *priv = dev_get_uclass_priv(dev);
+
+	if (priv->white_on_black != white_on_black) {
+		priv->white_on_black = white_on_black;
+		video_set_default_colors(dev, false);
+
+		video_clear(dev);
+	}
+}
+
 /* Set up the display ready for use */
 static int video_post_probe(struct udevice *dev)
 {
@@ -622,6 +634,8 @@ static int video_post_probe(struct udevice *dev)
 	if (IS_ENABLED(CONFIG_VIDEO_COPY) && plat->copy_base)
 		priv->copy_fb = map_sysmem(plat->copy_base, plat->size);
 
+	priv->white_on_black = CONFIG_IS_ENABLED(SYS_WHITE_ON_BLACK);
+
 	/* Set up colors  */
 	video_set_default_colors(dev, false);
 
diff --git a/include/video.h b/include/video.h
index 2fe2f73a865..0ec6b1ca289 100644
--- a/include/video.h
+++ b/include/video.h
@@ -100,6 +100,7 @@ enum video_format {
  * @fg_col_idx:	Foreground color code (bit 3 = bold, bit 0-2 = color)
  * @bg_col_idx:	Background color code (bit 3 = bold, bit 0-2 = color)
  * @last_sync:	Monotonic time of last video sync
+ * @white_on_black: Use a black background
  */
 struct video_priv {
 	/* Things set up by the driver: */
@@ -131,6 +132,7 @@ struct video_priv {
 	u8 fg_col_idx;
 	u8 bg_col_idx;
 	ulong last_sync;
+	bool white_on_black;
 };
 
 /**
@@ -346,6 +348,16 @@ void video_set_flush_dcache(struct udevice *dev, bool flush);
  */
 void video_set_default_colors(struct udevice *dev, bool invert);
 
+/**
+ * video_set_white_on_black() - Change the setting for white-on-black
+ *
+ * This does nothing if the setting is already the same.
+ *
+ * @dev: video device
+ * @white_on_black: true to use white-on-black, false for black-on-white
+ */
+void video_set_white_on_black(struct udevice *dev, bool white_on_black);
+
 /**
  * video_default_font_height() - Get the default font height
  *
-- 
2.43.0

