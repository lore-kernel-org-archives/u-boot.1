Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BFA1C25B7C
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 16:49:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B317A885AE;
	Tue, 28 May 2024 18:47:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="BV2gohe1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6200884D2; Tue, 28 May 2024 17:05:47 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33CFC884B2
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 17:05:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=piotr.wojtaszczyk@timesys.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5785fc9c543so1173610a12.1
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 08:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1716908744; x=1717513544;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CcOzxDgGeRgB7BQXzVC58bAHiXPeoVyqs/yJF9csQgA=;
 b=BV2gohe17jPdLWCiL+mNJqmgq5D70hItw7y0wszkvT3si6q+UvteGmX5ezIX6tUKH1
 00tAhjlNVRAffSey6sXFQ7Vi+OUNMcLsAZMsRlyH5VQQuVH1/ICwWvsBf5dFuwqDh2Z0
 H9/nt+Txli6o0i9CavR3fqOjnBzxfQZVCGgeZBUt57U/+CkpDLxMok7kusATVuNGLiTu
 NLsxOI1p0bhHHMtWvPAeVkJa4Jfs1HWdU7ZxJCmR4M3Kts60BKmOhiBn/oPdfUnpW7Tx
 nq6xCzR1YpwLzaBP6Dht5wk5R5pVIDYbBMNXYeOLzETv2Mm9VIfzC5NQTVb99OWUNo+b
 CsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716908744; x=1717513544;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CcOzxDgGeRgB7BQXzVC58bAHiXPeoVyqs/yJF9csQgA=;
 b=c/u6oCb+LvTeKfPl3XxgATd/alYCX0G7C8wievqJl5egtOjnNNi7OTWtx7ztlCH5iM
 wq/PoyyGjLRQmTh+tHUfAFOaVEwVRAggD3STUgvty66VNHZGANnzRyaCfdwH9VRqBFU6
 GIowRfuyV+EYNPEIJenYsfLZwf0I01QTG8Zgvz+dKYW1cmcZXW1dyjNbtHuZrTH/fKmZ
 L+SrJZgKCruAUBjhsuMtmxaG9Fk47zKjYvcOJ9LhsvXFcQG7asl63DGlv0b0zj60RLBY
 LKey8OnIgNKQWqpCgqFfEfAvMNabEuEE0tbcFX5m/hM76XozKnv8YJOhEdCSyxzSO1Er
 M8sg==
X-Gm-Message-State: AOJu0Yw54Ol+btOvqU607XV6ypUueWNyW2fU4au9gaeRD6jk4Eraigz6
 BKRuD47JCx1oV6sRkSnWqzeMRAkH03sNRIse6hQ374C022PovxJow922OjpmI0ArsM05anZJzLW
 FS+gN1Q==
X-Google-Smtp-Source: AGHT+IGK7oYUtJzq0HOpteE4kndSKQFfGPvdTnwNX0ih+5K6trO1H1L7F93Gqj8YRPgQ7Anfu4Ek/g==
X-Received: by 2002:a50:ab5a:0:b0:579:f08c:105b with SMTP id
 4fb4d7f45d1cf-579f08c10a4mr3004722a12.35.1716908744115; 
 Tue, 28 May 2024 08:05:44 -0700 (PDT)
Received: from localhost.localdomain ([91.216.213.152])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5786957ec9esm5219812a12.1.2024.05.28.08.05.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 08:05:43 -0700 (PDT)
From: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
To: u-boot@lists.denx.de
Cc: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Ben Dooks <ben.dooks@sifive.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] fs: ubifs: Add support for ZSTD decompression
Date: Tue, 28 May 2024 17:05:28 +0200
Message-Id: <20240528150528.1982853-1-piotr.wojtaszczyk@timesys.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 28 May 2024 18:47:36 +0200
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

ZSTD can be a better tradeoff between NAND IO operations and decompression
speed giving a better boot time.

Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
---

 fs/ubifs/ubifs-media.h |  2 ++
 fs/ubifs/ubifs.c       | 53 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 53 insertions(+), 2 deletions(-)

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
index a509584e5d..ff3945e7fd 100644
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
@@ -42,6 +47,25 @@ static int gzip_decompress(const unsigned char *in, size_t in_len,
 		      (unsigned long *)out_len, 0, 0);
 }
 
+#if IS_ENABLED(CONFIG_ZSTD)
+static int zstd_decompress_wrapper(const unsigned char *in, size_t in_len,
+				   unsigned char *out, size_t *out_len)
+{
+	struct abuf abuf_in, abuf_out;
+	int ret;
+
+	abuf_init_set(&abuf_in, (void *)in, in_len);
+	abuf_init_set(&abuf_out, (void *)out, *out_len);
+
+	ret = zstd_decompress(&abuf_in, &abuf_out);
+	if (ret < 0)
+		return ret;
+
+	*out_len = ret;
+	return 0;
+}
+#endif
+
 /* Fake description object for the "none" compressor */
 static struct ubifs_compressor none_compr = {
 	.compr_type = UBIFS_COMPR_NONE,
@@ -71,8 +95,21 @@ static struct ubifs_compressor zlib_compr = {
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
 /* All UBIFS compressors */
-struct ubifs_compressor *ubifs_compressors[UBIFS_COMPR_TYPES_CNT];
+struct ubifs_compressor *ubifs_compressors[UBIFS_COMPR_TYPES_CNT] = {NULL};
 
 
 #ifdef __UBOOT__
@@ -166,8 +203,14 @@ int ubifs_decompress(const struct ubifs_info *c, const void *in_buf,
 
 	compr = ubifs_compressors[compr_type];
 
+	if (unlikely(!compr)) {
+		ubifs_err(c, "compression type %d is not compiled in", compr_type);
+		return -EINVAL;
+	}
+
 	if (unlikely(!compr->capi_name)) {
-		ubifs_err(c, "%s compression is not compiled in", compr->name);
+		ubifs_err(c, "%s compression is not compiled in",
+			  compr->name ? compr->name : "unknown");
 		return -EINVAL;
 	}
 
@@ -232,6 +275,12 @@ int __init ubifs_compressors_init(void)
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

