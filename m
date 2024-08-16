Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57841C52D7D
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 23:00:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D51F388C97;
	Sat, 17 Aug 2024 00:59:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ny+3VA4v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CE7D88C53; Fri, 16 Aug 2024 23:51:35 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 231F288AA9
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 23:51:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6bf6755323cso14182466d6.1
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 14:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723845086; x=1724449886; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VFtHi4TaCsLwUH9hCc7TOzmAWuVIzwHdPD+IDaWTiKs=;
 b=Ny+3VA4vWFCkth6OmToXPlKLf3ZmSOEpm8ysLZHTUREoXQT3McWAavwtodmdY4E6vs
 Sz5Blbfm9ddwKCjbodSoVdwpr/4RwovyAp6ZmFLntpyM4U1zS2Q8vHgUIZMsw/h4vzWg
 J3dwY8eYg1pCADxmP37t5Q/dESCvB3FZlDTi5zPOfcOTTOSUJOtBEFPqCk4vHJIj39Lt
 U1LAzAg/aTuwr9L7Ec2ID6EMdUoaPTsHy/If+jtwkaLw5Y2IrDkMiaqOn0iFp0FAvL7q
 bpQwnTd+e1UbOtgC2naSzgjXqYmJV/clxQmTuZcpyc1nAnjemVrN4/TEkw5s63qYh9Mt
 wpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723845086; x=1724449886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VFtHi4TaCsLwUH9hCc7TOzmAWuVIzwHdPD+IDaWTiKs=;
 b=gSTAqzDDiqWR+k5sC8suMQM3R6ycS7X++u2ys9HMVy1aR5l8m9CjXLgJNMnsVUp9ye
 GQ/rJ8s72HPLJv65jYQPunH7i3gTceuwcK1qRRA2ouD6mvSs/6StJShxn5oXlVowcGhb
 0ib79A920oS0cI85IunplXrUbERFfvztrblj/ZuWYYQJOyyKnnVCI3OxdfVrm0T3SIWl
 rqzLyX+uQ1feX5nGj3LhgZ3xkJTH+kWU5zJ8Chqa1raFoVFBRUvypISeYaaEWFUIArNI
 hFSOw5hNdLju3VoPONgysxLIyPHSSU73jTHB2eftPUwPy8sUdLa9Tcc/kO2ryoLcyAlo
 ovEw==
X-Gm-Message-State: AOJu0Yy9lfisZPfgyId37t8tR+wE8wRmpep15Ai2l3R1qEfHzFfJUT/M
 55cHttioiLmlnQZBSFdVf+mZfa68RVwDEHoYf1c0m/KKNZQRgIR7vUn9S2OMJ/e84Ec92CMqxag
 F3fI=
X-Google-Smtp-Source: AGHT+IEgEbWnDTxNcZA6X2SO9vOQNj7JRXGSqjgc4OjEASJYFGfHIrhQNwE/xtUn06ZOpnJy76CHIw==
X-Received: by 2002:a05:6214:460d:b0:6b5:468e:d417 with SMTP id
 6a1803df08f44-6bf7cdc65bbmr56666366d6.23.1723845085716; 
 Fri, 16 Aug 2024 14:51:25 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bf6ff04ffbsm22044196d6.128.2024.08.16.14.51.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 14:51:25 -0700 (PDT)
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
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Anand Moon <linux.amoon@gmail.com>, Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v6 17/28] lib/crypto: Adapt public_key header with MbedTLS
Date: Fri, 16 Aug 2024 14:44:06 -0700
Message-Id: <20240816214436.1877263-18-raymond.mao@linaro.org>
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

Previous patch has introduced MbedTLS porting layer for public key,
here to adjust the header and makefiles accordingly.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v2
- Move the porting layer to MbedTLS dir.
Changes in v3
- Update commit message.
Changes in v4
- Control building legacy library via '_LEGACY' Kconfig.
Changes in v5
- Correct header file include directories.
- Kconfig rename.
Changes in v6
- None.

 include/crypto/public_key.h  | 6 ++++++
 lib/crypto/Makefile          | 5 ++---
 lib/crypto/asymmetric_type.c | 2 +-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
index 3ba90fcc348..25cfb68adce 100644
--- a/include/crypto/public_key.h
+++ b/include/crypto/public_key.h
@@ -12,6 +12,12 @@
 
 #ifdef __UBOOT__
 #include <linux/types.h>
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
+#include <library/common.h>
+#include <mbedtls/pk.h>
+#include <mbedtls/x509_crt.h>
+#include <mbedtls/md.h>
+#endif
 #else
 #include <linux/keyctl.h>
 #endif
diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index 16059088f26..7e877214aa8 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -7,9 +7,8 @@ obj-$(CONFIG_$(SPL_)ASYMMETRIC_KEY_TYPE) += asymmetric_keys.o
 
 asymmetric_keys-y := asymmetric_type.o
 
-obj-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += \
-	public_key_helper.o \
-	public_key.o
+obj-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += public_key_helper.o
+obj-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_LEGACY) += public_key.o
 
 #
 # RSA public key parser
diff --git a/lib/crypto/asymmetric_type.c b/lib/crypto/asymmetric_type.c
index 24c2d15ef97..95b82cd8e84 100644
--- a/lib/crypto/asymmetric_type.c
+++ b/lib/crypto/asymmetric_type.c
@@ -12,7 +12,6 @@
 #include <keys/asymmetric-subtype.h>
 #include <keys/asymmetric-parser.h>
 #endif
-#include <crypto/public_key.h>
 #ifdef __UBOOT__
 #include <linux/bug.h>
 #include <linux/compat.h>
@@ -26,6 +25,7 @@
 #include <linux/slab.h>
 #include <linux/ctype.h>
 #endif
+#include <crypto/public_key.h>
 #ifdef __UBOOT__
 #include <keys/asymmetric-type.h>
 #else
-- 
2.25.1

