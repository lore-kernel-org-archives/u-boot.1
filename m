Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D895DC3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 08:30:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79AB488982;
	Wed, 31 Jul 2024 10:28:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="L5t1JGsJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3FC58899C; Wed, 31 Jul 2024 10:28:57 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2071e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::71e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A022A884A7
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 10:28:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=saWDZMgeDYyMyVj5Z0fooYKHyxCaI151AUYKkqB32G1zvcQg7lOn1afh2KlYkkWTK0axRyA9GXJs69FUCIZQzQTq/26i71srqkgz+4gd32EbtsRCAXAPO/3XifJUVFNbYFSsMmcQuQTa1QajEdaXttjkPLVldBzfnvi0Pv2rrK3SvdWX2MbB5i0oKLQ2GjgtKBCuCw8wBlaStavmxTUACXJb22v1WPESbCt3ebJJLw/5+iBAGlz5EVbOOBAK/tFnUgfJJmstNr5QyY16kxMvuCD0R2RCU0JKSRBO8JkrLlSj/3Rz+au1xcdI4hr6yk+eRosZhqP8OMkbLOK21iP2XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8OBGBgWfiC3+akpoEZDCGeu69GRkUY8ygF+1VaEUwA=;
 b=wh+YFyVuPNPBk6bvVqkmx516maH4aKTgBgxoU3fv0p1e6DIfEpPTHEoz/93mfuyGnnGfU400qGRTpnWQIULL1dCxkyKuObBokw4Y6R3JN+OkbNx+16Glx4ARsSX1bgZvrjVkcnIpFODtCj+tuC1lHxxnlxDCuUBDftcFkGtLUGxvBgnKIfR5Nwx0PzV3Vfm+8qIC7LWV+PwBQafuwOiTPQmf5AROcJ+PGbPNcAjerx5n7MsIMMB+tjIlpoHGMzex4vI+6w/BbuPP5u8OgsnutfMf8u9MD7E0v+xDs+p8DWeuM+mfGkhrZJREEOVNMR5V5Kc5lAX3cjqbIDKRVylBSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8OBGBgWfiC3+akpoEZDCGeu69GRkUY8ygF+1VaEUwA=;
 b=L5t1JGsJRrUDqPM5+AMJzPrUmtKGgwMGdB3vnkoK1nUrblwN3/XKXaQ5q113jcSrC/D8+XscgfodjL6EcnJyyaS02OPA5mZUUfS0sruO70nvIoltDoMg83vZ6iRt2Y19k9eXpZAdf2ljRj8NMx3VRT3P3/Ecp0o1J/a2laPm2QDV4a7APX1YKdiHAiuaNm7KHkz3eWr+kGJQzP1Yn+R5SZwTMpJlsaIalSXILNjm80pb4bjix9vebEfPbbR3knki6t75tf0bmbIwPcD5uZKqZCcowo5nN+lDlBhP59Y2JUfGH+/2dQ3XAv8cg0RXO0gctGG9DLS8c8ABFaBPrDOZdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV1PR08MB7827.eurprd08.prod.outlook.com (2603:10a6:150:5b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Wed, 31 Jul
 2024 08:28:53 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 08:28:53 +0000
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
Subject: [PATCH v3 07/10] mtd: spinand: minor refactoring
Date: Wed, 31 Jul 2024 12:28:21 +0400
Message-Id: <20240731082824.3890809-8-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240731082824.3890809-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240731082824.3890809-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0103.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:348::11) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV1PR08MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ea1b9de-3387-4e89-322b-08dcb13acfbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Mf5sohc9MEEGAXUiKsrSUVeU1Vs17L0IYVp6ZVajRFKKyUuhLec89+jrRLug?=
 =?us-ascii?Q?Iznxa2gGeFNqgO0EkCC30Pfvn87bCvQtL2N6HBR5zGUSLmrJ4Dym7BtIZnVR?=
 =?us-ascii?Q?b0cj9pu6wt069VkxLWemVp7dts7p48u7n83039yGdolINQIKL1uStgJzUE/U?=
 =?us-ascii?Q?saR7tw4ZEg0n8iAPzQap9le51eyhtdRtI1bx1/NFbtWmHCFyzlStSZS+CsxA?=
 =?us-ascii?Q?VxEM16YxJKp4C9helKVGQy3uACRlK7X395XZ1z+uQkY/CJtCSr5YZdEWZkSC?=
 =?us-ascii?Q?eSwKC93ebvNFfOQcMsZJYmuhjkMGYFFzvoyEfa7jivoHjGUffS39TouSH8hv?=
 =?us-ascii?Q?vEm5lJZHCubtjMa3lPh583znxLloC3lZoU/BQRawQJZyY0gFdXDafL5xpqpD?=
 =?us-ascii?Q?lbX41QWzlXKqlLfEsFHJBOXlFMwZWVWvNT7DHxHXL72YE1CDd47/gLzeW4fp?=
 =?us-ascii?Q?vKPuYUpEazNwPskCue/pIXK5U61yOiQOd4Nl2AD0jO7AP9fQZnrvSV50U2Ms?=
 =?us-ascii?Q?t2E4SO1RKGhSmKaZl0lrg/z8ZwTtNWaNAdrtG7ZqRN9LSc94J22xvfnLBDzf?=
 =?us-ascii?Q?1ONh1tKWT1HBQPiw1YOI0pht/GZAZgHEXn+dXRFi24lrPs2MVr5TpIC1nqNy?=
 =?us-ascii?Q?26pzm2Lgnr8Iom+7aR4WmALRArnQIJ1ts0k+zznAWkmPVib0dVn2ZCP4VNx7?=
 =?us-ascii?Q?jhG0zho66OCwhM6KRZebqcmylkJ+9xGYSzbq6d3oJWc3NiJ6wjRF/HWN+kes?=
 =?us-ascii?Q?3CziynQsH0CJEGhUH6BqY+ZD+tdYirnwg8ETGGG6pscJY2uD6LIcItBgNkzU?=
 =?us-ascii?Q?PDkpXMxWgWWZ6ecLLEUpaIuVLDnCaWetFIKiZfy3CP4FbslYycr4QA1kdC8a?=
 =?us-ascii?Q?1aHetkI4e7YMuOeG8yeu8hS1C21QmLJLwtBG18aZcFLFHXZvj+2ig98oBgW5?=
 =?us-ascii?Q?HYYixrlVIZ2joPKiho+O4tOZLO/jX3myQTH22sCcWZ4fTYr4Ac8e2AT8W06C?=
 =?us-ascii?Q?UEAu2G9WXnSf6OeWXwwqniqwbgdAewqvD+CCQ7MAEAkOVD37XAfuop4SRT7v?=
 =?us-ascii?Q?GriKoGIOS2nmycdItVBgOSK11eHAdJvjUGtq3Rnim+vHcig/4pCkP26eba4w?=
 =?us-ascii?Q?8GK7mPCHc320r8zQzhQkFqgY2q+pLCa7tW481A7/ooJLrCihD6scj7+pbasY?=
 =?us-ascii?Q?viJgOIU1giP2fUyHr2gWKbFuhtGfVspltuwNLj3VQ1n1QaMVan55TP7ZkVUx?=
 =?us-ascii?Q?N8YCYSYOYS+l522iweSyqi/w04Qm3bIgRIdGj2rnSnZryGuJAxjHceTHlQvt?=
 =?us-ascii?Q?TTkpWZNfbs9riv9gWpKZUEU/ph0x+9VLFrf5jnX7fg7KyXW/0aUBVPQBpJ3i?=
 =?us-ascii?Q?IzUlxkj/whxiyq+7zIPawwVL58k2HydIw+MRQM8JWgNqnUXnOOOp9glthkpu?=
 =?us-ascii?Q?SddLnNIr1+o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GEiNwx17ol62orYj4uV5x3F+KDO4hlXVJBpaWyQku4tG0GS/RxyC3u4eovD8?=
 =?us-ascii?Q?b6WoaFLpZ0VYtTdQhEHFBRkEar+VDZ7F2uReuO6Ag1r8gsuFzvZoUPY6EG8I?=
 =?us-ascii?Q?Z2yjJjxPXZKdWyEVuygX93mwaQ/d6g7vTgScmzSUaZZGKQK2GRwaJDIpdtgT?=
 =?us-ascii?Q?mfHfYG4LHmwIr7urNnPAik3LSxyvEt5E8jYZYW+GhWFHZw5Y6xrBhXi1G8qT?=
 =?us-ascii?Q?1zi7P4jqnJBAk6XAMHqC7oh2s7sVQCOm0wBCG8BbUe97tt6dO+EvOW7aWwZy?=
 =?us-ascii?Q?CEvZ31BPG8wAVrbmCpJRS7JP1Sqbo02/PEnInfd+z6Q0xLsl2AXpRxYgoFaM?=
 =?us-ascii?Q?Wd2YiM+8Gk4w2UM/sJlMD8WAJdY/0itvxanrnERcSsHwDS5Zr3u+mSLOurZR?=
 =?us-ascii?Q?v/Y/8q47rmSc06OAZ11RJMq/uC8ZVE0nMjzYNzpwr/BpjmVnWQdmp+cJtf3S?=
 =?us-ascii?Q?rF71raY1Qv4UCJbhINptRjj2YCGgaTnuK6sta0v4LpAFKN5Gou1E6J5xMjsy?=
 =?us-ascii?Q?Lqm0irlq4viUdvF0EHb3BBX+2qb6GT3asZ8s7VBCLU5Emoh2N407ojyjGVsY?=
 =?us-ascii?Q?HsYZFe3YtWuillS1oqKdhmxfhlEIMGy2qS3Qg6tqpH6sSqekiXAdJOSlb7yJ?=
 =?us-ascii?Q?xGKlolEoU6cWwzK7FHbbu1OjcCt/TdkUlwKIhj7kfe3Le4K+vXwc+hqi5btZ?=
 =?us-ascii?Q?1PKj8cEwuMtCgrOVW9e4psvgFFE09rlCk3ODxYAtaQSK//e+6mzf5LeLV304?=
 =?us-ascii?Q?uhVCjkvxi2tNZNSaAA+LwWUkwgSKUT0GS2/vTTZnke/fhGqkrvTGW5IGsn8p?=
 =?us-ascii?Q?b6lDDPxBiSduRDROHYn7m6RRXwKk1gQKm5e1yRWkEElekpmZRMiFim7iKVBq?=
 =?us-ascii?Q?UevtkRQeUHeLdu3YtlrXOCTCURqnww4kkG+SCDTEnVQWQHFztoI66vYMWh1R?=
 =?us-ascii?Q?NRL25vHLAkAljV1gIbk7ExfB17LynKsLRc9lc0dw3xFU6vWbANz5QelS2p0o?=
 =?us-ascii?Q?DSAUhHJDXpmsXwrwI/JnFzWBa2JGZDJFHyp4seKU0tnx6OJM47UxbcKu7bbt?=
 =?us-ascii?Q?hBWHCkuwFEm8pMhbLlQsf6S761YdB7tknVoh4frYJEVG1+ikWa6Vuuaqr/C/?=
 =?us-ascii?Q?lOjQ/npIksvjxqLuyQiV8tp2IqGoIdXC/Z/SaMHsL2Vw+GJ3J/iBLK5pTwjh?=
 =?us-ascii?Q?m/Bs58dkjXp/2OkY6ibbrnG2kdBkouDQy2SxMgmw4TpclcqSqGVAxxntgBMJ?=
 =?us-ascii?Q?RW/vyIGULWw/WItNPXT+LDhOd/ak8vnRn9NAyktl+0vbj9Zt4qxzhLni4ZQY?=
 =?us-ascii?Q?elo2vpEnPhWUh37i/1zzLhBu5HAFwKWJTf7Rp+amQSUETx3fugXASSTR8Lu8?=
 =?us-ascii?Q?W9arQ+XSQsFtu+dfiLd0tfn+DqZaL6XrtAy17Z8kLf5P8dWJAkjSuKJ4Lm+A?=
 =?us-ascii?Q?gBE3JwJhSoGaeSCIKGFcdKieJwK87KX43b5F1TYibXhK0rDe8o9dU0JfrjM9?=
 =?us-ascii?Q?EM1BaqWfHRgKUqYEcVrAhkw476w+r9z5sysZu4tdyldII4i6GjvnTbdDCHaj?=
 =?us-ascii?Q?i/ee9cyu+xMUgEB3Z9P+sDWxFT4g1S3g1rparK8zDkQsPZJ5MPhEQuMUcfAM?=
 =?us-ascii?Q?d6vSFALcKa2u0lLfOGZaMNk=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea1b9de-3387-4e89-322b-08dcb13acfbd
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 08:28:53.3041 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xLNj7W8OzDcp6dshz5YlhPxduIklV45lTxE6TjVAgCvLMhuix8flm/cgxB36e0fe7O6dWthgN/jP9kjy1Z3FdOfsNHjdzI3tYFXE/iycU7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7827
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

No functional changes, just some refactoring to match better linux
kernel driver.

changes:
 * move spinand configuration reading out from spinand_init_cfg_cache()
   to separate function spinand_read_cfg()
 * move spinand flash initialization to separate function
   spinand_init_flash()
 * move direct mapping initialization to the end of spinand_init()

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 112 ++++++++++++++++++++++--------------
 1 file changed, 70 insertions(+), 42 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 8d5c07e6966..cb787908332 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -155,20 +155,12 @@ int spinand_select_target(struct spinand_device *spinand, unsigned int target)
 	return 0;
 }
 
-static int spinand_init_cfg_cache(struct spinand_device *spinand)
+static int spinand_read_cfg(struct spinand_device *spinand)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
-	struct udevice *dev = spinand->slave->dev;
 	unsigned int target;
 	int ret;
 
-	spinand->cfg_cache = devm_kzalloc(dev,
-					  sizeof(*spinand->cfg_cache) *
-					  nand->memorg.ntargets,
-					  GFP_KERNEL);
-	if (!spinand->cfg_cache)
-		return -ENOMEM;
-
 	for (target = 0; target < nand->memorg.ntargets; target++) {
 		ret = spinand_select_target(spinand, target);
 		if (ret)
@@ -187,6 +179,21 @@ static int spinand_init_cfg_cache(struct spinand_device *spinand)
 	return 0;
 }
 
+static int spinand_init_cfg_cache(struct spinand_device *spinand)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+	struct udevice *dev = spinand->slave->dev;
+
+	spinand->cfg_cache = devm_kcalloc(dev,
+					  nand->memorg.ntargets,
+					  sizeof(*spinand->cfg_cache),
+					  GFP_KERNEL);
+	if (!spinand->cfg_cache)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static int spinand_init_quad_enable(struct spinand_device *spinand)
 {
 	bool enable = false;
@@ -1068,11 +1075,55 @@ static const struct mtd_ooblayout_ops spinand_noecc_ooblayout = {
 	.rfree = spinand_noecc_ooblayout_free,
 };
 
+static int spinand_init_flash(struct spinand_device *spinand)
+{
+	struct udevice *dev = spinand->slave->dev;
+	struct nand_device *nand = spinand_to_nand(spinand);
+	int ret, i;
+
+	ret = spinand_read_cfg(spinand);
+	if (ret)
+		return ret;
+
+	ret = spinand_init_quad_enable(spinand);
+	if (ret)
+		return ret;
+
+	ret = spinand_upd_cfg(spinand, CFG_OTP_ENABLE, 0);
+	if (ret)
+		return ret;
+
+	ret = spinand_manufacturer_init(spinand);
+	if (ret) {
+		dev_err(dev,
+			"Failed to initialize the SPI NAND chip (err = %d)\n",
+			ret);
+		return ret;
+	}
+
+	/* After power up, all blocks are locked, so unlock them here. */
+	for (i = 0; i < nand->memorg.ntargets; i++) {
+		ret = spinand_select_target(spinand, i);
+		if (ret)
+			break;
+
+		ret = spinand_lock_block(spinand, BL_ALL_UNLOCKED);
+		if (ret)
+			break;
+	}
+
+	if (ret)
+		spinand_manufacturer_cleanup(spinand);
+
+	return ret;
+}
+
 static int spinand_init(struct spinand_device *spinand)
 {
+	struct udevice *dev = spinand->slave->dev;
 	struct mtd_info *mtd = spinand_to_mtd(spinand);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
-	int ret, i;
+	int ret;
 
 	/*
 	 * We need a scratch buffer because the spi_mem interface requires that
@@ -1105,41 +1156,10 @@ static int spinand_init(struct spinand_device *spinand)
 	if (ret)
 		goto err_free_bufs;
 
-	ret = spinand_init_quad_enable(spinand);
+	ret = spinand_init_flash(spinand);
 	if (ret)
 		goto err_free_bufs;
 
-	ret = spinand_upd_cfg(spinand, CFG_OTP_ENABLE, 0);
-	if (ret)
-		goto err_free_bufs;
-
-	ret = spinand_manufacturer_init(spinand);
-	if (ret) {
-		dev_err(spinand->slave->dev,
-			"Failed to initialize the SPI NAND chip (err = %d)\n",
-			ret);
-		goto err_free_bufs;
-	}
-
-	ret = spinand_create_dirmaps(spinand);
-	if (ret) {
-		dev_err(spinand->slave->dev,
-			"Failed to create direct mappings for read/write operations (err = %d)\n",
-			ret);
-		goto err_manuf_cleanup;
-	}
-
-	/* After power up, all blocks are locked, so unlock them here. */
-	for (i = 0; i < nand->memorg.ntargets; i++) {
-		ret = spinand_select_target(spinand, i);
-		if (ret)
-			goto err_manuf_cleanup;
-
-		ret = spinand_lock_block(spinand, BL_ALL_UNLOCKED);
-		if (ret)
-			goto err_manuf_cleanup;
-	}
-
 	ret = nanddev_init(nand, &spinand_ops, THIS_MODULE);
 	if (ret)
 		goto err_manuf_cleanup;
@@ -1166,6 +1186,14 @@ static int spinand_init(struct spinand_device *spinand)
 
 	mtd->oobavail = ret;
 
+	ret = spinand_create_dirmaps(spinand);
+	if (ret) {
+		dev_err(dev,
+			"Failed to create direct mappings for read/write operations (err = %d)\n",
+			ret);
+		goto err_cleanup_nanddev;
+	}
+
 	return 0;
 
 err_cleanup_nanddev:
-- 
2.39.2

