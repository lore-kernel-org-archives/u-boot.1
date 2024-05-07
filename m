Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54121C25B4F
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 17:59:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0822887DB;
	Tue,  7 May 2024 19:59:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ySIia540";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E1CC887EC; Tue,  7 May 2024 19:59:11 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DEE1883E8
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 19:59:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3c96c16bb19so1489252b6e.1
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 10:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715104748; x=1715709548; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PYPuJxTzjB+jOluF1ApLWe6/HbCUNfQgkJ0ZJ0P/xOk=;
 b=ySIia540Jc52m9Zwt0HqUoTI/dPNGLykL/i48q7+LqNhOleHmAXkoKDvrjDwitDoRj
 zckO4EfHPsDaMd+csiOI5158Bfkw70OUH/+hewMU6aG6gTQFXud7IYPzjxkotI/6QjGV
 8vMYPVmP3aXYT7aGhe6FJAVVoTCOZUmPJw+EAEzAmDLt4I+4ydR6vWZC/pXuK6vzl+Ur
 deOZ4aZ338ewNUdfSUIsZs0Qxisggnz8P+XhdFTulpYc8BwPl4xGPkBGaewmc4O4BKLL
 mzQxY709+5vj52uveQGQyCPW1AgtEsYsEom4WfUNe63Jdg2TBgNHFblKl/iA0jzArBrb
 uVaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715104748; x=1715709548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PYPuJxTzjB+jOluF1ApLWe6/HbCUNfQgkJ0ZJ0P/xOk=;
 b=LUuCcW7I1nuD0PhdKBfkOHH1mZE3HOA8MIrmECqBBDZnH65eh3v564o7OM7UO3IVH4
 FZ7wHkLLgvYcXLxK/M6AhgCPKyg2ne3tmF1Qx/p892xiaqNp767vJgVZ+SeYcgNNnrfz
 vvElSHbvXZIsLOXKmNdpyHITo7zdUUeS8pQhxVfCY0xRbxedhMWomB7T5Tf4LR4mWlbE
 pU/lcVN6Rmd1JLz4iGAzH/yCBMg3q0K/+7foe3Dqz3r/vUoHF8r72VLrXInoAjv+OEOg
 bb9kVAE5VBrh275O29Wq2/s5c0CUxdC8wsPUGrDjyEJ/VP5avNAE82P/YqV4uJPi+oEW
 xkTw==
X-Gm-Message-State: AOJu0Yzr9vT9pC62CSCoRCwOc7RMJPqVUK3Pl0V5a8WkhBAFRijBNfFs
 2RfhHSQn6vYVF0ox3gLuffmY7r7MJNyxSyAqU20k4M+ZPCoM4zePSnCCklS1FtvlQEcnJIfE5Se
 Q
X-Google-Smtp-Source: AGHT+IHCLL7QD1sdC+9Hp3qH9ukvmN37HtSKMaTLhmOzhi6evTZDYfU2A/4ushJVBiyNvyCJiNokPg==
X-Received: by 2002:a05:6808:1807:b0:3c9:6db0:bb6e with SMTP id
 5614622812f47-3c9852beb41mr332998b6e.24.1715104747914; 
 Tue, 07 May 2024 10:59:07 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-115-4-214.cpe.net.cable.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 o1-20020a0cecc1000000b006a0f126a033sm4801834qvq.28.2024.05.07.10.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 10:59:07 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Andrew Davis <afd@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Sergei Antonov <saproj@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilya Lukin <4.shket@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 Eddie James <eajames@linux.ibm.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH v2 17/28] lib/crypto: Adapt public_key header with MbedTLS
Date: Tue,  7 May 2024 10:50:59 -0700
Message-Id: <20240507175132.1456512-18-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240507175132.1456512-1-raymond.mao@linaro.org>
References: <20240507175132.1456512-1-raymond.mao@linaro.org>
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

Adapt the public_key header file with MbedTLS

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Move the porting layer to MbedTLS dir.

 include/crypto/public_key.h  | 6 ++++++
 lib/crypto/Makefile          | 2 ++
 lib/crypto/asymmetric_type.c | 2 +-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
index 3ba90fcc348..55cd4c2b012 100644
--- a/include/crypto/public_key.h
+++ b/include/crypto/public_key.h
@@ -12,6 +12,12 @@
 
 #ifdef __UBOOT__
 #include <linux/types.h>
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
+#include <external/mbedtls/library/common.h>
+#include <external/mbedtls/include/mbedtls/pk.h>
+#include <external/mbedtls/include/mbedtls/x509_crt.h>
+#include <external/mbedtls/include/mbedtls/md.h>
+#endif
 #else
 #include <linux/keyctl.h>
 #endif
diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index bec1bc95a65..8f7d9811f03 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -7,7 +7,9 @@ obj-$(CONFIG_$(SPL_)ASYMMETRIC_KEY_TYPE) += asymmetric_keys.o
 
 asymmetric_keys-y := asymmetric_type.o
 
+ifneq ($(CONFIG_MBEDTLS_LIB_X509), y)
 obj-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += public_key.o
+endif
 
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

