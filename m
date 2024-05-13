Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33CB2C25B78
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 23:29:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A68F187D07;
	Tue, 14 May 2024 01:29:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8617587D07; Tue, 14 May 2024 01:29:20 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8DA58813F
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 01:29:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1s6f6W-007JY8-F5;
 Mon, 13 May 2024 23:29:12 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: Tom Rini <trini@konsulko.com>, Tim Harvey <tharvey@gateworks.com>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Fabio Estevam <festevam@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@lists.denx.de, Dragan Simic <dsimic@manjaro.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 1/3 v4] mmc: use an enumerated type to represent
 PARTITION_CONFIG fields
Date: Mon, 13 May 2024 16:29:05 -0700
Message-Id: <20240513232907.2738959-2-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240513232907.2738959-1-tharvey@gateworks.com>
References: <20240513232907.2738959-1-tharvey@gateworks.com>
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

Modern eMMC v4+ devices have multiple hardware partitions per the JEDEC
specification described as:
  Boot Area Partition 1
  Boot Area Partition 2
  RPMB Partition
  General Purpose Partition 1
  General Purpose Partition 2
  General Purpose Partition 3
  General Purpose Partition 4
  User Data Area

These are referenced by fields in the PARTITION_CONFIG register
(Extended CSD Register 179) which is defined as:
bit 7: reserved
bit 6: BOOT_ACK
  0x0: No boot acknowledge sent (default
  0x1: Boot acknowledge sent during boot operation Bit
bit 5:3: BOOT_PARTITION_ENABLE
  0x0: Device not boot enabled (default)
  0x1: Boot Area partition 1 enabled for boot
  0x2: Boot Area partition 2 enabled for boot
  0x3-0x6: Reserved
  0x7: User area enabled for boot
bit 2:0 PARTITION_ACCESS
  0x0: No access to boot partition (default)
  0x1: Boot Area partition 1
  0x2: Boot Area partition 2
  0x3: Replay Protected Memory Block (RPMB)
  0x4: Access to General Purpose partition 1
  0x5: Access to General Purpose partition 2
  0x6: Access to General Purpose partition 3
  0x7: Access to General Purpose partition 4

Note that setting PARTITION_ACCESS to 0x0 results in selecting the User
Data Area partition.

You can see above that the two fields BOOT_PARTITION_ENABLE and
PARTITION_ACCESS do not use the same enumerated values.

U-Boot uses a set of macros to access fields of the PARTITION_CONFIG
register:

There are various places in U-Boot where the BOOT_PARTITION_ENABLE field
is accessed via EXT_CSD_EXTRACT_PARTITION_ACCESS and converted to a
hardware partition consistent with the definition of the
PARTITION_ACCESS field which is also the value used to specify the
hardware partition of the various mmc_switch incarnations.

To add some sanity to the distinction between BOOT_PARTITION_ENABLE
(used to specify the active device on power-cycle) and PARTITION_ACCESS
(used to switch between hardware partitions) create two enumerated types
and use them wherever struct mmc * part_config is used or the above
macros are used.

This represents no code changes.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
v4: new patch in this series
---
 arch/arm/mach-imx/image-container.c | 10 +++++-----
 arch/arm/mach-sunxi/board.c         |  2 +-
 board/gateworks/venice/spl.c        |  4 ++--
 board/gateworks/venice/venice.c     | 22 +++++++++++-----------
 board/purism/librem5/librem5.c      |  4 ++--
 board/storopack/smegw01/smegw01.c   |  4 ++--
 cmd/mvebu/bubt.c                    |  4 ++--
 common/spl/spl_mmc.c                |  4 ++--
 include/mmc.h                       | 20 ++++++++++++++++++++
 9 files changed, 47 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-imx/image-container.c b/arch/arm/mach-imx/image-container.c
index 35da0ae04258..bcd40889f0fa 100644
--- a/arch/arm/mach-imx/image-container.c
+++ b/arch/arm/mach-imx/image-container.c
@@ -205,7 +205,7 @@ static unsigned long get_boot_device_offset(void *dev, int dev_type)
 		} else {
 			u8 part = EXT_CSD_EXTRACT_BOOT_PART(mmc->part_config);
 
-			if (part == 1 || part == 2) {
+			if (part == EMMC_BOOT_PART_BOOT1 || part == EMMC_BOOT_PART_BOOT2) {
 				if (is_imx8qxp() && is_soc_rev(CHIP_REV_B))
 					offset = CONTAINER_HDR_MMCSD_OFFSET;
 				else
@@ -294,15 +294,15 @@ int spl_mmc_emmc_boot_partition(struct mmc *mmc)
 	int part;
 
 	part = EXT_CSD_EXTRACT_BOOT_PART(mmc->part_config);
-	if (part == 1 || part == 2) {
+	if (part == EMMC_BOOT_PART_BOOT1 || part == EMMC_BOOT_PART_BOOT2) {
 		unsigned long sec_set_off = 0;
 		bool sec_boot = false;
 
 		sec_boot = check_secondary_cnt_set(&sec_set_off);
 		if (sec_boot)
-			part = (part == 1) ? 2 : 1;
-	} else if (part == 7) {
-		part = 0;
+			part = (part == EMMC_BOOT_PART_BOOT1) ? EMMC_HWPART_BOOT2 : EMMC_HWPART_BOOT1;
+	} else if (part == EMMC_BOOT_PART_USER) {
+		part = EMMC_HWPART_DEFAULT;
 	}
 
 	return part;
diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
index 0140b07d32a6..860e7058b69c 100644
--- a/arch/arm/mach-sunxi/board.c
+++ b/arch/arm/mach-sunxi/board.c
@@ -396,7 +396,7 @@ static bool sunxi_valid_emmc_boot(struct mmc *mmc)
 		return false;
 
 	/* Partition 0 is the user data partition, bootpart must be 1 or 2. */
-	if (bootpart != 1 && bootpart != 2)
+	if (bootpart != EMMC_BOOT_PART_BOOT1 && bootpart != EMMC_BOOT_PART_BOOT2)
 		return false;
 
 	/* Failure to switch to the boot partition is fatal. */
diff --git a/board/gateworks/venice/spl.c b/board/gateworks/venice/spl.c
index 3b0f11f2fd0f..6f6dea84feee 100644
--- a/board/gateworks/venice/spl.c
+++ b/board/gateworks/venice/spl.c
@@ -353,8 +353,8 @@ unsigned long board_spl_mmc_get_uboot_raw_sector(struct mmc *mmc, unsigned long
 {
 	if (!IS_SD(mmc)) {
 		switch (EXT_CSD_EXTRACT_BOOT_PART(mmc->part_config)) {
-		case 1:
-		case 2:
+		case EMMC_BOOT_PART_BOOT1:
+		case EMMC_BOOT_PART_BOOT2:
 			if (IS_ENABLED(CONFIG_IMX8MN) || IS_ENABLED(CONFIG_IMX8MP))
 				raw_sect -= 32 * 2;
 			break;
diff --git a/board/gateworks/venice/venice.c b/board/gateworks/venice/venice.c
index 5b105d7659e4..44ed4e4598e1 100644
--- a/board/gateworks/venice/venice.c
+++ b/board/gateworks/venice/venice.c
@@ -173,20 +173,20 @@ int board_late_init(void)
 			int bootpart;
 
 			switch (EXT_CSD_EXTRACT_BOOT_PART(mmc->part_config)) {
-			case 1: /* boot0 */
-				bootpart = 1;
+			case EMMC_BOOT_PART_BOOT1:
+				bootpart = EMMC_HWPART_BOOT1;
 				break;
-			case 2: /* boot1 */
-				bootpart = 2;
+			case EMMC_BOOT_PART_BOOT2:
+				bootpart = EMMC_HWPART_BOOT2;
 				break;
-			case 7: /* user */
+			case EMMC_BOOT_PART_USER:
 			default:
-				bootpart = 0;
+				bootpart = EMMC_HWPART_DEFAULT;
 				break;
 			}
 			/* IMX8MP/IMX8MN BOOTROM v2 uses offset=0 for boot parts */
 			if ((IS_ENABLED(CONFIG_IMX8MN) || IS_ENABLED(CONFIG_IMX8MP)) &&
-			    (bootpart == 1 || bootpart == 2))
+			    (bootpart == EMMC_BOOT_PART_BOOT1 || bootpart == EMMC_BOOT_PART_BOOT2))
 				bootblk = 0;
 			env_set_hex("bootpart", bootpart);
 			env_set_hex("bootblk", bootblk);
@@ -217,10 +217,10 @@ uint mmc_get_env_part(struct mmc *mmc)
 {
 	if (!IS_SD(mmc)) {
 		switch (EXT_CSD_EXTRACT_BOOT_PART(mmc->part_config)) {
-		case 1:
-			return 1;
-		case 2:
-			return 2;
+		case EMMC_BOOT_PART_BOOT1:
+			return EMMC_HWPART_BOOT1;
+		case EMMC_BOOT_PART_BOOT2:
+			return EMMC_HWPART_BOOT2;
 		}
 	}
 
diff --git a/board/purism/librem5/librem5.c b/board/purism/librem5/librem5.c
index d0249e71f09a..3f1a8e385d72 100644
--- a/board/purism/librem5/librem5.c
+++ b/board/purism/librem5/librem5.c
@@ -43,8 +43,8 @@ uint board_mmc_get_env_part(struct mmc *mmc)
 {
 	uint part = EXT_CSD_EXTRACT_BOOT_PART(mmc->part_config);
 
-	if (part == 7)
-		part = 0;
+	if (part == EMMC_BOOT_PART_USER)
+		part = EMMC_HWPART_DEFAULT;
 	return part;
 }
 #endif
diff --git a/board/storopack/smegw01/smegw01.c b/board/storopack/smegw01/smegw01.c
index 345191b31c29..d1f474bc7a14 100644
--- a/board/storopack/smegw01/smegw01.c
+++ b/board/storopack/smegw01/smegw01.c
@@ -106,8 +106,8 @@ uint mmc_get_env_part(struct mmc *mmc)
 {
 	uint part = EXT_CSD_EXTRACT_BOOT_PART(mmc->part_config);
 
-	if (part == 7)
-		part = 0;
+	if (part == EMMC_BOOT_PART_USER)
+		part = EMMC_HWPART_DEFAULT;
 	return part;
 }
 
diff --git a/cmd/mvebu/bubt.c b/cmd/mvebu/bubt.c
index 744b1c20aa83..1e3f5bf7add6 100644
--- a/cmd/mvebu/bubt.c
+++ b/cmd/mvebu/bubt.c
@@ -224,8 +224,8 @@ static int mmc_burn_image(size_t image_size)
 #endif
 
 	part = EXT_CSD_EXTRACT_BOOT_PART(mmc->part_config);
-	if (part == 7)
-		part = 0;
+	if (part == EMMC_BOOT_PART_USER)
+		part = EMMC_HWPART_DEFAULT;
 
 #ifdef CONFIG_BLK
 	err = blk_dselect_hwpart(blk_desc, part);
diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index 3d032bb27ce3..fd5154dad7c4 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -320,8 +320,8 @@ int default_spl_mmc_emmc_boot_partition(struct mmc *mmc)
 	 * which is the first physical partition (0).
 	 */
 	part = EXT_CSD_EXTRACT_BOOT_PART(mmc->part_config);
-	if (part == 7)
-		part = 0;
+	if (part == EMMC_BOOT_PART_USER)
+		part = EMMC_HWPART_DEFAULT;
 #endif
 	return part;
 }
diff --git a/include/mmc.h b/include/mmc.h
index 4b8327f1f93b..0f3f1ed6aaa3 100644
--- a/include/mmc.h
+++ b/include/mmc.h
@@ -381,6 +381,26 @@ enum mmc_voltage {
 #define MMC_TIMING_MMC_HS200	9
 #define MMC_TIMING_MMC_HS400	10
 
+/* emmc PARTITION_CONFIG BOOT_PARTITION_ENABLE values */
+enum emmc_boot_part {
+	EMMC_BOOT_PART_DEFAULT = 0,
+	EMMC_BOOT_PART_BOOT1 = 1,
+	EMMC_BOOT_PART_BOOT2 = 2,
+	EMMC_BOOT_PART_USER = 7,
+};
+
+/* emmc PARTITION_CONFIG ACCESS_ENABLE values */
+enum emmc_hwpart {
+	EMMC_HWPART_DEFAULT = 0, /* user */
+	EMMC_HWPART_BOOT1 = 1,
+	EMMC_HWPART_BOOT2 = 2,
+	EMMC_HWPART_RPMB = 3,
+	EMMC_HWPART_GP1 = 4,
+	EMMC_HWPART_GP2 = 5,
+	EMMC_HWPART_GP3 = 6,
+	EMMC_HWPART_GP4 = 7,
+};
+
 /* Driver model support */
 
 /**
-- 
2.25.1

