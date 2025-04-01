Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DAE2C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 17:31:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45074820E3;
	Tue,  1 Apr 2025 19:30:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Kz9SEZXB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78B3082076; Tue,  1 Apr 2025 19:30:40 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BB4382040
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 19:30:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3014ae35534so8348278a91.0
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 10:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743528636; x=1744133436; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lvSMsPwwBMV2PJPQsiLmp2Bs6oMn+6QFuGgk0Zn3kNY=;
 b=Kz9SEZXB2KAEsj+L4+3hV2uXEe4H+rhhvLdLIYhxB4FHW/DVYSBZsib07Otka8Ir2h
 zBDygd4sUSseDeeFK54Y4chnru3I1tlJWd7o6LW5OyEkVEiiU9XhMhVIZ2cpde8GTRpt
 ffCuX6SE6Lr1YSQfLrslh2fMWZKnwsyGjHKbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743528636; x=1744133436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lvSMsPwwBMV2PJPQsiLmp2Bs6oMn+6QFuGgk0Zn3kNY=;
 b=V37Z8jf3n7GWDeGCp4o0d/s4WiS9/qc7wbl4SwT9f4/qK3tKepqpZ48s1QcdVas8bU
 X+KZuJxmIbLl6wrhv9XFn91pU45UkBLPO9Kz0R7dklW/ytrHMFRb6IImczkD8fw34g6t
 lsJQQhkqCMJHTSRCooRd1sbGEZwpXkod+rPHdP/NyYJ/mgPxhgDjBogsJydUWSvwsPQn
 q2xQZjxHvL2wSkX3/ArujrUqn6S6CiGigbMgrw6WWANJaUu/oAYpPUTSHTKL3R8To4aW
 mVEQ9cNrs4Rw3ruVLndPqUP7Aw8VBB6EMhgbIFUZjLQW60GGAn/GoITCbgZfhKc3fhkq
 oWsA==
X-Gm-Message-State: AOJu0YzDawT+T8IBKlxykmMe7hYLRas7pO6GwSmDBpdXhHxDAUaJY6OQ
 LbclOx972uKVALCc21OJ0emjFDjYgw0hWBK2Au2czqgVs2YZ0cLBklc1UnWzZt/6HSdWQrP+Roo
 c/w==
X-Gm-Gg: ASbGncvmDxXRw1YJ6s9Rb2gp5J32KN7LEdY66MKKZqFd2yqQGHLvfdj5Fbd6uppRpDX
 KcPqKI24qlYvRYW081YmEN3KmlSA2YNkr6QV1V3KnJonARW/FrzJGSvLPkB2wM5+wXp9l3U7/NS
 /scd3ybe9W6JekNeyjUULNTFV+r0Q2s9SJhWAnZ8La60fA5dyHjMvneQyO3b03XS7vEHQPQzSVk
 61iZR/kZwpGRZ9FuXvg3lMN2qGJM41Lj77aqmYADTNdzHKLFgqSARRWF74Y5U/vaM6Abvky9QUN
 Ab1OdZi8QBGcx/Dkp7FC6hT2E8x7fXo4Cj1sJEMEN+8=
X-Google-Smtp-Source: AGHT+IHBkrpnSTPPtUpwypwg99Bqumal+ZdASisQmq6DkOkDo8Fwj6XbcdWsx9wnh8EQtUHsLIANBw==
X-Received: by 2002:a17:90b:2650:b0:2fa:15ab:4df5 with SMTP id
 98e67ed59e1d1-3053216de3amr18282956a91.34.1743528635921; 
 Tue, 01 Apr 2025 10:30:35 -0700 (PDT)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3039dfd48e2sm11958976a91.9.2025.04.01.10.30.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 10:30:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Peter Robinson <pbrobinson@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 07/13] video: truetype: Support newlines in the measured string
Date: Wed,  2 Apr 2025 06:29:38 +1300
Message-ID: <20250401172948.1236000-8-sjg@chromium.org>
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

