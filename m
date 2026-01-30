Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65DD5D49C68
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 07:21:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 779EF84131;
	Fri, 30 Jan 2026 08:21:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Lu08CyzF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65CC88413A; Fri, 30 Jan 2026 08:21:25 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0079784101
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 08:21:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RYNN3f1kCpLqcZoNsRV/Wdc6G+djxp0Dl2o7t94hc05yJrczrhApazBGDE3pwwkrTeAZ4kl8IkEp6muwbQz72KENGBmOt1DhmLSNpZ/JjN5dPFhQQLApYhfx6bU85trUTwtniymOC914BdJ1O4Wp+HWRvj1Ey1VhVrEHw7KzSLFWRyn2kEslue4aG6ec9jC51B1IwiSIOoJHNoeBmmjYt0PmfU+gRJJHksTU56PD58ci1EcCkyZ/gQeClWMq5mJZr+zsybyAqm/8ozwfGgOCuIJqKNvmxUgsOztgRQCaY46T3JNwN+8qQmquNjBJteKAuT7X4S5/hCGHGB7eEz2zOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQKmLhMtwGdjEgzkvFxhNd8VbvszRBT7KdoiufDAwXk=;
 b=STYvAXcSvdbj31KE3SzV8SoHODq2gCg3qpOXhaCFbmtKCL0PX3XBVjvEttm9hQ6bSbKea+O0RNjV5ybRB0Ve9ZjLYYq6qC0ytjJsEFXogn8mz6JtjqtXkSncHb856uMUvUY9evB375NXfVw1tRMKm39iuXLWg4POufdjoHO8ojpipoSHjbONrtC/SmmmgiwNO5X1UmswgyT2jWYRtHm4r6qkDYwBJtaCfDNFMNf6aEvQmlNRCL7FJEwsLouyyh2MeSdCCk2eOZedf2Sk9kbfzzbdS24NdyDaRYOsI2gPgMx6nX4rHiSij0gZaQ1nCUgZv3BFvW3LhAHcTHJDZG6Qqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQKmLhMtwGdjEgzkvFxhNd8VbvszRBT7KdoiufDAwXk=;
 b=Lu08CyzFyaYHsE2hZwu6g/8N7N3uFoPAk2o3uf+GRkjxnMhsB3e6j+g1E+eWWb6KJgBB/oydZSZ1+FKM8w7TB6jazaswRltwuBQfOWTNL1/C0uTVcFj/ROX0JrNH2UoV3fYioSYI4cpq/YRZ3vU6ieJBrqU5wHXQZgLOmJSV8ZtspIg9p/q2B185EFEtTIVR2GZ/HbIXzO9ytJUPiush7EsldeCrM1iOT745A97PbFRXuVjA3xM9+21XwG7OktYXs3V6K29YX54HtZVXYmjXtfWbsIlzSKOvpwMsJCpQp3F1gpY9/xM9BRG3PZD55miIeNCQs2PFPfa1pvwHaXke3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8207.eurprd04.prod.outlook.com (2603:10a6:102:1cd::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 07:21:19 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Fri, 30 Jan 2026
 07:21:19 +0000
Date: Fri, 30 Jan 2026 15:21:16 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Eoin Dickson <eoin.dickson@microchip.com>,
 Greg Malysa <malysagreg@gmail.com>, Ian Roberts <ian.roberts@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Tom Rini <trini@konsulko.com>, Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH 1/3] gpio: Add GPIO delay driver
Message-ID: <aXxb7L03qQ3jdnuT@shlinux89>
References: <cover.1769086229.git.michal.simek@amd.com>
 <6a6cd2da427e13bc69d2e0ae4070b715791be02e.1769086229.git.michal.simek@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a6cd2da427e13bc69d2e0ae4070b715791be02e.1769086229.git.michal.simek@amd.com>
X-ClientProxiedBy: MA5P287CA0109.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b5::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8207:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eefab57-5e9c-4dfd-a1b6-08de5fd029b2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|7416014|376014|366016|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tPjrVZMwcyMTwn+S7BN8PDGp35Udktjt5W1tKYhurMhKNy7R2RQBb/GddRQ4?=
 =?us-ascii?Q?6Z/q11w7zK5M2MXJ2sxAwmgo2kesp0s7zLggrDUouHmW1ZYR4BkOqwJKtPfb?=
 =?us-ascii?Q?nZFqW2DkKb3qK7qBBeSRZF7pzdLWBDHRhOJautnoSSG2MaYjjn8hRFii1Lzp?=
 =?us-ascii?Q?0TEhiZKehnm+aadfKWRW8+7i4jgQ5oNbVfhzkvoUetuCv6Fejn85EhvtGYPq?=
 =?us-ascii?Q?yGLLJe1dlo9t/ex8mL36bWSy4LvXQPR8riT3IqjHgHjlkDzW7sPCnHfZiorI?=
 =?us-ascii?Q?0xyixnAmvKiufHd1X2PB0TOjcTWQe+d++pZddP7Ej3ACqHN9FZW5Fyk1c7PT?=
 =?us-ascii?Q?77UdgQHnDmRAELcA8qXQCFkT7nQqj66m9nTHIGBe/PBV2BLShpiwA5OGaM7r?=
 =?us-ascii?Q?89J8H6928Ed7QZwTAJgTcR1H8S+qgLVdUWbzXfgW5it4Kjlb7p/lLNhl1gn1?=
 =?us-ascii?Q?CfY9UGyqo1gaouMU71P1lC+qr+KhnivSs1cAj/eZTjAkXncXay6Xb6ySOmXW?=
 =?us-ascii?Q?KPPi5u2gQxRCU4KtVer+qBC0wp0O+XPpxle6vVKKt9gSvIu5Oy7omCoZEqDf?=
 =?us-ascii?Q?uOH6JVjduz2wfLYeDX9l7jdOLQRq5v2v5kZQNhznhcGYoULux+mFYOuTA4g3?=
 =?us-ascii?Q?Q+9tn3Sd6xlg+USIx5LZMnU05S2T4fsK9v3zAKJAzgzCwu4nUVLQrjdK0xhl?=
 =?us-ascii?Q?bKkVAH28ai06GoMd+arg/eC/fu+JxsfDxzcEd0uAbBTkBEp1z6I04CTkZz9G?=
 =?us-ascii?Q?ds5qMN2w8D25TaGTrpAlE8n81fDIaMxB1Xjq1sYyG5qIgU/vyeOIuT5ZM0Cl?=
 =?us-ascii?Q?wulk26LwziZTXINi/eRhVZSDIHFup+tBkyjy09HjspQNAEzH38YJ6QpnzEvZ?=
 =?us-ascii?Q?RDWJw8bp3Yz3GpeWPV/8ElYMFPfvnPFYYVhd7ORnxe/fqKJRP09F1XK+GbnA?=
 =?us-ascii?Q?OyH0yDBhHo+CfjQ8v/hjBGiJa+DLf/qGcJtplH/LY59iq5K/AK8ykmLZSUyt?=
 =?us-ascii?Q?YznN2VFRpmgzr+FCVNlTLVlkvFCGOENjwd1q7wSukWSgxgiIODPKrAMz7m6n?=
 =?us-ascii?Q?uip8f8ipDRPF+8zqeMlxLIP+OpvP6qqCDGpiwZ9cvnC5aAC+cydY6hSbwo5X?=
 =?us-ascii?Q?BTdDMS/rAgpObuSKzrgGHrsptpORcF1uQ8vzT2ns26VSwtUIyoW3ld0PE0pX?=
 =?us-ascii?Q?niaTYd72WS6mKnJn3EagFtEnRy+BEP9LgKyJHU4UGSsdB8VeaT/yxLToBkRo?=
 =?us-ascii?Q?KSoGZU5vrjYXEzzEAyfccpjpwvzCFREZhJOxOPnm/p6UTLESJHhp8UIJtEcY?=
 =?us-ascii?Q?KOHdSy2hGcgaP9u2feWwipuvddcdq2d0hmx+2HIFWU9eW18oelF+S3iYJ7BI?=
 =?us-ascii?Q?vHSUPGtOLm870GGJFIQaTJsxX/Xf/U9ogWEDEpkD2kCiivkaME8iwZtqYMuZ?=
 =?us-ascii?Q?fwMoHrXWeqAdcuVgxZfqROMD5QNJEooGQmumm1G7JDMkuIAlCx9M9cWaQPVC?=
 =?us-ascii?Q?weZ9VaPCeDD7ZcP6KHPAhPdx7g2sN61RklkSH5fDDvOMOPSGIhTfgXgs96QG?=
 =?us-ascii?Q?po5LkB36TQB1iKuIfpowIV1jEA+d8ljmrDb4nDYbhpzOm6i9kQFRaXbGLhK0?=
 =?us-ascii?Q?Wosmpe9tQhLd+RQdffvLUJ0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(19092799006)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5lPVs2SVUF/OHI60mor90z3YdY7EtC1QiAmE4I0pBcCJGoz102+Cx6CbGH1A?=
 =?us-ascii?Q?IiGjSaA50p7WYMRgpYE1Dc19nYXzoVWZ5/7XqGudSlXBtzdFPSdmzS+HUJOr?=
 =?us-ascii?Q?TMIzq7vSCpiavGeIlQKvD7WfOqSxWIopOck4Y63Ysry6sRmZKbaH4C/FMROx?=
 =?us-ascii?Q?ZLC8xMuTZ+RYERNcuQczql6zMqcFVH7pgUgPxJff8B9fOyJBEQv0kgVj4t4S?=
 =?us-ascii?Q?JIJl7yzEoZkusG/+c7BQQ8d0WtnG3AZyrng3s5t4+eDMXqitMAqekef3eyrt?=
 =?us-ascii?Q?kkc2EbMYW3bTMXy5UxAZHw8atVZv/OBo05IB1QoYOuPJt6/ff10uqmpE+lKT?=
 =?us-ascii?Q?uSYRHs+tnRQ78d97RtRuYpDXXj7aht/Nb8z+3bfjEDTqqzKuGGHj5U5w9mTx?=
 =?us-ascii?Q?RvR13NGmBiQ0SIrdYIAvoPmXuOXPr3atsg8kqe87ABKW5K734VVe27HH5p5w?=
 =?us-ascii?Q?sUI8RAzQLJRfZKCQ1HJg2Rh5Rt6cTpTfsPvY5Ia6OgM4AHIDI0nxHSg6+oGN?=
 =?us-ascii?Q?h8WpPiM+ejXYZSZuDUMlEgEXYWsTPBCs7hCscTQt7vi0kYHB5QeTdfXFTfXZ?=
 =?us-ascii?Q?cB9PrWO+ZGzQzyVvBSCuvwT/QonICb6v/z9SitOPQXJTexmT4iaz6xPeOGVN?=
 =?us-ascii?Q?BAeMfXJYIOTUcKeqZeahLzkkS1xsKWC2DdaQ/jy/t5NEyqHTeLvh8jegYtDt?=
 =?us-ascii?Q?PJseTga7XPMT0TIPeja5Lvx33agcpNEpTZz/wSotOfgQU29J5nVhcfQPG6Wh?=
 =?us-ascii?Q?WE+IVs720/3d02qj3smWV2ldD+EBNevNFhsQyxyyt3Sx/xfP5ZsWRp5t3sJz?=
 =?us-ascii?Q?kLUt6AELtxzeiC4EuLlQIZLew2ihcDZapGz9XvpNwe9EFaTT0zTlL8o0k5Ve?=
 =?us-ascii?Q?17F35+6aVE7yWkdGWVyF4ckDDJOUtUbmiy9SiWexUBTNbhmPgpy5BtAIlk0B?=
 =?us-ascii?Q?9YBOjOoiN3QK9ktypSAJ4OPBSdOI+NFb+FR1yPW5dqHI2pHXSvVoo97ftN8h?=
 =?us-ascii?Q?Y24rBfwlrg8Elq6nOYXzf2/DEwa6zivLX5rhVMNL+euZJ2DwhVNzEcvjz4m4?=
 =?us-ascii?Q?QtHmL3MOlpiPizqRpXT+WtrmXqr+Rwj1ixFCqbBxluCWj8O+KYf/sHdd/wix?=
 =?us-ascii?Q?KKKYueYXVaYgNcCHiVPGsTGHFAED98zs9wpCTgilmgPsQXW2rRRf8ArxSsJq?=
 =?us-ascii?Q?kjiTw41c8bMNRAVFo9sKIEC1Z2XpSOT4UpeUyX+5sNO8nN6lswyegu3uGq0g?=
 =?us-ascii?Q?iLjgoOA7TqfyUvNXGGJEIETrBY6zczwnJOt5ohflW1kfhZYPVSOvA839Ofz/?=
 =?us-ascii?Q?5bFkb1Kqby8PfHjfrQ2Rcc3LdvTPR2OpMG6vggrCGzGlhzozLSSCiCqvzmxG?=
 =?us-ascii?Q?vyTTtNTjSmapF5BgmMFmcCZlM2iDdbjhmP4F7Skg6Uv4vEQbt0Cd/mCTPDpp?=
 =?us-ascii?Q?UAdWtZ264yRvkMDTlJcKDW9dDiFAIjU5XS0BzrIyIS5OsDs0eT7m38dOUA1X?=
 =?us-ascii?Q?5JoFnIvssDqUO1lvGpK1RweuUXa/Rge61GAyZivCgEtv3VNFwSYGDT7Wi9Ew?=
 =?us-ascii?Q?Zgy7FthgSvxZZzzVqXlASUWJP3pRlsOTGJgVhVru1z/Qz4gUHUPF7BaFGxQy?=
 =?us-ascii?Q?eLYSOj4P+r8C2CvrvIK3PDTO9Fe5FHpmROtFOXfNcXCJPXPJL8FPH8k/ay6v?=
 =?us-ascii?Q?+udfxfYOhSgvzCif1GdBdDZ4kkLCOt1M/m6wLQByu2wuvNCumVSSAsPjioNx?=
 =?us-ascii?Q?lSmnyqHpyA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eefab57-5e9c-4dfd-a1b6-08de5fd029b2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 07:21:19.4703 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l2MPJ25exw4nAXXiII3WQyV+188c0eKvmMZ7Atb7nIVk3WqdirRVg7A8Mf7gxkcBKCf+WlpKasj2s/SKpVmGWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8207
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

Hi Michal,

On Thu, Jan 22, 2026 at 01:50:33PM +0100, Michal Simek wrote:
>Add a GPIO controller driver that provides configurable delays when
>setting GPIO output values. This is useful for hardware that requires
>specific timing delays during power sequencing or GPIO state changes.
>
>The driver wraps underlying GPIO controllers and adds programmable
>ramp-up and ramp-down delays specified in microseconds through the
>device tree. Each GPIO can have independent delay timings.
>
>Device tree binding matches Linux.
>
>Signed-off-by: Michal Simek <michal.simek@amd.com>
>---
>
> drivers/gpio/Kconfig      |   8 +++
> drivers/gpio/Makefile     |   1 +
> drivers/gpio/gpio-delay.c | 133 ++++++++++++++++++++++++++++++++++++++
> 3 files changed, 142 insertions(+)
> create mode 100644 drivers/gpio/gpio-delay.c
>
>diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
>index 60c5c54688e6..f69919abc05b 100644
>--- a/drivers/gpio/Kconfig
>+++ b/drivers/gpio/Kconfig
>@@ -1,3 +1,11 @@
>+config GPIO_DELAY
>+	bool "GPIO delay driver"
>+	depends on DM_GPIO
>+	help
>+	  Enable the GPIO delay driver.
>+	  This driver allows wrapping another GPIO controller and inserting
>+	  ramp-up/ramp-down delays on output changes, as described in the
>+	  Linux gpio-delay binding.

Add an entry for SPL?

> #
> # GPIO infrastructure and drivers
> #
>diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
>index 910478c0c7a9..fec258f59f52 100644
>--- a/drivers/gpio/Makefile
>+++ b/drivers/gpio/Makefile
>@@ -21,6 +21,7 @@ obj-$(CONFIG_ATMEL_PIO4)	+= atmel_pio4.o
> obj-$(CONFIG_BCM6345_GPIO)	+= bcm6345_gpio.o
> obj-$(CONFIG_CORTINA_GPIO)      += cortina_gpio.o
> obj-$(CONFIG_FXL6408_GPIO)	+= gpio-fxl6408.o
>+obj-$(CONFIG_GPIO_DELAY)	+= gpio-delay.o
> obj-$(CONFIG_INTEL_GPIO)	+= intel_gpio.o
> obj-$(CONFIG_INTEL_ICH6_GPIO)	+= intel_ich6_gpio.o
> obj-$(CONFIG_INTEL_BROADWELL_GPIO)	+= intel_broadwell_gpio.o
>diff --git a/drivers/gpio/gpio-delay.c b/drivers/gpio/gpio-delay.c
>new file mode 100644
>index 000000000000..0c0d05ccb493
>--- /dev/null
>+++ b/drivers/gpio/gpio-delay.c
>@@ -0,0 +1,133 @@
>+// SPDX-License-Identifier: GPL-2.0
>+/*
>+ * Copyright (C) 2025 - 2026, Advanced Micro Devices, Inc.

Drop 2025?

>+ *
>+ * Michal Simek <michal.simek@amd.com>
>+ */
>+
>+#include <dm.h>
>+#include <dm/device_compat.h>
>+#include <dm/devres.h>
>+#include <asm/gpio.h>
>+#include <linux/delay.h>
>+
>+struct gpio_delay_desc {
>+	struct gpio_desc real_gpio;
>+	u32 ramp_up_us;
>+	u32 ramp_down_us;
>+};
>+
>+struct gpio_delay_priv {
>+	struct gpio_delay_desc *descs;
>+};
>+
>+static int gpio_delay_direction_input(struct udevice *dev, unsigned int offset)
>+{
>+	return -ENOSYS;
>+}
>+
>+static int gpio_delay_get_value(struct udevice *dev, unsigned int offset)
>+{
>+	return -ENOSYS;
>+}
>+
>+static int gpio_delay_set_value(struct udevice *dev, unsigned int offset,
>+				int value)
>+{
>+	struct gpio_delay_priv *priv = dev_get_priv(dev);
>+	struct gpio_delay_desc *desc = &priv->descs[offset];
>+	int ret = dm_gpio_set_value(&desc->real_gpio, value);
>+	u32 wait;


Check return value.
	if (ret) {
		dev_err(dev, "Failed to set gpio %d\n", offset);
	}

>+
>+	dev_dbg(dev, "gpio %d set to %d\n", offset, value);
>+
>+	if (value)
>+		wait = desc->ramp_up_us;
>+	else
>+		wait = desc->ramp_down_us;
>+
>+	udelay(wait);
>+
>+	dev_dbg(dev, "waited for %d us\n", wait);
>+
>+	return ret;
>+}
>+
>+static int gpio_delay_direction_output(struct udevice *dev, unsigned int offset,
>+				       int value)
>+{
>+	return gpio_delay_set_value(dev, offset, value);
>+}
>+
>+static int gpio_delay_xlate(struct udevice *dev, struct gpio_desc *desc,
>+			    struct ofnode_phandle_args *args)
>+{
>+	struct gpio_delay_priv *priv = dev_get_priv(dev);
>+
>+	if (args->args_count < 3)
>+		return -EINVAL;
>+
>+	if (args->args[0] >= 32)
>+		return -EINVAL;
>+
>+	struct gpio_delay_desc *d = &priv->descs[args->args[0]];
>+
>+	d->ramp_up_us = args->args[1];
>+	d->ramp_down_us = args->args[2];
>+
>+	dev_dbg(dev, "pin: %d, ramp_up_us: %d, ramp_down_us: %d\n",
>+		args->args[0], d->ramp_up_us, d->ramp_down_us);
>+
>+	return 0;
>+}
>+
>+static const struct dm_gpio_ops gpio_delay_ops = {
>+	.direction_output = gpio_delay_direction_output,
>+	.direction_input = gpio_delay_direction_input,
>+	.get_value = gpio_delay_get_value,
>+	.set_value = gpio_delay_set_value,
>+	.xlate = gpio_delay_xlate,
>+};
>+
>+static int gpio_delay_probe(struct udevice *dev)
>+{
>+	struct gpio_delay_priv *priv = dev_get_priv(dev);
>+	struct gpio_delay_desc *d;
>+	ofnode node = dev_ofnode(dev);
>+	int i = 0, ret, ngpio;
>+
>+	ngpio = gpio_get_list_count(dev, "gpios");
>+	if (ngpio < 0)
>+		return ngpio;
>+
>+	dev_dbg(dev, "gpios: %d\n", ngpio);
>+
>+	priv->descs = devm_kmalloc_array(dev, ngpio, sizeof(*d), GFP_KERNEL);
>+	if (!priv->descs)
>+		return -ENOMEM;
>+
>+	/* Request all GPIOs described in the controller node */
>+	for (i = 0; i < ngpio; i++) {
>+		d = &priv->descs[i];
>+		ret = gpio_request_by_name_nodev(node, "gpios", i,
>+						 &d->real_gpio, GPIOD_IS_OUT);

This will configure the GPIO as output and ACTIVE high/low flag will also
be used per my understanding.

Should the dir and value be deferred until set_value is invoked?

Regards,
Peng

>+		if (ret)
>+			return ret;
>+	}
>+
>+	return 0;
>+}
>+
>+static const struct udevice_id gpio_delay_ids[] = {
>+	{ .compatible = "gpio-delay" },
>+	{ }
>+};
>+
>+U_BOOT_DRIVER(gpio_delay) = {
>+	.name = "gpio-delay",
>+	.id = UCLASS_GPIO,
>+	.of_match = gpio_delay_ids,
>+	.ops = &gpio_delay_ops,
>+	.priv_auto = sizeof(struct gpio_delay_priv),
>+	.probe = gpio_delay_probe,
>+};
>-- 
>2.43.0
>
