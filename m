Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 689DFC83F34
	for <u-boot@archiver.kernel.org>; Sat, 19 Jul 2025 00:58:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B439183721;
	Sat, 19 Jul 2025 02:57:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="VFZ2EikK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 488EA836F0; Sat, 19 Jul 2025 02:57:45 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 302CE834B6
 for <u-boot@lists.denx.de>; Sat, 19 Jul 2025 02:57:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uwjd9rIRXGD+7plkzx6yb22qn+0TbeMGC0uYILXu0P1Ux1M2NPYgydBE2V57OiZVUHFGwHpTSSag1q7pEKuH7OfisnXy3v0HfWHFR2v4lUHeHquYlHGOJsRjduij2d6L2mODyNC7ZSHt5niI9oHxkFdFb4CTEFsPkLmrMGMMjqFLSWD9EOYnfz4nJvB0sNHfo/Or7dAqlpbh9ef4AnT+eGpXzAdIX0Z9Q2LQORhQ/l4u4zrjw0hPi/8kmTTzAz10acB6pJyVaov+LIyz7gYGDnkXHc/eO+tclGF7+jHH4OIeFudAMoDRJ4n2im9DOCGHqH0PAYgBYBWtLG0+xnzR8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eLaKLG6pyX05jsjSamom28EacAtaqlXd6ruUShUwks=;
 b=buWNi6OurW4EEtOU8JXCG26chK6N1+6CuNbW7p3LyhG6Glvh46x7ai15HAUT9vY0LW7v9XYMpkeEny5Dg4OtodhTrM/NrJSlm9/fiOr6LdvfyQIJUVNWQw9gMBe1uQfhB8LyUbUOakXjzfKH7pEbx3JM+gIAP673dOHDMNwHYyujBMmUzBi7VVk0u0zEiWT7NnMeJ8RskvgF8wGm/L4/Ssjkt6p+fuqZqQ2fWR3LodG3ayU48IWEPr7n3qsD+x4tIaNn1exApIkcwjzcUMa2NtqZ7yTiRo6RUSwGwGV/GzdXupAsJkb1COHDoFF1Bw6GohCW2L+2Rhi6lp9Rq1qZHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eLaKLG6pyX05jsjSamom28EacAtaqlXd6ruUShUwks=;
 b=VFZ2EikK0rqVqwZgJl6p88ILruRcbpWV1Ac5T6ynbrTpPLzlSUugfbrQih6w9tn/7TuqAaLbR0ALF6OG+nvWBv9nGxoIso/uRnbKi0+7bETWH8ayvlwl9q2/KrTIsdGOx6/iGQ8P/sWFeQ1df1+4D0hZZr2pWcF1Sz7XY0N0bWiTDBF/fkd3HAzA1wp2OGOSHyCr5jEYVz3lTtdmfRVBujS6AcJCuaUvrBuAq4JHkBM7iZmvlPNrOiCnMKG/+0j/TvywfD9d8MHMFON8c0BSMEvpUoQrCg5lPGJLlSiwLSNk6Ircj3MeMYWJWKkDJJ3e5NKwPQXloGqub1YlUQeRTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI1PR08MB10218.eurprd08.prod.outlook.com (2603:10a6:800:1be::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.39; Sat, 19 Jul
 2025 00:57:41 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8922.037; Sat, 19 Jul 2025
 00:57:41 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 3/7] drivers/reset/reset-airoha: add support for airoha en7523
 SoC family
Date: Sat, 19 Jul 2025 03:57:13 +0300
Message-ID: <20250719005717.113842-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250719005717.113842-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250719005717.113842-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::19) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI1PR08MB10218:EE_
X-MS-Office365-Filtering-Correlation-Id: d97dbf5b-4980-4e9a-ac4d-08ddc65f4365
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HjR6UKmfYiTF0KORphn192lP/nKOdO7c6ixsIcfwMIgC/hp7XXF/yUZ4jBAa?=
 =?us-ascii?Q?YiY1jIWKUwAmxdiX/IYpZvgK++nCHl8gQKdOy0Wj0poY9rdpMJfe0OhLEag/?=
 =?us-ascii?Q?41GkPXTEYTfmeRAlXTBqSW/i896Y5suBzrXwxe7yvVL/3KjyBcSI6+Yjordu?=
 =?us-ascii?Q?fmmHHg/PMBUBWyC9v12J31ODyx+C9EgUuijWjbCxTmGDCsyfXrzEfFyGEfqd?=
 =?us-ascii?Q?ZweLRkzmNncY3vAydgr/p0bJ+sCnoPkq+tbGXaVFviZFipcNdo/DgiRaLQAA?=
 =?us-ascii?Q?ZBNKQPXUnYKzJLWiPBZR9pSVhueQd867nzZ92zTZWTvigyt82v/AB5Bee7DN?=
 =?us-ascii?Q?84YTRThqjTqzv3f/fXr4BTi1Mtw3i+o6CTAmUzDsGmfCHxwm6vQGlhdZRlNv?=
 =?us-ascii?Q?z8GDnya2vknfn64y7e2uWaI3xRAFLlOxxuD5/OjnX3Ck4JdG7NDRpfs8ArgM?=
 =?us-ascii?Q?xYXwuxy3cHcxUMp7h8xWDlRM/Aap41mCNSzXGP86+BY6nihuHpvS9EPI9ybm?=
 =?us-ascii?Q?rasVJnU0r405Sq8le/yPftJKjM+D18C7URmbY+RKdZsaMregi75REUpqgSri?=
 =?us-ascii?Q?IV0kijNpLaegPcHKCy8piYOSyduCJclKu0tnCYG3fBcDvKi0z0QwwDwArAD0?=
 =?us-ascii?Q?QcNCfuyimYu49Xk/QcXyzKwbUhbyJlHfP//jJxSkfLOycNLDNRrcVE8v7Qvm?=
 =?us-ascii?Q?2zCW5KUu/KnnWrvK4xmVxUci6myr9oGFdwSIhcwJcqXthcarjJBD5Q2ficwX?=
 =?us-ascii?Q?ikGrVjXzrJUY79mZoKVp4zzLvDz+hHVjQutOLuO8kLeVi6NqOnrx2iRV1qjr?=
 =?us-ascii?Q?SI3iQW4ziDjQw4vVVF6FU5FFW25YXG3jjHRhLn0DL24k9uihALe8qdSsit6i?=
 =?us-ascii?Q?FLrJHNPhDPp0UfUN9WM9Jvao166PcaG9trLa19IMuYrSOnKVffFg66/QwmZ7?=
 =?us-ascii?Q?zNLnt9JpQPeLEHIBdRyCSscTNxK9xhTGOepIVF/z/Me+OWYSjcLCLGs5Qkay?=
 =?us-ascii?Q?HOExlx3gw+6sR+D/nf/DjzovBNvVjwM1X3dbaj6sXBHtPZzF9dtMy4XEzjHb?=
 =?us-ascii?Q?kqbKSdZAWe5y8wF2r27v3yE2rAMbYU0E1EDolJMizvvFGSz7fSii8CLTl2Ti?=
 =?us-ascii?Q?g7PZdtc/rwfy5djmd9BTvFYWWkOE8T7wd/RWa/sqx0AibCw1qOT9q9jQtMrC?=
 =?us-ascii?Q?GoSxKrTXAaW//0Ltrv2wVLnmL2DWBRK6Ld5a4ri3WMHmaKiuGPAuJQ6SNrle?=
 =?us-ascii?Q?pvr96ZvDo60fBZybfkQVoRNZ4T0UEVZ6Bg1mEHSeyKCnwqUUvLfk8apDTcH8?=
 =?us-ascii?Q?+63sH6eqfW3ZlSDJdNMokQOxCXTVO2BhtMOF5SBzJLbzR1gz7PPiy4BwDQ0r?=
 =?us-ascii?Q?FKvwYwDc/ENb9HzPkpR+N4DtQDV/xkJVq8llGC/5IOToZV/J3/B6rtP6iUxS?=
 =?us-ascii?Q?bzO7mx6/5RbfpcEdfYRrw6OygHU9Zd49kgZVwo5acKZ1mIuIDvgTUAXgvhzK?=
 =?us-ascii?Q?+hughHuTtuGclbs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6NRtsnDSVK0YTz2AIb+diKqiAdjewWlzrGCv3KKGV9UMthS+p8pzItoIlmSg?=
 =?us-ascii?Q?nJB0TQwVz3+3bjNsNg64MraMf3qVVPNUxm3+iBvGi7n2LbApj+Dd1TBghF17?=
 =?us-ascii?Q?nfB78ZqZi1sgB+BGTa/pgvgo7cxp+RgMwGE0vdrI9p354/U0ZSwHUqN8dh5n?=
 =?us-ascii?Q?hn50uxx0hnd+4YlQ5wb7H9dnj2iMY6Euu5Brb5z7fM/GwQ86AanpwTXeGbI6?=
 =?us-ascii?Q?eognQgGKjHoGMeRjeoIBFMbE1ozNMaLd/sajrUR2FDwRreqzshMpuhfrf6ZA?=
 =?us-ascii?Q?sVdjNPpzHK/C+jfoA3XaMNY6IkTHNSJtIPEO2ifDznvzfLR4PtEK0gSzgFlN?=
 =?us-ascii?Q?ENcvOin4mcoKDPKIjZnK0/3CEG6zYeGiNCH5sP/zD33NR3hoYMghDeq8S2qK?=
 =?us-ascii?Q?yBgWYP+8IRt1XZOmGaswCXvE829sFba33Hgdx7gOVA8sAT9XelYvCtAMS9fp?=
 =?us-ascii?Q?JFLkpAknsULFm+r10/+DCoAl4s2bBSzrFlBqDdJY9rvCdNug3ppF/aENOUPH?=
 =?us-ascii?Q?+QQSGfxggzC458V2VifNjdS0leQyZMLM7k7xhALtkT47YRUaZi7PML+mY8+X?=
 =?us-ascii?Q?GrAiuTzWcfRwj6E4PmPSRKwmLWjdybMvkNOPPAsGahqagGFpfEyyQunMtHbi?=
 =?us-ascii?Q?zHCvONvchiBC420M6klw+8h2XIDGKw8ak7Q91R+0AiG0XH2nFpOwjJSIySot?=
 =?us-ascii?Q?vMNUdpx+m4AIVzl0yQc89YnjxtLoD70KeucQiMsm79zeQPzlxXwlDLbzgkag?=
 =?us-ascii?Q?XCSs2i/f1o7QYbufXzUeAGuwu6R0qb4GuonPG+C89sDzRoME6rBbLutgZUJJ?=
 =?us-ascii?Q?eH/TLtVhZuliWdsITSo3GFpObMe8Wbf6uorU59q98g3cTK/e3+ycworj3Avb?=
 =?us-ascii?Q?U9vFSrQPaIODkw6cvN5UpLgd9/976PrAxbz7Xh+ELYcH+LCscWnDhE7mOQOG?=
 =?us-ascii?Q?WwvuP/odUDTkDc7nNk4lKXaV1zKG14Udu/2f5ZXDS+ZYlfTq2TgXndC/yhAI?=
 =?us-ascii?Q?eM8nnzKDImNNcBsblYavu4ZPxf9vCC8YMG/fBUdFoZTa0AsUB2pJoe26P9MZ?=
 =?us-ascii?Q?V+bEK1N5omXRd2CSqY/jCVTaS1gLOUuwBV6AsZbeARZRgQNJxrbA5bz1YVnf?=
 =?us-ascii?Q?VVITvVoi3Ko0SHAoFn3O977ImwRj4uhog+DynL0usaHth3MG30nqabrTJsr3?=
 =?us-ascii?Q?y1a8K/EbKCq9PPrLom4cL9W/5kwHeAElGSOY7Yz6xCBh4hmCygm+z0XOQRhM?=
 =?us-ascii?Q?cub37sLCVH/eYUFWSQJ8lcld9jbM5GR42CnceP0GzfufFJoSsrWidi55Zh2Z?=
 =?us-ascii?Q?eXx0Ld2p7FQNc6ySOoc5AXCT82mHO0RSO5WZNRZCuQgzb1sfYMCxhJ4iMXAP?=
 =?us-ascii?Q?Y6iNPeaRjsnUu2tJfnSRdJCLZyhkeVNkyRaIWC4F/JjsSCUnXsv2gisP615f?=
 =?us-ascii?Q?qRh8bJTxiOYeNnzfrtV0NNC2S1uXSsKT/XtgtGAjIrF8X3f1MGYJobcb3wyh?=
 =?us-ascii?Q?wGyAaXR2pggJCKSUbRF6FedviO+25YYbUsJZiyE1cpj/qB9Ggui5mdRV1KNz?=
 =?us-ascii?Q?BlDeI6ujvua3z29ekMr6+W0AdbW+GWP/6a8IONhi8blC7eWgLkSQY5F01I6H?=
 =?us-ascii?Q?6X47lvtLXfqQZVnzvd8H1NE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d97dbf5b-4980-4e9a-ac4d-08ddc65f4365
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2025 00:57:41.3826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zeQcrXQc+EzJQhLtJ6nZrLnzcBebxfb7gPtVRGHOfEPPXu09HXhEEsHKOPlGX45E8HYYknZ2DFx3v/ag8aVDltIPKR10DYWPtNwrdAzNxlQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10218
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

This adds reset controller support for airoha en7523/en7529/en7562 SoCs.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/reset/reset-airoha.c                  | 63 +++++++++++++++++--
 .../dt-bindings/reset/airoha,en7523-reset.h   | 61 ++++++++++++++++++
 2 files changed, 119 insertions(+), 5 deletions(-)
 create mode 100644 dts/upstream/include/dt-bindings/reset/airoha,en7523-reset.h

diff --git a/drivers/reset/reset-airoha.c b/drivers/reset/reset-airoha.c
index e878af6167c..ea560a33ca0 100644
--- a/drivers/reset/reset-airoha.c
+++ b/drivers/reset/reset-airoha.c
@@ -11,7 +11,11 @@
 #include <linux/io.h>
 #include <reset-uclass.h>
 
+#if defined(CONFIG_TARGET_EN7523)
+#include <dt-bindings/reset/airoha,en7523-reset.h>
+#elif defined(CONFIG_TARGET_AN7581)
 #include <dt-bindings/reset/airoha,en7581-reset.h>
+#endif
 
 #define RST_NR_PER_BANK			32
 
@@ -24,12 +28,60 @@ struct airoha_reset_priv {
 	void __iomem *base;
 };
 
-static const u16 en7581_rst_ofs[] = {
+static const u16 en75xx_rst_ofs[] = {
 	REG_RESET_CONTROL2,
 	REG_RESET_CONTROL1,
 };
 
-static const u16 en7581_rst_map[] = {
+#if defined(CONFIG_TARGET_EN7523)
+static const u16 en75xx_rst_map[] = {
+	/* RST_CTRL2 */
+	[EN7523_XPON_PHY_RST]		= 0,
+	[EN7523_XSI_MAC_RST]		= 7,
+	[EN7523_XSI_PHY_RST]		= 8,
+	[EN7523_NPU_RST]		= 9,
+	[EN7523_I2S_RST]		= 10,
+	[EN7523_TRNG_RST]		= 11,
+	[EN7523_TRNG_MSTART_RST]	= 12,
+	[EN7523_DUAL_HSI0_RST]		= 13,
+	[EN7523_DUAL_HSI1_RST]		= 14,
+	[EN7523_HSI_RST]		= 15,
+	[EN7523_DUAL_HSI0_MAC_RST]	= 16,
+	[EN7523_DUAL_HSI1_MAC_RST]	= 17,
+	[EN7523_HSI_MAC_RST]		= 18,
+	[EN7523_WDMA_RST]		= 19,
+	[EN7523_WOE0_RST]		= 20,
+	[EN7523_WOE1_RST]		= 21,
+	[EN7523_HSDMA_RST]		= 22,
+	[EN7523_I2C2RBUS_RST]		= 23,
+	[EN7523_TDMA_RST]		= 24,
+	/* RST_CTRL1 */
+	[EN7523_PCM1_ZSI_ISI_RST]	= RST_NR_PER_BANK + 0,
+	[EN7523_FE_PDMA_RST]		= RST_NR_PER_BANK + 1,
+	[EN7523_FE_QDMA_RST]		= RST_NR_PER_BANK + 2,
+	[EN7523_PCM_SPIWP_RST]		= RST_NR_PER_BANK + 4,
+	[EN7523_CRYPTO_RST]		= RST_NR_PER_BANK + 6,
+	[EN7523_TIMER_RST]		= RST_NR_PER_BANK + 8,
+	[EN7523_PCM1_RST]		= RST_NR_PER_BANK + 11,
+	[EN7523_UART_RST]		= RST_NR_PER_BANK + 12,
+	[EN7523_GPIO_RST]		= RST_NR_PER_BANK + 13,
+	[EN7523_GDMA_RST]		= RST_NR_PER_BANK + 14,
+	[EN7523_I2C_MASTER_RST]		= RST_NR_PER_BANK + 16,
+	[EN7523_PCM2_ZSI_ISI_RST]	= RST_NR_PER_BANK + 17,
+	[EN7523_SFC_RST]		= RST_NR_PER_BANK + 18,
+	[EN7523_UART2_RST]		= RST_NR_PER_BANK + 19,
+	[EN7523_GDMP_RST]		= RST_NR_PER_BANK + 20,
+	[EN7523_FE_RST]			= RST_NR_PER_BANK + 21,
+	[EN7523_USB_HOST_P0_RST]	= RST_NR_PER_BANK + 22,
+	[EN7523_GSW_RST]		= RST_NR_PER_BANK + 23,
+	[EN7523_SFC2_PCM_RST]		= RST_NR_PER_BANK + 25,
+	[EN7523_PCIE0_RST]		= RST_NR_PER_BANK + 26,
+	[EN7523_PCIE1_RST]		= RST_NR_PER_BANK + 27,
+	[EN7523_PCIE_HB_RST]		= RST_NR_PER_BANK + 29,
+	[EN7523_XPON_MAC_RST]		= RST_NR_PER_BANK + 31,
+};
+#elif defined(CONFIG_TARGET_AN7581)
+static const u16 en75xx_rst_map[] = {
 	/* RST_CTRL2 */
 	[EN7581_XPON_PHY_RST]		= 0,
 	[EN7581_CPU_TIMER2_RST]		= 2,
@@ -86,6 +138,7 @@ static const u16 en7581_rst_map[] = {
 	[EN7581_PCIE_HB_RST]		= RST_NR_PER_BANK + 29,
 	[EN7581_XPON_MAC_RST]		= RST_NR_PER_BANK + 31,
 };
+#endif
 
 static int airoha_reset_update(struct airoha_reset_priv *priv,
 			       unsigned long id, bool assert)
@@ -135,7 +188,7 @@ static int airoha_reset_xlate(struct reset_ctl *reset_ctl,
 {
 	struct airoha_reset_priv *priv = dev_get_priv(reset_ctl->dev);
 
-	if (args->args[0] >= ARRAY_SIZE(en7581_rst_map))
+	if (args->args[0] >= ARRAY_SIZE(en75xx_rst_map))
 		return -EINVAL;
 
 	reset_ctl->id = priv->idx_map[args->args[0]];
@@ -158,8 +211,8 @@ static int airoha_reset_probe(struct udevice *dev)
 	if (!priv->base)
 		return -ENOMEM;
 
-	priv->bank_ofs = en7581_rst_ofs;
-	priv->idx_map = en7581_rst_map;
+	priv->bank_ofs = en75xx_rst_ofs;
+	priv->idx_map = en75xx_rst_map;
 
 	return 0;
 }
diff --git a/dts/upstream/include/dt-bindings/reset/airoha,en7523-reset.h b/dts/upstream/include/dt-bindings/reset/airoha,en7523-reset.h
new file mode 100644
index 00000000000..6c934ccf137
--- /dev/null
+++ b/dts/upstream/include/dt-bindings/reset/airoha,en7523-reset.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2024 iopsys Software Solutions AB.
+ * Copyright (C) 2025 Genexis AB.
+ *
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ *
+ * based on
+ *   dts/upstream/include/dt-bindings/reset/airoha,en7581-reset.h
+ * by Lorenzo Bianconi <lorenzo@kernel.org>
+ */
+
+#ifndef __DT_BINDINGS_RESET_CONTROLLER_AIROHA_EN7523_H_
+#define __DT_BINDINGS_RESET_CONTROLLER_AIROHA_EN7523_H_
+
+/* RST_CTRL2 */
+#define EN7523_XPON_PHY_RST		 0
+#define EN7523_XSI_MAC_RST		 1
+#define EN7523_XSI_PHY_RST		 2
+#define EN7523_NPU_RST			 3
+#define EN7523_I2S_RST			 4
+#define EN7523_TRNG_RST			 5
+#define EN7523_TRNG_MSTART_RST		 6
+#define EN7523_DUAL_HSI0_RST		 7
+#define EN7523_DUAL_HSI1_RST		 8
+#define EN7523_HSI_RST			 9
+#define EN7523_DUAL_HSI0_MAC_RST	10
+#define EN7523_DUAL_HSI1_MAC_RST	11
+#define EN7523_HSI_MAC_RST		12
+#define EN7523_WDMA_RST			13
+#define EN7523_WOE0_RST			14
+#define EN7523_WOE1_RST			15
+#define EN7523_HSDMA_RST		16
+#define EN7523_I2C2RBUS_RST		17
+#define EN7523_TDMA_RST			18
+/* RST_CTRL1 */
+#define EN7523_PCM1_ZSI_ISI_RST		19
+#define EN7523_FE_PDMA_RST		20
+#define EN7523_FE_QDMA_RST		21
+#define EN7523_PCM_SPIWP_RST		22
+#define EN7523_CRYPTO_RST		23
+#define EN7523_TIMER_RST		24
+#define EN7523_PCM1_RST			25
+#define EN7523_UART_RST			26
+#define EN7523_GPIO_RST			27
+#define EN7523_GDMA_RST			28
+#define EN7523_I2C_MASTER_RST		29
+#define EN7523_PCM2_ZSI_ISI_RST		30
+#define EN7523_SFC_RST			31
+#define EN7523_UART2_RST		32
+#define EN7523_GDMP_RST			33
+#define EN7523_FE_RST			34
+#define EN7523_USB_HOST_P0_RST		35
+#define EN7523_GSW_RST			36
+#define EN7523_SFC2_PCM_RST		37
+#define EN7523_PCIE0_RST		38
+#define EN7523_PCIE1_RST		39
+#define EN7523_PCIE_HB_RST		40
+#define EN7523_XPON_MAC_RST		41
+
+#endif /* __DT_BINDINGS_RESET_CONTROLLER_AIROHA_EN7523_H_ */
-- 
2.47.2

