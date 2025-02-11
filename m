Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 967B5C021A0
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 05:35:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FD7980C6E;
	Tue, 11 Feb 2025 06:34:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45F0A80815; Tue, 11 Feb 2025 06:34:39 +0100 (CET)
Received: from mail.naobsd.org (sakura.naobsd.org [160.16.200.221])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC899806FE
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 06:34:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=naoki@radxa.com
Received: from secure.fukaumi.org ([10.0.0.2])
 by mail.naobsd.org (8.14.4/8.14.4/Debian-4.1ubuntu1.1) with ESMTP id
 51B5Xk4k024751; Tue, 11 Feb 2025 14:33:53 +0900
From: FUKAUMI Naoki <naoki@radxa.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 trini@konsulko.com, jonas@kwiboo.se, quentin.schulz@cherry.de,
 jagan@amarulasolutions.com, dsimic@manjaro.org, pbrobinson@gmail.com,
 liujianfeng1994@gmail.com, paulk@sys-base.io, ricardo@pardini.net,
 heiko@sntech.de, macromorgan@hotmail.com, michal.simek@amd.com,
 seb-dev@mail.de, christopher.obbard@linaro.org,
 ilias.apalodimas@linaro.org, marex@denx.de, mkorpershoek@baylibre.com,
 xypron.glpk@gmx.de, jerome.forissier@linaro.org,
 FUKAUMI Naoki <naoki@radxa.com>
Subject: [PATCH 5/7] rockchip: Add DFU to SPL for RK3399
Date: Tue, 11 Feb 2025 05:33:38 +0000
Message-ID: <20250211053340.92919-6-naoki@radxa.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250211053340.92919-1-naoki@radxa.com>
References: <20250211053340.92919-1-naoki@radxa.com>
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

Boot the RK3399 from the USB OTG port using rkflashtool[1] or
rkusbboot[2] and dfu-util.

1a. Download the TPL and SPL using rkflashtool

$ openssl rc4 -provider legacy -K 7c4e0304550509072d2c7b38170d1711 \
	< mkimage-in-simple-bin.mkimage-rockchip-tpl | rkflashtool l
$ openssl rc4 -provider legacy -K 7c4e0304550509072d2c7b38170d1711 \
	< mkimage-in-simple-bin.mkimage-u-boot-spl | rkflashtool L

1b. Download the TPL and SPL using rkusbboot

$ rkusbboot \
	mkimage-in-simple-bin.mkimage-rockchip-tpl \
	mkimage-in-simple-bin.mkimage-u-boot-spl

2. Download the U-Boot

$ dfu-util -a 0 -D u-boot.itb

[1] https://github.com/linux-rockchip/rkflashtool
[2] https://github.com/RadxaNaoki/rkusbboot

Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
---
 arch/arm/dts/rk3399-u-boot.dtsi        | 10 ++++++++++
 arch/arm/mach-rockchip/rk3399/rk3399.c |  1 +
 configs/generic-rk3399_defconfig       |  9 +++++++++
 include/configs/rk3399_common.h        | 11 +++++++----
 4 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/rk3399-u-boot.dtsi b/arch/arm/dts/rk3399-u-boot.dtsi
index 0e3143f8235..ce703d02538 100644
--- a/arch/arm/dts/rk3399-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-u-boot.dtsi
@@ -192,6 +192,16 @@
 	bootph-pre-ram;
 };
 
+&usbdrd3_0 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&usbdrd_dwc3_0 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
 &vopb {
 	bootph-some-ram;
 };
diff --git a/arch/arm/mach-rockchip/rk3399/rk3399.c b/arch/arm/mach-rockchip/rk3399/rk3399.c
index 1ce43c6f0d4..681eecb1edd 100644
--- a/arch/arm/mach-rockchip/rk3399/rk3399.c
+++ b/arch/arm/mach-rockchip/rk3399/rk3399.c
@@ -27,6 +27,7 @@ const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
 	[BROM_BOOTSOURCE_EMMC] = "/mmc@fe330000",
 	[BROM_BOOTSOURCE_SPINOR] = "/spi@ff1d0000/flash@0",
 	[BROM_BOOTSOURCE_SD] = "/mmc@fe320000",
+	[BROM_BOOTSOURCE_USB] = "/usb@fe800000/usb@fe800000",
 };
 
 static struct mm_region rk3399_mem_map[] = {
diff --git a/configs/generic-rk3399_defconfig b/configs/generic-rk3399_defconfig
index 4df70fa4c15..fd08159fa6b 100644
--- a/configs/generic-rk3399_defconfig
+++ b/configs/generic-rk3399_defconfig
@@ -24,11 +24,13 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-generic.dtb"
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_CMD_MEMINFO=y
 CONFIG_CMD_MEMINFO_MAP=y
+CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MISC=y
@@ -44,6 +46,9 @@ CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigne
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 # CONFIG_ADC is not set
+CONFIG_DFU_RAM=y
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x100000
+CONFIG_SYS_DFU_MAX_FILE_SIZE=0x200000
 # CONFIG_USB_FUNCTION_FASTBOOT is not set
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SUPPORT_EMMC_RPMB=y
@@ -68,9 +73,13 @@ CONFIG_ROCKCHIP_SPI=y
 CONFIG_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_USB=y
+CONFIG_SPL_DM_USB_GADGET=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
+CONFIG_SPL_USB_DWC3_GENERIC=y
 CONFIG_USB_GADGET=y
+CONFIG_SPL_USB_GADGET=y
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_USB_FUNCTION_ROCKUSB=y
+CONFIG_SPL_DFU=y
 CONFIG_ERRNO_STR=y
diff --git a/include/configs/rk3399_common.h b/include/configs/rk3399_common.h
index 76f40e7cd5f..c6db5e5d8e2 100644
--- a/include/configs/rk3399_common.h
+++ b/include/configs/rk3399_common.h
@@ -13,8 +13,6 @@
 #define CFG_SYS_SDRAM_BASE		0
 #define SDRAM_MAX_SIZE			0xf8000000
 
-#ifndef CONFIG_XPL_BUILD
-
 #ifndef ROCKCHIP_DEVICE_SETTINGS
 #define ROCKCHIP_DEVICE_SETTINGS
 #endif
@@ -31,13 +29,18 @@
 	"ramdisk_addr_r=0x12180000\0"	\
 	"kernel_comp_size=0x8000000\0"
 
+#if defined(CONFIG_SPL_DFU) && defined(CONFIG_XPL_BUILD)
+#define CFG_EXTRA_ENV_SETTINGS				\
+	"dfu_alt_info_ram=u-boot.itb ram "		\
+	__stringify(CONFIG_SPL_LOAD_FIT_ADDRESS) " "	\
+	__stringify(CONFIG_SYS_DFU_MAX_FILE_SIZE) "\0"
+#else
 #define CFG_EXTRA_ENV_SETTINGS		\
 	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0"	\
 	"partitions=" PARTS_DEFAULT	\
 	ENV_MEM_LAYOUT_SETTINGS		\
 	ROCKCHIP_DEVICE_SETTINGS	\
 	"boot_targets=" BOOT_TARGETS "\0"
-
-#endif /* CONFIG_XPL_BUILD */
+#endif
 
 #endif /* __CONFIG_RK3399_COMMON_H */
-- 
2.43.0

