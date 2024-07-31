Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0DC7C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 17:31:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4492488A68;
	Wed, 31 Jul 2024 19:31:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MROkUwfh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C51088A7D; Wed, 31 Jul 2024 19:31:34 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63FAA86FB1
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 19:31:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7a1d066a5daso413789585a.3
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 10:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722447091; x=1723051891; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J1GzkvNLSw3Yqv7lJxTqOpiqHvEcc3DdaXaXhDO2rM8=;
 b=MROkUwfhZBfqr5RhoiRQSO6G+3G1TScHsYozsNmQeEqhXczS2IAwuv8Fe1VdQ6HjFD
 b/aUs6RNuwP1exlpBi6zKIGGxiWBGLvAHYIJMhDxrAG4hEnaYtKidJXemKBNH2OtsRge
 m/rDwUTdcke38mK02o7GDS/D4ddCSvks9QXzK/+TsRzd80rjzuTZlvb+Bqqk/zKEcTpI
 44HC3AUsSuc+hEIFV8mIn20+k6eIdT6xzvwD/026IfRPMLAnRLXdZl8BB5oRcB4kr+jU
 tz6YFLOc775doliISp3QlKA0veGbUaCztqN3gwP2+EeNbQ1UsEoGO5+dhO/muroHUx69
 Hpyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722447091; x=1723051891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J1GzkvNLSw3Yqv7lJxTqOpiqHvEcc3DdaXaXhDO2rM8=;
 b=lXes/6IegM7HKnaxRlIuch2xl4tupYeyIzE38NgVW+/qsAZHyR0ehR4lw6kHGJfki8
 A0mK38nQ+hYCnxvKSSmEBPfJvse4/P68BQoGTiWLolb3HxzVCBxN3xEoYM9j6F8GeWdw
 dz/m9JKLuel0tYqS8eF6HkJz7rmwUOmrzA5oitSFJ7IAN9jMJbJIavV0UjQKNnmBXWGa
 hbKzxOciqozMrFcXGcYCO+nF+ElBvnnLhbHEWUWW+oAgzQBY2XJMNp31KaCgc+P7bgnS
 yFvHtifp0tbeR+e3gWkv3zW3ARFbZPBEnfpZecKgkNNnarFdFx9klaqX2b2DWMdIUsha
 EVMA==
X-Gm-Message-State: AOJu0YykJOcNMeHpJyAxlwSyUMRdVB2baIgbso8cX9CKMcBsXmMxlzxh
 8dDTvWZJzBZc0W849HJDKNJRDQmm9w7+SX2+oJErTTlPgr5GvWj9fVL/eAQbdaZy4l9A6dS+t1p
 e3yY=
X-Google-Smtp-Source: AGHT+IGfWgSKTxAW+Wg88IXoaVfyzxWdE4er+4DUdfa28711hyZjxYgQELEnDDXpbYvjCwVAiRtLHQ==
X-Received: by 2002:a05:620a:40c3:b0:79f:1828:4279 with SMTP id
 af79cd13be357-7a1e5224386mr1922833085a.4.1722447091016; 
 Wed, 31 Jul 2024 10:31:31 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a1d73b378fsm779452485a.37.2024.07.31.10.31.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 10:31:30 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>,
 Sumit Garg <sumit.garg@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v5 14/27] pkcs7: move common functions to PKCS7 helper
Date: Wed, 31 Jul 2024 10:25:24 -0700
Message-Id: <20240731172556.1348487-15-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240731172556.1348487-1-raymond.mao@linaro.org>
References: <20240731172556.1348487-1-raymond.mao@linaro.org>
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

Move pkcs7_get_content_data as a helper function that can be
shared by legacy crypto lib and MbedTLS implementation.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v4
- Initial patch.
Changes in v5
- Remove authorship.

 lib/crypto/Makefile       |  1 +
 lib/crypto/pkcs7_helper.c | 37 +++++++++++++++++++++++++++++++++++++
 lib/crypto/pkcs7_parser.c | 28 ----------------------------
 3 files changed, 38 insertions(+), 28 deletions(-)
 create mode 100644 lib/crypto/pkcs7_helper.c

diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index 946cc3a7b59..16059088f26 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -53,6 +53,7 @@ $(obj)/x509_akid.asn1.o: $(obj)/x509_akid.asn1.c $(obj)/x509_akid.asn1.h
 obj-$(CONFIG_$(SPL_)PKCS7_MESSAGE_PARSER) += pkcs7_message.o
 pkcs7_message-y := \
 	pkcs7.asn1.o \
+	pkcs7_helper.o \
 	pkcs7_parser.o
 obj-$(CONFIG_$(SPL_)PKCS7_VERIFY) += pkcs7_verify.o
 
diff --git a/lib/crypto/pkcs7_helper.c b/lib/crypto/pkcs7_helper.c
new file mode 100644
index 00000000000..bb3b9d1354f
--- /dev/null
+++ b/lib/crypto/pkcs7_helper.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * PKCS7 helper functions
+ *
+ * Copyright (c) 2012 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+#include <linux/kernel.h>
+#include <linux/err.h>
+#include <crypto/pkcs7_parser.h>
+
+/**
+ * pkcs7_get_content_data - Get access to the PKCS#7 content
+ * @pkcs7: The preparsed PKCS#7 message to access
+ * @_data: Place to return a pointer to the data
+ * @_data_len: Place to return the data length
+ * @_headerlen: Size of ASN.1 header not included in _data
+ *
+ * Get access to the data content of the PKCS#7 message.  The size of the
+ * header of the ASN.1 object that contains it is also provided and can be used
+ * to adjust *_data and *_data_len to get the entire object.
+ *
+ * Returns -ENODATA if the data object was missing from the message.
+ */
+int pkcs7_get_content_data(const struct pkcs7_message *pkcs7,
+			   const void **_data, size_t *_data_len,
+			   size_t *_headerlen)
+{
+	if (!pkcs7->data)
+		return -ENODATA;
+
+	*_data = pkcs7->data;
+	*_data_len = pkcs7->data_len;
+	if (_headerlen)
+		*_headerlen = pkcs7->data_hdrlen;
+	return 0;
+}
diff --git a/lib/crypto/pkcs7_parser.c b/lib/crypto/pkcs7_parser.c
index d5efa828d6a..c849dc0d92d 100644
--- a/lib/crypto/pkcs7_parser.c
+++ b/lib/crypto/pkcs7_parser.c
@@ -182,34 +182,6 @@ out_no_ctx:
 }
 EXPORT_SYMBOL_GPL(pkcs7_parse_message);
 
-/**
- * pkcs7_get_content_data - Get access to the PKCS#7 content
- * @pkcs7: The preparsed PKCS#7 message to access
- * @_data: Place to return a pointer to the data
- * @_data_len: Place to return the data length
- * @_headerlen: Size of ASN.1 header not included in _data
- *
- * Get access to the data content of the PKCS#7 message.  The size of the
- * header of the ASN.1 object that contains it is also provided and can be used
- * to adjust *_data and *_data_len to get the entire object.
- *
- * Returns -ENODATA if the data object was missing from the message.
- */
-int pkcs7_get_content_data(const struct pkcs7_message *pkcs7,
-			   const void **_data, size_t *_data_len,
-			   size_t *_headerlen)
-{
-	if (!pkcs7->data)
-		return -ENODATA;
-
-	*_data = pkcs7->data;
-	*_data_len = pkcs7->data_len;
-	if (_headerlen)
-		*_headerlen = pkcs7->data_hdrlen;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(pkcs7_get_content_data);
-
 /*
  * Note an OID when we find one for later processing when we know how
  * to interpret it.
-- 
2.25.1

