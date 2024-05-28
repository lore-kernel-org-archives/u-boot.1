Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B9B4C25B7C
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 14:15:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F330988543;
	Tue, 28 May 2024 16:15:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dwg7QKHq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F314588544; Tue, 28 May 2024 16:15:21 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCDAE8852C
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 16:15:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-794977cbd66so26969085a.1
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 07:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716905718; x=1717510518; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pEb7meLbBTTaoqTDj2crmCDTE9wzssvULPCXBipboWk=;
 b=dwg7QKHqc3wsSxXI2+oEzIlgJGWtCs1ptHMUdD37YKHj4JDjOUwi429LtixuRlsu6/
 k3iTm1uJESEcgqMeVBpoF4ia5C6zwip3AI2bwwlzwzTz+Mp0Gwg8IOOTdB0TlRhxbxBC
 E7ujWYay5PBGq/A7oTiJrpvR7pBqSlgp083o3RLNeG+l+DV9jPcCcLzubZrrpdLOs5Qo
 6cJlcAh48lb64Uyfpw+6ytPsN74nq75JdfVXe8l7/kW6HhRJ9tqYibjZsjnz61Y9xJXM
 rDg9YsgZLDICbtIPu3lttniZipTvZO4mH/XtiKqcL6nA6xxi20DHrPebi1SdI89CbDYZ
 YQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716905718; x=1717510518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pEb7meLbBTTaoqTDj2crmCDTE9wzssvULPCXBipboWk=;
 b=ALM9WyC1m3aFke0vOhPMxhi4eajtB/Y99o1W9q1PtbIziS6JkuMgK2UGa/K08CgFO6
 oj1fJQy0tYWJUg+rdZYo104teW7yVbKGlA+l9Mr9ZxpSsqsYCg6QkBW2ecB4d/7HRXe3
 htP1FvGNkWkK/5DkvBIzg3btixuGWmzcumQxN4SjX5zkj72MVdwksNlRZdNBc4moG3hM
 uy7ph5uv+/W2wNmTb1+UAgq53JTt4kXHHAwKYctjJUnGofLfS9rljU2sVNrv2WjSAODV
 PEKYNbCiQKYVwddKFkW8EH0N6+zAS+sgDQDYLgtpSSM9lGNZR+86QPr8sXbARhcBhqfJ
 k/7A==
X-Gm-Message-State: AOJu0YwAiLYuMqm6kzpNDMga7llWspO5eNM4AGZkE9VE3+QI9rgJm1jM
 PwKb0QYTUtarP6u2j1rP0xrRmPmeKmYdJsMCwbhR/p/A3WRs85MujzwT0FVdM2dlK5XKmDTCpLj
 CKJI=
X-Google-Smtp-Source: AGHT+IERg8V3YSmImDxUDwWEtyGEom1eN8nyzdiMp8+pm1hHsLfdE8C5u69FU+85zMGFnhUwhizTUg==
X-Received: by 2002:a05:620a:8d6:b0:792:c175:b12f with SMTP id
 af79cd13be357-794ab1106b0mr1104048685a.63.1716905718353; 
 Tue, 28 May 2024 07:15:18 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794abcc5844sm381033685a.53.2024.05.28.07.15.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:15:18 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Stefan Bosch <stefan_b@posteo.net>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Sergei Antonov <saproj@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v3 14/25] lib/crypto: Adapt public_key header with MbedTLS
Date: Tue, 28 May 2024 07:09:25 -0700
Message-Id: <20240528140955.1960172-15-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240528140955.1960172-1-raymond.mao@linaro.org>
References: <20240528140955.1960172-1-raymond.mao@linaro.org>
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

