Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94844C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 19:03:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0555588463;
	Tue, 16 Apr 2024 21:02:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dnXl4HBM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0629088390; Tue, 16 Apr 2024 21:01:57 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A949088448
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 21:01:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-78d683c469dso463759585a.1
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 12:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713294108; x=1713898908; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OJUt6mvRtzMNzOC6rb7Ex5JyAjmcPRMQ0wD/gCfe18A=;
 b=dnXl4HBMaeR78GYfBrtZU6+23f6A2JNwZrOKs1s1rHKottufELskcMi/aPTQh4zBFg
 Bvb26M2s2dOROPngJKse/pZfIAfhntXE/6axkWyvXp6ciu8qa4YAObbxQjPQsG7UjiHd
 r/7XSoY7WRx82iRNn1909VVxl4KqpcNCFO0hIUiXHckzG85TeUmFv7zG/xPUhc2KO+qT
 0DHHRlKUEF+PsY4L2sLX+OMhI6U1qQwC48zl4cDeSr6AXWLnnLnRL3ygDi0hS3LR+nN9
 v3/871LeMCS4nLBjTRosMVnpGCID0ae4HW1CdlGK6Az5qhxowjoVIF3kuD9HgjY+zn0s
 0rUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713294108; x=1713898908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OJUt6mvRtzMNzOC6rb7Ex5JyAjmcPRMQ0wD/gCfe18A=;
 b=HoO7ec8/tcwzeokrSh/4R3lZ8e0+vxU7d6gBx+I+etzUzsM/5fu1zBSL09tZXcCZiM
 qJ5v3tXxNn+5MfKpdW6aJ1ZAUNv3gItcFbQ/LcpTdzjXjLjfiHsgnC0/GqhLhnhQJrby
 GCWkrEhOTky5EhoGz3oJHQqFaa7h3sBCfGa2FvBuvcHyGYB162q9bgwaCv2XVTgEJaPv
 x11bTG/q6boZC2PBYTNQSFn+pQ2coyvdcBAPFFmAeX9UE98m5T1F6TkSOhBqC1urwbJQ
 AA7oiEQ/odQj/gY6L5TnAl5nb7vRPV4LUwJsBQQAiNB2mZvUUHAPdtCh+ftNM4O7GTkS
 TI1A==
X-Gm-Message-State: AOJu0Yx9Y4BlOvuFPYfWVVJSwmTaT/4NtcW7cIsqoApRNq5mOSHVypd0
 e46jergZx4jV3RslTr0egnVU7gHPDS9dYZbH2eZihdApgaJMyyhhJTweB3rvyiFnV9rwOMQxisN
 i
X-Google-Smtp-Source: AGHT+IG5Zmb3sr3PVyKWLnFNKU5FzjmK/XHV2rHRaQHxY89A5/S0EJM1ikcssz1ZY+88LTRiIbbEPA==
X-Received: by 2002:a05:6214:5091:b0:69b:2664:cda2 with SMTP id
 kk17-20020a056214509100b0069b2664cda2mr18924904qvb.8.1713294108345; 
 Tue, 16 Apr 2024 12:01:48 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-115-4-214.cpe.net.cable.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 n13-20020a0cbe8d000000b0069b59fb5829sm5971657qvi.44.2024.04.16.12.01.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 12:01:48 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: raymond.mao@linaro.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 xypron.glpk@gmx.de
Subject: [PATCH 08/23] mbedtls: add hash shim layer
Date: Tue, 16 Apr 2024 12:00:04 -0700
Message-Id: <20240416190019.81016-9-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240416190019.81016-1-raymond.mao@linaro.org>
References: <20240416190019.81016-1-raymond.mao@linaro.org>
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

Create a hash shim layer on top of mbedtls crypto library.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 include/mbedtls/md5.h    |  18 ++++++
 include/mbedtls/sha1.h   |  27 +++++++++
 include/mbedtls/sha256.h |  31 ++++++++++
 include/mbedtls/sha512.h |  39 +++++++++++++
 lib/mbedtls/Makefile     |   3 +
 lib/mbedtls/hash_shim.c  | 118 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 236 insertions(+)
 create mode 100644 include/mbedtls/md5.h
 create mode 100644 include/mbedtls/sha1.h
 create mode 100644 include/mbedtls/sha256.h
 create mode 100644 include/mbedtls/sha512.h
 create mode 100644 lib/mbedtls/hash_shim.c

diff --git a/include/mbedtls/md5.h b/include/mbedtls/md5.h
new file mode 100644
index 0000000000..e5a205efda
--- /dev/null
+++ b/include/mbedtls/md5.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2023 Linaro Limited
+ * Author: Raymond Mao <raymond.mao@linaro.org>
+ */
+#include <external/mbedtls/include/mbedtls/md5.h>
+
+#ifndef _MBEDTLS_MD5_H
+#define _MBEDTLS_MD5_H
+
+#define MD5_SUM_LEN	16
+
+void
+md5_wd_mb(const unsigned char *input, unsigned int len,
+	  unsigned char output[16],
+	  unsigned int __always_unused chunk_sz);
+
+#endif /* _MBEDTLS_MD5_H */
diff --git a/include/mbedtls/sha1.h b/include/mbedtls/sha1.h
new file mode 100644
index 0000000000..f7aff6f652
--- /dev/null
+++ b/include/mbedtls/sha1.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2023 Linaro Limited
+ * Author: Raymond Mao <raymond.mao@linaro.org>
+ */
+#include <external/mbedtls/include/mbedtls/sha1.h>
+
+#ifndef _MBEDTLS_SHA1_H
+#define _MBEDTLS_SHA1_H
+
+#define SHA1_SUM_LEN	20
+#define SHA1_DER_LEN	15
+
+#define CHUNKSZ_SHA1	(64 * 1024)
+
+extern const u8 sha1_der_prefix[];
+
+typedef mbedtls_sha1_context sha1_context;
+
+void sha1_starts_mb(sha1_context *ctx);
+void sha1_update_mb(sha1_context *ctx, const unsigned char *input,
+		    unsigned int length);
+void sha1_finish_mb(sha1_context *ctx, unsigned char output[SHA1_SUM_LEN]);
+void sha1_csum_wd_mb(const unsigned char *input, unsigned int length,
+		     unsigned char *output, unsigned int chunk_sz);
+
+#endif /* _MBEDTLS_SHA1_H */
diff --git a/include/mbedtls/sha256.h b/include/mbedtls/sha256.h
new file mode 100644
index 0000000000..804f2ce8ab
--- /dev/null
+++ b/include/mbedtls/sha256.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2023 Linaro Limited
+ * Author: Raymond Mao <raymond.mao@linaro.org>
+ */
+#include <external/mbedtls/include/mbedtls/sha256.h>
+
+#ifndef _MBEDTLS_SHA256_H
+#define _MBEDTLS_SHA256_H
+
+#define SHA224_SUM_LEN	28
+#define SHA256_SUM_LEN	32
+
+#define SHA224_DER_LEN	19
+#define SHA256_DER_LEN	19
+
+#define CHUNKSZ_SHA224	(64 * 1024)
+#define CHUNKSZ_SHA256	(64 * 1024)
+
+extern const u8 sha256_der_prefix[];
+
+typedef mbedtls_sha256_context sha256_context;
+
+void sha256_starts_mb(sha256_context *ctx);
+void
+sha256_update_mb(sha256_context *ctx, const uint8_t *input, uint32_t length);
+void sha256_finish_mb(sha256_context *ctx, uint8_t digest[SHA256_SUM_LEN]);
+void sha256_csum_wd_mb(const unsigned char *input, unsigned int length,
+		       unsigned char *output, unsigned int chunk_sz);
+
+#endif /* _MBEDTLS_SHA256_H */
diff --git a/include/mbedtls/sha512.h b/include/mbedtls/sha512.h
new file mode 100644
index 0000000000..bc7f2faa0d
--- /dev/null
+++ b/include/mbedtls/sha512.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2023 Linaro Limited
+ * Author: Raymond Mao <raymond.mao@linaro.org>
+ */
+#include <external/mbedtls/include/mbedtls/sha512.h>
+
+#ifndef _MBEDTLS_SHA512_H
+#define _MBEDTLS_SHA512_H
+
+#define SHA384_SUM_LEN	48
+#define SHA512_SUM_LEN	64
+
+#define SHA384_DER_LEN	19
+#define SHA512_DER_LEN	19
+
+#define CHUNKSZ_SHA384	(16 * 1024)
+#define CHUNKSZ_SHA512	(16 * 1024)
+
+extern const u8 sha384_der_prefix[];
+extern const u8 sha512_der_prefix[];
+
+typedef mbedtls_sha512_context sha384_context;
+typedef mbedtls_sha512_context sha512_context;
+
+void sha384_starts_mb(sha512_context *ctx);
+void
+sha384_update_mb(sha512_context *ctx, const uint8_t *input, uint32_t length);
+void sha384_finish_mb(sha512_context *ctx, uint8_t digest[SHA384_SUM_LEN]);
+void sha384_csum_wd_mb(const unsigned char *input, unsigned int length,
+		       unsigned char *output, unsigned int chunk_sz);
+void sha512_starts_mb(sha512_context *ctx);
+void
+sha512_update_mb(sha512_context *ctx, const uint8_t *input, uint32_t length);
+void sha512_finish_mb(sha512_context *ctx, uint8_t digest[SHA512_SUM_LEN]);
+void sha512_csum_wd_mb(const unsigned char *input, unsigned int length,
+		       unsigned char *output, unsigned int chunk_sz);
+
+#endif /* _MBEDTLS_SHA512_H */
diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
index 85f0a3cfd0..5d41ddbd8d 100644
--- a/lib/mbedtls/Makefile
+++ b/lib/mbedtls/Makefile
@@ -14,6 +14,9 @@ ccflags-y += \
 	-I$(src)/external/mbedtls/library \
 	# This line is intentionally left blank
 
+# shim layer for hash
+obj-$(CONFIG_MBEDTLS_LIB_CRYPTO) += hash_shim.o
+
 obj-$(CONFIG_MBEDTLS_LIB_CRYPTO) += mbedtls_lib_crypto.o
 mbedtls_lib_crypto-y := \
 	$(MBEDTLS_LIB_DIR)/aes.o \
diff --git a/lib/mbedtls/hash_shim.c b/lib/mbedtls/hash_shim.c
new file mode 100644
index 0000000000..982718efed
--- /dev/null
+++ b/lib/mbedtls/hash_shim.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Hash shim layer on MbedTLS Crypto library
+ *
+ * Copyright (c) 2023 Linaro Limited
+ * Author: Raymond Mao <raymond.mao@linaro.org>
+ */
+
+#include "common.h"
+#include <malloc.h>
+#include <mbedtls/sha1.h>
+#include <mbedtls/sha256.h>
+#include <mbedtls/sha512.h>
+#include <mbedtls/md5.h>
+
+void sha1_starts_mb(sha1_context *ctx)
+{
+	mbedtls_sha1_init(ctx);
+	mbedtls_sha1_starts(ctx);
+}
+
+void sha1_update_mb(sha1_context *ctx, const unsigned char *input,
+		    unsigned int length)
+{
+	mbedtls_sha1_update(ctx, input, length);
+}
+
+void sha1_finish_mb(sha1_context *ctx, unsigned char output[SHA1_SUM_LEN])
+{
+	mbedtls_sha1_finish(ctx, output);
+	mbedtls_sha1_free(ctx);
+}
+
+void sha1_csum_wd_mb(const unsigned char *input, unsigned int length,
+		     unsigned char *output, unsigned int chunk_sz)
+{
+	mbedtls_sha1(input, length, output);
+}
+
+void sha256_starts_mb(sha256_context *ctx)
+{
+	mbedtls_sha256_init(ctx);
+	mbedtls_sha256_starts(ctx, 0);
+}
+
+void
+sha256_update_mb(sha256_context *ctx, const uint8_t *input, uint32_t length)
+{
+	mbedtls_sha256_update(ctx, input, length);
+}
+
+void sha256_finish_mb(sha256_context *ctx, uint8_t digest[SHA256_SUM_LEN])
+{
+	mbedtls_sha256_finish(ctx, digest);
+	mbedtls_sha256_free(ctx);
+}
+
+void sha256_csum_wd_mb(const unsigned char *input, unsigned int length,
+		       unsigned char *output, unsigned int chunk_sz)
+{
+	mbedtls_sha256(input, length, output, 0);
+}
+
+void sha384_starts_mb(sha512_context *ctx)
+{
+	mbedtls_sha512_init(ctx);
+	mbedtls_sha512_starts(ctx, 1);
+}
+
+void
+sha384_update_mb(sha512_context *ctx, const uint8_t *input, uint32_t length)
+{
+	mbedtls_sha512_update(ctx, input, length);
+}
+
+void sha384_finish_mb(sha512_context *ctx, uint8_t digest[SHA384_SUM_LEN])
+{
+	mbedtls_sha512_finish(ctx, digest);
+	mbedtls_sha512_free(ctx);
+}
+
+void sha384_csum_wd_mb(const unsigned char *input, unsigned int length,
+		       unsigned char *output, unsigned int chunk_sz)
+{
+	mbedtls_sha512(input, length, output, 1);
+}
+
+void sha512_starts_mb(sha512_context *ctx)
+{
+	mbedtls_sha512_init(ctx);
+	mbedtls_sha512_starts(ctx, 0);
+}
+
+void
+sha512_update_mb(sha512_context *ctx, const uint8_t *input, uint32_t length)
+{
+	mbedtls_sha512_update(ctx, input, length);
+}
+
+void sha512_finish_mb(sha512_context *ctx, uint8_t digest[SHA512_SUM_LEN])
+{
+	mbedtls_sha512_finish(ctx, digest);
+	mbedtls_sha512_free(ctx);
+}
+
+void sha512_csum_wd_mb(const unsigned char *input, unsigned int length,
+		       unsigned char *output, unsigned int chunk_sz)
+{
+	mbedtls_sha512(input, length, output, 0);
+}
+
+void
+md5_wd_mb(const unsigned char *input, unsigned int len,
+	  unsigned char output[16], unsigned int __always_unused chunk_sz)
+{
+	mbedtls_md5(input, len, output);
+}
+
-- 
2.25.1

