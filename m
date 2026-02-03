Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 245B1E8782A
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 13:36:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8A9984206;
	Tue,  3 Feb 2026 14:35:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="fgy7sn/b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A80DD84101; Tue,  3 Feb 2026 14:08:57 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A621B83FFA
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 14:08:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 768882765E;
 Tue,  3 Feb 2026 14:08:55 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p4Glv48bI6iX; Tue,  3 Feb 2026 14:08:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1770124134; bh=71Srj1UAQ+QBTYoyvZ5imOZ5g4X/CsV+/WJEQdl/iIo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=fgy7sn/butpHgmOONRzarUNYH07nmRxdLGwa9Rb7KEmxLFYlMPUDp96Z6oJrKSoDj
 idvE5sDvVpq/Ua4Iv5WWYh3Cq0/sbnxDnRoGdFl5R8MER1OKAbs79q4L6s1iseVx3K
 /HKgL5OM+tK20dsInDiIjPYsyc8VrtbEggK5OzT6XaYhDj02/bijogEx3KSZOq9VLI
 2jc9sj8gPeePWS7+ba2wNU7KOAvHKDnbRHAR21M9e2PNIFPpx/ifxvY9RmnpNWVEYc
 9nf/EUiWx91/5hp1/PrhVsivE7WQk10MJOshouwGBX2RV014n6R692tIc01d9xI/g9
 kmj39uG73Kfzw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Tue, 03 Feb 2026 18:38:41 +0530
Subject: [PATCH 03/11] board: samsung: exynos-mobile: disable MULTI_DTB_FIT
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-exynos-mobile-external-dtb-v1-3-a16a0e57991c@disroot.org>
References: <20260203-exynos-mobile-external-dtb-v1-0-a16a0e57991c@disroot.org>
In-Reply-To: <20260203-exynos-mobile-external-dtb-v1-0-a16a0e57991c@disroot.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Mailman-Approved-At: Tue, 03 Feb 2026 14:35:06 +0100
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

MULTI_DTB_FIT allowed a single U-Boot image to be booted in multiple
devices, but it was not a scalable solution; as more devices are added,
the U-Boot binary is bound to increase, space taken up by devicetrees
which are not even used.

The other approach is to be able to build separate images for multiple
devices using the same "board" defined in U-Boot. This is used by
qcom_phone to support muitiple devices.

Follow the said approach for Exynos devices as well, disable
MULTI_DTB_FIT for this board.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 board/samsung/exynos-mobile/exynos-mobile.c | 154 ----------------------------
 configs/exynos-mobile_defconfig             |   2 -
 2 files changed, 156 deletions(-)

diff --git a/board/samsung/exynos-mobile/exynos-mobile.c b/board/samsung/exynos-mobile/exynos-mobile.c
index c17d7052b1c..412dfa7555c 100644
--- a/board/samsung/exynos-mobile/exynos-mobile.c
+++ b/board/samsung/exynos-mobile/exynos-mobile.c
@@ -13,7 +13,6 @@
 #include <env.h>
 #include <errno.h>
 #include <init.h>
-#include <limits.h>
 #include <linux/sizes.h>
 #include <lmb.h>
 #include <part.h>
@@ -25,17 +24,6 @@ DECLARE_GLOBAL_DATA_PTR;
 #define lmb_alloc(size, addr) \
 	lmb_alloc_mem(LMB_MEM_ALLOC_ANY, SZ_2M, addr, size, LMB_NONE)
 
-struct exynos_board_info {
-	const char *name;
-	const char *chip;
-
-	char serial[64];
-
-	int (*const match)(struct exynos_board_info *);
-	const char *match_model;
-	const u8 match_max_rev;
-};
-
 /*
  * The memory mapping includes all DRAM banks, along with the
  * peripheral block, and a sentinel at the end. This is filled in
@@ -85,94 +73,6 @@ static const char *exynos_prev_bl_get_bootargs(void)
 	return bootargs_prop->data;
 }
 
-static int exynos7870_fdt_match(struct exynos_board_info *board_info)
-{
-	const char *prev_bl_bootargs;
-	int val, ret;
-
-	prev_bl_bootargs = exynos_prev_bl_get_bootargs();
-	if (!prev_bl_bootargs)
-		return -1;
-
-	/*
-	 * Read the cmdline property which stores the
-	 * bootloader/firmware version. An example value of the option
-	 * can be: "J600GDXU3ARH5". This can be used to verify the model
-	 * of the device.
-	 */
-	ret = cmdline_get_arg(prev_bl_bootargs, "androidboot.bootloader", &val);
-	if (ret < 0) {
-		log_err("%s: unable to find property for bootloader version (%d)\n",
-			__func__, ret);
-		return -1;
-	}
-
-	if (strncmp(prev_bl_bootargs + val, board_info->match_model,
-		    strlen(board_info->match_model)))
-		return -1;
-
-	/*
-	 * Read the cmdline property which stores the hardware revision.
-	 * This is required to allow selecting one of multiple dtbs
-	 * available of a single device, varying in hardware changes in
-	 * different revisions.
-	 */
-	ret = cmdline_get_arg(prev_bl_bootargs, "androidboot.revision", &val);
-	if (ret < 0)
-		ret = cmdline_get_arg(prev_bl_bootargs, "androidboot.hw_rev", &val);
-	if (ret < 0) {
-		log_err("%s: unable to find property for bootloader revision (%d)\n",
-			__func__, ret);
-		return -1;
-	}
-
-	if (strtoul(prev_bl_bootargs + val, NULL, 10) > board_info->match_max_rev)
-		return -1;
-
-	/*
-	 * Read the cmdline property which stores the serial number.
-	 * Store this in the board info struct.
-	 */
-	ret = cmdline_get_arg(prev_bl_bootargs, "androidboot.serialno", &val);
-	if (ret > 0)
-		strlcpy(board_info->serial, prev_bl_bootargs + val, ret);
-
-	return 0;
-}
-
-/*
- * This array is used for matching the models and revisions with the
- * devicetree used by U-Boot. This allows a single U-Boot to work on
- * multiple devices.
- *
- * Entries are kept in lexicographical order of board SoCs, followed by
- * board names.
- */
-static struct exynos_board_info exynos_board_info_match[] = {
-	{
-		/* Samsung Galaxy A2 Core */
-		.name = "a2corelte",
-		.chip = "exynos7870",
-		.match = exynos7870_fdt_match,
-		.match_model = "A260",
-		.match_max_rev = U8_MAX,
-	}, {
-		/* Samsung Galaxy J6 */
-		.name = "j6lte",
-		.chip = "exynos7870",
-		.match = exynos7870_fdt_match,
-		.match_model = "J600",
-		.match_max_rev = U8_MAX,
-	}, {
-		/* Samsung Galaxy J7 Prime */
-		.name = "on7xelte",
-		.chip = "exynos7870",
-		.match = exynos7870_fdt_match,
-		.match_model = "G610",
-		.match_max_rev = U8_MAX,
-	},
-};
-
 static void exynos_parse_dram_banks(const void *fdt_base)
 {
 	u64 mem_addr, mem_size = 0;
@@ -331,46 +231,6 @@ static int exynos_fastboot_setup(void)
 	return 0;
 }
 
-int board_fit_config_name_match(const char *name)
-{
-	struct exynos_board_info *board_info;
-	char buf[128];
-	unsigned int i;
-	int ret;
-
-	/*
-	 * Iterate over exynos_board_info_match[] to select the
-	 * appropriate board info struct. If not found, exit.
-	 */
-	for (i = 0; i < ARRAY_SIZE(exynos_board_info_match); i++) {
-		board_info = exynos_board_info_match + i;
-		snprintf(buf, sizeof(buf), "%s-%s", board_info->chip,
-			 board_info->name);
-
-		if (!strcmp(name, buf))
-			break;
-	}
-	if (i == ARRAY_SIZE(exynos_board_info_match))
-		return -1;
-
-	/*
-	 * Execute match logic for the target board. This is separated
-	 * as the process may be different for multiple boards.
-	 */
-	ret = board_info->match(board_info);
-	if (ret)
-		return ret;
-
-	/*
-	 * Store the correct board info struct in gd->board_type to
-	 * allow other functions to access it.
-	 */
-	gd->board_type = (ulong)board_info;
-	log_debug("%s: device detected: %s\n", __func__, name);
-
-	return 0;
-}
-
 int timer_init(void)
 {
 	ofnode timer_node;
@@ -389,21 +249,7 @@ int timer_init(void)
 
 int board_early_init_f(void)
 {
-	const struct exynos_board_info *board_info;
-
-	if (!gd->board_type)
-		return -ENODATA;
-	board_info = (const struct exynos_board_info *)gd->board_type;
-
 	exynos_parse_dram_banks(gd->fdt_blob);
-	/*
-	 * Some devices have multiple variants based on the amount of
-	 * memory and internal storage. The lowest bank base has been
-	 * observed to have the same memory range in all board variants.
-	 * For variants with more memory, the previous bootloader should
-	 * overlay the devicetree with the required extra memory ranges.
-	 */
-	exynos_parse_dram_banks((const void *)get_prev_bl_fdt_addr());
 
 	return 0;
 }
diff --git a/configs/exynos-mobile_defconfig b/configs/exynos-mobile_defconfig
index 3a0b455b169..ead4ea4493e 100644
--- a/configs/exynos-mobile_defconfig
+++ b/configs/exynos-mobile_defconfig
@@ -25,8 +25,6 @@ CONFIG_CMD_POWEROFF=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_EFI_PARTITION=y
 CONFIG_OF_UPSTREAM=y
-CONFIG_OF_LIST="exynos/exynos7870-a2corelte exynos/exynos7870-j6lte exynos/exynos7870-on7xelte"
-CONFIG_MULTI_DTB_FIT=y
 CONFIG_BUTTON=y
 CONFIG_BUTTON_REMAP_PHONE_KEYS=y
 CONFIG_CLK_EXYNOS7870=y

-- 
2.52.0

