Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD98E77188
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 01:51:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62A968021D;
	Thu, 19 Dec 2024 02:51:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="WI8SbUCj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E33768022B; Thu, 19 Dec 2024 02:50:58 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBFEE8021A
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 02:50:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734573056; x=1766109056;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=dY7EZLurdcxBhjybrfMFpK7WMFeByM4epOgNI3P+zzw=;
 b=WI8SbUCjEuC3CS3iBdlx0FIVVwkRrdEEAboP2Vkj4/y0OafH4tgubNQL
 n//iUOQ4TAJxfcvUB8gkW6T7MADSGqAwh0jlYM4QtJIDy592NuwVjcQdt
 7bk8+LvhAsPhJxxUypNJUsSqlajy4gpzwmKq5PxaBTkkQqz8KneW1Uo8D
 cIyfTyDD01/+AXUbeDgbI9bdsBsUbVcmtADjpZ/R7fkREbhvUPN0I4dJb
 LkBk2/PNs+oPPV6mmrFMmdYczf2FRaselV1VYJMcGXcei5WDItysLhbCw
 fslZUeoOjzHZ9KAx9R2f9yclhrgAEjylNqhmrdPegn43wvRGpwomtYdE5 g==;
X-CSE-ConnectionGUID: BlnOcHYnQUuC3fJqcMzx3g==
X-CSE-MsgGUID: Yd/hQ9i5Sdqo1yBzDSSj7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="34961200"
X-IronPort-AV: E=Sophos;i="6.12,246,1728975600"; d="scan'208";a="34961200"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2024 17:50:54 -0800
X-CSE-ConnectionGUID: 4VRdhtaoS4qqxPd3DA69Vw==
X-CSE-MsgGUID: QMAlX+HOQti5cgVIfyAEYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="103124411"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Dec 2024 17:50:54 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 18 Dec 2024 17:50:53 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 18 Dec 2024 17:50:53 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 18 Dec 2024 17:50:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aceIvYH/XC3U5X3HbwqMK8ENxjxXWmCSfvlZH+0LFfN35Bzfn6zaDjz3oI7Z0hYmOQenjV5d5+xAyPbq5GIvqyD6VGCv7pd9HziIH9S8ErrQY0sSkjXvIf4Fw1r2eqhnHTclHbWBdF4GUx1nlrq4qWEQax0SBiywwDt7IyKnOONdfq6hiw+uw69u4pZVKJSVL7ldqg5NsTn/uKUe5SK0lBpofvrjPfiJsnZE+RNC8ZcPpZyxJ58uOwt1CFG+x5FmIeT4x4m7GG6rwv7xEsxbf0RBUSGR05rTPjwgrbqI7keVSnV7a08PKMJlSMI9vqd4KadCBJoUySQjXron8n5Gng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dY7EZLurdcxBhjybrfMFpK7WMFeByM4epOgNI3P+zzw=;
 b=v7gQAGzw4vS1MM7KN2nw6NFkGnbU8n+wZmVCavzlDPtmCFF4P43HKeCLU3ncmfk4KzYPt70nTHT2M0OLfOZyX+N0zgsIOk+8wydpJVUS2+tZtVqPz+TB2LLo2LetE+zX2B9PfVrYmI7g7DJ2ET2ayE/tKvjpTeDXmmpGtba4bn1O1SHGXrc0WEbXAf/PkFAXVWtKUIknRhq36n+pfY68IMZJX0xZ6VDMBG9lXI1NpOtetYaee+5cXUOZkxiPNZHkLdO7aSnRg+zmTPlsuf38WbH2mrr5v2rSKh7h1hpZeGi3n7CroVZCYtep25SPIJlDw9h1oKehkwFwQTN7q/dqGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 CO1PR11MB4868.namprd11.prod.outlook.com (2603:10b6:303:90::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.13; Thu, 19 Dec 2024 01:50:47 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe%4]) with mapi id 15.20.8251.015; Thu, 19 Dec 2024
 01:50:47 +0000
From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
To: "Zamri, Muhammad Hazim Izzat" <muhammad.hazim.izzat.zamri@intel.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>, Tom Rini
 <trini@konsulko.com>, "Meng, Tingting" <tingting.meng@intel.com>, "Hea, Kok
 Kiang" <kok.kiang.hea@intel.com>, "Maniyam, Dinesh"
 <dinesh.maniyam@intel.com>, "Ng, Boon Khai" <boon.khai.ng@intel.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>, "Lim, Jit Loon"
 <jit.loon.lim@intel.com>, "Tang, Sieu Mun" <sieu.mun.tang@intel.com>
Subject: RE: [PATCH v1 1/1] arm: socfpga:agilex5: Fix system manager watchdog
 mode setting
Thread-Topic: [PATCH v1 1/1] arm: socfpga:agilex5: Fix system manager watchdog
 mode setting
Thread-Index: AQHbRsnOVNJpVKpZhUS72X8IW5tmObLs4dTA
Date: Thu, 19 Dec 2024 01:50:46 +0000
Message-ID: <DM8PR11MB5592F6A7AC540DAAA3454E1AD2062@DM8PR11MB5592.namprd11.prod.outlook.com>
References: <20241205035600.10545-1-muhammad.hazim.izzat.zamri@intel.com>
 <20241205035600.10545-2-muhammad.hazim.izzat.zamri@intel.com>
In-Reply-To: <20241205035600.10545-2-muhammad.hazim.izzat.zamri@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|CO1PR11MB4868:EE_
x-ms-office365-filtering-correlation-id: 3d78e6ca-9612-4f12-2f0a-08dd1fcf8ec0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?cWx5SI6RSzXKXDgkKzV96qd+tNvuaMjieaNoCzC7w35ytlDf5DP6vAugS1NF?=
 =?us-ascii?Q?IYGg8RpxB34koV92xNjyXCJ0qkh7Z4maY2g/JwQuqGAmskqisoIhAM2aRvvb?=
 =?us-ascii?Q?v8pXk7xmCQNb0rUv+mMlYRkJFogsOmi6GkMT55M3EQvJSSfdAcQhFiZ3FyUE?=
 =?us-ascii?Q?6ZKaRUnfnRrvEZkE8adwoZKZalvlpUQACcWhNWBmOfs2t75FZz+bpynO8W6Q?=
 =?us-ascii?Q?wf9LoyBeophVsxoKxdmGKIYnq+pjLepGgevd9aM9aEAqzZ2hNN5h66VXKsaw?=
 =?us-ascii?Q?cQDD6avlYTmMiDUfTah0UCnVA2VMEeAgtVv4+mjbTV6zOT8M6zinTa2obXW/?=
 =?us-ascii?Q?7eRKjsB0pIeLg7I6qNjMifE4EeGaNAjAkQsxTVtsuXk6nO+Sburu5+Qw7dO8?=
 =?us-ascii?Q?QpROkEQ144YssXcCqGPrt9YUaBRcFPTxuvrps2DDSvjuFDWoKH+42xLptPSo?=
 =?us-ascii?Q?8Pqobzd9AUkvPGta1B657LxOgxv8CZ6XiQFFzlTbE8O8aP17Aa3WIESsjWR5?=
 =?us-ascii?Q?SojWR+zpnFesmuwNJdnKBRpFAndRTcQG7VRvSZjc4bJ5/bvFlRFWjTR+sxan?=
 =?us-ascii?Q?mfqpTFhwqbnfJxUeGflt6+LgxIQTRe5NTWokEse2AKf/0Sh5l3GYZJc8q1Rk?=
 =?us-ascii?Q?SjYh9tWFCGurFvmSJR4zwJqc/PjeFxha2bQaJeWDHo/qgdXGxCO1BVE8YUkc?=
 =?us-ascii?Q?frhwhgakpjubZD8qIIhHybWpUSmCJFKIWkCEWKPWVa2K614uehEnQCC7dVTl?=
 =?us-ascii?Q?1bB+t9qv3azp8HW7bW9UE8hKk+7KUBF2C5a5cDZ9Sl+F6vxTsp1kmDNKVwAn?=
 =?us-ascii?Q?7kNTAMJlTNL8sKpIzqaNzH+WG+M+Db6M0jgApW04RGhgbdefpcm2ZZHq2uwE?=
 =?us-ascii?Q?NHQDWdmjWkjp9waqe7I1h1YK5olN77iQSxmpRCazEu5kbv83u9rfjNMjus9T?=
 =?us-ascii?Q?Yke6w6DCnodfWlXjVzT5LA6l68FB35lxNepBW0ZnNG9OBedN310UJzRUATvj?=
 =?us-ascii?Q?KQP4fHGh0uHGOAKPT8ShI8GwEw9oYNXyyvIF3ZKW3AjLd6bFNAWLTZqRCOu0?=
 =?us-ascii?Q?GYsVPnJIMqAuQv56T6fr2OysgQCqv8loE9AKHDuQK6n4dPOr3UZORL1YqyIs?=
 =?us-ascii?Q?moZI0Q72K6ivDlsnyaX8Yg2cRJc2eGNwfDDufvXV/CetbbM7yQZi6PAmcIDw?=
 =?us-ascii?Q?t0ApjczjwjrVDj0YgrnJ24FWaym0AdQbIIefc5bVGTKqDJQIhOIEnWuqUugJ?=
 =?us-ascii?Q?UE3TAOJICm3NqOIcqXTKz2ihuiTZ29baJ+znFIyLw0EdQl2pW1MlGadOqPrl?=
 =?us-ascii?Q?+wwM+9KpaFcsISsxoNoGz7OmdfiFBdg01HAMXfsk6rEErIq8xMvWc2raCdNw?=
 =?us-ascii?Q?DSvzTUn7AH1vhw/pc/mK/pYAW4kZM42FdASnmLGn2a0TiG6zl4MLJXeM/Y1L?=
 =?us-ascii?Q?FdJCFKd/Pe/oCMFZhfly9vKvK8ley+Zz?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5592.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T4DrPh9WSv+A9SrHfwksAVvWJsx73anzr4pdcHoYNCKZplBZhL0LOrw9DjB4?=
 =?us-ascii?Q?q4P8+xDB5z/3r2ps0iW9iikmJF6bw4hxJNfhPAPCWHEMJLVFgDc+MCYfO0PH?=
 =?us-ascii?Q?31wpEncJgPTRAlkHWjKXLaPUEUHFr/VcvRwNjK0Mo9nFwCVeG2cbefzlac1+?=
 =?us-ascii?Q?ot9KSx1MlO/FdZ45b3xmaoElsQLZzB7Iur6K8UkgSYUbPr2shgRv0zJWdnIV?=
 =?us-ascii?Q?VYq1RJKrjnTKanNsT1zkq64N3ctJy6I/eI7eFz5YaNqdmoz9AyY3yLig4YR6?=
 =?us-ascii?Q?gHQgSHC35k3V+IM4jrw9YgYgljDQiTbAOrqciPsSN8FqTRit0wHbGVYDCr6i?=
 =?us-ascii?Q?HAx+jicgYeVMkx6mtcn1xLPDbZrwo8ahPJGyqrQNkBWVE2jsl4gJblVraB9u?=
 =?us-ascii?Q?qPeL01fmyRd4pPKOsEHZMhURcaEqifjQA+32pxpdNtwfCSeP2lr6rIkCGyQp?=
 =?us-ascii?Q?++BXfmaG01XbgWdQLn9GB1dLafevD3fUY1vGRu1gECyCB/xKp7VSDNWPsSTi?=
 =?us-ascii?Q?bxfTO62X+GaTLzWVWenuRW/EwgNEfAswzWzG/zWBJVClEa1QlxE7ikOj29ZI?=
 =?us-ascii?Q?MEqzCr1y1fMyQeDBKStj0ojep5lLVwGOapee5wJGkW9NAY0vqQbO7EDAT63/?=
 =?us-ascii?Q?N9egI63BYu7i4XkNV34NI83Un2DkvgnxbGR+AwNs4HP7WDtg6M/+aiWRQsrh?=
 =?us-ascii?Q?z+KaYJ3k7R4ZBb2fdk2Fw5+qYPUgv+co46g2ZMmEt1/j3coAzUpP4XPZmElz?=
 =?us-ascii?Q?2IUpg2rEmCzTF+vNwAwS3azlxj9IgrnCQRggYZDWNNNvSXmzCoUUjnPg4uJt?=
 =?us-ascii?Q?Ngm4VpRwBMfALNwfjuA8tg0aT0C93XpE4mO4lJlA/0Bts2k3DUHfHVhfZrqj?=
 =?us-ascii?Q?I5xojVyxFTksr3NtvU4efcMG//o5yWDUHA/+fnUx7TrhLFYwv747jVbgNckQ?=
 =?us-ascii?Q?nwrWnxV/khnMXAUoEDgVNml/68dzejSrS5m/9zIcXWChG0Fd6/NTgJ6ZqVWa?=
 =?us-ascii?Q?nm4lD2Ld7rRM2yUkyr5s9ZQPGDuKZN+rUYH/dMEiCx/ukcx1cE50khY6JDMB?=
 =?us-ascii?Q?MxTTyipOAvuHlMc0TxD7CARyREkgVMhdy8Yo3CyDfNlJQCSxPPcfj8buKQUM?=
 =?us-ascii?Q?nZKCCw9O+7hMrUu6RXpGsqCaBqdmVKTPlv0W3o0yQscyC+LD7s9DxTZN0ylN?=
 =?us-ascii?Q?TCr7kdfnvY0qW1uEG8PN1taodMBmjH5hP2cKVgirsTGUSQS7jgSy7z1qkzNo?=
 =?us-ascii?Q?x6mQQLB74/JsKUZozv16Q/GWa5q8CDkF0WqOWF+mQDgrlzukhti2KMhaz7tV?=
 =?us-ascii?Q?OtOXY0qHA6UZeZ/Tm9SSiyDz6Hlu8oLSHMcXc/rW1uEOH8gArCzWhjOA4bLy?=
 =?us-ascii?Q?HE6LwKS9o9UsWA4ftHuD5Zrq0gkxhiq83He/HGWuH+okaqGZm2zXnXzPXk62?=
 =?us-ascii?Q?0pLOq8ScD0WY0SgGyU1YznT8FSzqcOaluy59J1F1BQ6EteqAZ2FRLRv1Q72l?=
 =?us-ascii?Q?lOPA8BKEFdDW/I/ym5G/30v+eMllqvNt7xDalvfBhz/et0JyUSaPkVxuEjff?=
 =?us-ascii?Q?Wsp7+s9W/7zAo3ZSnhwHywt4N6YNoqLnj8BtjMf3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d78e6ca-9612-4f12-2f0a-08dd1fcf8ec0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2024 01:50:46.9500 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 67p+9jYsGyy/9GyaVe+qSayQSR6tVpinBIVcwlzfeloacntRR9aS1k798H+pBAwSdfvkrXtwRV3Yx6TsG+upCkTwGn5CDGGr6xOA1akyd7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4868
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

Hi Hazim,

> -----Original Message-----
> From: Zamri, Muhammad Hazim Izzat
> <muhammad.hazim.izzat.zamri@intel.com>
> Sent: Thursday, December 5, 2024 11:56 AM
> To: u-boot@lists.denx.de
> Cc: Marek <marex@denx.de>; Simon <simon.k.r.goldschmidt@gmail.com>;
> Tom Rini <trini@konsulko.com>; Chee, Tien Fong
> <tien.fong.chee@intel.com>; Meng, Tingting <tingting.meng@intel.com>;
> Hea, Kok Kiang <kok.kiang.hea@intel.com>; Maniyam, Dinesh
> <dinesh.maniyam@intel.com>; Ng, Boon Khai <boon.khai.ng@intel.com>;
> Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@intel.com>; Zamri, Muhammad
> Hazim Izzat <muhammad.hazim.izzat.zamri@intel.com>; Lim, Jit Loon
> <jit.loon.lim@intel.com>; Tang, Sieu Mun <sieu.mun.tang@intel.com>
> Subject: [PATCH v1 1/1] arm: socfpga:agilex5: Fix system manager watchdog
> mode setting
>=20
> From: Muhammad Hazim Izzat Zamri
> <muhammad.hazim.izzat.zamri@intel.com>
>=20
> This commit is to fix the system manager watchdog mode setting to support
> until mode_4 for Agilex5. This changes can refer to system manager regist=
er
> map on wddbg fields.

You need to improve the commit message, the commit message should contains =
the description of issue you want to fix such as why no issue in Agilex dev=
ice, and what / why this solution?

[...]

Regards,
Tien Fong
