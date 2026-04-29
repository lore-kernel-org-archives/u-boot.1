Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 732F2FF885A
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 02:27:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE05E846BD;
	Wed, 29 Apr 2026 04:27:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QNXGKRH9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D27C5846C1; Wed, 29 Apr 2026 04:27:12 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAE78846AE
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 04:27:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cUKRrxnrM5l8lixeuoX+SI2ZvhRnM4NcWxon7KGtYYPA5/DkBrEckIwF0JIyxEEvRN77JMDQFxsMi5bgSjirQ9RfX0E/4m1k4Mzzc/Kbrz8DBGkY3wXjnKOo4CC0ZchMDwg6pI4y0ECKQiqCnmFfWIglIOXrzOaB8MKX9GDTf5VmR3+sDkzjRHPpjtYz7gxYKnP9DygVJpxFUUDjatUjspnP0Yrh2GNMaNYIDL6+GJzATgIC3dQ2lVjHRjEGPDcjT3nUkBu9YLVNRuaRD+n04R+cZb3y/jpQPsWmvoMc3LVtZ2bk939JGFnFq/x3TIdDKrYkKDyAz3TVUs2fnMihqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=we0ivhO8jGB2jD+BRXoOu8Jao/AdGrFUcqy2/UgAofM=;
 b=MkNTh9TeeMXEOyM3sFnPVfzwyhSC/fn8JJ1mNSztF++spDMLP3HismOKBV6pHKXpKbtjkjeqIrqcJzRMVXDhl5M3ThAL7C0d4i3dk0DjG8R6aJaSwAFa+YqDFDKY2GjgE3g5UAnRQ/B84W8vJYIS09uPsK/aU80hYImvAMQxwKjQ0mynm4zQix/o23rHTQL0GNbUhujP+frdaueWw6Y1tgBSkStVYuh2wbFY42969YAd5eo27KE9slDMf9K9TXA9GSbAV63CNnK2l7tetFMSW0gOgkejXCIM/80G431UVQCeGJCs+VWxkFOAkaS5kpf1iISQFIKMg2WRozOWnbDcnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=we0ivhO8jGB2jD+BRXoOu8Jao/AdGrFUcqy2/UgAofM=;
 b=QNXGKRH91WvpPCLWVfa4LTEJeGa8IM5GZns8DT1ArHGQW+cOcVkrMhHxmoJsyaz8wUL68HiDWw/TuEqLlti1IVEyiad9TYb4xYnWKq0/Udq5Pd2AN2IvoX8WuQvtWBz7hm/SNLMiTKSENneQZGNga2wOez1LXvTrPCL4gkzGQ7/zIjdKyYCyq7h74Z/9qEvqkpB9r5gEkuJJprSEIAjENqEhqINh5CTMaG/cLaz2Gf+D525o54v9uYMDAvea0PVgIyxlz1kfH/1DzQ63HIDC2UmH86XJ3EOS1Cs0NE+rkvwlJRxaBPP8cLAMIqx627GvRKEolX1VLdQYcXIgRzwR4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB10076.eurprd04.prod.outlook.com (2603:10a6:800:1e0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Wed, 29 Apr
 2026 02:27:08 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%4]) with mapi id 15.20.9846.025; Wed, 29 Apr 2026
 02:27:08 +0000
Date: Wed, 29 Apr 2026 10:29:46 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Ye Li <ye.li@nxp.com>
Cc: festevam@gmail.com, u-boot@lists.denx.de, peng.fan@nxp.com,
 marex@nabladev.com, fedor.ross@ifm.com, uboot-imx@nxp.com,
 ye.li@oss.nxp.com
Subject: Re: [PATCH] imx9: scmi: Support iMX95/94/952 secondary boot
Message-ID: <afFtGocJpOwJYRym@shlinux89>
References: <20260428083250.1802229-1-ye.li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428083250.1802229-1-ye.li@nxp.com>
X-ClientProxiedBy: MA5P287CA0046.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:175::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI1PR04MB10076:EE_
X-MS-Office365-Filtering-Correlation-Id: bd0edfca-90aa-47b3-b3d3-08dea596cfc7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|19092799006|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: TCwofQKsLGChl61A9yr0PNids+Pt8GjnG7idsFsOqhlq3nKNJpSNj8WuFz21pqVx5cu3MOh4zV0uRfpddfUhBDAOvy1ldijqQSo0/H4GzubBkx6MT4M/4x7Hla/HO1dIPi5sAQ5TFuagxoVRSYwaaridCo+XUBTwJMmPHpPZCljKcPV9ZAz74sqE7I7zdw2/5kSGIqpQU1VsAlkteW9cgdxcBATK7v9vkDh19oM4L7CYXefEp+s1D6OBl0X+uksL0jPv5Vw69fMg5ot/BdbYHqOryYNUuRhkpx0hv2O3gJpEBGF7OBuvslHia7ulDSPiKQsQuJ3224MF9h6L5jXR3DMoi5wBc2bO7JiLTFOSS5mOEJqCQH7qNH1sh4d+HlM8HG6Ow5rMe7wQOehF1YiexZcPxfLZhUukXClm1nCdRtENHf6TtwwGO6pUdOg7fl9T9m5KkskpvT6ms5HGAUPByvtlN0ATzUQW7YjXhy87s/pFBQJu3Uj59LwwCSbFrt15kR04Gk73LX5lQNBJSXfiNybU28Ax2FI3/5b2743q3/qqkjf9+yI0XioRVnY2TS2rxrRELCBSJKp38VJMq515+WowdxHmHwf3RWMNWUGgahcuvpQNjEw4uUBWsfqGuyUfaH/pPyJDGWrgEDmM4dxbeIKXrPMqVg3wlMEUhF8SdPgjQvr0nxt6jfP3nRFVzavQ9nw/IZqqvndK8mAU/SyrtGFRf9l8W8qjv2qzTRmQdrPSqlIcVPWlL3OeqzV7WQQ0DQAHIMPX1Syx8aPYGr4O6myIczizaSIw/BRNus1d2UY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(19092799006)(56012099003)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9pXbouVdYmeHFWaQt0HL/LFEf3ux+wwOSW+TubgeE6cqs2lE+BJjSUIrN5Kz?=
 =?us-ascii?Q?HpzF1cp89gxDMpc6yglxxnZcXItEXb41fgQIOUvX/hkow57lUYVAKICFFPnb?=
 =?us-ascii?Q?wasocF4+Hn7ucdZEX55meHc7Zf9/ZU35PAgd6F7dH11KWOX9/iRZHV6aFzCH?=
 =?us-ascii?Q?AlPZs2WQDz7Jl3Q8Q5TpcqXhLwEUggKXEyxAm1UvjB7cSdPxIHLFcXYX6ZHy?=
 =?us-ascii?Q?l7lS4JBMDEReEH6aIKUfnTIFezyP8grOK1Pq8OsF+opjLqsp95YS45p4/2Y3?=
 =?us-ascii?Q?6tVScvCN1tL+B7o9M8p02WHJTwLMe7rrDe8h0M8kf5yPB8/f5vFj2S2cEfjg?=
 =?us-ascii?Q?tK9tVCqtz8uJGkWWfiqnZvWWDzkrzOEevDTqKalxDm61/Z1GjX1zXXp6tETK?=
 =?us-ascii?Q?2cfgeZgNiDgjaGWdKdl7jmpNSpnkjNRyfwGFtHNxY4Ek+tmkRpvasgVylCOr?=
 =?us-ascii?Q?N4zczdhFRAwT1JC7kXjv2OjzfS7r/s+K5/g/4xk201pN1uWxa4MIjx8qTsR5?=
 =?us-ascii?Q?NhLT9Dxwuq8vTWQn4mZesRioaXRHoNCm0bZ+A3TgSyLfWgs/ZqXC5oRTeS5i?=
 =?us-ascii?Q?zpJ6Hq32+nJ55M7YJzUhmYWOGVEup95w7sp/jhzKvtnzxlxxTeIUvK3q4yId?=
 =?us-ascii?Q?NkMA3Lz6at168OgVGWatWSecs9F3YrwXzztBvKhhT9AxauVg9bn8oONI6OZb?=
 =?us-ascii?Q?lZccOf5wkYgqYeYlfJEfFqnwRU8EZe9HxijJwEPEpP5n8lCTlUQzz9re3ALq?=
 =?us-ascii?Q?ZkNCL2xpufGIGrKYP9d0bpNEvLrvsLEekPC8udSXuNXqIUacdihVPyn2Rs+K?=
 =?us-ascii?Q?iupoa7o10UVQjAvfjNbetszsFokxeNAZqlm73xxLOLTHdu164s7Fsg+A0Xjm?=
 =?us-ascii?Q?8SWaz6zBgCXojrve1Ynf/7R5UvFdv9DQ6e4hZk5p2D48GR54iOIPyaouUbYp?=
 =?us-ascii?Q?JgDOXn+/OFprQl3n1Reol0Xmt29aIUmUGmynUqln5BGUEKEfZUY2rsV3gCZl?=
 =?us-ascii?Q?HsDD7DrGF6zTIAXKed5PZMNJtZQrVLTW0UF6TY7ucwHmjPkqoxE7FZIIihH2?=
 =?us-ascii?Q?9SicX0dD3iOOKwj4QXtdDQ78kiEufnqB2U0VVyD3f5UUz+N9Nsjncp4tWSDF?=
 =?us-ascii?Q?o0EFzYi2YUfHrCfhXCJrYF7swvbj7sfgKuMUj4F2u/CJDb6jRtYNHoQ0g+QY?=
 =?us-ascii?Q?HwYYxq3cTX4wtX5EGCpDnDzmoAR/dGgxH5Y128bZCo9utuPmx0TgUuEBJ8BQ?=
 =?us-ascii?Q?c7QQzurwxbj6FHqGAw6dvtNQ7D3rhBsD26tSyLFx99dteLa+nPriwguzjCjT?=
 =?us-ascii?Q?SUA/FJOieezoSdQCu3Ka0ve/BtRq8ijsXdyGPp5wAGJRyBwZ8hWnZcMaKcyn?=
 =?us-ascii?Q?WhzGhyAgol6yaiRDXPuBIWQKosOz9vFir0PaZXLKDxgvTTK1xB+oZxMFVQEL?=
 =?us-ascii?Q?uJhLSfSM5LADgmLvnizkG/l0LnyPB5pKD9xkfN6HWsQWAB5PYohsEUtPGFke?=
 =?us-ascii?Q?/T0+fGKOQ6U1bAL1O76kzaKGP+vHktZLofxCk9iwRXkaK0gX17KA4vHwmfwF?=
 =?us-ascii?Q?BDhsgCBV9oqJ8bxBinMtqVSpTXT1mYG5th19qzj2bjMOgYUgTCwfJ8qTUPD4?=
 =?us-ascii?Q?fF9F2eXyMJQvKD0zXt+hOeqlRgdIcN1Bs4XtfAjkV2E0XaJKsCP7AcRRqM9s?=
 =?us-ascii?Q?JsmC9OpfFrAGrXU0ZVJhBwciFDrykBjIxboDNQiKHA4TpWbYgtjKc/oeHcCW?=
 =?us-ascii?Q?WsV09Wibpg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd0edfca-90aa-47b3-b3d3-08dea596cfc7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 02:27:08.4352 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e5UU7DPZeKjk/R6UUtKvX4Yl2e/DBZ0/w1fNL1xJCqcUIgOn1guJEmTy3V/PLj0tlCPbV0LOLMAuFTvi0jIEnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10076
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

On Tue, Apr 28, 2026 at 04:32:50PM +0800, Ye Li wrote:
>When ROM boots from secondary container set, SPL should select
>correct offset to load u-boot-atf container.
>The implementation uses ROM passover information:
>1) For non-eMMC boot partition device, use image offset in ROM
>   passover data to get u-boot-atf container offset.
>2) For eMMC boot partition device, use boot stage (secondary)
>   in ROM passover data to select correct eMMC boot partition
>   for u-boot-atf container.
>
>Signed-off-by: Ye Li <ye.li@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
