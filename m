Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA8EE75428
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 06:38:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 948458746E;
	Tue,  3 Oct 2023 08:37:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Im33jabZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ABE187456; Tue,  3 Oct 2023 08:37:10 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 225A98743C
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 08:37:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5046bf37ec1so643140e87.1
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 23:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696315023; x=1696919823; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mSSqpiiTKFMhLmIKSJQ2JBruJbcK3t9XTWfTF9IzDzk=;
 b=Im33jabZnuz7Sdw2gdkHEHcVCAY4MFKA2PRyIIc2l81SR/Ukc0INXGR8YrPjUPlcqv
 OBCHo0lMP7t5Uvk5/FbdvbP+oW+DHO3dvacXdnGT8gcxaShG3SBQ2wqBK0jHCuSWKYol
 98nZqI9hPGZjHcJI651M8cF6QENB1Kdxh8Xo3t+e6/Gaa+xuWaaE/HX48qBiG62bQNhL
 /wJsZe3nzGmYKLCRlOYZzkCWzGqejtX8TfUOPdXOi1hYM9GugEmSux+zqCllc6DwPaVg
 X5kvit/+bNhz9BUN/JHZhijHeeiqf0d7lSfcz6E+KzCUPyl8VpikKj+lDwQmJc2zxgdC
 o3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696315023; x=1696919823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mSSqpiiTKFMhLmIKSJQ2JBruJbcK3t9XTWfTF9IzDzk=;
 b=KCwWQLEtCDb7+lFvs9A5iiJKTX8CmZ5VlOvk9tIMUH/lCvvfosDA4h42SHCE3NK2Ko
 mx3QS5/JzDVl1aEZV+f19BXlvTskfkGGboT7dVU8sopNTrJ9170Z6bTLh/zGJYnpSFsG
 qGmZd8FL9afED154kqLOSoeoPX5f78n7b/IgfD1rvJvxucBqrD5bT5qflGMytbuxirF4
 ew2bU5ZOxvsjY9/RqmdMrBjUBBJD/kLU3Fb/9QVEjOyAHmMVj3o/oO37A5lECtWCKOSs
 4DorOaKR/rsLQnU225z9N657Q9WJdGxcU2qa1Tvhx0+c5Zxjjoq+fG4BYXkY1KdRMQEx
 QRTA==
X-Gm-Message-State: AOJu0Yw06887DvkgoRx5/QVik4VpSYvgrFL1V7ofkrabisk95FCPSoc1
 8dkAnu+Wfe1I70riMuBJzeo=
X-Google-Smtp-Source: AGHT+IFnojsVSeYuL7j8rSkqEQQIxc9WKgCySi3eY1Hy35oigki7bPswjRylpLvqcFTc0Uft1FijuQ==
X-Received: by 2002:a05:6512:3147:b0:502:fd1a:9fa0 with SMTP id
 s7-20020a056512314700b00502fd1a9fa0mr9692405lfi.53.1696315023401; 
 Mon, 02 Oct 2023 23:37:03 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 s1-20020a19ad41000000b00502b04e2722sm79636lfd.3.2023.10.02.23.37.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 23:37:03 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 10/16] ARM: dts: grouper: complete missing bindings
Date: Tue,  3 Oct 2023 09:36:41 +0300
Message-Id: <20231003063647.42770-11-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003063647.42770-1-clamor95@gmail.com>
References: <20231003063647.42770-1-clamor95@gmail.com>
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

