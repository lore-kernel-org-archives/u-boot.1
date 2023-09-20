Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A28AECE79AC
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 07:42:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85EE686B69;
	Wed, 20 Sep 2023 09:42:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iYfEZBRR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B133886BAC; Wed, 20 Sep 2023 09:42:32 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A056086AC0
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 09:42:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2c008042211so51081571fa.2
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 00:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695195750; x=1695800550; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9xPpmnt5tuN9k+PQjO3AR8gbG8Gr7rSkUlHf6nwGOxs=;
 b=iYfEZBRRX7UIO/NZYLxXXmcP2924CBa2waVGHt0bpnPILk7aMOK1OpT6XDNkrNvIGi
 Rp3wWQPHDdRZacurNQamI0mYK9CCrjMPGUW74PKAKpYGygHJByxghthzh0wWJjMHLnc3
 hyJkkhFbuDdqxqx2q2eZ+p6ZYo8OyV/N5y/IrE4Ktk71tfQkudkYxcmntCEvPXTQ1TP/
 X/Lt+c161epE5/MxwYWfb48nIoO+xTO9zPBkP7F5Y76eJA1SIZGmCqpbj1w+gWgTb/HO
 0tE3rJXuibldTjR+T4ENjWRCCwsIAoUXDQ0aHn9uALDzSuR7TLwgdGBu7qPsZtIZS103
 QUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695195750; x=1695800550;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9xPpmnt5tuN9k+PQjO3AR8gbG8Gr7rSkUlHf6nwGOxs=;
 b=iyIBOG2GfiiszFcirKKOPJm0KyZfRKobqLHgBBL7YEOCrRVU7G7u826V2GuQE6Jwk6
 d/dnNf1KA1G7yCzlkSY0irjdsENmyiVjVVfWrqHKDt0ysb8ZuMt3GTz1+Xofk0TBt3Sm
 GOFLcHMDNanSS/czAPTuvGlw0OMK1mCf9wgCiQRP20W275+bKJMTM3IeKUHHpDXgoZ8r
 QhJ5Lm14FvYCv9RU2fs5MhJKYIQlzTWF2zVhULPfAUcPD100okEHqDZOKXOBIWTvb8dY
 uooIFhodYjhKNXPH8/v+uvJxUk2ukgRJ92HKkvNnzlyUOlrOuZiNRi4zj+e+w5nwl8TR
 oWuA==
X-Gm-Message-State: AOJu0YxLj3k5ORkjedttik/vKGwuuvIgAsCQ3Zzw7QmiLpOTbBqw8RwR
 153NDZ2B9Qbt9VyAI47GPuJaqgSGnaWQ0Fx7pE4=
X-Google-Smtp-Source: AGHT+IF3MBLdustAxWcIcegC7smz+fquWcdyrHsWd0eu3S9wjyq0EYfMnHM5UCTO85M9Hv4gGmwBnw==
X-Received: by 2002:a19:e01a:0:b0:4ff:9efd:8a9e with SMTP id
 x26-20020a19e01a000000b004ff9efd8a9emr1428538lfg.7.1695195749633; 
 Wed, 20 Sep 2023 00:42:29 -0700 (PDT)
Received: from Fecusia.lan (c-05d8225c.014-348-6c756e10.bbcust.telenor.se.
 [92.34.216.5]) by smtp.gmail.com with ESMTPSA id
 g4-20020ac25384000000b005009c4ba3f0sm703234lfh.72.2023.09.20.00.42.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 00:42:29 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Subject: [PATCH] bmips: Add Inteno XG6846 board
Date: Wed, 20 Sep 2023 09:42:25 +0200
Message-ID: <20230920074225.1130769-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.41.0
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

This adds support for the Inteno XG6846 board based on the
Broadcom MIPS 6328 SoC.

The default boot will read a uImage from flash and boot it.

Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/mips/dts/Makefile              |  1 +
 arch/mips/dts/inteno,xg6846.dts     | 57 ++++++++++++++++++++++
 arch/mips/mach-bmips/Kconfig        | 12 +++++
 board/inteno/xg6846/Kconfig         | 12 +++++
 board/inteno/xg6846/MAINTAINERS     |  6 +++
 board/inteno/xg6846/Makefile        |  3 ++
 board/inteno/xg6846/xg6846.c        |  6 +++
 configs/inteno_xg6846_ram_defconfig | 74 +++++++++++++++++++++++++++++
 include/configs/inteno_xg6846.h     |  8 ++++
 9 files changed, 179 insertions(+)
 create mode 100644 arch/mips/dts/inteno,xg6846.dts
 create mode 100644 board/inteno/xg6846/Kconfig
 create mode 100644 board/inteno/xg6846/MAINTAINERS
 create mode 100644 board/inteno/xg6846/Makefile
 create mode 100644 board/inteno/xg6846/xg6846.c
 create mode 100644 configs/inteno_xg6846_ram_defconfig
 create mode 100644 include/configs/inteno_xg6846.h

diff --git a/arch/mips/dts/Makefile b/arch/mips/dts/Makefile
index 1b179116c9b2..14fbce597b9e 100644
--- a/arch/mips/dts/Makefile
+++ b/arch/mips/dts/Makefile
@@ -14,6 +14,7 @@ dtb-$(CONFIG_BOARD_COMTREND_CT5361) += comtrend,ct-5361.dtb
 dtb-$(CONFIG_BOARD_COMTREND_VR3032U) += comtrend,vr-3032u.dtb
 dtb-$(CONFIG_BOARD_COMTREND_WAP5813N) += comtrend,wap-5813n.dtb
 dtb-$(CONFIG_BOARD_HUAWEI_HG556A) += huawei,hg556a.dtb
+dtb-$(CONFIG_BOARD_INTENO_XG6846) += inteno,xg6846.dtb
 dtb-$(CONFIG_BOARD_MT7620_RFB) += mediatek,mt7620-rfb.dtb
 dtb-$(CONFIG_BOARD_MT7620_MT7530_RFB) += mediatek,mt7620-mt7530-rfb.dtb
 dtb-$(CONFIG_BOARD_MT7621_RFB) += mediatek,mt7621-rfb.dtb
diff --git a/arch/mips/dts/inteno,xg6846.dts b/arch/mips/dts/inteno,xg6846.dts
new file mode 100644
index 000000000000..180cfdcac9d4
--- /dev/null
+++ b/arch/mips/dts/inteno,xg6846.dts
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023 Linus Walleij <linusw@kernel.org>
+ *
+ * This is a diet version of the device tree from Linux,
+ * suitable for U-Boot.
+ */
+
+/dts-v1/;
+
+#include "brcm,bcm6328.dtsi"
+
+/ {
+	model = "Inteno XG6846";
+	compatible = "inteno,xg6846", "brcm,bcm6328";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&leds {
+	status = "okay";
+
+	led@18 {
+		reg = <18>;
+		active-low;
+		label = "red:pwr";
+	};
+
+	led@20 {
+		reg = <20>;
+		active-low;
+		label = "green:pwr";
+	};
+};
+
+&spi {
+	status = "okay";
+
+	spi-flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <33333334>;
+	};
+};
+
+&uart0 {
+	bootph-all;
+	status = "okay";
+};
diff --git a/arch/mips/mach-bmips/Kconfig b/arch/mips/mach-bmips/Kconfig
index 01d919f2dbe9..eb9ea34c52fe 100644
--- a/arch/mips/mach-bmips/Kconfig
+++ b/arch/mips/mach-bmips/Kconfig
@@ -203,6 +203,17 @@ config BOARD_HUAWEI_HG556A
 	  ethernet ports, 3 USB ports, 1 UART, GPIO buttons and LEDs, and
 	  a RT3062F/AR9223 (PCI).
 
+config BOARD_INTENO_XG6846
+	bool "Inteno XG6846"
+	depends on SOC_BMIPS_BCM6328
+	select BMIPS_SUPPORTS_BOOT_RAM
+	help
+	  Inteno XG6846 boards have a BCM6328 SoC with 64 MB of RAM and 16
+	  MB of flash (SPI).
+	  Between its different peripherals there's an integrated switch with 4
+	  ethernet ports, 1 UART, GPIO buttons and LEDs, and a Marvell
+	  DSA switch connected to a fiber SFP.
+
 config BOARD_NETGEAR_CG3100D
 	bool "Netgear CG3100D"
 	depends on SOC_BMIPS_BCM3380
@@ -272,6 +283,7 @@ source "board/comtrend/ct5361/Kconfig"
 source "board/comtrend/vr3032u/Kconfig"
 source "board/comtrend/wap5813n/Kconfig"
 source "board/huawei/hg556a/Kconfig"
+source "board/inteno/xg6846/Kconfig"
 source "board/netgear/cg3100d/Kconfig"
 source "board/netgear/dgnd3700v2/Kconfig"
 source "board/sagem/f@st1704/Kconfig"
diff --git a/board/inteno/xg6846/Kconfig b/board/inteno/xg6846/Kconfig
new file mode 100644
index 000000000000..4dd78b3b1960
--- /dev/null
+++ b/board/inteno/xg6846/Kconfig
@@ -0,0 +1,12 @@
+if BOARD_INTENO_XG6846
+
+config SYS_BOARD
+	default "xg6846"
+
+config SYS_VENDOR
+	default "inteno"
+
+config SYS_CONFIG_NAME
+	default "inteno_xg6846"
+
+endif
diff --git a/board/inteno/xg6846/MAINTAINERS b/board/inteno/xg6846/MAINTAINERS
new file mode 100644
index 000000000000..ca41730940f8
--- /dev/null
+++ b/board/inteno/xg6846/MAINTAINERS
@@ -0,0 +1,6 @@
+INTENO XG6846 BOARD
+M:	Linus Walleij <linusw@kernel.org>
+S:	Maintained
+F:	board/inteno/xg6846
+F:	include/configs/inteno_xg6846.h
+F:	configs/inteno_xg6846_ram_defconfig
diff --git a/board/inteno/xg6846/Makefile b/board/inteno/xg6846/Makefile
new file mode 100644
index 000000000000..311e1db7a775
--- /dev/null
+++ b/board/inteno/xg6846/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+obj-y += xg6846.o
diff --git a/board/inteno/xg6846/xg6846.c b/board/inteno/xg6846/xg6846.c
new file mode 100644
index 000000000000..b3b6751a6256
--- /dev/null
+++ b/board/inteno/xg6846/xg6846.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023 Linus Walleij <linusw@kernel.org>
+ */
+
+#include <common.h>
diff --git a/configs/inteno_xg6846_ram_defconfig b/configs/inteno_xg6846_ram_defconfig
new file mode 100644
index 000000000000..99c1ea6aa03e
--- /dev/null
+++ b/configs/inteno_xg6846_ram_defconfig
@@ -0,0 +1,74 @@
+CONFIG_MIPS=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_TEXT_BASE=0x81c00000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_ENV_SIZE=0x2000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="inteno,xg6846"
+CONFIG_SYS_PROMPT="XG6846 # "
+CONFIG_DM_RESET=y
+CONFIG_IDENT_STRING="Inteno XG6846"
+CONFIG_SYS_LOAD_ADDR=0x81000000
+CONFIG_ARCH_BMIPS=y
+CONFIG_SOC_BMIPS_BCM6328=y
+CONFIG_SYS_MIPS_TIMER_FREQ=160000000
+CONFIG_MIPS_CACHE_SETUP=y
+CONFIG_MIPS_CACHE_DISABLE=y
+# CONFIG_MIPS_BOOT_CMDLINE_LEGACY is not set
+# CONFIG_MIPS_BOOT_ENV_LEGACY is not set
+# CONFIG_BOOTSTD is not set
+CONFIG_BOOTDELAY=1
+CONFIG_AUTOBOOT_KEYED=y
+CONFIG_AUTOBOOT_PROMPT="Boot XG6846 in %d seconds\n"
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="sf probe; sf read 0x81000000 0x40000 0x500000; bootm 0x81000000"
+CONFIG_MIPS_BOOT_FDT=y
+CONFIG_LZMA=y
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_REMAKE_ELF=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
+CONFIG_DISPLAY_CPUINFO=y
+CONFIG_SYS_MALLOC_BOOTPARAMS=y
+CONFIG_HUSH_PARSER=y
+CONFIG_SYS_MAXARGS=24
+CONFIG_SYS_CBSIZE=512
+CONFIG_SYS_PBSIZE=541
+CONFIG_SYS_BOOTM_LEN=0x1000000
+CONFIG_CMD_CPU=y
+CONFIG_CMD_LICENSE=y
+# CONFIG_CMD_BOOTD is not set
+# CONFIG_CMD_ELF is not set
+# CONFIG_CMD_XIMG is not set
+# CONFIG_CMD_EXPORTENV is not set
+# CONFIG_CMD_IMPORTENV is not set
+# CONFIG_CMD_EDITENV is not set
+# CONFIG_CMD_SAVEENV is not set
+# CONFIG_CMD_ENV_EXISTS is not set
+# CONFIG_CMD_CRC32 is not set
+CONFIG_CMD_MEMINFO=y
+# CONFIG_CMD_FLASH is not set
+# CONFIG_CMD_LOADS is not set
+CONFIG_CMD_SPI=y
+# CONFIG_CMD_SLEEP is not set
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+# CONFIG_DM_DEVICE_REMOVE is not set
+CONFIG_DMA=y
+CONFIG_BCM6348_IUDMA=y
+CONFIG_LED=y
+CONFIG_LED_BCM6328=y
+CONFIG_LED_BLINK=y
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_PHY_RESET_DELAY=20
+CONFIG_POWER_DOMAIN=y
+CONFIG_BCM6328_POWER_DOMAIN=y
+CONFIG_RESET_BCM6345=y
+CONFIG_DM_SERIAL=y
+CONFIG_BCM6345_SERIAL=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_BCM63XX_HSSPI=y
diff --git a/include/configs/inteno_xg6846.h b/include/configs/inteno_xg6846.h
new file mode 100644
index 000000000000..4f2a2f84010c
--- /dev/null
+++ b/include/configs/inteno_xg6846.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2023 Linus Walleij <linusw@kernel.org>
+ */
+
+#include <configs/bmips_common.h>
+#include <configs/bmips_bcm6328.h>
+
-- 
2.41.0

