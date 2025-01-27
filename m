Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3528BC02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 15:17:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B868E8142D;
	Mon, 27 Jan 2025 16:17:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xeMW21HM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA2CD81417; Mon, 27 Jan 2025 16:17:21 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC2BA8144F
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 16:17:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7b9bc648736so481992685a.1
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 07:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737991038; x=1738595838; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Zs852+Fr1ECBr+mIkAlkM7fZhKtHWglNMZahIWNmEU=;
 b=xeMW21HMvmDzpfQWTom7ffhJ0d2qGuJIF/lnvfFo1SVviaJmrelzlYHmFOQdjSd5jL
 T+h1GvuuOVdkL7MJrvICyGgpZF3m9lIwJcgI/FoRSIc2YHHzOvTfvaWkTd/4g254QTPF
 d7PfIpfu3MYu/090xdt7oO8UKylj8S+ajBXe8UTfCyqeVa9hz0pUm0ETSjOUPiEkQZXy
 gkWem7AKd9MJULDoxr9QqCed/vJPEQqWiLYlgdF75CDudjYQeTewZS6CfSEvAUQK20gw
 044Q9tBeFNrGNZRTKh5IbZix5IorX4GAU+N0xtggEJ7wX33tUNpn0nxIXZP3mfLMukZg
 DnLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737991038; x=1738595838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Zs852+Fr1ECBr+mIkAlkM7fZhKtHWglNMZahIWNmEU=;
 b=NImjyrovbmpqQggDzyyg/ADYbalfpX30XH4fBOdd7CPu2D88/6+IHHSYEeFwkpgNBx
 eBszqQJXpaE5RBhBiUYHvb+v9aWDIEL/UWIkqLhRkvxtunV/rbsihK4iMjRuZwVfmj48
 RS62eahSk4r2vOHjtI0IMEKkOCrkcwQZJnUKlWGO0q+4zmN/O6Rve6LiNFytDfOzlRUy
 15BjSsOGCJ59a4FWuI1dQS/qXJ9/TKuuUw2x6J9T1Kmz440bB6yZFuW/8BishfTbqM1R
 tQDeaojFIPo2BHLEjU8XlQHpU3UpbK0mDN3l+Vp05PSZQzpNoyr2SX8djb5yvqIgZGoY
 vMew==
X-Gm-Message-State: AOJu0YwKZwuIHWWVDYhbgcO2QojNppDFoJLqvTg6w3q918kGfmKPEkIQ
 p5bEA3jnaPWyRgKgFSgy3HR1lKfj8hJHFHLPYn48ddGenLxKug230XznjdYeiajwzkR7NSPExmc
 n5yM=
X-Gm-Gg: ASbGncv3PWqPI4kOj59r3l2gh9XSsivOyXcoX6TjI5aBtYGAqEvm6tEcbeCDJ6X6sKI
 NRoROqiXfVGKQD3GVMRtACKLBmlRKA3DJ1l5tDlYuc+hKeyOfQgJx4+hLqnmUhbwsVY/q9huxhT
 SjNhjyXj/N/LxYhCcTHo3ZLOUoz8Dr2brIHm5zaZwwslEzdD8KitAL43pN1YHP6oFWsm0qOVM0u
 EULw/NKkciudyBH/aeOO8N1p0dw4+KuXXtA0QyZSgp0yFOR4e7gdaQmLMwBXvZQTqCRy5IEZ+Ql
 pIr++/Mf4EiouqJtuuA+M96eNcdQVDHwzzMI653VeclfwLjXjkES5fFTRajCzb1TKDQcj78c4HV
 iEMs=
X-Google-Smtp-Source: AGHT+IH0rs+bP3aLIQ90nSsA9jukeur78tSpcbqlaoL5kO26U9ZwhsEqWsnHXdwIrSTqf06JOp2eIw==
X-Received: by 2002:a05:620a:2a13:b0:7b6:d8aa:7ef9 with SMTP id
 af79cd13be357-7be6320c0f9mr6406389285a.32.1737991037872; 
 Mon, 27 Jan 2025 07:17:17 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be9af11709sm396693385a.112.2025.01.27.07.17.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 07:17:17 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH 2/3] mbedtls: access mbedtls private members in mscode and
 pkcs7 parser
Date: Mon, 27 Jan 2025 07:16:49 -0800
Message-Id: <20250127151657.648255-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250127151657.648255-1-raymond.mao@linaro.org>
References: <20250127151657.648255-1-raymond.mao@linaro.org>
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

U-Boot requires to access x509_internal.h, mbedtls_sha256_context and
mbedtls_sha1_context in the porting layer, and this requires to
enable MBEDTLS_ALLOW_PRIVATE_ACCESS.

Enable it to mscode and pkcs7_parser to fix a mbedtls internal building
error when X509 is selected.

Moreover, Move it to a separate file to avoid enabling it in multiple
places.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 include/crypto/mscode.h            |  1 +
 include/crypto/pkcs7_parser.h      |  1 +
 include/u-boot/sha1.h              | 12 +-----------
 include/u-boot/sha256.h            | 12 +-----------
 lib/mbedtls/port/mbedtls_options.h | 23 +++++++++++++++++++++++
 5 files changed, 27 insertions(+), 22 deletions(-)
 create mode 100644 lib/mbedtls/port/mbedtls_options.h

diff --git a/include/crypto/mscode.h b/include/crypto/mscode.h
index 678e69001b9..55501c22acb 100644
--- a/include/crypto/mscode.h
+++ b/include/crypto/mscode.h
@@ -10,6 +10,7 @@
 #include <crypto/hash_info.h>
 #endif
 #if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
+#include "mbedtls_options.h"
 #include <mbedtls/asn1.h>
 #include <mbedtls/oid.h>
 #endif
diff --git a/include/crypto/pkcs7_parser.h b/include/crypto/pkcs7_parser.h
index 469c2711fa6..fd1e48da09e 100644
--- a/include/crypto/pkcs7_parser.h
+++ b/include/crypto/pkcs7_parser.h
@@ -12,6 +12,7 @@
 #include <crypto/pkcs7.h>
 #include <crypto/x509_parser.h>
 #if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
+#include "mbedtls_options.h"
 #include <mbedtls/pkcs7.h>
 #include <library/x509_internal.h>
 #include <mbedtls/asn1.h>
diff --git a/include/u-boot/sha1.h b/include/u-boot/sha1.h
index dd66258bbe9..c2d62e9cf0f 100644
--- a/include/u-boot/sha1.h
+++ b/include/u-boot/sha1.h
@@ -18,17 +18,7 @@
 #include <linux/types.h>
 
 #if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
-/*
- * FIXME:
- * MbedTLS define the members of "mbedtls_sha256_context" as private,
- * but "state" needs to be access by arch/arm/cpu/armv8/sha1_ce_glue.
- * MBEDTLS_ALLOW_PRIVATE_ACCESS needs to be enabled to allow the external
- * access.
- * Directly including <external/mbedtls/library/common.h> is not allowed,
- * since this will include <malloc.h> and break the sandbox test.
- */
-#define MBEDTLS_ALLOW_PRIVATE_ACCESS
-
+#include "mbedtls_options.h"
 #include <mbedtls/sha1.h>
 #endif
 
diff --git a/include/u-boot/sha256.h b/include/u-boot/sha256.h
index d7a3403270b..2d86508332e 100644
--- a/include/u-boot/sha256.h
+++ b/include/u-boot/sha256.h
@@ -7,17 +7,7 @@
 #include <linux/types.h>
 
 #if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
-/*
- * FIXME:
- * MbedTLS define the members of "mbedtls_sha256_context" as private,
- * but "state" needs to be access by arch/arm/cpu/armv8/sha256_ce_glue.
- * MBEDTLS_ALLOW_PRIVATE_ACCESS needs to be enabled to allow the external
- * access.
- * Directly including <external/mbedtls/library/common.h> is not allowed,
- * since this will include <malloc.h> and break the sandbox test.
- */
-#define MBEDTLS_ALLOW_PRIVATE_ACCESS
-
+#include "mbedtls_options.h"
 #include <mbedtls/sha256.h>
 #endif
 
diff --git a/lib/mbedtls/port/mbedtls_options.h b/lib/mbedtls/port/mbedtls_options.h
new file mode 100644
index 00000000000..885ed6990b6
--- /dev/null
+++ b/lib/mbedtls/port/mbedtls_options.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Internal build options for MbedTLS
+ *
+ * Copyright (c) 2025 Linaro Limited
+ * Author: Raymond Mao <raymond.mao@linaro.org>
+ */
+
+#ifndef _MBEDTLS_OPT_H
+#define _MBEDTLS_OPT_H
+
+/*
+ * FIXME:
+ * U-Boot/MbedTLS port requires to access a few of members which are defined
+ * as private in MbedTLS context.
+ * E.g: x509_internal.h, mbedtls_sha256_context and mbedtls_sha1_context.
+ * MBEDTLS_ALLOW_PRIVATE_ACCESS needs to be enabled to allow the external
+ * access, but directly including <external/mbedtls/library/common.h> is not
+ * allowed, since this will include <malloc.h> and break the sandbox test.
+ */
+#define MBEDTLS_ALLOW_PRIVATE_ACCESS
+
+#endif /* _MBEDTLS_OPT_H */
-- 
2.25.1

