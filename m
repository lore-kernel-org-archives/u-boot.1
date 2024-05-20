Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 401F6C25B78
	for <u-boot@archiver.kernel.org>; Mon, 20 May 2024 13:33:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09408886B5;
	Mon, 20 May 2024 15:33:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="dVMx3U/T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA48688572; Mon, 20 May 2024 10:40:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C5D888659
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 10:40:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tingting.meng@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716194404; x=1747730404;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=63+75EqpELdUcxhbzcP2wfUmnlmxJ6yScA4tORR0HJg=;
 b=dVMx3U/TOGc1jB4zuDrF2zHlGK4kgKHWasK+mEQxOLQvl1G/w4j20YIg
 UpItlcNdMP9mAt/ppi87Drhe6kWtLTGebsBnz1VQbb6/CypN31PNPFpnL
 MBzC1+b1I68DVKdpuyKb7Cuydt2TsRJ9QNAM14gPakxTHffOmj2TnbYFG
 VKEdkgVLd+rAfAy6o9LCp1nrMn5D4+3Bff+ClAgeiRYTkwlqVp9SSM0vT
 TuDKPjK17I85TPAZbkbQOMtciCmFrD0f4GG+yhwaawsdcVy7MsNjRNeAo
 2CJU+wVlBxcvNewSpCvrNemveKRdWkVK8O+DV2Y0EikZ3HUUvuYVgPPBD w==;
X-CSE-ConnectionGUID: ENZ4hPCYTg24PYww8P0KAg==
X-CSE-MsgGUID: eF+YlND2T5eWDLt0yKUySw==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="12250455"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; d="scan'208";a="12250455"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2024 01:39:54 -0700
X-CSE-ConnectionGUID: ubh/fd4DQkqVTzZTLP5Qiw==
X-CSE-MsgGUID: MUUdqFGwS5qaGSDXfBUntg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; d="scan'208";a="37227699"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 May 2024 01:39:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 20 May 2024 01:39:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 20 May 2024 01:39:53 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 20 May 2024 01:39:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4WkTTdsCQmJFaH1zWcui2WcTijB81ZbIHb0tvkNPihwm3jphq9DIrJw5VO4H7tKXZZ/mOEyruHUFLviFDqD2e9p5FAMIVIuu4y6eUgp32JX/Zxjwscf3l+nbjoilhc3T1WJdcFWDTcprBzI8STUK0HyEQxZxJKv+qUwb4BVSkaauyy1iSAT8XrTUk1XFEuR6dz4ehOVRHKZrywzUczlEYwq/4I/Ae3u9AsSI3hk0mrHq9qFUMHIJYi8vBCTiJ5YTl1sfOm6q2/NOhir4hwQSewqELb4HM9IL8emVIT56PXLIwRcKEISwB1dIqGo1aV7Rdzy9KZO64hI4+RE8sWcbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZhD/fxJ0j1sk+I8MLFw9dUhqqdVkFSgHhIlRbdvwFs=;
 b=mP+kTHEdCD/Jz9iRGg9X47u0yeayrKNpwKExk6+In42M5yiVBeTiOGZcV5VB80KeUxnqqv9xd4A25GsqvfNKePktjq1L+vTvxV1AxMCy2GIhd3CEGXgiKV6bm12M2jMf0cCgj0j0WThyfjHJj0we1anBzuN9G/r43CqD4pMZ9tiaRL5KwWK2Vq7xTzU3qoiLTKTeHWItd+mGQ1ig3+QMciGpNOxYa8+SCXskejM9PzJh1ZrpKso/eE61TS/g3FLMUaxz/INf5k2mMV6v/U9RejX1lt9nT6wcRiao0o0Qo6ildT/lL5M+SEPgd7R9V92PoPOxuvt4UEhV4+kxd+BnWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB4877.namprd11.prod.outlook.com (2603:10b6:a03:2d9::19)
 by DS7PR11MB7931.namprd11.prod.outlook.com (2603:10b6:8:e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 08:39:51 +0000
Received: from SJ0PR11MB4877.namprd11.prod.outlook.com
 ([fe80::c314:4647:3665:a5ab]) by SJ0PR11MB4877.namprd11.prod.outlook.com
 ([fe80::c314:4647:3665:a5ab%6]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 08:39:51 +0000
From: "Meng, Tingting" <tingting.meng@intel.com>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Rayagonda Kokatanur
 <rayagonda.kokatanur@broadcom.com>, Marek <marex@denx.de>, Simon
 <simon.k.r.goldschmidt@gmail.com>, "Chee, Tien Fong"
 <tien.fong.chee@intel.com>, "Hea, Kok Kiang" <kok.kiang.hea@intel.com>,
 "Maniyam, Dinesh" <dinesh.maniyam@intel.com>, "Ng, Boon Khai"
 <boon.khai.ng@intel.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@intel.com>, "Chong, Teik Heng"
 <teik.heng.chong@intel.com>, "Zamri, Muhammad Hazim Izzat"
 <muhammad.hazim.izzat.zamri@intel.com>, "Lim, Jit Loon"
 <jit.loon.lim@intel.com>, "Tang, Sieu Mun" <sieu.mun.tang@intel.com>, "Lau,
 Wan Yee" <wan.yee.lau@intel.com>
Subject: RE: [Agilex7 M-series Platform Enablement v1 16/16] configs: Add
 defconfig for Agilex7 M-series
Thread-Topic: [Agilex7 M-series Platform Enablement v1 16/16] configs: Add
 defconfig for Agilex7 M-series
Thread-Index: AQHaqBsWRljC9lRudk+YvqB8Lz5v3bGbifgAgARIIcA=
Date: Mon, 20 May 2024 08:39:51 +0000
Message-ID: <SJ0PR11MB487708BDA5E29B008E20BA35E0E92@SJ0PR11MB4877.namprd11.prod.outlook.com>
References: <20240517052701.12949-1-tingting.meng@intel.com>
 <20240517052701.12949-17-tingting.meng@intel.com>
 <20240517151546.GJ2568172@bill-the-cat>
In-Reply-To: <20240517151546.GJ2568172@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB4877:EE_|DS7PR11MB7931:EE_
x-ms-office365-filtering-correlation-id: 1f62d90b-ea47-4a41-dd6f-08dc78a86a30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?Jr7iVe/52EbqtWQ5EKrR1GxgTzyls/dshsDukxBGBqa+ctJ5Sqth3jjgwWMV?=
 =?us-ascii?Q?4A1p48+rzPiIyTr6vhUEozu3nIYuCzREriVdCoxC8Rhsh9E3ignxpS2s1qlB?=
 =?us-ascii?Q?mQtKcfhB2ga9GWo79CyYydznPmwgTuO8AsFcyWXY5V7PME9LwQUQQEHj81jd?=
 =?us-ascii?Q?b6EMpFGkMpRHdjyILLSFNLHBb5yHOU52Ot6VAd+8P3sFBNf0XG7ClaKwznNf?=
 =?us-ascii?Q?uZhcMRBhCcY/F+y35L6GnN7LeBcl6X7P+ujKPboxQVyqo0oe6l1b9q7DuST7?=
 =?us-ascii?Q?aQ9Uf2DpwIc4AYIM1oo23rNrhXComYI9IEEUO3XoDgsWuoBo5Qv96AoDZI8Z?=
 =?us-ascii?Q?GGc22loYXpI5+8g8cMetYhdu26D1+dCY+ggzgnT4mUNsgFZOuX6Nd3T5QrBZ?=
 =?us-ascii?Q?L4tMxwNWXoW5CtKMhOShltdCiBOea1wVmbAVstXbUcay0yDQYkprZQIuPjXr?=
 =?us-ascii?Q?nOTIMF1IQfQ5nsWN3gdJ6HyAlDT+lFHRJsTysddcky2x8pW6tnRsgpMtFiMQ?=
 =?us-ascii?Q?d0i5SVnU32DctMdlHcWWKRQAbZd7Tf7hNRCBoa6KLFoDuoU1ZiobGbDw3J48?=
 =?us-ascii?Q?DGil5Frzj0e3/4UW8+T5w1tw7x6x0//NGnnq52AFPr5anm2ycjwPEI4oegNu?=
 =?us-ascii?Q?dbvmOPlAcxnhajgaGTeVaNlC/PVMFzDORWFmyaJZbQqwEdWbsVSIuBCgomm2?=
 =?us-ascii?Q?GTJewdkjnu3Q78nhfnPnTxEKXI+O2b6tiAud/NU2oZMiKiCaSPrtiUpXcC6G?=
 =?us-ascii?Q?GKaD6gbjmRe/6VZTkVNBs4x1P5Uc+aDwdZ4EbYAQR2dq3qGwTv4iaT14iFRn?=
 =?us-ascii?Q?Xojn07sFtevKcieBjAIdStGWBOiSk0w4Mst8947NSr2WrBXRjDPl68oav+gm?=
 =?us-ascii?Q?DqDa0JgJNWuKl/FApK894Z5S+09J1itxqihPLYS6kdIARojXvavSrShqTbCB?=
 =?us-ascii?Q?X2Kw+tSWYWFw6VlM8CcRVE3KaRQExdgchXA88ixyMK+TyM8QGwKXFdBkBgS/?=
 =?us-ascii?Q?B+f9II9D0yefYTVG2UhG/3vFqJzvG6VgRSaTB6W2cM+/TN2I2Oq5lA3LqERF?=
 =?us-ascii?Q?HYEtoEsj/5r+xlsFKesRiF0A4qBgSey2yL7/fCSW/k+PMnNSMCOYXCSIMHtW?=
 =?us-ascii?Q?5G+V8y3hVeZDLLnhGcE4lgz93aRvm11S3NYh2sqoa0yUg38swbYtRhMHTmwf?=
 =?us-ascii?Q?V7+qG2Qx58nREn/RZsnKsMh7HV+loSe/d/h6LlcbH1gg0k8FtdeLaWto4V+q?=
 =?us-ascii?Q?o7IELQbdFHjW+WnWIZVRzQ2Eb5e2z/aKvACUE2dem7DPINBpqzsMnA/DtC2g?=
 =?us-ascii?Q?dPYEJt2AGivzAo1e6FNpJYfp1YC9a5qXYj5uSp50xd+n6g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB4877.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7jgZt92RvnLEOovwca0llB+n/7HzMdApDEt02Ibjsu+ZzP2W6Oe4hHU9pWR8?=
 =?us-ascii?Q?bRz47NN59MjcYZ1qTvNMtdNITzQJ6UFWuUSvR79BNwdMN6VKK98FWgqzO3g/?=
 =?us-ascii?Q?8cKKhncr0LVL3TLOb2qWmaHj3moiVBzaUcZ6b4gRv9lGtHXCOdSSBjsOe3Tl?=
 =?us-ascii?Q?XufVL8wKY74/Ed3nZLLslfKjIOYPUsf7dO8eS7SPlq2Cs+gjdbIhL6TbVVn7?=
 =?us-ascii?Q?BckY9/4gNTZ3ndsUFypAAQ+WMEnFQyuzCTl5ZbIharhg7tHsHG0k/THn6tAs?=
 =?us-ascii?Q?trLTWTd6UzIXjWhuj1V72ETYJWTZoGzb0SL6uKOnltfhPKzarw4p62Sv9LC0?=
 =?us-ascii?Q?xKuTQwuH+jK4eYw61TkSVHE7Jso2UxiHc3cwr8RxOdtueQ5gLebSQ3tz/4km?=
 =?us-ascii?Q?anrUmV6mssq9AznqR2IrA3jJkAXCA/x05cVOM/84zsGCmVo6C6JKSecx/VUl?=
 =?us-ascii?Q?espsWjC1MyL8kkqD9q3SMqyJyJlNiLCt3AsIGNHx58zRwlYKC7o8El+DvFy3?=
 =?us-ascii?Q?O+PwrrnSScd70rwlxpsJDZZlNNL9LwU3MdiBos0xcwfOy0deSv5fR/mx+NJ3?=
 =?us-ascii?Q?Nk0LWOlu3ZXeQr0TKHHwLnmVaoEGn2bBkGtBuZDJr7rzk/wOfrPvGX/q5dUS?=
 =?us-ascii?Q?1leRKHQT+7wiqu2/TOMWFTCFOunOZ8FLZQBf4g0O/J33kmg0Zzewf1/NoEzW?=
 =?us-ascii?Q?IkHI8SPfTxgy7lD85iPeUk2i9sQ398jgDoAWtwFwbJDU/D1nQmXIv1Yv11Kp?=
 =?us-ascii?Q?zepWAP4QDb0azACgWO0d7gU48ARV+HF7+6RhFARS5I2glYDT9onJavzKh9ic?=
 =?us-ascii?Q?1sQW2wsZvxg0kP9gsAsXgyH1A1jEbq7yzNEGnSJ/FAVbKTaJwc6SRdtakn40?=
 =?us-ascii?Q?/kZXR141pqpFvI8H9BfGptZWlawIJbKJW863g1asNtDEMq+FukWPC9nEbEmz?=
 =?us-ascii?Q?dpp2E2w/RdoiNCSA4kBFWuPNV5HqKE4T59fTUWu9rhxzUVIyRNFyj5RwUejG?=
 =?us-ascii?Q?YtAzokkzhpqskCfOP9YDI6e1ZzVsCv6ufut2gVsaXQZB9+ow5mvfh+8jTp6v?=
 =?us-ascii?Q?0RLrQ5etJuMonl7esVXR8tANnj9ztLSvHqSi66NQ3cQWcjufII1Wz6y+fSqY?=
 =?us-ascii?Q?QJT+sbcrtXe7NAGxLmm4U2HF+X4ecCI7cTvkUp4y1JVEjGOHb5v//pl4qjq8?=
 =?us-ascii?Q?gJe6MHSdRQbeiYthS27PBfzBO9P0nuRBCOn2EuIKwqVhP3Ur5ZKzGO0MNdX4?=
 =?us-ascii?Q?dZLZLWiIzSA6Vxy6JlsOblUz7z1FxRQPXMpwh7qE0rxwFIvsCaOy5yRylqfX?=
 =?us-ascii?Q?s2IO988gyZJh8TFB7T9k3sqA1zsclRfRRAO6BIvk6XruI3A7kdC6bbFmxnxU?=
 =?us-ascii?Q?NivuWfG26dq637llszqS44rFXncOjLxzw7LfVVeGO1KCHzcoTGNzXto+FxoY?=
 =?us-ascii?Q?aEnKpVUbiZyDk17CxcwuZZjxDofx3O1eiAgkkeVSuFl207CxZ8aL81RApHKo?=
 =?us-ascii?Q?+CE/ngFlotVJldAjVyEKi27a2gnyNxu9bfDVuwzZn5aiGzNrAdGFul9n86xp?=
 =?us-ascii?Q?9dVJ0nNfoFwlHLTPfPW1IEtlVxRKcyzCvJ1RueNh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4877.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f62d90b-ea47-4a41-dd6f-08dc78a86a30
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2024 08:39:51.0785 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgr7ViQQTeLbQO77V8UU8Lr8RihKRO6PIZd5PT5IimLwovdo69gL0omceJ63r2cgMSykDbEI/6F2H3ATV+wT5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7931
X-OriginatorOrg: intel.com
X-Mailman-Approved-At: Mon, 20 May 2024 15:33:14 +0200
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


> -----Original Message-----
> From: Tom Rini <trini@konsulko.com>
> Sent: Friday, May 17, 2024 11:16 PM
> To: Meng, Tingting <tingting.meng@intel.com>
> Cc: u-boot@lists.denx.de; Lukasz Majewski <lukma@denx.de>; Sean
> Anderson <seanga2@gmail.com>; Rayagonda Kokatanur
> <rayagonda.kokatanur@broadcom.com>; Marek <marex@denx.de>; Simon
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@intel.com>; Hea, Kok Kiang <kok.kiang.hea@intel.com>;
> Maniyam, Dinesh <dinesh.maniyam@intel.com>; Ng, Boon Khai
> <boon.khai.ng@intel.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@intel.com>; Chong, Teik Heng
> <teik.heng.chong@intel.com>; Zamri, Muhammad Hazim Izzat
> <muhammad.hazim.izzat.zamri@intel.com>; Lim, Jit Loon
> <jit.loon.lim@intel.com>; Tang, Sieu Mun <sieu.mun.tang@intel.com>; Lau,
> Wan Yee <wan.yee.lau@intel.com>
> Subject: Re: [Agilex7 M-series Platform Enablement v1 16/16] configs: Add
> defconfig for Agilex7 M-series
>=20
> On Fri, May 17, 2024 at 01:27:01PM +0800, tingting.meng@intel.com wrote:
> > From: Wan Yee Lau <wan.yee.lau@intel.com>
> >
> > Add defconfig for Agilex7 M-series.
> >
> > Signed-off-by: Wan Yee Lau <wan.yee.lau@intel.com>
> > Signed-off-by: Teik Heng Chong <teik.heng.chong@intel.com>
> > Signed-off-by: Tingting Meng <tingting.meng@intel.com>
> > ---
> >  ...onfig =3D> socfpga_agilex7m_sdmmc_defconfig} | 110
> > +++++++++---------
> >  1 file changed, 54 insertions(+), 56 deletions(-)  copy
> > configs/{socfpga_agilex5_defconfig =3D>
> > socfpga_agilex7m_sdmmc_defconfig} (56%)
>=20
> You need to put this in a MAINTAINERS file.
>=20
> --
> Tom

Will add it. Thanks so much.
