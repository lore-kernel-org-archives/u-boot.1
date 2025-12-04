Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B493AD1D893
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 08:07:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3635E83E7F;
	Thu,  4 Dec 2025 09:07:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=norik.com header.i=@norik.com header.b="onwAPum7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A491483F32; Thu,  4 Dec 2025 09:07:49 +0100 (CET)
Received: from cp2.siel.si (cp2.siel.si [46.19.12.180])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B86883C51
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 09:07:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=primoz.fiser@norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com; 
 s=default;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IvG0AVnFtMOo/naJO0smNlAHUl3Jl6xeq7wkTdJmBJA=; b=onwAPum7WLV254n61QxHYwm65Q
 KJLv/jBRD8hsm6C6udXM9FTj88/e7sDHMAvq2+UbmxpanNhQ/5rExWnJL8ACIEjdZpDxDUW9t8dit
 gOYmLMEkWOVEoPhxpqCSmQgOdYwSHDuG0hGaR5YkEX90B2hRENAJA5LiuRBUX8+oiE05lFLwbkASO
 UDc1rDZAfVfqJK/puotQQLSiXGAW5lT5lkfDpbismfj68V+kU5JL1ZNJRKki2D6DNHMxgLSrcBRRC
 1uGVt24kFx5U+0yEYZBJEaDYr2JkLFaD7AMrNOHAoHwZgzb96C4sjCR98ROwZ+ZWIjBYW2QBoxMQU
 sOo/Al4w==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:43766
 helo=localhost.localdomain)
 by cp2.siel.si with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98.2) (envelope-from <primoz.fiser@norik.com>)
 id 1vR4NR-00000003FHo-0Ycx; Thu, 04 Dec 2025 09:07:45 +0100
From: Primoz Fiser <primoz.fiser@norik.com>
To: Mathieu Othacehe <m.othacehe@gmail.com>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 uboot-imx@nxp.com, Tom Rini <trini@konsulko.com>,
 Benjamin Hahn <B.Hahn@phytec.de>
Cc: u-boot@lists.denx.de,
	upstream@lists.phytec.de
Subject: [PATCH 1/3] board: phytec: phycore-imx93: Switch to standard boot
Date: Thu,  4 Dec 2025 09:07:42 +0100
Message-Id: <20251204080744.3868067-1-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp2.siel.si
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cp2.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cp2.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

Enable standard boot for the phyCORE-i.MX93 board and use it as a new
default. Add required standard boot variables to the environment, while
removing old boot scripts and now unnecessary environment variables.
Adjust variables according to the requirements of PHYTEC ampliphy-boot
distro-boot. Last but not least, order environment vars by alphabet and
run 'make savedefconfig' to resync defconfig.

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi | 16 +++++
 board/phytec/phycore_imx93/phycore_imx93.env  | 69 ++-----------------
 configs/imx93-phycore_defconfig               | 12 +++-
 3 files changed, 33 insertions(+), 64 deletions(-)

diff --git a/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi b/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
index 0c8d0ba9693f..646b617949d6 100644
--- a/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
+++ b/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
@@ -30,6 +30,22 @@
 		ethernet1 = &eqos;
 	};
 
+	bootstd {
+		bootph-verify;
+		compatible = "u-boot,boot-std";
+
+		filename-prefixes = "/", "/boot/";
+		bootdev-order = "mmc0", "mmc1", "ethernet";
+
+		rauc {
+			compatible = "u-boot,distro-rauc";
+		};
+
+		script {
+			compatible = "u-boot,script";
+		};
+	};
+
 	firmware {
 		optee {
 			compatible = "linaro,optee-tz";
diff --git a/board/phytec/phycore_imx93/phycore_imx93.env b/board/phytec/phycore_imx93/phycore_imx93.env
index 7b0a90e64472..8a2161e4abdf 100644
--- a/board/phytec/phycore_imx93/phycore_imx93.env
+++ b/board/phytec/phycore_imx93/phycore_imx93.env
@@ -1,70 +1,13 @@
 /* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
 
-#include <env/phytec/rauc.env>
-#include <env/phytec/overlays.env>
-
-bootcmd=
-	mmc dev ${mmcdev};
-	if mmc rescan; then
-		if test ${doraucboot} = 1; then
-			run raucinit;
-		fi;
-		if run loadimage; then
-			run mmcboot;
-		else
-			run netboot;
-		fi;
-	fi;
-image=Image
+boot_script_dhcp=net_boot_fit.scr.uimg
+bootcmd=bootflow scan -lb;
 console=ttyLP0
 fdt_addr_r=0x90000000
-fdtoverlay_addr_r=0x900c0000
-bootenv_addr_r=0x90500000
 fdtfile=CONFIG_DEFAULT_FDT_FILE
+fdtoverlay_addr_r=0x900c0000
 ip_dyn=yes
+kernel_addr_r=0x88000000
+nfsroot=/srv/nfs
 prepare_mcore=setenv optargs "${optargs} clk-imx93.mcore_booted"
-mmcdev=CONFIG_ENV_MMC_DEVICE_INDEX
-mmcpart=1
-mmcroot=2
-mmcautodetect=yes
-mmcargs=setenv bootargs console=${console},${baudrate} earlycon
-	root=/dev/mmcblk${mmcdev}p${mmcroot} ${raucargs} rootwait rw ${optargs}
-loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
-loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
-mmcboot=
-	echo Booting from mmc ...;
-	if test ${no_bootenv} = 0; then
-		if run mmc_load_bootenv; then
-			env import -t ${bootenv_addr_r} ${filesize};
-		fi;
-	fi;
-	run mmcargs;
-	if run loadfdt; then
-		run mmc_apply_overlays;
-		booti ${loadaddr} - ${fdt_addr_r};
-	else
-		echo WARN: Cannot load the DT;
-	fi;
-nfsroot=/nfs
-netargs=setenv bootargs console=${console},${baudrate} earlycon
-	root=/dev/nfs ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp ${optargs}
-netboot=
-	echo Booting from net ...;
-	run netargs;
-	if test ${ip_dyn} = yes; then
-		setenv get_cmd dhcp;
-	else
-		setenv get_cmd tftp;
-	fi;
-	if test ${no_bootenv} = 0; then
-		if run net_load_bootenv; then
-			env import -t ${bootenv_addr_r} ${filesize};
-		fi;
-	fi;
-	${get_cmd} ${loadaddr} ${image};
-	if ${get_cmd} ${fdt_addr_r} ${fdtfile}; then
-		run net_apply_overlays;
-		booti ${loadaddr} - ${fdt_addr_r};
-	else
-		echo WARN: Cannot load the DT;
-	fi;
+scriptaddr=0x83500000
diff --git a/configs/imx93-phycore_defconfig b/configs/imx93-phycore_defconfig
index 4c952e966d1a..9e8ff9b6ca90 100644
--- a/configs/imx93-phycore_defconfig
+++ b/configs/imx93-phycore_defconfig
@@ -5,10 +5,10 @@ CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SYS_MALLOC_F_LEN=0x20000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_ENV_SOURCE_FILE="phycore_imx93"
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_PHYTEC_SOM_DETECTION=y
 CONFIG_PHYTEC_EEPROM_BUS=2
-CONFIG_ENV_SOURCE_FILE="phycore_imx93"
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x700000
 CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/imximage.cfg"
@@ -33,8 +33,13 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x90000000
 CONFIG_REMAKE_ELF=y
 # CONFIG_ANDROID_BOOT_IMAGE is not set
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_BOOTSTD_FULL=y
+# CONFIG_BOOTSTD_DEFAULTS is not set
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_SYSTEM_SETUP=y
+# CONFIG_USE_BOOTCOMMAND is not set
 CONFIG_DEFAULT_FDT_FILE="oftree"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
@@ -52,6 +57,9 @@ CONFIG_SPL_I2C=y
 CONFIG_SPL_POWER=y
 CONFIG_SPL_WATCHDOG=y
 CONFIG_SYS_PROMPT="u-boot=> "
+# CONFIG_CMD_BOOTDEV is not set
+# CONFIG_CMD_BOOTMETH is not set
+# CONFIG_CMD_BOOTSTD is not set
 CONFIG_CMD_ERASEENV=y
 CONFIG_CMD_NVEDIT_EFI=y
 CONFIG_CRC32_VERIFY=y
@@ -149,5 +157,7 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x1fc9
 CONFIG_USB_GADGET_PRODUCT_NUM=0x0152
 CONFIG_CI_UDC=y
 CONFIG_ULP_WATCHDOG=y
+# CONFIG_RSA is not set
+# CONFIG_SPL_SHA256 is not set
 CONFIG_LZO=y
 CONFIG_BZIP2=y
-- 
2.34.1

