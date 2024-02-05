Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21130C48292
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 09:48:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 540CC87730;
	Mon,  5 Feb 2024 10:48:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="b/qrKefu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9612887760; Mon,  5 Feb 2024 10:48:04 +0100 (CET)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2611::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7E5D8771B
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 10:48:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Chh78zncE4gGq19cGfSfaKPmGwhLuleKr01R24hpiQxO6djPu+q8q0u1kGZ9cevH/7HE2/WMoKmQuS6YGfO4Z/NToNxETD0JQI6mvlF8vO3Y3ZCApzp+OLO8Cr/2CDQV72zRYFDf4j1lI1cOpFa6p0yewgLoC72RtPxA25trPHQ7nEEdBQL1exqO9blf7pW799lV8B0YFzG4Rnt4y0s+6BFGRTd5uMZcboyqfLiqp4nueXm+vZD8XBb8msm7z269FzOz717kEn0k8Xs8hXNu8LMaFGrwQmlm/lHZEBO4x/EpwadIn3WnHnz92wkc1z5tNaJOALy5Axj/AZ/rznLWXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5qqdIe0HRBZw5GD0XZ9yQjd5+bXc3aM9VIFlB5NtKo=;
 b=Uo97bzMUd95UCU28bt6wjK9ftI+ysXSTcFiPIcobdi2SzdFWwCk1Z4RzTIJlb7idlXXsc0fQnBiZI242k9Uyuucv+BsyskFqgWJpaB0kGi1WbSFuqx7BABvw74URnBWjLsHkxKX4LGBAKPcHWgv40Ll/rhZO5ZPhoDvFIb/XdGvba9/Vo6Toi9u9VNQ5jb3MRS6ujPyTBVpSu7e2j3AP1ulUyZTQhnklxNGgE+mZLegBRMcoiXkjpsXchcXY+8eHiVeAUcvDe1a3KQ/3LNjKu9Eb7DGuqtpfN7EqAUoKHq6pQMqNJsorZOM715YukvRtu2kAVlodUp2yn/lLolrD8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5qqdIe0HRBZw5GD0XZ9yQjd5+bXc3aM9VIFlB5NtKo=;
 b=b/qrKefu1Wz4/6Hbjl3jQ/NRHcAhvynOc/E0TyO3UX1Fv0K5ESk2sAVzBdeKXnDazmU85f2oakI3iznYu2X34XdX3Mkb8HVbYYm1HMSdJoPHQl2/4DSNNGjEFGnjmpNbZpVSH99vZ3pfZPh1O0t3VsEYl8TdoLPBhOevBcxFW0Ry10DLuEMEvMqm+J4RBsZAlelxRDAp+xNT6ywTorcmqtoJH7+m1C8QNtHFFv+XYsz2fLES7gD1YuRs7R2hq+TBlIwv2AogJxlKx+cMfAODr8jLCYsaaoQGzmqB5zFEAgBtO0iQN7miqFE9QAkIe8jhQ4WnoUxM+cyJiGFgtiAKrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AM9PR04MB8177.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 09:47:59 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%5]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 09:47:59 +0000
Message-ID: <5124b52c-47d7-4232-907d-d09a5065ff1e@theobroma-systems.com>
Date: Mon, 5 Feb 2024 10:47:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] rockchip: rk35xx: Enable eMMC HS200 mode by default
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>, Tianling Shen <cnsztl@gmail.com>
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Weizhao Ouyang <o451686892@gmail.com>, u-boot@lists.denx.de
References: <20240204205312.2342868-1-jonas@kwiboo.se>
 <20240204205312.2342868-3-jonas@kwiboo.se>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240204205312.2342868-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::13) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AM9PR04MB8177:EE_
X-MS-Office365-Filtering-Correlation-Id: 4504aee1-4d8a-4832-20ee-08dc262f89d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SUi6yDmKkkdad9TuosDbmzN4Rv3WOQpUigo7cuzst7SigOfmMtcJ5k+PM9z2qWcpHbdUC85AMnrkEwBwUXucw0Dp3ZKeqylEvSQetnbGDGmlBUkFWlNrGmaTYJrQLqJyNeRTyQFM4fOZ5RU4cgt/7NvUqk//Pp012rC/aCi+LEwRwxNL6UbiUF3Ju6qu/WJczTEARq+pMm/297e4lenECtfYgNlZ4j8bp9nNzy/na7wutG08FYLMITbMvfeXDnnWoRiym+nTV/oXDNE6lIIuBo8vtbcOPmtrWPvbp19IVdzxCLx4RpL0/3alrRYx/GRVvmdxpimTlml6gxA57ItwpOFyXQ7O9d7SRiGTG/DXpB1DKJ9RxPP7HKmbtYVx4n2qX8WOuOBnSTram5sgkpvbc6nrRrsxZE5KTYgGWVh3A1BEokCFgN1gn8M9QpFt1/u7ESyVYCgxHe4ZJi6FyKr/sL4iigEYl482uUiBzad24TsgRENuVCFdEY04ts+9+lTqTxZJmgj7bC4YIj+hRWJdMq34Vf1SUkIJrQY+BXT3h7WwD2pi9Ps/F00Nmpa3VFlvRdoPG/YL0Jfqp8HJYvxvBS3CtJVEIyKRsePsS7Fl1s1FRaXm3D6V/mBCShhfed0VCuqfejCbpneUaFhF4auHRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(366004)(39850400004)(376002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(26005)(2616005)(4326008)(38100700002)(8936002)(8676002)(54906003)(66476007)(110136005)(6506007)(66556008)(44832011)(2906002)(66946007)(316002)(5660300002)(966005)(6486002)(53546011)(6512007)(31696002)(478600001)(86362001)(36756003)(41300700001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0NWQUNvSDNvMWRRaXQ0aEtnSTlMUkFBak5qRFBYeDRLSEpvUkg4cEJRdEF1?=
 =?utf-8?B?eXBQMnNHbkppS1dDN3QzRTE4eWJic1F2amZtN3dOSkxlVmIyODdEbVhPYTFL?=
 =?utf-8?B?TEhDSUJyL3I2YktvazNZcGNscUZyNlprRDNZaldsSXY3R1JGbmtKdXREclVI?=
 =?utf-8?B?SlR0QzF2QUVBRjUrOWZRSTZzL2t0ZXFhUWQ2UlN4cDBqbW5CT0NuUkdyTGFJ?=
 =?utf-8?B?NG5jRlZoMlJlc3BqNDNyNVhiTTBwbjVuWjVwNEE2cnBCRFpIYnVhYnkxTHdO?=
 =?utf-8?B?YkZBTzQzbmlxMHhhVFNyQ01BaE8rNmtJRzY2NnpVc1h4eU01ajFPTHJMaFhX?=
 =?utf-8?B?UEVpcWMvM1h3bFNsNkpqTnVMY0d4VEUwTVJWbWtrS3Q1MStkVWVWN2hLZmwy?=
 =?utf-8?B?NEZFM3RuTGcvWm9Velh1bHN0b0VzanZDNHlhWHJlSitYbmZadGtvSWtnTGgv?=
 =?utf-8?B?QW42T2hCUDFqb1h2dEFkR0E0UTZpOWpBd1NZWThzTTQ4TjdsWE1NWVBtTHNy?=
 =?utf-8?B?endueHpVVnU5ZDBVc3N3SFpic3kxSzdnTVZESEpiUENkZks4VzQwcEZHN0pC?=
 =?utf-8?B?TG9FQ3VSZ09mb1VqbVZKalhiQ2ZkM0JiK0pNRWZBcHVuUUdIcVpJY3h3WUhr?=
 =?utf-8?B?TEQ4QVEyV2lVY09OQy9ZNHljZThQVFVCSlhndm9hQXhyeFJJcW5nNk1PWlJO?=
 =?utf-8?B?R1VMYUs3NFFJcTJhK1B6ZER4ZWtLN05KWkhaVStwVEFWNjMyRzd0Z3NteVJk?=
 =?utf-8?B?UVdYS2pCS2tFRXFWcTcyTFlteEJEcHpNekZOQjBacjNOQzNxdW03dU80Z0p6?=
 =?utf-8?B?YWg1akQyMTZ0RjB5dGhhSzBTVUt1ZmxGcVM3WWExekRaaUJlT214d2xMalpw?=
 =?utf-8?B?VkIyNEN0SDFlQjBpSWlyd2h2bzk2QnpOV1VlemtCT2VkUzIxVEEvTVRaNFpN?=
 =?utf-8?B?djVSYWlPTUhaZ09WSm9ya3NndGk2WUhOekhrUGRvNWtaUDNLNVRYRnRORTZJ?=
 =?utf-8?B?dUdnaW50OFAxMmVOdFdRNFVXZGF1NDNiY1hwdG45aWVZbjkrSjZmMXlzVFU5?=
 =?utf-8?B?SnVVZ0JyZ24zaFRRWFFGWjRtemgwSDh4UDhxZlFvTXZQWFM3Vmc1amU3cWV4?=
 =?utf-8?B?TUxDVFRUL1FTSC9XTkNtT1dlRUdvV2xPVUhtZUhDTmRPZ3FUZkhGL3lYSklY?=
 =?utf-8?B?cVZNRkEwR1RaYTFZYmt4L0c4MHE3aUQxaWtJblQxcmNxN0hmUFF5NXB5UjM4?=
 =?utf-8?B?RHRMTGlKTThyYjVvakhBOG5Odjlna1ZHSUxJSEVtUWh4WmlpQmhrbTRWcVR1?=
 =?utf-8?B?c1Y2QkkrRzZCd1lzcFBWY2lYZDZFZnR2cWFYWE8rQms3cUJCWmJSTFpPRFM1?=
 =?utf-8?B?cUl4TmpBSUl1Q2p4S29iRGtndEF6MmlIUmlUTllDMCtLK0xad0pabU02Y2Nw?=
 =?utf-8?B?RW5INmtFOERqRmVydGtzdHdCNTMzczd5NUVkNDZQTnowaXQrbFFHZkZwa0pT?=
 =?utf-8?B?d0haTDNWVnl2UHF4SXRQTXVHQThhcUFIN3RrbGx3djA4ajhWakU4aHFlb3U1?=
 =?utf-8?B?OWtpUUZ0UVhETVJyTUFxdXliMHd4M2taamYxd2RjLzdjRjR6VUE4NjdrWXJV?=
 =?utf-8?B?Nm5ndE5VajNscGdWaEtXTHVkRHdiVjdKenNsMjZhTTFvWHpncnhZa3VYV3hh?=
 =?utf-8?B?SXhibXBEd1RmZmJjZktRRW1CUXBuVlJXMmNPQU9PQmliU2ZhRW4raTlXZFU0?=
 =?utf-8?B?MWl5RjZRKzBTbFpLNGtwd3hpc2x4ZUY2NDVXVmpLQWNSSkRjZHVqQ3VwTHNu?=
 =?utf-8?B?VGdZdWx6YVQ3WmNWODkyY25xd0JORVdUc1VQRy9RRGRTSDFQU1ZEeUwxdVZ6?=
 =?utf-8?B?QldvN3RHcmFOb0h5QXJ1TUR6UjdjcTVaZGFwTndiZldaYkR4Rm5Wd3ZtdDlL?=
 =?utf-8?B?RWd3OE9KNjl3K0F0MjlXQzdORUlHWDNCdDMyK3NLZDJaL0hnM0RTV3p6TWNQ?=
 =?utf-8?B?dHBhc0NBWWYvSmVCRFI2bWpaTjBiWUppSFNBa1hVNUlWSGFwV3EyNHgxblhk?=
 =?utf-8?B?dExsRnp1ZWh5aGIvYVlVSTRvV003aGRZdzhJSWsvUDFRdmhOTXJmQ3d1Wnov?=
 =?utf-8?B?RGo2UjZhUTFrSEV2L1d3b3RNcnBJLzBuY0pQUUVBUVpRMUNhaUZRTEE2Y0RY?=
 =?utf-8?Q?WRJr+5RlAqORmgtUQeGbRro=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4504aee1-4d8a-4832-20ee-08dc262f89d2
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 09:47:59.8737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y6x2SCCxkCNpLX8Ut4b8W3mj3O+4kqMa4Fmbj/5FlTCNkiT1GNhBzEdbJCnePfZlijWPZwIP/iE7jNCby6TOUH07MATNWm+jtT8vrDk7XFEIK2TVS5fm9scb/lMzqQBi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8177
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

Hi Jonas,

On 2/4/24 21:53, Jonas Karlman wrote:
> Testing has shown that writing to eMMC using a slower mode then HS200
> typically generate an ERROR on first attempt on RK3588.
> 
>    # Rescan using MMC legacy mode
>    => mmc rescan 0
> 
>    # Write a single block to sector 0x4000 fails with ERROR
>    => mmc write 20000000 4000 1
> 
>    # Write a single block to sector 0x4000 now works
>    => mmc write 20000000 4000 1
> 
> With the MMC_SPEED_MODE_SET Kconfig option enabled.
> 
> Writing to eMMC using HS200 mode work more reliably than slower modes on
> RK35xx boards. Enable MMC_HS200_SUPPORT Kconfig option by default to
> prefer use of HS200 mode on RK356x and RK3588.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> Changes in v2:
> - Imply MMC_HS200_SUPPORT and SPL_MMC_HS200_SUPPORT in arch Kconfig
>    instead of adding to each boards defconfig
> - R-b tags not collected because of above change
> - Combine changes for rk356x and rk3588 in one patch
> - Update commit message
> 
> Link to v1: https://patchwork.ozlabs.org/patch/1891693/
> ---
>   arch/arm/mach-rockchip/Kconfig      | 4 ++++
>   configs/nanopi-r5c-rk3568_defconfig | 2 --
>   configs/nanopi-r5s-rk3568_defconfig | 2 --
>   configs/radxa-e25-rk3568_defconfig  | 2 --
>   4 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index 6ff0aa6911e2..946ef5d7023d 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -292,6 +292,8 @@ config ROCKCHIP_RK3568
>   	imply OF_LIBFDT_OVERLAY
>   	imply ROCKCHIP_OTP
>   	imply MISC_INIT_R
> +	imply MMC_HS200_SUPPORT if MMC_SDHCI_ROCKCHIP

MMC_SDHCI_ROCKCHIP is also required for eMMC on RK3399, which would 
change the current default, at the very least for Puma RK3399.

Doing a:

rg -lU --multiline-dotall 'RK3399.*MMC_HS.*' configs/

Only returns:
configs/evb-rk3399_defconfig
configs/pinebook-pro-rk3399_defconfig

and there are 29 defconfigs for RK3399-based boards right now, so maybe 
that's a bit too big of a change?

Cheers,
Quentin
