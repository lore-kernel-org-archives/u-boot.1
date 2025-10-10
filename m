Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D08CCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 12:02:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FFD18436C;
	Fri, 10 Oct 2025 13:59:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="hqCX7ISP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56D9D84347; Fri, 10 Oct 2025 13:59:07 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78154842BC
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 13:59:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohDywRURvQsfEA48o51YOcFU0R/ZXTzd2sAkhlMZiwpEWevPMWtVbstm8S/LXy/RJCfE8Y2kEP2O7wUEFIVcy5r/tLLUnS+y0RBcpLmNg/ZdctxG8T4JOWEoDLXNps4wNPgN6VO5xH2EZykAgE6zkuqGS+d5GclOMW0y15vF52KYefoWAQA3qkpfPssjm255x8QhcVxqGUF3z3KeyEwGEVjZTVMZi0QWEkPo2etC7HthR9Eu8Ia/V+kt3kiCheRnGYrPxYqJorjrYCslbsUVnBVMV0ORpF+B0gmuAOfPY3Es9Vo3GG/UskQ56yjLLixpR3Perw9iAXUQTd6ilIPvRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULly1+9azOSpUawL7sKWIIVDOOHxLfEt041BgVNDt0I=;
 b=Shz8TZPmMs591W2g4YVZ4b7Q0MTKxcnTbFz5W1/Ljja7nD/wcWWyXcSIEGBh9Rx4gUtR6Rm1K3ROz5nh7Uc9kZtL+7z5Q0JSNZMpsG3iRks+2PPnvFnRqGuXL4NBY8/AdK2eGNxAZ1j6V2l0RoCMCLutcTISu0V5gU+CfweO7Pzd6PL+0gRwadufkqwcJUUV6W0v7pGva3LiIDFEnYD1eot+H2zdmZGaGJxEIhDtcMbVidsIcq6okZdqQobifQIRIgOFehBVQlD94cklCF54UE4e1jjukwlbJg3shxIL8aiz1p6zOOFF9YjzKy20mVhhdpEwNBzk9YbpD+fzP+xVHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULly1+9azOSpUawL7sKWIIVDOOHxLfEt041BgVNDt0I=;
 b=hqCX7ISPtkiM3HLb6aVdmVjH34b4szLJ9nhCtJMkbYKIURcSgpWDvZv+RSoYHYlebpt10y8lP4RAiFFFaeCieDVy6aREFB/4EHavi579+xxicJDm7PLxqm/+Yp+11ZuFEAt1MhuiQPgCxCTbJkQx6qTDP7ou6QTbC5YkEpHqHoxYUonu76ZtHiK47gqeUPtTw48Mc0Od6YO1TFqDfdWjrmgCMAHwXJ917w2s2GtkdoJOSccnCz6JheN7qKh5Ln/6rJnqD3RJt8mnh5OkXct4aoWxrqQysQQ1OpmjWwePnQCs96gW4hrKMeplybezP3T26kcvj2cHEGe+mkYDCgV7/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB5586.eurprd08.prod.outlook.com (2603:10a6:20b:1d6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 11:59:04 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 11:59:04 +0000
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
Subject: [PATCH RESEND v7 22/24] mtd: spinand: fix direct mapping creation
 sizes
Date: Fri, 10 Oct 2025 14:58:23 +0300
Message-ID: <20251010115825.1531775-23-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010115825.1531775-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010115825.1531775-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::19) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB5586:EE_
X-MS-Office365-Filtering-Correlation-Id: 05a2ac47-37ff-4018-c89b-08de07f4685e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|52116014|1800799024|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TB+AlbVNEXpt9XpPc3aYGHXpC2v9z5a1bZbGf1WJMV2glvF6+4jJDFMtlMtm?=
 =?us-ascii?Q?ZrfNFO7OT6Ix3THxiz/1MWH9vmRGb+MMSZZeMTNJ6VNnzmGcccwjf0I/aIlh?=
 =?us-ascii?Q?WyF16MeeMx+Hv51NArYkY8ABAoNtokZT4OSdWtvkmVdllZrX/7Rw1pp1Ho+I?=
 =?us-ascii?Q?AXhYJp0aGv5XUJUsD9HZzPr1mgLMVWincOP9sRXsSdz5uVtDe9HJlg598ecs?=
 =?us-ascii?Q?aetALGXkhdZ3QW8/7qxHiGBGLqXUY3JznDubryqycn3qW35YEYLQXRoXgOxq?=
 =?us-ascii?Q?qdMaYlsGh1e3MfCnkm0A/OpUcvqYq0U3Jf2hWJVR8mo/XooRLoO0AEZwqT1K?=
 =?us-ascii?Q?9NH/vB8ynAverLQd2qgiM09NGEjJwx1RvTqYkE52pXImJr48RJhe5eEtDymC?=
 =?us-ascii?Q?Gc9dItFCO0w9+z/SD8KRm8wtxDzSTPcfc6mYM6UnKS0LdChfGVlt1IqEyFpO?=
 =?us-ascii?Q?FUhJQoOLUMKL7EahrzCu3mPiFNux8HkeVIxQmXiGNqMT2oUYMKpbVlAZnqAe?=
 =?us-ascii?Q?jCWTVKhw29jpJgkLfz/+cUy8IOZfbGyaYy0ySi4G8qi2Kvbr299igVbNkz7a?=
 =?us-ascii?Q?HH3jiKgcwp5/TwMkl2pQmWtsJwsgmjJqgMI2rR1Fl9O//1HQyYbd87bJHKZo?=
 =?us-ascii?Q?xJzOrxz8nTgr491U+E+D0kh9wgzvQP3jyUpJQwFFlEASi/cMFs5aZ7X41Ejj?=
 =?us-ascii?Q?zQNhfaF0qqz6pbaImtZMAqiIuPblrasoHqtl7GftL/AMyU2meh4wu9EuF3Xk?=
 =?us-ascii?Q?a5Vjbd/B3pD1ITjT7ARQbgv0D6AQfQMDy3OXlizUc9Py+mE3BJx34e1DNuKF?=
 =?us-ascii?Q?MKy3PO8IldQd/WAEnHRz9tvTvKcbymRVhY/4MhqwOmnS8x3u78NrV0qYsIXj?=
 =?us-ascii?Q?PUSI0XGV79ycDwqWT8GKabokQsDo2go96vhl/Sy0GCOQ0re9eMfUhnoBJHAE?=
 =?us-ascii?Q?+Bu5Sgx8UU0N+twmbA3BNLgtSLVchPI8rVUSkR++WboczdHYDDk2rGPUmUiZ?=
 =?us-ascii?Q?r+XFRrGnNkW1u/iJd48imWRofyKJ/Luc3ItZLec8pQGSaV42VFHBxsLs6o2h?=
 =?us-ascii?Q?fFw3xVetzthHjT7CeUL99aT1NMm/4MYcy3LZCQxUZXuCx1fLCMZVKbgUpkUp?=
 =?us-ascii?Q?jbk0yFQ3BNuV5Tx7FWiNuCTKEWUbQXKrO3Tlxc9+UKNYOEYgPCOBz58kKgQC?=
 =?us-ascii?Q?ZV3fvz0H2udhiEgJDt/umVtnB4H1uVpyupJ4WcGJpVgz5Km91r7pmul4JET5?=
 =?us-ascii?Q?kBlOdzC1lCMMWBA9SxshtCb50ZiYqwHWVqcvj/20HFGw0XXsS1rFJ3pGd4q1?=
 =?us-ascii?Q?wapMeY4pBCKxONuXys/qZKR5nl7dspBbaRB+UKhIq+/62J0zQ1NiRFCqODHP?=
 =?us-ascii?Q?yQC8EV5UsOrIni4zhcZO+MBmFel+kfVM4KYC9Btw1jDHuA5qrXIKbu1ntpX0?=
 =?us-ascii?Q?PZ1AruP6qqdbt8AnBo47qUDmECGMbjcOe28s2m7uaW+VlX44lJk+5VgZEUW1?=
 =?us-ascii?Q?QbTlMs6vtDh7FazBGDEWIXuDacja5VpvyT5UcPFAjte7ck0o5SfSdhuHxA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(52116014)(1800799024)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JuGmK8TI8HwBXl09X95MEjoK2etLxJ5d9Sdbqpg3p6qkzj3Qe5dgoWqozWqo?=
 =?us-ascii?Q?HRMM2XfWbERONsH9i2+qZ8E5l8dpbOvctSqyzYQulfg3GazCvEnRdw7lDFWV?=
 =?us-ascii?Q?10O5gPpPagt4bZODJRZ6LbsFQHM/AYhGjNpGczGPc1Yy4lxWA4V7wnbUUM0g?=
 =?us-ascii?Q?JVhqIuVojmRk6SgZdR56FSS2NXputPvxGjdcGRBBSSra4WfuC8gTRfwBPFwB?=
 =?us-ascii?Q?TmhFBgfWE0FbgsVm9ua8JPg66NEegHHacZvULiL4SsDIohNHzolioYNb1pX2?=
 =?us-ascii?Q?DHzz1CQZPioccMTRiRkpar1lUxpNqbj1IPI5OcOF8YaAgk3bE3kO2WT8O7Ly?=
 =?us-ascii?Q?RzvWptd8/A0sdF9Bg5ffzrmbTzpKErZfnKxYf7gDVLiOS39d5kRkZmBOf7AF?=
 =?us-ascii?Q?q+OYoTa06QibJpg9Bw/0pMQX9MRN6uJZIcoyiuR8buvUQdp3OFIHkoUAeeoi?=
 =?us-ascii?Q?wwHkJG9rR9TIy+TxEZpKBKBRld5XGMT0h6Fhozgvy0Obvtt9TT+AGdXB3S1G?=
 =?us-ascii?Q?JaLbcqfzMknuX3/mcAD2rTK/QmdyHnvE3OhT4NZ7EubFAMLEFY586XMwKegU?=
 =?us-ascii?Q?pGdn+sdWKRlTy3jKDqV7pSwLef6PTBDAQm7DywrBZ78D1K35crOQ0cW1JDvu?=
 =?us-ascii?Q?9ZVzxGFnEWfplmRb+0268FTepr1C01xhfYoG/6RsBhQfoUBnQDfHiqBRKHeV?=
 =?us-ascii?Q?LZaGkKADv4Pa55XR4BvYYyg+0kacra6R4ShkO+uyKt+2FqNAZzv+f9SiBSTW?=
 =?us-ascii?Q?Lp12ZA6pSiytR+uuGcg0Ncjj4rgbW2DvikelfGtBIsxVcdjMqFzEDv7JtHwH?=
 =?us-ascii?Q?DoMbO7sypFv/mSkX7vbE6NKu6a9WMXUh06agJ3MU27pPiMYv/M0F5FbuNBqP?=
 =?us-ascii?Q?qUjs6NqfTByISyZd54XkAdyZh4LA6Cw65viMOP2RZn6ipbHrKj5faMhTU8S8?=
 =?us-ascii?Q?LKpKK++hKGYSf6KM6F0GOP8rsxUrCETXu0+qZYzC6z/UfcWEnOF5rtxzHMEt?=
 =?us-ascii?Q?LIYFGTjRyZ2Px3PTXDwq81yylFmS7VibdW19TB4DvLs48B3TP5W4F8+lIwwg?=
 =?us-ascii?Q?p6l3Ug1d9bbnGD3yui6KJHdITi519RmKTT/rwT2KXu6+9fTOg5lRyRRSPx/R?=
 =?us-ascii?Q?Kg/3Q047z3jOgjNFAU8nmrdqnf7KI3XdMKtsd9OhUL4FK52DNZ6S0P1JQPx3?=
 =?us-ascii?Q?tByBr5bD6wfr7aI0NCPyb1oTTBjXKMARU4oDRBYzvniCoFJuxozgUnMCuI9z?=
 =?us-ascii?Q?b0LqC7oIjqdGYSmFRnUmoiJ+EyhCAIMDKK3RBnANUBovra9WH3GJ083sA6mb?=
 =?us-ascii?Q?MqT4AV5ecAuMpunljnm5Jh8zuCuEWaeHjLBvlass5a/EEjdhvaZxHZD5WxiK?=
 =?us-ascii?Q?sTpF88J4r+Fi3YSJceo/YpTc9iueNK+RCgAh3J6zfFKab3f/VYCAmaN9emOe?=
 =?us-ascii?Q?EGdvSFkRBdbk6LznitAJcLLU5ZM8+geOqMTYHccBgo7vggEJEhq3vZcZ9F/d?=
 =?us-ascii?Q?aAuhNFhJ4mwfJWEGUXB5S+umL9EkK9weHHRV8KSAf6tAbE3SVeFTZgLrMD0l?=
 =?us-ascii?Q?zTaDDHCJOrfcjpgXS+zH2A5MH1DQwE9XXhYgT9O9FPPZTKKO1FPvjx2dfDT/?=
 =?us-ascii?Q?ZtnxzEdtJ/ygmaLrL//tZd8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a2ac47-37ff-4018-c89b-08de07f4685e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 11:59:03.9519 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 08FxSUHvfAqvPx56bEX3Z2fCIp2TuGlmZdL4/9S9MR6gfSK/lcRkvkRVxtFyO+/wotkuJ20Jf2ODBRT2pQeRMpJPpkoGZnrPdxoO6BJb/Mo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5586
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

Continuous mode is only supported for data reads, thus writing
requires only single flash page mapping.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index b3d53e234b7..69dbdd60a6a 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1118,18 +1118,13 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 				 unsigned int plane)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
-	struct spi_mem_dirmap_info info = {
-		.length = nanddev_page_size(nand) +
-			  nanddev_per_page_oobsize(nand),
-	};
+	struct spi_mem_dirmap_info info = { 0 };
 	struct spi_mem_dirmap_desc *desc;
 
-	if (spinand->cont_read_possible)
-		info.length = nanddev_eraseblock_size(nand);
-
 	/* The plane number is passed in MSB just above the column address */
 	info.offset = plane << fls(nand->memorg.pagesize);
 
+	info.length = nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
 	info.op_tmpl = *spinand->op_templates.update_cache;
 	desc = spi_mem_dirmap_create(spinand->slave, &info);
 	if (IS_ERR(desc))
@@ -1137,6 +1132,8 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 
 	spinand->dirmaps[plane].wdesc = desc;
 
+	if (spinand->cont_read_possible)
+		info.length = nanddev_eraseblock_size(nand);
 	info.op_tmpl = *spinand->op_templates.read_cache;
 	desc = spi_mem_dirmap_create(spinand->slave, &info);
 	if (IS_ERR(desc)) {
-- 
2.51.0

