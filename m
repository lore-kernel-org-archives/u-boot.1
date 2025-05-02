Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2E0C3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:48:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B16C8290A;
	Fri,  2 May 2025 16:47:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Zxvsa1Gn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10EC782982; Fri,  2 May 2025 16:47:45 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 319BB82977
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:47:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-85e15dc801aso199719539f.2
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197260; x=1746802060; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0JrVfI+ThKSHbYDwWKnhMWA9c+dU3855JK6NCsiqi8E=;
 b=Zxvsa1GnR9TB1GJtvnpetVmpnmHb/ufBUTqLSKOJait9zoZDl8zYmHh7++fZrp+lr2
 M7JwAZgqvo+ihVACd3Yv4wU4td8ZBsQAXSiHMtQ8VoWMnMIXwFYZOmbjt/NxGy6YajFL
 0LZ8NcJKNTSNfZjEaWhrUm9ojyuxoGWIzaIVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197260; x=1746802060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0JrVfI+ThKSHbYDwWKnhMWA9c+dU3855JK6NCsiqi8E=;
 b=qIH1FeridH7UExAn2E/ZqUwPjttbTvz8mQQ0kY7ZTelkeYQyu38kwuQK9Yb7L2bnK0
 EhPORwehlzZtwE3ylv3AnreJhYsy3hJ0yIQMLp1ncBxxq5bGHeZahp/J525qDc2jxUlG
 erSRfgvfsURlqW645P9eoOvkdDuxCdveMLhL94Qj3/OongTy8Uc0eDgyEOJCg5vPK2NJ
 0I1Tg4g2FdeAY/dzNXjWlM61Cx8itMvnMVv6idRiEUJlDHtDczOTnzE90eiyVq+Vh9CL
 jCdfO3wQt4YahnkjsLGdtVDl21D4xyvVEuihMlM7L+ZFuaBlMXkmwKa317Lz03XamTNj
 VhPg==
X-Gm-Message-State: AOJu0YzBQHKFHPIZaGMqZx+djI90VVTA8xjmH2QTJwvP5ph9VzDUEMpb
 L4F2N1sykEMHr5HfhzsKl679Vb57EdOFl7YmFPzDllSzKU7ppvVE17Azylb+UAllGABplKrl4xU
 =
X-Gm-Gg: ASbGncuM3SRNNT0U67TDfIZ9MVVcU9DwXdEgCeTx+ynPrY2jrzeVouoAXxa0btpa2YI
 h3+dD+AXffN/89fFT+k5gKfFPDHo8adOuRqHBEpkgwW5HrY+V2w5ZKccm3mBEWXue9wEIm7DzMl
 LwMWkTNrQozXxx74pnjzJualN/oGxErdJsFahU/qP6Nv6NZF2N01qipdGQnkAUuj3BRMnGfjLoQ
 8j9wGUPcJg0T2LsjMELsSg9aY5PBqejiCtKXYyUapyeGIi9fDpwv7UbhUhQmNgcZBgFdLlb0PR3
 hk1DVsEQBRWVb7m+qKmGhe8N8pRJBPn3wHXWMFfIroVoWEtJU8DZ/Huk2/88IkX+oSYqK0+51qQ
 ptg==
X-Google-Smtp-Source: AGHT+IF21D1OjI2rl1lVZkDCMyLY7fnf6ZqDMYh7xNjK16NFWSOmV75wsvOVsiwAq9OkUcJEzbpGiA==
X-Received: by 2002:a05:6602:2763:b0:864:ab75:758 with SMTP id
 ca18e2360f4ac-8669f99351emr490251439f.4.1746197260307; 
 Fri, 02 May 2025 07:47:40 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.47.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:47:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Peter Robinson <pbrobinson@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 09/60] video: truetype: Fill in the measured line
Date: Fri,  2 May 2025 08:46:07 -0600
Message-ID: <20250502144718.313633-10-sjg@chromium.org>
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

Create a measured line for the (single) line of text.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

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

