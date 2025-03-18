Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7412C282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 15:21:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B6CE81CA8;
	Tue, 18 Mar 2025 16:21:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="idsY3tZi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6A0881CA8; Tue, 18 Mar 2025 16:21:16 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 748C981951
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 16:21:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso36859385e9.3
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 08:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742311273; x=1742916073; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Itdd/LPdvl89rCh+IguaGqIuDWqW/SFJsfh9nXrwIX4=;
 b=idsY3tZirLK5jb/zsW3rpGRNwbyEXVxKuKhw40C2R+E/RHTCZMuvxtNKRz/1wtScoC
 HtZfkecddnr1YcqYfeZLAVI26ZiGyEKI86kYh0dg6GvHu0BxhwNxDqK/d9/Kup2gfwdV
 mSVNbgDXbGDlm5PDEcZJavjpj+99tqrPsDZoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742311273; x=1742916073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Itdd/LPdvl89rCh+IguaGqIuDWqW/SFJsfh9nXrwIX4=;
 b=YSmiZQxOSRN/yeaCD/vGZb4rh+aeCGFFYRykkuk9DjVxqjkKrfgy2HW6AUYPLQNPKD
 suq33Okcq0XzA4q55wYoIhXLH3TjnjT7WHV8cOSOGylnRRyHOj9YfBl2wyRgaQkY64Nc
 SzxTVah4bcWd+L0bjvRh/TVuSPsGKBfOIMT3WGPLYbN1hbJelScW66KJoCOWI8Vb6hAU
 DxLdeJQbcuhas7zMS9O24+MQ1OGKgKT+qDv1h4EmwHL4NMCQL5RtiVYe2qd6jezX4GwS
 bqBgnKk0Gtr59gALB6epqpmHtoNYCcR5DIT3xwHOZVvGOjY0KrIymnfMfw7F+UBzNA3L
 oBGg==
X-Gm-Message-State: AOJu0YwFtNPHl/NUqXOLyLxCXlE96DEEWQChDngSOFhTR8H6fL0+el1F
 9sIE+vNJRSyhcI3OxkMIVtoh2qzm31FNSmIOIX0T2C1mZczL5B/VfL8Dv6q61wKwqOo+o6xgEQi
 KFrEK
X-Gm-Gg: ASbGncvFbVyxpW0nVMdO7dJ+MaHqx9tVkfMgs4/lAqbO96uNONGtOz+ETBILk0FBUfn
 PqPxl88fn/aQHTQ7Esd+r3t6kj8UjTORo+/78V91UhCg79t3daVftm8dgrsoGXJ0KA/E4Aad3iC
 bpldyS5CD6M8u0wnN+51f4uLRpY7qHFqX4pXHiPdSbCgT0WU2MLjuEv9KRpr54NuuITrQDsN56H
 q8O2sC9Mnqr4St6ruuEfl8mQ3hfl8Zzq7VD90o+evDHpPRwJ3dW92m2t4dYiweeb9tUUUXwUHOp
 r/YwiZoJmp3s056pDn8nv67GlA6IHddbSevX2xoKfQ==
X-Google-Smtp-Source: AGHT+IHn/gjdqAc8E5u6wi6PX3sM6L7ggrvgfMEiHWa6EusNw5GEriREkevsnTQ1A09XmnYhtnhp4g==
X-Received: by 2002:a05:600c:384c:b0:43d:b32:40aa with SMTP id
 5b1f17b1804b1-43d3b951a37mr26418865e9.3.1742311273182; 
 Tue, 18 Mar 2025 08:21:13 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe60d37sm136962225e9.27.2025.03.18.08.21.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 08:21:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Dragan Simic <dsimic@manjaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kever Yang <kever.yang@rock-chips.com>, Marek Vasut <marex@denx.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nam Cao <namcao@linutronix.de>, Soeren Moch <smoch@web.de>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 3/7] membuf: Rename struct
Date: Tue, 18 Mar 2025 16:20:44 +0100
Message-ID: <20250318152059.1464369-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318152059.1464369-1-sjg@chromium.org>
References: <20250318152059.1464369-1-sjg@chromium.org>
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

(no changes since v1)

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
index f3a81715080..921d721a27b 100644
--- a/boot/bootmeth_extlinux.c
+++ b/boot/bootmeth_extlinux.c
@@ -108,7 +108,7 @@ static int extlinux_check(struct udevice *dev, struct bootflow_iter *iter)
  */
 static int extlinux_fill_info(struct bootflow *bflow)
 {
-	struct membuff mb;
+	struct membuf mb;
 	char line[200];
 	char *data;
 	int len;
diff --git a/common/console.c b/common/console.c
index ffd0cc1807d..b69bb189639 100644
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
@@ -810,13 +810,13 @@ int console_record_init(void)
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
@@ -827,8 +827,8 @@ int console_record_init(void)
 
 void console_record_reset(void)
 {
-	membuf_purge((struct membuff *)&gd->console_out);
-	membuf_purge((struct membuff *)&gd->console_in);
+	membuf_purge((struct membuf *)&gd->console_out);
+	membuf_purge((struct membuf *)&gd->console_in);
 	gd->flags &= ~GD_FLG_RECORD_OVF;
 }
 
@@ -847,23 +847,23 @@ int console_record_readline(char *str, int maxlen)
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
index 18d94592b03..506ee51cdb0 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -316,14 +316,14 @@ struct global_data {
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
2.43.0

