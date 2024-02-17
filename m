Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16327C48260
	for <u-boot@archiver.kernel.org>; Sat, 17 Feb 2024 00:35:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96B3287E7B;
	Sat, 17 Feb 2024 01:24:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="UCn8iVZM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E84487E16; Sat, 17 Feb 2024 01:23:59 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85D25847AC
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 01:23:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4c2a=J2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1708129402; bh=y0B3gaXUWSANSuf0MlLFMccvMGrj/cdnkVvKFwim8e8=;
 b=UCn8iVZMLdNsKzShlWbQKGbm0aZ8OM2ViyuiRuBhdNJwJ3gE//dOmQC6AXuGwiKaqvfZF0Tke
 AfOLxEMFfezFDhm/8RX+SgPIe1FC5k37CwM5rOrY1zkshCpKRs07GF6zdo5dgkOay/ELggXDrsx
 KRducRW9PTvHMSFHlm2WTkUV94yrvf0Nz3LAKmyD2i7J5rSww2542E0at3t9EsxXXvRHPb4jftl
 wNRuzBqu4uNiRgZ7C43I5CGt1X8mdHioEA2v7gCGaAAcSkQCHk072nlliMWeVdhgSpnKhNIZ2D9
 OjWB5SysEYIomaaU+AbDlI2CqG6Z2drEWJwi6Gizk+yQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Dragan Simic <dsimic@manjaro.org>, Tianling Shen <cnsztl@gmail.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 02/15] rockchip: rk3328-evb: Update defconfig
Date: Sat, 17 Feb 2024 00:22:28 +0000
Message-ID: <20240217002304.2141064-3-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 65cffc78bb96cee8b5411ea3
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

Update defconfig for rk3328-evb with new defaults.

Add DM_RESET=y to support using reset signals.

Remove the xPL_DRIVERS_MISC=y option, no misc driver is used in xPL.

Add CONFIG_SPL_FIT_SIGNATURE=y to let SPL verify an auto generated hash
of FIT images. This help indicate if there is an issue loading any of
the images to DRAM or SRAM. Also add LEGACY_IMAGE_FORMAT=y to keep
support for scripts.

Add CMD_GPIO=y and CMD_REGULATOR=y to add the helpful gpio and regulator
commands.

Add MISC_INIT_R=y, ROCKCHIP_EFUSE=y and remove NET_RANDOM_ETHADDR=y,
ethaddr and eth1addr is set based on cpuid read from eFUSE.

Remove pinctrl-0 and pinctrl-names from CONFIG_OF_SPL_REMOVE_PROPS,
SPL need to configure pinctrl for e.g. SD-card.

Add SPL_DM_SEQ_ALIAS=y option to use alias sequence number in SPL.

Add DM_ETH_PHY=y, PHY_MOTORCOMM=y and PHY_REALTEK=y to support common
ethernet PHYs.

Remove REGULATOR_PWM=y, the pwm-regulator compatible is not used.

Add RNG_ROCKCHIP=y and DM_RNG=y options to support the onboard random
generator.

Add SYSINFO=y to support the sysinfo uclass.

Also add missing device tree files to MAINTAINERS and remove the
obsolete README file.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2:
- Add DM_RESET, CMD_GPIO, CMD_REGULATOR, PHY_GIGE and SYSINFO
- Remove REGULATOR_PWM
---
 board/rockchip/evb_rk3328/MAINTAINERS |  2 +
 board/rockchip/evb_rk3328/README      | 70 ---------------------------
 configs/evb-rk3328_defconfig          | 22 ++++++---
 3 files changed, 18 insertions(+), 76 deletions(-)
 delete mode 100644 board/rockchip/evb_rk3328/README

diff --git a/board/rockchip/evb_rk3328/MAINTAINERS b/board/rockchip/evb_rk3328/MAINTAINERS
index 5fc114a63f6c..dc750bd69426 100644
--- a/board/rockchip/evb_rk3328/MAINTAINERS
+++ b/board/rockchip/evb_rk3328/MAINTAINERS
@@ -4,6 +4,8 @@ S:      Maintained
 F:      board/rockchip/evb_rk3328
 F:      include/configs/evb_rk3328.h
 F:      configs/evb-rk3328_defconfig
+F:      arch/arm/dts/rk3328-evb.dts
+F:      arch/arm/dts/rk3328-evb-u-boot.dtsi
 
 NANOPI-R2C-RK3328
 M:      Tianling Shen <cnsztl@gmail.com>
diff --git a/board/rockchip/evb_rk3328/README b/board/rockchip/evb_rk3328/README
deleted file mode 100644
index 6cbb66a4cf87..000000000000
--- a/board/rockchip/evb_rk3328/README
+++ /dev/null
@@ -1,70 +0,0 @@
-Introduction
-============
-
-RK3328 key features we might use in U-Boot:
-* CPU: ARMv8 64bit quad-core Cortex-A53
-* IRAM: 36KB
-* DRAM: 4GB-16MB dual-channel
-* eMMC: support eMMC 5.0/5.1, suport HS400, HS200, DDR50
-* SD/MMC: support SD 3.0, MMC 4.51
-* USB: USB2.0 EHCI host port *2
-* Display: RGB/HDMI/DP/MIPI/EDP
-
-evb key features:
-* regulator: pwm regulator for CPU B/L
-* PMIC: rk808
-* debug console: UART2
-
-In order to support Arm Trust Firmware(ATF), we need to use the
-miniloader from rockchip which:
-* do DRAM init
-* load and verify ATF image
-* load and verify U-Boot image
-
-Here is the step-by-step to boot to U-Boot on rk3328.
-
-Get the Source and prebuild binary
-==================================
-
-  > mkdir ~/evb_rk3328
-  > cd ~/evb_rk3328
-  > git clone https://github.com/ARM-software/arm-trusted-firmware.git
-  > git clone https://github.com/rockchip-linux/rkbin
-  > git clone https://github.com/rockchip-linux/rkflashtool
-
-Compile ATF
-===============
-
-  > cd arm-trusted-firmware
-  > make realclean
-  > make CROSS_COMPILE=aarch64-linux-gnu- PLAT=rk3328 bl31
-
-Compile U-Boot
-==================
-
-  > cd ../u-boot
-  > make CROSS_COMPILE=aarch64-linux-gnu- evb-rk3328_defconfig all
-
-Compile rkflashtool
-=======================
-
-  > cd ../rkflashtool
-  > make
-
-Package image for miniloader
-================================
-  > cd ..
-  > cp arm-trusted-firmware/build/rk3328/release/bl31.bin rkbin/rk33
-  > ./rkbin/tools/trust_merger rkbin/tools/RK3328TRUST.ini
-  > ./rkbin/tools/loaderimage --pack --uboot u-boot/u-boot-dtb.bin uboot.img
-  > mkdir image
-  > mv trust.img ./image/
-  > mv uboot.img ./image/rk3328evb-uboot.bin
-
-Flash image
-===============
-Power on(or reset with RESET KEY) with MASKROM KEY preesed, and then:
-
-  > ./rkflashtool/rkflashloader rk3328evb
-
-You should be able to get U-Boot log message in console/UART2 now.
diff --git a/configs/evb-rk3328_defconfig b/configs/evb-rk3328_defconfig
index b9c541a92a1f..5a5f59c04b3b 100644
--- a/configs/evb-rk3328_defconfig
+++ b/configs/evb-rk3328_defconfig
@@ -9,11 +9,11 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
 CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3328-evb"
+CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3328=y
 CONFIG_TPL_ROCKCHIP_COMMON_BOARD=y
 CONFIG_TPL_LIBCOMMON_SUPPORT=y
 CONFIG_TPL_LIBGENERIC_SUPPORT=y
-CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL_STACK_R_ADDR=0x4000000
 CONFIG_SPL_STACK=0x400000
 CONFIG_TPL_SYS_MALLOC_F_LEN=0x800
@@ -25,10 +25,13 @@ CONFIG_DEBUG_UART=y
 # CONFIG_ANDROID_BOOT_IMAGE is not set
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-evb.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_MISC_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
@@ -41,22 +44,23 @@ CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x10000
 CONFIG_SPL_ATF=y
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_TPL_SYS_MALLOC_SIMPLE=y
-CONFIG_TPL_DRIVERS_MISC=y
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
-CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_TPL_OF_PLATDATA=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
-CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_TPL_DM=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
 CONFIG_TPL_REGMAP=y
@@ -70,8 +74,13 @@ CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
+CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_PHY_MOTORCOMM=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_PHY_GIGE=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
@@ -79,17 +88,18 @@ CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_RK8XX=y
-CONFIG_REGULATOR_PWM=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_REGULATOR_RK8XX=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_RAM=y
 CONFIG_SPL_RAM=y
 CONFIG_TPL_RAM=y
+CONFIG_DM_RNG=y
+CONFIG_RNG_ROCKCHIP=y
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
-CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_SYS_NS16550_MEM32=y
+CONFIG_SYSINFO=y
 CONFIG_SYSRESET=y
 # CONFIG_TPL_SYSRESET is not set
 CONFIG_USB=y
-- 
2.43.0

