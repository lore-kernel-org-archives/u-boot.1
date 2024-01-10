Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750A8C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 06:58:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 826DF878D7;
	Wed, 10 Jan 2024 07:58:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="fXLy2CqB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD890878F5; Wed, 10 Jan 2024 07:58:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52B49878D5
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 07:58:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1704869886; x=1736405886;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=8rgIrLPCX9fEnW093Rg/Tqr1Az1ETSyfjkYX836vVJM=;
 b=fXLy2CqBYCMxMs+ds4OkjbPftDsWioiiZpkOudiIhHDfGP2QKRSWWUGR
 zMQwAA3/w1ZpPZ2JGvtsfcdRfdtEage4WWvILHhDPEe3BQiKdDiNHEq/j
 KP1UaNsK/v7pxV8voqz/IrwQEqaai+ZqOuxI8X1g6U3QRr5oiXVKYHnz+
 gUq2V8JIi2bH8R8/3bjDEx/bHuhdGjc5qnOVVDxp5onLGp0T3+iBIY9g8
 Sx8MBfcvX0r2ONd8dA40ijD2F5KmzqXmnJ+T4NKp4H6Xd4KZIThxWCxvd
 Xn8DLKoZYCEN4oc3tqhv3GyxjT9Mez1Titn+a2RQOP0LW6gdFhlpnskE1 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="388870819"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; d="scan'208";a="388870819"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jan 2024 22:58:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="1029055243"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; d="scan'208";a="1029055243"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 09 Jan 2024 22:58:02 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 22:58:01 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Jan 2024 22:58:01 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Jan 2024 22:58:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYKcueJ3jL84XfOmdP+LLyfzfcPGsGftkpNVYIN/YLBpr8lFBfAfpIbx97iRmAO8qxFP/0VSoaEynPypKkB5RzwY60fapdYBPlsFG062WFXwluHa1KGQsZMvFEeUBDXUgpTrF60vE0etgY64Hui0Yj/12FRWx1wi+yNnEQv9tMBnUzjB6RRHiMkNwnomDxEfOr5wicZ1RWlkAVXEwJDFPeX/V4HW4F2OJsPxjJXfv5eO984NJgOil3RMRsSXgvTDz6sRGaJfgZ9+LuJUwawHhyrnr5TrntcMmGXY7bjXwpFdqDVjq3yXyYj3R9wOMTdgOY5idF2jFbHU47Y17QEMxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUuXSZIF0V4+Ye+m92H+TfsqXizF2xjhbztZ3eV3C7E=;
 b=mXiz+yWFOneWg/TRwGY2vT1YUF9n1cCq3hPWynfefXaXr//fbHsWt3qHa6WbIM2vo34IfcyqBn5GpNsBzHLrW8bkJOGlYM5GZn+5DR9o+E5l5snstOMcq/wMpIX+e4Ck0fuixWfKhnhgbl75D8fUvdlQfZpX5qbBnixbeAkF9X1MXvzcgb20WTaKxYUOdmeITVFPWSpjQKxJQ3+9q+tPDikrcqovnHj68vJ2hsJrOj+DFB9iOANJn3bJOcjpDONHshxuK8LfNqrPpi0X2i1XRdMUo9Buop/nFfU7gPdDqUgxHSaGmxE4jF/tpxwgTAFXvp4VFZN//ic4qthSCaFZTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Wed, 10 Jan
 2024 06:57:53 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::e293:879a:787b:a663]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::e293:879a:787b:a663%5]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 06:57:53 +0000
From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
To: "Maniyam, Dinesh" <dinesh.maniyam@intel.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>, "Hea, Kok
 Kiang" <kok.kiang.hea@intel.com>, "Ng, Boon Khai" <boon.khai.ng@intel.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>, "Chong, Teik Heng"
 <teik.heng.chong@intel.com>, "Zamri, Muhammad Hazim Izzat"
 <muhammad.hazim.izzat.zamri@intel.com>, "Lim, Jit Loon"
 <jit.loon.lim@intel.com>, "Tang, Sieu Mun" <sieu.mun.tang@intel.com>
Subject: RE: [PATCH] arm: socfpga: stratix10: SPI clock support
Thread-Topic: [PATCH] arm: socfpga: stratix10: SPI clock support
Thread-Index: AQHaKOGBkfMIys4YCUK/9hCMjehWe7DS0i0A
Date: Wed, 10 Jan 2024 06:57:53 +0000
Message-ID: <DM8PR11MB55929AFE6EC8185B83F5E380D2692@DM8PR11MB5592.namprd11.prod.outlook.com>
References: <20231207074602.15254-1-dinesh.maniyam@intel.com>
In-Reply-To: <20231207074602.15254-1-dinesh.maniyam@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|SA3PR11MB8118:EE_
x-ms-office365-filtering-correlation-id: a97f478f-f362-4e1a-6272-08dc11a977cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UedpQzU2szKIUSv0P/PEqb7+apMBknKi0DrrdfeMIM0njfWh0U2PwTGkKuGt8mEAgRkQJDzQmNFwXkb2vYFuoWOgMExsflvZ0ipbBctGHPp5v2lpfLBbNzOBEaWZxzzjdHQUzIXLDmPCvO2EvEiD0Oz861YO2ijBbZ1MasOVFC+X9UYfzreEA+vPrVbwU4pb51cyaI+/DkUe2BWn3qbKhV9Tlwo4oK2mEbxGt0LmT0nxBVVSVeSC7yyuhLBbt+oLiGx6c5AK0g77IK21Y9ckm3MsovS5y2k2ihbiNMt8zrSafGB9aQd6H1F3CD140A/IPZkhKRvxIAtoOU5uzx1ZbKesfDU7KE0d3chUD9NOltOkv5q3Q3igSXKFWPcryDb/zqAD3T8HRPr3LRa/FnJsEZ25nNYmUdaHIH6G507KwwzTdzu1KHviuAbPHHGr61LJiS7/+MZffbAht4IHc4oNOBCy8WrhMT81a2va+Is+a9csc2/D4mW7U6GqLmux78ceRT6T3caBfYPaX24mPGovIlIfEL/dbMEGtxmt19R+Ui6MDrdsE92x7xl8+JNxFy6ejYG8Wwib/YnhAQsZVLf5TrXJk2V9m1yXm/L6gk3YyR8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5592.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(39860400002)(346002)(376002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(71200400001)(53546011)(107886003)(26005)(38100700002)(122000001)(4326008)(8676002)(5660300002)(8936002)(52536014)(41300700001)(2906002)(478600001)(6506007)(9686003)(7696005)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(316002)(76116006)(110136005)(86362001)(33656002)(82960400001)(38070700009)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BKU/MB1UuEsaKGdiyDHK3MxG8Zue2eRrcJyd62BeUt9uK1WG8+LSTl68LydP?=
 =?us-ascii?Q?qqOsSo5eCoGdV+hKV1TKPzVaNrrMnpQOdP5fox3JSEFBAIEkhVEjE4J3yEhC?=
 =?us-ascii?Q?CqvO9O0bim7RFQA8v9KRP5lzy4V2mkbwHgTuUbIestsRe3SPVc+xEZhrEB8s?=
 =?us-ascii?Q?Eo9PpRCvS+0Z/aKIjyR+7Lo9fYy5k1Ass6C9njZDWBCi9sgIbwMJJB5WnVrF?=
 =?us-ascii?Q?Xyf8VC/o62xHZfRoZPCKVXk85Uztazk7txer5i8VYx7njhfxe1FV/0uXcAVY?=
 =?us-ascii?Q?aMKpbP+mxXyA2IxaM3n3Diy1YMWK+z5h78ARl9LsAebN9P9hQHv+lQurl9j9?=
 =?us-ascii?Q?j2eUAMAif6eUJn0PzmhnCjhBWiqmUwuVlHZbPk3kv3UFqk/NlhVk9aFISRdm?=
 =?us-ascii?Q?xk0z+dG7VVbaolN3Ygm/gl1kq5XR/xBG/0RgSzBbA44VzhSFJbh/lyxo5KJn?=
 =?us-ascii?Q?5A1QX4i/8796VyDGPpDAii/w53Ct7kC2RopuUKcYdstmjZCqoqZeXe5zLqlO?=
 =?us-ascii?Q?veykRwzTbfLasx4ZNkdYHkcpSivGB3DR9DQs/VzfvFH/NiPyKHjwUgwV0Cyo?=
 =?us-ascii?Q?SXizA2orFAcMk63zG26WcTyqmEIBHMD7ey7/uLtGUx0ZdZzRQGTuzeIc7x5b?=
 =?us-ascii?Q?BgxJqH4bUo7O4rjE3ucxOdoKqpmGKme5cFx3LtqZjl1WvvkawQfrzXNisY0G?=
 =?us-ascii?Q?E08b6k2G01go4baowYBWN9W83xOUic/lNhYz57xbXLl2ogS5CRjQaRGdkBzr?=
 =?us-ascii?Q?x65GSXBlDu3zEzxjugAOKKnTibJNYA4mlMs5Iv8FG2A1Z7Ve49XEtUvzyUfx?=
 =?us-ascii?Q?wfsKCSErWXwcOm+sBeflr5L8KKQ2VQSDac3VpBdfZDuo5lXgDqvqdkQyIEtD?=
 =?us-ascii?Q?robWplyeTrnh8+PXbLsGKTsK7LaDmChsrcZVlfLyEM+/AYILsH69MEx27vvv?=
 =?us-ascii?Q?QctsGgyngusNQXbPqHZk5YipEdyuKWMqyGwjDSVyEHEEhbIPYhVNTivw+Bej?=
 =?us-ascii?Q?e74jYImVgCxmgb0rbJBnXppdDGdu+fln4bZ+PcDreejGcA2t3vb1t6rOmAnJ?=
 =?us-ascii?Q?VCDkiWV9q3ttHtw4I5+1vyBsnKQfvFbUZ+MoRgCbTE5YiXGPq/fGJA8bebuH?=
 =?us-ascii?Q?JNg4ktwtjU9IsdFGSVZhPjLksppW4+nxpGYEkfM0UKIefZKC2Qh96SiUDcsy?=
 =?us-ascii?Q?uTTQuPQQC+B6b0z0Bdd6Je3XAXsQWIIMkC27AXZkxxECtwfAzyP1g+cfMP8I?=
 =?us-ascii?Q?IgWlNftPnnI0H52O5cYhb3aqzrA9+/wjG7un9rA+mOCuHC4I6M5NeM4Zlcvo?=
 =?us-ascii?Q?Leg24j0cD14SP/LdN5VvPHA4+gt1zr80orlKrpy9zJDQSiyB+Jh7yu1904lT?=
 =?us-ascii?Q?4r8ToBe0AYMEDynYl7NNm/R2N64Zdx2fifB+KbdDvhxcfnZSH6sGk4mN1wUL?=
 =?us-ascii?Q?gRGpyMsB/E9cUzp7z/IUN3VLwysF5hZuUONGW2yRemAZN8WMOnnHakPyeI2Z?=
 =?us-ascii?Q?BlVkxrhSQoUfJAg0ZRBb/s67meERVi62wTpnC8AfknjlyZ1T6SP0QmlVYVCR?=
 =?us-ascii?Q?XDuk2EIrglv155oT84L1mm6W+if8WgrJRtmxjCA3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a97f478f-f362-4e1a-6272-08dc11a977cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 06:57:53.6449 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c/skTogfjjgqo98UJhdvQ7t1jTvuOd5iCTVWLYZNJYpetU45IutZMQK7kHaqYjHyuC8edILxifxpjtXczdJUKY1uQrBrtMYl/RxvU56miwo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8118
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
> From: Maniyam, Dinesh <dinesh.maniyam@intel.com>
> Sent: Thursday, December 7, 2023 3:46 PM
> To: u-boot@lists.denx.de
> Cc: Marek <marex@denx.de>; Simon <simon.k.r.goldschmidt@gmail.com>;
> Chee, Tien Fong <tien.fong.chee@intel.com>; Hea, Kok Kiang
> <kok.kiang.hea@intel.com>; Maniyam, Dinesh <dinesh.maniyam@intel.com>;
> Ng, Boon Khai <boon.khai.ng@intel.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@intel.com>; Chong, Teik Heng
> <teik.heng.chong@intel.com>; Zamri, Muhammad Hazim Izzat
> <muhammad.hazim.izzat.zamri@intel.com>; Lim, Jit Loon
> <jit.loon.lim@intel.com>; Tang, Sieu Mun <sieu.mun.tang@intel.com>
> Subject: [PATCH] arm: socfpga: stratix10: SPI clock support
>=20
> From: Dinesh Maniyam <dinesh.maniyam@intel.com>
>=20
> This patch is to add SPI clock support for stratix10. Get clock rate func=
tion
> always returning 0 because the DW-SPI driver get the rate from clock node=
 in
> dts but Stratix10 does not support device tree clock node.To overcome thi=
s spi
> will get the clock_rate directly from spi clock controller override the w=
eaker
> function.
>=20
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
> ---
>  arch/arm/mach-socfpga/clock_manager_s10.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-socfpga/clock_manager_s10.c b/arch/arm/mach-
> socfpga/clock_manager_s10.c
> index 4b4f0749db..45300336d5 100644
> --- a/arch/arm/mach-socfpga/clock_manager_s10.c
> +++ b/arch/arm/mach-socfpga/clock_manager_s10.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Copyright (C) 2016-2018 Intel Corporation <www.intel.com>
> + * Copyright (C) 2016-2023 Intel Corporation <www.intel.com>
>   *
>   */
>=20
> @@ -399,6 +399,21 @@ unsigned int cm_get_l4_sys_free_clk_hz(void)
>  	return cm_get_l3_main_clk_hz() / 4;
>  }
>=20
> +/*
> + * Override weak dw_spi_get_clk implementation in designware_spi.c
> +driver  */
> +
> +int dw_spi_get_clk(struct udevice *bus, ulong *rate) {
> +	*rate =3D cm_get_spi_controller_clk_hz();
> +	if (!*rate) {
> +		printf("SPI: clock rate is zero");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  void cm_print_clock_quick_summary(void)
>  {
>  	printf("MPU         %d kHz\n", (u32)(cm_get_mpu_clk_hz() / 1000));
> --
> 2.26.2

Reviewed-by: Tien Fong Chee <tien.fong.chee@intel.com>

Regards
Tien Fong

