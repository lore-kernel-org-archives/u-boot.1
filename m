Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 695C1CCD184
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 03:27:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F621807C0;
	Mon, 20 Oct 2025 05:27:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="dcscrTOz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C478982E34; Mon, 20 Oct 2025 05:27:19 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2E81807B1
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 05:27:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VukKTAs/yLNhylDNTWre/nQCDfR5nxFKWmoYEKWt0LkHdW3dz87i39BCrlO4DzhL4BcqwVEe0nOQU0gPEzEio/ZpbTW+7/1Yx5vng575tvZnK3sYnXdOHHnXmmGr5qATrbW92MGf6nkeTsa0/Szky04+nrKZVOYYFeFeLFgCijwtvXoa0CWTc/cSUfk4xMbFbQWiEVdUHJgbdXovP+TXsNl8VXBun61g9BfuLADHwxMCPovABQNXcqrfeacmPCPQ8IUhovoIOcpMX6BY/1x7jTA6tkP3W21iNOAc/1ZvBZyPU3HC3d8KyyplZ9ndXyNPzp8HHf6OkEy59eaHc0Y+HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QGAcieSr46ZJA9qg4Q43DlUUQbNPINYbtXv+l7gQdQ=;
 b=LZEh/1WEWoioT6xarHPnGEcdpfSdRIq7V0V3g5UR5BoEt0dQ9tTCXiPuFOWcVbufL1FerHub3mQTtAWK9QMuU7xchF1eP6sPVKf4nsWnlKNl4u/N36XVXyOdzNPc9SjUz/0q4E7pjui1O3qm8p4b4oNHcZvUP/hgx1n9YZcrWxyGF9huusxpyi2EiHHhaWgDtczwK1Gkx/Vt+ggQqZLGBeGbUJD2kdTJpdX8G7YXSl6zWAmFJqXI/Mkr6aC/UIpMJIP7RaPnp++rHUtW0brnmhEpk32eZ5K0W8QFdoR9g04ftU1fkjbSKNS39XeC7X481J0LAcJ2c9MGZmddQ49NlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QGAcieSr46ZJA9qg4Q43DlUUQbNPINYbtXv+l7gQdQ=;
 b=dcscrTOzxstAikVaz8YO1SZIlYbJMsurP/Pu4HVXFGiWkUqooH99fuSMPq/MLEeBjIlhoMP3k+IDqV73BkrSacas1YbQqFKn/4nSH2ZCzAgFaN+Svj2SRuanGWyAWeJrqdhFt8ENWiK1EyYDBNjVSXNG6CpNTawytgs8Nk33yKAJXutN8x7W37YcyqzatDvCDsDqC/uUNKrv7bwBSvVXGBXyPq61Ysq6GwzePCUdy/zGHfm+MXDiOx6UYYE9Oigo1bNirKHCXRblpwDlns/qkfQliGKQ+4QWuK2RBzWGTXh+ZTyY1kUPuoCc/I+mTlzVkdibuXw5FPxPu/JLZp9O9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB9156.eurprd04.prod.outlook.com (2603:10a6:102:22f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 03:27:16 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 03:27:16 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Mon, 20 Oct 2025 11:26:58 +0800
Subject: [PATCH] doc: board: nxp: Add remoteproc guide
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-rproc-doc-v1-1-61fbaec7c40c@nxp.com>
X-B4-Tracking: v=1; b=H4sIAAGs9WgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyMD3aKCovxk3RQgNk41SDNNSTO0SDaxUAKqLyhKTcusAJsVHVtbCwC
 hhSaZWwAAAA==
X-Change-ID: 20251020-rproc-doc-3e0f5df18c48
To: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760930829; l=3126;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=E77p2McAc5u5f3DiG1rHgu2PNL9M75gS8eRlS/yFZhY=;
 b=ZbuE+JquguAoy3IGc0LbX7raLriJeCI5XTeNbtMzwS4voOT00jCHSrh1vTvAqml7Mm6GaqfBt
 iNFol/VSewjASWrKEDW1RJcEbkD2+BcuWhGGyvmvXTQ9ujjlLOkTWKn
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB9156:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ee3a330-0457-40bc-74c1-08de0f889117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|366016|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K00xUjRxSlZhNmVSTmJFN1B2TEhwMmZyZFBIUVdBTkFaMG0wZ2R5SkROcGt2?=
 =?utf-8?B?bGRWaGFlLzMwdmhzUlJ3bzdTRGY1S2ZRSVIwZkdRYVpSNTdIRmVsNHpsTTB3?=
 =?utf-8?B?NWMyQUc1VVVBNDJwTnNZWnhIMmlyTzUzRXAwZU1oSGYyRHFndStkLzdnaGV2?=
 =?utf-8?B?cTdaSlNoNTVvMnhDKzcya1JQNHAwRU9KTjRRcHk2UjQxTjUwSHFYdTV0YlRk?=
 =?utf-8?B?cXdnM3JIaFZRYUxENmlsWjFuL3VBbkxNNFMxRUhJN3hkRHNaNy80L1VNek5v?=
 =?utf-8?B?dHZuVEgrci80K2EwNnFlSThYQStkUlRXejZzR3M2NFl3NDdyUWhDZFZ2WUVa?=
 =?utf-8?B?VlJhSEFkU3ZKQUlqbDl4dzVYUnVqeVUya3FBZ0tuSGhoKzY5RkV3dlVia2RQ?=
 =?utf-8?B?azBZNTFYWmFYNGl4YXF0eWpQTFhhakxJUDZtV28vZCtHNHBkbis2bzJHSTc0?=
 =?utf-8?B?WDMxSXdGRWVQQjU0clFlajROcUpRa0o4bUdoRWp6bGg3TkFJTFpmejZUdmd2?=
 =?utf-8?B?dFJqdjVqVU8zeitUZ0lydHdrYnd0N1JMdEI0LzZ4bksrQjI1L2xLMFlNZjRB?=
 =?utf-8?B?T2IyYzJPK1VvR0tSOUtsUWVhTlhMNUdQK2xpV2U2Qml0OUlKMGRDWEg0ejJ1?=
 =?utf-8?B?RURGak9ZM29kbDRIMitQZmhTY0dkaS9xRW9LOExROXdqcUNURFpTL2xXVlBa?=
 =?utf-8?B?NnVFN2dHT2JLb2w5WElwQ2tXUHhEV1B1SXp3OHRjUDRGOWtPQ2JhUXZzZWtP?=
 =?utf-8?B?SGlLd1l2TllUaEpIS0w2L1h1NWZrTzM1MkJLYkVkS2FLKzRFblRGY2dRRUN3?=
 =?utf-8?B?QUo2UjZ0MnAxN1RtMEpsRXQ3ZXBjRWQ0SSs3Q25aQUNkbzJsazdpeVR5NTE4?=
 =?utf-8?B?YjFVRFJ2Z0ZramlWdjBqSnRzR0p1OGdnaE1wOUNZTTZwekRnSDdKRzFlQWFo?=
 =?utf-8?B?RHMrdFloNWNFWFRRb3p4TEVJbFJrb0xZK2Iva2JMUnZQeUJlcFZwWlVNUWRh?=
 =?utf-8?B?VzZrNDQ4K21FVmNEelVEOStKWE9pYWJja2tuQWgwK0pwNW0vMWRyN2dIekJE?=
 =?utf-8?B?Nk9jZ2VPMEUxamNkcWxxUmY4eGh6UnNQUkduTUpzMjFuR2U3eC8zdFYyQ1p5?=
 =?utf-8?B?MkFuKzVNenRKYmMyNXhlSmdodkc4eEhFMGhXSUozalpFTWVFMmJDNXhlOTlr?=
 =?utf-8?B?T1N4dG42aEJkWXl0Q0l4djRleGF4OG5hcVFkWDBxVzhLVjhManpFdU9xd2hn?=
 =?utf-8?B?L2gwUDQ3bzk4VTc3QjZZQ2xlRi9rOVJqN25XaTlab1NreHBYcC9zTGZSZEcy?=
 =?utf-8?B?K3daam1PeVdKUWJHKzVaY01jRWQzajRXNkFoWnFRRlNlb1IzekhJeUN0am9M?=
 =?utf-8?B?eE5lZGRGaytrU1hiaXhMdmpqL2xUQW1Sd3c5eUZSSWlTRTNZelYxMmVEaWJQ?=
 =?utf-8?B?TGt5TExZQzJNSitDbUU3Slp0dlJNWENVdE5KVzlJUXBtMDErVGtkYkNycVlC?=
 =?utf-8?B?dUYwUVZLSFc4OVY3VFoxdnU2RnFrRi85azNoVFpreURRNHdrTVB3VWNqeDRL?=
 =?utf-8?B?YjgvN1hnUDZKM0ZXdVAxaDZvMFNEdjMxY0hwakpxMU1rNjd6QndWUTVJUGwx?=
 =?utf-8?B?VE9yOG9LbE9uNEgzMjdNVE1DY2NuVGtuZ3ZMNmM4Ty8xTmorbkQvakdIeVF2?=
 =?utf-8?B?SGwwVWxVQm5ONUUwQUpBNEEzNFByUTFZcXdNTk1kOW5xeENXV0dEQW9SREd4?=
 =?utf-8?B?YVVsUjBjU0xZb1lweXBGeGdsVkF2SUczbENtLzM0VkVvemNENytiYUZDdzlw?=
 =?utf-8?B?RGRJU25ELzlwSVNuaHF0Rko4TE91Nk8vUWdTdnJ5UTBuVG8yMHNOUms2NVNX?=
 =?utf-8?B?RzJZVnU1YUVqdUhLUTdYaSt1Q1V0aVVuYk1zd3lFdUUwaWlWSHJ6ejNPWkE4?=
 =?utf-8?B?NnUwdmc1dE5aODdlQ2tpem0veWlPZk1JSTFTNnJHa1BiZ2pWYkdQY1RaRkgw?=
 =?utf-8?B?M3F5UVZHc21NLytTdG1WM1hKald1ZW5aUjNWOWJhVS9EMXIxWkxIY1o4L0V3?=
 =?utf-8?Q?6hYUXJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(366016)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WURmbXJtMjd2NjZPZ1gvT3hOVzViVVZYOHNZalNwOWh0Mi9iWGoyMWFvVG5t?=
 =?utf-8?B?RFhEeCtqT2xDRUc0V0ROVEgxbkk5dXFKWDFXQ0FMbFdxMGpvTVZhbzByZ0Y0?=
 =?utf-8?B?SGFFOW1HMnFEYjJTYndhT1pkYjN3WGZsMllxM0lvcW9OSWFKcVRuZi8vUFZa?=
 =?utf-8?B?cXlMci9HYVk2ZzFMc1RZUXVGdjZQSUhkaVFPdjd3dVdEaG5vSmFyTHhyOUhU?=
 =?utf-8?B?eCttc2Q5ZFpmbHlyS1dscWJkNUhqZTlib1FKQ3ZoYmNTSVdJVGp3aHhXcXpn?=
 =?utf-8?B?UVNlNTliU0lJbGhTQU92ajIrV2lqdnFRekZ6R3A5RXNlanAzL3hVU3VmMXdU?=
 =?utf-8?B?Z0tCYVZORU53Sk9Sbi9iQ2JueFY0MUMrY1Y2aE5BZEVmOGphbURSYTJpdG1m?=
 =?utf-8?B?RElFOTIzTXl2ODFyU2lmTXFSaFd4MXg2dlNMZVMrcmN4aVhLSFRQaVgzL2o3?=
 =?utf-8?B?bmsyYURCbml4T2VTYUJIR3BVamU0VkllK0xmTGFiV1p5UHpRTGd3cE5BRkFF?=
 =?utf-8?B?MHVVTUtNdks5NnBWakpzQTdsMUxSRjdzL0t1ZHJHTjBpdTgwY0VlOVM4YVNw?=
 =?utf-8?B?VEsvYjM3a2NQbXQ5VkJGVWx6SG5RU2VKeWV2cUlSUVRtZVVnQXlLYTdZSnB4?=
 =?utf-8?B?WVFXUXB4UFdENnZNVHlkQ0E0eURsRzNQVnNnZ0tlSjZISE1pYUdPNDRWRm1o?=
 =?utf-8?B?SDI3RmJXTjhpSVA4THFET0pIdjBQOVMyc1N3TnFJUjkwaUUyajI0QXVhbmRM?=
 =?utf-8?B?ZGVXaWt2ckJaN1dUSU53ZTAxNHRNTWFNaEk3M3Y5M3FSRDd0YTViaHdOTmZi?=
 =?utf-8?B?b1ZTekZ0c3VQM1U3ZEtlMWFmWmlCZUl5T0lJaUpDcmc1QllSWHhBd2NmRHQ2?=
 =?utf-8?B?VnlXWWVTYXl4SFFmbUxSS1RLQkRrdEpUTE9la1RCVFlyZmZwcGtscWpWZEtk?=
 =?utf-8?B?MllhODlMcTRmMFRMenJsSTBpRlQ4L0dzUlpTSFhEYXZlNElBTGw4WXo0KzlK?=
 =?utf-8?B?ZjBTREg3ZVpyL0xFYVpPKzFrbFk3Y3NRempSRVFqV2pvNVRkbEd2d3NRRkh2?=
 =?utf-8?B?NC9pMkJmVkd5MEF2a0s0bHUrR2hGT2xJVUk4YjVhcHlxMHQ1VVBHNW56ZmlI?=
 =?utf-8?B?VEhROFpVRzM3K2sxZ1hUd0ZrU2NJbDIrMjVJTThSTjZYc1J3QWNYS0pNWVFa?=
 =?utf-8?B?MDJtTFJPYW5BQzJzeFh4RHROa005aHlLZXBVY202SGJickR2aUtUdVRvOXpF?=
 =?utf-8?B?YVlXSWtlYWJqbVIxT1dYUk9xUU0yN3B5VFBENlpHcUZwaDA5aWdCQ3E0SDFp?=
 =?utf-8?B?a3VDemU2eE1hRW8rQWVZajFNa1RQclBuRVkyVE1nVFNwODNLK1dtajBwWXY5?=
 =?utf-8?B?ZHZyb2NvaTM4TkwrYTVHYzJPbVRDNjlBRFpCVmtIVUdlSnBBMEJlR0dlSktU?=
 =?utf-8?B?bmJBNkVZY0tzOWxHZGVrN29FV213NjhsM0pKQnVINXljQzdSeDArZGpaeUg3?=
 =?utf-8?B?TmVnSzBWbkIvVlBEQ3VhbmRtclY3UzR4ZTIvSTBESFBSOGZsb2pHaVJZVHlv?=
 =?utf-8?B?SHdDWlpsNW45M1BidVRUWHlNRk91c1FncmxaV212ei85S2YyUFBzdVh5eG01?=
 =?utf-8?B?TkhZL3FRdE1sMnFTazhKc3pEQ0pjd1dhZTczQ28wMUg3RVlhQ1JYRW1lcGtz?=
 =?utf-8?B?U3VjYVIxL3JtWENuUHFWcWhtcTAvTVk0VkVoZVhHVlJDRFZ1aGFqd08vY3VY?=
 =?utf-8?B?dEZERllOVGVzRWtDWkQyN01QL2R5SDJjSU9vV0hmRk9PVThGdkU1Ty9xbHNm?=
 =?utf-8?B?aFhGb3o1amZOTmJVZEJoRDZLRGNUb05iWmw0QVVVOVY0T0tITjlvNmg2OVlV?=
 =?utf-8?B?dHNRb3FVZi82U3dMT3hpbHh3ektqd05wT2c0a1JpRmNLOTUzdGJjaHBpV1Ey?=
 =?utf-8?B?NVVSRTc3NFRpUER1eUp3UjZPTGZEdGgzaTUrQ0tKcVg3eWxvUzM5NGpZalpk?=
 =?utf-8?B?eEtSUm5raGZmT0I3S3dkbWNvVjVHdXhhRmtzY2R3WnZtclhheCtNcnp3cHh3?=
 =?utf-8?B?eDA2emNXYXlldHFCdU1mM3htUTJwMVZXTytzbXdiNFJnV24zRTlDRi95MUE1?=
 =?utf-8?Q?uZaupta/aBxo+yWUAoBl52OIW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee3a330-0457-40bc-74c1-08de0f889117
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 03:27:16.0632 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OtJrdvx4ZIia+EB+MXPnfTgwBSmgInspW6QX3lqG1suzGTphdVOFhz2tQyJ2CD3qHexbOXIDF7OMgPZgYoTfsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9156
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

Add guide on how to use the Remote Processors on i.MX8M and i.MX93.

Update MAINTAINERS to include doc/board/nxp.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 MAINTAINERS             |  1 +
 doc/board/nxp/index.rst |  1 +
 doc/board/nxp/rproc.rst | 69 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 671903605d17a78b88d83ddb7e01b78115b553e7..b30ebdabefa087995fa9147f11d862fe0a12b75d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -317,6 +317,7 @@ F:	arch/arm/include/asm/mach-imx/
 F:	board/freescale/*mx*/
 F:	board/freescale/common/
 F:	common/spl/spl_imx_container.c
+F:	doc/board/nxp/
 F:	doc/imx/
 F:	drivers/mailbox/imx-mailbox.c
 F:	drivers/serial/serial_mxc.c
diff --git a/doc/board/nxp/index.rst b/doc/board/nxp/index.rst
index 670501164b5c11f64dc1dab03b6f90e2fba0163d..7b881961b65d4b481b018761cdedb7efb4d208c7 100644
--- a/doc/board/nxp/index.rst
+++ b/doc/board/nxp/index.rst
@@ -26,4 +26,5 @@ NXP Semiconductors
    mx6sabresd
    mx6ul_14x14_evk
    mx6ullevk
+   rproc
    psb
diff --git a/doc/board/nxp/rproc.rst b/doc/board/nxp/rproc.rst
new file mode 100644
index 0000000000000000000000000000000000000000..b023c1fadf6253438158b46a9ca1cc9a4e3dd757
--- /dev/null
+++ b/doc/board/nxp/rproc.rst
@@ -0,0 +1,69 @@
+.. SPDX-License-Identifier: GPL-2.0+
+   Copyright 2025 NXP
+   Written by Peng Fan <peng.fan@nxp.com>
+
+i.MX remoteproc usage guide
+===========================
+
+Introduction
+------------
+
+This guide is for giving user how to use the Remote Processors found on
+various i.MX Chips. The term remote processor is indicating the Cortex-M
+[4,7,33] cores inside i.MX family.
+
+i.MX8MM-EVK
+-----------
+
+Steps to start the Cortex-M4 core
+
+    load mmc 2:2 0x90000000 /lib/firmware/imx8mm_m4_TCM_rpmsg_lite_str_echo_rtos.elf
+
+    rproc load 0 0x90000000 ${filesize}
+
+    rproc start 0
+
+i.MX8MN-EVK
+-----------
+
+Steps to start the Cortex-M7 core
+
+    load mmc 2:2 0x90000000 /lib/firmware/imx8mn_m7_TCM_rpmsg_lite_str_echo_rtos.elf
+
+    rproc load 0 0x90000000 ${filesize}
+
+    rproc start 0
+
+i.MX8MQ-EVK
+-----------
+
+Steps to start the Cortex-M4 core
+
+    load mmc 0:2 0x90000000 /lib/firmware/imx8mq_m4_TCM_rpmsg_lite_str_echo_rtos.elf
+
+    rproc load 0 0x90000000 ${filesize}
+
+    rproc start 0
+
+i.MX8MP-EVK
+-----------
+
+Steps to start the Cortex-M7 core
+
+    load mmc 2:2 0x90000000 /lib/firmware/imx8mp_m7_TCM_rpmsg_lite_str_echo_rtos.elf
+
+    rproc load 0 0x90000000 ${filesize}
+
+    rproc start 0
+
+i.MX93-FRDM/QSB/EVK
+-------------------
+
+Steps to start the Cortex-M33 core, need to choose the correct file for
+corresponding board.
+
+    load mmc 0:2 0x90000000 /lib/firmware/imx93-11x11-evk_m33_TCM_rpmsg_lite_str_echo_rtos.elf
+
+    rproc load 0 0x90000000 ${filesize}
+
+    rproc start 0

---
base-commit: a58089ad2e41e88f81360f0e99bfd0715aceb556
change-id: 20251020-rproc-doc-3e0f5df18c48

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

