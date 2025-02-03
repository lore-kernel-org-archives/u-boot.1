Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B8BC02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 22:08:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD48B80087;
	Mon,  3 Feb 2025 23:08:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GBD1g6EE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EF16800B3; Mon,  3 Feb 2025 23:08:37 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02E2480050
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 23:08:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7b6c3629816so264767585a.1
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 14:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738620513; x=1739225313; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NllE1FMKx1udmMfX1GHQIdD1T0bKJMVsJOjB3/oZG/8=;
 b=GBD1g6EEkXz9jV60SE6HYQhsNXYF0HlT1L/vX55+T9DJZpNnpAMkmeQnCJnCDAgT43
 KGMsqnetAH+uGKoKSkwLe3GS0OuD/M9NApRf7aoh//2lGfPcDZuBYBD/wRJ51qBxYVVc
 3j05tYB5NYXC3FwSXi44RSDVWAoML6+d+oFLA4LeGLANz8gd+IR4cwcLc0cwiSfvrPjH
 cmaiExlwzI1s6KvWOsivGRzbVDErtLn/9TppX+27HMTiRvIO/sx00Pz8/jwL9kSS7p5o
 vJraSfPPDxYYG9i69jF7fHStJScq3FincAhxmQo2fl94JoEpHtMjMTamAsti/kglF+7x
 7dUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738620513; x=1739225313;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NllE1FMKx1udmMfX1GHQIdD1T0bKJMVsJOjB3/oZG/8=;
 b=JafHLKYeTg0JKCJEVLaFMsk1l5rpVfvEChqBRsaT4AaNrUvhKXykCL7knJeLwczr9+
 KepyvndRtEhY4ckWJ/aaKY8ka3ci+xNr7xDWlBOR9Jz5Tq5ZGrlovQ3U3uqMPstrLbmH
 tEFWOndnnKpg9cMPsV+R9bDcr9hwIVB8nDDQbgkFCPr/ide63bHD7339994Ls1NYeo+Q
 hQRLdvK5PuQ16SoQWjCcrbYShma961PF/QPjNhpqXl+YQo5OjGnWlfgOm+uyamng5DC2
 Doj2rJ3VKMh39c/E2fj5txZMVwxTVAfEWNbjq1PyYenKaoH50zGz2tgP46WeLjpFY7WF
 mdFQ==
X-Gm-Message-State: AOJu0Yy7ERe4w2mfedqLF8wJCfD9zsAHKeLbm8Wuua4w0huN+tST8pEx
 xx1t8QRBd81QLt6iYDQv9FWQLdEd+VvG0x2lW11Ywgd5xaYITA48Y4ech4oHainHYls8WWVUCA+
 QBbo=
X-Gm-Gg: ASbGnctY9ofYK/lmpNjO5ZOiq5LWFMhjN79MyRA4YHsslJziZHDSRcS8AVXuM5ZjSIq
 ti8W+Ki9DFxjjiIGVSWnAIYZ8croRBxam/m5pXUinZsa+U83A62mdu1f1HlTlWPSI4qGK7LYgUn
 Hv6haiR+raA5khQlMmSgeoCXwx905QnqHqeaLrbfHGJUi3dJTscs1BZn+ks1lmuerpNw11IayID
 Mjq7fiGn1d6aum8R/HWs92zZEph4oa34QA+fyMFS2FI6O0rkoqy05aR/jmPwruww98aXOlCphhn
 kRCt+AqYX9GXlFLp7BAcwbUfkBVmuA5N4eQg9w7WeE68OqHy/4qpOG6CdC3WJnXMYiuhi17UCbB
 gSaMuLGKytkXRcQ==
X-Google-Smtp-Source: AGHT+IHMtL18gG4OlTk2O9JcXe7smkO66R6wJd8SfBh/jWOC4aNeD/RNsj95fdtiQy+O4yCleWpjuA==
X-Received: by 2002:a05:620a:1d0e:b0:7b1:4f5c:a3a3 with SMTP id
 af79cd13be357-7bffcda0a4fmr3965499385a.56.1738620513569; 
 Mon, 03 Feb 2025 14:08:33 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c00a8d8700sm569781085a.49.2025.02.03.14.08.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 14:08:32 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v2 1/3] mbedtls: fix incorrect kconfig dependencies on mbedtls
Date: Mon,  3 Feb 2025 14:08:12 -0800
Message-Id: <20250203220825.707590-1-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
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

Fixed the building failures when WGET_HTTPS,NET_LWIP and MBEDTLS_LIB
are selected due to a few incorrect kconfig dependencies.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2:
- Remove the renaming to patch 3/3 and update the commit message accordingly.

 cmd/Kconfig         | 1 -
 lib/mbedtls/Kconfig | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index e62817bd977..2e2dd459f56 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2160,7 +2160,6 @@ config WGET_HTTPS
 	select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
 	select X509_CERTIFICATE_PARSER
 	select PKCS7_MESSAGE_PARSER
-	select MBEDTLS_LIB_CRYPTO
 	select MBEDTLS_LIB_TLS
 	select RSA_VERIFY_WITH_PKEY
 	select X509_CERTIFICATE_PARSER
diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
index 35d8c507a89..bb8ac5f862b 100644
--- a/lib/mbedtls/Kconfig
+++ b/lib/mbedtls/Kconfig
@@ -156,6 +156,7 @@ endif # LEGACY_CRYPTO_BASIC
 
 config LEGACY_CRYPTO_CERT
 	bool "legacy certificate libraries"
+	depends on LEGACY_CRYPTO
 	select ASN1_DECODER_LEGACY if ASN1_DECODER
 	select ASYMMETRIC_PUBLIC_KEY_LEGACY if \
 		ASYMMETRIC_PUBLIC_KEY_SUBTYPE
@@ -491,7 +492,7 @@ config MBEDTLS_LIB_TLS
 	depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
 	depends on ASN1_DECODER_MBEDTLS
 	depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
-	depends on MBEDTLS_LIB_CRYPTO
+	depends on MBEDTLS_LIB
 	help
 	  Enable MbedTLS TLS library. Required for HTTPs support
 	  in wget
-- 
2.25.1

