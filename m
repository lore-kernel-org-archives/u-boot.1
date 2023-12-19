Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D96C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 07:08:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7283286EE0;
	Tue, 19 Dec 2023 08:08:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ZKXcZdlo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E941787142; Tue, 19 Dec 2023 08:08:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D0C386ECA
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 08:08:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1702969720; x=1734505720;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vZmakQexjGurkqBEJPsG2woQM8/v4sp+lD1a37rOb28=;
 b=ZKXcZdlon+PHwoVm2qVnlFKAr3xi4clsD9pa/f9bx0bkpgC230YIabyh
 zxXwNP1F6zQ0XsAGfGTX3g6XNkg/GUea7u0gMBOR6AZ4sbV+gP0DePHBJ
 sMIfaonpbukBIjfd3K4MKpv54kVlIyWrL5TkPvsfXKWikG/n6tqAOMeez
 6iUXneTrGC2WkZpxy5H01UhCv5Dfytgn1EMA5ii7TikoOmFNDr9GXpwzS
 uUhRj9lP0aMynalxqMws9jc8qbJwl6J6thccrxs3yTKEopzERLsed02Pp
 /jGIVfNwq2OCg1KAcMcuF7G4QiOctbE+hhGPwet5jGiWt/3Hsi+gkrkup Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="17176578"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; d="scan'208";a="17176578"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2023 23:08:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="866520503"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; d="scan'208";a="866520503"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Dec 2023 23:08:38 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 23:08:38 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 23:08:38 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Dec 2023 23:08:38 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Dec 2023 23:08:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oe1vSHv/prPo+q9HWIsbyxmqQBkdClswj4vQMeHtr32LX/qAhdlA0jifh/3fiyMO8O/ATdErgSsyhK5uGCq6uFhuvpEPvIUnN1LJPUtq2sgmUDa7HWIyVgafExVEcjTDgQGqlfGoyApCVJrqRsO5/fup5V4aOdnj+VOWvidGd5K57LtH74IsquDsnVTkfwnl4g60hg++aY3yUxaZ0e2FBLOdDMFNvQQi2tOG5azWrG6G/y7Wjoxb6LZdjMgNSwfyK2GpsTKFO7hxWLo9UBOjL8EwCszdJwSDBBtGXHkgrQDA+0iLXSMWfBBqy7wUrkwQaix0Kvq/eE/QjyLBt2ufIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8c9xCZnJWulVAd+J3npiFNeWLTEpBDDUSWbE5q4VskA=;
 b=kI4S8rOJoj4Qc4+AqpQEs1g4nmWrO+UWFc/eJYyWkXUurL44r186EUCeXz/YuMHgbr0kSURpYwPfL0TfA80PVC9x/1c1XaloyLakV4i4iL8q+z7X2p+RJny+DBvPM8AkRqukMgqiQf5dbElnP1mqPfDBOUrf/U0kj/tbFXY/0Os2Sykp7w0635KO3tt4N/GrsW7ZidD0kwX+Ohsa+08gZqiXtzHsVs4HHdqbXO5v2CKg7c3CNZ74u+7HN/J5Nd/D/opkvECkm3x5ZRR8D3voqYQ/enCVg/4TR3sHsuJ8eLr+5OD25grgUF7KctB/Od7zkGTu0P9neZNJesPzpnEgEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 CY8PR11MB7731.namprd11.prod.outlook.com (2603:10b6:930:75::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.38; Tue, 19 Dec 2023 07:08:30 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::9e26:3fcf:912c:4259]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::9e26:3fcf:912c:4259%6]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 07:08:30 +0000
From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
To: "Maniyam, Dinesh" <dinesh.maniyam@intel.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>, "Lukasz
 Majewski" <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, "Hea, Kok
 Kiang" <kok.kiang.hea@intel.com>, "Ng, Boon Khai" <boon.khai.ng@intel.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>, "Chong, Teik Heng"
 <teik.heng.chong@intel.com>, "Zamri, Muhammad Hazim Izzat"
 <muhammad.hazim.izzat.zamri@intel.com>, "Lim, Jit Loon"
 <jit.loon.lim@intel.com>, "Tang, Sieu Mun" <sieu.mun.tang@intel.com>
Subject: RE: [PATCH] clk: altera: n5x: Fix MEMCLKMGR_EXTCNTRST_C0CNTRST to
 bit(0)
Thread-Topic: [PATCH] clk: altera: n5x: Fix MEMCLKMGR_EXTCNTRST_C0CNTRST to
 bit(0)
Thread-Index: AQHaLyaBuzBohbZYzUSmpbV+5VO2RbCwNfxw
Date: Tue, 19 Dec 2023 07:08:30 +0000
Message-ID: <DM8PR11MB5592DAE3686450752CA11B7DD297A@DM8PR11MB5592.namprd11.prod.outlook.com>
References: <20231215071519.25270-1-dinesh.maniyam@intel.com>
In-Reply-To: <20231215071519.25270-1-dinesh.maniyam@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|CY8PR11MB7731:EE_
x-ms-office365-filtering-correlation-id: 08d759bf-934c-4459-7b43-08dc00614e36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9CA83nrIfzvs/USVsaHBYQnc0LV5G3oMMdDI+whdVJimdbc6ULnUbz/5Do7sHvXKkDiPDmzYYE0QDqn54P7j0GNHzhtMPZIboLseRRdl1Ns8WNtQfxSeXU2iD1rcb9olyYLpb0qKmcjKT6IwXWP8Hgrf2cXjWVgGMhQyLj5pZ7tHv9G48wz18sdBGKrhTdlQzrIfEPRPq/yGswUtNvHHnHfcLr+tVmxG1QeP1TrgaIwzevbKqxxpfq9+DyV3003Z9Zw8/xLCPQh1+710fJwyXm4hTzIroT8mXccTmsx2UBYhl1amkAu1lt3jjyC1zFG2iFpLZCWYu6hDXmwWTTAo/JZyP6gr598PnFuplQLolxbr0u5gZBli/X/AJ6z8jjvQcEKO4qRKIGGgOOMkKa7HtwRW2TOdL8aQ+Sm0euCaifRyoyxpAgOzwl5MsJCpa3GM2YvE5ct8VC+Wshu0Y/us1A/aXcb0LshDoAyfIPwHO9AxMwXHlXgy+iH8PXHai/ZR8hg8uKQefyOof390x3pfRCUdR9QYcHsSafOmohsxBuOtaz1KeZxhFcoMKpMKwxQ2ZiZh08O7XjbGAWgh8zWCz3/ZkxBriTScUbV7lusAhJI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5592.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(396003)(136003)(39860400002)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(83380400001)(107886003)(53546011)(9686003)(7696005)(6506007)(5660300002)(4326008)(52536014)(41300700001)(316002)(110136005)(2906002)(71200400001)(478600001)(8676002)(8936002)(54906003)(66446008)(76116006)(66556008)(66946007)(66476007)(64756008)(86362001)(33656002)(122000001)(38100700002)(82960400001)(38070700009)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j6AsTtyXfimyKZOa6yZGDA9EturUt6+ZJUEdGoxRvd22yecxUW1qxaeVEJ07?=
 =?us-ascii?Q?fukDuR0rk20bLFdrT75RNcLgr1hDtRbfa8dHHKPUGrwbv/jfirithZhe821n?=
 =?us-ascii?Q?Mbg4IX/DMJBCNQjI/1jriUqGvzV4LxudNh0hD0gulNeQ+mlf4txQNs4TvaOd?=
 =?us-ascii?Q?pYIEqu9mzpKw1pjchdmkAwhf77Fj1bNK9lkRBPMQBv6syScHiX1UxEy1LUFY?=
 =?us-ascii?Q?sX7ooQi45UkBWXN9aAtyDhGU071Bbt8z5FCjSVzFGHlAAAAFgbZNZwFfhR2i?=
 =?us-ascii?Q?1XtZDU4x/K1lq8NGKy0Vf0hs6paquJLxT4721X0o61ohKUwD29Qv/tsoJwcG?=
 =?us-ascii?Q?iRpVKE5snMKtCIeaC0IXmCtkG/YbTMmJ8jfNLxEnNLv7yB+CD+UtDgZNcyym?=
 =?us-ascii?Q?n8OKsfJWHKL+FEeFNmrQUI4sV6w6VO98b8M26xM5kJM2rLkzY7co1okv9hT+?=
 =?us-ascii?Q?+Vb0IiLtlonFslitFsfzgHZIeuQnEQhNz4s5c3fwOcQAKdxt1S23Ibm22Oxm?=
 =?us-ascii?Q?ktWtkIrC0qp2Qbfp8/1fIB+GFnN5uUGMNWiWurzfohFHDTynAYnPhQJjTIIR?=
 =?us-ascii?Q?Nhs9FKPSH3zeZn4N+BTNi5KhDO4rzIlsIeIGxvXMwj1+8ONIqsGGFmt3GZ1C?=
 =?us-ascii?Q?HV7DWYgPZa21H2ss4chfDyZBF99hhlkYKfhti0q+4oNeX7gQ3NBBhM2qYd48?=
 =?us-ascii?Q?7Rb12mY9/Ca3niXDKvtkwQaocJeauNhh7PrM7HRURCW7GyIVUwrOoGHlpK6u?=
 =?us-ascii?Q?tZ4/DruOITyZirSB86/cwtcudgZmxAEMyRHBwDB4hsq87XxzVqpxGsNoCNlO?=
 =?us-ascii?Q?WO+EAE8qxPo4iUzmcdGioOT21bSrwxe7m1tLoXCwDo1vnwbOVtFReChto8IJ?=
 =?us-ascii?Q?tbdU2+lY+tAYJ3IWYzLwrA9C7lyjpSuseY+YpU4WqCtq29nkRvadiC7svrpy?=
 =?us-ascii?Q?nHP5NC8Ty++apICJudjrYZTEpg0aVotDGnTwbiz22mHmQEad0nMKoaXMeF4i?=
 =?us-ascii?Q?JoqC9MGULxI+IpBFqV/Fm3D7NidQzhVSZSuVkI6VtAAR4QC33GHSaOdsnPjD?=
 =?us-ascii?Q?L4V2ms8aXmjsIewdjsCxJ073+nz064k5ZSCddvN21S9l8ET06W9gx/3OeYWv?=
 =?us-ascii?Q?dYJm3I8vgNQDIb8825rceMpRjtpClYW6MSTB/kxc7Lkg1cxTlkvNrVKtWoRN?=
 =?us-ascii?Q?NiPhoOmkXRJiVSWbVoiCmMukHo91C3iJVzwqWjckGESWAjjllI5NhaQzanK2?=
 =?us-ascii?Q?djmLHLZPl8RUxJYLhEjj9FC1LtTNoNP89qaem07tzNG7B2BT29jYcTUIlS63?=
 =?us-ascii?Q?oXHWkYUT/yxx2MkZBw8zUVLyx6WyTw/BRnwcqMTmKC7LTFYasuPcWhSzCL/x?=
 =?us-ascii?Q?9qAdxO+Nt/qczvNsVwWsllzMgzlBgzgJum2qruTRwJZbIwM/Y8AKk/Laf0Ed?=
 =?us-ascii?Q?0VUb9ZLD3onAg4ztv8eddf85zKVAkYpu1YALDAbnEoOfy3TJDNiUtEoONdGX?=
 =?us-ascii?Q?+QYMz00i38Ul5/FY27eDr2NdN0xBiwFG+cs4EMCmTVfaTbsAP9ueqAlmAzD5?=
 =?us-ascii?Q?W8mdzO9gq0Hvo+fin2+mfqpTw7EuABcTDyjbMWg1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d759bf-934c-4459-7b43-08dc00614e36
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2023 07:08:30.3455 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q9POZidYtBozdXDMg4NhfVcmlMFvxCwcuVogEO/PERz6VBDLNk5BjMgeM8C3NL7th+Jtj0SyZ9mR8I81GylgmJslmBYAw32BQH4e4YkrR/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7731
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
> Sent: Friday, December 15, 2023 3:15 PM
> To: u-boot@lists.denx.de
> Cc: Marek <marex@denx.de>; Simon <simon.k.r.goldschmidt@gmail.com>;
> Lukasz Majewski <lukma@denx.de>; Sean Anderson <seanga2@gmail.com>;
> Chee, Tien Fong <tien.fong.chee@intel.com>; Hea, Kok Kiang
> <kok.kiang.hea@intel.com>; Maniyam, Dinesh
> <dinesh.maniyam@intel.com>; Ng, Boon Khai <boon.khai.ng@intel.com>;
> Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@intel.com>; Chong, Teik Heng
> <teik.heng.chong@intel.com>; Zamri, Muhammad Hazim Izzat
> <muhammad.hazim.izzat.zamri@intel.com>; Lim, Jit Loon
> <jit.loon.lim@intel.com>; Tang, Sieu Mun <sieu.mun.tang@intel.com>
> Subject: [PATCH] clk: altera: n5x: Fix MEMCLKMGR_EXTCNTRST_C0CNTRST to
> bit(0)
>=20
> From: Dinesh Maniyam <dinesh.maniyam@intel.com>
>=20
> MEMCLKMGR_EXTCNTRST_C0CNTRST register defined as BIT[0] in
> documentation but it is wrongly defined as BIT[7] in u-boot code. This
> register is used to hold associated pingpong counter in reset while PLL a=
nd
> 5:1 mux configuration is changed.
>=20
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
> ---
>  drivers/clk/altera/clk-mem-n5x.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/clk/altera/clk-mem-n5x.h b/drivers/clk/altera/clk-me=
m-
> n5x.h
> index 7b687012e8..c6bc44bb34 100644
> --- a/drivers/clk/altera/clk-mem-n5x.h
> +++ b/drivers/clk/altera/clk-mem-n5x.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
>  /*
> - * Copyright (C) 2020-2022 Intel Corporation <www.intel.com>
> + * Copyright (C) 2020-2023 Intel Corporation <www.intel.com>
>   */
>=20
>  #ifndef	_CLK_MEM_N5X_
> @@ -77,7 +77,7 @@
>  #define MEMCLKMGR_PLLOUTDIV_C0CNT_MASK
> 	GENMASK(4, 0)
>  #define MEMCLKMGR_PLLOUTDIV_C0CNT_OFFSET		0
>=20
> -#define MEMCLKMGR_EXTCNTRST_C0CNTRST			BIT(7)
> +#define MEMCLKMGR_EXTCNTRST_C0CNTRST			BIT(0)
>  #define MEMCLKMGR_EXTCNTRST_ALLCNTRST			\
>  	(MEMCLKMGR_EXTCNTRST_C0CNTRST)
>=20
> --
> 2.26.2

Reviewed-by: Tien Fong Chee <tien.fong.chee@intel.com>

Regards
Tien Fong

