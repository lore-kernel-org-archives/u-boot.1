Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF53FC6186
	for <u-boot@archiver.kernel.org>; Sat, 14 Sep 2024 01:07:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C67F88E11;
	Sat, 14 Sep 2024 03:04:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gAXBAyb7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61CD588706; Fri, 13 Sep 2024 18:11:50 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DB6C88B27
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 18:11:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6bf92f96f83so8342006d6.3
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 09:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726243907; x=1726848707; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q0+IFERVxS2sq9ZZFW01lC6mpTN+GX+Yoo8/Js8IgFo=;
 b=gAXBAyb7+kbg+1L9xGfBEtvR5p/g6u3YLkdY8y+MDQBxMWH0sfvFeGC61PiGIHo0l0
 KEIC/0GMaMPYfL3QixMIvS6+iqnYAxJvcbco9DNKW7gabLKVJS5G4JFGLhsfnwvhHugM
 I+8zizXbyNyugJ/LruG7wEkjaot52JGom7ZXKPt6Om8QEblUvuGaC8ovI5SjWrOlAanV
 pt5kGzE6Zqz3n8xR6l+MFsKQG6MwQgxBWLnWIZL1voyoMH395lutMgcqQEkn1O/yGWMK
 HOwi67SbSLIfIM9MkAZpLYdoQD3A4z/yS3hk0d/BpTigxRfFExVjH2XNsdPaE0ZtpY4P
 a+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726243907; x=1726848707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q0+IFERVxS2sq9ZZFW01lC6mpTN+GX+Yoo8/Js8IgFo=;
 b=xDPBTLQyuclPZUMXUV4aBpBUFqHsi+ciRwy2tIaqUoZF2Yu65cT2rdGEW/IohhyG0G
 YW9XL7wZdnQfC1yp7PII2neAw5h9miJjoc+C585aGn8k6L7/Ay3/r1QC7q6IpevJZPs/
 VjcLPdoLBvy2Ct1ZMDJON3aEd/g6bO3TN7q3jLvYbphN9hON5Oh/Tqaaw7PgNEKkPtvU
 yw+QaVWCYhjw+Z8V2D6MieQHgpaC5SNOTBXAPQx7YeCuSnZ9nEeT+wNCE1kj8nQb3/mZ
 1NiemwWPAVOtKz3cFZaiwRFOLuBa4xvntZaE8o4eUef64ACtoskm1FQaCY1oWXkqp1RW
 tjRg==
X-Gm-Message-State: AOJu0YzTaP1/3a6APEjiUtyRppf/nNgrk4K1FupxnSJKm8hRjOWUbpzC
 52YhjA45B959QnM0T2jH7hhvMQMvCpoM5IWXU7RadzEL8O8bFrVIO7uG9utYg8xwJ1EIUO+X0hG
 c
X-Google-Smtp-Source: AGHT+IE+tQy1dx+f9DgBQXkMJ/g3xk1KEXfRqrJeflOx2O4Uc7f3z3oTgsRf4qgegacDLExCf5l5TA==
X-Received: by 2002:a05:6214:5685:b0:6c3:5597:406d with SMTP id
 6a1803df08f44-6c57dc9cdfdmr63004766d6.0.1726243906849; 
 Fri, 13 Sep 2024 09:11:46 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c534774908sm67697286d6.118.2024.09.13.09.11.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 09:11:46 -0700 (PDT)
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
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Andrew Davis <afd@ti.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>, Marek Vasut <marex@denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Greg Malysa <greg.malysa@timesys.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v7 16/27] lib/crypto: Adapt public_key header with MbedTLS
Date: Fri, 13 Sep 2024 09:03:33 -0700
Message-Id: <20240913160408.2199558-17-raymond.mao@linaro.org>
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
Changes in v7
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

