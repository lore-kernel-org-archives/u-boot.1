Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6454DC30658
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 18:29:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2AE888791;
	Tue,  2 Jul 2024 20:29:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="q+LH8WjF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03271887BA; Tue,  2 Jul 2024 20:29:34 +0200 (CEST)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D08CE87D33
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 20:29:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-4450292a50bso36328731cf.1
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 11:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719944970; x=1720549770; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tZFujoRGsZy5SjPAvtivR86KDexXcBka0C6NPv48vg0=;
 b=q+LH8WjFnNH3wEysx7f/obV14Gis96EeZWpDSnxV1Oa1FtcPe6z+pol/ErQKz0IB7b
 TrNNQtGdbRlMdkXSqUasJkgmR9iI9NgyKkixbrWE+wpXc2ql8gVOKM+ADl5zJcB4k9vm
 MYWODpkknBBbeMMwYnrzHfv0rhlJO+YJHX4NWkGuUcCv9aSDFTFz5KE/AL/5t8U0jXKq
 qksvjyQKd8wNcUehCi72WduCkJcSmA5zcpw8RteIs5S7tDKvp0gPAP19chVbE40+JmWr
 /hjVr7Yt4B5pFqExAXyMvQXqWFJx8xroBpaQCiL/xi+ZIzTYD/W0rTxVhBjtarElv1dI
 j5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719944970; x=1720549770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tZFujoRGsZy5SjPAvtivR86KDexXcBka0C6NPv48vg0=;
 b=Ze8funKNBFI7GjhqIKRyYLrLtddV2IYS9ruA+LvzaY9UwnHCULE71SivIyh1GZKNmw
 5ASliok4soPTaJmii+v+hz9kJAlQ059keKibadjxgqHVP7Q8mg7VCDv4waz0hYC/epI9
 UJa8uUqQzHMFqluQ7GLG7AN74CY9KJJbBAYVzBYzuh9BJRebK8GrP4hyKGOhVJFdBOIf
 I7rsXj+hcJkmuDZtAO6re136lRf5Xgg3x67zxX1whxB9g17WjGONzT/cVtCozDJc0OnI
 VNyjFDIhH3P2T4pyy3J/uv14GxcAMhJiyFHMroYgDoKYDV/jqaSMYGR0WFScSc1T/RB+
 DxbQ==
X-Gm-Message-State: AOJu0YxyWwmFm0bozWoxf1CFa03G0J3OvcKHqXcqp739EFLljQP6e2js
 nBtH3+UtBSxWminkAlgBi6ESSczTAZgceC/mRZk0NyKy/EG4tpf2ptEhQ/uZHGwmim79LA+6/Df
 Y
X-Google-Smtp-Source: AGHT+IGskLE9nWXS3KcaKbNJFtJVCZwaeS/8yx579DdNdUQTd0VlNX8LP7LsvzWblsjLi5ClR6V1Hw==
X-Received: by 2002:a05:622a:11cd:b0:446:437f:4cc with SMTP id
 d75a77b69052e-44662dd3af1mr120083101cf.11.1719944970130; 
 Tue, 02 Jul 2024 11:29:30 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-446514b613dsm43316351cf.84.2024.07.02.11.29.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 11:29:29 -0700 (PDT)
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
 Igor Opaniuk <igor.opaniuk@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Sergei Antonov <saproj@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v4 14/29] public_key: move common functions to public key
 helper
Date: Tue,  2 Jul 2024 11:22:50 -0700
Message-Id: <20240702182325.2904421-15-raymond.mao@linaro.org>
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

Move public_key_free and public_key_signature_free as helper
functions that can be shared by legacy crypto lib and MbedTLS
implementation.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v4
- Initial patch.

 lib/crypto/Makefile            |  4 +++-
 lib/crypto/public_key.c        | 31 -------------------------
 lib/crypto/public_key_helper.c | 42 ++++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 32 deletions(-)
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
index 00000000000..4cb21edddf3
--- /dev/null
+++ b/lib/crypto/public_key_helper.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * X509 helper functions
+ *
+ * Copyright (c) 2012 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * Copyright (c) 2024 Linaro Limited
+ * Author: Raymond Mao <raymond.mao@linaro.org>
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

