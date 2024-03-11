Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031F8C5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 08:10:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22E0787EEF;
	Mon, 11 Mar 2024 09:10:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="XDikO9F2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 323D887EFD; Mon, 11 Mar 2024 09:10:12 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AD2887EEF
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 09:10:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710144609; x=1741680609;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HcCHG5mMsmrJiOStZe1jfKpFfdabT8VUe2qrpDlN1Fs=;
 b=XDikO9F29PYVIY2tETkj+tLCTdrdMvC26WuYnZIEd0/5hEs8W6UvRSFb
 KzBhlFK9OlviZKMOeplUUE/hskj5vF5i7taeOgNFtUrHCWKO9JBjsIpOF
 lbLXOKX/HDj24t8m0cdR93BDl3+8ZmoJMBhd9QTLuRuTMn2ro0YfO+AOC
 NoAUDeApqx6I0DRtXSHorfg0QNdScO5AgpeTCZBDoQYw5pjUbnxM8nDGX
 czn1dMQW4Y/lt4gGEGXqwWn/d4Dta4uwIp1OFlklhi5uica+O+yPZsMPo
 aVPcpRt4DOcTwKfm9MO2uKzBGdtTCLGpXboPmfU62t1QSPsNMMCGM+I3B w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="4972630"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="4972630"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2024 01:10:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; d="scan'208";a="48553095"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 11 Mar 2024 01:10:04 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Mar 2024 01:10:04 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Mar 2024 01:10:03 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Mar 2024 01:10:03 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Mar 2024 01:10:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDfCFNBq0RhOoexqKRmx9sI+/eGFe/bMuuQotFYT3IGvOFszeT7US6L/A5gxVUcfovvgHr7ubcW9H7oMmYKF2mo8g3FlIetNSN7bMlsujyR7HFW+SV6lhL/l0Jy2tCVYSmD8KtyBFt9UHzeU/L77P0zc9QQeVPocV2ZhuD9AHFxun0Ylwj9A8qoU6m6dT5CVcPGIbGjQDa0T1nuewoD3t+A12S5/ONU9sU/D7gHMi2enuntwXknCoGtjGKYBidBvFJBH5CO9E0fNvHkpF9t0YeVJPuj/wjauWWi31+apsAcAJsf6KwbjP1vDgNlFW8zYvLoquaa+y7aIELECyR2kVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yA/H9AKc+H4cVF+5+hW0ZNG+jv033JPK0r3phcBpen8=;
 b=jbN9GRGJIGmn/Ggdwk6WHM6BcIF17YIi4FtC8J9FpHEFWYvqPXJVD8XnZP6Id0BuaY6hDhQiZ75/6sh4sqLAtCsxxdTBoU1MOB7gMIDH6w3z/IP0CfUWz5o9DLLUOGs4Z7cc99OAmQkdK6BUlp4mvlAefBLC5uLykyorZqXd7EpQf/L3+mGPCgJYxTgoE8D8FRU1h+1KdWZx/y61fsCGfP3hZbuEvSjkg5htUc31dqAn3M5gNxhKq/h4qQcL+xlabPS5EAX2RHEhq0FgmlbWFh7hcyAxEMwNJLy9Cj5KDyv9a5NmkKhyYHZtehyWguijOgiuJlMNybv0zETQQ/DQKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 SA1PR11MB6710.namprd11.prod.outlook.com (2603:10b6:806:25a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.16; Mon, 11 Mar
 2024 08:10:01 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::d4e:e166:9da2:571]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::d4e:e166:9da2:571%4]) with mapi id 15.20.7386.016; Mon, 11 Mar 2024
 08:10:00 +0000
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
Subject: RE: [PATCH v3 v3 1/1] arch: arm: Agilex5 enablement
Thread-Topic: [PATCH v3 v3 1/1] arch: arm: Agilex5 enablement
Thread-Index: AQHac1atv7w81zDNNkqQMn4rwkzhsLEyI/mg
Date: Mon, 11 Mar 2024 08:10:00 +0000
Message-ID: <DM8PR11MB5592177D4BF048FD33352210D2242@DM8PR11MB5592.namprd11.prod.outlook.com>
References: <20240311015131.24528-1-jit.loon.lim@intel.com>
 <20240311015131.24528-2-jit.loon.lim@intel.com>
In-Reply-To: <20240311015131.24528-2-jit.loon.lim@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|SA1PR11MB6710:EE_
x-ms-office365-filtering-correlation-id: 8089a5f0-4784-4111-e4fd-08dc41a2a637
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W75fWBLwHSE/vam+7tWaoXM7/ss3Ra/L7qsJiu3ncycgie3MSaofVtc496wRF9h1TjJvPFB4Wkhf5GtrdxgZ75zQps15Jp2KjpQtLZfaDPsBttTUiI7gpvTiqypar3Eocgecyy1M9frME47CKLU3PZ8qkJZoN+nuTgf+HDaqAKXi86WkpAcD59MaWa7wraJ3os4c/MUQbCy2/cQYkPUvjBC+djs41gAqljO4ux9Jh/IiU5TjwEJbHCEqkyzyg3yHYv0/dTvdP+L4D11JN45/gaZ/yfQcy/puHvIKpETvGG5KgJ/YcsSu0GPd31c7IRXJBBItjtaBofCE7zV/8d+62IKv9ooE2MkMKzKlqyyFVtjqfyjRcfb+q/3PXhuB7BlJfyLjXLTbfk1YAawBHGwAQ5KsSdIbFgEg1dp2+ORAerHHNonX+7wn677y5NeFZnwqSxqORckLMaNZE1xZQBV8e+qtsL75H1t+my/KslIDGC/brAkt27GgdyPsanFFec0+OpmZLdkO81/XFuHV1xBoTXb8Tx0mV5J0QgwaTo5LDH8LXszcWc8JM0cwtonb3wLQqf71yMeodvyd9nLRJF4QcVBJ0CckQtnke0Ujp5EBper6Q+A/PPF4OIFx2wkb5okb70NRCVYqBbKpr4mCjgNinX6VtA7eQA4bS9xidDRgzEM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5592.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GoJR0G+adkPhIxMZHdNT41xW4Z+lccX31cwbeDTEXbY0/8ZNbrTS03RkFAHh?=
 =?us-ascii?Q?RZmP7UJBhTJCAj1UTkBxP3+B2fzpDddGeEj8J/cqh2IO22yU5Q33sfzJM0b5?=
 =?us-ascii?Q?lvhh7fCuhaKiKQsn4IxCuDrB+pd+EIB3xjZGiUmmjMr3tonfXB5YjK99yfqn?=
 =?us-ascii?Q?cSE/cCSjHNZKmpfYuSZLb5Njy6CzdSjBVdbxlaF732Um7v7cOtRx9fyleAZg?=
 =?us-ascii?Q?aijmpISmGVZEEqjoRNptWnboF+VigoBvnfmvVXZp1cLCUDXznIRkUKEveenX?=
 =?us-ascii?Q?rMfq88PyhoviAWBk2GWkRmogJseBvfx8axlXAp8pIU28VLXN0VcaDTWzM7Os?=
 =?us-ascii?Q?9r9P4vLp/gOJCCfjetoUP2urWTgezw6zNXsssufIaG8PyjgzGN+2gU/7F2XA?=
 =?us-ascii?Q?/hwo/tEBVlAzdaMEbtPsZs0FYqjB/+wi5mlSRHWooocvuqYaJpBnG3yCYm4A?=
 =?us-ascii?Q?Cman/hjE/YOtEmVGXYmY+wZJYiXnJKm5Ptst96LlqvQ2LYhQUfrpd7Twx/So?=
 =?us-ascii?Q?8KhgnVOzUm8LyHX/vKWeroFzlqR/oF5j7efi4DMBqmBgoN5ih6cTxdbsXaNG?=
 =?us-ascii?Q?tONsZ/52yGd/kPbGxAPwAJUBojsiXvYuKrVTEw+iXMkjxTpY7g5rEExrmj2k?=
 =?us-ascii?Q?AbY9PnqVL3ZXBI2vyAakB6RKjIVsqLBEIkZDMiqMsH3874/QbCdWUDduHYD1?=
 =?us-ascii?Q?wcW2dyZUQfL2CNuA1aoFlkPTT9s+lp3lsWWwVetiM79fHmzcHtF03datudpY?=
 =?us-ascii?Q?+psLiE0tM13k0ohtJCqta1ip13ls6tzbUN9usUoZSDT37qcpgYoHKpJYxDQM?=
 =?us-ascii?Q?fr1W3oRv7BwLQFeo6VPg19w0d0RrdE06EJTSk+NgIcSUa8li7ydwKREtvs2m?=
 =?us-ascii?Q?yNcTLU+7WncuU6J5iCuGWdj9I0owi5qZL89Z/2nefeZg8FHwL94ZZo2SfHfj?=
 =?us-ascii?Q?o6nFi279ffh7s2ov0JYcu9ne280mHXbNYg/DDjJQHgW+oKV/FDBMxOiiU3At?=
 =?us-ascii?Q?yruuC9yIoYTp2FmkHL48osFPcRtiuaOFMzWODj47X22zBvg/hhW+LR7OWYhs?=
 =?us-ascii?Q?S93X5D29knrIhucslt3EIp0qzxr5KN8EcltdjcwnHJGcQfeFAGqVL/sutD4+?=
 =?us-ascii?Q?suLAH9V+8K/xrLIVCv65kwLHlM2oK9FiK/PaPzESBkLqFSU85wNF7LWEQGtQ?=
 =?us-ascii?Q?x0o7csogw14yZeyUTeOAB+aFJivApYmd6edB8LyJZe9IAE0wzH9PeCkb+XJA?=
 =?us-ascii?Q?KX3yzEr0iz/fa8UAqd0sFEQLDOWt7FWg975ip1Grf6+y6cRjlZgSfezzw1zg?=
 =?us-ascii?Q?Wq0gMeNqXxHIX3MBFqGWiAUeQssntRFxwCVnk8GDA5MTpmxKwHbKtAVnbFle?=
 =?us-ascii?Q?TvnTrTZJTmmEMpoOH4kJFPiWaTMOGWHbSodq+EvwCy44ZcI8KkqhLJi6lrVX?=
 =?us-ascii?Q?nk7AQS74kefRiUviieZQtksZDFTPgbZW31XGHpOOZFDCDATyA/+anqci3bCn?=
 =?us-ascii?Q?eYef6U+MKmWapdlUQ1iMrIO14l7KCvPyFECYOCYnkxbXGdMUFHSEObQDWBnU?=
 =?us-ascii?Q?Har6aVYe9AqRsMPxVUa+h+WI6i8oe31X0NlROpgN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8089a5f0-4784-4111-e4fd-08dc41a2a637
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 08:10:00.8419 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KO5Hh5wPBpXC4EQyz4Njsa49KxOGzMYEfu6Cy9Nogf3lr5J55lXqJ3T4de4ir0h56V5t+Dxf2cJXz+xusPR852XtARMx2DG15t6aezfYbYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6710
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

Hi Jit Loon,

> -----Original Message-----
> From: Lim, Jit Loon <jit.loon.lim@intel.com>
> Sent: Monday, March 11, 2024 9:52 AM
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
> Subject: [PATCH v3 v3 1/1] arch: arm: Agilex5 enablement
>=20
> This patch is to enable Agilex5 platform for Intel
> product. Changes, modification and new files are
> created for board, dts, configs and makefile to
> create the base for Agilex5.
>=20
> Signed-off-by: Jit Loon Lim <jit.loon.lim@intel.com>
>=20
> Changes v2 -> v3:
> - Added FPGA 240G DDR region
> Changes v1 -> v2:
> - fixed git auto merge issue
> ---
>  arch/arm/Kconfig                              |   4 +-
>  arch/arm/dts/Makefile                         |   1 +
>  arch/arm/dts/socfpga_agilex5-u-boot.dtsi      |  71 ++
>  arch/arm/dts/socfpga_agilex5.dtsi             | 575 ++++++++++++++
>  .../arm/dts/socfpga_agilex5_socdk-u-boot.dtsi | 133 ++++
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
>  26 files changed, 2730 insertions(+), 36 deletions(-)
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

[...]

> diff --git a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
> b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
> new file mode 100644
> index 0000000000..a24b0482bb
> --- /dev/null
> +++ b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
> @@ -0,0 +1,133 @@
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

[...]

> +
> +#if !defined(CONFIG_SOCFPGA_SECURE_VAB_AUTH)

Using IS_enabled()

> +&fdt_0_blob {
> +	filename =3D "arch/arm/dts/socfpga_agilex5_socdk.dtb";
> +};

[...]

Best regards
Tien Fong
