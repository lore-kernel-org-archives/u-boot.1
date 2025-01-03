Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8FE6E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 04:48:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 265E280107;
	Fri,  3 Jan 2025 05:48:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u2liv6ls";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8333F80196; Fri,  3 Jan 2025 05:48:33 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::631])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5F16800D7
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 05:48:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GIf+yJ2I6jTjOCYrM1qQzXaNulPqbWYeHVacXTBibzdgTR/TjnELrAqQMg7tm0S0k8L+mzXxKdAYBoSRpVOJPfJxdkCmuHp8so0aYkzgLRaql6450d5/Ddadeus7OH1wevNuW76OMNzosoPrmXzMD80G5UohIzNu8aJhPGfYD1py3qNQt8HUK1yhhbXsArtjSZa52W0pDM+Xe2TwE9ipDyL5OEZPHFhhwNQL15j5lhIWKgKcfXV+kRub3djsZ/zd95a58MR519+QNfmUtKYh1tBlvFRHiSYfRngSP2Uqt6zceXhrZoX6XbV/P0ib2qqOsiDPgHPFbgoa+H5ughDPVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7mqF71fa8NaCCjVYi+IaXjtc9xpi0CM7TriAYuhCjU=;
 b=fCuy5+PSvcFlV6GFeCg27vGlN8MKiPpE7O5sstUC3zN1AZoZ91MYA50xBDJ8SeupGdqukJrxc1PU5P7fBas4tUFL8UISGge9Cval95JUvxKnuFp7XbgAo/NQqOYtuAEBgHHQvraeuNEK1W3UOEqmHxcsnI/e9MK3UbRyHypEJ7Cr4MOkdDSVKaW8jFIZHUScDUkkD7ZVW6G8rzqaU8R2CeDVygT8XOkMY/nPrG21a9+zaSHK/Pg/Mm8904O/IgESVj73fdvt2H0Qotj7oLEPXG/QZ1oE86Um+r8aat+1N0rzl3E/TBSoOYFPIxZfsq1QlvogjX8VUxuO5wvDxhXLaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7mqF71fa8NaCCjVYi+IaXjtc9xpi0CM7TriAYuhCjU=;
 b=u2liv6lsNYMD/npiEsoVOOvaBA1x7Obl0j6zjJBFk//+AeyPXbRn5Ny5d0CA2O4FkXpKWeVovMYvOgEkR09z24F35/C719ed3jimMJ6i1rHAMBCkTtJeffxHoADKD7bADnym2077lg+b7EhqEEF8YgylJCfSrtyrNs4OBZ9BM40=
Received: from DS7PR03CA0097.namprd03.prod.outlook.com (2603:10b6:5:3b7::12)
 by DS7PR12MB6264.namprd12.prod.outlook.com (2603:10b6:8:94::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Fri, 3 Jan
 2025 04:48:22 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:3b7:cafe::27) by DS7PR03CA0097.outlook.office365.com
 (2603:10b6:5:3b7::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.14 via Frontend Transport; Fri,
 3 Jan 2025 04:48:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Fri, 3 Jan 2025 04:48:22 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 2 Jan
 2025 22:48:21 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 2 Jan
 2025 22:48:20 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 2 Jan 2025 22:48:19 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@amd.com>
Subject: [PATCH v2] config: xilinx: Enable the SPI_STACKED_PARALLEL config
 option
Date: Fri, 3 Jan 2025 10:18:12 +0530
Message-ID: <20250103044812.18828-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|DS7PR12MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: 03173b47-a8df-4f61-9bce-08dd2bb1d9f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4BUf9MzJPETAsxY6YbNyuFSjnE1G4ytthN5D3INh0fpyBH8yEGbytjyFD1Kn?=
 =?us-ascii?Q?Kco9PBg8d6ACtQmgyqRO6kLJMmpafhnaeNKBxfDPTezQrnlbl5tLgPb3sMbz?=
 =?us-ascii?Q?ty6YYVMhoRdcV1AEEb9SIEnw/1R/f4omTBBT9vfkc7IHgZpcnpuwbsmkJVCk?=
 =?us-ascii?Q?pL93Y2yWOBxWTXC01FE3V+jbH9RccieLROLWzr0gM67gHQHCP3Wodg1v9TBS?=
 =?us-ascii?Q?yoNHctXG7O1xm2+9IYOmmkjnchdHMBgxqKpVwGsjscomuHB2bQR3YiQZfCey?=
 =?us-ascii?Q?RtuVHVkhlZvAAaOg00fPPKm8ZX6g+IlFCdlEqhGDaVknpTE8ltDGUo5bpELA?=
 =?us-ascii?Q?2Kmjyp42O78SWtqEUUasVOIecPUIXNDBGKUq2rCKM8s12ymHOFH3n/m+DhqU?=
 =?us-ascii?Q?GXDTmXCLih0SxazL46tgQUaahDaYISaMZ8ShqWmRKiffWcjH7GUVMFqgvB+0?=
 =?us-ascii?Q?PZmP9recrf4l0NPLihdIG2gzzpvWWodvd+GmIN0rSszLer76NIu/9jr3gdvR?=
 =?us-ascii?Q?Pv51qgV/k3rgcHP++Shlm/uAKhXfZ9TjCurOhLMyT38jWnagTK/lPweBMygN?=
 =?us-ascii?Q?4FhtpAawr6CQWbN4RUTfs6+ASHiKR628A3QmNFLF2iKKL62afnTCAHb7u+F2?=
 =?us-ascii?Q?A4X6Z9rqqykn05476kgR7OGh81rZ6fQued8tlWLlpcMNsvczVQAC1Vrlduq4?=
 =?us-ascii?Q?+dekIC6vlPQmIZQn5s33SVx5uF03LkV8IfRE02/xQm5ZQz5KejPorrVpThRZ?=
 =?us-ascii?Q?Dym/lRbAqdu+rOVVWatx6JQHoFiSWnvZK7G3MBG58mUTZjpFL8p6x1Dn4hdz?=
 =?us-ascii?Q?pYP0hZ2S0GtJ4ndGMrAx5Y+JaIgSEBuKnkEmWQ4oT+R2eN/r6F6i5audgTeV?=
 =?us-ascii?Q?f97vbU0/8aAb45YtDJk9PKg4XhATs472WMd3PB3PK7t/ddmTtQQc+xnwsBDm?=
 =?us-ascii?Q?z4Gi+KKa8Mm6xO74D9TVJhwh/9rwWL8PgqjFq8TSDsDYrk+vEQQyMx1bDo0n?=
 =?us-ascii?Q?hbCJ2HaStruVNS3QmZU/hRAPE2jXl5DHmCVBb+06noph8u1vyIidxWW3YtKY?=
 =?us-ascii?Q?dqGqEyXP8wsKUuZydrrxlww+FzqE+WW/2yRAOcADHlTipI5nBGW9tVU++qT3?=
 =?us-ascii?Q?sPzK7VuD9SVIbbck65orjvQKDAh26+yt/Pb2Si8Ccgt0T7bIJzunOoIJH64o?=
 =?us-ascii?Q?WWuPzQhswWAbnI/9kFjO/IRcLo/hh5LrOXZEP2R3AR/4Zp/KxHS25TfcwV4m?=
 =?us-ascii?Q?GnVFxcHd1AwPRUA3rPcYl2caEeXg2L/6g2Fy+/gUasIkAq6NK8Oec6IxHE81?=
 =?us-ascii?Q?tO99oYBRHQBMliYyF8lSaJ7+bfSpZMCWfI/4naudHbfdWMGBSrCJOnBQDeZl?=
 =?us-ascii?Q?92iaS6OM6kAubz4182h76FydEK9/LuQNF3XDqr/tR2dDt220/o1zEVd+QKkq?=
 =?us-ascii?Q?ItTCNu6FGm+xyF8PUbpVVUDPP2ssHAL6bGqEx1vL2LTlSVd0KTeyBxqPX3SH?=
 =?us-ascii?Q?ChmjVHyfqJ9PxqA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 04:48:22.1145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03173b47-a8df-4f61-9bce-08dd2bb1d9f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6264
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
Changes in v2:
- Updated the SPI_STACKED_PARALLEL config for zynq.
---
 configs/amd_versal2_mini_qspi_defconfig       | 1 +
 configs/xilinx_versal_mini_qspi_defconfig     | 1 +
 configs/xilinx_versal_net_mini_qspi_defconfig | 1 +
 configs/xilinx_zynqmp_kria_defconfig          | 1 +
 configs/xilinx_zynqmp_mini_qspi_defconfig     | 1 +
 configs/zynq_cse_qspi_defconfig               | 1 +
 6 files changed, 6 insertions(+)

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
diff --git a/configs/zynq_cse_qspi_defconfig b/configs/zynq_cse_qspi_defconfig
index cd84df1e290..6a5e1dd5d95 100644
--- a/configs/zynq_cse_qspi_defconfig
+++ b/configs/zynq_cse_qspi_defconfig
@@ -92,6 +92,7 @@ CONFIG_SPI_FLASH_WINBOND=y
 # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
 CONFIG_ARM_DCC=y
 CONFIG_ZYNQ_QSPI=y
+CONFIG_SPI_STACKED_PARALLEL=y
 CONFIG_SYS_TIMER_COUNTS_DOWN=y
 # CONFIG_GZIP is not set
 # CONFIG_LMB is not set
-- 
2.34.1

