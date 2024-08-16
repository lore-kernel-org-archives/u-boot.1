Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB4EC3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 21:50:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5FDB88C21;
	Fri, 16 Aug 2024 23:50:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ae1akc0f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67BAE88C4D; Fri, 16 Aug 2024 23:50:21 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34A1988AA9
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 23:50:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6b79293a858so12408136d6.3
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 14:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723845018; x=1724449818; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YAZYtzLYyECdfdtttrdP0YJc54dxhPLtxN6Cp3Swj6c=;
 b=Ae1akc0fV5iLLU7XXXMIXzhTX7GfiFk3TYReUYdwcBQ0FEAKIueDleaK8U4AvTy59A
 dQpGBePER2QLfcVoGIHyDyDyvmFmzPSMkOZdXFqY2X31xkP/tIY9IRc6IZFtf7kkIshf
 M7CMD6S1K3EAwxHKwhQn9DKr/kgmrHrglXcsJ67njlHqMs8ywgD6JQGbcIZfyOwISEw9
 nNo6hTkMt1HGp1Vn94j5+pSkiLiYVuuvtBbP7gPjjJEQSUm/sLOosfAMkjVFtXqoJsfd
 Ym83GWUwStKFA50wqQ2/ef72lOlKt6VsrrN664WYzynJrqR4m726SPmtHCr8R1vaWNyG
 STMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723845018; x=1724449818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YAZYtzLYyECdfdtttrdP0YJc54dxhPLtxN6Cp3Swj6c=;
 b=UruofwxiTtb/pC1kRnc5KA1vRoezkaJHDIzq4sU8/xa66ty1FtHEwrFaey7TU1H69h
 wMAq/JZUurOAMDYnenzABIrjf47HXZ8mbqUvdbO/QsbXn2nO0XhxvU+q9v9xnpeAeRbV
 oSoQru/BgzRQJMydeXFtRE75U/VC+YB4FnUNu2TMKcyTH625G2aTCO4HdY004jeMbgmS
 ubXgjN4Q9TKPBPnr/sofnLvX1QXCwAGlGSUysx6XCckqI0InkMXPOJt5ZAwvlGG40a2W
 KWIQptyNie4Ldb3AOR8uNgpI5LINDlAFtLIvYBbj+BkloWxvqVIVJkxJ2DI/g4vuGiC0
 1alA==
X-Gm-Message-State: AOJu0YzYIMV34yQZMKdJne2A+dMRZww1v7axii/d9YP8nYkBwIFK2/MV
 subLEg3ZwvPPhCqQDsn7C4di4Li5bVSMGXy6iec5RuYGydyWjDttfBM9rduYVnK9GMPAgDm35qs
 zXjU=
X-Google-Smtp-Source: AGHT+IEeTZAEBquzeU1pTtzJizZu89abpflYnH/G7Ajnb6WBnMXf5TFX5mSDr6E6uoC6oqGXyuT2OQ==
X-Received: by 2002:a05:6214:5908:b0:6b5:32de:bfe7 with SMTP id
 6a1803df08f44-6bf894e1df4mr12916816d6.22.1723845017818; 
 Fri, 16 Aug 2024 14:50:17 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bf6ff04ffbsm22044196d6.128.2024.08.16.14.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 14:50:17 -0700 (PDT)
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
 Sean Anderson <seanga2@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v6 14/28] x509: move common functions to x509 helper
Date: Fri, 16 Aug 2024 14:44:03 -0700
Message-Id: <20240816214436.1877263-15-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240816214436.1877263-1-raymond.mao@linaro.org>
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
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
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v4
- Initial patch.
Changes in v5
- Removed authorship.
Changes in v6
- None.

 lib/crypto/Makefile          |  1 +
 lib/crypto/x509_helper.c     | 64 ++++++++++++++++++++++++++++++++++++
 lib/crypto/x509_public_key.c | 56 +------------------------------
 3 files changed, 66 insertions(+), 55 deletions(-)
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
index 00000000000..87e8ff67ae1
--- /dev/null
+++ b/lib/crypto/x509_helper.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * X509 helper functions
+ *
+ * Copyright (C) 2012 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
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

