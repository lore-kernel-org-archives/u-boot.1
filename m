Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31661C30658
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 18:31:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4EC2887C0;
	Tue,  2 Jul 2024 20:31:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eV5G1/X6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6255E887C0; Tue,  2 Jul 2024 20:31:15 +0200 (CEST)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36137887C9
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 20:31:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-446427c5923so40650071cf.0
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 11:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719945072; x=1720549872; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5wK3VmHwNDZiuoj0qezexNs9T+JrDsbaue15zxbzT2c=;
 b=eV5G1/X6k2jQPXZRYibU4qMRAp795Xi1WAwcFDnPfu2cQnuy1HwSghVZ3a0HQCWCV9
 zJ3abqNafJ3HURuWz3k62qnA5+R3mBRAyL2Xo/5RqkV5sv1EduJmbkKuYttGzGBelvtT
 8YynicGuI1AO8jE6FKFPBMdg6DDaO4jOehtW8BsWOjGYMt5v0QAtMyNLMrh0wBkw8+1p
 /lXNia3gIfD1ceNPE73pNtym9WC7Dgwl59VfnN6PhN9ZDBGUAyQ+gu02UMokaLgwDnJL
 RI/rnrXipGvh9Tj8KLSyjuQwmYZ7XBF2ucnKAHISY0wlt3KhuN214TjRFtIAWKtmUu9p
 JXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719945072; x=1720549872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5wK3VmHwNDZiuoj0qezexNs9T+JrDsbaue15zxbzT2c=;
 b=OqIGd/SMYNAAmaOlUa2Q7wVy9OIOln4Zs5vSVrXKjFjV6ZSAi0fR9Q6qX77y8kiJxI
 35NjsBDXPZP6AndGZ5b/yykuM2KIDscJwq5QcCfibq6C/LTq0Z0fAk5IL3j6HKiF+UmS
 BqTAFRFoddBzL7Phw6LDnCNVLEiSNxRANW/XPh99BX9erILEFKmqADYH16oBzNdD0mAK
 /Qbms7h4sUQDOSQ+h/LzfRx19yVpgmEpMtdMTvMxuekQka6Ke2GhowIOjL5WB2wQcD8O
 Z6+TKdgtIfsH4KCKKAu+PwYfOaNcdgNTz9mTqwOyNm/AfIC7tKFmL3Ukboh2v8bvwBpk
 Ourw==
X-Gm-Message-State: AOJu0YyCkCEmtLyBZLZDjjwLHrPsGatsurBkBdrNyIdzuRSZbBYqkdsC
 PBgZ+f1Q205gxJ5AdBzJnbHrfPAIkakNSyyNIEKBK7q06m4sKmgFlfPTleWBSaoPwAaHmZlQ78w
 S
X-Google-Smtp-Source: AGHT+IENU5ONc/9kPID2b9AJvz+QI/y5cv2E+tbh59w4OBifiXfGzQzchwkX/EmaAz6poa9HCHXCuQ==
X-Received: by 2002:a05:622a:ca:b0:444:ce36:f12b with SMTP id
 d75a77b69052e-446556c21a8mr240453201cf.22.1719945071653; 
 Tue, 02 Jul 2024 11:31:11 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-446514b613dsm43316351cf.84.2024.07.02.11.31.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 11:31:11 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Ilya Lukin <4.shket@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Sergei Antonov <saproj@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v4 18/29] lib/crypto: Adapt public_key header with MbedTLS
Date: Tue,  2 Jul 2024 11:22:54 -0700
Message-Id: <20240702182325.2904421-19-raymond.mao@linaro.org>
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

Previous patch has introduced MbedTLS porting layer for public key,
here to adjust the header and makefiles accordingly.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Move the porting layer to MbedTLS dir.
Changes in v3
- Update commit message.
Changes in v4
- Control building legacy library via '_LEGACY' Kconfig.
- Minor fix of the include directories.

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
index 16059088f26..228ae443a27 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -7,9 +7,8 @@ obj-$(CONFIG_$(SPL_)ASYMMETRIC_KEY_TYPE) += asymmetric_keys.o
 
 asymmetric_keys-y := asymmetric_type.o
 
-obj-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += \
-	public_key_helper.o \
-	public_key.o
+obj-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += public_key_helper.o
+obj-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_SUBTYPE_LEGACY) += public_key.o
 
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

