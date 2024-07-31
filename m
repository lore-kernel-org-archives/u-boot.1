Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D67E4C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 17:30:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D7ED88A7D;
	Wed, 31 Jul 2024 19:30:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZZ4RMhqQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29A8688A7E; Wed, 31 Jul 2024 19:30:52 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E89BB86FB1
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 19:30:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7a20c529c77so64353385a.1
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 10:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722447048; x=1723051848; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OIuSI36a6ds/ndqwiIr/YH/O5LEEfZfxMl9APtGnvkc=;
 b=ZZ4RMhqQ62suIE4nn52FJD+YF3kDpvao36vEZFa2RmLuOUInKwgFcB8nuDTPwf56Lv
 4MRy8uQmx2ayK3QIYtzmvrZ547zuRJdy0SxNjrCOi1SNTS02ADT2y/D9oj1w74DlZk5+
 nBVtBbFPngU1sMfqYtncWjK83NbtyyXr9xg9LDNL+wO9u2fTC/njNp0pdjzvIUi3fonQ
 1ZUViuuqCQwzKZvktfHIUxr2Q6Tv8j+5fjbiv1bDK7Tdek6A5lEJfj1rgJuryTSmj4S0
 ohnRUb3in3w7wJN8CBz/zGAMQqtalEEGnQTX6nVV+TklTVolfwAEcpfPiMfcfZ0fYZqt
 6A7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722447048; x=1723051848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OIuSI36a6ds/ndqwiIr/YH/O5LEEfZfxMl9APtGnvkc=;
 b=xRXzetQF/cUxQfw5Pfh781G2ISl9euEBfifwpDpK1ogVSXzHUH2yE7dkJECaRGhxmH
 p9DjRssw4ur2Oc4BBPyAZCDTIghDzXgru0JrjPLWLvemRbhfxPSFk0xxy16pkghnJg/c
 YPQAMgP0NHUXKYXuIb6s2uasdNtbeWaDgQ8TqJv1p6UbB7GJkUsFUEidQexE5yOOVu3F
 DByVx1PWJoEd/tmibX+IEsc7dIRRZuNYe1KL0sJ5NeUsgq9H8jRj3xW9nRCTp1lckxC4
 SbHi3AKhSCEsb0ISjwAZBmC1Abb96qo2xqOHPMpzrsiuH6xPAl4OZABsN+Ppn3mMlKA0
 xTZQ==
X-Gm-Message-State: AOJu0YwBJH8UTK2hx3BLOZbR3SpEvbsmGZO3qhWLxinIswLvDAboHFPS
 zyRe/nPfGaDf8ciQj21CxZTvO6MerNssXptjGRhou4r0e3zym/Z2JNdt29OD6Tuc7hdwy9VTcmy
 HOhQ=
X-Google-Smtp-Source: AGHT+IE3miR72H8QjAOPSfttf5cfKxdE0Ix6g2sF8TjStJB7HPcvD1PUJxkK8z8BcLJqB34VM9NUxA==
X-Received: by 2002:a05:620a:370b:b0:79d:8042:cd01 with SMTP id
 af79cd13be357-7a1e522a45cmr2045835385a.7.1722447048599; 
 Wed, 31 Jul 2024 10:30:48 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a1d73b378fsm779452485a.37.2024.07.31.10.30.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 10:30:48 -0700 (PDT)
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
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sumit Garg <sumit.garg@linaro.org>, Andrew Davis <afd@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>, Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v5 12/27] public_key: move common functions to public key
 helper
Date: Wed, 31 Jul 2024 10:25:22 -0700
Message-Id: <20240731172556.1348487-13-raymond.mao@linaro.org>
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

