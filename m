Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 355D2C87FCB
	for <u-boot@archiver.kernel.org>; Sat,  9 Aug 2025 01:07:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5775D847EE;
	Sat,  9 Aug 2025 03:06:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Q9TO48D5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C1A2847F0; Sat,  9 Aug 2025 03:06:11 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 724A9847DF
 for <u-boot@lists.denx.de>; Sat,  9 Aug 2025 03:05:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G2nG3TE+cGYiiV5e0Qy/L2IF9BCQRofRfOH8q3rJroU21qry4AWmqZpi/VQSXWEky8MfUywvG1pUPb21vxQpnbl/RLHPGLTnjO4Ohe89u4X0LTjcDLxtpNP7sDRHpytFctiSIDwwBcaSueUPkgtJrK3lN2OlEQu44DMnK8WKLFb2L8HJkkAbSFqNA33j7DAQnRkD45tsx8jCs7KW9DbBYFk4+5Cfarb3u2CUwrSJobPKm9+jnzVA7DwAdFDDn4H9AkUIfkAYaCW25Pq6dwLws6MREDvUOkQ0EAl0uis+Mt2G30WAW97f/TYg51TZGboLs6sXhFYXVxwZac95YUawVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joe3FTpTyfHftH0nZKovFP4Po8Wwcg4QHNndEk6K+gM=;
 b=QSthkfdRj/BKPBPp/2PkiVX9wqNljkcq0AJ7AsM0mL/RnIDeaQzUJ1uGaAon8hqyYrUtTT91gCx1tsB8OM8b2AdSsvHbr0jpNkiqSvD2b1N2Hs3c0xSCK/wtSm0PCqDS5cXaD+j2ApDwZEkIBy0RIah1GvlH6VMefGCtrtHpyxYpFXWefgj05wc70dDmk6wYS6xpSWdxtvKNebd7uOKvXtIa8ahJNM8NnOevR+qKvRgpf4XLrb9+1hwtKs6kaAVWwZu5ZNE/1CdJJf7rm8Oscp2QE2tTXvr4ymDFZp+ZfW7i7c+Gv3xZqZy/QEItXirBBjF62factnQIJi92KCi3Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joe3FTpTyfHftH0nZKovFP4Po8Wwcg4QHNndEk6K+gM=;
 b=Q9TO48D5utGXxm1655u/TwchKPP+yhZY+iaUVe8mK0Xl9NRiFg12ZcMDpK9wBchZ5qBvfuwP/o7ZMZm2Uttd2ZafN1cLrQH/58I+XP29ufpGdDrpVMi86G0Lo2v1I0t/vYu4AhGwlbuZO/attNI7nTPTmTqwLNLTeA5vIH9CWpyGIKwnW6DIeA1N4u1JozO3eQxndKYCnmSmjElN/Rk9XcNFlvHSErZywES0YtRnTCH3thQrIn6MbsePAYYRgVcQqqPdmKbPJ9BbTytxXUVfN1kn/JqkR3z/6MgiMefO4K6ks60OaqBFvC5K+M/TlXvQxW5gkzqbl7jHvqG9wqVpWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB4PR08MB9861.eurprd08.prod.outlook.com (2603:10a6:10:3f2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Sat, 9 Aug
 2025 01:05:15 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Sat, 9 Aug 2025
 01:05:15 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 08/24] mtd: spinand: minor refactoring
Date: Sat,  9 Aug 2025 04:04:40 +0300
Message-ID: <20250809010457.3125925-9-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
References: <11f6f79e-0622-42e2-901e-16335ad73409@kontron.de>
 <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0102CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::29) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB4PR08MB9861:EE_
X-MS-Office365-Filtering-Correlation-Id: f8f1f00e-75ae-42ac-847b-08ddd6e0cc87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|7416014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nW2q8Rwi5+imk/aXmt2lR6KhwEBbT0UrkjwmqeVRLKeG5eptGVqHExF0GzWM?=
 =?us-ascii?Q?PFaYbUl79Z/mvwB4n7fIHaA7FNSdvhQsIQfLuYluAdaBr9OV3U/4OzkT+yWC?=
 =?us-ascii?Q?YTQRWxyrYWmPvRF5TYKrNHE9JlzJbdUQHKvK1Vdf0OMjN5dL3gjnNaXpHJtA?=
 =?us-ascii?Q?JZYBWvO5jnSCIVU9hlxXndG1+VPAEKe+L5+reQNBiP8/4cdRnhLZtIX9XnqM?=
 =?us-ascii?Q?dDAHR/ZUOk/7JkKXoecSvvvENsmpWERBX9sgdrvj+D8ng5wo584HexqMTci8?=
 =?us-ascii?Q?SSVrZEBNDXMMRxZQNqRNn0irkLZEvaGKM7fL8GfMqE/MF1k4eIUEpSzMMJxx?=
 =?us-ascii?Q?P8VwnLH9UcgRkHPfAIpNqaVc7mL/z+IYE+T8A6dkv+1sh96yqg+848WwGuyV?=
 =?us-ascii?Q?LXXQr6CHYivNK4d4hCHPXQ9YuFp1PtSE3P3Ul4XvDVFlYI/sveVvR2IL3kx9?=
 =?us-ascii?Q?/DWAP0mlkE9V8AIaJy/B7hZ5wRjt4+jZTq/CNpbwoRJP0cyv3j0sejDBiUdc?=
 =?us-ascii?Q?NSurvzzLtlwToLQWNvVezjp9cCc62BfrkEKvphurredFZK1UdnqEEdtiuWj7?=
 =?us-ascii?Q?BnOVR8Ca5ZmzncTDliTQ6WjqI9eMaSGXE22bwWdIYFJZ2XdybzA91Tl4Ag6D?=
 =?us-ascii?Q?RSXasOhbZgC8hzPlK2C9sb3msTsivKErVW81eqm6j6gVXI26XQK00o0OToA9?=
 =?us-ascii?Q?KzERcug9yiwA93kmDVhUuHoinnfDazCJ/gF72jFow/W5D+T4CueCx19Sxie2?=
 =?us-ascii?Q?LFsdkr8TAkplZfhzou6HVkD/X5RsHAwdW4JtIKiJ6jjivTDGE2W9OMqMUE4v?=
 =?us-ascii?Q?cHPtaQX0px3IB0jZLfNahOeKl1dFeQ8LeJcp1Pmv81iF0llSFJjJ95MrcxW8?=
 =?us-ascii?Q?N46auuu6URlYatynxk04IiPnA0z5Uc5dr0y3dqGM5n08mvA2c7CsFFAoLUWQ?=
 =?us-ascii?Q?5rrEoDJ3JXtGeA2rBkHzTGUEiQoUsCA2ByyVyRYjwop9Px9/Q0gKAPh9V/Gl?=
 =?us-ascii?Q?bA0qilJvaqqNsqJI0iZe04smpkjYLBUY3dpGgQA40/EB64sq/Smso94NNBJO?=
 =?us-ascii?Q?UrXtQMCGr3u4e7bFwby2fPc4brNnsOlDDonIOSXmn7/gIyaSGWtLZzYzlVKV?=
 =?us-ascii?Q?c6XUzBbCB4RmgiXdDIfdAXwYLEmnWx9fQkDgo5DKyNQHYAB0eHwT5IwRnhRT?=
 =?us-ascii?Q?+OVl7sJ5lu76CLOlTb78j25JWhgFF55v+TnGbw24KzeQRrw4/BGX4zfhhTnn?=
 =?us-ascii?Q?psJ2cgingQnT7G98zENEb3DS/5ZolCV46DKbaTXAby+aP33aG2ZT+0Onpkcy?=
 =?us-ascii?Q?yz8jbhKijVBl/C/nCKD6jl0G9sIIluumQUOzmNvdRAMYw66JR8XlgVoZURnD?=
 =?us-ascii?Q?YvLjg/D5s8DKokb4jCsDCz0cYIb+Wx2voqx0feuDWNRg1thsdlckteX7IZl4?=
 =?us-ascii?Q?nP3urB3uKXIrI0OgZL5yaX12Dsj65ABOQPAyhb3e2F3Od+ck0HnAv5ln+qcd?=
 =?us-ascii?Q?v3Y5ETxd0jscn9Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(7416014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qM4RNcHhanjPL/u7P/adt/xQTX/IUZIh7RZu8UTsEmA52l2ZHF2w1/8p1+9q?=
 =?us-ascii?Q?TmHLzm78NgllDSx/QqkscUoYcovmmkrKgdCqHXfADP1RckkcuPAy+IGCQrg/?=
 =?us-ascii?Q?lMCPXSIR95bepXYeAEAf1MwRFWo+VUKjPgFkYYobxD3SZwj5JuWH9gpN3Nvv?=
 =?us-ascii?Q?9qQKvLViCW5N91GBMFiAqxPBLMBrmgdE3+MBPOF/N2gDnWAXjy1LsI/xTntY?=
 =?us-ascii?Q?gRPNmPcXihiEmxprzhKIZxqIKSUnV7MNcdHK2G30HAHC32t8JTQLS4FO91LM?=
 =?us-ascii?Q?Tlaun00Y04oy9VILu+vhs+lWN4P0PpcxLUjkf3sPke08CFGOmIjcYpSJF9y6?=
 =?us-ascii?Q?pJoPnQqXY8VbGQp6M4QaY2lKm6ci183bWEeKg43Msnw2wDIeMPkY7C/Bbxzw?=
 =?us-ascii?Q?PSaFA0/OpC8Y1xob7elkNreclcERKI7V4UynGutJ516b7+g/p645TYt34EAP?=
 =?us-ascii?Q?rfQFpWtxCpWVKolzimpuFtNQTV+wqz6iOWdRiw5vpIkRK880OLnw5CDu3B1L?=
 =?us-ascii?Q?FKKI6FcVuF3MJTrM+OKYdkvf+yPqzgMPf0zr079HQwlgMZhoqn2H3Sc0nPfX?=
 =?us-ascii?Q?KdeFkXs7z0fAHLnIxKZ2rSevzF6fHXhy47YrBQd5gD+AnIJKKpcMJn8Nj1lA?=
 =?us-ascii?Q?8TekjBV+IgL7S6hO4wdW527i+6NP1+WySMYvuDddpc3juwjVYhBoJGka/pIf?=
 =?us-ascii?Q?fTiux71GmOPq5zYf0wjfDpKPWSBjVrOdmrR8jSKSWPaH8zylI6rMZFvkKF9Y?=
 =?us-ascii?Q?goIB/I25g5JcmlF+O7JOIApzwliCpdZDQtP2ai6PDOSJ/cXcehvz/qHIuk4b?=
 =?us-ascii?Q?y5hrNje/YxSSmlz/TIw+b2sHReHrGAeXnHQb1H2FkYcSD+FHApXv+FdOsbkp?=
 =?us-ascii?Q?yAV34KqcIIsYee0QtKRaK0bP7HpT4NXm8IUgokUcYaOk3qZy5V53ISImEye/?=
 =?us-ascii?Q?ZaP9IOfi2XAuc019OL+eV2U0pTqbpQ/5SaqKWXXulNR70s9iXyuTPpFyA7hA?=
 =?us-ascii?Q?n2ihwyzjlFeJvHM8S4BF0dKo4n2KuL6wblGC7ETPRp89j1r+oRqR59Wnr2Qh?=
 =?us-ascii?Q?lKoyTGnDA4iUPW1vbFc4dPAIy0/RNckLA4PzidpgmL0tle24bW2gOzEu4EqA?=
 =?us-ascii?Q?G/SHSaybbWLIHivtbCdNcX3bhaFxP8gD8mx40IT6OBtgVr076L2/fhr5PwMu?=
 =?us-ascii?Q?ij8wx3UZ4RM5n9FSJwFNP9vo8Q5RCaJv8pX5hWOWrmZXhtjhTIyIx8Yz9SPL?=
 =?us-ascii?Q?UcU1mYqpMqCRXPkjvBwT1azhXhMfsOde6OCwVgUQkeYsXFoW4HydhUd13mji?=
 =?us-ascii?Q?hKlhy/Ro1otiYf+FC0PWGy7XaXtp9QpGPyVar1JYcxOgd1O9toaIhHMuQmfs?=
 =?us-ascii?Q?C4g2x9Jyldh7t5v7pn/3WR/nlhqhogu4zJI2aO1k09mcKn4XVjRTVQ80e7RE?=
 =?us-ascii?Q?RFvgIwSas/Vnd03PvAFDtLaVxzxKsy+tNGQ0KFD8VeV9899pZ2HLp9yD3/t/?=
 =?us-ascii?Q?KoWYw0obe4P6Bp0TKSa4bT8szLFUZ+qV95dYYXzQh/IecferRfjXT7BA01zQ?=
 =?us-ascii?Q?yCRvvJ+sLdSOSLz72YMk3W4dKQifxtXZ5uMZ2JjvEqOV4UzjCq6vD2b19xRo?=
 =?us-ascii?Q?Wg=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f1f00e-75ae-42ac-847b-08ddd6e0cc87
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 01:05:15.0511 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SST8bmyaYslPsSs66BhI1Q8aSdFkx5jPgKl2zT6iCvvpzkVl7bSthf5tsNZ5v2xxRTQ94RXBsShHpX/uSJsYlb48FG7xdqkOdFWiDgPoRhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9861
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
index 098ed0c4cd2..df59d3d23ce 100644
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
@@ -1091,11 +1098,55 @@ static const struct mtd_ooblayout_ops spinand_noecc_ooblayout = {
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
@@ -1128,41 +1179,10 @@ static int spinand_init(struct spinand_device *spinand)
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
@@ -1189,6 +1209,14 @@ static int spinand_init(struct spinand_device *spinand)
 
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
2.47.2

