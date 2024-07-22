Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB9AC3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 18:03:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ECCC887D7;
	Mon, 22 Jul 2024 19:58:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wSQlF/k4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4090B88722; Mon, 22 Jul 2024 19:58:11 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E568388644
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 19:58:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7037c464792so2580940a34.2
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 10:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721671088; x=1722275888; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ad7GdUK8rf43qjd052nPBd+Af34mQ2N6SsTFgPP0XNE=;
 b=wSQlF/k4KilRApu9+izO4iP5Ruocx8mgFVpajCDkIyvamQiAuXQqmCWwXaCz8DtaJM
 AuCuuphnOGmPnKpnx5wicOF/hN/jwhXoxHtltUikNcfAoKaYfubJ3z90Yu8JQP6VVSAq
 2MU+2rzLyie8NICebEDn6Sd8FQ5kImlGO1HOeCINeLpC4gYb6gDwKlRnZhP3shP0rbMY
 IcAAc+v6IgqWCzrP7Na+IhiZz+HiEgJkJ68dy+NUoPYLmG1/7XjEkAN4AE9lj463eXi/
 CfYab82QAfNVdwedngK9MnyInm9pAcmcUhXHkUjbTm4IOENrAmrxI4aOEqtzSR2GSY+I
 0LxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721671088; x=1722275888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ad7GdUK8rf43qjd052nPBd+Af34mQ2N6SsTFgPP0XNE=;
 b=OyCbiVGm8IpE+vZxsHcEaHAp0bzDbdNbt5JX1eWiZG7SeW+rztFD2WpKeEUnlAgVmY
 ped2wXsRPRRsDejwAiuPBwYW7pPb3sleLSG3W+ONoy36HoOYUOaniHmyWgV7p+ucLfNk
 byGtT/L5CHSzR5GiyocQthSpLoT2gTtC8QSUOauNbrI8WkH6Akwa+qWTNkG0B5Rg8Xcj
 tUiUnwwR8E/DDlmw2ElTBaX+2z/3b3IvB7TbOR1NJnCIBQUUyxocSdtuJfi4vFD/4/E/
 /9EbUEOwlkqomrJfQNsl6m+dkX2T11/i2jQ33iRtZL8vLeP6bGqy+pM/wgQa5gLfA954
 djSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5fKQ/GKemqnHDs3QMfLeP+K5E87J2tGOQ2p0leK5DLkg18JrrU7J9p7qlHUBeNwrUZQvlmziYvMs07waVyhi+KcnW/g==
X-Gm-Message-State: AOJu0YzZzZah6xAqtERx0pzx8wrtl7JyAf2QZP6RsU6+X3YZEteTJcQB
 sMzOoPX2nDvK8NAAzgDrnTsFJC5QOZNjnZ51bYv8hGNAR4SwhcxzrXKbnbkeTI4=
X-Google-Smtp-Source: AGHT+IF0bBjR3VOkgeRT4ldct+CDgK7/guWt4Fb989shmAJqtxk09eMlnLgf5wFW8q1q/lABQkyNaw==
X-Received: by 2002:a05:6830:2a05:b0:702:1ea0:cfbb with SMTP id
 46e09a7af769-708fdb44267mr12159718a34.18.1721671087605; 
 Mon, 22 Jul 2024 10:58:07 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708f6189ca7sm1633927a34.72.2024.07.22.10.58.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 10:58:07 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>,
	Minkyu Kang <promsoft@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v3 36/38] arm: dts: exynos: Remove outdated DW MMC properties
 in all Exynos dts
Date: Mon, 22 Jul 2024 12:57:38 -0500
Message-Id: <20240722175740.6985-37-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240722175740.6985-1-semen.protsenko@linaro.org>
References: <20240722175740.6985-1-semen.protsenko@linaro.org>
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
index 24e96ed05868..6822c6aaaa8a 100644
--- a/arch/arm/dts/exynos4412-odroid.dts
+++ b/arch/arm/dts/exynos4412-odroid.dts
@@ -234,26 +234,18 @@
 };
 
 &sdhci2 {
-	samsung,bus-width = <4>;
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

