Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4590AFC6186
	for <u-boot@archiver.kernel.org>; Sat, 14 Sep 2024 01:06:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0009A88DCA;
	Sat, 14 Sep 2024 03:04:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sTlgl+CO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3936B88706; Fri, 13 Sep 2024 18:10:01 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B18A887BB
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 18:09:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6c359c1a2fdso8824736d6.2
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 09:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726243798; x=1726848598; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w2b/0DEeQ0FTYW0Sc2dgoPSUJIUfeAT3KYEqisEBpUM=;
 b=sTlgl+COWQozibZuYKPErFcyCkjXCge2O4Md08ucTW1KIXz1RPczj2RP+1XmSVJ+03
 JBvAf9tfORBWDyI666OxV4sb9yv4Ab66hJmdHpYlNuwsU/cGJzf4E7umLwa5y8SYt7nV
 nrX49XrU5dKSKediobxVMepDF8dHT8QOvOOdjziO8s9ANakJqlqwDfW6knnLQeW6l+kz
 Q5ibda4IIJSndsR8eI3fOeEvADwqtwrC16Waa+QGSHhonOtBsfR1PeMyvCbc9E6jdbRc
 y0mLRB2Daedz1bayfpidFVjuS8orVhrxfFUGiMX3NIahos5x8IXOYbP9XaAE4ixOxfd1
 G54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726243798; x=1726848598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w2b/0DEeQ0FTYW0Sc2dgoPSUJIUfeAT3KYEqisEBpUM=;
 b=mYqtvbv+at8/t/cpljL/XWhItqjewDXPqlCeeBRNzZzzD6vR53ByrafCPf3xns35kl
 nCqGGahiO//0bd0h9c6QQRd4XidlR/hCptHxUWDQKmYq4xiEk6WuA/099wIhwwhvTLfj
 iDouF8eHl97Tsf1lU1f4ifn41ly8oky+WGzLoqwPnjYTZ51/KibyQHQm5gPlkEnEjCUp
 Io+FyQqcWAGcyzSD8DwQZnbfaeOwtMETxSrH51dQ06QZEvHI+Sgbkze3M4Cov2D+G1XR
 UZ9MjnFhTJgDxaH8CtsjIoMY6oiUf/fn2H/EGgxISTKY5WoF+X7GN9Irhq8apSycjUXH
 2Lww==
X-Gm-Message-State: AOJu0Yy1gAVp7BOmhXQFoPHujQUWU3T7WpCMuP0134h08bRvHswK0ASw
 amOmVIs3tdZqV0b8phi2G5d7Idj4SzkmGvGfEHfVTS80G1wP4tsb19zmeVif+jQDgavDnAz4wee
 v
X-Google-Smtp-Source: AGHT+IEp9XKoog8898rLS0UlZlsGKk4Jx1JRMxciOBpUE4N1JRWq7Du89imgm34lhLHScPgKixlbgw==
X-Received: by 2002:a05:6214:398a:b0:6c5:5081:1491 with SMTP id
 6a1803df08f44-6c57df20828mr57153036d6.12.1726243797767; 
 Fri, 13 Sep 2024 09:09:57 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c534774908sm67697286d6.118.2024.09.13.09.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 09:09:57 -0700 (PDT)
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
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sean Anderson <seanga2@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Sumit Garg <sumit.garg@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>, Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Greg Malysa <greg.malysa@timesys.com>, Jonas Karlman <jonas@kwiboo.se>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v7 12/27] public_key: move common functions to public key
 helper
Date: Fri, 13 Sep 2024 09:03:29 -0700
Message-Id: <20240913160408.2199558-13-raymond.mao@linaro.org>
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

