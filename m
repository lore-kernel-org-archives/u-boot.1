Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE66CFA749
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 04:59:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48C0C89051;
	Fri,  4 Oct 2024 06:57:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HN6mVnpS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4F0888C6D; Thu,  3 Oct 2024 23:58:25 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79A2288CC5
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 23:58:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-45aeed46f5eso7192281cf.3
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 14:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727992702; x=1728597502; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u5eBTRw7307Fu1Y+274QcTRFVeiGoUy0zoTb4jHMxBE=;
 b=HN6mVnpSw/k/+zh2UFlIB1O/2UEQVV4wH9+kVsEjNpIrnaXUqlNN0bAvbw5s4ZA8V2
 oifPFWse2a4nHM2xyY02z4HEAxrcz0Mcs2diakVJqZAZUHXqavg+IHz0bRA6uA10nK+f
 D9OHbWbe6Ql/vS/gYgP3W+55GIoDUk70480+wI39ye+JtUbWf+pPK8AkJiBNQHo/VXC7
 I5+fdMfaBlVTfdomSdq312W1tj9+W88JkIAceivPWLEp2i6jo6GM7RgnxeTlknJ0hiAO
 d1TNiZ7+MsIcx6PY6NSCOWgLvYFxL8Aa4HGU4alxqFNYmaVzxmDgP2+5kEYIkLRH9OEn
 fP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727992702; x=1728597502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u5eBTRw7307Fu1Y+274QcTRFVeiGoUy0zoTb4jHMxBE=;
 b=oq2ksbPpOF+r0dK0C9WJoQ5z9Qbp0DprL6Up5ZywC8crRW1GBW+9Hc8nwxrCdn5mw4
 oWmB5up9aqqmqLArpg1vGSFpYEPt2Z+Bxgl5joKryT4QXdemC///z9TAKsmE/05g8fxa
 9k4o/sg7qwQqNUmT7+7Yperc6DAu+7fvJ/9CcqvmDmEDwSzb9ptrPkFwLdn2c3RdB8vU
 1nLfQGl22sggscP2j2z8KVImUc0Zjv5qgZ8g8fbfmSk+HKN3R1zldJAKZ9zVktSosMvi
 UaU8l+KVxjI2RqiSIzdXxeYu7SZahXfrgltL+WoQgMSpPLmWCiuv1TW3WMH60mSguRRg
 T9wg==
X-Gm-Message-State: AOJu0YwueLQJb3vkBOkJNiqWFE/WpSgbmpRIEz/ntPL/XKHI1mMQ4bwM
 aRlfhawMISZRB4/Wam0o2l0ckAlTjSCALxEJt50bJMadb1kjRnOkT49dwabsscIh+HVdBwFjkZx
 4
X-Google-Smtp-Source: AGHT+IF24ZsG9rN3ca/AbMRouwOoQJbTz5wMaks4aEWkaa0Nx7YIFK7cZ/XsN3F8Sf8cD5HQK9tBAA==
X-Received: by 2002:ac8:5a46:0:b0:45d:5786:80b4 with SMTP id
 d75a77b69052e-45d9ba6449bmr8964251cf.26.1727992702010; 
 Thu, 03 Oct 2024 14:58:22 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45d92ddf5c4sm9001541cf.18.2024.10.03.14.58.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 14:58:21 -0700 (PDT)
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
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, Marek Vasut <marex@denx.de>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Linus Walleij <linus.walleij@linaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v8 13/27] x509: move common functions to x509 helper
Date: Thu,  3 Oct 2024 14:50:26 -0700
Message-Id: <20241003215112.3103601-14-raymond.mao@linaro.org>
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
Changes in v8
- None

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

