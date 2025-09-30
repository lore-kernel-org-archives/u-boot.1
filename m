Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9388CAC5B9
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 00:22:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63F17835D8;
	Tue, 30 Sep 2025 02:21:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="5NeWL6cG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB3DB8359F; Tue, 30 Sep 2025 02:21:33 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 191EB83526
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 02:21:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/PZxLqYwdPa9AeNe3Y+Pt00W5695qpms4Pv8jwM50kwfY/nWKmQnKP3gdNYL2cTPUx37TnkNIGjw+Dr/T/L94reU5+bVBnHG/wdJp/9bNJrlOwO1GP0iqCqK+8SfdEjsv4/en5qSvVIANxqSPdkGOJhXnlix5416SuNSfLzV/PL0QfrAfrVeZolhJ5oU9NXb0YFKOWsU8YGdFmR7XRHT276/didDObWtZ2o/0G5p23yu9ACq2rhXdwqDCF+davuPi+6r12IRfDWfSfrr4pQY9wKSySJi5SKRiPxSDCM7CBcv3w7A5tE1zwQA0jNZuKsbiPEpjHfoy05XlYhG+auMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKlhRJrnn+zKClAl9tyOh8itPQoe5iT7tyc3CTQ3aWI=;
 b=fYA73jMqLpTAy9MCHEKYUsy2LnvrZKjTQHHRXj6bLDN1hAyyalo+aRx72jO3hN+LHTMJhcAkDad2ql+eoeFUrTbtRQfXF3mi2ApT7TiSBl7hlY0cDMKQZ0l14JE9IubYuzRdAb+eBQGmnyVeJRa96aMt21kVahEDbZcKwKgd0MS025IE5KmcUTlJ6sanVQheLlR/WAqYej5wt39WPDU2rcuzLoP8dY9mZulc7Zg45BXDfIOiVFkK+UPUhMPY+Y0wgRq1SSXuTYXZB3iM8G7bJx1Qu3LJ/tjmsL0UdHLlKeNa/glOn6HQ7gBBMB0ImlkqK4X+B16BR+Gtal1f8L8kPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKlhRJrnn+zKClAl9tyOh8itPQoe5iT7tyc3CTQ3aWI=;
 b=5NeWL6cGvxHmWSCUAxLPc+suDY6RBOD8XP9C8gSvnQVq2UiWM0b8DOer42+oRRay9+6xevQsEM+S7dMu94qTP0EsXaxjfClorCnlXt7UxEZqLIDPuwxBOZ+VI1OHBksUO5HWXNsYb/N+OtYf92POwvZUpVAV/kfnNoIG3cAtVv8Hy3T7mBZQVV11kA+DvzUrTvahWlIZE+6JauiAzrqNeZwkWHWAfrHO85Y+NosfJJjt4sJLXwlOgftKsBDGySdVK/bMJu9p3FPVbqaTMNJZCooMoO6W3p566WmUWHySkAKFbB2sSN5YlVRehm7WxXaT7OV7GY/bvOt1VCmNPSeKew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAWPR08MB11512.eurprd08.prod.outlook.com (2603:10a6:102:50a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Tue, 30 Sep
 2025 00:21:28 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 00:21:28 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>, Alexander Lobakin <alobakin@pm.me>
Subject: [PATCH v7 04/24] mtd: spinand: core: add missing MODULE_DEVICE_TABLE()
Date: Tue, 30 Sep 2025 03:20:49 +0300
Message-ID: <20250930002109.3600886-5-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930002109.3600886-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250930002109.3600886-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0317.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::10) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAWPR08MB11512:EE_
X-MS-Office365-Filtering-Correlation-Id: 7197a3fd-d416-4ad7-9756-08ddffb7494b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|376014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Or8BkrtgaY18jPeqNk2cfQuw/x7TOb09pUuQKthGicND8mtnjJR7KX4/Bw1h?=
 =?us-ascii?Q?hwbjGBIrhj2TYCQG9lpjLv9qlDo4XMaoOQh6qlgmBiFmPeMhJjhhF8yn4jN2?=
 =?us-ascii?Q?oHIpPctbtsoae0kI+NYmMLU5IWPmNVtwP9jncTu5oSiH+DFRbVoIxfmLilof?=
 =?us-ascii?Q?HpjbvyDO8lwuxuCZ+FgWZRjPj7TUiUtwgw2wrTVnuLxTkKjkoJ7V++Dwhqjo?=
 =?us-ascii?Q?4Ku7nc/HY7LEmJGHwdKYQf/1DEaviRGN8racmx8sLNnV042yhPavc3djE9cQ?=
 =?us-ascii?Q?dTPItzrJ/BMIVT9AsFQIBqcqBjo+4oTeppJsYzJRYwzWQVcIE0qdWHd1iZm/?=
 =?us-ascii?Q?AnXmx9AVudrfP6LDLIWEuSH8shiE9vVjjIFrnUtiAleunpIEQtiYXfMemm53?=
 =?us-ascii?Q?nHqz9UFgKRiFkxWoATEu8sMHz2c61sotBzCwvyB3A5YO8U0Ghru7N2NT+JaG?=
 =?us-ascii?Q?zkKJYs0QijZxMwHe6W1EpnB4GILNm0m3Q8JlctwM3Vi+4MoJ5sJVk073uDG8?=
 =?us-ascii?Q?buSr/fa/FrHodfFlegAvTbOrQvt0qQFI5ZNjXScwcjvZ0H1x91SH29gzOE7y?=
 =?us-ascii?Q?fh04fhtGfkUrzKkiVySfgHKe9gmymMZl+lzMfqN7TGCQvzYHvQ7wXjJcpzGa?=
 =?us-ascii?Q?pCy8Igewz7OLIb/IDOJEUjhcozUBoNKwuhjnEPcj8imnG39Krpns8+ZaYyB3?=
 =?us-ascii?Q?mwKA5d+Flc8Q3vx0Mqs16leHWC+v281GTPx1fqIFcHR9BTEVnae2D6VoZbpE?=
 =?us-ascii?Q?P8wAVLhtAgLOaKfUwOgEUbC2+cVt+tDosMkEolV8BnsgLWWzVoN1IJiCBKRs?=
 =?us-ascii?Q?UHi1GlY2gWvED1H0m1hE3Z2vcjKqtDdYsL55jRppaBEhZjE05IMj4wLVhMnm?=
 =?us-ascii?Q?MwQj63sPTPs+uc8l92Sysc/4SUSYtq285aItx/4VhM0g2gHdgwdJm2O+gV4Y?=
 =?us-ascii?Q?5KXhOLJT0TAcfqzH9O4KaMw6YY1xmgEe9261tTG2WX6R9kIJGE+4FYC3cDAC?=
 =?us-ascii?Q?Vth8jRqHWgjXA8RWUAxKpPAL2Z7n4L3EPz9c99opErounxMZGygrz+oPl/PR?=
 =?us-ascii?Q?/Fq2bcVQz3/Pg/5bvBQ7+YYElnVoJRZS8loUpakh/fPiU4050SwCeh+h0luh?=
 =?us-ascii?Q?y0hykPv+1Qy/O3HharOqPJyjVn/A1T5F6D5aNE4gWb8/UjAVPOhz1HKBs0vO?=
 =?us-ascii?Q?L5LFB4MfOcw2W00MpusI1sk2keCrqT9lKrYPsMOAfyLHYCfcruLQhR16cn9c?=
 =?us-ascii?Q?4MlJtCVt/YIXg7zUIxcJ5pHJQkTvegF72qYQrinzPEMhj6/tDYkiQBO68FDP?=
 =?us-ascii?Q?Uxr6/2yqJsAXenEu6pTOpxcxN1ntlvSZD4YzAGmGAulOYJ5FVVW9BSngHSV1?=
 =?us-ascii?Q?PrpNChrXt379j1hkIlIf6SChVv4rqNBkfqTApJjCD1ZacGITroez2O//1mq7?=
 =?us-ascii?Q?ObRvL8qfaVJ3Vm0aG9z9ZE5uNLzAqw9kunUEtHxVOS/ckkEmOlMy03t0cz85?=
 =?us-ascii?Q?ZfxY7xneV4n/fARv8CtApfdy5JRrp3nRawKuPFGJ2fiXwDUx8lOg9FBR4w?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(376014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VNe2plGZMreEJl+4jCy7Vrm2BB95gJspyDNr9ccbwIMk62bknysQBStwrk3G?=
 =?us-ascii?Q?Toz/PU6rp2vpQSyOR317fwpPHnATKK6UqfvPJvThk4ccKZXpIX4/vwXF/JMl?=
 =?us-ascii?Q?9R/GD2K4ze6qhevcPTknRakIVzxiEJNHWLpZ0lLuAjGta4ahVj5FUOfst6s/?=
 =?us-ascii?Q?O54xxeal/vMr9Vj8en39QbvQulj+0hpNJQU3+V/Av9OXzllDuhcdowVyNkeP?=
 =?us-ascii?Q?8+rY5nBk7XwJRdfTDnic3h3RZol56oYtp0g4HJAQS06YURCqubHniNOuQQPw?=
 =?us-ascii?Q?XgymES8Tmdj8VJxchyAdd7VmY3ftPpsEMuvro3f+fkegV437WDf3KPNUNZFk?=
 =?us-ascii?Q?hK7QOYJzfcm8Y3EG/CrKHQ/pkNAKkmOTlOfUpp6rveVFrYc7mwAayChKheJH?=
 =?us-ascii?Q?j61unhMat3vO/atfF7KDpQZDLTaH/6pr35/dv/Jn4r6Q8XP7B7RQLop6rP+K?=
 =?us-ascii?Q?3wse/aCs40m7pzZp3ihVioBQHy8ANXzVEEQXIVo3x+xszoUrP78KMyXc6m2h?=
 =?us-ascii?Q?qkYufF1fWampWSQfCCRtqEIJa/77antbdYEegKQkaCqd/x13FwXR6MOT4dy8?=
 =?us-ascii?Q?xsNR1urApYCrCbdOXb03D0LX0dtcZEfdy59VSjdXeykFYmPsoyB7bpDVjg9t?=
 =?us-ascii?Q?p/HVxzkLUdde5OXZ9+q9Xy+g14WcUNpjuw43oJY3BSrhxrW8F/SSO1lICALn?=
 =?us-ascii?Q?PTxHbgZHnbhqIFIyQ5zPnr8eCeW+ktseP4dhOfGAGhD6DgrkFHb2OxAgfWT6?=
 =?us-ascii?Q?u3WcrmGZoke7vfLB6dg7U05Znvy/QFJmyChQW/TLeMTJITIO54hftZA/SPNT?=
 =?us-ascii?Q?iIpGY0VX3YJm82Vr65PE0GjpKFmW6lNTbmCusmUIXPYtAvS6RgNN63xt5jsv?=
 =?us-ascii?Q?po8L/Bl+FuM0RlCaQbN+DZVipi8pLjRY8wf8xA132kfc7MT9vwstgUZm3ZkS?=
 =?us-ascii?Q?izepDX6iDi55hP8n1b3+eekxAld+hhNXtw9vy58NGxsRujJWabyFIs1MfLtr?=
 =?us-ascii?Q?5S5c170DR5DKyCbCckm4uVBAP2QoQ+19UOX8ClJXhqLzJ9vk6RFpycZ74VqV?=
 =?us-ascii?Q?ikBApiAkKHAPUBLGnJg8JrhkvIcwxIYVwwXm/hiqV8XaRlY/fmJbngqDtK2s?=
 =?us-ascii?Q?5YtqYSpBlnhmyv4HG7TWjTgn5k8OtsvlTWQONKG3+W7Udqv0Ecmvc37eXLBR?=
 =?us-ascii?Q?qOQpSCrwJY3jxHckiJ0hvrOLB9QTWmhd+AIHcsPBtQixwMv1DqxXXyMPSHgK?=
 =?us-ascii?Q?wtC/RwQhpsbn02sIs1qNPWbB8bYqfkcI0UfZjKRvFWUMj+FNOQr12dilID0b?=
 =?us-ascii?Q?UjCaQcgvsZlq0iXm6J+bLaQlSYYHuLFMA3ln0m0nir/EdKXGG1SVPUq8HYE1?=
 =?us-ascii?Q?mSLdCArm+OcJ4YMzQmlEqtT2NXZfItCt9JNpvQIvMDaUPTriznJW7GWofHZn?=
 =?us-ascii?Q?twQ2nhyTqab2anY+CEZ2MmFrNYP4J1CN5GoxfXnRqeIWJIrAqCeUsb7zJjl+?=
 =?us-ascii?Q?7Tju6jFrcjGJRZ8NMNI6qi0a8yfQZuqtVztZnDW8/DnRwzfPmWNsWpWB4HmK?=
 =?us-ascii?Q?1ihITdlIsnMAo+ggIQseOarnP8OiJhyVWDeIhtR9t9TkIPV9hwaPI79l0m6v?=
 =?us-ascii?Q?9cZqbuAs8nIddNR+xyYBzeY=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7197a3fd-d416-4ad7-9756-08ddffb7494b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 00:21:23.2315 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FdVvOkHUL+0WVd9yNrG6/AuB0d7gY39YX0Cul4wcplb7Rn3JHk+fT7zA3jVQyl2QoLBtTZBllZEG5A3bpf7VenTtzARwd4vIxzOw9X6Ils8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11512
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

From: Alexander Lobakin <alobakin@pm.me>

The module misses MODULE_DEVICE_TABLE() for both SPI and OF ID tables
and thus never autoloads on ID matches.
Add the missing declarations.
Present since day-0 of spinand framework introduction.

This is a port of linux commit
25fefc88c71f ("mtd: spinand: core: add missing MODULE_DEVICE_TABLE()")

Signed-off-by: Alexander Lobakin <alobakin@pm.me>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20210323173714.317884-1-alobakin@pm.me
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu> # U-Boot port
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/nand/spi/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index d8abd03e919..34e5ac33c63 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1285,12 +1285,14 @@ static const struct spi_device_id spinand_ids[] = {
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
2.51.0

