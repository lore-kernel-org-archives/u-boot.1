Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF20C71151
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 14:01:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F64982CB6;
	Fri, 13 Jun 2025 15:59:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oYG3aqBX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7E7D82C30; Fri, 13 Jun 2025 15:22:09 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF97482D09
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 15:22:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-adb47e0644dso366708566b.0
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 06:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749820927; x=1750425727;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5MAUVhCcccyeexn5wDcB5CniN7Qs6gHgM1j1HP4j09s=;
 b=oYG3aqBXf5gR/WJKZS0YaDCi3opjuIvhSf9Aln8U4kediSL6vkqskyK8l7W7NZ9uLA
 uDwaZrmGd3VLO2TvPxaU6y4trUczVlMrHkeB8SucVzbwQO8T70o7Ty1P70ijUOoRqnEf
 zBJf09TflN4i8URF2cL6Rov60jV7Qdfjui2P9WAThyQRPqNEn8co+Tf8or2PEcvnL73Y
 wcGVX5uAeU3CLzIPIIL1bVQHA6Jn6XqL/uTer0A9DHRzbJTg+tHT9NPl1VwnCUCYD+yq
 4SgkcPAmbqi0k7T+jUFjsrlwXTRZIMScIytRgt4fMWBqukU326VfDbi23kidkDwW5Lkl
 7X4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749820927; x=1750425727;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5MAUVhCcccyeexn5wDcB5CniN7Qs6gHgM1j1HP4j09s=;
 b=ArjTP2CpEOcPlM6QQ7LATfCgMz6F73moirQpfJdNHKuW2+VuVYAvlcOSZYJfbqw5ZF
 4OCu+aZr4xbLlwEWWxOzJnaEbdFsqPxME2pIkEBHU7BYMUYbmrEqwW9Ji1aBGb63MGci
 GKor9Ue2oLT7jGG7e2lw1qR+3jXubH+ch5kCgxphPVolyGCc33UfG3yx9JIxzphjAgi/
 aHr/1/mr2QEHjpXQLPWdf/h+lstujRUFeazUzaiOyENqV8bTsAh/dbmq84GXU1SBkWHV
 CCZSolidqYfkRlIvEQRimpkGtgirTNU5ZC2TrOGSRjEMPlIgfg6V6X2oKvyqA7mPpuyh
 tLoQ==
X-Gm-Message-State: AOJu0YxKpN5jnzPzH65oWts8d2hn7qsvjU2IZ2SMFIPcW9SmB/zJlQ2D
 pQsbmtl3sauRMesnRS74WF6vZp3PKrzDXV9ek0KHeUg3W8+6ms2hDiGs4RYF27a01SjinSUmN3p
 mACYy
X-Gm-Gg: ASbGnctRMKDSNZ2Jy/WRqry1gAqE0Lgp6pDDvTvZm82zOMwlLO++QRKI9IA9IwBlX5S
 jH7dAZZClyEHyJtEg2PLJPzYg+vd+Mz56NVM/AiRqzyzeQos4h2+xke/bTU4g/9+fWak6Spq/V4
 Ult8NuzT1D7B5SALzSWzMbgDkEO5/3tE/31WZSEMoL3/MXASAJMMvbBipreIBclhQd5UuabTAxq
 1+qHSGzfYQGVzzrM42lF2DtJlOUVU63d/cZHj5TmTJjijEfLmAXl0NfF7NOxlYt1lO2SXooayVw
 E2jQH3dpNULKxo35YTXxDAK7gbTtD3/EyTIf/vAHsBY6zN5m9ijDnyPocJQ=
X-Google-Smtp-Source: AGHT+IEq54zOhnQVEoFLso3qnPhnFrgNnuDpLYMcf63BKLkV+0VJjt9an/yzDy6Rd06VBaOseXCWKg==
X-Received: by 2002:a17:907:3d45:b0:ad8:89c2:423f with SMTP id
 a640c23a62f3a-adf4c73201amr77944866b.7.1749820927036; 
 Fri, 13 Jun 2025 06:22:07 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83c4:9fe4:a128:a20c:8b84])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-adec820da06sm128146966b.70.2025.06.13.06.22.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 06:22:06 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Fri, 13 Jun 2025 15:19:32 +0200
Subject: [PATCH v2 12/22] arm64: dts: ti: k3-am6*: Remove disable-wp for eMMC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-12-3d233aaea355@baylibre.com>
References: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-0-3d233aaea355@baylibre.com>
In-Reply-To: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-0-3d233aaea355@baylibre.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Robert Nelson <robertcnelson@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de, Kevin Hilman <khilman@baylibre.com>, 
 Vishal Mahaveer <vishalm@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Dhruva Gole <d-gole@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5989; i=msp@baylibre.com;
 h=from:subject:message-id; bh=/RTrYs1D/0jD2IrT4IoPsyCOayOUKLMnCNgJRz6DjIk=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhgwf1R0+Z2YsW/Ei/uhEEwe5zvnFm85cn3d5plqm5pviR
 3LWO/r7O0pZGMS4GGTFFFk6E0PT/svvPJa8aNlmmDmsTCBDGLg4BWAiRu0M/+znTQ4Vnfu786D3
 /idbv+8VkDKx0bPLOPKg2tec1cbtRBPD//S8f6ynL/AwbJsUuOcIL4dXV6XFRMMvJ2ImpES8j0k
 V4wEA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Fri, 13 Jun 2025 15:59:32 +0200
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

From: Judith Mendez <jm@ti.com>

Remove disable-wp flag for eMMC nodes since this flag is
only applicable to SD according to the binding doc
(mmc/mmc-controller-common.yaml).

For eMMC, this flag should be ignored but lets remove
anyways to cleanup sdhci nodes.

Signed-off-by: Judith Mendez <jm@ti.com>
Reviewed-by: Moteen Shah <m-shah@ti.com>
Link: https://lore.kernel.org/r/20250429151454.4160506-4-jm@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>

[ upstream commit: ef839ba8142f14513ba396a033110526b7008096 ]

(cherry picked from commit 9bd6216a75f9f2be497b6f66fcfcbd75b685e92a)
---
 dts/upstream/src/arm64/ti/k3-am62-phycore-som.dtsi               | 1 -
 dts/upstream/src/arm64/ti/k3-am625-beagleplay.dts                | 1 -
 dts/upstream/src/arm64/ti/k3-am62a-phycore-som.dtsi              | 1 -
 dts/upstream/src/arm64/ti/k3-am62a7-sk.dts                       | 1 -
 dts/upstream/src/arm64/ti/k3-am62p5-sk.dts                       | 1 -
 dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi                | 1 -
 dts/upstream/src/arm64/ti/k3-am642-evm.dts                       | 1 -
 dts/upstream/src/arm64/ti/k3-am654-base-board.dts                | 1 -
 dts/upstream/src/arm64/ti/k3-am6548-iot2050-advanced-common.dtsi | 1 -
 dts/upstream/src/arm64/ti/k3-am69-sk.dts                         | 1 -
 10 files changed, 10 deletions(-)

diff --git a/dts/upstream/src/arm64/ti/k3-am62-phycore-som.dtsi b/dts/upstream/src/arm64/ti/k3-am62-phycore-som.dtsi
index 55ed418c023bc1f03a04514d12a0950ee9f498bb..e5be92aa121891d167a0e29713aca3434f32657c 100644
--- a/dts/upstream/src/arm64/ti/k3-am62-phycore-som.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-am62-phycore-som.dtsi
@@ -381,7 +381,6 @@
 &sdhci0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mmc0_pins_default>;
-	disable-wp;
 	non-removable;
 	bootph-all;
 	status = "okay";
diff --git a/dts/upstream/src/arm64/ti/k3-am625-beagleplay.dts b/dts/upstream/src/arm64/ti/k3-am625-beagleplay.dts
index a5469f2712f0945d5717d9570767fedf2681013a..91c50ff8d5d0c2d188d68e8ccaeaf256a150b7ae 100644
--- a/dts/upstream/src/arm64/ti/k3-am625-beagleplay.dts
+++ b/dts/upstream/src/arm64/ti/k3-am625-beagleplay.dts
@@ -834,7 +834,6 @@
 	bootph-all;
 	pinctrl-names = "default";
 	pinctrl-0 = <&emmc_pins_default>;
-	disable-wp;
 	status = "okay";
 };
 
diff --git a/dts/upstream/src/arm64/ti/k3-am62a-phycore-som.dtsi b/dts/upstream/src/arm64/ti/k3-am62a-phycore-som.dtsi
index 147d56b879843ec832d0849e6ed877aa83a72229..0d4115590b9c3d2f92140521e99a6ff8440e398f 100644
--- a/dts/upstream/src/arm64/ti/k3-am62a-phycore-som.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-am62a-phycore-som.dtsi
@@ -338,7 +338,6 @@
 &sdhci0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mmc0_pins_default>;
-	disable-wp;
 	non-removable;
 	bootph-all;
 	status = "okay";
diff --git a/dts/upstream/src/arm64/ti/k3-am62a7-sk.dts b/dts/upstream/src/arm64/ti/k3-am62a7-sk.dts
index 22be41d46eb519917516fba5f2439bdb492c46f4..c65ada5a22abbd88a70e81703c28b7b83461c6c8 100644
--- a/dts/upstream/src/arm64/ti/k3-am62a7-sk.dts
+++ b/dts/upstream/src/arm64/ti/k3-am62a7-sk.dts
@@ -634,7 +634,6 @@
 	non-removable;
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mmc0_pins_default>;
-	disable-wp;
 	bootph-all;
 };
 
diff --git a/dts/upstream/src/arm64/ti/k3-am62p5-sk.dts b/dts/upstream/src/arm64/ti/k3-am62p5-sk.dts
index d29f524600af017af607e2cb6122d3a581575ffc..7cc730e27ce69dc30feb97d68c9cec88b553a4bd 100644
--- a/dts/upstream/src/arm64/ti/k3-am62p5-sk.dts
+++ b/dts/upstream/src/arm64/ti/k3-am62p5-sk.dts
@@ -455,7 +455,6 @@
 &sdhci0 {
 	status = "okay";
 	ti,driver-strength-ohm = <50>;
-	disable-wp;
 	bootph-all;
 };
 
diff --git a/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi b/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi
index d52cb2a5a589a8e5eb325fd90324d57ec1e3783b..17f97434b91ae8c9e46da872e0a08a60ec4fbc0c 100644
--- a/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi
@@ -436,7 +436,6 @@
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mmc0_pins_default>;
-	disable-wp;
 };
 
 &sdhci1 {
diff --git a/dts/upstream/src/arm64/ti/k3-am642-evm.dts b/dts/upstream/src/arm64/ti/k3-am642-evm.dts
index f8ec40523254ba1ee9b0bec7c00541dceef25526..5c6197ba842e4e1c604d3063d25b7f99c274057f 100644
--- a/dts/upstream/src/arm64/ti/k3-am642-evm.dts
+++ b/dts/upstream/src/arm64/ti/k3-am642-evm.dts
@@ -597,7 +597,6 @@
 	status = "okay";
 	non-removable;
 	ti,driver-strength-ohm = <50>;
-	disable-wp;
 	bootph-all;
 };
 
diff --git a/dts/upstream/src/arm64/ti/k3-am654-base-board.dts b/dts/upstream/src/arm64/ti/k3-am654-base-board.dts
index aa7139cc8a92b44fe94b556d392038edf6e9f35e..c30425960398ebb75ebda44726ed90cd78947d58 100644
--- a/dts/upstream/src/arm64/ti/k3-am654-base-board.dts
+++ b/dts/upstream/src/arm64/ti/k3-am654-base-board.dts
@@ -456,7 +456,6 @@
 	bus-width = <8>;
 	non-removable;
 	ti,driver-strength-ohm = <50>;
-	disable-wp;
 };
 
 /*
diff --git a/dts/upstream/src/arm64/ti/k3-am6548-iot2050-advanced-common.dtsi b/dts/upstream/src/arm64/ti/k3-am6548-iot2050-advanced-common.dtsi
index ae842b85b70de0b0524e9429f4e1c338c5425d40..12af6cb7f65cfb5045e756080f3970971101f18e 100644
--- a/dts/upstream/src/arm64/ti/k3-am6548-iot2050-advanced-common.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-am6548-iot2050-advanced-common.dtsi
@@ -50,5 +50,4 @@
 	bus-width = <8>;
 	non-removable;
 	ti,driver-strength-ohm = <50>;
-	disable-wp;
 };
diff --git a/dts/upstream/src/arm64/ti/k3-am69-sk.dts b/dts/upstream/src/arm64/ti/k3-am69-sk.dts
index b85227052f97eab2ac22e95d30ec3f6bfde85c0d..f28375629739cbb76567a805d9655a1cd19d4d83 100644
--- a/dts/upstream/src/arm64/ti/k3-am69-sk.dts
+++ b/dts/upstream/src/arm64/ti/k3-am69-sk.dts
@@ -940,7 +940,6 @@
 	status = "okay";
 	non-removable;
 	ti,driver-strength-ohm = <50>;
-	disable-wp;
 };
 
 &main_sdhci1 {

-- 
2.49.0

