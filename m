Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5530C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 08:29:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D738889A8;
	Wed, 31 Jul 2024 10:28:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Al/s/nLi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED23F884A7; Wed, 31 Jul 2024 10:28:52 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20720.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::720])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 104F188982
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 10:28:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQUKaoQxW4dhfxPJGIScSQLTtPVNoMHbR5XNlWdAobPgdeeOvOO0qU5xmi23BwAfpwHRhFhjfRANw6nxzWAgpxVs7s+DQPX8UAag1kLu/03uQAxbH+TEEPIGtC58cLQ3tInvK6qsyTH2TRC+hcbmL0OE+AnZC44czDL8cbz1YEnLPZoSk6ZFAC95pKJ+GffHl3m9o0BP0Spvb05StNkwaB8aZT/lnTGSY6SsEq050cwnt7RnyTxVWEO9zAaDWWcIUUIkVJFyO7kMR/twUMmfCI/F83xv6sZ+NnE7BWxtSrFjMjuDUT2mhUaZ95evIKmkDaP92Dy8dcPIWxrlErBxPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ao3WAHGgo24qvwCOlX3FPoGCFDYUr4WWIipL7VcPe+I=;
 b=MvVe+ubhj6133umSwfPQvrXI6xMTzw53JxUmj5ps6fGXdQft8P9UlmAIlB1p2H8S/mDo8kqtA7nKFIXCi9SD+3cscOJmnF0w0/6yrOBt0CeSiJ9RcxvBL09jbfGGio1OjbIRWtqNN+WxDNfdcrfQy4FTxOlAthlXNB1g/+yE9aLeBZ2hlHreA1SRv/OP73v+dkB2bFLPbQp7EPCphzdjrY/CXmkmmrhpTwE3FrcCoxI2Qf1prNT6fkXg5rDbl+/I1vjKzML50chpWxz+fQha3u/HYO320k/BTWfv7rltxUCKSEj4AnwQngEKectp3ciR/LcnABU6JgzXjlyKDD0D+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ao3WAHGgo24qvwCOlX3FPoGCFDYUr4WWIipL7VcPe+I=;
 b=Al/s/nLi6fLdikNpaiXgH+TQ6daMuF6ZR1ZIFGhnrvPQNxLWvWjZo8G0rJ8CY0LAGyezYqEcINT6AGkdnA6l/+ZDnpdNKziVRMm7/VybLUudGlldysf46SxmRqyyoSb7JtaG8zZH6ussCxs5FsijGKApdEj7KKFvJ+QVSVwn5ZEo3nP/Am6USnkQXh9JD+FiwJdL24smRJgkV/CLuFq/fEVm0rks6xwK9XYIMT7Bd48VHQmHxDl2Z2GqYjL1gGJR8ZRQ6ZduCWr/a2ghfuBoGjMiVbP0BD7XkgoNm86Ey64JXgFyv1qgOSGOpywbW1sqbVE1ALil1J7TxaAvWtibag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV1PR08MB7827.eurprd08.prod.outlook.com (2603:10a6:150:5b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Wed, 31 Jul
 2024 08:28:49 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 08:28:49 +0000
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
Subject: [PATCH v3 05/10] mtd: spinand: more use of spinand_to_{something}
 helpers
Date: Wed, 31 Jul 2024 12:28:19 +0400
Message-Id: <20240731082824.3890809-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240731082824.3890809-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240731082824.3890809-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0103.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:348::11) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV1PR08MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: 73ceb48d-afeb-456c-db65-08dcb13acd3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tAJr2i98I3BsEKJEgud7reVa5L+e3dw+YYas1nkO1C/FdgkgkynuqoLcIaU4?=
 =?us-ascii?Q?o0Y1MyBMkiJ7FSqIgjvVZ307MHXdcIGcakd4Jhw4K6W2geE0SI8lHZ9iKdAn?=
 =?us-ascii?Q?iFtO/BSGMNiQNHCJwrGsbNcCrj6x8XKN7ZZFL+//qCgOCNwhOpqbuDLdEALm?=
 =?us-ascii?Q?JwZTfpMenw6MB6OC3FC/H271X4sr5Aa1mFPPtQ2hhYojNuBycffaFPnAkiUc?=
 =?us-ascii?Q?2QTN/YMwYO535WId42ayVeOcEHhtnhyZYoRPRXEiP6XUaipV0+Rrr0BRi/4u?=
 =?us-ascii?Q?F/Zm110pVqEvz+2tQwapSqPa0ds+TI/qM65SVJSjPPekZUK+fUlydfq6Dtvx?=
 =?us-ascii?Q?9vdiybHVVN0A6KAxATs38I4e3cxVRgT7fW77fg/5xo70OTzmE8/uPPYDNmAV?=
 =?us-ascii?Q?DvHdkv1foqpKumTYiwWrnBeZfinGwOE+XF4dt/SND7QxHhCOd6qn25mKSv7e?=
 =?us-ascii?Q?uhe4JDYtD1JeCW2id+yf4ZE3gEW9Oc5Fx4R1rN4BuIVo9lQ1FwBicI/RjpgU?=
 =?us-ascii?Q?IvCj1xpP421uqtrj6cieTQJxqiiMn9TZBOQC4q5wq2RfGY4C0mFLl0xU9RME?=
 =?us-ascii?Q?YGUPbsVQ5iP8uiqW8dAQgPOHK1HPQmKGR6IQ3sHDgiZQMDhZpsZPft1jb37T?=
 =?us-ascii?Q?Br4dotGwwqNG/oQcoVmhJdiDxAlR/WtO2vca6WuwSYPCr7TgeA1CBG3HK69X?=
 =?us-ascii?Q?uZfQjEXdR0t1g4K/KEa0YdPTdp0FBODb6YJo7W8KZES+ja1MTxzqvNCjv21+?=
 =?us-ascii?Q?oWmg6PW28Dhpre2aRlR+gjyD1sZm6FwCPCdpKO0Xg4kEwSnk3V87jaGv7tHo?=
 =?us-ascii?Q?NaQ8S0NPcZpvW38j6hJMSD+rvhbi/oAIP5MWMfeXky/OHWIU51FJNWKO9xud?=
 =?us-ascii?Q?qKSOspfpK3MAWnbxWe1Amj3PwopJwa3OpGEfe91r7Qnfzul+75BuEVQLV3fI?=
 =?us-ascii?Q?foNjmqLf/MwBxJAtC0LbJrcdc+yPem4GQQXYEEMVpj0SauqekTI3P8kUEtcH?=
 =?us-ascii?Q?F2VJ8hkYvZUNeIuBAgCHzxymkJrIT7Y9USVo80fPrHKbbBGshZ8cG6TQ9HWW?=
 =?us-ascii?Q?9ZOd9lCojUdnlFvKpJC+Eiq3zvMN9hAeUudiz8PcMEwYPwJCULoZo5kVwR0y?=
 =?us-ascii?Q?p5q06XtTiFcCWzc66Xlhg0o/nGUjeW1qLSCpU1BBqsNKaHEXvAp/UoM1S7Ul?=
 =?us-ascii?Q?I/IGWq6USI2ieYVCJsLJKZBf28uT7AYL8hfyWTPDVUAfrSNFWCa1OoR0aixQ?=
 =?us-ascii?Q?8rX6R3ptePH83knnLlSJMcRvyCu7UVyLZxPfct38giuFYADVnqkI3nmqvxwa?=
 =?us-ascii?Q?aEZbrYH3WaaikR7b7rm2nmKpmxHGOhatqPSDTksyEu3MiWIs8LevLzozJOoj?=
 =?us-ascii?Q?qScRxMedbI3+pBrx966eQS3DMnVdSLmS8XFG5EbdfekLaVCc8h8IpatYQgUG?=
 =?us-ascii?Q?1+OLyzWrNHw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yol5PClU8AbauhuT3xbjtxfsH9Svsm8P0Etxy85P8PhnS8I5hiN83h0xvoAQ?=
 =?us-ascii?Q?OiwNvdtneWdXlq4Uu2gkrn33zue2JUv71YJw4r/xrZ27IQ5o9V05rq8joBT5?=
 =?us-ascii?Q?CVwwUF7/pvTJ3PRtjJMsiuuN0DjnVzlvx2WXrW2N6zL23g9Cp0SGTEfyBPlT?=
 =?us-ascii?Q?UEgvLLs1a+7LGkZqxGe4Tspi121ZgQNTafXnf8DtquQxoUkGk+5pljqvsAZ2?=
 =?us-ascii?Q?cPQKbrNoLEKtuaZxd5qQN+P8QmaHEOZZ+piDQ+HpRZRzv8mONWcmMlSIQHzO?=
 =?us-ascii?Q?Ke4fKzkviE13qb+s5FReQfYZqC3woZppXNN09cHrROe0t12NabwUxjM+SNeq?=
 =?us-ascii?Q?YA9iq+FjWWPBqXWrl8BaYtlUaR+GFkwLb4DhZb9/jT4b+9NDa+8isq9UiET1?=
 =?us-ascii?Q?hf1Xpc46xLGUonWnCgIaWcfZdYhXjfWUGYVP+JXczB7bfqEVokYE4Loe3zOn?=
 =?us-ascii?Q?w+lL2qliN4eryyuaLBF72KFMvzxygiZsBlI2SV7/N58PTxcj/HaQwXhSKUSD?=
 =?us-ascii?Q?FhsuXKGYSkJGRm7diyXBB64rdgnmntzLuDcW9bcz43YaqxwPeTSBzMGyuFok?=
 =?us-ascii?Q?3vy0/q/m85yORMmQj2B6q8DH42sCWRQ9RVL21pfYeYdCHy7C45ODJYYnYHXD?=
 =?us-ascii?Q?2me6DHnsGu3/+jeJyy+x4FzgmVdJkejeV1vVHA8zsyHipu+Bc9UANK8NOqf0?=
 =?us-ascii?Q?p/NBNbkxfWQQRqagYcS00B0dXnQtdQln++lklwrMTukhLGrdhq596xEL4Pam?=
 =?us-ascii?Q?Wm0sSWrNV5NO2kP3Qvp3MZa5+Woyh8pXpGV/m+1YJqsmQk+2RtvpQk6TIAp2?=
 =?us-ascii?Q?c5dg9tUPlFCfGflhhn5wI0lM653qqpRODGJuAQZN7FIN/sWStzpTE6P+z/Fo?=
 =?us-ascii?Q?QW9RGLy3qJ9NEx1HACb79iaMBpQfCPrX95WolQxExJ6Uen2BkTwx4XeOkz1O?=
 =?us-ascii?Q?VopqhZb+rDIq6o6J4fxVoG6f2mYnZMYeIVdRMlkvBUAXFn3U460/lQp28QWm?=
 =?us-ascii?Q?xYL2Twzdvn6KEAEOnGsaktO5z6LtwmPHv9j3Of207ZSnsIBQLjWAv0JW8rs4?=
 =?us-ascii?Q?DOkMzjTMXdgvNOsg3TOhjIBlRwv7UsrAVl1smAl5k5D8r5nW1x89ucZPUETX?=
 =?us-ascii?Q?o7drEn09taIgo1i93LCvpK/H1u0IsMPN0ycgNzyWqFP6gP9rmoWQ8LGBNPH5?=
 =?us-ascii?Q?pKS9a2eMjXiG8u6jKm09A7ws3D6T0VwpWdbwWby3S1vkI5V1Zc7fXzl4cPl+?=
 =?us-ascii?Q?KSK01XjDE/rmUZlLLrHuuop5KOr9ehGEoKNbabeCjo2jb+K3BdGz6F7tMYjZ?=
 =?us-ascii?Q?CzKWLc6Q6Foxakac5R19Jk1w8cXEiKw39be/7h1NwqPZR3xed7/3R/1QTmFT?=
 =?us-ascii?Q?r/IR5ffA5dqwrlIM5O22zO5/cWbP5ac3C/Ksz4fMcQ9W/q5x/QR+cWYWWDlq?=
 =?us-ascii?Q?z6apyX6+RC6YHijcCThF4NAFqNhtz6dgYZNZlj6hTjbSq2/jtxQ0OcYkLRpn?=
 =?us-ascii?Q?oF7544wNHtkeFWFa9XY9qlglzSC8bzEwI3G7XQ9NR1c3cv3DED5DmkV3Odmo?=
 =?us-ascii?Q?LsVDALiy3yiGM1GZ+YgDu0ZoUUxsOokFL8azyjsTLO61R+5MlpW+oY8pLpeP?=
 =?us-ascii?Q?6+r3UWGyACg6qp8TS57o+vY=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ceb48d-afeb-456c-db65-08dcb13acd3c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 08:28:49.0984 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C0Cx8iJEfCwMAmx2tM8zWZKm5fqs1xSgZ38EtPWIH/HFj45tkofYmRMcTbxJfC4XfW1w7nGDk/WD//8IJUGaqxfYRp9w51GmcgOn1f8Mr58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7827
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
index bc16d9888d5..b8e2849832f 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -231,7 +231,7 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 				      const struct nand_page_io_req *req)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
-	struct mtd_info *mtd = nanddev_to_mtd(nand);
+	struct mtd_info *mtd = spinand_to_mtd(spinand);
 	struct spi_mem_dirmap_desc *rdesc;
 	unsigned int nbytes = 0;
 	void *buf = NULL;
@@ -289,7 +289,7 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 				     const struct nand_page_io_req *req)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
-	struct mtd_info *mtd = nanddev_to_mtd(nand);
+	struct mtd_info *mtd = spinand_to_mtd(spinand);
 	struct spi_mem_dirmap_desc *wdesc;
 	unsigned int nbytes, column = 0;
 	void *buf = spinand->databuf;
@@ -351,7 +351,7 @@ static int spinand_program_op(struct spinand_device *spinand,
 static int spinand_erase_op(struct spinand_device *spinand,
 			    const struct nand_pos *pos)
 {
-	struct nand_device *nand = &spinand->base;
+	struct nand_device *nand = spinand_to_nand(spinand);
 	unsigned int row = nanddev_pos_to_row(nand, pos);
 	struct spi_mem_op op = SPINAND_BLK_ERASE_OP(row);
 
-- 
2.39.2

