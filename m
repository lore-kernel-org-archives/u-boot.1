Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC8C9E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 13:05:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0586C80243;
	Fri, 20 Dec 2024 14:05:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J6ltTGgs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C342280326; Fri, 20 Dec 2024 14:05:56 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::631])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 572B38021D
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 14:05:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HxJCpJj8Oy7tYGQfdDsTkI7in7/QIIcV266UOkkqmM9tdL9dgjkfU2EZH2PgNpBfaW8TJIENsaMsM60uZ/gZFjuLZl48a/Krdn9EXjbygH574e/DwI3I/c5xB6dCqI0AymMtJXJCE43MumMyh5XqmZYrIgwAP3/RsgpLW4NdhXWdbCgHlKfKwllVZzgyf+1/K2iAuqbtGZdw80MOeC4pUtF2jaHWhxJ33relh0if8v9f7BXYHHZgLb8jLoRptThCQ1WWu2I3Vdxlo22E8nh0vxM+37zlSh31uof/sW4uZzozIp9uVXgE7qMOXrqpq8mX6M9ZMiGch8/zQ6hLW6tBSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjUer/OlD47ZZ0iLc9t9EzmDBkJWNHauEfUXCiQzTfM=;
 b=u1CR+o83ycDHwcpOeZka0c+t7vJD3UT6VvWPjRnZ61hnFJ3B9KNQ40br91nMmD3CCXYO9Hb2R7z9tSPIXYrKn4xQwHLXhIJEM95Fl7eF3TYSQUQXcDA745EaDqpe+K7lA2Tp2ES14Tl37UWUjlBIlBn9LpS8KwXIB/3wRYU6T+XRRaUeHI2vhzcSQg9ketPJ+OF5/Gq/9MjSVZyGLH+Xo83oVTnpAPExM4U67BDJ9YbJmuxTmyn0gnCkvSNV7ExaXstlU4gVpQCt8Yvf6siipfFkmerfDk4b2h6nTpDmmQl1V7WKvYEK0R57uQghK2dLGhezwsehuKZQDR3tkwlk/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjUer/OlD47ZZ0iLc9t9EzmDBkJWNHauEfUXCiQzTfM=;
 b=J6ltTGgsf9cGOjxJEvJAylblkQ3zg3ugmdS00D/gWRhrzBKhm4TTEo8GLoiWwcURZM23s4jBS9xjkoLRs8x0Yr3RqGetK/wrQMWAhS+77MlU5W+Id3fWJqkyrX69j3s0A5ZUQWp2bDRPGp7Vfv+jY/LdVKs6wuigL9mfr2PlpKU=
Received: from SA1PR04CA0005.namprd04.prod.outlook.com (2603:10b6:806:2ce::14)
 by BL3PR12MB6619.namprd12.prod.outlook.com (2603:10b6:208:38e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Fri, 20 Dec
 2024 13:05:50 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:2ce:cafe::13) by SA1PR04CA0005.outlook.office365.com
 (2603:10b6:806:2ce::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.25 via Frontend Transport; Fri,
 20 Dec 2024 13:05:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 20 Dec 2024 13:05:49 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 07:05:49 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 07:05:48 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 20 Dec 2024 07:05:46 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@amd.com>
Subject: [PATCH] config: xilinx: Enable the SPI_STACKED_PARALLEL config option
Date: Fri, 20 Dec 2024 18:35:40 +0530
Message-ID: <20241220130540.1917013-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|BL3PR12MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: 123c668d-2033-41cc-e19b-08dd20f706e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZOn9xbLHHF9MIbfGUyALHmqcPI8HVnjVHw9/j3ATWJM3FtX269WjPnVUcxmZ?=
 =?us-ascii?Q?PGiX0wX4gYgQnKaxt1x2HXdYLBNJ0K5JsFzENsl3A34Rqo4WW+0UYB/8+iMn?=
 =?us-ascii?Q?TGTvRTJBfc0oRZGjZU83yoUoEceUP4TdyGRyAHUigYF+HHyzQrEubb6aTyWU?=
 =?us-ascii?Q?Lsc1UU1e5HlzTCaeO2MazOeBzKsDyYsGTznIgQTJLy/V5z3zTPc7FYroyHvc?=
 =?us-ascii?Q?a+EO3ZCECBhsc2iGNL45GSEG/qYhwTJQyhHUT/2xRDhQhygav0knJEbippZg?=
 =?us-ascii?Q?CKruSkPnYfQXpO0BhqOkMRilqlvO2x1VVNFMlhSnKO2Ct4hRTbRXz/kktv0S?=
 =?us-ascii?Q?2xG+EJcdS8RqInGqr/PpKjTqkMU/+2a8S6gzsO4Fd+50dhXHUsf7pejSVMDt?=
 =?us-ascii?Q?JB29E+YsXF7VpZHAtNptw5lQ0yyNmSA1uIdnSoiZN9b4PdIBuvt8BCDwBM6K?=
 =?us-ascii?Q?R0jIUGDYi3pwERpdorB89C2kG4rI07MKJuq1fdW0OloEh/YUv4dfZPAVFLcB?=
 =?us-ascii?Q?tRqWUvhOKpCsWiAtHEygeJ/GDnTY16UM1YPs1JHo+gIAHJtUW52WLpPuuR5L?=
 =?us-ascii?Q?yLQ/Qtj+yp8n5OuckhmnNywUPibVdqD+MO+TI6aozBD3DSiRk4N/LKizUJdG?=
 =?us-ascii?Q?XUWAwzET+7wRzDvvCbf0KCqvrDKGyfehHgKMvHSHYH2ELBPYl992pW7a6Sl/?=
 =?us-ascii?Q?9OwIDtxZRlSPzTQyxFjcQZvII6pzPlPVxvpR+m0Ka3N5jhUbT1St1HUw6U3G?=
 =?us-ascii?Q?3CgdgyZGVjMv5VRJyt//wu/EhdTSOejUP/e1OuvmZ9WSOndcMnu0FgKFypqE?=
 =?us-ascii?Q?9ffa4pbs4iPhmzjYIRLaStMxp5qn8RSkInPOhGAV1dGQqDjQGdzgP57kKvCu?=
 =?us-ascii?Q?yVDurVffol39Ps4Oer2mNYEsV+pjeGlpd2Qo6Tit4GEaxR9AdhO9TRirdsR1?=
 =?us-ascii?Q?cJV+n3QMVA4HdKDA3PmJon0Eo+3kPzHCcQ4Nvn+G9rcxtdoEliqpqCNKRbex?=
 =?us-ascii?Q?c4lD9U+HcCB8QMjmQLp1Kq8Rz0oZ4PaMcZ6H+4CAyDNg8/LBNLGlr1xfLDLm?=
 =?us-ascii?Q?5vbg+RlZ7+bcMlB3yilfQe8z3ZTSsTzmgSqnEWeogci0h9JkymoK5yRjE+Kw?=
 =?us-ascii?Q?mMJkZRxO2u5JqQMx+jaL0HgWLfRYrwgV1oUVr5Tm418C91PUnSxcsBoHibcn?=
 =?us-ascii?Q?KPmDuNHypVqquGDFxSrnA/bJ3KygMZfonk+E73LN786jlzPa8uyO7sDd1ePl?=
 =?us-ascii?Q?HYqzhA87GMRzj1Em+s+fOWC2lOUS7hBW91HZej+pKvTtF/WAuvAiRMvO3pGi?=
 =?us-ascii?Q?teaMvNwxRxQSeZI3hBwHTvUXSnBQYlTeFQjl7Yzzzn39aC7UiVYK+lVp0evd?=
 =?us-ascii?Q?iouOJt5CNHBO//Cc1PnvCa6NZkcVDruz+OOUna+N2O9MyD0GwPtloZh57Gcu?=
 =?us-ascii?Q?4Xo8OyAXM8I9l+KO83IvuP9UNk2BhCk9welAle7NE3LpXYqANjDT6p1ftqoK?=
 =?us-ascii?Q?nM6t6lyZUXh/l0w=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 13:05:49.9952 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 123c668d-2033-41cc-e19b-08dd20f706e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6619
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

Enable the SPI_STACKED_PARALLEL config option for
all AMD/xilinx platforms, as this is required for parallel and
stacked memories.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 configs/amd_versal2_mini_qspi_defconfig       | 1 +
 configs/xilinx_versal_mini_qspi_defconfig     | 1 +
 configs/xilinx_versal_net_mini_qspi_defconfig | 1 +
 configs/xilinx_zynqmp_kria_defconfig          | 1 +
 configs/xilinx_zynqmp_mini_qspi_defconfig     | 1 +
 5 files changed, 5 insertions(+)

diff --git a/configs/amd_versal2_mini_qspi_defconfig b/configs/amd_versal2_mini_qspi_defconfig
index eb63f060c1b..2750fa2cc27 100644
--- a/configs/amd_versal2_mini_qspi_defconfig
+++ b/configs/amd_versal2_mini_qspi_defconfig
@@ -74,5 +74,6 @@ CONFIG_PL01X_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_ZYNQMP_GQSPI=y
+CONFIG_SPI_STACKED_PARALLEL=y
 # CONFIG_GZIP is not set
 # CONFIG_LMB is not set
diff --git a/configs/xilinx_versal_mini_qspi_defconfig b/configs/xilinx_versal_mini_qspi_defconfig
index 4d23b353409..529815afe16 100644
--- a/configs/xilinx_versal_mini_qspi_defconfig
+++ b/configs/xilinx_versal_mini_qspi_defconfig
@@ -78,4 +78,5 @@ CONFIG_ARM_DCC=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_ZYNQMP_GQSPI=y
+CONFIG_SPI_STACKED_PARALLEL=y
 # CONFIG_LMB is not set
diff --git a/configs/xilinx_versal_net_mini_qspi_defconfig b/configs/xilinx_versal_net_mini_qspi_defconfig
index 8453be5a590..818c62c6959 100644
--- a/configs/xilinx_versal_net_mini_qspi_defconfig
+++ b/configs/xilinx_versal_net_mini_qspi_defconfig
@@ -76,4 +76,5 @@ CONFIG_ARM_DCC=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_ZYNQMP_GQSPI=y
+CONFIG_SPI_STACKED_PARALLEL=y
 # CONFIG_LMB is not set
diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index e5ffc7076fb..5d91338c12e 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -196,6 +196,7 @@ CONFIG_SOC_XILINX_ZYNQMP=y
 CONFIG_SPI=y
 CONFIG_ZYNQ_SPI=y
 CONFIG_ZYNQMP_GQSPI=y
+CONFIG_SPI_STACKED_PARALLEL=y
 CONFIG_SYSRESET=y
 CONFIG_SYSRESET_CMD_POWEROFF=y
 CONFIG_SYSRESET_PSCI=y
diff --git a/configs/xilinx_zynqmp_mini_qspi_defconfig b/configs/xilinx_zynqmp_mini_qspi_defconfig
index a60403d82c2..1204c1583d4 100644
--- a/configs/xilinx_zynqmp_mini_qspi_defconfig
+++ b/configs/xilinx_zynqmp_mini_qspi_defconfig
@@ -92,6 +92,7 @@ CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_ARM_DCC=y
 CONFIG_SPI=y
 CONFIG_ZYNQMP_GQSPI=y
+CONFIG_SPI_STACKED_PARALLEL=y
 CONFIG_PANIC_HANG=y
 # CONFIG_GZIP is not set
 # CONFIG_LMB is not set
-- 
2.34.1

