Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E014AC982D2
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 17:20:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8F6DE60C12;
	Thu, 17 Sep 2026 17:20:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J-KEqgqhCKJf; Thu, 17 Sep 2026 17:20:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 833A260BF1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789665615;
	b=nMGVcUdjpXTwdufeV4EErtUmkZD36+7GBBvm4R4YAcq2zU2Rq0KnrH3KvKlUgVsBbmuL
	 xG15Fr3FresSoExWSJ6R2YfkfCGltUIlXjC9o+86BCKKtDMaxQ6PcZgjhDV2GTWdJpx8T
	 LfNO8kSOslEUo+zDHjnlNZx2PByrTTD449eFoQjiRQ9Hh1ROnYjnH+ilr5zfpVjodSAO6
	 uOBZA7d1zryGZEdc4LXhDxmpiBqWZHUCH3tnxkVDkvANAtXVlaHnw6nXrtIICdvROYD1F
	 i4ibVnr/OHzPoZGSbLHrfM/bPisjnHWeAZ59WSj2sAiQklxbh5F7SuAmXlkDu9K97lQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789665615;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rqz1OiHl/SWaqtEyNPThqQoN2Nf9/kVXO7FTlqcJaqs=;
	b=GqZuXniX0zUR5MuUg9G0BbGK2am5s4fL32rxRhD3hASOWxf2EgVsWf0Zay17CiQD6QRU
	 QIjZUnTxWL4kLqVHVzWWgqs5XDWoeRE1iXCf3MbL4btJB3vB6v01Rgeq8zvntSwzIxBE1
	 mIOksEinZEawnjq26KMN/JKvCmRn9Gjfbc0MVVWdIGtvTvcnjzhCHCzIbVpRPTeGdbPD/
	 bDLcx6fOYm0xfoYHrXt1xXORSmctOOwlybSlyL4jeMUBQLeO1CBBJB2XH8Y1w5wEfe24Q
	 Sfzg+/hbPZrLuS2f6zjwfAycEEF8d48Kd9qN2B5LV6o0V0AvE4GqnxwobXP4+CIx+5Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789665615;
	bh=rqz1OiHl/SWaqtEyNPThqQoN2Nf9/kVXO7FTlqcJaqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n25VpEYoM29SABkYuAJm0xYrdZrW6u85DD2HvF5fwYaF+AstY/xMEyxOUnZfqRpFW
	 l6szpX+yDOzMf+Yz4NqtMe/wb8tzul4TtqTINMWtem2hmawSU9oX/i4ov2Sg9UKZsM
	 grjEgyu6q6W8yNZVfiCHLATbP4xm69vt7i8Od9SLhdJUXfC/iHzZ8vwrshW0kcSyn0
	 l+w8ZzPk7eC3cSkyTTTQOxqd5R649htL/E+l9L4xA9I6npHIHigG9eOqZBzdPtrhBK
	 HmUEXUe5k2HCTMmSVM5sRvrOdnZSPvTbx5sAq2BjOyZvcxo2cNR7ttaiRoR/1NlQT5
	 m+xVal7aNSSNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 833A260BF1;
	Thu, 17 Sep 2026 17:20:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B5B85465
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:19:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B36F140446
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:19:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AibThgxXqqvt for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 17:19:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 67D5440378
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789665553;
 b=TJgWga0ly9yqdkypcTL+eaWrJf3dLYcBLZy6TSED+QK7ygSHcAgQUbol1XJjgBMX8Ti7
 9rOsebKRn+whRUlUm+hvYQd3We/Cvtpaijn7w8lKUcyqnje4sn1S0YT1W1pbh2F4+sUaq
 qF5lq8r4/bmGtL+Afp39r41Y9O7vFu3AC94YtVvVUjNGIiZ2YYPM1mjZyZBoo5RLwUJ7r
 5I8seNlknlbXPA2nNSvaL0b+U+hx48zuG1OZVvjIIj40cdVR87Twq+x7xpLhIkznvftvu
 bqGilDhTWngGm2AHb5ZSM6xdPjrvIeVlUApOKxrqnGQcGy9rozyZ/HF5V7/QQVm3bqg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789665553;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=rqz1OiHl/SWaqtEyNPThqQoN2Nf9/kVXO7FTlqcJaqs=;
 b=j+CDQDVsat51kD8Hl89HVYLYHJS53qW/eeACJUD88c5g8365HU1YYCaAuV/eaZtxxfiZ
 2jVwjfMCd+trjxF5VNYOopI4oonAYsqj2+ykIA9eLzP5MmtwT79AOHRuPCCA4gGKzBmK4
 lMsJ2fNw1lmVun9phG3hpUgUiG0dpqmkDGa0LpGjiyp75Fz/VZoiv6gpO5kX7p+deq/MX
 9+UehccyqOf+AyyDOi5tQ2QIUQ7e4pcj4ZMix9iDiU1Yvfvlyx4J5g83HKU2VExc3exFY
 7HP3ymQBDMmPrsB87VfIPfgNgXPys7t/NkOB7HLFpntdWtxi4yVodXR5lcl3HUbIbbg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=IfkRIbvJ; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=IfkRIbvJ
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 67D5440378
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:19:13 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0613B1F02;
 Thu, 17 Sep 2026 10:19:09 -0700 (PDT)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABFD33F7B4;
 Thu, 17 Sep 2026 10:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789665552; bh=pngKKTCxCJaBHF8ggnkUFiI+3RJSxhxOJhClLz4YhJ8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IfkRIbvJa3wMdeXQnKkcMvoGW/h99vfXOgrorTdoksVLOpk92c+M4Ned6lBxsbfUB
 bzrEIJcHuQFyBD7rfJJTSJlKWhHHvPAKMqe04+ewOypTxX0CrkBORPyPj+Vb5pkr1N
 vZyJo8GtJNgAHhVpLkrWRnq5RnXOoWuWppzzQ+lQ=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alex Chapman <alex.chapman@arm.com>, Tom Rini <trini@konsulko.com>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>
Subject: [PATCH v6 20/24] fwu_arm_psa: corstone1000: Enable FWU support
Date: Thu, 17 Sep 2026 18:18:06 +0100
Message-ID: <20260917171810.4122899-21-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917171810.4122899-1-harsimransingh.tungal@arm.com>
References: <20260917171810.4122899-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 17 Sep 2026 17:19:43 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>

Provide the update_info structure and FWU configs for Corstone-1000

update_info defines the image to be used for FWU.
The FWU configs enabled are the FWU Arm PSA configs.

Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Signed-off-by: Alex Chapman <alex.chapman@arm.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Hugues Kamba Mpiana <hugues.kambampiana@arm.com>
---
 board/armltd/corstone1000/corstone1000.c | 142 ++++++++++++++++++++++-
 configs/corstone1000_defconfig           |  13 ++-
 lib/efi_loader/Kconfig                   |   8 ++
 3 files changed, 159 insertions(+), 4 deletions(-)

diff --git a/board/armltd/corstone1000/corstone1000.c b/board/armltd/corstone1000/corstone1000.c
index eb0f9c06849..b255a0d78ad 100644
--- a/board/armltd/corstone1000/corstone1000.c
+++ b/board/armltd/corstone1000/corstone1000.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * (C) Copyright 2022 ARM Limited
+ * (C) Copyright 2022, 2025-2026 Arm Limited
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
@@ -77,6 +207,16 @@ static struct mm_region corstone1000_mem_map[] = {
 
 struct mm_region *mem_map = corstone1000_mem_map;
 
+int board_init(void)
+{
+#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
+	if (!strcmp(DEVICE_TREE, "corstone1000-fvp"))
+		update_info.images = fw_fvp_images;
+	else
+		update_info.images = fw_mps3_images;
+#endif
+	return 0;
+}
 int dram_init(void)
 {
 	gd->ram_size = PHYS_SDRAM_1_SIZE;
diff --git a/configs/corstone1000_defconfig b/configs/corstone1000_defconfig
index 876b915b6a4..ef45d42f50e 100644
--- a/configs/corstone1000_defconfig
+++ b/configs/corstone1000_defconfig
@@ -10,11 +10,17 @@ CONFIG_DEFAULT_DEVICE_TREE="corstone1000-mps3"
 CONFIG_SYS_BOOTM_LEN=0x800000
 CONFIG_SYS_LOAD_ADDR=0x82100000
 CONFIG_IDENT_STRING=" corstone1000 aarch64 "
+CONFIG_FWU_NUM_IMAGES_PER_BANK=4
+CONFIG_FWU_NUM_BANKS=2
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
@@ -26,7 +32,7 @@ CONFIG_SYS_CBSIZE=512
 CONFIG_LOGLEVEL=7
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_DISPLAY_BOARDINFO is not set
-# CONFIG_BOARD_INIT is not set
+CONFIG_BOARD_INIT=y
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SYS_PROMPT="corstone1000# "
 # CONFIG_CMD_CONSOLE is not set
@@ -39,6 +45,7 @@ CONFIG_CMD_LOADM=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_CACHE=y
+CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_RTC=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_GETTIME=y
@@ -66,5 +73,5 @@ CONFIG_USB=y
 CONFIG_USB_ISP1760=y
 # CONFIG_RANDOM_UUID is not set
 CONFIG_ERRNO_STR=y
-CONFIG_FWU_MULTI_BANK_UPDATE=y
-CONFIG_FWU_MDATA_V1=y
+CONFIG_FWU_ARM_PSA=y
+# CONFIG_TOOLS_MKEFICAPSULE is not set
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 09932a98d6e..f01889fd6d3 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -375,11 +375,19 @@ config FWU_ARM_PSA
 		(ARM64 || SANDBOX) && \
 		!FWU_MULTI_BANK_UPDATE
 	select EFI_CAPSULE_FIRMWARE
+	select EFI_PARTITION
+	imply EFI_CAPSULE_ON_DISK_EARLY
 	help
 	  Select this option if you want to enable firmware management protocol
 	  driver that supports the Arm PSA firmware update specification as
 	  mentioned in https://developer.arm.com/documentation/den0118/a/
 
+config FWU_NUM_BANKS
+	int "Number of Banks defined by the platform"
+	depends on FWU_ARM_PSA
+	help
+	  Define the number of banks of firmware images on a platform
+
 config FWU_NUM_IMAGES_PER_BANK
 	int "Number of firmware images per bank"
 	depends on FWU_ARM_PSA
-- 
2.43.0

