Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B12CFA749
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 04:59:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1A3E8901D;
	Fri,  4 Oct 2024 06:57:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GirikEDM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC8FC88D8F; Thu,  3 Oct 2024 23:57:53 +0200 (CEST)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AF7A88C6D
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 23:57:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-4582f9abb43so9834031cf.2
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 14:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727992670; x=1728597470; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PkPWAznF12MpobvBhfpS2LY6JX1lTBHDNTnBRZ9Q+9g=;
 b=GirikEDMc9SzYF9eluREi3OJuhxYBbq8X7vTivczmVWhAykWWrZqsYxX6WxuMQTUzb
 AsDId6+qRgx8XIQGYOrODMKSAWqzO2vvnMxrXKvAo7UhimjdfqoxCrCKyHTvu7AUkbRQ
 7kXmNJiKNnqHHqvrSDt0NX6yFVrk+x97zD4aJz2Dt+UF7sMSpY/GE92evh3jZLHgEqev
 fXmsP5WX3KYjNmt9ZunB8CalwZ2TPLK33KdWLDYKScta0egSVNeZHRX+lKkFTNWS3fK6
 99sQxB6WB8PXrXIe3X6HeuS9mABnLvd0kjuNgkXtF+g1Wjg7tKZPsGJTZp8sI5WIUpwd
 oj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727992670; x=1728597470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PkPWAznF12MpobvBhfpS2LY6JX1lTBHDNTnBRZ9Q+9g=;
 b=VH5ARKeu0sf+X2DuXOdmBNdLzeFbEGVmoUzL3xIABTAL2pASbWtgrvNVAcTtC1L/lF
 76j1K0FgkjrDPH77Yyc5bOBWXACcD3jlgzDHq6JKkc6Wv1v3BY3iL0JfabHyXgueRjOV
 WkCo9+x3iLm1Dj8D1MzfwK/XzN0K6LnGnOnktUE///MUNqmNA6w7ZZkNHLeu57HCFAaY
 B+8VYM4Hi+yUFYsCkqRTc83ykh+EVnpTUXhB7izAKBAb3ai0rIlFoF95leI9xd6O/wP1
 fxsc5ysNMuTqwP1N1lfY+MDZtOP1cNEnL4Eik6dhBVVR9Y+26F4sm47+eqtWlN0lJrJZ
 XPYQ==
X-Gm-Message-State: AOJu0YzcK2R/wT4LpH6gwShsdlmDAfDL1xL8C/rc84XgiZrsu6RA7DdO
 WESvdEILF5AF2caxdmXZQl2eLnwa3vIf6UxNh0dle18+4yoZMUgkYGFREhQtN1mPSESCzrDLEPa
 x
X-Google-Smtp-Source: AGHT+IEqOeGkgdjgFhbbWAusNRQcFEXPcrAcHSQmjV1equS5r+55lHJBYd7U/ad2K8HOYHSwiNCC8A==
X-Received: by 2002:a05:622a:1998:b0:453:5cb9:51a9 with SMTP id
 d75a77b69052e-45d9ba9ceecmr9432491cf.14.1727992669975; 
 Thu, 03 Oct 2024 14:57:49 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45d92ddf5c4sm9001541cf.18.2024.10.03.14.57.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 14:57:49 -0700 (PDT)
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
 Andrew Davis <afd@ti.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, Marek Vasut <marex@denx.de>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ian Roberts <ian.roberts@timesys.com>, Jonas Karlman <jonas@kwiboo.se>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Linus Walleij <linus.walleij@linaro.org>,
 Greg Malysa <greg.malysa@timesys.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v8 12/27] public_key: move common functions to public key
 helper
Date: Thu,  3 Oct 2024 14:50:25 -0700
Message-Id: <20241003215112.3103601-13-raymond.mao@linaro.org>
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

Move public_key_free and public_key_signature_free as helper
functions that can be shared by legacy crypto lib and MbedTLS
implementation.

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

 lib/crypto/Makefile            |  4 +++-
 lib/crypto/public_key.c        | 31 ---------------------------
 lib/crypto/public_key_helper.c | 39 ++++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 32 deletions(-)
 create mode 100644 lib/crypto/public_key_helper.c

diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index bec1bc95a65..4ad1849040d 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -7,7 +7,9 @@ obj-$(CONFIG_$(SPL_)ASYMMETRIC_KEY_TYPE) += asymmetric_keys.o
 
 asymmetric_keys-y := asymmetric_type.o
 
-obj-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += public_key.o
+obj-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += \
+	public_key_helper.o \
+	public_key.o
 
 #
 # RSA public key parser
diff --git a/lib/crypto/public_key.c b/lib/crypto/public_key.c
index 6efe951c057..408742907f1 100644
--- a/lib/crypto/public_key.c
+++ b/lib/crypto/public_key.c
@@ -51,38 +51,7 @@ static void public_key_describe(const struct key *asymmetric_key,
 }
 #endif
 
-/*
- * Destroy a public key algorithm key.
- */
-void public_key_free(struct public_key *key)
-{
-	if (key) {
-		kfree(key->key);
-		kfree(key->params);
-		kfree(key);
-	}
-}
-EXPORT_SYMBOL_GPL(public_key_free);
-
 #ifdef __UBOOT__
-/*
- * from <linux>/crypto/asymmetric_keys/signature.c
- *
- * Destroy a public key signature.
- */
-void public_key_signature_free(struct public_key_signature *sig)
-{
-	int i;
-
-	if (sig) {
-		for (i = 0; i < ARRAY_SIZE(sig->auth_ids); i++)
-			free(sig->auth_ids[i]);
-		free(sig->s);
-		free(sig->digest);
-		free(sig);
-	}
-}
-EXPORT_SYMBOL_GPL(public_key_signature_free);
 
 /**
  * public_key_verify_signature - Verify a signature using a public key.
diff --git a/lib/crypto/public_key_helper.c b/lib/crypto/public_key_helper.c
new file mode 100644
index 00000000000..2c55922bdcb
--- /dev/null
+++ b/lib/crypto/public_key_helper.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * X509 helper functions
+ *
+ * Copyright (c) 2012 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+#include <linux/compat.h>
+#include <crypto/public_key.h>
+
+/*
+ * Destroy a public key algorithm key.
+ */
+void public_key_free(struct public_key *key)
+{
+	if (key) {
+		kfree(key->key);
+		kfree(key->params);
+		kfree(key);
+	}
+}
+
+/*
+ * from <linux>/crypto/asymmetric_keys/signature.c
+ *
+ * Destroy a public key signature.
+ */
+void public_key_signature_free(struct public_key_signature *sig)
+{
+	int i;
+
+	if (sig) {
+		for (i = 0; i < ARRAY_SIZE(sig->auth_ids); i++)
+			kfree(sig->auth_ids[i]);
+		kfree(sig->s);
+		kfree(sig->digest);
+		kfree(sig);
+	}
+}
-- 
2.25.1

