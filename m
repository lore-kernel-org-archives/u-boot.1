Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46CE3C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 20:51:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A9EB88850;
	Thu, 25 Jul 2024 22:45:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CGR6jgde";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 518678863E; Thu, 25 Jul 2024 22:45:51 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7D7188403
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 22:45:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-70938328a0aso163572a34.1
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 13:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721940347; x=1722545147; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MRWZ3XISpHkNgfnMrf60r5EK2Iftgh+Qw3jGTgAaHvI=;
 b=CGR6jgdeu2OM8vbBwErBhmIrHKhiVU9m5aKgAj27uZrWdMpctVRR6crKlfPRZe8NU4
 /ih8H4CN6Zc3CG3+Nw21bXmevAc+OOYA2hPDhqUZA32hudUob+ZG4VJ4A6KlxOp6vETZ
 0ko9aAGNHH7UnUG4iwfajoRYZn3WIbRPlnNxQkV2JrGmCsvNhjWMuOazoOc6ejPDvNE3
 ad9MHSouz701R7mK28hGvdGlZ7/gCLFxgWxsplrlBjHjsW5aUaHj4qyslCSVpK+JD6ni
 abQAvf+++bd9rXPTV3LRgl95EtGM5txMjJEhnPeMIxjjvQWW3tkeyQGLZ/W0kY0ioDs2
 M4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721940347; x=1722545147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MRWZ3XISpHkNgfnMrf60r5EK2Iftgh+Qw3jGTgAaHvI=;
 b=oPvUEmi5xv4cnpjQClL8tD0VMWoBFdpx3Eh4RjgEggCd3Te91wA1AG/rGUZhHCZ0wa
 KxELvnqZYI25p39ndy39zkuZHDbfzoaY2s/2910jBpwmRpeEo3C/NsyCzwI1T+eJzIN6
 uUiURUu/0VGE6j56/VVJLTmy2gefvmw6V/PPZT/5acjxHxqNBqhOC8lmPtFom4lBapa+
 ZjUjPH3WdZGqHHUdi77f4sDpfI4L2KD8t9eLaKrg2DrIvXUU1TBow1NUbCSHKkQmcT4x
 Pliov+Q6OPYX5napx7F3WChnYxGSSJzXsHr3xyWquSbFb6H5A45EBVH6qihS6ZoMa0F8
 QBDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXj+9YCwlFNX8UeXxU5Kc93SUjbmrBVM8s+/l3G43bp3rBvCEiCYBaVlnhZjsQsHu7/miriV+JF0vwnXpi7gbIw+k7/NQ==
X-Gm-Message-State: AOJu0YzJY7McBdb4+GPOWsqzKU63+r2x6MGxqsWidAn06V/QPL3jNnuu
 18Tcfx24WhEWgHn/P85/A9w4w6ejYals6lgijTdjFfLEOy2Jx/WGjx4hoe22eHA=
X-Google-Smtp-Source: AGHT+IEjQzVl8RWMI9cPHxQMIU58dV5C+ylSdIQwDCi9recd47ukfPP/FCMiRtb0FzypcCblrHvIfQ==
X-Received: by 2002:a05:6830:d86:b0:709:396c:c455 with SMTP id
 46e09a7af769-709396cc7bdmr608798a34.24.1721940347644; 
 Thu, 25 Jul 2024 13:45:47 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70930778050sm445393a34.62.2024.07.25.13.45.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 13:45:47 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Minkyu Kang <mk7.kang@samsung.com>, Minkyu Kang <promsoft@gmail.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v4 36/38] arm: dts: exynos: Remove outdated DW MMC properties
 in all Exynos dts
Date: Thu, 25 Jul 2024 15:45:18 -0500
Message-Id: <20240725204520.18134-37-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240725204520.18134-1-semen.protsenko@linaro.org>
References: <20240725204520.18134-1-semen.protsenko@linaro.org>
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

