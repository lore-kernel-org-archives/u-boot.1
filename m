Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C59FCE79A9
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 18:11:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C86E86BFE;
	Tue, 19 Sep 2023 20:09:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fS2mtcHb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F4C486BE8; Tue, 19 Sep 2023 20:09:42 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 356F086B7E
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:09:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-34fcd361e91so11385095ab.3
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 11:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695146979; x=1695751779; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UumrJGXMFjWrtv3H/syYMi8hGSXjg5929Scm3TOZl/k=;
 b=fS2mtcHbWZ9g1izX+3tNUnIMN4BJaIvkD8HCA84koKOIW/PU6hutCg/P4+vswQGrsk
 U50NDhOGYwZ+AXvQxfD5OZKGjhcORHzTDC6k23Khk2jQEnEs7CYIjiJ8ozqnJYOH1dFg
 7QrEOLO/0ujB4V/Rs3hv8V9tInFnaFY3MT5dI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695146979; x=1695751779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UumrJGXMFjWrtv3H/syYMi8hGSXjg5929Scm3TOZl/k=;
 b=aSfWgQ9hgrmem4nxHEYQEQPXvPDZe29Qkf2QAaJo9hqWej/I5dsBMPn4QXwsHlDTz0
 zDpCe1tNcraVYTmk8V7LZ0AkGlY1AZ+jLA+Jl5uIBYtNYq+DHkO4DyJGbHpPd6Jad+sP
 H7/2q+SnuQn88uyIe6BCBkwShGuvTtqA7hJkVQwRT/D/DKwzv9/UB+i2B88lC3zORk2Y
 9hcjjGrUt2hgwO32F5JzkLTIPi4pWxINCQMHLO2GYq9ftW3gYH0kc89dmjUYJHQt1Lo4
 qcjTHIGcMJHL6xwe18hQPHKt9cIyzxrDFAHOFfcjdCHVVAkTkfW5y1MBxEkcOq3bf/7b
 B58w==
X-Gm-Message-State: AOJu0YxmpDLynef/ytSd9DDu8IQl7Vs0x7g6eN73AB+X8FyYTeaa3pqg
 pQrY83FOzfLHrF0FM/1gCDkfXgm7CuR04qHWgL4=
X-Google-Smtp-Source: AGHT+IG4oWJPpDAJ4IEbFDChaGh/E32iyP1MZz94fq/2ijOzmKcu7OxoECbhA9MLWH1f4DcyZ+g9aQ==
X-Received: by 2002:a92:cda5:0:b0:348:d325:2788 with SMTP id
 g5-20020a92cda5000000b00348d3252788mr644918ild.32.1695146978870; 
 Tue, 19 Sep 2023 11:09:38 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:5337:a30a:1478:27f0])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a056e020c8900b0034e1092bccfsm3885352ile.80.2023.09.19.11.09.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 11:09:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>
Subject: [PATCH 14/36] video: Allow obtaining the nominal size of a string size
Date: Tue, 19 Sep 2023 12:08:44 -0600
Message-ID: <20230919180918.2904313-15-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230919180918.2904313-1-sjg@chromium.org>
References: <20230919180918.2904313-1-sjg@chromium.org>
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

At present there is a method for measuring text, but if the actual text
string is not known, it cannot be used.

For text editor we want to set the size of the entry box to cover the
expected text size. Add the concept of a 'norminal' size with a method
to calculate that for the vidconsole.

If the method is not implemented, fall back to using the font size,
which is sufficient for fixed-width fonts.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/video/console_truetype.c  | 31 +++++++++++++++++++++++++++++++
 drivers/video/vidconsole-uclass.c | 22 ++++++++++++++++++++++
 include/video_console.h           | 30 ++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+)

diff --git a/drivers/video/console_truetype.c b/drivers/video/console_truetype.c
index 0f9bb49e44f..8ed79c37676 100644
--- a/drivers/video/console_truetype.c
+++ b/drivers/video/console_truetype.c
@@ -750,6 +750,36 @@ int truetype_measure(struct udevice *dev, const char *name, uint size,
 	return 0;
 }
 
+static int truetype_nominal(struct udevice *dev, const char *name, uint size,
+			    uint num_chars, struct vidconsole_bbox *bbox)
+{
+	struct console_tt_metrics *met;
+	stbtt_fontinfo *font;
+	int lsb, advance;
+	int width;
+	int ret;
+
+	ret = get_metrics(dev, name, size, &met);
+	if (ret)
+		return log_msg_ret("sel", ret);
+
+	font = &met->font;
+	width = 0;
+
+	/* First get some basic metrics about this character */
+	stbtt_GetCodepointHMetrics(font, 'W', &advance, &lsb);
+
+	width = advance;
+
+	bbox->valid = true;
+	bbox->x0 = 0;
+	bbox->y0 = 0;
+	bbox->x1 = tt_ceil((double)width * num_chars * met->scale);
+	bbox->y1 = met->font_size;
+
+	return 0;
+}
+
 const char *console_truetype_get_font_size(struct udevice *dev, uint *sizep)
 {
 	struct console_tt_priv *priv = dev_get_priv(dev);
@@ -802,6 +832,7 @@ struct vidconsole_ops console_truetype_ops = {
 	.get_font_size	= console_truetype_get_font_size,
 	.select_font	= truetype_select_font,
 	.measure	= truetype_measure,
+	.nominal	= truetype_nominal,
 };
 
 U_BOOT_DRIVER(vidconsole_truetype) = {
diff --git a/drivers/video/vidconsole-uclass.c b/drivers/video/vidconsole-uclass.c
index b5b3b662590..23b1b81731b 100644
--- a/drivers/video/vidconsole-uclass.c
+++ b/drivers/video/vidconsole-uclass.c
@@ -618,6 +618,28 @@ int vidconsole_measure(struct udevice *dev, const char *name, uint size,
 	return 0;
 }
 
+int vidconsole_nominal(struct udevice *dev, const char *name, uint size,
+		       uint num_chars, struct vidconsole_bbox *bbox)
+{
+	struct vidconsole_priv *priv = dev_get_uclass_priv(dev);
+	struct vidconsole_ops *ops = vidconsole_get_ops(dev);
+	int ret;
+
+	if (ops->measure) {
+		ret = ops->nominal(dev, name, size, num_chars, bbox);
+		if (ret != -ENOSYS)
+			return ret;
+	}
+
+	bbox->valid = true;
+	bbox->x0 = 0;
+	bbox->y0 = 0;
+	bbox->x1 = priv->x_charsize * num_chars;
+	bbox->y1 = priv->y_charsize;
+
+	return 0;
+}
+
 void vidconsole_push_colour(struct udevice *dev, enum colour_idx fg,
 			    enum colour_idx bg, struct vidconsole_colour *old)
 {
diff --git a/include/video_console.h b/include/video_console.h
index 2694e44f6ec..5234c85efd6 100644
--- a/include/video_console.h
+++ b/include/video_console.h
@@ -224,6 +224,21 @@ struct vidconsole_ops {
 	 */
 	int (*measure)(struct udevice *dev, const char *name, uint size,
 		       const char *text, struct vidconsole_bbox *bbox);
+
+	/**
+	 * nominal() - Measure the expected width of a line of text
+	 *
+	 * Uses an average font width and nominal height
+	 *
+	 * @dev: Console device to use
+	 * @name: Font name, NULL for default
+	 * @size: Font size, ignored if @name is NULL
+	 * @num_chars: Number of characters to use
+	 * @bbox: Returns nounding box of @num_chars characters
+	 * Returns: 0 if OK, -ve on error
+	 */
+	int (*nominal)(struct udevice *dev, const char *name, uint size,
+		       uint num_chars, struct vidconsole_bbox *bbox);
 };
 
 /* Get a pointer to the driver operations for a video console device */
@@ -263,6 +278,21 @@ int vidconsole_select_font(struct udevice *dev, const char *name, uint size);
 int vidconsole_measure(struct udevice *dev, const char *name, uint size,
 		       const char *text, struct vidconsole_bbox *bbox);
 
+/**
+ * vidconsole_nominal() - Measure the expected width of a line of text
+ *
+ * Uses an average font width and nominal height
+ *
+ * @dev: Console device to use
+ * @name: Font name, NULL for default
+ * @size: Font size, ignored if @name is NULL
+ * @num_chars: Number of characters to use
+ * @bbox: Returns nounding box of @num_chars characters
+ * Returns: 0 if OK, -ve on error
+ */
+int vidconsole_nominal(struct udevice *dev, const char *name, uint size,
+		       uint num_chars, struct vidconsole_bbox *bbox);
+
 /**
  * vidconsole_push_colour() - Temporarily change the font colour
  *
-- 
2.42.0.459.ge4e396fd5e-goog

