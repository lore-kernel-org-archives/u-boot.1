Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A64CAC5B0
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 00:21:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E42DF83510;
	Tue, 30 Sep 2025 02:21:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="mPxGe+nx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FDF9835B0; Tue, 30 Sep 2025 02:21:31 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 768F28341C
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 02:21:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KA9fNt37ykj+2lAsS9CU7SRCza9yA5xcuW+0cuF0d8FCi1TDFLbzSqTFAcpzEWy6laDBd5B2Jv8Kobyhdf+hrya8TAaziffPHSwlT2CqEyJPxYE0VQojUzZnD/CoIJpNf1toek3ZD6xG/FUtA/fM1l6CAilMyen3ciIh3o8rLwUFar5j2S+5Wa4Vmm3JcokBPZaWXRzDQdK7rg/5qxHt0/LpU5kyhNon1WqkrHVw6pfY8sCn8sjYpaoZDgmPy0qOkrGJ5+fEpw0TkfjwGHNl0Jd6XFcPTeUb3FKSNenOLH2Xk3YXHxeAdnkBKTZreht+h9K7JNt0zkcESaWh2bGcqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxemkM4gedvriRpCGZEgHYghzj5XTcheAEqHXhNv6xU=;
 b=gCrxSyj/gKXC2vatVu8VO/OfH6mjl0/JCaHms5GXrfQqgegIX0BTI49HVy97oGTa5kzS+OUUKeyz9reCXzr5OrkpUnH1vSTPKEn9wOrUBQOxFwP1yUpsrouw65lgJLMBWh87mrgOiNFJoj6QtpRO548lcJv3AIS97lvJN+sTnT7z+cqhMLQ+KULKERXyloqJ63gSnNE5cfvCPEw659S1XBFQuEoTEVMLKLkY3VT5IA0kVHgj17HI5t0QVSpArsuyKUpGkjSnhTZoc03vNvCuB7aXg1XbQatnYLGvcjlp9PXB4wit9VRZS/FYc/uXp4Q+KIp9ltL8R+o2S7MAHKvZMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxemkM4gedvriRpCGZEgHYghzj5XTcheAEqHXhNv6xU=;
 b=mPxGe+nxtok0IJ9BnQC8nUHTBmJx77IMtzqnZmR+aOoSDp8hGLDGZpV6tESureN2Mk+fDQFN1OrOz942VMMfSKIHe3mRiXO2uLDWP0f46m6Vtw9tvZTvNYtMg616ock/DllsCSggpl2neIYP0lSyTu7JVpNs3m7ccdZWBy3++BMSz1JeplMM/0G8vUK74HnaIiu1EGDQ9j+afCbm7Cm0BPfgIsuQZS++wPkKfnv6T5xZIw6Kr3mlTSpy+zphyP3xRywn6y3b5nK4hLPD4xf2IXw74aghwCVoHB1NBXCS3nW3rryq8nkm5uCQ0cpQiOaFNBce4jA0KbB/quN7WJUVGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAWPR08MB11512.eurprd08.prod.outlook.com (2603:10a6:102:50a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Tue, 30 Sep
 2025 00:21:20 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 00:21:20 +0000
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
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v7 02/24] mtd: spinand: Use the spi-mem dirmap API
Date: Tue, 30 Sep 2025 03:20:47 +0300
Message-ID: <20250930002109.3600886-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930002109.3600886-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250930002109.3600886-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0317.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::10) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAWPR08MB11512:EE_
X-MS-Office365-Filtering-Correlation-Id: 828f22f2-e7ae-4495-5599-08ddffb747bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|376014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V6mbvidKadPUEmTCEHZDOhXjdJj7ppAsfQe73EkWvQN9ZCLjukC60v1IZ/Pb?=
 =?us-ascii?Q?pAT7KfzcV9AFC4/F5bx32SbYu3Ouuyts41Xdvlg03tfP0DBSZYVNnHGRgPO1?=
 =?us-ascii?Q?0h7Cz428A7vuAMdELhSz1WwvzJ1lF3qRmjRXk2vufxX80XHLXOn39CHtUnP0?=
 =?us-ascii?Q?CVG1yNT1i9L3/Bj/UbFTmzplwI9Jzkg3MnmafDgpeTRM84km1Jnq7ed5QnY4?=
 =?us-ascii?Q?TRScJ5GXdEM8blWjl4RFzG8acbDIrf3+VPCBUBt9QkLtqI2MVhgySyC7tGxx?=
 =?us-ascii?Q?yyo7mLeLflHxJKLX/xCJKkK5rcYUFW+d5KgEyaXmqSv+uyXZpgyrAiP12QP4?=
 =?us-ascii?Q?33cEp4hoakXQw8IyqaPTMxUYx1kEZTrXGdsf9XS9lu/5NtbGNbQ7SxYnh4d5?=
 =?us-ascii?Q?v2LAANZfU4oqOP6bmB6zf1JgQd8QDiaXXlmfN8kuuwEJqvD7fHkgLIPlUNSZ?=
 =?us-ascii?Q?accDR7DSgx+XV8Lh4iubHWv/Q+tqTDKRHxgAf6oHBKdOUF5PpavgyxhmxFBv?=
 =?us-ascii?Q?iCkOSBPfsjVqCHxlbK8ICGHJhN8vE9wHWhE3ijUdZ4aJ3Ew1VL4vq3x1o8Zv?=
 =?us-ascii?Q?Yjclft6lm+vx9fokE9Bfo32nqrBgInDqtfjcWTyEguU44iHKNF2J/dAR/S8g?=
 =?us-ascii?Q?qn57dTLihyI6BIpsEarKLl8LGQrPWuxvsnwDP9qrBRajxITsx6+3fiRxv6Mv?=
 =?us-ascii?Q?7HLV9XlznYVW6VhT7MFUQmWoSXYK/R0qQujoMZi3EuKiGI2OAK/lkuW60E1E?=
 =?us-ascii?Q?1+dPsdD7YVmgFJsqHRd9alonXj4t65pPR1wARUxN6m1Cs7npAO5afPqMYuUG?=
 =?us-ascii?Q?57VJPKiVG6fDe2iW6SBjH81CP7XwxAsNh+p+Q5F1G71f0XwLHxJSMzn9Ge1m?=
 =?us-ascii?Q?/0WXgNFEgMedqN3hlcmBVGFkMvRM8HgfrYCXawGaLWSVCLPgeE7YpT2uRe4s?=
 =?us-ascii?Q?IaQ5Q3g+zDcbdkt/Cd720CIeMSm6MTJT4IV9u1tyNInwE3HPXIdrcTnu49fO?=
 =?us-ascii?Q?odYfCCXB7JKRQ83XrUafecGj6vjo4ELqqlGHKyAYlkzYOD+HwOakTV3A9mF6?=
 =?us-ascii?Q?cn8kItGiORmjiTPfwue4COEJMZJ9eLvrt0l4ohTTe6/xpvtga9CMhKp6ZriL?=
 =?us-ascii?Q?SSuuvMZmSZVFFEv8YFYLvnzDbhpQsrgVHfX52dgaqdgTMJdXnqtRqCqBflg7?=
 =?us-ascii?Q?TMh1gAQKqRzZAFoG9z96vIxQUMkbmyuyhukUEqxczSpSPZJawMc/RlNf3xij?=
 =?us-ascii?Q?YWFCBad90LeJANIpo2xsELg5kswYjykqJUB14LbNM/X1UPdRfU5rCZPVFzqb?=
 =?us-ascii?Q?iB+VeCKLruURFrnnjMyIEUsZshF4rY3+l5ttx6eQqEFk/KAOMKoYqT+LBusb?=
 =?us-ascii?Q?28ib/cmhmn6ZBwB95FdQ8uQuLFKuZe4Jp6XeabeWt/zwxNj1M8PGss7ztBSz?=
 =?us-ascii?Q?4Anln8nXSp4jSqIaPVpSWdUVBvMhu5vXfKbyPjbe0cX7BIwGYkNfE5aqJY1q?=
 =?us-ascii?Q?f/WKdNhlb+PpmrrqIwZ/TkS+x7QZxXO8Bgv+lY0IOAAC7Yxwndl/jaIuyw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(376014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0RQ8ZlwzMOsa8YAgQBe+ffmPhftV7YQ86cMwZI9Ds4pFRA0pN6m1yRa5I1mX?=
 =?us-ascii?Q?saDj4bygKy9g0c5msJRxztIm5yfca5ZV0Jyg4rk/YOk5mD6Gp1CK4ArxqcVm?=
 =?us-ascii?Q?jVQc18gsH9s7t5jFMtQduGQ3kgYdle8CcVLxkTxKzA6jMLxSKhpTDck8hMVD?=
 =?us-ascii?Q?uhoJKOzWpG8I/rsDSCRFgCrN+sR4n240/3yBU3OkrMlsl3vgT0cE24pkG7pJ?=
 =?us-ascii?Q?4LeYyFCxkuFOPknbmUvBEjUoPuZ+wF4d4ZEXTplbNDxfTUhcm+zuq802Xwut?=
 =?us-ascii?Q?bKO+tdjUSxOTHa3odgeuCQe0b/ZUHZgodiOaX8tEO8aTw6k+ueHCZ7Z5dKc0?=
 =?us-ascii?Q?KbMpNjoigG2UHrW0Ms/deW6EKYE7tmW03jgHqkQPEMP3FLIqneGPkIvoLOcK?=
 =?us-ascii?Q?TsC6d0LiyUycf21F8t5XPtrp5SA70c890JFlQMO6XRzT3JqEnCpHuYTc9e8+?=
 =?us-ascii?Q?FPIVz0qA48JEFr0fZVvEuqMLhqAbmhv6kAPkRpuhVqK3oI1mZF9N9xkNc7no?=
 =?us-ascii?Q?jN4zHxC7+7v2qwNaO3oOivQZh66eVCM/9OOq8Qjtar1A1XuTAfCkoYm1AxfZ?=
 =?us-ascii?Q?2Bzw9ABrbJEinQzexxKGYgsTY3271f8l6NLscg+fJGm56w1AtQLRXR8LGyeG?=
 =?us-ascii?Q?36RghhSiSOnUqIucNY1MJYAsMdISY9oCfAzhuo/4V8sXsukq4ltTZ1QYSZTo?=
 =?us-ascii?Q?Prd9G1dPKGjjDBISaNgcmjlqDamH3j4biLMjQUYCzSO6/h2dovOTQhB4ml0I?=
 =?us-ascii?Q?TXHJmekWAb4Ev+Jh6L9G3DzzvlYIgabAjrMCsni5dd8LXS/BGn2r71yKIy0h?=
 =?us-ascii?Q?2vQXKW5qhfCzoqTRoqEY/b2+DdnZk+7hxuQjqn+8sqvxoME84bUhfUGs40HQ?=
 =?us-ascii?Q?BD/4xt183tDIw3GW3GoaLqgfTujS20e+uw7HEc7i3CKwXO79voN91D+617yy?=
 =?us-ascii?Q?jvvomHGNZK6XYjAbM91fq3ezfZfePge/izCI0GKc2Uj+86EeMCradj4oU92E?=
 =?us-ascii?Q?RAxGnvVAiMmJ1OBz6vl26SE7NQJcR38FOIZoz+5cUgQg361IAGDuNLw3CTyk?=
 =?us-ascii?Q?r3hW12DfdVygrd9g3ESE+daYushZQuNzZhYrmUklSqBgypEalOqFcdfwoKu1?=
 =?us-ascii?Q?1y3exobTch2Iw4tXRMVUHP1KV8u2br8vCcsaSew9lZqSpdsWaZDX6F/+dgux?=
 =?us-ascii?Q?8lZzdT3oMTUllICItEHbMZkkZKmpLTMVEAW/Oqbr6jgB+CCpubfmlAKm/bj/?=
 =?us-ascii?Q?6lSGBKSHmnhZxitZm+VX03jCafZHwAznU7TTEEqeA3j4YyfOkOHrRpT7q1ZV?=
 =?us-ascii?Q?YVy+/AYUxCEKpt6mXTtAmzVln3TxL7lSF2Kt7dWETINlqWNJ9UKOi9lXwEGt?=
 =?us-ascii?Q?uc/e7SeaKAWcP3e/GgTixNr9VJ87iDJPxpF5ZdIItjLculwsPlTi+T4p8kze?=
 =?us-ascii?Q?mbiM6MyBOokxYOuuws33Nm9LdHgbyXtbdpykkWZLICTM0mW0rG9+kzpqm6L/?=
 =?us-ascii?Q?9k8I56ZyJOOz20BuO+q3+5esCVm0L39l98S9BVVrNdj/eQHyN2GIKPQypZaV?=
 =?us-ascii?Q?jGWFcGmQcO/swW/AN2V9SkV8E7Qp/hsh8k3j5sQwvcAQTB2ZonjTJle1nQbp?=
 =?us-ascii?Q?CJfQN1x6mbh4E4/tR33NdWY=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 828f22f2-e7ae-4495-5599-08ddffb747bd
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 00:21:20.6434 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wVdKI4K3wkk+d7uy1CcIPmBLPSqKwEG81fjEoMhCdHlnRPnVPy+H+C10NUMfck9GYO19i3trVBRkZ2C7LJ+OmdGvJPqMRlU+4sQKePOohS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11512
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

Based on a linux commit 981d1aa0697c ("mtd: spinand: Use the spi-mem dirmap API")
created by Boris Brezillon <bbrezillon@kernel.org> with additional
fixes taken from Linux 6.10.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/nand/spi/core.c | 185 +++++++++++++++++-------------------
 include/linux/mtd/spinand.h |   7 ++
 2 files changed, 95 insertions(+), 97 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 3a1e7e18736..c1b8b9627f2 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -41,21 +41,6 @@ struct spinand_plat {
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
@@ -249,27 +234,21 @@ static int spinand_load_page_op(struct spinand_device *spinand,
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
@@ -277,28 +256,19 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
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
@@ -322,14 +292,12 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
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
@@ -338,19 +306,12 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
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
@@ -361,52 +322,21 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
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
@@ -819,6 +749,59 @@ static int spinand_mtd_block_isreserved(struct mtd_info *mtd, loff_t offs)
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
@@ -1134,6 +1117,14 @@ static int spinand_init(struct spinand_device *spinand)
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
index 6fe6fd520a4..163269313f6 100644
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
2.51.0

