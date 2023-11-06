Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 983BEC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 08:36:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55D3A842D0;
	Mon,  6 Nov 2023 09:33:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XCCEVRuF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A81F86F84; Mon,  6 Nov 2023 09:33:09 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4426486F89
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 09:32:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-9dd6dc9c00cso346592566b.3
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 00:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699259578; x=1699864378; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VoNJAJGuuHef30IP55wR11RrI2/yqH6RM95MIefMfls=;
 b=XCCEVRuFN7mjdGeFTBxtVW1XXld0mjMdu7JSIiYmpijgFyePjdkfATtFu+lHe9Q6ls
 4B8yyK5VTjLO022ezXlPCT+bBOGrpa03VOUpTKR03kCUA8WEUbAdbUynwf3nzHaCXk3y
 lQl5iBGh22Klqxn3nuwIRbJbP33EeIEEg2Ibf0SmAL/JHOBNe38+JjKacAMoOHFazZiJ
 /9bMzufQeikdW8pf/r34ummqxRKWQFXe8P/iX/qCIGWnBNddF2F1j875U8wMt26MsA08
 X1MK6iNV374hgWCpsxnDQHH9LNKrUW9tLO9XahI95zy+oaWlnJskcwaKkVpCJ/hxqQ0R
 7PBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699259578; x=1699864378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VoNJAJGuuHef30IP55wR11RrI2/yqH6RM95MIefMfls=;
 b=Vbj2epWPuvvqdwfuV2ZydzDUdrePehFcDFQcHjbXt2nF6bpc2QsrIxFqPtwsTSmFQ1
 eVYS3W30xPdEjfM1IBv4APe4+PkIpwA9/Zs48Cl7MHoN55P3XcBO+UT/kE/DIyea1fRg
 IqgCJ2eeLfX5CUEMThOcvOIUlOThjnBc0zkeeNm/oZC9wC5qIoD0U7sOQfK+z1osddul
 ZfIxyI0sCDHX9W2NSr7gIq4l6MhJvXi2Q0onU9UZbur2F4CYX03o3MBVAWdxUQhBJSlE
 AztuGPfHkqRRgUx+KcLIDjt2PLkQiMEGer14PQzS1uhcVWIAG5EzY4gHf8ieVAVrxCm9
 +93w==
X-Gm-Message-State: AOJu0YwGr8bVtoM5rWe0QhhJ+UYAaJjPhu1L6q8pUx/yJ6rcJz29J9tJ
 /XLc7XnSg5BJuC0s64w3F9lB13eoHb4=
X-Google-Smtp-Source: AGHT+IF1f4IizcAKRjzVEHEo8fxD/CicZJOjnZeyIwNKl/eu5m+0dIGEz2rtwv3cX4hA9RkubBPSqg==
X-Received: by 2002:a17:907:d502:b0:9db:e46c:569 with SMTP id
 wb2-20020a170907d50200b009dbe46c0569mr8605324ejc.45.1699259577791; 
 Mon, 06 Nov 2023 00:32:57 -0800 (PST)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 t21-20020a170906269500b009a1a653770bsm3799715ejc.87.2023.11.06.00.32.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 00:32:57 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 5/5] ARM: dts: tegra30: enable USB PHY node on some devices
Date: Mon,  6 Nov 2023 10:32:29 +0200
Message-Id: <20231106083229.256322-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231106083229.256322-1-clamor95@gmail.com>
References: <20231106083229.256322-1-clamor95@gmail.com>
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

Enable USB PHY nodes on ASUS Transformers, Grouper, Enadevoru
and LG X3. This is not mandatory since driver will use default
values but preferable for new devices.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/tegra30-asus-grouper-common.dtsi |  7 +++++++
 arch/arm/dts/tegra30-asus-p1801-t.dts         | 15 +++++++++++++++
 arch/arm/dts/tegra30-asus-tf600t.dts          | 11 +++++++++++
 arch/arm/dts/tegra30-asus-transformer.dtsi    |  7 +++++++
 arch/arm/dts/tegra30-htc-endeavoru.dts        |  7 +++++++
 arch/arm/dts/tegra30-lg-x3.dtsi               |  8 ++++++++
 6 files changed, 55 insertions(+)

diff --git a/arch/arm/dts/tegra30-asus-grouper-common.dtsi b/arch/arm/dts/tegra30-asus-grouper-common.dtsi
index fcf31e2dd0..c9277388c9 100644
--- a/arch/arm/dts/tegra30-asus-grouper-common.dtsi
+++ b/arch/arm/dts/tegra30-asus-grouper-common.dtsi
@@ -71,6 +71,13 @@
 		dr_mode = "otg";
 	};
 
+	usb-phy@7d000000 {
+		status = "okay";
+		nvidia,hssync-start-delay = <0>;
+		nvidia,xcvr-lsfslew = <2>;
+		nvidia,xcvr-lsrslew = <2>;
+	};
+
 	backlight: backlight {
 		compatible = "pwm-backlight";
 
diff --git a/arch/arm/dts/tegra30-asus-p1801-t.dts b/arch/arm/dts/tegra30-asus-p1801-t.dts
index d62d43268b..19de984d5f 100644
--- a/arch/arm/dts/tegra30-asus-p1801-t.dts
+++ b/arch/arm/dts/tegra30-asus-p1801-t.dts
@@ -150,17 +150,32 @@
 		dr_mode = "otg";
 	};
 
+	usb-phy@7d000000 {
+		status = "okay";
+		nvidia,hssync-start-delay = <0>;
+		nvidia,xcvr-lsfslew = <2>;
+		nvidia,xcvr-lsrslew = <2>;
+	};
+
 	/* Mini USB port */
 	usb2: usb@7d004000 {
 		status = "okay";
 		nvidia,vbus-gpio = <&gpio TEGRA_GPIO(H, 7) GPIO_ACTIVE_HIGH>;
 	};
 
+	usb-phy@7d004000 {
+		status = "okay";
+	};
+
 	/* Dock's USB port */
 	usb3: usb@7d008000 {
 		status = "okay";
 	};
 
+	usb-phy@7d008000 {
+		status = "okay";
+	};
+
 	/* PMIC has a built-in 32KHz oscillator which is used by PMC */
 	clk32k_in: clock-32k {
 		compatible = "fixed-clock";
diff --git a/arch/arm/dts/tegra30-asus-tf600t.dts b/arch/arm/dts/tegra30-asus-tf600t.dts
index efc6a83b9d..3f11d33bc4 100644
--- a/arch/arm/dts/tegra30-asus-tf600t.dts
+++ b/arch/arm/dts/tegra30-asus-tf600t.dts
@@ -165,11 +165,22 @@
 		dr_mode = "otg";
 	};
 
+	usb-phy@7d000000 {
+		status = "okay";
+		nvidia,hssync-start-delay = <0>;
+		nvidia,xcvr-lsfslew = <2>;
+		nvidia,xcvr-lsrslew = <2>;
+	};
+
 	/* Dock's USB port */
 	usb3: usb@7d008000 {
 		status = "okay";
 	};
 
+	usb-phy@7d008000 {
+		status = "okay";
+	};
+
 	backlight: backlight {
 		compatible = "pwm-backlight";
 
diff --git a/arch/arm/dts/tegra30-asus-transformer.dtsi b/arch/arm/dts/tegra30-asus-transformer.dtsi
index afddb83983..c4649eee79 100644
--- a/arch/arm/dts/tegra30-asus-transformer.dtsi
+++ b/arch/arm/dts/tegra30-asus-transformer.dtsi
@@ -131,6 +131,13 @@
 		dr_mode = "otg";
 	};
 
+	usb-phy@7d000000 {
+		status = "okay";
+		nvidia,hssync-start-delay = <0>;
+		nvidia,xcvr-lsfslew = <2>;
+		nvidia,xcvr-lsrslew = <2>;
+	};
+
 	/* Dock's USB port */
 	usb3: usb@7d008000 {
 		status = "okay";
diff --git a/arch/arm/dts/tegra30-htc-endeavoru.dts b/arch/arm/dts/tegra30-htc-endeavoru.dts
index 22320de708..21cd0f9207 100644
--- a/arch/arm/dts/tegra30-htc-endeavoru.dts
+++ b/arch/arm/dts/tegra30-htc-endeavoru.dts
@@ -101,6 +101,13 @@
 		dr_mode = "otg";
 	};
 
+	usb-phy@7d000000 {
+		status = "okay";
+		nvidia,hssync-start-delay = <0>;
+		nvidia,xcvr-lsfslew = <2>;
+		nvidia,xcvr-lsrslew = <2>;
+	};
+
 	backlight: backlight {
 		compatible = "nvidia,tegra-pwm-backlight";
 
diff --git a/arch/arm/dts/tegra30-lg-x3.dtsi b/arch/arm/dts/tegra30-lg-x3.dtsi
index aa207a70c7..01936b872e 100644
--- a/arch/arm/dts/tegra30-lg-x3.dtsi
+++ b/arch/arm/dts/tegra30-lg-x3.dtsi
@@ -153,6 +153,14 @@
 		dr_mode = "otg";
 	};
 
+	usb-phy@7d000000 {
+		status = "okay";
+		nvidia,hssync-start-delay = <0>;
+		nvidia,xcvr-lsfslew = <2>;
+		nvidia,xcvr-lsrslew = <2>;
+		vbus-supply = <&avdd_3v3_periph>;
+	};
+
 	/* PMIC has a built-in 32KHz oscillator which is used by PMC */
 	clk32k_in: clock-32k {
 		compatible = "fixed-clock";
-- 
2.40.1

