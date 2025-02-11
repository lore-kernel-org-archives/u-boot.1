Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38ECCC021A1
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 04:34:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2CAB80BA8;
	Tue, 11 Feb 2025 05:34:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E19C78043C; Tue, 11 Feb 2025 05:34:15 +0100 (CET)
Received: from mail.naobsd.org (sakura.naobsd.org [160.16.200.221])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7C02800B3
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 05:34:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=naoki@radxa.com
Received: from secure.fukaumi.org ([10.0.0.2])
 by mail.naobsd.org (8.14.4/8.14.4/Debian-4.1ubuntu1.1) with ESMTP id
 51B4Xf17024593; Tue, 11 Feb 2025 13:33:44 +0900
From: FUKAUMI Naoki <naoki@radxa.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 marex@denx.de, quentin.schulz@cherry.de, dsimic@manjaro.org,
 jonas@kwiboo.se, benwolsieffer@gmail.com, a-dutta@ti.com,
 mkorpershoek@baylibre.com, caleb.connolly@linaro.org,
 neil.armstrong@linaro.org, jan.kiszka@siemens.com, s-vadapalli@ti.com,
 bb@ti.com, ian.roberts@timesys.com, sumit.garg@linaro.org,
 FUKAUMI Naoki <naoki@radxa.com>
Subject: [PATCH v2 2/2] rockchip: Fix SPL link error for Radxa ROCK Pi 4
Date: Tue, 11 Feb 2025 04:33:35 +0000
Message-ID: <20250211043335.92538-2-naoki@radxa.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250211043335.92538-1-naoki@radxa.com>
References: <20250211043335.92538-1-naoki@radxa.com>
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

If CONFIG_EFI_CAPSULE_FIRMWARE_RAW, CONFIG_SPL_ENV_SUPPORT, and
CONFIG_SPL_DFU are enabled, linking u-boot-spl will fail.

  LD      spl/u-boot-spl
ld.bfd: drivers/dfu/dfu.o: in function `dfu_init_env_entities':
/home/radxa/u-boot/drivers/dfu/dfu.c:173:(.text.dfu_init_env_entities+0x24): undefined reference to `set_dfu_alt_info'

Separate the EFI specific parts from board.c into efi.c.

Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
---
Changes in v2:
- Separate the EFI specific parts from board.c into efi.c
---
 arch/arm/mach-rockchip/Makefile |   1 +
 arch/arm/mach-rockchip/board.c  | 165 --------------------------
 arch/arm/mach-rockchip/efi.c    | 201 ++++++++++++++++++++++++++++++++
 3 files changed, 202 insertions(+), 165 deletions(-)
 create mode 100644 arch/arm/mach-rockchip/efi.c

diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
index 5e7edc99cdc..cf66a507c8e 100644
--- a/arch/arm/mach-rockchip/Makefile
+++ b/arch/arm/mach-rockchip/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) += board.o
 endif
 
 ifeq ($(CONFIG_TPL_BUILD),)
+obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) += efi.o
 obj-$(CONFIG_DISPLAY_CPUINFO) += cpu-info.o
 endif
 
diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
index 75d6693e28a..0542e7a3f60 100644
--- a/arch/arm/mach-rockchip/board.c
+++ b/arch/arm/mach-rockchip/board.c
@@ -35,171 +35,6 @@
 #include <asm/arch-rockchip/periph.h>
 #include <power/regulator.h>
 
-#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && IS_ENABLED(CONFIG_EFI_PARTITION)
-
-#define DFU_ALT_BUF_LEN			SZ_1K
-
-static struct efi_fw_image *fw_images;
-
-static bool updatable_image(struct disk_partition *info)
-{
-	int i;
-	bool ret = false;
-	efi_guid_t image_type_guid;
-
-	uuid_str_to_bin(info->type_guid, image_type_guid.b,
-			UUID_STR_FORMAT_GUID);
-
-	for (i = 0; i < update_info.num_images; i++) {
-		if (!guidcmp(&fw_images[i].image_type_id, &image_type_guid)) {
-			ret = true;
-			break;
-		}
-	}
-
-	return ret;
-}
-
-static void set_image_index(struct disk_partition *info, int index)
-{
-	int i;
-	efi_guid_t image_type_guid;
-
-	uuid_str_to_bin(info->type_guid, image_type_guid.b,
-			UUID_STR_FORMAT_GUID);
-
-	for (i = 0; i < update_info.num_images; i++) {
-		if (!guidcmp(&fw_images[i].image_type_id, &image_type_guid)) {
-			fw_images[i].image_index = index;
-			break;
-		}
-	}
-}
-
-static int get_mmc_desc(struct blk_desc **desc)
-{
-	int ret;
-	struct mmc *mmc;
-	struct udevice *dev;
-
-	/*
-	 * For now the firmware images are assumed to
-	 * be on the SD card
-	 */
-	ret = uclass_get_device(UCLASS_MMC, 1, &dev);
-	if (ret)
-		return -1;
-
-	mmc = mmc_get_mmc_dev(dev);
-	if (!mmc)
-		return -ENODEV;
-
-	if ((ret = mmc_init(mmc)))
-		return ret;
-
-	*desc = mmc_get_blk_desc(mmc);
-	if (!*desc)
-		return -1;
-
-	return 0;
-}
-
-void set_dfu_alt_info(char *interface, char *devstr)
-{
-	const char *name;
-	bool first = true;
-	int p, len, devnum, ret;
-	char buf[DFU_ALT_BUF_LEN];
-	struct disk_partition info;
-	struct blk_desc *desc = NULL;
-
-	ret = get_mmc_desc(&desc);
-	if (ret) {
-		log_err("Unable to get mmc desc\n");
-		return;
-	}
-
-	memset(buf, 0, sizeof(buf));
-	name = blk_get_uclass_name(desc->uclass_id);
-	devnum = desc->devnum;
-	len = strlen(buf);
-
-	len += snprintf(buf + len, DFU_ALT_BUF_LEN - len,
-			 "%s %d=", name, devnum);
-
-	for (p = 1; p <= MAX_SEARCH_PARTITIONS; p++) {
-		if (part_get_info(desc, p, &info))
-			continue;
-
-		/* Add entry to dfu_alt_info only for updatable images */
-		if (updatable_image(&info)) {
-			if (!first)
-				len += snprintf(buf + len,
-						DFU_ALT_BUF_LEN - len, ";");
-
-			len += snprintf(buf + len, DFU_ALT_BUF_LEN - len,
-					"%s%d_%s part %d %d",
-					name, devnum, info.name, devnum, p);
-			first = false;
-		}
-	}
-
-	log_debug("dfu_alt_info => %s\n", buf);
-	env_set("dfu_alt_info", buf);
-}
-
-__weak void rockchip_capsule_update_board_setup(void)
-{
-}
-
-static void gpt_capsule_update_setup(void)
-{
-	int p, i, ret;
-	struct disk_partition info;
-	struct blk_desc *desc = NULL;
-
-	fw_images = update_info.images;
-	rockchip_capsule_update_board_setup();
-
-	ret = get_mmc_desc(&desc);
-	if (ret) {
-		log_err("Unable to get mmc desc\n");
-		return;
-	}
-
-	for (p = 1, i = 1; p <= MAX_SEARCH_PARTITIONS; p++) {
-		if (part_get_info(desc, p, &info))
-			continue;
-
-		/*
-		 * Since we have a GPT partitioned device, the updatable
-		 * images could be stored in any order. Populate the
-		 * image_index at runtime.
-		 */
-		if (updatable_image(&info)) {
-			set_image_index(&info, i);
-			i++;
-		}
-	}
-}
-#endif /* CONFIG_EFI_HAVE_CAPSULE_SUPPORT && CONFIG_EFI_PARTITION */
-
-__weak int rk_board_late_init(void)
-{
-	return 0;
-}
-
-int board_late_init(void)
-{
-	setup_boot_mode();
-
-#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && IS_ENABLED(CONFIG_EFI_PARTITION)
-	gpt_capsule_update_setup();
-#endif
-
-	return rk_board_late_init();
-}
-
 int board_init(void)
 {
 	return 0;
diff --git a/arch/arm/mach-rockchip/efi.c b/arch/arm/mach-rockchip/efi.c
new file mode 100644
index 00000000000..5173a7c1b4e
--- /dev/null
+++ b/arch/arm/mach-rockchip/efi.c
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2019 Rockchip Electronics Co., Ltd.
+ *
+ * Copyright (C) 2019 Collabora Inc - https://www.collabora.com/
+ *      Rohan Garg <rohan.garg@collabora.com>
+ *
+ * Based on puma-rk3399.c:
+ *      (C) Copyright 2017 Theobroma Systems Design und Consulting GmbH
+ */
+#include <config.h>
+#include <clk.h>
+#include <cpu_func.h>
+#include <env.h>
+#include <dm.h>
+#include <dm/uclass-internal.h>
+#include <efi_loader.h>
+#include <fastboot.h>
+#include <hash.h>
+#include <init.h>
+#include <log.h>
+#include <mmc.h>
+#include <dm/uclass-internal.h>
+#include <misc.h>
+#include <part.h>
+#include <ram.h>
+#include <syscon.h>
+#include <u-boot/uuid.h>
+#include <u-boot/crc.h>
+#include <u-boot/sha256.h>
+#include <asm/cache.h>
+#include <asm/io.h>
+#include <asm/arch-rockchip/boot_mode.h>
+#include <asm/arch-rockchip/clock.h>
+#include <asm/arch-rockchip/periph.h>
+#include <power/regulator.h>
+
+#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && IS_ENABLED(CONFIG_EFI_PARTITION)
+
+#define DFU_ALT_BUF_LEN			SZ_1K
+
+static struct efi_fw_image *fw_images;
+
+static bool updatable_image(struct disk_partition *info)
+{
+	int i;
+	bool ret = false;
+	efi_guid_t image_type_guid;
+
+	uuid_str_to_bin(info->type_guid, image_type_guid.b,
+			UUID_STR_FORMAT_GUID);
+
+	for (i = 0; i < update_info.num_images; i++) {
+		if (!guidcmp(&fw_images[i].image_type_id, &image_type_guid)) {
+			ret = true;
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static void set_image_index(struct disk_partition *info, int index)
+{
+	int i;
+	efi_guid_t image_type_guid;
+
+	uuid_str_to_bin(info->type_guid, image_type_guid.b,
+			UUID_STR_FORMAT_GUID);
+
+	for (i = 0; i < update_info.num_images; i++) {
+		if (!guidcmp(&fw_images[i].image_type_id, &image_type_guid)) {
+			fw_images[i].image_index = index;
+			break;
+		}
+	}
+}
+
+static int get_mmc_desc(struct blk_desc **desc)
+{
+	int ret;
+	struct mmc *mmc;
+	struct udevice *dev;
+
+	/*
+	 * For now the firmware images are assumed to
+	 * be on the SD card
+	 */
+	ret = uclass_get_device(UCLASS_MMC, 1, &dev);
+	if (ret)
+		return -1;
+
+	mmc = mmc_get_mmc_dev(dev);
+	if (!mmc)
+		return -ENODEV;
+
+	if ((ret = mmc_init(mmc)))
+		return ret;
+
+	*desc = mmc_get_blk_desc(mmc);
+	if (!*desc)
+		return -1;
+
+	return 0;
+}
+
+void set_dfu_alt_info(char *interface, char *devstr)
+{
+	const char *name;
+	bool first = true;
+	int p, len, devnum, ret;
+	char buf[DFU_ALT_BUF_LEN];
+	struct disk_partition info;
+	struct blk_desc *desc = NULL;
+
+	ret = get_mmc_desc(&desc);
+	if (ret) {
+		log_err("Unable to get mmc desc\n");
+		return;
+	}
+
+	memset(buf, 0, sizeof(buf));
+	name = blk_get_uclass_name(desc->uclass_id);
+	devnum = desc->devnum;
+	len = strlen(buf);
+
+	len += snprintf(buf + len, DFU_ALT_BUF_LEN - len,
+			 "%s %d=", name, devnum);
+
+	for (p = 1; p <= MAX_SEARCH_PARTITIONS; p++) {
+		if (part_get_info(desc, p, &info))
+			continue;
+
+		/* Add entry to dfu_alt_info only for updatable images */
+		if (updatable_image(&info)) {
+			if (!first)
+				len += snprintf(buf + len,
+						DFU_ALT_BUF_LEN - len, ";");
+
+			len += snprintf(buf + len, DFU_ALT_BUF_LEN - len,
+					"%s%d_%s part %d %d",
+					name, devnum, info.name, devnum, p);
+			first = false;
+		}
+	}
+
+	log_debug("dfu_alt_info => %s\n", buf);
+	env_set("dfu_alt_info", buf);
+}
+
+__weak void rockchip_capsule_update_board_setup(void)
+{
+}
+
+static void gpt_capsule_update_setup(void)
+{
+	int p, i, ret;
+	struct disk_partition info;
+	struct blk_desc *desc = NULL;
+
+	fw_images = update_info.images;
+	rockchip_capsule_update_board_setup();
+
+	ret = get_mmc_desc(&desc);
+	if (ret) {
+		log_err("Unable to get mmc desc\n");
+		return;
+	}
+
+	for (p = 1, i = 1; p <= MAX_SEARCH_PARTITIONS; p++) {
+		if (part_get_info(desc, p, &info))
+			continue;
+
+		/*
+		 * Since we have a GPT partitioned device, the updatable
+		 * images could be stored in any order. Populate the
+		 * image_index at runtime.
+		 */
+		if (updatable_image(&info)) {
+			set_image_index(&info, i);
+			i++;
+		}
+	}
+}
+#endif /* CONFIG_EFI_HAVE_CAPSULE_SUPPORT && CONFIG_EFI_PARTITION */
+
+__weak int rk_board_late_init(void)
+{
+	return 0;
+}
+
+int board_late_init(void)
+{
+	setup_boot_mode();
+
+#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && IS_ENABLED(CONFIG_EFI_PARTITION)
+	gpt_capsule_update_setup();
+#endif
+
+	return rk_board_late_init();
+}
-- 
2.43.0

