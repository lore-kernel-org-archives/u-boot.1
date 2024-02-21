Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB55C48BC3
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 06:25:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDC3C87DEC;
	Wed, 21 Feb 2024 07:25:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="PLwXwOXe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B32B287DF8; Wed, 21 Feb 2024 07:25:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59AD087DEC
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 07:24:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708496697; x=1740032697;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=cUr3fDNCm+fJwJm92fGCs8iUUNuNmX66b0k3QKpjTFY=;
 b=PLwXwOXe5nWd0EWC9Lr0k+S6C3c0NoSWHlFS23hE3Mj+aW4NyuI0bvSU
 YqLDqyyl20/4Uv8aPd+w7c6xWxrrECJyVL9tYfF+86+TDO7nCxwZebI2q
 Mtk+vdVYz6KkPD1U73ZB8cZYM/LxJeXZQ5INfmAT+cT0NGU5PAsGYzPAE
 rP66LepHLqLM7+CAx9olottliPD43uxBrtINJRUyz5hvShlmo7LNOQlWu
 sp0qAgoWhzFz/LxuLJ1kXmK5kUPSAGYoR41uBG5xyQ8JCNrBWz57WMFd8
 qZFVtPjCigsY231mqwg8RFJIPVYxY0QoH3WWbTzp2JUUCrBpr+P1h8+nn w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2777484"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2777484"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2024 22:24:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="5339999"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Feb 2024 22:24:50 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 22:24:49 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 22:24:49 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 22:24:49 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 22:24:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hxea17pZD9ohhETZseN2c6z8cYFThck0uUXk2UIEE8H0vWaWkGZEonSHgIv8LcM9t9e7S6EVYIdipZ2cCEoEWohRWYFtKyPJSASWxAYdLbydIcMJg2FXG7VYUybWPMQIKAY/AFcOwbBhsnSNl0NuC61cKxcDak8IcFkF1OdmvyeAwKfLhKIF78GJxnXtVN58bTPB+ISM74SbseUI03AWEpob889ySMMBCSnRuqkBEKLjCASoHJjzr0tiYTMF1M1XS+ECEIz8Qa+Y9c5HxLpm+u4evdcDIcoI0QgCm/OaNsO04P0H6wlfNBkJ8l7YNEGdNF+DV90HZd5PbRyu7Ak3Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1uARz5IgJaL09dBdfE/o1T0DsSKXGCrEZawlu+uCBWM=;
 b=AFTCdVB65se9k9qaYBvypg3gSnaU7coPuHWy91UBoKRa0CkCYCpsiBS5absvaLKvwxMKeuvZCOHYl1IvJUyLI3NK1kAbXxqtWqOU5wo3WQiaPLoN23SNuVeLr8YmSQSFuNLOcAX09juJTTOuSj7MutVOQ1Y6E3XE3nJ8mpPYLx983NDW1oSjQx4ga/vhOGR/DlsJsapMYo18Y8vOqMiDo3SureKEbR5TmlLu1KnceZakWIGjAn/kw8CQ7i8DQDWONkk72v8/4qHTbC/qhAK2X0aP7+Luw4GZtyF1yKZx2hUnpywgGVAwmUkfTMkd2wUbtXSyN26zzRdMGy3gB54XAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 SN7PR11MB7537.namprd11.prod.outlook.com (2603:10b6:806:348::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.37; Wed, 21 Feb
 2024 06:24:47 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::e293:879a:787b:a663]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::e293:879a:787b:a663%5]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 06:24:47 +0000
From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
To: "Lim, Jit Loon" <jit.loon.lim@intel.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Jagan Teki <jagan@amarulasolutions.com>, Marek <marex@denx.de>, Simon
 <simon.k.r.goldschmidt@gmail.com>, "Hea, Kok Kiang"
 <kok.kiang.hea@intel.com>, "Maniyam, Dinesh" <dinesh.maniyam@intel.com>, "Ng, 
 Boon Khai" <boon.khai.ng@intel.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@intel.com>, "Chong, Teik Heng"
 <teik.heng.chong@intel.com>, "Zamri, Muhammad Hazim Izzat"
 <muhammad.hazim.izzat.zamri@intel.com>, "Tang, Sieu Mun"
 <sieu.mun.tang@intel.com>, Bin Meng <bmeng.cn@gmail.com>
Subject: RE: [PATCH v1 1/1] arch:arm: Agilex5 enablement
Thread-Topic: [PATCH v1 1/1] arch:arm: Agilex5 enablement
Thread-Index: AQHaZAo6jZZES1hj7kWE3VckHwGIwbEUTtyg
Date: Wed, 21 Feb 2024 06:24:46 +0000
Message-ID: <DM8PR11MB5592E1516ABBD66396B303DCD2572@DM8PR11MB5592.namprd11.prod.outlook.com>
References: <20240220143603.22091-1-jit.loon.lim@intel.com>
In-Reply-To: <20240220143603.22091-1-jit.loon.lim@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|SN7PR11MB7537:EE_
x-ms-office365-filtering-correlation-id: 8294d131-12f3-430a-49c8-08dc32a5ccf6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: posZKplS6MOp+UUggGV8+9u4sk1Sjt/rJxZ+oZ/ieGFDkV4HLY6MPjQqTW+v10Y4W/iZp0g8GE1Lfvx7poTNx6WyLpq1keGzOUszO9jtZeT/cNAwrw+tsChZWnW33jzJ/T0Ys0AhRuRJ4Y9mcIPxhYK2IjPOvotx8D/7pGB9mn0oIx7TJde9Abue5OXR1GTWJHFT1n1KdL6HQpkfDh/lebhcR/RdGer7e6ojeXHzkTMPAJV5dhjoJBA04mjVkJYpnELyAHkKJHl7G4NL/5qdg1ge9qdIh/v2pGlcTPFHMWzP6nba0q2vUZ8ch8QRULDc/k6zWF8frLfcVkq6nQBD5hRBGLP6FGswpF/guSLRIFmjAbFhT8WWudV3Ol9QvIk2S0PIdMQY7DmKWtApByvZGOHkEDOie9PhJOSxYwDhlprB1jD2WfNIm/0UbWuT1coLy8G1qS2GGCSSSzFUiCwdKANtvfeKdgsgETIkW+1moMOm+hqPXu1DxVSpp8Z4bMqBl2ICC7qb8svb6cNq7747rh9rZIwlwvN1R1qVaDzFvDauw+GOqSknq4fEHPnwT9ZQfME08KRVlxzHZOqZZL0juleWKGxsWA/UVf7Rr98EgzY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5592.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4QS5tqh20wO5U4XCbao0+tVvYSxt8NwkpIMN4eofF8j8+ZAyoRq5Le31jacQ?=
 =?us-ascii?Q?nVuNZA3DlWDWa0467bjxh1bWGsrz6a38TlY82yIGlOi3gP07saTBHMZofMrp?=
 =?us-ascii?Q?k3+/I/muzXy+9CiOm7opnCTbIh8vejVIy26q2HWcHRot4/2S05+GQZIZH3Ge?=
 =?us-ascii?Q?GhRPrE1GPYixR1sknod+O+oxvUgMbguMVZSsiqfGTrtLCD2pkmYEwPK814m5?=
 =?us-ascii?Q?5xKZfCGnnwzNGrt2da9k4KN5x6WqB2lWfoXuSIleVEy15/7zhLUGHORk8uq8?=
 =?us-ascii?Q?KDrllkGA4ZU7InocliLG99B/2MCzX4di9GIkp7ahLVJNZQ6ZuqAnFbxKYq4r?=
 =?us-ascii?Q?/C72C4uG8gsKmwCeYFpfdLEqiKyZzmsmG5Zhfckd+1OWh9qg0rf6G8RfOpeK?=
 =?us-ascii?Q?QqUaGKd3h+/OA0PHWSsgbS+udOjS64mvj5jmZrf3WnxwO10i0b60oblt9AZ2?=
 =?us-ascii?Q?YvIryb5Xm/WCDh/iMZfDitzRVQVsNTODAodRTNvK7jiqROVSIHlIk09yhib2?=
 =?us-ascii?Q?PtDa8ZQ3css7lKG80srPDuwH0XIa6A3gMdshTEYYt6L7TULQAjsY2K/vsCzQ?=
 =?us-ascii?Q?eFV62wzy0t2NdY6p5K6JaEvLUDha8HjTZlMSMCmMstF33ELXsLrnXAYn3h+I?=
 =?us-ascii?Q?qHU5y9lDAGiYbtT+A0bYwzxpj28sCmP8tnUeHzLlBNTZjJIpwaeXdbPmkjfU?=
 =?us-ascii?Q?E9HH9Rqf2jldfOVF10vrZhBcErosDJWk8HInxakKz669sdStbN5t/H0ewezD?=
 =?us-ascii?Q?4EfJBPRbucfJn9dwtl40GG9s+rNTun2eIN8dCWmw8DqW20Ol6cgBcKfHBMob?=
 =?us-ascii?Q?PBdXkFWm7SUOKpg2KUazBdU2BjCkXXFHs6261X0MJ/e76bqxYKr8Mh2KgySy?=
 =?us-ascii?Q?NB/7YaBYwV6vidYbB0sx+boBpzrxN9f7LqW+VvYjk7eqHUj5HpXYxSvwG31F?=
 =?us-ascii?Q?bmQbTucbPBFfYBarCU2BqzkibMXSTecHyc63FpP61I69puS2y/HWy+wT27J5?=
 =?us-ascii?Q?7iFGCUYg8MpUgUXk2YY5/kFp/b2cW5VX8/T1+rCI4E07rDf1EBNvAMBaBMHe?=
 =?us-ascii?Q?CDSFoxm2+x5hbNaY6iuSkj7f4EA9lk6RhxY+bDNVnz1aoSNU5VuKMEQ4q0tS?=
 =?us-ascii?Q?8xq8bx548b5I5n2ZZYMaLLSUwiE3ivOGaD3BWKt5INZYiLFQA+zKjY2TWiic?=
 =?us-ascii?Q?0pa6mFBDHKnZ8HzhC1PviMwYjwTgN5p43KY9Y/kh2aBcREwyeoc/GQ2T+p47?=
 =?us-ascii?Q?AwsJzWO2C8grA6WanGACcGHewad+JnrV6fkVkW1OolmhqmcFLWgAwdQm6lw6?=
 =?us-ascii?Q?Yqedvb37u20PKnvMQPHTkXf/LbmD5uq5t5/X1tzf5Rf/+dP4YTe9wJM0Q71g?=
 =?us-ascii?Q?lfpPhvHILm3u0WYJYPKOQVkiH82ZyY01QY1cqsonXpiK12A73ASG3bxBQ99U?=
 =?us-ascii?Q?lFGtHEysC37BKTT5Ab3ARkeIRXbKhqrnfG8g7lOLhxmltkzlegEicP03gBzI?=
 =?us-ascii?Q?JbIHVTztOZVLEpGiOOheuSo0LMLpQMWyZJfU3eWHy6HwlJvcQmhy0RVMxrul?=
 =?us-ascii?Q?uevauOnXmvHYRYkN8+v3DcrQglMGYHn2jWoxANn9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8294d131-12f3-430a-49c8-08dc32a5ccf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 06:24:46.9050 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zCi9765NfWceaaRmn+2CqHxxeAZ+vGLsyUVT92CFhg6wFaQg5wfj6B3gKer3kGrwdlue0dKut3U2ypXwSifYx5XJiLby7npWjhoaD3me+yk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7537
X-OriginatorOrg: intel.com
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

Hi,

> -----Original Message-----
> From: Lim, Jit Loon <jit.loon.lim@intel.com>
> Sent: Tuesday, February 20, 2024 10:36 PM
> To: u-boot@lists.denx.de
> Cc: Jagan Teki <jagan@amarulasolutions.com>; Marek <marex@denx.de>;
> Simon <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@intel.com>; Hea, Kok Kiang <kok.kiang.hea@intel.com>;
> Maniyam, Dinesh <dinesh.maniyam@intel.com>; Ng, Boon Khai
> <boon.khai.ng@intel.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@intel.com>; Chong, Teik Heng
> <teik.heng.chong@intel.com>; Zamri, Muhammad Hazim Izzat
> <muhammad.hazim.izzat.zamri@intel.com>; Lim, Jit Loon
> <jit.loon.lim@intel.com>; Tang, Sieu Mun <sieu.mun.tang@intel.com>; Bin
> Meng <bmeng.cn@gmail.com>
> Subject: [PATCH v1 1/1] arch:arm: Agilex5 enablement
>=20
> This patch is to enable Agilex5 platform for Intel product. Changes,
> modification and new files are created for board, dts, configs and makefi=
le to
> create the base for Agilex5.
>=20
> Signed-off-by: Jit Loon Lim <jit.loon.lim@intel.com>
> ---
>  arch/arm/Kconfig                              |   9 +-
>  arch/arm/dts/Makefile                         |  32 +----
>  .../arm/dts/socfpga_agilex5_socdk-u-boot.dtsi |  11 +-
>  arch/arm/dts/socfpga_agilex5_socdk.dts        |  67 +---------
>  arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi    |   2 +-
>  arch/arm/mach-socfpga/Kconfig                 | 125 +++++-------------
>  arch/arm/mach-socfpga/Makefile                |  99 +-------------
>  arch/arm/mach-socfpga/board.c                 |   2 -
>  .../include/mach/base_addr_soc64.h            |  16 +--
>  board/intel/agilex5-socdk/MAINTAINERS         |   2 +
>  board/intel/agilex5-socdk/Makefile            |   2 +-
>  board/intel/agilex5-socdk/socfpga.c           |   2 +-
>  configs/socfpga_agilex5_defconfig             |  33 -----
>  include/configs/socfpga_agilex5_socdk.h       |   2 +-
>  include/configs/socfpga_soc64_common.h        |  40 +-----
>  15 files changed, 63 insertions(+), 381 deletions(-)
>=20
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig index
> 43d5ad346f..c8d91669da 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -28,7 +28,7 @@ config COUNTER_FREQUENCY
>  			ROCKCHIP_RK3288 || ROCKCHIP_RK322X ||
> ROCKCHIP_RK3036
>  	default 25000000 if ARCH_LX2160A || ARCH_LX2162A ||
> ARCH_LS1088A
>  	default 100000000 if ARCH_ZYNQMP
> -	default 400000000 if ARCH_SOCFPGA && ARM64

This patch is not based on latest U-Boot main branch https://source.denx.de=
/u-boot/u-boot.git, no such code in current main branch.

> +	default 200000000 if ARCH_SOCFPGA && ARM64 &&
> TARGET_SOCFPGA_AGILEX5
>  	default 0
>  	help
>  	  For platforms with ARMv8-A and ARMv7-A which features a system
> @@ -1088,14 +1088,14 @@ config ARCH_SNAPDRAGON
>  	select SPMI
>  	imply CMD_DM
>=20
> -config ARCH_SOCFPGA

Why remove this?

> -	bool "Altera SOCFPGA family"
> +bool "Altera SOCFPGA family"

Why to change this?

>  	select ARCH_EARLY_INIT_R
>  	select ARCH_MISC_INIT if !TARGET_SOCFPGA_ARRIA10
>  	select ARM64 if TARGET_SOCFPGA_SOC64
>  	select CPU_V7A if TARGET_SOCFPGA_GEN5 ||
> TARGET_SOCFPGA_ARRIA10
>  	select DM
>  	select DM_SERIAL
> +	select GICV2
>  	select GPIO_EXTRA_HEADER
>  	select ENABLE_ARM_SOC_BOOT0_HOOK if
> TARGET_SOCFPGA_GEN5 || TARGET_SOCFPGA_ARRIA10
>  	select OF_CONTROL
> @@ -1109,7 +1109,7 @@ config ARCH_SOCFPGA
>  	select SPL_SOCFPGA_SEC_REG if TARGET_SOCFPGA_SOC64
>  	select SPL_SERIAL
>  	select SPL_SYSRESET
> -	select SPL_WATCHDOG
> +	select SPL_WATCHDOG if !TARGET_SOCFPGA_AGILEX5

This can be removed, watchdog is supported in Agilex5

>  	select SUPPORT_SPL
>  	select SYS_NS16550
>  	select SYS_THUMB_BUILD if TARGET_SOCFPGA_GEN5 ||
> TARGET_SOCFPGA_ARRIA10 @@ -1123,6 +1123,7 @@ config
> ARCH_SOCFPGA
>  	imply DM_SPI
>  	imply DM_SPI_FLASH
>  	imply FAT_WRITE
> +	imply MTD
>  	imply SPL
>  	imply SPL_DM
>  	imply SPL_DM_SPI
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile index
> 90d933a9ae..646f4feaf7 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -543,37 +543,7 @@ dtb-$(CONFIG_TARGET_AM3517_EVM) +=3D am3517-
> evm.dtb
>  dtb-$(CONFIG_TARGET_THUNDERX_88XX) +=3D thunderx-88xx.dtb
>=20
>  dtb-$(CONFIG_ARCH_SOCFPGA) +=3D				\
> -	socfpga_agilex_n6010.dtb			\
> -	socfpga_agilex_socdk.dtb			\
> -	socfpga_agilex_socdk_nand.dtb                   \
> -	socfpga_agilex_socdk_qspi.dtb			\
> -	socfpga_agilex5_socdk.dtb			\
> -	socfpga_agilex5_emu.dtb			\
> -	socfpga_agilex7m_socdk.dtb			\
> -	socfpga_agilex7m_socdk_nand.dtb			\
> -	socfpga_arria5_secu1.dtb			\
> -	socfpga_arria5_socdk.dtb			\
> -	socfpga_arria10_chameleonv3_270_2.dtb		\
> -	socfpga_arria10_chameleonv3_270_3.dtb		\
> -	socfpga_arria10_chameleonv3_480_2.dtb		\
> -	socfpga_arria10_socdk_nand.dtb			\
> -	socfpga_arria10_socdk_qspi.dtb			\
> -	socfpga_arria10_socdk_sdmmc.dtb			\
> -	socfpga_cyclone5_mcvevk.dtb			\
> -	socfpga_cyclone5_is1.dtb			\
> -	socfpga_cyclone5_socdk.dtb			\
> -	socfpga_cyclone5_dbm_soc1.dtb			\
> -	socfpga_cyclone5_de0_nano_soc.dtb		\
> -	socfpga_cyclone5_de1_soc.dtb			\
> -	socfpga_cyclone5_de10_nano.dtb			\
> -	socfpga_cyclone5_sockit.dtb			\
> -	socfpga_cyclone5_socrates.dtb			\
> -	socfpga_cyclone5_sr1500.dtb			\
> -	socfpga_cyclone5_vining_fpga.dtb		\
> -	socfpga_n5x_socdk.dtb				\
> -	socfpga_stratix10_socdk.dtb			\
> -	socfpga_stratix10_socdk_nand.dtb                \
> -	socfpga_stratix10_socdk_qspi.dtb

Why remove these?

> +	socfpga_agilex5_socdk.dtb
>=20
>  dtb-$(CONFIG_TARGET_DRA7XX_EVM) +=3D dra72-evm.dtb dra7-evm.dtb
> 	\
>  	dra72-evm-revc.dtb dra71-evm.dtb dra76-evm.dtb diff --git
> a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
> b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
> index 5da93576c2..28e1c140c2 100755
> --- a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
> @@ -2,7 +2,7 @@
>  /*
>   * U-Boot additions
>   *
> - * Copyright (C) 2022-2023 Intel Corporation <www.intel.com>
> + * Copyright (C) 2024 Intel Corporation <www.intel.com>
>   */

You are not using U-Boot main branch as the base.
Please rebase the patch on U-Boot main branch, I will review in next versio=
n.

[...]

Regards,
Tien Fong
