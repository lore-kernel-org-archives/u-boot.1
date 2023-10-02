Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B5D4E784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:24:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71BFF8716C;
	Mon,  2 Oct 2023 03:15:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IYvvcDVY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E64B86D7C; Mon,  2 Oct 2023 03:14:17 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60B87870EC
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:14:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-35255c1a448so13499965ab.3
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209245; x=1696814045; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XVSdwn+6p01yq6KTrn82FyZczhGxyFfV3PUsIFiTs7E=;
 b=IYvvcDVYXvS42IpDDb83e+2um7vu+h7rHPlZtl+BVgHNSsRfPyYrvyoKu7HGVlZDa4
 CCt2uTUH3BKvX1rp0J0CsMz07J3H5x2D8DlkAZpYkQH/d1LFQMER6+hSnJi/MBd8DxEf
 muRIveEsQYEEvirHkD9C4Q4lyt+NvUg6KxXrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209245; x=1696814045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XVSdwn+6p01yq6KTrn82FyZczhGxyFfV3PUsIFiTs7E=;
 b=QEwJE5QX0DXk4GGGdG8jgyYWm6h9ygIQKVRPQ7+87SNT/1ETxhbYvY3bu7wOKbKFfl
 jtNnBvk4ZndkDuXrZLmkExzwQz95cZckode1BvUQFX/9/pnATntEJqkQvSMXyKg2rnLO
 zSChFjddGO0jmR6HIcEn/BgmEoWbp3qeHjIBYgyTds6p2vnBxxyb1KJ/hdofp8VAEqsc
 rZgZ3qJFBLLgIk/JgxaAsFCGPiYx+Fbsy4mEA9xOGB/IJAOLqq80wSgzaIdLxFyHPqHJ
 yEmxrUW4syQlB8jZI2APBxzMGtTv6k9M9EGMD7zVloMd91bTSPMiS64OjGaRqa6TFF+F
 flog==
X-Gm-Message-State: AOJu0YweewmhHQKMYye/B2GYo0GNEU1oq/aAFLQJUvMJAQUii/hNKNaE
 WZ2okdo/i+oyE9NonPe+WVFBMhyw8JlMBMFXGwA=
X-Google-Smtp-Source: AGHT+IFiDoEykPN6N6Xha8kuoiVlmcSN6JYE7gkY4YeLsvB3C9gPwAqm119x856itn+NBnieBV1BYw==
X-Received: by 2002:a92:c56b:0:b0:351:2104:64f6 with SMTP id
 b11-20020a92c56b000000b00351210464f6mr13013373ilj.1.1696209244947; 
 Sun, 01 Oct 2023 18:14:04 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 bq6-20020a056638468600b0042aec33bc26sm3571046jab.18.2023.10.01.18.14.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:14:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v2 14/36] video: Allow obtaining the nominal size of a string
 size
Date: Sun,  1 Oct 2023 19:13:18 -0600
Message-ID: <20231002011349.461284-15-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011349.461284-1-sjg@chromium.org>
References: <20231002011349.461284-1-sjg@chromium.org>
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

(no changes since v1)

 drivers/video/console_truetype.c  | 31 +++++++++++++++++++++++++++++++
 drivers/video/vidconsole-uclass.c | 22 ++++++++++++++++++++++
 include/video_console.h           | 30 ++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+)

diff --git a/drivers/video/console_truetype.c b/drivers/video/console_truetype.c
index 0f9bb49e44f7..8ed79c37676c 100644
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
index b5b3b6625902..23b1b81731bc 100644
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
index 2694e44f6ecf..5234c85efd6f 100644
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
2.42.0.582.g8ccd20d70d-goog

