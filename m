Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD9BD7309B
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 04:52:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DABD5840B0;
	Fri,  3 Apr 2026 06:52:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RIAZU/aJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 608428408D; Thu,  2 Apr 2026 19:14:13 +0200 (CEST)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C81B83F7D
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 19:14:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jzhang918@gmail.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-8cbb6d5f780so121124085a.1
 for <u-boot@lists.denx.de>; Thu, 02 Apr 2026 10:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775150050; x=1775754850; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3sBCQC9Afuk0QIW6oH50X7J6BE7QPiz4KuoEJb7iW8M=;
 b=RIAZU/aJMUNY+IcIGv7WGxWlG1Ft5dwJOTrFcKsEcKfnoRIcZpAUc+v+4KBeoh0IZa
 CGJWuELT91kA2UZrknXZx9ewV1pXRS2B4eMRSS4rqw8J4/Uxow6Pc6B6dkoaYbVYfCVv
 ecHgMJGm0GCuns5TnRiHu6NbuwB0DqTyxuQw703JGhefAYTmojeSsf0FghkIKzF2Lkt6
 jkv6mONyHmNT6oH6jKykDAG0LywZc6xFYiBgbz2jMVqn5FuVQTB8pQrZAtE9bwKVEWKn
 f9bci8cy5W60MFYbIDYoffeW5XEB5yHzxGXXoG7u6Rdauhpu1w1tGD7n4z9/5CMYjVQa
 pZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775150050; x=1775754850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3sBCQC9Afuk0QIW6oH50X7J6BE7QPiz4KuoEJb7iW8M=;
 b=oNA+d1f0GJZsemcdEL4kSZwtxwtDXsnVG9nL3RbOMEcajmTubT6gRb+ZO1z3Dn6wzw
 sVdHPgNL9qW34EDQhO3qYYBgAwHf6Y2S6LBixsygn2swe4FngTP8tpXRZITnfNYdoVpF
 iQVLhpoVjoXXzAIPr8eVB56enE1MOlDv6sKlqGUBk7Iwp8wsfHF6It4SkDCAuU2ePFzc
 gVqqUbFfG3dXKB9EJCTM1pMmp2xuUjbXIPLWxmoZ+p47yjYcnHEm8vIoTMzdTKKZUsvp
 ThJEGeM3vYEoY45v5Cv6FPTIAJFlQDRTM7mzCZxRwSgfuMfun7sWZvtvXsYkuoUsGCCz
 4dLQ==
X-Gm-Message-State: AOJu0Yzf0Xk05+Z2fCC/pvhYjSIsOx+UgbmDWMkzCmG7MxXz4YWx/2z4
 Ki0l5ABti4NDOl8+PGhY+2536gihU5XvXXil9v1nWKZr+IbDbrOZlOlUp7LcWx38
X-Gm-Gg: AeBDievdseDAVsRrzkG1QoifT64dRbIKCv4fgHJ57zGx8954mRw7uydP1+WXLpCO5uv
 Rs8nWpSS+8u5Nr5Rpv+JgXC2FaA4SN5H50pUffinTMhTIhayRnn6bKUGspfe05zPrR7yZpBwSsL
 JmSNRzEyycBbI9uNqaFVVAgKYxN9e/q2o2Yl/KJMtYULPLCE18HQUFA4Wchs4weIR3ixgsJXvRd
 4oHJyiFLHm2utO6aEXmdGf1+4yxli6Q3L4dgEKVnN3Jch7C8P/xPxS4kIGaG3+uU3CEc3pVA7JV
 ZOJF26db54aM5D8jy4w8pifz2ghrMFNzjSQwHIVRv262GUDI/EqasTNgvTE/rHpNhGSg4xtRqbr
 Momz/jsnFmPigZYxbiZkPthvKxOu/P6Vnle98BRQiQaNaGYNu7hA3Dl/eo66ifrMlUUmQrCF95Z
 pKNp459CPnkat2nXOsQ9Sm801okEx0RV7fGsnSk9eBjnqb77+7BJWTb4J5tno7uvnS
X-Received: by 2002:a05:6214:4791:b0:896:fbdd:ef14 with SMTP id
 6a1803df08f44-8a436d1d409mr114752576d6.12.1775150049737; 
 Thu, 02 Apr 2026 10:14:09 -0700 (PDT)
Received: from P5510 (h96-61-12-172.cntcnh.broadband.dynamic.tds.net.
 [96.61.12.172]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8a5977e00b4sm27112226d6.47.2026.04.02.10.14.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 10:14:09 -0700 (PDT)
From: Jie Zhang <jzhang918@gmail.com>
To: u-boot@lists.denx.de
Cc: jzhang918@gmail.com, Jie Zhang <jie.zhang@analog.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Tom Rini <trini@konsulko.com>, Caleb Ethridge <caleb.ethridge@analog.com>,
 Ozan Durgut <ozan.durgut@analog.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>, linux@analog.com
Subject: [PATCH 1/1] arm: dts: add/fix I2C controllers for sc5xx
Date: Thu,  2 Apr 2026 13:13:16 -0400
Message-ID: <20260402171330.165754-2-jzhang918@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402171330.165754-1-jzhang918@gmail.com>
References: <20260402171330.165754-1-jzhang918@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 03 Apr 2026 06:52:30 +0200
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

From: Jie Zhang <jie.zhang@analog.com>

sc59x processors have 6 I2C controllers, but their devicetrees
currently have only 3. The length of its register block should
be 0x100 instead of 0x1000. All I2C nodes should be disabled in
sc5xx.dtsi. They can be enabled in board devicetree files if
they are used on the boards. Add missing I2C controllers and
fix the above issues.

Signed-off-by: Jie Zhang <jie.zhang@analog.com>
---
 arch/arm/dts/sc573-ezlite.dts    |  2 ++
 arch/arm/dts/sc584-ezkit.dts     |  2 ++
 arch/arm/dts/sc589-ezkit.dts     |  2 ++
 arch/arm/dts/sc594-som.dtsi      | 13 +++++++++++++
 arch/arm/dts/sc598-som-revD.dtsi |  2 ++
 arch/arm/dts/sc598-som-revE.dtsi |  2 ++
 arch/arm/dts/sc598-som.dtsi      | 12 ++++++++++++
 arch/arm/dts/sc59x.dtsi          | 30 ++++++++++++++++++++++++++++++
 arch/arm/dts/sc5xx.dtsi          | 12 ++++++------
 9 files changed, 71 insertions(+), 6 deletions(-)

diff --git a/arch/arm/dts/sc573-ezlite.dts b/arch/arm/dts/sc573-ezlite.dts
index 57604d707f7..f128c4f9697 100644
--- a/arch/arm/dts/sc573-ezlite.dts
+++ b/arch/arm/dts/sc573-ezlite.dts
@@ -14,6 +14,8 @@
 };
 
 &i2c0 {
+	status = "okay";
+
 	gpio_expander0: mcp23017@21 {
 		compatible = "microchip,mcp23017";
 		reg = <0x21>;
diff --git a/arch/arm/dts/sc584-ezkit.dts b/arch/arm/dts/sc584-ezkit.dts
index 176faa50672..3a6d60b3f29 100644
--- a/arch/arm/dts/sc584-ezkit.dts
+++ b/arch/arm/dts/sc584-ezkit.dts
@@ -13,6 +13,8 @@
 };
 
 &i2c2 {
+	status = "okay";
+
 	gpio_expander0: mcp23017@21 {
 		compatible = "microchip,mcp23017";
 		reg = <0x21>;
diff --git a/arch/arm/dts/sc589-ezkit.dts b/arch/arm/dts/sc589-ezkit.dts
index d8eb5b6f8fe..04ad8e44cbb 100644
--- a/arch/arm/dts/sc589-ezkit.dts
+++ b/arch/arm/dts/sc589-ezkit.dts
@@ -17,6 +17,8 @@
 &i2c0 {
 	#address-cells = <1>;
 	#size-cells = <0>;
+	status = "okay";
+
 	gpio_expander0: mcp23017@21 {
 		compatible = "microchip,mcp23017";
 		reg = <0x21>;
diff --git a/arch/arm/dts/sc594-som.dtsi b/arch/arm/dts/sc594-som.dtsi
index 1c2adc601dd..c4373aea60f 100644
--- a/arch/arm/dts/sc594-som.dtsi
+++ b/arch/arm/dts/sc594-som.dtsi
@@ -79,6 +79,7 @@
 
 &i2c2 {
 	clocks = <&clk ADSP_SC594_CLK_CGU0_SCLK0>;
+	status = "okay";
 
 	som_gpio_expander: mcp23017@21 {
 		compatible = "microchip,mcp23017";
@@ -153,6 +154,18 @@
 	};
 };
 
+&i2c3 {
+	clocks = <&clk ADSP_SC594_CLK_CGU0_SCLK0>;
+};
+
+&i2c4 {
+	clocks = <&clk ADSP_SC594_CLK_CGU0_SCLK0>;
+};
+
+&i2c5 {
+	clocks = <&clk ADSP_SC594_CLK_CGU0_SCLK0>;
+};
+
 &ospi {
 	status = "okay";
 
diff --git a/arch/arm/dts/sc598-som-revD.dtsi b/arch/arm/dts/sc598-som-revD.dtsi
index 26e272966ff..06d550b8532 100644
--- a/arch/arm/dts/sc598-som-revD.dtsi
+++ b/arch/arm/dts/sc598-som-revD.dtsi
@@ -8,6 +8,8 @@
 #include "sc598-som.dtsi"
 
 &i2c2 {
+	status = "okay";
+
 	som_gpio_expander: mcp23018@20 {
 		compatible = "microchip,mcp23018";
 		reg = <0x20>;
diff --git a/arch/arm/dts/sc598-som-revE.dtsi b/arch/arm/dts/sc598-som-revE.dtsi
index bec504102e7..1f48d52109b 100644
--- a/arch/arm/dts/sc598-som-revE.dtsi
+++ b/arch/arm/dts/sc598-som-revE.dtsi
@@ -8,6 +8,8 @@
 #include "sc598-som.dtsi"
 
 &i2c2 {
+	status = "okay";
+
 	som_gpio_expander: adp5587@34 {
 		compatible = "adi,adp5587";
 		reg = <0x34>;
diff --git a/arch/arm/dts/sc598-som.dtsi b/arch/arm/dts/sc598-som.dtsi
index bc212ef25cb..ac1f24c86c3 100644
--- a/arch/arm/dts/sc598-som.dtsi
+++ b/arch/arm/dts/sc598-som.dtsi
@@ -138,6 +138,18 @@
 	clocks = <&clk ADSP_SC598_CLK_CGU0_SCLK0>;
 };
 
+&i2c3 {
+	clocks = <&clk ADSP_SC598_CLK_CGU0_SCLK0>;
+};
+
+&i2c4 {
+	clocks = <&clk ADSP_SC598_CLK_CGU0_SCLK0>;
+};
+
+&i2c5 {
+	clocks = <&clk ADSP_SC598_CLK_CGU0_SCLK0>;
+};
+
 &spi2 {
 	clocks = <&clk ADSP_SC598_CLK_SPI>;
 };
diff --git a/arch/arm/dts/sc59x.dtsi b/arch/arm/dts/sc59x.dtsi
index ff279cca2d1..64e5a1afc53 100644
--- a/arch/arm/dts/sc59x.dtsi
+++ b/arch/arm/dts/sc59x.dtsi
@@ -86,6 +86,36 @@
 			pinctrl-0 = <&usb0_default>;
 			status = "disabled";
 		};
+
+		i2c3: i2c3@31001000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "adi-i2c";
+			reg = <0x31001000 0x100>;
+			clock-names = "i2c";
+			status = "disabled";
+			bootph-pre-ram;
+		};
+
+		i2c4: i2c4@31001100 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "adi-i2c";
+			reg = <0x31001100 0x100>;
+			clock-names = "i2c";
+			status = "disabled";
+			bootph-pre-ram;
+		};
+
+		i2c5: i2c5@31001200 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "adi-i2c";
+			reg = <0x31001200 0x100>;
+			clock-names = "i2c";
+			status = "disabled";
+			bootph-pre-ram;
+		};
 	};
 };
 
diff --git a/arch/arm/dts/sc5xx.dtsi b/arch/arm/dts/sc5xx.dtsi
index 072631e34f7..b821deddda7 100644
--- a/arch/arm/dts/sc5xx.dtsi
+++ b/arch/arm/dts/sc5xx.dtsi
@@ -140,9 +140,9 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "adi-i2c";
-			reg = <0x31001400 0x1000>;
+			reg = <0x31001400 0x100>;
 			clock-names = "i2c";
-			status = "okay";
+			status = "disabled";
 			bootph-pre-ram;
 		};
 
@@ -150,9 +150,9 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "adi-i2c";
-			reg = <0x31001500 0x1000>;
+			reg = <0x31001500 0x100>;
 			clock-names = "i2c";
-			status = "okay";
+			status = "disabled";
 			bootph-pre-ram;
 		};
 
@@ -160,9 +160,9 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "adi-i2c";
-			reg = <0x31001600 0x1000>;
+			reg = <0x31001600 0x100>;
 			clock-names = "i2c";
-			status = "okay";
+			status = "disabled";
 			bootph-pre-ram;
 		};
 	};
-- 
2.53.0

