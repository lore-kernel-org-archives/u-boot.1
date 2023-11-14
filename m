Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7423C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 08:52:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 356628723C;
	Tue, 14 Nov 2023 09:52:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ftiJTTao";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C03D8721D; Tue, 14 Nov 2023 09:52:18 +0100 (CET)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74504871DE
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 09:52:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6be1bc5aa1cso5511940b3a.3
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 00:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699951935; x=1700556735; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ETZPvkm09kOfVepRGwPb9GErIx/+th3fcdNO1CCDNoI=;
 b=ftiJTTaotUueMhNvJ4jPH14LxsflWxVq/wJhhIh3T8poD0U8KAvSkTcllcz4CmwY3o
 xW7IN09CfaWUJH+C1TxoX7JKh06wG4O+IgLDKbSivQQkd4jWTUg2MichUrefy5qNl7Zx
 OSHvj6B+ChFNhnCZcZC32X4q3VvwIeCnvMQEFi7uXiSEp4TONR4Gg2lcCUNM811eJDb7
 dmAsMFH+fFIKSzRGSIJ2H9164eUp2MZsUju1+l962AhYo9/wDrWy6/MeN+uvutHbXo9U
 YRS46Q42OgWfkMWdpg3VG7auMCgPqmEDLO9f84QWB4vbDxWEkTfVSNbkcpD2BD+AWtnb
 qq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699951935; x=1700556735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ETZPvkm09kOfVepRGwPb9GErIx/+th3fcdNO1CCDNoI=;
 b=xM6cLGVaVUeuXEldnywUwkuizyVk8/khMA/IQ3aQg6Sn69C/9/WV4AtG96gXrR2wtR
 n4PlwfXARK9CBTUyRFXNAJiSJCZQa4TB5Fy5L1Ewkey/t6vWB1ofCBsyjt+MIVrHZx2e
 LG+fYgq7szGjGcyytU7eRmeBS8T9Dgt8EY0JMhwAEMZBVNg3aJzva/j4SFsTvq1cl7v6
 eQkT6Cp9zPHrM1AuICzeObTJmxWw464wiDUyD6SvFk0iqUn8vnTfp9GXTrAycv/dkVjs
 kLHtV0vv6cFP0cRHMEM7okdIUQY1YK6YGOEcaWUpxMbdvd/k2x/oI5vsTE5sR2sTDl9F
 NCVQ==
X-Gm-Message-State: AOJu0YyNVjFfUqWpJosunQ5UQz2Gqe+blR5tKF+PUSxtN7H+h9qQsFe9
 GvX7Zp+DahISFT9dnHIxoOJ141gtel8mPw==
X-Google-Smtp-Source: AGHT+IF/vHfmpircWym+QRZb8W+U94GyX3dFTrKPR+TXNa5u3yCunOSLCPhebMYzo7ei8O35K1QCzQ==
X-Received: by 2002:a05:6a00:278c:b0:6c4:9672:9a17 with SMTP id
 bd12-20020a056a00278c00b006c496729a17mr10380583pfb.1.1699951934729; 
 Tue, 14 Nov 2023 00:52:14 -0800 (PST)
Received: from cs20-buildserver.lan ([180.217.145.22])
 by smtp.gmail.com with ESMTPSA id
 fh23-20020a056a00391700b006be0bd6a4d8sm778696pfb.36.2023.11.14.00.52.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 00:52:14 -0800 (PST)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, KWLIU@nuvoton.com, jim.t90615@gmail.com,
 trini@konsulko.com, YSCHU@nuvoton.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 1/4] arm: dts: npcm845-evb: fix/add node and aliases
Date: Tue, 14 Nov 2023 16:51:56 +0800
Message-Id: <20231114085159.3739887-2-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231114085159.3739887-1-JJLIU0@nuvoton.com>
References: <20231114085159.3739887-1-JJLIU0@nuvoton.com>
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

Modify spi and usb aliases name.
Add dt-binding for usb phy define and fix usb phy reset error.
Add tpm/otpee and host_intf node.

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
Changes for v2:
   - add espi node
---
 arch/arm/dts/nuvoton-common-npcm8xx.dtsi      | 11 ++++++-
 arch/arm/dts/nuvoton-npcm845-evb.dts          | 29 ++++++++++++++-----
 arch/arm/dts/nuvoton-npcm8xx-u-boot.dtsi      |  2 +-
 include/dt-bindings/phy/nuvoton,npcm-usbphy.h | 14 +++++++++
 4 files changed, 47 insertions(+), 9 deletions(-)
 create mode 100644 include/dt-bindings/phy/nuvoton,npcm-usbphy.h

diff --git a/arch/arm/dts/nuvoton-common-npcm8xx.dtsi b/arch/arm/dts/nuvoton-common-npcm8xx.dtsi
index fabe5925b7..1694ef8849 100644
--- a/arch/arm/dts/nuvoton-common-npcm8xx.dtsi
+++ b/arch/arm/dts/nuvoton-common-npcm8xx.dtsi
@@ -133,7 +133,16 @@
 			ranges = <0x0 0x0 0xf0000000 0x00300000>,
 				<0xfff00000 0x0 0xfff00000 0x00016000>;
 
-			spi1: spi@201000 {
+			host_intf: host_intf@9f000 {
+				compatible = "nuvoton,npcm845-host-intf";
+				reg = <0x9f000 0x1000>;
+				type = "espi";
+				ioaddr = <0x4e>;
+				channel-support = <0xf>;
+				syscon = <&gcr>;
+			};
+
+			pspi: spi@201000 {
 				compatible = "nuvoton,npcm845-pspi";
 				reg = <0x201000 0x1000>;
 				pinctrl-names = "default";
diff --git a/arch/arm/dts/nuvoton-npcm845-evb.dts b/arch/arm/dts/nuvoton-npcm845-evb.dts
index a93666cb41..0d3aaa0fff 100644
--- a/arch/arm/dts/nuvoton-npcm845-evb.dts
+++ b/arch/arm/dts/nuvoton-npcm845-evb.dts
@@ -2,6 +2,8 @@
 // Copyright (c) 2021 Nuvoton Technology tomer.maimon@nuvoton.com
 
 /dts-v1/;
+
+#include <dt-bindings/phy/nuvoton,npcm-usbphy.h>
 #include "nuvoton-npcm845.dtsi"
 #include "nuvoton-npcm845-pincfg.dtsi"
 
@@ -46,10 +48,10 @@
 		spi1 = &fiu1;
 		spi3 = &fiu3;
 		spi4 = &fiux;
-		spi5 = &spi1;
+		spi5 = &pspi;
 		usb0 = &udc0;
 		usb1 = &ehci1;
-		usb2 = &ehci2;
+		usb2 = &udc8;
 	};
 
 	chosen {
@@ -60,6 +62,17 @@
 		reg = <0x0 0x0 0x0 0x40000000>;
 	};
 
+	tpm@0 {
+		compatible = "microsoft,ftpm";
+	};
+
+	firmware {
+		optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+	};
+
 	vsbr2: vsbr2 {
 		compatible = "regulator-npcm845";
 		regulator-name = "vr2";
@@ -149,6 +162,8 @@
 	snps,reset-active-low;
 	snps,reset-delays-us = <0 10000 1000000>;
 	snps,reset-gpio = <&gpio5 2 GPIO_ACTIVE_LOW>;    /* gpio162 */
+	phy-supply = <&vsbr2>;
+	phy-supply-microvolt = <1800000>;
 	status = "okay";
 };
 
@@ -179,7 +194,7 @@
 	status = "okay";
 };
 
-&spi1 {
+&pspi {
 	status = "okay";
 };
 
@@ -197,7 +212,7 @@
 
 &udc0 {
 	status = "okay";
-	phys = <&usbphy1 0>;
+	phys = <&usbphy1 NPCM_UDC0_7>;
 };
 
 &sdhci0 {
@@ -207,12 +222,12 @@
 
 &ehci1 {
 	status = "okay";
-	phys = <&usbphy2 3>;
+	phys = <&usbphy2 NPCM_USBH1>;
 };
 
-&ehci2 {
+&udc8 {
 	status = "okay";
-	phys = <&usbphy3 4>;
+	phys = <&usbphy3 NPCM_UDC8>;
 };
 
 &rng {
diff --git a/arch/arm/dts/nuvoton-npcm8xx-u-boot.dtsi b/arch/arm/dts/nuvoton-npcm8xx-u-boot.dtsi
index e49e564b79..4c6d5bed44 100644
--- a/arch/arm/dts/nuvoton-npcm8xx-u-boot.dtsi
+++ b/arch/arm/dts/nuvoton-npcm8xx-u-boot.dtsi
@@ -174,7 +174,7 @@
 				compatible = "nuvoton,npcm845-usb-phy";
 				#phy-cells = <1>;
 				reg = <3>;
-				resets = <&rstc3 NPCM8XX_RESET_USBPHY3>;
+				resets = <&rstc4 NPCM8XX_RESET_USBPHY3>;
 				status = "disabled";
 			};
 		};
diff --git a/include/dt-bindings/phy/nuvoton,npcm-usbphy.h b/include/dt-bindings/phy/nuvoton,npcm-usbphy.h
new file mode 100644
index 0000000000..46946d377d
--- /dev/null
+++ b/include/dt-bindings/phy/nuvoton,npcm-usbphy.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+// Copyright (c) 2023 Nuvoton Technology corporation.
+
+#ifndef _DT_BINDINGS_NPCM_USBPHY_H
+#define _DT_BINDINGS_NPCM_USBPHY_H
+
+#define NPCM_UDC0_7		0
+#define NPCM_UDC8		1
+#define NPCM_UDC9		2
+#define NPCM_USBH1		3
+#define NPCM_USBH2		4
+#define NPCM_MAX_USB_CTRL_ID	4
+
+#endif
-- 
2.25.1

