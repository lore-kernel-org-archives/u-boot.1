Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A797AC25B75
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 11:16:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20C9D886EB;
	Wed,  8 May 2024 13:16:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hf8LWrye";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAF6F886EB; Wed,  8 May 2024 13:16:21 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AB9C882C8
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 13:16:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2b433dd2566so3021221a91.2
 for <u-boot@lists.denx.de>; Wed, 08 May 2024 04:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715166978; x=1715771778; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=AEqhZn8a1z3vtKaWroAbHTihipiEum0K1w+Lm+YGP8U=;
 b=hf8LWryesC47ATG6fA5hkATya8nnUha2g6FUhN2R+DHT4X/zsYXAfEOr8NirZACfMo
 MpzEuknAYniaPw+/nnNsX1xKDhFz2Jnzm0Ulpuy3wF9Ji46XUI2B74vy6DhhRYnNbIt8
 0T/MzbcEwu+EZDYO9RhxaBwWshF5m1PKekhkFCxLuCwOBxj1d+XcbV087Ev6kaNLNgGi
 8lmSDpml5dummAnXJioMETgTYReSqTKgnuka/WccA09beIaPgJlnk+44DIlHYsPv7f8c
 Wsw3mps9UuGpGss+g4XX3+/YnZzeLmpyOWgm+MmoeHF6DnYDiAKvhNVS6hOke7O1YJcl
 FVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715166978; x=1715771778;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AEqhZn8a1z3vtKaWroAbHTihipiEum0K1w+Lm+YGP8U=;
 b=gPUXacMZNXpPBcG9KLy5e+Y4M6nD7XkKnMRuDph79mgwwtLxftm0HMFwVT/XIh19dh
 2BfEC+6Fb8YhpByj0LFP4/mNXIx++uTtQ3fDjKeZmPwKb6SdOTT4eCanaOBsfuIrHYhc
 MOBpuCwzHLyptzYCezGZLixAjao8PPP47Aoqc4EcA4lsIFOzNYti6EmJ5LNt8Akk674A
 SnpQdwdatA2JQ+KrCBItjPymgeYxqudwZClNejW/+e8GQT+a3/+gFp+SDk79VPM6X661
 Z83oPOPX/tn7O/foiU9DSd2bWkGXy19BchPaONHPvXqK6Y+Wlr9qhbtNvH1Cwx8WBoe1
 94ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCWM6yumnWjkk4sFFMWkHexcExP+Jbmk/YsZYqieLgNwjkkN+n6LkImlBCMc/Bu7by1mxIKLpirRHSxUwXvUBvkwejnzqA==
X-Gm-Message-State: AOJu0YxKG0LFMFu7WPdLBGETNwYmx31w1CtVnOdr370WCIa00La+GFDN
 MMlYNRun5rnnhDVwViqX5F35n/6o3MQn3agOm50W0TrsTq+E1Y0b
X-Google-Smtp-Source: AGHT+IFXFylD9pzS+XguQ38sn7z6+AyEa54Z+VI1oiynuG+OcXjrZ/lO5CbE+dbn4s2R5PZFZ2I22w==
X-Received: by 2002:a17:90b:4b4b:b0:2b4:32ae:7217 with SMTP id
 98e67ed59e1d1-2b6169d96d4mr1897563a91.30.1715166977396; 
 Wed, 08 May 2024 04:16:17 -0700 (PDT)
Received: from ownia.localdomain (vps-bd302c4a.vps.ovh.ca.
 [2402:1f00:8000:800::34b0]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b628ca53c3sm1171510a91.46.2024.05.08.04.16.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 04:16:17 -0700 (PDT)
From: Weizhao Ouyang <o451686892@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 John Keeping <john@metanate.com>, Dragan Simic <dsimic@manjaro.org>,
 Weizhao Ouyang <o451686892@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Ben Wolsieffer <benwolsieffer@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH] arm: rockchip: using generic capsule update mechanism
Date: Wed,  8 May 2024 19:16:00 +0800
Message-Id: <20240508111600.154919-1-o451686892@gmail.com>
X-Mailer: git-send-email 2.40.1
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

Currently Rockchip's capsule update mechanism only accepts capsules in
form of a mmc partition, but a generic capsule update mechanism should
be used to satisfy the universal requirements.

Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
---
 arch/arm/mach-rockchip/board.c              | 153 ------------------
 board/radxa/rockpi4-rk3399/rockpi4-rk3399.c | 166 +++++++++++++++++++-
 2 files changed, 158 insertions(+), 161 deletions(-)

diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
index cd226844b6..73fbb3f58c 100644
--- a/arch/arm/mach-rockchip/board.c
+++ b/arch/arm/mach-rockchip/board.c
@@ -35,155 +35,6 @@
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
 __weak int rk_board_late_init(void)
 {
 	return 0;
@@ -193,10 +44,6 @@ int board_late_init(void)
 {
 	setup_boot_mode();
 
-#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && IS_ENABLED(CONFIG_EFI_PARTITION)
-	gpt_capsule_update_setup();
-#endif
-
 	return rk_board_late_init();
 }
 
diff --git a/board/radxa/rockpi4-rk3399/rockpi4-rk3399.c b/board/radxa/rockpi4-rk3399/rockpi4-rk3399.c
index a533128b92..01c3b7d5a2 100644
--- a/board/radxa/rockpi4-rk3399/rockpi4-rk3399.c
+++ b/board/radxa/rockpi4-rk3399/rockpi4-rk3399.c
@@ -4,22 +4,132 @@
  */
 
 #include <dm.h>
+#include <mmc.h>
+#include <part.h>
 #include <efi_loader.h>
 
 #define ROCKPI4_UPDATABLE_IMAGES	2
 
-#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
-static struct efi_fw_image fw_images[ROCKPI4_UPDATABLE_IMAGES] = {0};
+#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && IS_ENABLED(CONFIG_EFI_PARTITION)
+
+#define DFU_ALT_BUF_LEN			SZ_1K
+
+static struct efi_fw_image *fw_images = {0};
+static struct efi_fw_image fw_images_d[ROCKPI4_UPDATABLE_IMAGES] = {0};
 
 struct efi_capsule_update_info update_info = {
 	.num_images = ROCKPI4_UPDATABLE_IMAGES,
-	.images = fw_images,
+	.images = fw_images_d,
 };
 
-#endif
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
+	ret = mmc_init(mmc);
+	if (ret)
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
 
-#ifndef CONFIG_SPL_BUILD
-#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && IS_ENABLED(CONFIG_EFI_PARTITION)
 static bool board_is_rockpi_4b(void)
 {
 	return of_machine_is_compatible("radxa,rockpi4b");
@@ -30,7 +140,7 @@ static bool board_is_rockpi_4c(void)
 	return of_machine_is_compatible("radxa,rockpi4c");
 }
 
-void rockchip_capsule_update_board_setup(void)
+static void rockchip_capsule_update_board_setup(void)
 {
 	if (board_is_rockpi_4b()) {
 		efi_guid_t idbldr_image_type_guid =
@@ -54,5 +164,45 @@ void rockchip_capsule_update_board_setup(void)
 		fw_images[1].fw_name = u"ROCKPI4C-UBOOT";
 	}
 }
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
 #endif /* CONFIG_EFI_HAVE_CAPSULE_SUPPORT && CONFIG_EFI_PARTITION */
-#endif /* !CONFIG_SPL_BUILD */
+
+int rk_board_late_init(void)
+{
+#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && IS_ENABLED(CONFIG_EFI_PARTITION)
+	gpt_capsule_update_setup();
+#endif
+
+	return 0;
+}
+
-- 
2.40.1

