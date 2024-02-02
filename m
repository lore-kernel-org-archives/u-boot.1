Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3FF8C4828F
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 00:12:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0E4987D59;
	Fri,  2 Feb 2024 01:12:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="cDcNFY+g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5548387073; Fri,  2 Feb 2024 01:12:43 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 675CF87D59
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 01:12:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ad07=JL=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1706832752;
 bh=sc0V2N1qM6R3+3tDhg5S7wU86m8ckbDJ0kBXABLRr10=;
 b=cDcNFY+g9FoFO7VdwxC2Rf7xHZi1Kvqv+mFf4XbCDbBVTpGgCng1LD5WAjmyhs+MP7fGXCce5
 /jdgkGc2jebNw8Z9SsGV9K/r2pxD8GmNX9Bc2FuhyfXRKfweTp9Xry5JzzZ+oMbxN4+7JS02FFj
 dCALC2AOTC8QXiDdqOawGLle2BLuWBaaUaiQWfk8e8OM0jXf+c16tnmVpl/KY0XarXUO9hvp/Gq
 CCi1LqjfQWelKKDt2DEIL5lEF0jAEZT7wN53Hvu7HRNjpAV/z6QmezM/RrfZusWxgxfc8lOc6l2
 K1nt4mcGdVwCKjZileYBiIyF8fkBYUe3WoCm3ZoQ1sMw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [RFC] rockchip: Reset to bootrom download mode on hang
Date: Fri,  2 Feb 2024 00:12:18 +0000
Message-ID: <20240202001221.531207-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65bc336fb6304ca20eda0046
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

Add support to reset to bootrom download mode on hang in U-Boot SPL and
proper. ROCKCHIP_HANG_TO_BROM can be used to enable this feature.

Example when SPL cannot load FIT:

  U-Boot SPL 2024.04-rc1 (Feb 01 2024 - 23:01:12 +0000)
  Trying to boot from MMC1
  mmc_load_image_raw_sector: mmc block read error
  Trying to boot from MMC2
  Card did not respond to voltage select! : -110
  spl: mmc init failed with error: -95
  Trying to boot from MMC1
  mmc_load_image_raw_sector: mmc block read error
  SPL: failed to boot from all boot devices
  ### ERROR ### Please RESET the board ###
  entering download mode ...
  resetting ...

Procedure to start bootrom download mode:
- U-Boot SPL or proper write 0xEF08A53C to BOOT_MODE_REG and then reset
- Bootrom loads and run boot code (TPL) from e.g. SPI > eMMC > SD-card
- TPL check for 0xEF08A53C in BOOT_MODE_REG very early, i.e. Rockchip
  TPL blobs check for this value directly at start
- TPL return to bootrom with a return value != 0
- Bootrom enter download mode

This also fixes an issue where the BOOT_MODE_REG is reset to 0 when
board is reset on RK35xx after TF-A has been loaded. To fix this the
SOC_CON1 reg value is reset prior to issuing a global reset.

The RK356x TF-A blobs will clear SOC_CON1 as part of a PSCI reset,
however the RK3588 TF-A blobs does not seem to clear SOC_CON1.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
- Is reset to bootrom download mode on hang a feature of intereset to
  anyone else?
- How can we best handle the issue with BOOT_MODE_REG being reset?
- Should we instead enable SYSRESET_PSCI and relay on TF-A to properly
  reset without loosing value in BOOT_MODE_REG? Currently works on
  RK356x bl31 blobs but not on the RK3588 bl31 blobs.
---
 arch/arm/mach-rockchip/Kconfig     |  9 +++++++
 arch/arm/mach-rockchip/Makefile    |  9 ++++---
 arch/arm/mach-rockchip/boot_mode.c | 38 ++++++++++++++++++++++++++----
 configs/generic-rk3568_defconfig   |  1 +
 configs/generic-rk3588_defconfig   |  1 +
 5 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 6ff0aa6911e2..66556d30af27 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -508,6 +508,15 @@ config TPL_ROCKCHIP_EARLYRETURN_TO_BROM
 	  This enables support code in the BOOT0 hook for the TPL stage
 	  to allow multiple entries.
 
+config ROCKCHIP_HANG_TO_BROM
+	bool "Reset to bootrom download mode on hang"
+	select SHOW_BOOT_PROGRESS
+
+config SPL_ROCKCHIP_HANG_TO_BROM
+	bool "Reset to bootrom download mode on hang in SPL"
+	default y if ROCKCHIP_HANG_TO_BROM
+	select SPL_SHOW_BOOT_PROGRESS
+
 config SPL_MMC
 	default y if !SPL_ROCKCHIP_BACK_TO_BROM
 
diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
index 1dc92066bbf3..ab4446bb6b51 100644
--- a/arch/arm/mach-rockchip/Makefile
+++ b/arch/arm/mach-rockchip/Makefile
@@ -16,17 +16,16 @@ obj-tpl-$(CONFIG_ROCKCHIP_PX30) += px30-board-tpl.o
 obj-spl-$(CONFIG_ROCKCHIP_RK3036) += rk3036-board-spl.o
 
 ifeq ($(CONFIG_SPL_BUILD)$(CONFIG_TPL_BUILD),)
+obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) += board.o
+obj-$(CONFIG_MISC_INIT_R) += misc.o
+endif
 
+ifeq ($(CONFIG_TPL_BUILD),)
 # Always include boot_mode.o, as we bypass it (i.e. turn it off)
 # inside of boot_mode.c when CONFIG_ROCKCHIP_BOOT_MODE_REG is 0.  This way,
 # we can have the preprocessor correctly recognise both 0x0 and 0
 # meaning "turn it off".
 obj-y += boot_mode.o
-obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) += board.o
-obj-$(CONFIG_MISC_INIT_R) += misc.o
-endif
-
-ifeq ($(CONFIG_TPL_BUILD),)
 obj-$(CONFIG_DISPLAY_CPUINFO) += cpu-info.o
 endif
 
diff --git a/arch/arm/mach-rockchip/boot_mode.c b/arch/arm/mach-rockchip/boot_mode.c
index eb8f65ae4e9d..de9ec1414926 100644
--- a/arch/arm/mach-rockchip/boot_mode.c
+++ b/arch/arm/mach-rockchip/boot_mode.c
@@ -5,6 +5,7 @@
 
 #include <common.h>
 #include <adc.h>
+#include <bootstage.h>
 #include <command.h>
 #include <env.h>
 #include <log.h>
@@ -23,11 +24,31 @@ int setup_boot_mode(void)
 
 #else
 
-void set_back_to_bootrom_dnl_flag(void)
+static void set_back_to_bootrom_dnl_flag(void)
 {
+	/*
+	 * These SOC_CON1 regs needs to be cleared before a reset or the
+	 * BOOT_MODE_REG do not retain its value and it is not possible
+	 * to reset to bootrom download mode once TF-A has been started.
+	 *
+	 * TF-A blobs for RK3568 already clear SOC_CON1 for PSCI reset.
+	 * However, the TF-A blobs for RK3588 does not clear SOC_CON1.
+	 */
+	if (IS_ENABLED(CONFIG_ROCKCHIP_RK3568))
+		writel(0x40000, 0xFDC20104);
+	if (IS_ENABLED(CONFIG_ROCKCHIP_RK3588))
+		writel(0xFFFF0000, 0xFD58A004);
+
 	writel(BOOT_BROM_DOWNLOAD, CONFIG_ROCKCHIP_BOOT_MODE_REG);
 }
 
+static void rockchip_reset_to_dnl_mode(void)
+{
+	puts("entering download mode ...\n");
+	set_back_to_bootrom_dnl_flag();
+	do_reset(NULL, 0, 0, NULL);
+}
+
 /*
  * detect download key status by adc, most rockchip
  * based boards use adc sample the download key status,
@@ -71,12 +92,19 @@ __weak int rockchip_dnl_key_pressed(void)
 		return false;
 }
 
-void rockchip_dnl_mode_check(void)
+#if CONFIG_IS_ENABLED(ROCKCHIP_HANG_TO_BROM)
+void show_boot_progress(int val)
+{
+	if (val == -BOOTSTAGE_ID_NEED_RESET)
+		rockchip_reset_to_dnl_mode();
+}
+#endif
+
+static void rockchip_dnl_mode_check(void)
 {
 	if (rockchip_dnl_key_pressed()) {
-		printf("download key pressed, entering download mode...");
-		set_back_to_bootrom_dnl_flag();
-		do_reset(NULL, 0, 0, NULL);
+		puts("download key pressed, ");
+		rockchip_reset_to_dnl_mode();
 	}
 }
 
diff --git a/configs/generic-rk3568_defconfig b/configs/generic-rk3568_defconfig
index b90ecb643dc7..9edd4c33000e 100644
--- a/configs/generic-rk3568_defconfig
+++ b/configs/generic-rk3568_defconfig
@@ -11,6 +11,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
 CONFIG_DEFAULT_DEVICE_TREE="rk3568-generic"
 CONFIG_ROCKCHIP_RK3568=y
 CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
+CONFIG_ROCKCHIP_HANG_TO_BROM=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_STACK_R_ADDR=0x600000
 CONFIG_SPL_STACK=0x400000
diff --git a/configs/generic-rk3588_defconfig b/configs/generic-rk3588_defconfig
index a9329eb1c625..5872bd4802c5 100644
--- a/configs/generic-rk3588_defconfig
+++ b/configs/generic-rk3588_defconfig
@@ -11,6 +11,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
 CONFIG_DEFAULT_DEVICE_TREE="rk3588-generic"
 CONFIG_ROCKCHIP_RK3588=y
 CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
+CONFIG_ROCKCHIP_HANG_TO_BROM=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_STACK_R_ADDR=0x600000
 CONFIG_TARGET_EVB_RK3588=y
-- 
2.43.0

