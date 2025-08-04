Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB60C87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 22:13:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F74E840BD;
	Tue,  5 Aug 2025 00:11:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="zTWf4kOs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF11E84005; Tue,  5 Aug 2025 00:11:55 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 831738407D
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 00:11:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/boxmeflc01uzWKmsQJ/GxPYMtx2e7nh7N255TIseoECMQFYik1bHgj5TEYoZ3IvjDjZPn+EY5ctTEZ3IdfCrscO5ijuf+XYLqdUBc+AuReaTi30lzVEROFR811qpNN8wBw9jowWBt+3jRxgvjmYuqPjcSP6CmoLlnI1u6WDVG/RwXqS741utFaFtvd6C5Sl1mrCIVFNNx8/taUSrEumFP9MQ+SS5ed6DK1Kh6EHFW3ObLAg5xjsKAN4dK2h8fKfgWZAccB6qdNBeb1tvs2QVTQTxTebGvCwTnoZzRseVMdbrAHzNh47xFytsPjXzVXszKMEhKy3uZTVJM92qZrEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2AMGtjEpXT5LVKEZaPzEs8JtYzEp4mZmzsHjBMpIrCM=;
 b=MDwVMsdc1hykFgnPvN/5M7MufMIRjiua0wucSuCz+BiMfT5/OMAb+5g1xXOtsvAApeDUes9W9Fmbv+i5qu1jrylSr+OlXXVmDevij/Ab0MRzxNSJgScns2coMMKuDkV4LWBkqACESiemHwXjnSUjbYpO/DSHZKiC8yNcSbGT7syOP5nd6yd3QMwP5ZRDCzjNoiiuZQ+Df233nOwrdCCpdn5812XTkxcXO+Y2hCrtGmqtKZEX+w0z/6dUEtk2AbS0n8ReZCGj7GD0Yet9qU2InFqnk3O0XQZYANsxGJ7r6qcwZbG+tJDbyHBfqBW43JM0zqrJzXaiwP803cAhIZeKfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2AMGtjEpXT5LVKEZaPzEs8JtYzEp4mZmzsHjBMpIrCM=;
 b=zTWf4kOs2QjV5zOJJMBJ/VwOWw/TZg/N7dvI1XIbHDrFLh4C7r1E+lJ77iZt6vZtmb66pm4TouHr3h3rMndyDbGLooqCpPgtr4pRhs5dBRpfL2qVkh4UzypX61mTQHgKEyN3sejxtEwHdcppjHbam2Uiuj1v4axcHC4VLGct4pH8IP52MFExf8TAD5CUn13e3DoTeihzOJLExfCaX3c1hCknXkHnS6nkQTIpQptonGUNUO7Q63YXyki3lZJ5IdqjXOoluNdx4U9uLk8yROvQRxW4U4S/AmPmxdPu8vnvXJwXQWnbmv+GOIKkprcBOsDWCMhPL294UCutXYYdayV9Bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB7771.eurprd08.prod.outlook.com (2603:10a6:10:397::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 22:11:46 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 22:11:46 +0000
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
Subject: [PATCH v2 12/22] drivers: mtd: spi-nand: Add support for setting
 plane select bits
Date: Tue,  5 Aug 2025 01:11:12 +0300
Message-ID: <20250804221122.1420516-13-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250804221122.1420516-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250804221122.1420516-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR05CA0144.eurprd05.prod.outlook.com
 (2603:10a6:7:28::31) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a681148-ad3a-4722-008d-08ddd3a3e6b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Pj3xvzMd24lFTcd9PQDudMpDYenh9fZtAxINz4RhELlJUKPdh9Nk1/foNsds?=
 =?us-ascii?Q?w9Bs1TQO9pgOWoDwgcnlx9rUJLCXIYeO57IP9HmR19fOEkKo2NIZQVFFMITU?=
 =?us-ascii?Q?t9COGTkCoA1ArhyJKIj0OPwhNWljZSt91Qd7rDlW1NlqxrEYN8us0NCIrS95?=
 =?us-ascii?Q?ySAgkKVin1Mg+0D5qroHgBZbXKsKESODurWc1pK3xbf0PP0PEy4Z6gO5yuh7?=
 =?us-ascii?Q?vyteZcbY4HWw7byyhQqQotQJ4EP1a5yXpjXxVjpZqN7VH73PRAy7CdtwXaD9?=
 =?us-ascii?Q?XOO6nUv7pX2MRMNy+jvA+sgh51vjmBbwxlsKmd6CwPKB8zpvdnPf1cg2Lw0T?=
 =?us-ascii?Q?dRoPSgBb9KTTmgnFbokgVoqjA12yedP3uXStGtAVIlbuN0tjwxjd0m3Tw+jH?=
 =?us-ascii?Q?K5XZ4iIlzDMaCE4sDq34/gQ1cxg2nvr4gGRMlXAvTvvGYn6YL8wZI6IN90Xb?=
 =?us-ascii?Q?snO1yNOe7pTtYO9jqBNkiQGumGvTvFkz3pSbnRgG3T06DB6+MQk9qw4Su0BY?=
 =?us-ascii?Q?Z5FJq3I5SYgxRMEAojNCq8675Artoil2uUCz90wuI0SEGWQhp+5+2RCxb5DX?=
 =?us-ascii?Q?/1R/61Gb8RS1KFkKUttPXvDpbDAE9i4ViDHdedQ6s4vKlA7y3NznRd+6hcXC?=
 =?us-ascii?Q?WkluTWSq/tylgH/DZ4G4UtpYDG9nhd6z19xbefpk4q7wnuYqvsC6fYCT1zBk?=
 =?us-ascii?Q?ONdBGHQ8yrWtpvhNxXU4SsVnrQp2QJ9STQ12oeG9QMOhjSZJ4lXRwpFrja2y?=
 =?us-ascii?Q?sNU6q+fhJjd2WZ/s3UluzJV4x1Od7yLQ3bxVsa7m0DzxqVtR8R1vBl9lEgQZ?=
 =?us-ascii?Q?yaPBkjjeuuu8lDn7dh39BEl4eohVkEyUEI3LPDHAndg5i11p9SI0foUUS/+r?=
 =?us-ascii?Q?N1eWvFWENcQxb1xq5BdeBYrmfjVdOh/jmxjl1/S0w7c7ijK4TqqfaoSS5jRH?=
 =?us-ascii?Q?xUcZafKJyHzIK2kfIn8oWb+mDf/IjiQ0ZhQo6An2LLMhWoGHbDU9JnsIJt/7?=
 =?us-ascii?Q?PtdADQ51V6TwZnGgvY5ctNQimJC9coV5cSzqa52L8MdjYck2FDTJ0zDG2dCT?=
 =?us-ascii?Q?aOuppYcZ/BwKaOOiLQmQiFIIoEthKeqKZAipkiH29hQ2u3ZX71PJdqnjr94B?=
 =?us-ascii?Q?55qLO7kVfCXYwAZ8OfXt9zDozUP8geGqbMpsQdPqmn6l7ZZhjJV4dyctDuAH?=
 =?us-ascii?Q?xkERcCtHcRvnHqLbCY39Uonoiw8O/rwccqw6g3ruFnhDbZMEd16wRkzVJFi5?=
 =?us-ascii?Q?4MiIyx2uhHT/UfrI3Miyk1SChQyLibArwNOp6eOqKOY15noTKg+gZKsSRUkq?=
 =?us-ascii?Q?PzLe7DF4OrNu518URoD561eC4FFKzPHb+POc0rmQ3fnxG7VZc+dpl17KfWwY?=
 =?us-ascii?Q?f6DEyrr71WQhXYPklbZiT9b9+Sd/lRPCtYWK4cZa4cUpOXTa4cNrmRPv8Rhd?=
 =?us-ascii?Q?10Mvw1AfTSOD+PQ78yTkOnIQTIWKzc/Mfb38NLyX2ZYbH/wnW+7ACZImiSOQ?=
 =?us-ascii?Q?wD/4xnrMeuYCawY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KXgcsnFMDipOanEe3X/CHeRt7MTTn6SlTpHd3Tpb82u5PvwvVefm3qxSBqdA?=
 =?us-ascii?Q?+lnvy7grHrdTzRZQpO1kVaa09XHE/7gaVY4ucCc7vkRhCALUtbm8tJWwBKoX?=
 =?us-ascii?Q?QO9Qjbw4/ZIhWWEZCbiWrvM3SyJWpUkGF7LE1VrCEcPcFnQSwSXj41jIYz8G?=
 =?us-ascii?Q?L3z1MUUkjLeiRmkZzHDcR9NgHeiM/iDerB/wPTYHKSVCr1bWAiAgyDGLlSmN?=
 =?us-ascii?Q?L29+h70ceUPlLM3yvWdoDSKWOLbQDKMeCtunYTMzoRvsiwpObabUmp3gseD+?=
 =?us-ascii?Q?cz9CL0cEnMyF87m8DXARsJkkkIw1cZeaeOMgK68A4iW+U8eQCyiu6nj8bypU?=
 =?us-ascii?Q?yPyxT8YcmmstKhBcJJEJnIzTw6ZgD4IZeLLtbdCt7lUEbTOFZVCgq8fyo4u8?=
 =?us-ascii?Q?bKr8u3l4Pp5ErVJfs2tUcu5fWm9LUw6j9Z30RObmdcSRZHTHwtWo7u1a8Ou1?=
 =?us-ascii?Q?QyUG3uvGDtgbguJy1TxyqH2i5z9wRomdHFZ9u+h4eM3CKan9zJdtAe0khgsO?=
 =?us-ascii?Q?JiMUz0+nXoD3zdHSi1R13RXonXMNP6Rj/IPMpszwjC+xUtbEQw02WYGd6IU7?=
 =?us-ascii?Q?fkZTaL/5YexESSrAwDGBfmLhEINDdh+wtSfbfV71tLWvIXq6SRAx96aNjq11?=
 =?us-ascii?Q?uA3t/CHG5ppTczt4bQBz7VG5vE7q4bIXs1CI1MZD2aOODHzH/uKnYir+k3rr?=
 =?us-ascii?Q?b6fzQENPN/iHLxHNNKLCsOHuDXRQG+pVfjAmM6RuMteEcXuuRYSTs6zHGA54?=
 =?us-ascii?Q?4OYECQXgYdD4JEjOBRkTumY7CxebkN32UIkPTWV0rKWwA8I9MsR+s9h5FUQR?=
 =?us-ascii?Q?CdQ40gmR0w65GYruWcNwi7Z+cYkhYx2oeCLEAc0wYyEGZz811LeGtUAIm5L6?=
 =?us-ascii?Q?/87m58x7HuQ89SZj6KNzWjTxTBil59zoeL91ykKCs2xa6p0oRf7AEcDZ62IG?=
 =?us-ascii?Q?huJ9E0aKe2anAkg09a+0kjZFmvbtLCgt8jGjTbIzF5qsFvxUXPT8JNESPPVI?=
 =?us-ascii?Q?gO5HYPiMq6qylzxgPNJP8x1HOZ42mCXTSHXK7HDmO7KxlckH8cN+dYduv0yn?=
 =?us-ascii?Q?rVgqg/1mEVG9usi6xHcNVMckfstJt1XNKCqEXxFYYuvJGDKqk282sXToMGNA?=
 =?us-ascii?Q?xwRa1IeeEDpyL2APpG0JX/CBDVnDIXL0hFFCExo6mQzzYf3deFw/kfRwzCkr?=
 =?us-ascii?Q?21/JZNXc6heEAchgEYAGP277Y3UkHviWPlVI/3joTpnYiFSG0qpApcbgXqyI?=
 =?us-ascii?Q?DlTusl0IasO21juHmbBKhb2N8kX+87gEC4gHB3E/6aV5/vWHybJzvI0NA2qZ?=
 =?us-ascii?Q?esVfnYk7FCVSycGdsu+Pbw8arQgZtSZlQ27AbQo+nEoFOc0GpfjsxiMhOlo3?=
 =?us-ascii?Q?bajjDYPjTC/IXQFlrPRWITK+9GOMVoAyNh4J4dKpnZwMUaqI64Q6CefcUb54?=
 =?us-ascii?Q?KbLSmq+IhOlL81rttiUEBlJ6JgYMY5eQQ4oRGB49l1eYhDM3Btr3LhxfViH5?=
 =?us-ascii?Q?W0I5fjy246EhmtkB94iNCL0TbrpglTr9oIlBIntfTlIn3VqNY9l2SmAGoXsa?=
 =?us-ascii?Q?3gfg4jYrwQk6n9yJq4S6tXgsayMjLPoGG80e2hOSh0L/P03wFGdPuopbdnC8?=
 =?us-ascii?Q?oA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a681148-ad3a-4722-008d-08ddd3a3e6b7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 22:11:46.2069 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YVV7g5Kj6YbyBxenUmGInGFckvQqhlxGyC/NH/fdFcyJiP07yXjGtUbwsr6mvLOxvBkk19RTtB0YB5ojZBALAKnRhxfvgy4V7ASz07QSRMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7771
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

