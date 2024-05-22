Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D0FC25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 23:34:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 242E988591;
	Thu, 23 May 2024 01:32:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pflm1lRG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE39B88511; Thu, 23 May 2024 01:31:56 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA1E2884EF
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 01:31:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6f662252c7eso793063a34.3
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716420709; x=1717025509; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m9D3lerFK752PlADc+6gNEau9V4hSr3EplD1k2lukUI=;
 b=pflm1lRGpdRpipZcnCkKBlNfS0Fuz0ffHAX1SJpEmR7yr5jIfrw0vF0VuLKjkT91sx
 P4w6xKC3CSz3H3eCbPt9JJj8sgZNOcly1M4dDfNpwTcICcEn2DmPuvvVug4Zd0uUFZ3s
 FnWWP1IoRMhlqY0vXGA0TF6mN1OwSU4wuTA9Ww0CfRk+uWgDqAlKeRna3MqP5YuYOjvW
 EHb/md/PfoPQSMb800r8dIqV4bLcPsLMjGSzZ18RHBKZZU943vhGBDw5NCi21mOth9wM
 IeUZi5El1rgZzl5ORkzXDp/owikAuaG/qzmuHLuU1XZnIA+a3988N2wVxIov8vch63UF
 djUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716420709; x=1717025509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m9D3lerFK752PlADc+6gNEau9V4hSr3EplD1k2lukUI=;
 b=ATTkva4Je159oiPNwnAJDubOc2GEq6p5ufG4+qHTs4AzGCn/o6pAlo0EufiwddaJV9
 mSQojAM97PtO+2vTHNE/VD5fM8CM0YNne2yKJ3+0myy3uEGG68CHhYJQGuMnJaL36H9s
 +p+wxc2W611BlTxlS+0Js65NdfsmXagy8EtsfYuN27pEJ7cKmCDC+IRksmmWm8pyFOMi
 meqDdy821wVt4GudvYIbuq0sK0NrEg+zIAFQO0YAkOUNejytZcgmznNzjT4MWAnBjGyt
 Nm/XfO2lbIBREiUPltMO8BDuFulys8cKdsJGQWzOqH54uiTC2KuiDRCoftl0jpsNnz2v
 vqcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVS8wuNasrepJbiSbyBCozDGaE6CFds12VqHTRIZLfF6lWs6MTnauN3Ek/7EOdcMBpliTCZsGEMeRBGzj1pA7l1ZobcDg==
X-Gm-Message-State: AOJu0YyTbTWQNLqnOWtY23OZYJMUSbVpOq7KmPPU4taOgHx/WC2t/ZCb
 XvofIf2QUUROTo63TxizbgLxvW3GxptB0LblVQ9M3np/SYj/GUPD8Z/BFLTpLvs=
X-Google-Smtp-Source: AGHT+IFwIfunW+3VMT0la/XiPy1Qjpr8waMn2VfaN3vZfWmgPLKPg6tm4p8Xe5dk276YiyLL1Uua7Q==
X-Received: by 2002:a9d:6a48:0:b0:6f1:2341:348b with SMTP id
 46e09a7af769-6f665c26a0fmr4068584a34.3.1716420709424; 
 Wed, 22 May 2024 16:31:49 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f1281e33a8sm2931294a34.68.2024.05.22.16.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 16:31:48 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH 16/42] arm: dts: exynos: Add upstream DW MMC properties to all
 Exynos dts
Date: Wed, 22 May 2024 18:31:09 -0500
Message-Id: <20240522233135.26835-17-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240522233135.26835-1-semen.protsenko@linaro.org>
References: <20240522233135.26835-1-semen.protsenko@linaro.org>
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

Some device tree properties for DW MMC block were updated in Linux
kernel. Let's follow its example and rework corresponding properties in
all Exynos device trees. Don't remove outdated properties yet, it'll be
done later once DW MMC driver is updated accordingly to read the updated
properties instead of outdated ones.

Next properties are added:

* samsung,dw-mshc-ciu-div and samsung,dw-mshc-sdr-timing:

  They were derived from outdated samsung,timing property.

* fifo-depth (generic replacement for fifoth_val):

  FIFO depth was calculated from fifoth_val (using expressions from
  FIFOTH register description in TRM):

      fifo-depth = ((fifoth_val >> 16) + 1) * 2

* bus-width: generic replacement for samsung,bus-width
* clock-frequency: generic replacement for bus_hz
* non-removable: generic replacement for samsung,removable = <0>

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 arch/arm/dts/exynos4210-origen.dts         | 1 +
 arch/arm/dts/exynos4210-trats.dts          | 2 ++
 arch/arm/dts/exynos4210-universal_c210.dts | 2 ++
 arch/arm/dts/exynos4412-odroid.dts         | 6 ++++++
 arch/arm/dts/exynos4412-trats2.dts         | 8 ++++++++
 arch/arm/dts/exynos5250-arndale.dts        | 6 ++++++
 arch/arm/dts/exynos5250-smdk5250.dts       | 7 +++++++
 arch/arm/dts/exynos5250-snow.dts           | 7 +++++++
 arch/arm/dts/exynos5250-spring.dts         | 4 ++++
 arch/arm/dts/exynos5420-smdk5420.dts       | 7 +++++++
 arch/arm/dts/exynos5422-odroidxu3.dts      | 2 ++
 arch/arm/dts/exynos54xx.dtsi               | 7 +++++++
 12 files changed, 59 insertions(+)

diff --git a/arch/arm/dts/exynos4210-origen.dts b/arch/arm/dts/exynos4210-origen.dts
index 65a5fcd67eff..a4915de2c49c 100644
--- a/arch/arm/dts/exynos4210-origen.dts
+++ b/arch/arm/dts/exynos4210-origen.dts
@@ -26,6 +26,7 @@
 
 &sdhci2 {
 	samsung,bus-width = <4>;
+	bus-width = <4>;
 	samsung,timing = <1 2 3>;
 	cd-gpios = <&gpk2 2 0>;
 	status = "okay";
diff --git a/arch/arm/dts/exynos4210-trats.dts b/arch/arm/dts/exynos4210-trats.dts
index 05989ee97e5b..4fbdf4730994 100644
--- a/arch/arm/dts/exynos4210-trats.dts
+++ b/arch/arm/dts/exynos4210-trats.dts
@@ -241,6 +241,7 @@
 
 &sdhci0 {
 	samsung,bus-width = <8>;
+	bus-width = <8>;
 	samsung,timing = <1 3 3>;
 	pwr-gpios = <&gpk0 2 0>;
 	status = "okay";
@@ -248,6 +249,7 @@
 
 &sdhci2 {
 	samsung,bus-width = <4>;
+	bus-width = <4>;
 	samsung,timing = <1 2 3>;
 	cd-gpios = <&gpx3 4 0>;
 	status = "okay";
diff --git a/arch/arm/dts/exynos4210-universal_c210.dts b/arch/arm/dts/exynos4210-universal_c210.dts
index 610a8ad2e71e..1b3ac1fee15f 100644
--- a/arch/arm/dts/exynos4210-universal_c210.dts
+++ b/arch/arm/dts/exynos4210-universal_c210.dts
@@ -236,6 +236,7 @@
 
 &sdhci0 {
 	samsung,bus-width = <8>;
+	bus-width = <8>;
 	samsung,timing = <1 3 3>;
 	pwr-gpios = <&gpk0 2 0>;
 	status = "okay";
@@ -243,6 +244,7 @@
 
 &sdhci2 {
 	samsung,bus-width = <4>;
+	bus-width = <4>;
 	samsung,timing = <1 2 3>;
 	cd-gpios = <&gpx3 4 0>;
 	status = "okay";
diff --git a/arch/arm/dts/exynos4412-odroid.dts b/arch/arm/dts/exynos4412-odroid.dts
index ce08e8dc1ebb..24e96ed05868 100644
--- a/arch/arm/dts/exynos4412-odroid.dts
+++ b/arch/arm/dts/exynos4412-odroid.dts
@@ -243,9 +243,15 @@
 
 &mshc_0 {
 	samsung,bus-width = <8>;
+	bus-width = <8>;
 	samsung,timing = <2 1 0>;
+	samsung,dw-mshc-ciu-div = <0>;
+	samsung,dw-mshc-sdr-timing = <2 1>;
 	samsung,removable = <0>;
+	non-removable;
 	fifoth_val = <0x203f0040>;
+	fifo-depth = <0x80>;
+	clock-frequency = <400000000>;
 	bus_hz = <400000000>;
 	div = <0x3>;
 	index = <4>;
diff --git a/arch/arm/dts/exynos4412-trats2.dts b/arch/arm/dts/exynos4412-trats2.dts
index c4db137e01f6..30758ffa1ef9 100644
--- a/arch/arm/dts/exynos4412-trats2.dts
+++ b/arch/arm/dts/exynos4412-trats2.dts
@@ -109,6 +109,7 @@
 
 	sdhci@12510000 {
 		samsung,bus-width = <8>;
+		bus-width = <8>;
 		samsung,timing = <1 3 3>;
 		pwr-gpios = <&gpk0 4 0>;
 		status = "disabled";
@@ -432,6 +433,7 @@
 
 &sdhci0 {
 	samsung,bus-width = <8>;
+	bus-width = <8>;
 	samsung,timing = <1 3 3>;
 	pwr-gpios = <&gpk0 4 0>;
 	status = "disabled";
@@ -439,6 +441,7 @@
 
 &sdhci2 {
 	samsung,bus-width = <4>;
+	bus-width = <4>;
 	samsung,timing = <1 2 3>;
 	cd-gpios = <&gpk2 2 0>;
 	status = "okay";
@@ -446,9 +449,14 @@
 
 &mshc_0 {
 	samsung,bus-width = <8>;
+	bus-width = <8>;
 	samsung,timing = <2 1 0>;
+	samsung,dw-mshc-ciu-div = <0>;
+	samsung,dw-mshc-sdr-timing = <2 1>;
 	samsung,removable = <0>;
+	non-removable;
 	fifoth_val = <0x203f0040>;
+	clock-frequency = <400000000>;
 	bus_hz = <400000000>;
 	div = <0x3>;
 	index = <4>;
diff --git a/arch/arm/dts/exynos5250-arndale.dts b/arch/arm/dts/exynos5250-arndale.dts
index 60309c61f302..7f84589c97a2 100644
--- a/arch/arm/dts/exynos5250-arndale.dts
+++ b/arch/arm/dts/exynos5250-arndale.dts
@@ -28,7 +28,10 @@
 
 	mmc@12200000 {
 		samsung,bus-width = <8>;
+		bus-width = <8>;
 		samsung,timing = <1 3 3>;
+		samsung,dw-mshc-ciu-div = <3>;
+		samsung,dw-mshc-sdr-timing = <1 3>;
 	};
 
 	mmc@12210000 {
@@ -37,7 +40,10 @@
 
 	mmc@12220000 {
 		samsung,bus-width = <4>;
+		bus-width = <4>;
 		samsung,timing = <1 2 3>;
+		samsung,dw-mshc-ciu-div = <3>;
+		samsung,dw-mshc-sdr-timing = <1 2>;
 	};
 
 	mmc@12230000 {
diff --git a/arch/arm/dts/exynos5250-smdk5250.dts b/arch/arm/dts/exynos5250-smdk5250.dts
index afe0cca48a93..882db2d1f608 100644
--- a/arch/arm/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/dts/exynos5250-smdk5250.dts
@@ -146,8 +146,12 @@
 
 	mmc@12200000 {
 		samsung,bus-width = <8>;
+		bus-width = <8>;
 		samsung,timing = <1 3 3>;
+		samsung,dw-mshc-ciu-div = <3>;
+		samsung,dw-mshc-sdr-timing = <1 3>;
 		samsung,removable = <0>;
+		non-removable;
 	};
 
 	mmc@12210000 {
@@ -156,7 +160,10 @@
 
 	mmc@12220000 {
 		samsung,bus-width = <4>;
+		bus-width = <4>;
 		samsung,timing = <1 2 3>;
+		samsung,dw-mshc-ciu-div = <3>;
+		samsung,dw-mshc-sdr-timing = <1 2>;
 		samsung,removable = <1>;
 	};
 
diff --git a/arch/arm/dts/exynos5250-snow.dts b/arch/arm/dts/exynos5250-snow.dts
index e41f2d3041e2..bcf04d5c07c0 100644
--- a/arch/arm/dts/exynos5250-snow.dts
+++ b/arch/arm/dts/exynos5250-snow.dts
@@ -302,8 +302,12 @@
 
 	mmc@12200000 {
 		samsung,bus-width = <8>;
+		bus-width = <8>;
 		samsung,timing = <1 3 3>;
+		samsung,dw-mshc-ciu-div = <3>;
+		samsung,dw-mshc-sdr-timing = <1 3>;
 		samsung,removable = <0>;
+		non-removable;
 	};
 
 	mmc@12210000 {
@@ -312,7 +316,10 @@
 
 	mmc@12220000 {
 		samsung,bus-width = <4>;
+		bus-width = <4>;
 		samsung,timing = <1 2 3>;
+		samsung,dw-mshc-ciu-div = <3>;
+		samsung,dw-mshc-sdr-timing = <1 2>;
 		samsung,removable = <1>;
 	};
 
diff --git a/arch/arm/dts/exynos5250-spring.dts b/arch/arm/dts/exynos5250-spring.dts
index 77e7a6b9e45a..7270a546a795 100644
--- a/arch/arm/dts/exynos5250-spring.dts
+++ b/arch/arm/dts/exynos5250-spring.dts
@@ -104,8 +104,12 @@
 
 	mmc@12200000 {
 		samsung,bus-width = <8>;
+		bus-width = <8>;
 		samsung,timing = <1 3 3>;
+		samsung,dw-mshc-ciu-div = <3>;
+		samsung,dw-mshc-sdr-timing = <1 3>;
 		samsung,removable = <0>;
+		non-removable;
 	};
 
 	mmc@12210000 {
diff --git a/arch/arm/dts/exynos5420-smdk5420.dts b/arch/arm/dts/exynos5420-smdk5420.dts
index 7a5da674fbed..1f27baafebaf 100644
--- a/arch/arm/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/dts/exynos5420-smdk5420.dts
@@ -107,8 +107,12 @@
 
 	mmc@12200000 {
 		samsung,bus-width = <8>;
+		bus-width = <8>;
 		samsung,timing = <1 3 3>;
+		samsung,dw-mshc-ciu-div = <3>;
+		samsung,dw-mshc-sdr-timing = <1 3>;
 		samsung,removable = <0>;
+		non-removable;
 		samsung,pre-init;
 	};
 
@@ -118,7 +122,10 @@
 
 	mmc@12220000 {
 		samsung,bus-width = <4>;
+		bus-width = <4>;
 		samsung,timing = <1 2 3>;
+		samsung,dw-mshc-ciu-div = <3>;
+		samsung,dw-mshc-sdr-timing = <1 2>;
 		samsung,removable = <1>;
 	};
 
diff --git a/arch/arm/dts/exynos5422-odroidxu3.dts b/arch/arm/dts/exynos5422-odroidxu3.dts
index 9d055d066fd3..767b3e415d58 100644
--- a/arch/arm/dts/exynos5422-odroidxu3.dts
+++ b/arch/arm/dts/exynos5422-odroidxu3.dts
@@ -281,10 +281,12 @@
 
 	mmc@12200000 {
 		fifoth_val = <0x201f0020>;
+		fifo-depth = <0x40>;
 	};
 
 	mmc@12220000 {
 		fifoth_val = <0x201f0020>;
+		fifo-depth = <0x40>;
 	};
 
 	emmc-reset {
diff --git a/arch/arm/dts/exynos54xx.dtsi b/arch/arm/dts/exynos54xx.dtsi
index 221da8b4850b..fd74166c7e48 100644
--- a/arch/arm/dts/exynos54xx.dtsi
+++ b/arch/arm/dts/exynos54xx.dtsi
@@ -120,8 +120,12 @@
 
 	mmc@12200000 {
 		samsung,bus-width = <8>;
+		bus-width = <8>;
 		samsung,timing = <1 3 3>;
+		samsung,dw-mshc-ciu-div = <3>;
+		samsung,dw-mshc-sdr-timing = <1 3>;
 		samsung,removable = <0>;
+		non-removable;
 		samsung,pre-init;
 	};
 
@@ -131,7 +135,10 @@
 
 	mmc@12220000 {
 		samsung,bus-width = <4>;
+		bus-width = <4>;
 		samsung,timing = <1 2 3>;
+		samsung,dw-mshc-ciu-div = <3>;
+		samsung,dw-mshc-sdr-timing = <1 2>;
 		samsung,removable = <1>;
 	};
 
-- 
2.39.2

