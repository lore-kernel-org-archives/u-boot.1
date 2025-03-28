Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6298C3600C
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:08:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3773C81F0B;
	Fri, 28 Mar 2025 14:07:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NzzbKJCR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6C8481E3E; Fri, 28 Mar 2025 14:07:32 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7638481E1F
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:07:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-85e46f5c50fso183828039f.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167248; x=1743772048; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0JrVfI+ThKSHbYDwWKnhMWA9c+dU3855JK6NCsiqi8E=;
 b=NzzbKJCRcy8DnP0evjPkRGe2c7RmB00pJFODMXZKWqs3pCo43aP1LSgvTNIm82cduM
 Jh0VdV4uchBcnjc22fwrAszv4CE6aXZCE+yDwzExS2hkqZ3HtVKg5Sf24xjcko8+PbyX
 RDAmpa9ky0m3rsGEnvmsMQ8BqoJUfLy2fEjaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167248; x=1743772048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0JrVfI+ThKSHbYDwWKnhMWA9c+dU3855JK6NCsiqi8E=;
 b=FQwekP41alON6LcCzeka+A769pgQpuDFK9YPeuhO2/2MSVIm5shmp0UGbRLmg2IflB
 wbRY8dlhu9v7HyqonGICaWxPAh1KD8Glhul9pnstBnlBW6NpW5gV4zDu6XFFdCqOCuTi
 TnoN/noPIuO3T8vf7Nf5qm/tWu0/szejiHY0zkgf2pFh+zXwtmVeJFGvJ+zODrqloo2g
 CYOEYHlnO2EzDfeeMplgZfq4D3p1inPof6YbAc/Drfw6M6JNhif78p8zyYAvRy1Cy3Qe
 T9L256Abrt3qH4wfYh0ID9lPLsa4N3DL4b6D7AF61j8twuUgUjbdeuzYqE8I9JT1ZqS1
 k4Bw==
X-Gm-Message-State: AOJu0YyT9MjOTh78QoDlGiicqqJiF01xrUXfiBVvLZO7s7W5ulIbO95g
 8VTKgEnxfHWYuKL2SuVDEoT/qupBSBfULrIWWPk8PjTqcFu5j4sweIUfGqiy+XISx4gEf/DGv3M
 =
X-Gm-Gg: ASbGncsDmktp/WUU5vWRXea1rRAglTWycjeWE9Ud39xoYGdT2uZCgPdyHBAiyPLPHMQ
 ny8XJJ2xcsj8ht0H4vFsKC4/PIRmeU9A5ZAWjcijdRj+m+fQtFDJ092uCKF5AU2CSpcMADWYofq
 2MKu7ysTzI34nuqxyGXzA+W2yLBlRxBhmEwWiMp4lYSK4+WEydcLg9K3PPv1QlRuK4pcCNQbmNS
 G9YMC2F6QhVkrNRc+Og/zQYnqfvopAz79lvG07iqFKgwy1vfmAKBxJAqoo4uSmb/PmQiM1iI2IU
 eu90BHl87eO3knleUEeZm1nqrNJmNGPoveql13G0+/D58mW8l3hnjklv30d/maPGodEoQ77tURc
 h6et2XA==
X-Google-Smtp-Source: AGHT+IFakASLatatdI4o4OQ3/WAXRi116RKW7jG7WMTHy4SzVnMNI8VYujAMfhpnJnQhD4ndFC9tOA==
X-Received: by 2002:a05:6602:3993:b0:85a:efae:2f15 with SMTP id
 ca18e2360f4ac-85e8205a9cdmr985974439f.1.1743167248476; 
 Fri, 28 Mar 2025 06:07:28 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.07.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:07:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Peter Robinson <pbrobinson@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 05/56] video: truetype: Fill in the measured line
Date: Fri, 28 Mar 2025 07:05:52 -0600
Message-ID: <20250328130713.2612648-6-sjg@chromium.org>
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

