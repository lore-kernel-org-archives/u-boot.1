Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 411F5C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 14:17:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C39158852C;
	Tue, 28 May 2024 16:17:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="r5ac6ouG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73F2088563; Tue, 28 May 2024 16:17:31 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AF8E884D1
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 16:17:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-794ab0eb68cso315474285a.0
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 07:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716905848; x=1717510648; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J6bitS7TTCjhccwE/acUrtuSNsXP8ljGzdhe9xBAjWI=;
 b=r5ac6ouG4EGKRZQ8/BUH1N/ndkEoZxqqJmKxP1yLS/U4njGJlv8k1rG8s84TaLScmL
 pCaoDYV0kibmTcWnxOxyGcmq3EdZ5FUnnK/g4hcnAIpJlrekCg5VsO+FCAXWdiwA4QBR
 8NORJIyVJEU2oAWeV7HJ7ak68hEECEmQEJXN3hJGmpgjg7T6pPVURjW+E5uv/Tom77PM
 sWIAudNpniC3OW04ksuXvUmUJeqzrJ15GIy3rUTqSpzulKaH+59Awi+1/aMmdzE0GqYL
 k9bT0fqKoWNeTBwK9fSzHi7jYJmfPaF/lk+7aO0GxIbunjzs1cC8spjsfp6dpaGv5wsP
 XERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716905848; x=1717510648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J6bitS7TTCjhccwE/acUrtuSNsXP8ljGzdhe9xBAjWI=;
 b=CnCYktt6x4nbdo20I0w7AFmLO2pY0OFFQBFXt+yTjZfbGt2TfrAzgQg52zpy0boEsO
 62hpqeq3zngsv12zfL4Bta+8fRb5vwhzyR5tSUVjUi5BjNlb7Gn6ltFp3xfr3YhR25c8
 VlLAWw96UnKJgCD6Tqhygv6246dUCwjRHqjwXdsk3coVFp8naUKHRczLs7AAP7jdLVDc
 HcWUHTJrU8fY24qvyT9Qwji59ShkyfmkM4SGZeIy4K6TAzdUzEpg0RZM16NqePfMTFJ/
 KpU0wzr7bw3N1mRBpQRxgnCoePF34N0jPrfHPDi8oH29ZuXfatspBz/e3kLQ+aVKcnWb
 Paqg==
X-Gm-Message-State: AOJu0Yyp9wRIoxviYMGYpakBLtJhq5zOf1BluXARXwSu+6a+BYJXEL9J
 fWiF1MlbNoywGBFBELr02lmlheIIUePswNgSdVCWlb1Vqi9P8fErVRksA3k4xW16aSlY1bfQLIo
 Xdlo=
X-Google-Smtp-Source: AGHT+IE7ncRX8fxh6vbNxMpEiBxNeljqZcJq5cpImBG95DcA3gMxv0JdbQ8UVFEZZ0CEY09IbZfmVQ==
X-Received: by 2002:a05:620a:4049:b0:793:19a3:6fa3 with SMTP id
 af79cd13be357-794a08fbcc7mr2685151185a.1.1716905848044; 
 Tue, 28 May 2024 07:17:28 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794abcc5844sm381033685a.53.2024.05.28.07.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:17:27 -0700 (PDT)
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
 Sergei Antonov <saproj@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilya Lukin <4.shket@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v3 20/25] lib/crypto: Adapt mscode_parser to MbedTLS
Date: Tue, 28 May 2024 07:09:31 -0700
Message-Id: <20240528140955.1960172-21-raymond.mao@linaro.org>
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

Previous patch has introduced MbedTLS porting layer for mscode parser,
here to adjust the header and makefiles accordingly.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Move the porting layer to MbedTLS dir.
Changes in v3
- Update commit message.

 include/crypto/mscode.h | 4 ++++
 lib/crypto/Makefile     | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/include/crypto/mscode.h b/include/crypto/mscode.h
index 551058b96e6..c214fc87e40 100644
--- a/include/crypto/mscode.h
+++ b/include/crypto/mscode.h
@@ -9,6 +9,10 @@
 #ifndef __UBOOT__
 #include <crypto/hash_info.h>
 #endif
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
+#include <external/mbedtls/include/mbedtls/asn1.h>
+#include <external/mbedtls/include/mbedtls/oid.h>
+#endif
 
 struct pefile_context {
 #ifndef __UBOOT__
diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index c3fe9c9d2c0..e3232019df2 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -62,6 +62,7 @@ $(obj)/pkcs7.asn1.o: $(obj)/pkcs7.asn1.c $(obj)/pkcs7.asn1.h
 endif
 obj-$(CONFIG_$(SPL_)PKCS7_VERIFY) += pkcs7_verify.o
 
+ifneq ($(CONFIG_MBEDTLS_LIB_X509), y)
 #
 # Signed PE binary-wrapped key handling
 #
@@ -73,3 +74,4 @@ mscode-y := \
 
 $(obj)/mscode_parser.o: $(obj)/mscode.asn1.h $(obj)/mscode.asn1.h
 $(obj)/mscode.asn1.o: $(obj)/mscode.asn1.c $(obj)/mscode.asn1.h
+endif
-- 
2.25.1

