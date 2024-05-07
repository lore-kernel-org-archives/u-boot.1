Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C41A9C25B4F
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 17:55:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 524BB883E6;
	Tue,  7 May 2024 19:55:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="K6pHhpA8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AA94883E8; Tue,  7 May 2024 19:55:01 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2977C8836C
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 19:54:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6a0f889877cso12848956d6.1
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 10:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715104498; x=1715709298; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5RKFv+4QeMhvOZHUPQKbiyDx5uknAZOPw91XAqHBSjU=;
 b=K6pHhpA8PuRpqk//8gCVMAYQ7m8MQwbAZNdh6fEOztIzhH+MKkrhsMNFbC2lu2UIz9
 Y32oKwCudvSTUhLCbU8m+0BfBGbB/bNTRg/L9xPpIDDoE1Od3CP+UvHBCxe/fwMMpu/C
 DzErnvl7pQd60mx+2dVVeMwDEnbgMIY7isbSGiQOPleMN7nYxDqbip7DzeEt+jdgtcbP
 17z9BvkqE5fe7akWH6Hy/6X1o8jwBDluY5gOQvXhH6jZyIj3w5Qm823rVDtbjmvy9P9Y
 tVwWw1uJ3ErbaOkijsT7h/gn4IHsQlTKd4hXa6c+pFp9wSfqSapXOGowkfBF2z4PXmde
 5giA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715104498; x=1715709298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5RKFv+4QeMhvOZHUPQKbiyDx5uknAZOPw91XAqHBSjU=;
 b=Ipp8NpWdkDETQjj6G+EeK55ypN9wbzm/kzSkjWihh/R6vBRHCEA9/BtRYdOasJPfd+
 M1xvZiTM7uDboiV8dQmoiG2a7EqsQPHQuTRWng8QPknuwShPYhPC1AfCh8v278wtVIGG
 7utwtVPhGeevW5vnvML14w12HatgZvVA9RU+LmIt8/vikeK9xgT5Pbo95ZNHb1KA6Dvc
 vB4xo8/HgoRK1VOgCIuRRENjJXP7I0u1VHjU4Q+/hr+vH4Rq8TKhUNY8rj+CaUpI2sWp
 kkv2eoThPXW70NT9LfKEDuzkeTlXtXvug8SrXgzLdwNCwWAQinKbZp91DkeWmXr6sfZ5
 jbWw==
X-Gm-Message-State: AOJu0Yz7qvJCwNNebj9HkMGtkMvV9V6B8+jY6bKHz7k/KEFq3M2OjTB1
 PHKeMzjlY+YYbOAJOFKpwte/BtBU4LwgQeqFRB/CUg1bnbT9ScBUHFMoeold2fYdvyn8zR5JaGE
 D
X-Google-Smtp-Source: AGHT+IEKRsE/prb7ca8nF5WdCr9hHs/OTCMLc29Cg+HC+G38QaxXDhAWNlAe7WR6pinXoMHxA649kA==
X-Received: by 2002:ad4:5be8:0:b0:69b:7f0e:bdc with SMTP id
 6a1803df08f44-6a1514eb028mr5903286d6.30.1715104497767; 
 Tue, 07 May 2024 10:54:57 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-115-4-214.cpe.net.cable.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 o1-20020a0cecc1000000b006a0f126a033sm4801834qvq.28.2024.05.07.10.54.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 10:54:57 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Andrew Davis <afd@ti.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Sergei Antonov <saproj@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilya Lukin <4.shket@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH v2 07/28] lib: Adapt digest header files to MbedTLS
Date: Tue,  7 May 2024 10:50:49 -0700
Message-Id: <20240507175132.1456512-8-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240507175132.1456512-1-raymond.mao@linaro.org>
References: <20240507175132.1456512-1-raymond.mao@linaro.org>
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

Adapt digest header files to support both original libs and MbedTLS
by switching on/off MBEDTLS_LIB_CRYPTO

FIXME:
`IS_ENABLED` or `CONFIG_IS_ENABLED` is not applicable here, since
including <linux/kconfig.h> causes undefined reference on schedule()
with sandbox build.
As <linux/kconfig.h> includes <generated/autoconf.h> which enables
`CONFIG_HW_WATCHDOG` and `CONFIG_WATCHDOG` but no schedule() are
defined in sandbox build.
`#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)` is a workaround.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Initial patch.

 include/u-boot/md5.h    | 17 ++++++++++++-----
 include/u-boot/sha1.h   | 21 ++++++++++++++++++++-
 include/u-boot/sha256.h | 20 ++++++++++++++++++++
 include/u-boot/sha512.h | 22 +++++++++++++++++++---
 lib/Makefile            |  6 +++++-
 5 files changed, 76 insertions(+), 10 deletions(-)

diff --git a/include/u-boot/md5.h b/include/u-boot/md5.h
index d61364c0ae3..3cfd33a8e56 100644
--- a/include/u-boot/md5.h
+++ b/include/u-boot/md5.h
@@ -6,22 +6,29 @@
 #ifndef _MD5_H
 #define _MD5_H
 
+#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
+#include <external/mbedtls/include/mbedtls/md5.h>
+#endif
 #include "compiler.h"
 
 #define MD5_SUM_LEN	16
 
-struct MD5Context {
+#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
+typedef mbedtls_md5_context MD5Context;
+#else
+typedef struct MD5Context {
 	__u32 buf[4];
 	__u32 bits[2];
 	union {
 		unsigned char in[64];
 		__u32 in32[16];
 	};
-};
+} MD5Context;
+#endif
 
-void MD5Init(struct MD5Context *ctx);
-void MD5Update(struct MD5Context *ctx, unsigned char const *buf, unsigned len);
-void MD5Final(unsigned char digest[16], struct MD5Context *ctx);
+void MD5Init(MD5Context *ctx);
+void MD5Update(MD5Context *ctx, unsigned char const *buf, unsigned int len);
+void MD5Final(unsigned char digest[16], MD5Context *ctx);
 
 /*
  * Calculate and store in 'output' the MD5 digest of 'len' bytes at
diff --git a/include/u-boot/sha1.h b/include/u-boot/sha1.h
index 09fee594d26..ee46fe947a0 100644
--- a/include/u-boot/sha1.h
+++ b/include/u-boot/sha1.h
@@ -14,6 +14,21 @@
 #ifndef _SHA1_H
 #define _SHA1_H
 
+#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
+/*
+ * FIXME:
+ * MbedTLS define the members of "mbedtls_sha256_context" as private,
+ * but "state" needs to be access by arch/arm/cpu/armv8/sha1_ce_glue.
+ * MBEDTLS_ALLOW_PRIVATE_ACCESS needs to be enabled to allow the external
+ * access.
+ * Directly including <external/mbedtls/library/common.h> is not allowed,
+ * since this will include <malloc.h> and break the sandbox test.
+ */
+#define MBEDTLS_ALLOW_PRIVATE_ACCESS
+
+#include <external/mbedtls/include/mbedtls/sha1.h>
+#endif
+
 #ifdef __cplusplus
 extern "C" {
 #endif
@@ -24,6 +39,9 @@ extern "C" {
 
 extern const uint8_t sha1_der_prefix[];
 
+#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
+typedef mbedtls_sha1_context sha1_context;
+#else
 /**
  * \brief	   SHA-1 context structure
  */
@@ -34,13 +52,14 @@ typedef struct
     unsigned char buffer[64];	/*!< data block being processed */
 }
 sha1_context;
+#endif
 
 /**
  * \brief	   SHA-1 context setup
  *
  * \param ctx	   SHA-1 context to be initialized
  */
-void sha1_starts( sha1_context *ctx );
+void sha1_starts(sha1_context *ctx);
 
 /**
  * \brief	   SHA-1 process buffer
diff --git a/include/u-boot/sha256.h b/include/u-boot/sha256.h
index 9aa1251789a..e2b7fdd41c8 100644
--- a/include/u-boot/sha256.h
+++ b/include/u-boot/sha256.h
@@ -1,6 +1,22 @@
 #ifndef _SHA256_H
 #define _SHA256_H
 
+#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
+/*
+ * FIXME:
+ * MbedTLS define the members of "mbedtls_sha256_context" as private,
+ * but "state" needs to be access by arch/arm/cpu/armv8/sha256_ce_glue.
+ * MBEDTLS_ALLOW_PRIVATE_ACCESS needs to be enabled to allow the external
+ * access.
+ * Directly including <external/mbedtls/library/common.h> is not allowed,
+ * since this will include <malloc.h> and break the sandbox test.
+ */
+#define MBEDTLS_ALLOW_PRIVATE_ACCESS
+
+#include <external/mbedtls/include/mbedtls/sha256.h>
+#endif
+
+#define SHA224_SUM_LEN	28
 #define SHA256_SUM_LEN	32
 #define SHA256_DER_LEN	19
 
@@ -9,11 +25,15 @@ extern const uint8_t sha256_der_prefix[];
 /* Reset watchdog each time we process this many bytes */
 #define CHUNKSZ_SHA256	(64 * 1024)
 
+#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
+typedef mbedtls_sha256_context sha256_context;
+#else
 typedef struct {
 	uint32_t total[2];
 	uint32_t state[8];
 	uint8_t buffer[64];
 } sha256_context;
+#endif
 
 void sha256_starts(sha256_context * ctx);
 void sha256_update(sha256_context *ctx, const uint8_t *input, uint32_t length);
diff --git a/include/u-boot/sha512.h b/include/u-boot/sha512.h
index 516729d7750..a0c0de89d60 100644
--- a/include/u-boot/sha512.h
+++ b/include/u-boot/sha512.h
@@ -1,6 +1,10 @@
 #ifndef _SHA512_H
 #define _SHA512_H
 
+#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
+#include <external/mbedtls/include/mbedtls/sha512.h>
+#endif
+
 #define SHA384_SUM_LEN          48
 #define SHA384_DER_LEN          19
 #define SHA512_SUM_LEN          64
@@ -10,11 +14,16 @@
 #define CHUNKSZ_SHA384	(16 * 1024)
 #define CHUNKSZ_SHA512	(16 * 1024)
 
+#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
+typedef mbedtls_sha512_context sha384_context;
+typedef mbedtls_sha512_context sha512_context;
+#else
 typedef struct {
 	uint64_t state[SHA512_SUM_LEN / 8];
 	uint64_t count[2];
 	uint8_t buf[SHA512_BLOCK_SIZE];
 } sha512_context;
+#endif
 
 extern const uint8_t sha512_der_prefix[];
 
@@ -27,12 +36,19 @@ void sha512_csum_wd(const unsigned char *input, unsigned int ilen,
 
 extern const uint8_t sha384_der_prefix[];
 
+#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
+void sha384_starts(sha512_context *ctx);
+void
+sha384_update(sha512_context *ctx, const uint8_t *input, uint32_t length);
+void sha384_finish(sha512_context *ctx, uint8_t digest[SHA384_SUM_LEN]);
+void sha384_csum_wd(const unsigned char *input, unsigned int length,
+		    unsigned char *output, unsigned int chunk_sz);
+#else
 void sha384_starts(sha512_context * ctx);
 void sha384_update(sha512_context *ctx, const uint8_t *input, uint32_t length);
 void sha384_finish(sha512_context * ctx, uint8_t digest[SHA384_SUM_LEN]);
 
 void sha384_csum_wd(const unsigned char *input, unsigned int ilen,
-		unsigned char *output, unsigned int chunk_sz);
-
-
+		    unsigned char *output, unsigned int chunk_sz);
+#endif
 #endif /* _SHA512_H */
diff --git a/lib/Makefile b/lib/Makefile
index a4600b09f49..3534b3301ae 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -69,14 +69,18 @@ obj-$(CONFIG_$(SPL_TPL_)CRC16) += crc16.o
 obj-y += crypto/
 
 obj-$(CONFIG_$(SPL_TPL_)ACPI) += acpi/
-obj-$(CONFIG_$(SPL_)MD5) += md5.o
 obj-$(CONFIG_ECDSA) += ecdsa/
 obj-$(CONFIG_$(SPL_)RSA) += rsa/
 obj-$(CONFIG_HASH) += hash-checksum.o
 obj-$(CONFIG_BLAKE2) += blake2/blake2b.o
+
+ifneq ($(CONFIG_MBEDTLS_LIB_CRYPTO), y)
+obj-$(CONFIG_$(SPL_)MD5) += md5.o
 obj-$(CONFIG_$(SPL_)SHA1) += sha1.o
 obj-$(CONFIG_$(SPL_)SHA256) += sha256.o
 obj-$(CONFIG_$(SPL_)SHA512) += sha512.o
+endif
+
 obj-$(CONFIG_CRYPT_PW) += crypt/
 obj-$(CONFIG_$(SPL_)ASN1_DECODER) += asn1_decoder.o
 
-- 
2.25.1

