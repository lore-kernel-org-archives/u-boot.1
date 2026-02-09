Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB61E7E0D2
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 18:33:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46DA283D0B;
	Mon,  9 Feb 2026 19:32:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cp+4BuDl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA170805D7; Mon,  9 Feb 2026 19:32:34 +0100 (CET)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA45280325
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 19:32:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-38305d006faso40616121fa.3
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 10:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770661951; x=1771266751; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mwNOx3qaUH5Lgm9K74bGju095uYLpEKWi8xYFZqaZSM=;
 b=cp+4BuDlzuyP/MGGPILpHxV9+jH0D1Kd0Y6KyjLL4nI8D8jeRZt9SJc0s8xRXwmBH3
 WtkMSFAeWyh/8BxN40LFI9PZD9NPdGNsntF1BviLf0GGB5hsky7GPzxtrWoHl2dnQO63
 YM5j2XXV8rIx0ncHUqcqb0BPzOqa5lGvunDxhXILcdUxj4f05X31wOlRUG8pfogL7eCu
 s6Gj2qvyEXzxRvfXqqhynPEn4Nf8mTF1RwW3lX1dXMi5lNKqixvx1DAbrI1KchOHUBhk
 Ddl88nCUlm2OOkhWp2Zct1VpHvg3SfF+fSahqKHYcqgBl/KkTWYshcc3VfcOZtKYJJ6Q
 cHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770661951; x=1771266751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mwNOx3qaUH5Lgm9K74bGju095uYLpEKWi8xYFZqaZSM=;
 b=gHx9jlcbDAhqdRQZA7NL2ua8+/PinoG8KT+AR2NyD8jH+UL/eXVCsVhY3PcI1hCZEW
 IDiCCJtmJdhQYgRuMyCBl2e3aF1f2pKH2LMqKjwpCs/qyDQ/DfZMjQQTj6WLczfCP9l4
 qMfHX2TGyaFGmWSsG68NjPswSK8p67+eHB+zenq8s52JjXPLxa2OrqP+zUmG7dpeqfau
 rP2AS4hBJilSu4iyGyropNvcciZDVU/xphLTY6C8BQSbjxn/N6Gl00rL4IcBN4kLBOy9
 hKWpXro7B6d6cOFQdqKdbsvTw/QWpt4vVcIv6VXPdxMVCnMDgZ7662zKHtIJf27tGMKs
 usHA==
X-Gm-Message-State: AOJu0YzRf1kyk1dGFE2nHa1aZSzhoNWEilJOJ57p8s6Se/TS1MN1OHM8
 9s3z7lyskuMhuIZIV1bf6K7HoAL/LsSYSbKN3O6M/R5VCjOr0fwQe0Cf
X-Gm-Gg: AZuq6aLEFCrymvXdg8uUMVvt1DZSn2EmVa/HlrlCBdGJ+vETVbXmDby3Dd9Bo07oLqi
 Dar/QIdovXKdZWX9r3882feqfdlflTJhYLFK2cViYdm7q6QJUZJI7Y8ojwrT+o/4OPl+EUSxw0q
 3lQUehPbun1wAWYAfZc0lP3jmWMwoPLynf3ZVXLSmcb6lTF+SoZ3gluRZwINjNNDRiqRxYYH0Yo
 ttTLyESlNLm9fp7LFgp6uP7VKMIF2E5ktp6nz8gpkumVTi1sdlZuVN1EhgJY/VdE7A4TNi0IHNf
 uFUhWZ8no5qrdvvH9regIKJH4fLa03A7JFdokGkce8n/bNOcuBfIyE0PXXCLDIejDp+9hi/sAFa
 Kj1clhsK6mNRzySi2NBbETNCx0KYofbzW0IwOGHKSrB1na07j1HzPYbKk3twi5M1GB2BNW9TTTi
 Fx
X-Received: by 2002:a05:6512:1307:b0:59e:2a7:4055 with SMTP id
 2adb3069b0e04-59e4515bfdamr3790799e87.32.1770661950592; 
 Mon, 09 Feb 2026 10:32:30 -0800 (PST)
Received: from xeon ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59e44d299ffsm2815391e87.55.2026.02.09.10.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 10:32:30 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Ion Agorria <ion@agorria.com>, Peter Robinson <pbrobinson@gmail.com>,
 Peter Geis <pgwipeout@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 5/6] ARM: tegra: rename sdhci nodes to mmc
Date: Mon,  9 Feb 2026 20:32:18 +0200
Message-ID: <20260209183219.34250-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209183219.34250-1-clamor95@gmail.com>
References: <20260209183219.34250-1-clamor95@gmail.com>
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

Align with existing Linux Tegra device trees to simplify using U-Boot
device trees as a base for future Linux adaptations.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/tegra114-asus-tf701t.dts                |  4 ++--
 arch/arm/dts/tegra114-dalmore.dts                    |  8 ++++----
 .../arm/dts/tegra114-microsoft-surface-2-common.dtsi |  4 ++--
 arch/arm/dts/tegra114-nvidia-tegratab.dts            |  4 ++--
 arch/arm/dts/tegra114.dtsi                           |  8 ++++----
 arch/arm/dts/tegra124-apalis.dts                     | 12 ++++++------
 arch/arm/dts/tegra124-cei-tk1-som.dts                |  8 ++++----
 arch/arm/dts/tegra124-jetson-tk1.dts                 |  8 ++++----
 arch/arm/dts/tegra124-nyan-big.dts                   |  6 +++---
 arch/arm/dts/tegra124-nyan.dtsi                      |  6 +++---
 arch/arm/dts/tegra124-venice2.dts                    |  8 ++++----
 arch/arm/dts/tegra124-xiaomi-mocha.dts               |  4 ++--
 arch/arm/dts/tegra124.dtsi                           |  8 ++++----
 arch/arm/dts/tegra186-p2771-0000-000.dts             |  2 +-
 arch/arm/dts/tegra186-p2771-0000-500.dts             |  2 +-
 arch/arm/dts/tegra186-p2771-0000.dtsi                |  8 ++++----
 arch/arm/dts/tegra186.dtsi                           |  4 ++--
 arch/arm/dts/tegra20-acer-a500-picasso.dts           |  4 ++--
 arch/arm/dts/tegra20-asus-transformer.dtsi           |  4 ++--
 arch/arm/dts/tegra20-colibri.dts                     |  4 ++--
 arch/arm/dts/tegra20-harmony.dts                     |  8 ++++----
 arch/arm/dts/tegra20-lg-star.dts                     |  4 ++--
 arch/arm/dts/tegra20-medcom-wide.dts                 |  2 +-
 arch/arm/dts/tegra20-motorola-mot.dtsi               |  4 ++--
 arch/arm/dts/tegra20-paz00.dts                       |  8 ++++----
 arch/arm/dts/tegra20-plutux.dts                      |  2 +-
 arch/arm/dts/tegra20-samsung-bose.dts                |  2 +-
 arch/arm/dts/tegra20-samsung-n1-common.dtsi          |  4 ++--
 arch/arm/dts/tegra20-samsung-n1.dts                  |  2 +-
 arch/arm/dts/tegra20-seaboard.dts                    | 10 +++++-----
 arch/arm/dts/tegra20-tamonten.dtsi                   |  2 +-
 arch/arm/dts/tegra20-tec.dts                         |  2 +-
 arch/arm/dts/tegra20-trimslice.dts                   |  8 ++++----
 arch/arm/dts/tegra20-ventana.dts                     | 10 +++++-----
 arch/arm/dts/tegra20.dtsi                            |  8 ++++----
 arch/arm/dts/tegra210-p2371-0000.dts                 |  8 ++++----
 arch/arm/dts/tegra210-p2371-2180.dts                 |  8 ++++----
 arch/arm/dts/tegra210-p2571.dts                      |  8 ++++----
 arch/arm/dts/tegra210-p3450-0000.dts                 |  8 ++++----
 arch/arm/dts/tegra210.dtsi                           |  8 ++++----
 arch/arm/dts/tegra30-apalis.dts                      | 12 ++++++------
 arch/arm/dts/tegra30-asus-grouper-common.dtsi        |  2 +-
 arch/arm/dts/tegra30-asus-p1801-t.dts                |  4 ++--
 arch/arm/dts/tegra30-asus-tf600t.dts                 |  4 ++--
 arch/arm/dts/tegra30-asus-transformer.dtsi           |  4 ++--
 arch/arm/dts/tegra30-beaver.dts                      |  8 ++++----
 arch/arm/dts/tegra30-cardhu.dts                      |  8 ++++----
 arch/arm/dts/tegra30-colibri.dts                     |  8 ++++----
 arch/arm/dts/tegra30-htc-endeavoru.dts               |  2 +-
 arch/arm/dts/tegra30-lenovo-ideapad-yoga-11.dts      |  4 ++--
 arch/arm/dts/tegra30-lg-p880.dts                     |  2 +-
 arch/arm/dts/tegra30-lg-x3.dtsi                      |  2 +-
 arch/arm/dts/tegra30-microsoft-surface-rt.dts        |  4 ++--
 arch/arm/dts/tegra30-ouya.dts                        |  2 +-
 arch/arm/dts/tegra30-pegatron-chagall.dts            |  4 ++--
 arch/arm/dts/tegra30-tamonten.dtsi                   | 10 +++++-----
 arch/arm/dts/tegra30-tec-ng.dts                      |  2 +-
 arch/arm/dts/tegra30-wexler-qc750.dts                |  4 ++--
 arch/arm/dts/tegra30.dtsi                            |  8 ++++----
 59 files changed, 163 insertions(+), 163 deletions(-)

diff --git a/arch/arm/dts/tegra114-asus-tf701t.dts b/arch/arm/dts/tegra114-asus-tf701t.dts
index 2505b9bb726..bd43a80a208 100644
--- a/arch/arm/dts/tegra114-asus-tf701t.dts
+++ b/arch/arm/dts/tegra114-asus-tf701t.dts
@@ -1151,7 +1151,7 @@
 		};
 	};
 
-	sdmmc3: sdhci@78000400 {
+	sdmmc3: mmc@78000400 {
 		status = "okay";
 		bus-width = <4>;
 
@@ -1165,7 +1165,7 @@
 		vqmmc-supply = <&vddio_usd>;
 	};
 
-	sdmmc4: sdhci@78000600 {
+	sdmmc4: mmc@78000600 {
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
diff --git a/arch/arm/dts/tegra114-dalmore.dts b/arch/arm/dts/tegra114-dalmore.dts
index 18bcb75fafa..48708f37246 100644
--- a/arch/arm/dts/tegra114-dalmore.dts
+++ b/arch/arm/dts/tegra114-dalmore.dts
@@ -16,8 +16,8 @@
 		i2c2 = "/i2c@7000c400";
 		i2c3 = "/i2c@7000c500";
 		i2c4 = "/i2c@7000c700";
-		mmc0 = "/sdhci@78000600";
-		mmc1 = "/sdhci@78000400";
+		mmc0 = "/mmc@78000600";
+		mmc1 = "/mmc@78000400";
 		usb0 = "/usb@7d000000";
 		usb1 = "/usb@7d008000";
 	};
@@ -57,13 +57,13 @@
 		spi-max-frequency = <25000000>;
 	};
 
-	sdhci@78000400 {
+	mmc@78000400 {
 		cd-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_LOW>;
 		bus-width = <4>;
 		status = "okay";
 	};
 
-	sdhci@78000600 {
+	mmc@78000600 {
 		bus-width = <8>;
 		status = "okay";
 		non-removable;
diff --git a/arch/arm/dts/tegra114-microsoft-surface-2-common.dtsi b/arch/arm/dts/tegra114-microsoft-surface-2-common.dtsi
index 79369753a17..f735f5060ce 100644
--- a/arch/arm/dts/tegra114-microsoft-surface-2-common.dtsi
+++ b/arch/arm/dts/tegra114-microsoft-surface-2-common.dtsi
@@ -814,7 +814,7 @@
 		};
 	};
 
-	sdmmc3: sdhci@78000400 {
+	sdmmc3: mmc@78000400 {
 		status = "okay";
 		bus-width = <4>;
 
@@ -827,7 +827,7 @@
 		vqmmc-supply = <&vddio_usd>;
 	};
 
-	sdmmc4: sdhci@78000600 {
+	sdmmc4: mmc@78000600 {
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
diff --git a/arch/arm/dts/tegra114-nvidia-tegratab.dts b/arch/arm/dts/tegra114-nvidia-tegratab.dts
index f65772a8e01..6ff2850b911 100644
--- a/arch/arm/dts/tegra114-nvidia-tegratab.dts
+++ b/arch/arm/dts/tegra114-nvidia-tegratab.dts
@@ -953,7 +953,7 @@
 		};
 	};
 
-	sdmmc3: sdhci@78000400 {
+	sdmmc3: mmc@78000400 {
 		status = "okay";
 		bus-width = <4>;
 
@@ -967,7 +967,7 @@
 		vqmmc-supply = <&vddio_usd>;
 	};
 
-	sdmmc4: sdhci@78000600 {
+	sdmmc4: mmc@78000600 {
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
diff --git a/arch/arm/dts/tegra114.dtsi b/arch/arm/dts/tegra114.dtsi
index 250d692f6bf..0a783fbc95d 100644
--- a/arch/arm/dts/tegra114.dtsi
+++ b/arch/arm/dts/tegra114.dtsi
@@ -631,7 +631,7 @@
 		#nvidia,mipi-calibrate-cells = <1>;
 	};
 
-	sdhci@78000000 {
+	mmc@78000000 {
 		compatible = "nvidia,tegra114-sdhci", "nvidia,tegra30-sdhci";
 		reg = <0x78000000 0x200>;
 		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
@@ -641,7 +641,7 @@
 		status = "disabled";
 	};
 
-	sdhci@78000200 {
+	mmc@78000200 {
 		compatible = "nvidia,tegra114-sdhci", "nvidia,tegra30-sdhci";
 		reg = <0x78000200 0x200>;
 		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
@@ -651,7 +651,7 @@
 		status = "disabled";
 	};
 
-	sdhci@78000400 {
+	mmc@78000400 {
 		compatible = "nvidia,tegra114-sdhci", "nvidia,tegra30-sdhci";
 		reg = <0x78000400 0x200>;
 		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
@@ -661,7 +661,7 @@
 		status = "disabled";
 	};
 
-	sdhci@78000600 {
+	mmc@78000600 {
 		compatible = "nvidia,tegra114-sdhci", "nvidia,tegra30-sdhci";
 		reg = <0x78000600 0x200>;
 		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/dts/tegra124-apalis.dts b/arch/arm/dts/tegra124-apalis.dts
index 08184ab3ac2..5ac08037a92 100644
--- a/arch/arm/dts/tegra124-apalis.dts
+++ b/arch/arm/dts/tegra124-apalis.dts
@@ -54,9 +54,9 @@
 		i2c1 = "/i2c@7000c000";
 		i2c2 = "/i2c@7000c400";
 		i2c3 = "/i2c@7000c500";
-		mmc0 = "/sdhci@700b0600";
-		mmc1 = "/sdhci@700b0000";
-		mmc2 = "/sdhci@700b0400";
+		mmc0 = "/mmc@700b0600";
+		mmc1 = "/mmc@700b0000";
+		mmc2 = "/mmc@700b0400";
 		rtc0 = "/i2c@7000c000/rtc@68";
 		rtc1 = "/i2c@7000d000/pmic@40";
 		rtc2 = "/rtc@7000e000";
@@ -1958,7 +1958,7 @@
 	};
 
 	/* Apalis MMC1 */
-	sdhci@700b0000 {
+	mmc@700b0000 {
 		status = "okay";
 		/* MMC1_CD# */
 		cd-gpios = <&gpio TEGRA_GPIO(V, 3) GPIO_ACTIVE_LOW>;
@@ -1967,7 +1967,7 @@
 	};
 
 	/* Apalis SD1 */
-	sdhci@700b0400 {
+	mmc@700b0400 {
 		status = "okay";
 		/* SD1_CD# */
 		cd-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_LOW>;
@@ -1976,7 +1976,7 @@
 	};
 
 	/* eMMC */
-	sdhci@700b0600 {
+	mmc@700b0600 {
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
diff --git a/arch/arm/dts/tegra124-cei-tk1-som.dts b/arch/arm/dts/tegra124-cei-tk1-som.dts
index e5b41f3183c..59901a3439b 100644
--- a/arch/arm/dts/tegra124-cei-tk1-som.dts
+++ b/arch/arm/dts/tegra124-cei-tk1-som.dts
@@ -16,8 +16,8 @@
 		i2c2 = "/i2c@7000c400";
 		i2c3 = "/i2c@7000c500";
 		i2c4 = "/i2c@7000c700";
-		mmc0 = "/sdhci@700b0600";
-		mmc1 = "/sdhci@700b0400";
+		mmc0 = "/mmc@700b0600";
+		mmc1 = "/mmc@700b0400";
 		spi0 = "/spi@7000d400";
 		spi1 = "/spi@7000da00";
 		usb0 = "/usb@7d000000";
@@ -297,7 +297,7 @@
 		};
 	};
 
-	sdhci@700b0400 {
+	mmc@700b0400 {
 		status = "okay";
 		cd-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_LOW>;
 		power-gpios = <&gpio TEGRA_GPIO(R, 0) GPIO_ACTIVE_HIGH>;
@@ -305,7 +305,7 @@
 		bus-width = <4>;
 	};
 
-	sdhci@700b0600 {
+	mmc@700b0600 {
 		status = "okay";
 		bus-width = <8>;
 	};
diff --git a/arch/arm/dts/tegra124-jetson-tk1.dts b/arch/arm/dts/tegra124-jetson-tk1.dts
index 59e080a8af6..7d19a25e278 100644
--- a/arch/arm/dts/tegra124-jetson-tk1.dts
+++ b/arch/arm/dts/tegra124-jetson-tk1.dts
@@ -16,8 +16,8 @@
 		i2c2 = "/i2c@7000c400";
 		i2c3 = "/i2c@7000c500";
 		i2c4 = "/i2c@7000c700";
-		mmc0 = "/sdhci@700b0600";
-		mmc1 = "/sdhci@700b0400";
+		mmc0 = "/mmc@700b0600";
+		mmc1 = "/mmc@700b0400";
 		spi0 = "/spi@7000d400";
 		spi1 = "/spi@7000da00";
 		usb0 = "/usb@7d000000";
@@ -301,7 +301,7 @@
 		};
 	};
 
-	sdhci@700b0400 {
+	mmc@700b0400 {
 		status = "okay";
 		cd-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_LOW>;
 		power-gpios = <&gpio TEGRA_GPIO(R, 0) GPIO_ACTIVE_HIGH>;
@@ -309,7 +309,7 @@
 		bus-width = <4>;
 	};
 
-	sdhci@700b0600 {
+	mmc@700b0600 {
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
diff --git a/arch/arm/dts/tegra124-nyan-big.dts b/arch/arm/dts/tegra124-nyan-big.dts
index f1c97052a84..b942d92e900 100644
--- a/arch/arm/dts/tegra124-nyan-big.dts
+++ b/arch/arm/dts/tegra124-nyan-big.dts
@@ -16,8 +16,8 @@
 		i2c5 = "/i2c@7000d100";
 		rtc0 = "/i2c@7000d000/pmic@40";
 		rtc1 = "/rtc@7000e000";
-		mmc0 = "/sdhci@700b0600";
-		mmc1 = "/sdhci@700b0400";
+		mmc0 = "/mmc@700b0600";
+		mmc1 = "/mmc@700b0400";
 		spi0 = "/spi@7000d400";
 		spi1 = "/spi@7000da00";
 		usb0 = "/usb@7d000000";
@@ -59,7 +59,7 @@
 		ddc-i2c-bus = <&dpaux>;
 	};
 
-	sdhci@700b0400 { /* SD Card on this bus */
+	mmc@700b0400 { /* SD Card on this bus */
 		wp-gpios = <&gpio TEGRA_GPIO(Q, 4) GPIO_ACTIVE_LOW>;
 	};
 
diff --git a/arch/arm/dts/tegra124-nyan.dtsi b/arch/arm/dts/tegra124-nyan.dtsi
index 2b28fe14970..7b465c601af 100644
--- a/arch/arm/dts/tegra124-nyan.dtsi
+++ b/arch/arm/dts/tegra124-nyan.dtsi
@@ -370,7 +370,7 @@
 		reset-gpios = <&gpio TEGRA_GPIO(X, 7) GPIO_ACTIVE_LOW>;
 	};
 
-	sdhci@700b0000 { /* WiFi/BT on this bus */
+	mmc@700b0000 { /* WiFi/BT on this bus */
 		status = "okay";
 		power-gpios = <&gpio TEGRA_GPIO(X, 7) GPIO_ACTIVE_HIGH>;
 		bus-width = <4>;
@@ -382,7 +382,7 @@
 		keep-power-in-suspend;
 	};
 
-	sdhci@700b0400 { /* SD Card on this bus */
+	mmc@700b0400 { /* SD Card on this bus */
 		status = "okay";
 		cd-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_LOW>;
 		power-gpios = <&gpio TEGRA_GPIO(R, 0) GPIO_ACTIVE_HIGH>;
@@ -392,7 +392,7 @@
 		vqmmc-supply = <&vddio_sdmmc3>;
 	};
 
-	sdhci@700b0600 { /* eMMC on this bus */
+	mmc@700b0600 { /* eMMC on this bus */
 		status = "okay";
 		bus-width = <8>;
 		no-1-8-v;
diff --git a/arch/arm/dts/tegra124-venice2.dts b/arch/arm/dts/tegra124-venice2.dts
index 7e9c6aa1839..0e855d8bc30 100644
--- a/arch/arm/dts/tegra124-venice2.dts
+++ b/arch/arm/dts/tegra124-venice2.dts
@@ -17,8 +17,8 @@
 		i2c3 = "/i2c@7000c500";
 		i2c4 = "/i2c@7000c700";
 		i2c5 = "/i2c@7000d100";
-		mmc0 = "/sdhci@700b0600";
-		mmc1 = "/sdhci@700b0400";
+		mmc0 = "/mmc@700b0600";
+		mmc1 = "/mmc@700b0400";
 		spi0 = "/spi@7000d400";
 		spi1 = "/spi@7000da00";
 		usb0 = "/usb@7d000000";
@@ -70,7 +70,7 @@
 		spi-max-frequency = <25000000>;
 	};
 
-	sdhci@700b0400 {
+	mmc@700b0400 {
 		status = "okay";
 		cd-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_HIGH>;
 		power-gpios = <&gpio TEGRA_GPIO(R, 0) GPIO_ACTIVE_HIGH>;
@@ -78,7 +78,7 @@
 		bus-width = <4>;
 	};
 
-	sdhci@700b0600 {
+	mmc@700b0600 {
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
diff --git a/arch/arm/dts/tegra124-xiaomi-mocha.dts b/arch/arm/dts/tegra124-xiaomi-mocha.dts
index 64386f2b7b7..09b5c1eea05 100644
--- a/arch/arm/dts/tegra124-xiaomi-mocha.dts
+++ b/arch/arm/dts/tegra124-xiaomi-mocha.dts
@@ -476,7 +476,7 @@
 		};
 	};
 
-	sdmmc3: sdhci@700b0400 {
+	sdmmc3: mmc@700b0400 {
 		status = "okay";
 		bus-width = <4>;
 
@@ -487,7 +487,7 @@
 		vqmmc-supply = <&vddio_usd>;
 	};
 
-	sdmmc4: sdhci@700b0600 {
+	sdmmc4: mmc@700b0600 {
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
diff --git a/arch/arm/dts/tegra124.dtsi b/arch/arm/dts/tegra124.dtsi
index cac9b112302..1c62d1f6e7b 100644
--- a/arch/arm/dts/tegra124.dtsi
+++ b/arch/arm/dts/tegra124.dtsi
@@ -717,7 +717,7 @@
 		#phy-cells = <1>;
 	};
 
-	sdhci@700b0000 {
+	mmc@700b0000 {
 		compatible = "nvidia,tegra124-sdhci";
 		reg = <0x700b0000 0x200>;
 		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
@@ -727,7 +727,7 @@
 		status = "disabled";
 	};
 
-	sdhci@700b0200 {
+	mmc@700b0200 {
 		compatible = "nvidia,tegra124-sdhci";
 		reg = <0x700b0200 0x200>;
 		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
@@ -737,7 +737,7 @@
 		status = "disabled";
 	};
 
-	sdhci@700b0400 {
+	mmc@700b0400 {
 		compatible = "nvidia,tegra124-sdhci";
 		reg = <0x700b0400 0x200>;
 		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
@@ -747,7 +747,7 @@
 		status = "disabled";
 	};
 
-	sdhci@700b0600 {
+	mmc@700b0600 {
 		compatible = "nvidia,tegra124-sdhci";
 		reg = <0x700b0600 0x200>;
 		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/dts/tegra186-p2771-0000-000.dts b/arch/arm/dts/tegra186-p2771-0000-000.dts
index 84e850d6fca..39076058bfb 100644
--- a/arch/arm/dts/tegra186-p2771-0000-000.dts
+++ b/arch/arm/dts/tegra186-p2771-0000-000.dts
@@ -6,7 +6,7 @@
 	model = "NVIDIA P2771-0000-000";
 	compatible = "nvidia,p2771-0000-000", "nvidia,p2771-0000", "nvidia,tegra186";
 
-	sdhci@3400000 {
+	mmc@3400000 {
 		cd-gpios = <&gpio_main TEGRA_MAIN_GPIO(P, 6) GPIO_ACTIVE_LOW>;
 		power-gpios = <&gpio_main TEGRA_MAIN_GPIO(P, 5) GPIO_ACTIVE_HIGH>;
 	};
diff --git a/arch/arm/dts/tegra186-p2771-0000-500.dts b/arch/arm/dts/tegra186-p2771-0000-500.dts
index 1ac8ab431e9..cb36dae80e5 100644
--- a/arch/arm/dts/tegra186-p2771-0000-500.dts
+++ b/arch/arm/dts/tegra186-p2771-0000-500.dts
@@ -6,7 +6,7 @@
 	model = "NVIDIA P2771-0000-500";
 	compatible = "nvidia,p2771-0000-500", "nvidia,p2771-0000", "nvidia,tegra186";
 
-	sdhci@3400000 {
+	mmc@3400000 {
 		cd-gpios = <&gpio_main TEGRA_MAIN_GPIO(P, 5) GPIO_ACTIVE_LOW>;
 		power-gpios = <&gpio_main TEGRA_MAIN_GPIO(P, 6) GPIO_ACTIVE_HIGH>;
 	};
diff --git a/arch/arm/dts/tegra186-p2771-0000.dtsi b/arch/arm/dts/tegra186-p2771-0000.dtsi
index 7cda0b41f74..7bbf81fe2bf 100644
--- a/arch/arm/dts/tegra186-p2771-0000.dtsi
+++ b/arch/arm/dts/tegra186-p2771-0000.dtsi
@@ -10,8 +10,8 @@
 
 	aliases {
 		ethernet = "/ethernet@2490000";
-		mmc0 = "/sdhci@3460000";
-		mmc1 = "/sdhci@3400000";
+		mmc0 = "/mmc@3460000";
+		mmc1 = "/mmc@3400000";
 		i2c0 = "/bpmp/i2c";
 		i2c1 = "/i2c@3160000";
 		i2c2 = "/i2c@c240000";
@@ -48,13 +48,13 @@
 		status = "okay";
 	};
 
-	sdhci@3400000 {
+	mmc@3400000 {
 		status = "okay";
 		wp-gpios = <&gpio_main TEGRA_MAIN_GPIO(P, 4) GPIO_ACTIVE_HIGH>;
 		bus-width = <4>;
 	};
 
-	sdhci@3460000 {
+	mmc@3460000 {
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
diff --git a/arch/arm/dts/tegra186.dtsi b/arch/arm/dts/tegra186.dtsi
index edcb7aacb8e..0cabf608a9e 100644
--- a/arch/arm/dts/tegra186.dtsi
+++ b/arch/arm/dts/tegra186.dtsi
@@ -136,7 +136,7 @@
 		status = "disabled";
 	};
 
-	sdhci@3400000 {
+	mmc@3400000 {
 		compatible = "nvidia,tegra186-sdhci";
 		reg = <0x0 0x03400000 0x0 0x200>;
 		resets = <&bpmp TEGRA186_RESET_SDMMC1>;
@@ -146,7 +146,7 @@
 		status = "disabled";
 	};
 
-	sdhci@3460000 {
+	mmc@3460000 {
 		compatible = "nvidia,tegra186-sdhci";
 		reg = <0x0 0x03460000 0x0 0x200>;
 		resets = <&bpmp TEGRA186_RESET_SDMMC4>;
diff --git a/arch/arm/dts/tegra20-acer-a500-picasso.dts b/arch/arm/dts/tegra20-acer-a500-picasso.dts
index 4afde766330..d8d2d10a48a 100644
--- a/arch/arm/dts/tegra20-acer-a500-picasso.dts
+++ b/arch/arm/dts/tegra20-acer-a500-picasso.dts
@@ -400,7 +400,7 @@
 		nvidia,xcvr-lsrslew = <2>;
 	};
 
-	sdmmc3: sdhci@c8000400 {
+	sdmmc3: mmc@c8000400 {
 		status = "okay";
 		bus-width = <4>;
 
@@ -412,7 +412,7 @@
 		vqmmc-supply = <&vdd_3v3_sys>;
 	};
 
-	sdmmc4: sdhci@c8000600 {
+	sdmmc4: mmc@c8000600 {
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
diff --git a/arch/arm/dts/tegra20-asus-transformer.dtsi b/arch/arm/dts/tegra20-asus-transformer.dtsi
index df078a6fcdc..db6bed3e5d2 100644
--- a/arch/arm/dts/tegra20-asus-transformer.dtsi
+++ b/arch/arm/dts/tegra20-asus-transformer.dtsi
@@ -437,7 +437,7 @@
 		status = "okay";
 	};
 
-	sdmmc3: sdhci@c8000400 {
+	sdmmc3: mmc@c8000400 {
 		status = "okay";
 		bus-width = <4>;
 
@@ -449,7 +449,7 @@
 		vqmmc-supply = <&vdd_3v3_sys>;
 	};
 
-	sdmmc4: sdhci@c8000600 {
+	sdmmc4: mmc@c8000600 {
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
diff --git a/arch/arm/dts/tegra20-colibri.dts b/arch/arm/dts/tegra20-colibri.dts
index 11023968f41..776491a515e 100644
--- a/arch/arm/dts/tegra20-colibri.dts
+++ b/arch/arm/dts/tegra20-colibri.dts
@@ -14,7 +14,7 @@
 		i2c0 = "/i2c@7000d000";
 		i2c1 = "/i2c@7000c000";
 		i2c2 = "/i2c@7000c400";
-		mmc0 = "/sdhci@c8000600";
+		mmc0 = "/mmc@c8000600";
 		usb0 = "/usb@c5000000";
 		usb1 = "/usb@c5004000"; /* On-module only, for ASIX */
 		usb2 = "/usb@c5008000";
@@ -106,7 +106,7 @@
 		nvidia,vbus-gpio = <&gpio TEGRA_GPIO(W, 2) GPIO_ACTIVE_LOW>;
 	};
 
-	sdhci@c8000600 {
+	mmc@c8000600 {
 		status = "okay";
 		bus-width = <4>;
 		cd-gpios = <&gpio TEGRA_GPIO(C, 7) GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/dts/tegra20-harmony.dts b/arch/arm/dts/tegra20-harmony.dts
index 7fe7d52096c..60cc7b32bb0 100644
--- a/arch/arm/dts/tegra20-harmony.dts
+++ b/arch/arm/dts/tegra20-harmony.dts
@@ -18,8 +18,8 @@
 		usb0 = "/usb@c5000000";
 		usb1 = "/usb@c5004000";
 		usb2 = "/usb@c5008000";
-		mmc0 = "/sdhci@c8000600";
-		mmc1 = "/sdhci@c8000200";
+		mmc0 = "/mmc@c8000600";
+		mmc1 = "/mmc@c8000200";
 	};
 
 	memory {
@@ -645,7 +645,7 @@
 		status = "okay";
 	};
 
-	sdhci@c8000200 {
+	mmc@c8000200 {
 		status = "okay";
 		cd-gpios = <&gpio TEGRA_GPIO(I, 5) GPIO_ACTIVE_LOW>;
 		wp-gpios = <&gpio TEGRA_GPIO(H, 1) GPIO_ACTIVE_HIGH>;
@@ -653,7 +653,7 @@
 		bus-width = <4>;
 	};
 
-	sdhci@c8000600 {
+	mmc@c8000600 {
 		status = "okay";
 		cd-gpios = <&gpio TEGRA_GPIO(H, 2) GPIO_ACTIVE_LOW>;
 		wp-gpios = <&gpio TEGRA_GPIO(H, 3) GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/dts/tegra20-lg-star.dts b/arch/arm/dts/tegra20-lg-star.dts
index 8012b57e5bb..912c0b6051b 100644
--- a/arch/arm/dts/tegra20-lg-star.dts
+++ b/arch/arm/dts/tegra20-lg-star.dts
@@ -413,7 +413,7 @@
 		vbus-supply = <&avdd_3v3_usb>;
 	};
 
-	sdmmc3: sdhci@c8000400 {
+	sdmmc3: mmc@c8000400 {
 		status = "okay";
 		bus-width = <4>;
 
@@ -423,7 +423,7 @@
 		vqmmc-supply = <&vdd_1v8_vio>;
 	};
 
-	sdmmc4: sdhci@c8000600 {
+	sdmmc4: mmc@c8000600 {
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
diff --git a/arch/arm/dts/tegra20-medcom-wide.dts b/arch/arm/dts/tegra20-medcom-wide.dts
index 1c79d757467..00e9272541a 100644
--- a/arch/arm/dts/tegra20-medcom-wide.dts
+++ b/arch/arm/dts/tegra20-medcom-wide.dts
@@ -12,7 +12,7 @@
 
 	aliases {
 		usb0 = "/usb@c5008000";
-		mmc0 = "/sdhci@c8000600";
+		mmc0 = "/mmc@c8000600";
 	};
 
 	memory {
diff --git a/arch/arm/dts/tegra20-motorola-mot.dtsi b/arch/arm/dts/tegra20-motorola-mot.dtsi
index 5a9f58ff17f..b3c0e36340d 100644
--- a/arch/arm/dts/tegra20-motorola-mot.dtsi
+++ b/arch/arm/dts/tegra20-motorola-mot.dtsi
@@ -425,7 +425,7 @@
 		vbus-supply = <&avdd_3v3_periph>;
 	};
 
-	sdmmc3: sdhci@c8000400 {
+	sdmmc3: mmc@c8000400 {
 		status = "okay";
 		bus-width = <4>;
 
@@ -435,7 +435,7 @@
 		vqmmc-supply = <&vddio_usd>;
 	};
 
-	sdmmc4: sdhci@c8000600 {
+	sdmmc4: mmc@c8000600 {
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
diff --git a/arch/arm/dts/tegra20-paz00.dts b/arch/arm/dts/tegra20-paz00.dts
index f851767a55f..91799518412 100644
--- a/arch/arm/dts/tegra20-paz00.dts
+++ b/arch/arm/dts/tegra20-paz00.dts
@@ -19,8 +19,8 @@
 		usb0 = "/usb@c5000000";
 		usb1 = "/usb@c5004000";
 		usb2 = "/usb@c5008000";
-		mmc0 = "/sdhci@c8000600";
-		mmc1 = "/sdhci@c8000000";
+		mmc0 = "/mmc@c8000600";
+		mmc1 = "/mmc@c8000000";
 	};
 
 	memory {
@@ -485,7 +485,7 @@
 		status = "okay";
 	};
 
-	sdhci@c8000000 {
+	mmc@c8000000 {
 		status = "okay";
 		cd-gpios = <&gpio TEGRA_GPIO(V, 5) GPIO_ACTIVE_LOW>;
 		wp-gpios = <&gpio TEGRA_GPIO(H, 1) GPIO_ACTIVE_HIGH>;
@@ -493,7 +493,7 @@
 		bus-width = <4>;
 	};
 
-	sdhci@c8000600 {
+	mmc@c8000600 {
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
diff --git a/arch/arm/dts/tegra20-plutux.dts b/arch/arm/dts/tegra20-plutux.dts
index 1b642be9928..8d8672da23d 100644
--- a/arch/arm/dts/tegra20-plutux.dts
+++ b/arch/arm/dts/tegra20-plutux.dts
@@ -12,7 +12,7 @@
 
 	aliases {
 		usb0 = "/usb@c5008000";
-		mmc0 = "/sdhci@c8000600";
+		mmc0 = "/mmc@c8000600";
 	};
 
 	memory {
diff --git a/arch/arm/dts/tegra20-samsung-bose.dts b/arch/arm/dts/tegra20-samsung-bose.dts
index 5bb9a33adf2..64cf8489707 100644
--- a/arch/arm/dts/tegra20-samsung-bose.dts
+++ b/arch/arm/dts/tegra20-samsung-bose.dts
@@ -92,7 +92,7 @@
 		};
 	};
 
-	sdhci@c8000400 {
+	mmc@c8000400 {
 		broken-cd;
 	};
 
diff --git a/arch/arm/dts/tegra20-samsung-n1-common.dtsi b/arch/arm/dts/tegra20-samsung-n1-common.dtsi
index 7225047caba..b82e6464248 100644
--- a/arch/arm/dts/tegra20-samsung-n1-common.dtsi
+++ b/arch/arm/dts/tegra20-samsung-n1-common.dtsi
@@ -365,7 +365,7 @@
 		vbus-supply = <&usb_phy_reg>;
 	};
 
-	sdmmc3: sdhci@c8000400 {
+	sdmmc3: mmc@c8000400 {
 		status = "okay";
 		bus-width = <4>;
 
@@ -373,7 +373,7 @@
 		vqmmc-supply = <&vdd_3v3_sys>;
 	};
 
-	sdmmc4: sdhci@c8000600 {
+	sdmmc4: mmc@c8000600 {
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
diff --git a/arch/arm/dts/tegra20-samsung-n1.dts b/arch/arm/dts/tegra20-samsung-n1.dts
index 930a3195aa0..82b337973b9 100644
--- a/arch/arm/dts/tegra20-samsung-n1.dts
+++ b/arch/arm/dts/tegra20-samsung-n1.dts
@@ -151,7 +151,7 @@
 		};
 	};
 
-	sdhci@c8000400 {
+	mmc@c8000400 {
 		/* battery blocks the sdcard slot and the device lacks CD pin */
 		non-removable;
 	};
diff --git a/arch/arm/dts/tegra20-seaboard.dts b/arch/arm/dts/tegra20-seaboard.dts
index 341c7f35836..dbb2e49962e 100644
--- a/arch/arm/dts/tegra20-seaboard.dts
+++ b/arch/arm/dts/tegra20-seaboard.dts
@@ -19,8 +19,8 @@
 		rtc0 = "/i2c@7000d000/tps6586x@34";
 		rtc1 = "/rtc@7000e000";
 		serial0 = &uartd;
-		mmc0 = "/sdhci@c8000600";
-		mmc1 = "/sdhci@c8000400";
+		mmc0 = "/mmc@c8000600";
+		mmc1 = "/mmc@c8000400";
 	};
 
 	chosen {
@@ -803,14 +803,14 @@
 		status = "okay";
 	};
 
-	sdhci@c8000000 {
+	mmc@c8000000 {
 		status = "okay";
 		power-gpios = <&gpio TEGRA_GPIO(K, 6) GPIO_ACTIVE_HIGH>;
 		bus-width = <4>;
 		keep-power-in-suspend;
 	};
 
-	sdhci@c8000400 {
+	mmc@c8000400 {
 		status = "okay";
 		cd-gpios = <&gpio TEGRA_GPIO(I, 5) GPIO_ACTIVE_LOW>;
 		wp-gpios = <&gpio TEGRA_GPIO(H, 1) GPIO_ACTIVE_HIGH>;
@@ -818,7 +818,7 @@
 		bus-width = <4>;
 	};
 
-	sdhci@c8000600 {
+	mmc@c8000600 {
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
diff --git a/arch/arm/dts/tegra20-tamonten.dtsi b/arch/arm/dts/tegra20-tamonten.dtsi
index f13ef4d05a8..98fa51bed30 100644
--- a/arch/arm/dts/tegra20-tamonten.dtsi
+++ b/arch/arm/dts/tegra20-tamonten.dtsi
@@ -476,7 +476,7 @@
 		status = "okay";
 	};
 
-	sdhci@c8000600 {
+	mmc@c8000600 {
 		cd-gpios = <&gpio TEGRA_GPIO(H, 2) GPIO_ACTIVE_LOW>;
 		wp-gpios = <&gpio TEGRA_GPIO(H, 3) GPIO_ACTIVE_HIGH>;
 		bus-width = <4>;
diff --git a/arch/arm/dts/tegra20-tec.dts b/arch/arm/dts/tegra20-tec.dts
index 4733c813490..b26979496c6 100644
--- a/arch/arm/dts/tegra20-tec.dts
+++ b/arch/arm/dts/tegra20-tec.dts
@@ -12,7 +12,7 @@
 
 	aliases {
 		usb0 = "/usb@c5008000";
-		mmc0 = "/sdhci@c8000600";
+		mmc0 = "/mmc@c8000600";
 	};
 
 	memory {
diff --git a/arch/arm/dts/tegra20-trimslice.dts b/arch/arm/dts/tegra20-trimslice.dts
index fa942d26078..9542eb6c41b 100644
--- a/arch/arm/dts/tegra20-trimslice.dts
+++ b/arch/arm/dts/tegra20-trimslice.dts
@@ -12,8 +12,8 @@
 
 	aliases {
 		usb0 = "/usb@c5000000";
-		mmc0 = "/sdhci@c8000600";
-		mmc1 = "/sdhci@c8000000";
+		mmc0 = "/mmc@c8000600";
+		mmc1 = "/mmc@c8000000";
 		spi0 = "/spi@7000c380";
 	};
 
@@ -55,12 +55,12 @@
 		nvidia,vbus-gpio = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_HIGH>;
 	};
 
-	sdhci@c8000000 {
+	mmc@c8000000 {
 		status = "okay";
 		bus-width = <4>;
 	};
 
-	sdhci@c8000600 {
+	mmc@c8000600 {
 		status = "okay";
 		cd-gpios = <&gpio TEGRA_GPIO(P, 1) GPIO_ACTIVE_LOW>;
 		wp-gpios = <&gpio TEGRA_GPIO(P, 2) GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/dts/tegra20-ventana.dts b/arch/arm/dts/tegra20-ventana.dts
index 85cd1e39bda..50cf78e4170 100644
--- a/arch/arm/dts/tegra20-ventana.dts
+++ b/arch/arm/dts/tegra20-ventana.dts
@@ -18,8 +18,8 @@
 		usb0 = "/usb@c5000000";
 		usb1 = "/usb@c5004000";
 		usb2 = "/usb@c5008000";
-		mmc0 = "/sdhci@c8000600";
-		mmc1 = "/sdhci@c8000400";
+		mmc0 = "/mmc@c8000600";
+		mmc1 = "/mmc@c8000400";
 	};
 
 	memory {
@@ -576,14 +576,14 @@
 		status = "okay";
 	};
 
-	sdhci@c8000000 {
+	mmc@c8000000 {
 		status = "okay";
 		power-gpios = <&gpio TEGRA_GPIO(K, 6) GPIO_ACTIVE_HIGH>;
 		bus-width = <4>;
 		keep-power-in-suspend;
 	};
 
-	sdhci@c8000400 {
+	mmc@c8000400 {
 		status = "okay";
 		cd-gpios = <&gpio TEGRA_GPIO(I, 5) GPIO_ACTIVE_LOW>;
 		wp-gpios = <&gpio TEGRA_GPIO(H, 1) GPIO_ACTIVE_HIGH>;
@@ -591,7 +591,7 @@
 		bus-width = <4>;
 	};
 
-	sdhci@c8000600 {
+	mmc@c8000600 {
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
diff --git a/arch/arm/dts/tegra20.dtsi b/arch/arm/dts/tegra20.dtsi
index 4a40edfdfbe..430df19b8b7 100644
--- a/arch/arm/dts/tegra20.dtsi
+++ b/arch/arm/dts/tegra20.dtsi
@@ -766,7 +766,7 @@
 		status = "disabled";
 	};
 
-	sdhci@c8000000 {
+	mmc@c8000000 {
 		compatible = "nvidia,tegra20-sdhci";
 		reg = <0xc8000000 0x200>;
 		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
@@ -776,7 +776,7 @@
 		status = "disabled";
 	};
 
-	sdhci@c8000200 {
+	mmc@c8000200 {
 		compatible = "nvidia,tegra20-sdhci";
 		reg = <0xc8000200 0x200>;
 		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
@@ -786,7 +786,7 @@
 		status = "disabled";
 	};
 
-	sdhci@c8000400 {
+	mmc@c8000400 {
 		compatible = "nvidia,tegra20-sdhci";
 		reg = <0xc8000400 0x200>;
 		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
@@ -796,7 +796,7 @@
 		status = "disabled";
 	};
 
-	sdhci@c8000600 {
+	mmc@c8000600 {
 		compatible = "nvidia,tegra20-sdhci";
 		reg = <0xc8000600 0x200>;
 		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/dts/tegra210-p2371-0000.dts b/arch/arm/dts/tegra210-p2371-0000.dts
index 539e7cef93b..e5e9d68651a 100644
--- a/arch/arm/dts/tegra210-p2371-0000.dts
+++ b/arch/arm/dts/tegra210-p2371-0000.dts
@@ -12,8 +12,8 @@
 
 	aliases {
 		i2c0 = "/i2c@7000d000";
-		mmc0 = "/sdhci@700b0600";
-		mmc1 = "/sdhci@700b0000";
+		mmc0 = "/mmc@700b0600";
+		mmc1 = "/mmc@700b0000";
 		usb0 = "/usb@7d000000";
 	};
 
@@ -21,14 +21,14 @@
 		reg = <0x0 0x80000000 0x0 0xc0000000>;
 	};
 
-	sdhci@700b0000 {
+	mmc@700b0000 {
 		status = "okay";
 		cd-gpios = <&gpio TEGRA_GPIO(Z, 1) GPIO_ACTIVE_LOW>;
 		power-gpios = <&gpio TEGRA_GPIO(Z, 4) GPIO_ACTIVE_HIGH>;
 		bus-width = <4>;
 	};
 
-	sdhci@700b0600 {
+	mmc@700b0600 {
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
diff --git a/arch/arm/dts/tegra210-p2371-2180.dts b/arch/arm/dts/tegra210-p2371-2180.dts
index 649c163152e..a619b2475eb 100644
--- a/arch/arm/dts/tegra210-p2371-2180.dts
+++ b/arch/arm/dts/tegra210-p2371-2180.dts
@@ -14,8 +14,8 @@
 		i2c0 = "/i2c@7000d000";
 		i2c2 = "/i2c@7000c400";
 		i2c3 = "/i2c@7000c500";
-		mmc0 = "/sdhci@700b0600";
-		mmc1 = "/sdhci@700b0000";
+		mmc0 = "/mmc@700b0600";
+		mmc1 = "/mmc@700b0000";
 		usb0 = "/usb@7d000000";
 	};
 
@@ -73,7 +73,7 @@
 		};
 	};
 
-	sdhci@700b0000 {
+	mmc@700b0000 {
 		status = "okay";
 		cd-gpios = <&gpio TEGRA_GPIO(Z, 1) GPIO_ACTIVE_LOW>;
 		power-gpios = <&gpio TEGRA_GPIO(Z, 3) GPIO_ACTIVE_HIGH>;
@@ -81,7 +81,7 @@
 		bus-width = <4>;
 	};
 
-	sdhci@700b0600 {
+	mmc@700b0600 {
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
diff --git a/arch/arm/dts/tegra210-p2571.dts b/arch/arm/dts/tegra210-p2571.dts
index 16370c596e0..f48ce4d662f 100644
--- a/arch/arm/dts/tegra210-p2571.dts
+++ b/arch/arm/dts/tegra210-p2571.dts
@@ -17,8 +17,8 @@
 		i2c3 = "/i2c@7000c500";
 		i2c4 = "/i2c@7000c700";
 		i2c5 = "/i2c@7000d100";
-		mmc0 = "/sdhci@700b0600";
-		mmc1 = "/sdhci@700b0000";
+		mmc0 = "/mmc@700b0600";
+		mmc1 = "/mmc@700b0000";
 		spi0 = "/spi@7000d400";
 		spi1 = "/spi@7000da00";
 		spi2 = "/spi@70410000";
@@ -74,14 +74,14 @@
 		spi-max-frequency = <24000000>;
 	};
 
-	sdhci@700b0000 {
+	mmc@700b0000 {
 		status = "okay";
 		cd-gpios = <&gpio TEGRA_GPIO(Z, 1) GPIO_ACTIVE_LOW>;
 		power-gpios = <&gpio TEGRA_GPIO(Z, 4) GPIO_ACTIVE_HIGH>;
 		bus-width = <4>;
 	};
 
-	sdhci@700b0600 {
+	mmc@700b0600 {
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
diff --git a/arch/arm/dts/tegra210-p3450-0000.dts b/arch/arm/dts/tegra210-p3450-0000.dts
index ddeeb232de2..333060a4ec7 100644
--- a/arch/arm/dts/tegra210-p3450-0000.dts
+++ b/arch/arm/dts/tegra210-p3450-0000.dts
@@ -20,8 +20,8 @@
 		i2c2 = "/i2c@7000c400";
 		i2c3 = "/i2c@7000c500";
 		i2c4 = "/i2c@7000c700";
-		mmc0 = "/sdhci@700b0600";
-		mmc1 = "/sdhci@700b0000";
+		mmc0 = "/mmc@700b0600";
+		mmc1 = "/mmc@700b0000";
 		spi0 = "/spi@70410000";
 		usb0 = "/usb@7d000000";
 	};
@@ -89,14 +89,14 @@
 		};
 	};
 
-	sdhci@700b0000 {
+	mmc@700b0000 {
 		status = "okay";
 		cd-gpios = <&gpio TEGRA_GPIO(Z, 1) GPIO_ACTIVE_LOW>;
 		power-gpios = <&gpio TEGRA_GPIO(Z, 3) GPIO_ACTIVE_HIGH>;
 		bus-width = <4>;
 	};
 
-	sdhci@700b0600 {
+	mmc@700b0600 {
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
diff --git a/arch/arm/dts/tegra210.dtsi b/arch/arm/dts/tegra210.dtsi
index 92eb4f67bf5..45b1ca9a041 100644
--- a/arch/arm/dts/tegra210.dtsi
+++ b/arch/arm/dts/tegra210.dtsi
@@ -696,7 +696,7 @@
 		#phy-cells = <1>;
 	};
 
-	sdhci@700b0000 {
+	mmc@700b0000 {
 		compatible = "nvidia,tegra210-sdhci", "nvidia,tegra124-sdhci";
 		reg = <0x0 0x700b0000 0x0 0x200>;
 		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
@@ -709,7 +709,7 @@
 		status = "disabled";
 	};
 
-	sdhci@700b0200 {
+	mmc@700b0200 {
 		compatible = "nvidia,tegra210-sdhci", "nvidia,tegra124-sdhci";
 		reg = <0x0 0x700b0200 0x0 0x200>;
 		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
@@ -722,7 +722,7 @@
 		status = "disabled";
 	};
 
-	sdhci@700b0400 {
+	mmc@700b0400 {
 		compatible = "nvidia,tegra210-sdhci", "nvidia,tegra124-sdhci";
 		reg = <0x0 0x700b0400 0x0 0x200>;
 		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
@@ -735,7 +735,7 @@
 		status = "disabled";
 	};
 
-	sdhci@700b0600 {
+	mmc@700b0600 {
 		compatible = "nvidia,tegra210-sdhci", "nvidia,tegra124-sdhci";
 		reg = <0x0 0x700b0600 0x0 0x200>;
 		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/dts/tegra30-apalis.dts b/arch/arm/dts/tegra30-apalis.dts
index 77502dfdb47..19553d14fb1 100644
--- a/arch/arm/dts/tegra30-apalis.dts
+++ b/arch/arm/dts/tegra30-apalis.dts
@@ -15,9 +15,9 @@
 		i2c1 = "/i2c@7000c000";
 		i2c2 = "/i2c@7000c500";
 		i2c3 = "/i2c@7000c700";
-		mmc0 = "/sdhci@78000600";
-		mmc1 = "/sdhci@78000400";
-		mmc2 = "/sdhci@78000000";
+		mmc0 = "/mmc@78000600";
+		mmc1 = "/mmc@78000400";
+		mmc2 = "/mmc@78000000";
 		spi0 = "/spi@7000d400";
 		spi1 = "/spi@7000dc00";
 		spi2 = "/spi@7000de00";
@@ -246,21 +246,21 @@
 		spi-max-frequency = <25000000>;
 	};
 
-	sdhci@78000000 {
+	mmc@78000000 {
 		status = "okay";
 		bus-width = <4>;
 		/* SD1_CD# */
 		cd-gpios = <&gpio TEGRA_GPIO(CC, 5) GPIO_ACTIVE_LOW>;
 	};
 
-	sdhci@78000400 {
+	mmc@78000400 {
 		status = "okay";
 		bus-width = <8>;
 		/* MMC1_CD# */
 		cd-gpios = <&gpio TEGRA_GPIO(V, 3) GPIO_ACTIVE_LOW>;
 	};
 
-	sdhci@78000600 {
+	mmc@78000600 {
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
diff --git a/arch/arm/dts/tegra30-asus-grouper-common.dtsi b/arch/arm/dts/tegra30-asus-grouper-common.dtsi
index ddacdbb85c8..8eb36eb8164 100644
--- a/arch/arm/dts/tegra30-asus-grouper-common.dtsi
+++ b/arch/arm/dts/tegra30-asus-grouper-common.dtsi
@@ -773,7 +773,7 @@
 		clock-frequency = <400000>;
 	};
 
-	sdmmc4: sdhci@78000600 {
+	sdmmc4: mmc@78000600 {
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
diff --git a/arch/arm/dts/tegra30-asus-p1801-t.dts b/arch/arm/dts/tegra30-asus-p1801-t.dts
index 31cbef1b93c..2d6b4aba016 100644
--- a/arch/arm/dts/tegra30-asus-p1801-t.dts
+++ b/arch/arm/dts/tegra30-asus-p1801-t.dts
@@ -1100,7 +1100,7 @@
 		};
 	};
 
-	sdmmc1: sdhci@78000000 {
+	sdmmc1: mmc@78000000 {
 		status = "okay";
 		bus-width = <4>;
 
@@ -1111,7 +1111,7 @@
 		vqmmc-supply = <&vddio_usd>;
 	};
 
-	sdmmc4: sdhci@78000600 {
+	sdmmc4: mmc@78000600 {
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
diff --git a/arch/arm/dts/tegra30-asus-tf600t.dts b/arch/arm/dts/tegra30-asus-tf600t.dts
index e622ba78d2e..51d82f942f4 100644
--- a/arch/arm/dts/tegra30-asus-tf600t.dts
+++ b/arch/arm/dts/tegra30-asus-tf600t.dts
@@ -1064,7 +1064,7 @@
 		};
 	};
 
-	sdmmc1: sdhci@78000000 {
+	sdmmc1: mmc@78000000 {
 		status = "okay";
 		bus-width = <4>;
 
@@ -1075,7 +1075,7 @@
 		vqmmc-supply = <&vddio_usd>;
 	};
 
-	sdmmc4: sdhci@78000600 {
+	sdmmc4: mmc@78000600 {
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
diff --git a/arch/arm/dts/tegra30-asus-transformer.dtsi b/arch/arm/dts/tegra30-asus-transformer.dtsi
index c2a9e04901d..6bb24ea62e9 100644
--- a/arch/arm/dts/tegra30-asus-transformer.dtsi
+++ b/arch/arm/dts/tegra30-asus-transformer.dtsi
@@ -1093,7 +1093,7 @@
 		};
 	};
 
-	sdmmc1: sdhci@78000000 {
+	sdmmc1: mmc@78000000 {
 		status = "okay";
 		bus-width = <4>;
 
@@ -1104,7 +1104,7 @@
 		vqmmc-supply = <&vddio_usd>;
 	};
 
-	sdmmc4: sdhci@78000600 {
+	sdmmc4: mmc@78000600 {
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
diff --git a/arch/arm/dts/tegra30-beaver.dts b/arch/arm/dts/tegra30-beaver.dts
index 9bb097b0813..b78982edd1a 100644
--- a/arch/arm/dts/tegra30-beaver.dts
+++ b/arch/arm/dts/tegra30-beaver.dts
@@ -16,8 +16,8 @@
 		i2c2 = "/i2c@7000c400";
 		i2c3 = "/i2c@7000c500";
 		i2c4 = "/i2c@7000c700";
-		mmc0 = "/sdhci@78000600";
-		mmc1 = "/sdhci@78000000";
+		mmc0 = "/mmc@78000600";
+		mmc1 = "/mmc@78000000";
 		spi0 = "/spi@7000da00";
 		usb0 = "/usb@7d000000";
 		usb1 = "/usb@7d008000";
@@ -191,7 +191,7 @@
 		};
 	};
 
-	sdhci@78000000 {
+	mmc@78000000 {
 		status = "okay";
 		cd-gpios = <&gpio TEGRA_GPIO(I, 5) GPIO_ACTIVE_LOW>;
 		wp-gpios = <&gpio TEGRA_GPIO(T, 3) GPIO_ACTIVE_HIGH>;
@@ -199,7 +199,7 @@
 		bus-width = <4>;
 	};
 
-	sdhci@78000600 {
+	mmc@78000600 {
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
diff --git a/arch/arm/dts/tegra30-cardhu.dts b/arch/arm/dts/tegra30-cardhu.dts
index 7534861e40d..299ba7ef371 100644
--- a/arch/arm/dts/tegra30-cardhu.dts
+++ b/arch/arm/dts/tegra30-cardhu.dts
@@ -16,8 +16,8 @@
 		i2c2 = "/i2c@7000c400";
 		i2c3 = "/i2c@7000c500";
 		i2c4 = "/i2c@7000c700";
-		mmc0 = "/sdhci@78000600";
-		mmc1 = "/sdhci@78000000";
+		mmc0 = "/mmc@78000600";
+		mmc1 = "/mmc@78000000";
 		spi0 = "/spi@7000da00";
 		usb0 = "/usb@7d008000";
 	};
@@ -183,7 +183,7 @@
 		spi-max-frequency = <25000000>;
 	};
 
-	sdhci@78000000 {
+	mmc@78000000 {
 		status = "okay";
 		cd-gpios = <&gpio TEGRA_GPIO(I, 5) GPIO_ACTIVE_LOW>;
 		wp-gpios = <&gpio TEGRA_GPIO(T, 3) GPIO_ACTIVE_HIGH>;
@@ -191,7 +191,7 @@
 		bus-width = <4>;
 	};
 
-	sdhci@78000600 {
+	mmc@78000600 {
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
diff --git a/arch/arm/dts/tegra30-colibri.dts b/arch/arm/dts/tegra30-colibri.dts
index 38afe7819c7..075a35f1c9a 100644
--- a/arch/arm/dts/tegra30-colibri.dts
+++ b/arch/arm/dts/tegra30-colibri.dts
@@ -14,8 +14,8 @@
 		i2c0 = "/i2c@7000d000";
 		i2c1 = "/i2c@7000c000";
 		i2c2 = "/i2c@7000c700";
-		mmc0 = "/sdhci@78000600";
-		mmc1 = "/sdhci@78000200";
+		mmc0 = "/mmc@78000600";
+		mmc1 = "/mmc@78000200";
 		spi0 = "/spi@7000d400";
 		usb0 = "/usb@7d000000";
 		usb1 = "/usb@7d004000"; /* on module only, for ASIX */
@@ -61,13 +61,13 @@
 		spi-max-frequency = <25000000>;
 	};
 
-	sdhci@78000200 {
+	mmc@78000200 {
 		status = "okay";
 		bus-width = <4>;
 		cd-gpios = <&gpio TEGRA_GPIO(C, 7) GPIO_ACTIVE_LOW>; /* MMCD */
 	};
 
-	sdhci@78000600 {
+	mmc@78000600 {
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
diff --git a/arch/arm/dts/tegra30-htc-endeavoru.dts b/arch/arm/dts/tegra30-htc-endeavoru.dts
index 79f423bd22a..e67d335f73c 100644
--- a/arch/arm/dts/tegra30-htc-endeavoru.dts
+++ b/arch/arm/dts/tegra30-htc-endeavoru.dts
@@ -1246,7 +1246,7 @@
 		};
 	};
 
-	sdmmc4: sdhci@78000600 {
+	sdmmc4: mmc@78000600 {
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
diff --git a/arch/arm/dts/tegra30-lenovo-ideapad-yoga-11.dts b/arch/arm/dts/tegra30-lenovo-ideapad-yoga-11.dts
index 53f42089d30..2d96d6867e6 100644
--- a/arch/arm/dts/tegra30-lenovo-ideapad-yoga-11.dts
+++ b/arch/arm/dts/tegra30-lenovo-ideapad-yoga-11.dts
@@ -1119,7 +1119,7 @@
 		>;
 	};
 
-	sdmmc1: sdhci@78000000 {
+	sdmmc1: mmc@78000000 {
 		status = "okay";
 		bus-width = <4>;
 
@@ -1129,7 +1129,7 @@
 		vqmmc-supply = <&vddio_usd>;
 	};
 
-	sdmmc4: sdhci@78000600 {
+	sdmmc4: mmc@78000600 {
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
diff --git a/arch/arm/dts/tegra30-lg-p880.dts b/arch/arm/dts/tegra30-lg-p880.dts
index ab5993150b2..84b6dc1f95a 100644
--- a/arch/arm/dts/tegra30-lg-p880.dts
+++ b/arch/arm/dts/tegra30-lg-p880.dts
@@ -126,7 +126,7 @@
 		};
 	};
 
-	sdmmc3: sdhci@78000400  {
+	sdmmc3: mmc@78000400  {
 		status = "okay";
 		bus-width = <4>;
 
diff --git a/arch/arm/dts/tegra30-lg-x3.dtsi b/arch/arm/dts/tegra30-lg-x3.dtsi
index e5effe132b0..6e1e25b7cfa 100644
--- a/arch/arm/dts/tegra30-lg-x3.dtsi
+++ b/arch/arm/dts/tegra30-lg-x3.dtsi
@@ -1037,7 +1037,7 @@
 		};
 	};
 
-	sdmmc4: sdhci@78000600 {
+	sdmmc4: mmc@78000600 {
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
diff --git a/arch/arm/dts/tegra30-microsoft-surface-rt.dts b/arch/arm/dts/tegra30-microsoft-surface-rt.dts
index 2d22d3e0bb1..77cd79cb0d6 100644
--- a/arch/arm/dts/tegra30-microsoft-surface-rt.dts
+++ b/arch/arm/dts/tegra30-microsoft-surface-rt.dts
@@ -946,7 +946,7 @@
 		};
 	};
 
-	sdmmc1: sdhci@78000000 {
+	sdmmc1: mmc@78000000 {
 		status = "okay";
 		bus-width = <4>;
 
@@ -956,7 +956,7 @@
 		vqmmc-supply = <&vddio_usd>;
 	};
 
-	sdmmc4: sdhci@78000600 {
+	sdmmc4: mmc@78000600 {
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
diff --git a/arch/arm/dts/tegra30-ouya.dts b/arch/arm/dts/tegra30-ouya.dts
index e6b2824d783..4911c802a51 100644
--- a/arch/arm/dts/tegra30-ouya.dts
+++ b/arch/arm/dts/tegra30-ouya.dts
@@ -1970,7 +1970,7 @@
 		};
 	};
 
-	sdmmc4: sdhci@78000600 {
+	sdmmc4: mmc@78000600 {
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
diff --git a/arch/arm/dts/tegra30-pegatron-chagall.dts b/arch/arm/dts/tegra30-pegatron-chagall.dts
index 98eb369f7a8..1ff53b7c54b 100644
--- a/arch/arm/dts/tegra30-pegatron-chagall.dts
+++ b/arch/arm/dts/tegra30-pegatron-chagall.dts
@@ -1121,7 +1121,7 @@
 		};
 	};
 
-	sdmmc1: sdhci@78000000 {
+	sdmmc1: mmc@78000000 {
 		status = "okay";
 		bus-width = <4>;
 
@@ -1131,7 +1131,7 @@
 		vqmmc-supply = <&vddio_usd>;
 	};
 
-	sdmmc4: sdhci@78000600 {
+	sdmmc4: mmc@78000600 {
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
diff --git a/arch/arm/dts/tegra30-tamonten.dtsi b/arch/arm/dts/tegra30-tamonten.dtsi
index 33da1754d30..0240568cd94 100644
--- a/arch/arm/dts/tegra30-tamonten.dtsi
+++ b/arch/arm/dts/tegra30-tamonten.dtsi
@@ -18,9 +18,9 @@
 		i2c2 = "/i2c@7000c400";
 		i2c3 = "/i2c@7000c500";
 		i2c4 = "/i2c@7000d000";
-		mmc0 = "/sdhci@78000600";
-		mmc1 = "/sdhci@78000400";
-		mmc2 = "/sdhci@78000000";
+		mmc0 = "/mmc@78000600";
+		mmc1 = "/mmc@78000400";
+		mmc2 = "/mmc@78000000";
 		usb0 = "/usb@7d008000";
 	};
 
@@ -54,14 +54,14 @@
 	};
 
 	/* SD slot on the base board */
-	sdhci@78000400 {
+	mmc@78000400 {
 		cd-gpios = <&gpio TEGRA_GPIO(I, 5) GPIO_ACTIVE_LOW>;
 		wp-gpios = <&gpio TEGRA_GPIO(I, 3) GPIO_ACTIVE_HIGH>;
 		bus-width = <4>;
 	};
 
 	/* EMMC on the COM module */
-	sdhci@78000600 {
+	mmc@78000600 {
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
diff --git a/arch/arm/dts/tegra30-tec-ng.dts b/arch/arm/dts/tegra30-tec-ng.dts
index f2a49b8cbe2..444a390ba58 100644
--- a/arch/arm/dts/tegra30-tec-ng.dts
+++ b/arch/arm/dts/tegra30-tec-ng.dts
@@ -16,7 +16,7 @@
 	};
 
 	/* SD card slot */
-	sdhci@78000400 {
+	mmc@78000400 {
 		status = "okay";
 	};
 };
diff --git a/arch/arm/dts/tegra30-wexler-qc750.dts b/arch/arm/dts/tegra30-wexler-qc750.dts
index ededbf579fd..c310a22f56f 100644
--- a/arch/arm/dts/tegra30-wexler-qc750.dts
+++ b/arch/arm/dts/tegra30-wexler-qc750.dts
@@ -985,7 +985,7 @@
 		};
 	};
 
-	sdmmc1: sdhci@78000000 {
+	sdmmc1: mmc@78000000 {
 		status = "okay";
 		bus-width = <4>;
 
@@ -996,7 +996,7 @@
 		vqmmc-supply = <&vddio_usd>;
 	};
 
-	sdmmc4: sdhci@78000600 {
+	sdmmc4: mmc@78000600 {
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
diff --git a/arch/arm/dts/tegra30.dtsi b/arch/arm/dts/tegra30.dtsi
index 82e843d05be..cf772338b55 100644
--- a/arch/arm/dts/tegra30.dtsi
+++ b/arch/arm/dts/tegra30.dtsi
@@ -803,7 +803,7 @@
 		};
 	};
 
-	sdhci@78000000 {
+	mmc@78000000 {
 		compatible = "nvidia,tegra30-sdhci", "nvidia,tegra20-sdhci";
 		reg = <0x78000000 0x200>;
 		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
@@ -813,7 +813,7 @@
 		status = "disabled";
 	};
 
-	sdhci@78000200 {
+	mmc@78000200 {
 		compatible = "nvidia,tegra30-sdhci", "nvidia,tegra20-sdhci";
 		reg = <0x78000200 0x200>;
 		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
@@ -823,7 +823,7 @@
 		status = "disabled";
 	};
 
-	sdhci@78000400 {
+	mmc@78000400 {
 		compatible = "nvidia,tegra30-sdhci", "nvidia,tegra20-sdhci";
 		reg = <0x78000400 0x200>;
 		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
@@ -833,7 +833,7 @@
 		status = "disabled";
 	};
 
-	sdhci@78000600 {
+	mmc@78000600 {
 		compatible = "nvidia,tegra30-sdhci", "nvidia,tegra20-sdhci";
 		reg = <0x78000600 0x200>;
 		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.51.0

