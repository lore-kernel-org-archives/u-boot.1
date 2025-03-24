Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3718FC36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 18:01:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1059581B42;
	Mon, 24 Mar 2025 19:01:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="pW23ygib";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A9AA80F70; Mon, 24 Mar 2025 19:00:58 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CE0080548
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 19:00:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4394a823036so48281145e9.0
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 11:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1742839255; x=1743444055;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iFaFn/OC4j0QG0f+ruGPqbpwF76TJl6MZZ0HQgXuxOk=;
 b=pW23ygibmZ1+tciHBTuZeMystXT3TBfV6CcxWNOAo/lg+c9ljdqmiSMk/ea2x0EEFc
 jjiY7k28tw2JEsXAqHHr89gl5WSKiayNOsxE6modqv+sTEXavWr0f52OmRnDRootONFp
 Ytw9sZfHlqX4sGko0QErHjs3xGKe1dtuuwMAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742839255; x=1743444055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iFaFn/OC4j0QG0f+ruGPqbpwF76TJl6MZZ0HQgXuxOk=;
 b=KGcraCASOnuLmNXZkUl1m2lqlQsIM09vwLY0gRyuTk8sGj22luLMzTdPtnyJejDKbS
 pT422OfEBsda9J77DMgd3ZYQDEKr8Fi3S2rADTFYQaNMlGOO5vs4WZEXdr2oOV78QQXG
 PzB30tpBl/XJrwr8b9YlqwNolpvgndMFrNR23DaJ/sZVrhV2xJqHy4TnDi7+SZbBL2AG
 2zm6sABenUOfcIijxSFmFCx8U0Mt46QqtP2jyqDNWOG8ghLYyGou2rMcGba3lsjO7r3y
 KFeOskQvxEDM8QbvLKxIgoxrfCxEygcqns1DD+I/8hYgqHz9HpmshnLaqQKa/9tGsGqY
 d1iQ==
X-Gm-Message-State: AOJu0YydAHKoVaNIA3HX0ESCz94ijbfGIK70xzOxklc9HRlllAkGAJvc
 IjSISw7591Eyp7g+5SGe1V19dM8csFpXE+OQPAMs2s3ktXwWIDBnKgTZejSm6SPXWBaZ0F8jO5q
 G
X-Gm-Gg: ASbGncu1a99SnfdDenPHgnhiR+0jhDfsT2Ds3zbvIsIViMXqnXHr77TGy+bT5lx587F
 Hnd4Zbtfzlemh7TbgupcM/I/H4K3vKVoGsIInh+pP+EDFVkrixTrJ4s7ofOlfP9yYj1onnTCn1S
 XknsUF0l54XeR7enf0ML/SJnwRnkIJBnvLg/GIICIl1Md4HBvcT8NIqR7wCp6ETXx4BT9orRspX
 S3z2y8jr3LQelJTWf0i+2po5Rlem/1G4+vA0F0dInZKahdi0emfcQswTaSIMYTjrsAjn2j1Gn+w
 W4/FCk0EYznHF+FrUpYlwmHxx07ZiN2Xx5KVIyZ/9ljPxNIbLpWJiTdsTBHfABw4amMOlY92N2C
 h2dvT9aIhG6uw9GOTjWsmB32trugQn/riBok=
X-Google-Smtp-Source: AGHT+IFa27r9SdTqh/c8mBcZ4kUHnf5UsghURYnf5JfTfTUwhsaGVPm3LsV1kFOHFRf/djCSw6DGnQ==
X-Received: by 2002:a05:600c:cce:b0:43c:eec7:eab7 with SMTP id
 5b1f17b1804b1-43d509ed65amr140521595e9.11.1742839254591; 
 Mon, 24 Mar 2025 11:00:54 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2.196.41.220])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f556a4sm178289285e9.22.2025.03.24.11.00.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 11:00:54 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 3/6] ARM: dts: stm32: add display support on stm32f769-disco
Date: Mon, 24 Mar 2025 19:00:27 +0100
Message-ID: <20250324180047.1571378-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250324180047.1571378-1-dario.binacchi@amarulasolutions.com>
References: <20250324180047.1571378-1-dario.binacchi@amarulasolutions.com>
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

[backport from Linux commit 598e5adfeb6062f5d4d352c0ef888b2b29d7e215]

The patch adds display support on the stm32f769-disco board.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 arch/arm/dts/stm32f769-disco-u-boot.dtsi | 34 --------------
 arch/arm/dts/stm32f769-disco.dts         | 58 ++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 34 deletions(-)

diff --git a/arch/arm/dts/stm32f769-disco-u-boot.dtsi b/arch/arm/dts/stm32f769-disco-u-boot.dtsi
index c5ae753debe6..16a9eecd4a99 100644
--- a/arch/arm/dts/stm32f769-disco-u-boot.dtsi
+++ b/arch/arm/dts/stm32f769-disco-u-boot.dtsi
@@ -32,18 +32,6 @@
 		compatible = "st,led1";
 		led-gpio = <&gpioj 5 0>;
 	};
-
-	panel: panel {
-		compatible = "orisetech,otm8009a";
-		reset-gpios = <&gpioj 15 1>;
-		status = "okay";
-
-		port {
-			panel_in: endpoint {
-				remote-endpoint = <&dsi_out>;
-			};
-		};
-	};
 };
 
 &dsi {
@@ -52,33 +40,11 @@
 		 <&clk_hse>;
 	clock-names = "pclk", "px_clk", "ref";
 	bootph-all;
-	status = "okay";
-
-	ports {
-		port@0 {
-			dsi_out: endpoint {
-				remote-endpoint = <&panel_in>;
-			};
-		};
-		port@1 {
-			dsi_in: endpoint {
-				remote-endpoint = <&dp_out>;
-			};
-		};
-	};
 };
 
 &ltdc {
 	clocks = <&rcc 0 STM32F7_APB2_CLOCK(LTDC)>;
 	bootph-all;
-
-	ports {
-		port@0 {
-			dp_out: endpoint {
-				remote-endpoint = <&dsi_in>;
-			};
-		};
-	};
 };
 
 &fmc {
diff --git a/arch/arm/dts/stm32f769-disco.dts b/arch/arm/dts/stm32f769-disco.dts
index b4e240a8e3eb..3fd5140ec5eb 100644
--- a/arch/arm/dts/stm32f769-disco.dts
+++ b/arch/arm/dts/stm32f769-disco.dts
@@ -24,6 +24,19 @@
 		reg = <0xC0000000 0x1000000>;
 	};
 
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		linux,dma {
+			compatible = "shared-dma-pool";
+			linux,dma-default;
+			no-map;
+			size = <0x100000>;
+		};
+	};
+
 	aliases {
 		serial0 = &usart1;
 	};
@@ -78,6 +91,45 @@
 	clock-frequency = <25000000>;
 };
 
+&dsi {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			dsi_in: endpoint {
+				remote-endpoint = <&ltdc_out_dsi>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+			dsi_out: endpoint {
+				remote-endpoint = <&dsi_panel_in>;
+			};
+		};
+	};
+
+	panel0: panel@0 {
+		compatible = "orisetech,otm8009a";
+		reg = <0>; /* dsi virtual channel (0..3) */
+		reset-gpios = <&gpioj 15 GPIO_ACTIVE_LOW>;
+		power-supply = <&vcc_3v3>;
+		status = "okay";
+
+		port {
+			dsi_panel_in: endpoint {
+				remote-endpoint = <&dsi_out>;
+			};
+		};
+	};
+};
+
 &i2c1 {
 	pinctrl-0 = <&i2c1_pins_b>;
 	pinctrl-names = "default";
@@ -88,6 +140,12 @@
 
 &ltdc {
 	status = "okay";
+
+	port {
+		ltdc_out_dsi: endpoint {
+			remote-endpoint = <&dsi_in>;
+		};
+	};
 };
 
 &rtc {
-- 
2.43.0

