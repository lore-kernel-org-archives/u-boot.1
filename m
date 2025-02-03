Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC95FC02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 22:08:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BACE80137;
	Mon,  3 Feb 2025 23:08:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Rt2xMtTx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9D8080050; Mon,  3 Feb 2025 23:08:48 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A5B9801DE
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 23:08:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7be8f281714so446212385a.1
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 14:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738620525; x=1739225325; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fD41BSgApx0p7NFljC/PYwO2FhY/j+AVWD32Rw0vgz0=;
 b=Rt2xMtTxz7t3VIlU+adq4O3QqGCdWeo85/z5ikFRn57HX1gfC9CMi9uCu8hG07oqbk
 /7KTWmjff7DPNc6ZDKeM1pAY83OTx3uzThXkcnkBbFuwrAD0c6xFoUGu/Z4Rgx/+9WyJ
 KVxy8ZFU001EtV1YQRxdXbrRq72WGh/ATvhJtJMB4g0MuUqve0IFzfPi7zG71CB5rpaT
 ucclBwk0kf0Tf9X1hNziUGcRDjWojW1ikeTaqzToTyDDefYg0s5SD9t//ZGLYZbNOesR
 5qozloZkedw+KKMijWPahNLMEe1/Sy9KVOJcn5UR6RwZmVy+IkDlIxme9tzmkxlts4l1
 rP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738620525; x=1739225325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fD41BSgApx0p7NFljC/PYwO2FhY/j+AVWD32Rw0vgz0=;
 b=Gb1LYnqmuLnvDfBFGHEksZwW7GZ3HGoCwQM7xe6hcV37IzvJHRpYDQtbmnPhbTv0F3
 o2wMgGlkbyVE6Tui2MA9m3xDJLPvQTlC9sqCuqBPUrpjt/hsBOTDmXpYT8SsG4hxTpe9
 a5JSjK7GWMZHhLYpW8zm0G3UEcTd2XKsZ6kWicRO5fW6VDvoBUWpJ0kqb723h0i78ko8
 QZfmc87pOxiWehEZQ8slvLNXWBWNERGNx5z91Civp07sYuHFO0o/hMHVbM9778oTw5iS
 xC7df9c/yRrZuSrxay1a2EeLoxxHKNHBGjKKx+xRz818PZexAqysq5eydeLI8KrnxhJr
 EmbQ==
X-Gm-Message-State: AOJu0YyEo81UhBf0Rg4Ic9pUGTx38Ud4yF4osWv5ytma/787xa12YV2C
 1ue8Bf8N6o2KW3QCADPf58fo4x+hY5V9KQgD3nkg4lGKFIiOjooH6KhkJYpPRCKLx2N5RFCzPhe
 ZSgw=
X-Gm-Gg: ASbGnctdNcGckfefoIc+yfST1gEFsWFwOopGAeqxjxaHmnZvetyVKz265bwtR7siglp
 hOValn7rnBmhUssA64SpjMdwXX9khndmHqLaO1LHnj1ldJhXSrQIctkl7sX13if15I75P1wmNMQ
 kd3o9fmXHKWJoa3/o5bJkzvkdvALx+y0KXZw7Y6mnFB+ZTOn2BIVOYeTFZsioQWCIrFteIgxgm0
 BxPD7rOKUv974yRatzqOicWQ2OUn5PSsC1xSoVmHyaUgMeZUE0VqFc6Nfr6WveHk17NqjUEHtwi
 sm3i45wmfoWsXOBPfI5hTWzcIDy9wSqhg5RIwMhnV352Ql92zRKuNnUT9M057Yqhcr+aJBYyOWC
 Y7IgweyLjWZ0U6Q==
X-Google-Smtp-Source: AGHT+IEtEIQ4zTXSglH//paqYHrTX8EkN5IlGBCqDhbbqSylrXe0eoE/GJGH2wI1Pv5vHpgdeGJL9A==
X-Received: by 2002:a05:620a:2694:b0:7b6:d252:b4ef with SMTP id
 af79cd13be357-7bffcda12c9mr3970359385a.53.1738620524803; 
 Mon, 03 Feb 2025 14:08:44 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c00a8d8700sm569781085a.49.2025.02.03.14.08.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 14:08:43 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v2 2/3] mbedtls: access mbedtls private members in mscode and
 pkcs7 parser
Date: Mon,  3 Feb 2025 14:08:13 -0800
Message-Id: <20250203220825.707590-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250203220825.707590-1-raymond.mao@linaro.org>
References: <20250203220825.707590-1-raymond.mao@linaro.org>
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
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v2:
- None.

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

