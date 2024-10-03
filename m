Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E72BCFA749
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 04:58:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B55FF88FD0;
	Fri,  4 Oct 2024 06:57:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TmlKMyoC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84E9588C6D; Thu,  3 Oct 2024 23:54:42 +0200 (CEST)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DDBB88CC5
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 23:54:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-45d8f76eca7so12033921cf.2
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 14:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727992479; x=1728597279; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HWiLl4nDFvUgPbRtwuRMWJhubzPUdhqV7Ki44H16J5E=;
 b=TmlKMyoCmRuEPqeJqLsTEYDmjUJvkT1sTFTqiPhQoR1wAujwpcFBNCMF5tQECZ1MA4
 qjmIsVAKm9bWBll9XJ6VjXguL0tiZIXOfS6MC6bnKxT2WEDrSlT+4jix/4nkmlHyb8AT
 IUwxo2SKhYWOe6OUT4C79hwm45M8OOfOAuvwegSQJqNY6BUir4PYYosmvd+D4OoCQeIn
 4v1rNa+5HjYs1jHUgZLnaa7hN0XNb8DT1Zo71B74hZMDfadRgRZlBA6pEe6waCzjlesc
 lJsvSKJIRfMdDVUa3/jwXpkpd7oOzI2VrD2fgYHAFo+MXcbLx/ZEcSSGEitjhYRDR5YU
 ddXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727992479; x=1728597279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HWiLl4nDFvUgPbRtwuRMWJhubzPUdhqV7Ki44H16J5E=;
 b=Z/nyOnzgtbE9qF7xBBIoJFZkJigGYM2RClVms/WtZ8Zpc+ZQL4ap/8x1/xUBqVLUuo
 vG6ucpmPISdmlTpg7ymMhAMM2On9+jGZ0WrkJAo7ZpNodjLvqT+Jb6t1mTjajSO7zBH2
 +4JtNy4b/4a5Q02Kb6XmWSx1atRoKsgnrZJfgVq1JZS8qiVVoGlTrmd+HndRCQk/xR8y
 +s5mwpfp9ttFNRvO+pwjogHbL36DRsFvhaYA1LwWJgXxzH56hvl4DpBZPIWq09Jz242y
 KRtreRi9CgmvDgFvPwaX8vj8b4knxQChLUElzLrruT2J8qnNvPN/I7NRXxjgdkcfV6ON
 4QVQ==
X-Gm-Message-State: AOJu0Yy0puZKHnIGLvboo8zWP57sBtKJqh+S9SNQdn8+zeThXVD2LeV4
 C0T6sBwnHvAQJCpfwStNOUkTuyU9KENWbkHJBmzCBmCxBTBzDUC5MaF8dvkLimeLTDxbBX214v1
 w
X-Google-Smtp-Source: AGHT+IGEtXtoNNz5XBGloyhUZ7Y+tjtMIUY/7m4+S951QtyffU02rOzBXCrfBkqNqkAkzhF+b32WCA==
X-Received: by 2002:a05:622a:148c:b0:458:4ac7:866b with SMTP id
 d75a77b69052e-45d9bb20777mr7218241cf.45.1727992478597; 
 Thu, 03 Oct 2024 14:54:38 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45d92ddf5c4sm9001541cf.18.2024.10.03.14.54.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 14:54:37 -0700 (PDT)
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
 Sumit Garg <sumit.garg@linaro.org>, Sean Anderson <seanga2@gmail.com>,
 Andrew Davis <afd@ti.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>, Paul Barker <paul.barker.ct@bp.renesas.com>,
 Kongyang Liu <seashell11234455@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Greg Malysa <greg.malysa@timesys.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v8 06/27] mbedtls: add digest shim layer for MbedTLS
Date: Thu,  3 Oct 2024 14:50:19 -0700
Message-Id: <20241003215112.3103601-7-raymond.mao@linaro.org>
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

Implement digest shim layer on top of MbedTLS crypto library.
Introduce <alg>_MBEDTLS kconfig for MbedTLS crypto implementations.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Split the shim layer into separated files and use the original head
  files instead of creating new ones.
Changes in v3
- Refactored sha1_hmac and removed non-watchdog md5 function.
Changes in v4
- Refactored hash _wd functions.
- Introduce <alg>_MBEDTLS kconfig for MbedTLS crypto implementations.
Changes in v5
- Correct kconfig dependence.
- Refactored MbedTLS makefile.
Changes in v6
- None.
Changes in v7
- None.
Changes in v8
- None

 include/u-boot/sha1.h |  4 ++
 lib/mbedtls/Kconfig   | 90 +++++++++++++++++++++++++++++++++++++++
 lib/mbedtls/Makefile  | 14 ++++--
 lib/mbedtls/md5.c     | 57 +++++++++++++++++++++++++
 lib/mbedtls/sha1.c    | 99 +++++++++++++++++++++++++++++++++++++++++++
 lib/mbedtls/sha256.c  | 62 +++++++++++++++++++++++++++
 lib/mbedtls/sha512.c  | 93 ++++++++++++++++++++++++++++++++++++++++
 7 files changed, 415 insertions(+), 4 deletions(-)
 create mode 100644 lib/mbedtls/md5.c
 create mode 100644 lib/mbedtls/sha1.c
 create mode 100644 lib/mbedtls/sha256.c
 create mode 100644 lib/mbedtls/sha512.c

diff --git a/include/u-boot/sha1.h b/include/u-boot/sha1.h
index 36c3db15e22..2fca7f1be16 100644
--- a/include/u-boot/sha1.h
+++ b/include/u-boot/sha1.h
@@ -41,6 +41,10 @@ extern "C" {
 
 #define SHA1_DEF_CHUNK_SZ 0x10000
 
+#define K_IPAD_VAL 0x36
+#define K_OPAD_VAL 0x5C
+#define K_PAD_LEN 64
+
 extern const uint8_t sha1_der_prefix[];
 
 #if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
index 8a7b3a30c04..262abb2cec7 100644
--- a/lib/mbedtls/Kconfig
+++ b/lib/mbedtls/Kconfig
@@ -134,10 +134,100 @@ config MBEDTLS_LIB_CRYPTO_ALT
 
 config MBEDTLS_LIB_CRYPTO
 	bool "MbedTLS crypto libraries"
+	select MD5_MBEDTLS if MD5
+	select SHA1_MBEDTLS if SHA1
+	select SHA256_MBEDTLS if SHA256
+	select SHA512_MBEDTLS if SHA512
+	select SHA384_MBEDTLS if SHA384
+	select SPL_MD5_MBEDTLS if SPL_MD5
+	select SPL_SHA1_MBEDTLS if SPL_SHA1
+	select SPL_SHA256_MBEDTLS if SPL_SHA256
+	select SPL_SHA512_MBEDTLS if SPL_SHA512
+	select SPL_SHA384_MBEDTLS if SPL_SHA384
 	help
 	  Enable MbedTLS crypto libraries.
 	  Mutually incompatible with MBEDTLS_LIB_CRYPTO_ALT.
 
+if MBEDTLS_LIB_CRYPTO
+
+config SHA1_MBEDTLS
+	bool "Enable SHA1 support with MbedTLS crypto library"
+	depends on MBEDTLS_LIB_CRYPTO && SHA1
+	help
+	  This option enables support of hashing using SHA1 algorithm
+	  with MbedTLS crypto library.
+
+config SHA256_MBEDTLS
+	bool "Enable SHA256 support with MbedTLS crypto library"
+	depends on MBEDTLS_LIB_CRYPTO && SHA256
+	help
+	  This option enables support of hashing using SHA256 algorithm
+	  with MbedTLS crypto library.
+
+config SHA512_MBEDTLS
+	bool "Enable SHA512 support with MbedTLS crypto library"
+	depends on MBEDTLS_LIB_CRYPTO && SHA512
+	default y if TI_SECURE_DEVICE && FIT_SIGNATURE
+	help
+	  This option enables support of hashing using SHA512 algorithm
+	  with MbedTLS crypto library.
+
+config SHA384_MBEDTLS
+	bool "Enable SHA384 support with MbedTLS crypto library"
+	depends on MBEDTLS_LIB_CRYPTO && SHA384
+	select SHA512_MBEDTLS
+	help
+	  This option enables support of hashing using SHA384 algorithm
+	  with MbedTLS crypto library.
+
+config MD5_MBEDTLS
+	bool "Enable MD5 support with MbedTLS crypto library"
+	depends on MBEDTLS_LIB_CRYPTO && MD5
+	help
+	  This option enables support of hashing using MD5 algorithm
+	  with MbedTLS crypto library.
+
+if SPL
+
+config SPL_SHA1_MBEDTLS
+	bool "Enable SHA1 support in SPL with MbedTLS crypto library"
+	depends on MBEDTLS_LIB_CRYPTO && SPL_SHA1
+	help
+	  This option enables support of hashing using SHA1 algorithm
+	  with MbedTLS crypto library.
+
+config SPL_SHA256_MBEDTLS
+	bool "Enable SHA256 support in SPL with MbedTLS crypto library"
+	depends on MBEDTLS_LIB_CRYPTO && SPL_SHA256
+	help
+	  This option enables support of hashing using SHA256 algorithm
+	  with MbedTLS crypto library.
+
+config SPL_SHA512_MBEDTLS
+	bool "Enable SHA512 support in SPL with MbedTLS crypto library"
+	depends on MBEDTLS_LIB_CRYPTO && SPL_SHA512
+	help
+	  This option enables support of hashing using SHA512 algorithm
+	  with MbedTLS crypto library.
+
+config SPL_SHA384_MBEDTLS
+	bool "Enable SHA384 support in SPL with MbedTLS crypto library"
+	depends on MBEDTLS_LIB_CRYPTO && SPL_SHA384
+	select SPL_SHA512
+	help
+	  This option enables support of hashing using SHA384 algorithm
+	  with MbedTLS crypto library.
+
+config SPL_MD5_MBEDTLS
+	bool "Enable MD5 support in SPL with MbedTLS crypto library"
+	depends on MBEDTLS_LIB_CRYPTO && SPL_MD5
+	help
+	  This option enables support of hashing using MD5 algorithm
+	  with MbedTLS crypto library.
+
+endif # SPL
+
+endif # MBEDTLS_LIB_CRYPTO
 
 config MBEDTLS_LIB_X509
 	bool "MbedTLS certificate libraries"
diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
index 0b6d6ca808f..eeb28ec1557 100644
--- a/lib/mbedtls/Makefile
+++ b/lib/mbedtls/Makefile
@@ -5,17 +5,23 @@
 
 MBEDTLS_LIB_DIR = external/mbedtls/library
 
+# shim layer for hash
+obj-$(CONFIG_$(SPL_)MD5_MBEDTLS) += md5.o
+obj-$(CONFIG_$(SPL_)SHA1_MBEDTLS) += sha1.o
+obj-$(CONFIG_$(SPL_)SHA256_MBEDTLS) += sha256.o
+obj-$(CONFIG_$(SPL_)SHA512_MBEDTLS) += sha512.o
+
 # MbedTLS crypto library
 obj-$(CONFIG_MBEDTLS_LIB) += mbedtls_lib_crypto.o
 mbedtls_lib_crypto-y := \
 	$(MBEDTLS_LIB_DIR)/platform_util.o \
 	$(MBEDTLS_LIB_DIR)/constant_time.o \
 	$(MBEDTLS_LIB_DIR)/md.o
-mbedtls_lib_crypto-$(CONFIG_$(SPL_)MD5) += $(MBEDTLS_LIB_DIR)/md5.o
-mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA1) += $(MBEDTLS_LIB_DIR)/sha1.o
-mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA256) += \
+mbedtls_lib_crypto-$(CONFIG_$(SPL_)MD5_MBEDTLS) += $(MBEDTLS_LIB_DIR)/md5.o
+mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA1_MBEDTLS) += $(MBEDTLS_LIB_DIR)/sha1.o
+mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA256_MBEDTLS) += \
 	$(MBEDTLS_LIB_DIR)/sha256.o
-mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA512) += \
+mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA512_MBEDTLS) += \
 	$(MBEDTLS_LIB_DIR)/sha512.o
 
 # MbedTLS X509 library
diff --git a/lib/mbedtls/md5.c b/lib/mbedtls/md5.c
new file mode 100644
index 00000000000..04388fce249
--- /dev/null
+++ b/lib/mbedtls/md5.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Hash shim layer on MbedTLS Crypto library
+ *
+ * Copyright (c) 2024 Linaro Limited
+ * Author: Raymond Mao <raymond.mao@linaro.org>
+ */
+#include "compiler.h"
+
+#ifndef USE_HOSTCC
+#include <watchdog.h>
+#endif /* USE_HOSTCC */
+#include <u-boot/md5.h>
+
+void MD5Init(MD5Context *ctx)
+{
+	mbedtls_md5_init(ctx);
+	mbedtls_md5_starts(ctx);
+}
+
+void MD5Update(MD5Context *ctx, unsigned char const *buf, unsigned int len)
+{
+	mbedtls_md5_update(ctx, buf, len);
+}
+
+void MD5Final(unsigned char digest[16], MD5Context *ctx)
+{
+	mbedtls_md5_finish(ctx, digest);
+	mbedtls_md5_free(ctx);
+}
+
+void md5_wd(const unsigned char *input, unsigned int len,
+	    unsigned char output[16], unsigned int chunk_sz)
+{
+	MD5Context context;
+
+	MD5Init(&context);
+
+	if (IS_ENABLED(CONFIG_HW_WATCHDOG) || IS_ENABLED(CONFIG_WATCHDOG)) {
+		const unsigned char *curr = input;
+		const unsigned char *end = input + len;
+		int chunk;
+
+		while (curr < end) {
+			chunk = end - curr;
+			if (chunk > chunk_sz)
+				chunk = chunk_sz;
+			MD5Update(&context, curr, chunk);
+			curr += chunk;
+			schedule();
+		}
+	} else {
+		MD5Update(&context, input, len);
+	}
+
+	MD5Final(output, &context);
+}
diff --git a/lib/mbedtls/sha1.c b/lib/mbedtls/sha1.c
new file mode 100644
index 00000000000..2aee5037795
--- /dev/null
+++ b/lib/mbedtls/sha1.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Hash shim layer on MbedTLS Crypto library
+ *
+ * Copyright (c) 2024 Linaro Limited
+ * Author: Raymond Mao <raymond.mao@linaro.org>
+ */
+#ifndef USE_HOSTCC
+#include <cyclic.h>
+#endif /* USE_HOSTCC */
+#include <string.h>
+#include <u-boot/sha1.h>
+
+const u8 sha1_der_prefix[SHA1_DER_LEN] = {
+	0x30, 0x21, 0x30, 0x09, 0x06, 0x05, 0x2b, 0x0e,
+	0x03, 0x02, 0x1a, 0x05, 0x00, 0x04, 0x14
+};
+
+void sha1_starts(sha1_context *ctx)
+{
+	mbedtls_sha1_init(ctx);
+	mbedtls_sha1_starts(ctx);
+}
+
+void sha1_update(sha1_context *ctx, const unsigned char *input,
+		 unsigned int length)
+{
+	mbedtls_sha1_update(ctx, input, length);
+}
+
+void sha1_finish(sha1_context *ctx, unsigned char output[SHA1_SUM_LEN])
+{
+	mbedtls_sha1_finish(ctx, output);
+	mbedtls_sha1_free(ctx);
+}
+
+void sha1_csum_wd(const unsigned char *input, unsigned int ilen,
+		  unsigned char *output, unsigned int chunk_sz)
+{
+	sha1_context ctx;
+
+	sha1_starts(&ctx);
+
+	if (IS_ENABLED(CONFIG_HW_WATCHDOG) || IS_ENABLED(CONFIG_WATCHDOG)) {
+		const unsigned char *curr = input;
+		const unsigned char *end = input + ilen;
+		int chunk;
+
+		while (curr < end) {
+			chunk = end - curr;
+			if (chunk > chunk_sz)
+				chunk = chunk_sz;
+			sha1_update(&ctx, curr, chunk);
+			curr += chunk;
+			schedule();
+		}
+	} else {
+		sha1_update(&ctx, input, ilen);
+	}
+
+	sha1_finish(&ctx, output);
+}
+
+void sha1_hmac(const unsigned char *key, int keylen,
+	       const unsigned char *input, unsigned int ilen,
+	       unsigned char *output)
+{
+	int i;
+	sha1_context ctx;
+	unsigned char k_ipad[K_PAD_LEN];
+	unsigned char k_opad[K_PAD_LEN];
+	unsigned char tmpbuf[20];
+
+	if (keylen > K_PAD_LEN)
+		return;
+
+	memset(k_ipad, K_IPAD_VAL, sizeof(k_ipad));
+	memset(k_opad, K_OPAD_VAL, sizeof(k_opad));
+
+	for (i = 0; i < keylen; i++) {
+		k_ipad[i] ^= key[i];
+		k_opad[i] ^= key[i];
+	}
+
+	sha1_starts(&ctx);
+	sha1_update(&ctx, k_ipad, sizeof(k_ipad));
+	sha1_update(&ctx, input, ilen);
+	sha1_finish(&ctx, tmpbuf);
+
+	sha1_starts(&ctx);
+	sha1_update(&ctx, k_opad, sizeof(k_opad));
+	sha1_update(&ctx, tmpbuf, sizeof(tmpbuf));
+	sha1_finish(&ctx, output);
+
+	memset(k_ipad, 0, sizeof(k_ipad));
+	memset(k_opad, 0, sizeof(k_opad));
+	memset(tmpbuf, 0, sizeof(tmpbuf));
+	memset(&ctx, 0, sizeof(sha1_context));
+}
diff --git a/lib/mbedtls/sha256.c b/lib/mbedtls/sha256.c
new file mode 100644
index 00000000000..24aa58fa674
--- /dev/null
+++ b/lib/mbedtls/sha256.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Hash shim layer on MbedTLS Crypto library
+ *
+ * Copyright (c) 2024 Linaro Limited
+ * Author: Raymond Mao <raymond.mao@linaro.org>
+ */
+#ifndef USE_HOSTCC
+#include <cyclic.h>
+#endif /* USE_HOSTCC */
+#include <u-boot/sha256.h>
+
+const u8 sha256_der_prefix[SHA256_DER_LEN] = {
+	0x30, 0x31, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86,
+	0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x01, 0x05,
+	0x00, 0x04, 0x20
+};
+
+void sha256_starts(sha256_context *ctx)
+{
+	mbedtls_sha256_init(ctx);
+	mbedtls_sha256_starts(ctx, 0);
+}
+
+void
+sha256_update(sha256_context *ctx, const uint8_t *input, uint32_t length)
+{
+	mbedtls_sha256_update(ctx, input, length);
+}
+
+void sha256_finish(sha256_context *ctx, uint8_t digest[SHA256_SUM_LEN])
+{
+	mbedtls_sha256_finish(ctx, digest);
+	mbedtls_sha256_free(ctx);
+}
+
+void sha256_csum_wd(const unsigned char *input, unsigned int ilen,
+		    unsigned char *output, unsigned int chunk_sz)
+{
+	sha256_context ctx;
+
+	sha256_starts(&ctx);
+
+	if (IS_ENABLED(CONFIG_HW_WATCHDOG) || IS_ENABLED(CONFIG_WATCHDOG)) {
+		const unsigned char *curr = input;
+		const unsigned char *end = input + ilen;
+		int chunk;
+
+		while (curr < end) {
+			chunk = end - curr;
+			if (chunk > chunk_sz)
+				chunk = chunk_sz;
+			sha256_update(&ctx, curr, chunk);
+			curr += chunk;
+			schedule();
+		}
+	} else {
+		sha256_update(&ctx, input, ilen);
+	}
+
+	sha256_finish(&ctx, output);
+}
diff --git a/lib/mbedtls/sha512.c b/lib/mbedtls/sha512.c
new file mode 100644
index 00000000000..5615248cb91
--- /dev/null
+++ b/lib/mbedtls/sha512.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Hash shim layer on MbedTLS Crypto library
+ *
+ * Copyright (c) 2024 Linaro Limited
+ * Author: Raymond Mao <raymond.mao@linaro.org>
+ */
+#ifndef USE_HOSTCC
+#include <cyclic.h>
+#endif /* USE_HOSTCC */
+#include <compiler.h>
+#include <u-boot/sha512.h>
+
+const u8 sha384_der_prefix[SHA384_DER_LEN] = {
+	0x30, 0x41, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86,
+	0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x02, 0x05,
+	0x00, 0x04, 0x30
+};
+
+const u8 sha512_der_prefix[SHA512_DER_LEN] = {
+	0x30, 0x51, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86,
+	0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x03, 0x05,
+	0x00, 0x04, 0x40
+};
+
+void sha384_starts(sha512_context *ctx)
+{
+	mbedtls_sha512_init(ctx);
+	mbedtls_sha512_starts(ctx, 1);
+}
+
+void
+sha384_update(sha512_context *ctx, const uint8_t *input, uint32_t length)
+{
+	mbedtls_sha512_update(ctx, input, length);
+}
+
+void sha384_finish(sha512_context *ctx, uint8_t digest[SHA384_SUM_LEN])
+{
+	mbedtls_sha512_finish(ctx, digest);
+	mbedtls_sha512_free(ctx);
+}
+
+void sha384_csum_wd(const unsigned char *input, unsigned int length,
+		    unsigned char *output, unsigned int chunk_sz)
+{
+	mbedtls_sha512(input, length, output, 1);
+}
+
+void sha512_starts(sha512_context *ctx)
+{
+	mbedtls_sha512_init(ctx);
+	mbedtls_sha512_starts(ctx, 0);
+}
+
+void
+sha512_update(sha512_context *ctx, const uint8_t *input, uint32_t length)
+{
+	mbedtls_sha512_update(ctx, input, length);
+}
+
+void sha512_finish(sha512_context *ctx, uint8_t digest[SHA512_SUM_LEN])
+{
+	mbedtls_sha512_finish(ctx, digest);
+	mbedtls_sha512_free(ctx);
+}
+
+void sha512_csum_wd(const unsigned char *input, unsigned int ilen,
+		    unsigned char *output, unsigned int chunk_sz)
+{
+	sha512_context ctx;
+
+	sha512_starts(&ctx);
+
+	if (IS_ENABLED(CONFIG_HW_WATCHDOG) || IS_ENABLED(CONFIG_WATCHDOG)) {
+		const unsigned char *curr = input;
+		const unsigned char *end = input + ilen;
+		int chunk;
+
+		while (curr < end) {
+			chunk = end - curr;
+			if (chunk > chunk_sz)
+				chunk = chunk_sz;
+			sha512_update(&ctx, curr, chunk);
+			curr += chunk;
+			schedule();
+		}
+	} else {
+		sha512_update(&ctx, input, ilen);
+	}
+
+	sha512_finish(&ctx, output);
+}
-- 
2.25.1

