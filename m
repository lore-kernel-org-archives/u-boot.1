Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF839D74978
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 06:44:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47875891E1;
	Wed, 30 Oct 2024 07:44:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iRQNBw26";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 378BB89212; Wed, 30 Oct 2024 07:44:51 +0100 (CET)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::611])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D21F891E1
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 07:44:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nnlwotCqztyKmDPRpf6N5TaD9J6zN1R4+b5Elkb565I8XVGI5dWixqx+DkM0v9Ggdz+AXN8YyRikpMuogroZmWvxzVhv6C+TiZQweIObEO3hZ18J+i3IZCgNMRoSC0XPXaosyyTChQL+9/pKlIvS2Yj/apqnxA1XMRvgxy2lhOrFKv3vlwEn48qRIolBcYDmKDwbwiV/6PP2lsWB/NGQBfzFNR5YnBn8BUp7ag50ix0x+WQaj6mko4cpoVnhnxLeSS6WZ3d7AYnVd0jRtGrKL7OpC/le6jfugpxesNJtfhYuDsYASGb+86hhHjTi721IDak+rEc75qnlofeBdqJPKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FC8GqTYwYTqTbtYBxO04t9JHkZG1x95PgiWMoZpynk=;
 b=SgXyHuuAPg8BOp84rm70TGIqxAdtAJAGoymDg/fc6iOpIS9liOwjLkpUcEUs1rLheD/03jV2yVSuG9dIwas0cXe9KoF6+jaQh9ZzxdnQI4CM81S1ZaTbq6uQ473z00qutyLMYdI24VNcTDSWp8b8CIqs+UNJh9BjQSSeEovydX+d7Jy9HLRKVFyDgcc9cNpHqGKN7mi3Lus4jRM+yf+mTeesXXpLDs7SKggZQy4xpK6FkLAuO4KkF0zkx8AEm7NEVBxMLkt+NX0bPtli8VhhmajZ6bGqoz3B/R3ubE0XIXxjXHYROlFfTf2TsR5V/UufXL6TIJk0wBBe0ZgEyJx/Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FC8GqTYwYTqTbtYBxO04t9JHkZG1x95PgiWMoZpynk=;
 b=iRQNBw26fDR2CLLf/wSjLQZnFXkYm8PE0owc1YIS1+FGPkfGKLVUGjPI+m6eyQpb1q55jqbFBP0Eur+dkXmD83KvObUzo8lR4I36kiUKMEPO0tX1co9+xqckXSP9cC77RIGfKh5TX741EIILdHoOwN1ZzJ8GGvGd2R9/9nixisU=
Received: from BL0PR02CA0049.namprd02.prod.outlook.com (2603:10b6:207:3d::26)
 by BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Wed, 30 Oct
 2024 06:44:40 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:207:3d:cafe::cf) by BL0PR02CA0049.outlook.office365.com
 (2603:10b6:207:3d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Wed, 30 Oct 2024 06:44:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 06:44:39 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 01:44:00 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 01:43:34 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 30 Oct 2024 01:43:32 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v9 6/7] configs: zynqmp_kria: Enable the USB onboard hub
Date: Wed, 30 Oct 2024 12:13:13 +0530
Message-ID: <20241030064314.28604-7-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241030064314.28604-1-venkatesh.abbarapu@amd.com>
References: <20241030064314.28604-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|BY5PR12MB4307:EE_
X-MS-Office365-Filtering-Correlation-Id: 912d4cff-5f43-4f79-7680-08dcf8ae541e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oTMU9vmrlDER84jx4mxJfrFrWFH/drih/PQznw8SE27Qp+ezYkYouHWTrNcM?=
 =?us-ascii?Q?ndzq6+VJynFn3Ku1QPx2eF97KbUcKXupRvatzF81rngYOneycip7mSSqfI/+?=
 =?us-ascii?Q?2CdK8mNNWY8H7dgZ9FCqhdj3VhHQnIgXX6uGKxodBVEzVDC+7ikdZp7cj5Sq?=
 =?us-ascii?Q?evQkl+Ry9hwjz5w6SGWf1U0JRVEcNVzGmwx9gw2fdx5RP7I8F3s3WZ1HvmoZ?=
 =?us-ascii?Q?ZEdfi3zzjJvYw3xDrb9L62Cl1wGpq6A9X0OxowYeNR3OyH4GWQbKqlDctq6v?=
 =?us-ascii?Q?vvTw5/uQ2WnFo6OmgThtQmy1akgJxPkiCqj1nPHyLVQWbZLsiW80xYSACRTy?=
 =?us-ascii?Q?rcYUwFM9ItWhDv6usX38bxqCRu5bY73btw7Jeq4GMUrfjzwQKaxbT58I4dnZ?=
 =?us-ascii?Q?UKHQ8OJYtQIoYbxzpdoItc1uUEmaU7f01ADifZKmPHDTu5z3qbTTxoJ/uGBV?=
 =?us-ascii?Q?atIy2sV9kp+67MhhR/6pry4zgTYLstcSsnGbyiVPaexER5yXq//lpgrXkTsE?=
 =?us-ascii?Q?r2v7bcgvQ9HrzJloeCi0IHCmG0ujLO3c4+vXSn2KmsqMTUzE8Pm7cHaO427g?=
 =?us-ascii?Q?+0XAU4W5yMOeKbvRXzWqkpUf0esdWiq8r+loQerBg+6GSy0jRffqsaNsgH3C?=
 =?us-ascii?Q?CyFmKUU6jCYlgjTgClntmuK8E3TD0zi3CB8WJ6PvrhLodKiwkcsPKCH1I9nl?=
 =?us-ascii?Q?yFM14sVABcaaxkYLGKVJCkxb9zzNkx1nd5MReV5HkwlzRqHZhVMlPrnlLOeV?=
 =?us-ascii?Q?5kB2P2tbgmoLe2UT97Vprpz5o+pwsmHxjsHh75kEctLkdxudv4Uco5sKucfF?=
 =?us-ascii?Q?LJtamhIYPfQHhWjrStYPTQwP4Y9OcFu5B/9YVlANFh02hH3jj1zmtshwZD5H?=
 =?us-ascii?Q?3dJiWhpf/ckiJPbpvWaN2rWMQ9DUCKOZBLCcTgJRca0+DlQ6QJhdjiNXLLsR?=
 =?us-ascii?Q?Booe8RFiOLu0ALIFQ1w1KwdlAj9oRZmePfvdna5Thl0DBHYJDZcz4y44+NmG?=
 =?us-ascii?Q?lU5ycO1rALax/HJJndLIRDczEPb32M1zYYRFEcLKWw8raeTLCjQEt4cCobfG?=
 =?us-ascii?Q?S96tW6JeHL1EntG+noKgOcweUuyeWSghNDZ6AQLdxGJkT6qCvoeoXqUfFS9X?=
 =?us-ascii?Q?EtLuc/PTX41sRThGfBZTv4jg/qcrOG9VbDzPBPRyouxkrDS4ZjryE2nkYggv?=
 =?us-ascii?Q?/i0nct76CTq3ZI+87F1pCCXIs+leUkE4dEogF8IY8fj7ZP3wnNhMY7lrR+1A?=
 =?us-ascii?Q?s3oGg7H4VP+5iL2sIRDWrfdKWa+4U3v5xRAq4MUSpNLDPFL43b8IDkNI4j2z?=
 =?us-ascii?Q?SgKdxmS/CRRy859Ef2Xd/phLvO2HRuLRGCrWUFijhCJMzrKzE7/gwKTh2il9?=
 =?us-ascii?Q?hBaeAhFIChAayp50QfrgHFsnPNz/EQtfeW2fjBLeMUgUBBdzWg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 06:44:39.8423 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 912d4cff-5f43-4f79-7680-08dcf8ae541e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4307
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

