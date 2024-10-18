Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A72D3C544
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 03:01:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C287891A8;
	Fri, 18 Oct 2024 05:00:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U6KnWoC3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A09FC8916D; Fri, 18 Oct 2024 05:00:51 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4E8989175
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 05:00:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3a3b7442db5so6003005ab.2
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 20:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729220447; x=1729825247; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y8V2duqfG5+iwBCzjCddmVmJ7hXFtR2VfxvqvJKTYJI=;
 b=U6KnWoC3+dKJAWnS7WWvT/bPkEZqNnwARANniABl0jQXXS1mi7HGkcc5ZB62pXEQfO
 9JJv2/ZHn/GyUXLPIAm2/e0sVUg/SR83tF9n1BftTMsab43g7/NQAxEHGpyljbtDuQEg
 fqOpCCzDsdUQbhYXud4ymshE3UHxOePHB1QSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729220447; x=1729825247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y8V2duqfG5+iwBCzjCddmVmJ7hXFtR2VfxvqvJKTYJI=;
 b=jt8vhneBzna9sf32GCTL8x+jdzCkHtFlvWPs+jusbv6IJrJsBH0z06Zbpt2SfVzkEP
 2lrQhbhXLm1SWMNYcnJT1K2nGECGMYQKNy2Bw7dAZCiNXgT73Ff3NjP3yccnhI147ohh
 ksaPvsB/tLkJn/9FCqnKzGktINY1Hy5+V4t8FMyp0e5G9yiTh9IzdJD5gLYSWO5ET9vk
 ZV5vUnuVxeKA+Pn2ocMOlX3RfkJB64MrvFJIf3U9UqrrXMSjQG/FHN76269AA9ZJ2mYg
 fztUdAxz7n0MG7B50MZtaujUS+C6IdHAE1H6PutViW9C+okitky8HCui5mXfZ070ERL8
 1F3Q==
X-Gm-Message-State: AOJu0Yw6svQ+53KJJoSVNOEG7EJIjtpXs/rQwcQAVJZnLJaGHBIG/Bv/
 JWdb6dxCMwAXhMdKEVRZ2t3CA3Uw+sqPABHAJA2PT9DiqIVQI/u76xII9CxhvXeyMHK6tPynHP8
 =
X-Google-Smtp-Source: AGHT+IEg2bB9n0qUg7DIv20kdf8o/vDd//GrHHrHHga/FJNojYAeIVkMYL4ZJfStAWqhI5npssUedw==
X-Received: by 2002:a05:6e02:1e07:b0:3a0:aa6c:8a51 with SMTP id
 e9e14a558f8ab-3a3f405f9a6mr7157985ab.8.1729220447292; 
 Thu, 17 Oct 2024 20:00:47 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b83e6dsm192499173.39.2024.10.17.20.00.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 20:00:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Ion Agorria <ion@agorria.com>, Marek Vasut <marex@denx.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/8] membuff: Rename functions to have membuf_ prefix
Date: Thu, 17 Oct 2024 21:00:20 -0600
Message-Id: <20241018030027.842749-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018030027.842749-1-sjg@chromium.org>
References: <20241018030027.842749-1-sjg@chromium.org>
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

The double 'f' is not necessary and is a bit annoying as elsewhere in
U-Boot we use 'buf'. Rename all the functions before it is used more
widely.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootmeth_extlinux.c        |  6 +--
 common/console.c                | 32 ++++++-------
 drivers/serial/sandbox.c        | 10 ++--
 drivers/usb/emul/sandbox_keyb.c |  6 +--
 include/membuff.h               | 82 ++++++++++++++++-----------------
 lib/membuff.c                   | 66 +++++++++++++-------------
 6 files changed, 101 insertions(+), 101 deletions(-)

diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
index be8fbf4df63..35854c1e188 100644
--- a/boot/bootmeth_extlinux.c
+++ b/boot/bootmeth_extlinux.c
@@ -112,9 +112,9 @@ static int extlinux_fill_info(struct bootflow *bflow)
 	int len;
 
 	log_debug("parsing bflow file size %x\n", bflow->size);
-	membuff_init(&mb, bflow->buf, bflow->size);
-	membuff_putraw(&mb, bflow->size, true, &data);
-	while (len = membuff_readline(&mb, line, sizeof(line) - 1, ' ', true), len) {
+	membuf_init(&mb, bflow->buf, bflow->size);
+	membuf_putraw(&mb, bflow->size, true, &data);
+	while (len = membuf_readline(&mb, line, sizeof(line) - 1, ' ', true), len) {
 		char *tok, *p = line;
 
 		tok = strsep(&p, " ");
diff --git a/common/console.c b/common/console.c
index 22224701e45..fa4017a188a 100644
--- a/common/console.c
+++ b/common/console.c
@@ -101,7 +101,7 @@ static void console_record_putc(const char c)
 	if (!(gd->flags & GD_FLG_RECORD))
 		return;
 	if  (gd->console_out.start &&
-	     !membuff_putbyte((struct membuff *)&gd->console_out, c))
+	     !membuf_putbyte((struct membuff *)&gd->console_out, c))
 		gd->flags |= GD_FLG_RECORD_OVF;
 }
 
@@ -112,7 +112,7 @@ static void console_record_puts(const char *s)
 	if  (gd->console_out.start) {
 		int len = strlen(s);
 
-		if (membuff_put((struct membuff *)&gd->console_out, s, len) !=
+		if (membuf_put((struct membuff *)&gd->console_out, s, len) !=
 		    len)
 			gd->flags |= GD_FLG_RECORD_OVF;
 	}
@@ -125,7 +125,7 @@ static int console_record_getc(void)
 	if (!gd->console_in.start)
 		return -1;
 
-	return membuff_getbyte((struct membuff *)&gd->console_in);
+	return membuf_getbyte((struct membuff *)&gd->console_in);
 }
 
 static int console_record_tstc(void)
@@ -133,7 +133,7 @@ static int console_record_tstc(void)
 	if (!(gd->flags & GD_FLG_RECORD))
 		return 0;
 	if (gd->console_in.start) {
-		if (membuff_peekbyte((struct membuff *)&gd->console_in) != -1)
+		if (membuf_peekbyte((struct membuff *)&gd->console_in) != -1)
 			return 1;
 	}
 	return 0;
@@ -814,14 +814,14 @@ int console_record_init(void)
 {
 	int ret;
 
-	ret = membuff_new((struct membuff *)&gd->console_out,
-			  gd->flags & GD_FLG_RELOC ?
-				  CONFIG_CONSOLE_RECORD_OUT_SIZE :
-				  CONFIG_CONSOLE_RECORD_OUT_SIZE_F);
+	ret = membuf_new((struct membuff *)&gd->console_out,
+			 gd->flags & GD_FLG_RELOC ?
+				CONFIG_CONSOLE_RECORD_OUT_SIZE :
+				CONFIG_CONSOLE_RECORD_OUT_SIZE_F);
 	if (ret)
 		return ret;
-	ret = membuff_new((struct membuff *)&gd->console_in,
-			  CONFIG_CONSOLE_RECORD_IN_SIZE);
+	ret = membuf_new((struct membuff *)&gd->console_in,
+			 CONFIG_CONSOLE_RECORD_IN_SIZE);
 
 	/* Start recording from the beginning */
 	gd->flags |= GD_FLG_RECORD;
@@ -831,8 +831,8 @@ int console_record_init(void)
 
 void console_record_reset(void)
 {
-	membuff_purge((struct membuff *)&gd->console_out);
-	membuff_purge((struct membuff *)&gd->console_in);
+	membuf_purge((struct membuff *)&gd->console_out);
+	membuf_purge((struct membuff *)&gd->console_in);
 	gd->flags &= ~GD_FLG_RECORD_OVF;
 }
 
@@ -851,23 +851,23 @@ int console_record_readline(char *str, int maxlen)
 	if (console_record_isempty())
 		return -ENOENT;
 
-	return membuff_readline((struct membuff *)&gd->console_out, str,
+	return membuf_readline((struct membuff *)&gd->console_out, str,
 				maxlen, '\0', false);
 }
 
 int console_record_avail(void)
 {
-	return membuff_avail((struct membuff *)&gd->console_out);
+	return membuf_avail((struct membuff *)&gd->console_out);
 }
 
 bool console_record_isempty(void)
 {
-	return membuff_isempty((struct membuff *)&gd->console_out);
+	return membuf_isempty((struct membuff *)&gd->console_out);
 }
 
 int console_in_puts(const char *str)
 {
-	return membuff_put((struct membuff *)&gd->console_in, str, strlen(str));
+	return membuf_put((struct membuff *)&gd->console_in, str, strlen(str));
 }
 
 #endif
diff --git a/drivers/serial/sandbox.c b/drivers/serial/sandbox.c
index 77a1558db68..cc0491bc3c8 100644
--- a/drivers/serial/sandbox.c
+++ b/drivers/serial/sandbox.c
@@ -63,7 +63,7 @@ static int sandbox_serial_probe(struct udevice *dev)
 
 	if (state->term_raw != STATE_TERM_RAW)
 		disable_ctrlc(1);
-	membuff_init(&priv->buf, priv->serial_buf, sizeof(priv->serial_buf));
+	membuf_init(&priv->buf, priv->serial_buf, sizeof(priv->serial_buf));
 
 	return 0;
 }
@@ -138,15 +138,15 @@ static int sandbox_serial_pending(struct udevice *dev, bool input)
 		return 0;
 
 	os_usleep(100);
-	avail = membuff_putraw(&priv->buf, 100, false, &data);
+	avail = membuf_putraw(&priv->buf, 100, false, &data);
 	if (!avail)
 		return 1;	/* buffer full */
 
 	count = os_read(0, data, avail);
 	if (count > 0)
-		membuff_putraw(&priv->buf, count, true, &data);
+		membuf_putraw(&priv->buf, count, true, &data);
 
-	return membuff_avail(&priv->buf);
+	return membuf_avail(&priv->buf);
 }
 
 static int sandbox_serial_getc(struct udevice *dev)
@@ -156,7 +156,7 @@ static int sandbox_serial_getc(struct udevice *dev)
 	if (!sandbox_serial_pending(dev, true))
 		return -EAGAIN;	/* buffer empty */
 
-	return membuff_getbyte(&priv->buf);
+	return membuf_getbyte(&priv->buf);
 }
 
 #ifdef CONFIG_DEBUG_UART_SANDBOX
diff --git a/drivers/usb/emul/sandbox_keyb.c b/drivers/usb/emul/sandbox_keyb.c
index db769883ba3..756fef64a36 100644
--- a/drivers/usb/emul/sandbox_keyb.c
+++ b/drivers/usb/emul/sandbox_keyb.c
@@ -167,7 +167,7 @@ int sandbox_usb_keyb_add_string(struct udevice *dev,
 	struct sandbox_keyb_priv *priv = dev_get_priv(dev);
 	int ret;
 
-	ret = membuff_put(&priv->in, scancode, USB_KBD_BOOT_REPORT_SIZE);
+	ret = membuf_put(&priv->in, scancode, USB_KBD_BOOT_REPORT_SIZE);
 	if (ret != USB_KBD_BOOT_REPORT_SIZE)
 		return -ENOSPC;
 
@@ -194,7 +194,7 @@ static int sandbox_keyb_interrupt(struct udevice *dev, struct usb_device *udev,
 	if (length < USB_KBD_BOOT_REPORT_SIZE)
 		return 0;
 
-	membuff_get(&priv->in, buffer, USB_KBD_BOOT_REPORT_SIZE);
+	membuf_get(&priv->in, buffer, USB_KBD_BOOT_REPORT_SIZE);
 
 	return 0;
 }
@@ -220,7 +220,7 @@ static int sandbox_keyb_probe(struct udevice *dev)
 	struct sandbox_keyb_priv *priv = dev_get_priv(dev);
 
 	/* Provide an 80 character keyboard buffer */
-	return membuff_new(&priv->in, 80 * USB_KBD_BOOT_REPORT_SIZE);
+	return membuf_new(&priv->in, 80 * USB_KBD_BOOT_REPORT_SIZE);
 }
 
 static const struct dm_usb_ops sandbox_usb_keyb_ops = {
diff --git a/include/membuff.h b/include/membuff.h
index 4eba626ce1c..c7370e1c072 100644
--- a/include/membuff.h
+++ b/include/membuff.h
@@ -6,8 +6,8 @@
  * Copyright (c) 1992 Simon Glass
  */
 
-#ifndef _MEMBUFF_H
-#define _MEMBUFF_H
+#ifndef _membuf_H
+#define _membuf_H
 
 /**
  * @struct membuff: holds the state of a membuff - it is used for input and
@@ -37,16 +37,16 @@ struct membuff {
 };
 
 /**
- * membuff_purge() - reset a membuff to the empty state
+ * membuf_purge() - reset a membuff to the empty state
  *
  * Initialise head and tail pointers so that the membuff becomes empty.
  *
  * @mb: membuff to purge
  */
-void membuff_purge(struct membuff *mb);
+void membuf_purge(struct membuff *mb);
 
 /**
- * membuff_putraw() - find out where bytes can be written
+ * membuf_putraw() - find out where bytes can be written
  *
  * Work out where in the membuff some data could be written. Return a pointer
  * to the address and the number of bytes which can be written there. If
@@ -64,10 +64,10 @@ void membuff_purge(struct membuff *mb);
  * @data: the address data can be written to
  * Return: number of bytes which can be written
  */
-int membuff_putraw(struct membuff *mb, int maxlen, bool update, char **data);
+int membuf_putraw(struct membuff *mb, int maxlen, bool update, char **data);
 
 /**
- * membuff_getraw() - find and return a pointer to available bytes
+ * membuf_getraw() - find and return a pointer to available bytes
  *
  * Returns a pointer to any valid input data in the given membuff and
  * optionally marks it as read. Note that not all input data may not be
@@ -82,37 +82,37 @@ int membuff_putraw(struct membuff *mb, int maxlen, bool update, char **data);
  * @data: returns address of data in input membuff
  * Return: the number of bytes available at *@data
  */
-int membuff_getraw(struct membuff *mb, int maxlen, bool update, char **data);
+int membuf_getraw(struct membuff *mb, int maxlen, bool update, char **data);
 
 /**
- * membuff_putbyte() - Writes a byte to a membuff
+ * membuf_putbyte() - Writes a byte to a membuff
  *
  * @mb: membuff to adjust
  * @ch: byte to write
  * Return: true on success, false if membuff is full
  */
-bool membuff_putbyte(struct membuff *mb, int ch);
+bool membuf_putbyte(struct membuff *mb, int ch);
 
 /**
  * @mb: membuff to adjust
- * membuff_getbyte() - Read a byte from the membuff
+ * membuf_getbyte() - Read a byte from the membuff
  * Return: the byte read, or -1 if the membuff is empty
  */
-int membuff_getbyte(struct membuff *mb);
+int membuf_getbyte(struct membuff *mb);
 
 /**
- * membuff_peekbyte() - check the next available byte
+ * membuf_peekbyte() - check the next available byte
  *
- * Return the next byte which membuff_getbyte() would return, without
+ * Return the next byte which membuf_getbyte() would return, without
  * removing it from the membuff.
  *
  * @mb: membuff to adjust
  * Return: the byte peeked, or -1 if the membuff is empty
  */
-int membuff_peekbyte(struct membuff *mb);
+int membuf_peekbyte(struct membuff *mb);
 
 /**
- * membuff_get() - get data from a membuff
+ * membuf_get() - get data from a membuff
  *
  * Copies any available data (up to @maxlen bytes) to @buff and removes it
  * from the membuff.
@@ -122,10 +122,10 @@ int membuff_peekbyte(struct membuff *mb);
  * @maxlen: maximum number of bytes to read
  * Return: the number of bytes read
  */
-int membuff_get(struct membuff *mb, char *buff, int maxlen);
+int membuf_get(struct membuff *mb, char *buff, int maxlen);
 
 /**
- * membuff_put() - write data to a membuff
+ * membuf_put() - write data to a membuff
  *
  * Writes some data to a membuff. Returns the number of bytes added. If this
  * is less than @lnehgt, then the membuff got full
@@ -135,36 +135,36 @@ int membuff_get(struct membuff *mb, char *buff, int maxlen);
  * @length: number of bytes to write from 'data'
  * Return: the number of bytes added
  */
-int membuff_put(struct membuff *mb, const char *buff, int length);
+int membuf_put(struct membuff *mb, const char *buff, int length);
 
 /**
- * membuff_isempty() - check if a membuff is empty
+ * membuf_isempty() - check if a membuff is empty
  *
  * @mb: membuff to check
  * Return: true if empty, else false
  */
-bool membuff_isempty(struct membuff *mb);
+bool membuf_isempty(struct membuff *mb);
 
 /**
- * membuff_avail() - check available data in a membuff
+ * membuf_avail() - check available data in a membuff
  *
  * @mb: membuff to check
  * Return: number of bytes of data available
  */
-int membuff_avail(struct membuff *mb);
+int membuf_avail(struct membuff *mb);
 
 /**
- * membuff_size() - get the size of a membuff
+ * membuf_size() - get the size of a membuff
  *
  * Note that a membuff can only old data up to one byte less than its size.
  *
  * @mb: membuff to check
  * Return: total size
  */
-int membuff_size(struct membuff *mb);
+int membuf_size(struct membuff *mb);
 
 /**
- * membuff_makecontig() - adjust all membuff data to be contiguous
+ * membuf_makecontig() - adjust all membuff data to be contiguous
  *
  * This places all data in a membuff into a single contiguous lump, if
  * possible
@@ -172,18 +172,18 @@ int membuff_size(struct membuff *mb);
  * @mb: membuff to adjust
  * Return: true on success
  */
-bool membuff_makecontig(struct membuff *mb);
+bool membuf_makecontig(struct membuff *mb);
 
 /**
- * membuff_free() - find the number of bytes that can be written to a membuff
+ * membuf_free() - find the number of bytes that can be written to a membuff
  *
  * @mb: membuff to check
  * Return: returns the number of bytes free in a membuff
  */
-int membuff_free(struct membuff *mb);
+int membuf_free(struct membuff *mb);
 
 /**
- * membuff_readline() - read a line of text from a membuff
+ * membuf_readline() - read a line of text from a membuff
  *
  * Reads a line of text of up to 'maxlen' characters from a membuff and puts
  * it in @str. Any character less than @minch is assumed to be the end of
@@ -196,10 +196,10 @@ int membuff_free(struct membuff *mb);
  * Return: number of bytes read (including terminator) if a line has been
  *	   read, 0 if nothing was there or line didn't fit when must_fit is set
  */
-int membuff_readline(struct membuff *mb, char *str, int maxlen, int minch, bool must_fit);
+int membuf_readline(struct membuff *mb, char *str, int maxlen, int minch, bool must_fit);
 
 /**
- * membuff_extend_by() - expand a membuff
+ * membuf_extend_by() - expand a membuff
  *
  * Extends a membuff by the given number of bytes
  *
@@ -209,38 +209,38 @@ int membuff_readline(struct membuff *mb, char *str, int maxlen, int minch, bool
  * Return: 0 if the expand succeeded, -ENOMEM if not enough memory, -E2BIG
  * if the the size would exceed @max
  */
-int membuff_extend_by(struct membuff *mb, int by, int max);
+int membuf_extend_by(struct membuff *mb, int by, int max);
 
 /**
- * membuff_init() - set up a new membuff using an existing membuff
+ * membuf_init() - set up a new membuff using an existing membuff
  *
  * @mb: membuff to set up
  * @buff: Address of buffer
  * @size: Size of buffer
  */
-void membuff_init(struct membuff *mb, char *buff, int size);
+void membuf_init(struct membuff *mb, char *buff, int size);
 
 /**
- * membuff_uninit() - clear a membuff so it can no longer be used
+ * membuf_uninit() - clear a membuff so it can no longer be used
  *
  * @mb: membuff to uninit
  */
-void membuff_uninit(struct membuff *mb);
+void membuf_uninit(struct membuff *mb);
 
 /**
- * membuff_new() - create a new membuff
+ * membuf_new() - create a new membuff
  *
  * @mb: membuff to init
  * @size: size of membuff to create
  * Return: 0 if OK, -ENOMEM if out of memory
  */
-int membuff_new(struct membuff *mb, int size);
+int membuf_new(struct membuff *mb, int size);
 
 /**
- * membuff_dispose() - free memory allocated to a membuff and uninit it
+ * membuf_dispose() - free memory allocated to a membuff and uninit it
  *
  * @mb: membuff to dispose
  */
-void membuff_dispose(struct membuff *mb);
+void membuf_dispose(struct membuff *mb);
 
 #endif
diff --git a/lib/membuff.c b/lib/membuff.c
index b242a38ff1c..435d12b8a3c 100644
--- a/lib/membuff.c
+++ b/lib/membuff.c
@@ -11,15 +11,15 @@
 #include <malloc.h>
 #include "membuff.h"
 
-void membuff_purge(struct membuff *mb)
+void membuf_purge(struct membuff *mb)
 {
 	/* set mb->head and mb->tail so the buffers look empty */
 	mb->head = mb->start;
 	mb->tail = mb->start;
 }
 
-static int membuff_putrawflex(struct membuff *mb, int maxlen, bool update,
-			      char ***data, int *offsetp)
+static int membuf_putrawflex(struct membuff *mb, int maxlen, bool update,
+			     char ***data, int *offsetp)
 {
 	int len;
 
@@ -72,30 +72,30 @@ static int membuff_putrawflex(struct membuff *mb, int maxlen, bool update,
 	return len;
 }
 
-int membuff_putraw(struct membuff *mb, int maxlen, bool update, char **data)
+int membuf_putraw(struct membuff *mb, int maxlen, bool update, char **data)
 {
 	char **datap;
 	int offset;
 	int size;
 
-	size = membuff_putrawflex(mb, maxlen, update, &datap, &offset);
+	size = membuf_putrawflex(mb, maxlen, update, &datap, &offset);
 	*data = *datap + offset;
 
 	return size;
 }
 
-bool membuff_putbyte(struct membuff *mb, int ch)
+bool membuf_putbyte(struct membuff *mb, int ch)
 {
 	char *data;
 
-	if (membuff_putraw(mb, 1, true, &data) != 1)
+	if (membuf_putraw(mb, 1, true, &data) != 1)
 		return false;
 	*data = ch;
 
 	return true;
 }
 
-int membuff_getraw(struct membuff *mb, int maxlen, bool update, char **data)
+int membuf_getraw(struct membuff *mb, int maxlen, bool update, char **data)
 {
 	int len;
 
@@ -146,21 +146,21 @@ int membuff_getraw(struct membuff *mb, int maxlen, bool update, char **data)
 	return len;
 }
 
-int membuff_getbyte(struct membuff *mb)
+int membuf_getbyte(struct membuff *mb)
 {
 	char *data = 0;
 
-	return membuff_getraw(mb, 1, true, &data) != 1 ? -1 : *(uint8_t *)data;
+	return membuf_getraw(mb, 1, true, &data) != 1 ? -1 : *(uint8_t *)data;
 }
 
-int membuff_peekbyte(struct membuff *mb)
+int membuf_peekbyte(struct membuff *mb)
 {
 	char *data = 0;
 
-	return membuff_getraw(mb, 1, false, &data) != 1 ? -1 : *(uint8_t *)data;
+	return membuf_getraw(mb, 1, false, &data) != 1 ? -1 : *(uint8_t *)data;
 }
 
-int membuff_get(struct membuff *mb, char *buff, int maxlen)
+int membuf_get(struct membuff *mb, char *buff, int maxlen)
 {
 	char *data = 0, *buffptr = buff;
 	int len = 1, i;
@@ -171,7 +171,7 @@ int membuff_get(struct membuff *mb, char *buff, int maxlen)
 	 */
 	for (i = 0; len && i < 2; i++) {
 		/* get a pointer to the data available */
-		len = membuff_getraw(mb, maxlen, true, &data);
+		len = membuf_getraw(mb, maxlen, true, &data);
 
 		/* copy it into the buffer */
 		memcpy(buffptr, data, len);
@@ -183,14 +183,14 @@ int membuff_get(struct membuff *mb, char *buff, int maxlen)
 	return buffptr - buff;
 }
 
-int membuff_put(struct membuff *mb, const char *buff, int length)
+int membuf_put(struct membuff *mb, const char *buff, int length)
 {
 	char *data;
 	int towrite, i, written;
 
 	for (i = written = 0; i < 2; i++) {
 		/* ask where some data can be written */
-		towrite = membuff_putraw(mb, length, true, &data);
+		towrite = membuf_putraw(mb, length, true, &data);
 
 		/* and write it, updating the bytes length */
 		memcpy(data, buff, towrite);
@@ -203,12 +203,12 @@ int membuff_put(struct membuff *mb, const char *buff, int length)
 	return written;
 }
 
-bool membuff_isempty(struct membuff *mb)
+bool membuf_isempty(struct membuff *mb)
 {
 	return mb->head == mb->tail;
 }
 
-int membuff_avail(struct membuff *mb)
+int membuf_avail(struct membuff *mb)
 {
 	struct membuff copy;
 	int i, avail;
@@ -219,18 +219,18 @@ int membuff_avail(struct membuff *mb)
 
 	/* now read everything out of the copied buffer */
 	for (i = avail = 0; i < 2; i++)
-		avail += membuff_getraw(&copy, -1, true, &data);
+		avail += membuf_getraw(&copy, -1, true, &data);
 
 	/* and return how much we read */
 	return avail;
 }
 
-int membuff_size(struct membuff *mb)
+int membuf_size(struct membuff *mb)
 {
 	return mb->end - mb->start;
 }
 
-bool membuff_makecontig(struct membuff *mb)
+bool membuf_makecontig(struct membuff *mb)
 {
 	int topsize, botsize;
 
@@ -281,13 +281,13 @@ bool membuff_makecontig(struct membuff *mb)
 	return true;
 }
 
-int membuff_free(struct membuff *mb)
+int membuf_free(struct membuff *mb)
 {
 	return mb->end == mb->start ? 0 :
-			(mb->end - mb->start) - 1 - membuff_avail(mb);
+			(mb->end - mb->start) - 1 - membuf_avail(mb);
 }
 
-int membuff_readline(struct membuff *mb, char *str, int maxlen, int minch, bool must_fit)
+int membuf_readline(struct membuff *mb, char *str, int maxlen, int minch, bool must_fit)
 {
 	int len;  /* number of bytes read (!= string length) */
 	char *s, *end;
@@ -322,7 +322,7 @@ int membuff_readline(struct membuff *mb, char *str, int maxlen, int minch, bool
 	return len;
 }
 
-int membuff_extend_by(struct membuff *mb, int by, int max)
+int membuf_extend_by(struct membuff *mb, int by, int max)
 {
 	int oldhead, oldtail;
 	int size, orig;
@@ -358,32 +358,32 @@ int membuff_extend_by(struct membuff *mb, int by, int max)
 	return 0;
 }
 
-void membuff_init(struct membuff *mb, char *buff, int size)
+void membuf_init(struct membuff *mb, char *buff, int size)
 {
 	mb->start = buff;
 	mb->end = mb->start + size;
-	membuff_purge(mb);
+	membuf_purge(mb);
 }
 
-int membuff_new(struct membuff *mb, int size)
+int membuf_new(struct membuff *mb, int size)
 {
 	mb->start = malloc(size);
 	if (!mb->start)
 		return -ENOMEM;
 
-	membuff_init(mb, mb->start, size);
+	membuf_init(mb, mb->start, size);
 	return 0;
 }
 
-void membuff_uninit(struct membuff *mb)
+void membuf_uninit(struct membuff *mb)
 {
 	mb->end = NULL;
 	mb->start = NULL;
-	membuff_purge(mb);
+	membuf_purge(mb);
 }
 
-void membuff_dispose(struct membuff *mb)
+void membuf_dispose(struct membuff *mb)
 {
 	free(&mb->start);
-	membuff_uninit(mb);
+	membuf_uninit(mb);
 }
-- 
2.34.1

