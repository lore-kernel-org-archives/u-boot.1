Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0542AC02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 04:51:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62DBC801F5;
	Wed, 22 Jan 2025 05:51:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="BaYh6KZJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 417D6801FB; Wed, 22 Jan 2025 05:51:54 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16A878001F
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 05:51:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737521511; x=1769057511;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=0g5GYh2v88dUWJCKD0TDOgWE7vqKGkYx52pRqhcz8u0=;
 b=BaYh6KZJKEM6lBMGTpyBx0GSIhCAOEcdTEmjJ39DbtGqw8wmIptzGa9c
 ZxGhG8opVAZ3W9quv//HRMpromt3gScYKLxjhcjcnTPsqETwo5Jr2bqEo
 P6VLydY2DsiBE0NR7n9TeKdY67ORUHMKgfYFfgxlYtqKo4S/bNT30tHti
 7/KBErV7p3tdl1+sAOH3XnB102xhurVt2LsPBvLWjRBgdlVeek4QDn2Ec
 CxCw/a+K3pFiVE8M/oogKEslFL+U7yxDX7saBtBzvVZJc2t3LS2c3FPDj
 5GDQD3MZ2RnzUYaDkAHOdoW8a8UUwuLwx6TpyvUINoef9vnhflq/NHZ46 g==;
X-CSE-ConnectionGUID: OWQ0y6TXT7azOewgL6Hb8Q==
X-CSE-MsgGUID: j6+f7mvXS9mm5lyJM+ZUhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="48456965"
X-IronPort-AV: E=Sophos;i="6.13,224,1732608000"; d="scan'208";a="48456965"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2025 20:51:49 -0800
X-CSE-ConnectionGUID: RYrQYIUxTyuma7c+avhVDA==
X-CSE-MsgGUID: hklRFm1iQByK4nJTv3kvqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="137896394"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 Jan 2025 20:51:49 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 21 Jan 2025 20:51:48 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 21 Jan 2025 20:51:48 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 21 Jan 2025 20:51:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HiGlXVvW82ygS4vM7QjZWDj4D5zdlio+GuoLZdJV/XLMd/oX9R6/Kby6dBjZhBKIs5buYPhl6K9lYnReporCcLVkyx/W4msphemMNJ4wMS4vOvIhybStstY/FMX08EkCzzGujXjuAVoDmzUJfPh+rV+J5zSkRZL23y8Y6G40JJ1q17Ovfx4OTGinwtKtzP6yj8rPVZKKtG62Mf00mY9ziwxROw6VluMcSYLNCfpRfSC0UQDFDPcYjSTKK1LMEBOP4BnDp0e0raiM+G9FfsSd9LtbXWGIE4lQ6tp+E+a96Yb1Os0HTTmZV2B04wIPkFkd9C62JIKDjznOEBCkCVlZBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lhT4x6zIJ+XGLkNXVQQEgOVIrhtz0YvvSIgiB7i/Q6g=;
 b=IGjy6guVeHrO1I2/fyHtat0abN+rAX1WRGzaCdoaUQwaZdCt/JePRhpKcyRWTP/chXnuZv2sDyJLrn8KK5ncAYKNeux9cbWk9svTV6K02pnKtbBNM3UrLAN+HuInnFjwCHJqljZMtluJSGpWcqMNYVWNukyb1cq8kSAUAWX8oaU0iOfnfuJdhwA2K+VQS/bvow85sRL9MAHboYbAbfKvQD8phNVORWT3/488J01NbVRQVP3X2DZk/V0tJ+8feSqC8ZulMSPUopK/ARCHslp1Ml66ya160ihoBN+p2O4L31LTmLJVQvaYCiFJiD+hJZckJ+BUnDvsVhWx69QCLvHEig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 PH7PR11MB7097.namprd11.prod.outlook.com (2603:10b6:510:20c::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.20; Wed, 22 Jan 2025 04:51:32 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe%4]) with mapi id 15.20.8356.014; Wed, 22 Jan 2025
 04:51:32 +0000
From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
To: "Ng, Boon Khai" <boon.khai.ng@intel.com>, Uboot Open List
 <u-boot@lists.denx.de>
CC: "Hea, Kok Kiang" <kok.kiang.hea@intel.com>, "Maniyam, Dinesh"
 <dinesh.maniyam@intel.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@intel.com>, "Zamri, Muhammad Hazim Izzat"
 <muhammad.hazim.izzat.zamri@intel.com>, Tien Fong Chee
 <tien.fong.chee@altera.com>, Kok Kiang Hea <kok.kiang.hea@altera.com>, Dinesh
 Maniyam <dinesh.maniyam@altera.com>, Alif Zakuan
 <alif.zakuan.yuslaimi@altera.com>, Boon Khai Ng <boon.khai.ng@altera.com>,
 Muhammad Hazim <muhammad.hazim.izzat.zamri@altera.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, Tom Rini
 <trini@konsulko.com>
Subject: RE: [XGMAC error message v1 1/1] net: dwc_eth_xgmac: Add device name
 for the error message.
Thread-Topic: [XGMAC error message v1 1/1] net: dwc_eth_xgmac: Add device name
 for the error message.
Thread-Index: AQHbaKvX1c0AaHiabEecFUh1gIlwDbMiQRUA
Date: Wed, 22 Jan 2025 04:51:32 +0000
Message-ID: <DM8PR11MB5592EB50BC2F57E3330677FDD2E12@DM8PR11MB5592.namprd11.prod.outlook.com>
References: <20250117064823.23512-1-boon.khai.ng@intel.com>
 <20250117064823.23512-2-boon.khai.ng@intel.com>
In-Reply-To: <20250117064823.23512-2-boon.khai.ng@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|PH7PR11MB7097:EE_
x-ms-office365-filtering-correlation-id: 806bbae8-8a7c-4edf-0736-08dd3aa070f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?7WLk9LUrK9yPZUsKc0x5fAv9DUGkqt+xqRc5uAcbFrOImPDKDYnTffQnAMxE?=
 =?us-ascii?Q?dmuyrRh2XtR2D/CPFyFEVQWK/cw/9zjS/m59mLIw4AGpmUY8usw9MbRKY1H6?=
 =?us-ascii?Q?LMQki/wibRV4s+X/9DQTodtYiFMBCt7tqp8i5xA3DR05ID0gseDRtT3eHwZK?=
 =?us-ascii?Q?GnRoZkPIUNQQncCrQ0o8QsteP/+A/e+Ssf9b7VRPoLjiKfbl7VJfJf1TEVjo?=
 =?us-ascii?Q?Lo3CreCEXVPBKFo8PdaktEKmn+F/IvVYwPFVS1jD4vco8EZyu7mV0ee7PmLi?=
 =?us-ascii?Q?ylhZvwNobpjMzATKiFSjBc8SrlhcxW6lvepw3k5KZoXaagT7KOr+boMvxTU3?=
 =?us-ascii?Q?Lr+9fJGLnplcb+ovtXxU6YdGJm5Vd3B9KkI5CTr33nYmUT6fSGCmx5BQXKqk?=
 =?us-ascii?Q?hTs9e54x86oqfqFN/eDfKKQKcVjahUdOz/Pcda4QLrt9I5hxnaGvAQYnQ7J2?=
 =?us-ascii?Q?m90kYVe8QmzdvxnhFiBOIoJktOlhCBmY+qVNZAqn+f6v/FS6pNELNz6uccYg?=
 =?us-ascii?Q?mpr4xRpN2oOI1c9h2tavkIrE4J1WDdi9WZEWPa0hE7ddc1zdZLxZ3Bq3Guw+?=
 =?us-ascii?Q?GeOnhVfbWKXuSMX8mL/TuaHt8EQAWtV8FO5PtSVBb44Ytyq9r/P9oo8wbwgb?=
 =?us-ascii?Q?Y3franWmZhkTLk/Lqcqh/ZZrssxKexo2hpWPi1xkudGV4JT+L8A95bSvXNcI?=
 =?us-ascii?Q?xFodxadXGt7vjZfvUn3OlI49SiLuHG1q4POuvT/VRMR3oN2UmxV6RfLbHWKb?=
 =?us-ascii?Q?vrTyjqMdGlRWX0XuJMQFYqOWftgvBYA+pBm1XKF/SRr31XOUX4+JsG7El05l?=
 =?us-ascii?Q?wITOScp8TxmPf78A1WsHnFJ5FXpmFo47r/PkraNP5+q0jK6Ifq2dwED882vi?=
 =?us-ascii?Q?a7DQtdp9v6j7bZtDCEnJRcnZX6KgCxVQb8zzB0e/lemIfbYA5g3b1DdF4Hlu?=
 =?us-ascii?Q?zjjujzkH4R87RPlcQT64L103Zeu330bw7SxA9FCSHZ+RMb+m84lkQ4L4m5xC?=
 =?us-ascii?Q?McYlSMoM5xFkGXN8ZdkxFy3aYYU/a/eC34V0xD151kWaBkgVc4NWVVQx1yFJ?=
 =?us-ascii?Q?ZuldHjUpzB/fL+yvcM7iyj630yMrJaTa+sEYyP/fHXtpw+kRg6vpEUZOSBv3?=
 =?us-ascii?Q?dYwF40XaO6UvpcFGuICJxTl6QL+MT9Q+QErgrosaxXYra4NktNDjDKeNPiCK?=
 =?us-ascii?Q?dI1ZA7zbybcWcMCNdqsUfyS284QFby4WvHLj13XAmgSv+/x7AU0atSvXUYdP?=
 =?us-ascii?Q?/EFRJA8jkhHx1wnSzoNLipnganktn1epQmIvjgoBP2KL7JmwsuVld7BraKSo?=
 =?us-ascii?Q?ZC+1igzP+u2RLz9yDN42FICSc6WXmjhpeaaM/aOMvokIAQn4GD19vxcNPCJw?=
 =?us-ascii?Q?fNbdTusByH9NkC0RqKSdzaYAKhf/RfYJf7oTE2yoPxZ5HfoAjnvD3ZtK3P4+?=
 =?us-ascii?Q?T0dMFPkNdxF+3geIqVa59Fn7xyNIMALi?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5592.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rgQPsQ48VfD+bp6aLHycKIkgsINhiIp+VN+5/Zg9rP4ObQBWE6kxerJ8zsMq?=
 =?us-ascii?Q?OcC1e2JIwAwiUU3I/7BWMWo0gl6x/1+ZAPmRSHDOlJLPv7vcU0TlThBZBCoi?=
 =?us-ascii?Q?9fLaNYk9j2P4B2ocuA9LcN/+BYj0V7n6M+iFfRcCQ4XJpUkExWuWBFvfI9my?=
 =?us-ascii?Q?8EB8MllRed5a8PPvUYiT5degqZZhYhdvhLHlL43BHojzT6kqscv/Owzy4lB6?=
 =?us-ascii?Q?k749FzXY7wLfEhTaTNIQ4XrGA21qrnpdUdVhCMCxhkaTmfajTSnOa3NVU/32?=
 =?us-ascii?Q?qybuaNIJjuTYhKYW8SX/MNqjoau7X5uD4XHGJlSo7/fR9CZ1g02h1s8n4wtP?=
 =?us-ascii?Q?02gbqPcVlmczaP3jhLh+p0TJXf3eIbv9Je6LSvh3aHyy15bbkmRvKkO6nltk?=
 =?us-ascii?Q?gD80/9F6yDF2mGXMCfyaQG0Xzu7BIXtGiaNZQ1czMGtRdlfKQwZ/oMr/Nqy6?=
 =?us-ascii?Q?/rNxo6aFLmrMqQc5DikM2NRW5nDnlzl6GOPSulNJ3zi6ubL4+odBgpCJmUbT?=
 =?us-ascii?Q?8TPkq7VOuqqHpst442R+lZ+vWH/G09/bKln0u/b6xUdbE6UNUlujhC3pkrjW?=
 =?us-ascii?Q?ibjBve2unzO9JCG+CL9oy0DLClpi90A1DMjnaXZ70dW9YVag78MtzbDj2+Gt?=
 =?us-ascii?Q?7uWolt6RzSkd+q1TJsLOA4pHGAC17EM1ClnmmgBkjqh7qzgcEzrOVsTuxZ6R?=
 =?us-ascii?Q?JwewuvyTRWDKNTsFZv4XywM/y+Dt0SzsB2Gc6r8ZJjfpDKnNLCRk/yIECWgy?=
 =?us-ascii?Q?OIRBjAfGmWBC9x5kh97mMOgVHp5MJnqmq+Ar1SAHeLLxfEKqim6f6FF+WOIW?=
 =?us-ascii?Q?OkB/Fy3Z8zLFl5AT0F7qw4JZyD5wl7dwv4Y28wi7ZHHoj94oT9pF6/BTevHy?=
 =?us-ascii?Q?3KYfb2R+NnmdHnQzOrkTvl4VMbpUNywJrVs1DnN3TeSoWjRehEa52AhOYXU3?=
 =?us-ascii?Q?11haja/xHSJc2kylMO6PSipcA8H/v7U77/32iXPJsuz8W3VJeIP0pB013PO7?=
 =?us-ascii?Q?E1zW0lAMPhXqc1oyjIBNKAT9K/DoML2JxW8YJEvr7FITKNvv6gdZ5VWqKSlJ?=
 =?us-ascii?Q?87HTH4CBFGwOU7TLqsKSRjXpWC4puhdWeXFF1QHZHBNu+grB1bk97RC046eB?=
 =?us-ascii?Q?YhjkS4zZzhQT+6+s90J/qnTu6gUFZmStjGzdeUhmpOmApeFKxLyE0nFne0nm?=
 =?us-ascii?Q?hfBXl77fW41f/Y7ggi/+l/pBdEX/xTRSFwClBCcTTLQdRuOYXg7ZGI2Xa0wt?=
 =?us-ascii?Q?0uK9V+8j4Kc7KI55M2VQigxu2Y3BULAKoHgrZU9yeDQBhf5Cxb2Y4+DGp7su?=
 =?us-ascii?Q?Wlj3Z8rby4wjOniUKmNMyUO2OATJs/i4f4v3EMpOe+vfW1UQQ8I/sivbdmX/?=
 =?us-ascii?Q?qrar7AbIsHOX9gxNQjg8euasfldamWi9DHimVLlbhOq38qz+S2/1Qe1/AQ+o?=
 =?us-ascii?Q?O+qhCkR1MTMPKBJVXAOp7T0tCzr8V3vOb6DhIALHPh/3uBnBtNaZee8+JYS4?=
 =?us-ascii?Q?5vb7ewrjQxA8TD1YvEloYiTym1FoRKSwJbDtFKOQheTz7ysQem9qyxPrtKu1?=
 =?us-ascii?Q?KLT7lTbtFQ4xhp/WHVNXSZg30zRTNNB64YMiKBZl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 806bbae8-8a7c-4edf-0736-08dd3aa070f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2025 04:51:32.0390 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 70IZqbGAZ3iVEchZUvqkkO8MmDHQSRUdF3bIy+6PUDYyniXhf/3lc0ylV9Af4CSzfH8FShXPp/Rq8wIT5Vpr/5EeiAFIwWNrDwLinjiD5Zk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7097
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



> -----Original Message-----
> From: Ng, Boon Khai <boon.khai.ng@intel.com>
> Sent: Friday, January 17, 2025 2:48 PM
> To: Uboot Open List <u-boot@lists.denx.de>
> Cc: Chee, Tien Fong <tien.fong.chee@intel.com>; Hea, Kok Kiang
> <kok.kiang.hea@intel.com>; Maniyam, Dinesh
> <dinesh.maniyam@intel.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@intel.com>; Zamri, Muhammad Hazim Izzat
> <muhammad.hazim.izzat.zamri@intel.com>; Tien Fong Chee
> <tien.fong.chee@altera.com>; Kok Kiang Hea <kok.kiang.hea@altera.com>;
> Dinesh Maniyam <dinesh.maniyam@altera.com>; Alif Zakuan
> <alif.zakuan.yuslaimi@altera.com>; Boon Khai Ng
> <boon.khai.ng@altera.com>; Muhammad Hazim
> <muhammad.hazim.izzat.zamri@altera.com>; Joe Hershberger
> <joe.hershberger@ni.com>; Ramon Fried <rfried.dev@gmail.com>; Tom Rini
> <trini@konsulko.com>; Ng, Boon Khai <boon.khai.ng@intel.com>
> Subject: [XGMAC error message v1 1/1] net: dwc_eth_xgmac: Add device
> name for the error message.
>=20
> Agilex5 having several ethernet instance, adding the device name at the
> error message to differentiate between which instance is having issue.
>=20
> Signed-off-by: Boon Khai Ng <boon.khai.ng@intel.com>
> ---
>  drivers/net/dwc_eth_xgmac.c | 82 +++++++++++++++++++++++-------------
> -
>  1 file changed, 52 insertions(+), 30 deletions(-)
>=20
> diff --git a/drivers/net/dwc_eth_xgmac.c b/drivers/net/dwc_eth_xgmac.c
> index d3e5f9255f..cf8227b1b4 100644
> --- a/drivers/net/dwc_eth_xgmac.c
> +++ b/drivers/net/dwc_eth_xgmac.c
> @@ -152,7 +152,9 @@ static int xgmac_mdio_read(struct mii_dev *bus, int
> mdio_addr, int mdio_devad,
>=20
>  	ret =3D xgmac_mdio_wait_idle(xgmac);
>  	if (ret) {
> -		pr_err("MDIO not idle at entry: %d\n", ret);
> +		pr_err("%s MDIO not idle at entry: %d\n",
> +		       xgmac->dev->name, ret);
> +
>  		return ret;
>  	}
>=20
> @@ -172,7 +174,9 @@ static int xgmac_mdio_read(struct mii_dev *bus, int
> mdio_addr, int mdio_devad,
>=20
>  	ret =3D xgmac_mdio_wait_idle(xgmac);
>  	if (ret) {
> -		pr_err("MDIO not idle at entry: %d\n", ret);
> +		pr_err("%s MDIO not idle at entry: %d\n",
> +		       xgmac->dev->name, ret);
> +
>  		return ret;
>  	}
>=20
> @@ -181,7 +185,9 @@ static int xgmac_mdio_read(struct mii_dev *bus, int
> mdio_addr, int mdio_devad,
>=20
>  	ret =3D xgmac_mdio_wait_idle(xgmac);
>  	if (ret) {
> -		pr_err("MDIO read didn't complete: %d\n", ret);
> +		pr_err("%s MDIO read didn't complete: %d\n",
> +		       xgmac->dev->name, ret);
> +
>  		return ret;
>  	}
>=20
> @@ -206,7 +212,9 @@ static int xgmac_mdio_write(struct mii_dev *bus, int
> mdio_addr, int mdio_devad,
>=20
>  	ret =3D xgmac_mdio_wait_idle(xgmac);
>  	if (ret) {
> -		pr_err("MDIO not idle at entry: %d\n", ret);
> +		pr_err("%s MDIO not idle at entry: %d\n",
> +		       xgmac->dev->name, ret);
> +
>  		return ret;
>  	}
>=20
> @@ -229,7 +237,9 @@ static int xgmac_mdio_write(struct mii_dev *bus, int
> mdio_addr, int mdio_devad,
>=20
>  	ret =3D xgmac_mdio_wait_idle(xgmac);
>  	if (ret) {
> -		pr_err("MDIO not idle at entry: %d\n", ret);
> +		pr_err("%s MDIO not idle at entry: %d\n",
> +		       xgmac->dev->name, ret);
> +
>  		return ret;
>  	}
>=20
> @@ -238,7 +248,9 @@ static int xgmac_mdio_write(struct mii_dev *bus, int
> mdio_addr, int mdio_devad,
>=20
>  	ret =3D xgmac_mdio_wait_idle(xgmac);
>  	if (ret) {
> -		pr_err("MDIO write didn't complete: %d\n", ret);
> +		pr_err("%s MDIO write didn't complete: %d\n",
> +		       xgmac->dev->name, ret);
> +
>  		return ret;
>  	}
>=20
> @@ -323,7 +335,7 @@ static int xgmac_adjust_link(struct udevice *dev)
>  	else
>  		ret =3D xgmac_set_half_duplex(dev);
>  	if (ret < 0) {
> -		pr_err("xgmac_set_*_duplex() failed: %d\n", ret);
> +		pr_err("%s xgmac_set_*_duplex() failed: %d\n", dev->name,
> ret);
>  		return ret;
>  	}
>=20
> @@ -341,26 +353,28 @@ static int xgmac_adjust_link(struct udevice *dev)
>  		ret =3D xgmac_set_mii_speed_10(dev);
>  		break;
>  	default:
> -		pr_err("invalid speed %d\n", xgmac->phy->speed);
> +		pr_err("%s invalid speed %d\n", dev->name, xgmac->phy-
> >speed);
>  		return -EINVAL;
>  	}
>  	if (ret < 0) {
> -		pr_err("xgmac_set_*mii_speed*() failed: %d\n", ret);
> +		pr_err("%s xgmac_set_*mii_speed*() failed: %d\n", dev-
> >name, ret);
>  		return ret;
>  	}
>=20
>  	if (en_calibration) {
>  		ret =3D xgmac->config->ops->xgmac_calibrate_pads(dev);
>  		if (ret < 0) {
> -			pr_err("xgmac_calibrate_pads() failed: %d\n",
> -			       ret);
> +			pr_err("%s xgmac_calibrate_pads() failed: %d\n",
> +			       dev->name, ret);
> +
>  			return ret;
>  		}
>  	} else {
>  		ret =3D xgmac->config->ops->xgmac_disable_calibration(dev);
>  		if (ret < 0) {
> -			pr_err("xgmac_disable_calibration() failed: %d\n",
> -			       ret);
> +			pr_err("%s xgmac_disable_calibration() failed: %d\n",
> +			       dev->name, ret);
> +
>  			return ret;
>  		}
>  	}
> @@ -456,7 +470,7 @@ static int xgmac_start(struct udevice *dev)
>=20
>  	ret =3D xgmac->config->ops->xgmac_start_resets(dev);
>  	if (ret < 0) {
> -		pr_err("xgmac_start_resets() failed: %d\n", ret);
> +		pr_err("%s xgmac_start_resets() failed: %d\n", dev->name,
> ret);
>  		goto err;
>  	}
>=20
> @@ -466,13 +480,13 @@ static int xgmac_start(struct udevice *dev)
>  				XGMAC_DMA_MODE_SWR, false,
>  				xgmac->config->swr_wait, false);
>  	if (ret) {
> -		pr_err("XGMAC_DMA_MODE_SWR stuck: %d\n", ret);
> +		pr_err("%s XGMAC_DMA_MODE_SWR stuck: %d\n", dev-
> >name, ret);
>  		goto err_stop_resets;
>  	}
>=20
>  	ret =3D xgmac->config->ops->xgmac_calibrate_pads(dev);
>  	if (ret < 0) {
> -		pr_err("xgmac_calibrate_pads() failed: %d\n", ret);
> +		pr_err("%s xgmac_calibrate_pads() failed: %d\n", dev-
> >name, ret);
>  		goto err_stop_resets;
>  	}
>=20
> @@ -485,14 +499,16 @@ static int xgmac_start(struct udevice *dev)
>  		xgmac->phy =3D phy_connect(xgmac->mii, addr, dev,
>  					 xgmac->config->interface(dev));
>  		if (!xgmac->phy) {
> -			pr_err("phy_connect() failed\n");
> +			pr_err("%s phy_connect() failed\n", dev->name);
>  			goto err_stop_resets;
>  		}
>=20
>  		if (xgmac->max_speed) {
>  			ret =3D phy_set_supported(xgmac->phy, xgmac-
> >max_speed);
>  			if (ret) {
> -				pr_err("phy_set_supported() failed: %d\n",
> ret);
> +				pr_err("%s phy_set_supported()
> failed: %d\n",
> +				       dev->name, ret);
> +
>  				goto err_shutdown_phy;
>  			}
>  		}
> @@ -500,25 +516,25 @@ static int xgmac_start(struct udevice *dev)
>  		xgmac->phy->node =3D xgmac->phy_of_node;
>  		ret =3D phy_config(xgmac->phy);
>  		if (ret < 0) {
> -			pr_err("phy_config() failed: %d\n", ret);
> +			pr_err("%s phy_config() failed: %d\n", dev->name,
> ret);
>  			goto err_shutdown_phy;
>  		}
>  	}
>=20
>  	ret =3D phy_startup(xgmac->phy);
>  	if (ret < 0) {
> -		pr_err("phy_startup() failed: %d\n", ret);
> +		pr_err("%s phy_startup() failed: %d\n", dev->name, ret);
>  		goto err_shutdown_phy;
>  	}
>=20
>  	if (!xgmac->phy->link) {
> -		pr_err("No link\n");
> +		pr_err("%s No link\n", dev->name);
>  		goto err_shutdown_phy;
>  	}
>=20
>  	ret =3D xgmac_adjust_link(dev);
>  	if (ret < 0) {
> -		pr_err("xgmac_adjust_link() failed: %d\n", ret);
> +		pr_err("%s xgmac_adjust_link() failed: %d\n", dev->name,
> ret);
>  		goto err_shutdown_phy;
>  	}
>=20
> @@ -611,7 +627,7 @@ static int xgmac_start(struct udevice *dev)
>=20
>  	ret =3D xgmac_write_hwaddr(dev);
>  	if (ret < 0) {
> -		pr_err("xgmac_write_hwaddr() failed: %d\n", ret);
> +		pr_err("%s xgmac_write_hwaddr() failed: %d\n", dev-
> >name, ret);
>  		goto err;
>  	}
>=20
> @@ -738,7 +754,7 @@ err_shutdown_phy:
>  err_stop_resets:
>  	xgmac->config->ops->xgmac_stop_resets(dev);
>  err:
> -	pr_err("FAILED: %d\n", ret);
> +	pr_err("%s FAILED: %d\n", dev->name, ret);
>  	return ret;
>  }
>=20
> @@ -1047,7 +1063,7 @@ static int xgmac_probe(struct udevice *dev)
>=20
>  	xgmac->regs =3D dev_read_addr(dev);
>  	if (xgmac->regs =3D=3D FDT_ADDR_T_NONE) {
> -		pr_err("dev_read_addr() failed\n");
> +		pr_err("%s dev_read_addr() failed\n", dev->name);
>  		return -ENODEV;
>  	}
>  	xgmac->mac_regs =3D (void *)(xgmac->regs +
> XGMAC_MAC_REGS_BASE); @@ -1058,19 +1074,23 @@ static int
> xgmac_probe(struct udevice *dev)
>=20
>  	ret =3D xgmac_probe_resources_core(dev);
>  	if (ret < 0) {
> -		pr_err("xgmac_probe_resources_core() failed: %d\n", ret);
> +		pr_err("%s xgmac_probe_resources_core() failed: %d\n",
> +		       dev->name, ret);
> +
>  		return ret;
>  	}
>=20
>  	ret =3D xgmac->config->ops->xgmac_probe_resources(dev);
>  	if (ret < 0) {
> -		pr_err("xgmac_probe_resources() failed: %d\n", ret);
> +		pr_err("%s xgmac_probe_resources() failed: %d\n",
> +		       dev->name, ret);
> +
>  		goto err_remove_resources_core;
>  	}
>=20
>  	ret =3D xgmac->config->ops->xgmac_start_clks(dev);
>  	if (ret < 0) {
> -		pr_err("xgmac_start_clks() failed: %d\n", ret);
> +		pr_err("%s xgmac_start_clks() failed: %d\n", dev->name,
> ret);
>  		return ret;
>  	}
>=20
> @@ -1080,7 +1100,7 @@ static int xgmac_probe(struct udevice *dev)
>  	if (!xgmac->mii) {
>  		xgmac->mii =3D mdio_alloc();
>  		if (!xgmac->mii) {
> -			pr_err("mdio_alloc() failed\n");
> +			pr_err("%s mdio_alloc() failed\n", dev->name);
>  			ret =3D -ENOMEM;
>  			goto err_stop_clks;
>  		}
> @@ -1091,7 +1111,9 @@ static int xgmac_probe(struct udevice *dev)
>=20
>  		ret =3D mdio_register(xgmac->mii);
>  		if (ret < 0) {
> -			pr_err("mdio_register() failed: %d\n", ret);
> +			pr_err("%s mdio_register() failed: %d\n",
> +			       dev->name, ret);
> +
>  			goto err_free_mdio;
>  		}
>  	}
> --
> 2.26.2

Reviewed-by: Tien Fong Chee <tien.fong.chee@intel.com>

Best regards,
Tien Fong

