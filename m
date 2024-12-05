Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7BB6E7716C
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 10:38:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB45A89408;
	Thu,  5 Dec 2024 11:38:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ShqSRH7Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6533893F6; Thu,  5 Dec 2024 11:38:33 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::630])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DE4089401
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 11:38:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e4NUShI9y2DJLNZqO/Jv3T4oN3nNZ5SqlyEJuxDnJQAYig8g69jhyLuKUgAdelC1of3AR4NePQfVSY5LSZpo6lJ9U8S/PAs4AesnTHCK2AW6mDcj2NLFlhY2T4WYN5qaiJytNCoM0QZ6FYxknrPY3bBxfJeXcC8TvsmFM5EP+WyB/k4aBr6Iw/7g8fdVdls7fylOGGAi13utfvHC20H0ry8+6DyS0ZKSs5OZes6EB6CPVs2MDRRttkpzC8JvJY3AxddLBaDK4gfA09wjxiKVg2XDr24iDXJn1+zdou6PrmAv0+ko+NdHQae9nXgzlJinpR7eYdd6ELQuVIggvZNbSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9F8vX6dJjv2rRbiGu5SdzD0LnLaSlBno51TlhR4frS8=;
 b=SI9ztZW52Jog1spUX/TROVkzZ1eQHuBKgpWbsMrl8Iep6jATQYlpvuY35Kx7NTlHZm2iu9bsu0Hd9TukK2uU6i5GJ2PmCdS3aIQmA90uvHKGjbmrtB95EFPCPvXZRG891CDMpeCHAFqZWiFEI8e1DGzrXgrWi2/MfLpyTmfcBeDPGB5OPFAhBb+kotqy75fmVEbOY6PVPP6ltIqaWYQx5A+sPskKnahTYPgtE40GAy1sl5uYDeX/FhHGUuVfPSkpDjzW5fWcZMUlw3F6Fer+vHuUy4eilU1i9uV8feykbbDUMQbh5336pVSoSmJek9iInZtxxDxlWvkWrBa4k5q6HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9F8vX6dJjv2rRbiGu5SdzD0LnLaSlBno51TlhR4frS8=;
 b=ShqSRH7Qc+1Jbg92vVgntsTtpdLjiLZ9IMeJQRbbOI0LTuocmIIV0e/VLRKz7XYxKhA6idMwDhuo4TXWUGC/Fvmvdf19mSC9q82zTXeYmLrC969xUSM1uUkJqTfnhXf4Dp4jD/1wWPZ6xwju7bgXkqTILzM2R59fwUqN6AUptHM=
Received: from BN6PR17CA0056.namprd17.prod.outlook.com (2603:10b6:405:75::45)
 by DS0PR12MB6533.namprd12.prod.outlook.com (2603:10b6:8:c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Thu, 5 Dec
 2024 10:38:27 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:405:75:cafe::eb) by BN6PR17CA0056.outlook.office365.com
 (2603:10b6:405:75::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Thu,
 5 Dec 2024 10:38:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 10:38:26 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 04:38:23 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Marek Vasut <marek.vasut+renesas@mailbox.org>, T Karthik Reddy
 <t.karthik.reddy@xilinx.com>, Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 Tom Rini <trini@konsulko.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
Subject: [PATCH 1/2] arm64: versal: Wire SPIs for dfu_alt_info variable
 generation
Date: Thu, 5 Dec 2024 11:38:15 +0100
Message-ID: <67ff88c8c7186138353c0b74ed37a318fb4b199e.1733395093.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2447; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=LZvVQ7hA7UtVBJRU0Oe52UIF2nA00miZivqBgsn49rQ=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvTAphmVr329FL/O3jFZhl/T2Kb4coP1HuPVocnf0lZvv
 /qlZpdYRywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZiIFSPD/Ix9rAXpXD/b13i6
 JT9v9Xn412ziP4b5vj/abbtmrPoRtez/rTMP7X1N3W3yAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|DS0PR12MB6533:EE_
X-MS-Office365-Filtering-Correlation-Id: cafca134-6893-4702-e92e-08dd1518f3a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WbJTayksBywWdZ5XJQM0GQwv2TNtM3tzhpJ555WRWyJof2kK2bJNY6omBuaZ?=
 =?us-ascii?Q?mFtTQYzYOERqYdVhdJ/077xEfaFoN7Nxflb9+AIy8U0TOROqjTkp7bxJFaeH?=
 =?us-ascii?Q?CPKqxSUh+WkF7i3P+rCUmz0mKEUzbhi00rKc9YREt85F4kXFo1B+CS59rVnm?=
 =?us-ascii?Q?ztHIkpsQVdl0lUWyAYJWa1wbvNNNvvLhtdA0sxW6tACvfYHwvXdlRwT+X4s8?=
 =?us-ascii?Q?WAXKFTHqMTYV+gBIGPmvjzLIsyQ5ACm/mzP/r+BsIKWX5woG4p9ztuRJKqzK?=
 =?us-ascii?Q?AMuHGc576+A3GGCdAPyis3Z1un7nuwZmueXKr8ofn8Te1eV2peHSIZd2+6QL?=
 =?us-ascii?Q?DQImdBwfzrRsdPW8jkVhbMPtI8r+mCphSDO3cJkYLRUHMVMGmXO+qXyQm5aw?=
 =?us-ascii?Q?+kO81mK+yagQis96t2dJU9LSxsZMtF4LokFKTq3VQBUXzwTMpBPSdfAwDpf/?=
 =?us-ascii?Q?a+9g3JOxvpQui/VQ8gEzvG0oV4EO0TtxZZP7VoFvnjySu644PQKA71kziqKa?=
 =?us-ascii?Q?eDD3ocu3z75Oi8S7KsPKx3mvn+BrkugbflCDOVxtcFf/zpfl6V5BIv5majw/?=
 =?us-ascii?Q?KWQqz0gcpUhdGTzAamd69BqsRHG2L23GCQE3ToNS1jCpbgUUkx36/dBtpNHe?=
 =?us-ascii?Q?qqkdXlPAaWVbv0O1AaV/4PjF+OrO+PttItCJO2oKHN7tvtLN5WkJWxIYEMoU?=
 =?us-ascii?Q?GdaDpBdW+R2+rhPN1Q4h9Hir4BQfetZ4na1BEOt+pT08ZyDAfA5I0tsyBrK6?=
 =?us-ascii?Q?3BSzOqenEF6+rrNg/ELipK5wr5gqyFMuK1HzrmbwWI4TXgg27rh2l/k/XBna?=
 =?us-ascii?Q?XdnCHKWvE4L8EKemrH2vLkY3Ab7hblgBSa+PXVJhVV5Wlopk8bEgsLi38+3b?=
 =?us-ascii?Q?Ygtm+8BQ3hPdp7JJ1RiY4M29ZstM2ECepyH01vfrvCn9j1Vzvmk0jBIRYDHW?=
 =?us-ascii?Q?gKlV3f2tOJevk4egCNEh81bfKUXM/uitnQd8o761q4qbdjONE5DMNUr7C8nh?=
 =?us-ascii?Q?om29fcHUz2cVLF1+HgV8/dE1W4MLiKgREnnyoNoRWBsnzpIU/uS8RSxnWRq/?=
 =?us-ascii?Q?qzrLKuZbknPi24jwDaRbGWXWTx/qn0qIDIqv0p7bNM7l7UNgm5lXwPm0lPgh?=
 =?us-ascii?Q?JkLBVQoBktmU9IrTaIlvnfA1wgTYGTBSpyb5V7mXPAAFdEGUgAdfAbn//8xC?=
 =?us-ascii?Q?2UBVkfIb905TQdb33WsshRJqlN7KjHSiCHKc/R4J8VIaHUeT7AnYRl64OVN+?=
 =?us-ascii?Q?ptkZ3USIUU4Wcu464JvlOY5gZ6iPZvrGlZnP9dxJTIb1bLVMBX/rE+81ZlTd?=
 =?us-ascii?Q?fJsia85lV2Qa7Ffx7a/GAoOQn0EicJGi/X+9nCYWnIbzETt0RL94ETOMzVBd?=
 =?us-ascii?Q?VmjU295bkLwAmYRBXwZkFmqNvXUITkEg6hOMxevxmEAdDKvVSdkKsoNce5ux?=
 =?us-ascii?Q?uv6exl7uS2ePqBlo/7PP1Qd/GjJhVP5a?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 10:38:26.6963 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cafca134-6893-4702-e92e-08dd1518f3a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6533
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

Enable automatic dfu_alt_info variable generation based on MTD partition.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/xilinx/versal/board.c          | 41 ++++++++++++++++++++++++++++
 configs/xilinx_versal_virt_defconfig |  1 +
 2 files changed, 42 insertions(+)

diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
index fd5c6ced7956..964a779b5f19 100644
--- a/board/xilinx/versal/board.c
+++ b/board/xilinx/versal/board.c
@@ -14,6 +14,7 @@
 #include <malloc.h>
 #include <memalign.h>
 #include <mmc.h>
+#include <mtd.h>
 #include <time.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
@@ -346,6 +347,31 @@ enum env_location env_get_location(enum env_operation op, int prio)
 
 #define DFU_ALT_BUF_LEN		SZ_1K
 
+static void mtd_found_part(u32 *base, u32 *size)
+{
+	struct mtd_info *part, *mtd;
+
+	mtd_probe_devices();
+
+	mtd = get_mtd_device_nm("nor0");
+	if (!IS_ERR_OR_NULL(mtd)) {
+		list_for_each_entry(part, &mtd->partitions, node) {
+			debug("0x%012llx-0x%012llx : \"%s\"\n",
+			      part->offset, part->offset + part->size,
+			      part->name);
+
+			if (*base >= part->offset &&
+			    *base < part->offset + part->size) {
+				debug("Found my partition: %d/%s\n",
+				      part->index, part->name);
+				*base = part->offset;
+				*size = part->size;
+				break;
+			}
+		}
+	}
+}
+
 void set_dfu_alt_info(char *interface, char *devstr)
 {
 	int bootseq = 0, len = 0;
@@ -371,6 +397,21 @@ void set_dfu_alt_info(char *interface, char *devstr)
 		len += snprintf(buf + len, DFU_ALT_BUF_LEN, ".bin fat %d 1",
 			       bootseq);
 		break;
+	case QSPI_MODE_24BIT:
+	case QSPI_MODE_32BIT:
+	case OSPI_MODE:
+		{
+			u32 base = 0;
+			u32 size = 0x1500000;
+			u32 limit = size;
+
+			mtd_found_part(&base, &limit);
+
+			len += snprintf(buf + len, DFU_ALT_BUF_LEN,
+					"sf 0:0=boot.bin raw 0x%x 0x%x",
+					base, limit);
+		}
+		break;
 	default:
 		return;
 	}
diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index c8f166c12218..fb757c1067d0 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -83,6 +83,7 @@ CONFIG_CLK_VERSAL=y
 CONFIG_DFU_TIMEOUT=y
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
+CONFIG_DFU_SF=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x1800000
 CONFIG_ARM_FFA_TRANSPORT=y
 CONFIG_FPGA_XILINX=y
-- 
2.43.0

