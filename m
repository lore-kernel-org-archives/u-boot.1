Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F302C87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 08:19:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA8B88421F;
	Tue,  5 Aug 2025 10:15:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="B2oGirlo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83A018419D; Tue,  5 Aug 2025 10:15:57 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C2BD841B8
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 10:15:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AsAVk5CNVFY4BqULQ9L51myE4RRlGE+YZTSBtWeQRdCs5VQ1XaMvVlg/7Q2WRTOo29fQd3DVCy7TQl+UbMdY5hbSui04IuK6t9tzdW2xpCyI1BPpfij7FgJf5UNSn1ckOIM7AVqfGCmI7227OBEArB98DUN4OrVw3rVYyVVr3xk9A2nVTdNf0EGhmBjZg2FoJW9vf94ZNww1pEuocM4lCc2JNzGj0ZDZmR2tt/HtbeSpa+fdY5ocOaU4C9rdq91j6HDyhuBBbcGXafDOBo8ZEGPtFNHqfEHo5G9+QlfnYMI0BMFZjv2+YN8ohM64X45P7LDdeN1ZKa2VLVkmP9UVGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/fI6bGy4YeMo/8fwMRpD9DJXc8Id538oOnYwsFgeaI=;
 b=J7s+osBOaRIh7HJlhBHVhCZNqPQSelqDvbYfrHCRh/Bqm+ODubMM4KX0ixQU8KJm/8WmnYYRgkj3knd3I+GPE+ECLmmPzB4wftadDWUCaTokt1XlfwPNcirWhj0sCuqTd6FlE2addgPto1SKs/+DIrcEzhZdmt5GgloyugDZ+jy2LvFfwV4axqbdbqcjoNINVbvVH6/uAIa5UJa9PSixwhMe4RqXpu16fjmgpWga0aoNy+K2BkmqofEcjb2jLT6K1lPKCr5xuvk3b3BKKjHtnmu2HpHLfaMG+TyEXhi/gje51vklpLpaUZkWzfjIQtub3XaJFRUO7xXe329UIH2/NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/fI6bGy4YeMo/8fwMRpD9DJXc8Id538oOnYwsFgeaI=;
 b=B2oGirloXKa/Dfj0KZoLKZBmPSUy3JI+O6//kbSjWC3JSzWVPkF1O3tBtL0lHJK/GCEj1Nh2FxppvVWapBSqki3waYpSkLaRBHkZpYf6Oa+kZBnP+i/F0piX3FPR7ygrZOn7EHyYnN+qh8jOWR1uUKlhtPnNV+DqjmAOxR/RYt7C1KNj/Id307mI7MbTB58UKUaM6AbV4cR9SAf9TQ34QdWsVf7Y7o+cunx2oZvx1HkC2zx450wE9MVBlqeNQZLcJMN6kmGQBQi+f4h9QwAUk/HsfjUR9OgF2SGEOiyL27e8hmQLhEBZQ7MOMb5y8AfSaOx+n+PmFyaMcuGq0MQ49g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by FRZPR08MB11069.eurprd08.prod.outlook.com (2603:10a6:d10:139::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Tue, 5 Aug
 2025 08:15:46 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 08:15:46 +0000
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
Subject: [PATCH v3 21/22] mtd: spinand: try a regular dirmap if creating a
 dirmap for continuous reading fails
Date: Tue,  5 Aug 2025 11:15:10 +0300
Message-ID: <20250805081511.1482964-22-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|FRZPR08MB11069:EE_
X-MS-Office365-Filtering-Correlation-Id: 648ef2a9-55e9-4f35-b560-08ddd3f847a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mG1PgBmTeWk+ikqOiWNf8RNE+WM2ZrwQOPx0Cbyv9vIneeM/xV/9W/fNwtar?=
 =?us-ascii?Q?QuB2+3204koXylXNdJufMbwAxvACd1zlM1JlWcJIkacCX0TBIkmQG6VdEzeH?=
 =?us-ascii?Q?x1Rl9WiCJ9mx6oAmG32peNeuJUCVIPgfF6TANFS36tvJ4+5bl2T7RZapnACX?=
 =?us-ascii?Q?MBtKKlOlnep/h3pvPopNWMbvZeFzUyMOv/X/Zfujoocf517g6com9JcwXg08?=
 =?us-ascii?Q?HDTMUBNVCjAsBQKTBPPzOIUftXZIM5uIfsiX7gHXH/IxcZSMR95uF3aCbdvp?=
 =?us-ascii?Q?ZDqo7V8perVkfsAsVK3m1mfi943IW6APBHq0q9WFxpAk8rb01E6F+pjglLJD?=
 =?us-ascii?Q?FntyQCTEG2aU1TO0T577fwLobhj/j1zZPVcbzQ/2hGW37UP2yfzO/ZZzyf7w?=
 =?us-ascii?Q?HBJXINytN0kNVfv9sOrVc1oMj9f7rd1ZjhmjpljIhIjoyEMwFiT4EDoSyelF?=
 =?us-ascii?Q?Y2KrFntfqjxQOEMX/Q3ifTz3yQzeJLZPak0lnyRdAX/n2vn5y9hdLZLFJ3hL?=
 =?us-ascii?Q?FVX3Wx6yRa53K8mtgduYaFO8OEV4jHIw7jzGvd0hWgitfeY52aGJTrln9US7?=
 =?us-ascii?Q?GoWg2UFPfJRO9LvUi1V7/RClACVQQiB3cvaYda3/35/86unpAHMzhwx+GIrP?=
 =?us-ascii?Q?Q/JLMZFuRzu+tMJHtn/niRfyxjxDHe9urqD3hP2bsLFaCIpNgyKgNnYk2E+u?=
 =?us-ascii?Q?oZGdpENp2z45PvcLg9hofXgTbwD8M2n1Sl87/6hGAvkKejskZb8Awz3vjJAG?=
 =?us-ascii?Q?lTwp3oJzleK+Ua1pNFwllCATNTqYbZBfuAS219LKxh9IS6pkjBPFkiiXUsXn?=
 =?us-ascii?Q?ILA+FomXxf2OW2EOdT9PUwnHbqVywrs4WmCLps1Pad5tDfbL678FvSqFVnP3?=
 =?us-ascii?Q?SUqvIvYPzbOjVtiDkgAdlYPAmDEXLmuAXJj/Vw3YqoX9uZUhmgkT9O19H+5N?=
 =?us-ascii?Q?v/qI6TYbpb0x7rcv5XXrRk/btOL9iMBFrrCEncf1ruXoTkicVJNT7Uz7kB/C?=
 =?us-ascii?Q?OhMZ7ADffnf1qqF1QBTBPFHaXFd5xJ4+H0UZaJriu/ILcEjp6K5U6LNYxzIT?=
 =?us-ascii?Q?JnZCvFDbt/F0Zs38aNBKvtH6/FMulUZgctoB3i3mP6xDNM+z4cMNgawDObT6?=
 =?us-ascii?Q?nJIFgtv6QBkdDCL5+khoh6LB2ifpS/AViSOefQhUOAi/2AVNkVXRxcEkBZ1f?=
 =?us-ascii?Q?p4WPCc55piCDYrkYtdgtNDijmrneJVJCEMSrS2KTZIPSYZM3pGdQQ1rDuCwq?=
 =?us-ascii?Q?qse+z9Da5XYYBkc08qu9Q49sh4hKK2jxm3SBH+NgTin2umGIpkcWUIOIfVXI?=
 =?us-ascii?Q?l+QpJtdy2eyrlbz2PpJ39qsi/+7N4Azgh2CfIh2m13z5Fla4aj5cpMBkk3pN?=
 =?us-ascii?Q?Guy0UGPbEDuXjroYGtlODKcBKC5Z75TYcKrJEwDR2sXduRFsSKL4sIHoGEpI?=
 =?us-ascii?Q?/+XMwgBRciueUKdcNERxz17I80ubALpSXx1Euomc55rS0PeYxYehTzvr9WnW?=
 =?us-ascii?Q?tJt5HvyEmPOLW5Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a7XA3JpkUoqv6VNhGbkJs8D0b50nwWXqo/Oq/FScUcB/RrHMdRPvk89BYikY?=
 =?us-ascii?Q?no0VQylIgrWsMv/eRgw5W/p2/GuXZfIAXYwUyQkZr44iDc1Ad/P8+qxoWfFN?=
 =?us-ascii?Q?UK/e7ZPpRPpyZJ6ZVtmlxdEC9WMMLL5nUgYH7wCwDSQqHiFxVdGnj/OZij5q?=
 =?us-ascii?Q?fMltLCi2rdNIKaFEnkUSNSFgU3cSC1/Uit0jHGVviod0zZC0QcHxNF1wZ0+F?=
 =?us-ascii?Q?ofYpNnQ/F2NIr5Yg5wFQ7BYSyqPvPspy1H9WjukF4DTW4hAKE0ZnlLC+yfW/?=
 =?us-ascii?Q?j7mlL7Np+rt73FEpCvWWIEtNHN8GG1dfbzxYjkC0HqJHifd9lzAx8TKJN1VL?=
 =?us-ascii?Q?52KG3DRZmrGzBldlhdXQpvBrZx/TA+R3GH3Q+UzQThc3mcz2Pv8Lbr7ct0Xm?=
 =?us-ascii?Q?vx9XmPJfqj1RMgvkvlPaXu9OR4/8E/XNlXMYrcRoxZ0bDlbVa6p2HrrP2iGQ?=
 =?us-ascii?Q?OFyV9O6Hbyll/bFsYmXT0Oo69VKlLYz7w+/AH+NSuelyzvj8SZDYnWh1V7hV?=
 =?us-ascii?Q?apu8K+3qzl8G6ty0trGIiHD2/6glTK4zz9eGKHWA2ll1yS8QaEq5JlJplvtz?=
 =?us-ascii?Q?pgj+RnfAG2SUTY7mN31w0kIGVFoYU1XEI2gcHoEFuTVMpX06Y7hoEbHViiui?=
 =?us-ascii?Q?yeIJzGgbaTgssRqsvTK1G2GSZBeDs1xHa+g33kw8mDtVbQjIXdEiChkGrT1W?=
 =?us-ascii?Q?ZauG7vuTZkppOn3jtVNLpWhiEKuwG2XubOQwVZ6LQgs5SOSPSiIRKofDpK+4?=
 =?us-ascii?Q?l49KySU6ehF4YGwcfcegf1Giu0lMK01t2t4H3EG4D7d4Df59kWcBPWLkliKM?=
 =?us-ascii?Q?PocP4qvHxdIKSqEdegMUOvXGn1HKEBYf6j+UM9ILz+4GmtyQckm/BFi1lpnN?=
 =?us-ascii?Q?xvx4XIO5hYat9SiAheDo8IFyFYi64CulFG8ALU8tSQSThoB3UkcpgVG/d91S?=
 =?us-ascii?Q?KpS/JiQciClLKY0fuvwiH/y+yxqYOEoNVD8glgj4iWUdpV0PCAIuMdsHKv7u?=
 =?us-ascii?Q?ZPHFa7e5r1JhjDBrz2H7nj+EppzgxZuru86jwSTtrr2JZo09XwCVmaiGmvow?=
 =?us-ascii?Q?AhBm5cad0xCIjLbCIGJboS2H61Z2bwwKAY/t16xriL7rmfYVW5AiBKkswx3d?=
 =?us-ascii?Q?R7ycv7pNjEb2SahG43rVIL+f19u86wxMhWkK2s9GZDIqUpS6VWYixCP84Gdw?=
 =?us-ascii?Q?VUaGpMQhIkPlVEOfyA1pvNYE4yGgWWblRihZuEwuRiu/FTfqfdidH+PBPfnr?=
 =?us-ascii?Q?QolRI3219nxEgl2M7Yh+tycn048bYPXgz3Fz9ovJAZXRa8fpJLd2jYqotE/z?=
 =?us-ascii?Q?h/MHcgG+K5+Qy7h8QwIMO3vreRkQkZKcqa76pDOblkzO3LLtqFvqyVvjW5wi?=
 =?us-ascii?Q?fXTuBRjd4VXe1lUVwrnvxQIQ7ULXSbh8p5Oq4KIArJvqCBmjUT02NPefkLPZ?=
 =?us-ascii?Q?h1D2OowzKIcyr+0w+0sy2doIVKv77sMq/GKG5fv2kmb62sMn84VL5WOikN19?=
 =?us-ascii?Q?Wj8QAWQe6z7pBYcFUinf/A/bA78J5bKnMHBbF0ZyFjIrpp4b6csXvZPEg1Jn?=
 =?us-ascii?Q?qlIuaF7AOw9kkMef9G2vVGZTiRNOHh6qjHljhupFst1MyPJQ9k5scv9us+P+?=
 =?us-ascii?Q?qg=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 648ef2a9-55e9-4f35-b560-08ddd3f847a8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 08:15:46.5916 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ey6BaevvlTgiuS7quisBvXTXEx709mTej0CaDgXcLjZdtHrqYl/uiapnwyH/YiUOOObu7w9PK6fU8YZq9ldd/57Np0zRbJ1i6H/jt0DiOig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR08MB11069
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

Continuous reading may result in multiple flash pages reading in one
operation. Typically only one flash page has read/written (a little bit
more than 2-4 Kb), but continuous reading requires the spi-controller
to read up to 512 Kb in one operation without togling CS in beetween.

Roughly speaking spi-controllers can be divided on 2 categories:
 * spi-controllers without dirmap acceleration support
 * spi-controllers with dirmap acceleration support

Usually, first of them have no issues with large reading support.
Second group often supports acceleration of single page only reading.
Thus enabling of continuous reading can break flash reading.

This patch tries to create dirmap for continuous reading first and
fallback to regular reading if spi-controller refuses to create it.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 07ea66825d5..e9ca2b3c391 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1131,10 +1131,30 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 
 	spinand->dirmaps[plane].wdesc = desc;
 
-	if (spinand->cont_read_possible)
+	desc = NULL;
+	if (spinand->cont_read_possible) {
+		/*
+		 * spi-controllers may return an error if info.length is
+		 * too large
+		 */
 		info.length = nanddev_eraseblock_size(nand);
-	info.op_tmpl = *spinand->op_templates.read_cache;
-	desc = spi_mem_dirmap_create(spinand->slave, &info);
+		info.op_tmpl = *spinand->op_templates.read_cache;
+		desc = spi_mem_dirmap_create(spinand->slave, &info);
+	}
+
+	if (IS_ERR_OR_NULL(desc)) {
+		/*
+		 * continuous reading is not supported by flash or
+		 * its spi-controller, try regular reading
+		 */
+		spinand->cont_read_possible = false;
+
+		info.length = nanddev_page_size(nand) +
+			      nanddev_per_page_oobsize(nand);
+		info.op_tmpl = *spinand->op_templates.read_cache;
+		desc = spi_mem_dirmap_create(spinand->slave, &info);
+	}
+
 	if (IS_ERR(desc)) {
 		spi_mem_dirmap_destroy(spinand->dirmaps[plane].wdesc);
 		return PTR_ERR(desc);
-- 
2.47.2

