Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FDC8ECE57E
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 22:25:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A41BC88E68;
	Tue, 10 Sep 2024 00:24:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="CPqQlUFR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AED5188E59; Tue, 10 Sep 2024 00:24:26 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20707.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::707])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 925AE889F8
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 00:24:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QprFKjZrmaYfeF1/i+Bsr55Wy80wt0VKGlCyrFUXfm2zagrSBfyJzbSlp34rj2z7yJBPqg/mW3w52qI5wsBvo/eSU2RRv69eNwxJLEzGg/YS+gIZksV0O94sGw8v5cfq4/TCNeF1TaD1KXQHryVJc6j9UD515ydjN7vL1QHy0oFqdRbwZEXh/mq4htpKTIMVJ5El574UfPZouAPN6QoYoN0EcJdyRcJWz+BAnXpNfRdozQDoOWdhQSezbfSVfW3VT1C7Pa5tItkuRTzcbL9fu9sK9gF8Xm+fGrlKt23QAB4ZCS7tL9+uUiBRw2epe09Sf5sn6BSe2TxBFSGVVtiokg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBVMf1HtML+wrbFAbRZ5Dsb3MxqYGNYI5rU8KrmMS70=;
 b=u4EGL1e3zHpj5H+nnbRcjk8mrRl/0ofjCNcGVmgA07iR0/xyOw/TU4ixBRXpcGMXl/vUxHQOOeI/a/9YcuAh5FMF227vNv+ohs4rtFWNkKjZvA9ByyQkprgksDbjaKlSFm6tyy/B0S3kpwgknmHq2+wbBBBjr6GFnbp4scDHhQKaDnh4TYY3EDOOAtXocOpIw/ZZEazsdPuSIF+Ih4+mxJvLdQklhx8Xw91cKaMtgzvf3EplgUwd6K3C4RrfjNJRDIi8+/n+amdf2wbXSXOExGNh550lTQxABcIw873NWu7iNXcDv/7qY10gCS3Q8Zn9kWtqHGcOdja+JmoxYYCSbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBVMf1HtML+wrbFAbRZ5Dsb3MxqYGNYI5rU8KrmMS70=;
 b=CPqQlUFR7/U7QOXZ3Mk56qEgh3EEjfRaDGeqdP+BBLg2BX2awdbIwXSvqGTcgTG3+Ygc2aXsoiTPHTydYghaKyBOtEC6R4p1/QPhoxuB2ZhO8aHT/sEgWndQQuxpQLrO5Ypr9qanvBIVkkSkveMGNKrXLV6l/gxFAKJiAZ2ooqxDinMxatvNIUwdEVFhvnHxRN9aOOaVeD1EEwQxIJTNJX+sWMZk4QPgEgLGsBUUiSXLc+d7lW452xp9pCrbSVl3ZaenFwqi+hr1ICh8gA/nrMSmZsp/RHT76154OIUvdCWVjHaCi1C3iKn7JmYWp0VM9Y8nDJLsiUsAMzcJB5J1DA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9935.eurprd08.prod.outlook.com (2603:10a6:10:401::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.15; Mon, 9 Sep
 2024 22:24:18 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7962.014; Mon, 9 Sep 2024
 22:24:18 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>, Simon Glass <sjg@chromium.org>,
 William Zhang <william.zhang@broadcom.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>, Bruce Suen <bruce_suen@163.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Chuanhong Guo <gch981213@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
Subject: [RESEND PATCH v4 06/10] mtd: spinand: replace enable_ecc variable
 with disable_ecc and update corresponding logic
Date: Tue, 10 Sep 2024 01:23:54 +0300
Message-ID: <20240909222401.2562898-7-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240909222401.2562898-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240909222401.2562898-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::8) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB9935:EE_
X-MS-Office365-Filtering-Correlation-Id: 95d2c7f1-5e2a-469e-b447-08dcd11e24f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|7416014|376014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AbyPd0ClKg/RKu+19nW/xQWw7rXFxyVeHjxC5NPzCv4OQfRd8JCQ+T+4rDlb?=
 =?us-ascii?Q?F+TU/oAr2ZHlLdkTTL/BJFvdpD2u37nw2fFWentUWe7LGgJZlQm4R2eKwSnR?=
 =?us-ascii?Q?F60EcUwue8IlzOTJb3P1GEFNyJLnSdYaDusDesZWw0cTWft2XOUQ09UBKWeX?=
 =?us-ascii?Q?IIyC7XyalzJdB+u4F2MTP0an5NZ0udQWE71Y0vQ7BQnMqf1vqEBQFQIEDbmJ?=
 =?us-ascii?Q?La56X9w4Mh8OIiSo6t5wJNhZ2zWTEUvWx5JES3SinemVpL9nbKJ8ugu9Ba5U?=
 =?us-ascii?Q?BPHoPnMUAsoY5Ne5GIl3qmhxq+kCKO3BbPdhGzj4Wt45UM053DPEu1j+5bKE?=
 =?us-ascii?Q?2L443TTZGvdeBZkhVtmBcNeWLCnehA68SuzBxmbShGlSeyyNThEqfF6XxaOA?=
 =?us-ascii?Q?Ir3Dr4BXOVW3oF9xNVZMD91lCZjKoJdQkyGDTaycFWaQYhQW5w4Pz+aiQMIO?=
 =?us-ascii?Q?9MUctLFcllvFmzWl6amfjMWmX+Awe7RJxzzzlcpowYcPfVWCS6UQO/33lrfT?=
 =?us-ascii?Q?ge7p1eiJ0lHBmJbeVFXPK2MFRMUVrPuHF/CxCRBS5cRYZjEulxMDfvJN31qt?=
 =?us-ascii?Q?y61ldF6gIhSubGaGkF7WSbxhlzy7NwXpsB9VcGvhdGyd9DzlwSoUOclCQk7o?=
 =?us-ascii?Q?hiMmcJDLJmSSuwfbf/w1RbiBWfUljQAOqPBVzB9iSsj7Q9VEoKZ0qYDLI+Sb?=
 =?us-ascii?Q?oA546kdurlcTywyjSk2HcNeINlTbOUhtHOSybekqWLIuH8okstDcTSmep8Fl?=
 =?us-ascii?Q?OxYhf2ZmquSthOnJuyYDnlKPQjYw40DPv9b/lVcTZV2/A6v6XjYAQegW7hjT?=
 =?us-ascii?Q?U+7G2N+aTppRL4HcjKA5L4zRgTM/TMoHgS4UxbydIT8HW/OdmYnYxWlYkY0Z?=
 =?us-ascii?Q?ieGsZ6upKRO7PLUI9zYa67azIYdHHTITeRcR2irBxuBywSlti3vRNwh7rjnf?=
 =?us-ascii?Q?cTuiSMcDslk7lKRg6JtoGUT3+ZKttPFqg2O2YAb+Dy4rVa1mH1BC3iR7yy3u?=
 =?us-ascii?Q?d2n5N+DKEXrNWVRzZQxCZWmMD5CBEDuwqGLRSCL4g/QdCNQoS4TwRTN90crk?=
 =?us-ascii?Q?ly1RCdS8mEufPP7RpEPEomyhxXM4zV3pI7CsyogqDguu097jo5jVhpfsTz0Q?=
 =?us-ascii?Q?kNyM052Xtz6mw/N86dmkc/JlluZ3ceZjeZJORw1clq/KjSGVIYQjP4QJnwqa?=
 =?us-ascii?Q?lPZ4bjOOklsJ0AHCj9V4O8gPXNL8/1hAxdrm+z21iGWkimzmQXYctL3tXZJm?=
 =?us-ascii?Q?888VNf045/T/+v0n0LQs5OzNTXKJsW0/LCRq0E/Uobo82JlQjcZrd4n8Sk3g?=
 =?us-ascii?Q?XEEXKoOyr7RagTVK4EPXXmHmUvKKJzYNCfayMbg/EG7/xC86Al1ClgvlA2u6?=
 =?us-ascii?Q?uQ/ctWhvQkHdJjoheHLCEZF3TFP1YsBz12eLrePYE2+XlSQENfbzUxUZNFu4?=
 =?us-ascii?Q?INgDM20u26c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v9BaBA7JPSt3UpD4mNbBXYZ0qdSI+eP307JoV8iTtYtQSGLqkSU2E4MsUwPE?=
 =?us-ascii?Q?7qe4/XsY0e/Zv9VDcVg3eYENHEMAGUbbiSQtpmlGpT59zUNKeQ8IP2w0f8Qh?=
 =?us-ascii?Q?QNJ7eJ6k7RdpXSohTjnf/gJCvur+6JxV8ElMRgERep+hiDJogw8VeAvtlfRT?=
 =?us-ascii?Q?GOUunFMH3FIGjGhagS5r9ctj/FAPh2A1WiNrFtLD371bTafiU+TXSPoa7u0P?=
 =?us-ascii?Q?Yh8iI76H33kIh1yvUfps0g5Q9VMO6QGMQ4owtIKfofImbBkkpd0nKvCNa/7c?=
 =?us-ascii?Q?TBCgTcobTVJM0JvNDwR+t0NAOJwgTHj5wFz3MtuHbTRP5TvTc2omqd97Wn9W?=
 =?us-ascii?Q?Dfs0z0GnDYYWLwCYu+n61liRAA5HPg0voIyr16MNYbgKaXCOTXiPWOgI3qNn?=
 =?us-ascii?Q?Ax5A3NpgECW0H7hN6iwWipKQbVDYJzUdyEaMyGYKqDIP/SY7YSYOGlNTe7xy?=
 =?us-ascii?Q?MirEtXtTjCpDnSrL9JnhHPiE/S8GPMX0uJ3Ef8Mse+Y2cZ6mYandmRJz1gat?=
 =?us-ascii?Q?Y5BOMLtBU4TiHzC5VmQ4a+uomOaHuoA1OKAMKkWNlX3xPfE2z4bT/RtqtV6d?=
 =?us-ascii?Q?RimvCEfKv3XZnChPz46dmMTahfTzetSIh0+2G+mz1l/GZ81XjYQlZlU9RkuQ?=
 =?us-ascii?Q?2ctO5FbQ5llP/u13Z3p1CcsjTopjNF0e5H85ja02ZeeQ7hfSzJdvA5RtLpsH?=
 =?us-ascii?Q?w3O3iLIcqP+qIlXBPI1lfN+H6Le4Bybbu40yoOKFg2SRV3Kb5f5dQMNAeZ21?=
 =?us-ascii?Q?/tOF4nCZb1o2OOtmYu4MTpLXjAwgI9Wxiqm6HQTZqWCMT+M6uLSSX8sRlxdp?=
 =?us-ascii?Q?YC0Y7baSS49oNlMSxPxzheWb3dzqR0tK28eykvT/J/yaQnamIYH86AVyfqm9?=
 =?us-ascii?Q?osW6kKwfxUn70aYIFRrQEiIKRfEDXwfTMlLYAcjn5E8YSUHtg/wuAsTbASFG?=
 =?us-ascii?Q?V3RgrmdSPKVRs66TtFkYBjszSfavB02geFyjFLlyg/rIeKbcHdahzSQRA4Ic?=
 =?us-ascii?Q?Yh1HlijeD9Z3wuUYvT2N7yLVPJhOOTyc8n1O3ANt29qOcZk9TsIJP/UDtGX3?=
 =?us-ascii?Q?VVcdsQfTISLEiWpjcxC5AM3ev0tltim9UG0oCfNqcCbXRGnahEwQHhG8gqRP?=
 =?us-ascii?Q?6Dhq0iaWndInR8Har7R6BYviyg/uxdVRGE5To2Lfwbe/wscyllfsChcNr8r3?=
 =?us-ascii?Q?X6fBrjj8D6C8QIm+r1e97K0MosZREJq7CycztkqY50timavyvLaHKZEKLmmG?=
 =?us-ascii?Q?B9h3oPuLtlSgEuHYgggjR1Rx36s+GCnqkTyB/74UGBEFASynpoxf9Ii3dmZR?=
 =?us-ascii?Q?V16NRxxvjD5G3YISg8LiYrFMkht68LKn9esefm+A2mZatq360YeyEgSpb0md?=
 =?us-ascii?Q?3e+4/KALbggeZH5g8FKoJ6+O/LNfHpK0eLY8hJhhg3U9or9qVZ3lkOzEtspA?=
 =?us-ascii?Q?HPzRDelrcHmMXCIK/18XoUhrc8mio947TU+NIc2Ge05pUQQ5XcSwdYBYUdaU?=
 =?us-ascii?Q?yuc00anC7JDeiQzTHNUjZ5a9ziWV0mXXU5M5H1mq72OHgNmLsTOASFhanfGp?=
 =?us-ascii?Q?Su7ELsiVmwVG/RYhBCmuGb+7iegYFr2hoAPqtoMzWIfAfeaZRWHXiIGJgkSJ?=
 =?us-ascii?Q?Ag=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d2c7f1-5e2a-469e-b447-08dcd11e24f1
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 22:24:18.0160 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+S6fgrgfnMbNMpoMQFun8QW9j9LfKDCOzl92Wxc2CrROGU3X3tJjc3q8GJdkUNu57OUotNTv7bwPj7AxlFW0eWnnzAYLucIH9OVYTzRVBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9935
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

