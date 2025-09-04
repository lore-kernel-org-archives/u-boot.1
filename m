Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02889CA1017
	for <u-boot@archiver.kernel.org>; Thu,  4 Sep 2025 14:33:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B00483B7F;
	Thu,  4 Sep 2025 16:32:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="lfucdwFb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7438883B8A; Thu,  4 Sep 2025 16:32:42 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0E1C83B7E
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 16:32:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EogFVf83+fQnlgyCOZwc1YrLd7aaSbx+GiITucjcxkYqnjmWfxrEe3p0jZ8pYt18qcf01zaFCUVu4cUzefdpLRrrVRI8afAEfqG9GkJuqqGm3/2fbx+Ly+/20Y9IbbhqwcWuwQ9ezkccDA2ITHnBkRxH+nCLyj8WxMuiRezwP80w9YUPco0yUeQVMa7PuOarEBC/+hrdviWfLs3zXMAkJTt8WITag2kcOY1fD41O4iN3xfzZDHYHGgFduk4lKiGCg8u5kWxyYJyivP/2kCP8nIX4eH7nB3xxd0Hk+i/WMkrZ8pybqgR8X4pd3Z2n/aEFcK/YidyNQv68AvMpGMEVsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KrMoXT3wErUaRnaBMHwLhRWmoi46zEf51AniGlHid8=;
 b=bGVvpO1TRepmIkkmoNQYOSLWWYtp0tBPAnfhRSGJIAGRcTNxTXXuD5vmqTqpFF+bJEVSgtwoMa989CzR8UTpiVUzVFq/PmJxp65xeTWmSLn9EwBxBSeWzTLgCXdsbfsXh3rjJxB2jsHR0dMNAcnUaMD9XZPU44seOb/xWnzeNg/J0bFEygzS2Qgc9a1gLd9lIcTxK/lTDxj+iWGjwEvZnlxOaq7WRp7WFMZZ2xJoPHGwnTS0z5PylNYo9NCPeRHa9VTotNg2jUrNUIlcCcEVwo3AY5qV32CYCx3koPq/Kxa4kYUbGjBshpbQ3METeqpaa5vp5qwuJ+EdAgKLKAgNvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KrMoXT3wErUaRnaBMHwLhRWmoi46zEf51AniGlHid8=;
 b=lfucdwFb6M6ZgOeiB/QgPTkLVcXmnKNZ00+D8n15klBgHaTNGwr9wgTpqB4RhDgs7BKdntAcXfAYfb4LvDuTjzor0HeWMk5dyeZZVEyOLKa1cuKHmKCGSa75mGDQOZPTN99hktHCnFN9WLbwfREitZ5LvnTWw7bxIx3sjBMoU9dPLtb0DNiR+Xuz/wQQ2kZDt6gAGCoPjaNAAUZ4J66oyhNk78uybozbS18Cs+uGKf9UPKoezqJdKfpQwjnxEzrgvAkO84lfD3/+59jnn1qkTvjKkWNqtOf2EmzU8Y8Q/c2z+nXlNalyoxQce9uqYieOmu1Cpu8/yibHIhgy6WPoXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB9231.eurprd08.prod.outlook.com (2603:10a6:150:d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 14:32:32 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 14:32:32 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH RESEND v5 1/2] cmd: mtd: fix speed measurement in the speed
 benchmark
Date: Thu,  4 Sep 2025 17:32:23 +0300
Message-ID: <20250904143224.657971-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250904143224.657971-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250904143224.657971-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0088.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::19) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV2PR08MB9231:EE_
X-MS-Office365-Filtering-Correlation-Id: c91d3485-61fa-4aad-88fb-08ddebbfe212
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5xB1mkb6JSKNH/8ycbSVjsx/UJJeA1t3HKDiZ921rzpN7zsk5nw6+qcEsQFt?=
 =?us-ascii?Q?9AeOm4dm+vBtD0TyBXpwGHmFjIRClcXKZ27v0u31pZSqjD8mS3mPowQJ0qLB?=
 =?us-ascii?Q?BMl/dPUqYI+YJbH5f434GYSPV4QAtXFTnWJvvoJ/NvgL3UOMtwjgPKLIWQ6h?=
 =?us-ascii?Q?iihUe8kAyHeUnNdS+6c9V5hRW30Oy26wTC0nA4Ki+9B/KBZA5uW0ywmemFov?=
 =?us-ascii?Q?7WmbgPCOBbVCzvuHXrFdpWcsdIEWUgOVy1KVWY7NzUrwPQnLRY4nXJq2ZL5L?=
 =?us-ascii?Q?iotq7uF5Sv/xQSPzAhqGOJiLmR/l3aCsXAFx8qP2GApqYcBgQtmyOU5yZdFY?=
 =?us-ascii?Q?o26e1O92YhHCEhQc+rCscgZR5BuLrbwJxW9G5JN+bQ7msa++b0B8kkb5onDf?=
 =?us-ascii?Q?3Fl1qn79SHdZ/TaAtLZ+Z0lmHHOF7bZdZc8jV/eJopYeyDItz01rM+iUrYr7?=
 =?us-ascii?Q?D1MwXgZ0dhtRU7wUQ5mDQs6zpq/8KKQcEFzBXCjhN1cnHa2o0rFa3EVsPx0x?=
 =?us-ascii?Q?QShniiBzzq/Not/xX0Taesh17Ksj2X2wfhJoAwIXDhRKdMsV/b1oeGC/B9yx?=
 =?us-ascii?Q?9dhPgm00yt0BK8sg7frNjioMUNiado1zzFASQT7PsZdpv5C+RW9NS0kxusJK?=
 =?us-ascii?Q?cIRZV8y51R4ziO3JU3o5GcePmvekwGkF00c/fT5PoUhk/yxYtpoEhnsvfaJ2?=
 =?us-ascii?Q?EmmVCtb7r9k2ezuz981Ecq9FVbD/zGEfMMyP41Am9IeVXLZyLr6chANubEvL?=
 =?us-ascii?Q?UvZXfdNljAcLeG7ws6GkusEhp0r8a757qn/EdbWlHSa8+hts08XAKlWBjZOw?=
 =?us-ascii?Q?INvh6R0/GX8tJMzl3smwCpRH6/qVGK7pILl9ruaizyyS9fjpvBtnq3AXO4R9?=
 =?us-ascii?Q?kGhRmaaydenPtdpiY+Kq3EbuCpZGA4voJurIEJWDU4HVviKbl7D+rTvgRWay?=
 =?us-ascii?Q?lYXo82P/XvSzWMyih4WRTgvsxxFVXNubFDrHH568qX5GN5RumGaGRfaKucVZ?=
 =?us-ascii?Q?xScGDCnj22Abxilfr7U1T0/elHsL2CfCwY60N00Sprizvtg1qeAi9c0AnzQs?=
 =?us-ascii?Q?53j0z7/KBq3ixOXLLjSAvZ2U6wkRQ3YFJkzhMV6seyHovJnOJtp9Kmkjfzk7?=
 =?us-ascii?Q?mY2A5fPhBX5dwBRNvUsYOIA/gV+kQ4JyMcNhCVP5Bl8HXcq9nVkAW372ii+S?=
 =?us-ascii?Q?nTDDtt9KUBy2AXCsQTcZCMzS/PL/Q+svPPSeqR7pMUq/Tg8mk/DDy1wy8DBp?=
 =?us-ascii?Q?W4+SRn2LwJmi9Qiwb0sHk68SuzHbrQKAHeGQ1mqW1WIkL20NWs5pkwO6etzP?=
 =?us-ascii?Q?/pFE+cQFc+UPH+0wKpMZJKvsHm+EUdCSCttmDM3BL/pH0Qzk9+hsQT6whhC+?=
 =?us-ascii?Q?V9MlLXGUA1bSETR/mNlo84fJjRsQ1gvkM5WBxtuT1n6yNsFcbOQ7saCpNAaZ?=
 =?us-ascii?Q?Tvlxyzug24LOxacAYQ2wU/PRMvipkjb6piDJD37/I7sp7Ehhg7bApA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bckahJ5jJ5x1fhGxC+UX+PJk7cRxXoZc00Z0g6xc2KDYSPGWEo0AvdP131B/?=
 =?us-ascii?Q?9hHDe0QTrvkeb0T/BmfFGY9Nvk0KruZQU3w3tl0e05toi/Y3j/Xsuu920HK4?=
 =?us-ascii?Q?acS8fqvou83AfkJH0dWhyJJkcNpEbXuXWXJ6WkR2IVUjS52gNGiTg2Zv/2h0?=
 =?us-ascii?Q?RNyifYF+KuG8XnEoso1oShHefxYR0byh+qj+FWOp0FSAmEP+KclAnn4pFZtj?=
 =?us-ascii?Q?12S73Ejk19dtmmdI05C7urxcAyDrD27+8wyYJehOnfcRBRrzLfuktNruVnng?=
 =?us-ascii?Q?dVFPkHsh+2840074Df7Qx8FBVfvmxMjOjOYO5DkKiGhyKMp7FWt655mXeYb8?=
 =?us-ascii?Q?H2wWyLeMIB0/5znEuIDD34qBOSBP2Lp/ZveBSNFYumZrj0wRA4wLteORoTRK?=
 =?us-ascii?Q?n6t3imp7ALAzI4pFxF8r2xKJMSFYnz5ymvghjyBAWyi92bI+ZV+6s6NGse1M?=
 =?us-ascii?Q?RNkZIj1PaSTYWdKlRbRXG2MuxnHqLiFOWtPMJDuDd8yCixy7/eazgWXniMy4?=
 =?us-ascii?Q?KSdVvebe1VfEYbbeFEyofOr30dOuFhgIzJhzq7gLu4z0eE3cqMZemEpsl0ab?=
 =?us-ascii?Q?CVgem7WR7ipUMo88V3GA6DqukozJbmMUrgnJj6b2ThVmNDdjFKMPT7UzuchO?=
 =?us-ascii?Q?Lx1pBDQfVDEJ7tatRryQkBtIl8EMsyt3axyvEjHuxbmleXaoyUclWElgR8Q2?=
 =?us-ascii?Q?e4EQ4bN7DcY+5iSYPy4zFWAGQONUlcqcHvrYD3yJiU1xN28hWjiKa22oDbRe?=
 =?us-ascii?Q?1iymvGtmH+uxp/8+o5p3raRRxJYWQzAJYBO0q28CDhuTKz1v/sB9h2pZ8rWu?=
 =?us-ascii?Q?fs2B73tWOU3pHT8Cmzx3esuFK/+FHbBiHBhEKKM5j3eWY3RhGI+Fo4iKS4tK?=
 =?us-ascii?Q?nG6mSmxcRisIok5UviLBea8puxUO8l8yukWQzGBvd+OGtBQO4BKsAGIoe9Rn?=
 =?us-ascii?Q?+CF109Jsu7T8gCjIhNW7UCamMVLHC3GhjvmCBzkXo0aBqm8+ZTtlPr3VwMVM?=
 =?us-ascii?Q?sjxEMHcL1fgRpGIw4D7berJp0b+Jco8cFPMZtuTvHDHjyJtuD7vrlrA47wrx?=
 =?us-ascii?Q?LIge+zApJXzfOlumEcXEguSfONzhGqDxFIJkxHc71qWAzyIz6l4WFrxmZDr/?=
 =?us-ascii?Q?MB3gklQtBIoCA7M48kTaU6X5/B6WOc9MkdKu5DGfxNmprMYBfyfEqkHFeAfU?=
 =?us-ascii?Q?VRvh4ncxuhD7ia/UHP/8W+QLo7hkuypoBxETbwM14vB6MAFZiRwAiKb4vi5g?=
 =?us-ascii?Q?R+57BXPm+5IiVQfwMPqyVt8w4s0ZYOq+2g1+YA1BQpZdJVnnq16L9PyknyLR?=
 =?us-ascii?Q?ubak9gvYeR+8qq48p3axLpqtdFhLpTpL3LdFGrDNR476WukukAfvzJW+9lBA?=
 =?us-ascii?Q?20ijMTOPZqgArVGjvMgMhp40VpQrxXqt7RAwQU3GGlkaIUkPSnpOWE7D8bsJ?=
 =?us-ascii?Q?LaBalfCz2e7p6aezBvNMKTchkWE1oxf3QS796fDX45dQLUy5zq47qExVXjJx?=
 =?us-ascii?Q?bK6N8nwjw3pVaRfjBXhSwchwLmFwSR0T7iLCFuuJp2FXxYF+BAHt+8AtiX32?=
 =?us-ascii?Q?KQTj19ByWhXE+9ndwulc0NKUKJ1ae+J1pUiFXGOpZOOabq9OyUn/iJsaloWP?=
 =?us-ascii?Q?spyVZZM8XO4WXb9aQtT7qpA=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c91d3485-61fa-4aad-88fb-08ddebbfe212
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 14:32:32.3236 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1EY8/vopCeqbHKxoJcQXTWHu3nqF0wlY5ZcoNQE5jUDd/k6AUVj2uNIEr25O7gAisB6Re3JZms4gCpT6sSQMJj/qlq+YHn/Q6baoWljnww0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9231
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

The shown speed is inversely proportional to the data size.
See the output:

  spi-nand: spi_nand nand@0: Micron SPI NAND was found.
  spi-nand: spi_nand nand@0: 256 MiB, block size: 128 KiB, page size: 2048, OOB size: 128
  ...
  => mtd read.benchmark spi-nand0 $loadaddr 0 0x40000
  Reading 262144 byte(s) (128 page(s)) at offset 0x00000000
  Read speed: 63kiB/s
  => mtd read.benchmark spi-nand0 $loadaddr 0 0x20000
  Reading 131072 byte(s) (64 page(s)) at offset 0x00000000
  Read speed: 127kiB/s
  => mtd read.benchmark spi-nand0 $loadaddr 0 0x10000
  Reading 65536 byte(s) (32 page(s)) at offset 0x00000000
  Read speed: 254kiB/s

In the spi-nand case 'io_op.len' is not always the same as 'len', thus
we are using the wrong amount of data to derive the speed.

Also make sure we are using 64-bit calculation to get a more precise
results.

Fixes: d246e70cf81d0 ("cmd: mtd: Enable speed benchmarking")
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 cmd/mtd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/cmd/mtd.c b/cmd/mtd.c
index 2520b89eed2..57f6c700f1d 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -468,7 +468,7 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
 		     char *const argv[])
 {
 	bool dump, read, raw, woob, benchmark, write_empty_pages, has_pages = false;
-	u64 start_off, off, len, remaining, default_len;
+	u64 start_off, off, len, remaining, default_len, speed;
 	unsigned long bench_start, bench_end;
 	struct mtd_oob_ops io_op = {};
 	uint user_addr = 0, npages;
@@ -594,9 +594,10 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	if (benchmark && bench_start) {
 		bench_end = timer_get_us();
+		speed = (len * 1000000) / (bench_end - bench_start);
 		printf("%s speed: %lukiB/s\n",
 		       read ? "Read" : "Write",
-		       ((io_op.len * 1000000) / (bench_end - bench_start)) / 1024);
+		       (unsigned long)(speed / 1024));
 	}
 
 	led_activity_off();
-- 
2.50.1

