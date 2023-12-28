Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18BCC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 15:41:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 429E187AD4;
	Thu, 28 Dec 2023 16:40:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="H8D9kkga";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B9E187AB4; Thu, 28 Dec 2023 16:39:36 +0100 (CET)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72B9B87A83
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 16:39:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id B9D0110003A;
 Thu, 28 Dec 2023 18:39:31 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru B9D0110003A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1703777971;
 bh=991fraxlfZvbzzsVn1BOrHM4o74vwGG99h9CuOHl1kQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=H8D9kkga6PSB48Q8j0ROx8za/4szbFw5vdA6GlbvzJLlQHwrb3engQSw70j+HjcO+
 3TsKhnvn2OuA63A6+fHnNN3JBSc0B07TBsozsro2fyDzTmUgIZ/MZh8UVH02zCvMSU
 zaBG8OfQ6NyhLkHz+WtLUsicy+oXVwkht+o4uQM0Hq1Fs+QtvyZlO3PR9adwRUbzAO
 mjr6cIqDYVEmKQu5s1b50Zsfkdhsen7+u3j7bVc+b200pSPh51MovUj6wip2/PP9Jk
 3qYEzUPzAKt47A3lDWdankRfZbP1SzEZZfmDa+NBdkkGXeDfZ2Qno1CXSQO0kZc61i
 lXOZTOcARiwqg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu, 28 Dec 2023 18:39:31 +0300 (MSK)
Received: from cab-wsm-0029881.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Dec 2023 18:39:30 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <michal.simek@amd.com>, <marex@denx.de>, <michael@walle.cc>,
 <stcarlso@linux.microsoft.com>, <tobias@waldekranz.com>,
 <seanedmond@microsoft.com>, <abdellatif.elkhlifi@arm.com>,
 <neil.armstrong@linaro.org>, <n-jain1@ti.com>, <xypron.glpk@gmx.de>,
 <dario.binacchi@amarulasolutions.com>, <michael@amarulasolutions.com>,
 <frieder.schrempf@kontron.de>, <sjg@chromium.org>, <hs@denx.de>,
 <sean.anderson@seco.com>, <dimorinny@google.com>,
 <mkorpershoek@baylibre.com>, <patrick.delaunay@foss.st.com>
CC: <u-boot@lists.denx.de>, <kernel@salutedevices.com>, Alexey Romanov
 <avromanov@salutedevices.com>
Subject: [PATCH v1 01/12] nand: move NAND initialization API to nand/core.c
Date: Thu, 28 Dec 2023 18:39:04 +0300
Message-ID: <20231228153922.84323-2-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231228153922.84323-1-avromanov@salutedevices.com>
References: <20231228153922.84323-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 182415 [Dec 28 2023]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7
 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a,
 {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:5.0.1,7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; salutedevices.com:7.1.1;
 127.0.0.199:7.1.2;
 100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/12/28 11:18:00 #22863388
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Thu, 28 Dec 2023 16:40:43 +0100
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

nand_register() and nand_init() is generic API for both
RAW and SPI NAND's. We have to move this functions
from drivers/mtd/nand/raw/nand.c to drivers/mtd/nand/core.c.

Functions designed to work with RAW NAND should remain
in drivers/mtd/nand/raw/nand.c.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 drivers/mtd/Kconfig          |   2 +-
 drivers/mtd/nand/Kconfig     |  10 +++
 drivers/mtd/nand/core.c      | 136 +++++++++++++++++++++++++++++++++++
 drivers/mtd/nand/raw/Kconfig |  10 ---
 drivers/mtd/nand/raw/nand.c  | 134 ----------------------------------
 include/nand.h               |   2 +
 6 files changed, 149 insertions(+), 145 deletions(-)

diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index c56840c849..1902351719 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -260,7 +260,7 @@ config SYS_NAND_MAX_ECCPOS
 
 config SYS_NAND_MAX_CHIPS
 	int "NAND max chips"
-	depends on MTD_RAW_NAND || CMD_ONENAND || TARGET_S5PC210_UNIVERSAL || \
+	depends on MTD_RAW_NAND || MTD_SPI_NAND || CMD_ONENAND || TARGET_S5PC210_UNIVERSAL || \
 		SPL_OMAP3_ID_NAND
 	default 1
 	help
diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 78ae04bdcb..9a1d4ac0dc 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -1,6 +1,16 @@
 config MTD_NAND_CORE
 	tristate
 
+config SYS_MAX_NAND_DEVICE
+	int "Maximum number of NAND devices to support"
+	default 1
+
+config SYS_NAND_SELF_INIT
+	bool
+	help
+	  This option, if enabled, provides more flexible and linux-like
+	  NAND initialization process.
+
 source "drivers/mtd/nand/raw/Kconfig"
 
 source "drivers/mtd/nand/spi/Kconfig"
diff --git a/drivers/mtd/nand/core.c b/drivers/mtd/nand/core.c
index 4b9dd6a926..ff298e3a0f 100644
--- a/drivers/mtd/nand/core.c
+++ b/drivers/mtd/nand/core.c
@@ -10,6 +10,7 @@
 #define pr_fmt(fmt)	"nand: " fmt
 
 #include <common.h>
+#include <nand.h>
 #include <watchdog.h>
 #ifndef __UBOOT__
 #include <linux/compat.h>
@@ -18,6 +19,12 @@
 #include <linux/bitops.h>
 #include <linux/mtd/nand.h>
 
+int nand_curr_device = -1;
+
+static struct mtd_info *nand_info[CONFIG_SYS_MAX_NAND_DEVICE];
+static char dev_name[CONFIG_SYS_MAX_NAND_DEVICE][8];
+static unsigned long total_nand_size; /* in kiB */
+
 /**
  * nanddev_isbad() - Check if a block is bad
  * @nand: NAND device
@@ -250,6 +257,135 @@ void nanddev_cleanup(struct nand_device *nand)
 }
 EXPORT_SYMBOL_GPL(nanddev_cleanup);
 
+struct mtd_info *get_nand_dev_by_index(int dev)
+{
+	if (dev < 0 || dev >= CONFIG_SYS_MAX_NAND_DEVICE || !nand_info[dev] ||
+	    !nand_info[dev]->name)
+		return NULL;
+
+	return nand_info[dev];
+}
+EXPORT_SYMBOL_GPL(get_nand_dev_by_index);
+
+int nand_mtd_to_devnum(struct mtd_info *mtd)
+{
+	int i;
+
+	for (i = 0; i < CONFIG_SYS_MAX_NAND_DEVICE; i++) {
+		if (mtd && get_nand_dev_by_index(i) == mtd)
+			return i;
+	}
+
+	return -ENODEV;
+}
+EXPORT_SYMBOL_GPL(nand_mtd_to_devnum);
+
+/* Register an initialized NAND mtd device with the U-Boot NAND command. */
+int nand_register(int devnum, struct mtd_info *mtd)
+{
+	if (devnum >= CONFIG_SYS_MAX_NAND_DEVICE)
+		return -EINVAL;
+
+	nand_info[devnum] = mtd;
+
+	sprintf(dev_name[devnum], "nand%d", devnum);
+	mtd->name = dev_name[devnum];
+
+#ifdef CONFIG_MTD
+	/*
+	 * Add MTD device so that we can reference it later
+	 * via the mtdcore infrastructure (e.g. ubi).
+	 */
+	add_mtd_device(mtd);
+#endif
+
+	total_nand_size += mtd->size / 1024;
+
+	if (nand_curr_device == -1)
+		nand_curr_device = devnum;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nand_register);
+
+#ifdef CONFIG_MTD_CONCAT
+static void create_mtd_concat(void)
+{
+	struct mtd_info *nand_info_list[CONFIG_SYS_MAX_NAND_DEVICE];
+	int nand_devices_found = 0;
+	int i;
+
+	for (i = 0; i < CONFIG_SYS_MAX_NAND_DEVICE; i++) {
+		struct mtd_info *mtd = get_nand_dev_by_index(i);
+		if (mtd != NULL) {
+			nand_info_list[nand_devices_found] = mtd;
+			nand_devices_found++;
+		}
+	}
+	if (nand_devices_found > 1) {
+		struct mtd_info *mtd;
+		char c_mtd_name[16];
+
+		/*
+		 * We detected multiple devices. Concatenate them together.
+		 */
+		sprintf(c_mtd_name, "nand%d", nand_devices_found);
+		mtd = mtd_concat_create(nand_info_list, nand_devices_found,
+					c_mtd_name);
+
+		if (mtd == NULL)
+			return;
+
+		nand_register(nand_devices_found, mtd);
+	}
+
+	return;
+}
+#else
+static void create_mtd_concat(void)
+{
+}
+#endif
+
+unsigned long nand_size(void)
+{
+	return total_nand_size;
+}
+EXPORT_SYMBOL_GPL(nand_size);
+
+void nand_init(void)
+{
+	static int initialized;
+
+	/*
+	 * Avoid initializing NAND Flash multiple times,
+	 * otherwise it will calculate a wrong total size.
+	 */
+	if (initialized)
+		return;
+	initialized = 1;
+
+#if CONFIG_IS_ENABLED(SYS_NAND_SELF_INIT)
+	board_nand_init();
+#else
+	int i;
+
+	for (i = 0; i < CONFIG_SYS_MAX_NAND_DEVICE; i++)
+		nand_init_chip(i);
+#endif
+
+#ifdef CONFIG_SYS_NAND_SELECT_DEVICE
+	/*
+	 * Select the chip in the board/cpu specific driver
+	 */
+	board_nand_select_device(mtd_to_nand(get_nand_dev_by_index(nand_curr_device)),
+				 nand_curr_device);
+#endif
+
+	create_mtd_concat();
+}
+EXPORT_SYMBOL_GPL(nand_init);
+
 MODULE_DESCRIPTION("Generic NAND framework");
 MODULE_AUTHOR("Boris Brezillon <boris.brezillon@free-electrons.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index f0100a601d..31949f1dff 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -3,12 +3,6 @@ menuconfig MTD_RAW_NAND
 	bool "Raw NAND Device Support"
 if MTD_RAW_NAND
 
-config SYS_NAND_SELF_INIT
-	bool
-	help
-	  This option, if enabled, provides more flexible and linux-like
-	  NAND initialization process.
-
 config SPL_SYS_NAND_SELF_INIT
 	bool
 	depends on !SPL_NAND_SIMPLE
@@ -29,10 +23,6 @@ config TPL_NAND_INIT
 config SPL_NAND_INIT
 	bool
 
-config SYS_MAX_NAND_DEVICE
-	int "Maximum number of NAND devices to support"
-	default 1
-
 config SYS_NAND_DRIVER_ECC_LAYOUT
 	bool "Omit standard ECC layouts to save space"
 	help
diff --git a/drivers/mtd/nand/raw/nand.c b/drivers/mtd/nand/raw/nand.c
index eacd99c4e2..edca824d77 100644
--- a/drivers/mtd/nand/raw/nand.c
+++ b/drivers/mtd/nand/raw/nand.c
@@ -15,68 +15,10 @@
 #define CFG_SYS_NAND_BASE_LIST { CFG_SYS_NAND_BASE }
 #endif
 
-int nand_curr_device = -1;
-
-static struct mtd_info *nand_info[CONFIG_SYS_MAX_NAND_DEVICE];
-
 #if !CONFIG_IS_ENABLED(SYS_NAND_SELF_INIT)
 static struct nand_chip nand_chip[CONFIG_SYS_MAX_NAND_DEVICE];
 static ulong base_address[CONFIG_SYS_MAX_NAND_DEVICE] = CFG_SYS_NAND_BASE_LIST;
-#endif
-
-static char dev_name[CONFIG_SYS_MAX_NAND_DEVICE][8];
-
-static unsigned long total_nand_size; /* in kiB */
-
-struct mtd_info *get_nand_dev_by_index(int dev)
-{
-	if (dev < 0 || dev >= CONFIG_SYS_MAX_NAND_DEVICE || !nand_info[dev] ||
-	    !nand_info[dev]->name)
-		return NULL;
 
-	return nand_info[dev];
-}
-
-int nand_mtd_to_devnum(struct mtd_info *mtd)
-{
-	int i;
-
-	for (i = 0; i < CONFIG_SYS_MAX_NAND_DEVICE; i++) {
-		if (mtd && get_nand_dev_by_index(i) == mtd)
-			return i;
-	}
-
-	return -ENODEV;
-}
-
-/* Register an initialized NAND mtd device with the U-Boot NAND command. */
-int nand_register(int devnum, struct mtd_info *mtd)
-{
-	if (devnum >= CONFIG_SYS_MAX_NAND_DEVICE)
-		return -EINVAL;
-
-	nand_info[devnum] = mtd;
-
-	sprintf(dev_name[devnum], "nand%d", devnum);
-	mtd->name = dev_name[devnum];
-
-#ifdef CONFIG_MTD
-	/*
-	 * Add MTD device so that we can reference it later
-	 * via the mtdcore infrastructure (e.g. ubi).
-	 */
-	add_mtd_device(mtd);
-#endif
-
-	total_nand_size += mtd->size / 1024;
-
-	if (nand_curr_device == -1)
-		nand_curr_device = devnum;
-
-	return 0;
-}
-
-#if !CONFIG_IS_ENABLED(SYS_NAND_SELF_INIT)
 static void nand_init_chip(int i)
 {
 	struct nand_chip *nand = &nand_chip[i];
@@ -98,79 +40,3 @@ static void nand_init_chip(int i)
 	nand_register(i, mtd);
 }
 #endif
-
-#ifdef CONFIG_MTD_CONCAT
-static void create_mtd_concat(void)
-{
-	struct mtd_info *nand_info_list[CONFIG_SYS_MAX_NAND_DEVICE];
-	int nand_devices_found = 0;
-	int i;
-
-	for (i = 0; i < CONFIG_SYS_MAX_NAND_DEVICE; i++) {
-		struct mtd_info *mtd = get_nand_dev_by_index(i);
-		if (mtd != NULL) {
-			nand_info_list[nand_devices_found] = mtd;
-			nand_devices_found++;
-		}
-	}
-	if (nand_devices_found > 1) {
-		struct mtd_info *mtd;
-		char c_mtd_name[16];
-
-		/*
-		 * We detected multiple devices. Concatenate them together.
-		 */
-		sprintf(c_mtd_name, "nand%d", nand_devices_found);
-		mtd = mtd_concat_create(nand_info_list, nand_devices_found,
-					c_mtd_name);
-
-		if (mtd == NULL)
-			return;
-
-		nand_register(nand_devices_found, mtd);
-	}
-
-	return;
-}
-#else
-static void create_mtd_concat(void)
-{
-}
-#endif
-
-unsigned long nand_size(void)
-{
-	return total_nand_size;
-}
-
-void nand_init(void)
-{
-	static int initialized;
-
-	/*
-	 * Avoid initializing NAND Flash multiple times,
-	 * otherwise it will calculate a wrong total size.
-	 */
-	if (initialized)
-		return;
-	initialized = 1;
-
-#if CONFIG_IS_ENABLED(SYS_NAND_SELF_INIT)
-	board_nand_init();
-#else
-	int i;
-
-	for (i = 0; i < CONFIG_SYS_MAX_NAND_DEVICE; i++)
-		nand_init_chip(i);
-#endif
-
-#ifdef CONFIG_SYS_NAND_SELECT_DEVICE
-	/*
-	 * Select the chip in the board/cpu specific driver
-	 */
-	board_nand_select_device(mtd_to_nand(get_nand_dev_by_index(nand_curr_device)),
-				 nand_curr_device);
-#endif
-
-	create_mtd_concat();
-}
diff --git a/include/nand.h b/include/nand.h
index 70c1286ccb..16cfc2a24a 100644
--- a/include/nand.h
+++ b/include/nand.h
@@ -25,6 +25,8 @@ int nand_register(int devnum, struct mtd_info *mtd);
 struct nand_chip;
 
 extern int board_nand_init(struct nand_chip *nand);
+
+void nand_init_chip(int index);
 #endif
 
 extern int nand_curr_device;
-- 
2.30.1

