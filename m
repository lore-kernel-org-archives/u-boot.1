Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6957C021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 06:38:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7DE4801DE;
	Wed, 19 Feb 2025 07:38:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="VN+r83MK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E868809A4; Wed, 19 Feb 2025 07:38:29 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3CAE800D7
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 07:38:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739947106; x=1771483106;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ejyK9qLfnPfOZ1KIIUkPGo0JUt0dsDiYWuJQluv8do4=;
 b=VN+r83MKyTUfaBoIsEDBIPvNCKqfPEHG90n19QHu69QeKhayZml+JXb8
 laCZIqKUDz5LyYKZrv4D3injDo8LNnNc5+1AXHW8dYjqgctlhTr32Qkmy
 lmRCvkthzXszhZ9iVZKXZ7cjy0nNF9J/0mRmhcKUFzWOv6580XIgd9GWC
 ihK0IithHrIgkX7phq9Ft+Tm0um9xAXidcuuvlf+KTnk4ZtZCZ2eu5BYI
 2k2Ltn11OpyRhZnpVGMygVWvr+K0LwyUI+0PpaopmbWTbUQGaqHmUiThF
 dJ+0uszFZklEwHcqSRI6sqbxJa1Dti30YpUBIU55soo6RxQz2Sq3EVk8F w==;
X-CSE-ConnectionGUID: vnd1+HNoSWOBCuDJ8fl8mw==
X-CSE-MsgGUID: /61vVeFMQ66bxAB/TYUd0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="52075401"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; d="scan'208";a="52075401"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 22:38:02 -0800
X-CSE-ConnectionGUID: 5jbpq2T0R9+JZAxzweQ7TA==
X-CSE-MsgGUID: p1va+qj5SxGPYMq5Jvr3pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; d="scan'208";a="145475461"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Feb 2025 22:38:02 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 18 Feb 2025 22:38:01 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 18 Feb 2025 22:38:01 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 22:37:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mFE2DjfxmgaZj5ni4rISQe3NqVFFnlO7PVNtji6XTzVdBBXjoAvmntw0mvkd+8fkfZT+OaU/y3HffKNO8Z60Aa7fWkU1ML24gYyvOPAvEkQjQFdQLISmRb8ngi+IG5WSGY0+ISoIlBoBdCAk2TCWlxhknQUz5ecmaBGhmqE/lAMj9Jz8ODzgwXYMaKes7h9yXrJth7lY5LZKk2ZKqKOqofGy1wBiS+8TTZTr/8ooftQ30Hews7zY+AI4yAfPG+AltjZ2etvOV7+lM4iODcfNU5vtdE8n5NPzv9X2c3H8BDYxR28mZMXSehyQ2BGVjOKPQ9i2VG+AJX4o1XBaeJjP7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2xVlVWQbrxKkxXOr43l63KiOeu9nT5qaen1yh788Q4=;
 b=f/wU/M9pJQPmOf2hRh9kybORpB6N6155qzT5qmiMU3fz02qv0uF6dJTV8i5BMyh3nd+UCWGMp4WFkWTMJNJCR1V7Jwlj0P91g64OvJhQOK79QDwQcjAyqnnE/4LoBAvkrZ69Stng9fV4FhxQalQ1HhgZr/th9ybtOfNE2sm0+8x+CYdzSPo+ROdu9sgUcAtfXef9YYtooGt3AVkcTFsSmBAlojQs0pSVmSjrAHOkDhrzQRnN0ClsZCny6QvQB/pZ/U1isOnZxpf7aRzD0D8nxtbT3ZS0QmUD9L3l++609LUOpvzp8ZR5MulhZr55pl//cqxMOH2hPet2/LlUem24gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 MN2PR11MB4710.namprd11.prod.outlook.com (2603:10b6:208:262::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 06:37:15 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe%4]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 06:37:15 +0000
From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
To: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tien Fong Chee
 <tien.fong.chee@altera.com>, Alif Zakuan Yuslaimi
 <alif.zakuan.yuslaimi@altera.com>, Tingting Meng <tingting.meng@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Kok Kiang Hea
 <kok.kiang.hea@altera.com>
Subject: RE: [PATCH v2 01/26] arm: socfpga: agilex5: Add new driver model for
 system manager in Agilex5
Thread-Topic: [PATCH v2 01/26] arm: socfpga: agilex5: Add new driver model for
 system manager in Agilex5
Thread-Index: AQHbgeAVDfaE5XvUGUK36g1dccXLMbNOLMig
Date: Wed, 19 Feb 2025 06:37:15 +0000
Message-ID: <DM8PR11MB559296B2DEB7CB7AA6253B7BD2C52@DM8PR11MB5592.namprd11.prod.outlook.com>
References: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
 <20250218083511.29249-2-alif.zakuan.yuslaimi@intel.com>
In-Reply-To: <20250218083511.29249-2-alif.zakuan.yuslaimi@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|MN2PR11MB4710:EE_
x-ms-office365-filtering-correlation-id: 7544fdaf-8077-449b-f3a3-08dd50afd989
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?nn21Q4ZPPBWkGsUfexU81A00gPuOahpug4ybBGdEhOQd8qo8C5hq7WJelA8p?=
 =?us-ascii?Q?e8bo4zY6/3GCUrHeaeYcWYH2lebINyfInrIvSnVVecePOJ4K0xKzektSU/xL?=
 =?us-ascii?Q?9F15/H1XVFQVFLmS/ezZVqAA4R7vQ2srmNBocovj7psoJb0yZohOVxCpfOEs?=
 =?us-ascii?Q?S4zwPmIebKNnrZMSBwJvTD5Qm2I6MBY41HjwKY/8kYEBXiOv5cTJwzGbEkAC?=
 =?us-ascii?Q?oZ2dECIBqyOH2hWl/MoC7mvgGZWBiQDhuGu/c2qcrIKp/w9qlvUuVSjxxVLz?=
 =?us-ascii?Q?Kw/S5uLybZLJ0HznIeRvulFjzIJTaHsX/8CrNd8xsH7/xkLu5HuOWUrjAZ6K?=
 =?us-ascii?Q?SPalZle5ygdN+pFmF/VK5RHa3+IOP2hMNL7LOk0vPSI2s26sPzcWc+21Rwjm?=
 =?us-ascii?Q?nWazNEpxq3fsrsf4IYp5g9uRaKApE5TopUiRi3vE46C/j9HiFeHh06hJeEOa?=
 =?us-ascii?Q?3C9daI/BIJFP3VcltwNJZQnVLB71eUUVExCxAgljkfs2LjNrJhw0dU4BOWBm?=
 =?us-ascii?Q?cV8ElWjkFyGUCT7c/suRjzk3HdY33wXx9WG3MNtDzGpcnH3M4Qzex9cp6qlH?=
 =?us-ascii?Q?PDlpaUTFZkeqJGbtPEiEW7tLElDzYIiyPCV9KsYsZqgE6Wq7cBOjmzKCRTbE?=
 =?us-ascii?Q?usaHhpo9b4d6GCiAQH0LstTAAJZ05AvYKcNh3gJdg64qFke55n0LMl+kQrkc?=
 =?us-ascii?Q?u6krCUHDzIzUSx4olU+WHkdqe8E2Cx7BztjOdJHWDjVNGxyQG8e9FA5qZkLY?=
 =?us-ascii?Q?t3x0QEpdoxo/fWiWfWAqzrzLGrUhnMooxI/BB1Mi0dh1HiY4QW+i7co6Mc+R?=
 =?us-ascii?Q?JqS4gAV4aSHxAaYhMJNDIhMUCH4wFkIJohZtIZfEM4r0jaeDqY53ilSjJqDi?=
 =?us-ascii?Q?nY09ejrjqPL1Ry/5bhztIGAyz76rMII2iHyjyePH8ugekA2bPH4puBVSHpGP?=
 =?us-ascii?Q?NT6eWT+p3SLGN0jcFI7PZCn6lPrVknwxLhuGqXuuxxUHhm7bktBYSxCyaVCp?=
 =?us-ascii?Q?corNOpYaznDzqjlrBjPrwVWbtNF0f/eblqpn/D3zZ38I1oNYXeMS8qikq31P?=
 =?us-ascii?Q?ACG1upHiqMr1InPwAK7QZYh1JsmSe1uFrcSILEsaZXJYF9IR0WmFzfcKKGA8?=
 =?us-ascii?Q?NN8bxYRwsRh50mdrZWFYz4T+I8Ui0FOLVRYxAMApmIv5SHoyG1sAz2A/P+WN?=
 =?us-ascii?Q?lZEJpGBNoNfpBWBXoFVIOWsW//P8GrXHsCRke7cw7k+aNKrMpnJXXh0CaTHU?=
 =?us-ascii?Q?LyzV7WyvpcDU0A0lfdH5Buo3g69Wgt0qHcbL3yVcOCrAO7xsp8fx+/ruR4rn?=
 =?us-ascii?Q?JkjOIPFSx8aOVcojBwl3aLfTTsEgM5E9ePqj27VxyzzvxXDpCjaEtDVx6jBR?=
 =?us-ascii?Q?TJVQltEucW5V9pB2ezMxzjyl3mobY90YB9iyoAZp6jGlmBW0tZCVMNL7wQb9?=
 =?us-ascii?Q?n1lJEAstQHA+6UEELGPHuU0Wl13jR6dK?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5592.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Xl6aJ/KnhFYwGDcPQvyMAcYSe1xhE1O16TFYr/P2VHFmZSoTsMXLYk+e88AO?=
 =?us-ascii?Q?YGpCG19KBlm96s7oYlIBKdVXWkW7SFSfvpFIdRcweYJxj69HjhiVTcICQeFd?=
 =?us-ascii?Q?qXAG5hoxpDiVeQiZ8lfztfWjllAL31kI3H1xQ8Uf7t2Wgthp11uxvKTtXuWZ?=
 =?us-ascii?Q?qecy3i/T1qPlWvNtg2stofhZCgqrXO2BI3KjL+S2/Rsd84tX7YxzU8Ln5rkd?=
 =?us-ascii?Q?VECALl2ep+0mG98Q2q2sG+WJLsgVPwN8/syHxStWMx0E803Luym/QGxirgwb?=
 =?us-ascii?Q?gOkSoAmVMyRuIW1RBSz8CpOurCYpN6rQQvom+CDa2yVFERon/QOPEZpauxt5?=
 =?us-ascii?Q?UXN8oPx4APoose8hfSUj9euWaZUwARq63rmdqg3PqhwjL98dcQJ/Jc13rhFi?=
 =?us-ascii?Q?hoQdVEVlxfeIxjMIuXNGxDpo5gq3u9KLzABqA9BBXw7h5y0Fx8so3E2Pz651?=
 =?us-ascii?Q?yjGRUjfm7pqT2ek8+Srd5dhkA5KrX4KMSl/D37UdAjenm4VbeiTsy2OwNxth?=
 =?us-ascii?Q?/ZB3nvkdV5jvhu4CBoSPLaj/FyrsrrTIJ1ULaHvzAGCCmJ7hxiAA51YTONyR?=
 =?us-ascii?Q?n7YjDovNJXMp1R1dz28fFzrHZ1xV8I6nCiNLCi1acngaSQ5KzMKgX3oAWUIK?=
 =?us-ascii?Q?YIeLviAu+g0wY9ks7DlxncHyaA52FCJeDSjHInVpBef+2AZPsDmxzIRxpomt?=
 =?us-ascii?Q?FKxEp59+4nvTfedqDtT3Q4+LZKVsPU2ZBIkwCjCZB/ff54Pk1qkCnRR6TQWR?=
 =?us-ascii?Q?fWKwVscmCgKHmKZyyCkoukux4eKle2uXPGeOYS3Clg6edG6sPIZ0Qnu7WfFa?=
 =?us-ascii?Q?Ur2OaVWyRa1DgvNf8y0j5bsohMoCOw99Sx/zOT9GXHex0f0uGfbEdhGUHKeB?=
 =?us-ascii?Q?kWbyIet4ZoX2UkvNPMHqHBmgQk1YMmJMMuSRzc57vdXU/apVMRu8jsmhiMen?=
 =?us-ascii?Q?8CrcqocKI5TfnPtbdqHxQr0JnN4FCC81Qfyn3fJVJuHj9qXqkR8DZTRCavj/?=
 =?us-ascii?Q?rFM+z75qJ056OIyoj43904Mg/UH5QUj2HfsnN3KotIRCSdGu5XknDJjyofnQ?=
 =?us-ascii?Q?ltwbfE8tLJjFII1lLD4nEIm30QDjC9l53oOGb33kNjO083S4SwWbgXwR2nOE?=
 =?us-ascii?Q?ftvTfSud7RlQDJaDwq2MJX0pMp8UkkLBHbv/BHWbKgQePSfO0E0ljGPGjC5M?=
 =?us-ascii?Q?bYQensKyZyeDYKRnbYjekhp3teH8C3a1bJLs7/g9Uccil3Ff1hd4bOkfnRPx?=
 =?us-ascii?Q?FfYLKjb4/qEE2YNZl5mMQ7yI/fPhcNP0irLuYYCgRHfJMLGReixvNjQqimUV?=
 =?us-ascii?Q?I2cFIZPOWzouWuDbrCUPyRx4vChVxV3jH3lt1i4/RPtxbliA0pzgnntdcRLC?=
 =?us-ascii?Q?sk2H51OJGtorSPp7PP/RURv5xj6yBPiZrsCYM5xjMrDu1BwKwehDimPUI5Q2?=
 =?us-ascii?Q?P7qV0i/9VZiprUElupqvdZ2mqdtdCfu2QXv9/G3efjaMEIH/hJFaNHfPzi17?=
 =?us-ascii?Q?9Hh4BOapD1ZZ8p4BMu5YTvGGLwEkNtT88htXvInmkcmpQc7+nEigUyk7+kDg?=
 =?us-ascii?Q?6Q+El4aZIC/uHJUOWjeV4XTEqiTdu6CHmT+rEI5p?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7544fdaf-8077-449b-f3a3-08dd50afd989
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 06:37:15.5295 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pk8uaRlmxhO9NlLlcxg7Ka6lfxmJiWZWtdYvCFTAxrSQpln8gLJJtdea6vSydZtXYaWt8/TZABaYPAyBmXtXfk0TJENwDbTa+qq70eY1etI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4710
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



-----Original Message-----
From: Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@intel.com>=20
Sent: Tuesday, February 18, 2025 4:35 PM
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt <simon.k.r.goldschmidt@g=
mail.com>; Tien Fong Chee <tien.fong.chee@altera.com>; Alif Zakuan Yuslaimi=
 <alif.zakuan.yuslaimi@altera.com>; Tingting Meng <tingting.meng@altera.com=
>; Boon Khai Ng <boon.khai.ng@altera.com>; Kok Kiang Hea <kok.kiang.hea@alt=
era.com>; Chee, Tien Fong <tien.fong.chee@intel.com>
Subject: [PATCH v2 01/26] arm: socfpga: agilex5: Add new driver model for s=
ystem manager in Agilex5

From: Tien Fong Chee <tien.fong.chee@intel.com>

Initial creation of new system manager driver.

Add supports for the SOCFPGA System Manager Register block which aggregates=
 different peripheral function into one area.
On 64 bit ARM parts, the system manager only can be accessed during
EL3 mode, this driver model provide user the high level access to system re=
gister and abstract user from low level access.

The base address of system manager can be retrieved using DT framework thro=
ugh the System Manager driver.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>

---

v1->v2
- Implement system manager driver to move towards DT probing
---
 arch/arm/mach-socfpga/Makefile                |   3 +-
 arch/arm/mach-socfpga/altera-sysmgr.c         | 113 ++++++++++++++++
 .../mach-socfpga/include/mach/altera-sysmgr.h |  16 +++
 arch/arm/mach-socfpga/include/mach/misc.h     |   2 +
 .../include/mach/system_manager_soc64.h       | 128 ++++++++++++------
 arch/arm/mach-socfpga/misc.c                  |  18 ++-
 board/intel/agilex5-socdk/Makefile            |   7 +
 board/intel/agilex5-socdk/socfpga.c           |  12 ++
 configs/socfpga_agilex5_defconfig             |   1 +
 9 files changed, 250 insertions(+), 50 deletions(-)  create mode 100644 ar=
ch/arm/mach-socfpga/altera-sysmgr.c
 create mode 100644 arch/arm/mach-socfpga/include/mach/altera-sysmgr.h
 create mode 100644 board/intel/agilex5-socdk/Makefile
 create mode 100644 board/intel/agilex5-socdk/socfpga.c

[...]

Reviewed-by: Tien Fong Chee <tien.fong.chee@intel.com>

Best regards,
Tien Fong
