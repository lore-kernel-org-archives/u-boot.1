Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 709A0C36001
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:56:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62A9481F30;
	Wed, 19 Mar 2025 15:55:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M1B+5xIT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C451E81E60; Wed, 19 Mar 2025 15:55:38 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB2AD81E60
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:55:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43948021a45so47346105e9.1
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396136; x=1743000936; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vjbI8EEIUoQ362UBCM++dOL1m1Y9BxmUuC6WjlvwnSc=;
 b=M1B+5xITk1pxSRduvaetxjun6UA+PN6dYroukG9suYKbbqA4zRRREs7dtPMGef9oRp
 kDJPSRxaQ7w/uKb50eOW9IvBympWk8r9+SRCIJGcArF/IU1TpypQB8v+Ery4rap3PT1x
 k49EDTQzaPTBpQA9c7RbmVLD4Ffwa10+KQVjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396136; x=1743000936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vjbI8EEIUoQ362UBCM++dOL1m1Y9BxmUuC6WjlvwnSc=;
 b=IqPf/+Ccm6SQ9C8A14Xays2Avwtqb9rkDxbx6gu18XYv4BKqxeyszatwiTxsr4ajd6
 H+0BOrIAeUEpWoGypyo8J1+7ddE7UiynDJRFSSxkkrI8V1FzByBb8XdLBkqD098e3mZc
 XijXpKnELUtOa4z5nNNuG/6vtvDVU/8205mqksN+vwhP4fEnFYXcgaAB35fO4ZE6sDkQ
 qWuohb31HTGM7IFFmJ6vqQt6YN1VWQccCz4eKa+SVEq1cpXLYzfBPLlGIdfD0dEOEXWs
 OObrjvD1d6rQq/ZupiXcsWIifg7azuaezp7wiZuqGVZxDtSag4leTg2WavgZxSwfz+F5
 Bn7A==
X-Gm-Message-State: AOJu0YyIf9KBteLavQSlZl0EhNIh+bYA8Qw55sJcI03cbV7MCiTY+X1U
 B/Nc68BTNM3MNYmN5WHHa7+Lxx8CoGUBsVf0r8GXd4XNwrN2xsaDXWmDItv7yzw/2NmwVC/YKho
 =
X-Gm-Gg: ASbGncuh26A6mH/PjaIz9ZIYKdaTy5I7ptJ77D1kzt01EDN3bMQ8jvSC1SOMTHHBCfR
 cqashdeq4Sc2MF23tLonTdKF+LDhRAXceGLQzOn4m9IR4Z5p1TqS1Siuno2BIpKXryopXtQa8No
 404CjAwuMDzIvPy7PO499QiMhXa0jEHVirO4hN4KVVLiN3QhO/jtCnUJ9TgyqZ65NvjFUPMZeC9
 Xak4DePTy8Kk6Ohu1i2cnCHCh1FEF+a8GV0saxZbzB5PIXmY4zP5TtTnBKji79B3aAbU5RJhFwx
 M+R0KZ410qutI0DCRnH4jY+HgUzhobKcwdFg30gqeg==
X-Google-Smtp-Source: AGHT+IHKinOY/lKUxzEKham7aYOxT6+QyWxpWtPezrq7mkHqBqNufnYlP/u8k217Q/Z/BYvsOhSG4g==
X-Received: by 2002:a05:600c:2d85:b0:43d:47b7:b32d with SMTP id
 5b1f17b1804b1-43d47b7b4c4mr7963765e9.25.1742396135569; 
 Wed, 19 Mar 2025 07:55:35 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.55.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:55:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Janne Grunau <j@jannau.net>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/52] video: truetype: Fill in the measured line
Date: Wed, 19 Mar 2025 15:54:10 +0100
Message-ID: <20250319145512.2391122-6-sjg@chromium.org>
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

Create a measured line for the (single) line of text.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/video/console_truetype.c | 36 +++++++++++++++++++++++---------
 test/dm/video.c                  | 13 +++++++++++-
 2 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/drivers/video/console_truetype.c b/drivers/video/console_truetype.c
index 7b9033818d3..39d77ad9818 100644
--- a/drivers/video/console_truetype.c
+++ b/drivers/video/console_truetype.c
@@ -737,11 +737,13 @@ static int truetype_measure(struct udevice *dev, const char *name, uint size,
 			    struct alist *lines)
 {
 	struct console_tt_metrics *met;
+	struct vidconsole_mline mline;
+	const char *s;
 	stbtt_fontinfo *font;
 	int lsb, advance;
-	const char *s;
 	int width;
-	int last;
+	int start;
+	int lastch;
 	int ret;
 
 	ret = get_metrics(dev, name, size, &met);
@@ -754,25 +756,39 @@ static int truetype_measure(struct udevice *dev, const char *name, uint size,
 
 	font = &met->font;
 	width = 0;
-	for (last = 0, s = text; *s; s++) {
+	bbox->y1 = 0;
+	start = 0;
+	for (lastch = 0, s = text; *s; s++) {
+		int neww;
 		int ch = *s;
 
-		/* Used kerning to fine-tune the position of this character */
-		if (last)
-			width += stbtt_GetCodepointKernAdvance(font, last, ch);
-
 		/* First get some basic metrics about this character */
 		stbtt_GetCodepointHMetrics(font, ch, &advance, &lsb);
+		neww = width + advance;
 
-		width += advance;
-		last = ch;
+		/* Use kerning to fine-tune the position of this character */
+		if (lastch)
+			neww += stbtt_GetCodepointKernAdvance(font, lastch, ch);
+		lastch = ch;
+
+		width = neww;
 	}
 
+	/* add the line */
+	mline.bbox.x0 = 0;
+	mline.bbox.y0 = bbox->y1;
+	mline.bbox.x1 = tt_ceil((double)width * met->scale);
+	bbox->y1 += met->font_size;
+	mline.bbox.y1 = bbox->y1;
+	mline.start = start;
+	mline.len = (s - text) - start;
+	if (lines && !alist_add(lines, mline))
+		return log_msg_ret("ttM", -ENOMEM);
+
 	bbox->valid = true;
 	bbox->x0 = 0;
 	bbox->y0 = 0;
 	bbox->x1 = tt_ceil((double)width * met->scale);
-	bbox->y1 = met->font_size;
 
 	return 0;
 }
diff --git a/test/dm/video.c b/test/dm/video.c
index cfc831b6931..d3fd74a9a9a 100644
--- a/test/dm/video.c
+++ b/test/dm/video.c
@@ -785,6 +785,7 @@ static int dm_test_font_measure(struct unit_test_state *uts)
 		"attempting more than you can do and for making a certainty of "
 		"what you try. But this principle, like others in life and "
 		"war, has its exceptions.";
+	const struct vidconsole_mline *line;
 	struct vidconsole_bbox bbox;
 	struct video_priv *priv;
 	struct udevice *dev, *con;
@@ -798,13 +799,23 @@ static int dm_test_font_measure(struct unit_test_state *uts)
 	/* this is using the Nimbus font with size of 18 pixels */
 	ut_assertok(uclass_get_device(UCLASS_VIDEO_CONSOLE, 0, &con));
 	vidconsole_position_cursor(con, 0, 0);
+	alist_init_struct(&lines, struct vidconsole_mline);
 	ut_assertok(vidconsole_measure(con, NULL, 0, test_string, &bbox,
 				       &lines));
 	ut_asserteq(0, bbox.x0);
 	ut_asserteq(0, bbox.y0);
 	ut_asserteq(0x47a, bbox.x1);
 	ut_asserteq(0x12, bbox.y1);
-	ut_asserteq(0, lines.count);
+	ut_asserteq(1, lines.count);
+
+	line = alist_get(&lines, 0, struct vidconsole_mline);
+	ut_assertnonnull(line);
+	ut_asserteq(0, line->bbox.x0);
+	ut_asserteq(0, line->bbox.y0);
+	ut_asserteq(0x47a, line->bbox.x1);
+	ut_asserteq(0x12, line->bbox.y1);
+	ut_asserteq(0, line->start);
+	ut_asserteq(strlen(test_string), line->len);
 
 	return 0;
 }
-- 
2.43.0

