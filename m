Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3592FC87FDA
	for <u-boot@archiver.kernel.org>; Sat,  9 Aug 2025 01:07:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5C3A847D2;
	Sat,  9 Aug 2025 03:06:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="KCqaZoxR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 780C9847F6; Sat,  9 Aug 2025 03:06:09 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40728847EC
 for <u-boot@lists.denx.de>; Sat,  9 Aug 2025 03:06:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nidl7V8GuuKbB+ESIys0JEueaaRMYD+Igc2RqjZcwBpdO9Wfx8IFc0PRdF3LIv3UIO3k8OKqaambtawUJG3Ua5xZiAeZxlNVSYI2eTXYHbn0aNkcT5kCNOyylA7KzDyZ81gYohTMqM1Cdv0Tps8/sHkJAyQZsneDaRyeFGdNS1C+H8Rr38bkoBlxxNzkYhY0JTSIEDcUk/MMPAG8r1I2ZeGWP0wo4l26dmjaXBRyJrrUJrLSBvlAmyVdH74Qb3ET3zKusNHOCyy1/1vQtSrDVDAOU6ieSd0Z66frL1xd8Y0lt6H4mVODQ94/qD/0bDlx+MmPPq57nvMN8swHN51blQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7EgLbj4mjuglep3u+bFeGo9SULOAQ5+OPOPIazNEbWY=;
 b=gHMDXG7EMENnRjwWJPUGr+oGFJNbeUlgf8rBzEN5PM7zFiARm0v18Dct3MSATRbHBEVpcSaZHlNsRNWvVE1VuaTsdEN/K7hdEAkZ51sF3Lw5u/zducxjZP36CCR2VzUTHoE2cJz+y0kd9vmFl6TgLct9neS6m76jApCucyWvLbnnrodhmZ5u1itc5pbqSYMVxogAlBNNbt1hdiqGiJvSyCd8fIlTpxTdZEzMtgiK6IgOp5kft0nv6Ph2aqAKnqFwFP1ul2+uktxvxg70mJYdKxcUz515bQ1BpI9ZmZc+q71FILTy7NZGtjqT1o+ZCuhZglewL+GIl8VJED4YdTC3uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EgLbj4mjuglep3u+bFeGo9SULOAQ5+OPOPIazNEbWY=;
 b=KCqaZoxR2G922yeKWeTQbQ5jYAGZTdnJfnBG79pxGQnn5aouMjAHWtif2SAEtG8PZFuEGbccrENGzQ4NgkfuNfFh+gctdRoUmvpQAbuG/xJLV0ihAUpPdfq0rYNED7GXEFRK1oY4H+61obcfCDaqWCW/j4ygX3vKUWyBIS+sn5zzK/a3qcrDaQvhgXNIAu9be+A6dtmXCk8uxKxMtDzfgaksDlEKccyfFN9NVnpAW/TAlK4T+9Tnr2A0FuPNFj/LFNlLOtOMas8ME5asqRc2WEIdu5HtXG31ZipFndbpbKKEF12LiiYK+9vpcQfFnZVvzUx6KwQe8ImDNqskdkZNKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9582.eurprd08.prod.outlook.com (2603:10a6:10:44a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Sat, 9 Aug
 2025 01:05:22 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Sat, 9 Aug 2025
 01:05:22 +0000
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
Subject: [PATCH v4 14/24] mtd: spinand: Introduce a way to avoid raw access
Date: Sat,  9 Aug 2025 04:04:46 +0300
Message-ID: <20250809010457.3125925-15-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB9582:EE_
X-MS-Office365-Filtering-Correlation-Id: fa47a9f6-87b9-4b07-3d45-08ddd6e0d123
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AOShqcfkmU2OJNVaLAj5IE1YFv8mXibNAd/vFBfMfpP/wBzFO8DvcQpBZWiS?=
 =?us-ascii?Q?y5gy5iv+I4cM1ozIoCJhjXOLZ04DVw9KYA3/9YLHC9cKELdLOS9Zx0UPx1wh?=
 =?us-ascii?Q?KR+jB7Qp35MPDKAni/Og2t2Hh1ZJWpPFbMAX8iRvv/xwpomQ67T6GeUwzh/C?=
 =?us-ascii?Q?/tWk27G1ISpWBD8TTyux5WoXroJNwtCtn6Ls8bBJcMku2siFabTmJjg1l9vb?=
 =?us-ascii?Q?cse3onGnsJxYTpV7i5UVvzAFuO8bxUlc3wZzcf5ZOFU7fqKNCrwGrwvdC0Hn?=
 =?us-ascii?Q?zxyqJl5oShWT0pPj8DbW2Xn1YgKphwDRon+qbEo/HqCvIauaE8Q3itWIg0EU?=
 =?us-ascii?Q?dth4eiIT4h50SEK6FPZC5/jcMjwy+2yvkihyJPDG3sZwjShPN16RzGH+cxXP?=
 =?us-ascii?Q?uhduwlZhqB+rZGwSwbj6bfbCLHIKq7IzSUG7qE5Spu10iPcs0BOf3i524RrG?=
 =?us-ascii?Q?axWneRAmUe1eKOHc+7glh+B5TADLdDJ5SKDvHKaYGBdLjk9qdLQyJgEftz9F?=
 =?us-ascii?Q?Qx33uJyuBnw3njN+XjZ7GpravyN9MNRkQeCrTmXbh3FVuAzp1uQ5yCUJXaox?=
 =?us-ascii?Q?SiEdgEjatbv4kSO9KnIvbzoGV4nyzd5KphM2SWUj+9Q9+4LarVZRTSJmV8rY?=
 =?us-ascii?Q?sttTVIXz2GYnoKUSjGDYhSXKf23onANzT5A/ZM13VJGd48a7ms7omW64oU95?=
 =?us-ascii?Q?Ittf43JFO4QFH9ayWVHeIRg+zFA561k5pJdJdzoNY1SDJ31oJENF6RDKtMMW?=
 =?us-ascii?Q?RVm3sfHB98dI7tWO8VOHCvwYf8BeE2saaWy5udbaIqD3DsKM2M+PrOwM5eib?=
 =?us-ascii?Q?8ImITpq3haUObFmUamJnngwohuEXpsBsr63E4Yu3QDJDqy/8S63QpNPwpYcy?=
 =?us-ascii?Q?VfVVNjSO259y6c0YuoeuIbKo4dtESqDNDfpeKplipXlVTf3+XkfMvpNq7feR?=
 =?us-ascii?Q?GQidDtC050jjuJwY8q+2+xJh5DOWolFMMbTN/f9LdSB9xlrBSNmldfpnLi/U?=
 =?us-ascii?Q?ToKdmDdeWFQhbAaijS4Ry77tRVs1JDET0KRTT/TV78Aw3jkumgzq94tMBqn0?=
 =?us-ascii?Q?bvCF33B1jdUfabYiEqXWqlh5K/H+BJ2IimOhQBP+UijDfUKGgp/FxFoYLNfn?=
 =?us-ascii?Q?c2NF7Zp6UA/5rHNzVDiP7clpC9egKuitR8Bw8sZ95uIFlJSEc1tRQLlIzSIj?=
 =?us-ascii?Q?rNuqq7Vdk3sB0sGJNUlN3hcGfFpz7dQ43P8H3OL6SIROA1OhJ0uNoJUTbHQ4?=
 =?us-ascii?Q?ifjd27W6bbrT6toVnXiBSpdTP5a1L/f4Koma2MKYhEjp1yb7gh1K7kgAiMhm?=
 =?us-ascii?Q?2ORv0s/yE5NfxUWlXX27ZxqVwAwAKoA0zhuVXj8LGRy81m81MR4znwHoa/mq?=
 =?us-ascii?Q?drEP/qM6zOFmr625m3pNUbihNYRxAc6tCxjHw1ELgfXsVE43cFcGP/6BbSvG?=
 =?us-ascii?Q?0jOmhPryAyVi6pasx67G0ZOFuPNeIbQk2OIAoJik5OezyL/nRCRx/y3/XDmp?=
 =?us-ascii?Q?9hhtBwRCCxVIb2g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eqh76Av8wl9yWbG8MjSe3PcEU7OJquAlngxhKsFswglPap9cujAbxM6OT48k?=
 =?us-ascii?Q?MeZ0Pj5v/jTQRlGp9g7INeFZKdKycYEwM7/TIbt3K2+45sTOdy15qr8gd0MQ?=
 =?us-ascii?Q?BAi525kuyKoBW8yT5TJjbYufBpTD6Vw3Wl+oN1UHrlevf4NGMNq1PmtWWRDG?=
 =?us-ascii?Q?PEUjt1A/t0G2ntMCWNZCKWL4h5NceSPxVw1IjfIDEMO3vEwAtUxtzAhtoS47?=
 =?us-ascii?Q?/gGd4HzQnErKqLOlfMxIHXPoEhlrm6ZWvU5UsjTtZFszdGMdEgFKvDsJ6eYX?=
 =?us-ascii?Q?3iG2/dQSWSxdmiYm+NuYmWg0b7UVaH6hbhUpneZ0nmPdjhZbolMG5ug3f2GO?=
 =?us-ascii?Q?aHewV4xC0rc7ihBQ6QcrzaqCyKT2diY/R/FVHdwyKehmRN+oJLAKH+ZHgcyx?=
 =?us-ascii?Q?jFL+1muHY9B9SKvRbuwpZgePPJpUvRcIU5YPAuGUOXGXpTmUmKvv8qNgwISo?=
 =?us-ascii?Q?VLHvmhiIghgyKqqx/F7qjHXK8Un3bitfvdf4RN0WyTRrLtgxDgmYq+NzNqWL?=
 =?us-ascii?Q?Y3yv3pHfrL/9LY8ExFvQQriA/E+n/5NCVO5wZk29pZxOjjLXuGksMoOPkfvg?=
 =?us-ascii?Q?mJLyspiuJ5wsQvE6tPR1RN8aYItp1oujnKXWmKqnz/0F3ZyUQFHSxcOoZ8DW?=
 =?us-ascii?Q?SaFx6rxWwc8yDwMfn0kbRr5YiRGgBV77/p284qnhk9kXTMn93LOf/HsB+hiC?=
 =?us-ascii?Q?IGtIUqWozjqgaSFQMDNr5ZQdizIdlh/7YaSS+JxhEIxb5Tk92e/Hx4qDs2At?=
 =?us-ascii?Q?ig2EmxhBVJBfWM5qoSi6xB6iwAtAiHShN6vRfvqP3KuWIHS9UmKPPSxWW+r9?=
 =?us-ascii?Q?pjRSUXPNhAgiVXDKM8ngNcyIQwP46/0dVNqFVn1yfwF/UGkFU9xhozdz5vUn?=
 =?us-ascii?Q?0nv+MtJk71A3Uek0QT60APauvUG3+L6gJkV9oIMmnZx7YGizMDPFA1ErabIp?=
 =?us-ascii?Q?3LtfsA4vWNRkTW+sfVukjPhfq3eBYz1KY7OfwC9nrPvBj/uxnD24MKXM4Tut?=
 =?us-ascii?Q?Rb1XlevC7JTcEKerb8Tfi4ro+toBpHXI10adqzLX5DcegHWoxsCwj03vq4i0?=
 =?us-ascii?Q?sihr2UuMEUftQshzkSg57ZdJDGlIL7c5QMgE8uFX4c04q30vXq4d8EUzGlgn?=
 =?us-ascii?Q?0Eztd+OkVmavDaudhbFp6h0yE/2F/eNmRzjBe69nP3n09abeVGcAwv+E3cXc?=
 =?us-ascii?Q?q3qDJzhZyUzbTnR/7gbh6W1bY86APfr/z3sRlegxCYeo7xddhWTG0T+gXcWq?=
 =?us-ascii?Q?blL56qY8V9eeHt3XIJTSrR2AkPIqncd8aFnu6NLfF0tRn2oflwotNfMbkjEo?=
 =?us-ascii?Q?CaMgR6azKV8yAQP6Co2tMSHCH6Tlvc3aPflNUl7CY6iVz1jN9FISUPqQNCrn?=
 =?us-ascii?Q?KAMdqsKU5aUNe7/nY6ijbK2SsmVA9tnL9GBqV5EIFkhNZAtcsEaLNWFTitmL?=
 =?us-ascii?Q?fLXHcHcbLYBUZObAmiF1EFhz9fG3DONRPUOOfZXnlbGPU9Zv886FhUlp1kMD?=
 =?us-ascii?Q?1RzgPeeULaTO0qKcRamIeKkzHLiRrG/xzfgYgCSB874sCega2jkcWw8auxSj?=
 =?us-ascii?Q?g4wAEEYZP473sErue4UnD9eHsTF2zDF3LbP2qZSIMoNw9DehwrHcQ0cAjChq?=
 =?us-ascii?Q?kw=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: fa47a9f6-87b9-4b07-3d45-08ddd6e0d123
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 01:05:22.7690 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6whmfGKS0ajdIbfIQcoEqsFalCE+2oNBO/KN3++oV8Q4SuUKe3jWMa2Jt2Urh6ORteg+Xa0+RAliJc6IiXVRyHTIietihUhOFjFnEArwlEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9582
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

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

SkyHigh spinand device has ECC enable bit in configuration register but
it must be always enabled. If ECC is disabled, read and write ops
results in undetermined state. For such devices, a way to avoid raw
access is needed.

Introduce SPINAND_NO_RAW_ACCESS flag to advertise the device does not
support raw access. In such devices, the on-die ECC engine ops returns
error to I/O request in raw mode.

Checking and marking BBM need to be cared as special case, by adding
fallback mechanism that tries read/write OOB with ECC enabled.

This is a port of linux commit 6d9d6ab3a82af50e36e13e7bc8e2d1b970e39f79
(mtd: spinand: Introduce a way to avoid raw access)

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 22 ++++++++++++++++++++--
 include/linux/mtd/spinand.h |  1 +
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 9f150eb8585..a8fb3177f8a 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -298,6 +298,9 @@ static int spinand_ondie_ecc_prepare_io_req(struct nand_device *nand,
 	struct spinand_device *spinand = nand_to_spinand(nand);
 	bool enable = (req->mode != MTD_OPS_RAW);
 
+	if (!enable && spinand->flags & SPINAND_NO_RAW_ACCESS)
+		return -EOPNOTSUPP;
+
 	memset(spinand->oobbuf, 0xff, nanddev_per_page_oobsize(nand));
 
 	/* Only enable or disable the engine */
@@ -737,9 +740,17 @@ static bool spinand_isbad(struct nand_device *nand, const struct nand_pos *pos)
 		.oobbuf.in = marker,
 		.mode = MTD_OPS_RAW,
 	};
+	int ret;
 
 	spinand_select_target(spinand, pos->target);
-	spinand_read_page(spinand, &req);
+
+	ret = spinand_read_page(spinand, &req);
+	if (ret == -EOPNOTSUPP) {
+		/* Retry with ECC in case raw access is not supported */
+		req.mode = MTD_OPS_PLACE_OOB;
+		spinand_read_page(spinand, &req);
+	}
+
 	if (marker[0] != 0xff || marker[1] != 0xff)
 		return true;
 
@@ -783,7 +794,14 @@ static int spinand_markbad(struct nand_device *nand, const struct nand_pos *pos)
 	if (ret)
 		return ret;
 
-	return spinand_write_page(spinand, &req);
+	ret = spinand_write_page(spinand, &req);
+	if (ret == -EOPNOTSUPP) {
+		/* Retry with ECC in case raw access is not supported */
+		req.mode = MTD_OPS_PLACE_OOB;
+		ret = spinand_write_page(spinand, &req);
+	}
+
+	return ret;
 }
 
 static int spinand_mtd_block_markbad(struct mtd_info *mtd, loff_t offs)
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index fb3a2e5d909..63626c9c27c 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -320,6 +320,7 @@ struct spinand_ecc_info {
 #define SPINAND_HAS_CR_FEAT_BIT			BIT(1)
 #define SPINAND_HAS_PROG_PLANE_SELECT_BIT	BIT(2)
 #define SPINAND_HAS_READ_PLANE_SELECT_BIT	BIT(3)
+#define SPINAND_NO_RAW_ACCESS			BIT(4)
 
 /**
  * struct spinand_info - Structure used to describe SPI NAND chips
-- 
2.47.2

