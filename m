Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80418CCD192
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 16:04:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87954835A2;
	Tue, 14 Oct 2025 18:03:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jjNZHduS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 107C7833C6; Tue, 14 Oct 2025 18:03:56 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64CEA833F6
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 18:03:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3ee1221ceaaso4538608f8f.3
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 09:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760457833; x=1761062633; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yJubyeiBlXK1KjNqADXFJOuhBwYhIl8jui9ntuTXtWU=;
 b=jjNZHduSkUhmt50qNEyI/OU+ZcRNvvpq+HK+JNCzuMOfMP68T6gb33k8fyXlf0QOM/
 UtpinPO/vZsSXKKG8yA5jh0vU5YGt4yTNOpvSbAmkeZuib4Xi7pVBirBaVbDNWpQWG20
 qc2Dt6JIr7+CEHLKtdIEJOyGnaig1zSUGZB1QN0XLjynq680WO4ERElInVY3L3tfY/H9
 6AX8Cv6iYjj+BdoBnSfxEzvHeMj52TKmCzQdjfgPiQWdGWybNT2xA+xrwgOGCz7mxYTi
 LHEEW7Djinmv6uHtvmTuAPfPCh5cQvN0G027IwWevnM6sz/3CcMjbuN70vVwygQVYDcJ
 aUpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760457833; x=1761062633;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yJubyeiBlXK1KjNqADXFJOuhBwYhIl8jui9ntuTXtWU=;
 b=NVR2P2RtQjYgZPYGBXz1y09BnpkicPUWSzGAjU0l/Gwv1GA44Uzwpl8P43z+xE1Nr0
 mkvbPfUMgWfQAXvVRG9cI3e//6A7MCZH2p3IHRK5Ad+9C2u6fyJh5T/sdDggPjjm9QRL
 1LpK00KdFuhhmTRfoKIwQwVsDzI+H2rm5mJFqMN2tuBq29U/e27AZGDvzCghjfVzPiYi
 RvblsyiVdZeJ+Vq3zPwxiMT8piLfIv0vQ1RtVEFr46HMGD0WbovtdMwhDOqNVoLQDbIG
 VaGThmhu6LIdtklyc6pjezkzKxBjU9x3Pl4+5vbQky7pu0UC7Ku7NvQi+KBeDRsKdCAO
 J2xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVibSYe5VV5o4riOcmo2u6CsrAr+kVwZLOtRXUrFxnWBKvmwTB/AY/Pkc5D02JwwsQ7hX82Ww=@lists.denx.de
X-Gm-Message-State: AOJu0YwSbIw4IcaasouUESjjBA4h8+rUML05UjbP6FXSJn5lxGWlJboR
 UqTum6nmvzHbmFufpmx0biz8t0vMxAIh20MM2O3mBc6ROL+RG/q9C7Xd35ppFgGcMRo=
X-Gm-Gg: ASbGnctxbnRjaJOjeW4vUJE9jYpawhKskpMmdJyhLi2pUa8a5NxGRls56mnaCezBUOo
 JmwVgg8RMdbCK/fLPrcb65SAErsaa/JQSJp4YSl9VDrgustmNR2STWgwKnNm2exoIuxp2yHktuK
 ll70xU00MC1dGA1eTzf5nWt1AeHTNnYqsgqSJE4DbBgBocw343PrCcXtD05JpVY2DZ1EmoAu0tN
 fCzzygtlI3ZS3eVMx+aPK6OrOAvD3uyjWrqp9Rf7ZzdNADHUQno5XWyrZOoXUpFrcS7C9opENiN
 0PuGvTClDpl36xL62IPgG8jcdTMM2BYjf1rsEimThGd3Xi72FEwb5pN4onrY/Gf4RK4oZhIg9IJ
 SKhNAsd0AEwFSJ1Rd1yPBeilniIRR705E9sFCqemuipOCOhDeAU5pOR9zofHjfB6YTBW968auaQ
 D2g92qyx07
X-Google-Smtp-Source: AGHT+IG+Y5nHvHWJT6CuE50IaBsE/aILYVGuxCNR0TvDCknWINKV+byjzx/HB7CO6jJLS4rKdJBdUA==
X-Received: by 2002:a05:6000:4305:b0:3c8:d236:26bd with SMTP id
 ffacd0b85a97d-42666ac2ce9mr16654494f8f.11.1760457832703; 
 Tue, 14 Oct 2025 09:03:52 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:216f:297d:c441:f2cf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce57cce5sm24864380f8f.1.2025.10.14.09.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 09:03:52 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 14 Oct 2025 17:03:51 +0100
Subject: [PATCH v4 2/2] fs: semihosting: Fixup smh_flen against overflow
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-fs_semihosting-v4-2-6f2bc490175b@linaro.org>
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

The sys calls SYS_FLEN was being used in a way that did ot allow for
file sizes > 2^31. Fixing this required changing the signature of the
function to allow file sizes up to 2^32 - 2 and also being able to
return errors that could be tested for.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 common/spl/spl_semihosting.c |  6 +++---
 fs/semihostingfs.c           | 14 ++++++++------
 include/semihosting.h        |  5 +++--
 lib/semihosting.c            |  6 ++++--
 4 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/common/spl/spl_semihosting.c b/common/spl/spl_semihosting.c
index cff6f5351e265136b3effe483fd5d641fdd109f8..fb578a274d0d937b2ed5bd13e505bcefd4491799 100644
--- a/common/spl/spl_semihosting.c
+++ b/common/spl/spl_semihosting.c
@@ -28,7 +28,8 @@ static int spl_smh_load_image(struct spl_image_info *spl_image,
 {
 	const char *filename = CONFIG_SPL_FS_LOAD_PAYLOAD_NAME;
 	int ret;
-	long fd, len;
+	long fd;
+	size_t len;
 	struct spl_load_info load;
 
 	fd = smh_open(filename, MODE_READ | MODE_BINARY);
@@ -37,12 +38,11 @@ static int spl_smh_load_image(struct spl_image_info *spl_image,
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
diff --git a/fs/semihostingfs.c b/fs/semihostingfs.c
index 15f58d578b65f7dbbadce19093546f5bdb46c0c3..6a4d0aaaf2fdaf8da154e59677839a5c7a4889e9 100644
--- a/fs/semihostingfs.c
+++ b/fs/semihostingfs.c
@@ -35,10 +35,10 @@ static int smh_fs_read_at(const char *filename, loff_t pos, void *buffer,
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
@@ -79,17 +79,19 @@ static int smh_fs_write_at(const char *filename, loff_t pos, void *buffer,
 
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
index 42832d86c711ff04e91b6b739c80629253f6d30a..60535199b9532ce16620aea3ca1ea741c5b73766 100644
--- a/include/semihosting.h
+++ b/include/semihosting.h
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
index e49b16b0aa34ab04b6c8949a3e7cab539fdbef82..547a936e17f38204e840035a50f481e57d159592 100644
--- a/lib/semihosting.c
+++ b/lib/semihosting.c
@@ -154,7 +154,7 @@ long smh_close(long fd)
 	return 0;
 }
 
-long smh_flen(long fd)
+int smh_flen(long fd, size_t *size)
 {
 	long ret;
 
@@ -163,7 +163,9 @@ long smh_flen(long fd)
 	ret = smh_trap(SYSFLEN, &fd);
 	if (ret == -1)
 		return smh_errno();
-	return ret;
+
+	*size = (size_t)ret;
+	return 0;
 }
 
 long smh_seek(long fd, long pos)

-- 
2.47.3

