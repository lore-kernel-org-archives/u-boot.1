Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 376CEC83F26
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 14:57:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D6BD82BA1;
	Tue, 29 Jul 2025 16:57:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MgJoMniG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0430782BA7; Tue, 29 Jul 2025 16:57:34 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D48082B20
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 16:57:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yajQrq2EnYHn6j60y+PJEhU1IZB5i4fd+C7iGYR/qhMrB6Gv5ph8czCojR0ysk/V24qRFzXIdt2yfNWQzS4q3rDvj8cSh8O5peAm5EspAfntvDtsj0eF4Bb7xaU/G8+llK4iwjj81fOAisoLSltikZjFrtlf/2YQLEar7kS93CicfTHUYjMkKWJbPEroRFwVzRXy5YhO/v4z7nXGIXRl/XogcDjLIdc4D8eyFtiSkEkPnFOzxG+aIqbK2+GRzTBoLKEQds/8NZfOcXuECOft2j/64Lh/w4ycJgc1pPXfa/k7zBGgr/SKc7nh50c2a1uPY6AndbxgOTSMa3+/Gws8Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jvtql/juquSD+RZa25CkBuLiU0xeTF4CBgofghsg7ic=;
 b=lDF7ll76QtCdvPFt+CMz07i1LNwYoEL3p+J3gyKX3WB/oiy6XF3uqb4d+AyQ8hYzYEhgOLZCYiFhBsUDBMqvOPxryC84BQYg2k0m8OrMknJ+9FMHonUYOvQpsgNWNIOFLSlTXrH0v+8PWOlheyim+l4cV9TMS5c7jidikM0dVIGEqQolHVzHT2pK8XaYqec0mU7RtuSYfxg2TyOV2rP87XiyGAYKNTvJ0C0K54Mw9Er7l2MPkmSGnTzvLMbts/I7LhxwhYxY04jdZ963hGkcW5ZsjX9/3EqqJpkDmnFFkeONSkDBlzg+ok6dwZTjzZNz14BQohJCzUTCvdlFvDy/lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jvtql/juquSD+RZa25CkBuLiU0xeTF4CBgofghsg7ic=;
 b=MgJoMniG8jYpMBPsV9FJ/Gj+6iNtkkPwD5QSUSDdtSd59yDLnhGO15Rtsp6ZFAz5/WzbnlV/QhqJiHSrHthOl3dpgVVFN6ZZjY99/9HUT/jQX2ZIuqRnJEzbxrZaj+Wp9tg9HYH/upoHiEM6r28d9MuN44R6yv5qRcZsq+aHYgHhf5iUOFoHNb4BJ62gYj9/N6+IOs6M6ZV6suop6FpKETFu33Ug+oFPiUHENoxllo6t3zI7n699E4I12Rl8lcw9MPEcQX4QySFbJ7EVCM7rp4eYd2tytltw6VLGU4a6JStLM+MRCLI+ctbB7pJ6I84youp+ZY/nddCuuC1IV6xo4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7991.eurprd04.prod.outlook.com (2603:10a6:20b:289::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Tue, 29 Jul
 2025 14:57:30 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 14:57:29 +0000
Date: Wed, 30 Jul 2025 00:08:05 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>,
 Ye Li <ye.li@nxp.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Alice Guo <alice.guo@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
Subject: Re: ??????: [PATCH v2 0/4] imx: add i.MX95 b0 support
Message-ID: <20250729160805.GA31189@nxa18884-linux.ap.freescale.net>
References: <20250708-imx95b0-v1-0-01759e9c855f@oss.nxp.com>
 <CAJ+vNU2G=CMiHc4mU4fjQEz7zwjvx_EuiWWQo8MBVHGJdmTarA@mail.gmail.com>
 <PAXPR04MB9644BC97420DB4E3D877C2E2E225A@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <20250729113902.GA27993@francesco-nb>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729113902.GA27993@francesco-nb>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::16) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: 13fe6a90-5fee-477b-ea2a-08ddceb03d6f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pQXdc5/QBouhL/N0/7XRk1O5XKshVp8x51tHjS3j7xsJpRTnRPGLImjtOQyZ?=
 =?us-ascii?Q?xlehWc1cZ7oyHfI0fq9CXFjncB8FKVuKV+wfdQTLcussVAsTBbWAIWDX9fhB?=
 =?us-ascii?Q?8GEUFqN4KIMR0xts2wkIUGE4MQz7Be5H307BSHkc4JZz470TmBViKcDqcFxb?=
 =?us-ascii?Q?o2JHZtaHhWCt1bOEWZE4KsNsr9NK73woFV77uhOcdwQ4unUl3r4qGO/xR9sV?=
 =?us-ascii?Q?mC3Qssf3nrl0aCS2AIjoS9zTYsTYH1zMx8h/1pIekEUC2fHTXY0/R1ClZqEK?=
 =?us-ascii?Q?D3ReBUX0VfGUA1iLMStF+fnKqqY81ermJ7DOu9wzJ9jQx3bEx8XSz2LJc2V+?=
 =?us-ascii?Q?4OYKBJDIABiu6HyADrerT7RHNuArVgTP25VaEIrdODTFNYB0bjdbZpOIAs0W?=
 =?us-ascii?Q?JWUNyc0THTwqBW2S8bmUVs51qrtfBYEqCETLi2gfV3kKXV0N+hh6kQJaPejv?=
 =?us-ascii?Q?gyPsu1Qm+fpFXAKU0MTJfLYDRL2Oq97g8g7yZ824RLMyG9UIKgVM1BYnyIy3?=
 =?us-ascii?Q?XDtLP9RX513dxSMDu2wySk73+nvWOqH0nyPCxho7qq/SPqASjsYa4XEhdmLX?=
 =?us-ascii?Q?RBUmDT1i/bNnGx5U5l0dlI4UxVW5CN/tSoFPVsBzoHjbftTC19G0JJr+kyRH?=
 =?us-ascii?Q?TUxVL5zy/CdLkClvzISn8n47diS3cwcckbN38/gW1Cl7Au8ki8/CmfaDsRf8?=
 =?us-ascii?Q?l10JdWNoULtC+R/c6xajnleYksAN56zsp5Xv1dSIfXLI74oG7lNkyw9tEGVm?=
 =?us-ascii?Q?5pRj6mqdiKGJKkftOXJXgWoO/sNGBO4Cnq8MMJtFjrOWKO54sfVpLsOgmav+?=
 =?us-ascii?Q?JktvynFXs4ls5EDVK9de7mcZgiOT4sypppYyCAD95PFkx8Lm40wSOixloZZp?=
 =?us-ascii?Q?Ygze82gIWvHRbdzEn7rRQ0MYO/8B3wQ6cM92riBdSk4AlC5wpkTk/YWLAkG3?=
 =?us-ascii?Q?SQ2shf+cziM1ipnmwnvRV40rY2XoRFklHCk/nZFTOofsuI1w8BCC9m9gsdXg?=
 =?us-ascii?Q?WV70pUOBg7BW4HKzI+PFSD/scXLmL6PJxVBIHZ34ZlUQY0LxyGS4+vQ/xDdT?=
 =?us-ascii?Q?YuA+9+8IXem174xRjWzPr05Rd9844hfCLxkyXipz32YLac/I3lMgbH5NmQpy?=
 =?us-ascii?Q?dThkigPkf69LW2gwgGzhX3tACqQilz7OvUZiYuV6dmK8/3serQ+ai+rFm6Ed?=
 =?us-ascii?Q?64pFpJtmDrqkR3d9qYhcimJ73tRVi5ltL51kItpl2umKkY3w2nStoZ0hxSj0?=
 =?us-ascii?Q?GEH7qwFbG+JoJ4j7FtirHSHpFcGVRoNe51lrjB+iMousoNuylunoiCdN0uEr?=
 =?us-ascii?Q?IzyTihpe3fpTRaILCD95+pJw9vhSAluquEO3O8p5llWypMdG5EilRLzzuXLf?=
 =?us-ascii?Q?azk+O2dzYPvwozFeYjnxRnYFwJF6x3Zg6NvfrwQc9Bo6kwcIwdwGS26AHYJw?=
 =?us-ascii?Q?lZNZQwBJwyVcwNICyeSBK2p0OcwtyGF32Z/YBv/Xsq20dQfciMlGCQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2JNVN1sTzO2gxNcXhTCK0opEG9W17dTTgiFEsaoOx2Bi6IxRpmm93qrO/Uvx?=
 =?us-ascii?Q?/PQ9TH1Y/Cvt8jwWXT6aEJiSHADj9bvwbK+weHfleCmsvU0nxx6xcZOiAW/8?=
 =?us-ascii?Q?4xrtfhVhqwBy18R0rAluHQbBbNu/X6ctVyilWQRJdDH5n5UOEj6havXKZTVt?=
 =?us-ascii?Q?JgCV2+6/9M3TvTzZwtcmt+NEfwA3oEZb86MebdR9SY5Y2wy/w43fYSsTprlh?=
 =?us-ascii?Q?tPDDqx3f8YYBjqANMOuvdCuPimB22TYBbo8roKruyax263Eyulb7RrJE9JyH?=
 =?us-ascii?Q?Z6V77/2Uhz98c4G+Og4F70gJzSBGOI4fGwWdIqE+Zsqvb25orDdQTyGSfINe?=
 =?us-ascii?Q?+eHZ7q0zz1ecLxP1jKpd+mYKSq3AFVMs3kZ3ffKWf8O5sOLkuF760GdnzWeC?=
 =?us-ascii?Q?Y1XbpFecmkzMpj1gxnEAFFcgNPMmORk+DFEWGJYmKtvXGyU284NTr6BFJlC3?=
 =?us-ascii?Q?JXX2qkE8QQn+5eUEAyk/5fAeWwYCGAKvwGZ+4m7Yyt7m6O88vvjxDrIzV+nK?=
 =?us-ascii?Q?+0z8QceyLSz1rXRcfoD2gWmFVzT60zhkza8ujnReXgkLSLvC0RTLl500UX7y?=
 =?us-ascii?Q?kAF6CLk0y8CiKShXR0mYRT2kpiXaPVbV7Jdk6ymu7D7CTAdRZIqSxKT4INKD?=
 =?us-ascii?Q?1fD2dqjWWDPtE9MVMhfAbitoWCs0vpmtcP2gHPwhyh3NK4us25DMGfE64JQs?=
 =?us-ascii?Q?Vm1AjpT3Ept++QR6KiHKDIoD/7gNMnihZ+edBxKSgtzX6h8cJKw66PlHaCp7?=
 =?us-ascii?Q?vls6WmItHWCuq0D8oNEDYrhQWGM5MzFMD6ifay6xtftjXNVyJGgLbCaQLgwd?=
 =?us-ascii?Q?sQsiT/5lG9hm+98s896zBC1F3w7hShvBBPOiveVX+EX6lP4/8dxWVjSCbgjD?=
 =?us-ascii?Q?RRdcKJeE+Htpnawwo5bwMjbmXzhTrkzn5/fBD2aJfFIdlvieOkCtkdXkADWi?=
 =?us-ascii?Q?1iADk3lO68Z85Zmjunkc1WWSROds+CBOqhi3S6+Jaque8besbmBKsUomqDBX?=
 =?us-ascii?Q?H649/5INlzU+fDtBfS3oqFBnbRNVdJfr37WAMKqH4kVtuWTJ3Dh4ueT1dLYb?=
 =?us-ascii?Q?kYgLE8dBp/iTdUQSZWsWHLInedrHsywn8cNbU53BCsfjUR+pR32nWah+huw0?=
 =?us-ascii?Q?lSrCgfWtavwqKGjlT0Xpsx3Yiinw2scp32V6rBfP9XrPaSGBbcna9UcjlU5y?=
 =?us-ascii?Q?Wern6ixzNR+FuJ53iSpBfat86SN2o8bNnA2XC3gYsjvl9Y57/0BKnIWY/nsU?=
 =?us-ascii?Q?0zBaG5OmWLboJtWfrmkwKgyQBDw9vIDlWw4gTAgDajOy17LiDHF0yxesGy4i?=
 =?us-ascii?Q?0l+QzVbCfuK/vVxIptfHg4xliBWZJbk6tTOTayr9/A+dwAw6WlfoPrlqOIlb?=
 =?us-ascii?Q?tSEpI6xAggu5b6+08NdxaVmkdCdugFeDBLKH4gL8JRqxekZck2rKyIMQXcPU?=
 =?us-ascii?Q?LxOcoMjLUCPLIUy/u9fn7AM7Sq9/yz1n+yxxdyIKRKIAcaOG/bgPgSp3w9eS?=
 =?us-ascii?Q?AkdedIUu4HcNqUmBOrFSxHmEVl96oePHO9usCYEk0Ygkku/CA3rRaNUGw4Wq?=
 =?us-ascii?Q?ZibOfwa0Bmtf0Mc3mmPnZu8DII5xjrEE54myJkin?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13fe6a90-5fee-477b-ea2a-08ddceb03d6f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 14:57:29.9211 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iNP4QMlwx1q619b9c2G1ex5xdMTWzZc5vICMY6BnlZ95630rtLvB+JMB5RjoQGULOcqRK/ijf7/qWgKTuv0HiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7991
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

On Tue, Jul 29, 2025 at 01:39:02PM +0200, Francesco Dolcini wrote:
>On Tue, Jul 29, 2025 at 02:21:19AM +0000, Alice Guo (OSS) wrote:
>> A0 has been dropped.
>
>Dropping support for A0 i.MX95 SoC variant in mainline U-Boot is not a
>decision from NXP.
>
>There are multiple boards around with such SoC variant, just dropping
>support for it with no explanation does not seem ok to me.

A0 may not goes into mass production, so I think it will phase out.
It would be better to update your boards to use B0.

Since B0 is here, continuing A0 does not make much sense.

Thanks
Peng

>
>Francesco
>
>
>
