Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B704C79FBD
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 19:48:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF94D83E43;
	Mon,  5 Jan 2026 20:47:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="kSuKFSd+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FFAB8398C; Mon,  5 Jan 2026 20:47:40 +0100 (CET)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76CF283DE4
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 20:47:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
 bh=L85FV/B/WwAAKY47XsY3QtNXZnooirdAXAk+S2mnZv8=; b=kSuKFSd+fx9AhshQvqQIIa2HcV
 rKxvQa9KHL4cWVrgFc2VAseSn1Zr0hJh/bNhm8kf/PTI7aN4ZSWhRh0wN//S4CxayvrLVcslBve9n
 XEu84RsZlzNuh4ctuIu1XsoCjwW9oFcgMJPFjXDOaaMdX+wmz8oypmsgVijPC+D6hb4jZXOZKIvJ9
 rSXua60oYbKnbUW7tuiNhTIDj8Km28ZLY2+Y3DvgkX/n3CPFQ+94peWdMRVtDLHHzk+Di4buXj9Kc
 vhyVycfJno4uIwbsiCiPhmrigPmmXgL6fBDGPYvIX9O41vfhUwu9NATDvjDh6FBmbNSrBafOwUq3K
 pT87TaQg==;
Received: from i53875bd9.versanet.de ([83.135.91.217] helo=phil..)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1vcqY9-001AcR-AQ; Mon, 05 Jan 2026 20:47:33 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: sjg@chromium.org,
	philipp.tomsich@vrull.eu,
	kever.yang@rock-chips.com
Cc: heiko@sntech.de,
	trini@konsulko.com,
	u-boot@lists.denx.de
Subject: [PATCH 06/12] rockchip: board: qnap-ts433: Support multiple models of
 the TSx33 family
Date: Mon,  5 Jan 2026 20:47:17 +0100
Message-ID: <20260105194723.2928608-7-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20260105194723.2928608-1-heiko@sntech.de>
References: <20260105194723.2928608-1-heiko@sntech.de>
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

The RK3568-based NAS systems share a common basic structure and mainly
only differ in the number of available hard-drive slots.

They also contain EEPROMs on their mainboard and backplane, that contain
identifying information and therefore make it possible to determine the
model at runtime.

Add that EEPROM reading and model association, to set the correct
devicetree filename for the OS that gets booted. This allows to just
set fdtdir in extlinux and have u-boot then load the correct devicetree.

For u-boot itself, all models are similar enough up to the emmc that
we wouldn't necessarily need to diversify here, especially as reading
the eeproms gets tricky at the stage where embedded_dtb_select would run.

So for now, we'll still need separate configs per model, but can share
the board-code.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 board/qnap/ts433_rk3568/Makefile    |   7 +
 board/qnap/ts433_rk3568/board.c     | 261 ++++++++++++++++++++++++++++
 configs/qnap-ts433-rk3568_defconfig |   2 +
 3 files changed, 270 insertions(+)
 create mode 100644 board/qnap/ts433_rk3568/Makefile
 create mode 100644 board/qnap/ts433_rk3568/board.c

diff --git a/board/qnap/ts433_rk3568/Makefile b/board/qnap/ts433_rk3568/Makefile
new file mode 100644
index 00000000000..d87f916d00b
--- /dev/null
+++ b/board/qnap/ts433_rk3568/Makefile
@@ -0,0 +1,7 @@
+#
+# (C) Copyright 2026 Heiko Stuebner <heiko@sntech.de>
+#
+# SPDX-License-Identifier:     GPL-2.0+
+#
+
+obj-y	+= board.o
diff --git a/board/qnap/ts433_rk3568/board.c b/board/qnap/ts433_rk3568/board.c
new file mode 100644
index 00000000000..ea43d12942d
--- /dev/null
+++ b/board/qnap/ts433_rk3568/board.c
@@ -0,0 +1,261 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2026 Heiko Stuebner <heiko@sntech.de>
+ */
+
+#include <dm.h>
+#include <env.h>
+#include <i2c_eeprom.h>
+#include <init.h>
+#include <net.h>
+#include <netdev.h>
+#include <vsprintf.h>
+
+#ifndef CONFIG_XPL_BUILD
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define DTB_DIR			"rockchip/"
+
+struct tsx33_model {
+	const char *mb;
+	const u8 mb_pcb;
+	const char *bp;
+	const u8 bp_pcb;
+	const char *name;
+	const char *fdtfile;
+};
+
+/*
+ * gd->board_type is unsigned long, so start at 1 for actual found types
+ * The numeric PCB ids should be matched against the highest available
+ * one for best feature matching. For example Q0AI0_13 gained per-disk
+ * gpios for presence detection and power-control. Similar changes
+ * for the other boards.
+ * So the list should be sorted higest to lowest pcb-id.
+ */
+enum tsx33_device_id {
+	UNKNOWN_TSX33 = 0,
+	Q0AI0_13,
+	Q0AI0_11,
+	Q0AJ0_Q0AM0_12_11,
+	Q0AJ0_Q0AM0_11_10,
+	Q0B20_Q0AW0_12_10,
+	Q0B20_Q0B30_12_10,
+	Q0B20_Q0B30_10_10,
+	QA0110_10,
+	TSX33_MODELS,
+};
+
+/*
+ * All TSx33 devices consist of a mainboard and possible backplane.
+ * Each board has a model identifier and a pcb code written to an eeprom
+ * on it. Later board revisions got per-harddrive presence detection
+ * and power-supply switches, so might need an overlay applied later on
+ * to support those.
+ */
+static const struct tsx33_model tsx33_models[TSX33_MODELS] = {
+	[UNKNOWN_TSX33] = {
+		"UNKNOWN",
+		0,
+		NULL,
+		0,
+		"Unknown TSx33",
+		NULL,
+	},
+	[Q0AI0_13] = {
+		"Q0AI0",
+		13,
+		NULL,
+		0,
+		"TS133",
+		NULL, /* not yet supported */
+	},
+	[Q0AI0_11] = {
+		"Q0AI0",
+		11,
+		NULL,
+		0,
+		"TS133",
+		NULL, /* not yet supported */
+	},
+	[Q0AJ0_Q0AM0_12_11] = {
+		"Q0AJ0",
+		12,
+		"Q0AM0",
+		11,
+		"TS233",
+		NULL, /* not yet supported */
+	},
+	[Q0AJ0_Q0AM0_11_10] = {
+		"Q0AJ0",
+		11,
+		"Q0AM0",
+		10,
+		"TS233",
+		NULL, /* not yet supported */
+	},
+	[Q0B20_Q0AW0_12_10] = {
+		"Q0B20",
+		12,
+		"Q0AW0",
+		10,
+		"TS216G",
+		NULL, /* not yet supported */
+	},
+	[Q0B20_Q0B30_12_10] = {
+		"Q0B20",
+		12,
+		"Q0B30",
+		10,
+		"TS433",
+		DTB_DIR "rk3568-qnap-ts433.dtb",
+	},
+	[Q0B20_Q0B30_10_10] = {
+		"Q0B20",
+		10,
+		"Q0B30",
+		10,
+		"TS433",
+		DTB_DIR "rk3568-qnap-ts433.dtb",
+	},
+	[QA0110_10] = {
+		/*
+		 * The board ident in the original firmware is longer here.
+		 * Likely the field order is different in the ident string.
+		 * So this needs an EEPROM dump to figure out.
+		 */
+		"QA0110",
+		11,
+		NULL,
+		0,
+		"TS433eU",
+		NULL, /* not yet supported */
+	},
+};
+
+/* Field offset and length taken from HAL implementation */
+#define MB_PRODUCT_OFF	0x42
+#define MB_PRODUCT_LEN	32
+#define BP_PRODUCT_OFF	0x6a
+#define BP_PRODUCT_LEN	32
+
+#define PRODUCT_BOARD_OFF	4
+#define PRODUCT_BOARD_LEN	5
+#define PRODUCT_PCB_OFF	9
+#define PRODUCT_PCB_LEN	2
+#define PRODUCT_BOM_OFF	11
+#define PRODUCT_BOM_LEN	1
+
+static void tsx33_decode_product(char *product, char *board, int *pcb)
+{
+	strncpy(board, product + PRODUCT_BOARD_OFF, PRODUCT_BOARD_LEN);
+
+	/* add an artificial end to the PCB string */
+	product[PRODUCT_BOM_OFF] = '\0';
+	*pcb = (int)simple_strtol(product + PRODUCT_PCB_OFF, NULL, 0);
+}
+
+static int tsx33_setup_device(int type, const struct tsx33_model *model)
+{
+	if (!model->bp)
+		printf("Type:  QNAP %s (%s_%d)\n", model->name,
+		       model->mb, model->mb_pcb);
+	else
+		printf("Type:  QNAP %s (%s_%s_%d_%d)\n", model->name, model->mb,
+		       model->bp, model->mb_pcb, model->bp_pcb);
+
+	gd->board_type = type;
+
+	if (!model->fdtfile) {
+		printf("No board-specific devicetree found, functionality might be degraded.\n");
+		return 0;
+	}
+
+	return env_set("fdtfile", model->fdtfile);
+}
+
+static int tsx33_detect_device(void)
+{
+	struct udevice *dev;
+	char product[MB_PRODUCT_LEN];
+	char mb_board[PRODUCT_BOARD_LEN] = { 0 };
+	char bp_board[PRODUCT_BOARD_LEN] = { 0 };
+	int mb_pcb = 0, bp_pcb = 0;
+	int ret, i;
+
+	/*
+	 * Init to 0, for no specific board found.
+	 * This allows us to run on similar devices for initial bringup.
+	 */
+	gd->board_type = 0;
+
+	/* Get mainboard eeprom, this will always be present */
+	ret = uclass_get_device_by_name(UCLASS_I2C_EEPROM, "eeprom@54", &dev);
+	if (ret)
+		return ret;
+
+	ret = i2c_eeprom_read(dev, MB_PRODUCT_OFF, product, MB_PRODUCT_LEN);
+	if (ret)
+		return ret;
+
+	tsx33_decode_product(product, mb_board, &mb_pcb);
+
+	/* Try to get backplane eeprom, only available if a backplane exists */
+	ret = uclass_get_device_by_name(UCLASS_I2C_EEPROM, "eeprom@56", &dev);
+	if (ret)
+		goto search_model;
+
+	ret = i2c_eeprom_read(dev, BP_PRODUCT_OFF, product, BP_PRODUCT_LEN);
+	if (ret)
+		goto search_model;
+
+	tsx33_decode_product(product, bp_board, &bp_pcb);
+
+search_model:
+	for (i = 0; i < TSX33_MODELS; i++) {
+		const struct tsx33_model *model = &tsx33_models[i];
+
+		/*
+		 * Check if mainboard does not match the entry.
+		 * Condition to meet: Either board-name differs or model
+		 * pcb-rev is bigger than the one read from the eeprom.
+		 */
+		if (strncmp(model->mb, mb_board, PRODUCT_BOARD_LEN) ||
+		    model->mb_pcb > mb_pcb)
+			continue;
+
+		/*
+		 * Mainboard matches and there is no backplane found
+		 * nor expected.
+		 */
+		if (!bp_pcb && !model->bp)
+			return tsx33_setup_device(i, model);
+
+		/* we expect a backplane, but the entry does not have one */
+		if (!model->bp)
+			continue;
+
+		if (!strncmp(model->bp, bp_board, PRODUCT_BOARD_LEN) &&
+		    model->bp_pcb <= bp_pcb)
+			return tsx33_setup_device(i, model);
+	}
+
+	printf("Type: No matching type found for %s_%s_%d_%d\n", mb_board,
+	       bp_board, mb_pcb, bp_pcb);
+
+	return -ENODEV;
+}
+
+int rk_board_late_init(void)
+{
+	int ret;
+
+	/* If detection fails, we'll still try to continue */
+	ret = tsx33_detect_device();
+	if (ret)
+		printf("Unable to detect device type: %d\n", ret);
+
+	return 0;
+}
+#endif
diff --git a/configs/qnap-ts433-rk3568_defconfig b/configs/qnap-ts433-rk3568_defconfig
index ebcd3b69e90..dfb240ed70f 100644
--- a/configs/qnap-ts433-rk3568_defconfig
+++ b/configs/qnap-ts433-rk3568_defconfig
@@ -24,6 +24,7 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF=y
+CONFIG_BOARD_TYPES=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
@@ -50,6 +51,7 @@ CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MISC=y
+CONFIG_I2C_EEPROM=y
 CONFIG_SUPPORT_EMMC_RPMB=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
-- 
2.47.2

