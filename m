Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBAA3C3600C
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:08:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D05D181F6B;
	Fri, 28 Mar 2025 14:07:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WB9VWgew";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1338C81F69; Fri, 28 Mar 2025 14:07:42 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AB0481E5A
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:07:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-223a7065ff8so2057945ad.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167257; x=1743772057; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=08pwY9XqGgfFvaKNwxBuV5Z2raZTvhQzKregn5vt344=;
 b=WB9VWgewEefhMOYLUFl55kYzsjnwJk4bA6wro3xlSbR3vlSo8apPqzKDt+xZwI5vsG
 nJk9QehhM+UZF/6Ygr1/iIqlXymz0xyR9b2r9zzUQTK2ZO938LA7S87tlIRCb6tuCSiy
 wNNvHNgj72gOkOS3CKETT7suogyYCiqwVeC6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167257; x=1743772057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=08pwY9XqGgfFvaKNwxBuV5Z2raZTvhQzKregn5vt344=;
 b=tuuDTEXtN4kSdQh4zJ+oXeM3Wovhjyrpn0Z6LE4XYd1pmi1bZnsXJej9FV9dqzCrj3
 bcxhnxDpco4ENLIeB81PwRw6Ehyk1MieS70uQLQWXOf7QR4w0avgeuvei5/bGhDVIQ2t
 Zm44Xm5mXXjQI8wxpiCjdUrFluUx2VsPlTLfRjVnXzjBu7dyc29ZRcJ1+kWgut3C/edF
 8eKknz3LjXW6rxMWmqcx7VrCmufqWTe9JT+az3C2HEVIrbExS7gvEZq0gA+u3bzuW1PP
 CpVK0njUTKWZpODj937+OCQQu4HREUKIlTpf+Y9BQEWEjdftuE6NUC2nGCc3NeSZleNQ
 xJ8A==
X-Gm-Message-State: AOJu0YwWnuGe8C8fP6FGoVShGw5jkfrioJ0XhAxVoEfcN5+Z9rAzUFFP
 ZcmRyhVuELpn3P02I4jpofJgWYNhO7wgiq3BUt1fjQ1xB4xOzXRyaQaSW6Tq4qejvn6h2qb935A
 =
X-Gm-Gg: ASbGnctPrc9QQyJnOcgLPcbFu4aFl0nxmXPH8Rrtj7faE4Wrby/EdLkG11ZWzXoqzqO
 lq5jyXPf88kluI06Udqq0d///qM9JS/fMqGYteSoVbk2sswUKnNYbt20BV2pKI1YBKyMdDfBsXa
 noJ2UwmJLKI0DJ2KLu9n9GMdFhluP4DH780N+h4N+f9KDst9EPV4G0lqqE3HqmZbL7WC8sYskIj
 5Wg+uaxxwHDnZy+uaHaOXpNqCrAfifDaKmXiFhn3NkPgFTW/e0pl1+OsbDFhLtSeyVqrfWuVE/G
 5Dbq1nrpVeEmeL1KnJ1k0FdWt2ZqfgazFwwsUv13fknjj0J0l9j3uP6enBeQz53J/H2LFU72ElW
 0Y7gxzw==
X-Google-Smtp-Source: AGHT+IEVw6euEPSLmxg41TEM+roeBL+XbR443B12cP8Opt8d9H8j0g5xLDJvGxFlkeP9YXR86p1erg==
X-Received: by 2002:a05:6602:400f:b0:85b:3827:ed06 with SMTP id
 ca18e2360f4ac-85e8208fa86mr1087147039f.4.1743167247055; 
 Fri, 28 Mar 2025 06:07:27 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.07.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:07:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Peter Robinson <pbrobinson@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 04/56] video: Begin support for measuring multiple lines of
 text
Date: Fri, 28 Mar 2025 07:05:51 -0600
Message-ID: <20250328130713.2612648-5-sjg@chromium.org>
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
index 15e7a8b3387..d3ae5816bef 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -298,7 +298,7 @@ int scene_obj_get_hw(struct scene *scn, uint id, int *widthp)
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

