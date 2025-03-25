Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBCBBC35FFC
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 06:42:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C4D780F70;
	Tue, 25 Mar 2025 07:42:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PzeLNm9W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50212810E8; Tue, 25 Mar 2025 07:42:56 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::62e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08FD880EEF
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 07:42:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=whEZQF08iW0fy39LhHDWMdUEegj58z3H/qiAxAPk5UhiJh8TslHf2Xq4mlxm1VfMev1blaKbIu2VIDmu41sS54Nh+qPON09Aw+W45mEBW6wA6VPWbk8ottFfzbepK2MNERKLSB/Cj0Ck/VTk4OWGyhPP5YUiymcxqh5WuX9wZffYm8fAYwMQE24fbh4FvhT/CNjPxq/i7+5PoOz5IUXssl/7GTcCohf+0StotMuCGTDn9lsfenbrYydlT9NubR9PyDcpohzPX7ufXmvBJ91NLrRS7gZMwW9N5K6AhUpizwmLVCfmislGKkB6QOM3kmDldsdL8akHLCFSEbqsJ5TAoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LuSHXgYLSNiRuQViCFkMDB9XHCSJS9tJ1mtBHP5Gqgs=;
 b=gCfo2tZeaZFr5MX/upGW3eTwlwQeq+C11oL3iaAjuEJzs/m7MUo20Jc1AqXhaP4kW1ScMMUCOF2GAs4sUhrrgRaHZ0otpORvGkbX/+ViTA617b58C4Fjxn2KQEmmfwc2gbvpxemnJNUy8ynVRzZpa1hoGI9JO0e8bqfS+tAbkkhdzpsz0hIJM7xpD7GozJxBZn4ZYaPYMwAjZfM3ocqKm4Wom6IImpK0YNPCdOu/mb5xqNDjg43Xd90nmDX3GMkaDjEZiK5gKqexc/O97eRYl6kbcZF9NV4Rg1x2Mo6+mzUwX737V9ngDabqehAcQnqCnRoa6Vxu8CZArfYUrIp1Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuSHXgYLSNiRuQViCFkMDB9XHCSJS9tJ1mtBHP5Gqgs=;
 b=PzeLNm9WSjlCmPG4daMG7b0ETU8scVd3yVGxN8iB16Ys+KCx8QLQ5hfOOhljO+LdvYLOO3D0HTPglfnIx7Po19WEC6Sr8uiZ5ZX6URUWQPZ3+9EafRPmoCCuHecNGIn+TZOI4qiXpcRbFFdJ0aPaQnxT32JMA9IgVus/Z14mjxsKx49foL1HYXjfn5p953/pimE9y2J3P6SBiZtSyfZvkDU+1uwyDYPZ3ypaNRL0+0b92esjA081nr/B6zbBJWit9hdbd5rybt6K6hNkHLJM+vQxyO6RHVmbLbiIWC2R0ZxiW6LgyUT0NJoI3ypzphYYob1S5oSKTUeBOp5dVg/xtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10734.eurprd04.prod.outlook.com (2603:10a6:800:25e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 06:42:49 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 06:42:49 +0000
Date: Tue, 25 Mar 2025 15:50:50 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Adam Ford <aford173@gmail.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@denx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
Subject: Re: [PATCH v2 00/24] clk: Add clk_resolve_parent_clk() and fix up
 iMX clock drivers
Message-ID: <20250325075050.GB27303@nxa18884-linux>
References: <20250323160107.145749-1-marex@denx.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250323160107.145749-1-marex@denx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI0PR04MB10734:EE_
X-MS-Office365-Filtering-Correlation-Id: 94ebdd5a-7bc6-4d76-9dd3-08dd6b684261
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FMQgt/lhhqC8oyWLPK1lqBxzxIy6AVGEUm2HxndRRznzL5PbF3cyjHLdbp4Y?=
 =?us-ascii?Q?rkQbfPLRE8EFV2H7lMeMHkPjokgoBS+Xd2Y3DubPtqq2Mss+YW9MBWk74ZWp?=
 =?us-ascii?Q?BK+JIrNlYr6+vD1UQfbYfflmD4m3lifuRK0sK/h6MO2zcXrYlqNYn7kXPepC?=
 =?us-ascii?Q?u6Wxf+L5AcaZBUX3I0Hb6y90jAmkn8JHPHrifT2cZgol3BM3maa1wFkjJ1Ol?=
 =?us-ascii?Q?imavMt+tDrT4nUh3j15eRS63q+A9iZuKvrrsf34S5kjlGOwaBncv+YSNgP9U?=
 =?us-ascii?Q?Dp/4Ji4T0whaI7eAYDLE2xFnuDzwJWzcb5aMCHn04wnMTgemXtFoY8dFjUns?=
 =?us-ascii?Q?LA+onDyzktHiQivk2HkHtyF5XL2VKeitKEYEjOk7/dJuMZztDcW5kxkX0zUx?=
 =?us-ascii?Q?IlPaCYoucvU5m+j6Knvk+tpm2iahGf1iH2Apud/2KunKh18opairCj3J7k/0?=
 =?us-ascii?Q?0m/crFqqD+HavrdmONracsPRXskPA9G2NzzFa0O0O2UqP/usrDEbVHyO8bTr?=
 =?us-ascii?Q?xATwY2h9Tq23wcJWWqkWbYjcboh0hQMO5eRCCuBCgkXUS9blCtU6HVEWYK+g?=
 =?us-ascii?Q?l7YaNDogSurdJyUBy96r932EgM09jPqTMN3EKwpgfnNJHWZ+fuplXEq8vJk2?=
 =?us-ascii?Q?t+iqPzb01n0Njj9Dho/E2DV97bqSiJHNoowOR5kljTdU9CkzSIcZo7Hqvgos?=
 =?us-ascii?Q?7uuUc8lq9HuHn0SDq0/I+3X7lglG9VuDpI9T8gzKI2I4o5Ix5JHJPrzL75Qo?=
 =?us-ascii?Q?xLbNn7dlAC4vgyuCu032KAobZkuEm/X9tsbQd1T92zkECPV/xvzvmwvsSW9Q?=
 =?us-ascii?Q?b/ELRg44aG9vq2ckUGHYS3R5ZcYEtrlyeXcMVjOwSw7S/NiVC5+H2GPFxGv7?=
 =?us-ascii?Q?EMYS92+KlTghaPFGApXj8tt0Q1KGLHBqP2F6EHdg15aDSYmQ21cdVCJoTy/h?=
 =?us-ascii?Q?vl1ZdH/Lsokx234UhEXga1WzP28EDk6XsXeNTa1COsHMXlRZCR44YP6R3x12?=
 =?us-ascii?Q?fYcHOuzDJr1889ZeRDxiZp6xsmUwU8Ta4fEvKKUx6oUZbjiiWCS21u96nNC1?=
 =?us-ascii?Q?SWCsQBcamUz+UyzS3Mo7jAg5dh1BmyTIGEHMVr2/5hg7IN/1sBfOQ3IcO7MA?=
 =?us-ascii?Q?XDCYuQS7ABp/Qw69AJloPZmrbPPx5CzeDurCztVNu3DtupAB530all9FLDhe?=
 =?us-ascii?Q?+pyVKrEO1QihKyUFk6Q8WxsRbE9zjwCU1zqKhPSC92MWcZetuA1OQTc1jLnI?=
 =?us-ascii?Q?5KNdeXhXXfrhv+6movCEmN3AL+lw9dS67imQw2CUYxnN2XLQPiB7NVH41zCt?=
 =?us-ascii?Q?/DQMw4/J00kwIaJh9KJY8F6woh0e+qhH7haLQ/ZOiMFPcXnBWRPKwQ9WbeLF?=
 =?us-ascii?Q?QIhhx6Im4qzYtmc1gLOocBm2/nw1iV57qPYLgrhVFEH8udn3eGFkAVvCHNp3?=
 =?us-ascii?Q?u8rRTi9I4Q5lxjCXZjAnz4br4PhYc6Jl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W+kLtanE1nqCHlkCEdMus3xvWhDezi640WCb6cCQGbVIXK4ObV2hH4JVbEiT?=
 =?us-ascii?Q?ec6GL8guz6GcuUeUIL4ZxC5oIl4pZlP16QLGDD3FdvZFuTLpJDzIBtwp1pV/?=
 =?us-ascii?Q?i6yXm+oJ77UBDN9OCZs9+vmXJISLyRFW86ywTWMeS8We2PO9PgM/K8hpuSJb?=
 =?us-ascii?Q?xzozayEhZZmqtaYBQZS6rC74YtijeW0ikaWCosR4IJIEkGGl//GoQAD++vmO?=
 =?us-ascii?Q?iQbSFlu13bCZiYZeuXK86fjaZTx7swfyi2CGJlYnl4ctagPfSUBbJ2rxSEED?=
 =?us-ascii?Q?J+wj9BBtiyRLUJpCe4TfCG7qyg+gfMK/ddOjF9LR1N0FcbFiPP1tbpe8z9M3?=
 =?us-ascii?Q?8pVbkQ5v2nmH5LKun97LOjjE0hWV9g1h7QfADeBVswkctXjAnj7I6FtlE6WF?=
 =?us-ascii?Q?BD9gOQHnyiEtAHi03BhMHUCbdmrmep11jcrfUrqg3/dIoBzvyeUDRVIHV7li?=
 =?us-ascii?Q?7f8ol0IQbzTUdFiixmVRbgnZW3REuzeXdg1YX1D9opPRM//10Fv8gtISFsMC?=
 =?us-ascii?Q?Fj5cf9lFnQGaDEDWl/11vCHpVq7NS2MHbTEb8WOwbRPCUeQFXuzCbb/Z+lvf?=
 =?us-ascii?Q?VX8HyHVVVOq8Zkjq6UZibuEK184wY6HmI6dKDa/eIkkhkWP3b3tGQyN4ol2w?=
 =?us-ascii?Q?Rn7oX36GzfdnNAj6mowFpWCVL1yl8yb/03WKJfkV/2TtV9bGn+C2YH8W6xVg?=
 =?us-ascii?Q?KwmQKE+wMJB2AkwDNk2w5E+H7KrVqZyYq/jX61CZW9l/4xjiQtbrf8x4OLDX?=
 =?us-ascii?Q?uAOf0AyIVZM7DzYnmwTFcIKOS2RvEkbmQQnNDluUIJwaGOK0qcUsxKKBrRk5?=
 =?us-ascii?Q?mGQt2nF4joPb6p6rwaWDZchR4irWNppOh5ujDckqQgfct1J0WsDXm5FyZ6mP?=
 =?us-ascii?Q?GbysiIiBMKGnmZjxnv56mdpOb9u9eeFOk5VPQedl98JMSswpfuyPNh6dQXSD?=
 =?us-ascii?Q?U+6olcxeQIchgXk6v1LXtnFmhEMysFlfXpmbZJ2EdU/Sc13+dTo9KMxiSOga?=
 =?us-ascii?Q?yN2sX1pw0AqyeroiZiJbIL3jhZafLmKR9BRDb2pkGeF7mV7PUuHqzeK6hi2d?=
 =?us-ascii?Q?xtTViPsqKl6yreZIRhjl35T1IWopRjeBKE70uLLghNI32cIyCM4Y9oyKra95?=
 =?us-ascii?Q?w97V8LjJcUtRoOtES1TpgFo08rnwoSZIWyeznBgz44CZaWL/vl4vQainsF5I?=
 =?us-ascii?Q?Jh/wKDoYn/KTYhs94urqNo+tLGtC7r9b7fV9BrP6BhJHTxDZmkhuM+GPklMI?=
 =?us-ascii?Q?vA54SuqLpBzKLy8iJ2sA0lMJmrdJHGXr6MGc/UFE6CLCspseqA+3q5vBVANH?=
 =?us-ascii?Q?gIqOxJxcd/weoNwsPa1SPCKZqDL0HB6dVVcAuZKyzH6sGyeHbd6qUXIfyGrV?=
 =?us-ascii?Q?M7v05KX/VEbL7TOBrsRo5vRJlZmlQOzwCj0yXC+2lysRGQt3fpSLYMw2iTdo?=
 =?us-ascii?Q?gc11tU+LGXOyZxpLOm3ZuzF12rqi9iu5aMrrz1fLTTFbJLBza6X7zhwFJOvO?=
 =?us-ascii?Q?xwxAxl/ZAfdRNG5DXoJpm1hlUyQ2cOeEmQNOIhULeBvZJ28KBCetmokBr7ER?=
 =?us-ascii?Q?Z8cXDY3v0rDVtoyuao5nLpDucu2DphYJJQ0GXhkD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ebdd5a-7bc6-4d76-9dd3-08dd6b684261
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 06:42:49.2696 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ULfFdmeMZC5VfDIgwJLsrMwC696rm2TnwDy9z5LUeYZeGa/H0B4yOR2EkZncRQUVQGaxpSkXXg+mAthdqwulEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10734
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

On Sun, Mar 23, 2025 at 04:58:29PM +0100, Marek Vasut wrote:
>Add clk_resolve_parent_clk() to resolve parent clock udevice name
>based on clock-names DT property. This is used in SoC clock drivers
>to look up the clock name in clock tables, which matches a clock
>name in DT clock-names property, and convert it into udevice name
>which is used by U-Boot clock framework to look up parent clock in
>e.g. clk_register() using uclass_get_device_by_name(UCLASS_CLK,
>parent_name, &parent);
>
>Pass struct udevice pointer through the various iMX clock drivers.

Thanks for the effort. 

Acked-by: Peng Fan <peng.fan@nxp.com>


BTW: this could only fix partial of the current clk code.

The current clock framework is kind of a bit mess. There is
more issue is not support multiple clk provider, name should be unique.

I was thinking to drop using device for clk, following linux clk
driver to use a clk_hw structure for each clk.

Regards,
Peng

>
>Marek Vasut (24):
>  clk: Add clk_resolve_parent_clk()
>  clk: clk-mux: Fold clk_register_mux()
>  clk: clk-mux: Use struct udevice instead of struct device
>  clk: clk-mux: Resolve parent clock by name
>  clk: imx: Pass struct udevice into imx_clk_mux*()
>  clk: imx: Pass struct udevice to clk_register_mux()
>  clk: clk-gate: Use struct udevice instead of struct device
>  clk: clk-gate: Resolve parent clock by name
>  clk: imx: gate2: Use struct udevice instead of struct device
>  clk: imx: gate2: Resolve parent clock by name
>  clk: imx: Pass struct udevice into imx_clk_gate*()
>  clk: imx: Pass struct udevice to clk_register_gate*()
>  clk: clk-composite: Use struct udevice instead of struct device
>  clk: clk-composite: Resolve parent clock by name
>  clk: imx: Pass struct udevice into imx_clk_composite*()
>  clk: imx: Convert clock-osc-* back to osc_*
>  clk: imx: Pass struct udevice into imx_clk_pllv3*()
>  clk: imx: pllv3: Resolve parent clock by name
>  clk: clk-divider: Use struct udevice instead of struct device
>  clk: imx: Pass struct udevice into imx_clk_divider*()
>  clk: clk-divider: Resolve parent clock by name
>  clk: clk-fixed-factor: Use struct udevice instead of struct device
>  clk: clk-fixed-factor: Resolve parent clock by name
>  clk: imx: Pass struct udevice into imx_clk_fixed_factor*()
>
> drivers/clk/clk-composite.c        |   4 +-
> drivers/clk/clk-divider.c          |   7 +-
> drivers/clk/clk-fixed-factor.c     |   6 +-
> drivers/clk/clk-gate.c             |   5 +-
> drivers/clk/clk-mux.c              |  47 +---
> drivers/clk/clk-uclass.c           |  18 ++
> drivers/clk/imx/clk-composite-8m.c |   4 +-
> drivers/clk/imx/clk-gate2.c        |   5 +-
> drivers/clk/imx/clk-imx6q.c        |  80 +++----
> drivers/clk/imx/clk-imx8mm.c       | 254 +++++++++++----------
> drivers/clk/imx/clk-imx8mn.c       | 246 ++++++++++----------
> drivers/clk/imx/clk-imx8mp.c       | 348 ++++++++++++++---------------
> drivers/clk/imx/clk-imx8mq.c       | 226 +++++++++----------
> drivers/clk/imx/clk-imx93.c        |   8 +-
> drivers/clk/imx/clk-imxrt1020.c    |  42 ++--
> drivers/clk/imx/clk-imxrt1050.c    |  78 +++----
> drivers/clk/imx/clk-imxrt1170.c    |  30 +--
> drivers/clk/imx/clk-pllv3.c        |   9 +-
> drivers/clk/imx/clk.h              | 116 +++++-----
> include/clk.h                      |   9 +
> include/linux/clk-provider.h       |  10 +-
> 21 files changed, 783 insertions(+), 769 deletions(-)
>
>---
>Cc: Adam Ford <aford173@gmail.com>
>Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
>Cc: Dong Aisheng <aisheng.dong@nxp.com>
>Cc: Fabio Estevam <festevam@denx.de>
>Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>Cc: Michael Trimarchi <michael@amarulasolutions.com>
>Cc: Peng Fan <peng.fan@nxp.com>
>Cc: Tim Harvey <tharvey@gateworks.com>
>Cc: Tom Rini <trini@konsulko.com>
>Cc: u-boot@lists.denx.de
>Cc: uboot-imx@nxp.com
>
>-- 
>2.47.2
>
