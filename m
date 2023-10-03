Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F36EE7542B
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 06:38:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A9C6872AD;
	Tue,  3 Oct 2023 08:37:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h2o3oc/f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCB158720E; Tue,  3 Oct 2023 08:37:03 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D32388720E
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 08:37:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5044dd5b561so605166e87.1
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 23:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696315021; x=1696919821; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yuQ4iWKY6sR5mEfnYSqXtkZWwArfdK8Y1eLh6Iceoas=;
 b=h2o3oc/fGs75hobnfEAzd2J3p1dpeZ6VCyhYHj8rDsgkwqTjodVT2xXBgAmH3JjEOI
 f7a6zE12O9KFd2pmLaidWdXaJ6vc3TvDgtgDf8xPvs3bFPPQuGntK4gLSeoAyNsgQjXf
 7Epxesil8qFPGptf2Lk2Vi9Z2WZurHR1z4SBydcZp107p3z/uN5RK9iZ6jb/t2suw5dD
 MoRWXYJN+hyvC5NQfbKMrTEbnLGtT2MTESWuJh57mjZ8GMphoZuEYDMD64ZGzRfnZIfV
 74iNliiXQkli5v355ElCysDcn3W4lfepcIJNm582eoUA813wReOwtQhulUGGYz0ePAj/
 lMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696315021; x=1696919821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yuQ4iWKY6sR5mEfnYSqXtkZWwArfdK8Y1eLh6Iceoas=;
 b=TL6N2a5awvRkD9g02IvsxZDsIhIkcN9iZUiY+VPwluXczwCaV35JLFXNxMdM9cTdVQ
 ++69BDpFge3JfjChoR3k7zrlv7nbYJIiguq9Jxbp/NUlt7JxFHqL3Uow3JaiGZlnHNpG
 X0T6eWKoA6ojdyNGD+KKTSXdDkZK9S+mS9pgigT+9luTHJtlhqAbQ8MnWeKX743s+BYZ
 WW3VZPwAia9KPiaNTggKU763LoJpBL1i1+Z2hAYxgltvvJzW3ssLtiJ/sJbewJWwpXS4
 wONTqDZ4wxoD0M9bUYHxJ0zY9+UDU4CPC8UwmYQc1z5fceExswfF0r8hmjO2QhHkHz30
 7Hhw==
X-Gm-Message-State: AOJu0Yw0uv+0aH2A4xju+kYLL4Y2AO8Pt96iLZHuW7YIkvaCBiqbec28
 HkFWhzftglicXlRd8ZbbwFs=
X-Google-Smtp-Source: AGHT+IHppNJR+/MszJ8qfu/X53pTYyrEvevcndgQQwTzfetUAFRdoJaGJBg6/Fp8Jfn11i3EsN2agA==
X-Received: by 2002:a19:e047:0:b0:4fd:d18f:2d93 with SMTP id
 g7-20020a19e047000000b004fdd18f2d93mr8855107lfj.6.1696315021061; 
 Mon, 02 Oct 2023 23:37:01 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 s1-20020a19ad41000000b00502b04e2722sm79636lfd.3.2023.10.02.23.37.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 23:37:00 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 07/16] ARM: dts: transformer-t30: complete missing bindings
Date: Tue,  3 Oct 2023 09:36:38 +0300
Message-Id: <20231003063647.42770-8-clamor95@gmail.com>
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

