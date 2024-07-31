Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4622CC3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 17:31:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0E6688A08;
	Wed, 31 Jul 2024 19:31:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pYySR24T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91ED188A94; Wed, 31 Jul 2024 19:31:13 +0200 (CEST)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F3E786FB1
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 19:31:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7a1e31bc1efso360987285a.3
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 10:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722447070; x=1723051870; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zgdde31wO2wy4T9xmk1DpA1dyAfwYIrJVEwNbQL1dUw=;
 b=pYySR24TpGMC59d377AH9EZ/et+MC5XrHjgYqaQ9IpfzWtaDl32YbUW0TXgh635/la
 olDA1+w2hLbQ3RJb7+QYXlFondOVud7TlEIY1VhSAGwlMtNa2jUPQEGMS6GtdnGePkf4
 h3J0hzgOHIfO536QK5lX/KClIhymoh7ako9pYYX8J1cnHDvr6t1/CpOgob9nwh6WIHrS
 8l7jNvevyXfaz2GYARkL1yM88vj9DUSYOSGe0dRwuroXEJtkE4ETy/Mfb2KdEt0e/RWG
 pzCqxSPa1lujzsL7O5BO4+h25DdEbTDTVz4gt1olmFvo3ndv4CE8zH0Hsyab2dkKHWHo
 6DNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722447070; x=1723051870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zgdde31wO2wy4T9xmk1DpA1dyAfwYIrJVEwNbQL1dUw=;
 b=Yf4aPT3CPgtyHqmB5u8gMqBXTQxel57iuBfbVv23yVVbLysJ/C+7mSo0BrBNX83Bs6
 BPf1xDk9hj6RZ3wjvFN4DWDrK6zs50l+IdagwjKuRCmBLjp8hWtl0Kl/ZUWg3VqyX54R
 dBcX9eP4gZ9MBDzOX5DhgB3gFLFG5l0HdOl4BL3nqP6UCO20HYnxk7SKcuaV9xxLVQhM
 6FdT4nYsun9GxDNj0y5ImRZMveNHzJM6CNkTgdKf5MW0Hz4B54L30hki9go+0Zg8uW60
 uDy97aFFOGij5x1TYa3DvqQnDAI1K1VoCyBOPadUWR93qNURHL5TbEXXj+WKHBGRHux8
 xbqQ==
X-Gm-Message-State: AOJu0Ywhkc4nfh9WcG32mKLc/IojgCnfkFzDG7MdW378/XIZ6OW49+8h
 5tm8BEeRkq31sWQ5DVoOLHXB/M8uPHfznhqaR/rF/l1RDQ9cxcPESx1nxC4NpJ1CN/FAxhwSwBD
 9PEs=
X-Google-Smtp-Source: AGHT+IFN878ZIlPrc3nXwG3pgsRV6EAzqTI6Bi80Z949pGGbxi3TSpCKAJJQJYmaKWvP0I3qNgKYeg==
X-Received: by 2002:a05:620a:240f:b0:79f:758:9654 with SMTP id
 af79cd13be357-7a1e526018cmr1689728285a.40.1722447069816; 
 Wed, 31 Jul 2024 10:31:09 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a1d73b378fsm779452485a.37.2024.07.31.10.31.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 10:31:09 -0700 (PDT)
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
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v5 13/27] x509: move common functions to x509 helper
Date: Wed, 31 Jul 2024 10:25:23 -0700
Message-Id: <20240731172556.1348487-14-raymond.mao@linaro.org>
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

Move x509_check_for_self_signed as a common helper function
that can be shared by legacy crypto lib and MbedTLS implementation.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v4
- Initial patch.
Changes in v5
- Removed authorship.

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

