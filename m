Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C4FC3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 07:37:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3814E831E0;
	Thu, 10 Apr 2025 09:37:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M1JJZyKt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C8C5839CA; Thu, 10 Apr 2025 09:37:43 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::60d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2ED7E830E4
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 09:37:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vuel0KLxiLtXNsy8u25BD8oU32RKg2SMmO0GJqHweWbJhOits9epFtUZpBru0ocVWok2HvZSXDV9P+mAu2isiHm+MKXyWLXMhEjl/hPsn0nBZVKyJGF7voPMjozNhA94s3J79iT92fWN5FAs2gPvJiugqEO/03qSKkFsQeZtLhTT9n2QjTaqAT7PIeaaTa8Svvut/090fOvPJvimpAHOL4XLbaCtRj4TRPqMCkGLwjbDwUsIY81AX4ko35UiOIb/jfo7nU9sKnHI3+P/YLIL3JXlFUcTRKGVSkM9qZCnqi7K0ioRarYGAugn2Uxjw+VQy37BwA6IKy1SkzG5T7WUJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ayn9zEh5jsNES6WAiUkesXxgPmaRo78O6SWaR1uA8U=;
 b=sP6IXcThVAPoUuImTMJI+uL67qh/Qm989omUuguqVI3zJTfOhtTglZ5dbQssV6meB5Qr3pOx1EiXMaM8BgkydznWzhbwCvXlZYJrjk2eCv4al4fJ5IRzErHSdWSm8NsKMqU2KQj8FIo4f+Pjn8KiRifzntuB/J+WZNAt5fsrASamQcYShqnaUQhZWjYBzCRncDI8NnmbTQfSr0zluc3TINPCazwLELbHYqObgPQmXxhD5U/g17+M+VQvLrjxs+T6PqWjb7syg5IDrn/HfUr87oDHtyFsuzLwPVnVWy058gfoXkZNq2XX8fxeGbQk8b8vyt+MvzooIIX7HiXCW3rIRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ayn9zEh5jsNES6WAiUkesXxgPmaRo78O6SWaR1uA8U=;
 b=M1JJZyKtkaHNKTH0ydrL5fB5u1+mzPeb5vo9SoJ2ghUCR9HqJ6p1M8ongDrXCRF6QXdvWlHoGpKav/2PazcWph1bpwArfKD+kjfDftxN3vPrIopub9P5VXHb14479//ezMzud7l5w33GzGPGgSKaUrUKqoyZ3N0Wix2hlmVQSWw=
Received: from DM6PR08CA0045.namprd08.prod.outlook.com (2603:10b6:5:1e0::19)
 by BY1PR12MB8447.namprd12.prod.outlook.com (2603:10b6:a03:525::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Thu, 10 Apr
 2025 07:37:36 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:1e0:cafe::2d) by DM6PR08CA0045.outlook.office365.com
 (2603:10b6:5:1e0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.23 via Frontend Transport; Thu,
 10 Apr 2025 07:37:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 07:37:35 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 02:37:33 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 10 Apr 2025 02:37:32 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Prasad Kummari <prasad.kummari@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH] amd: versal2: Enable NVMEM framework
Date: Thu, 10 Apr 2025 09:37:28 +0200
Message-ID: <b6714165aee393528812ddbfc3cd18a3bbcf202e.1744270647.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|BY1PR12MB8447:EE_
X-MS-Office365-Filtering-Correlation-Id: b40ed15d-8bb6-47a5-f5d6-08dd78029005
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hP+54WbEzHhSFOUukmT22awmo2UnnpJnCpR1SxtDC/xDQfx0oYNZHz85ldtD?=
 =?us-ascii?Q?GDohYu+X/HmTMcUPXcYgJRepNd3S9BewFL31S69p4lIN0SSxtjLXXGeVXt0h?=
 =?us-ascii?Q?xbSqPTCTOjZNrMCnrJdaVRxS+3MPcG79gKVxFhfEj4ypogAg4wIn8tE45MSe?=
 =?us-ascii?Q?WaZeVWnNt7umy1R78xEyRwD6RVqU8uzfgkp9M3ImLS7LdEuvJXAfns0CR5hM?=
 =?us-ascii?Q?PTXUNSSaTTh2phPqpU++7Fyp9mhDVA10i8TNUVHao6kleB2Pt3hKB3ncuJHA?=
 =?us-ascii?Q?asaOU3UIZas8U8PQ94uuV69nP0gjOAHAVsbgQ492qznVeHhWIYMKSMDD6Fkn?=
 =?us-ascii?Q?Ka3pfJ0uuLLwRoS2lZGQrNJoFWXweWmfyQZWFcfxUxZHWIEYqYL9ZoPyk6XU?=
 =?us-ascii?Q?wivk4EGJbIOurwNjfQFLSgVDYhpIDhFNNlFPoIapyxKEwUDpxBjBEk3c7Dpj?=
 =?us-ascii?Q?ENInsA3oU3AGdW3ci67nzWgsGjF2rdjwut0v7eLkHQJ6XRnCq+OE0f5tGh11?=
 =?us-ascii?Q?r5GMWtbR6F1XacGJRBnKIdGrV5ZISI5rNQkDizGjoe07FRPKl0Wpz2fg56TA?=
 =?us-ascii?Q?b0FaDQNBeXzsUtJjOogGmmAtzrdzyjMYr1l8WXiGdQrUswnSgz4RhxVwnqdE?=
 =?us-ascii?Q?bepdFtRV57bLUkrDL9isej1uy5lzTV0JybNU1X+X+XcdvHkFPKLf9KN8jmFD?=
 =?us-ascii?Q?urPA6MkFZHr0FN9fXlHy3tmsm87kzJ+/Szlawud0Fu4v766IAadN0yHMMk8o?=
 =?us-ascii?Q?8gxc3ESwedcIGmZBeMU8/26lo4x0TTcJx/aN+MJlnrgUTtaZXC0XMcXACQmO?=
 =?us-ascii?Q?fZS/T9JSBX1L1epzFxPXYC18bMeBcdz97IE7p4aAYt31v1Oxv2/4naH7SV8l?=
 =?us-ascii?Q?2uCmGXYiLRiYReUJBb1y/ERWSX/cjfu7K30Rr5BbuVJ9C7HGqGr+Kni923Ed?=
 =?us-ascii?Q?N18ALYDdWoSTXqesRqA9aUk1Ovk4bq2pvgEP50CJzWKgO6Vy3aogcjlP+JJ0?=
 =?us-ascii?Q?ehF3riQA+dSLRx6eNjoi2yVfLeXJFVnoWmqEWJGg67jG7fvJe43s5TjtaqCX?=
 =?us-ascii?Q?sNnCwuFsaIVNPx3sAqfhyGkWqGQXSq07K1vDOhtSC0Z/vJ8/dLGcBO51nXfS?=
 =?us-ascii?Q?VRBSqKpR1UgkVNWu8BTW6v+Vcn+d3oneJ1D6fwICW5Ds3GPwEWGMeaMpLOFQ?=
 =?us-ascii?Q?38h3+h0Hny/IrXeztCwy0QXK/wYFMgnd7zWrU5RO1zpI2mFA6rCPWdhURxHY?=
 =?us-ascii?Q?+/1xKXmlW2qomsW/CWTFsCZmUyImLkuuVYNXG0SBxF4OQLSbw8w957vYi1rM?=
 =?us-ascii?Q?MPQ8c1JY0cjMD7ezgPyalom4R/G/j/L6ANg9Ef5uQH89yMHSDMdNOw+GrlU7?=
 =?us-ascii?Q?PxmEsz9afVLua/DDmHNcgmuE6WVZvp9FKfnc/7S/hVz0FwZgLw8Qv/YoGJwN?=
 =?us-ascii?Q?S8FNOYeUYMZJzhGgUEkGoWQkt29kewzPuyIfcuy9b+Ua+6/YTHYyp0RLvs8E?=
 =?us-ascii?Q?ahJR4rUKaPhLPKSAGKo1lECsDq2dr1ODxeU9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 07:37:35.7118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b40ed15d-8bb6-47a5-f5d6-08dd78029005
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8447
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

Enable NVMEM framework to be able to for example read MAC address from
eeprom. For more information please look at commit 5db5b7e2a336 ("xilinx:
Enable NVMEM framework for all platforms").

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/amd_versal2_virt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index d722f3c811b4..5ae558e14198 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -82,6 +82,7 @@ CONFIG_I2C_MUX_PCA954x=y
 CONFIG_DM_MAILBOX=y
 CONFIG_ZYNQMP_IPI=y
 CONFIG_MISC=y
+CONFIG_NVMEM=y
 CONFIG_I2C_EEPROM=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_IO_VOLTAGE=y
-- 
2.43.0

