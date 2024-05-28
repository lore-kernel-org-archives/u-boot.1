Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA75EC27C44
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 14:12:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07526884C8;
	Tue, 28 May 2024 16:12:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DmOI8u9g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C48808850F; Tue, 28 May 2024 16:12:27 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 494A587D70
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 16:12:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5b96a95c5e8so524130eaf.3
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 07:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716905544; x=1717510344; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B0YK94EWNR5YKprnrKrFVUKiuPYoV7fFUDq2SZhE0wY=;
 b=DmOI8u9gEZlBqsYg3L7lUuWX7559bFmLYjQphbafUX6C797TRtcWk5GgU3BriOI9iT
 lgvovtmNYcM1fORiAQOyKWHux9Rlfg+ZcjorjZzEPOONHaZyO0rf5kAjcdNh+djBc/i1
 beC0aTZpsbLzz0uR+yk+5Lw3/s38x5VhShJ2z44t3rJT8agqmDXXZZOIKiylbHQSDYtp
 7VCtIzO6E5Lr95/EV6RvsCTQYM4+f13P8f4TCuFiMgWzBmzBFfVmI5hM0+Sa5O9G5zSm
 75QpIUk59Xxac/4jD80g7bVvtONXKKrK8u0DKkktjuf+zOufsUI4FHlR4rpPfxft99pM
 3oCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716905544; x=1717510344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B0YK94EWNR5YKprnrKrFVUKiuPYoV7fFUDq2SZhE0wY=;
 b=qgRKILoaF9iznznuBmYuqLMOMRWf+V7iwBYuCF23h27NRMxzs/fKNQ4J1BJFwuY1e0
 uTKMlGEF9abGdaYlHn5IJXsqjf5Y90pYzSwn5hEqI7GRDPlpZjdVRjxV+nifbEFe1WbC
 zUgwmmNeZlOTYhsUsCgPrKaZBT1A3sH2syF9zvdxiQ4fqpHTcWIatlZQkdMXF+7mCIan
 ns/J+Ubxts5rMD3ziWpr2bB/PmYOfVNcIBpRAKTLPVS0TWuWmFRxpEfIc5qMkPJu93Qg
 ziFGv6peImGnP9nhxcuB9pq3ysWLWcRAZ1bFw/NIfFxWPbdb3TzHU2dinUtwkXwcvEUK
 5vhQ==
X-Gm-Message-State: AOJu0YzBGp7/Yp+vRlCAa0fXcA2WGii89rKy94KgIoago9Yg1HEdPL5x
 IbfYIfPD1S94Kc8xc+rPh6frsdQqwIpL4NqZ7J6/oTxcyxDDT0tOTfpSep11rQmRCMBkaY4FlAj
 nAl4=
X-Google-Smtp-Source: AGHT+IEwwnG3mpAVO55dNJNEcHmV2NjWUzJSIVV2em2o0cvIYAhhKG2L73XYA3Nx3tYnJDINFg+YGQ==
X-Received: by 2002:a05:6358:d091:b0:183:55bf:3442 with SMTP id
 e5c5f4694b2df-197e483f5c6mr1154473155d.0.1716905543524; 
 Tue, 28 May 2024 07:12:23 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794abcc5844sm381033685a.53.2024.05.28.07.12.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:12:23 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Stefan Bosch <stefan_b@posteo.net>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Sergei Antonov <saproj@gmail.com>,
 Ilya Lukin <4.shket@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v3 06/25] mbedtls: add digest shim layer for MbedTLS
Date: Tue, 28 May 2024 07:09:17 -0700
Message-Id: <20240528140955.1960172-7-raymond.mao@linaro.org>
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

Implement digest shim layer on top of MbedTLS crypto library.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Split the shim layer into separated files and use the original head
  files instead of creating new ones.
Changes in v3
- Refactored sha1_hmac and removed non-watchdog md5 function.

 include/u-boot/sha1.h |   4 ++
 lib/mbedtls/Makefile  |   7 +++
 lib/mbedtls/md5.c     |  59 ++++++++++++++++++++++
 lib/mbedtls/sha1.c    | 111 ++++++++++++++++++++++++++++++++++++++++++
 lib/mbedtls/sha256.c  |  65 +++++++++++++++++++++++++
 lib/mbedtls/sha512.c  |  96 ++++++++++++++++++++++++++++++++++++
 6 files changed, 342 insertions(+)
 create mode 100644 lib/mbedtls/md5.c
 create mode 100644 lib/mbedtls/sha1.c
 create mode 100644 lib/mbedtls/sha256.c
 create mode 100644 lib/mbedtls/sha512.c

diff --git a/include/u-boot/sha1.h b/include/u-boot/sha1.h
index ee46fe947a0..6120284ad4f 100644
--- a/include/u-boot/sha1.h
+++ b/include/u-boot/sha1.h
@@ -37,6 +37,10 @@ extern "C" {
 #define SHA1_SUM_LEN	20
 #define SHA1_DER_LEN	15
 
+#define K_IPAD_VAL 0x36
+#define K_OPAD_VAL 0x5C
+#define K_PAD_LEN 64
+
 extern const uint8_t sha1_der_prefix[];
 
 #if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
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
index 00000000000..aa8c159f66f
--- /dev/null
+++ b/lib/mbedtls/md5.c
@@ -0,0 +1,59 @@
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
index 00000000000..3d863b2af7f
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

