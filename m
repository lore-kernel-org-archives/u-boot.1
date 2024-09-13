Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8A3FC6186
	for <u-boot@archiver.kernel.org>; Sat, 14 Sep 2024 01:05:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F71288CE7;
	Sat, 14 Sep 2024 03:04:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="H+cWT5Xr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA4B088706; Fri, 13 Sep 2024 18:05:52 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22019887BB
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 18:05:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6c54b1f52f7so14362306d6.3
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 09:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726243548; x=1726848348; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9s99SIz8p0+K4CxT7VafLsCzBPKXQBuzf+CzaVUunf0=;
 b=H+cWT5XrS4nuv42DRgZPSPE5O6c6hSDBgUzgGFTuln4CNixqw2baHhxwIhkvee3802
 fLgms/b+tOTXjQSMCUX6GkY+QHIgY7ft+kyCU5ab6VZKRII9Pg7jyQfqAFCC1LqzrPva
 kP+0fIQ3rhX358ZlS83xb+iRrHo7GLYSc4sDcqyDHKe1tjo4EnrgbauaViq1BIOab1EO
 nrodGCf9CLfVQiHaqvkr5oGpRxqMTeb+gV+kcrCzxVsOXHrtDOOhA86kmtPKDSkjVlSO
 wMGW2sTwlD/ZS/SRBFxz2B5+TjwzDVRBZXNjSfjo96YdB9GxNaLlhbITMsVbhIR8pWAn
 XIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726243548; x=1726848348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9s99SIz8p0+K4CxT7VafLsCzBPKXQBuzf+CzaVUunf0=;
 b=Iu0rf7y1pcc8kVJSSwmbyfYPPR2+egdrU7hHrHPv9TzPHZ5vY6BqbJyfasNbbaQHKc
 8m+WB7tTF+nY5b2KiWy89SGzFEFCgZhA1qGrTJNnfAYwcRvkV+QF8pWI/5Li6kiPBeBL
 76fq99auoasmmw0ngO5T32nCA5K0PVblY4GIcUhf7KK5cLXc5PvkhKqsXViKf74DI148
 pCHgEdx8SLDOnwDwLEY3pNki6KjpDECQvGnQYuNEXpA93nOZiTWpG7zJRo/dNJkXsZyC
 ef1e3Gr8UHaDoVrp0noX+JPDAJt/ZZI0zV02fxjXb+Pm4QaZiX4aK7xKIVfr3k+MI1NK
 nahQ==
X-Gm-Message-State: AOJu0YzqUuZDCGS6MOGENP8V+VoybIvypUMOzKOk0zuuePgmzluhldpd
 vWTPPQMw4wREhVBpJ+ywj3ZlAybrG5DG/EChwirfgGIgDFA2Y6MkTzGo9xiwa0WPz6pKf7E3/gm
 2
X-Google-Smtp-Source: AGHT+IHdB6ZQnw3VO6Uw9+NQxVfkfAqoXwCUlzm0A2YxFeqIJLrXIthGlYaJMwoPPYWEz8kL+Yn2Xg==
X-Received: by 2002:a05:6214:5b86:b0:6c5:4b90:b5ce with SMTP id
 6a1803df08f44-6c57352f5eamr105448346d6.24.1726243547627; 
 Fri, 13 Sep 2024 09:05:47 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c534774908sm67697286d6.118.2024.09.13.09.05.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 09:05:47 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Sumit Garg <sumit.garg@linaro.org>, Sean Anderson <seanga2@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Kongyang Liu <seashell11234455@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v7 03/27] lib: Adapt digest header files to MbedTLS
Date: Fri, 13 Sep 2024 09:03:20 -0700
Message-Id: <20240913160408.2199558-4-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240913160408.2199558-1-raymond.mao@linaro.org>
References: <20240913160408.2199558-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 14 Sep 2024 03:04:24 +0200
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
sha256.o should depend on SHA256 kconfig only but not SUPPORT_EMMC_RPMB,
SHA256 should be selected when SUPPORT_EMMC_RPMB is enabled instead.

`IS_ENABLED` or `CONFIG_IS_ENABLED` is not applicable here, since
including <linux/kconfig.h> causes undefined reference on schedule()
with sandbox build, as <linux/kconfig.h> includes <generated/autoconf.h>
which enables `CONFIG_HW_WATCHDOG` and `CONFIG_WATCHDOG` but no schedule()
are defined in sandbox build,
Thus we use `#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)` instead.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v2
- Initial patch.
Changes in v3
- Remove the changes that were done in previous clean-up patch set.
Changes in v4
- Introduce <alg>_LEGACY kconfig for legacy hash implementations.
Changes in v5
- Correct header file include directories.
- Correct kconfig dependence.
Changes in v6
- Update commit message.
- Rebased on next branch.
Changes in v7
- Fixed the dependency between SUPPORT_EMMC_RPMB and SHA256.

 drivers/mmc/Kconfig     |  1 +
 include/u-boot/md5.h    |  7 ++++
 include/u-boot/sha1.h   | 21 +++++++++-
 include/u-boot/sha256.h | 20 +++++++++
 include/u-boot/sha512.h |  9 ++++
 lib/Makefile            | 11 ++---
 lib/mbedtls/Kconfig     | 91 +++++++++++++++++++++++++++++++++++++++++
 7 files changed, 154 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index 982e84dc3bc..5d7fd904950 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -119,6 +119,7 @@ config MMC_HW_PARTITIONING
 config SUPPORT_EMMC_RPMB
 	bool "Support eMMC replay protected memory block (RPMB)"
 	imply CMD_MMC_RPMB
+	select SHA256
 	help
 	  Enable support for reading, writing and programming the
 	  key for the Replay Protection Memory Block partition in eMMC.
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
index 83c2119cd26..7e10f590a1d 100644
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
 
diff --git a/lib/Makefile b/lib/Makefile
index c4950b78a29..33755778283 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -50,7 +50,6 @@ obj-$(CONFIG_XXHASH) += xxhash.o
 obj-y += net_utils.o
 obj-$(CONFIG_PHYSMEM) += physmem.o
 obj-y += rc4.o
-obj-$(CONFIG_SUPPORT_EMMC_RPMB) += sha256.o
 obj-$(CONFIG_RBTREE)	+= rbtree.o
 obj-$(CONFIG_BITREVERSE) += bitrev.o
 obj-y += list_sort.o
@@ -71,14 +70,16 @@ obj-$(CONFIG_$(SPL_TPL_)CRC16) += crc16.o
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
index 3e9057f1acf..efae2c4fd72 100644
--- a/lib/mbedtls/Kconfig
+++ b/lib/mbedtls/Kconfig
@@ -21,9 +21,100 @@ if LEGACY_CRYPTO
 
 config LEGACY_CRYPTO_BASIC
 	bool "legacy basic crypto libraries"
+	select MD5_LEGACY if MD5
+	select SHA1_LEGACY if SHA1
+	select SHA256_LEGACY if SHA256
+	select SHA512_LEGACY if SHA512
+	select SHA384_LEGACY if SHA384
+	select SPL_MD5_LEGACY if SPL_MD5
+	select SPL_SHA1_LEGACY if SPL_SHA1
+	select SPL_SHA256_LEGACY if SPL_SHA256
+	select SPL_SHA512_LEGACY if SPL_SHA512
+	select SPL_SHA384_LEGACY if SPL_SHA384
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
+	help
+	  This option enables support of hashing using SHA1 algorithm
+	  with legacy crypto library.
+
+config SPL_SHA256_LEGACY
+	bool "Enable SHA256 support in SPL with legacy crypto library"
+	depends on LEGACY_CRYPTO_BASIC && SPL_SHA256
+	help
+	  This option enables support of hashing using SHA256 algorithm
+	  with legacy crypto library.
+
+config SPL_SHA512_LEGACY
+	bool "Enable SHA512 support in SPL with legacy crypto library"
+	depends on LEGACY_CRYPTO_BASIC && SPL_SHA512
+	help
+	  This option enables support of hashing using SHA512 algorithm
+	  with legacy crypto library.
+
+config SPL_SHA384_LEGACY
+	bool "Enable SHA384 support in SPL with legacy crypto library"
+	depends on LEGACY_CRYPTO_BASIC && SPL_SHA384
+	select SPL_SHA512_LEGACY
+	help
+	  This option enables support of hashing using SHA384 algorithm
+	  with legacy crypto library.
+
+config SPL_MD5_LEGACY
+	bool "Enable MD5 support in SPL with legacy crypto library"
+	depends on LEGACY_CRYPTO_BASIC && SPL_MD5
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

