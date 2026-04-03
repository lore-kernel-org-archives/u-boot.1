Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E18BD73087
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 02:27:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C20F28415C;
	Fri,  3 Apr 2026 04:26:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="qRWW5jgH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE0E883D8A; Fri,  3 Apr 2026 04:25:58 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 243CB84101
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 04:25:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sq+xpQ+J9vh7HsqYuOhjBwuc0hdaUbpUKZl1rdp1EOxc+tUAp5fiRQ8CGnUaLNPwMmnnf9kEQKBhoBPQiHIaRt16lK7m69/Blb4tBGIPLU/L+qD8Jbf80P3nn5CEqINsoFevWRsx+qKYNIQyesOckufZUlI+gdnnOjSvuwB+Boizsn1T8nLf5c50JCBi3hMRvxAZpzoS+NCxBfamAN5rQ+lq5kNFkx6U74ZfWyIJXLdvCB5XjqAaFaN5eGA67jHQxzDkJFU8F3gcxBvbGxAlSjgB1vzJ6FIXsfLickd111vPxs+aHQUt+oCg9MopQ0ahuN5eDVrBj7uR6We7ntpVhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lYo4yYq3AsLIj6owfnAbgzbCKvv34/teA3kijxNQcY=;
 b=xAAdMAGKvuZH4mWlB/ptTM5zZinxcBlJM6FVLpWfkzyvKzLMOSdNk8X4qyhy7eHLik+KiNMrQd9BhE9kEroFfSK+iODEUNdG4sBIiP00rFZ2r3jsqoL4VJc7KVpNSG0KuQUGyBmyrtgdZvvL7nfaTt3kOZ5UU2HUM962AqWu4u6NmE3H/dVK5Rw8Ro7nIzrM5+klP2aWAeodtxoSGkx1c7AvGN1imNGIoLF88xD3XGbXVlLszbh3Ox3XfZTCymhRhptxKJy7P07xktv3SmNMEOQ9rwoSAquVMy+t46NwuvcI0cCmlu2A55dm2k1c7/9EslalVK5jxSWhOuXG/tRmGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lYo4yYq3AsLIj6owfnAbgzbCKvv34/teA3kijxNQcY=;
 b=qRWW5jgHPqVs9BshEZZftoWTnV0FrzLUk7vyupvLR53T+J+mJalnSuGfqinOAoLZYAVW3Z7eWJYKg2eRxrrn0RwegkO2LHveMhafqFpDb/tkRyh2Zz903A1fVzfEik9d3jLbBZE7VZnYmUF4Q9XMt+oggqD/62UEnhZQohaFy18HBlbSjXi5QiTglQOfhPbovrUnr2EEVO1IK0tURzlJIaAJkn00pLCCoUQFc3ZRLNjxPCXtcU+uzuGh2IsdSBkoNjsqXlk6HF516VTrX13z0Gkuf1Mz/iArcm6gFL3TW64pYuaVHqcS4QOrDx3w1za2vNzLu2lmjzibtn306JEiiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by DSWPR03MB989164.namprd03.prod.outlook.com (2603:10b6:8:362::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 3 Apr
 2026 02:25:50 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9745.025; Fri, 3 Apr 2026
 02:25:50 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 6/9] ddr: altera: soc64: Add secure region support for ATF
 flow
Date: Thu,  2 Apr 2026 19:25:10 -0700
Message-ID: <20260403022513.9446-7-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260403022513.9446-1-alif.zakuan.yuslaimi@altera.com>
References: <20260403022513.9446-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::6) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|DSWPR03MB989164:EE_
X-MS-Office365-Filtering-Correlation-Id: beb1840b-52fd-48eb-0db2-08de9128524f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|55112099003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: UUOGgE4BM2rytnT8fxn6sd7Ap2t6WPLOHEBhj6YWZqCxFPAZX4VMfxdbkgLCVoSBypwrurYj999AXsE5ERqCOkjJlbhucDjdvlGzPPWDAMNLuL0xkXoSlXl3O1gtHaPg7fLMc8bILWYAhtm9Lvb8EAyuCzbW/ZaWh5HWgsUrr+G0gAOePu1gKY0HrBcDoKOU1FeBRhHPVBz9ItnpNOSiLqGzSgp4jjQlIaPVeFMIOVVCzb31EC8VWiucEG+x9hmL4pJO1vH/gvAyYphl8WNBhwR1Nxb6hOqO3kNZIn8Y1IuXr0DTH5AlaFJYjqiQFUCD1mUlQ54FDA9XtVKgNOCr6KyS/4he4RO6ioGZnbXDpJlon1I/a+zSwiRaRXjh8JTQ7zotgkY+2+J8r2DJng3qRnkJh4G1QvYtRceNeWPkX5Yoq7eyi7x2BPTzsWvLEGi4QeM7ngKnbu+wVtVVE9VjeoMPB63/HSTGYJ0aOXh1Jf/6Shco+BTicmA7M0+u265qVsMdby1RyxgI5hX4YDFjren6BsOFzLfTUJdtuWUTuArWuERg+coRfZ1Rhei7ehOdOBVhD23Gma6qhHqCTmQtlXT/DQ2No5hyyrfwFwjixP1qE4sNog2G4utmcnOGc34Gf8IVp587tm96hclvnTesNVkrDODtKbGgahiQgxu29Dd+FqxphEIIyUaE41An6xuJWMIgQ3QI0Qa47OLq0U0169/1H2RtptM/zBEbmUvdALE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(55112099003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?312RpS87CT0Q/t8aVQTSLrnKD0mcyuLo+MrhABbjP3vbjQx4QhsglSf7uexz?=
 =?us-ascii?Q?TvY2yk5/ngPcTKaQIP5p6YlAKmFBpJLuN986pObuCdXzYtIrqLBx7P1rRtfX?=
 =?us-ascii?Q?AxPCM2jI2IFST/G1kqjjYVsF4OVHI9lx9DfQg2jmPSsgtb0/hskvMr+kjUtD?=
 =?us-ascii?Q?xJ3QHE6BuwbN+U5glQPbo85+wBy0B6xKklQhJB8RjD9bdenKPXF/BNu9wVIb?=
 =?us-ascii?Q?lFE0p16S46Dr3HfjVGkm6bZo4iMIOP6lNxK/sZanOwCPe6TPyjFv7WSS6sRC?=
 =?us-ascii?Q?LsIuheBWPtSE9NQL37S5UtY0TC7cc0qjFa+Tbcxaq8kDTRyz0sDzIkNT/1RJ?=
 =?us-ascii?Q?1z16m68+zsSkEasXKBWpKUXeGKah+g5GIhNu7t8imciA2kVSUIK3K1WfTnMm?=
 =?us-ascii?Q?WOs3qLud23KxAHuTwHBPh5khADl5DoSvZwMrOIqiHnAEygIge7KSydTr/jgy?=
 =?us-ascii?Q?UJqO+1ugVI5nrcC1pSnVHA+4Xmaj6hl+7BHUi3xZddFNcuK97YCAklXpNlK+?=
 =?us-ascii?Q?rAoYgGp0jwOcrBli7WCUiBAr5+DDLcM1kjTBuRCQOgXoUc6ip9tiyIuvOBY8?=
 =?us-ascii?Q?ZFEW7Gy1h5UpqGKNED+Wx0xVcKpAYNSFJCymkuiiS07F6hLPoO6sXACg54oz?=
 =?us-ascii?Q?pnavoDLlxqgnyjo3mEMoUmdOGKZfC3VS+HNUlhLn8Br7WSbBzgVTIPKt5LIB?=
 =?us-ascii?Q?AeWKfwIwoCs6SdyZnaK+U3gHJ283UtLkHHQG2eCk1bXiEhBudWMsSE/Zx5dk?=
 =?us-ascii?Q?jVIyIdoAl6bZTqfbI/Qr79xD6dENnXh8QtXRsAvEtUyOQbktqddq0YjMwJco?=
 =?us-ascii?Q?qu63YsNTPXJfYGaRleSlD4xqUUtkEUAoYCGvhJrFE0N6cXoLLD4JKWV1czU2?=
 =?us-ascii?Q?wf/ls76TUHt+1ooq1qM3Jql7jqdsyC3aVrdBnmPxtuhy5EuzPgy8P0kxskfg?=
 =?us-ascii?Q?CDNcvAtYX3W27yGUlzdJXoeVQyo8J/hGY5ay8snD+QDsgvODFX69dB3DSMrY?=
 =?us-ascii?Q?thq8hYiIQIinYzUIazk0TMxmN1UaPM/3Z2tomPdUjnPlZaj0NznfTHd5HqHP?=
 =?us-ascii?Q?a4bv0g+wj8RE2LAQeDrVsMb3ayzN1x0g7LVUFsg0nCo3tmZpIS4Smpop4zdk?=
 =?us-ascii?Q?psaqDbiZ5D5bCsggW7qoLL61nEz8+/0D9BEXAPbEpb0DbVWndow+nDB2t238?=
 =?us-ascii?Q?TOMAqDvNzLZ9rk36ZHyPHQ0Ubh6W58MhtKal4tlB6/k1MxPPVr/h43Iv4YAy?=
 =?us-ascii?Q?v+FRnom0tmkWaqECIDoaD16V7OufezE27l7EYowyL0tGlRJA9ZfIXcDbnl7A?=
 =?us-ascii?Q?xQ2WR7OBjUJ8hv0SNPrmKWXjtMVNAjrRVT0TThmNY0FL7TRV4mJvF3tT5xJk?=
 =?us-ascii?Q?IUU+YRXq9wKrOMMux71EBDQjI6bhIPe/O+QS4zv/spE3Z2EKnlHNCLn5E0Yi?=
 =?us-ascii?Q?dgmSEj7UjO6rrB79HHb2pj/ZYg1E+mmOuZr7/yC3qAyq+02d+dlmtmq2y87m?=
 =?us-ascii?Q?7fmEO/2mPrOc+HEAXeYaDHlY1Wu4wL9dxYuGRe3RDjCC5JYrLy5elWZApeB0?=
 =?us-ascii?Q?BhgX4BQkDgscryEuSPeIdKvi+xfPu/eIPzVScTYVQ2HyawaZ8Lm+JpHm1mBs?=
 =?us-ascii?Q?oJeL2B/Wo86a8XMKW8brlE1BppTPmgAibp6vVV1c052l9KVSNF0Kp14wNjTd?=
 =?us-ascii?Q?TXmRhfo+XA0yiptty8nE47aZjBzwXxw9yk4XJzN8rDXomD/YO2YeBztL89lj?=
 =?us-ascii?Q?kVN85l1vqrPMzQzn1hovfL/cbmQjM8E=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beb1840b-52fd-48eb-0db2-08de9128524f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 02:25:50.1165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 96SIKv8GDycCdpbW98BZYwE2FnztxzuzRP5HA/powK29VvA2MsOmjDNapYnUKEOiGjwyil8+FbvGpJQToKzQQZZWRrpWJMChkbV7Z8Hxapw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR03MB989164
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Setting up firewall regions based on SDRAM memory banks configuration
(up to CONFIG_NR_DRAM_BANKS banks) instead of using whole address space.

First 1 MiB (0 to 0xfffff) of SDRAM is configured as secure region,
other address spaces are non-secure regions. The ARM Trusted Firmware (ATF)
image is located in this first 1 MiB memory region. So, this can prevent
software executing at non-secure state EL0-EL2 and non-secure masters
access to secure region.

Add common function for firewall setup and reuse for all SoC64 devices.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 drivers/ddr/altera/sdram_s10.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/ddr/altera/sdram_s10.c b/drivers/ddr/altera/sdram_s10.c
index 1497a8e4aab..aed53ae58eb 100644
--- a/drivers/ddr/altera/sdram_s10.c
+++ b/drivers/ddr/altera/sdram_s10.c
@@ -78,20 +78,6 @@ int sdram_mmr_init_full(struct udevice *dev)
 	phys_size_t hw_size;
 	struct bd_info bd = {0};
 
-	/* this enables nonsecure access to DDR */
-	/* mpuregion0addr_limit */
-	FW_MPU_DDR_SCR_WRITEL(0xFFFF0000, FW_MPU_DDR_SCR_MPUREGION0ADDR_LIMIT);
-	FW_MPU_DDR_SCR_WRITEL(0x1F, FW_MPU_DDR_SCR_MPUREGION0ADDR_LIMITEXT);
-
-	/* nonmpuregion0addr_limit */
-	FW_MPU_DDR_SCR_WRITEL(0xFFFF0000,
-			      FW_MPU_DDR_SCR_NONMPUREGION0ADDR_LIMIT);
-	FW_MPU_DDR_SCR_WRITEL(0x1F, FW_MPU_DDR_SCR_NONMPUREGION0ADDR_LIMITEXT);
-
-	/* Enable mpuregion0enable and nonmpuregion0enable */
-	FW_MPU_DDR_SCR_WRITEL(MPUREGION0_ENABLE | NONMPUREGION0_ENABLE,
-			      FW_MPU_DDR_SCR_EN_SET);
-
 	/* Ensure HMC clock is running */
 	if (poll_hmc_clock_status()) {
 		puts("DDR: Error as HMC clock not running\n");
@@ -284,6 +270,8 @@ int sdram_mmr_init_full(struct udevice *dev)
 
 	sdram_size_check(&bd);
 
+	sdram_set_firewall(&bd);
+
 	priv->info.base = bd.bi_dram[0].start;
 	priv->info.size = gd->ram_size;
 
-- 
2.43.7

