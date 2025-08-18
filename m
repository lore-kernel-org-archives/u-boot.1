Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 066A8CA0EC0
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 10:07:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C257182E34;
	Mon, 18 Aug 2025 12:06:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="1LpXwHbD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 387D880FA8; Mon, 18 Aug 2025 12:06:39 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D7FE801BE
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 12:06:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=br7DHt6uaZO2YtG4t+KbxkJn/EMw4OfMxnn1ntoKfhYLjeyNgEiskwYo3pYBNzKLDD/ssh65BlPPAA2tEktEayBuFS8d8smt8Z0XR4NzPw2wM0FfwkUjg6HKUFsiErLXh8gLG4h2kMsTsBQdfwXC9Zx7KE2IQHjhma9GokLdAyeYopfhmu8enqvDpM6WL5K0adJFsrw3t3xhAvRVzsA8JNS2uomw2/Tex42bqPVO3wxzIIaR8NNQtwoUMIzenaCNeDuflZMv163Sibsud+uVtoZ9StuA5aBMefAj8f7mAi07BvsyXMqvRVxOtLtKVyY8rJO/XzQV32AvhaI4itai9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUPgIq6x4EG3jOp8KWUdw93V8PHZmMCN2fW/8PUPh+A=;
 b=rPnYsQiGGpIKjus7YkcpRe1QUBhO4uqtrSXNsz7J+G44CMis0QyMjioF764JNts4Ow6wFqdJ+TyDvkTiIWK8BdyDGz3rpNXQeIuLmkh5k0OD5WwriUkLQWLXtcpKjVg6P6Z9CsVjXgNeds7U4LoYxWK7ja8X+1gGwo72hEpHregS89+hjHnpvE96iDUqBo/mp3sR8ChBbTfPNG9zCpZNIszwCbnqqp0b83I2vg5Z+RYx8Z9OpF1zBsKIge7RsbSjbIFmrEsRkBsCf0by1dCO2k6Wk25l/e1HQmfD/R5ZAGyFIU5XgbKJmpnUCjAwnakGYHDcrbSqqPlKjom2zDObxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUPgIq6x4EG3jOp8KWUdw93V8PHZmMCN2fW/8PUPh+A=;
 b=1LpXwHbDYze/vJzUMyArEFQI1bLIAN95GWeYJPwxz1sZtbLSKUC+qWlEj48ixsBfQ2UvBp3rsIz72UZXulxQQJ9qWL2hdcBHtyI60N9K70GMXXDju2zMcPpr3g9Wm8Orwu4Gy/PxPEeoKM1HoIFT1Aw1l2EPJWqokGwffxZhIxrwa3zw0n8tAtvYICweMtnhpjp6l98hsePQM7nADd1AVZf+yANyXxAoJ2P+yHhvlejNEuqwAMvH8H5616PFPd8+kme30CWDRPk6HrMpSm5lAew4/5kYsh3WgS4DxbvqspYuAtdC9CbgJQ75XrFfc2zLBqQ8t0AcN+DAiPso5jI7RA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB9719.eurprd08.prod.outlook.com (2603:10a6:20b:615::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 10:06:36 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Mon, 18 Aug 2025
 10:06:35 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v6 08/21] mtd: spinand: Refactor spinand_init* functions
Date: Mon, 18 Aug 2025 13:06:00 +0300
Message-ID: <20250818100614.432931-9-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002E2E.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB9719:EE_
X-MS-Office365-Filtering-Correlation-Id: aa0c67fc-f661-4392-12a1-08ddde3eea51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CFKjyxyzU8nBNXfCvdyCDyG+sMpOpnZOnX1Q7gmnNPxtXclsBDlxNsjCPvqr?=
 =?us-ascii?Q?68H74x1KfkgTFwOlBUd4N54fNbHW1+Igv8Qc95XDBG5jwd2TuTrNMHleMM2q?=
 =?us-ascii?Q?NdCPd2qGaVmbELQP7QtwQSDumu0v0RkmSCevrsze4hOvjTmPs7V7dLECI57W?=
 =?us-ascii?Q?No4KHyGtaHFNzkFpvL55WWlDwUeYod5W12/Yc+9H9Q6XDIhaU4TSyhsEHSTg?=
 =?us-ascii?Q?w/B+1GQdziW1VDXgWqH4CjpsG1xdGihZfN0leq9xbcM8UCnUYm3Y+AwYl0xx?=
 =?us-ascii?Q?TfAhzW0FNl8HmJtJsJL8V9mkjX2+raSK6yuPldy37KQNpSfUlIRs/Tgm4nN9?=
 =?us-ascii?Q?V/e64LltCtoAPSKT5DS7bi9tTKFDqKTNx5HKZ6xakFZkx3B4l78sU1f+ehx2?=
 =?us-ascii?Q?WiiAjkN7Cw0lPlx7NYQm/0C2VkVVLT+zvr5uU5SeTyqGFEN7+uoFzFF/TU5T?=
 =?us-ascii?Q?ekdKBkcPuJHMrFfGurvr6DOmV2cV2avZ8hiykUXVufJzCBsAvWSelADezJ3Q?=
 =?us-ascii?Q?w/DNB9C9Cc+Z6e5aic6T79calV+aMZ8Z7JDeizt4UN3mUON6O7wSM8IZlGaP?=
 =?us-ascii?Q?NqioQAMrfhWwy8E1ZdMstXukdZ66QU0BnPFo2ng31bmhSuK2Eb0kaKZvkk5i?=
 =?us-ascii?Q?72s2GYiDq3c0/DtD06dsbBwcAUTg54b4PYwHbJIsHElocDo8jwnKYnnCHN89?=
 =?us-ascii?Q?D1ljC6w//Ymu5xODUT4KuQpWxeZcPAMdKEOsQVMniumkQS90b3+jfIrYZ6ib?=
 =?us-ascii?Q?0VNkH3fnBaGl/5yyi/8QqlM95RUO+eFmLAZuFYiM+ho9igCFeNmCTCJfts7b?=
 =?us-ascii?Q?9hy66osKiyIGhV0PPEJAF02oP8OmmKYxh7xmEhg32Iigi0PrsXESLkjonanM?=
 =?us-ascii?Q?cYKwLlQ2ktM693LHyG3+KnqPrjPNhBHG8HEVVBUSrpTiEWVZNcDS2wssLAqh?=
 =?us-ascii?Q?aEgitP5aL7aHA8jr+iMg51REGL4wep1/KxdjCPw08iSIJasLelA9Fm/Mnxi5?=
 =?us-ascii?Q?voQZGNj8fRcXf1q47bKQrg0/BT5oFGCvKvtOoi3aX3TtPlSMZBw9KaIDZJhq?=
 =?us-ascii?Q?w++NDK/hmy2ZwhZE4uppVu3mU4Bd38EMM09kz/C8zjLTGGpBzkVZYjXgMj80?=
 =?us-ascii?Q?ZWRhQBaaLpTpc9vlFFdp1NA6907nflzLkHF3gp7oQ4Lo4rhbl+uXs5iHapEt?=
 =?us-ascii?Q?Flg2S2TL7kclWvmt9w0JegwRIRmhqIcqfYxvU/+uAn6S8RLHFQ44d7aVMBxO?=
 =?us-ascii?Q?U7aIBvf1c2HX+FhOJhoVbu6nbO8cubu6GEuBo8P/aJiplkQEKaLHmjmlT3SM?=
 =?us-ascii?Q?kggWL8H3JumnWnyXDwd5ZT0RZwgYDy9kmq7oPEb0DugKyA3KOyGpzCvYIj0b?=
 =?us-ascii?Q?rWT0waYBAvg/t9BRuaxpVXFo2KrrFbkYhi+FaBIhwew7aqwCzv1+1PlpO+yJ?=
 =?us-ascii?Q?DyjeZJFNkI8Xmem2+EJxc7mG/uiUaqQ7M0FUAlpYkGYfTmBjDE5MJxUAMhZm?=
 =?us-ascii?Q?ZxV9W69HOQmRIJg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wmR/v7CjFMMcIO6Mj1NI4k8J3W5sSqHUVNYOurBcJjkTyqqIKuc+09apt6kF?=
 =?us-ascii?Q?8HZ8IWQhEeek6TWCzJwvXahr+OZSVQAQ0qcnM4a9+6yTJytgYbNgSxNOSJHk?=
 =?us-ascii?Q?a2AutNI+cf9jeuUkVWZ1gQPXgZ6cuZVQ8cRh5GMuYU45krN84c0We2G5HK82?=
 =?us-ascii?Q?b1QwZmoHW4CGuWMo4De7d7ck8aj6RX85fAH/et3zPWBCVIQgzTEViKGO1Jai?=
 =?us-ascii?Q?qFJ/Ap/+JYDy6eWnZR03yr/SB8DifbSvfI0TwLlULaxxDFBUJnLxu22oNW4Q?=
 =?us-ascii?Q?GdHa8lYu1gdt0IWPhtjGvOrOF+4IEGNOTEVlhpibVSMgn/RvbJwP/SuMa10v?=
 =?us-ascii?Q?iwPQVTlTyuuiYECUYJ//tH8iMK62oaB4KkMjrxgpZ1w71mJZHa2U9CuvEZ/l?=
 =?us-ascii?Q?iXrOteI6cRFJTuuncP/lzoFwLzXxr+7OLbyQ1mJ1JWMWdSr1CdwGe7yECLy7?=
 =?us-ascii?Q?UHQn4zG3bR2BU4I9Dh6hqcoNKnRH8M2gOzsTihz40m98zMTszmBVbiedA8Hy?=
 =?us-ascii?Q?sDAKQi6z0vlUNcN/PSCR6aE5eYYm2cXKOTOJVYyw74YL5LZJ1qZGP6HoUswe?=
 =?us-ascii?Q?CrYnN8WUPIzkDprqnLpep6Du8lDmcPDhEypdWLZKgrkWFCUeSKhuz7TYCcSo?=
 =?us-ascii?Q?kOoeWaSKSfU3DqeuHuhBtOiXRsfYzZ6lS1QPuvl8UJSHqGPG3DIvBTYNjADO?=
 =?us-ascii?Q?UmrwFtGPrZcvlvp7p3Kq8g1xgFvdzAteBQFhciyasQl82YzKL8YquGHcCz3j?=
 =?us-ascii?Q?kY4Fg1/UeUwYR0mwiRX+XMpUs7/kUFGsUZNXmpIxluIv9IyDW/Ddwyn6N2UF?=
 =?us-ascii?Q?U0JJ3mV3uMRWkbG5/JmfETrKuqA+ifPpUv2tSghLFJod9NqAb1cvScEViO1E?=
 =?us-ascii?Q?2Re3j7tsVUfuTXNb6sjzvmFQs+nwbRxlcHwyHT4k0xHGG+y6gGfPRE6HgXBU?=
 =?us-ascii?Q?97LMYs2ThfAnN+HB1mxU+t2D6WPIrGJRvCa0eRVhSBB7f9r9+EbvFUeshOo3?=
 =?us-ascii?Q?bqMw1GRgZ0IF1MKoIuTBST9+uPF538ny8NtNZzd9DCNDa+N9YxQKyJlMLA8C?=
 =?us-ascii?Q?8OsjoqpujjjvjQZUBflIoqY+m5w3Tdfo148uo4Gwg2eqMSCQv04omIR+7zWC?=
 =?us-ascii?Q?OCs2zY6DjX8tN5ZyROjNRG5220jJyv93SSg9WCHWKK2lvaYoZGyP6dgv7Q+G?=
 =?us-ascii?Q?VxNe/+MDu7lGsgvN8hXuv/XZuKagSAUndyjIFgoeYXHtwkDJqErB0wurtvu5?=
 =?us-ascii?Q?dVeUtp0vxvzZyzYQ+rlA7RuhVNef5R5LwHuFuS76xkIJHasRb1SxAuEHkPJW?=
 =?us-ascii?Q?xK5iq/92sxDRivzEXuuHwRIOeEMwgfavRzJ5R4qcjRxioxzG0fs+wbYpv21M?=
 =?us-ascii?Q?MtjWVn6h+qbGIomwy1fvuZQgFvGOR1iOyrq2iiEmXKYuDXL5dhKsuY2R7q74?=
 =?us-ascii?Q?dIhmTbm0pKu6jhJDNhimqz10Y2Y/jx8//uuh0IMiGCDLyA3/G6xnuH2+toqU?=
 =?us-ascii?Q?SGdTDwN23+P8pvNJzBiPVHbchgT9dgDUR4OaPThHZU9oy7ybxvWBZDq26q2T?=
 =?us-ascii?Q?6pwqw9faX8fh0gow668qLHVapE5OPVeZEihLbJOr5FPB/ZtaiGN7HOgZMczF?=
 =?us-ascii?Q?Mg=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: aa0c67fc-f661-4392-12a1-08ddde3eea51
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 10:06:35.9199 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AdKPMXPuh9T+1Pw+cDoXTYcrsQKeVNjCh17yNkne8TxEH7wT/zsSzB+1mGzu0JtvTD+1zebxLdkfe+o6eldMCMfEh2Qvqvl7ZZE92Vjgs+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9719
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

No functional changes, just some refactoring to better match linux
kernel driver.

changes:
 * move spinand configuration reading out from spinand_init_cfg_cache()
   to separate function spinand_read_cfg()
 * move spinand flash initialization to separate function
   spinand_init_flash()
 * move direct mapping initialization to the end of spinand_init()

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/nand/spi/core.c | 112 ++++++++++++++++++++++--------------
 1 file changed, 70 insertions(+), 42 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 6d80b7c6d30..9b48bcba496 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -160,20 +160,12 @@ int spinand_select_target(struct spinand_device *spinand, unsigned int target)
 	return 0;
 }
 
-static int spinand_init_cfg_cache(struct spinand_device *spinand)
+static int spinand_read_cfg(struct spinand_device *spinand)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
-	struct udevice *dev = spinand->slave->dev;
 	unsigned int target;
 	int ret;
 
-	spinand->cfg_cache = devm_kzalloc(dev,
-					  sizeof(*spinand->cfg_cache) *
-					  nand->memorg.ntargets,
-					  GFP_KERNEL);
-	if (!spinand->cfg_cache)
-		return -ENOMEM;
-
 	for (target = 0; target < nand->memorg.ntargets; target++) {
 		ret = spinand_select_target(spinand, target);
 		if (ret)
@@ -192,6 +184,21 @@ static int spinand_init_cfg_cache(struct spinand_device *spinand)
 	return 0;
 }
 
+static int spinand_init_cfg_cache(struct spinand_device *spinand)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+	struct udevice *dev = spinand->slave->dev;
+
+	spinand->cfg_cache = devm_kcalloc(dev,
+					  nand->memorg.ntargets,
+					  sizeof(*spinand->cfg_cache),
+					  GFP_KERNEL);
+	if (!spinand->cfg_cache)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static int spinand_init_quad_enable(struct spinand_device *spinand)
 {
 	bool enable = false;
@@ -1103,11 +1110,55 @@ static const struct mtd_ooblayout_ops spinand_noecc_ooblayout = {
 	.rfree = spinand_noecc_ooblayout_free,
 };
 
+static int spinand_init_flash(struct spinand_device *spinand)
+{
+	struct udevice *dev = spinand->slave->dev;
+	struct nand_device *nand = spinand_to_nand(spinand);
+	int ret, i;
+
+	ret = spinand_read_cfg(spinand);
+	if (ret)
+		return ret;
+
+	ret = spinand_init_quad_enable(spinand);
+	if (ret)
+		return ret;
+
+	ret = spinand_upd_cfg(spinand, CFG_OTP_ENABLE, 0);
+	if (ret)
+		return ret;
+
+	ret = spinand_manufacturer_init(spinand);
+	if (ret) {
+		dev_err(dev,
+			"Failed to initialize the SPI NAND chip (err = %d)\n",
+			ret);
+		return ret;
+	}
+
+	/* After power up, all blocks are locked, so unlock them here. */
+	for (i = 0; i < nand->memorg.ntargets; i++) {
+		ret = spinand_select_target(spinand, i);
+		if (ret)
+			break;
+
+		ret = spinand_lock_block(spinand, BL_ALL_UNLOCKED);
+		if (ret)
+			break;
+	}
+
+	if (ret)
+		spinand_manufacturer_cleanup(spinand);
+
+	return ret;
+}
+
 static int spinand_init(struct spinand_device *spinand)
 {
+	struct udevice *dev = spinand->slave->dev;
 	struct mtd_info *mtd = spinand_to_mtd(spinand);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
-	int ret, i;
+	int ret;
 
 	/*
 	 * We need a scratch buffer because the spi_mem interface requires that
@@ -1140,41 +1191,10 @@ static int spinand_init(struct spinand_device *spinand)
 	if (ret)
 		goto err_free_bufs;
 
-	ret = spinand_init_quad_enable(spinand);
+	ret = spinand_init_flash(spinand);
 	if (ret)
 		goto err_free_bufs;
 
-	ret = spinand_upd_cfg(spinand, CFG_OTP_ENABLE, 0);
-	if (ret)
-		goto err_free_bufs;
-
-	ret = spinand_manufacturer_init(spinand);
-	if (ret) {
-		dev_err(spinand->slave->dev,
-			"Failed to initialize the SPI NAND chip (err = %d)\n",
-			ret);
-		goto err_free_bufs;
-	}
-
-	ret = spinand_create_dirmaps(spinand);
-	if (ret) {
-		dev_err(spinand->slave->dev,
-			"Failed to create direct mappings for read/write operations (err = %d)\n",
-			ret);
-		goto err_manuf_cleanup;
-	}
-
-	/* After power up, all blocks are locked, so unlock them here. */
-	for (i = 0; i < nand->memorg.ntargets; i++) {
-		ret = spinand_select_target(spinand, i);
-		if (ret)
-			goto err_manuf_cleanup;
-
-		ret = spinand_lock_block(spinand, BL_ALL_UNLOCKED);
-		if (ret)
-			goto err_manuf_cleanup;
-	}
-
 	ret = nanddev_init(nand, &spinand_ops, THIS_MODULE);
 	if (ret)
 		goto err_manuf_cleanup;
@@ -1201,6 +1221,14 @@ static int spinand_init(struct spinand_device *spinand)
 
 	mtd->oobavail = ret;
 
+	ret = spinand_create_dirmaps(spinand);
+	if (ret) {
+		dev_err(dev,
+			"Failed to create direct mappings for read/write operations (err = %d)\n",
+			ret);
+		goto err_cleanup_nanddev;
+	}
+
 	return 0;
 
 err_cleanup_nanddev:
-- 
2.50.1

