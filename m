Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24025C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 13:13:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C53F8862B;
	Thu, 18 Apr 2024 15:12:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="Wdz7iQnd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE6C58862F; Thu, 18 Apr 2024 15:12:57 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBD3088609
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 15:12:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id F3A1B1F9B6;
 Thu, 18 Apr 2024 15:12:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1713445972;
 bh=91DpWyw0C5FUxb5UcP6q6W6p0s+O+1+mwirfFC91GOs=; h=From:To:Subject;
 b=Wdz7iQndoLrx0vkFwVsRxGMOsnUucjHTK1MvTDZLbToqfWpkF5eXie7y6QU6gvOJL
 w+LgiAwLKtjEpmEL5yWk1X89oayhFS6plWevJNy631YMPHSnIk2Mw9xGQRMIhdPPrN
 vxSr3Vksdiq+XzALtI/THgQN4EryfSjVTtVwK8YlDYMtNkiQw9a/BehEmKJfu7y2Dg
 mo87G77rDIS4/Eb2zbbVSwjLRjDDbJFoJdD9usWkVoq2n3U1t4+YSRU212pfRiuuWz
 3V1iruH0pWPIMb5TEYPcu3CnmpNlABAmM2zICK7oLbqmBsu2Wd689c4+5S8fjUl+HW
 bEL1C50Xk9V5g==
From: Francesco Dolcini <francesco@dolcini.it>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Fabio Estevam <festevam@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1] board: toradex: imx: Remove not needed env variables
Date: Thu, 18 Apr 2024 15:12:47 +0200
Message-Id: <20240418131247.19646-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
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

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Remove not needed variables from environment and include config files.

 - setup variable used to be executed from some bootscript, however
   it's not required and there is no point on having this small helper
   here
 - boot_file, kernel_file, ip_dyn variables are not used anywhere
 - fdt_fixup variable is just set empty
 - defargs, vidargs variables used to be used from some bootscript,
   however there is no point on having it here and even old legacy
   bootscript can work without them
 - removed CONFIG_ENABLE_DDR_TRAINING_DEBUG, this is a leftover from
   some copy/paste

On colibri imx6ull/imx7 NAND module, remove consoleblank=0, this is
already the Linux kernel default therefore useless.

Various Linux Kernel command line options removed are not-existing
left-over that applied to some old NXP i.MX downstream branch

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 include/configs/apalis-imx8.h     |  2 --
 include/configs/apalis_imx6.h     |  9 +--------
 include/configs/colibri-imx6ull.h | 10 +++-------
 include/configs/colibri-imx8x.h   |  2 --
 include/configs/colibri_imx6.h    |  9 +--------
 include/configs/colibri_imx7.h    | 11 +++--------
 include/configs/verdin-imx8mm.h   |  3 ---
 include/configs/verdin-imx8mp.h   |  5 -----
 8 files changed, 8 insertions(+), 43 deletions(-)

diff --git a/include/configs/apalis-imx8.h b/include/configs/apalis-imx8.h
index 845705c86db2..c8ec034fc979 100644
--- a/include/configs/apalis-imx8.h
+++ b/include/configs/apalis-imx8.h
@@ -46,8 +46,6 @@
 	"fdt_board=eval\0" \
 	"initrd_addr=0x83800000\0" \
 	"initrd_high=0xffffffffffffffff\0" \
-	"setup=setenv setupargs console=tty1 console=${console},${baudrate} " \
-		"consoleblank=0 earlycon\0" \
 	"update_uboot=askenv confirm Did you load flash.bin resp. u-boot-dtb.imx (y/N)?; " \
 		"if test \"$confirm\" = \"y\"; then " \
 		"setexpr blkcnt ${filesize} + 0x1ff && setexpr blkcnt " \
diff --git a/include/configs/apalis_imx6.h b/include/configs/apalis_imx6.h
index 8a9f3ef75a7d..0df3917e2009 100644
--- a/include/configs/apalis_imx6.h
+++ b/include/configs/apalis_imx6.h
@@ -64,12 +64,9 @@
 
 #define CFG_EXTRA_ENV_SETTINGS \
 	BOOTENV \
-	"boot_file=zImage\0" \
 	"boot_script_dhcp=boot.scr\0" \
 	"console=ttymxc0\0" \
-	"defargs=enable_wait_mode=off vmalloc=400M\0" \
 	"fdt_board=eval\0" \
-	"fdt_fixup=;\0" \
 	MEM_LAYOUT_ENV_SETTINGS \
 	UBOOT_UPDATE \
 	"setethupdate=if env exists ethaddr; then; else setenv ethaddr " \
@@ -80,16 +77,12 @@
 		"|| setenv drive 2; mmc rescan; load ${interface} ${drive}:1" \
 		" ${loadaddr} flash_blk.img && " \
 		"source ${loadaddr}\0" \
-	"setup=setenv setupargs fec_mac=${ethaddr} " \
-		"consoleblank=0 no_console_suspend=1 console=tty1 " \
-		"console=${console},${baudrate}n8\0 " \
 	"setupdate=run setsdupdate || run setusbupdate || run setethupdate\0" \
 	"setusbupdate=usb start && setenv interface usb; setenv drive 0; " \
 		"load ${interface} ${drive}:1 ${loadaddr} flash_blk.img && " \
 		"source ${loadaddr}\0" \
 	"splashpos=m,m\0" \
-	"splashimage=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
-	"vidargs=mxc_hdmi.only_cea=1 fbmem=32M\0"
+	"splashimage=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0"
 
 /* Miscellaneous configurable options */
 
diff --git a/include/configs/colibri-imx6ull.h b/include/configs/colibri-imx6ull.h
index 561a61ebc03c..7c9d633b68d9 100644
--- a/include/configs/colibri-imx6ull.h
+++ b/include/configs/colibri-imx6ull.h
@@ -48,8 +48,8 @@
 	"ubiargs=ubi.mtd=ubi root=ubi0:rootfs rw rootfstype=ubifs " \
 		"ubi.fm_autoconvert=1\0" \
 	"ubiboot=run setup; " \
-		"setenv bootargs ${defargs} ${ubiargs} " \
-		"${setupargs} ${vidargs} ${tdxargs}; echo Booting from NAND...; " \
+		"setenv bootargs ${ubiargs} " \
+		"${setupargs} ${tdxargs}; echo Booting from NAND...; " \
 		"ubi part ubi &&" \
 		"ubi read ${kernel_addr_r} kernel && " \
 		"ubi read ${fdt_addr_r} dtb && " \
@@ -86,11 +86,7 @@
 	UBOOT_UPDATE \
 	"boot_script_dhcp=boot.scr\0" \
 	"console=ttymxc0\0" \
-	"defargs=user_debug=30\0" \
 	"fdt_board=eval-v3\0" \
-	"fdt_fixup=;\0" \
-	"ip_dyn=yes\0" \
-	"kernel_file=zImage\0" \
 	"setethupdate=if env exists ethaddr; then; else setenv ethaddr " \
 		"00:14:2d:00:00:00; fi; tftpboot ${loadaddr} " \
 		"${board}/flash_eth.img && source ${loadaddr}\0" \
@@ -99,7 +95,7 @@
 		"${board}/flash_blk.img && source ${loadaddr}\0" \
 	"setup=setenv setupargs " \
 		"console=tty1 console=${console}" \
-		",${baudrate}n8 ${memargs} ${mtdparts} consoleblank=0\0" \
+		",${baudrate}n8 ${memargs} ${mtdparts}\0" \
 	"setupdate=run setsdupdate || run setusbupdate || run setethupdate\0" \
 	"setusbupdate=usb start && setenv interface usb && " \
 		"fatload ${interface} 0:1 ${loadaddr} " \
diff --git a/include/configs/colibri-imx8x.h b/include/configs/colibri-imx8x.h
index 042fcb8757ff..2b7fea30116f 100644
--- a/include/configs/colibri-imx8x.h
+++ b/include/configs/colibri-imx8x.h
@@ -40,8 +40,6 @@
 	"fdt_board=eval-v3\0" \
 	"initrd_addr=0x83800000\0" \
 	"initrd_high=0xffffffffffffffff\0" \
-	"setup=setenv setupargs console=tty1 console=${console},${baudrate} " \
-		"consoleblank=0 earlycon\0" \
 	"update_uboot=askenv confirm Did you load flash.bin resp. u-boot-dtb.imx (y/N)?; " \
 		"if test \"$confirm\" = \"y\"; then " \
 		"setexpr blkcnt ${filesize} + 0x1ff && setexpr blkcnt " \
diff --git a/include/configs/colibri_imx6.h b/include/configs/colibri_imx6.h
index 4b2841833b5a..79e5b870b812 100644
--- a/include/configs/colibri_imx6.h
+++ b/include/configs/colibri_imx6.h
@@ -58,12 +58,9 @@
 
 #define CFG_EXTRA_ENV_SETTINGS \
 	BOOTENV \
-	"boot_file=zImage\0" \
 	"boot_script_dhcp=boot.scr\0" \
 	"console=ttymxc0\0" \
-	"defargs=enable_wait_mode=off galcore.contiguousSize=50331648\0" \
 	"fdt_board=eval-v3\0" \
-	"fdt_fixup=;\0" \
 	MEM_LAYOUT_ENV_SETTINGS \
 	UBOOT_UPDATE \
 	"setethupdate=if env exists ethaddr; then; else setenv ethaddr " \
@@ -72,16 +69,12 @@
 	"setsdupdate=setenv interface mmc; setenv drive 1; mmc rescan; load " \
 		"${interface} ${drive}:1 ${loadaddr} flash_blk.img && " \
 		"source ${loadaddr}\0" \
-	"setup=setenv setupargs fec_mac=${ethaddr} " \
-		"consoleblank=0 no_console_suspend=1 console=tty1 " \
-		"console=${console},${baudrate}n8\0 " \
 	"setupdate=run setsdupdate || run setusbupdate || run setethupdate\0" \
 	"setusbupdate=usb start && setenv interface usb; setenv drive 0; " \
 		"load ${interface} ${drive}:1 ${loadaddr} flash_blk.img && " \
 		"source ${loadaddr}\0" \
 	"splashpos=m,m\0" \
-	"splashimage=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
-	"vidargs=fbmem=8M\0"
+	"splashimage=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0"
 
 /* Miscellaneous configurable options */
 
diff --git a/include/configs/colibri_imx7.h b/include/configs/colibri_imx7.h
index 7a9f4afe7d17..c34f1f903df6 100644
--- a/include/configs/colibri_imx7.h
+++ b/include/configs/colibri_imx7.h
@@ -89,8 +89,8 @@
 	"ubiargs=ubi.mtd=ubi root=ubi0:rootfs rootfstype=ubifs " \
 		"ubi.fm_autoconvert=1\0" \
 	"ubiboot=run setup; " \
-		"setenv bootargs ${defargs} ${ubiargs} " \
-		"${setupargs} ${vidargs} ${tdxargs}; echo Booting from NAND...; " \
+		"setenv bootargs ${ubiargs} " \
+		"${setupargs} ${tdxargs}; echo Booting from NAND...; " \
 		"ubi part ubi && run m4boot && " \
 		"ubi read ${kernel_addr_r} kernel && " \
 		"ubi read ${fdt_addr_r} dtb && " \
@@ -123,15 +123,10 @@
 	MEM_LAYOUT_ENV_SETTINGS \
 	MODULE_EXTRA_ENV_SETTINGS \
 	UBOOT_UPDATE \
-	"boot_file=zImage\0" \
 	"boot_script_dhcp=boot.scr\0" \
 	"console=ttymxc0\0" \
-	"defargs=\0" \
 	"fdt_board=eval-v3\0" \
-	"fdt_fixup=;\0" \
 	"m4boot=;\0" \
-	"ip_dyn=yes\0" \
-	"kernel_file=zImage\0" \
 	"setethupdate=if env exists ethaddr; then; else setenv ethaddr " \
 		"00:14:2d:00:00:00; fi; tftpboot ${loadaddr} " \
 		"${board}/flash_eth.img && source ${loadaddr}\0" \
@@ -140,7 +135,7 @@
 		"${board}/flash_blk.img && source ${loadaddr}\0" \
 	"setup=setenv setupargs " \
 		"console=tty1 console=${console}" \
-		",${baudrate}n8 ${memargs} ${mtdparts} consoleblank=0\0" \
+		",${baudrate}n8 ${memargs} ${mtdparts}\0" \
 	"setupdate=run setsdupdate || run setusbupdate || run setethupdate\0" \
 	"setusbupdate=usb start && setenv interface usb && " \
 		"fatload ${interface} 0:1 ${loadaddr} " \
diff --git a/include/configs/verdin-imx8mm.h b/include/configs/verdin-imx8mm.h
index a7ea02807ddf..34238d3b505c 100644
--- a/include/configs/verdin-imx8mm.h
+++ b/include/configs/verdin-imx8mm.h
@@ -37,14 +37,11 @@
 #define CFG_EXTRA_ENV_SETTINGS \
 	BOOTENV \
 	MEM_LAYOUT_ENV_SETTINGS \
-	"boot_file=Image\0" \
 	"boot_script_dhcp=boot.scr\0" \
 	"console=ttymxc0\0" \
 	"fdt_board=dev\0" \
 	"initrd_addr=0x43800000\0" \
 	"initrd_high=0xffffffffffffffff\0" \
-	"setup=setenv setupargs console=tty1 console=${console},${baudrate} " \
-		"consoleblank=0 earlycon\0" \
 	"update_uboot=askenv confirm Did you load flash.bin (y/N)?; " \
 		"if test \"$confirm\" = \"y\"; then " \
 		"setexpr blkcnt ${filesize} + 0x1ff && setexpr blkcnt " \
diff --git a/include/configs/verdin-imx8mp.h b/include/configs/verdin-imx8mp.h
index 256bab089ffc..0b88e95603d5 100644
--- a/include/configs/verdin-imx8mp.h
+++ b/include/configs/verdin-imx8mp.h
@@ -13,7 +13,6 @@
 	(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
 
 #ifdef CONFIG_SPL_BUILD
-/*#define CONFIG_ENABLE_DDR_TRAINING_DEBUG*/
 
 /* malloc f used before GD_FLG_FULL_MALLOC_INIT set */
 #define CFG_MALLOC_F_ADDR				0x184000
@@ -40,15 +39,11 @@
 #define CFG_EXTRA_ENV_SETTINGS \
 	BOOTENV \
 	MEM_LAYOUT_ENV_SETTINGS \
-	"boot_file=Image\0" \
-	"boot_scripts=boot.scr\0" \
 	"boot_script_dhcp=boot.scr\0" \
 	"console=ttymxc2\0" \
 	"fdt_board=dev\0" \
 	"initrd_addr=0x43800000\0" \
 	"initrd_high=0xffffffffffffffff\0" \
-	"setup=setenv setupargs console=tty1 console=${console},${baudrate} " \
-		"consoleblank=0 earlycon\0" \
 	"update_uboot=askenv confirm Did you load flash.bin (y/N)?; " \
 		"if test \"$confirm\" = \"y\"; then " \
 		"setexpr blkcnt ${filesize} + 0x1ff && setexpr blkcnt " \
-- 
2.39.2

