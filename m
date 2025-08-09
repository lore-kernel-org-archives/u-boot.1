Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9411C87FDA
	for <u-boot@archiver.kernel.org>; Sat,  9 Aug 2025 01:10:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49BAC83D7A;
	Sat,  9 Aug 2025 03:10:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="WA/xGzBi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1090A83D85; Sat,  9 Aug 2025 03:10:33 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11020118.outbound.protection.outlook.com [52.101.69.118])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDDA083CD3
 for <u-boot@lists.denx.de>; Sat,  9 Aug 2025 03:10:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ICNEe61luNoOCirnC1DOU4LtSBL7SCvXGMACwKdFcuAYVeZfo4FVattiMQYt0IQ2+Rkju++eZw5HF/BT3NxFvY0BIPGfn7K21s1deUFZucVPJumyJjslimbyU8X+7Bc4Z/HQ068mqRCKnBXwZjdjxuacxRH/3VMbrvATJhRnyCu00jbG8GQPJ/6vC+3Jw6Y8fsennL4Ko65POanuLIo3BhVmJ8SK9yDHpkH37GyPI9G+ICKRkLwTkJS3HCII0ITnYAjO5PrGN7k1mwUz3lIiwZWlyqQtS4ujCgKP8FLHX+FdC6XDMZ+zbkB8BF0Q2p3wbBbG5AyoPmUcgFaxh2T4Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhIiTCMbqiukrwV0BJhhmWUcv4ZYkyxZQpLGFzCKQ4o=;
 b=MzLNe4ZsM9A8juaoACD2OxsZtxijSWihNSD8vHMJ9/jwoBUjYAkVkDVLcID8IJuc2qYYJeY7mVgplnrPPVhZux4iCtrkegPFwlUBPFSAVcSz7008ftJxD6LNxhqt+A0H96RENy7zANXqfBZgvCqRdh4avig6Yj+rRxC45aQC+m7Uz15LI9wVz6CpFGuS5eG8G9tyfZCPDQPg+/T9hpIIffuZiCUFejLzbtzcHJfTtspEdQsHtMykvPM7tDgOlUHYRom5S8T4sUb5PpPAMfqJVIqZ1D+i9b91MpUtZ/Ft12uUvFdV1YUUcs+ONitUoOUwvBQy2F8/mQwrG0/z7Jnz7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhIiTCMbqiukrwV0BJhhmWUcv4ZYkyxZQpLGFzCKQ4o=;
 b=WA/xGzBieyZ78+npvsw6HBt4aiKyqiq9UJzvgZGrubTdbpL4UXz7ITc1ZKppfsWWPPmuX8kCQA8Lcwi+0G2fP3eLc4+4E4dZVzyE4uYTQq88Y7McEY9KUMUVya4PeFjHJIV1ZaPlANLhXxx4gFhDy4tXDTUxkZN9VJIcFPEbnzW36wXdn/MG1hbusaJXMh2S8rQS1U4FW01p1axKXJh/XGwgBgplQHqRC8zIVXKU+HDdOxTz5RyQvfZvyFfKwrM8pt6l9tFlM9L11sXq/vilrCzeMoPZwUncIBD0MDrsUS2d83XgYMTABvfl6TVeOHbSj66E1OmrVAvgwcChU3t+mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9582.eurprd08.prod.outlook.com (2603:10a6:10:44a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Sat, 9 Aug
 2025 01:05:20 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Sat, 9 Aug 2025
 01:05:20 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 12/24] mtd: spinand: Add support for setting plane select
 bits
Date: Sat,  9 Aug 2025 04:04:44 +0300
Message-ID: <20250809010457.3125925-13-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
References: <11f6f79e-0622-42e2-901e-16335ad73409@kontron.de>
 <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0102CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::29) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB9582:EE_
X-MS-Office365-Filtering-Correlation-Id: 61dce41f-8611-46f0-1281-08ddd6e0cfa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+njZvq9nRB3u76XnL0jvCCJ7Sca0djiP82aMQCtmbJa/rcwqqcx1tbILodkj?=
 =?us-ascii?Q?mIu/g+juR2m4TF4q93no+lYwwFXFCJudv3WSdm7rCvjy3z40mXzk3CMsSJHc?=
 =?us-ascii?Q?CuoqloW14I0ix7rDA6zmNBDc+g6WPiUHkNYQ9SbXFIIQhjZ8hr4L7pAHh6Z7?=
 =?us-ascii?Q?vs2ltuFc4fTItOEnBa/SeswgeMUytVqa3MqofbmGCvhtUEmz46dRz8eYy8fR?=
 =?us-ascii?Q?w8wMz/yGzG+7QCHAiiCmwBg4aeQvJOUPV9Cxqv7Ls45wByXpewVIiPZ/jklt?=
 =?us-ascii?Q?Niz0lbJsCMXQc55s1yYiIjHvHbosbYwXVaFv5v2evqTsHvywhBRYGXqij1a/?=
 =?us-ascii?Q?MiuQvZxja9VapDCTc3okDCtSQoRVDRqV9F1n85TgF1Be3WalfDGKS2dCfg34?=
 =?us-ascii?Q?9Qq5Kho7Zpt2m7k3jbBBsk6wQN15/RNiPCvWMvGQfcsHNTCghfnOWqBj0Oz+?=
 =?us-ascii?Q?pE44R7ffyKIH0AnHC/H0Uj2nM7NKFLMRZm0JggtWjCDrVemM4kOKjhLci5rD?=
 =?us-ascii?Q?2vEZPt21bP665ljW5kDI8NU0PwYhud82efEE04fIULdknV5FTuhFwqiFpxNA?=
 =?us-ascii?Q?YYJ/AFcFVctaz8gF/bXQLe1/lZdhddR/SzIM0NLHeVkFowFhRHyQkTph7HKy?=
 =?us-ascii?Q?lATB8n3ML+/trUo1IP3/eF0oWqi1+uilfmNjnEGQZsYgpe81+/jmEcUvSRN6?=
 =?us-ascii?Q?RopPYMdPuWDlvWxLAbm6hBeNsbMTaz3qYlnI2oIdd4nD4WtjH/W9pT1Ae4s1?=
 =?us-ascii?Q?hOfHH+lLVJCOBjE3tmpWJHIIYXVUE/x1y455WUoCtQRHKHmZFZfMPaadqVd9?=
 =?us-ascii?Q?BNm67efr+epLZm/stnwguS7qr4MrgOq10bJANFst8IAuDFnUuaTNkSbl1m82?=
 =?us-ascii?Q?okhUsHHDpBK7GsqMTfXMSudkXu11pvDsrJsCk5PLfEk6nnvtZk/wTmy8qVxT?=
 =?us-ascii?Q?03o/gmL/273bZeFGPJJgAnKoP4T/Fxn5fpSyYgn11AZVwah03j+q2dPTXKdi?=
 =?us-ascii?Q?n8NqsgkdDyqP8cS6QePeKKQdME8OGhxHwNXM3FPqm9boXwbNor2qGEWWe04i?=
 =?us-ascii?Q?Un3CDwcWNQF4GCCHH1aNyoH1jLLSfjoCBRuYJi6ZqU3bvHNm0g2Hkyqal2dn?=
 =?us-ascii?Q?QbQn6/d55n0kCYsXM2w16HZYXg70t7ru8W0MZy8irfJjgCOIxS/21uOQhUcZ?=
 =?us-ascii?Q?x5GQVQlaoklv4pCo7vq0/fkNRngfFjhi5qfnDQibN31HG8rH9VK1O3VMSPhL?=
 =?us-ascii?Q?+x8lp1EDZR+6t4xHeXeNhKr49c6YTTF8BWNTz58T4F+U+twOGQ1MaN5kdOXu?=
 =?us-ascii?Q?+TsnK5y15gkxKuZDviqpIT6J/iZMm8AMxiI9kXt7gW/dZydNUPXhDegC5A88?=
 =?us-ascii?Q?Dm9tADOO4OE+XdQBK3fLgjlmdBPzYg8Z19DxZ9Up19RHas3XlvCjyN0Xu/iL?=
 =?us-ascii?Q?bXQ+GHil8d+Fh5BBfMfEXQxT5cGhEtF7v+SY8VfQBXGOWpuGjIczUbAbNfxz?=
 =?us-ascii?Q?322/kg3gD0pT2MA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2Y5ffOybc0wABgNsiU2KSF0hskgdDPLJIQs/RxwP349KD36ppdcvmYS+Mo+Y?=
 =?us-ascii?Q?/S91Rx/zDLiW8YaIhRgc2eJLbL/U8neB0xfRLYndPHYboFQVqztuivPvyhwG?=
 =?us-ascii?Q?PA/Jm+pOc7A6BJJMRFZpngb+SsRxSM/tpKeIoEiLCO94a1t9IqYz8eaZhSnh?=
 =?us-ascii?Q?dbFh9IQae9HiKvY5+rbjGlxsv2jUm3p8UDcH7dyAdFBloOk6y8d2SUaPbZ7i?=
 =?us-ascii?Q?v4lDdNEbbhU/eqsUqHlbYjAJzQro/GpiN1zEXJSVe0pWUul98db/mk28R7Sq?=
 =?us-ascii?Q?48nDQGFAkdSn28AFwjNSBtWP349Mx+kSF3eZkiVXddKksDsC63MIIfLRK3Tb?=
 =?us-ascii?Q?SpiBRo6trWZ2F7FcqvvDPFH9WTGeWk9JpfsHmaywAb7VcaLtWxdWKSsUDrhY?=
 =?us-ascii?Q?9pTGQN8w5OT1amAdrGN4e79tx5N68Q1TCDkWVIqJbVm5MkWcM28v+hI1GPXd?=
 =?us-ascii?Q?7s+WnBDD0G0TMCTiwWEtp4INJgY8HGCv6swx2F1ASEr42+u58NqxlGvHk0fM?=
 =?us-ascii?Q?EO+5stToBRI/z45GlkeTD1vqXHVfv12E2qnoVIfyfz9j57xpJOr3C0K7TggG?=
 =?us-ascii?Q?JIG13+EVy17NVnuP+Uq/cwECFewhtu0xleWYRKbe4zM5r/1n+89NIY4bWvkr?=
 =?us-ascii?Q?7L2F7FIp3432cEyspnShAg6bTDD3ditBRk23WmfPmag5S3RD5KPKaxJH//Ff?=
 =?us-ascii?Q?rA4tqe+VIch1EWhGumgdtNwYgwqd1R5qU4l1unp2Dhq+ePLK9ksKSNlhkTsF?=
 =?us-ascii?Q?5HMC7WVmmibV2QFpsR4Euqzk2Szf67qw1slpHiT+XQuhbcmq1ZBoZ1bEboJK?=
 =?us-ascii?Q?vEgOSJjsgoNsntivt9ZROQ7T+3AfonHX/PDFIZboHPljc1+9VRx6SD7fcwK0?=
 =?us-ascii?Q?SfLcSzwwvDvlU9SBGu9roL+PjdhqldtDFakolwuNE3fnbeO5VW4owjpzJNRv?=
 =?us-ascii?Q?nRUk7R3CcFnRBGuhirOR3E3NFqQOaRffOiMgfwfl2xBFocTPnc+HhjjIUpV1?=
 =?us-ascii?Q?Ib/I8AknQaxXr4ZaQjpatIA8nUcSq1818ws6wqpCx7gAEOVi9tDcAwRqE2Sy?=
 =?us-ascii?Q?va495Mo382hH3g/BJarS0waNGmD0nwU4x8txLHHPsoKnqtW/0VhDFjY6aVnR?=
 =?us-ascii?Q?Lb+UK8SoBmrtjH7uA25sAI4Vh3XPLgSDtBN5wTIZwmmJ6cx7yoov7GUFSsFy?=
 =?us-ascii?Q?78xHp+iM8KgA6MNT3fK34P//m3Bbry6DbdtVcrQ9BoFJYI1xFjpmRx5TziQ1?=
 =?us-ascii?Q?nhybBY2PbDfrZ9CsZjlUWNT7/EC9FdpUZ/or54OlUKim+HjSGs5uxQHDdIL3?=
 =?us-ascii?Q?58pa7igzxMIi3+V8NnhLGpd26a/9Oq2+J/qJiF35KOe14SddJYGpnPsH3mHF?=
 =?us-ascii?Q?Pf/pHa87Y8oZsFYV+ZdhkZNF5D9MrFMCJiRdycnKN2Dlx9dRdlHpkjqJksxR?=
 =?us-ascii?Q?10LIQLf4w/FQY2pWE1Nxr+INK41rVwbhW8yjbcGNv3jg275utoca9qeVD7qb?=
 =?us-ascii?Q?yBgomEwe+gBk4Jv0v5/1UTsKGKLYBxm1wWQKLv7Frn2u98VCpgxUrF7jV3Dt?=
 =?us-ascii?Q?SlCbxzjXMfZcxs3dfIUKilwerEgVY1YAWYl43r9kP+AopzNZmy0hGXt/Cj0q?=
 =?us-ascii?Q?8A=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 61dce41f-8611-46f0-1281-08ddd6e0cfa4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 01:05:20.2619 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Td/jLUIqTeCDtOsrMG6CDiSjE6SEAiNhM9MGXrBUPIsGx73JXhQFQIuivalF0A2sC9gTp/8ozPDxTbw1tjkbXPmL/S+TFPfSKTAH5d9Sjec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9582
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

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

Add two flags for inserting the Plane Select bit into the column
address during the write_to_cache and the read_from_cache operation.

Add the SPINAND_HAS_PROG_PLANE_SELECT_BIT flag for serial NAND flash
that require inserting the Plane Select bit into the column address
during the write_to_cache operation.

Add the SPINAND_HAS_READ_PLANE_SELECT_BIT flag for serial NAND flash
that require inserting the Plane Select bit into the column address
during the read_from_cache operation.

This is a port of linux commit ca229bdbef29be207c8666f106acc3bf50736c05
(mtd: spinand: Add support for setting plane select bits)

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 6 ++++++
 include/linux/mtd/spinand.h | 6 ++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 7ace61fd19f..0cddf2dd742 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -382,6 +382,9 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 	else
 		rdesc = spinand->dirmaps[req->pos.plane].rdesc_ecc;
 
+	if (spinand->flags & SPINAND_HAS_READ_PLANE_SELECT_BIT)
+		column |= req->pos.plane << fls(nanddev_page_size(nand));
+
 	while (nbytes) {
 		ret = spi_mem_dirmap_read(rdesc, column, nbytes, buf);
 		if (ret < 0)
@@ -456,6 +459,9 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 	else
 		wdesc = spinand->dirmaps[req->pos.plane].wdesc_ecc;
 
+	if (spinand->flags & SPINAND_HAS_PROG_PLANE_SELECT_BIT)
+		column |= req->pos.plane << fls(nanddev_page_size(nand));
+
 	while (nbytes) {
 		ret = spi_mem_dirmap_write(wdesc, column, nbytes, buf);
 		if (ret < 0)
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 011861dd059..fb3a2e5d909 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -316,8 +316,10 @@ struct spinand_ecc_info {
 	const struct mtd_ooblayout_ops *ooblayout;
 };
 
-#define SPINAND_HAS_QE_BIT		BIT(0)
-#define SPINAND_HAS_CR_FEAT_BIT		BIT(1)
+#define SPINAND_HAS_QE_BIT			BIT(0)
+#define SPINAND_HAS_CR_FEAT_BIT			BIT(1)
+#define SPINAND_HAS_PROG_PLANE_SELECT_BIT	BIT(2)
+#define SPINAND_HAS_READ_PLANE_SELECT_BIT	BIT(3)
 
 /**
  * struct spinand_info - Structure used to describe SPI NAND chips
-- 
2.47.2

