Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B1CC3600C
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:08:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBC7181E3E;
	Fri, 28 Mar 2025 14:07:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="j3cnNqxQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8A1181F66; Fri, 28 Mar 2025 14:07:34 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 511CE81F45
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:07:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-85b43b60b6bso62756139f.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167250; x=1743772050; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AZuf4C30Hge5k/VN7qG3TNJLMz9f7pY9mHplsKuisdo=;
 b=j3cnNqxQm0KkSf2cQoSsgMyCC+jaUGnLRqHfu6Cv9a14RPDDvSnPrqBu6fZ0PRkJk6
 JvfIQTL2V42RSJy+tpMaoMJRVa9qyhMmnY87bggyoNrwFwQRcfYsQXDaPymkI7aAeh7i
 o8QY4DbKHDfvLaF8sBh6WKkpfbPSfQ3TcbWzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167250; x=1743772050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AZuf4C30Hge5k/VN7qG3TNJLMz9f7pY9mHplsKuisdo=;
 b=W24xu8oUsPFsrCt5D3ptVB6hh5X0+gaN7rPRiB/7YCpAk4rsrysACAEDxBQz2YGF42
 6eaWXtDQevvKVMhejHKKkhFt6X2+mItgXeKqXzav4kcwpfA1vbpT4k8eaZE8WvIaSYDv
 DfUzjpthJ34jRwhxGxjkjOPgZQCYvo3GAOplcduG4jBmbqkahIu/lKbIPi0JzpvdXsx8
 45r2qaAzw7Aa/qxZHy/esWZOSK4BqUOWv49WT2Zq2BTs6mIkdqh7yAiCWUVslYuGly7N
 jhZIkYpFnRqh8S0SPTdL/neYRwwrNQlTLBX5CrHDxlz0jVV/lAvlE0BmvcQ25QbspUbw
 i5Ew==
X-Gm-Message-State: AOJu0YxxGFL9N9piSEH8p8nPisa2Y5H5J8mkGZgp2by6gcgXVweWoOgW
 7R+OOMhkmFFfJ6J9RHR7e/q7c7LkKhC1Pt75/KS/ECxs4+/l4DZRCz5YUEmcebBi5tIX5ZtDFQ0
 =
X-Gm-Gg: ASbGncsGvVKT1lnOtLCB0i7pikbmPmkFyrzw1ewxqI6NFlE89JgMQiSFHO6HffodyVy
 N1rqtsMqBOYtXX0KK8iIfeItnHbJmf/b8d+fyNmOxGQOK2ZxV2Zaf+LzqAljqCJc+ZyCHZDFeR0
 siDaWf6VJqUv+e5AJKxCQ4k+dm7WMN3xN/Yea0gdBNqjdB9UGCaLZ4nnumOsrrk/InMDVAsgO4G
 El+sQmeM7KsPRh2ndq3pn26C5pXUGzcTGx1jWETxfsHT/nbB0Ox9Sfv6nybi1oBQvqhcbpHP6LH
 hDbX/Nq6LJnYtqXQFsSL4PaOaDTtZqnzuotmVP7cCMwuIC05rYC5EanmylIj8z1bZx66Oxpgner
 4tR/1Cg==
X-Google-Smtp-Source: AGHT+IE4HAlnGx9n+WNMY0oYRvQqHfwMrjkyH5xsjvAYIEDWw/yOGFrc9RCF5xjFMac+EGX+674/MA==
X-Received: by 2002:a05:6602:1695:b0:85d:ad56:af88 with SMTP id
 ca18e2360f4ac-85e91d3bc3cmr210125839f.1.1743167250275; 
 Fri, 28 Mar 2025 06:07:30 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.07.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:07:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 06/56] video: truetype: Support newlines in the measured
 string
Date: Fri, 28 Mar 2025 07:05:53 -0600
Message-ID: <20250328130713.2612648-7-sjg@chromium.org>
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

