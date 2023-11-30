Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0818AC10DC1
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 20:23:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B52A987712;
	Thu, 30 Nov 2023 21:22:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZVcU7TJS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E808F8770A; Thu, 30 Nov 2023 21:22:52 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B16D8876B0
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 21:22:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40b57fa7a85so8407395e9.1
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 12:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701375770; x=1701980570; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0w+DCrtEuIUYJ2fnE/WrbX3JeH1Hp7bKSGISGtzF7mY=;
 b=ZVcU7TJSfNhwXMR4Mrhl2asraPJqrNva2HtVpv+3XGysC9+ZkHkmQvdF5XRYc6B6aP
 D+UkJnaZ0HrrLWij4ANBDIlCfNDC/nnJWLeHfBz99MwGSywVNhxAmgGEVDg1QL2CyFGn
 Iku/uDOmSNWD78qG3yRvZuDVhVTXTvgL4J++eUc5r4gdIfCt1qq2oJziWlmnPTGyC3j5
 ZpMhPTL5YChq1MWaIzer9Sfj3JtDD3jmDe/bOShDN0nMX2IofsXJ2PLV03kh2Qz73mgj
 NxEaYZ0AuzZC2UtO1sphIIMmoDwxh9pbnylAw/8xODUN6vhyuNWXLFSAKOak0DVIYq+8
 e2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701375770; x=1701980570;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0w+DCrtEuIUYJ2fnE/WrbX3JeH1Hp7bKSGISGtzF7mY=;
 b=aNXVCSeA2SFnvaQyMIVtO6C3DWSjTVH0JNMtcD5g79hMWlQuuSCi6qaENpQNoBYWQe
 vtihg53LA+81ljSBnQFbTFi0shRW0jiY121va9nvfRnt3/avE+Glh1j/IM9ZuQ8QLieG
 to5816dIKS7c9mD9iToRa46aRC6Z69F3+0l04P97CI0Yrkn7N4GQ56ElxD55b+sWHfI5
 i9AQV+kTnClBKsVrIFPmyidbLAuWC0pDtGjPQzM0/Pb7wD/uXahoZCRca0VwLANg/e9X
 LUYIBNkDlEcJedlahvU6ZKZR9IqKCQt5g11xAsXK8/ek4k3CBec+8s9SYcUGTvFwG56s
 vsDA==
X-Gm-Message-State: AOJu0Yxm1i2CsTRUKzphUw2npJ2h9utbrTKvvA16rO8nHLn9ObVp/H1z
 nytuDFyUY/OYsLzIDCh1i8BMcQ==
X-Google-Smtp-Source: AGHT+IHD/Ye/4MOY+Gw6vhhTNWHaDf2YpPEl0bKub+xHL6tMLUuIkttU4iPc/o/LSvRQKr4rp6Wn8w==
X-Received: by 2002:a05:600c:3511:b0:40b:5e1f:c382 with SMTP id
 h17-20020a05600c351100b0040b5e1fc382mr33475wmq.24.1701375770195; 
 Thu, 30 Nov 2023 12:22:50 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 fa23-20020a05600c519700b003fee6e170f9sm3028900wmb.45.2023.11.30.12.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 12:22:49 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 30 Nov 2023 20:22:27 +0000
Subject: [PATCH v5 3/9] mach-snapdragon: switch to PMIC button driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231130-b4-qcom-dt-compat-v5-3-41500e237ad0@linaro.org>
References: <20231130-b4-qcom-dt-compat-v5-0-41500e237ad0@linaro.org>
In-Reply-To: <20231130-b4-qcom-dt-compat-v5-0-41500e237ad0@linaro.org>
To: Ramon Fried <rfried.dev@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=13165;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=3vVA5fWR/xqYPXh1LCy36OWhPSOyrFDMxssL+OxQe3w=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSM96KzTkd+6DSskWz+oulcmnGPa69U4t81H5aqWhksC
 /3gtpe7o5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAEykOIeRYZNeDIOV162PfSsO
 5/P8Yvtl3BOVu0SwXSVoX2eS+lTlXQz/g+auct/+hif7a++8+L+PE1x73r657FBtnSnNU7H6seW
 HNgA=
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

The PMIC button driver is a much better representation of the hardware
here, adjust the boards to use upstream DT and the PMIC button driver
instead of exposing the buttons as GPIOs and relying on the GPIO-button
driver.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/dts/dragonboard410c-uboot.dtsi          | 11 ------
 arch/arm/dts/dragonboard410c.dts                 | 22 +++++++++---
 arch/arm/dts/dragonboard820c-uboot.dtsi          | 12 -------
 arch/arm/dts/dragonboard820c.dts                 | 23 ++++++++----
 arch/arm/dts/dragonboard845c-uboot.dtsi          | 11 ------
 arch/arm/dts/dragonboard845c.dts                 |  4 +++
 arch/arm/dts/sdm845.dtsi                         | 23 +++++++++---
 arch/arm/dts/starqltechn-uboot.dtsi              | 10 ------
 arch/arm/dts/starqltechn.dts                     | 20 +++--------
 arch/arm/mach-snapdragon/Kconfig                 |  3 ++
 arch/arm/mach-snapdragon/init_sdm845.c           | 45 +++++-------------------
 board/qualcomm/dragonboard410c/dragonboard410c.c | 31 ++++++----------
 board/qualcomm/dragonboard820c/dragonboard820c.c | 29 +++++----------
 13 files changed, 91 insertions(+), 153 deletions(-)

diff --git a/arch/arm/dts/dragonboard410c-uboot.dtsi b/arch/arm/dts/dragonboard410c-uboot.dtsi
index 3b0bd0ed0a1b..cec64bf80f99 100644
--- a/arch/arm/dts/dragonboard410c-uboot.dtsi
+++ b/arch/arm/dts/dragonboard410c-uboot.dtsi
@@ -42,14 +42,3 @@
 		gpios = <&pm8916_gpios 3 0>;
 	};
 };
-
-
-&pm8916_pon {
-	key_vol_down {
-		gpios = <&pm8916_pon 1 0>;
-	};
-
-	key_power {
-		gpios = <&pm8916_pon 0 0>;
-	};
-};
diff --git a/arch/arm/dts/dragonboard410c.dts b/arch/arm/dts/dragonboard410c.dts
index 9230dd3fd96c..c41fee977813 100644
--- a/arch/arm/dts/dragonboard410c.dts
+++ b/arch/arm/dts/dragonboard410c.dts
@@ -147,11 +147,23 @@
 				#address-cells = <0x1>;
 				#size-cells = <0x1>;
 
-				pm8916_pon: pm8916_pon@800 {
-					compatible = "qcom,pm8916-pwrkey";
-					reg = <0x800 0x96>;
-					#gpio-cells = <2>;
-					gpio-controller;
+				pon@800 {
+					compatible = "qcom,pm8916-pon";
+					reg = <0x800 0x100>;
+					mode-bootloader = <0x2>;
+					mode-recovery = <0x1>;
+
+					pwrkey {
+						compatible = "qcom,pm8941-pwrkey";
+						debounce = <15625>;
+						bias-pull-up;
+					};
+
+					pm8916_resin: resin {
+						compatible = "qcom,pm8941-resin";
+						debounce = <15625>;
+						bias-pull-up;
+					};
 				};
 
 				pm8916_gpios: pm8916_gpios@c000 {
diff --git a/arch/arm/dts/dragonboard820c-uboot.dtsi b/arch/arm/dts/dragonboard820c-uboot.dtsi
index 457728a43ecb..d93c7c1fbdee 100644
--- a/arch/arm/dts/dragonboard820c-uboot.dtsi
+++ b/arch/arm/dts/dragonboard820c-uboot.dtsi
@@ -30,15 +30,3 @@
 		};
 	};
 };
-
-&pm8994_pon {
-	key_vol_down {
-		gpios = <&pm8994_pon 1 0>;
-		label = "key_vol_down";
-	};
-
-	key_power {
-		gpios = <&pm8994_pon 0 0>;
-		label = "key_power";
-	};
-};
diff --git a/arch/arm/dts/dragonboard820c.dts b/arch/arm/dts/dragonboard820c.dts
index ad201d48749c..0d9c9f7a4922 100644
--- a/arch/arm/dts/dragonboard820c.dts
+++ b/arch/arm/dts/dragonboard820c.dts
@@ -109,12 +109,23 @@
 				#address-cells = <0x1>;
 				#size-cells = <0x1>;
 
-				pm8994_pon: pm8994_pon@800 {
-					compatible = "qcom,pm8994-pwrkey";
-					reg = <0x800 0x96>;
-					#gpio-cells = <2>;
-					gpio-controller;
-					gpio-bank-name="pm8994_key.";
+				pm8994_pon: pon@800 {
+					compatible = "qcom,pm8916-pon";
+					reg = <0x800 0x100>;
+					mode-bootloader = <0x2>;
+					mode-recovery = <0x1>;
+
+					pwrkey {
+						compatible = "qcom,pm8941-pwrkey";
+						debounce = <15625>;
+						bias-pull-up;
+					};
+
+					pm8994_resin: resin {
+						compatible = "qcom,pm8941-resin";
+						debounce = <15625>;
+						bias-pull-up;
+					};
 				};
 
 				pm8994_gpios: pm8994_gpios@c000 {
diff --git a/arch/arm/dts/dragonboard845c-uboot.dtsi b/arch/arm/dts/dragonboard845c-uboot.dtsi
index 7728f4f4a3e5..775f45c0149f 100644
--- a/arch/arm/dts/dragonboard845c-uboot.dtsi
+++ b/arch/arm/dts/dragonboard845c-uboot.dtsi
@@ -24,14 +24,3 @@
 		};
 	};
 };
-
-&pm8998_pon {
-	key_vol_down {
-		gpios = <&pm8998_pon 1 0>;
-		label = "key_vol_down";
-	};
-	key_power {
-		gpios = <&pm8998_pon 0 0>;
-		label = "key_power";
-	};
-};
diff --git a/arch/arm/dts/dragonboard845c.dts b/arch/arm/dts/dragonboard845c.dts
index b4f057ac6537..054f253eb32a 100644
--- a/arch/arm/dts/dragonboard845c.dts
+++ b/arch/arm/dts/dragonboard845c.dts
@@ -41,4 +41,8 @@
 	};
 };
 
+&pm8998_resin {
+	status = "okay";
+};
+
 #include "dragonboard845c-uboot.dtsi"
diff --git a/arch/arm/dts/sdm845.dtsi b/arch/arm/dts/sdm845.dtsi
index 4798ace0ff8b..cd5d890e9a45 100644
--- a/arch/arm/dts/sdm845.dtsi
+++ b/arch/arm/dts/sdm845.dtsi
@@ -78,12 +78,25 @@
 				#address-cells = <0x1>;
 				#size-cells = <0x1>;
 
-				pm8998_pon: pm8998_pon@800 {
-					compatible = "qcom,pm8998-pwrkey";
+				pm8998_pon: pon@800 {
+					compatible = "qcom,pm8998-pon";
+
 					reg = <0x800 0x100>;
-					#gpio-cells = <2>;
-					gpio-controller;
-					gpio-bank-name = "pm8998_key.";
+					mode-bootloader = <0x2>;
+					mode-recovery = <0x1>;
+
+					pm8998_pwrkey: pwrkey {
+						compatible = "qcom,pm8941-pwrkey";
+						debounce = <15625>;
+						bias-pull-up;
+					};
+
+					pm8998_resin: resin {
+						compatible = "qcom,pm8941-resin";
+						debounce = <15625>;
+						bias-pull-up;
+						status = "disabled";
+					};
 				};
 
 				pm8998_gpios: pm8998_gpios@c000 {
diff --git a/arch/arm/dts/starqltechn-uboot.dtsi b/arch/arm/dts/starqltechn-uboot.dtsi
index 034d5c1c07ed..55c6d18412ba 100644
--- a/arch/arm/dts/starqltechn-uboot.dtsi
+++ b/arch/arm/dts/starqltechn-uboot.dtsi
@@ -25,13 +25,3 @@
 	};
 };
 
-&pm8998_pon {
-	key_vol_down {
-		gpios = <&pm8998_pon 1 0>;
-		label = "key_vol_down";
-	};
-	key_power {
-		gpios = <&pm8998_pon 0 0>;
-		label = "key_power";
-	};
-};
diff --git a/arch/arm/dts/starqltechn.dts b/arch/arm/dts/starqltechn.dts
index 5b6372bee79a..0842e19adb60 100644
--- a/arch/arm/dts/starqltechn.dts
+++ b/arch/arm/dts/starqltechn.dts
@@ -45,22 +45,6 @@
 		format = "a8r8g8b8";
 	};
 
-	gpio-keys {
-		compatible = "gpio-keys";
-
-		key-pwr {
-			label = "Power";
-			linux,code = <KEY_ENTER>;
-			gpios = <&pm8998_pon 0 GPIO_ACTIVE_LOW>;
-		};
-
-		key-vol-down {
-			label = "Volume Down";
-			linux,code = <KEY_DOWN>;
-			gpios = <&pm8998_pon 1 GPIO_ACTIVE_LOW>;
-		};
-	};
-
 	soc: soc {
 		serial@a84000 {
 			status = "okay";
@@ -68,6 +52,10 @@
 	};
 };
 
+&pm8998_resin {
+	status = "okay";
+};
+
 &tlmm {
 	muic_i2c: muic-i2c-n {
 		pins = "GPIO_33", "GPIO_34";
diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index 3c9f3bee3f18..ad6671081910 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -17,6 +17,7 @@ config SDM845
 	select LINUX_KERNEL_IMAGE_HEADER
 	imply CLK_QCOM_SDM845
 	imply PINCTRL_QCOM_SDM845
+	imply BUTTON_QCOM_PMIC
 
 config LNX_KRNL_IMG_TEXT_OFFSET_BASE
 	default 0x80000000
@@ -30,6 +31,7 @@ config TARGET_DRAGONBOARD410C
 	select ENABLE_ARM_SOC_BOOT0_HOOK
 	imply CLK_QCOM_APQ8016
 	imply PINCTRL_QCOM_APQ8016
+	imply BUTTON_QCOM_PMIC
 	help
 	  Support for 96Boards Dragonboard 410C. This board complies with
 	  96Board Open Platform Specifications. Features:
@@ -45,6 +47,7 @@ config TARGET_DRAGONBOARD820C
 	bool "96Boards Dragonboard 820C"
 	imply CLK_QCOM_APQ8096
 	imply PINCTRL_QCOM_APQ8096
+	imply BUTTON_QCOM_PMIC
 	help
 	  Support for 96Boards Dragonboard 820C. This board complies with
 	  96Board Open Platform Specifications. Features:
diff --git a/arch/arm/mach-snapdragon/init_sdm845.c b/arch/arm/mach-snapdragon/init_sdm845.c
index 1f8850239437..067acc9a6f44 100644
--- a/arch/arm/mach-snapdragon/init_sdm845.c
+++ b/arch/arm/mach-snapdragon/init_sdm845.c
@@ -5,6 +5,7 @@
  * (C) Copyright 2021 Dzmitry Sankouski <dsankouski@gmail.com>
  */
 
+#include <button.h>
 #include <init.h>
 #include <env.h>
 #include <common.h>
@@ -32,46 +33,18 @@ __weak int board_init(void)
 /* Check for vol- and power buttons */
 __weak int misc_init_r(void)
 {
-	struct udevice *pon;
-	struct gpio_desc resin;
-	int node, ret;
+	struct udevice *btn;
+	int ret;
+	enum button_state_t state;
 
-	ret = uclass_get_device_by_name(UCLASS_GPIO, "pm8998_pon@800", &pon);
+	ret = button_get_by_label("pwrkey", &btn);
 	if (ret < 0) {
-		printf("Failed to find PMIC pon node. Check device tree\n");
-		return 0;
+		printf("Couldn't find power button!\n");
+		return ret;
 	}
 
-	node = fdt_subnode_offset(gd->fdt_blob, dev_of_offset(pon),
-				  "key_vol_down");
-	if (node < 0) {
-		printf("Failed to find key_vol_down node. Check device tree\n");
-		return 0;
-	}
-	if (gpio_request_by_name_nodev(offset_to_ofnode(node), "gpios", 0,
-				       &resin, 0)) {
-		printf("Failed to request key_vol_down button.\n");
-		return 0;
-	}
-	if (dm_gpio_get_value(&resin)) {
-		env_set("key_vol_down", "1");
-		printf("Volume down button pressed\n");
-	} else {
-		env_set("key_vol_down", "0");
-	}
-
-	node = fdt_subnode_offset(gd->fdt_blob, dev_of_offset(pon),
-				  "key_power");
-	if (node < 0) {
-		printf("Failed to find key_power node. Check device tree\n");
-		return 0;
-	}
-	if (gpio_request_by_name_nodev(offset_to_ofnode(node), "gpios", 0,
-				       &resin, 0)) {
-		printf("Failed to request key_power button.\n");
-		return 0;
-	}
-	if (dm_gpio_get_value(&resin)) {
+	state = button_get_state(btn);
+	if (state == BUTTON_ON) {
 		env_set("key_power", "1");
 		printf("Power button pressed\n");
 	} else {
diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.c b/board/qualcomm/dragonboard410c/dragonboard410c.c
index 371b3262f8c5..350e0e9e20aa 100644
--- a/board/qualcomm/dragonboard410c/dragonboard410c.c
+++ b/board/qualcomm/dragonboard410c/dragonboard410c.c
@@ -5,6 +5,7 @@
  * (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
  */
 
+#include <button.h>
 #include <common.h>
 #include <cpu_func.h>
 #include <dm.h>
@@ -108,32 +109,20 @@ int board_usb_init(int index, enum usb_init_type init)
 /* Check for vol- button - if pressed - stop autoboot */
 int misc_init_r(void)
 {
-	struct udevice *pon;
-	struct gpio_desc resin;
-	int node, ret;
+	struct udevice *btn;
+	int ret;
+	enum button_state_t state;
 
-	ret = uclass_get_device_by_name(UCLASS_GPIO, "pm8916_pon@800", &pon);
+	ret = button_get_by_label("vol_down", &btn);
 	if (ret < 0) {
-		printf("Failed to find PMIC pon node. Check device tree\n");
-		return 0;
+		printf("Couldn't find power button!\n");
+		return ret;
 	}
 
-	node = fdt_subnode_offset(gd->fdt_blob, dev_of_offset(pon),
-				  "key_vol_down");
-	if (node < 0) {
-		printf("Failed to find key_vol_down node. Check device tree\n");
-		return 0;
-	}
-
-	if (gpio_request_by_name_nodev(offset_to_ofnode(node), "gpios", 0,
-				       &resin, 0)) {
-		printf("Failed to request key_vol_down button.\n");
-		return 0;
-	}
-
-	if (dm_gpio_get_value(&resin)) {
+	state = button_get_state(btn);
+	if (state == BUTTON_ON) {
 		env_set("preboot", "setenv preboot; fastboot 0");
-		printf("key_vol_down pressed - Starting fastboot.\n");
+		printf("vol_down pressed - Starting fastboot.\n");
 	}
 
 	return 0;
diff --git a/board/qualcomm/dragonboard820c/dragonboard820c.c b/board/qualcomm/dragonboard820c/dragonboard820c.c
index 6785bf58e949..2f0db628368b 100644
--- a/board/qualcomm/dragonboard820c/dragonboard820c.c
+++ b/board/qualcomm/dragonboard820c/dragonboard820c.c
@@ -5,6 +5,7 @@
  * (C) Copyright 2017 Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
  */
 
+#include <button.h>
 #include <cpu_func.h>
 #include <init.h>
 #include <env.h>
@@ -139,30 +140,18 @@ void reset_cpu(void)
 /* Check for vol- button - if pressed - stop autoboot */
 int misc_init_r(void)
 {
-	struct udevice *pon;
-	struct gpio_desc resin;
-	int node, ret;
+	struct udevice *btn;
+	int ret;
+	enum button_state_t state;
 
-	ret = uclass_get_device_by_name(UCLASS_GPIO, "pm8994_pon@800", &pon);
+	ret = button_get_by_label("pwrkey", &btn);
 	if (ret < 0) {
-		printf("Failed to find PMIC pon node. Check device tree\n");
-		return 0;
+		printf("Couldn't find power button!\n");
+		return ret;
 	}
 
-	node = fdt_subnode_offset(gd->fdt_blob, dev_of_offset(pon),
-				  "key_vol_down");
-	if (node < 0) {
-		printf("Failed to find key_vol_down node. Check device tree\n");
-		return 0;
-	}
-
-	if (gpio_request_by_name_nodev(offset_to_ofnode(node), "gpios", 0,
-				       &resin, 0)) {
-		printf("Failed to request key_vol_down button.\n");
-		return 0;
-	}
-
-	if (dm_gpio_get_value(&resin)) {
+	state = button_get_state(btn);
+	if (state == BUTTON_ON) {
 		env_set("bootdelay", "-1");
 		printf("Power button pressed - dropping to console.\n");
 	}

-- 
2.42.1

