Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AAE4C3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:48:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D40B482928;
	Fri,  2 May 2025 16:47:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Jnw9o4QH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F01C08297E; Fri,  2 May 2025 16:47:42 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BD1D828C2
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:47:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-864a071b44bso67739639f.3
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197259; x=1746802059; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h9VzytJ57saU6NBp0fFRV+cB2kogBEe0VLNNAfOaSsI=;
 b=Jnw9o4QHX0sFavzY83PFYjeNdXpTz2Q+LzFIB+CI/i9R0/+7dievUHJ2BqFeIo4wAX
 2wllJbRQwnpRhADiabesCHtQrV6wNv8DtF7vQvfgh/prnfH/Tm34zImdyXyxWNEabktc
 8DE/4DokFOEW2cXwxljQw8KgvRKrOl2EDB8mY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197259; x=1746802059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h9VzytJ57saU6NBp0fFRV+cB2kogBEe0VLNNAfOaSsI=;
 b=IqjoSWiEuBxnzjRnElYg+j77AO2S9429kKzC4HoP3yR/v78chBXm2Wj1z11VoY8GmG
 T22ro1geY9t3hKd0mzbl1+dLLeG/FXORKNjWJ+r6AtAsJcSnFdXxdIByq9+L5nAp7X1d
 J5lIM6rz/eO3KBnqx45EOjpTIJ/2nZFuu2wv6kxc+M5RXa8DhftWWMOiQl+10zBJR7PX
 K1ocglyLqvEOpGMBdX4cQz12X7WLDNWwuIM8SM1yGZDqG26GZFmI9VEcmNwjIUka/LpV
 qMDxD0wMvvGUlIeQIDJWaS3UkAk0xX9VQUD3/rOGeV3lFkn3/xJji7csnXt0PxgVxZaP
 5Plg==
X-Gm-Message-State: AOJu0YyCy0ZfuWA3GFcpBTLefExFCW1B87Vt3OQfGIJNNVMU5WIWpro7
 8l8eRmXSbRERTgzPJP0SqjmubBgNUJtOFcfO2jALKJ0HMY+2dpGcByQZ0VM7Bp7iFEYeQgGn2Ug
 =
X-Gm-Gg: ASbGncsN+71sPf5SXJy2pV9y7B2AOgzassrQBXMBt90er9Rx3DQLSvcXSPt3URJ8FqZ
 aLp0kMplQfT/13IbAiVNJTQxBEEytsgJlVjhLwGW2UZgMI3+XeXzUjeQVksZSL9EoQJ+dteT0r8
 V6Q/pDzp7Xo0slOf0xzHf6ydNzdwGVB9ZESqrO+J2WVsa6SVVv7Ip6sWZnzxPV6FQhYBtQUDc4N
 DZQgmhnxUdiqRUOg08XXTuKjcnjwxB7yl0t25ik2SUtxYID9FrqTEvAsWpOtk4Lbb7lo1GBKx1j
 U8ax3RqnARpK6fyvuLXRLZPl9L6a0M7jA3YDhNWVLfa1XWb4UUPbl4MV7eZXt/9pDoB+neKW/1l
 PbA==
X-Google-Smtp-Source: AGHT+IH/5F8hWOoaLCsUO07N01FOfz39xMUXWQA5fPrLySSl4T5NsCTrALq5ZgHoy9OhZaaZRBG04g==
X-Received: by 2002:a05:6602:3799:b0:864:48ec:c312 with SMTP id
 ca18e2360f4ac-8669f98092amr435946339f.3.1746197258809; 
 Fri, 02 May 2025 07:47:38 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.47.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:47:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Peter Robinson <pbrobinson@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 08/60] video: Begin support for measuring multiple lines of
 text
Date: Fri,  2 May 2025 08:46:06 -0600
Message-ID: <20250502144718.313633-9-sjg@chromium.org>
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

Update the vidconsole API so that measure() can measure multiple lines
of text. This will make it easier to implement multi-line fields in
expo.

Tidy up the function comments while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/scene.c                      |  2 +-
 drivers/video/console_truetype.c  |  3 +-
 drivers/video/vidconsole-uclass.c |  7 +++--
 include/video_console.h           | 50 +++++++++++++++++++++++--------
 test/dm/video.c                   |  5 +++-
 5 files changed, 49 insertions(+), 18 deletions(-)

diff --git a/boot/scene.c b/boot/scene.c
index 3af34369fe8..1311055aac3 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -297,7 +297,7 @@ int scene_obj_get_hw(struct scene *scn, uint id, int *widthp)
 		}
 
 		ret = vidconsole_measure(scn->expo->cons, txt->font_name,
-					 txt->font_size, str, &bbox);
+					 txt->font_size, str, &bbox, NULL);
 		if (ret)
 			return log_msg_ret("mea", ret);
 		if (widthp)
diff --git a/drivers/video/console_truetype.c b/drivers/video/console_truetype.c
index 980baee83cf..7b9033818d3 100644
--- a/drivers/video/console_truetype.c
+++ b/drivers/video/console_truetype.c
@@ -733,7 +733,8 @@ static int truetype_select_font(struct udevice *dev, const char *name,
 }
 
 static int truetype_measure(struct udevice *dev, const char *name, uint size,
-			    const char *text, struct vidconsole_bbox *bbox)
+			    const char *text, struct vidconsole_bbox *bbox,
+			    struct alist *lines)
 {
 	struct console_tt_metrics *met;
 	stbtt_fontinfo *font;
diff --git a/drivers/video/vidconsole-uclass.c b/drivers/video/vidconsole-uclass.c
index a1dfd35b7b8..4ca41dc331e 100644
--- a/drivers/video/vidconsole-uclass.c
+++ b/drivers/video/vidconsole-uclass.c
@@ -608,14 +608,17 @@ int vidconsole_select_font(struct udevice *dev, const char *name, uint size)
 }
 
 int vidconsole_measure(struct udevice *dev, const char *name, uint size,
-		       const char *text, struct vidconsole_bbox *bbox)
+		       const char *text, struct vidconsole_bbox *bbox,
+		       struct alist *lines)
 {
 	struct vidconsole_priv *priv = dev_get_uclass_priv(dev);
 	struct vidconsole_ops *ops = vidconsole_get_ops(dev);
 	int ret;
 
 	if (ops->measure) {
-		ret = ops->measure(dev, name, size, text, bbox);
+		if (lines)
+			alist_empty(lines);
+		ret = ops->measure(dev, name, size, text, bbox, lines);
 		if (ret != -ENOSYS)
 			return ret;
 	}
diff --git a/include/video_console.h b/include/video_console.h
index 13197fa4518..ee9ce3c0e37 100644
--- a/include/video_console.h
+++ b/include/video_console.h
@@ -6,6 +6,7 @@
 #ifndef __video_console_h
 #define __video_console_h
 
+#include <alist.h>
 #include <video.h>
 
 struct abuf;
@@ -119,6 +120,19 @@ struct vidconsole_bbox {
 	int y1;
 };
 
+/**
+ * vidconsole_mline - Holds information about a line of measured text
+ *
+ * @bbox: Bounding box of the line, assuming it starts at 0,0
+ * @start: String index of the first character in the line
+ * @len: Number of characters in the line
+ */
+struct vidconsole_mline {
+	struct vidconsole_bbox bbox;
+	int start;
+	int len;
+};
+
 /**
  * struct vidconsole_ops - Video console operations
  *
@@ -228,18 +242,23 @@ struct vidconsole_ops {
 	int (*select_font)(struct udevice *dev, const char *name, uint size);
 
 	/**
-	 * measure() - Measure the bounds of some text
+	 * measure() - Measure the bounding box of some text
 	 *
-	 * @dev:	Device to adjust
+	 * @dev:	Console device to use
 	 * @name:	Font name to use (NULL to use default)
 	 * @size:	Font size to use (0 to use default)
 	 * @text:	Text to measure
 	 * @bbox:	Returns bounding box of text, assuming it is positioned
 	 *		at 0,0
+	 * @lines:	If non-NULL, this must be an alist of
+	 *		struct vidconsole_mline inited by caller. A separate
+	 *		record is added for each line of text
+	 *
 	 * Returns: 0 on success, -ENOENT if no such font
 	 */
 	int (*measure)(struct udevice *dev, const char *name, uint size,
-		       const char *text, struct vidconsole_bbox *bbox);
+		       const char *text, struct vidconsole_bbox *bbox,
+		       struct alist *lines);
 
 	/**
 	 * nominal() - Measure the expected width of a line of text
@@ -320,19 +339,24 @@ int vidconsole_get_font(struct udevice *dev, int seq,
  */
 int vidconsole_select_font(struct udevice *dev, const char *name, uint size);
 
-/*
- * vidconsole_measure() - Measuring the bounding box of some text
+/**
+ * vidconsole_measure() - Measure the bounding box of some text
  *
- * @dev: Console device to use
- * @name: Font name, NULL for default
- * @size: Font size, ignored if @name is NULL
- * @text: Text to measure
- * @bbox: Returns nounding box of text
- * Returns: 0 if OK, -ve on error
+ * @dev:	Device to adjust
+ * @name:	Font name to use (NULL to use default)
+ * @size:	Font size to use (0 to use default)
+ * @text:	Text to measure
+ * @bbox:	Returns bounding box of text, assuming it is positioned
+ *		at 0,0
+ * @lines:	If non-NULL, this must be an alist of
+ *		struct vidconsole_mline inited by caller. The list is emptied
+ *		and then a separate record is added for each line of text
+ *
+ * Returns: 0 on success, -ENOENT if no such font
  */
 int vidconsole_measure(struct udevice *dev, const char *name, uint size,
-		       const char *text, struct vidconsole_bbox *bbox);
-
+		       const char *text, struct vidconsole_bbox *bbox,
+		       struct alist *lines);
 /**
  * vidconsole_nominal() - Measure the expected width of a line of text
  *
diff --git a/test/dm/video.c b/test/dm/video.c
index 6ce1a756e25..cfc831b6931 100644
--- a/test/dm/video.c
+++ b/test/dm/video.c
@@ -788,6 +788,7 @@ static int dm_test_font_measure(struct unit_test_state *uts)
 	struct vidconsole_bbox bbox;
 	struct video_priv *priv;
 	struct udevice *dev, *con;
+	struct alist lines;
 
 	ut_assertok(uclass_get_device(UCLASS_VIDEO, 0, &dev));
 	priv = dev_get_uclass_priv(dev);
@@ -797,11 +798,13 @@ static int dm_test_font_measure(struct unit_test_state *uts)
 	/* this is using the Nimbus font with size of 18 pixels */
 	ut_assertok(uclass_get_device(UCLASS_VIDEO_CONSOLE, 0, &con));
 	vidconsole_position_cursor(con, 0, 0);
-	ut_assertok(vidconsole_measure(con, NULL, 0, test_string, &bbox));
+	ut_assertok(vidconsole_measure(con, NULL, 0, test_string, &bbox,
+				       &lines));
 	ut_asserteq(0, bbox.x0);
 	ut_asserteq(0, bbox.y0);
 	ut_asserteq(0x47a, bbox.x1);
 	ut_asserteq(0x12, bbox.y1);
+	ut_asserteq(0, lines.count);
 
 	return 0;
 }
-- 
2.43.0

