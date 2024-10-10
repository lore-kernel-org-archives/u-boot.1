Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85BBCF07A8
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 05:57:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39231891A9;
	Thu, 10 Oct 2024 07:56:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="Ut1arsYf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDA2B890FA; Thu, 10 Oct 2024 07:56:04 +0200 (CEST)
Received: from mta-65-226.siemens.flowmailer.net
 (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 576E0890DF
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 07:55:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 20241010055559eef498cc2895ce7e4b for <u-boot@lists.denx.de>;
 Thu, 10 Oct 2024 07:55:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=tV4DrDemqUcN6H5XpWpN2fo3oAli/E+sxNjfyERGKUA=;
 b=Ut1arsYf1DNpS8kc5UFfuORQPbkl7wnLwK7fdcbkOq020S02kBLNuNwwb+CPeb4mtwpc96
 TQsUnI6Cg3kv13ShRbjE0wq+sq1RVOza6QcjjuxUkMXQuVFg52p/Af3GJoXbyOjClUIMqw1o
 bGBRTzJ0a2XVEershVFTrcwF6kol0XqTjrhik0Ft2TyjQHaT9hW+Tg1MO6lXBbw5gBTBO0a/
 6oYZW0Db5lp+Z8Chq+60Gr0F72VAYvidcApBfEc+p5lg5Vx+ca+9XczCBdZrsP5MqrTYW3Vk
 IjcVVlXgndmefx9yFzKMY3F2AV7rkQfXhpKi+w5BcyYu0Ypg6yj5CyyQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bryan Brattlof <bb@ti.com>,
	Nishanth Menon <nm@ti.com>
Subject: [PATCH 11/11] board: siemens: iot2050: Use sysinfo for board
 initialization
Date: Thu, 10 Oct 2024 07:55:55 +0200
Message-ID: <7e91794807d69731cfef8c0077d859f8d7cdc12a.1728539755.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1728539755.git.jan.kiszka@siemens.com>
References: <cover.1728539755.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
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

From: Li Hua Qian <huaqian.li@siemens.com>

Drop the info structure parsing of the board in favor of our new sysinfo
driver to avoid code duplication.

Signed-off-by: Baocheng Su <baocheng.su@siemens.com>
Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
[Jan: rebasing, split-up, cleanup]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm/mach-k3/am65x/Kconfig |   2 +
 board/siemens/iot2050/board.c  | 142 +++++++++++++++++++--------------
 configs/iot2050_defconfig      |   1 -
 3 files changed, 82 insertions(+), 63 deletions(-)

diff --git a/arch/arm/mach-k3/am65x/Kconfig b/arch/arm/mach-k3/am65x/Kconfig
index f17b641e136..88c6be33a7b 100644
--- a/arch/arm/mach-k3/am65x/Kconfig
+++ b/arch/arm/mach-k3/am65x/Kconfig
@@ -34,6 +34,8 @@ config TARGET_IOT2050_A53
 	select BOARD_LATE_INIT
 	select SYS_DISABLE_DCACHE_OPS
 	select BINMAN
+	select SYSINFO
+	select SPL_SYSINFO if SPL
 	help
 	  This builds U-Boot for the IOT2050 devices.
 
diff --git a/board/siemens/iot2050/board.c b/board/siemens/iot2050/board.c
index e6bedc38917..c355f5bd3fd 100644
--- a/board/siemens/iot2050/board.c
+++ b/board/siemens/iot2050/board.c
@@ -21,32 +21,12 @@
 #include <spl.h>
 #include <version.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 #include <asm/arch/hardware.h>
 #include <asm/gpio.h>
 #include <asm/io.h>
 
-#define IOT2050_INFO_MAGIC		0x20502050
-
-struct iot2050_info {
-	u32 magic;
-	u16 size;
-	char name[20 + 1];
-	char serial[16 + 1];
-	char mlfb[18 + 1];
-	char uuid[32 + 1];
-	char a5e[18 + 1];
-	u8 mac_addr_cnt;
-	u8 mac_addr[8][ARP_HLEN];
-	char seboot_version[40 + 1];
-	u8 padding[3];
-	u32 ddr_size_mb;
-} __packed;
-
-/*
- * Scratch SRAM (available before DDR RAM) contains extracted EEPROM data.
- */
-#define IOT2050_INFO_DATA ((struct iot2050_info *) \
-			     TI_SRAM_SCRATCH_BOARD_EEPROM_START)
+#include "../../../../drivers/sysinfo/iot2050.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -117,6 +97,8 @@ static const char *m2_connector_mode_name[] = {
 
 static enum m2_connector_mode connector_mode;
 
+static char iot2050_board_name[21];
+
 #if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
 static void *connector_overlay;
 static u32 connector_overlay_size;
@@ -149,37 +131,57 @@ static void set_pinvalue(const char *gpio_name, const char *label, int value)
 	dm_gpio_set_value(&gpio, value);
 }
 
+static bool setup_sysinfo(struct udevice **sysinfo_ptr)
+{
+	if (sysinfo_get(sysinfo_ptr)) {
+		pr_err("Could not find sysinfo device.\n");
+		return false;
+	}
+	if (sysinfo_detect(*sysinfo_ptr)) {
+		pr_err("Board info parsing error\n");
+		return false;
+	}
+	return true;
+}
+
+static void get_board_name(void)
+{
+	struct udevice *sysinfo;
+
+	if (iot2050_board_name[0] != 0)
+		return;
+
+	if (!setup_sysinfo(&sysinfo))
+		return;
+
+	sysinfo_get_str(sysinfo, BOARD_NAME, sizeof(iot2050_board_name),
+			iot2050_board_name);
+}
+
 static bool board_is_advanced(void)
 {
-	struct iot2050_info *info = IOT2050_INFO_DATA;
 
-	return info->magic == IOT2050_INFO_MAGIC &&
-		strstr((char *)info->name, "IOT2050-ADVANCED") != NULL;
+	get_board_name();
+	return strstr(iot2050_board_name, "IOT2050-ADVANCED") != NULL;
 }
 
 static bool board_is_pg1(void)
 {
-	struct iot2050_info *info = IOT2050_INFO_DATA;
-
-	return info->magic == IOT2050_INFO_MAGIC &&
-		(strcmp((char *)info->name, "IOT2050-BASIC") == 0 ||
-		 strcmp((char *)info->name, "IOT2050-ADVANCED") == 0);
+	get_board_name();
+	return strcmp(iot2050_board_name, "IOT2050-BASIC") == 0 ||
+	       strcmp(iot2050_board_name, "IOT2050-ADVANCED") == 0;
 }
 
 static bool board_is_m2(void)
 {
-	struct iot2050_info *info = IOT2050_INFO_DATA;
-
-	return info->magic == IOT2050_INFO_MAGIC &&
-		strcmp((char *)info->name, "IOT2050-ADVANCED-M2") == 0;
+	get_board_name();
+	return strcmp(iot2050_board_name, "IOT2050-ADVANCED-M2") == 0;
 }
 
 static bool board_is_sm(void)
 {
-	struct iot2050_info *info = IOT2050_INFO_DATA;
-
-	return info->magic == IOT2050_INFO_MAGIC &&
-		strcmp((char *)info->name, "IOT2050-ADVANCED-SM") == 0;
+	get_board_name();
+	return strcmp(iot2050_board_name, "IOT2050-ADVANCED-SM") == 0;
 }
 
 static void remove_mmc1_target(void)
@@ -206,33 +208,40 @@ static void enable_pcie_connector_power(void)
 
 void set_board_info_env(void)
 {
-	struct iot2050_info *info = IOT2050_INFO_DATA;
-	u8 __maybe_unused mac_cnt;
+	struct udevice *sysinfo;
 	const char *fdtfile;
+	char buf[41];
 
-	if (info->magic != IOT2050_INFO_MAGIC) {
-		pr_err("IOT2050: Board info parsing error!\n");
+	if (env_get("board_uuid"))
 		return;
-	}
 
-	if (env_get("board_uuid"))
+	if (!setup_sysinfo(&sysinfo))
 		return;
 
-	env_set("board_name", info->name);
-	env_set("board_serial", info->serial);
-	env_set("mlfb", info->mlfb);
-	env_set("board_uuid", info->uuid);
-	env_set("board_a5e", info->a5e);
+	if (sysinfo_get_str(sysinfo, BOARD_NAME, sizeof(buf), buf) == 0)
+		env_set("board_name", buf);
+	if (sysinfo_get_str(sysinfo, BOARD_SERIAL, sizeof(buf), buf) == 0)
+		env_set("board_serial", buf);
+	if (sysinfo_get_str(sysinfo, BOARD_MLFB, sizeof(buf), buf) == 0)
+		env_set("mlfb", buf);
+	if (sysinfo_get_str(sysinfo, BOARD_UUID, sizeof(buf), buf) == 0)
+		env_set("board_uuid", buf);
+	if (sysinfo_get_str(sysinfo, BOARD_A5E, sizeof(buf), buf) == 0)
+		env_set("board_a5e", buf);
+	if (sysinfo_get_str(sysinfo, BOARD_SEBOOT_VER, sizeof(buf), buf) == 0)
+		env_set("seboot_version", buf);
 	env_set("fw_version", PLAIN_VERSION);
-	env_set("seboot_version", info->seboot_version);
 
 	if (IS_ENABLED(CONFIG_NET)) {
+		int mac_cnt, n;
+
+		sysinfo_get_int(sysinfo, BOARD_MAC_ADDR_CNT, &mac_cnt);
 		/* set MAC addresses to ensure forwarding to the OS */
-		for (mac_cnt = 0; mac_cnt < info->mac_addr_cnt; mac_cnt++) {
-			if (is_valid_ethaddr(info->mac_addr[mac_cnt]))
-				eth_env_set_enetaddr_by_index("eth",
-							      mac_cnt + 1,
-							      info->mac_addr[mac_cnt]);
+		for (n = 0; n < mac_cnt; n++) {
+			sysinfo_get_str(sysinfo, BOARD_MAC_ADDR_START + n,
+					sizeof(buf), buf);
+			if (is_valid_ethaddr(buf))
+				eth_env_set_enetaddr_by_index("eth", n + 1, buf);
 		}
 	}
 
@@ -288,7 +297,7 @@ static void do_overlay_prepare(const char *overlay_path)
 	return;
 
 fit_error:
-	pr_err("M.2 device tree overlay %s not available,\n", overlay_path);
+	pr_err("M.2 device tree overlay %s not available.\n", overlay_path);
 #endif
 }
 
@@ -362,8 +371,17 @@ int board_init(void)
 
 int dram_init(void)
 {
-	struct iot2050_info *info = IOT2050_INFO_DATA;
-	gd->ram_size = ((phys_size_t)(info->ddr_size_mb)) << 20;
+	struct udevice *sysinfo;
+	char buf[10];
+
+	if (!setup_sysinfo(&sysinfo))
+		return -ENODEV;
+
+	sysinfo_get_str(sysinfo, BOARD_DDR_SIZE, sizeof(buf), buf);
+
+	u32 ddr_size_mb = *((u32 *)buf);
+
+	gd->ram_size = ((phys_size_t)(ddr_size_mb)) << 20;
 
 	return 0;
 }
@@ -405,18 +423,18 @@ int dram_init_banksize(void)
 #ifdef CONFIG_SPL_LOAD_FIT
 int board_fit_config_name_match(const char *name)
 {
-	struct iot2050_info *info = IOT2050_INFO_DATA;
 	char upper_name[32];
 
+	get_board_name();
+
 	/* skip the prefix "ti/k3-am65x8-" */
 	name += 13;
 
-	if (info->magic != IOT2050_INFO_MAGIC ||
-	    strlen(name) >= sizeof(upper_name))
+	if (strlen(name) >= sizeof(upper_name))
 		return -1;
 
 	str_to_upper(name, upper_name, sizeof(upper_name));
-	if (!strcmp(upper_name, (char *)info->name))
+	if (!strcmp(upper_name, iot2050_board_name))
 		return 0;
 
 	return -1;
diff --git a/configs/iot2050_defconfig b/configs/iot2050_defconfig
index 574e232d119..2624f0cb573 100644
--- a/configs/iot2050_defconfig
+++ b/configs/iot2050_defconfig
@@ -141,7 +141,6 @@ CONFIG_SOC_TI=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_CADENCE_QSPI=y
-CONFIG_SYSINFO=y
 CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_TI_SCI=y
-- 
2.43.0

