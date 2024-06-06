Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E4D3C27C55
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 16:34:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DBCE88470;
	Thu,  6 Jun 2024 18:33:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nic.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=nic.cz header.i=@nic.cz header.b="TfhryP7D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3034881A1; Thu,  6 Jun 2024 18:33:41 +0200 (CEST)
Received: from mail.nic.cz (mail.nic.cz [217.31.204.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D554088444
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 18:33:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nic.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.mojik@nic.cz
Received: from marcharch.labs.office.nic.cz (unknown
 [IPv6:2001:1488:fffe:6:592e:6672:3345:e2e0])
 by mail.nic.cz (Postfix) with ESMTPSA id 874731C2BB0;
 Thu,  6 Jun 2024 18:33:33 +0200 (CEST)
Authentication-Results: mail.nic.cz;
 auth=pass smtp.auth=marek.mojik@nic.cz smtp.mailfrom=marek.mojik@nic.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
 t=1717691613; bh=jaTMyR6aGOinFSumBvYDKoNQ68Sgzbyc51SoWxd8hzM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
 Subject:To:Cc;
 b=TfhryP7DGoXfPpSIjEpMjLTAy5o9Lib5E9HrjlyE4hhaOKZF/0Nk/ij06krAy0h7G
 4p8HHb1ELlBl4QYU/nFbkSQ+9sJ4YOAj5QAbOcqVgQjqz6RggyBWRs/SAyw154w+2H
 OKWqK/a54L5Sb2j5ILvfVb6BIlos2aYG3zCqCNJc=
From: =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>
To: u-boot@lists.denx.de
Cc: kabel@kernel.org,
	marek.mojik@nic.cz
Subject: [PATCH 6/6] powerpc: Add support for CZ.NIC Turris 1.x routers
Date: Thu,  6 Jun 2024 18:33:26 +0200
Message-ID: <20240606163326.386950-7-marek.mojik@nic.cz>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240606163326.386950-1-marek.mojik@nic.cz>
References: <20240606163326.386950-1-marek.mojik@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.10 / 20.00]; REPLY(-4.00)[];
 MIME_GOOD(-0.10)[text/plain];
 WHITELISTED_IP(0.00)[2001:1488:fffe:6:592e:6672:3345:e2e0];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 ASN(0.00)[asn:25192, ipnet:2001:1488::/32, country:CZ];
 FROM_EQ_ENVFROM(0.00)[]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]
X-Rspamd-Action: no action
X-Rspamd-Server: mail
X-Rspamd-Queue-Id: 874731C2BB0
X-Spamd-Bar: ----
X-Rspamd-Pre-Result: action=no action; module=multimap;
 Matched map: WHITELISTED_IP
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

From: Pali Rohár <pali@kernel.org>

Add support for CZ.NIC Turris 1.x routers.

CZ.NIC Turris 1.0 (RTRS01) and 1.1 (RTRS02) are open source routers, they
have dual-core PowerPC Freescale P2020 CPU and are based on reference
Freescale P2020RDB-PC-A board design.

Hardware design is fully open source, all firmware and hardware design
files are available at Turris project website:

https://docs.turris.cz/hw/turris-1x/turris-1x/
https://project.turris.cz/en/hardware.html

The P2020 BootROM can load U-Boot either from NOR flash or from SD card.
We add the new defconfigs, turris_1x_nor_defconfig, which configures
U-Boot for building the NOR image, and turris_1x_sdcard_defconfig, which
configures U-Boot for building an image suitable for SD card.

The defconfig for NOR image is stripped-down a - many config options
enabled in SD defconfig are disabled for NOR defconfig. This is because
U-Boot grew non-trivially in the last two years and it would not fit
into the space allocated for U-Boot in the NOR memory. In the future we
may try to use LTO to reduce the size of the code and enable more
options.

The design of CZ.NIC Turris 1.x routers is based on Freescale P2020RDB-PC-A
board, so some code from boards/freescale/p1_p2_rdb_pc is used and linked
into Turris 1.x board code.

Turris 1.x code in this patch uses modern distroboot and can boot Linux
kernel from various locations, including NAND, SD card, USB flash disks,
NVMe disks or SATA disks (connected to extra SATA/SCSI PCIe controllers).
Via distroboot is implemented also rescue NOR boot for factory recovery,
triggered by reset button, like on other existing Turris routers.

SD boot with RAM larger than 2GB will only allocate 2GB of RAM (We were
not able to fix this yet)

Signed-off-by: Pali Rohár <pali@kernel.org>
[ Because various CONFIG_ macros were migrated to Kconfig since the last
  time this worked on upstream U-Boot (in 2022), a non-trivial rebasing
  was needed and some issues were solved. ]
Signed-off-by: Marek Mojík <marek.mojik@nic.cz>
---
 arch/powerpc/cpu/mpc85xx/Kconfig            |   7 +
 arch/powerpc/dts/Makefile                   |   1 +
 arch/powerpc/dts/turris1x-u-boot.dtsi       |  17 +
 arch/powerpc/dts/turris1x.dts               | 511 ++++++++++++++++++
 board/CZ.NIC/turris_1x/Kconfig              | 155 ++++++
 board/CZ.NIC/turris_1x/MAINTAINERS          |  13 +
 board/CZ.NIC/turris_1x/Makefile             |  15 +
 board/CZ.NIC/turris_1x/ddr.c                |  28 +
 board/CZ.NIC/turris_1x/law.c                |  13 +
 board/CZ.NIC/turris_1x/tlb.c                | 143 +++++
 board/CZ.NIC/turris_1x/turris_1x.c          | 571 ++++++++++++++++++++
 board/freescale/p1_p2_rdb_pc/p1_p2_rdb_pc.c |   9 +-
 boot/Kconfig                                |   2 +-
 configs/turris_1x_nor_defconfig             |  87 +++
 configs/turris_1x_sdcard_defconfig          | 106 ++++
 include/configs/turris_1x.h                 | 335 ++++++++++++
 16 files changed, 2011 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/dts/turris1x-u-boot.dtsi
 create mode 100644 arch/powerpc/dts/turris1x.dts
 create mode 100644 board/CZ.NIC/turris_1x/Kconfig
 create mode 100644 board/CZ.NIC/turris_1x/MAINTAINERS
 create mode 100644 board/CZ.NIC/turris_1x/Makefile
 create mode 100644 board/CZ.NIC/turris_1x/ddr.c
 create mode 100644 board/CZ.NIC/turris_1x/law.c
 create mode 100644 board/CZ.NIC/turris_1x/tlb.c
 create mode 100644 board/CZ.NIC/turris_1x/turris_1x.c
 create mode 100644 configs/turris_1x_nor_defconfig
 create mode 100644 configs/turris_1x_sdcard_defconfig
 create mode 100644 include/configs/turris_1x.h

diff --git a/arch/powerpc/cpu/mpc85xx/Kconfig b/arch/powerpc/cpu/mpc85xx/Kconfig
index e813bf094d..b441ba9840 100644
--- a/arch/powerpc/cpu/mpc85xx/Kconfig
+++ b/arch/powerpc/cpu/mpc85xx/Kconfig
@@ -173,6 +173,12 @@ config TARGET_P2020RDB
 	imply CMD_SATA
 	imply SATA_SIL
 
+config TARGET_TURRIS_1X
+	bool "Support Turris 1.x"
+	select SUPPORT_SPL
+	select ARCH_P2020
+	select SYS_L2_SIZE_512KB
+
 config TARGET_P2041RDB
 	bool "Support P2041RDB"
 	select ARCH_P2041
@@ -1530,6 +1536,7 @@ config TPL_SYS_MPC85XX_NO_RESETVEC
 config FSL_VIA
 	bool
 
+source "board/CZ.NIC/turris_1x/Kconfig"
 source "board/emulation/qemu-ppce500/Kconfig"
 source "board/freescale/mpc8548cds/Kconfig"
 source "board/freescale/p1010rdb/Kconfig"
diff --git a/arch/powerpc/dts/Makefile b/arch/powerpc/dts/Makefile
index bb436f02bc..321c644804 100644
--- a/arch/powerpc/dts/Makefile
+++ b/arch/powerpc/dts/Makefile
@@ -26,6 +26,7 @@ dtb-$(CONFIG_TARGET_T2080QDS) += t2080qds.dtb
 dtb-$(CONFIG_TARGET_T2080RDB) += t2080rdb.dtb
 dtb-$(CONFIG_TARGET_T4240RDB) += t4240rdb.dtb
 dtb-$(CONFIG_TARGET_TUGE1) += kmtuge1.dtb
+dtb-$(CONFIG_TARGET_TURRIS_1X) += turris1x.dtb
 dtb-$(CONFIG_TARGET_TUXX1) += kmtuxa1.dtb
 dtb-$(CONFIG_TARGET_MCR3000) += mcr3000.dtb
 dtb-$(CONFIG_TARGET_GAZERBEAM) += gazerbeam.dtb
diff --git a/arch/powerpc/dts/turris1x-u-boot.dtsi b/arch/powerpc/dts/turris1x-u-boot.dtsi
new file mode 100644
index 0000000000..355d14c954
--- /dev/null
+++ b/arch/powerpc/dts/turris1x-u-boot.dtsi
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+&soc {
+	i2c@3000 {
+		bootph-all;
+
+		crypto@64 {
+			bootph-all;
+		};
+	};
+};
+
+&serial0 {
+	bootph-all;
+};
+
+#include "u-boot.dtsi"
diff --git a/arch/powerpc/dts/turris1x.dts b/arch/powerpc/dts/turris1x.dts
new file mode 100644
index 0000000000..fade02c3c8
--- /dev/null
+++ b/arch/powerpc/dts/turris1x.dts
@@ -0,0 +1,511 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Turris 1.x Device Tree Source
+ *
+ * Copyright 2013 - 2022 CZ.NIC z.s.p.o. (http://www.nic.cz/)
+ *
+ * Pinout, Schematics and Altium hardware design files are open source
+ * and available at: https://docs.turris.cz/hw/turris-1x/turris-1x/
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/leds/common.h>
+/include/ "fsl/p2020si-pre.dtsi"
+
+/ {
+	model = "Turris 1.x";
+
+	/* fsl,P2020RDB-PC is required for booting Linux */
+	compatible = "cznic,turris1x", "fsl,P2020RDB-PC";
+
+	aliases {
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		ethernet2 = &enet2;
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci0 = &pci0;
+		pci1 = &pci1;
+		pci2 = &pci2;
+		spi0 = &spi0;
+	};
+
+	memory {
+		device_type = "memory";
+	};
+
+	soc: soc@ffe00000 {
+		ranges = <0x0 0x0 0xffe00000 0x00100000>;
+
+		i2c@3000 {
+			/* PCA9557PW GPIO controller for boot config */
+			gpio-controller@18 {
+				compatible = "nxp,pca9557";
+				label = "bootcfg";
+				reg = <0x18>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				polarity = <0x00>;
+			};
+
+			/* STM32F030R8T6 MCU for power control */
+			power-control@2a {
+				/*
+				 * Turris Power Control firmware runs on STM32F0 MCU.
+				 * This firmware is open source and available at:
+				 * https://gitlab.nic.cz/turris/hw/turris_power_control
+				 */
+				reg = <0x2a>;
+			};
+
+			/* DDR3 SPD/EEPROM PSWP instruction */
+			eeprom@32 {
+				reg = <0x32>;
+			};
+
+			/* SA56004ED temperature control */
+			temperature-sensor@4c {
+				compatible = "nxp,sa56004";
+				reg = <0x4c>;
+				interrupt-parent = <&gpio>;
+				interrupts = <12 IRQ_TYPE_LEVEL_LOW>, /* GPIO12 - ALERT pin */
+					     <13 IRQ_TYPE_LEVEL_LOW>; /* GPIO13 - CRIT pin */
+			};
+
+			/* DDR3 SPD/EEPROM */
+			eeprom@52 {
+				compatible = "atmel,spd";
+				reg = <0x52>;
+			};
+
+			/* MCP79402-I/ST Protected EEPROM */
+			eeprom@57 {
+				reg = <0x57>;
+			};
+
+			/* ATSHA204-TH-DA-T crypto module */
+			crypto@64 {
+				compatible = "atmel,atsha204";
+				reg = <0x64>;
+			};
+
+			/* IDT6V49205BNLGI clock generator */
+			clock-generator@69 {
+				compatible = "idt,6v49205b";
+				reg = <0x69>;
+			};
+
+			/* MCP79402-I/ST RTC */
+			rtc@6f {
+				compatible = "microchip,mcp7940x";
+				reg = <0x6f>;
+				interrupt-parent = <&gpio>;
+				interrupts = <14 0>; /* GPIO14 - MFP pin */
+			};
+		};
+
+		/* SPI on connector P1 */
+		spi0: spi@7000 {
+		};
+
+		gpio: gpio-controller@fc00 {
+			#interrupt-cells = <2>;
+			interrupt-controller;
+		};
+
+		/* Connected to SMSC USB2412-DZK 2-Port USB 2.0 Hub Controller */
+		usb@22000 {
+			phy_type = "ulpi";
+			dr_mode = "host";
+		};
+
+		enet0: ethernet@24000 {
+			/* Connected to port 6 of QCA8337N-AL3C switch */
+			phy-connection-type = "rgmii-id";
+
+			fixed-link {
+				speed = <1000>;
+				full-duplex;
+			};
+		};
+
+		mdio@24520 {
+			/* KSZ9031RNXCA ethernet phy for WAN port */
+			phy: ethernet-phy@7 {
+				interrupts = <3 1 0 0>;
+				reg = <0x7>;
+			};
+
+			/* QCA8337N-AL3C switch with integrated ethernet PHYs for LAN ports */
+			switch@10 {
+				compatible = "qca,qca8337";
+				interrupts = <2 1 0 0>;
+				reg = <0x10>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						label = "cpu";
+						ethernet = <&enet1>;
+						phy-mode = "rgmii-id";
+
+						fixed-link {
+							speed = <1000>;
+							full-duplex;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+						label = "lan5";
+					};
+
+					port@2 {
+						reg = <2>;
+						label = "lan4";
+					};
+
+					port@3 {
+						reg = <3>;
+						label = "lan3";
+					};
+
+					port@4 {
+						reg = <4>;
+						label = "lan2";
+					};
+
+					port@5 {
+						reg = <5>;
+						label = "lan1";
+					};
+
+					port@6 {
+						reg = <6>;
+						label = "cpu";
+						ethernet = <&enet0>;
+						phy-mode = "rgmii-id";
+
+						fixed-link {
+							speed = <1000>;
+							full-duplex;
+						};
+					};
+				};
+			};
+		};
+
+		ptp_clock@24e00 {
+			fsl,tclk-period = <5>;
+			fsl,tmr-prsc = <200>;
+			fsl,tmr-add = <0xcccccccd>;
+			fsl,tmr-fiper1 = <0x3b9ac9fb>;
+			fsl,tmr-fiper2 = <0x0001869b>;
+			fsl,max-adj = <249999999>;
+		};
+
+		enet1: ethernet@25000 {
+			/* Connected to port 0 of QCA8337N-AL3C switch */
+			phy-connection-type = "rgmii-id";
+
+			fixed-link {
+				speed = <1000>;
+				full-duplex;
+			};
+		};
+
+		mdio@25520 {
+			status = "disabled";
+		};
+
+		enet2: ethernet@26000 {
+			/* Connected to KSZ9031RNXCA ethernet phy (WAN port) */
+			label = "wan";
+			phy-handle = <&phy>;
+			phy-connection-type = "rgmii-id";
+		};
+
+		mdio@26520 {
+			status = "disabled";
+		};
+
+		sdhc@2e000 {
+			bus-width = <4>;
+			cd-gpios = <&gpio 8 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	lbc: localbus@ffe05000 {
+		reg = <0 0xffe05000 0 0x1000>;
+
+		ranges = <0x0 0x0 0x0 0xef000000 0x01000000>, /* NOR */
+			 <0x1 0x0 0x0 0xff800000 0x00040000>, /* NAND */
+			 <0x3 0x0 0x0 0xffa00000 0x00020000>; /* CPLD */
+
+		/* S29GL128P90TFIR10 NOR */
+		nor@0,0 {
+			compatible = "cfi-flash";
+			reg = <0x0 0x0 0x01000000>;
+			bank-width = <2>;
+			device-width = <1>;
+
+			partitions {
+				compatible = "fixed-partitions";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				partition@0 {
+					/* 128 kB for Device Tree Blob */
+					reg = <0x00000000 0x00020000>;
+					label = "dtb";
+				};
+
+				partition@20000 {
+					/* 1.7 MB for Linux Kernel Image */
+					reg = <0x00020000 0x001a0000>;
+					label = "kernel";
+				};
+
+				partition@1c0000 {
+					/* 1.5 MB for Rescue JFFS2 Root File System */
+					reg = <0x001c0000 0x00180000>;
+					label = "rescue";
+				};
+
+				partition@340000 {
+					/* 11 MB for TAR.XZ Archive with Factory content of NAND
+					 * Root File System
+					 */
+					reg = <0x00340000 0x00b00000>;
+					label = "factory";
+				};
+
+				partition@e40000 {
+					/* 768 kB for Certificates JFFS2 File System */
+					reg = <0x00e40000 0x000c0000>;
+					label = "certificates";
+				};
+
+				/* free unused space 0x00f00000-0x00f20000 */
+
+				partition@f20000 {
+					/* 128 kB for U-Boot Environment Variables */
+					reg = <0x00f20000 0x00020000>;
+					label = "u-boot-env";
+				};
+
+				partition@f40000 {
+					/* 768 kB for U-Boot Bootloader Image */
+					reg = <0x00f40000 0x000c0000>;
+					label = "u-boot";
+				};
+			};
+		};
+
+		/* MT29F2G08ABAEAWP:E NAND */
+		nand@1,0 {
+			compatible = "fsl,p2020-fcm-nand", "fsl,elbc-fcm-nand";
+			reg = <0x1 0x0 0x00040000>;
+			nand-ecc-mode = "soft";
+			nand-ecc-algo = "bch";
+
+			partitions {
+				compatible = "fixed-partitions";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				partition@0 {
+					/* 256 MB for UBI with one volume: UBIFS Root File System */
+					reg = <0x00000000 0x10000000>;
+					label = "rootfs";
+				};
+			};
+		};
+
+		/* LCMXO1200C-3FTN256C FPGA */
+		cpld@3,0 {
+			/*
+			 * Turris CPLD firmware which runs on this Lattice FPGA,
+			 * is extended version of P1021RDB-PC CPLD v4.1 firmware.
+			 * It is backward compatible with its original version
+			 * and the only extension is support for Turris LEDs.
+			 * Turris CPLD firmware is open source and available at:
+			 * https://gitlab.nic.cz/turris/hw/turris_cpld/-/blob/master/CZ_NIC_Router_CPLD.v
+			 */
+			compatible = "cznic,turris1x-cpld", "fsl,p1021rdb-pc-cpld", "simple-bus",
+				     "syscon";
+			reg = <0x3 0x0 0x30>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x3 0x0 0x00020000>;
+
+			/* MAX6370KA+T watchdog */
+			watchdog@2 {
+				/*
+				 * CPLD firmware maps SET0, SET1 and SET2
+				 * input logic of MAX6370KA+T chip to CPLD
+				 * memory space at byte offset 0x2. WDI
+				 * input logic is outside of the CPLD and
+				 * connected via external GPIO.
+				 */
+				compatible = "maxim,max6370";
+				reg = <0x02 0x01>;
+				gpios = <&gpio 11 GPIO_ACTIVE_LOW>;
+			};
+
+			reboot@d {
+				/*
+				 * CPLD firmware which manages system reset and
+				 * watchdog registers has bugs. It does not
+				 * autoclear system reset register after change
+				 * and watchdog ignores reset line on immediate
+				 * succeeding reset cycle triggered by watchdog.
+				 * These bugs have to be workarounded in U-Boot
+				 * bootloader. So use system reset via syscon as
+				 * a last resort because older U-Boot versions
+				 * do not have workaround for watchdog.
+				 *
+				 * Reset method via rstcr's global-utilities
+				 * (the preferred one) has priority level 128,
+				 * watchdog has priority level 0 and default
+				 * syscon-reboot priority level is 192.
+				 *
+				 * So define syscon-reboot with custom priority
+				 * level 64 (between rstcr and watchdog) because
+				 * rstcr should stay as default preferred reset
+				 * method and reset via watchdog is more broken
+				 * than system reset via syscon.
+				 */
+				compatible = "syscon-reboot";
+				reg = <0x0d 0x01>;
+				offset = <0x0d>;
+				mask = <0x01>;
+				value = <0x01>;
+				priority = <64>;
+			};
+
+			led-controller@13 {
+				/*
+				 * LEDs are controlled by CPLD firmware.
+				 * All five LAN LEDs share common RGB settings
+				 * and so it is not possible to set different
+				 * colors on different LAN ports.
+				 */
+				compatible = "cznic,turris1x-leds";
+				reg = <0x13 0x1d>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				multi-led@0 {
+					reg = <0x0>;
+					color = <LED_COLOR_ID_RGB>;
+					function = LED_FUNCTION_WAN;
+				};
+
+				multi-led@1 {
+					reg = <0x1>;
+					color = <LED_COLOR_ID_RGB>;
+					function = LED_FUNCTION_LAN;
+					function-enumerator = <5>;
+				};
+
+				multi-led@2 {
+					reg = <0x2>;
+					color = <LED_COLOR_ID_RGB>;
+					function = LED_FUNCTION_LAN;
+					function-enumerator = <4>;
+				};
+
+				multi-led@3 {
+					reg = <0x3>;
+					color = <LED_COLOR_ID_RGB>;
+					function = LED_FUNCTION_LAN;
+					function-enumerator = <3>;
+				};
+
+				multi-led@4 {
+					reg = <0x4>;
+					color = <LED_COLOR_ID_RGB>;
+					function = LED_FUNCTION_LAN;
+					function-enumerator = <2>;
+				};
+
+				multi-led@5 {
+					reg = <0x5>;
+					color = <LED_COLOR_ID_RGB>;
+					function = LED_FUNCTION_LAN;
+					function-enumerator = <1>;
+				};
+
+				multi-led@6 {
+					reg = <0x6>;
+					color = <LED_COLOR_ID_RGB>;
+					function = LED_FUNCTION_WLAN;
+				};
+
+				multi-led@7 {
+					reg = <0x7>;
+					color = <LED_COLOR_ID_RGB>;
+					function = LED_FUNCTION_POWER;
+				};
+			};
+		};
+	};
+
+	pci2: pcie@ffe08000 {
+		/*
+		 * PCIe bus for on-board TUSB7340RKM USB 3.0 xHCI controller.
+		 * This xHCI controller is available only on Turris 1.1 boards.
+		 * Turris 1.0 boards have nothing connected to this PCIe bus,
+		 * so system would see only PCIe Root Port of this PCIe Root
+		 * Complex. TUSB7340RKM xHCI controller has four SuperSpeed
+		 * channels. Channel 0 is connected to the front USB 3.0 port,
+		 * channel 1 (but only USB 2.0 subset) to USB 2.0 pins on mPCIe
+		 * slot 1 (CN5), channels 2 and 3 to connector P600.
+		 *
+		 * P2020 PCIe Root Port uses 1MB of PCIe MEM and xHCI controller
+		 * uses 64kB + 8kB of PCIe MEM. No PCIe IO is used or required.
+		 * So allocate 2MB of PCIe MEM for this PCIe bus.
+		 */
+		reg = <0 0xffe08000 0 0x1000>;
+		ranges = <0x02000000 0x0 0xc0000000 0 0xc0000000 0x0 0x00200000>, /* MEM */
+			 <0x01000000 0x0 0x00000000 0 0xffc20000 0x0 0x00010000>; /* IO */
+
+		pcie@0 {
+			ranges;
+		};
+	};
+
+	pci1: pcie@ffe09000 {
+		/* PCIe bus on mPCIe slot 2 (CN6) for expansion mPCIe card */
+		reg = <0 0xffe09000 0 0x1000>;
+		ranges = <0x02000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000>, /* MEM */
+			 <0x01000000 0x0 0x00000000 0 0xffc10000 0x0 0x00010000>; /* IO */
+
+		pcie@0 {
+			ranges;
+		};
+	};
+
+	pci0: pcie@ffe0a000 {
+		/*
+		 * PCIe bus on mPCIe slot 1 (CN5) for expansion mPCIe card.
+		 * Turris 1.1 boards have in this mPCIe slot additional USB 2.0
+		 * pins via channel 1 of TUSB7340RKM xHCI controller and also
+		 * additional SIM card slot, both for USB-based WWAN cards.
+		 */
+		reg = <0 0xffe0a000 0 0x1000>;
+		ranges = <0x02000000 0x0 0x80000000 0 0x80000000 0x0 0x20000000>, /* MEM */
+			 <0x01000000 0x0 0x00000000 0 0xffc00000 0x0 0x00010000>; /* IO */
+
+		pcie@0 {
+			ranges;
+		};
+	};
+};
+
+/include/ "fsl/p2020si-post.dtsi"
diff --git a/board/CZ.NIC/turris_1x/Kconfig b/board/CZ.NIC/turris_1x/Kconfig
new file mode 100644
index 0000000000..f55dfa14bc
--- /dev/null
+++ b/board/CZ.NIC/turris_1x/Kconfig
@@ -0,0 +1,155 @@
+# SPDX-License-Identifier: GPL-2.0+
+# (C) 2022 Pali Rohár <pali@kernel.org>
+
+if TARGET_TURRIS_1X
+
+# Board identification
+config SYS_BOARD
+	default "turris_1x"
+config SYS_VENDOR
+	default "CZ.NIC"
+config SYS_CONFIG_NAME
+	default "turris_1x"
+config DEFAULT_DEVICE_TREE
+	default "turris1x"
+
+# Board functions
+config ATSHA204A
+	default y
+config BOARD_EARLY_INIT_F
+	default y
+config BOARD_EARLY_INIT_R
+	default y
+config LAST_STAGE_INIT
+	default y
+config MISC
+	default y
+config OF_BOARD_FIXUP
+	default y
+config OF_BOARD_SETUP
+	default y
+
+# ENV
+config ENV_SIZE
+	default 0x2000
+config ENV_SECT_SIZE
+	default 0x20000
+config ENV_OVERWRITE
+	default y
+config ENV_IS_IN_FLASH
+	default y
+config ENV_ADDR
+	default 0xeff20000 # in NOR
+config SYS_RELOC_GD_ENV_ADDR
+	default y
+
+# DDR
+config DDR_CLK_FREQ
+	default 66666666
+config NR_DRAM_BANKS
+	default 5
+
+# UART
+config DEBUG_UART_BASE
+	default 0xffe04500 if DEBUG_UART
+config DEBUG_UART_CLOCK
+	default 37500000 if DEBUG_UART
+config SYS_NS16550
+	default y
+
+# I2C
+config I2C_SET_DEFAULT_BUS_NUM
+	default y
+config SYS_FSL_I2C_OFFSET
+	default 0x3000
+config SYS_FSL_HAS_I2C2_OFFSET
+	default y
+config SYS_FSL_I2C2_OFFSET
+	default 0x3100
+config SYS_I2C_FSL
+	default y
+
+# GPIO
+config MPC8XXX_GPIO
+	default y
+
+# WDT
+config WDT_MAX6370
+	default y
+
+# PCIe
+config PCI_INIT_R
+	default y
+config PCIE_FSL
+	default y
+
+# Ethernet
+config MII
+	default y
+config PHY_FIXED
+	default y
+config TSEC_ENET
+	default y
+
+# USB
+config USB_EHCI_FSL
+	default y
+config USB_XHCI_HCD
+	default y
+config USB_XHCI_PCI
+	default y
+
+# SDHC
+config FSL_ESDHC
+	default y
+config SYS_FSL_ESDHC_DEFAULT_BUS_WIDTH
+	default 4
+
+# NOR
+config MTD_NOR_FLASH
+	default y
+config CFI_FLASH
+	default y
+config FLASH_CFI_MTD
+	default y
+config SYS_FLASH_USE_BUFFER_WRITE
+	default y
+
+# NAND
+config MTD_RAW_NAND
+	default y
+config NAND_FSL_ELBC
+	default y
+config NAND_FSL_ELBC_DT
+	default y
+config BCH
+	default y
+config SYS_FLASH_CFI
+	default y
+config NAND_ECC_BCH
+	default y
+endif
+
+config SYS_LOAD_ADDR
+	default 0x1000000
+
+if SPL
+
+config SPL_ENV_SUPPORT
+	default y
+config SPL_FRAMEWORK
+	default n
+config SPL_I2C
+	default y
+config SPL_LIBCOMMON_SUPPORT
+	default y
+config SPL_LIBGENERIC_SUPPORT
+	default y
+config SPL_MPC8XXX_INIT_DDR
+	default y
+config SPL_SERIAL
+	default y
+config SPL_SYS_I2C_LEGACY
+	default y
+
+endif
diff --git a/board/CZ.NIC/turris_1x/MAINTAINERS b/board/CZ.NIC/turris_1x/MAINTAINERS
new file mode 100644
index 0000000000..e858c97b96
--- /dev/null
+++ b/board/CZ.NIC/turris_1x/MAINTAINERS
@@ -0,0 +1,13 @@
+TURRIS 1.X BOARD
+M:	Marek Mojík <marek.mojik@nic.cz>
+S:	Maintained
+F:	arch/powerpc/dts/turris1x-u-boot.dtsi
+F:	arch/powerpc/dts/turris1x.dts
+F:	board/CZ.NIC/turris_1x/
+F:	board/CZ.NIC/turris_atsha_otp.c
+F:	board/CZ.NIC/turris_atsha_otp.h
+F:	board/freescale/p1_p2_rdb_pc/p1_p2_rdb_pc.c
+F:	board/freescale/p1_p2_rdb_pc/spl.c
+F:	configs/turris_1x_nor_defconfig
+F:	configs/turris_1x_sdcard_defconfig
+F:	include/configs/turris_1x.h
diff --git a/board/CZ.NIC/turris_1x/Makefile b/board/CZ.NIC/turris_1x/Makefile
new file mode 100644
index 0000000000..a24aee9161
--- /dev/null
+++ b/board/CZ.NIC/turris_1x/Makefile
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0+
+# (C) 2022 Pali Rohár <pali@kernel.org>
+
+ifdef CONFIG_SPL_BUILD
+obj-y	+= ../../freescale/p1_p2_rdb_pc/spl.o
+endif
+
+obj-y	+= ../../freescale/p1_p2_rdb_pc/p1_p2_rdb_pc.o
+obj-y	+= ../turris_atsha_otp.o
+obj-y	+= ../turris_common.o
+
+obj-y	+= turris_1x.o
+obj-y	+= ddr.o
+obj-y	+= law.o
+obj-y	+= tlb.o
diff --git a/board/CZ.NIC/turris_1x/ddr.c b/board/CZ.NIC/turris_1x/ddr.c
new file mode 100644
index 0000000000..27400f9afc
--- /dev/null
+++ b/board/CZ.NIC/turris_1x/ddr.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0+
+// (C) 2022 Pali Rohár <pali@kernel.org>
+
+#include <config.h>
+#include <linux/types.h>
+#include <fsl_ddr_sdram.h>
+#include <fsl_ddr_dimm_params.h>
+
+void fsl_ddr_board_options(memctl_options_t *popts, dimm_params_t *pdimm, unsigned int ctrl_num)
+{
+	int i;
+
+	popts->clk_adjust = 6;
+	popts->cpo_override = 0x1f;
+	popts->write_data_delay = 2;
+	popts->half_strength_driver_enable = 1;
+	popts->wrlvl_en = 1;
+	popts->wrlvl_override = 1;
+	popts->wrlvl_sample = 0xf;
+	popts->wrlvl_start = 0x8;
+	popts->trwt_override = 1;
+	popts->trwt = 0;
+
+	for (i = 0; i < CONFIG_CHIP_SELECTS_PER_CTRL; i++) {
+		popts->cs_local_opts[i].odt_rd_cfg = FSL_DDR_ODT_NEVER;
+		popts->cs_local_opts[i].odt_wr_cfg = FSL_DDR_ODT_CS;
+	}
+}
diff --git a/board/CZ.NIC/turris_1x/law.c b/board/CZ.NIC/turris_1x/law.c
new file mode 100644
index 0000000000..51217ccf05
--- /dev/null
+++ b/board/CZ.NIC/turris_1x/law.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0+
+// (C) 2022 Pali Rohár <pali@kernel.org>
+
+#include <config.h>
+#include <asm/fsl_law.h>
+
+struct law_entry law_table[] = {
+	SET_LAW(CFG_SYS_FLASH_BASE_PHYS, LAW_SIZE_16M, LAW_TRGT_IF_LBC),
+	SET_LAW(CFG_SYS_NAND_BASE_PHYS, LAW_SIZE_256K, LAW_TRGT_IF_LBC),
+	SET_LAW(CFG_SYS_CPLD_BASE_PHYS, LAW_SIZE_128K, LAW_TRGT_IF_LBC),
+};
+
+int num_law_entries = ARRAY_SIZE(law_table);
diff --git a/board/CZ.NIC/turris_1x/tlb.c b/board/CZ.NIC/turris_1x/tlb.c
new file mode 100644
index 0000000000..f35a555838
--- /dev/null
+++ b/board/CZ.NIC/turris_1x/tlb.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0+
+// (C) 2022 Pali Rohár <pali@kernel.org>
+
+#include <config.h>
+#include <mpc85xx.h>
+#include <asm/mmu.h>
+#include <linux/sizes.h>
+#include <linux/build_bug.h>
+
+/*
+ * NOTE: e500v2 supports only following Book-E page sizes:
+ *
+ * TLB0:
+ * BOOKE_PAGESZ_4K
+ *
+ * TLB1:
+ * BOOKE_PAGESZ_4K
+ * BOOKE_PAGESZ_16K
+ * BOOKE_PAGESZ_64K
+ * BOOKE_PAGESZ_256K
+ * BOOKE_PAGESZ_1M
+ * BOOKE_PAGESZ_4M
+ * BOOKE_PAGESZ_16M
+ * BOOKE_PAGESZ_64M
+ * BOOKE_PAGESZ_256M
+ * BOOKE_PAGESZ_1G
+ * BOOKE_PAGESZ_4G
+ */
+
+struct fsl_e_tlb_entry tlb_table[] = {
+	/* TLB 0 */
+
+	/* ***** - Initial stack in L1 cache 16K */
+	SET_TLB_ENTRY(0, CFG_SYS_INIT_RAM_ADDR + 0 * SZ_4K,
+		      CFG_SYS_INIT_RAM_ADDR_PHYS + 0 * SZ_4K,
+		      MAS3_SX | MAS3_SW | MAS3_SR, 0,
+		      0, 0, BOOKE_PAGESZ_4K, 0),
+	SET_TLB_ENTRY(0, CFG_SYS_INIT_RAM_ADDR + 1 * SZ_4K,
+		      CFG_SYS_INIT_RAM_ADDR_PHYS + 1 * SZ_4K,
+		      MAS3_SX | MAS3_SW | MAS3_SR, 0,
+		      0, 0, BOOKE_PAGESZ_4K, 0),
+	SET_TLB_ENTRY(0, CFG_SYS_INIT_RAM_ADDR + 2 * SZ_4K,
+		      CFG_SYS_INIT_RAM_ADDR_PHYS + 2 * SZ_4K,
+		      MAS3_SX | MAS3_SW | MAS3_SR, 0,
+		      0, 0, BOOKE_PAGESZ_4K, 0),
+	SET_TLB_ENTRY(0, CFG_SYS_INIT_RAM_ADDR + 3 * SZ_4K,
+		      CFG_SYS_INIT_RAM_ADDR_PHYS + 3 * SZ_4K,
+		      MAS3_SX | MAS3_SW | MAS3_SR, 0,
+		      0, 0, BOOKE_PAGESZ_4K, 0),
+
+	/* TLB 1 */
+
+	/* *I*** - Boot page 4K */
+	SET_TLB_ENTRY(1, BPTR_VIRT_ADDR,
+		      0xfffff000,
+		      MAS3_SX | MAS3_SW | MAS3_SR, MAS2_I,
+		      0, 0, BOOKE_PAGESZ_4K, 1),
+
+	/* *I*G* - CCSR 1M */
+	SET_TLB_ENTRY(1, CFG_SYS_CCSRBAR,
+		      CFG_SYS_CCSRBAR_PHYS,
+		      MAS3_SX | MAS3_SW | MAS3_SR, MAS2_I | MAS2_G,
+		      0, 1, BOOKE_PAGESZ_1M, 1),
+
+	/* W**G* - NOR 16M */
+	/* This will be changed to *I*G* after relocation to RAM in board_early_init_r() */
+	SET_TLB_ENTRY(1, CFG_SYS_FLASH_BASE,
+		      CFG_SYS_FLASH_BASE_PHYS,
+		      MAS3_SX | MAS3_SR, MAS2_W | MAS2_G,
+		      0, 2, BOOKE_PAGESZ_16M, 1),
+
+	/* *I*G* - CPLD 256K (effective 128K) */
+	SET_TLB_ENTRY(1, CFG_SYS_CPLD_BASE,
+		      CFG_SYS_CPLD_BASE_PHYS,
+		      MAS3_SX | MAS3_SW | MAS3_SR, MAS2_I | MAS2_G,
+		      0, 3, BOOKE_PAGESZ_256K, 1),
+
+	/* *I*G* - NAND 256K */
+	SET_TLB_ENTRY(1, CFG_SYS_NAND_BASE,
+		      CFG_SYS_NAND_BASE_PHYS,
+		      MAS3_SX | MAS3_SW | MAS3_SR, MAS2_I | MAS2_G,
+		      0, 4, BOOKE_PAGESZ_256K, 1),
+
+	/* *I*G* - PCIe MEM (bus 1 and 2) 1G */
+	SET_TLB_ENTRY(1, CFG_SYS_PCIE1_MEM_VIRT,
+		      CFG_SYS_PCIE1_MEM_PHYS,
+		      MAS3_SX | MAS3_SW | MAS3_SR, MAS2_I | MAS2_G,
+		      0, 5, BOOKE_PAGESZ_1G, 1),
+
+	/* *I*G* - PCIe MEM (bus 3) 4M (effective 2M) */
+	SET_TLB_ENTRY(1, CFG_SYS_PCIE3_MEM_VIRT,
+		      CFG_SYS_PCIE3_MEM_PHYS,
+		      MAS3_SX | MAS3_SW | MAS3_SR, MAS2_I | MAS2_G,
+		      0, 6, BOOKE_PAGESZ_4M, 1),
+
+	/* *I*G* - PCIe I/O (all 3 buses) 256K (effective 192K) */
+	SET_TLB_ENTRY(1, CFG_SYS_PCIE1_IO_VIRT,
+		      CFG_SYS_PCIE1_IO_PHYS,
+		      MAS3_SX | MAS3_SW | MAS3_SR, MAS2_I | MAS2_G,
+		      0, 7, BOOKE_PAGESZ_256K, 1),
+
+#ifdef CFG_SYS_INIT_L2_ADDR
+	/* ***G* - Initial SRAM in L2 cache 512K */
+	SET_TLB_ENTRY(1, CFG_SYS_INIT_L2_ADDR,
+		      CFG_SYS_INIT_L2_ADDR_PHYS,
+		      MAS3_SX | MAS3_SW | MAS3_SR, MAS2_G,
+		      0, 8, BOOKE_PAGESZ_256K, 1),
+	SET_TLB_ENTRY(1, CFG_SYS_INIT_L2_ADDR + SZ_256K,
+		      CFG_SYS_INIT_L2_ADDR_PHYS + SZ_256K,
+		      MAS3_SX | MAS3_SW | MAS3_SR, MAS2_G,
+		      0, 9, BOOKE_PAGESZ_256K, 1),
+#endif
+
+#if defined(CONFIG_SPL) && !defined(CONFIG_SPL_BUILD)
+	/* **M** - SDRAM 2G */
+	SET_TLB_ENTRY(1, CFG_SYS_DDR_SDRAM_BASE,
+		      CFG_SYS_DDR_SDRAM_BASE,
+		      MAS3_SX | MAS3_SW | MAS3_SR, MAS2_M,
+		      0, 10, BOOKE_PAGESZ_1G, 1),
+	SET_TLB_ENTRY(1, CFG_SYS_DDR_SDRAM_BASE + SZ_1G,
+		      CFG_SYS_DDR_SDRAM_BASE + SZ_1G,
+		      MAS3_SX | MAS3_SW | MAS3_SR, MAS2_M,
+		      0, 11, BOOKE_PAGESZ_1G, 1),
+#endif
+};
+
+int num_tlb_entries = ARRAY_SIZE(tlb_table);
+
+/*
+ * PCIe MEM TLB entry expects that second PCIe MEM window is mapped after the
+ * first PCIe MEM window. Check for this requirement.
+ */
+static_assert(CFG_SYS_PCIE1_MEM_VIRT + SZ_512M == CFG_SYS_PCIE2_MEM_VIRT);
+static_assert(CFG_SYS_PCIE1_MEM_PHYS + SZ_512M == CFG_SYS_PCIE2_MEM_PHYS);
+
+/*
+ * PCIe I/O TLB entry expects that all 3 PCIe I/O windows are mapped one after
+ * another. Check for this requirement.
+ */
+static_assert(CFG_SYS_PCIE1_IO_VIRT + SZ_64K == CFG_SYS_PCIE2_IO_VIRT);
+static_assert(CFG_SYS_PCIE1_IO_PHYS + SZ_64K == CFG_SYS_PCIE2_IO_PHYS);
+static_assert(CFG_SYS_PCIE2_IO_VIRT + SZ_64K == CFG_SYS_PCIE3_IO_VIRT);
+static_assert(CFG_SYS_PCIE2_IO_PHYS + SZ_64K == CFG_SYS_PCIE3_IO_PHYS);
diff --git a/board/CZ.NIC/turris_1x/turris_1x.c b/board/CZ.NIC/turris_1x/turris_1x.c
new file mode 100644
index 0000000000..7a0b68caae
--- /dev/null
+++ b/board/CZ.NIC/turris_1x/turris_1x.c
@@ -0,0 +1,571 @@
+// SPDX-License-Identifier: GPL-2.0+
+// (C) 2022 Pali Rohár <pali@kernel.org>
+
+#include <init.h>
+#include <env.h>
+#include <fdt_support.h>
+#include <clock_legacy.h>
+#include <image.h>
+#include <asm/fsl_law.h>
+#include <asm/global_data.h>
+#include <asm/mmu.h>
+#include <dm/device.h>
+#include <dm/ofnode.h>
+#include <linux/build_bug.h>
+#include <display_options.h>
+
+#include "../turris_atsha_otp.h"
+
+DECLARE_GLOBAL_DATA_PTR;
+
+/*
+ * Reset time cycle register provided by Turris CPLD firmware.
+ * Turris CPLD firmware is open source and available at:
+ * https://gitlab.nic.cz/turris/hw/turris_cpld/-/blob/master/CZ_NIC_Router_CPLD.v
+ */
+#define TURRIS_CPLD_RESET_TIME_CYCLE_REG	((void *)CFG_SYS_CPLD_BASE + 0x1f)
+#define  TURRIS_CPLD_RESET_TIME_CYCLE_300MS	BIT(0)
+#define  TURRIS_CPLD_RESET_TIME_CYCLE_1S	BIT(1)
+#define  TURRIS_CPLD_RESET_TIME_CYCLE_2S	BIT(2)
+#define  TURRIS_CPLD_RESET_TIME_CYCLE_3S	BIT(3)
+#define  TURRIS_CPLD_RESET_TIME_CYCLE_4S	BIT(4)
+#define  TURRIS_CPLD_RESET_TIME_CYCLE_5S	BIT(5)
+#define  TURRIS_CPLD_RESET_TIME_CYCLE_6S	BIT(6)
+
+#define TURRIS_CPLD_LED_BRIGHTNESS_REG_FIRST	((void *)CFG_SYS_CPLD_BASE + 0x13)
+#define TURRIS_CPLD_LED_BRIGHTNESS_REG_LAST	((void *)CFG_SYS_CPLD_BASE + 0x1e)
+#define TURRIS_CPLD_LED_SW_OVERRIDE_REG		((void *)CFG_SYS_CPLD_BASE + 0x22)
+
+int dram_init_banksize(void)
+{
+	phys_size_t size = gd->ram_size;
+
+	static_assert(CONFIG_NR_DRAM_BANKS >= 3);
+
+	gd->bd->bi_dram[0].start = gd->ram_base;
+	gd->bd->bi_dram[0].size = get_effective_memsize();
+	size -= gd->bd->bi_dram[0].size;
+
+	/* Note: This address space is not mapped via TLB entries in U-Boot */
+
+#ifndef CONFIG_SDCARD
+	if (size > 0) {
+		/*
+		 * Setup additional overlapping 1 GB DDR LAW at the end of
+		 * 32-bit physical address space. It overlaps with all other
+		 * peripherals on P2020 mapped to physical address space.
+		 * But this is not issue because documentation says:
+		 * P2020 QorIQ Integrated Processor Reference Manual,
+		 * section 2.3.1 Precedence of local access windows:
+		 * If two local access windows overlap, the lower
+		 * numbered window takes precedence.
+		 */
+		if (set_ddr_laws(0xc0000000, SZ_1G, LAW_TRGT_IF_DDR_1) < 0) {
+			printf("Error: Cannot setup DDR LAW for more than 2 GB\n");
+			return 0;
+		}
+	}
+
+	if (size > 0) {
+		/* Free space between PCIe bus 3 MEM and NOR */
+		gd->bd->bi_dram[1].start = 0xc0200000;
+		gd->bd->bi_dram[1].size = min(size, 0xef000000 - gd->bd->bi_dram[1].start);
+		size -= gd->bd->bi_dram[1].size;
+	}
+
+	if (size > 0) {
+		/* Free space between NOR and NAND */
+		gd->bd->bi_dram[2].start = 0xf0000000;
+		gd->bd->bi_dram[2].size = min(size, 0xff800000 - gd->bd->bi_dram[2].start);
+		size -= gd->bd->bi_dram[2].size;
+	}
+#else
+	puts("\n\n!!! TODO: fix sdcard >2GB RAM\n\n\n");
+#endif
+	return 0;
+}
+
+static inline int fdt_setprop_inplace_u32_partial(void *blob, int node,
+						  const char *name,
+						  u32 idx, u32 val)
+{
+	val = cpu_to_fdt32(val);
+
+	return fdt_setprop_inplace_namelen_partial(blob, node, name,
+						   strlen(name),
+						   idx * sizeof(u32),
+						   &val, sizeof(u32));
+}
+
+/* Setup correct size of PCIe controller MEM in DT "ranges" property recursively */
+static void fdt_fixup_pcie_mem_size(void *blob, int node, phys_size_t pcie1_mem,
+				    phys_size_t pcie2_mem, phys_size_t pcie3_mem)
+{
+	int pci_cells, cpu_cells, size_cells;
+	const u32 *ranges;
+	int pnode;
+	int i, len;
+	u32 pci_flags;
+	u64 cpu_addr;
+	u64 size;
+	u64 new_size;
+	int pcie_id;
+	int idx;
+	int subnode;
+	int ret;
+
+	if (!fdtdec_get_is_enabled(blob, node))
+		return;
+
+	ranges = fdt_getprop(blob, node, "ranges", &len);
+	if (!ranges || !len || len % sizeof(u32))
+		return;
+
+	/*
+	 * The "ranges" property is an array of
+	 *   { <PCI address> <CPU address> <size in PCI address space> }
+	 * where number of PCI address cells and size cells is stored in the
+	 * "#address-cells" and "#size-cells" properties of the same node
+	 * containing the "ranges" property and number of CPU address cells
+	 * is stored in the parent's "#address-cells" property.
+	 *
+	 * All 3 elements can span a different number of cells. Fetch them.
+	 */
+	pnode = fdt_parent_offset(blob, node);
+	pci_cells = fdt_address_cells(blob, node);
+	cpu_cells = fdt_address_cells(blob, pnode);
+	size_cells = fdt_size_cells(blob, node);
+
+	/* PCI addresses always use 3 cells */
+	if (pci_cells != 3)
+		return;
+
+	/* CPU addresses and sizes on P2020 may be 32-bit (1 cell) or 64-bit (2 cells) */
+	if (cpu_cells != 1 && cpu_cells != 2)
+		return;
+	if (size_cells != 1 && size_cells != 2)
+		return;
+
+	for (i = 0; i < len / sizeof(u32); i += pci_cells + cpu_cells + size_cells) {
+		/* PCI address consists of 3 cells: flags, addr.hi, addr.lo */
+		pci_flags = fdt32_to_cpu(ranges[i]);
+
+		cpu_addr = fdt32_to_cpu(ranges[i + pci_cells]);
+		if (cpu_cells == 2) {
+			cpu_addr <<= 32;
+			cpu_addr |= fdt32_to_cpu(ranges[i + pci_cells + 1]);
+		}
+
+		size = fdt32_to_cpu(ranges[i + pci_cells + cpu_cells]);
+		if (size_cells == 2) {
+			size <<= 32;
+			size |= fdt32_to_cpu(ranges[i + pci_cells + cpu_cells + 1]);
+		}
+
+		/*
+		 * Bits [25:24] of PCI flags defines space code
+		 * 0b10 is 32-bit MEM and 0b11 is 64-bit MEM.
+		 * Check for any type of PCIe MEM mapping.
+		 */
+		if (!(pci_flags & 0x02000000))
+			continue;
+
+		if (cpu_addr == CFG_SYS_PCIE1_MEM_PHYS && size > pcie1_mem) {
+			pcie_id = 1;
+			new_size = pcie1_mem;
+		} else if (cpu_addr == CFG_SYS_PCIE2_MEM_PHYS && size > pcie2_mem) {
+			pcie_id = 2;
+			new_size = pcie2_mem;
+		} else if (cpu_addr == CFG_SYS_PCIE3_MEM_PHYS && size > pcie3_mem) {
+			pcie_id = 3;
+			new_size = pcie3_mem;
+		} else {
+			continue;
+		}
+
+		printf("Decreasing PCIe MEM %d size from ", pcie_id);
+		print_size(size, " to ");
+		print_size(new_size, "\n");
+		idx = i + pci_cells + cpu_cells;
+		if (size_cells == 2) {
+			ret = fdt_setprop_inplace_u32_partial(blob, node,
+							      "ranges", idx, 0);
+			if (ret)
+				goto err;
+			idx++;
+		}
+		ret = fdt_setprop_inplace_u32_partial(blob, node,
+						      "ranges", idx, SZ_2M);
+		if (ret)
+			goto err;
+	}
+
+	/* Recursively fix also all subnodes */
+	fdt_for_each_subnode(subnode, blob, node)
+		fdt_fixup_pcie_mem_size(blob, subnode, pcie1_mem, pcie2_mem, pcie3_mem);
+
+	return;
+
+err:
+	printf("Error: Cannot update \"ranges\" property\n");
+}
+
+static inline phys_size_t get_law_size(phys_addr_t addr, enum law_trgt_if id)
+{
+	struct law_entry e;
+
+	e = find_law_by_addr_id(addr, id);
+	if (e.index < 0)
+		return 0;
+
+	return 2ULL << e.size;
+}
+
+void ft_memory_setup(void *blob, struct bd_info *bd)
+{
+	phys_size_t pcie1_mem, pcie2_mem, pcie3_mem;
+	u64 start[CONFIG_NR_DRAM_BANKS];
+	u64 size[CONFIG_NR_DRAM_BANKS];
+	int count;
+	int node;
+
+	if (!env_get("bootm_low") && !env_get("bootm_size")) {
+		for (count = 0; count < CONFIG_NR_DRAM_BANKS; count++) {
+			start[count] = gd->bd->bi_dram[count].start;
+			size[count] = gd->bd->bi_dram[count].size;
+			if (!size[count])
+				break;
+		}
+		fdt_fixup_memory_banks(blob, start, size, count);
+	} else {
+		fdt_fixup_memory(blob, env_get_bootm_low(), env_get_bootm_size());
+	}
+
+	pcie1_mem = get_law_size(CFG_SYS_PCIE1_MEM_PHYS, LAW_TRGT_IF_PCIE_1);
+	pcie2_mem = get_law_size(CFG_SYS_PCIE2_MEM_PHYS, LAW_TRGT_IF_PCIE_2);
+	pcie3_mem = get_law_size(CFG_SYS_PCIE3_MEM_PHYS, LAW_TRGT_IF_PCIE_3);
+
+	fdt_for_each_node_by_compatible(node, blob, -1, "fsl,mpc8548-pcie")
+		fdt_fixup_pcie_mem_size(blob, node, pcie1_mem, pcie2_mem, pcie3_mem);
+}
+
+static int detect_model_serial(const char **model, char serial[17])
+{
+	u32 version_num;
+	int err;
+
+	err = turris_atsha_otp_get_serial_number(serial);
+	if (err) {
+		*model = "Turris 1.x";
+		strcpy(serial, "unknown");
+		return -1;
+	}
+
+	version_num = simple_strtoull(serial, NULL, 16) >> 32;
+
+	/*
+	 * Turris 1.0 boards (RTRS01) have version_num 0x5.
+	 * Turris 1.1 boards (RTRS02) have version_num 0x6, 0x7, 0x8 and 0x9.
+	 */
+	if (be32_to_cpu(version_num) >= 0x6) {
+		*model = "Turris 1.1 (RTRS02)";
+		return 1;
+	}
+
+	*model = "Turris 1.0 (RTRS01)";
+	return 0;
+}
+
+void p1_p2_rdb_pc_fix_fdt_model(void *blob)
+{
+	const char *model;
+	char serial[17];
+	int len;
+	int off;
+	int rev;
+	char c;
+
+	rev = detect_model_serial(&model, serial);
+	if (rev < 0)
+		return;
+
+	/* Turris 1.0 boards (RTRS01) do not have third PCIe controller */
+	if (rev == 0) {
+		off = fdt_path_offset(blob, "pci2");
+		if (off >= 0)
+			fdt_del_node(blob, off);
+	}
+
+	/* Fix model string only in case it is generic "Turris 1.x" */
+	model = fdt_getprop(blob, 0, "model", &len);
+	if (len < sizeof("Turris 1.x") - 1)
+		return;
+	if (memcmp(model, "Turris 1.x", sizeof("Turris 1.x") - 1) != 0)
+		return;
+
+	c = '0' + rev;
+	fdt_setprop_inplace_namelen_partial(blob, 0, "model", sizeof("model") - 1,
+					    sizeof("Turris 1.") - 1, &c, 1);
+}
+
+int misc_init_r(void)
+{
+	turris_atsha_otp_init_mac_addresses(0);
+	turris_atsha_otp_init_serial_number();
+	return 0;
+}
+
+/* This comes from ../../freescale/p1_p2_rdb_pc/p1_p2_rdb_pc.c */
+extern int checkboard_p1_p2(void);
+
+int checkboard(void)
+{
+	const char *model;
+	char serial[17];
+	void *reg;
+
+	/* Disable software control of all Turris LEDs */
+	out_8(TURRIS_CPLD_LED_SW_OVERRIDE_REG, 0x00);
+
+	/* Reset colors of all Turris LEDs to their default values */
+	for (reg = TURRIS_CPLD_LED_BRIGHTNESS_REG_FIRST;
+	     reg <= TURRIS_CPLD_LED_BRIGHTNESS_REG_LAST;
+	     reg++)
+		out_8(reg, 0xff);
+
+	detect_model_serial(&model, serial);
+	printf("Revision: %s\n", model);
+	printf("Serial Number: %s\n", serial);
+
+	return checkboard_p1_p2();
+}
+
+static void handle_reset_button(void)
+{
+	const char * const vars[1] = { "bootcmd_rescue", };
+	u8 reset_time_raw, reset_time;
+
+	/*
+	 * Ensure that bootcmd_rescue has always stock value, so that running
+	 *   run bootcmd_rescue
+	 * always works correctly.
+	 */
+	env_set_default_vars(1, (char * const *)vars, 0);
+
+	reset_time_raw = in_8(TURRIS_CPLD_RESET_TIME_CYCLE_REG);
+	if (reset_time_raw & TURRIS_CPLD_RESET_TIME_CYCLE_6S)
+		reset_time = 6;
+	else if (reset_time_raw & TURRIS_CPLD_RESET_TIME_CYCLE_5S)
+		reset_time = 5;
+	else if (reset_time_raw & TURRIS_CPLD_RESET_TIME_CYCLE_4S)
+		reset_time = 4;
+	else if (reset_time_raw & TURRIS_CPLD_RESET_TIME_CYCLE_3S)
+		reset_time = 3;
+	else if (reset_time_raw & TURRIS_CPLD_RESET_TIME_CYCLE_2S)
+		reset_time = 2;
+	else if (reset_time_raw & TURRIS_CPLD_RESET_TIME_CYCLE_1S)
+		reset_time = 1;
+	else
+		reset_time = 0;
+
+	env_set_ulong("turris_reset", reset_time);
+
+	/* Check if red reset button was hold for at least six seconds. */
+	if (reset_time >= 6) {
+		const char * const vars[3] = {
+			"bootcmd",
+			"bootdelay",
+			"distro_bootcmd",
+		};
+
+		/*
+		 * Set the above envs to their default values, in case the user
+		 * managed to break them.
+		 */
+		env_set_default_vars(3, (char * const *)vars, 0);
+
+		/* Ensure bootcmd_rescue is used by distroboot */
+		env_set("boot_targets", "rescue");
+
+		printf("RESET button was hold for >= 6s, overwriting boot_targets for system rescue!\n");
+	} else {
+		/*
+		 * In case the user somehow managed to save environment with
+		 * boot_targets=rescue, reset boot_targets to default value.
+		 * This could happen in subsequent commands if bootcmd_rescue
+		 * failed.
+		 */
+		if (!strcmp(env_get("boot_targets"), "rescue")) {
+			const char * const vars[1] = {
+				"boot_targets",
+			};
+
+			env_set_default_vars(1, (char * const *)vars, 0);
+		}
+
+		if (reset_time > 0)
+			printf("RESET button was hold for %us.\n", reset_time);
+	}
+}
+
+static int recalculate_pcie_mem_law(phys_addr_t addr,
+				    pci_size_t pcie_size,
+				    enum law_trgt_if id,
+				    phys_addr_t *free_start,
+				    phys_size_t *free_size)
+{
+	phys_size_t cur_size, new_size;
+	struct law_entry e;
+
+	e = find_law_by_addr_id(addr, id);
+	if (e.index < 0) {
+		*free_start = *free_size = 0;
+		return 0;
+	}
+
+	cur_size = 2ULL << e.size;
+	new_size = roundup_pow_of_two(pcie_size);
+
+	if (new_size >= cur_size) {
+		*free_start = *free_size = 0;
+		return 0;
+	}
+
+	set_law(e.index, addr, law_size_bits(new_size), id);
+
+	*free_start = addr + new_size;
+	*free_size = cur_size - new_size;
+	return 1;
+}
+
+static void recalculate_used_pcie_mem(void)
+{
+	phys_addr_t free_start1, free_start2;
+	phys_size_t free_size1, free_size2;
+	pci_size_t pcie1_used_mem_size;
+	pci_size_t pcie2_used_mem_size;
+	struct law_entry e;
+	phys_size_t size;
+	ofnode node;
+	int i;
+
+	size = gd->ram_size;
+
+	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++)
+		size -= gd->bd->bi_dram[i].size;
+
+	if (size == 0)
+		return;
+
+	e = find_law_by_addr_id(CFG_SYS_PCIE3_MEM_PHYS, LAW_TRGT_IF_PCIE_3);
+	if (e.index < 0 && gd->bd->bi_dram[1].size > 0) {
+		/*
+		 * If there is no LAW for PCIe 3 MEM then 3rd PCIe controller
+		 * is inactive, which is the case for Turris 1.0 boards. So
+		 * use its reserved 2 MB physical space for DDR RAM.
+		 */
+		unsigned int bank_size = SZ_2M;
+
+		if (bank_size > size)
+			bank_size = size;
+		printf("Reserving unused ");
+		print_size(bank_size, "");
+		printf(" of PCIe 3 MEM for DDR RAM\n");
+		gd->bd->bi_dram[1].start -= bank_size;
+		gd->bd->bi_dram[1].size += bank_size;
+		size -= bank_size;
+		if (size == 0)
+			return;
+	}
+
+#ifdef CONFIG_PCI_PNP
+	/*
+	 * Detect how much space of PCIe MEM is needed for both PCIe 1 and
+	 * PCIe 2 controllers with all connected cards on whole hierarchy.
+	 * This works only when U-Boot has enabled PCI PNP code which scans
+	 * all PCI devices and calculate required memory for every PCI BAR of
+	 * every PCI device.
+	 */
+	ofnode_for_each_compatible_node(node, "fsl,mpc8548-pcie") {
+		struct udevice *dev;
+
+		if (device_find_global_by_ofnode(node, &dev))
+			continue;
+
+		struct pci_controller *hose = dev_get_uclass_priv(pci_get_controller(dev));
+
+		if (!hose)
+			continue;
+		if (!hose->pci_mem)
+			continue;
+		if (!hose->pci_mem->size)
+			continue;
+
+		pci_size_t used_mem_size = hose->pci_mem->bus_lower - hose->pci_mem->bus_start;
+
+		if (hose->pci_mem->phys_start == CFG_SYS_PCIE1_MEM_PHYS)
+			pcie1_used_mem_size = used_mem_size;
+		else if (hose->pci_mem->phys_start == CFG_SYS_PCIE2_MEM_PHYS)
+			pcie2_used_mem_size = used_mem_size;
+	}
+
+	if (pcie1_used_mem_size == 0 && pcie2_used_mem_size == 0)
+		return;
+
+	e = find_law_by_addr_id(0xc0000000, LAW_TRGT_IF_DDR_1);
+	if (e.index < 0) {
+		printf("Error: Cannot setup DDR LAW for more than 3 GB of RAM\n");
+		return;
+	}
+
+	/*
+	 * Increase additional overlapping 1 GB DDR LAW from 1GB to 2GB by
+	 * moving its left side from 0xc0000000 to 0x80000000. After this
+	 * change it would overlap with PCIe MEM 1 and 2 LAWs.
+	 */
+	set_law(e.index, 0x80000000, LAW_SIZE_2G, LAW_TRGT_IF_DDR_1);
+
+	i = 3;
+	static_assert(CONFIG_NR_DRAM_BANKS >= 3 + 2);
+
+	if (recalculate_pcie_mem_law(CFG_SYS_PCIE2_MEM_PHYS,
+				     pcie2_used_mem_size, LAW_TRGT_IF_PCIE_2,
+				     &free_start2, &free_size2)) {
+		printf("Reserving unused ");
+		print_size(free_size2, "");
+		printf(" of PCIe 2 MEM for DDR RAM\n");
+		gd->bd->bi_dram[i].start = free_start2;
+		gd->bd->bi_dram[i].size = min(size, free_size2);
+		size -= gd->bd->bi_dram[i].start;
+		i++;
+		if (size == 0)
+			return;
+	}
+
+	if (recalculate_pcie_mem_law(CFG_SYS_PCIE1_MEM_PHYS,
+				     pcie1_used_mem_size, LAW_TRGT_IF_PCIE_1,
+				     &free_start1, &free_size1)) {
+		printf("Reserving unused ");
+		print_size(free_size1, "");
+		printf(" of PCIe 1 MEM for DDR RAM\n");
+		gd->bd->bi_dram[i].start = free_start1;
+		gd->bd->bi_dram[i].size = min(size, free_size1);
+		size -= gd->bd->bi_dram[i].size;
+		i++;
+		if (size == 0)
+			return;
+	}
+#endif
+}
+
+int last_stage_init(void)
+{
+	handle_reset_button();
+	recalculate_used_pcie_mem();
+	return 0;
+}
+
+int get_serial_clock(void)
+{
+	return get_bus_freq(0);
+}
diff --git a/board/freescale/p1_p2_rdb_pc/p1_p2_rdb_pc.c b/board/freescale/p1_p2_rdb_pc/p1_p2_rdb_pc.c
index 336d274cdb..a19a98dd0d 100644
--- a/board/freescale/p1_p2_rdb_pc/p1_p2_rdb_pc.c
+++ b/board/freescale/p1_p2_rdb_pc/p1_p2_rdb_pc.c
@@ -224,7 +224,7 @@ int board_early_init_f(void)
 #define BOARD_NAME "P2020RDB-PC"
 #endif
 
-int checkboard(void)
+int checkboard_p1_p2(void)
 {
 	struct cpld_data *cpld_data = (void *)(CFG_SYS_CPLD_BASE);
 	ccsr_gur_t *gur = (void *)(CFG_SYS_MPC85xx_GUTS_ADDR);
@@ -317,6 +317,13 @@ int checkboard(void)
 	return 0;
 }
 
+#if !defined(CONFIG_TARGET_TURRIS_1X)
+int checkboard(void)
+{
+	return checkboard_p1_p2();
+}
+#endif
+
 int board_early_init_r(void)
 {
 	const unsigned int flashbase = CFG_SYS_FLASH_BASE;
diff --git a/boot/Kconfig b/boot/Kconfig
index 6f3096c15a..8099af480b 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -812,7 +812,7 @@ choice
 	prompt "Freescale PBL (or predecessor) load location"
 	depends on RAMBOOT_PBL || ((TARGET_P1010RDB_PA || TARGET_P1010RDB_PB \
 		|| TARGET_P1020RDB_PC || TARGET_P1020RDB_PD || TARGET_P2020RDB) \
-		&& !CMD_NAND)
+		&& !CMD_NAND) || (TARGET_TURRIS_1X && SYS_MPC85XX_NO_RESETVEC)
 
 config SDCARD
 	bool "Freescale PBL (or similar) is found on SD card"
diff --git a/configs/turris_1x_nor_defconfig b/configs/turris_1x_nor_defconfig
new file mode 100644
index 0000000000..f06daaaca6
--- /dev/null
+++ b/configs/turris_1x_nor_defconfig
@@ -0,0 +1,87 @@
+CONFIG_PPC=y
+CONFIG_TEXT_BASE=0xeff40000
+CONFIG_SYS_MALLOC_F_LEN=0x1000
+CONFIG_SYS_MONITOR_LEN=786432
+CONFIG_MPC85xx=y
+CONFIG_SYS_INIT_RAM_LOCK=y
+# CONFIG_CMD_ERRATA is not set
+CONFIG_TARGET_TURRIS_1X=y
+CONFIG_MPC85XX_HAVE_RESET_VECTOR=y
+CONFIG_L2_CACHE=y
+CONFIG_ENABLE_36BIT_PHYS=y
+CONFIG_AHCI=y
+CONFIG_PCIE1=y
+CONFIG_PCIE2=y
+CONFIG_PCIE3=y
+CONFIG_OPTIMIZE_INLINING=y
+CONFIG_ENV_VARS_UBOOT_CONFIG=y
+CONFIG_HAS_BOARD_SIZE_LIMIT=y
+CONFIG_BOARD_SIZE_LIMIT=786432
+CONFIG_MP=y
+CONFIG_FIT=y
+CONFIG_SUPPORT_RAW_INITRD=y
+CONFIG_BOOTDELAY=3
+CONFIG_OF_STDOUT_VIA_ALIAS=y
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="run distro_bootcmd"
+CONFIG_USE_PREBOOT=y
+CONFIG_HUSH_PARSER=y
+CONFIG_CMD_BOOTZ=y
+# CONFIG_CMD_EEPROM is not set
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_SYS_LOADS_BAUD_CHANGE=y
+CONFIG_CMD_LSBLK=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_PART=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_WDT=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_TFTPPUT=y
+CONFIG_CMD_PING=y
+CONFIG_CMD_BTRFS=y
+CONFIG_CMD_EXT2=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_CMD_FS_UUID=y
+CONFIG_OF_CONTROL=y
+CONFIG_OF_INITIAL_DTB_READONLY=y
+CONFIG_USE_ETHPRIME=y
+CONFIG_ETHPRIME="eth2"
+# CONFIG_DM_DEVICE_REMOVE is not set
+CONFIG_SCSI_AHCI=y
+CONFIG_AHCI_PCI=y
+CONFIG_LBA48=y
+CONFIG_SYS_64BIT_LBA=y
+CONFIG_CHIP_SELECTS_PER_CTRL=2
+CONFIG_SYS_BR0_PRELIM_BOOL=y
+CONFIG_SYS_BR0_PRELIM=0xef001001
+CONFIG_SYS_OR0_PRELIM=0xff000ff7
+CONFIG_SYS_BR1_PRELIM_BOOL=y
+CONFIG_SYS_BR1_PRELIM=0xff800821
+CONFIG_SYS_OR1_PRELIM=0xfffc0796
+CONFIG_SYS_BR3_PRELIM_BOOL=y
+CONFIG_SYS_BR3_PRELIM=0xffa00801
+CONFIG_SYS_OR3_PRELIM=0xfffe09f7
+CONFIG_DM_I2C=y
+# CONFIG_MMC_HW_PARTITIONING is not set
+# CONFIG_MMC_VERBOSE is not set
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_SYS_FLASH_EMPTY_INFO=y
+CONFIG_SYS_FLASH_QUIET_TEST=y
+CONFIG_SYS_MAX_FLASH_SECT=128
+CONFIG_MTD_UBI=y
+CONFIG_DM_MDIO=y
+CONFIG_NVME_PCI=y
+CONFIG_SCSI=y
+CONFIG_SPECIFY_CONSOLE_INDEX=y
+CONFIG_DM_SERIAL=y
+CONFIG_USB=y
+CONFIG_USB_STORAGE=y
+CONFIG_WDT=y
+# CONFIG_BINMAN_FDT is not set
diff --git a/configs/turris_1x_sdcard_defconfig b/configs/turris_1x_sdcard_defconfig
new file mode 100644
index 0000000000..fb42e024c5
--- /dev/null
+++ b/configs/turris_1x_sdcard_defconfig
@@ -0,0 +1,106 @@
+CONFIG_PPC=y
+CONFIG_TEXT_BASE=0x11000000
+CONFIG_SYS_MALLOC_F_LEN=0x1000
+CONFIG_SPL_TEXT_BASE=0xf8f80000
+CONFIG_SYS_MONITOR_LEN=1048576
+CONFIG_SPL_MMC=y
+CONFIG_SPL=y
+CONFIG_MPC85xx=y
+CONFIG_SYS_INIT_RAM_LOCK=y
+CONFIG_FSL_PREPBL_ESDHC_BOOT_SECTOR=y
+CONFIG_TARGET_TURRIS_1X=y
+CONFIG_SYS_CCSRBAR_DEFAULT=0xffe00000
+CONFIG_L2_CACHE=y
+CONFIG_ENABLE_36BIT_PHYS=y
+CONFIG_SYS_MPC85XX_NO_RESETVEC=y
+CONFIG_SPL_SYS_MPC85XX_NO_RESETVEC=y
+CONFIG_DEBUG_UART=y
+CONFIG_AHCI=y
+CONFIG_PCIE1=y
+CONFIG_PCIE2=y
+CONFIG_PCIE3=y
+CONFIG_HAS_BOARD_SIZE_LIMIT=y
+CONFIG_BOARD_SIZE_LIMIT=1048576
+CONFIG_MP=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTDELAY=3
+CONFIG_OF_STDOUT_VIA_ALIAS=y
+CONFIG_USE_PREBOOT=y
+CONFIG_SPL_MAX_SIZE=0x80200
+CONFIG_SPL_PAD_TO=0x0
+CONFIG_SPL_MMC_BOOT=y
+CONFIG_SPL_GD_ADDR=0xf8f9c000
+CONFIG_SPL_RELOC_STACK=0xf8f9d000
+CONFIG_SPL_RELOC_MALLOC=y
+CONFIG_SPL_RELOC_MALLOC_ADDR=0xf8fa5000
+CONFIG_SPL_RELOC_MALLOC_SIZE=0x5b000
+CONFIG_SPL_TARGET="u-boot-with-spl.bin"
+CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_IMLS=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_SHA1SUM=y
+CONFIG_CMD_LZMADEC=y
+CONFIG_CMD_UNLZ4=y
+CONFIG_CMD_UNZIP=y
+CONFIG_CMD_DM=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_SYS_LOADS_BAUD_CHANGE=y
+CONFIG_CMD_LSBLK=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_SPI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_WDT=y
+CONFIG_CMD_TFTPPUT=y
+CONFIG_CMD_NFS=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_BTRFS=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_CMD_SQUASHFS=y
+CONFIG_CMD_FS_UUID=y
+CONFIG_CMD_UBI=y
+CONFIG_OF_CONTROL=y
+CONFIG_USE_ETHPRIME=y
+CONFIG_ETHPRIME="eth2"
+CONFIG_NETCONSOLE=y
+CONFIG_SCSI_AHCI=y
+CONFIG_AHCI_PCI=y
+CONFIG_LBA48=y
+CONFIG_SYS_64BIT_LBA=y
+CONFIG_CHIP_SELECTS_PER_CTRL=2
+CONFIG_SYS_BR0_PRELIM_BOOL=y
+CONFIG_SYS_BR0_PRELIM=0xef001001
+CONFIG_SYS_OR0_PRELIM=0xff000ff7
+CONFIG_SYS_BR1_PRELIM_BOOL=y
+CONFIG_SYS_BR1_PRELIM=0xff800821
+CONFIG_SYS_OR1_PRELIM=0xfffc0796
+CONFIG_SYS_BR3_PRELIM_BOOL=y
+CONFIG_SYS_BR3_PRELIM=0xffa00801
+CONFIG_SYS_OR3_PRELIM=0xfffe09f7
+CONFIG_DM_PCA953X=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_EEPROM_ADDR=0x52
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_SYS_FLASH_EMPTY_INFO=y
+CONFIG_SYS_FLASH_QUIET_TEST=y
+CONFIG_SYS_MAX_FLASH_SECT=128
+CONFIG_DM_MDIO=y
+CONFIG_NVME_PCI=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_DS1307=y
+CONFIG_SCSI=y
+CONFIG_DM_SERIAL=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_FSL_ESPI=y
+CONFIG_USB=y
+CONFIG_WDT=y
+CONFIG_FAT_WRITE=y
diff --git a/include/configs/turris_1x.h b/include/configs/turris_1x.h
new file mode 100644
index 0000000000..3d398a6c1e
--- /dev/null
+++ b/include/configs/turris_1x.h
@@ -0,0 +1,335 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* (C) 2022 Pali Rohár <pali@kernel.org> */
+
+#ifndef _CONFIG_TURRIS_1X_H
+#define _CONFIG_TURRIS_1X_H
+
+#include <linux/sizes.h>
+
+/*
+ * Turris 1.x memory map:
+ *
+ * 0x0000_0000 - 0x7fff_ffff    2 GB  DDR                 cacheable
+ * 0x8000_0000 - 0xbfff_ffff    1 GB  PCIe MEM (bus 1-2)  non-cacheable
+ * 0xc000_0000 - 0xc01f_ffff    2 MB  PCIe MEM (bus 3)    non-cacheable
+ * 0xc020_0000 - 0xeeff_ffff  750 MB  unused
+ * 0xef00_0000 - 0xefff_ffff   16 MB  NOR (CS0)           non-cacheable
+ * 0xf000_0000 - 0xf8f7_ffff  143 MB  unused
+ * 0xf8f8_0000 - 0xf8ff_ffff  512 kB  L2 SRAM             cacheable (early boot, SD card only)
+ * 0xf900_0000 - 0xff6f_ffff  103 MB  unused
+ * 0xff70_0000 - 0xff7f_ffff    1 MB  CCSR                non-cacheable (SPL only)
+ * 0xff80_0000 - 0xff83_ffff  256 kB  NAND (CS1)          non-cacheable
+ * 0xffa0_0000 - 0xffa1_ffff  128 kB  CPLD (CS3)          non-cacheable
+ * 0xffc0_0000 - 0xffc2_ffff  192 kB  PCIe IO             non-cacheable
+ * 0xffd0_0000 - 0xffd0_3fff   16 kB  L1 stack            cacheable (early boot)
+ * 0xffe0_0000 - 0xffef_ffff    1 MB  CCSR                non-cacheable (not in SPL)
+ * 0xffff_f000 - 0xffff_ffff    4 kB  Boot page           non-cacheable
+ */
+
+/*
+ * Global settings
+ */
+
+/*
+ * CONFIG_ENABLE_36BIT_PHYS needs to be always defined when processor supports
+ * 36-bit addressing (which is case for P2020), also when only 32-bit addressing
+ * mode is used. Name of this config option is misleading and should have been
+ * called SUPPORT instead of ENABLE.
+ * When CONFIG_PHYS_64BIT is set then 36-bit addressing is used, when unset then
+ * 32-bit addressing is used. Name of this config option is misleading too and
+ * should have been called 36BIT and ENABLED, not 64BIT.
+ * Due to performance reasons (see document AN4064), Turris 1.x boards use only
+ * 32-bit addressing. Also all config options are currently defined only for
+ * 32-bit addressing, so compiling U-Boot for 36-bit addressing is not possible
+ * yet.
+ */
+#ifdef CONFIG_PHYS_64BIT
+#error "36-bit addressing is not implemented for this board"
+#endif
+
+/*
+ * Boot settings
+ */
+
+/*
+ * Booting from SD card
+ * BootROM configures L2 cache as SRAM, loads image from SD card into L2 SRAM
+ * and starts executing directly _start entry point in L2 SRAM. Therefore reset
+ * vector is not used and maximal size of the image is L2 cache size. For builds
+ * with SPL there is no limit of U-Boot proper as BootROM loads SPL which then
+ * loads U-Boot proper directly into DDR.
+ */
+
+/*
+ * For SD card builds without SPL it is needed to set CONFIG_SYS_RAMBOOT
+ *
+ * if CONFIG_SPL_BUILD
+ *     if CONFIG_FSL_PREPBL_ESDHC_BOOT_SECTOR
+ *         define CONFIG_SPL_MAX_SIZE = (CONFIG_SYS_L2_SIZE+CONFIG_FSL_PREPBL_ESDHC_BOOT_SECTOR_DATA
+ *                                      * SZ_512)
+ *     else
+ *         define CONFIG_SPL_MAX_SIZE = CONFIG_SYS_L2_SIZE
+ */
+
+#ifdef CONFIG_SDCARD
+#define CFG_SYS_MMC_U_BOOT_SIZE	CONFIG_BOARD_SIZE_LIMIT
+#define CFG_SYS_MMC_U_BOOT_DST	CONFIG_TEXT_BASE
+#define CFG_SYS_MMC_U_BOOT_START	CONFIG_TEXT_BASE
+#endif
+
+/*
+ * Booting from NOR
+ * Last 4kB page of the NOR is mapped into CPU address space and CPU starts
+ * executing last instruction of that page, which is reset vector address.
+ * We have 16 MB large NOR memory, so define correct reset vector address.
+ *
+ * CONFIG_RESET_VECTOR_ADDRESS = (CONFIG_SYS_FLASH_BASE + SZ_16M - 4)
+ */
+
+/*
+ * CONFIG_BOARD_SIZE_LIMIT must be hex number because it is used in Makefile.
+ * For NOR build, size of the U-Boot binary must always be 768 kB.
+ * For SD card build with SPL, there is no limit, just broken build system which
+ * cannot fill CFG_SYS_MMC_U_BOOT_SIZE and CONFIG_SYS_MONITOR_LEN values
+ * automatically. So choose it as lowest value as possible with which build
+ * process does not fail, to minimize final binary size.
+ * For SD card build without SPL, there is upper limit of L2 cache size.
+ *
+ * if SDCARD
+ *     CONFIG_BOARD_SIZE_LIMIT = 0x000c0000 // 768 kB
+ * elif SPL
+ *     CONFIG_BOARD_SIZE_LIMIT = 0x00100000 // 1 MB
+ * else
+ *     CONFIG_BOARD_SIZE_LIMIT = 0x00080000 // 512 kB - must be same as CONFIG_SYS_L2_SIZE
+ */
+
+/*
+ * Initial stack in L1 cache
+ */
+
+#define CFG_SYS_INIT_RAM_ADDR			0xffd00000
+#define CFG_SYS_INIT_RAM_ADDR_PHYS		CFG_SYS_INIT_RAM_ADDR
+#define CFG_SYS_INIT_RAM_ADDR_PHYS_HIGH	0
+#define CFG_SYS_INIT_RAM_ADDR_PHYS_LOW		CFG_SYS_INIT_RAM_ADDR_PHYS
+#define CFG_SYS_INIT_RAM_SIZE			SZ_16K
+
+#define CFG_SYS_GBL_DATA_OFFSET			(CFG_SYS_INIT_RAM_SIZE - GENERATED_GBL_DATA_SIZE)
+#define CFG_SYS_INIT_SP_OFFSET			CFG_SYS_GBL_DATA_OFFSET
+
+/*
+ * Initial SRAM in L2 cache
+ */
+
+/* Initial SRAM is used only for SD card boot in first stage image */
+#if !defined(CONFIG_SPL) || defined(CONFIG_SPL_BUILD)
+#define CFG_SYS_INIT_L2_ADDR		0xf8f80000
+#define CFG_SYS_INIT_L2_ADDR_PHYS	CFG_SYS_INIT_L2_ADDR
+/*
+ * CONFIG_SPL_RELOC_TEXT_BASE =     CONFIG_SYS_MONITOR_BASE
+ * CONFIG_SPL_GD_ADDR =             (CFG_SYS_INIT_L2_ADDR + 112 * SZ_1K)
+ * CONFIG_SPL_RELOC_STACK =         (CFG_SYS_INIT_L2_ADDR + 116 * SZ_1K)
+ * CONFIG_SPL_RELOC_MALLOC_ADDR =   (CFG_SYS_INIT_L2_ADDR + 148 * SZ_1K)
+ * CONFIG_SPL_RELOC_MALLOC_SIZE =   (364 * SZ_1K)
+ */
+#endif
+
+/*
+ * CCSR
+ */
+
+#define CFG_SYS_CCSRBAR				0xffe00000
+#define CFG_SYS_CCSRBAR_PHYS_LOW		CFG_SYS_CCSRBAR
+/*
+ * CFG_SYS_CCSRBAR_PHYS_HIGH =	0x0
+ */
+
+/*
+ * U-Boot _start code expects that if CCSRBAR is configured to its default
+ * location and automatically relocate it to the new CONFIG_SYS_CCSRBAR_PHYS
+ * location. Relocation to the new location can be skipped by defining macro
+ * CONFIG_SYS_CCSR_DO_NOT_RELOCATE.
+ *
+ * All addresses in device tree are set to according the new relocated CCSRBAR.
+ * So device tree code cannot be used when CONFIG_SYS_CCSR_DO_NOT_RELOCATE is
+ * set.
+ *
+ * If CCSRBAR is not configured to its default location then _start code hangs
+ * or crashes.
+ *
+ * So relocation of CCSRBAR must be disabled in every code which runs before
+ * U-Boot proper (e.g. SPL), otherwise U-Boot proper's _start code crashes.
+ */
+
+/*
+ * DDR
+ */
+
+#define CFG_SYS_DDR_SDRAM_BASE			0x00000000
+#define CFG_SYS_SDRAM_BASE				CFG_SYS_DDR_SDRAM_BASE
+
+#define CFG_SYS_I2C_PCA9557_ADDR	0x18
+#define SPD_EEPROM_ADDRESS		0x52
+
+/*
+ * NOR
+ */
+
+#define CFG_SYS_FLASH_BASE		0xef000000
+#define CFG_SYS_FLASH_BASE_PHYS	CFG_SYS_FLASH_BASE
+#define CFG_RESET_VECTOR_ADDRESS	(CFG_SYS_FLASH_BASE + SZ_16M - 4)
+
+/*
+ * CONFIG_SYS_BR0_PRELIM = (BR_PHYS_ADDR(CFG_SYS_FLASH_BASE_PHYS) | BR_PS_16 | BR_MS_GPCM | BR_V)
+ * CONFIG_SYS_OR0_PRELIM = (OR_AM_16MB | OR_GPCM_CSNT | OR_GPCM_ACS_DIV2 | OR_GPCM_XACS
+ *                         | OR_GPCM_SCY_15 | OR_GPCM_TRLX | OR_GPCM_EHTR | OR_GPCM_EAD)
+ */
+
+/*
+ * NAND
+ */
+
+#define CFG_SYS_NAND_BASE		0xff800000
+#define CFG_SYS_NAND_BASE_PHYS	CFG_SYS_NAND_BASE
+
+/*
+ * CONFIG_SYS_BR1_PRELIM = BR_PHYS_ADDR(CFG_SYS_NAND_BASE_PHYS) | BR_PS_8 | BR_MS_FCM | BR_V)
+ * CONFIG_SYS_OR1_PRELIM = (OR_AM_256KB | OR_FCM_PGS | OR_FCM_CSCT | OR_FCM_CST | OR_FCM_CHT
+ *                         | OR_FCM_SCY_1 | OR_FCM_TRLX | OR_FCM_EHTR)
+ */
+
+#define CFG_SYS_NAND_BASE_LIST	{ CFG_SYS_NAND_BASE }
+#define CFG_SYS_NAND_OR_PRELIM	CONFIG_SYS_OR1_PRELIM
+
+/*
+ * CPLD
+ */
+
+#define CFG_SYS_CPLD_BASE		0xffa00000
+#define CFG_SYS_CPLD_BASE_PHYS	CFG_SYS_CPLD_BASE
+
+/*
+ * CONFIG_SYS_BR3_PRELIM = (BR_PHYS_ADDR(CFG_SYS_CPLD_BASE_PHYS) | BR_PS_8 | BR_MS_GPCM | BR_V)
+ * CONFIG_SYS_OR3_PRELIM = (OR_AM_128KB | OR_GPCM_CSNT | OR_GPCM_XACS | OR_GPCM_SCY_15
+ *                         | OR_GPCM_TRLX | OR_GPCM_EHTR | OR_GPCM_EAD)
+ */
+
+/*
+ * Serial Port
+ */
+
+#if !CONFIG_IS_ENABLED(DM_SERIAL)
+#define CFG_SYS_NS16550_CLK			get_bus_freq(0)
+#define CFG_SYS_NS16550_COM1		(CFG_SYS_CCSRBAR + 0x4500)
+#define CFG_SYS_NS16550_COM2		(CFG_SYS_CCSRBAR + 0x4600)
+#endif
+
+/*
+ * PCIe
+ */
+
+/* PCIe bus on mPCIe slot 1 (CN5) for expansion mPCIe card */
+#define CFG_SYS_PCIE1_MEM_VIRT	0x80000000
+#define CFG_SYS_PCIE1_IO_VIRT	0xffc00000
+#define CFG_SYS_PCIE1_MEM_PHYS	CFG_SYS_PCIE1_MEM_VIRT
+#define CFG_SYS_PCIE1_IO_PHYS	CFG_SYS_PCIE1_IO_VIRT
+
+/* PCIe bus on mPCIe slot 2 (CN6) for expansion mPCIe card */
+#define CFG_SYS_PCIE2_MEM_VIRT	0xa0000000
+#define CFG_SYS_PCIE2_IO_VIRT	0xffc10000
+#define CFG_SYS_PCIE2_MEM_PHYS	CFG_SYS_PCIE2_MEM_VIRT
+#define CFG_SYS_PCIE2_IO_PHYS	CFG_SYS_PCIE2_IO_VIRT
+
+/* PCIe bus for on-board TUSB7340RKM USB 3.0 xHCI controller */
+#define CFG_SYS_PCIE3_MEM_VIRT	0xc0000000
+#define CFG_SYS_PCIE3_IO_VIRT	0xffc20000
+#define CFG_SYS_PCIE3_MEM_PHYS	CFG_SYS_PCIE3_MEM_VIRT
+#define CFG_SYS_PCIE3_IO_PHYS	CFG_SYS_PCIE3_IO_VIRT
+
+/*
+ * eSDHC
+ */
+
+#define CFG_SYS_FSL_ESDHC_ADDR	CFG_SYS_MPC85xx_ESDHC_ADDR
+#define SDHC_WP_IS_GPIO		/* SDHC_WP pin is not connected to SD card slot, it is GPIO pin */
+
+/*
+ * For booting Linux, the board info and command line data
+ * have to be in the first 64 MB of memory, since this is
+ * the maximum mapped by the Linux kernel during initialization.
+ */
+#define CFG_SYS_BOOTMAPSZ		SZ_64M /* Initial Memory for Linux */
+
+/*
+ * Environment Configuration
+ */
+
+#ifdef CONFIG_SDCARD
+#define BOOT_TARGET_DEVICES(func) \
+	func(MMC, mmc, 0) \
+	func(NVME, nvme, 0) \
+	func(SCSI, scsi, 0) \
+	func(USB, usb, 0) \
+	func(USB, usb, 1) \
+	func(USB, usb, 2) \
+	func(USB, usb, 3) \
+	func(USB, usb, 4) \
+	func(UBIFS, ubifs, 0, rootfs, rootfs, 512) \
+	func(UBIFS, ubifs, 1, rootfs, rootfs, 2048) \
+	func(DHCP, dhcp, na)
+#else
+#define BOOT_TARGET_DEVICES(func) \
+	func(MMC, mmc, 0) \
+	func(NVME, nvme, 0) \
+	func(SCSI, scsi, 0) \
+	func(USB, usb, 0) \
+	func(USB, usb, 1) \
+	func(USB, usb, 2) \
+	func(USB, usb, 3) \
+	func(USB, usb, 4) \
+	func(DHCP, dhcp, na)
+#endif
+
+#include <config_distro_bootcmd.h>
+
+/* These boot source switches macros must be constant numbers as they are stringified */
+#define __SW_BOOT_MASK			0x03
+#define __SW_BOOT_NOR			0xc8
+#define __SW_BOOT_SPI			0x28
+#define __SW_BOOT_SD			0x68
+#define __SW_BOOT_SD2			0x18
+#define __SW_BOOT_NAND			0xe8
+#define __SW_BOOT_PCIE			0xa8
+#define __SW_NOR_BANK_MASK		0xfd
+#define __SW_NOR_BANK_UP		0x00
+#define __SW_NOR_BANK_LO		0x02
+#define __SW_BOOT_NOR_BANK_UP		0xc8 /* (__SW_BOOT_NOR | __SW_NOR_BANK_UP) */
+#define __SW_BOOT_NOR_BANK_LO		0xca /* (__SW_BOOT_NOR | __SW_NOR_BANK_LO) */
+#define __SW_BOOT_NOR_BANK_MASK		0x01 /* (__SW_BOOT_MASK & __SW_NOR_BANK_MASK) */
+
+#include "p1_p2_bootsrc.h"
+
+#define REBOOT_ENV_SETTINGS \
+	RST_NOR_UP_CMD(reboot_to_nor, echo Rebooting to NOR bootloader;) \
+	RST_SD_CMD(reboot_to_sd, echo Rebooting to SD bootloader;) \
+	RST_DEF_CMD(reboot_to_def, echo Rebooting to default bootloader;) \
+	""
+
+#define BOOTCMD_RESCUE \
+	"setenv bootargs root=mtd2 ro rootfstype=jffs2 console=ttyS0,115200; " \
+	"mw.b 0xffa00002 0x03; " \
+	"bootm 0xef020000 - 0xef000000" \
+	""
+
+#define CFG_EXTRA_ENV_SETTINGS \
+	"fdt_addr_r=0x2000000\0" \
+	"kernel_addr_r=0x2100000\0" \
+	"scriptaddr=0x3000000\0" \
+	"pxefile_addr_r=0x3100000\0" \
+	"ramdisk_addr_r=0x4000000\0" \
+	"fdtfile=" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0" \
+	"fdt_addr=0xef000000\0" \
+	"bootcmd_rescue=" BOOTCMD_RESCUE "\0" \
+	REBOOT_ENV_SETTINGS \
+	BOOTENV
+
+#endif /* _CONFIG_TURRIS_1X_H */
-- 
2.45.1

