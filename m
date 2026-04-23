Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99FDEFF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 17:29:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 135DB841DF;
	Sat, 25 Apr 2026 19:29:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WNTYYjk1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12B218444B; Sat, 25 Apr 2026 19:29:26 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BC19841D7
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:29:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-506a7bbe9d0so74087321cf.0
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 10:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777138162; x=1777742962; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=51U8V7KTLPDMkqY3udw1QgXnogYnhnwyJJFlc3iFPAQ=;
 b=WNTYYjk17dw/9yLa/N6TG7VTDOBAfWIxy2T70jJiHRxSN7iLBc49C4Gx4H9ewzvMzs
 XxsaDrXM8ulK+AC8g4NZkBCjlpMew1/C0D2kxsX3Fi/kRCSj/2rcS0/nD1oSB9n3JSw4
 7lkNP4ILeNFkZ681dkBi415vfJCiKJS/Eqn6a7bQ1LSF6SM6U4fcAEhyiaDadHlu4Gcx
 VXaA+v8H8kbw5uL9L6GnQevXW+4/i/L0cAkqQ3Q5x4IKB1qiYSGGaDqnCyybwEedFyr2
 DjAyzJbT224OiEGwrBVnpmdDJ7LZakk1g9SpEjqAJYOnPIFUTkl6uJinMY9B+WBjlz9g
 IMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777138162; x=1777742962;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=51U8V7KTLPDMkqY3udw1QgXnogYnhnwyJJFlc3iFPAQ=;
 b=Ioqugg73R4o+Xav3Rm5wpfzlbVHJSy8bV6kqA1ErWhfcvBTmeS0yeCG9hM76l4QZHA
 acJ4eWeU7wCJqnXF4Tl4OBZXaEpoOljPyboYiUw1a4LCv+wz2zncZ8gynIIuZzhFaNiW
 9XZmqUdLCADxS+qYm1Fy0lpNk/FF0Fi09RpM2YLrrjxe125OXxUEeuotQVP3c/OqOGZ+
 ewiv+X9a64j3DBN7CM0hLT9JZBYTqLLc4iSOSu/fJqEYRa5jqyH7HHZi04Ev+AcIXIwC
 BWfjPtRDpFzcPbiSwv7+DWxbWyR5j8YWxXKEraw4jZril19rXP1sT/ZHQsysSH6gzGxq
 QU2w==
X-Gm-Message-State: AOJu0YwHsXWcXx02k6sDFtdUQQktIkmDjtKCWryomY7LzS62nqPWdCvB
 xoZSvMLnFSn8VWGr4Idb2PZ/CJmVTi9sKUtPiylazcBfQH5I9Fa6pCjY5mrbaA==
X-Gm-Gg: AeBDieuh8OGkAlDCj0Jp0Y1LQ0UpjvMcniaONos9Mb2gCc+HbuX+pM+ISrWPSD6PiQ+
 mk4VwgY6z8+ydsm8u14i/8Un6HfFyqSPJyXz39R9LcbZY8n/QULsKm+wm2+yt7+J87399DKkjE+
 aqYde5dGOJnu99Cxs3P1ES2ZkOM8htnZMsktVZT2c04swfDZoj3fnLer+DlT/Xl8KCMsE6gZl3H
 wQJZX2a+8+tH0MjfkIpcsekB5B/hlmDoAstXAYff7mzrqzOkojCG8yYyuV9phAK9mWlt9gsbocV
 E4ATPivwUdlN4GTtJJN+u31neJ/W3t5FBlKDhKTeTDPBRZJwGBJqkTSG47JvrIGWrMFT99W+beq
 dAUCqaeRGcVJSY2ip70fTt59qnDNlBG4qfg8DHMb6LftPLn8K431CxcFvIgpIH2ew7kKOr6+PiC
 2O0Mo6BVc5+2ve/8znCJi27e8vrkrU+U8=
X-Received: by 2002:a05:6820:1622:b0:685:fbc4:cd31 with SMTP id
 006d021491bc7-69462f25c27mr16250020eaf.44.1776969504674; 
 Thu, 23 Apr 2026 11:38:24 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-696148cd37dsm2399306eaf.8.2026.04.23.11.38.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 11:38:24 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: jonas@kwiboo.se, trini@konsulko.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH] board: rockchip: add Anbernic RG-DS
Date: Thu, 23 Apr 2026 13:35:49 -0500
Message-ID: <20260423183549.598018-1-macroalpha82@gmail.com>
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
 .../arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi | 41 ++++++++++
 arch/arm/mach-rockchip/rk3568/Kconfig         |  7 ++
 board/anbernic/rg-ds/Kconfig                  | 12 +++
 board/anbernic/rg-ds/MAINTAINERS              |  7 ++
 configs/anbernic-rg-ds-rk3568_defconfig       | 76 +++++++++++++++++++
 include/configs/anbernic-rg-ds-rk3568.h       | 12 +++
 6 files changed, 155 insertions(+)
 create mode 100644 arch/arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi
 create mode 100644 board/anbernic/rg-ds/Kconfig
 create mode 100644 board/anbernic/rg-ds/MAINTAINERS
 create mode 100644 configs/anbernic-rg-ds-rk3568_defconfig
 create mode 100644 include/configs/anbernic-rg-ds-rk3568.h

diff --git a/arch/arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi b/arch/arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi
new file mode 100644
index 00000000000..337e50f2e54
--- /dev/null
+++ b/arch/arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "rk356x-u-boot.dtsi"
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
+&sdhci {
+	cap-mmc-highspeed;
+};
+
+&sdmmc_pwren_l {
+	bootph-pre-ram;
+};
+
+&vcc3v3_sd {
+	bootph-pre-ram;
+};
diff --git a/arch/arm/mach-rockchip/rk3568/Kconfig b/arch/arm/mach-rockchip/rk3568/Kconfig
index 2730220a18e..8fbd764ab54 100644
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
+source "board/anbernic/rg-ds/Kconfig"
 source "board/anbernic/rgxx3_rk3566/Kconfig"
 source "board/hardkernel/odroid_m1/Kconfig"
 source "board/hardkernel/odroid_m1s/Kconfig"
diff --git a/board/anbernic/rg-ds/Kconfig b/board/anbernic/rg-ds/Kconfig
new file mode 100644
index 00000000000..cb93c249cf4
--- /dev/null
+++ b/board/anbernic/rg-ds/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_RG_DS_RK3568
+
+config SYS_BOARD
+	default "rg-ds-rk3568"
+
+config SYS_VENDOR
+	default "anbernic"
+
+config SYS_CONFIG_NAME
+	default "rg-ds-rk3568"
+
+endif
diff --git a/board/anbernic/rg-ds/MAINTAINERS b/board/anbernic/rg-ds/MAINTAINERS
new file mode 100644
index 00000000000..79ddb663ab7
--- /dev/null
+++ b/board/anbernic/rg-ds/MAINTAINERS
@@ -0,0 +1,7 @@
+ANBERNIC-RG-DS-RK3568
+M:	Chris Morgan <macromorgan@hotmail.com>
+S:	Maintained
+F:	arch/arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi
+F:	board/anbernic/rg-ds
+F:	configs/anbernic-rg-ds_defconfig
+F:	include/configs/anbernic-rg-ds.h
diff --git a/configs/anbernic-rg-ds-rk3568_defconfig b/configs/anbernic-rg-ds-rk3568_defconfig
new file mode 100644
index 00000000000..c16a208a117
--- /dev/null
+++ b/configs/anbernic-rg-ds-rk3568_defconfig
@@ -0,0 +1,76 @@
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
+# CONFIG_EFI_LOADER is not set
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-anbernic-rg-ds.dtb"
+CONFIG_DISABLE_CONSOLE=y
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
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_NO_NET=y
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

