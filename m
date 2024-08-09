Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B18C49EA1
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 05:05:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 324DC88A0E;
	Fri,  9 Aug 2024 07:05:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yl/uEJlX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4038988B81; Fri,  9 Aug 2024 07:05:23 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E8F28871E
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 07:05:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qvQgqoNMVPEzw7T392HloPUs7DphyElz7h4U98cHuXBSmd8w/jJnj9vwggFLGpkOeWYRkHRfKmHD9KN4xhsBcXYCLaKgNFnxhz/l+yl4pctcYsvOGwfK8zNAboWPX8I1nxPbb1YqD3WqY5Hq6TC6C1Nn6dFzo7fDYekpLK3TQ+IlO1AO46dVavlW1qpUsUoZ/rLan+FLWSWJgzHS4YNDSsOc8XL9E6olVlKaVt84RR9yiqF75hEy791rtooI3eCUT7nyUSdDzK/0/ri9Bxjpi3NIoZMA/ZI7sKHzOhQNEbcP1++jRaxAfM9pQj6HePyBVvQSMfkEIEW2ycOFznhRbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=heJTjVUpp2d/3Blwhtg2brIrvd4Qt1DBzQy4lydQ5qY=;
 b=Ruy0SaFvaR1WYLH70YU7C2CD0ng/0FRkt3MwX38p7brAFREJym8K93qMmr5fgS7Ihz24QFxUrZnLSILIDJ1ke/TvIWeN47TYBfI7nj5MhTsEBbaM2otfmikqcn0qEo0nfUFcJ/O7y1ZaucE+PkvVE0xr4G8QwIFq9rbNk2dpS4Ec1a0/k1/u5WNyvpfJUQwOtm37xz6PGYIajFGRjSY1w3Og8sM+LD5afHPMU7Atd7oBQHAWHZSiOkbRAeO6uwbn97yJn5w0YDuQiVJe0nnaq/7sh8455kO3g+1vhRy/C4sw3Y+0Zh+ZbZmTqCMGoju+UQDRqt+Dxr70qp+irnXjzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=heJTjVUpp2d/3Blwhtg2brIrvd4Qt1DBzQy4lydQ5qY=;
 b=yl/uEJlXIn0c6w7IbPvDYZ6iR4eB1SkFgcm0XJ26l5sVlQmRq/F+fWonI0lMZCW7HUkeBEELTKaxC9tR8/UeEWCW7xDsweblFuWNOaqAHnVF0JbQKuPMm3MVmjQ+Ve26Spfta94NFS2GsIBQwcYSplUGMjMPJrWvryD/SENY5S8=
Received: from DM5PR08CA0048.namprd08.prod.outlook.com (2603:10b6:4:60::37) by
 MW3PR12MB4458.namprd12.prod.outlook.com (2603:10b6:303:5d::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.15; Fri, 9 Aug 2024 05:05:17 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:4:60:cafe::65) by DM5PR08CA0048.outlook.office365.com
 (2603:10b6:4:60::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15 via Frontend
 Transport; Fri, 9 Aug 2024 05:05:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Fri, 9 Aug 2024 05:05:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 Aug
 2024 00:05:15 -0500
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 9 Aug 2024 00:05:14 -0500
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH] versal2: Update the sys prompt name
Date: Fri, 9 Aug 2024 10:35:13 +0530
Message-ID: <ffe76860e1a67728e27ff904a6f7639a771fddd4.1723179877.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: love.kumar@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|MW3PR12MB4458:EE_
X-MS-Office365-Filtering-Correlation-Id: a71a4ded-bdb3-400a-8a7c-08dcb830dc02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0OHagJw8M6uPOI+rG5Cw0NsWterqIsSMw8b6DeaFyhPs1UYWrItYZwzAbD6+?=
 =?us-ascii?Q?dnZYcpekTXmAHNYENhtOLF1/KFFUZlBIXeLyHvN9yHEigbKY1e0aSW76KNp9?=
 =?us-ascii?Q?GYN6wu/4pFDJYdU0PdM1aLtlZww0E2ngiEl9yECk3XJpcleWnEJev/82tPg1?=
 =?us-ascii?Q?M75huBLGEDT73xi8RYDCUwjMvGgghI0AS75jFFFwnBUkBhMsBJqCYihYd1lT?=
 =?us-ascii?Q?ZfQzvPNBqO/IKUdhwqm/PCnl/r2E5ZbNib6yNTyTFjp7h/c4s2HPoDCxfYpT?=
 =?us-ascii?Q?8HLbZSYDfH0mVNtJdHauwS4CEIE1utObXGP/IhDIWUEv5HZou6kgYt2f5FS0?=
 =?us-ascii?Q?8FHyWwsW7U9xoKMdXGxqh0Jr5o7ak3qR7l6z4ZAXyGlfgFTXV7LmCw2UKOvc?=
 =?us-ascii?Q?eK207uaLL3YmWGa+1HAcgDPnC2wJtasRKkU/gxYKd6YXweAbFOKthRY3LXPP?=
 =?us-ascii?Q?0DIyXDlloeenL6fzupHDXxdTQNsKTK9Qi5bpPu1tn3L4yKrMn4YHKlEQvJdi?=
 =?us-ascii?Q?/fJyEsJUm5FcZbqMdtPQWHUmN1ypSM+dyKoj9pCpB1YnoMMeadBhOw5Vo3Lu?=
 =?us-ascii?Q?bs+Nvn2j1/zcraeFLgVeYRsdlV5CWGC3KILyynoj/Lx0ideusSUy82GXkhRn?=
 =?us-ascii?Q?3my3nbedtfoSUnLNU+wyDUNnxO968WKsJwDdDE1FYCkCfunNkEz0kItzTjEB?=
 =?us-ascii?Q?Hc9CUD9Hc1UeLL0KSKMt+VbHMvMlr2dtRAK3jq42YH8jP7AqDg7X+FFz9tLG?=
 =?us-ascii?Q?yLkLN4RImrVEJHouoKuLWQnU4loiLeRrOsjNM0jpU9DSZiYzjVQxlrOjMFyz?=
 =?us-ascii?Q?E3huo1pH/1DaKztwGdmPf9jPkzy3LD83wQr2K4TsgfKZnLLu4aaUzhMrTH9U?=
 =?us-ascii?Q?IwdqtBwkme7WSfs6YyKS1J4gqjTmNRgdOrNSGRVJSIIwNvjbivRiUyItfn5f?=
 =?us-ascii?Q?wbFr1rs2buTk2wryB0NC+/vlU78MvOJI3LXhZU893xl4TYfrN9gTT/uhdMFT?=
 =?us-ascii?Q?+YNG8NJ3gDuJoZCv9eyx/I+H10bU2JRQ7kjRdh35UCQfc0CtGaD5Xk7u83u9?=
 =?us-ascii?Q?B1+KCJfc6lAJ+SCFmdon0rySQcVpOpvRVdQh1l/KyRdMk+FphSrdyRJj9/9f?=
 =?us-ascii?Q?Pt8KiPzGjJnhRfpaNMbTnBCQZkhVmy9ZJWT68v7AWOPWlRNyhmscTnc21Vrm?=
 =?us-ascii?Q?kw89MyYP6fyFoYR4FzZQ74YcG+hRSlMniF/k7CNQMqxUsTT7oCuczA3J5mPJ?=
 =?us-ascii?Q?JhpaWasIYEZJm3dngyXKpGepWK5X8eAM3N3PIYY4WvGBSDY2IuXOe2Hy47e5?=
 =?us-ascii?Q?8y2MrQC72i6xy7b+ZrDDah9L7aeMwDip8Be8ImEchtiz00coyZHcK0eYEBwn?=
 =?us-ascii?Q?k9aZnYa4XEb6ASGjnGvPZ9FK761lTAJQ/LRI4GrYPJGmaUWBSYd+kZt2AmnJ?=
 =?us-ascii?Q?W5thNu60mbU6GkEaCvSJjDIKAYyWIPj4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 05:05:16.7144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a71a4ded-bdb3-400a-8a7c-08dcb830dc02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4458
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

versal2 refers as "Versal Gen 2" as a generic approved name so using
the same as u-boot prompt name for all versal2 defconfig

Signed-off-by: Love Kumar <love.kumar@amd.com>
---
 configs/amd_versal2_mini_defconfig      | 2 +-
 configs/amd_versal2_mini_emmc_defconfig | 2 +-
 configs/amd_versal2_mini_ospi_defconfig | 2 +-
 configs/amd_versal2_mini_qspi_defconfig | 2 +-
 configs/amd_versal2_virt_defconfig      | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/configs/amd_versal2_mini_defconfig b/configs/amd_versal2_mini_defconfig
index 0dd2305bfb2d..2af9ff4d8377 100644
--- a/configs/amd_versal2_mini_defconfig
+++ b/configs/amd_versal2_mini_defconfig
@@ -32,7 +32,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
 # CONFIG_CMDLINE_EDITING is not set
 # CONFIG_AUTO_COMPLETE is not set
 # CONFIG_SYS_LONGHELP is not set
-CONFIG_SYS_PROMPT="versal2> "
+CONFIG_SYS_PROMPT="VersalGen2> "
 # CONFIG_CMD_CONSOLE is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_BOOTI is not set
diff --git a/configs/amd_versal2_mini_emmc_defconfig b/configs/amd_versal2_mini_emmc_defconfig
index 7ad44386a6da..520dabbf7c8b 100644
--- a/configs/amd_versal2_mini_emmc_defconfig
+++ b/configs/amd_versal2_mini_emmc_defconfig
@@ -24,7 +24,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
 # CONFIG_CMDLINE_EDITING is not set
 # CONFIG_AUTO_COMPLETE is not set
 # CONFIG_SYS_LONGHELP is not set
-CONFIG_SYS_PROMPT="versal2> "
+CONFIG_SYS_PROMPT="VersalGen2> "
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
 # CONFIG_CMD_BOOTD is not set
diff --git a/configs/amd_versal2_mini_ospi_defconfig b/configs/amd_versal2_mini_ospi_defconfig
index 2242960392f5..9498f4ba46c4 100644
--- a/configs/amd_versal2_mini_ospi_defconfig
+++ b/configs/amd_versal2_mini_ospi_defconfig
@@ -30,7 +30,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
 # CONFIG_CMDLINE_EDITING is not set
 # CONFIG_AUTO_COMPLETE is not set
 # CONFIG_SYS_LONGHELP is not set
-CONFIG_SYS_PROMPT="versal2> "
+CONFIG_SYS_PROMPT="VersalGen2> "
 # CONFIG_CMD_CONSOLE is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_BOOTI is not set
diff --git a/configs/amd_versal2_mini_qspi_defconfig b/configs/amd_versal2_mini_qspi_defconfig
index 3360c1546a20..6aa2223df2fe 100644
--- a/configs/amd_versal2_mini_qspi_defconfig
+++ b/configs/amd_versal2_mini_qspi_defconfig
@@ -30,7 +30,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
 # CONFIG_CMDLINE_EDITING is not set
 # CONFIG_AUTO_COMPLETE is not set
 # CONFIG_SYS_LONGHELP is not set
-CONFIG_SYS_PROMPT="versal2> "
+CONFIG_SYS_PROMPT="VersalGen2> "
 # CONFIG_CMD_CONSOLE is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_BOOTI is not set
diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index c4bf77186cd5..1ab916451b54 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -26,7 +26,7 @@ CONFIG_USE_PREBOOT=y
 CONFIG_SYS_PBSIZE=2073
 CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_CLOCKS=y
-CONFIG_SYS_PROMPT="versal2> "
+CONFIG_SYS_PROMPT="VersalGen2> "
 CONFIG_CMD_BOOTMENU=y
 CONFIG_CMD_GREPENV=y
 CONFIG_CMD_NVEDIT_EFI=y
-- 
2.23.0

