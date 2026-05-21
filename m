Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 755F1CD4F3D
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 05:02:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D14DC84659;
	Thu, 21 May 2026 07:01:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=issi.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=issi.com header.i=@issi.com header.b="dfmLVBqo";
	dkim=pass (1024-bit key; unprotected) header.d=issi.com header.i=@issi.com header.b="lHy7XseZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF723846F1; Thu, 21 May 2026 04:29:56 +0200 (CEST)
Received: from mx0b-009ae801.pphosted.com (mx0b-009ae801.pphosted.com
 [208.56.12.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D91808460E
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 04:29:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=issi.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jeyu@issi.com
Received: from pps.filterd (m0495960.ppops.net [127.0.0.1])
 by mx0b-009ae801.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KNtGKX705320; Thu, 21 May 2026 10:29:36 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=issi.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=11242025; bh=WG8ICT0dXmTvzWcCqn6ThbR
 LdTxllVNkzbjcUlY/tqI=; b=dfmLVBqoEoic4R+NjxZlY4mzJ1RvFBjrf2tryTk
 syBkE+8isfuApV61xIpK4QrpFAMo9Ml/JCWjaI7bFN4s8mXJiEOYKsgcp2oDzkkg
 JTHEAfbj33Y1rkZ1zXNKDXYpYsgIuiRA+/Wn6bVCKO7OT84H32CqTKg3NAAIH2uF
 cm1FSLWoYcFObTTGShIpCH7g1dEDxUZFeP6pauu2tcLmNxu/Msxc0xaUS7oHHTWv
 Y3DhPi1bP5I7cmaOTVt7gmCimsS7BzXBc8RKjf0Ztpd4Eyx7IcY/wC/pHFYM7XXr
 gild+hR5gnvCBAt+iPyRTlUyKFoRkDo1rfNHUVDRBBNSY9Q==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11020088.outbound.protection.outlook.com [52.101.201.88])
 by mx0b-009ae801.pphosted.com (PPS) with ESMTPS id 4e9fcs8ama-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 21 May 2026 10:29:36 +0800 (WST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tSzjEakTJ2enFOKr+OnQ87N6Gmoghvj1Sb/AvKwYMimslcJpJw6AC/ZNhlGQsEr2sdvECRrHrgIvn27G4dT3GmDvFYJF8ETIaH9ZJhEO7oF/fM6GGqjTb3dpFxA3PqV4Udm9Iro2trBbcMwDWah8QqMxPvQzE45gj4hc0EpBCQL+Y2k0WnsYZPC2R1pj2x/n+8sy0LksDsGYBxd1SGDFNxMkwCv/N+UCGIKnwir9Um9KEMK864AzauSMv3h7IOWAbrmvmyr9LlZ+dY6NzCF+YtCFbk5abEWW00J++SPLSeiZMRp9v5fjjr9DrY5QHnWvsmsahL9Az5Rk+BLFFXd0Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WG8ICT0dXmTvzWcCqn6ThbRLdTxllVNkzbjcUlY/tqI=;
 b=cNWwW4Wql9Yd7cbVdYdhAdKkYkJzhPsI+YaggPyBZrJSikkyXJZCrfAYzyi/2yqXAZVQRemI+GYsDqUadu1jUDoEioF2dz23pPBvtn0dsET5wKj/3mb8U16y7+JNFir92ksio5ox3w57MVAgfioZCrUUvSo1BzCXuCIQY3EX7C+w8+vY/pkLTqFLw/4J2h4NgaeCA5QkNbFeBl5ndIglTJ/+eCRIS48uYil1nxF1N1cseQPO4iSL0AlKGofZHpgQmldYCayPYB5XpdowBdwN394/wxE4mQe0AMt9IX817ptDlPffN5k0BCMFnfb5hFlhyO77PIUAeNvZMZFYq+qjcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=issi.com; dmarc=pass action=none header.from=issi.com;
 dkim=pass header.d=issi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=issi.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WG8ICT0dXmTvzWcCqn6ThbRLdTxllVNkzbjcUlY/tqI=;
 b=lHy7XseZK56U2wuLq8btB58ODrONd4e2gwyis1TBo6mdPL0niqHGxIVDB4akErk2FFRlIZcCXrEe5kvLmEjwUMRNIAgN/6RxeLnEcTZW4BVpIfDolLTDupCCPNWBkIHkJqEbbzOP3R9o6yZoyo30R6TQ8CnQ/7Hj847kCFnhAwI=
Received: from LV8PR19MB8597.namprd19.prod.outlook.com (2603:10b6:408:25c::15)
 by DS4PR19MB9028.namprd19.prod.outlook.com (2603:10b6:8:2a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 02:29:33 +0000
Received: from LV8PR19MB8597.namprd19.prod.outlook.com
 ([fe80::d035:5ff:4546:5713]) by LV8PR19MB8597.namprd19.prod.outlook.com
 ([fe80::d035:5ff:4546:5713%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 02:29:33 +0000
From: Jeffrey Yu <jeyu@issi.com>
To: "vigneshr@ti.com" <vigneshr@ti.com>, "takahiro.kuwano@infineon.com"
 <takahiro.kuwano@infineon.com>, Tom Rini <trini@konsulko.com>,
 "flaviu.nistor@gmail.com" <flaviu.nistor@gmail.com>, "ssunkkan@gmail.com"
 <ssunkkan@gmail.com>, "yangshiji66@outlook.com" <yangshiji66@outlook.com>,
 "chen.huei.lok@altera.com" <chen.huei.lok@altera.com>,
 "christoph.reiter@evk.biz" <christoph.reiter@evk.biz>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
 "dlechner@baylibre.com" <dlechner@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: [PATCH] Add JEDEC ID table entries for additional ISSI SPI-NOR
 devices.
Thread-Topic: [PATCH] Add JEDEC ID table entries for additional ISSI SPI-NOR
 devices.
Thread-Index: AQHc6MWNUy9u+PgnZk6SdiZ8HKff/Q==
Date: Thu, 21 May 2026 02:29:33 +0000
Message-ID: <LV8PR19MB8597C7355B88EE667B9C07ACB60E2@LV8PR19MB8597.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR19MB8597:EE_|DS4PR19MB9028:EE_
x-ms-office365-filtering-correlation-id: b5af55c1-34da-47b7-0a05-08deb6e0cb4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|1800799024|18002099003|56012099003|38070700021|921020|13003099007;
x-microsoft-antispam-message-info: 7J/KOsa8UX0aHe7LnpCuoik8iEpgucyMTS1YIrxJscN3Jr0Y8czCofb1INBwGwp1/eXdUvLxuHxNOz7tvdZtxSmFNB+fY1GKtYjEDyFCzW1a1fCTyQproeKBCfchRY9VnAIW/c0nP+twh6z03tF5tq201H6V+XunlBss+CHzQTrRAIl5WMwEYWohgbkhSBMbd0RNGenSJU3v0gxyjvF9WGC3vaFm2pM/v4GhcIy3bNEc35Yyc9Je47Jdoq7N5Pi4baRjP5XkMBSaMH6GaKKnG0HTAuclQS44vNmLbvjVqSNKOnyGIinDUllHJ4Hl+4l0NM56Z1Dea6p17zBNA16R6sHPZJ5f0yarXHPfXnrx8s2VV+q2e2/QpwN98+qvoMYe90b85DkTuCFzwVp41KrrqrORodcR6R6p4L7DFcF+rtvvEQkJi4Mri7Jkde8v8RBiENmqTe8IjsWcckVEdVyUHHUisR2mHwGPP2NZbZ579Jh74MveZUw3ep9/zFG7GjtfhlYsDTxGDriKDGF5wnk4lC+uYT6eGG1mWG1+vfxQPyeElFkCEEKRYZ2zjb5npdDKGpW6INIwWkFAZ2UddHeyNgqxUryE+y2UvlCAR4FHSX4N/ilw55QWkz3eBhdF8/hZ2onpbV8C5dddoeJ/eKDkwk0sCe1bp90JjFvZRUKoaq0jBMx8feM2yrRtYEqaqXINmuCAfAku3Pjye3DZ4bH2IWvAmpo/ltGdCPRJDYwQh/c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR19MB8597.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024)(18002099003)(56012099003)(38070700021)(921020)(13003099007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vXxzTm4Nq8uQh6KHb4oOvLgXl/aZejS6GJq02XZfFVsSxaqMkgbIhYgGf/?=
 =?iso-8859-1?Q?xszmAlSYVyD2l0ao7GuwgeSHWXnR5x9Ih5jJnN0iW3M41YCAK3lTu4Sn/h?=
 =?iso-8859-1?Q?fOR+YkzI6X7eWWtFGLEs0lqAFEiFhvYIxVRy+LHl2ZT4WQn5bVALT+24x0?=
 =?iso-8859-1?Q?KwRtxe/vcnJvvb8g/bKyFuiMuct0mPA+rA3uIqNxzQ+d1GhNckIRZaARwr?=
 =?iso-8859-1?Q?IaGQZDc+1/u6IJXmUiD9irUlUimFed7eNNdwRYeKazGolGXkCDeqKm9RK4?=
 =?iso-8859-1?Q?qdzW2eR3zRIG4HcK+O0ltoAB0NXFfJq7HknohQM31eafvPccZaMVkOlwgn?=
 =?iso-8859-1?Q?2vBIztDPDl26zIPpYUNONmwR7QibLFGyyqTb9DUQJQEs6qFFoTRmo8p4HF?=
 =?iso-8859-1?Q?ZS2rxE43IIEGgia5yx/IAHZ6EjylVvK/+V30XaIbyr2O3ZYSF8aCDCwxU7?=
 =?iso-8859-1?Q?hgdkor0p6RyJTIns9P5cf/kBYyyPCks9M6JAzw8wD2dGjmQ0XTAL5DDl2H?=
 =?iso-8859-1?Q?3WkAJqzYKdBRA1LtEA0n4jdX3R/dUNOHfH67q4jSVNj+7tqy1DeIUmfsUa?=
 =?iso-8859-1?Q?hS59kHbPnZWilQ8nv/yEAR4HAu8ZIwnuOYGfxQ9C57aWLUnkmxKAXeP+Bf?=
 =?iso-8859-1?Q?W/J+P3DwZ1628+XGCZqodEbPiN8Na7ck95qKvU5spesm0nsALIzKJhktJ7?=
 =?iso-8859-1?Q?Mc1xNxP+bkRJr1I7FOG5OQJfSuh2lbGO7f4XyFKtSDw4LBnJ9I1Ay9LC+v?=
 =?iso-8859-1?Q?0d6QhSRvAvBwwJ2lTim6AhrQgbYhGLoeVkw1l1ykrkRFcoAWbLymDnuCnr?=
 =?iso-8859-1?Q?4k/UmRg4wq9aSXcPBztT89wmcydFpEfWocXfI8zWvslTf4/0xfatZWmUbP?=
 =?iso-8859-1?Q?obW5DBLXo10p1+yPi20GdLNZhtAsBjYL0F2WjUw3m2CoIrAPcJ9jSOCMCs?=
 =?iso-8859-1?Q?/btl6BYZ0l2HMvhGDmd81IMMqOeGLacghPP+6L13+DanQ0BxeGqhxzaz3B?=
 =?iso-8859-1?Q?2euIYyQR7mBMyjfJWZm5Bz3vny77GZNHHdvreTg2LYqW+0k6rvXxQ+O7dx?=
 =?iso-8859-1?Q?50IYXL5MJ8NaNUTr32ciDl6oBqtg1kwcSFV4v+gn/nppMvCuPEBgFVv2Bg?=
 =?iso-8859-1?Q?yGHG27ia7WT4DWr4o5W6aZZ2xXYjw8ueWRb/2LMVKBjKa8CJ1UXm2Q2Tfy?=
 =?iso-8859-1?Q?PHl+IcYQN9SfNHfwkzRszBaeDBIB/PR0DNL6NqetX/vDI0B52s1aqw01Mf?=
 =?iso-8859-1?Q?gG3J2CFz1fXC3lVhQF6QLwyLuJPPJaRQ9DbaCFoDbY2tdZNKOBU0YetQl/?=
 =?iso-8859-1?Q?reu2ExDGK2+VjoIUR0RTwKI+TAGAH/ODK8IYKlc3iV2h6pU3w7G+2zMF0+?=
 =?iso-8859-1?Q?yqYF/cWI+FtYq1Tku3p4fL4cD8mJvEklbjD3+OJjNEv0bu/eh/hUEBfHQ0?=
 =?iso-8859-1?Q?Xj7iyHCLIRSQMU8ruo2ibv5e6RWMHkAoaefJiR0TL+FvxqIo76t60ygcXP?=
 =?iso-8859-1?Q?s2d8NA9V6DTmF5VuapI+TR4BMboSx45Qa1H4/No5QyfYYbouGOi3EFxk5o?=
 =?iso-8859-1?Q?el+vTFSyR+9vCOYQyhZ1SPzV1VtylKGeCxLfAGTBaySzp8NjIKV0VRsHL+?=
 =?iso-8859-1?Q?QxuX/GebODoBj5/g9jE2RFVA4IuKn/Cr9+OKX9wjdKa8jVacoJTW+iMKis?=
 =?iso-8859-1?Q?LQdaLn0NDeynj2nU6IGoZiPvqMaan8J2BOKL7682/B6DFvvf2nZoh2eNQs?=
 =?iso-8859-1?Q?nE41fsgbACkFKz5IkCkmEfKqg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: n4H4Og/Q1cJVxTYH3KRXdtchhcM0L8II7rD9jDC43GNqeNcwhmMAhCul7uWsmMXiTZ7F/C5/xwvdDd7oIlPepTPYX1aAFCSdtfveEtEGHkvWU7fxLHukG5xoU2zNHUjPI8Dh3sq5S5w5C81RlgzxDH7gHa0CGhToKj3NTQffdKveNpL27xEajS0p+Tob17wHjpHSsvI9RuLFFOw5FeKqK81/1WT1oJBJ/ZWYmzi3bscTif5uRykmQen0t5y8s6OjMRjongODIVxvlJoerg8ugc1CfGy3JDflG8ax6t9+Sq07YphadirBnkK4i+o34SzcV4fCbDVYELgoNiiK7atuaw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BUyo6xCeTtLJc8AfBMqsJ+sVLgPBKFNRtOx1D9eT45wbAaaGIyfR4cTPHg1yyOprmqZvryHIxIJkEp+Gf8uRggleL+qN+LOlX6cDQKTPDCxz+0F4vKN8jzBrQrjy+sEiyLpKE6AY22bzHl3IgeY1p+yE6o2XfiYLc+aDR4z5B/c1U/SSnS//+r/GjZGFfRK/drNgcUVtg9HiT0E51/IVnTZZq4HMEyGnPNfXg8VrC5U/ho3tgeMirA0ZyXdioGK0F3qdeMsLPx0UTNgV2NBTPTkOl/Q15eAGsKayImQpAjU6glOpjwF1U99ahlqj8BMNwwfIqaiWzYEc8j8Erb/mAZjsMV9V4g+Kb/IC05eGFME/edCEoV+nrpXHZNd8gIGvgaYIUj8lpjUrveCSSn2UhFLMA6WtvQAKK4YCpBI7ykivc4N7mlvp5cG7XcFY7FAw67PQAK0JOskXaFhkiQ3uBdfVwtMWAnJp0sPlBC0kXmQHFkEIEqQSJeLphU7SCRH1Yi9mCN9T4vXY2tCqyyrVY6UfnbIOYzErnl/O7pKmg/Ydhvy+EEEKtvUg+ajIHksT2ySWEHyfdyBcxTqUGYQ5A1okuC1sMN7o10NruokD3gP4seClJXUVSOJL+YYloDCC
X-OriginatorOrg: issi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR19MB8597.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5af55c1-34da-47b7-0a05-08deb6e0cb4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 02:29:33.3023 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6af618fc-4f7d-45f1-a2f2-8c59a26d2c10
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ymq9p4mafL/USX3heBpbk7Y6Xz8XDGZWbMIYqi4HPvUc/yaibJ8hzDGr1PcqRBhl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR19MB9028
X-Proofpoint-GUID: WEwaBEooL5cdd4iIRUE1ta6PsoceFyCi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDAyMCBTYWx0ZWRfX72zlFmEVIsKI
 T8x6Yh7shkQBox58aaVysrm4wRou2W9g5aI6ywH7uYHQfZwaPFQ67ja6ov6awgDcknVbINQCGac
 g2Mew2Rpz+n0Rh+xawfuEGaOkFODhKd06uA20leU3MiaISeCAOo0ergxXlJByx26/zkaheoH5KY
 hsxPSps62RSRUr/yCAzWqtQmyLjkAIwhuQv7iURoMlDouWvTDvpayPZGmtZs7E3mofGDjjMA2HG
 3Rw1/6b8OMqEsXtLEkUBmiMFYNcO6vqQXwyciXjjue/RPCqN4UpsNd4ktqpNd8t4jhS5r53/kZh
 8oR+6ifHiTB4Rtk+e98d/16G6r9s0+8Ga3zOGXjrQrL7hUXIRZ5SzuV/NnLEJCCN3piIoHdWG94
 4v7RhiyYiFoEkk8NAA80+DHfUdcCOwx4gYW2NdyNb/zsTzucn6A8MVrLRkXlCaLOKF1BPl6QdHR
 0kFCQ4Sjb+ramgtFpIQ==
X-Authority-Analysis: v=2.4 cv=WPNPmHsR c=1 sm=1 tr=0 ts=6a0e6e10 cx=c_pps
 a=g1r3gZ1HyswFwe8rp8Qgpg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=NGcC8JguVDcA:10 a=ozMtBe7fU4EA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yOHNzV93IasTtWdH6Nhn:22 a=US3Q6AVWkkt9IXfmMOXc:22 a=DUnRZS7UAAAA:8
 a=LnoCUbAube3HSx948R8A:9 a=wPNLvfGTeEIA:10 a=cDzw7mrAGmWHSR5u0tpu:22
X-Proofpoint-ORIG-GUID: WEwaBEooL5cdd4iIRUE1ta6PsoceFyCi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1011 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210020
X-Mailman-Approved-At: Thu, 21 May 2026 07:01:44 +0200
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

Add JEDEC ID table entries for additional ISSI SPI-NOR =0A=
 devices.=0A=
=0A=
These parts previously not yet supported.=0A=
With these entries, Linux software can match the device by JEDEC ID=0A=
and use the existing ISSI SPI-NOR device handling.=0A=
=0A=
Newly added devices include:=0A=
  - IS25WX256  (JEDEC 0x9d5b19)=0A=
    https://www.issi.com/WW/pdf/25LX-WX256-128.pdf=0A=
  - IS25LX256  (JEDEC 0x9d5a19)=0A=
    https://www.issi.com/WW/pdf/25LX-WX256-128.pdf=0A=
  - IS25WX512M   (JEDEC 0x9d5b1a)=0A=
    https://www.issi.com/WW/pdf/25LX-WX512M.pdf=0A=
  - IS25LX512M   (JEDEC 0x9d5a1a)=0A=
    https://www.issi.com/WW/pdf/25LX-WX512M.pdf=0A=
  - IS25WX01G   (JEDEC 0x9d5b1b)=0A=
    https://www.issi.com/WW/pdf/25LX-WX01G.pdf=0A=
  - IS25LX01G   (JEDEC 0x9d5a1b)=0A=
    https://www.issi.com/WW/pdf/25LX-WX01G.pdf=0A=
=0A=
Signed-off-by: Jeffrey Y <jeyu@issi.com>=0A=
---=0A=
 drivers/mtd/spi/spi-nor-ids.c | 12 ++++++++++++=0A=
 1 file changed, 12 insertions(+)=0A=
=0A=
diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c=
=0A=
index c0fa98424aa..039821b8175 100644=0A=
--- a/drivers/mtd/spi/spi-nor-ids.c=0A=
+++ b/drivers/mtd/spi/spi-nor-ids.c=0A=
@@ -301,6 +301,18 @@ const struct flash_info spi_nor_ids[] =3D {=0A=
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_TB) },=0A=
 	{ INFO("is25wp02gj",  0x9d7022, 0, 64 * 1024, 4096,=0A=
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_TB) },=0A=
+	{ INFO("is25wx256",  0x9d5b19, 0, 128 * 1024, 256,=0A=
+			SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES) },=0A=
+	{ INFO("is25lx256",  0x9d5a19, 0, 128 * 1024, 256,=0A=
+			SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES) },=0A=
+	{ INFO("is25wx512m",  0x9d5b1a, 0, 64 * 1024, 1024,=0A=
+			SECT_4K | USE_FSR | SPI_NOR_4B_OPCODES | SPI_NOR_HAS_TB) },=0A=
+	{ INFO("is25lx512m",  0x9d5a1a, 0, 64 * 1024, 1024,=0A=
+			SECT_4K | USE_FSR | SPI_NOR_4B_OPCODES | SPI_NOR_HAS_TB) },=0A=
+	{ INFO("is25wx01g",  0x9d5b1b, 0, 64 * 1024, 2048,=0A=
+			SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES) },=0A=
+	{ INFO("is25lx01g",  0x9d5a1b, 0, 64 * 1024, 2048,=0A=
+			SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES) },=0A=
 #endif=0A=
 #ifdef CONFIG_SPI_FLASH_MACRONIX	/* MACRONIX */=0A=
 	/* Macronix */=0A=
-- =0A=
2.43.0=0A=
=0A=
