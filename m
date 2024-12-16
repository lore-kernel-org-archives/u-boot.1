Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDCBE7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 07:51:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 290628005B;
	Mon, 16 Dec 2024 08:51:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ufBVXCl2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1667580104; Mon, 16 Dec 2024 08:51:13 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 113B88003E
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 08:51:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a8jaBfvOpywqvgGAkbnjwnjOLSwQJQIh6l+oFNnHiNNQMRjQ/l7sOHOjCAxCiAE4lJz+Kitk3/ehHSZNfv+qX/rUiH5HiKlyO/ihvcm4ogWJxnpkNMLwglDL6upG8NKVVdzH8f7Y8+q94Q57STnTT5RK2+WKZuWqTpTX9gwhxq8PzxkHzQ/KPKJNVVWKlz8UVohPW230k3Vm4cO1Y1wEDnz8kkfIV3pgPlWPikJupleVBIzM50/j6+44QecNLFwD35uXqK4Sq4AQHB1Tlt9Yr4FDUmRE60DMrKKpRp1Nltbv8j5iRZFXiIe8qaFxVouyHwQMqiRDo4UgegIecvGhZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3V6PqxTBI7dMp+zypKUzoIq58NAXOD780/VV/Bk52Bw=;
 b=xmiFM9YWC6zCwgph2R6g1tV8TdlyvsSapDEfsys4LMlOptkBWLm3qZB3IRid8nEZUW+W+snMIuA1/G25YaueRMVde8BFKt0l4k56eB5WGDaE9F80irExHcRMeM04PxIRTCy/pb6upxt2yPTk4Thb/B35Zlc8opzn2McTj+4TrJpk8/+WOAsyvAw3LKMsKu3G/HKyfPltSx7z9gDYDhOoE1VC1TwkmumKmA7bwmNENUJrdoMuWwnyBR9ynI0/5i55kmH3EXVLgzQ4mwkCw9vaUv2P9+xbh4IJz0mBVGptM1n9xaCbpAxzGdgEYlPpG1mjs+S+ChUxqD+8Ga5AWnm2kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3V6PqxTBI7dMp+zypKUzoIq58NAXOD780/VV/Bk52Bw=;
 b=ufBVXCl2LZJLJEbn5LJ3kSZpMNAQEokx3VlVUrz0mXwoKrDSqLk5l25XW6GS8CCBn0ABlp8oDHzzrW/Icz/eYl/s7Hg7YKQm/7ku8z0aEprFdggja59Za/sEToxm6d6LhE8EXlerN8FJfgrBuo2wivzIKzuOwM3/pyudqi3n1ttbkwpBXfRxcWghzUOXHH0btOf6K5HqDOoHajzXswiBUElv6eJadlxiwRwsUmK1l+U0VJPJNtyg2pigyfYQB/MAeZucrqIHiUmST9NgiYWdNM8H0qa9SILx6ptRq34TJf80fjhDhKBkPRWXqMd5S6BfJ3iwnSzqT4unaFXZUHPi2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7557.eurprd04.prod.outlook.com (2603:10a6:20b:294::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 07:51:08 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 07:51:08 +0000
Date: Mon, 16 Dec 2024 16:56:23 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Abdelrahman Ibrahem <mail@aibrahem.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] arm: imx: Remove arch_env_get_location to fix env lockdown
Message-ID: <20241216085623.GA29881@localhost.localdomain>
References: <20241215010518.GA16463@localhost.localdomain>
 <20241215205553.10445-1-mail@aibrahem.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241215205553.10445-1-mail@aibrahem.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:195::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: d14528bc-14f0-48be-70bc-08dd1da6666f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|366016|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8H2wS/RYFYweNFT6zvrb0G4XGHZEIcYkMGXQLQi6KPVWxUCVvx+g44BZZw3R?=
 =?us-ascii?Q?5yMm+mn50t5ccfVIlNVcjeur4rWUmZ9BXBrwqtlI55CsjFrprCFSccZJDCFy?=
 =?us-ascii?Q?FOr4AYXH79HIw2jAfW431SFQ8FHkE21NyIWc9hYFh4vy6v2yZhE1C3RuejxE?=
 =?us-ascii?Q?oWgbBgWcrOY+6bkrnUcBEmFdig7o22rInAS3txua0v+934e1xroCMiJDyfiX?=
 =?us-ascii?Q?xhtSRQcTyDCbKEeGaviaeTSx3aU3FGtPFwq++Arhq4DI66qshW69xPNwg1IM?=
 =?us-ascii?Q?0gHqqxvLFDkM6DCodbdMN57RUW6GzDHq6EZg31qQk96+i1ltmE10ji7mlNE9?=
 =?us-ascii?Q?uQnWzii618oEjjBUJ+5vQXSGXJfFmLYF5r7inAQC1wp3hxzEi/wUV1K7/9vX?=
 =?us-ascii?Q?YyB3J/89xxZncZWffeGK0VglHb9ZZz/RMCPeY7mk1r0G090e7KpRYxiUTJai?=
 =?us-ascii?Q?LcWl+pwr6vvSJAOLpth9zOj4uhdsdURN3t2wRoMVRKwOUNmy6eGVgv9mr6Du?=
 =?us-ascii?Q?4V/UH80TWu/iXTZ194EYE0BB6yewCog/JAdUYDpbJ0LXEVa6zdv8uExC9H3C?=
 =?us-ascii?Q?g3lPcfw4gypLkV4V8/ypicXKsW1hMHIibVCY/ab7AR2dDuObxqPJGAEcOWfH?=
 =?us-ascii?Q?pS7T/qg8mu27QSWpkNTpVUsHvvvhY9b/Wstr6X87RrHzRQehNT0m3D3RNAvH?=
 =?us-ascii?Q?acl/Ufri0BIXt71xQfSTCjojySjY1+thZq2U+0DPrmhmzASvXxe70qxx+qjz?=
 =?us-ascii?Q?PP+e6ozE/g2QPkjWOcH/IUOAz5wKQfuuY0qKzeBZaIVkc8lpa4A2dsa2RGyB?=
 =?us-ascii?Q?YPQ+/b+bS++GJPFnZtnBAOgsJur/372cW+AjcEciizwFArP1Hb7rz7f+oUEc?=
 =?us-ascii?Q?6QPCCz6P7KN1c8eybdVsMzy7SA1p3NkR8r+5S809L/f2OFDxp6VWDcWtXDm0?=
 =?us-ascii?Q?oycarnZ50tcrRDm+WFN2Ll4Oj3ADqA+/OHzhcRHqoI91+zrOFfigWjLbhbOk?=
 =?us-ascii?Q?6AGZ/duFj57yaW1aeoeRrvXOb9nSPQtzrY4NxcfG1xNh/4BlL0kr5l4+MRXV?=
 =?us-ascii?Q?2rMt2TWJAVYLePZ4TiOabsXXxSZMBu7xDGRe5JI6j4PYHS1ClInT+8WJAjxu?=
 =?us-ascii?Q?iBn+F4UffY25sAijNjiQX/zjmrl1Cz5NGU9wtyjwfPzbRWJruDz/P8gf7gbV?=
 =?us-ascii?Q?YgMPmjJ8KR0dOEucq6/d0EMrVy/z8EC53ZuiS4VZ0aROJ9Nwdi2pxzdvxXI5?=
 =?us-ascii?Q?b64s433hxIgcn04bH3lj1ecEaCN8xtLemmo8w1MZvBPCrEA/3DdA6bV1UA25?=
 =?us-ascii?Q?zetsm5cYghw5r7HDzeI4N3vWxtafjJVz9fA1V0FDVPWAJRCG4NVCKmcu7Zj+?=
 =?us-ascii?Q?X2TkTtf+aPEOFWZqbLhcN2lr2nRJBXO48fLQsXPnaIlORCZXDd+/ECkBz4Mq?=
 =?us-ascii?Q?lbAghAUEePpqAc0TYurbuF6tZuu7y8Fh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ziZUpYUM2NURoRAmCFh/9lzwnWio1vXMXDm8/OK2/eHQFlDP0yumCrWeOrgv?=
 =?us-ascii?Q?ueHmTWlfO+74lvE+B0zUFx/v2Br3WLFqQIyC29u4DnGJ/yLZXP0LorgwqAq+?=
 =?us-ascii?Q?xFhRaZJDa0c6qEarSVrTV/vr+HkaR3iAtOIOHO0CF/HILm0vDtqTVcGykkef?=
 =?us-ascii?Q?WY3gtaSs6/eNeDdoiOKW5kvXtc+WEzPfu67ycm2x0dNLub0BAle0N/VZ2ViN?=
 =?us-ascii?Q?U/Oz1QDTNtnAWxySvOGTt8TlYin/zNOqgT9DR4K7iE6F3sYNd3KyZin+oLX7?=
 =?us-ascii?Q?KYHeiAp9r0t5A0EUW0zOYKPAv9wcIMSyzqOapiOD5u65/iv3/bhiA8xpBNM7?=
 =?us-ascii?Q?/dXPuyl/0uK2O1bJK0/WdrZH3cCtYgxTOrVgINJXpZxjOlAgb1zhdMSMO/Bg?=
 =?us-ascii?Q?g0k4JqMil9UMcHMYklXwCUkZY1eju6laO3yo/1T+Xdcstw4k9CazYWojdHnu?=
 =?us-ascii?Q?tdn2UBiDS6fe/UM4ntMRJfw7AFjM800QLJ8tcEbnV40K+5mKSpkso8Q1S7p5?=
 =?us-ascii?Q?DqrhFt9YajQn+rRSn3tthgGaubTipg0LIaH8kSVajK/6xr8fUXvEgLt1oqSq?=
 =?us-ascii?Q?VmJ047sUctrYau+RTZsts89xL4SlAW9hZubRo48SvPEDPzepcovX7LQlySCH?=
 =?us-ascii?Q?SQbjU1CLah9cNwImF6p2ZHITM2fPOXsiyOvOxdUsUADz79KNzKHOkCBnJfwa?=
 =?us-ascii?Q?IRlycDYYcuk85/ez30SuFukj0fVTdtEVIPUcYyNUdPJCu/n6QjQEqLUSKnr7?=
 =?us-ascii?Q?WAsqdqqnWUIbKempbV4zHhDaeiw99L7ZopKEXQCE/E6p8G2Mi2f6r4fh8upC?=
 =?us-ascii?Q?Dcj+Yfm1UfPIVLuXMxX+vBiIrW60WaT8/GkLlo0cMBKFDutxIn7oIL5PPtzD?=
 =?us-ascii?Q?knxRZzMJeAPxGUPH1TqmpYp+NShuoEoUgdnJDOZU9ZDvPHQOt0ooRC53jPF/?=
 =?us-ascii?Q?+wvxyn/4UQoZCvRsDj/HyzLn38xh1S5229pSNrRSP6gsL6exka+xWnLXvgkv?=
 =?us-ascii?Q?R0+DHtIrO6et9Q1LF9FeQzG1nmZE9DvTmqefmBtRfD3Z+GN1gaceyC95EnWF?=
 =?us-ascii?Q?jLZybTqdl0u6C7PXr2Lkh+/7clXa6bfS3YSH72cURHRbwxUDhLrbQUwV9VOO?=
 =?us-ascii?Q?tK1oAbQNIWU7pXwVlSSSR6J+e0drxNIqFq3o8mPg9snPiMFCe3zghv+RZtxo?=
 =?us-ascii?Q?7UCoR+RVwPnVIOegU2YR9XxscOG7PJvPCG9yJSxnS6IS3VBY0hOFZXpNUAtq?=
 =?us-ascii?Q?LXnA5ARSZtxw56Lwbhcucm8ou75f6FjukBsm0iNOYXifvytU12JhZUReoEpt?=
 =?us-ascii?Q?J7Qo8M1kBL2pZRZ5UzAj/gOX8tu6Ep9qfJMGjANt1uvuS08gP/lCj7GO1oMe?=
 =?us-ascii?Q?ooQz6kbxiV2aPx5n3Y20DbL2nEmIZk+EjlxJJLVU+vivyUvA1hTC2k3q5cIM?=
 =?us-ascii?Q?xwYA11dPA01mhAAA9jKQv+lmd19sJQPn9twcMsiyYE28nm7Iv9s1z1Lsww1S?=
 =?us-ascii?Q?y43YayMr4uKKY+hX62FHTm/EI3epIuLH3rZPQ7CoR/Y0ORW70adWzymZ/Aey?=
 =?us-ascii?Q?iWhCm65FlggyV8E9aBry0twW3K3TzJ+O7XaozL/Q?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d14528bc-14f0-48be-70bc-08dd1da6666f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 07:51:08.4632 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pVJjq9Wd+pmmw3CUmP+jhHX9rOL7DEh5HNtw75GYHVY4FP8Jh5lvFjwVgpTW5CCXz4A35Z6EOVrUYkG8wiLFyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7557
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

On Sun, Dec 15, 2024 at 09:55:53PM +0100, Abdelrahman Ibrahem wrote:
>Thank you for your feedback.
>
>This file is global for all Layerscape Processors, if this function is
>needed for a specific board then it needs to be moved to only be included
>for that board.
>
>Let me know if you have further suggestions.

Please override env_get_location for you specific usage. Removing
the whole function will break current users.

Thanks,
Peng

>
>Best regards,
>Abdelrahman Ibrahem
