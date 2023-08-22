Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD15EE49A3
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 11:24:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB669864BB;
	Tue, 22 Aug 2023 13:22:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="slBi6oQN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D1CD86489; Tue, 22 Aug 2023 13:22:50 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B75B864AE
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 13:22:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-977e0fbd742so550898666b.2
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 04:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692703367; x=1693308167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yuQ4iWKY6sR5mEfnYSqXtkZWwArfdK8Y1eLh6Iceoas=;
 b=slBi6oQNBgZvf85yQ8crqWDXD2YZM5pfhv0uWcUtwkohVT3LinNZIjnQ+BdABDzEMK
 KtUSzEkmsTxLShBmXqw96SJZXWjz7q7GcCc6ecxZQIkbF36tcG2sCuRtUUywZmonmo1/
 xr86YYxdlpFxy6oZ2zH+SS2G8glf9qWGeKuARg/64YQc9TFLjE7IzzvWwfavWfEzSZS9
 TlMDYkV6S0kUjKl7JpO3aGK7v8hyuo4TnWedoeP+4vx19k7NWJ/7eoVyEA7DkQoKBY/A
 ALzLCJloZp/eBx242k6y0rQ9FmWwf3vXnCwe/99xSxF/TIpg2zYiCqfpoZY5a4ZOmBi+
 aO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692703367; x=1693308167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yuQ4iWKY6sR5mEfnYSqXtkZWwArfdK8Y1eLh6Iceoas=;
 b=ISLKJA9f1wJUWmytJ5+cacu1XUs5IRQvG8/diFh0uZWBk4/T0ijOFHT7O+YsemNMfZ
 8Fpk1ohZ/lGbJ45UYx79wBiJClyV4fKk+3YzRPTurfZ/nbdnLGNf7J10YyyZYv7yhz8s
 HVkPSSbNX/d4Tb3naHhrKLaeF1mUyap45mjx6ZBptSnR3bA+qdO7fm3CB2g/SXJVTn+4
 BMUV6bDlpOj9sWLZoiEj+J5Hl8CpMeMi9PesOk0jbMlslBlFi/ve3kRl/1nP8hfbppQH
 kYZy0YXnHF5wPWM+b8LSCjYcGjeYlgkHT2h4T+s8zGBvf+i1SM4sraLo6vxWxEREMEek
 nIYw==
X-Gm-Message-State: AOJu0YxrSnf9Nzw1mEpQt32nGiICzkbnxljiE44cz30246XnnMndZ/+C
 lnIi+TixfhtdXLHVYBoxFCWQFAroJsL9ow==
X-Google-Smtp-Source: AGHT+IHC88ksCg7xht2OCk1C7bCx+QrIP+x6msCn+zueBOnr/Pr4zieOzHUnlj+n0bvIw43J4TqHQw==
X-Received: by 2002:a17:906:51c9:b0:99d:ef0e:e95e with SMTP id
 v9-20020a17090651c900b0099def0ee95emr7184641ejk.13.1692703366988; 
 Tue, 22 Aug 2023 04:22:46 -0700 (PDT)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 mh9-20020a170906eb8900b009934855d8f1sm8041456ejb.34.2023.08.22.04.22.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 04:22:46 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 07/19] ARM: dts: transformer-t30: complete missing bindings
Date: Tue, 22 Aug 2023 14:22:05 +0300
Message-Id: <20230822112217.4646-8-clamor95@gmail.com>
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

