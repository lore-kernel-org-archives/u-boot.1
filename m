Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19AD7C48BF5
	for <u-boot@archiver.kernel.org>; Sat, 17 Feb 2024 00:36:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8509E87E98;
	Sat, 17 Feb 2024 01:26:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="mrIrNxvi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A40E87E9B; Sat, 17 Feb 2024 01:26:30 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D4E787E9D
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 01:26:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4c2a=J2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1708129419; bh=TyKKugpVSCIzW/pHiYU1Iq2TQfW9wOWAkxiUe73aeYQ=;
 b=mrIrNxviIws35p4D66Qtym5AzVTFNPsrhQZICk4qo4UQQHGCzJeKIVx5gOC9D7lVme7FfvSiU
 Lhwy9jHQ99fB4UpDjl/GXXIeYu64KtTq72+XyqqoSR2PXL9WedpK1BS8LcJwkV0jewuf/9YR43m
 IZPUQ5f6Leb1P9RUlpVxiN/uY5RUO3i//wWjDvbF/fpglkCw0zvj2XdrnMlD5LdQAhcL9AxplG4
 138HtEGOhb+5E3dUJ+yYD0OFQIz0BVBIpVUoWKZUYNPPa+eNc3o2uL5NGisrYiL0n645Estb49h
 eOrVVd0KrXbTtEVFF73xbo+7jmkXP20wPYkJZcPWqIaw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 David Bauer <mail@david-bauer.net>, Tianling Shen <cnsztl@gmail.com>
Cc: Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH v2 06/15] rockchip: rk3328-nanopi-r2: Update defconfig
Date: Sat, 17 Feb 2024 00:22:32 +0000
Message-ID: <20240217002304.2141064-7-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240217002304.2141064-1-jonas@kwiboo.se>
References: <20240217002304.2141064-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65cffc8abb96cee8b5411eeb
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

Update defconfig for rk3328-nanopi-r2* boards with new defaults.

Remove the SPL_DRIVERS_MISC=y option, no misc driver is used in SPL.

Add CONFIG_SPL_FIT_SIGNATURE=y to let SPL verify an auto generated hash
of FIT images. This help indicate if there is an issue loading any of
the images to DRAM or SRAM. Also add LEGACY_IMAGE_FORMAT=y to keep
support for scripts.

Remove SPL_I2C=y and SPL_PMIC_RK8XX=y, the related i2c and pmic nodes is
not included in the SPL fdt.

Add CMD_GPIO=y and CMD_REGULATOR=y to add the helpful gpio and regulator
commands.

Add ROCKCHIP_EFUSE=y and remove NET_RANDOM_ETHADDR=y, ethaddr and
eth1addr is set based on cpuid read from eFUSE.

Add SPL_DM_SEQ_ALIAS=y option to use alias sequence number in SPL.

Add DM_ETH_PHY=y, PHY_GIGE=y, PHY_MOTORCOMM=y, PHY_REALTEK=y and remove
&gmac2io to support reset of onboard ethernet PHYs. Also add DM_MDIO=y
to ensure device tree props is used by motorcomm PHY driver.

Remove REGULATOR_PWM=y, the pwm-regulator compatible is not used.

Add DM_REGULATOR_GPIO=y and SPL_DM_REGULATOR_GPIO=y to support the
regulator-gpio compatible.

Add RNG_ROCKCHIP=y and DM_RNG=y options to support the onboard random
generator.

Also add missing device tree files to MAINTAINERS file.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2:
- Add CMD_GPIO, CMD_REGULATOR, DM_MDIO, PHY_GIGE, DM_REGULATOR_GPIO and
  SPL_DM_REGULATOR_GPIO
- Remove SPL_I2C, SPL_PMIC_RK8XX and REGULATOR_PWM
---
 arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi |  6 ------
 board/rockchip/evb_rk3328/MAINTAINERS      |  2 ++
 configs/nanopi-r2c-plus-rk3328_defconfig   | 20 +++++++++++++++-----
 configs/nanopi-r2c-rk3328_defconfig        | 20 +++++++++++++++-----
 configs/nanopi-r2s-rk3328_defconfig        | 20 +++++++++++++++-----
 doc/board/rockchip/rockchip.rst            |  3 +++
 6 files changed, 50 insertions(+), 21 deletions(-)

diff --git a/arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi b/arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi
index d969b008775e..0a1152e8b52d 100644
--- a/arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi
@@ -27,9 +27,3 @@
 &vcc_sd {
 	bootph-pre-ram;
 };
-
-&gmac2io {
-	snps,reset-gpio = <&gpio1 RK_PC2 GPIO_ACTIVE_LOW>;
-	snps,reset-active-low;
-	snps,reset-delays-us = <0 10000 50000>;
-};
diff --git a/board/rockchip/evb_rk3328/MAINTAINERS b/board/rockchip/evb_rk3328/MAINTAINERS
index 47fd05d2ea8b..b88727acad26 100644
--- a/board/rockchip/evb_rk3328/MAINTAINERS
+++ b/board/rockchip/evb_rk3328/MAINTAINERS
@@ -11,12 +11,14 @@ NANOPI-R2C-RK3328
 M:      Tianling Shen <cnsztl@gmail.com>
 S:      Maintained
 F:      configs/nanopi-r2c-rk3328_defconfig
+F:      arch/arm/dts/rk3328-nanopi-r2c.dts
 F:      arch/arm/dts/rk3328-nanopi-r2c-u-boot.dtsi
 
 NANOPI-R2C-PLUS-RK3328
 M:      Tianling Shen <cnsztl@gmail.com>
 S:      Maintained
 F:      configs/nanopi-r2c-plus-rk3328_defconfig
+F:      arch/arm/dts/rk3328-nanopi-r2c-plus.dts
 F:      arch/arm/dts/rk3328-nanopi-r2c-plus-u-boot.dtsi
 
 NANOPI-R2S-RK3328
diff --git a/configs/nanopi-r2c-plus-rk3328_defconfig b/configs/nanopi-r2c-plus-rk3328_defconfig
index 320ed8b434a8..7a7b0342629f 100644
--- a/configs/nanopi-r2c-plus-rk3328_defconfig
+++ b/configs/nanopi-r2c-plus-rk3328_defconfig
@@ -15,7 +15,6 @@ CONFIG_ROCKCHIP_RK3328=y
 CONFIG_TPL_ROCKCHIP_COMMON_BOARD=y
 CONFIG_TPL_LIBCOMMON_SUPPORT=y
 CONFIG_TPL_LIBGENERIC_SUPPORT=y
-CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL_STACK_R_ADDR=0x600000
 CONFIG_SPL_STACK=0x400000
 CONFIG_TPL_SYS_MALLOC_F_LEN=0x800
@@ -26,7 +25,9 @@ CONFIG_DEBUG_UART=y
 # CONFIG_ANDROID_BOOT_IMAGE is not set
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-nanopi-r2c-plus.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
@@ -39,17 +40,18 @@ CONFIG_SPL_BSS_MAX_SIZE=0x2000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_STACK_R=y
-CONFIG_SPL_I2C=y
 CONFIG_SPL_POWER=y
 CONFIG_SPL_ATF=y
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_TPL_SYS_MALLOC_SIMPLE=y
 CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
+CONFIG_CMD_REGULATOR=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_TPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
@@ -57,8 +59,8 @@ CONFIG_TPL_OF_PLATDATA=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
-CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_TPL_DM=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
 CONFIG_TPL_REGMAP=y
@@ -72,8 +74,14 @@ CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
+CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_PHY_MOTORCOMM=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_PHY_GIGE=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
@@ -81,16 +89,18 @@ CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_RK8XX=y
-CONFIG_SPL_PMIC_RK8XX=y
 CONFIG_SPL_DM_REGULATOR=y
-CONFIG_REGULATOR_PWM=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_SPL_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_SPL_DM_REGULATOR_GPIO=y
 CONFIG_REGULATOR_RK8XX=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_RAM=y
 CONFIG_SPL_RAM=y
 CONFIG_TPL_RAM=y
+CONFIG_DM_RNG=y
+CONFIG_RNG_ROCKCHIP=y
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
diff --git a/configs/nanopi-r2c-rk3328_defconfig b/configs/nanopi-r2c-rk3328_defconfig
index 583179d7c548..becad021f95d 100644
--- a/configs/nanopi-r2c-rk3328_defconfig
+++ b/configs/nanopi-r2c-rk3328_defconfig
@@ -15,7 +15,6 @@ CONFIG_ROCKCHIP_RK3328=y
 CONFIG_TPL_ROCKCHIP_COMMON_BOARD=y
 CONFIG_TPL_LIBCOMMON_SUPPORT=y
 CONFIG_TPL_LIBGENERIC_SUPPORT=y
-CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL_STACK_R_ADDR=0x600000
 CONFIG_SPL_STACK=0x400000
 CONFIG_TPL_SYS_MALLOC_F_LEN=0x800
@@ -26,7 +25,9 @@ CONFIG_DEBUG_UART=y
 # CONFIG_ANDROID_BOOT_IMAGE is not set
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-nanopi-r2c.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
@@ -39,17 +40,18 @@ CONFIG_SPL_BSS_MAX_SIZE=0x2000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_STACK_R=y
-CONFIG_SPL_I2C=y
 CONFIG_SPL_POWER=y
 CONFIG_SPL_ATF=y
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_TPL_SYS_MALLOC_SIMPLE=y
 CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
+CONFIG_CMD_REGULATOR=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_TPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
@@ -57,8 +59,8 @@ CONFIG_TPL_OF_PLATDATA=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
-CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_TPL_DM=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
 CONFIG_TPL_REGMAP=y
@@ -72,8 +74,14 @@ CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
+CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_PHY_MOTORCOMM=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_PHY_GIGE=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
@@ -81,16 +89,18 @@ CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_RK8XX=y
-CONFIG_SPL_PMIC_RK8XX=y
 CONFIG_SPL_DM_REGULATOR=y
-CONFIG_REGULATOR_PWM=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_SPL_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_SPL_DM_REGULATOR_GPIO=y
 CONFIG_REGULATOR_RK8XX=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_RAM=y
 CONFIG_SPL_RAM=y
 CONFIG_TPL_RAM=y
+CONFIG_DM_RNG=y
+CONFIG_RNG_ROCKCHIP=y
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
diff --git a/configs/nanopi-r2s-rk3328_defconfig b/configs/nanopi-r2s-rk3328_defconfig
index f7ed71e41228..fc910b9d03c9 100644
--- a/configs/nanopi-r2s-rk3328_defconfig
+++ b/configs/nanopi-r2s-rk3328_defconfig
@@ -15,7 +15,6 @@ CONFIG_ROCKCHIP_RK3328=y
 CONFIG_TPL_ROCKCHIP_COMMON_BOARD=y
 CONFIG_TPL_LIBCOMMON_SUPPORT=y
 CONFIG_TPL_LIBGENERIC_SUPPORT=y
-CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL_STACK_R_ADDR=0x600000
 CONFIG_SPL_STACK=0x400000
 CONFIG_TPL_SYS_MALLOC_F_LEN=0x800
@@ -26,7 +25,9 @@ CONFIG_DEBUG_UART=y
 # CONFIG_ANDROID_BOOT_IMAGE is not set
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-nanopi-r2s.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
@@ -39,17 +40,18 @@ CONFIG_SPL_BSS_MAX_SIZE=0x2000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_STACK_R=y
-CONFIG_SPL_I2C=y
 CONFIG_SPL_POWER=y
 CONFIG_SPL_ATF=y
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_TPL_SYS_MALLOC_SIMPLE=y
 CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
+CONFIG_CMD_REGULATOR=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_TPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
@@ -57,8 +59,8 @@ CONFIG_TPL_OF_PLATDATA=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
-CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_TPL_DM=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
 CONFIG_TPL_REGMAP=y
@@ -72,8 +74,14 @@ CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
+CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_PHY_MOTORCOMM=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_PHY_GIGE=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
@@ -81,16 +89,18 @@ CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_RK8XX=y
-CONFIG_SPL_PMIC_RK8XX=y
 CONFIG_SPL_DM_REGULATOR=y
-CONFIG_REGULATOR_PWM=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_SPL_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_SPL_DM_REGULATOR_GPIO=y
 CONFIG_REGULATOR_RK8XX=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_RAM=y
 CONFIG_SPL_RAM=y
 CONFIG_TPL_RAM=y
+CONFIG_DM_RNG=y
+CONFIG_RNG_ROCKCHIP=y
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index becd0bfe801d..5f613e7462e5 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -61,6 +61,9 @@ List of mainline supported Rockchip boards:
 * rk3328
      - Rockchip Evb-RK3328 (evb-rk3328)
      - Firefly ROC-RK3328-CC (roc-cc-rk3328)
+     - FriendlyElec NanoPi R2C (nanopi-r2c-rk3328)
+     - FriendlyElec NanoPi R2C Plus (nanopi-r2c-plus-rk3328)
+     - FriendlyElec NanoPi R2S (nanopi-r2s-rk3328)
      - Pine64 Rock64 (rock64-rk3328)
      - Radxa ROCK Pi E (rock-pi-e-rk3328)
 * rk3368
-- 
2.43.0

