Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09700EC111A
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 18:47:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF4EF83DEB;
	Mon, 23 Feb 2026 19:47:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="RaBsVZQ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CE5E83935; Mon, 23 Feb 2026 19:39:23 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA4A183D0F
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 19:39:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id B6FE727DA9;
 Mon, 23 Feb 2026 19:39:19 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SR1QFJvBw8Z2; Mon, 23 Feb 2026 19:39:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1771871959; bh=2dhaSTCRfutTzZF9LgxYzp6Ajmt0qbhWeRyohkZf834=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=RaBsVZQ+RwSSCYmIhJJRPRe/HuCfT9/f3SsIjR34rm+G8C4PKSedhRj3t8FviO7Mc
 W3SJIC2UaRYh5YC4aWr/l3U1G/woO9czmRB4yRK3xNc6pRr5x407QmT6m7gkfS/lmm
 35unAdECvAtQTzlSjEE1F4YoFmtFyz0nUPn/PESh63krnDq1SxRhOWOs/9kb3PMZGu
 zDE3291bQ+uWbkQEGK7OVTLfgieuylYQ3/OKQY0m7N/pqwqt4EqGP8BUMga2fe6lKa
 2FGGDgYJaGPLZUKIT0j9idkHDbzZWQxkRFrJQuH0LV6rm3I1lYosZWnFYnQHdCVs69
 GJPGr4BKHvzKQ==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Tue, 24 Feb 2026 00:09:10 +0530
Subject: [PATCH 2/2] board: samsung: exynos-mobile: add EFI capsule update
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-exynos-blkmap-dfu-v1-2-cfe615b68c88@disroot.org>
References: <20260224-exynos-blkmap-dfu-v1-0-cfe615b68c88@disroot.org>
In-Reply-To: <20260224-exynos-blkmap-dfu-v1-0-cfe615b68c88@disroot.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Mailman-Approved-At: Mon, 23 Feb 2026 19:47:22 +0100
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

Add support for EFI capsule updates via U-Boot's DFU. This flashes the
boot partition with the new image provided in the capsule.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 board/samsung/exynos-mobile/exynos-mobile.c | 24 ++++++++++++++++++++++++
 configs/exynos-mobile_defconfig             |  6 ++++++
 2 files changed, 30 insertions(+)

diff --git a/board/samsung/exynos-mobile/exynos-mobile.c b/board/samsung/exynos-mobile/exynos-mobile.c
index c5e1b186ae3..6b2b1523663 100644
--- a/board/samsung/exynos-mobile/exynos-mobile.c
+++ b/board/samsung/exynos-mobile/exynos-mobile.c
@@ -10,6 +10,8 @@
 #include <bootflow.h>
 #include <ctype.h>
 #include <dm/ofnode.h>
+#include <efi.h>
+#include <efi_loader.h>
 #include <env.h>
 #include <errno.h>
 #include <init.h>
@@ -24,6 +26,19 @@ DECLARE_GLOBAL_DATA_PTR;
 #define lmb_alloc(size, addr) \
 	lmb_alloc_mem(LMB_MEM_ALLOC_ANY, SZ_2M, addr, size, LMB_NONE)
 
+struct efi_fw_image fw_images[] = {
+	{
+		.fw_name = u"UBOOT_BOOT_PARTITION",
+		.image_index = 1,
+	},
+};
+
+struct efi_capsule_update_info update_info = {
+	.dfu_string = NULL,
+	.images = fw_images,
+	.num_images = ARRAY_SIZE(fw_images),
+};
+
 /*
  * The memory mapping includes all DRAM banks, along with the
  * peripheral block, and a sentinel at the end. This is filled in
@@ -191,6 +206,7 @@ static int exynos_blk_env_setup(void)
 	struct blk_desc *blk_desc;
 	struct disk_partition info = {0};
 	unsigned long largest_part_start = 0, largest_part_size = 0;
+	static char dfu_string[32];
 	int i;
 
 	blk_ifname = "mmc";
@@ -204,6 +220,14 @@ static int exynos_blk_env_setup(void)
 		if (part_get_info(blk_desc, i, &info))
 			continue;
 
+		if (!update_info.dfu_string &&
+		    !strncasecmp(info.name, "boot", strlen("boot"))) {
+			snprintf(dfu_string, sizeof(dfu_string),
+				 "mmc %d=u-boot.bin part %d %d", blk_dev,
+				 blk_dev, i);
+			update_info.dfu_string = dfu_string;
+		}
+
 		if (info.start > largest_part_size) {
 			largest_part_start = info.start;
 			largest_part_size = info.size;
diff --git a/configs/exynos-mobile_defconfig b/configs/exynos-mobile_defconfig
index cee468d9c24..9a4b6a52362 100644
--- a/configs/exynos-mobile_defconfig
+++ b/configs/exynos-mobile_defconfig
@@ -11,6 +11,10 @@ CONFIG_SYS_BOOTM_LEN=0x2000000
 CONFIG_SYS_LOAD_ADDR=0x80000000
 CONFIG_ARMV8_CNTFRQ_BROKEN=y
 # CONFIG_PSCI_RESET is not set
+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
+CONFIG_EFI_CAPSULE_ON_DISK=y
+CONFIG_EFI_CAPSULE_ON_DISK_EARLY=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
 CONFIG_BUTTON_CMD=y
 CONFIG_USE_PREBOOT=y
 CONFIG_SAVE_PREV_BL_FDT_ADDR=y
@@ -31,6 +35,8 @@ CONFIG_BLKMAP=y
 CONFIG_BUTTON=y
 CONFIG_BUTTON_REMAP_PHONE_KEYS=y
 CONFIG_CLK_EXYNOS7870=y
+CONFIG_DFU_MMC=y
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x200000
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0xdead0000
 CONFIG_FASTBOOT_FLASH=y

-- 
2.52.0

