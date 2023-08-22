Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33236EE49A3
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 11:24:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA569864B7;
	Tue, 22 Aug 2023 13:22:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KFsAc+5b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EC9F864C8; Tue, 22 Aug 2023 13:22:52 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0F4D864B8
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 13:22:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-99c0290f0a8so548882866b.1
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 04:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692703369; x=1693308169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mSSqpiiTKFMhLmIKSJQ2JBruJbcK3t9XTWfTF9IzDzk=;
 b=KFsAc+5baXOGRNS9++zDWafR9envtzrXnSsMBkkfRboYtkZlv7Ml+gLNpA+nbI8hQo
 OiqCUWYwN0vFp+iay+NZ2oqOn7I+6Q+2DeSrTxhP3w2vXiMrxIaVaJOCug0GUKGD4J+m
 oWcYsL8mmnQCjwsrD0509xOO6xEAcN7WhgAaz/XXfDIreiYZCw2VxxFCM7qDv3kVzsXA
 rPBsP13NgwSZ//gLdFXpLGVvqQgT/O1LZ1+YHMKxLmWAES0pn3lpyF8eVDL2Mhtv9DKV
 oOX6zgou1rxdzGZqpnVepRXjO/rP3gJhLc4CN7KwTSPiahf+ygCF/OVXntTcnLrXcSPH
 FB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692703369; x=1693308169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mSSqpiiTKFMhLmIKSJQ2JBruJbcK3t9XTWfTF9IzDzk=;
 b=iwVySB7qeRBgMMSF57Ip0OEdESYoyAUuRNNkmvz1m+ApOmzUkJidoGxM8JxCBhxC3L
 PZkLSohr05DKymhrX+gmbepZP+huPBR//3A4Va9LGiWpkjrpWKyLL2A+KHIZtwdbuHFb
 K+62abpqX6sK8JjqsaATuU47EFILYiNZUHHpzQVezHbx6aKTbcSOudXWdIORmEVEuUSo
 zJRW2qbSG27Z6rtB/eGuMn0jNf/VVvYnvUUP/oKxgzHx5ECbMFllxAnPrPGGl2GYD2j8
 qaJmuIVbOoS4YvWLaUYvLoBtozmXiNVvv+kTd+MqSLGDmzu3ZVO7zwH6DlRN6+nG33ll
 Xy/g==
X-Gm-Message-State: AOJu0YwSyloiHUlDUz9q962rg8Y9AFEtZXnWpLupRUudNII4N1WJOmLE
 J+VhkXVOadchj710iUNfq6k=
X-Google-Smtp-Source: AGHT+IHi3lGHKYbbu9nYtx+2Gee2Xr0r5jAZAFSjHX9idh6pzhZuIIzqgg8Up6ZfXjiY4dIGUVE3+w==
X-Received: by 2002:a17:906:7481:b0:99d:dce8:41d6 with SMTP id
 e1-20020a170906748100b0099ddce841d6mr7089556ejl.71.1692703369094; 
 Tue, 22 Aug 2023 04:22:49 -0700 (PDT)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 mh9-20020a170906eb8900b009934855d8f1sm8041456ejb.34.2023.08.22.04.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 04:22:48 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 10/19] ARM: dts: grouper: complete missing bindings
Date: Tue, 22 Aug 2023 14:22:08 +0300
Message-Id: <20230822112217.4646-11-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230822112217.4646-1-clamor95@gmail.com>
References: <20230822112217.4646-1-clamor95@gmail.com>
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

