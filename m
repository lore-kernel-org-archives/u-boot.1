Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAAE9FC6185
	for <u-boot@archiver.kernel.org>; Sat, 14 Sep 2024 01:06:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B1E488E05;
	Sat, 14 Sep 2024 03:04:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RwTnqq4e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AF1A88706; Fri, 13 Sep 2024 18:10:28 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50B72887BB
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 18:10:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6c3603292abso9375426d6.1
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 09:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726243825; x=1726848625; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TbZTS7Ye/+yg7uXbtxFMPzpFQxDfI0nkSvqSdtcoYHk=;
 b=RwTnqq4eHZbbmepzSpJQ21SUmVuCnuT/1jvb3tANhyCorPURx0liJ23IaLoF8Zfhmg
 60U5zIpX7DTZjVst8vYeEacbr/HTraFPIbsHxOR4biVKV5u+0VZxZRT0RrFpRtF5liX5
 ytLGl79Q/VYcnMf+8dYO4//eWEF9WXcOnGPfvoxVDS9Vxd9mHxJ1r8wO7fMm+K9ZjMAi
 sUORy/Tvnak2n2gQk9cODFMeGYG1nqDKbxqPgqfZTcvYSlwPWFCZMMWAO/oY0e5RbKLj
 y0Wvhx9FBTs5n9xVE4bh4Rzf1eFl7xcC8zZMgtkKSZPgJBMS0PY6YxT1QOTHsA9wBlqy
 6s0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726243825; x=1726848625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TbZTS7Ye/+yg7uXbtxFMPzpFQxDfI0nkSvqSdtcoYHk=;
 b=uAlx4XERVQhf34+QpIK2YLyjXcuSU6GHOIDIdp5cUb3c4gVQbgJpCq+NIVhwQL0wkA
 ouqiwdC7F1o6td/zwhL7pUjWi/ngjleBWL1uzLks1Agh6lZ4guriVT9/2dPfBALk/4oo
 7V4k/filSOfS/elOAqwaqvrliygl+hp3QDujp/n/F8yOZOnChH0DRT1K7/6j09JRKIjw
 NxroSN2z+vtcrpAXCwltYSKslJMBpgVkE5eUTqKWf1fxwbOtszDRmgovRLosl4Gs65AI
 zPj/aSavF1t1W9eZiPSDjtkKEAiTnErmFo/hHkqf/PfGmDiuvCtJBVs8kLsXaiCNZ3Fx
 7Q5g==
X-Gm-Message-State: AOJu0YzmlnoMhVEMiUfVTGCMNR+X/66gQwDOyPib0ENAodmdn8C4uJns
 5saFFOQGIhReisBSo/R/B9euZf/df5gUaMMggPHVF3gQZrvclCT2ZCn7B6HhqSNxZOP3KPwUzOj
 W
X-Google-Smtp-Source: AGHT+IEUM0xUFS0iud4j9YXiy6r+bMMTY+xrIOh5NcMfWdxay0gHJROI9xPNyWPHdiu8GxZTc792LA==
X-Received: by 2002:a05:6214:3d87:b0:6c5:5324:6f44 with SMTP id
 6a1803df08f44-6c57e0bc356mr43730746d6.35.1726243824794; 
 Fri, 13 Sep 2024 09:10:24 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c534774908sm67697286d6.118.2024.09.13.09.10.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 09:10:24 -0700 (PDT)
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
 Sean Anderson <seanga2@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Sumit Garg <sumit.garg@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>, Marek Vasut <marex@denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Linus Walleij <linus.walleij@linaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Greg Malysa <greg.malysa@timesys.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v7 13/27] x509: move common functions to x509 helper
Date: Fri, 13 Sep 2024 09:03:30 -0700
Message-Id: <20240913160408.2199558-14-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240913160408.2199558-1-raymond.mao@linaro.org>
References: <20240913160408.2199558-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 14 Sep 2024 03:04:24 +0200
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
Changes in v7
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

