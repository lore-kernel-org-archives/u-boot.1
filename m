Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA55CCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 12:00:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3D1084230;
	Fri, 10 Oct 2025 13:58:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="GnJsiNm6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C52B841F4; Fri, 10 Oct 2025 13:58:53 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 333FE8421C
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 13:58:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WSYoQ7SfHbEsdTQ0ctQBu4r/Kdu7mMY8LaoVqgcJQFCR1omWW/c3Zj/cq171qlfmXiR26UXC7k/jrR5HK9NFf6lUEcG+YQmRr7jcn4rn21HyfOdmw7L252hUslp/BnKrULCpteY7FbDQ3shhyFGGyFdkCOZARSX80+Q/7xkknquHnIvmn++DhEHfXkQBFwAS2vnYTkWr853YaPogtvATNi4+cueEk0TXEGcPsYdWjufFMQN4AflCSI4eOVg3lx9yKgcYyh2z+KTmKmk+AFJW5twMkq41lrxcKL/4p9gaQTvk/mQ+NgcYmP/D3AhAU5URiACwl+16OSflh4Z1PyfgbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJLrIXolFxP7/FYyWDMDU/p3eOzQ17QWLLzE23u4eLo=;
 b=KEoDIvtY0VAOAJ6pzinknl+qE/9D14wRvNjobR7qKURK7M+iRfuYVsmdlTX57OQpMWz19GPwYEST4WSgdOB/T65Uz0DEskSVxmgmDKtszWFBh9RQZSCdPVM7G27jto0BfKEsJnLL3EoBMoTgZVwEz0J6CD31Usbd7/WH+wFrHvMMm5lzUIO+lxrve3+f6BGzi+mT1Mbn/GtueXAiwhJqwHgulj8Vgz8sR4OiD3KJsJlbMAm4jkotYfBvc+QwJEoIGKM4p4jH5o5Cci+SYVI0nLbIejtrQyqQSCJeTWMJGD3zXUhJ0IzqMwbulCWpclslkzKSh+LTVSB5989bkl/S9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJLrIXolFxP7/FYyWDMDU/p3eOzQ17QWLLzE23u4eLo=;
 b=GnJsiNm6w5Yp/UCIfaFRMuV//aR78Rcx95kMi2CFYbb9t8nA+sOwT2P7sN0cIYfLGZJLjQVR+Entbq4ag6mmA4y88dMLK5BaHJIUF5XJi/5WZkxWX4d1Qp+leAsrjWEcBsrxr4Gj/l8ciaSmO7Q4YtiUZ7DTez1udlFBLZM10hapfhMCWGqPYe65AcRiJpgBxz774jFiJkpVUvNJ9AzjoFmvXRWa65JDtrUhSaeUfKozq9U6YcG3kTUWtTfdzduYUpePYMWFYnE+oCkQzYYuC2MQmUyYPaH0h0x2x0tAnPMDLlS4XHM6ZK/wiW4TmGFS/FqMD5KRUN8h5T9zqyhjrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB5586.eurprd08.prod.outlook.com (2603:10a6:20b:1d6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 11:58:49 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 11:58:49 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>, Daniel Golle <daniel@makrotopia.org>
Subject: [PATCH RESEND v7 11/24] mtd: spinand: set bitflip_threshold to 75% of
 ECC strength
Date: Fri, 10 Oct 2025 14:58:12 +0300
Message-ID: <20251010115825.1531775-12-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010115825.1531775-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010115825.1531775-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::19) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB5586:EE_
X-MS-Office365-Filtering-Correlation-Id: c3aa0272-490e-4532-58c9-08de07f45f62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|52116014|1800799024|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5JFvCQQennvaJ110X2jYPcoFBTdWh4TtfyCbD+J/olrST1YtgCKPA0ZJyPCH?=
 =?us-ascii?Q?ZKSK/Nu5oBv6AYxFHNhZAUEKmJp7fMpuxa3ssO55EmObglumZBUk1ix4pdgN?=
 =?us-ascii?Q?6RuSaCg4Bb3pf109A3djuiLe8IjnRLdQ0r6ng0Dzx3maAHDiGHl4AfgJWV+G?=
 =?us-ascii?Q?o5Pw51sYBV4mRVY69stx07Hg/zZFv/DqugFJW4cGktmX3TcpZkNmggwChCgu?=
 =?us-ascii?Q?2aTdLNKJrGfndMLjMldytud5+yoe5WNt3NYCacSVa7L8PhIKIet+Zrj6qb62?=
 =?us-ascii?Q?y/JLyfNey7OjovhPJ4jp5LeQZen4pooXY8gZ2Y4Fe4mUTygX04lsNrmmtT/p?=
 =?us-ascii?Q?SqoVYwyeAyQnzQpISjyLtKTDCy4y9QyFX2HhiDCWu4IjF5Czvdrl3/VmKJS7?=
 =?us-ascii?Q?YdGkf78nlwm7bjRntEv1nIyfouxW9h0Q8t3pkZW6pDggCV+r3Rk3y59rRaUh?=
 =?us-ascii?Q?STOrHOfUR9d3sO146YM3WRJGq0D3oduCAtRi3FrUpu2l3AWGc4jBivFes4/V?=
 =?us-ascii?Q?SY6bmtNFqdN7dtz1/EJHTBgQDBHOKcMTvOongnCoLWOv1peGDWZ+2E7mKsP7?=
 =?us-ascii?Q?lK7UIyoN/k5Q9WxvTebqAf6RCQXphX9y9i4tZHp7ZKLS3GMTgsIoCU5oUCpb?=
 =?us-ascii?Q?kUZ7Uo7zscmbH1kA3872ETxm5VBD4qoTNk7+sj/6CfbxYVrFuj7B8AUJ1U7f?=
 =?us-ascii?Q?V0DNzLvqgrz0MGbKK3PhrFIZnWXbuqbxGSw9GMbmA2y+n5OOy+Xb7A4plgkL?=
 =?us-ascii?Q?V05sVCfl9JYLp/xPRiwLXL9tt7JjjmEegU2zNLoy07AMOcqpHBMpmuqqnp9k?=
 =?us-ascii?Q?SiCebzKJGCLXOmzhOYJPeiHe3EkcCIFnc/vzB08McyPq16KB7tDY3KCV6jLm?=
 =?us-ascii?Q?Hb8lBPyrOdxwBnLUPcFMubiCyTt3CoY6UqIWsB92mBXiALaaRSUJItxgyjF/?=
 =?us-ascii?Q?LrwopH4aANwF7zJXkwnoA7VvqBW9jVccoqQBo9npfYnx03TiILJAOoABjTMf?=
 =?us-ascii?Q?i9h0KF5ownpeh4UHW/XdWODFvZHJQ9rg4zZm6lWpvyXY1VVvRK7c6B7Bf31f?=
 =?us-ascii?Q?N7XPY1aKr0EQriPY0QNAhUfRxP1f1T9KMQq9wJg/rAkoerVnV0jK+eCwJeMw?=
 =?us-ascii?Q?Yy5k+7y6n2qSYdubUjkgkQieRUOOg8TFHy55iUrN99crwCkYB3cgAS3ooGQ7?=
 =?us-ascii?Q?CZ6f+2Qu3Qm0IhGVfMT+o9ktv3Tip96UbrDIfRj+q2k7JZ2a+xuPAWdTz6NH?=
 =?us-ascii?Q?4Ax/tbCk2W2gPoFzT5UcfGQvco0Mw0iflutCCgo9MssJ6sa/kKWeomU3heet?=
 =?us-ascii?Q?CaJpVxdqOHjPwOh33+krFakb5m9pt50TPahVcO9hb2l4OG5ryGOGQlJ4DOyr?=
 =?us-ascii?Q?Dc0kLVnCT8D7UTs2v27ZmuRjBcvo3l2dmFN/Bc0Q+O44E93xPbweOfcwbG1G?=
 =?us-ascii?Q?u9QTk+nOSbBehN71dgZeygNN9Wg9Uek2dgBOdiHBdT8kXeJKIdGt/y4ghapG?=
 =?us-ascii?Q?NhnicPCCl7YrOhkU5SCILndJIK9cTtS3nwIUnjzhejDXoZ3PrEUmcGgchg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(52116014)(1800799024)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WNmq4A5qOKctQicCIXyuHq2/WwEQKYA3TF1Sm2iEY3jZsJlb+Wful+aezBlp?=
 =?us-ascii?Q?2Ls35ns0t8lxG3Kj63AI5wtOeEi2ZvlVKMxNyDGufD7SFx+eDNz9YaBzWaVw?=
 =?us-ascii?Q?ZCW92GMHm1teeOOYJbTWg24kOfq/Hr0AxdChHc1Zoq+sVqRJl6HAxIImi4CD?=
 =?us-ascii?Q?dDG2forIHzA07BVms6Hh3j6vVbJ4Je/QxjdUCcjX0ERsYU+7PHO7Y62bIUyB?=
 =?us-ascii?Q?8oDNWLT8LBkTSWrOR5CNabHbl9NGGGa22WZ/sSEQTQcC7sY4edNDKRceld55?=
 =?us-ascii?Q?dfu45KrKtK/V2rW6DDfE5hY5/Smq9c44dje2WlACZcyzRoS5p50FHxHOhm2v?=
 =?us-ascii?Q?1wuHjXeQVg7xqXF7MS9AZmE4TunN8kjgbY+VxQElCPi2ncmryvv7oQ14LHeh?=
 =?us-ascii?Q?b+m5j4625L06TlHQPjp4z5NWqdLllAcm4CDhzZrL8il3xEXXZ1I6G+PPUtAP?=
 =?us-ascii?Q?ZORRQHom0SuR00i+zN/98ZHXG9lHIgdsAiZLtKPbWp51zY0RBIevD4pNJ/on?=
 =?us-ascii?Q?bVLAZng5wbJ05J2r0v8MiEfGsQEWBwr4Ax3HQDaaV5o1hbXzv3SWQjNdERbh?=
 =?us-ascii?Q?XgciJgABDJevRCI1xplrCfU3P2V6sMA40jH0i7XfDx+glUt2tlgTEcf87kVU?=
 =?us-ascii?Q?cCGzd8bW854LfU4mGNrr/ymmqp506m6o5j/+eKn2Ib0Oohwc3CaMYp0MAAlc?=
 =?us-ascii?Q?llJaXuVA/NF3HvJBkS8MtJSVdE1GQvUoWWr0L+FrVP0Y3VfTJnb5gC7m1Rw/?=
 =?us-ascii?Q?XSfGsno0SWBx4qf8n/mARGBuWaP7JejVyCpRjoZzFvssPlFNH+M8eyE7JEMy?=
 =?us-ascii?Q?inynE2aEkYJsw10maO147RVPqW/b1DQjJ0+arBAnbNjfG/8fn7g4M58bloFu?=
 =?us-ascii?Q?RmQdF3VnxOOjZ5vTNcLZEVrMb7AHnd1yvaF3NGUr9pWozCjf3vvBozQu8oDv?=
 =?us-ascii?Q?yGyOePrB5QwFqrTFZTuV7sr2J9+2VJGQd6VN+QbAE619j37Tv7sWHL+NM+lP?=
 =?us-ascii?Q?1tbKObpgNeap5UtW+h6cn52Gm0/fU1dOJUcrw1SQBt8Vk2Rjcj8GEuQb/6Rb?=
 =?us-ascii?Q?9uA4H2RlS6lRIaBgcZXqNJITXh+MjunnBC5XhhFL7wLFqUnJFAEvy4id0YUr?=
 =?us-ascii?Q?79zdbHpIxCVvHMOg+sk9Du6tyt93h2/fs4nSP9bxxEG6X6U1NsulyXbjvrl0?=
 =?us-ascii?Q?pICPEfg6okTc4SBiQbD33bXGPyCxtCfF06QS8/1xVRJrFeGECErs22lwdHyC?=
 =?us-ascii?Q?nYWSJdtEoOX2vYdK3agJ/8OJuDlil0R/piQBUFmRcvOS+pKlZUFWuUKFQKF8?=
 =?us-ascii?Q?TkiVpn3Sj9uKf+M0/8HGNBqCtB03SzYgKZUOLgMV3eytgwK8TMaQl3JlTFEE?=
 =?us-ascii?Q?7bd2T7INzJ60/Jr388Ka3ilm09a7Yu63uysfmdCfT+iMtotRa0WcBYr9Rkib?=
 =?us-ascii?Q?AfpI5PAK91pYsb3mIiTRpQziR4VZVeYVCG/zRYuis1jsbpGq2Gz1lgpRN0Fi?=
 =?us-ascii?Q?WIZbs3+Iu2NEEDwMJKvvisv+bFcIZdV4L9KJL4JSEKfKuVUuMzlUbsu33f0U?=
 =?us-ascii?Q?FXM1sBm87BYLyvMng3BxaGU3d/nueQWN1qY/oLVuO/F+NiFVHd1SvqTfbclV?=
 =?us-ascii?Q?DekE4WjQvA8LUdPKdTjlIAU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c3aa0272-490e-4532-58c9-08de07f45f62
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 11:58:48.8979 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lOM5QHNow351FbdTp80+rHE9xWJDe74xliHnnVC/TseiAsrxL5XKr4DKizU3Vh0UpjJ63ALgPsdsNgvS1VaCunk0NMIiNCUib+UQyDOyrT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5586
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

From: Daniel Golle <daniel@makrotopia.org>

Reporting an unclean read from SPI-NAND only when the maximum number
of correctable bitflip errors has been hit seems a bit late.
UBI LEB scrubbing, which depends on the lower MTD device reporting
correctable bitflips, then only kicks in when it's almost too late.

Set bitflip_threshold to 75% of the ECC strength, which is also the
default for raw NAND.

This is a port of linux commit
1824520e7477 (mtd: spinand: set bitflip_threshold to 75% of ECC strength)

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/2117e387260b0a96f95b8e1652ff79e0e2d71d53.1723427450.git.daniel@makrotopia.org
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu> # U-Boot port
---
 drivers/mtd/nand/spi/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index b5daab21743..2a2ab664c2c 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1291,6 +1291,7 @@ static int spinand_init(struct spinand_device *spinand)
 	/* Propagate ECC information to mtd_info */
 	mtd->ecc_strength = nanddev_get_ecc_conf(nand)->strength;
 	mtd->ecc_step_size = nanddev_get_ecc_conf(nand)->step_size;
+	mtd->bitflip_threshold = DIV_ROUND_UP(mtd->ecc_strength * 3, 4);
 
 	ret = spinand_create_dirmaps(spinand);
 	if (ret) {
-- 
2.51.0

