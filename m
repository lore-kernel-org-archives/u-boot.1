Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A54F9C3271E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 14:26:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4006889B8;
	Fri,  5 Jul 2024 16:25:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Mu9zHH3Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97C71889AF; Fri,  5 Jul 2024 16:25:28 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20711.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::711])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CB78889AE
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 16:25:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvCX8CxBhO9QST9Rqk+qevpqKrLlYZXxoJQxS0Rfkwvv9XUVr3K9S+TG+nMOfzHUEhaldF3HhY7SzGV1auaxv8rZCsEVnzBm2RnXI67qaTOdQQgKOD6RAQI5GtQJcyKRuM7ri21IQOFtsvxH+t2N4Vma/P6latgePe2HtMm3/acKU28D68Dz3ET0L7gqO32uogVp3DxzgcSknd6CdL4GSnw4CianBV4muA3DhwRsZegDwjVRjconJt9YrTJXl0C83+wcKabDAEu1GtznWq5B136jchAMXr5cCig+Ltp2sRVFjzlQG4C6XS5sVzfxkr+7zHkdnNMFTB9NBgBYALvSoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qjo+fQCL8BeBP8eLqIebanaZhbZ+C3EaAzXLKy++LtM=;
 b=VtdDUlon7ORuNbNcVkMCFW9sqYC/EFt35sSdwnII96Crr18Tjt3zhQDuKOKz/2wMmdj03uKEMjPpunlIYKZq/MWB2vcZMKFKitXDVQRm/NLkJfCN5COUkZTZNvF29eWXTCoVSSPfItzCZOrWInyujFVUA85+XNB/4+ABGFfM+qsMT+sbKFmph7m6RpMIowV2QV3iiLkpN/6qVPIQuS6hPum1SQCrSvhTJ9eIWx16PMyTlb7Bao9rhGPcYLIupJ8AbOuwY7hbO5JAlK2f71NbiAlslUEtwomQv+/UqAGuUz0680iAaNGoZRyUmdRJv9FAhx3mFwOv8XNgj3/fPP8n1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjo+fQCL8BeBP8eLqIebanaZhbZ+C3EaAzXLKy++LtM=;
 b=Mu9zHH3ZvA7GnGdV9KLpjOmccXs7QvqNYxqWDQlN7Mi0HhRkGl241o9nchg9rIbYWy2PA6ajSMG3fEB8KfPmCiF4LAT4hwt+vfRXspK797E1exnH2aJCCxI7+ga/XO1mTfiwY1eVfRSUUJsh8GD64X/vxFImuj82eSDrqIzVyfmk9CoYYhRInF3vEyokLhy1MvMzrcMmOh6QUGSECiA0h0dlglZHIraujMUqCMZPPlp05xyPa21oqW3bF2TWiFH6dTBwhly//UFfXY7OSu8eDz2IRDSX83UEFKclftL8sIIPgEuS2/a6eteIJDU1ko4L09myUqQBvHYNUJzeJ6T72g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBBPR08MB5978.eurprd08.prod.outlook.com (2603:10a6:10:1f5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Fri, 5 Jul
 2024 14:25:24 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 14:25:24 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 William Zhang <william.zhang@broadcom.com>, Simon Glass <sjg@chromium.org>,
 Bruce Suen <bruce_suen@163.com>, Chuanhong Guo <gch981213@gmail.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 4/7] mtd: spinand: preparation for ecc engine adding
Date: Fri,  5 Jul 2024 18:24:57 +0400
Message-Id: <20240705142500.2272803-5-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705142500.2272803-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240705142500.2272803-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P123CA0020.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::17) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DBBPR08MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: cdc4ee8e-c58f-4d93-8c60-08dc9cfe4f54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|7416014|1800799024|376014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l2JBmZFuTh6sNxdGFlP6TawktpRo4gOkta6cOnLTwmZPeQg9CHQNumPKXtyv?=
 =?us-ascii?Q?QjzR9N/GNgMvF6tIeXgHZJBon4b4xQ25yzbaLjKVfKwkGuQE780ryzVEzeWD?=
 =?us-ascii?Q?ZgkQSir8sA2OP5ZGO8Xus4IsX3/uZnvqYJv5XtB8EYVGwP0ZYW++2qBa5p2X?=
 =?us-ascii?Q?hKxuAo3xKYPem1zE2X+5HLBtyagStqDS/5BOgSPwxVtaagxzXcQ2BwRQJg6/?=
 =?us-ascii?Q?KWJu21HiUXakd2F9x1Kl6c8vgpbnXYrej4un109BDEnZL0b0tRwTCgOEcJST?=
 =?us-ascii?Q?3kaNstXcaYeqGk/tsRioSXGpeT1+Kcl8bMmHhmkXIRiBIvzPny/LM0cehwPI?=
 =?us-ascii?Q?qRVdhuqXz/2cHHcAXVVsAY/DledfQno3BlpUJi0jJX4j9eR+s6eLa+UwAcoP?=
 =?us-ascii?Q?LdJXxG5jGmf6bY4Or6Iz5vuwry/JHoHt9t0HZHPS3lk/s0AaLbtazyyZ5Z8+?=
 =?us-ascii?Q?2VcJ0rmCq50EhEsuBmzXnEUK3OmyeseTL+fDAAG/pFy061ANfbaHAjaWuvme?=
 =?us-ascii?Q?cp0kIbthfX/W7NlpDbvHhgsxLZcVPm6u7GXV0RWt/8x7bpJmDw0JoSoS1TYu?=
 =?us-ascii?Q?HsNtNXtUdmKQzC0gKwg6AKvM+AsnPU7XGAK1mSnV6mLA6KIQrC2YFUn+07ZP?=
 =?us-ascii?Q?CvdqJfrjOkFQHNdpOnoAp6dPWdIvgWPi2JqYJ+qixDXHjkK87xlpwHpanVOc?=
 =?us-ascii?Q?cwym8Dd9+SeSwQ7PW1o5RUciTfXuvbqXDuUNLQwKRXJJ7cT8LFKeD0AzBpjs?=
 =?us-ascii?Q?rhNHmyRgSybQR+If9QH6gs0uOLAxy1pjL/hh4evWuv7YSseGi2sK9ehT1Qdr?=
 =?us-ascii?Q?cw7KUEr3qBQhaOIRNhhPFTsCb25hY/F45zA46TaXfYWk9KC6lOqagY8a+tfW?=
 =?us-ascii?Q?LUDhggHiD8SIm+JKoylCbpKrS85fGSZWVUsy3+0FHY594tyCpgFCemCcnA6/?=
 =?us-ascii?Q?GDzwQ1tx7wNzBw+Yep4293ws0mHsXolITzf5uzkfNtrtBYIbSod9UkMupRWZ?=
 =?us-ascii?Q?kSsKmoQUPHj+X4xRYNWhvazywBbHUik9xevKd4sCIBa0kB6KZwc96XZk0MLC?=
 =?us-ascii?Q?FaS0EaWyEcL9MQQ/CcDg2rCk3JwbUrweoF6DN+HhL20Od/MNjYkprQr9YqSZ?=
 =?us-ascii?Q?EqUb+rma5tLGPK1ZT2ucoBau1OtQKZCz+BpdQ4sLLkLpI3waYj5he2RvJOrx?=
 =?us-ascii?Q?Pwb2IhSJTXVA62S/rHwY9mHrVMhdyuEwXLuGSOV6G6fGlND5a954S229FmZY?=
 =?us-ascii?Q?35MoIgDkhAOhiavmO7qwzquU9L/F1ECo5oR6GERu35box536F/T8Y0HUQoCP?=
 =?us-ascii?Q?JDRr4YIG7xGLiqX1epUGeWfs0RIuS+Cy07YD9EW8+wc8tfdfJpUFqsbMyr4n?=
 =?us-ascii?Q?c17xjzZIYIP04kO8GYjeuST/QK15jVqDnMbf14OntAbLdxHGlW3QiQ0rrhwS?=
 =?us-ascii?Q?ao3WXZg5uJM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(7416014)(1800799024)(376014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wAhmDYcB2j49AJ/6bjOoUKAHVewn29r0YWnxcmG/SL3CxoqVTlD9fyp++hpp?=
 =?us-ascii?Q?NIi2l8Iisv3JEa4Rjq1EG0e6SWa+hocJMMUyRy8dBNT7K9o9za3KbmaU6SVY?=
 =?us-ascii?Q?H9evwiFYJoOrs2hJaWMpqAhlugaT8HdpdQOF0F/qkAbZ7bh1hPuSsZAgijuF?=
 =?us-ascii?Q?0wZswx+YcV7UfbsEFSOkW5iYRkg9zm49C4q96AMB/G1PmKbRAGAOMW2Hf4iW?=
 =?us-ascii?Q?XmWTZA5cyRRnQ6MkjmH9ankAAK/a11qS/zrvKVXBHK65THwRF+oWWcF21fpz?=
 =?us-ascii?Q?7WAyilyzr31zlXqzt3mbUZInGIh4Y/m9mJTtSDhbEkFSWyKC07tzJ3fz6ufE?=
 =?us-ascii?Q?EXAKCv347BqfLH02CVXao5qZaP4/ECT9uhw0i64Z7AXBbFUILt4yx65xorgY?=
 =?us-ascii?Q?KafEWSG/2AZQTmDPHT5cItRlD5DKptgfA175r4FH4GZtHDSyh/6pfpHQGL33?=
 =?us-ascii?Q?Uxt4R4guVut1FJTxwBq4ImDfdw29625Af/Ce3w7XPxjkUKthLRqAjs0r6DuA?=
 =?us-ascii?Q?HCYRe1lGHrm1sU9Amo0zVPU4Xo2HjC1YO14nsBI1ytfU5TEvAF9E5X98vqfz?=
 =?us-ascii?Q?vSz5h2HLS3Uv7tNz3Tovi+cvPPeWfbzAUnHU9s8rwmd15ivj/T/HZQAmblyo?=
 =?us-ascii?Q?o3FniISECX6m6XQyE5xD2m7kso9n5u+rhioNExUYG/Fh/TESF3QZ0rm0fmIi?=
 =?us-ascii?Q?TJFj5FwiQzoKPYRPqYbyDWFOkeAs/OJlHFYFxWi2dMS/rmhUANRplrVd0FKE?=
 =?us-ascii?Q?2oEIX2Q5JI+UCkJlHSbZ+BM+P73BkmV7TovL8QbdQOTtGhsoEUIeAhyM6LBB?=
 =?us-ascii?Q?utitPPVmWPKfl23BRTwXG/LGOdUijm5DOiZsoe23c9exeTZj47tD9wGCBgO2?=
 =?us-ascii?Q?8fIUUr4WEd11Brj+fh+mIHY4Nw/oCr+t+rn4O1bRNhWaEiRbCYzwTHeNYVGP?=
 =?us-ascii?Q?Lm0UjEEfAKKczrq+cqYGgpD3wLkzmoKCbiukMujUiOIlKf/hhuUh87m80Mc8?=
 =?us-ascii?Q?RKLSaiV9bp+u/E8vcw+BmXNTPTh+kHLvJoeDg68sKsLrr/7MeDK3nPd/II2o?=
 =?us-ascii?Q?W0D85M3+epYqnrtfHTibX/a2aryKBcfzbAux6FoZjJ2fH+tze5k+41Cudy1w?=
 =?us-ascii?Q?bDZMunEmMgfh/WiljecsM055QmtmRSEev7oPXM/w+40u1b3jXuJ5hgxDQzwt?=
 =?us-ascii?Q?Z+M1xcKSj+npWO+rkLh17G7JO3eHtV4WQDCh5zG4Xg+EVHUZbeA0wp/zh7B2?=
 =?us-ascii?Q?L3GnjO/r8YTnUPp2WL+xmpGkEtcR9uN9Xy8IaBv6nnE2iB8qUa2DxSlR8lgQ?=
 =?us-ascii?Q?jJF+AJYYzjGibC71kldVEDplBulnwq+VICv393y82dEZqHaFTXQQJ9efMIMc?=
 =?us-ascii?Q?N9Vs3ZyZCJaiJt18DCFsMSZZVAyealovH/oTCBi1lYPbr348NHk9t56SsyKW?=
 =?us-ascii?Q?z2QGiKstdJiWoviZnbh9at2n6+9usZA2qezq3M1MdZEEP9t4fP/fCqqpZv/K?=
 =?us-ascii?Q?00lb5itc4IEeKeumZyH9tYl8qZIqyoCUR7UNCnDK4Egq4iHy8D2WAY+79poM?=
 =?us-ascii?Q?i01rF+bhfwmxSAEZOV4DgrK+hANw3WN5x6VG1NUWRyQPZkdvYBLMPjpMXRGD?=
 =?us-ascii?Q?eBtayuKXvtme/Mzd6MsWB0o=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc4ee8e-c58f-4d93-8c60-08dc9cfe4f54
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 14:25:24.8049 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nbJGd/O1XhR0s8hgK7Mt/eu4WkA7BYtK1OuL/Xxe9nyStr6o3f1MVL/ukMwnvtr/i1S9cOKZgGs1yb6l/RYQ++6nR7WSYVxIKPkKoez5Gmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5978
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

Changes:
 * add missed MODULE_DEVICE_TABLE()
 * update mtd stats after data reading

Code reorganization:
 * use spinand_to_nand() and spinand_to_mtd() helpers instead of
   nanddev_to_mtd() and direct access to spinand structure fields
 * rename enable_ecc variable to disable_ecc and update corresponding logic
 * move reading of spinand cfg to spinand_read_cfg() function
 * move spinand flash initialization to spinand_init_flash() function
 * move creation of dirmaps to other place
 * move to other place:
     spinand_check_ecc_status(),
     spinand_noecc_ooblayout_ecc(),
     spinand_noecc_ooblayout_free(),
     spinand_noecc_ooblayout

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 259 +++++++++++++++++++++---------------
 1 file changed, 151 insertions(+), 108 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 8664e882753..1b2eefc9041 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -156,20 +156,12 @@ int spinand_select_target(struct spinand_device *spinand, unsigned int target)
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
@@ -188,6 +180,21 @@ static int spinand_init_cfg_cache(struct spinand_device *spinand)
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
@@ -211,6 +218,59 @@ static int spinand_ecc_enable(struct spinand_device *spinand,
 			       enable ? CFG_ECC_ENABLE : 0);
 }
 
+static int spinand_check_ecc_status(struct spinand_device *spinand, u8 status)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+
+	if (spinand->eccinfo.get_status)
+		return spinand->eccinfo.get_status(spinand, status);
+
+	switch (status & STATUS_ECC_MASK) {
+	case STATUS_ECC_NO_BITFLIPS:
+		return 0;
+
+	case STATUS_ECC_HAS_BITFLIPS:
+		/*
+		 * We have no way to know exactly how many bitflips have been
+		 * fixed, so let's return the maximum possible value so that
+		 * wear-leveling layers move the data immediately.
+		 */
+		return nand->eccreq.strength;
+
+	case STATUS_ECC_UNCOR_ERROR:
+		return -EBADMSG;
+
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static int spinand_noecc_ooblayout_ecc(struct mtd_info *mtd, int section,
+				       struct mtd_oob_region *region)
+{
+	return -ERANGE;
+}
+
+static int spinand_noecc_ooblayout_free(struct mtd_info *mtd, int section,
+					struct mtd_oob_region *region)
+{
+	if (section)
+		return -ERANGE;
+
+	/* Reserve 2 bytes for the BBM. */
+	region->offset = 2;
+	region->length = 62;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops spinand_noecc_ooblayout = {
+	.ecc = spinand_noecc_ooblayout_ecc,
+	.rfree = spinand_noecc_ooblayout_free,
+};
+
 static int spinand_write_enable_op(struct spinand_device *spinand)
 {
 	struct spi_mem_op op = SPINAND_WR_EN_DIS_OP(true);
@@ -232,7 +292,7 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 				      const struct nand_page_io_req *req)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
-	struct mtd_info *mtd = nanddev_to_mtd(nand);
+	struct mtd_info *mtd = spinand_to_mtd(spinand);
 	struct spi_mem_dirmap_desc *rdesc;
 	unsigned int nbytes = 0;
 	void *buf = NULL;
@@ -290,7 +350,7 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 				     const struct nand_page_io_req *req)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
-	struct mtd_info *mtd = nanddev_to_mtd(nand);
+	struct mtd_info *mtd = spinand_to_mtd(spinand);
 	struct spi_mem_dirmap_desc *wdesc;
 	unsigned int nbytes, column = 0;
 	void *buf = spinand->databuf;
@@ -352,7 +412,7 @@ static int spinand_program_op(struct spinand_device *spinand,
 static int spinand_erase_op(struct spinand_device *spinand,
 			    const struct nand_pos *pos)
 {
-	struct nand_device *nand = &spinand->base;
+	struct nand_device *nand = spinand_to_nand(spinand);
 	unsigned int row = nanddev_pos_to_row(nand, pos);
 	struct spi_mem_op op = SPINAND_BLK_ERASE_OP(row);
 
@@ -402,9 +462,8 @@ out:
 static int spinand_read_id_op(struct spinand_device *spinand, u8 naddr,
 			      u8 ndummy, u8 *buf)
 {
-	struct spi_mem_op op = SPINAND_READID_OP(naddr, ndummy,
-						 spinand->scratchbuf,
-						 SPINAND_MAX_ID_LEN);
+	struct spi_mem_op op = SPINAND_READID_OP(
+		naddr, ndummy, spinand->scratchbuf, SPINAND_MAX_ID_LEN);
 	int ret;
 
 	ret = spi_mem_exec_op(spinand->slave, &op);
@@ -434,35 +493,6 @@ static int spinand_lock_block(struct spinand_device *spinand, u8 lock)
 	return spinand_write_reg_op(spinand, REG_BLOCK_LOCK, lock);
 }
 
-static int spinand_check_ecc_status(struct spinand_device *spinand, u8 status)
-{
-	struct nand_device *nand = spinand_to_nand(spinand);
-
-	if (spinand->eccinfo.get_status)
-		return spinand->eccinfo.get_status(spinand, status);
-
-	switch (status & STATUS_ECC_MASK) {
-	case STATUS_ECC_NO_BITFLIPS:
-		return 0;
-
-	case STATUS_ECC_HAS_BITFLIPS:
-		/*
-		 * We have no way to know exactly how many bitflips have been
-		 * fixed, so let's return the maximum possible value so that
-		 * wear-leveling layers move the data immediately.
-		 */
-		return nand->eccreq.strength;
-
-	case STATUS_ECC_UNCOR_ERROR:
-		return -EBADMSG;
-
-	default:
-		break;
-	}
-
-	return -EINVAL;
-}
-
 static int spinand_read_page(struct spinand_device *spinand,
 			     const struct nand_page_io_req *req,
 			     bool ecc_enabled)
@@ -524,30 +554,36 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 {
 	struct spinand_device *spinand = mtd_to_spinand(mtd);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
+	struct mtd_ecc_stats old_stats;
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
 #endif
 
+	old_stats = mtd->ecc_stats;
+
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
 
@@ -564,6 +600,13 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 		ops->oobretlen += iter.req.ooblen;
 	}
 
+	if (ops->stats) {
+		ops->stats->uncorrectable_errors +=
+			mtd->ecc_stats.failed - old_stats.failed;
+		ops->stats->corrected_bitflips +=
+			mtd->ecc_stats.corrected - old_stats.corrected;
+	}
+
 #ifndef __UBOOT__
 	mutex_unlock(&spinand->lock);
 #endif
@@ -579,11 +622,11 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
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
@@ -591,11 +634,14 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
 
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
 
@@ -1039,35 +1085,55 @@ static int spinand_detect(struct spinand_device *spinand)
 	return 0;
 }
 
-static int spinand_noecc_ooblayout_ecc(struct mtd_info *mtd, int section,
-				       struct mtd_oob_region *region)
+static int spinand_init_flash(struct spinand_device *spinand)
 {
-	return -ERANGE;
-}
+	struct udevice *dev = spinand->slave->dev;
+	struct nand_device *nand = spinand_to_nand(spinand);
+	int ret, i;
 
-static int spinand_noecc_ooblayout_free(struct mtd_info *mtd, int section,
-					struct mtd_oob_region *region)
-{
-	if (section)
-		return -ERANGE;
+	ret = spinand_read_cfg(spinand);
+	if (ret)
+		return ret;
 
-	/* Reserve 2 bytes for the BBM. */
-	region->offset = 2;
-	region->length = 62;
+	ret = spinand_init_quad_enable(spinand);
+	if (ret)
+		return ret;
 
-	return 0;
-}
+	ret = spinand_upd_cfg(spinand, CFG_OTP_ENABLE, 0);
+	if (ret)
+		return ret;
 
-static const struct mtd_ooblayout_ops spinand_noecc_ooblayout = {
-	.ecc = spinand_noecc_ooblayout_ecc,
-	.rfree = spinand_noecc_ooblayout_free,
-};
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
 
 static int spinand_init(struct spinand_device *spinand)
 {
+	struct udevice *dev = spinand->slave->dev;
 	struct mtd_info *mtd = spinand_to_mtd(spinand);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
-	int ret, i;
+	int ret;
 
 	/*
 	 * We need a scratch buffer because the spi_mem interface requires that
@@ -1100,49 +1166,14 @@ static int spinand_init(struct spinand_device *spinand)
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
 
-	/*
-	 * Right now, we don't support ECC, so let the whole oob
-	 * area is available for user.
-	 */
 	mtd->_read_oob = spinand_mtd_read;
 	mtd->_write_oob = spinand_mtd_write;
 	mtd->_block_isbad = spinand_mtd_block_isbad;
@@ -1161,8 +1192,18 @@ static int spinand_init(struct spinand_device *spinand)
 
 	mtd->oobavail = ret;
 
+	ret = spinand_create_dirmaps(spinand);
+	if (ret) {
+		dev_err(dev,
+			"Failed to create direct mappings for read/write operations (err = %d)\n",
+			ret);
+		goto err_cleanup_ecc_engine;
+	}
+
 	return 0;
 
+err_cleanup_ecc_engine:
+
 err_cleanup_nanddev:
 	nanddev_cleanup(nand);
 
@@ -1262,12 +1303,14 @@ static const struct spi_device_id spinand_ids[] = {
 	{ .name = "spi-nand" },
 	{ /* sentinel */ },
 };
+MODULE_DEVICE_TABLE(spi, spinand_ids);
 
 #ifdef CONFIG_OF
 static const struct of_device_id spinand_of_ids[] = {
 	{ .compatible = "spi-nand" },
 	{ /* sentinel */ },
 };
+MODULE_DEVICE_TABLE(of, spinand_of_ids);
 #endif
 
 static struct spi_mem_driver spinand_drv = {
-- 
2.39.2

