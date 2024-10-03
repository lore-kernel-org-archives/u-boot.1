Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3DC6CFA749
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 04:57:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4727788E7A;
	Fri,  4 Oct 2024 06:57:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JohYVMUS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9E7B88C6D; Thu,  3 Oct 2024 23:52:32 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01B9588CC5
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 23:52:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6cb3ba0a9a2so9785586d6.2
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 14:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727992349; x=1728597149; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V2fRE/Rkcy9aTWyu8IOFoqGQ59XthJUCI/RdUJYJKVI=;
 b=JohYVMUSNH64HoC04PbU6uQT54SPHjvl4eaS/mbdK76+g5XGGYU0keaLPyCWHP6xMo
 SFjvxm4Bxf51uhwfz9aOwa1WY/jVsZu2J80kT1hVJPzMlpSLRttZ5t2+84IOd7TcMu+B
 Z5OdFmrefUX/GV0Lxex5VllN+lOTMoKR9XjJvMtcVrO13YacBCK22qUoOqVr4T55wvPB
 tlfBmw4NHL2rvqZlUIF5d+A3OFWnV5elzq5s3ORvd8bcTvfK/Jd3jjoKeCL0fZDru5Xj
 i5teQJOTTAt9eu8S+IxaQenADlz7ldK3Ysy3xE5TYrrGpCGD8W29/4Eg1aHnYnFy8cPO
 hd9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727992349; x=1728597149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V2fRE/Rkcy9aTWyu8IOFoqGQ59XthJUCI/RdUJYJKVI=;
 b=Njr+F2r+8ok8EpFlVicwVoK47ckNbxemoGg4XFLpGVdW2ubCEqWdQzGSpZJOOd4+pP
 U8Z5a2ffzxzmwA27eWvG2f7ZsEEwD3hHq+IlGswkwJ9c/WZ9BZMMW5rVIpEFlup+I9fg
 8GQTMuTfOTfLCRgN1mVwAPNHIgOo9EIftBy9UrDEbgjr1SFRjBMyQnkVxfALIrVvYzM3
 LEh4fJt8fyS2IPEYG8oqYKOtiLiUoCho/AifDDbBQDrUoLWnxRRqCVg23/PxkTxU91LJ
 1sIzIPcy+lI9hCZdkfP+5LsxPcs1Bci7BtIuTVsnoAEdgp8VWIoylLj3uLTRwisTAmyx
 /LWg==
X-Gm-Message-State: AOJu0Ywc2/SNmBzXJKJ8Ymoa+/sRcPvW4J3oazHHbYDfQ/3Cq0FuMyGx
 GKJEkpb6U0AMtLHzvoXYrhPlQBE+8GdEI46p85uGqzE5kHHYg5+Pkt4Vk5pZhdB6eUJsA06X085
 b
X-Google-Smtp-Source: AGHT+IHsvqh6j0hKZgLSreKShw6N03IUhi1uzqAGyMdn8kBmbYDZz5bj2n0ooBN34pwRKgS32Qmjug==
X-Received: by 2002:a05:6214:4987:b0:6cb:3a53:c549 with SMTP id
 6a1803df08f44-6cb9a330870mr9878536d6.1.1727992348565; 
 Thu, 03 Oct 2024 14:52:28 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45d92ddf5c4sm9001541cf.18.2024.10.03.14.52.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 14:52:27 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Andrew Davis <afd@ti.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Marek Vasut <marex@denx.de>,
 Greg Malysa <greg.malysa@timesys.com>,
 Kongyang Liu <seashell11234455@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v8 02/27] mbedtls: add mbedtls into the build system
Date: Thu,  3 Oct 2024 14:50:15 -0700
Message-Id: <20241003215112.3103601-3-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241003215112.3103601-1-raymond.mao@linaro.org>
References: <20241003215112.3103601-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 04 Oct 2024 06:57:18 +0200
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
Port u-boot hash functions as MbedTLS crypto alternatives and set
it as default.

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
Changes in v7
- Fixed CI world build failures due to config dependencies.
- Fixed values of UINT_MAX and UINT32_MAX.
Changes in v8
- Port u-boot hash functions as MbedTLS crypto alternatives and set
  it as default.

 Makefile                         |  6 +++
 include/limits.h                 | 25 ++++++++++
 include/linux/kernel.h           | 13 +----
 include/stdlib.h                 |  1 +
 lib/Kconfig                      |  4 ++
 lib/Makefile                     |  2 +
 lib/mbedtls/Kconfig              | 56 +++++++++++++++++++++
 lib/mbedtls/Makefile             | 41 ++++++++++++++++
 lib/mbedtls/mbedtls_def_config.h | 84 ++++++++++++++++++++++++++++++++
 lib/mbedtls/port/assert.h        | 12 +++++
 lib/mbedtls/port/md5_alt.h       | 57 ++++++++++++++++++++++
 lib/mbedtls/port/sha1_alt.h      | 57 ++++++++++++++++++++++
 lib/mbedtls/port/sha256_alt.h    | 64 ++++++++++++++++++++++++
 lib/mbedtls/port/sha512_alt.h    | 78 +++++++++++++++++++++++++++++
 14 files changed, 488 insertions(+), 12 deletions(-)
 create mode 100644 include/limits.h
 create mode 100644 lib/mbedtls/Kconfig
 create mode 100644 lib/mbedtls/Makefile
 create mode 100644 lib/mbedtls/mbedtls_def_config.h
 create mode 100644 lib/mbedtls/port/assert.h
 create mode 100644 lib/mbedtls/port/md5_alt.h
 create mode 100644 lib/mbedtls/port/sha1_alt.h
 create mode 100644 lib/mbedtls/port/sha256_alt.h
 create mode 100644 lib/mbedtls/port/sha512_alt.h

diff --git a/Makefile b/Makefile
index 525576f987d..f4659f9493a 100644
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
index 00000000000..4700cc7a59f
--- /dev/null
+++ b/include/limits.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef _LIMITS_H
+#define _LIMITS_H
+
+#define INT_MAX     0x7fffffff
+#define UINT_MAX    0xffffffffU
+#define CHAR_BIT    8
+#define UINT32_MAX  0xffffffffU
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
index 1dd4f271595..67a60160dac 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -419,6 +419,10 @@ config CIRCBUF
 
 source "lib/dhry/Kconfig"
 
+menu "Alternative crypto libraries"
+source lib/mbedtls/Kconfig
+endmenu
+
 menu "Security support"
 
 config AES
diff --git a/lib/Makefile b/lib/Makefile
index d300249f57c..c4950b78a29 100644
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
index 00000000000..9d1a63c1ca6
--- /dev/null
+++ b/lib/mbedtls/Kconfig
@@ -0,0 +1,56 @@
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
+	select MBEDTLS_LIB_X509
+endchoice
+
+if LEGACY_CRYPTO || MBEDTLS_LIB_CRYPTO_ALT
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
+config MBEDTLS_LIB_CRYPTO_ALT
+	bool "MbedTLS crypto alternatives"
+	depends on MBEDTLS_LIB && !MBEDTLS_LIB_CRYPTO
+	select LEGACY_CRYPTO_BASIC
+	default y if MBEDTLS_LIB && !MBEDTLS_LIB_CRYPTO
+	help
+	  Enable MbedTLS crypto alternatives.
+	  Mutually incompatible with MBEDTLS_LIB_CRYPTO.
+
+config MBEDTLS_LIB_CRYPTO
+	bool "MbedTLS crypto libraries"
+	help
+	  Enable MbedTLS crypto libraries.
+	  Mutually incompatible with MBEDTLS_LIB_CRYPTO_ALT.
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
index 00000000000..0b6d6ca808f
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
+obj-$(CONFIG_MBEDTLS_LIB) += mbedtls_lib_crypto.o
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
index 00000000000..6fba053bd7c
--- /dev/null
+++ b/lib/mbedtls/mbedtls_def_config.h
@@ -0,0 +1,84 @@
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
+#if defined CONFIG_MBEDTLS_LIB
+
+#if CONFIG_IS_ENABLED(MD5)
+#define MBEDTLS_MD_C
+#define MBEDTLS_MD5_C
+#if defined CONFIG_MBEDTLS_LIB_CRYPTO_ALT
+#define MBEDTLS_MD5_ALT
+#endif
+#endif
+
+#if CONFIG_IS_ENABLED(SHA1)
+#define MBEDTLS_MD_C
+#define MBEDTLS_SHA1_C
+#if defined CONFIG_MBEDTLS_LIB_CRYPTO_ALT
+#define MBEDTLS_SHA1_ALT
+#endif
+#endif
+
+#if CONFIG_IS_ENABLED(SHA256)
+#define MBEDTLS_MD_C
+#define MBEDTLS_SHA256_C
+#if defined CONFIG_MBEDTLS_LIB_CRYPTO_ALT
+#define MBEDTLS_SHA256_ALT
+#endif
+#endif
+
+#if CONFIG_IS_ENABLED(SHA384)
+#define MBEDTLS_MD_C
+#define MBEDTLS_SHA384_C
+#endif
+
+#if CONFIG_IS_ENABLED(SHA512)
+#define MBEDTLS_MD_C
+#define MBEDTLS_SHA512_C
+#if defined CONFIG_MBEDTLS_LIB_CRYPTO_ALT
+#define MBEDTLS_SHA512_ALT
+#endif
+#endif
+
+#if defined CONFIG_MBEDTLS_LIB_X509
+
+#if CONFIG_IS_ENABLED(X509_CERTIFICATE_PARSER)
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
+#define MBEDTLS_PKCS1_V15
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
+#endif /* #if defined CONFIG_MBEDTLS_LIB_X509 */
+
+#endif /* #if defined CONFIG_MBEDTLS_LIB */
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
diff --git a/lib/mbedtls/port/md5_alt.h b/lib/mbedtls/port/md5_alt.h
new file mode 100644
index 00000000000..c6e8eabf68a
--- /dev/null
+++ b/lib/mbedtls/port/md5_alt.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2024 Linaro Limited
+ * Author: Raymond Mao <raymond.mao@linaro.org>
+ */
+#ifndef MD5_ALT_H
+#define MD5_ALT_H
+
+#include <image.h>
+#include <u-boot/md5.h>
+
+typedef MD5Context mbedtls_md5_context;
+
+static inline void mbedtls_md5_init(mbedtls_md5_context *ctx)
+{
+}
+
+static inline void mbedtls_md5_free(mbedtls_md5_context *ctx)
+{
+}
+
+static inline void
+mbedtls_md5_clone(mbedtls_md5_context *dst, const mbedtls_md5_context *src)
+{
+	*dst = *src;
+}
+
+static inline int mbedtls_md5_starts(mbedtls_md5_context *ctx)
+{
+	MD5Init(ctx);
+	return 0;
+}
+
+static inline int mbedtls_md5_update(mbedtls_md5_context *ctx,
+				     const unsigned char *input,
+				     size_t ilen)
+{
+	MD5Update(ctx, input, ilen);
+	return 0;
+}
+
+static inline int mbedtls_md5_finish(mbedtls_md5_context *ctx,
+				     unsigned char output[16])
+{
+	MD5Final(output, ctx);
+	return 0;
+}
+
+static inline int mbedtls_md5(const unsigned char *input,
+			      size_t ilen,
+			      unsigned char output[16])
+{
+	md5_wd(input, ilen, output, CHUNKSZ_MD5);
+	return 0;
+}
+
+#endif /* md5_alt.h */
diff --git a/lib/mbedtls/port/sha1_alt.h b/lib/mbedtls/port/sha1_alt.h
new file mode 100644
index 00000000000..cbfe0ddc478
--- /dev/null
+++ b/lib/mbedtls/port/sha1_alt.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2024 Linaro Limited
+ * Author: Raymond Mao <raymond.mao@linaro.org>
+ */
+#ifndef SHA1_ALT_H
+#define SHA1_ALT_H
+
+#include <image.h>
+#include <u-boot/sha1.h>
+
+typedef sha1_context mbedtls_sha1_context;
+
+static inline void mbedtls_sha1_init(mbedtls_sha1_context *ctx)
+{
+}
+
+static inline void mbedtls_sha1_free(mbedtls_sha1_context *ctx)
+{
+}
+
+static inline void mbedtls_sha1_clone(mbedtls_sha1_context *dst,
+				      const mbedtls_sha1_context *src)
+{
+	*dst = *src;
+}
+
+static inline int mbedtls_sha1_starts(mbedtls_sha1_context *ctx)
+{
+	sha1_starts(ctx);
+	return 0;
+}
+
+static inline int mbedtls_sha1_update(mbedtls_sha1_context *ctx,
+				      const unsigned char *input,
+				      size_t ilen)
+{
+	sha1_update(ctx, input, ilen);
+	return 0;
+}
+
+static inline int mbedtls_sha1_finish(mbedtls_sha1_context *ctx,
+				      unsigned char output[20])
+{
+	sha1_finish(ctx, output);
+	return 0;
+}
+
+static inline int mbedtls_sha1(const unsigned char *input,
+			       size_t ilen,
+			       unsigned char output[20])
+{
+	sha1_csum_wd(input, ilen, output, CHUNKSZ_SHA1);
+	return 0;
+}
+
+#endif /* sha1_alt.h */
diff --git a/lib/mbedtls/port/sha256_alt.h b/lib/mbedtls/port/sha256_alt.h
new file mode 100644
index 00000000000..80be94b0a06
--- /dev/null
+++ b/lib/mbedtls/port/sha256_alt.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2024 Linaro Limited
+ * Author: Raymond Mao <raymond.mao@linaro.org>
+ */
+#ifndef SHA256_ALT_H
+#define SHA256_ALT_H
+
+#include <image.h>
+#include <u-boot/sha256.h>
+
+typedef sha256_context mbedtls_sha256_context;
+
+static inline void mbedtls_sha256_init(mbedtls_sha256_context *ctx)
+{
+}
+
+static inline void mbedtls_sha256_free(mbedtls_sha256_context *ctx)
+{
+}
+
+static inline void mbedtls_sha256_clone(mbedtls_sha256_context *dst,
+					const mbedtls_sha256_context *src)
+{
+	*dst = *src;
+}
+
+static inline int mbedtls_sha256_starts(mbedtls_sha256_context *ctx, int is224)
+{
+	if (is224)
+		return -EOPNOTSUPP;
+
+	sha256_starts(ctx);
+	return 0;
+}
+
+static inline int mbedtls_sha256_update(mbedtls_sha256_context *ctx,
+					const unsigned char *input,
+					size_t ilen)
+{
+	sha256_update(ctx, input, ilen);
+	return 0;
+}
+
+static inline int mbedtls_sha256_finish(mbedtls_sha256_context *ctx,
+					unsigned char *output)
+{
+	sha256_finish(ctx, output);
+	return 0;
+}
+
+static inline int mbedtls_sha256(const unsigned char *input,
+				 size_t ilen,
+				 unsigned char *output,
+				 int is224)
+{
+	if (is224)
+		return -EOPNOTSUPP;
+
+	sha256_csum_wd(input, ilen, output, CHUNKSZ_SHA256);
+	return 0;
+}
+
+#endif /* sha256_alt.h */
diff --git a/lib/mbedtls/port/sha512_alt.h b/lib/mbedtls/port/sha512_alt.h
new file mode 100644
index 00000000000..596f17ae4da
--- /dev/null
+++ b/lib/mbedtls/port/sha512_alt.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2024 Linaro Limited
+ * Author: Raymond Mao <raymond.mao@linaro.org>
+ */
+#ifndef SHA512_ALT_H
+#define SHA512_ALT_H
+
+#include <image.h>
+#include <u-boot/sha512.h>
+
+typedef struct mbedtls_sha512_context {
+	sha512_context *ubctx;
+	bool is384;
+} mbedtls_sha512_context;
+
+static inline void mbedtls_sha512_init(mbedtls_sha512_context *ctx)
+{
+}
+
+static inline void mbedtls_sha512_free(mbedtls_sha512_context *ctx)
+{
+}
+
+static inline void mbedtls_sha512_clone(mbedtls_sha512_context *dst,
+					const mbedtls_sha512_context *src)
+{
+	*dst = *src;
+}
+
+static inline int mbedtls_sha512_starts(mbedtls_sha512_context *ctx, int is384)
+{
+	if (is384)
+		sha384_starts(ctx->ubctx);
+	else
+		sha512_starts(ctx->ubctx);
+
+	ctx->is384 = is384;
+	return 0;
+}
+
+static inline int mbedtls_sha512_update(mbedtls_sha512_context *ctx,
+					const unsigned char *input,
+					size_t ilen)
+{
+	if (ctx->is384)
+		sha384_update(ctx->ubctx, input, ilen);
+	else
+		sha512_update(ctx->ubctx, input, ilen);
+
+	return 0;
+}
+
+static inline int mbedtls_sha512_finish(mbedtls_sha512_context *ctx,
+					unsigned char *output)
+{
+	if (ctx->is384)
+		sha384_finish(ctx->ubctx, output);
+	else
+		sha512_finish(ctx->ubctx, output);
+
+	return 0;
+}
+
+static inline int mbedtls_sha512(const unsigned char *input,
+				 size_t ilen,
+				 unsigned char *output,
+				 int is384)
+{
+	if (is384)
+		sha384_csum_wd(input, ilen, output, CHUNKSZ_SHA512);
+	else
+		sha512_csum_wd(input, ilen, output, CHUNKSZ_SHA512);
+
+	return 0;
+}
+
+#endif /* sha512_alt.h */
-- 
2.25.1

