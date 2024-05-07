Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 955EAC10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 17:55:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CFF2883F3;
	Tue,  7 May 2024 19:55:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aA5MxlPu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33B46883F6; Tue,  7 May 2024 19:55:52 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABA15883E8
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 19:55:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6a0b4622ea0so12019866d6.2
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 10:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715104548; x=1715709348; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nLpBIowFzAJX0HA9qym++PfMHbigr6dSeU0mvBkSU5g=;
 b=aA5MxlPuckN3omdwjymd02STM9xpe4GrEDGHh493FlAeYkHMgI4eysTqmgZtOr4nTQ
 DVAk3QsTx2/a6HiS1x7UsqyA2fSdCQvQMmOEpi1WOkwXxVzhI89DhdM1HIr+Z5an6rNu
 40V/SxdKH62iAhtBSy7d6koXlUKYWl2kSO4nNZ3mvzpiVik9b6mxSjbVkR0UZmQJaEZC
 +IPPGA7YHPg4hi7hYrPygumd1n5OWPtA5i50X/fuSyg9DMLTE9TwPajbNzE+80BC2nvg
 jOCsbnfBm+f5vPG/4N6Z4Qk6wBseFduRR5/weZHX5KhLHFj5iRP46QZ0x2gEIAHOBQql
 JYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715104548; x=1715709348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nLpBIowFzAJX0HA9qym++PfMHbigr6dSeU0mvBkSU5g=;
 b=QI6g5UaMVCt92VDuS5Qls3Ompy7vgkvmnGdidru6gzLuow42TkhE4Ol3FH38cB6HjY
 VYQEFMV128878o1rUK/wBkyvZcHg6wlzDGwmyce59UMCjJ5YZehO5z9ls/oBvhhOKzg1
 3VdiHzEOEu46p6gaY9phk/JqLwLzXtVSjbp9Er+eAk7TfaxrqJDGOXLFFFqPS5z1igvD
 LmmHLx81AJszn+mLWlrFNejFFDPlKBP991h6k5ctrC6DStL7WXgsTYidJ58gX6nKqqVx
 fxPNxRCusdnYCfbFqvzrwDf/KdTlWS3deHkU1Taf7fRCUrmdI7VHQnOAWzGmmC0iyhAV
 ts3Q==
X-Gm-Message-State: AOJu0Yx8ZcJ+ikbtmiiP5ZcWD4f6cZGAKXKKulCjHPuBy6zHfuW9S9Ig
 EmUO6mrJu1Ewbp7sCJTuH0Qys+O2Y4fgH4dV9q9PaJkuTLcT+527EPJYQfwOm8octI/+BDSq8p5
 p
X-Google-Smtp-Source: AGHT+IE66VYRisTK3VeDukaph+QzRAfJUPG3ycekurdrOIJkx2wm+eVCh0QYANUS24X8CjyhPP8D2g==
X-Received: by 2002:ad4:5def:0:b0:6a1:eb9:d4a7 with SMTP id
 6a1803df08f44-6a151528089mr6647336d6.20.1715104548236; 
 Tue, 07 May 2024 10:55:48 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-115-4-214.cpe.net.cable.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 o1-20020a0cecc1000000b006a0f126a033sm4801834qvq.28.2024.05.07.10.55.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 10:55:47 -0700 (PDT)
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
 Sumit Garg <sumit.garg@linaro.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Sergei Antonov <saproj@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Alexander Gendin <agendin@matrox.com>, Eddie James <eajames@linux.ibm.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH v2 09/28] mbedtls: add digest shim layer for MbedTLS
Date: Tue,  7 May 2024 10:50:51 -0700
Message-Id: <20240507175132.1456512-10-raymond.mao@linaro.org>
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

Implement digest shim layer on top of MbedTLS crypto library.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Split the shim layer into separated files and use the original head
  files instead of creating new ones.

 lib/mbedtls/Makefile |   7 +++
 lib/mbedtls/md5.c    |  68 ++++++++++++++++++++++++++
 lib/mbedtls/sha1.c   | 111 +++++++++++++++++++++++++++++++++++++++++++
 lib/mbedtls/sha256.c |  65 +++++++++++++++++++++++++
 lib/mbedtls/sha512.c |  96 +++++++++++++++++++++++++++++++++++++
 5 files changed, 347 insertions(+)
 create mode 100644 lib/mbedtls/md5.c
 create mode 100644 lib/mbedtls/sha1.c
 create mode 100644 lib/mbedtls/sha256.c
 create mode 100644 lib/mbedtls/sha512.c

diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
index 85f0a3cfd07..b8eda9638f4 100644
--- a/lib/mbedtls/Makefile
+++ b/lib/mbedtls/Makefile
@@ -14,6 +14,13 @@ ccflags-y += \
 	-I$(src)/external/mbedtls/library \
 	# This line is intentionally left blank
 
+# shim layer for hash
+obj-$(CONFIG_MBEDTLS_LIB_CRYPTO) += hash_mbedtls.o
+hash_mbedtls-$(CONFIG_$(SPL_)MD5) += md5.o
+hash_mbedtls-$(CONFIG_$(SPL_)SHA1) += sha1.o
+hash_mbedtls-$(CONFIG_$(SPL_)SHA256) += sha256.o
+hash_mbedtls-$(CONFIG_$(SPL_)SHA512) += sha512.o
+
 obj-$(CONFIG_MBEDTLS_LIB_CRYPTO) += mbedtls_lib_crypto.o
 mbedtls_lib_crypto-y := \
 	$(MBEDTLS_LIB_DIR)/aes.o \
diff --git a/lib/mbedtls/md5.c b/lib/mbedtls/md5.c
new file mode 100644
index 00000000000..2488d4f5603
--- /dev/null
+++ b/lib/mbedtls/md5.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Hash shim layer on MbedTLS Crypto library
+ *
+ * Copyright (c) 2023 Linaro Limited
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
+void md5(unsigned char *input, int len, unsigned char output[16])
+{
+	MD5Context context;
+
+	MD5Init(&context);
+	MD5Update(&context, input, len);
+	MD5Final(output, &context);
+}
+
+void md5_wd(const unsigned char *input, unsigned int len,
+	    unsigned char output[16], unsigned int chunk_sz)
+{
+	MD5Context context;
+#if defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG)
+	const unsigned char *end, *curr;
+	int chunk;
+#endif
+
+	MD5Init(&context);
+
+#if defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG)
+	curr = input;
+	end = input + len;
+	while (curr < end) {
+		chunk = end - curr;
+		if (chunk > chunk_sz)
+			chunk = chunk_sz;
+		MD5Update(&context, curr, chunk);
+		curr += chunk;
+		schedule();
+	}
+#else
+	MD5Update(&context, input, len);
+#endif
+
+	MD5Final(output, &context);
+}
diff --git a/lib/mbedtls/sha1.c b/lib/mbedtls/sha1.c
new file mode 100644
index 00000000000..84a13f5c63b
--- /dev/null
+++ b/lib/mbedtls/sha1.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Hash shim layer on MbedTLS Crypto library
+ *
+ * Copyright (c) 2023 Linaro Limited
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
+void sha1_csum(const unsigned char *input, unsigned int ilen,
+	       unsigned char *output)
+{
+	sha1_context ctx;
+
+	sha1_starts(&ctx);
+	sha1_update(&ctx, input, ilen);
+	sha1_finish(&ctx, output);
+}
+
+void sha1_csum_wd(const unsigned char *input, unsigned int ilen,
+		  unsigned char *output, unsigned int chunk_sz)
+{
+	sha1_context ctx;
+#if defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG)
+	const unsigned char *end, *curr;
+	int chunk;
+#endif
+
+	sha1_starts(&ctx);
+
+#if defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG)
+	curr = input;
+	end = input + ilen;
+	while (curr < end) {
+		chunk = end - curr;
+		if (chunk > chunk_sz)
+			chunk = chunk_sz;
+		sha1_update(&ctx, curr, chunk);
+		curr += chunk;
+		schedule();
+	}
+#else
+	sha1_update(&ctx, input, ilen);
+#endif
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
+	unsigned char k_ipad[64];
+	unsigned char k_opad[64];
+	unsigned char tmpbuf[20];
+
+	memset(k_ipad, 0x36, 64);
+	memset(k_opad, 0x5C, 64);
+
+	for (i = 0; i < keylen; i++) {
+		if (i >= 64)
+			break;
+
+		k_ipad[i] ^= key[i];
+		k_opad[i] ^= key[i];
+	}
+
+	sha1_starts(&ctx);
+	sha1_update(&ctx, k_ipad, 64);
+	sha1_update(&ctx, input, ilen);
+	sha1_finish(&ctx, tmpbuf);
+
+	sha1_starts(&ctx);
+	sha1_update(&ctx, k_opad, 64);
+	sha1_update(&ctx, tmpbuf, 20);
+	sha1_finish(&ctx, output);
+
+	memset(k_ipad, 0, 64);
+	memset(k_opad, 0, 64);
+	memset(tmpbuf, 0, 20);
+	memset(&ctx, 0, sizeof(sha1_context));
+}
diff --git a/lib/mbedtls/sha256.c b/lib/mbedtls/sha256.c
new file mode 100644
index 00000000000..45f6c08c5f6
--- /dev/null
+++ b/lib/mbedtls/sha256.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Hash shim layer on MbedTLS Crypto library
+ *
+ * Copyright (c) 2023 Linaro Limited
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
+#if defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG)
+	const unsigned char *end;
+	unsigned char *curr;
+	int chunk;
+#endif
+
+	sha256_starts(&ctx);
+
+#if defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG)
+	curr = (unsigned char *)input;
+	end = input + ilen;
+	while (curr < end) {
+		chunk = end - curr;
+		if (chunk > chunk_sz)
+			chunk = chunk_sz;
+		sha256_update(&ctx, curr, chunk);
+		curr += chunk;
+		schedule();
+	}
+#else
+	sha256_update(&ctx, input, ilen);
+#endif
+
+	sha256_finish(&ctx, output);
+}
diff --git a/lib/mbedtls/sha512.c b/lib/mbedtls/sha512.c
new file mode 100644
index 00000000000..6f7f843b2b2
--- /dev/null
+++ b/lib/mbedtls/sha512.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Hash shim layer on MbedTLS Crypto library
+ *
+ * Copyright (c) 2023 Linaro Limited
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
+#if defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG)
+	const unsigned char *end;
+	unsigned char *curr;
+	int chunk;
+#endif
+
+	sha512_starts(&ctx);
+
+#if defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG)
+	curr = (unsigned char *)input;
+	end = input + ilen;
+	while (curr < end) {
+		chunk = end - curr;
+		if (chunk > chunk_sz)
+			chunk = chunk_sz;
+		sha512_update(&ctx, curr, chunk);
+		curr += chunk;
+		schedule();
+	}
+#else
+	sha512_update(&ctx, input, ilen);
+#endif
+
+	sha512_finish(&ctx, output);
+}
-- 
2.25.1

