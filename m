Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19FCCC3DA59
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 18:00:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B889588657;
	Mon, 22 Jul 2024 19:58:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cwKpK0Y5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 364C6884DC; Mon, 22 Jul 2024 19:57:56 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0A74884F9
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 19:57:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-708e75d8d7cso2625102a34.3
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 10:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721671071; x=1722275871; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=id639ixBzy+ji376pqSatYxzuQUFVtJEU5yaKT9PomA=;
 b=cwKpK0Y56O8akKWdNEOOOjDXrBT6LmV8obnTDczJoxE0pbWxJ93cR3T747qIH3xNVc
 lsM92Kl5teX3/FipFPIDCMKZABzp64+23jz4Qf39R+h5pSYIGwLQpyce/hOo4N/aFDwQ
 jTibvUW+FUFOk2mmkqM/xslUYP6h+K75WBuYoEgxDbQwsGa2kSF8HWSFW/gS2IWca8mY
 PKt+yxV8Uchs5zO1ycM+BWBlDyEK/LT0nQkQ3LIXa+6vLN/K/RufDyClzmrzuElLEtIe
 PWzrIi/1MO7/TG4ZrSm3g9UWQKc2TCGsLEBtIhDsBv2H1IgpADFCN5d3AGdgowSGd0yC
 bM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721671071; x=1722275871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=id639ixBzy+ji376pqSatYxzuQUFVtJEU5yaKT9PomA=;
 b=tFnL24evG0mKvhQ0mfTjBR1lv6an5hA2kmPFYFubvfEEAxH4s3/tDl87E8Uhl14GXN
 IYkQYXfUEQdIxeTf4zm/2kl3G++dDu4kUv3I+odkXifb/ZbrSKBZ+ckTka6F6Gn6F/b4
 aXchnguxwfaIoaFLA5LTn99UHNx98xbKoXuBpXqhnCRS0kEdzhtfr1N9ghi9EYC3C8xS
 +qEoet520plQa0BXmkBGSR7sc3rxv0e08ZJxYPFxKYuZzqWutP61vl05Xmm4SBP/NUSl
 MpNY2Q8EcTHkXYpqwzMg/xd8B/7NEr/ulJWr2StxsNgbLRfPaZ5HmQFi4FrO89nIBDJ/
 uKNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVx86967cX77IPXj+m3jVaI9aw1+o0zlpJ2eSbltZ/wECkAx3iV7U48GFjLFU5XyXvMScNjYmtH0hRL2AcYBOK3hY37sQ==
X-Gm-Message-State: AOJu0YzblSScosjMEKhP1OkoYuVGYvl+MdanglzSkuMUPUMFVDlL5Zk0
 hdhaGWxKgYH4hXzPX48qW3O5r3z89RJXPBLjpbnaLsKwCm3v4sWx0Jvr2Vutayg=
X-Google-Smtp-Source: AGHT+IHthnhtktfKMn7qkjxJ5KAzUOyE8ZNNhAS9jmKVN3ERUcoqg6p69nDJOCflz5uMRxTlNZBk5A==
X-Received: by 2002:a05:6830:6103:b0:703:c26b:6e05 with SMTP id
 46e09a7af769-709008e4da1mr12024389a34.18.1721671071581; 
 Mon, 22 Jul 2024 10:57:51 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708f6195f6bsm1620485a34.77.2024.07.22.10.57.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 10:57:51 -0700 (PDT)
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
Subject: [PATCH v3 14/38] arm: dts: exynos: Add upstream DW MMC properties to
 all Exynos dts
Date: Mon, 22 Jul 2024 12:57:16 -0500
Message-Id: <20240722175740.6985-15-semen.protsenko@linaro.org>
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
Changes in v3:
  - (none)

Changes in v2:
  - (none)

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

