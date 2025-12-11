Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F3F5D41C01
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 08:07:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58BEB83D3C;
	Thu, 11 Dec 2025 09:06:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fqeoa/7o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7671183D07; Thu, 11 Dec 2025 09:06:02 +0100 (CET)
Received: from mail-yx1-xb12e.google.com (mail-yx1-xb12e.google.com
 [IPv6:2607:f8b0:4864:20::b12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08EF783D0D
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 09:06:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-6446bae1e17so639898d50.0
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 00:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765440358; x=1766045158; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G1h4L1SSSXR/YPtIFjikeUkZTbaDCPMilV9YBo5Rt4c=;
 b=Fqeoa/7oBklZE9e7OK/VbzLtn+HhpIgPBxp5YYbxgaL3q1R19X41VI2JnsbIBgAiK2
 NRE/wm2HAX3JfEM1xW0d7QIp8hqgsa2tgjXwh1iIvj27kKF92yVf/kvybzHw7o5pgdsp
 8fIHNEFq0eo3PmRCyARgtroRoaYeHCF2kDVr/FVCjQsieLBy/4qppYELxnXcZC6Jpk7x
 0xqUL9GaeBBk8j3YnkraccQXRDd6Tb1Ucgeq7NeI8DQ4V32nC/H00LouJt8AS7doUO1L
 DBtq56wVhSBKvjWgI+6VqeEQm231cisgvI6u0R8BNjeD7ljKVtdkpveyySzWGLnjYL/B
 tETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765440358; x=1766045158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G1h4L1SSSXR/YPtIFjikeUkZTbaDCPMilV9YBo5Rt4c=;
 b=jtSyjNL6v73Bck5XTbu+3mV96R5h8Ytjr5v/ryrS8n+Mwzs3kPORbKZsCyOYuoN1kX
 pqoulh1qCiJOTvpvgr8cRLhfWp3jD+BgNL5uUMelPndBg8Ge1yeVrmf8u90q6uel29QE
 zHaOkED5WJs6zbGgv9z0aV7/JdqI3ahd6KZWc2Txair8HINzpqPfjNcCgmGdg4PnT/vo
 9AtdIrBpFFgODUHoG+K+ibjMa7p6Mw3CSQltDOOLWMDYBtHIXAiv9xkUdYTs9j3+OoBY
 wrDDO2yJS70CaviALqXqGRSwGB5qbKyLRwS1P3zRc3D5T/vnbw7LzwBDm4fo8Ts37TOA
 qpUA==
X-Gm-Message-State: AOJu0YxPiov8cAsjUZVyWgeoRmZqTO+ADf/j0ppF/KRJSrCAlBbowo5D
 JoQNLs+ZaarjIsdt0FomUeFc2EIJYHgLQioV8irmd1WLM1Tley6DddCezfmO
X-Gm-Gg: AY/fxX7YK5eHd5WlhaTOLA/2211fUVhr4TwKee+emRxZugYD9OKfnV4eVRAAXstDixv
 7hKjSPCS4vAeVOZFaVheS8laCI5pfjBc9HGGr5l5tOQKQ6Jzm+F7qH1eIPhlO/Ln7ARea1fD5tl
 jRrhQgmutbrbQ/f4cq3EGRXhUpSJlMR3iQASZ6LJjCwdWDefEpT11I10VuwNdMIB9qH2KEo0POh
 n7e89gnGWYV1P6XY2EP03Vob4PNujLVGrgMXAi85e0gsP+9DEuhqev/9yNjqqz/v2Y6VqvxfQK/
 Il7LtAf8uh/ug/9Nie3T/DsJPE49hQd7CUuOqSoNA0NlmhHuZiiqUpkMnKOWdxD03ABVjQJiXe3
 pnmrGuJv0pn3U5hX4BH8AscP8aCn9kGmAb7OIMqKGWHOKZIpTdPM9QCW3XeCzbyggwpxDXFiiBU
 7y/KEfR2JtPZnLWfv5Dq1becpf0C3a+Q3BRZL4
X-Google-Smtp-Source: AGHT+IG3Tk6vkEeUeAOjpgI5rz/qktBwg6QAT/A1m3SW5pj/iY09/DlEKxayig0n2rXhVJFQGpLYCA==
X-Received: by 2002:a05:690e:c41:b0:63f:ae41:fbbc with SMTP id
 956f58d0204a3-6446e8ff1b7mr3861601d50.10.1765440358290; 
 Thu, 11 Dec 2025 00:05:58 -0800 (PST)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-78d69d83a85sm7256657b3.28.2025.12.11.00.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 00:05:57 -0800 (PST)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: adsp-linux@analog.com, Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Caleb Ethridge <caleb.ethridge@analog.com>,
 Ian Roberts <ian.roberts@timesys.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 09/12] board: adi: Add support for SC584-ezkit
Date: Thu, 11 Dec 2025 03:04:00 -0500
Message-ID: <20251211080414.5363-10-malysagreg@gmail.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251211080414.5363-1-malysagreg@gmail.com>
References: <20251211080414.5363-1-malysagreg@gmail.com>
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

This adds support for the Analog Devices SC584-EZKIT.

Signed-off-by: Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Signed-off-by: Utsav Agarwal <utsav.agarwal@analog.com>
Signed-off-by: Arturs Artamonovs <arturs.artamonovs@analog.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
Signed-off-by: Greg Malysa <malysagreg@gmail.com>

---

Changes in v3:
- Add one more GPIO that was named incorrectly
- Removed whitespace in .env

Changes in v2:
- GPIO names and polarities adjusted to match logical usage

 arch/arm/dts/sc584-ezkit.dts          | 230 ++++++++++++++++++++++++++
 board/adi/sc584-ezkit/Makefile        |   6 +
 board/adi/sc584-ezkit/sc584-ezkit.c   |  21 +++
 board/adi/sc584-ezkit/sc584-ezkit.env |  17 +-
 configs/sc584-ezkit_defconfig         |  96 +++++++++++
 5 files changed, 363 insertions(+), 7 deletions(-)
 create mode 100644 board/adi/sc584-ezkit/Makefile
 create mode 100644 board/adi/sc584-ezkit/sc584-ezkit.c
 create mode 100644 configs/sc584-ezkit_defconfig

diff --git a/arch/arm/dts/sc584-ezkit.dts b/arch/arm/dts/sc584-ezkit.dts
index 4ec6bcfb658..e9f4e1da383 100644
--- a/arch/arm/dts/sc584-ezkit.dts
+++ b/arch/arm/dts/sc584-ezkit.dts
@@ -11,3 +11,233 @@
 	model = "ADI SC584-EZKIT";
 	compatible = "adi,sc584-ezkit", "adi,sc58x";
 };
+
+&i2c2 {
+	gpio_expander1: mcp23017@21 {
+		compatible = "microchip,mcp23017";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		bootph-pre-ram;
+
+		eeprom {
+			gpio-hog;
+			gpios = <0 GPIO_ACTIVE_LOW>;
+			output-low;
+			line-name = "eeprom-en";
+			bootph-pre-ram;
+		};
+
+		uart0-flow-en {
+			gpio-hog;
+			gpios = <1 GPIO_ACTIVE_LOW>;
+			output-low;
+			line-name = "uart0-flow-en";
+			bootph-pre-ram;
+		};
+
+		uart0-en {
+			gpio-hog;
+			gpios = <2 GPIO_ACTIVE_LOW>;
+			output-high;
+			line-name = "uart0-en";
+			bootph-pre-ram;
+		};
+
+		mlb {
+			gpio-hog;
+			gpios = <5 GPIO_ACTIVE_LOW>;
+			output-low;
+			line-name = "mlb-en";
+			bootph-pre-ram;
+		};
+
+		can0 {
+			gpio-hog;
+			gpios = <6 GPIO_ACTIVE_LOW>;
+			output-low;
+			line-name = "can0-en";
+			bootph-pre-ram;
+		};
+
+		can1 {
+			gpio-hog;
+			gpios = <7 GPIO_ACTIVE_LOW>;
+			output-low;
+			line-name = "can1-en";
+			bootph-pre-ram;
+		};
+
+		adau1962 {
+			gpio-hog;
+			gpios = <8 GPIO_ACTIVE_LOW>;
+			output-high;
+			line-name = "adau1962-en";
+			bootph-pre-ram;
+		};
+
+		adau1979 {
+			gpio-hog;
+			gpios = <9 GPIO_ACTIVE_LOW>;
+			output-high;
+			line-name = "adau1979-en";
+			bootph-pre-ram;
+		};
+
+		audio_jack_sel {
+			gpio-hog;
+			gpios = <10 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "audio_jack_sel";
+			bootph-pre-ram;
+		};
+
+		spi2d2-d3 {
+			gpio-hog;
+			gpios = <12 GPIO_ACTIVE_LOW>;
+			output-high;
+			line-name = "spi2d2-d3-en";
+			bootph-pre-ram;
+		};
+
+		spi2flash-cs {
+			gpio-hog;
+			gpios = <13 GPIO_ACTIVE_LOW>;
+			output-high;
+			line-name = "spi2flash-cs";
+			bootph-pre-ram;
+		};
+
+		spdif-opt {
+			gpio-hog;
+			gpios = <14 GPIO_ACTIVE_LOW>;
+			output-low;
+			line-name = "spdif-optical-en";
+			bootph-pre-ram;
+		};
+
+		spdif-dig {
+			gpio-hog;
+			gpios = <15 GPIO_ACTIVE_LOW>;
+			output-low;
+			line-name = "spdif-digital-en";
+			bootph-pre-ram;
+		};
+	};
+
+	gpio_expander2: mcp23017@22 {
+		compatible = "microchip,mcp23017";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		bootph-pre-ram;
+
+		pushbutton3 {
+			gpio-hog;
+			gpios = <0 GPIO_ACTIVE_LOW>;
+			output-high;
+			line-name = "pushbutton3-en";
+			bootph-pre-ram;
+		};
+
+		pushbutton2 {
+			gpio-hog;
+			gpios = <1 GPIO_ACTIVE_LOW>;
+			output-high;
+			line-name = "pushbutton2-en";
+			bootph-pre-ram;
+		};
+
+		pushbutton1 {
+			gpio-hog;
+			gpios = <2 GPIO_ACTIVE_LOW>;
+			output-high;
+			line-name = "pushbutton1-en";
+			bootph-pre-ram;
+		};
+
+		leds {
+			gpio-hog;
+			gpios = <3 GPIO_ACTIVE_LOW>;
+			output-high;
+			line-name = "leds-en";
+			bootph-pre-ram;
+		};
+
+		flg0 {
+			gpio-hog;
+			gpios = <4 GPIO_ACTIVE_LOW>;
+			output-high;
+			line-name = "flg0_loop";
+			bootph-pre-ram;
+		};
+
+		flg1 {
+			gpio-hog;
+			gpios = <5 GPIO_ACTIVE_LOW>;
+			output-high;
+			line-name = "flg1_loop";
+			bootph-pre-ram;
+		};
+
+		flg2 {
+			gpio-hog;
+			gpios = <6 GPIO_ACTIVE_LOW>;
+			output-high;
+			line-name = "flg2_loop";
+			bootph-pre-ram;
+		};
+
+		flg3 {
+			gpio-hog;
+			gpios = <7 GPIO_ACTIVE_LOW>;
+			output-high;
+			line-name = "flg3_loop";
+			bootph-pre-ram;
+		};
+
+		adau1977 {
+			gpio-hog;
+			gpios = <8 GPIO_ACTIVE_LOW>;
+			output-high;
+			line-name = "adau1977_en";
+			bootph-pre-ram;
+		};
+
+		adau1977_fault_rst {
+			gpio-hog;
+			gpios = <9 GPIO_ACTIVE_LOW>;
+			output-low;
+			line-name = "adau1977_fault_rst_en";
+			bootph-pre-ram;
+		};
+
+		thumbwheel {
+			gpio-hog;
+			gpios = <10 GPIO_ACTIVE_LOW>;
+			output-high;
+			line-name = "thumbwheel_oe";
+			bootph-pre-ram;
+		};
+
+		engine_rpm {
+			gpio-hog;
+			gpios = <11 GPIO_ACTIVE_LOW>;
+			output-high;
+			line-name = "engine_rpm_oe";
+			bootph-pre-ram;
+		};
+	};
+};
+
+&eth0 {
+	snps,reset-gpio = <&gpio0 ADI_ADSP_PIN('B', 14) GPIO_ACTIVE_LOW>;
+};
+
+&gpio0 {
+	emac0_phy_pwdn {
+		gpio-hog;
+		output-high;
+		gpios = <ADI_ADSP_PIN('C', 15) GPIO_ACTIVE_HIGH>;
+	};
+};
diff --git a/board/adi/sc584-ezkit/Makefile b/board/adi/sc584-ezkit/Makefile
new file mode 100644
index 00000000000..86f94976cf3
--- /dev/null
+++ b/board/adi/sc584-ezkit/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# (C) Copyright 2025 - Analog Devices, Inc.
+#
+
+obj-y	:= sc584-ezkit.o
diff --git a/board/adi/sc584-ezkit/sc584-ezkit.c b/board/adi/sc584-ezkit/sc584-ezkit.c
new file mode 100644
index 00000000000..288c2670761
--- /dev/null
+++ b/board/adi/sc584-ezkit/sc584-ezkit.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2025 - Analog Devices, Inc.
+ */
+
+#include <phy.h>
+#include <asm/u-boot.h>
+#include <asm/arch-adi/sc5xx/sc5xx.h>
+#include <asm/arch-adi/sc5xx/soc.h>
+
+int board_phy_config(struct phy_device *phydev)
+{
+	fixup_dp83867_phy(phydev);
+	return 0;
+}
+
+int board_init(void)
+{
+	sc5xx_enable_rgmii();
+	return 0;
+}
diff --git a/board/adi/sc584-ezkit/sc584-ezkit.env b/board/adi/sc584-ezkit/sc584-ezkit.env
index af9a9e01bcf..8a6f7edd5e8 100644
--- a/board/adi/sc584-ezkit/sc584-ezkit.env
+++ b/board/adi/sc584-ezkit/sc584-ezkit.env
@@ -1,13 +1,16 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later+ */
-
 /*
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-#include <env/adi/adi_boot.env>
-
-adi_stage2_offset=0x20000
-adi_image_offset=0xE0000
-adi_rfs_offset=0x6E0000
-loadaddr=0x89300000
+adi_stage2_offset=CONFIG_SC5XX_UBOOT_OFFSET
+adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
+adi_rfs_offset=CONFIG_SC5XX_ROOTFS_OFFSET
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc584-ezkit.jffs2
+loadaddr=CONFIG_SC5XX_LOADADDR
+
+#define USE_NFS
+#define USE_SPI
+#define USE_RAM
+
+#include <env/adi/adi_boot.env>
diff --git a/configs/sc584-ezkit_defconfig b/configs/sc584-ezkit_defconfig
new file mode 100644
index 00000000000..25ac59e4733
--- /dev/null
+++ b/configs/sc584-ezkit_defconfig
@@ -0,0 +1,96 @@
+CONFIG_ARM=y
+CONFIG_SYS_ARM_CACHE_WRITETHROUGH=y
+CONFIG_ARCH_SC5XX=y
+CONFIG_SYS_MALLOC_LEN=0x100000
+CONFIG_SPL_GPIO=y
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0xD0000
+CONFIG_ENV_SECT_SIZE=0x4000
+CONFIG_DM_GPIO=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_STACK=0x200C0000
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x8000
+CONFIG_SPL_BSS_START_ADDR=0x200A0000
+CONFIG_SPL_BSS_MAX_SIZE=0x8000
+CONFIG_SC58X=y
+CONFIG_SC5XX_UBOOT_OFFSET=0x20000
+CONFIG_SC5XX_FITIMAGE_OFFSET=0xE0000
+CONFIG_SC5XX_ROOTFS_OFFSET=0x6E0000
+CONFIG_SC5XX_LOADADDR=0x89300000
+CONFIG_WATCHDOG_TIMEOUT_MSECS=60000
+CONFIG_ADI_BUG_EZKHW21=y
+CONFIG_CGU0_CLKOUTSEL=7
+# CONFIG_EFI_LOADER is not set
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="run ramboot"
+CONFIG_SYS_CBSIZE=512
+CONFIG_CYCLIC_MAX_CPU_TIME_US=1000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_I2C=y
+CONFIG_CMD_BOOTZ=y
+# CONFIG_BOOTM_NETBSD is not set
+# CONFIG_BOOTM_PLAN9 is not set
+# CONFIG_BOOTM_RTEMS is not set
+# CONFIG_BOOTM_VXWORKS is not set
+# CONFIG_CMD_ELF is not set
+CONFIG_CMD_DM=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+# CONFIG_CMD_PINMUX is not set
+CONFIG_CMD_SPI=y
+CONFIG_CMD_USB=y
+CONFIG_SYS_DISABLE_AUTOLOAD=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_DNS=y
+CONFIG_CMD_MII=y
+# CONFIG_CMD_MDIO is not set
+CONFIG_CMD_PING=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_EMBED=y
+# CONFIG_OF_TAG_MIGRATE is not set
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_ENV_SPI_MAX_HZ=10000000
+CONFIG_USE_HOSTNAME=y
+CONFIG_HOSTNAME="sc584-ezkit"
+CONFIG_NET_RETRY_COUNT=20
+CONFIG_IP_DEFRAG=y
+CONFIG_SPL_CLK=y
+CONFIG_SPL_CLK_CCF=y
+CONFIG_GPIO_HOG=y
+CONFIG_SPL_GPIO_HOG=y
+CONFIG_DM_GPIO_LOOKUP_LABEL=y
+CONFIG_SPL_DM_GPIO_LOOKUP_LABEL=y
+CONFIG_MCP230XX_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_DM_I2C_GPIO=y
+CONFIG_SYS_I2C_ADI=y
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_ETH_DESIGNWARE=y
+CONFIG_DW_ALTDESCRIPTOR=y
+CONFIG_PINCTRL=y
+# CONFIG_PINCTRL_GENERIC is not set
+CONFIG_SPL_PINCTRL=y
+# CONFIG_SPL_PINCTRL_GENERIC is not set
+CONFIG_SPECIFY_CONSOLE_INDEX=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_ADI_SPI3=y
+CONFIG_SPL_TIMER=y
+CONFIG_USB=y
+CONFIG_USB_MUSB_HOST=y
+CONFIG_USB_MUSB_SC5XX=y
+CONFIG_USB_MUSB_PIO_ONLY=y
+CONFIG_USB_STORAGE=y
+CONFIG_FAT_WRITE=y
+# CONFIG_REGEX is not set
+# CONFIG_SPL_CRC8 is not set
-- 
2.49.1

