Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D522BCA0EE0
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 23:46:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36BAB83935;
	Thu, 14 Aug 2025 01:43:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="EqAtNFs8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CD748390B; Thu, 14 Aug 2025 01:43:56 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17982837E2
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 01:43:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RkYhuOV/nMU9M0Nqq5dAHqGhwf/LFr2JgPAaavqK1tlvOBXvSDr4HS7ZRUuWJl0BLzYR95mfhSi0+EBb0XjGbw71QBcax0gzLRkYUboDAIFCreULeOcrfiuBcCju0snRLOBA6Uah5IDJsJwlTiuMj93g2glYxq4BA+YdQ8RgJAv0vCuwiFLbUN0Ks32GzMw/KwiMtibBDWqTOVFwROR3xLUMX+347gPih1QQ/+IUA8QvgHTGP3HrixSEjslWRdkxrhsZt2SCV9aFYqAP2waE+KIc7R5j/SBMO7OPAXBi0MYqOcXBA2ggYCDZEqSIdRrzyfg50OICMz3fgk1X7CmEow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97zEqtMTthsSyUaSQpkP2cjBbtMW/uWTiveR3uNgLG4=;
 b=Em+9OGY/GCH7BaxxNqGhAeptHdtJhxIwVdozg+vUpmnkPQpMF/JPcIHX13MKc3X16ITStAMelkb2GsWhvlC3fcximrQh+z6XfPsT0y75SJQFkfrQLRNwuDkoV6uGdhuKCUDnvQPakHUWbTIRxEuw2mb6NPWmgqQcuJrLx4SDvyzr7PH3JeKZN2jTRihd4tjPOjibz5cnc3cY4oJQppxieHudH0BIKETJ3GxS/EXmElww2n7pzdPnCYmNNfKbwtEjSpougB9Ocl4XlL4VR66mTG/SXNkQF5hVkr7HxNAFSVW3R1X163O38dWh0bHsEIaxs9L3iUBewTXg2+J+QP1Y8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97zEqtMTthsSyUaSQpkP2cjBbtMW/uWTiveR3uNgLG4=;
 b=EqAtNFs889wtklPuGbjxzUb2Txf7eXMpctwL+C2yiX9Wdfu9odm3NCS6nw9UzuE1LCc55GHeW2Bjo/nMeLQD1HgKcH5Vso90G/3weHhk6AzFriO6WkKBI3a2XF8YHszUXA55SzL11jLseyhLsUoqnno3ePvD6OV1KRWU7H2LmH2h6CbmN+KtQxy42dRHMjed7aig+BUjrV0o9hwLHwgNXwZp0D1FMQSLvvs0mW8Hm37RKg4Lyv2fORAozVyWZfVDjVfhjJe+4rLO3OJ5cUREalgVVXRrKzTwTWO+nzefNg5p4vouhhVnQXod2a6V0ZNi//VnsYtYmquX9snPzPoLvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB7557.eurprd08.prod.outlook.com (2603:10a6:10:304::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Wed, 13 Aug
 2025 23:43:50 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Wed, 13 Aug 2025
 23:43:50 +0000
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
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v5 20/21] mtd: spinand: Add a ->configure_chip() hook
Date: Thu, 14 Aug 2025 02:43:13 +0300
Message-ID: <20250813234314.3945708-21-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
 <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::7) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 70eaf739-fa1e-4359-2297-08dddac340db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|7416014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+SbBjbqsGXwrlz7Xd/sIWK+NTVFmcleExkcmM4HTT2uKDBDyL+KDkJxei/m9?=
 =?us-ascii?Q?uyrwMuXdh5biWQ5Y+/NEa81X+RUAE3bRtUfWl7xo5J2KW5yD9Ka0ooQtJ0VZ?=
 =?us-ascii?Q?1SojcGo5tXgICBHFUiq9qW9yTlo8hHl+3movLcUrnkKI9DqIihSVgnTmRXn6?=
 =?us-ascii?Q?iovvWCvupQTO8uIZUNgGKoZnCwHQf4TiFA3dcSt2TX5R3WGwibLoUdVFoeLf?=
 =?us-ascii?Q?4Jw/GpUQGZRxjsJ72PiUKYi/mkzhQJAuYprfEeYW+asMCGxL80hXjA2hrn0s?=
 =?us-ascii?Q?k6ILGWruAZyRhuQNp4jtCxW1eOVJeF2qNJ6rL+VWi9PZ35itf+ogTmhoX39R?=
 =?us-ascii?Q?XSo7htfzWWW8sL65T+u2ArD+RE2QVp7E5O6IO3EOzuB9smgRkYns2EqykX4t?=
 =?us-ascii?Q?1t6zKeQUmIxJ7RcfKY1rSl98MqYbWpsLkaK74CnV7yUEmc4A/y6MhNlaJb8l?=
 =?us-ascii?Q?wLAl582YAI6bDELiqGtkSFYvE/IO6XkY8WBztP1pvJybetkJRz3zY+WAUW1j?=
 =?us-ascii?Q?pWFMs8qEqVWbi/G3O3FsIOtA3aV5AHuOP4RAvs7NFaVJQJLFsazoGAZsEFl3?=
 =?us-ascii?Q?NhYJktW1GvE9jzoVtzu2uEIttlW6+pNfnITTWNF5IVklSlUMW2HPhfhUMiUc?=
 =?us-ascii?Q?ZLCDkYXnSUe3d6jsSU0V08o/tUmN/tjHYNUvjrTfa1Aan/7SMYNrYWo4fxy9?=
 =?us-ascii?Q?kh65J3ciC/HDYacviHJcvF7np5vMorVOfYMDjo0aGG9NcIMqEvYcmST+vhn7?=
 =?us-ascii?Q?S6t+gI55hA5xl+xE4rRfko5Z5gHBMW3DbZWKi3UklrtqYTsgB49wR+kii1/m?=
 =?us-ascii?Q?2fWBCB87vaUm1CoBUt8XgvO9uDHON68xsN+m3w7DgygblWEMxKxqil8MAK6v?=
 =?us-ascii?Q?+AFxNh/ImZIGwxzhoBUUh/mNZ/lH25ak608So9BnVi7b5/ohygk/W/t5vScI?=
 =?us-ascii?Q?3Si8DLbbpEbu9dmbPa3r/1nM6g3LiPoPuLOVhBcD3k6ZMW9GwSJplg6T2WQ8?=
 =?us-ascii?Q?Kty15uC6qODXyq5CMlgjX0xQOsxgWg0xe+NTERu9aOZGileG45yuYCOiXhwU?=
 =?us-ascii?Q?Q27Z7bbrcH10kP3lvW+CKxvgMlZnvUKL3KxbCXgLoT5ChYIVH15+0UhRkTYv?=
 =?us-ascii?Q?exR+IK4oUnYi2BzcoBKxf1lxBxfQb9EhgZP+ATmkWgDynGhyuFCmlF8C+ORN?=
 =?us-ascii?Q?XKu0Al0PPEnNcXbNGiqFJtIc4sBPBtn6fj8PHUuDJIJIYwBqQgo2T7eySLZf?=
 =?us-ascii?Q?m+QRhi66jLB3oj4KAumGwpQHef1zZiReA0QcX14XY3cpiwPNKc7eg7S7Tbax?=
 =?us-ascii?Q?1adsWtMHQvZxhIMUUiL//U1OJbYTI4X98xFWN3oyQcPwH5Iq0z54esGnC9FX?=
 =?us-ascii?Q?k/JzmZInTta0psk7Z6NXxVvGu4gumOBVLxtcJeqBlOG3Xq3L3C8JKR/z6iIf?=
 =?us-ascii?Q?ibBnoyQzIdPnHZV670dRZF0HuVOXYIGMiiEXjEUR2IZty9GZcm+c2p3gXock?=
 =?us-ascii?Q?t2KxNVwvchVzXaM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(7416014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mLJBtJ+cLTgcDb0vBr240xhqWP5z5rDzd2lGqkMAfjcI/APZA8kspDiqSL+m?=
 =?us-ascii?Q?fu/j2Lsn7hmWzhfLyJaAJhlZTaZG9A75GPMYSVhIsazTjQPC43J8aOQtOdsZ?=
 =?us-ascii?Q?km1Tmb/xbqBFl5TqkTKQ22xt8uLIp+8hsKdH33uVbqYFTBw8WMjc16O5gMMa?=
 =?us-ascii?Q?WH4LaaA8LlCAvTVzuD52WxcSAaG5HE7ik9qGd22bK+6f11GFB6xlObhRCcxd?=
 =?us-ascii?Q?V9ZkoBUtJXdKL+ZFmyTsvykx/R1E2K0etVsEHEznuv8Mgf/xk78HEpB814y2?=
 =?us-ascii?Q?Bn/ihgIRzY72HF/tOjQ0hZZBJ4WHiSGxw8xeIbQ1/EaFHltQYjN92FXbwOXd?=
 =?us-ascii?Q?Qt48j8M1AsOfKwiR1r5Zn8WvN73z2QrsvsvBT7lBEVoJncgMSboSVrPGcHd/?=
 =?us-ascii?Q?CGm7CQR4uJASA4bJqixMoRNNMfA7eTQPsiZJzy6bdguJakx2R8pAmBUwfD2w?=
 =?us-ascii?Q?8Xl0+NKaHJi3CneDYqTZqRduS0WkKjrn1cPzlIp0cXmQePOFR4QrrM5szciK?=
 =?us-ascii?Q?sUhaYus1yK+ThyweSzf9qLPWwLHsdxoJsGJaiBsToQMMD6vZ0zApc6ajYpfq?=
 =?us-ascii?Q?EtKhlrbZbepGqCmlZ7PqU2VMxFAwJ7squlCcMm28QVvUOqOu65ADnxZJqWAj?=
 =?us-ascii?Q?9Tu7bBfPR0MFlYqfNx30xXLDPLq4l1aAV1zS5HdIOpR0Rc8Zcs6ir8+xsI0A?=
 =?us-ascii?Q?zUBYdG5w6YmPbaMeym7Q+MAjxb1TZZVMXs1qL7mfBuqr43o52L2SlRSUfHod?=
 =?us-ascii?Q?A7KaTJSJpaW94PFTPGe/xI8paGS34YfcNg2ZiozI9O8fWoTnjtcjiSdgyHd3?=
 =?us-ascii?Q?1ESgzvPnyFY3XJtypiZK8dt/+F50tlfrlY8E5e5ztkfjBiA5Wod/K17sopP/?=
 =?us-ascii?Q?KDkEuWdKqrp4adsRzEICn5N6VOQPx7Y1cUdmZS5E8qPU7ObkqxwwFTEDZFa/?=
 =?us-ascii?Q?zXxDoFCCzSWvplK1v9aF74vlOBC9fOp7BI8POtMym9bt5qN7gTudE/pd4025?=
 =?us-ascii?Q?pSFPwbAvSj65gpC1CR9VNNw7YT3zdM0UVJF0uIVYNUw+98PIcNDJoF5dYsUn?=
 =?us-ascii?Q?7mzcAd1JRBmsKBFrZ+LTDIaQQLMA6/eAWrzBjSFEpfR0W6HDjyhuU6jTxIOX?=
 =?us-ascii?Q?CsjMakxPPasq8Fcikwcik06rQX/DHGupcVjK7bjhaHNdkf7GjVbMxNXotsiT?=
 =?us-ascii?Q?761Xxi6sqd6yxjW4n2JAzH2FyMTBeW2ssYrkmuqmBCS9xZDeaTiBSScfm460?=
 =?us-ascii?Q?RcVrC4+DAxd5OdD5Lm7TF2fV1nDhTzyRd2UyCauSBJOq1tfH5BxsH//cbncG?=
 =?us-ascii?Q?Mp3e5ULTbSSbGlhjvKdDpky5ddxgHUAZTUyz7NT4R4PfIiKDYcUbWN5B7eC1?=
 =?us-ascii?Q?1XJTHV9ptFck19WhtcvXc58oIzFvFcJuUD9vnT/W/Sjjejh/Bsn0SZwGXhXP?=
 =?us-ascii?Q?ditYFAzbEuklh1nB4fSiQfQYmGtgusP5t8ULFI3OzbG0B77jH+mu8SLMitSE?=
 =?us-ascii?Q?xST57VITmc2vEwEmdS99dRq1fgVzeCCC3M1gCPYAoi37jVCyk+Kr4ek7Y7fy?=
 =?us-ascii?Q?gVwg9iCwYQjmrbssk62T5YyPjzyqBFNnwuId1gbwkA9WxUlLcoPAaRcT18bU?=
 =?us-ascii?Q?Gg=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 70eaf739-fa1e-4359-2297-08dddac340db
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 23:43:49.9975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w7uHG5DET0zwzK4n9ScFAypy9Sj30qm5HQyEM3oPOluMLDyuMftvrx9iqyC3d9Ah8x+AqnEcRMvxd+pwiR/Dw4rUY7zD/pTE+L0zuugz41o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7557
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

From: Miquel Raynal <miquel.raynal@bootlin.com>

There is already a manufacturer hook, which is manufacturer specific but
not chip specific. We no longer have access to the actual NAND identity
at this stage so let's add a per-chip configuration hook to align the
chip configuration (if any) with the core's setting.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

This is a port of linux commit
da55809ebb45 ("mtd: spinand: Add a ->configure_chip() hook")

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 16 ++++++++++++++--
 include/linux/mtd/spinand.h |  7 +++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 3e21a06dd0f..25e7a38a874 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1251,8 +1251,19 @@ static int spinand_id_detect(struct spinand_device *spinand)
 
 static int spinand_manufacturer_init(struct spinand_device *spinand)
 {
-	if (spinand->manufacturer->ops->init)
-		return spinand->manufacturer->ops->init(spinand);
+	int ret;
+
+	if (spinand->manufacturer->ops->init) {
+		ret = spinand->manufacturer->ops->init(spinand);
+		if (ret)
+			return ret;
+	}
+
+	if (spinand->configure_chip) {
+		ret = spinand->configure_chip(spinand);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
@@ -1363,6 +1374,7 @@ int spinand_match_and_init(struct spinand_device *spinand,
 		spinand->flags = table[i].flags;
 		spinand->id.len = 1 + table[i].devid.len;
 		spinand->select_target = table[i].select_target;
+		spinand->configure_chip = table[i].configure_chip;
 		spinand->set_cont_read = table[i].set_cont_read;
 		spinand->fact_otp = &table[i].fact_otp;
 		spinand->user_otp = &table[i].user_otp;
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index adfb5f3ffbc..94f324741e0 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -398,6 +398,7 @@ struct spinand_user_otp {
  * @op_variants.update_cache: variants of the update-cache operation
  * @select_target: function used to select a target/die. Required only for
  *		   multi-die chips
+ * @configure_chip: Align the chip configuration with the core settings
  * @set_cont_read: enable/disable continuous cached reads
  * @fact_otp: SPI NAND factory OTP info.
  * @user_otp: SPI NAND user OTP info.
@@ -421,6 +422,7 @@ struct spinand_info {
 	} op_variants;
 	int (*select_target)(struct spinand_device *spinand,
 			     unsigned int target);
+	int (*configure_chip)(struct spinand_device *spinand);
 	int (*set_cont_read)(struct spinand_device *spinand,
 			     bool enable);
 	struct spinand_fact_otp fact_otp;
@@ -453,6 +455,9 @@ struct spinand_info {
 #define SPINAND_SELECT_TARGET(__func)					\
 	.select_target = __func,
 
+#define SPINAND_CONFIGURE_CHIP(__configure_chip)			\
+	.configure_chip = __configure_chip
+
 #define SPINAND_CONT_READ(__set_cont_read)				\
 	.set_cont_read = __set_cont_read,
 
@@ -521,6 +526,7 @@ struct spinand_dirmap {
  *		passed in spi_mem_op be DMA-able, so we can't based the bufs on
  *		the stack
  * @manufacturer: SPI NAND manufacturer information
+ * @configure_chip: Align the chip configuration with the core settings
  * @cont_read_possible: Field filled by the core once the whole system
  *		configuration is known to tell whether continuous reads are
  *		suitable to use or not in general with this chip/configuration.
@@ -569,6 +575,7 @@ struct spinand_device {
 
 	u8 last_wait_status;
 
+	int (*configure_chip)(struct spinand_device *spinand);
 	bool cont_read_possible;
 	int (*set_cont_read)(struct spinand_device *spinand,
 			     bool enable);
-- 
2.50.1

