Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EAEACF3185
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 20:46:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20055892DE;
	Tue,  1 Oct 2024 22:45:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="QSVW/Dk6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FA15892D5; Tue,  1 Oct 2024 22:45:03 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E3E989256
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 22:45:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oiyAbuqbb9Tx7DW+GdCOU7MRoXgLNqV43f1JpVymi6tGPVGqo+ktCzkZFjqb/SVz0PPLSVzJ9ELqH8GmV2J9gZCyR8XyX12bisqDRFHhZASrL8QaWHRUmH7NZFhVpO/fSVEtqgy7Vtr9oMhHmKeeqhsM8BuaAiFswyQ4g20skkqjQAQHcqoaiGvfu11ytbBWUxZyK6HVeHEVk+XtqeVGaIRcVnDZ79J0ZM0vW1YZQG6C+h0EgxpkuySekMtsQYSL2q/EYOW6BXdfsER+mXeqqY1KCNBOY7AzbGhl9Sa3GAJ4lFREYOyigaZ+CoKlTbPKgctKfR0z4a5kiZ4qk4gqJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBVMf1HtML+wrbFAbRZ5Dsb3MxqYGNYI5rU8KrmMS70=;
 b=Guf5MKMWtO7dGXpYGTkt2usfOezC3WpKgjIrv+Gr7ZM0ybU07l/I2ajWAhHGOvjZSG3DMmVLJ3zAcrr2EieXL/Zi/XWk5v6galkMTgjfTGaXhWtekURXeuth5U0sOMidlGhAYhwk2HlmPT01hE6Z+7zgZQA2ITAuozWvyD2aSul9U1FdQmfCIBipxX4oi9Dz1NUnJVhl4Mvi+CvdvDEzHy+aARqQR7TpETr8vu/Ea8TYJGpmaObIq9xbsxFAg5Hf4hdbmbHIOpy+g/QqLqQGCwz3l0W9TBW745tBvfjk6EWutVHv4hYxqCARv/uz37th4kWuX2q7pvpUkFl9r9LUIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBVMf1HtML+wrbFAbRZ5Dsb3MxqYGNYI5rU8KrmMS70=;
 b=QSVW/Dk6FAX+Gcs1WekaFEli7J09Y1zIv2OypPpRIwtk8T8gWxs0KFjogQJfPRw6NwrcKVGbc7AxSW5IwbplQx5C3q1Ey0Mq8sK3+LLW4ROUuvhvOdYdR1lX2wJ1MX/2I6RR0zz5+iYcWxsRhpu3HSSiQKnji2hTLt1GEyZ3MdfCuYGmf0rQkAmQB/ezwxGLvcXdeqa2Asrpfssj/BuAa1Hv7Ww8QD3ufRwABO3w/GYpzvArd2IG3k48ZnQXf1PbUOrjzzX1d/frqnOEo/cnHlp5BNC4InepVAbq8uscyA03gYGcgrbfI0xoxsndD0b2du7Re/jYjiNkpH05jHncOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB7812.eurprd08.prod.outlook.com (2603:10a6:10:3b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 20:45:00 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 20:45:00 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 William Zhang <william.zhang@broadcom.com>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>,
 Igor Prusov <ivprusov@salutedevices.com>, Bruce Suen <bruce_suen@163.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
Subject: [RESEND PATCH v4 06/10] mtd: spinand: replace enable_ecc variable
 with disable_ecc and update corresponding logic
Date: Tue,  1 Oct 2024 23:44:38 +0300
Message-ID: <20241001204444.917238-7-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241001204444.917238-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241001204444.917238-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00011B5E.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:8:0:16) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB7812:EE_
X-MS-Office365-Filtering-Correlation-Id: 27151be8-53be-490a-ea41-08dce259ead8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|366016|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K/aPy1K8hWCBtbteWR9oKTPFYYTQ2dpy+vVnhya5DqgoqNlt72lK61Ic2fUk?=
 =?us-ascii?Q?68OxXARYkFGsad5u9BeRON6xjrRXOXCXdYSS3i+fFzaO2K+nJPJBeVUsolnd?=
 =?us-ascii?Q?FSErFR8EqzywF1pTWj0WTetQ/43Broqo4+7DG5iEhyzVdG7Yg60ABYUDSLR2?=
 =?us-ascii?Q?oEYXyugVNmECofu15jTaND1e9GU9noldrVG8F/cpg8g7WdEnKWQPJOreg2sZ?=
 =?us-ascii?Q?e7fAWY06cND1u/faPZMBCQSxQiBGAa4Hxm/zEDduq/v+TmJaAecSNKJevh0h?=
 =?us-ascii?Q?Al2Qd3qlgr2H+QDOlg+u3rJXQjmxwnNfim8sLPQjOibvW0bUopeM5A93QLlZ?=
 =?us-ascii?Q?69NgUcUco2aSi1/kpJ6UnRhSIEXzMYGf416DnYotYAbfU5uAaKE/+OloKhN6?=
 =?us-ascii?Q?pZSR3btotm8s9vO8b3z5BfqeKy6sJkPtTTJsU0gZe1hwdgGFZYaYDIhT0qPU?=
 =?us-ascii?Q?gHUQsNJPWZXbCSnRMGTcEf4q/6gU0e6c6mmOz6JXpIg1QPwmDutDbK7Qnk4p?=
 =?us-ascii?Q?Rk7vfKsRRVl/iz8Dh9opLdq4PqQZB/IP4UcGF/GV41QO5RRJ1gwDD1itvO5o?=
 =?us-ascii?Q?Zn+RwyWGr5wuSvfHfLsk4j0lCa50pMRLOW9X6UdkRL5uz+Vi13CFLomvmBWN?=
 =?us-ascii?Q?Kc/8VWLxbhXjQui6Obqa9Lxtz90D/RrEpa0ZLzQaLRGtj91QTPi7R2EIe7uG?=
 =?us-ascii?Q?LEcCFjQy52tcFC0PDDsrhL0Moy+sCd6WoLlgDAImJLTjaddsg+hAcxwcFCC4?=
 =?us-ascii?Q?DYzKSZWDOROnNW99eWM3qWvX1Upk9SN5Gj9MrAzB5SoPkKLWT1VNXk/oVbxv?=
 =?us-ascii?Q?YxNHO3A0B0C7Lul0/Mf4cUh+wdzAdBa57N8tVeA14+PH2rAn+T7KFSYSgdRr?=
 =?us-ascii?Q?g9cBZOj8pUFLU+l4At6u5n2+ymwva7OlZZ1D+2Xcyz7HnHKstB+4ey9tyLQD?=
 =?us-ascii?Q?DXfZnGOabnnhwhubQY2yb70b+pGH81No1WmBPBOEMjqRzc+aKE0G+5fuxPJo?=
 =?us-ascii?Q?aTcf4Wmm2QkwEYLJHBIVl6b6wgKO93EDZABfA3sFJMirh5Th6WjEPkFRz0iy?=
 =?us-ascii?Q?GONabkogX3TdEN9RXk74/zltSqZWeOe/XS5mvp/H/d4kMcXd1OSHEtfyCHQ0?=
 =?us-ascii?Q?HqubQ58O8Zeg0EBpUqk8aO0Z/aTI6/uzpuvkYaD75/I3w45OaolS+dr2wlYd?=
 =?us-ascii?Q?sk9LeJNzhoZE7eV60MPq5r3bogGR+t8hz2S+ms4bSy5BfbW+0I/mLF2Q9hdu?=
 =?us-ascii?Q?y/gJFm0ZGUZHyTO22aZgYeHXna+nrSas4NHTt8jOrHOm/tLrImD9Sb9B7ko1?=
 =?us-ascii?Q?wjuaukN1mgpxKrSLE5z8t1Sp4wjq/CgiQW6rfJDnft+AYXcwEOy89OU3YTve?=
 =?us-ascii?Q?6VCEY6A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Abu3G3AdTNaVOOzerpHySIzZ9VyLqg4gCe7kgc6N34o4KGVbfA9Fsjk4urzj?=
 =?us-ascii?Q?rh/h3ryIC9tWL+WbWnWo4yxafhMP5cdx/8AdSy0R1fTg84s7/nxfFAEXauru?=
 =?us-ascii?Q?QKrqeYc5z0+hUlv14YPgyiHH6DMq1y1hMdpQHJdn8/kzgE7UHtPzvBhMWtTz?=
 =?us-ascii?Q?IxRohOQRvpfD2EJ0U/lf3u4hNFY7wCJ4fme3g8YQn6Aesgu3NALzwyNHTPDy?=
 =?us-ascii?Q?lyJZvz5yRpqguW4CJSULqzZbRSvGw0lKeyBsCcRMwGl6pvA5NDO/+zwLy0+B?=
 =?us-ascii?Q?7h1qNMALC0naYUL2txzU1wrBspvBsIIhdkNumcbNeSi6iRsAlUYe0/eMALjf?=
 =?us-ascii?Q?ht7BMZ3/FgiDIfxwq+qYqK7G6RNbp5eKcXmct55VYsP+5+9aUD0wyQF82do0?=
 =?us-ascii?Q?r97ofCyMl7ECaccxQ9qZAY2Ebnct2C6ZlqTNVMK1oZm9v1SK1XLna+VKx9/b?=
 =?us-ascii?Q?PJVr8VgeLOC5WbHuonVJnOIeJBPriA84MlAiJA4hpcszjwAffBkd0zV7tHHO?=
 =?us-ascii?Q?eQk98rteUesoZbyQ68Cd38UjfoylODAHnYDZUEnumRofKRnLhn31q5YJI0zT?=
 =?us-ascii?Q?hiHC68K9wV7X1m5NU9piOxQzGq71SrD1tgJ/Pt9Kpw++puFHfhTq5bY0bIPu?=
 =?us-ascii?Q?4Fzz0WP5q01MrMOz+Nu08VtL2+NUKSfrUQ3SovJ+HHgCPOvqSe5xmYgZfjc7?=
 =?us-ascii?Q?JUasHe+H9qJ0IcGinYXTo6kAiL6JnHagJPLSFUqJFjUZHGW0B1l/4NW8H6M0?=
 =?us-ascii?Q?HMWf9lbZEF0DUEOgvuxT5U3o+Oyb1p0yz/Xd6ZQHd13zqQk7C07bH2A4Czzy?=
 =?us-ascii?Q?rIaeZslzNsXw5BASX61pYJTFB1HjIQq/ZQ9ubLGReZ2sarSyXu1uuSHH7Ore?=
 =?us-ascii?Q?FXvYV25GF4l717QfcARrybM5u3Hc6BQ6y7LwpbYHzrzPi+Ubl3BHaRt7+H0X?=
 =?us-ascii?Q?3n7Q8GOUSj0yobDhWSfUJqww2mgl5tPu29j8ENXZiJCPM1s79wvo4sR2byLX?=
 =?us-ascii?Q?OF/AMFkKyxHb9XvxWeTTYJXGdiA+RVohxCSHsZUYxymbkqdjbJOkhOHu0kUh?=
 =?us-ascii?Q?+z9uNaYKB95ScRT+gVCSDXRAoal9JKDow8FUT7YoeBf2kT37msmN9bcDnBFJ?=
 =?us-ascii?Q?64/gTUL365vd1+l+odLytk3r1umg/PxKD9fpIf3l2tWgC/RI9fsL0ArLmA+Z?=
 =?us-ascii?Q?jrf14SPMV44bW397/CxS3K86jjjpUN6YKMtdU6HVo0ju97lsDowcC0K1nmch?=
 =?us-ascii?Q?ho+ZIYPiCwhTawDBIcmEIx9hVTh6UYVsj/qrtK9FyY7K9dTzrAak8E5Wwf/e?=
 =?us-ascii?Q?8RQH/0TcFtCEJdUgyQh6pq47ys+UtWc6Y4pfXaKJ5BwsJ92q43d3UzqACrX/?=
 =?us-ascii?Q?+kBgIaGL+kaCSn/jQushFu1MbXw/zYXMgi3vexrtdF3AJgHu9k+9JCGzzIEy?=
 =?us-ascii?Q?oW+sFWe5QFj4a5uSEf+sA6/mfqPKh9xQs6z/rDLbVAc0oUaFCG+rme91EGfF?=
 =?us-ascii?Q?l5+S3dWC3/goBTL7KL0nym3RgrJR3DJwqQN2uRDMF15O9GlfYJFVRAu2lSWN?=
 =?us-ascii?Q?IhyE4pyHOrL1AtDsxuonPB5eAZ1pbmIB/Iu4sLOd83EWJgheg/g/pxgoVWSy?=
 =?us-ascii?Q?ZIZ6NJ25lme8FgDlpbUNoPg=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 27151be8-53be-490a-ea41-08dce259ead8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 20:45:00.1376 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n3sTQ60/Ge9RHprpgkgMIX4g0XoAHD3/fthaEJrtuFypngEoGd5QFzxtdaQjKxIzh9nYCR1uJ8N7Zg0Xd0kTKMLHDhgKHiIAccJoilq4R70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7812
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

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index b58d9e00907..9629fac3388 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -530,12 +530,12 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 	struct nand_device *nand = mtd_to_nanddev(mtd);
 	unsigned int max_bitflips = 0;
 	struct nand_io_iter iter;
-	bool enable_ecc = false;
+	bool disable_ecc = false;
 	bool ecc_failed = false;
 	int ret = 0;
 
-	if (ops->mode != MTD_OPS_RAW && spinand->eccinfo.ooblayout)
-		enable_ecc = true;
+	if (ops->mode == MTD_OPS_RAW || !spinand->eccinfo.ooblayout)
+		disable_ecc = true;
 
 #ifndef __UBOOT__
 	mutex_lock(&spinand->lock);
@@ -543,15 +543,18 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 
 	nanddev_io_for_each_page(nand, NAND_PAGE_READ, from, ops, &iter) {
 		schedule();
+		if (disable_ecc)
+			iter.req.mode = MTD_OPS_RAW;
+
 		ret = spinand_select_target(spinand, iter.req.pos.target);
 		if (ret)
 			break;
 
-		ret = spinand_ecc_enable(spinand, enable_ecc);
+		ret = spinand_ecc_enable(spinand, !disable_ecc);
 		if (ret)
 			break;
 
-		ret = spinand_read_page(spinand, &iter.req, enable_ecc);
+		ret = spinand_read_page(spinand, &iter.req, !disable_ecc);
 		if (ret < 0 && ret != -EBADMSG)
 			break;
 
@@ -583,11 +586,11 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
 	struct spinand_device *spinand = mtd_to_spinand(mtd);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
 	struct nand_io_iter iter;
-	bool enable_ecc = false;
+	bool disable_ecc = false;
 	int ret = 0;
 
-	if (ops->mode != MTD_OPS_RAW && mtd->ooblayout)
-		enable_ecc = true;
+	if (ops->mode == MTD_OPS_RAW || !mtd->ooblayout)
+		disable_ecc = true;
 
 #ifndef __UBOOT__
 	mutex_lock(&spinand->lock);
@@ -595,11 +598,14 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
 
 	nanddev_io_for_each_page(nand, NAND_PAGE_WRITE, to, ops, &iter) {
 		schedule();
+		if (disable_ecc)
+			iter.req.mode = MTD_OPS_RAW;
+
 		ret = spinand_select_target(spinand, iter.req.pos.target);
 		if (ret)
 			break;
 
-		ret = spinand_ecc_enable(spinand, enable_ecc);
+		ret = spinand_ecc_enable(spinand, !disable_ecc);
 		if (ret)
 			break;
 
-- 
2.45.2

