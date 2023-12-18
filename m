Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A6BC35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 07:25:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5460387DDA;
	Mon, 18 Dec 2023 08:25:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wifsNWND";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 433AD87DE8; Mon, 18 Dec 2023 08:25:12 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8766987DDD
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 08:25:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-28b82dc11e6so133459a91.1
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 23:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702884307; x=1703489107; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XGsLmeu6lxDABuW2GRQzNf/hk+50FqYGbIBY8Z4h744=;
 b=wifsNWNDrpXOcuergpnq45hkey0RfziuL1st0bJn0PErvo7EGeW4iZAzL7mRJRWnDy
 XD1FcYLR9OxTszxMYHO1T/SBz/PeHPqDkt2UE5ZOTgBblgblj8ptaBs4UL/aXn9b2OYX
 Ib6s/EFYM2Pr9BYvZ9rqNymNp9NwY8esug2L+HZ8OYrmcwIsAS/9uCGtHm6AqiifaPWi
 6dsCBXhI3TVkwsHnj4RUaTQQVEwuQm21AJIC/8DvOxEX8nHwP5YsJOGMur9+aHp3Dmpo
 9N4m05agQ7MFJc2dH9ElrHjDM86TxnZnEduluGxOEcS/HiKBeCQV28GP7LkifKBvWE7i
 SvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702884307; x=1703489107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XGsLmeu6lxDABuW2GRQzNf/hk+50FqYGbIBY8Z4h744=;
 b=fpAZvKONIX1B+tLyyHmbbuh5Jkr6hj3ijylNwhL49pJOTn2c5h2O0lfQLZDWTUw8IV
 sucgLvPzCuyHlK1VyKXibiPL2yAixhlftBwZ3ghTtznUtuW6jHnpdJ0KgExpWz3eIn2X
 nVqsiSQMS9YpBRkpehFhW7rBYWLjYEuswtH8JsRYW6oL+e9e6B3iucZMUu4fGX5RDnvB
 Rm5WLyHCGCLrhr78LLK/3LK4x1Zu9mmfVQzrspWurqlR9SOitd1uSOE7s9G2lKSFabPD
 Np1Utx15fWOUHfJiwnO4QxclFb41tyZD67I0E3KjjFVUTaOgvEpMaO0Pk0U+3gl/rxba
 aOoQ==
X-Gm-Message-State: AOJu0Yxnx2Kea6j0jHq3WGsgi+gmp6NkHwTI38e5TafXeB/guor3XxBM
 lpJfPBa+qIRCffrt/tGnoYpYYa3dcqcnGDV+fF9rhQ==
X-Google-Smtp-Source: AGHT+IHdt3NKnu9GVVL+KNAd9CiR9DZ4DQyVsErDB1IFjiM00qOsGqXc+S/oLW1PAN5jJzPjJTQClg==
X-Received: by 2002:a17:90a:8007:b0:28b:5540:60d7 with SMTP id
 b7-20020a17090a800700b0028b554060d7mr358632pjn.62.1702884306536; 
 Sun, 17 Dec 2023 23:25:06 -0800 (PST)
Received: from sumit-X1.. ([223.178.213.6]) by smtp.gmail.com with ESMTPSA id
 nr21-20020a17090b241500b0028b8b269aedsm1038997pjb.57.2023.12.17.23.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Dec 2023 23:25:06 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: caleb.connolly@linaro.org, neil.armstrong@linaro.org, lukma@denx.de,
 seanga2@gmail.com, marex@denx.de, laetitia.mariottini@se.com,
 pascal.eberhard@se.com, abdou.saker@se.com, jimmy.lalande@se.com,
 benjamin.missey@non.se.com, daniel.thompson@linaro.org,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 4/7] board: Add SE HMIBSC board support
Date: Mon, 18 Dec 2023 12:54:25 +0530
Message-Id: <20231218072428.1802969-5-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218072428.1802969-1-sumit.garg@linaro.org>
References: <20231218072428.1802969-1-sumit.garg@linaro.org>
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

Support for Schneider Electric HMIBSC. Features:
- Qualcomm Snapdragon 410C SoC - APQ8016 (4xCortex A53, Adreno 306)
- 2GiB RAM
- 64GiB eMMC, SD slot
- WiFi and Bluetooth
- 2x Host, 1x Device USB port
- HDMI
- Discrete TPM2 chip over SPI

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 arch/arm/dts/Makefile              |   1 +
 arch/arm/dts/hmibsc-uboot.dtsi     |  43 +++++++
 arch/arm/dts/hmibsc.dts            | 188 +++++++++++++++++++++++++++++
 arch/arm/mach-snapdragon/Kconfig   |  18 +++
 arch/arm/mach-snapdragon/Makefile  |   1 +
 board/schneider/hmibsc/Kconfig     |  15 +++
 board/schneider/hmibsc/MAINTAINERS |   6 +
 board/schneider/hmibsc/Makefile    |   5 +
 board/schneider/hmibsc/hmibsc.c    | 179 +++++++++++++++++++++++++++
 board/schneider/hmibsc/hmibsc.env  |  11 ++
 configs/hmibsc_defconfig           |  73 +++++++++++
 drivers/usb/host/Kconfig           |   1 +
 include/configs/hmibsc.h           |  19 +++
 13 files changed, 560 insertions(+)
 create mode 100644 arch/arm/dts/hmibsc-uboot.dtsi
 create mode 100644 arch/arm/dts/hmibsc.dts
 create mode 100644 board/schneider/hmibsc/Kconfig
 create mode 100644 board/schneider/hmibsc/MAINTAINERS
 create mode 100644 board/schneider/hmibsc/Makefile
 create mode 100644 board/schneider/hmibsc/hmibsc.c
 create mode 100644 board/schneider/hmibsc/hmibsc.env
 create mode 100644 configs/hmibsc_defconfig
 create mode 100644 include/configs/hmibsc.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 55aceb51cdb..59cfc318400 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -601,6 +601,7 @@ dtb-$(CONFIG_TARGET_SL28) += fsl-ls1028a-kontron-sl28.dtb \
 dtb-$(CONFIG_TARGET_TEN64) += fsl-ls1088a-ten64.dtb
 
 dtb-$(CONFIG_TARGET_DRAGONBOARD410C) += dragonboard410c.dtb
+dtb-$(CONFIG_TARGET_HMIBSC) += hmibsc.dtb
 dtb-$(CONFIG_TARGET_DRAGONBOARD820C) += dragonboard820c.dtb
 dtb-$(CONFIG_TARGET_STARQLTECHN) += starqltechn.dtb
 dtb-$(CONFIG_TARGET_QCS404EVB) += qcs404-evb.dtb
diff --git a/arch/arm/dts/hmibsc-uboot.dtsi b/arch/arm/dts/hmibsc-uboot.dtsi
new file mode 100644
index 00000000000..1629e9263f5
--- /dev/null
+++ b/arch/arm/dts/hmibsc-uboot.dtsi
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * U-Boot addition to handle HMIBSC pins
+ *
+ * (C) Copyright 2022 Sumit Garg <sumit.garg@linaro.org>
+ */
+
+/ {
+
+	smem {
+		bootph-all;
+	};
+
+	soc {
+		bootph-all;
+
+		pinctrl@1000000 {
+			bootph-all;
+
+			uart {
+				bootph-all;
+			};
+		};
+
+		qcom,gcc@1800000 {
+			bootph-all;
+		};
+
+		serial@78af000 {
+			bootph-all;
+		};
+	};
+};
+
+&pm8916_gpios {
+	usb_hub_reset_pm {
+		gpios = <&pm8916_gpios 2 0>;
+	};
+
+	usb_sw_sel_pm {
+		gpios = <&pm8916_gpios 3 0>;
+	};
+};
diff --git a/arch/arm/dts/hmibsc.dts b/arch/arm/dts/hmibsc.dts
new file mode 100644
index 00000000000..5b01870cb90
--- /dev/null
+++ b/arch/arm/dts/hmibsc.dts
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Qualcomm APQ8016 based HMIBSC board device tree source
+ *
+ * (C) Copyright 2023 Sumit Garg <sumit.garg@linaro.org>
+ */
+
+/dts-v1/;
+
+#include "skeleton64.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "Schneider Electric HMIBSC";
+	compatible = "se,hmibsc", "qcom,apq8016-sbc";
+	qcom,msm-id = <0xce 0x0 0xf8 0x0 0xf9 0x0 0xfa 0x0 0xf7 0x0>;
+	qcom,board-id = <0x10018 0x0>;
+	#address-cells = <0x2>;
+	#size-cells = <0x2>;
+
+	aliases {
+		usb0 = "/soc/ehci@78d9000";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0 0x80000000 0 0x3da00000>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		smem_mem: smem_region@86300000 {
+			reg = <0x0 0x86300000 0x0 0x100000>;
+			no-map;
+		};
+	};
+
+	chosen {
+		stdout-path = "/soc/serial@78af000";
+	};
+
+	smem {
+		compatible = "qcom,smem";
+		memory-region = <&smem_mem>;
+		qcom,rpm-msg-ram = <&rpm_msg_ram>;
+	};
+
+	soc {
+		#address-cells = <0x1>;
+		#size-cells = <0x1>;
+		ranges = <0x0 0x0 0x0 0xffffffff>;
+		compatible = "simple-bus";
+
+		rpm_msg_ram: memory@60000 {
+			compatible = "qcom,rpm-msg-ram";
+			reg = <0x60000 0x8000>;
+		};
+
+		soc_gpios: pinctrl@1000000 {
+			compatible = "qcom,msm8916-pinctrl";
+			reg = <0x1000000 0x400000>;
+			gpio-controller;
+			gpio-count = <122>;
+			gpio-bank-name="soc";
+			#gpio-cells = <2>;
+
+			blsp1_uart: uart {
+				function = "blsp1_uart";
+				pins = "GPIO_0", "GPIO_1", "GPIO_2", "GPIO_3";
+				drive-strength = <8>;
+				bias-disable;
+			};
+		};
+		clkc: qcom,gcc@1800000 {
+			compatible = "qcom,gcc-apq8016";
+			reg = <0x1800000 0x80000>;
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+		};
+
+		serial@78af000 {
+			compatible = "qcom,msm-uartdm-v1.4";
+			reg = <0x78af000 0x200>;
+			clock = <&clkc 5>;
+			pinctrl-names = "uart";
+			pinctrl-0 = <&blsp1_uart>;
+			gpios = <&soc_gpios 99 GPIO_ACTIVE_HIGH>,
+				<&soc_gpios 100 GPIO_ACTIVE_HIGH>;
+		};
+
+		ehci@78d9000 {
+			compatible = "qcom,ehci-host";
+			reg = <0x78d9000 0x400>;
+			phys = <&ehci_phy>;
+		};
+
+		ehci_phy: ehci_phy@78d9000 {
+			compatible = "qcom,apq8016-usbphy";
+			reg = <0x78d9000 0x400>;
+			#phy-cells = <0>;
+		};
+
+		sdhci@07824000 {
+			compatible = "qcom,sdhci-msm-v4";
+			reg = <0x7824900 0x11c 0x7824000 0x800>;
+			bus-width = <0x8>;
+			index = <0x0>;
+			non-removable;
+			clock = <&clkc 0>;
+			clock-frequency = <100000000>;
+		};
+
+		sdhci@07864000 {
+			compatible = "qcom,sdhci-msm-v4";
+			reg = <0x7864900 0x11c 0x7864000 0x800>;
+			index = <0x1>;
+			bus-width = <0x4>;
+			clock = <&clkc 1>;
+			clock-frequency = <200000000>;
+			cd-gpios = <&soc_gpios 38 GPIO_ACTIVE_LOW>;
+		};
+
+		wcnss {
+			bt {
+				compatible="qcom,wcnss-bt";
+			};
+
+			wifi {
+				compatible="qcom,wcnss-wlan";
+			};
+		};
+
+		spmi_bus: spmi@200f000 {
+			compatible = "qcom,spmi-pmic-arb";
+			reg = <0x0200f000 0x001000>,
+			      <0x02400000 0x400000>,
+			      <0x02c00000 0x400000>,
+			      <0x03800000 0x200000>,
+			      <0x0200a000 0x002100>;
+			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
+			#address-cells = <0x1>;
+			#size-cells = <0x1>;
+			pmic0: pm8916@0 {
+				compatible = "qcom,spmi-pmic";
+				reg = <0x0 0x1>;
+				#address-cells = <0x1>;
+				#size-cells = <0x1>;
+
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
+				};
+
+				pm8916_gpios: pm8916_gpios@c000 {
+					compatible = "qcom,pm8916-gpio";
+					reg = <0xc000 0x400>;
+					gpio-controller;
+					gpio-ranges = <&pm8916_gpios 0 0 4>;
+					#gpio-cells = <2>;
+				};
+			};
+
+			pmic1: pm8916@1 {
+				compatible = "qcom,spmi-pmic";
+				reg = <0x1 0x1>;
+			};
+		};
+	};
+};
+
+#include "hmibsc-uboot.dtsi"
diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index ad667108191..d1312f1c2ab 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -43,6 +43,23 @@ config TARGET_DRAGONBOARD410C
 	  - HDMI
 	  - 20-pin low speed and 40-pin high speed expanders, 4 LED, 3 buttons
 
+config TARGET_HMIBSC
+	bool "Schneider Electric HMIBSC"
+	select BOARD_LATE_INIT
+	select ENABLE_ARM_SOC_BOOT0_HOOK
+	imply CLK_QCOM_APQ8016
+	imply PINCTRL_QCOM_APQ8016
+	imply BUTTON_QCOM_PMIC
+	help
+	  Support for Schneider Electric HMIBSC. Features:
+	  - Qualcomm Snapdragon 410C SoC - APQ8016 (4xCortex A53, Adreno 306)
+	  - 2GiB RAM
+	  - 64GiB eMMC, SD slot
+	  - WiFi and Bluetooth
+	  - 2x Host, 1x Device USB port
+	  - HDMI
+	  - Discrete TPM2 chip over SPI
+
 config TARGET_DRAGONBOARD820C
 	bool "96Boards Dragonboard 820C"
 	imply CLK_QCOM_APQ8096
@@ -93,6 +110,7 @@ config TARGET_QCS404EVB
 endchoice
 
 source "board/qualcomm/dragonboard410c/Kconfig"
+source "board/schneider/hmibsc/Kconfig"
 source "board/qualcomm/dragonboard820c/Kconfig"
 source "board/qualcomm/dragonboard845c/Kconfig"
 source "board/samsung/starqltechn/Kconfig"
diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
index 3a3a297c176..971196942b7 100644
--- a/arch/arm/mach-snapdragon/Makefile
+++ b/arch/arm/mach-snapdragon/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_SDM845) += sysmap-sdm845.o
 obj-$(CONFIG_SDM845) += init_sdm845.o
 obj-$(CONFIG_TARGET_DRAGONBOARD820C) += sysmap-apq8096.o
 obj-$(CONFIG_TARGET_DRAGONBOARD410C) += sysmap-apq8016.o
+obj-$(CONFIG_TARGET_HMIBSC) += sysmap-apq8016.o
 obj-y += misc.o
 obj-y += dram.o
 obj-$(CONFIG_TARGET_QCS404EVB) += sysmap-qcs404.o
diff --git a/board/schneider/hmibsc/Kconfig b/board/schneider/hmibsc/Kconfig
new file mode 100644
index 00000000000..f093350b868
--- /dev/null
+++ b/board/schneider/hmibsc/Kconfig
@@ -0,0 +1,15 @@
+if TARGET_HMIBSC
+
+config SYS_BOARD
+	default "hmibsc"
+
+config SYS_VENDOR
+	default "schneider"
+
+config SYS_SOC
+	default "apq8016"
+
+config SYS_CONFIG_NAME
+	default "hmibsc"
+
+endif
diff --git a/board/schneider/hmibsc/MAINTAINERS b/board/schneider/hmibsc/MAINTAINERS
new file mode 100644
index 00000000000..0f31bbda966
--- /dev/null
+++ b/board/schneider/hmibsc/MAINTAINERS
@@ -0,0 +1,6 @@
+HMIBSC BOARD
+M:	Sumit Garg <sumit.garg@linaro.org>
+S:	Maintained
+F:	board/schneider/hmibsc/
+F:	include/configs/hmibsc.h
+F:	configs/hmibsc_defconfig
diff --git a/board/schneider/hmibsc/Makefile b/board/schneider/hmibsc/Makefile
new file mode 100644
index 00000000000..7c9edd6a90d
--- /dev/null
+++ b/board/schneider/hmibsc/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# (C) Copyright 2023 Sumit Garg <sumit.garg@linaro.org>
+
+obj-y	:= hmibsc.o
diff --git a/board/schneider/hmibsc/hmibsc.c b/board/schneider/hmibsc/hmibsc.c
new file mode 100644
index 00000000000..b2d506b528b
--- /dev/null
+++ b/board/schneider/hmibsc/hmibsc.c
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Board init file for SE HMIBSC
+ *
+ * (C) Copyright 2023 Sumit Garg <sumit.garg@linaro.org>
+ */
+
+#include <button.h>
+#include <cpu_func.h>
+#include <dm.h>
+#include <env.h>
+#include <init.h>
+#include <net.h>
+#include <usb.h>
+#include <asm/cache.h>
+#include <asm/global_data.h>
+#include <asm/gpio.h>
+#include <fdt_support.h>
+#include <asm/arch/dram.h>
+#include <asm/arch/misc.h>
+#include <linux/delay.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int dram_init(void)
+{
+	gd->ram_size = PHYS_SDRAM_1_SIZE;
+
+	return 0;
+}
+
+int dram_init_banksize(void)
+{
+	gd->bd->bi_dram[0].start = PHYS_SDRAM_1;
+	gd->bd->bi_dram[0].size = PHYS_SDRAM_1_SIZE;
+
+	return 0;
+}
+
+int board_usb_init(int index, enum usb_init_type init)
+{
+	static struct udevice *pmic_gpio;
+	static struct gpio_desc hub_reset, usb_sel;
+	int ret = 0, node;
+
+	if (!pmic_gpio) {
+		ret = uclass_get_device_by_name(UCLASS_GPIO,
+						"pm8916_gpios@c000",
+						&pmic_gpio);
+		if (ret < 0) {
+			printf("Failed to find pm8916_gpios@c000 node.\n");
+			return ret;
+		}
+	}
+
+	/* Try to request gpios needed to start usb host on dragonboard */
+	if (!dm_gpio_is_valid(&hub_reset)) {
+		node = fdt_subnode_offset(gd->fdt_blob,
+					  dev_of_offset(pmic_gpio),
+					  "usb_hub_reset_pm");
+		if (node < 0) {
+			printf("Failed to find usb_hub_reset_pm dt node.\n");
+			return node;
+		}
+		ret = gpio_request_by_name_nodev(offset_to_ofnode(node),
+						 "gpios", 0, &hub_reset, 0);
+		if (ret < 0) {
+			printf("Failed to request usb_hub_reset_pm gpio.\n");
+			return ret;
+		}
+	}
+
+	if (!dm_gpio_is_valid(&usb_sel)) {
+		node = fdt_subnode_offset(gd->fdt_blob,
+					  dev_of_offset(pmic_gpio),
+					  "usb_sw_sel_pm");
+		if (node < 0) {
+			printf("Failed to find usb_sw_sel_pm dt node.\n");
+			return 0;
+		}
+		ret = gpio_request_by_name_nodev(offset_to_ofnode(node),
+						 "gpios", 0, &usb_sel, 0);
+		if (ret < 0) {
+			printf("Failed to request usb_sw_sel_pm gpio.\n");
+			return ret;
+		}
+	}
+
+	if (init == USB_INIT_HOST) {
+		/* Start USB Hub */
+		dm_gpio_set_dir_flags(&hub_reset,
+				      GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
+		mdelay(100);
+		/* Switch usb to host connectors */
+		dm_gpio_set_dir_flags(&usb_sel,
+				      GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
+		mdelay(100);
+	} else { /* Device */
+		/* Disable hub */
+		dm_gpio_set_dir_flags(&hub_reset, GPIOD_IS_OUT);
+		/* Switch back to device connector */
+		dm_gpio_set_dir_flags(&usb_sel, GPIOD_IS_OUT);
+	}
+
+	return 0;
+}
+
+/* Check for vol- button - if pressed - stop autoboot */
+int misc_init_r(void)
+{
+	struct udevice *btn;
+	int ret;
+	enum button_state_t state;
+
+	ret = button_get_by_label("vol_down", &btn);
+	if (ret < 0) {
+		printf("Couldn't find power button!\n");
+		return ret;
+	}
+
+	state = button_get_state(btn);
+	if (state == BUTTON_ON) {
+		env_set("preboot", "setenv preboot; fastboot 0");
+		printf("vol_down pressed - Starting fastboot.\n");
+	}
+
+	return 0;
+}
+
+int board_init(void)
+{
+	return 0;
+}
+
+int board_late_init(void)
+{
+	return 0;
+}
+
+/*
+ * Fixup of DTB for Linux Kernel
+ * 1. Fixup installed DRAM.
+ * 2. Fixup WLAN/BT Mac address:
+ *	First, check if MAC addresses for WLAN/BT exists as environemnt
+ *	variables wlanaddr,btaddr. if not, generate a unique address.
+ */
+
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	u8 mac[ARP_HLEN];
+
+	msm_fixup_memory(blob);
+
+	if (!eth_env_get_enetaddr("wlanaddr", mac)) {
+		msm_generate_mac_addr(mac);
+	};
+
+	do_fixup_by_compat(blob, "qcom,wcnss-wlan",
+			   "local-mac-address", mac, ARP_HLEN, 1);
+
+	if (!eth_env_get_enetaddr("btaddr", mac)) {
+		msm_generate_mac_addr(mac);
+
+		/*
+		 * The BD address is same as WLAN MAC address but with
+		 * least significant bit flipped.
+		 */
+		mac[0] ^= 0x01;
+	};
+
+	do_fixup_by_compat(blob, "qcom,wcnss-bt",
+			   "local-bd-address", mac, ARP_HLEN, 1);
+	return 0;
+}
+
+void reset_cpu(void)
+{
+	psci_system_reset();
+}
diff --git a/board/schneider/hmibsc/hmibsc.env b/board/schneider/hmibsc/hmibsc.env
new file mode 100644
index 00000000000..692722058f5
--- /dev/null
+++ b/board/schneider/hmibsc/hmibsc.env
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+loadaddr=0x90000000
+initrd_high=0xffffffffffffffff
+linux_image=Image
+kernel_addr_r=0x81000000
+fdtfile=qcom/hmibsc.dtb
+fdt_addr_r=0x83000000
+ramdisk_addr_r=0x84000000
+scriptaddr=0x90000000
+pxefile_addr_r=0x90100000
diff --git a/configs/hmibsc_defconfig b/configs/hmibsc_defconfig
new file mode 100644
index 00000000000..cef9e304b3a
--- /dev/null
+++ b/configs/hmibsc_defconfig
@@ -0,0 +1,73 @@
+CONFIG_ARM=y
+CONFIG_COUNTER_FREQUENCY=19000000
+CONFIG_ARCH_SNAPDRAGON=y
+CONFIG_TEXT_BASE=0x8f600000
+CONFIG_SYS_MALLOC_LEN=0x802000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x8007fff0
+CONFIG_ENV_SIZE=0x2000
+CONFIG_ENV_OFFSET=0x0
+CONFIG_TARGET_HMIBSC=y
+CONFIG_DEFAULT_DEVICE_TREE="hmibsc"
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_IDENT_STRING="\nSchneider Electric-HMIBSC"
+CONFIG_SYS_LOAD_ADDR=0x80080000
+CONFIG_REMAKE_ELF=y
+# CONFIG_ANDROID_BOOT_IMAGE is not set
+CONFIG_FIT=y
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_USE_PREBOOT=y
+# CONFIG_DISPLAY_CPUINFO is not set
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_MISC_INIT_R=y
+CONFIG_SYS_PROMPT="hmibsc => "
+CONFIG_SYS_MAXARGS=64
+CONFIG_SYS_CBSIZE=512
+CONFIG_SYS_PBSIZE=548
+# CONFIG_CMD_IMI is not set
+CONFIG_CMD_MD5SUM=y
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_USB=y
+CONFIG_BOOTP_BOOTFILESIZE=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_TIMER=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_CLK=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x91000000
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_MSM_GPIO=y
+CONFIG_QCOM_PMIC_GPIO=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_MSM=y
+CONFIG_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_PINCONF=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_QCOM=y
+CONFIG_MSM_SERIAL=y
+CONFIG_SPMI_MSM=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_MSM=y
+CONFIG_USB_ULPI_VIEWPORT=y
+CONFIG_USB_ULPI=y
+CONFIG_USB_HOST_ETHER=y
+CONFIG_USB_ETHER_ASIX=y
+CONFIG_USB_ETHER_ASIX88179=y
+CONFIG_USB_ETHER_MCS7830=y
+CONFIG_USB_ETHER_SMSC95XX=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_VENDOR_NUM=0x18d1
+CONFIG_USB_GADGET_PRODUCT_NUM=0xd00d
+CONFIG_CI_UDC=y
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index b501ea514bc..776466978f7 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -266,6 +266,7 @@ config USB_EHCI_MSM
 	depends on DM_USB
 	select USB_ULPI_VIEWPORT
 	select MSM8916_USB_PHY
+	select EHCI_HCD_INIT_AFTER_RESET
 	---help---
 	  Enables support for the on-chip EHCI controller on Qualcomm
 	  Snapdragon SoCs.
diff --git a/include/configs/hmibsc.h b/include/configs/hmibsc.h
new file mode 100644
index 00000000000..04052ed6dee
--- /dev/null
+++ b/include/configs/hmibsc.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Board configuration file for HMIBSC
+ *
+ * (C) Copyright 2023 Sumit Garg <sumit.garg@linaro.org>
+ */
+
+#ifndef __CONFIGS_HMIBSC_H
+#define __CONFIGS_HMIBSC_H
+
+#include <linux/sizes.h>
+
+/* Physical Memory Map */
+#define PHYS_SDRAM_1			0x80000000
+/* Note: 8 MiB (0x86000000 - 0x86800000) are reserved for tz/smem/hyp/rmtfs/rfsa */
+#define PHYS_SDRAM_1_SIZE		SZ_1G
+#define CFG_SYS_SDRAM_BASE		PHYS_SDRAM_1
+
+#endif
-- 
2.34.1

