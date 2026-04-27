Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCFC1FF8860
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 17:58:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 401BE83BC4;
	Mon, 27 Apr 2026 19:58:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OLi9wdph";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 899F983C51; Mon, 27 Apr 2026 19:58:26 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2F04805D7
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 19:58:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-4233e152457so7360292fac.1
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 10:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777312702; x=1777917502; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/D9WAUfbiK+L+WAVxS2oAViYIV300Kq0m5waMU2vjeU=;
 b=OLi9wdphywlEG65GphNcg8zh/n8wK+3Hw3Jr+laVNijzYbrnN00mg5txZ+UlHIiwD7
 h5LAU2Ku4cYAxYtvjV3Jj5o3A8U5AzkNkjE0yb1lujQqOB1Y+q30Py4j+4FW4JzYdJJ7
 LZu8PlWlprOyqx0LlLdLiqrlPwv8iFZuxqIlT3U4s38vXHdn+pyFhUHmQZwCa9MdImVW
 9kPa+PVDjVdn9wTMqNuSFhEpAxs7wbUqrF3LTJHFqCbHZfZ5/tLjTQbe8dQDuOqdNTia
 FxG7gGtUsXtnvJqFFMpyCJdJgPJf9KVCvzqf6QTVH2psTx4UGnIQbpxnO+YFEFOo6ot+
 A83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777312702; x=1777917502;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/D9WAUfbiK+L+WAVxS2oAViYIV300Kq0m5waMU2vjeU=;
 b=ZKZlvhkTzDUjmsbYLvqPtSIz/MjibUg5JrzTIHYgospvp00bMqmX787R1VoOHNjoVR
 OHE1wE5v7/obmB5M7zbxroWq6f549//i5AxId3wxZjqXlS97SOU2IoPUlVlS0kTDfPUg
 B1w5HqSB9H3o1xz0SSn4uY5GkRdGdFfJuJIkhj7ZiEbWN/AjzBaq+WfvlhooeLmu2v6u
 TKFrjvDC7gtsVNVS8U15PrlEdZQ84Oszns9L6sN27t/uPwVLy6c1E8EN66dZQV9/2BJU
 R2mWOPJFGgkALqS2mzj6FTQomZNul/BP/l9Eon3D+oUGsMKbyRIxf4IZ03ziygm38jyr
 nW4A==
X-Gm-Message-State: AOJu0YwmJmN33myzpHUiNzdIY9kVw+c0iAwSW/ei+/B2CGrntZvFraiW
 8ZdSzERACKsm6LkNJ1FGAJZkVsXEUpaUgnEjLkwPXP3YxGLz1ArYvtv/ryzgQA==
X-Gm-Gg: AeBDiet5TvRjYT5+0caG8rVKQMVU5BOahAqkIWNWdFyKGumD/Vk6wKUDIV2VJlrXXBC
 dpPud11rraiVC1XXG7kz+uRl0poL+LGPTdN+UNC9PHFnD8ZzqzfLyH2w4NJKTXXJB4/yq72KOBx
 BdSVR14LIacndkR4wPDj3EsKyurE26FebU8TJwufDWxcYc6FSYbHhbNS7cyudvbNaUyN+/hrviX
 aqzP0i9YLmazAMKQDAmpQ18epZcIVV2sJoi+xl77CPovsfeXE/hubmHRjwGF6rwnTaOgOCZm3q/
 vE1GD78uVEJFzoN/zvpyA1Q/eDykEzC0BeGuXqERVwyz+j1Vs2HBxDwFh1zcw6QfCv2TsXUKovt
 TOKCzs7SG917oQdTOdpaOFioWdax11kalU7tFdu+zqMOJTRaEJ/PvX8Q+gOoYb95NOUShtzOvrT
 KTsGs8741KZzne4Y4IB3Z8bl+VymyBu+s=
X-Received: by 2002:a05:6871:5d17:b0:42c:193a:465 with SMTP id
 586e51a60fabf-433efd1b3e7mr26805fac.23.1777312702192; 
 Mon, 27 Apr 2026 10:58:22 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-433effdc79bsm4006fac.18.2026.04.27.10.58.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 10:58:21 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: jonas@kwiboo.se, quentin.schulz@cherry.de, trini@konsulko.com,
 kever.yang@rock-chips.com, philipp.tomsich@vrull.eu, sjg@chromium.org,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V2] board: rockchip: add Anbernic RG-DS
Date: Mon, 27 Apr 2026 12:55:53 -0500
Message-ID: <20260427175553.21426-1-macroalpha82@gmail.com>
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
index 00000000000..00d57104775
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
index 00000000000..34528b22420
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

