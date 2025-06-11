Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E15C71135
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 23:36:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD4F382977;
	Thu, 12 Jun 2025 01:36:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="GbNiToC4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99B6482A4B; Thu, 12 Jun 2025 01:36:33 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62D7D800C1
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 01:36:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fddt83Vu5vyIVB/SEb0fM3KF68ajW3j5BdaJ2F1X4opVUHqgUIyXUWqRnlo5k4xezbf35cSyGX6VzJmCGx2No51xkFAoAaPmeAYeugvywXKxY0dEPzo4/RDbrk4TG0DYkkuU+J3p5KUNhUjvx2P7vKMzEKkWEs8iJs92B+6k0Aa3CukCdardLrPgkZLMLF/cV+BXKClimw9RJlMsqMgWLact5dwdbAmnr8RtfY1cmEFcW2pSPN8z3MJ10e8OVrwIQZckrQmIwqIKuABZWIDoaozlyeQKVHVGgc/cnvfPSlk6j2Uwopx/RuDy0++LF4CY/MHKZnrf78fQJFlG1Is5Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfqxD8vX7ZuYxiD3cohU0c8SzyZX7oH2e/g9DrKtq34=;
 b=cMHbFbYAcV5gOE9bDO6VfDxLfQrSeX12BH+dOH9zYNf3P/tNPx+zHCOmUEVSJDqkTAt2pvql1R1qJVRtE3naeo2DTlq5E3NXev0J205WvjCttawCsR1gzZO3ucYELvlT34p0zoSjdzC2KVR4SOM3R694fAOtcugOMMbNRGAFskQHYYODdlvtdiJUkLw8myowsRM92xLmG3NnJAwgueh5uQHIQYbzKyV4JlZ64mUVnyixQBbEzjIQblGEWbiCIF6d6VhKXosk9cV2UTxASOpXoAfbaQARVjaVLs4GXne+2FavZhyEE8iTRBF0gLxuFSfyK4W5PubyBwFjWeXQFcN36A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfqxD8vX7ZuYxiD3cohU0c8SzyZX7oH2e/g9DrKtq34=;
 b=GbNiToC49RTjEQr136TZTf7OBy9VKG/BPGRqjrav/H+odXcQ0b1KF5TcYSBgNE21JEVXkAb9g7JrWOyQdaa3gZzc5ST5B864MdpFOc71X5lOQWyiiiCCRA7QNhQoGwrndO1KXn4Yq0/LUldhTS64kweIzOguHFhavvi9mildaXIA+zQyNlkvoN3HuRj+6vMeUgHndaE+HRSEfbX6VcX2kVZLgo7GG+QbRNqQRv1NdCxbHPJ3386zuEWQvgcpjts4qa9NW80Xs04mU1DdphfF3fgB3qTaksGP8hrRQ7lKAyEFQWdEkdKz2/yUoQQoDhMIESgKoJfZFoWc6yJRCJ3RlQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.31; Wed, 11 Jun
 2025 23:36:28 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 23:36:28 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Heiko Thiery <heiko.thiery@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>
Subject: RE: [PATCH] mmc: Kconfig: Really correct dependencies SDHCI ADMA
 options
Thread-Topic: [PATCH] mmc: Kconfig: Really correct dependencies SDHCI ADMA
 options
Thread-Index: AQHb2tyC1h5E51ksEE2aCwD0tuNf4rP+nPEw
Date: Wed, 11 Jun 2025 23:36:28 +0000
Message-ID: <PAXPR04MB84594967B3EBF26ECF83B3B28875A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250611142352.3990076-1-trini@konsulko.com>
In-Reply-To: <20250611142352.3990076-1-trini@konsulko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PA3PR04MB11153:EE_
x-ms-office365-filtering-correlation-id: 4847ea75-ba96-4b84-d938-08dda940c9f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?NDd7lsmC0W+lVCNh2Xt5bbEMuDfiD6vXoRjstBKMu3EhbMrTqfxHToBlCZgw?=
 =?us-ascii?Q?H/+kFbf/wlL163OzAthtYy1kBK1TATBI0jujYXbCr9FBZAsnzEDEur3Xqac0?=
 =?us-ascii?Q?gbZRfkFdWUiu+umH0DyFEP/WskD4z6WusrpqL5qhO2km//K36gc5UNqo6yKE?=
 =?us-ascii?Q?XUySsL0IBE/DU/Pl6CrDrvKr2MaRB03RGTwo6a++QJc/04+nKO3yB07ebc0b?=
 =?us-ascii?Q?iBYD14jtvAhyDpNoW6UXBg3eN4L27bLUyiiQgweB91F/l22/sB6mDzuLFhhf?=
 =?us-ascii?Q?hNBsOitzpQCXOzbPhT+6XFw/1EZg66j3QDklJznKTK0eiab8kpM34/HmbIpb?=
 =?us-ascii?Q?Wbd/1+MyKLoLtUq5oUV1fNctwwzpjmcrdOKnxbqXmx1yOln3QNisuNuem8+I?=
 =?us-ascii?Q?bC3DTIDcqWBfN23fUnbdQ0TdN28S1FPmKVv8m90OSnKbTiHlIU+nG5sxtbiw?=
 =?us-ascii?Q?3y2u9TrjGxWRyfkcK8BqD9GeqX9dGl1th4QqwhwEX69NtFdO/AVljvb7nZYQ?=
 =?us-ascii?Q?HaZpOubHXVz+WSatlzTsqOpJWK+JXfMfzZkwJN0MrMXdbDRWC9L8j8YUQQTJ?=
 =?us-ascii?Q?It+JW7djyHvi2+6CL/DNw9KtE9/IDYGpoCUM9WtzJ+ZcTqx01RKwxBhm4Fiy?=
 =?us-ascii?Q?39vZRDeK1bvbY+LkkPWLqoj6s1juNTIYiTK2gFub+NBBtmowVv5EbEK0qeUe?=
 =?us-ascii?Q?eSTNmF8tmrg/vOyqBiVxLqz7b3wm2ZxyEfFm3tCW2AGOepuFWaTNZyDwIL+0?=
 =?us-ascii?Q?PCMfV9N/7ojplYIVn3/eEyYjJd1JDX2BrYQMr4h7SgdJURcwJgf3kI7Z898u?=
 =?us-ascii?Q?KPDZNH6PIVA5OSqz81mb+0q92A6SMf1+aMUTueFmFjwg7pxTqnRtS9qDA6Zv?=
 =?us-ascii?Q?Pb62Sg3AZwmy8yY4WRqRYt+jWM3sAc+EwoRQiJKsZDJQzrzi48GclKO2uWY5?=
 =?us-ascii?Q?8S/Kj080hsx4Fa8YV2vyPiVWrXWWmCCd9kaEapUKa1FdLJddEzlB/4JBVtKk?=
 =?us-ascii?Q?0wQVJaM1ERvNptU2IKzGkLK8D4aH3SCTGLItFClSN1F/5VShbwWiibNxjY9N?=
 =?us-ascii?Q?/totNdvpKPRfao4bIJniY3Zx6luXvhjvtueLtUd2GKQl0zG15I7iS1cpQqYE?=
 =?us-ascii?Q?2zImF4UtvhtTJCQydrxC4qmEpxtP7b1aEjQ1hZq69Zc+CQfQ3DfGYFB9DV3a?=
 =?us-ascii?Q?3qBJnSEs6jRHSS3XvInkGfaU0ENomP2LVwZDO0+PF/JnFGJ1rDNCb6NxSmKO?=
 =?us-ascii?Q?uGd2Il06BnCQTLu7yNFfZYugJRc6mPdmjxCitl4a871Exuv2uyGAf4Ekskjd?=
 =?us-ascii?Q?WKxJUxx0qCfgHvzHLwsSV5ZRswaQ/qLq4hWVQApyjy45HKi5jJYoD29kcaKX?=
 =?us-ascii?Q?KCAOJ6qMvGLmk2M9YgX/Gk5K7GQBeRI1BkLGWUgN1kY30o/VH/jIVlIO4zEG?=
 =?us-ascii?Q?3eP42Q40BjVHuYIt7bz0xMUSWRYR4UQHiN0Yedaj34OHoDmgXVsBxA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2iuncRnacVYjJ+jvhxjLs2FMhGVh3Wfi4HXBM3JLLgnnkH5n5Vd4tK10fTZh?=
 =?us-ascii?Q?7WFCqo0ryIj7/emkn/hxb8usoI/57ERyXiFeSQ3omm5LwfS89T2UGo5VIoZA?=
 =?us-ascii?Q?xvYOe3JxkNkAJ1seY217/oknmFUbuvnm+GpEtf3lFzOu745akgjotpChuSXB?=
 =?us-ascii?Q?uDlO2x5eqZYv1HYZex56XEtDA+thN3YqQ+1hMN/2wJL5aDd/gI6pXJFzu89a?=
 =?us-ascii?Q?E9e224aSZ3gDN3AjsQ3Hh2UfwyflAfUYiUp1Fz+WB8tQKmWVCW+r9pLlk4N0?=
 =?us-ascii?Q?+xHRtaTS0Yc4PMTwpPRkd5r4Qyrb19R3SxYnwGTEjOIrWVTM/oYygJQJYWmw?=
 =?us-ascii?Q?5FFW49vfBNutqWEDmIthQZALSv9Z67ZvDmWO2jx4t+EsCfjN9jPQmm3FH6zK?=
 =?us-ascii?Q?ayLZDncU2sjO9titTV2RKZTc7OITJOkpk/0LoAgw11A6LDSro8s+AJtx1g31?=
 =?us-ascii?Q?/ZfFveCeYXCp99z5Lu0QjrXp7/JodISukeFmQALcvi7Deja8As9DWNc9axYx?=
 =?us-ascii?Q?l8U26iTp2NiIiD8bEUhXIkpbV/LRlFrIV1zXV9GG5j+3coDuDEjx+P385Anx?=
 =?us-ascii?Q?V8+n1dG8dpx3JtgsKJhdRJZ3MhSAKnnu6FPS+tOP2+A8/zCCZkf0F9//zKyK?=
 =?us-ascii?Q?O7y9R2O/KHeejr40g5v8r8mSAsIN7wJpR+o3P/r1dO98WpjhuGhQHiermWlG?=
 =?us-ascii?Q?ebHaZsLFr4xBfG+rrt/nq46SrYGHHKaY8LL6cU3LTYkIYP8LYxzJvTvZLqaS?=
 =?us-ascii?Q?EaOtltd7OCU5COe3DAoqpTSF6HyuyEADF6AIBIQncljSrNy694GpQUGACrBR?=
 =?us-ascii?Q?9tjlJLUgSsqtLakIssrAU+u6Z5cwT3l1DigGrI1oSI3XcGjxH4EoTtGJUr8q?=
 =?us-ascii?Q?9w/d1Ylj4AeDyEneP6G4+vApT0xl9YE0w2e4CuuQymgqep5Z54s+ONWdndoh?=
 =?us-ascii?Q?D9OdgxS92g31pzt7PTunBuUKIpPG1yWop78Fi7waUUz/qubjUsb06S/aurKy?=
 =?us-ascii?Q?HjhZCj2zjYWz3O/5RqX9NGe0so+oHezhmQUYe5pGmKVuGuDVHCCcSDTod0Hx?=
 =?us-ascii?Q?OEtDh+6xYJSotVbwy/TtJSNhAFskqunEXynYnUpp1skhroV32vFOSKxDIXGG?=
 =?us-ascii?Q?6P4TST9ArXaATnHrPIsexQPBfDxoY0ZDwE1Hegq+J5VtZarbaQpcuXcq5No9?=
 =?us-ascii?Q?v0zjROWMeoF2AyQP1M8pxPKzUEjFdgUFMN6P0XwSS3pFtXsa76Ghh3Qo3oOT?=
 =?us-ascii?Q?fbpWw+bnjxTImr6FjnyURmDqZGzOdfyPEl9geHhtfccvaPzPBUc8xQpaJgJ/?=
 =?us-ascii?Q?YiVKgIJ4psuqKgq/pChZXOtbO9R8dZR89W3rR/iMfguXIabTgfF0avv+DVTa?=
 =?us-ascii?Q?xIbLZU/+wvWbiMrO3BGFDdmr7TskCFIESkZL3V9uPW4/o1mvg6kC94OgihP0?=
 =?us-ascii?Q?9/3+gUPE66vuzj80Qjbb2QCsF0u+FgI3RdXTHDSPsS/+uffBOL2yN9u3FYJF?=
 =?us-ascii?Q?NPmSoE1qtPDoUfO1JgddLq8kBxl/iT2niR/WPuxD0WuBalUPJudI+4JVoPKs?=
 =?us-ascii?Q?KkZaskMvdhdFW9v9wQs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4847ea75-ba96-4b84-d938-08dda940c9f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2025 23:36:28.7500 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kdkrTrxMv78DukNZI6TVxYgfMbByOWKvyQiJb41XQ/qZ5biHNBGW3gwySwN+CbOI7HoW0TgDH6SqAXm4wcGQ9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11153
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

Hi Tom,

> Subject: [PATCH] mmc: Kconfig: Really correct dependencies SDHCI
> ADMA options

Thanks for fixing this.

>=20
> When doing the investigation for commit 53bb8fdea12a ("mmc:
> Kconfig:
> Correct dependencies SDHCI ADMA options") I missed the implications
> of MMC_SDHCI_ADMA_HELPERS. The problem is that FSL_ESDHC via
> the
> FSL_ESDHC_SUPPORT_ADMA2 option will also enable these helper
> functions.
> This in turn means the correct dependency here is
> MMC_SDHCI_ADMA_HELPERS and not *MMC_SDHCI_ADMA.
>=20
> Reported-by: Heiko Thiery <heiko.thiery@gmail.com>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> This is a regression vs v2025.04 and so I want to get this in for this
> release. Should I apply it directly or will there be an MMC PR for it?
> Thanks!

Please pick it up directly.

Thanks,
Peng.
>=20
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/mmc/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig index
> 38867f30a7eb..1c9b6898bff4 100644
> --- a/drivers/mmc/Kconfig
> +++ b/drivers/mmc/Kconfig
> @@ -528,7 +528,7 @@ config SPL_MMC_SDHCI_ADMA
>=20
>  config MMC_SDHCI_ADMA_FORCE_32BIT
>  	bool "Force 32 bit mode for ADMA on 64 bit platforms"
> -	depends on MMC_SDHCI_ADMA || SPL_MMC_SDHCI_ADMA
> +	depends on MMC_SDHCI_ADMA_HELPERS
>  	help
>  	  This forces SDHCI ADMA to be built for 32 bit descriptors,
> even
>  	  on a 64 bit platform where they would otherwise be assumed
> to @@ -538,7 +538,7 @@ config MMC_SDHCI_ADMA_FORCE_32BIT
>=20
>  config MMC_SDHCI_ADMA_64BIT
>  	bool "Use SHDCI ADMA with 64 bit descriptors"
> -	depends on MMC_SDHCI_ADMA || SPL_MMC_SDHCI_ADMA
> +	depends on MMC_SDHCI_ADMA_HELPERS
>  	depends on !MMC_SDHCI_ADMA_FORCE_32BIT
>  	default y if DMA_ADDR_T_64BIT
>  	help
> --
> 2.43.0

