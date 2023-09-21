Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60357E7071F
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 11:25:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0F0D86B96;
	Thu, 21 Sep 2023 13:25:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UvuJlTMl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADC2786BF4; Thu, 21 Sep 2023 06:21:58 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::631])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2160386CBD
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 06:21:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hjh268JlAkDFH77oKRKSzYRvCizN+FOoM/y38c/l8FFpZbl7OOtcZkhCoxh/sPiU/w9WdHZDPbcRwXO4zAFLCA4NsGSz3tAFqzXICpQl4fGp4kDrbMh8wDmHNgb8AkUZxSKXVtXf3uIP7TnEUE4DVqRM0IW8NnSjMFl2FtrNPybbufPTVS9vA7pGFZebEm8P47fH0ZeSYt/fHVutmgPR7zv9SYLzeDgL34tgKBKNyO8qvoAafT3U659p2lUmbI+NKIvRjfP7g5AKXlYt3Xyyo1BLz8ZmJsnYEo/oM/Br/kOJfx39p56AzpRjSGAy4+kLyo5RIPJbelDsAI8LPq1YXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkapHNFZsFQzBIwWYxeBXkOYih8iC9yWCMre+HI6X1c=;
 b=h+lduIwRIpytirg2xenKS2VjAvMqD/5BwJGecnzHlDrmbWX5DTpkSlslvVaKEgdcpOeE4ePX35KlNfV1HLQBKyUBnSD5zLSDbv+PFe65iAbUVxAlc8a6s+dlqcrwYE+LpMG2L5FB8LAbXB3U5qI6sIVUTrhDSvClq4uXYnzk2BoDOBcqqhGM6gRDLT7GfO8LiB8W3F/GofIX7Se7gdBssAOk+ZCiniPFf+DLI+8vsQGJsGEJ3Fa67iuw2DXuyKGrTeHCNV2HR/QQQgnzy1eqW8iKu7BfvVOXFLFRdPYAdKYTQoZghQM0kueT+2OBbuWCazvXe6EgqxxrlM1K3SbdDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkapHNFZsFQzBIwWYxeBXkOYih8iC9yWCMre+HI6X1c=;
 b=UvuJlTMl5hy+wZs3onWoytKJe9CDzNrm0oj7pFkyU70JuHc+LB4T7uEGFQva+Xi8J/r8jKbyqKfBu1WBOff+4zLJ/w6qC2T9oaf6XJqjgLiqVXMYyOvl0Lb54WPbpJ/JAzCUj1mZHmOutDK0JOzKhGjGwhbMw2AnQKMCbXxb73E=
Received: from BL1PR13CA0325.namprd13.prod.outlook.com (2603:10b6:208:2c1::30)
 by SN7PR12MB7953.namprd12.prod.outlook.com (2603:10b6:806:345::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Thu, 21 Sep
 2023 04:21:47 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:2c1:cafe::84) by BL1PR13CA0325.outlook.office365.com
 (2603:10b6:208:2c1::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20 via Frontend
 Transport; Thu, 21 Sep 2023 04:21:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 21 Sep 2023 04:21:46 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Sep
 2023 23:21:46 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Sep
 2023 23:21:45 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Wed, 20 Sep 2023 23:21:44 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <sjg@chromium.org>, <git@xilinx.com>, "Algapally
 Santosh Sagar" <santoshsagar.algapally@amd.com>
Subject: [PATCH v7 1/2] configs: Add support in Kconfig and convert for armada
 boards
Date: Thu, 21 Sep 2023 09:51:29 +0530
Message-ID: <20230921042130.21139-2-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230921042130.21139-1-venkatesh.abbarapu@amd.com>
References: <20230921042130.21139-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|SN7PR12MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: cfcc6c7b-b0d8-48b8-cd49-08dbba5a44c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CZPKjKiGOROHMMvFdBIaWAX9Xg5sPP/HEkRjg1VjlT3NyYE1NT/a8A+KerdKPOFmj8/38CEDrQdJPTVdSQkDnIy8pRY20JkS00C2J5IGTrMACzhdw8e2NGm3HOihQOQfmxsraKzsGacXSMw/orLt+N5NFSyhyFtGg6bcdpaMrni639b1zhd+ry8TxWyY3cmqojdR4yngZ4ZVXwrTfjgzoP21UvtyhAZm+pdIAze89jhc+OjQ95WfJeGvZ03FMuNbHrzSFPsmIW4O3N3he8Cu2jcMRadU0fnAnNsUNlZNdugZaVMVjcbtHw9zhiZSDdfiDKGYvjr+w7ZGYX9OtqjkjjRmtGHuGuikMaDZw+IQeWevVnilIvT9PEQEgC62zW7slzmMnH9tVFBoTvA5IHKqA8Fk+DlEWJseVsnNQnBP51olFHq9hDg9WSQ0QPfRTtj9LweWaxXbBxte91q8x87TVSQJuQpO3vSHpgp3K9+j0l2k5SFkFUBv1ik9ePDgeFaKyvy+psHzCve+meSywoQyAi32hevTD9yMDGBToIVwJlLVUEs1zjz4DjgtBYJpc5o3LHaCOV8dwItew4IEDQDhIwMdP0gZrVYJv8zTzzK6eWfoTOorlf+FdED5Ikm9jGPTGCC67mfKbMv2hhpQCgwVKlSeevvYsCbg6cMDCJ/NB7kb33nYjQXJo12AFC/2Q/UMCOB22JBSsRp3Ap/2SavROtXUdwUOA2YQhyOyZPBCLJ3gS3/aWo9wNP57J068qST02PNiBKCe3M3lQa/yGI0c3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(82310400011)(451199024)(186009)(1800799009)(40470700004)(46966006)(36840700001)(83380400001)(6666004)(478600001)(70586007)(316002)(426003)(36756003)(2906002)(47076005)(5660300002)(8676002)(336012)(1076003)(6916009)(8936002)(54906003)(4326008)(2616005)(40460700003)(70206006)(82740400003)(86362001)(356005)(40480700001)(81166007)(36860700001)(41300700001)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 04:21:46.6512 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfcc6c7b-b0d8-48b8-cd49-08dbba5a44c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7953
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
2.17.1

