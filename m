Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B9FC5475B
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 04:21:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF92187E39;
	Fri,  8 Mar 2024 05:21:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="A8CXsnvl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 984AE87E92; Fri,  8 Mar 2024 05:20:59 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A365287947
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 05:20:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709871654; x=1741407654;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=8QNc/UrNYUtuHG9kRxE4qj9a4FCK+JuHysgAEgnvhpY=;
 b=A8CXsnvlaq/t976scT1euvkYwJOAijRnmnAviVhbRqLRKF73EmMXk4Mc
 YY/+QDVcnA5SsF8WuLctA5Njzg3Ny2vkDpZURuaFsFrFzwm6Obu2+jXlr
 ksLjs5/8fqFSjWRdMSmN2FQrt5kcpwbSx1EtmjUPkspiE3trciYFQqg/v
 afr4QYt2oJzmHhUlZxALW96b2WvSVr2T5Vu1RIMK5sWJRAvo+2EAnofHl
 pXlyyjEaYs5W1j2afff8cDe/LxQOlixOab96uPlAO7Ake0E66O+woGtAj
 h4c1JY3/l84YhiF/mCsMUEmvwc0xRh2L6W+JDa3ACrL/+2pRyKF6FW1Ey Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15988636"
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; d="scan'208";a="15988636"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2024 20:20:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; d="scan'208";a="10454773"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 Mar 2024 20:20:45 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 20:20:43 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Mar 2024 20:20:43 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 20:20:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpG8W3wA7xHK4ZsgHAae6q+f0UhyXFy1K7jMnNkVXTAAut4SugxXhiPXMVUu5zQm7hfDm1gG7s2XEQdgS7Raip+Dt4LtwfoCKStGZ3Ihi50dlKqalY1fpfOhXIMrPBZRnrmAHq9O0a5x9sItyzkpR4fBBIF9T+W4uVVf8/B53ZXrU5d6WFGihCLC0pvVIrWfvkAAqPInaSeZXFG1FedjmIZeMYC70brGJyhTSbK+DRdwUWr+m1Xu5oYf8Ska5bgM1sTvH+843oX6ynUoDJPiISrqXOLe3hlUErw7OmZGtSpy86HogbEDt1qpCQLfqyV9R6OuBlOF/4/6Y235rYERmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYKOc1mNTxXzDUK6xD+cWw49YWVG03PfxhEN1Trfh3I=;
 b=jw3ZP6uMZwtOA8Et2XYbqxfi0gxYTqyoOOhTMH2bwyrwlnEcSGILcDUrmvZmv3M+z5oXbl9Bc0s+SdsTLjL1qBCOU5vHkrjd1OfG6TQaJmr2M8rpYgV8lKN7w/xLGoERazOisMEtfi0MsHH/tdlRH+OfbLYLLNQe6sMbkSJPGAeImXGlaVqpc9KoYdoMT5QO0GxZAhg1U31CGHsrp2NKjJqv459qpGI7zocQryxgxtNz41/mAsloQSMZbfJeVC2Od8rRJJVSfC/DDzkLijrYKe57MZUKeA0P9MXt0Kcj35goGGkSQDTRm7H1Fax5Fgpo5aFhCWuUrxGuNuMa/64EwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 DM6PR11MB4513.namprd11.prod.outlook.com (2603:10b6:5:2a2::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.9; Fri, 8 Mar 2024 04:20:37 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::d4e:e166:9da2:571]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::d4e:e166:9da2:571%4]) with mapi id 15.20.7386.006; Fri, 8 Mar 2024
 04:20:37 +0000
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
Thread-Index: AQHab+VFUNV9+oc18EOnLp/yZCRVcrEtP1Cg
Date: Fri, 8 Mar 2024 04:20:37 +0000
Message-ID: <DM8PR11MB55928714B1FE2FE3322411D3D2272@DM8PR11MB5592.namprd11.prod.outlook.com>
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
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|DM6PR11MB4513:EE_
x-ms-office365-filtering-correlation-id: d50462dd-4294-4c03-3cc7-08dc3f271b71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PMLa2WjAjSLMkoQYwOBkGBiHoygsp9LKaCLAw2JUpDMvJpLM2V4EMhRBTXKhlRmyaNPeTDZx1G3aQy/B9Tzm4raTZu76pEhhR1Hz94W2tgEQnA9Akk4ea64cia2dFESW93oLBUwASt1HXBVyegCB21rZNMJ4bDxF+7Z5Kzll8AtgARUlLodZmhisEblS8xlaZ3JtS8oHNl8rbTZgmpqE1pt8vxc7bGTqi+sub3PjWZUiHcdZww6291jj7Bnn2jJYz+HJbR5y+etKt105plgNBZ0f7hFbvLi76YQ64e3VP+z6ZAvt52qtkCGsgcFJehcowRhLalgU1NLfdozfDoEPWKUqixatdvSlWoDAbKFFeQntTe9p6yvapWGLRufQ/4wMYcrH7MXxW4HZnTm2vgO3bPwqwQfwfEFZSycCnpobZLsiCA88urXnGxORHv7+Xns1+a0O+lB6V3uKPM2lrR1mY0GHvvFeoUsHnCcb+0+64iEJF18pWo/QIehRmfHxoHW5XNdzc65vQ1HS+Hzk8G9kHSsXYhvuABgBfdS/F5pWe+sL3QvrCS7FnVZNHebFOZqd9Fao6hZ7IsdfbXqaO4o1KakJXOsAlzzc2vDL2iZhb16PDeoghz6BTuFGtTAn9PmGe7+phxWvBK46B73k0N5PWu5otwnLFEwzK1DPzfweKSs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5592.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H6xsZ1vSorGu+87SMll0m+ANblJSv2UrP//1WO+19WZxLAq+2kgQfd+DXR6L?=
 =?us-ascii?Q?wC0yNfmHZWqM5uIaik1i+NI8bViBJOStNRoUq0tl8aXq7AsjqBVESO5Q5I/T?=
 =?us-ascii?Q?Cx3UloPTVVXOmyQ8LskFkSdLCskY+p/W6+tUJxhWdq+x8zxC5gpYRuA1TjgA?=
 =?us-ascii?Q?H7cD2ync9dzNlDYR0igzWtxuh8aGIsmV7X7cEQIAOZ1a8B8jNvfXNhuPhB5r?=
 =?us-ascii?Q?ytbNfDAIXDseFXYE9l9eznFU/vJXg2yoI+rjRE0I1tT7ExEFFCOfiKi91+LM?=
 =?us-ascii?Q?49f0ekT1IkEXn2KZfwSFhv8PJHzmP7WfX3y6BRSeko9vLHD4FHg+XD/Cn2QL?=
 =?us-ascii?Q?BQ9FUpqIu6XDAeB5sHtZgi1+TKQyPoDGPwVu/6/1qSG1Y/9gEZydnLwPvCmu?=
 =?us-ascii?Q?lib8ItN5kPloPzvHHDL7ogRC7E4Aom76gLNONE6ihWmeYSmtVvCazTEg7l5u?=
 =?us-ascii?Q?RnRAxDJTbRulAnYHwT4rkajsSGzNmjxdaUCHNHVyjy9Yiv4fhC4k5hgPBEzg?=
 =?us-ascii?Q?Otor7FLY73YxQKQmvrGrlmLoaW/Op0wXnpUmupdEOzMUOuvWwRA3wB2qAoWC?=
 =?us-ascii?Q?D+9WgMogfHna3AsjekCOfqvNO9ouPlswJ9W9j9wt7rLfaIjFm+qbcJSg70Ax?=
 =?us-ascii?Q?I25FD7oHLfFzWjQRQCw2DM9BhqrzmqzZdjSk9LjemeMd/SyMJB4caYOzpvle?=
 =?us-ascii?Q?pwrlyUL7gW4sdyZrpbdhuCvr7NqFg4BUcci+hHY6DnJaM5iyYmebfMD6XtY2?=
 =?us-ascii?Q?IbHuyxKcg698EvvtY8x8OqcumF4hatWTRW/B60KJojErxrnksJ0W5yrG+gOY?=
 =?us-ascii?Q?kBVcGFgV1aHNerBDRc6WbGoWeqgqMDhU7chvZmGcRMoTgONxcA1PvNV2uF8i?=
 =?us-ascii?Q?FiERdYdirYc36tfHoJPSoh0cNXkFrtXr7rdwHH1KENhtYAsIy/Wpm8oCK5sz?=
 =?us-ascii?Q?2p0CoC2lFJnzBI5NLa9UjoyowebX0O2+0wnkK5KzyoY1cXWR5AqtfTWljAkv?=
 =?us-ascii?Q?bAzG/fwlT4+nHaszucaJREGw3tc1Vy+oFv7XXw2mbxfI90rU65XHmUe8B3/Q?=
 =?us-ascii?Q?lQQLoI//ov63fqq3lGOe0YWCBL36zJjTEPQoCmfEh1mu2cf2tkmPvGidGKrO?=
 =?us-ascii?Q?TUGJS7ik1qBLCFf6HDUpluURPi0vdOv7OmA3xa1OsjxTB+ZtVDboTyEsUhNj?=
 =?us-ascii?Q?SPmU2lEocNYfp957LoUWwv//CTlxrudmBQtOxhuHCdeNySyJOX+PxF+NYTNm?=
 =?us-ascii?Q?eR8C2ggmEHhxVy7tHgY9ecqeoPX+i6l4QUVNGvULubSKN7En66t4vwajhj6k?=
 =?us-ascii?Q?wMlhm81dTMv91iJDhFrNxG0tJ9nRHIm311vdnKEGT6EzeWiFiRffWiKiAplK?=
 =?us-ascii?Q?36DP7CK/hffcy4eO5AozJEu5RAjzBoZghgUBgYLb+3nW3+y0SRBRMgPrFsAe?=
 =?us-ascii?Q?SGCKsWH2WA3gQOEXD/uAC8vWr/VmhYwbSpe5Vz62IHHFojx3sPXJ/b0biBMg?=
 =?us-ascii?Q?MxAoDxLerLhEGzSplKSsZFhO6A2P6URYRi7xdJV2ebElcFlEOrpmx4nKFm73?=
 =?us-ascii?Q?6mwbkl+bR+swZ5TLl9XanzVjXLWcSqVGbAPKRd//?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d50462dd-4294-4c03-3cc7-08dc3f271b71
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 04:20:37.6430 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B4DIHYxeEIERroMnNIUkKGNTF32igc2UEhoHHs0Obgb0q61wmZzWMv2WlnYAFnP2SMIzlal+C4KdiZqiOy96UHjG3JIC8SeBptk5IQemxiA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4513
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
>  arch/arm/Kconfig                              |   4 +-
>  arch/arm/dts/Makefile                         |   1 +
>  arch/arm/dts/socfpga_agilex5-u-boot.dtsi      |  71 ++
>  arch/arm/dts/socfpga_agilex5.dtsi             | 575 ++++++++++++++
>  .../arm/dts/socfpga_agilex5_socdk-u-boot.dtsi | 134 ++++
>  arch/arm/dts/socfpga_agilex5_socdk.dts        | 163 ++++
>  arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi    |  38 +-
>  arch/arm/mach-socfpga/Kconfig                 |  19 +-
>  arch/arm/mach-socfpga/Makefile                |  14 +-
>  arch/arm/mach-socfpga/board.c                 |  56 +-
>  arch/arm/mach-socfpga/clock_manager_agilex5.c |  89 +++
>  .../include/mach/base_addr_soc64.h            |  38 +-
>  .../mach-socfpga/include/mach/clock_manager.h |   4 +-
>  .../include/mach/clock_manager_agilex5.h      |  12 +
>  .../mach-socfpga/include/mach/handoff_soc64.h |  31 +-
>  .../mach-socfpga/include/mach/mailbox_s10.h   |   1 +
>  arch/arm/mach-socfpga/mmu-arm64_s10.c         |  59 +-
>  board/intel/agilex5-socdk/MAINTAINERS         |   8 +
>  configs/socfpga_agilex5_defconfig             | 116 +++
>  drivers/clk/altera/Makefile                   |   1 +
>  drivers/clk/altera/clk-agilex5.c              | 743 ++++++++++++++++++
>  drivers/clk/altera/clk-agilex5.h              | 284 +++++++
>  include/configs/socfpga_agilex5_socdk.h       |  12 +
>  include/configs/socfpga_soc64_common.h        | 143 +++-
>  include/dt-bindings/clock/agilex5-clock.h     |  71 ++
>  include/dt-bindings/reset/altr,rst-mgr-agx5.h |  80 ++
>  26 files changed, 2731 insertions(+), 36 deletions(-)
>  create mode 100644 arch/arm/dts/socfpga_agilex5-u-boot.dtsi
>  create mode 100644 arch/arm/dts/socfpga_agilex5.dtsi
>  create mode 100644 arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
>  create mode 100644 arch/arm/dts/socfpga_agilex5_socdk.dts
>  create mode 100644 arch/arm/mach-socfpga/clock_manager_agilex5.c
>  create mode 100644 arch/arm/mach-
> socfpga/include/mach/clock_manager_agilex5.h
>  create mode 100644 board/intel/agilex5-socdk/MAINTAINERS
>  create mode 100644 configs/socfpga_agilex5_defconfig
>  create mode 100644 drivers/clk/altera/clk-agilex5.c
>  create mode 100644 drivers/clk/altera/clk-agilex5.h
>  create mode 100644 include/configs/socfpga_agilex5_socdk.h
>  create mode 100644 include/dt-bindings/clock/agilex5-clock.h
>  create mode 100644 include/dt-bindings/reset/altr,rst-mgr-agx5.h
>=20
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index fde85dc0d5..6df805f44c 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -28,6 +28,7 @@ config COUNTER_FREQUENCY
>  			ROCKCHIP_RK3288 || ROCKCHIP_RK322X ||
> ROCKCHIP_RK3036
>  	default 25000000 if ARCH_LX2160A || ARCH_LX2162A ||
> ARCH_LS1088A
>  	default 100000000 if ARCH_ZYNQMP
> +	default 200000000 if ARCH_SOCFPGA && ARM64 &&
> TARGET_SOCFPGA_AGILEX5
>  	default 0
>  	help
>  	  For platforms with ARMv8-A and ARMv7-A which features a system
> @@ -1124,7 +1125,8 @@ config ARCH_SOCFPGA
>  	select SYS_THUMB_BUILD if TARGET_SOCFPGA_GEN5 ||
> TARGET_SOCFPGA_ARRIA10
>  	select SYSRESET
>  	select SYSRESET_SOCFPGA if TARGET_SOCFPGA_GEN5 ||
> TARGET_SOCFPGA_ARRIA10
> -	select SYSRESET_SOCFPGA_SOC64 if TARGET_SOCFPGA_SOC64
> +	select SYSRESET_SOCFPGA_SOC64 if !TARGET_SOCFPGA_AGILEX5 &&
> \
> +	  TARGET_SOCFPGA_SOC64
>  	imply CMD_DM
>  	imply CMD_MTDPARTS
>  	imply CRC32_VERIFY
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index d9725030d5..2b4f896ad2 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -548,6 +548,7 @@ dtb-$(CONFIG_TARGET_THUNDERX_88XX) +=3D
> thunderx-88xx.dtb
>=20
>  dtb-$(CONFIG_ARCH_SOCFPGA) +=3D				\
>  	socfpga_agilex_socdk.dtb			\
> +	socfpga_agilex5_socdk.dtb			\
>  	socfpga_arria5_secu1.dtb			\
>  	socfpga_arria5_socdk.dtb			\
>  	socfpga_arria10_chameleonv3_270_2.dtb		\
> diff --git a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
> b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
> new file mode 100644
> index 0000000000..a8167e5c14
> --- /dev/null
> +++ b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
> @@ -0,0 +1,71 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * U-Boot additions
> + *
> + * Copyright (C) 2024 Intel Corporation <www.intel.com>
> + */
> +
> +#include "socfpga_soc64_fit-u-boot.dtsi"
> +
> +/{
> +	memory {
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;
> +		bootph-all;
> +	};
> +};
> +
> +&clkmgr {
> +	bootph-all;
> +};
> +
> +&i2c0 {
> +	reset-names =3D "i2c";
> +};
> +
> +&i2c1 {
> +	reset-names =3D "i2c";
> +};
> +
> +&i2c2 {
> +	reset-names =3D "i2c";
> +};
> +
> +&i2c3 {
> +	reset-names =3D "i2c";
> +};
> +
> +&mmc {
> +	resets =3D <&rst SDMMC_RESET>, <&rst SDMMC_OCP_RESET>;
> +};
> +
> +&porta {
> +	bank-name =3D "porta";
> +};
> +
> +&portb {
> +	bank-name =3D "portb";
> +};
> +
> +&qspi {
> +	bootph-all;
> +};
> +
> +&rst {
> +	compatible =3D "altr,rst-mgr";
> +	altr,modrst-offset =3D <0x24>;
> +	bootph-all;
> +};
> +
> +&sysmgr {
> +	compatible =3D "altr,sys-mgr", "syscon";
> +	bootph-all;
> +};
> +
> +&uart0 {
> +	bootph-all;
> +};
> +
> +&watchdog0 {
> +	bootph-all;
> +};
> diff --git a/arch/arm/dts/socfpga_agilex5.dtsi
> b/arch/arm/dts/socfpga_agilex5.dtsi
> new file mode 100644
> index 0000000000..03b5504049
> --- /dev/null
> +++ b/arch/arm/dts/socfpga_agilex5.dtsi
> @@ -0,0 +1,575 @@
> +// SPDX-License-Identifier:     GPL-2.0
> +/*
> + * Copyright (C) 2024 Intel Corporation <www.intel.com>
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/reset/altr,rst-mgr-agx5.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/clock/agilex5-clock.h>
> +
> +/ {
> +	compatible =3D "intel,socfpga-agilex";
> +	#address-cells =3D <2>;
> +	#size-cells =3D <2>;
> +
> +	reserved-memory {
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;
> +		ranges;
> +
> +		service_reserved: svcbuffer@0 {
> +			compatible =3D "shared-dma-pool";
> +			reg =3D <0x0 0x0 0x0 0x1000000>;
> +			alignment =3D <0x1000>;
> +			no-map;
> +		};
> +	};
> +
> +	cpus {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		cpu0: cpu@0 {
> +			compatible =3D "arm,cortex-a55";
> +			device_type =3D "cpu";
> +			enable-method =3D "psci";
> +			reg =3D <0x0>;
> +		};
> +
> +		cpu1: cpu@1 {
> +			compatible =3D "arm,cortex-a55";
> +			device_type =3D "cpu";
> +			enable-method =3D "psci";
> +			reg =3D <0x1>;
> +		};
> +
> +		cpu2: cpu@2 {
> +			compatible =3D "arm,cortex-a76";
> +			device_type =3D "cpu";
> +			enable-method =3D "psci";
> +			reg =3D <0x2>;
> +		};
> +
> +		cpu3: cpu@3 {
> +			compatible =3D "arm,cortex-a76";
> +			device_type =3D "cpu";
> +			enable-method =3D "psci";
> +			reg =3D <0x3>;
> +		};
> +	};
> +
> +	pmu {
> +		compatible =3D "arm,armv8-pmuv3";
> +		interrupts =3D <0 170 4>,
> +			     <0 171 4>,
> +			     <0 172 4>,
> +			     <0 173 4>;
> +		interrupt-affinity =3D <&cpu0>,
> +				     <&cpu1>,
> +				     <&cpu2>,
> +				     <&cpu3>;
> +		interrupt-parent =3D <&intc>;
> +	};
> +
> +	psci {
> +		compatible =3D "arm,psci-0.2";
> +		method =3D "smc";
> +	};
> +
> +	intc: intc@fffc1000 {
> +		compatible =3D "arm,gic-400", "arm,cortex-a15-gic";
> +		#interrupt-cells =3D <3>;
> +		interrupt-controller;
> +		reg =3D <0x0 0x1d000000 0x0 0x10000>;
> +	};
> +
> +	soc {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		compatible =3D "simple-bus";
> +		device_type =3D "soc";
> +		interrupt-parent =3D <&intc>;
> +		ranges =3D <0 0 0 0xffffffff>;
> +
> +		base_fpga_region {
> +			#address-cells =3D <0x1>;
> +			#size-cells =3D <0x1>;
> +			compatible =3D "fpga-region";
> +			fpga-mgr =3D <&fpga_mgr>;
> +		};
> +
> +		clkmgr: clock-controller@10d10000 {
> +			compatible =3D "intel,agilex5-clkmgr";
> +			reg =3D <0x10d10000 0x1000>;
> +			#clock-cells =3D <1>;
> +		};
> +
> +		clocks {
> +			cb_intosc_hs_div2_clk: cb-intosc-hs-div2-clk {
> +				#clock-cells =3D <0>;
> +				compatible =3D "fixed-clock";
> +			};
> +
> +			cb_intosc_ls_clk: cb-intosc-ls-clk {
> +				#clock-cells =3D <0>;
> +				compatible =3D "fixed-clock";
> +			};
> +
> +			f2s_free_clk: f2s-free-clk {
> +				#clock-cells =3D <0>;
> +				compatible =3D "fixed-clock";
> +			};
> +
> +			osc1: osc1 {
> +				#clock-cells =3D <0>;
> +				compatible =3D "fixed-clock";
> +			};
> +
> +			qspi_clk: qspi-clk {
> +				#clock-cells =3D <0>;
> +				compatible =3D "fixed-clock";
> +				clock-frequency =3D <200000000>;
> +			};
> +		};
> +		gmac0: ethernet@10810000 {
> +			compatible =3D "intel,socfpga-dwxgmac",
> "snps,dwxgmac-2.10", "snps,dwxgmac";
> +			reg =3D <0x10810000 0x3500>;
> +			interrupts =3D <0 190 4>;
> +			interrupt-names =3D "macirq";
> +			mac-address =3D [00 00 00 00 00 00];
> +			resets =3D <&rst EMAC0_RESET>, <&rst
> EMAC0_OCP_RESET>;
> +			reset-names =3D "stmmaceth", "stmmaceth-ocp";
> +			tx-fifo-depth =3D <32768>;
> +			rx-fifo-depth =3D <16384>;
> +			iommus =3D <&smmu 1>;
> +			altr,sysmgr-syscon =3D <&sysmgr 0x44 0>;
> +			clocks =3D <&clkmgr AGILEX5_EMAC0_CLK>;
> +			clock-names =3D "stmmaceth";
> +			status =3D "disabled";
> +		};
> +
> +		gmac1: ethernet@10820000 {
> +			compatible =3D "intel,socfpga-dwxgmac",
> "snps,dwxgmac-2.10", "snps,dwxgmac";
> +			reg =3D <0x10820000 0x3500>;
> +			interrupts =3D <0 207 4>;
> +			interrupt-names =3D "macirq";
> +			mac-address =3D [00 00 00 00 00 00];
> +			resets =3D <&rst EMAC1_RESET>, <&rst
> EMAC1_OCP_RESET>;
> +			reset-names =3D "stmmaceth", "stmmaceth-ocp";
> +			tx-fifo-depth =3D <32768>;
> +			rx-fifo-depth =3D <16384>;
> +			iommus =3D <&smmu 2>;
> +			altr,sysmgr-syscon =3D <&sysmgr 0x48 0>;
> +			clocks =3D <&clkmgr AGILEX5_EMAC1_CLK>;
> +			clock-names =3D "stmmaceth";
> +			status =3D "disabled";
> +		};
> +
> +		gmac2: ethernet@10830000 {
> +			compatible =3D "intel,socfpga-dwxgmac",
> "snps,dwxgmac-2.10", "snps,dwxgmac";
> +			reg =3D <0x10830000 0x3500>;
> +			interrupts =3D <0 224 4>;
> +			interrupt-names =3D "macirq";
> +			mac-address =3D [00 00 00 00 00 00];
> +			resets =3D <&rst EMAC2_RESET>, <&rst
> EMAC2_OCP_RESET>;
> +			reset-names =3D "stmmaceth", "stmmaceth-ocp";
> +			tx-fifo-depth =3D <32768>;
> +			rx-fifo-depth =3D <16384>;
> +			iommus =3D <&smmu 3>;
> +			altr,sysmgr-syscon =3D <&sysmgr 0x4c 0>;
> +			clocks =3D <&clkmgr AGILEX5_EMAC2_CLK>;
> +			clock-names =3D "stmmaceth";
> +			status =3D "disabled";
> +		};
> +
> +		gpio0: gpio@10c03200 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			compatible =3D "snps,dw-apb-gpio";
> +			reg =3D <0x10c03200 0x80>;
> +			resets =3D <&rst GPIO0_RESET>;
> +			status =3D "disabled";
> +
> +			porta: gpio-controller@0 {
> +				compatible =3D "snps,dw-apb-gpio-port";
> +				gpio-controller;
> +				#gpio-cells =3D <2>;
> +				snps,nr-gpios =3D <24>;
> +				reg =3D <0>;
> +				interrupt-controller;
> +				#interrupt-cells =3D <2>;
> +				interrupts =3D <0 110 4>;
> +			};
> +		};
> +
> +		gpio1: gpio@10c03300 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			compatible =3D "snps,dw-apb-gpio";
> +			reg =3D <0x10c03300 0x80>;
> +			resets =3D <&rst GPIO1_RESET>;
> +			status =3D "disabled";
> +
> +			portb: gpio-controller@0 {
> +				compatible =3D "snps,dw-apb-gpio-port";
> +				gpio-controller;
> +				#gpio-cells =3D <2>;
> +				snps,nr-gpios =3D <24>;
> +				reg =3D <0>;
> +				interrupt-controller;
> +				#interrupt-cells =3D <2>;
> +				interrupts =3D <0 111 4>;
> +			};
> +		};
> +
> +		i2c0: i2c@10c02800 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			compatible =3D "snps,designware-i2c";
> +			reg =3D <0x10c02800 0x100>;
> +			interrupts =3D <0 103 4>;
> +			resets =3D <&rst I2C0_RESET>;
> +			clocks =3D <&clkmgr AGILEX5_L4_SP_CLK>;
> +			status =3D "disabled";
> +		};
> +
> +		i2c1: i2c@10c02900 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			compatible =3D "snps,designware-i2c";
> +			reg =3D <0x10c02900 0x100>;
> +			interrupts =3D <0 104 4>;
> +			resets =3D <&rst I2C1_RESET>;
> +			clocks =3D <&clkmgr AGILEX5_L4_SP_CLK>;
> +			status =3D "disabled";
> +		};
> +
> +		i2c2: i2c@10c02a00 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			compatible =3D "snps,designware-i2c";
> +			reg =3D <0x10c02a00 0x100>;
> +			interrupts =3D <0 105 4>;
> +			resets =3D <&rst I2C2_RESET>;
> +			clocks =3D <&clkmgr AGILEX5_L4_SP_CLK>;
> +			status =3D "disabled";
> +		};
> +
> +		i2c3: i2c@10c02b00 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			compatible =3D "snps,designware-i2c";
> +			reg =3D <0x10c02b00 0x100>;
> +			interrupts =3D <0 106 4>;
> +			resets =3D <&rst I2C3_RESET>;
> +			clocks =3D <&clkmgr AGILEX5_L4_SP_CLK>;
> +			status =3D "disabled";
> +		};
> +
> +		i2c4: i2c@10c02c00 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			compatible =3D "snps,designware-i2c";
> +			reg =3D <0x10c02c00 0x100>;
> +			interrupts =3D <0 107 4>;
> +			resets =3D <&rst I2C4_RESET>;
> +			clocks =3D <&clkmgr AGILEX5_L4_SP_CLK>;
> +			status =3D "disabled";
> +		};
> +
> +		i3c0: i3c@10da0000 {
> +			compatible =3D "snps,dw-i3c-master-1.00a";
> +			reg =3D <0x10da0000 0x1000>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			interrupts =3D <0 164 4>;
> +			resets =3D <&rst I3C0_RESET>;
> +			max_devices =3D <11>;
> +			clocks =3D <&clkmgr AGILEX5_L4_MP_CLK>;
> +			status =3D "disabled";
> +		};
> +
> +		i3c1: i3c@10da1000 {
> +			compatible =3D "snps,dw-i3c-master-1.00a";
> +			reg =3D <0x10da1000 0x1000>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			interrupts =3D <0 165 4>;
> +			resets =3D <&rst I3C1_RESET>;
> +			clocks =3D <&clkmgr AGILEX5_L4_MP_CLK>;
> +			max_devices =3D <11>;
> +			status =3D "disabled";
> +		};
> +
> +		combophy0: combophy@0 {
> +			#phy-cells =3D <0>;
> +			phy-type =3D <1>;
> +			compatible =3D "cdns,combophy";
> +			reg =3D <0x10808000 0x1000>;
> +			resets =3D <&rst COMBOPHY_RESET>;
> +			reset-names =3D "reset";
> +			status =3D "disabled";
> +		};
> +
> +		mmc: mmc0@10808000 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			compatible =3D "cdns,sd4hc";
> +			reg =3D <0x10808000 0x1000>;
> +			interrupts =3D <0 96 4>;
> +			phys =3D <&combophy0>;
> +			phy-names =3D "combo-phy";
> +			clocks =3D <&clkmgr AGILEX5_L4_MP_CLK>,
> +				 <&clkmgr AGILEX5_SDMMC_CLK>;
> +			clock-names =3D "biu", "ciu";
> +			fifo-depth =3D <0x800>;
> +			resets =3D <&rst SDMMC_RESET>;
> +			reset-names =3D "reset";
> +			iommus =3D <&smmu 5>;
> +			status =3D "disabled";
> +		};
> +
> +		ocram: sram@00000000 {
> +			compatible =3D "mmio-sram";
> +			reg =3D <0x00000000 0x200000>;
> +		};
> +
> +		rst: rstmgr@10d11000 {
> +			#reset-cells =3D <1>;
> +			compatible =3D "altr,stratix10-rst-mgr";
> +			reg =3D <0x10d11000 0x1000>;
> +		};
> +
> +		smmu: iommu@16000000 {
> +			compatible =3D "arm,mmu-500", "arm,smmu-v2";
> +			reg =3D <0x16000000 0x40000>;
> +			#global-interrupts =3D <2>;
> +			#iommu-cells =3D <1>;
> +			interrupt-parent =3D <&intc>;
> +			interrupts =3D <0 128 4>,	/* Global Secure Fault */
> +				<0 129 4>, /* Global Non-secure Fault */
> +				/* Non-secure Context Interrupts (32) */
> +				<0 138 4>, <0 139 4>, <0 140 4>, <0 141 4>,
> +				<0 142 4>, <0 143 4>, <0 144 4>, <0 145 4>,
> +				<0 146 4>, <0 147 4>, <0 148 4>, <0 149 4>,
> +				<0 150 4>, <0 151 4>, <0 152 4>, <0 153 4>,
> +				<0 154 4>, <0 155 4>, <0 156 4>, <0 157 4>,
> +				<0 158 4>, <0 159 4>, <0 160 4>, <0 161 4>,
> +				<0 162 4>, <0 163 4>, <0 164 4>, <0 165 4>,
> +				<0 166 4>, <0 167 4>, <0 168 4>, <0 169 4>;
> +			stream-match-mask =3D <0x7ff0>;
> +			status =3D "disabled";
> +		};
> +
> +		spi0: spi@10da4000 {
> +			compatible =3D "intel,agilex-spi",
> +				     "snps,dw-apb-ssi-4.00a", "snps,dw-apb-ssi";
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <0x10da4000 0x1000>;
> +			interrupts =3D <0 99 4>;
> +			resets =3D <&rst SPIM0_RESET>;
> +			reg-io-width =3D <4>;
> +			num-cs =3D <4>;
> +			clocks =3D <&clkmgr AGILEX5_L4_MAIN_CLK>;
> +			status =3D "disabled";
> +		};
> +
> +		spi1: spi@10da5000 {
> +			compatible =3D "intel,agilex-spi",
> +				     "snps,dw-apb-ssi-4.00a", "snps,dw-apb-ssi";
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <0x10da5000 0x1000>;
> +			interrupts =3D <0 100 4>;
> +			resets =3D <&rst SPIM1_RESET>;
> +			reg-io-width =3D <4>;
> +			num-cs =3D <4>;
> +			clocks =3D <&clkmgr AGILEX5_L4_MAIN_CLK>;
> +			status =3D "disabled";
> +		};
> +
> +		sysmgr: sysmgr@10d12000 {
> +			compatible =3D "altr,sys-mgr-s10","altr,sys-mgr";
> +			reg =3D <0x10d12000 0x500>;
> +		};
> +
> +		/* Local timer */
> +		timer {
> +			compatible =3D "arm,armv8-timer";
> +			interrupts =3D <1 13 0xf08>,
> +				     <1 14 0xf08>,
> +				     <1 11 0xf08>,
> +				     <1 10 0xf08>;
> +		};
> +
> +		timer0: timer0@10c03000 {
> +			compatible =3D "snps,dw-apb-timer";
> +			interrupts =3D <0 113 4>;
> +			reg =3D <0x10c03000 0x100>;
> +			resets =3D <&rst SPTIMER0_RESET>;
> +			clocks =3D <&clkmgr AGILEX5_L4_SP_CLK>;
> +			clock-names =3D "timer";
> +			status =3D "disabled";
> +		};
> +
> +		timer1: timer1@10c03100 {
> +			compatible =3D "snps,dw-apb-timer";
> +			interrupts =3D <0 114 4>;
> +			reg =3D <0x10c03100 0x100>;
> +			resets =3D <&rst SPTIMER1_RESET>;
> +			clocks =3D <&clkmgr AGILEX5_L4_SP_CLK>;
> +			clock-names =3D "timer";
> +			status =3D "disabled";
> +		};
> +
> +		timer2: timer2@10d00000 {
> +			compatible =3D "snps,dw-apb-timer";
> +			interrupts =3D <0 115 4>;
> +			reg =3D <0x10d00000 0x100>;
> +			resets =3D <&rst L4SYSTIMER0_RESET>;
> +			clocks =3D <&clkmgr AGILEX5_L4_SYS_FREE_CLK>;
> +			clock-names =3D "timer";
> +			status =3D "disabled";
> +		};
> +
> +		timer3: timer3@10d00100 {
> +			compatible =3D "snps,dw-apb-timer";
> +			interrupts =3D <0 116 4>;
> +			reg =3D <0x10d00100 0x100>;
> +			resets =3D <&rst L4SYSTIMER1_RESET>;
> +			clocks =3D <&clkmgr AGILEX5_L4_SYS_FREE_CLK>;
> +			clock-names =3D "timer";
> +			status =3D "disabled";
> +		};
> +
> +		uart0: serial0@10c02000 {
> +			compatible =3D "snps,dw-apb-uart";
> +			reg =3D <0x10c02000 0x100>;
> +			interrupts =3D <0 108 4>;
> +			reg-shift =3D <2>;
> +			reg-io-width =3D <4>;
> +			resets =3D <&rst UART0_RESET>;
> +			status =3D "disabled";
> +			clocks =3D <&clkmgr AGILEX5_L4_SP_CLK>;
> +			clock-frequency =3D <100000000>;
> +		};
> +
> +		uart1: serial1@10c02100 {
> +			compatible =3D "snps,dw-apb-uart";
> +			reg =3D <0x10c02100 0x100>;
> +			interrupts =3D <0 109 4>;
> +			reg-shift =3D <2>;
> +			reg-io-width =3D <4>;
> +			resets =3D <&rst UART1_RESET>;
> +			clocks =3D <&clkmgr AGILEX5_L4_SP_CLK>;
> +			status =3D "disabled";
> +		};
> +
> +		usbphy0: usbphy@0 {
> +			#phy-cells =3D <0>;
> +			compatible =3D "usb-nop-xceiv";
> +			clocks =3D <&clkmgr AGILEX5_USB_CLK>;
> +			status =3D "disabled";
> +		};
> +
> +		usb0: usb@10b00000 {
> +			compatible =3D "snps,dwc2";
> +			reg =3D <0x10b00000 0x40000>;
> +			interrupts =3D <0 93 4>;
> +			phys =3D <&usbphy0>;
> +			phy-names =3D "usb2-phy";
> +			resets =3D <&rst USB0_RESET>, <&rst
> USB0_OCP_RESET>;
> +			reset-names =3D "dwc2", "dwc2-ecc";
> +			clocks =3D <&clkmgr AGILEX5_USB_CLK>;
> +			iommus =3D <&smmu 6>;
> +			status =3D "disabled";
> +		};
> +
> +		usb31: usb31@11000000 {
> +			compatible =3D "snps,dwc3";
> +			reg =3D <0x11000000 0x100000>;
> +			resets =3D <&rst USB1_RESET>;
> +			phys =3D <&usbphy0>, <&usbphy0>;
> +			phy-names =3D "usb2-phy", "usb3-phy";
> +			dr_mode =3D "host";
> +			maximum-speed =3D "super-speed";
> +			snps,dis_u2_susphy_quirk;
> +			status =3D "disabled";
> +		};
> +
> +		watchdog0: watchdog@10d00200 {
> +			compatible =3D "snps,dw-wdt";
> +			reg =3D <0x10d00200 0x100>;
> +			interrupts =3D <0 117 4>;
> +			resets =3D <&rst WATCHDOG0_RESET>;
> +			clocks =3D <&clkmgr AGILEX5_L4_SYS_FREE_CLK>;
> +			status =3D "disabled";
> +		};
> +
> +		watchdog1: watchdog@10d00300 {
> +			compatible =3D "snps,dw-wdt";
> +			reg =3D <0x10d00300 0x100>;
> +			interrupts =3D <0 118 4>;
> +			resets =3D <&rst WATCHDOG1_RESET>;
> +			clocks =3D <&clkmgr AGILEX5_L4_SYS_FREE_CLK>;
> +			status =3D "disabled";
> +		};
> +
> +		watchdog2: watchdog@10d00400 {
> +			compatible =3D "snps,dw-wdt";
> +			reg =3D <0x10d00400 0x100>;
> +			interrupts =3D <0 125 4>;
> +			resets =3D <&rst WATCHDOG2_RESET>;
> +			clocks =3D <&clkmgr AGILEX5_L4_SYS_FREE_CLK>;
> +			status =3D "disabled";
> +		};
> +
> +		watchdog3: watchdog@10d00500 {
> +			compatible =3D "snps,dw-wdt";
> +			reg =3D <0x10d00500 0x100>;
> +			interrupts =3D <0 126 4>;
> +			resets =3D <&rst WATCHDOG3_RESET>;
> +			clocks =3D <&clkmgr AGILEX5_L4_SYS_FREE_CLK>;
> +			status =3D "disabled";
> +		};
> +
> +		watchdog4: watchdog@10d00600 {
> +			compatible =3D "snps,dw-wdt";
> +			reg =3D <0x10d00600 0x100>;
> +			interrupts =3D <0 175 4>;
> +			resets =3D <&rst WATCHDOG4_RESET>;
> +			clocks =3D <&clkmgr AGILEX5_L4_SYS_FREE_CLK>;
> +			status =3D "disabled";
> +		};
> +
> +		/* QSPI address not available yet */
> +		qspi: spi@108d2000 {
> +			compatible =3D "cdns,qspi-nor";
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <0x108d2000 0x100>,
> +			      <0x10900000 0x100000>;
> +			interrupts =3D <0 3 4>;
> +			cdns,fifo-depth =3D <128>;
> +			cdns,fifo-width =3D <4>;
> +			cdns,trigger-address =3D <0x00000000>;
> +			clocks =3D <&qspi_clk>;
> +
> +			status =3D "disabled";
> +		};
> +
> +		firmware {
> +			svc {
> +				compatible =3D "intel,stratix10-svc";
> +				method =3D "smc";
> +				memory-region =3D <&service_reserved>;
> +
> +				fpga_mgr: fpga-mgr {
> +					compatible =3D "intel,stratix10-soc-fpga-
> mgr";
> +				};
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
> b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
> new file mode 100644
> index 0000000000..fb86b1d9d7
> --- /dev/null
> +++ b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
> @@ -0,0 +1,134 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * U-Boot additions
> + *
> + * Copyright (C) 2024 Intel Corporation <www.intel.com>
> + */
> +
> +#include "socfpga_agilex5-u-boot.dtsi"
> +
> +/{
> +	aliases {
> +		spi0 =3D &qspi;
> +		freeze_br0 =3D &freeze_controller;
> +	};
> +
> +	soc {
> +		freeze_controller: freeze_controller@0x20000450 {
> +			compatible =3D "altr,freeze-bridge-controller";
> +			reg =3D <0x20000450 0x00000010>;
> +			status =3D "disabled";
> +		};
> +	};
> +
> +	memory {
> +		/* 8GB */
> +		reg =3D <0 0x80000000 0 0x80000000>,
> +		      <8 0x80000000 1 0x80000000>;
> +	};
> +
> +	chosen {
> +		stdout-path =3D "serial0:115200n8";
> +		u-boot,spl-boot-order =3D &mmc,&flash0,"/memory";
> +	};
> +};
> +
> +&flash0 {
> +	compatible =3D "jedec,spi-nor";
> +	spi-tx-bus-width =3D <4>;
> +	spi-rx-bus-width =3D <4>;
> +	bootph-all;
> +	/delete-property/ cdns,read-delay;
> +};
> +
> +&i3c0 {
> +	bootph-all;
> +};
> +
> +&i3c1 {
> +	bootph-all;
> +};
> +
> +&mmc {
> +	status =3D "okay";
> +	bus-width =3D <4>;
> +	sd-uhs-sdr50;
> +	cap-mmc-highspeed;
> +	bootph-all;
> +};
> +
> +&combophy0 {
> +	status =3D "okay";
> +	bootph-all;
> +	cdns,phy-use-ext-lpbk-dqs =3D <1>;
> +	cdns,phy-use-lpbk-dqs =3D <1>;
> +	cdns,phy-use-phony-dqs =3D <1>;
> +	cdns,phy-use-phony-dqs-cmd =3D <1>;
> +	cdns,phy-io-mask-always-on =3D <0>;
> +	cdns,phy-io-mask-end =3D <5>;
> +	cdns,phy-io-mask-start =3D <0>;
> +	cdns,phy-data-select-oe-end =3D <1>;
> +	cdns,phy-sync-method =3D <1>;
> +	cdns,phy-sw-half-cycle-shift =3D <0>;
> +	cdns,phy-rd-del-sel =3D <52>;
> +	cdns,phy-underrun-suppress =3D <1>;
> +	cdns,phy-gate-cfg-always-on =3D <1>;
> +	cdns,phy-param-dll-bypass-mode =3D <1>;
> +	cdns,phy-param-phase-detect-sel =3D <2>;
> +	cdns,phy-param-dll-start-point =3D <254>;
> +	cdns,phy-read-dqs-cmd-delay =3D <0>;
> +	cdns,phy-clk-wrdqs-delay =3D <0>;
> +	cdns,phy-clk-wr-delay =3D <0>;
> +	cdns,phy-read-dqs-delay =3D <0>;
> +	cdns,phy-phony-dqs-timing =3D <0>;
> +	cdns,hrs09-rddata-en =3D <1>;
> +	cdns,hrs09-rdcmd-en =3D <1>;
> +	cdns,hrs09-extended-wr-mode =3D <1>;
> +	cdns,hrs09-extended-rd-mode =3D <1>;
> +	cdns,hrs10-hcsdclkadj =3D <3>;
> +	cdns,hrs16-wrdata1-sdclk-dly =3D <0>;
> +	cdns,hrs16-wrdata0-sdclk-dly =3D <0>;
> +	cdns,hrs16-wrcmd1-sdclk-dly =3D <0>;
> +	cdns,hrs16-wrcmd0-sdclk-dly =3D <0>;
> +	cdns,hrs16-wrdata1-dly =3D <0>;
> +	cdns,hrs16-wrdata0-dly =3D <0>;
> +	cdns,hrs16-wrcmd1-dly =3D <0>;
> +	cdns,hrs16-wrcmd0-dly =3D <0>;
> +	cdns,hrs07-rw-compensate =3D <10>;
> +	cdns,hrs07-idelay-val =3D <0>;
> +};
> +
> +&qspi {
> +	status =3D "okay";
> +};
> +
> +&timer0 {
> +	bootph-all;
> +};
> +
> +&timer1 {
> +	bootph-all;
> +};
> +
> +&timer2 {
> +	bootph-all;
> +};
> +
> +&timer3 {
> +	bootph-all;
> +};
> +
> +&watchdog0 {
> +	bootph-all;
> +};
> +
> +#if !defined(CONFIG_SOCFPGA_SECURE_VAB_AUTH)
> +&fdt_0_blob {
> +	filename =3D "arch/arm/dts/socfpga_agilex5_socdk.dtb";
> +};
> +
> +&binman {
> +	/delete-node/ kernel;
> +};
> +#endif
> +
> diff --git a/arch/arm/dts/socfpga_agilex5_socdk.dts
> b/arch/arm/dts/socfpga_agilex5_socdk.dts
> new file mode 100644
> index 0000000000..852e1e5ae3
> --- /dev/null
> +++ b/arch/arm/dts/socfpga_agilex5_socdk.dts
> @@ -0,0 +1,163 @@
> +// SPDX-License-Identifier:     GPL-2.0
> +/*
> + * Copyright (C) 2024 Intel Corporation <www.intel.com>
> + */
> +#include "socfpga_agilex5.dtsi"
> +
> +/ {
> +	model =3D "SoCFPGA Agilex5 SoCDK";
> +
> +	aliases {
> +		serial0 =3D &uart0;
> +		ethernet0 =3D &gmac0;
> +		ethernet2 =3D &gmac2;
> +	};
> +
> +	leds {
> +		compatible =3D "gpio-leds";
> +		hps0 {
> +			label =3D "hps_led0";
> +			gpios =3D <&portb 20 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		hps1 {
> +			label =3D "hps_led1";
> +			gpios =3D <&portb 19 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		hps2 {
> +			label =3D "hps_led2";
> +			gpios =3D <&portb 21 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
> +	memory {
> +		device_type =3D "memory";
> +		/* We expect the bootloader to fill in the reg */
> +		reg =3D <0 0 0 0>;
> +	};
> +
> +	soc {
> +		clocks {
> +			osc1 {
> +				clock-frequency =3D <25000000>;
> +			};
> +		};
> +	};
> +};
> +
> +&gpio0 {
> +	status =3D "okay";
> +};
> +
> +&gpio1 {
> +	status =3D "okay";
> +};
> +
> +&i2c0 {
> +	status =3D "okay";
> +};
> +
> +&i2c1 {
> +	status =3D "okay";
> +};
> +
> +&i3c0 {
> +	status =3D "okay";
> +};
> +
> +&i3c1 {
> +	status =3D "okay";
> +};
> +
> +&uart0 {
> +	status =3D "okay";
> +};
> +
> +&usbphy0 {
> +	status =3D "okay";
> +};
> +
> +&usb0 {
> +	status =3D "okay";
> +	disable-over-current;
> +};
> +
> +&watchdog0 {
> +	status =3D "okay";
> +};
> +
> +&watchdog1 {
> +	status =3D "okay";
> +};
> +
> +&watchdog2 {
> +	status =3D "okay";
> +};
> +
> +&watchdog3 {
> +	status =3D "okay";
> +};
> +
> +&watchdog4 {
> +	status =3D "okay";
> +};
> +
> +&timer0 {
> +	status =3D "okay";
> +};
> +
> +&timer1 {
> +	status =3D "okay";
> +};
> +
> +&timer2 {
> +	status =3D "okay";
> +};
> +
> +&timer3 {
> +	status =3D "okay";
> +};
> +
> +&spi0 {
> +	status =3D "okay";
> +};
> +
> +&spi1 {
> +	status =3D "okay";
> +};
> +
> +&qspi {
> +	flash0: flash@0 {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		compatible =3D "mt25qu02g";
> +		reg =3D <0>;
> +		spi-max-frequency =3D <100000000>;
> +
> +		m25p,fast-read;
> +		cdns,page-size =3D <256>;
> +		cdns,block-size =3D <16>;
> +		cdns,read-delay =3D <1>;
> +		cdns,tshsl-ns =3D <50>;
> +		cdns,tsd2d-ns =3D <50>;
> +		cdns,tchsh-ns =3D <4>;
> +		cdns,tslch-ns =3D <4>;
> +
> +		partitions {
> +			compatible =3D "fixed-partitions";
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +
> +			qspi_boot: partition@0 {
> +				label =3D "u-boot";
> +				reg =3D <0x0 0x04200000>;
> +			};
> +
> +			root: partition@4200000 {
> +				label =3D "root";
> +				reg =3D <0x04200000 0x0BE00000>;
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi
> b/arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi
> index 84b91e8df0..15306db600 100644
> --- a/arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi
> @@ -2,7 +2,7 @@
>  /*
>   * U-Boot additions
>   *
> - * Copyright (C) 2020 Intel Corporation <www.intel.com>
> + * Copyright (C) 2020-2024 Intel Corporation <www.intel.com>
>   */
>=20
>  #if defined(CONFIG_FIT)
> @@ -21,14 +21,18 @@
>  			description =3D "FIT with firmware and bootloader";
>  			#address-cells =3D <1>;
>=20
> -			images {
> +			images: images {
>  				uboot {
>  					description =3D "U-Boot SoC64";
>  					type =3D "standalone";
>  					os =3D "U-Boot";
>  					arch =3D "arm64";
>  					compression =3D "none";
> +				#if
> IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
> +					load =3D <0x80200000>;
> +				#else
>  					load =3D <0x00200000>;
> +				#endif
>  					uboot_blob: blob-ext {
>  						filename =3D "u-boot-nodtb.bin";
>  					};
> @@ -43,8 +47,13 @@
>  					os =3D "arm-trusted-firmware";
>  					arch =3D "arm64";
>  					compression =3D "none";
> +				#if
> IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
> +					load =3D <0x80000000>;
> +					entry =3D <0x80000000>;
> +				#else
>  					load =3D <0x00001000>;
>  					entry =3D <0x00001000>;
> +				#endif
>  					atf_blob: blob-ext {
>  						filename =3D "bl31.bin";
>  					};
> @@ -53,11 +62,11 @@
>  					};
>  				};
>=20
> -				fdt {
> -					description =3D "U-Boot SoC64 flat
> device-tree";
> +				fdt-0 {
> +					description =3D "socfpga_socdk";
>  					type =3D "flat_dt";
>  					compression =3D "none";
> -					uboot_fdt_blob: blob-ext {
> +					fdt_0_blob: blob-ext {
>  						filename =3D "u-boot.dtb";
>  					};
>  					hash {
> @@ -66,17 +75,18 @@
>  				};
>  			};
>=20
> -			configurations {
> -				default =3D "conf";
> -				conf {
> -					description =3D "Intel SoC64 FPGA";
> +			board_config: configurations {
> +				default =3D "board-0";
> +
> +				board-0 {
> +					description =3D "board_0";
>  					firmware =3D "atf";
>  					loadables =3D "uboot";
> -					fdt =3D "fdt";
> +					fdt =3D "fdt-0";
>  					signature {
>  						algo =3D "crc32";
>  						key-name-hint =3D "dev";
> -						sign-images =3D "atf", "fdt",
> "uboot";
> +						sign-images =3D "atf", "uboot",
> "fdt-0";
>  					};
>  				};
>  			};
> @@ -96,8 +106,8 @@
>  					arch =3D "arm64";
>  					os =3D "linux";
>  					compression =3D "none";
> -					load =3D <0x4080000>;
> -					entry =3D <0x4080000>;
> +					load =3D <0x6000000>;
> +					entry =3D <0x6000000>;
>  					kernel_blob: blob-ext {
>  						filename =3D "Image";
>  					};
> @@ -146,7 +156,7 @@
>  	filename =3D "signed-bl31.bin";
>  };
>=20
> -&uboot_fdt_blob {
> +&fdt_0_blob {
>  	filename =3D "signed-u-boot.dtb";
>  };
>=20
> diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfi=
g
> index 114d243812..1008232cac 100644
> --- a/arch/arm/mach-socfpga/Kconfig
> +++ b/arch/arm/mach-socfpga/Kconfig
> @@ -8,7 +8,8 @@ config NR_DRAM_BANKS
>=20
>  config SOCFPGA_SECURE_VAB_AUTH
>  	bool "Enable boot image authentication with Secure Device Manager"
> -	depends on TARGET_SOCFPGA_AGILEX || TARGET_SOCFPGA_N5X
> +	depends on TARGET_SOCFPGA_AGILEX || TARGET_SOCFPGA_N5X || \
> +	  TARGET_SOCFPGA_AGILEX5
>  	select FIT_IMAGE_POST_PROCESS
>  	select SHA384
>  	select SHA512
> @@ -58,6 +59,15 @@ config TARGET_SOCFPGA_AGILEX
>  	select SPL_CLK if SPL
>  	select TARGET_SOCFPGA_SOC64
>=20
> +config TARGET_SOCFPGA_AGILEX5
> +	bool
> +	select BINMAN if SPL_ATF
> +	select CLK
> +	select FPGA_INTEL_SDM_MAILBOX
> +	select GICV3
> +	select SPL_CLK if SPL
> +	select TARGET_SOCFPGA_SOC64
> +
>  config TARGET_SOCFPGA_ARRIA5
>  	bool
>  	select TARGET_SOCFPGA_GEN5
> @@ -129,6 +139,10 @@ config TARGET_SOCFPGA_AGILEX_SOCDK
>  	bool "Intel SOCFPGA SoCDK (Agilex)"
>  	select TARGET_SOCFPGA_AGILEX
>=20
> +config TARGET_SOCFPGA_AGILEX5_SOCDK
> +	bool "Intel SOCFPGA SoCDK (Agilex5)"
> +	select TARGET_SOCFPGA_AGILEX5
> +
>  config TARGET_SOCFPGA_ARIES_MCVEVK
>  	bool "Aries MCVEVK (Cyclone V)"
>  	select TARGET_SOCFPGA_CYCLONE5
> @@ -202,6 +216,7 @@ config TARGET_SOCFPGA_TERASIC_SOCKIT
>  endchoice
>=20
>  config SYS_BOARD
> +	default "agilex5-socdk" if TARGET_SOCFPGA_AGILEX5_SOCDK
>  	default "agilex-socdk" if TARGET_SOCFPGA_AGILEX_SOCDK
>  	default "arria5-socdk" if TARGET_SOCFPGA_ARRIA5_SOCDK
>  	default "arria10-socdk" if TARGET_SOCFPGA_ARRIA10_SOCDK
> @@ -223,6 +238,7 @@ config SYS_BOARD
>  	default "vining_fpga" if TARGET_SOCFPGA_SOFTING_VINING_FPGA
>=20
>  config SYS_VENDOR
> +	default "intel" if TARGET_SOCFPGA_AGILEX5_SOCDK
>  	default "intel" if TARGET_SOCFPGA_AGILEX_SOCDK
>  	default "intel" if TARGET_SOCFPGA_N5X_SOCDK
>  	default "altera" if TARGET_SOCFPGA_ARRIA5_SOCDK
> @@ -245,6 +261,7 @@ config SYS_SOC
>  	default "socfpga"
>=20
>  config SYS_CONFIG_NAME
> +	default "socfpga_agilex5_socdk" if
> TARGET_SOCFPGA_AGILEX5_SOCDK
>  	default "socfpga_agilex_socdk" if TARGET_SOCFPGA_AGILEX_SOCDK
>  	default "socfpga_arria5_secu1" if TARGET_SOCFPGA_ARRIA5_SECU1
>  	default "socfpga_arria5_socdk" if TARGET_SOCFPGA_ARRIA5_SOCDK
> diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-
> socfpga/Makefile
> index ec38b64dd4..67c6a8dfec 100644
> --- a/arch/arm/mach-socfpga/Makefile
> +++ b/arch/arm/mach-socfpga/Makefile
> @@ -4,7 +4,7 @@
>  # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
>  #
>  # Copyright (C) 2012-2017 Altera Corporation <www.altera.com>
> -# Copyright (C) 2017-2021 Intel Corporation <www.intel.com>
> +# Copyright (C) 2017-2024 Intel Corporation <www.intel.com>
>=20
>  obj-y	+=3D board.o
>  obj-y	+=3D clock_manager.o
> @@ -56,6 +56,15 @@ obj-y	+=3D wrap_handoff_soc64.o
>  obj-y	+=3D wrap_pll_config_soc64.o
>  endif
>=20
> +ifdef CONFIG_TARGET_SOCFPGA_AGILEX5
> +obj-y	+=3D clock_manager_agilex5.o
> +obj-y	+=3D mailbox_s10.o
> +obj-y	+=3D misc_soc64.o
> +obj-y	+=3D mmu-arm64_s10.o
> +obj-y	+=3D reset_manager_s10.o
> +obj-y	+=3D wrap_pll_config_soc64.o
> +endif
> +
>  ifdef CONFIG_TARGET_SOCFPGA_N5X
>  obj-y	+=3D clock_manager_n5x.o
>  obj-y	+=3D lowlevel_init_soc64.o
> @@ -95,6 +104,9 @@ endif
>  ifdef CONFIG_TARGET_SOCFPGA_N5X
>  obj-y	+=3D spl_n5x.o
>  endif
> +ifdef CONFIG_TARGET_SOCFPGA_AGILEX5
> +obj-y	+=3D spl_soc64.o
> +endif
>  else
>  obj-$(CONFIG_SPL_ATF) +=3D secure_reg_helper.o
>  obj-$(CONFIG_SPL_ATF) +=3D smc_api.o
> diff --git a/arch/arm/mach-socfpga/board.c b/arch/arm/mach-socfpga/board.=
c
> index 09e09192fb..616e1afe5d 100644
> --- a/arch/arm/mach-socfpga/board.c
> +++ b/arch/arm/mach-socfpga/board.c
> @@ -7,9 +7,11 @@
>=20
>  #include <common.h>
>  #include <asm/arch/clock_manager.h>
> +#include <asm/arch/mailbox_s10.h>
>  #include <asm/arch/misc.h>
>  #include <asm/arch/reset_manager.h>
>  #include <asm/arch/secure_vab.h>
> +#include <asm/arch/smc_api.h>
>  #include <asm/global_data.h>
>  #include <asm/io.h>
>  #include <errno.h>
> @@ -23,6 +25,8 @@
>=20
>  DECLARE_GLOBAL_DATA_PTR;
>=20
> +#define DEFAULT_JTAG_USERCODE 0xFFFFFFFF
> +
>  void s_init(void) {
>  #ifndef CONFIG_ARM64
>  	/*
> @@ -92,13 +96,50 @@ int g_dnl_board_usb_cable_connected(void)
>  }
>  #endif
>=20
> -#ifdef CONFIG_SPL_BUILD
> -__weak int board_fit_config_name_match(const char *name)
> +u8 socfpga_get_board_id(void)
>  {
> -	/* Just empty function now - can't decide what to choose */
> -	debug("%s: %s\n", __func__, name);
> +	u8 board_id =3D 0;
> +	u32 jtag_usercode;
> +	int err;
>=20
> -	return 0;
> +#if !IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_SPL_ATF)
> +	err =3D smc_get_usercode(&jtag_usercode);
> +#else
> +	u32 resp_len =3D 1;
> +
> +	err =3D mbox_send_cmd(MBOX_ID_UBOOT, MBOX_GET_USERCODE,
> MBOX_CMD_DIRECT, 0,
> +			    NULL, 0, &resp_len, &jtag_usercode);
> +#endif
> +
> +	if (err) {
> +		puts("Fail to read JTAG Usercode. Default Board ID to 0\n");
> +		return board_id;
> +	}
> +
> +	debug("Valid JTAG Usercode: %u\n", jtag_usercode);
> +
> +	if (jtag_usercode =3D=3D DEFAULT_JTAG_USERCODE) {
> +		debug("JTAG Usercode is not set. Default Board ID to 0\n");
> +	} else if (jtag_usercode >=3D 0 && jtag_usercode <=3D 255) {
> +		board_id =3D jtag_usercode;
> +		debug("Valid JTAG Usercode. Set Board ID to %u\n", board_id);
> +	} else {
> +		puts("Board ID is not in range 0 to 255\n");
> +	}
> +
> +	return board_id;
> +}
> +
> +#if IS_ENABLED(CONFIG_SPL_BUILD) &&
> IS_ENABLED(CONFIG_TARGET_SOCFPGA_SOC64)
> +int board_fit_config_name_match(const char *name)
> +{
> +	char board_name[10];
> +
> +	sprintf(board_name, "board_%u", socfpga_get_board_id());
> +
> +	debug("Board name: %s\n", board_name);
> +
> +	return strcmp(name, board_name);
>  }
>  #endif
>=20
> @@ -116,6 +157,8 @@ void board_fit_image_post_process(const void *fit, in=
t
> node, void **p_image,
>  #if !IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_FIT)
>  void board_prep_linux(struct bootm_headers *images)
>  {
> +	bool use_fit =3D false;
> +
>  	if (!images->fit_uname_cfg) {
>  		if (IS_ENABLED(CONFIG_SOCFPGA_SECURE_VAB_AUTH) &&
>=20
> 	    !IS_ENABLED(CONFIG_SOCFPGA_SECURE_VAB_AUTH_ALLOW_NON
> _FIT_IMAGE)) {
> @@ -127,12 +170,13 @@ void board_prep_linux(struct bootm_headers
> *images)
>  			hang();
>  		}
>  	} else {
> +		use_fit =3D true;
>  		/* Update fdt_addr in enviroment variable */
>  		env_set_hex("fdt_addr", (ulong)images->ft_addr);
>  		debug("images->ft_addr =3D 0x%08lx\n", (ulong)images-
> >ft_addr);
>  	}
>=20
> -	if (IS_ENABLED(CONFIG_CADENCE_QSPI)) {
> +	if (use_fit && IS_ENABLED(CONFIG_CADENCE_QSPI)) {
>  		if (env_get("linux_qspi_enable"))
>  			run_command(env_get("linux_qspi_enable"), 0);
>  	}
> diff --git a/arch/arm/mach-socfpga/clock_manager_agilex5.c
> b/arch/arm/mach-socfpga/clock_manager_agilex5.c
> new file mode 100644
> index 0000000000..b92f0b3af8
> --- /dev/null
> +++ b/arch/arm/mach-socfpga/clock_manager_agilex5.c
> @@ -0,0 +1,89 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 Intel Corporation <www.intel.com>
> + *
> + */
> +
> +#include <clk.h>
> +#include <config.h>
> +#include <dm.h>
> +#include <errno.h>
> +#include <log.h>
> +#include <malloc.h>
> +#include <stdarg.h>
> +#include <stdio.h>
> +#include <time.h>
> +#include <vsprintf.h>
> +#include <asm/global_data.h>
> +#include <asm/io.h>
> +#include <asm/u-boot.h>
> +#include <linux/kernel.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +#include <asm/arch/clock_manager.h>
> +#include <asm/arch/system_manager.h>
> +#include <dt-bindings/clock/agilex5-clock.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +static ulong cm_get_rate_dm(u32 id)
> +{
> +	struct udevice *dev;
> +	struct clk clk;
> +	ulong rate;
> +	int ret;
> +
> +	ret =3D uclass_get_device_by_driver(UCLASS_CLK,
> +
> DM_DRIVER_GET(socfpga_agilex5_clk),
> +					  &dev);
> +	if (ret)
> +		return 0;
> +
> +	clk.id =3D id;
> +	ret =3D clk_request(dev, &clk);
> +	if (ret < 0)
> +		return 0;
> +
> +	rate =3D clk_get_rate(&clk);
> +
> +	if ((rate =3D=3D (unsigned long)-ENOSYS) ||
> +	    (rate =3D=3D (unsigned long)-ENXIO) ||
> +	    (rate =3D=3D (unsigned long)-EIO)) {
> +		debug("%s id %u: clk_get_rate err: %ld\n",
> +		      __func__, id, rate);
> +		return 0;
> +	}
> +
> +	return rate;
> +}
> +
> +static u32 cm_get_rate_dm_khz(u32 id)
> +{
> +	return cm_get_rate_dm(id) / 1000;
> +}
> +
> +unsigned long cm_get_mpu_clk_hz(void)
> +{
> +	return cm_get_rate_dm(AGILEX5_MPU_CLK);
> +}
> +
> +unsigned int cm_get_l4_sys_free_clk_hz(void)
> +{
> +	return cm_get_rate_dm(AGILEX5_L4_SYS_FREE_CLK);
> +}
> +
> +void cm_print_clock_quick_summary(void)
> +{
> +	printf("MPU       %10d kHz\n",
> +	       cm_get_rate_dm_khz(AGILEX5_MPU_CLK));
> +	printf("L4 Main	    %8d kHz\n",
> +	       cm_get_rate_dm_khz(AGILEX5_L4_MAIN_CLK));
> +	printf("L4 sys free %8d kHz\n",
> +	       cm_get_rate_dm_khz(AGILEX5_L4_SYS_FREE_CLK));
> +	printf("L4 MP       %8d kHz\n",
> +	       cm_get_rate_dm_khz(AGILEX5_L4_MP_CLK));
> +	printf("L4 SP       %8d kHz\n",
> +	       cm_get_rate_dm_khz(AGILEX5_L4_SP_CLK));
> +	printf("SDMMC       %8d kHz\n",
> +	       cm_get_rate_dm_khz(AGILEX5_SDMMC_CLK));
> +}
> diff --git a/arch/arm/mach-socfpga/include/mach/base_addr_soc64.h
> b/arch/arm/mach-socfpga/include/mach/base_addr_soc64.h
> index 3f899fcfa3..65721098b2 100644
> --- a/arch/arm/mach-socfpga/include/mach/base_addr_soc64.h
> +++ b/arch/arm/mach-socfpga/include/mach/base_addr_soc64.h
> @@ -1,11 +1,46 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /*
> - * Copyright (C) 2016-2021 Intel Corporation <www.intel.com>
> + * Copyright (C) 2016-2024 Intel Corporation <www.intel.com>
>   */
>=20
>  #ifndef _SOCFPGA_SOC64_BASE_HARDWARE_H_
>  #define _SOCFPGA_SOC64_BASE_HARDWARE_H_
>=20
> +#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
> +#define SOCFPGA_CCU_ADDRESS			0x1c000000
> +#define SOCFPGA_F2SDRAM_MGR_ADDRESS		0x18001000
> +#define SOCFPGA_SMMU_ADDRESS			0x16000000
> +#define SOCFPGA_OCRAM_FIREWALL_ADDRESS		0x108cc400
> +#define SOCFPGA_MAILBOX_ADDRESS			0x10a30000
> +#define SOCFPGA_UART0_ADDRESS			0x10c02000
> +#define SOCFPGA_UART1_ADDRESS			0x10c02100
> +#define SOCFPGA_SPTIMER0_ADDRESS		0x10c03000
> +#define SOCFPGA_SPTIMER1_ADDRESS		0x10c03100
> +#define SOCFPGA_SYSTIMER0_ADDRESS		0x10d00000
> +#define SOCFPGA_SYSTIMER1_ADDRESS		0x10d00100
> +#define SOCFPGA_L4WD0_ADDRESS			0x10d00200
> +#define SOCFPGA_L4WD1_ADDRESS			0x10d00300
> +#define SOCFPGA_L4WD2_ADDRESS			0x10d00400
> +#define SOCFPGA_L4WD3_ADDRESS			0x10d00500
> +#define SOCFPGA_L4WD4_ADDRESS			0x10d00600
> +#define SOCFPGA_GTIMER_SEC_ADDRESS		0x10d01000
> +#define SOCFPGA_GTIMER_NSEC_ADDRESS		0x10d02000
> +#define SOCFPGA_CLKMGR_ADDRESS			0x10d10000
> +#define SOCFPGA_RSTMGR_ADDRESS			0x10d11000
> +#define SOCFPGA_SYSMGR_ADDRESS			0x10d12000
> +#define SOCFPGA_OCRAM_ADDRESS			0x00000000
> +#define SOCFPGA_FW_DDR_CCU_DMI0_ADDRESS		0x18000800
> +#define SOCFPGA_FW_DDR_CCU_DMI1_ADDRESS		0x18000A00
> +#define SOCFPGA_FW_TBU2NOC_ADDRESS		0x18000C00
> +#define SOCFPGA_FIREWALL_L4_PER			0x10d21000
> +#define SOCFPGA_FIREWALL_L4_SYS			0x10d21100
> +#define SOCFPGA_FIREWALL_SOC2FPGA		0x10d21200
> +#define SOCFPGA_FIREWALL_LWSOC2FPGA		0x10d21300
> +#define SOCFPGA_FIREWALL_TCU			0x10d21400
> +#define SOCFPGA_FIREWALL_PRIV_MEMORYMAP_PRIV	0x10d24800
> +#define GICD_BASE				0x1d000000
> +#define GICR_BASE				0x1d060000
> +#else
>  #define SOCFPGA_CCU_ADDRESS			0xf7000000
>  #define SOCFPGA_SDR_SCHEDULER_ADDRESS		0xf8000400
>  #define SOCFPGA_HMC_MMR_IO48_ADDRESS		0xf8010000
> @@ -44,5 +79,6 @@
>  #define SOCFPGA_OCRAM_ADDRESS			0xffe00000
>  #define GICD_BASE				0xfffc1000
>  #define GICC_BASE				0xfffc2000
> +#endif /* IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5) */
>=20
>  #endif /* _SOCFPGA_SOC64_BASE_HARDWARE_H_ */
> diff --git a/arch/arm/mach-socfpga/include/mach/clock_manager.h
> b/arch/arm/mach-socfpga/include/mach/clock_manager.h
> index a8cb07a1c4..6c9d32b9dd 100644
> --- a/arch/arm/mach-socfpga/include/mach/clock_manager.h
> +++ b/arch/arm/mach-socfpga/include/mach/clock_manager.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0+ */
>  /*
> - *  Copyright (C) 2013-2017 Altera Corporation <www.altera.com>
> + *  Copyright (C) 2013-2024 Altera Corporation <www.altera.com>
>   */
>=20
>  #ifndef _CLOCK_MANAGER_H_
> @@ -28,6 +28,8 @@ int cm_set_qspi_controller_clk_hz(u32 clk_hz);
>  #include <asm/arch/clock_manager_s10.h>
>  #elif defined(CONFIG_TARGET_SOCFPGA_AGILEX)
>  #include <asm/arch/clock_manager_agilex.h>
> +#elif IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
> +#include <asm/arch/clock_manager_agilex5.h>
>  #elif IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X)
>  #include <asm/arch/clock_manager_n5x.h>
>  #endif
> diff --git a/arch/arm/mach-socfpga/include/mach/clock_manager_agilex5.h
> b/arch/arm/mach-socfpga/include/mach/clock_manager_agilex5.h
> new file mode 100644
> index 0000000000..1ae0a92603
> --- /dev/null
> +++ b/arch/arm/mach-socfpga/include/mach/clock_manager_agilex5.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2024 Intel Corporation <www.intel.com>
> + */
> +
> +#ifndef _CLOCK_MANAGER_AGILEX5_
> +#define _CLOCK_MANAGER_AGILEX5_
> +
> +#include <asm/arch/clock_manager_soc64.h>
> +#include "../../../../../drivers/clk/altera/clk-agilex5.h"
> +
> +#endif /* _CLOCK_MANAGER_AGILEX5_ */
> diff --git a/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
> b/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
> index 9b85e5865b..2684b84a08 100644
> --- a/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
> +++ b/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0
>   *
> - * Copyright (C) 2016-2021 Intel Corporation <www.intel.com>
> + * Copyright (C) 2016-2024 Intel Corporation <www.intel.com>
>   *
>   */
>=20
> @@ -17,7 +17,12 @@
>  #define SOC64_HANDOFF_MAGIC_FPGA	0x46504741
>  #define SOC64_HANDOFF_MAGIC_DELAY	0x444C4159
>  #define SOC64_HANDOFF_MAGIC_CLOCK	0x434C4B53
> +#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
> +#define SOC64_HANDOFF_MAGIC_PERI	0x50455249
> +#define SOC64_HANDOFF_MAGIC_SDRAM	0x5344524d
> +#else
>  #define SOC64_HANDOFF_MAGIC_MISC	0x4D495343
> +#endif
>=20
>  #define SOC64_HANDOFF_OFFSET_LENGTH	0x4
>  #define SOC64_HANDOFF_OFFSET_DATA	0x10
> @@ -27,6 +32,8 @@
>  	IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX)
>  #define SOC64_HANDOFF_BASE		0xFFE3F000
>  #define SOC64_HANDOFF_MISC		(SOC64_HANDOFF_BASE +
> 0x610)
> +#elif IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
> +#define SOC64_HANDOFF_BASE		0x0007F000
>  #elif IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X)
>  #define SOC64_HANDOFF_BASE		0xFFE5F000
>  #define SOC64_HANDOFF_MISC		(SOC64_HANDOFF_BASE +
> 0x630)
> @@ -58,13 +65,21 @@
>  #define SOC64_HANDOFF_FPGA		(SOC64_HANDOFF_BASE +
> 0x330)
>  #define SOC64_HANDOFF_DELAY		(SOC64_HANDOFF_BASE +
> 0x3F0)
>  #define SOC64_HANDOFF_CLOCK		(SOC64_HANDOFF_BASE +
> 0x580)
> +#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
> +#define SOC64_HANDOFF_PERI		(SOC64_HANDOFF_BASE +
> 0x620)
> +#define SOC64_HANDOFF_SDRAM		(SOC64_HANDOFF_BASE +
> 0x634)
> +#define SOC64_HANDOFF_SDRAM_LEN		1
> +#endif
>=20
>  #if IS_ENABLED(CONFIG_TARGET_SOCFPGA_STRATIX10)
> -#define SOC64_HANDOFF_CLOCK_OSC	(SOC64_HANDOFF_BASE + 0x608)
> -#define SOC64_HANDOFF_CLOCK_FPGA	(SOC64_HANDOFF_BASE +
> 0x60C)
> +#define SOC64_HANDOFF_CLOCK_OSC
> 	(SOC64_HANDOFF_BASE + 0x608)
> +#define SOC64_HANDOFF_CLOCK_FPGA
> 	(SOC64_HANDOFF_BASE + 0x60C)
> +#elif IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
> +#define SOC64_HANDOFF_CLOCK_OSC
> 	(SOC64_HANDOFF_BASE + 0x60c)
> +#define SOC64_HANDOFF_CLOCK_FPGA
> 	(SOC64_HANDOFF_BASE + 0x610)
>  #else
> -#define SOC64_HANDOFF_CLOCK_OSC	(SOC64_HANDOFF_BASE + 0x5fc)
> -#define SOC64_HANDOFF_CLOCK_FPGA	(SOC64_HANDOFF_BASE +
> 0x600)
> +#define SOC64_HANDOFF_CLOCK_OSC
> 	(SOC64_HANDOFF_BASE + 0x5fc)
> +#define SOC64_HANDOFF_CLOCK_FPGA
> 	(SOC64_HANDOFF_BASE + 0x600)
>  #endif
>=20
>  #define SOC64_HANDOFF_MUX_LEN			96
> @@ -78,6 +93,12 @@
>=20
>  #ifndef __ASSEMBLY__
>  #include <asm/types.h>
> +enum endianness {
> +	LITTLE_ENDIAN =3D 0,
> +	BIG_ENDIAN,
> +	UNKNOWN_ENDIANNESS
> +};
> +
>  int socfpga_get_handoff_size(void *handoff_address);
>  int socfpga_handoff_read(void *handoff_address, void *table, u32 table_l=
en);
>  #endif
> diff --git a/arch/arm/mach-socfpga/include/mach/mailbox_s10.h
> b/arch/arm/mach-socfpga/include/mach/mailbox_s10.h
> index fbaf11597e..2cc7c89044 100644
> --- a/arch/arm/mach-socfpga/include/mach/mailbox_s10.h
> +++ b/arch/arm/mach-socfpga/include/mach/mailbox_s10.h
> @@ -119,6 +119,7 @@ enum ALT_SDM_MBOX_RESP_CODE {
>  #define MBOX_RECONFIG_DATA	8
>  #define MBOX_RECONFIG_STATUS	9
>  #define MBOX_VAB_SRC_CERT		11
> +#define MBOX_GET_USERCODE		19
>  #define MBOX_QSPI_OPEN		50
>  #define MBOX_QSPI_CLOSE		51
>  #define MBOX_QSPI_DIRECT	59
> diff --git a/arch/arm/mach-socfpga/mmu-arm64_s10.c b/arch/arm/mach-
> socfpga/mmu-arm64_s10.c
> index a55b7b7cf3..b1e327a24e 100644
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
> +		.attrs	=3D PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +				PTE_BLOCK_NON_SHARE |
> +				PTE_BLOCK_PXN | PTE_BLOCK_UXN,
> +	}, {
> +		/* MEM 2GB */
> +		.virt	=3D 0x80000000UL,
> +		.phys	=3D 0x80000000UL,
> +		.size	=3D 0x80000000UL,
> +		.attrs	=3D PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> +				PTE_BLOCK_INNER_SHARE,
> +	}, {
> +		/* List terminator */
> +	},
> +};
> +
> +struct mm_region *mem_map =3D socfpga_agilex5_mem_map;
> +
> +#else
>  static struct mm_region socfpga_stratix10_mem_map[] =3D {
>  	{
>  		/* MEM 2GB*/
> @@ -70,3 +126,4 @@ static struct mm_region socfpga_stratix10_mem_map[]
> =3D {
>  };
>=20
>  struct mm_region *mem_map =3D socfpga_stratix10_mem_map;
> +#endif
> diff --git a/board/intel/agilex5-socdk/MAINTAINERS b/board/intel/agilex5-
> socdk/MAINTAINERS
> new file mode 100644
> index 0000000000..b696f788c8
> --- /dev/null
> +++ b/board/intel/agilex5-socdk/MAINTAINERS
> @@ -0,0 +1,8 @@
> +SOCFPGA BOARD
> +M:	Tien Fong Chee <tien.fong.chee@intel.com>
> +M:	Teik Heng Chong <teik.heng.chong@intel.com>
> +M:	Jit Loon Lim <jit.loon.lim@intel.com>
> +S:	Maintained
> +F:	board/intel/agilex5-socdk/
> +F:	include/configs/socfpga_agilex5_socdk.h
> +F:	configs/socfpga_agilex5_defconfig
> diff --git a/configs/socfpga_agilex5_defconfig
> b/configs/socfpga_agilex5_defconfig
> new file mode 100644
> index 0000000000..f39954aea8
> --- /dev/null
> +++ b/configs/socfpga_agilex5_defconfig
> @@ -0,0 +1,116 @@
> +CONFIG_ARM=3Dy
> +CONFIG_SPL_LDSCRIPT=3D"arch/arm/mach-socfpga/u-boot-spl-soc64.lds"
> +CONFIG_SYS_SPI_U_BOOT_OFFS=3D0x04000000
> +CONFIG_ARCH_SOCFPGA=3Dy
> +CONFIG_TEXT_BASE=3D0x80200000
> +CONFIG_SYS_MALLOC_F_LEN=3D0x2000
> +CONFIG_NR_DRAM_BANKS=3D2
> +CONFIG_ENV_SIZE=3D0x2000
> +CONFIG_ENV_OFFSET=3D0x04100000
> +CONFIG_DM_GPIO=3Dy
> +CONFIG_DEFAULT_DEVICE_TREE=3D"socfpga_agilex5_socdk"
> +CONFIG_TARGET_SOCFPGA_AGILEX5_SOCDK=3Dy
> +CONFIG_IDENT_STRING=3D"socfpga_agilex5"
> +CONFIG_SPL_FS_FAT=3Dy
> +CONFIG_DISTRO_DEFAULTS=3Dy
> +CONFIG_FIT=3Dy
> +CONFIG_SPL_FIT_SIGNATURE=3Dy
> +CONFIG_SPL_LOAD_FIT=3Dy
> +CONFIG_SPL_LOAD_FIT_ADDRESS=3D0x82000000
> +# CONFIG_USE_SPL_FIT_GENERATOR is not set
> +CONFIG_QSPI_BOOT=3Dy
> +CONFIG_BOOTDELAY=3D5
> +CONFIG_USE_BOOTARGS=3Dy
> +CONFIG_BOOTARGS=3D"console=3DttyS0,115200 initrd=3D0x90000000
> root=3D/dev/ram0 rw init=3D/sbin/init ramdisk_size=3D10000000 earlycon pa=
nic=3D-1
> nosmp kvm-arm.mode=3Dnvhe"
> +CONFIG_LEGACY_IMAGE_FORMAT=3Dy
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_CRC32=3Dy
> +CONFIG_SPL_CACHE=3Dy
> +CONFIG_SPL_ATF=3Dy
> +CONFIG_SPL_ATF_NO_PLATFORM_PARAM=3Dy
> +CONFIG_SYS_PROMPT=3D"SOCFPGA_AGILEX5 # "
> +CONFIG_CMD_NVEDIT_SELECT=3Dy
> +CONFIG_CMD_MEMTEST=3Dy
> +CONFIG_CMD_GPIO=3Dy
> +CONFIG_CMD_I2C=3Dy
> +CONFIG_CMD_SF=3Dy
> +CONFIG_DOS_PARTITION=3Dy
> +CONFIG_SPL_DOS_PARTITION=3Dy
> +CONFIG_SPL_SYS_DISABLE_DCACHE_OPS=3Dy
> +CONFIG_CMD_MTD=3Dy
> +# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
> +CONFIG_CMD_SPI=3Dy
> +CONFIG_CMD_USB=3Dy
> +CONFIG_CMD_CACHE=3Dy
> +CONFIG_SPL_SPI_FLASH_MTD=3Dy
> +CONFIG_SPI_FLASH_MTD=3Dy
> +CONFIG_SPL_MTD_SUPPORT=3Dy
> +CONFIG_CMD_UBI=3Dy
> +CONFIG_CMD_UBIFS=3Dy
> +CONFIG_MTD_UBI=3Dy
> +CONFIG_MTD_UBI_WL_THRESHOLD=3D4096
> +CONFIG_MTD_UBI_BEB_LIMIT=3D20
> +# CONFIG_ISO_PARTITION is not set
> +# CONFIG_EFI_PARTITION is not set
> +CONFIG_OF_LIST=3D""
> +CONFIG_ENV_IS_IN_UBI=3Dy
> +CONFIG_ENV_UBI_PART=3D"root"
> +CONFIG_ENV_UBI_VOLUME=3D"env"
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> +CONFIG_NET_RANDOM_ETHADDR=3Dy
> +CONFIG_SPL_DM_SEQ_ALIAS=3Dy
> +CONFIG_SPL_ALTERA_SDRAM=3Dy
> +CONFIG_FPGA_INTEL_PR=3Dy
> +CONFIG_DWAPB_GPIO=3Dy
> +CONFIG_DM_I2C=3Dy
> +CONFIG_SYS_I2C_DW=3Dy
> +CONFIG_MISC=3Dy
> +CONFIG_MTD=3Dy
> +CONFIG_DM_MTD=3Dy
> +CONFIG_SF_DEFAULT_MODE=3D0x2003
> +CONFIG_SPI_FLASH_SPANSION=3Dy
> +CONFIG_SPI_FLASH_STMICRO=3Dy
> +CONFIG_UBI_SILENCE_MSG=3Dy
> +CONFIG_DM_ETH=3Dy
> +CONFIG_RGMII=3Dy
> +CONFIG_DM_RESET=3Dy
> +CONFIG_SYS_NS16550_MEM32=3Dy
> +CONFIG_SPI=3Dy
> +CONFIG_CADENCE_QSPI=3Dy
> +CONFIG_DESIGNWARE_SPI=3Dy
> +CONFIG_USB=3Dy
> +CONFIG_USB_DWC2=3Dy
> +CONFIG_USB_XHCI_HCD=3Dy
> +CONFIG_UBIFS_SILENCE_MSG=3Dy
> +# CONFIG_SPL_USE_TINY_PRINTF is not set
> +CONFIG_PANIC_HANG=3Dy
> +CONFIG_SPL_SPI_LOAD=3Dy
> +CONFIG_SYS_LOAD_ADDR=3D0x82000000
> +CONFIG_WDT=3Dy
> +CONFIG_CMD_WDT=3Dy
> +CONFIG_DESIGNWARE_WATCHDOG=3Dy
> +CONFIG_SPL_WDT=3Dy
> +CONFIG_WATCHDOG_AUTOSTART=3Dn
> +CONFIG_TIMER=3Dy
> +CONFIG_DESIGNWARE_APB_TIMER=3Dy
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x80300000
> +CONFIG_SPL_MAX_SIZE=3D0x40000
> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=3Dy
> +CONFIG_SPL_BSS_START_ADDR=3D0xbff00000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK=3D0x7f000
> +CONFIG_SYS_SPL_MALLOC=3Dy
> +CONFIG_HAS_CUSTOM_SPL_MALLOC_START=3Dy
> +CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=3D0xbfa00000
> +CONFIG_SYS_SPL_MALLOC_SIZE=3D0x500000
> +CONFIG_SPL_BSS_MAX_SIZE=3D0x100000
> +# CONFIG_EFI_LOADER is not set
> +CONFIG_I3C=3Dy
> +CONFIG_DW_I3C_MASTER=3Dy
> +CONFIG_CMD_I3C=3Dy
> +CONFIG_SYS_MAXARGS=3D32
> +CONFIG_CMD_TIMER=3Dy
> +# CONFIG_BOOTFILE=3D"Image" is not set for CONFIG_SPL_ATF=3Dy
> +CONFIG_USE_BOOTFILE=3Dy
> +CONFIG_BOOTFILE=3D"kernel.itb"
> diff --git a/drivers/clk/altera/Makefile b/drivers/clk/altera/Makefile
> index 33db092918..61ffa4179a 100644
> --- a/drivers/clk/altera/Makefile
> +++ b/drivers/clk/altera/Makefile
> @@ -7,3 +7,4 @@ obj-$(CONFIG_TARGET_SOCFPGA_AGILEX) +=3D clk-agilex.o
>  obj-$(CONFIG_TARGET_SOCFPGA_ARRIA10) +=3D clk-arria10.o
>  obj-$(CONFIG_TARGET_SOCFPGA_N5X) +=3D clk-n5x.o
>  obj-$(CONFIG_TARGET_SOCFPGA_N5X) +=3D clk-mem-n5x.o
> +obj-$(CONFIG_TARGET_SOCFPGA_AGILEX5) +=3D clk-agilex5.o
> diff --git a/drivers/clk/altera/clk-agilex5.c b/drivers/clk/altera/clk-ag=
ilex5.c
> new file mode 100644
> index 0000000000..c3b614ace4
> --- /dev/null
> +++ b/drivers/clk/altera/clk-agilex5.c
> @@ -0,0 +1,743 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 Intel Corporation <www.intel.com>
> + */
> +
> +#include <clk-uclass.h>
> +#include <config.h>
> +#include <errno.h>
> +#include <dm.h>
> +#include <log.h>
> +#include <stdarg.h>
> +#include <stdio.h>
> +#include <time.h>
> +#include <vsprintf.h>
> +#include <asm/global_data.h>
> +#include <asm/io.h>
> +#include <asm/system.h>
> +#include <asm/u-boot.h>
> +#include <dm/lists.h>
> +#include <dm/util.h>
> +#include <linux/bitops.h>
> +#include <linux/kernel.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +#include <asm/arch/clock_manager.h>
> +#include <dt-bindings/clock/agilex5-clock.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +struct socfpga_clk_plat {
> +	void __iomem *regs;
> +};
> +
> +/*
> + * function to write the bypass register which requires a poll of the
> + * busy bit
> + */
> +static void clk_write_bypass_mainpll(struct socfpga_clk_plat *plat, u32 =
val)
> +{
> +	CM_REG_WRITEL(plat, val, CLKMGR_MAINPLL_BYPASS);
> +	cm_wait_for_fsm();
> +}
> +
> +static void clk_write_bypass_perpll(struct socfpga_clk_plat *plat, u32 v=
al)
> +{
> +	CM_REG_WRITEL(plat, val, CLKMGR_PERPLL_BYPASS);
> +	cm_wait_for_fsm();
> +}
> +
> +/* function to write the ctrl register which requires a poll of the busy=
 bit */
> +static void clk_write_ctrl(struct socfpga_clk_plat *plat, u32 val)
> +{
> +	CM_REG_WRITEL(plat, val, CLKMGR_CTRL);
> +	cm_wait_for_fsm();
> +}
> +
> +static const struct {
> +	u32 reg;
> +	u32 val;
> +	u32 mask;
> +} membus_pll[] =3D {
> +	{
> +		MEMBUS_CLKSLICE_REG,
> +		/*
> +		 * BIT[7:7]
> +		 * Enable source synchronous mode
> +		 */
> +		BIT(7),
> +		BIT(7)
> +	},
> +	{
> +		MEMBUS_SYNTHCALFOSC_INIT_CENTERFREQ_REG,
> +		/*
> +		 * BIT[0:0]
> +		 * Sets synthcalfosc_init_centerfreq=3D1 to limit overshoot
> +		 * frequency during lock
> +		 */
> +		BIT(0),
> +		BIT(0)
> +	},
> +	{
> +		MEMBUS_SYNTHPPM_WATCHDOGTMR_VF01_REG,
> +		/*
> +		 * BIT[0:0]
> +		 * Sets synthppm_watchdogtmr_vf0=3D1 to give the pll more
> time
> +		 * to settle before lock is asserted.
> +		 */
> +		BIT(0),
> +		BIT(0)
> +	},
> +	{
> +		MEMBUS_CALCLKSLICE0_DUTY_LOCOVR_REG,
> +		/*
> +		 * BIT[6:0]
> +		 * Centering duty cycle for clkslice0 output
> +		 */
> +		0x4a,
> +		GENMASK(6, 0)
> +	},
> +	{
> +		MEMBUS_CALCLKSLICE1_DUTY_LOCOVR_REG,
> +		/*
> +		 * BIT[6:0]
> +		 * Centering duty cycle for clkslice1 output
> +		 */
> +		0x4a,
> +		GENMASK(6, 0)
> +	},
> +};
> +
> +static int membus_wait_for_req(struct socfpga_clk_plat *plat, u32 pll,
> +			       int timeout)
> +{
> +	int cnt =3D 0;
> +	u32 req_status;
> +
> +	if (pll =3D=3D MEMBUS_MAINPLL)
> +		req_status =3D CM_REG_READL(plat, CLKMGR_MAINPLL_MEM);
> +	else
> +		req_status =3D CM_REG_READL(plat, CLKMGR_PERPLL_MEM);
> +
> +	while ((cnt < timeout) && (req_status &
> CLKMGR_MEM_REQ_SET_MSK)) {
> +		if (pll =3D=3D MEMBUS_MAINPLL)
> +			req_status =3D CM_REG_READL(plat,
> CLKMGR_MAINPLL_MEM);
> +		else
> +			req_status =3D CM_REG_READL(plat,
> CLKMGR_PERPLL_MEM);
> +		cnt++;
> +	}
> +
> +	if (cnt >=3D timeout)
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}
> +
> +static int membus_write_pll(struct socfpga_clk_plat *plat, u32 pll,
> +			    u32 addr_offset, u32 wdat, int timeout)
> +{
> +	u32 addr;
> +	u32 val;
> +
> +	addr =3D ((addr_offset | CLKMGR_MEM_ADDR_START) &
> CLKMGR_MEM_ADDR_MASK);
> +
> +	val =3D (CLKMGR_MEM_REQ_SET_MSK | CLKMGR_MEM_WR_SET_MSK
> |
> +	       (wdat << CLKMGR_MEM_WDAT_LSB_OFFSET) | addr);
> +
> +	if (pll =3D=3D MEMBUS_MAINPLL)
> +		CM_REG_WRITEL(plat, val, CLKMGR_MAINPLL_MEM);
> +	else
> +		CM_REG_WRITEL(plat, val, CLKMGR_PERPLL_MEM);
> +
> +	debug("MEMBUS: Write 0x%08x to addr =3D 0x%08x\n", wdat, addr);
> +
> +	return membus_wait_for_req(plat, pll, timeout);
> +}
> +
> +static int membus_read_pll(struct socfpga_clk_plat *plat, u32 pll,
> +			   u32 addr_offset, u32 *rdata, int timeout)
> +{
> +	u32 addr;
> +	u32 val;
> +
> +	addr =3D ((addr_offset | CLKMGR_MEM_ADDR_START) &
> CLKMGR_MEM_ADDR_MASK);
> +
> +	val =3D ((CLKMGR_MEM_REQ_SET_MSK &
> ~CLKMGR_MEM_WR_SET_MSK) | addr);
> +
> +	if (pll =3D=3D MEMBUS_MAINPLL)
> +		CM_REG_WRITEL(plat, val, CLKMGR_MAINPLL_MEM);
> +	else
> +		CM_REG_WRITEL(plat, val, CLKMGR_PERPLL_MEM);
> +
> +	*rdata =3D 0;
> +
> +	if (membus_wait_for_req(plat, pll, timeout))
> +		return -ETIMEDOUT;
> +
> +	if (pll =3D=3D MEMBUS_MAINPLL)
> +		*rdata =3D CM_REG_READL(plat, CLKMGR_MAINPLL_MEMSTAT);
> +	else
> +		*rdata =3D CM_REG_READL(plat, CLKMGR_PERPLL_MEMSTAT);
> +
> +	debug("MEMBUS: Read 0x%08x from addr =3D 0x%08x\n", *rdata, addr);
> +
> +	return 0;
> +}
> +
> +static void membus_pll_configs(struct socfpga_clk_plat *plat, u32 pll)
> +{
> +	int i;
> +	u32 rdata;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(membus_pll); i++) {
> +		membus_read_pll(plat, pll, membus_pll[i].reg,
> +				&rdata, MEMBUS_TIMEOUT);
> +		membus_write_pll(plat, pll, membus_pll[i].reg,
> +			 ((rdata & ~membus_pll[i].mask) | membus_pll[i].val),
> +			 MEMBUS_TIMEOUT);
> +	}
> +}
> +
> +static u32 calc_vocalib_pll(u32 pllm, u32 pllglob)
> +{
> +	u32 mdiv, refclkdiv, arefclkdiv, drefclkdiv, mscnt, hscnt, vcocalib;
> +
> +	mdiv =3D pllm & CLKMGR_PLLM_MDIV_MASK;
> +	arefclkdiv =3D (pllglob & CLKMGR_PLLGLOB_AREFCLKDIV_MASK) >>
> +		      CLKMGR_PLLGLOB_AREFCLKDIV_OFFSET;
> +	drefclkdiv =3D (pllglob & CLKMGR_PLLGLOB_DREFCLKDIV_MASK) >>
> +		      CLKMGR_PLLGLOB_DREFCLKDIV_OFFSET;
> +	refclkdiv =3D (pllglob & CLKMGR_PLLGLOB_REFCLKDIV_MASK) >>
> +		     CLKMGR_PLLGLOB_REFCLKDIV_OFFSET;
> +	mscnt =3D CLKMGR_VCOCALIB_MSCNT_CONST / (mdiv * BIT(drefclkdiv));
> +	if (!mscnt)
> +		mscnt =3D 1;
> +	hscnt =3D (mdiv * mscnt * BIT(drefclkdiv) / refclkdiv) -
> +		CLKMGR_VCOCALIB_HSCNT_CONST;
> +	vcocalib =3D (hscnt & CLKMGR_VCOCALIB_HSCNT_MASK) |
> +		   ((mscnt << CLKMGR_VCOCALIB_MSCNT_OFFSET) &
> +		     CLKMGR_VCOCALIB_MSCNT_MASK);
> +
> +	/* Dump all the pll calibration settings for debug purposes */
> +	debug("mdiv          : %d\n", mdiv);
> +	debug("arefclkdiv    : %d\n", arefclkdiv);
> +	debug("drefclkdiv    : %d\n", drefclkdiv);
> +	debug("refclkdiv     : %d\n", refclkdiv);
> +	debug("mscnt         : %d\n", mscnt);
> +	debug("hscnt         : %d\n", hscnt);
> +	debug("vcocalib      : 0x%08x\n", vcocalib);
> +
> +	return vcocalib;
> +}
> +
> +/*
> + * Setup clocks while making no assumptions about previous state of the
> clocks.
> + */
> +static void clk_basic_init(struct udevice *dev,
> +			   const struct cm_config * const cfg)
> +{
> +	struct socfpga_clk_plat *plat =3D dev_get_plat(dev);
> +	u32 vcocalib;
> +
> +	if (!cfg)
> +		return;
> +
> +	if (IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5_EMU)) {
> +		/* Take both PLL out of reset and power up */
> +		CM_REG_SETBITS(plat, CLKMGR_MAINPLL_PLLGLOB,
> +			       CLKMGR_PLLGLOB_PD_MASK |
> CLKMGR_PLLGLOB_RST_MASK);
> +		CM_REG_SETBITS(plat, CLKMGR_PERPLL_PLLGLOB,
> +			       CLKMGR_PLLGLOB_PD_MASK |
> CLKMGR_PLLGLOB_RST_MASK);
> +
> +		cm_wait_for_lock(CLKMGR_STAT_ALLPLL_LOCKED_MASK);
> +
> +		/* Put both PLLs in bypass */
> +		clk_write_bypass_mainpll(plat,
> CLKMGR_BYPASS_MAINPLL_ALL);
> +		clk_write_bypass_perpll(plat, CLKMGR_BYPASS_PERPLL_ALL);
> +
> +		/* Take all PLLs out of bypass */
> +		clk_write_bypass_mainpll(plat, 0);
> +		clk_write_bypass_perpll(plat, 0);
> +
> +		/* Out of boot mode */
> +		clk_write_ctrl(plat,
> +			       CM_REG_READL(plat, CLKMGR_CTRL) &
> ~CLKMGR_CTRL_BOOTMODE);
> +	} else {
> +#ifdef CONFIG_SPL_BUILD
> +		/* Always force clock manager into boot mode before any
> configuration */
> +		clk_write_ctrl(plat,
> +			       CM_REG_READL(plat, CLKMGR_CTRL) |
> CLKMGR_CTRL_BOOTMODE);
> +#else
> +		/* Skip clock configuration in SSBL if it's not in boot mode */
> +		if (!(CM_REG_READL(plat, CLKMGR_CTRL) &
> CLKMGR_CTRL_BOOTMODE))
> +			return;
> +#endif
> +
> +		/* Put both PLLs in bypass */
> +		clk_write_bypass_mainpll(plat,
> CLKMGR_BYPASS_MAINPLL_ALL);
> +		clk_write_bypass_perpll(plat, CLKMGR_BYPASS_PERPLL_ALL);
> +
> +		/* Put both PLLs in Reset and Power Down */
> +		CM_REG_CLRBITS(plat, CLKMGR_MAINPLL_PLLGLOB,
> +			       CLKMGR_PLLGLOB_PD_MASK |
> CLKMGR_PLLGLOB_RST_MASK);
> +		CM_REG_CLRBITS(plat, CLKMGR_PERPLL_PLLGLOB,
> +			       CLKMGR_PLLGLOB_PD_MASK |
> CLKMGR_PLLGLOB_RST_MASK);
> +
> +		/* setup main PLL dividers where calculate the vcocalib value
> */
> +		vcocalib =3D calc_vocalib_pll(cfg->main_pll_pllm, cfg-
> >main_pll_pllglob);
> +		CM_REG_WRITEL(plat, cfg->main_pll_pllglob &
> ~CLKMGR_PLLGLOB_RST_MASK,
> +			      CLKMGR_MAINPLL_PLLGLOB);
> +		CM_REG_WRITEL(plat, cfg->main_pll_fdbck,
> CLKMGR_MAINPLL_FDBCK);
> +		CM_REG_WRITEL(plat, vcocalib,
> CLKMGR_MAINPLL_VCOCALIB);
> +		CM_REG_WRITEL(plat, cfg->main_pll_pllc0,
> CLKMGR_MAINPLL_PLLC0);
> +		CM_REG_WRITEL(plat, cfg->main_pll_pllc1,
> CLKMGR_MAINPLL_PLLC1);
> +		CM_REG_WRITEL(plat, cfg->main_pll_pllc2,
> CLKMGR_MAINPLL_PLLC2);
> +		CM_REG_WRITEL(plat, cfg->main_pll_pllc3,
> CLKMGR_MAINPLL_PLLC3);
> +		CM_REG_WRITEL(plat, cfg->main_pll_pllm,
> CLKMGR_MAINPLL_PLLM);
> +		CM_REG_WRITEL(plat, cfg->main_pll_nocclk,
> CLKMGR_MAINPLL_NOCCLK);
> +		CM_REG_WRITEL(plat, cfg->main_pll_nocdiv,
> CLKMGR_MAINPLL_NOCDIV);
> +
> +		/* setup peripheral PLL dividers where calculate the vcocalib
> value */
> +		vcocalib =3D calc_vocalib_pll(cfg->per_pll_pllm, cfg-
> >per_pll_pllglob);
> +		CM_REG_WRITEL(plat, cfg->per_pll_pllglob &
> ~CLKMGR_PLLGLOB_RST_MASK,
> +			      CLKMGR_PERPLL_PLLGLOB);
> +		CM_REG_WRITEL(plat, cfg->per_pll_fdbck,
> CLKMGR_PERPLL_FDBCK);
> +		CM_REG_WRITEL(plat, vcocalib, CLKMGR_PERPLL_VCOCALIB);
> +		CM_REG_WRITEL(plat, cfg->per_pll_pllc0,
> CLKMGR_PERPLL_PLLC0);
> +		CM_REG_WRITEL(plat, cfg->per_pll_pllc1,
> CLKMGR_PERPLL_PLLC1);
> +		CM_REG_WRITEL(plat, cfg->per_pll_pllc2,
> CLKMGR_PERPLL_PLLC2);
> +		CM_REG_WRITEL(plat, cfg->per_pll_pllc3,
> CLKMGR_PERPLL_PLLC3);
> +		CM_REG_WRITEL(plat, cfg->per_pll_pllm,
> CLKMGR_PERPLL_PLLM);
> +		CM_REG_WRITEL(plat, cfg->per_pll_emacctl,
> CLKMGR_PERPLL_EMACCTL);
> +		CM_REG_WRITEL(plat, cfg->per_pll_gpiodiv,
> CLKMGR_PERPLL_GPIODIV);
> +
> +		/* Configure ping pong counters in control group */
> +		CM_REG_WRITEL(plat, cfg->ctl_emacactr,
> CLKMGR_CTL_EMACACTR);
> +		CM_REG_WRITEL(plat, cfg->ctl_emacbctr,
> CLKMGR_CTL_EMACBCTR);
> +		CM_REG_WRITEL(plat, cfg->ctl_emacptpctr,
> CLKMGR_CTL_EMACPTPCTR);
> +		CM_REG_WRITEL(plat, cfg->ctl_gpiodbctr,
> CLKMGR_CTL_GPIODBCTR);
> +		CM_REG_WRITEL(plat, cfg->ctl_s2fuser0ctr,
> CLKMGR_CTL_S2FUSER0CTR);
> +		CM_REG_WRITEL(plat, cfg->ctl_s2fuser1ctr,
> CLKMGR_CTL_S2FUSER1CTR);
> +		CM_REG_WRITEL(plat, cfg->ctl_psirefctr,
> CLKMGR_CTL_PSIREFCTR);
> +		CM_REG_WRITEL(plat, cfg->ctl_usb31ctr,
> CLKMGR_CTL_USB31CTR);
> +		CM_REG_WRITEL(plat, cfg->ctl_dsuctr,
> CLKMGR_CTL_DSUCTR);
> +		CM_REG_WRITEL(plat, cfg->ctl_core01ctr,
> CLKMGR_CTL_CORE01CTR);
> +		CM_REG_WRITEL(plat, cfg->ctl_core23ctr,
> CLKMGR_CTL_CORE23CTR);
> +		CM_REG_WRITEL(plat, cfg->ctl_core2ctr,
> CLKMGR_CTL_CORE2CTR);
> +		CM_REG_WRITEL(plat, cfg->ctl_core3ctr,
> CLKMGR_CTL_CORE3CTR);
> +
> +		/* Take both PLL out of reset and power up */
> +		CM_REG_SETBITS(plat, CLKMGR_MAINPLL_PLLGLOB,
> +			       CLKMGR_PLLGLOB_PD_MASK |
> CLKMGR_PLLGLOB_RST_MASK);
> +		CM_REG_SETBITS(plat, CLKMGR_PERPLL_PLLGLOB,
> +			       CLKMGR_PLLGLOB_PD_MASK |
> CLKMGR_PLLGLOB_RST_MASK);
> +
> +		/* Membus programming for mainpll */
> +		membus_pll_configs(plat, MEMBUS_MAINPLL);
> +		/* Membus programming for peripll */
> +		membus_pll_configs(plat, MEMBUS_PERPLL);
> +
> +		/* Enable Main pll clkslices */
> +		CM_REG_WRITEL(plat, CM_REG_READL(plat,
> CLKMGR_MAINPLL_PLLC0) |
> +				CLKMGR_PLLCX_EN_SET_MSK,
> +				CLKMGR_MAINPLL_PLLC0);
> +		CM_REG_WRITEL(plat, CM_REG_READL(plat,
> CLKMGR_MAINPLL_PLLC1) |
> +				CLKMGR_PLLCX_EN_SET_MSK,
> +				CLKMGR_MAINPLL_PLLC1);
> +		CM_REG_WRITEL(plat, CM_REG_READL(plat,
> CLKMGR_MAINPLL_PLLC2) |
> +				CLKMGR_PLLCX_EN_SET_MSK,
> +				CLKMGR_MAINPLL_PLLC2);
> +		CM_REG_WRITEL(plat, CM_REG_READL(plat,
> CLKMGR_MAINPLL_PLLC3) |
> +				CLKMGR_PLLCX_EN_SET_MSK,
> +				CLKMGR_MAINPLL_PLLC3);
> +
> +		/* Enable Periph pll clkslices */
> +		CM_REG_WRITEL(plat, CM_REG_READL(plat,
> CLKMGR_PERPLL_PLLC0) |
> +				CLKMGR_PLLCX_EN_SET_MSK,
> +				CLKMGR_PERPLL_PLLC0);
> +		CM_REG_WRITEL(plat, CM_REG_READL(plat,
> CLKMGR_PERPLL_PLLC1) |
> +				CLKMGR_PLLCX_EN_SET_MSK,
> +				CLKMGR_PERPLL_PLLC1);
> +		CM_REG_WRITEL(plat, CM_REG_READL(plat,
> CLKMGR_PERPLL_PLLC2) |
> +				CLKMGR_PLLCX_EN_SET_MSK,
> +				CLKMGR_PERPLL_PLLC2);
> +		CM_REG_WRITEL(plat, CM_REG_READL(plat,
> CLKMGR_PERPLL_PLLC3) |
> +				CLKMGR_PLLCX_EN_SET_MSK,
> +				CLKMGR_PERPLL_PLLC3);
> +
> +		cm_wait_for_lock(CLKMGR_STAT_ALLPLL_LOCKED_MASK);
> +
> +		CM_REG_WRITEL(plat, CLKMGR_LOSTLOCK_SET_MASK,
> CLKMGR_MAINPLL_LOSTLOCK);
> +		CM_REG_WRITEL(plat, CLKMGR_LOSTLOCK_SET_MASK,
> CLKMGR_PERPLL_LOSTLOCK);
> +
> +		CM_REG_WRITEL(plat, CM_REG_READL(plat,
> CLKMGR_MAINPLL_PLLGLOB) |
> +
> 	CLKMGR_PLLGLOB_CLR_LOSTLOCK_BYPASS_MASK,
> +				CLKMGR_MAINPLL_PLLGLOB);
> +		CM_REG_WRITEL(plat, CM_REG_READL(plat,
> CLKMGR_PERPLL_PLLGLOB) |
> +
> 	CLKMGR_PLLGLOB_CLR_LOSTLOCK_BYPASS_MASK,
> +				CLKMGR_PERPLL_PLLGLOB);
> +
> +		/* Take all PLLs out of bypass */
> +		clk_write_bypass_mainpll(plat, 0);
> +		clk_write_bypass_perpll(plat, 0);
> +
> +		/* Clear the loss of lock bits (write 1 to clear) */
> +		CM_REG_CLRBITS(plat, CLKMGR_INTRCLR,
> +			       CLKMGR_INTER_PERPLLLOST_MASK |
> +			       CLKMGR_INTER_MAINPLLLOST_MASK);
> +
> +		/* Take all ping pong counters out of reset */
> +		CM_REG_CLRBITS(plat, CLKMGR_CTL_EXTCNTRST,
> +			       CLKMGR_CTL_EXTCNTRST_ALLCNTRST);
> +
> +#ifdef COUNTER_FREQUENCY_REAL
> +	u32 cntfrq =3D COUNTER_FREQUENCY_REAL;
> +	u32 counter_freq =3D 0;
> +
> +	/* Update with accurate clock frequency */
> +	if (current_el() =3D=3D 3) {
> +		asm volatile("msr cntfrq_el0, %0" : : "r" (cntfrq) : "memory");
> +		asm volatile("mrs %0, cntfrq_el0" : "=3Dr" (counter_freq));
> +		debug("Counter freq =3D 0x%x\n", counter_freq);
> +	}
> +#endif
> +
> +		/* Out of boot mode */
> +		clk_write_ctrl(plat,
> +			       CM_REG_READL(plat, CLKMGR_CTRL) &
> ~CLKMGR_CTRL_BOOTMODE);
> +	}
> +}
> +
> +static u64 clk_get_vco_clk_hz(struct socfpga_clk_plat *plat,
> +			      u32 pllglob_reg, u32 pllm_reg)
> +{
> +	 u64 fref, arefdiv, mdiv, reg, vco;
> +
> +	reg =3D CM_REG_READL(plat, pllglob_reg);
> +
> +	fref =3D (reg & CLKMGR_PLLGLOB_VCO_PSRC_MASK) >>
> +		CLKMGR_PLLGLOB_VCO_PSRC_OFFSET;
> +
> +	switch (fref) {
> +	case CLKMGR_VCO_PSRC_EOSC1:
> +		fref =3D cm_get_osc_clk_hz();
> +		break;
> +	case CLKMGR_VCO_PSRC_INTOSC:
> +		fref =3D cm_get_intosc_clk_hz();
> +		break;
> +	case CLKMGR_VCO_PSRC_F2S:
> +		fref =3D cm_get_fpga_clk_hz();
> +		break;
> +	}
> +
> +	arefdiv =3D (reg & CLKMGR_PLLGLOB_AREFCLKDIV_MASK) >>
> +		   CLKMGR_PLLGLOB_AREFCLKDIV_OFFSET;
> +
> +	mdiv =3D CM_REG_READL(plat, pllm_reg) &
> CLKMGR_PLLM_MDIV_MASK;
> +
> +	vco =3D fref / arefdiv;
> +	vco =3D vco * mdiv;
> +
> +	return vco;
> +}
> +
> +static u64 clk_get_main_vco_clk_hz(struct socfpga_clk_plat *plat)
> +{
> +	return clk_get_vco_clk_hz(plat, CLKMGR_MAINPLL_PLLGLOB,
> +				 CLKMGR_MAINPLL_PLLM);
> +}
> +
> +static u64 clk_get_per_vco_clk_hz(struct socfpga_clk_plat *plat)
> +{
> +	return clk_get_vco_clk_hz(plat, CLKMGR_PERPLL_PLLGLOB,
> +				 CLKMGR_PERPLL_PLLM);
> +}
> +
> +static u32 clk_get_5_1_clk_src(struct socfpga_clk_plat *plat, u64 reg)
> +{
> +	u32 clksrc =3D CM_REG_READL(plat, reg);
> +
> +	return (clksrc & CLKMGR_CLKSRC_MASK) >>
> CLKMGR_CLKSRC_OFFSET;
> +}
> +
> +static u64 clk_get_clksrc_hz(struct socfpga_clk_plat *plat, u32 clksrc_r=
eg,
> +			     u32 main_reg, u32 per_reg)
> +{
> +	u64 clock;
> +	u32 clklsrc =3D clk_get_5_1_clk_src(plat, clksrc_reg);
> +
> +	switch (clklsrc) {
> +	case CLKMGR_CLKSRC_MAIN:
> +		clock =3D clk_get_main_vco_clk_hz(plat);
> +		clock /=3D (CM_REG_READL(plat, main_reg) &
> +			  CLKMGR_CLKCNT_MSK);
> +		break;
> +
> +	case CLKMGR_CLKSRC_PER:
> +		clock =3D clk_get_per_vco_clk_hz(plat);
> +		clock /=3D (CM_REG_READL(plat, per_reg) &
> +			  CLKMGR_CLKCNT_MSK);
> +		break;
> +
> +	case CLKMGR_CLKSRC_OSC1:
> +		clock =3D cm_get_osc_clk_hz();
> +		break;
> +
> +	case CLKMGR_CLKSRC_INTOSC:
> +		clock =3D cm_get_intosc_clk_hz();
> +		break;
> +
> +	case CLKMGR_CLKSRC_FPGA:
> +		clock =3D cm_get_fpga_clk_hz();
> +		break;
> +	default:
> +		return 0;
> +	}
> +
> +	return clock;
> +}
> +
> +static u64 clk_get_mpu_clk_hz(struct socfpga_clk_plat *plat)
> +{
> +	u64 clock;
> +	u32 ctr_reg;
> +	u32 cpu =3D ((read_mpidr() >> MPIDR_AFF1_OFFSET) &
> MPIDR_AFF1_OFFSET);
> +
> +	if (cpu > CORE1) {
> +		ctr_reg =3D CLKMGR_CTL_CORE23CTR;
> +
> +		clock =3D clk_get_clksrc_hz(plat, ctr_reg,
> +					  CLKMGR_MAINPLL_PLLC0,
> +					  CLKMGR_PERPLL_PLLC0);
> +	} else {
> +		ctr_reg =3D CLKMGR_CTL_CORE01CTR;
> +
> +		clock =3D clk_get_clksrc_hz(plat, ctr_reg,
> +					  CLKMGR_MAINPLL_PLLC1,
> +					  CLKMGR_PERPLL_PLLC0);
> +	}
> +
> +	if (cpu =3D=3D CORE3)
> +		ctr_reg =3D CLKMGR_CTL_CORE3CTR;
> +	else if (cpu =3D=3D CORE2)
> +		ctr_reg =3D CLKMGR_CTL_CORE2CTR;
> +	else
> +		ctr_reg =3D CLKMGR_CTL_CORE01CTR;
> +
> +	clock /=3D 1 + (CM_REG_READL(plat, ctr_reg) &
> +		 CLKMGR_CLKCNT_MSK);
> +
> +	return clock;
> +}
> +
> +static u32 clk_get_l3_main_clk_hz(struct socfpga_clk_plat *plat)
> +{
> +	return clk_get_clksrc_hz(plat, CLKMGR_MAINPLL_NOCCLK,
> +				      CLKMGR_MAINPLL_PLLC3,
> +				      CLKMGR_PERPLL_PLLC1);
> +}
> +
> +static u32 clk_get_l4_main_clk_hz(struct socfpga_clk_plat *plat)
> +{
> +	u64 clock =3D clk_get_l3_main_clk_hz(plat);
> +
> +	return clock;
> +}
> +
> +static u32 clk_get_l4_sp_clk_hz(struct socfpga_clk_plat *plat)
> +{
> +	u64 clock =3D clk_get_l3_main_clk_hz(plat);
> +	clock /=3D BIT((CM_REG_READL(plat, CLKMGR_MAINPLL_NOCDIV) >>
> +		      CLKMGR_NOCDIV_L4SPCLK_OFFSET) &
> +		      CLKMGR_NOCDIV_DIVIDER_MASK);
> +
> +	return clock;
> +}
> +
> +static u32 clk_get_l4_mp_clk_hz(struct socfpga_clk_plat *plat)
> +{
> +	u64 clock =3D clk_get_l3_main_clk_hz(plat);
> +
> +	clock /=3D BIT((CM_REG_READL(plat, CLKMGR_MAINPLL_NOCDIV) >>
> +		      CLKMGR_NOCDIV_L4MPCLK_OFFSET) &
> +		      CLKMGR_NOCDIV_DIVIDER_MASK);
> +
> +	return clock;
> +}
> +
> +static u32 clk_get_sdmmc_clk_hz(struct socfpga_clk_plat *plat)
> +{
> +	u64 clock =3D clk_get_l4_mp_clk_hz(plat);
> +
> +	clock /=3D BIT((CM_REG_READL(plat, CLKMGR_MAINPLL_NOCDIV) >>
> +		      CLKMGR_NOCDIV_SOFTPHY_OFFSET) &
> +		      CLKMGR_NOCDIV_DIVIDER_MASK);
> +
> +	return clock;
> +}
> +
> +static u32 clk_get_l4_sys_free_clk_hz(struct socfpga_clk_plat *plat)
> +{
> +	if (CM_REG_READL(plat, CLKMGR_STAT) &
> CLKMGR_STAT_BOOTMODE)
> +		return clk_get_l3_main_clk_hz(plat) / 2;
> +
> +	return clk_get_l3_main_clk_hz(plat) / 4;
> +}
> +
> +static u32 clk_get_emac_clk_hz(struct socfpga_clk_plat *plat, u32 emac_i=
d)
> +{
> +	u32 ctl;
> +	u32 ctr_reg;
> +	u32 clock;
> +	u32 div;
> +	u32 reg;
> +
> +	if (emac_id =3D=3D AGILEX5_EMAC_PTP_CLK) {
> +		reg =3D CM_REG_READL(plat, CLKMGR_CTL_EMACPTPCTR);
> +		ctr_reg =3D CLKMGR_CTL_EMACPTPCTR;
> +	} else {
> +		reg =3D CM_REG_READL(plat, CLKMGR_CTL_EMACACTR);
> +		ctl =3D CM_REG_READL(plat, CLKMGR_PERPLL_EMACCTL);
> +		if (emac_id =3D=3D AGILEX5_EMAC0_CLK)
> +			ctl =3D (ctl &
> CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_MASK) >>
> +
> 	CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_OFFSET;
> +		else if (emac_id =3D=3D AGILEX5_EMAC1_CLK)
> +			ctl =3D (ctl &
> CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_MASK) >>
> +
> 	CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_OFFSET;
> +		else if (emac_id =3D=3D AGILEX5_EMAC2_CLK)
> +			ctl =3D (ctl &
> CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_MASK) >>
> +
> 	CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_OFFSET;
> +		else
> +			return 0;
> +
> +		if (ctl) {
> +			/* EMAC B source */
> +			ctr_reg =3D CLKMGR_CTL_EMACBCTR;
> +		} else {
> +			/* EMAC A source */
> +			ctr_reg =3D CLKMGR_CTL_EMACACTR;
> +		}
> +	}
> +	/* Get EMAC clock source */
> +	clock =3D (reg & CLKMGR_CTL_EMACCTR_SRC_MASK)
> +		 >> CLKMGR_CTL_EMACCTR_SRC_OFFSET;
> +
> +	reg =3D CM_REG_READL(plat, ctr_reg);
> +	div =3D (reg & CLKMGR_CTL_EMACCTR_CNT_MASK)
> +		>> CLKMGR_CTL_EMACCTR_CNT_OFFSET;
> +
> +	switch (clock) {
> +	case CLKMGR_CLKSRC_MAIN:
> +		clock =3D clk_get_main_vco_clk_hz(plat);
> +
> +		if (emac_id =3D=3D AGILEX5_EMAC_PTP_CLK) {
> +			clock /=3D (CM_REG_READL(plat,
> CLKMGR_MAINPLL_PLLC3) &
> +				  CLKMGR_CLKCNT_MSK);
> +		} else {
> +			clock /=3D (CM_REG_READL(plat,
> CLKMGR_MAINPLL_PLLC1) &
> +				  CLKMGR_CLKCNT_MSK);
> +		}
> +		break;
> +
> +	case CLKMGR_CLKSRC_PER:
> +		clock =3D clk_get_per_vco_clk_hz(plat);
> +
> +		clock /=3D (CM_REG_READL(plat, CLKMGR_PERPLL_PLLC3) &
> +			  CLKMGR_CLKCNT_MSK);
> +		break;
> +
> +	case CLKMGR_CLKSRC_OSC1:
> +		clock =3D cm_get_osc_clk_hz();
> +		break;
> +
> +	case CLKMGR_CLKSRC_INTOSC:
> +		clock =3D cm_get_intosc_clk_hz();
> +		break;
> +
> +	case CLKMGR_CLKSRC_FPGA:
> +		clock =3D cm_get_fpga_clk_hz();
> +		break;
> +	}
> +
> +	clock /=3D 1 + div;
> +
> +	return clock;
> +}
> +
> +static ulong socfpga_clk_get_rate(struct clk *clk)
> +{
> +	struct socfpga_clk_plat *plat =3D dev_get_plat(clk->dev);
> +
> +	switch (clk->id) {
> +	case AGILEX5_MPU_CLK:
> +		return clk_get_mpu_clk_hz(plat);
> +	case AGILEX5_L4_MAIN_CLK:
> +		return clk_get_l4_main_clk_hz(plat);
> +	case AGILEX5_L4_SYS_FREE_CLK:
> +		return clk_get_l4_sys_free_clk_hz(plat);
> +	case AGILEX5_L4_MP_CLK:
> +		return clk_get_l4_mp_clk_hz(plat);
> +	case AGILEX5_L4_SP_CLK:
> +		return clk_get_l4_sp_clk_hz(plat);
> +	case AGILEX5_SDMMC_CLK:
> +	case AGILEX5_NAND_CLK:
> +		return clk_get_sdmmc_clk_hz(plat);
> +	case AGILEX5_EMAC0_CLK:
> +	case AGILEX5_EMAC1_CLK:
> +	case AGILEX5_EMAC2_CLK:
> +	case AGILEX5_EMAC_PTP_CLK:
> +		return clk_get_emac_clk_hz(plat, clk->id);
> +	case AGILEX5_USB_CLK:
> +	case AGILEX5_NAND_X_CLK:
> +		return clk_get_l4_mp_clk_hz(plat);
> +	default:
> +		return -ENXIO;
> +	}
> +}
> +
> +static int socfpga_clk_enable(struct clk *clk)
> +{
> +	return 0;
> +}
> +
> +static int socfpga_clk_probe(struct udevice *dev)
> +{
> +	const struct cm_config *cm_default_cfg =3D cm_get_default_config();
> +
> +	clk_basic_init(dev, cm_default_cfg);
> +
> +	return 0;
> +}
> +
> +static int socfpga_clk_of_to_plat(struct udevice *dev)
> +{
> +	struct socfpga_clk_plat *plat =3D dev_get_plat(dev);
> +	fdt_addr_t addr;
> +
> +	addr =3D dev_read_addr(dev);
> +	if (addr =3D=3D FDT_ADDR_T_NONE)
> +		return -EINVAL;
> +	plat->regs =3D (void __iomem *)addr;
> +
> +	return 0;
> +}
> +
> +static struct clk_ops socfpga_clk_ops =3D {
> +	.enable		=3D socfpga_clk_enable,
> +	.get_rate	=3D socfpga_clk_get_rate,
> +};
> +
> +static const struct udevice_id socfpga_clk_match[] =3D {
> +	{ .compatible =3D "intel,agilex5-clkmgr" },
> +	{}
> +};
> +
> +U_BOOT_DRIVER(socfpga_agilex5_clk) =3D {
> +	.name		=3D "clk-agilex5",
> +	.id		=3D UCLASS_CLK,
> +	.of_match	=3D socfpga_clk_match,
> +	.ops		=3D &socfpga_clk_ops,
> +	.probe		=3D socfpga_clk_probe,
> +	.of_to_plat =3D socfpga_clk_of_to_plat,
> +	.plat_auto	=3D sizeof(struct socfpga_clk_plat),
> +};
> diff --git a/drivers/clk/altera/clk-agilex5.h b/drivers/clk/altera/clk-ag=
ilex5.h
> new file mode 100644
> index 0000000000..a4ddc1a60d
> --- /dev/null
> +++ b/drivers/clk/altera/clk-agilex5.h
> @@ -0,0 +1,284 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2024 Intel Corporation <www.intel.com>
> + */
> +
> +#ifndef	_CLK_AGILEX5_
> +#define	_CLK_AGILEX5_
> +
> +#ifndef __ASSEMBLY__
> +#include <linux/bitops.h>
> +#endif
> +
> +#define CORE0		1
> +#define CORE1		2
> +#define CORE2		3
> +#define CORE3		4
> +
> +/* Derived from l4_main_clk (PSS clock) */
> +#define COUNTER_FREQUENCY_REAL	400000000
> +
> +#define CM_REG_READL(plat, reg)				\
> +	readl((plat)->regs + (reg))
> +
> +#define CM_REG_WRITEL(plat, data, reg)			\
> +	writel(data, (plat)->regs + (reg))
> +
> +#define CM_REG_CLRBITS(plat, reg, clear)		\
> +	clrbits_le32((plat)->regs + (reg), (clear))
> +
> +#define CM_REG_SETBITS(plat, reg, set)			\
> +	setbits_le32((plat)->regs + (reg), (set))
> +
> +struct cm_config {
> +	/* main group */
> +	u32 main_pll_nocclk;
> +	u32 main_pll_nocdiv;
> +	u32 main_pll_pllglob;
> +	u32 main_pll_fdbck;
> +	u32 main_pll_pllc0;
> +	u32 main_pll_pllc1;
> +	u32 main_pll_pllc2;
> +	u32 main_pll_pllc3;
> +	u32 main_pll_pllm;
> +
> +	/* peripheral group */
> +	u32 per_pll_emacctl;
> +	u32 per_pll_gpiodiv;
> +	u32 per_pll_pllglob;
> +	u32 per_pll_fdbck;
> +	u32 per_pll_pllc0;
> +	u32 per_pll_pllc1;
> +	u32 per_pll_pllc2;
> +	u32 per_pll_pllc3;
> +	u32 per_pll_pllm;
> +
> +	/* control group */
> +	u32 ctl_emacactr;
> +	u32 ctl_emacbctr;
> +	u32 ctl_emacptpctr;
> +	u32 ctl_gpiodbctr;
> +	u32 ctl_s2fuser0ctr;
> +	u32 ctl_s2fuser1ctr;
> +	u32 ctl_psirefctr;
> +	u32 ctl_usb31ctr;
> +	u32 ctl_dsuctr;
> +	u32 ctl_core01ctr;
> +	u32 ctl_core23ctr;
> +	u32 ctl_core2ctr;
> +	u32 ctl_core3ctr;
> +
> +	/* incoming clock */
> +	u32 hps_osc_clk_hz;
> +	u32 fpga_clk_hz;
> +	u32 spare[3];
> +};
> +
> +/* Clock Manager registers */
> +#define CLKMGR_CTRL				0
> +#define CLKMGR_STAT				4
> +#define CLKMGR_TESTIOCTRL			8
> +#define CLKMGR_INTRGEN				0x0c
> +#define CLKMGR_INTRMSK				0x10
> +#define CLKMGR_INTRCLR				0x14
> +#define CLKMGR_INTRSTS				0x18
> +#define CLKMGR_INTRSTK				0x1c
> +#define CLKMGR_INTRRAW				0x20
> +
> +/* Clock Manager Main PPL group registers */
> +#define CLKMGR_MAINPLL_EN			0x24
> +#define CLKMGR_MAINPLL_ENS			0x28
> +#define CLKMGR_MAINPLL_ENR			0x2c
> +#define CLKMGR_MAINPLL_BYPASS			0x30
> +#define CLKMGR_MAINPLL_BYPASSS			0x34
> +#define CLKMGR_MAINPLL_BYPASSR			0x38
> +#define CLKMGR_MAINPLL_NOCCLK			0x40
> +#define CLKMGR_MAINPLL_NOCDIV			0x44
> +#define CLKMGR_MAINPLL_PLLGLOB			0x48
> +#define CLKMGR_MAINPLL_FDBCK			0x4c
> +#define CLKMGR_MAINPLL_MEM			0x50
> +#define CLKMGR_MAINPLL_MEMSTAT			0x54
> +#define CLKMGR_MAINPLL_VCOCALIB			0x58
> +#define CLKMGR_MAINPLL_PLLC0			0x5c
> +#define CLKMGR_MAINPLL_PLLC1			0x60
> +#define CLKMGR_MAINPLL_PLLC2			0x64
> +#define CLKMGR_MAINPLL_PLLC3			0x68
> +#define CLKMGR_MAINPLL_PLLM			0x6c
> +#define CLKMGR_MAINPLL_FHOP			0x70
> +#define CLKMGR_MAINPLL_SSC			0x74
> +#define CLKMGR_MAINPLL_LOSTLOCK			0x78
> +
> +/* Clock Manager Peripheral PPL group registers */
> +#define CLKMGR_PERPLL_EN			0x7c
> +#define CLKMGR_PERPLL_ENS			0x80
> +#define CLKMGR_PERPLL_ENR			0x84
> +#define CLKMGR_PERPLL_BYPASS			0x88
> +#define CLKMGR_PERPLL_BYPASSS			0x8c
> +#define CLKMGR_PERPLL_BYPASSR			0x90
> +#define CLKMGR_PERPLL_EMACCTL			0x94
> +#define CLKMGR_PERPLL_GPIODIV			0x98
> +#define CLKMGR_PERPLL_PLLGLOB			0x9c
> +#define CLKMGR_PERPLL_FDBCK			0xa0
> +#define CLKMGR_PERPLL_MEM			0xa4
> +#define CLKMGR_PERPLL_MEMSTAT			0xa8
> +#define CLKMGR_PERPLL_VCOCALIB			0xac
> +#define CLKMGR_PERPLL_PLLC0			0xb0
> +#define CLKMGR_PERPLL_PLLC1			0xb4
> +#define CLKMGR_PERPLL_PLLC2			0xb8
> +#define CLKMGR_PERPLL_PLLC3			0xbc
> +#define CLKMGR_PERPLL_PLLM			0xc0
> +#define CLKMGR_PERPLL_FHOP			0xc4
> +#define CLKMGR_PERPLL_SSC			0xc8
> +#define CLKMGR_PERPLL_LOSTLOCK			0xcc
> +
> +/* Clock Manager Control group registers */
> +#define CLKMGR_CTL_JTAG			0xd0
> +#define CLKMGR_CTL_EMACACTR			0xd4
> +#define CLKMGR_CTL_EMACBCTR			0xd8
> +#define CLKMGR_CTL_EMACPTPCTR			0xdc
> +#define CLKMGR_CTL_GPIODBCTR			0xe0
> +#define CLKMGR_CTL_S2FUSER0CTR			0xe8
> +#define CLKMGR_CTL_S2FUSER1CTR			0xec
> +#define CLKMGR_CTL_PSIREFCTR			0xf0
> +#define CLKMGR_CTL_EXTCNTRST			0xf4
> +#define CLKMGR_CTL_USB31CTR				0xf8
> +#define CLKMGR_CTL_DSUCTR				0xfc
> +#define CLKMGR_CTL_CORE01CTR			0x100
> +#define CLKMGR_CTL_CORE23CTR			0x104
> +#define CLKMGR_CTL_CORE2CTR				0x108
> +#define CLKMGR_CTL_CORE3CTR				0x10C
> +
> +#define CLKMGR_CTRL_BOOTMODE			BIT(0)
> +
> +#define CLKMGR_STAT_BUSY			BIT(0)
> +#define CLKMGR_STAT_MAINPLL_LOCKED		BIT(8)
> +#define CLKMGR_STAT_MAIN_TRANS			BIT(9)
> +#define CLKMGR_STAT_PERPLL_LOCKED		BIT(16)
> +#define CLKMGR_STAT_PERF_TRANS			BIT(17)
> +#define CLKMGR_STAT_BOOTMODE			BIT(24)
> +#define CLKMGR_STAT_BOOTCLKSRC			BIT(25)
> +
> +#define CLKMGR_STAT_ALLPLL_LOCKED_MASK		\
> +	(CLKMGR_STAT_MAINPLL_LOCKED | CLKMGR_STAT_PERPLL_LOCKED)
> +
> +#define CLKMGR_INTER_MAINPLLLOCKED_MASK		0x00000001
> +#define CLKMGR_INTER_PERPLLLOCKED_MASK		0x00000002
> +#define CLKMGR_INTER_MAINPLLLOST_MASK		0x00000004
> +#define CLKMGR_INTER_PERPLLLOST_MASK		0x00000008
> +
> +#define CLKMGR_CLKSRC_MASK			GENMASK(18, 16)
> +#define CLKMGR_CLKSRC_OFFSET			16
> +#define CLKMGR_CLKSRC_MAIN			0
> +#define CLKMGR_CLKSRC_PER			1
> +#define CLKMGR_CLKSRC_OSC1			2
> +#define CLKMGR_CLKSRC_INTOSC			3
> +#define CLKMGR_CLKSRC_FPGA			4
> +#define CLKMGR_CLKCNT_MSK			GENMASK(10, 0)
> +
> +#define CLKMGR_BYPASS_MAINPLL_ALL		0xf6
> +#define CLKMGR_BYPASS_PERPLL_ALL		0xef
> +
> +#define CLKMGR_NOCDIV_SOFTPHY_DIV_ONE		0
> +#define CLKMGR_NOCDIV_SOFTPHY_DIV_TWO		1
> +#define CLKMGR_NOCDIV_SOFTPHY_DIV_FOUR		2
> +#define CLKMGR_NOCDIV_L4SYSFREECLK_OFFSET		0
> +#define CLKMGR_NOCDIV_L4MPCLK_OFFSET		4
> +#define CLKMGR_NOCDIV_L4SPCLK_OFFSET		6
> +#define CLKMGR_NOCDIV_SOFTPHY_OFFSET		16
> +#define CLKMGR_NOCDIV_CCU_OFFSET			18
> +#define CLKMGR_NOCDIV_MPUPERIPH_OFFSET		20
> +#define CLKMGR_NOCDIV_CSATCLK_OFFSET		24
> +#define CLKMGR_NOCDIV_CSTRACECLK_OFFSET		26
> +#define CLKMGR_NOCDIV_CSPDBGCLK_OFFSET		28
> +#define CLKMGR_NOCDIV_DIVIDER_MASK		0x3
> +
> +#define CLKMGR_PLLGLOB_PD_MASK				BIT(0)
> +#define CLKMGR_PLLGLOB_RST_MASK				BIT(1)
> +#define CLKMGR_PLLGLOB_AREFCLKDIV_MASK
> 	GENMASK(11, 8)
> +#define CLKMGR_PLLGLOB_DREFCLKDIV_MASK
> 	GENMASK(13, 12)
> +#define CLKMGR_PLLGLOB_REFCLKDIV_MASK			GENMASK(13,
> 8)
> +#define CLKMGR_PLLGLOB_MODCLKDIV_MASK
> 	GENMASK(24, 27)
> +#define CLKMGR_PLLGLOB_AREFCLKDIV_OFFSET		8
> +#define CLKMGR_PLLGLOB_DREFCLKDIV_OFFSET		12
> +#define CLKMGR_PLLGLOB_REFCLKDIV_OFFSET			8
> +#define CLKMGR_PLLGLOB_MODCLKDIV_OFFSET			24
> +#define CLKMGR_PLLGLOB_VCO_PSRC_MASK			GENMASK(17,
> 16)
> +#define CLKMGR_PLLGLOB_VCO_PSRC_OFFSET			16
> +#define CLKMGR_PLLGLOB_CLR_LOSTLOCK_BYPASS_MASK		BIT(29)
> +
> +#define CLKMGR_VCO_PSRC_EOSC1			0
> +#define CLKMGR_VCO_PSRC_INTOSC			1
> +#define CLKMGR_VCO_PSRC_F2S			2
> +
> +#define CLKMGR_MEM_REQ_SET_MSK			BIT(24)
> +#define CLKMGR_MEM_WR_SET_MSK			BIT(25)
> +#define CLKMGR_MEM_ERR_MSK			BIT(26)
> +#define CLKMGR_MEM_WDAT_LSB_OFFSET		16
> +#define CLKMGR_MEM_ADDR_MASK			GENMASK(15, 0)
> +#define CLKMGR_MEM_ADDR_START			0x00004000
> +
> +#define CLKMGR_PLLCX_EN_SET_MSK			BIT(27)
> +#define CLKMGR_PLLCX_MUTE_SET_MSK		BIT(28)
> +
> +#define CLKMGR_VCOCALIB_MSCNT_MASK		GENMASK(23, 16)
> +#define CLKMGR_VCOCALIB_MSCNT_OFFSET		16
> +#define CLKMGR_VCOCALIB_HSCNT_MASK		GENMASK(9, 0)
> +#define CLKMGR_VCOCALIB_MSCNT_CONST		100
> +#define CLKMGR_VCOCALIB_HSCNT_CONST		4
> +
> +#define CLKMGR_PLLM_MDIV_MASK			GENMASK(9, 0)
> +
> +#define CLKMGR_LOSTLOCK_SET_MASK		BIT(0)
> +
> +#define CLKMGR_PERPLLGRP_EN_SDMMCCLK_MASK		BIT(5)
> +#define CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_OFFSET	26
> +#define CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_MASK		BIT(26)
> +#define CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_OFFSET	27
> +#define CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_MASK		BIT(27)
> +#define CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_OFFSET	28
> +#define CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_MASK		BIT(28)
> +
> +#define CLKMGR_CTL_EMACCTR_SRC_OFFSET		16
> +#define CLKMGR_CTL_EMACCTR_SRC_MASK		GENMASK(18, 16)
> +#define CLKMGR_CTL_EMACCTR_CNT_OFFSET		0
> +#define CLKMGR_CTL_EMACCTR_CNT_MASK		GENMASK(10, 0)
> +
> +#define CLKMGR_CTL_EXTCNTRST_EMACACNTRST	BIT(0)
> +#define CLKMGR_CTL_EXTCNTRST_EMACBCNTRST	BIT(1)
> +#define CLKMGR_CTL_EXTCNTRST_EMACPTPCNTRST	BIT(2)
> +#define CLKMGR_CTL_EXTCNTRST_GPIODBCNTRST	BIT(3)
> +#define CLKMGR_CTL_EXTCNTRST_S2FUSER0CNTRST	BIT(5)
> +#define CLKMGR_CTL_EXTCNTRST_S2FUSER1CNTRST	BIT(6)
> +#define CLKMGR_CTL_EXTCNTRST_PSIREFCNTRST	BIT(7)
> +#define CLKMGR_CTL_EXTCNTRST_USB31REFCNTRST	BIT(8)
> +#define CLKMGR_CTL_EXTCNTRST_DSUCNTRST		BIT(10)
> +#define CLKMGR_CTL_EXTCNTRST_CORE01CNTRST	BIT(11)
> +#define CLKMGR_CTL_EXTCNTRST_CORE2CNTRST	BIT(12)
> +#define CLKMGR_CTL_EXTCNTRST_CORE3CNTRST	BIT(13)
> +#define CLKMGR_CTL_EXTCNTRST_ALLCNTRST		\
> +	(CLKMGR_CTL_EXTCNTRST_EMACACNTRST |	\
> +	 CLKMGR_CTL_EXTCNTRST_EMACBCNTRST |	\
> +	 CLKMGR_CTL_EXTCNTRST_EMACPTPCNTRST |	\
> +	 CLKMGR_CTL_EXTCNTRST_GPIODBCNTRST |	\
> +	 CLKMGR_CTL_EXTCNTRST_S2FUSER0CNTRST |	\
> +	 CLKMGR_CTL_EXTCNTRST_S2FUSER1CNTRST |	\
> +	 CLKMGR_CTL_EXTCNTRST_PSIREFCNTRST |	\
> +	 CLKMGR_CTL_EXTCNTRST_USB31REFCNTRST |	\
> +	 CLKMGR_CTL_EXTCNTRST_DSUCNTRST |	\
> +	 CLKMGR_CTL_EXTCNTRST_CORE01CNTRST |	\
> +	 CLKMGR_CTL_EXTCNTRST_CORE2CNTRST |	\
> +	 CLKMGR_CTL_EXTCNTRST_CORE3CNTRST)
> +
> +#define MEMBUS_MAINPLL				0
> +#define MEMBUS_PERPLL				1
> +#define MEMBUS_TIMEOUT				1000
> +
> +#define MEMBUS_CLKSLICE_REG				0x27
> +#define MEMBUS_SYNTHCALFOSC_INIT_CENTERFREQ_REG		0xb3
> +#define MEMBUS_SYNTHPPM_WATCHDOGTMR_VF01_REG		0xe6
> +#define MEMBUS_CALCLKSLICE0_DUTY_LOCOVR_REG		0x03
> +#define MEMBUS_CALCLKSLICE1_DUTY_LOCOVR_REG		0x07
> +
> +#define MPIDR_AFF1_OFFSET	8
> +#define MPIDR_AFF1_MASK		0x3
> +#endif /* _CLK_AGILEX5_ */
> diff --git a/include/configs/socfpga_agilex5_socdk.h
> b/include/configs/socfpga_agilex5_socdk.h
> new file mode 100644
> index 0000000000..b5b5bd767f
> --- /dev/null
> +++ b/include/configs/socfpga_agilex5_socdk.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * Copyright (C) 2024 Intel Corporation <www.intel.com>
> + *
> + */
> +
> +#ifndef __CONFIG_SOCFGPA_AGILEX5_H__
> +#define __CONFIG_SOCFGPA_AGILEX5_H__
> +
> +#include <configs/socfpga_soc64_common.h>
> +
> +#endif	/* __CONFIG_SOCFGPA_AGILEX5_H__ */
> diff --git a/include/configs/socfpga_soc64_common.h
> b/include/configs/socfpga_soc64_common.h
> index 820372c28b..b7ee1dbf20 100644
> --- a/include/configs/socfpga_soc64_common.h
> +++ b/include/configs/socfpga_soc64_common.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0
>   *
> - * Copyright (C) 2017-2019 Intel Corporation <www.intel.com>
> + * Copyright (C) 2017-2024 Intel Corporation <www.intel.com>
>   *
>   */
>=20
> @@ -26,8 +26,13 @@
>  /*
>   * U-Boot run time memory configurations
>   */
> +#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
> +#define CFG_SYS_INIT_RAM_ADDR	0x0
> +#define CFG_SYS_INIT_RAM_SIZE	0x80000
> +#else
>  #define CFG_SYS_INIT_RAM_ADDR	0xFFE00000
>  #define CFG_SYS_INIT_RAM_SIZE	0x40000
> +#endif
>=20
>  /*
>   * U-Boot environment configurations
> @@ -36,9 +41,121 @@
>  /*
>   * Environment variable
>   */
> +#if IS_ENABLED(CONFIG_DISTRO_DEFAULTS)
> +#if IS_ENABLED(CONFIG_CMD_MMC)
> +#define BOOT_TARGET_DEVICES_MMC(func) func(MMC, mmc, 0)
> +#else
> +#define BOOT_TARGET_DEVICES_MMC(func)
> +#endif
> +
> +#if IS_ENABLED(CONFIG_CMD_SF)
> +#define BOOT_TARGET_DEVICES_QSPI(func) func(QSPI, qspi, na)
> +#else
> +#define BOOT_TARGET_DEVICES_QSPI(func)
> +#endif
> +
> +#define BOOTENV_DEV_QSPI(devtypeu, devtypel, instance) \
> +	"bootcmd_qspi=3Dubi detach; sf probe && " \
> +	"if ubi part root && ubi readvol ${scriptaddr} script; " \
> +	"then echo QSPI: Running script from UBIFS; " \
> +	"elif sf read ${scriptaddr} ${qspiscriptaddr} ${scriptsize}; " \
> +	"then echo QSPI: Running script from JFFS2; fi; " \
> +	"echo QSPI: Trying to boot script at ${scriptaddr} && " \
> +	"source ${scriptaddr}; " \
> +	"echo QSPI: SCRIPT FAILED: continuing...; ubi detach;\0"
> +
> +#define BOOTENV_DEV_NAME_QSPI(devtypeu, devtypel, instance) \
> +	"qspi "
> +
> +#define BOOT_TARGET_DEVICES(func) \
> +	BOOT_TARGET_DEVICES_MMC(func) \
> +	BOOT_TARGET_DEVICES_QSPI(func)
> +
> +#include <config_distro_bootcmd.h>
> +
> +#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
> +
>  #define CFG_EXTRA_ENV_SETTINGS \
> +	"kernel_addr_r=3D0x82000000\0" \
> +	"fdt_addr_r=3D0x86000000\0" \
> +	"qspiscriptaddr=3D0x02110000\0" \
> +	"scriptsize=3D0x00010000\0" \
> +	"qspibootimageaddr=3D0x02120000\0" \
> +	"bootimagesize=3D0x03200000\0" \
>  	"loadaddr=3D" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
>  	"bootfile=3D" CONFIG_BOOTFILE "\0" \
> +	"mmcroot=3D/dev/mmcblk0p2\0" \
> +	"mtdids=3D" CONFIG_MTDIDS_DEFAULT "\0" \
> +	"mtdparts=3D" CONFIG_MTDPARTS_DEFAULT "\0" \
> +	"linux_qspi_enable=3Dif sf probe; then " \
> +		"echo Enabling QSPI at Linux DTB...;" \
> +		"fdt addr ${fdt_addr}; fdt resize;" \
> +		"fdt set /soc/spi@108d2000 status okay;" \
> +		"if fdt set /clocks/qspi-clk clock-frequency" \
> +		" ${qspi_clock}; then echo QSPI clock frequency updated;" \
> +		" elif fdt set /soc/clkmgr/clocks/qspi_clk clock-frequency" \
> +		" ${qspi_clock}; then echo QSPI clock frequency updated;" \
> +		" else fdt set /clocks/qspi-clk clock-frequency" \
> +		" ${qspi_clock}; echo QSPI clock frequency updated; fi; fi\0" \
> +	"scriptaddr=3D0x81000000\0" \
> +	"scriptfile=3Dboot.scr\0" \
> +	"socfpga_legacy_reset_compat=3D1\0" \
> +	"smc_fid_rd=3D0xC2000007\0" \
> +	"smc_fid_wr=3D0xC2000008\0" \
> +	"smc_fid_upd=3D0xC2000009\0 " \
> +	BOOTENV
> +
> +#else
> +
> +#define CFG_EXTRA_ENV_SETTINGS \
> +	"kernel_addr_r=3D0x2000000\0" \
> +	"fdt_addr_r=3D0x6000000\0" \
> +	"qspiscriptaddr=3D0x02110000\0" \
> +	"scriptsize=3D0x00010000\0" \
> +	"qspibootimageaddr=3D0x02120000\0" \
> +	"bootimagesize=3D0x03200000\0" \
> +	"loadaddr=3D" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
> +	"bootfile=3D" CONFIG_BOOTFILE  "\0" \
> +	"mmcroot=3D/dev/mmcblk0p2\0" \
> +	"mtdids=3D" CONFIG_MTDIDS_DEFAULT "\0" \
> +	"mtdparts=3D" CONFIG_MTDPARTS_DEFAULT "\0" \
> +	"linux_qspi_enable=3Dif sf probe; then " \
> +		"echo Enabling QSPI at Linux DTB...;" \
> +		"fdt addr ${fdt_addr}; fdt resize;" \
> +		"fdt set /soc/spi@ff8d2000 status okay;" \
> +		"if fdt set /soc/clocks/qspi-clk clock-frequency" \
> +		" ${qspi_clock}; then echo QSPI clock frequency updated;" \
> +		" elif fdt set /soc/clkmgr/clocks/qspi_clk clock-frequency" \
> +		" ${qspi_clock}; then echo QSPI clock frequency updated;" \
> +		" else fdt set /clocks/qspi-clk clock-frequency" \
> +		" ${qspi_clock}; echo QSPI clock frequency updated; fi; fi\0" \
> +	"scriptaddr=3D0x05FF0000\0" \
> +	"scriptfile=3Dboot.scr\0" \
> +	"socfpga_legacy_reset_compat=3D1\0" \
> +	"smc_fid_rd=3D0xC2000007\0" \
> +	"smc_fid_wr=3D0xC2000008\0" \
> +	"smc_fid_upd=3D0xC2000009\0 " \
> +	BOOTENV
> +#endif /*#IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)*/
> +
> +#else
> +
> +#define CFG_EXTRA_ENV_SETTINGS \
> +	"kernel_comp_addr_r=3D0x9000000\0" \
> +	"kernel_comp_size=3D0x01000000\0" \
> +	"qspibootimageaddr=3D0x020E0000\0" \
> +	"qspifdtaddr=3D0x020D0000\0" \
> +	"bootimagesize=3D0x01F00000\0" \
> +	"fdtimagesize=3D0x00010000\0" \
> +	"qspiload=3Dsf read ${loadaddr} ${qspibootimageaddr}
> ${bootimagesize};" \
> +		"sf read ${fdt_addr} ${qspifdtaddr} ${fdtimagesize}\0" \
> +	"qspiboot=3Dsetenv bootargs earlycon root=3D/dev/mtdblock1 rw " \
> +		"rootfstype=3Djffs2 rootwait;booti ${loadaddr} - ${fdt_addr}\0" \
> +	"qspifitload=3Dsf read ${loadaddr} ${qspibootimageaddr}
> ${bootimagesize}\0" \
> +	"qspifitboot=3Dsetenv bootargs earlycon root=3D/dev/mtdblock1 rw " \
> +		"rootfstype=3Djffs2 rootwait;bootm ${loadaddr}\0" \
> +	"loadaddr=3D" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
> +	"bootfile=3D" CONFIG_BOOTFILE  "\0" \
>  	"fdt_addr=3D8000000\0" \
>  	"fdtimage=3D" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0" \
>  	"mmcroot=3D/dev/mmcblk0p2\0" \
> @@ -53,24 +170,40 @@
>  		"bootm ${loadaddr}\0" \
>  	"mmcfitload=3Dmmc rescan;" \
>  		"load mmc 0:1 ${loadaddr} ${bootfile}\0" \
> +	"mtdids=3D" CONFIG_MTDIDS_DEFAULT "\0" \
> +	"mtdparts=3D" CONFIG_MTDPARTS_DEFAULT "\0" \
>  	"linux_qspi_enable=3Dif sf probe; then " \
>  		"echo Enabling QSPI at Linux DTB...;" \
>  		"fdt addr ${fdt_addr}; fdt resize;" \
>  		"fdt set /soc/spi@ff8d2000 status okay;" \
> -		"fdt set /soc/clkmgr/clocks/qspi_clk clock-frequency " \
> -		" ${qspi_clock}; fi; \0" \
> +		"if fdt set /soc/clocks/qspi-clk clock-frequency" \
> +		" ${qspi_clock}; then echo QSPI clock frequency updated;" \
> +		" elif fdt set /soc/clkmgr/clocks/qspi_clk clock-frequency" \
> +		" ${qspi_clock}; then echo QSPI clock frequency updated;" \
> +		" else fdt set /clocks/qspi-clk clock-frequency" \
> +		" ${qspi_clock}; echo QSPI clock frequency updated; fi; fi\0" \
>  	"scriptaddr=3D0x02100000\0" \
>  	"scriptfile=3Du-boot.scr\0" \
>  	"fatscript=3Dif fatload mmc 0:1 ${scriptaddr} ${scriptfile};" \
> -		   "then source ${scriptaddr}; fi\0" \
> -	"socfpga_legacy_reset_compat=3D1\0"
> +		   "then source ${scriptaddr}:script; fi\0" \
> +	"socfpga_legacy_reset_compat=3D1\0" \
> +	"smc_fid_rd=3D0xC2000007\0" \
> +	"smc_fid_wr=3D0xC2000008\0" \
> +	"smc_fid_upd=3D0xC2000009\0 "
> +#endif /*#if IS_ENABLED(CONFIG_DISTRO_DEFAULTS)*/
>=20
>  /*
>   * External memory configurations
>   */
> +#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
> +#define PHYS_SDRAM_1			0x80000000
> +#define PHYS_SDRAM_1_SIZE		(1 * 1024 * 1024 * 1024)
> +#define CFG_SYS_SDRAM_BASE		0x80000000
> +#else
>  #define PHYS_SDRAM_1			0x0
>  #define PHYS_SDRAM_1_SIZE		(1 * 1024 * 1024 * 1024)
>  #define CFG_SYS_SDRAM_BASE		0
> +#endif
>=20
>  /*
>   * Serial / UART configurations
> diff --git a/include/dt-bindings/clock/agilex5-clock.h b/include/dt-
> bindings/clock/agilex5-clock.h
> new file mode 100644
> index 0000000000..c84fa51540
> --- /dev/null
> +++ b/include/dt-bindings/clock/agilex5-clock.h
> @@ -0,0 +1,71 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2024, Intel Corporation
> + */
> +
> +#ifndef __AGILEX5_CLOCK_H
> +#define __AGILEX5_CLOCK_H
> +
> +/* fixed rate clocks */
> +#define AGILEX5_OSC1			0
> +#define AGILEX5_CB_INTOSC_HS_DIV2_CLK	1
> +#define AGILEX5_CB_INTOSC_LS_CLK		2
> +#define AGILEX5_L4_SYS_FREE_CLK		3
> +#define AGILEX5_F2S_FREE_CLK		4
> +
> +/* PLL clocks */
> +#define AGILEX5_MAIN_PLL_CLK		5
> +#define AGILEX5_MAIN_PLL_C0_CLK		6
> +#define AGILEX5_MAIN_PLL_C1_CLK		7
> +#define AGILEX5_MAIN_PLL_C2_CLK		8
> +#define AGILEX5_MAIN_PLL_C3_CLK		9
> +#define AGILEX5_PERIPH_PLL_CLK		10
> +#define AGILEX5_PERIPH_PLL_C0_CLK	11
> +#define AGILEX5_PERIPH_PLL_C1_CLK	12
> +#define AGILEX5_PERIPH_PLL_C2_CLK	13
> +#define AGILEX5_PERIPH_PLL_C3_CLK	14
> +#define AGILEX5_MPU_FREE_CLK		15
> +#define AGILEX5_MPU_CCU_CLK		16
> +#define AGILEX5_BOOT_CLK			17
> +
> +/* fixed factor clocks */
> +#define AGILEX5_L3_MAIN_FREE_CLK		18
> +#define AGILEX5_NOC_FREE_CLK		19
> +#define AGILEX5_S2F_USR0_CLK		20
> +#define AGILEX5_NOC_CLK			21
> +#define AGILEX5_EMAC_A_FREE_CLK		22
> +#define AGILEX5_EMAC_B_FREE_CLK		23
> +#define AGILEX5_EMAC_PTP_FREE_CLK	24
> +#define AGILEX5_GPIO_DB_FREE_CLK		25
> +#define AGILEX5_SDMMC_FREE_CLK		26
> +#define AGILEX5_S2F_USER0_FREE_CLK	27
> +#define AGILEX5_S2F_USER1_FREE_CLK	28
> +#define AGILEX5_PSI_REF_FREE_CLK		29
> +
> +/* Gate clocks */
> +#define AGILEX5_MPU_CLK			30
> +#define AGILEX5_MPU_PERIPH_CLK		31
> +#define AGILEX5_L4_MAIN_CLK		32
> +#define AGILEX5_L4_MP_CLK		33
> +#define AGILEX5_L4_SP_CLK		34
> +#define AGILEX5_CS_AT_CLK		35
> +#define AGILEX5_CS_TRACE_CLK		36
> +#define AGILEX5_CS_PDBG_CLK		37
> +#define AGILEX5_CS_TIMER_CLK		38
> +#define AGILEX5_S2F_USER0_CLK		39
> +#define AGILEX5_EMAC0_CLK		40
> +#define AGILEX5_EMAC1_CLK		41
> +#define AGILEX5_EMAC2_CLK		42
> +#define AGILEX5_EMAC_PTP_CLK		43
> +#define AGILEX5_GPIO_DB_CLK		44
> +#define AGILEX5_NAND_CLK			45
> +#define AGILEX5_PSI_REF_CLK		46
> +#define AGILEX5_S2F_USER1_CLK		47
> +#define AGILEX5_SDMMC_CLK		48
> +#define AGILEX5_SPI_M_CLK		49
> +#define AGILEX5_USB_CLK			50
> +#define AGILEX5_NAND_X_CLK		51
> +#define AGILEX5_NAND_ECC_CLK		52
> +#define AGILEX5_NUM_CLKS			53
> +
> +#endif	/* __AGILEX5_CLOCK_H */
> diff --git a/include/dt-bindings/reset/altr,rst-mgr-agx5.h b/include/dt-
> bindings/reset/altr,rst-mgr-agx5.h
> new file mode 100644
> index 0000000000..1dba270aed
> --- /dev/null
> +++ b/include/dt-bindings/reset/altr,rst-mgr-agx5.h
> @@ -0,0 +1,80 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2024 Intel Corporation. All rights reserved
> + */
> +
> +#ifndef _DT_BINDINGS_RESET_ALTR_RST_MGR_AGX_EDGE_H
> +#define _DT_BINDINGS_RESET_ALTR_RST_MGR_AGX_EDGE_H
> +
> +/* PER0MODRST */
> +#define EMAC0_RESET		0
> +#define EMAC1_RESET		1
> +#define EMAC2_RESET		2
> +#define USB0_RESET		3
> +#define USB1_RESET		4
> +#define NAND_RESET		5
> +#define COMBOPHY_RESET		6
> +#define SDMMC_RESET		7
> +#define EMAC0_OCP_RESET		8
> +#define EMAC1_OCP_RESET		9
> +#define EMAC2_OCP_RESET		10
> +#define USB0_OCP_RESET		11
> +#define USB1_OCP_RESET		12
> +#define NAND_OCP_RESET		13
> +/* 14 is empty */
> +#define SDMMC_OCP_RESET		15
> +#define DMA_RESET		16
> +#define SPIM0_RESET		17
> +#define SPIM1_RESET		18
> +#define SPIS0_RESET		19
> +#define SPIS1_RESET		20
> +#define DMA_OCP_RESET		21
> +#define EMAC_PTP_RESET		22
> +/* 23 is empty*/
> +#define DMAIF0_RESET		24
> +#define DMAIF1_RESET		25
> +#define DMAIF2_RESET		26
> +#define DMAIF3_RESET		27
> +#define DMAIF4_RESET		28
> +#define DMAIF5_RESET		29
> +#define DMAIF6_RESET		30
> +#define DMAIF7_RESET		31
> +
> +/* PER1MODRST */
> +#define WATCHDOG0_RESET		32
> +#define WATCHDOG1_RESET		33
> +#define WATCHDOG2_RESET		34
> +#define WATCHDOG3_RESET		35
> +#define L4SYSTIMER0_RESET	36
> +#define L4SYSTIMER1_RESET	37
> +#define SPTIMER0_RESET		38
> +#define SPTIMER1_RESET		39
> +#define I2C0_RESET		40
> +#define I2C1_RESET		41
> +#define I2C2_RESET		42
> +#define I2C3_RESET		43
> +#define I2C4_RESET		44
> +#define I3C0_RESET		45
> +#define I3C1_RESET		46
> +/* 47 is empty */
> +#define UART0_RESET		48
> +#define UART1_RESET		49
> +/* 50-55 is empty */
> +#define GPIO0_RESET		56
> +#define GPIO1_RESET		57
> +#define WATCHDOG4_RESET		58
> +/* 59-63 is empty */
> +
> +/* BRGMODRST */
> +#define SOC2FPGA_RESET		64
> +#define LWHPS2FPGA_RESET	65
> +#define FPGA2SOC_RESET		66
> +#define F2SSDRAM_RESET		67
> +/* 68-69 is empty */
> +#define DDRSCH_RESET		70
> +/* 71-95 is empty */
> +
> +/* DBGMODRST */
> +#define DBG_RESET		192
> +
> +#endif
> --
> 2.19.0

Reviewed-by: Tien Fong Chee <tien.fong.chee@intel.com>

Regards
Tien Fong
