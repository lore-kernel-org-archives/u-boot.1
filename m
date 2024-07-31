Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A36C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 10:20:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66A43889C8;
	Wed, 31 Jul 2024 12:20:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="hEpcVhxl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFD418811C; Wed, 31 Jul 2024 12:20:18 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20728.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::728])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F9A588958
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 12:20:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bTZAEE90Fmd8NAF0RdzeeGpmzvLZL3zQ32XbJ3WROhYdK5W8WnxywofU8X+MZTaPglSfyRbkt+68koZIqelu3yh6Lx4PcX7iBDbdR78ZjzlDchAvp0DoBAiSUNEvGYgz6mU890yybE6XMg120AqZ14/sHQumR4QJvofDRkAYMr2RvVVvs8jQlhMatHX0wh/SGiFIeAKW3b32Y7a7XubCZo4JASXkg/1D3bc+uPIClD4V9UBhDsvf1ZSDxaGbBsPgD9MX4dCdab9tVhjnmezwROtlWzQ6pkCrO/bnXQp1a4zg53hiEFtP//FxoYf+/1G6XZfoYvOedGZzBOU6oCqaSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8fFT96N/jDT6c2wVNEIm+uQNj1fOf8toIYyuZN8d2o=;
 b=k3TjyzNfoGjB7Ti2F85yaawLEKuXgzWzsmpe2IcJrxuNB0JP9VKXHaioMXrAvajsClf5V8C9enr1cdiHhZFMf3I+QsYeKn2WCXxn6XuKDG1AU3yUFFtkxIs/Xb6CJ9xwjqH9St5NyOG4KWPAM9IlV2FJnzwlya6tHLGlQ73MmRmR38w5JriUpN/FFpCBGX+Q6Fx3/U/y7pXfWqbhM3UpYJhcPEvcvuUsOLPfCeKcKTT5QQS1ClSWLaHXlv84oa8o79e2k8YM6E8e1AXaR7REvlGHCwdATQY9RaV+4NWiNZl13J9FG4PkxjlNV0C/Vq2GuZ2tG+VZvk6ntyb6HI3ZeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8fFT96N/jDT6c2wVNEIm+uQNj1fOf8toIYyuZN8d2o=;
 b=hEpcVhxlAwxiTiPVknXc2BtMgI+SqQTRpp5oZU6bsKhXWJtQSCTRCr2ZgPzmuB2Tghist1/O0xlHtHpl7ME1mQ/S+6QiSFPC5SR2Gi38lLrlsKrhxOUxDyhku9lmkZG66P/VdMiEia3U2Klsm/N9h55elVHdpGvSyIyhM/5IKUtlCUUnFtoiThiMlN51ABL+urHixZlDuOKUgCmNo1lvRTOXrpKIj1UDnxzQOqk0N7gs0WiR4dHhA6Y5PTl+v/PGW6YSfc5FQfJuyBwa5ziMrPdBREoolrQ4vucvaF3kJKUqwPUzpIJ8F7MM2LHDKyvOdz30+99bbI0y7B/rQmGpdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI1PR08MB10076.eurprd08.prod.outlook.com (2603:10a6:800:1bd::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Wed, 31 Jul
 2024 10:20:14 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 10:20:14 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 William Zhang <william.zhang@broadcom.com>, Simon Glass <sjg@chromium.org>,
 Bruce Suen <bruce_suen@163.com>, Igor Prusov <ivprusov@salutedevices.com>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 01/10] mtd: spinand: Use the spi-mem dirmap API
Date: Wed, 31 Jul 2024 14:19:52 +0400
Message-Id: <20240731102001.4030460-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240731102001.4030460-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240731102001.4030460-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0139.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::31) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI1PR08MB10076:EE_
X-MS-Office365-Filtering-Correlation-Id: fd5c596f-9e31-4056-5f16-08dcb14a5dd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|52116014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9SdiEm45UHWBRhDhZRCIcm7RZzkKsZ2s1pG3gG9fK9TaOT2G059reF7GklBu?=
 =?us-ascii?Q?ChuTSs4I0Z4OetKR8f0pS2STUJQ+DGNcz5cVj0wggpMYWvV1tZUUVv3hYVLL?=
 =?us-ascii?Q?4UCl4xfISPsGEXKANWGYuR6/xQZJagPsaA4+wLeoLe3k9A2VBFeyQRAWyVlj?=
 =?us-ascii?Q?67nZD68AGXr+7+PKq86HrnhZmbZ2H94NpqxBOhQvTjoLZsGxAWmfhvHASN3M?=
 =?us-ascii?Q?jo9SdchrkHpMZMl9lio54+2vW9YLIf0NHDzeYjnmrIpqQgbjqG7AtoQ7e3ID?=
 =?us-ascii?Q?N1V2hsJBRrP7SDkXl8tsw86Q0aoYe5FCEYdf0/oXPMs8NZv8qSWoRjG7jaeM?=
 =?us-ascii?Q?fkjuygGFSQ03uKJ6Cj1M/kX8Wqm9BrcXNmrlLv+0xAqkSPU23odOPbgqb3oO?=
 =?us-ascii?Q?U5FAY99/CEKneI8/EatE5a2y+6TFnnE7NClQP6Iq08gW1JiobEOSbRFUAG67?=
 =?us-ascii?Q?KWmVDNTyZ/Q9IAFh70+QdqedPTyvwEqm3MuPQUHGV2IMDDLYKdTRnUWJwezw?=
 =?us-ascii?Q?ctdL3zTFwkuOhqW4w6KnzdRusOYiIqMHcO1LYlvjNUGHOYNoXvtuEqE7vB0S?=
 =?us-ascii?Q?TL2ESM+vOLgCMeVsSX8036MN//jmeM49b4XRowvmUw7rmnLnr+t7ZINowpwS?=
 =?us-ascii?Q?xQDXeFjZbmtZJOUwd6XK6+D6c2ESXYEGxeKT5mi9cPCn4bIC9Z7THGOoOhF1?=
 =?us-ascii?Q?sjTL4ZYWZhRRJ6tZY4+Lb5UzUlDCW+ms7dGTkd+2kuh+APeSH3Ix+hxK+SJt?=
 =?us-ascii?Q?hoaYvAO+QoA6jBYd6Hm6Z8BjWxi6EwWbu+rAZzhHZ77oGCnJP+27YONdEdxo?=
 =?us-ascii?Q?S8bAm7DPnwf76ZTsmH5O1c1N5KINVIQPTOUZRKi0EIy+FdPb5s1JEnLlSTOp?=
 =?us-ascii?Q?NPu5P2MOlrcvhPXkqvlw+AygGOt92yT6ARnQbBUofJK7uTPF28OmRAQ47MHI?=
 =?us-ascii?Q?bwEtXSwGrUPVmRycwFqizLChwA37HydCTu25Av2BAz7ueH14vUCxV9NSX0bZ?=
 =?us-ascii?Q?583odGozTRlW9sRC8sEc6H3K9abRgdY3BBZ6vjdVc2ruZd9c2fCS4hcp4MeU?=
 =?us-ascii?Q?6VqwnTIHG9Ov30daT0PLVpVxa8uLMA++GH3dB/bC6pvmAMNeuUHT59GBAqCy?=
 =?us-ascii?Q?DKtWTQ62bgGl6sqOXDI5uHz+W5+UsxgfcAb72vXErTQXnQoT59cPry1jP/qy?=
 =?us-ascii?Q?5e9u9y9BNMS1HFP+Iv7NgBnWycyqjF2e69bsT+s6lwTB5M7px/63/p8s2bdw?=
 =?us-ascii?Q?ZByXS/V7keB0+wUYXjjRJnmEyOfWjIcTesllOfbPux2lEaD5qeXNs5YTj+Ee?=
 =?us-ascii?Q?JAvx8eiIt0gdgEjOGzN7S6717ULh3z5w1tZeADTJ4tBDE7qdSiE6hlQlGrko?=
 =?us-ascii?Q?se9g5fwFp2DX4k/KNqPZxnl0+qBj/BIS79ifSVYkwMJnSOdln++OIKnnNYtp?=
 =?us-ascii?Q?1PyOVRA0Lmo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(52116014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jwbXiZP0+DuRlusVXlTh74c3QfzkZJV4VvE0f1SU3/pV6DdC4RxjHTGsFsKY?=
 =?us-ascii?Q?HoNdWNNjQRI38xSUEaXRuOAsoqWWyPftkXMza8/JCTGNPSS6WmGwByW1pjD1?=
 =?us-ascii?Q?XCVQ4QOUXOM9lc0mUqp641AFSnh3rl05sXj97WTUYlCG/v7GwPqSTC8pMaQ1?=
 =?us-ascii?Q?zbfpZySTMvQyOP3EJ6cMss8WxoR9nsViaZOw85qQXTLtZY+j/sJk4N6N6EZS?=
 =?us-ascii?Q?l+bE9OztEu8XMnAMEMcZi/q86ocAPHOQsunl8FhIMJ4h33K8NCzrvW6rsi+Y?=
 =?us-ascii?Q?YugvW4l4g6GLXa/sp5nEFcX69dO9WuuHGI4thOnBhMPYs9zhVJWiQqTenhp1?=
 =?us-ascii?Q?PK88I5+EnAnROYtcWU+R64VZZwphFTTaz2IE5rKnlKWUpchzISwWEnCHUJks?=
 =?us-ascii?Q?LmP9Yx8YDE2n/1hc7jDNShrgHIw40V5up6S4sLQ7hpXZrRSbk6BJRhypWhe+?=
 =?us-ascii?Q?HQI5pXNzlWa0CQkapl4g+eGhG3j47bqzqBUnJpRX+qju1u4FrIdLjbP5cjEB?=
 =?us-ascii?Q?w98HoyCj9y8bcps+zDoY4BDHxLjlUAQ+YLM2itWkVuppxYbjICtKXSeGbSDY?=
 =?us-ascii?Q?dCkp1t8hY5dSG0u4k2ECloUJPU5Nuzu0eY9N+m250KrGRv6t277ujUxz61Aw?=
 =?us-ascii?Q?oU//2q2vnZ70YBi3WWBTdIfrNDoNygHgTFqfm9vi5lV8xAFz9DsTQLFPM5bu?=
 =?us-ascii?Q?2NqChaSHtcL/NlxjumfZSqmzoGyOTBIA9pik6iadisiZp9VdNGJ4WTZX74v+?=
 =?us-ascii?Q?CUeSQIpV6eMm1JF7RDkpZBT1wKTv+M+XeA0MMNisrI3Cl1nUT1NPBrloh6HN?=
 =?us-ascii?Q?YpLZR+Hvze8nQe1yyNGI/cR/2dSVjL0VOviyEmB9Is5DRLtBiUMdyoaI40AE?=
 =?us-ascii?Q?7VYBpht4Y/TdQ0Hig3N5qFDJm1O8Tg8DqU6VtbiXGpA7T5V4e2S+Pj8tUX4i?=
 =?us-ascii?Q?FuzXXS7HJM/rL7angD6y0wSUdy5LJe7Lz8V3L55t7zk7M0IMN9lJcDhpmg/c?=
 =?us-ascii?Q?WjvEaS/3Xr3JcFIJEP/vCe2Ic+DFAvM/Dto//3j0yDcFgjh093vRivrwRu4Q?=
 =?us-ascii?Q?/ZkQgIxQ1df4Ta48KPQCtDWrsKPNUz8RnRDO84SOFpvpONOV8GnF6JF9nFjh?=
 =?us-ascii?Q?EB6PrDok2qoIsXQkH9bixHoslmObXqaRFePtf5Zrb3ePJB2FlWi2t6rbFXF1?=
 =?us-ascii?Q?Lt2rDT6rGYf0lUgBGpyqSwD1O+bWkKkerQ85ZPtgzMPn8aD732lx9LJi7Kgw?=
 =?us-ascii?Q?IjlvkzMHsC9KOYAYfDark7UwhMoVmqyIdI3j8t17c6kfGVm+XY/j+5Xc8FGd?=
 =?us-ascii?Q?g86JjU24GFfV4Hc/y4eoR/5lyVMGhAenrw51dZrdFiK0gME+tTX3e23ineDd?=
 =?us-ascii?Q?8fVeBNUlV3etH+5jEkyS/GIa3OSlPpEH92NNbSQlPy2AM9rW4sELt1gCe25z?=
 =?us-ascii?Q?Le0U5yimltaaXuKgNXaMmC9eVH5XjwEBidIjBHkaJuEhIRl3yvROaGLLl7fN?=
 =?us-ascii?Q?LAIdLKBCoRsAYqVt8SRejrkBCdHo+p/Q5cwOHmy8av11xVXSQBCh9O+OosJv?=
 =?us-ascii?Q?piOem7bBxoYJ96gLFbywk4Cw7kf7EtdBfDBSRZdUia7KJLbwvG+qBG6K3XCL?=
 =?us-ascii?Q?3A=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5c596f-9e31-4056-5f16-08dcb14a5dd2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 10:20:14.1046 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kOboXAhMEbcgW68aWQlOpyTRWk12j6TikplYH/TXuHvgVCbfEqocAIsJPBB/A5/xvFgky/wDqIo8XK7phAsdTXOukAmN6bWpvrK0ghTJw2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10076
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

Make use of the spi-mem direct mapping API to let advanced controllers
optimize read/write operations when they support direct mapping.

This is a port of linux patch 981d1aa0697ce1393e00933f154d181e965703d0
created by Boris Brezillon <bbrezillon@kernel.org>.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 185 +++++++++++++++++-------------------
 include/linux/mtd/spinand.h |   7 ++
 2 files changed, 95 insertions(+), 97 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index ef50237f10e..2a7e9c164f5 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -36,21 +36,6 @@
 /* SPI NAND index visible in MTD names */
 static int spi_nand_idx;
 
-static void spinand_cache_op_adjust_colum(struct spinand_device *spinand,
-					  const struct nand_page_io_req *req,
-					  u16 *column)
-{
-	struct nand_device *nand = spinand_to_nand(spinand);
-	unsigned int shift;
-
-	if (nand->memorg.planes_per_lun < 2)
-		return;
-
-	/* The plane number is passed in MSB just above the column address */
-	shift = fls(nand->memorg.pagesize);
-	*column |= req->pos.plane << shift;
-}
-
 static int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val)
 {
 	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(reg,
@@ -244,27 +229,21 @@ static int spinand_load_page_op(struct spinand_device *spinand,
 static int spinand_read_from_cache_op(struct spinand_device *spinand,
 				      const struct nand_page_io_req *req)
 {
-	struct spi_mem_op op = *spinand->op_templates.read_cache;
 	struct nand_device *nand = spinand_to_nand(spinand);
 	struct mtd_info *mtd = nanddev_to_mtd(nand);
-	struct nand_page_io_req adjreq = *req;
+	struct spi_mem_dirmap_desc *rdesc;
 	unsigned int nbytes = 0;
 	void *buf = NULL;
 	u16 column = 0;
-	int ret;
+	ssize_t ret;
 
 	if (req->datalen) {
-		adjreq.datalen = nanddev_page_size(nand);
-		adjreq.dataoffs = 0;
-		adjreq.databuf.in = spinand->databuf;
 		buf = spinand->databuf;
-		nbytes = adjreq.datalen;
+		nbytes = nanddev_page_size(nand);
+		column = 0;
 	}
 
 	if (req->ooblen) {
-		adjreq.ooblen = nanddev_per_page_oobsize(nand);
-		adjreq.ooboffs = 0;
-		adjreq.oobbuf.in = spinand->oobbuf;
 		nbytes += nanddev_per_page_oobsize(nand);
 		if (!buf) {
 			buf = spinand->oobbuf;
@@ -272,28 +251,19 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 		}
 	}
 
-	spinand_cache_op_adjust_colum(spinand, &adjreq, &column);
-	op.addr.val = column;
+	rdesc = spinand->dirmaps[req->pos.plane].rdesc;
 
-	/*
-	 * Some controllers are limited in term of max RX data size. In this
-	 * case, just repeat the READ_CACHE operation after updating the
-	 * column.
-	 */
 	while (nbytes) {
-		op.data.buf.in = buf;
-		op.data.nbytes = nbytes;
-		ret = spi_mem_adjust_op_size(spinand->slave, &op);
-		if (ret)
+		ret = spi_mem_dirmap_read(rdesc, column, nbytes, buf);
+		if (ret < 0)
 			return ret;
 
-		ret = spi_mem_exec_op(spinand->slave, &op);
-		if (ret)
-			return ret;
+		if (!ret || ret > nbytes)
+			return -EIO;
 
-		buf += op.data.nbytes;
-		nbytes -= op.data.nbytes;
-		op.addr.val += op.data.nbytes;
+		nbytes -= ret;
+		column += ret;
+		buf += ret;
 	}
 
 	if (req->datalen)
@@ -317,14 +287,12 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 static int spinand_write_to_cache_op(struct spinand_device *spinand,
 				     const struct nand_page_io_req *req)
 {
-	struct spi_mem_op op = *spinand->op_templates.write_cache;
 	struct nand_device *nand = spinand_to_nand(spinand);
 	struct mtd_info *mtd = nanddev_to_mtd(nand);
-	struct nand_page_io_req adjreq = *req;
-	unsigned int nbytes = 0;
-	void *buf = NULL;
-	u16 column = 0;
-	int ret;
+	struct spi_mem_dirmap_desc *wdesc;
+	unsigned int nbytes, column = 0;
+	void *buf = spinand->databuf;
+	ssize_t ret;
 
 	/*
 	 * Looks like PROGRAM LOAD (AKA write cache) does not necessarily reset
@@ -333,19 +301,12 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 	 * the data portion of the page, otherwise we might corrupt the BBM or
 	 * user data previously programmed in OOB area.
 	 */
-	memset(spinand->databuf, 0xff,
-	       nanddev_page_size(nand) +
-	       nanddev_per_page_oobsize(nand));
+	nbytes = nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
+	memset(spinand->databuf, 0xff, nbytes);
 
-	if (req->datalen) {
+	if (req->datalen)
 		memcpy(spinand->databuf + req->dataoffs, req->databuf.out,
 		       req->datalen);
-		adjreq.dataoffs = 0;
-		adjreq.datalen = nanddev_page_size(nand);
-		adjreq.databuf.out = spinand->databuf;
-		nbytes = adjreq.datalen;
-		buf = spinand->databuf;
-	}
 
 	if (req->ooblen) {
 		if (req->mode == MTD_OPS_AUTO_OOB)
@@ -356,52 +317,21 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 		else
 			memcpy(spinand->oobbuf + req->ooboffs, req->oobbuf.out,
 			       req->ooblen);
-
-		adjreq.ooblen = nanddev_per_page_oobsize(nand);
-		adjreq.ooboffs = 0;
-		nbytes += nanddev_per_page_oobsize(nand);
-		if (!buf) {
-			buf = spinand->oobbuf;
-			column = nanddev_page_size(nand);
-		}
 	}
 
-	spinand_cache_op_adjust_colum(spinand, &adjreq, &column);
-
-	op = *spinand->op_templates.write_cache;
-	op.addr.val = column;
+	wdesc = spinand->dirmaps[req->pos.plane].wdesc;
 
-	/*
-	 * Some controllers are limited in term of max TX data size. In this
-	 * case, split the operation into one LOAD CACHE and one or more
-	 * LOAD RANDOM CACHE.
-	 */
 	while (nbytes) {
-		op.data.buf.out = buf;
-		op.data.nbytes = nbytes;
-
-		ret = spi_mem_adjust_op_size(spinand->slave, &op);
-		if (ret)
-			return ret;
-
-		ret = spi_mem_exec_op(spinand->slave, &op);
-		if (ret)
+		ret = spi_mem_dirmap_write(wdesc, column, nbytes, buf);
+		if (ret < 0)
 			return ret;
 
-		buf += op.data.nbytes;
-		nbytes -= op.data.nbytes;
-		op.addr.val += op.data.nbytes;
+		if (!ret || ret > nbytes)
+			return -EIO;
 
-		/*
-		 * We need to use the RANDOM LOAD CACHE operation if there's
-		 * more than one iteration, because the LOAD operation resets
-		 * the cache to 0xff.
-		 */
-		if (nbytes) {
-			column = op.addr.val;
-			op = *spinand->op_templates.update_cache;
-			op.addr.val = column;
-		}
+		nbytes -= ret;
+		column += ret;
+		buf += ret;
 	}
 
 	return 0;
@@ -814,6 +744,59 @@ static int spinand_mtd_block_isreserved(struct mtd_info *mtd, loff_t offs)
 	return ret;
 }
 
+static int spinand_create_dirmap(struct spinand_device *spinand,
+				 unsigned int plane)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+	struct spi_mem_dirmap_info info = {
+		.length = nanddev_page_size(nand) +
+			  nanddev_per_page_oobsize(nand),
+	};
+	struct spi_mem_dirmap_desc *desc;
+
+	/* The plane number is passed in MSB just above the column address */
+	info.offset = plane << fls(nand->memorg.pagesize);
+
+	info.op_tmpl = *spinand->op_templates.update_cache;
+	desc = spi_mem_dirmap_create(spinand->slave, &info);
+	if (IS_ERR(desc))
+		return PTR_ERR(desc);
+
+	spinand->dirmaps[plane].wdesc = desc;
+
+	info.op_tmpl = *spinand->op_templates.read_cache;
+	desc = spi_mem_dirmap_create(spinand->slave, &info);
+	if (IS_ERR(desc)) {
+		spi_mem_dirmap_destroy(spinand->dirmaps[plane].wdesc);
+		return PTR_ERR(desc);
+	}
+
+	spinand->dirmaps[plane].rdesc = desc;
+
+	return 0;
+}
+
+static int spinand_create_dirmaps(struct spinand_device *spinand)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+	int i, ret;
+
+	spinand->dirmaps = devm_kzalloc(spinand->slave->dev,
+					sizeof(*spinand->dirmaps) *
+					nand->memorg.planes_per_lun,
+					GFP_KERNEL);
+	if (!spinand->dirmaps)
+		return -ENOMEM;
+
+	for (i = 0; i < nand->memorg.planes_per_lun; i++) {
+		ret = spinand_create_dirmap(spinand, i);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static const struct nand_ops spinand_ops = {
 	.erase = spinand_erase,
 	.markbad = spinand_markbad,
@@ -1111,6 +1094,14 @@ static int spinand_init(struct spinand_device *spinand)
 		goto err_free_bufs;
 	}
 
+	ret = spinand_create_dirmaps(spinand);
+	if (ret) {
+		dev_err(spinand->slave->dev,
+			"Failed to create direct mappings for read/write operations (err = %d)\n",
+			ret);
+		goto err_manuf_cleanup;
+	}
+
 	/* After power up, all blocks are locked, so unlock them here. */
 	for (i = 0; i < nand->memorg.ntargets; i++) {
 		ret = spinand_select_target(spinand, i);
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 13b5a52f8b9..5934b7604cc 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -363,6 +363,11 @@ struct spinand_info {
 		__VA_ARGS__						\
 	}
 
+struct spinand_dirmap {
+	struct spi_mem_dirmap_desc *wdesc;
+	struct spi_mem_dirmap_desc *rdesc;
+};
+
 /**
  * struct spinand_device - SPI NAND device instance
  * @base: NAND device instance
@@ -406,6 +411,8 @@ struct spinand_device {
 		const struct spi_mem_op *update_cache;
 	} op_templates;
 
+	struct spinand_dirmap *dirmaps;
+
 	int (*select_target)(struct spinand_device *spinand,
 			     unsigned int target);
 	unsigned int cur_target;
-- 
2.39.2

