Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E5DBC3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 07:04:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B99FF88820;
	Sat, 13 Jul 2024 09:03:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H2UibuGS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96E17887DB; Sat, 13 Jul 2024 09:03:50 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20795887E3
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 09:03:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52ea5dc3c79so3835673e87.1
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 00:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720854227; x=1721459027; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ru2CVuo+69+gYKq+a22vIAXWUry+f3gqW1HA65Qs9YI=;
 b=H2UibuGSp0RsiQouWn8G0aYTgGFGE19Ofu07wUJ7HGMBlxYxrgLpsy0LyLAr8JyhV6
 vol9FemQpXu/PEiz2racFg1R8b2gCJDkFp1Md/7OYBSrrUx4R475IZA+uaAKR2RhiMSS
 kL3QKv8eB8AIdulVoyfX7Yd9xvb5fk6P/Oy5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720854227; x=1721459027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ru2CVuo+69+gYKq+a22vIAXWUry+f3gqW1HA65Qs9YI=;
 b=HwfHC0TRC/95HClV+CZx8Y8oBuRCn3eC4TM361vlpp+9FCW4QiT9d55NEOFbxF0VTg
 msBOsxTtA2bWyx3Frzhp33LR++a5QiIVd08S1KHvAdTh27tfQap69M5GrmMp5NttJPXM
 6Y4O3dFlLvOAT2M2N+3bpWvpLGM2k5wkqgNY+fn34ZqjgcLo8mUBqDyUbxhdO/jLjPdz
 hTbhWnuL/dGXcaxMnHm6AZG03qdyIk/R2GPWi8fqFguydIzvX8VGDmKVNrtTvnKv7BIc
 apPHDjUFn+0ZMtNFdvvcQhl7Q65vlCRzJOY4y4vA0VWhQE2aw6Ifpa5TskMkjZPdFh6b
 BYnA==
X-Gm-Message-State: AOJu0Yx+rZ4KLmPWIy94sA/T2LzM6KGZ4JbT8jRLOUuGbMZC46rIT4eA
 /StSH6t8lE81uO+g3ingczFA/AQjdzDCyaJGv7BpgYbFTyhwawd+I4T7xsRwkPIjGC/AG9WHWgc
 =
X-Google-Smtp-Source: AGHT+IG+XN/IfLhvYRx6k9HD/OTFZRrD71HteBE6m+Ies9+msX5q01r3i5TE7eSrSBW1vW98AMcpGQ==
X-Received: by 2002:a19:6411:0:b0:52e:7f18:1775 with SMTP id
 2adb3069b0e04-52eb99919e9mr7169927e87.6.1720854227227; 
 Sat, 13 Jul 2024 00:03:47 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5ef550asm9973165e9.46.2024.07.13.00.03.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jul 2024 00:03:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Michal Simek <michal.simek@amd.com>, Sean Anderson <seanga2@gmail.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 07/21] sandbox: Return error code from read/write/seek
Date: Sat, 13 Jul 2024 08:00:41 +0100
Message-Id: <20240713070055.2172883-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240713070055.2172883-1-sjg@chromium.org>
References: <20240713070055.2172883-1-sjg@chromium.org>
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

(no changes since v1)

 arch/sandbox/cpu/os.c            | 24 +++++++++++++++++++++---
 arch/sandbox/cpu/spl.c           |  8 ++++----
 drivers/block/sandbox.c          |  4 ++--
 drivers/usb/emul/sandbox_flash.c |  2 +-
 fs/sandbox/sandboxfs.c           |  6 +++---
 include/os.h                     |  6 +++---
 6 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/arch/sandbox/cpu/os.c b/arch/sandbox/cpu/os.c
index 1491d00504d..572947baf5c 100644
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
index caa8e0b3b01..39869f27a7b 100644
--- a/arch/sandbox/cpu/spl.c
+++ b/arch/sandbox/cpu/spl.c
@@ -195,15 +195,15 @@ static ulong read_fit_image(struct spl_load_info *load, ulong offset,
 
 	ret = os_lseek(load_ctx->fd, offset, OS_SEEK_SET);
 	if (ret < 0) {
-		printf("Failed to seek to %zx, got %zx (errno=%d)\n", offset,
-		       ret, errno);
+		printf("Failed to seek to %zx, got %zx (errno=%zd)\n", offset,
+		       ret, ret);
 		return log_msg_ret("lse", ret);
 	}
 
 	res = os_read(load_ctx->fd, buf, size);
 	if (res < 0) {
-		printf("Failed to read %lx bytes, got %ld (errno=%d)\n",
-		       size, res, errno);
+		printf("Failed to read %lx bytes, got %ld (errno=%zd)\n",
+		       size, res, ret);
 		return log_msg_ret("osr", res);
 	}
 
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

