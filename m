Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E45CFA745
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 04:59:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE68F8905F;
	Fri,  4 Oct 2024 06:57:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wqqlExQg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DF1888C6D; Thu,  3 Oct 2024 23:58:59 +0200 (CEST)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5354F88D7F
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 23:58:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-4581e0ed0f2so20805211cf.1
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 14:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727992735; x=1728597535; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t2RSn2HlFuhWVc0QgU3RLs99TwPJdYZTazen7HknIRc=;
 b=wqqlExQgxAcT2KJ0GgjAv42mIqLaftuI/vTVKdy3mhtUqxESFLoWosspSqnjHMtsNz
 AfJdw78ybROCy0FIDJguA0usXA9itJG1ZhdjHzBgR5SCEDeGAghoWKbhUwL8iVPfl5oD
 P9e9I8+WjRqITmElMJg5CiOziQzVhq9wqoZxkNPfBVZc3wRTvA35KfRdPqBM+7PB7Vjp
 BKGdypjncHAZ2PG81sskAGf7OrNQRvMiOXi0ixLsEhl1F1LYuGouAtmkeiuXDPdjWxMx
 BFco7pEANQNXEcgcy+hJ/xl6bdWmD9CTbMbprH9Q7068+sULh09EsT1lVMEEbBn2AOBr
 nhag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727992735; x=1728597535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t2RSn2HlFuhWVc0QgU3RLs99TwPJdYZTazen7HknIRc=;
 b=BDzSXrXF2KUc6o4+HI6xM0XKLPXxvMj8Pj6mzCEFVI9sE2YLhvidOc+l0wt3iV2StX
 UshqrdbdWJq8klCvcmRLq2YIWp5L3RO9LWxWcpvypPaMUUFDhTr5YbSXQfC9UzcVgjUu
 /CobsZMjq2IPqmiNP3Jh9Xm51x9uMeRGkURemw2Z1KnZUnccy3ORlhkVMaSa9Tn7vR0Z
 PaAPtTMRkPThnAOGf/4w0Mua6zf1/aQN3Ah9fA4QbCkRlqyBIG9EOtJuDcL9oWc39JDV
 8bULmVhyuosAF24qrUglZmTJlscKPUT9Val/zMr3581ZzDMknrzMl5ttxqOuCuy0rC9v
 MlIA==
X-Gm-Message-State: AOJu0Yx9ybiedhohH3PpXDZbgwi9wShAZIL2N159MJJC+y3iF2mJZaFd
 9Qy1I0plYozCtPa0CtzDBfx0X3x8jRbk+cRrQLgQDKbx8O8N8MKQZuzgoAyr6uTzj7fhJwovVga
 D
X-Google-Smtp-Source: AGHT+IEcQ4Dpu6wjB4rck9EkQ/XQ8qGYipothyNjbD5ApeAIGOHvSUOVTJF36zbDEjuPRI34v1oY7Q==
X-Received: by 2002:a05:622a:13d3:b0:45b:39a7:1d84 with SMTP id
 d75a77b69052e-45d9ba2fe08mr10162661cf.5.1727992734716; 
 Thu, 03 Oct 2024 14:58:54 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45d92ddf5c4sm9001541cf.18.2024.10.03.14.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 14:58:53 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Sean Anderson <seanga2@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Marek Vasut <marex@denx.de>,
 Jonas Karlman <jonas@kwiboo.se>, Greg Malysa <greg.malysa@timesys.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Anand Moon <linux.amoon@gmail.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v8 14/27] pkcs7: move common functions to PKCS7 helper
Date: Thu,  3 Oct 2024 14:50:27 -0700
Message-Id: <20241003215112.3103601-15-raymond.mao@linaro.org>
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
Changes in v7
- None.
Changes in v8
- None

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

