Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF1BC3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 10:19:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4058E889C9;
	Wed, 14 Aug 2024 12:19:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="HXTfiWgN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5723F889C9; Wed, 14 Aug 2024 12:19:38 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DB5D889BD
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 12:19:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=naGXOd7ekFyly6mi8qIhClZNkJcBNxwVIImaIG4Jb9FvUm06VVHQ/uIvHR8DmZWCR/ah03Ux7B5P7UUIMRhrgtoHG5LPHzy8F0h85y2iE3vnQJ1R+8SdDXI3Aeki4pvgj6Ty9BI8H8Fg95Nkk90lqp6e3iYB3SRsMFNDDdZCWW3L7ONPinfwI7NkSvYLPmYSQDyLcj/ibkXweV8hdqaEynD9tvcTQOJESVVGza5o+LPcTc0rTRmc+X4KnvysYIBYnzBvd/vNElMBXZLfiLgE19rNFyVecWal7kbbebDMXzKmDdMzXpvV7c+xJcLo3J5kQfjdxemVv/WsLeF6vxT4mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGeVFQSUJYAE6wO9h5CYUw+z16ZWWcyuZ4/p4PRB8wo=;
 b=WjUcazB2c6MslNijASMdaMc42loN2tjPXl+VOW0Wd+dFYkdcToTZjzvdDVy01QcPtLnvhLxIVQ0FXfcVQfWRkK8FNz98Sa7hwqX5eUTQlE2pov4+ivMdQEqcW8A/EEq3yXo5e+UwugQMPnF3oj6KEDSRLxYQEDDVMW/C5DROB/SPYcn8DM/VTHdYEAefzoeV2XigeDVWaJbAF6H0PCm3wk8xFih3seRT5Cr7BuprEBaZbSVjrKbd/AN3FOx1bxAmNnKHB0XIB0JpkFcUz7XSLF9JFZ3goO4N5No8orVaGNMN1qoCCIUTDhUwEJXuLEC8MDD9N6A1rX4ClBp3Jgrrxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGeVFQSUJYAE6wO9h5CYUw+z16ZWWcyuZ4/p4PRB8wo=;
 b=HXTfiWgNIqQ75YeZ9+F7wAxh0LfdoMdUjvPbBx3Ptirl7QKQk79XTVupHTYVTJpoFHHzR/p+31+P1lbUCwZtpmdSsUnVu8/CwPBZ3qAwYGgtjYGTSWX1ru2x1nAQhTXt1dWaA0FbAaK0IZlgI7SR1aZtzVDu4iRbZ7NN9/6KJ5+TyxO0dgSfPOcMt44r/i/+2HI0whcgCZ8SEHIARL8vciNYBh1LwERaETRGcVay2ZzokrlhFiMydwMPnPdzkgOvj/2tMLHpPzD6AvTZAXiWqAC88aesrdkPSopGI9Fh61pYeQeDko2KKsslKGbWIqJwUcENsO0mnERHPypV9J0dpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB9524.eurprd08.prod.outlook.com (2603:10a6:20b:60c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.16; Wed, 14 Aug
 2024 10:19:34 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7875.012; Wed, 14 Aug 2024
 10:19:34 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 William Zhang <william.zhang@broadcom.com>, Simon Glass <sjg@chromium.org>,
 Chuanhong Guo <gch981213@gmail.com>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Igor Prusov <ivprusov@salutedevices.com>, Bruce Suen <bruce_suen@163.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [RESEND PATCH v4 01/10] mtd: spinand: Use the spi-mem dirmap API
Date: Wed, 14 Aug 2024 14:19:09 +0400
Message-Id: <20240814101918.1347167-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240814101918.1347167-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240814101918.1347167-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0401.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::10) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d3f6967-7fe4-4705-d895-08dcbc4a97af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|52116014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gZrktY1138kh718Pm0tzX+VG6Kqgb9S3d7Q995azpo/Era1fv1ELN8qx14cy?=
 =?us-ascii?Q?5jNecdwqVJZ2N3SdykwmdpYn+F85mPHnPegrdSIujew6VoomfjXNkthI+SdU?=
 =?us-ascii?Q?Pam4hTpjpop8dZS6rpnogIjbKokOs8ol/XYOiEC6ayAUvH62JL2EnUa5i99b?=
 =?us-ascii?Q?Axf0nJAahf8I+Bjp5s73uFPLJ5K6gzevzvG/UuCEoFOIetGF6zgH9iwe1qEz?=
 =?us-ascii?Q?1aZZ+o0NgyA2loTuUhwWx+W2lwqtWLwWBJ52LQ+6lgvBGlQGMcHPni458oNW?=
 =?us-ascii?Q?wiowntQE3IcZgPcW+I+ThUr12fFcwZ0t/gXsDK4kQVOe59xEQ6IgO9rhfSOM?=
 =?us-ascii?Q?3YZ4FMCbZraNSBkFzW6uvXOw27CcjuNeuJrqVi37Cd38+mEVwgjgYFq+GPKN?=
 =?us-ascii?Q?W0rJmJw8L9VaAyNFZV4zZh7HV90v2w2I8Qe9+4e1lWTv1VNXAQQ6zhGgJX0Q?=
 =?us-ascii?Q?ZCJJjkwOReX1ZXqIBVLYqw/sbiT4iEuwkeN2xzFAgBy6zIAZ/rNmWxbN8aji?=
 =?us-ascii?Q?XJI5WVVpSoI05fDq4MMpD2LHnd0+Ktq0W/3TS0M328tKhz247oqrgvJ8A8Qs?=
 =?us-ascii?Q?b25na5wXsR7Pg/0EPAZhqCcX/QJoYn6VwWKStttNKyJvVdujIxgouEk33zQE?=
 =?us-ascii?Q?4hDXO+EByYQ/t6U6pEb92oyESqf8yIJ14/rn9DSL4RwJIvKwYRjlmKP6PrI/?=
 =?us-ascii?Q?U5/UbB4XaDd62KK75OIIcSM+A+kHosdfwzDsF3hOOz74bFSw33TyF5Zxfj7u?=
 =?us-ascii?Q?+9WVP91X4lUJ7cJpTK2TubHhFdjMbuzi+xxN1XzgbAbv9ihegiNlQoqwniLy?=
 =?us-ascii?Q?C2CP3sJIjVVQg5s9UDrcx4C9PYkhHQYTLYNE/GIWFforspNWt1cVmEIjvXvD?=
 =?us-ascii?Q?ThDHJLB5wwdQlIRtAeFXGS6dzHbbXxYdIeqE12iDspFKv3OeSgpApGpgobsQ?=
 =?us-ascii?Q?byfDBvfQbvmT8d94wPNOUu+5k6njaFK7zla+3uOqgBgl8uzxpMjY6R1he5mo?=
 =?us-ascii?Q?TyL2PWO1ohk2fw8LlCRbGgDEDnJlZNwFbLMscHW4PuWQDwRSd/oA7xUAKp+Q?=
 =?us-ascii?Q?crcDZR1OgXSokXEShmHkbIaMPLulcSDX47Uhzu7PgLFwvdVqs7VF/KrbMr/h?=
 =?us-ascii?Q?NvcPd0YBqhC7DycEPupVF/1TJjWUaW1cCT+IoJdEniLWoD++vwmCO5hZYpkk?=
 =?us-ascii?Q?WHEUUhsehwq02tUYZXmOHp0ihK7bcbw0q5SQEKvptN5qZY32qAuR9QbzZLw1?=
 =?us-ascii?Q?6R2ZfbgNuYMLP13ifKAosInR8XH8CmHbXosFZIpYR3huThgyWw3r334QK7ln?=
 =?us-ascii?Q?oOCKzxOPafeQ4BSN2pH5OvBSJm4LhUi6t+RmPOA10AbyooMg/udBaHnKWZOx?=
 =?us-ascii?Q?lPlFVNlP/NxnABlVhlBg7L+dbSJX6k4rZqOs4EPurdeF5U9hvEcSzEB9rHRq?=
 =?us-ascii?Q?JLw9Ca3cZWk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(52116014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HkPPE7tpZqiR76SrNzmmMvdKK0xm9VOy8mHtRghLzzoRulc+5ESs+P/EqFjq?=
 =?us-ascii?Q?C1f6eVQ6Th1+1H+u6D9UFZLb6C1LLP48CiovJH2ZJ9H9kaJDIAKMRZUbdZzp?=
 =?us-ascii?Q?AANTYOFKNgh8kY+epowfAmod1CS5p8T99JL/RiUK0BisPgArTSlic0OiOkMn?=
 =?us-ascii?Q?BnloIP/IeumFDKYQha+P9JI5aHkZ2wwBoAAFjBNy7NYROmkNDeX3Uu2CvGon?=
 =?us-ascii?Q?zYSCtqvT2eRQMBAA08D+3hKzNvSC8HWZq4nXGxB93CczMp+o7ER7GXO6Djmv?=
 =?us-ascii?Q?RvVnaVMRmKDG1gZt5930cF3E2rodNR6laSLXwvq5fyJR95H7U6oHoDB0FOxM?=
 =?us-ascii?Q?bKf1bTxKXSxrBHMdGL+8h1geEvMoqwNIqtNWxkBobR2Cgr8HJWJ4zR8SlZ1J?=
 =?us-ascii?Q?q3zdrxcFrUocmbV/UG/F4BoiZfr9fUpDIL314pnlFYUtj87nUdVhabcJEHSS?=
 =?us-ascii?Q?OumaBR75ZWNySCBbj62PK9Ewj/LUtwLdO/i5whWgXx6O/bA0V0+n1G1b85xq?=
 =?us-ascii?Q?cIu7pTJsI7yBN/ippUgMytP/Gv/ZPmH6JKb1mnYsE0nGzjpaRk5SqhtWor4T?=
 =?us-ascii?Q?ebu+/Woyv3M3YhU0bMbEJfxCoJrbAbf957e9F9A02x1J3JEX98MkYN5OS0X/?=
 =?us-ascii?Q?gpIPiBvTGuxc1FHiE3K52Yc3Op8v1d0AJHjPEEBnD1cTHNqTpBU+MGu5ejWg?=
 =?us-ascii?Q?DfGKzJlrLLq7jMVR0Fs5R2jGQ1yRAO17oB+Nc2ngen5KWTXNZjSTCdLwIFVj?=
 =?us-ascii?Q?Gz6VrXLfqvLBRj14GopqshzZlUKXhTKp+mYnXU1rGcEhjTpZduwCkManBQFY?=
 =?us-ascii?Q?SgzhsKyByxFUv9vg1zOX8FakifagH9milf6AfEPb2Ysi9v4wPp+MKFtJNeSF?=
 =?us-ascii?Q?vlc12g1aXzAF9lulfbyarvbF6x8uB5Jcy2nZnWPf4CzxrwJX4Fe+S05fAbGE?=
 =?us-ascii?Q?jLQ0u7QS4RncqsrznEb+GA4IjypiSDNJGhLix76TPA0kKS5FSl1MX0LKhb3a?=
 =?us-ascii?Q?t0IwHGbrb6vSxs8IIpZnjTaNdEGs2nBJ2lpHGffrKks1CaAKj/0gxTnOyIFs?=
 =?us-ascii?Q?5MVKxxBSczMsoEym5kuU+ANwBDgHFW/QpADySzviHRRbFFXPczukw82jYgwE?=
 =?us-ascii?Q?aFKkulzJaTziZMfPZbyigukCSQXKTWMbHTpoOasl7BXPWWY1Rbhweo2wM9XV?=
 =?us-ascii?Q?pB4o57wpgF4+1Ckvwz1sKyrzIWruu/1AxmPyVsJ2WMSIbRDgzK7RyfzbGssI?=
 =?us-ascii?Q?U1RGAiiOPXDn34lvEGoZzjUxaaJn5c548/8i+kff+vhnv7dkBcHvN9NE3+Ks?=
 =?us-ascii?Q?3sYmduU9RFnaOnFbkwIyg9JBBREhDtoBNLyYWAaPNlL63T2pFlo0/EI62zdz?=
 =?us-ascii?Q?cKo6AEXWHsPqHaiU7P+ahfTe1RMlwopnJyLwnsb2k+m0zkovS4HNtWbjppU+?=
 =?us-ascii?Q?ZXUPFk4+zvAA45RLlQ9VkaNPUU+R575jrFnqmPr3A6WX85mYlG7U6csbqk1M?=
 =?us-ascii?Q?zd4QyCeHseWJ1fPBtPVXXnNZC8vh5Fv8SdenarlP0BDXQRxTR4klNsN8dCCk?=
 =?us-ascii?Q?a6Z61t7dQJgO7aGcHQ3+V8FNE4Ht0QkUr9WrtpY7MTxVQ3kyKIkqzroGAd+i?=
 =?us-ascii?Q?Kw=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3f6967-7fe4-4705-d895-08dcbc4a97af
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 10:19:34.0371 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LiQseUIPzkTL7W6TRfUk+yfttQP1C71yiL0ldh3GjOxcvvzzVb/TMWQLZlUEv9bfvXxrRChbMPvyMP2g+n7R8mEywTIzCFkfZ91rtio4uCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9524
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
2.39.2

