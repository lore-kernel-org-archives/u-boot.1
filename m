Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0110AC4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 14:47:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 443A787457;
	Wed,  6 Dec 2023 15:47:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="YuXrzvn9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C98D807E9; Wed,  6 Dec 2023 15:11:55 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12olkn2082b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::82b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1190F868AE
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 15:11:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macromorgan@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVmsazXJnnip5QImMIGvWr33DzZDJqpyxwo3ce8ZAqlarFh9up+XJtn61vnf5QsAiLrjagFZxLHXJLTgs6V28r7SfM3d46oxGlY9mphAFBdb+qsO7P9U7Hpa+G/oCDuZv0s9WtQpkP+1uv0fkyylgkFiZsLuIVGlBSZthCCF4oT1PLIiXiAJ+jEXKowDp70VlRuMqhQeVJ+PozNEDGvEOjDkPh6K5AxrhVxJmAPJ+01qPg6eO+1T6555ZQ1BFWNzXmchmaASKl42L2XaASHybxY/OKsdu0WQJIG7t+JPftP2yfXq0YCrHv2y7bCPUFp7c/NwL1FhlgklhBHyc+j8OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5zl5CZ22Au5huDwUjchol0tBP2ekjGeF4RD/K46sCQ=;
 b=OF2w6akAAKMhptepXHXbiAA7HluHOXAhmP5MCj34u4DL1YbQhCreBs71ebGkH7nVzNuKKfDRXyQN3knWLHiSEjWrsUPEYiP81bULldYi9zfBjyYulJ2n0RM1TNJH340qw3f4Ewhz2rLv415ktw9B/4NiaFqZKWyyZ6y8MCdWg15PepM1f0h24EvuJj69edWf24k/N8ysz+6L675MF9FL6Yhk2AMp+j2FD8PTfx+gC4P4IcdOzIen+aksZ1icbTYbZAhx9tBucxjicaL4XWRbIKOhZ+CZM/5Rrlkg1QfWGgv3s9/Ssy59FONdSmmPyDhdgszP2o6EoIsaFIJG2F7coA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5zl5CZ22Au5huDwUjchol0tBP2ekjGeF4RD/K46sCQ=;
 b=YuXrzvn9ccb9j9iFNAQRzPG5M62V11zIfdxwjt8JObXZTS/oh5NARzz721d8d3fzaX7JOZai3fnOwrK0LYN5wwFKTIkUWxgHbWykVELOY6pCOITVN7SIzCkATspKJJ+dvCLJA/vBhEv5qTrZNDXDZVcQMUkgh/SltlUdvv/5FIe6TRy5LLGqP9AYUAV43XLYU4wFf2lr37HxFm/mjbn6xyQL0oVuEOKU29HABSwbyxDlXMfIh2wsqBBodqt+/rrqEhMFVAvUdnxSi9Lb+1hcoH+vHBGihtdJ0ioNlxDI6bplC2TVglE6+EyVHNmsVnoyu6qeZxaPDyIf5HTkK5Ni0w==
Received: from SN6PR06MB5342.namprd06.prod.outlook.com (2603:10b6:805:f9::31)
 by CO6PR06MB7140.namprd06.prod.outlook.com (2603:10b6:5:34b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 14:11:48 +0000
Received: from SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::3fca:a39b:c9d2:c834]) by SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::3fca:a39b:c9d2:c834%2]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 14:11:48 +0000
Date: Wed, 6 Dec 2023 08:11:44 -0600
From: Chris Morgan <macromorgan@hotmail.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Chris Morgan <macroalpha82@gmail.com>, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org, u-boot@lists.denx.de
Subject: Re: [PATCH] board: rockchip: add Powkiddy X55
Message-ID: <SN6PR06MB5342D02343AD3642EFA640F6A584A@SN6PR06MB5342.namprd06.prod.outlook.com>
References: <20231205213929.95324-1-macroalpha82@gmail.com>
 <791b6412-8f8a-4a55-98ad-7564ec0c283d@kwiboo.se>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <791b6412-8f8a-4a55-98ad-7564ec0c283d@kwiboo.se>
X-TMN: [V3cAKgDztK1iiYLXTO2jCnTCjDo/qrm2]
X-ClientProxiedBy: SA9PR10CA0028.namprd10.prod.outlook.com
 (2603:10b6:806:a7::33) To SN6PR06MB5342.namprd06.prod.outlook.com
 (2603:10b6:805:f9::31)
X-Microsoft-Original-Message-ID: <ZXCBIARw4G34iYv0@wintermute.localhost.fail>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR06MB5342:EE_|CO6PR06MB7140:EE_
X-MS-Office365-Filtering-Correlation-Id: aecdf44b-f14a-44d2-685b-08dbf6654897
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cyOweKzmbQO9mNkVqmdUn6tUv4xihTcMYWCKTQMIGKdkuhAwVY1ERLsSiUfTApCgNCnKj4CRoznusigFfjpR5dd3cXNSvQT+7yN8dmW7xb4ogOhpQMAVYAFvuno+dWQEh8TTCD7U8/Uwa8COHmmb16qvcEYJdKKHmxA/bRfpQ8Q5SE7cxgZChgDjuHn7dvG3O+aZJURcOV+beoquUfABnDGq08rIDf/hz5kNnHmCbO4VLkldebHS7gSUAHyLbtoZEeIFsmAVQIcBXzcItDt+q5MRVm2fp8/WZ3AHo7+/ylulbSvPNaERlAkH89AsVSblGuMH4Fwoa2RjJ7lc9n4wLQbS+vIB//A6AKZxPKwYZZcuo2WR7j+BmbE4gjNC+/31qUXFe1Wcc88yEd8RAQDf4xarOmtIHQ8/1pCXJAPbHu+0iPnFk79c2CEQxK2F0v9Yr1NjCdtSWWgVrLEDstdbxA4zCMFDUBpuzjF6kDJZCoY2UE4aGxBgIMVmFFJVheIJHpXfLcA3lR82K/1KtIypu0L1x4WUzQqkVWkcR0TthFY=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+bWPhAnJfPdnOQCkuInphiOKOFv02VapXV9MCyAuLiCzgWl9JFrpMiFjLFyn?=
 =?us-ascii?Q?mvNokUqy60HS+KfZ8A1p9gB2QD5EAX4BHy3XShB+D1d6/ZNTt0OFpKgPGfhW?=
 =?us-ascii?Q?qv19pvcaDj4zk8huJTuhIyB2RXuyfYsjtebvBXTpEvNRBDr3fCUbQvpnhGxa?=
 =?us-ascii?Q?U2utkK7kb6Vfv9tZH459hI4iCm/wgQoTc2Sg4Onz73mjxIih9xMaUNiIvsbl?=
 =?us-ascii?Q?7JSXnpvzL6zkAaRFgVWR2Ckmn9q3peG2fbltATLzu4JMX/1wx+CE2GTc97Bu?=
 =?us-ascii?Q?GxOOCv7fIGVFy61gOeSMU8Ts9iPzFOE/146sR7pjB9OSSZHvueISBH3yBGHp?=
 =?us-ascii?Q?mWAeafaWrLOhoZmMmSXafRqOW6HwFE2KsMoc82tIcee1asXMbbRqLSxUSOHb?=
 =?us-ascii?Q?CGamkJFDS49LNjX3ehL0CoTPvogwEWMk3qaWMB4WOrk356q1+FQ3xKeraGzx?=
 =?us-ascii?Q?GPrD/lnDCBZsLhYN6zJucdylp4cxBOTc929jdaXxQDyGRQ5XmxXxG4fCxLk+?=
 =?us-ascii?Q?HB+qnD0JTEubfkm/psZHX9/rd70vAi4xur1XBWsi9UF62CH1ENmehixi6OIq?=
 =?us-ascii?Q?McTW0NJC2GnRdmvmLI+zstkv0uyt13VXQXq2NEpx03aGq+pzU3AqP1Dwr5fN?=
 =?us-ascii?Q?3NINbqYMn5eLs7gHon7K/36j4otaZ4zlJDVcmi5qGR8y6dOwFOHnSHhV96yK?=
 =?us-ascii?Q?yiT8IN7Fi1S6H1J0QS1cgrztlxgCErjM8EJQ/RhMNZrNTkBqg8tKYDZ9pK5S?=
 =?us-ascii?Q?PjTIKlxBPZxhJwGLHnnrf9LnM6YZVEQuK0e92AOQvAfcQRiPSFbuMrB55/9J?=
 =?us-ascii?Q?b04N8mw71mNHtaz2To5bNBSi23ilNrRxfgjZlEf3JhRPpIVrSIIey5HSVR38?=
 =?us-ascii?Q?dNKl+Z5xZtLyw7eqMt+hEzn/TeGZMFKv5UV4Dum+CCM4PHZEOPD1HeUvxqFL?=
 =?us-ascii?Q?bc/qft+wS2x1V5ZP/K2ioFjPgI14MLCVQkk5mAd/ZtyjbIhizvquMaWgM9pz?=
 =?us-ascii?Q?QfiV6WyntJF8Bk2DmY4PcblsiTwLdAfjj1d/fUDmBQ2RCYhaGo+4tcLOyWea?=
 =?us-ascii?Q?8RrOsIwareOR/94uN5HnYNywOwq247EgxVmXUTY95p029eSk0eMFHijT1IPj?=
 =?us-ascii?Q?pH2k2zCwl8NJlWKva200uyfqNdewqn6cPzLrFhCKBhgwlS04HFuGVbafU3Hs?=
 =?us-ascii?Q?bfAP7ZqbyQF83yzLDY5gmoDL4z1sKYThL0WT5UPYMlcryYeXqmEYbhn3iS0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-89723.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: aecdf44b-f14a-44d2-685b-08dbf6654897
X-MS-Exchange-CrossTenant-AuthSource: SN6PR06MB5342.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 14:11:48.1675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR06MB7140
X-Mailman-Approved-At: Wed, 06 Dec 2023 15:47:24 +0100
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

On Tue, Dec 05, 2023 at 11:48:26PM +0100, Jonas Karlman wrote:
> Hi Chris,
> 
> On 2023-12-05 22:39, Chris Morgan wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > The Powkiddy X55 is a Rockchip RK3566 based handheld gaming device.
> > UART, ADC, eMMC, and SDMMC are tested to work.
> > 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > ---
> >  arch/arm/dts/Makefile                        |   1 +
> >  arch/arm/dts/rk3566-powkiddy-x55-u-boot.dtsi |  67 ++
> >  arch/arm/dts/rk3566-powkiddy-x55.dts         | 926 +++++++++++++++++++
> >  arch/arm/mach-rockchip/rk3568/Kconfig        |   6 +
> >  board/powkiddy/x55/Kconfig                   |  15 +
> >  board/powkiddy/x55/MAINTAINERS               |   8 +
> >  board/powkiddy/x55/Makefile                  |   6 +
> >  board/powkiddy/x55/x55.c                     | 101 ++
> >  configs/powkiddy-x55-rk3566_defconfig        |  86 ++
> >  doc/board/index.rst                          |   1 +
> >  doc/board/powkiddy/index.rst                 |   9 +
> >  doc/board/powkiddy/x55.rst                   |  46 +
> >  include/configs/powkiddy-x55-rk3566.h        |  12 +
> >  13 files changed, 1284 insertions(+)
> >  create mode 100644 arch/arm/dts/rk3566-powkiddy-x55-u-boot.dtsi
> >  create mode 100644 arch/arm/dts/rk3566-powkiddy-x55.dts
> >  create mode 100644 board/powkiddy/x55/Kconfig
> >  create mode 100644 board/powkiddy/x55/MAINTAINERS
> >  create mode 100644 board/powkiddy/x55/Makefile
> >  create mode 100644 board/powkiddy/x55/x55.c
> >  create mode 100644 configs/powkiddy-x55-rk3566_defconfig
> >  create mode 100644 doc/board/powkiddy/index.rst
> >  create mode 100644 doc/board/powkiddy/x55.rst
> >  create mode 100644 include/configs/powkiddy-x55-rk3566.h
> > 
> > diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> > index 1be08c5fdc..9e38bab6eb 100644
> > --- a/arch/arm/dts/Makefile
> > +++ b/arch/arm/dts/Makefile
> > @@ -174,6 +174,7 @@ dtb-$(CONFIG_ROCKCHIP_RK3568) += \
> >  	rk3566-anbernic-rgxx3.dtb \
> >  	rk3566-quartz64-a.dtb \
> >  	rk3566-quartz64-b.dtb \
> > +	rk3566-powkiddy-x55.dtb \
> >  	rk3566-radxa-cm3-io.dtb \
> >  	rk3566-soquartz-blade.dtb \
> >  	rk3566-soquartz-cm4.dtb \
> > diff --git a/arch/arm/dts/rk3566-powkiddy-x55-u-boot.dtsi b/arch/arm/dts/rk3566-powkiddy-x55-u-boot.dtsi
> > new file mode 100644
> > index 0000000000..2e3998a65a
> > --- /dev/null
> > +++ b/arch/arm/dts/rk3566-powkiddy-x55-u-boot.dtsi
> > @@ -0,0 +1,67 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +
> > +#include "rk356x-u-boot.dtsi"
> > +
> > +/ {
> > +	chosen {
> > +		stdout-path = &uart2;
> > +		u-boot,spl-boot-order = "same-as-spl", &sdmmc0, &sdhci;
> 
> This matches what is set in rk356x-u-boot.dtsi and can be droped.

Will do, thank you.

> 
> > +	};
> > +
> > +	rng: rng@fe388000 {
> > +		compatible = "rockchip,cryptov2-rng";
> > +		reg = <0x0 0xfe388000 0x0 0x2000>;
> > +		status = "okay";
> > +	};
> > +};
> > +
> > +&cru {
> > +	assigned-clocks =
> > +			<&pmucru CLK_RTC_32K>, <&pmucru PLL_PPLL>,
> > +			<&pmucru PCLK_PMU>, <&cru PLL_CPLL>,
> > +			<&cru PLL_GPLL>, <&cru PLL_VPLL>,
> > +			<&cru ACLK_BUS>, <&cru PCLK_BUS>,
> > +			<&cru ACLK_TOP_HIGH>, <&cru ACLK_TOP_LOW>,
> > +			<&cru HCLK_TOP>, <&cru PCLK_TOP>,
> > +			<&cru ACLK_PERIMID>, <&cru HCLK_PERIMID>,
> > +			<&cru CPLL_500M>, <&cru CPLL_333M>,
> > +			<&cru CPLL_250M>, <&cru CPLL_125M>,
> > +			<&cru CPLL_100M>, <&cru CPLL_62P5M>,
> > +			<&cru CPLL_50M>, <&cru CPLL_25M>;
> > +		assigned-clock-rates =
> > +			<32768>, <200000000>,
> > +			<100000000>, <1000000000>,
> > +			<1200000000>, <126400000>,
> > +			<150000000>, <100000000>,
> > +			<500000000>, <400000000>,
> > +			<150000000>, <100000000>,
> > +			<300000000>, <150000000>,
> > +			<500000000>, <333333333>,
> > +			<250000000>, <125000000>,
> > +			<100000000>, <62500000>,
> > +			<50000000>, <25000000>;
> > +		assigned-clock-parents =
> > +			<&pmucru CLK_RTC32K_FRAC>;
> > +};
> > +
> > +&pmucru {
> > +	assigned-clocks = <&pmucru SCLK_32K_IOE>;
> > +	assigned-clock-parents = <&pmucru CLK_RTC_32K>;
> > +};
> > +
> > +/*
> > + * We don't need the clocks, but if they are present they may cause
> > + * probing to fail so we remove them for U-Boot.
> > + */
> > +&rk817 {
> > +	/delete-property/ assigned-clocks;
> > +	/delete-property/ assigned-clock-parents;
> > +	/delete-property/ clocks;
> > +	/delete-property/ clock-names;
> > +};
> 
> You should not need to remove these clock properties, the clk driver has
> dummy support for the referenced I2S1_MCLKOUT_TX clock.
> 

I'll test without them then and confirm, thank you. Previously this was
necessary.

> > +
> > +&uart2 {
> > +	clock-frequency = <24000000>;
> > +	bootph-all;
> > +	status = "okay";
> > +};
> 
> [...]
> 
> > diff --git a/arch/arm/mach-rockchip/rk3568/Kconfig b/arch/arm/mach-rockchip/rk3568/Kconfig
> > index baa51349f4..a97da8ae55 100644
> > --- a/arch/arm/mach-rockchip/rk3568/Kconfig
> > +++ b/arch/arm/mach-rockchip/rk3568/Kconfig
> > @@ -22,6 +22,11 @@ config TARGET_ODROID_M1_RK3568
> >  	help
> >  	  Hardkernel ODROID-M1 single board computer with a RK3568B2 SoC.
> >  
> > +config TARGET_POWKIDDY_X55_RK3566
> > +	bool "Powkiddy X55"
> > +	help
> > +	  Powkiddy X55 handheld gaming console with an RK3566 SoC.
> > +
> >  config TARGET_QUARTZ64_RK3566
> >  	bool "Pine64 Quartz64"
> >  	help
> > @@ -45,5 +50,6 @@ source "board/rockchip/evb_rk3568/Kconfig"
> >  source "board/anbernic/rgxx3_rk3566/Kconfig"
> >  source "board/hardkernel/odroid_m1/Kconfig"
> >  source "board/pine64/quartz64_rk3566/Kconfig"
> > +source "board/powkiddy/x55/Kconfig"
> >  
> >  endif
> > diff --git a/board/powkiddy/x55/Kconfig b/board/powkiddy/x55/Kconfig
> > new file mode 100644
> > index 0000000000..a7b3ed4d0d
> > --- /dev/null
> > +++ b/board/powkiddy/x55/Kconfig
> > @@ -0,0 +1,15 @@
> > +if TARGET_POWKIDDY_X55_RK3566
> > +
> > +config SYS_BOARD
> > +	default "x55"
> > +
> > +config SYS_VENDOR
> > +	default "powkiddy"
> > +
> > +config SYS_CONFIG_NAME
> > +	default "powkiddy-x55-rk3566"
> > +
> > +config BOARD_SPECIFIC_OPTIONS
> > +	def_bool y
> > +
> > +endif
> > diff --git a/board/powkiddy/x55/MAINTAINERS b/board/powkiddy/x55/MAINTAINERS
> > new file mode 100644
> > index 0000000000..2c83cd6ee1
> > --- /dev/null
> > +++ b/board/powkiddy/x55/MAINTAINERS
> > @@ -0,0 +1,8 @@
> > +X55
> > +M:	Chris Morgan <macromorgan@hotmail.com>
> > +S:	Maintained
> > +F:	board/powkiddy/x55
> > +F:	include/configs/powkiddy-x55-rk3566.h
> > +F:	configs/powkiddy-x55-rk3566_defconfig
> > +F:	arch/arm/dts/rk3566-powkiddy-x55.dts
> > +F:	arch/arm/dts/rk3566-powkiddy-x55-u-boot.dtsi
> 
> doc/board/powkiddy/x55.rst should probably also be listed.

Acknowledged, thank you.

> 
> > diff --git a/board/powkiddy/x55/Makefile b/board/powkiddy/x55/Makefile
> > new file mode 100644
> > index 0000000000..55c8c16aa1
> > --- /dev/null
> > +++ b/board/powkiddy/x55/Makefile
> > @@ -0,0 +1,6 @@
> > +# SPDX-License-Identifier:     GPL-2.0+
> > +#
> > +# Copyright (c) 2023 Chris Morgan <macromorgan@hotmail.com>
> > +#
> > +
> > +obj-y += x55.o
> > diff --git a/board/powkiddy/x55/x55.c b/board/powkiddy/x55/x55.c
> > new file mode 100644
> > index 0000000000..5c8d7e2bcd
> > --- /dev/null
> > +++ b/board/powkiddy/x55/x55.c
> > @@ -0,0 +1,101 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (c) 2023 Chris Morgan <macromorgan@hotmail.com>
> > + */
> > +
> > +#include <asm/io.h>
> > +#include <command.h>
> > +#include <linux/iopoll.h>
> > +
> > +#define BOOT_BROM_DOWNLOAD	0xef08a53c
> > +
> > +#define GPIO4_BASE		0xfe770000
> > +#define GPIO_SWPORT_DR_L	0x0000
> > +#define GPIO_SWPORT_DDR_L	0x0008
> > +#define GPIO_B4			BIT(12)
> > +#define GPIO_B5			BIT(13)
> > +#define GPIO_B6			BIT(14)
> > +
> > +#define GPIO_WRITEMASK(bits)	((bits) << 16)
> > +
> > +#define SARADC_BASE		0xfe720000
> > +#define SARADC_DATA		0x0000
> > +#define SARADC_STAS		0x0004
> > +#define SARADC_ADC_STATUS	BIT(0)
> > +#define SARADC_CTRL		0x0008
> > +#define SARADC_INPUT_SRC_MSK	0x7
> > +#define SARADC_POWER_CTRL	BIT(3)
> > +
> > +/*
> > + * Read the function "button" to determine if we need to boot straight
> > + * into download mode. In this case a user would hold the left joystick
> > + * all the way to the left when powering on the device. This function is
> > + * needed because 1) on some devices it may not be possible to bypass the
> > + * eMMC in the bootpath and 2) after A-TF loads the device will simply
> > + * reboot instead of booting into download mode.
> > + */
> > +void read_func_button(void)
> > +{
> > +	int ret;
> > +	u32 reg;
> > +
> > +	/* Turn off SARADC to reset it. */
> > +	writel(0, (SARADC_BASE + SARADC_CTRL));
> > +
> > +	/* Enable channel 0 and power on SARADC. */
> > +	writel(((0 & SARADC_INPUT_SRC_MSK) | SARADC_POWER_CTRL),
> > +	       (SARADC_BASE + SARADC_CTRL));
> > +
> > +	/*
> > +	 * Wait for data to be ready. Use timeout of 20000us from
> > +	 * rockchip_saradc driver.
> > +	 */
> > +	ret = readl_poll_timeout((SARADC_BASE + SARADC_STAS), reg,
> > +				 !(reg & SARADC_ADC_STATUS), 20000);
> > +	if (ret) {
> > +		printf("ADC Timeout");
> > +		return;
> > +	}
> > +
> > +	/* Read the data from the SARADC. */
> > +	reg = readl((SARADC_BASE + SARADC_DATA));
> > +
> > +	/* Turn the SARADC back off so it's ready to be used again. */
> > +	writel(0, (SARADC_BASE + SARADC_CTRL));
> > +
> > +	/*
> > +	 * If the value is less than 30 the button is being pressed.
> > +	 * Reset the device back into Rockchip download mode.
> > +	 */
> > +	if (reg <= 30) {
> > +		printf("download key pressed, entering download mode...");
> > +		writel(BOOT_BROM_DOWNLOAD, CONFIG_ROCKCHIP_BOOT_MODE_REG);
> > +		do_reset(NULL, 0, 0, NULL);
> > +	}
> > +};
> 
> Would be nice if this could be made more generic for all rockchip boards,
> and using a value from devicetree to configure the channel to use.
> 
> Possible something like rockchip,brom-download-adc-channel = <0> under
> chosen node or something similar could work?
> 
> We should also have enough space in SPL to be able to use driver model
> for interaction with adc.
> 

Will that work prior to A-TF in the SPL stage? One thing I noticed is
that if I call pre A-TF the USB download mode worked as expected, but
post A-TF the device would just reboot (and not into the download
mode). I'll happily make this code generic if I can. Would a suitable
compromise (for now) be to move this into the board specific file for
the rk3568? That would also allow me to remove this (pretty much
identical) code from the rgxx3_rk3566.c board file too. I have some
other code I'm going to submit soon to move the rng_seed code to the
main board.c in mach-rockchip so all boards can benefit. For now the
one requirement I have for this routine is that it runs as early as
possible, since for some devices (but not necessarily this one) it's
the last line of defense against a possible brick.

> > +
> > +/*
> > + * Start LED very early so user knows device is on. Set color
> > + * to red.
> > + */
> > +void spl_board_init(void)
> > +{
> > +	read_func_button();
> > +
> > +	/* Set GPIO4_B4, GPIO4_B5, and GPIO4_B6 to output. */
> > +	writel(GPIO_WRITEMASK(GPIO_B6 | GPIO_B5 | GPIO_B4) | \
> > +	       (GPIO_B6 | GPIO_B5 | GPIO_B4),
> > +	       (GPIO4_BASE + GPIO_SWPORT_DDR_L));
> > +	/* Set GPIO4_B5 and GPIO4_B6 to 0 and GPIO4_B4 to 1. */
> > +	writel(GPIO_WRITEMASK(GPIO_B6 | GPIO_B5 | GPIO_B4) | GPIO_B4,
> > +	       (GPIO4_BASE + GPIO_SWPORT_DR_L));
> > +}
> > +
> > +int rk_board_late_init(void)
> > +{
> > +	/* Turn off red LED and turn on orange LED. */
> > +	writel(GPIO_WRITEMASK(GPIO_B6 | GPIO_B5 | GPIO_B4) | GPIO_B6,
> > +	       (GPIO4_BASE + GPIO_SWPORT_DR_L));
> > +
> > +	return 0;
> > +}
> > diff --git a/configs/powkiddy-x55-rk3566_defconfig b/configs/powkiddy-x55-rk3566_defconfig
> > new file mode 100644
> > index 0000000000..aa29df04d1
> > --- /dev/null
> > +++ b/configs/powkiddy-x55-rk3566_defconfig
> > @@ -0,0 +1,86 @@
> > +CONFIG_ARM=y
> > +CONFIG_SKIP_LOWLEVEL_INIT=y
> > +CONFIG_COUNTER_FREQUENCY=24000000
> > +CONFIG_ARCH_ROCKCHIP=y
> > +CONFIG_TEXT_BASE=0x00a00000
> > +CONFIG_SPL_LIBCOMMON_SUPPORT=y
> > +CONFIG_SPL_LIBGENERIC_SUPPORT=y
> > +CONFIG_NR_DRAM_BANKS=2
> > +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> > +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
> > +CONFIG_DEFAULT_DEVICE_TREE="rk3566-powkiddy-x55"
> > +CONFIG_ROCKCHIP_RK3568=y
> > +CONFIG_SPL_ROCKCHIP_BACK_TO_BROM=y
> 
> SPL load U-Boot proper from FIT image, so this should not be needed.
> 

I'll test this and confirm, but thank you.

> > +CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
> > +CONFIG_ROCKCHIP_RK8XX_DISABLE_BOOT_ON_POWERON=y
> > +CONFIG_SPL_MMC=y
> > +CONFIG_SPL_SERIAL=y
> > +CONFIG_SPL_STACK_R_ADDR=0x600000
> > +CONFIG_TARGET_POWKIDDY_X55_RK3566=y
> > +CONFIG_SPL_STACK=0x400000
> > +CONFIG_DEBUG_UART_BASE=0xFE660000
> > +CONFIG_DEBUG_UART_CLOCK=24000000
> > +CONFIG_SYS_LOAD_ADDR=0xc00800
> > +CONFIG_DEBUG_UART=y
> > +CONFIG_FIT=y
> > +CONFIG_FIT_VERBOSE=y
> 
> Recommend adding following for an added integrity check of loaded FIT
> images.

Will do.

> 
> CONFIG_SPL_FIT_SIGNATURE=y
> CONFIG_LEGACY_IMAGE_FORMAT=y
> 
> Try following patch to speed up boot when signature check is enabled.
> https://patchwork.ozlabs.org/patch/1802303/
> 
> > +CONFIG_SPL_LOAD_FIT=y
> > +CONFIG_OF_STDOUT_VIA_ALIAS=y
> > +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-powkiddy-x55.dtb"
> > +# CONFIG_CONSOLE_MUX is not set
> > +# CONFIG_DISPLAY_CPUINFO is not set
> > +CONFIG_DISPLAY_BOARDINFO_LATE=y
> > +CONFIG_SPL_MAX_SIZE=0x20000
> 
> Should be 0x40000 not 0x20000
> 

Acknowledged.

> > +CONFIG_SPL_PAD_TO=0x7f8000
> > +CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> > +CONFIG_SPL_BSS_START_ADDR=0x4000000
> > +CONFIG_SPL_BSS_MAX_SIZE=0x4000
> > +CONFIG_SPL_BOARD_INIT=y
> > +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> > +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> > +CONFIG_SPL_STACK_R=y
> > +CONFIG_SPL_ATF=y
> > +CONFIG_CMD_PWM=y
> > +CONFIG_CMD_GPT=y
> > +CONFIG_CMD_MMC=y
> > +# CONFIG_CMD_SETEXPR is not set
> > +# CONFIG_CMD_CLS is not set
> > +# CONFIG_SPL_DOS_PARTITION is not set
> > +CONFIG_SPL_OF_CONTROL=y
> > +CONFIG_OF_LIVE=y
> 
> Recommend adding following to ensure pinctrl for sdmmc/sdhci is
> configured at SPL stage.
> 
> CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> CONFIG_SPL_DM_SEQ_ALIAS=y
> CONFIG_SPL_PINCTRL=y
> 

Thanks, I'll test it out.

> > +CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
> > +# CONFIG_NET is not set
> > +CONFIG_SPL_REGMAP=y
> > +CONFIG_SPL_SYSCON=y
> > +CONFIG_SPL_CLK=y
> > +CONFIG_ARM_SMCCC_FEATURES=y
> > +CONFIG_SCMI_FIRMWARE=y
> > +CONFIG_ROCKCHIP_GPIO=y
> > +CONFIG_SYS_I2C_ROCKCHIP=y
> > +CONFIG_MISC=y
> > +CONFIG_SUPPORT_EMMC_RPMB=y
> > +CONFIG_MMC_DW=y
> > +CONFIG_MMC_DW_ROCKCHIP=y
> > +CONFIG_MMC_SDHCI=y
> > +CONFIG_MMC_SDHCI_SDMA=y
> > +CONFIG_MMC_SDHCI_ROCKCHIP=y
> > +CONFIG_DM_PMIC=y
> > +CONFIG_DM_PMIC_FAN53555=y
> 
> I do not see fcs,fan53555 compatible in the device tree, this can be
> droped.

There is a compatible device. I'll test this out though but I think
either it's there under a different compatible (or more likely I need
to add a new compatible to this driver).

> 
> > +CONFIG_PMIC_RK8XX=y
> > +CONFIG_REGULATOR_PWM=y
> > +CONFIG_DM_REGULATOR_GPIO=y
> 
> I do not see any pwm-regulator or regulator-gpio compatible in the
> device tree, these two can be dropped.

I get confused between regulator-gpio and regulator-fixed, sorry.

> 
> > +CONFIG_REGULATOR_RK8XX=y
> > +CONFIG_DM_REGULATOR_SCMI=y
> 
> SCMI clock protocol is only used to control cpu and gpu clock on rk356x,
> this can be droped.

Ack, thanks.

> 
> > +CONFIG_PWM_ROCKCHIP=y
> > +CONFIG_SPL_RAM=y
> > +# CONFIG_RAM_ROCKCHIP_DEBUG is not set
> > +CONFIG_DM_RNG=y
> > +CONFIG_RNG_ROCKCHIP=y
> > +# CONFIG_RNG_SMCCC_TRNG is not set
> > +CONFIG_BAUDRATE=1500000
> > +CONFIG_DEBUG_UART_SHIFT=2
> > +CONFIG_SYS_NS16550_MEM32=y
> > +CONFIG_SYSRESET=y
> > +CONFIG_REGEX=y
> > +CONFIG_ERRNO_STR=y
> > +# CONFIG_EFI_LOADER is not set
> > diff --git a/doc/board/index.rst b/doc/board/index.rst
> > index 531e547e7e..dd4bce9981 100644
> > --- a/doc/board/index.rst
> > +++ b/doc/board/index.rst
> > @@ -36,6 +36,7 @@ Board-specific doc
> >     nxp/index
> >     openpiton/index
> >     phytec/index
> > +   powkiddy/index
> >     purism/index
> >     qualcomm/index
> >     renesas/index
> > diff --git a/doc/board/powkiddy/index.rst b/doc/board/powkiddy/index.rst
> > new file mode 100644
> > index 0000000000..b0115a73d4
> > --- /dev/null
> > +++ b/doc/board/powkiddy/index.rst
> > @@ -0,0 +1,9 @@
> > +.. SPDX-License-Identifier: GPL-2.0+
> > +
> > +Powkiddy
> > +========
> > +
> > +.. toctree::
> > +   :maxdepth: 2
> > +
> > +   x55.rst
> > diff --git a/doc/board/powkiddy/x55.rst b/doc/board/powkiddy/x55.rst
> > new file mode 100644
> > index 0000000000..66d02944c9
> > --- /dev/null
> > +++ b/doc/board/powkiddy/x55.rst
> > @@ -0,0 +1,46 @@
> > +.. SPDX-License-Identifier: GPL-2.0+
> > +
> > +U-Boot for Powkiddy X55 Handheld Gaming Console
> > +===============================================
> > +
> > +This allows U-Boot to boot the Powkiddy X55 handheld gaming console.
> > +The X55 is very similar to the other existing Powkiddy RK3566 based
> > +devices, except that ADC channels 0-3 are used for the ADC joysticks.
> > +As a result the same auto detection functionality cannot be used on
> > +this device as the others.
> > +
> > +The indicator LED will change color based on the boot stage. Red means
> > +the device is powered on but has yet to start U-Boot, amber means the
> > +device has started U-Boot and is waiting to boot Linux, and when Linux
> > +has taken over the LED should change to green (or however it has been
> > +configured by the user).
> > +
> > +In the event the device needs to enter Rockchip download mode, a user
> > +can, starting with the power off, hold the left joystick all the way
> > +to the left and then power on the device. At this point the USB-C port
> > +marked DC/OTG should be set to peripheral mode and allow a user to
> > +manipulate the device with the rkdeveloptool tool.
> > +
> > +Building U-Boot
> > +---------------
> > +
> > +.. code-block:: bash
> > +
> > +    $ export CROSS_COMPILE=aarch64-linux-gnu-
> > +    $ export BL31=../rkbin/bin/rk35/rk3568_bl31_v1.34.elf
> > +    $ export ROCKCHIP_TPL=../rkbin/bin/rk35/rk3568_ddr_1056MHz_v1.13.bin
> 
> I know that the rk3566/rk3568 ddr blobs are identical, but suggest you
> reference correct ddr blob here.
> 

Will do. In one of my rkbin trees (the one I must have been testing
with) there were no 3566 files, so that might be why I did this. Will
update.

> > +    $ make powkiddy-x55-rk3566_defconfig
> > +    $ make
> > +
> > +This will build ``u-boot-rockchip.bin`` which can be written to an SD
> > +card.
> > +
> > +Image installation
> > +------------------
> > +
> > +Write the ``u-boot-rockchip.bin`` to an SD card or the internal eMMC
> > +offset 32kb from the start.
> > +
> > +.. code-block:: bash
> > +
> > +    $ dd if=u-boot-rockchip.bin of=/dev/mmcblk0 bs=512 seek=64
> 
> Why just not reference the common Rockchip build and flashing
> instructions at doc/board/rockchip/rockchip.rst ? Are they missing
> something and could/should be updated?
> 
> Also missing addition of this board under the rk3566 heading in that doc.

No, this was mostly a cut and paste of docs I wrote for the Anbernic
RGxx3 series. I'll cut this part out and reference that instead.

> 
> Regards,
> Jonas
> 

Thank you for all your feedback. I'll work on a V2 and send it soon.

> > diff --git a/include/configs/powkiddy-x55-rk3566.h b/include/configs/powkiddy-x55-rk3566.h
> > new file mode 100644
> > index 0000000000..4b25c6a877
> > --- /dev/null
> > +++ b/include/configs/powkiddy-x55-rk3566.h
> > @@ -0,0 +1,12 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +
> > +#ifndef __POWKIDDY_X55_RK3566_H
> > +#define __POWKIDDY_X55_RK3566_H
> > +
> > +#include <configs/rk3568_common.h>
> > +
> > +#define ROCKCHIP_DEVICE_SETTINGS \
> > +			"stdout=serial,vidconsole\0" \
> > +			"stderr=serial,vidconsole\0"
> > +
> > +#endif
> 
