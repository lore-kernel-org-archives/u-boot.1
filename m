Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC229C3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 14:13:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B92082905;
	Tue,  6 May 2025 16:13:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="eWewn9Hc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3904F800C1; Tue,  6 May 2025 16:13:44 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::604])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCA5282A36
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 16:13:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JdLR+iub1DOvz8zomzRkaatHvB5T4Ha8AKOWXjor2IF54yQkKHwktXxqWQNKIj38rgk5N7d78/KydyYELzOJSpEh/H+wOfvx6njBdmxTROn47ko5P2U6D4vreyRA5jgRJseApoeiGqyb4S8nvQGtbFX3BuCKTThW2kZzZdnb5tYhWmOZGQUNcOJ2ZAb3DQivxNHjeDq70Kbngv5XX8nhAQj+o0rYVpIRYks0dVxm/SuNJV5pZMAMnqA9uxJApXzLlpnfPpvo29jM5Fu9hNH/EO9G+w/KQ/2mz0evMxvbDncN5EKzr0DnZNtmcGCVG1PLNEXRkxY1GYBNQ2HCD3KslQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuNBHVPlhQ5KS2+9dnwYR71nN3fZixCPUwOD86QFXyM=;
 b=vxdljf3dhRPgq8X8qu9Zd1G4abCFvNxhYNHKUwlB+RBFULfTKJm0z2UtzmLB+7eHuiYvjSCSQhFXlh2qJDQGT7KvnP7SXZ/hBc0AIfRCJV+dYp6XG2IAAEwlc6yJLpd2xkdB6VXLgBwkfp3jC8c4VddCR0UmdK/+gfKjVS+3eRk1dCLOJjLjGML9i+xI8pDl7BJhuLPiFxQAr5k93c9ti5lDVVSsbnYKlS0sXiUKfdPcF+W/jSpfNifwNCkamBYqfAh1FIJIkp+dBC2QE2FK9S3xNGa9GInVXLlZcZ/3zBuTzHKGXA4ImKUUFSe0z6F02C+2jp/OJi1K0c+N92BULg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuNBHVPlhQ5KS2+9dnwYR71nN3fZixCPUwOD86QFXyM=;
 b=eWewn9HcEMhVVZ6fvltpYnV1wVi9a1lRoEL9KNEccpRPq6rt1lCz1axC/dBrQSnImHDIPe9+uCVgDq80oJDC0vbG44Ph4BBbe6qVlK0KQi9BAh0WAdq+mOCUUctM75lKWOnkRnCQQ33QzQBDPsXevlMuQhqg5VIpjRirycHfc48dwPr1peZRR6AgpdxpltdjbmBWoPFFKsHDtmMa5Nj7HzbiYXgobGj7XntQ7AWfhKbsnuF+bt2GlaFplJ/h3Q1bv7SQPket5U+QEoxqkESYnhWWuNe4NjW3kUxnO7D4TwkEOBljwfJNBUvR/GSJju/vVWn4wfpk16NbLVyI+e3BXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB4646.namprd03.prod.outlook.com (2603:10b6:a03:133::26)
 by CH5PR03MB7934.namprd03.prod.outlook.com (2603:10b6:610:215::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Tue, 6 May
 2025 14:13:35 +0000
Received: from BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce]) by BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce%4]) with mapi id 15.20.8678.025; Tue, 6 May 2025
 14:13:35 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Tingting Meng <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH 5/5] drivers: ddr: altera: Add ECC scrubbing with Dcache
 enabled
Date: Tue,  6 May 2025 07:12:46 -0700
Message-Id: <20250506141246.6672-6-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250506141246.6672-1-nareshkumar.ravulapalli@altera.com>
References: <20250506141246.6672-1-nareshkumar.ravulapalli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0069.namprd03.prod.outlook.com
 (2603:10b6:a03:331::14) To BYAPR03MB4646.namprd03.prod.outlook.com
 (2603:10b6:a03:133::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB4646:EE_|CH5PR03MB7934:EE_
X-MS-Office365-Filtering-Correlation-Id: ea9b66e3-d73d-40aa-e2a1-08dd8ca830a5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kemlMbTDAbpLNl/tuk91eJlJ3Amxo8C24dNd95EFO6Q6e6VISDhnrP1JmpDx?=
 =?us-ascii?Q?1uHOEZKUZFqBiPRfdeu+9Y5w20AUJ1d2OInEHIKMkp/w8obGIciLo4BpsBlv?=
 =?us-ascii?Q?ed/bjoyBlQaKJUxrL2LK7G8BdjawCJEZn7CP/A7BRHAsmj9PJRAjg3RVu5hR?=
 =?us-ascii?Q?Dca2fF9ua1LL2RtXXA+VZnUswP1oKdqkwPO4VFSj9j9GnDPh0bfLl3mOKCYR?=
 =?us-ascii?Q?ECOCDGzffDDatFZBYQOCHoYWxFb/9JPcPcQr5gjjRia47uKQ0eYbVkqEqTBG?=
 =?us-ascii?Q?oqLgk3dYkbCETv+9E3PbyV0AjG2yr7H+C31VUTC6bq3eVEUOYLBRBleWdR/j?=
 =?us-ascii?Q?GxpOtE4TBP3UUhHxh9KCqUZatUpLHPeHePf0g8cdXxegWpbNYihV2XD2VXLY?=
 =?us-ascii?Q?M70BBAuz2jqD1B21pDp4rLxUAV/jMIEewCNzaL2M9hoJrwSOF0j2TBaeNXn/?=
 =?us-ascii?Q?DPL/foJ7WP0nWl1JX1Y7LIH+54u7/Kvqa3u3mT1M1LOeQ7sf3zBYK4+MkVg6?=
 =?us-ascii?Q?8cHjyvG5erHbqCx7kQrwxer/gumI4rEzVkF5ZjpzNVnO5MARyURyKiBQhcgv?=
 =?us-ascii?Q?E2c9Nax+tCGUI5324Z6k8kqPDs0zCQtMlomIyiTrzpM1Bb2sC96wNRa63Drh?=
 =?us-ascii?Q?VfYNff5SS0T/jU4QykVxaU0DNKzx4d39IDqJUrbqCGf+xQ2MGi4Up1+Cxux5?=
 =?us-ascii?Q?C03FYhGea0EL0yBSjOXm1l1nW355pZfkGMvkkU5ZRDgs0jxjkjTkYpBJVq99?=
 =?us-ascii?Q?RL5pZpU/ouWxhN4aMCUSz8PhfbfDSySx8Ms0D/2rXFOhqHviKdv6kZNb3jUU?=
 =?us-ascii?Q?XFMFm/C6ziLOSyPGYlnrfAsLcRE93oKuPhl+pBfx04TYr7d79BUl5o8/g+76?=
 =?us-ascii?Q?BrOfDPJO6pw7Lc0Zk7zFYbx/8rQ/xg49sjckRhmmoG5MZzavUf7idb/rzd7E?=
 =?us-ascii?Q?NbTzAsuox6/O5vnFqNkkKRu9begBOVIk35IESUFJeYyLlTaHo5H6wN7uN6Rr?=
 =?us-ascii?Q?A0KcRLuqYOQt7vj+EsyXTCV7QRL0CTtKorUmjJPbTETk9xDnHaOtTbG4WuW/?=
 =?us-ascii?Q?0g6me+77g9NZtSRBLKd2KjXc7KX8AMW3urbbq4VEXWVsGgMWXttbSIGIvAdA?=
 =?us-ascii?Q?Mt1ANRPAdjLROMldv4SrFacpPYixd+J6xYQAtIXwtQ4UsnvVEJIEc+SoZDOk?=
 =?us-ascii?Q?59QAfxhg+MOlDELI+h1KjCjY0LMSW0paA+5KoxtFs2WicIOu0d0GaArhChAT?=
 =?us-ascii?Q?URZ6TJITXiHv/rxpZgMaYAyRSQq2hbrrTi1yvy4962qjq7w+JOt8HAQjIsi8?=
 =?us-ascii?Q?+e9mL56MN3QfAMWu1vYOB19lcuBfUDp9ZjC4id/Dbgi7l/aXsL6vcZ51LQoy?=
 =?us-ascii?Q?5F41uXM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR03MB4646.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oVkSBF4FYI2jjxChfo2olujBfwkt2J1DB7qmK7fNUYbBm/hQ7kqQozaR8YAC?=
 =?us-ascii?Q?+bqrnzRBqMrYBu0Jq24X9bvUA1mJPZ0k6G37vxvk+7Pt8/JsaiFttyWemXU/?=
 =?us-ascii?Q?ojvMgWMyG3K5GWhGEezgPFirex23mBBWByVCOiq6+Gl0bCYkcuMjLSNIbUu8?=
 =?us-ascii?Q?fMAIJCAXW2SCqtZNQEjkrVQeH6yloV7hj5z/tgYgyM1qQyC/wM+gwOGSX5sw?=
 =?us-ascii?Q?tGcLsFmns1eHInVTc5RsEMke5F5+iOOLxQaUgjQccWot0p511/PVsmU1e58v?=
 =?us-ascii?Q?RJC23DB4QiPcrNyin6NZi5ykKSOlERDZOV2mDFCBLdQeAAOojwsRiMB3WdDl?=
 =?us-ascii?Q?2ihBr7YV0RFKUTB+Mzal3ElGqeHttMjDwqDpopvKOjOOAXOhP1d1+J5q0fqE?=
 =?us-ascii?Q?ZsUXMhpkz3KMN2eJMzCGOD1kNwWAtyoXh5S+hYzzxGzc3uoTNkfeMsIsKtMU?=
 =?us-ascii?Q?5MobMpvHxc/g79z71qqx9TvrfXj6uQ4DHu7pvTRtYt39Jk3jV0GRoinFN1JJ?=
 =?us-ascii?Q?5W+iFyqZAT0h0OOwrN6c4c7/yjhbBFQhmhri9Ffo3mIS4LluC2/X3OwgZofj?=
 =?us-ascii?Q?dDfR4XP2qq3B+y7Ya1Ah46ON9zov7XVm0AyWODlx9ALoVLgcJnqiHq2MmHsQ?=
 =?us-ascii?Q?v11kqXGRkyZHiQ7XMRiDIYoD5Vmg7HuGmifySEvHjI2bPMDvQgYZb3+xVLc8?=
 =?us-ascii?Q?gH8tHJTxUCBgh5veJCGgY8Mwy4MAfuDK2Q7jlYBakovN6Rxz1KPGriDniswO?=
 =?us-ascii?Q?yLfrkX7dglFwBU737tr191FNnqkIFGB9ua97CyB3tlZ0siPw24l1s4Dg8uQ7?=
 =?us-ascii?Q?YqcxtDQoRfiJfKDqyex+3UWuOJ/RATspWS0IcXWKR1KjSVAmgTwmjTl+kx5K?=
 =?us-ascii?Q?D84SWoTv5yiqhD+nuMwb2DgG2Kj422DnZ46OCHMLN8eu2zdFs464r3OJd+vd?=
 =?us-ascii?Q?3W1k0f3InIhvGU9EB57zN7B8Uj+hrAYQhQfF4wnXdV3m3j1guwlOGjZrJ1R3?=
 =?us-ascii?Q?lwoGUspnHiwcxjw9IFSsPi/VWvjKbSqKiMTgCd+lddagzg32WVa+5edD3ja8?=
 =?us-ascii?Q?Mkkl0eObZZFp3tQIPI0J7eKbl+Ngrep4B825HLBekFbQAnbyhWedrs2Vs4q6?=
 =?us-ascii?Q?vrVqmfrAml6iWYj+9BXx1Z53+FJ/2F/Zqy86p9FRr1vAWUxzLGISCy71eTup?=
 =?us-ascii?Q?niNf549kBVUAkw1Y6D2syPmI7wBgmjt/nSoJRj4FNBX1yhP4VWDw/dZQovsF?=
 =?us-ascii?Q?G33rbIH4dcYrMx6N/5schl8wylDrwLVIzD1wtCM6PnO8+d7260hWWygWwmn0?=
 =?us-ascii?Q?GtH+P9McPtItTViY1TicMBInxLqslpyM1qj4wPy0NM/m9k7SEDrJg29yGzqu?=
 =?us-ascii?Q?uqIpQVRjzfhmXBoR2MNEl2Vj69yXU/NpNO8HtVlu9a63JN6D9fbAwF+yMZmR?=
 =?us-ascii?Q?6ucMq4Ii//2W4ECai+hrQnK+7iMn+hByFnm2F1TBuGR6G6sMvRRZ1hdrMw+2?=
 =?us-ascii?Q?q3Tp7uI/QxrjYRucyUE6C6h0LbQ97m5WJvBVHYdOEqdxnvDbXwJULJXnA7cA?=
 =?us-ascii?Q?6GU2yh6gxerP0PfpO8QN8Awpt9CszyD3NxaS4Y+yhrGVw41J6mNjPd99Ea4Q?=
 =?us-ascii?Q?cwa6eCDY6t/NQD5xyDh4a+8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea9b66e3-d73d-40aa-e2a1-08dd8ca830a5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4646.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 14:13:35.6931 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LbTjo12nNURDn+o15mf9doetYTYQH5S0pCiIP/xqqpA9F3tI7aTbhpVMaKNeJL2yJcjNUC8nFou3ktwnIb2HF8JYIMF5xxvH8BJX+hnWa/fIEej1+Bnr8xBhlX/ziaZF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR03MB7934
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

Add ECC scrubbing with Dcache enabled to speed up the scrubbing time.
Change the SDRAM region to writethrough before scrubbing and restore back
to its original behavior after that. This is to avoid triggering of false
double-bit error.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
---
 drivers/ddr/altera/sdram_arria10.c | 62 ++++++++++++------------
 drivers/ddr/altera/sdram_soc32.c   | 75 ++++++++++++++++++++++++++----
 drivers/ddr/altera/sdram_soc32.h   |  2 +-
 3 files changed, 99 insertions(+), 40 deletions(-)

diff --git a/drivers/ddr/altera/sdram_arria10.c b/drivers/ddr/altera/sdram_arria10.c
index 133d4604738..8f281b82765 100644
--- a/drivers/ddr/altera/sdram_arria10.c
+++ b/drivers/ddr/altera/sdram_arria10.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
 
-#include <cpu_func.h>
 #include <errno.h>
 #include <fdtdec.h>
 #include <init.h>
@@ -23,11 +22,14 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/kernel.h>
+#include <linux/sizes.h>
 
 #include "sdram_soc32.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
+#define PGTABLE_OFF	0x4000
+
 static void sdram_mmr_init(void);
 static u64 sdram_size_calc(void);
 
@@ -129,10 +131,10 @@ static int emif_reset(void)
 	s2c = readl(DDR_REG_SEQ2CORE);
 
 	debug("c2s=%08x s2c=%08x nr0=%08x nr1=%08x nr2=%08x dst=%08x\n",
-	     c2s, s2c, readl(IO48_MMR_NIOS2_RESERVE0),
-	     readl(IO48_MMR_NIOS2_RESERVE1),
-	     readl(IO48_MMR_NIOS2_RESERVE2),
-	     readl(IO48_MMR_DRAMSTS));
+		c2s, s2c, readl(IO48_MMR_NIOS2_RESERVE0),
+		readl(IO48_MMR_NIOS2_RESERVE1),
+		readl(IO48_MMR_NIOS2_RESERVE2),
+		readl(IO48_MMR_DRAMSTS));
 
 	if (s2c & SEQ2CORE_MASK) {
 		ret = emif_clear();
@@ -162,9 +164,9 @@ static int emif_reset(void)
 	debug("emif_reset interrupt cleared\n");
 
 	debug("nr0=%08x nr1=%08x nr2=%08x\n",
-	     readl(IO48_MMR_NIOS2_RESERVE0),
-	     readl(IO48_MMR_NIOS2_RESERVE1),
-	     readl(IO48_MMR_NIOS2_RESERVE2));
+		readl(IO48_MMR_NIOS2_RESERVE0),
+		readl(IO48_MMR_NIOS2_RESERVE1),
+		readl(IO48_MMR_NIOS2_RESERVE2));
 
 	return 0;
 }
@@ -225,7 +227,7 @@ static u64 sdram_size_calc(void)
 		(dramaddrw & IO48_MMR_DRAMADDRW_CFG_COL_ADDR_WIDTH_MASK));
 
 	size *= (2 << (readl(&socfpga_ecc_hmc_base->ddrioctrl) &
-		       ALT_ECC_HMC_OCP_DDRIOCTRL_IO_SIZE_MSK));
+		 ALT_ECC_HMC_OCP_DDRIOCTRL_IO_SIZE_MSK));
 
 	debug("SDRAM size=%llu\n", size);
 
@@ -264,7 +266,7 @@ static void sdram_mmr_init(void)
 	if ((readl(&socfpga_io48_mmr_base->niosreserve1) >> 6) & 0x1FF) {
 		update_value = readl(&socfpga_io48_mmr_base->niosreserve0);
 		writel(((update_value & 0xFF) >> 5),
-		       &socfpga_ecc_hmc_base->ddrioctrl);
+			&socfpga_ecc_hmc_base->ddrioctrl);
 	}
 
 	ddrioctl = readl(&socfpga_ecc_hmc_base->ddrioctrl);
@@ -352,11 +354,11 @@ static void sdram_mmr_init(void)
 			(ctrlcfg0_cfg_ctrl_burst_len >> 2));
 
 	io48_value = ((((readl(&socfpga_io48_mmr_base->dramtiming0) &
-		      ALT_IO48_DRAMTIME_MEM_READ_LATENCY_MASK) + 2 + 15 +
-		      (ctrlcfg0_cfg_ctrl_burst_len >> 1)) >> 1) -
-		      /* Up to here was in memory cycles so divide by 2 */
-		      caltim1_cfg_rd_to_wr + caltim0_cfg_act_to_rdwr +
-		      caltim4_cfg_pch_to_valid);
+			ALT_IO48_DRAMTIME_MEM_READ_LATENCY_MASK) + 2 + 15 +
+			(ctrlcfg0_cfg_ctrl_burst_len >> 1)) >> 1) -
+			/* Up to here was in memory cycles so divide by 2 */
+			caltim1_cfg_rd_to_wr + caltim0_cfg_act_to_rdwr +
+			caltim4_cfg_pch_to_valid);
 
 	writel(((caltim0_cfg_act_to_act <<
 			ALT_NOC_MPU_DDR_T_SCHED_DDRTIMING_ACTTOACT_LSB) |
@@ -414,23 +416,23 @@ static void sdram_mmr_init(void)
 	/* Enable or disable the SDRAM ECC */
 	if (ctrlcfg1 & IO48_MMR_CTRLCFG1_CTRL_ENABLE_ECC) {
 		setbits_le32(&socfpga_ecc_hmc_base->eccctrl,
-			     (ALT_ECC_HMC_OCP_ECCCTL_AWB_CNT_RST_SET_MSK |
-			      ALT_ECC_HMC_OCP_ECCCTL_CNT_RST_SET_MSK |
-			      ALT_ECC_HMC_OCP_ECCCTL_ECC_EN_SET_MSK));
+				(ALT_ECC_HMC_OCP_ECCCTL_AWB_CNT_RST_SET_MSK |
+				ALT_ECC_HMC_OCP_ECCCTL_CNT_RST_SET_MSK |
+				ALT_ECC_HMC_OCP_ECCCTL_ECC_EN_SET_MSK));
 		clrbits_le32(&socfpga_ecc_hmc_base->eccctrl,
-			     (ALT_ECC_HMC_OCP_ECCCTL_AWB_CNT_RST_SET_MSK |
-			      ALT_ECC_HMC_OCP_ECCCTL_CNT_RST_SET_MSK));
+				(ALT_ECC_HMC_OCP_ECCCTL_AWB_CNT_RST_SET_MSK |
+				ALT_ECC_HMC_OCP_ECCCTL_CNT_RST_SET_MSK));
 		setbits_le32(&socfpga_ecc_hmc_base->eccctrl2,
-			     (ALT_ECC_HMC_OCP_ECCCTL2_RMW_EN_SET_MSK |
-			      ALT_ECC_HMC_OCP_ECCCTL2_AWB_EN_SET_MSK));
+				(ALT_ECC_HMC_OCP_ECCCTL2_RMW_EN_SET_MSK |
+				ALT_ECC_HMC_OCP_ECCCTL2_AWB_EN_SET_MSK));
 	} else {
 		clrbits_le32(&socfpga_ecc_hmc_base->eccctrl,
-			     (ALT_ECC_HMC_OCP_ECCCTL_AWB_CNT_RST_SET_MSK |
-			      ALT_ECC_HMC_OCP_ECCCTL_CNT_RST_SET_MSK |
-			      ALT_ECC_HMC_OCP_ECCCTL_ECC_EN_SET_MSK));
+				(ALT_ECC_HMC_OCP_ECCCTL_AWB_CNT_RST_SET_MSK |
+				ALT_ECC_HMC_OCP_ECCCTL_CNT_RST_SET_MSK |
+				ALT_ECC_HMC_OCP_ECCCTL_ECC_EN_SET_MSK));
 		clrbits_le32(&socfpga_ecc_hmc_base->eccctrl2,
-			     (ALT_ECC_HMC_OCP_ECCCTL2_RMW_EN_SET_MSK |
-			      ALT_ECC_HMC_OCP_ECCCTL2_AWB_EN_SET_MSK));
+				(ALT_ECC_HMC_OCP_ECCCTL2_RMW_EN_SET_MSK |
+				ALT_ECC_HMC_OCP_ECCCTL2_AWB_EN_SET_MSK));
 	}
 }
 
@@ -643,8 +645,8 @@ static int of_sdram_firewall_setup(const void *blob)
 		}
 
 		writel((start_end[0] & ALT_NOC_FW_DDR_ADDR_MASK) |
-		       (start_end[1] << ALT_NOC_FW_DDR_END_ADDR_LSB),
-		       firewall_table[i].cfg_addr);
+			(start_end[1] << ALT_NOC_FW_DDR_END_ADDR_LSB),
+			firewall_table[i].cfg_addr);
 		setbits_le32(firewall_table[i].en_addr,
 			     firewall_table[i].en_bit);
 	}
@@ -719,7 +721,7 @@ int ddr_calibration_sequence(void)
 		puts("FW: Error Configuring Firewall\n");
 
 	if (sdram_is_ecc_enabled())
-		sdram_init_ecc_bits(gd->ram_size);
+		sdram_init_ecc_bits();
 
 	sdram_size_check();
 
diff --git a/drivers/ddr/altera/sdram_soc32.c b/drivers/ddr/altera/sdram_soc32.c
index ccb4266473c..b6693a03617 100644
--- a/drivers/ddr/altera/sdram_soc32.c
+++ b/drivers/ddr/altera/sdram_soc32.c
@@ -7,25 +7,82 @@
 #include <cpu_func.h>
 #include <linux/sizes.h>
 #include "sdram_soc32.h"
+#include <watchdog.h>
+#include <wait_bit.h>
+#if !defined(CONFIG_HW_WATCHDOG)
+#include <asm/arch/reset_manager.h>
+#endif
 
 DECLARE_GLOBAL_DATA_PTR;
 
 #define PGTABLE_OFF	0x4000
 
 /* Initialize SDRAM ECC bits to avoid false DBE */
-void sdram_init_ecc_bits(u32 size)
+void sdram_init_ecc_bits(void)
 {
-	icache_enable();
+	u32 start;
+	phys_addr_t start_addr, saved_start;
+	phys_size_t size, size_init, saved_size;
+	enum dcache_option option = DCACHE_WRITEBACK;
 
-	memset(0, 0, 0x8000);
-	gd->arch.tlb_addr = 0x4000;
-	gd->arch.tlb_size = PGTABLE_SIZE;
+	if (IS_ENABLED(CONFIG_SYS_ARM_CACHE_WRITETHROUGH))
+		option = DCACHE_WRITETHROUGH;
+	else if (IS_ENABLED(CONFIG_SYS_ARM_CACHE_WRITEALLOC))
+		option = DCACHE_WRITEALLOC;
+
+	start = get_timer(0);
+
+	start_addr = gd->bd->bi_dram[0].start;
+	size = gd->bd->bi_dram[0].size;
 
+	printf("DDRCAL: Scrubbing ECC RAM (%ld MiB).\n", size >> 20);
+
+	memset((void *)start_addr, 0, PGTABLE_SIZE + PGTABLE_OFF);
+	gd->arch.tlb_addr = start_addr + PGTABLE_OFF;
+	gd->arch.tlb_size = PGTABLE_SIZE;
+	start_addr += PGTABLE_SIZE + PGTABLE_OFF;
+	size -= (PGTABLE_OFF + PGTABLE_SIZE);
 	dcache_enable();
 
-	printf("DDRCAL: Scrubbing ECC RAM (%i MiB).\n", size >> 20);
-	memset((void *)0x8000, 0, size - 0x8000);
-	flush_dcache_all();
-	printf("DDRCAL: Scrubbing ECC RAM done.\n");
+	saved_start = start_addr;
+	saved_size = size;
+	/* Set SDRAM region to writethrough to avoid false double-bit error. */
+	mmu_set_region_dcache_behaviour(saved_start, saved_size,
+					DCACHE_WRITETHROUGH);
+
+	while (size > 0) {
+		size_init = min((phys_addr_t)SZ_1G, (phys_addr_t)size);
+		memset((void *)start_addr, 0, size_init);
+		size -= size_init;
+		start_addr += size_init;
+
+		if (IS_ENABLED(CONFIG_HW_WATCHDOG)) {
+			/*
+			 * In case the watchdog is enabled,
+			 * make sure to (re-)configure watchdog
+			 * so that the defined timeout is valid.
+			 */
+			debug("%s: %d\n", __func__, __LINE__);
+			hw_watchdog_init();
+		} else {
+			/*
+			 * If the HW watchdog is NOT enabled,
+			 * make sure it is not running, because
+			 * it is enabled in the preloader and
+			 * causing boot loop if is not handled.
+			 */
+			debug("%s: %d\n", __func__, __LINE__);
+			socfpga_per_reset(SOCFPGA_RESET(L4WD0), 1);
+			socfpga_per_reset(SOCFPGA_RESET(L4WD0), 0);
+		}
+	}
+
 	dcache_disable();
+
+	/* Restore back to original dcache behaviour. */
+	mmu_set_region_dcache_behaviour(saved_start, saved_size,
+					option);
+
+	printf("DDRCAL: SDRAM-ECC initialized success with %d ms\n",
+	       (u32)get_timer(start));
 }
diff --git a/drivers/ddr/altera/sdram_soc32.h b/drivers/ddr/altera/sdram_soc32.h
index 4c6137e728d..85a951a5a74 100644
--- a/drivers/ddr/altera/sdram_soc32.h
+++ b/drivers/ddr/altera/sdram_soc32.h
@@ -6,6 +6,6 @@
 #ifndef	_SDRAM_SOC32_H_
 #define	_SDRAM_SOC32_H_
 
-void sdram_init_ecc_bits(u32 size);
+void sdram_init_ecc_bits(void);
 
 #endif /* _SDRAM_SOC32_H_ */
-- 
2.35.3

