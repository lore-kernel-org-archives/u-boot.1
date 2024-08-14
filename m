Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B892C3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 10:20:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2CF488A11;
	Wed, 14 Aug 2024 12:19:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="VH5KogtC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2849888CC; Wed, 14 Aug 2024 12:19:49 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20709.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::709])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6E48888CC
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 12:19:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZyyJ4RbHBx+xpiICHbZBVodz085/NbW0NNQxc3hq1H8hSzlmh4g2BX/ius6hg1eAjnqM+RJtKxn0FeHITamOhf28KoFKlnq4TFvZYIBcrJsJc88H6mptC/LI2LnWxQYn1i2+2AtbzwZDw2qY5qQS/VbgPJ+XyFMovVAhcXpCn40fODqLLDUFl7weG0fwrU0+p/W1VANoQX4KiPFShLeeqNT+UJB0VatAROGkWlUqJcoyAjjrx/YoeJJvXY2B0SqEo6rh0+abudaImGfhldf2UQ0UQmWpwnq9KfsdVVhpkFAabu5Cl6cuPEzHkBNMJNI8k1dtexWcKe5T80JmKFuR0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cD1mj2G6WAQYPXqJnb+M4I/Qc2PEB3pWrb7Vqd0G8vE=;
 b=fXA/mr6DPAlDREXSZPIzsg9kyhGYezbAthLmK+6fq3zP07gSxvDTQPIyfQcvAcFrc3MgZbLKfqAbtxjnOKyKUP59HnJDFTJWQDXvOSnmToIxhsfaSMWZjVN/XkrNZx9TJuv/pXAGeBFVBwgf7yTJy3Llf+RLH1HgDDIZQXse6PBZecj4cBVYwWozT2ta+cCmqQn+Jjt263KeG0lLgqdlxIWv9lAnStjw3JKg/wOqaARQO/sv1F30Amnz0Z2I9sfpRSJOvSZpLMvg3JIr8tX7AzqICakG9m2REFCcI50/cnd48zPCW4CyEErhn1Bemx41q409BN2H8b9pcioViMVWZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cD1mj2G6WAQYPXqJnb+M4I/Qc2PEB3pWrb7Vqd0G8vE=;
 b=VH5KogtCIQQh2DEvxCDpb3tuby2J0LKAsCCM6LG06LSYAWC10sWgg8qsjRDyXagYYmWOZ2xM8ZZcC47ia/ahuXARqV5W2wJhA4ax8HTgAz2qoDeXcr0zSOg8FyeyJp0CsHpCrVNwP6v4rTQsGIRtMt2J9h/crRpaTZL5JylYRC7c9IERtzY/ZX1yvFueHWZwIvbxfO4OXl07mGVFFgMgeLXZIDP9yDhCLtnrE45pM1/dOxYxiTOuPO4pBTKWR31yGIbj6TXRIqg9H/rU1+JExG6khl/lXFmQDn/SETiYJv5jW4L+KcGdmwZIGuMtQjb+NWE8BcopgPIiJmOOh8AOEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB9524.eurprd08.prod.outlook.com (2603:10a6:20b:60c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.16; Wed, 14 Aug
 2024 10:19:46 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7875.012; Wed, 14 Aug 2024
 10:19:46 +0000
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
Subject: [RESEND PATCH v4 05/10] mtd: spinand: more use of
 spinand_to_{something} helpers
Date: Wed, 14 Aug 2024 14:19:13 +0400
Message-Id: <20240814101918.1347167-6-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 290e510e-bea2-4151-7a3a-08dcbc4a9f16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|52116014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ppB50ft1VPkFp9xsBhrOj5ApDRWmEwa0n4XNrXyUN7UDyMInZTlI08a9i2co?=
 =?us-ascii?Q?2e3qsvjclzfvkp1+P5u4mGNlta+6CJ8BL+qexbHJCXvdtmuEcNemah9Isn5+?=
 =?us-ascii?Q?U2/UZIm3IOiM/YvLwxLSzC7Kqe412QUvadRNWwHdGGsqghMCQVVfW8ruw0FJ?=
 =?us-ascii?Q?twXh7Hgd1MWzjDLKgjj6vO8iJMoXGQqNtM+Kui/k5XKjZYxXhh/fY8BWA1Vh?=
 =?us-ascii?Q?ks6jCXIE+4QOGFI1RZvm4XH94aXDJ5V67EpMIxvu60ehkMqEWMFMJc1kANGB?=
 =?us-ascii?Q?VgGMt2oISMseH2FeXWgU/nn6tr48PsM2h/Qrae6Mp8NC+ei2mpqKlkEQ93w+?=
 =?us-ascii?Q?5rDMnwFRy3Z0Q6KXFvyR3d1G7dZlD9PDI15WBscYgVJ7RbOXRGoJ+tGFBCAz?=
 =?us-ascii?Q?48d5N6iFwtgmDKPL44EFnWfySz6vdbZ17P5JkviI5/0g6jSTj9+OMkzPprOA?=
 =?us-ascii?Q?aHc0JAECMaBxCOROhjVjyNAV9nFVX4JU9CsWapSfXlIjqjBGD3YehysI0+5w?=
 =?us-ascii?Q?z04KMey6ge/b23BuYcuzzAGTx/ok8Jl/mrZfkvTcyGYtLF//qLg0pxolDdrO?=
 =?us-ascii?Q?XpOBoQZpCBo0qGIKb1+F7Im/gRQuZ57Bh9ARPE51yknSOMVAmDCzDynF0A7x?=
 =?us-ascii?Q?NDEbQUSIsVAgYnvqwvJcbzFXUaochAwrT3Y4EfMigs8e5z3x7C7kj6OO7lMU?=
 =?us-ascii?Q?f8l08NfrJBEQyTG0bHpl0csVxBvTHkUDLdJY2EPuSM9yl4BdPGBv+4F6Z3H/?=
 =?us-ascii?Q?kTGThLtU9AagC01ExbmutP3j/bbDOv9FHNbalDw5akoFBRnGLumhaQ3pj+1X?=
 =?us-ascii?Q?5EgHKST1jDfPs9cxe3v/awTPdCKKFls9hxb3UZotHEaSq35Q96H5PKEphLye?=
 =?us-ascii?Q?7p4acRh3KgRvzkNpy/GvJV0s6e6/cNz7V6QrGGkjoo2j63pJiu4yUXQceZ++?=
 =?us-ascii?Q?O3eJVqnC9T0pTbq9jD8JhpRyfVLscIS0nu59KmO/SGcxey59rT6BOysLRWqa?=
 =?us-ascii?Q?FB3gXzib9NThNbjvMXxF7mDRNKhjrQn7Zu0WyyXmmVcEeNecTqIcMvYNvK9B?=
 =?us-ascii?Q?kUtSbmh8DSvexOLrBezJ2UHia+TP1wHrmrbiEZ6yLMt6OwN86lOJZ6H9jgNv?=
 =?us-ascii?Q?2uadW+5//Vp6k5ly0p8FeVe4eLH2ZqhFbHXZ19VJvUXuJFU6aREog6J6j44u?=
 =?us-ascii?Q?CY60yuJUfqM74PyRWXSxz0GxKwKbSgDOz7vKieb1SDjV0HPwHEshvvAL8Er3?=
 =?us-ascii?Q?EgbMjMfeg/b573+2suSmsA2lEoYRo1l9jW9PGdNBgpAEQzxE+oYCE0d6Bs0U?=
 =?us-ascii?Q?9MT/o/JmFof8+dEY7fOGNIFjZfksfIhxBqeUMrA45PQbATMnbx3aUpeo4TYI?=
 =?us-ascii?Q?T/mRWTd+umdmm21rel6qQf4VcUY1K9GizwYjWesRDcSZcF1y4UVUU35MT9eh?=
 =?us-ascii?Q?o4stdhAHwZU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(52116014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HkeodjEeNDVO1lPZET+60+Cdt1sNE6RkC9VXdc3M9jPQJXb2edpT/I6Q2NBP?=
 =?us-ascii?Q?fTADm59PuR1VixU/8MOdT1YZQWs0tP1RBPAmyaOLUVAoqtR737RpD6XcIllb?=
 =?us-ascii?Q?pkyDPYiHaIlq4O24EKdq+bdhw/ygvbX++SEHL+wMhCznxDMzFtCNm+kLhYr+?=
 =?us-ascii?Q?6VHZaXuBcfj52Fp+tqv1FuZV+TntMjwd2TedEcyl/x+xQP7LUYF6IhjYIsJI?=
 =?us-ascii?Q?UNfdM6N22VOX3on3mNEjLN5vtXILd9eLG0/+YzRSwEFc1NreKKwxfLPY0y7o?=
 =?us-ascii?Q?2DNILoyi993faCUEJqjY8BPn9sIzc30nnNbFfWpamQVPFJnjI6lxE9b1/HPK?=
 =?us-ascii?Q?RloBPNjDTQX5DOz2jwr8iTOsuEqBgzjPFxfqfD2lz1j1r69OKoEToHQEOINN?=
 =?us-ascii?Q?rU2aFvP5RzDKybkEW42Oqc3mfnKvFlUjkOUm+oSB7gALFlVFAzmOcCyPvJ11?=
 =?us-ascii?Q?jo5z2529kHAhQ9vSG69GBRjEN9JnL3PNklUoyjvpq2lBDmp6Wtgz1diPFgt7?=
 =?us-ascii?Q?HKB4DW+0MlDnvjWpKNLn1Pp2xH1ylpJYw7L7ojBKcE6iRxXBirKgxKu8N9lF?=
 =?us-ascii?Q?Vm51Lds+t79dvyk3eZ7OvhP7QxRvvNsqXgci4LBArpy+Gutwhdxm+Z+bZ9Rw?=
 =?us-ascii?Q?2LPb4x+ZtM5O2T5hIQsPoTuqPOe1usyBxm9FXHgMRizglBaiV1UoKj5jD0f2?=
 =?us-ascii?Q?xL2OwjpQQ3iEG5SH+6nPKasNaxQALCmPXx9IxcO+uJrAtZ1E28dH+qy3dPTQ?=
 =?us-ascii?Q?89voIYdu5SSn4or0hk66vx4nzD/bT4uQDOyrQEYPUyTkRmknP7u1m61tPvzv?=
 =?us-ascii?Q?xu16hwY63YteyIoqA02MzGR9lhvGn+Hh5RIiFPwtaaxY2tJF3EbzB43TZk1q?=
 =?us-ascii?Q?JeeJzobMzcC8p63N7V40HcUwXxY4gaviPhTFCnsK9hr5iLa1rL85H7kaOOKX?=
 =?us-ascii?Q?sXxcXZOjbd8KfJZ0qFBprfJmtFu2/xA8CJHC9mmwIZs3jYiwhP7HIthYW9d+?=
 =?us-ascii?Q?t06WRXB73y7i9q96PiOr2cvS8rdDHT9zTPMTzNZBHvoHUxvtaAwlharfqgk6?=
 =?us-ascii?Q?GM3rQouHJYxwOAyJ3zHWVBb5zBionzOdXeJ2FIoT7XE+gmnmjeyCZ/9Gpca+?=
 =?us-ascii?Q?wI6fWe2/dTHGRzzYpPw5WpAzmlSMsSGO2DLPYZR4EOj2hfLyLniciJWPKini?=
 =?us-ascii?Q?/cjKOKKIO6qdbkTHWSt5YW+BqvHDwMa523RiV68W3HyuO/vofyx2GOTv2RhY?=
 =?us-ascii?Q?K8GWcTVAL4oJ+9GcctG3TaR2jH8O1YmM+a+Gx8SAiQpSsa4IkNVSVSAfgzrA?=
 =?us-ascii?Q?TrBRNMs2u0KjO8lojd9Ijxb7m/gbBndMSC0q1nVxtDSz+WXFZFCk80HHFgSn?=
 =?us-ascii?Q?6EsU6dNjjOJpoCxtu0Cbx0C7vzU0jhxE5Yo3NHdKPDjD2d7kHORPme/ix0KA?=
 =?us-ascii?Q?zJWpNyHuB9Szp0cdC6nlAXupbhaxEQCY3EYgPXVJFyJk0FBLLc6SJiV/tXds?=
 =?us-ascii?Q?LsTJdmIWlqe4OKIhccXjYwtr8Hjmczt7zwpumS9pfY9AhUVzcVtUY8BrBg1v?=
 =?us-ascii?Q?ZQQNtWFY5aHzhGpj98x8oOoYw1sJmEFDdhhjRgcHx7493a1ZAeaQdQNQTf/8?=
 =?us-ascii?Q?8Q=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 290e510e-bea2-4151-7a3a-08dcbc4a9f16
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 10:19:46.4133 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RIaQbz8iQvaUtxtlJdD6oCD/fYf34Lnh9eeoMBCBdh0DDjRbq8Ob81Qd8iFRxChD1dA7pffrpkVYV93yIyaBgVPqbDduj8g7HAQ8RaNFJ6M=
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

Use spinand_to_nand() and spinand_to_mtd() helpers instead of
nanddev_to_mtd() and direct access to spinand structure fields.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index a10605487f3..b58d9e00907 100644
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
2.39.2

