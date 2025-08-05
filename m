Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1DB1C87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 08:17:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69F28841C8;
	Tue,  5 Aug 2025 10:15:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="G+86R7cU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D20D3831C5; Tue,  5 Aug 2025 10:15:42 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2845A84142
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 10:15:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BrL+LMqI/k+N7Re/6VUaCgfLf9wVi1U6R9YdqHme5OdBJQkSlwqoYYg/R+W9xWJw4SPsgnqJ+q+uz754NWihzg1WWX/ZqYEyRXicxneznPf2QcIrd1B7JESwJNB4vxe8jP5pzU79/Q+Ix9KaWX4M6Xd4xZvyrcEun/EYDDOlDVIkPzSZMdRKyWNVdZATx4M4avSSAD25XISkQWpVjPXpbw19X8YzaeIqQa5xDB8XaYHGOfFVaDGq8nBFyJV0BKaCFC3IXXCBF1dWOxRWIcgPTE/SmRfPkoJ/f5Kz2f4C8fHNxHs4/tWK7L8XQrSmb+MVsGRl7GOm9sC6S8liiFCXqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5V59sYNd3d2AXL908cxc5+GDKD2NkSXybUwD6ek8+0A=;
 b=xZPkL3YVbmLrb9Ipsixp6YBMDGBU8o2ITjGGzz4Ed09F06chIKNxg0B1LUaIijMJJ3MA/TYCCoHwxdfAU8qxelBObCoKJd2J5refJbfCzvpmjOBItvRzR214BmQvj91euFmkA4ChdDOQw43BxZGIoIZsOqeCgLsZ5BsIWzvpt8rOZhXXNX5HvkduJ/WnDk+IBNJFY8HkLuSKq9lipqKHSFIsLji8ZY+7AE6/ZUUngHqW2qGvzQ/UMj9hCFd4cNDBSCEt/W9xZKoRXD/dVEZIdHt5lDc6TX3JuKgBcyb62WSgs5wGPhKkyLsmkRCzs+juKVwe+l4tzQaP8qtVxnJv+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5V59sYNd3d2AXL908cxc5+GDKD2NkSXybUwD6ek8+0A=;
 b=G+86R7cUbw9I9iF1g8XpX6ROdH+hkelhG488SxdM5BzrtkLTMjmfBs9Jz6j0Dr2IqU8xP/Qm+U8AyFXKabAcVeabUcn13jImMNSx9E0aJaniEOIU+lUES5HnttZqbjiQZNJBhM8r6G09xFVMLVrkYXA6h1H9516TcSsKrIL/jcPXjc9taPUCDWCw9FChMZn25+DdFprZcWLz0rhzgfTB2tjWuGOB6a9LmRIG725F3L4VmyTwaSxFjpyxfdFGUNNAcLfLgHHntY31ku0w1/FUifN8VT+rO7Dwn83CzxL/Qcuwcnrt9k9KeCRueNt/lxA1/om/w7Ku7IIgTr9Hur42XA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB6698.eurprd08.prod.outlook.com (2603:10a6:10:2a2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Tue, 5 Aug
 2025 08:15:27 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 08:15:27 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 06/22] mtd: spinand: more use of spinand_to_{something}
 helpers
Date: Tue,  5 Aug 2025 11:14:55 +0300
Message-ID: <20250805081511.1482964-7-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250805081511.1482964-1-mikhail.kshevetskiy@iopsys.eu>
References: <11f6f79e-0622-42e2-901e-16335ad73409@kontron.de>
 <20250805081511.1482964-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0902CA0059.eurprd09.prod.outlook.com
 (2603:10a6:7:15::48) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB6698:EE_
X-MS-Office365-Filtering-Correlation-Id: f34ebd2e-64fa-4f77-2bb0-08ddd3f83c5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|52116014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SOL8UJ72I/ITWYav7IcCBMJCHkKhKsv565SAPivrIzKZkzfYY8Vry+3z9iTR?=
 =?us-ascii?Q?B1HJsuHGSfFvkqg7jXpUTxskwaumz1Bv6ZKEnPVDiUjvLVWXcZ2Gm3JnvAIM?=
 =?us-ascii?Q?QQiCO+TqiuM/taN7OnEw5dJZwT+pkfcICRvSyJCT9RgqzrTgabK7BH+ucEmB?=
 =?us-ascii?Q?X5ketuNPP/4BoDp8hxDVB3GsE3UOw9KqPvH6w8CApu/thSEexoVLcIC0wjlH?=
 =?us-ascii?Q?SHcBSANGofCuumU0HbQ2OXwYoB06tc/MboSF1OGNqmua00BNpybnHBPGsGLq?=
 =?us-ascii?Q?g1FFK64+WZtIt73jpBfk94ABWM+hkoNZytxeK1vZ5XG7Ju+n7JNpoah4gCTj?=
 =?us-ascii?Q?dj+8R8vfzqDqMwUvdyXc91bhAgamEjfsVVbotJfkr4hqCjZdNkBSi3ZX+ETK?=
 =?us-ascii?Q?GYX/LRCswItYBZb6QpUcUqPbgOyyzN5FNk7TvYluFyZqPB4ujnJD3BjY4dHJ?=
 =?us-ascii?Q?dyczsXVdHEVmU4TC7KgUdVuOUXRs/Mq+dLB+nB7iR9OSRwYXMp6XUR7OAzy+?=
 =?us-ascii?Q?qVuhe2leP3J8miOardEE34vPhjX8plJPFa/YfAEDfiWMWvXchcTL3wonXqBw?=
 =?us-ascii?Q?50670WE76ynZr4ANCvLfKtJ2Qj6FQ1ftrCSmCxknUQR3OKdyKjvTYaZJTGMb?=
 =?us-ascii?Q?bP2Cq5gp3SbfMXJIWlFZxC/Lov3blKaqQNAV8pJl9AHrr+mzn48btkEjA35m?=
 =?us-ascii?Q?N+dgaxH76Xy1HRSaHkx8Yjr3kG+G4fatVSPbS6+LMFOEcE4per2JB8fV67Hr?=
 =?us-ascii?Q?4P5QUzVrLmRaxgpt74N6n9D1MHU8YPLgWrx2I3xBxXd56uISrsEbD9+1/zB1?=
 =?us-ascii?Q?fhesE5gdeuMuKvt085LK+Xwdck7KCSHPdVsMTGi58kRpB/q2s9VhgwE1QGa8?=
 =?us-ascii?Q?qeaSz1iwqdGQz514B8qshcZzg35EOJKTSrBhZsqFJ8zHsV608+MgL6gRl+cf?=
 =?us-ascii?Q?wGCdRxbdPipDp/szznwULSAOUlKpasz7acKDrAktabjpdE+ukSuqk9GqsAKf?=
 =?us-ascii?Q?4CwSGruTGN51PzII4z0/L5GgMzjhZ1hFP+bFzO0397SPsR6SbFh5+IvEan7r?=
 =?us-ascii?Q?ItO6/LYVuMLM2vq2jJCqMhJB0r9HucaQoAkg7Mc6Y7gyOrtv2JvMhPlTY/Om?=
 =?us-ascii?Q?Wx3GnPVlwiZM8wo2UmEhjUasVmvkZGa5Ol43HkWkdY8FRqOg0nth1SVJeZZC?=
 =?us-ascii?Q?spdwJ55RwYyuKWMZFwZcSs9X8f8YtvrfllnYa/31HcUWjYzBjXAExgK6ADjq?=
 =?us-ascii?Q?r7mfbRtOqMYJq2B0SqBF6Z14eCDq0SDxQL8T8drk1YtPmc7/J214huGGjR1D?=
 =?us-ascii?Q?wyBQMAwXHKfu39+OIbGw3zJlaMC152Cku7ZgLulswCgr7Jjq8/9aebC4zkfV?=
 =?us-ascii?Q?/9uuKraC+WcxiMbhOmO1WlcjjqoSuAFpq2xWTOfvIRJrDEASzXViUowWyy1f?=
 =?us-ascii?Q?0IW7tAxx/teUf1FJJH1eYpTQvRlLHam9A7lWKJQqWDiu9kaghKFxF4TmOHKZ?=
 =?us-ascii?Q?Bqe/P+Cs4L/6MZ8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zBmDklyMs5Ufmj4nHhPPJD3chBhdtsdiql6zIfuLRlKyiXA39DvDGCdtjMPl?=
 =?us-ascii?Q?lRuVIowKMwvyqKjGrQYkxhLmYGWTD589TVoOcniqjgY5qG+8OjJYn+N3clnk?=
 =?us-ascii?Q?aADgXiRH2KGGuLsAAJ2ixeeutWlX42Shnza1+27oylbeGXzIrId1O/gid7Cm?=
 =?us-ascii?Q?YSo0gjri1SIFinrW6PPtCUqM0d7DJgPPUd23sO6gn2K9gebNDumHNvKu57bV?=
 =?us-ascii?Q?RKm3+urQFDsuHqKzWBIKjWNWQZxuTtjE94KTV+IYBVhBHuKP6y0tT7fajFOw?=
 =?us-ascii?Q?e+zZeKEi/iQSLswhXJYJraheUozAkMjKox1xF/6SN+Bpto91PEbBKcpESDOW?=
 =?us-ascii?Q?wafrc9han/kFOWN0zN/BdH9NegONiIeAAwUHOWKeus+cp3F97hakEF9GxX9w?=
 =?us-ascii?Q?+msOVby1ov+azSWuVOQ6hKc2Jnbic8jUnj+KdJRke7zOZNthpLPbuNBajT1/?=
 =?us-ascii?Q?NjMCj5RCOfqoCatuoU784aJAl8frhGB08u0d/mMvXVi4817gCX1o+EIjpWot?=
 =?us-ascii?Q?F6XeVi/kjJuG8FGT1Ffbtsr6QePRKHA6LKpokgKFki3fCQm5vACihIGw9TWl?=
 =?us-ascii?Q?d3c7hg2+9r1zou1VmC0NyfW7uglheoJwtZP6R7NsS1PGW2I262wbzER9muUW?=
 =?us-ascii?Q?7vCvJIQZYT9d/8hifNBfA2KZckq4r/t1ADQU+k6akiAbnraEGMalZ980j3M7?=
 =?us-ascii?Q?WR8672JtRmwwZxddGYW3cU9HuCczEVYa2TCopr2BisYe/MojhKfIS1ro8RYZ?=
 =?us-ascii?Q?P1KR4SVH4gi9fYXg5x4lDUm1x/iR7V7MJBgF4A1i55MrApeaSgluqiZDU9Mn?=
 =?us-ascii?Q?1IeRLKQoUQ9khsxnAAeK1DktcF1O5XZG+okYjWpTe2rb8T+HanPaFrBSdidO?=
 =?us-ascii?Q?XmOuVEVXwDa1olCjz1drmtVJObNfsQ47voz4UekEZNRUgOsMThL+wFJtu3Cc?=
 =?us-ascii?Q?2RWUuDkhk3xNuPxSJaA8jdyppKwg3C456J74uM0RFLRaksh7Z5Eu8t0oo4LC?=
 =?us-ascii?Q?M3Gcy+A2P2UJiSVWdu6whSCGkc4vPffiHMVUWkTfUW/YlVbV0/QqiOS2j1OR?=
 =?us-ascii?Q?up7LnSGp2nz+VQWTx5okwO0zrEyxKhSV4R+anTcQrrsMdNb0ANQLPOFpBxrI?=
 =?us-ascii?Q?RDAj0Hvfl80EJmDdw9Zc6E/YUXoY5VpbWYIfR7AtLHZi5zJllqoUYymVGdkP?=
 =?us-ascii?Q?0FVtcTHNFGQ2a4B3oASqoERyQBbZy1w3qPz2ZEyomiS/an5LzaoABKWPvsDL?=
 =?us-ascii?Q?8jDU48k17KOr3l1Xd18L0+t/1hSMjQq+ntUanD6/0t0xQuLFlf2U5HCVJlbO?=
 =?us-ascii?Q?BKstz80RcEVi+YIyvy9Fz2A6ak9qxs5PHR897NCLAadaLBTeL0IRaejFuzLt?=
 =?us-ascii?Q?PUDoPhr7zZWOfd1zNaMStfS/ssMCkX36WrDZjZ0Xe3LFS5lj4uD9Fn6j0bzV?=
 =?us-ascii?Q?vYFGMZwDMGB4Z7I1neRe+Jev2D1VCG9cg5Pa5y3NvjWgwUIwBf5hGXtuSPdL?=
 =?us-ascii?Q?en8MocAZc3fvxuGSocUNxHaqifLoFrd2h9HOaM9Vj6zHFdiv8KznDegCiiIX?=
 =?us-ascii?Q?Pt2+krHrfA2mH7NFhKHvxRtEMWlhUDvaSHPP1+VefTpCVdtmaY4MXt0TdrYp?=
 =?us-ascii?Q?2A=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f34ebd2e-64fa-4f77-2bb0-08ddd3f83c5b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 08:15:27.6287 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: guL7Z1xTI7fi5ZeuOErUJT4vnzVmoqi9p+ICD3bPuiMsdHWITXyoZxNK49mS5v8idwbMNw5DM+a5evT6p8WNruXR69+3JBUA5+LLVmNzAxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6698
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

Use spinand_to_nand() and spinand_to_mtd() helpers instead of
nanddev_to_mtd() and direct access to spinand structure fields.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index f99568050fb..c16d3954245 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -236,7 +236,7 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 				      const struct nand_page_io_req *req)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
-	struct mtd_info *mtd = nanddev_to_mtd(nand);
+	struct mtd_info *mtd = spinand_to_mtd(spinand);
 	struct spi_mem_dirmap_desc *rdesc;
 	unsigned int nbytes = 0;
 	void *buf = NULL;
@@ -294,7 +294,7 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 				     const struct nand_page_io_req *req)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
-	struct mtd_info *mtd = nanddev_to_mtd(nand);
+	struct mtd_info *mtd = spinand_to_mtd(spinand);
 	struct spi_mem_dirmap_desc *wdesc;
 	unsigned int nbytes, column = 0;
 	void *buf = spinand->databuf;
@@ -356,7 +356,7 @@ static int spinand_program_op(struct spinand_device *spinand,
 static int spinand_erase_op(struct spinand_device *spinand,
 			    const struct nand_pos *pos)
 {
-	struct nand_device *nand = &spinand->base;
+	struct nand_device *nand = spinand_to_nand(spinand);
 	unsigned int row = nanddev_pos_to_row(nand, pos);
 	struct spi_mem_op op = SPINAND_BLK_ERASE_OP(row);
 
-- 
2.47.2

