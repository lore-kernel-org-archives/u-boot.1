Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79AD2C5AD4C
	for <u-boot@archiver.kernel.org>; Thu, 23 Nov 2023 15:11:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E59F18768C;
	Thu, 23 Nov 2023 16:10:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DABF8767A; Thu, 23 Nov 2023 16:10:32 +0100 (CET)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::224])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4A5287657
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 16:10:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=foss+uboot@0leil.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8B966E000A;
 Thu, 23 Nov 2023 15:10:27 +0000 (UTC)
From: Quentin Schulz <foss+uboot@0leil.net>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de,
 Heiko Stuebner <heiko@sntech.de>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: [PATCH next v2 3/6] rockchip: ringneck-px30/puma-rk3399: factor out
 storage medium selection
Date: Thu, 23 Nov 2023 16:10:07 +0100
Message-ID: <20231123-env_default_theobroma-v2-3-a80914c2c114@theobroma-systems.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231123-env_default_theobroma-v2-0-a80914c2c114@theobroma-systems.com>
References: <20231123-env_default_theobroma-v2-0-a80914c2c114@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit
X-GND-Sasl: foss@0leil.net
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
 board/theobroma-systems/common/common.c            | 139 +++++++++++++++++++
 board/theobroma-systems/common/common.h            |  19 +++
 board/theobroma-systems/puma_rk3399/MAINTAINERS    |   1 +
 board/theobroma-systems/puma_rk3399/Makefile       |   3 +
 board/theobroma-systems/puma_rk3399/puma-rk3399.c  | 146 +-------------------
 board/theobroma-systems/ringneck_px30/MAINTAINERS  |   1 +
 board/theobroma-systems/ringneck_px30/Makefile     |   3 +
 .../ringneck_px30/ringneck-px30.c                  | 147 +--------------------
 8 files changed, 168 insertions(+), 291 deletions(-)

diff --git a/board/theobroma-systems/common/common.c b/board/theobroma-systems/common/common.c
new file mode 100644
index 00000000000..f4b854554ea
--- /dev/null
+++ b/board/theobroma-systems/common/common.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2017 Theobroma Systems Design und Consulting GmbH
+ */
+
+#include <dm.h>
+#include <env.h>
+#include <env_internal.h>
+#include <dm/uclass-internal.h>
+
+/*
+ * Swap mmc0 and mmc1 in boot_targets if booted from SD-Card.
+ *
+ * If bootsource is uSD-card we can assume that we want to use the
+ * SD-Card instead of the eMMC as first boot_target for distroboot.
+ * We only want to swap the defaults and not any custom environment a
+ * user has set. We exit early if a changed boot_targets environment
+ * is detected.
+ */
+int setup_boottargets(void)
+{
+	const char *boot_device =
+		ofnode_read_chosen_string("u-boot,spl-boot-device");
+	char *env_default, *env;
+
+	if (!boot_device) {
+		debug("%s: /chosen/u-boot,spl-boot-device not set\n",
+		      __func__);
+		return -1;
+	}
+	debug("%s: booted from %s\n", __func__, boot_device);
+
+	env_default = env_get_default("boot_targets");
+	env = env_get("boot_targets");
+	if (!env) {
+		debug("%s: boot_targets does not exist\n", __func__);
+		return -1;
+	}
+	debug("%s: boot_targets current: %s - default: %s\n",
+	      __func__, env, env_default);
+
+	if (strcmp(env_default, env) != 0) {
+		debug("%s: boot_targets not default, don't change it\n",
+		      __func__);
+		return 0;
+	}
+
+	/*
+	 * Make the default boot medium between SD Card and eMMC, the one that
+	 * was used to load U-Boot proper. If SPI-NOR flash was used, keep
+	 * original default order.
+	 */
+	struct udevice *devp;
+
+	if (uclass_find_device_by_ofnode(UCLASS_MMC, ofnode_path(boot_device), &devp)) {
+		debug("%s: not reordering boot_targets, bootdev %s != MMC\n",
+		      __func__, boot_device);
+		return 0;
+	}
+
+	char *mmc0, *mmc1;
+
+	mmc0 = strstr(env, "mmc0");
+	mmc1 = strstr(env, "mmc1");
+
+	if (!mmc0 || !mmc1) {
+		debug("%s: only one mmc boot_target found\n", __func__);
+		return -1;
+	}
+
+	/*
+	 * If mmc0 comes first in the boot order and U-Boot proper was
+	 * loaded from mmc1, swap mmc0 and mmc1 in the list.
+	 * If mmc1 comes first in the boot order and U-Boot proper was
+	 * loaded from mmc0, swap mmc0 and mmc1 in the list.
+	 */
+	if ((mmc0 < mmc1 && devp->seq_ == 1) ||
+	    (mmc0 > mmc1 && devp->seq_ == 0)) {
+		mmc0[3] = '1';
+		mmc1[3] = '0';
+		debug("%s: set boot_targets to: %s\n", __func__, env);
+		env_set("boot_targets", env);
+	}
+
+	return 0;
+}
+
+int mmc_get_env_dev(void)
+{
+	const char *boot_device =
+		ofnode_read_chosen_string("u-boot,spl-boot-device");
+	struct udevice *devp;
+
+	if (!boot_device) {
+		debug("%s: /chosen/u-boot,spl-boot-device not set\n",
+		      __func__);
+		return CONFIG_SYS_MMC_ENV_DEV;
+	}
+
+	debug("%s: booted from %s\n", __func__, boot_device);
+
+	if (uclass_find_device_by_ofnode(UCLASS_MMC, ofnode_path(boot_device), &devp))
+		return CONFIG_SYS_MMC_ENV_DEV;
+
+	debug("%s: get MMC ENV from mmc%d\n", __func__, devp->seq_);
+
+	return devp->seq_;
+}
+
+enum env_location arch_env_get_location(enum env_operation op, int prio)
+{
+	const char *boot_device =
+		ofnode_read_chosen_string("u-boot,spl-boot-device");
+	struct udevice *devp;
+
+	if (prio > 0)
+		return ENVL_UNKNOWN;
+
+	if (!boot_device) {
+		debug("%s: /chosen/u-boot,spl-boot-device not set\n",
+		      __func__);
+		return ENVL_NOWHERE;
+	}
+
+	debug("%s: booted from %s\n", __func__, boot_device);
+
+	if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH) &&
+	    !uclass_find_device_by_ofnode(UCLASS_SPI_FLASH, ofnode_path(boot_device), &devp))
+		return ENVL_SPI_FLASH;
+
+	if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC) &&
+	    !uclass_find_device_by_ofnode(UCLASS_MMC, ofnode_path(boot_device), &devp))
+		return ENVL_MMC;
+
+	printf("%s: No environment available: booted from %s but U-Boot config does not allow loading environment from it.",
+	       __func__, boot_device);
+
+	return ENVL_NOWHERE;
+}
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
diff --git a/board/theobroma-systems/puma_rk3399/puma-rk3399.c b/board/theobroma-systems/puma_rk3399/puma-rk3399.c
index ac8ceedc7c9..a82f97b2d54 100644
--- a/board/theobroma-systems/puma_rk3399/puma-rk3399.c
+++ b/board/theobroma-systems/puma_rk3399/puma-rk3399.c
@@ -3,28 +3,15 @@
  * (C) Copyright 2017 Theobroma Systems Design und Consulting GmbH
  */
 
-#include <common.h>
 #include <dm.h>
-#include <env.h>
-#include <env_internal.h>
-#include <init.h>
-#include <log.h>
-#include <misc.h>
-#include <spl.h>
 #include <syscon.h>
-#include <u-boot/crc.h>
-#include <usb.h>
 #include <dm/pinctrl.h>
-#include <dm/uclass-internal.h>
 #include <asm/io.h>
-#include <asm/setup.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/hardware.h>
 #include <asm/arch-rockchip/grf_rk3399.h>
-#include <asm/arch-rockchip/periph.h>
 #include <asm/arch-rockchip/misc.h>
-#include <power/regulator.h>
-#include <u-boot/sha256.h>
+#include "../common/common.h"
 
 static void setup_iodomain(void)
 {
@@ -40,137 +27,6 @@ static void setup_iodomain(void)
 	rk_setreg(&grf->io_vsel, 1 << GRF_IO_VSEL_GPIO4CD_SHIFT);
 }
 
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
-	 * was used to load U-Boot proper. If SPI-NOR flash was used, keep
-	 * original default order.
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
-		return CONFIG_SYS_MMC_ENV_DEV;
-	}
-
-	debug("%s: booted from %s\n", __func__, boot_device);
-
-	if (uclass_find_device_by_ofnode(UCLASS_MMC, ofnode_path(boot_device), &devp))
-		return CONFIG_SYS_MMC_ENV_DEV;
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
-	if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH) &&
-	    !uclass_find_device_by_ofnode(UCLASS_SPI_FLASH, ofnode_path(boot_device), &devp))
-		return ENVL_SPI_FLASH;
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
 int misc_init_r(void)
 {
 	const u32 cpuid_offset = 0x7;
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
index fb5570767db..ff7e414303d 100644
--- a/board/theobroma-systems/ringneck_px30/ringneck-px30.c
+++ b/board/theobroma-systems/ringneck_px30/ringneck-px30.c
@@ -3,155 +3,10 @@
  * (C) Copyright 2022 Theobroma Systems Design und Consulting GmbH
  */
 
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
 #include <asm/gpio.h>
-#include <asm/io.h>
-#include <asm/setup.h>
-#include <asm/arch-rockchip/clock.h>
-#include <asm/arch-rockchip/hardware.h>
-#include <asm/arch-rockchip/periph.h>
 #include <asm/arch-rockchip/misc.h>
 #include <linux/delay.h>
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
-		return CONFIG_SYS_MMC_ENV_DEV;
-	}
-
-	debug("%s: booted from %s\n", __func__, boot_device);
-
-	if (uclass_find_device_by_ofnode(UCLASS_MMC, ofnode_path(boot_device), &devp))
-		return CONFIG_SYS_MMC_ENV_DEV;
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
+#include "../common/common.h"
 
 int misc_init_r(void)
 {

-- 
2.42.0

