Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A765C83F1A
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 11:44:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 466698389A;
	Tue, 22 Jul 2025 13:42:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="P1krmx4F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5818F82E26; Tue, 22 Jul 2025 13:42:12 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06FC58388A
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 13:42:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=weQmpRUtHEKuftxwoOobcs5WCorRFysOxKOyNdvwtLYl0GCL3YaJa2PZF8cTD8hqW7RS4XQvam4u1XbaCzuInlknYWWF1yrAAhUtcDocPYI5XG5CbL8Mt2dSIvc6Yh2piy5nBlvasMlKMBrOP/UGf0C7otD+kamGzu2fS5BYbSZUqTqnFDT3uVvIJIQGO4gLwkUbUrJWvRf7+FYet2yQS9PK1OUssj1OtQaMYuaYhtdNPz45Dxk8g4s3Ifx6FLXMVtx7NC+AQ5dWArE5XJUTwQld8MeF4jDUzj34X1mI3BL3JeKlwkiCfcfHY5939AOB8SzwbFUZCRVDNkwPViYSFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2AMGtjEpXT5LVKEZaPzEs8JtYzEp4mZmzsHjBMpIrCM=;
 b=jOGtdoQK8CZjafAEvyL01K3mXMuywBC9PXAodyc0/OrJIvYJJLhbA1lIr9JD2OTw7YkjzSmqqWniTB32Qp7ehMALXg+pYoLiWaHTJTWbaahDIFujInpQmZLsd82C0U3G5668KgPD3T035tvKnrtt9MBvy19a0Y4wJ/QEb6NWQfSQnOJ+4CltuyW7t/pCKQE3+/g9Vt0a2kZdY+/nvSgwxSD4BPtlXE2e44KOVxRYTSLx4p74GbjVL27ltdBMAjbIuCzDEUYuFkwwn/lTevgGuO+UMOXifGXUOXxhCJDYoI502qyzxCDaM1vOk65CY7xz0ZIkvy+GZgQbjhT2ZOubAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2AMGtjEpXT5LVKEZaPzEs8JtYzEp4mZmzsHjBMpIrCM=;
 b=P1krmx4FtLluwrqQkyLt7X6sN3LWZv466QtXEmU1Dd8xKjw1xI2yUuHBnNdomSq3wed6CFvr0P+tiXhRoKwcJlsQFQa+yq0B3Dt6HJF9b8qrx/ggP+DuleoyJgqLpsKGRh0hLpFvzSpP12BaN/2ht3at23zUNCdMiQhWItWMbF19Gqbl3in1K56ea0mBLFbfeObpaNUu0Bh34P4aqna9ymFHVD70bISw2jGuymduYcCoQ9QvKvkpccDlOW7Kmh2OhdluAMsqt00wGoeubSlvPM5v9Kuv2jW8XdQHAovGJJUNV+Z6cIvGfFZVt9lAOPM3eVHpRu42IDQIH503pmLuYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB9908.eurprd08.prod.outlook.com (2603:10a6:20b:562::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 11:42:08 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 11:42:08 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 12/19] mtd: spinand: Add support for setting plane select bits
Date: Tue, 22 Jul 2025 14:41:28 +0300
Message-ID: <20250722114135.768998-13-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250722114135.768998-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250722114135.768998-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB9908:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ab1649e-69fc-41e5-bcf6-08ddc914c97c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|7416014|376014|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NcRwl7XjTtLSADNodn6gSHgxIioT3aPKSQ1qUa36lTk6sIedMQX4PSwrqLsE?=
 =?us-ascii?Q?MsL0xWcM4QPtOuogSGW/P12FKOSGS0qd6JryyZzTOZXjPDeGXhypw64GQlFG?=
 =?us-ascii?Q?jty6kP8zFr/rsgrN7TAJb9Oe48VOIFmnxpTCJ3FFB5F6irJqXLdJCDMLzds2?=
 =?us-ascii?Q?5EGeNIO6o04ZiFDKuUuDtlQcOOgkdq+M/h/FU/zc53FmlUyS/zVeVMTbCPgD?=
 =?us-ascii?Q?AUb1G43OLOVVqIgqD9fTOdQmsiFL54oDWKOKJYsqTmlowu4dWe5vS+M6tBJC?=
 =?us-ascii?Q?ZNaRWGBPDxnmTyExHy1weUVSYunsgH5/7yH1dmQSL9jh+53AxE8DV1xDDT8d?=
 =?us-ascii?Q?7WWKZ9ZrYjNjyYAY0z+zr6Opoh1iZXhlNIRhsAROYxIzUqqp/RZgPggahDVm?=
 =?us-ascii?Q?ZcQsTZgx0oMtSf4UtqZQTnVne+3OgOFrCX07RUV+bVtMoxzGOwcDgBiAxRRq?=
 =?us-ascii?Q?lLIa52hK1nY3g2JTBwyZCNBDUVypa7/6CXEEEpVh3x6y1kxl3YfJgD/mGZ62?=
 =?us-ascii?Q?uUGdV21uUYDekBdqFhTRc3TP5zsrX/c0SJfCSNc7klrnQwz8xKoD6BP+hI72?=
 =?us-ascii?Q?qtBjrwbqwZH2YSg0HHLpqkkAmEyI2M3WbrHx9Z9AorPPyX7torg9IItjVG4Q?=
 =?us-ascii?Q?Mswi56ezLGHAISqWuXqkEjf1QON+69VNtpUAOq5cdWGvcvFYPmmdkJzJUwS9?=
 =?us-ascii?Q?wNpvgTok7TKkMaJhGXYzAPESmqCEjDSTIiUnjyHphyO8aIvF91UtoROR/r5S?=
 =?us-ascii?Q?K4RfifcC+27acFkNv3PfEsc3vMP3nRAl6Y2m2JVfJjs95y3hp+rCenAvI2j7?=
 =?us-ascii?Q?oOCbFchf577lYTrCtQdxECvpybgm8Xf9aqLY/IfjEVL6w2SgjEkv86xdTzBr?=
 =?us-ascii?Q?+LQGqS6dwV+8MJiEbBCpZzgoigN1eiy8AgeqThpthjw7JUn7ProP/plDNq2p?=
 =?us-ascii?Q?yKDq40j1sprlXJHi3ReeYRF/ha7w/LyB2RiudSKKEfs55A/SpXs59+GAkdL6?=
 =?us-ascii?Q?QH9bVw/0zUjB6uDqdL7dtp0sm5A0KlE2sDN7xYi7bK2+L93T30WB1e+bvuiH?=
 =?us-ascii?Q?qiGEW8Oq+fb7/OJRkyxRC2zMwrspI4m5ndajcTCGJO+rHf7CoJTRnESYQr3j?=
 =?us-ascii?Q?wfEZmsBRRl+rkzVMXHXoMJv+ZphQq1kCzq5AKYyK1BNGhW1cBVfl1bY62LPa?=
 =?us-ascii?Q?F1JcmglAsXJFcNaVdxHHQNccac0zM//bBKpUcvuw+KNTOvqk5C6fE94hw8/3?=
 =?us-ascii?Q?xhTU1czXL43KFipRMf30FSXIB0JozaMNXdHC/eDBs23OOSxriB3UQwWlPbE6?=
 =?us-ascii?Q?TSb8w1cUrN9oSnokTs1qQlEh2Dmyygyhn+wG17aZoh2H4QO7QE1e9PkZmXSW?=
 =?us-ascii?Q?RuHIErUe8DMf3458R9mWSqNv/jZMylB0BdBc9PbE/GTmIqV9S7hT/tt8WGQd?=
 =?us-ascii?Q?SUwfSQNYnXW4IAshMsqLhjnkdMqyFZKlXYYjaOr9jz3y0E/hgxjYStkHR/n0?=
 =?us-ascii?Q?PBn22LgdGx1Suns=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ab56bhnpUNoHFz/1TGsg+guyAH4kUPAw3aLEXErVzq2lltuCaWuDKdYW3hH7?=
 =?us-ascii?Q?kBkFj+FXAgAK+xT8jzcgYdAzFbqgscwm0prpfG269xctBeywOZcjmXi1UevQ?=
 =?us-ascii?Q?BME/7JF9ai3bYnCUVLQ3u9FryCg5T/djYImGYRaDRRNkd0sb8u64s7nfICO2?=
 =?us-ascii?Q?g5E8tNyjwn+TWfKwGcbeTBNnclfUDOwak+bHme+XvtwGfQihhAHexcKDwlJ0?=
 =?us-ascii?Q?Xq8s0N/Yd9QBDX1UbU7+UzjbOP9VF6geSHc42urDzUBCAweEzyhrOiVBEGBj?=
 =?us-ascii?Q?Nfm9BKKauy+lHmkUlwYXZQPZCCiYGqrod/zKRpnwzz92hbvTJuW+cDJbOr0O?=
 =?us-ascii?Q?OVEkX9NLUzVfrt9E2AMSO3zji3xoR+JK9IShUSNiLEcpZSB94oiVQbZxa7Yq?=
 =?us-ascii?Q?/Us3/rn7J5q9JwS9tLdw5iL7XwWHOF98MMeabw8L0xiPCeb0GRKz5fXOZKLl?=
 =?us-ascii?Q?leJ37S4TD8oPwXkbk6xFEsSsdnTDZZCn8rOWBR+h/GoEkp8L7fZz4iFHPz35?=
 =?us-ascii?Q?40wtSuTr86wOt/U7cKw3ufF5XLFBFuULnB4DuhRoS7JRiHOxP0AJ9q9RX2DG?=
 =?us-ascii?Q?TwjEwxN4bqNTGw7ID3JAfcssyL8sVn/E0Jkm1qsgA4Y/gxcdkI7KMZ4tQb9s?=
 =?us-ascii?Q?DCa+QVBwEBa+lQWNtKTpzrqv4EnD3LOVxQxBpxIaOSM9l1vbzy1iCkt5rSWE?=
 =?us-ascii?Q?zg9hITAAz0AEJdGQvgqv9iTak9rvvH+3U2T55CUUF609zDVXuK1HMkoCauqB?=
 =?us-ascii?Q?cttXMJemQhXM9D7BIl23ONTD3QqpvnwY74JNlqFDGLLa5vJHJj5udShbWfOR?=
 =?us-ascii?Q?G3mIrUEAw2xX47t8W0Jc+Fp/Ix5rv6+qU9qX3anW5L/Tj/+tT3Yb6iS333Ya?=
 =?us-ascii?Q?tsGttKouIr8wdxr00vegMjpHF7qhgV5EtTSWQc1RQtHcRYfSCE/wQ6byCl95?=
 =?us-ascii?Q?d3W0tB+3Dsbzyzyfa+/eXHFDVfFD5lckj99giHWqY5zR5LH7tP/1ptKO4k44?=
 =?us-ascii?Q?dSN7HNFjmHO3vOY7RkR4naGjxzJL2wCIQyWTnhXKvfR64TfCa7OfVM6ttuc4?=
 =?us-ascii?Q?zFoLxj7ahvyFb6Il7e5G+zeMO2IOSUk+zi4EtHKOnj0CWOk8XM0O5RFhzl9W?=
 =?us-ascii?Q?yLx5YSC6Y2JamQT8j7WLGmHeKSgn5mwX/sR8RNeHsEwTMRGk/vdLaKnww/Sr?=
 =?us-ascii?Q?akp6FFu4isagrWfKGW2SDiza0JzNlHQJIF9J+DWFCrefDdIPVxdvqbGbo0YP?=
 =?us-ascii?Q?KI7ZMNTsmmGNu2SOlMnCqPkKTOND/8fUzy/kFbuRQDaod019tlAOPT2pX1Oq?=
 =?us-ascii?Q?xwu8KySPgGJop/2WtkUD+3lKtC610xvNCxnybal7QwuWSFuuROc/LhRwZuFh?=
 =?us-ascii?Q?4xC2c67SU6VDYgNQi1L6mFFFEV0N4w/ucXjoFGLVjcxPiUp2/SquUvpUun71?=
 =?us-ascii?Q?pQmG9s1X7budtnLPs/tLu45S9CUlpo1Rt4VLeMSVA1H7PkLpEgmYh13ObkZU?=
 =?us-ascii?Q?e0oxqGQGhKd7rrIeP1orpWN2jNEoKBRf2agx8uhwfXb/M3hefaFAiBMuYNka?=
 =?us-ascii?Q?LUs+zSZrO+jtiiNmLUzd3d6S/hKJ1nxzW3C17mxor4L7EhHcyQWvtcI64dhp?=
 =?us-ascii?Q?Ty/2zXsrx4YWbHW7Qjgaub4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab1649e-69fc-41e5-bcf6-08ddc914c97c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 11:42:07.5514 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CW34qxlHR1HL427qcnQOmcf4mV0AW0Ig5cYBA2A31Gxv4D2mmoTcWCiJ3ZEkI4FxP7Ex12bI3Vz01FlsvSi5FBZ0PT5EWpXm8OtqQ9pEkFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9908
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

Add two flags for inserting the Plane Select bit into the column
address during the write_to_cache and the read_from_cache operation.

Add the SPINAND_HAS_PROG_PLANE_SELECT_BIT flag for serial NAND flash
that require inserting the Plane Select bit into the column address
during the write_to_cache operation.

Add the SPINAND_HAS_READ_PLANE_SELECT_BIT flag for serial NAND flash
that require inserting the Plane Select bit into the column address
during the read_from_cache operation.

This is a port of linux commit ca229bdbef29be207c8666f106acc3bf50736c05
(mtd: spinand: Add support for setting plane select bits)

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 6 ++++++
 include/linux/mtd/spinand.h | 6 ++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 7ace61fd19f..0cddf2dd742 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -382,6 +382,9 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 	else
 		rdesc = spinand->dirmaps[req->pos.plane].rdesc_ecc;
 
+	if (spinand->flags & SPINAND_HAS_READ_PLANE_SELECT_BIT)
+		column |= req->pos.plane << fls(nanddev_page_size(nand));
+
 	while (nbytes) {
 		ret = spi_mem_dirmap_read(rdesc, column, nbytes, buf);
 		if (ret < 0)
@@ -456,6 +459,9 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 	else
 		wdesc = spinand->dirmaps[req->pos.plane].wdesc_ecc;
 
+	if (spinand->flags & SPINAND_HAS_PROG_PLANE_SELECT_BIT)
+		column |= req->pos.plane << fls(nanddev_page_size(nand));
+
 	while (nbytes) {
 		ret = spi_mem_dirmap_write(wdesc, column, nbytes, buf);
 		if (ret < 0)
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 011861dd059..fb3a2e5d909 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -316,8 +316,10 @@ struct spinand_ecc_info {
 	const struct mtd_ooblayout_ops *ooblayout;
 };
 
-#define SPINAND_HAS_QE_BIT		BIT(0)
-#define SPINAND_HAS_CR_FEAT_BIT		BIT(1)
+#define SPINAND_HAS_QE_BIT			BIT(0)
+#define SPINAND_HAS_CR_FEAT_BIT			BIT(1)
+#define SPINAND_HAS_PROG_PLANE_SELECT_BIT	BIT(2)
+#define SPINAND_HAS_READ_PLANE_SELECT_BIT	BIT(3)
 
 /**
  * struct spinand_info - Structure used to describe SPI NAND chips
-- 
2.47.2

