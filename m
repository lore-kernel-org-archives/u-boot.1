Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB5F2C3DA61
	for <u-boot@archiver.kernel.org>; Sun, 21 Jul 2024 10:11:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8164D881E7;
	Sun, 21 Jul 2024 12:10:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B2VpfEcW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25FAF87C69; Sun, 21 Jul 2024 12:09:59 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A982388210
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 12:09:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4266f344091so23695875e9.0
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 03:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721556595; x=1722161395; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5i0NFc2j2On6aDo5SzNrdceYyOGKTNjqbZM8l/9JF9o=;
 b=B2VpfEcWB+lKIZZoZ9zNXaZb1aPsztw/gZVjDNRbpG6SC2JkkiOm9vn6I6/NCyy0jR
 OXvjE2RNn7R+5Rw2fzvBofEpthlfrhCC3OkrYm+DFUVtfLZ2QN62cNgc5jp05/hIZ7BD
 XKUZr74D3TgNz/tz/RTpqP6iTm4u75jgLmmQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721556595; x=1722161395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5i0NFc2j2On6aDo5SzNrdceYyOGKTNjqbZM8l/9JF9o=;
 b=A05Ef3+m9AHgew8wYAoITeiblJi/1O16GENmxnPlifKFjHXAHS8ujbl7K8hcRMltr0
 hUw1LMmMzsoSlVtu15qiWB2Lud0WoM4nDrulZM7EsXg0QOLV/AnWhxwoQOKY1ZEbJ+dV
 r8nnXGX1oV2N/PjPjjulTXgfFMc3x64HnsHUpDfVF/x1FqcBDCLuT7yyk0J68oW4zrQn
 M6a0Fnx/TpT5QTS8B4+5NFt0t2rM1dGfVD/UMsDkIN+x0ObYGhLFoFcgeVO6vvHg7rH6
 k8MvP+KFxzK7xzgdOOgodPnb8e/5iyUIZ89D2fmFEN9CBaCCXH0J489YHKzt0BjLWoRU
 wj9w==
X-Gm-Message-State: AOJu0YwpUFGEl6J+RrKVvifCBYbqId0zVuALC7c12Y9591/aGlQ72DGc
 Ano9Mx/1KvRzmabIXA6HQSIRciZ3T849iDRGnroNFcPpIyjRN9hrDgdUq7n/2OvslBmdvm1/x3Q
 =
X-Google-Smtp-Source: AGHT+IGzTUrvznep6As+cC+FJ9Fh/oLZ159jn7CJdhYb/XtCyr2ZSkiSjcSPqoGq4NX2vc9rBb3QZg==
X-Received: by 2002:a05:600c:1906:b0:426:4765:16f7 with SMTP id
 5b1f17b1804b1-427dc529337mr21889395e9.21.1721556594692; 
 Sun, 21 Jul 2024 03:09:54 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d69013fasm85096265e9.12.2024.07.21.03.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 03:09:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 06/21] sandbox: Return error code from read/write/seek
Date: Sun, 21 Jul 2024 11:09:24 +0100
Message-Id: <20240721100940.3202027-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240721100940.3202027-1-sjg@chromium.org>
References: <20240721100940.3202027-1-sjg@chromium.org>
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

The existing API for these functions is different from the rest of
U-Boot, in that any error code must be obtained from the errno variable
on failure. This variable is part of the C library, so accessing it
outside of the special 'sandbox' shim-functions is not ideal.

Adjust the API to return an error code, to avoid this. Update existing
uses to check for any negative value, rather than just -1.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Rebase on earlier change

 arch/sandbox/cpu/os.c            | 24 +++++++++++++++++++++---
 arch/sandbox/cpu/spl.c           | 16 +++++++---------
 drivers/block/sandbox.c          |  4 ++--
 drivers/usb/emul/sandbox_flash.c |  2 +-
 fs/sandbox/sandboxfs.c           |  6 +++---
 include/os.h                     |  6 +++---
 6 files changed, 37 insertions(+), 21 deletions(-)

diff --git a/arch/sandbox/cpu/os.c b/arch/sandbox/cpu/os.c
index da96ebe43c9..f5c9a8aecf2 100644
--- a/arch/sandbox/cpu/os.c
+++ b/arch/sandbox/cpu/os.c
@@ -47,12 +47,24 @@ struct os_mem_hdr {
 
 ssize_t os_read(int fd, void *buf, size_t count)
 {
-	return read(fd, buf, count);
+	ssize_t ret;
+
+	ret = read(fd, buf, count);
+	if (ret == -1)
+		return -errno;
+
+	return ret;
 }
 
 ssize_t os_write(int fd, const void *buf, size_t count)
 {
-	return write(fd, buf, count);
+	ssize_t ret;
+
+	ret = write(fd, buf, count);
+	if (ret == -1)
+		return -errno;
+
+	return ret;
 }
 
 int os_printf(const char *fmt, ...)
@@ -69,6 +81,8 @@ int os_printf(const char *fmt, ...)
 
 off_t os_lseek(int fd, off_t offset, int whence)
 {
+	off_t ret;
+
 	if (whence == OS_SEEK_SET)
 		whence = SEEK_SET;
 	else if (whence == OS_SEEK_CUR)
@@ -77,7 +91,11 @@ off_t os_lseek(int fd, off_t offset, int whence)
 		whence = SEEK_END;
 	else
 		os_exit(1);
-	return lseek(fd, offset, whence);
+	ret = lseek(fd, offset, whence);
+	if (ret == -1)
+		return -errno;
+
+	return ret;
 }
 
 int os_open(const char *pathname, int os_flags)
diff --git a/arch/sandbox/cpu/spl.c b/arch/sandbox/cpu/spl.c
index 49abe02f322..e86193de419 100644
--- a/arch/sandbox/cpu/spl.c
+++ b/arch/sandbox/cpu/spl.c
@@ -195,16 +195,14 @@ static ulong read_fit_image(struct spl_load_info *load, ulong offset,
 
 	ret = os_lseek(load_ctx->fd, offset, OS_SEEK_SET);
 	if (ret < 0) {
-		printf("Failed to seek to %zx, got %zx (errno=%d)\n", offset,
-		       ret, errno);
-		return log_msg_ret("lse", -errno);
+		printf("Failed to seek to %zx, got %zx\n", offset, ret);
+		return log_msg_ret("lse", ret);
 	}
 
 	res = os_read(load_ctx->fd, buf, size);
 	if (res < 0) {
-		printf("Failed to read %lx bytes, got %ld (errno=%d)\n",
-		       size, res, errno);
-		return log_msg_ret("osr", -errno);
+		printf("Failed to read %lx bytes, got %ld\n", size, res);
+		return log_msg_ret("osr", res);
 	}
 
 	return size;
@@ -238,9 +236,9 @@ int sandbox_spl_load_fit(char *fname, int maxlen, struct spl_image_info *image)
 	}
 	ret = os_read(fd, header, sizeof(*header));
 	if (ret != sizeof(*header)) {
-		printf("Failed to read %lx bytes, got %ld (errno=%d)\n",
-		       sizeof(*header), ret, -errno);
-		return log_msg_ret("rea", -errno);
+		printf("Failed to read %lx bytes, got %d\n", sizeof(*header),
+		       ret);
+		return log_msg_ret("rea", ret);
 	}
 	load_ctx.fd = fd;
 
diff --git a/drivers/block/sandbox.c b/drivers/block/sandbox.c
index ec34f1ad8c2..6c74d66037e 100644
--- a/drivers/block/sandbox.c
+++ b/drivers/block/sandbox.c
@@ -25,7 +25,7 @@ static unsigned long host_block_read(struct udevice *dev,
 	struct udevice *host_dev = dev_get_parent(dev);
 	struct host_sb_plat *plat = dev_get_plat(host_dev);
 
-	if (os_lseek(plat->fd, start * desc->blksz, OS_SEEK_SET) == -1) {
+	if (os_lseek(plat->fd, start * desc->blksz, OS_SEEK_SET) < 0) {
 		printf("ERROR: Invalid block %lx\n", start);
 		return -1;
 	}
@@ -44,7 +44,7 @@ static unsigned long host_block_write(struct udevice *dev,
 	struct udevice *host_dev = dev_get_parent(dev);
 	struct host_sb_plat *plat = dev_get_plat(host_dev);
 
-	if (os_lseek(plat->fd, start * desc->blksz, OS_SEEK_SET) == -1) {
+	if (os_lseek(plat->fd, start * desc->blksz, OS_SEEK_SET) < 0) {
 		printf("ERROR: Invalid block %lx\n", start);
 		return -1;
 	}
diff --git a/drivers/usb/emul/sandbox_flash.c b/drivers/usb/emul/sandbox_flash.c
index 24420e3d51e..b5176bb30ce 100644
--- a/drivers/usb/emul/sandbox_flash.c
+++ b/drivers/usb/emul/sandbox_flash.c
@@ -196,7 +196,7 @@ static int handle_ufi_command(struct sandbox_flash_priv *priv, const void *buff,
 		   priv->fd != -1) {
 		offset = os_lseek(priv->fd, info->seek_block * info->block_size,
 				  OS_SEEK_SET);
-		if (offset == (off_t)-1)
+		if (offset < 0)
 			setup_fail_response(priv);
 		else
 			setup_response(priv);
diff --git a/fs/sandbox/sandboxfs.c b/fs/sandbox/sandboxfs.c
index 773b583fa43..76f1a71f412 100644
--- a/fs/sandbox/sandboxfs.c
+++ b/fs/sandbox/sandboxfs.c
@@ -28,7 +28,7 @@ int sandbox_fs_read_at(const char *filename, loff_t pos, void *buffer,
 	if (fd < 0)
 		return fd;
 	ret = os_lseek(fd, pos, OS_SEEK_SET);
-	if (ret == -1) {
+	if (ret < 0) {
 		os_close(fd);
 		return ret;
 	}
@@ -65,14 +65,14 @@ int sandbox_fs_write_at(const char *filename, loff_t pos, void *buffer,
 	if (fd < 0)
 		return fd;
 	ret = os_lseek(fd, pos, OS_SEEK_SET);
-	if (ret == -1) {
+	if (ret < 0) {
 		os_close(fd);
 		return ret;
 	}
 	size = os_write(fd, buffer, towrite);
 	os_close(fd);
 
-	if (size == -1) {
+	if (size < 0) {
 		ret = -1;
 	} else {
 		ret = 0;
diff --git a/include/os.h b/include/os.h
index 877404a6c13..4371270a1ee 100644
--- a/include/os.h
+++ b/include/os.h
@@ -29,7 +29,7 @@ int os_printf(const char *format, ...);
  * @fd:		File descriptor as returned by os_open()
  * @buf:	Buffer to place data
  * @count:	Number of bytes to read
- * Return:	number of bytes read, or -1 on error
+ * Return:	number of bytes read, or -errno on error
  */
 ssize_t os_read(int fd, void *buf, size_t count);
 
@@ -39,7 +39,7 @@ ssize_t os_read(int fd, void *buf, size_t count);
  * @fd:		File descriptor as returned by os_open()
  * @buf:	Buffer containing data to write
  * @count:	Number of bytes to write
- * Return:	number of bytes written, or -1 on error
+ * Return:	number of bytes written, or -errno on error
  */
 ssize_t os_write(int fd, const void *buf, size_t count);
 
@@ -49,7 +49,7 @@ ssize_t os_write(int fd, const void *buf, size_t count);
  * @fd:		File descriptor as returned by os_open()
  * @offset:	File offset (based on whence)
  * @whence:	Position offset is relative to (see below)
- * Return:	new file offset
+ * Return:	new file offset, or -errno on error
  */
 off_t os_lseek(int fd, off_t offset, int whence);
 
-- 
2.34.1

