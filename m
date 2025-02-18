Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FFFC02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 05:36:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C153480F7A;
	Tue, 18 Feb 2025 06:35:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=baocheng.su@siemens.com header.b="b7YN+MMS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18FA6807F1; Tue, 18 Feb 2025 03:36:53 +0100 (CET)
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6CF480017
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 03:36:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=baocheng.su@siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 202502180236501b6dd3daf819e3c994 for <u-boot@lists.denx.de>;
 Tue, 18 Feb 2025 03:36:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=baocheng.su@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=rWKXoQJ7ZuDcoK+NVsO3EYiz2tCj6CcLqOYzhRzyovM=;
 b=b7YN+MMSYa/TTDco42BMMNtrT4l70nJoamHt+zVrz7T6qI/OAfAZ99hyDKak6cNsT8LCZF
 QWFas6PVjV3OLvGfCgo9HWPjIEYJ/uYPmgtQEDSQi7CuRB7T4ryJWOwUKER1nDdJvnoOH+QX
 v4tsXgvYhUOtqV58aHCJ6pQV4W6L2MfaZt6qXhpbHD8XYy48DBL9hFBGgv/t7KEOeKY9elcM
 +tWxuNKHX48ed8v3rozVIgjW+CKy82mjrkNYfUYUi9v7OOdiZZtLNmLp6gRZNfOkYPUrnQPP
 lojVIbDP+G9B0INCyQ13NPZIpAJYQ53TtadZugRUEJsEiM6Elpy0pUvA==;
From: Baocheng Su <baocheng.su@siemens.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bryan Brattlof <bb@ti.com>, Nishanth Menon <nm@ti.com>,
 Li Hua Qian <huaqian.li@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Baocheng Su <baocheng.su@siemens.com>
Subject: [PATCH v4 5/5] board: siemens: iot2050: Use sysinfo for board
 initialization
Date: Tue, 18 Feb 2025 10:36:14 +0800
Message-Id: <20250218023614.52574-6-baocheng.su@siemens.com>
In-Reply-To: <20250218023614.52574-1-baocheng.su@siemens.com>
References: <20250218023614.52574-1-baocheng.su@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-909155:519-21489:flowmailer
X-Mailman-Approved-At: Tue, 18 Feb 2025 06:35:12 +0100
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

Drop the info structure parsing of the board in favor of our new sysinfo
driver to avoid code duplication.

Signed-off-by: Baocheng Su <baocheng.su@siemens.com>
Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
[Jan: rebasing, split-up, cleanup]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

---

(no changes since v3)

Changes in v3:
- reworked to align with the sysinfo driver updates

 arch/arm/mach-k3/am65x/Kconfig |   2 +
 board/siemens/iot2050/board.c  | 142 +++++++++++++++++++--------------
 2 files changed, 82 insertions(+), 62 deletions(-)

diff --git a/arch/arm/mach-k3/am65x/Kconfig b/arch/arm/mach-k3/am65x/Kconfig
index 72a8298aebf9..056ae118c9e7 100644
--- a/arch/arm/mach-k3/am65x/Kconfig
+++ b/arch/arm/mach-k3/am65x/Kconfig
@@ -35,6 +35,8 @@ config TARGET_IOT2050_A53
 	select BOARD_LATE_INIT
 	select SYS_DISABLE_DCACHE_OPS
 	select BINMAN
+	select SYSINFO
+	select SPL_SYSINFO if SPL
 	help
 	  This builds U-Boot for the IOT2050 devices.
 
diff --git a/board/siemens/iot2050/board.c b/board/siemens/iot2050/board.c
index e6bedc389173..d827f728a08c 100644
--- a/board/siemens/iot2050/board.c
+++ b/board/siemens/iot2050/board.c
@@ -25,28 +25,7 @@
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
 
@@ -117,6 +96,8 @@ static const char *m2_connector_mode_name[] = {
 
 static enum m2_connector_mode connector_mode;
 
+static char iot2050_board_name[21];
+
 #if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
 static void *connector_overlay;
 static u32 connector_overlay_size;
@@ -149,37 +130,57 @@ static void set_pinvalue(const char *gpio_name, const char *label, int value)
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
@@ -206,33 +207,43 @@ static void enable_pcie_connector_power(void)
 
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
+	if (sysinfo_get_str(sysinfo, SYSID_SM_SYSTEM_SERIAL, sizeof(buf), buf) == 0)
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
+		int mac_cnt;
+
+		mac_cnt = sysinfo_get_item_count(sysinfo, SYSID_BOARD_MAC_ADDR);
 		/* set MAC addresses to ensure forwarding to the OS */
-		for (mac_cnt = 0; mac_cnt < info->mac_addr_cnt; mac_cnt++) {
-			if (is_valid_ethaddr(info->mac_addr[mac_cnt]))
-				eth_env_set_enetaddr_by_index("eth",
-							      mac_cnt + 1,
-							      info->mac_addr[mac_cnt]);
+		for (int i = 0; i < mac_cnt; i++) {
+			u8 *mac = NULL;
+			size_t bytes = 0;
+
+			sysinfo_get_data_by_index(sysinfo, SYSID_BOARD_MAC_ADDR,
+						  i, (void **)&mac, &bytes);
+			if (bytes == ARP_HLEN && is_valid_ethaddr(mac))
+				eth_env_set_enetaddr_by_index("eth", i + 1, mac);
 		}
 	}
 
@@ -288,7 +299,7 @@ static void do_overlay_prepare(const char *overlay_path)
 	return;
 
 fit_error:
-	pr_err("M.2 device tree overlay %s not available,\n", overlay_path);
+	pr_err("M.2 device tree overlay %s not available.\n", overlay_path);
 #endif
 }
 
@@ -362,8 +373,15 @@ int board_init(void)
 
 int dram_init(void)
 {
-	struct iot2050_info *info = IOT2050_INFO_DATA;
-	gd->ram_size = ((phys_size_t)(info->ddr_size_mb)) << 20;
+	struct udevice *sysinfo;
+	u32 ddr_size_mb;
+
+	if (!setup_sysinfo(&sysinfo))
+		return -ENODEV;
+
+	sysinfo_get_int(sysinfo, SYSID_BOARD_RAM_SIZE_MB, &ddr_size_mb);
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
-- 
2.39.5

