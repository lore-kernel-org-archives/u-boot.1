Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE44C3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:49:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC2A9829CD;
	Fri,  2 May 2025 16:47:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FWijgviy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 669AD828F8; Fri,  2 May 2025 16:47:48 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5E3A82153
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:47:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-8644aa73dfcso75928339f.0
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197264; x=1746802064; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=utTTuYyNBXHl8dR7XfpASr8wYMROflkFfa4nEjGMWZ8=;
 b=FWijgviyow7ITQxi8hjNvHhjtOCC7yOQoZ2muTyUP0oIhNkaKs6MQ4CSZNDJYtmbeW
 f4OPKh2l7BDRvCeLI+H+lmhr/FX0QdN4DjN/gLJf3bCY9NtST6OdxbLU0MHcev0ywfUF
 qYLuAD/pVJP5z4No2V2Qd+VhdGaIQtKQzKBfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197264; x=1746802064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=utTTuYyNBXHl8dR7XfpASr8wYMROflkFfa4nEjGMWZ8=;
 b=cmXApWPQbVuhvcYT0geEZMaXZmYJ95rtU9F/MZek1DauTjDJDCPoIiPwfei8j8HLFU
 FCOfYlvyjQBz6NqbvwDk9jh0c2cL84OrgGOFapLAayQulnwF0kzO3ykMsKpcJUWK+Ki5
 uzob5C0LDuvq1QlOgtTY01Y6VR0ivqxc7jE2j13081BpQBO/TrKp4vaeoN0ysxJRWQ+c
 ccmQL9U6+QGteXKYUz9Anr7r49GRDS2DIBr0Yj7RwOLdduxMM2uL5fyaCToVQpFb5rBO
 Nizog667mVh5RO0V0HUqEQAXc8fo5vzet5bVQ99/49jTo0tmVddPiGT/zf/Zqhj+ggv+
 NfWw==
X-Gm-Message-State: AOJu0YyybDdWMp2uU0S9LwI8KBcdWnrBJk+UUL+QN5so2OBDss3OI11P
 i01K+lzqhhdsJoM27HJqxpQsmtcPANbUTe6DGW9hJOwNvj6tscv8CDlf13MxpoomjhFxFb0Yw2M
 =
X-Gm-Gg: ASbGncvYiFFSBLkx/W4LhvOoqrQaOZKiyKdDCCCYeDBZnMoTogNRn1sJGH9owzxd9PC
 8RLbm1waNkHfbsgHCQKIL68CUu7RRVFQpI1Be3GxqJee2HxLQJjUx3sY5wXK9gyAU5WTf7IPCpa
 0uDrMgFEpyTGiTEUpNMTkLoHL4EjfNYY7cMZRQ2ZJxCx7e6EIC+IUFqDq0YtrhIy3FydMR6sbWM
 qItGJUIQPynONN8IqVmd9EydZuXzmokxMDS5GP+S946yvK/W+vdz5VNq9Ar0KUUafXRxM38iNky
 T4ceMlmyjAtqz3roOg31YRJ9jDxJfQy4WNF44KXmRCx9RvmJ/fMk+lz5fEClTbeHG76AY7jQrIN
 FfA==
X-Google-Smtp-Source: AGHT+IGt1CevUb2wzNUUmXu5xmfihjdxFpdy183auK4OEC/bXZpvfhqvaXE98u8Aq5m/zKjQ7GCv0w==
X-Received: by 2002:a05:6602:2b15:b0:865:3f10:5ac9 with SMTP id
 ca18e2360f4ac-8669f96859bmr402562439f.2.1746197264098; 
 Fri, 02 May 2025 07:47:44 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:47:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Peter Robinson <pbrobinson@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 11/60] video: truetype: Support a limit on the width of a
 line
Date: Fri,  2 May 2025 08:46:09 -0600
Message-ID: <20250502144718.313633-12-sjg@chromium.org>
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

Expo needs to be able to word-wrap lines so that they are displayed as
the user expects. Add a limit on the width of each line and support this
in the measurement algorithm.

Add a log category to truetype while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/scene.c                      |  2 +-
 drivers/video/console_truetype.c  | 40 ++++++++++++++++-----
 drivers/video/vidconsole-uclass.c |  6 ++--
 include/video_console.h           | 10 +++---
 test/dm/video.c                   | 59 ++++++++++++++++++++++++++++++-
 5 files changed, 100 insertions(+), 17 deletions(-)

diff --git a/boot/scene.c b/boot/scene.c
index 1311055aac3..90b4ccf4766 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -297,7 +297,7 @@ int scene_obj_get_hw(struct scene *scn, uint id, int *widthp)
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

