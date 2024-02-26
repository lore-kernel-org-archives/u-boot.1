Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC02DC5478C
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 05:59:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CB8287E45;
	Mon, 26 Feb 2024 06:59:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="EZMgzYj7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CCFD87E57; Mon, 26 Feb 2024 06:59:53 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8605887E45
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 06:59:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jit.loon.lim@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708927190; x=1740463190;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=PO7e+D9bnk+lKvHN6AJ3XqcdrX+k1P0vgg0isW52osE=;
 b=EZMgzYj7a90PSuyYKaB7BvasQ6rttZbQhVLxQlwgPYhMsTU7epR0OAIp
 xMwJTt5X+YkQQfa8u44XEut3biBJRvELiX1s6M4WnpuyE+9vcElRPBDiz
 z2nGH+Z9a2kPsPCdiL35WeH3RFjgda9ZtoaaUl+U0we6x3wUsu8bckgQp
 TPUV+BFGs63BxUWcsBH4OSFUodWAoK2jEiSkavMyigsdw1M6Ry4Ju6M9h
 Wv03XGGWZ1zPNzJnnq+N4+JoBQtgGIfD3ersjgxo/rMJwY/hMWCEiWYvZ
 B4iyLtLdw0JZATXRGAfF5NI/tAqG+Pe+a5tsGT3GU6OwnLWWQSkVMiiCx Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="14627792"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; d="scan'208";a="14627792"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2024 21:59:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="7061907"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 25 Feb 2024 21:59:48 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 25 Feb 2024 21:59:47 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 25 Feb 2024 21:59:47 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 25 Feb 2024 21:59:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnjMdNO2VrJt5MFB7qSr1HPDL7qVUK/QNl0RArvmuURY1LdinjtfzYI1GFAm5DRb9mDDqfrdxOSTeRQmBa1/foGkwlfCBOhT4ui0aPHpcBaToF6TyalO/b1FIeoxGdBMA2mdFaNQGxQjWWr8Rh1BdjtJUc4PMob4wZ9hI0MfJvEs61LcSaJu5gVsjMYVJV1VM/qVqge8gL2gk8o81tukusmTJNvrnksvctQ87/+HsYuCMTRdNJzmqAj/kQmlUbRAf7+SVC9f1qpY/4fHiD4FLj7PNCng1u3vju0zPkw5hWA27sVQZGajUtAKBswChg1I2vqayh3Q6+KO2/9N+MALnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LTu+tfRMkxd7Q1JbtIYdX08VtvBJz3Nx35RuzPfHlRk=;
 b=Bakmsm/XIF9zhRiCOhw/C7Rw8osL//EFVzVXZil8KQAQRjTffESx0emnSxsvwsEeoFL8ZA3YTe75GZ+6fP/51D9lzF7dUN8JiTR9M9uMMJEV1muhLRKuPoZi9uaC5fEz+KkF1I1Ig+WQVkltOdwXR8d44sxXg7GVY0s6WM+nYxRTaiXwSTN1VkYWA+9thXMZIMa1gFJRZbP3iFkGY0kqQaXSYyEyQ2lF7ADeUl/9iZ8bpOked61OkD25wjHLp9U0EuGZ9BebyAvbhPMBMOWaLFtgXbiGJ0DEyQGXrAgxXdWVrNt0+rg6svdZLFpu2UnSLGtJyiMMX/Q3VcG6qAYttQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4945.namprd11.prod.outlook.com (2603:10b6:303:9c::8)
 by PH7PR11MB6793.namprd11.prod.outlook.com (2603:10b6:510:1b7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.23; Mon, 26 Feb
 2024 05:59:44 +0000
Received: from CO1PR11MB4945.namprd11.prod.outlook.com
 ([fe80::9aec:3496:2566:cd4f]) by CO1PR11MB4945.namprd11.prod.outlook.com
 ([fe80::9aec:3496:2566:cd4f%5]) with mapi id 15.20.7339.009; Mon, 26 Feb 2024
 05:59:44 +0000
From: "Lim, Jit Loon" <jit.loon.lim@intel.com>
To: "Chee, Tien Fong" <tien.fong.chee@intel.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Jagan Teki <jagan@amarulasolutions.com>, Marek <marex@denx.de>, Simon
 <simon.k.r.goldschmidt@gmail.com>, "Hea, Kok Kiang"
 <kok.kiang.hea@intel.com>, "Maniyam, Dinesh" <dinesh.maniyam@intel.com>, "Ng, 
 Boon Khai" <boon.khai.ng@intel.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@intel.com>, "Chong, Teik Heng"
 <teik.heng.chong@intel.com>, "Zamri, Muhammad Hazim Izzat"
 <muhammad.hazim.izzat.zamri@intel.com>, "Tang, Sieu Mun"
 <sieu.mun.tang@intel.com>, Bin Meng <bmeng.cn@gmail.com>, "Lim, Jit Loon"
 <jit.loon.lim@intel.com>
Subject: RE: [PATCH v1 1/1] arch:arm: Agilex5 enablement
Thread-Topic: [PATCH v1 1/1] arch:arm: Agilex5 enablement
Thread-Index: AQHaZAo6N/BMzexSSkOV8EuL+8FgarEUVT8AgAfUdNA=
Date: Mon, 26 Feb 2024 05:59:44 +0000
Message-ID: <CO1PR11MB49453F289C6ADF95EE9E2FACD25A2@CO1PR11MB4945.namprd11.prod.outlook.com>
References: <20240220143603.22091-1-jit.loon.lim@intel.com>
 <DM8PR11MB5592E1516ABBD66396B303DCD2572@DM8PR11MB5592.namprd11.prod.outlook.com>
In-Reply-To: <DM8PR11MB5592E1516ABBD66396B303DCD2572@DM8PR11MB5592.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4945:EE_|PH7PR11MB6793:EE_
x-ms-office365-filtering-correlation-id: eaf4f6b1-2be3-4179-2855-08dc369021a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F1on6nDX5ay1fTYt4ZZaUFhI/qDYoatexdB2IVy5RHFchCMo2T/FKeWhuT3wmn1pKFW+LzojL6/CCEX0BWcqgg+DnJCs9NK/KXbyGyR+7tFXY40GVEd59Zolkt3k2Je53X2I1xkqUFB164MLEPktiLdOBhlX1TtdsifeCBDy/sZud2bpoSObfhe5hJE/dwLYcDpGroTAXwsXeBIb1+FOYZnkvrHKVekcEcf4GPPBDVMaLfMrCKrjFha4ugSiUvV7o6S0I7G0kV0QLQVAFNCDqWSJtkrrLhhSm+8aj0lnfvZSpJsvX7TxF6O+OF14TWMruWxLOJiwWL/Dww19/w7s8veBTTsq6Kw1YMBCj57mUCl9BBf5nP11Ac3Ahk+Qdpn4qm+Db5mMkrqXZs0LTEIiTfVmpYxTKkkIZA2gHJs61B2dJlpxUpo3p1F/wzb21ZyYKceXf9/3SAVdUifj4NXUyx/eMFWT2tTFd0W800AMr4AdZy8HxVdxgHqNouFG7rMik8pYLArXXefPCPrGCVH5oUXwZ0fZgdlqtcCperz3Eq8VIsu7CSoGm6la0qVxSHm36YcqTwSdnovS6HFQ6jPcstn563wvBzYXsuNWX2r/uGfkAAVC4okRwZa+C9/nwLlgn/LATA/OMSbefy5NyZws9SeOJeh+2KrY5oXbVtQ3ZExWVT+MIrpEfe6gmSJkibplWoxqq+V60g9TsY9mwWq/mA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4945.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g12xkPbD6G5XiDn+zImqZzuo+V5tgkbUPOKhU7Rsdwox4hvJ4oMwS3eCkOkq?=
 =?us-ascii?Q?Qv7joMnhagXIXxb+T4ha94ANJaTEffe6P6/U03v3ae8Iavpbuulmd2wLRINB?=
 =?us-ascii?Q?APHnnM6by0uJZlll8PH3Xa9K6ZUzTUBPC5+D9NosRh1xnBZHp/fXntVyuY6Z?=
 =?us-ascii?Q?y9mZodnL4e0S+aPYIED3X0fCfBLB62FU0PUYjOSp6Z1JrT1rV/3VciyAgALH?=
 =?us-ascii?Q?suDdLSNGsiekn8Ef8LYWrVXMtinzYaLB/W16FfIqRVhEjKHFzaj9At1Wvwfv?=
 =?us-ascii?Q?u5839qMAQxtRaa7Ydyos+HedM15uDYa1Kt/Z8Mdm6wVucP/IlhEpvERwQ5fa?=
 =?us-ascii?Q?/Dx3OUCsjYjesotUy1XRo04EispbmVYrzb1RkY+OBGeRlx55uFeTExXSAKrI?=
 =?us-ascii?Q?F+xH6EjOLANjBQb2MkmMao6szB0ihyaQE2LDKKzbewNeahItJtE4gvmoki7X?=
 =?us-ascii?Q?gHijTNdOa9gN4zAx/gMpOC89FpeE869E4v3BLq7KsNWscDsQyluf6/LviQvZ?=
 =?us-ascii?Q?THmiA+L2K7yM8jt8IeBEP/YRKQb0YJjSJEiVKDfKMUbdwLc2h0LU0T3d+pNV?=
 =?us-ascii?Q?RGIMdJnoLCYX6/S3BG5SXfLn30+C0IjnNMuWa+MNCMb9BQ/PEEHmgeLHl3hK?=
 =?us-ascii?Q?N9hNR8YHkeRxnThth10x+101S34OjmJOqTSDd7wXHKUnHuAzjrJ0i/mx6JMi?=
 =?us-ascii?Q?dkpkot2CrfOrVe6CgHD8pYAyazQeNmhNv6kn90KkejA8e7WCALqMnfSJjb2z?=
 =?us-ascii?Q?kPMhveDKaHVbIs/bXOdhxgrjwkStJdhpzVIC100mtPjWx48NthLKKLcmIGz5?=
 =?us-ascii?Q?W1y3To4LiQtbFbWmG4l9UMNMiUrcAlfbIPcGeeXKLb8Nh3b0xCemD8hJVgcL?=
 =?us-ascii?Q?YeTTzu8v97sEjbToH0wCy4T0tFgUru3JqTJ9y8NmTfcmQAH/iHTfljsUQYXW?=
 =?us-ascii?Q?qN5B/r8abH92YGnTKgEqqA8YV0ZS171H9H2/VFOplH2xLlyxayOghAOFiFOk?=
 =?us-ascii?Q?szm8zQzMAV5ULFjRrwrUyqd8infubWHAedu3QoEYm14dPVKLrDyE2EQmrnJy?=
 =?us-ascii?Q?L4aA8p2E3Yxp4tPRHN0J01t15MSkZ+zW6EXYLF5MYel08GgH/VUyySayztc4?=
 =?us-ascii?Q?IRL2jHiFP0LzmJi1d6KuhKMGwsbflpd/I8I6hAqWu6HtE7LUKY+PRPe0N9uR?=
 =?us-ascii?Q?vZ8yXXRxdT0uhKkCwXicWuIRmQ9M8MUGa0yewXfhLb3Tc0cjxpbbh7wE2DFs?=
 =?us-ascii?Q?YajIJHwaT+y8+HMWGObkJbrRPJfqgNwv3C7f4pZ13xoenvrP6SejeS+5FjEy?=
 =?us-ascii?Q?x+JnCwzvO2lFpQPxeX5qw49DgFwhjBjjDDjpWnTC6V4w2qPmSWu3pP7k0M79?=
 =?us-ascii?Q?uyHsgdWf4ETPWzc0c75LSniJXWzh4sFvlSXnZ3YS5k8JIyvOUv+z9RtoS39Q?=
 =?us-ascii?Q?xrQSHiMYCvt+SAYUalyglDVM5/Ez/BF5dogGYdOQhlKnoayId9AQK3Jq2jS6?=
 =?us-ascii?Q?s86MKWY8YSOKDE1exKjxio03TwnyHIJ6+fqy0QU2y+Pa5un4vVRxFCx0zxZ3?=
 =?us-ascii?Q?YzXrSDWfZ9jPWNjJFo/6Bxxz2AZCJEVJuu/CXbxx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4945.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaf4f6b1-2be3-4179-2855-08dc369021a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 05:59:44.7157 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JQWb6CWGs4ej/byinSSk5iAMIIXOfRXdhzx4VtYJ4feM7339BzIkl9aIECnOoVjlIlKeeN8mP7jjq+uaABckUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6793
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



Thanks

Best Regards
JL Lim (Benjamin)

> -----Original Message-----
> From: Chee, Tien Fong <tien.fong.chee@intel.com>
> Sent: Wednesday, February 21, 2024 2:25 PM
> To: Lim, Jit Loon <jit.loon.lim@intel.com>; u-boot@lists.denx.de
> Cc: Jagan Teki <jagan@amarulasolutions.com>; Marek <marex@denx.de>;
> Simon <simon.k.r.goldschmidt@gmail.com>; Hea, Kok Kiang
> <kok.kiang.hea@intel.com>; Maniyam, Dinesh <dinesh.maniyam@intel.com>;
> Ng, Boon Khai <boon.khai.ng@intel.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@intel.com>; Chong, Teik Heng
> <teik.heng.chong@intel.com>; Zamri, Muhammad Hazim Izzat
> <muhammad.hazim.izzat.zamri@intel.com>; Tang, Sieu Mun
> <sieu.mun.tang@intel.com>; Bin Meng <bmeng.cn@gmail.com>
> Subject: RE: [PATCH v1 1/1] arch:arm: Agilex5 enablement
>=20
> Hi,
>=20
> > -----Original Message-----
> > From: Lim, Jit Loon <jit.loon.lim@intel.com>
> > Sent: Tuesday, February 20, 2024 10:36 PM
> > To: u-boot@lists.denx.de
> > Cc: Jagan Teki <jagan@amarulasolutions.com>; Marek <marex@denx.de>;
> > Simon <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> > <tien.fong.chee@intel.com>; Hea, Kok Kiang <kok.kiang.hea@intel.com>;
> > Maniyam, Dinesh <dinesh.maniyam@intel.com>; Ng, Boon Khai
> > <boon.khai.ng@intel.com>; Yuslaimi, Alif Zakuan
> > <alif.zakuan.yuslaimi@intel.com>; Chong, Teik Heng
> > <teik.heng.chong@intel.com>; Zamri, Muhammad Hazim Izzat
> > <muhammad.hazim.izzat.zamri@intel.com>; Lim, Jit Loon
> > <jit.loon.lim@intel.com>; Tang, Sieu Mun <sieu.mun.tang@intel.com>;
> > Bin Meng <bmeng.cn@gmail.com>
> > Subject: [PATCH v1 1/1] arch:arm: Agilex5 enablement
> >
> > This patch is to enable Agilex5 platform for Intel product. Changes,
> > modification and new files are created for board, dts, configs and
> > makefile to create the base for Agilex5.
> >
> > Signed-off-by: Jit Loon Lim <jit.loon.lim@intel.com>
> > ---
> >  arch/arm/Kconfig                              |   9 +-
> >  arch/arm/dts/Makefile                         |  32 +----
> >  .../arm/dts/socfpga_agilex5_socdk-u-boot.dtsi |  11 +-
> >  arch/arm/dts/socfpga_agilex5_socdk.dts        |  67 +---------
> >  arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi    |   2 +-
> >  arch/arm/mach-socfpga/Kconfig                 | 125 +++++-------------
> >  arch/arm/mach-socfpga/Makefile                |  99 +-------------
> >  arch/arm/mach-socfpga/board.c                 |   2 -
> >  .../include/mach/base_addr_soc64.h            |  16 +--
> >  board/intel/agilex5-socdk/MAINTAINERS         |   2 +
> >  board/intel/agilex5-socdk/Makefile            |   2 +-
> >  board/intel/agilex5-socdk/socfpga.c           |   2 +-
> >  configs/socfpga_agilex5_defconfig             |  33 -----
> >  include/configs/socfpga_agilex5_socdk.h       |   2 +-
> >  include/configs/socfpga_soc64_common.h        |  40 +-----
> >  15 files changed, 63 insertions(+), 381 deletions(-)
> >
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig index
> > 43d5ad346f..c8d91669da 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -28,7 +28,7 @@ config COUNTER_FREQUENCY
> >  			ROCKCHIP_RK3288 || ROCKCHIP_RK322X ||
> > ROCKCHIP_RK3036
> >  	default 25000000 if ARCH_LX2160A || ARCH_LX2162A ||
> ARCH_LS1088A
> >  	default 100000000 if ARCH_ZYNQMP
> > -	default 400000000 if ARCH_SOCFPGA && ARM64
>=20
> This patch is not based on latest U-Boot main branch
> https://source.denx.de/u-boot/u-boot.git, no such code in current main
> branch.
>=20
> > +	default 200000000 if ARCH_SOCFPGA && ARM64 &&
> > TARGET_SOCFPGA_AGILEX5
> >  	default 0
> >  	help
> >  	  For platforms with ARMv8-A and ARMv7-A which features a system
> @@
> > -1088,14 +1088,14 @@ config ARCH_SNAPDRAGON
> >  	select SPMI
> >  	imply CMD_DM
> >
> > -config ARCH_SOCFPGA
>=20
> Why remove this?
>=20
> > -	bool "Altera SOCFPGA family"
> > +bool "Altera SOCFPGA family"
>=20
> Why to change this?
>=20
> >  	select ARCH_EARLY_INIT_R
> >  	select ARCH_MISC_INIT if !TARGET_SOCFPGA_ARRIA10
> >  	select ARM64 if TARGET_SOCFPGA_SOC64
> >  	select CPU_V7A if TARGET_SOCFPGA_GEN5 ||
> > TARGET_SOCFPGA_ARRIA10
> >  	select DM
> >  	select DM_SERIAL
> > +	select GICV2
> >  	select GPIO_EXTRA_HEADER
> >  	select ENABLE_ARM_SOC_BOOT0_HOOK if
> > TARGET_SOCFPGA_GEN5 || TARGET_SOCFPGA_ARRIA10
> >  	select OF_CONTROL
> > @@ -1109,7 +1109,7 @@ config ARCH_SOCFPGA
> >  	select SPL_SOCFPGA_SEC_REG if TARGET_SOCFPGA_SOC64
> >  	select SPL_SERIAL
> >  	select SPL_SYSRESET
> > -	select SPL_WATCHDOG
> > +	select SPL_WATCHDOG if !TARGET_SOCFPGA_AGILEX5
>=20
> This can be removed, watchdog is supported in Agilex5
>=20
> >  	select SUPPORT_SPL
> >  	select SYS_NS16550
> >  	select SYS_THUMB_BUILD if TARGET_SOCFPGA_GEN5 ||
> > TARGET_SOCFPGA_ARRIA10 @@ -1123,6 +1123,7 @@ config
> ARCH_SOCFPGA
> >  	imply DM_SPI
> >  	imply DM_SPI_FLASH
> >  	imply FAT_WRITE
> > +	imply MTD
> >  	imply SPL
> >  	imply SPL_DM
> >  	imply SPL_DM_SPI
> > diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile index
> > 90d933a9ae..646f4feaf7 100644
> > --- a/arch/arm/dts/Makefile
> > +++ b/arch/arm/dts/Makefile
> > @@ -543,37 +543,7 @@ dtb-$(CONFIG_TARGET_AM3517_EVM) +=3D
> am3517-
> > evm.dtb
> >  dtb-$(CONFIG_TARGET_THUNDERX_88XX) +=3D thunderx-88xx.dtb
> >
> >  dtb-$(CONFIG_ARCH_SOCFPGA) +=3D				\
> > -	socfpga_agilex_n6010.dtb			\
> > -	socfpga_agilex_socdk.dtb			\
> > -	socfpga_agilex_socdk_nand.dtb                   \
> > -	socfpga_agilex_socdk_qspi.dtb			\
> > -	socfpga_agilex5_socdk.dtb			\
> > -	socfpga_agilex5_emu.dtb			\
> > -	socfpga_agilex7m_socdk.dtb			\
> > -	socfpga_agilex7m_socdk_nand.dtb			\
> > -	socfpga_arria5_secu1.dtb			\
> > -	socfpga_arria5_socdk.dtb			\
> > -	socfpga_arria10_chameleonv3_270_2.dtb		\
> > -	socfpga_arria10_chameleonv3_270_3.dtb		\
> > -	socfpga_arria10_chameleonv3_480_2.dtb		\
> > -	socfpga_arria10_socdk_nand.dtb			\
> > -	socfpga_arria10_socdk_qspi.dtb			\
> > -	socfpga_arria10_socdk_sdmmc.dtb			\
> > -	socfpga_cyclone5_mcvevk.dtb			\
> > -	socfpga_cyclone5_is1.dtb			\
> > -	socfpga_cyclone5_socdk.dtb			\
> > -	socfpga_cyclone5_dbm_soc1.dtb			\
> > -	socfpga_cyclone5_de0_nano_soc.dtb		\
> > -	socfpga_cyclone5_de1_soc.dtb			\
> > -	socfpga_cyclone5_de10_nano.dtb			\
> > -	socfpga_cyclone5_sockit.dtb			\
> > -	socfpga_cyclone5_socrates.dtb			\
> > -	socfpga_cyclone5_sr1500.dtb			\
> > -	socfpga_cyclone5_vining_fpga.dtb		\
> > -	socfpga_n5x_socdk.dtb				\
> > -	socfpga_stratix10_socdk.dtb			\
> > -	socfpga_stratix10_socdk_nand.dtb                \
> > -	socfpga_stratix10_socdk_qspi.dtb
>=20
> Why remove these?
>=20
> > +	socfpga_agilex5_socdk.dtb
> >
> >  dtb-$(CONFIG_TARGET_DRA7XX_EVM) +=3D dra72-evm.dtb dra7-evm.dtb
> > 	\
> >  	dra72-evm-revc.dtb dra71-evm.dtb dra76-evm.dtb diff --git
> > a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
> > b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
> > index 5da93576c2..28e1c140c2 100755
> > --- a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
> > +++ b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
> > @@ -2,7 +2,7 @@
> >  /*
> >   * U-Boot additions
> >   *
> > - * Copyright (C) 2022-2023 Intel Corporation <www.intel.com>
> > + * Copyright (C) 2024 Intel Corporation <www.intel.com>
> >   */
>=20
> You are not using U-Boot main branch as the base.
> Please rebase the patch on U-Boot main branch, I will review in next vers=
ion.
>=20
> [...]
>=20
Yes. This issue happens due to Git auto-merge.

> Regards,
> Tien Fong
