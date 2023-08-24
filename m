Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A37C3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 19:28:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61CC6869E1;
	Thu, 24 Aug 2023 21:27:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UT4YoaPb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91614869D2; Thu, 24 Aug 2023 21:27:01 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B60186900
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:26:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5007c8308c3so254563e87.0
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692905218; x=1693510018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mSSqpiiTKFMhLmIKSJQ2JBruJbcK3t9XTWfTF9IzDzk=;
 b=UT4YoaPbstXs9G8r4NmbLaVQPZ0G7T3za2eAGgBIP34uwLwM/8Dh4s5EpiNCLqTvv1
 r3oOLXK1bdJFtJEkSCCZeCCDYTAhrLP5V1A5hzH2taGrQMUPmwhtvg6Hn+hT1/nEIb1s
 1KkxFFfYlBNmRaM22+IWp9ukcqOlzt0792WXjbz2IcR3Z8zGjV8fxq8sO0I//tj92+kY
 vdMxxD0QDNVVt6TfbkDNoXauQNulOPVPVFChZIZ4d/mLSmG4fhhbSav/B7QHbcDF86oJ
 o3Kbhwe+bc0YQxRVYdjdFD3udnpQTnK92VhMn3D2ii6Elu0md/FvPfKOuxDGY6Dhr3tl
 Qg5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692905218; x=1693510018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mSSqpiiTKFMhLmIKSJQ2JBruJbcK3t9XTWfTF9IzDzk=;
 b=NNnwIrXF0QEbDd2kAuCe47/R8+SMLx6J+5zx+aDRXhhRWLLjnRhvLVw8VoS9WnyyfP
 ULtn1J0//GmcERdr325P/fSTmNIoEbIyZ7PhvnnTJqT0kQ7DfTVBrtWwo/ejXWPmh5GT
 hPQCGQb/JDmewxoE+ip12OkXFdrms4eR3YBc7Kax9qqO/FvlwN6Oy1Gak8uNLV0RVOUJ
 iSoE+x4fViFrv82PsbVfej17VlwrWMWtb34zHkZUfe69b2x/EFKZu5OqjX/1QZoAue2r
 lcyU7qal+9kYPM0Ej3pXJBE7AfahWMWUlwsH62wKDeINCsbOsvrhF/zOrqIxm4GWVqgM
 Og3g==
X-Gm-Message-State: AOJu0YxCa3ak0idCoZB1PUv9zGVqt4Z3b/VPtcMHbP+Xf+u84KcRDYdf
 xHPtGQNqhCScFefABWp0Klo=
X-Google-Smtp-Source: AGHT+IGROHhHaBVhiEcFKXvdcesLj95gCvuarj4NqdPLHeUk4Gb0m0cXdqEUnLlK2zWm0sJRvw+4kw==
X-Received: by 2002:a05:6512:615:b0:4fd:d9dd:7a1a with SMTP id
 b21-20020a056512061500b004fdd9dd7a1amr11584321lfe.31.1692905217739; 
 Thu, 24 Aug 2023 12:26:57 -0700 (PDT)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 be20-20020a0564021a3400b0052a1d98618bsm96033edb.54.2023.08.24.12.26.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:26:57 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 10/16] ARM: dts: grouper: complete missing bindings
Date: Thu, 24 Aug 2023 22:25:57 +0300
Message-Id: <20230824192603.240104-11-clamor95@gmail.com>
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
 arch/arm/dts/tegra30-asus-grouper-common.dtsi      |  5 +++--
 arch/arm/dts/tegra30-asus-nexus7-grouper-E1565.dts |  5 ++---
 arch/arm/dts/tegra30-asus-nexus7-grouper-PM269.dts | 11 +++++++++--
 arch/arm/dts/tegra30-asus-nexus7-tilapia-E1565.dts |  5 ++---
 4 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/arm/dts/tegra30-asus-grouper-common.dtsi b/arch/arm/dts/tegra30-asus-grouper-common.dtsi
index 4fa980f24f..fcf31e2dd0 100644
--- a/arch/arm/dts/tegra30-asus-grouper-common.dtsi
+++ b/arch/arm/dts/tegra30-asus-grouper-common.dtsi
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <dt-bindings/input/input.h>
-
 #include "tegra30.dtsi"
 
 / {
@@ -62,6 +61,9 @@
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
+
+		vmmc-supply = <&vcore_emmc>;
+		vqmmc-supply = <&vdd_1v8_vio>;
 	};
 
 	usb1: usb@7d000000 {
@@ -150,7 +152,6 @@
 		regulator-name = "vdd_5v0_bl";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
-		regulator-boot-on;
 		gpio = <&gpio TEGRA_GPIO(H, 3) GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
diff --git a/arch/arm/dts/tegra30-asus-nexus7-grouper-E1565.dts b/arch/arm/dts/tegra30-asus-nexus7-grouper-E1565.dts
index a98d3e2145..945ae404ac 100644
--- a/arch/arm/dts/tegra30-asus-nexus7-grouper-E1565.dts
+++ b/arch/arm/dts/tegra30-asus-nexus7-grouper-E1565.dts
@@ -22,7 +22,7 @@
 			gpio-controller;
 
 			regulators {
-				vdd_1v8: sd2 {
+				vdd_1v8_vio: sd2 {
 					regulator-name = "vdd_1v8_gen";
 					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <1800000>;
@@ -34,8 +34,7 @@
 				vcore_emmc: ldo3 {
 					regulator-name = "vcore_emmc";
 					regulator-min-microvolt = <2850000>;
-					regulator-max-microvolt = <3100000>;
-					regulator-always-on;
+					regulator-max-microvolt = <2850000>;
 				};
 			};
 		};
diff --git a/arch/arm/dts/tegra30-asus-nexus7-grouper-PM269.dts b/arch/arm/dts/tegra30-asus-nexus7-grouper-PM269.dts
index 44ea218a47..4363bfc87d 100644
--- a/arch/arm/dts/tegra30-asus-nexus7-grouper-PM269.dts
+++ b/arch/arm/dts/tegra30-asus-nexus7-grouper-PM269.dts
@@ -23,12 +23,19 @@
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
 			};
 		};
diff --git a/arch/arm/dts/tegra30-asus-nexus7-tilapia-E1565.dts b/arch/arm/dts/tegra30-asus-nexus7-tilapia-E1565.dts
index 812d5a1ba7..89348fde13 100644
--- a/arch/arm/dts/tegra30-asus-nexus7-tilapia-E1565.dts
+++ b/arch/arm/dts/tegra30-asus-nexus7-tilapia-E1565.dts
@@ -22,7 +22,7 @@
 			gpio-controller;
 
 			regulators {
-				vdd_1v8: sd2 {
+				vdd_1v8_vio: sd2 {
 					regulator-name = "vdd_1v8_gen";
 					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <1800000>;
@@ -34,8 +34,7 @@
 				vcore_emmc: ldo3 {
 					regulator-name = "vcore_emmc";
 					regulator-min-microvolt = <2850000>;
-					regulator-max-microvolt = <3100000>;
-					regulator-always-on;
+					regulator-max-microvolt = <2850000>;
 				};
 			};
 		};
-- 
2.39.2

