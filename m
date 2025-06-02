Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7692AC5AD49
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 19:48:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1F2782B0E;
	Mon,  2 Jun 2025 21:47:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Hk9SqzHq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 075EF82998; Mon,  2 Jun 2025 21:47:15 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E05582AAF
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 21:47:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e7da099de49so4281979276.2
 for <u-boot@lists.denx.de>; Mon, 02 Jun 2025 12:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748893631; x=1749498431; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lmbXGAtnKLXQg1jpp0zKcS9LAWcI1vKOIAeS09vUrl4=;
 b=Hk9SqzHq9Utd9uF+IuQ/gW86N4JNzRz7DVrgpnhvpibVwoHCwXwaOcjUgYxD6fZyAo
 +SX6rPDPEYlKOtWRH1wtEVGputdRPp5LLCASLA3rFwOdaJPTlz2d8CA+6zVgaEwRerzl
 FYJH1WJgGjGHlOJO+9XoJh6gvhfjXewTtyZtYtNYxJ8qzQFf1AGbTtK6gu1Mt3ne3KR/
 PSqpn1iUj5sNnOClnqLn5JBEpba3Q12PPJG6rLWnOYFsSh2/ZnIPknYFgG/ZlXYJIiQA
 k1l/F8Jvrl5Oj8a+yosL4FbZVlA5K3LQ3S4wb1U6zqiOjC6w8ITVazcayOBinVzgQOMT
 aP/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748893631; x=1749498431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lmbXGAtnKLXQg1jpp0zKcS9LAWcI1vKOIAeS09vUrl4=;
 b=w2GfLKd8tV5CNurXie7wb5V10P9W7ctG7REmWrh8dPwnCDs4jnIu10GubGmY1Oqwqk
 2bVY1NSq7Od8CbUzCqFdICUXzbYBqa8NAHJ8apBUGC3rqtdwqJ2hkpt3lxzwELzVy9Fw
 sQ4XPvw2rQFANQOOj/H8MuzBr0YXqxIyPJ+u4JoVnliGZvyYx0o0IKp3f2Zsti/rhye7
 etdQ8NiI9Pnj2U+VD6apnh7vm1rf8FNKIjjjJAo6YDcNgU7U8iBoy7xiM4Z9NGxnXYUl
 klCAWmKNSx4TGt2wYsu0VtA6UBdHZwxOkC2r9ZIfh7XkYD4vlLcflixexR0iFHUgFfd4
 lnYQ==
X-Gm-Message-State: AOJu0YyuCVEHps8kbvXAQpSTZK4OJyJR9Td6DH27jwa4HbW8AqrGTQvF
 eJPJRAuvPZRk2r0lQT/Ze+r/3SMmsOq7T+kusk+xRc5vzigXl7RZXo4TidgO
X-Gm-Gg: ASbGncvZoSBj7aZpIGQ8/ZGeu+lpG9XqNCHvLav4yNOgdvKiNCAQCveYJgZIKnLozTO
 ifTW0Wk8+soF/6+uuQS0p9OQr4ffOcbX27yFb+a0EOL6rxko47yvjR/p8C8DjGwtWXH91Lo6pV4
 K84GC49Z7o2dcGusnvonxtobuaTuXHrmKfv3kVnGfxtaeuPLAfQgah289Gfikr8pphq6/JSExv5
 5HXmiJIMW77SUnzi2UotGOx1HGSYec4Qb2Gz8fDlOU2i8l11eO1alr1S8FMLQ1HKgG2k4EyXqU+
 6CS7BmVrWfIk4Ztct0fvR3w936SXiSPEFKfSyX3pUZZrjjJpIYYYiB/xbI2SvcA1YGq3hxEtyHm
 OdQ==
X-Google-Smtp-Source: AGHT+IGNvQMdtd7daDtR7y78OFngUNaZLD2xyZ8xIOycdTJkNc2lmwKuTnrE4vfH6x/6PSXeXQnuag==
X-Received: by 2002:a05:690c:3383:b0:70e:7ae4:5a3e with SMTP id
 00721157ae682-71097c4ccddmr153660997b3.11.1748893630800; 
 Mon, 02 Jun 2025 12:47:10 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-70f8ac0f452sm21902867b3.51.2025.06.02.12.47.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 12:47:10 -0700 (PDT)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: adsp-linux@analog.com, Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, Tom Rini <trini@konsulko.com>,
 Trevor Woerner <twoerner@gmail.com>
Subject: [PATCH 07/10] board: adi: Add support for SC584
Date: Mon,  2 Jun 2025 15:44:45 -0400
Message-ID: <20250602194507.15159-8-malysagreg@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250602194507.15159-1-malysagreg@gmail.com>
References: <20250602194507.15159-1-malysagreg@gmail.com>
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
Signed-off-by: Greg Malysa <malysagreg@gmail.com>
---

 arch/arm/dts/sc584-ezkit.dts          | 230 ++++++++++++++++++++++++++
 board/adi/sc584-ezkit/Makefile        |   6 +
 board/adi/sc584-ezkit/sc584-ezkit.c   |  21 +++
 board/adi/sc584-ezkit/sc584-ezkit.env |  16 +-
 configs/sc584-ezkit_defconfig         | 108 ++++++++++++
 5 files changed, 375 insertions(+), 6 deletions(-)
 create mode 100644 board/adi/sc584-ezkit/Makefile
 create mode 100644 board/adi/sc584-ezkit/sc584-ezkit.c
 create mode 100644 configs/sc584-ezkit_defconfig

diff --git a/arch/arm/dts/sc584-ezkit.dts b/arch/arm/dts/sc584-ezkit.dts
index 4ec6bcfb658..f110418409c 100644
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
+			gpios = <0 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "~eeprom-en";
+			bootph-pre-ram;
+		};
+
+		uart0-flow-en {
+			gpio-hog;
+			gpios = <1 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "~uart0-flow-en";
+			bootph-pre-ram;
+		};
+
+		uart0-en {
+			gpio-hog;
+			gpios = <2 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "~uart0-en";
+			bootph-pre-ram;
+		};
+
+		mlb {
+			gpio-hog;
+			gpios = <5 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "~mlb-en";
+			bootph-pre-ram;
+		};
+
+		can0 {
+			gpio-hog;
+			gpios = <6 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "~can0-en";
+			bootph-pre-ram;
+		};
+
+		can1 {
+			gpio-hog;
+			gpios = <7 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "~can1-en";
+			bootph-pre-ram;
+		};
+
+		adau1962 {
+			gpio-hog;
+			gpios = <8 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "~adau1962-en";
+			bootph-pre-ram;
+		};
+
+		adau1979 {
+			gpio-hog;
+			gpios = <9 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "~adau1979-en";
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
+			gpios = <12 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "~spi2d2-d3-en";
+			bootph-pre-ram;
+		};
+
+		spi2flash-cs {
+			gpio-hog;
+			gpios = <13 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "~spi2flash-cs";
+			bootph-pre-ram;
+		};
+
+		spdif-opt {
+			gpio-hog;
+			gpios = <14 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "~spdif-optical-en";
+			bootph-pre-ram;
+		};
+
+		spdif-dig {
+			gpio-hog;
+			gpios = <15 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "~spdif-digital-en";
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
+			gpios = <0 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "~pushbutton3-en";
+			bootph-pre-ram;
+		};
+
+		pushbutton2 {
+			gpio-hog;
+			gpios = <1 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "~pushbutton2-en";
+			bootph-pre-ram;
+		};
+
+		pushbutton1 {
+			gpio-hog;
+			gpios = <2 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "~pushbutton1-en";
+			bootph-pre-ram;
+		};
+
+		leds {
+			gpio-hog;
+			gpios = <3 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "~leds-en";
+			bootph-pre-ram;
+		};
+
+		flg0 {
+			gpio-hog;
+			gpios = <4 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "~flg0_loop";
+			bootph-pre-ram;
+		};
+
+		flg1 {
+			gpio-hog;
+			gpios = <5 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "~flg1_loop";
+			bootph-pre-ram;
+		};
+
+		flg2 {
+			gpio-hog;
+			gpios = <6 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "~flg2_loop";
+			bootph-pre-ram;
+		};
+
+		flg3 {
+			gpio-hog;
+			gpios = <7 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "~flg3_loop";
+			bootph-pre-ram;
+		};
+
+		adau1977 {
+			gpio-hog;
+			gpios = <8 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "~adau1977_en";
+			bootph-pre-ram;
+		};
+
+		adau1977_fault_rst {
+			gpio-hog;
+			gpios = <9 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "~adau1977_fault_rst_en";
+			bootph-pre-ram;
+		};
+
+		thumbwheel {
+			gpio-hog;
+			gpios = <10 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "~thumbwheel_oe";
+			bootph-pre-ram;
+		};
+
+		engine_rpm {
+			gpio-hog;
+			gpios = <11 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "~engine_rpm_oe";
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
index af9a9e01bcf..59b776cea6f 100644
--- a/board/adi/sc584-ezkit/sc584-ezkit.env
+++ b/board/adi/sc584-ezkit/sc584-ezkit.env
@@ -4,10 +4,14 @@
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
index 00000000000..501fe86ec25
--- /dev/null
+++ b/configs/sc584-ezkit_defconfig
@@ -0,0 +1,108 @@
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
+# CONFIG_PACK_FITIMAGE is not set
+# CONFIG_PACK_ROOTFS is not set
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
+CONFIG_HOSTNAME="sc58x"
+CONFIG_NET_RETRY_COUNT=20
+CONFIG_IP_DEFRAG=y
+CONFIG_USE_GATEWAYIP=y
+CONFIG_GATEWAYIP="192.168.0.1"
+CONFIG_USE_IPADDR=y
+CONFIG_IPADDR="192.168.0.15"
+CONFIG_USE_NETMASK=y
+CONFIG_NETMASK="255.255.255.0"
+CONFIG_USE_ROOTPATH=y
+CONFIG_ROOTPATH="/romfs"
+CONFIG_USE_SERVERIP=y
+CONFIG_SERVERIP="192.168.0.2"
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
2.45.2

