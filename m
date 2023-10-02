Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3684E784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:24:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AABD387173;
	Mon,  2 Oct 2023 03:15:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gDW/KllJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0A8C87107; Mon,  2 Oct 2023 03:14:23 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82F1E87109
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:14:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-79f915e5b47so569120339f.2
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209246; x=1696814046; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=px9+RU9h351PB3PF1do8ism248NIwzuis7dv5lQQrI4=;
 b=gDW/KllJVofn6IjWdehEq2fWWMusGT4R9q+l5ZD+gp76HiK2DONg4uaLh1xZV+cJTB
 sZzXBCbX2GUw2Iq+DG4NqWP5/IJ+ZH+Zl7MNSQ+vfIGQIM+ZaT2hK/hBlC9XXhKVw7R8
 Ynyfp2qt2YrR9mNiGEd9x2JQtDg7DqqM28j4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209246; x=1696814046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=px9+RU9h351PB3PF1do8ism248NIwzuis7dv5lQQrI4=;
 b=Na4Arm7sCo1lsaRJ8muqp6iKdPEClnacBP711JwcdZ16FPLuTv9KBhmCWVl8GXLGjQ
 /UNdHRuFb30wKKa0Yu4hc7txWq8Z43jT8b6zZSBON6YFCoKrPC9ov5UKOLaHtLcgj3i3
 KyyJ8eKl3bNEvL/y7AVyhIjQLJv6KLYhQUCgxQbRKzrUu7KV96M6mY58fEHGHOjWGk02
 bcnhgsXdnQMrdrG0ivKMjCFrAA1QQK+Y0ZEWCW3nPPQpkMUuj5XPlFvxJBp7oZUTIeN1
 z73tIeOhtkVPSNzqAcIStWd2vcHL2pILj15h/0vJAzKXLjteMGHK7APOydD37KSKyeKu
 6yVw==
X-Gm-Message-State: AOJu0Yy+3p+VjeXNJFomocDA91XB23ZKyOiqlPWlb3wntQ9Kgn/UxAVV
 faLf9G2GhZ93VAsTYLOmKxrEGgQdfv5WwHKNcH8=
X-Google-Smtp-Source: AGHT+IE3lcIugJnzODIT1fLyEYR9bQ6TkQzN+ZWkH90ubAiuZFQHsoV9TZtoW80WsRW32iFAqN9ylA==
X-Received: by 2002:a6b:3b4d:0:b0:7a2:9fd3:5684 with SMTP id
 i74-20020a6b3b4d000000b007a29fd35684mr2398791ioa.18.1696209245952; 
 Sun, 01 Oct 2023 18:14:05 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 bq6-20020a056638468600b0042aec33bc26sm3571046jab.18.2023.10.01.18.14.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:14:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v2 15/36] video: Allow saving and restoring text-entry state
Date: Sun,  1 Oct 2023 19:13:19 -0600
Message-ID: <20231002011349.461284-16-sjg@chromium.org>
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

Text entry operates within a context which includes quite a bit of
information. For example, with Truetype fonts, each character in the
text string has a position stored, so that it is possible to
backspace to that character. This information is built up as strings
are drawn on the display.

For the command line, there is just a single context. It is created
when command-line entry starts and it is destroyed (or at least not
needed anymore) when the user presses <enter> to enter the command.

By contrast, expo needs to be able to switch in and out of a text-entry
context, since it is also displaying other objects in the scene.

Add a way to save and restore the entry context for a vidconsole. This
is only needed for the truetype vidconsole, so add a method for that,
storing the information in an abuf struct.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/video/console_truetype.c  | 53 +++++++++++++++++++++++++++++++
 drivers/video/vidconsole-uclass.c | 32 +++++++++++++++++++
 include/video_console.h           | 49 ++++++++++++++++++++++++++++
 3 files changed, 134 insertions(+)

diff --git a/drivers/video/console_truetype.c b/drivers/video/console_truetype.c
index 8ed79c37676c..1ce01a96bb6c 100644
--- a/drivers/video/console_truetype.c
+++ b/drivers/video/console_truetype.c
@@ -4,6 +4,7 @@
  */
 
 #include <common.h>
+#include <abuf.h>
 #include <dm.h>
 #include <log.h>
 #include <malloc.h>
@@ -175,6 +176,17 @@ struct console_tt_priv {
 	int pos_ptr;
 };
 
+/**
+ * struct console_tt_store - Format used for save/restore of entry information
+ *
+ * @priv: Private data
+ * @cur: Current cursor position
+ */
+struct console_tt_store {
+	struct console_tt_priv priv;
+	struct pos_info cur;
+};
+
 static int console_truetype_set_row(struct udevice *dev, uint row, int clr)
 {
 	struct video_priv *vid_priv = dev_get_uclass_priv(dev->parent);
@@ -780,6 +792,45 @@ static int truetype_nominal(struct udevice *dev, const char *name, uint size,
 	return 0;
 }
 
+static int truetype_entry_save(struct udevice *dev, struct abuf *buf)
+{
+	struct vidconsole_priv *vc_priv = dev_get_uclass_priv(dev);
+	struct console_tt_priv *priv = dev_get_priv(dev);
+	struct console_tt_store store;
+	const uint size = sizeof(store);
+
+	/*
+	 * store the whole priv structure as it is simpler that picking out
+	 * what we need
+	 */
+	if (!abuf_realloc(buf, size))
+		return log_msg_ret("sav", -ENOMEM);
+
+	store.priv = *priv;
+	store.cur.xpos_frac = vc_priv->xcur_frac;
+	store.cur.ypos  = vc_priv->ycur;
+	memcpy(abuf_data(buf), &store, size);
+
+	return 0;
+}
+
+static int truetype_entry_restore(struct udevice *dev, struct abuf *buf)
+{
+	struct vidconsole_priv *vc_priv = dev_get_uclass_priv(dev);
+	struct console_tt_priv *priv = dev_get_priv(dev);
+	struct console_tt_store store;
+
+	memcpy(&store, abuf_data(buf), sizeof(store));
+
+	vc_priv->xcur_frac = store.cur.xpos_frac;
+	vc_priv->ycur = store.cur.ypos;
+	priv->pos_ptr = store.priv.pos_ptr;
+	memcpy(priv->pos, store.priv.pos,
+	       store.priv.pos_ptr * sizeof(struct pos_info));
+
+	return 0;
+}
+
 const char *console_truetype_get_font_size(struct udevice *dev, uint *sizep)
 {
 	struct console_tt_priv *priv = dev_get_priv(dev);
@@ -833,6 +884,8 @@ struct vidconsole_ops console_truetype_ops = {
 	.select_font	= truetype_select_font,
 	.measure	= truetype_measure,
 	.nominal	= truetype_nominal,
+	.entry_save	= truetype_entry_save,
+	.entry_restore	= truetype_entry_restore,
 };
 
 U_BOOT_DRIVER(vidconsole_truetype) = {
diff --git a/drivers/video/vidconsole-uclass.c b/drivers/video/vidconsole-uclass.c
index 23b1b81731bc..07427ba346b0 100644
--- a/drivers/video/vidconsole-uclass.c
+++ b/drivers/video/vidconsole-uclass.c
@@ -10,6 +10,7 @@
 #define LOG_CATEGORY UCLASS_VIDEO_CONSOLE
 
 #include <common.h>
+#include <abuf.h>
 #include <command.h>
 #include <console.h>
 #include <log.h>
@@ -640,6 +641,37 @@ int vidconsole_nominal(struct udevice *dev, const char *name, uint size,
 	return 0;
 }
 
+int vidconsole_entry_save(struct udevice *dev, struct abuf *buf)
+{
+	struct vidconsole_ops *ops = vidconsole_get_ops(dev);
+	int ret;
+
+	if (ops->measure) {
+		ret = ops->entry_save(dev, buf);
+		if (ret != -ENOSYS)
+			return ret;
+	}
+
+	/* no data so make sure the buffer is empty */
+	abuf_realloc(buf, 0);
+
+	return 0;
+}
+
+int vidconsole_entry_restore(struct udevice *dev, struct abuf *buf)
+{
+	struct vidconsole_ops *ops = vidconsole_get_ops(dev);
+	int ret;
+
+	if (ops->measure) {
+		ret = ops->entry_restore(dev, buf);
+		if (ret != -ENOSYS)
+			return ret;
+	}
+
+	return 0;
+}
+
 void vidconsole_push_colour(struct udevice *dev, enum colour_idx fg,
 			    enum colour_idx bg, struct vidconsole_colour *old)
 {
diff --git a/include/video_console.h b/include/video_console.h
index 5234c85efd6f..28d65451889a 100644
--- a/include/video_console.h
+++ b/include/video_console.h
@@ -8,6 +8,7 @@
 
 #include <video.h>
 
+struct abuf;
 struct video_priv;
 
 #define VID_FRAC_DIV	256
@@ -239,6 +240,30 @@ struct vidconsole_ops {
 	 */
 	int (*nominal)(struct udevice *dev, const char *name, uint size,
 		       uint num_chars, struct vidconsole_bbox *bbox);
+
+	/**
+	 * entry_save() - Save any text-entry information for later use
+	 *
+	 * Saves text-entry context such as a list of positions for each
+	 * character in the string.
+	 *
+	 * @dev: Console device to use
+	 * @buf: Buffer to hold saved data
+	 * Return: 0 if OK, -ENOMEM if out of memory
+	 */
+	int (*entry_save)(struct udevice *dev, struct abuf *buf);
+
+	/**
+	 * entry_restore() - Restore text-entry information for current use
+	 *
+	 * Restores text-entry context such as a list of positions for each
+	 * character in the string.
+	 *
+	 * @dev: Console device to use
+	 * @buf: Buffer containing data to restore
+	 * Return: 0 if OK, -ve on error
+	 */
+	int (*entry_restore)(struct udevice *dev, struct abuf *buf);
 };
 
 /* Get a pointer to the driver operations for a video console device */
@@ -293,6 +318,30 @@ int vidconsole_measure(struct udevice *dev, const char *name, uint size,
 int vidconsole_nominal(struct udevice *dev, const char *name, uint size,
 		       uint num_chars, struct vidconsole_bbox *bbox);
 
+/**
+ * vidconsole_entry_save() - Save any text-entry information for later use
+ *
+ * Saves text-entry context such as a list of positions for each
+ * character in the string.
+ *
+ * @dev: Console device to use
+ * @buf: Buffer to hold saved data
+ * Return: 0 if OK, -ENOMEM if out of memory
+ */
+int vidconsole_entry_save(struct udevice *dev, struct abuf *buf);
+
+/**
+ * entry_restore() - Restore text-entry information for current use
+ *
+ * Restores text-entry context such as a list of positions for each
+ * character in the string.
+ *
+ * @dev: Console device to use
+ * @buf: Buffer containing data to restore
+ * Return: 0 if OK, -ve on error
+ */
+int vidconsole_entry_restore(struct udevice *dev, struct abuf *buf);
+
 /**
  * vidconsole_push_colour() - Temporarily change the font colour
  *
-- 
2.42.0.582.g8ccd20d70d-goog

