Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92619FF8860
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 17:55:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B27B483BC4;
	Mon, 27 Apr 2026 19:55:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="HabgoK85";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 259C583C14; Mon, 27 Apr 2026 19:49:06 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazolkn190100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d107::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AE4A83AA9
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 19:49:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macromorgan@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ffWAANWhT03ZEtgYeEmGu4aTLnFeIVI/755oYwLLJgNYi6vG5uh8TcrKjjRCtqQlPehaBQ+HsIxpqfxcOXwDGHtFFglcfBlI6UWNVjthTgqVqUAayx9z5BcaF+roNs40YoInD8+5NOKXNyz3yiL1YkLbeji+KFRNnkjSLoocGg1qF1+Xb3PbG42+5g2rdmSpCOa1XC0iV7GuK9sJpQdwsGbKl1FnFcnSUYeuEV8umG5E3EeygCv6sGNE5Lb7H06uq9ldRC0ZrIER2ZpkwoXGrglvYFj2xPgp2HiEMccUTnXzSwswYHrm5Ydf8F6b5OLFILW3SVPx/3sdwuTOgcrEBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99e6aVX/d/q4DKEbeuuNSrig/VUadY6QWl7ynWcwwkQ=;
 b=kur6bxFVWtOpQvYP/SgoZEBMPcIS4WInsmM59PsZiVNHtJTLi5MRycFZsBMqpqHD+SFFXclSZIwKX2QHJftXAo2puRY4VewMdR2oBcMebaUWw8Evl4vU8z2Jc1O5BQbiv2cQwLfZc33zpQzJvg2Q12y2Rguks2Pxd5si7w1v1NIjiy+NZcmqfZAkkDeF4DVZEq0jOg/1qKhtzIwNj/Jzf6BS80B51z+UAf/3J5zQcAT7DVgawTZgjAZQzZEl5Yz72+u4OaOs7UPIKBawGpzKHjTpR6LMdgrQUz+CQ8O/Sp4eVvkPJKLxA3fM7aQkAbhzNVMJDzHg+fAjLBXmC/l+1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99e6aVX/d/q4DKEbeuuNSrig/VUadY6QWl7ynWcwwkQ=;
 b=HabgoK85gyqXZwpe01PfB1zIjx9aI9XDoqXhxxTG94+9nJoSeCtBSI/v8kIZMz/Ty+HmYeX947bVIvgt2+wgJeXxSOrfd1SXzZT/hpgaumy8UqPA4Mj3l23vxdCwgGegxXoA6GeWgiVqYOShWvCEvAvN175zOv3PTftbTMxuAE2z1LG+Cc90/MjfPxA3LDDbL5k13PrXIdVQfTiKI275Diebvx/CPu59R089SbvFeu0nlRi4UwnvfXmZ46sglchS3xK9xAJFK+erInNXIbWHyQJuG+88GQkuFl1+3avZ0a9IkyVjfYa+gLG6RaUZ8/1lFkYEV7bMZTHkjjthgwrT+Q==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by DM4PR19MB6344.namprd19.prod.outlook.com
 (2603:10b6:8:a5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 17:48:59 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%6]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 17:48:59 +0000
Date: Mon, 27 Apr 2026 12:48:52 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de,
 jonas@kwiboo.se, trini@konsulko.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org
Subject: Re: [PATCH] board: rockchip: add Anbernic RG-DS
Message-ID: <PH0PR19MB99733877D409EC734B398DE017A5362@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260423183549.598018-1-macroalpha82@gmail.com>
 <71f9df6c-81a5-461a-abae-ee07814705d0@cherry.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71f9df6c-81a5-461a-abae-ee07814705d0@cherry.de>
X-ClientProxiedBy: SA1P222CA0040.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::8) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <ae-hhE1xwZApYEDl@wintermute.localhost.fail>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|DM4PR19MB6344:EE_
X-MS-Office365-Filtering-Correlation-Id: 11ee01eb-7741-4684-988c-08dea48542da
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|461199028|23021999003|15080799012|19110799012|8060799015|6090799003|25031999004|5072599009|24021099003|37011999003|10035399007|440099028|3412199025|40105399003|52005399003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E+ajmAPHDu1gdaGa/lxWCYyWWo/AqN/JX4KqHXcM+uBfSz16xFpIoutniR7Y?=
 =?us-ascii?Q?WCeHFEi2r0R5fS1uX1EgyYWJag1Nwij7QWeW8h/M0D3RNexDRktRJN99IgsS?=
 =?us-ascii?Q?xJiztRsmn3JCvUd77byGccCNanDbWnIDoQf+Gg132b/lmbcxfLcU+tR06ro9?=
 =?us-ascii?Q?ls7CzaF9/jXM30PW16qdPhmv43z5lzlbG5mhAb3pJWQ9a93mNw+VTFUTgvbu?=
 =?us-ascii?Q?PbdMiQ29FLzPtrhoJivVMav6FmSJU0o/UcY+ImaiA3nnojHq4CGB9HW8hKJB?=
 =?us-ascii?Q?sU6fYo8f7LFubGqDi2qEZ3erq/0+oCjV7qOYnDDTSjbdZ46gUIM2ttnH1adI?=
 =?us-ascii?Q?8omy+DenHk3aQ84CjJ82icFxsAJPZLFYG8eNBZWenf2Tv3rxSM3lwCuLaunw?=
 =?us-ascii?Q?R4XNd1Gmx1HOMKb5vjfxQT5RWSiyuXWGlfi0YGHrOmHsPixS8qBpGj2E2nLN?=
 =?us-ascii?Q?RGUVmIAJ8xyfJNHzbZHiO7fwxVqYotGUrd9RMaBz0JPd6gaXlkKz1WdiNYic?=
 =?us-ascii?Q?ntn4WKf8ycMFHil0ydY5rl3u+k2tgPma9KiMvd9jDyGKG3NzI+k8dL/DPEVe?=
 =?us-ascii?Q?ZLmXUBhlhQeKF6QoiFCDi3ajkv0hk+xxcy63hucLJlJpbCm6s3b4ICvffAw9?=
 =?us-ascii?Q?NEY2uP+uj5nrdbroQBgXudtPZYPsHm81ZJVPE7jAHh5igr2EMXLVSo57V3lP?=
 =?us-ascii?Q?BhsSQAO47Gd0Mxl6JROvIfrr/Ks7R2SSHHvOcXNO2twUFzYiCXFv96pennSV?=
 =?us-ascii?Q?juV5Cq3UucbyckK/kUtwbAQX3B/p2AQGwGibeHk3Ygj01Br0SCzsrUEcBDqq?=
 =?us-ascii?Q?DsQw/YeTcCyv6WWGXHPoxOk76cajz+cJp/1zb1PrSq5z8RsSO/42sz0HgaZ2?=
 =?us-ascii?Q?qRN4pVfUP7Wezd+U6j5PZ+54iObjC0g6sJa7FqL1SN4y8WSc8KE2zFfK5Mla?=
 =?us-ascii?Q?BTOwIfa+pnb7kfX3o0f9AM2b+5Rq42MxdFG0Oqp4jP0hgMo0fHM82KwwMHH/?=
 =?us-ascii?Q?8g0L?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SIde3oFH7OgEZp8hiQ8OltSzuZZ7xe4rQhKynbNVDLpYvAijx0AC2N4pb4h6?=
 =?us-ascii?Q?FaZ2MWN1QX7N/YGatDn9HrFVcHjBTDEIBFnAvGZfBmPFNzo5zYVP9XVdOoU1?=
 =?us-ascii?Q?yLN8rYF8fdFV8htd/yMmpwWsOTymrRw/YI58aMxEUVBNRCtkQFVEh2cEzWEp?=
 =?us-ascii?Q?ZzvZF2S7x+zUAcgs79jmCUHrjCGW35FL8EdfPNlOUk1vcCrQ/pNa1g928hvK?=
 =?us-ascii?Q?UWAbYoFgsqENncxRiNDw+LnSRNqLgfqhR7BNaIuvpMWwc48rHJCTUq64AT3K?=
 =?us-ascii?Q?UYtmA3YsYo6H0BDS1hTXE6Oz0/WnVbDW6jdwNl78wKFwfubvoeM3m1W9mgI+?=
 =?us-ascii?Q?rupWH2eIQkPqW9R7RF+nGnIj6i2GAuVyMyIiSnn8qfjI8LGSD/0eHEhwNvY5?=
 =?us-ascii?Q?NSvVQZkkR6Ov2ITmlrOGoqvV/KfflW+joOb1NQ0T0GAY9KtxNEnLyFw4j9U0?=
 =?us-ascii?Q?/Xd/hzFqTBRp+70sK3hdt5G5IaF4zP8YGbuOTMZ9ehlZ5x5tMwy/94kk/A9L?=
 =?us-ascii?Q?nMpE607TLYQM+b8PKzY7W4L2Fch+ksIa2H0+jZ2J285IHHPVtYURJVk0XzmL?=
 =?us-ascii?Q?yJWmKPAcgbssM2h3RVFCjjaXsBpoWG4oS9PziUQ5p54Lj7EVxR5O3PUniJjX?=
 =?us-ascii?Q?AKkPwVWH/2E3b92Wz8ed+PAMHWFkqYzaxegG0NCBoARJ9OxC2Agcbh39PrEF?=
 =?us-ascii?Q?pyLIlADV2wCuzQKvM7TEk0zbzHE6BRx84X0bKTRKy0Fz8eRAPBBon+ER8GpN?=
 =?us-ascii?Q?yfupfCB24VV5lrU2docQ+q968RMyLgsUc0SiuhqtYBZ3wAc/WaSB7jvIRBg6?=
 =?us-ascii?Q?kMOu9PXLtgq+fpAHgynCKiWhxgt50cFAwMslp2FYK5d4jj0GBtkNuYOpfOKL?=
 =?us-ascii?Q?gkJWvTlA/UlvS3XNz1AuVS2pEobZEmegc1PPgE4/SZll1L5Dg5T0yop2dZrI?=
 =?us-ascii?Q?pyjdGAndJ40cHuTRvzjKBOkNhTUsWMZ4NU5M1Yg7sa3kkbyutw3TU1AdGHrV?=
 =?us-ascii?Q?UWw2KZYjHocdsJwztQw22BLwf2xIHXOOVs1GnsuWB5LzXO5iXsXsPPOXCwbc?=
 =?us-ascii?Q?Hh/cp23rIvj+tpQmFNoJ+JW7A2pm8Wh8+zmdaT7nSZB9Z4K0v71n1Oye4cON?=
 =?us-ascii?Q?WP1h9GaIIbiNVuqgRrHq0vpstxiHI1LhXMQ1kbe2ofX+sEYlA3QRq1S2+BSc?=
 =?us-ascii?Q?harP2KSE5kJkOrLePTThvALaIUMgrCzBj3yod9ivTg/ZkUtGyap9Yu1wGGtK?=
 =?us-ascii?Q?4D/IsuoVbErE+EPA6fzDPy/smRCQutXv8lz7+KkrDY7ugvZ8Ttjc75wuoQq0?=
 =?us-ascii?Q?8iKexLWGRVKwSR9Dz3ZQHA/QyzIxNNrSbbq6nKbkhEVyj10sV0zdXdgBngS6?=
 =?us-ascii?Q?Dl5n9Zn2WfXmcwvhedegYPw+g++L0RpSrSgJlJ2ZZhV+QsgLKw=3D=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ee01eb-7741-4684-988c-08dea48542da
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 17:48:59.4615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB6344
X-Mailman-Approved-At: Mon, 27 Apr 2026 19:55:49 +0200
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

On Mon, Apr 27, 2026 at 01:29:41PM +0200, Quentin Schulz wrote:
> Hi Chris,
> 
> On 4/23/26 8:35 PM, Chris Morgan wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Add support for the Anbernic RG-DS dual-screen handheld gaming device.
> > 
> > Link: https://anbernic.com/products/rgds
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > ---
> >   .../arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi | 41 ++++++++++
> >   arch/arm/mach-rockchip/rk3568/Kconfig         |  7 ++
> >   board/anbernic/rg-ds/Kconfig                  | 12 +++
> >   board/anbernic/rg-ds/MAINTAINERS              |  7 ++
> >   configs/anbernic-rg-ds-rk3568_defconfig       | 76 +++++++++++++++++++
> >   include/configs/anbernic-rg-ds-rk3568.h       | 12 +++
> >   6 files changed, 155 insertions(+)
> >   create mode 100644 arch/arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi
> >   create mode 100644 board/anbernic/rg-ds/Kconfig
> >   create mode 100644 board/anbernic/rg-ds/MAINTAINERS
> >   create mode 100644 configs/anbernic-rg-ds-rk3568_defconfig
> >   create mode 100644 include/configs/anbernic-rg-ds-rk3568.h
> > 
> 
> Please add an entry to doc/board/rockchip/rockchip.rst.

Will do.

> 
> > diff --git a/arch/arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi b/arch/arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi
> > new file mode 100644
> > index 00000000000..337e50f2e54
> > --- /dev/null
> > +++ b/arch/arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi
> > @@ -0,0 +1,41 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +
> > +#include "rk356x-u-boot.dtsi"
> > +
> > +&gpio0 {
> > +	bootph-pre-ram;
> > +};
> > +
> > +&i2c0 {
> > +	bootph-pre-ram;
> > +};
> > +
> > +&i2c0_xfer {
> > +	bootph-pre-ram;
> > +};
> > +
> > +&i2s1m0_mclk {
> > +	bootph-pre-ram;
> > +};
> > +
> > +&pmic_int_l {
> > +	bootph-pre-ram;
> > +};
> > +
> > +&rk817 {
> > +	regulators {
> > +		bootph-pre-ram;
> > +	};
> > +};
> > +
> > +&sdhci {
> > +	cap-mmc-highspeed;
> > +};
> 
> Why is this not upstreamed to the Linux kernel DTS?
> 

I think early in testing I copied this from another board, but it turns
out after testing this isn't needed so I'll remove it.

> > +
> > +&sdmmc_pwren_l {
> > +	bootph-pre-ram;
> > +};
> > +
> > +&vcc3v3_sd {
> > +	bootph-pre-ram;
> > +};
> 
> Don't you need vccio_sd as well since it's the vin-supply of vcc3v3_sd? (and
> also used as vqmmc-supply for sdmmc0

I will add it. I believe the regulator is programmed by OTP to always
be on during boot, but it couldn't hurt to be explicit. 

> 
> > diff --git a/arch/arm/mach-rockchip/rk3568/Kconfig b/arch/arm/mach-rockchip/rk3568/Kconfig
> > index 2730220a18e..8fbd764ab54 100644
> > --- a/arch/arm/mach-rockchip/rk3568/Kconfig
> > +++ b/arch/arm/mach-rockchip/rk3568/Kconfig
> > @@ -8,6 +8,12 @@ config TARGET_EVB_RK3568
> >   	help
> >   	  RK3568 EVB is a evaluation board for Rockchp RK3568.
> > +config TARGET_ANBERNIC_RG_DS_RK3568
> > +	bool "Anbernic RG DS"
> > +	help
> > +	  Anbernic RG DS gaming device with Rockchip RK3568 and dual
> > +	  displays.
> > +
> >   config TARGET_ANBERNIC_RGXX3_RK3566
> >   	bool "Anbernic RGXX3"
> >   	help
> > @@ -71,6 +77,7 @@ config SYS_SOC
> >   	default "rk3568"
> >   source "board/rockchip/evb_rk3568/Kconfig"
> > +source "board/anbernic/rg-ds/Kconfig"
> >   source "board/anbernic/rgxx3_rk3566/Kconfig"
> >   source "board/hardkernel/odroid_m1/Kconfig"
> >   source "board/hardkernel/odroid_m1s/Kconfig"
> > diff --git a/board/anbernic/rg-ds/Kconfig b/board/anbernic/rg-ds/Kconfig
> > new file mode 100644
> > index 00000000000..cb93c249cf4
> > --- /dev/null
> > +++ b/board/anbernic/rg-ds/Kconfig
> > @@ -0,0 +1,12 @@
> > +if TARGET_RG_DS_RK3568
> > +
> > +config SYS_BOARD
> > +	default "rg-ds-rk3568"
> > +
> > +config SYS_VENDOR
> > +	default "anbernic"
> > +
> > +config SYS_CONFIG_NAME
> > +	default "rg-ds-rk3568"
> > +
> > +endif
> > diff --git a/board/anbernic/rg-ds/MAINTAINERS b/board/anbernic/rg-ds/MAINTAINERS
> > new file mode 100644
> > index 00000000000..79ddb663ab7
> > --- /dev/null
> > +++ b/board/anbernic/rg-ds/MAINTAINERS
> > @@ -0,0 +1,7 @@
> > +ANBERNIC-RG-DS-RK3568
> > +M:	Chris Morgan <macromorgan@hotmail.com>
> > +S:	Maintained
> > +F:	arch/arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi
> > +F:	board/anbernic/rg-ds
> 
> Should we have rk3568 mentioned here maybe? Not a blocker though.

I'll add it.

> 
> > +F:	configs/anbernic-rg-ds_defconfig
> > +F:	include/configs/anbernic-rg-ds.h
> 
> Both defconfig and include files do not match here.
> 

Sorry, will fix.

> > diff --git a/configs/anbernic-rg-ds-rk3568_defconfig b/configs/anbernic-rg-ds-rk3568_defconfig
> > new file mode 100644
> > index 00000000000..c16a208a117
> > --- /dev/null
> > +++ b/configs/anbernic-rg-ds-rk3568_defconfig
> > @@ -0,0 +1,76 @@
> > +CONFIG_ARM=y
> > +CONFIG_SKIP_LOWLEVEL_INIT=y
> > +CONFIG_COUNTER_FREQUENCY=24000000
> > +CONFIG_ARCH_ROCKCHIP=y
> > +CONFIG_SPL_GPIO=y
> > +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3568-anbernic-rg-ds"
> > +CONFIG_ROCKCHIP_RK3568=y
> > +CONFIG_ROCKCHIP_RK8XX_DISABLE_BOOT_ON_POWERON=y
> > +CONFIG_SPL_SERIAL=y
> > +CONFIG_TARGET_ANBERNIC_RG_DS_RK3568=y
> > +CONFIG_SYS_LOAD_ADDR=0xc00800
> > +CONFIG_DEBUG_UART_BASE=0xFE660000
> > +CONFIG_DEBUG_UART_CLOCK=24000000
> > +CONFIG_DEBUG_UART=y
> > +# CONFIG_EFI_LOADER is not set
> 
> Any reason for explicitly disabling EFI support? (aside from other anbernic
> devices disabling it as well?) I believe some distros depend on that for
> booting up?

I don't use it, but I shouldn't explicitly disable it. I'll remove that.

> 
> > +CONFIG_FIT=y
> > +CONFIG_FIT_VERBOSE=y
> > +CONFIG_SPL_FIT_SIGNATURE=y
> > +CONFIG_SPL_LOAD_FIT=y
> > +CONFIG_LEGACY_IMAGE_FORMAT=y
> 
> Is this really used? I'm thinking we should probably stop using this for new
> boards if possible?

I don't use it, I just copied it from my other Rockchip boards. I'll remove it.

> 
> > +CONFIG_OF_STDOUT_VIA_ALIAS=y
> > +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-anbernic-rg-ds.dtb"
> > +CONFIG_DISABLE_CONSOLE=y
> 
> Why no console? This will make debugging harder no?

I belive this was a vestige from something I copied, so I'll remove that.

> 
> > +# CONFIG_CONSOLE_MUX is not set
> > +CONFIG_BOARD_TYPES=y
> > +# CONFIG_DISPLAY_CPUINFO is not set
> > +CONFIG_DISPLAY_BOARDINFO_LATE=y
> > +CONFIG_BOARD_RNG_SEED=y
> > +CONFIG_SPL_MAX_SIZE=0x40000
> > +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> > +CONFIG_SPL_POWER=y
> > +CONFIG_SPL_ATF=y
> > +CONFIG_CMD_PWM=y
> > +CONFIG_CMD_GPT=y
> > +CONFIG_CMD_MMC=y
> > +# CONFIG_CMD_SETEXPR is not set
> > +# CONFIG_CMD_CLS is not set
> > +# CONFIG_SPL_DOS_PARTITION is not set
> > +CONFIG_SPL_OF_CONTROL=y
> > +CONFIG_OF_LIVE=y
> > +CONFIG_OF_LIST="rockchip/rk3568-anbernic-rg-ds"
> > +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> 
> Why remove clock-names?

For the RK817 PMIC it has clocks but they are only needed for the audio codec.
Based on observation when probing the PMIC if the clocks are defined but cannot
be probed then probing the PMIC also fails. Since the clocks are really only
used for the audio codec, we don't need them here.

> 
> Cheers,
> Quentin

I'll make all the changes you suggest, except for the clock-names one which
has an explicit reason. Thank you for your review.

Chris
