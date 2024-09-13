Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3F9FC6186
	for <u-boot@archiver.kernel.org>; Sat, 14 Sep 2024 01:05:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A93888D94;
	Sat, 14 Sep 2024 03:04:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="c2sBBKt1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 333B588549; Fri, 13 Sep 2024 18:07:18 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3EDF8860D
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 18:07:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6c524b4a3aeso16138706d6.3
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 09:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726243634; x=1726848434; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d9EqVH3m6eIZFMT0y0kcX/lhQ5zm4lRs0WPCrnjUqAc=;
 b=c2sBBKt1Nj4BJRqn8D0+qqaSJdzYNwYpkUj0OM3Rgq7G11IH7j02DzSFfNzWfhkl+v
 ciIO78//2ew/paIEDMCxjDV92+UqMmFCAbCT2kv7bWgFVQkDtlwgcAAvY/FBpHfbAi56
 94ZY71Bn6u9MqaaUTALAOrjzejbf0FZU+zJCv4m6SGlIEiQFiz2p69hV0GZxWbKJ6uqv
 YtaE4YQ9ib4/PM+HLfHwZmog0pggbsF+0yG9OcvgIgljHfMpBOScOBK01aUwqbEqJRZZ
 /0pdGqS1O2qnTbT4EI6WIwrOp2i0shJMBpeTMVEZir65vOoCLjMR6M6TrKd+PODMvlBS
 JhJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726243634; x=1726848434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d9EqVH3m6eIZFMT0y0kcX/lhQ5zm4lRs0WPCrnjUqAc=;
 b=DEdMrvvtYakycXHW3k5bHjV++i0MOrwfP8yi+Knz1aidyMXFyu9EKMdPyPVgBl8Vwp
 B2JtujZawi4/Ka4ViRZte/1TGew88o5Nmt+aDWCAHyE+y3dx02JvxTUmOsLGMCs2/1qX
 aE8rTM780kpIquXL2s40JS8swysAG3Sx+S6mRtG3FQyRI4aIUkbYGbSJltlpq/ISogiW
 Yigm1IZ1Zux5ZnWTVPSnN0UzwWDRsZJUU3oTqJUqDOTBnQrpjAZ09j2E2+YQVk70bjYE
 lXZ2+6lItPS0g+wfugn67Fposw9OImovqXqtCd75jQVGbD5Cgz0L9gw1AaEm1sMfZjVF
 Pv9A==
X-Gm-Message-State: AOJu0Yw2E5szJ20+aHe+qtX53E2ht1YpoNpEZqrVAKOAAeaT5Gp0exzl
 XXB5J+wobpuoKwa8flQbcJbfwEBEWsuNB7GvjEASsPlSr/O1djqWw5r9+7DZJ7QLquqf/1s9qzv
 R
X-Google-Smtp-Source: AGHT+IHIqSDbEQZTrwT3buKZ+Qe6PJgrP5Ug6HoUr/f98PaUY2pOdBp+pF7aRCDShWdVMeDX1Txzvg==
X-Received: by 2002:a0c:f8c3:0:b0:6c5:73d3:2316 with SMTP id
 6a1803df08f44-6c573d32477mr77407806d6.36.1726243634273; 
 Fri, 13 Sep 2024 09:07:14 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c534774908sm67697286d6.118.2024.09.13.09.07.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 09:07:13 -0700 (PDT)
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
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sumit Garg <sumit.garg@linaro.org>, Sean Anderson <seanga2@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>, Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Jonas Karlman <jonas@kwiboo.se>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v7 06/27] mbedtls: add digest shim layer for MbedTLS
Date: Fri, 13 Sep 2024 09:03:23 -0700
Message-Id: <20240913160408.2199558-7-raymond.mao@linaro.org>
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
index efae2c4fd72..12f8c965f5a 100644
--- a/lib/mbedtls/Kconfig
+++ b/lib/mbedtls/Kconfig
@@ -126,9 +126,99 @@ if MBEDTLS_LIB
 
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
index e98241b46ab..50c1ba5f88e 100644
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
 obj-$(CONFIG_MBEDTLS_LIB_CRYPTO) += mbedtls_lib_crypto.o
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

