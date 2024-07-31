Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF00C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 17:32:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1952E88A8F;
	Wed, 31 Jul 2024 19:32:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gkZAaZ8V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C0E388A9B; Wed, 31 Jul 2024 19:32:16 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 631578841E
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 19:32:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7093efbade6so3942338a34.2
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 10:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722447133; x=1723051933; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6dXne6peT8QuJzQaRusxyBfFnERp1mMR9aGBAJXcN6U=;
 b=gkZAaZ8VOmGHpAE6LQf0j0voS1rv2eF9P6lXUjApBq/hncGgqeZbWQQ5mzoS+krN5i
 Ceb80b6ENLfGojjGIWTJOW11rDJAIVS3SemTSWRGdTaSNwGbRfXWSmp5IFrKZGCHqfGv
 0C7ZrmiTbgh2uJYjxXc8+1Kq4q2cJFvIJfJlEjDHzZk/a45NtglNZ6MP83D4qcJQLR70
 QWG+qJgHKnaoIjgF1ueZXbzZlBDPRdbVzHq3gktNqQq/Z9h3q7TnCG8C1esnXzqPjY5C
 X0aaG10E26geNxOa9RKpuXO6ukmsElNEiHJ/PFdHg+p9dh0Ox8BODUP0ULONe6QQsZeg
 8l7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722447133; x=1723051933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6dXne6peT8QuJzQaRusxyBfFnERp1mMR9aGBAJXcN6U=;
 b=O1PG0R1sCpiXMR9KXKz/vhiwk00gWmChWLUgzitvmg4xrK3cEHyMProVOYzR+Urt+H
 Q18tSeLIbk3F0IfM9GNpwEPetIK60A/S8gYFK28O1mci3yfY+Udcrh7aT/EkjIltodQx
 Bcfc1hYo67L+W4rCHOFvfjr68dA9VtbJYwu2t2M08LW3ZU0qugxGxZ2XpyabjPbkR6LH
 020pQqrEisytv8r76klI82lOyB3is91XJP13RK9TUDm05RkYnArEmYRwDkjjT2CYL8dJ
 TH7g06ozAFp8OV4JxKFRIE4atqJyCiG7AQEwVGP8Zs1GaXXab1eePXu9X6FzzzQXy0ue
 /4dA==
X-Gm-Message-State: AOJu0YwR1LTumsW8WOaA/hE924MZQdCt0OEpyWum+mVu2zJjCuBsv80h
 mMqzcoQbksqLXT8eKH+KMzPfpcp6fDykK5igF0QqDnAhdYCz1y8Iadmsh1ZaWFgTg/I3LtWoVuD
 3WqU=
X-Google-Smtp-Source: AGHT+IGk/09twcq0YJn+j4SKBJFcC9ol+gDGu50TWVA6V9bq6kSQoA3QlQHbvBiUlikGWvZZzmHbEw==
X-Received: by 2002:a05:6830:d12:b0:709:2752:4523 with SMTP id
 46e09a7af769-70940c0ad6emr21338374a34.8.1722447132941; 
 Wed, 31 Jul 2024 10:32:12 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a1d73b378fsm779452485a.37.2024.07.31.10.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 10:32:12 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>,
 Sumit Garg <sumit.garg@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng.cn@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v5 16/27] lib/crypto: Adapt public_key header with MbedTLS
Date: Wed, 31 Jul 2024 10:25:26 -0700
Message-Id: <20240731172556.1348487-17-raymond.mao@linaro.org>
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
Changes in v5
- Correct header file include directories.
- Kconfig rename.

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

