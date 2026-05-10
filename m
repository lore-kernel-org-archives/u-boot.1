Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5BE7CD37B2
	for <u-boot@archiver.kernel.org>; Sun, 10 May 2026 21:19:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4BC0846D1;
	Sun, 10 May 2026 23:19:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UJFmWgTE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76B9B846D2; Sun, 10 May 2026 23:19:41 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2F9A846CB
 for <u-boot@lists.denx.de>; Sun, 10 May 2026 23:19:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7e363c6141dso2214051a34.2
 for <u-boot@lists.denx.de>; Sun, 10 May 2026 14:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778447977; x=1779052777; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NwL6UPFNc7Ux4fp8bgzbthpn7aA1JjmrdYRJpVdPVfE=;
 b=UJFmWgTEBRLyLFYsl+ppIBCbB7Nakk+bQ9kKG6jlOUJFDJauqAY1MWytaG8Tpzv9rh
 +6NOyNBZ+h6QSLpnbRd44Kz0VQP/WO0oPM1FA1Xv4qLljRrGU3/yw9qqzAdy0ML6j12Z
 HIm7jHHLh6wdRza9xVKIqbFvIBuCtMRZkoacDjr6BLV/VdK1G4XB6iBBrQKJDs4FGBK2
 xK6unVxQAM/0ReZG5ANJUgvMsGaFGgOy2xNUWJBu5f+lQFLfGtT2pvHFVPMPbMUgozXr
 G7e72BLl2KWIISN3/tQXAwv9OZCUce+ThfQ6ld+1ck8REh1JavZw+kc39n/woyFNK+nE
 wLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778447977; x=1779052777;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NwL6UPFNc7Ux4fp8bgzbthpn7aA1JjmrdYRJpVdPVfE=;
 b=g2mev6dz24uDU0ZvzEKhYGWSMfstzv6Zmm2/1T2RkoMp4d4fHiXNcSZqWL98jsA8ZP
 waBCz1RmJTD/ZNnrTB8I/ITUUE9USQJhBDPdmEcAcWCOQMxG7Jwd8nA1Xh8668KfY7uM
 Fkqb7Ab+aHwlg5RcV/ThIctLcjSqxMxHepm3a74svSKTJVsNiwQ7xCYTS8NGMNvD8+xE
 IzsVGZ8vc3XOtRStjF8EvrxjI/N34ja3R8hFehjSd3y/Lv8m3tHewvIOMDkiGFCk/+co
 w9frv52H01kza7dF4Qy7m2xqqnhgGB+dVx7Ff97/hqF92cScNXXFu9LFCHMjUj1qaJlh
 atKA==
X-Gm-Message-State: AOJu0YwSIyPDywgOd+jcRx0fjZi2vCd7+hn+lhQtnECIxpvBXCYyxEnv
 hXGWGFX0dHIAwC1TEBl3waCXUcspO4hj5WiSYRwZf3jCHbOu3xB3vHDkk5ephQ==
X-Gm-Gg: Acq92OFm3YcndpHOyxhQL6Dpc9xTLVyD0r12/4KFpLgZ3JrDu7Npolgn5etCTtK9hMD
 s9U8sTMcx41KsX83TmqvSo5m0DbZKAWO5496RhJ+uST/r17B1MXkaB0HVH3ZagcU6sYjmuouXNV
 IJnnWNcRdcXnZ8EjITbEVW5jijqKhZ6smgJo+f74tIhRkE8m1+PU5pLgXUj266FezGsY6F1traw
 hf8EFQ/I5YPc4QLgLe4RDr9bMtcYJpMGtZFxBJjG4rPqKfK4O3aaBN+lD1s16G6dxpGTgb7ULAG
 mthN55TgMSCul9unhGzIP4cJWiq5VSR9DFQKrPQsQ/jlAQnpkXMj6Ym2pf+oC5hZkCFztiX7b38
 ZMt/0ZGg0t+KCXHuhJhqmaIM2JXY86xA52Yl2bk/x29UwWC0KJuBDqNOdrMiwKN0QO7No9dNrSj
 dEfy1U52+rfK9I5w/mTjUG
X-Received: by 2002:a05:6830:3110:b0:7dc:c7aa:22bd with SMTP id
 46e09a7af769-7e1deec720emr14100756a34.6.1778447977286; 
 Sun, 10 May 2026 14:19:37 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367df2fc5sm5626136a34.25.2026.05.10.14.19.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2026 14:19:36 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: jonas@kwiboo.se, quentin.schulz@cherry.de, trini@konsulko.com,
 kever.yang@rock-chips.com, philipp.tomsich@vrull.eu, sjg@chromium.org,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V3] board: rockchip: add Anbernic RG-DS
Date: Sun, 10 May 2026 16:17:13 -0500
Message-ID: <20260510211713.68312-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Chris Morgan <macromorgan@hotmail.com>

Add support for the Anbernic RG-DS dual-screen handheld gaming device.

Link: https://anbernic.com/products/rgds
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
Changes since V1:
 - Added entry to doc/board/rockchip/rockchip.rst.
 - Removed &sdhci and added &vccio_sd to u-boot device tree.
 - Added rk3568 to board path.
 - Corrected defconfig and include files in MAINTAINERS.
 - Removed CONFIG_EFI_LOADER, CONFIG_LEGACY_IMAGE_FORMAT, and
   CONFIG_DISABLE_CONSOLE from defconfig.
Changes since V2:
 - Removed "clock-names" from CONFIG_OF_SPL_REMOVE_PROPS as after
   testing it appears it's no longer needed.
 - Changed include to use rk3568-u-boot.dtsi instead of
   rk356x-u-boot.dtsi.
 - Changed from CONFIG_NO_NET=y to "#CONFIG_NET is not set".
---
 .../arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi | 41 +++++++++++
 arch/arm/mach-rockchip/rk3568/Kconfig         |  7 ++
 board/anbernic/rg-ds_rk3568/Kconfig           | 12 +++
 board/anbernic/rg-ds_rk3568/MAINTAINERS       |  7 ++
 configs/anbernic-rg-ds-rk3568_defconfig       | 73 +++++++++++++++++++
 doc/board/rockchip/rockchip.rst               |  1 +
 include/configs/anbernic-rg-ds-rk3568.h       | 12 +++
 7 files changed, 153 insertions(+)
 create mode 100644 arch/arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi
 create mode 100644 board/anbernic/rg-ds_rk3568/Kconfig
 create mode 100644 board/anbernic/rg-ds_rk3568/MAINTAINERS
 create mode 100644 configs/anbernic-rg-ds-rk3568_defconfig
 create mode 100644 include/configs/anbernic-rg-ds-rk3568.h

diff --git a/arch/arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi b/arch/arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi
new file mode 100644
index 00000000000..7944610827f
--- /dev/null
+++ b/arch/arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "rk3568-u-boot.dtsi"
+
+&gpio0 {
+	bootph-pre-ram;
+};
+
+&i2c0 {
+	bootph-pre-ram;
+};
+
+&i2c0_xfer {
+	bootph-pre-ram;
+};
+
+&i2s1m0_mclk {
+	bootph-pre-ram;
+};
+
+&pmic_int_l {
+	bootph-pre-ram;
+};
+
+&rk817 {
+	regulators {
+		bootph-pre-ram;
+	};
+};
+
+&sdmmc_pwren_l {
+	bootph-pre-ram;
+};
+
+&vcc3v3_sd {
+	bootph-pre-ram;
+};
+
+&vccio_sd {
+	bootph-pre-ram;
+};
diff --git a/arch/arm/mach-rockchip/rk3568/Kconfig b/arch/arm/mach-rockchip/rk3568/Kconfig
index 2730220a18e..ec22898137e 100644
--- a/arch/arm/mach-rockchip/rk3568/Kconfig
+++ b/arch/arm/mach-rockchip/rk3568/Kconfig
@@ -8,6 +8,12 @@ config TARGET_EVB_RK3568
 	help
 	  RK3568 EVB is a evaluation board for Rockchp RK3568.
 
+config TARGET_ANBERNIC_RG_DS_RK3568
+	bool "Anbernic RG DS"
+	help
+	  Anbernic RG DS gaming device with Rockchip RK3568 and dual
+	  displays.
+
 config TARGET_ANBERNIC_RGXX3_RK3566
 	bool "Anbernic RGXX3"
 	help
@@ -71,6 +77,7 @@ config SYS_SOC
 	default "rk3568"
 
 source "board/rockchip/evb_rk3568/Kconfig"
+source "board/anbernic/rg-ds_rk3568/Kconfig"
 source "board/anbernic/rgxx3_rk3566/Kconfig"
 source "board/hardkernel/odroid_m1/Kconfig"
 source "board/hardkernel/odroid_m1s/Kconfig"
diff --git a/board/anbernic/rg-ds_rk3568/Kconfig b/board/anbernic/rg-ds_rk3568/Kconfig
new file mode 100644
index 00000000000..8676940651a
--- /dev/null
+++ b/board/anbernic/rg-ds_rk3568/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_RG_DS_RK3568
+
+config SYS_BOARD
+	default "rg-ds_rk3568"
+
+config SYS_VENDOR
+	default "anbernic"
+
+config SYS_CONFIG_NAME
+	default "anbernic-rg-ds-rk3568"
+
+endif
diff --git a/board/anbernic/rg-ds_rk3568/MAINTAINERS b/board/anbernic/rg-ds_rk3568/MAINTAINERS
new file mode 100644
index 00000000000..7b9b546f7bc
--- /dev/null
+++ b/board/anbernic/rg-ds_rk3568/MAINTAINERS
@@ -0,0 +1,7 @@
+ANBERNIC-RG-DS-RK3568
+M:	Chris Morgan <macromorgan@hotmail.com>
+S:	Maintained
+F:	arch/arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi
+F:	board/anbernic/rg-ds_rk3568
+F:	configs/anbernic-rg-ds-rk3568_defconfig
+F:	include/configs/anbernic-rg-ds-rk3568.h
diff --git a/configs/anbernic-rg-ds-rk3568_defconfig b/configs/anbernic-rg-ds-rk3568_defconfig
new file mode 100644
index 00000000000..399a216a7c9
--- /dev/null
+++ b/configs/anbernic-rg-ds-rk3568_defconfig
@@ -0,0 +1,73 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_SPL_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3568-anbernic-rg-ds"
+CONFIG_ROCKCHIP_RK3568=y
+CONFIG_ROCKCHIP_RK8XX_DISABLE_BOOT_ON_POWERON=y
+CONFIG_SPL_SERIAL=y
+CONFIG_TARGET_ANBERNIC_RG_DS_RK3568=y
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_DEBUG_UART_BASE=0xFE660000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_DEBUG_UART=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-anbernic-rg-ds.dtb"
+# CONFIG_CONSOLE_MUX is not set
+CONFIG_BOARD_TYPES=y
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_BOARD_RNG_SEED=y
+CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_POWER=y
+CONFIG_SPL_ATF=y
+CONFIG_CMD_PWM=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MMC=y
+# CONFIG_CMD_SETEXPR is not set
+# CONFIG_CMD_CLS is not set
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
+CONFIG_OF_LIST="rockchip/rk3568-anbernic-rg-ds"
+CONFIG_OF_SPL_REMOVE_PROPS="interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+# CONFIG_NET is not set
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SPL_REGMAP=y
+CONFIG_SPL_SYSCON=y
+CONFIG_SPL_ADC=y
+CONFIG_SPL_CLK=y
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_MISC=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_FAN53555=y
+CONFIG_PMIC_RK8XX=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
+CONFIG_REGULATOR_RK8XX=y
+CONFIG_PWM_ROCKCHIP=y
+CONFIG_SPL_RAM=y
+# CONFIG_RAM_ROCKCHIP_DEBUG is not set
+CONFIG_BAUDRATE=1500000
+# CONFIG_REQUIRE_SERIAL_CONSOLE is not set
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_SYSRESET=y
+CONFIG_REGEX=y
+# CONFIG_RSA is not set
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 141071f528a..faccba4289b 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -126,6 +126,7 @@ List of mainline supported Rockchip boards:
      - Xunlong Orange Pi 3B (orangepi-3b-rk3566)
 
 * rk3568
+     - Anbernic RG-DS (anbernic-rg-ds-rk3568)
      - Rockchip Evb-RK3568 (evb-rk3568)
      - Banana Pi BPI-R2 Pro (bpi-r2-pro-rk3568)
      - EmbedFire LubanCat 2 (lubancat-2-rk3568)
diff --git a/include/configs/anbernic-rg-ds-rk3568.h b/include/configs/anbernic-rg-ds-rk3568.h
new file mode 100644
index 00000000000..3c5bed952ef
--- /dev/null
+++ b/include/configs/anbernic-rg-ds-rk3568.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __ANBERNIC_RG_DS_RK3568_H
+#define __ANBERNIC_RG_DS_RK3568_H
+
+#define ROCKCHIP_DEVICE_SETTINGS \
+			"stdout=serial,vidconsole\0" \
+			"stderr=serial,vidconsole\0"
+
+#include <configs/rk3568_common.h>
+
+#endif
-- 
2.43.0

