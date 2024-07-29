Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 845C2C3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 20:45:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F156888861;
	Mon, 29 Jul 2024 22:45:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71A9088863; Mon, 29 Jul 2024 22:45:09 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46BC888791
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 22:45:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 80C041F00057
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 20:44:54 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id E58C9A1258F; Mon, 29 Jul 2024 20:44:53 +0000 (UTC)
Received: from localhost.localdomain (unknown [192.168.1.64])
 by laika.paulk.fr (Postfix) with ESMTP id E949BA12589;
 Mon, 29 Jul 2024 20:44:40 +0000 (UTC)
From: Paul Kocialkowski <paulk@sys-base.io>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 Sjoerd Simons <sjoerd.simons@collabora.co.uk>,
 Govindaraji Sivanantham <Govindaraji.Sivanantham@in.bosch.com>,
 Hiremath Gireesh <Gireesh.Hiremath@in.bosch.com>,
 Heiko Schocher <hs@denx.de>, Felix Brack <fb@ltec.ch>,
 Marcin Niestroj <m.niestroj@grinn-global.com>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH 2/3] am33xx: Use regular spl_board_init instead of
 am33xx_spl_board_init
Date: Mon, 29 Jul 2024 22:44:38 +0200
Message-ID: <20240729204439.429900-2-paulk@sys-base.io>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240729204439.429900-1-paulk@sys-base.io>
References: <20240729204439.429900-1-paulk@sys-base.io>
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

The am33xx_spl_board_init function was introduced as a way to add
board-specific SPL init for AM33xx devices since the spl_board_init
function was already used for SoC-specific init.

Now that the SoC-specific SPL init was moved to spl_soc_init, we can
use spl_board_init for this purpose and get rid of
am33xx_spl_board_init.

Rename the function in board files and enable the related config
option for concerned boards.

Signed-off-by: Paul Kocialkowski <paulk@sys-base.io>
---
 arch/arm/include/asm/arch-am33xx/sys_proto.h | 1 -
 arch/arm/mach-omap2/am33xx/board.c           | 8 --------
 arch/arm/mach-omap2/boot-common.c            | 3 ---
 board/BuR/brppt1/board.c                     | 2 +-
 board/BuR/brsmarc1/board.c                   | 2 +-
 board/BuR/brxre1/board.c                     | 2 +-
 board/bosch/guardian/board.c                 | 2 +-
 board/bosch/shc/board.c                      | 2 +-
 board/eets/pdu001/board.c                    | 6 +++---
 board/grinn/chiliboard/board.c               | 2 +-
 board/tcl/sl50/board.c                       | 2 +-
 board/vscom/baltos/board.c                   | 2 +-
 configs/am335x_baltos_defconfig              | 1 +
 configs/am335x_guardian_defconfig            | 1 +
 configs/am335x_pdu001_defconfig              | 1 +
 configs/am335x_shc_defconfig                 | 1 +
 configs/am335x_shc_ict_defconfig             | 1 +
 configs/am335x_shc_netboot_defconfig         | 1 +
 configs/am335x_shc_sdboot_defconfig          | 1 +
 configs/am335x_sl50_defconfig                | 1 +
 configs/brppt1_mmc_defconfig                 | 1 +
 configs/brsmarc1_defconfig                   | 1 +
 configs/brxre1_defconfig                     | 1 +
 configs/chiliboard_defconfig                 | 1 +
 24 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/arm/include/asm/arch-am33xx/sys_proto.h b/arch/arm/include/asm/arch-am33xx/sys_proto.h
index 513cdaca8593..7abcd1cb6156 100644
--- a/arch/arm/include/asm/arch-am33xx/sys_proto.h
+++ b/arch/arm/include/asm/arch-am33xx/sys_proto.h
@@ -37,7 +37,6 @@ u32 wait_on_value(u32, u32, void *, u32);
 #ifdef CONFIG_NOR_BOOT
 void enable_norboot_pin_mux(void);
 #endif
-void am33xx_spl_board_init(void);
 int am335x_get_efuse_mpu_max_freq(struct ctrl_dev *cdev);
 int am335x_get_mpu_vdd(int sil_rev, int frequency);
 int am335x_get_tps65910_mpu_vdd(int sil_rev, int frequency);
diff --git a/arch/arm/mach-omap2/am33xx/board.c b/arch/arm/mach-omap2/am33xx/board.c
index 84a60dedd729..abdc1e403351 100644
--- a/arch/arm/mach-omap2/am33xx/board.c
+++ b/arch/arm/mach-omap2/am33xx/board.c
@@ -337,14 +337,6 @@ int board_early_init_f(void)
 	return 0;
 }
 
-/*
- * This function is the place to do per-board things such as ramp up the
- * MPU clock frequency.
- */
-__weak void am33xx_spl_board_init(void)
-{
-}
-
 #if defined(CONFIG_SPL_AM33XX_ENABLE_RTC32K_OSC)
 static void rtc32k_enable(void)
 {
diff --git a/arch/arm/mach-omap2/boot-common.c b/arch/arm/mach-omap2/boot-common.c
index 21b204074e80..649bc07047ab 100644
--- a/arch/arm/mach-omap2/boot-common.c
+++ b/arch/arm/mach-omap2/boot-common.c
@@ -285,9 +285,6 @@ void spl_soc_init(void)
 #endif
 #if defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG)
 	hw_watchdog_init();
-#endif
-#ifdef CONFIG_AM33XX
-	am33xx_spl_board_init();
 #endif
 	if (IS_ENABLED(CONFIG_SPL_BUILD) &&
 	    IS_ENABLED(CONFIG_REMOTEPROC_TI_IPU))
diff --git a/board/BuR/brppt1/board.c b/board/BuR/brppt1/board.c
index 192a2fa6327b..80e0ca805b52 100644
--- a/board/BuR/brppt1/board.c
+++ b/board/BuR/brppt1/board.c
@@ -79,7 +79,7 @@ static const struct ctrl_ioregs ddr3_ioregs = {
 #define OSC	(V_OSCK/1000000)
 static const struct dpll_params dpll_ddr3 = { 400, OSC-1, 1, -1, -1, -1, -1};
 
-void am33xx_spl_board_init(void)
+void spl_board_init(void)
 {
 	int rc;
 
diff --git a/board/BuR/brsmarc1/board.c b/board/BuR/brsmarc1/board.c
index 2d3f593d0ab0..bfb6adf6d5c0 100644
--- a/board/BuR/brsmarc1/board.c
+++ b/board/BuR/brsmarc1/board.c
@@ -72,7 +72,7 @@ static const struct ctrl_ioregs ddr3_ioregs = {
 #define OSC	(V_OSCK / 1000000)
 const struct dpll_params dpll_ddr3 = { 400, OSC - 1, 1, -1, -1, -1, -1};
 
-void am33xx_spl_board_init(void)
+void spl_board_init(void)
 {
 	struct cm_perpll *const cmper = (struct cm_perpll *)CM_PER;
 	struct cm_wkuppll *const cmwkup = (struct cm_wkuppll *)CM_WKUP;
diff --git a/board/BuR/brxre1/board.c b/board/BuR/brxre1/board.c
index b9b595cb156d..510d2af31471 100644
--- a/board/BuR/brxre1/board.c
+++ b/board/BuR/brxre1/board.c
@@ -79,7 +79,7 @@ static const struct ctrl_ioregs ddr3_ioregs = {
 #define OSC	(V_OSCK / 1000000)
 const struct dpll_params dpll_ddr3 = { 400, OSC - 1, 1, -1, -1, -1, -1};
 
-void am33xx_spl_board_init(void)
+void spl_board_init(void)
 {
 	int rc;
 
diff --git a/board/bosch/guardian/board.c b/board/bosch/guardian/board.c
index 41d7567ad21e..33ba7a7751ce 100644
--- a/board/bosch/guardian/board.c
+++ b/board/bosch/guardian/board.c
@@ -75,7 +75,7 @@ static struct emif_regs ddr3_emif_reg_data = {
 const struct dpll_params dpll_ddr = {
 		400, OSC - 1, 1, -1, -1, -1, -1};
 
-void am33xx_spl_board_init(void)
+void spl_board_init(void)
 {
 	int mpu_vdd;
 	int usb_cur_lim;
diff --git a/board/bosch/shc/board.c b/board/bosch/shc/board.c
index ab688745938a..59628ce6f570 100644
--- a/board/bosch/shc/board.c
+++ b/board/bosch/shc/board.c
@@ -310,7 +310,7 @@ const struct dpll_params *get_dpll_ddr_params(void)
 const struct dpll_params dpll_mpu_shc_opp100 = {
 		99, MPUPLL_N, 1, -1, -1, -1, -1};
 
-void am33xx_spl_board_init(void)
+void spl_board_init(void)
 {
 	int sil_rev;
 	int mpu_vdd;
diff --git a/board/eets/pdu001/board.c b/board/eets/pdu001/board.c
index 2ad256f86357..00f9a5ef341b 100644
--- a/board/eets/pdu001/board.c
+++ b/board/eets/pdu001/board.c
@@ -56,10 +56,10 @@ DECLARE_GLOBAL_DATA_PTR;
  *  boot device save register
  * -------------------------
  * The boot device can be quired by 'spl_boot_device()' in
- * 'am33xx_spl_board_init'. However it can't be saved in the u-boot
+ * 'spl_board_init'. However it can't be saved in the u-boot
  * environment here. In turn 'spl_boot_device' can't be called in
  * 'board_late_init' which allows writing to u-boot environment.
- * To get the boot device from 'am33xx_spl_board_init' to
+ * To get the boot device from 'spl_board_init' to
  * 'board_late_init' we therefore use a scratch register from the RTC.
  */
 #define CFG_SYS_RTC_SCRATCH0 0x60
@@ -192,7 +192,7 @@ const struct dpll_params dpll_ddr_evm_sk = {
 const struct dpll_params dpll_ddr_bone_black = {
 		400, OSC - 1, 1, -1, -1, -1, -1};
 
-void am33xx_spl_board_init(void)
+void spl_board_init(void)
 {
 	struct ctrl_dev *cdev = (struct ctrl_dev *)CTRL_DEVICE_BASE;
 
diff --git a/board/grinn/chiliboard/board.c b/board/grinn/chiliboard/board.c
index 8313b37655fb..e0eb8aa9f2bc 100644
--- a/board/grinn/chiliboard/board.c
+++ b/board/grinn/chiliboard/board.c
@@ -80,7 +80,7 @@ void set_mux_conf_regs(void)
 	enable_board_pin_mux();
 }
 
-void am33xx_spl_board_init(void)
+void spl_board_init(void)
 {
 	chilisom_spl_board_init();
 }
diff --git a/board/tcl/sl50/board.c b/board/tcl/sl50/board.c
index 484b4e244281..6c60c70b7b48 100644
--- a/board/tcl/sl50/board.c
+++ b/board/tcl/sl50/board.c
@@ -92,7 +92,7 @@ int spl_start_uboot(void)
 const struct dpll_params dpll_ddr_sl50 = {
 		400, OSC-1, 1, -1, -1, -1, -1};
 
-void am33xx_spl_board_init(void)
+void spl_board_init(void)
 {
 	int mpu_vdd;
 
diff --git a/board/vscom/baltos/board.c b/board/vscom/baltos/board.c
index cea25f8c9005..f54f183038b8 100644
--- a/board/vscom/baltos/board.c
+++ b/board/vscom/baltos/board.c
@@ -177,7 +177,7 @@ const struct dpll_params dpll_ddr_evm_sk = {
 const struct dpll_params dpll_ddr_baltos = {
 		400, OSC-1, 1, -1, -1, -1, -1};
 
-void am33xx_spl_board_init(void)
+void spl_board_init(void)
 {
 	int sil_rev, mpu_vdd;
 	int freq;
diff --git a/configs/am335x_baltos_defconfig b/configs/am335x_baltos_defconfig
index 14d8d96a8656..3fcebc6aa7d4 100644
--- a/configs/am335x_baltos_defconfig
+++ b/configs/am335x_baltos_defconfig
@@ -17,6 +17,7 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOOTCOMMAND="run findfdt; run usbboot;run mmcboot;setenv mmcdev 1; setenv bootpart 1:2; run mmcboot;run nandboot;"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
+CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_FS_EXT4=y
diff --git a/configs/am335x_guardian_defconfig b/configs/am335x_guardian_defconfig
index 6b40d398392c..7c7041c23b08 100644
--- a/configs/am335x_guardian_defconfig
+++ b/configs/am335x_guardian_defconfig
@@ -29,6 +29,7 @@ CONFIG_AUTOBOOT_DELAY_STR="d"
 CONFIG_AUTOBOOT_STOP_STR=" "
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_ARCH_MISC_INIT=y
+CONFIG_SPL_BOARD_INIT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
diff --git a/configs/am335x_pdu001_defconfig b/configs/am335x_pdu001_defconfig
index f6b7d9c88ebd..a0163f16f369 100644
--- a/configs/am335x_pdu001_defconfig
+++ b/configs/am335x_pdu001_defconfig
@@ -22,6 +22,7 @@ CONFIG_AUTOBOOT_PROMPT="Press SPACE to abort autoboot in %d seconds\n"
 CONFIG_AUTOBOOT_STOP_STR=" "
 CONFIG_BOOTCOMMAND="run eval_boot_device;part uuid mmc ${mmc_boot}:${root_fs_partition} root_fs_partuuid;setenv bootargs console=${console} vt.global_cursor_default=0 root=PARTUUID=${root_fs_partuuid} rootfstype=ext4 rootwait rootdelay=1;fatload mmc ${mmc_boot} ${fdtaddr} ${fdtfile};fatload mmc ${mmc_boot} ${loadaddr} ${bootfile};bootz ${loadaddr} - ${fdtaddr}"
 CONFIG_BOARD_LATE_INIT=y
+CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is not set
diff --git a/configs/am335x_shc_defconfig b/configs/am335x_shc_defconfig
index f2cf35c4c331..8fb6e1a5a9bb 100644
--- a/configs/am335x_shc_defconfig
+++ b/configs/am335x_shc_defconfig
@@ -31,6 +31,7 @@ CONFIG_BOOTCOMMAND="if mmc dev 1; mmc rescan; then run emmc_setup; else echo ERR
 CONFIG_DEFAULT_FDT_FILE="am335x-shc"
 CONFIG_SYS_PBSIZE=1049
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
+CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
diff --git a/configs/am335x_shc_ict_defconfig b/configs/am335x_shc_ict_defconfig
index f30c2661100d..b9f5db23053d 100644
--- a/configs/am335x_shc_ict_defconfig
+++ b/configs/am335x_shc_ict_defconfig
@@ -29,6 +29,7 @@ CONFIG_BOOTCOMMAND="if mmc dev 0; mmc rescan; then run sd_setup; else echo ERROR
 CONFIG_DEFAULT_FDT_FILE="am335x-shc"
 CONFIG_SYS_PBSIZE=1049
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
+CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
diff --git a/configs/am335x_shc_netboot_defconfig b/configs/am335x_shc_netboot_defconfig
index e9262fdf3713..5c42bf423ff3 100644
--- a/configs/am335x_shc_netboot_defconfig
+++ b/configs/am335x_shc_netboot_defconfig
@@ -32,6 +32,7 @@ CONFIG_BOOTCOMMAND="run fusecmd; if run netboot; then echo Booting from network;
 CONFIG_DEFAULT_FDT_FILE="am335x-shc"
 CONFIG_SYS_PBSIZE=1049
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
+CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
diff --git a/configs/am335x_shc_sdboot_defconfig b/configs/am335x_shc_sdboot_defconfig
index 887b6aa6feb9..9375bc93a2f9 100644
--- a/configs/am335x_shc_sdboot_defconfig
+++ b/configs/am335x_shc_sdboot_defconfig
@@ -32,6 +32,7 @@ CONFIG_BOOTCOMMAND="if mmc dev 0; mmc rescan; then run sd_setup; else echo ERROR
 CONFIG_DEFAULT_FDT_FILE="am335x-shc"
 CONFIG_SYS_PBSIZE=1049
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
+CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
diff --git a/configs/am335x_sl50_defconfig b/configs/am335x_sl50_defconfig
index 3e539c8d54e4..894a59f58eda 100644
--- a/configs/am335x_sl50_defconfig
+++ b/configs/am335x_sl50_defconfig
@@ -22,6 +22,7 @@ CONFIG_AUTOBOOT_PROMPT="Press SPACE to abort autoboot in %d seconds\n"
 CONFIG_AUTOBOOT_DELAY_STR="d"
 CONFIG_AUTOBOOT_STOP_STR=" "
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
+CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_ENV_SUPPORT=y
diff --git a/configs/brppt1_mmc_defconfig b/configs/brppt1_mmc_defconfig
index 09e061350bc8..8947b76e11f2 100644
--- a/configs/brppt1_mmc_defconfig
+++ b/configs/brppt1_mmc_defconfig
@@ -37,6 +37,7 @@ CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_ARCH_MISC_INIT=y
+CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
diff --git a/configs/brsmarc1_defconfig b/configs/brsmarc1_defconfig
index 5ec55f34f697..dc868b72b213 100644
--- a/configs/brsmarc1_defconfig
+++ b/configs/brsmarc1_defconfig
@@ -37,6 +37,7 @@ CONFIG_BOARD_TYPES=y
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_ARCH_MISC_INIT=y
+CONFIG_SPL_BOARD_INIT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_SYS_MALLOC=y
diff --git a/configs/brxre1_defconfig b/configs/brxre1_defconfig
index 0663a597847a..fc801f267401 100644
--- a/configs/brxre1_defconfig
+++ b/configs/brxre1_defconfig
@@ -33,6 +33,7 @@ CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_ARCH_MISC_INIT=y
+CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
diff --git a/configs/chiliboard_defconfig b/configs/chiliboard_defconfig
index 25e162e938e3..98778989761d 100644
--- a/configs/chiliboard_defconfig
+++ b/configs/chiliboard_defconfig
@@ -22,6 +22,7 @@ CONFIG_BOOTCOMMAND="run mmcboot; run nandboot; run netboot"
 CONFIG_DEFAULT_FDT_FILE="am335x-chiliboard.dtb"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_ARCH_MISC_INIT=y
+CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_I2C=y
-- 
2.45.2

