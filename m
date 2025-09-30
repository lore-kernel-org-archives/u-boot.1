Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3BB8CAC5B0
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 00:22:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06392836A6;
	Tue, 30 Sep 2025 02:21:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="6QJijzqU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CAD7835D0; Tue, 30 Sep 2025 02:21:39 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D1C48361E
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 02:21:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GTb8vVld/4UZEU18kjEtMSABUnl/HLEoazJBhnewYx4fgHGgEdccGyaa3dtgJv566dxD9phTZYphrm5s3MNLncZd0JxZzaOPisJDSwVeQ+KusEzrfJlj7AbpK2EKz8rs5WcLMYUritVWFdo3D8tV9Q8U66p6UVqUF8l5RSghSoNfsqVVidtMqfTkIvH1UYZk58Oi9j8oLm2VH7oNhamu6jqUqTT9Yv4h/JNuraIb27d0PlKjbJvxqHqQTgc61yaixv14ujY5J0BIL7DcgU3L65aKN3dPoOP2Nkb/MfcaJYbxGA02PrIUrw05adW7fH7s2lutUUYXpER7lnQgIqklTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyqkra5Fo54Gnr98mnNB/TfZabZIYjZ9C4fUEkuynpY=;
 b=VzlTa2pS/8/5Ia+yEWFl467umJtbwvn6XfQ5/XcbmWGGIH/l6zelk2csM9jLIEYo1FXw25tIidLqeMzWEsMZFR7RpArPILqWSv7C04LmV4EQoxWFFk9UBlAkgoE52EA4qntDKL9l/EVgiVFyewJ6YIp9hao+RT+FAJxAw9c6iSAcfWoYkDk48j45MclP0RCbWzMA5DwPrHBwtVk0r+QNUqsDttOwE019sFcTjNAAjxDUY+TeUoRhMvE3CxHEnx+xbjCSHHJLfxV+IU30bnd/8Cnu/XBzaXtjeaAGmEqiCkbX2mWgSNiLcM30Ig4rD4wmguCau3PNn/ZZp1wmEWgHLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyqkra5Fo54Gnr98mnNB/TfZabZIYjZ9C4fUEkuynpY=;
 b=6QJijzqUBSbfzAmFpAvpn/GRQF/aZVauEJ/WVTdJ88tS56qpIxYOhxx0zn8De8mZfu0hHxYWIXOwgj3Oypm7XutzJu+BVBWZgQ1T9sIuTqUfe2sGY3suoaHxGtma8KPZFACpX4eDqa00ni9yfVejvGwCVc0MhWPpDgLeBAOTVbrK07yqkURw3WVzXezg7sCzwCSSDO6rq2B7bLlV0cPCB8Md0D3FvISJSc/49duFMUuk7Jxi+A9dkEOjt/Rq+xgEX/xbQhvvcpf2BKe+wAMd5SSV32mb5cjWBMUQ065zHNN7eIv5mNCQ+C/Up5A/nep/Jdv4XVYPa9kZdOsO/QaVCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAWPR08MB11512.eurprd08.prod.outlook.com (2603:10a6:102:50a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Tue, 30 Sep
 2025 00:21:36 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 00:21:36 +0000
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
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v7 08/24] mtd: spinand: Refactor spinand_init* functions
Date: Tue, 30 Sep 2025 03:20:53 +0300
Message-ID: <20250930002109.3600886-9-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: ec0a6c61-c0d6-45a8-35f5-08ddffb74c3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|376014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nquIS4lTWwgxZZIN7BLn8a1xuS6JAxeUByS+hdxiJO3gL0Fabn2KwgnOdhY+?=
 =?us-ascii?Q?mIbNc7p8tkf4/4n0qF46fdlXDSjTAd+61/vqVdCiIDFPL1oiMhcL/VSSciMh?=
 =?us-ascii?Q?2x8ipQitgOIo444CkcGOYFN0oqR//sqQ518kLiauE6cEMAZ6eSS9HN1Umqhh?=
 =?us-ascii?Q?/XzJ0PmDfE6HLexF/0dNYGRLDIdd7nmwzu1YjTXs7YXRUFMAM/KgaOu3vS2a?=
 =?us-ascii?Q?erMXCOIE7zeUFkYQKOpN/VnggelbQ+hwh57ZFV0GKnA7z2f+gF92uPXgQsON?=
 =?us-ascii?Q?tWLropbELVSMUS1ADLzV/t4ivC0faQqAPVfJC1MioTPSlMoqqOYFKcN73eDu?=
 =?us-ascii?Q?2quvVhpS0qpM0S1pkUEWjQ6lzFAhPOc9lgzTiw6zFJiMXt7OBlMm5W82Zj1J?=
 =?us-ascii?Q?UITh+D854Fb+10IvV4CqLGBwW7gBkn93ptZQHIxuYPgjnpdnxeB5sYnWXTJs?=
 =?us-ascii?Q?4j0Swr3DGygYnziJcc5eG0qZ/FPF9PF2H6nDlr/+Tt4mA+94r1VLDb6lthgE?=
 =?us-ascii?Q?/FImrdRlqCQXuPGCLjfZIc+kmadkPdqu1qQnEWaLvuI8F+PzKhXWCh1NCPJ3?=
 =?us-ascii?Q?TMZROMOjolslLZNR9aCEgm24aokzsgeJyEdwZOlqfMWFXFL5NdLq+zZN73n2?=
 =?us-ascii?Q?2MNGzlMWw/gY4Qm+OGtOGctWC57Otewx4zqkcNwoCvNqnBn253sLtQeJW31g?=
 =?us-ascii?Q?klmPbdFmdrQtE1oKWWz3yoqAf2JdF+FplF+MgDS8MiOKT5ZX7WmQ8TPqkElm?=
 =?us-ascii?Q?MFZJwtYb2Wx9OrptmR3wtds0EX/wgb/2wMBhNwGZaWhGTRrAxfAqSmhfRsaY?=
 =?us-ascii?Q?tjzCgEpZHxGQj/aVPEUaMxpmda/owtfh8h558xFAbDGFOqdPCh0OzwkXKQDV?=
 =?us-ascii?Q?7/uExyxYjQf2lc0SsoWPOIPd+8jQhBBAq9NJDqtykhbVNuGmproyTKHqPpkt?=
 =?us-ascii?Q?INLUaRqOLcvWJ3nUjeLVuGWxUUP6hGdz3vIDKf4BXLGFqvMOVJxB2WkJi/aH?=
 =?us-ascii?Q?YTHox/cLjXolEIZci/ZVlE+q1zRUlYGKZOQYxE6bhIyjjrPOUvUCiy1AUrfH?=
 =?us-ascii?Q?p56CBjx9rvOKGlZ5kM8eWAssqgk5I9wp5Zbxmbe3AzB1f4XzZSdEix76RB6A?=
 =?us-ascii?Q?aMXMMutEFW1UFN0i9xigT6Gj30M2drQXw1EE6ZSydVl6xE9q+9OUpEvv7Yb2?=
 =?us-ascii?Q?mQZwm6ya9ucuqJt0Vyymg95hIzL+/UtpdXSR7Vcr+9S5CPpXK0NxEE55E1QQ?=
 =?us-ascii?Q?a+cs7soHpqQ6ZT2m3AuDI05IMUgnBAdUBK9jYdRKKJM3eYgwHhJ/GCmJzv94?=
 =?us-ascii?Q?jo+LBiTANxS0o9rFZecBXI9u1cRp5jFwGgRfq4VjzFZq1+T3lCOdsvCarbsc?=
 =?us-ascii?Q?u5ddrLGVEAOaqlPy8yJgu0sbAsu5A9DwQ8U1QHtl5oMtZa/53QcuHYFiIV6o?=
 =?us-ascii?Q?elSAffQmPiY1mGbsoaoc8PJYwy1aABd/MMmpPqbmyCqAwvvxaaCg05f62kVV?=
 =?us-ascii?Q?jVBwZojx1STa53AycWa8doibr+CNbvsldOfB7sNbFmrrW9w1qt9OrSPBLA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(376014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZikVej0pFGhYC7awmRFTIqGab1PkWdw+4EHWuyI5XlMiJcm2IkOR63J7RV+X?=
 =?us-ascii?Q?wFe+Neypq0ytJoAxyvn3yJy8DXnmgcBcbH/cR2MOuT1grIhSa/w3zsLJXGTj?=
 =?us-ascii?Q?KBWc9eN+MPxJbpGa229+IXWKoD072APkZWdqrFIpXiSQKT0wqTdfXBOl3rUQ?=
 =?us-ascii?Q?ZmataaNu6FbpPiTltqtBgv6GlyLEjRzP0jPa/ZIMmyZnfR5HLOqoEYy8HE46?=
 =?us-ascii?Q?6Kfj3mFEsgqGjtGw/ZhXMKOjT1ptcV7Decpp0laXyRDX1Xqb4Om+BSqQ2v0n?=
 =?us-ascii?Q?rmbOZN78k5hIh9IKd4YjifKVPk1udjtz2p0+U2JsNU8JZZY7mzp/JoR+9A77?=
 =?us-ascii?Q?e4CVg5Zkjy749vo75XXluytxZ4OoEyrppSx8Xq/AoItYPPOyQURKPsUIRvBP?=
 =?us-ascii?Q?0RzzFfj8sTko8n36j4jZbiZdd0jQ9kyBWqp2IcnEZyxWHkjT4s5iDI2jECEI?=
 =?us-ascii?Q?L3DvaKFy9ww4BQOLxfn1LrRLL6tVsD9GBdmLexb2t0Y/pkmO+1gdwWP6FEe3?=
 =?us-ascii?Q?lCoJR+weQNVAFdFMECXwwvCCeCR8oXxX6aKtZMP0nfFgWl1MOcO1nVeHb7En?=
 =?us-ascii?Q?p1EQZG6EvgNa68aDULuQuRwIbcygPdLBKgqb4iK6S2cm9N3grjgw8YnEp+sz?=
 =?us-ascii?Q?qe6Dle7SuoelFQ1q2nzpGi9bPbUVsBeAPZJ5FG/NRimnGNJN9EwK+IOmfO5d?=
 =?us-ascii?Q?JQzF9PW9sy3rTvpu8erihUFTG4XfyaWwWVzWCs/wxmX5KI33fWpzgypzRr/I?=
 =?us-ascii?Q?oni3IOK6yBrIO1kBDfuwqL8LOp3F2Hkc8NpNbw7gieYO1TRa6U+4WlknYyaP?=
 =?us-ascii?Q?qMOdYcCLRB/1MtoJeOk9zhzfu2UKRmWdse/UDLsfGG7ml/1e0y5aqnQM2NCY?=
 =?us-ascii?Q?MvEdmBlSEsDdKStyKTNgSPK4SZnMMB1Er0Sqs0KSVQh52LBtOmCZ+Yh2Nih9?=
 =?us-ascii?Q?Davcdm+OeER0H+wZMr9TUZ/k9z+IvHSi1gBZZiWUMUWayeBqJP/m90f5K5B+?=
 =?us-ascii?Q?s8lclGtXonLvch6RUP9vSuznKWlZQgr1J9CGgkP6uPCcxuogGedWV3MfKorD?=
 =?us-ascii?Q?36gQV1PCce1jolpBlEK84O5PI7n7oM69uY2RCbHbNQiQqzc/bY+gDhfuDEDB?=
 =?us-ascii?Q?UliJEC004p7Mk47Fy1fSEQ5TXdZYnj0iyvIuhdY+ueZy0Q9MxYJyRWE8suZ4?=
 =?us-ascii?Q?VXzdZMMJyt3TBQTn12Hcbm3sfPZKkqhCvKnEGk29Ls+0nC/gGHaEOyF6dfMv?=
 =?us-ascii?Q?ZBdoURdNcchkX7leo6OFuoqhwZ++OpGM6yBLgfvILrG2DRYOKcSQ0uZitHhP?=
 =?us-ascii?Q?XEChzjiQXWUV12lvHLu5vnV8oMCZRg6EbiwnONUFr5g9e7/c87TkvVMKPhre?=
 =?us-ascii?Q?BkMKEFRhBQR8Xxd9PqwcBbNLn3XLQLAznT67taFXOG7h76m+6bOgUNYs223Y?=
 =?us-ascii?Q?UuxAZ5wg/zEiKqVf+Rwy8nZDXnC17KZrCtSRZUOhSlIBVZeugb29587kIlTM?=
 =?us-ascii?Q?enGqbb3B/L1e81lG7/0SoXM0jWsLcfzlzOu9l4Xr0FJX6J7bvleHGUiU7CBi?=
 =?us-ascii?Q?4QRo4Tt5F8XKvVJzDrJyniq/EA28Cfk7eYyBfPN6hNL88SQjaZZSL+1hxHdX?=
 =?us-ascii?Q?9lu0tBuA0I2XjgX1aovCriw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ec0a6c61-c0d6-45a8-35f5-08ddffb74c3e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 00:21:28.1389 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dQAzIWrkko3LRdWy+XWuypY1+yUeQt3W4D1fNt50Cho5MKFgfsy7goz/NQHG2snPblXAMA1xjjnagAim5afYb2mcor4r5fA3M/QicYBJ7z4=
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

No functional changes, just some refactoring to better match linux
kernel driver.

changes:
 * move spinand configuration reading out from spinand_init_cfg_cache()
   to separate function spinand_read_cfg()
 * move spinand flash initialization to separate function
   spinand_init_flash()
 * move direct mapping initialization to the end of spinand_init()

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/nand/spi/core.c | 112 ++++++++++++++++++++++--------------
 1 file changed, 70 insertions(+), 42 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 6d80b7c6d30..9b48bcba496 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -160,20 +160,12 @@ int spinand_select_target(struct spinand_device *spinand, unsigned int target)
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
@@ -192,6 +184,21 @@ static int spinand_init_cfg_cache(struct spinand_device *spinand)
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
@@ -1103,11 +1110,55 @@ static const struct mtd_ooblayout_ops spinand_noecc_ooblayout = {
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
@@ -1140,41 +1191,10 @@ static int spinand_init(struct spinand_device *spinand)
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
@@ -1201,6 +1221,14 @@ static int spinand_init(struct spinand_device *spinand)
 
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
2.51.0

