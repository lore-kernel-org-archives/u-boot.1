Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A42C30658
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 01:10:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 641B9887B6;
	Wed,  3 Jul 2024 03:10:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="UYf565ut";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7FE1887C7; Wed,  3 Jul 2024 03:10:07 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D198887BB
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 03:09:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aT6oTJesqc+E+vVu80pCCGdc6RYgpzCmbTum7fso79Pd9LluE0B4oltJD3Y1epVQjqG0hbq1lTvo8NPmEtUdaRBiuNq/QRmRmuf29z+7m+PP2WL6ZkP/k/WA9Ic/W0lcCq+p8B/qI9GGd0ObGNqMT9O9GG/qvsAgkl1Dv+Bv+b5WWjT1USYUkUgmcXZ/bb7afZ5QPFXLeKyHs0l0M4bccVxv8cdfb/+bLSSDraWLnqWmEtDlyYQWew1zrLqiZfnqd9QyXm3vCi8VJFU6GlQBpmtfEoLsuDQuNVSLnWmintDsAvAnqDeo4L5lQFT8obIdDjW8z41tM96Ea41QBeHkoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0ndmVAr72ruTSn7qa7UvOALi68jcboFzobZQ6WDI/o=;
 b=GsVfFCdVVDR3pGbBaJ5ermH3xbpC9wpsu815xnQR54CkS0czoAsaEbuZCDD+6VmsXLMpGdLETRiVOZ4lKxPIEsWTDlpyVV3N5N/Ksg67DH21eaftld4E/x5NlFFueRNV+lPPLeORpNxsXQ5veyzF4sAGwxWkEC8Y+rwpHQKxq1YXJH3vdpY0Mv2XknekXWp4olgJlwJia36CmtI292VDcltnI2/f+CWVHnl+Bkt+IzXXvnqMh8YgHtucJtH3yS9j4IU1C0KkWAY0LrXH/h5/Py2rw8QZI2/dB/IpQTH264O1rktPNc5aw7xQC2Wyczc/pHd2x+o4WULStb+PJ+ibxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0ndmVAr72ruTSn7qa7UvOALi68jcboFzobZQ6WDI/o=;
 b=UYf565utj6VNyOXbADAFkCPvvjD9+JMPLt63l9v/L1xFn2LBrcLQe0L5399bxk7602fXyRiWkC+DKtCVJEWoRyxuZwGfDf/h1iIL5hzE4R6HoskjQX5W0mkb8kkNLKMZO6vBwbFnRGIuda58tYgk5B5IzBg7yzwNOwfmMDrpjSMa6vlcTr/9zYL06X8bU4CyUfOR01P+d5AdYdbDl7ylWB3gTM/zN3MYsNs3xwSG8sVcdBfM8fzZOeLXrnGiFHPQSGAvzh4GCiLwr1qwlEgL8Os2DjVs4w7sUnJq/Wiew764l6/WLH7ps8H/QEy2t7yyi6Ucy2aQVPkIqffwuXiMpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6013.eurprd08.prod.outlook.com (2603:10a6:102:eb::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Wed, 3 Jul
 2024 01:09:58 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 01:09:58 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Fabio Estevam <festevam@denx.de>,
 William Zhang <william.zhang@broadcom.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 1/2] spi: soft_spi: fix miso gpio property name
Date: Wed,  3 Jul 2024 05:09:33 +0400
Message-Id: <20240703010934.1735889-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0085.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::25) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB6013:EE_
X-MS-Office365-Filtering-Correlation-Id: f8039f2a-e02d-4459-34f5-08dc9afcdb50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uO64k2q202kwhspgiVmb2Xhn+r/bSgRSkOkc4MFctrjfTYoSZNe6AMyb3FIS?=
 =?us-ascii?Q?BXcqNK2cAOwKFTdG8BH38VSFMhebgASYH0nRjqgWzP9UbEHjL4gu4FA29p8K?=
 =?us-ascii?Q?8waRmmJPYAXSUtMaUZmX2iJZx/mRF/VTOUH/jHEpCBJpDLJXYSyumgXuyp9Z?=
 =?us-ascii?Q?1uEz9MVFK+rtLQ28XVwoICxjAEOpZp810LFPUcwKIssOOr+MHqDFQVT2FZ5l?=
 =?us-ascii?Q?h9vMH/4mvZfGMDPD1bRtpxZxw21f3opzgda9gTfoKLL76PzvI63OcATFZsq1?=
 =?us-ascii?Q?YRaJFXLvG+LWj7Ixz/hJSK/myTXvjs+kw1gy4k0QfcAIiXWyFWWnZ9460wxL?=
 =?us-ascii?Q?Cn5fiufcjICpFV2Kh/L/O9tB0zJqqc6O6MhiVVlRDcTb1OsFtAeYucxVXp5U?=
 =?us-ascii?Q?ms8a9Vt8xiPglrYTG0U2nRhr3jwWjlMF0cWw0DIGsGBqPnqknaBiWjC+UO5x?=
 =?us-ascii?Q?qOjP2tByaENicegFfNVta5PijgRdJTcOJaBvLCYr28fIsv0Ax0V9JSyOum+s?=
 =?us-ascii?Q?llFXYFbMyRsL0XId23qU0jrJHsun7SSqGDQT9X9LYGRzxiMMq57DfP+clX1U?=
 =?us-ascii?Q?xkppJXFct8P4YFO+JohH2QGKGrHgMvfLLV47tdHG1ZLRVeS1vRWPhCoi0voL?=
 =?us-ascii?Q?OdzFgdx9o3mFVrE5y2TuhkYRcVusEWdB/FBzyusPRXBrbYYPYbukULQROBal?=
 =?us-ascii?Q?VS1/Hbq+Rv3fdwiLRj6oZRfHvtQ4WPt/f35Wu7f1JqDk5c12YygQ8G3j2AAb?=
 =?us-ascii?Q?k5eC2KLuqeeUdQsI6Ywbfi0M2HrGA1qb2lLX79WL+fLTh/pJyESuIoCqPTgC?=
 =?us-ascii?Q?sR+yrkh2MKrfEPQaubUj676zi3UzDgZdOAIsmivIWG3BsZeaiCvOmO2Lxybz?=
 =?us-ascii?Q?2hIuO3nzCgVeiR58cGS3sbFJRzUP5r4UcYhJAQzjZ5oLVWIxDpkDkVLtMX+N?=
 =?us-ascii?Q?u9sm1bVf3Kt5fBb5YToWIdAy+US36HTAKrEtNk8vnnRmqGomYJn0zUJ0ouJn?=
 =?us-ascii?Q?2ifD9yg8DrxAWRp7g5gGb262SgzPu4hNwxLvjfE2zuwQKZXYybgj8m+OG4Oo?=
 =?us-ascii?Q?sQSV/77RMPDwQiUctrI5BrqpB50f6vM9CX7dyPV1bekP8Y7VJ0DdicpkF0UI?=
 =?us-ascii?Q?Q2hknXG+SUhfUzf8vYiO/EFTJLZFhHfa5Wn5HRnDCiG7mMlhWOZKIpq7Ole5?=
 =?us-ascii?Q?7UDsK6kDmLO/OvV/ffMZYTyKGzmxmgoDPS6uY3qS0lchNzHDwRa0HpecGxLf?=
 =?us-ascii?Q?RGsF2caeJCLTjGJeNlmT/i3eHqwUUWFzyWpCQO4foe28D8KGbbknPUhQyLwO?=
 =?us-ascii?Q?zdF0bHXPXftnZ17mr79ifwyp22oFM4TrxNQK6647hyDEjWDID/r+o9+zcru+?=
 =?us-ascii?Q?pR2ffbUNW1Bj589KLUo3B2l/fdL3vdLVkrbHbsGegnQsJD1mBw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R1/DX+s8jvra5E1yv65TUD6X988dM29EjXRxQrCYQfmrrCgn3HUpdDktOtbG?=
 =?us-ascii?Q?yqDMEHrlxUTNKrGVZ61v5/Z/kTJcdjJB/R2SbxZx85j9MOVOfIwuQ3zAGqa3?=
 =?us-ascii?Q?ZuAaEr+ZZTQVE1VcA3OoNTcRnt0pqEghjNt71ossKXUVgMyFThvOsOSzWi53?=
 =?us-ascii?Q?MyVj91LfcKfGFZ5TbAuyFA4XLhEdwBuNOJ+g7gIQvtQ26GI1la+iNSUErf2X?=
 =?us-ascii?Q?YV0aAFacYGdpLcQCxKDvOdGDK8UtM3lg60Hef84Sxe+ezwm0dPxP6VMnIxDc?=
 =?us-ascii?Q?5X2RSBfCYY1RzARelblrIO8mk7xtciwL8L8/94PoXxAGb6QFXui46fiwM8Ey?=
 =?us-ascii?Q?N7gIAvn+jaXBKLSwuCLD1tLKxNIi7ArUh2ahMwpFsjVxGcbS5kPdF0yXeJlC?=
 =?us-ascii?Q?qB7OypfRBrZpnnb0ZecO965OIGk77QeACQFonnraJMIxEU4rroZP3SIAoV1A?=
 =?us-ascii?Q?lb69gbbskkhTDaain9peU/eWyZgCGT0D7G8Sb3kwr5p9Wws52kKoEQP0cIU2?=
 =?us-ascii?Q?S84lSd2GFkeG0Y5lMiBU3mrS63VPP9ua61gjuNSVSEueo8Oaj0pb5/3TIbX/?=
 =?us-ascii?Q?ezbJzv5rKCQaZ9p0HVSR/xTaZ/flpDGhejTsWFigMQkQ/xagOFGy2kW+gUmX?=
 =?us-ascii?Q?NnFcm69jL+hg9MrqvoJjPvEdicshTMBzg4furYY5eSpBB9KtbMhOq3/y0Eg9?=
 =?us-ascii?Q?g38JgeagBoqhq7NnTQRXtRyjErJVebw2gV1OprLIN+8b/+UmtjbFVEoDcQ9D?=
 =?us-ascii?Q?wgru3GteuDNjFN20ef8I2c9teHHWX6WZGjIzY9stOldODtSeoH8iLiNuczx8?=
 =?us-ascii?Q?05OX7cq4rLwFSpxt6Vx9eLSn6Ha2DSIU4uybdaqeTSonTkH5N9kmxNJyh0z7?=
 =?us-ascii?Q?LZxJ57VtNbcTKI6hOO2t+dh6ia53T/+D0WXJnG0mXswO30oL8EvDjB37KtSw?=
 =?us-ascii?Q?O0j5K8LOrmNw5dlFlOuo3htKqxbM5+GPB7BKZekMTLn6RjLDHvhIzXz6r8eb?=
 =?us-ascii?Q?5KmvhGGBDAt3xHIdC2D+CEZElLEAT/r7OIMQlBsJrq7uvbI5Ru311bneMb0+?=
 =?us-ascii?Q?QIDQwko7Ap7BX+SCUynD+i0hqSEYzvwKJglCSXl2YMy1NA93L6/X3Kf85YEJ?=
 =?us-ascii?Q?3leJqq7tA1mcZqPL10NMtZEj9zH4LBTmsYsJxz6CoYd+0C7ppLY4ghV0H8np?=
 =?us-ascii?Q?mBbnmGGFRGUmSHH9Hyyscn8Ds759Jj0X4VTQbV7q1uxMDnaOOHUEImKpEx/R?=
 =?us-ascii?Q?QxSgvMzMQ21KNdDmhb4VmeVgYh2+zk9R8KiHGVXTMYDxLRbKeUHrrLWIhrRA?=
 =?us-ascii?Q?Nv01zJIG77NuXOerVbtFJ6g0ErrP+ajIZqY3D3+wrtL6YgYyRtDgTWxhQxmi?=
 =?us-ascii?Q?xvPzX/gSwOICGV/Q3re/FeOL1i3NbZMEJscnyPhB3XGGhuSG1Ih9FHJVlvyw?=
 =?us-ascii?Q?0p4cViECRE1I584nNh7Prm6S5QyVRzH1Whyd8gBgT7dPcwnt5JEjhlkEfh2J?=
 =?us-ascii?Q?fYXDeVtjtEkXFsR2qVOo0EkG5MahFy5XxLTq617ZwO4Wn6wyQCnS6TfQo+BG?=
 =?us-ascii?Q?FwZ/EQE1MZjTLNKSsaDcih5P+FapjX4760kYOVvMPDzwKQ4o8LyMlSAjOXxK?=
 =?us-ascii?Q?gg=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f8039f2a-e02d-4459-34f5-08dc9afcdb50
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 01:09:58.3867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q4PR5Ycy3sew9mjB3lFY//mnjua5qjJ0ExZLD8rIF/YDfLM8fw4ztUSe/+NY3F/WZq9jjJDLMfb3+RLttvqlW75x7Dx2GTOccql16J67RwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6013
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

The patch fix a missprint introduced in commit 2e9fe73a883a ("spi: soft_spi:
Support the recommended soft spi properties").

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/soft_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/soft_spi.c b/drivers/spi/soft_spi.c
index 0fa14339bdc..3fe62818a44 100644
--- a/drivers/spi/soft_spi.c
+++ b/drivers/spi/soft_spi.c
@@ -272,7 +272,7 @@ static int soft_spi_probe(struct udevice *dev)
 	ret = gpio_request_by_name(dev, "gpio-miso", 0, &plat->miso,
 				   GPIOD_IS_IN);
 	if (ret)
-		ret = gpio_request_by_name(dev, "gpio-miso", 0, &plat->miso,
+		ret = gpio_request_by_name(dev, "miso-gpios", 0, &plat->miso,
 					   GPIOD_IS_IN);
 	if (ret)
 		plat->flags |= SPI_MASTER_NO_RX;
-- 
2.39.2

