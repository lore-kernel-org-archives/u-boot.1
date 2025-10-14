Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E6ECCD184
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 16:04:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4234C834D4;
	Tue, 14 Oct 2025 18:03:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="o/Hb470H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C59D807B1; Tue, 14 Oct 2025 18:03:54 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99A11833BF
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 18:03:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3f0ae439b56so3313739f8f.3
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 09:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760457832; x=1761062632; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=doa4CD18DO9P4hy6BoVbKsEtPYGTk+3enzJe/ChRLy8=;
 b=o/Hb470HeRnW3x591PytP0q7S4YGnMhuJv7hn6k3/POy6wCiEZ1V2aEcNva1ZmnpxF
 BuHJWrGIyhVZI10u2Ilmm+7lGHrxEMSOaCn3Mp8Nnw0NnGu4B6PrTG5a21flMnCIlVeK
 2ed2uEySHorMBUhUnFVoy36PNsMUc/3ADn9gw83jvXTzXDg/zZKmV40I742KvbyCw+/9
 36mp6ZGaL8liXFavwSTI8mBhiXNIYBswUe+reLx2Mpqm62/WDsyskb6kFdjHKV9ZIeeI
 0UZliSXQZ7nSNXf1ynQIOEjFBN/+hZlu/OMDWjTDeNS8RI7+toiSDkCWDT4wrqg9Wzm+
 oogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760457832; x=1761062632;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=doa4CD18DO9P4hy6BoVbKsEtPYGTk+3enzJe/ChRLy8=;
 b=eBbzHACYMJZmdkILlOeczGQjpqlkq2oVIysm55OWaocZVFGJ7BMHAJgD+bKu/8DNga
 Ju0WpSF3cSQDq8ZLUoWxu5WBEBaXR+5aqW7toDnLPliZGIy/XG/uDONIVn5ve58Vf13b
 dVajE/QIJZp6BWY7vx5PGG/xUQG8K1AEJimKTZc89AF9M+YgH3tHgqGtuunK3jcMucdB
 QeHB0IgUD7QjVbXkMYj1xTOpR2HJbl+79c+nXqXBygYktEFbF0n1VCY132fpu0h9m+7Z
 qxxIYh9yJ10BLjflJ10wxUruP7z/HEkSidxj2KSQBxXrA2ueRVbrLaXxznkauxxwzxX3
 2lmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8WU8YNQPv7eBV4ySciOaiInnhKhSVbeYnfK0sEK3YP+pv74NEYNtTfy1tkN2n0WgL6BQVl7E=@lists.denx.de
X-Gm-Message-State: AOJu0YyeRt4xV/K9PUAOV4o3Q3f0yiFMEPm9ht2yQ3SP981PwN0vn6YY
 apuoH3CUZy7xca1EPiEAeNK9K60Lm8+/4HRO8BmoEOkPG7yxjOkV+QZUVvPYPxCLF1Q=
X-Gm-Gg: ASbGncsieTMfY8mAqcFVGgzdKPGski+hJeEl4g7qSQAecnhKBvzaH53Hhxpz2DxW6ot
 C7ddbAwEzCPXxUr0kuFpB6aaDADwt4DGwBVSX3nelt6ZydGED/Q++LPB99p+JjuB9LGhfYq8OR0
 EGF+UGnywTIGnUwDSGLn+04xZoUGzHYzC/fHjvdXz5i77aNoWL7NRZkm6tfCDI/wd8ohU1OdlkZ
 kkpsl6+GzxyvfypJkSGIfqCJ8BqKEyZs+qPeTLDOtG0T/BfctcauvKtLvPdXrx1h/8cW7/xeSAK
 NIoFMBTmJ0K0IzNuapLd8e0f5xucGm+hEwrIgXt1UoFxPijDL4QKzDyWQqrBTFbBrYBPpDRyOqa
 vUN9pvbE5FqWprR+18HP/FsFYLbEynOru9ww/ShX3Fx5i1E/aaBf5Eqq0zTo1SXPfxC/adBv4iA
 ==
X-Google-Smtp-Source: AGHT+IF7j1rMeiLKBA4wDa9RsqMq0R3apwr6DWQQo9pYnY65PcWG62DbHGSHciC+Ud7MYPbawKVuSQ==
X-Received: by 2002:a05:6000:2283:b0:3f3:ba4:29d7 with SMTP id
 ffacd0b85a97d-4266e8db63cmr14405319f8f.43.1760457831972; 
 Tue, 14 Oct 2025 09:03:51 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:216f:297d:c441:f2cf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce57cce5sm24864380f8f.1.2025.10.14.09.03.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 09:03:51 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 14 Oct 2025 17:03:50 +0100
Subject: [PATCH v4 1/2] fs: semihosting: Fixup smh_read against overflow
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-fs_semihosting-v4-1-6f2bc490175b@linaro.org>
References: <20251014-fs_semihosting-v4-0-6f2bc490175b@linaro.org>
In-Reply-To: <20251014-fs_semihosting-v4-0-6f2bc490175b@linaro.org>
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

The sys call SYS_READ was being used in a way that did not allow for
file sizes > 2^31. Fixing this required changing the signature of the
function to allow file sizes up to 2^32 - 2 and also being able to
return errors that could be tested for.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 common/spl/spl_semihosting.c        |  7 ++++---
 drivers/serial/serial_semihosting.c |  6 ++++--
 fs/semihostingfs.c                  |  9 +++++----
 include/semihosting.h               |  8 ++++----
 lib/semihosting.c                   | 22 ++++++++++++++++++----
 5 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/common/spl/spl_semihosting.c b/common/spl/spl_semihosting.c
index f36863fe48d25859ee9af67a67140893b6e9e262..cff6f5351e265136b3effe483fd5d641fdd109f8 100644
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
index 77e39ca407e4d240a1fd573497c5b6b908816454..15f58d578b65f7dbbadce19093546f5bdb46c0c3 100644
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
@@ -43,10 +44,10 @@ static int smh_fs_read_at(const char *filename, loff_t pos, void *buffer,
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
diff --git a/include/semihosting.h b/include/semihosting.h
index 4e844cbad87bb1ae6bb365f87f3e7a8aeea445f4..42832d86c711ff04e91b6b739c80629253f6d30a 100644
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
diff --git a/lib/semihosting.c b/lib/semihosting.c
index 9be5bffd30124777c4f8110065e6cca5640312ac..e49b16b0aa34ab04b6c8949a3e7cab539fdbef82 100644
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
@@ -105,9 +105,23 @@ long smh_read(long fd, void *memp, size_t len)
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
+	} else if ((long)ret == -1) {
+		*read_len = 0;
 		return smh_errno();
-	return len - ret;
+	} else {
+		/* Partial success */
+		*read_len = len - ret;
+		return 0;
+	}
+
 }
 
 long smh_write(long fd, const void *memp, size_t len, ulong *written)

-- 
2.47.3

