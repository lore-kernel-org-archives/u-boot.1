Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F02EFC3DA70
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 13:50:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A38F887E8;
	Tue, 30 Jul 2024 15:50:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KhlPJ+tJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88B89887B9; Tue, 30 Jul 2024 15:50:33 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3267487BF4
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 15:50:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eAllmdHRdVyF8jmdKcrSf5wlEzuLlx/Nz8HFgZLAe294t72Y306reM3Y+SxgV7KHDk+VzkrOpzm0MhmHt+ZBH4nhl5xT8m+sHcKzZcVuG+SChuF91WmzwYzqkmFuzm8NcpTBc4DTQ94E/lTzuDsb5WULwaRPfFV9yDrvHDTC4hw+Z6e2+NR8wdUSDvgGhaAM1WbeS4rRSl5yOnm4KN/NCQgLf3HsOZJLrkOa481ANOZJzLFPNIP1tmFnd4zSqojrRWjUbqVO4y4eJgT9qDW+MEYm37bk2/EYu1hqTjsY7695nvLOOl3XsPUin3hJE164joZKwITqJk4uPgWC07y1WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9BNbGYo07k87fKLn2cXoD3mDKXA9xQ0GawCv4zVkPI=;
 b=yXsytIQoZS0LwWVqmaSpXnpJb3AwkllOirx1S50ZB7tuKX0z0ujwOxprCVFEkPgZJmylAhxMQ0m6lWvJQB0ecMGwMIIxYsQGEdpLZi4qri60ydOofNvifbIYVk5BDf+Gs7DnA1Dr4+J2WVenu/WY2UADWhwnAvq7kqLKLWi83/LmABhoORaxaks8kilDOrXPMLNz+FGE8GfC26O5Ayw+dDT+Q1vwKznkndaThclgTqY1JMFAF/iVKq37OPe/xZcC8V46PBmOD7fqoPaMt1j7uX4Dm4OP+5OKrUhDw+TRSBsshxzsUAAp3/+syPRMiBpCWLb9bwehM021PFuSoO4Ouw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9BNbGYo07k87fKLn2cXoD3mDKXA9xQ0GawCv4zVkPI=;
 b=KhlPJ+tJUV86JdkLFwz8xQnF5PKPgn6YzoT+h5ugZ29faT5FfiUiH22l3Di16cmqsIL6CJn406DCdeM3MDjpJFjQZJUCVnMIPUZzXavpo/gosPxbzi5dgGUv0/yy0XSxN8HkeDCn8MAckstWsyOb9fjlhfq5RvsM4JZH4M0GtfE=
Received: from MN2PR19CA0044.namprd19.prod.outlook.com (2603:10b6:208:19b::21)
 by DS7PR12MB6069.namprd12.prod.outlook.com (2603:10b6:8:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.29; Tue, 30 Jul
 2024 13:50:28 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:19b:cafe::72) by MN2PR19CA0044.outlook.office365.com
 (2603:10b6:208:19b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28 via Frontend
 Transport; Tue, 30 Jul 2024 13:50:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 13:50:27 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 08:50:25 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH] ARM: zynq: Add support for 7z010_lr and 7z020_lr
Date: Tue, 30 Jul 2024 15:50:17 +0200
Message-ID: <14d8905a89d1b31fbb2318512cf57eb0256c11be.1722347416.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2312; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=KV0M/48S5W0/6zLZJElEh6x5SrLbRv36iryajIddO5A=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrQV72f79GdYi75p6lne8nox2/bFqxdXXP199PO/0hlJR
 4/13Fic0BHLwiDIxCArpsgibXPlzN7KGVOELx6Wg5nDygQyhIGLUwAmIqrJMN810WP2i6hvvLva
 92mLzy77/zrg+B+G+eGbjvIxT2SZP0nDOz+Pv/Y8k0mbHAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|DS7PR12MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d580a71-c3bd-4e6a-e077-08dcb09e91bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DqoDw3AsP6bbzb2E7+0Ys6C+OMBEdpV8y9ylHY3Wr2z9eTa1KuuB9JsHC+aN?=
 =?us-ascii?Q?599T5rQ3g8FLqfKvqkST3E4rD/hCjNFno90cd58YUmgzazV81lu1oA/CN/5S?=
 =?us-ascii?Q?qbgYtz5UMFrfZbDdkuk/d7sFeJQE8xepxwLKfMpva2K7chKX7YYI6iHOU27F?=
 =?us-ascii?Q?rF6YYNvcGJ0nOrMrOKO2cAuoly3AnxFq2h0GeVghbPvf2TeASESOq3xrxaRi?=
 =?us-ascii?Q?Lz6EgS8IxSfl17pn8SmcZKRX6ZeP3YGQNOzB6/spTKopdu4dTnNjrneA0OBu?=
 =?us-ascii?Q?t124KHI9suJ4UWHgOwBYfgvhSDKzSSYKluj8jmtwm9dp5IfVPd2jdQ3uqKOw?=
 =?us-ascii?Q?n5CIXGE7m6kGIrD26XgSBXSu7pukpVIKGThXQTTVaIWMGAPWHXjp+iyhUUB6?=
 =?us-ascii?Q?/4Esecg0AOXofheY0ldLSSv3T+P2TNo6pfI7kynuIHHtK3iXuXpSq+SjDRQY?=
 =?us-ascii?Q?MzBnQYvcJbywy4qqbOTY+CYz6DSbRCaMLE20LV4Ki4MGSlfEa7+4zqpbs5dN?=
 =?us-ascii?Q?gRGiEdfmyF+zAiXjpnD1PS/VMDI5oeZB4GxcnxBTETHEVYHW0tA5euBFFTeQ?=
 =?us-ascii?Q?Ff6aXfmSm8D0KXtygLGVLK+NI8OOmkVLdNHLqiVmbF1M7TsCoySMXLCGUvcf?=
 =?us-ascii?Q?Gfvos9IWUkluPHYekpc2/bF2CdnGUXKTBa+gRLSJ3uuyu1BW05tp4kF1iRl4?=
 =?us-ascii?Q?8umjGSbftGF81zHrxrwBCLP0e7VxurqFHxa132tVmrC/ugjIp3sgQWgVxJPB?=
 =?us-ascii?Q?rwWmSN/qOwgN0konxvhrk3+ny2W65qpkgyyu4/JCj5A1TbYRHo7ercgPJjcq?=
 =?us-ascii?Q?okKfJf7G7pnISC3RQlvl9WgmXGfoXp7b5/4tPC2oUEmXjJ28BObbVZAb4/K0?=
 =?us-ascii?Q?ebfZoVW3+iNi3mXPFjRPnZpNWHfSw/ZArQDv8gEBo1lmYfeIJl1v6IEFafYi?=
 =?us-ascii?Q?HEyljdEVouE8f9SDEPDf2jFu8iNBtFijcfaRM/DFqxmZz0M/kZf+YWp2xPmM?=
 =?us-ascii?Q?Lkvj2yb10pUswqjJulpXmzUxNeYRWn7zhJLH1BG8YMBkUPxn8Gm9s8bRiMBD?=
 =?us-ascii?Q?f1hkmWbpRjxaR5Bh4uJ4ciE6BoHG4gYlcOqZdjm6c33hMHw2r3uF1SzohnXe?=
 =?us-ascii?Q?/fHGbHJnqkYTihiaRrwnMUvGP5l3marh4kHSI1odOVcrM9kZV5TUM4J7aPSz?=
 =?us-ascii?Q?IK0gaLmvbbeMKqdHLE+xMBresJmkn9yf1b4SAVZJyeIRGbocAj0xoQwVA1JF?=
 =?us-ascii?Q?U3Yc5C998ybMP6RVSPASR35bO/CehMQyWEerGExrv4R2r+n3XfakX24/ZWEc?=
 =?us-ascii?Q?ElXRwVWQM6L6wZfga5XCJwbrVnmgeszIOGQqczAz0bCWENGIJFWplev6KlIl?=
 =?us-ascii?Q?fuj2PByfwZB5f7uspMTWnp8poVDt/5pbYlesTSgSur/h/Qvliyyl8GdTl+Zd?=
 =?us-ascii?Q?K87GaC/S5V7KiISPsM1SAYbXFzpyKeBO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 13:50:27.5473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d580a71-c3bd-4e6a-e077-08dcb09e91bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6069
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

Add support for *_lr SOCs. Without this change chips are not going to be
properly identified and bitstream programming won't work.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/mach-zynq/cpu.c | 2 ++
 include/zynqpl.h         | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/mach-zynq/cpu.c b/arch/arm/mach-zynq/cpu.c
index c75e453d5730..5b6d765099d4 100644
--- a/arch/arm/mach-zynq/cpu.c
+++ b/arch/arm/mach-zynq/cpu.c
@@ -36,9 +36,11 @@ static const struct {
 } zynq_fpga_descs[] = {
 	ZYNQ_DESC(7Z007S),
 	ZYNQ_DESC(7Z010),
+	ZYNQ_DESC(7Z010_LR),
 	ZYNQ_DESC(7Z012S),
 	ZYNQ_DESC(7Z014S),
 	ZYNQ_DESC(7Z015),
+	ZYNQ_DESC(7Z020_LR),
 	ZYNQ_DESC(7Z020),
 	ZYNQ_DESC(7Z030),
 	ZYNQ_DESC(7Z035),
diff --git a/include/zynqpl.h b/include/zynqpl.h
index d7dc064585ea..08d067d87572 100644
--- a/include/zynqpl.h
+++ b/include/zynqpl.h
@@ -20,9 +20,11 @@ extern struct xilinx_fpga_op zynq_op;
 
 #define XILINX_ZYNQ_XC7Z007S	0x3
 #define XILINX_ZYNQ_XC7Z010	0x2
+#define XILINX_ZYNQ_XC7Z010_LR	0x4
 #define XILINX_ZYNQ_XC7Z012S	0x1c
 #define XILINX_ZYNQ_XC7Z014S	0x8
 #define XILINX_ZYNQ_XC7Z015	0x1b
+#define XILINX_ZYNQ_XC7Z020_LR	0x9
 #define XILINX_ZYNQ_XC7Z020	0x7
 #define XILINX_ZYNQ_XC7Z030	0xc
 #define XILINX_ZYNQ_XC7Z035	0x12
@@ -32,9 +34,11 @@ extern struct xilinx_fpga_op zynq_op;
 /* Device Image Sizes */
 #define XILINX_XC7Z007S_SIZE	16669920/8
 #define XILINX_XC7Z010_SIZE	16669920/8
+#define XILINX_XC7Z010_LR_SIZE	16669920/8
 #define XILINX_XC7Z012S_SIZE	28085344/8
 #define XILINX_XC7Z014S_SIZE	32364512/8
 #define XILINX_XC7Z015_SIZE	28085344/8
+#define XILINX_XC7Z020_LR_SIZE	32364512/8
 #define XILINX_XC7Z020_SIZE	32364512/8
 #define XILINX_XC7Z030_SIZE	47839328/8
 #define XILINX_XC7Z035_SIZE	106571232/8
@@ -44,9 +48,11 @@ extern struct xilinx_fpga_op zynq_op;
 /* Device Names */
 #define XILINX_XC7Z007S_NAME	"7z007s"
 #define XILINX_XC7Z010_NAME	"7z010"
+#define XILINX_XC7Z010_LR_NAME	"xc7z010_lr"
 #define XILINX_XC7Z012S_NAME	"7z012s"
 #define XILINX_XC7Z014S_NAME	"7z014s"
 #define XILINX_XC7Z015_NAME	"7z015"
+#define XILINX_XC7Z020_LR_NAME	"xa7z020_lr"
 #define XILINX_XC7Z020_NAME	"7z020"
 #define XILINX_XC7Z030_NAME	"7z030"
 #define XILINX_XC7Z035_NAME	"7z035"
-- 
2.43.0

