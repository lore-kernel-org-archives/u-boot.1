Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6886C3065C
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 18:30:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61A6A887C0;
	Tue,  2 Jul 2024 20:30:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="g1PWyBO6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31F66887C1; Tue,  2 Jul 2024 20:29:59 +0200 (CEST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F01CF87D33
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 20:29:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-4464c31a874so22299781cf.2
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 11:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719944995; x=1720549795; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2YaA+hS24uk71OQHWWbaKeNWt94mmaG9VTyW2Eh/SdY=;
 b=g1PWyBO6Vc3Y/f2c0zq/LJByQgrHD2otWS8XWEqGOE1EJi2N+U6vSsSQ475rtoU5h8
 Uy4MQzKQfviGzScBmAVoOB7IPAMaTuw78jbioAYn0fFgfO25EYs/cR8Ovz5Z+j+0EFUw
 1OXHSrIpndK0zzBaXryBt00xSYv3yc04xQnexTZBhCgwS1VqonecbaCx/HY6hc5pTDip
 2tNuAdXqY4qRwYyuSxS7/N2dbewzuSxyhhgiuhdqnzcENwly6EIQfTmfcLKd0IW7sFmb
 MxdfZkVNIQ2l1xQqk1HpJIUOUXBeogPjgMytNjlQy/2CE86H+8g40OC0xecnXQ4LFuel
 ZUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719944995; x=1720549795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2YaA+hS24uk71OQHWWbaKeNWt94mmaG9VTyW2Eh/SdY=;
 b=EgFjemiIDTD/xl5Ti5tYFaWHNHBK9S93brcNblvXz0S/mxbqZpIEwK1XnxEHYuUT9I
 TKZ2ZaSJtnCbQkB9wLVUAxPb91A7WNIz98Xk9TOTefSv9jWStULuIVJLmp0tdgPZC8Fr
 40pVenCvDwzUk+IUlBCeKFCEV7pezLq4ophrZ15Id59lWNDBFr9mRuhHSt5z+cgBoDZt
 igkGDYLPjkKS4gbZELmfr3o9TRRmASMlv5mm42/m3r91T2KHjU9Z6/ges/bS971r7KGq
 lJMpuTeZ1utAYGWzT5e5tVStthNx0PaS9CtDZYj6eErhbagqr6EKY7AYEJZCmkI/a58Q
 iCEg==
X-Gm-Message-State: AOJu0Yz2ktWjcFVxHHgg28JYApCJm5ivAzcqrNnxRYuQxmOfTzZ1XeEU
 VF+D5klM/K2otX/GkoNt9R0AQv8Qyxw7Q9aDuNLqPsW6+EtzZaqO8rRJFmrIXMxUL2unxAXjVJ1
 9
X-Google-Smtp-Source: AGHT+IGbGGlNI68/aeAnpl1LnEUFuPfmLuw0PeAJHgIQq7r1L/EEnw/DZZPC8m/pwRg1ygFeqbJhmQ==
X-Received: by 2002:ac8:5f0b:0:b0:446:3fa5:255 with SMTP id
 d75a77b69052e-44662e5d025mr112870671cf.54.1719944995617; 
 Tue, 02 Jul 2024 11:29:55 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-446514b613dsm43316351cf.84.2024.07.02.11.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 11:29:55 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Sergei Antonov <saproj@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v4 15/29] x509: move common functions to x509 helper
Date: Tue,  2 Jul 2024 11:22:51 -0700
Message-Id: <20240702182325.2904421-16-raymond.mao@linaro.org>
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

Move x509_check_for_self_signed as a common helper function
that can be shared by legacy crypto lib and MbedTLS implementation.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v4
- Initial patch.

 lib/crypto/Makefile          |  1 +
 lib/crypto/x509_helper.c     | 67 ++++++++++++++++++++++++++++++++++++
 lib/crypto/x509_public_key.c | 56 +-----------------------------
 3 files changed, 69 insertions(+), 55 deletions(-)
 create mode 100644 lib/crypto/x509_helper.c

diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index 4ad1849040d..946cc3a7b59 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -37,6 +37,7 @@ x509_key_parser-y := \
 	x509.asn1.o \
 	x509_akid.asn1.o \
 	x509_cert_parser.o \
+	x509_helper.o \
 	x509_public_key.o
 
 $(obj)/x509_cert_parser.o: \
diff --git a/lib/crypto/x509_helper.c b/lib/crypto/x509_helper.c
new file mode 100644
index 00000000000..d0c80907ec3
--- /dev/null
+++ b/lib/crypto/x509_helper.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * X509 helper functions
+ *
+ * Copyright (C) 2012 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * Copyright (c) 2024 Linaro Limited
+ * Author: Raymond Mao <raymond.mao@linaro.org>
+ */
+#include <linux/err.h>
+#include <crypto/public_key.h>
+#include <crypto/x509_parser.h>
+
+/*
+ * Check for self-signedness in an X.509 cert and if found, check the signature
+ * immediately if we can.
+ */
+int x509_check_for_self_signed(struct x509_certificate *cert)
+{
+	int ret = 0;
+
+	if (cert->raw_subject_size != cert->raw_issuer_size ||
+	    memcmp(cert->raw_subject, cert->raw_issuer,
+		   cert->raw_issuer_size))
+		goto not_self_signed;
+
+	if (cert->sig->auth_ids[0] || cert->sig->auth_ids[1]) {
+		/*
+		 * If the AKID is present it may have one or two parts. If
+		 * both are supplied, both must match.
+		 */
+		bool a = asymmetric_key_id_same(cert->skid,
+						cert->sig->auth_ids[1]);
+		bool b = asymmetric_key_id_same(cert->id,
+						cert->sig->auth_ids[0]);
+
+		if (!a && !b)
+			goto not_self_signed;
+
+		ret = -EKEYREJECTED;
+		if (((a && !b) || (b && !a)) &&
+		    cert->sig->auth_ids[0] && cert->sig->auth_ids[1])
+			goto out;
+	}
+
+	ret = -EKEYREJECTED;
+	if (strcmp(cert->pub->pkey_algo, cert->sig->pkey_algo))
+		goto out;
+
+	ret = public_key_verify_signature(cert->pub, cert->sig);
+	if (ret == -ENOPKG) {
+		cert->unsupported_sig = true;
+		goto not_self_signed;
+	}
+	if (ret < 0)
+		goto out;
+
+	pr_devel("Cert Self-signature verified");
+	cert->self_signed = true;
+
+out:
+	return ret;
+
+not_self_signed:
+	return 0;
+}
diff --git a/lib/crypto/x509_public_key.c b/lib/crypto/x509_public_key.c
index a10145a7cdc..4ba13c1adc3 100644
--- a/lib/crypto/x509_public_key.c
+++ b/lib/crypto/x509_public_key.c
@@ -139,61 +139,7 @@ error:
 	return ret;
 }
 
-/*
- * Check for self-signedness in an X.509 cert and if found, check the signature
- * immediately if we can.
- */
-int x509_check_for_self_signed(struct x509_certificate *cert)
-{
-	int ret = 0;
-
-	pr_devel("==>%s()\n", __func__);
-
-	if (cert->raw_subject_size != cert->raw_issuer_size ||
-	    memcmp(cert->raw_subject, cert->raw_issuer,
-		   cert->raw_issuer_size) != 0)
-		goto not_self_signed;
-
-	if (cert->sig->auth_ids[0] || cert->sig->auth_ids[1]) {
-		/* If the AKID is present it may have one or two parts.  If
-		 * both are supplied, both must match.
-		 */
-		bool a = asymmetric_key_id_same(cert->skid, cert->sig->auth_ids[1]);
-		bool b = asymmetric_key_id_same(cert->id, cert->sig->auth_ids[0]);
-
-		if (!a && !b)
-			goto not_self_signed;
-
-		ret = -EKEYREJECTED;
-		if (((a && !b) || (b && !a)) &&
-		    cert->sig->auth_ids[0] && cert->sig->auth_ids[1])
-			goto out;
-	}
-
-	ret = -EKEYREJECTED;
-	if (strcmp(cert->pub->pkey_algo, cert->sig->pkey_algo) != 0)
-		goto out;
-
-	ret = public_key_verify_signature(cert->pub, cert->sig);
-	if (ret < 0) {
-		if (ret == -ENOPKG) {
-			cert->unsupported_sig = true;
-			ret = 0;
-		}
-		goto out;
-	}
-
-	pr_devel("Cert Self-signature verified");
-	cert->self_signed = true;
-
-out:
-	pr_devel("<==%s() = %d\n", __func__, ret);
-	return ret;
-
-not_self_signed:
-	pr_devel("<==%s() = 0 [not]\n", __func__);
-	return 0;
-}
+#endif /* !CONFIG_IS_ENABLED(MBEDTLS_LIB_X509) */
 
 #ifndef __UBOOT__
 /*
-- 
2.25.1

