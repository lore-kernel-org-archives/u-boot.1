Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EECCDC52D7B
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 10:14:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F64C889C9;
	Wed, 14 Aug 2024 12:14:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="nQLKniXg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69F1C888CC; Wed, 14 Aug 2024 12:14:19 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2070c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::70c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89154889A2
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 12:14:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kO7oqmudrCqVu6ZweQvowLWWknAYifAKTunOjxxaGYY3QL+5rA7I0Bc9h/f15m0PkhqPxxvnqFVh6+UjQKMbWQfvZYchd4W3WFJ3w4Osj8ai30bQqeX33YZ2YI4+PsVGuLlcJk5xXq88zILPnbKTdIx1KqAc4q0r3818+U8Mss5tzQpq2QE5yaz3mCF3J+FEbMeXt4nuYPaOAyAP7fbuFubpyUZgIw5deN6onzwc3cLlkETbqLOl5zGw9awtBLF6amSaq5c9eoMxStyV8oCUONttvlTZQcV1c2H/78heyA9KMrtZcgoTqGWQrXQDdYeqjKxj8ZDeUUO+ZQRVjAE9tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWuV6fO4RJ8g3GDYdwjeGujs8w/RzBhv9vfl+PFa/dM=;
 b=PpNbzCtLdejyHD4Cm2WzpMdIvjWcZRz9dn4pjTlNFPntjgi3NQJ9IXqZx/hnw1bVFMcOhvsyJDGSCFJEqZ94oRaItrV3N6d/GGEugzFKONOimR3pY238OAJHRphbbu3xPvaMNII3GkjlSNJ5xeE2NIsOEJeNRslp6JvdrtZilKRs0sCEM+xQc/nrXUf8XMJwQnS/MhEOLkfV2HF9BhnehW72VqoBLLgL6ot6aqDlCIvd2cnmyeUVK1B+qjfjG2gQVLd6sNlMHMZYkuWOY7eHH8adLVqb6TIhfap3ckNStzkfzFUMrdIxvkiWDlkqvvFngFTF93DRMDvv8bZAwEQTMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWuV6fO4RJ8g3GDYdwjeGujs8w/RzBhv9vfl+PFa/dM=;
 b=nQLKniXgRfKO81/ShYmCj+t5gdWWO72UWn3Vqsf4T0wJKWrQL0RS0Reaf+L1p7UeM841nW6A0/9cptnivpfK9nOMA0xf68zmaIfLLUU/KnIBmcQp0dMMcJwjdHreHsg1wCzW8uxWRBJZ3OQKmBHcbBgKw+aiEHJGS164IioaBuhzZoLr93s/zsO2uu0/q8vMCTdGXFDfjdQr/hE2LkAP+U6zUqmdwRUTPaLHZsmjcRFOdWnGbKuzFKJPoGRKhi3TrZiH6KdkfqDB+q5jjNa4dkK+PBli9lzc95Zq3JAGg4Q8NzZoDF8CMEouSOC1CG0yIE8nrKvD2KaQ8d1WS0yvaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VE1PR08MB5709.eurprd08.prod.outlook.com (2603:10a6:800:1a7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.16; Wed, 14 Aug
 2024 10:14:15 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7875.012; Wed, 14 Aug 2024
 10:14:15 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 William Zhang <william.zhang@broadcom.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Fabio Estevam <festevam@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [RESEND PATCH v2 1/2] spi: soft_spi: fix miso gpio property name
Date: Wed, 14 Aug 2024 14:14:01 +0400
Message-Id: <20240814101402.1346941-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240814101402.1346941-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240814101402.1346941-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0065.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::19) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VE1PR08MB5709:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ba9cacb-3438-4055-d57f-08dcbc49d9c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ybvvd/mzab/MnJjYyt1gXcMxYMg/JPuMECbysGaYWcFF2+FVX1YNlsxZckTd?=
 =?us-ascii?Q?zq3c46AXLQtyYXqVaydP1v+8IA5dO4wT/EgIUpZhUmwnLjNuP6FmULUG2kCE?=
 =?us-ascii?Q?f8dT1XEz7CC94qyVMC3IQyZK5tyRMz7WtGSL+1q+Wu4O7PNEq54rn0v96Xke?=
 =?us-ascii?Q?x7HcnXE2p0E/H775Mmw6t2a6moLbY1N6L334X9kJx4zW9mW3VZXQbMXFyUsU?=
 =?us-ascii?Q?jUbzRuSaOk+42gSj5anuXnRn+IGCwDREBieOfHY7OfV4ROnsnQC0Gt/B4rZy?=
 =?us-ascii?Q?stlh1gFndy+coZO9aLw0WGLxGF6Z68MSJVOODMoxjADp3SL7BWaOVQCEA895?=
 =?us-ascii?Q?OQk/+qYnXRGvE3794/kqEZLL0bR31+E3qmj5A/6ZRFyEAeI2BQmEcX1HlXUp?=
 =?us-ascii?Q?KfVkqOZOjWBSm+D0h5mTVvLEohLfZ1h/xer8D+A2fhPDvPZtgePht8RjNk7U?=
 =?us-ascii?Q?iFs//Lhjlza3WgpFFFvZB0v9pBOVo84SRJ5yN8K464DXvUxxUZm1sr+t/ZNG?=
 =?us-ascii?Q?dPzt3I+bDBbZeGpBdhosLzsuFY8xz3C3ec1BuGNhDBBdCbXEbdD3QayuJg2D?=
 =?us-ascii?Q?8MZzDHOeo6/ECSxywNrv7mtQrkxMDzd6k8CQIvMhXKi4EsW4WXRN/d8wVtI8?=
 =?us-ascii?Q?TqAyYrbTrvXy/L2OlTiw171/HeArcOLfwjj4FEojCGf2e+ZiYeun+FcdNrNl?=
 =?us-ascii?Q?pgpWejIxrkxx6olqaELnqnXxGCoOgXyG5FQE8Ue71EO2fQKs5IqPGb74+WK8?=
 =?us-ascii?Q?5RcvErVzm0VKemPnyQR4qOa9eVQ5TDk8mIKiF4Tciudp72KlLhK3NpdgmrXt?=
 =?us-ascii?Q?/vyV8ChDnaUHkPTYGtcFB4H5+EK5ecavDiSF/wI/tYWNanAa687IpZoyhOOM?=
 =?us-ascii?Q?TGgnp7w5iJqKcnZsy1TJTVZ6lFB2zBSBRyapuUICmi+g4yFSArQ+bADNbhbc?=
 =?us-ascii?Q?DF+3K9FoYyviPgVEgyiimFwPlRIBRMs4cCXkUVcZJ7kBkMi1Ul6GHyevRvQi?=
 =?us-ascii?Q?Gjrl18vzrLagGTU1grPwFHLR8PKOyUufhq4c0IAXbrLue1nWOEpfbXI/9uVT?=
 =?us-ascii?Q?047VJ/FR5OXFamO927BEnGeSaMENZpygstGpa7wTttVwGklHgOYg5p+DvacE?=
 =?us-ascii?Q?0oBmckOsgJc+Lu8Ye4VsnPrsp2BdC4oqZS7r6ZrKT3iZ8ZwIIOz+vLMT6kzj?=
 =?us-ascii?Q?bT/PuzvSJjPZX4kMYbO4GXrIvMhNswgWA9lDE7+TUnULjYrXVIHLTJS5wo+e?=
 =?us-ascii?Q?szIXDal5ASvppeiKtA7YggmdngQoXAvPAGHDorp0SNI9VLnTW1Tn2c4Yx/pk?=
 =?us-ascii?Q?0r3rpRzM909E5j/nO7PeFjIjo3FvMlTsv9SaPPIoH+mwlqKZD4n3D5ARxx7U?=
 =?us-ascii?Q?1x47w8GW8K/WbCsnaKXBRLVEnLIRu9knRXiVObbm+8oLN0s4yw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZZmpGg/CB4To02iTX3fVsxuQQ5vhHvE5Gv1q6ttWg2nPL6Dp738aSG+ORhL6?=
 =?us-ascii?Q?Rk9WWposCM31S1mw2w+eNqh0yA5y9LT5t267p0/NHlBVenVOZudDDGegqTWl?=
 =?us-ascii?Q?0qsqD0cwxAS2WkVv55ECRCuPSCvFHm0kBU1hza1Wmv8Adlt8UunW0jjkMgle?=
 =?us-ascii?Q?F30MgDRjRwJm5HkQKQcOUIoSnF0SZPIEJ9G/OqVSMsEQVWzGECy87ijYVZYt?=
 =?us-ascii?Q?l0+dgfWn+QwgghVQhF7E+9Aza/TJfTNcbkvZillkWCgJVUncMqz88gN449ZJ?=
 =?us-ascii?Q?VcFFTzUHUubVp5wO6ibqudW6P7xosr2NuWpwjUpeu1Ywbeg8bNkh4zGf+oQJ?=
 =?us-ascii?Q?DOM/lBuIMeCws8wEKD5jzxX9ygXm3WWQeTShIq5X6/SQK+KkYufFqnqQkl+z?=
 =?us-ascii?Q?AZpOp8Aok7PuciM/JzwPdfP9wQW7+0FQVuKRlsQLavE+C1BWCTkp2tBrsMpq?=
 =?us-ascii?Q?vx8IWolExn+RQPn51UvqrG5ioj9dq+L/l7WZfTct3nxYY5jSYCpNGZfE8mnZ?=
 =?us-ascii?Q?kOgLCn5R/Szm1MRRioNQ9gHT9geL0RQ3EJdPLJMySKRij/+dAFGO6zXfsJvK?=
 =?us-ascii?Q?XkPBSnA/x7Pdzx59c635vaGlCPLdVpfeVw9YRYgQ5StsJwxEfgVBvwf2eVgz?=
 =?us-ascii?Q?/rM7rW/f4pGzZXV9xQ1ftr2NqdzzeBJNEf6dbDqaiBjzbmjJD5y6Yum2HL0E?=
 =?us-ascii?Q?3iuChsvDvi2n/dUCH/jN/zkHRThAQoOjGXg8NU9zQMgax5mB7DIEdoDH+XEu?=
 =?us-ascii?Q?nXQwUgHbDJ1Ud97HWDQ4vUNCd5JPrF/BI1NUrITEF+Hn2r65ZK1ihJlZwZp7?=
 =?us-ascii?Q?pEBObUOe+dQZPndGNUt/njObZJtWL2lpmvFOv2UrOIzSXDGfvrIt15gGFD12?=
 =?us-ascii?Q?OGL3jEeRLAp/tVSZNVSPeOqhLCX1za9Ogk0yZay0jZtuy1CIRmHHTJhveJMp?=
 =?us-ascii?Q?F+K358/vHUCJB6iItCCRtWYs/qs6HAHJMK1Qutodvh3rInARxwB0sMNaWbmi?=
 =?us-ascii?Q?DB6vBmfL6r8SCiDLk/Lf1sMJfgfoTq2hFjY5I9UBD05gx/1wFECVyNXitELe?=
 =?us-ascii?Q?oZkG2rfM+D3KyL6t90DFb2Pde3GJ8PIQ4LFdjDyW+vkfROsyo0AXHHXHAJq9?=
 =?us-ascii?Q?W76weQPjRBLPg1a0DYglzibHI4WxE7Z7CAtYFkncC930h6SPN5AspXqQcuG4?=
 =?us-ascii?Q?n/LQpkI3JP+EctMdohY+t6sqAAAM93RcogJFmqEMWjZrOsuFujju1ZWv3jlU?=
 =?us-ascii?Q?ouWyshXbMuT+bw8zfOukvEzlJFzNxcNadTZOKfzl7DdXZUnRzQyQGmQeRKA9?=
 =?us-ascii?Q?pUpi6z5FzSkVFS6NtaqQimlaQ0vPnoH0bfgEiuGR0Wx6xkHuqpwvJuF9iRmw?=
 =?us-ascii?Q?y0IlEcjaT/2c86iQh7fpjczcRrRsxo9Y0NoGWkcqZqhgtSLZBzHa9JADmlx7?=
 =?us-ascii?Q?LVqc5V9RN0xiEJCMcx60Nk5SzYs2BNS9mQrq+w4omhFRaTIwdnn/thKccvf4?=
 =?us-ascii?Q?D//njJ5UpNPlG0QxD39qSNABefYCiuF52GRhglXj4+lEiKx6KOnw3yJz3Ol1?=
 =?us-ascii?Q?DHrdC5uLtnK67z5cHeO7bPqoJRJ/n+dFriz3Gcqvwae3EoyEfSN8op+Nqpmj?=
 =?us-ascii?Q?jg=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba9cacb-3438-4055-d57f-08dcbc49d9c1
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 10:14:15.4710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2HSFo9WB/QOHgTdlrmLU7fS/Wa+S56uHDgggsINHfSWl1cPr0pPTiVTPJNJy2QZSEpfFwpDhFmcRW24Ua9D3sAvsMmlw0QV7A+iJ0ZvB3Aw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5709
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
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/spi/soft_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/soft_spi.c b/drivers/spi/soft_spi.c
index 9bdb4a5bff9..04691d3a3ba 100644
--- a/drivers/spi/soft_spi.c
+++ b/drivers/spi/soft_spi.c
@@ -271,7 +271,7 @@ static int soft_spi_probe(struct udevice *dev)
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

