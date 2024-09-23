Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E0BCF9C73
	for <u-boot@archiver.kernel.org>; Tue, 24 Sep 2024 02:14:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42EEA88BFC;
	Tue, 24 Sep 2024 04:13:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="DNNKNRyv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F96C88A4C; Mon, 23 Sep 2024 19:38:33 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12olkn20807.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2c18::807])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7635D88770
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 19:38:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macromorgan@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R77OVBxoNoXn3KAVg7oDUFEf9MiGUTMnlKTj/t1RZRxawfCE2wSdIAOEwVXZW5YBtPsle+q8SWRKrrycXsdbDP5wXSprqY/sGVd/JOuqNvMrvRdgxb42ywwAf1EZoxwaiSIf9wkOW1EgBAO94IsLrCkHbtuqW+FrwTEBjPhNuF/DjHaExLFMWPw6T/8EibIb2VLSEk8oncs+t387WISGW+q4rP8UhgBTgebtZkMObmLeScvMOna2acVz/8s9aI1UKwqqaBA9pdAG0IOV3O63/8OpbqK3APHciCFj7UHL4+6BpFd8w5/eJrvS5ZaVW1InxyPXoQFLX0Xhl5Bsd1HU/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1K3SFA/E6cbnlS3rdYnvneqBmxkZNPlmErurCsYOyRU=;
 b=e0Jakwyr5KTZfoaSGKiEacoEetS1VzKq+vmtvJ2zCPVUq0wS3/T/N35QFEgEvhd4NnZQyT6nm9IK0BY+/c4lE/NyO1Y5nuf9nX0tx5M62AtOkovCdgFgMrwHBb25J4VC7IqPTubZ+pIIUinLCUfZ35AG8gpVf1av+dGQM7XpB6lhLR/0VEnrp7LJ1iDhpqe3QBzN+/YIXJ0gZjWC8v+B6x/e5stDDOXRCQt3y93q9N+5qWqwmgcR391oGgkS3RzY9tt2xh1Y2V5fSaZ5tX6k8eL11PJJECvWJrvMKF1sdn1Y7yY/eOpdoc+qUMziktChjoCTR1zFcAhyhYalHUuEDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1K3SFA/E6cbnlS3rdYnvneqBmxkZNPlmErurCsYOyRU=;
 b=DNNKNRyvPxdt1tSGBxPzrgD3dMIEK8cIucMsUBIs8wsa1yyyZ9WH+ZcE981BOmwFH3t+i/weTiX1PC6TPrC36qZgxYDghne4mRVQpcaUgpCLNnNKqi1jBsvLxfkgivVGqPU5yiRxdmjq+fwclfi4B9uUnM/5V2GKjkumY7/+5ALLK67BBoJsdQi6r3jjVw88zYupD9BZCH8sdyTGoEISnMuAfg0y2MRlpo/lnpeEzfWwGTStbl0Lb6FPlkaeCX3FJ5Su7UA5GC6YmPwuPftBlDeiWSUTyhsUrxFLL01oC4lTRAJ3cUozmAIjGhMf+EMdKumoxHi5m0DPph7egOQfug==
Received: from MN2PR16MB2941.namprd16.prod.outlook.com (2603:10b6:208:e1::15)
 by SA1PR16MB4706.namprd16.prod.outlook.com (2603:10b6:806:229::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 17:38:28 +0000
Received: from MN2PR16MB2941.namprd16.prod.outlook.com
 ([fe80::9d62:95ae:c373:c490]) by MN2PR16MB2941.namprd16.prod.outlook.com
 ([fe80::9d62:95ae:c373:c490%5]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 17:38:28 +0000
Date: Mon, 23 Sep 2024 12:38:25 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de,
 jonas@kwiboo.se, trini@konsulko.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org, dsimic@manjaro.org
Subject: Re: [PATCH V2 4/4] board: rockchip: Enable PD_VO before driver access
Message-ID: <MN2PR16MB2941B5324EEF8193605018F1A56F2@MN2PR16MB2941.namprd16.prod.outlook.com>
References: <20240919140022.511067-1-macroalpha82@gmail.com>
 <20240919140022.511067-5-macroalpha82@gmail.com>
 <da41ca54-871e-4e40-b7c8-626a3c4a3f1a@cherry.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da41ca54-871e-4e40-b7c8-626a3c4a3f1a@cherry.de>
X-ClientProxiedBy: SN7PR04CA0056.namprd04.prod.outlook.com
 (2603:10b6:806:120::31) To MN2PR16MB2941.namprd16.prod.outlook.com
 (2603:10b6:208:e1::15)
X-Microsoft-Original-Message-ID: <ZvGnkTEnUxS+p/Cn@wintermute.localhost.fail>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR16MB2941:EE_|SA1PR16MB4706:EE_
X-MS-Office365-Filtering-Correlation-Id: b72d8658-c7d2-4006-b60f-08dcdbf688b1
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|15080799006|7092599003|19110799003|461199028|8060799006|5072599009|6090799003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: L67wgAu830BJucn3/tTNcJX2fzr35B9G/vafwcZ2L6kfY+0bEl+anl+kwHiJBLuuhoTvLnr+ymx7+KphxgdC+Z1Y11TYMzJXq3ocxQzTarBVeYVKwg9wPYvDN5CZ7tgt9KXkb5ndIbzLsee2fmYcs/wnxSyounmuWUz3NTM9LOJwWWUlFSVriuJBS4/dRlUXEx++QsX4CWuE9uW72Z+HU9nAqMbMiL1eoTwp+Mb4R7z0ED2Geajen8dVVFmnrhUVdWVU8OXiEZuXGEWao8mWrUG6DNzCwyYyTUyQR+x7RJMLbs6LJGmNmApBkOpCl6gUFD4RaXfft2SomDdBJCSVy+80J7GF1mqS4DKlp22DTgCHh0glWnSloR25ea4oo0sHYg5UjTr9+XB7h4ZymeWCGezIGoaOm/9/aYpxQ+mly4V3zNC4k97DsRfhOtc999P+MnODJhWbSTpeBNiz/X/PlTnQc7ZdSKJKjhBEH0WglIqbjegCjbZ4D2UrGtt4Fu+NoICle8eBuFV8gVIHVYF3WWvuHudmaLiOO6nNMRBzBkOX8smaIaqGUmwU1KLF738C1Sy48+DsV1S/vD4taCjh4WJ4lwDRS92FVTGUoIQ18zovKeKLGSQOrHxo+PyQj4w7pkg3/FdB5P/3aS9yGJg0JMpJ3n8qTmv8ZHwiik/M/KylHFYa5iZvLmm2rSxfpwjwH40cMSc3uAYtWZ4ds+8AOH+LsUB3M3ELUuO1jgNu3KXHcqevBr9GI9UFwM4923DtiOvjx8jTCgn2kh59WmeBNw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?beL7R8SkDj33o/YDXa+zcBIVthVDp3ZoL46N+Sye6y8ZQ0yJXI6Zx6grqvYu?=
 =?us-ascii?Q?Sg+wtG8ZZKGv1K2yuh9Sut/l41w9pPcnwZ7YB48mj6QumplPYkq+VIVx3kmh?=
 =?us-ascii?Q?N5SDHGQxjcOe0oGUWgttNdXbYpPfs06HeAvWHT83nwcKxjOWr/knZiop6JRG?=
 =?us-ascii?Q?Z+knYVTk9T+F4UFKW0bvEYc0gG5Ka2rloUaUnZLvXNBTIcc7u3IbuC8PM6Sj?=
 =?us-ascii?Q?76lnJ6bPrccjgVpXTK+b44zBjycevCBi9Ri6o5H0dEtIxYLqbVC+6NzzEl1i?=
 =?us-ascii?Q?kEIMU1j2JsTrJVQHQ9DCePHFjN7IXbU5x7gtK+e82oiLyk/0WUzyvetdKWdH?=
 =?us-ascii?Q?a72zBgbzH+q4ilJxUmiNXEw4GbM7vZX/EkSMp9ZFpVem7XM4Vhm0hTFUN7fe?=
 =?us-ascii?Q?zyNk7QhhlmZeWajK8IJ+tMlLqY9v2t1SauVQkqFPs2rdj6PK5DU0PaeadRkw?=
 =?us-ascii?Q?US7QDEFFgfumH/4jHCEYObwArE/SFentcI27WeWlAH9wTprHguaXc7vWWkOq?=
 =?us-ascii?Q?o8OzOY3DBf47WFI0RTdQpDV0/RpRBZl2TVR8yHfJcD1ZJ2pYDP4oYE3pSSqK?=
 =?us-ascii?Q?tJbhug5zPayMoMYGeT9ItbGZbj84kmEKmT9t5XY8fDbyPI/qA8w8TsDWVPSt?=
 =?us-ascii?Q?KJdu52jKbrnfMkYWVwpwBqGtCHVpraqPMycsMmfRchfL3AnoRozj5C8H9MJ7?=
 =?us-ascii?Q?xSr9BWxZiMFzNXHqOwrWvF+WiaJ/6lbTY7aFktQIxSGcxioR/YN+v/oV5FIw?=
 =?us-ascii?Q?FH6AOCNSpxWwz3UMCbTHKFCqZX2GsZ+vo8zU2vYMg5D80NSEL2Bt1TEPEN5G?=
 =?us-ascii?Q?4VfcUwU6B16+km8G9w4jvw/pcQiVG9FBu/as4jC6l8fP9aTn+gZY8iAn7472?=
 =?us-ascii?Q?rmmwnjhDDz623WiHX33yn8QhvzWWdEIytiITZvgUVJLWlTDR/+lFQaIoKsx3?=
 =?us-ascii?Q?8x7Us0P44lhuzDj0pTzG5pdcV+cX0Ig6w6rhw5QGCI64pv88CEcRIsWOEl6r?=
 =?us-ascii?Q?P+3nZJ9yrfyDZVbqCuU0DZNb7nn8S0n0RPFP/v15O2b9MiG3Fo6vUJD9QSwm?=
 =?us-ascii?Q?RaytcXQEwBRGTNYITRZ67KUIo9xfiKejZU9mADdks5Uz7FImOz5tdqeHvm1f?=
 =?us-ascii?Q?imfRHXudcVTDWcZDgVi88YlEZZIWA5i0SIpSnQUsV9svO1US0QuzsB3QA8VX?=
 =?us-ascii?Q?avIPA92swkfgtArzIoyno37uQO4JLmgdMHv/tSsjVXwPUO2YB1eNIyE+xFUH?=
 =?us-ascii?Q?oeqzSooijdLmLoqKt1mX4Jrteyhs0YobWxQJJSegtg=3D=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-559fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b72d8658-c7d2-4006-b60f-08dcdbf688b1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR16MB2941.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 17:38:28.4792 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR16MB4706
X-Mailman-Approved-At: Tue, 24 Sep 2024 04:13:40 +0200
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

On Mon, Sep 23, 2024 at 01:24:34PM +0200, Quentin Schulz wrote:
> Hi Chris,
> 
> On 9/19/24 4:00 PM, Chris Morgan wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Enable the PD_VO power domain before driver access on the rk3568 SoC.
> > 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > ---
> >   arch/arm/mach-rockchip/rk3568/rk3568.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> > 
> > diff --git a/arch/arm/mach-rockchip/rk3568/rk3568.c b/arch/arm/mach-rockchip/rk3568/rk3568.c
> > index 1b3e40074e3..d5742b68d68 100644
> > --- a/arch/arm/mach-rockchip/rk3568/rk3568.c
> > +++ b/arch/arm/mach-rockchip/rk3568/rk3568.c
> > @@ -26,6 +26,8 @@
> >   #define PMU_BASE_ADDR		0xfdd90000
> >   #define PMU_NOC_AUTO_CON0	(0x70)
> >   #define PMU_NOC_AUTO_CON1	(0x74)
> > +#define PMU_PWR_GATE_SFTCON	(0xa0)
> > +#define PMU_PD_VO_DWN_ENA	BIT(7)
> >   #define EDP_PHY_GRF_BASE	0xfdcb0000
> >   #define EDP_PHY_GRF_CON0	(EDP_PHY_GRF_BASE + 0x00)
> >   #define EDP_PHY_GRF_CON10	(EDP_PHY_GRF_BASE + 0x28)
> > @@ -130,6 +132,10 @@ int arch_cpu_init(void)
> >   	writel(0x3f3f0707, GRF_BASE + GRF_GPIO1C_DS_1);
> >   	writel(0x3f3f0707, GRF_BASE + GRF_GPIO1C_DS_2);
> >   	writel(0x3f3f0707, GRF_BASE + GRF_GPIO1C_DS_3);
> > +
> > +	/* Enable VO power domain for display */
> > +	writel((PMU_PD_VO_DWN_ENA << 16),
> > +	       PMU_BASE_ADDR + PMU_PWR_GATE_SFTCON);
> 
> Maybe we want to guard this with a symbol for video stuff in U-Boot? I
> assume Linux is capable of handling this just fine without U-Boot's
> intervention?
> 
> At the very least have #if CONFIG_IS_ENABLED(VIDEO) ?
> 
> What do you think?

I'm game if you are. To me this just brings back the default behavior
of the binary A-TF from Rockchip where the PD_VO was enabled, but if
we want to guard this I'm okay.

> 
> Cheers,
> Quentin

Thank you,
Chris
