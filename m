Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0064CC2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 11:22:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83FE187FC8;
	Thu, 27 Jun 2024 13:22:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="14m4jGNr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CC6B87FA1; Thu, 27 Jun 2024 13:22:43 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DCE487FC8
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 13:22:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kensJaLLtvU0b1uNqix9d/JPVx4ODwiUPdChWqYFNPpiR0QY0xV8GhRl1qhn0hgSYgeejNZ3G1A6VuHduB/WYoA9MZYyBjBiuIlRHKUzlknGFo6wEGTD7a2YX/vG8UOfKjAj5k0GhApis0oso3lMQx9Of2xzxZOjsZq/LTiw0QMUvziQT9ptTUZ+gB0NP/ztkvKwtmQrijHqzsNofz+paK6/NiKLDtVxnzmMvEEZAxsLSMGX28PUcBNIOggw66orfDwYOIacoHX4uK3FawsrngwdhRXKWFQFAEbXIMxF1q0QIAWbm4JnePNYD5+82oeDoIlExvoRaYKCxdXTPrJvIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wg6omXkgYJkutKzj3+yhoC6E/Ve7Luc1NT/yXnGZ3A=;
 b=UiPowqS/BN3pB8VbyIs8yZ79GviBmbB+h4AzpGE0tD+1rFQ1i+otLa/KnnjnB5lpOkxAlZ7d4uAJOV4V3ztLMcWfoM2hIIEUOhPxBwYp3sxQrFw2vQYA1vkOSN2kfaqheAuD656TOADjLYUDNXGqg2vUIVa/NXETzap3jPtXsnAkPeLlunEEzGZFTumozgv8fClKU0MiU4q4D7TXFLsG1vDvgiR5UvN5MIjqKtavp7qh/pNagxBU3EcrmNiDxx9RqwOJULqacpfvPBdxD1WKxYSU0XdPsEbYSzsZiNpmMO/2Oz2GI630axD3I+wEvq1fGGC/xGioPzvWzugEyN8goQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wg6omXkgYJkutKzj3+yhoC6E/Ve7Luc1NT/yXnGZ3A=;
 b=14m4jGNrnkcZPDuqOe4DPEXtdSN/YFyKQPahaZUXxgvDr50PrflpuywP1irUrjVvw2dD92WTBHlOfi+qcRKqTtkdCwNmvrHDZM2CAzDZjBq6hu4uRD85A5NdaqYGJ2xujrP1B43jXo4JxMHx2qwxHlr505Ff3GJn9fRKD1ZiVg450/41Ta3m/Nkr5D8V+gZJJ+RG0AzTRIdK/fzy5y4R+gmB8KdjQMpHwFA+1MQSuk33mDdSAE0iXrwIJxVW+wX0KRPnaNKa7WFiEykM4MVnq6hOMCYg348rkZ6M8EjtyFcvBVKAkIsfCH/EOL1LJDLcX+3cE6U2VHJmat8zokvCuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB7695.eurprd08.prod.outlook.com (2603:10a6:20b:520::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 11:22:39 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 11:22:39 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Fabio Estevam <festevam@denx.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 William Zhang <william.zhang@broadcom.com>, u-boot@lists.denx.de
Subject: [PATCH 1/2] spi: soft_spi: fix miso gpio property name
Date: Thu, 27 Jun 2024 14:22:31 +0300
Message-ID: <20240627112232.99507-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002E42.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::4f) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: b7e338db-e75b-4c92-152c-08dc969b73e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KYVmzkkXguHOQxyKof2TIcikJdWUK54q39P9sNu0hMKaTNjdTCRzfRuT1zu5?=
 =?us-ascii?Q?5qILRxdfThoav94dX0DezNtSnvySz03wzGdE64/jILg5eqpz3zTpMz9DLsuf?=
 =?us-ascii?Q?jyAeb6BD7b3VwSkaCt4rCCsxPhrTNjF2wHehnfA8fQcIx8cW1kkUTP94iTX/?=
 =?us-ascii?Q?LWqEE2C7NXEWLJhLpjwB83pM1V2+nJuNMBeyU/X4jvP3x1VH8a86s2Gx2JuK?=
 =?us-ascii?Q?TXsfz2HCGOWFJ/vE5eLItYuMz424N7f0vJbQKTKfqLOKaz7W/jVRojrOFhId?=
 =?us-ascii?Q?GyzQK4HW9e9S6SayaUyK/2gfZaODeu6yUsv5g4KNjrfhQW3oDp4Gkv0nRx8q?=
 =?us-ascii?Q?EiJ9+cm9W9RzsAjZkkzXBZwdyDlPB83oCfUFGYzUJ6p05GdT1DHsacH0E7Dv?=
 =?us-ascii?Q?0+XSj9GVF2tP8HizpDWhnDdiLQN6ZPp8dCXi3KgD0tGlVOLj9Zx+njcDgADm?=
 =?us-ascii?Q?biKTV/BS4jPM0w/efwiNVoJxsm0zphQMNeh1ww8P+FktjfaI2c5WbhbvNCMU?=
 =?us-ascii?Q?ZLvZqwCcFZTYBWik8h4HX2b+ht5BWIRAsO5wLbIcBYEgpIX2okd7pSJ7biuy?=
 =?us-ascii?Q?z2YLv3eREtm6Z/IVtN6MWgn5lj5HKrfnUZoJvfZe/A0IXudMo9TAxLMxNxk1?=
 =?us-ascii?Q?CxslEUuXMqgOtAaY3OlBXLtkdRO9+F766fTefXEvHtuHmdcGXgUXDq8KEonN?=
 =?us-ascii?Q?DTb6sbIbfGrKRFU46mgyNZMy99fdwOrbAv7/+cLVBthF3257+GaV9k4gO0R9?=
 =?us-ascii?Q?9Wu/68Tfu45P6LN+blxYgNWWKxAopVCyxdQULbZmjtGACQ5fiSizMsu7TFW5?=
 =?us-ascii?Q?j8Ck3e36RjdbmCs8jEz5oLGj68xgE4imTe6moMHUJmkDPFdi8qWr3zwKJbbr?=
 =?us-ascii?Q?cEP2QWmC1PbY0RcKwf6q5ciMeVVscn5I3f4eVDQGyVdWLd3NmSnsmlk4Ii74?=
 =?us-ascii?Q?Vu+PP6lm+q2cgZT+emJQX1afFRXIuRSlvbEnilA4BlHHlguVQbazYajJ1zAi?=
 =?us-ascii?Q?Cx9si/ExAid3NnmPwQILGU2vWdxffkKJXLYC+WFiGHJdwce0dFQPi2zTE0vF?=
 =?us-ascii?Q?XNfnQANTtUVVBbCg+ruTRmTD+IOpsqkhCdHxbiwOxxVLgWQCuT04ZMAmF39y?=
 =?us-ascii?Q?o4apubtXBDJhURSU6xbZHhHR+AK4tjo9DT565hkbvloqIV/fxQqsdZnoL9lm?=
 =?us-ascii?Q?523NXAF2ppzAP8o++fJ28UcgQs4ORY1TTiRl5bW5N3aduNQB5gSNU3FEU4EM?=
 =?us-ascii?Q?fy9EAVv5XOwMUrX5mj3w7dmGv/RnFOkgSYLk66O2GPg7ZgRpWpOemt2FydxA?=
 =?us-ascii?Q?TmpEHwEfDu4C+TinAzruQjLBuigZJVOT+zPJm14S8g4jmblp/qQejZfapVXu?=
 =?us-ascii?Q?b6/Qs5lmILDiXVGLcrnZFbsDEEDmbbgoUP+fGJH2wn9nqV7SCA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CzvYlRnvMvEKALGC/iAAaXi18uHeEMBLnlbI4bj9wMIpEli/OXulhlF0gYI+?=
 =?us-ascii?Q?qxJZP9GlHO2D/dv46seusokRtLqZ06Ou4ziQ4k6qCseVjIV6K44xQkpPhk1s?=
 =?us-ascii?Q?XzKSxVdLOBL0rq18I74rVN8YPb7DOn8oodWPMAk5uORSjJ8BPbeIi+D2DIIS?=
 =?us-ascii?Q?XUbAv0QtKQB55XTzxOoxia1OuisWmszOi2RNRMbqiGK6n7f08FUoNfqeA10h?=
 =?us-ascii?Q?UxG98SPQe2toJY3zLfd3fMgwsDKC5kb/SA3hrxD030i5OEurAkYrLiRBR0jI?=
 =?us-ascii?Q?BBY7OLQKq4DwZQf/2w8JfMwWc4ZvH9u/hQ84GvyJ9F5wAdXHBFcuIc/ZjxBa?=
 =?us-ascii?Q?z0I13rac6quiQBJEExAXGZS7KDgnTCkNi5ePcFXQT7DvBgCV+le/m+f36p1k?=
 =?us-ascii?Q?ENpeF8aisB5m1MuHniHB1SPjwwmvuNjNFLRcQaSITS2jdhh0Bjtw7+tnwD1i?=
 =?us-ascii?Q?zaNZp9m2YFP6bNrbJaMJnuf0DEfpQl2AVqnE0JsSviDzTa8H8syvnXBM7LEO?=
 =?us-ascii?Q?l+L5VvKyVraFkL7Gh+9Izd9YhWuK8yowbhdszLpP/EGUJm6qrBoH/car+ZBr?=
 =?us-ascii?Q?MWaTS2I8m6hBKIaHfgdyb9GwlfhhcZ68kVjRvm9mAVHgDgdpk44HewTpeThY?=
 =?us-ascii?Q?jN7fnPOrdnoEhODw5HpVW6IN6A6BkZeNtFACemr5xYFZmPFHVdvMeMhBTh18?=
 =?us-ascii?Q?t802yNqwgETvNiYQQKDJ2shwR1RhEPguJtqJ1XQa19bBElRj71rCO1g99KXH?=
 =?us-ascii?Q?Onfl5m6CSF9htQ8Co5vFFQ7XxbYuiU8FGUc4SXulylb9oZBEvRmjYtMMRZQm?=
 =?us-ascii?Q?tfRiqS9Mt1oaTptwHOxxx0K4oxoiQMJwi97AYJTINdJC216WINNHHNVWbUOV?=
 =?us-ascii?Q?JBogh6ERKEWsrwXOyRnKiEGe+HQEV14FObZNwGmd4MR3SGoiyNhc1f4O2iZ8?=
 =?us-ascii?Q?E4NUH3yQaAEFMXMNjPlXKu55Yk7GeSKgge7v7d9ml4LLjtIwBBalzuYZ0dZE?=
 =?us-ascii?Q?KIWob0dYD3k0bixmvEm3wdTVf7IckFBZqDf5HAFpv3+TPCzRrCNoF6cEZbar?=
 =?us-ascii?Q?G5J+QXx7ENOtl6PMSpi1zAaAAq9zVr2poW/4u4PflUNkVTKXgkQb7PUSP8ug?=
 =?us-ascii?Q?oL/W1VYabehrpoWFziU0HJ//vN4wZEHmAzoo8Vt4tBWLiRdDGXBvqF1vI2Gv?=
 =?us-ascii?Q?BOwjel4uhj/4nVsbv93TR2DTH4MNkXOpSkAEuecnhgSsSUb3c5KR2znfOHWu?=
 =?us-ascii?Q?JZXNyL8SxHzXm7vqqlNpTPhY/8dCkZk/QraSti3NjizHx6MPgzhnqO5dRCvN?=
 =?us-ascii?Q?bByf+pqIljwgXQcU37+I22rpTthLGg8VUIr6UznI5jLSF7tNzs+AGTBDIivo?=
 =?us-ascii?Q?XhoC4TmrMS5KW0uhmlkZpsLgyd1V+lLaj9NjBr7fUQt4Nkvq5hqvJM1yUO6V?=
 =?us-ascii?Q?flETANUal1bph1Hwl6QDmHrsQ3f2FLM055Gy2dZmGtbe9QL5g8w3nIeYmeOP?=
 =?us-ascii?Q?nD+t6tAASeue0qzTU/Xarta17dTW1gy71HPUGjrcjB5jsRhM9xN/5jiAT9Yy?=
 =?us-ascii?Q?XPXehhXYo9fepxyYC+VG59WPh0Zjb42ZZ6qbgtJU9H3Oq6DoPOHny//y1oug?=
 =?us-ascii?Q?En1zWWnyEhSjFbS9OQ0Y5D8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e338db-e75b-4c92-152c-08dc969b73e9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 11:22:39.0770 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i75izYGZYBncMuTzL5z5CSltpH3pCpSjIJf/i4/cd15gYmnRZQXV5K9feD/YjTaVTyH8n9uwuSI7Y94Uu5AlvukBrobMAMuGPwh4nrXxjis=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7695
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
2.43.0

