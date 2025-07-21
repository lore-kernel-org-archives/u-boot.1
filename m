Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6358DC83F25
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 11:22:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3965D83816;
	Mon, 21 Jul 2025 13:19:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E0E5831D6; Mon, 21 Jul 2025 13:19:14 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 88B5E83804
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 13:19:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1960126AC;
 Mon, 21 Jul 2025 04:19:05 -0700 (PDT)
Received: from e130802.cambridge.arm.com (e130802.arm.com [10.1.26.61])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F18A73F6A8;
 Mon, 21 Jul 2025 04:19:09 -0700 (PDT)
From: abdellatif.elkhlifi@arm.com
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>
Subject: [PATCH v3 20/24] fwu_arm_psa: corstone1000: Enable FWU support
Date: Mon, 21 Jul 2025 12:18:12 +0100
Message-Id: <20250721111816.62340-21-abdellatif.elkhlifi@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250721111816.62340-1-abdellatif.elkhlifi@arm.com>
References: <20250721111816.62340-1-abdellatif.elkhlifi@arm.com>
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

From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>

Provide the update_info structure and FWU configs for Corstone-1000

update_info defines the image to be used for FWU.
The FWU configs enabled are the FWU Arm PSA configs.

Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Hugues Kamba Mpiana <hugues.kambampiana@arm.com>
---
 board/armltd/corstone1000/corstone1000.c | 138 ++++++++++++++++++++++-
 configs/corstone1000_defconfig           |  10 +-
 2 files changed, 146 insertions(+), 2 deletions(-)

diff --git a/board/armltd/corstone1000/corstone1000.c b/board/armltd/corstone1000/corstone1000.c
index 3ad77f51949..d2176b9174d 100644
--- a/board/armltd/corstone1000/corstone1000.c
+++ b/board/armltd/corstone1000/corstone1000.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * (C) Copyright 2022 ARM Limited
+ * (C) Copyright 2022, 2025 Arm Limited
  * (C) Copyright 2022 Linaro
  * Rui Miguel Silva <rui.silva@linaro.org>
  */
@@ -8,8 +8,11 @@
 #include <blk.h>
 #include <cpu_func.h>
 #include <dm.h>
+#include <generated/dt.h>
 #include <env.h>
+#include <efi_loader.h>
 #include <fwu.h>
+#include <fwu_arm_psa.h>
 #include <netdev.h>
 #include <nvmxip.h>
 #include <part.h>
@@ -21,6 +24,133 @@
 #define CORSTONE1000_KERNEL_PRIMARY "kernel_primary"
 #define CORSTONE1000_KERNEL_SECONDARY "kernel_secondary"
 
+#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
+
+/* The total number of upgradable images including the start and end dummy payloads */
+#define CAPSULE_PAYLOADS_MAX_COUNT (CONFIG_FWU_NUM_IMAGES_PER_BANK + 2)
+
+/*
+ * GUIDs for capsule updatable firmware images
+ *
+ * The GUIDs are generating with the UUIDv5 format.
+ * Namespace used for FVP GUIDs: 989f3a4e-46e0-4cd0-9877-a25c70c01329
+ * Namespace used for MPS3 GUIDs: df1865d1-90fb-4d59-9c38-c9f2c1bba8cc
+ * Names: the image names stated in the fw_name field
+ */
+
+#define FWU_FVP_BL2_IMAGE_GUID \
+	EFI_GUID(0xf1d883f9, 0xdfeb, 0x5363, 0x98, 0xd8,	\
+		0x68, 0x6e, 0xe3, 0xb6, 0x9f, 0x4f)
+
+#define FWU_MPS3_BL2_IMAGE_GUID \
+	EFI_GUID(0xfbfbefaa, 0x0a56, 0x50d5, 0xb6, 0x51,	\
+		0x74, 0x09, 0x1d, 0x3d, 0x62, 0xcf)
+
+#define FWU_FVP_TFM_S_IMAGE_GUID \
+	EFI_GUID(0x7fad470e, 0x5ec5, 0x5c03, 0xa2, 0xc1,	\
+		0x47, 0x56, 0xb4, 0x95, 0xde, 0x61)
+
+#define FWU_MPS3_TFM_S_IMAGE_GUID \
+	EFI_GUID(0xaf4cc7ad, 0xee2e, 0x5a39, 0xaa, 0xd5,	\
+		0xfa, 0xc8, 0xa1, 0xe6, 0x17, 0x3c)
+
+#define FWU_FVP_FIP_IMAGE_GUID \
+	EFI_GUID(0xf1933675, 0x5a8c, 0x5b6d, 0x9e, 0xf4,	\
+		0x84, 0x67, 0x39, 0xe8, 0x9b, 0xc8)
+
+#define FWU_MPS3_FIP_IMAGE_GUID \
+	EFI_GUID(0x55302f96, 0xc4f0, 0x5cf9, 0x86, 0x24,	\
+		0xe7, 0xcc, 0x38, 0x8f, 0x2b, 0x68)
+
+#define FWU_FVP_INITRAMFS_IMAGE_GUID \
+	EFI_GUID(0xf771aff9, 0xc7e9, 0x5f99, 0x9e, 0xda,	\
+		0x23, 0x69, 0xdd, 0x69, 0x4f, 0x61)
+
+#define FWU_MPS3_INITRAMFS_IMAGE_GUID \
+	EFI_GUID(0x3e8ac972, 0xc33c, 0x5cc9, 0x90, 0xa0,	\
+		0xcd, 0xd3, 0x15, 0x96, 0x83, 0xea)
+
+enum fw_image_index {
+	FW_IMAGE_INDEX_BL2 = 1,
+	FW_IMAGE_INDEX_TFM_S,
+	FW_IMAGE_INDEX_FIP,
+	FW_IMAGE_INDEX_INITRAMFS,
+	FW_IMAGE_INDEX_DUMMY_START,
+	FW_IMAGE_INDEX_DUMMY_END
+};
+
+struct efi_fw_image fw_mps3_images[] = {
+	{
+		.image_type_id = FWU_MPS3_BL2_IMAGE_GUID,
+		.fw_name = u"BL2",
+		.image_index = FW_IMAGE_INDEX_BL2,
+	},
+	{
+		.image_type_id = FWU_MPS3_TFM_S_IMAGE_GUID,
+		.fw_name = u"TFM_S",
+		.image_index = FW_IMAGE_INDEX_TFM_S,
+	},
+	{
+		.image_type_id = FWU_MPS3_FIP_IMAGE_GUID,
+		.fw_name = u"FIP",
+		.image_index = FW_IMAGE_INDEX_FIP,
+	},
+	{
+		.image_type_id = FWU_MPS3_INITRAMFS_IMAGE_GUID,
+		.fw_name = u"INITRAMFS",
+		.image_index = FW_IMAGE_INDEX_INITRAMFS,
+	},
+	{
+		.image_type_id = FWU_DUMMY_START_IMAGE_GUID,
+		.fw_name = u"DUMMY_START",
+		.image_index = FW_IMAGE_INDEX_DUMMY_START,
+	},
+	{
+		.image_type_id = FWU_DUMMY_END_IMAGE_GUID,
+		.fw_name = u"DUMMY_END",
+		.image_index = FW_IMAGE_INDEX_DUMMY_END,
+	},
+};
+
+struct efi_fw_image fw_fvp_images[] = {
+	{
+		.image_type_id = FWU_FVP_BL2_IMAGE_GUID,
+		.fw_name = u"BL2",
+		.image_index = FW_IMAGE_INDEX_BL2,
+	},
+	{
+		.image_type_id = FWU_FVP_TFM_S_IMAGE_GUID,
+		.fw_name = u"TFM_S",
+		.image_index = FW_IMAGE_INDEX_TFM_S,
+	},
+	{
+		.image_type_id = FWU_FVP_FIP_IMAGE_GUID,
+		.fw_name = u"FIP",
+		.image_index = FW_IMAGE_INDEX_FIP,
+	},
+	{
+		.image_type_id = FWU_FVP_INITRAMFS_IMAGE_GUID,
+		.fw_name = u"INITRAMFS",
+		.image_index = FW_IMAGE_INDEX_INITRAMFS,
+	},
+	{
+		.image_type_id = FWU_DUMMY_START_IMAGE_GUID,
+		.fw_name = u"DUMMY_START",
+		.image_index = FW_IMAGE_INDEX_DUMMY_START,
+	},
+	{
+		.image_type_id = FWU_DUMMY_END_IMAGE_GUID,
+		.fw_name = u"DUMMY_END",
+		.image_index = FW_IMAGE_INDEX_DUMMY_END,
+	},
+};
+
+struct efi_capsule_update_info update_info = {
+	.num_images = CAPSULE_PAYLOADS_MAX_COUNT,
+};
+
+#endif /* EFI_HAVE_CAPSULE_SUPPORT */
+
 static int corstone1000_boot_idx;
 
 static struct mm_region corstone1000_mem_map[] = {
@@ -79,6 +209,12 @@ struct mm_region *mem_map = corstone1000_mem_map;
 
 int board_init(void)
 {
+#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
+	if (!strcmp(DEVICE_TREE, "corstone1000-fvp"))
+		update_info.images = fw_fvp_images;
+	else
+		update_info.images = fw_mps3_images;
+#endif
 	return 0;
 }
 
diff --git a/configs/corstone1000_defconfig b/configs/corstone1000_defconfig
index 80163580f85..5b10e3f7484 100644
--- a/configs/corstone1000_defconfig
+++ b/configs/corstone1000_defconfig
@@ -10,11 +10,16 @@ CONFIG_DEFAULT_DEVICE_TREE="corstone1000-mps3"
 CONFIG_SYS_BOOTM_LEN=0x800000
 CONFIG_SYS_LOAD_ADDR=0x82100000
 CONFIG_IDENT_STRING=" corstone1000 aarch64 "
+CONFIG_FWU_NUM_IMAGES_PER_BANK=4
 CONFIG_EFI_MM_COMM_TEE=y
 CONFIG_FFA_SHARED_MM_BUF_SIZE=4096
 CONFIG_FFA_SHARED_MM_BUF_OFFSET=0
 CONFIG_FFA_SHARED_MM_BUF_ADDR=0x02000000
+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
 CONFIG_EFI_CAPSULE_ON_DISK=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
+CONFIG_EFI_CAPSULE_AUTHENTICATE=y
+CONFIG_EFI_CAPSULE_CRT_FILE="CRT.crt"
 CONFIG_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=3
@@ -38,6 +43,7 @@ CONFIG_CMD_LOADM=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_CACHE=y
+CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_RTC=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_GETTIME=y
@@ -67,4 +73,6 @@ CONFIG_USB_ISP1760=y
 # CONFIG_RANDOM_UUID is not set
 CONFIG_ERRNO_STR=y
 CONFIG_FWU_MULTI_BANK_UPDATE=y
-CONFIG_FWU_MDATA_V1=y
+CONFIG_FWU_MDATA_V2=y
+CONFIG_FWU_ARM_PSA=y
+# CONFIG_TOOLS_MKEFICAPSULE is not set
-- 
2.25.1

