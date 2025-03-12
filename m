Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD5AC28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 05:11:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEC5A807D9;
	Wed, 12 Mar 2025 06:11:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RnQ+JAZQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B579780F92; Wed, 12 Mar 2025 06:11:16 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::60f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71FEC801BE
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 06:11:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WvrE7cvQYCojeNjr7ogbHakW4/s0ynbVmMZjXht8HUb0wXSYKgvnk6KFD0xJN7u0dJYH37iNuIOU36lH2vHpFJbmGxlzkl4o6dtYfCIl0CaQWCMg3FUGfLlwuNDXQyLEs941rmxsS2rmv/e5fwXph9cgxLz+FydG2YlHSgzlJ8LWPKT9vu2VPguyV0yr7nSUpHqW5C4jZ+Wfx8wdizQqCj3UQXtx3VXlJeG6wVrkixu2UUCuw1FNOigSOBkk3I7Qwbv7F6WIeyku1/g3JoNfOg1pxe+FsY/tdOV+MH9jaDxJUAb/tsdG9IKWVgfPzCcMwys4DOY3LaW41thVAvwGPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TD0IO1IEoocwVk6Hm3ZioT8h6zcyySqJ7endoOQbdpg=;
 b=dOHmIejoYdS18yxBiTDe9PLV0k5VyObzHtsG6Ji/UaF48JvH8Fc32oDTbIKVWmTU6vB12iOkqhccOA98HwLVLjyW5LoMdG/Kgo8AnMFshImjoeUP+bsC0k8/YTvQDSOTfWUC5i3ndfa0dovY1gBocZCpZSgkZKHe4XKeWrNu8YXwq7yb9akWTFsjFrPvsrJ4X7/BCW+7UGq4kW6hrgaoCq4584YjciPDZlrHikGDJUjZsoVQL86BqzHQp7+4LYe4fYW3zPFdGSwfdqqonETtvSjuoPGF0Lg+ajN1QlxfEwNtZS1zuHDS8p97ZuA7LK7aHB/93+wz0eSkgiZFdiLw/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TD0IO1IEoocwVk6Hm3ZioT8h6zcyySqJ7endoOQbdpg=;
 b=RnQ+JAZQZKpdIUY1L6jiX5wAcV8ja32GEtjL86hku2jl9N0nI1ITEq4VXn01ozimQuCco0JnNW87AR4TyS6+5hWNJvTfW1bdii5pebg6SqhuEuFa06y12GYuw5SkHdRb1C7maDj5n/e5h2giQkbZIulLWW5SJZuO7qx2wilrUAVBGulq67sjv1ArCZJyYWuVAjJvUyqdgjvW6Qj+PM6gDVgrD6BnjU0FDFYLmjxHbnacYPxPTjWSsDEjGBrH7BsrzBMLNMTDuTqLRjeaJAW5N8cO0yJeXBj13pJHzJ7H0veApGuEBCuFcoWaYhLEqWN9rrfcu3CetCkSOw53cegWfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB11020.eurprd04.prod.outlook.com (2603:10a6:150:227::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 05:11:11 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 05:11:11 +0000
Date: Wed, 12 Mar 2025 14:18:47 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Tim Harvey <tharvey@gateworks.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH V2 01/10] clk: imx6q: Properly handle imx6qp ECSPI clk_sels
Message-ID: <20250312061847.GA11991@nxa18884-linux>
References: <20250312003041.110023-1-aford173@gmail.com>
 <20250312003041.110023-2-aford173@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312003041.110023-2-aford173@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB11020:EE_
X-MS-Office365-Filtering-Correlation-Id: 94eb7278-4e5b-43e7-04e9-08dd61244e31
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|7416014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FIchdcFmufI7u5mV3rD3tlnSdrAsPNWo8zdCLUBEbQoAhhZCEjMx+jGeAHKZ?=
 =?us-ascii?Q?2KeixQDAH27MxfabQ0Cs33ZwLqIJorb00L1axYkxrm36QvItD3XhNuCsq6Le?=
 =?us-ascii?Q?5Q1VL+0I9ZvOnurSHRGM3iK74Srg5dqbaW8LEOLX03Xvj6W6q/1vAlOLLIhR?=
 =?us-ascii?Q?a1uGmu4sevORsTXKsRbcmZPR45lI3luYa+z4tSB9w4JeTADuu/IniFDsKGTB?=
 =?us-ascii?Q?t8VsBGJN7Kt0yCa6gjtuKbZzIIh1HuJUwCajVT2YN1NrtN2VyN7s1Xqj4qUh?=
 =?us-ascii?Q?e25kg/nAFCps7rMce9TyjFp9roR/61Nbov1xcwW3a59gxnj4rp1j05R/47q2?=
 =?us-ascii?Q?N2TcOOpYGYyenP1NIdj6GjC28ExFfV8xamid+U9wWiDtlWS3NUM9zWdFngQK?=
 =?us-ascii?Q?fDsxsJ298xr4ROOIjFuooaqvwmjIJFmAPtukL7vXwgYMcUIsE2Kp7Z411oVS?=
 =?us-ascii?Q?pQXztVzNFyyQxyAH3jEfjzRLp4BdMYa5IrT20AiL/1Bx6BjDjivgy35thcbU?=
 =?us-ascii?Q?Dmqy+tWttn/Iuem4Yh77YZBk9kj9vZIEr2sPjHknWnDMzUaoftzPaljfTWVQ?=
 =?us-ascii?Q?EbGCJDUaQRPhoOqIravVPMdhXCba99Lj5/hUHr3M1I5cMGfjQWo4AYkZ78aS?=
 =?us-ascii?Q?CcUjhzQuRW4CZU1GQgVnLB24vV3wAIS1JMbOBUVdEKBxlcfov2JGyGHTp4mF?=
 =?us-ascii?Q?WK4RnkWntBRZe3XMg709m7XFRpU8rFnEy9X0jcQ8NIsgM3sv3QQpotdiRfSg?=
 =?us-ascii?Q?rq+GZE+zbo/E400bjpTmoFrQ5cw4pZ3J8uh6u6mgYkgATjpaTBrCI2l4mKeQ?=
 =?us-ascii?Q?RPFV8JyrWwzX1LpMOXPMRBEElxlcthEFox436kyxPx/W1zNpis0vDsNvOwam?=
 =?us-ascii?Q?VTTxpl5iRSeVp2I2MiY4QnGpt0eXwPJWoZL7/RhH4jnv6CtzTAqxmJcOwR4M?=
 =?us-ascii?Q?b2MTFRqCxpUcc4esE8Ft1kOcgYx1J7eKurpW4JHjCQgGjXvqwky9MpEf6mYn?=
 =?us-ascii?Q?RJEg1I1Jwn8GMhsyazxXh/xC83qoKeVYNe/jsFQDC9+l2cbn1keKNAzZMwLp?=
 =?us-ascii?Q?EbQ2pVIxda5DaPB7O0M0kwpJS5ddxX6/XxQgwzubDCe/GAN9c1OFUgEYirDl?=
 =?us-ascii?Q?aA28ZoAW6Gj/L3nbU43RlU4ij8mlSsprmmBGFgazPbMbuSDOGYOuzYPSCFY8?=
 =?us-ascii?Q?VrjQk8zVWn65fgcvjXyM7MJBGLq7SP/Pjriwksd06ekYcN/6kriyyNsh/lAT?=
 =?us-ascii?Q?ua86sKMvecvFxFq4QQgK0sRilDF/fWI0b+jN0N5cqvd7DEEIhVafv0bZlG0R?=
 =?us-ascii?Q?oiHwxi3Qv6kc8RWiBLgvrmdn4TSch/DFVurT0zymJ6JTCrRUTE4dXQrEajH9?=
 =?us-ascii?Q?DL35mysn5iF0B2huFOF6pTQw2AA1Oepv9VxLA4r9i9QPU08GPfvScsI5E93+?=
 =?us-ascii?Q?6zHPYngpZVn5Fk4S9kkdIMcJ5JFmXT+n?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1du3c6G8AFP2wW80JOitPwVBVf1/lPAOdvzcy9rHcu0L0Uay78W8Z9kppGy0?=
 =?us-ascii?Q?PtbR03q79RTRRHS8a+5Rk6/reDStcPtryGX3EnSaAFLDCp/p7UpW+FqdjEBm?=
 =?us-ascii?Q?y7IpMu4Bb5maXmxr0tUhTwVmNF1BJp4UwTnX5wofa8XPwwzGT4C7VRD7tL+2?=
 =?us-ascii?Q?jUuiJNoDFRU5ugOXszK/T3E6s/4Wy4FrratFrBVd+1l7ZDeK9/KrooXE6L77?=
 =?us-ascii?Q?zS+MZZEL+SDB/uOr+LJfThdIMiQuUidHZr7DRvm5kwEprZ4bif1KcVUx9fwA?=
 =?us-ascii?Q?/EClzrJvR5Li+mC6LdDnaTyAPfkzlICFcZk7VdtES5X76+Pebtjmw6eWQjbH?=
 =?us-ascii?Q?zNQprfvVI2h9ZistJ912NhrBZj+cu0KcxONlw5UYbxWVa05Wbj36aIm4vj6Y?=
 =?us-ascii?Q?8Rn4WuFL38UGf5wVLUbFpzNfHRlmj04psKBZ5FpVEPQQofi5ZlwyHjuzX32h?=
 =?us-ascii?Q?XR22Rm1q/k465ZdUX9iOgBbCypUa09MX3ofcYyYVBYZv4s9YfYkf5PfTbpTM?=
 =?us-ascii?Q?IbshyfQUpxpfX77psUxvrOu9uBGOKaHXi/AFT32vP9550Q1IP5JD+5TCSekm?=
 =?us-ascii?Q?FHx+qbL/Zg+bPgdyJ8qaM0ayO0HP1staxOOWTh0dKZQPjcpQZu7Ff4JaJD00?=
 =?us-ascii?Q?SQnv99jwAdgEQ2WCZ8IU3MWds8A6zYX84G2nb3Bn/cwywkwakxhYLsFFC1DO?=
 =?us-ascii?Q?RLL4JfivzYwnRTUaIuM3ZsKWj2H5ZBjQNI4VYdZIVQDkw+y4awmxnmX2evPJ?=
 =?us-ascii?Q?rKkhYDmXpS9mIc8zbrH+AffoNZ8BERjuFEK+VZz7Vq/G9R02qlvZf5DKalgc?=
 =?us-ascii?Q?pC3GuUin1mZx77LG8puDTecF4V/5v7aLoXim7bn2dMqnpO0E+ZoCjafFdx5I?=
 =?us-ascii?Q?kdYzMt2wU7Oi06SF1JNL5YPVZA0Qx9S6QuSfGt6FDFsq6l4I48C+hOmGzBI1?=
 =?us-ascii?Q?1gmTydGVt0Kdi2+AdcgAGDTbw3vTWHCkynsSADg7bc1NInzcXnLWzfuZ2aBg?=
 =?us-ascii?Q?wt3dOQMC4wTBGVk9qW9yvm9uqALYJBCZonOSeqa+pZTsNhMqesb/GTmVLlYx?=
 =?us-ascii?Q?ksR+KGI7SzXfx7pOdwy9Rl5ZyjClnmo3CiCz39FTnYwaJRS3qD2tft4CtP8a?=
 =?us-ascii?Q?kXmoN5oCNnwngz/pkqTdNXjHEhIIqYT7TfOxT2l+Nd6GjW8pXH+S6XDok9bA?=
 =?us-ascii?Q?Y0mgiCjMS6BPpBpeRcq0UIR0BUtb8aqp2TAuY11sv0qj2HyiguJjBvMp4dtK?=
 =?us-ascii?Q?79oGLsCD0+1zl19yegAqHzmaqUDkZK66F8OE63UsATlb6sze6lGwf3rZU49W?=
 =?us-ascii?Q?sc9eMcgUQFps9Ax+kP/WcQPV/L0Cy2nQqheP41ZnDvxkY+u4DTiMYGGXrsyL?=
 =?us-ascii?Q?L2nQi/co/CW5ZT5m7d3ekq3FgVWUznjldMFbaB7pXxIv8WjNbwFgfNu+LTwf?=
 =?us-ascii?Q?IDCi3n4U62d6ErWaLxTmTepCuRJBikExU/fbc1v6yFR8XPJm09k/OLeKa876?=
 =?us-ascii?Q?ml7NAT230kowx2QFH3ioIj3dA8YH6GM70dpF91HqOK9W8n6kzfmm9xx5HTUf?=
 =?us-ascii?Q?m/M1IBDyI9jSGveE+i2CD+li9c58J9Wru6yze3EN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94eb7278-4e5b-43e7-04e9-08dd61244e31
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 05:11:11.7183 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bZIzjXP2qt4cAl0os94m/ZE1eNDusntdX9l8Fqnk4+JZZVXyIBdrH+m8JZUU93nHVrxSJ93Ov1qLO3msuwRHYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11020
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

On Tue, Mar 11, 2025 at 07:30:21PM -0500, Adam Ford wrote:
>The ECSPI clock has the ability to select between pll3_60m and
>osc on the imx6qp, where it's fixed on other variants.  Fix this
>by adding using a helper function to determine SoC variant and
>register the clock accordingly.
>
>Signed-off-by: Adam Ford <aford173@gmail.com>
>Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
