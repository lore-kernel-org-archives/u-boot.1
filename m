Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17840C3ABC5
	for <u-boot@archiver.kernel.org>; Sun, 11 May 2025 13:03:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73323829A0;
	Sun, 11 May 2025 15:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="sUsZWE7S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0C5D8210D; Sat, 10 May 2025 23:02:54 +0200 (CEST)
Received: from mail-106101.protonmail.ch (mail-106101.protonmail.ch
 [79.135.106.101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E0E480EE5
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 23:02:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=omapbsf@protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1746910968; x=1747170168;
 bh=pbvQdJLQLhBXC+RPfEDlQ0GzJyrXq58Dn4l+vdBmKW8=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
 List-Unsubscribe:List-Unsubscribe-Post;
 b=sUsZWE7Sw0qUf0W1w49iw/eaIPCh9Da0kgg5O+oJGvnTvVu+f3svZNV4hBUiQlFHk
 bT6YSOTF531DU9zTlU4KvFSs7wAA4rDzjfF4h/4uorf7CXj3Zk0TzlCDgHRqss1bPp
 t6vLgHtpunns3EH0XDH1/zJ6AhS/ATCM7YYLRySkItx0Wc3vqQIekjPGs3gztnMGPE
 PK0fx1QHaUGm7gABaJcq1PiPsU86FoKqbK0lbS7mgs1m9NgqTiAi3WGnrcPum981kL
 0fNGPjX7c87DRMY/8a0yOEPgkKLi8hFYRpilHcswuyWdr8wMWSCTOPrhh7NyetkrN1
 kysJ2EFSUb2lw==
Date: Sat, 10 May 2025 21:02:43 +0000
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
From: OMAP at BSF <omapbsf@protonmail.com>
Subject: [PATCH v2 1/2] BeagleBoard: Bring it back with updates.
Message-ID: <wM3seWgM7nTqYrWUrMIA0F0YvNBTcJMbkcOmyU0yylDQ27YFJToncVGiNstM8G4bqfydlQrjZ0zzRW7GMocc_czSOFoLFE0qdo-6ie37N0c=@protonmail.com>
Feedback-ID: 36988183:user:proton
X-Pm-Message-ID: f19d64f6c5b1a0ae2edc1c5e01795002faefa38b
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 11 May 2025 15:02:43 +0200
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

* Converted to using DM_I2C.
* New config file for xM.
* Run 'patman' on patches.
* Use upstream device tree files.

Signed-off-by: Nevets Llih <omapbsf@protonmail.com>
---
 arch/arm/dts/Makefile                       |   9 +
 arch/arm/dts/omap3-beagle-u-boot.dtsi       |  14 +
 arch/arm/dts/omap3-beagle-xm-ab-u-boot.dtsi |  14 +
 arch/arm/dts/omap3-beagle-xm-u-boot.dtsi    |  14 +
 arch/arm/dts/omap3-u-boot.dtsi              |  34 +-
 arch/arm/include/asm/arch-omap3/cpu.h       |   3 +-
 arch/arm/include/asm/arch-omap3/hardware.h  |  22 +
 arch/arm/include/asm/arch-omap3/mem.h       |   8 +-
 arch/arm/mach-omap2/omap3/Kconfig           |  14 +
 board/beagle/beagle/Kconfig                 |  14 +
 board/beagle/beagle/MAINTAINERS             |   7 +
 board/beagle/beagle/Makefile                |   7 +
 board/beagle/beagle/beagle.c                | 541 +++++++++++++++++++
 board/beagle/beagle/beagle.h                | 545 ++++++++++++++++++++
 board/beagle/beagle/led.c                   |  70 +++
 board/isee/igep00x0/spl.c                   |   6 +-
 board/lg/sniper/sniper.c                    |   2 +-
 board/logicpd/omap3som/omap3logic.c         |   4 +-
 board/ti/omap3evm/evm.c                     |   2 +-
 board/timll/devkit8000/devkit8000.c         |   2 +-
 configs/omap3_beagle_defconfig              | 124 +++++
 configs/omap3_beagle_xm_defconfig           | 109 ++++
 include/configs/omap3_beagle.h              | 201 ++++++++
 23 files changed, 1736 insertions(+), 30 deletions(-)
 create mode 100644 arch/arm/dts/omap3-beagle-u-boot.dtsi
 create mode 100644 arch/arm/dts/omap3-beagle-xm-ab-u-boot.dtsi
 create mode 100644 arch/arm/dts/omap3-beagle-xm-u-boot.dtsi
 create mode 100644 arch/arm/include/asm/arch-omap3/hardware.h
 create mode 100644 board/beagle/beagle/Kconfig
 create mode 100644 board/beagle/beagle/MAINTAINERS
 create mode 100644 board/beagle/beagle/Makefile
 create mode 100644 board/beagle/beagle/beagle.c
 create mode 100644 board/beagle/beagle/beagle.h
 create mode 100644 board/beagle/beagle/led.c
 create mode 100644 configs/omap3_beagle_defconfig
 create mode 100644 configs/omap3_beagle_xm_defconfig
 create mode 100644 include/configs/omap3_beagle.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 82f5c374f10..35b83eee33c 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -964,6 +964,15 @@ dtb-$(CONFIG_TARGET_GARDENA_SMART_GATEWAY_AT91SAM) +=
=3D \
=20
 dtb-$(CONFIG_TARGET_USB_A9263) +=3D usb_a9263.dtb
=20
+dtb-$(CONFIG_TARGET_OMAP3_EVM) +=3D \
+=09omap3-evm-37xx.dtb \
+=09omap3-evm.dtb
+
+dtb-$(CONFIG_TARGET_OMAP3_BEAGLE) +=3D \
+=09omap3-beagle-xm-ab.dtb \
+=09omap3-beagle-xm.dtb \
+=09omap3-beagle.dtb
+
 dtb-$(CONFIG_TARGET_DEVKIT8000) +=3D omap3-devkit8000.dtb
=20
 dtb-$(CONFIG_TARGET_SAMA7G5EK) +=3D \
diff --git a/arch/arm/dts/omap3-beagle-u-boot.dtsi b/arch/arm/dts/omap3-bea=
gle-u-boot.dtsi
new file mode 100644
index 00000000000..2c03701c896
--- /dev/null
+++ b/arch/arm/dts/omap3-beagle-u-boot.dtsi
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * U-Boot additions
+ *
+ * (C) Copyright 2017 Derald D. Woods <woods.technical@gmail.com>
+ */
+
+#include "omap3-u-boot.dtsi"
+
+/ {
+=09chosen {
+=09=09stdout-path =3D &uart3;
+=09};
+};
diff --git a/arch/arm/dts/omap3-beagle-xm-ab-u-boot.dtsi b/arch/arm/dts/oma=
p3-beagle-xm-ab-u-boot.dtsi
new file mode 100644
index 00000000000..2c03701c896
--- /dev/null
+++ b/arch/arm/dts/omap3-beagle-xm-ab-u-boot.dtsi
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * U-Boot additions
+ *
+ * (C) Copyright 2017 Derald D. Woods <woods.technical@gmail.com>
+ */
+
+#include "omap3-u-boot.dtsi"
+
+/ {
+=09chosen {
+=09=09stdout-path =3D &uart3;
+=09};
+};
diff --git a/arch/arm/dts/omap3-beagle-xm-u-boot.dtsi b/arch/arm/dts/omap3-=
beagle-xm-u-boot.dtsi
new file mode 100644
index 00000000000..2c03701c896
--- /dev/null
+++ b/arch/arm/dts/omap3-beagle-xm-u-boot.dtsi
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * U-Boot additions
+ *
+ * (C) Copyright 2017 Derald D. Woods <woods.technical@gmail.com>
+ */
+
+#include "omap3-u-boot.dtsi"
+
+/ {
+=09chosen {
+=09=09stdout-path =3D &uart3;
+=09};
+};
diff --git a/arch/arm/dts/omap3-u-boot.dtsi b/arch/arm/dts/omap3-u-boot.dts=
i
index bc2793757b7..b17790e758b 100644
--- a/arch/arm/dts/omap3-u-boot.dtsi
+++ b/arch/arm/dts/omap3-u-boot.dtsi
@@ -9,74 +9,74 @@
=20
 /{
 =09ocp@68000000 {
-=09=09bootph-pre-ram;
+=09=09bootph-all;
=20
 =09=09bandgap@48002524 {
-=09=09=09bootph-pre-ram;
+=09=09=09bootph-all;
 =09=09};
 =09};
 };
=20
 &uart1 {
-=09bootph-pre-ram;
+=09bootph-all;
 =09reg-shift =3D <2>;
 };
=20
 &uart2 {
-=09bootph-pre-ram;
+=09bootph-all;
 =09reg-shift =3D <2>;
 };
=20
 &uart3 {
-=09bootph-pre-ram;
+=09bootph-all;
 =09reg-shift =3D <2>;
 };
=20
 &mmc1 {
-=09bootph-pre-ram;
+=09bootph-all;
 };
=20
 &mmc2 {
-=09bootph-pre-ram;
+=09bootph-all;
 };
=20
 &l4_core {
-=09bootph-pre-ram;
+=09bootph-all;
 };
=20
 &scm {
-=09bootph-pre-ram;
+=09bootph-all;
 };
=20
 &scm_conf {
-=09bootph-pre-ram;
+=09bootph-all;
 };
=20
 &gpio1 {
-=09bootph-pre-ram;
+=09bootph-all;
 };
=20
 &gpio2 {
-=09bootph-pre-ram;
+=09bootph-all;
 };
=20
 &gpio3 {
-=09bootph-pre-ram;
+=09bootph-all;
 };
=20
 &gpio4 {
-=09bootph-pre-ram;
+=09bootph-all;
 };
=20
 &gpio5 {
-=09bootph-pre-ram;
+=09bootph-all;
 };
=20
 &gpio6 {
-=09bootph-pre-ram;
+=09bootph-all;
 };
=20
 &i2c1 {
-=09bootph-pre-ram;
+=09bootph-all;
 =09clock-frequency =3D <100000>;
 };
diff --git a/arch/arm/include/asm/arch-omap3/cpu.h b/arch/arm/include/asm/a=
rch-omap3/cpu.h
index d2fbf919a5b..917e7def378 100644
--- a/arch/arm/include/asm/arch-omap3/cpu.h
+++ b/arch/arm/include/asm/arch-omap3/cpu.h
@@ -12,6 +12,8 @@
 #include <asm/types.h>
 #endif /* !(__KERNEL_STRICT_NAMES || __ASSEMBLY__) */
=20
+#include <asm/arch/hardware.h>
+
 /* Register offsets of common modules */
 /* Control */
 #ifndef __KERNEL_STRICT_NAMES
@@ -67,7 +69,6 @@ struct ctrl_id {
 #define SKUID_CLK_600MHZ=090x0
 #define SKUID_CLK_720MHZ=090x8
=20
-#define GPMC_BASE=09=09(OMAP34XX_GPMC_BASE)
 #define GPMC_CONFIG_CS0=09=090x60
 #define GPMC_CONFIG_CS0_BASE=09(GPMC_BASE + GPMC_CONFIG_CS0)
=20
diff --git a/arch/arm/include/asm/arch-omap3/hardware.h b/arch/arm/include/=
asm/arch-omap3/hardware.h
new file mode 100644
index 00000000000..108830912ad
--- /dev/null
+++ b/arch/arm/include/asm/arch-omap3/hardware.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * hardware.h
+ *
+ * hardware specific header
+ *
+ * Copyright (C) 2013, Texas Instruments, Incorporated - http://www.ti.com=
/
+ */
+
+#ifndef __OMAP_HARDWARE_H
+#define __OMAP_HARDWARE_H
+
+#include <asm/arch/omap.h>
+
+/*
+ * Common hardware definitions
+ */
+
+/* GPMC Base address */
+#define GPMC_BASE=09=09(OMAP34XX_GPMC_BASE)
+
+#endif
diff --git a/arch/arm/include/asm/arch-omap3/mem.h b/arch/arm/include/asm/a=
rch-omap3/mem.h
index 2b6cfde4114..e5b57ca0dbf 100644
--- a/arch/arm/include/asm/arch-omap3/mem.h
+++ b/arch/arm/include/asm/arch-omap3/mem.h
@@ -37,10 +37,10 @@ enum {
  * enable at bits 0:1 and an autorefresh counter value in bits 8:23.  The
  * counter is a result of ( tREFI / tCK ) - 50.
  */
-#define SDP_3430_SDRC_RFR_CTRL_100MHz=090x0002da01
-#define SDP_3430_SDRC_RFR_CTRL_133MHz=090x0003de01 /* 7.8us/7.5ns - 50=3D0=
x3de */
-#define SDP_3430_SDRC_RFR_CTRL_165MHz=090x0004e201 /* 7.8us/6ns - 50=3D0x4=
e2 */
-#define SDP_3430_SDRC_RFR_CTRL_200MHz=090x0005e601 /* 7.8us/5ns - 50=3D0x5=
e6 */
+#define SDP_3430_SDRC_RFR_CTRL_100MHZ=090x0002da01
+#define SDP_3430_SDRC_RFR_CTRL_133MHZ=090x0003de01 /* 7.8us/7.5ns - 50=3D0=
x3de */
+#define SDP_3430_SDRC_RFR_CTRL_165MHZ=090x0004e201 /* 7.8us/6ns - 50=3D0x4=
e2 */
+#define SDP_3430_SDRC_RFR_CTRL_200MHZ=090x0005e601 /* 7.8us/5ns - 50=3D0x5=
e6 */
=20
 #define DLL_OFFSET=09=090
 #define DLL_WRITEDDRCLKX2DIS=091
diff --git a/arch/arm/mach-omap2/omap3/Kconfig b/arch/arm/mach-omap2/omap3/=
Kconfig
index a175e5ce6ed..d6ed6197e58 100644
--- a/arch/arm/mach-omap2/omap3/Kconfig
+++ b/arch/arm/mach-omap2/omap3/Kconfig
@@ -34,6 +34,19 @@ config TARGET_AM3517_EVM
 =09select MMC
 =09imply CMD_DM
=20
+config TARGET_OMAP3_BEAGLE
+=09bool "TI OMAP3 BeagleBoard"
+=09select DM
+=09select DM_GPIO
+=09select DM_I2C
+=09select DM_SERIAL
+=09select OMAP3_GPIO_5
+=09select OMAP3_GPIO_6
+=09select TI_I2C_BOARD_DETECT
+=09select SUPPORT_EXTENSION_SCAN
+=09imply CMD_DM
+=09imply OF_UPSTREAM
+
 config TARGET_CM_T35
 =09bool "CompuLab CM-T3530 and CM-T3730 boards"
 =09select OMAP3_GPIO_2
@@ -144,6 +157,7 @@ config SYS_SOC
 =09default "omap3"
=20
 source "board/logicpd/am3517evm/Kconfig"
+source "board/beagle/beagle/Kconfig"
 source "board/timll/devkit8000/Kconfig"
 source "board/ti/omap3evm/Kconfig"
 source "board/isee/igep00x0/Kconfig"
diff --git a/board/beagle/beagle/Kconfig b/board/beagle/beagle/Kconfig
new file mode 100644
index 00000000000..7e8fb365698
--- /dev/null
+++ b/board/beagle/beagle/Kconfig
@@ -0,0 +1,14 @@
+if TARGET_OMAP3_BEAGLE
+
+config SYS_BOARD
+=09default "beagle"
+
+config SYS_VENDOR
+=09default "beagle"
+
+config SYS_CONFIG_NAME
+=09default "omap3_beagle"
+
+endif
+
+source "board/ti/common/Kconfig"
diff --git a/board/beagle/beagle/MAINTAINERS b/board/beagle/beagle/MAINTAIN=
ERS
new file mode 100644
index 00000000000..a289fd15619
--- /dev/null
+++ b/board/beagle/beagle/MAINTAINERS
@@ -0,0 +1,7 @@
+BEAGLE BOARD
+M:=09Nevets Llih <omapbsf@protonmail.com>
+S:=09Maintained
+F:=09board/beagle/beagle/
+F:=09include/configs/omap3_beagle.h
+F:=09configs/omap3_beagle_defconfig
+F:=09configs/omap3_beagle_xm_defconfig
diff --git a/board/beagle/beagle/Makefile b/board/beagle/beagle/Makefile
new file mode 100644
index 00000000000..fc9288cf186
--- /dev/null
+++ b/board/beagle/beagle/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# (C) Copyright 2000, 2001, 2002
+# Wolfgang Denk, DENX Software Engineering, wd@denx.de.
+
+obj-y=09:=3D beagle.o
+obj-$(CONFIG_LED_STATUS) +=3D led.o
diff --git a/board/beagle/beagle/beagle.c b/board/beagle/beagle/beagle.c
new file mode 100644
index 00000000000..660a50afd0d
--- /dev/null
+++ b/board/beagle/beagle/beagle.c
@@ -0,0 +1,541 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2004-2011
+ * Texas Instruments, <www.ti.com>
+ *
+ * Author :
+ *=09Sunil Kumar <sunilsaini05@gmail.com>
+ *=09Shashi Ranjan <shashiranjanmca05@gmail.com>
+ *
+ * Derived from Beagle Board and 3430 SDP code by
+ *=09Richard Woodruff <r-woodruff2@ti.com>
+ *=09Syed Mohammed Khasim <khasim@ti.com>
+ *
+ */
+#include <bootstage.h>
+#include <dm.h>
+#include <env.h>
+#include <init.h>
+#include <net.h>
+#include <ns16550.h>
+#include <serial.h>
+#if (IS_ENABLED(CONFIG_LED_STATUS))
+#include <status_led.h>
+#endif
+#include <twl4030.h>
+#include <asm/global_data.h>
+#include <linux/mtd/rawnand.h>
+#include <asm/io.h>
+#include <asm/arch/mmc_host_def.h>
+#include <i2c.h>
+#include <asm/arch/mux.h>
+#include <asm/arch/mem.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/gpio.h>
+#include <asm/mach-types.h>
+#include <asm/omap_musb.h>
+#include <linux/errno.h>
+#include <linux/usb/ch9.h>
+#include <linux/usb/gadget.h>
+#include <linux/usb/musb.h>
+#include "beagle.h"
+#include <command.h>
+
+#define TWL4030_I2C_BUS=09=09=090
+
+#define TINCANTOOLS_ZIPPY=09=090x01000100
+#define TINCANTOOLS_ZIPPY2=09=090x02000100
+#define TINCANTOOLS_TRAINER=09=090x04000100
+#define TINCANTOOLS_SHOWDOG=09=090x03000100
+#define KBADC_BEAGLEFPGA=09=090x01000600
+#define LW_BEAGLETOUCH=09=09=090x01000700
+#define BRAINMUX_LCDOG=09=09=090x01000800
+#define BRAINMUX_LCDOGTOUCH=09=090x02000800
+#define BBTOYS_WIFI=09=09=090x01000B00
+#define BBTOYS_VGA=09=09=090x02000B00
+#define BBTOYS_LCD=09=09=090x03000B00
+#define BCT_BRETTL3=09=09=090x01000F00
+#define BCT_BRETTL4=09=09=090x02000F00
+#define LSR_COM6L_ADPT=09=09=090x01001300
+#define BEAGLE_NO_EEPROM=09=090xffffffff
+
+DECLARE_GLOBAL_DATA_PTR;
+
+static struct {
+=09unsigned int device_vendor;
+=09unsigned char revision;
+=09unsigned char content;
+=09char fab_revision[8];
+=09char env_var[16];
+=09char env_setting[64];
+} expansion_config;
+
+/*
+ * Routine: board_init
+ * Description: Early hardware init.
+ */
+int board_init(void)
+{
+=09gpmc_init(); /* in SRAM or SDRAM, finish GPMC */
+=09/* board id for Linux */
+=09gd->bd->bi_arch_number =3D MACH_TYPE_OMAP3_BEAGLE;
+=09/* boot param addr */
+=09gd->bd->bi_boot_params =3D (OMAP34XX_SDRC_CS0 + 0x100);
+
+#if (IS_ENABLED(CONFIG_LED_STATUS)) && (IS_ENABLED(CONFIG_LED_STATUS_BOOT_=
ENABLE))
+=09status_led_set(CONFIG_LED_STATUS_BOOT, CONFIG_LED_STATUS_ON);
+#endif
+
+=09return 0;
+}
+
+#if (IS_ENABLED(CONFIG_SPL_OS_BOOT))
+int spl_start_uboot(void)
+{
+=09/* break into full u-boot on 'c' */
+=09if (serial_tstc() && serial_getc() =3D=3D 'c')
+=09=09return 1;
+
+=09return 0;
+}
+#endif /* CONFIG_SPL_OS_BOOT */
+
+/*
+ * Routine: get_board_revision
+ * Description: Detect if we are running on a Beagle revision Ax/Bx,
+ *=09=09C1/2/3, C4, xM Ax/Bx or xM Cx. This can be done by reading
+ *=09=09the level of GPIO173, GPIO172 and GPIO171. This should
+ *=09=09result in
+ *=09=09GPIO173, GPIO172, GPIO171: 1 1 1 =3D> Ax/Bx
+ *=09=09GPIO173, GPIO172, GPIO171: 1 1 0 =3D> C1/2/3
+ *=09=09GPIO173, GPIO172, GPIO171: 1 0 1 =3D> C4
+ *=09=09GPIO173, GPIO172, GPIO171: 0 1 0 =3D> xM Cx
+ *=09=09GPIO173, GPIO172, GPIO171: 0 0 0 =3D> xM Ax/Bx
+ */
+static int get_board_revision(void)
+{
+=09static int revision =3D -1;
+
+=09if (revision =3D=3D -1) {
+=09=09if (!gpio_request(171, "rev0") &&
+=09=09    !gpio_request(172, "rev1") &&
+=09=09    !gpio_request(173, "rev2")) {
+=09=09=09gpio_direction_input(171);
+=09=09=09gpio_direction_input(172);
+=09=09=09gpio_direction_input(173);
+
+=09=09=09revision =3D gpio_get_value(173) << 2 |
+=09=09=09=09gpio_get_value(172) << 1 |
+=09=09=09=09gpio_get_value(171);
+=09=09} else {
+=09=09=09printf("Error: unable to acquire board revision GPIOs\n");
+=09=09}
+=09}
+
+=09return revision;
+}
+
+#if (IS_ENABLED(CONFIG_SPL_BUILD))
+/*
+ * Routine: get_board_mem_timings
+ * Description: If we use SPL then there is no x-loader nor config header
+ * so we have to setup the DDR timings ourself on both banks.
+ */
+void get_board_mem_timings(struct board_sdrc_timings *timings)
+{
+=09int pop_mfr, pop_id;
+
+=09/*
+=09 * We need to identify what PoP memory is on the board so that
+=09 * we know what timings to use.  If we can't identify it then
+=09 * we know it's an xM.  To map the ID values please see nand_ids.c
+=09 */
+=09identify_nand_chip(&pop_mfr, &pop_id);
+
+=09timings->mr =3D MICRON_V_MR_165;
+=09switch (get_board_revision()) {
+=09case REVISION_C4:
+=09=09if (pop_mfr =3D=3D NAND_MFR_STMICRO && pop_id =3D=3D 0xba) {
+=09=09=09/* 512MB DDR */
+=09=09=09timings->mcfg =3D NUMONYX_V_MCFG_165(512 << 20);
+=09=09=09timings->ctrla =3D NUMONYX_V_ACTIMA_165;
+=09=09=09timings->ctrlb =3D NUMONYX_V_ACTIMB_165;
+=09=09=09timings->rfr_ctrl =3D SDP_3430_SDRC_RFR_CTRL_165MHZ;
+=09=09=09break;
+=09=09} else if (pop_mfr =3D=3D NAND_MFR_MICRON && pop_id =3D=3D 0xba) {
+=09=09=09/* Beagleboard Rev C4, 512MB Nand/256MB DDR*/
+=09=09=09timings->mcfg =3D MICRON_V_MCFG_165(128 << 20);
+=09=09=09timings->ctrla =3D MICRON_V_ACTIMA_165;
+=09=09=09timings->ctrlb =3D MICRON_V_ACTIMB_165;
+=09=09=09timings->rfr_ctrl =3D SDP_3430_SDRC_RFR_CTRL_165MHZ;
+=09=09=09break;
+=09=09} else if (pop_mfr =3D=3D NAND_MFR_MICRON && pop_id =3D=3D 0xbc) {
+=09=09=09/* Beagleboard Rev C5, 256MB DDR */
+=09=09=09timings->mcfg =3D MICRON_V_MCFG_200(256 << 20);
+=09=09=09timings->ctrla =3D MICRON_V_ACTIMA_200;
+=09=09=09timings->ctrlb =3D MICRON_V_ACTIMB_200;
+=09=09=09timings->rfr_ctrl =3D SDP_3430_SDRC_RFR_CTRL_200MHZ;
+=09=09=09break;
+=09=09}
+=09case REVISION_XM_AB:
+=09case REVISION_XM_C:
+=09=09if (pop_mfr =3D=3D 0) {
+=09=09=09/* 256MB DDR */
+=09=09=09timings->mcfg =3D MICRON_V_MCFG_200(256 << 20);
+=09=09=09timings->ctrla =3D MICRON_V_ACTIMA_200;
+=09=09=09timings->ctrlb =3D MICRON_V_ACTIMB_200;
+=09=09=09timings->rfr_ctrl =3D SDP_3430_SDRC_RFR_CTRL_200MHZ;
+=09=09} else {
+=09=09=09/* 512MB DDR */
+=09=09=09timings->mcfg =3D NUMONYX_V_MCFG_165(512 << 20);
+=09=09=09timings->ctrla =3D NUMONYX_V_ACTIMA_165;
+=09=09=09timings->ctrlb =3D NUMONYX_V_ACTIMB_165;
+=09=09=09timings->rfr_ctrl =3D SDP_3430_SDRC_RFR_CTRL_165MHZ;
+=09=09}
+=09=09break;
+=09default:
+=09=09/* Assume 128MB and Micron/165MHz timings to be safe */
+=09=09timings->mcfg =3D MICRON_V_MCFG_165(128 << 20);
+=09=09timings->ctrla =3D MICRON_V_ACTIMA_165;
+=09=09timings->ctrlb =3D MICRON_V_ACTIMB_165;
+=09=09timings->rfr_ctrl =3D SDP_3430_SDRC_RFR_CTRL_165MHZ;
+=09}
+}
+#endif
+
+/*
+ * Routine: get_expansion_id
+ * Description: This function checks for expansion board by checking I2C
+ *=09=09bus 1 for the availability of an AT24C01B serial EEPROM.
+ *=09=09returns the device_vendor field from the EEPROM
+ */
+static unsigned int get_expansion_id(void)
+{
+#if (IS_ENABLED(CONFIG_DM_I2C))
+=09struct udevice *dev;
+=09struct udevice *bus;
+=09int rc;
+
+=09rc =3D uclass_get_device_by_seq(UCLASS_I2C, CONFIG_EEPROM_BUS_ADDRESS,
+=09=09=09=09      &bus);
+=09if (rc)
+=09=09return rc;
+=09rc =3D dm_i2c_probe(bus, CONFIG_EEPROM_CHIP_ADDRESS, 0, &dev);
+=09if (rc)
+=09=09return rc;
+
+=09/* Read configuration data. */
+=09(void)dm_i2c_read(dev, 1, (u8 *)&expansion_config,
+=09=09=09  sizeof(expansion_config));
+
+=09/* Retry reading configuration data with 16-bit addressing */
+=09if (expansion_config.device_vendor =3D=3D 0xFFFFFF00 ||
+=09    expansion_config.device_vendor =3D=3D 0xFFFFFFFF) {
+=09=09printf("EEPROM may be blank, retrying with 16-bit:\n");
+=09=09(void)dm_i2c_read(dev, 2, (u8 *)&expansion_config,
+=09=09=09=09  sizeof(expansion_config));
+=09}
+#else
+=09/* Read configuration data. */
+=09i2c_read(CONFIG_EEPROM_CHIP_ADDRESS, 0, 1, (u8 *)&expansion_config,
+=09=09 sizeof(expansion_config));
+
+=09/* Retry reading configuration data with 16bit addressing. */
+=09if (expansion_config.device_vendor =3D=3D 0xFFFFFF00 ||
+=09    expansion_config.device_vendor =3D=3D 0xFFFFFFFF) {
+=09=09printf("EEPROM is blank or 8bit addressing failed: retrying with 16b=
it:\n");
+=09=09i2c_read(CONFIG_EEPROM_CHIP_ADDRESS, 0, 2, (u8 *)&expansion_config,
+=09=09=09 sizeof(expansion_config));
+=09}
+
+=09i2c_set_bus_num(TWL4030_I2C_BUS);
+#endif
+=09return expansion_config.device_vendor;
+}
+
+#if (IS_ENABLED(CONFIG_VIDEO_OMAP3))
+/*
+ * Configure DSS to display background color on DVID
+ * Configure VENC to display color bar on S-Video
+ */
+static void beagle_display_init(void)
+{
+=09omap3_dss_venc_config(&venc_config_std_tv, VENC_HEIGHT, VENC_WIDTH);
+=09switch (get_board_revision()) {
+=09case REVISION_AXBX:
+=09case REVISION_CX:
+=09case REVISION_C4:
+=09=09omap3_dss_panel_config(&dvid_cfg);
+=09=09break;
+=09case REVISION_XM_AB:
+=09case REVISION_XM_C:
+=09default:
+=09=09omap3_dss_panel_config(&dvid_cfg_xm);
+=09=09break;
+=09}
+}
+
+/*
+ * Enable DVI power
+ */
+static void beagle_dvi_pup(void)
+{
+=09uchar val;
+
+=09switch (get_board_revision()) {
+=09case REVISION_AXBX:
+=09case REVISION_CX:
+=09case REVISION_C4:
+=09=09gpio_request(170, "dvi");
+=09=09gpio_direction_output(170, 0);
+=09=09gpio_set_value(170, 1);
+=09=09break;
+=09case REVISION_XM_AB:
+=09case REVISION_XM_C:
+=09default:
+=09=09#define GPIODATADIR1 (TWL4030_BASEADD_GPIO + 3)
+=09=09#define GPIODATAOUT1 (TWL4030_BASEADD_GPIO + 6)
+
+#if (IS_ENABLED(CONFIG_DM_I2C))
+=09=09struct udevice *dev;
+=09=09struct udevice *bus;
+=09=09int rc;
+
+=09=09rc =3D uclass_get_device_by_seq(UCLASS_I2C, TWL4030_I2C_BUS,
+=09=09=09=09=09      &bus);
+=09=09if (rc)
+=09=09=09return;
+=09=09rc =3D dm_i2c_probe(bus, TWL4030_CHIP_GPIO, 0, &dev);
+=09=09if (rc)
+=09=09=09return;
+
+=09=09(void)dm_i2c_read(dev, GPIODATADIR1, &val, 1);
+=09=09val |=3D 4;
+=09=09(void)dm_i2c_write(dev, GPIODATADIR1, &val, 1);
+
+=09=09(void)dm_i2c_read(dev, GPIODATAOUT1, &val, 1);
+=09=09val |=3D 4;
+=09=09(void)dm_i2c_write(dev, GPIODATAOUT1, &val, 1);
+#else
+=09=09i2c_read(TWL4030_CHIP_GPIO, GPIODATADIR1, 1, &val, 1);
+=09=09val |=3D 4;
+=09=09i2c_write(TWL4030_CHIP_GPIO, GPIODATADIR1, 1, &val, 1);
+
+=09=09i2c_read(TWL4030_CHIP_GPIO, GPIODATAOUT1, 1, &val, 1);
+=09=09val |=3D 4;
+=09=09i2c_write(TWL4030_CHIP_GPIO, GPIODATAOUT1, 1, &val, 1);
+#endif
+=09=09break;
+=09}
+}
+#endif
+
+/*
+ * Routine: misc_init_r
+ * Description: Configure board specific parts
+ */
+int misc_init_r(void)
+{
+=09struct gpio *gpio5_base =3D (struct gpio *)OMAP34XX_GPIO5_BASE;
+=09struct gpio *gpio6_base =3D (struct gpio *)OMAP34XX_GPIO6_BASE;
+=09struct control_prog_io *prog_io_base =3D (struct control_prog_io *)OMAP=
34XX_CTRL_BASE;
+=09bool generate_fake_mac =3D false;
+=09u32 value;
+
+=09/* Enable i2c2 pullup resisters */
+=09value =3D readl(&prog_io_base->io1);
+=09value &=3D ~(PRG_I2C2_PULLUPRESX);
+=09writel(value, &prog_io_base->io1);
+
+=09switch (get_board_revision()) {
+=09case REVISION_AXBX:
+=09=09printf("Beagle Rev Ax/Bx\n");
+=09=09env_set("beaglerev", "AxBx");
+=09=09break;
+=09case REVISION_CX:
+=09=09printf("Beagle Rev C1/C2/C3\n");
+=09=09env_set("beaglerev", "Cx");
+=09=09MUX_BEAGLE_C();
+=09=09break;
+=09case REVISION_C4:
+=09=09printf("Beagle Rev C4\n");
+=09=09env_set("beaglerev", "C4");
+=09=09MUX_BEAGLE_C();
+=09=09/* Set VAUX2 to 1.8V for EHCI PHY */
+=09=09twl4030_pmrecv_vsel_cfg(TWL4030_PM_RECEIVER_VAUX2_DEDICATED,
+=09=09=09=09=09TWL4030_PM_RECEIVER_VAUX2_VSEL_18,
+=09=09=09=09=09TWL4030_PM_RECEIVER_VAUX2_DEV_GRP,
+=09=09=09=09=09TWL4030_PM_RECEIVER_DEV_GRP_P1);
+=09=09break;
+=09case REVISION_XM_AB:
+=09=09printf("Beagle xM Rev A/B\n");
+=09=09env_set("beaglerev", "xMAB");
+=09=09MUX_BEAGLE_XM();
+=09=09/* Set VAUX2 to 1.8V for EHCI PHY */
+=09=09twl4030_pmrecv_vsel_cfg(TWL4030_PM_RECEIVER_VAUX2_DEDICATED,
+=09=09=09=09=09TWL4030_PM_RECEIVER_VAUX2_VSEL_18,
+=09=09=09=09=09TWL4030_PM_RECEIVER_VAUX2_DEV_GRP,
+=09=09=09=09=09TWL4030_PM_RECEIVER_DEV_GRP_P1);
+=09=09generate_fake_mac =3D true;
+=09=09break;
+=09case REVISION_XM_C:
+=09=09printf("Beagle xM Rev C\n");
+=09=09env_set("beaglerev", "xMC");
+=09=09MUX_BEAGLE_XM();
+=09=09/* Set VAUX2 to 1.8V for EHCI PHY */
+=09=09twl4030_pmrecv_vsel_cfg(TWL4030_PM_RECEIVER_VAUX2_DEDICATED,
+=09=09=09=09=09TWL4030_PM_RECEIVER_VAUX2_VSEL_18,
+=09=09=09=09=09TWL4030_PM_RECEIVER_VAUX2_DEV_GRP,
+=09=09=09=09=09TWL4030_PM_RECEIVER_DEV_GRP_P1);
+=09=09generate_fake_mac =3D true;
+=09=09break;
+=09default:
+=09=09printf("Beagle unknown 0x%02x\n", get_board_revision());
+=09=09MUX_BEAGLE_XM();
+=09=09/* Set VAUX2 to 1.8V for EHCI PHY */
+=09=09twl4030_pmrecv_vsel_cfg(TWL4030_PM_RECEIVER_VAUX2_DEDICATED,
+=09=09=09=09=09TWL4030_PM_RECEIVER_VAUX2_VSEL_18,
+=09=09=09=09=09TWL4030_PM_RECEIVER_VAUX2_DEV_GRP,
+=09=09=09=09=09TWL4030_PM_RECEIVER_DEV_GRP_P1);
+=09=09generate_fake_mac =3D true;
+=09}
+
+=09switch (get_expansion_id()) {
+=09case TINCANTOOLS_ZIPPY:
+=09=09printf("Recognized Tincantools Zippy board (rev %d %s)\n",
+=09=09       expansion_config.revision,
+=09=09       expansion_config.fab_revision);
+=09=09MUX_TINCANTOOLS_ZIPPY();
+=09=09env_set("buddy", "zippy");
+=09=09break;
+=09case TINCANTOOLS_ZIPPY2:
+=09=09printf("Recognized Tincantools Zippy2 board (rev %d %s)\n",
+=09=09       expansion_config.revision,
+=09=09       expansion_config.fab_revision);
+=09=09MUX_TINCANTOOLS_ZIPPY();
+=09=09env_set("buddy", "zippy2");
+=09=09break;
+=09case TINCANTOOLS_TRAINER:
+=09=09printf("Recognized Tincantools Trainer board (rev %d %s)\n",
+=09=09       expansion_config.revision,
+=09=09       expansion_config.fab_revision);
+=09=09MUX_TINCANTOOLS_ZIPPY();
+=09=09MUX_TINCANTOOLS_TRAINER();
+=09=09env_set("buddy", "trainer");
+=09=09break;
+=09case TINCANTOOLS_SHOWDOG:
+=09=09printf("Recognized Tincantools Showdow board (rev %d %s)\n",
+=09=09       expansion_config.revision,
+=09=09       expansion_config.fab_revision);
+=09=09/* Place holder for DSS2 definition for showdog lcd */
+=09=09env_set("defaultdisplay", "showdoglcd");
+=09=09env_set("buddy", "showdog");
+=09=09break;
+=09case KBADC_BEAGLEFPGA:
+=09=09printf("Recognized KBADC Beagle FPGA board\n");
+=09=09MUX_KBADC_BEAGLEFPGA();
+=09=09env_set("buddy", "beaglefpga");
+=09=09break;
+=09case LW_BEAGLETOUCH:
+=09=09printf("Recognized Liquidware BeagleTouch board\n");
+=09=09env_set("buddy", "beagletouch");
+=09=09break;
+=09case BRAINMUX_LCDOG:
+=09=09printf("Recognized Brainmux LCDog board\n");
+=09=09env_set("buddy", "lcdog");
+=09=09break;
+=09case BRAINMUX_LCDOGTOUCH:
+=09=09printf("Recognized Brainmux LCDog Touch board\n");
+=09=09env_set("buddy", "lcdogtouch");
+=09=09break;
+=09case BBTOYS_WIFI:
+=09=09printf("Recognized BeagleBoardToys WiFi board\n");
+=09=09MUX_BBTOYS_WIFI()
+=09=09env_set("buddy", "bbtoys-wifi");
+=09=09break;
+=09case BBTOYS_VGA:
+=09=09printf("Recognized BeagleBoardToys VGA board\n");
+=09=09break;
+=09case BBTOYS_LCD:
+=09=09printf("Recognized BeagleBoardToys LCD board\n");
+=09=09break;
+=09case BCT_BRETTL3:
+=09=09printf("Recognized bct electronic GmbH brettl3 board\n");
+=09=09break;
+=09case BCT_BRETTL4:
+=09=09printf("Recognized bct electronic GmbH brettl4 board\n");
+=09=09break;
+=09case LSR_COM6L_ADPT:
+=09=09printf("Recognized LSR COM6L Adapter Board\n");
+=09=09MUX_BBTOYS_WIFI()
+=09=09env_set("buddy", "lsr-com6l-adpt");
+=09=09break;
+=09case BEAGLE_NO_EEPROM:
+=09=09printf("No EEPROM on expansion board\n");
+=09=09env_set("buddy", "none");
+=09=09break;
+=09default:
+=09=09printf("Unrecognized expansion board: %x\n",
+=09=09       expansion_config.device_vendor);
+=09=09env_set("buddy", "unknown");
+=09}
+
+=09if (expansion_config.content =3D=3D 1)
+=09=09env_set(expansion_config.env_var, expansion_config.env_setting);
+
+=09twl4030_power_init();
+=09twl4030_power_mmc_init(0);
+
+=09switch (get_board_revision()) {
+=09case REVISION_XM_AB:
+=09=09twl4030_led_init(TWL4030_LED_LEDEN_LEDBON);
+=09=09break;
+=09default:
+=09=09twl4030_led_init(TWL4030_LED_LEDEN_LEDAON | TWL4030_LED_LEDEN_LEDBON=
);
+=09=09break;
+=09}
+
+=09/* Set GPIO states before they are made outputs */
+=09writel(GPIO23 | GPIO10 | GPIO8 | GPIO2 | GPIO1,
+=09       &gpio6_base->setdataout);
+=09writel(GPIO31 | GPIO30 | GPIO29 | GPIO28 | GPIO22 | GPIO21 |
+=09       GPIO15 | GPIO14 | GPIO13 | GPIO12, &gpio5_base->setdataout);
+
+=09/* Configure GPIOs to output */
+=09writel(~(GPIO23 | GPIO10 | GPIO8 | GPIO2 | GPIO1), &gpio6_base->oe);
+=09writel(~(GPIO31 | GPIO30 | GPIO29 | GPIO28 | GPIO22 | GPIO21 |
+=09=09GPIO15 | GPIO14 | GPIO13 | GPIO12), &gpio5_base->oe);
+
+=09omap_die_id_display();
+
+#if (IS_ENABLED(CONFIG_VIDEO_OMAP3))
+=09beagle_dvi_pup();
+=09beagle_display_init();
+=09omap3_dss_enable();
+#endif
+
+=09if (generate_fake_mac)
+=09=09omap_die_id_usbethaddr();
+
+#if defined(CONFIG_MTDIDS_DEFAULT) && defined(CONFIG_MTDPARTS_DEFAULT)
+=09if (strlen(CONFIG_MTDIDS_DEFAULT))
+=09=09env_set("mtdids", CONFIG_MTDIDS_DEFAULT);
+
+=09if (strlen(CONFIG_MTDPARTS_DEFAULT))
+=09=09env_set("mtdparts", CONFIG_MTDPARTS_DEFAULT);
+#endif
+
+=09return 0;
+}
+
+/*
+ * Routine: set_muxconf_regs
+ * Description: Setting up the configuration Mux registers specific to the
+ *=09=09hardware. Many pins need to be moved from protect to primary
+ *=09=09mode.
+ */
+void set_muxconf_regs(void)
+{
+=09/* Convert to be like am335x/mux.c file. */
+=09MUX_BEAGLE();
+}
diff --git a/board/beagle/beagle/beagle.h b/board/beagle/beagle/beagle.h
new file mode 100644
index 00000000000..ce78ea661b9
--- /dev/null
+++ b/board/beagle/beagle/beagle.h
@@ -0,0 +1,545 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2008
+ * Dirk Behme <dirk.behme@gmail.com>
+ */
+#ifndef _BEAGLE_H_
+#define _BEAGLE_H_
+
+#include <asm/arch/dss.h>
+
+const omap3_sysinfo sysinfo =3D {
+=09DDR_STACKED,
+=09"OMAP3 Beagle board",
+#if defined(CONFIG_ENV_IS_IN_ONENAND)
+=09"OneNAND",
+#else
+=09"NAND",
+#endif
+};
+
+/* BeagleBoard revisions */
+#define REVISION_AXBX=090x7
+#define REVISION_CX=090x6
+#define REVISION_C4=090x5
+#define REVISION_XM_AB=090x0
+#define REVISION_XM_C=090x2
+
+/*
+ * IEN  - Input Enable
+ * IDIS - Input Disable
+ * PTD  - Pull type Down
+ * PTU  - Pull type Up
+ * DIS  - Pull type selection is inactive
+ * EN   - Pull type selection is active
+ * M0   - Mode 0
+ * The commented string gives the final mux configuration for that pin
+ */
+#define MUX_BEAGLE() \
+ /*SDRC*/\
+=09MUX_VAL(CP(SDRC_D0),=09=09(IEN  | PTD | DIS | M0)) /*SDRC_D0*/\
+=09MUX_VAL(CP(SDRC_D1),=09=09(IEN  | PTD | DIS | M0)) /*SDRC_D1*/\
+=09MUX_VAL(CP(SDRC_D2),=09=09(IEN  | PTD | DIS | M0)) /*SDRC_D2*/\
+=09MUX_VAL(CP(SDRC_D3),=09=09(IEN  | PTD | DIS | M0)) /*SDRC_D3*/\
+=09MUX_VAL(CP(SDRC_D4),=09=09(IEN  | PTD | DIS | M0)) /*SDRC_D4*/\
+=09MUX_VAL(CP(SDRC_D5),=09=09(IEN  | PTD | DIS | M0)) /*SDRC_D5*/\
+=09MUX_VAL(CP(SDRC_D6),=09=09(IEN  | PTD | DIS | M0)) /*SDRC_D6*/\
+=09MUX_VAL(CP(SDRC_D7),=09=09(IEN  | PTD | DIS | M0)) /*SDRC_D7*/\
+=09MUX_VAL(CP(SDRC_D8),=09=09(IEN  | PTD | DIS | M0)) /*SDRC_D8*/\
+=09MUX_VAL(CP(SDRC_D9),=09=09(IEN  | PTD | DIS | M0)) /*SDRC_D9*/\
+=09MUX_VAL(CP(SDRC_D10),=09=09(IEN  | PTD | DIS | M0)) /*SDRC_D10*/\
+=09MUX_VAL(CP(SDRC_D11),=09=09(IEN  | PTD | DIS | M0)) /*SDRC_D11*/\
+=09MUX_VAL(CP(SDRC_D12),=09=09(IEN  | PTD | DIS | M0)) /*SDRC_D12*/\
+=09MUX_VAL(CP(SDRC_D13),=09=09(IEN  | PTD | DIS | M0)) /*SDRC_D13*/\
+=09MUX_VAL(CP(SDRC_D14),=09=09(IEN  | PTD | DIS | M0)) /*SDRC_D14*/\
+=09MUX_VAL(CP(SDRC_D15),=09=09(IEN  | PTD | DIS | M0)) /*SDRC_D15*/\
+=09MUX_VAL(CP(SDRC_D16),=09=09(IEN  | PTD | DIS | M0)) /*SDRC_D16*/\
+=09MUX_VAL(CP(SDRC_D17),=09=09(IEN  | PTD | DIS | M0)) /*SDRC_D17*/\
+=09MUX_VAL(CP(SDRC_D18),=09=09(IEN  | PTD | DIS | M0)) /*SDRC_D18*/\
+=09MUX_VAL(CP(SDRC_D19),=09=09(IEN  | PTD | DIS | M0)) /*SDRC_D19*/\
+=09MUX_VAL(CP(SDRC_D20),=09=09(IEN  | PTD | DIS | M0)) /*SDRC_D20*/\
+=09MUX_VAL(CP(SDRC_D21),=09=09(IEN  | PTD | DIS | M0)) /*SDRC_D21*/\
+=09MUX_VAL(CP(SDRC_D22),=09=09(IEN  | PTD | DIS | M0)) /*SDRC_D22*/\
+=09MUX_VAL(CP(SDRC_D23),=09=09(IEN  | PTD | DIS | M0)) /*SDRC_D23*/\
+=09MUX_VAL(CP(SDRC_D24),=09=09(IEN  | PTD | DIS | M0)) /*SDRC_D24*/\
+=09MUX_VAL(CP(SDRC_D25),=09=09(IEN  | PTD | DIS | M0)) /*SDRC_D25*/\
+=09MUX_VAL(CP(SDRC_D26),=09=09(IEN  | PTD | DIS | M0)) /*SDRC_D26*/\
+=09MUX_VAL(CP(SDRC_D27),=09=09(IEN  | PTD | DIS | M0)) /*SDRC_D27*/\
+=09MUX_VAL(CP(SDRC_D28),=09=09(IEN  | PTD | DIS | M0)) /*SDRC_D28*/\
+=09MUX_VAL(CP(SDRC_D29),=09=09(IEN  | PTD | DIS | M0)) /*SDRC_D29*/\
+=09MUX_VAL(CP(SDRC_D30),=09=09(IEN  | PTD | DIS | M0)) /*SDRC_D30*/\
+=09MUX_VAL(CP(SDRC_D31),=09=09(IEN  | PTD | DIS | M0)) /*SDRC_D31*/\
+=09MUX_VAL(CP(SDRC_CLK),=09=09(IEN  | PTD | DIS | M0)) /*SDRC_CLK*/\
+=09MUX_VAL(CP(SDRC_DQS0),=09=09(IEN  | PTD | DIS | M0)) /*SDRC_DQS0*/\
+=09MUX_VAL(CP(SDRC_DQS1),=09=09(IEN  | PTD | DIS | M0)) /*SDRC_DQS1*/\
+=09MUX_VAL(CP(SDRC_DQS2),=09=09(IEN  | PTD | DIS | M0)) /*SDRC_DQS2*/\
+=09MUX_VAL(CP(SDRC_DQS3),=09=09(IEN  | PTD | DIS | M0)) /*SDRC_DQS3*/\
+ /*GPMC*/\
+=09MUX_VAL(CP(GPMC_A1),=09=09(IDIS | PTD | DIS | M0)) /*GPMC_A1*/\
+=09MUX_VAL(CP(GPMC_A2),=09=09(IDIS | PTD | DIS | M0)) /*GPMC_A2*/\
+=09MUX_VAL(CP(GPMC_A3),=09=09(IDIS | PTD | DIS | M0)) /*GPMC_A3*/\
+=09MUX_VAL(CP(GPMC_A4),=09=09(IDIS | PTD | DIS | M0)) /*GPMC_A4*/\
+=09MUX_VAL(CP(GPMC_A5),=09=09(IDIS | PTD | DIS | M0)) /*GPMC_A5*/\
+=09MUX_VAL(CP(GPMC_A6),=09=09(IDIS | PTD | DIS | M0)) /*GPMC_A6*/\
+=09MUX_VAL(CP(GPMC_A7),=09=09(IDIS | PTD | DIS | M0)) /*GPMC_A7*/\
+=09MUX_VAL(CP(GPMC_A8),=09=09(IDIS | PTD | DIS | M0)) /*GPMC_A8*/\
+=09MUX_VAL(CP(GPMC_A9),=09=09(IDIS | PTD | DIS | M0)) /*GPMC_A9*/\
+=09MUX_VAL(CP(GPMC_A10),=09=09(IDIS | PTD | DIS | M0)) /*GPMC_A10*/\
+=09MUX_VAL(CP(GPMC_D0),=09=09(IEN  | PTD | DIS | M0)) /*GPMC_D0*/\
+=09MUX_VAL(CP(GPMC_D1),=09=09(IEN  | PTD | DIS | M0)) /*GPMC_D1*/\
+=09MUX_VAL(CP(GPMC_D2),=09=09(IEN  | PTD | DIS | M0)) /*GPMC_D2*/\
+=09MUX_VAL(CP(GPMC_D3),=09=09(IEN  | PTD | DIS | M0)) /*GPMC_D3*/\
+=09MUX_VAL(CP(GPMC_D4),=09=09(IEN  | PTD | DIS | M0)) /*GPMC_D4*/\
+=09MUX_VAL(CP(GPMC_D5),=09=09(IEN  | PTD | DIS | M0)) /*GPMC_D5*/\
+=09MUX_VAL(CP(GPMC_D6),=09=09(IEN  | PTD | DIS | M0)) /*GPMC_D6*/\
+=09MUX_VAL(CP(GPMC_D7),=09=09(IEN  | PTD | DIS | M0)) /*GPMC_D7*/\
+=09MUX_VAL(CP(GPMC_D8),=09=09(IEN  | PTD | DIS | M0)) /*GPMC_D8*/\
+=09MUX_VAL(CP(GPMC_D9),=09=09(IEN  | PTD | DIS | M0)) /*GPMC_D9*/\
+=09MUX_VAL(CP(GPMC_D10),=09=09(IEN  | PTD | DIS | M0)) /*GPMC_D10*/\
+=09MUX_VAL(CP(GPMC_D11),=09=09(IEN  | PTD | DIS | M0)) /*GPMC_D11*/\
+=09MUX_VAL(CP(GPMC_D12),=09=09(IEN  | PTD | DIS | M0)) /*GPMC_D12*/\
+=09MUX_VAL(CP(GPMC_D13),=09=09(IEN  | PTD | DIS | M0)) /*GPMC_D13*/\
+=09MUX_VAL(CP(GPMC_D14),=09=09(IEN  | PTD | DIS | M0)) /*GPMC_D14*/\
+=09MUX_VAL(CP(GPMC_D15),=09=09(IEN  | PTD | DIS | M0)) /*GPMC_D15*/\
+=09MUX_VAL(CP(GPMC_NCS0),=09=09(IDIS | PTU | EN  | M0)) /*GPMC_nCS0*/\
+=09MUX_VAL(CP(GPMC_NCS1),=09=09(IDIS | PTU | EN  | M0)) /*GPMC_nCS1*/\
+=09MUX_VAL(CP(GPMC_NCS2),=09=09(IDIS | PTU | EN  | M0)) /*GPMC_nCS2*/\
+=09MUX_VAL(CP(GPMC_NCS3),=09=09(IDIS | PTU | EN  | M0)) /*GPMC_nCS3*/\
+=09MUX_VAL(CP(GPMC_NCS4),=09=09(IDIS | PTU | EN  | M0)) /*GPMC_nCS4*/\
+=09MUX_VAL(CP(GPMC_NCS5),=09=09(IDIS | PTD | DIS | M0)) /*GPMC_nCS5*/\
+=09MUX_VAL(CP(GPMC_NCS6),=09=09(IEN  | PTD | DIS | M1)) /*SYS_nDMA_REQ2*/\
+=09MUX_VAL(CP(GPMC_NCS7),=09=09(IEN  | PTU | EN  | M1)) /*SYS_nDMA_REQ3*/\
+=09MUX_VAL(CP(GPMC_NBE1),=09=09(IEN  | PTD | DIS | M0)) /*GPMC_nBE1*/\
+=09MUX_VAL(CP(GPMC_WAIT2),=09=09(IEN  | PTU | EN  | M0)) /*GPMC_WAIT2*/\
+=09MUX_VAL(CP(GPMC_WAIT3),=09=09(IEN  | PTU | EN  | M0)) /*GPMC_WAIT3*/\
+=09MUX_VAL(CP(GPMC_CLK),=09=09(IDIS | PTD | DIS | M0)) /*GPMC_CLK*/\
+=09MUX_VAL(CP(GPMC_NADV_ALE),=09(IDIS | PTD | DIS | M0)) /*GPMC_nADV_ALE*/=
\
+=09MUX_VAL(CP(GPMC_NOE),=09=09(IDIS | PTD | DIS | M0)) /*GPMC_nOE*/\
+=09MUX_VAL(CP(GPMC_NWE),=09=09(IDIS | PTD | DIS | M0)) /*GPMC_nWE*/\
+=09MUX_VAL(CP(GPMC_NBE0_CLE),=09(IDIS | PTD | DIS | M0)) /*GPMC_nBE0_CLE*/=
\
+=09MUX_VAL(CP(GPMC_NWP),=09=09(IEN  | PTD | DIS | M0)) /*GPMC_nWP*/\
+=09MUX_VAL(CP(GPMC_WAIT0),=09=09(IEN  | PTU | EN  | M0)) /*GPMC_WAIT0*/\
+=09MUX_VAL(CP(GPMC_WAIT1),=09=09(IEN  | PTU | EN  | M0)) /*GPMC_WAIT1*/\
+ /*DSS*/\
+=09MUX_VAL(CP(DSS_PCLK),=09=09(IDIS | PTD | DIS | M0)) /*DSS_PCLK*/\
+=09MUX_VAL(CP(DSS_HSYNC),=09=09(IDIS | PTD | DIS | M0)) /*DSS_HSYNC*/\
+=09MUX_VAL(CP(DSS_VSYNC),=09=09(IDIS | PTD | DIS | M0)) /*DSS_VSYNC*/\
+=09MUX_VAL(CP(DSS_ACBIAS),=09=09(IDIS | PTD | DIS | M0)) /*DSS_ACBIAS*/\
+=09MUX_VAL(CP(DSS_DATA0),=09=09(IDIS | PTD | DIS | M0)) /*DSS_DATA0*/\
+=09MUX_VAL(CP(DSS_DATA1),=09=09(IDIS | PTD | DIS | M0)) /*DSS_DATA1*/\
+=09MUX_VAL(CP(DSS_DATA2),=09=09(IDIS | PTD | DIS | M0)) /*DSS_DATA2*/\
+=09MUX_VAL(CP(DSS_DATA3),=09=09(IDIS | PTD | DIS | M0)) /*DSS_DATA3*/\
+=09MUX_VAL(CP(DSS_DATA4),=09=09(IDIS | PTD | DIS | M0)) /*DSS_DATA4*/\
+=09MUX_VAL(CP(DSS_DATA5),=09=09(IDIS | PTD | DIS | M0)) /*DSS_DATA5*/\
+=09MUX_VAL(CP(DSS_DATA6),=09=09(IDIS | PTD | DIS | M0)) /*DSS_DATA6*/\
+=09MUX_VAL(CP(DSS_DATA7),=09=09(IDIS | PTD | DIS | M0)) /*DSS_DATA7*/\
+=09MUX_VAL(CP(DSS_DATA8),=09=09(IDIS | PTD | DIS | M0)) /*DSS_DATA8*/\
+=09MUX_VAL(CP(DSS_DATA9),=09=09(IDIS | PTD | DIS | M0)) /*DSS_DATA9*/\
+=09MUX_VAL(CP(DSS_DATA10),=09=09(IDIS | PTD | DIS | M0)) /*DSS_DATA10*/\
+=09MUX_VAL(CP(DSS_DATA11),=09=09(IDIS | PTD | DIS | M0)) /*DSS_DATA11*/\
+=09MUX_VAL(CP(DSS_DATA12),=09=09(IDIS | PTD | DIS | M0)) /*DSS_DATA12*/\
+=09MUX_VAL(CP(DSS_DATA13),=09=09(IDIS | PTD | DIS | M0)) /*DSS_DATA13*/\
+=09MUX_VAL(CP(DSS_DATA14),=09=09(IDIS | PTD | DIS | M0)) /*DSS_DATA14*/\
+=09MUX_VAL(CP(DSS_DATA15),=09=09(IDIS | PTD | DIS | M0)) /*DSS_DATA15*/\
+=09MUX_VAL(CP(DSS_DATA16),=09=09(IDIS | PTD | DIS | M0)) /*DSS_DATA16*/\
+=09MUX_VAL(CP(DSS_DATA17),=09=09(IDIS | PTD | DIS | M0)) /*DSS_DATA17*/\
+=09MUX_VAL(CP(DSS_DATA18),=09=09(IDIS | PTD | DIS | M0)) /*DSS_DATA18*/\
+=09MUX_VAL(CP(DSS_DATA19),=09=09(IDIS | PTD | DIS | M0)) /*DSS_DATA19*/\
+=09MUX_VAL(CP(DSS_DATA20),=09=09(IDIS | PTD | DIS | M0)) /*DSS_DATA20*/\
+=09MUX_VAL(CP(DSS_DATA21),=09=09(IDIS | PTD | DIS | M0)) /*DSS_DATA21*/\
+=09MUX_VAL(CP(DSS_DATA22),=09=09(IDIS | PTD | DIS | M0)) /*DSS_DATA22*/\
+=09MUX_VAL(CP(DSS_DATA23),=09=09(IDIS | PTD | DIS | M0)) /*DSS_DATA23*/\
+ /*CAMERA*/\
+=09MUX_VAL(CP(CAM_HS),=09=09(IEN  | PTU | EN  | M0)) /*CAM_HS */\
+=09MUX_VAL(CP(CAM_VS),=09=09(IEN  | PTU | EN  | M0)) /*CAM_VS */\
+=09MUX_VAL(CP(CAM_XCLKA),=09=09(IDIS | PTD | DIS | M0)) /*CAM_XCLKA*/\
+=09MUX_VAL(CP(CAM_PCLK),=09=09(IEN  | PTU | EN  | M0)) /*CAM_PCLK*/\
+=09MUX_VAL(CP(CAM_FLD),=09=09(IDIS | PTD | DIS | M4)) /*GPIO_98*/\
+=09MUX_VAL(CP(CAM_D0),=09=09(IEN  | PTD | DIS | M0)) /*CAM_D0*/\
+=09MUX_VAL(CP(CAM_D1),=09=09(IEN  | PTD | DIS | M0)) /*CAM_D1*/\
+=09MUX_VAL(CP(CAM_D2),=09=09(IEN  | PTD | DIS | M0)) /*CAM_D2*/\
+=09MUX_VAL(CP(CAM_D3),=09=09(IEN  | PTD | DIS | M0)) /*CAM_D3*/\
+=09MUX_VAL(CP(CAM_D4),=09=09(IEN  | PTD | DIS | M0)) /*CAM_D4*/\
+=09MUX_VAL(CP(CAM_D5),=09=09(IEN  | PTD | DIS | M0)) /*CAM_D5*/\
+=09MUX_VAL(CP(CAM_D6),=09=09(IEN  | PTD | DIS | M0)) /*CAM_D6*/\
+=09MUX_VAL(CP(CAM_D7),=09=09(IEN  | PTD | DIS | M0)) /*CAM_D7*/\
+=09MUX_VAL(CP(CAM_D8),=09=09(IEN  | PTD | DIS | M0)) /*CAM_D8*/\
+=09MUX_VAL(CP(CAM_D9),=09=09(IEN  | PTD | DIS | M0)) /*CAM_D9*/\
+=09MUX_VAL(CP(CAM_D10),=09=09(IEN  | PTD | DIS | M0)) /*CAM_D10*/\
+=09MUX_VAL(CP(CAM_D11),=09=09(IEN  | PTD | DIS | M0)) /*CAM_D11*/\
+=09MUX_VAL(CP(CAM_XCLKB),=09=09(IDIS | PTD | DIS | M0)) /*CAM_XCLKB*/\
+=09MUX_VAL(CP(CAM_WEN),=09=09(IEN  | PTD | DIS | M4)) /*GPIO_167*/\
+=09MUX_VAL(CP(CAM_STROBE),=09=09(IDIS | PTD | DIS | M0)) /*CAM_STROBE*/\
+=09MUX_VAL(CP(CSI2_DX0),=09=09(IEN  | PTD | DIS | M0)) /*CSI2_DX0*/\
+=09MUX_VAL(CP(CSI2_DY0),=09=09(IEN  | PTD | DIS | M0)) /*CSI2_DY0*/\
+=09MUX_VAL(CP(CSI2_DX1),=09=09(IEN  | PTD | DIS | M0)) /*CSI2_DX1*/\
+=09MUX_VAL(CP(CSI2_DY1),=09=09(IEN  | PTD | DIS | M0)) /*CSI2_DY1*/\
+ /*Audio Interface */\
+=09MUX_VAL(CP(MCBSP2_FSX),=09=09(IEN  | PTD | DIS | M0)) /*McBSP2_FSX*/\
+=09MUX_VAL(CP(MCBSP2_CLKX),=09(IEN  | PTD | DIS | M0)) /*McBSP2_CLKX*/\
+=09MUX_VAL(CP(MCBSP2_DR),=09=09(IEN  | PTD | DIS | M0)) /*McBSP2_DR*/\
+=09MUX_VAL(CP(MCBSP2_DX),=09=09(IDIS | PTD | DIS | M0)) /*McBSP2_DX*/\
+ /*Expansion card */\
+=09MUX_VAL(CP(MMC1_CLK),=09=09(IDIS | PTU | EN  | M0)) /*MMC1_CLK*/\
+=09MUX_VAL(CP(MMC1_CMD),=09=09(IEN  | PTU | EN  | M0)) /*MMC1_CMD*/\
+=09MUX_VAL(CP(MMC1_DAT0),=09=09(IEN  | PTU | EN  | M0)) /*MMC1_DAT0*/\
+=09MUX_VAL(CP(MMC1_DAT1),=09=09(IEN  | PTU | EN  | M0)) /*MMC1_DAT1*/\
+=09MUX_VAL(CP(MMC1_DAT2),=09=09(IEN  | PTU | EN  | M0)) /*MMC1_DAT2*/\
+=09MUX_VAL(CP(MMC1_DAT3),=09=09(IEN  | PTU | EN  | M0)) /*MMC1_DAT3*/\
+=09MUX_VAL(CP(MMC1_DAT4),=09=09(IEN  | PTU | EN  | M0)) /*MMC1_DAT4*/\
+=09MUX_VAL(CP(MMC1_DAT5),=09=09(IEN  | PTU | EN  | M0)) /*MMC1_DAT5*/\
+=09MUX_VAL(CP(MMC1_DAT6),=09=09(IEN  | PTU | EN  | M0)) /*MMC1_DAT6*/\
+=09MUX_VAL(CP(MMC1_DAT7),=09=09(IEN  | PTU | EN  | M0)) /*MMC1_DAT7*/\
+ /*Wireless LAN */\
+=09MUX_VAL(CP(MMC2_CLK),=09=09(IEN  | PTU | EN  | M4)) /*GPIO_130*/\
+=09MUX_VAL(CP(MMC2_CMD),=09=09(IEN  | PTU | EN  | M4)) /*GPIO_131*/\
+=09MUX_VAL(CP(MMC2_DAT0),=09=09(IEN  | PTU | EN  | M4)) /*GPIO_132*/\
+=09MUX_VAL(CP(MMC2_DAT1),=09=09(IEN  | PTU | EN  | M4)) /*GPIO_133*/\
+=09MUX_VAL(CP(MMC2_DAT2),=09=09(IEN  | PTU | EN  | M4)) /*GPIO_134*/\
+=09MUX_VAL(CP(MMC2_DAT3),=09=09(IEN  | PTU | EN  | M4)) /*GPIO_135*/\
+=09MUX_VAL(CP(MMC2_DAT4),=09=09(IEN  | PTU | EN  | M4)) /*GPIO_136*/\
+=09MUX_VAL(CP(MMC2_DAT5),=09=09(IEN  | PTU | EN  | M4)) /*GPIO_137*/\
+=09MUX_VAL(CP(MMC2_DAT6),=09=09(IEN  | PTU | EN  | M4)) /*GPIO_138*/\
+=09MUX_VAL(CP(MMC2_DAT7),=09=09(IEN  | PTU | EN  | M4)) /*GPIO_139*/\
+ /*Bluetooth*/\
+=09MUX_VAL(CP(MCBSP3_DX),=09=09(IEN  | PTD | DIS | M1)) /*UART2_CTS*/\
+=09MUX_VAL(CP(MCBSP3_DR),=09=09(IDIS | PTD | DIS | M1)) /*UART2_RTS*/\
+=09MUX_VAL(CP(MCBSP3_CLKX),=09(IDIS | PTD | DIS | M1)) /*UART2_TX*/\
+=09MUX_VAL(CP(MCBSP3_FSX),=09=09(IEN  | PTD | DIS | M1)) /*UART2_RX*/\
+=09MUX_VAL(CP(UART2_CTS),=09=09(IEN  | PTD | DIS | M4)) /*GPIO_144*/\
+=09MUX_VAL(CP(UART2_RTS),=09=09(IEN  | PTD | DIS | M4)) /*GPIO_145*/\
+=09MUX_VAL(CP(UART2_TX),=09=09(IEN  | PTD | DIS | M4)) /*GPIO_146*/\
+=09MUX_VAL(CP(UART2_RX),=09=09(IEN  | PTD | DIS | M4)) /*GPIO_147*/\
+ /*Modem Interface */\
+=09MUX_VAL(CP(UART1_TX),=09=09(IDIS | PTD | DIS | M0)) /*UART1_TX*/\
+=09MUX_VAL(CP(UART1_RTS),=09=09(IDIS | PTD | DIS | M4)) /*GPIO_149*/ \
+=09MUX_VAL(CP(UART1_CTS),=09=09(IDIS | PTD | DIS | M4)) /*GPIO_150*/ \
+=09MUX_VAL(CP(UART1_RX),=09=09(IEN  | PTD | DIS | M0)) /*UART1_RX*/\
+=09MUX_VAL(CP(MCBSP4_CLKX),=09(IEN  | PTD | DIS | M1)) /*SSI1_DAT_RX*/\
+=09MUX_VAL(CP(MCBSP4_DR),=09=09(IEN  | PTD | DIS | M1)) /*SSI1_FLAG_RX*/\
+=09MUX_VAL(CP(MCBSP4_DX),=09=09(IEN  | PTD | DIS | M1)) /*SSI1_RDY_RX*/\
+=09MUX_VAL(CP(MCBSP4_FSX),=09=09(IEN  | PTD | DIS | M1)) /*SSI1_WAKE*/\
+=09MUX_VAL(CP(MCBSP1_CLKR),=09(IDIS | PTD | DIS | M4)) /*GPIO_156*/\
+=09MUX_VAL(CP(MCBSP1_FSR),=09=09(IDIS | PTU | EN  | M4)) /*GPIO_157*/\
+=09MUX_VAL(CP(MCBSP1_DX),=09=09(IDIS | PTD | DIS | M4)) /*GPIO_158*/\
+=09MUX_VAL(CP(MCBSP1_DR),=09=09(IDIS | PTD | DIS | M4)) /*GPIO_159*/\
+=09MUX_VAL(CP(MCBSP_CLKS),=09=09(IEN  | PTU | DIS | M0)) /*McBSP_CLKS*/\
+=09MUX_VAL(CP(MCBSP1_FSX),=09=09(IDIS | PTD | DIS | M4)) /*GPIO_161*/\
+=09MUX_VAL(CP(MCBSP1_CLKX),=09(IDIS | PTD | DIS | M4)) /*GPIO_162*/\
+ /*Serial Interface*/\
+=09MUX_VAL(CP(UART3_CTS_RCTX),=09(IEN  | PTD | EN  | M0)) /*UART3_CTS_RCTX=
*/\
+=09MUX_VAL(CP(UART3_RTS_SD),=09(IDIS | PTD | DIS | M0)) /*UART3_RTS_SD */\
+=09MUX_VAL(CP(UART3_RX_IRRX),=09(IEN  | PTD | DIS | M0)) /*UART3_RX_IRRX*/=
\
+=09MUX_VAL(CP(UART3_TX_IRTX),=09(IDIS | PTD | DIS | M0)) /*UART3_TX_IRTX*/=
\
+=09MUX_VAL(CP(HSUSB0_CLK),=09=09(IEN  | PTD | DIS | M0)) /*HSUSB0_CLK*/\
+=09MUX_VAL(CP(HSUSB0_STP),=09=09(IDIS | PTU | EN  | M0)) /*HSUSB0_STP*/\
+=09MUX_VAL(CP(HSUSB0_DIR),=09=09(IEN  | PTD | DIS | M0)) /*HSUSB0_DIR*/\
+=09MUX_VAL(CP(HSUSB0_NXT),=09=09(IEN  | PTD | DIS | M0)) /*HSUSB0_NXT*/\
+=09MUX_VAL(CP(HSUSB0_DATA0),=09(IEN  | PTD | DIS | M0)) /*HSUSB0_DATA0*/\
+=09MUX_VAL(CP(HSUSB0_DATA1),=09(IEN  | PTD | DIS | M0)) /*HSUSB0_DATA1*/\
+=09MUX_VAL(CP(HSUSB0_DATA2),=09(IEN  | PTD | DIS | M0)) /*HSUSB0_DATA2*/\
+=09MUX_VAL(CP(HSUSB0_DATA3),=09(IEN  | PTD | DIS | M0)) /*HSUSB0_DATA3*/\
+=09MUX_VAL(CP(HSUSB0_DATA4),=09(IEN  | PTD | DIS | M0)) /*HSUSB0_DATA4*/\
+=09MUX_VAL(CP(HSUSB0_DATA5),=09(IEN  | PTD | DIS | M0)) /*HSUSB0_DATA5*/\
+=09MUX_VAL(CP(HSUSB0_DATA6),=09(IEN  | PTD | DIS | M0)) /*HSUSB0_DATA6*/\
+=09MUX_VAL(CP(HSUSB0_DATA7),=09(IEN  | PTD | DIS | M0)) /*HSUSB0_DATA7*/\
+=09MUX_VAL(CP(I2C1_SCL),=09=09(IEN  | PTU | EN  | M0)) /*I2C1_SCL*/\
+=09MUX_VAL(CP(I2C1_SDA),=09=09(IEN  | PTU | EN  | M0)) /*I2C1_SDA*/\
+=09MUX_VAL(CP(I2C2_SCL),=09=09(IEN  | PTU | EN  | M0)) /*I2C2_SCL*/\
+=09MUX_VAL(CP(I2C2_SDA),=09=09(IEN  | PTU | EN  | M0)) /*I2C2_SDA*/\
+=09MUX_VAL(CP(I2C3_SCL),=09=09(IEN  | PTU | EN  | M0)) /*I2C3_SCL*/\
+=09MUX_VAL(CP(I2C3_SDA),=09=09(IEN  | PTU | EN  | M0)) /*I2C3_SDA*/\
+=09MUX_VAL(CP(I2C4_SCL),=09=09(IEN  | PTU | EN  | M0)) /*I2C4_SCL*/\
+=09MUX_VAL(CP(I2C4_SDA),=09=09(IEN  | PTU | EN  | M0)) /*I2C4_SDA*/\
+=09MUX_VAL(CP(HDQ_SIO),=09=09(IDIS | PTU | EN  | M4)) /*GPIO_170*/\
+=09MUX_VAL(CP(MCSPI1_CLK),=09=09(IEN  | PTU | EN  | M4)) /*GPIO_171*/\
+=09MUX_VAL(CP(MCSPI1_SIMO),=09(IEN  | PTU | EN  | M4)) /*GPIO_172*/\
+=09MUX_VAL(CP(MCSPI1_SOMI),=09(IEN  | PTU | EN  | M4)) /*GPIO_173*/\
+=09MUX_VAL(CP(MCSPI1_CS0),=09=09(IEN  | PTD | EN  | M0)) /*McSPI1_CS0*/\
+=09MUX_VAL(CP(MCSPI1_CS1),=09=09(IDIS | PTD | EN  | M0)) /*McSPI1_CS1*/\
+=09MUX_VAL(CP(MCSPI1_CS2),=09=09(IDIS | PTD | DIS | M4)) /*GPIO_176*/\
+ /* USB EHCI (port 2) */\
+=09MUX_VAL(CP(MCSPI1_CS3),=09=09(IEN  | PTD | EN  | M3)) /*HSUSB2_DATA2*/\
+=09MUX_VAL(CP(MCSPI2_CLK),=09=09(IEN  | PTD | EN  | M3)) /*HSUSB2_DATA7*/\
+=09MUX_VAL(CP(MCSPI2_SIMO),=09(IEN  | PTD | EN  | M3)) /*HSUSB2_DATA4*/\
+=09MUX_VAL(CP(MCSPI2_SOMI),=09(IEN  | PTD | EN  | M3)) /*HSUSB2_DATA5*/\
+=09MUX_VAL(CP(MCSPI2_CS0),=09=09(IEN  | PTD | EN  | M3)) /*HSUSB2_DATA6*/\
+=09MUX_VAL(CP(MCSPI2_CS1),=09=09(IEN  | PTD | EN  | M3)) /*HSUSB2_DATA3*/\
+=09MUX_VAL(CP(ETK_D10_ES2),=09(IDIS | PTD | DIS | M3)) /*HSUSB2_CLK*/\
+=09MUX_VAL(CP(ETK_D11_ES2),=09(IDIS | PTD | DIS | M3)) /*HSUSB2_STP*/\
+=09MUX_VAL(CP(ETK_D12_ES2),=09(IEN  | PTD | EN  | M3)) /*HSUSB2_DIR*/\
+=09MUX_VAL(CP(ETK_D13_ES2),=09(IEN  | PTD | EN  | M3)) /*HSUSB2_NXT*/\
+=09MUX_VAL(CP(ETK_D14_ES2),=09(IEN  | PTD | EN  | M3)) /*HSUSB2_DATA0*/\
+=09MUX_VAL(CP(ETK_D15_ES2),=09(IEN  | PTD | EN  | M3)) /*HSUSB2_DATA1*/\
+ /*Control and debug */\
+=09MUX_VAL(CP(SYS_32K),=09=09(IEN  | PTD | DIS | M0)) /*SYS_32K*/\
+=09MUX_VAL(CP(SYS_CLKREQ),=09=09(IEN  | PTD | DIS | M0)) /*SYS_CLKREQ*/\
+=09MUX_VAL(CP(SYS_NIRQ),=09=09(IEN  | PTU | EN  | M0)) /*SYS_nIRQ*/\
+=09MUX_VAL(CP(SYS_BOOT0),=09=09(IEN  | PTD | DIS | M4)) /*GPIO_2*/\
+=09MUX_VAL(CP(SYS_BOOT1),=09=09(IEN  | PTD | DIS | M4)) /*GPIO_3*/\
+=09MUX_VAL(CP(SYS_BOOT2),=09=09(IEN  | PTD | DIS | M4)) /*GPIO_4 - MMC1_WP=
*/\
+=09MUX_VAL(CP(SYS_BOOT3),=09=09(IEN  | PTD | DIS | M4)) /*GPIO_5*/\
+=09MUX_VAL(CP(SYS_BOOT4),=09=09(IEN  | PTD | DIS | M4)) /*GPIO_6*/\
+=09MUX_VAL(CP(SYS_BOOT5),=09=09(IEN  | PTD | DIS | M4)) /*GPIO_7*/\
+=09MUX_VAL(CP(SYS_BOOT6),=09=09(IDIS | PTD | DIS | M4)) /*GPIO_8*/ \
+=09MUX_VAL(CP(SYS_OFF_MODE),=09(IEN  | PTD | DIS | M0)) /*SYS_OFF_MODE*/\
+=09MUX_VAL(CP(SYS_CLKOUT1),=09(IEN  | PTD | DIS | M0)) /*SYS_CLKOUT1*/\
+=09MUX_VAL(CP(SYS_CLKOUT2),=09(IEN  | PTU | EN  | M4)) /*GPIO_186*/\
+=09MUX_VAL(CP(ETK_CLK_ES2),=09(IDIS | PTU | EN  | M3)) /*HSUSB1_STP*/\
+=09MUX_VAL(CP(ETK_CTL_ES2),=09(IDIS | PTU | DIS | M3)) /*HSUSB1_CLK*/\
+=09MUX_VAL(CP(ETK_D0_ES2),=09=09(IEN  | PTU | DIS | M3)) /*HSUSB1_DATA0*/\
+=09MUX_VAL(CP(ETK_D1_ES2),=09=09(IEN  | PTU | DIS | M3)) /*HSUSB1_DATA1*/\
+=09MUX_VAL(CP(ETK_D2_ES2),=09=09(IEN  | PTU | DIS | M3)) /*HSUSB1_DATA2*/\
+=09MUX_VAL(CP(ETK_D3_ES2),=09=09(IEN  | PTU | DIS | M3)) /*HSUSB1_DATA7*/\
+=09MUX_VAL(CP(ETK_D4_ES2),=09=09(IEN  | PTU | DIS | M3)) /*HSUSB1_DATA4*/\
+=09MUX_VAL(CP(ETK_D5_ES2),=09=09(IEN  | PTU | DIS | M3)) /*HSUSB1_DATA5*/\
+=09MUX_VAL(CP(ETK_D6_ES2),=09=09(IEN  | PTU | DIS | M3)) /*HSUSB1_DATA6*/\
+=09MUX_VAL(CP(ETK_D7_ES2),=09=09(IEN  | PTU | DIS | M3)) /*HSUSB1_DATA3*/\
+=09MUX_VAL(CP(ETK_D8_ES2),=09=09(IEN  | PTU | DIS | M3)) /*HSUSB1_DIR*/\
+=09MUX_VAL(CP(ETK_D9_ES2),=09=09(IEN  | PTU | DIS | M3)) /*HSUSB1_NXT*/\
+=09MUX_VAL(CP(D2D_MCAD1),=09=09(IEN  | PTD | EN  | M0)) /*d2d_mcad1*/\
+=09MUX_VAL(CP(D2D_MCAD2),=09=09(IEN  | PTD | EN  | M0)) /*d2d_mcad2*/\
+=09MUX_VAL(CP(D2D_MCAD3),=09=09(IEN  | PTD | EN  | M0)) /*d2d_mcad3*/\
+=09MUX_VAL(CP(D2D_MCAD4),=09=09(IEN  | PTD | EN  | M0)) /*d2d_mcad4*/\
+=09MUX_VAL(CP(D2D_MCAD5),=09=09(IEN  | PTD | EN  | M0)) /*d2d_mcad5*/\
+=09MUX_VAL(CP(D2D_MCAD6),=09=09(IEN  | PTD | EN  | M0)) /*d2d_mcad6*/\
+=09MUX_VAL(CP(D2D_MCAD7),=09=09(IEN  | PTD | EN  | M0)) /*d2d_mcad7*/\
+=09MUX_VAL(CP(D2D_MCAD8),=09=09(IEN  | PTD | EN  | M0)) /*d2d_mcad8*/\
+=09MUX_VAL(CP(D2D_MCAD9),=09=09(IEN  | PTD | EN  | M0)) /*d2d_mcad9*/\
+=09MUX_VAL(CP(D2D_MCAD10),=09=09(IEN  | PTD | EN  | M0)) /*d2d_mcad10*/\
+=09MUX_VAL(CP(D2D_MCAD11),=09=09(IEN  | PTD | EN  | M0)) /*d2d_mcad11*/\
+=09MUX_VAL(CP(D2D_MCAD12),=09=09(IEN  | PTD | EN  | M0)) /*d2d_mcad12*/\
+=09MUX_VAL(CP(D2D_MCAD13),=09=09(IEN  | PTD | EN  | M0)) /*d2d_mcad13*/\
+=09MUX_VAL(CP(D2D_MCAD14),=09=09(IEN  | PTD | EN  | M0)) /*d2d_mcad14*/\
+=09MUX_VAL(CP(D2D_MCAD15),=09=09(IEN  | PTD | EN  | M0)) /*d2d_mcad15*/\
+=09MUX_VAL(CP(D2D_MCAD16),=09=09(IEN  | PTD | EN  | M0)) /*d2d_mcad16*/\
+=09MUX_VAL(CP(D2D_MCAD17),=09=09(IEN  | PTD | EN  | M0)) /*d2d_mcad17*/\
+=09MUX_VAL(CP(D2D_MCAD18),=09=09(IEN  | PTD | EN  | M0)) /*d2d_mcad18*/\
+=09MUX_VAL(CP(D2D_MCAD19),=09=09(IEN  | PTD | EN  | M0)) /*d2d_mcad19*/\
+=09MUX_VAL(CP(D2D_MCAD20),=09=09(IEN  | PTD | EN  | M0)) /*d2d_mcad20*/\
+=09MUX_VAL(CP(D2D_MCAD21),=09=09(IEN  | PTD | EN  | M0)) /*d2d_mcad21*/\
+=09MUX_VAL(CP(D2D_MCAD22),=09=09(IEN  | PTD | EN  | M0)) /*d2d_mcad22*/\
+=09MUX_VAL(CP(D2D_MCAD23),=09=09(IEN  | PTD | EN  | M0)) /*d2d_mcad23*/\
+=09MUX_VAL(CP(D2D_MCAD24),=09=09(IEN  | PTD | EN  | M0)) /*d2d_mcad24*/\
+=09MUX_VAL(CP(D2D_MCAD25),=09=09(IEN  | PTD | EN  | M0)) /*d2d_mcad25*/\
+=09MUX_VAL(CP(D2D_MCAD26),=09=09(IEN  | PTD | EN  | M0)) /*d2d_mcad26*/\
+=09MUX_VAL(CP(D2D_MCAD27),=09=09(IEN  | PTD | EN  | M0)) /*d2d_mcad27*/\
+=09MUX_VAL(CP(D2D_MCAD28),=09=09(IEN  | PTD | EN  | M0)) /*d2d_mcad28*/\
+=09MUX_VAL(CP(D2D_MCAD29),=09=09(IEN  | PTD | EN  | M0)) /*d2d_mcad29*/\
+=09MUX_VAL(CP(D2D_MCAD30),=09=09(IEN  | PTD | EN  | M0)) /*d2d_mcad30*/\
+=09MUX_VAL(CP(D2D_MCAD31),=09=09(IEN  | PTD | EN  | M0)) /*d2d_mcad31*/\
+=09MUX_VAL(CP(D2D_MCAD32),=09=09(IEN  | PTD | EN  | M0)) /*d2d_mcad32*/\
+=09MUX_VAL(CP(D2D_MCAD33),=09=09(IEN  | PTD | EN  | M0)) /*d2d_mcad33*/\
+=09MUX_VAL(CP(D2D_MCAD34),=09=09(IEN  | PTD | EN  | M0)) /*d2d_mcad34*/\
+=09MUX_VAL(CP(D2D_MCAD35),=09=09(IEN  | PTD | EN  | M0)) /*d2d_mcad35*/\
+=09MUX_VAL(CP(D2D_MCAD36),=09=09(IEN  | PTD | EN  | M0)) /*d2d_mcad36*/\
+=09MUX_VAL(CP(D2D_CLK26MI),=09(IEN  | PTD | DIS | M0)) /*d2d_clk26mi*/\
+=09MUX_VAL(CP(D2D_NRESPWRON),=09(IEN  | PTD | EN  | M0)) /*d2d_nrespwron*/=
\
+=09MUX_VAL(CP(D2D_NRESWARM),=09(IEN  | PTU | EN  | M0)) /*d2d_nreswarm */\
+=09MUX_VAL(CP(D2D_ARM9NIRQ),=09(IEN  | PTD | DIS | M0)) /*d2d_arm9nirq */\
+=09MUX_VAL(CP(D2D_UMA2P6FIQ),=09(IEN  | PTD | DIS | M0)) /*d2d_uma2p6fiq*/=
\
+=09MUX_VAL(CP(D2D_SPINT),=09=09(IEN  | PTD | EN  | M0)) /*d2d_spint*/\
+=09MUX_VAL(CP(D2D_FRINT),=09=09(IEN  | PTD | EN  | M0)) /*d2d_frint*/\
+=09MUX_VAL(CP(D2D_DMAREQ0),=09(IEN  | PTD | DIS | M0)) /*d2d_dmareq0*/\
+=09MUX_VAL(CP(D2D_DMAREQ1),=09(IEN  | PTD | DIS | M0)) /*d2d_dmareq1*/\
+=09MUX_VAL(CP(D2D_DMAREQ2),=09(IEN  | PTD | DIS | M0)) /*d2d_dmareq2*/\
+=09MUX_VAL(CP(D2D_DMAREQ3),=09(IEN  | PTD | DIS | M0)) /*d2d_dmareq3*/\
+=09MUX_VAL(CP(D2D_N3GTRST),=09(IEN  | PTD | DIS | M0)) /*d2d_n3gtrst*/\
+=09MUX_VAL(CP(D2D_N3GTDI),=09=09(IEN  | PTD | DIS | M0)) /*d2d_n3gtdi*/\
+=09MUX_VAL(CP(D2D_N3GTDO),=09=09(IEN  | PTD | DIS | M0)) /*d2d_n3gtdo*/\
+=09MUX_VAL(CP(D2D_N3GTMS),=09=09(IEN  | PTD | DIS | M0)) /*d2d_n3gtms*/\
+=09MUX_VAL(CP(D2D_N3GTCK),=09=09(IEN  | PTD | DIS | M0)) /*d2d_n3gtck*/\
+=09MUX_VAL(CP(D2D_N3GRTCK),=09(IEN  | PTD | DIS | M0)) /*d2d_n3grtck*/\
+=09MUX_VAL(CP(D2D_MSTDBY),=09=09(IEN  | PTU | EN  | M0)) /*d2d_mstdby*/\
+=09MUX_VAL(CP(D2D_SWAKEUP),=09(IEN  | PTD | EN  | M0)) /*d2d_swakeup*/\
+=09MUX_VAL(CP(D2D_IDLEREQ),=09(IEN  | PTD | DIS | M0)) /*d2d_idlereq*/\
+=09MUX_VAL(CP(D2D_IDLEACK),=09(IEN  | PTU | EN  | M0)) /*d2d_idleack*/\
+=09MUX_VAL(CP(D2D_MWRITE),=09=09(IEN  | PTD | DIS | M0)) /*d2d_mwrite*/\
+=09MUX_VAL(CP(D2D_SWRITE),=09=09(IEN  | PTD | DIS | M0)) /*d2d_swrite*/\
+=09MUX_VAL(CP(D2D_MREAD),=09=09(IEN  | PTD | DIS | M0)) /*d2d_mread*/\
+=09MUX_VAL(CP(D2D_SREAD),=09=09(IEN  | PTD | DIS | M0)) /*d2d_sread*/\
+=09MUX_VAL(CP(D2D_MBUSFLAG),=09(IEN  | PTD | DIS | M0)) /*d2d_mbusflag*/\
+=09MUX_VAL(CP(D2D_SBUSFLAG),=09(IEN  | PTD | DIS | M0)) /*d2d_sbusflag*/\
+=09MUX_VAL(CP(SDRC_CKE0),=09=09(IDIS | PTU | EN  | M0)) /*sdrc_cke0*/\
+=09MUX_VAL(CP(SDRC_CKE1),=09=09(IDIS | PTU | EN  | M0)) /*sdrc_cke1*/
+
+#define MUX_BEAGLE_C() \
+=09MUX_VAL(CP(MCBSP3_DX),=09=09(IEN  | PTD | DIS | M4)) /*GPIO_140*/\
+=09MUX_VAL(CP(MCBSP3_DR),=09=09(IEN  | PTD | DIS | M4)) /*GPIO_142*/\
+=09MUX_VAL(CP(MCBSP3_CLKX),=09(IEN  | PTD | DIS | M4)) /*GPIO_141*/\
+=09MUX_VAL(CP(UART2_CTS),=09=09(IEN  | PTU | EN  | M0)) /*UART2_CTS*/\
+=09MUX_VAL(CP(UART2_RTS),=09=09(IDIS | PTD | DIS | M0)) /*UART2_RTS*/\
+=09MUX_VAL(CP(UART2_TX),=09=09(IDIS | PTD | DIS | M0)) /*UART2_TX*/\
+=09MUX_VAL(CP(UART2_RX),=09=09(IDIS | PTU | EN  | M4)) /*GPIO_147*/
+
+#define MUX_BEAGLE_XM() \
+=09MUX_VAL(CP(GPMC_NCS5),=09=09(IDIS | PTD | EN  | M4)) /*GPIO_56*/\
+=09MUX_VAL(CP(GPMC_WAIT1),=09=09(IDIS | PTU | EN  | M4)) /*GPIO_63*/\
+=09MUX_VAL(CP(MMC1_DAT7),=09=09(IDIS | PTU | EN  | M4)) /*GPIO_129*/\
+=09MUX_VAL(CP(HDQ_SIO),=09=09(IDIS | PTU | EN  | M4)) /*GPIO_170*/\
+=09MUX_VAL(CP(MCBSP3_DX),=09=09(IEN  | PTD | DIS | M4)) /*GPIO_140*/\
+=09MUX_VAL(CP(MCBSP3_DR),=09=09(IEN  | PTD | DIS | M4)) /*GPIO_142*/\
+=09MUX_VAL(CP(MCBSP3_CLKX),=09(IEN  | PTD | DIS | M4)) /*GPIO_141*/\
+=09MUX_VAL(CP(UART2_CTS),=09=09(IEN  | PTU | EN  | M0)) /*UART2_CTS*/\
+=09MUX_VAL(CP(UART2_RTS),=09=09(IDIS | PTD | DIS | M0)) /*UART2_RTS*/\
+=09MUX_VAL(CP(UART2_TX),=09=09(IDIS | PTD | DIS | M0)) /*UART2_TX*/\
+=09MUX_VAL(CP(DSS_DATA0),=09=09(IDIS | PTD | DIS | M7)) /*safe_mode*/\
+=09MUX_VAL(CP(DSS_DATA1),=09=09(IDIS | PTD | DIS | M7)) /*safe_mode*/\
+=09MUX_VAL(CP(DSS_DATA2),=09=09(IDIS | PTD | DIS | M7)) /*safe_mode*/\
+=09MUX_VAL(CP(DSS_DATA3),=09=09(IDIS | PTD | DIS | M7)) /*safe_mode*/\
+=09MUX_VAL(CP(DSS_DATA4),=09=09(IDIS | PTD | DIS | M7)) /*safe_mode*/\
+=09MUX_VAL(CP(DSS_DATA5),=09=09(IDIS | PTD | DIS | M7)) /*safe_mode*/\
+=09MUX_VAL(CP(DSS_DATA18),=09=09(IDIS | PTD | DIS | M3)) /*DSS_DATA0*/\
+=09MUX_VAL(CP(DSS_DATA19),=09=09(IDIS | PTD | DIS | M3)) /*DSS_DATA1*/\
+=09MUX_VAL(CP(DSS_DATA20),=09=09(IDIS | PTD | DIS | M3)) /*DSS_DATA2*/\
+=09MUX_VAL(CP(DSS_DATA21),=09=09(IDIS | PTD | DIS | M3)) /*DSS_DATA3*/\
+=09MUX_VAL(CP(DSS_DATA22),=09=09(IDIS | PTD | DIS | M3)) /*DSS_DATA4*/\
+=09MUX_VAL(CP(DSS_DATA23),=09=09(IDIS | PTD | DIS | M3)) /*DSS_DATA5*/\
+=09MUX_VAL(CP(SYS_BOOT0),=09=09(IDIS | PTD | DIS | M3)) /*DSS_DATA18*/\
+=09MUX_VAL(CP(SYS_BOOT1),=09=09(IDIS | PTD | DIS | M3)) /*DSS_DATA19*/\
+=09MUX_VAL(CP(SYS_BOOT3),=09=09(IDIS | PTD | DIS | M3)) /*DSS_DATA20*/\
+=09MUX_VAL(CP(SYS_BOOT4),=09=09(IDIS | PTD | DIS | M3)) /*DSS_DATA21*/\
+=09MUX_VAL(CP(SYS_BOOT5),=09=09(IDIS | PTD | DIS | M3)) /*DSS_DATA22*/\
+=09MUX_VAL(CP(SYS_BOOT6),=09=09(IDIS | PTD | DIS | M3)) /*DSS_DATA23*/
+
+#define MUX_TINCANTOOLS_ZIPPY() \
+=09MUX_VAL(CP(MMC2_CLK),       (IEN  | PTU | EN  | M0)) /*MMC2_CLK*/\
+=09MUX_VAL(CP(MMC2_CMD),       (IEN  | PTU | EN  | M0)) /*MMC2_CMD*/\
+=09MUX_VAL(CP(MMC2_DAT0),      (IEN  | PTU | EN  | M0)) /*MMC2_DAT0*/\
+=09MUX_VAL(CP(MMC2_DAT1),      (IEN  | PTU | EN  | M0)) /*MMC2_DAT1*/\
+=09MUX_VAL(CP(MMC2_DAT2),      (IEN  | PTU | EN  | M0)) /*MMC2_DAT2*/\
+=09MUX_VAL(CP(MMC2_DAT3),      (IEN  | PTU | EN  | M0)) /*MMC2_DAT3*/\
+=09MUX_VAL(CP(MMC2_DAT4),      (IEN  | PTU | EN  | M1)) /*MMC2_DIR_DAT0*/\
+=09MUX_VAL(CP(MMC2_DAT5),      (IEN  | PTU | EN  | M1)) /*MMC2_DIR_DAT1*/\
+=09MUX_VAL(CP(MMC2_DAT6),      (IEN  | PTU | EN  | M1)) /*MMC2_DIR_CMD*/\
+=09MUX_VAL(CP(MMC2_DAT7),      (IEN  | PTU | EN  | M1)) /*MMC2_CLKIN*/\
+=09MUX_VAL(CP(MCBSP1_CLKR),    (IEN  | PTU | EN  | M1)) /*MCSPI4_CLK*/\
+=09MUX_VAL(CP(MCBSP1_FSR),     (IEN  | PTU | EN  | M4)) /*GPIO_157*/\
+=09MUX_VAL(CP(MCBSP1_DX),      (IEN  | PTD | EN  | M1)) /*MCSPI4_SIMO*/\
+=09MUX_VAL(CP(MCBSP1_DR),      (IEN  | PTD | DIS | M1)) /*MCSPI4_SOMI*/\
+=09MUX_VAL(CP(MCBSP1_FSX),     (IEN  | PTD | EN  | M1)) /*MCSPI4_CS0*/\
+=09MUX_VAL(CP(MCBSP1_CLKX),    (IEN  | PTD | DIS | M4)) /*GPIO_162*/\
+=09MUX_VAL(CP(MCBSP3_DX),      (IEN  | PTD | DIS | M4)) /*GPIO_140*/\
+=09MUX_VAL(CP(MCBSP3_DR),      (IEN  | PTD | DIS | M4)) /*GPIO_142*/\
+=09MUX_VAL(CP(MCBSP3_CLKX),    (IEN  | PTD | DIS | M4)) /*GPIO_141*/
+
+#define MUX_TINCANTOOLS_TRAINER() \
+=09MUX_VAL(CP(MMC2_CLK),       (IEN  | PTU | EN  | M4)) /*GPIO_130*/\
+=09MUX_VAL(CP(MMC2_CMD),       (IEN  | PTU | EN  | M4)) /*GPIO_131*/\
+=09MUX_VAL(CP(MMC2_DAT0),      (IEN  | PTU | EN  | M4)) /*GPIO_132*/\
+=09MUX_VAL(CP(MMC2_DAT1),      (IEN  | PTU | EN  | M4)) /*GPIO_133*/\
+=09MUX_VAL(CP(MMC2_DAT2),      (IEN  | PTU | EN  | M4)) /*GPIO_134*/\
+=09MUX_VAL(CP(MMC2_DAT3),      (IEN  | PTU | EN  | M4)) /*GPIO_135*/\
+=09MUX_VAL(CP(MMC2_DAT4),      (IEN  | PTU | EN  | M4)) /*GPIO_136*/\
+=09MUX_VAL(CP(MMC2_DAT5),      (IEN  | PTU | EN  | M4)) /*GPIO_137*/\
+=09MUX_VAL(CP(MMC2_DAT6),      (IEN  | PTU | EN  | M4)) /*GPIO_138*/\
+=09MUX_VAL(CP(MMC2_DAT7),      (IEN  | PTU | EN  | M4)) /*GPIO_139*/\
+=09MUX_VAL(CP(MCBSP3_DX),      (IEN  | PTU | EN  | M4)) /*GPIO_140*/\
+=09MUX_VAL(CP(MCBSP3_CLKX),    (IEN  | PTU | EN  | M4)) /*GPIO_141*/\
+=09MUX_VAL(CP(MCBSP1_CLKX),    (IEN  | PTU | EN  | M4)) /*GPIO_162*/
+
+#define MUX_KBADC_BEAGLEFPGA() \
+=09MUX_VAL(CP(MCBSP1_CLKR),    (IEN  | PTU | DIS | M1)) /*MCSPI4_CLK*/\
+=09MUX_VAL(CP(MCBSP1_DX),      (IDIS | PTU | DIS | M1)) /*MCSPI4_SIMO*/\
+=09MUX_VAL(CP(MCBSP1_DR),      (IEN  | PTU | EN  | M1)) /*MCSPI4_SOMI*/\
+=09MUX_VAL(CP(MCBSP1_FSX),     (IDIS | PTU | DIS | M1)) /*MCSPI4_CS0*/
+
+#define MUX_BBTOYS_WIFI() \
+=09MUX_VAL(CP(MMC2_CLK),       (IEN  | PTU | EN  | M0)) /*MMC2_CLK*/\
+=09MUX_VAL(CP(MMC2_CMD),       (IEN  | PTU | EN  | M0)) /*MMC2_CMD*/\
+=09MUX_VAL(CP(MMC2_DAT0),      (IEN  | PTU | EN  | M0)) /*MMC2_DAT0*/\
+=09MUX_VAL(CP(MMC2_DAT1),      (IEN  | PTU | EN  | M0)) /*MMC2_DAT1*/\
+=09MUX_VAL(CP(MMC2_DAT2),      (IEN  | PTU | EN  | M0)) /*MMC2_DAT2*/\
+=09MUX_VAL(CP(MMC2_DAT3),      (IEN  | PTU | EN  | M0)) /*MMC2_DAT3*/\
+=09MUX_VAL(CP(MMC2_DAT4),      (IDIS | PTU | EN  | M4)) /*GPIO_136 FM_EN/B=
T_WU*/\
+=09MUX_VAL(CP(MMC2_DAT5),      (IEN  | PTU | EN  | M4)) /*GPIO_137 WLAN_IR=
Q*/\
+=09MUX_VAL(CP(MMC2_DAT6),      (IDIS | PTU | EN  | M4)) /*GPIO_138 BT_EN*/=
\
+=09MUX_VAL(CP(MMC2_DAT7),      (IDIS | PTU | EN  | M4)) /*GPIO_139 WLAN_EN=
*/
+
+/*
+ * Display Configuration
+ */
+
+#define DVI_BEAGLE_ORANGE_COL=09=090x00FF8000
+#define VENC_HEIGHT=09=09=090x00ef
+#define VENC_WIDTH=09=09=090x027f
+
+/*
+ * Configure VENC in DSS for Beagle to generate Color Bar
+ *
+ * Kindly refer to OMAP TRM for definition of these values.
+ */
+static const struct venc_regs venc_config_std_tv =3D {
+=09.status=09=09=09=09=09=3D 0x0000001B,
+=09.f_control=09=09=09=09=3D 0x00000040,
+=09.vidout_ctrl=09=09=09=09=3D 0x00000000,
+=09.sync_ctrl=09=09=09=09=3D 0x00008000,
+=09.llen=09=09=09=09=09=3D 0x00008359,
+=09.flens=09=09=09=09=09=3D 0x0000020C,
+=09.hfltr_ctrl=09=09=09=09=3D 0x00000000,
+=09.cc_carr_wss_carr=09=09=09=3D 0x043F2631,
+=09.c_phase=09=09=09=09=3D 0x00000024,
+=09.gain_u=09=09=09=09=09=3D 0x00000130,
+=09.gain_v=09=09=09=09=09=3D 0x00000198,
+=09.gain_y=09=09=09=09=09=3D 0x000001C0,
+=09.black_level=09=09=09=09=3D 0x0000006A,
+=09.blank_level=09=09=09=09=3D 0x0000005C,
+=09.x_color=09=09=09=09=3D 0x00000000,
+=09.m_control=09=09=09=09=3D 0x00000001,
+=09.bstamp_wss_data=09=09=09=3D 0x0000003F,
+=09.s_carr=09=09=09=09=09=3D 0x21F07C1F,
+=09.line21=09=09=09=09=09=3D 0x00000000,
+=09.ln_sel=09=09=09=09=09=3D 0x00000015,
+=09.l21__wc_ctl=09=09=09=09=3D 0x00001400,
+=09.htrigger_vtrigger=09=09=09=3D 0x00000000,
+=09.savid__eavid=09=09=09=09=3D 0x069300F4,
+=09.flen__fal=09=09=09=09=3D 0x0016020C,
+=09.lal__phase_reset=09=09=09=3D 0x00060107,
+=09.hs_int_start_stop_x=09=09=09=3D 0x008D034E,
+=09.hs_ext_start_stop_x=09=09=09=3D 0x000F0359,
+=09.vs_int_start_x=09=09=09=09=3D 0x01A00000,
+=09.vs_int_stop_x__vs_int_start_y=09=09=3D 0x020501A0,
+=09.vs_int_stop_y__vs_ext_start_x=09=09=3D 0x01AC0024,
+=09.vs_ext_stop_x__vs_ext_start_y=09=09=3D 0x020D01AC,
+=09.vs_ext_stop_y=09=09=09=09=3D 0x00000006,
+=09.avid_start_stop_x=09=09=09=3D 0x03480079,
+=09.avid_start_stop_y=09=09=09=3D 0x02040024,
+=09.fid_int_start_x__fid_int_start_y=09=3D 0x0001008A,
+=09.fid_int_offset_y__fid_ext_start_x=09=3D 0x01AC0106,
+=09.fid_ext_start_y__fid_ext_offset_y=09=3D 0x01060006,
+=09.tvdetgp_int_start_stop_x=09=09=3D 0x00140001,
+=09.tvdetgp_int_start_stop_y=09=09=3D 0x00010001,
+=09.gen_ctrl=09=09=09=09=3D 0x00FF0000,
+=09.output_control=09=09=09=09=3D 0x0000000D,
+=09.dac_b__dac_c=09=09=09=09=3D 0x00000000
+};
+
+/*
+ * Configure Timings for DVI D
+ */
+static const struct panel_config dvid_cfg =3D {
+=09.timing_h=09=3D 0x0ff03f31, /* Horizontal timing */
+=09.timing_v=09=3D 0x01400504, /* Vertical timing */
+=09.pol_freq=09=3D 0x00007028, /* Pol Freq */
+=09.divisor=09=3D 0x00010006, /* 72Mhz Pixel Clock */
+=09.lcd_size=09=3D 0x02ff03ff, /* 1024x768 */
+=09.panel_type=09=3D 0x01, /* TFT */
+=09.data_lines=09=3D 0x03, /* 24 Bit RGB */
+=09.load_mode=09=3D 0x02, /* Frame Mode */
+=09.panel_color=09=3D DVI_BEAGLE_ORANGE_COL, /* ORANGE */
+=09.gfx_format=09=3D GFXFORMAT_RGB24_UNPACKED,
+};
+
+static const struct panel_config dvid_cfg_xm =3D {
+=09.timing_h=09=3D 0x1a4024c9, /* Horizontal timing */
+=09.timing_v=09=3D 0x02c00509, /* Vertical timing */
+=09.pol_freq=09=3D 0x00007028, /* Pol Freq */
+=09.divisor=09=3D 0x00010001, /* 96MHz Pixel Clock */
+=09.lcd_size=09=3D 0x02ff03ff, /* 1024x768 */
+=09.panel_type=09=3D 0x01, /* TFT */
+=09.data_lines=09=3D 0x03, /* 24 Bit RGB */
+=09.load_mode=09=3D 0x02, /* Frame Mode */
+=09.panel_color=09=3D DVI_BEAGLE_ORANGE_COL, /* ORANGE */
+=09.gfx_format=09=3D GFXFORMAT_RGB24_UNPACKED,
+};
+#endif
diff --git a/board/beagle/beagle/led.c b/board/beagle/beagle/led.c
new file mode 100644
index 00000000000..9daec4f48dc
--- /dev/null
+++ b/board/beagle/beagle/led.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2010 Texas Instruments, Inc.
+ * Jason Kridner <jkridner@beagleboard.org>
+ */
+#include <status_led.h>
+#include <asm/arch/cpu.h>
+#include <asm/io.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/gpio.h>
+
+/* GPIO pins for the LEDs */
+#define BEAGLE_LED_USR0=09150
+#define BEAGLE_LED_USR1=09149
+
+#if (IS_ENABLED(CONFIG_LED_STATUS_GREEN))
+void green_led_off(void)
+{
+=09__led_set(CONFIG_LED_STATUS_GREEN, 0);
+}
+
+void green_led_on(void)
+{
+=09__led_set(CONFIG_LED_STATUS_GREEN, 1);
+}
+#endif
+
+static int get_led_gpio(led_id_t mask)
+{
+#if (IS_ENABLED(CONFIG_LED_STATUS0))
+=09if (CONFIG_LED_STATUS_BIT & mask)
+=09=09return BEAGLE_LED_USR0;
+#endif
+#if (IS_ENABLED(CONFIG_LED_STATUS1))
+=09if (CONFIG_LED_STATUS_BIT1 & mask)
+=09=09return BEAGLE_LED_USR1;
+#endif
+
+=09return 0;
+}
+
+void __led_init(led_id_t mask, int state)
+{
+=09int toggle_gpio;
+
+=09toggle_gpio =3D get_led_gpio(mask);
+
+=09if (toggle_gpio && !gpio_request(toggle_gpio, "led"))
+=09=09__led_set(mask, state);
+}
+
+void __led_toggle(led_id_t mask)
+{
+=09int state, toggle_gpio;
+
+=09toggle_gpio =3D get_led_gpio(mask);
+=09if (toggle_gpio) {
+=09=09state =3D gpio_get_value(toggle_gpio);
+=09=09gpio_direction_output(toggle_gpio, !state);
+=09}
+}
+
+void __led_set(led_id_t mask, int state)
+{
+=09int toggle_gpio;
+
+=09toggle_gpio =3D get_led_gpio(mask);
+=09if (toggle_gpio)
+=09=09gpio_direction_output(toggle_gpio, state);
+}
diff --git a/board/isee/igep00x0/spl.c b/board/isee/igep00x0/spl.c
index f814fe13542..18e15215c36 100644
--- a/board/isee/igep00x0/spl.c
+++ b/board/isee/igep00x0/spl.c
@@ -34,19 +34,19 @@ void get_board_mem_timings(struct board_sdrc_timings *t=
imings)
 =09=09=09/* Should not happen... */
 =09=09=09break;
 =09=09}
-=09=09timings->rfr_ctrl =3D SDP_3430_SDRC_RFR_CTRL_200MHz;
+=09=09timings->rfr_ctrl =3D SDP_3430_SDRC_RFR_CTRL_200MHZ;
 =09=09gpmc_cs0_flash =3D MTD_DEV_TYPE_NAND;
 =09} else {
 =09=09if (get_cpu_family() =3D=3D CPU_OMAP34XX) {
 =09=09=09timings->mcfg =3D NUMONYX_V_MCFG_165(256 << 20);
 =09=09=09timings->ctrla =3D NUMONYX_V_ACTIMA_165;
 =09=09=09timings->ctrlb =3D NUMONYX_V_ACTIMB_165;
-=09=09=09timings->rfr_ctrl =3D SDP_3430_SDRC_RFR_CTRL_165MHz;
+=09=09=09timings->rfr_ctrl =3D SDP_3430_SDRC_RFR_CTRL_165MHZ;
 =09=09} else {
 =09=09=09timings->mcfg =3D NUMONYX_V_MCFG_200(256 << 20);
 =09=09=09timings->ctrla =3D NUMONYX_V_ACTIMA_200;
 =09=09=09timings->ctrlb =3D NUMONYX_V_ACTIMB_200;
-=09=09=09timings->rfr_ctrl =3D SDP_3430_SDRC_RFR_CTRL_200MHz;
+=09=09=09timings->rfr_ctrl =3D SDP_3430_SDRC_RFR_CTRL_200MHZ;
 =09=09}
 =09=09gpmc_cs0_flash =3D MTD_DEV_TYPE_ONENAND;
 =09}
diff --git a/board/lg/sniper/sniper.c b/board/lg/sniper/sniper.c
index d4db32ee69b..8a04baf0094 100644
--- a/board/lg/sniper/sniper.c
+++ b/board/lg/sniper/sniper.c
@@ -60,7 +60,7 @@ void get_board_mem_timings(struct board_sdrc_timings *tim=
ings)
 =09timings->mcfg =3D HYNIX_V_MCFG_200(256 << 20);
 =09timings->ctrla =3D HYNIX_V_ACTIMA_200;
 =09timings->ctrlb =3D HYNIX_V_ACTIMB_200;
-=09timings->rfr_ctrl =3D SDP_3430_SDRC_RFR_CTRL_200MHz;
+=09timings->rfr_ctrl =3D SDP_3430_SDRC_RFR_CTRL_200MHZ;
 =09timings->mr =3D MICRON_V_MR_165;
 }
=20
diff --git a/board/logicpd/omap3som/omap3logic.c b/board/logicpd/omap3som/o=
map3logic.c
index 352b519b451..80bdfeab359 100644
--- a/board/logicpd/omap3som/omap3logic.c
+++ b/board/logicpd/omap3som/omap3logic.c
@@ -86,13 +86,13 @@ void get_board_mem_timings(struct board_sdrc_timings *t=
imings)
 =09=09timings->mcfg =3D MICRON_V_MCFG_200(256 << 20);
 =09=09timings->ctrla =3D MICRON_V_ACTIMA_200;
 =09=09timings->ctrlb =3D MICRON_V_ACTIMB_200;
-=09=09timings->rfr_ctrl =3D SDP_3430_SDRC_RFR_CTRL_200MHz;
+=09=09timings->rfr_ctrl =3D SDP_3430_SDRC_RFR_CTRL_200MHZ;
 =09} else {
 =09=09/* 165 MHz works for OMAP35 */
 =09=09timings->mcfg =3D MICRON_V_MCFG_165(256 << 20);
 =09=09timings->ctrla =3D MICRON_V_ACTIMA_165;
 =09=09timings->ctrlb =3D MICRON_V_ACTIMB_165;
-=09=09timings->rfr_ctrl =3D SDP_3430_SDRC_RFR_CTRL_165MHz;
+=09=09timings->rfr_ctrl =3D SDP_3430_SDRC_RFR_CTRL_165MHZ;
 =09}
 }
=20
diff --git a/board/ti/omap3evm/evm.c b/board/ti/omap3evm/evm.c
index 8803643b032..252a2909d64 100644
--- a/board/ti/omap3evm/evm.c
+++ b/board/ti/omap3evm/evm.c
@@ -147,7 +147,7 @@ void get_board_mem_timings(struct board_sdrc_timings *t=
imings)
 =09=09timings->ctrla =3D MICRON_V_ACTIMA_165;
 =09=09timings->ctrlb =3D MICRON_V_ACTIMB_165;
 =09}
-=09timings->rfr_ctrl =3D SDP_3430_SDRC_RFR_CTRL_165MHz;
+=09timings->rfr_ctrl =3D SDP_3430_SDRC_RFR_CTRL_165MHZ;
 =09timings->mr =3D MICRON_V_MR_165;
 }
 #endif /* CONFIG_XPL_BUILD */
diff --git a/board/timll/devkit8000/devkit8000.c b/board/timll/devkit8000/d=
evkit8000.c
index a2a3a9489aa..07aedc46cec 100644
--- a/board/timll/devkit8000/devkit8000.c
+++ b/board/timll/devkit8000/devkit8000.c
@@ -198,7 +198,7 @@ void get_board_mem_timings(struct board_sdrc_timings *t=
imings)
 {
 =09/* General SDRC config */
 =09timings->mcfg =3D MICRON_V_MCFG_165(128 << 20);
-=09timings->rfr_ctrl =3D SDP_3430_SDRC_RFR_CTRL_165MHz;
+=09timings->rfr_ctrl =3D SDP_3430_SDRC_RFR_CTRL_165MHZ;
=20
 =09/* AC timings */
 =09timings->ctrla =3D MICRON_V_ACTIMA_165;
diff --git a/configs/omap3_beagle_defconfig b/configs/omap3_beagle_defconfi=
g
new file mode 100644
index 00000000000..a6cf155426d
--- /dev/null
+++ b/configs/omap3_beagle_defconfig
@@ -0,0 +1,124 @@
+CONFIG_ARM=3Dy
+# CONFIG_SPL_USE_ARCH_MEMCPY is not set
+# CONFIG_SPL_USE_ARCH_MEMSET is not set
+CONFIG_ARCH_OMAP2PLUS=3Dy
+CONFIG_SYS_MALLOC_F_LEN=3D0x4000
+CONFIG_EEPROM_BUS_ADDRESS=3D1
+CONFIG_TI_COMMON_CMD_OPTIONS=3Dy
+CONFIG_DEFAULT_DEVICE_TREE=3D"ti/omap/omap3-beagle"
+CONFIG_TARGET_OMAP3_BEAGLE=3Dy
+CONFIG_SPL_SYS_MALLOC_F_LEN=3D0x400
+CONFIG_SPL=3Dy
+CONFIG_ENV_VARS_UBOOT_CONFIG=3Dy
+# CONFIG_EFI_LOADER is not set
+# CONFIG_ANDROID_BOOT_IMAGE is not set
+# CONFIG_BOOTSTD is not set
+CONFIG_SUPPORT_RAW_INITRD=3Dy
+CONFIG_USE_BOOTCOMMAND=3Dy
+CONFIG_BOOTCOMMAND=3D"run findfdt; run distro_bootcmd"
+CONFIG_USE_PREBOOT=3Dy
+CONFIG_DEFAULT_FDT_FILE=3D"omap3-beagle.dtb"
+CONFIG_SYS_PBSIZE=3D1055
+CONFIG_SYS_CONSOLE_INFO_QUIET=3Dy
+CONFIG_ANDROID_AB=3Dy
+CONFIG_SPL_PAD_TO=3D0x0
+CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
+# CONFIG_SPL_FS_EXT4 is not set
+CONFIG_SPL_MTD=3Dy
+CONFIG_SPL_NAND_DRIVERS=3Dy
+CONFIG_SPL_NAND_ECC=3Dy
+CONFIG_SPL_NAND_SIMPLE=3Dy
+CONFIG_SPL_NAND_BASE=3Dy
+CONFIG_HUSH_PARSER=3Dy
+CONFIG_SYS_PROMPT=3D"BeagleBoard # "
+CONFIG_CMD_CONFIG=3Dy
+# CONFIG_BOOTM_PLAN9 is not set
+# CONFIG_BOOTM_RTEMS is not set
+# CONFIG_BOOTM_VXWORKS is not set
+# CONFIG_CMD_ELF is not set
+# CONFIG_CMD_XIMG is not set
+# CONFIG_CMD_DFU is not set
+# CONFIG_CMD_GPT is not set
+# CONFIG_CMD_MMC_REG is not set
+# CONFIG_MMC_SPEED_MODE_SET is not set
+CONFIG_CMD_NAND=3Dy
+CONFIG_CMD_NAND_TRIMFFS=3Dy
+# CONFIG_CMD_NFS is not set
+CONFIG_CMD_CACHE=3Dy
+# CONFIG_CMD_TIME is not set
+CONFIG_CMD_SYSBOOT=3Dy
+# CONFIG_CMD_PMIC is not set
+# CONFIG_CMD_REGULATOR is not set
+CONFIG_CMD_SQUASHFS=3Dy
+CONFIG_CMD_FS_UUID=3Dy
+CONFIG_CMD_MTDPARTS=3Dy
+CONFIG_MTDIDS_DEFAULT=3D"nand0=3Domap2-nand.0"
+CONFIG_MTDPARTS_DEFAULT=3D"mtdparts=3Domap2-nand.0:512k(spl),1920k(u-boot)=
,128k(u-boot-env),128k(dtb),6m(kernel),-(rootfs)"
+CONFIG_CMD_UBI=3Dy
+CONFIG_EFI_PARTITION=3Dy
+# CONFIG_SPL_EFI_PARTITION is not set
+CONFIG_OF_CONTROL=3Dy
+CONFIG_SPL_OF_CONTROL=3Dy
+CONFIG_OF_SPL_REMOVE_PROPS=3D"clocks clock-names interrupt-parent"
+CONFIG_ENV_OVERWRITE=3Dy
+# CONFIG_ENV_IS_IN_FAT is not set
+CONFIG_ENV_IS_IN_NAND=3Dy
+CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=3Dy
+CONFIG_VERSION_VARIABLE=3Dy
+CONFIG_SPL_DM=3Dy
+CONFIG_SPL_DM_SEQ_ALIAS=3Dy
+CONFIG_SPL_OF_TRANSLATE=3Dy
+CONFIG_USB_FUNCTION_FASTBOOT=3Dy
+CONFIG_FASTBOOT_BUF_ADDR=3D0x82000000
+CONFIG_LED_STATUS=3Dy
+CONFIG_LED_STATUS0=3Dy
+CONFIG_LED_STATUS_BIT=3D1
+CONFIG_LED_STATUS_STATE=3D2
+CONFIG_LED_STATUS1=3Dy
+CONFIG_LED_STATUS_BIT1=3D2
+CONFIG_LED_STATUS_STATE1=3D2
+CONFIG_LED_STATUS_BOOT_ENABLE=3Dy
+CONFIG_LED_STATUS_BOOT=3D1
+CONFIG_LED_STATUS_GREEN_ENABLE=3Dy
+CONFIG_LED_STATUS_GREEN=3D2
+CONFIG_LED_STATUS_CMD=3Dy
+CONFIG_TWL4030_LED=3Dy
+CONFIG_MMC_OMAP_HS=3Dy
+CONFIG_MTD=3Dy
+CONFIG_DM_MTD=3Dy
+CONFIG_MTD_RAW_NAND=3Dy
+CONFIG_NAND_OMAP_ECCSCHEME_HAM1_CODE_HW=3Dy
+CONFIG_SYS_NAND_BLOCK_SIZE=3D0x20000
+CONFIG_SYS_NAND_PAGE_SIZE=3D0x800
+CONFIG_SYS_NAND_OOBSIZE=3D0x40
+CONFIG_SYS_NAND_BUSWIDTH_16BIT=3Dy
+CONFIG_SYS_NAND_U_BOOT_LOCATIONS=3Dy
+CONFIG_SYS_NAND_U_BOOT_OFFS=3D0x80000
+CONFIG_DM_PMIC=3Dy
+# CONFIG_SPL_DM_PMIC is not set
+CONFIG_DM_REGULATOR=3Dy
+CONFIG_DM_REGULATOR_FIXED=3Dy
+CONFIG_DM_REGULATOR_GPIO=3Dy
+CONFIG_SPI=3Dy
+CONFIG_DM_SPI=3Dy
+CONFIG_OMAP3_SPI=3Dy
+CONFIG_USB=3Dy
+# CONFIG_SPL_DM_USB is not set
+CONFIG_USB_EHCI_HCD=3Dy
+CONFIG_USB_OMAP3=3Dy
+CONFIG_USB_MUSB_GADGET=3Dy
+CONFIG_USB_MUSB_OMAP2PLUS=3Dy
+CONFIG_TWL4030_USB=3Dy
+CONFIG_USB_STORAGE=3Dy
+CONFIG_USB_HOST_ETHER=3Dy
+CONFIG_USB_ETHER_ASIX=3Dy
+CONFIG_USB_ETHER_MCS7830=3Dy
+CONFIG_USB_ETHER_SMSC95XX=3Dy
+CONFIG_USB_GADGET=3Dy
+CONFIG_USB_GADGET_MANUFACTURER=3D"TI"
+CONFIG_USB_GADGET_VENDOR_NUM=3D0x0451
+CONFIG_USB_GADGET_PRODUCT_NUM=3D0xd022
+CONFIG_USB_ETHER=3Dy
+CONFIG_BCH=3Dy
+CONFIG_SPL_CRC8=3Dy
diff --git a/configs/omap3_beagle_xm_defconfig b/configs/omap3_beagle_xm_de=
fconfig
new file mode 100644
index 00000000000..42e01d86361
--- /dev/null
+++ b/configs/omap3_beagle_xm_defconfig
@@ -0,0 +1,109 @@
+CONFIG_ARM=3Dy
+# CONFIG_SPL_USE_ARCH_MEMCPY is not set
+# CONFIG_SPL_USE_ARCH_MEMSET is not set
+CONFIG_ARCH_OMAP2PLUS=3Dy
+CONFIG_SYS_MALLOC_F_LEN=3D0x4000
+CONFIG_EEPROM_BUS_ADDRESS=3D1
+CONFIG_TI_COMMON_CMD_OPTIONS=3Dy
+CONFIG_DEFAULT_DEVICE_TREE=3D"ti/omap/omap3-beagle-xm"
+CONFIG_TARGET_OMAP3_BEAGLE=3Dy
+CONFIG_SPL_SYS_MALLOC_F_LEN=3D0x400
+CONFIG_SPL=3Dy
+CONFIG_ENV_VARS_UBOOT_CONFIG=3Dy
+# CONFIG_EFI_LOADER is not set
+# CONFIG_ANDROID_BOOT_IMAGE is not set
+# CONFIG_BOOTSTD is not set
+CONFIG_SUPPORT_RAW_INITRD=3Dy
+CONFIG_USE_BOOTCOMMAND=3Dy
+CONFIG_BOOTCOMMAND=3D"run findfdt; run distro_bootcmd"
+CONFIG_USE_PREBOOT=3Dy
+CONFIG_DEFAULT_FDT_FILE=3D"omap3-beagle-xm.dtb"
+CONFIG_SYS_CONSOLE_INFO_QUIET=3Dy
+CONFIG_ANDROID_AB=3Dy
+CONFIG_SPL_PAD_TO=3D0x0
+CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
+# CONFIG_SPL_FS_EXT4 is not set
+CONFIG_SPL_MTD=3Dy
+# CONFIG_SPL_NAND_SUPPORT is not set
+CONFIG_HUSH_PARSER=3Dy
+CONFIG_SYS_PROMPT=3D"BeagleBoard-xM # "
+CONFIG_CMD_CONFIG=3Dy
+# CONFIG_BOOTM_PLAN9 is not set
+# CONFIG_BOOTM_RTEMS is not set
+# CONFIG_BOOTM_VXWORKS is not set
+# CONFIG_CMD_ELF is not set
+# CONFIG_CMD_XIMG is not set
+# CONFIG_CMD_DFU is not set
+# CONFIG_CMD_GPT is not set
+# CONFIG_CMD_MMC_REG is not set
+# CONFIG_MMC_SPEED_MODE_SET is not set
+# CONFIG_CMD_NFS is not set
+CONFIG_CMD_CACHE=3Dy
+# CONFIG_CMD_TIME is not set
+CONFIG_CMD_SYSBOOT=3Dy
+# CONFIG_CMD_PMIC is not set
+# CONFIG_CMD_REGULATOR is not set
+CONFIG_CMD_SQUASHFS=3Dy
+CONFIG_CMD_FS_UUID=3Dy
+CONFIG_CMD_MTDPARTS=3Dy
+CONFIG_MTDIDS_DEFAULT=3D"nand0=3Domap2-nand.0"
+CONFIG_MTDPARTS_DEFAULT=3D"mtdparts=3Domap2-nand.0:512k(spl),1920k(u-boot)=
,128k(u-boot-env),128k(dtb),6m(kernel),-(rootfs)"
+CONFIG_CMD_UBI=3Dy
+CONFIG_EFI_PARTITION=3Dy
+# CONFIG_SPL_EFI_PARTITION is not set
+CONFIG_OF_CONTROL=3Dy
+CONFIG_SPL_OF_CONTROL=3Dy
+CONFIG_OF_SPL_REMOVE_PROPS=3D"clocks clock-names interrupt-parent"
+CONFIG_ENV_OVERWRITE=3Dy
+CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
+CONFIG_SYS_MMC_ENV_PART=3D1
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=3Dy
+CONFIG_VERSION_VARIABLE=3Dy
+CONFIG_SPL_DM=3Dy
+CONFIG_SPL_DM_SEQ_ALIAS=3Dy
+CONFIG_SPL_OF_TRANSLATE=3Dy
+CONFIG_USB_FUNCTION_FASTBOOT=3Dy
+CONFIG_FASTBOOT_BUF_ADDR=3D0x82000000
+CONFIG_LED_STATUS=3Dy
+CONFIG_LED_STATUS0=3Dy
+CONFIG_LED_STATUS_BIT=3D1
+CONFIG_LED_STATUS_STATE=3D2
+CONFIG_LED_STATUS1=3Dy
+CONFIG_LED_STATUS_BIT1=3D2
+CONFIG_LED_STATUS_STATE1=3D2
+CONFIG_LED_STATUS_BOOT_ENABLE=3Dy
+CONFIG_LED_STATUS_BOOT=3D1
+CONFIG_LED_STATUS_GREEN_ENABLE=3Dy
+CONFIG_LED_STATUS_GREEN=3D2
+CONFIG_LED_STATUS_CMD=3Dy
+CONFIG_TWL4030_LED=3Dy
+CONFIG_MMC_OMAP_HS=3Dy
+CONFIG_MTD=3Dy
+CONFIG_DM_MTD=3Dy
+CONFIG_DM_PMIC=3Dy
+# CONFIG_SPL_DM_PMIC is not set
+CONFIG_DM_REGULATOR=3Dy
+CONFIG_DM_REGULATOR_FIXED=3Dy
+CONFIG_DM_REGULATOR_GPIO=3Dy
+CONFIG_SPI=3Dy
+CONFIG_DM_SPI=3Dy
+CONFIG_OMAP3_SPI=3Dy
+CONFIG_USB=3Dy
+# CONFIG_SPL_DM_USB is not set
+CONFIG_USB_EHCI_HCD=3Dy
+CONFIG_USB_OMAP3=3Dy
+CONFIG_USB_MUSB_GADGET=3Dy
+CONFIG_USB_MUSB_OMAP2PLUS=3Dy
+CONFIG_TWL4030_USB=3Dy
+CONFIG_USB_STORAGE=3Dy
+CONFIG_USB_HOST_ETHER=3Dy
+CONFIG_USB_ETHER_ASIX=3Dy
+CONFIG_USB_ETHER_MCS7830=3Dy
+CONFIG_USB_ETHER_SMSC95XX=3Dy
+CONFIG_USB_GADGET=3Dy
+CONFIG_USB_GADGET_MANUFACTURER=3D"TI"
+CONFIG_USB_GADGET_VENDOR_NUM=3D0x0451
+CONFIG_USB_GADGET_PRODUCT_NUM=3D0xd022
+CONFIG_USB_ETHER=3Dy
+CONFIG_BCH=3Dy
+CONFIG_SPL_CRC8=3Dy
diff --git a/include/configs/omap3_beagle.h b/include/configs/omap3_beagle.=
h
new file mode 100644
index 00000000000..d3737ce97dd
--- /dev/null
+++ b/include/configs/omap3_beagle.h
@@ -0,0 +1,201 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2006-2008
+ * Texas Instruments.
+ * Richard Woodruff <r-woodruff2@ti.com>
+ * Syed Mohammed Khasim <x0khasim@ti.com>
+ *
+ * Configuration settings for the TI OMAP3530 Beagle board.
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#include <configs/ti_omap3_common.h>
+
+/*
+ * We are only ever GP parts and will utilize all of the "downloaded image=
"
+ * area in SRAM which starts at 0x40200000 and ends at 0x4020FFFF (64KB).
+ */
+
+/* NAND */
+#if defined(CONFIG_MTD_RAW_NAND)
+#define CFG_SYS_FLASH_BASE=09NAND_BASE
+#define CFG_SYS_NAND_ECCPOS=09{ 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13 }
+#define CFG_SYS_NAND_ECCSIZE=09512
+#define CFG_SYS_NAND_ECCBYTES=093
+/* NAND: SPL falcon mode configs */
+#endif /* CONFIG_MTD_RAW_NAND */
+
+/* DSS Support */
+
+/* TWL4030 LED Support */
+
+#define MEM_LAYOUT_ENV_SETTINGS \
+=09DEFAULT_LINUX_BOOT_ENV
+
+#define BOOTENV_DEV_LEGACY_MMC(devtypeu, devtypel, instance) \
+=09"bootcmd_" #devtypel #instance "=3D" \
+=09"setenv mmcdev " #instance "; " \
+=09"run mmcboot\0"
+#define BOOTENV_DEV_NAME_LEGACY_MMC(devtypeu, devtypel, instance) \
+=09#devtypel #instance " "
+
+#define BOOT_TARGET_DEVICES_MMC(func)=09=09func(MMC, mmc, 0)
+#define BOOT_TARGET_DEVICES_MMC_LEGACY(func)=09func(LEGACY_MMC, legacy_mmc=
, 0)
+
+#if defined(CONFIG_MTD_RAW_NAND)
+
+#define BOOTENV_DEV_NAND(devtypeu, devtypel, instance) \
+=09"bootcmd_" #devtypel #instance "=3D" \
+=09"if test ${mtdids} =3D '' || test ${mtdparts} =3D '' ; then " \
+=09=09"echo NAND boot disabled: No mtdids and/or mtdparts; " \
+=09"else " \
+=09=09"run nandboot; " \
+=09"fi\0"
+#define BOOTENV_DEV_NAME_NAND(devtypeu, devtypel, instance) \
+=09#devtypel #instance " "
+
+#define BOOT_TARGET_DEVICES_UBIFS(func)=09func(UBIFS, ubifs, 0, rootfs, ro=
otfs)
+#define BOOT_TARGET_DEVICES_NAND(func)=09func(NAND, nand, 0)
+
+#define BOOT_TARGET_DEVICES(func)=09=09\
+=09BOOT_TARGET_DEVICES_MMC(func)=09=09\
+=09BOOT_TARGET_DEVICES_MMC_LEGACY(func)=09\
+=09BOOT_TARGET_DEVICES_UBIFS(func)=09=09\
+=09BOOT_TARGET_DEVICES_NAND(func)
+
+#else /* !CONFIG_MTD_RAW_NAND */
+
+#define BOOT_TARGET_DEVICES(func)=09=09\
+=09BOOT_TARGET_DEVICES_MMC(func)=09=09\
+=09BOOT_TARGET_DEVICES_MMC_LEGACY(func)
+
+#endif /* CONFIG_MTD_RAW_NAND */
+
+#include <config_distro_bootcmd.h>
+
+#define CFG_EXTRA_ENV_SETTINGS \
+=09MEM_LAYOUT_ENV_SETTINGS \
+=09"fdtfile=3D" CONFIG_DEFAULT_FDT_FILE "\0" \
+=09"console=3DttyO2,115200n8\0" \
+=09"bootdir=3D/boot\0" \
+=09"bootenv=3DuEnv.txt\0" \
+=09"bootfile=3DzImage\0" \
+=09"bootpart=3D0:2\0" \
+=09"usbtty=3Dcdc_acm\0" \
+=09"mpurate=3Dauto\0" \
+=09"buddy=3Dnone\0" \
+=09"camera=3Dnone\0" \
+=09"vram=3D12M\0" \
+=09"dvimode=3D640x480MR-16@60\0" \
+=09"defaultdisplay=3Ddvi\0" \
+=09"defaultargs=3Dsetenv defargs " \
+=09=09"mpurate=3D${mpurate} " \
+=09=09"buddy=3D${buddy} "\
+=09=09"camera=3D${camera} "\
+=09=09"vram=3D${vram} " \
+=09=09"omapfb.mode=3Ddvi:${dvimode} " \
+=09=09"omapdss.def_disp=3D${defaultdisplay}\0" \
+=09"optargs=3D\0" \
+=09"findfdt=3D" \
+=09=09"if test $beaglerev =3D AxBx; then " \
+=09=09=09"setenv fdtfile omap3-beagle.dtb; fi; " \
+=09=09"if test $beaglerev =3D Cx; then " \
+=09=09=09"setenv fdtfile omap3-beagle.dtb; fi; " \
+=09=09"if test $beaglerev =3D C4; then " \
+=09=09=09"setenv fdtfile omap3-beagle.dtb; fi; " \
+=09=09"if test $beaglerev =3D xMAB; then " \
+=09=09=09"setenv fdtfile omap3-beagle-xm-ab.dtb; fi; " \
+=09=09"if test $beaglerev =3D xMC; then " \
+=09=09=09"setenv fdtfile omap3-beagle-xm.dtb; fi; " \
+=09=09"if test $fdtfile =3D undefined; then " \
+=09=09=09"echo WARNING: Could not determine device tree to use; fi\0" \
+=09"mmcdev=3D0\0" \
+=09"mmcpart=3D2\0" \
+=09"mmcroot=3D/dev/mmcblk0p2 rw\0" \
+=09"mmcrootfstype=3Dext4 rootwait\0" \
+=09"mmcargs=3Drun defaultargs; setenv bootargs console=3D${console} " \
+=09=09"${mtdparts} " \
+=09=09"${defargs} " \
+=09=09"${optargs} " \
+=09=09"root=3D${mmcroot} " \
+=09=09"rootfstype=3D${mmcrootfstype}\0" \
+=09"userbutton_xm=3Dgpio input 4;\0" \
+=09"userbutton_nonxm=3Dgpio input 7;\0" \
+=09"userbutton=3Dif gpio input 173; then " \
+=09=09=09"run userbutton_xm; " \
+=09=09"else " \
+=09=09=09"run userbutton_nonxm; " \
+=09=09"fi;\0" \
+=09"loadbootenv=3Dfatload mmc ${mmcdev} ${loadaddr} ${bootenv}\0" \
+=09"ext4bootenv=3Dext4load mmc ${bootpart} ${loadaddr} ${bootdir}/${booten=
v}\0" \
+=09"importbootenv=3Decho Importing environment from mmc${mmcdev} ...; " \
+=09=09"env import -t ${loadaddr} ${filesize}\0" \
+=09"mmcbootenv=3Dsetenv bootpart ${mmcdev}:${mmcpart}; " \
+=09=09"mmc dev ${mmcdev}; " \
+=09=09"if mmc rescan; then " \
+=09=09=09"if run userbutton; then " \
+=09=09=09=09"setenv bootenv uEnv.txt;" \
+=09=09=09"else " \
+=09=09=09=09"setenv bootenv user.txt;" \
+=09=09=09"fi;" \
+=09=09=09"run loadbootenv && run importbootenv; " \
+=09=09=09"run ext4bootenv && run importbootenv; " \
+=09=09=09"if test -n $uenvcmd; then " \
+=09=09=09=09"echo Running uenvcmd ...; " \
+=09=09=09=09"run uenvcmd; " \
+=09=09=09"fi; " \
+=09=09"fi\0" \
+=09"validatefdt=3D" \
+=09=09"if test $beaglerev =3D xMAB; then " \
+=09=09=09"if test ! -e mmc ${bootpart} ${bootdir}/${fdtfile}; then " \
+=09=09=09=09"setenv fdtfile omap3-beagle-xm.dtb; " \
+=09=09=09"fi; " \
+=09=09"fi; \0" \
+=09"loadimage=3Dext4load mmc ${bootpart} ${loadaddr} ${bootdir}/${bootfile=
}\0" \
+=09"loaddtb=3Drun validatefdt; ext4load mmc ${bootpart} ${fdtaddr} ${bootd=
ir}/${fdtfile}\0" \
+=09"mmcboot=3Drun mmcbootenv; " \
+=09=09"if run loadimage && run loaddtb; then " \
+=09=09=09"echo Booting ${bootdir}/${bootfile} from mmc ${bootpart} ...; " =
\
+=09=09=09"run mmcargs; " \
+=09=09=09"if test ${bootfile} =3D uImage; then " \
+=09=09=09=09"bootm ${loadaddr} - ${fdtaddr}; " \
+=09=09=09"fi; " \
+=09=09=09"if test ${bootfile} =3D zImage; then " \
+=09=09=09=09"bootz ${loadaddr} - ${fdtaddr}; " \
+=09=09=09"fi; " \
+=09=09"fi\0" \
+=09"nandroot=3Dubi0:rootfs ubi.mtd=3Drootfs rw\0" \
+=09"nandrootfstype=3Dubifs rootwait\0" \
+=09"nandargs=3Drun defaultargs; setenv bootargs console=3D${console} " \
+=09=09"${mtdparts} " \
+=09=09"${defargs} " \
+=09=09"${optargs} " \
+=09=09"root=3D${nandroot} " \
+=09=09"rootfstype=3D${nandrootfstype}\0" \
+=09"nandboot=3Dif nand read ${loadaddr} kernel && nand read ${fdtaddr} dtb=
; then " \
+=09=09=09"echo Booting uImage from NAND MTD 'kernel' partition ...; " \
+=09=09=09"run nandargs; " \
+=09=09=09"bootm ${loadaddr} - ${fdtaddr}; " \
+=09=09"fi\0" \
+=09"loadramdisk=3Dext4load mmc ${bootpart} ${rdaddr} ${bootdir}/${ramdisk}=
\0" \
+=09"ramdisk=3Drootfs.ext2.gz.uboot\0" \
+=09"ramdisk_size=3D16384\0" \
+=09"ramroot=3D/dev/ram rw\0" \
+=09"ramrootfstype=3Dext2\0" \
+=09"ramargs=3Drun defaultargs; setenv bootargs console=3D${console} " \
+=09=09"${mtdparts} " \
+=09=09"${defargs} " \
+=09=09"${optargs} " \
+=09=09"root=3D${ramroot} ramdisk_size=3D${ramdisk_size} " \
+=09=09"rootfstype=3D${ramrootfstype}\0" \
+=09"ramboot=3Drun mmcbootenv; " \
+=09=09"if run loadimage && run loaddtb && run loadramdisk; then " \
+=09=09=09"echo Booting ${bootdir}/${bootfile} from mmc ${bootpart} w/ramdi=
sk ...; " \
+=09=09=09"run ramargs; " \
+=09=09=09"bootz ${loadaddr} ${rdaddr} ${fdtaddr}; " \
+=09=09"fi\0" \
+=09BOOTENV
+
+#endif /* __CONFIG_H */
--=20
2.43.0


