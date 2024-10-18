Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C81FD3C545
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 03:01:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39C82891C7;
	Fri, 18 Oct 2024 05:00:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e7Ivpk3f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8099D89175; Fri, 18 Oct 2024 05:00:54 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEDAD8916D
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 05:00:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-83ab21c26e5so56082539f.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 20:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729220450; x=1729825250; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dhLQmI6mKgrb3C7rletXGFXAU9H244mNEBp7f1qSF2g=;
 b=e7Ivpk3f2YTVw9Im5XeVLta2ZMAZIUHKf2NEoCGklzpm8hoFVnDtAtUX/YHQT0ECsS
 jBJVjz+n2gmbGB78yT0bWPRBNtp7n/n6ARaFCWW0hWVO/N2VlZ4zSA314biRkcle6SVc
 ss0mNlzWZMWHejhS0eLU+79EoVvkGoouEDLdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729220450; x=1729825250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dhLQmI6mKgrb3C7rletXGFXAU9H244mNEBp7f1qSF2g=;
 b=RcGB/JfYZtAmTVnjGMsTM3kCGmvc/hCH/H2phFo21eQpq8YL9bc+l3jDXKcYWeeqGu
 p/XwrsH74qQduGJb0uwDIXfLAJqRhj7/uHC795NkRavVmugPRAi3PJmds8Tin0UZlIfD
 KaXzPJp/eGtOchbpMR8rfw/OgYe/+1RRk50L3+1Kp5oYhQnehnmAmy4BnnWYJ6xaPTKR
 9CDQbVgLZ/4sThEoDjZgq7y9hN8xTMZxWt++xU/fMRsk8d3H6+/4iqi6zKkZvs+KRmOM
 KIPwQOOq6xtPD/ZO0RZJNPY6tMTl5rGe/9MlOx9btMxUn6/J6VYEMlsPRldHVMLUPxxv
 OFAw==
X-Gm-Message-State: AOJu0Yxn/H1j6ldlkl74YAfp/kMkEtnleOq+nmlRT0bSOwiSZ884FZN5
 AE28e8dzEAZUxVS4Us0Pp1APFmu9bXm3fNCXLa+1DMrKRWsrrgHMCpo6jCSk0ZkG/Sv+765+kfE
 =
X-Google-Smtp-Source: AGHT+IFlZOIeEgIcaxHbVaasjlXzjA8EaUpiFNruAFJbjEXPJeCibHbPL70bQP/JT6iqG4KSZ70QfA==
X-Received: by 2002:a05:6602:6c0e:b0:835:4cb5:4fa7 with SMTP id
 ca18e2360f4ac-83aba648870mr95525639f.12.1729220450265; 
 Thu, 17 Oct 2024 20:00:50 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b83e6dsm192499173.39.2024.10.17.20.00.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 20:00:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Ion Agorria <ion@agorria.com>,
 Marek Vasut <marex@denx.de>, Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/8] membuf: Rename struct
Date: Thu, 17 Oct 2024 21:00:22 -0600
Message-Id: <20241018030027.842749-4-sjg@chromium.org>
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

Rename the struct to match the function prefix and filenames.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/sandbox/include/asm/serial.h |  2 +-
 boot/bootmeth_extlinux.c          |  2 +-
 common/console.c                  | 24 +++++++++---------
 drivers/usb/emul/sandbox_keyb.c   |  2 +-
 include/asm-generic/global_data.h |  4 +--
 include/membuf.h                  | 42 +++++++++++++++----------------
 lib/membuf.c                      | 42 +++++++++++++++----------------
 7 files changed, 59 insertions(+), 59 deletions(-)

diff --git a/arch/sandbox/include/asm/serial.h b/arch/sandbox/include/asm/serial.h
index 16589a1b219..41506341816 100644
--- a/arch/sandbox/include/asm/serial.h
+++ b/arch/sandbox/include/asm/serial.h
@@ -44,7 +44,7 @@ void sandbox_serial_endisable(bool enabled);
  * @buf: holds input characters available to be read by this driver
  */
 struct sandbox_serial_priv {
-	struct membuff buf;
+	struct membuf buf;
 	char serial_buf[16];
 	bool start_of_line;
 };
diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
index 35854c1e188..e193feb180e 100644
--- a/boot/bootmeth_extlinux.c
+++ b/boot/bootmeth_extlinux.c
@@ -106,7 +106,7 @@ static int extlinux_check(struct udevice *dev, struct bootflow_iter *iter)
  */
 static int extlinux_fill_info(struct bootflow *bflow)
 {
-	struct membuff mb;
+	struct membuf mb;
 	char line[200];
 	char *data;
 	int len;
diff --git a/common/console.c b/common/console.c
index fa4017a188a..5a7e9cf422f 100644
--- a/common/console.c
+++ b/common/console.c
@@ -101,7 +101,7 @@ static void console_record_putc(const char c)
 	if (!(gd->flags & GD_FLG_RECORD))
 		return;
 	if  (gd->console_out.start &&
-	     !membuf_putbyte((struct membuff *)&gd->console_out, c))
+	     !membuf_putbyte((struct membuf *)&gd->console_out, c))
 		gd->flags |= GD_FLG_RECORD_OVF;
 }
 
@@ -112,7 +112,7 @@ static void console_record_puts(const char *s)
 	if  (gd->console_out.start) {
 		int len = strlen(s);
 
-		if (membuf_put((struct membuff *)&gd->console_out, s, len) !=
+		if (membuf_put((struct membuf *)&gd->console_out, s, len) !=
 		    len)
 			gd->flags |= GD_FLG_RECORD_OVF;
 	}
@@ -125,7 +125,7 @@ static int console_record_getc(void)
 	if (!gd->console_in.start)
 		return -1;
 
-	return membuf_getbyte((struct membuff *)&gd->console_in);
+	return membuf_getbyte((struct membuf *)&gd->console_in);
 }
 
 static int console_record_tstc(void)
@@ -133,7 +133,7 @@ static int console_record_tstc(void)
 	if (!(gd->flags & GD_FLG_RECORD))
 		return 0;
 	if (gd->console_in.start) {
-		if (membuf_peekbyte((struct membuff *)&gd->console_in) != -1)
+		if (membuf_peekbyte((struct membuf *)&gd->console_in) != -1)
 			return 1;
 	}
 	return 0;
@@ -814,13 +814,13 @@ int console_record_init(void)
 {
 	int ret;
 
-	ret = membuf_new((struct membuff *)&gd->console_out,
+	ret = membuf_new((struct membuf *)&gd->console_out,
 			 gd->flags & GD_FLG_RELOC ?
 				CONFIG_CONSOLE_RECORD_OUT_SIZE :
 				CONFIG_CONSOLE_RECORD_OUT_SIZE_F);
 	if (ret)
 		return ret;
-	ret = membuf_new((struct membuff *)&gd->console_in,
+	ret = membuf_new((struct membuf *)&gd->console_in,
 			 CONFIG_CONSOLE_RECORD_IN_SIZE);
 
 	/* Start recording from the beginning */
@@ -831,8 +831,8 @@ int console_record_init(void)
 
 void console_record_reset(void)
 {
-	membuf_purge((struct membuff *)&gd->console_out);
-	membuf_purge((struct membuff *)&gd->console_in);
+	membuf_purge((struct membuf *)&gd->console_out);
+	membuf_purge((struct membuf *)&gd->console_in);
 	gd->flags &= ~GD_FLG_RECORD_OVF;
 }
 
@@ -851,23 +851,23 @@ int console_record_readline(char *str, int maxlen)
 	if (console_record_isempty())
 		return -ENOENT;
 
-	return membuf_readline((struct membuff *)&gd->console_out, str,
+	return membuf_readline((struct membuf *)&gd->console_out, str,
 				maxlen, '\0', false);
 }
 
 int console_record_avail(void)
 {
-	return membuf_avail((struct membuff *)&gd->console_out);
+	return membuf_avail((struct membuf *)&gd->console_out);
 }
 
 bool console_record_isempty(void)
 {
-	return membuf_isempty((struct membuff *)&gd->console_out);
+	return membuf_isempty((struct membuf *)&gd->console_out);
 }
 
 int console_in_puts(const char *str)
 {
-	return membuf_put((struct membuff *)&gd->console_in, str, strlen(str));
+	return membuf_put((struct membuf *)&gd->console_in, str, strlen(str));
 }
 
 #endif
diff --git a/drivers/usb/emul/sandbox_keyb.c b/drivers/usb/emul/sandbox_keyb.c
index 756fef64a36..5ed8c2c799a 100644
--- a/drivers/usb/emul/sandbox_keyb.c
+++ b/drivers/usb/emul/sandbox_keyb.c
@@ -38,7 +38,7 @@ enum {
  *
  */
 struct sandbox_keyb_priv {
-	struct membuff in;
+	struct membuf in;
 };
 
 struct sandbox_keyb_plat {
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index cc87d0037f0..9f10e3cddd5 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -317,14 +317,14 @@ struct global_data {
 	 *
 	 * This buffer is used to collect output during console recording.
 	 */
-	struct membuff console_out;
+	struct membuf console_out;
 	/**
 	 * @console_in: input buffer for console recording
 	 *
 	 * If console recording is activated, this buffer can be used to
 	 * emulate input.
 	 */
-	struct membuff console_in;
+	struct membuf console_in;
 #endif
 #if CONFIG_IS_ENABLED(VIDEO)
 	/**
diff --git a/include/membuf.h b/include/membuf.h
index c7370e1c072..17616d5577e 100644
--- a/include/membuf.h
+++ b/include/membuf.h
@@ -10,7 +10,7 @@
 #define _membuf_H
 
 /**
- * @struct membuff: holds the state of a membuff - it is used for input and
+ * @struct membuf: holds the state of a membuff - it is used for input and
  * output buffers. The buffer extends from @start to (@start + @size - 1).
  * Data in the buffer extends from @tail to @head: it is written in at
  * @head and read out from @tail. The membuff is empty when @head == @tail
@@ -29,7 +29,7 @@
  *		^		^
  *		head		tail
  */
-struct membuff {
+struct membuf {
 	char *start;		/** the start of the buffer */
 	char *end;		/** the end of the buffer (start + length) */
 	char *head;		/** current buffer head */
@@ -43,7 +43,7 @@ struct membuff {
  *
  * @mb: membuff to purge
  */
-void membuf_purge(struct membuff *mb);
+void membuf_purge(struct membuf *mb);
 
 /**
  * membuf_putraw() - find out where bytes can be written
@@ -64,7 +64,7 @@ void membuf_purge(struct membuff *mb);
  * @data: the address data can be written to
  * Return: number of bytes which can be written
  */
-int membuf_putraw(struct membuff *mb, int maxlen, bool update, char **data);
+int membuf_putraw(struct membuf *mb, int maxlen, bool update, char **data);
 
 /**
  * membuf_getraw() - find and return a pointer to available bytes
@@ -82,7 +82,7 @@ int membuf_putraw(struct membuff *mb, int maxlen, bool update, char **data);
  * @data: returns address of data in input membuff
  * Return: the number of bytes available at *@data
  */
-int membuf_getraw(struct membuff *mb, int maxlen, bool update, char **data);
+int membuf_getraw(struct membuf *mb, int maxlen, bool update, char **data);
 
 /**
  * membuf_putbyte() - Writes a byte to a membuff
@@ -91,14 +91,14 @@ int membuf_getraw(struct membuff *mb, int maxlen, bool update, char **data);
  * @ch: byte to write
  * Return: true on success, false if membuff is full
  */
-bool membuf_putbyte(struct membuff *mb, int ch);
+bool membuf_putbyte(struct membuf *mb, int ch);
 
 /**
  * @mb: membuff to adjust
  * membuf_getbyte() - Read a byte from the membuff
  * Return: the byte read, or -1 if the membuff is empty
  */
-int membuf_getbyte(struct membuff *mb);
+int membuf_getbyte(struct membuf *mb);
 
 /**
  * membuf_peekbyte() - check the next available byte
@@ -109,7 +109,7 @@ int membuf_getbyte(struct membuff *mb);
  * @mb: membuff to adjust
  * Return: the byte peeked, or -1 if the membuff is empty
  */
-int membuf_peekbyte(struct membuff *mb);
+int membuf_peekbyte(struct membuf *mb);
 
 /**
  * membuf_get() - get data from a membuff
@@ -122,7 +122,7 @@ int membuf_peekbyte(struct membuff *mb);
  * @maxlen: maximum number of bytes to read
  * Return: the number of bytes read
  */
-int membuf_get(struct membuff *mb, char *buff, int maxlen);
+int membuf_get(struct membuf *mb, char *buff, int maxlen);
 
 /**
  * membuf_put() - write data to a membuff
@@ -135,7 +135,7 @@ int membuf_get(struct membuff *mb, char *buff, int maxlen);
  * @length: number of bytes to write from 'data'
  * Return: the number of bytes added
  */
-int membuf_put(struct membuff *mb, const char *buff, int length);
+int membuf_put(struct membuf *mb, const char *buff, int length);
 
 /**
  * membuf_isempty() - check if a membuff is empty
@@ -143,7 +143,7 @@ int membuf_put(struct membuff *mb, const char *buff, int length);
  * @mb: membuff to check
  * Return: true if empty, else false
  */
-bool membuf_isempty(struct membuff *mb);
+bool membuf_isempty(struct membuf *mb);
 
 /**
  * membuf_avail() - check available data in a membuff
@@ -151,7 +151,7 @@ bool membuf_isempty(struct membuff *mb);
  * @mb: membuff to check
  * Return: number of bytes of data available
  */
-int membuf_avail(struct membuff *mb);
+int membuf_avail(struct membuf *mb);
 
 /**
  * membuf_size() - get the size of a membuff
@@ -161,7 +161,7 @@ int membuf_avail(struct membuff *mb);
  * @mb: membuff to check
  * Return: total size
  */
-int membuf_size(struct membuff *mb);
+int membuf_size(struct membuf *mb);
 
 /**
  * membuf_makecontig() - adjust all membuff data to be contiguous
@@ -172,7 +172,7 @@ int membuf_size(struct membuff *mb);
  * @mb: membuff to adjust
  * Return: true on success
  */
-bool membuf_makecontig(struct membuff *mb);
+bool membuf_makecontig(struct membuf *mb);
 
 /**
  * membuf_free() - find the number of bytes that can be written to a membuff
@@ -180,7 +180,7 @@ bool membuf_makecontig(struct membuff *mb);
  * @mb: membuff to check
  * Return: returns the number of bytes free in a membuff
  */
-int membuf_free(struct membuff *mb);
+int membuf_free(struct membuf *mb);
 
 /**
  * membuf_readline() - read a line of text from a membuff
@@ -196,7 +196,7 @@ int membuf_free(struct membuff *mb);
  * Return: number of bytes read (including terminator) if a line has been
  *	   read, 0 if nothing was there or line didn't fit when must_fit is set
  */
-int membuf_readline(struct membuff *mb, char *str, int maxlen, int minch, bool must_fit);
+int membuf_readline(struct membuf *mb, char *str, int maxlen, int minch, bool must_fit);
 
 /**
  * membuf_extend_by() - expand a membuff
@@ -209,7 +209,7 @@ int membuf_readline(struct membuff *mb, char *str, int maxlen, int minch, bool m
  * Return: 0 if the expand succeeded, -ENOMEM if not enough memory, -E2BIG
  * if the the size would exceed @max
  */
-int membuf_extend_by(struct membuff *mb, int by, int max);
+int membuf_extend_by(struct membuf *mb, int by, int max);
 
 /**
  * membuf_init() - set up a new membuff using an existing membuff
@@ -218,14 +218,14 @@ int membuf_extend_by(struct membuff *mb, int by, int max);
  * @buff: Address of buffer
  * @size: Size of buffer
  */
-void membuf_init(struct membuff *mb, char *buff, int size);
+void membuf_init(struct membuf *mb, char *buff, int size);
 
 /**
  * membuf_uninit() - clear a membuff so it can no longer be used
  *
  * @mb: membuff to uninit
  */
-void membuf_uninit(struct membuff *mb);
+void membuf_uninit(struct membuf *mb);
 
 /**
  * membuf_new() - create a new membuff
@@ -234,13 +234,13 @@ void membuf_uninit(struct membuff *mb);
  * @size: size of membuff to create
  * Return: 0 if OK, -ENOMEM if out of memory
  */
-int membuf_new(struct membuff *mb, int size);
+int membuf_new(struct membuf *mb, int size);
 
 /**
  * membuf_dispose() - free memory allocated to a membuff and uninit it
  *
  * @mb: membuff to dispose
  */
-void membuf_dispose(struct membuff *mb);
+void membuf_dispose(struct membuf *mb);
 
 #endif
diff --git a/lib/membuf.c b/lib/membuf.c
index 5473efa98ca..b13998ccdbd 100644
--- a/lib/membuf.c
+++ b/lib/membuf.c
@@ -11,14 +11,14 @@
 #include <malloc.h>
 #include "membuf.h"
 
-void membuf_purge(struct membuff *mb)
+void membuf_purge(struct membuf *mb)
 {
 	/* set mb->head and mb->tail so the buffers look empty */
 	mb->head = mb->start;
 	mb->tail = mb->start;
 }
 
-static int membuf_putrawflex(struct membuff *mb, int maxlen, bool update,
+static int membuf_putrawflex(struct membuf *mb, int maxlen, bool update,
 			     char ***data, int *offsetp)
 {
 	int len;
@@ -72,7 +72,7 @@ static int membuf_putrawflex(struct membuff *mb, int maxlen, bool update,
 	return len;
 }
 
-int membuf_putraw(struct membuff *mb, int maxlen, bool update, char **data)
+int membuf_putraw(struct membuf *mb, int maxlen, bool update, char **data)
 {
 	char **datap;
 	int offset;
@@ -84,7 +84,7 @@ int membuf_putraw(struct membuff *mb, int maxlen, bool update, char **data)
 	return size;
 }
 
-bool membuf_putbyte(struct membuff *mb, int ch)
+bool membuf_putbyte(struct membuf *mb, int ch)
 {
 	char *data;
 
@@ -95,7 +95,7 @@ bool membuf_putbyte(struct membuff *mb, int ch)
 	return true;
 }
 
-int membuf_getraw(struct membuff *mb, int maxlen, bool update, char **data)
+int membuf_getraw(struct membuf *mb, int maxlen, bool update, char **data)
 {
 	int len;
 
@@ -146,21 +146,21 @@ int membuf_getraw(struct membuff *mb, int maxlen, bool update, char **data)
 	return len;
 }
 
-int membuf_getbyte(struct membuff *mb)
+int membuf_getbyte(struct membuf *mb)
 {
 	char *data = 0;
 
 	return membuf_getraw(mb, 1, true, &data) != 1 ? -1 : *(uint8_t *)data;
 }
 
-int membuf_peekbyte(struct membuff *mb)
+int membuf_peekbyte(struct membuf *mb)
 {
 	char *data = 0;
 
 	return membuf_getraw(mb, 1, false, &data) != 1 ? -1 : *(uint8_t *)data;
 }
 
-int membuf_get(struct membuff *mb, char *buff, int maxlen)
+int membuf_get(struct membuf *mb, char *buff, int maxlen)
 {
 	char *data = 0, *buffptr = buff;
 	int len = 1, i;
@@ -183,7 +183,7 @@ int membuf_get(struct membuff *mb, char *buff, int maxlen)
 	return buffptr - buff;
 }
 
-int membuf_put(struct membuff *mb, const char *buff, int length)
+int membuf_put(struct membuf *mb, const char *buff, int length)
 {
 	char *data;
 	int towrite, i, written;
@@ -203,14 +203,14 @@ int membuf_put(struct membuff *mb, const char *buff, int length)
 	return written;
 }
 
-bool membuf_isempty(struct membuff *mb)
+bool membuf_isempty(struct membuf *mb)
 {
 	return mb->head == mb->tail;
 }
 
-int membuf_avail(struct membuff *mb)
+int membuf_avail(struct membuf *mb)
 {
-	struct membuff copy;
+	struct membuf copy;
 	int i, avail;
 	char *data = 0;
 
@@ -225,12 +225,12 @@ int membuf_avail(struct membuff *mb)
 	return avail;
 }
 
-int membuf_size(struct membuff *mb)
+int membuf_size(struct membuf *mb)
 {
 	return mb->end - mb->start;
 }
 
-bool membuf_makecontig(struct membuff *mb)
+bool membuf_makecontig(struct membuf *mb)
 {
 	int topsize, botsize;
 
@@ -281,13 +281,13 @@ bool membuf_makecontig(struct membuff *mb)
 	return true;
 }
 
-int membuf_free(struct membuff *mb)
+int membuf_free(struct membuf *mb)
 {
 	return mb->end == mb->start ? 0 :
 			(mb->end - mb->start) - 1 - membuf_avail(mb);
 }
 
-int membuf_readline(struct membuff *mb, char *str, int maxlen, int minch, bool must_fit)
+int membuf_readline(struct membuf *mb, char *str, int maxlen, int minch, bool must_fit)
 {
 	int len;  /* number of bytes read (!= string length) */
 	char *s, *end;
@@ -322,7 +322,7 @@ int membuf_readline(struct membuff *mb, char *str, int maxlen, int minch, bool m
 	return len;
 }
 
-int membuf_extend_by(struct membuff *mb, int by, int max)
+int membuf_extend_by(struct membuf *mb, int by, int max)
 {
 	int oldhead, oldtail;
 	int size, orig;
@@ -358,14 +358,14 @@ int membuf_extend_by(struct membuff *mb, int by, int max)
 	return 0;
 }
 
-void membuf_init(struct membuff *mb, char *buff, int size)
+void membuf_init(struct membuf *mb, char *buff, int size)
 {
 	mb->start = buff;
 	mb->end = mb->start + size;
 	membuf_purge(mb);
 }
 
-int membuf_new(struct membuff *mb, int size)
+int membuf_new(struct membuf *mb, int size)
 {
 	mb->start = malloc(size);
 	if (!mb->start)
@@ -375,14 +375,14 @@ int membuf_new(struct membuff *mb, int size)
 	return 0;
 }
 
-void membuf_uninit(struct membuff *mb)
+void membuf_uninit(struct membuf *mb)
 {
 	mb->end = NULL;
 	mb->start = NULL;
 	membuf_purge(mb);
 }
 
-void membuf_dispose(struct membuff *mb)
+void membuf_dispose(struct membuf *mb)
 {
 	free(&mb->start);
 	membuf_uninit(mb);
-- 
2.34.1

