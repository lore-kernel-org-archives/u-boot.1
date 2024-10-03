Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E2FCFA745
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 05:00:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC0AE8908A;
	Fri,  4 Oct 2024 06:57:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JqH2rOLt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9926288ED2; Fri,  4 Oct 2024 00:00:07 +0200 (CEST)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57BDF88F6B
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 23:59:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-458320b30e7so10146381cf.0
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 14:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727992798; x=1728597598; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PCVLaJeosaE+jxxfKDUCKZqXpFmc7t9eWVJ9QN6YMLs=;
 b=JqH2rOLtEg/SWCQD0bzgwKv535v7Rh15k6/Dw+yMZB359KdZFmxpAMD7FmjF5h6q+n
 xxhecqWcSLff7dyt1J8byTSvT4uu2/sI7Rvgk1BfFK5DB3Pqsm8fdED5FAb8xUyFQ81U
 9xMeEqu245PFHiZCX+Bt6dgrDAjgLrW9ZWCVMQrouL3Y1Zb0nh7qJTOJRmt99xQpMkg+
 A3bOGZ4fx6lzA0uRMY150ZO41mLCOFHPGygJqR8MQP+F9Zog2nnSXYAyiQCXWJW/V3Qr
 WEFUB8BMjco0jQAb4TsrwqwqAOU+G8SOd5yEXCZi3c6C/pHeLYeAfrdk+2Zq6NMZfYiV
 MVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727992798; x=1728597598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PCVLaJeosaE+jxxfKDUCKZqXpFmc7t9eWVJ9QN6YMLs=;
 b=Mbf/cVWXAYkCfpXIEpCWzhBnRg6usRqa0gZqyx7t0e5Uvq2rNX1hvh7rDGtrmV4XcE
 fesp5oNKjd7zBQnoT2YFIAmGNnIxW9+oLaZEA8d9IYF4CbFmLDzU+1RwlnS1bDy4aggA
 Br/OfIIenqREwQ4OKQdssVnQ3hxMK9CtIuhlRhUwDTnFxGv5GPtEtyYDhxlJKqgTqbSp
 rKh0iMmaFlfEQwViBcNarS1eiCOCtI7Ln1lTkYVLXPF/e+feW6JfHWNV0eexRZlc9AXu
 w/w++AR1BAtAIA5daGWmfGrs/VYZrrWfY9aOOBbQMDlKOe3Zjg7ijPK+5ehb0FpU/Sdt
 5D9g==
X-Gm-Message-State: AOJu0YxcH57cIVY9VivHqRQ1kWvXsU5MOwIIE3A1aJmY7ZOXaSOA3wRw
 YplaKeh0uUaSi4iyBfXubJhoeLLoMVDtKq50QVts3stxXYRp9MbYwi6c/roX8YNphIiJVnk0c+5
 w
X-Google-Smtp-Source: AGHT+IGpI2kputNwQfBjzNxMa4b3/hDxXuoka6c4ZL/lmaJaleWOcrNa/qxCYPJsFS5Iurxsngc9Rg==
X-Received: by 2002:a05:622a:8c:b0:458:53b3:7a01 with SMTP id
 d75a77b69052e-45d9ba9eaf7mr9366531cf.18.1727992798027; 
 Thu, 03 Oct 2024 14:59:58 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45d92ddf5c4sm9001541cf.18.2024.10.03.14.59.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 14:59:57 -0700 (PDT)
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
 Sumit Garg <sumit.garg@linaro.org>, Sean Anderson <seanga2@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Marek Vasut <marex@denx.de>,
 Jonas Karlman <jonas@kwiboo.se>, Kongyang Liu <seashell11234455@gmail.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v8 16/27] lib/crypto: Adapt public_key header with MbedTLS
Date: Thu,  3 Oct 2024 14:50:29 -0700
Message-Id: <20241003215112.3103601-17-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241003215112.3103601-1-raymond.mao@linaro.org>
References: <20241003215112.3103601-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 04 Oct 2024 06:57:18 +0200
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
Changes in v8
- None

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

