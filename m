Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B39EDD46627
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 22:30:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7A3A83623;
	Thu, 15 Jan 2026 23:29:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="Ru3nGpaN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0530382BF2; Thu, 15 Jan 2026 23:05:43 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazolkn190120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d100::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F58980077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 23:05:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macromorgan@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ns6CKII7E38iWlga9zHOQclxSPY6X8JxRBBoxbBmYn29BflX5aGbvz8Wqc2Oj1QuD5yJUQKoBL29BZUWPxn8+IQp4HYo8DrgCVJhqZ8QX0e5C8o8Fm4WCkZph64tshL7tidjoWpfarc4BAJvlhg8tQTpBz8HFdXAzDkOjatygU7mg276M2+tehTwCBGDwN2M1E3Sg5LAOYqHJ7+m+HcBNUV0iyNxXFNNSwAwERykgUJrUsZXp3COFNIsqMRM01ra1TnjRkSt07wo18N7xlyQPi6wqrO+GSNJjKAbT9kYbEFSyUz30M56i0GXnVUAWRV/sy8yR2lGbr1QocCWvAq5zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yj7Eq1VkCYEPdi6Dh7ZAwoNtC0OlxzJaxPN8le1/iBg=;
 b=H+hOiEvwYIeIks6TN3aWvlIyHtkdlcOy4Y47hXU8Mqt32DJkaAwcvmQdBPD+MlngUsdG3NQKqmz76e0IifKSK9Eu12cbEDCJFjXXcizMU/r0iyeM8aNYHiG+rpj2tv6bNBb+l8WGRudWKN/ky1R0NNqRQySz2AS/3lcf23egAlG9rWCJU88nB3Eur0W0t3iMD7aTnwAPWwQ51geRYzStSO7LJPjDN9lkcXCtT2+Yu9buslElQKlrcJwmVqveKas7YGwtUobGOcHdwVQGlb4OCgpM+vf6QmPlmBc7pSu0wbzWQbM8J6b1ZjSAxe0g4is9ZIySPkEcIVnjsvP57cm70Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yj7Eq1VkCYEPdi6Dh7ZAwoNtC0OlxzJaxPN8le1/iBg=;
 b=Ru3nGpaNtuPHzp6rOTF5T16CzRGLrJawjkbu6uIfmTzbDFpsoRcwwOiRWF90ZyVnVCFxjxOEapnbkJFSaoSPIQACB9lG0z3mkmWnEawOlY1XH4FyjpFxWA6uhGSPORsfTBTDKUx3om6h9ZNRs9knpMrXwNYRZ0h+GX9nK2EAhHH+BCkV5Rqql/rduo7WW8N8rFsDZewT334Cw6WD828hjm0jzSaXLbTa+TjPOhozoCg35nRd/ymW5lB+WaxT5lLn7H8bPSuKl2NVdBojSb28908be+WM/TB5iLVtKfYt0GyiVjy8f+lh6hM95UoAgQPANnkzWxGnDaPM8g7jm8vSqg==
Received: from SN6PR1901MB4654.namprd19.prod.outlook.com (2603:10b6:805:b::18)
 by DS4PR19MB9124.namprd19.prod.outlook.com (2603:10b6:8:2ac::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 22:05:38 +0000
Received: from SN6PR1901MB4654.namprd19.prod.outlook.com
 ([fe80::57b1:b92:26fc:c937]) by SN6PR1901MB4654.namprd19.prod.outlook.com
 ([fe80::57b1:b92:26fc:c937%3]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 22:05:38 +0000
Date: Thu, 15 Jan 2026 16:05:34 -0600
From: Chris Morgan <macromorgan@hotmail.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de,
 thinhn@synopsys.com, neil.armstrong@linaro.org,
 quic_varada@quicinc.com, felipe.balbi@linux.intel.com,
 lukma@denx.de, trini@konsulko.com, marex@denx.de,
 Mian Yousaf Kaukab <yousaf.kaukab@intel.com>
Subject: Re: [PATCH 2/2] usb: dwc3: core: improve reset sequence
Message-ID: <SN6PR1901MB46543DF8F519327079CD3306A58CA@SN6PR1901MB4654.namprd19.prod.outlook.com>
References: <20251223231311.1983423-1-macroalpha82@gmail.com>
 <20251223231311.1983423-3-macroalpha82@gmail.com>
 <87h5sofnrn.fsf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h5sofnrn.fsf@kernel.org>
X-ClientProxiedBy: SN7PR04CA0112.namprd04.prod.outlook.com
 (2603:10b6:806:122::27) To SN6PR1901MB4654.namprd19.prod.outlook.com
 (2603:10b6:805:b::18)
X-Microsoft-Original-Message-ID: <aWlkruv6Fkb02QUu@wintermute.localhost.fail>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1901MB4654:EE_|DS4PR19MB9124:EE_
X-MS-Office365-Filtering-Correlation-Id: ece25f62-c7b8-4182-2f1d-08de548236f4
X-MS-Exchange-SLBlob-MailProps: znQPCv1HvwXZ5XHxNrJCjRnjimRBgM6SaygUxrMue+Y1dFum/ylTwJZ4YHV8Fg97O5WioCRqycvtOKzNXxGG1noi+pQ6GIW+XnQDoSeyPsk/p8axgG4G09RQBiYu4NpV0coOQ5MIHyQgqlsYz1iDqg3Udv4x1kK6FETq7GMBxlO+F5U/aQW5noSaTaTdLuCek3UxfXFDr1KxQeAI8HWlnjCi/ktaWkwuoq4bdKf7hsr938/MkDV1lLd5PWX4H66nCQymuk28obTYClMtTSBOVO9vNAgkfxUTDPS33LHLmElG0xMKTGL0N0fbjBksF/R0+0CnY34kXxp5XA6YqGAQX823kq3LRzjs1dnd3qcMXZqW1ZHS9lbe+Vr2fxL/9WoZiwRM/MjxS9CeJvlpDx9QSAtbz1vm0JjrBaYTJwyXRqoDkERfZNtc77rDeQ48EmcNITPH9mWESm7+7DnwyEjTHhko3EFl8UdZZ23LeSLgkCPZt/xkbvSocAIEgEKT85YBK/SrzKhtrdyk2k/Y3chazhDoowFX2gUhAvw14H9E8q9WLqTbOf4ZWjWRmK+RfUNcceBX7cs8jq7mlQf9r2s4nbLp8tsDQaUFbUFG7MXG0hVrde84Cl0Jvzkr/QmZYtFEQDmy2iy6i0n04rxw0nKHhwX2eBA9qSs/q7t7IXCnip03pYw3Xm+D1FN9yRfHtHTM+9u/jeg3E/ZOz5BniGU0N+FdM3Hi8R9supeixez2golXvI9lxYjrkdXKhWfW2UQkQHI7+/YQ2ng=
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|19110799012|461199028|8060799015|12121999013|39105399006|23021999003|6090799003|5072599009|15080799012|13031999003|21061999006|41001999006|1602099012|4302099013|440099028|3412199025|40105399003|10035399007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9OVs5YEAFLcI8LycQ2JKtAoNDj2iEISOzmL1BwjKXfvuIE2qlR+0jiG6blLI?=
 =?us-ascii?Q?xiR4Drd/4rfqwL4BiOOvofBmGMTuvveZbrvkrVs72tOftuka4iMQq/HHMnoF?=
 =?us-ascii?Q?cfQK84trupzUSe2CY34/IOKbReZPr3LrYjC/TdfoCpYz+hBC6l5ltpby5FOy?=
 =?us-ascii?Q?XHc5ZxoJODDowUODFxUHPRJ00cqf2ODIdZY9qkBifeN8Iodh5lK65+strUdr?=
 =?us-ascii?Q?KNB5XTFb4JsvA990L/2kEBXRaqQeDDGRUAFsIbQ0N8VG8RoWifJtqlLgT+Vt?=
 =?us-ascii?Q?cNBl9pG8tBvF2eshfQAgI4z0/MqRWTiEhzBADku2y8sDdyBdBD1X5OsTVOrd?=
 =?us-ascii?Q?dTDHMqSLnMA/1GPw5P1uOLyUxL6W4ug+VwtT5jCYgdoRbY3esYbFXPFSfrMq?=
 =?us-ascii?Q?DJ3ELNSN4E0Tv9OEI/pQ7WjqnHHiXwZAUmBbLuIPWzmQi8HYRGKAGJ9FDkt/?=
 =?us-ascii?Q?it21ACvVTj690zU4JkOo3fzm4KxqN+rVV0qPTLtnf12Fa1H5IA2x+TTNhd+E?=
 =?us-ascii?Q?xgXWR3XZBqjl2k5ZFkTiHAnYrPWALdYrtQy6jW7lW3VpywYoKmEFZyuZ9z9R?=
 =?us-ascii?Q?Mtk1FFCBSI4kx3032JYz54x/IoAaX1+3FBQlCkH9Og+ZRW9yyWwfMEq5BvTI?=
 =?us-ascii?Q?F619Qicd58NcxJ2XD3FJ9TJkvjUBYxp6hLgg8QFvGIQkZUuZ4Eaay6ZA2y6Z?=
 =?us-ascii?Q?4QO1SLIVe3/naByF+jT7fNyacAVVE7CMyJCqgoOXnB6LvRUTq5qyk71c5aFn?=
 =?us-ascii?Q?giBzhc6Z4FkZA92Z3QspES5r5v4ZR2g5CH27vaavjO9Jppu4/Qnik0ZEvj2/?=
 =?us-ascii?Q?B5hviHQEK6UkV1CYH0fJWio5Hse9WtRSGW6276ckZT4W6IK2Qg2hXYCXDyAy?=
 =?us-ascii?Q?jL6qVe2VWP0wd1tbu7I8UTFtKcHJ+gsHiGca0VxbaHHI9dBZzq2Jl/AD+Dsv?=
 =?us-ascii?Q?mhfoPfVgdZlWlxMOQaFJFxom8ygXXm11xzB1UuGqpbTQAhRV+jicxDQZJuOI?=
 =?us-ascii?Q?ie2pm/y9V6l1I3AJlYBR3TdiGn74pGS1um2rQwo1KAiFrYpn+a8H5yKjhUbK?=
 =?us-ascii?Q?ZUUea2rxgBnWYSHEgHgB0VA0OR/NKO2M+ze9+He/OIRsXzIY+moIYdpX+DrJ?=
 =?us-ascii?Q?Q4TxsARaR4wcUqruZR6Fk3jvbRFOzEhrSlI07erB1BhZeV5clXI3GnoAzdB8?=
 =?us-ascii?Q?MzJEtyZ12Igsx30bXjvonWz7ULbJUFjrnpV4DhusqptxScfkTYHXlKpIXN0i?=
 =?us-ascii?Q?m6RovS0GFaotzNE3UT26wYzf0Yr89tPFoDDEirBLu/vPwqPVIKyNQBJBSE1h?=
 =?us-ascii?Q?6aJCMT6r6ssnF0R/iNibaONe7w/6RIVv7TUsEflGcLpIo8A/BcZi7uOFZ16N?=
 =?us-ascii?Q?lqoWNKn/CA1BnMyXYpAyZlVT8vG1dM0HSr4ps6lJbm/d/mgBbzFlQ8Wm/4g3?=
 =?us-ascii?Q?26f1ojq8X+H5L/FiPBhCvigyEsn3imBRGN0ioFVualQD7E86IGfahQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6qP/UkvqHGtbTGqxipkndxl5gPkQ8K4fAt6pBpivIlstk9hfJSBpy2M4qVEn?=
 =?us-ascii?Q?GEmvBou1zFKPkri9XiAVUMfnXCAFjeiafzJa/j6ktD3aI6duRZyh7kha9Fdz?=
 =?us-ascii?Q?FCfcR2ozguL7lEo/K6osJ8siNRQoWa8gJFYhGkCf+7D8OCjQHeJlxeIa5RCT?=
 =?us-ascii?Q?+Y776S4AuJhWDIQRn7InrreDVSdz1J8sNR/MDcTcVvS9a4WZPm5GekL67Xls?=
 =?us-ascii?Q?4OPytGpGdezdZcMgJJioJnKIvQD6wQ3119xLnnPCMpWExoq6Gfg4XHYSJIUu?=
 =?us-ascii?Q?+uXLu1ncoKFht/nwXwAk1VvQSBvwM4ayQLBFdy4ZreN6VR1FssCE6tx7u2GO?=
 =?us-ascii?Q?lVuDBkXMhOxMVXiRBYedLI3LAwDW/G6w91vARBxaDunmaD8IW6tdoT1pUnh2?=
 =?us-ascii?Q?K2vRB3fZSbR4OOhZaOqOs8ao5bFdjEXcOoJXoUyuKRqbFKaiI1j1+W0q4FY1?=
 =?us-ascii?Q?5hL7aWF4uRi4f58seFvUzh54WZo4/qBEjMKyWpYFhJli28owbkPiKwDQF/hR?=
 =?us-ascii?Q?Pakxm3pW1rHSaKDtY5j+CJJAJGFOS1Tf4M/kkefllCyu5nuuemHb4NYUDS6c?=
 =?us-ascii?Q?zspqiXf58eVogWLIxoAyJY1sUJoyg/WopngXTlLjLnJlNeSoaU1PoDi/iCFA?=
 =?us-ascii?Q?NPFYyFWPtr+VSRagFzAwnOGYAYSggnwmpnxXuZCn/1fwDmcpop6RAcDV/fGq?=
 =?us-ascii?Q?4p+chNTW7Io15UAds9LVn7a+zq4eX86vWmcWyvamIfPh5R9FPFIPED0SdmE4?=
 =?us-ascii?Q?AHh2W24Bf6Ixtg1nTL+ejT7px1B2E6nXWITzzb6i2sDxM5sBjIonD00WYVGw?=
 =?us-ascii?Q?9LO/6wG4Crdm1LLvw6D2VkyO2AG79uOx01ClMHj5pWsI3M0iaqYqwg1ULsBh?=
 =?us-ascii?Q?7oTBJ9JFzTPpQg5nUTVKBNWZZvHdh4bevzyamMcHlP2wkMbLYqKAg19hdLIA?=
 =?us-ascii?Q?iqxtJr2i8iyEKf3qvVD598nxBKUzzv12eTCn0R2pBJHNnBsggt0nowCSLXY1?=
 =?us-ascii?Q?Ky0eXjd6riweEbSGRL0CccKjwSkBXOcwgPiTHNt8AyM5wCLWcE0hKsWHtKZY?=
 =?us-ascii?Q?8LRLCw/nvlRWbDspmxI3iITxh0rYhMK7dFkmAauYYeaNPcnvVlAQWLFBI11r?=
 =?us-ascii?Q?CnEgratB6Qv7l4wZSAikhQdfBq0wEV81vLnHCyu5hDCi60bAfJvmzww06Bjl?=
 =?us-ascii?Q?LmDlY8k5/OexxtejPakYrZH9+kQIRrAQdmxTt6fQbfztezIBPBthhPv78YPG?=
 =?us-ascii?Q?LL1WPtcTikA18VBJm4hZiW64/USim4j5qne4MnLh0AGFhdyy3D4EmFca0F68?=
 =?us-ascii?Q?I8cW4IXlPQ8xDPECYdRDKNqoiu8jD02YO1rEvlMEKB4hsJQOmy2s+qua1SnY?=
 =?us-ascii?Q?bu5wymBMvbl5eeLu9ol8r9ApyyDSZZa3UzvLm2Zzo5hrIaOPjA=3D=3D?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-6f20a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ece25f62-c7b8-4182-2f1d-08de548236f4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1901MB4654.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 22:05:38.5135 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR19MB9124
X-Mailman-Approved-At: Thu, 15 Jan 2026 23:29:05 +0100
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

On Wed, Jan 14, 2026 at 12:15:56PM +0100, Mattijs Korpershoek wrote:
> Hi Chris,
> 
> Thank you for the patch and sorry for the review delay.
> 
> On Tue, Dec 23, 2025 at 17:13, Chris Morgan <macroalpha82@gmail.com> wrote:
> 
> > From: Chris Morgan <macromorgan@hotmail.com>
> >
> > According to Synopsys Databook, we shouldn't be
> > relying on GCTL.CORESOFTRESET bit as that's only for
> > debugging purposes. Instead, let's use DCTL.CSFTRST
> > if we're OTG or PERIPHERAL mode.
> >
> > Host side block will be reset by XHCI driver if
> > necessary. Note that this reduces amount of time
> > spent on dwc3_probe() by a long margin.
> >
> > We're still gonna wait for reset to finish for a
> > long time (default to 1ms max), but tests show that
> > the reset polling loop executed at most 19 times
> > (modprobe dwc3 && modprobe -r dwc3 executed 1000
> > times in a row).
> >
> > Note that this patch was submitted to Linux in 2016 [1], however I can
> > confirm it is needed to support gadget mode in U-Boot on my device.
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/patch/drivers/usb/dwc3?id=f59dcab176293b646e1358144c93c58c3cda2813
> >
> > Suggested-by: Mian Yousaf Kaukab <yousaf.kaukab@intel.com>
> > Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > ---
> >  drivers/usb/dwc3/core.c | 31 +++++++++++++++++++++----------
> >  1 file changed, 21 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index 847fa1f82c3..b4de2e95a0d 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -59,11 +59,20 @@ static void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
> >  static int dwc3_core_soft_reset(struct dwc3 *dwc)
> >  {
> >  	u32		reg;
> > +	int		retries = 1000;
> >  
> > -	/* Before Resetting PHY, put Core in Reset */
> > -	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
> > -	reg |= DWC3_GCTL_CORESOFTRESET;
> > -	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
> > +	/*
> > +	 * We're resetting only the device side because, if we're in host mode,
> > +	 * XHCI driver will reset the host block. If dwc3 was configured for
> > +	 * host-only mode, then we can return early.
> > +	 */
> > +	if (dwc->dr_mode == USB_DR_MODE_HOST)
> > +		return 0;
> > +
> > +	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
> > +	reg |= DWC3_DCTL_CSFTRST;
> > +	reg &= ~DWC3_DCTL_RUN_STOP;
> > +	dwc3_gadget_dctl_write_safe(dwc, reg);
> >  
> >  	/* Assert USB3 PHY reset */
> >  	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
> 
> Looking more closely at [1], I can see that /* Assert USB3 PHY reset */
> and  /* Assert USB2 PHY reset */  have also been removed in that patch
> (in linux)
> 
> Can you please explain why it has not been removed in the U-Boot
> version?
> Please add details of that in the commit message.

I don't remember honestly, I think I kept that there because I wasn't
entirely sure if it was still necessary by other boards or not. For v2
what I'm going to do instead is basically port the
dwc3_core_soft_reset() function as it exists today in the mainline
v6.19-rc5 branch and implement that here instead. So at least this
function will be identical to Linux. I can confirm doing so does work
on my board and continues to resolve the problems I had previously.

> 
> > @@ -87,12 +96,14 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
> >  	reg &= ~DWC3_GUSB2PHYCFG_PHYSOFTRST;
> >  	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
> >  
> > -	mdelay(100);
> > +	do {
> > +		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
> > +		if (!(reg & DWC3_DCTL_CSFTRST))
> > +			return 0;
> > +		udelay(1);
> > +	} while (--retries);
> >  
> > -	/* After PHYs are stable we can take Core out of reset state */
> > -	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
> > -	reg &= ~DWC3_GCTL_CORESOFTRESET;
> > -	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
> > +	return -ETIMEDOUT;
> >  
> >  	return 0;
> >  }
> > @@ -137,7 +148,7 @@ static void dwc3_ref_clk_period(struct dwc3 *dwc)
> >  
> >  	if (dwc->ref_clk) {
> >  		rate = clk_get_rate(dwc->ref_clk);
> > -		if (!rate)
> > +		if (!rate || (long)rate < 0)
> 
> Is this a spurious change? it does not appear in the linux version of
> the patch and also seems unrelated to soft reset.
> 

Spurious change, the device works fine without it as far as I can tell.

> >  			return;
> >  		period = NSEC_PER_SEC / rate;
> >  	} else {
> > -- 
> > 2.43.0

Thank you,
Chris
