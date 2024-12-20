Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C1A5E77184
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 03:08:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2DC58021D;
	Fri, 20 Dec 2024 04:08:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U8JsZKOX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F31D80291; Fri, 20 Dec 2024 04:08:48 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::608])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE7288021A
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 04:08:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iw+8gMjzHo9meoQ2QC9UG20KZr+dWXIsGIYUbOKQR3eE6ADv9AiyVPyHmH2sHl7cc8NwtKk3o+HoWcLxgIV7JPeOhfSuxUSPo1MzTtbF1Qc/FtwatM843CJECiRi5Kubt+c5ZFnHh0mJfbTbI9Ymi4VSHG4qV0YS4Vo9FTINdtlMrKjQI0ZJ3/6BBTnax5LU/u8T2yypoJgoIQNcwooWKz1N9Ny/cjk8rxM12FSXmA6OqYMoV8E7sM0MeuMuYhWTG4LbPfElfWtVFOqLh8DOPQOFwvssZDjCo10jC2LYRwPBkmBIT0+pk3mAL7WoUqJyIAEfk7mCPgu596TzoODBAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/n3Zv3DSe0xYNjjYhcfxuWHIhZ3luUH0w40VuWs19tA=;
 b=xJy6mv2ZH3D3cqNGMJuv6NO0qR6fa/6+KmrQ0l93kEMQcvJ2M1lp+/x58X8kpW3BMkointHDzEtxQLHeiSW0R2TSJftbS8JOuVGwOLUlXl5rWaspjKi5p9J6Q5GF0laiKpEHz1CGmeJXuq0tXI2/BROJWFzzFQbyx9NMdWehQqo5eyss44PGt6JPqj587l/E+Afe611vQKr5TgdwVPXkopE5pkHH9TWMI/kOnQ4MJSEN4clkNT1rCIoAYh7XjwqxsL408OOSzPkbfDbSB5Wr0WYPKRnr2cxQzssaumylBkU4zR4t2OQlyNx1UHYeMF85/L09mm1oimnbNxmelGfOeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/n3Zv3DSe0xYNjjYhcfxuWHIhZ3luUH0w40VuWs19tA=;
 b=U8JsZKOX52pWNPPvNejfAB8WgvmwDwZ4EpIiT5qIaLvyfMcw6ge2MwQhnbCGwOBHbiZVZAT0jJ4gHkO7Jsmy/C7cgpmD0AVmw6R1lFbNCfCJGSRcf84VZSosRsLXpLOgR8Zh4yGgyul5NYNOAp+QbHbyvNOz01PE3dnLTmx29vY=
Received: from SJ0PR03CA0364.namprd03.prod.outlook.com (2603:10b6:a03:3a1::9)
 by CH3PR12MB9169.namprd12.prod.outlook.com (2603:10b6:610:1a0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 03:08:42 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::36) by SJ0PR03CA0364.outlook.office365.com
 (2603:10b6:a03:3a1::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.23 via Frontend Transport; Fri,
 20 Dec 2024 03:08:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 20 Dec 2024 03:08:41 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Dec
 2024 21:07:53 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Dec
 2024 21:07:50 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 19 Dec 2024 21:07:49 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <sughosh.ganu@linaro.org>, <git@amd.com>
Subject: [PATCH v2] common: memtop: Fix the return type for find_ram_top
Date: Fri, 20 Dec 2024 08:37:42 +0530
Message-ID: <20241220030742.1745984-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|CH3PR12MB9169:EE_
X-MS-Office365-Filtering-Correlation-Id: d1f87a37-f2a4-4635-e94b-08dd20a39b4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?thViI8KcU6brKMuo1abHBaDla1qcN2I/u0ZggFCzLR0pdrNlpVI7ZLLEdiwD?=
 =?us-ascii?Q?0QBfWRYRD53iyXhliL40KvdjZnuT4885TCAnv+Zr4Td2Iavb/QeiUd8itqEg?=
 =?us-ascii?Q?6hL0x7a9+LLrGPduSUMa5mQSxzZ7TNp0C+twk/0GBP5XZ7h+PvaGFhvTAp1h?=
 =?us-ascii?Q?VIVkvnhJny4F4h6V3XAeEt2yts+sr6+xOWRhRaJEUSsiRNRhnIpN+uI4iKyg?=
 =?us-ascii?Q?XjlY+i6jtLnV1dh1xin5PbXnRW3cJEZGfnUMuaqrABzct9+M/w9E62dt9j5A?=
 =?us-ascii?Q?vQ8LIFlVPm0K+O+mT4yVcVdkf2qkrSjbNmMq3dfy5mdS1BYbkcmMTVf3yn2f?=
 =?us-ascii?Q?yWNvXQFStMgTm1ZFpcqETbB1RkwGN3fIFVK/2x7MMJL6BHlwHkw+FutH2dJC?=
 =?us-ascii?Q?wO081HM1JPN992T4S+wE5soGu6ho7tvSdaaaiaTaJ2FM/b8cYoyefsw4sQjc?=
 =?us-ascii?Q?/Os6EhtJHr3SOdXa+GQ46K3IxsqN5pxMF6hEPjUxeSmF/tYykl7SwE+M3093?=
 =?us-ascii?Q?rGPekr3YfJDZW7cw9xzhQPLsgMhBlhxYXrWkclAiyHjabcDtL1RGubrGwrkM?=
 =?us-ascii?Q?vTtIxR8r+iIqgm+O9PVxftDMQUs3AldhZG5mPjhLv1WFQj0I8R615BVAJ9o4?=
 =?us-ascii?Q?MuKaAus3x2zBNVmqYyUMSCryNGQ5+ebSMjHK7zP8BUA6q6ILyOt7cBKZhV9V?=
 =?us-ascii?Q?LGYvz4y3pQXx71qi/OHbVfcjyuFN/9xPoOLYwczPdNhQD+djNrIMq5bj94AZ?=
 =?us-ascii?Q?JjkL9SgWbw56XEQesdHRhnuDaZXEnV65q+50RIcxaLZXkfrAufr4WEWR2NWY?=
 =?us-ascii?Q?mJbntjp8cZnOlO8ppUpm3Y5qImUKxjrs5qY79xNEGpA41ZrgQebhMRtZhMMl?=
 =?us-ascii?Q?fcc4qhgS3b2LgZcACtuTXEre5hPGLubfA1uJ/HUUCzEbBX2mLvA09HnYzHjC?=
 =?us-ascii?Q?gBmhmPIwbCXJ69PKqZC4MDkHCTzYzQKfm2iwKSXu0NN1sdcro7osvtjChPzD?=
 =?us-ascii?Q?to2LPBe6LjTRDN2ZK2LM8PwiewyydNyGrX4WQdPEC7lOAENfZJXN+r0HnvN/?=
 =?us-ascii?Q?oR2iKDIaerzg2QbWui3yicoGdplGp01t96GEa4fRvaz7ZvksHmm39GizsVG/?=
 =?us-ascii?Q?DbKXqyv/5H9oHeSACub+c1xmqdKD/5ZqXZ0A3BC5neM+n94pVO38b2SVwMAB?=
 =?us-ascii?Q?8jio8hHbKD7v1vTyNJh9IOZsf6yVPs0SXcoixuVfawxjwyeQIXLd6LKHKptd?=
 =?us-ascii?Q?5c3krqRp31utLkB/LKoWzViZEGWncz0ADnYdwjTw2LFlUs3ZuU9Pzz9JasJk?=
 =?us-ascii?Q?gzjndoSZxOktGgJKoViodtLt4Xaqhs4ASdy417nc782TqQvgNdlhYX4U63b2?=
 =?us-ascii?Q?9NvhMCtF4KvxZUCOzJNnpge4DDmC9G8cMAT1jt/WDHIB7POLezN/R+5qaVjD?=
 =?us-ascii?Q?AkNw+DCUaAPK4IlI2llJZcCwFSaX3SQuC++xH/bSAOHLyyEBSajA4K8Y6I20?=
 =?us-ascii?Q?XRch3+wgGmWLNaM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 03:08:41.2742 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f87a37-f2a4-4635-e94b-08dd20a39b4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9169
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

As the return type is "int" for find_ram_top() function and
returning the "base" which is of phys_addr_t is breaking when the
"base" address is 64-bit. So fix this by updating the return type as
phys_addr_t.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Reviewed-by: Michal Simek <michal.simek@amd.com>
---
Changes in v2:
- Fixed the check patch warning.
---
 common/memtop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/memtop.c b/common/memtop.c
index 841d89e0799..bff27d8211e 100644
--- a/common/memtop.c
+++ b/common/memtop.c
@@ -121,8 +121,8 @@ static long region_overlap_check(struct mem_region *mem_rgn, phys_addr_t base,
 	return (i < mem_rgn->count) ? i : -1;
 }
 
-static int find_ram_top(struct mem_region *free_mem,
-			struct mem_region *reserved_mem, phys_size_t size)
+static phys_addr_t find_ram_top(struct mem_region *free_mem,
+				struct mem_region *reserved_mem, phys_size_t size)
 {
 	long i, rgn;
 	phys_addr_t base = 0;
-- 
2.34.1

