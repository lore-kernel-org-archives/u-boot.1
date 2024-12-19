Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC57EE77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 14:51:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF9E98021D;
	Thu, 19 Dec 2024 15:51:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MfgwX1zC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CEF78022B; Thu, 19 Dec 2024 15:51:17 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::622])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B99B801F5
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 15:51:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/NgtEjIcGEALDzhs+t/ewuJ9nDa+B2lIteveYUQLwldPlPtQvQ4VNJzpbW1hMLVcQ+lIHMn9whfmHvDJeySeQPHxGhcjIfbQBoQhzHaa4IjPRc2xBoDyxqibQZAOw0QntK+sm8RIgnhvkZYxZB+cmMlJWtqtJ5O8wcjiOrmwYXcnBMZ5/uNV4Op26GnbpEWhuzsCrcLLGFmpWRQRobJ/7ecIZ7SOrocnuEwry3aASq0qO39FnK4Z4tMa/UZjrSFFsXinwMKei4Mg4RSGnFaHSpAeTZTwaKydJ857SJb9VvB4GhDEvnVgqTK6ziiiTuTwdRwzqXpgZuxzpgvu4miDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uyrGVv9fDITU/KaOKh6Us04zs8vP3W5cts26Bo3klqw=;
 b=Lm5Zo2rI6inGvfS7Z4fGk0iicxq6Ppm2sKXwnOW7mXRfIFU8c9DSEWxbAqEkJVi4jE3jIj6omZwQGYyHWVq7CZ05J0OWfeE/RFa+22sDXzmuMasbW3FDEwqWL1UAf2i1QtCm/L/o4qHO6VsPrBjARuKq4mWXZGB+cLuCPGNVqe1/2pK8PTyc40joXMUvvkzztjFdJl0RkUcdFG/lMHMUFQjX0lyEr7d1l6Mielqm+1NEgT+WhuOlTagQ2aiUybmCFg804qyoL82ewLPDj09BsGvtj81aKnsPqGb0pRqJ0CtNTTKtUhxy1e1XpftDHVs1ZssNiIB0OEtIK4kS7r2dbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyrGVv9fDITU/KaOKh6Us04zs8vP3W5cts26Bo3klqw=;
 b=MfgwX1zCLRCPwHU3YhI/WSoMWUwdlDCF8QTHQRo/2Ksz2hbWdX/ilnJh45ShJix/L+EXn1/8oQqQKvsgTbq2Y1IQmOwPm5o6NeNQYbMMjCwDwkw4xXABWuPG2NUUBafL/1rNXOISs/AwX0SHHhDLVnufma6n6oFRzfB6qMS3VZU=
Received: from SJ0P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::14)
 by IA0PR12MB7626.namprd12.prod.outlook.com (2603:10b6:208:438::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 14:51:09 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::dd) by SJ0P220CA0010.outlook.office365.com
 (2603:10b6:a03:41b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.24 via Frontend Transport; Thu,
 19 Dec 2024 14:51:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 19 Dec 2024 14:51:08 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Dec
 2024 08:51:06 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Dec
 2024 08:51:04 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 19 Dec 2024 08:51:03 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <sughosh.ganu@linaro.org>, <git@amd.com>
Subject: [PATCH] common: memtop: Fix the return type for find_ram_top
Date: Thu, 19 Dec 2024 20:20:51 +0530
Message-ID: <20241219145051.1735676-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|IA0PR12MB7626:EE_
X-MS-Office365-Filtering-Correlation-Id: 39442eb9-e461-4769-d908-08dd203c92b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JH5cd2eQlB7Z/VYimfWXvttnz6gMkCOcx4N7onfQ3/wQ6HzipNi5BipecA5r?=
 =?us-ascii?Q?oiKscfsD7HfAFBA1amCqiuqqV4u+VBmV3TrnuCDxci45WWumeBuCbNuuz5G/?=
 =?us-ascii?Q?5x6/1Tp8iZD0HYKPYHZQz31TjNIJz2FHLSIdiGkV1YAFTbydnjPL/TAw22W6?=
 =?us-ascii?Q?tiiooypT4CaQm6/udgRqnTMNKwlMejo9s3uT43gNVZI0EbCf9IVgo4ZNO+wz?=
 =?us-ascii?Q?HEcWAVr/7Gy0mZqkofNjzySGCdoABkvWiyOUbBQQoWwt/f03ovYbcL4PEvUg?=
 =?us-ascii?Q?DfTm79tPf97ipc4fSJRIotWWzApocbwwbDLGgN5RHyE3Qed+k7RVcKRiFkNr?=
 =?us-ascii?Q?LO4IOuZ0SYcSz6fRxMgNCCkuAmiK/DO5xNPqNQ5kR151mxceG8Vdul3hNWTI?=
 =?us-ascii?Q?zt2kSjH/SKqh826dtPQg3oVsN0tKnIsKU7fL3tk9dEGcpOdfpIrdUQ1vP3pU?=
 =?us-ascii?Q?TilXtgmfiJFBgZc3DnhvpRT8QipUUnqGETwRiWOGMKVT9vC26d7XhgxI1sk/?=
 =?us-ascii?Q?tuPqTmREt0QdCBCBypZ+ss+cpx51/BoXCBD3zi1/gk4oT18HXwGsFIx557DV?=
 =?us-ascii?Q?n6jyZvWo32mVwT6YwFEUt/ZkfHxu1fdR5W+bALhwwLHUAmOa62T9vtSyUC23?=
 =?us-ascii?Q?kWRnPh5z36WwDhuNbcJ5lm1G71BfHUZlzYrDtFRZ7S6fxGve5ZFKgSqvEC8R?=
 =?us-ascii?Q?+DjH48iRx/wBcFplgOZH81SzZa6aAGgDxQG/Mqxr5TrikpIRFLkJuOYTiNET?=
 =?us-ascii?Q?LhEmVO1r+VfzmuvlZga3gbr/IuzrL4TlAStqxGgtPVdx8eNgriHw9kKEhXuN?=
 =?us-ascii?Q?eb+1YKPvUNin3yDmGqLq/GvJVHRJj8+Pf09rZJ6olh2J4lTpTnlf15v+OgwU?=
 =?us-ascii?Q?76D5YC4x5jKsQ44rppb56ST6uUZQfVYO78hB/1F2ZvCAsW/+9QIc2FMx4TOZ?=
 =?us-ascii?Q?8LOxQaOJG9RKy2Uixm/+nrOwv89m+ub0FLhJNABfUHxOfoTvaIt99z1Zh1QE?=
 =?us-ascii?Q?mW3bfbe2Ek+nQHCAh1zyJNRGk0KvCoMIWDfixpZqIOQgJWCxtjDlIA/qHczr?=
 =?us-ascii?Q?CiOCk0V6FM4mzT6LqsYp7b4ZHRdXLdkdL0NFxvfWbuHdnp554vzyR4vJfCaO?=
 =?us-ascii?Q?A58twYkwjgl4kmCHJf199JfAIC0vXyrCkUNI/Edp6x5yrBe0Ro/kn0romk3s?=
 =?us-ascii?Q?VL0ChJTM5EmL485PJ17/ZCufbkc/xKpE4IoTliEken7VAi5hxiY1vpEfUupg?=
 =?us-ascii?Q?L8AA43p3YGH4PGikMReCzcMgpHQx+M+bx4EFf8Cj54h4NZbQxgJyZiVM15U9?=
 =?us-ascii?Q?c4jBlMBhNRfJ2xIzzc+xsYazk7/QobyTZE+aMZHYsRHpIJ994/+OhMe18d50?=
 =?us-ascii?Q?G1Vz1AbQpj4Z0ZQmgRPEGD3y+uriCmlUNWphBO1XPa5VaPKnX8TIdblqMQCm?=
 =?us-ascii?Q?vKrZ2Gh6H67bJa/aJ2tFerqPBPCeFhhNy6rtjfWIIpMdTS5qCAX/jcqUMnpG?=
 =?us-ascii?Q?3Dwnh2od4vb5d8c=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 14:51:08.6302 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39442eb9-e461-4769-d908-08dd203c92b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7626
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
---
 common/memtop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/memtop.c b/common/memtop.c
index 841d89e0799..114ba64067d 100644
--- a/common/memtop.c
+++ b/common/memtop.c
@@ -121,7 +121,7 @@ static long region_overlap_check(struct mem_region *mem_rgn, phys_addr_t base,
 	return (i < mem_rgn->count) ? i : -1;
 }
 
-static int find_ram_top(struct mem_region *free_mem,
+static phys_addr_t find_ram_top(struct mem_region *free_mem,
 			struct mem_region *reserved_mem, phys_size_t size)
 {
 	long i, rgn;
-- 
2.34.1

