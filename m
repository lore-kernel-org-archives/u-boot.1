Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B2CC3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:48:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86942828F8;
	Fri,  2 May 2025 16:47:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZHDQ0Pq0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A307828F8; Fri,  2 May 2025 16:47:47 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47BFB828BC
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:47:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-85e15dc801aso199722339f.2
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197262; x=1746802062; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AZuf4C30Hge5k/VN7qG3TNJLMz9f7pY9mHplsKuisdo=;
 b=ZHDQ0Pq0taqA6gnzf2CS0cP5FA9KeD64HGyZVurkC7DZReASzvjZssuNZ0BROUIE6N
 FlsA7oBW6moFCBc5HIybjacMy+1ve+baWcpHk3Lj3esLiHm7LKNF63dWXKvdNTeam1SZ
 q6txb8tyFnN7+ozm8uM3YhKmE/ghjrApflGqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197262; x=1746802062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AZuf4C30Hge5k/VN7qG3TNJLMz9f7pY9mHplsKuisdo=;
 b=NZyWWYbL6FG/TATP7c7GOWxlby0h2NRQYnGivLUcFamwnLni7IlwLUZHyz09dtGbrp
 BjtCL6djiOjffUfDcbDWhO94+xNYA4yaLeDtmKZ7JHkhCPgUym2lupOUZulLYkFcBgb5
 vfSJtZ5OQDJ7kJ4ofrQs7nsIADZhiVb+YE7aYUh5WHxoexsTYyLcJe6ClbCEdfPvpQ+E
 c88LzDarlz4QqgS6ejD87/fYdrSNQOhPgImqL7FgkTvTonGyKd+tDn0AqC8Yl9X/SIjj
 zLfQWPKvqFrLrnC1GNs14XSKZJBvnQDh+zSdLNWFkh/0dTz/LxCyiXngebhKq6Y+cnTL
 ft6A==
X-Gm-Message-State: AOJu0YyOjScP1fomZbbQW/pmmsP5A2/JJe2MTGtxL8W2O88mQuO2z2+T
 uDm8gs90TGdcQCpzFX3RmAQUaXbciwBlij8s7QwlEm9FCAKWP5zm0127TUYDSSkJhZ4bAtjdzBU
 =
X-Gm-Gg: ASbGnctYFVqIEOkS0zDpB+/UCVttk249g0yK/4V7tHwavxuI5byUmNhgOmyxwNQXFnr
 qcFYWb0sETscoKI3fqKGZy8ip3ooBsjiGtNRpNB/jwkPf3DShJyXPbaZkVANy3jOto+fV9uAbuu
 WNxPmmNCeWtv4wOPTQYSqUaBevPaBb7+q/o2J/RM2hW2KO2TrCBo67Q+ZnNjg7FvoJb6gPiptS7
 iyvpmnmTnDH3Y8FJz8lCCbzt/w5tuoNTMCIItmgKNH6spGPpS3GZpT8+w7mwpSWuwgjkkMYvblG
 KKwVyLceJ+bxk4LyUU+WDkevs5vtVWDY7FIfTic3iqxsbqQooy9MeH5wIsmKAbJX+10Pe+tNgV4
 Kqw==
X-Google-Smtp-Source: AGHT+IES0G7r7d2dZJB404P95mglMHc2D2wSTizJQr/lERof/cD+NcNtYoQcuCfAUDoW9yvm8BeBpA==
X-Received: by 2002:a05:6602:2763:b0:864:ab75:758 with SMTP id
 ca18e2360f4ac-8669f99351emr490271539f.4.1746197262476; 
 Fri, 02 May 2025 07:47:42 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.47.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:47:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Peter Robinson <pbrobinson@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 10/60] video: truetype: Support newlines in the measured
 string
Date: Fri,  2 May 2025 08:46:08 -0600
Message-ID: <20250502144718.313633-11-sjg@chromium.org>
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

It is useful to be able to embed newline characters in the string and
have the text measured into multiple lines. Add support for this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/video/console_truetype.c | 25 ++++++++++++++++++++++++-
 include/video_console.h          |  4 ++++
 test/dm/video.c                  | 26 ++++++++++++++++++++------
 3 files changed, 48 insertions(+), 7 deletions(-)

diff --git a/drivers/video/console_truetype.c b/drivers/video/console_truetype.c
index 39d77ad9818..6eca5d7f543 100644
--- a/drivers/video/console_truetype.c
+++ b/drivers/video/console_truetype.c
@@ -771,10 +771,33 @@ static int truetype_measure(struct udevice *dev, const char *name, uint size,
 			neww += stbtt_GetCodepointKernAdvance(font, lastch, ch);
 		lastch = ch;
 
+		/* see if we need to start a new line */
+		if (ch == '\n') {
+			mline.bbox.x0 = 0;
+			mline.bbox.y0 = bbox->y1;
+			mline.bbox.x1 = tt_ceil((double)width * met->scale);
+			bbox->y1 += met->font_size;
+			mline.bbox.y1 = bbox->y1;
+			mline.bbox.valid = true;
+			mline.start = start;
+			mline.len = (s - text) - start;
+			if (lines && !alist_add(lines, mline))
+				return log_msg_ret("ttm", -ENOMEM);
+			log_debug("line x1 %d y0 %d y1 %d start %d len %d text '%.*s'\n",
+				  mline.bbox.x1, mline.bbox.y0, mline.bbox.y1,
+				  mline.start, mline.len, mline.len, text + mline.start);
+
+			start = s - text;
+			if (ch == '\n')
+				start++;
+			lastch = 0;
+			neww = 0;
+		}
+
 		width = neww;
 	}
 
-	/* add the line */
+	/* add the final line */
 	mline.bbox.x0 = 0;
 	mline.bbox.y0 = bbox->y1;
 	mline.bbox.x1 = tt_ceil((double)width * met->scale);
diff --git a/include/video_console.h b/include/video_console.h
index ee9ce3c0e37..a0ee9ab62e9 100644
--- a/include/video_console.h
+++ b/include/video_console.h
@@ -244,6 +244,8 @@ struct vidconsole_ops {
 	/**
 	 * measure() - Measure the bounding box of some text
 	 *
+	 * The text can include newlines
+	 *
 	 * @dev:	Console device to use
 	 * @name:	Font name to use (NULL to use default)
 	 * @size:	Font size to use (0 to use default)
@@ -342,6 +344,8 @@ int vidconsole_select_font(struct udevice *dev, const char *name, uint size);
 /**
  * vidconsole_measure() - Measure the bounding box of some text
  *
+ * The text can include newlines
+ *
  * @dev:	Device to adjust
  * @name:	Font name to use (NULL to use default)
  * @size:	Font size to use (0 to use default)
diff --git a/test/dm/video.c b/test/dm/video.c
index d3fd74a9a9a..a3f3b046882 100644
--- a/test/dm/video.c
+++ b/test/dm/video.c
@@ -781,7 +781,7 @@ DM_TEST(dm_test_video_damage, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 /* Test font measurement */
 static int dm_test_font_measure(struct unit_test_state *uts)
 {
-	const char *test_string = "There is always much to be said for not "
+	const char *test_string = "There is always much\nto be said for not "
 		"attempting more than you can do and for making a certainty of "
 		"what you try. But this principle, like others in life and "
 		"war, has its exceptions.";
@@ -790,6 +790,7 @@ static int dm_test_font_measure(struct unit_test_state *uts)
 	struct video_priv *priv;
 	struct udevice *dev, *con;
 	struct alist lines;
+	int nl;
 
 	ut_assertok(uclass_get_device(UCLASS_VIDEO, 0, &dev));
 	priv = dev_get_uclass_priv(dev);
@@ -804,18 +805,31 @@ static int dm_test_font_measure(struct unit_test_state *uts)
 				       &lines));
 	ut_asserteq(0, bbox.x0);
 	ut_asserteq(0, bbox.y0);
-	ut_asserteq(0x47a, bbox.x1);
-	ut_asserteq(0x12, bbox.y1);
-	ut_asserteq(1, lines.count);
+	ut_asserteq(0x3ea, bbox.x1);
+	ut_asserteq(0x24, bbox.y1);
+	ut_asserteq(2, lines.count);
+
+	nl = strchr(test_string, '\n') - test_string;
 
 	line = alist_get(&lines, 0, struct vidconsole_mline);
 	ut_assertnonnull(line);
 	ut_asserteq(0, line->bbox.x0);
 	ut_asserteq(0, line->bbox.y0);
-	ut_asserteq(0x47a, line->bbox.x1);
+	ut_asserteq(0x8c, line->bbox.x1);
 	ut_asserteq(0x12, line->bbox.y1);
 	ut_asserteq(0, line->start);
-	ut_asserteq(strlen(test_string), line->len);
+	ut_asserteq(20, line->len);
+	ut_asserteq(nl, line->len);
+
+	line++;
+	ut_asserteq(0x0, line->bbox.x0);
+	ut_asserteq(0x12, line->bbox.y0);
+	ut_asserteq(0x3ea, line->bbox.x1);
+	ut_asserteq(0x24, line->bbox.y1);
+	ut_asserteq(21, line->start);
+	ut_asserteq(nl + 1, line->start);
+	ut_asserteq(163, line->len);
+	ut_asserteq(strlen(test_string + nl + 1), line->len);
 
 	return 0;
 }
-- 
2.43.0

