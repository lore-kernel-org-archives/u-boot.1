Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A21CCE79AD
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 03:43:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F229286C97;
	Wed, 20 Sep 2023 05:42:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uRUGIs0E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1612486A84; Wed, 20 Sep 2023 05:28:20 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 099D886A38
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 05:28:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htvZu/2KZ8FVExarm3H6h63JcirzHuEp8Uffe/djnUZd4b6djs31vV30+LxE7aH/YHef+YbRIMnY00qQNk4KvgKSdW6QKOXWkXlwlZ6rl6ZYpifPLtAMPfuP3hmTcQymo8wpTin07OgqGkGrgSq+/IDfSdglGuBA3B81GgYh5znSXxQUjRS/BNwXTuBMJfV1L1qeazsmcER4kr5HFHRNM1Y+/U2xP8OyghNOc6J0PgMAciskPwbV5uI/wEXkA1G+hC8HVbhiUKDivFIbk9sxgTJseZwkiwV2boq45H1aTc1aVvR6bjPYTYafPS4LA9YBthe/N3KM3gLjpw0o8mfaLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Izo72+Oh4nlpqIBZz41nE6PWKHANiOZL2NTJ6cO6hc=;
 b=S6TMnoA2WeQIofRKuDYwmPhCtG83kcY4ijRQq//Qkand7DJ3gyKuw7SjbKqtNBH4ZjtA8P4tx6ejX1SF3v0N7qeV4nJWIcDrqS99KQkyyLgJDt5p2tXxFew2qt6xSt91aJhGR7WrTM+kJ45BkPGC9TwIlFWgflpRi4eDHx0xeecK5bHGTpTnD5syU4sJAkIbpMH0Q9j3TrewB14OOwbrN5Eh1tPwURi6XYuhWzQGhv4RKFP3BJ+xBuihLkOiHiSFfj5QNsj0rFkRzYyuIgXe3JGgVrpY50N+MfhNBaAOvHTsaa0IUZKTHxKnP9qC9r3cFApTh49UmI4zR9T3jfYi3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Izo72+Oh4nlpqIBZz41nE6PWKHANiOZL2NTJ6cO6hc=;
 b=uRUGIs0EKMYqHNqWvPhh8QLW/zOz3Av0Yxl7tqLIqdvbWy4ShnBOFqM7Vpb6J2MyKOvEFHq81spugX7iX616dXCfCxS8DHh9dxOMLwydpbeCP/JQXkOoRSDg4kUNNy0hP74mteFloCUlPhAToaaFq5Z/+henD0MJ3aGfTQoXagQ=
Received: from DS7P222CA0014.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::34) by
 MN0PR12MB6200.namprd12.prod.outlook.com (2603:10b6:208:3c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 03:28:13 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:8:2e:cafe::72) by DS7P222CA0014.outlook.office365.com
 (2603:10b6:8:2e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28 via Frontend
 Transport; Wed, 20 Sep 2023 03:28:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 03:28:13 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 22:27:36 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Tue, 19 Sep 2023 22:27:34 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <sjg@chromium.org>, <git@xilinx.com>, "Algapally
 Santosh Sagar" <santoshsagar.algapally@amd.com>
Subject: [PATCH v6 1/2] configs: Add support in Kconfig and convert for armada
 boards
Date: Wed, 20 Sep 2023 08:57:24 +0530
Message-ID: <20230920032725.21748-2-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230920032725.21748-1-venkatesh.abbarapu@amd.com>
References: <20230920032725.21748-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|MN0PR12MB6200:EE_
X-MS-Office365-Filtering-Correlation-Id: 27492bae-7190-44cb-8e4f-08dbb9899efa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zhUQa34/S7NS8QA4gATKWQGT5HTIaYTu/WjC2+6xEw+xFNzDwbWqi2RB/Juokm6yABkB5ijv2/7NW/hqOm5JWcgu9qoPRCT+IP8oCwMqmjoOKx1+R3o5ffVcE4J8fJNjCoAPqnWhHtVFHWPRCl8Bw+9j69eSiWTruqm4FjFfTSHZc3LVjS2+BlxyOaRidAofzpa8RANwFMLJwW8AnQiM/DoUJDPSeidGfAFML1afPkdrOWAphPfHBU8pv/Uw1n+dP9ckEemlsvzRsIthMvtUqnkTp+KzP0MeHzS0NvPhuR1IbNBm2jMHj52q3VqpIFfP5D+i3kyP8kab4Fc3KmAlwXpVuYIv2QnJg4dPnnZuVO1nOGxPG2f19VvCG082QLgNuEte5Bo8/g+Kra6qoGECvKyZjwjvaDK4Ty+9g73gsL24b0pw+q4a8gtZ9kMqehQVSvHVmW7v5dzWxNULzhmldVK2+Sprg2BTQTK8RBXvzdo34oLWmCaN3qdMABPILk3kTK2EtOMsdxhElRaqaakg1+Q7lWc+CUWBfhqryeWtl+eqmSSDXsIiwUAnYwLmIXdHjDbiDA9bldlvB+5OaPoWK5UllSlkNz6NMjLDEWS42jS2FFR25H4FgtcqIt1PO2wPKFwA+4hLaHaFzpuwBsPg70mfCn2R3p9RgNrA2bVkTbN+s8vS9pmerlH6x/v8Fc7nhI8ABWWUA/O1wfu/fdXEEOHdXWz2oSW7x2LE1bIsqtHdFQ/HGo6egnT9sSGq/LUPtH1sncCrtzsaq3Vb7rcw4A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(82310400011)(186009)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(6666004)(478600001)(83380400001)(4326008)(26005)(336012)(2616005)(426003)(47076005)(1076003)(2906002)(70206006)(6916009)(54906003)(316002)(5660300002)(8676002)(8936002)(70586007)(41300700001)(40460700003)(356005)(36860700001)(36756003)(40480700001)(86362001)(82740400003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 03:28:13.1154 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27492bae-7190-44cb-8e4f-08dbb9899efa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6200
X-Mailman-Approved-At: Wed, 20 Sep 2023 05:42:43 +0200
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

The DEFAULT_ENV_IS_RW is moved to the Kconfig for easier configuration.
Hence, the CONFIG_DEFAULT_ENV_IS_RW config is added to the defconfig files
to allow enabling them for armada boards.

Signed-off-by: Algapally Santosh Sagar <santoshsagar.algapally@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
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

