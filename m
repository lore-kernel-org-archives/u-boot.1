Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0084AD26D94
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 19:01:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB8C0843B6;
	Fri,  9 Jan 2026 20:01:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GZG2656z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8B42843C6; Fri,  9 Jan 2026 20:01:12 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazhn15011021.outbound.protection.outlook.com [52.102.137.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C380D843AD
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 20:00:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MfOu4zgm+mlFygt3fZAIdRJ4dpGM9BE6ln3nc/iBJmVkH0Efet7ZAXyBcv5KRGpVGdKctWVg3Kg8MJrWYTl7MUbxJRVEyL6UpDsc84YKyeg7YhCkUvaKMDa9hqqPWoynHiuxTh9I7ApoiHRzN0vl5WlpRtzEN3KKQO6wVMPjhA0PQjbLQn09/BJzHp9wIBXVW53LOfTj5Zfa27710+ByiUTlJn0gmW8MxsbDt0LM9wRMT+JGQkSPSevoqEhg87WnCkyUADmLC+hLAHxvba75yx3YcghOm4Qkpfj2IHfj/srFv7qHslQzf9jC4M6web1VstSMtnEOCW1/mbc1fDV+ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hMOZBLe9rlrZ6ZK30tptACe4kyKP9a4dk78tAS86kE=;
 b=D2pHqpB2gQ02ToejmSXZzgUnwKX/dYlubLpaAQ/LDYdnOSdsMeqCRRt9Bk2vHSPQGUfTLu060K6pMO4/cpH/vMTNnMHFa304c+8TwvgWfsNRw/lBKU/QhMJ9BoeZGcCy++fmx6hP4YKsp2DoAQt3jdr3IPWa83Z9DIiiyaoEZLwKAha9ISVI2EXBW6SAFtRJPtCsL1Xbblp/X06pq0rCrTU35We5uwUD8d/TezrQpZIq/90RC1u8XmIfVwyBEAV5CJrn6QK1vfLJaQy2CUke4ZhZaCZHMJvM2V4kLmZ4atu4XxXGAJYLZlZNXOcmYiGBqxexkBtjpWW21kmAbqMCjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hMOZBLe9rlrZ6ZK30tptACe4kyKP9a4dk78tAS86kE=;
 b=GZG2656z1w+klll2HQzzaIWv8xzh1jsfOzyOi5NRNMf97J9f/d4FlTS81nFvHJ39y8utmKxpEG0Rr2Z4D27sO9kXdWqXhnFvpddxLnNOj595H3dmW5uj6Tx2LgNB3hbKtFLP/ZZq+rC4LL4bqE5Wznxkf0/mUYIOEsZpyMIk4m8=
Received: from PH7P223CA0011.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::17)
 by CYXPR10MB7949.namprd10.prod.outlook.com (2603:10b6:930:e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Fri, 9 Jan
 2026 19:00:46 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:510:338:cafe::26) by PH7P223CA0011.outlook.office365.com
 (2603:10b6:510:338::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.5 via Frontend Transport; Fri, 9
 Jan 2026 19:00:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Fri, 9 Jan 2026 19:00:45 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 9 Jan
 2026 13:00:41 -0600
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 9 Jan
 2026 13:00:41 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 9 Jan 2026 13:00:41 -0600
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 609J0QpD518987;
 Fri, 9 Jan 2026 13:00:37 -0600
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <ilias.apalodimas@linaro.org>, <malysagreg@gmail.com>,
 <sughosh.ganu@linaro.org>, <philip.molloy@analog.com>,
 <marek.vasut+renesas@mailbox.org>, <james.hilliard1@gmail.com>,
 <anshuld@ti.com>, <afd@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <n-francis@ti.com>, <u-kumar1@ti.com>, <b-padhi@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 2/2] ARM: OMAP2+: Pad SPL binary to 8-byte alignment before DTB
Date: Sat, 10 Jan 2026 00:30:26 +0530
Message-ID: <20260109190026.58464-3-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260109190026.58464-1-b-padhi@ti.com>
References: <20260109190026.58464-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|CYXPR10MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f7525b4-3003-4045-aa05-08de4fb16544
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|34020700016|36860700013|82310400026|1800799024|12100799066;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3JcEzOtTKSJbq3atfdVIaV9rwYjzn9wpyOrVTAVIyrJo6K39yECmUPc0dYYk?=
 =?us-ascii?Q?R1zoBFZo0NMfO8FkgaKZOT12G6CMfNOCFiMc8fjE6mJ/2CQRD6W8LIADhsOl?=
 =?us-ascii?Q?srOLlBv4K8hZBfJNof7Htlvp3XtGcKlKcWgUhtixLtC7/0UGizQbQ83V8Pfn?=
 =?us-ascii?Q?aGu+BGPShF3tXs1MWmt0Njqc3pr9EvrS0qTV0yy9+c2uhOHweW2NnUCDJJfb?=
 =?us-ascii?Q?W+k60fBmnWlX7Bm3p3N44Cn//Gi0DMMByoJ5gNn5mdmi988lSZFi9iGA4BLm?=
 =?us-ascii?Q?lTH9NrR1PoN27purh6DmyG6R7dmgLYL4MIBNl6y3SXXLCaVjcptI762O8hvq?=
 =?us-ascii?Q?iTgOA8tS0WX+RFkLZQLlVw5N4gewRJw5XHb7ssJavd5Sd3lV7qhWaGYWIolo?=
 =?us-ascii?Q?cFO0r6mJ9+F8iG99H1/qp36zrAIPMAGAROQl9XNUbmINVtEfhghGpi7eIAiB?=
 =?us-ascii?Q?vYLFoafbTx2xlBc189QcGYfTAvfa79GyPDkjRj2yhuzeF73d5hIDwGGh0RuW?=
 =?us-ascii?Q?pXtxRSVZYIcRtYBTAUrtgwaTZH1cTcy6HEn+U5vPQJMmQ81wKzfQfDgtHelY?=
 =?us-ascii?Q?23IgQHGFmsbygvholC0TakemV0zbA482DAKy4ligs9dKgRE0F99Vdats1NFi?=
 =?us-ascii?Q?Obi/9Xk8GXZ/hNGowBFfB05FyRVy0xgDEq2AC12wXOROTCQqj9W6enABARvf?=
 =?us-ascii?Q?9V3Beu6G5up25r29ZZ99brdvTV/jEspCzMzkesJBjZE92Gqa8JA00a2jdfo+?=
 =?us-ascii?Q?kM4HyPkUa7Qb+eFu1hGroWstwhyGHmXsSbvJgKr1orbnYP5E7qEAIbe8U7bZ?=
 =?us-ascii?Q?8Rs6YAIC7h1wTDeVngH+qlPITZdS+AK352WmonWxd7h3Gz8Kj31RK1Gx1k+q?=
 =?us-ascii?Q?XqRbUl0Q5Pwl+BrdppSBGR4s9fC5CvxiD9kZkpcpi1l769JWwa0FCTyAhG4y?=
 =?us-ascii?Q?usQeh+yY/st1DpfhqgolCOa/pyVNAMRItteH6OpTNZp2sUCGuGnP7jvJp+i+?=
 =?us-ascii?Q?qQajaEMY4qUP9uyXz7oQ97Q0Awy6vHHSKqTbxYY4EX8vDV8tQpbnpzTxC6Au?=
 =?us-ascii?Q?QNTRxqFM/5ZDmVF6deCw0ImXhyt8/5oFxznyicy05N9djOtk8RsNIHNj845J?=
 =?us-ascii?Q?SHqqdUshR0EVtJa1Ai+ru1VWmnuYblm55tX1cx/5/w7CG2tUrmbjAjCAn5Mh?=
 =?us-ascii?Q?QZA7PRvgmoQRzEr6tNiWud4jf5tHHbtzJTMQ0SdzIzvTkz/8/uowWcXQhJMr?=
 =?us-ascii?Q?WK45P0f6l069o2ob5iQsGrnMBnC0qErAi/MPaTi3ARY5vqmso/u+Izokw1Rl?=
 =?us-ascii?Q?1yDkSD10n4d5cT3b2QGfD3XcYMQsAoZ/nolqqqpFhz5I+uuWvJNlPu9N5OY3?=
 =?us-ascii?Q?GIR8ftD9EKTa00fa4QD4M3Bnjp7pzRd9DsSs4j2x9LriaS4fhUwD5vaf0D1/?=
 =?us-ascii?Q?CkTqLGxvEoggi2MWXGH4FoKZIb5nmAE/EG7k8br15PA930b2OR3vr7uRVIdo?=
 =?us-ascii?Q?vLvCStkL1Nf5CLNHMG5t/O+Cv+M+bNTN/wEqMoy0RUH++gGW0Ebx214PNecY?=
 =?us-ascii?Q?Yvnh1N2ZNk7/XsisjzY=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(34020700016)(36860700013)(82310400026)(1800799024)(12100799066);
 DIR:OUT; SFP:1501; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 19:00:45.9368 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7525b4-3003-4045-aa05-08de4fb16544
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7949
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

The OMAP2 SPL linker script (also used for K3 platforms) currently uses
4-byte alignment after the __u_boot_list section. Change this to 8-byte
alignment to meet the device tree specification requirement for DTB
alignment.

However, this alignment directive only advances the location counter
without padding the actual binary output. When objcopy extracts
u-boot-spl-nodtb.bin, it includes only actual data, stopping at the last
byte of __u_boot_list (e.g., 0x41c359fc), not the aligned address (e.g.,
0x41c35a00). When the FIT image containing device trees is concatenated
to the above SPL binary, it gets appended at the unaligned file size,
causing libfdt validation failure.

To fix this, add an alignment directive inside the __u_boot_list section
itself. This forces the linker to include padding as part of the section
data, ensuring objcopy includes the padding bytes in the binary and the
appended FIT image starts at an 8-byte aligned boundary.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
 arch/arm/mach-omap2/u-boot-spl.lds | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/u-boot-spl.lds b/arch/arm/mach-omap2/u-boot-spl.lds
index 3bb759d8a1c..081323e6599 100644
--- a/arch/arm/mach-omap2/u-boot-spl.lds
+++ b/arch/arm/mach-omap2/u-boot-spl.lds
@@ -35,9 +35,10 @@ SECTIONS
 	. = ALIGN(4);
 	__u_boot_list : {
 		KEEP(*(SORT(__u_boot_list*)));
+		. = ALIGN(8);
 	} >.sram
 
-	. = ALIGN(4);
+	. = ALIGN(8);
 	__image_copy_end = .;
 	_end = .;
 	_image_binary_end = .;
-- 
2.34.1

