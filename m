Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9E61C83F3E
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 11:31:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9156B8696B;
	Tue,  5 Sep 2023 13:31:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x89L2tvR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 073E28696B; Tue,  5 Sep 2023 13:31:22 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DCEB8691E
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 13:31:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYR68PVclWpfObYchxNgjherlofhJhOrL96T6XxRR7Lq3bIqfBi+hrEFPwEc8tq6otrjMAqLPS6EJzSRhlw6mizXa3Ihw+Lr3NZCHzzDgBK1ED29oSXYFe4aekNb4CDt0OJcm8/oa6TDMTp10JuvNflCct0HoHsPFewThhXtdfaKVlDPVAgD3Q/+jCSm7jg7s3TJO6VNibk1wTBRYTUGJq8gZbiDji3RzOiXX+3QJvMPTAKUQa3uwXiF7GpzO9EKQihAV/hI+HjK9r7dfbso1oWbELy3LHHUwg0ugv/oipPD/GvNnrCue4h5rpRRj2m9b+W/vlJTLFwetDmq2zRSaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f85Gkj2KHOG2lhUvGQG3XW4SFMs223CMOLwZw3sIeFA=;
 b=QWVfprQns6CHHFjqDb18GKk2MjzfmjzbZGQV4e9z+xNcN3N4sw7m0I1nHmp2G/kDpq4PRi6sN5FQLx5jjo52kaIGdeN96VmFrdb5FL2BtGdblnFs5XKY3sTQ4cfR8aLLwZEAqJG0VoCkPUDzEozdyWugCq0yPiuenKFtgr2hBh01KXyjuBHJRg8D1FngaBNcpXuDInw/ia9QX57vKCpVCTFuddFBgEls6ZxHOs5M7cHK5vyFD/xtV8iauPFAXXnu2j/bwz9+HS8z5PtzH6nF3A1NSoSszej9cRUlAtiKv0CH/yRtdNzAUN5QJRbh1IskdEDUVignDwdo3skIRvkz4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f85Gkj2KHOG2lhUvGQG3XW4SFMs223CMOLwZw3sIeFA=;
 b=x89L2tvRK39odGrlVYBnwkvaD9HemryNqolL9YYpT6gOhUlJqjHtrdCWKeqPYaMJa9J4fOLUMdlyHe5nw7fUFMCD8mnntqLzPTRRaHx5G0hAlAM2gCohboXHUuFv0WT3/TU3FIF1WAKaua/P+HAT1XND8PRZzFuVmpBlCmfhcOY=
Received: from MN2PR22CA0014.namprd22.prod.outlook.com (2603:10b6:208:238::19)
 by MN2PR12MB4453.namprd12.prod.outlook.com (2603:10b6:208:260::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 11:31:15 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::82) by MN2PR22CA0014.outlook.office365.com
 (2603:10b6:208:238::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33 via Frontend
 Transport; Tue, 5 Sep 2023 11:31:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Tue, 5 Sep 2023 11:31:15 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 5 Sep
 2023 06:30:09 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH] arm64: xilinx: Guard distro boot variable generation
Date: Tue, 5 Sep 2023 13:30:07 +0200
Message-ID: <570c51435da59831ec245cddceda078afa58a550.1693913398.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7114; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=nuIcBek1mXCDqJeOFZrHww493b/ZwT9Ja1VmAr21gjM=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpTvguYHj6QtKU0/mP2LbSkb/wHm5AKmZ8X3/BbYP7BvW
 ShRHrKmI5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEwkhINhnpJZ7Q4uqf5PHmxl
 Zwvmvn9b/DUvi2F+icpjM4XUL7Iv5ias3Ragc48vI+0oAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|MN2PR12MB4453:EE_
X-MS-Office365-Filtering-Correlation-Id: 42db3356-cbb5-4e3e-32cd-08dbae039d73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 791868sR9ktbBtdnwOmtP8d8u9H6MULnbw8GVeMExBe86d6Uy1gF3/BDsKTvgQefImQq8Ernfte7sIDMiVdWV5KgJOKYIjszTHSMhrGRieFPv5cZHInE3sdq3nJaYGIm/on83L3PNy050tB65Hpq4J8YmBcxfh/OQyrd6bbPujJSiaLI5hDn3j5rsOPjerLghWhkDJB36TdM9JTKdBbs+3efAL/lKlF85WsUObt6ATaI1FtUE8AfTVDUWXr9GRniR54HmLnu1/ywsNroBdJnxZH5ylVBXQ+01V6N3Vt4WPCdMK9RpOCJ1KbA4IMQhEPVtsSNt7b7EwAIaHtGpKZz3OhFpX72AE+YUl+i/MbYgYKQJilrWI4wEXC9WeWS+fM/wU1cbO2wemWfL+Va96y2IQLx2Qx5APLn5j+7vzD7kW6dM3HGby40l9Zd5EfAa/GW4OCMQxj9ZdZ7PNOLt4B6E4YzFOwNcNIU4dZ+idPye/nAcW8Egboxc7phGTzo7x/iVcjtQmxb6ral5P98eGECLZSsR/cbp6mhkqzfS/WMsWenREtM2HMx5sS0JpkV9Rx5kkxNNAChMZLndvwAZLTE9J8RgYfFjtObB+Fgxq3ndTdC+c06o0GL4fl8C/E9urD39ucwWoGbAyr9Wf5uYx6mAHhGM+qAZuj9NTvF5oofUV9k7V3UX+CMUNRGqB/y3tNQaepXewc6GYyEXnkJ+rPsGrogUq2Dsk7VF82MOQUZOjQl7JtSNzMIQ3TmnttoZ1Fs8jQ4EgevPmdFJuyliQenqQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199024)(82310400011)(1800799009)(186009)(40470700004)(36840700001)(46966006)(70206006)(70586007)(86362001)(40480700001)(82740400003)(36860700001)(41300700001)(316002)(110136005)(47076005)(2616005)(26005)(16526019)(44832011)(8676002)(5660300002)(8936002)(478600001)(336012)(426003)(36756003)(40460700003)(83380400001)(2906002)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 11:31:15.2295 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42db3356-cbb5-4e3e-32cd-08dbae039d73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4453
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

When distro boot is disabled there is no reason to generate variables for
it. Also do not update boot_targets variable because it would be unused.

It is useful for example when standard boot is enabled and distro boot
is disabled.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/xilinx/versal-net/board.c     | 32 ++++++++++++-----
 board/xilinx/versal/board.c         | 31 +++++++++++-----
 board/xilinx/zynqmp/zynqmp.c        | 56 +++++++++++++++++------------
 include/configs/xilinx_versal.h     |  6 ++++
 include/configs/xilinx_versal_net.h |  6 ++++
 include/configs/xilinx_zynqmp.h     |  6 ++++
 6 files changed, 97 insertions(+), 40 deletions(-)

diff --git a/board/xilinx/versal-net/board.c b/board/xilinx/versal-net/board.c
index 7ad299f3a231..c18be0c26c99 100644
--- a/board/xilinx/versal-net/board.c
+++ b/board/xilinx/versal-net/board.c
@@ -194,7 +194,7 @@ static u8 versal_net_get_bootmode(void)
 	return bootmode;
 }
 
-int board_late_init(void)
+static int boot_targets_setup(void)
 {
 	u8 bootmode;
 	struct udevice *dev;
@@ -205,14 +205,6 @@ int board_late_init(void)
 	char *new_targets;
 	char *env_targets;
 
-	if (!(gd->flags & GD_FLG_ENV_DEFAULT)) {
-		debug("Saved variables - Skipping\n");
-		return 0;
-	}
-
-	if (!IS_ENABLED(CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG))
-		return 0;
-
 	bootmode = versal_net_get_bootmode();
 
 	puts("Bootmode: ");
@@ -320,6 +312,28 @@ int board_late_init(void)
 
 		env_set("boot_targets", new_targets);
 	}
+
+	return 0;
+}
+
+int board_late_init(void)
+{
+	int ret;
+
+	if (!(gd->flags & GD_FLG_ENV_DEFAULT)) {
+		debug("Saved variables - Skipping\n");
+		return 0;
+	}
+
+	if (!IS_ENABLED(CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG))
+		return 0;
+
+	if (IS_ENABLED(CONFIG_DISTRO_DEFAULTS)) {
+		ret = boot_targets_setup();
+		if (ret)
+			return ret;
+	}
+
 	return board_late_init_xilinx();
 }
 
diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
index 982a8b3779f1..e4bdd5d7a38b 100644
--- a/board/xilinx/versal/board.c
+++ b/board/xilinx/versal/board.c
@@ -126,7 +126,7 @@ static u8 versal_get_bootmode(void)
 	return bootmode;
 }
 
-int board_late_init(void)
+static int boot_targets_setup(void)
 {
 	u8 bootmode;
 	struct udevice *dev;
@@ -137,14 +137,6 @@ int board_late_init(void)
 	char *new_targets;
 	char *env_targets;
 
-	if (!(gd->flags & GD_FLG_ENV_DEFAULT)) {
-		debug("Saved variables - Skipping\n");
-		return 0;
-	}
-
-	if (!IS_ENABLED(CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG))
-		return 0;
-
 	bootmode = versal_get_bootmode();
 
 	puts("Bootmode: ");
@@ -247,6 +239,27 @@ int board_late_init(void)
 		env_set("boot_targets", new_targets);
 	}
 
+	return 0;
+}
+
+int board_late_init(void)
+{
+	int ret;
+
+	if (!(gd->flags & GD_FLG_ENV_DEFAULT)) {
+		debug("Saved variables - Skipping\n");
+		return 0;
+	}
+
+	if (!IS_ENABLED(CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG))
+		return 0;
+
+	if (IS_ENABLED(CONFIG_DISTRO_DEFAULTS)) {
+		ret = boot_targets_setup();
+		if (ret)
+			return ret;
+	}
+
 	return board_late_init_xilinx();
 }
 
diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
index 0b6d4e57078b..f16280308483 100644
--- a/board/xilinx/zynqmp/zynqmp.c
+++ b/board/xilinx/zynqmp/zynqmp.c
@@ -384,7 +384,7 @@ static int set_fdtfile(void)
 	return 0;
 }
 
-int board_late_init(void)
+static int boot_targets_setup(void)
 {
 	u8 bootmode;
 	struct udevice *dev;
@@ -394,27 +394,6 @@ int board_late_init(void)
 	const char *mode = NULL;
 	char *new_targets;
 	char *env_targets;
-	int ret, multiboot;
-
-#if defined(CONFIG_USB_ETHER) && !defined(CONFIG_USB_GADGET_DOWNLOAD)
-	usb_ether_init();
-#endif
-
-	if (!(gd->flags & GD_FLG_ENV_DEFAULT)) {
-		debug("Saved variables - Skipping\n");
-		return 0;
-	}
-
-	if (!IS_ENABLED(CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG))
-		return 0;
-
-	ret = set_fdtfile();
-	if (ret)
-		return ret;
-
-	multiboot = multi_boot();
-	if (multiboot >= 0)
-		env_set_hex("multiboot", multiboot);
 
 	bootmode = zynqmp_get_bootmode();
 
@@ -525,6 +504,39 @@ int board_late_init(void)
 		free(new_targets);
 	}
 
+	return 0;
+}
+
+int board_late_init(void)
+{
+	int ret, multiboot;
+
+#if defined(CONFIG_USB_ETHER) && !defined(CONFIG_USB_GADGET_DOWNLOAD)
+	usb_ether_init();
+#endif
+
+	if (!(gd->flags & GD_FLG_ENV_DEFAULT)) {
+		debug("Saved variables - Skipping\n");
+		return 0;
+	}
+
+	if (!IS_ENABLED(CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG))
+		return 0;
+
+	ret = set_fdtfile();
+	if (ret)
+		return ret;
+
+	multiboot = multi_boot();
+	if (multiboot >= 0)
+		env_set_hex("multiboot", multiboot);
+
+	if (IS_ENABLED(CONFIG_DISTRO_DEFAULTS)) {
+		ret = boot_targets_setup();
+		if (ret)
+			return ret;
+	}
+
 	reset_reason();
 
 	return board_late_init_xilinx();
diff --git a/include/configs/xilinx_versal.h b/include/configs/xilinx_versal.h
index 98792aba7cce..b634bb1ab705 100644
--- a/include/configs/xilinx_versal.h
+++ b/include/configs/xilinx_versal.h
@@ -43,6 +43,8 @@
 	"ramdisk_addr_r=0x02100000\0" \
 	"script_size_f=0x80000\0"
 
+#if defined(CONFIG_DISTRO_DEFAULTS)
+
 #if defined(CONFIG_MMC_SDHCI_ZYNQ)
 # define BOOT_TARGET_DEVICES_MMC(func)	func(MMC, mmc, 0) func(MMC, mmc, 1)
 #else
@@ -124,6 +126,10 @@
 
 #include <config_distro_bootcmd.h>
 
+#else /* CONFIG_DISTRO_DEFAULTS */
+# define BOOTENV
+#endif /* CONFIG_DISTRO_DEFAULTS */
+
 /* Initial environment variables */
 #ifndef CFG_EXTRA_ENV_SETTINGS
 #define CFG_EXTRA_ENV_SETTINGS \
diff --git a/include/configs/xilinx_versal_net.h b/include/configs/xilinx_versal_net.h
index e17b44093548..2b441da91a10 100644
--- a/include/configs/xilinx_versal_net.h
+++ b/include/configs/xilinx_versal_net.h
@@ -57,6 +57,8 @@
 	"ramdisk_addr_r=0x02100000\0" \
 	"script_size_f=0x80000\0"
 
+#if defined(CONFIG_DISTRO_DEFAULTS)
+
 #if defined(CONFIG_MMC_SDHCI_ZYNQ)
 # define BOOT_TARGET_DEVICES_MMC(func)	func(MMC, mmc, 0) func(MMC, mmc, 1)
 #else
@@ -125,6 +127,10 @@
 
 #include <config_distro_bootcmd.h>
 
+#else /* CONFIG_DISTRO_DEFAULTS */
+# define BOOTENV
+#endif /* CONFIG_DISTRO_DEFAULTS */
+
 /* Initial environment variables */
 #ifndef CFG_EXTRA_ENV_SETTINGS
 #define CFG_EXTRA_ENV_SETTINGS \
diff --git a/include/configs/xilinx_zynqmp.h b/include/configs/xilinx_zynqmp.h
index 51f0a4253406..c57ab14d1b97 100644
--- a/include/configs/xilinx_zynqmp.h
+++ b/include/configs/xilinx_zynqmp.h
@@ -63,6 +63,8 @@
 	"stdout=serial,vidconsole\0" \
 	"stderr=serial,vidconsole\0" \
 
+#if defined(CONFIG_DISTRO_DEFAULTS)
+
 #if defined(CONFIG_MMC_SDHCI_ZYNQ)
 # define BOOT_TARGET_DEVICES_MMC(func)	func(MMC, mmc, 0) func(MMC, mmc, 1)
 #else
@@ -174,6 +176,10 @@
 
 #include <config_distro_bootcmd.h>
 
+#else /* CONFIG_DISTRO_DEFAULTS */
+# define BOOTENV
+#endif /* CONFIG_DISTRO_DEFAULTS */
+
 /* Initial environment variables */
 #ifndef CFG_EXTRA_ENV_SETTINGS
 #define CFG_EXTRA_ENV_SETTINGS \
-- 
2.36.1

