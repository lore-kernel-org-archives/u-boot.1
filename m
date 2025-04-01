Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E6B8C36017
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 17:31:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9117A81FAA;
	Tue,  1 Apr 2025 19:30:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PRRJDV4K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A19C817C4; Tue,  1 Apr 2025 19:30:46 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C35582063
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 19:30:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-30384072398so7883040a91.0
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 10:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743528641; x=1744133441; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aFqOM6/OP5tgCAftMUdIXRcGxuO4BZiZW4UQDQ17x7Q=;
 b=PRRJDV4KklSTw4eem8v+jXPFdkTrGKQZDX0iL7Sc1KiRf+7oSE9FGd/OBxhXpIr+QH
 bYr1ll72gRoB2X3ajpgpJsx4MSfqiL7aG+vaoQjdKOWaE7z0LFqLrTKxR2M9TJttmh+C
 EuxNdflo33U+MW0Vj2lquakliGI9wHcFK+4OY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743528641; x=1744133441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aFqOM6/OP5tgCAftMUdIXRcGxuO4BZiZW4UQDQ17x7Q=;
 b=diISWNQHZW+SkUMqqe/dj5SuYFQTvHcpnht8D1/YfPxS3NnrDipnUaf/KzPquCIyjD
 Mf+hivwY3zc8GhfReA0rm7fSKOn65NLlvgYY4BNqjGiernP2VuNHrw1rq75fPL6FqEfU
 KpE6SPUJib7bVcQADYqAyFmEYL0zpULNqS4fEHE5yWFUBrthaqHi3tBnTFHysJt3KFHQ
 nGYEXWvWKh7MMVviLA2w9QqdGsvmXS7DKvz+8gQqkNdmOmnXbLu1IcMyomfghTCH/CZg
 VNJ3LDdAl17PpWMp+B6PCGuRiQU5YQugRQhGZzTxbZKl5OAn1neUkNF3GlZ6j+eoZZdw
 L0cw==
X-Gm-Message-State: AOJu0Yz5rGZZHec88y4mk5ghtvX1hnM9WwZzeFs3BS2XGGtrwWYSqm3J
 F2uwf3KY4MXDB72sCvb/HzCaKaSHJfTstd/FGdbKRG5uAAV0gP8bmC+kXrr7eiyOz3eMoLImigo
 eOw==
X-Gm-Gg: ASbGncvo/hbNJPTYiwGnWgyiyjCHgRRv74P4fwyo3S7is1MLG+uz+WhCWDW2mZ+TBXA
 rm1anWRuuNzaazT3ntbYhG/jwE/TlR3feh/vvIdnkCIdP7w2haCHB7iQuS+VUql+WFDOPikn5w1
 0hB7Pv9/jJgD5uITuy/fAKGSFC4XdmR6TSwttATZI61pWR6QuaxtmhhOZvk91t0xMuWqojgJl9N
 B7xQ+DpZQ+BoxofXFFmsh7ge+e0mBMjSxyGiqi819XtLQQiq7sQGhe23R7zwi6pMIueUcbJgYpu
 snSQOKhr4ZBeWAw2cBMJOrVGrH5cpMiZ3KlD9v+T0EE=
X-Google-Smtp-Source: AGHT+IGAg5EbHk4idwp0oK1KjRwR/uUO4kx4QT/uh9Hb24uHqBFWW1vBQDjyP+H+pw0uY9EQ/N+54Q==
X-Received: by 2002:a17:90b:5685:b0:2ff:698d:ef7c with SMTP id
 98e67ed59e1d1-30532157b9fmr21012049a91.29.1743528641038; 
 Tue, 01 Apr 2025 10:30:41 -0700 (PDT)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3039dfd48e2sm11958976a91.9.2025.04.01.10.30.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 10:30:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/13] video: truetype: Support a limit on the width of a line
Date: Wed,  2 Apr 2025 06:29:39 +1300
Message-ID: <20250401172948.1236000-9-sjg@chromium.org>
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

Expo needs to be able to word-wrap lines so that they are displayed as
the user expects. Add a limit on the width of each line and support this
in the measurement algorithm.

Add a log category to truetype while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/scene.c                      |  2 +-
 drivers/video/console_truetype.c  | 40 ++++++++++++++++-----
 drivers/video/vidconsole-uclass.c |  6 ++--
 include/video_console.h           | 10 +++---
 test/dm/video.c                   | 59 ++++++++++++++++++++++++++++++-
 5 files changed, 100 insertions(+), 17 deletions(-)

diff --git a/boot/scene.c b/boot/scene.c
index d3ae5816bef..fb82ffe768c 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -298,7 +298,7 @@ int scene_obj_get_hw(struct scene *scn, uint id, int *widthp)
 		}
 
 		ret = vidconsole_measure(scn->expo->cons, txt->font_name,
-					 txt->font_size, str, &bbox, NULL);
+					 txt->font_size, str, -1, &bbox, NULL);
 		if (ret)
 			return log_msg_ret("mea", ret);
 		if (widthp)
diff --git a/drivers/video/console_truetype.c b/drivers/video/console_truetype.c
index 6eca5d7f543..2e3e6f07112 100644
--- a/drivers/video/console_truetype.c
+++ b/drivers/video/console_truetype.c
@@ -3,6 +3,8 @@
  * Copyright (c) 2016 Google, Inc
  */
 
+#define LOG_CATEGORY	UCLASS_VIDEO
+
 #include <abuf.h>
 #include <dm.h>
 #include <log.h>
@@ -733,16 +735,17 @@ static int truetype_select_font(struct udevice *dev, const char *name,
 }
 
 static int truetype_measure(struct udevice *dev, const char *name, uint size,
-			    const char *text, struct vidconsole_bbox *bbox,
-			    struct alist *lines)
+			    const char *text, int pixel_limit,
+			    struct vidconsole_bbox *bbox, struct alist *lines)
 {
 	struct console_tt_metrics *met;
 	struct vidconsole_mline mline;
-	const char *s;
+	const char *s, *last_space;
+	int width, last_width;
 	stbtt_fontinfo *font;
 	int lsb, advance;
-	int width;
 	int start;
+	int limit;
 	int lastch;
 	int ret;
 
@@ -754,14 +757,30 @@ static int truetype_measure(struct udevice *dev, const char *name, uint size,
 	if (!*text)
 		return 0;
 
+	limit = -1;
+	if (pixel_limit != -1)
+		limit = tt_ceil((double)pixel_limit / met->scale);
+
 	font = &met->font;
 	width = 0;
 	bbox->y1 = 0;
+	bbox->x1 = 0;
 	start = 0;
+	last_space = NULL;
+	last_width = 0;
 	for (lastch = 0, s = text; *s; s++) {
 		int neww;
 		int ch = *s;
 
+		if (ch == ' ') {
+			/*
+			 * store the position and width so we can use it again
+			 * if we need to word-wrap
+			 */
+			last_space = s;
+			last_width = width;
+		}
+
 		/* First get some basic metrics about this character */
 		stbtt_GetCodepointHMetrics(font, ch, &advance, &lsb);
 		neww = width + advance;
@@ -772,10 +791,16 @@ static int truetype_measure(struct udevice *dev, const char *name, uint size,
 		lastch = ch;
 
 		/* see if we need to start a new line */
-		if (ch == '\n') {
+		if (ch == '\n' || (limit != -1 && neww >= limit)) {
+			if (ch != '\n' && last_space) {
+				s = last_space;
+				width = last_width;
+			}
+			last_space = NULL;
 			mline.bbox.x0 = 0;
 			mline.bbox.y0 = bbox->y1;
 			mline.bbox.x1 = tt_ceil((double)width * met->scale);
+			bbox->x1 = max(bbox->x1, mline.bbox.x1);
 			bbox->y1 += met->font_size;
 			mline.bbox.y1 = bbox->y1;
 			mline.bbox.valid = true;
@@ -788,8 +813,7 @@ static int truetype_measure(struct udevice *dev, const char *name, uint size,
 				  mline.start, mline.len, mline.len, text + mline.start);
 
 			start = s - text;
-			if (ch == '\n')
-				start++;
+			start++;
 			lastch = 0;
 			neww = 0;
 		}
@@ -811,7 +835,7 @@ static int truetype_measure(struct udevice *dev, const char *name, uint size,
 	bbox->valid = true;
 	bbox->x0 = 0;
 	bbox->y0 = 0;
-	bbox->x1 = tt_ceil((double)width * met->scale);
+	bbox->x1 = max(bbox->x1, mline.bbox.x1);
 
 	return 0;
 }
diff --git a/drivers/video/vidconsole-uclass.c b/drivers/video/vidconsole-uclass.c
index 4ca41dc331e..3259bd2ef7d 100644
--- a/drivers/video/vidconsole-uclass.c
+++ b/drivers/video/vidconsole-uclass.c
@@ -608,8 +608,8 @@ int vidconsole_select_font(struct udevice *dev, const char *name, uint size)
 }
 
 int vidconsole_measure(struct udevice *dev, const char *name, uint size,
-		       const char *text, struct vidconsole_bbox *bbox,
-		       struct alist *lines)
+		       const char *text, int limit,
+		       struct vidconsole_bbox *bbox, struct alist *lines)
 {
 	struct vidconsole_priv *priv = dev_get_uclass_priv(dev);
 	struct vidconsole_ops *ops = vidconsole_get_ops(dev);
@@ -618,7 +618,7 @@ int vidconsole_measure(struct udevice *dev, const char *name, uint size,
 	if (ops->measure) {
 		if (lines)
 			alist_empty(lines);
-		ret = ops->measure(dev, name, size, text, bbox, lines);
+		ret = ops->measure(dev, name, size, text, limit, bbox, lines);
 		if (ret != -ENOSYS)
 			return ret;
 	}
diff --git a/include/video_console.h b/include/video_console.h
index a0ee9ab62e9..1bb265dc9da 100644
--- a/include/video_console.h
+++ b/include/video_console.h
@@ -250,6 +250,7 @@ struct vidconsole_ops {
 	 * @name:	Font name to use (NULL to use default)
 	 * @size:	Font size to use (0 to use default)
 	 * @text:	Text to measure
+	 * @limit:	Width limit for each line, or -1 if none
 	 * @bbox:	Returns bounding box of text, assuming it is positioned
 	 *		at 0,0
 	 * @lines:	If non-NULL, this must be an alist of
@@ -259,8 +260,8 @@ struct vidconsole_ops {
 	 * Returns: 0 on success, -ENOENT if no such font
 	 */
 	int (*measure)(struct udevice *dev, const char *name, uint size,
-		       const char *text, struct vidconsole_bbox *bbox,
-		       struct alist *lines);
+		       const char *text, int limit,
+		       struct vidconsole_bbox *bbox, struct alist *lines);
 
 	/**
 	 * nominal() - Measure the expected width of a line of text
@@ -350,6 +351,7 @@ int vidconsole_select_font(struct udevice *dev, const char *name, uint size);
  * @name:	Font name to use (NULL to use default)
  * @size:	Font size to use (0 to use default)
  * @text:	Text to measure
+ * @limit:	Width limit for each line, or -1 if none
  * @bbox:	Returns bounding box of text, assuming it is positioned
  *		at 0,0
  * @lines:	If non-NULL, this must be an alist of
@@ -359,8 +361,8 @@ int vidconsole_select_font(struct udevice *dev, const char *name, uint size);
  * Returns: 0 on success, -ENOENT if no such font
  */
 int vidconsole_measure(struct udevice *dev, const char *name, uint size,
-		       const char *text, struct vidconsole_bbox *bbox,
-		       struct alist *lines);
+		       const char *text, int limit,
+		       struct vidconsole_bbox *bbox, struct alist *lines);
 /**
  * vidconsole_nominal() - Measure the expected width of a line of text
  *
diff --git a/test/dm/video.c b/test/dm/video.c
index a3f3b046882..c1b2a502b47 100644
--- a/test/dm/video.c
+++ b/test/dm/video.c
@@ -789,6 +789,7 @@ static int dm_test_font_measure(struct unit_test_state *uts)
 	struct vidconsole_bbox bbox;
 	struct video_priv *priv;
 	struct udevice *dev, *con;
+	const int limit = 0x320;
 	struct alist lines;
 	int nl;
 
@@ -801,7 +802,7 @@ static int dm_test_font_measure(struct unit_test_state *uts)
 	ut_assertok(uclass_get_device(UCLASS_VIDEO_CONSOLE, 0, &con));
 	vidconsole_position_cursor(con, 0, 0);
 	alist_init_struct(&lines, struct vidconsole_mline);
-	ut_assertok(vidconsole_measure(con, NULL, 0, test_string, &bbox,
+	ut_assertok(vidconsole_measure(con, NULL, 0, test_string, -1, &bbox,
 				       &lines));
 	ut_asserteq(0, bbox.x0);
 	ut_asserteq(0, bbox.y0);
@@ -831,6 +832,62 @@ static int dm_test_font_measure(struct unit_test_state *uts)
 	ut_asserteq(163, line->len);
 	ut_asserteq(strlen(test_string + nl + 1), line->len);
 
+	/* now use a limit on the width */
+	ut_assertok(vidconsole_measure(con, NULL, 0, test_string, limit, &bbox,
+				       &lines));
+	ut_asserteq(0, bbox.x0);
+	ut_asserteq(0, bbox.y0);
+	ut_asserteq(0x31e, bbox.x1);
+	ut_asserteq(0x36, bbox.y1);
+	ut_asserteq(3, lines.count);
+
+	nl = strchr(test_string, '\n') - test_string;
+
+	line = alist_get(&lines, 0, struct vidconsole_mline);
+	ut_assertnonnull(line);
+	ut_asserteq(0, line->bbox.x0);
+	ut_asserteq(0, line->bbox.y0);
+	ut_asserteq(0x8c, line->bbox.x1);
+	ut_asserteq(0x12, line->bbox.y1);
+	ut_asserteq(0, line->start);
+	ut_asserteq(20, line->len);
+	ut_asserteq(nl, line->len);
+	printf("line0 '%.*s'\n", line->len, test_string + line->start);
+	ut_asserteq_strn("There is always much",
+			 test_string + line->start);
+
+	line++;
+	ut_asserteq(0x0, line->bbox.x0);
+	ut_asserteq(0x12, line->bbox.y0);
+	ut_asserteq(0x31e, line->bbox.x1);
+	ut_asserteq(0x24, line->bbox.y1);
+	ut_asserteq(21, line->start);
+	ut_asserteq(nl + 1, line->start);
+	ut_asserteq(129, line->len);
+	printf("line1 '%.*s'\n", line->len, test_string + line->start);
+	ut_asserteq_strn("to be said for not attempting more than you can do "
+			 "and for making a certainty of what you try. But this "
+			 "principle, like others in",
+			 test_string + line->start);
+
+	line++;
+	ut_asserteq(0x0, line->bbox.x0);
+	ut_asserteq(0x24, line->bbox.y0);
+	ut_asserteq(0xc8, line->bbox.x1);
+	ut_asserteq(0x36, line->bbox.y1);
+	ut_asserteq(21 + 130, line->start);
+	ut_asserteq(33, line->len);
+	printf("line2 '%.*s'\n", line->len, test_string + line->start);
+	ut_asserteq_strn("life and war, has its exceptions.",
+			 test_string + line->start);
+
+	/*
+	 * all characters should be accounted for, except the newline and the
+	 * space which is consumed in the wordwrap
+	 */
+	ut_asserteq(strlen(test_string) - 2,
+		    line[-2].len + line[-1].len + line->len);
+
 	return 0;
 }
 DM_TEST(dm_test_font_measure, UTF_SCAN_FDT);
-- 
2.43.0

