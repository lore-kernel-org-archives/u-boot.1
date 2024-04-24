Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5440BC4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 11:15:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C34988DEB;
	Wed, 24 Apr 2024 13:14:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="IgLqBRbK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9911088CD6; Wed, 24 Apr 2024 13:14:41 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9841B831A2
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 13:14:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a5557e3ebcaso150089166b.1
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 04:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1713957279; x=1714562079; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=esCOPpgqwz4Sc2eh73qo039el0nsI8ch7CTjiX0aRlc=;
 b=IgLqBRbKNmQlA6J++yhhX7uh6nFkwo2s14mph/SbzHLwyA2f29SZMch+uaa5riAfFu
 zjNDDcgwePonzN1G29ahW+pR3/aADQEsoavRNHigzJd0rOX1yMYgFvwUijBIDuRX2vRM
 dFt0qTIIN7YtDqBfDvthafkbqjIRM3bR57YTLC4keBtvArayBsieNz7j26IPkTm/FGcC
 snAmabm/7hwCC8sRDhEBRCyugDrzIfQe7clHDeiaRR7JFjX49qLMZvZy3pG4RRlsCx+d
 LBtuubUkUE1qTzm+qvf4h7q5gz4kxb1gWq/gPzNMSNsSZVowI7aO+jcLeUi66vix4N3y
 fY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713957279; x=1714562079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=esCOPpgqwz4Sc2eh73qo039el0nsI8ch7CTjiX0aRlc=;
 b=XPH/9kZ8jESdsT+nl/j9Qy1tSScuWoa71BygT5sjXxfJ2yKKGXmX8MUYoxHVSihWwY
 UBQRKxHh7xnzNQZWF9vnLkc+mSCXXxrohOhrxNZwaFTW+zwEDlaOqT+rVJtC0Dqre0Un
 prD8AhoBK51RjUimBWgqjzz1Yog/hFYGF8kKgdaC09W9bYzSVgZjN3D0EMT8DWKL/wv0
 bdjNFKF/N3CRB9iHZHVvp9SmgVz8mU0onGX8ioAPpprFtjgYTX6lSI2OOUNVN1F6/9TE
 UyBrtpSqR3kzzPAWXABIiGpDAuPj/JqNPCnuMMRRaFcyv9COAN1FOtX5KEx5Btul5NjA
 HXcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIdB1T4XLVqZQzARp8JC7mn9cXIMom147A3TFlIwCXQuBuE3pcUCOw78vZnyleZovrbCNmdx4f3g1sgA83gMUEkjOcgQ==
X-Gm-Message-State: AOJu0YyOWJ5eXX2sVsMm+4EATKCHHoXNUYZ9LW0NepM9mpiPgM5Jh5ni
 Ydz4b7IIpuyNI6+jW3LYoytQRCn1DiMaX/yOxc2+52+YMmjASnlaCQPMOFh0Sn4=
X-Google-Smtp-Source: AGHT+IHYrA1wkLItzVhTFNoZPIQ6W7+4cwLi/H08oUA8x0CMpVWGjc+JqsPcu1w8BFtjub5RFceYag==
X-Received: by 2002:a17:906:19db:b0:a52:4246:be8d with SMTP id
 h27-20020a17090619db00b00a524246be8dmr2292043ejd.18.1713957279115; 
 Wed, 24 Apr 2024 04:14:39 -0700 (PDT)
Received: from fedora.. (cpe-188-129-47-121.dynamic.amis.hr. [188.129.47.121])
 by smtp.googlemail.com with ESMTPSA id
 ju5-20020a170906e90500b00a55b35b57a7sm3964553ejb.62.2024.04.24.04.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 04:14:38 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: trini@konsulko.com, caleb.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@linaro.org, u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: j.beck@linefinity.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 3/3] arm: dts: drop downstream IPQ4019 DTSI
Date: Wed, 24 Apr 2024 13:13:58 +0200
Message-ID: <20240424111434.373920-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424111434.373920-1-robert.marko@sartura.hr>
References: <20240424111434.373920-1-robert.marko@sartura.hr>
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

We want to use OF_UPSTREAM on IPQ40XX as its well supported upstream, so
lets drop our downstream DTSI.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 arch/arm/dts/qcom-ipq4019.dtsi | 202 ---------------------------------
 1 file changed, 202 deletions(-)
 delete mode 100644 arch/arm/dts/qcom-ipq4019.dtsi

diff --git a/arch/arm/dts/qcom-ipq4019.dtsi b/arch/arm/dts/qcom-ipq4019.dtsi
deleted file mode 100644
index f9489e42ea..0000000000
--- a/arch/arm/dts/qcom-ipq4019.dtsi
+++ /dev/null
@@ -1,202 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (c) 2019 Sartura Ltd.
- *
- * Author: Robert Marko <robert.marko@sartura.hr>
- */
-
- /dts-v1/;
-
-#include "skeleton.dtsi"
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/clock/qcom,ipq4019-gcc.h>
-#include <dt-bindings/reset/qcom,ipq4019-reset.h>
-
-/ {
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	model = "Qualcomm Technologies, Inc. IPQ4019";
-	compatible = "qcom,ipq4019";
-
-	aliases {
-		serial0 = &blsp1_uart1;
-		spi0 = &blsp1_spi1;
-	};
-
-	reserved-memory {
-		#address-cells = <0x1>;
-		#size-cells = <0x1>;
-		ranges;
-
-		smem_mem: smem_region: smem@87e00000 {
-			reg = <0x87e00000 0x080000>;
-			no-map;
-		};
-
-		tz@87e80000 {
-			reg = <0x87e80000 0x180000>;
-			no-map;
-		};
-	};
-
-	smem {
-		compatible = "qcom,smem";
-		memory-region = <&smem_mem>;
-	};
-
-	soc: soc {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-		compatible = "simple-bus";
-
-		gcc: clock-controller@1800000 {
-			compatible = "qcom,gcc-ipq4019";
-			reg = <0x1800000 0x60000>;
-			#clock-cells = <1>;
-			#reset-cells = <1>;
-			bootph-all;
-		};
-
-		rng: rng@22000 {
-			compatible = "qcom,prng";
-			reg = <0x22000 0x140>;
-			clocks = <&gcc GCC_PRNG_AHB_CLK>;
-			status = "disabled";
-		};
-
-		soc_gpios: pinctrl@1000000 {
-			compatible = "qcom,ipq4019-pinctrl";
-			reg = <0x1000000 0x300000>;
-			gpio-controller;
-			gpio-count = <100>;
-			gpio-bank-name="soc";
-			#gpio-cells = <2>;
-			bootph-all;
-		};
-
-		blsp1_uart1: serial@78af000 {
-			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
-			reg = <0x78af000 0x200>;
-			clock = <&gcc GCC_BLSP1_UART1_APPS_CLK>;
-			bit-rate = <0xFF>;
-			status = "disabled";
-			bootph-all;
-		};
-
-		blsp1_spi1: spi@78b5000 {
-			compatible = "qcom,spi-qup-v2.2.1";
-			reg = <0x78b5000 0x600>;
-			clocks = <&gcc GCC_BLSP1_QUP1_SPI_APPS_CLK>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-			bootph-all;
-		};
-
-		mdio: mdio@90000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "qcom,ipq4019-mdio";
-			reg = <0x90000 0x64>;
-			status = "disabled";
-
-			ethphy0: ethernet-phy@0 {
-				reg = <0>;
-			};
-
-			ethphy1: ethernet-phy@1 {
-				reg = <1>;
-			};
-
-			ethphy2: ethernet-phy@2 {
-				reg = <2>;
-			};
-
-			ethphy3: ethernet-phy@3 {
-				reg = <3>;
-			};
-
-			ethphy4: ethernet-phy@4 {
-				reg = <4>;
-			};
-		};
-
-		usb3_ss_phy: ssphy@9a000 {
-			compatible = "qcom,usb-ss-ipq4019-phy";
-			#phy-cells = <0>;
-			reg = <0x9a000 0x800>;
-			reg-names = "phy_base";
-			resets = <&gcc USB3_UNIPHY_PHY_ARES>;
-			reset-names = "por_rst";
-			status = "disabled";
-		};
-
-		usb3_hs_phy: hsphy@a6000 {
-			compatible = "qcom,usb-hs-ipq4019-phy";
-			#phy-cells = <0>;
-			reg = <0xa6000 0x40>;
-			reg-names = "phy_base";
-			resets = <&gcc USB3_HSPHY_POR_ARES>, <&gcc USB3_HSPHY_S_ARES>;
-			reset-names = "por_rst", "srif_rst";
-			status = "disabled";
-		};
-
-		usb3: usb3@8af8800 {
-			compatible = "qcom,dwc3";
-			reg = <0x8af8800 0x100>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			clocks = <&gcc GCC_USB3_MASTER_CLK>,
-				 <&gcc GCC_USB3_SLEEP_CLK>,
-				 <&gcc GCC_USB3_MOCK_UTMI_CLK>;
-			clock-names = "master", "sleep", "mock_utmi";
-			ranges;
-			status = "disabled";
-
-			dwc3@8a00000 {
-				compatible = "snps,dwc3";
-				reg = <0x8a00000 0xf8000>;
-				phys = <&usb3_hs_phy>, <&usb3_ss_phy>;
-				phy-names = "usb2-phy", "usb3-phy";
-				dr_mode = "host";
-				maximum-speed = "super-speed";
-				snps,dis_u2_susphy_quirk;
-			};
-		};
-
-		usb2_hs_phy: hsphy@a8000 {
-			compatible = "qcom,usb-hs-ipq4019-phy";
-			#phy-cells = <0>;
-			reg = <0xa8000 0x40>;
-			reg-names = "phy_base";
-			resets = <&gcc USB2_HSPHY_POR_ARES>, <&gcc USB2_HSPHY_S_ARES>;
-			reset-names = "por_rst", "srif_rst";
-			status = "disabled";
-		};
-
-		usb2: usb2@60f8800 {
-			compatible = "qcom,dwc3";
-			reg = <0x60f8800 0x100>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			clocks = <&gcc GCC_USB2_MASTER_CLK>,
-				 <&gcc GCC_USB2_SLEEP_CLK>,
-				 <&gcc GCC_USB2_MOCK_UTMI_CLK>;
-			clock-names = "master", "sleep", "mock_utmi";
-			ranges;
-			status = "disabled";
-
-			dwc3@6000000 {
-				compatible = "snps,dwc3";
-				reg = <0x6000000 0xf8000>;
-				phys = <&usb2_hs_phy>;
-				phy-names = "usb2-phy";
-				dr_mode = "host";
-				maximum-speed = "high-speed";
-				snps,dis_u2_susphy_quirk;
-			};
-		};
-	};
-};
-- 
2.44.0

