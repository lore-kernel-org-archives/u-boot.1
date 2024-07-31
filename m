Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 044E1C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 10:21:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67E91889E2;
	Wed, 31 Jul 2024 12:20:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="RGlyYigE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56B7688A03; Wed, 31 Jul 2024 12:20:29 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8161889E2
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 12:20:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OXPQLJhTzjDAcUvb6pB/1YTLrU0ntOyD+f4W3pmYDLi2CPltx2UR9PmyTLlPNp0CI72KiFix91J9LoO8e5bBQlUEi0foLs10FkFLX0mvezVe5nAMySa9/LSWyiaqCaUSn17t4aA+dgYY+Jsv0AjRKxQNCvUoLXnG/v4QvSnpGhejWchgrGUxXhSUaCH/68JdmmHyIvE62lYYO2hcGBSIRJaCHM4QJ24YjyeVXkA4CoHaxP/09nlPYsdioMRkEAg+MEzNXiksRq+lwNr45SbPk4Yuzile+SatRtMxMGapGw163IjniMTSozcadJlO9+27Ttj/Fu3rBx7LWX5gSVZqgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xNL8019Ajyoc/IIPSFlTCXVqzixRplRiCDmLHGTfSQ=;
 b=RixKLQ89KsHCh+4miJ9wpR/sRLHEimmpAxIBli92VrIE0lWEAKdFxX8max1K5/afgKEHQw4zExEn/jx1rehixDR9wIo9FT4NTg8A81ABhbJki4jrvfUZVekBBxBt6l0leiFF5IF0Q3/4PjIg/12SqV1tWO8ZPZuy2I+59i8xpG79nFHCXTPcFRPkyDxSUArsmMslKPzM3dCwd3qaQbzhX3VDOaAqMEMBIXWVqoMCmbSWIA94xEsH1nJViASsj8e6dGzHzBsOIExHIqm1dzpf/GD/snKBFCoY7RNcXziylmia6k6x2+p8Q+Kjeqb3FHroQvjb31WTMi3qqGB9LKNWIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xNL8019Ajyoc/IIPSFlTCXVqzixRplRiCDmLHGTfSQ=;
 b=RGlyYigE0cBpnOvgB9fQeyLM0gT0Y3LmHNk/EMknfuoNIJaN/Uvhn8CqP5j5l6vme61ExIK0Ud+OEcE8maZn/h9UF3pkhhgg1k1/r5nRiXjRQ+I7IstRxSs6NmkWYTYH7hZFFZCUOcA+2wk8kAuBQWOxg8mpYnBFN8zMMNkZSii9u9FybvWbEIAAq8jtE1Hw1hwg/J4aPYsG+r/ecfM+gnx2HsDrf6pATb+sttMwBAtLKqq46VtrZfak7dWzZwhm+bhCfgJbluvDRl6cfSAVYqAuKXmcv2+ffaDvzdh5OyG6BozGfkzCowNzusJm3RgDzwHULaLzwR4icXlTGzIL3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB10002.eurprd08.prod.outlook.com (2603:10a6:20b:63b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 10:20:25 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 10:20:25 +0000
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
Subject: [PATCH v4 06/10] mtd: spinand: replace enable_ecc variable with
 disable_ecc and update corresponding logic
Date: Wed, 31 Jul 2024 14:19:57 +0400
Message-Id: <20240731102001.4030460-7-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240731102001.4030460-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240731102001.4030460-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0139.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::31) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB10002:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d19386d-b005-4ca7-f372-08dcb14a6468
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|52116014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FCw5ZEKc/Muz1MVXcdD3gfJXGskdUcfUWLMUwjqZYoku+o/msAtaGBang+XA?=
 =?us-ascii?Q?f1vPh93TVc6GJF15pN5vagxRgIHM5eeOF4VpBCAuvk89K1zrAeoEFvJBuVtm?=
 =?us-ascii?Q?3gCCaWKUFDGYMaGbGFHmJ85+DNMicQeLeoMFcFWDSylDTlQcnotzsqjO4T1q?=
 =?us-ascii?Q?dyoouU3EFVWtPQcCNGpAN3ikL2TPXbHa8RnTKhOOQsOIuVHbNXAKWFVKUU35?=
 =?us-ascii?Q?yowbrMysfrIZ97g1lZb++EYN/wZ0CukxLUM0tiNS7d+OPBHBE6smLHW+AW9A?=
 =?us-ascii?Q?cOT8sttbsdJ1aw+LVbOtGXK027ophQhLhEqZbJDSwNCoHVAvwGHTmGQ5WVGT?=
 =?us-ascii?Q?diWZgvEm75hN4WChpmawe6hZEdXuykfFeq36R42iPckD4L50VEN3q7vmIYk6?=
 =?us-ascii?Q?SyYIx84754366K7Zt5cn2IJQkjhM33AuyFVYgEShdDLQApc+VIBXZV4AFZD6?=
 =?us-ascii?Q?LIUC7UK+HzfUIfVDdXc00IBrkg+EHlfX1Mc0GcLgRbdiKOSaSP1uNDgLWzZE?=
 =?us-ascii?Q?gUGhhQVC+N37U6BtpPiA1DvbGgiFHAVIKZEsw843U2vW6F0Wy2jcj0M6VlCG?=
 =?us-ascii?Q?hzh0wzz+zwaWxTRC9UiaYMiZlN0Irljop2Qq/oNEy9MG1SboSj17KeHkfr+j?=
 =?us-ascii?Q?PMstMfEp6XuPIFG0yz/XTkSRVCRv3p052myL7WhgMG7v8OuSBx4xJgFljjx8?=
 =?us-ascii?Q?kEeTKkX9LXeD+xx3aOM6/jq+XTPxPaPjGYD1buno95KsyOZvayiTKBT8hlSp?=
 =?us-ascii?Q?5lvLHoDfWxmfDLMeY8EJ5c/XAhmQo+F5JfkTsZZug97h03KpgN7dOEWhKuah?=
 =?us-ascii?Q?ZWDCADrLr0Vu/4W4+aoL+0SLF2/Iuznx7LkK2l30iR9RoZKCS0jtdytCyvR9?=
 =?us-ascii?Q?hd1UZcYGe3ln3n4anqj3RuBCFyKuEU8mhrf8xSkVHjoNa2Cerx4t8gH17pd+?=
 =?us-ascii?Q?XSwCYROkQkc3DFkraYJrI5co1zxYaNa4uPnpwrE7fsT1vDA35V+Sr6Y75QEy?=
 =?us-ascii?Q?0tR53AtcNVWWUU6vj70QxzPjTXUbs1Do1Wbaa20VFRGqbYKcuVg6VcUYJVAT?=
 =?us-ascii?Q?SA4GKxDX5UD/I9nTkfIWoDHwVyrwxEuOXdFjoe5n+DlrH7b6TL2+3qC2ZIVH?=
 =?us-ascii?Q?J74qchvzbmtSQpxTOFwwRaCCw30tOcz+x7utnldWc2hAbGzJgshvoHKrT7dH?=
 =?us-ascii?Q?SRBYUPO9cgP5aTHM6q1agFtDVgt4t8vh0RYjlq4H/QKARAHDzvxZtlsMl3+o?=
 =?us-ascii?Q?Cg2EvHfpjRZ9UVXhaTIwfMEzPTrVDGQJsoJn2kBoqDNv3olaAzbxWUrnR0Au?=
 =?us-ascii?Q?PhNRUuGrFLwHcrc5FKZtQ+CmO1JLkxgHONNUvU9wRUz5J6i+/u1VqwTgYCex?=
 =?us-ascii?Q?+LCTHGZlFMMh9YZYL5UwWavb/yCUsaGj2LUsynG4QZboqh+RQaKe6C/mYhcQ?=
 =?us-ascii?Q?yb69wGANmRU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(52116014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eW61jZaso2aFqDcRDTGg7SHdQ7QDVFX4ni6Pfx67eQwlXrrxWffbtboYEWf6?=
 =?us-ascii?Q?DnacMo1dploKlCbiYewQIaTdm5+FLA6Koc4mSoxMnDPPTvQj171imX9xC/5Y?=
 =?us-ascii?Q?ALNHDa2fxX54U+Y3mlYbPHQrQt+YRYssKs0Vlu8ZwWg6qafQztO8cAg0vPhK?=
 =?us-ascii?Q?LTxo30MuvvbdkZQ+om/fbvf3Xn3QMFEqO50Q+apl2yfNABZty5X9OGMG+1aD?=
 =?us-ascii?Q?pJ4kG+iLUblCGd7f4g0L4qY1XXcAMqk9Tdn7SRZx8QUtRKCSK/NWh+QZTcPI?=
 =?us-ascii?Q?AI6apdudz+7uFJNQbjOUaHD2soyRZ4Rqn5UeKK4do/sRFBcNX7bavqxeNLV0?=
 =?us-ascii?Q?DdDn5xnrxX7pLEFjI7xdUozlEVJdKnsh3M4k2NPhz3VWmu7UePoAERbgBDj/?=
 =?us-ascii?Q?JfpBAdarTVtY9793pgrpyk2xzEVtmc9afuLr0OCZyfgOi845BABJaMgNcps2?=
 =?us-ascii?Q?DL2HhFQctZ4m1BZ4ezkZhD6hsM4aX2Wi4cy7OnV9K2Tb6o/Ve4iPrToTBdI4?=
 =?us-ascii?Q?CQBOATGsONmXQTU8f1R3UZlL5vxrK79r+nusndvbguoy8IOm3ZGBr++O8KkM?=
 =?us-ascii?Q?e0mt+k2JQvm+SD8HuUiUbfqP1Fx2pm1/fDm9n6pkbwccylXVFFrEYC0ZpnQJ?=
 =?us-ascii?Q?1x6m0uQsXurQx+k0DVA6JLIPUBX5edREdS6WGTLCnc/tcjmIs4Mqpnp7NFZi?=
 =?us-ascii?Q?jE4Kaf3X1g9D63NFfRiVS7zERPwi7JGZ66LAKC1fiHqzqT1C9Gosj/Z3SCOw?=
 =?us-ascii?Q?K4uA7+oDBqEVmoyIv7niczLe1NqygBsxEy8aMyQYpNpgF6Df4aKmo3lWjUwM?=
 =?us-ascii?Q?cGUC1pTqVb2Ci6Y8pLSprsxuTixHiSbM5yjiYZIKghC2+w/XliVxw4Hil8HZ?=
 =?us-ascii?Q?ieGzRxKDcT1vlbKxWIbJLMUTMBqRfV25po591qFdX+pNB9XX5GSTbRTFzFJv?=
 =?us-ascii?Q?2N2T3/eDCcJ4yoUqa7GOcOtkCZZ+Yo4c+toNw4zqhn0B/yIRe2EE6uQwg4SQ?=
 =?us-ascii?Q?NE/mEl2BrhfEY1jjgsxvrAxsLY1lD62fVFaBj/niB7YwBTw4dXz9qh85BpPq?=
 =?us-ascii?Q?fw7QNNFKiFxNPPlkSTIZWJ1Dh+G21rbQT9d/9XcmWPHvwPbxk6jY4VOWLbvx?=
 =?us-ascii?Q?a9+DfLfbQlV/GiJ3Wi59lAEnx1BI+cmDnl6ALtkAs8EITHYgz4PPPqZB89GW?=
 =?us-ascii?Q?INMhBX8Jbi0PgXAlD+ZsGU55y0fsL5HlNQYuIbb1b2Mqw+Y3+W9XwtOrQfNt?=
 =?us-ascii?Q?IiSxCykQ8qKoOt//5BvTr685lfE9n+Gn8BRcdDQU0bOTGWSbM6lDbwzcAfq4?=
 =?us-ascii?Q?Df+WfXsWvDpEgXspVCXLiwCh3BYB72g1veUc44w+//Vf52M/mmxCDG0kkoGT?=
 =?us-ascii?Q?ftLxH5irLv+JxkUaSY5AnsAK8a2bPdV8xixbyJNjfoAKGCo1d2ClQCCubTK9?=
 =?us-ascii?Q?dL4xswLhNOxZQX3SOz7DjCgFP8j91nhiVNx3kMzrBK4y+oicV7rcSMAh+D9Z?=
 =?us-ascii?Q?yUTx9GVn0iR1SIVOhr3bPF7eYbXmWQZDCO8aGW6Q5NnDhca3qQKE3F+BlGlv?=
 =?us-ascii?Q?LfGtZ3ejuVJJEzcdYTRdbTd66jH6DMn62pjz8A5t8ml79jpiTAI5ixg+LHyG?=
 =?us-ascii?Q?PSZYf9sVq5IxYE4REy94bv8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d19386d-b005-4ca7-f372-08dcb14a6468
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 10:20:25.1743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q2/q2uFGwYTRm3lyKmyPMsYR796Epz2r/maIcL6OFt5TtDCmEb3nlQVolAtlLagaAM6oKVfob55DaS05ALYRBOjHWfmBbFGvaBcmEicYYyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10002
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
index b8e2849832f..8d5c07e6966 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -525,12 +525,12 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
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
@@ -538,15 +538,18 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 
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
 
@@ -578,11 +581,11 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
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
@@ -590,11 +593,14 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
 
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
2.39.2

