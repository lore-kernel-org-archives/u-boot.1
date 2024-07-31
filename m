Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9FE0C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 10:20:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FBA988A01;
	Wed, 31 Jul 2024 12:20:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Crcvy0QZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FC318811C; Wed, 31 Jul 2024 12:20:22 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20713.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::713])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AFA5889D2
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 12:20:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Egzg35ZU7ceOvSZzU3Uf5ln4xk+yipSdAzZkNvzpB4VCaeCpa+XDsGflVOyrTiFN5xdHvVYc33mbn7OSmJoVf0ERa1YgI4ov5DzhwjZk+mCkgAKKER0HQhvT5iUPnd3yebfkX8rWH/H+pA/F/MRcgvyfwiPbcp6mL7H/A1vjt6p7lKCYaXZSQNTwbIyZkSpOB5DttbY8bFPHZXE2t72xfHJz6Rr7o8eNqf4oL2Q7KT6M+w/P8YO1yK2AoMEitF1bExK+1Qd+Hp+EsjfQHq9W0+PoHttG27GNVQXt6lNl28DanTG61lnFq/5pzdkfkWfImgH4XjwvlZw8Zi2jygZJfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdk5U8Ycr1FVQ8B5gUEI2BchXKFzkqhtc7UrkCMDtbw=;
 b=URV/iRYMepWbKu1OKC/NAarWDVkYS0F3zt4uM0qPkCjWgOH1z5K3obAhHe+saU3NhkZk9UIyLU7fnfMy1xdsjGD6kAHQN74IqCfnSw0zGiwUulf82sexN4nzmlSDPZ5sIq0ZpMaqkd5foG8sMt04BObqQZt4DuvHXrvly2NQgWVZya0+e7VDmskCreOewVuZnn9ktdufUz71Rrw7TJdi9fi+ju03CSpHIRDITJhpDj6gAMHTlHCGzpujNeE3z1Y608xbUsjBc22TZyMM4RDtIUkC9CwVqWLNhrqrFBktuES2Cpxb/nXje295PnPpSrgXikHx1UOVI0CHVaHGolxrLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdk5U8Ycr1FVQ8B5gUEI2BchXKFzkqhtc7UrkCMDtbw=;
 b=Crcvy0QZ6T0SxSEEM4W4lA537begBkFlRF/ACFfK/lQ24TVjsgJiTGDVLwJ9x7KMbrg/kfOa4lATh/zGneBrSVDd9ngsJGz1ZlWOv2kw+D5qXV/q/14U9I+9Tp0q5vkr10msVRaevIY3Z8c64TwUcHb7XWWPJ42+N7RlolGvMaN6FyHUtIZ1jGmzi+klzFPyoRXbdCWuP3fZn+H9LgiUyDeTUd0csBvTMaCpmyC12YY5utRcrPkFj8HBSLR6gkCwEbJubKrcEdUtB3gfwvjZm2jDLvXzopTcvybfyf1CZHfPwHFuQUpJOURaKDIizr8w4fEH6a2s9YphArSLrSgxMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI1PR08MB10076.eurprd08.prod.outlook.com (2603:10a6:800:1bd::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Wed, 31 Jul
 2024 10:20:18 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 10:20:18 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 William Zhang <william.zhang@broadcom.com>, Simon Glass <sjg@chromium.org>,
 Bruce Suen <bruce_suen@163.com>, Igor Prusov <ivprusov@salutedevices.com>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 03/10] mtd: spinand: add missed add missed
 MODULE_DEVICE_TABLE()
Date: Wed, 31 Jul 2024 14:19:54 +0400
Message-Id: <20240731102001.4030460-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240731102001.4030460-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240731102001.4030460-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0139.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::31) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI1PR08MB10076:EE_
X-MS-Office365-Filtering-Correlation-Id: ebdf567e-24c1-4632-2dfc-08dcb14a6057
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|52116014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tGRNTq+DhAtsqmkKfmsTxV+wuPMdCSbB6OrhWDO02QVAff7EFs0pjJ0XUXmM?=
 =?us-ascii?Q?FwX1wLxpWZwVWCwOoExp29KKD2glJ04G8MUo1Rt1ReaI29zste72tlrmODut?=
 =?us-ascii?Q?p0lPtZ+0B2kXm0/KOrF87MJF1HNNK6hCCgyBsqcAOQJC47skw24ASc2X3qEp?=
 =?us-ascii?Q?KdxH2P/rHZ5XfxO1yW4id4L+/WNeWc3JRu1Sv3Lq/KR5LRAoVGPtwyRiRCqA?=
 =?us-ascii?Q?swPPQy8g/fFBClgArRfhpGbnJC66PWbqFVga6IUWXlCCkl1Bho167wzKLFjJ?=
 =?us-ascii?Q?yTH8xUaennF8tfJ+rYCZEnasnVwLiFDBcgQYZVsgtjmWtFmyFsiMaUnCJywe?=
 =?us-ascii?Q?9XQrkHNsQD4QMuiytpgOZLsRIdc9OAzC+7tRv9D5cr7Otn2HEfS1+x2WP8/O?=
 =?us-ascii?Q?12Lj46FJkIsQamfj+P5JLcL6/4wpx32CNoXYkXDm4yFjmkLwPlGaPf/EH8RU?=
 =?us-ascii?Q?BmGdCB4wFzulJAn52xODM+f6ZVgOSvkKTnuow/g536CzWA1iKHqLBFMxkniH?=
 =?us-ascii?Q?fp3TKOvW4dGyz9jx9+XJIs9Y97N7A595azv0AssMWEy/9ONb7f9yShBUT39g?=
 =?us-ascii?Q?8LuWMkbRKvBw5VcdxWNWq5PKtHcVjfGR07kOKDHv7QKWkUYjB8ab/rTgclOy?=
 =?us-ascii?Q?ClFtPS6uNACq6XfKM+0OGgODvkym6OdQvzfN1LjP3y7ChK9kQyZ5dyYHr8/w?=
 =?us-ascii?Q?/4jYTggJoOeCzMYNKhgNF7+5tAg7inEdBgBWLOlzvWeYQPELwooMt8TF0TjT?=
 =?us-ascii?Q?iDxQgefvN4+N2qK5hz45XwG7t+qqjzy+wOQBxfxxRwLInMz++qDVknPhkRrf?=
 =?us-ascii?Q?/tWAVOpPPYChLobWKAxsDUS1ifsKah13CX2dg9dmMKUSxeJJ2OLIXtEFE+Er?=
 =?us-ascii?Q?sMM2W2byQphfAF0rOW0ioZGj/2LLzELd1vSet3G70JO/4+EwJmwjqv2hDBep?=
 =?us-ascii?Q?qw7D+veoYdFnyGhMCZp1/ahUCv/hbRtz3pnhQpD8CS7yTuDRkyVHEM1QStfK?=
 =?us-ascii?Q?6fQPQF3X1ooERaE3+VdOcL9I97YKnJMyjO9gPybNux6itYkGlqeBqKDdkVp3?=
 =?us-ascii?Q?cyW7UW0ZknmfDk3Lt6Hcftpql5VDAihNeRSw6v5Y9AI9WN5vkj19GXX+8rF8?=
 =?us-ascii?Q?ehf72tMNOroAFtaUOJDsSM+g2rnyZHa2sjeUnCK54eLoXAYSz0H6AShn3954?=
 =?us-ascii?Q?k4sLU8meFmCNmD4OINVL9D65+eH3DNGGBKKNkpw+XX8JPdHTUiI5SkLgh3OH?=
 =?us-ascii?Q?BdFjGetbbRPDDw4rg9ebUpRPk/ymvTrY+1uw8OLONsiGnC/6rfOerYgnCS65?=
 =?us-ascii?Q?6VkZYT+S/fKGQGYtqfmUnCNlpiYNoDrM0uDGOLwqjposIbjeiATk0wBky2V/?=
 =?us-ascii?Q?Gfu7PSL83/E0C/OsL9FVH1obxaL1yB1D7JNrH98lhdykZKMn9o7wCVUXa3mb?=
 =?us-ascii?Q?Y50G2mpEAU4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(52116014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zztwdpuA12E6XNI/aFy7taXel4iogiC9bhHf63anQbv0QkvsKh8TjtaoEDRz?=
 =?us-ascii?Q?2gf/Qh+RKbspDsI4hf48vShiIB7boFTE2uUtz/lYhomnZRkkquLn4OFaCOOv?=
 =?us-ascii?Q?Lkc7PSkjEWS8Gu3ORyBy2rT/EwEwc9H2Er4i2U5U5nPQGBk91ri0MzrB0H/Q?=
 =?us-ascii?Q?xzQ+T/zduLNZNhqbhgZsf7YIJ+a/0RwWP03TepIqPsftZV8RhBZtUE0YtkiA?=
 =?us-ascii?Q?dTH7pORWjOkGO4Y4HLNgCPR/GhdU1TMNpDinPMzq8HiOPinmv9zcXNjGyrN7?=
 =?us-ascii?Q?XEtoS9Y1cvYHACuOH2BwSjiCa4G8Q10g9cLoQMBInRWKKw7hJ1sjpY+A8sTF?=
 =?us-ascii?Q?DTOW7Jywf6owEh28UbJL7rPOZ0PdV0VQ4XA4uP0Ix5cEebhOJ5jAwJt5lmar?=
 =?us-ascii?Q?MCNTm1RlBlDVdl4jHnAjqnOzaUv2kMXyBGuANZjA+8sLZ821swaR5wFNu0Hs?=
 =?us-ascii?Q?4DtXJCC+GMtBtm2gtFGJMxfTeBHOWXm185ocQesbwWVgZcKefwKRc8GPrQz1?=
 =?us-ascii?Q?rRo/U27dd3Cao4iZ4L00/CmYrkHl0ukXopXQLG2NCv/r7B+c/GBEH59ONIEX?=
 =?us-ascii?Q?tcTMPuPOnABj8vluBgrwOLPT7bBvPEz41DIg5JHVLCCWQ8kmr3CkqFX1/Lg4?=
 =?us-ascii?Q?JcXTSU7Xwm5GjK5BwMa5YUCgEGiSPe7t0tL5sUcboEozJFmM9QDn8eze6QWj?=
 =?us-ascii?Q?s6sUWhOJ4oq7Lqm0Bj/78D3Usv/nt5na0VO+Y+yzqSfEeMk/xj/p7EzEE1fY?=
 =?us-ascii?Q?k/HIP028+36EZP+xr36yIW5O3GBzGesOlErmpcXL/pxrarb2h8T35jsKSj19?=
 =?us-ascii?Q?P/wFqaelUi9Cdv7v72ONUMTTAXmbWA4sL41yR6IUOnUFkCM1RkeLo48z3icz?=
 =?us-ascii?Q?9A38xRj8Sv3lxdfcQ6fzbOtz5ZvuWniIz2mzFSx0WhdHulQLYIngqa80BtvJ?=
 =?us-ascii?Q?12QvyCwn8eEplS+YtnP71+3oNNdondqLAmQdZ8hmECe2WNLi09ePex+3sZfj?=
 =?us-ascii?Q?yVro9g2Yr9sgMPRhyjGcbZxIN8lXydpF3HDFvDJN9Rmk5jGePMboB+MG4VaN?=
 =?us-ascii?Q?WvTW2p43VZ7iL0/KmFnYv192w6I9amYaN4xAu2jGSML7IPDb7LZiPmtD9X56?=
 =?us-ascii?Q?mYYZvGVBOPDk782FXL8e+i5KZi6kyJ6/Df02IqixSdRbREENkAep6sFNE/ph?=
 =?us-ascii?Q?Cuwq4xSuEDPLffvrSXzbtEy3OpZjPEt1pvgiHf00hx99KETMBHhwcez6sPv2?=
 =?us-ascii?Q?qI4RwLW/339f6yLp1wLgYdmobak8XPuWCYmQfXKaEyoPaam9o8N41CjrN8za?=
 =?us-ascii?Q?0Ojt5vX2FwpC5BAJLWNNLJQGOhXAKn9UeKbd5ZiOb1jHd5HhhfySVgc5Tzko?=
 =?us-ascii?Q?uHRXxyvUHyj5jkvyFjtYL92b2vZSj72iQ0Wvz9nULGV+5YUhMVL6oK/Flpuf?=
 =?us-ascii?Q?iVPA+n6M4OK4lRlH+0SarZ/RGDBLULeNZfaKy4dLgqecQJgCTQtvnsIvdPHB?=
 =?us-ascii?Q?kJ/Fs+4TlWykADEeU4VgPGo+aBdTwrem2ZzJo4tpnIrkHAzChDnP45rDkzWB?=
 =?us-ascii?Q?zQGcs5/R4MZdJH7Wwm2pjvQGLaxr6Erb+OreFIzICfxajiYEOk7GX1eI1M0H?=
 =?us-ascii?Q?rYBZj3qaiS6qs4kNgUMrZF4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ebdf567e-24c1-4632-2dfc-08dcb14a6057
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 10:20:18.4385 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mcX2thN0ExcCyqHhoANCYvZR5rkM6JTBFS5Pt+iyjOgR1DGJLLISCVPQVGv8uLVwrsICvJZ5Y0DO84iVctBgQoGV17UNdfTwIfb7g9vbsDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10076
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
 drivers/mtd/nand/spi/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index ca07c70e217..4741d3e087c 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1240,12 +1240,14 @@ static const struct spi_device_id spinand_ids[] = {
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
2.39.2

