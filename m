Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A617C25B7C
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 14:11:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D305884C8;
	Tue, 28 May 2024 16:11:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="r+/1Afp+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64082884EF; Tue, 28 May 2024 16:11:41 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D1D887D70
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 16:11:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-79305314956so64457085a.3
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 07:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716905498; x=1717510298; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nxhaA6lR0BhMLSj/nBxoiLf8pbp5N0odf9jomF0F48A=;
 b=r+/1Afp+Zl8pdGRYmPq8jFuPKJSLiLO8TNWZS7/QKzVmulkkXw7HHmrhzbiQOWRhOm
 KrT+fJVVmc3q/tO/Vh/blyJHSqgf2WBRlIqh0Aa6RF+Yeo+YpGLzQIl661+48zTWlkMP
 pveJKDankiQqTMCtZnc0jyhUC5YH0CImINXY5TdlbkxXitxtiKZeqfO8Ofl4/6TOIMuT
 Nsw7YH/QflqcksY8LMlXK9zGfuG15bI4Zrd3Licnvh9wJot0UaAxNQTkILAEV9Z2hC9o
 L5NUM6PrQPcFAaarjGXy5e2FpiU3jcpbZKl0ddM5BwYAmUdDzrRYcNQoRIispQ9kX4dR
 fuxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716905498; x=1717510298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nxhaA6lR0BhMLSj/nBxoiLf8pbp5N0odf9jomF0F48A=;
 b=fq0mSX0C9QY8KR6uYZ74SYzgtmgbioUWVaNHriAJKNGTECkQ6kONHVFH8upobzyxXU
 9aMxs9EZO9guewxBmP/YtNr7Wnj564iylQWtiCjCrs5FHbJKDRHvK0rs3g+ub6R6bjsB
 K61avDba40ivhKdqBerWn8gaA5RVEZlTFUO0w00BsdSgZfa6NKps7LPvVos693HUjXNP
 Ac1IaKyNr3VJTW8fDQqkY57+TdVPZy6ecjtbvxGsg+9VcFfDPk2dlZzEA3aJyAqLBBEy
 wKSDPN5dflSMDKRQ2N80n55S9zK/JWjNlrAupYj2PU9fZuNOhsjeuuCgzl0XWffRn8FA
 nodw==
X-Gm-Message-State: AOJu0YzaRxqq/VQIkizECmzYk3+I8Har2PJ4Tsn/edse6UFKd/aAz7U8
 zhMpQjc8Fz3xJgq3e8xUWs43syuxs6NxOuj75C/gOkyXsqgMF6c4d2BwhZV9sfFZi5U6gyiAxBC
 l5dk=
X-Google-Smtp-Source: AGHT+IEEbHqe8WAE1B/f/V3PfxwDBOfK1QuaiajWiX7cPSg+OQMfamFTQeKRn3fIALzOHLECKuRG8Q==
X-Received: by 2002:a05:620a:d4c:b0:794:afb0:6bcb with SMTP id
 af79cd13be357-794afb06bf0mr1036231385a.42.1716905497750; 
 Tue, 28 May 2024 07:11:37 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794abcc5844sm381033685a.53.2024.05.28.07.11.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:11:37 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Stefan Bosch <stefan_b@posteo.net>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Sergei Antonov <saproj@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v3 04/25] lib: Adapt digest header files to MbedTLS
Date: Tue, 28 May 2024 07:09:15 -0700
Message-Id: <20240528140955.1960172-5-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240528140955.1960172-1-raymond.mao@linaro.org>
References: <20240528140955.1960172-1-raymond.mao@linaro.org>
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
Changes in v3
- Remove the changes that were done in previous clean-up patch set.

 include/u-boot/md5.h    |  7 +++++++
 include/u-boot/sha1.h   | 21 ++++++++++++++++++++-
 include/u-boot/sha256.h | 20 ++++++++++++++++++++
 include/u-boot/sha512.h | 22 +++++++++++++++++++---
 lib/Makefile            |  6 +++++-
 5 files changed, 71 insertions(+), 5 deletions(-)

diff --git a/include/u-boot/md5.h b/include/u-boot/md5.h
index c465925ea8d..3cfd33a8e56 100644
--- a/include/u-boot/md5.h
+++ b/include/u-boot/md5.h
@@ -6,10 +6,16 @@
 #ifndef _MD5_H
 #define _MD5_H
 
+#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
+#include <external/mbedtls/include/mbedtls/md5.h>
+#endif
 #include "compiler.h"
 
 #define MD5_SUM_LEN	16
 
+#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
+typedef mbedtls_md5_context MD5Context;
+#else
 typedef struct MD5Context {
 	__u32 buf[4];
 	__u32 bits[2];
@@ -18,6 +24,7 @@ typedef struct MD5Context {
 		__u32 in32[16];
 	};
 } MD5Context;
+#endif
 
 void MD5Init(MD5Context *ctx);
 void MD5Update(MD5Context *ctx, unsigned char const *buf, unsigned int len);
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

