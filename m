Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28AF2C5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 07:11:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B978982CF5;
	Mon, 26 May 2025 09:11:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="G7GGiryA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E43B182D06; Mon, 26 May 2025 09:11:48 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::61a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DB6482CED
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 09:11:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1TliZWkD+5i56e4U2J3MQ7Ny+s1mpE+mLOJ1MghiBcBZqKHz6aVSgsIaEVzHBDb9esWKIm4S3sw4/V2zUPM0z/AHk0Rb8YCgvneojfRxO82A3N7MtXLrZpTmefcTZn3AaQ8NycSvJHRx8wYKVsqEVzYV8uodkb0Ahds5ahyV8wLm+icjQ9S9T1AOHbE0CayAxl+Vwp3T1SHpHBligUeRKqJKaPZxBbDLnMN9IZ0M6dL0tfk5xs7W9FNnl6S1FgEpm5/CKKsdA/1jUdTxh6K+n6srd7bWHkGW4b4HEg08DtusKJGrFDTMrWyRKJz0Sj6Tel0SFMoRRs/xlBFw/qC6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8JHNI0t+Gl1bGsx25pUw4IQyBd7WULju0DkdKm4qAs=;
 b=ZQujo8tfdilwJyUyuSwBESw9P0NCQzCBumHiYPyZx43TDEVwPigna5nGKpgzkCwp/xOGqX42n8fJbY6KwtP3dR7axXUGytcc9/hpRwNxLGCL8lmLGUyOziuN4Fvg6uf13QlyuCMVlNj3nNb+vAi6VJtObBSKIPBD8djd1VDe/KLnm+Me+EzlhR40w/WUlHdS8I+lUzoy2Puafqummmxf6TCZcXhhg2Gh0+of+lIhQnAoOIaT7CfM7y8GKDWhG+WuIbJ+klugbSoOPcxandk/goH+ftdoc2Pu6vxtDfFLy4ZlMUK/aJy4cJT3/lDHEZqbDRVOg04nW/x/Pn+PJJMo3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8JHNI0t+Gl1bGsx25pUw4IQyBd7WULju0DkdKm4qAs=;
 b=G7GGiryA17UL+YDhrgdMoQI/H/J07rLHcdo4VaD/VMvGZMp72DxWBQZsakLH7uR9Ou8YtTqqG/XaM3iw6hEpQtaZkapE4/FYYhAW4VkIzMJTcxU7qBwU3MP1+c95LSUF+/0PEig3TXaABOs4+Lv4xChX+BtJl28l4dlw2GZk857dRljsz88N5T4bwCqcjzwoOmuv7c0A7Ekkv4Obn1nit+1uSNYbKVzp/OzZA3NoNj/2QF2ZCsbAfPZFLPIfRJwuC68Drn38OFuf9dtXQ2dA8KpBDS1uqsDvVqXkGr1QSrPwr7zPvp2ziIuGh83DBZ8vToE9QDd0bTNxTXt/E9CcAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB7570.eurprd04.prod.outlook.com (2603:10a6:20b:281::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Mon, 26 May
 2025 07:11:45 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 07:11:45 +0000
Date: Mon, 26 May 2025 16:21:31 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
Subject: Re: [PATCH 01/13] configs: imx8m*_venice: enable several commands
 useful for scripting
Message-ID: <20250526082131.GO19264@nxa18884-linux>
References: <20250523172018.4164647-1-tharvey@gateworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523172018.4164647-1-tharvey@gateworks.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: 6336fc69-8efd-4201-1bde-08dd9c249297
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|7053199007|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CcgGBxIDHyTqQHiKTTfmE9CiLyW9oXiqnbQoZis2OBES238NoGa+CQbBSiVU?=
 =?us-ascii?Q?GgVz6bICx1CWJqaS/o48ErGTXYOUvKvJkFd7ZIL0oOaYUHpvRXkSAer9mQcq?=
 =?us-ascii?Q?kcBm7V08e7IMD6Mvc1xSxFziQmPdvRejwl3LH6e+kTuxuPiTdaSl3eDzbJVx?=
 =?us-ascii?Q?XWt05ap/4DHFpUER01jLK/jkkFH3Ugxx+P6ntJZ19Zm271YBz6CbwTjRhVnH?=
 =?us-ascii?Q?RkZGq0r0mr85eiSLnPJCbwF29dPFBX2firJqwWnOUVsXJF/fKGdLKE8bFpOv?=
 =?us-ascii?Q?ZC4bqTfwZnRo/UpB0rqwY4Mu336Qn0puH65pd+3/Fj7Fihd6XpGT3kJHmJmK?=
 =?us-ascii?Q?jgLimaMl2b20BdfEySd7+y7ZHjsqaMvdC+1mNRXF5lURFLev8xyAWwpkkGI1?=
 =?us-ascii?Q?M2y5Bhb/r3CGSuspyLskiTANatLW91hpnzZEjLn+TjM8j3KhGH3WbOYloKva?=
 =?us-ascii?Q?A9Hy8ctYvX7y0PQf57jxEqXAvXldwILeetNXbPG0J9ezEmQD8kotNg4DvppO?=
 =?us-ascii?Q?I/+BbVRtgTQ/gd3vh26hDJb8F3OwL2SR5LXJEAHqS50cr1hN/YvbYQSk7K8o?=
 =?us-ascii?Q?fTznLYkUk1xe2cCUABFHv2Uw1+5D+gaY/Y2AayINNWqiu4a/745EnYG+sbSx?=
 =?us-ascii?Q?BqyjDGdmy8Kj812IZm/qKw5ZGT4VMK5Hx/w4P7AhkMClrHeTSKroyasaVrsV?=
 =?us-ascii?Q?8wUfrY+Z/mqVkN3Eou/oAlcgyGL+94YReJYwZEvUl1XhzUELI98nIjr7yfWK?=
 =?us-ascii?Q?KDF3ImDW2Rm3KkBWvl+Q6OClFdUVJSqH9ucLxVDLS3CAa9ZbdMTCzLWkXwL2?=
 =?us-ascii?Q?9S5eENTTqbq6CaLhVct95NMzeOtH7r8f0hxJe8U4cjr8GrHDwA8JbzSsgxKR?=
 =?us-ascii?Q?i9OgDBwppRa0AB9lR+yhpX5SvMNdjaeGljQ/oukg/gh0pAl2NXrBmVwgRsz/?=
 =?us-ascii?Q?Dz19XtAZpqs3WLORIxI64RXVn5OkCiHZKTo96gAzol1VEgIC7jdM+DkBlwA1?=
 =?us-ascii?Q?Mwg7jnl8d5BJavFlw9GbzBn6cMgVpYghukf9uP56T+otxR9xkfYLtCLgE01w?=
 =?us-ascii?Q?9DLrLYhWeyhjxWansB7nJXioPaaapctulKCd+Jz3b9RTq/n1X5BoreKg8S+6?=
 =?us-ascii?Q?1mi5GKqOpWOtnn/Pr7+h0TN2eaT7nNjY/BNFKk74S7JPpP3lYJtH1v5TEq19?=
 =?us-ascii?Q?uEw30Gdp5cPJpOXHZ5T04I5y1BqP+Q1I+SWcWkcp07QRDJQeZTS0IN4nkR9D?=
 =?us-ascii?Q?oyByb6p4QS0in1OJKI3Gt/zuEX6vnF91nsKnpOYyTrfi2nkfchUqOkrD3tl8?=
 =?us-ascii?Q?qIv/yp1yPYOPXNZNxPZPOw9jjHRCBr8NRrJi8/SiGqEVw07tuLADyMcPnVQf?=
 =?us-ascii?Q?aHJPSPCcpcWOeYI3Mp0Y37MAvnfFy8XhYZrLkNWwWcU9X258qhfInxrNoV4O?=
 =?us-ascii?Q?LPQmlXcrxnjGzpJ8JxSubpO8GLdZLLxlkZM5LLCifOchweoHC6gjaA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9+MRrP/xigwXgi4G1WsDcplivzn5sR+lknR5k8ZpIu7MSByDCfkM3Lel+/LI?=
 =?us-ascii?Q?/+iX7IVWhGXYEanfu0e93w/cWEcQKpLjFdDO1KAFdzsrL0u5dk475oj3bGfY?=
 =?us-ascii?Q?pZD/MxCqTbpEOrm8HMmC499ZS1V8GGI9jg1SbPwtIef3KJ0pRdnvl8LDE4iI?=
 =?us-ascii?Q?ImO0RdjNWc7CFWXl+vNIH45J77MOuldI/nO5wyEwpvw7FHfO9oq0EoDQb/Uj?=
 =?us-ascii?Q?5rhDq23l7dY2Wzd87IxO9jAVsBoK2XkvH9JJpPPcFTw7MRVyTezxTuo1vqEO?=
 =?us-ascii?Q?5zPrpv0JapbgpWGhzWJ78ikqXeGORxUoS1WZFGxHRje9PSXG0qzkReHDeOkw?=
 =?us-ascii?Q?pnfcR9OA+3jCeb9yPJ/7fihFADN3sJuURceYIuZmHLG7hZtOcTi1VPo7wUof?=
 =?us-ascii?Q?QctoKO6Om2yBxCVkgETBQ0Ojd8xROTKjw0GfpVQ4dILnGTMexuzanaHW6Luw?=
 =?us-ascii?Q?n3vApxOzn1tdy82SqT+HqIOt7K/uwF6m9sWbgbJD5rQHxlkXzxHf/KwZi2iL?=
 =?us-ascii?Q?+MhyOCQYxd+yLy10hKrZVIWOUQGN6teNxN7q2LYHhaNB0sFN7jjdj1lhRx/t?=
 =?us-ascii?Q?Zxd/Y1XgIWmUs6Pw4aM5FNxjGG0nnF+xSLdXR0xVOl4eO5p3V8RXX/bsvfR1?=
 =?us-ascii?Q?+acE5zQxqoxsRpaK/5+/ek27GNH34+ho43ux6C29LMkR0yUsdfsH5DEXkYZn?=
 =?us-ascii?Q?i3FuN1WEluXk0AIoZhSx5y6nLlJKmnoJQjDtH2VKWBWSblRX5FcUk82M/AqD?=
 =?us-ascii?Q?Unm2qQoY4PKInC3m1o1ezHd5/dIhLHr5VMdbNCiClTIAolihtkbL7IuO9L/H?=
 =?us-ascii?Q?+r0e+7nenaDr5DZAjjc7Yfe0eA0r4ZV7v+utLKGe4LDUoopPsahQUUFsy4+U?=
 =?us-ascii?Q?Ddd+hdWv6NqK+NIQuCcSKt5D4hOxrl+o71Raeu2YuPS04QAircpEZgPvZojN?=
 =?us-ascii?Q?Tfw1rDbvNWanE0hoAnsvvs7BW1p0uhO8ps764F/bue3Cs1udcmqShSVTDRdK?=
 =?us-ascii?Q?rW7eXKS2Em8D12wG87tDExIU2Wm5ffi1aC5eIaCe4sE87No5OJeENEXWh7oB?=
 =?us-ascii?Q?GB+MAQkk0WCns7ac+6v4+YW+g1SyeSIpixwF4hmMBf1YU+KjvvAIz5olCWLA?=
 =?us-ascii?Q?EB81wDnv4LbCknL6Zi9wRWcrO3i6sUjqbUQKRWSHDZFnhODQbD5heuo5ZD3G?=
 =?us-ascii?Q?HxhKDNYtfxxlBLp1S/ZucSeYi7DKPAyOB8FQ2R9xF1jpPvkmBKu0wGQVaXp6?=
 =?us-ascii?Q?Ki93f5Vi459CSIPGfrfFiqhQ2ZCLp7MrM5pClbV5PWW5bdslHtF9tKuCnq0u?=
 =?us-ascii?Q?PPr3CkaPcGouNSVYwypfSKI5onCjgGapVqc8eId5Yv7CJ18aBJlAPtrH2zKj?=
 =?us-ascii?Q?4u+NRHAG0ITkq9vAvKgSbgRGxZ2FFbk/R8OA6tWxOQ1x2HMWE5tk8U9+neD+?=
 =?us-ascii?Q?zmc4we0Hc1AadsytY2UWz4x+aTRnWaHkS/6GOPEZ5rBNO9eYuKV7QO6tsHSG?=
 =?us-ascii?Q?uiqaMQ0byYoUkrMl5oPE7lBV2cOy5PUTXiAK5hFqsUMR5C3SzxYGoxYdL/cw?=
 =?us-ascii?Q?L7Tjd6i8pklFd9KEMX+aDY9NAWkxbVuynRMl/XJ3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6336fc69-8efd-4201-1bde-08dd9c249297
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 07:11:45.0063 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zArjsozeaM4q2cZ+tQcCAOgktrr4PhS52h1Nm90sSiJ47b5ujqCu5cXnriW6n9PkChz878OQQwuo+TxrL9hc3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7570
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

On Fri, May 23, 2025 at 10:20:06AM -0700, Tim Harvey wrote:
>enable cat, xxd, and the ability for setexpr to return values in
>variables which are all useful for scripting.
>
>Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
