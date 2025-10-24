Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E254CCD1BF
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 17:38:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C8CA838BB;
	Fri, 24 Oct 2025 19:37:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="DqcGoIKC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43D7A83835; Fri, 24 Oct 2025 19:29:25 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43B7D83677
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 19:29:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 148EB20D77;
 Fri, 24 Oct 2025 19:29:23 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lGghEv1aMTaM; Fri, 24 Oct 2025 19:29:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1761326962; bh=IhDY6EqX8Gswcq3pyetr+oMSevMAhhdZy74rpu9NcYM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=DqcGoIKCcHE3cNWw4QPhbS52PhqxOaWWpnmp6XUA8FRqikN6T0oWrTUZ9v1FIwOec
 kTenP+DoxvUbn+Cubd8HGo4d6fOY8GbaDHpWJ8qhyDIvnp7853H4fmRYSfYTJqPCpM
 ZdpZBdpaFeJeHPLK+i4lviKBI4SbHGTJDmXt0yCymIB1FvDGeRLELZSrbUrSrMJaaW
 dp/jBaDiFp6j1ZzWtjZKuVGkTZa+DiJWG/hogZUsrbHNRefGSaEomZd0muDgFHAMjB
 EXiOnrO0zGQpwei5xgstV3Q5U+O/oFFZgP93dNSgSkQEzd61wWmZ6l5T4yPVO6Vp3A
 OXMvGiNKdyXOw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 24 Oct 2025 22:58:28 +0530
Subject: [PATCH v2 2/3] board: samsung: exynos-mobile: add exynos7870
 support and three devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-board-exynos-mobile-v2-2-e6fce69e60c3@disroot.org>
References: <20251024-board-exynos-mobile-v2-0-e6fce69e60c3@disroot.org>
In-Reply-To: <20251024-board-exynos-mobile-v2-0-e6fce69e60c3@disroot.org>
To: u-boot@lists.denx.de
Cc: Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Henrik Grimler <henrik@grimler.se>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761326916; l=6976;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=IhDY6EqX8Gswcq3pyetr+oMSevMAhhdZy74rpu9NcYM=;
 b=LrihamVMPxAQkG8t6FxbLtwfcnEjDhIzGF8S9v3J6oAXbBBKjsm4go2CdKaqgJwBGUXYVKfN3
 Qw0AZ6J/d/oB3sUBWsW42/hYHzABxsa8kqDM/bP3fEYLV/qrPMjhkkg
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=
X-Mailman-Approved-At: Fri, 24 Oct 2025 19:37:56 +0200
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

Add basic support for the Exynos7870 SoC, this includes device tree
match logic using multiple boards, where devices use a stub dtb in
Samsung's QCDT format. S-BOOT, the previous stage bootloader, places its
cmdline arguments there, which has identifying information.

This is added with support for three devices:
 * Samsung Galaxy A2 Core (codename: a2corelte)
 * Samsung Galaxy J6 (codename: j6lte)
 * Samsung Galaxy J7 Prime (codename: on7xelte)

Add their device trees in the defconfig, and also enable the clock and
pin controller drivers.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 .../samsung/exynos-mobile/debug-exynos7870.config  |   7 ++
 board/samsung/exynos-mobile/exynos-mobile.c        | 116 +++++++++++++++++++++
 configs/exynos-mobile_defconfig                    |   4 +
 3 files changed, 127 insertions(+)

diff --git a/board/samsung/exynos-mobile/debug-exynos7870.config b/board/samsung/exynos-mobile/debug-exynos7870.config
new file mode 100644
index 0000000000000000000000000000000000000000..1aa506a675d30b025651dd4575aee36de82b8d07
--- /dev/null
+++ b/board/samsung/exynos-mobile/debug-exynos7870.config
@@ -0,0 +1,7 @@
+CONFIG_DEBUG_UART=y
+CONFIG_DEBUG_UART_BASE=0x13820000
+CONFIG_DEBUG_UART_CLOCK=133250000
+CONFIG_DEBUG_UART_S5P=y
+CONFIG_LOG=y
+CONFIG_LOG_CONSOLE=y
+CONFIG_LOG_MAX_LEVEL=8
diff --git a/board/samsung/exynos-mobile/exynos-mobile.c b/board/samsung/exynos-mobile/exynos-mobile.c
index c16281dbc36fb07cf5e9f64604632bb98393cd86..8ef38816abf73ae5f897ea06cca43e528a570b21 100644
--- a/board/samsung/exynos-mobile/exynos-mobile.c
+++ b/board/samsung/exynos-mobile/exynos-mobile.c
@@ -13,6 +13,7 @@
 #include <env.h>
 #include <errno.h>
 #include <init.h>
+#include <limits.h>
 #include <linux/sizes.h>
 #include <lmb.h>
 #include <part.h>
@@ -53,6 +54,96 @@ static struct mm_region exynos_mem_map[CONFIG_NR_DRAM_BANKS + 2] = {
 
 struct mm_region *mem_map = exynos_mem_map;
 
+static const u64 exynos7870_common_dram_bank_bases[CONFIG_NR_DRAM_BANKS] = {
+	0x40000000, 0x80000000, 0x100000000,
+};
+
+static const char *exynos_prev_bl_get_bootargs(void)
+{
+	void *prev_bl_fdt_base = (void *)get_prev_bl_fdt_addr();
+	int chosen_node_offset, ret;
+	const struct fdt_property *bootargs_prop;
+
+	ret = fdt_check_header(prev_bl_fdt_base);
+	if (ret < 0) {
+		log_err("%s: FDT is invalid (FDT_ERR %d)\n", __func__, ret);
+		return NULL;
+	}
+
+	ret = fdt_path_offset(prev_bl_fdt_base, "/chosen");
+	chosen_node_offset = ret;
+	if (ret < 0) {
+		log_err("%s: /chosen node not found (FDT_ERR %d)\n", __func__,
+			ret);
+		return NULL;
+	}
+
+	bootargs_prop = fdt_get_property(prev_bl_fdt_base, chosen_node_offset,
+					 "bootargs", &ret);
+	if (!bootargs_prop) {
+		log_err("%s: /chosen/bootargs property not found (FDT_ERR %d)\n",
+			__func__, ret);
+		return NULL;
+	}
+
+	return bootargs_prop->data;
+}
+
+static int exynos7870_fdt_match(struct exynos_board_info *board_info)
+{
+	const char *prev_bl_bootargs;
+	int val, ret;
+
+	prev_bl_bootargs = exynos_prev_bl_get_bootargs();
+	if (!prev_bl_bootargs)
+		return -1;
+
+	/*
+	 * Read the cmdline property which stores the
+	 * bootloader/firmware version. An example value of the option
+	 * can be: "J600GDXU3ARH5". This can be used to verify the model
+	 * of the device.
+	 */
+	ret = cmdline_get_arg(prev_bl_bootargs, "androidboot.bootloader", &val);
+	if (ret < 0) {
+		log_err("%s: unable to find property for bootloader version (%d)\n",
+			__func__, ret);
+		return -1;
+	}
+
+	if (strncmp(prev_bl_bootargs + val, board_info->match_model,
+		    strlen(board_info->match_model)))
+		return -1;
+
+	/*
+	 * Read the cmdline property which stores the hardware revision.
+	 * This is required to allow selecting one of multiple dtbs
+	 * available of a single device, varying in hardware changes in
+	 * different revisions.
+	 */
+	ret = cmdline_get_arg(prev_bl_bootargs, "androidboot.revision", &val);
+	if (ret < 0)
+		ret = cmdline_get_arg(prev_bl_bootargs, "androidboot.hw_rev", &val);
+	if (ret < 0) {
+		log_err("%s: unable to find property for bootloader revision (%d)\n",
+			__func__, ret);
+		return -1;
+	}
+
+	if (strtoul(prev_bl_bootargs + val, NULL, 10) > board_info->match_max_rev)
+		return -1;
+
+	/*
+	 * Read the cmdline property which stores the serial number.
+	 * Store this in the board info struct.
+	 */
+	ret = cmdline_get_arg(prev_bl_bootargs, "androidboot.serialno", &val);
+	if (ret > 0)
+		strlcpy(board_info->serial, prev_bl_bootargs + val, ret);
+
+	return 0;
+}
+
 /*
  * This array is used for matching the models and revisions with the
  * devicetree used by U-Boot. This allows a single U-Boot to work on
@@ -62,6 +153,31 @@ struct mm_region *mem_map = exynos_mem_map;
  * board names.
  */
 static struct exynos_board_info exynos_board_info_match[] = {
+	{
+		/* Samsung Galaxy A2 Core */
+		.name = "a2corelte",
+		.chip = "exynos7870",
+		.dram_bank_bases = exynos7870_common_dram_bank_bases,
+		.match = exynos7870_fdt_match,
+		.match_model = "A260",
+		.match_max_rev = U8_MAX,
+	}, {
+		/* Samsung Galaxy J6 */
+		.name = "j6lte",
+		.chip = "exynos7870",
+		.dram_bank_bases = exynos7870_common_dram_bank_bases,
+		.match = exynos7870_fdt_match,
+		.match_model = "J600",
+		.match_max_rev = U8_MAX,
+	}, {
+		/* Samsung Galaxy J7 Prime */
+		.name = "on7xelte",
+		.chip = "exynos7870",
+		.dram_bank_bases = exynos7870_common_dram_bank_bases,
+		.match = exynos7870_fdt_match,
+		.match_model = "G610",
+		.match_max_rev = U8_MAX,
+	},
 };
 
 static void exynos_parse_dram_banks(const struct exynos_board_info *board_info,
diff --git a/configs/exynos-mobile_defconfig b/configs/exynos-mobile_defconfig
index 2dbf90010bac8182ea202a484252a5b527eb6ad9..81a2c4d337314da6d92e4681606e1a5dcbfad745 100644
--- a/configs/exynos-mobile_defconfig
+++ b/configs/exynos-mobile_defconfig
@@ -7,6 +7,7 @@ CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SYS_MALLOC_F_LEN=0x16000
 CONFIG_TARGET_EXYNOS_MOBILE=y
 CONFIG_NR_DRAM_BANKS=3
+CONFIG_DEFAULT_DEVICE_TREE="exynos/exynos7870-a2corelte"
 CONFIG_SYS_BOOTM_LEN=0x2000000
 CONFIG_SYS_LOAD_ADDR=0x80000000
 CONFIG_ARMV8_CNTFRQ_BROKEN=y
@@ -24,11 +25,13 @@ CONFIG_CMD_POWEROFF=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_EFI_PARTITION=y
 CONFIG_OF_UPSTREAM=y
+CONFIG_OF_LIST="exynos/exynos7870-a2corelte exynos/exynos7870-j6lte exynos/exynos7870-on7xelte"
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_BUTTON=y
 CONFIG_BUTTON_REMAP_PHONE_KEYS=y
 CONFIG_CLK=y
 CONFIG_CLK_CCF=y
+CONFIG_CLK_EXYNOS7870=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0xdead0000
 CONFIG_FASTBOOT_FLASH=y
@@ -44,6 +47,7 @@ CONFIG_MMC_DW=y
 CONFIG_PHY=y
 CONFIG_PHY_EXYNOS_USBDRD=y
 CONFIG_PINCTRL=y
+CONFIG_PINCTRL_EXYNOS78x0=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_S2MPS11=y
 CONFIG_DM_REGULATOR=y

-- 
2.51.0

