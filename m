Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C71C52D6F
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 03:20:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D62A088BEF;
	Thu,  8 Aug 2024 05:15:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NhuqZtoH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 778C788BB0; Thu,  8 Aug 2024 05:15:20 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBE8688C25
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 05:15:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3db1bc36bc2so260898b6e.0
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 20:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723086912; x=1723691712; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GMBO0TKnoGZ2Os/Na/4z8r9LiumA2hDLvzolhxblVXc=;
 b=NhuqZtoHtg6Wykql8tOrZaLavl5VhNaZ6lkH7EIz1clDUeJylLDFn4iXzbIe5M5bhe
 RjhBncOqxFEgdBuDEPUvOl0kKvaXkvq075ThzK1nHnNmR9sase8cU0CMkFJm8IOHKlCt
 U0yzxaDjm7RZIDn6/PLtAix4/eyHlC0ij4nYwv7KlkuKU+6t194fI5Gif9t2kdKfqiv7
 O5BHK1cdRjeGNEp3RQlAUtiM261hZmDlgM2z1tfG5LeihwI4MV3R/ngZWncpbD6bFUf1
 GnTEEd7JImPwnZTSUp5FFPwEV7cL9ucxPibyLy9TkLm0wRXZMWXTP5oOPG/9z96ivMKt
 2J/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723086912; x=1723691712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GMBO0TKnoGZ2Os/Na/4z8r9LiumA2hDLvzolhxblVXc=;
 b=OWWCXa8A+OgccUtGpGYveP8P8DvB1rkSBOaIxD3AMlYrDtuKvujbNpC5MuyxeQ4BgX
 OYXGKFCmz8+R5oLjjulmIXu/8DEsEc+xjIjd64TGlU/1vK7fLrEWqX+pFCLKQckw1EGc
 N3nxJKHsdPr/3Pb4UwQ+Nij9lgQW3erBZ+fFIRBRoXFUV31jX/QA2+Jb3g791J44eQSo
 ojijp4lYMnNrzpIMZP7hmLWDNoPmj3LbJRnh9LW9JBwd5wFUffiMyaQDcPvutS1otPBA
 rC1XrycjmILGCKtaIzXy04F1TVErtGO5qcLOGrI8Q8N+ybkySDbhuRMZ3Ree2wLi3tyJ
 X1PA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxU7rJleW/5JNZfYZg2G2GdvtKBFK64qtzsIbSUu1RmGjSXTKFUxtaptU7FccppgAYMBO9D0GywlvYWG48/NwCGqwNzw==
X-Gm-Message-State: AOJu0YwlME6yvzianiltrtXgmh4d3GXxQUdIhuBT0e8ImUux95fA0dpQ
 91zspdAi3a/TZ7AY4l8kdg6kLca7/Ljq6zwRzhX2+ScJ0UAJUMLFqUhhSfg4grE=
X-Google-Smtp-Source: AGHT+IEFBE6ImzXQQQDPU9enamN4X0HiGU1og19V8rAM3xAGb5LL2kevxAY9GlqqblLGg1gaaq9ORA==
X-Received: by 2002:a05:6808:13d6:b0:3d6:2bab:16ca with SMTP id
 5614622812f47-3dc3c184e05mr138478b6e.13.1723086911802; 
 Wed, 07 Aug 2024 20:15:11 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3db5627d8c4sm4562880b6e.0.2024.08.07.20.15.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 20:15:11 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <promsoft@gmail.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Tom Rini <trini@konsulko.com>, Henrik Grimler <henrik@grimler.se>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v5 36/38] arm: dts: exynos: Remove outdated DW MMC properties
 in all Exynos dts
Date: Wed,  7 Aug 2024 22:14:42 -0500
Message-Id: <20240808031444.9619-37-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240808031444.9619-1-semen.protsenko@linaro.org>
References: <20240808031444.9619-1-semen.protsenko@linaro.org>
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

Upstream properties were added to device trees to follow current Linux
kernel. DW MMC driver was updated accordingly. Safely remove outdated
MMC properties. Details on removed properties are as follows:

* samsung,removable: replaced by non-removable
* samsung,bus-width: replaced by bus-width
* samsung,timing:
  - replaced by samsung,dw-mshc-ciu-div and samsung,dw-mshc-sdr-timing
    in dw_mmc nodes
  - removed from sdhci nodes (it's neither described in bindings, nor
    it's used in s5p_sdhci.c driver)
* fifoth_val: replaced by fifo-depth
* bus_hz: replaced by clock-frequency
* div: the fixed CIU clock divider value was moved to the chip data in
  exynos_dw_mmc.c driver

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v5:
  - Rebased on top of changed patch 14/38

Changes in v4:
  - (none)

Changes in v3:
  - (none)

Changes in v2:
  - (none)

 arch/arm/dts/exynos4210-origen.dts         |  2 --
 arch/arm/dts/exynos4210-trats.dts          |  4 ----
 arch/arm/dts/exynos4210-universal_c210.dts |  4 ----
 arch/arm/dts/exynos4412-odroid.dts         |  8 --------
 arch/arm/dts/exynos4412-trats2.dts         | 12 ------------
 arch/arm/dts/exynos5250-arndale.dts        |  4 ----
 arch/arm/dts/exynos5250-smdk5250.dts       |  6 ------
 arch/arm/dts/exynos5250-snow.dts           |  6 ------
 arch/arm/dts/exynos5250-spring.dts         |  3 ---
 arch/arm/dts/exynos5420-smdk5420.dts       |  6 ------
 arch/arm/dts/exynos5422-odroidxu3.dts      |  2 --
 arch/arm/dts/exynos54xx.dtsi               |  6 ------
 12 files changed, 63 deletions(-)

diff --git a/arch/arm/dts/exynos4210-origen.dts b/arch/arm/dts/exynos4210-origen.dts
index a4915de2c49c..40289c8c4aaf 100644
--- a/arch/arm/dts/exynos4210-origen.dts
+++ b/arch/arm/dts/exynos4210-origen.dts
@@ -25,9 +25,7 @@
 };
 
 &sdhci2 {
-	samsung,bus-width = <4>;
 	bus-width = <4>;
-	samsung,timing = <1 2 3>;
 	cd-gpios = <&gpk2 2 0>;
 	status = "okay";
 };
diff --git a/arch/arm/dts/exynos4210-trats.dts b/arch/arm/dts/exynos4210-trats.dts
index 4fbdf4730994..88e9c0ed2bb0 100644
--- a/arch/arm/dts/exynos4210-trats.dts
+++ b/arch/arm/dts/exynos4210-trats.dts
@@ -240,17 +240,13 @@
 };
 
 &sdhci0 {
-	samsung,bus-width = <8>;
 	bus-width = <8>;
-	samsung,timing = <1 3 3>;
 	pwr-gpios = <&gpk0 2 0>;
 	status = "okay";
 };
 
 &sdhci2 {
-	samsung,bus-width = <4>;
 	bus-width = <4>;
-	samsung,timing = <1 2 3>;
 	cd-gpios = <&gpx3 4 0>;
 	status = "okay";
 };
diff --git a/arch/arm/dts/exynos4210-universal_c210.dts b/arch/arm/dts/exynos4210-universal_c210.dts
index 1b3ac1fee15f..c87b92be609d 100644
--- a/arch/arm/dts/exynos4210-universal_c210.dts
+++ b/arch/arm/dts/exynos4210-universal_c210.dts
@@ -235,17 +235,13 @@
 };
 
 &sdhci0 {
-	samsung,bus-width = <8>;
 	bus-width = <8>;
-	samsung,timing = <1 3 3>;
 	pwr-gpios = <&gpk0 2 0>;
 	status = "okay";
 };
 
 &sdhci2 {
-	samsung,bus-width = <4>;
 	bus-width = <4>;
-	samsung,timing = <1 2 3>;
 	cd-gpios = <&gpx3 4 0>;
 	status = "okay";
 };
diff --git a/arch/arm/dts/exynos4412-odroid.dts b/arch/arm/dts/exynos4412-odroid.dts
index a405b9708719..346e0f55c768 100644
--- a/arch/arm/dts/exynos4412-odroid.dts
+++ b/arch/arm/dts/exynos4412-odroid.dts
@@ -234,27 +234,19 @@
 };
 
 &sdhci2 {
-	samsung,bus-width = <4>;
 	bus-width = <4>;
-	samsung,timing = <1 2 3>;
 	cd-inverted;
 	cd-gpios = <&gpk2 2 0>;
 	status = "okay";
 };
 
 &mshc_0 {
-	samsung,bus-width = <8>;
 	bus-width = <8>;
-	samsung,timing = <2 1 0>;
 	samsung,dw-mshc-ciu-div = <0>;
 	samsung,dw-mshc-sdr-timing = <2 1>;
-	samsung,removable = <0>;
 	non-removable;
-	fifoth_val = <0x203f0040>;
 	fifo-depth = <0x80>;
 	clock-frequency = <400000000>;
-	bus_hz = <400000000>;
-	div = <0x3>;
 	index = <4>;
 	status = "okay";
 };
diff --git a/arch/arm/dts/exynos4412-trats2.dts b/arch/arm/dts/exynos4412-trats2.dts
index 30758ffa1ef9..2b71d328cd0e 100644
--- a/arch/arm/dts/exynos4412-trats2.dts
+++ b/arch/arm/dts/exynos4412-trats2.dts
@@ -108,9 +108,7 @@
 	};
 
 	sdhci@12510000 {
-		samsung,bus-width = <8>;
 		bus-width = <8>;
-		samsung,timing = <1 3 3>;
 		pwr-gpios = <&gpk0 4 0>;
 		status = "disabled";
 	};
@@ -432,33 +430,23 @@
 };
 
 &sdhci0 {
-	samsung,bus-width = <8>;
 	bus-width = <8>;
-	samsung,timing = <1 3 3>;
 	pwr-gpios = <&gpk0 4 0>;
 	status = "disabled";
 };
 
 &sdhci2 {
-	samsung,bus-width = <4>;
 	bus-width = <4>;
-	samsung,timing = <1 2 3>;
 	cd-gpios = <&gpk2 2 0>;
 	status = "okay";
 };
 
 &mshc_0 {
-	samsung,bus-width = <8>;
 	bus-width = <8>;
-	samsung,timing = <2 1 0>;
 	samsung,dw-mshc-ciu-div = <0>;
 	samsung,dw-mshc-sdr-timing = <2 1>;
-	samsung,removable = <0>;
 	non-removable;
-	fifoth_val = <0x203f0040>;
 	clock-frequency = <400000000>;
-	bus_hz = <400000000>;
-	div = <0x3>;
 	index = <4>;
 	fifo-depth = <0x80>;
 	status = "okay";
diff --git a/arch/arm/dts/exynos5250-arndale.dts b/arch/arm/dts/exynos5250-arndale.dts
index 7f84589c97a2..4c894f1712fa 100644
--- a/arch/arm/dts/exynos5250-arndale.dts
+++ b/arch/arm/dts/exynos5250-arndale.dts
@@ -27,9 +27,7 @@
 	};
 
 	mmc@12200000 {
-		samsung,bus-width = <8>;
 		bus-width = <8>;
-		samsung,timing = <1 3 3>;
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <1 3>;
 	};
@@ -39,9 +37,7 @@
 	};
 
 	mmc@12220000 {
-		samsung,bus-width = <4>;
 		bus-width = <4>;
-		samsung,timing = <1 2 3>;
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <1 2>;
 	};
diff --git a/arch/arm/dts/exynos5250-smdk5250.dts b/arch/arm/dts/exynos5250-smdk5250.dts
index 882db2d1f608..f9f54cb63871 100644
--- a/arch/arm/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/dts/exynos5250-smdk5250.dts
@@ -145,12 +145,9 @@
 	};
 
 	mmc@12200000 {
-		samsung,bus-width = <8>;
 		bus-width = <8>;
-		samsung,timing = <1 3 3>;
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <1 3>;
-		samsung,removable = <0>;
 		non-removable;
 	};
 
@@ -159,12 +156,9 @@
 	};
 
 	mmc@12220000 {
-		samsung,bus-width = <4>;
 		bus-width = <4>;
-		samsung,timing = <1 2 3>;
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <1 2>;
-		samsung,removable = <1>;
 	};
 
 	mmc@12230000 {
diff --git a/arch/arm/dts/exynos5250-snow.dts b/arch/arm/dts/exynos5250-snow.dts
index bcf04d5c07c0..ab7b5212ba7c 100644
--- a/arch/arm/dts/exynos5250-snow.dts
+++ b/arch/arm/dts/exynos5250-snow.dts
@@ -301,12 +301,9 @@
 	};
 
 	mmc@12200000 {
-		samsung,bus-width = <8>;
 		bus-width = <8>;
-		samsung,timing = <1 3 3>;
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <1 3>;
-		samsung,removable = <0>;
 		non-removable;
 	};
 
@@ -315,12 +312,9 @@
 	};
 
 	mmc@12220000 {
-		samsung,bus-width = <4>;
 		bus-width = <4>;
-		samsung,timing = <1 2 3>;
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <1 2>;
-		samsung,removable = <1>;
 	};
 
 	mmc@12230000 {
diff --git a/arch/arm/dts/exynos5250-spring.dts b/arch/arm/dts/exynos5250-spring.dts
index 7270a546a795..9c478837ba44 100644
--- a/arch/arm/dts/exynos5250-spring.dts
+++ b/arch/arm/dts/exynos5250-spring.dts
@@ -103,12 +103,9 @@
 	};
 
 	mmc@12200000 {
-		samsung,bus-width = <8>;
 		bus-width = <8>;
-		samsung,timing = <1 3 3>;
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <1 3>;
-		samsung,removable = <0>;
 		non-removable;
 	};
 
diff --git a/arch/arm/dts/exynos5420-smdk5420.dts b/arch/arm/dts/exynos5420-smdk5420.dts
index 1f27baafebaf..6ba1306e862a 100644
--- a/arch/arm/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/dts/exynos5420-smdk5420.dts
@@ -106,12 +106,9 @@
 	};
 
 	mmc@12200000 {
-		samsung,bus-width = <8>;
 		bus-width = <8>;
-		samsung,timing = <1 3 3>;
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <1 3>;
-		samsung,removable = <0>;
 		non-removable;
 		samsung,pre-init;
 	};
@@ -121,12 +118,9 @@
 	};
 
 	mmc@12220000 {
-		samsung,bus-width = <4>;
 		bus-width = <4>;
-		samsung,timing = <1 2 3>;
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <1 2>;
-		samsung,removable = <1>;
 	};
 
 	mmc@12230000 {
diff --git a/arch/arm/dts/exynos5422-odroidxu3.dts b/arch/arm/dts/exynos5422-odroidxu3.dts
index 767b3e415d58..ef25cf774470 100644
--- a/arch/arm/dts/exynos5422-odroidxu3.dts
+++ b/arch/arm/dts/exynos5422-odroidxu3.dts
@@ -280,12 +280,10 @@
 	};
 
 	mmc@12200000 {
-		fifoth_val = <0x201f0020>;
 		fifo-depth = <0x40>;
 	};
 
 	mmc@12220000 {
-		fifoth_val = <0x201f0020>;
 		fifo-depth = <0x40>;
 	};
 
diff --git a/arch/arm/dts/exynos54xx.dtsi b/arch/arm/dts/exynos54xx.dtsi
index fd74166c7e48..5915ed697791 100644
--- a/arch/arm/dts/exynos54xx.dtsi
+++ b/arch/arm/dts/exynos54xx.dtsi
@@ -119,12 +119,9 @@
 	};
 
 	mmc@12200000 {
-		samsung,bus-width = <8>;
 		bus-width = <8>;
-		samsung,timing = <1 3 3>;
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <1 3>;
-		samsung,removable = <0>;
 		non-removable;
 		samsung,pre-init;
 	};
@@ -134,12 +131,9 @@
 	};
 
 	mmc@12220000 {
-		samsung,bus-width = <4>;
 		bus-width = <4>;
-		samsung,timing = <1 2 3>;
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <1 2>;
-		samsung,removable = <1>;
 	};
 
 	mmc@12230000 {
-- 
2.39.2

