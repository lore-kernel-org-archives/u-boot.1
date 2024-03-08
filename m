Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC86AC54E41
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 05:03:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03D9A87EB7;
	Fri,  8 Mar 2024 06:03:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="BJ1kZFvy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5282787E98; Fri,  8 Mar 2024 06:03:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEFB287ECA
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 06:03:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709874219; x=1741410219;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=dm5EmoJpyS+tHV6puN3BMdyfJU9EHOApD0Xu9Vi/g8I=;
 b=BJ1kZFvyREMFoihJ93bJ0Mg15eW7FdiFKEnYZFfxroscMjuly0zJssnn
 TMN3Ne/j8rauzulWoxcV0QvcfrHmtzCVG5tm/thpwR8eX7to6zsTXJ4cz
 jEggzdVPOKbxfbqrAN5nw0q9l1WM8B/Hac3RyGGRFEdYD597cbnV2NsPn
 DlkPxD6DRjTJvIdOFCvawq/7jEGe+eis/58m4TWDk1AWOIgwf347JU4V6
 99DwMTqC7u2VpRHuSu3NuYnTgV7X0mVoLo22DQS4fMe9sVfShD/sqSwgh
 A9AT14Xsq/shy94nbGcTOXL5j3Mg7xcDXHSW7zLnyt6Th2zUqBur6TQ9y Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="27055043"
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; d="scan'208";a="27055043"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2024 21:03:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; d="scan'208";a="41263787"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 Mar 2024 21:03:36 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 21:03:36 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Mar 2024 21:03:33 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 21:03:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XuJdgDx//+6tUPmVYOvfCqkDsW0QaswY+6EWmRQy0aF+/zp6/U1syNP75/63OqOhzS3M1nBUE5UtLPDhMvcD+iYclsIPo3Ae6hH80ds/oK1u6KvcYNpPREmA3kViC9/Y8Ts5+udK+vB0j5zIplmn7H01G7lsGWOdh18+xveZrq2JhRJa+HfznPjF9j0O8HUTGoPgKIJJfY4SQIIPi107lgeSyBa4+ihOz1nBMS1pV3/FE1ilUg6xjDdUEVThsQD8pOyMtQTT1WA1Uj78cjqPALd39/EHfYCZYaPsf2WP9RM2OV+BiXNNFXAauAf4fk1Z3CbJ2oW+7tGkFzUE+w48+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y6qvNvZJlfQHqqLzi14s5JjpBTFT3/AUAarAidw5PfU=;
 b=bgL01W5fOPBOA/UE9+BNJLTY6hJ4ZgGtIXrsgCyYexn3Nm5wveP8bcnBWzE4mqR0QMGmuBY5H+Dtj/zY/Ci7WCdxM9f9k3TnqThf2nXugFU0wsQbpOAHbF/mTgOX7Rk6BZTinpW+cHX0XaukUXRJa6FFdG3r7CrtY3/0f0ZxWhvvmBFPMsAk0CeXZgm+hPO84DYSiQvOG8u9E63I9Bb57gPe2RdQrY0mNj6gMxbIX70r9tLdhdJhigvoJ7JSt60pctX+Rzzqm0bOjGj5F+V2W2zEgE6ziRgpPX/OJSUFmFzUm+fmkzXbiaS3/jPvu918LUl4EfTerSjnpBm6mP6lsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 MW4PR11MB6738.namprd11.prod.outlook.com (2603:10b6:303:20c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.8; Fri, 8 Mar
 2024 05:03:30 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::d4e:e166:9da2:571]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::d4e:e166:9da2:571%4]) with mapi id 15.20.7386.006; Fri, 8 Mar 2024
 05:03:29 +0000
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
Subject: RE: [RESEND v2 1/1] arch: arm: Agilex5 enablement
Thread-Topic: [RESEND v2 1/1] arch: arm: Agilex5 enablement
Thread-Index: AQHab+VFUNV9+oc18EOnLp/yZCRVcrEtS1Gw
Date: Fri, 8 Mar 2024 05:03:29 +0000
Message-ID: <DM8PR11MB5592EEC20C8D3E46393F56C1D2272@DM8PR11MB5592.namprd11.prod.outlook.com>
References: <20240306164205.26939-1-jit.loon.lim@intel.com>
 <20240306164205.26939-2-jit.loon.lim@intel.com>
In-Reply-To: <20240306164205.26939-2-jit.loon.lim@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|MW4PR11MB6738:EE_
x-ms-office365-filtering-correlation-id: cc3811aa-a893-4ac8-6e99-08dc3f2d1893
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: um1AAh29owi4eevlGI5WiMX2EZOnJFuCjAVZPJL1V42d/KCjZnfn6/Cqrwsh0rd2KikDaXpg6UVZaT7PyDlUq4k/lbcU2zpWyuzyxzjTscSuqIYuuu60s1A2Ja5dQVrncinFdL34rWxQdj7dZ7e2x2C9Pj2ahFsm/2ZobE+I7/hNqxmvFcMEluSzD+mUJj9kVe6e6uJI8mcKL5fC7mVu4J09nslidwLQ4zsk+1zNr42p15vfaLcdk076RQMbIkkA3WU0VAilVM7PwbLwcYaLg0KZuyViVCRIijcpBGbV2eoXiCpUJ8XUHAuvt2LmjvkqLfGEoyXorQWyGvPen6I36Ia+xd3esrHZvq3PqtsbGf/ACMMdvPorsXEzall89URGNlt3phJ6DX2FcqkiBeLv9q+9oi7/3jWk6GbfJEs6kbBbUsNpmlHjHE0oezASzWiZjT2DlWShVFuUgvKgCvePcMA+CvYY0o8K9oaOPnva/MbA+izr7aa2c11Q9l8YyXMzlJvCBPBhcT2hriL7CMrc78IaPLUR1SMEZKvqgh5g5eWMwtHzlucD/pWsCauUWFA5HFTL7SQzA8HXh+M976v/fQV01MGNYFUSZharpQd4Qk3/grGUYH+8akJUW4keuGXGYOGZaRT2oEtKZ+EcE2n2nLkiNm+/qlFPQs1Ofx6YUOg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5592.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J/tbh5ePquhfTbRiETi4ob6fFTYDFxKlu5Vkq3zYxH/WrrFoDBryuzdLyj1P?=
 =?us-ascii?Q?12lMsO6QV+Gprq4E0G1pyath3fmt63yTRX3L1RNGwk5wv4IshKzANoehpVyH?=
 =?us-ascii?Q?P1JW0qoeELUpTEiO5PCYbJL1apVQDr0weDa3+VnFIhjDeKVCX9xHJ0k/0XL5?=
 =?us-ascii?Q?58C+XYNGnWyKONIXUkYfga8gx2ahLCDZew1w3nFsO/BAFZjomfb4r/6VY0wl?=
 =?us-ascii?Q?iRQEbBsLa0t7OTeCWIiKPUPKKgz2x6Yld4X7su3X44W1CHq4yTzjse3/w0tL?=
 =?us-ascii?Q?b44fkLi/KE7aJXON+nEwCwRvRnkajJzrmqX628FgTkrthZs33zv4KKG+UxcC?=
 =?us-ascii?Q?0PSEep50ts15u/npY9E0I37sZfFXRaxz/w0xnC2lXd1N8Liuh6NNLlqzKJzM?=
 =?us-ascii?Q?RE37pMU/T3HIxYZRfroxoZky+CyYE5hXZlFO/CBf43VYV9yUH8mL3bAceEeZ?=
 =?us-ascii?Q?sPRnAX1y2v7g8KbVz2eOYCkwfy5pUmzxMbMcCBhL2fK8nYNuAKjFZgLnwMHj?=
 =?us-ascii?Q?+dLuBY2V+cL4+wApYV3S6e+NCVZYKWwiWPaiuTBCQN15721t0Aq6V/nW8hk6?=
 =?us-ascii?Q?vkcU+NEEYdAwBGQoy8jaSMQiaZyv7JKq0uzMiVfgC7Gs2Jxp4jk/fJPk2JVh?=
 =?us-ascii?Q?bSGADJQsquOgiw3MVHbE6ZdDyNUMjiJzSI+tufYKrAvzUnMDoXCankVQpeT3?=
 =?us-ascii?Q?hyitd1TJuBcrdlot4ELxzTrdFd1Oe0atlGQ296kL8Rln+6OSoI2N7QdibwYL?=
 =?us-ascii?Q?VA/KAvMPxQ/4yB87NXh7nmBvm/gsVOf0CbLqEnsICabGFdfGYp1dNy6DFLAv?=
 =?us-ascii?Q?tC5Cmm8ZvjLvQ38C1iCp4tTU5F/n7LbYnBM59VYrmSTKXcF7hZGqXTCTcQUV?=
 =?us-ascii?Q?kmFPVC1JJt4xWKOtmN+EGRL9YDOJU4WtM/yR7BOfGKybNt+yTehIBdY67myQ?=
 =?us-ascii?Q?bS+hs3R79btwuGmJMoOMK1vTf1f58XXXoTwmSKXyk5rllR9suXqv7Js0eZHM?=
 =?us-ascii?Q?gzLUIZdx+OtenTi181FTsqC+REixoby17I/L4IrLgDaTDpc3XXoVR/zhdXsI?=
 =?us-ascii?Q?dC6G4XAOy3zKFu+gHG90nHdHDdlbPUor+KaLix1R4tQb/UKcCJq7qj86is2d?=
 =?us-ascii?Q?l3HflcqKWABW2ZcN/S4ExCLgFcwXnocdSaHB6E0cng48BIK2lAEPs7OED0Qz?=
 =?us-ascii?Q?NTJoyYTvmDQi3T/UKo4QrUvddOZtdLh/WX+2PYY3bV8sC4JhJdlga7xMOnmE?=
 =?us-ascii?Q?nfspWzKMItL+7QStDRouuVhv07Etp6Taxt3+dn0PXePmgzRyOWeGeVYWil2d?=
 =?us-ascii?Q?V0PVNPZXmiuS5ZkQtB1N5fS1RMFaNN+szOawpT1m1LgjqScJts3b3oxScvQ9?=
 =?us-ascii?Q?9IAMcsyDGHX4E4bFkP8vgd6YUztcqzL6usyIvl0H8eCE2PUNcCYaW+B/1gFf?=
 =?us-ascii?Q?+hoR8d+jx3dslCqrqXBhyNvIO6W3V/SwFIjNEM+YFITEw0+yH3SnxaMGBkaT?=
 =?us-ascii?Q?Li2n9YX0m4oTFiZuwhBypuI+0qLZ/jerYe69m4RlaEw+gaAo68KJ43jLVZzx?=
 =?us-ascii?Q?nhqxc3IjpUtzyE/WF4J6/STaMTa+LTcSAvw2L3Hm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3811aa-a893-4ac8-6e99-08dc3f2d1893
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 05:03:29.7961 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GJqnYIkUEcF9y2kbSEqnFSBrFz2phGZKdXTdfOgbsht0e47WvLOuBEFxp2quTMJ1/gS417g03/ctgqTVY758ebG+42N/J2rNQY6aXnRk12g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6738
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

Hi Jit loon,

> -----Original Message-----
> From: Lim, Jit Loon <jit.loon.lim@intel.com>
> Sent: Thursday, March 7, 2024 12:42 AM
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
> Subject: [RESEND v2 1/1] arch: arm: Agilex5 enablement
>=20
> This patch is to enable Agilex5 platform for Intel
> product. Changes, modification and new files are
> created for board, dts, configs and makefile to
> create the base for Agilex5.
>=20
> Signed-off-by: Jit Loon Lim <jit.loon.lim@intel.com>
>=20
> ---
> Changes v1 -> v2:
> - fixed git auto merge issue
> ---

[...]

> --- a/arch/arm/mach-socfpga/mmu-arm64_s10.c
> +++ b/arch/arm/mach-socfpga/mmu-arm64_s10.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Copyright (C) 2016-2018 Intel Corporation <www.intel.com>
> + * Copyright (C) 2016-2024 Intel Corporation <www.intel.com>
>   *
>   */
>=20
> @@ -10,6 +10,62 @@
>=20
>  DECLARE_GLOBAL_DATA_PTR;
>=20
> +#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
> +static struct mm_region socfpga_agilex5_mem_map[] =3D {
> +	{
> +		/* OCRAM 512KB */
> +		.virt	=3D 0x00000000UL,
> +		.phys	=3D 0x00000000UL,
> +		.size	=3D 0x00080000UL,
> +		.attrs	=3D PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +				PTE_BLOCK_NON_SHARE,
> +	}, {
> +		/* DEVICE */
> +		.virt	=3D 0x10808000UL,
> +		.phys	=3D 0x10808000UL,
> +		.size	=3D 0x0F7F8000UL,
> +		.attrs	=3D PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +				PTE_BLOCK_NON_SHARE |
> +				PTE_BLOCK_PXN | PTE_BLOCK_UXN,
> +	}, {
> +		/* FPGA 1.5GB */
> +		.virt	=3D 0x20000000UL,
> +		.phys	=3D 0x20000000UL,
> +		.size	=3D 0x60000000UL,
> +		.attrs	=3D PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +				PTE_BLOCK_NON_SHARE |
> +				PTE_BLOCK_PXN | PTE_BLOCK_UXN,
> +	}, {
> +		/* FPGA 15GB */
> +		.virt	=3D 0x440000000UL,
> +		.phys	=3D 0x440000000UL,
> +		.size	=3D 0x3C0000000UL,
> +		.attrs	=3D PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +				PTE_BLOCK_NON_SHARE |
> +				PTE_BLOCK_PXN | PTE_BLOCK_UXN,
> +	}, {
> +		/* FPGA 240GB */
> +		.virt	=3D 0x4400000000UL,
> +		.phys	=3D 0x4400000000UL,
> +		.size	=3D 0x3E80000000UL,

This size is not 240GB, please correct it.

[...]

Best regards,
Tien Fong
