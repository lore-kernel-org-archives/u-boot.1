Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D77C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:56:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F232082014;
	Wed, 19 Mar 2025 15:55:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Os6AFeb+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 606C682040; Wed, 19 Mar 2025 15:55:44 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 201A081DE3
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:55:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cfecdd8b2so34332205e9.2
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396141; x=1743000941; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aFqOM6/OP5tgCAftMUdIXRcGxuO4BZiZW4UQDQ17x7Q=;
 b=Os6AFeb+V6x2Hak6vBOYWE3GKwmkMbUkiikrSNuoOHLtW+QvB9atR+2fpK4l4TEwj5
 BnwV/vN7FWbPzO9csoIijH3L3Gs10Vy5h4Qc0ueD6rpu4iD107P0KlC7cgY2jqc9EPLy
 Ln5xw6embs6hjqTjK3/fFAezVFxeTILOpe7J4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396141; x=1743000941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aFqOM6/OP5tgCAftMUdIXRcGxuO4BZiZW4UQDQ17x7Q=;
 b=IjsPq01ucyaQ8Unj1mAnqXFZIfrW3nYcIJTd1vUcymdTIpRJa8kj/syFb30ghlIjqZ
 jgK2TUkptsEmNsAQ0sE/KNrZSDJpRXQQOYd1PsLWNvAAIvdW/IHmhTbx/5KNFeIhbXid
 OQAt7nrf4r4BEj+wL88Xdy9QoMPfoIObZJz8WkxltZnaSfXt1Vk9ZYRqdo1gRfjlKbdd
 0zxsDt0GjCb6LyvRRzMXybyUELG5PrFNhyLU1Ku2Ha+LGRkAqBH1I/PFeS5lu8mSS1AC
 equeEXIjh7Bvwvv2JqF0iN4CiLF1w546DzWZ6S+KV7M/NwnS8bPS7FDAwr4wa08IbsPD
 6dpQ==
X-Gm-Message-State: AOJu0YwtEKJgGlcQtKnA1K6Y3lLriUsqDCPUiC6zlMwLkly06qqJDgLO
 ftYB92d/YdEexAZFa6Tl4H64Ld1D0komayXcRwZkIK1jfikZAMWAu6GXHnKiEfVw3LwmLCVzZso
 =
X-Gm-Gg: ASbGncuPjG7c8V98AEhg1GsozlL8H+3j88tg6m4z29FNvfEr+YjRavVB84BTg0YPNRV
 t+r0OdfiO1OPTm0e0lpQT+X7ylDdvhz5bSa5l1xxLUje03nJ7SYM5cdztVkYrPc/MRB+ud0TQTu
 V+WCciWcZmcXi0Sjwpv/IAG7FfxIG1nYXNn6tWx4HzuKnEYC/QEsWDzEI/3E1Mvs7AndATYlzrt
 Gg0cuVl93ngih/hZIJDcsODC7EKlbtJwsqYUnJKsr1F/iM/ggkAhnrAN/A0WOMYaebU/OIWK71q
 14WQSMsbXgWQ75J35sftvOh0Hv0RfvEbAJWWb4mHzQ==
X-Google-Smtp-Source: AGHT+IGuhymuDZ5PWGJW0UrlDF2J7ZG9uGfPwRrS+i3gjW6JawH0TaxuqFvVt5YqRPvQhTy40NOR1w==
X-Received: by 2002:a05:600c:3d17:b0:43d:b51:46fb with SMTP id
 5b1f17b1804b1-43d4378617dmr29537495e9.2.1742396140810; 
 Wed, 19 Mar 2025 07:55:40 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.55.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:55:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Janne Grunau <j@jannau.net>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 07/52] video: truetype: Support a limit on the width of a line
Date: Wed, 19 Mar 2025 15:54:12 +0100
Message-ID: <20250319145512.2391122-8-sjg@chromium.org>
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

