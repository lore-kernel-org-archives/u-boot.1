Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D95E674BA
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 08:37:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF76F89017;
	Fri,  1 Nov 2024 09:37:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QC9BdJi6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B196D8902F; Fri,  1 Nov 2024 09:37:45 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::631])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 960E788E26
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 09:37:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LrCPL9M3ksPNnISoanVWb7BLG+KEH31UHCSEfbgPbPm4stEE04l9TFcv4ZORJSW2R8aZW8Poq2MylJGboAKMmy6xlxxKM3gR57okjoYWovTYfBYybKvtkLhiVbhWLu9uMd1+rI3t6kqRFjky18IcIg7TYASPPolbWgn7qm9UDLk4YQZaI/G2ePESAXvMt4Z4qyyn0v27lLmalWpjUsaUWmDQ5U4BT8dhr3HbhtX8VrQX2wJLX1v2WaCKH40nt5nKf4RYXi1S8Gz1JzFFpkB+QSPJKbIaOrAPWgrGLgl/yLC3cNeEtfLb8UuXqPxVD5iL/pq/i2lpbMN00bo7PT83NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LagC8Dp4nmqUs5jSoa03jXKdZ7xABPQWoA9YaZJYl8=;
 b=T3dMkh3+Ffz1GrPoHw3xy/z8ialpcu18EXy+H/wF+0n7rkuC4symNaCDZrJyuNle8WNb8KB3Ew6J3lLY000ZjwrfZ9pt2htFx9/5n0n/v9dVyUgTR6WE3jLe9pCT4rPDG3EoGB6OkBQ+bFDjna+WUxAY7WJhLh4plNC3IPNQYbJGM14wK84BLAkGdKul0oYkN4092y+EaaOFNEVNtk10ZW86qvBJzbGZWoWolrrZ0qKApJe5/kBNs4Fm0hmzTb5hyHZWFVDujqSQahrA5yUW8tBm7hOHliaUB0G6Eg9IFDSXtpJB6BxODLJVvjeXKGhjdpe/qC1VJjLfgwIQKp73MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LagC8Dp4nmqUs5jSoa03jXKdZ7xABPQWoA9YaZJYl8=;
 b=QC9BdJi6S0egENf9vr0QUDeiKnK+0JJc6bkIoSRBvTCLX9KhiiHf2j3tdvyg1d947RYgXUVJPcYvg6lm1ApC1zSELjYk34/pnNs4R9KJSk4MxBd+j9GYHgActzd7rjjATR6BhymzFIeBagP9jLH+47Dw4JnbVaQJG/NWiSgb9VA=
Received: from BYAPR02CA0019.namprd02.prod.outlook.com (2603:10b6:a02:ee::32)
 by IA1PR12MB6626.namprd12.prod.outlook.com (2603:10b6:208:3a2::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23; Fri, 1 Nov
 2024 08:37:39 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a02:ee:cafe::fb) by BYAPR02CA0019.outlook.office365.com
 (2603:10b6:a02:ee::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23 via Frontend
 Transport; Fri, 1 Nov 2024 08:37:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 08:37:38 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Nov
 2024 03:37:35 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Marek Vasut <marek.vasut+renesas@mailbox.org>, Tejas Bhumkar
 <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>, "Venkatesh
 Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH] arm64: xilinx: Rename SPI_ADVANCE to SPI_STACKED_PARALLEL
Date: Fri, 1 Nov 2024 09:37:23 +0100
Message-ID: <fe05a0e542d6117c10956e4a104123e46f956793.1730450241.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2687; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=/XKUpfzIxj2WcKfn6w1SKMHwwyCvqIfUG1F5csLZb10=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhnSVyR537RhMBTdYVnWHzGhoK/eSszYNWT6jeqrRp5JWa
 d7GsKaOWBYGQSYGWTFFFmmbK2f2Vs6YInzxsBzMHFYmkCEMXJwCMJG6QIb5SUkLWGSmqc5p+aB9
 6c3TQO8N53QMGRa03tay2LxeT8ff/e/S4gslup6hso4A
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|IA1PR12MB6626:EE_
X-MS-Office365-Filtering-Correlation-Id: 113a3f1f-ee7e-426f-d105-08dcfa507155
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rIVTwHqrEruO2cj9xmTVLTDrFXbFGrWHuCCBeoE3D4fuqU3VDTAujxy7I+W0?=
 =?us-ascii?Q?ZsxJ6fWjSDR9kp2p1bR+grGKn1YrWR8CxpEF5SnvHMJw3h9dde8QoYO79oiJ?=
 =?us-ascii?Q?PqxDJRcQ85TrSulwxIRmTsYAo6Z+m6C82etRp5Tq8G6DkmEvRMEkeMAD7fIV?=
 =?us-ascii?Q?c+sz3dvXROI8Qx58u4IFvMcqInng6wRcA0EjuqbPq9pJtiOYQ2VVvCcAwts9?=
 =?us-ascii?Q?XGgdDKXkcAvyt70xTVjsOMDVZ5JSIeHsllsjMMyeD8BM9dCVN7esph9XylmQ?=
 =?us-ascii?Q?ZTbb9iOBHyrujeDd69BMjNljf038dGwVKm0j+Ok/EHSiWIv8/hI+PUZH/ir3?=
 =?us-ascii?Q?sH8AGc+uyFnQ+xOUt1D5wZhUWifJ3gjn7INoWTPCwlHRoBeYYqULkis4MHI5?=
 =?us-ascii?Q?O1fTxwbSbkA4ZT+sxD7SOQLeWQjYyMRlY+vZ0+iBLma8jAaYa64Tmu8VcsWB?=
 =?us-ascii?Q?zadX2QuaUIY0K3E7YZJm/AIqe08nbfrdztUwKbR3F8npXM9S+v4P/zvtiE0u?=
 =?us-ascii?Q?EzRLZulk3riZBS5iyNvjYv4MHjL+7hnO+euK7dyVTROipKKKhQs1LL8oSU+e?=
 =?us-ascii?Q?3No39m/O0kRaHk/3KHEBT6iIknL/jatLnRcDFvlNheaQCu4OU1VnUnlLsNW5?=
 =?us-ascii?Q?hE/EYXjlTweC8yLq9zzI2WqmptLT+7iIQstgvlsP6yE8omrYggLlxwWfZi06?=
 =?us-ascii?Q?VYp5EZsnFtxJAgdtzr3oIvRSspFObLJVW62KCFn9y/Hjbkc8WS0McN5J23PA?=
 =?us-ascii?Q?btZMFbDksFZ+VQ9tLBai51plFTLZyTxZ28NtLkiZRGeIgIbmOe+lzFcQTemC?=
 =?us-ascii?Q?wgMfISIP91faWMOUqvZlTAOm74wvqEzdrubQkOa3lmklq9Z+QOCTJ0vnl1ze?=
 =?us-ascii?Q?e3MPUj+tBAMM/Stagbb+/3LkS4fFmdf+3J134qgEYqgq3tZwfbNj/NiZw+L/?=
 =?us-ascii?Q?X5vLYVJmvBIMhLNsbMwTphmoK8Gp6ErX8fP9wDaIV6PlsCcrvZyB4yangKfC?=
 =?us-ascii?Q?0uoQykja9u4YmfEYNUUmSjqrviE08COfIOgqXbzzaTrgPFeicCjQDQz6RH57?=
 =?us-ascii?Q?3vc1aEzR/GNMJiyX345TuopiLetUAJSyA63WNXBu5VFl/of8CP5ORhkWISqI?=
 =?us-ascii?Q?8+CIpTAhRBsbN+Yf+hR5/U8YjlkKCXIHbzQB76Kby7hVCOOUyGeJ8H9qK3XY?=
 =?us-ascii?Q?/ZwVyTzUp0UT7VhtPwj0LlrnbEuMjyCY0UxyUi65c1eaJ4GQ8xIUMrzDFLJi?=
 =?us-ascii?Q?XYh58cg5CiDoyxsafTLUnsH16mlF/n3XPpK8HDgEbfKk393ty+tXHJEUqIWe?=
 =?us-ascii?Q?cE3PN/LN4jWuBj6iq3xiMT6wVNwie8kdU0Lwa3yLNGkRoXWixkS1ualGxlLN?=
 =?us-ascii?Q?PdQnoNx5uQt551yiqhrsMSGk0GVWIHtUKF5ZnVWOvH/RxUvfVA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 08:37:38.3670 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 113a3f1f-ee7e-426f-d105-08dcfa507155
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6626
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

Align defconfigs with the latest Kconfig layout.

Fixes: f896aa656774 ("mtd: spi-nor: Rename SPI_ADVANCE to SPI_STACKED_PARALLEL")
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/xilinx_versal_net_virt_defconfig | 2 +-
 configs/xilinx_versal_virt_defconfig     | 2 +-
 configs/xilinx_zynq_virt_defconfig       | 2 +-
 configs/xilinx_zynqmp_virt_defconfig     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
index 476c3aa8a6b5..30d79ab8c8c0 100644
--- a/configs/xilinx_versal_net_virt_defconfig
+++ b/configs/xilinx_versal_net_virt_defconfig
@@ -128,12 +128,12 @@ CONFIG_XILINX_UARTLITE=y
 CONFIG_SOC_DEVICE=y
 CONFIG_SOC_XILINX_VERSAL_NET=y
 CONFIG_SPI=y
-CONFIG_SPI_ADVANCE=y
 CONFIG_DM_SPI=y
 CONFIG_CADENCE_QSPI=y
 CONFIG_CADENCE_OSPI_VERSAL=y
 CONFIG_ZYNQ_SPI=y
 CONFIG_ZYNQMP_GQSPI=y
+CONFIG_SPI_STACKED_PARALLEL=y
 CONFIG_TPM2_TIS_SPI=y
 CONFIG_USB=y
 CONFIG_DM_USB_GADGET=y
diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index ede729b4dd50..671dd160617b 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -129,7 +129,6 @@ CONFIG_PL01X_SERIAL=y
 CONFIG_XILINX_UARTLITE=y
 CONFIG_SOC_XILINX_VERSAL=y
 CONFIG_SPI=y
-CONFIG_SPI_ADVANCE=y
 CONFIG_DM_SPI=y
 CONFIG_CADENCE_QSPI=y
 CONFIG_HAS_CQSPI_REF_CLK=y
@@ -137,6 +136,7 @@ CONFIG_CQSPI_REF_CLK=200000000
 CONFIG_CADENCE_OSPI_VERSAL=y
 CONFIG_ZYNQ_SPI=y
 CONFIG_ZYNQMP_GQSPI=y
+CONFIG_SPI_STACKED_PARALLEL=y
 CONFIG_TPM2_TIS_SPI=y
 CONFIG_USB=y
 CONFIG_DM_USB_GADGET=y
diff --git a/configs/xilinx_zynq_virt_defconfig b/configs/xilinx_zynq_virt_defconfig
index 19ef894242ff..ed3d10194857 100644
--- a/configs/xilinx_zynq_virt_defconfig
+++ b/configs/xilinx_zynq_virt_defconfig
@@ -144,9 +144,9 @@ CONFIG_ZYNQ_GEM=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_ARM_DCC=y
 CONFIG_ZYNQ_SERIAL=y
-CONFIG_SPI_ADVANCE=y
 CONFIG_ZYNQ_SPI=y
 CONFIG_ZYNQ_QSPI=y
+CONFIG_SPI_STACKED_PARALLEL=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_ULPI_VIEWPORT=y
diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index d94b298e94bd..310efdf2338a 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -208,9 +208,9 @@ CONFIG_XILINX_UARTLITE=y
 CONFIG_ZYNQ_SERIAL=y
 CONFIG_SOC_XILINX_ZYNQMP=y
 CONFIG_SPI=y
-CONFIG_SPI_ADVANCE=y
 CONFIG_ZYNQ_SPI=y
 CONFIG_ZYNQMP_GQSPI=y
+CONFIG_SPI_STACKED_PARALLEL=y
 CONFIG_SYSRESET=y
 CONFIG_SYSRESET_CMD_POWEROFF=y
 CONFIG_SYSRESET_PSCI=y
-- 
2.43.0

