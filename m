Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40703E95396
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 13:17:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5617583A8E;
	Wed,  4 Feb 2026 14:16:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=vaisala.com header.i=@vaisala.com header.b="0RVhDSzb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D7E6838FA; Wed,  4 Feb 2026 14:16:57 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AE9083A24
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 14:16:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=niko.mauno@vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KaW7rvHfgy/6DFX/NqSeuFblLftjIBuuexmN5xM1GuyVReUJfTkefpDiE3RqXCUty/ZVU5SHK+iYFzpsVCsEE6l7CHaRjbnptVoEoTBKr0oFKNUHY0aVr2Orz1tLqrD+Y91epAuLL5V4++zbLnd0V0N0ZWZp49T6YSvfeCKcHN0p20lGSc6O5NC0z/nNOxIc3gwzGM198FJbLCmqQX63RALBakWpC0LlFX4s5N3B9e2lY+Rj594k1B3G7top/gm6AY7Kg4Q5OTCpsf62OvKaVBzzHmEeeMfXouaQsE7nN35ygOnESjCmE6JkKgFT4UCtdvig3uJx22VfkbVqVML9BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRnEskrm7s6/jftso8ilZ40mXEzTh/zkWiQFbMKPmPQ=;
 b=MGha9IhaMi8eFWLAi0ulu2giBVdv2D/fboDRNBDf1WeDzPmie7HhHWNIJYB5+yXtkK8BLLEfu5q8ME3ypVIglcbOU8YeLSzzq0pro8GyeRGgyAb4XkJVd909CXB6bEa5LrGWeqXOt3+WA/Cg/6tuqJlgEVIO/g+LnZ7vT+bHUdjFzwCgECHhODAn69TodGn0ATzlfgY9K1HRIhm5m2FbMBlXqHOm1ePyh0Od+Rw0Xot83xaFzfbN2qr8gx3P4WzxCA11s2vGjZeovtcf7ygwAA1NANeXcqNeXYWbQtJpLbYVrHhmRkeqIYa0fVsHgQTrY3tSPwNheH+nkDCXVTbJsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRnEskrm7s6/jftso8ilZ40mXEzTh/zkWiQFbMKPmPQ=;
 b=0RVhDSzbcrAjX6/5gfDBxwuea6pnFqtmlv+iWTqyip2SfIc88YW56snrUOlUKLdmwyH46zIzdFTFrDhGnxS1ySBvjR6txyUwODKuWSlPG4+4RrxGKvlMKfFlymxke+qFL6go14bjai24sHPRLc+JrSJrqSAVok5LLhsGpErXJPok6udpb/sjsdDGmUjRH83HVs7UHPJeHAkE5wV1jiOwr7xwLF/MX1km+nH9diSfKsla0rzXx5PKT5CLiflaS4fhB2nTnFE/FuVA/Wdey7WTW8dU+O+Mj5s+I9yxFSWrUL+/ViVBMxT0GjcqwIK9NALe+jQNI80jkIQwNiNMhmB35w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com (2603:10a6:20b:4e2::11)
 by GV4PR06MB10191.eurprd06.prod.outlook.com (2603:10a6:150:2df::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 13:16:51 +0000
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::fb61:408a:ba4e:990f]) by AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::fb61:408a:ba4e:990f%6]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 13:16:51 +0000
From: niko.mauno@vaisala.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Niko Mauno <niko.mauno@vaisala.com>
Subject: [PATCH v2 1/3] bootcount: Use predefined count/magic bit masks
Date: Wed,  4 Feb 2026 15:17:35 +0200
Message-ID: <20260204131804.23805-1-niko.mauno@vaisala.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770197302.git.niko.mauno@vaisala.com>
References: <cover.1770197302.git.niko.mauno@vaisala.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00007563.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3fb) To AS4PR06MB8447.eurprd06.prod.outlook.com
 (2603:10a6:20b:4e2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR06MB8447:EE_|GV4PR06MB10191:EE_
X-MS-Office365-Filtering-Correlation-Id: 36d850cd-e550-4436-ea5a-08de63efa8a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NcHZHHooVaApImlrg7aHW4K1CxKcvgdzTHytnL7D3sblnieNlnUW5k9s/am6?=
 =?us-ascii?Q?CR2p2b2G/mkMT3BuQ5e0rjzv5Z+nOwW0HFWNE0lHORmVBeYAm0S7RrsOJQFF?=
 =?us-ascii?Q?HdZXE4xHZgmJYu0FUdj0FMAWbelnfU7qmYpeHhoZGkDeVR1XdtkBWzcXiV2T?=
 =?us-ascii?Q?v+Ia9wlOcFSpGsUHjJQA2gvLXLDV2di68NQFMe7nh6LHb5cIWwlYYzMXqbuM?=
 =?us-ascii?Q?Fo9sev9azOf8hx/lBSTbyIC5tI3X3SZAZkgAgKHge7zBq/1VH/BzJdq+Qa8j?=
 =?us-ascii?Q?rV1C1MDg9Y1IYEJnCiIqrJom5wybTUdwsie5fK7MO/+38WsTIL3t5Lg2QBLV?=
 =?us-ascii?Q?rUs46jNNa1AkERiDumXPzXVppu9UTWMNdYSFnxEYoJ9TDp2bNcRtVfo+PrrO?=
 =?us-ascii?Q?YgO98oEOJ7enB+5qhAuwIiJyvKuL98aqO26Q5Uxz7wEXdNIMajOdE9SMfKe8?=
 =?us-ascii?Q?Gfl8mt6Rz7mSoqzIVfbuoQ1AhpYaHfp/D46FTBkdlJXfwGy2eFCOQ7hGw1u7?=
 =?us-ascii?Q?RpQO4kmZwMGO70Jw54t4sy5zvvopc3p+LVv7kdRbryHkl+F21q9bExo/cp9k?=
 =?us-ascii?Q?VzU+sR2rQo1/ruLjsdiCP1fU2A8Ee1ouqwx1AeYPaIZijwdRURqtsATrP2lY?=
 =?us-ascii?Q?Z7v8RF37jMH8YU47aYCHmP4SQRiddPfUSvnusV6Vjif/chIUWu0OPfD+UueY?=
 =?us-ascii?Q?PMWbykT7/h5wRoC5/5VGHzi4Et88i9jf5yzkBNZmxhyrYRAoNcECK1DFNBZS?=
 =?us-ascii?Q?T9puxLJgtgxj+hoIGlS5DKJyRZ930rz/CqQqaeCnk9XeSNaNbF/+TfRswXjg?=
 =?us-ascii?Q?7l7d6ElYMG9zzIig/QFJPVY7w9q8dUrt7IrRiNR2KxjdHVDyk8ZIyXUblO+B?=
 =?us-ascii?Q?EopKkycjYJaUarKimfCaHB6+0Ih//nqH6ht4+7jpe8olBKV9B3iqmGylLu9g?=
 =?us-ascii?Q?IoSaddQuEvA3AWftkQRZIU8Z/Jk3CFl1zyZmH0i3F80m+N9e6Ii/fXYEa9aR?=
 =?us-ascii?Q?iX1piEU/r1ywhlYNVN2IDv07tuWQ/5f2GtJ9k+sVElwRg74YNUfuQvzF/8wz?=
 =?us-ascii?Q?8kaDkBktqnAT8/j/K91s5EAN6TudUMsWSgBqXa7gTjkJxDVkUO3GnAdDvtUP?=
 =?us-ascii?Q?SxTSsojMmkOKpKPjtxUgCs8hcmMLsV1Ob8FXK9PimTHD7vCYaMA4GbV/8ftC?=
 =?us-ascii?Q?CDuhw30yOSIcM8OKzthd+UBMXgJXVcB4Uk+M5GLuDq7iav1yCODjLR/sKbE8?=
 =?us-ascii?Q?zCJGoASIFTGX7Ki9Ov21dEu1qRq3ZBdEkvYT1DlnY0zvp1mKXM/zwlU1stKq?=
 =?us-ascii?Q?mbZlp3uMhVbUEe9wA/b13pPWlTlGQ3zHIozHSagQNE/8QwAza3csY1t1T9mz?=
 =?us-ascii?Q?VMy0icJcSUB0zOpo9RlbPcq4F9mO8pmb1dFPrYB76H7+tF1zDSBtQrSxC/7A?=
 =?us-ascii?Q?aSGFrjG/aeZxhoWxeu/YGcXw3n89oM6b5Zs3PzBcUH2OHkW/lSMP8fo+Ie27?=
 =?us-ascii?Q?62S5+nIsgs045COsgZa8c3KFfvK8NbdFgyA/3d3Fb58jQzpmMLTil9nZliD5?=
 =?us-ascii?Q?84/QBusblN4aZW6mO+W/IcBr1fO/uYRhfKoAbhXPYoefVPTsRPVzmpAmuXWY?=
 =?us-ascii?Q?F/BypLKotPCJui/LMm+RdxY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR06MB8447.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZiyFz26EpWgMiC1zKpf//fuq+VUkiK0YojpKUHeQf4f+X8msANM7dyy+iIpI?=
 =?us-ascii?Q?Mn4oC39U7KWZ3sH8/2PxVtRYFjC6hjj4QQholOcuGcPnLoq/Bml43c4VEbO4?=
 =?us-ascii?Q?9/tk2wYHHZhkfWdxpOPuHfuHplMEMZr/v6B0KoUaH4wg5fl8Mb8s1AJXLaDJ?=
 =?us-ascii?Q?JRdHY7e25ndXMCsJGkQ7Ntvp/H3MCa2mtf/hmqtJ79N74CoEjSqjIvOPuktz?=
 =?us-ascii?Q?766IMlG7SGKFf3Bnz7u/0rueuMBh0vBpnTNh+p/f678rJIfRUrv6cx3FQ2hI?=
 =?us-ascii?Q?oVAsXYgwFisLAS10CwSHkMPZYpbK8CCTkKe1YDh+2XAY4Q7HAd6wSAhLmZiP?=
 =?us-ascii?Q?tDRj8jNE5BBIfiXLv4FxXTxYMXlCKlQtAYwOIDpq1Fh84d1jkshTgJnGZHb/?=
 =?us-ascii?Q?EZG0FBgN0u6EWTtkHc72H2LWVujHWyH8MSimG4SGYOfkB15k5PHJGeaKt1iI?=
 =?us-ascii?Q?56Gqblr1rv2EFlZpic847Egyyc3cUZjBXJJBpPFRukYU3//iVRH/iChrJHU/?=
 =?us-ascii?Q?34leV9TLybLQVR9JoazpfN0EGCEN2CXy9rfjil+ggfbGB1Z5F1bWnqc3EuHb?=
 =?us-ascii?Q?fqkRWhWIek4l4Pzw0RAsNASl9j/ATYN1atCLSQ6SJS9e1i5MnYbS0S/l90ty?=
 =?us-ascii?Q?Oo5RGbQBa6CSW3BYNyiBonRT2+n/6XBivL2uD0x5czuCwys/BU2NKQ59rYTO?=
 =?us-ascii?Q?YF4+Zk6XU0/XYvKk5n+ShlSUMCG8TsgBwHGe+zHKRDcg84iI6g695fRGq3BL?=
 =?us-ascii?Q?VGp+nzrsNS7WuYYfNgWk17308sZgHMNE8tFPAWudThTgJIEsSPMqpatTdlXY?=
 =?us-ascii?Q?6jsq7FfLZkMiObkwKWGNBs6cGI6fORS6+y8uer5XlKbnb9ldP/QtYSTt5Jc9?=
 =?us-ascii?Q?WoHRIvZYhO2z3gKa64K9EUXaeA0EBtu7UdB7J2gKzNWH70eGgARp/ZI6pQ1m?=
 =?us-ascii?Q?OvvZLvsCOGvfTK99nv56yUyphJgIagD634gSzPBkRL1SiBstqpJI6LZBYkIj?=
 =?us-ascii?Q?PmXimDbKgks89pLUQN9UclegyjB1A1/SE0xml5Q/GzIbLpQQMzKYA5ru2ALx?=
 =?us-ascii?Q?9NjDNWzwr6p4Gnd8J53LvX7PtsGlzopPvV3p8ly9VEpvtRt7YfODV3brYe/Y?=
 =?us-ascii?Q?+lM+KjtE/UW5khPzat16ZF0M1LEW8hhLIwilNRYGMnLes9A1+0jLU1zBSEBG?=
 =?us-ascii?Q?uX52v7lTW3cGqJSgrxpACYV5nR4DxSO83QdC94hZSP5jEXr3mzyoJSrY+XsX?=
 =?us-ascii?Q?0CPyf1UKPbpFnBtZ15maii4e/khug8U5tb4QjVKGKWXSMyqOwyWADTp8S5r+?=
 =?us-ascii?Q?sEdEf3G8ZXMXwSAcbGAQ3lZk3XXXn4yaLndZd/Uf2+V8NyTMODPSGEayeTpz?=
 =?us-ascii?Q?p7QJH9OV5JE0F76pYOAmGj1JWLsnT6eA27b81UHpGWwrsHIlIwnGudtA+e+f?=
 =?us-ascii?Q?K9B3sD0kBdyDMgtHjZ+10r7q2lD3fWC5Ygk3pXSyDibr8w5IV3I9tZ0Y81ay?=
 =?us-ascii?Q?X03VqB1mdQF86eLva9RKzA3MDLscfvdD4YQ8kx5dwLnKl6z5fDb48WmoutVq?=
 =?us-ascii?Q?OtS16orv4xRfvXxonKP34BYWxA6KYnGgAc1iJIT6KmT3Exz8eLPq7XrYCz6H?=
 =?us-ascii?Q?Lob4GJtMRopZgGNIZ0AvNKukBoRlL1xugCX/GR5WRei/Liq/pjkcvjMSRbLv?=
 =?us-ascii?Q?U0C8Lr8C/hCu3YUbXgAYAMrX2/w9le1Yj/jQz3w3zI/XsRyFGjt6Bv1/4AAg?=
 =?us-ascii?Q?aALYaCv8O/OGpzPM18nY/prI92kw8jk=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d850cd-e550-4436-ea5a-08de63efa8a1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR06MB8447.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 13:16:51.1874 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CeB25NeN309c4Z2kaDzJ10IbsoyNVq3gaZet1H9ayztRu9z5+Xi+gp4wp8iqbqet68HNRoLsGf1C9tJh412fYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR06MB10191
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

From: Niko Mauno <niko.mauno@vaisala.com>

Use predefined bit masks in operations where only the magic half or
only the count half of the 32-bit value are processed.

Signed-off-by: Niko Mauno <niko.mauno@vaisala.com>
---
 drivers/bootcount/bootcount.c         | 12 ++++++------
 drivers/bootcount/bootcount_at91.c    |  7 ++++---
 drivers/bootcount/bootcount_davinci.c |  6 +++---
 include/bootcount.h                   |  5 +++++
 4 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/bootcount/bootcount.c b/drivers/bootcount/bootcount.c
index 343b8a34414..454e50591df 100644
--- a/drivers/bootcount/bootcount.c
+++ b/drivers/bootcount/bootcount.c
@@ -19,7 +19,7 @@ __weak void bootcount_store(ulong a)
 	uintptr_t flush_end;
 
 #if defined(CONFIG_SYS_BOOTCOUNT_SINGLEWORD)
-	raw_bootcount_store(reg, (CONFIG_SYS_BOOTCOUNT_MAGIC & 0xffff0000) | a);
+	raw_bootcount_store(reg, (CONFIG_SYS_BOOTCOUNT_MAGIC & BOOTCOUNT_MAGIC_MASK) | a);
 
 	flush_end = roundup(CONFIG_SYS_BOOTCOUNT_ADDR + 4,
 			    CONFIG_SYS_CACHELINE_SIZE);
@@ -40,10 +40,10 @@ __weak ulong bootcount_load(void)
 #if defined(CONFIG_SYS_BOOTCOUNT_SINGLEWORD)
 	u32 tmp = raw_bootcount_load(reg);
 
-	if ((tmp & 0xffff0000) != (CONFIG_SYS_BOOTCOUNT_MAGIC & 0xffff0000))
+	if ((tmp & BOOTCOUNT_MAGIC_MASK) != (CONFIG_SYS_BOOTCOUNT_MAGIC & BOOTCOUNT_MAGIC_MASK))
 		return 0;
 	else
-		return (tmp & 0x0000ffff);
+		return (tmp & BOOTCOUNT_COUNT_MASK);
 #else
 	if (raw_bootcount_load(reg + 4) != CONFIG_SYS_BOOTCOUNT_MAGIC)
 		return 0;
@@ -74,10 +74,10 @@ static int bootcount_mem_get(struct udevice *dev, u32 *a)
 	if (priv->singleword) {
 		u32 tmp = raw_bootcount_load(reg);
 
-		if ((tmp & 0xffff0000) != (magic & 0xffff0000))
+		if ((tmp & BOOTCOUNT_MAGIC_MASK) != (magic & BOOTCOUNT_MAGIC_MASK))
 			return -ENODEV;
 
-		*a = (tmp & 0x0000ffff);
+		*a = (tmp & BOOTCOUNT_COUNT_MASK);
 	} else {
 		if (raw_bootcount_load(reg + 4) != magic)
 			return -ENODEV;
@@ -98,7 +98,7 @@ static int bootcount_mem_set(struct udevice *dev, const u32 a)
 	uintptr_t flush_end;
 
 	if (priv->singleword) {
-		raw_bootcount_store(reg, (magic & 0xffff0000) | a);
+		raw_bootcount_store(reg, (magic & BOOTCOUNT_MAGIC_MASK) | a);
 		flush_end = roundup(priv->base + 4,
 				    CONFIG_SYS_CACHELINE_SIZE);
 	} else {
diff --git a/drivers/bootcount/bootcount_at91.c b/drivers/bootcount/bootcount_at91.c
index 1a06db1fb74..1322abe921e 100644
--- a/drivers/bootcount/bootcount_at91.c
+++ b/drivers/bootcount/bootcount_at91.c
@@ -3,6 +3,7 @@
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/at91_gpbr.h>
+#include <bootcount.h>
 
 /*
  * We combine the CONFIG_SYS_BOOTCOUNT_MAGIC and bootcount in one 32-bit
@@ -13,7 +14,7 @@ void bootcount_store(ulong a)
 {
 	at91_gpbr_t *gpbr = (at91_gpbr_t *) ATMEL_BASE_GPBR;
 
-	writel((CONFIG_SYS_BOOTCOUNT_MAGIC & 0xffff0000) | (a & 0x0000ffff),
+	writel((CONFIG_SYS_BOOTCOUNT_MAGIC & BOOTCOUNT_MAGIC_MASK) | (a & BOOTCOUNT_COUNT_MASK),
 	       &gpbr->reg[AT91_GPBR_INDEX_BOOTCOUNT]);
 }
 
@@ -22,8 +23,8 @@ ulong bootcount_load(void)
 	at91_gpbr_t *gpbr = (at91_gpbr_t *) ATMEL_BASE_GPBR;
 
 	ulong val = readl(&gpbr->reg[AT91_GPBR_INDEX_BOOTCOUNT]);
-	if ((val & 0xffff0000) != (CONFIG_SYS_BOOTCOUNT_MAGIC & 0xffff0000))
+	if ((val & BOOTCOUNT_MAGIC_MASK) != (CONFIG_SYS_BOOTCOUNT_MAGIC & BOOTCOUNT_MAGIC_MASK))
 		return 0;
 	else
-		return val & 0x0000ffff;
+		return val & BOOTCOUNT_COUNT_MASK;
 }
diff --git a/drivers/bootcount/bootcount_davinci.c b/drivers/bootcount/bootcount_davinci.c
index 6326957d7b0..a03d160a4cd 100644
--- a/drivers/bootcount/bootcount_davinci.c
+++ b/drivers/bootcount/bootcount_davinci.c
@@ -24,7 +24,7 @@ void bootcount_store(ulong a)
 	writel(RTC_KICK0R_WE, &reg->kick0r);
 	writel(RTC_KICK1R_WE, &reg->kick1r);
 	raw_bootcount_store(&reg->scratch2,
-		(CONFIG_SYS_BOOTCOUNT_MAGIC & 0xffff0000) | (a & 0x0000ffff));
+		(CONFIG_SYS_BOOTCOUNT_MAGIC & BOOTCOUNT_MAGIC_MASK) | (a & BOOTCOUNT_COUNT_MASK));
 }
 
 ulong bootcount_load(void)
@@ -34,8 +34,8 @@ ulong bootcount_load(void)
 		(struct davinci_rtc *)CONFIG_SYS_BOOTCOUNT_ADDR;
 
 	val = raw_bootcount_load(&reg->scratch2);
-	if ((val & 0xffff0000) != (CONFIG_SYS_BOOTCOUNT_MAGIC & 0xffff0000))
+	if ((val & BOOTCOUNT_MAGIC_MASK) != (CONFIG_SYS_BOOTCOUNT_MAGIC & BOOTCOUNT_MAGIC_MASK))
 		return 0;
 	else
-		return val & 0x0000ffff;
+		return val & BOOTCOUNT_COUNT_MASK;
 }
diff --git a/include/bootcount.h b/include/bootcount.h
index 847c0f02d98..86474569d36 100644
--- a/include/bootcount.h
+++ b/include/bootcount.h
@@ -10,6 +10,7 @@
 #include <asm/io.h>
 #include <asm/byteorder.h>
 #include <env.h>
+#include <linux/bitops.h>
 
 #ifdef CONFIG_DM_BOOTCOUNT
 
@@ -59,6 +60,10 @@ int dm_bootcount_set(struct udevice *dev, u32 bootcount);
 
 #endif
 
+/* Bit masks for magic and count parts in single word scheme */
+#define BOOTCOUNT_MAGIC_MASK	GENMASK(31, 16)
+#define BOOTCOUNT_COUNT_MASK	GENMASK(15, 0)
+
 /** bootcount_store() - store the current bootcount */
 void bootcount_store(ulong);
 
-- 
2.47.3

