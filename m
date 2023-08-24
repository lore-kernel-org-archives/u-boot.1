Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD78BC3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 19:28:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01461869C3;
	Thu, 24 Aug 2023 21:27:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TjpDTJFu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BB4686900; Thu, 24 Aug 2023 21:26:58 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4310886995
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:26:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-51a52a7d859so2618284a12.0
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692905215; x=1693510015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yuQ4iWKY6sR5mEfnYSqXtkZWwArfdK8Y1eLh6Iceoas=;
 b=TjpDTJFu+5FqjulMpyWoSiI177b5WNtnVbVkESZwdv1euhwd+fpirPQvoghEIsRxLp
 1Xrow4cZibcAFIacwP7DxeUiU3LFi452N3jfLwcoz8rEnhFdYTXEaEi1b6u53Xs4IO7m
 ewv27zXyBZe0xpfohQtOhmVfzT0zx705KLbL1fATXCEsb1UCV0D24jjpF31ld7TwfEvJ
 iSl04H8FauBNcbr6UhY3E7quWzKwWMvH5FHHSb2HNrwL6VLjD7MMTUnkfkPIeiB+OrUV
 TPO8CWk+/gb7eBb6tfEAu0aMrX2PmYzpGKigN7d5T0dwM4Rs51jk6eTutG/SKtEOTwR/
 xdOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692905215; x=1693510015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yuQ4iWKY6sR5mEfnYSqXtkZWwArfdK8Y1eLh6Iceoas=;
 b=fUS313ZILeddmlvsLz0tLC+upBsbpPiyiUV10Vgz4iAlhVrTm0+f8t1opIYiNGIoVe
 VS8c206/awAeWpyhhzBD5odkrBJsdxhU6cd4lMTX/O0TepWDzul5m+ZEvRpHniD2ZuRd
 DfRkSPV5qSJPi/SnhpbJOt69QvFRACoccMwIqHKLyzZEaurIsJoSQJA2T0TOBGQXxRcj
 Y6mfl5w8vS7PAZN4CvN33toxFKGzsx3v48EyVWDbw3QtnknNird1pdkh1LxIGkjv+3VN
 eOtUfleb63KQkRk8oZqOfLvhSz0+bmQ6EdZWtss4KScD2fy1eAXJw83AoJaEESpOrAZ2
 g4Rg==
X-Gm-Message-State: AOJu0YzZpPWR6osRiPj30TipFMZN0KqUDUpsVD1DVLE8EZOgzKV9saFQ
 nHGpOEvaw1udl2n1iICbq1Y=
X-Google-Smtp-Source: AGHT+IFwglRXdTJ7KOanBFPJ6Q12cGas0EoUsMQMMHHHPtnA+nsqSNtgxenGujbOfxNvWQOy1phHxQ==
X-Received: by 2002:a05:6402:3586:b0:522:b9ae:db3c with SMTP id
 y6-20020a056402358600b00522b9aedb3cmr17336651edc.6.1692905214802; 
 Thu, 24 Aug 2023 12:26:54 -0700 (PDT)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 be20-20020a0564021a3400b0052a1d98618bsm96033edb.54.2023.08.24.12.26.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:26:54 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 07/16] ARM: dts: transformer-t30: complete missing bindings
Date: Thu, 24 Aug 2023 22:25:54 +0300
Message-Id: <20230824192603.240104-8-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824192603.240104-1-clamor95@gmail.com>
References: <20230824192603.240104-1-clamor95@gmail.com>
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

Clean up the tree and prepare for DM PMIC migration.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/tegra30-asus-transformer.dtsi | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm/dts/tegra30-asus-transformer.dtsi b/arch/arm/dts/tegra30-asus-transformer.dtsi
index d144a56445..888f9ca74e 100644
--- a/arch/arm/dts/tegra30-asus-transformer.dtsi
+++ b/arch/arm/dts/tegra30-asus-transformer.dtsi
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <dt-bindings/input/input.h>
-
 #include "tegra30.dtsi"
 
 / {
@@ -70,12 +69,19 @@
 			gpio-controller;
 
 			regulators {
+				vdd_1v8_vio: vddio {
+					regulator-name = "vdd_1v8_gen";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
 				/* eMMC VDD */
 				vcore_emmc: ldo1 {
 					regulator-name = "vdd_emmc_core";
-					regulator-min-microvolt = <1000000>;
+					regulator-min-microvolt = <3300000>;
 					regulator-max-microvolt = <3300000>;
-					regulator-always-on;
 				};
 
 				/* uSD slot VDD */
@@ -88,8 +94,10 @@
 				/* uSD slot VDDIO */
 				vddio_usd: ldo3 {
 					regulator-name = "vddio_usd";
-					regulator-min-microvolt = <1800000>;
+					regulator-min-microvolt = <3100000>;
 					regulator-max-microvolt = <3100000>;
+					regulator-always-on;
+					regulator-boot-on;
 				};
 			};
 		};
@@ -110,6 +118,9 @@
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
+
+		vmmc-supply = <&vcore_emmc>;
+		vqmmc-supply = <&vdd_1v8_vio>;
 	};
 
 	/* USB via ASUS connector */
@@ -208,7 +219,6 @@
 		regulator-name = "vdd_5v0_bl";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
-		regulator-boot-on;
 		gpio = <&gpio TEGRA_GPIO(H, 3) GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
-- 
2.39.2

