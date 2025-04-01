Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F3AC36008
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 07:02:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5323081F6B;
	Tue,  1 Apr 2025 09:01:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="lv2dU5wS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 938B581F54; Tue,  1 Apr 2025 09:01:37 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1345481E6C
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 09:01:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-399749152b4so2190231f8f.3
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 00:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1743490893; x=1744095693;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8gMeInNBRAkCkwoVlTM98xEWy0g3akZgL6kxDi5yA3g=;
 b=lv2dU5wSg6wKvvK/9jtfmwW6o/RRNjCL9teDp3n1JxuRSZ/Jhta9PJxY0VGCiVCafA
 G8pPfHoNQFJDnFgXUdpHbWnyIkLOK6X4257HpoUloDshnAL0uytsmXWLnZt0b8FjNw38
 h3yrWZrGauR2EwuEYckIXbZUiEdNVKMyxOGXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743490893; x=1744095693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8gMeInNBRAkCkwoVlTM98xEWy0g3akZgL6kxDi5yA3g=;
 b=gbLAvuzsSLNnxhapeU9rC5IwkHeTjClK38wyFj+YQ/ni1PO0jBnjC5HamlZCGGPM81
 ZCzS60M1/A+YXbj147FxqwzH1muZWVUxutR3uZqQSMDakb3HVKvM5ebcd4P1wtPpGrCw
 v8egGE5aZYrQ2yNakk3C4xB+5A+4rGBy2xGyKOJOKIONNStsOEtpTL1vZwT0Jrq6qQ5A
 NzRGHyRC2ESKgDVcOSfN+Due/MdP0J+VY1vxqliru37HXzsX/oZ7Tr1Row96oCaGy3N4
 FVBR7TZTOYK8GMCkzUEhQGNBeqfRgqF6jFWgPPSX5MKqUiQA0CFCrfgYhUSDEy2tQDr7
 /png==
X-Gm-Message-State: AOJu0Yz++658b6kqmQd9yjRRVo890FBtiCiiHCSWvX0VjXLzQ8IyRaMy
 LdqXGXn5iFS38jNNK6kHXEqmFDrYNxvmVfkbe2cINaby9NS5ox3FJGaVfJM/6Rjw/3ZWJ7wfb0g
 2
X-Gm-Gg: ASbGncupk8CF1lourBbnPU+QeoJSdDRef0ZhVTj0YkQJ6V8m2RIBSGo/eMIiXIUoduQ
 oOfeA0aE9Le7FJjh1Dsm1XC0uuL5pj2alKHDpOwmpfSwaCpKuVkhv4wzjlrg6BApEIi7UfO3Fb9
 KdSrktKTVdPf4D1gG9X6kHtofBvIYknaXDnwNKiz+FNDSm4CQQwY3RmYAXcsQq06/EhxJchYAp/
 WpXtf8kBZk8JyVTHa4/Wc3A/B4dctyc/DMhd/cLsW8KA8KoMuoteWN3Tz7R4Zk4/PxiataTT7w1
 jkAQ6YTZKVER6CXfYXLKcd8JaXoSDHSiQYfhGXUnCQJLCmQogi93Oqjla8F9ZYoxnsTBIAdKCvH
 hnkCaTKnGXg==
X-Google-Smtp-Source: AGHT+IHJ3fzHvs7TIHyWTcnAGL6nzKFp5yUVFrICNeE33iCAMDxahGJs/HPFYvmE5aElUVDwJ08tkQ==
X-Received: by 2002:a5d:59a5:0:b0:390:f9d0:5e3 with SMTP id
 ffacd0b85a97d-39c23646fe3mr1063138f8f.1.1743490893132; 
 Tue, 01 Apr 2025 00:01:33 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([2.196.40.230])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b66b015sm13701760f8f.54.2025.04.01.00.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 00:01:32 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 3/6] ARM: dts: stm32: add display support on stm32f769-disco
Date: Tue,  1 Apr 2025 09:00:54 +0200
Message-ID: <20250401070125.3705126-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250401070125.3705126-1-dario.binacchi@amarulasolutions.com>
References: <20250401070125.3705126-1-dario.binacchi@amarulasolutions.com>
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
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

---

Changes in v2:
- Add Reviewed-by tag of Patrice Chotard

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

