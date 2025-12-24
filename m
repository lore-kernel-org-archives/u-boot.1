Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C281AE75423
	for <u-boot@archiver.kernel.org>; Wed, 24 Dec 2025 08:26:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5CB084248;
	Wed, 24 Dec 2025 09:25:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="xCb1zdy0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F23284236; Wed, 24 Dec 2025 09:25:06 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45EE784246
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 09:25:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Op/tSxXPAR0Iydzcpdc4M0neE8Bhkxl6hjXjAHXlp7kVZyqoso6ASx+OX/BXEj2L6xir2/DIc61//8qKncTbC98XBjOETkuhcoCcGnuKLQZgud60hF/Djxw55uKd2H5LWWluZ/1d3uLt/CZXEEnO9kA87mmCecCc56pOga7OzaDgV1Cama+Vp6JJp1WMP4M7SE3XnKSE1DuRitb8LO1odCeLrOGE08E9sb2titgup5h+TAXVtsratjUsNQF7lHMVgNg85eB55cDEyu3y1xmaM7+5LkUcgUYniGKRj6SHtBGRlQxNNbi4VWQFKBM9tzqr6EULG3K7XLcwSeTWZgO6pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NonnEcqCVse5I+Is+wgt48heTlYcqZN2cPOnTPxxYik=;
 b=cD7jw853Tmrufn4mNG/b4kLruzi05YXQoPn7pBmvPhNhvzb5xFhDJXZafuYSynWAo736zt8jKBzuXfV08g0bYrxAHxGnEgx5WYIBfnjHWtQWTg3dUxWbUgp9ZI7Qf2iuCMskBoyO4l5m2+Kx0UbZT1zJyffO+IZdXdElOXiZe7VgQF87H5e0mmkH0m8/xhiv6glLah7yvt7j6U+jh0leA6o2gnG9JlyC+8tl6yKxm4OjUeNjuj8SGzeFiyZat+iC0o16tyODTWiS15Y/Ib1mFSoE+Nacq1JwM9OdE/EpNzi8LdY1U6jIQYYdnfDpCfcokDlSmyWfsKTmqGFBe5wTZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NonnEcqCVse5I+Is+wgt48heTlYcqZN2cPOnTPxxYik=;
 b=xCb1zdy04dVO8JK7ERCg6Z51hu/bG1xU1/qeNqJMGm51lAgx9KA1Jwf+7oLS/R09Z+IidLghcxbhp1fTh/AM1YfMzI9k7I/+1R5Bz8gPznnjyE3uA9eDBNYzJuzGe2DmmcjpWmYj6cqL1DJFN4hQKu6jAKjLlTC0FwplmDeuorQznkOk+6Sme6ciCquHODt7iqNU8YRN2E58GdLYOvsggisOs5WhsfPkWvT5XJuU2SMOd4Lgw07ManRp4YaLYZwJ47sX+0WziVNNTSuER39tzJxGiYlbHBwmT7KgkJZCrkIcPXV3PG8NwhthFQQzIR2p5YI1G5O9PWCosCc92mq86A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB6562.eurprd08.prod.outlook.com (2603:10a6:20b:355::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Wed, 24 Dec
 2025 08:25:02 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9434.009; Wed, 24 Dec 2025
 08:25:02 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <me@ziyao.cc>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Markus Gothe <markus.gothe@genexis.eu>, Greg Malysa <malysagreg@gmail.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH RESEND 14/19] net: airoha: fill in support for PCS/PHY in
 Airoha Ethernet driver
Date: Wed, 24 Dec 2025 11:24:04 +0300
Message-ID: <20251224082409.1347373-15-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251224082409.1347373-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251224082409.1347373-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::15) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB6562:EE_
X-MS-Office365-Filtering-Correlation-Id: 5acb4fc3-baa4-46f8-4212-08de42c5ef02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6glGUa/5nVWnme3y64cS8SOsqhnkId6b4fRGxQ/Cv1oUr3borQ3xdnW8Ns2Z?=
 =?us-ascii?Q?/oVQzY7xk6JbtWBqcYrzS04e9vw4uHult8qWzLbzs9yyk/P+E+f6qvH2nCWH?=
 =?us-ascii?Q?Q6pJ/smN1q9qn3KwgKrLOrEvFogMVGFttlgstjmvLHC/C6+ahLpWASr4NqP2?=
 =?us-ascii?Q?BILXEhpEOrRFtiJEROL+rVlb2+KuoCLLHHyMdxQdzfOpPwSUXFaN4yOOlhh0?=
 =?us-ascii?Q?FcSGruYeqvmKGS1KlJI1b8fLUcxECVx0bNTG5CACvMyc5C5yahO5y8iqgZyr?=
 =?us-ascii?Q?B9aacS7wlbb7icqCYapfdWKmqVxQP+cEUxp6IeeqFCW+rThzdb3f1F9LE+35?=
 =?us-ascii?Q?b4iQ9GchC5D83fdS86GbbCYhnAOx3D3kUMncqeRJ1S9uu86O8BKiNacTEA0V?=
 =?us-ascii?Q?i+pagjeL5Ty7DZIVnU2vS8jIOyHeIHxj9HYSB6Yh0rGzzpEbJIIm2a2m6MlS?=
 =?us-ascii?Q?38lQ81iOfU1tq5wRVg0u5NVeEEKsDsTVth/2zOKwniSDpKDeluwiKhtBbvYr?=
 =?us-ascii?Q?I2XXgIDhKln9ej78Tg//KZZ86TMKg39F/5s89BJDEIOHyDuzQ45pjDhHpFT9?=
 =?us-ascii?Q?RXbTzUqGGdX9K1Kgj2lO9yWQ3ITnDjnsV7uyQBXdDZUxkIyk1QFOb0uQTSER?=
 =?us-ascii?Q?Ff1UUAR1ezBxqbGXjwfaKo2NKpx+ZDCretsRYHgIAy7CV7IC5UrEjEpUy/jU?=
 =?us-ascii?Q?4BfOE2H5yxotAeqzYgAovChGifKjXl99iQeSjWPT0WfZXccrUNRgSwF7xlMH?=
 =?us-ascii?Q?MfdiZRWyvNq8LUdiFa1Hz+gmmpBS6kpppLOrTXNVf6bd+ogJebspo3dywtJa?=
 =?us-ascii?Q?VHs8IJ9g0tve9GKq1gQT9g0i3egp0VSvDMlu8jBpn9VGG42XmcwkmDbbyD+2?=
 =?us-ascii?Q?gLrV3gEQ8Wn326Ec0+klKQCpyKALrEGqows5RBMiTBEQr2QwaU0vowEIm57G?=
 =?us-ascii?Q?Jo/d8jfrrNZyyH6h73viLcdEYMBylPIW8u0HmuIYwsbWkIM8NP5lc3OMsPTR?=
 =?us-ascii?Q?sreNxs1QBEGe0ckyrVLtTx93vKwyshuEVef9W2eicEwb+janfNOqk0wE4icw?=
 =?us-ascii?Q?nwvQlOF5OOm6ohQdgMJrayDWEX5y94erDLcGSSuMNA2TzKNTq4d4LGcw+ooj?=
 =?us-ascii?Q?bCRhVh2eF7TwgPiUzqtbRCUW8YiAlZClMUDutYdRkyxqvm2wRucANxRCy9Pj?=
 =?us-ascii?Q?RAyifrTGxRWhkDRhXcCXQ2DVdlq3+bHniS5O/jrAt4PsiBBkGTAoOgt5+rjD?=
 =?us-ascii?Q?NHsny/DiIIiWZLdg2uNgJtG+nJhxIUi+zHH2lrFpHnnXG7pMyyxXdDmYJNyT?=
 =?us-ascii?Q?mk/E+Krxoi6ZqNwmVfw52PNkVV0Eszh3UhIxYfsf+pjibftP6RuVbyAWBbsc?=
 =?us-ascii?Q?h7Wxr95K+Cbz3NuwQhWVgCoecKoIo4nmodLlOG4d/nVV7UUixWjDdUpNO2Lv?=
 =?us-ascii?Q?ZoNkOrQ0j71kqI5NOhd9vdZxEurlMUdF4yzG9ZlEKXsTaBDIXgeRj7UJDqJz?=
 =?us-ascii?Q?BTvQoevAJHV2UYSI5z/pR31s3mZbN1URcguNVD7ht1Gv2KxEYT1mVIDyHA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+sVSzM35f7+/bWi1j+kt7IYif1oBCHdSBoFSh/WV7gdew8A+VNKtpn95Kkug?=
 =?us-ascii?Q?B6d23oYb/mxZtuX400lMI67J6By3S6jkEcMbleHW7BjB6IGxlAYoOkMvJ1j/?=
 =?us-ascii?Q?88f1F0N8hk+1fZvUxD+wZDJfISpS+vyOc3yH2sdYdw7IINOyQfJ8G7/9rRxc?=
 =?us-ascii?Q?tAsXrkVtUsyYaPjezYjzy5INzEShDUYwnIbB0F0cLEGSpWGPwG7lJfX7FX0C?=
 =?us-ascii?Q?ZZPC7pOCVo+qVL7B0bEYbzSHZa5Gs31Qjvuk5+nwJsinYWYnoqS5K1qkLjeE?=
 =?us-ascii?Q?rqr8gvnKP6d0XLWL0yHeM9xlQSsdv0IiMsW0kQUh4St/tvP0horA1Pkfe7oM?=
 =?us-ascii?Q?/owdcEazJKsR8/GLIKwWHPHOwEP4uhHG4IGvqI40IDa7GvKECjRL8873rBIs?=
 =?us-ascii?Q?eYy74w1WKREBtu18TMUs8rfBV+fhnF3as6VkP8JdgNBpcS2qX464779lNq1R?=
 =?us-ascii?Q?ZjOlK9lP/NBeQs3XRDRRPm8SGxm0E0jSd86aZJKIdgaTeOO3Rjucqe2z5TrM?=
 =?us-ascii?Q?aDAwu8M6tIUhd56Aeid4OkMNU4xH8sGQJpam75IoFSsfFJ4TcOIUbJsPPBpR?=
 =?us-ascii?Q?gYVBhvhf5Az4BEePeyTxeEgtBNuLql7V0WzV7AGQ/yRsTLKZ+qDe/0AC1bFl?=
 =?us-ascii?Q?P0T69ZiiCD2/pW3jJ1JzgvPyap2gEq8jEzKrY01S5UFWcumrsJLpZlWsUTM/?=
 =?us-ascii?Q?A9EZadmopHB0cVOdOSemGndbCRLnHqijjhIHDTTnj+hkz+W8hROM8IrC7wVU?=
 =?us-ascii?Q?/qRHzHZRG648XWR/kmPXq0H7ewznIajgn0XSMHZxsUbKhY+xP35NuW5JzYwf?=
 =?us-ascii?Q?zXjFnluHi5nlZDrVueIBfm6XaewTKBgo/9n9fNnXuSf8teP/NgUe746+jytS?=
 =?us-ascii?Q?aYDCtdYvAiIPJMyTGWvsfuEdSRRmE0zwyx7yfQPtgUvhl93bB7NYw34jwR7A?=
 =?us-ascii?Q?bNW1kO4DQOn+HK7mkU+D79pXgPdjIrcktJcu0I5Kfw+alBmY9Mfi5SmoY9Qq?=
 =?us-ascii?Q?9ks0TkUlJFx9fDjP0VRtx69Il+U2V3lGCJRYDt9rXAZp8Vk0/gQIlsGRMtaD?=
 =?us-ascii?Q?X6WyQK4jOByQYfIjp/uB8mKe5JudXuuydMdqqKregI6Iit+V7e0jv8Zsn/gO?=
 =?us-ascii?Q?D7glGVN3v5bJS9LIjhFysURtOvFV4ya6HS6PSfjNcpfunEmbwc6iOwQ+Xk0w?=
 =?us-ascii?Q?l7s8YTUwu6HSKLnqrdG9J9wBaiJusz4/bCtKD+Dt87p/YqpR8D/bQFjOqAED?=
 =?us-ascii?Q?8zZbgtXHUrggmgdBFZE6y+R0/S62k4+kPBcPxpwQKzdB6qOfrmqlGZuYq66N?=
 =?us-ascii?Q?8cU/61gnDJpVL5kgawkvHanKNY8/fCsskVpveX134ntGTWya9yUEvqWHF6jp?=
 =?us-ascii?Q?qX1qnCIkrV99P7H4x/7EAZFbnKAyQbIYA8MadbH7a0UcqqKhvdu1zgMzIV2P?=
 =?us-ascii?Q?j6w9EB37A6x7dCuItFaULawo42ur0zMZJ98v0t7kmH3Z6l9Uo2umQviGaf5u?=
 =?us-ascii?Q?sJiEXB2pqC4Ry0CtVZm928pBvo6Eln3ZvpgYb5HH1dlIsexHTy8AhygEeE2U?=
 =?us-ascii?Q?VA+Rxb/Yan/Zpa+llpQ1ayKnR046NhDFf8R29XA/n7pfOSZcFLjullDU+C1G?=
 =?us-ascii?Q?miQGyzL0jy5Im4Izrp4EjWDZaImGNguOibY8QUdBY+Tdz/OIqM3CCeTvJvrc?=
 =?us-ascii?Q?wxRop73D+Xdm9Yy09UGnwLQ/THycKUcxwMQ8iYTzjx8gA3sTJK7n4knhl+++?=
 =?us-ascii?Q?ihPOJJTMpx06CNula4FOINCLs86Tgro=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5acb4fc3-baa4-46f8-4212-08de42c5ef02
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2025 08:25:02.1107 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IGsAO/AaBKn5oIgmMRxMTMiRhUHC+YlKXoamqfNyCEhPiouc0F6xvUxPpxhNt0u2E3AsyC48s8m3ufvR0nYlzyviPbrBwJycDOpWRzv2E40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6562
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

From: Christian Marangi <ansuelsmth@gmail.com>

Add required changes to call PCS function to configure the Serdes Port.
The Ethernet driver is adapted following Upstream Kernel node structure.

Function calling order is the same of Phylink upstream kernel.

With the PCS support, also add support for attaching PHY. With
"in-band-status" set in DT for the managed property, a rudimental
support for SFP module is present.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/Kconfig      |  1 +
 drivers/net/airoha_eth.c | 99 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 26a292362c0..e300ff3bd52 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -127,6 +127,7 @@ config AIROHA_ETH
 	bool "Airoha Ethernet QDMA Driver"
 	depends on ARCH_AIROHA
 	select PHYLIB
+	select DM_ETH_PHY
 	select DM_RESET
 	help
 	  This Driver support Airoha Ethernet QDMA Driver
diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index 7f984f56dc8..f773318fe14 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -12,6 +12,7 @@
 #include <dm/device-internal.h>
 #include <dm/devres.h>
 #include <mapmem.h>
+#include <miiphy.h>
 #include <net.h>
 #include <regmap.h>
 #include <reset.h>
@@ -19,11 +20,14 @@
 #include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
+#include <linux/ethtool.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/time.h>
 #include <asm/arch/scu-regmap.h>
 
+#include "airoha/pcs-airoha.h"
+
 #define AIROHA_MAX_NUM_GDM_PORTS	4
 #define AIROHA_MAX_NUM_QDMA		1
 #define AIROHA_MAX_NUM_RSTS		3
@@ -318,6 +322,12 @@ struct airoha_qdma {
 struct airoha_gdm_port {
 	struct airoha_qdma *qdma;
 	int id;
+
+	struct udevice *pcs_dev;
+	phy_interface_t mode;
+	bool neg_mode;
+
+	struct phy_device *phydev;
 };
 
 struct airoha_eth {
@@ -692,6 +702,34 @@ static int airoha_qdma_init(struct udevice *dev,
 	return airoha_qdma_hw_init(qdma);
 }
 
+static int airoha_pcs_init(struct udevice *dev)
+{
+	struct airoha_gdm_port *port = dev_get_priv(dev);
+	struct udevice *pcs_dev;
+	const char *managed;
+	int ret;
+
+	ret = uclass_get_device_by_phandle(UCLASS_MISC, dev, "pcs",
+					   &pcs_dev);
+	if (ret || !pcs_dev)
+		return ret;
+
+	port->pcs_dev = pcs_dev;
+	port->mode = dev_read_phy_mode(dev);
+	managed = dev_read_string(dev, "managed");
+	port->neg_mode = !strncmp(managed, "in-band-status",
+				  sizeof("in-band-status"));
+
+	airoha_pcs_pre_config(pcs_dev, port->mode);
+
+	ret = airoha_pcs_post_config(pcs_dev, port->mode);
+	if (ret)
+		return ret;
+
+	return airoha_pcs_config(pcs_dev, port->neg_mode,
+				 port->mode, NULL, true);
+}
+
 static int airoha_hw_init(struct udevice *dev,
 			  struct airoha_eth *eth)
 {
@@ -712,6 +750,10 @@ static int airoha_hw_init(struct udevice *dev,
 	if (ret)
 		return ret;
 
+	ret = reset_deassert_bulk(&eth->xsi_rsts);
+	if (ret)
+		return ret;
+
 	mdelay(20);
 
 	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++) {
@@ -891,6 +933,7 @@ static int airoha_eth_port_probe(struct udevice *dev)
 {
 	struct airoha_eth *eth = (void *)dev_get_driver_data(dev);
 	struct airoha_gdm_port *port = dev_get_priv(dev);
+	int ret;
 
 	port->qdma = &eth->qdma[0];
 
@@ -898,6 +941,14 @@ static int airoha_eth_port_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
+	if (port->id > 1) {
+		ret = airoha_pcs_init(dev);
+		if (ret)
+			return ret;
+
+		port->phydev = dm_eth_phy_connect(dev);
+	}
+
 	return 0;
 }
 
@@ -917,6 +968,47 @@ static int airoha_eth_init(struct udevice *dev)
 			GLOBAL_CFG_TX_DMA_EN_MASK |
 			GLOBAL_CFG_RX_DMA_EN_MASK);
 
+	if (port->id > 1) {
+		struct phy_device *phydev = port->phydev;
+		int speed, duplex;
+		int ret;
+
+		if (phydev) {
+			ret = phy_config(phydev);
+			if (ret)
+				return ret;
+
+			ret = phy_startup(phydev);
+			if (ret)
+				return ret;
+
+			speed = phydev->speed;
+			duplex = phydev->duplex;
+		} else {
+			duplex = DUPLEX_FULL;
+
+			/* Hardcode speed for linkup */
+			switch (port->mode) {
+			case PHY_INTERFACE_MODE_USXGMII:
+			case PHY_INTERFACE_MODE_10GBASER:
+				speed = SPEED_10000;
+				break;
+			case PHY_INTERFACE_MODE_2500BASEX:
+				speed = SPEED_2500;
+				break;
+			case PHY_INTERFACE_MODE_SGMII:
+			case PHY_INTERFACE_MODE_1000BASEX:
+				speed = SPEED_1000;
+				break;
+			default:
+				return -EINVAL;
+			}
+		}
+
+		airoha_pcs_link_up(port->pcs_dev, port->neg_mode, port->mode,
+				   speed, duplex);
+	}
+
 	return 0;
 }
 
@@ -925,6 +1017,13 @@ static void airoha_eth_stop(struct udevice *dev)
 	struct airoha_gdm_port *port = dev_get_priv(dev);
 	struct airoha_qdma *qdma = port->qdma;
 
+	if (port->id > 1) {
+		if (port->phydev)
+			phy_shutdown(port->phydev);
+
+		airoha_pcs_link_down(port->pcs_dev);
+	}
+
 	airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
 			  GLOBAL_CFG_TX_DMA_EN_MASK |
 			  GLOBAL_CFG_RX_DMA_EN_MASK);
-- 
2.51.0

