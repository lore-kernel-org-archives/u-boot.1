Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 339A9CF3180
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 20:45:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2CB2892C1;
	Tue,  1 Oct 2024 22:44:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="P9oHi0x2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC122892B1; Tue,  1 Oct 2024 22:44:57 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20709.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::709])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EBF089253
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 22:44:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CFjRU2TRvJr2JIxdiYqm1DnoULdH0jbvWLIZq4eaflm/UGfajbzaULRpIv8ZbdneIrm9rfXNBZrI825xFd92J8Q/reKId6vfuiJu6dE4DKTcyq4B6Nrb/xqQ39qjhjRFMGBQmeeY9Ntg70FsnMVPDDPZn/kj1xFY5O80UQ4s8KdP91yikMinuQ3T6rdLBiaRSUwsfre4bScOT2spgJVgfb3rN7fo2Y+UsJ11L34hMc3J4wjWV9tz2vsUmgv6mbHMSI21Bim1O/M4gliQl6mtQ7ybXvQ7nzkb6WvtHjJrxS4a7f/mfZDXkLDD5iF2sNoZAhvMDSWybU1PSw70DXWplw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gc3PGIU49z6TqucUdkvmYhM0WGxnEKiaTwANKLpDjP4=;
 b=LU62rTzsFu976gpDBH/fmRYW+s50r2XrP+w+NyrEF9tDzDMgdRvRYKzTsUTSnem0nTRAjcN6Yd03Jo0tLmAEYq1/DytjVCH3tcv0t3Hz04AazBQL0wFbikLV449lefq0/n8pm4fm/qdESJm3IvdP3K3F+4eXUlNIJ9JFDeHdlVpbdxATUYveWlIi3o+BDtF9Kr1182p//ZxU8s9IEdfE0Pm9xlzqwgUiWijSAtiiEc5aoIu1yzK2y5Fks4AXSfd+ghsyrPuAo8lDVkjnoX2cyVn20G3Nc3KklJvyBApXqTm8KufuB2yaXlU6uOuRC5/6cGxGRQYDstNtgjH/PpSH+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gc3PGIU49z6TqucUdkvmYhM0WGxnEKiaTwANKLpDjP4=;
 b=P9oHi0x2cEAFGYwC5b/DVuAGJVtbMG4McLAVsHtH2T1Kowff5m1CZwnqop9EvQi7vQyBzkqez3y8hZYWhmBbsaMy+JEoLiSfovGJcsurOqK+kFMIu9J+Y6VGkUw5pRud5l5BKdVoB2FQmvlGW74dthQi33DP42Xkl3ej+5DuXzpgL48Q4LZ+dCPbt/lThBeZre7N/kp+dnimmNuE31dROracUNtgkoFSEXC7FYElWYBgTAf9sduJbSAOa/y+Z2IOPEnX7K3kWSELBPcuC6MWdI8EGcvF5PwtlrJmv/cL1qda/29JStwTcCc9bFKHXfGs+WgbThC6/d96XlPox6mAJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB6539.eurprd08.prod.outlook.com (2603:10a6:10:23f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 20:44:53 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 20:44:53 +0000
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
Subject: [RESEND PATCH v4 01/10] mtd: spinand: Use the spi-mem dirmap API
Date: Tue,  1 Oct 2024 23:44:33 +0300
Message-ID: <20241001204444.917238-2-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB6539:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ae135c0-8497-4ddb-9d30-08dce259e6d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|52116014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+gzbGTa+BKNKL3t5APHyeLtEZv9a7hyHqiIrk2qhj86dd/XERvpEx87BHKRI?=
 =?us-ascii?Q?4FfuYsTrtPlPM+a24G+XEOcd9dfd/+H0TfRoiqRykjhbXgV0O3tUW0RyqD3m?=
 =?us-ascii?Q?uMOnJc8jtJY+AFelOu/E3+JuLFCRzr4Q34FMMtdnIiNiL7SqNgEFdAy0UErZ?=
 =?us-ascii?Q?uA8ZaLuLdnl26s1XPEb0czMAaT6cG7uoLatUczJ8cSsXLgz3TH3MmfKyeFsb?=
 =?us-ascii?Q?GU81ia7Rs2UCNYCW9M0BaoGBkr9ehyIq5W/U+JmK0YBeOUbtPiWtrlUpRE0+?=
 =?us-ascii?Q?uTTkMpnofEhRPgfu/hWKxok5Gx4XSnJFxD8dGSkJnCquY2bK6Bw8Uw4EL9AB?=
 =?us-ascii?Q?K065phmAKTEVijoORdgXGgBPsztEdn5yblDanJ6G6wtC98eKy9zdFKYnbGNX?=
 =?us-ascii?Q?+i8RZdyvRV24rs2WRYuf5T6JEehRoRhy4WhN34BE70JYbNCMqJmtRg+DOIIF?=
 =?us-ascii?Q?gC3A65rBdSdN2wzZyqbZjlVl9ni2ZS3qx2ynR8eKCtFwpzkJyc2mDkbX1qKq?=
 =?us-ascii?Q?jwPy8ebQkn7PAFhjBpGT3+gywzn7onqRC4cr0ie5DmAGM/EDEs+EvmUIvOg5?=
 =?us-ascii?Q?xLfF+OAf12w2uBfP3iRtLA/r2llMfpilEFWuL2rkz/YZ2qyhCd2aUn3X36ol?=
 =?us-ascii?Q?EakuqGqjKuz79GAdBU5l0bjCzDgcC6fr0EcHDNCo7vcSelYUcENPI3CTkf16?=
 =?us-ascii?Q?a57kfY5yqzr3aBCO8gIyDS3Beq91uO5bVghTtuY4fmuNa5Q25CO2oLxCq84Y?=
 =?us-ascii?Q?xbRLFVdPZ4WxdxCBVO4vJqNX+edjNGzHnvBU/5LbWh4a8ZmQeo0mrzY2VnN/?=
 =?us-ascii?Q?oMyGYRrHZdndj2KxhC5pf7+hNsRR0ZURDn4J3eqc/X+M58nMvLo6TU2ADnRO?=
 =?us-ascii?Q?I0UY5l2NEGG7kWJOfA0C793F6OxajV277KUuwksbQ5Y0DaOoP3psHwWyY74V?=
 =?us-ascii?Q?MV/YGsRyy5V93Y2RiWfxAiQfy0CmvY6IMS1wZFUv9I24kPjWD2Y86a10EOZe?=
 =?us-ascii?Q?Nkc7MX1pu+qhI/sOWpuK0LhEahJoZuNjJKLJ1/BMRYkn9FI066OFdeDt3Ve2?=
 =?us-ascii?Q?AnxpwPaJoabuFddZZWes/snTy8DTHUw+C1L02BPeXbQM0QFyD8dCyItB3RCK?=
 =?us-ascii?Q?PbXQ6gItmY1HbLy282CgF0vaZkzUGgqBDiQ0O7m1R6UrE9Z+ik+7quenipcD?=
 =?us-ascii?Q?UZVLRhTxzK/tcvHhOhVFrhrcRph2LkcMoHyMhefiG/Hq163bv1KPVNzOSPe7?=
 =?us-ascii?Q?Ymzb+O+HFTNW7ats5fQnTu/2c84udQ5fM+xPar5LiGAyFqYHEFkVQOKXO5uz?=
 =?us-ascii?Q?PWXEDkrWIEmVDrEYmXbF7gwesmm2qyL0Yyk+TMWECzsxdr1XRJT9sWZ9uc0A?=
 =?us-ascii?Q?yIDBrXM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(52116014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?whK5q0QRAY0LEuiTR2JZpxTGTkpZHeKiOUc0TPMAD+EEuSwz5RPLSSmrsX80?=
 =?us-ascii?Q?L3gN/juymgzxvUrf1vl/H9UASp//FsCE0dmLNrj+ZOHY/7Xv0WwN1OXZdVB7?=
 =?us-ascii?Q?hk6DssmlQQtoFZKkrdtTuinzhaxzHIAl0JgLB2bE4+w3g2q9BwgtmJYXCk/R?=
 =?us-ascii?Q?Ph6mHFfmV2xQqXEpsgls8TyTSpJOB4ezr38M4K3FqnQKjmeIiW9+9bt5I//6?=
 =?us-ascii?Q?wNvYVI50X4JhC1+jQfj/M+BMhNTYsPsLPq7khXVn3DfUOpg/RhT8OIWxLIyt?=
 =?us-ascii?Q?IGhECt8sqjZIULPDS0dxwa2la+IFFYezRnuE7NaosMq5ab02qWjUSXFfun/c?=
 =?us-ascii?Q?F9c5P6oTQR0RhjvC/mRBMSZNCggsq4moKYiV67eHS5056PFsYnFLi1sJz/Q+?=
 =?us-ascii?Q?gBClVXVS/UGwbpF6Da92x1aGNuY7Wur6tLDfVd6z/1T9uKRjXvkNWWu0fynY?=
 =?us-ascii?Q?gFjKsiXoF014NCAgeYm8GS629EBIOoavJtZVjXW9/H5JuL/Y8pB+TWkd6++8?=
 =?us-ascii?Q?3dhCu/xgpjPdWCEH8Cxzeo5wubmyaMOOs8iw+b+O+rPuE99TNtI2BjMhvJpQ?=
 =?us-ascii?Q?/e3zpCzsPJpU05YPaglnSMyUWIIfPOpumKEmBAcKOomB8cwWdH+WAHXQS3fx?=
 =?us-ascii?Q?YOM2Ivmy3icBKhwdt8O8Tpr3zfPEhzq4Gp5QNI/7pMM6CT86yU9WGP/f3Dt2?=
 =?us-ascii?Q?rFL3stabkrO474J6t07nVVrxx2a6NrcD4II3wH96O8oUb8EN6cQZMVZWQTm3?=
 =?us-ascii?Q?uxFfCwmNITCJbX7BzYVwx363wFMOEAHWSxVXqGwaXOVJ4chpLZgugHifim/T?=
 =?us-ascii?Q?lSZNp2gbCpG+RpWW0RI3x0/EM3PKqJr9DK8qpRW8UbOTeA2ppUIksplNyxdv?=
 =?us-ascii?Q?OtG10PY7dNTXR3cV7fSB2i2BH1zTYximjxTBcGv+2ZypiIAdlDd8DRQ8dTZJ?=
 =?us-ascii?Q?4gMr7i/OvUTc54+S3AxFB2HX6Y3nqq4dIAFF1QIoUJHLE5U+nyk1+Ld4hJB3?=
 =?us-ascii?Q?gugDomqEX0oLUYtB0HOag1EVccJAEAg+wGNze1aNuVXMP5aBO+GWvZzyoA0x?=
 =?us-ascii?Q?zrFP3UkaT4UdAN8wrsBXj7/i/+zC1guEDpa68yF80b2QS8hw+F6agqxS4Yik?=
 =?us-ascii?Q?tI6AV7ChJIBwteEeyE9wG7rZObVbJ30Po2mJq0o6tIwOq4aWW64QV7peHALr?=
 =?us-ascii?Q?/Bt7p1qjyJBNJsWvbr9mJE9Wz6QqWqu7i1JtAkVnPBBla8Y8anF6MUoGKCSP?=
 =?us-ascii?Q?ayiA+rEfjTv7ZUh7/SfSww30XYSHi6ShHfPlPEEV41whSKeDoqBjliiEmtu0?=
 =?us-ascii?Q?Bo+vMARoQaMxJtIRhPoxSjvmbpJGZUDT3ROWH6sA1sce6OSVrISJrJ0qkS7S?=
 =?us-ascii?Q?U/8AVnp4IhtsW0UNPy5mHGWyzdwZfRF5I26BX2m2G1bInkXxMiBwLaGv8fky?=
 =?us-ascii?Q?fxUOY1RzKf5ad0Ls0elj0kuBe0mAaMxg92UgLrH7tCYjDtUvMqRaYlOEEP3W?=
 =?us-ascii?Q?IJTX6OJj3KGXZs1Ctkse0NgZxVeN32InIBn/9xqYvU2EoBoYW3me+kpI00fh?=
 =?us-ascii?Q?YGTeg1Vx3x/Zel3EQ4EvtURk88E66cE0A0Y7GuK7wxRJ16uE4UfEoV5syIBj?=
 =?us-ascii?Q?T6jXAjJB2wauBK7LSYgcLZ0=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae135c0-8497-4ddb-9d30-08dce259e6d2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 20:44:53.4039 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zAUER+lTtEqO/MeLMDfm7e5WiPE3bqgDWigDvUejlXdJsNHtqbCpP8HZS/Umy1l2M7XuhKNB6bPsNWPvfuGj8xF88M8pW7xUAN5QtrGha94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6539
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
index f5ddfbf4b83..ea00cd7dcf0 100644
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
@@ -1116,6 +1099,14 @@ static int spinand_init(struct spinand_device *spinand)
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
2.45.2

