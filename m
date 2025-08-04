Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB2EC87FCF
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 22:14:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C040B840FB;
	Tue,  5 Aug 2025 00:12:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="4u97aCin";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BEBF840AA; Tue,  5 Aug 2025 00:12:03 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C888B840D5
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 00:12:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xuNlRRnebr2Ad3VM64Y0vtf5+NTOJ6swGT1WprCnbtHjH3H2m/otDj3fcmOISqTYz/jyIZ8URh5vocsOGwy/nLjAqceZjV+qvRWMjOoVL/y+v0orrtKPufMJvX8D4CZ+4JXPaLVuI+8l1mvrTLz+t2qpwU+Ue7LA50ajsXzfSTjGQFfvZFOTOs31vGK9YYIc7V3hqbLjhuBj8fqD+xvXqItw5Xwptd39hVVCEiG0i+TRIXeJYxo4R4uyGlCwCHXh5wR/2AiS7q5w3RlQMJ/YJQK97b2zKzGfd/MUyG04ZoK/zjvRxHjd4ZAfT8D7ClykusGSTkIQUYHYCSsEMnpi5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/fI6bGy4YeMo/8fwMRpD9DJXc8Id538oOnYwsFgeaI=;
 b=NqCLib0E5W/ongG5YDb1yS+dYgIbrvEzScdSegydtvhLvhI+QCOH0IU9g8BgDLMF2r3BKxUcaNxagGkxGxFYk/RhX6SPBP5yXBgjBDdxZLROYizpG+ucTW0doHXjKVLh4T/sm0f0zjKZAK2c5OwzCSy+VcxaFqOKF0DQymTbH0tvNrCMAig7FcHCSKM+gMuF0YPlc0EgsjNdIfb9nzj8XCBX0gphShkW1cTkRCM1WiVBP9CyzdnjAK9Wyv6ZVZUI4JBtBs5XjyFrpTNktYqEcaBXDuMnB2SQGaDhSNYafwbexbf9e37qpSRUPglhLxqEwmFKx2ZIOuqunIjY8vSkPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/fI6bGy4YeMo/8fwMRpD9DJXc8Id538oOnYwsFgeaI=;
 b=4u97aCinXnIXV6s9rbc7u7brg4Cvj0e80EtghXXNIi5y6s8kD5mI/kR+DCdqdzuCPuwxiEFUq0UiGav2NDjoH+2z3KUjTeAgHTdYMsdVoIYAbrXRWehyGTuyMg4AewyegnrsYR400DwlQHMMTqcSfizDfqKq7sgn2+yXXLoJyooBL44w3/q4xquSSgvpr3pRYKCzSP3BhN/0MYzfvz2sIM8TTqH/7X8xeejR7X8P3746WgDU/1Ek0M9YbOlPwHJLYZEmz+SdrQl9fJLCIabA6gDATpVdphnvSNev/6uNocP2racCgQA/faIkzStAq/cJ7ElbJJvOub+cxWjZaCvTvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB10194.eurprd08.prod.outlook.com (2603:10a6:20b:63c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Mon, 4 Aug
 2025 22:11:57 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 22:11:57 +0000
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
Subject: [PATCH v2 21/22] drivers: mtd: spi-nand: try a regular dirmap if
 creating a dirmap for continuous reading fails
Date: Tue,  5 Aug 2025 01:11:21 +0300
Message-ID: <20250804221122.1420516-22-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB10194:EE_
X-MS-Office365-Filtering-Correlation-Id: 52b0549c-958e-4b7e-deff-08ddd3a3ed44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hJdGMMU6G3o0JVio87JFoqEU5D4KLHgXLzWfvolmU8ybiFy+dfwq4SHzKGL5?=
 =?us-ascii?Q?NcJxLTBzC0eMPGU2ZXKXCRo4de8hV6VXPBV4B7hH1ZuJ5Ty/ppuAbS7TrrxS?=
 =?us-ascii?Q?5k+kf2dYEK0T6Beq3IgczGS6DO4P8amtPXTfCJntGJR3zJ/xw4EkQwHOxEt0?=
 =?us-ascii?Q?NMPJ1vj1VSFjpN/tKkTa1yP94mZRI7Op09sx/+9SdEpHRUrBbd7iDt9FHVxo?=
 =?us-ascii?Q?O832Fr8tWqiCvJsJnN/gvr1DclXTVLnWAvcgu1hy8qqSQ2k+6GMuDsJONrEr?=
 =?us-ascii?Q?nNlq2BBg6260GIBeol66OsmEfjGINB8OOd6D6cVewJLmyFEkNNAO2+Jawq6M?=
 =?us-ascii?Q?dCNY+/q/hfK1yWbxx0QS6yiSdb94De17sqjKkgXKMz6HI1SFN8ZEBAVHaL3k?=
 =?us-ascii?Q?26AA/dDmpPu4SftU24EQ/+05wtwfw0R7yEq+kuFnu9Z9TgKrHTDMmccXtFbl?=
 =?us-ascii?Q?2kCyIzFlU2JeFscQKkvyVIbndXHjRKaILE1FenRXDhQBBDTADw1Nmph2VM9Z?=
 =?us-ascii?Q?u2Dtx3XCJxU+LIU3Q2VnW3sOz42zfCCTKwSHsD6hKxaYsO2/7iaQwSncueQa?=
 =?us-ascii?Q?vVkzvqL34RyGTBjL+bPKoQp+ODsZMsEpumvroPBVbEaIu32ONyQmj9pn2KBG?=
 =?us-ascii?Q?G0C0+FmQ7gv6Tm0lqoiTRrhdoy5nI+fVFEndgEEcpMzReD+ZciYl7wYbZsx3?=
 =?us-ascii?Q?Q0SlTH7rXu6a9uEWdqFsNZSxq/i0zMnvQ7Djdt8hT48DNJGtwyOkOYnZl6/7?=
 =?us-ascii?Q?90x+Ef6Ymi8VTTvdcChOmY+4hBojiEwGDWK93xhsKw5dhWEVM/E2509MnqIv?=
 =?us-ascii?Q?7b7UsMyhYbUPiw9AB8GqaA1JmVxUtH5rp3iP5PCJpity0ZZJ8WDYYwF4e8Nd?=
 =?us-ascii?Q?qCGmxeXcMIyShq7+45cSfmV7YNGTXy2OTwl60mtB4IWT9djC/bdYcl2i+N1p?=
 =?us-ascii?Q?aLDcrdpIrVDGNZGKeafPLYbcDK+ez/WLu49tabM7A4JZSHIq0no706f1SmMx?=
 =?us-ascii?Q?/IuNmwnYxfJru+vabMl++0C6/DsJb8UpBuvXGV9cTttPaFNYOH3X9XLOcHEX?=
 =?us-ascii?Q?mBVQdsbQB2tJrjcqZucoIwcZXzPec0rQoe4sJqPWM03OUsRozE/cOYpSob4K?=
 =?us-ascii?Q?plG7fxqKKMhmlDuqMZv70A30Qg+01syd/eKjd3hgDWBrT2qG3a+a7vC3xmMd?=
 =?us-ascii?Q?Q5ovcJf5hW90QcAANKALsSShjX3VB2owR+dmTyr0DH8t5eFNTrAnJbpdTlGI?=
 =?us-ascii?Q?JDH6+ZHFHkFbJsX/yBpKYdAuZx8yYm4JFf+ZMNFiWMRwVPV3R+H+YatKNJit?=
 =?us-ascii?Q?HXW3M5f81GmDx+2ue9AWjo0r3WkAW/jMFCOtKULZbPpkOYF/quIpDDng50Yv?=
 =?us-ascii?Q?nPge2ORltBFefzxG9KATmV57+OoPdOV4p7kmlukecwd/XyB7Zi1SP2ZcfJRb?=
 =?us-ascii?Q?ALznVDMWTwHiVjZvVu6omotDKlNfFjKVSh7ZWxzIiGYxEL9x+y8IiHmQXPCZ?=
 =?us-ascii?Q?ew9cXCNC+YfW/8o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ziJe2OgijaPi0/utxaaNsAN/NAUzXWPZJr34ffsw91fnOYvobhaMxF9ACmZJ?=
 =?us-ascii?Q?nrSD4YSsfUeJWSpqm1DPJvsz0d9XT2nGHdJOpSs9poyatDkzD5/vDKd4YFki?=
 =?us-ascii?Q?SmnV+Qadrq0vKfPyjvtTL3TnCDPSY5sLwt7z82HKR5/SmwzM46bvEwt0PX6+?=
 =?us-ascii?Q?YkabjUcuUgmlNJSSD0K1SpmxMYio1ClRQWoXIsoABnDeqjhR4XpgHYTlfXFk?=
 =?us-ascii?Q?TtdyPV/vI+Gh92bXkCd1ld9z9Gxzd2GW1T6++f82XKPuozcSHRM87BHC/ro/?=
 =?us-ascii?Q?zntAZBKh/5GdJ8sUnPQ+0Rwqb1zYx4OwBPURkKsVhmOJlkhS2O22+u/lw137?=
 =?us-ascii?Q?L8tygm4ddF7Dp7OtMpihHUC4jKJmk2vkEKP16IXc2HXpq5BT5zwBzZ0untot?=
 =?us-ascii?Q?63h+GrRrAtBt8Y8BjN3mWtuWxTNgih9IJ5deziktFUpyc/9CT9JexKNokHe/?=
 =?us-ascii?Q?Wfm9D/g9OLJ1/sxpdR5vlRyTAvZrdFgNy0et0qwnx8q2WvkELtOagsTB3xJI?=
 =?us-ascii?Q?uLbxQ4GtzQXj14ihnbrZP8iRx+o3k/H3gyOhggzP/st81O/YJiUQXIYTGje6?=
 =?us-ascii?Q?GK9ZSCUyzyqm9yVyjmzDESMu77HRuEedMY1XptiKRY5RXKLUWRsUPnLJJayc?=
 =?us-ascii?Q?fbZYYVCoeWE4Y2POFHRzluZ5Euar55nMGnuBI7PpO1HfkaJq8Sc6DdX6rDXb?=
 =?us-ascii?Q?4WA+YK/AgoKm0gx3dKV5Hm2KAsG8/iM7kSW96GVUPBRFxnWM3+TYZGUzg0hg?=
 =?us-ascii?Q?8/Cq/+RKtupz6T2j5GbMg+DLDrpu8L7dWe0eMFVeGwaohBMtYos97JuZ9SjB?=
 =?us-ascii?Q?CVoOYuiuzhn4Sqo9KufuUqabSDN57lg2oFRTV5xX2V0CkiWxljK1MfQ+KDv4?=
 =?us-ascii?Q?wMOcVL8k88chS2rp0htREmhc8DLfuD3wntB7AdYLpCg8Z6zebK5cLJYaZozN?=
 =?us-ascii?Q?/HGq2tWWlC4p11ByuWY47xECVSQsxGJVMdyfEhxp/XnKYQVgeLxmtem2d5vy?=
 =?us-ascii?Q?Uhy7XiWV9yfDw9o2i1mxeLxjbd3tMHuGfVHD+axtg5ze2a2uAXPvj9QVSiFu?=
 =?us-ascii?Q?GfzlREBLYAqeb2XrVpZ7H47erh1QWupuICaH9qHexi2DjDrsVzQiSF1D9mMV?=
 =?us-ascii?Q?CAaUzRmpyW+1EhLgtSzKo7s6QHW4p+hPA+BS0pSMnib/3zMgzKrpzVA4gw+c?=
 =?us-ascii?Q?seQsT38ABYxnrNWyMyRtTA26wALeXa1LM7edBF5o845OjdIbiroNF33e/jCe?=
 =?us-ascii?Q?z7XbgjTFUMn+T0j8T56Z3vlB2PRMQZEjYXRf25zuR2+ZeZqhG3srjRVTVyZO?=
 =?us-ascii?Q?aeGtTb6CJtnEUR1GjY2+pVIKTc3uHxS8LzcDD18pd54aozGH/4ogtfhoRCHd?=
 =?us-ascii?Q?6cX8l09tpJxsWj7ap8kdiW22mqYYMtpB5QErRhlyyNeei62Ot3TFZGBmtzTN?=
 =?us-ascii?Q?KKD43cg1rSsgFgcnzTziTdj8BR5LJGYE5C++9TmM6FvFhtfGQGhQZfQnXLPo?=
 =?us-ascii?Q?lRCQvWdW2Hp4y/kvj4IaE7wd+mzIvcz8ii2XlFVJmOMptN3p3jYzUKAlTNET?=
 =?us-ascii?Q?N8xJg/4hLaFcFeN7SWJa27F3SwNpYFoQ+O37RzinkZJVevLrO67OA3yzA69/?=
 =?us-ascii?Q?KQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b0549c-958e-4b7e-deff-08ddd3a3ed44
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 22:11:57.1866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GmTShS94wntkbtCrJRbR3dqGdS2vkO1QRVHzegdm2yAnU5ynYnF2uyZCRDKP7vKRb0nXOpyUHB2FUi6LFhHSNsrRF7wV7GrYwALqtP/FLvw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10194
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

Continuous reading may result in multiple flash pages reading in one
operation. Typically only one flash page has read/written (a little bit
more than 2-4 Kb), but continuous reading requires the spi-controller
to read up to 512 Kb in one operation without togling CS in beetween.

Roughly speaking spi-controllers can be divided on 2 categories:
 * spi-controllers without dirmap acceleration support
 * spi-controllers with dirmap acceleration support

Usually, first of them have no issues with large reading support.
Second group often supports acceleration of single page only reading.
Thus enabling of continuous reading can break flash reading.

This patch tries to create dirmap for continuous reading first and
fallback to regular reading if spi-controller refuses to create it.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 07ea66825d5..e9ca2b3c391 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1131,10 +1131,30 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 
 	spinand->dirmaps[plane].wdesc = desc;
 
-	if (spinand->cont_read_possible)
+	desc = NULL;
+	if (spinand->cont_read_possible) {
+		/*
+		 * spi-controllers may return an error if info.length is
+		 * too large
+		 */
 		info.length = nanddev_eraseblock_size(nand);
-	info.op_tmpl = *spinand->op_templates.read_cache;
-	desc = spi_mem_dirmap_create(spinand->slave, &info);
+		info.op_tmpl = *spinand->op_templates.read_cache;
+		desc = spi_mem_dirmap_create(spinand->slave, &info);
+	}
+
+	if (IS_ERR_OR_NULL(desc)) {
+		/*
+		 * continuous reading is not supported by flash or
+		 * its spi-controller, try regular reading
+		 */
+		spinand->cont_read_possible = false;
+
+		info.length = nanddev_page_size(nand) +
+			      nanddev_per_page_oobsize(nand);
+		info.op_tmpl = *spinand->op_templates.read_cache;
+		desc = spi_mem_dirmap_create(spinand->slave, &info);
+	}
+
 	if (IS_ERR(desc)) {
 		spi_mem_dirmap_destroy(spinand->dirmaps[plane].wdesc);
 		return PTR_ERR(desc);
-- 
2.47.2

