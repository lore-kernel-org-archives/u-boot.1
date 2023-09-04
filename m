Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D645C71153
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 13:58:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 828188695F;
	Mon,  4 Sep 2023 15:58:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F+5vgpUd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8C98867B5; Mon,  4 Sep 2023 05:16:09 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::60f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C99E4868B8
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 05:16:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JpIt61vIPuZF93faX2WEtJq+VWIMzXo/T8cJxLtwdnWT9UV0Uf3vJMtRQy6Z2UrHLmNcvvzYFRIfDgddlTwCOsfuGoW+SK/iCrnm2ec8gmi/4FCA23WFq4hjPzuv48O4sbzKThrB+uEGu/PQnkhNfxzM3WZO6iKIsG3Ve5rD09sZPR2IK4VyQPziWfPdu5ulpOBoquAXtieEe0MrhcPgY1VGpdk8qheysxTgMW8vj8VE3+Z9U8y/EA0l0vbu1GrrOfn2CBg36OqX3x+C0gaCJ9MUH9UD1szYSSh5PuHsfiAgnswsHF/TcyM4arFJ450Fy2sO4Kpr6SdevM3zcyOiqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Axho+jxbk53wF4ye8Fvx+P4LUz/BsuPCQgrLB/6VEL4=;
 b=Ms8ZgO1cV2dkRII8hniPvbFnQ7iKAhdEeH4UFJEtrAWX5uRaHVs1t+I+YaJ0HiLUX7dYNhLa9AdYtZB+JvKiOZp/VfIE2sWpICBfgoWqoil+KdifR0tukWQNhDeaLQxQTDV6Es2A2FLlQ+WRbrY9QfO5iAokF/O0/xkGinn4r24cn0nS1QyMGuDKzLGJLHhIusnBlvSLeM6Clw5ijXkSNWV/fbx0379zNmP2Qh420KIYwcnZAN5MEhggplstOLeArBJFgBlZSfOnMzmngVstEeR9Ka/vjrAZbV4+XetuDZcXHRKNZoit6wYaQrHyYTgWKcuYslx2jXqI3ZV+p5vdiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Axho+jxbk53wF4ye8Fvx+P4LUz/BsuPCQgrLB/6VEL4=;
 b=F+5vgpUdBfYa9hny9z7Lu+gS9fKi0/6dSDtF2HtL/Fm1isF0UEfsHEcciOqbxI0GrCwTjeG+LZZLeNacx0lgluI/qExejXSELIWquDpUEwU+YaFziMZgo/9G0YphDwPIPcpRWzUR72Jcho+1yeLeO16Zcw9pFBzrptINHZ+AZjA=
Received: from CH0PR03CA0443.namprd03.prod.outlook.com (2603:10b6:610:10e::7)
 by SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Mon, 4 Sep
 2023 03:15:59 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:610:10e:cafe::56) by CH0PR03CA0443.outlook.office365.com
 (2603:10b6:610:10e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32 via Frontend
 Transport; Mon, 4 Sep 2023 03:15:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Mon, 4 Sep 2023 03:15:58 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 3 Sep
 2023 22:15:53 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 3 Sep
 2023 22:15:46 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Sun, 3 Sep 2023 22:15:43 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <sjg@chromium.org>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <rfried.dev@gmail.com>,
 <seanedmond@microsoft.com>, <tobias@waldekranz.com>, <sr@denx.de>,
 <john@metanate.com>, <git@xilinx.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>
Subject: [PATCH v2 2/2] zynqmp: config: Add proper dependencies for USB
Date: Mon, 4 Sep 2023 08:45:28 +0530
Message-ID: <20230904031528.11817-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230904031528.11817-1-venkatesh.abbarapu@amd.com>
References: <20230904031528.11817-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|SA1PR12MB8599:EE_
X-MS-Office365-Filtering-Correlation-Id: 7babb0ec-ed09-4283-15a6-08dbacf542be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TzOHAAnQ8NfN81Nn9HcqCn82KE0y4GnVrX/Ude1rF/3gc6ARSRu9I3RNGIDMOv/XDWaBcxdRulFvL6WigCQs29gGJpHEqlBE2ASg0CYaZgUTxevc3vBd2L4Sfwajgerg0DVxPtzqR/T9/s/KTvW7xCLW1Bkq4P+ZIfFstmn+sSXCD9hlnL1DNfoolpJmdHnwAiY7CmBGJJYh3UmLP+KG595btmWhyQ2eV7NlVf847cnJPcFYf8xecXLsqLDHodHU1Pf0+Fy0lv9IpUHqhLq7g7ykmKK80zd/1No2UpzVmHlcByH0j6DwdSVKyeeyH1kspOSLDDq1CWaq5S+jVBZfYB6LdoZmGTzAxrfk0z82N0cvIj1VhFsq0FPACWtrpmNNcsCpz2C33Lq+Uu+FnrXfRBsGWC2hZwOMhDym/0Kw4L7B3dgmkDuydhjvj/Awn9lc1HyJ0EGvlWpT/s7AGDNRsNFWVUt0DkLkjXNEA4yABejrKlII1sCQAppphNKHdK4hHvQkDrskMnx/X+smk6gnOmJ8UzkZnRUnZc8xmIo/UMHjltA0oB9+jJnsHZEn7tmpylmYxalJ3GKr92iTQ13djsTGAWJfDjtVwXXHwwG8khht+nferifJRzP6JFgOv2ACKj2O0DQ5pGVTuyx9CbzRURAPvryXXxrGtKZBB7EnAG+Aqo7hmZeHq3Qkghk022qNcZbmt0j58254Nt+xJCwZWgIg6nhHAoZ2ngW4rqd5uFdHZHId5mhQtIek6iBk109GWHRDnghH7sHtKj+HQ2zn5Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199024)(186009)(1800799009)(82310400011)(40470700004)(36840700001)(46966006)(316002)(2906002)(54906003)(70586007)(36756003)(86362001)(70206006)(6916009)(40480700001)(5660300002)(8936002)(8676002)(4326008)(41300700001)(40460700003)(1076003)(36860700001)(2616005)(83380400001)(426003)(336012)(26005)(47076005)(478600001)(81166007)(356005)(82740400003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 03:15:58.8994 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7babb0ec-ed09-4283-15a6-08dbacf542be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8599
X-Mailman-Approved-At: Mon, 04 Sep 2023 15:58:13 +0200
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

When CONFIG_CMD_USB and CONFIG_USB are disabled, still some compilation
errors are seen as below.

In file included from include/configs/xilinx_zynqmp.h:173,
                 from include/config.h:3,
                 from include/common.h:16,
                 from env/common.c:10:
include/config_distro_bootcmd.h:302:9: error: expected '}' before 'BOOT_TARGET_DEVICES_references_USB_without_CONFIG_CMD_USB'
  302 |         BOOT_TARGET_DEVICES_references_USB_without_CONFIG_CMD_USB
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/config_distro_bootcmd.h:302:9: note: in definition of macro
'BOOTENV_DEV_NAME_USB'
  302 |         BOOT_TARGET_DEVICES_references_USB_without_CONFIG_CMD_USB
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/configs/xilinx_zynqmp.h:77:41: note: in expansion of macro
'BOOTENV_DEV_NAME'
   77 | # define BOOT_TARGET_DEVICES_USB(func)  func(USB, usb, 0)
   func(USB, usb, 1)
      |                                         ^~~~
include/configs/xilinx_zynqmp.h:168:9: note: in expansion of macro
'BOOT_TARGET_DEVICES_USB'
  168 |         BOOT_TARGET_DEVICES_USB(func) \
      |         ^~~~~~~~~~~~~~~~~~~~~~~
include/config_distro_bootcmd.h:454:25: note: in expansion of macro
'BOOT_TARGET_DEVICES'
  454 |         "boot_targets=" BOOT_TARGET_DEVICES(BOOTENV_DEV_NAME) "\0"
      |                         ^~~~~~~~~~~~~~~~~~~
include/config_distro_bootcmd.h:474:9: note: in expansion of macro
'BOOTENV_BOOT_TARGETS'
  474 |         BOOTENV_BOOT_TARGETS \
      |         ^~~~~~~~~~~~~~~~~~~~
include/configs/xilinx_zynqmp.h:179:9: note: in expansion of macro
'BOOTENV'
  179 |         BOOTENV
      |         ^~~~~~~
include/env_default.h:120:9: note: in expansion of macro
'CFG_EXTRA_ENV_SETTINGS'
  120 |         CFG_EXTRA_ENV_SETTINGS
      |         ^~~~~~~~~~~~~~~~~~~~~~
In file included from env/common.c:32:
include/env_default.h:27:36: note: to match this '{'
   27 | const char default_environment[] = {
      |                                    ^
scripts/Makefile.build:256: recipe for target 'env/common.o' failed
make[1]: *** [env/common.o] Error 1
Makefile:1853: recipe for target 'env' failed
make: *** [env] Error 2
make: *** Waiting for unfinished jobs....

Add CONFIG_USB_STORAGE as dependency for USB related macro's such as
BOOT_TARGET_DEVICES_USB() and DFU_DEFAULT_POLL_TIMEOUT and
CONFIG_THOR_RESET_OFF.

Remove CONFIG_ZYNQMP_USB from Kconfig and also from defconfig since it
is not used anywhere else.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 arch/arm/mach-zynqmp/Kconfig         | 3 ---
 configs/xilinx_zynqmp_virt_defconfig | 1 -
 include/configs/xilinx_zynqmp.h      | 4 ++--
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-zynqmp/Kconfig b/arch/arm/mach-zynqmp/Kconfig
index fd6f07715a..26b80b7882 100644
--- a/arch/arm/mach-zynqmp/Kconfig
+++ b/arch/arm/mach-zynqmp/Kconfig
@@ -84,9 +84,6 @@ config ZYNQMP_SPL_PM_CFG_OBJ_FILE
 	  Leave this option empty if your PMU firmware has a hard-coded
 	  configuration object or you are loading it by any other means.
 
-config ZYNQMP_USB
-	bool "Configure ZynqMP USB"
-
 config ZYNQMP_NO_DDR
 	bool "Disable DDR MMU mapping"
 	help
diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index acab38fefe..c0e7061524 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -17,7 +17,6 @@ CONFIG_ENV_OFFSET_REDUND=0x1E80000
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 CONFIG_CMD_FRU=y
-CONFIG_ZYNQMP_USB=y
 CONFIG_SYS_LOAD_ADDR=0x8000000
 CONFIG_AHCI=y
 CONFIG_SYS_MEMTEST_START=0x00000000
diff --git a/include/configs/xilinx_zynqmp.h b/include/configs/xilinx_zynqmp.h
index 74264b7bee..a8edf13e34 100644
--- a/include/configs/xilinx_zynqmp.h
+++ b/include/configs/xilinx_zynqmp.h
@@ -29,7 +29,7 @@
 
 /* Miscellaneous configurable options */
 
-#if defined(CONFIG_ZYNQMP_USB)
+#if defined(CONFIG_USB_STORAGE)
 #define DFU_DEFAULT_POLL_TIMEOUT	300
 
 # define PARTS_DEFAULT \
@@ -76,7 +76,7 @@
 # define BOOT_TARGET_DEVICES_SCSI(func)
 #endif
 
-#if defined(CONFIG_ZYNQMP_USB)
+#if defined(CONFIG_USB_STORAGE)
 # define BOOT_TARGET_DEVICES_USB(func)	func(USB, usb, 0) func(USB, usb, 1)
 #else
 # define BOOT_TARGET_DEVICES_USB(func)
-- 
2.17.1

