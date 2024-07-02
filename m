Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9EAC3065C
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 18:33:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF185887E3;
	Tue,  2 Jul 2024 20:33:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="efJ9+Xeg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DE6A887EB; Tue,  2 Jul 2024 20:33:24 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ACDC87D74
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 20:33:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-4464b843e37so22796971cf.0
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 11:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719945201; x=1720550001; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=27tw/fHfcKg1GSDpQTqme+GGGSVk/OfU2XJenDJbcVs=;
 b=efJ9+XeghwnktBqFlYhZVxh/EapNO9d6gIdITDB7y4/V1d7LCwKgZXVk5LeW59CNZ8
 zDRdZmV2pIdh1NkpmPOgiFb0xjMBNiiR6H3K1w4JbMwwS8XM8xUPOiJZ6erVoZ2eQpH5
 LsU+1lOSycvph9Yh4Vw25Goplq+GuZ5MegjdThGy5kLYt+isaY+7MHoBRY6Mffr/82tM
 xwCKWokvGYvynrjk771b/02XJV3rD0H6yG4CtfPx/CHl04v1OcwgUF9N4DBJZ3sn6gyT
 qJqViPhnKAjxfp0XXOpWfmRBawY52lqOuZrXLnNpbZKZTZZIPdSj47JR8y9uAptdU5hX
 OyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719945201; x=1720550001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=27tw/fHfcKg1GSDpQTqme+GGGSVk/OfU2XJenDJbcVs=;
 b=mAERKLweLphciw4xX8o5XOEidb7yGnGNsyVRUfL6tiNVjoOzPaH9B0hQGFRNR9fyUD
 FQNNMYc9QoLDOIyxR9kc/o9x/UcsY+DKm7oJLRAAD2F5ecgzZXiD5OiaiHconD2d2u6v
 vXKi2AjGVeYICUf1mp26rRJyYOdTYIRaG631Ci98rdISDrr3JwwwM7L5PFxjb1nQPaNS
 Pkk1Opa0KkSRTAbnzhd5/7bYcvoSJ7hPncNZ39J6DvNds7gh2YwHxrmQkDwNbljieViT
 5XlvOehP4JN8x5ywep1dia3PKhY76XRW2FdHgf+vPxI1RJU3vAnV57iw5B3o1unbeC1B
 jubg==
X-Gm-Message-State: AOJu0YzydiYyhSjix3uQb1GqOxF5NKn0TBgQLod/O22NhVXfzlWUpJay
 7GZSS3kjRWPbklATDdKCKIiUghH3geYc0OarYJ5qae5wQSncopqjQUJlgNqAqGtbzWnvf+TFFRe
 7
X-Google-Smtp-Source: AGHT+IG9bN0w/yS+wmTFpmClFyRiuZTaofsJ2YC5YzAjwPrPFe3punbvYUDIlOIhdiQrjfLEcjBYKw==
X-Received: by 2002:a05:622a:4f:b0:446:5c9b:4e00 with SMTP id
 d75a77b69052e-44662c99c3amr98596101cf.8.1719945200670; 
 Tue, 02 Jul 2024 11:33:20 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-446514b613dsm43316351cf.84.2024.07.02.11.33.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 11:33:20 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Sergei Antonov <saproj@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilya Lukin <4.shket@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Bin Meng <bmeng@tinylab.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v4 24/29] lib/crypto: Adapt mscode_parser to MbedTLS
Date: Tue,  2 Jul 2024 11:23:00 -0700
Message-Id: <20240702182325.2904421-25-raymond.mao@linaro.org>
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

Previous patch has introduced MbedTLS porting layer for mscode parser,
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

 include/crypto/mscode.h | 4 ++++
 lib/crypto/Makefile     | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/crypto/mscode.h b/include/crypto/mscode.h
index 551058b96e6..678e69001b9 100644
--- a/include/crypto/mscode.h
+++ b/include/crypto/mscode.h
@@ -9,6 +9,10 @@
 #ifndef __UBOOT__
 #include <crypto/hash_info.h>
 #endif
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
+#include <mbedtls/asn1.h>
+#include <mbedtls/oid.h>
+#endif
 
 struct pefile_context {
 #ifndef __UBOOT__
diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index 428dcba0a6b..9bbd8b48d77 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -63,7 +63,7 @@ obj-$(CONFIG_$(SPL_)PKCS7_VERIFY) += pkcs7_verify.o
 #
 # Signed PE binary-wrapped key handling
 #
-obj-$(CONFIG_$(SPL_)MSCODE_PARSER) += mscode.o
+obj-$(CONFIG_$(SPL_)MSCODE_PARSER_LEGACY) += mscode.o
 
 mscode-y := \
 	mscode_parser.o \
-- 
2.25.1

