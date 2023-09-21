Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73954E70717
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 11:28:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C024586C35;
	Thu, 21 Sep 2023 13:25:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eiRqkLE7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDAA3864C4; Thu, 21 Sep 2023 13:21:00 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBFA4867D2
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 13:20:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NbsblXxofLuvksRvUitdeSdaE8Z+dt30Qj/CWkRCjBpLDTJctFDVmw1leqwrEmUttbEk5Z3Bew/dJEJxlOcIdTVMrBKydFMMYbff94FBDXtezsRBtXwGH2rafKLdvIf/eFAv/D4ZlbuTweOwJ9UZt8Xb7XczyEqSw9vd1JzFrtSAyafOiiFcllzPnf0HxLPF4tvLGe56BThlqrDe1LiMhhAfZQc8WXiYejpRk4HQ488AWAaSPKb6TYK6Ig0XQHigSIuUHJHoK3mrvzhnNcieW8fszVXD+2nGI+iLntk1MczU+kRnZsLBjRfC0cmwgcv8DZKT3BTcqVRjNiARhVsIrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEcnx3l9vOw8jKqqXZgNzmfAbjXiVuKymSpUMdsN0Iw=;
 b=ll6WzUFY7s9TFYD//NsbsYJUJVRLgU7ZYh2LBLukMNNT/KtTh1e4eD0QpL2IXePdR1fiMyprveM9qvXYHL3n4VTORWTjlasNUwlV89Jxbtc9q8R8DKr0IO4cIh0+cuFXjTNZglv1/vgXExaeLTFjT7RmqiMxbfoFblFITGP+XbBRubRfP9BlygyJBFxIHpysoANPH9SVcsusj6TXIPRe8cp+nhDenkcM89Q+dmxTc5I7zxcYZ+Noi/VRf2iuWB82vYxRxK7tiLtUMO/yd6Uu73uuGCNyL3RJxxOfQom88S500shFz1kvmGAgzMt9xY2V5GSrIY1BZMOFjPcwcrD/CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEcnx3l9vOw8jKqqXZgNzmfAbjXiVuKymSpUMdsN0Iw=;
 b=eiRqkLE7peegejDyFZ//6L1UJm2N0aPY8pV/nJqO82OLznM6hlCMzYeWV9vOXznK/1dL9IG/99Kq50e+3Ht9dykDR3MZtxUXWFOKu8dXWCnEb0I0xwSIJPEO8eFeOEbQGOWpxKNq/5WCpNrIuKASRKWNIseVHKiF7uNt8RIp+Wc=
Received: from MW4PR03CA0286.namprd03.prod.outlook.com (2603:10b6:303:b5::21)
 by PH7PR12MB7260.namprd12.prod.outlook.com (2603:10b6:510:208::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 21 Sep
 2023 11:20:55 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:303:b5:cafe::72) by MW4PR03CA0286.outlook.office365.com
 (2603:10b6:303:b5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.31 via Frontend
 Transport; Thu, 21 Sep 2023 11:20:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 21 Sep 2023 11:20:55 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Sep
 2023 06:20:53 -0500
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Thu, 21 Sep 2023 06:20:52 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <sjg@chromium.org>, <git@xilinx.com>, "Algapally
 Santosh Sagar" <santoshsagar.algapally@amd.com>
Subject: [PATCH v8 1/2] configs: Add support in Kconfig and convert for armada
 boards
Date: Thu, 21 Sep 2023 16:50:42 +0530
Message-ID: <20230921112043.3144726-2-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230921112043.3144726-1-venkatesh.abbarapu@amd.com>
References: <20230921112043.3144726-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|PH7PR12MB7260:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bb2595c-ce22-4247-7912-08dbba94d273
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ixLRfRaQS5zUHSpTQ7Xy88Hn7Lji6xfd57HEtjvRF+2kMB9RGJpE5Py8XH+CPcuSlsV+G8hpX/74+XzYhpKIDdkQ8iipq28tyHv182ZrYFzYMVsYb2mD6cw2I+bv3OBXdr9R8WyikUSyG2N8uviaYSnfXyf2neJm5nCxuVsRtbyurXItEsD35P/3PI/qZ5dsgIgmv8gY66u2Q/foGumaaz0OhFYwFzSxTLDXFqhFYGixRRn5cdVUFhwtpT9YGUKNEjzxU3lQy/1qhwhn51fsBE4giNieTz6MCIVnTldZjL2rUtK+nrnGoEV1IPXBU6FJCzh9OkM6Y6tyWNcpUBP4DvUMiNFMwvPPj9uqM/EDwlGY57nsJHXLC8grMpFSA3WprLO2fA03tPi8dAMP5xrJ2qesNS0YCSWmxZ4vaT5B27Nh6t4vuWWTf/77gsyGJ/WEjIcpwBD9wJeyQpUXkl5SEs/ADUD37SEGwg3NlxhteCxRVEJAFOyuxOQoOhpoi7NnJaiChYE3Yao6dvjGUXJgeu3tmy8wLyxmqJherDGB7DZrYsybe6sqnzejAyzHaQhN1JcZbr4fbjONLo82DsxaWa/QlysNoDa2MyRa1rRu0PjMUQ2LN/+mURg/33/rJ2tHlHXz+yVHmtRvAsc9fYqWoZTfCRsdnnbjMI7m3H7winnJMFWEzOhJgmzOQlAsDObdKKJtrzKxPzL07W+3Pt6jKB/5dtbyRLCsG0bZCzXnV/D6sLfd3Js442hWk+J7gMdqgyiv5jaH7gfyiEv8jt6v4A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(396003)(346002)(136003)(82310400011)(186009)(1800799009)(451199024)(40470700004)(36840700001)(46966006)(478600001)(6666004)(36756003)(8676002)(336012)(2906002)(2616005)(426003)(54906003)(70206006)(83380400001)(4326008)(47076005)(41300700001)(8936002)(26005)(6916009)(70586007)(40480700001)(40460700003)(86362001)(356005)(1076003)(5660300002)(82740400003)(36860700001)(316002)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 11:20:55.0360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bb2595c-ce22-4247-7912-08dbba94d273
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7260
X-Mailman-Approved-At: Thu, 21 Sep 2023 13:25:12 +0200
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

From: Algapally Santosh Sagar <santoshsagar.algapally@amd.com>

Move the DEFAULT_ENV_IS_RW to Kconfig for easier configuration.
Hence, add the CONFIG_DEFAULT_ENV_IS_RW config to the defconfig files
to allow enabling them for armada boards.

Signed-off-by: Algapally Santosh Sagar <santoshsagar.algapally@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 configs/eDPU_defconfig                      | 1 +
 configs/mvebu_db-88f3720_defconfig          | 1 +
 configs/mvebu_espressobin-88f3720_defconfig | 1 +
 configs/uDPU_defconfig                      | 1 +
 drivers/serial/Kconfig                      | 6 ++++++
 include/configs/mvebu_armada-37xx.h         | 1 -
 include/env_default.h                       | 2 +-
 include/env_internal.h                      | 2 +-
 8 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/configs/eDPU_defconfig b/configs/eDPU_defconfig
index 77ea2b2eec..61fb9bd2a5 100644
--- a/configs/eDPU_defconfig
+++ b/configs/eDPU_defconfig
@@ -21,6 +21,7 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_USE_PREBOOT=y
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_DEFAULT_ENV_IS_RW=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_SYS_MAXARGS=32
diff --git a/configs/mvebu_db-88f3720_defconfig b/configs/mvebu_db-88f3720_defconfig
index 829567014f..e6fb80167a 100644
--- a/configs/mvebu_db-88f3720_defconfig
+++ b/configs/mvebu_db-88f3720_defconfig
@@ -22,6 +22,7 @@ CONFIG_USE_PREBOOT=y
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_DEFAULT_ENV_IS_RW=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_SYS_MAXARGS=32
diff --git a/configs/mvebu_espressobin-88f3720_defconfig b/configs/mvebu_espressobin-88f3720_defconfig
index fc394a7e9d..64ee99d64b 100644
--- a/configs/mvebu_espressobin-88f3720_defconfig
+++ b/configs/mvebu_espressobin-88f3720_defconfig
@@ -24,6 +24,7 @@ CONFIG_USE_PREBOOT=y
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_DEFAULT_ENV_IS_RW=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_BOARD_LATE_INIT=y
diff --git a/configs/uDPU_defconfig b/configs/uDPU_defconfig
index fa1989518b..4d3d53ac7e 100644
--- a/configs/uDPU_defconfig
+++ b/configs/uDPU_defconfig
@@ -21,6 +21,7 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_USE_PREBOOT=y
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_DEFAULT_ENV_IS_RW=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_SYS_MAXARGS=32
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 8c54bc9c47..4d27034c3f 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -24,6 +24,12 @@ config BAUDRATE
 	  in the SPL stage (most drivers) or for choosing a default baudrate
 	  in the absence of an environment setting (serial_mxc.c).
 
+config DEFAULT_ENV_IS_RW
+	bool "Make default environment as writable"
+	help
+	  Select this to enable to make default environment writable. This
+	  allows modifying the default environment.
+
 config REQUIRE_SERIAL_CONSOLE
 	bool "Require a serial port for console"
 	# Running without a serial console is not supported by the
diff --git a/include/configs/mvebu_armada-37xx.h b/include/configs/mvebu_armada-37xx.h
index 76e148f55e..18b55be0d8 100644
--- a/include/configs/mvebu_armada-37xx.h
+++ b/include/configs/mvebu_armada-37xx.h
@@ -30,7 +30,6 @@
 /*
  * Environment
  */
-#define DEFAULT_ENV_IS_RW		/* required for configuring default fdtfile= */
 
 #ifdef CONFIG_MMC
 #define BOOT_TARGET_DEVICES_MMC(func, i) func(MMC, mmc, i)
diff --git a/include/env_default.h b/include/env_default.h
index b16c22d5a2..227cad7c34 100644
--- a/include/env_default.h
+++ b/include/env_default.h
@@ -21,7 +21,7 @@ env_t embedded_environment __UBOOT_ENV_SECTION__(environment) = {
 	{
 #elif defined(DEFAULT_ENV_INSTANCE_STATIC)
 static char default_environment[] = {
-#elif defined(DEFAULT_ENV_IS_RW)
+#elif defined(CONFIG_DEFAULT_ENV_IS_RW)
 char default_environment[] = {
 #else
 const char default_environment[] = {
diff --git a/include/env_internal.h b/include/env_internal.h
index 6a69494646..fcb464263f 100644
--- a/include/env_internal.h
+++ b/include/env_internal.h
@@ -89,7 +89,7 @@ typedef struct environment_s {
 extern env_t embedded_environment;
 #endif /* ENV_IS_EMBEDDED */
 
-#ifdef DEFAULT_ENV_IS_RW
+#ifdef CONFIG_DEFAULT_ENV_IS_RW
 extern char default_environment[];
 #else
 extern const char default_environment[];
-- 
2.25.1

