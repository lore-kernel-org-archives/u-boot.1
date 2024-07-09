Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90DDC2BD09
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 12:51:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1576C8858B;
	Tue,  9 Jul 2024 14:51:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b="k0qMLH/i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A4FF87B77; Tue,  9 Jul 2024 11:25:21 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F478885A0
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 11:25:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=inmusicbrands.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jkeeping@inmusicbrands.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzBfezwAdSKwEZ+qJ5P3L8VsJLDGAA9PgDiMcAhKsN+g3GV42Y0sg9786lx2KoZnJIGc2EZuWKj3bu2LFSdUObq3xY/Uiqrvr9ZIQ53wqtqL7CbFvG0ijfVIVOphpEhMMV6A244znjXjZaxQfEzf/Dg6iyLC0roAcCh5fg+VscDRaoLzZFSQX+ujzcuIUkZ7v2Z6zZJRPrIXCI8jk/yn6V9UCQAmS0oeWCyPbFo3W1lPCYVgp9tmolP/E+SJselgY3a6f1pXmMiK2TO/qDPaPefSRtkK5njdU8DrxUX1k1rB8K9goNAJsIjI5pc0muD2MMyK71s7opGFkUpFPQBy1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNw22HGOCq784VUlXx1edd3VFvsN5S5Tn4i34I1aHCU=;
 b=SVXceOHVL0TRgrJeKYX7HBcetx2bErwRk3zVvaatGHm29SFEKJe48wIEQ3XYiKpucoYGY5oL2hGrdMxh5wL6/8EN/MhZfL/MxCHAZw+VTlfs9snRKzlJIiomsL7s2fmFrB7s3DJ5LYe607uE19fsRV9iAfxoiyNoBpZtnM5jaQPKTMhSzqkuUbLrC3F7W6aPXzVQOn+mdLqk5eG7OufptEVptkL+jTh6YfG7DPMIlIuOtLieKUA/Eca1iax3aLpSKwZH87QYPBz4LiTk2vJnDRukfZCwVaNCDirJbA9cpUQPYvd0NNouOeSU45QFV8aKQGZPMkEKmVHh/Yz4WcC1FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=inmusicbrands.com; dmarc=pass action=none
 header.from=inmusicbrands.com; dkim=pass header.d=inmusicbrands.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inmusicbrands.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNw22HGOCq784VUlXx1edd3VFvsN5S5Tn4i34I1aHCU=;
 b=k0qMLH/i+IeTUTUYSiAB0I5ZkA8Csz0+a7t32M2SVYC4aZxpIWr1dHKAdW/s3RSiPC2CKrVaLTB5QFhZDaaDMQLR4g6ip6SZvuf2OOkimghQyEEl3ofwKSmasX1viFJe/Bz+X9/I9rJ1AFuSVcrPhdkpIz9fw6KaA8XX/YRMQX8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=inmusicbrands.com;
Received: from MW4PR08MB8282.namprd08.prod.outlook.com (2603:10b6:303:1bd::18)
 by BL3PR08MB7452.namprd08.prod.outlook.com (2603:10b6:208:343::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 09:25:11 +0000
Received: from MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401]) by MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401%6]) with mapi id 15.20.7741.031; Tue, 9 Jul 2024
 09:25:10 +0000
From: John Keeping <jkeeping@inmusicbrands.com>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: John Keeping <jkeeping@inmusicbrands.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Philippe Schenker <philippe.schenker@toradex.com>, u-boot@lists.denx.de
Subject: [PATCH] regulator: fixed: fix regulator-fixed-clock
Date: Tue,  9 Jul 2024 10:24:54 +0100
Message-ID: <20240709092454.949260-1-jkeeping@inmusicbrands.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0258.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::30) To MW4PR08MB8282.namprd08.prod.outlook.com
 (2603:10b6:303:1bd::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR08MB8282:EE_|BL3PR08MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: 66e58dab-da2c-4755-67d5-08dc9ff9079e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ev+mvDgBhsuSWYeTD4DeeVW0YelaqSBGWY1hgu0AC1bZZsTS6M1v3d0K5dV6?=
 =?us-ascii?Q?1gnCgA19KDrtFGoUa+K0LWUHndEyZZnZhOmQHB3gl8UA//FipIXCdh3eMOQJ?=
 =?us-ascii?Q?EJwVNYKmzhu0Fyi2kLjOB4KpoXge1DmmdSos4kx2Sv7KyaujzkC/QpvFEzws?=
 =?us-ascii?Q?qEZuCIKlR2x0T+dHr/sh37e/PKvZGfdj2mC6QFv3ywdFWB2sbQcYzW77qBBF?=
 =?us-ascii?Q?AXs4/Rz0+Yx/GEsMHo/PecxJa30VOi6qrk26miM417vPPzjXkI/2HMozzo8u?=
 =?us-ascii?Q?A+C/qwAIwtwEqugNldFxpi5a3nGl04AlB+34h8IN0KXdGgGPCsnNxpwr/LHT?=
 =?us-ascii?Q?qwrn+fihpltlIBRK41BbHzHlRcXYEeihE2DIdbhA+tR8qRGrC156ttIXXz/C?=
 =?us-ascii?Q?IDbNJM84RxFOjpIeroSnjkhU3A+P+T/25L/kzTWFrgjo1nVwJQYUg/bsFlqY?=
 =?us-ascii?Q?OwIwk7Dm0Jop1qpPxsqXKqiedTiuqgFttLKlKpY5QKPw0ICeAc7S3fTmPcAL?=
 =?us-ascii?Q?hoxoFCSbsWYFXsszxreStM/WeH0EmZPHHcPf3txigqZwQenPuEiNuLo88xPx?=
 =?us-ascii?Q?0SjeV76J7B7s/TBgGVo1ZqYHmKSR7ZDwADUC+ll6K9gYPdPNdL1wc+BQZF3s?=
 =?us-ascii?Q?L22R0SRXwo2VImq2fDuwowROO34HIe2PbUV5Uwm7MB5ugoXSZRqXMZ7NzctL?=
 =?us-ascii?Q?4BQKpqsOFtX29T4ZepP9ci7Trzlw2NTI8XLnfDZF0BqbN0oNpukWFJ4ZsMHt?=
 =?us-ascii?Q?j1VieAB7NUTIvWuF8/+KicyhYbxP615oYEGOV2copaISOy5+S2hZAlqfit7D?=
 =?us-ascii?Q?1QEKxfU2maS/TPeGPFW0kjCkm1/S5hPfMjjrpKh9S5AHUG6BMLcaGIykNDym?=
 =?us-ascii?Q?4pcPaIQ+R0Uu/Zfn/UFf404ISmwUQSxXWBePZ3cKqasQdpIu1EXHsAx6GGKc?=
 =?us-ascii?Q?JY6ncPieNg9NH0l30eVDxyHbTzKWAZROR/toafnfPEVyS6FWsomMj6piYixg?=
 =?us-ascii?Q?4/Weimrwf6sGRwYFMV0j2eOEmUrFVmqRtUDD2iSVfkgTBBc2Xl2MG37vWCm5?=
 =?us-ascii?Q?n/wsHKEIUjvwUAA8s9Y2v1Bs3vlEZMoxUejvsV7B0A0BhYUqZH0T085B8B3b?=
 =?us-ascii?Q?e5cdNsgFXtW/6DfNkbbq7RzMosT6q7Qt64E16STtPC6uuMdYn3MkEkFwf5Ri?=
 =?us-ascii?Q?xM5WJ1PFA03FqFEW8vfYOLMwd/sJqkNYDjBXF1TwV4pAVRQNymc+1s/430a2?=
 =?us-ascii?Q?eky79aMv3J3d58l8Diu/Qpy7zFrW6JtpDU84UkvghbsLOehg7ivEvCHpoQ1o?=
 =?us-ascii?Q?brO0G2dd7A0zljzgRJOrunyNOU96d9nn/0+ePm/oRwnGcMwtmLeDxg8pzaji?=
 =?us-ascii?Q?WBUg10ujg/Ey7F3xD8JvFuBP4q2y6HeyQwr97jBivMB5rnoQcQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR08MB8282.namprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?umBU1P7MaatTt5LNSq+BQpt9pfBTTp4AVZlibVdC8PFT1VFju5fsMN0zay+L?=
 =?us-ascii?Q?kfK3JO1Sz9dOwx5mLYNEmeLN1VgAIH7R2Yxc7CJPEZxfswxUV40u/2N7yLOQ?=
 =?us-ascii?Q?blWSKn2z62SLv8N/comDYZDaArdWwH+Oimaiuu8lyF/KjKYFe8ZSJASwbFvS?=
 =?us-ascii?Q?ZpPwfPpVTqA+7DaiY8DMiYEAi4SWcGDnXULPPjCkMviQpigvLtZl3sBI6PZO?=
 =?us-ascii?Q?uMW42z9ZMc6G1JHiUpFxrvf5V+3H+AhmgFXQY2TyHgWtpYYrAsEJ1f0uycTC?=
 =?us-ascii?Q?W1jEQ4rRNlFMCO0qyM+Me3ayRDqRqT6O6261ZZOF98AWUC/e7UQP4bi97di9?=
 =?us-ascii?Q?+cs+MyI108+wT4rwTlRfnWtlHQ8IMKJZ+ekXuGtajqtbAtJl3RM6sIMOZpj7?=
 =?us-ascii?Q?3th2LKpQO8mDZ8vxZ/hxYIonfNeWl0Q9m6Wriua3bl0dlEo1FQBaLKfDyLS0?=
 =?us-ascii?Q?kz8kwTHkDDTgfV6Zfr1fNKYcFnyuBWsa2Jeyi4JzHN/FNpKBLZC4VTJIIMtw?=
 =?us-ascii?Q?wt/02Kpp//LdKM/twx3a+Hi+vzm+Cq1yKMVAB9EVy+b7evy76ZDRM+4RfwXv?=
 =?us-ascii?Q?5bwlUelocd0U2TbW08DW2UDUXOel9LUwaS3WUIppcCS5M7ZZFP6snAfMOEsu?=
 =?us-ascii?Q?AG08rumJ4SbgMBzJuExTIMBIyp56FRW3O/wjacpdYwmIcLu14146h3Eac56t?=
 =?us-ascii?Q?q4UjpIhhhNarPnkPP91+UbKk1lNTPxUL3GLdcX72mPfkmp94yCEK9zkwsMKa?=
 =?us-ascii?Q?WGXBBd93LPQsEPl7OqE+HWWlY6rSnHRSPsfonJayFPjiYayUd6lrKMkmvrqA?=
 =?us-ascii?Q?+pXlgGZQj7ii4MYsl1m20kfi5sUjBeaAIWjehvtOsLE5nAx9UpO0fp1aU4zs?=
 =?us-ascii?Q?ZtUIw/0br4wckfkJkJJ4bDDUpQJTY1yWoQw3XphiAgIOwIPoHSs86L3/zMQ6?=
 =?us-ascii?Q?umOmPBHIkwlQFc7PKqjKdCs5wn7gu8e2X0zBbAlLxIKFvsvfQPd7+WpGQ5Tg?=
 =?us-ascii?Q?q/LJN9r5L9IOO7zYCTlCqLyi4byDMvA03QYgl5qCFLVHB0XIzdN0Oh0NoWuX?=
 =?us-ascii?Q?oU7M6tz1WRmfUXoTrpzi60MnRDNVJLtMvlnchHMzERk2q7lCyCGQPAX2i9Vj?=
 =?us-ascii?Q?ICMI/v5e518WGBrVPXlfgZksfcWf2e7NrrL6hHXnVIdowsqPAIoAbDBOdeBC?=
 =?us-ascii?Q?MoZZhmCfQp2lwGL+sl9gB9it/DRQk/YSlv/Mw5scgu8FBn1+pY6bsG/X04CU?=
 =?us-ascii?Q?aU3UvzyiqrGSox5NGfERLb3RrP0b9XuiYqhO0oCFs+BvF82/HY36srfX9nrN?=
 =?us-ascii?Q?rXGhKO+bJpqCrRRIsmNr9j9rmd+pRDNpHwIMxOfsWqMb2BR7yAhH2U9kmDQU?=
 =?us-ascii?Q?NhdiwFdqx3VhEVMatAOGvAq2jZUSnthT44GZGmHPpgrfUlyUem2rXiEF2H/w?=
 =?us-ascii?Q?vu9WB8sQpftgZSufgCfHqe0FSXwNq5wNVi30AXeShOnIT7fM3NtD84KrNVof?=
 =?us-ascii?Q?l8YFEuxSKqvRqML1jf3JE6KGzn2KoiNYnDkREV6TeqDLXAvlXGgaixNJw630?=
 =?us-ascii?Q?fIkYBLQ5SSwSPFx6bDKJ6kutvslZ5xZ2+O46zjVt0BIpX16ok2ZEUtg+2t1o?=
 =?us-ascii?Q?qA=3D=3D?=
X-OriginatorOrg: inmusicbrands.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e58dab-da2c-4755-67d5-08dc9ff9079e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR08MB8282.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 09:25:10.4577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 24507e43-fb7c-4b60-ab03-f78fafaf0a65
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BDdp0YqxLEStbuNR0WZ/oBMTP6Cwff1KOjpbp1RqEivwh/bqBMLWUG9/64GzGaDK+QbqVFXAvLhM8YGpvGBPLWkCgTeE7aw75LWH5xKs12Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR08MB7452
X-Mailman-Approved-At: Tue, 09 Jul 2024 14:51:36 +0200
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

For regulator-fixed-clock, the device's private data is never set so in
fixed_clock_regulator_set_enable() is null and the function cannot
complete successfully.

Rename the _plat structure to _priv to better represent its role and set
this as the private data.  As shown by the set_enable() function and by
using the same .of_to_plat hook as regulator-fixed, the platform data is
regulator_common_plat so also set .plat_auto correctly.

Finally, set up the private data by adding a .probe function to look up
the clock and set the member variable.

Fixes: f3b5100aff3 ("regulator: fixed: add possibility to enable by clock")
Signed-off-by: John Keeping <jkeeping@inmusicbrands.com>
---
 drivers/power/regulator/fixed.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/power/regulator/fixed.c b/drivers/power/regulator/fixed.c
index 98c89bf2aff..996da41546a 100644
--- a/drivers/power/regulator/fixed.c
+++ b/drivers/power/regulator/fixed.c
@@ -17,7 +17,7 @@
 
 #include "regulator_common.h"
 
-struct fixed_clock_regulator_plat {
+struct fixed_clock_regulator_priv {
 	struct clk *enable_clock;
 	unsigned int clk_enable_counter;
 };
@@ -83,14 +83,14 @@ static int fixed_regulator_set_enable(struct udevice *dev, bool enable)
 
 static int fixed_clock_regulator_get_enable(struct udevice *dev)
 {
-	struct fixed_clock_regulator_plat *priv = dev_get_priv(dev);
+	struct fixed_clock_regulator_priv *priv = dev_get_priv(dev);
 
 	return priv->clk_enable_counter > 0;
 }
 
 static int fixed_clock_regulator_set_enable(struct udevice *dev, bool enable)
 {
-	struct fixed_clock_regulator_plat *priv = dev_get_priv(dev);
+	struct fixed_clock_regulator_priv *priv = dev_get_priv(dev);
 	struct regulator_common_plat *plat = dev_get_plat(dev);
 	int ret = 0;
 
@@ -113,6 +113,17 @@ static int fixed_clock_regulator_set_enable(struct udevice *dev, bool enable)
 	return ret;
 }
 
+static int fixed_clock_regulator_probe(struct udevice *dev)
+{
+	struct fixed_clock_regulator_priv *priv = dev_get_priv(dev);
+
+	priv->enable_clock = devm_clk_get(dev, NULL);
+	if (IS_ERR(priv->enable_clock))
+		return PTR_ERR(priv->enable_clock);
+
+	return 0;
+}
+
 static const struct dm_regulator_ops fixed_regulator_ops = {
 	.get_value	= fixed_regulator_get_value,
 	.get_current	= fixed_regulator_get_current,
@@ -149,6 +160,8 @@ U_BOOT_DRIVER(regulator_fixed_clock) = {
 	.id = UCLASS_REGULATOR,
 	.ops = &fixed_clock_regulator_ops,
 	.of_match = fixed_clock_regulator_ids,
+	.probe = fixed_clock_regulator_probe,
 	.of_to_plat = fixed_regulator_of_to_plat,
-	.plat_auto = sizeof(struct fixed_clock_regulator_plat),
+	.plat_auto = sizeof(struct regulator_common_plat),
+	.priv_auto = sizeof(struct fixed_clock_regulator_priv),
 };
-- 
2.45.2

