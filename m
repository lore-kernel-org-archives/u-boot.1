Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0619D6100C
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 12:00:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0324983F20;
	Thu, 29 Jan 2026 13:00:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="24Ba8QlL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A45083F4C; Thu, 29 Jan 2026 13:00:37 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDEBD83EF9
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 13:00:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.sanwal@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l2gmifaGi45nOxCgbMuX378pJAaWd5RBpsBCErBaWzc/h1uGf6Q5U39kavVLSnn5WmqxXFSwqGknmcZL9xYgDIzp6EMMANz6/wxihKtu4Gh6IH9P79NQOUjlLdjuU2fo6VPIYDa/V+1Qo+g7DjJ8yqIcNHWcUpmKg5ht3mzT/P3i9IKxqoBoIgjePQ4vC4EfGn+SXZriafPobv6E8p4Mqiw1CKsaD80/wBqki/StMmp/fif86qrJkLPceMOJJX8v9mYHnDOUWbQynJ6GAuSeacOkizjxjly1QfFATjx/CdZjp+fGGAhmF23qoRBEt/1j3xyN4StNp30fcB9BQcFs0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QH7NHhGxedhCir+2/xFZTTZRYfscmORnPZ+1jHJILK8=;
 b=jw/LGC0pbyp8Bip3BGl9Jc08ldp2lmBj/AGwb8+cPs8K7GQF6ms1P5ZY9Tjp/rys4GS0Uv5DB/ULrgESD89Os5dkAb1Zj49MCLgMQnJCCKPqLMXojuN2s2buHYEXoAQWFtD7Zp+r9kJVNmo4Y8KnHYrCwjWRDqgk+iawOwJwR7uihLm1welv5vtBPc5/A6apoCsYIRSBE7XqPud2QneGrM37OgUQJR9K+vZU/nHD3fpx69CeEgri86EMOtyeCl0vRxCl1qhQ8jQLMgx+3u1eTUizK6c2mHP4b7vSycuMeYHdxO+B7hjji9vg4OqBGhsgmmE3dR/nb9E7QTLFtpWHxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QH7NHhGxedhCir+2/xFZTTZRYfscmORnPZ+1jHJILK8=;
 b=24Ba8QlLozDqRooegovIJqmQ2e34A/3vbWUtuWZ3fMmp3//vr/bfmGYhvZT20Qc+1uxB/0MTJtrJZNqg2Z3djCljisnuCYf7Yd7YNDq01UloyaD6yGechLr2PFSBSsbuxDe2SM0HSsCVl37UBlQO8gfHjJ6YxLSG+xCCPW364sY=
Received: from BN0PR02CA0043.namprd02.prod.outlook.com (2603:10b6:408:e5::18)
 by DM3PR12MB9288.namprd12.prod.outlook.com (2603:10b6:0:4a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Thu, 29 Jan
 2026 12:00:31 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:408:e5:cafe::2f) by BN0PR02CA0043.outlook.office365.com
 (2603:10b6:408:e5::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.11 via Frontend Transport; Thu,
 29 Jan 2026 12:00:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 29 Jan 2026 12:00:31 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 29 Jan
 2026 06:00:30 -0600
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 29 Jan 2026 04:00:29 -0800
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH v5 0/2] Enable dynamic MMU page table sizing
Date: Thu, 29 Jan 2026 17:30:19 +0530
Message-ID: <20260129120021.1328653-1-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|DM3PR12MB9288:EE_
X-MS-Office365-Filtering-Correlation-Id: 459b5813-ccc7-4962-f63d-08de5f2e004b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9okh+gZhr8oZjDk3L67F/QAPM8lIzR3XgLgw8R+ZkIszbsydViEPu4JPzBj/?=
 =?us-ascii?Q?0y0psrd93Wd0whhjfGc0bptnc5Mu8oQavHa8dtK2fO+9WdKdmaChH0Lg+EGG?=
 =?us-ascii?Q?WdGsMtIk0XvnKi916YGHw5YDBbHbm6BvBdrNxGnO/j4deTh+SYZLjW2h1w2r?=
 =?us-ascii?Q?sZ0NIHXi1t2ljN+Y34recXg9cp/o7EXXjr3y6IwNnLq9HO9FqeWMuZJknVdI?=
 =?us-ascii?Q?5ZJTYNW8h+XEu9uOqZ+edTro73Kyrcqb8UQpo+V0kx1mFQ5UTMFDAKcwb+MI?=
 =?us-ascii?Q?O0kpFqoRVhsQAi7Mw8fjOvy6Wxm9Z6Ee17nlaBYYY5entTRdp28ThphLSFET?=
 =?us-ascii?Q?z822+CqSfsx8clCBEgE+Lpvtg0HYGoyPOoNGmyqLvsICbxWRqq4EUFQSUscR?=
 =?us-ascii?Q?aDb0XIpfNW5Q7Ye1Zo96EIKeho9+GcnBX+1q1LCh8YXqL+zVBCrzQdYYpl58?=
 =?us-ascii?Q?w1hVBqUX0cHkAF9lNGKCSllp876nY2ShYCgCvyhIY4O7gOe5GMOKx0O4I6Ze?=
 =?us-ascii?Q?c0aMC+yYMYerVQv/6NNFeIZTB6BTy0uL9+sAHsZx/5Yt3tAkOCPeX201HhKX?=
 =?us-ascii?Q?aLZIcH+g2zx0UnxsNcm5duApDahh9JEsrSReTWB0L2/6nlL+G/3gYB3tb2Re?=
 =?us-ascii?Q?LB3qkPVHxayKFXAWk55A6V9462g4ekfYi5mwPMFDOY41u72YSF8IFVMG9RCe?=
 =?us-ascii?Q?c/dGviOdtKNmGfZsgoES/OuZ2jy/dr+/CvXs3Kood/e8bGwGchkmOiK1PGvl?=
 =?us-ascii?Q?iSdnOhDxbliRjQDX3KHWkGXZsBgx8ZHndYYk52XGKwG69A1SD9Y79oXgJwBK?=
 =?us-ascii?Q?AiY5CdCGk5dz/useDd/P5ONn1tk4NxnY+ubRaoqsD+MBLn0L24sXb8pk7gHG?=
 =?us-ascii?Q?u0awXYVUBpz3NKzQq4pfXzCUup3GnI7U9wdT2KjUtW3Caf1fVgbaT+2mW1ni?=
 =?us-ascii?Q?TNI2sGeUJBeLk8OJVCBZ0ofAtx1TVmZWGW2+GcsICA23n6NAWoHQjzfoDj0r?=
 =?us-ascii?Q?URXtOLxzq79J8LOxer3+FO2WPmpui2P2vcReGXJlJOlk6aqnBbPnzHK0B5lD?=
 =?us-ascii?Q?JVlSJo3sWRiDBvQBMObSJU7RaZRSE8/i26eHv3M4LzqJbY0i+I1/DguwsZVB?=
 =?us-ascii?Q?tHHnhTAi6ov9clOEKyABWxhqSzF1buuNkAhdLuzLfJarKcxFZOGgCjgRsHGW?=
 =?us-ascii?Q?YUMi8g4bTGK6rMq33HAPkiVQarYW8395QW62WHCnKFwtn6bDA0ZgX1b3wVSY?=
 =?us-ascii?Q?2wPFke/Cv8x7oRh6lnBHYoMTf/ADzFzksdHqDEbqvAcXsHE55pAP9gjtC1LN?=
 =?us-ascii?Q?35dRMfjvOV6sG7KqNpHv3X9OXjr9Waa3H6b41PD84WNnxuZEyRKF7wvM9sQ9?=
 =?us-ascii?Q?hWhnXvwjrC5if2fB5vDrLOwDKA6Hzu01CJqk8aVsVkF+JgsUMEdLl/m7/o6/?=
 =?us-ascii?Q?F/Xepqx9nHOlRBKYfUpWc5/69M0PTO0z0wmr8nsXcsdfFEPzNeg9I8ASAeC4?=
 =?us-ascii?Q?k/VegYYxD4bvrKX59kR3bwY+g3PyYFj+usAul+eoa4i8vtGOFFlnu6WMlcbz?=
 =?us-ascii?Q?GZUBAgN13xu6n4cj9sSY8OrbkFC4EPu+A4aWMni8YGbEVLaQXHrUG00RedhZ?=
 =?us-ascii?Q?wdR+TLI6pmfioAF+mIPD2QBEVDpckyOtDkNQ079nmKVCSYJW0aDtlT2yzPLD?=
 =?us-ascii?Q?yPimpg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 12:00:31.0900 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 459b5813-ccc7-4962-f63d-08de5f2e004b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9288
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

This patch series fixes a boot sequence issue in AMD Versal Gen 2, where DRAM banks are populated too late during MMU initialization.
The fdtdec-based approach doesn't provide memory information early enough.

Changes in v5:
-Add fdtdec_ prefix to exported fdt api.
-Clean up DDR init logs.

Changes in v4:
-Better debug logs alignment.

Changes in v3:
-Fix DRAM base detection boundary condition (text >= bank_phys)

Changes in v2:
-Address boundary case where U-Boot is loaded at the  beginning of a memory region.
-Export get_next_memory_node() helper from fdtdec for reuse -Split previous monolithic patch into two focused patches -Add comprehensive documentation for new functions -Include proper header dependencies (dm/ofnode_decl.h)

Pranav Sanwal (2):
  fdtdec: Add declaration for get_next_memory_node() helper
  arm64: versal2: Populate DRAM banks before page table size calculation

 arch/arm/mach-versal2/cpu.c                   | 55 ++++++++++++--
 .../arm/mach-versal2/include/mach/sys_proto.h |  4 +-
 board/amd/versal2/board.c                     | 75 +++++++++++++++----
 include/fdtdec.h                              | 24 ++++++
 lib/fdtdec.c                                  |  7 +-
 5 files changed, 140 insertions(+), 25 deletions(-)

-- 
2.34.1

