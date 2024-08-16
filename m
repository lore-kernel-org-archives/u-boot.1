Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636E3C52D7D
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 22:59:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9ED7088C82;
	Sat, 17 Aug 2024 00:59:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Op0IvzPn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54B5D88C4E; Fri, 16 Aug 2024 23:50:07 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2067688AA9
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 23:50:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5d5aecbe0a9so1409025eaf.1
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 14:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723844995; x=1724449795; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5W75xNOJ0rsiOhEe4XkwtkPP1doQXaQtAwh83LM6HZ4=;
 b=Op0IvzPny5Iep1nxu5Uk0ZsP5w7y0GOGXu7NOjCS8r7PxRrM1P11iO3KUyNzF561eE
 9SMVprroTf8xRrXnlCT6XS1Eb4Q6f37Mm70d1QCvVqfi4hqHDqLyCudyBKtKJpIzM1la
 OdUOAQnv3A6GwiUSsmDm+zdNecYxq+2k5rjph9Saq371PDifIvpVyPLi/klAmpvimG2X
 kVnRMngzbUvc8NLSuvl5gUGZwggotmbzwVdTVbrjpQScjRIb895wBnVpJmIWyOnJhlMQ
 zr2uZEGPeI11xNbevyxKbIitHwftLulNIXQ0Vhn43nfkvJBAdDU4o6L7KQ4anKW279fR
 GBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723844995; x=1724449795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5W75xNOJ0rsiOhEe4XkwtkPP1doQXaQtAwh83LM6HZ4=;
 b=HltOOkGonwSS5EurTTIIqWIjwXV3CqflHl+WGZmuWuBhFtSRTcq6dJKg2PYpeUPX9a
 6HXRWn2qXc0dmwOPz8kH1g/UP+AkXqnGSoqYSEP/fVbI5jKnR0k39ja24/0QC07hdPo3
 us03Pn5muXsZl1DMccBEMPmEoZtjePCWBEXczpQkRxgUscBfFwXjLWFQ4A8x1TC+nqee
 BvHZ5lkWTGyYV6XdpwSNPqqH0KHJD96OgY+awbkTQ5faLJFjjd9lk54ODWHbHMyONit5
 qepUj9EvmMhD6cXvHJ4xJ0HWVswMx5nzLIPNcAwwTmTEk9Why16QUcFMtB57At/wQN8E
 jYGA==
X-Gm-Message-State: AOJu0YwC5pAcksBfYEGXdjVjQSUMeIpQfz96dx9ZDGw/GCTTrPlKEpKX
 0cnMYxX9P2HDqQLRnR0itBJ7EhsBIL9pJJJz2+JsGJsb7pOenUWxFRtmVpfrrnbhFq8W4Os2W7t
 wUgg=
X-Google-Smtp-Source: AGHT+IFwxksynlFEPv8vgPq8K+BxMrRwEOFCQtquhSwVw2poJx113wwQStfWTlqk3JcJJP+PLONw3Q==
X-Received: by 2002:a05:6358:419f:b0:1ac:f2bb:8aa6 with SMTP id
 e5c5f4694b2df-1b39328524amr550680055d.21.1723844995212; 
 Fri, 16 Aug 2024 14:49:55 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bf6ff04ffbsm22044196d6.128.2024.08.16.14.49.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 14:49:54 -0700 (PDT)
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
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sumit Garg <sumit.garg@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Anand Moon <linux.amoon@gmail.com>, Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v6 13/28] public_key: move common functions to public key
 helper
Date: Fri, 16 Aug 2024 14:44:02 -0700
Message-Id: <20240816214436.1877263-14-raymond.mao@linaro.org>
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

