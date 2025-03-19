Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D90C36000
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:56:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7C3C81ECD;
	Wed, 19 Mar 2025 15:55:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Rrkyj20B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCAC881DE3; Wed, 19 Mar 2025 15:55:41 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDE5581FE8
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:55:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so32267455e9.1
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396138; x=1743000938; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lvSMsPwwBMV2PJPQsiLmp2Bs6oMn+6QFuGgk0Zn3kNY=;
 b=Rrkyj20B4rwKVHdahiitcut6OcaqEWRozWwMxs2KB+LHaJEucgoibzlzVbuJO6IcmZ
 +XcuJJNSsPNIDvHIEqQqGjHawnVK5Lgo86iWI9tgSRuIuYCSSBh5vMaU515fSRJu6i2q
 8dvy3EQ80aF+Yo5r620nta1gu+2L1oeAYdcS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396138; x=1743000938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lvSMsPwwBMV2PJPQsiLmp2Bs6oMn+6QFuGgk0Zn3kNY=;
 b=ZuAM5ATIdw2A7Xvb67nGI3SOCdyYdFj2yoAASGqYqLSksQM9/PVEvLS1kX2P9f2ndJ
 XRw3/tgL+FE8ti56vzrLXIk92wCX5LYBK5qwahjt+r4IdcUPyO4MqzFuIQR4e+zUDJU0
 C1F4LOOCEVUc2NDfQkuiaodB13JXi56MXCULHJZw/uxj0UC7+XErbZTdopZkNsjOcQzP
 52mjDwMqUax9atL1kVnQYXiEgMKZn034/e7Xn6zYTLdwZi4CGqwAfccpzj3OixV8nV/W
 Qv7BgpodIA5VDAakhEDd3sYTovOY3DVDaAMMZqIFbVpQAM0ZEu5XoDUzvktUR4jwsoeC
 twoA==
X-Gm-Message-State: AOJu0YzTT8siw3IcK4pJvsIXI+IsEPeUrclYjpnBBd31lQkOWXPZ4Cyr
 pew4+HJyoakeM3T5aWObEjj05im1XD9mh7OTy9fQzjYlFXZ7vleOt0QQWbNEKACuPSGySZsozCQ
 =
X-Gm-Gg: ASbGnctxr80wM8+/SRdliGPwBCMl7PLkyQpd/Atuh3NN1Z0Txs68CfC/BZSca3bHqUh
 OcQ7xOa1/0beAv7qSQwtsRhazFVRu8bd0LhMerz1qpCTKv+2/IorVmEb4ZWwK3HoAfiqvKUF4OY
 CLDTPekALoS+YLLYqh3leDo7YV24tPcogpMS/JeKedGfiWjH7AHdAEzqwpNC5fY9I14WemJKyN7
 59/NLJhA9Qz9y5aQaj7WGZL2eQwFu0rj9h0yvjslwaAVQfPb4RobVKtZZjZuvrcVfnY2EJzyy8d
 +W+mD/ePH/OhfeWbhD8OOR8HTwK0hUXHl16puQk8/X/5Ab39sXyW
X-Google-Smtp-Source: AGHT+IHl+Dx/8zCE6CUWhaLui9mHqqNvxUag7mO393pi9/SwxKLHmhxRwf2BC2nyi/TN2fxREmX0tQ==
X-Received: by 2002:a05:600c:138c:b0:43d:db5:7af8 with SMTP id
 5b1f17b1804b1-43d438052fdmr21807265e9.21.1742396138214; 
 Wed, 19 Mar 2025 07:55:38 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.55.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:55:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Janne Grunau <j@jannau.net>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/52] video: truetype: Support newlines in the measured string
Date: Wed, 19 Mar 2025 15:54:11 +0100
Message-ID: <20250319145512.2391122-7-sjg@chromium.org>
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

It is useful to be able to embed newline characters in the string and
have the text measured into multiple lines. Add support for this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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

