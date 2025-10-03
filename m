Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD2EECCA470
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 09:04:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2DC5836C1;
	Fri,  3 Oct 2025 11:04:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nbJwYmLK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDC96836C8; Fri,  3 Oct 2025 11:04:01 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10E6A8366F
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 11:03:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e430494ccso11820735e9.1
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 02:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759482238; x=1760087038; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TLeIhjraAuKu0GTC210SbDmnRYnOHo1FNucHH95w4UU=;
 b=nbJwYmLKBB1mgVdlXHu+Umy7P+h6CPzMffu+w/eDTVpi2mHbswNZ/HsZZfiiliFT5J
 iEH0cTWdpehkgSTG8eSeMEVUgAQ4VfjUI8hkR9OkSV0pTVGkG76k9+S/v2sSWwtlooHd
 QDOnCY98Z0w3v3G56XTV3xKSLXUwjoNUlmPnlmSeLEg3uw9+Yb8yaSSVH+qetDFRhpwg
 sZJpJuECKAATZLWxxqD16wYKvgN3oPxQM/qNvKqhbspdNDYCS1SC36JOBEkvvTedFIKl
 2Zd2kiHuhJ2rVYdNymeG28KYj46J1UmM9unTQcpFyy/cfPtzRB6DNtHZcWb2oETMxUT+
 fZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759482238; x=1760087038;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TLeIhjraAuKu0GTC210SbDmnRYnOHo1FNucHH95w4UU=;
 b=pK2FQOwHyc+DoCU+DaQHMIUtLQWH6ouawf8U337n2Zrez06jx/VxnKkF2XFJ572Xi/
 bVgsUlzXIu/otzJG3U5kSUKO+JlWB/PJ7CLDBobNCwJ0ZBjuCsvhHhcOJyI4S41BH0gS
 tMBIKyOvsD5BuENp1YeUmwKvj1xmCcdFbGG4jL3nCFQLR4/Ee8sDqVb9m6rauKRm76Bj
 VJLL8j9Bvjv4gW+SX0O4V+WaYxKAPygDyBISy56gOQ5xiQumSqMDw38yy8bDm8JyLn8Z
 Uc5I87+pYzCipPR+4HcYQ/pURd1SQMpysb0t3KoFkjh7anw0J9EJkZG4PXj0jYRyjcc2
 FcdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNxLZEcjpq6uwPssu88S/ANTR3pl/KFT/lphR++7pzqWKQut7vyDaV2FxOSGJmCFmQhdUXSDU=@lists.denx.de
X-Gm-Message-State: AOJu0YwydT61hI70JWcosWIYNKgrbnKcSObmZTU11M1By6Zr19XwB/T4
 hR8uGnMyKOoPiE113PwYxWKmrruMWDT1DtetjR+WAjpDSXFoUKz0ta4SkpUvPfZYtVM=
X-Gm-Gg: ASbGncs6J0Vya6nDprwX/Zip83kI25qttfQBAb0g93PCu+QE5vMdZNhpuDK6V5P2Ly7
 GuIk+hlU/JI7ajGyyQbCk2ywkOy37yjo6J5P9HO1PQZOcU+dYa0bWiDY0a1MQoIXmhqUenCH9R3
 mWiqwFf2XeWKENqfX2VBmh/r8oIJTgSRiZtuq19N7hHE+ubVZLCK9l3NM26A7WBaP7s5Vl7fx2X
 s5DkVfo9D5GvR3Oh3YBYFTZqtekscQYMBfGkBkMdDXGiQlvo03pO2+secTmsi68tIazWeNmLeKF
 XGcikUvP90FgdLllNbrjWtYKHMzpxbbPdGPZxPS2gPDE/kNERCuVsVddwPFo+mWuv+2Vs9Hm/ne
 4XORqVi1fAFIx2vWgWi13sU26jhuLNUEgBdSRkSfTn1Aqy5xwqtb4h41bVm/CnbJt+5aKjAiADX
 f9R77kc5Ae7AzJGg==
X-Google-Smtp-Source: AGHT+IHTRRWDD9WldAJexuLKLe/JHP4DJw/rxYlFlIhuq2TanP8uV++EbxtQuIuQnP/nJuqNDfTCow==
X-Received: by 2002:a5d:588f:0:b0:415:b17:1e47 with SMTP id
 ffacd0b85a97d-425671c18c0mr1524189f8f.54.1759482238398; 
 Fri, 03 Oct 2025 02:03:58 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ebd:e301:a6dd:d590:166e:6c62])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e723591fcsm21306615e9.10.2025.10.03.02.03.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 02:03:57 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Fri, 03 Oct 2025 10:03:57 +0100
Subject: [PATCH v3] fs: semihosting: Fixup smh_flen and smh_read against
 overflow
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-fs_semihosting-v3-1-5f6de9b7f225@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHyR32gC/32MywrCMBBFf0WyNtJJX9GV/yEibTJpBzSRTAlK6
 b+bdudCuatz4ZxZMEZCFqfdLCImYgo+Q7nfCTN2fkBJNrNQhaqhKJR0fGN80Bh4Ij9IXdvm2Lr
 emc6KLD0jOnptwcs180g8hfje+gnW92cqgcwDVWHTozE1nO/kuxgOIQ5ibSX131fZN9DqEivQ2
 uovf1mWD5svCBbtAAAA
X-Change-ID: 20251002-fs_semihosting-85d697fbfcad
To: Sean Anderson <sean.anderson@seco.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

The sys calls SYS_FLEN and SYS_READ were being used in a way that did
not allow for file sizes > 2^31. Fixing this required changing the
signatures of the functions smh_flen and smh_read to allow file
sizes up to 2^32 - 2 and also being able to return errors that could be
tested for.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Changes in v3:
- V2 missed fixing up one use of smh_flen, fix it
- Link to v2: https://lore.kernel.org/r/20251002-fs_semihosting-v2-1-c1783e4188d8@linaro.org

Changes in v2:
- Fixup smh_flen and smh_read to allow for > 2^31 byte files
- Link to v1: https://lore.kernel.org/r/20251002-fs_semihosting-v1-1-1124e6becc51@linaro.org
---
 common/spl/spl_semihosting.c        | 13 +++++++------
 drivers/serial/serial_semihosting.c |  6 ++++--
 fs/semihostingfs.c                  | 23 +++++++++++++----------
 include/semihosting.h               | 13 +++++++------
 lib/semihosting.c                   | 25 +++++++++++++++++++------
 5 files changed, 50 insertions(+), 30 deletions(-)

diff --git a/common/spl/spl_semihosting.c b/common/spl/spl_semihosting.c
index f36863fe48d25859ee9af67a67140893b6e9e262..fb578a274d0d937b2ed5bd13e505bcefd4491799 100644
--- a/common/spl/spl_semihosting.c
+++ b/common/spl/spl_semihosting.c
@@ -13,13 +13,14 @@ static ulong smh_fit_read(struct spl_load_info *load, ulong file_offset,
 			  ulong size, void *buf)
 {
 	long fd = *(long *)load->priv;
-	ulong ret;
+	long ret;
+	size_t bytes_read;
 
 	if (smh_seek(fd, file_offset))
 		return 0;
 
-	ret = smh_read(fd, buf, size);
-	return ret < 0 ? 0 : ret;
+	ret = smh_read(fd, buf, size, &bytes_read);
+	return ret < 0 ? 0 : bytes_read;
 }
 
 static int spl_smh_load_image(struct spl_image_info *spl_image,
@@ -27,7 +28,8 @@ static int spl_smh_load_image(struct spl_image_info *spl_image,
 {
 	const char *filename = CONFIG_SPL_FS_LOAD_PAYLOAD_NAME;
 	int ret;
-	long fd, len;
+	long fd;
+	size_t len;
 	struct spl_load_info load;
 
 	fd = smh_open(filename, MODE_READ | MODE_BINARY);
@@ -36,12 +38,11 @@ static int spl_smh_load_image(struct spl_image_info *spl_image,
 		return fd;
 	}
 
-	ret = smh_flen(fd);
+	ret = smh_flen(fd, &len);
 	if (ret < 0) {
 		log_debug("could not get length of image: %d\n", ret);
 		goto out;
 	}
-	len = ret;
 
 	spl_load_init(&load, smh_fit_read, &fd, 1);
 	ret = spl_load(spl_image, bootdev, &load, len, 0);
diff --git a/drivers/serial/serial_semihosting.c b/drivers/serial/serial_semihosting.c
index 56a5ec72428afdd97eccad739a46189380ba3e76..017b1f8eda84f5c25e09be7e970d0ebfdbf2ace0 100644
--- a/drivers/serial/serial_semihosting.c
+++ b/drivers/serial/serial_semihosting.c
@@ -25,11 +25,12 @@ static int smh_serial_getc(struct udevice *dev)
 {
 	char ch = 0;
 	struct smh_serial_priv *priv = dev_get_priv(dev);
+	size_t bytes_read;
 
 	if (priv->infd < 0)
 		return smh_getc();
 
-	smh_read(priv->infd, &ch, sizeof(ch));
+	smh_read(priv->infd, &ch, sizeof(ch), &bytes_read);
 	return ch;
 }
 
@@ -140,11 +141,12 @@ static void smh_serial_setbrg(void)
 static int smh_serial_getc(void)
 {
 	char ch = 0;
+	size_t bytes_read;
 
 	if (infd < 0)
 		return smh_getc();
 
-	smh_read(infd, &ch, sizeof(ch));
+	smh_read(infd, &ch, sizeof(ch), &bytes_read);
 	return ch;
 }
 
diff --git a/fs/semihostingfs.c b/fs/semihostingfs.c
index 77e39ca407e4d240a1fd573497c5b6b908816454..6a4d0aaaf2fdaf8da154e59677839a5c7a4889e9 100644
--- a/fs/semihostingfs.c
+++ b/fs/semihostingfs.c
@@ -23,7 +23,8 @@ int smh_fs_set_blk_dev(struct blk_desc *rbdd, struct disk_partition *info)
 static int smh_fs_read_at(const char *filename, loff_t pos, void *buffer,
 			  loff_t maxsize, loff_t *actread)
 {
-	long fd, size, ret;
+	long fd, ret;
+	size_t size;
 
 	fd = smh_open(filename, MODE_READ | MODE_BINARY);
 	if (fd < 0)
@@ -34,19 +35,19 @@ static int smh_fs_read_at(const char *filename, loff_t pos, void *buffer,
 		return ret;
 	}
 	if (!maxsize) {
-		size = smh_flen(fd);
+		ret = smh_flen(fd, &size);
 		if (ret < 0) {
 			smh_close(fd);
-			return size;
+			return ret;
 		}
 
 		maxsize = size;
 	}
 
-	size = smh_read(fd, buffer, maxsize);
+	ret = smh_read(fd, buffer, maxsize, &size);
 	smh_close(fd);
-	if (size < 0)
-		return size;
+	if (ret < 0)
+		return ret;
 
 	*actread = size;
 	return 0;
@@ -78,17 +79,19 @@ static int smh_fs_write_at(const char *filename, loff_t pos, void *buffer,
 
 int smh_fs_size(const char *filename, loff_t *result)
 {
-	long fd, size;
+	long fd;
+	size_t size;
+	int ret;
 
 	fd = smh_open(filename, MODE_READ | MODE_BINARY);
 	if (fd < 0)
 		return fd;
 
-	size = smh_flen(fd);
+	ret = smh_flen(fd, &size);
 	smh_close(fd);
 
-	if (size < 0)
-		return size;
+	if (ret < 0)
+		return ret;
 
 	*result = size;
 	return 0;
diff --git a/include/semihosting.h b/include/semihosting.h
index 4e844cbad87bb1ae6bb365f87f3e7a8aeea445f4..60535199b9532ce16620aea3ca1ea741c5b73766 100644
--- a/include/semihosting.h
+++ b/include/semihosting.h
@@ -95,12 +95,12 @@ long smh_open(const char *fname, enum smh_open_mode mode);
  * @fd: A file descriptor returned from smh_open()
  * @memp: Pointer to a buffer of memory of at least @len bytes
  * @len: The number of bytes to read
+ * @read_len: Pointer which will be updated with actual bytes read on success,
+ *  with 0 indicating %EOF
  *
- * Return:
- * * The number of bytes read on success, with 0 indicating %EOF
- * * A negative error on failure
+ * Return: 0 on success or negative error on failure
  */
-long smh_read(long fd, void *memp, size_t len);
+long smh_read(long fd, void *memp, size_t len, size_t *read_len);
 
 /**
  * smh_write() - Write data to a file
@@ -124,10 +124,11 @@ long smh_close(long fd);
 /**
  * smh_flen() - Get the length of a file
  * @fd: A file descriptor returned from smh_open()
+ * @size: Pointer which will be updated with length of file on success
  *
- * Return: The length of the file, in bytes, or a negative error on failure
+ * Return: 0 on success or negative error on failure
  */
-long smh_flen(long fd);
+int smh_flen(long fd, size_t *size);
 
 /**
  * smh_seek() - Seek to a position in a file
diff --git a/lib/semihosting.c b/lib/semihosting.c
index 9be5bffd30124777c4f8110065e6cca5640312ac..a0f42d41e4a7ad95023c684f6824bfc677ad25cd 100644
--- a/lib/semihosting.c
+++ b/lib/semihosting.c
@@ -93,9 +93,9 @@ struct smh_rdwr_s {
 	size_t len;
 };
 
-long smh_read(long fd, void *memp, size_t len)
+long smh_read(long fd, void *memp, size_t len, size_t *read_len)
 {
-	long ret;
+	size_t ret;
 	struct smh_rdwr_s read;
 
 	debug("%s: fd %ld, memp %p, len %zu\n", __func__, fd, memp, len);
@@ -105,9 +105,20 @@ long smh_read(long fd, void *memp, size_t len)
 	read.len = len;
 
 	ret = smh_trap(SYSREAD, &read);
-	if (ret < 0)
+	if (!ret) {
+		/* Success */
+		*read_len = len;
+		return 0;
+	} else if (ret == len) {
+		/* EOF */
+		*read_len = 0;
+		return 0;
+	} else {
+		/* Partial success */
+		*read_len = len - ret;
 		return smh_errno();
-	return len - ret;
+	}
+
 }
 
 long smh_write(long fd, const void *memp, size_t len, ulong *written)
@@ -140,7 +151,7 @@ long smh_close(long fd)
 	return 0;
 }
 
-long smh_flen(long fd)
+int smh_flen(long fd, size_t *size)
 {
 	long ret;
 
@@ -149,7 +160,9 @@ long smh_flen(long fd)
 	ret = smh_trap(SYSFLEN, &fd);
 	if (ret == -1)
 		return smh_errno();
-	return ret;
+
+	*size = (size_t)ret;
+	return 0;
 }
 
 long smh_seek(long fd, long pos)

---
base-commit: da47ddebd16a7e1047da8537fbf01558d2a89fcf
change-id: 20251002-fs_semihosting-85d697fbfcad

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

