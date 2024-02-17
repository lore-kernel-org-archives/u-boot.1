Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 733FCC48260
	for <u-boot@archiver.kernel.org>; Sat, 17 Feb 2024 00:33:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78B1E87E64;
	Sat, 17 Feb 2024 01:24:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="FHRUCSi9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4280087E6C; Sat, 17 Feb 2024 01:23:55 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBBA687E16
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 01:23:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4c2a=J2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1708129407; bh=N5TZj2gspAXCG0YdQom4J60SiXMwUBRLCcww29Tg40c=;
 b=FHRUCSi9lKFhV4RbxBIGlmMiXghYi0tagTq6TcDIpDE1Ev6asUIh5+iIXguWuF6+/QTCsMWbK
 BU3vXpzWlorw5QZmXquEuxiW7EtRgvOsH4uRmmjpSGHz7Gs5sT4SDNdiKf/N1Rt02WaGV2y24DQ
 5j8x7nozL8Onlg/BunHEwgbDnahycGUCWr49cHiivl3mL+HVtzpyfYi9Pp0OsBEm+dXvPOnoCJe
 YVZCAPRFJ97VQGUntl5IdGOC7+tYeCv/ctl78liRoLMl+e/DwxC3dzNuhl0CYCtM/rEydK5GWEE
 i5N+FHi1OemFwFBmjLnXyImrrKaAQZ8SmVFIwAWJkMew==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>, Jonas Karlman
 <jonas@kwiboo.se>
Cc: Dragan Simic <dsimic@manjaro.org>, Tianling Shen <cnsztl@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH v2 03/15] rockchip: rk3328-rock64: Update defconfig
Date: Sat, 17 Feb 2024 00:22:29 +0000
Message-ID: <20240217002304.2141064-4-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 65cffc7dbb96cee8b5411eb5
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

Update defconfig for rk3328-rock64 with new defaults.

Remove the SPL_DRIVERS_MISC=y option, no misc driver is used in SPL.

Add CONFIG_SPL_FIT_SIGNATURE=y to let SPL verify an auto generated hash
of FIT images. This help indicate if there is an issue loading any of
the images to DRAM or SRAM. Also add LEGACY_IMAGE_FORMAT=y to keep
support for scripts.

Remove SPL_I2C=y and SPL_PMIC_RK8XX=y, the related i2c and pmic nodes is
not included in the SPL fdt.

Add CMD_GPIO=y and CMD_REGULATOR=y to add the helpful gpio and regulator
commands. Also add CMD_POWEROFF=y to be able to use the poweroff command.

Remove the NET_RANDOM_ETHADDR=y option, ethaddr and eth1addr is set
based on cpuid read from eFUSE.

Add SPL_DM_SEQ_ALIAS=y option to use alias sequence number in SPL.

Add DM_ETH_PHY=y and PHY_REALTEK=y to support onboard ethernet PHY.

Remove REGULATOR_PWM=y, the pwm-regulator compatible is not used.

Also add missing device tree file to MAINTAINERS and add myself as a
reviewer for this board.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
---
v2:
- Add CMD_GPIO, CMD_POWEROFF, CMD_REGULATOR and PHY_GIGE
- Remove SPL_I2C, SPL_PMIC_RK8XX and REGULATOR_PWM
- Collect r-b tag
---
 board/rockchip/evb_rk3328/MAINTAINERS |  2 ++
 configs/rock64-rk3328_defconfig       | 14 +++++++++-----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/board/rockchip/evb_rk3328/MAINTAINERS b/board/rockchip/evb_rk3328/MAINTAINERS
index dc750bd69426..419bc8ded375 100644
--- a/board/rockchip/evb_rk3328/MAINTAINERS
+++ b/board/rockchip/evb_rk3328/MAINTAINERS
@@ -47,8 +47,10 @@ F:      arch/arm/dts/rk3328-roc-cc-u-boot.dtsi
 
 ROCK64-RK3328
 M:      Matwey V. Kornilov <matwey.kornilov@gmail.com>
+R:      Jonas Karlman <jonas@kwiboo.se>
 S:      Maintained
 F:      configs/rock64-rk3328_defconfig
+F:      arch/arm/dts/rk3328-rock64.dts
 F:      arch/arm/dts/rk3328-rock64-u-boot.dtsi
 
 ROCKPIE-RK3328
diff --git a/configs/rock64-rk3328_defconfig b/configs/rock64-rk3328_defconfig
index 0297d098761e..feda87014286 100644
--- a/configs/rock64-rk3328_defconfig
+++ b/configs/rock64-rk3328_defconfig
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
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-rock64.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
@@ -39,17 +40,19 @@ CONFIG_SPL_BSS_MAX_SIZE=0x2000
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
+CONFIG_CMD_POWEROFF=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
+CONFIG_CMD_REGULATOR=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_TPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
@@ -57,8 +60,8 @@ CONFIG_TPL_OF_PLATDATA=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
-CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_TPL_DM=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
 CONFIG_TPL_REGMAP=y
@@ -76,6 +79,9 @@ CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_PHY_GIGE=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
@@ -83,9 +89,7 @@ CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_RK8XX=y
-CONFIG_SPL_PMIC_RK8XX=y
 CONFIG_SPL_DM_REGULATOR=y
-CONFIG_REGULATOR_PWM=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_REGULATOR_RK8XX=y
-- 
2.43.0

