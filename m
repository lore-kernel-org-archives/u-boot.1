Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06377C9830C
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 01:46:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4752683015;
	Mon, 19 Jan 2026 02:46:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="szf3aHVl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C24EF8307F; Mon, 19 Jan 2026 02:46:42 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C48A8004F
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 02:46:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rO/qINwxlEjlgH7Y5XvXrLAkCtGgLFtNI6kF22Orb1gVGIloKEzm1hiSBHkhXtrPyp/KSMY8rL/sl/pPOWXyMbNOpgHVEFFz6qhgOkMXeNuJ9wrD3NqUjH36UyzdunJq6PiUvwj1/FE2VC7ATaxtF31gPpm3jGpbYLdjFVFhmuQYiB/qy2IhwIjOsyYR+snxRAdf5Y+YB2CAmsgRCPhhazmeeDEszpHfFuhv+n0Y0+q6oOvimROJyCyVZ7GQ1quNLKdIhBOmGpzFIqA89aNAn5EffWjb/6OLG9FWVPkrzPToax2VVjx31CVuiYUkqAOlZH8DQVBJYknHi84XDVhndQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWEBjbODkUs6hMDLlUWMBbtgiKY/Tysa9sH5aA/2Z8A=;
 b=C9wIHADNFcSr5zTmUGb7i+d71Zlb/VM05LbJzkay5m4W7pRmYeogFaBFzf+pQ4q8OBaPBvB/CMdk0MFf0fYe2WU0lChzyzfgyhTH/Ff6OwEP1dv7w4Jn6blMVxyC+NABZVMz9HWsXdxcboNMNBsZkmLHhEVauAJTP5lEk6fBv2y8z00t09sIqf/vK6+gogLUY9+3a76ot5T8eJSc2ctV7hohCoVouU2ZydnDwOz4/mFuuRJ4AxTEzSiwu48cr/ZZaZq4ocszD8M+9eNo8S248DBf7j0Q9wpcByz1/yD1r/XZ4KqbiIDiPX2hVibOJ+yOXj8DaM5j1q1K+CiAK1NzwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWEBjbODkUs6hMDLlUWMBbtgiKY/Tysa9sH5aA/2Z8A=;
 b=szf3aHVlqxFXNe3JcAbYNAagBYNLi2QyhxKGpnLg072m1LBigOnVvcbsNFY0K4CEi0WY1AsVNrTf9TPuYF/Exk0oU8fJq4rd2iYPxEfTYPMyoECWmlwImBQHPlDRvNCSRyXX/lXyR7n6WXeskGym6ThjnI2WXhGPSEqBrsrYKlC4eRmR8GLvkBLK26WRk5/nuFcPhdTzvgRSX5ZeMXubVLlX2HCBWJtKDjhvy3PA/yXetFEUHn6LVpOOhKxU/0QfG9LvckOiWDXdzZfXuqUF4IvDW7tEPuDvTEMctkRFpaMAB6GKhw+ZypbOwUs4ftDHQlafeI/sJad9mtrGVeySLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by AM0PR08MB5345.eurprd08.prod.outlook.com (2603:10a6:208:18c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 01:46:38 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%4]) with mapi id 15.20.9520.005; Mon, 19 Jan 2026
 01:46:37 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH] mtd: spinand: add Foresee F35SQB002G flash support
Date: Mon, 19 Jan 2026 04:46:27 +0300
Message-ID: <20260119014627.767778-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0016.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::8)
 To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|AM0PR08MB5345:EE_
X-MS-Office365-Filtering-Correlation-Id: eed42e81-b18d-4420-43d6-08de56fc95a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jPMylykbwbcmipIvTML18oE+s31BZ60qK+LIJg12e0yHHgYefGmDee8f9lnx?=
 =?us-ascii?Q?WxH8DIqmkDM3Pe0AtO9VO7GGfmWnagzPm0cYiUEi12eHDvdohdWOJXLdcdA9?=
 =?us-ascii?Q?tOHN9LIV3mKtjUQjOoIxSA5knVQzJ41aK+VCM6ELXlRr9fvdt8+dSobEk1EG?=
 =?us-ascii?Q?DJ+kyUGvIYkPalGS0MOvm6SfnGcgYAFoPQVJXmSLXmw/kXU8neBARLS/9ct3?=
 =?us-ascii?Q?r6YivVXumjpaF/fo2A9+S0OGRhl8HpXKa8Qg4Mt2dAsxBgxpRM/UXfSWqjGR?=
 =?us-ascii?Q?FNaZlCqxT1SMh4th/U/Tcyz2G89bNl1e5I82HOmeS+KI/WiS73rcIHxydSut?=
 =?us-ascii?Q?gLAkiXEDQUlfdY3u3UswX+S1g3le5+lXordPZRP7qXhQ4d2DCh6o68nKYmOH?=
 =?us-ascii?Q?Dd7ka+uhhZrjssjPhAP9tUkgRh826Ic6UQ9XrNTOjuF2ksXa4eZIGS+sr+wU?=
 =?us-ascii?Q?9D4XEBFviqEAZDYdk+c58eJHHN+IdKh9uIu5kD8jWAf7INbCVPxx9V5VFfHx?=
 =?us-ascii?Q?3335cr+1TYH6FHccvdB0tfNc7shb49XyxA+ICu1QHhLT4GVk5WgM1obzfRQd?=
 =?us-ascii?Q?JREbjGBGbqgIcctehcxwBrmGhJ9tl+7ABmZthA/k6yumkaJFQ9WlfFvVNxeC?=
 =?us-ascii?Q?WV+OuCsuD1aN5C76uOLPGbn6anRw5eQx7qq4EjRBkZyfhtJmeilV2ulgAfQF?=
 =?us-ascii?Q?eEZwjKR/6CdDo6VxYgPrQj0KmFndgPaDhcDowwFq562OWeUgXO/6lov+QNmB?=
 =?us-ascii?Q?zc0sn6KGwyzjUlkKf2nXfXlwiGoHn0Kg0ClMh45cVh85f4ByLEUMmA4LSPrU?=
 =?us-ascii?Q?WSkW2oBk5mLxAHBY6Sdoi3Lb0Y6/hsXIrVYU5O3czPWdzZqbAK6qsTypdjZE?=
 =?us-ascii?Q?4PdwH3Q0BTjZuJtogC9JSNZgd/jHxM2k6238+JDDJ1mnIG6foYjoIH5uUSBS?=
 =?us-ascii?Q?Z3N/kf5li7rChKZhiwNc9EmwYod0aB3bZvF7K+NG9WD1klTi2/j2JhTfEqEf?=
 =?us-ascii?Q?C43kFcTretQJ5FGoJK+jmsSU4+8vMpVWe4wdyiZUXFXcpIE8ALXgDBh0D5Jp?=
 =?us-ascii?Q?5A4pRNah2QefkCWdGKyNeJYyM3c0MsNenqgD3UHJWMdLDnv0adU4sru2dMAI?=
 =?us-ascii?Q?gzrDQFW16Ys+G2j9RXdj/cb4dK4mi6tXk+Pu0hslwU8I0jXLqOJD/JR/Tsre?=
 =?us-ascii?Q?/y7z9q3irBkw2VvS/c9UxGH4BIn8uBsV56bSdI/OwvHDbbmvntbvCKBMJAIT?=
 =?us-ascii?Q?YFvxdlutv8MjgjMu8Pj7hPCPMulMwQWpHImratBYTyBLRaTK8EPxqgU8MgAl?=
 =?us-ascii?Q?MeFC2X7aTn0gYlWg+CoiwyZCsttmjHWs2zcwEVkZViwu6N9wiqm2jywHzy6q?=
 =?us-ascii?Q?BmcOcWY2cHi8OX/Yq6+DqUlljgs5Ky9XxkBrPL/sxV0ckG+lnC7vjff1mr9h?=
 =?us-ascii?Q?3/QZhmCLa0z1ph7edU9OmPSvXPavuwrcW9lp08MYlCNTli5MwV5K5zrIiQv3?=
 =?us-ascii?Q?rwg8mOBuHbw4rimde6KeegThYXyNq1lVjpqozv7Wg+Mwb8pMXJ6LM6Tm0/Aa?=
 =?us-ascii?Q?UkjgmyQGTkrCwLV15iaLxb0B7ouOkLl4AS9OB5E3/jEfNrguRAqmzh64m+vO?=
 =?us-ascii?Q?EYb9TnLZ1Av794wSOiXNZvg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?myDu3IVhSmaQbkCnyyZM73vjktuHpjCraKqTkSmi56C3Su6v+CxCi2iSbRDV?=
 =?us-ascii?Q?3sK8JPsNuRL7LC0zpuGqL58r/E4rORMPcv6hEAynHyhvKiK+Ud9jEouACWoX?=
 =?us-ascii?Q?KPegJPJlHM6pCyG+uT7vpt078MpkvmK4fXtFlVhbW0fSsEIdzr+0OrRSjqtZ?=
 =?us-ascii?Q?da8AEfg6asy/wGf/mfIgiastwAEV8vt7JkxbkpWWDls16qO1W7nX55440mHo?=
 =?us-ascii?Q?t/Ke1fAiYbavyqoJylWbQG3bnqWKLnONNEWM1j77YW5xONUb3/JGGZ3t7eMv?=
 =?us-ascii?Q?0vDszj7vnFdXzWpffe8rO6NImdhib6tzYfi4bnaIesOWIFIviCW0bMxUActA?=
 =?us-ascii?Q?MWuDX/aKX1qmRLZ1J1KlGOSXXD8oO90TGRS4+vj8UqUkkYHemwn6mgQIquTj?=
 =?us-ascii?Q?vGH/VqI/LGTOwBU4CGp9OD5wt617KLq9DZiQgtQvCWCp4GlAB3FoFmxRk7Hm?=
 =?us-ascii?Q?PU7TWlBmzxhKuKWl6Ikkfol60j/WlV1ICbG2yL/+Cc7iRE6xhks3zOr7CTkO?=
 =?us-ascii?Q?fpOB0Z8biYN2hdaMQH6rP6tBMSQMGocdHzNbDzNYGBOn4ypg4NL4xJAhKi1X?=
 =?us-ascii?Q?0jjergMPGdH1ZAzeslxccyt2aMWfm6dp4Od2QuOeiK38XbsL+31aoI8aZ7Dz?=
 =?us-ascii?Q?ixl8PTpj0tPbjIhp6yj8BJaW5ZOxQerxSDo37ZRs/+lSIckhDPGuZbdyIipu?=
 =?us-ascii?Q?OlkDHMdm42d1AK2moE9lG8U6IUFgE9pVEpNcPfsHAq9CityTTA40b0MSqQ21?=
 =?us-ascii?Q?8MG2TX3irV7JpNtFc0kcihSz5/m68+PMoK8DcLNYNgnsyZPXicQtq1wuPb9i?=
 =?us-ascii?Q?emfHjnogDmu16kVHbdQWlcC/JgflGW/ZmJPVVt2RqIaJBTzfZ+9SKrdL9WEA?=
 =?us-ascii?Q?IHUhdje2Z2Dv10rpvRnWadgBWHfAs1uHqD76w2bwDjrOqrzq+ftUGRd4xYAi?=
 =?us-ascii?Q?Ex/xOUHMBL2O2uEaeKiBIQD2MThHNJhhC4UtJT0/QEkNbWkdkaAIhgCV/lgB?=
 =?us-ascii?Q?0q2zLytW95NPlD9nNgAyFixcanghdwEZir5ecILbAnR2tSFgLkL8nwqUsez+?=
 =?us-ascii?Q?fjK56AX108CQxoyVL8hKA4aTbq01oI5+t829lbQHDy7rIocRC+mHG18akMtk?=
 =?us-ascii?Q?pX+V+whDW+FgHHKfeWOQ37d1tk6f/8YyG3BV8urffXzkLgLaVFGjQF29+OWz?=
 =?us-ascii?Q?ddDK2NFCz+ukRQxxpJIGJ3pYdz5082rPcRxFs4VR7x7HPRZ/BxAH1VdIgZke?=
 =?us-ascii?Q?H+NWvlJU10u838v/siC8g/kU+awC2UhgQXehojQUMwwYwDcN/W1fhb1WJkx1?=
 =?us-ascii?Q?gXEOpvpKfgIGIgry0Al+o8XoEV+DDzc8xw+oSUdTfU7Ds/xPI2HNgCnq8hrz?=
 =?us-ascii?Q?idKH+fL/mfNyoQsOp+Kc2N7dM3VBnbBjxmqzmU2aBrHFWED7S6+cK0NcdVf0?=
 =?us-ascii?Q?WstSSRyDSrvUM2+s6OKaCNGmJ/NnBElLb6rAtV+gCNsQ8mWRnwWllE2Q1NVr?=
 =?us-ascii?Q?3uFRdF11spM75yhi//4SSPXYypXxhF7+Fhz1f1y/18Hcl5F/G6PLzgBYwJX5?=
 =?us-ascii?Q?/OFHy9mCkN+XsXLlSlQCx/CrsC6ClKdP8lGlJGiN/oMU8tsmGvtD3VxDSIwJ?=
 =?us-ascii?Q?JJVqGrjjafG6rlfuNdDpdCmKEx+yzCbt3lhApJ+wYBNfwARnJgju59R9FYFi?=
 =?us-ascii?Q?uktsF0xt03oBgglh9zLaLF/7+1MxU1igpMu6DFa5WYqgFlz00kGzk3meVjJK?=
 =?us-ascii?Q?9G2RliYIUQ2RYO5jQS2RR2ZnqJV3F5Q=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: eed42e81-b18d-4420-43d6-08de56fc95a2
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 01:46:37.7850 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J5dIDxmgNbTszhaR5LfFW+6Lx8EeMncfNq4nJEnTRjBYsQrC8sUeT/YmLrQ43j+Bj6I+yatLbDA4HcN7sIhXfh4V3wU/aubw42UN1BNwQ3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5345
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

Add support of Foresee F35SQB002G spinand flash

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/foresee.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/mtd/nand/spi/foresee.c b/drivers/mtd/nand/spi/foresee.c
index 370f8494fb5..986f77426e5 100644
--- a/drivers/mtd/nand/spi/foresee.c
+++ b/drivers/mtd/nand/spi/foresee.c
@@ -13,6 +13,11 @@
 
 #define SPINAND_MFR_FORESEE		0xCD
 
+#define F35SQB002G_STATUS_ECC_MASK		(7 << 4)
+#define F35SQB002G_STATUS_ECC_NO_BITFLIPS	(0 << 4)
+#define F35SQB002G_STATUS_ECC_1_3_BITFLIPS	(1 << 4)
+#define F35SQB002G_STATUS_ECC_UNCOR_ERROR	(7 << 4)
+
 static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0, 0),
@@ -72,6 +77,25 @@ static int f35sqa002g_ecc_get_status(struct spinand_device *spinand, u8 status)
 	return -EBADMSG;
 }
 
+static int f35sqb002g_ecc_get_status(struct spinand_device *spinand, u8 status)
+{
+	switch (status & F35SQB002G_STATUS_ECC_MASK) {
+	case F35SQB002G_STATUS_ECC_NO_BITFLIPS:
+		return 0;
+
+	case F35SQB002G_STATUS_ECC_1_3_BITFLIPS:
+		return 3;
+
+	case F35SQB002G_STATUS_ECC_UNCOR_ERROR:
+		return -EBADMSG;
+
+	default: /* (2 << 4) through (6 << 4) are 4-8 corrected errors */
+		return ((status & F35SQB002G_STATUS_ECC_MASK) >> 4) + 2;
+	}
+
+	return -EINVAL;
+}
+
 static const struct spinand_info foresee_spinand_table[] = {
 	SPINAND_INFO("F35SQA002G",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x72, 0x72),
@@ -93,6 +117,16 @@ static const struct spinand_info foresee_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&f35sqa002g_ooblayout,
 				     f35sqa002g_ecc_get_status)),
+	SPINAND_INFO("F35SQB002G",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x52, 0x52),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&f35sqa002g_ooblayout,
+				     f35sqb002g_ecc_get_status)),
 };
 
 static const struct spinand_manufacturer_ops foresee_spinand_manuf_ops = {
-- 
2.51.0

