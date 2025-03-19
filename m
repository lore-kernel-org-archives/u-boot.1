Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAEF8C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:56:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1510B81E6C;
	Wed, 19 Mar 2025 15:55:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cmdOjmMA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E86D82012; Wed, 19 Mar 2025 15:55:37 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25DFB81EC9
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:55:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cfe63c592so51479135e9.2
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396134; x=1743000934; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ok5BsbyCnVdM0R2qe67a/kntfUsxct3Lrr/6qy44l78=;
 b=cmdOjmMAhLj8JyRo/iOu4HiNYWoi7p8NT3MPZwHeFuDKZOq+g333AVBdWS3pcryq28
 zL0Yvm/g7zOQob7637RaxDE22JrDwGf4TFZpBB/nh73n+LUUlGbQFpll7lw3Kz0QRTDY
 Fng62rtGMoKgm+DfaL1z/CBLY8Hj8CyZ+lJYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396134; x=1743000934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ok5BsbyCnVdM0R2qe67a/kntfUsxct3Lrr/6qy44l78=;
 b=XJBv0G/jB0m8vjUouR9V195JoWCgD7UHw9XXntrX9CO0fHJTFK27Kp7GdcbKiOinDG
 6hhuJmo5BaBGrILpA1YMyOgzk65a2A99aLGA9v0EnLtrNAgwqdOdNepXzpYmKfbSJSgG
 1f49cOhdLtSUfCY3oaNXxArqe3eF4E2Xx+8tgN5Oju9pTwBBx9oLIs86cs5SRbMwtfQz
 GhZYqXjHI32DB8WipbBIH+GflOt9FRvpLzywdlm0TkqNK6Zt/XPc7sfOQc8x+l1mWet6
 watCRhoG9a/qkuRhdvlqb3q/wk00J7gbUB8FAK+a74j7b8H0DQXLGQQ4gcRc7UKyHacr
 QGWw==
X-Gm-Message-State: AOJu0Yx0FX3lsX4EONVvsGNh65KUqfaA86JzbO7rV+auuBSF3toXTiCi
 9DXbV5OM5kzGWIETvvPxio22gsBkJPUv8A+yg9O79CraI9sk3P/SLmNUbM+S88L3fxCHER3Qags
 =
X-Gm-Gg: ASbGncttbNlsEF4YzFOPawdCWEt4qgQVs8HV/Uj3OPJ44Jhh1ik0S6jZCSTvtQzncY2
 +edUSP+S/QCGECkgpndVhXhOJrfOjLDwh9QZauftkX1+jCLo0FgitU9TOd8IIkXYPi+AD5MhCGg
 tX+Vc509ODE0VxwNqETgL8T1c/S9o5+mRclXOV+SspXNqBmsa7BH2UM98MtkFbo9vH3LmtAESiA
 U1JAfbpQNd5VDVhx00ZBSEkRAKJOMx9oBTkSsu54qJo57LHcMcqwst8Vvbf5r0Wu9EH9W7puo8g
 +cD7ah0KAvBKiS+w3oivcY+T0sryRuaOvtq7WfoVvNxnTnL6X/om
X-Google-Smtp-Source: AGHT+IFLPej8OeXIqOtTg85S3mrPGFh+ClUXU2bEtjCmnBbVWTs40oozbj8/qaL6ih40rpr224AUGg==
X-Received: by 2002:a05:600c:a08e:b0:43c:fcbc:9680 with SMTP id
 5b1f17b1804b1-43d4383d0c6mr24723945e9.25.1742396133938; 
 Wed, 19 Mar 2025 07:55:33 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:55:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Janne Grunau <j@jannau.net>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/52] video: Begin support for measuring multiple lines of
 text
Date: Wed, 19 Mar 2025 15:54:09 +0100
Message-ID: <20250319145512.2391122-5-sjg@chromium.org>
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

Update the vidconsole API so that measure() can measure multiple lines
of text. This will make it easier to implement multi-line fields in
expo.

Tidy up the function comments while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/scene.c                      |  2 +-
 drivers/video/console_truetype.c  |  3 +-
 drivers/video/vidconsole-uclass.c |  7 +++--
 include/video_console.h           | 50 +++++++++++++++++++++++--------
 test/dm/video.c                   |  5 +++-
 5 files changed, 49 insertions(+), 18 deletions(-)

diff --git a/boot/scene.c b/boot/scene.c
index 15e7a8b3387..d3ae5816bef 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -298,7 +298,7 @@ int scene_obj_get_hw(struct scene *scn, uint id, int *widthp)
 		}
 
 		ret = vidconsole_measure(scn->expo->cons, txt->font_name,
-					 txt->font_size, str, &bbox);
+					 txt->font_size, str, &bbox, NULL);
 		if (ret)
 			return log_msg_ret("mea", ret);
 		if (widthp)
diff --git a/drivers/video/console_truetype.c b/drivers/video/console_truetype.c
index 980baee83cf..7b9033818d3 100644
--- a/drivers/video/console_truetype.c
+++ b/drivers/video/console_truetype.c
@@ -733,7 +733,8 @@ static int truetype_select_font(struct udevice *dev, const char *name,
 }
 
 static int truetype_measure(struct udevice *dev, const char *name, uint size,
-			    const char *text, struct vidconsole_bbox *bbox)
+			    const char *text, struct vidconsole_bbox *bbox,
+			    struct alist *lines)
 {
 	struct console_tt_metrics *met;
 	stbtt_fontinfo *font;
diff --git a/drivers/video/vidconsole-uclass.c b/drivers/video/vidconsole-uclass.c
index a1dfd35b7b8..4ca41dc331e 100644
--- a/drivers/video/vidconsole-uclass.c
+++ b/drivers/video/vidconsole-uclass.c
@@ -608,14 +608,17 @@ int vidconsole_select_font(struct udevice *dev, const char *name, uint size)
 }
 
 int vidconsole_measure(struct udevice *dev, const char *name, uint size,
-		       const char *text, struct vidconsole_bbox *bbox)
+		       const char *text, struct vidconsole_bbox *bbox,
+		       struct alist *lines)
 {
 	struct vidconsole_priv *priv = dev_get_uclass_priv(dev);
 	struct vidconsole_ops *ops = vidconsole_get_ops(dev);
 	int ret;
 
 	if (ops->measure) {
-		ret = ops->measure(dev, name, size, text, bbox);
+		if (lines)
+			alist_empty(lines);
+		ret = ops->measure(dev, name, size, text, bbox, lines);
 		if (ret != -ENOSYS)
 			return ret;
 	}
diff --git a/include/video_console.h b/include/video_console.h
index 13197fa4518..ee9ce3c0e37 100644
--- a/include/video_console.h
+++ b/include/video_console.h
@@ -6,6 +6,7 @@
 #ifndef __video_console_h
 #define __video_console_h
 
+#include <alist.h>
 #include <video.h>
 
 struct abuf;
@@ -119,6 +120,19 @@ struct vidconsole_bbox {
 	int y1;
 };
 
+/**
+ * vidconsole_mline - Holds information about a line of measured text
+ *
+ * @bbox: Bounding box of the line, assuming it starts at 0,0
+ * @start: String index of the first character in the line
+ * @len: Number of characters in the line
+ */
+struct vidconsole_mline {
+	struct vidconsole_bbox bbox;
+	int start;
+	int len;
+};
+
 /**
  * struct vidconsole_ops - Video console operations
  *
@@ -228,18 +242,23 @@ struct vidconsole_ops {
 	int (*select_font)(struct udevice *dev, const char *name, uint size);
 
 	/**
-	 * measure() - Measure the bounds of some text
+	 * measure() - Measure the bounding box of some text
 	 *
-	 * @dev:	Device to adjust
+	 * @dev:	Console device to use
 	 * @name:	Font name to use (NULL to use default)
 	 * @size:	Font size to use (0 to use default)
 	 * @text:	Text to measure
 	 * @bbox:	Returns bounding box of text, assuming it is positioned
 	 *		at 0,0
+	 * @lines:	If non-NULL, this must be an alist of
+	 *		struct vidconsole_mline inited by caller. A separate
+	 *		record is added for each line of text
+	 *
 	 * Returns: 0 on success, -ENOENT if no such font
 	 */
 	int (*measure)(struct udevice *dev, const char *name, uint size,
-		       const char *text, struct vidconsole_bbox *bbox);
+		       const char *text, struct vidconsole_bbox *bbox,
+		       struct alist *lines);
 
 	/**
 	 * nominal() - Measure the expected width of a line of text
@@ -320,19 +339,24 @@ int vidconsole_get_font(struct udevice *dev, int seq,
  */
 int vidconsole_select_font(struct udevice *dev, const char *name, uint size);
 
-/*
- * vidconsole_measure() - Measuring the bounding box of some text
+/**
+ * vidconsole_measure() - Measure the bounding box of some text
  *
- * @dev: Console device to use
- * @name: Font name, NULL for default
- * @size: Font size, ignored if @name is NULL
- * @text: Text to measure
- * @bbox: Returns nounding box of text
- * Returns: 0 if OK, -ve on error
+ * @dev:	Device to adjust
+ * @name:	Font name to use (NULL to use default)
+ * @size:	Font size to use (0 to use default)
+ * @text:	Text to measure
+ * @bbox:	Returns bounding box of text, assuming it is positioned
+ *		at 0,0
+ * @lines:	If non-NULL, this must be an alist of
+ *		struct vidconsole_mline inited by caller. The list is emptied
+ *		and then a separate record is added for each line of text
+ *
+ * Returns: 0 on success, -ENOENT if no such font
  */
 int vidconsole_measure(struct udevice *dev, const char *name, uint size,
-		       const char *text, struct vidconsole_bbox *bbox);
-
+		       const char *text, struct vidconsole_bbox *bbox,
+		       struct alist *lines);
 /**
  * vidconsole_nominal() - Measure the expected width of a line of text
  *
diff --git a/test/dm/video.c b/test/dm/video.c
index 6ce1a756e25..cfc831b6931 100644
--- a/test/dm/video.c
+++ b/test/dm/video.c
@@ -788,6 +788,7 @@ static int dm_test_font_measure(struct unit_test_state *uts)
 	struct vidconsole_bbox bbox;
 	struct video_priv *priv;
 	struct udevice *dev, *con;
+	struct alist lines;
 
 	ut_assertok(uclass_get_device(UCLASS_VIDEO, 0, &dev));
 	priv = dev_get_uclass_priv(dev);
@@ -797,11 +798,13 @@ static int dm_test_font_measure(struct unit_test_state *uts)
 	/* this is using the Nimbus font with size of 18 pixels */
 	ut_assertok(uclass_get_device(UCLASS_VIDEO_CONSOLE, 0, &con));
 	vidconsole_position_cursor(con, 0, 0);
-	ut_assertok(vidconsole_measure(con, NULL, 0, test_string, &bbox));
+	ut_assertok(vidconsole_measure(con, NULL, 0, test_string, &bbox,
+				       &lines));
 	ut_asserteq(0, bbox.x0);
 	ut_asserteq(0, bbox.y0);
 	ut_asserteq(0x47a, bbox.x1);
 	ut_asserteq(0x12, bbox.y1);
+	ut_asserteq(0, lines.count);
 
 	return 0;
 }
-- 
2.43.0

