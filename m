Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33495CFD35B
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 11:49:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63EDE88C9C;
	Fri, 11 Oct 2024 13:49:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zSpDYAzH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24B4B88D94; Fri, 11 Oct 2024 13:49:30 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::605])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC0A788C7D
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 13:49:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MTg6gsqGMPEa/1G3aNV5cmZdkSWPmaJMsMUWM7Z+T76QnoiNiooh9C5Gyybnl0KQEaJREQ9JgGqP4VXtc3r1fEwfsXYuj6F8+bA7d8wplswiFI4yvOB0w5gZQl5hfbmqbHg8OI35atorxHPAJT3htwJcOZAY+GVw6jtanHKowTJu6IOizIyr1Kski27x3uuf1aqo12yP7mSWT20m2u8jdFAgKqtjZB4b+w/jq9QYXjR05Svz8UzcYZ69vnpdWVk8+uRl08N9nRA1P40o7WpHC8oq6D6DgEmqeMlOfgVr1djPSrlMQ0IbdKVbYCy4GUiHRFXyR1D9qx6iv8u7sKVw3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOsaZ+lkwGl0hqGuZTaYxQ8w6VU0r447MAuQIMpy3nA=;
 b=n+VREhlHN4cZk48XXCDAUaU4it2WMaOETZMpzNUN5H8NnZuIkp1DNFASbTBgVM2emaiLJY7AkqLss5iPsW9Lno8qlRryXOh7cq129CuERKr5lA+xr7DKCHgxopQROu6Gu6D/7PXjsrcGug3EibCHFtAycO9lMPByEdA3xANSIEmFt+3e623XHG3BFGSqzA52leI3H43N9w9rwB4lhGrd6dGyS1P2jZnFVZ9gtKTjNAG+1U7Le1/MEu9ET14nb6NxNr3ryRvDEATpF5tm2n7wYhgOa5QSSf+CfMgQppBkllI4TTtH52mf9/W9lYsFnx2a/uFMknDiubRC0R8CswdOpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOsaZ+lkwGl0hqGuZTaYxQ8w6VU0r447MAuQIMpy3nA=;
 b=zSpDYAzHEKu48/r1n48iuUrkYDtnh2YnQ4AvEOCjHR5tViPiuPbKp+XL3rnuP7jE+uKgto4mDTNhdHqI5v81M6EJ0+MSAxHdz+QDtk/GkXtMV5LNILUaTT1uyoU1lzLC7lTiysykfetYcCGf3u0/FtGRD7bfGhJJvf3ZvFR4QY4=
Received: from CH5P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::18)
 by PH7PR12MB7161.namprd12.prod.outlook.com (2603:10b6:510:200::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.21; Fri, 11 Oct
 2024 11:34:46 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::28) by CH5P222CA0022.outlook.office365.com
 (2603:10b6:610:1ee::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20 via Frontend
 Transport; Fri, 11 Oct 2024 11:34:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Fri, 11 Oct 2024 11:34:45 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Oct
 2024 06:34:44 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Oct
 2024 06:34:43 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 11 Oct 2024 06:34:42 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <Prasad.Kummari@amd.com>
Subject: [PATCH] arm64: zynqmp: fix tcm initialization for mini u-boot
Date: Fri, 11 Oct 2024 17:04:35 +0530
Message-ID: <20241011113435.1966604-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|PH7PR12MB7161:EE_
X-MS-Office365-Filtering-Correlation-Id: dec853fc-7e4e-4001-1e33-08dce9e8b4e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+Dn7ajSBPEn8P7Z0ZEKpORegmxcDay1prDlxbWS5/kO5ymD3tWR8jgFI/XnI?=
 =?us-ascii?Q?1nbYlaKhaI8P1+feVZhOUsUZHvGL6TIdl4N57EWvIQBUp1Dwh7sIvNOW7W9a?=
 =?us-ascii?Q?NYP7PgENUWTOqX1DcVota0XW7xRxOQUo7xTnXrTr9TFrZYRm9OoC4ekyReOo?=
 =?us-ascii?Q?g7lHQUBCKfy69HNO2bJsErs8lYIjhHhshjjxIygvgQbVUGmugSXzvaELxJ7h?=
 =?us-ascii?Q?KRMNIpWkfQ5aMadIattONVC3Py5p3YOAsk2UzcwBrvLLTqXDWbpAMShSMylW?=
 =?us-ascii?Q?pQ9FQsfVGqo7hLgTNR9wwrGNCNxhzrgyfOmGkmX6/NeSZ+wiZO4hBGJifywi?=
 =?us-ascii?Q?9M4vF7tsGfXSZHkdD6fKLFDLyElN3kUa9kP2UGGcdX5zIBf6A6i8/bHXMB9a?=
 =?us-ascii?Q?k/xV20LVu3D8ieJjY3WKhhcyta9ad9cy1P6+bm4rWv9yOeUix/qkSpuXe76H?=
 =?us-ascii?Q?Er0upe/po2vZcU7u2ouXvLB1qV6Xz8jv3+tnDemnvBHMr6v6Ofkh01cfMFnu?=
 =?us-ascii?Q?ubkm6eeRZ6URnQEnVvWV1j4tPPlZ3/WZQ+iflDNPXTn1+Vu+I67DDvMt9PfI?=
 =?us-ascii?Q?5J9/zIi75kAhQWezMfq8Rore7nFYQ1Gu+f3Hc8NW3/KngV+eSZnVpSjUw160?=
 =?us-ascii?Q?l9t3wWOSeRHRR3OJ3PWnlNF+U6GCiMmyr2Nr4Z7+1VRPFQyyTu6df42kauC+?=
 =?us-ascii?Q?QcqKuP8BU2YIEMBysLrySnNVKtskqEB8zAqs35ediXOnQcTdIUDRXVu9+6qr?=
 =?us-ascii?Q?N1ab2NELznabTn2VaROMmHexlc5zD2G4nzYaxx5PWNy6YrVxpjtYbAtTtmV3?=
 =?us-ascii?Q?W2biczWwbsg09sWVt81SsKZdQQwpSwABN6xOER1KCMhCw2ugX509UZqjdXcr?=
 =?us-ascii?Q?sP/eMQEvD+0MV+lxV9UzrnolBLgjylFI0pyZ3SuJhOz3TsMN6hU3UJ1dr9DM?=
 =?us-ascii?Q?suRTTCcdVRm0ZoB52ip9OsH0jgfnlSAccu/VMkntN6YGrGj+QjUI3hLr9sZJ?=
 =?us-ascii?Q?bIdiecRBxTLuk3IqYSD/Mf2aLAonUuEWw8s3Wz8kebDNz0PaT+xF9M2+XThy?=
 =?us-ascii?Q?GJgM91pX6S4CoEL/vVAJQv4GAdMrEXPD8DwJ9sUVTifI8TXaNZ1ci8R1xT8i?=
 =?us-ascii?Q?zZH2COnThZdp72YwMx4vdYF2Hqc+EMr8q3FIYh+cJ57wCF5EtVIl5utNBTuL?=
 =?us-ascii?Q?DYCBN9w8cHFMMSQ3PXpMwQ1bCJBPELMfhmyO5801SBzBBnF3OTckS4QrQSn4?=
 =?us-ascii?Q?DUmml5lsmWlxBnQvH19Y2GRoHpMowc27fCoNToqM0MxAyZqwQoF7S5V8hPpl?=
 =?us-ascii?Q?aBnyOKDXNOeMw70tsNdicu9zROvPmb+tIqkQWU0e2JV3Ktg5KY3Ibscrsm/+?=
 =?us-ascii?Q?c/y5dpbi+F27PFz3YrA0HvFOaGdb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 11:34:45.5403 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dec853fc-7e4e-4001-1e33-08dce9e8b4e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7161
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

Fix the issue introduced by commit fed064477c2c
("arm64: zynqmp: Print an error for split to lock mode switch").
The mini u-boot is hanging, because of the tcm is not initialized.
The mini u-boot is using the tcm to reserve the mmu table and
currently it is not initialized, so allowing u-boot to initialize
the tcm.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 arch/arm/mach-zynqmp/cpu.c                    | 7 +++++--
 arch/arm/mach-zynqmp/include/mach/sys_proto.h | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-zynqmp/cpu.c b/arch/arm/mach-zynqmp/cpu.c
index b24c1631479..6c43063bf23 100644
--- a/arch/arm/mach-zynqmp/cpu.c
+++ b/arch/arm/mach-zynqmp/cpu.c
@@ -112,7 +112,7 @@ u64 get_page_table_size(void)
 	return 0x14000;
 }
 
-#if defined(CONFIG_SYS_MEM_RSVD_FOR_MMU) || defined(CONFIG_DEFINE_TCM_OCM_MMAP)
+#if defined(CONFIG_DEFINE_TCM_OCM_MMAP)
 void tcm_init(u8 mode)
 {
 	int ret;
@@ -134,7 +134,10 @@ void tcm_init(u8 mode)
 #ifdef CONFIG_SYS_MEM_RSVD_FOR_MMU
 int arm_reserve_mmu(void)
 {
-	tcm_init(TCM_LOCK);
+	puts("WARNING: Initializing TCM overwrites TCM content\n");
+	initialize_tcm(TCM_LOCK);
+	memset((void *)ZYNQMP_TCM_BASE_ADDR, 0, ZYNQMP_TCM_SIZE);
+
 	gd->arch.tlb_size = PGTABLE_SIZE;
 	gd->arch.tlb_addr = ZYNQMP_TCM_BASE_ADDR;
 
diff --git a/arch/arm/mach-zynqmp/include/mach/sys_proto.h b/arch/arm/mach-zynqmp/include/mach/sys_proto.h
index b3396db28f0..9af3ab5d6b6 100644
--- a/arch/arm/mach-zynqmp/include/mach/sys_proto.h
+++ b/arch/arm/mach-zynqmp/include/mach/sys_proto.h
@@ -51,7 +51,7 @@ unsigned int zynqmp_get_silicon_version(void);
 int check_tcm_mode(bool mode);
 void initialize_tcm(bool mode);
 void mem_map_fill(void);
-#if defined(CONFIG_SYS_MEM_RSVD_FOR_MMU) || defined(CONFIG_DEFINE_TCM_OCM_MMAP)
+#if defined(CONFIG_DEFINE_TCM_OCM_MMAP)
 void tcm_init(u8 mode);
 #endif
 
-- 
2.25.1

