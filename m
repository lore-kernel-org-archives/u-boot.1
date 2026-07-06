Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25668C43602
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 03:45:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8477F84105;
	Mon,  6 Jul 2026 05:45:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vTgbIZD2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E020184686; Mon,  6 Jul 2026 05:45:02 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC389801A9
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 05:45:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CjAqEAaOTsELUOwagMjR64B6zHbmFHyy11v3FHkMIycOy3zuujUdg00UsDW0D9KACF+cLphT+lIrTQohzywzLZ23nCAuG6CXeFIXhG6LiusITt0KJnuthyA+C+fRFRGEhI+pj4yvOW8b+zSkn3r96fQfsfpD54W6HC9X4J07DRmLFQBoPxDPhP5Zj/kPNbRW817/FymnYN+BbAeGQBZu8yFn8wEIpZgJyz3QOLI4W9F7BmVkIyEpcDOcwyxdv6Nv9gx3BYoLQDuHH/I61lVMqf89d9BmPOhElinzP7owYG4yRSCzLQYTEdwGRnpYsR/GE1aV9pnf8Fk5pIIiu+eQLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E03Mt5zTAWXmApIi0oi0EYzu0IrWvbOcPl23IS8P2k4=;
 b=Uwb7fhRDrFAza/JxoBOvSva4YdfpmhS9uc9YbpXzS9QajLWzlVGGrtILG0IXuUdY1qwW24b0x67VW8V/OjKdqgoxZAUadAziMa8hqwKo6aTUiHQ08Yg+hJceq/70oPmDEFwHgAso6KMxKR+fWC54QzZ+KsiBUUFqxKHQyVy3OsahzYhisj0/FoOWVIypsc7NLsrzUh6R+pZskxEI7GP25DtdBWPG6rsKhSBKmkhZ7QK1NheevDZHC3jSWRPaUYQSYxiHTOjBNnYqXOFMeZZKV0KevJ3c/v3JUGjvhe8JUJrDOidWspT4GaPMQGw6FIkYPrrc3OKIKLyzPkI3eqWB0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E03Mt5zTAWXmApIi0oi0EYzu0IrWvbOcPl23IS8P2k4=;
 b=vTgbIZD2Pc0e5mnDNDHv3BVQcniu3HfwSRJzcHPdJ8oSSi+LHW01ki1+J3y++u0Hart8uRkqYEYhedRTKe/y63GvcYHMYMAnGZWUKNMNe3xFnL+Js0knWRbvtlwqA/lYWG2I7aKjwlOZyBAVn3mPd+19fEvTdv+vaKbAoMP+tqZYaFzCehTCBpGHuELWBzjqGMUE4dQtgXDhkGbSZ4HnrgCFu97GT83PhNgCW5kpMkS/5QVP41GNKnWRpSQ8uOVE9H2gksgTJ8KgZ69tVkTvFKY0rilwkteOjbZgIPrFfvn2h2dNr0Ddib0nMmnVFA/0I4TCjTqSib7av7dual7pCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PAXPR04MB8623.eurprd04.prod.outlook.com (2603:10a6:102:21a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 03:44:59 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 03:44:59 +0000
Date: Mon, 6 Jul 2026 11:43:45 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com
Subject: Re: [PATCH v2 3/7] power: regulator: add MPS MPQ8785 PMBus regulator
 driver
Message-ID: <akskcZJXYtDjWzBR@nxa18884-linux-1.ap.freescale.net>
References: <20260702195619.1857591-1-vjardin@free.fr>
 <20260702201438.1861442-1-vjardin@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702201438.1861442-1-vjardin@free.fr>
X-ClientProxiedBy: MA5P287CA0079.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d8::14) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PAXPR04MB8623:EE_
X-MS-Office365-Filtering-Correlation-Id: 66308761-2d2b-49d3-5b08-08dedb10f431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|366016|23010399003|376014|18002099003|22082099003|3023799007|4143699003|56012099006|11063799006|15866825006|41080700001;
X-Microsoft-Antispam-Message-Info: spSZ+PGlcSu1o2pcSZxiaDISdjTviPchDDz0oUJXw2PR8PynBsdXmTUB91k+b8KBd93pImAYiH+U152GFKL3g1CR1rwiOSZykqd/Kp5hiAZA9r0cIAHh7MNoXfNC04QyhTsAAXADUwqGpUMjLrqap2QgwL8+f2DKeSdJi726+8kycJ+/1gZFaAQlPrbJtabwaHqbjSVPhyOpdwVkIeLugZ2CkS7zTMR7LotNmvKK7haFCobRjyI9Q2psAO/GRuD2iSkWCEQps0jOrqGK3w54xJqkuJpHRB9qlj1jxEfR1VjJj/Lhr26FRJLKq0caqgT9yzUP8oCdZrAC4KZabWBDli77i2xgS2Jw3s9pILRqO0WPdP+xhDzNkQ5I20f+KJduL9ftfHQXcMTX/SLDCGIaD8GzuNI57QQcdEbGe2HfrxJSedg1GWr9/WkayXn722aEMApTpdyB4KQ07rZ9Z7dvk7edZjVFhqZfgpFilvvRHyDJe6mW0JD89CGOLxERe9tJeuB5jpQruiX27wmvnYHCzCeWW8J0gyJTZkBWTXYWYRnv7NPvt8775ZxuOTlgAMUGa+j+eU1gTM0rkXKdaeu4YF+ZUJUYc1HIEz1d4FsHlDeH2ZoVsX1mNzDTH1g7MB6e9HC5LHtwkY3+Mbk3I3MRcubxRXwKtuYVKqGlm/ser9x26eaeaZEvSO7zGczpKxq8Z5zSakMkNRXAuwM7kQCixBXAzd3NShm5mkyX/yhgAgVwwsLou374Z96gPSpY9ao5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(3023799007)(4143699003)(56012099006)(11063799006)(15866825006)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6CXxWDnv+W7JcUVZLKTv1noKjHiP02KEUaeC+V258RuBWp9ef871clHEUgZJ?=
 =?us-ascii?Q?0bbTyoHRMKarVW4flPlxevY4Sk74gcx5Q5m/ifr74WwUPkVeR1byBYDItFXl?=
 =?us-ascii?Q?lWrzoOopKCSRPiNEBVVKc8AZ+ix0tlSe7wcJodHnAZrwn3qwVk+PwQuiwv5Y?=
 =?us-ascii?Q?/VoocJGb0KvMHaMC4K4dBHDCdl7QosBRTT5oJAt+f9V89+uXLWIovO+xGE7G?=
 =?us-ascii?Q?3A2xjY1mIU6qj8ikKBQ76yhJHh6NHLuFT0Mh8+2O8AqxCf+MEY4Z+y9cJt6C?=
 =?us-ascii?Q?TBE7SQ8Q+YD0bRNpRNpxKB7JG335wajg4bmAglEpiks6usq+IRhcjUHYhEl3?=
 =?us-ascii?Q?7EatZHifybicUwhRsPlMP+WgD1FehjLsey3LiYWGneyTLVVNc6egZBkl2SGK?=
 =?us-ascii?Q?+1lPoE4XbsdXkBhyTG73I6OjSkgIGEW9naPV58btHwk33lpT4ZwyH0elxbC9?=
 =?us-ascii?Q?t1Wjo4kGAbRXgmOfu96Ut6Du2cscBTaB/FfVfKf4SYBFXkwTuA/2q9omhfi7?=
 =?us-ascii?Q?0Qg0ij66kwrZo0eZmDc9zR8JSfUe0rvxSfd1g/RDHn5F3lDr5OxhRARxrrEP?=
 =?us-ascii?Q?rBYG8mczT1tiOXDlYzNOcxRxNg5ID/wafHpP+gamS1Wh0SUbf/Il97W++D3Y?=
 =?us-ascii?Q?mZt5hrZqacQPiyeHd/Q6miua7Ihob7+a5OFvq8D8dmeMJW6OapnbGGAHkc/m?=
 =?us-ascii?Q?4B4iPSHsJndRe2om6y8eeeKQJVqtjQiA8nYtsEzX6kAl5etDDJDAm+9A/fr2?=
 =?us-ascii?Q?2bC4TZIv16hO8/DxC0M8lxA9S8kcOX0n+vLI0LWT/Zj63VoKJO/6K2atrbhZ?=
 =?us-ascii?Q?ezPQCqB6vREZhHJnaYd1nT9Bm4pdRTrAGH9DKAbHXjbHbcCFpM0wXMRJG/Ph?=
 =?us-ascii?Q?smTt8UHPqRPnIZ7NDJj1UsTgcbxZR5EIpN8BA3wTBiik9YJoE7mD/Y5deX52?=
 =?us-ascii?Q?bBi8Ag4VQmrNc5/lVEf7NZCUWmgZk3jFvPH6/vCFbiGaxLohzu4bBCgMsJPi?=
 =?us-ascii?Q?7O0CasRu6LEkc+Mu0zHfltZTe6o5nzioIaQ9tBETvzdyyIyrH8IDSM/3+8kW?=
 =?us-ascii?Q?uLGo0mSnF/ZkModsiFBvCFzWJVnB0d3Tlij5VsCxeOtMqaIDC5xpw4ZsW8E3?=
 =?us-ascii?Q?EoqRTYS6fFyW/ViAJ/7oKmLmDkgO9j1v2fjdHSPveRRmRgv+GmcANzUp76L+?=
 =?us-ascii?Q?I/q+43abyQchJnN8WwARBcHKyITmlTL/sG0Xcmh/OK3CKdvqejXfEix5Az+L?=
 =?us-ascii?Q?TCmicNiV0B9KV4l+rzf+5THPnz9/wk3bxlEnk/dYtFmMJsgf8JyyTTd/7OwJ?=
 =?us-ascii?Q?UzHK4Dki1NgUNPMYSWrlgmWoZjbIsoNtWLdah3ON2WknPFj4tey2swEsK8+f?=
 =?us-ascii?Q?Q9oAhrcwUjE1LH7RnCYDXZrnRxZmajyAdIZNJQz0p9ceE3TVSPapM8tCQxQd?=
 =?us-ascii?Q?58lsNQGWgyzWUxVM/e7CxIStMv+od+RJ6gfCV8UeYjD7QFmPXqbkXty/wT6g?=
 =?us-ascii?Q?ysFr+2A2U5NsKjhY7PY5CulsJJbhyj0pCjgU1m4WSqTvmRtqezpDSyGsP1NP?=
 =?us-ascii?Q?OJjkhF8xLb4EdMn/Yz0DP9NtB0eIexjzfELaeGg7yYNYQLGh/WP7ePMb0Ina?=
 =?us-ascii?Q?TSG8w61zZDTV4cLVb+AYLaTuoZ6gTqQhFgrvXiCiGobMuE78Q3oZBC/190lH?=
 =?us-ascii?Q?i75JAGrwcmXCGtr027KHJMOI/gjnRTHmx2HXTy46zKGT+NmfhBfIysJcxzjj?=
 =?us-ascii?Q?omWvD8hFO+V0pkrGNrvUI63S3oqFll95dXDbPaAfD/P6tfTqVLai?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66308761-2d2b-49d3-5b08-08dedb10f431
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 03:44:59.7115 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TvkAVNbXw1bi69fj4cvVVhvOQELwk8Gna3a+QojJPGVWWi8HR5+R5ol0tsKkIuAazSFYM/cj2TCYvpCTwHkxQQTINtHJ8KWpuLWyUOPUJUewQRb8xfAya1pP1MRrWB3k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8623
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

On Thu, Jul 02, 2026 at 10:14:38PM +0200, Vincent Jardin wrote:
>Per-chip UCLASS_REGULATOR driver for the MPS MPQ8785 / MPM3695 /
>MPM3695-25 / MPM82504 family, layered on the shared pmbus_helper
>adapter. Runs Linux's mpq8785_identify() VOUT_MODE switch
>(LINEAR16 vs DIRECT m=64 R=1) at probe time, applies the optional
>mps,vout-fb-divider-ratio-permille DT property, and walks the
>documented MPS ADDR_VBOOT windows on MFR_ID failure so a
>die-revision address shift just works.

Per reading the driver, only one MPS[X] is supported here.
Are there cases that need multiple MPS?

>
>Publishes the pmbus mps last|clear last|clear force vendor
>extension subcommands (NVM PROTECTION_LAST read and clear) when
>CMD_PMBUS is enabled.
>
>Adaapted from Linux code.

Typo.

>
>Signed-off-by: Vincent Jardin <vjardin@free.fr>
>---
>

Regards
Peng
