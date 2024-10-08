Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CA3CED267
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 04:59:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BF8388E0C;
	Tue,  8 Oct 2024 06:58:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tWr5MIBz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C09188DFE; Tue,  8 Oct 2024 06:58:50 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::61a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2952E88E0F
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 06:58:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=clUWQRo/tYDngxI/UXaTiuzE16378RdjgIyVfENInARoWitTvaIZ0IbriXnLkvHfq4S7GBIVfQ98z2//7qGHeeu9el1MhrVAn2egGpITZDVj7xerUWjNlktF8Pj5Pk+3b7G+q4KlG8xdvxtAApxScinlgOvha1EJbjp2+Yhf92EasbEizq8rgW7to8qGDirn1RYwHoPHGJppaTQIU2C+Tq172bmH4f26EoWTacLEBRM/QOKS4LcyLrKnhg+JN8Z2QI2sndFrBLqy6kYjcPq8/+3BVhzVsLZUxRJ5gs8wZnZBhMUgDm8KFPlpXVwT8jIRsNC/wCY0JbgJmojfijxRWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FC8GqTYwYTqTbtYBxO04t9JHkZG1x95PgiWMoZpynk=;
 b=TRItNpyzib+JB3W/8taX2UEShj+9/6NgK/42gwkiCSJ6ppjKPGuGP7FzhJ44S7QBeYnLfl2TMPptub6NEFbMOZiykJNi7QDNdMY3d+i5d/uVJMRHEcwjKe4VurPAGTzITHiGdPSnRDlD8qMeMGGQ9mg5USGMIjQz5ablr8HmpB9Xg73BJCeFbBTHQfb9fKX3lY9OGxaKkVI6SnIKqCZ5EaGYgU4bWBLBVI74lRs4iGR/MbHjqF7a5/4X1C5n3Aeu5b93ZMOfgENj3mdXJ1H99RW2X0Z6x1t3vLwqCIazOQMhS2+PcvGlmIIM0EKVXKmbKMPDFijupddMUYOBs+bJVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FC8GqTYwYTqTbtYBxO04t9JHkZG1x95PgiWMoZpynk=;
 b=tWr5MIBziswstxSDHVDi5DvqMmKRs060v9v2lp+ZmSRkBXPKXlX2rjunAbCh+rQW4lzSXdbsfkqxCC22MzwEcJoNzuFVJugsYLkvLuJ8gp6UFV5M3zuNQFRM3lQ0G+Jyr6Jm0mYfItnuXmUUkDq5NM8TEHjB2dabJas7bmvBq1U=
Received: from PH8PR02CA0013.namprd02.prod.outlook.com (2603:10b6:510:2d0::14)
 by SJ1PR12MB6122.namprd12.prod.outlook.com (2603:10b6:a03:45b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 04:58:41 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:510:2d0:cafe::ff) by PH8PR02CA0013.outlook.office365.com
 (2603:10b6:510:2d0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20 via Frontend
 Transport; Tue, 8 Oct 2024 04:58:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 04:58:41 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Oct
 2024 23:58:39 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 7 Oct 2024 23:58:37 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v6 6/7] configs: zynqmp_kria: Enable the USB onboard hub
Date: Tue, 8 Oct 2024 10:28:07 +0530
Message-ID: <20241008045808.28757-7-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241008045808.28757-1-venkatesh.abbarapu@amd.com>
References: <20241008045808.28757-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|SJ1PR12MB6122:EE_
X-MS-Office365-Filtering-Correlation-Id: 7df423d6-a2bc-43ec-2c9b-08dce755e11e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ExqlsGb19E1mskGh5eSAf+WYs1NTCe4oQ0X2/ZptP2Qrc/wooPKM2CXM9HHa?=
 =?us-ascii?Q?qqQrSIzFjcLCdQWefDPJaW9Wswx7LJtdVvu3eq+YARVwrHPeJJwxFJ+5Vawi?=
 =?us-ascii?Q?kE/qzExGqwX85uMf1zvYtK3xn2RtftRpvh0YCsqFYNlhbsPBpTk7Ukynvf2Y?=
 =?us-ascii?Q?o494N6xz8zrFEQLw8lOLW3kWYZR64SoGnupkiryMAKykxvhP3R2sFZjds5DO?=
 =?us-ascii?Q?Ta8T6gK2uuNMgEp2O1FRUzVMyNZPoVfZ8INY1+LskbDuvLa2BKPwh6VVQkxN?=
 =?us-ascii?Q?fMC8rmhqh6AiSrnpRPa063eUpgxxGxmqkv3TkolCh/1Yns+Fvxvzo7XLC1vS?=
 =?us-ascii?Q?z8t4bKVi8ZMLrLJ+4KrxhymMtMe2rZsBYIQOq91okjKHCXvLV5uCLumzBPxL?=
 =?us-ascii?Q?qSnD1aujCPLQUjpFzKu6YhxvRze6OW8tcCTY4GqkLWFMpgzR23LMu/BBxI3o?=
 =?us-ascii?Q?F8K4XfEmXzK3DSKTTQ0AJfICHDzj/WrTkwXjAgYgFYN4FgJYNYj+OEmTcDsi?=
 =?us-ascii?Q?20iPc/4VjxGqH9bZIUeEuh30ix9D+YJc1ntZ72OWExK68Au72pz13PSsS6bQ?=
 =?us-ascii?Q?XpxwAgm8UtiEYOEUeM2rgrsibUQ2AjvF5nDulXexBJS6Y7kvIwU8Rcw8gAsQ?=
 =?us-ascii?Q?cvQiDB+CQ6UxHl7Gz5B15ZuDriGg5FAxKeQrIl6O7VYpPqJQ62t9m7UOrn0J?=
 =?us-ascii?Q?zQx6lWZADBcz2oQB81CvEsbfgyOdsGUvqH/xIC5He5iOf2Vy9+Mt48oJaOqB?=
 =?us-ascii?Q?tfuW7hiBZKsi8OR8+bMUN6ioaFhx1yOI7ei74nOqLG8HaaEpsJjf4rjVXY2E?=
 =?us-ascii?Q?P9WGYELK+6dfeSJ8JZGFe44QfwgG8GRfbqYP8/T83QOxPd/+4iTdWRWswFAp?=
 =?us-ascii?Q?uUDUMwxL7ntaUN95siPOCfVbuD3LEiwe7/vTHJGb+rw8W9ICIWN8QcOYeFWB?=
 =?us-ascii?Q?Rh9PyrzPYGfECS9NDfOKmKRg5isUzYFQMCZs5OuuebUyE/BcOkDYErQ5tzxj?=
 =?us-ascii?Q?dtC9B0GpwJ0phkCMBnAYzrmT3b5LtDX5CT5kF90EsXio5XgkKVSQru4euhpC?=
 =?us-ascii?Q?V5drKi0oY19VtIqPDy3KFKknYk6AnR0uSLmaWTH6fQ7q9AO/uZHz4y/eMpyM?=
 =?us-ascii?Q?BxWzf96RFjpQNlfjdhW7mNTSB1SEyUHohlHYlMHKuQxEm7U5I9aO7yoSICyq?=
 =?us-ascii?Q?9GWQ9OQlO3o1LVT4b/BvmryRA42mh1iyZxmf2daZaEIrFbAFBWBsOBF6tbor?=
 =?us-ascii?Q?T9CtSW6164hS7U8raeQyIyYbuzAa7E8kgSay1izk+Mba6J3Bxh+H5V+BdSvJ?=
 =?us-ascii?Q?cYILsvGoUj05qlegoIhOu5PlY6o2WFHujVZCsgB5WJTIyeiUqSmYHfY6+98N?=
 =?us-ascii?Q?K+fOiwnfdXlffsnf6P2IwJlF+Mln?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 04:58:41.4074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df423d6-a2bc-43ec-2c9b-08dce755e11e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6122
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

USB host support on ZYNQMP KRIA SOM needs onboard USB
hub driver for handling reset GPIO and for i2c initialization
sequence.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Acked-by: Michal Simek <michal.simek@amd.com>
---
 configs/xilinx_zynqmp_kria_defconfig | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index 5a07edf5cd..4f0199f099 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -29,6 +29,11 @@ CONFIG_AHCI=y
 CONFIG_SYS_MEMTEST_START=0x00000000
 CONFIG_SYS_MEMTEST_END=0x00001000
 CONFIG_REMAKE_ELF=y
+CONFIG_EFI_SET_TIME=y
+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
+CONFIG_EFI_CAPSULE_ON_DISK=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
+CONFIG_EFI_HTTP_BOOT=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_LOAD_FIT=y
@@ -204,6 +209,7 @@ CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_ULPI_VIEWPORT=y
 CONFIG_USB_ULPI=y
+CONFIG_USB_ONBOARD_HUB=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
 CONFIG_USB_GADGET=y
@@ -223,8 +229,3 @@ CONFIG_VIRTIO_BLK=y
 CONFIG_PANIC_HANG=y
 CONFIG_TPM=y
 CONFIG_SPL_GZIP=y
-CONFIG_EFI_SET_TIME=y
-CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
-CONFIG_EFI_CAPSULE_ON_DISK=y
-CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
-CONFIG_EFI_HTTP_BOOT=y
-- 
2.17.1

