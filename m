Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A21C52D7C
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 13:43:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2D6288C25;
	Wed, 21 Aug 2024 15:42:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="K30ji2S3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9300088DD4; Wed, 21 Aug 2024 15:42:03 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E8D188DBE
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 15:42:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a7a94478a4eso147841366b.1
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 06:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724247721; x=1724852521; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yPrDPgQU7/bvZow9laSNg4WMEx5CRzVugf/oAUblCT4=;
 b=K30ji2S3yioeE5/M0vSF0qrx1STvg5+c45nG5Kg+dcjyT1GMIsiX0GbpHc8+aTeWpp
 Bd16xS5DE9TAuA1s2WmMq1TNdKHCyyx3MSSHMP9S9SctgsZSxIypHfGf7m6duOmEf5I8
 HBAumCuGiHTW3NkqIl8H2yZjkAbajsM1Q98+NyYJskO8owlNVyczk44QEbJ16Jtmntq6
 u+v7SADVhB3LrWu30OOWnwu/Z/9TVapcDx+ZAGflSfCy5P54TgqYIRYrBtjn9huobmaJ
 XJED4Ak8A7iJHUQ5Savv+T4lTPHHfD+J+1NZDr1ciKMujXdnFUuZYcUZLoAn0PHLVsDD
 +S6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724247721; x=1724852521;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yPrDPgQU7/bvZow9laSNg4WMEx5CRzVugf/oAUblCT4=;
 b=RTxkaBLhQgRZeSdTWakNQdltrcGw4Cw+6Jge9dwNM3Q/YJMSuM1z7N2JGOntXjHxD2
 NZzz61S7FHFOOjYJoubSodORxK53ddoKFuwUvxurdOy+9Y67fPtAweqdd8NJnDdvBrEh
 35wnkzs6ItOpaYe1StAVW06cFPwhqK7ajV3yVdoyKwzCfp8oTYHC5QFJUhi0EM4KnF97
 HepCXvJdv+Qm1/hOVJu19Y6L2RKwXEWztyS53XVwtLOeyKO5x4Qk4PuhnZEAcGkT5lBB
 0kaoF4zSuIX8CVYMJ4oa/4TJg/epJPEtpdDjPDJ2KEWVWbay4/E7PLlgi/tDNndUgOGI
 5vvw==
X-Gm-Message-State: AOJu0Ywpr+aZcIll1/M3ZGdzXawgIEMgRfu4GacRerzZeNne6pIDfvz0
 FBjk4XnDaPXHLxU60pO20RaUjuXG+96oqxwOdmGkP/6Hf3yiMbOJc/ikC/obqxQ=
X-Google-Smtp-Source: AGHT+IFBBHXs1fwWXLXlqsclsjPN/CITy3andQbbeClu6l28M7g0bUERMexbKgeMqQwwLkcBMwvMRA==
X-Received: by 2002:a17:907:1b2a:b0:a86:668a:8b28 with SMTP id
 a640c23a62f3a-a8670182bd0mr296134266b.30.1724247720548; 
 Wed, 21 Aug 2024 06:42:00 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::676e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83839342f6sm904164066b.137.2024.08.21.06.41.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 06:42:00 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 21 Aug 2024 15:41:51 +0200
Subject: [PATCH v2 6/7] configs: add qcm6490_defconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240821-b4-rb3gen2-v2-6-49b07633f3a8@linaro.org>
References: <20240821-b4-rb3gen2-v2-0-49b07633f3a8@linaro.org>
In-Reply-To: <20240821-b4-rb3gen2-v2-0-49b07633f3a8@linaro.org>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1579;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=ACfbGsu6Qfhpulh7cWGr4R2PHD6f1xBOaMcu/oMTV/k=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmxe6eltJAuAi418HOLC6BvAwvNrE6K+OD4tmaU
 8Agtuwf3TuJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZsXungAKCRAFgzErGV9k
 tp2fD/4izqkO8vl46KJDMg5exEAzqayxPJyZcBnhIQyekkEfHowP0Hnr0xDZqbYbl6BAapt+ZBA
 237lBMrvuWc45PJO228GrtQw+7AcU8UqYXvy0mhiS+xUJHhirFotdPZX8jly9sRdw54SUINx7vl
 HThC3BXeYgmzugZXoSGA3Dw/d8NZXgf5aCjqXW/pIMBWK4RB/4r84gPQG3dgNT12yTVuNtN81ng
 7UMKgDHnK5kaXNh630td4ZmmJQ2jhUU/DShNLmKJnpe67xiK6DjHJiQqgqqj2ZZ38qvlRRpNYgx
 0iwUSyvlnNrB6dHAyzgUjMFaqxReb+rJKvr7+k9YB1dbmysbh9MM3WlWKmf9P39qLjJp1zBwd5z
 9lolc/k+9FT0hziFLDd1sMPQ0oBSZQQNFxZCEtncn387cDFCvJb/nUZnyt6XVzimfnSfssBGQ/g
 A04MCaVXei5UeDZHc2kuv4yi7bWWnN3hZVdkoSHMe5esd0cYlVmz2tBkPzTDWIckquNRo/2dWyE
 k5yQoqRVqg/V1GTE0f3B9aL/diPmJdYp+Z2FAAihFEUEOAKSPr+BfGIm2bNoMHUUQRGecjNoitg
 qLmRTfs21gQs6x1ZivJ1tm3WGl2u+FUm9uuyYwB0bGnXasAzIBB+F4K2AL3dcULGf3Au2Q4w7Y1
 ULXtGjABlmE9Z5w==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Introduce a defconfig for the RB3 Gen 2 and other QCM6490 boards with a
dedicated uefi partition. These can replace EDK2 entirely with U-Boot.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 MAINTAINERS               |  1 +
 configs/qcm6490_defconfig | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index daaf0345d0e8..7ab39d91a553 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -616,8 +616,9 @@ M:	Neil Armstrong <neil.armstrong@linaro.org>
 R:	Sumit Garg <sumit.garg@linaro.org>
 L:	u-boot-qcom@groups.io
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git
+F:	configs/qcm6490_defconfig
 F:	drivers/*/*/pm8???-*
 F:	drivers/gpio/msm_gpio.c
 F:	drivers/mmc/msm_sdhci.c
 F:	drivers/phy/msm8916-usbh-phy.c
diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
new file mode 100644
index 000000000000..25413ac9ed5a
--- /dev/null
+++ b/configs/qcm6490_defconfig
@@ -0,0 +1,18 @@
+# Configuration for building U-Boot to be flashed
+# to the uefi partition of QCM6490 dev boards with
+# the "Linux Embedded" partition layout (which have
+# a dedicated "uefi" partition for edk2/U-Boot)
+
+#include "qcom_defconfig"
+
+CONFIG_DEBUG_UART=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_BASE=0x994000
+CONFIG_DEBUG_UART_MSM_GENI=y
+CONFIG_DEBUG_UART_CLOCK=14745600
+
+# Address where U-Boot will be loaded
+CONFIG_TEXT_BASE=0x9fc00000
+CONFIG_REMAKE_ELF=y
+
+CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs6490-rb3gen2"

-- 
2.46.0

