Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85031CF34C3
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 21:28:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 739CC88F6B;
	Thu,  3 Oct 2024 23:28:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="E2T1FRnh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 953F288D47; Thu,  3 Oct 2024 23:28:17 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::623])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8E0988D47
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 23:28:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C0sT/B/9zOVUQcXLJDlqcgfjehTIxQL4W/9es/5+bEBlk3UUk3fOTJM4i/veXxq2EcZTGHvXBRywm4h/B0R8pehsMqNy7JwX5JI9sdduayq4j3o0aVw2istQHA94hWvC1R/alDLc8OTgtqTxplaYPLeZVNTq6DaSQ2RNjhE/2dQsaVN4WJyCgh8t1YTatJtDi8e7StUSwlEU0lp3fICS+dIlUadzOJb+tKL1CRBWRmOwtCWQoAxsZvk0Q+SOIkuAX76s6MlmvNgiwWfvbkz12zYc3czeHZxxmyfX2YkPpaI1z9yz4CswHiSFdw5u1rzEH/brOjN84Cn9ZNUnLqlWGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xt35A6GCic3NGcSvAY95Q/Ci7ZajF5LoO2BOs8Fm5Rg=;
 b=EzQn+YTM+A46AT0h6gjqDsvgvEYae9K0jy4vd7h1DOOPiNf9z5RXIK8oYLky2lB7Dg7h96EUEzQ3AUd2WbfRT4rzRikWMJceImTvBtlRDnMc3gWJLKHXnjCbbEoPQm9jdrcHlwTRhk3ovMWsK6bF9CDg9w7Jow71613gn/1JtDwBF0/5JqGdJeTYbV97CrRtHuFMK773Sc2BowpqP4h/dQV8WQ2aZU/GR6SK65cTsPabpO5mZwEIA/9S3xUUgG4IbzhVMvg05cE8pQ+y3kBLuBcaWLD5ArM180LbF5ZVS072pavS+pxXPVVcsTSIbohQEQj+1HXGtBH33kPp920c4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xt35A6GCic3NGcSvAY95Q/Ci7ZajF5LoO2BOs8Fm5Rg=;
 b=E2T1FRnhSPme9dYASMQp9SVliGGsX1K3tOOIfeQdcw/xUEgn9v2GNAQ4soxWTYmGnwZsil/cVvoZCQltTzQq8UhKKWqoDxsOqq8uTboW2tI8XVsdMo3unN3mPtmhFfJZqA7tnBZjoWOuU5ea8zCjWV8yImo+DZwpxcAq3hCbofs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DB9PR10MB8118.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4c5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.9; Thu, 3 Oct
 2024 21:28:14 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.8048.007; Thu, 3 Oct 2024
 21:28:14 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 03/13] led: include cyclic.h in led_sw_blink.c
Date: Thu,  3 Oct 2024 23:27:52 +0200
Message-ID: <20241003212802.3810-4-ravi@prevas.dk>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241003212802.3810-1-ravi@prevas.dk>
References: <20241003212802.3810-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0083.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::24) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DB9PR10MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: ad7fbb3d-b672-4d03-8d67-08dce3f24a1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bbbGZk/+AiEfaYdxDN8ATl2rDSgNZ25e4ScWGo/XlB7XTZNbgXKo6WKf8fCQ?=
 =?us-ascii?Q?ZUdaCSDPKiwtQ7CCVOwv5+xoqe1wW5MMO952qd3n6O4q27miGD5e/t4eVuMA?=
 =?us-ascii?Q?CyPGyVIH2336KTSemgnuxEBXNPQCVGvqkkHLboxNRMzlyf1X80Ndxm79sZjv?=
 =?us-ascii?Q?TTpKJTPTWs+cK1J7wDgop7RxhN0Jb28OxmZuNnLiVJ0ABmRsyKe38k9lIELS?=
 =?us-ascii?Q?SMGAC/0/HauCZ9Xe8ZSk/UOVjYBoMzLjSR1r0Vlf0ZulH4Bg1Y7iPqGbiPwz?=
 =?us-ascii?Q?VO476WBIO0QKyn+e+ydzRPvoaB2I74d4i4LUj2URiyJgOr8k6SBEbGkhPnlo?=
 =?us-ascii?Q?a09JFgxjp6wicXVYfvp00p/S0b4x3NKyTUjG3GJdrpm1JLWpCH4vUOFeZAXt?=
 =?us-ascii?Q?MgQcXZUr8C6IGtWxjCejd3hsJtxtqAz8+fUfox7Kgi2S3rPSytwsUE/1FV9k?=
 =?us-ascii?Q?5CLtAX3f57XWra1s6HWLmQ3BJMdr2GcSEPnFAYMDTAme1QEejRjDjzBE5qw/?=
 =?us-ascii?Q?wljaRP9jN7cIx9/JruBeGi0+lr5obyWbeXsqhFf+hSdj3D5pkS7Wu2vulHbh?=
 =?us-ascii?Q?jTDZFGay9Q9pqsxArwr+NWa4Kx28pGCRqqNlasLEkcQaz7AYRFsLSryJKbb9?=
 =?us-ascii?Q?sS5DjCb60e63+56kb0RK1bnESepyH0WsYXOTSDZR5MVNq0gweh6SQv+rnRnh?=
 =?us-ascii?Q?Xw3QXIeeBdX9kopv0RZxyKE9C4E60NzDlVKl3Mm1kHoJEn8lsA4pWSFMS9rM?=
 =?us-ascii?Q?7WFBdKkr7Kn835JK2xWh4yrn51nWut9X9T3MmOv2ff3OtvbCVH/wBDZ0Ns8F?=
 =?us-ascii?Q?VBjJtwqgCovK8v99YgTROvJMKMeb+Huq9AsnvlCDq3CDK8YLGur/8L8d7hRO?=
 =?us-ascii?Q?GMvT9+naYs7xCR5YHOs9r+y8XZGFfDIS/qx0vdMVly3CvRjC6C9lrM5pBG8h?=
 =?us-ascii?Q?ur6iVLrfAzs5KUTCZu+jDMZF43NdjDUKZ611KBan8NCVOrIg9CHFT0qHt/uU?=
 =?us-ascii?Q?X2XNKcVO4XgO6gUspzjWaNCELd2beZYbckcO9ECVF2NH7Dp7GJYhgIJhB7qR?=
 =?us-ascii?Q?TP5/7iB90uV6d2jHOODUgTilrPmiBx+Z9X/lXrAJbRZCBQgJ6Adn2XK+VGzB?=
 =?us-ascii?Q?1dIYivUnhswwyTJNGINn5SzrGSJwFNIzYFelOuFgP2aKpHwuDr7x32cGq45s?=
 =?us-ascii?Q?vpkrKpQq8crkQV164wS7V0kubU+lH/nwVzKY2DmSN9msR56n2gToY38cO42v?=
 =?us-ascii?Q?Umfa0KjD+tYcZVx8ipgfgtfP8CLAHXe6SKz6ml8JZy170MCYMhIvCkme+N36?=
 =?us-ascii?Q?8W9qPigq2X/x3FIVwh1kJMn2TcztdNiE4eScX0LQlFseKw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BQpIFdIhFRP0A7vPIYFcJwCIpZ5IQ/EgoPIr0sBvjgYOS4vdzkTYjk9U1Hr9?=
 =?us-ascii?Q?dej6o8z1M2I9zOokAhmgcMvH5QL172P2mzNLLU0tkjxtzcZ7FE4nFtToKWpV?=
 =?us-ascii?Q?KWm+NA6W6W8+UMZdOeTZyrQS8gNQ9YlfS2CoAleQCesWdsw744hsnUzBqubp?=
 =?us-ascii?Q?nS3Of2oR3XuhyFmyKdogz/LfSCZFEQX39cnSb9dLzZZnzO8puNqydCZkWvS1?=
 =?us-ascii?Q?3Tl0yQAIuuR193zm/slWCfJxcUxfLf8vQpK6KJvpOeWaZebkJw9zgaJIv5IG?=
 =?us-ascii?Q?Bfq0Y1XGhRuo8uHX6Fl6L0yQOTJ5Gz9HRWEiFE3oMIr9JY1IA3e+Xi8BrKLZ?=
 =?us-ascii?Q?ltQSKRTRhT29wpMh6h9BSbpvOPT+oA8zYWuFMGn0niwiY3FK/YIFcrOVo0Gb?=
 =?us-ascii?Q?jIdCPJn1NxCllf84YaGuUOrGjZE/QcJD4EyztZM1rhSmyn5HsDyYAFrRIC7F?=
 =?us-ascii?Q?b3vr+8N3+dkDPjy/K1V9TdaUa1fYPgF/iWNHo3I4KnpO0S9e/JiWT7L6hpxt?=
 =?us-ascii?Q?Y8auCNX7Rjkv9tp9m2GytijZkYTZuKBG8cRy9sLARpp33BypeGr19wPxXlOp?=
 =?us-ascii?Q?WiwcLGTCQn9/UzkBujBiaitNLZKADDU2PTQdhd/BOuU9X4pmzF4xU8ABcVBC?=
 =?us-ascii?Q?OBZ8LhNVioGDVKQujqTUTE0dJkc5uwuiIGe3rQLabvKUn/W5FzL82iLK4IIL?=
 =?us-ascii?Q?8Wc8vuLyGo+DUbmz/mUySgJlb+Nq+r5s3HZCCYOFGxBcA9UYwJ7ktqPx5Ohx?=
 =?us-ascii?Q?dTnbCC7KXQTkL66LUopZ6qapiTTgA55oG/ssQPeXyDK699SnYHDzQ208P7Z0?=
 =?us-ascii?Q?ZNDmiGMBe1wsbs5K/AWpDjWiOLALbK30z4j2+SOqrk+2iyO48IpJ/1lX7Ck9?=
 =?us-ascii?Q?zRzVoKuDVrGF3F9PKevJgPOmyj29gSm2JZR3Qho3Jn3IBi7eTqC66teDd6Uo?=
 =?us-ascii?Q?BHf6voh4yGEODgSIvWJk0NodZhemX9YlCLsk6a0hPghHUvBWAtVGQUiu5f1R?=
 =?us-ascii?Q?qOz+YeNFeJKu7zgNAL4QmKW3mMoo1uIoTYG4fBhFrAlMlnOuezTsRvPYnopZ?=
 =?us-ascii?Q?7foAy2DBWeHOxb3E9kjPSlkg17jfttpjSWdG9C6lveE8g97mMO+NAFlE/i7q?=
 =?us-ascii?Q?omyom6rvPRp3H4nUApblVzIoyxAW1Z9uWuWXH65PwnqhZRYIQwO+6uGTlVXI?=
 =?us-ascii?Q?lPO4W5v1NCRuchK0bJJI1+BHTutkQAwLhV4ztit5PKDMBpuOr9e3RftJXeco?=
 =?us-ascii?Q?noo3XPbq+3/PKep17lRtK5svGaXZbZFCLhcD9KGAQKeT8qTn46tr4O15pWdF?=
 =?us-ascii?Q?MQ9cPCwrwllikxCDnUmgh88KrSEXx0v8zVFoguTASZJ5iY9n5otFe0q6dSHn?=
 =?us-ascii?Q?R+rlFuX/T8Gds65hdpkebxK757R95/Pyd0uTnVGpcPdJE+8gFONflyoLSYGB?=
 =?us-ascii?Q?SdzmRoEC4Ne04BcXnO14xbD1POOe8VDA/IGbUxoz5NtmvxJgjk3lwTkVYrq0?=
 =?us-ascii?Q?gEuuQEHlMylyR87iYgvmbeZMPBPOZGHcWIwALb7CuNaIeTK/gb1FgNQH4DKN?=
 =?us-ascii?Q?kL+IOuEwafz5jZ99zhIONQ+xZY/RqipvU/LleYvHN1kMnyrr5ni8cJJgJMG0?=
 =?us-ascii?Q?hQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7fbb3d-b672-4d03-8d67-08dce3f24a1f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 21:28:14.5776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dNB5AMl1lDRxKfJ3wxG3aBbzInec/0W0ohxYDS+Y2XyH4ukkG1SU6HWXv8yEEk7KeuCVtAW6eo94m3KgqQ1LmBBjrwKrghRXufAy5fag4Vw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8118
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

This makes use of the cyclic API but relies on implicitly getting the
appropriate declarations through some nested include. Include the
cyclic.h header directly.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 drivers/led/led_sw_blink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/led/led_sw_blink.c b/drivers/led/led_sw_blink.c
index 9e36edbee47..6976b84544e 100644
--- a/drivers/led/led_sw_blink.c
+++ b/drivers/led/led_sw_blink.c
@@ -5,6 +5,7 @@
  * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
  */
 
+#include <cyclic.h>
 #include <dm.h>
 #include <led.h>
 #include <time.h>
-- 
2.46.2

