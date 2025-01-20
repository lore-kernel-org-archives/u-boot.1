Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ADD2C02185
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 09:55:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACD2B801CF;
	Mon, 20 Jan 2025 10:55:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZOKtYqCh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84AA7801CF; Mon, 20 Jan 2025 09:51:15 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 886E280077
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 09:51:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-shenai@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50K8pAJU762625
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Jan 2025 02:51:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1737363070;
 bh=Co/7D/ssJsJoEzuaG+6lhIzl5Yg95SyIL/dq+/wZm8A=;
 h=From:To:CC:Subject:Date;
 b=ZOKtYqChclgDhrkrCpZJAGprpeCtKQeauSnxdGERGwqgKa4kiN7EknZCOzdUrqf2g
 bRyCnZQYIE6W7U1wrIsyWKkrwpP6To0Wk6d/deG9s3jmwJJ+btzDT7jnLtyMS4icm5
 mmTiAW3Z14ppO+kNS0rXeE1Nio5Chn2CD02eNlFk=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 50K8pAPe018586
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 20 Jan 2025 02:51:10 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 20
 Jan 2025 02:51:10 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 20 Jan 2025 02:51:10 -0600
Received: from aashvij.dhcp.ti.com (aashvij.dhcp.ti.com [172.24.227.252])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50K8p7Vu114183;
 Mon, 20 Jan 2025 02:51:08 -0600
From: Aashvij Shenai <a-shenai@ti.com>
To: <u-boot@lists.denx.de>, <praneeth@ti.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>, <trini@konsulko.com>, <d-gole@ti.com>
CC: <m-chawdhry@ti.com>, <kamlesh@ti.com>
Subject: [PATCH] arm64: configs: Remove obsolete TI config
Date: Mon, 20 Jan 2025 14:20:42 +0530
Message-ID: <20250120085042.2767733-1-a-shenai@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Mon, 20 Jan 2025 10:55:32 +0100
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

This config is causing conflicts with how fdtfile variable is
initialized.
For K3 devices, CONFIG_DEFAULT_DEVICE_TREE= "ti/k3-<board>.dtb".
With CONFIG_TI_FDT_FOLDER_PATH also prefixing "ti", fdtfile is then
"ti/ti/k3-<board>.dtb". This variable is updated when fitImage is
booted and fails to boot due to the parsing error "ti/ti/".

Given that there are no other users of this config other than K3 for
now, it is being removed.

Since am64x, j721e and j721s2 also define a DEFAULT_FDT_FILE, update
them to conform to the DEFAULT_DEVICE_TREE standard.

Signed-off-by: Aashvij Shenai <a-shenai@ti.com>
---

 board/beagle/beagleboneai64/beagleboneai64.c |  3 +--
 board/beagle/beagleplay/beagleplay.c         |  3 +--
 board/ti/am64x/evm.c                         |  4 ++--
 board/ti/common/Kconfig                      | 11 -----------
 board/ti/common/fdt_ops.c                    |  9 +++------
 board/ti/j721e/evm.c                         |  6 +++---
 board/ti/j721s2/evm.c                        |  4 ++--
 7 files changed, 12 insertions(+), 28 deletions(-)

diff --git a/board/beagle/beagleboneai64/beagleboneai64.c b/board/beagle/beagleboneai64/beagleboneai64.c
index 1e43d1c1bd2..e8d07f1f95f 100644
--- a/board/beagle/beagleboneai64/beagleboneai64.c
+++ b/board/beagle/beagleboneai64/beagleboneai64.c
@@ -73,8 +73,7 @@ int board_late_init(void)
 {
 	char fdtfile[50];
 
-	snprintf(fdtfile, sizeof(fdtfile), "%s/%s.dtb",
-		 CONFIG_TI_FDT_FOLDER_PATH, CONFIG_DEFAULT_DEVICE_TREE);
+	snprintf(fdtfile, sizeof(fdtfile), "%s.dtb", CONFIG_DEFAULT_DEVICE_TREE);
 
 	env_set("fdtfile", fdtfile);
 
diff --git a/board/beagle/beagleplay/beagleplay.c b/board/beagle/beagleplay/beagleplay.c
index a21f09e3122..fae69b37585 100644
--- a/board/beagle/beagleplay/beagleplay.c
+++ b/board/beagle/beagleplay/beagleplay.c
@@ -69,8 +69,7 @@ int board_late_init(void)
 {
 	char fdtfile[50];
 
-	snprintf(fdtfile, sizeof(fdtfile), "%s/%s.dtb",
-		 CONFIG_TI_FDT_FOLDER_PATH, CONFIG_DEFAULT_DEVICE_TREE);
+	snprintf(fdtfile, sizeof(fdtfile), "%s.dtb", CONFIG_DEFAULT_DEVICE_TREE);
 
 	env_set("fdtfile", fdtfile);
 
diff --git a/board/ti/am64x/evm.c b/board/ti/am64x/evm.c
index 00b8317d6bf..c0033db2078 100644
--- a/board/ti/am64x/evm.c
+++ b/board/ti/am64x/evm.c
@@ -217,8 +217,8 @@ int checkboard(void)
 
 #ifdef CONFIG_BOARD_LATE_INIT
 static struct ti_fdt_map ti_am64_evm_fdt_map[] = {
-	{"am64x_gpevm", "k3-am642-evm.dtb"},
-	{"am64x_skevm", "k3-am642-sk.dtb"},
+	{"am64x_gpevm", "ti/k3-am642-evm.dtb"},
+	{"am64x_skevm", "ti/k3-am642-sk.dtb"},
 	{ /* Sentinel. */ }
 };
 
diff --git a/board/ti/common/Kconfig b/board/ti/common/Kconfig
index de44e4de211..b8b691aa06c 100644
--- a/board/ti/common/Kconfig
+++ b/board/ti/common/Kconfig
@@ -50,14 +50,3 @@ config TI_COMMON_CMD_OPTIONS
 	imply CMD_TIME
 	imply CMD_USB if USB
 
-config TI_FDT_FOLDER_PATH
-	string "Location of Folder path where dtb is present"
-	default "ti/davinci" if ARCH_DAVINCI
-	default "ti/keystone" if ARCH_KEYSTONE
-	default "ti/omap" if ARCH_OMAP2PLUS
-	default "ti" if ARCH_K3
-	depends on ARCH_DAVINCI || ARCH_KEYSTONE || ARCH_OMAP2PLUS || ARCH_K3
-	help
-	   Folder path for kernel device tree default.
-	   This is used along with fdtfile path to locate the kernel
-	   device tree blob.
diff --git a/board/ti/common/fdt_ops.c b/board/ti/common/fdt_ops.c
index 8a3300993ed..47df5726ff0 100644
--- a/board/ti/common/fdt_ops.c
+++ b/board/ti/common/fdt_ops.c
@@ -35,17 +35,14 @@ void ti_set_fdt_env(const char *board_name, struct ti_fdt_map *fdt_map)
 		 */
 #ifdef CONFIG_DEFAULT_FDT_FILE
 		if (strlen(CONFIG_DEFAULT_FDT_FILE)) {
-			snprintf(fdtfile, sizeof(fdtfile), "%s/%s",
-				 CONFIG_TI_FDT_FOLDER_PATH, CONFIG_DEFAULT_FDT_FILE);
+			snprintf(fdtfile, sizeof(fdtfile), "%s", CONFIG_DEFAULT_FDT_FILE);
 		} else
 #endif
 		{
-			snprintf(fdtfile, sizeof(fdtfile), "%s/%s.dtb",
-				 CONFIG_TI_FDT_FOLDER_PATH, CONFIG_DEFAULT_DEVICE_TREE);
+			snprintf(fdtfile, sizeof(fdtfile), "%s.dtb", CONFIG_DEFAULT_DEVICE_TREE);
 		}
 	} else {
-		snprintf(fdtfile, sizeof(fdtfile), "%s/%s", CONFIG_TI_FDT_FOLDER_PATH,
-			 fdt_file_name);
+		snprintf(fdtfile, sizeof(fdtfile), "%s", fdt_file_name);
 	}
 
 	env_set("fdtfile", fdtfile);
diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
index 6221be9dcff..c54816e9e18 100644
--- a/board/ti/j721e/evm.c
+++ b/board/ti/j721e/evm.c
@@ -395,9 +395,9 @@ static int probe_daughtercards(void)
 
 #ifdef CONFIG_BOARD_LATE_INIT
 static struct ti_fdt_map ti_j721e_evm_fdt_map[] = {
-	{"j721e", "k3-j721e-common-proc-board.dtb"},
-	{"j721e-sk", "k3-j721e-sk.dtb"},
-	{"j7200", "k3-j7200-common-proc-board.dtb"},
+	{"j721e", "ti/k3-j721e-common-proc-board.dtb"},
+	{"j721e-sk", "ti/k3-j721e-sk.dtb"},
+	{"j7200", "ti/k3-j7200-common-proc-board.dtb"},
 	{ /* Sentinel. */ }
 };
 static void setup_board_eeprom_env(void)
diff --git a/board/ti/j721s2/evm.c b/board/ti/j721s2/evm.c
index 2cfeb3bec6c..6627e0ce466 100644
--- a/board/ti/j721s2/evm.c
+++ b/board/ti/j721s2/evm.c
@@ -116,8 +116,8 @@ int checkboard(void)
 }
 
 static struct ti_fdt_map ti_j721s2_evm_fdt_map[] = {
-	{"j721s2", "k3-j721s2-common-proc-board.dtb"},
-	{"am68-sk", "k3-am68-sk-base-board.dtb"},
+	{"j721s2", "ti/k3-j721s2-common-proc-board.dtb"},
+	{"am68-sk", "ti/k3-am68-sk-base-board.dtb"},
 	{ /* Sentinel. */ }
 };
 
-- 
2.34.1

