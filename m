Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 405BDC52D7D
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 21:45:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AB3588C17;
	Fri, 16 Aug 2024 23:45:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uZ6Ji0Pw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AC2688C17; Fri, 16 Aug 2024 23:45:38 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1B3F88C13
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 23:45:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6bf6beda0c0so14227856d6.1
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 14:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723844734; x=1724449534; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rRB23vjtGaqZ2u78/cg3JzKWyms9EQ7M55ktgpr60oc=;
 b=uZ6Ji0PwTpOJjz9ZJr8Sme+YQvNwa+mlsOP8dL6pYv158BhYI10BJJNXcRiEFM61a3
 MkjUKjxX7x4iKmd7L+py5ejOAWnHQveExATEUqOyuq10Wwpruhk3Kb8EZ5yVpTBT8cYP
 alrjt/YFi40r6+odil211fhdPFRuk1YjfDOYYnzw/CgXXYm2lXd4v8z7qg8DOWjdYGl8
 u39VvNtmu+f0Sf8zS9N572pWC0HCHVgAYzW1/pantXM+uIUZKumQWNODGD2E42pJM/GW
 d+1/4jl+FxBpAt59PeRVh4j1nG3lFTEcd1lKRAq/d4d1vvhxNqlmHFADGcj6NnFYebYg
 WQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723844734; x=1724449534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rRB23vjtGaqZ2u78/cg3JzKWyms9EQ7M55ktgpr60oc=;
 b=l6olGThiw5xhlC9WNgyP+O3lF90quT88sQAwetI1vS+kinq9DdT3sFCX4eipWS2lQZ
 E+pAfNxkP68sgvfrckFdQka+qMWON6g8LXvcXNvFqAHZe5kWFozhL0BBpEJBW4y81QqW
 Je8NbzCsNhZy7v7HGoWbYBr0eI2pNDb2jkf5pas4nz6of+yql02R0E/1qkCgw8sQrch5
 kY43CAB/K8yqUblQvBXaJpdfoiHgGhW1/Rv3PMgIo1nuADrE687Yqjf7gfebUfv5ZA6h
 9xWyuJ2cUoF56/jpaTQtZfbgUfzhv0a/SxOdvSaYw6WLJXgI3GvbXBQaaWQl5Nj4RTW1
 qs5A==
X-Gm-Message-State: AOJu0Yxs5uY2tX9cmJ7KsiMoPP/AVhJtZ01P1RBbDUcYYmAxXXV1hDEE
 gzj3p86HeN4vp0W27+H945MmvMEPsvLSDR0noaTnRnJrZwgz3/KMt9ET0UtbhPypUhRksxlkX/v
 VFrs=
X-Google-Smtp-Source: AGHT+IHTyOKCHUzKmsNb043ho9vsE3CewS6aWACoMSj2rcA+LOndwAqv+MuyaPoWPnamvrJadViWyA==
X-Received: by 2002:a05:6214:598c:b0:6bf:6b15:a6da with SMTP id
 6a1803df08f44-6bf894e6716mr12104226d6.25.1723844734331; 
 Fri, 16 Aug 2024 14:45:34 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bf6ff04ffbsm22044196d6.128.2024.08.16.14.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 14:45:33 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Andrew Davis <afd@ti.com>,
 Sumit Garg <sumit.garg@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Anand Moon <linux.amoon@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v6 02/28] mbedtls: add mbedtls into the build system
Date: Fri, 16 Aug 2024 14:43:51 -0700
Message-Id: <20240816214436.1877263-3-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240816214436.1877263-1-raymond.mao@linaro.org>
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
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

Port mbedtls with adapted libc header files.
Add mbedtls default config header file.
Optimize mbedtls default config by disabling unused features to
reduce the target size.
Add mbedtls kbuild makefile.
Add Kconfig skeleton and config submenu entry for selecting
crypto libraries between mbedtls and legacy ones.
Add the mbedtls include directories into the build system.

Subsequent patches will separate those Kconfigs into pairs of
_LEGACY and _MBEDTLS for controlling the implementations of legacy
crypto libraries and MbedTLS ones respectively.

The motivation of moving and adapting *INT* macros from kernel.h
to limits.h is to fullfill the MbedTLS building requirement.
The conditional compilation statements in MbedTLS expects the
*INT* macros as constant expressions, thus expressions like
`((int)(~0U >> 1))` will not work.

Prerequisite
------------

This patch series requires mbedtls git repo to be added as a
subtree to the main U-Boot repo via:

$ git subtree add --prefix lib/mbedtls/external/mbedtls \
      https://github.com/Mbed-TLS/mbedtls.git \
      v3.6.0 --squash

Moreover, due to the Windows-style files from mbedtls git repo,
we need to convert the CRLF endings to LF and do a commit manually:

$ git add --renormalize .
$ git commit

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Disabled unused MbedTLS features to optimize the target size.
Changes in v3
- Removed changes in stdio.h.
Changes in v4
- Move limits.h as a common header file that is included by kernel.h.
- Refactor the Kconfig to support legacy and MbedTLS options for each
  algorithm.
- Refactor MbedTLS makefile and default config file to remove unused
  config options and objects.
Changes in v5
- Merged patch #9 of v4 into this patch.
- Removed unused config MBEDTLS_LIB_TLS.
- Refactored MbedTLS Makefile and default config file.
Changes in v6
- Fixed UINT64_MAX.
- Removed copy right statement from limits.h

 Makefile                         |  6 +++
 include/limits.h                 | 25 ++++++++++++
 include/linux/kernel.h           | 13 +-----
 include/stdlib.h                 |  1 +
 lib/Kconfig                      |  4 ++
 lib/Makefile                     |  2 +
 lib/mbedtls/Kconfig              | 47 ++++++++++++++++++++++
 lib/mbedtls/Makefile             | 41 +++++++++++++++++++
 lib/mbedtls/mbedtls_def_config.h | 69 ++++++++++++++++++++++++++++++++
 lib/mbedtls/port/assert.h        | 12 ++++++
 10 files changed, 208 insertions(+), 12 deletions(-)
 create mode 100644 include/limits.h
 create mode 100644 lib/mbedtls/Kconfig
 create mode 100644 lib/mbedtls/Makefile
 create mode 100644 lib/mbedtls/mbedtls_def_config.h
 create mode 100644 lib/mbedtls/port/assert.h

diff --git a/Makefile b/Makefile
index b35a472d9be..3c506c299a1 100644
--- a/Makefile
+++ b/Makefile
@@ -829,6 +829,12 @@ KBUILD_HOSTCFLAGS += $(if $(CONFIG_TOOLS_DEBUG),-g)
 UBOOTINCLUDE    := \
 	-Iinclude \
 	$(if $(KBUILD_SRC), -I$(srctree)/include) \
+	$(if $(CONFIG_MBEDTLS_LIB), \
+		"-DMBEDTLS_CONFIG_FILE=\"mbedtls_def_config.h\"" \
+		-I$(srctree)/lib/mbedtls \
+		-I$(srctree)/lib/mbedtls/port \
+		-I$(srctree)/lib/mbedtls/external/mbedtls \
+		-I$(srctree)/lib/mbedtls/external/mbedtls/include) \
 	$(if $(CONFIG_$(SPL_)SYS_THUMB_BUILD), \
 		$(if $(CONFIG_HAS_THUMB2), \
 			$(if $(CONFIG_CPU_V7M), \
diff --git a/include/limits.h b/include/limits.h
new file mode 100644
index 00000000000..be219ddbfca
--- /dev/null
+++ b/include/limits.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef _LIMITS_H
+#define _LIMITS_H
+
+#define INT_MAX     0x7fffffff
+#define UINT_MAX    0xffffffffUL
+#define CHAR_BIT    8
+#define UINT32_MAX  0xffffffffUL
+#define UINT64_MAX  0xffffffffffffffffULL
+
+#ifdef CONFIG_64BIT
+    #define UINTPTR_MAX UINT64_MAX
+#else
+    #define UINTPTR_MAX UINT32_MAX
+#endif
+
+#ifndef SIZE_MAX
+#define SIZE_MAX    UINTPTR_MAX
+#endif
+#ifndef SSIZE_MAX
+#define SSIZE_MAX   ((ssize_t)(SIZE_MAX >> 1))
+#endif
+
+#endif /* _LIMITS_H */
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 939465f372b..9467edd65ab 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -3,25 +3,18 @@
 
 #include <linux/types.h>
 #include <linux/printk.h> /* for printf/pr_* utilities */
+#include <limits.h>
 
 #define USHRT_MAX	((u16)(~0U))
 #define SHRT_MAX	((s16)(USHRT_MAX>>1))
 #define SHRT_MIN	((s16)(-SHRT_MAX - 1))
-#define INT_MAX		((int)(~0U>>1))
 #define INT_MIN		(-INT_MAX - 1)
-#define UINT_MAX	(~0U)
 #define LONG_MAX	((long)(~0UL>>1))
 #define LONG_MIN	(-LONG_MAX - 1)
 #define ULONG_MAX	(~0UL)
 #define LLONG_MAX	((long long)(~0ULL>>1))
 #define LLONG_MIN	(-LLONG_MAX - 1)
 #define ULLONG_MAX	(~0ULL)
-#ifndef SIZE_MAX
-#define SIZE_MAX	(~(size_t)0)
-#endif
-#ifndef SSIZE_MAX
-#define SSIZE_MAX	((ssize_t)(SIZE_MAX >> 1))
-#endif
 
 #define U8_MAX		((u8)~0U)
 #define S8_MAX		((s8)(U8_MAX>>1))
@@ -36,10 +29,6 @@
 #define S64_MAX		((s64)(U64_MAX>>1))
 #define S64_MIN		((s64)(-S64_MAX - 1))
 
-/* Aliases defined by stdint.h */
-#define UINT32_MAX	U32_MAX
-#define UINT64_MAX	U64_MAX
-
 #define INT32_MAX	S32_MAX
 
 #define STACK_MAGIC	0xdeadbeef
diff --git a/include/stdlib.h b/include/stdlib.h
index 9c175d4d74c..dedfd52a144 100644
--- a/include/stdlib.h
+++ b/include/stdlib.h
@@ -7,5 +7,6 @@
 #define __STDLIB_H_
 
 #include <malloc.h>
+#include <rand.h>
 
 #endif /* __STDLIB_H_ */
diff --git a/lib/Kconfig b/lib/Kconfig
index 2059219a120..8b170dcc67e 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -418,6 +418,10 @@ config CIRCBUF
 
 source "lib/dhry/Kconfig"
 
+menu "Alternative crypto libraries"
+source lib/mbedtls/Kconfig
+endmenu
+
 menu "Security support"
 
 config AES
diff --git a/lib/Makefile b/lib/Makefile
index 81b503ab526..e1ab8dfd503 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -96,6 +96,8 @@ obj-$(CONFIG_LIBAVB) += libavb/
 obj-$(CONFIG_$(SPL_TPL_)OF_LIBFDT) += libfdt/
 obj-$(CONFIG_$(SPL_TPL_)OF_REAL) += fdtdec_common.o fdtdec.o
 
+obj-$(CONFIG_MBEDTLS_LIB) += mbedtls/
+
 ifdef CONFIG_SPL_BUILD
 obj-$(CONFIG_SPL_YMODEM_SUPPORT) += crc16-ccitt.o
 obj-$(CONFIG_$(SPL_TPL_)HASH) += crc16-ccitt.o
diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
new file mode 100644
index 00000000000..3e9057f1acf
--- /dev/null
+++ b/lib/mbedtls/Kconfig
@@ -0,0 +1,47 @@
+choice
+	prompt "Select crypto libraries"
+	default LEGACY_CRYPTO
+	help
+	  Select crypto libraries.
+	  LEGACY_CRYPTO for legacy crypto libraries,
+	  MBEDTLS_LIB for MbedTLS libraries.
+
+config LEGACY_CRYPTO
+	bool "legacy crypto libraries"
+	select LEGACY_CRYPTO_BASIC
+	select LEGACY_CRYPTO_CERT
+
+config MBEDTLS_LIB
+	bool "MbedTLS libraries"
+	select MBEDTLS_LIB_CRYPTO
+	select MBEDTLS_LIB_X509
+endchoice
+
+if LEGACY_CRYPTO
+
+config LEGACY_CRYPTO_BASIC
+	bool "legacy basic crypto libraries"
+	help
+	  Enable legacy basic crypto libraries.
+
+config LEGACY_CRYPTO_CERT
+	bool "legacy certificate libraries"
+	help
+	  Enable legacy certificate libraries.
+
+endif # LEGACY_CRYPTO
+
+if MBEDTLS_LIB
+
+config MBEDTLS_LIB_CRYPTO
+	bool "MbedTLS crypto libraries"
+	help
+	  Enable MbedTLS crypto libraries.
+
+
+config MBEDTLS_LIB_X509
+	bool "MbedTLS certificate libraries"
+	help
+	  Enable MbedTLS certificate libraries.
+
+endif # MBEDTLS_LIB
diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
new file mode 100644
index 00000000000..e98241b46ab
--- /dev/null
+++ b/lib/mbedtls/Makefile
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (c) 2024 Linaro Limited
+# Author: Raymond Mao <raymond.mao@linaro.org>
+
+MBEDTLS_LIB_DIR = external/mbedtls/library
+
+# MbedTLS crypto library
+obj-$(CONFIG_MBEDTLS_LIB_CRYPTO) += mbedtls_lib_crypto.o
+mbedtls_lib_crypto-y := \
+	$(MBEDTLS_LIB_DIR)/platform_util.o \
+	$(MBEDTLS_LIB_DIR)/constant_time.o \
+	$(MBEDTLS_LIB_DIR)/md.o
+mbedtls_lib_crypto-$(CONFIG_$(SPL_)MD5) += $(MBEDTLS_LIB_DIR)/md5.o
+mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA1) += $(MBEDTLS_LIB_DIR)/sha1.o
+mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA256) += \
+	$(MBEDTLS_LIB_DIR)/sha256.o
+mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA512) += \
+	$(MBEDTLS_LIB_DIR)/sha512.o
+
+# MbedTLS X509 library
+obj-$(CONFIG_MBEDTLS_LIB_X509) += mbedtls_lib_x509.o
+mbedtls_lib_x509-y := $(MBEDTLS_LIB_DIR)/x509.o
+mbedtls_lib_x509-$(CONFIG_$(SPL_)ASN1_DECODER) += \
+	$(MBEDTLS_LIB_DIR)/asn1parse.o \
+	$(MBEDTLS_LIB_DIR)/asn1write.o \
+	$(MBEDTLS_LIB_DIR)/oid.o
+mbedtls_lib_x509-$(CONFIG_$(SPL_)RSA_PUBLIC_KEY_PARSER) += \
+	$(MBEDTLS_LIB_DIR)/bignum.o \
+	$(MBEDTLS_LIB_DIR)/bignum_core.o \
+	$(MBEDTLS_LIB_DIR)/rsa.o \
+	$(MBEDTLS_LIB_DIR)/rsa_alt_helpers.o
+mbedtls_lib_x509-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += \
+	$(MBEDTLS_LIB_DIR)/pk.o \
+	$(MBEDTLS_LIB_DIR)/pk_wrap.o \
+	$(MBEDTLS_LIB_DIR)/pkparse.o
+mbedtls_lib_x509-$(CONFIG_$(SPL_)X509_CERTIFICATE_PARSER) += \
+	$(MBEDTLS_LIB_DIR)/x509_crl.o \
+	$(MBEDTLS_LIB_DIR)/x509_crt.o
+mbedtls_lib_x509-$(CONFIG_$(SPL_)PKCS7_MESSAGE_PARSER) += \
+	$(MBEDTLS_LIB_DIR)/pkcs7.o
diff --git a/lib/mbedtls/mbedtls_def_config.h b/lib/mbedtls/mbedtls_def_config.h
new file mode 100644
index 00000000000..38de6b0b9af
--- /dev/null
+++ b/lib/mbedtls/mbedtls_def_config.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * MbedTLS config file
+ *
+ * Derived from the MbedTLS internal config file,
+ * for more information about each build option,
+ * please refer to:
+ * external/mbedtls/include/mbedtls/mbedtls_config.h
+ *
+ * Copyright (c) 2024 Linaro Limited
+ * Author: Raymond Mao <raymond.mao@linaro.org>
+ */
+
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
+
+#define MBEDTLS_MD_C
+
+#if CONFIG_IS_ENABLED(MD5)
+#define MBEDTLS_MD5_C
+#endif
+
+#if CONFIG_IS_ENABLED(SHA1)
+#define MBEDTLS_SHA1_C
+#endif
+
+#if CONFIG_IS_ENABLED(SHA256)
+#define MBEDTLS_SHA256_C
+#endif
+
+#if CONFIG_IS_ENABLED(SHA384)
+#define MBEDTLS_SHA384_C
+#endif
+
+#if CONFIG_IS_ENABLED(SHA512)
+#define MBEDTLS_SHA512_C
+#endif
+
+#endif /* CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO) */
+
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
+
+#if CONFIG_IS_ENABLED(X509_CERTIFICATE_PARSER)
+#define MBEDTLS_PKCS1_V15
+#define MBEDTLS_X509_USE_C
+#define MBEDTLS_X509_CRT_PARSE_C
+#define MBEDTLS_X509_CRL_PARSE_C
+#endif
+
+#if CONFIG_IS_ENABLED(ASYMMETRIC_PUBLIC_KEY_SUBTYPE)
+#define MBEDTLS_PK_C
+#define MBEDTLS_PK_PARSE_C
+#endif
+
+#if CONFIG_IS_ENABLED(RSA_PUBLIC_KEY_PARSER)
+#define MBEDTLS_BIGNUM_C
+#define MBEDTLS_RSA_C
+#endif
+
+#if CONFIG_IS_ENABLED(PKCS7_MESSAGE_PARSER)
+#define MBEDTLS_PKCS7_C
+#endif
+
+#if CONFIG_IS_ENABLED(ASN1_DECODER)
+#define MBEDTLS_OID_C
+#define MBEDTLS_ASN1_PARSE_C
+#define MBEDTLS_ASN1_WRITE_C
+#endif
+
+#endif /* CONFIG_IS_ENABLED(MBEDTLS_LIB_X509) */
diff --git a/lib/mbedtls/port/assert.h b/lib/mbedtls/port/assert.h
new file mode 100644
index 00000000000..490701aa9d0
--- /dev/null
+++ b/lib/mbedtls/port/assert.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Dummy file to allow mbedtls linked with U-Boot to include assert.h
+ *
+ * Copyright (c) 2023 Linaro Limited
+ * Author: Raymond Mao <raymond.mao@linaro.org>
+ */
+
+#ifndef _MBEDTLS_ASSERT_H
+#define _MBEDTLS_ASSERT_H
+
+#endif /* _MBEDTLS_ASSERT_H */
-- 
2.25.1

