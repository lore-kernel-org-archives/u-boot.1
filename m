Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C4B3E7E64B
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 16:36:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2987F86DE9;
	Tue, 26 Sep 2023 18:36:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=conclusive.pl header.i=@conclusive.pl header.b="jAYfEGnU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F2E786DE0; Tue, 26 Sep 2023 18:36:04 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5ADD686DBA
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 18:36:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=conclusive.pl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=artur@conclusive.pl
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2b95d5ee18dso156580171fa.1
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 09:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=conclusive.pl; s=google; t=1695746160; x=1696350960; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DNGR/iNDaGepkDy6C0F7g21rmB9w9BooNfNZ/6R4/N8=;
 b=jAYfEGnU6NJFd4VJcd7KFpYIjlg15aZVaB1Obq5xEifmUw/oJmPwShA2R999pZLUC3
 Aljyl6XEII84M9N/PY/hl0g6be/n2LRzLSzr9PDvLk4VmbTMx4a2hvYIxW42xoNWem1+
 +UIm6PY8/td7mss49b51KyNZTeUFCYCi6s9f6CnMXZ3bmwmn7xfRa37V6f5hdN5hWr3i
 /kBArWyv2YbdLeUSx20PAR3bNpYU+ZLGwhkyrsvViQPj01cLVIEzoaAa15g6qJ/Hr7OT
 cB0I4yDoIolWl9E94KEQhvvqZRJ2GhQVvi8KqaU248uCErsK3a+DmOHXJwSTbQJUhJeh
 Di1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695746160; x=1696350960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DNGR/iNDaGepkDy6C0F7g21rmB9w9BooNfNZ/6R4/N8=;
 b=wn/TfsXldB/piVvdb4iJki26XnNFf9VXBR64x4Ot3BI55duSFT8W8DLNMfGoHb22lt
 QqceThnV+LsYvBMLi6H4bJOyt8RuYAcDxV7N4grj7T+KjnyuR8FakvqMEq1Pjb8KvdpW
 PEGEFeLPNOO7jRMt0rQGDumcxA1btNk4IBQTqzzIiUn4k1EDjT2YMb0lZ0JfXkWqAR9T
 oSDEUHPPSQ3Ncy/M0Dkb6tFP7ZYK6vmwqBDsv7ORN1sx7t6RoI1lOHqrhOSo8ztF9eYf
 UKIEOz+ofMpbV0wOpQlx9Rzqzpu1E0AcRiF9pVkC9psoxYwIG4QjYTuAWrUoyqx7+hf/
 TvCg==
X-Gm-Message-State: AOJu0YxyQG+vmoX5OvMa1PntwE9IOxS8bBwng0ZvSTE0Nd+x1E6AN4OG
 XEFUFSJbjQcMt7USlRLSfvCuYA==
X-Google-Smtp-Source: AGHT+IEPUqCtXsC0e9iVBIPf+scDVCqnsT6Uj2jWhMzTwmqRVK75LpWw8mP9dabHneOk3EmkiVCLuQ==
X-Received: by 2002:a2e:81d0:0:b0:2bf:e855:8cbf with SMTP id
 s16-20020a2e81d0000000b002bfe8558cbfmr8768922ljg.35.1695746160609; 
 Tue, 26 Sep 2023 09:36:00 -0700 (PDT)
Received: from localhost.localdomain (host-89.25.128.123.static.3s.pl.
 [89.25.128.123]) by smtp.gmail.com with ESMTPSA id
 x18-20020a2e9c92000000b002c12630e4d3sm2698544lji.127.2023.09.26.09.35.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 09:36:00 -0700 (PDT)
From: Artur Rojek <artur@conclusive.pl>
To: Eugen Hristev <eugen.hristev@collabora.com>,
 Simon Glass <sjg@chromium.org>, Jakub Klama <jakub@conclusive.pl>,
 Marcin Jabrzyk <marcin@conclusive.pl>
Cc: Wojciech Kloska <wojciech@conclusive.pl>, u-boot@lists.denx.de,
 Artur Rojek <artur@conclusive.pl>
Subject: [PATCH v2 3/3] board: Add support for Conclusive KSTR-SAMA5D27
Date: Tue, 26 Sep 2023 18:35:10 +0200
Message-ID: <20230926163510.219804-4-artur@conclusive.pl>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230926163510.219804-1-artur@conclusive.pl>
References: <20230926163510.219804-1-artur@conclusive.pl>
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

Introduce support for Conclusive KSTR-SAMA5D27 Single Board Computer.

Co-developed-by: Jakub Klama <jakub@conclusive.pl>
Signed-off-by: Jakub Klama <jakub@conclusive.pl>
Co-developed-by: Marcin Jabrzyk <marcin@conclusive.pl>
Signed-off-by: Marcin Jabrzyk <marcin@conclusive.pl>
Signed-off-by: Artur Rojek <artur@conclusive.pl>
---

v2: - remove redundant license text from at91-kstr-sama5d27.dts
    - when defining properties in .dts, reference nodes by labels
    - drop nodes for usb0 and pmic, as these aren't used by drivers 
    - switch i2c to flexcom driver and make the necessary dts changes
    - sort includes in at91-kstr-sama5d27.dts alphabetically

 arch/arm/dts/Makefile                         |   3 +
 arch/arm/dts/at91-kstr-sama5d27.dts           | 131 ++++++++++
 arch/arm/mach-at91/Kconfig                    |  13 +
 board/conclusive/kstr-sama5d27/Kconfig        |  15 ++
 board/conclusive/kstr-sama5d27/MAINTAINERS    |   8 +
 board/conclusive/kstr-sama5d27/Makefile       |   5 +
 .../conclusive/kstr-sama5d27/kstr-sama5d27.c  | 234 ++++++++++++++++++
 configs/kstr_sama5d27_defconfig               |  80 ++++++
 include/configs/kstr-sama5d27.h               |  15 ++
 9 files changed, 504 insertions(+)
 create mode 100644 arch/arm/dts/at91-kstr-sama5d27.dts
 create mode 100644 board/conclusive/kstr-sama5d27/Kconfig
 create mode 100644 board/conclusive/kstr-sama5d27/MAINTAINERS
 create mode 100644 board/conclusive/kstr-sama5d27/Makefile
 create mode 100644 board/conclusive/kstr-sama5d27/kstr-sama5d27.c
 create mode 100644 configs/kstr_sama5d27_defconfig
 create mode 100644 include/configs/kstr-sama5d27.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 85fd5b1157b1..8e4d33c01912 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1198,6 +1198,9 @@ dtb-$(CONFIG_TARGET_SAMA5D27_SOM1_EK) += \
 dtb-$(CONFIG_TARGET_SAMA5D27_WLSOM1_EK) += \
 	at91-sama5d27_wlsom1_ek.dtb
 
+dtb-$(CONFIG_TARGET_KSTR_SAMA5D27) += \
+	at91-kstr-sama5d27.dtb
+
 dtb-$(CONFIG_TARGET_SAMA5D2_ICP) += \
 	at91-sama5d2_icp.dtb
 
diff --git a/arch/arm/dts/at91-kstr-sama5d27.dts b/arch/arm/dts/at91-kstr-sama5d27.dts
new file mode 100644
index 000000000000..fe9ec7e5bbc3
--- /dev/null
+++ b/arch/arm/dts/at91-kstr-sama5d27.dts
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0+ OR X11
+/*
+ * at91-kstr-sama5d27.dts - Device Tree file for Conclusive KSTR-SAMA5D27 board
+ *
+ *  Copyright (C) 2019-2023 Conclusive Engineering Sp. z o. o.
+ *
+ */
+/dts-v1/;
+
+#include "sama5d2.dtsi"
+#include "sama5d2-pinfunc.h"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/mfd/atmel-flexcom.h>
+
+/ {
+	model = "Conclusive KSTR-SAMA5D27";
+	compatible = "conclusive,kstr-sama5d27", "atmel,sama5d2", "atmel,sama5";
+
+	chosen {
+		bootph-all;
+		stdout-path = &uart1;
+	};
+};
+
+&main_xtal {
+	clock-frequency = <12000000>;
+};
+
+&sdmmc0 {
+	bus-width = <4>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sdmmc0_cmd_dat_default &pinctrl_sdmmc0_ck_cd_default>;
+	status = "okay";
+	bootph-all;
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1_default>;
+	status = "okay";
+	bootph-all;
+};
+
+&macb0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_macb0_rmii &pinctrl_macb0_phy_irq>;
+	phy-mode = "rmii";
+	status = "okay";
+
+	ethernet-phy@0 {
+		reg = <0x0>;
+		reset-gpios = <&pioA 44 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&flx4 {
+	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_TWI>;
+	status = "okay";
+};
+
+&i2c6 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flx4_i2c>;
+	status = "okay";
+
+	eeprom: eeprom@50 {
+		compatible = "microchip,24c32", "atmel,24c32";
+		reg = <0x50>;
+		read-only;
+		pagesize = <32>;
+		status = "okay";
+	};
+};
+
+&pioA {
+	pinctrl {
+		pinctrl_uart1_default: uart1_default {
+			pinmux = <PIN_PD2__URXD1>,
+				 <PIN_PD3__UTXD1>;
+			bias-disable;
+			bootph-all;
+		};
+
+		pinctrl_macb0_phy_irq: macb0_phy_irq {
+			pinmux = <PIN_PB13__GPIO>;
+			bias-disable;
+			bootph-all;
+		};
+
+		pinctrl_macb0_rmii: macb0_rmii {
+			pinmux = <PIN_PB14__GTXCK>,
+				 <PIN_PB15__GTXEN>,
+				 <PIN_PB16__GRXDV>,
+				 <PIN_PB17__GRXER>,
+				 <PIN_PB18__GRX0>,
+				 <PIN_PB19__GRX1>,
+				 <PIN_PB20__GTX0>,
+				 <PIN_PB21__GTX1>,
+				 <PIN_PB22__GMDC>,
+				 <PIN_PB23__GMDIO>;
+			bias-disable;
+			bootph-all;
+		};
+
+		pinctrl_sdmmc0_cmd_dat_default: sdmmc0_cmd_dat_default {
+			pinmux = <PIN_PA1__SDMMC0_CMD>,
+				 <PIN_PA2__SDMMC0_DAT0>,
+				 <PIN_PA3__SDMMC0_DAT1>,
+				 <PIN_PA4__SDMMC0_DAT2>,
+				 <PIN_PA5__SDMMC0_DAT3>;
+			bias-pull-up;
+			bootph-all;
+		};
+
+		pinctrl_sdmmc0_ck_cd_default: sdmmc0_ck_cd_default {
+			pinmux = <PIN_PA0__SDMMC0_CK>,
+				 <PIN_PA11__SDMMC0_VDDSEL>,
+				 <PIN_PA13__SDMMC0_CD>;
+			bias-disable;
+			bootph-all;
+		};
+
+		pinctrl_flx4_i2c: flx4_i2c {
+			pinmux = <PIN_PC28__FLEXCOM4_IO0>,
+				 <PIN_PC29__FLEXCOM4_IO1>;
+			bias-disable;
+		};
+	};
+};
diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 7c2e4ebbdb0f..9ab1a9339ee1 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -204,6 +204,18 @@ config TARGET_SAMA5D27_WLSOM1_EK
 	  processor-based SAMA5D2 MPU with 2 Gbit LPDDR2-SDRAM
 	  in a single package.
 
+config TARGET_KSTR_SAMA5D27
+	bool "Conclusive KSTR-SAMA5D27 board"
+	select BOARD_EARLY_INIT_F
+	select SAMA5D2
+	select BOARD_LATE_INIT
+	help
+	  The KSTR-SAMA5D27 embeds SAMA5D27 SoC, together with
+	  256 MiB SDRAM, 10/100 Mbit/s Ethernet, 96 Mbit/s Wi-Fi b/g/n,
+	  Bluetooth 4.1 LE, USB OTG controller w/ type-C USB connector
+	  and stackable GPIO headers in an all-in-one SBC form factor:
+	  https://conclusive.pl/products/kstr-sama5d27-sbc/
+
 config TARGET_SAMA5D2_ICP
 	bool "SAMA5D2 Industrial Connectivity Platform (ICP)"
 	select SAMA5D2
@@ -352,6 +364,7 @@ source "board/atmel/sama5d4_xplained/Kconfig"
 source "board/atmel/sama5d4ek/Kconfig"
 source "board/bluewater/gurnard/Kconfig"
 source "board/calao/usb_a9263/Kconfig"
+source "board/conclusive/kstr-sama5d27/Kconfig"
 source "board/egnite/ethernut5/Kconfig"
 source "board/esd/meesc/Kconfig"
 source "board/gardena/smart-gateway-at91sam/Kconfig"
diff --git a/board/conclusive/kstr-sama5d27/Kconfig b/board/conclusive/kstr-sama5d27/Kconfig
new file mode 100644
index 000000000000..572551cfda98
--- /dev/null
+++ b/board/conclusive/kstr-sama5d27/Kconfig
@@ -0,0 +1,15 @@
+if TARGET_KSTR_SAMA5D27
+
+config SYS_BOARD
+	default "kstr-sama5d27"
+
+config SYS_VENDOR
+	default "conclusive"
+
+config SYS_SOC
+	default "at91"
+
+config SYS_CONFIG_NAME
+	default "kstr-sama5d27"
+
+endif
diff --git a/board/conclusive/kstr-sama5d27/MAINTAINERS b/board/conclusive/kstr-sama5d27/MAINTAINERS
new file mode 100644
index 000000000000..cb1635cdd280
--- /dev/null
+++ b/board/conclusive/kstr-sama5d27/MAINTAINERS
@@ -0,0 +1,8 @@
+CONCLUSIVE KSTR-SAMA5D27 BOARD
+M:	Jakub Klama <jakub@conclusive.pl>
+M:	Artur Rojek <artur@conclusive.pl>
+S:	Maintained
+F:	board/conclusive/kstr-sama5d27
+F:	include/configs/kstr-sama5d27.h
+F:	configs/kstr_sama5d27_defconfig
+F:	arch/arm/dts/at91-kstr-sama5d27.dts
diff --git a/board/conclusive/kstr-sama5d27/Makefile b/board/conclusive/kstr-sama5d27/Makefile
new file mode 100644
index 000000000000..edf7d1c93441
--- /dev/null
+++ b/board/conclusive/kstr-sama5d27/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2019-2023 Conclusive Engineering Sp. z o. o.
+
+obj-y += kstr-sama5d27.o
diff --git a/board/conclusive/kstr-sama5d27/kstr-sama5d27.c b/board/conclusive/kstr-sama5d27/kstr-sama5d27.c
new file mode 100644
index 000000000000..33dbb95734bb
--- /dev/null
+++ b/board/conclusive/kstr-sama5d27/kstr-sama5d27.c
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * kstr-sama5d27.c - Board init file for Conclusive KSTR-SAMA5D27 board
+ * Copyright (C) 2021-2023 Conclusive Engineering Sp. z o. o.
+ */
+
+#include <common.h>
+#include <debug_uart.h>
+#include <init.h>
+#include <env.h>
+#include <fdt_support.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <asm/arch/at91_common.h>
+#include <asm/arch/atmel_pio4.h>
+#include <asm/arch/atmel_mpddrc.h>
+#include <asm/arch/atmel_sdhci.h>
+#include <asm/arch/clk.h>
+#include <asm/arch/gpio.h>
+#include <asm/arch/sama5d2.h>
+#include <linux/delay.h>
+
+#ifdef CONFIG_USB_GADGET_ATMEL_USBA
+#include <asm/arch/atmel_usba_udc.h>
+#endif
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#ifdef CONFIG_DEBUG_UART_BOARD_INIT
+static void board_uart1_hw_init(void)
+{
+	/* URXD1 */
+	atmel_pio4_set_a_periph(AT91_PIO_PORTD, 2, ATMEL_PIO_PUEN_MASK);
+	/* UTXD1 */
+	atmel_pio4_set_a_periph(AT91_PIO_PORTD, 3, 0);
+	at91_periph_clk_enable(ATMEL_ID_UART1);
+}
+
+void board_debug_uart_init(void)
+{
+	board_uart1_hw_init();
+}
+#endif
+
+void board_lan8720a_init(void)
+{
+	/* LAN8720A_nRST */
+	atmel_pio4_set_pio_output(AT91_PIO_PORTB, 12, 0);
+	/*
+	 * Force 0 on RXER/PHYAD0. LAN8720A chipset will latch with address 0 on
+	 * MDIO bus.
+	 */
+	atmel_pio4_set_pio_output(AT91_PIO_PORTB, 17, 0);
+	/* Minimal delay of reset signal is 25 ms */
+	mdelay(30);
+	/* LAN8720A_nRST */
+	atmel_pio4_set_pio_output(AT91_PIO_PORTB, 12, 1);
+}
+
+void board_usba_init(void)
+{
+#ifdef CONFIG_USB_GADGET_ATMEL_USBA
+	/* USB device peripheral initialization: sama5d2_devices.c */
+	at91_udp_hw_init();
+	/* USB device controller drivers/usb/gadget/atmel_usba_udc.c */
+	usba_udc_probe(&pdata);
+#endif
+}
+
+#ifdef CONFIG_BOARD_EARLY_INIT_F
+int board_early_init_f(void)
+{
+#ifdef CONFIG_DEBUG_UART
+	debug_uart_init();
+#endif
+
+	return 0;
+}
+#endif
+
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	char *wlanaddr = env_get("eth1addr");
+
+	if (wlanaddr)
+		do_fixup_by_compat(blob, "brcm,bcm4329-fmac", "local-mac-address",
+				   wlanaddr, strlen(wlanaddr), 1);
+	else
+		printf("Not setting WIFI mac address. Check if EEPROM TLV is correctly set up.\n");
+
+	return 0;
+}
+
+int board_init(void)
+{
+	/* address of boot parameters */
+	gd->bd->bi_boot_params = CFG_SYS_SDRAM_BASE + 0x100;
+
+	board_usba_init();
+	board_lan8720a_init();
+
+	return 0;
+}
+
+#ifdef CONFIG_BOARD_LATE_INIT
+int board_late_init(void)
+{
+	const char *serial_number;
+
+	eeprom_read_serial(0);
+
+	printf("Conclusive KSTR-SAMA5D27\n");
+
+	serial_number = env_get("serial#");
+	if (!serial_number)
+		printf("Warning: unknown serial number.\n");
+	else
+		printf("Serial number %s\n", serial_number);
+
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_MISC_INIT_R
+int misc_init_r(void)
+{
+	return 0;
+}
+#endif
+
+int dram_init(void)
+{
+	gd->ram_size = get_ram_size((void *)CFG_SYS_SDRAM_BASE,
+				    CFG_SYS_SDRAM_SIZE);
+	return 0;
+}
+
+/* SPL */
+#ifdef CONFIG_SPL_BUILD
+void spl_board_init(void)
+{
+}
+
+static void ddrc_conf(struct atmel_mpddrc_config *ddrc)
+{
+	ddrc->md = (ATMEL_MPDDRC_MD_DBW_16_BITS | ATMEL_MPDDRC_MD_DDR2_SDRAM);
+
+	ddrc->cr = (ATMEL_MPDDRC_CR_NC_COL_10 |
+		    ATMEL_MPDDRC_CR_NR_ROW_13 |
+		    ATMEL_MPDDRC_CR_CAS_DDR_CAS3 |
+		    ATMEL_MPDDRC_CR_DIC_DS |
+		    ATMEL_MPDDRC_CR_ZQ_LONG |
+		    ATMEL_MPDDRC_CR_NB_8BANKS |
+		    ATMEL_MPDDRC_CR_DECOD_INTERLEAVED |
+		    ATMEL_MPDDRC_CR_UNAL_SUPPORTED);
+
+	ddrc->rtr = 0x511;
+
+	ddrc->tpr0 = ((7 << ATMEL_MPDDRC_TPR0_TRAS_OFFSET) |
+		      (3 << ATMEL_MPDDRC_TPR0_TRCD_OFFSET) |
+		      (3 << ATMEL_MPDDRC_TPR0_TWR_OFFSET) |
+		      (9 << ATMEL_MPDDRC_TPR0_TRC_OFFSET) |
+		      (3 << ATMEL_MPDDRC_TPR0_TRP_OFFSET) |
+		      (4 << ATMEL_MPDDRC_TPR0_TRRD_OFFSET) |
+		      (4 << ATMEL_MPDDRC_TPR0_TWTR_OFFSET) |
+		      (2 << ATMEL_MPDDRC_TPR0_TMRD_OFFSET));
+
+	ddrc->tpr1 = ((22 << ATMEL_MPDDRC_TPR1_TRFC_OFFSET) |
+		      (23 << ATMEL_MPDDRC_TPR1_TXSNR_OFFSET) |
+		      (200 << ATMEL_MPDDRC_TPR1_TXSRD_OFFSET) |
+		      (3 << ATMEL_MPDDRC_TPR1_TXP_OFFSET));
+
+	ddrc->tpr2 = ((2 << ATMEL_MPDDRC_TPR2_TXARD_OFFSET) |
+		      (8 << ATMEL_MPDDRC_TPR2_TXARDS_OFFSET) |
+		      (4 << ATMEL_MPDDRC_TPR2_TRPA_OFFSET) |
+		      (4 << ATMEL_MPDDRC_TPR2_TRTP_OFFSET) |
+		      (8 << ATMEL_MPDDRC_TPR2_TFAW_OFFSET));
+}
+
+void mem_init(void)
+{
+	struct at91_pmc *pmc = (struct at91_pmc *)ATMEL_BASE_PMC;
+	struct atmel_mpddr *mpddrc = (struct atmel_mpddr *)ATMEL_BASE_MPDDRC;
+	struct atmel_mpddrc_config ddrc_config;
+	u32 reg;
+
+	ddrc_conf(&ddrc_config);
+
+	at91_periph_clk_enable(ATMEL_ID_MPDDRC);
+	writel(AT91_PMC_DDR, &pmc->scer);
+
+	reg = readl(&mpddrc->io_calibr);
+	reg &= ~ATMEL_MPDDRC_IO_CALIBR_RDIV;
+	reg |= ATMEL_MPDDRC_IO_CALIBR_DDR3_RZQ_55;
+	reg &= ~ATMEL_MPDDRC_IO_CALIBR_TZQIO;
+	reg |= ATMEL_MPDDRC_IO_CALIBR_TZQIO_(101);
+	writel(reg, &mpddrc->io_calibr);
+
+	writel(ATMEL_MPDDRC_RD_DATA_PATH_SHIFT_ONE_CYCLE,
+	       &mpddrc->rd_data_path);
+
+	ddr3_init(ATMEL_BASE_MPDDRC, ATMEL_BASE_DDRCS, &ddrc_config);
+
+	writel(0x3, &mpddrc->cal_mr4);
+	writel(64, &mpddrc->tim_cal);
+}
+
+void at91_pmc_init(void)
+{
+	u32 tmp;
+
+	/*
+	 * While coming from the ROM code, we run on PLLA @ 492 MHz / 164 MHz,
+	 * so we need to slow down and configure MCKR accordingly.
+	 * This is why we have a special flavor of the switching function.
+	 */
+	tmp = AT91_PMC_MCKR_PLLADIV_2 |
+	      AT91_PMC_MCKR_MDIV_3 |
+	      AT91_PMC_MCKR_CSS_MAIN;
+	at91_mck_init_down(tmp);
+
+	tmp = AT91_PMC_PLLAR_29 |
+	      AT91_PMC_PLLXR_PLLCOUNT(0x3f) |
+	      AT91_PMC_PLLXR_MUL(40) |
+	      AT91_PMC_PLLXR_DIV(1);
+	at91_plla_init(tmp);
+
+	tmp = AT91_PMC_MCKR_H32MXDIV |
+	      AT91_PMC_MCKR_PLLADIV_2 |
+	      AT91_PMC_MCKR_MDIV_3 |
+	      AT91_PMC_MCKR_CSS_PLLA;
+	at91_mck_init(tmp);
+}
+#endif
diff --git a/configs/kstr_sama5d27_defconfig b/configs/kstr_sama5d27_defconfig
new file mode 100644
index 000000000000..1c8aceb9e19c
--- /dev/null
+++ b/configs/kstr_sama5d27_defconfig
@@ -0,0 +1,80 @@
+CONFIG_ARM=y
+CONFIG_ARCH_AT91=y
+CONFIG_TEXT_BASE=0x26f00000
+CONFIG_SYS_LOAD_ADDR=0x24000000
+CONFIG_SYS_MONITOR_LEN=524288
+CONFIG_TARGET_KSTR_SAMA5D27=y
+CONFIG_SYS_MALLOC_F_LEN=0x2000
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20003ee0
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="at91-kstr-sama5d27"
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_FIT=y
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_SYS_EXTRA_OPTIONS="SAMA5D2"
+CONFIG_SD_BOOT=y
+CONFIG_BOOTDELAY=3
+CONFIG_USE_BOOTARGS=y
+CONFIG_BOOTARGS="console=ttyS0,115200 earlyprintk root=/dev/mmcblk0p2 rw rootwait"
+# CONFIG_USE_BOOTCOMMAND is not set
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_MISC_INIT_R=y
+CONFIG_CMD_TLV_EEPROM=y
+CONFIG_CMD_IMAGE=y
+CONFIG_CMD_DM=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+# CONFIG_CMD_LOADS is not set
+CONFIG_CMD_MMC=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+# CONFIG_ISO_PARTITION is not set
+CONFIG_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_FAT=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_DM=y
+CONFIG_CLK=y
+CONFIG_CLK_AT91=y
+CONFIG_AT91_UTMI=y
+CONFIG_AT91_H32MX=y
+CONFIG_AT91_GENERIC_CLK=y
+CONFIG_ATMEL_PIO4=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_AT91=y
+CONFIG_I2C_EEPROM=y
+CONFIG_MICROCHIP_FLEXCOM=y
+CONFIG_DM_MMC=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ATMEL=y
+CONFIG_PHY_MICREL=y
+CONFIG_DM_ETH=y
+CONFIG_MACB=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_AT91PIO4=y
+CONFIG_DM_SERIAL=y
+CONFIG_ATMEL_USART=y
+CONFIG_TEE=y
+CONFIG_OPTEE=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_AT91=y
+CONFIG_DM_RESET=y
+CONFIG_RESET_AT91=y
+CONFIG_TIMER=y
+CONFIG_ATMEL_PIT_TIMER=y
+CONFIG_USB=y
+CONFIG_DM_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_VENDOR_NUM=0x16c0
+CONFIG_USB_GADGET_PRODUCT_NUM=0x03e9
+CONFIG_USB_GADGET_ATMEL_USBA=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_SPL_OF_LIBFDT=y
+# CONFIG_EFI_LOADER is not set
diff --git a/include/configs/kstr-sama5d27.h b/include/configs/kstr-sama5d27.h
new file mode 100644
index 000000000000..772a073ba209
--- /dev/null
+++ b/include/configs/kstr-sama5d27.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2021-2023 Conclusive Engineering Sp. z o. o.
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#include "at91-sama5_common.h"
+
+/* SDRAM */
+#define CFG_SYS_SDRAM_BASE           0x20000000
+#define CFG_SYS_SDRAM_SIZE           0x10000000
+
+#endif
-- 
2.42.0

