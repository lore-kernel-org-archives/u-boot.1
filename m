Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DDCEC30658
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 18:30:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0535887C8;
	Tue,  2 Jul 2024 20:30:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rS9yIXAT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9EE987D33; Tue,  2 Jul 2024 20:30:20 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA9B6887C7
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 20:30:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-44651f094adso20684491cf.1
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 11:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719945017; x=1720549817; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tiSNl9DQWbc7XfMN41/109F+th4+e9WHOe7hpYqFrsQ=;
 b=rS9yIXATfy4NKuX2xnGEMEYa9xyzcH7c071MK8+XGNVoxeCeB6wI9vd3NeImJMPUXD
 DEAqCu5Nv/8mXmLCdaIBqk5JlhbAcOliEtEb39rxXrWTJTGA0kbMCMqPMJM6VCAoBgk3
 VcI92yQdZ0aIkWDbk5mCSShAn+5zHomvzBq+4GXuj3AzRVLju/UHRnNlseKQlAJkiaXg
 cXkYfeFCTwuUQhi8ZpDY81CaaHbTp/B7JAacTbIYx8haiaVQk3Qwl9Aqsv7bd4JEsN2F
 vO9I+wtB+OcgW/jnMCL8wRHYtv4UilMVy9k4qWn7i/pALMEAGB0w618NhNSL0gjvyC+x
 H6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719945017; x=1720549817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tiSNl9DQWbc7XfMN41/109F+th4+e9WHOe7hpYqFrsQ=;
 b=vMYabxxEx6vOxoUYztFrB72+6rOmB7XKt8now6zhrAbL4O3iXR9aakHyX+cweCA/af
 YrGStRMnWpME53HiUmToZvZp4s62vjbXD/XRB2YUXD4nwPIQa5JjysCAwMYKAH3RjdyF
 KKD6GmNVYkGrkGm0SwDsUXXWe0P0SzRGG1/ABFeGr+4azlC4LtvsJHuxb8EorRYMBkfZ
 TtItmEROuk3X523CeCR9fkhXntBJVaYF7SNFeNGch3C8VNqJtgs4q+UWp3KxYbMQl81u
 eKeI9F29miInZKSj7n7fRIBTZZ+1yxFV/b/utwbTcZIaIBagrGIS23hsEcgxaBuolA3A
 wv4A==
X-Gm-Message-State: AOJu0Yz1iVMEQbwk3P2jTcfXVStjLf/EU/GKV685uQW4SZlDD7sncRMO
 /BPKcpgxMZC2qTQRuKQZdpcwCRoEU04Zyqj8X1gTcoPyvbgWhDE65hsPAH/Hv9QjWMzP9cyUDai
 V
X-Google-Smtp-Source: AGHT+IHzyXXQiFZd189DEuXpDmntD0CcNr+uadJ84RurQ/mWM238aI8jwkygzoE60eeu/ZO4iTMnBA==
X-Received: by 2002:ac8:58ca:0:b0:446:596c:5359 with SMTP id
 d75a77b69052e-44662e0bd74mr114818861cf.39.1719945017336; 
 Tue, 02 Jul 2024 11:30:17 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-446514b613dsm43316351cf.84.2024.07.02.11.30.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 11:30:16 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Ilya Lukin <4.shket@gmail.com>, Sergei Antonov <saproj@gmail.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v4 16/29] pkcs7: move common functions to PKCS7 helper
Date: Tue,  2 Jul 2024 11:22:52 -0700
Message-Id: <20240702182325.2904421-17-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240702182325.2904421-1-raymond.mao@linaro.org>
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
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
---
Changes in v4
- Initial patch.

 lib/crypto/Makefile       |  1 +
 lib/crypto/pkcs7_helper.c | 40 +++++++++++++++++++++++++++++++++++++++
 lib/crypto/pkcs7_parser.c | 28 ---------------------------
 3 files changed, 41 insertions(+), 28 deletions(-)
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
index 00000000000..6c8dcd1a935
--- /dev/null
+++ b/lib/crypto/pkcs7_helper.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * PKCS7 helper functions
+ *
+ * Copyright (c) 2012 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * Copyright (c) 2024 Linaro Limited
+ * Author: Raymond Mao <raymond.mao@linaro.org>
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

