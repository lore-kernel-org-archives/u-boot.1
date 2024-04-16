Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC252C04FFF
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 19:03:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E025B8843C;
	Tue, 16 Apr 2024 21:02:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zHlAE9iS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10F6D88438; Tue, 16 Apr 2024 21:01:57 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C35548843B
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 21:01:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6eb7ef71c03so1455849a34.0
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 12:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713294110; x=1713898910; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nd1Owqki79mUv8AQ0kJHiY+QY8a9I9+pBvz0H9WzHA8=;
 b=zHlAE9iSGnrmsvmtGh3rCF598r/r8GbCvBHdOuZEAZqjYtD4C3FoSLUpaQf466R5II
 B1fEDh78OflcRdvzbaLJ2X1gKjWwsUP7BnTQGAHp5CJR2o5EenBH4X/ucdy9exWGMKBz
 O6n5hQQce5F0v0YtEuNwMKWKEpSJrPiYmDkTBcALEVPuiKqhjVOYgbcJHDUyeSU6q5PC
 kh8Jj8Fnw9wOeNcveTuAz+5Wpv2x5Zqgf9PCA05kE4IGEsQOS9LYDtKOJfEjYK2zvjLE
 EUMpDShs1LgumHm2oypj2wKY3qYV1HQ4pKQ1aUVTJvmWp7R5rvQ8CklDFdpCjzY7A/Wr
 s+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713294110; x=1713898910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nd1Owqki79mUv8AQ0kJHiY+QY8a9I9+pBvz0H9WzHA8=;
 b=SSJc89f3rLlI9jKIWgqG+89VDR9HuoP2VNWAP8Ea13DHnJLcpgcsjckpLlwPHhg9Zt
 8sQ3V6tVumvKAFw3lz3hB4C4GQn4TakCaS9pr8ekMkvkrW9Tz2DOBUZmbFLOpDcfrNoP
 G7IpBIYp/8ET93mMBQG4u+ZiZuWFpctmY2DCtAJgG76Ns+wPm7NbtalmSey0pdMkRzG6
 Osx1cIaNSgK2vdToGn7lQ7bIu44pOMeY5dWdI0YKhsOZ5RcsozEFE3HKfl4VAJ1KzyPo
 Qlcrg8krY/4F3NKwQszAgmwaMZQU2l77oxQHgeX9ASwbGjixTq4Eq7/HhWl6BHJo3S8O
 esnw==
X-Gm-Message-State: AOJu0Yz180dd87cUnC1xeNIUiAwkT6G54R1XcrcWoAfYTU7MaU9ttXnw
 6S0PKDt/OLU/+oYeVqGxXA5R9E4oUAOPvcX3836BC16i9rY4DjwAiOan0ASYjjm9XSck/allsMV
 z
X-Google-Smtp-Source: AGHT+IH6J70/ngx9QEGNPKtre9ZjytHEvAK0HTlpTVQt/HzMhITu6OJSB1JVN/2VL8GqdHtvgPYBtA==
X-Received: by 2002:a05:6870:7012:b0:22e:e675:69d3 with SMTP id
 u18-20020a056870701200b0022ee67569d3mr15831237oae.26.1713294110284; 
 Tue, 16 Apr 2024 12:01:50 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-115-4-214.cpe.net.cable.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 n13-20020a0cbe8d000000b0069b59fb5829sm5971657qvi.44.2024.04.16.12.01.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 12:01:49 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: raymond.mao@linaro.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 xypron.glpk@gmx.de
Subject: [PATCH 09/23] hash: integrate hash on mbedtls
Date: Tue, 16 Apr 2024 12:00:05 -0700
Message-Id: <20240416190019.81016-10-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240416190019.81016-1-raymond.mao@linaro.org>
References: <20240416190019.81016-1-raymond.mao@linaro.org>
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

Integrate common/hash.c on the hash shim layer so that hash APIs
from mbedtls can be leveraged by boot/image and efi_loader.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 common/hash.c                  | 161 +++++++++++++++++++++++++++++++++
 include/u-boot/hash-checksum.h |   6 ++
 2 files changed, 167 insertions(+)

diff --git a/common/hash.c b/common/hash.c
index 3d6b84de47..5352ba88e3 100644
--- a/common/hash.c
+++ b/common/hash.c
@@ -31,10 +31,143 @@
 #include <hash.h>
 #include <image.h>
 #include <u-boot/crc.h>
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
+#include <mbedtls/sha1.h>
+#include <mbedtls/sha256.h>
+#include <mbedtls/sha512.h>
+#include <mbedtls/md5.h>
+#else
 #include <u-boot/sha1.h>
 #include <u-boot/sha256.h>
 #include <u-boot/sha512.h>
 #include <u-boot/md5.h>
+#endif
+
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
+
+static int hash_init_sha1(struct hash_algo *algo, void **ctxp)
+{
+	int ret;
+	mbedtls_sha1_context *ctx = malloc(sizeof(mbedtls_sha1_context));
+
+	mbedtls_sha1_init(ctx);
+	ret = mbedtls_sha1_starts(ctx);
+	if (!ret) {
+		*ctxp = ctx;
+	} else {
+		mbedtls_sha1_free(ctx);
+		free(ctx);
+	}
+
+	return ret;
+}
+
+static int hash_update_sha1(struct hash_algo *algo, void *ctx, const void *buf,
+			    unsigned int size, int is_last)
+{
+	return mbedtls_sha1_update((mbedtls_sha1_context *)ctx, buf, size);
+}
+
+static int
+hash_finish_sha1(struct hash_algo *algo, void *ctx, void *dest_buf, int size)
+{
+	int ret;
+
+	if (size < algo->digest_size)
+		return -1;
+
+	ret = mbedtls_sha1_finish((mbedtls_sha1_context *)ctx, dest_buf);
+	if (!ret) {
+		mbedtls_sha1_free((mbedtls_sha1_context *)ctx);
+		free(ctx);
+	}
+
+	return ret;
+}
+
+static int hash_init_sha256(struct hash_algo *algo, void **ctxp)
+{
+	int ret;
+	int is224 = algo->digest_size == SHA224_SUM_LEN ? 1 : 0;
+	mbedtls_sha256_context *ctx = malloc(sizeof(mbedtls_sha256_context));
+
+	mbedtls_sha256_init(ctx);
+	ret = mbedtls_sha256_starts(ctx, is224);
+	if (!ret) {
+		*ctxp = ctx;
+	} else {
+		mbedtls_sha256_free(ctx);
+		free(ctx);
+	}
+
+	return ret;
+}
+
+static int hash_update_sha256(struct hash_algo *algo, void *ctx, const void *buf,
+			      uint size, int is_last)
+{
+	return mbedtls_sha256_update((mbedtls_sha256_context *)ctx, buf, size);
+}
+
+static int
+hash_finish_sha256(struct hash_algo *algo, void *ctx, void *dest_buf, int size)
+{
+	int ret;
+
+	if (size < algo->digest_size)
+		return -1;
+
+	ret = mbedtls_sha256_finish((mbedtls_sha256_context *)ctx, dest_buf);
+	if (!ret) {
+		mbedtls_sha256_free((mbedtls_sha256_context *)ctx);
+		free(ctx);
+	}
+
+	return ret;
+}
+
+static int hash_init_sha512(struct hash_algo *algo, void **ctxp)
+{
+	int ret;
+	int is384 = algo->digest_size == SHA384_SUM_LEN ? 1 : 0;
+	mbedtls_sha512_context *ctx = malloc(sizeof(mbedtls_sha512_context));
+
+	mbedtls_sha512_init(ctx);
+	ret = mbedtls_sha512_starts(ctx, is384);
+	if (!ret) {
+		*ctxp = ctx;
+	} else {
+		mbedtls_sha512_free(ctx);
+		free(ctx);
+	}
+
+	return ret;
+}
+
+static int hash_update_sha512(struct hash_algo *algo, void *ctx, const void *buf,
+			      uint size, int is_last)
+{
+	return mbedtls_sha512_update((mbedtls_sha512_context *)ctx, buf, size);
+}
+
+static int
+hash_finish_sha512(struct hash_algo *algo, void *ctx, void *dest_buf, int size)
+{
+	int ret;
+
+	if (size < algo->digest_size)
+		return -1;
+
+	ret = mbedtls_sha512_finish((mbedtls_sha512_context *)ctx, dest_buf);
+	if (!ret) {
+		mbedtls_sha512_free((mbedtls_sha512_context *)ctx);
+		free(ctx);
+	}
+
+	return ret;
+}
+
+#else /* CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO) */
 
 static int __maybe_unused hash_init_sha1(struct hash_algo *algo, void **ctxp)
 {
@@ -144,6 +277,8 @@ static int __maybe_unused hash_finish_sha512(struct hash_algo *algo, void *ctx,
 	return 0;
 }
 
+#endif /* CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO) */
+
 static int hash_init_crc16_ccitt(struct hash_algo *algo, void **ctxp)
 {
 	uint16_t *ctx = malloc(sizeof(uint16_t));
@@ -209,7 +344,11 @@ static struct hash_algo hash_algo[] = {
 		.name		= "md5",
 		.digest_size	= MD5_SUM_LEN,
 		.chunk_size	= CHUNKSZ_MD5,
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
+		.hash_func_ws	= md5_wd_mb,
+#else
 		.hash_func_ws	= md5_wd,
+#endif
 	},
 #endif
 #if CONFIG_IS_ENABLED(SHA1)
@@ -219,9 +358,13 @@ static struct hash_algo hash_algo[] = {
 		.chunk_size	= CHUNKSZ_SHA1,
 #if CONFIG_IS_ENABLED(SHA_HW_ACCEL)
 		.hash_func_ws	= hw_sha1,
+#else
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
+		.hash_func_ws	= sha1_csum_wd_mb,
 #else
 		.hash_func_ws	= sha1_csum_wd,
 #endif
+#endif
 #if CONFIG_IS_ENABLED(SHA_PROG_HW_ACCEL)
 		.hash_init	= hw_sha_init,
 		.hash_update	= hw_sha_update,
@@ -240,9 +383,13 @@ static struct hash_algo hash_algo[] = {
 		.chunk_size	= CHUNKSZ_SHA256,
 #if CONFIG_IS_ENABLED(SHA_HW_ACCEL)
 		.hash_func_ws	= hw_sha256,
+#else
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
+		.hash_func_ws	= sha256_csum_wd_mb,
 #else
 		.hash_func_ws	= sha256_csum_wd,
 #endif
+#endif
 #if CONFIG_IS_ENABLED(SHA_PROG_HW_ACCEL)
 		.hash_init	= hw_sha_init,
 		.hash_update	= hw_sha_update,
@@ -261,17 +408,27 @@ static struct hash_algo hash_algo[] = {
 		.chunk_size	= CHUNKSZ_SHA384,
 #if CONFIG_IS_ENABLED(SHA512_HW_ACCEL)
 		.hash_func_ws	= hw_sha384,
+#else
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
+		.hash_func_ws	= sha384_csum_wd_mb,
 #else
 		.hash_func_ws	= sha384_csum_wd,
 #endif
+#endif
 #if CONFIG_IS_ENABLED(SHA512_HW_ACCEL) && CONFIG_IS_ENABLED(SHA_PROG_HW_ACCEL)
 		.hash_init	= hw_sha_init,
 		.hash_update	= hw_sha_update,
 		.hash_finish	= hw_sha_finish,
+#else
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
+		.hash_init	= hash_init_sha512,
+		.hash_update	= hash_update_sha512,
+		.hash_finish	= hash_finish_sha512,
 #else
 		.hash_init	= hash_init_sha384,
 		.hash_update	= hash_update_sha384,
 		.hash_finish	= hash_finish_sha384,
+#endif
 #endif
 	},
 #endif
@@ -282,9 +439,13 @@ static struct hash_algo hash_algo[] = {
 		.chunk_size	= CHUNKSZ_SHA512,
 #if CONFIG_IS_ENABLED(SHA512_HW_ACCEL)
 		.hash_func_ws	= hw_sha512,
+#else
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
+		.hash_func_ws	= sha512_csum_wd_mb,
 #else
 		.hash_func_ws	= sha512_csum_wd,
 #endif
+#endif
 #if CONFIG_IS_ENABLED(SHA512_HW_ACCEL) && CONFIG_IS_ENABLED(SHA_PROG_HW_ACCEL)
 		.hash_init	= hw_sha_init,
 		.hash_update	= hw_sha_update,
diff --git a/include/u-boot/hash-checksum.h b/include/u-boot/hash-checksum.h
index bcc6ba48fc..7f898b0b35 100644
--- a/include/u-boot/hash-checksum.h
+++ b/include/u-boot/hash-checksum.h
@@ -7,9 +7,15 @@
 #define _RSA_CHECKSUM_H
 
 #include <errno.h>
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
+#include <mbedtls/sha1.h>
+#include <mbedtls/sha256.h>
+#include <mbedtls/sha512.h>
+#else
 #include <u-boot/sha1.h>
 #include <u-boot/sha256.h>
 #include <u-boot/sha512.h>
+#endif
 
 struct image_region;
 
-- 
2.25.1

