Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4213C4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 12:18:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BF83889BB;
	Tue, 30 Apr 2024 14:18:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="UbaTew6Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF20F889B3; Tue, 30 Apr 2024 12:24:07 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25256887B8
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 12:24:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=piotr.wojtaszczyk@timesys.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-51b09c3a111so7777342e87.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 03:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1714472644; x=1715077444;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EbYWJ777GaNT+/g2AmZX4TYnTOQzzxU0uNtXFduag+c=;
 b=UbaTew6QQhBDZldaEMTu8S8E0vZNNJ8BL1uL1/XYdvJL4n2GPc+f22ySpCyVRI8yam
 L5Tj1zalYWnnuQ4ARkGeD57Q+kAiLdhjFcuhUYtTYtvx2xl4H+Wxn5TzJFKfxbKXYr9x
 XaXwVSI54ZeG/LnKepCMeAA4jSWmazjBhMoskB0gThL4St+zWlmW/MNKVacrF/5kpUnI
 0kL6NMn2easGssW5E5UURibyl4T5w9odLpkvBInzCShAER6s2FEY2Ey7lfwlK0LvNwsG
 52nZeG2SNv6ipjP18fisGKdOkamF3lhihTcOOtNTZbo8/3mlEPlNUaR0rZcWlJT8+1W4
 Gr5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714472644; x=1715077444;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EbYWJ777GaNT+/g2AmZX4TYnTOQzzxU0uNtXFduag+c=;
 b=fGZ2GOyWyhxzNf+iWpE8rqILMhHyTbNEsI8padDJ6aapX4SM3H/D82wAKDf3Aow+Sy
 bcjcYbm1pEm4iTHZgtraGD6JCdcgN2kb2iAFB+tjHRmlvK3IdFofZI9V35mdO/4V5d08
 VhjXCkXNK0jv7sNfdRmD8L87k/MK58SYbeuAUJA42DzkAXzWIkQArz3RhuDxS4MyHaBk
 PbAMqAteIa2YlYca0zhXl4HajjPLGZT6cjZx2d4xXf0mpj56lfF3M7yqEFh99LY3ZPyZ
 z6GxQm8ZA/qNOKF+HyvPhKDeuxYhr4zbPbuWUsEF8X2NoNEWZX6u8envK7CEd9ZEzc3h
 pItw==
X-Gm-Message-State: AOJu0YxIb7M/lnFZEofFsA/nv5bwzjdUK4OU9O/uV0Z22MSlkSU31mx+
 8nB4HdrJ2LrujOhqavmcQzMMUR0K44EtjBPO7zSyGyMjsveQPO3xlQyltTX74/eB95HOI/sRGnw
 w
X-Google-Smtp-Source: AGHT+IGC+yv0MYSgZSGwB3SQ7jRBEh6JOOTkHa6vdzDpOoOFiZWnsvk10qHX6Hi6NwkOu2+5f5vZKg==
X-Received: by 2002:a05:6512:2f0:b0:516:a6ff:2467 with SMTP id
 m16-20020a05651202f000b00516a6ff2467mr9207329lfq.0.1714472643715; 
 Tue, 30 Apr 2024 03:24:03 -0700 (PDT)
Received: from localhost.localdomain ([91.216.213.152])
 by smtp.gmail.com with ESMTPSA id
 k9-20020a17090666c900b00a52274ee0a7sm15111201ejp.171.2024.04.30.03.24.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 03:24:03 -0700 (PDT)
From: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
To: u-boot@lists.denx.de
Cc: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Ben Dooks <ben.dooks@sifive.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] fs: ubifs: Add support for ZSTD decompression
Date: Tue, 30 Apr 2024 12:23:58 +0200
Message-Id: <20240430102358.11163-1-piotr.wojtaszczyk@timesys.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 30 Apr 2024 14:18:01 +0200
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

Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
---

 fs/ubifs/ubifs-media.h |  2 ++
 fs/ubifs/ubifs.c       | 55 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/fs/ubifs/ubifs-media.h b/fs/ubifs/ubifs-media.h
index 2b5b26a01b..299d80f928 100644
--- a/fs/ubifs/ubifs-media.h
+++ b/fs/ubifs/ubifs-media.h
@@ -320,12 +320,14 @@ enum {
  * UBIFS_COMPR_NONE: no compression
  * UBIFS_COMPR_LZO: LZO compression
  * UBIFS_COMPR_ZLIB: ZLIB compression
+ * UBIFS_COMPR_ZSTD: ZSTD compression
  * UBIFS_COMPR_TYPES_CNT: count of supported compression types
  */
 enum {
 	UBIFS_COMPR_NONE,
 	UBIFS_COMPR_LZO,
 	UBIFS_COMPR_ZLIB,
+	UBIFS_COMPR_ZSTD,
 	UBIFS_COMPR_TYPES_CNT,
 };
 
diff --git a/fs/ubifs/ubifs.c b/fs/ubifs/ubifs.c
index a509584e5d..4df7cbb951 100644
--- a/fs/ubifs/ubifs.c
+++ b/fs/ubifs/ubifs.c
@@ -27,6 +27,11 @@
 #include <linux/err.h>
 #include <linux/lzo.h>
 
+#if IS_ENABLED(CONFIG_ZSTD)
+#include <linux/zstd.h>
+#include <abuf.h>
+#endif
+
 DECLARE_GLOBAL_DATA_PTR;
 
 /* compress.c */
@@ -42,6 +47,26 @@ static int gzip_decompress(const unsigned char *in, size_t in_len,
 		      (unsigned long *)out_len, 0, 0);
 }
 
+#if IS_ENABLED(CONFIG_ZSTD)
+static int zstd_decompress_wrapper(const unsigned char *in, size_t in_len,
+			   unsigned char *out, size_t *out_len)
+{
+	struct abuf abuf_in, abuf_out;
+	int ret;
+
+	abuf_init_set(&abuf_in, (void *)in, in_len);
+	abuf_init_set(&abuf_out, (void *)out, *out_len);
+
+	ret = zstd_decompress(&abuf_in, &abuf_out);
+	if (ret < 0) {
+		return ret;
+	}
+
+	*out_len = ret;
+	return 0;
+}
+#endif
+
 /* Fake description object for the "none" compressor */
 static struct ubifs_compressor none_compr = {
 	.compr_type = UBIFS_COMPR_NONE,
@@ -71,8 +96,22 @@ static struct ubifs_compressor zlib_compr = {
 	.decompress = gzip_decompress,
 };
 
+#if IS_ENABLED(CONFIG_ZSTD)
+static struct ubifs_compressor zstd_compr = {
+	.compr_type = UBIFS_COMPR_ZSTD,
+#ifndef __UBOOT__
+	.comp_mutex = &zstd_enc_mutex,
+	.decomp_mutex = &zstd_dec_mutex,
+#endif
+	.name = "zstd",
+	.capi_name = "zstd",
+	.decompress = zstd_decompress_wrapper,
+};
+#endif
+
+
 /* All UBIFS compressors */
-struct ubifs_compressor *ubifs_compressors[UBIFS_COMPR_TYPES_CNT];
+struct ubifs_compressor *ubifs_compressors[UBIFS_COMPR_TYPES_CNT] = {NULL};
 
 
 #ifdef __UBOOT__
@@ -166,8 +205,14 @@ int ubifs_decompress(const struct ubifs_info *c, const void *in_buf,
 
 	compr = ubifs_compressors[compr_type];
 
+	if (unlikely(!compr)) {
+		ubifs_err(c, "compression type %d is not compiled in", compr_type);
+		return -EINVAL;
+	}
+
 	if (unlikely(!compr->capi_name)) {
-		ubifs_err(c, "%s compression is not compiled in", compr->name);
+		ubifs_err(c, "%s compression is not compiled in",
+				compr->name ? compr->name : "unknown");
 		return -EINVAL;
 	}
 
@@ -232,6 +277,12 @@ int __init ubifs_compressors_init(void)
 	if (err)
 		return err;
 
+#if IS_ENABLED(CONFIG_ZSTD)
+	err = compr_init(&zstd_compr);
+	if (err)
+		return err;
+#endif
+
 	err = compr_init(&none_compr);
 	if (err)
 		return err;
-- 
2.25.1

