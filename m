Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58DD6C52D7D
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 23:00:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0849488C8A;
	Sat, 17 Aug 2024 00:59:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ROFaLAMU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5014588C53; Fri, 16 Aug 2024 23:50:44 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16D9488AA9
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 23:50:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6b791cddfcbso13472566d6.0
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 14:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723845040; x=1724449840; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=78S86b69TE7Vt1P5GqbHdDbzOx60P2EgKEwa4H+r+YU=;
 b=ROFaLAMUigUuj4QClbu7TA9KrMO5IchGqQ/6OuKsgpeTIqMiSKhM0OWKMI5UGtmXpS
 VJh6GfjAURM3zg1KYY2cpdh5YXVVwIhVNdBMtK+scpw9ePyGZjjgv2gvvzFOWhlD1RS8
 bNpp0C0diHyFTnJLIZ+63ZSBL9k1xIVCrIeI4z7h1lcfAuC0p1SJZvU1mXkHG1LRqgjv
 LUgWDTnmojCbY3/NhKECZi7Jg6/UHBc2Bx58alu3nZrRHm8PNviQUBY9/nUPwuIqQ+bA
 WZoHIMwQl8AfI4shmUrOvq3Vfew3brKMHwI7BGY833CZ0Lm24/z780Fo5DO5R1Enx2fW
 XxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723845040; x=1724449840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=78S86b69TE7Vt1P5GqbHdDbzOx60P2EgKEwa4H+r+YU=;
 b=fCVHZOOM8W8sZNDWwyEKw4crXXxv6UVj2lqK7QnJEX7DE0Z0oVJmwv62k2elz5VGqE
 sAiYznPeCTsvz1A96hhRcZrpm162AkQlKw9gbBwZzwso+TCFuVukg9B1Re1Iu+ar6suB
 BJm9W73gyeZG4NJquJV2aEkaqmzN4VhthIMP1yJL08l/3N3DeXPTRl9lNHNFl3J10zCl
 pnE6zOeoyRAJtvwWr3k1sUCHs4vSSP0rjY82mkuBzvBmbosavsMXeeknqwC6D27tHIkL
 ij1k81DPyD9VafxHB6z5qyAayC8IdnWK8xI3cTdEDSawkJCK2iZnhuEYab3+FV3rmV9Y
 BFqw==
X-Gm-Message-State: AOJu0YxNhUZTLVkVtIemSYiv8anxKEKix0yl+LzdRxSSRdShaCgTFUP7
 1JVWBeQ6dudpu9m1eeA9fR3N9dlH2nKiNqueRoOm4WvUhpvVVbUxqFqLvjDc+bzi8VnI4fh3zE/
 dDXM=
X-Google-Smtp-Source: AGHT+IGgNSAs1wl0TywWqntiP1zQjJk2aJgE0vbssltGIDh9S7T7Wb8i3A7fTaJbDkO4bcvWyOx4og==
X-Received: by 2002:a05:6214:2f08:b0:6bd:698f:440f with SMTP id
 6a1803df08f44-6bf7cd79c04mr47842676d6.4.1723845040195; 
 Fri, 16 Aug 2024 14:50:40 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bf6ff04ffbsm22044196d6.128.2024.08.16.14.50.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 14:50:39 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Andrew Davis <afd@ti.com>,
 Sumit Garg <sumit.garg@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Eddie James <eajames@linux.ibm.com>, Anand Moon <linux.amoon@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v6 15/28] pkcs7: move common functions to PKCS7 helper
Date: Fri, 16 Aug 2024 14:44:04 -0700
Message-Id: <20240816214436.1877263-16-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240816214436.1877263-1-raymond.mao@linaro.org>
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 17 Aug 2024 00:59:01 +0200
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
Changes in v6
- None.

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

