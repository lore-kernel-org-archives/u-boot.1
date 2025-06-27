Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7442C77B7F
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 08:50:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24D2382E35;
	Fri, 27 Jun 2025 10:50:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="syUm+c/2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4C7D82E9A; Fri, 27 Jun 2025 10:50:22 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::615])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0F2082E27
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 10:50:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LFS24jPr8nba50pF0n078UO7jaN1r+4BO8EStkuhimX7iY+eXq97x/uLFigL3DSgKGZcq3zMfiycZBUaJhcJjgjWSGfd/kXhXkKs8Aj7xuzgL98jrsdA2Im7mBzfpy4DXXK4MmRzZ1KzE/+1BqTNra7MzXzzo1GF09ZXpkf/w0F1ns5lav8GlXac72hvt20PEhHTGU590e/TsfDOcvUIPnBWY0gnmeRlCa59J5+ICachstpAOHVpuJtg/BdYSfZ1KVRRw96r9ZTBOCfZg+DEd1F5YNtlInV8p03rktobvWN25jX3Y6j1/dhJwA3w+mUVfZztsb1aYt6XuOKU5itvYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+dac8F//S6lcB30BqIz9RZJ4JDD9pD9Lb1HiRnFF1wA=;
 b=gDBUxLyEZJaPkflfB1O9qaYePDYrs0Gt3dEH2olluc4Xdl2hLMxujFPID5/DrNqYHFU6Eul6rpUKWmLHz4O0+/CyXZuboE0+0N5suFIvS1c+l1koQCVLoFMBLzWs5kfa2EDxGwm5hqtCUFncQ75MYlBxbm9Fkh4/awDS+URTdXhGZ44L30ppTKxCwMY1Zvaa3Drx9e0TvKt9TJmBnH2i27HE61DIWBTIvgCpk4NRwZtixSVzmT/7IHG3QIxRb51yxNbZXZxH2YJhxXzo6o8RK/uRGcnm5dqypbARCYVMiSJHTuetRPZMGE+T/faWCAhIyz6X9cJ1QtTTN2t7aFD1qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+dac8F//S6lcB30BqIz9RZJ4JDD9pD9Lb1HiRnFF1wA=;
 b=syUm+c/26fz867ZcCiDabEqSQIBmB8IiWH52XmSRa07icR3IK2iAk+pZtfRH9k5KtHD/rGfrh8/nEsyQ2C/FvjRXbPQ5eFJ+Fl5miAzy7iCO6jjBHs4BF+iMQLLUwAcY4VBITI+YM9yzX0tqTJUBnscnaaiYsFMLVojgVrrbNFU=
Received: from BN9PR03CA0574.namprd03.prod.outlook.com (2603:10b6:408:10d::9)
 by MN6PR12MB8470.namprd12.prod.outlook.com (2603:10b6:208:46d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Fri, 27 Jun
 2025 08:50:06 +0000
Received: from BN3PEPF0000B070.namprd21.prod.outlook.com
 (2603:10b6:408:10d:cafe::5a) by BN9PR03CA0574.outlook.office365.com
 (2603:10b6:408:10d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.23 via Frontend Transport; Fri,
 27 Jun 2025 08:50:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B070.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.1 via Frontend Transport; Fri, 27 Jun 2025 08:50:06 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Jun
 2025 03:50:04 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Jun
 2025 03:50:02 -0500
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 27 Jun 2025 03:50:01 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Casey Connolly <casey.connolly@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] cmd: Introduce CMD_HELP
Date: Fri, 27 Jun 2025 10:49:52 +0200
Message-ID: <3f2984f62d6bda6a4a432b51047eddb70e35571f.1751014184.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1067; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=suBfioSmunNdKtsEWV8vEEidSyRvpf1Gj7N2mOhiRUg=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTERRuL3PrxU/lxo0xZ1jrvglcLm575MFw0szoh/PiuS
 PfmhVoiHaUsDGIcDLJiiizTmXQc1ny7tlRseWQ+zBxWJpAhDFycAjCRnGBGhiO/V3J4vuRVO7Su
 yeJZ66UXYotfy58tyv/5WCfnkWQD83eGX8wHJ+jNEnZpEn8iVyv72CHXz+7tlAk7Tit/VWY0OmG
 whAsA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B070:EE_|MN6PR12MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: b1d4d739-8a65-4df5-acbc-08ddb5579d8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?22sGGPIT1WmArQclIzCRYNaEJqb2Tz/Eob91co8NcBEaaFp+kkp3/wN5x+4y?=
 =?us-ascii?Q?nKKcVmQuPX29VeE7ABY+Jn6Y594KzV5ZYAj98AsMOsyn+It2ab120slXDT7D?=
 =?us-ascii?Q?t6M+OuTP6Mt4acHwj7LW2qwYRKrzwdwRLbY7MUZu68v/8dJYGYCLwqBTTNrn?=
 =?us-ascii?Q?+MMdOg1y7lUr1anU24QQVVnwJXC7tvJTQF4P8Tr4kGSUXwaZXWCivx6WBRlI?=
 =?us-ascii?Q?s8MrtBaQ674grv9+EDZ5uVg+eIVZ14pcrlCLS9bwurt79zqf8wcxKEOiECnu?=
 =?us-ascii?Q?YVDdpPXzbj2ssMI07bjpv/6s2/NLU0Rrk7MbGELei5cLVhyUgJU/9lSpkEeJ?=
 =?us-ascii?Q?a9rfLZiiu7Xr1rKERTZeZomjw5qRE/eMX+QxM5UPTOnvdhe8FGEVBQqvUosA?=
 =?us-ascii?Q?d2Sku0CL+tU6WUijCfHNOFx318m5zukk3al83lYNwERAvnOzBr1Wte3gB7ga?=
 =?us-ascii?Q?iLoji0/pkMvGCVNw8N/ggJyU2jEDKheZNJsIXdfd8787njFwsAUE45WEe/YW?=
 =?us-ascii?Q?SyOMKxri2j3dXjuf8EFOfuF7GsiEDW6R6m8MreE02YVlg5/5i6/Q8SPjpkyI?=
 =?us-ascii?Q?CihqG0G79ExDB5/KKpbVG1bTOeTCzQYuA7CcMUVluXBgcV4+X8e4NBX8cj3g?=
 =?us-ascii?Q?W9yvukNegFtYLdJcy9wGwh6jd/5IZheQk2o+A+XwaZRKCJLUBo9Zyl8jLKT5?=
 =?us-ascii?Q?aoGGXgyJzcVQsEiznt8VWG0zuiLSi3AS89IjLgJ2J0YT6W8q5rUrhbSV8Thb?=
 =?us-ascii?Q?6TEnAPvfMhcD947LhzL/pnt9kjZvqsMqfaiSdDS75ylI6QdghiqEnzmt3PD0?=
 =?us-ascii?Q?Skx3it0kz1KZ+xrlAmvdnrBSiBVx2QoJ6tjRb9gfhOlK+Su+wANkJyJfdLRQ?=
 =?us-ascii?Q?Ug0Ql9eN1pp9oGcWmoiZnw8tpRAhs67C+dbmDJxcn0kKzfJPk6McwWCgreB/?=
 =?us-ascii?Q?yppTRTBxaNpFGjvQscot8Whto5MEiNFm5Xl6s1lRAxrh4PeHaPV2wbAekJqM?=
 =?us-ascii?Q?UTKqZATg5hCPUqT/mQiDPd/ZuMdZLPMUKEfHtz1CarviW5COYC2PVMuA/dxo?=
 =?us-ascii?Q?VpsiORfJaNRgUjjb//hL2N2uQRzKXzjQff5AzTKXHjbnsZc5zsY0+7kTo6nc?=
 =?us-ascii?Q?xHlL2L1Wxu3jriy1fNcAUkpsqp9oR32SaOztSskhLR80OxY27X32vV5pAirh?=
 =?us-ascii?Q?z4rVUE/QxBr9lvt6SY4z2ba6adL8ZeG7Rlvg5uaQ1ltEN/0TMS7QAD9WzfeN?=
 =?us-ascii?Q?NrMbUk/lKV0ifYCVQy3vMOYjRL220yHVfYpELHdh40quYBo/wWPsTr2xxvyD?=
 =?us-ascii?Q?lYygAdDPVPHMm3roCsS4crLH5UITq4YW5cuEC4W90uJClIo0UdnhJ/Sp7mW2?=
 =?us-ascii?Q?9HKM6fXmR1tUnPL60zoWvx9MkhuKh9v4+qsL1FyLhcMcbktAZujzFRmlCrrQ?=
 =?us-ascii?Q?7bx0imN0CtEl4gOaLi3y2ljNroNzcfRGaNdnfUeLEYY3C3py2yq/8OcFQnET?=
 =?us-ascii?Q?W0W6bt28WWYT58N6YOS7+9U0SmeN+Y2eeSM0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 08:50:06.5945 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d4d739-8a65-4df5-acbc-08ddb5579d8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B070.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8470
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

Add option to disable help command in size constrained systems to save some
space.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 cmd/Kconfig  | 6 ++++++
 cmd/Makefile | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index f21d27cb27f2..3f4221cb4d02 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -189,6 +189,12 @@ config CMD_FWU_METADATA
 	help
 	  Command to read the metadata and dump it's contents
 
+config CMD_HELP
+	bool "help"
+	default y
+	help
+	  Command to show help information about other commands.
+
 config CMD_HISTORY
 	bool "history"
 	depends on CMDLINE_EDITING
diff --git a/cmd/Makefile b/cmd/Makefile
index 80cf70b7fe8c..718eff4ed197 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -7,7 +7,7 @@ ifndef CONFIG_XPL_BUILD
 # core command
 obj-y += boot.o
 obj-$(CONFIG_CMD_BOOTM) += bootm.o
-obj-y += help.o
+obj-$(CONFIG_CMD_HELP) += help.o
 obj-y += panic.o
 obj-y += version.o
 
-- 
2.43.0

base-commit: 8c20ef07b8939e5ea703224ad91a8669badaaae5
