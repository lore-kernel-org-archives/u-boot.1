Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04323C47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 17:44:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 819AC87BB5;
	Wed, 17 Jan 2024 18:43:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F00C587947; Wed, 17 Jan 2024 18:43:14 +0100 (CET)
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch
 [185.125.25.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24E1F87A4B
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 18:43:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
 by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TFYBN59cxzMq990;
 Wed, 17 Jan 2024 17:43:08 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4TFYBM74WDz3f; Wed, 17 Jan 2024 18:43:07 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de,
 Heiko Stuebner <heiko@sntech.de>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: [PATCH v3 3/6] rockchip: ringneck-px30/puma-rk3399: factor out
 storage medium selection
Date: Wed, 17 Jan 2024 18:42:50 +0100
Message-ID: <20240117-env_default_theobroma-v3-3-316c25a6733f@theobroma-systems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240117-env_default_theobroma-v3-0-316c25a6733f@theobroma-systems.com>
References: <20240117-env_default_theobroma-v3-0-316c25a6733f@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Ringneck PX30 and Puma RK3399 both have the same expectation with regard
to bootstd device order and U-Boot environment storage device, except
that Puma RK3399 also supports SPI Flash.

Let's move all of this into a common file where common logic can be put.

Cc: Quentin Schulz <foss+uboot@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 .../{puma_rk3399/puma-rk3399.c => common/common.c} |  64 +-----
 board/theobroma-systems/common/common.h            |  19 ++
 board/theobroma-systems/puma_rk3399/MAINTAINERS    |   1 +
 board/theobroma-systems/puma_rk3399/Makefile       |   3 +
 board/theobroma-systems/ringneck_px30/MAINTAINERS  |   1 +
 board/theobroma-systems/ringneck_px30/Makefile     |   3 +
 .../ringneck_px30/ringneck-px30.c                  | 237 ---------------------
 7 files changed, 30 insertions(+), 298 deletions(-)

diff --git a/board/theobroma-systems/puma_rk3399/puma-rk3399.c b/board/theobroma-systems/common/common.c
similarity index 72%
rename from board/theobroma-systems/puma_rk3399/puma-rk3399.c
rename to board/theobroma-systems/common/common.c
index b8b718da243..eb21d4c4550 100644
--- a/board/theobroma-systems/puma_rk3399/puma-rk3399.c
+++ b/board/theobroma-systems/common/common.c
@@ -1,44 +1,12 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * (C) Copyright 2017 Theobroma Systems Design und Consulting GmbH
  */
 
-#include <common.h>
 #include <dm.h>
 #include <env.h>
 #include <env_internal.h>
-#include <init.h>
-#include <log.h>
-#include <misc.h>
-#include <spl.h>
-#include <syscon.h>
-#include <u-boot/crc.h>
-#include <usb.h>
-#include <dm/pinctrl.h>
 #include <dm/uclass-internal.h>
-#include <asm/io.h>
-#include <asm/setup.h>
-#include <asm/arch-rockchip/clock.h>
-#include <asm/arch-rockchip/hardware.h>
-#include <asm/arch-rockchip/grf_rk3399.h>
-#include <asm/arch-rockchip/periph.h>
-#include <asm/arch-rockchip/misc.h>
-#include <power/regulator.h>
-#include <u-boot/sha256.h>
-
-static void setup_iodomain(void)
-{
-	const u32 GRF_IO_VSEL_GPIO4CD_SHIFT = 3;
-	struct rk3399_grf_regs *grf =
-	    syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
-
-	/*
-	 * Set bit 3 in GRF_IO_VSEL so PCIE_RST# works (pin GPIO4_C6).
-	 * Linux assumes that PCIE_RST# works out of the box as it probes
-	 * PCIe before loading the iodomain driver.
-	 */
-	rk_setreg(&grf->io_vsel, 1 << GRF_IO_VSEL_GPIO4CD_SHIFT);
-}
 
 /*
  * Swap mmc0 and mmc1 in boot_targets if booted from SD-Card.
@@ -49,7 +17,7 @@ static void setup_iodomain(void)
  * user has set. We exit early if a changed boot_targets environment
  * is detected.
  */
-static int setup_boottargets(void)
+int setup_boottargets(void)
 {
 	const char *boot_device =
 		ofnode_read_chosen_string("u-boot,spl-boot-device");
@@ -172,34 +140,8 @@ enum env_location arch_env_get_location(enum env_operation op, int prio)
 	    !uclass_find_device_by_ofnode(UCLASS_MMC, ofnode_path(boot_device), &devp))
 		return ENVL_MMC;
 
-	printf("%s: No environment available: booted from %s but U-Boot "
-	       "config does not allow loading environment from it.",
+	printf("%s: No environment available: booted from %s but U-Boot config does not allow loading environment from it.",
 	       __func__, boot_device);
 
 	return ENVL_NOWHERE;
 }
-
-int misc_init_r(void)
-{
-	const u32 cpuid_offset = 0x7;
-	const u32 cpuid_length = 0x10;
-	u8 cpuid[cpuid_length];
-	int ret;
-
-	ret = rockchip_cpuid_from_efuse(cpuid_offset, cpuid_length, cpuid);
-	if (ret)
-		return ret;
-
-	ret = rockchip_cpuid_set(cpuid, cpuid_length);
-	if (ret)
-		return ret;
-
-	ret = rockchip_setup_macaddr();
-	if (ret)
-		return ret;
-
-	setup_iodomain();
-	setup_boottargets();
-
-	return 0;
-}
diff --git a/board/theobroma-systems/common/common.h b/board/theobroma-systems/common/common.h
new file mode 100644
index 00000000000..488313a2d86
--- /dev/null
+++ b/board/theobroma-systems/common/common.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * (C) Copyright 2023 Theobroma Systems Design und Consulting GmbH
+ */
+
+/*
+ * setup_boottargets() - Swap mmc0 and mmc1 in boot_targets depending on U-Boot
+ * proper load medium.
+ *
+ * If bootsource is uSD-card we can assume that we want to use the
+ * SD-Card instead of the eMMC as first boot_target for distroboot.
+ * We only want to swap the defaults and not any custom environment a
+ * user has set. We exit early if a changed boot_targets environment
+ * is detected.
+ *
+ * Return:
+ * 0 if OK, -1 otherwise
+ */
+int setup_boottargets(void);
diff --git a/board/theobroma-systems/puma_rk3399/MAINTAINERS b/board/theobroma-systems/puma_rk3399/MAINTAINERS
index 1ec2dd72d6c..93f570fc4f9 100644
--- a/board/theobroma-systems/puma_rk3399/MAINTAINERS
+++ b/board/theobroma-systems/puma_rk3399/MAINTAINERS
@@ -3,6 +3,7 @@ M:	Quentin Schulz <quentin.schulz@theobroma-systems.com>
 M:	Klaus Goger <klaus.goger@theobroma-systems.com>
 S:	Maintained
 F:	board/theobroma-systems/puma_rk3399
+F:	board/theobroma-systems/common
 F:	include/configs/puma_rk3399.h
 F:	arch/arm/dts/rk3399-puma.dts
 F:	configs/puma-rk3399_defconfig
diff --git a/board/theobroma-systems/puma_rk3399/Makefile b/board/theobroma-systems/puma_rk3399/Makefile
index d962b56f111..edd61a35c1e 100644
--- a/board/theobroma-systems/puma_rk3399/Makefile
+++ b/board/theobroma-systems/puma_rk3399/Makefile
@@ -5,3 +5,6 @@
 #
 
 obj-y	+= puma-rk3399.o
+ifneq ($(CONFIG_SPL_BUILD),y)
+obj-y	+= ../common/common.o
+endif
diff --git a/board/theobroma-systems/ringneck_px30/MAINTAINERS b/board/theobroma-systems/ringneck_px30/MAINTAINERS
index d764e26066c..06e1beaab14 100644
--- a/board/theobroma-systems/ringneck_px30/MAINTAINERS
+++ b/board/theobroma-systems/ringneck_px30/MAINTAINERS
@@ -3,6 +3,7 @@ M:	Quentin Schulz <quentin.schulz@theobroma-systems.com>
 M:	Klaus Goger <klaus.goger@theobroma-systems.com>
 S:	Maintained
 F:	board/theobroma-systems/ringneck_px30
+F:	board/theobroma-systems/common
 F:	include/configs/ringneck_px30.h
 F:	arch/arm/dts/px30-ringneck*
 F:	configs/ringneck-px30_defconfig
diff --git a/board/theobroma-systems/ringneck_px30/Makefile b/board/theobroma-systems/ringneck_px30/Makefile
index 31ada1a6942..45cc65baf9a 100644
--- a/board/theobroma-systems/ringneck_px30/Makefile
+++ b/board/theobroma-systems/ringneck_px30/Makefile
@@ -5,3 +5,6 @@
 #
 
 obj-y	+= ringneck-px30.o
+ifneq ($(CONFIG_SPL_BUILD),y)
+obj-y	+= ../common/common.o
+endif
diff --git a/board/theobroma-systems/ringneck_px30/ringneck-px30.c b/board/theobroma-systems/ringneck_px30/ringneck-px30.c
deleted file mode 100644
index 5d2c76ab902..00000000000
--- a/board/theobroma-systems/ringneck_px30/ringneck-px30.c
+++ /dev/null
@@ -1,237 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * (C) Copyright 2022 Theobroma Systems Design und Consulting GmbH
- */
-
-#include <common.h>
-#include <dm.h>
-#include <env.h>
-#include <env_internal.h>
-#include <init.h>
-#include <log.h>
-#include <misc.h>
-#include <spl.h>
-#include <syscon.h>
-#include <u-boot/crc.h>
-#include <usb.h>
-#include <dm/pinctrl.h>
-#include <dm/uclass-internal.h>
-#include <asm/gpio.h>
-#include <asm/io.h>
-#include <asm/setup.h>
-#include <asm/arch-rockchip/clock.h>
-#include <asm/arch-rockchip/hardware.h>
-#include <asm/arch-rockchip/periph.h>
-#include <asm/arch-rockchip/misc.h>
-#include <linux/delay.h>
-#include <power/regulator.h>
-#include <u-boot/sha256.h>
-
-/*
- * Swap mmc0 and mmc1 in boot_targets if booted from SD-Card.
- *
- * If bootsource is uSD-card we can assume that we want to use the
- * SD-Card instead of the eMMC as first boot_target for distroboot.
- * We only want to swap the defaults and not any custom environment a
- * user has set. We exit early if a changed boot_targets environment
- * is detected.
- */
-static int setup_boottargets(void)
-{
-	const char *boot_device =
-		ofnode_read_chosen_string("u-boot,spl-boot-device");
-	char *env_default, *env;
-
-	if (!boot_device) {
-		debug("%s: /chosen/u-boot,spl-boot-device not set\n",
-		      __func__);
-		return -1;
-	}
-	debug("%s: booted from %s\n", __func__, boot_device);
-
-	env_default = env_get_default("boot_targets");
-	env = env_get("boot_targets");
-	if (!env) {
-		debug("%s: boot_targets does not exist\n", __func__);
-		return -1;
-	}
-	debug("%s: boot_targets current: %s - default: %s\n",
-	      __func__, env, env_default);
-
-	if (strcmp(env_default, env) != 0) {
-		debug("%s: boot_targets not default, don't change it\n",
-		      __func__);
-		return 0;
-	}
-
-	/*
-	 * Make the default boot medium between SD Card and eMMC, the one that
-	 * was used to load U-Boot proper.
-	 */
-	struct udevice *devp;
-
-	if (uclass_find_device_by_ofnode(UCLASS_MMC, ofnode_path(boot_device), &devp)) {
-		debug("%s: not reordering boot_targets, bootdev %s != MMC\n",
-		      __func__, boot_device);
-		return 0;
-	}
-
-	char *mmc0, *mmc1;
-
-	mmc0 = strstr(env, "mmc0");
-	mmc1 = strstr(env, "mmc1");
-
-	if (!mmc0 || !mmc1) {
-		debug("%s: only one mmc boot_target found\n", __func__);
-		return -1;
-	}
-
-	/*
-	 * If mmc0 comes first in the boot order and U-Boot proper was
-	 * loaded from mmc1, swap mmc0 and mmc1 in the list.
-	 * If mmc1 comes first in the boot order and U-Boot proper was
-	 * loaded from mmc0, swap mmc0 and mmc1 in the list.
-	 */
-	if ((mmc0 < mmc1 && devp->seq_ == 1) ||
-	    (mmc0 > mmc1 && devp->seq_ == 0)) {
-		mmc0[3] = '1';
-		mmc1[3] = '0';
-		debug("%s: set boot_targets to: %s\n", __func__, env);
-		env_set("boot_targets", env);
-	}
-
-	return 0;
-}
-
-int mmc_get_env_dev(void)
-{
-	const char *boot_device =
-		ofnode_read_chosen_string("u-boot,spl-boot-device");
-	struct udevice *devp;
-
-	if (!boot_device) {
-		debug("%s: /chosen/u-boot,spl-boot-device not set\n",
-		      __func__);
-#ifdef CONFIG_SYS_MMC_ENV_DEV
-		return CONFIG_SYS_MMC_ENV_DEV;
-#else
-		return 0;
-#endif
-	}
-
-	debug("%s: booted from %s\n", __func__, boot_device);
-
-	if (uclass_find_device_by_ofnode(UCLASS_MMC, ofnode_path(boot_device), &devp))
-#ifdef CONFIG_SYS_MMC_ENV_DEV
-		return CONFIG_SYS_MMC_ENV_DEV;
-#else
-		return 0;
-#endif
-
-	debug("%s: get MMC ENV from mmc%d\n", __func__, devp->seq_);
-
-	return devp->seq_;
-}
-
-enum env_location arch_env_get_location(enum env_operation op, int prio)
-{
-	const char *boot_device =
-		ofnode_read_chosen_string("u-boot,spl-boot-device");
-	struct udevice *devp;
-
-	if (prio > 0)
-		return ENVL_UNKNOWN;
-
-	if (!boot_device) {
-		debug("%s: /chosen/u-boot,spl-boot-device not set\n",
-		      __func__);
-		return ENVL_NOWHERE;
-	}
-
-	debug("%s: booted from %s\n", __func__, boot_device);
-
-	if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC) &&
-	    !uclass_find_device_by_ofnode(UCLASS_MMC, ofnode_path(boot_device), &devp))
-		return ENVL_MMC;
-
-	printf("%s: No environment available: booted from %s but U-Boot "
-	       "config does not allow loading environment from it.",
-	       __func__, boot_device);
-
-	return ENVL_NOWHERE;
-}
-
-int misc_init_r(void)
-{
-	const u32 cpuid_offset = 0x7;
-	const u32 cpuid_length = 0x10;
-	u8 cpuid[cpuid_length];
-	int ret;
-
-	ret = rockchip_cpuid_from_efuse(cpuid_offset, cpuid_length, cpuid);
-	if (ret)
-		return ret;
-
-	ret = rockchip_cpuid_set(cpuid, cpuid_length);
-	if (ret)
-		return ret;
-
-	ret = rockchip_setup_macaddr();
-	if (ret)
-		return ret;
-
-	setup_boottargets();
-
-	return 0;
-}
-
-#define STM32_RST	100 /* GPIO3_A4 */
-#define STM32_BOOT	101 /* GPIO3_A5 */
-
-void spl_board_init(void)
-{
-	/*
-	 * Glitches on STM32_BOOT and STM32_RST lines during poweroff or power
-	 * on may put the STM32 companion microcontroller into DFU mode, let's
-	 * always reset it into normal mode instead.
-	 * Toggling the STM32_RST line is safe to do with the ATtiny companion
-	 * microcontroller variant because it will not trigger an MCU reset
-	 * since only a UPDI reset command will. Since a UPDI reset is difficult
-	 * to mistakenly trigger, glitches to the lines are theoretically also
-	 * incapable of triggering an actual ATtiny reset.
-	 */
-	int ret;
-
-	ret = gpio_request(STM32_RST, "STM32_RST");
-	if (ret) {
-		debug("Failed to request STM32_RST\n");
-		return;
-	}
-
-	ret = gpio_request(STM32_BOOT, "STM32_BOOT");
-	if (ret) {
-		debug("Failed to request STM32_BOOT\n");
-		return;
-	}
-
-	/* Rely on HW pull-down for inactive level */
-	ret = gpio_direction_input(STM32_BOOT);
-	if (ret) {
-		debug("Failed to configure STM32_BOOT as input\n");
-		return;
-	}
-
-	ret = gpio_direction_output(STM32_RST, 0);
-	if (ret) {
-		debug("Failed to configure STM32_RST as output low\n");
-		return;
-	}
-
-	mdelay(1);
-
-	ret = gpio_direction_output(STM32_RST, 1);
-	if (ret) {
-		debug("Failed to configure STM32_RST as output high\n");
-		return;
-	}
-}

-- 
2.43.0

