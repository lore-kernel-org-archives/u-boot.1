Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 928B0C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 00:41:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9E4F876F3;
	Wed,  8 Nov 2023 01:40:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ioFJo5/Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 277E6876ED; Wed,  8 Nov 2023 01:40:49 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75C7C876DD
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 01:40:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-28019b66ad5so5633958a91.3
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 16:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699404045; x=1700008845; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VKIveplpuBkXuijXAQoTSeDExj69Kip/pLHYYIZOmws=;
 b=ioFJo5/Y2YTVDKLCLkVuBVNO3/g5T4g3Eo0nT5S4HYXaYsW1cLjB0k8KmKxzRvZqZv
 5RLoF767NuAdjZWWDQTs+yDhfvwXaBm/864TDv2ZB31mZhbDB7BFTKEfIhJHooklHzPb
 de5IKyleytEbMOupYxpSTk322FF7L+SShsg5H1N1hDdef0SD/FwrmdrgKtUEC/lwWyM2
 i5ngNs6wQyEBRJvLqc8MtMi/dc7BlPjJN46HVy3BqGVhnc9SCyGXxZ0eL5PBX529xbvj
 lXL5UDrY346NYhvHHLJ45VNlXpIWE+vJRt+IEJ8XE2Am4o8Vbbsxng8eHdnoLN3/VIUo
 BbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699404045; x=1700008845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VKIveplpuBkXuijXAQoTSeDExj69Kip/pLHYYIZOmws=;
 b=j0yBWHavX8RAOugBAPaJixBAX+5Nd5WGo2SSe0fjBAheajDtJXAMgWPMVn63UIlY2P
 Qwx+RAX5Xogj8Vtnm8CJBi/KR7Wz+IwSdYVWIxgtGuEuz42njOc75o7UJAeA3bTTND/M
 AAkRVqRRXZqsIncfL+LN7SiyLT0+X9JQ4/dLRhyBP4XXhHDcl1PnKN+Hycjo7qCfMSs2
 D1YsfwdZpEhE1jFKtJgqzX2MwUbS/KzTwOVk6NZEGZDerTDgUqvYyKKyHPUE/Q4exGc2
 le5sC4zfpJo04ywxpa4iWwL1WfgbL7aw76zlTUE0xe0CisKxbQvBKTyQsQx2KA0Kvhfv
 rvCg==
X-Gm-Message-State: AOJu0YynLP3ZiZoESCE2wKO9KuCk9HkIAaibuPRGueXDK3g7nQScZ0hM
 x7v4uJfXH7PZodRroBqj7aE=
X-Google-Smtp-Source: AGHT+IH5qxr5wkQhTJiKEVTaZcvV8h/x1MGXD9P8JRonibK8c6DAgAiBGVS57KO2umkPi7wA2GvYsQ==
X-Received: by 2002:a17:90b:4aca:b0:27d:880d:8645 with SMTP id
 mh10-20020a17090b4aca00b0027d880d8645mr286666pjb.49.1699404044715; 
 Tue, 07 Nov 2023 16:40:44 -0800 (PST)
Received: from cs20-buildserver.lan ([180.217.132.54])
 by smtp.gmail.com with ESMTPSA id
 mv21-20020a17090b199500b0028066f3c373sm384284pjb.17.2023.11.07.16.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 16:40:44 -0800 (PST)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, YSCHU@nuvoton.com--compose, KWLIU@nuvoton.com,
 jim.t90615@gmail.com, trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/4] arm: dts: npcm845-evb: fix/add node and aliases name
Date: Wed,  8 Nov 2023 08:40:24 +0800
Message-Id: <20231108004027.281383-2-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231108004027.281383-1-JJLIU0@nuvoton.com>
References: <20231108004027.281383-1-JJLIU0@nuvoton.com>
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
Add tpm and otpee node.

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 arch/arm/dts/nuvoton-common-npcm8xx.dtsi      |  2 +-
 arch/arm/dts/nuvoton-npcm845-evb.dts          | 29 ++++++++++++++-----
 arch/arm/dts/nuvoton-npcm8xx-u-boot.dtsi      |  2 +-
 include/dt-bindings/phy/nuvoton,npcm-usbphy.h | 14 +++++++++
 4 files changed, 38 insertions(+), 9 deletions(-)
 create mode 100644 include/dt-bindings/phy/nuvoton,npcm-usbphy.h

diff --git a/arch/arm/dts/nuvoton-common-npcm8xx.dtsi b/arch/arm/dts/nuvoton-common-npcm8xx.dtsi
index fabe5925b7..8478367711 100644
--- a/arch/arm/dts/nuvoton-common-npcm8xx.dtsi
+++ b/arch/arm/dts/nuvoton-common-npcm8xx.dtsi
@@ -133,7 +133,7 @@
 			ranges = <0x0 0x0 0xf0000000 0x00300000>,
 				<0xfff00000 0x0 0xfff00000 0x00016000>;
 
-			spi1: spi@201000 {
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

