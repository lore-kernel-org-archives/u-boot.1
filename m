Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A916C3065C
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 18:25:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9537F88746;
	Tue,  2 Jul 2024 20:25:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="G4Y2yYP7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73ECF8874F; Tue,  2 Jul 2024 20:25:49 +0200 (CEST)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 130BB87C86
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 20:25:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-4468ac3c579so3279921cf.0
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 11:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719944745; x=1720549545; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0frUaFhfhvYEuqoBkGLrGtcJfh6dNTq0Uq7TqxarjPY=;
 b=G4Y2yYP7F+vbGFJeQKuj5hyNnxO3mWPdi7JnkZBm4QDmve5kyVroHHD5DkaN7kp7zs
 hWUB7z5ezVLayulV/dLwgJRP7I5nBIuOJoSl6xv87qYYSXRxepyJBJykSBs0W37pm9ro
 6vfUoBwTSuyTnI9lwODqnUKztTgk5lIP2vnadp3lSl3rYhEnrPvqbnWbUqnNfal9flXZ
 OMPaVrdI6qNOE4FlH/93zSUxSyI4YlaxoWUE6abCVuHXqLILbscyh0An1QvPV5NIUWtY
 I6ZOUQFtK5gLLImlA7vGEXNVo14usNWsvuHX1137a+Oa1ACcTncNZcRQEIa+5ciNtpcD
 Oo3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719944745; x=1720549545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0frUaFhfhvYEuqoBkGLrGtcJfh6dNTq0Uq7TqxarjPY=;
 b=hnH3m8nCXVCiiuyID6gvyQck38SLE0qmHXsppOqmLgBxuyiBUvTu1eT2h+kM+Nwg1n
 XZsCoLOt3ImklyTUBciJJZoAoCzU70RLRoR0JX59JCb1ZMgq/jR2pt3pQhF9RwGlSoRV
 hPG++3FBoqeC/+au2sUqXYVT6ifmni6pSvQ8bAxrUutON1O///T/Lvnapp8XQKM4RC5v
 ZkYNyiX9/QPPhZ4dKxBl+vXos7ufWyjfGKN+tBUbrX+1ddfd13qkuihr5Y6oqgWg6YE3
 /DA4XV7pettxF/Mugi9mfPO0ETdyHryznHPatVztC/jhzUTKGUK069UuoIM/IKq3h8/I
 9CpA==
X-Gm-Message-State: AOJu0Yw7XTSYcQAzirFB4olkojMDLgM8YX5rSpvhzz8naplBe4pUusuH
 VltB87iq4F3B60D0R8FMZv31z/nM42hkDGtfEamV6DhIc2CqdcZMd0PC/M1HaDudscWLVrutYfM
 G
X-Google-Smtp-Source: AGHT+IHSkjGqQ6j5cxOCCCbuH001MKrWNoheEL+RYC+EpceAOFBzPL+McIM1THMqIR6T9YglgCRMEQ==
X-Received: by 2002:ac8:5751:0:b0:446:48b5:16c1 with SMTP id
 d75a77b69052e-44662e68b7dmr102867111cf.59.1719944745257; 
 Tue, 02 Jul 2024 11:25:45 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-446514b613dsm43316351cf.84.2024.07.02.11.25.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 11:25:44 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Sergei Antonov <saproj@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v4 04/29] lib: Adapt digest header files to MbedTLS
Date: Tue,  2 Jul 2024 11:22:40 -0700
Message-Id: <20240702182325.2904421-5-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240702182325.2904421-1-raymond.mao@linaro.org>
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
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
by switching on/off MBEDTLS_LIB_CRYPTO.
Introduce <alg>_LEGACY kconfig for legacy hash implementations.

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
Changes in v4
- Introduce <alg>_LEGACY kconfig for legacy hash implementations.
- Minor fix of the include directories.

 include/u-boot/md5.h    |  7 +++
 include/u-boot/sha1.h   | 21 ++++++++-
 include/u-boot/sha256.h | 20 +++++++++
 include/u-boot/sha512.h | 22 ++++++++--
 lib/Makefile            | 10 +++--
 lib/mbedtls/Kconfig     | 96 +++++++++++++++++++++++++++++++++++++++++
 6 files changed, 168 insertions(+), 8 deletions(-)

diff --git a/include/u-boot/md5.h b/include/u-boot/md5.h
index c465925ea8d..69898fcbe49 100644
--- a/include/u-boot/md5.h
+++ b/include/u-boot/md5.h
@@ -6,10 +6,16 @@
 #ifndef _MD5_H
 #define _MD5_H
 
+#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
+#include <mbedtls/md5.h>
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
index c1e9f67068d..ab88134fb98 100644
--- a/include/u-boot/sha1.h
+++ b/include/u-boot/sha1.h
@@ -16,6 +16,21 @@
 
 #include <linux/types.h>
 
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
+#include <mbedtls/sha1.h>
+#endif
+
 #ifdef __cplusplus
 extern "C" {
 #endif
@@ -26,6 +41,9 @@ extern "C" {
 
 extern const uint8_t sha1_der_prefix[];
 
+#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
+typedef mbedtls_sha1_context sha1_context;
+#else
 /**
  * \brief	   SHA-1 context structure
  */
@@ -36,13 +54,14 @@ typedef struct
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
index a4fe176c0b4..b58d5b58d39 100644
--- a/include/u-boot/sha256.h
+++ b/include/u-boot/sha256.h
@@ -3,6 +3,22 @@
 
 #include <linux/types.h>
 
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
+#include <mbedtls/sha256.h>
+#endif
+
+#define SHA224_SUM_LEN	28
 #define SHA256_SUM_LEN	32
 #define SHA256_DER_LEN	19
 
@@ -11,11 +27,15 @@ extern const uint8_t sha256_der_prefix[];
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
index 90bd96a3f8c..2b5a21a7c70 100644
--- a/include/u-boot/sha512.h
+++ b/include/u-boot/sha512.h
@@ -3,6 +3,10 @@
 
 #include <linux/types.h>
 
+#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
+#include <mbedtls/sha512.h>
+#endif
+
 #define SHA384_SUM_LEN          48
 #define SHA384_DER_LEN          19
 #define SHA512_SUM_LEN          64
@@ -12,11 +16,16 @@
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
 
@@ -29,12 +38,19 @@ void sha512_csum_wd(const unsigned char *input, unsigned int ilen,
 
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
index a4600b09f49..f76af77a969 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -69,14 +69,16 @@ obj-$(CONFIG_$(SPL_TPL_)CRC16) += crc16.o
 obj-y += crypto/
 
 obj-$(CONFIG_$(SPL_TPL_)ACPI) += acpi/
-obj-$(CONFIG_$(SPL_)MD5) += md5.o
 obj-$(CONFIG_ECDSA) += ecdsa/
 obj-$(CONFIG_$(SPL_)RSA) += rsa/
 obj-$(CONFIG_HASH) += hash-checksum.o
 obj-$(CONFIG_BLAKE2) += blake2/blake2b.o
-obj-$(CONFIG_$(SPL_)SHA1) += sha1.o
-obj-$(CONFIG_$(SPL_)SHA256) += sha256.o
-obj-$(CONFIG_$(SPL_)SHA512) += sha512.o
+
+obj-$(CONFIG_$(SPL_)MD5_LEGACY) += md5.o
+obj-$(CONFIG_$(SPL_)SHA1_LEGACY) += sha1.o
+obj-$(CONFIG_$(SPL_)SHA256_LEGACY) += sha256.o
+obj-$(CONFIG_$(SPL_)SHA512_LEGACY) += sha512.o
+
 obj-$(CONFIG_CRYPT_PW) += crypt/
 obj-$(CONFIG_$(SPL_)ASN1_DECODER) += asn1_decoder.o
 
diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
index 3e9057f1acf..6662a9d20f1 100644
--- a/lib/mbedtls/Kconfig
+++ b/lib/mbedtls/Kconfig
@@ -21,9 +21,105 @@ if LEGACY_CRYPTO
 
 config LEGACY_CRYPTO_BASIC
 	bool "legacy basic crypto libraries"
+	select MD5_LEGACY if MD5
+	select SHA1_LEGACY if SHA1
+	select SHA256_LEGACY if SHA256
+	select SHA512_LEGACY if SHA512
+	select SHA384_LEGACY if SHA384
+	select SPL_MD5_LEGACY if MD5 && SPL
+	select SPL_SHA1_LEGACY if SHA1 && SPL
+	select SPL_SHA256_LEGACY if SHA256 && SPL
+	select SPL_SHA512_LEGACY if SHA512 && SPL
+	select SPL_SHA384_LEGACY if SHA384 && SPL
 	help
 	  Enable legacy basic crypto libraries.
 
+if LEGACY_CRYPTO_BASIC
+
+config SHA1_LEGACY
+	bool "Enable SHA1 support with legacy crypto library"
+	depends on LEGACY_CRYPTO_BASIC && SHA1
+	help
+	  This option enables support of hashing using SHA1 algorithm
+	  with legacy crypto library.
+
+config SHA256_LEGACY
+	bool "Enable SHA256 support with legacy crypto library"
+	depends on LEGACY_CRYPTO_BASIC && SHA256
+	help
+	  This option enables support of hashing using SHA256 algorithm
+	  with legacy crypto library.
+
+config SHA512_LEGACY
+	bool "Enable SHA512 support with legacy crypto library"
+	depends on LEGACY_CRYPTO_BASIC && SHA512
+	default y if TI_SECURE_DEVICE && FIT_SIGNATURE
+	help
+	  This option enables support of hashing using SHA512 algorithm
+	  with legacy crypto library.
+
+config SHA384_LEGACY
+	bool "Enable SHA384 support with legacy crypto library"
+	depends on LEGACY_CRYPTO_BASIC && SHA384
+	select SHA512_LEGACY
+	help
+	  This option enables support of hashing using SHA384 algorithm
+	  with legacy crypto library.
+
+config MD5_LEGACY
+	bool "Enable MD5 support with legacy crypto library"
+	depends on LEGACY_CRYPTO_BASIC && MD5
+	help
+	  This option enables support of hashing using MD5 algorithm
+	  with legacy crypto library.
+
+if SPL
+
+config SPL_SHA1_LEGACY
+	bool "Enable SHA1 support in SPL with legacy crypto library"
+	depends on LEGACY_CRYPTO_BASIC && SPL_SHA1
+	default y if SHA1 && LEGACY_CRYPTO_BASIC
+	help
+	  This option enables support of hashing using SHA1 algorithm
+	  with legacy crypto library.
+
+config SPL_SHA256_LEGACY
+	bool "Enable SHA256 support in SPL with legacy crypto library"
+	depends on LEGACY_CRYPTO_BASIC && SPL_SHA256
+	default y if SHA256 && LEGACY_CRYPTO_BASIC
+	help
+	  This option enables support of hashing using SHA256 algorithm
+	  with legacy crypto library.
+
+config SPL_SHA512_LEGACY
+	bool "Enable SHA512 support in SPL with legacy crypto library"
+	depends on LEGACY_CRYPTO_BASIC && SPL_SHA512
+	default y if SHA512 && LEGACY_CRYPTO_BASIC
+	help
+	  This option enables support of hashing using SHA512 algorithm
+	  with legacy crypto library.
+
+config SPL_SHA384_LEGACY
+	bool "Enable SHA384 support in SPL with legacy crypto library"
+	depends on LEGACY_CRYPTO_BASIC && SPL_SHA384
+	default y if SHA384 && LEGACY_CRYPTO_BASIC
+	select SPL_SHA512
+	help
+	  This option enables support of hashing using SHA384 algorithm
+	  with legacy crypto library.
+
+config SPL_MD5_LEGACY
+	bool "Enable MD5 support in SPL with legacy crypto library"
+	depends on LEGACY_CRYPTO_BASIC && SPL_MD5
+	default y if MD5 && LEGACY_CRYPTO_BASIC
+	help
+	  This option enables support of hashing using MD5 algorithm
+	  with legacy crypto library.
+
+endif # SPL
+
+endif # LEGACY_CRYPTO_BASIC
+
 config LEGACY_CRYPTO_CERT
 	bool "legacy certificate libraries"
 	help
-- 
2.25.1

