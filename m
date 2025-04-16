Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1071EC369B1
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 05:30:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B7AD82CA0;
	Wed, 16 Apr 2025 07:30:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="vzdgwPEW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12F5F82BCE; Wed, 16 Apr 2025 05:13:17 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B4C681E14
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 05:13:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vg0tRidwlDTOEUOvxaJ8KXDZpzGIesSmscRqvS2XeNB3vr/4lmSzzIDkXPELfyE84xgAoSURg0TL7wofmnDvtglLrts7PFhpM1xn8Zx7fSk2zeE1VO6bi3shjJLjZTKwDINPx3smm3KCq4GjPGctcWxvS2AjUfJ/eZjvgAZb1odokc3D1Zilcg+S3FMWbnkhwSDpG7cf8+1G8UP8f+MNj/mHhG4gdpaKc65BYvShUc0s64PqmtGiGYlfmSoOJ7p02Ic4ZHLZWU5oB+qIytzcowVHnoO0dS8zaYP5hZnDLKY+wa3ABb4+6MguJVAOU1fCuqEE5expGDRCiLFmnh0Rtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCiqF2mTJ/am/1as/V+LNBtgBNL9ft9OoNEnCDSNHbI=;
 b=q88yz4vVvqA9nHpzMeTJQf4wFD2F0TXemrzgg3I88eyeJadQRvzKw5uHAoGbkZMxbkwhu2R/tpCtqPzaPYrVlgnsY/sFmBcGcN1GgzygEwo8R3ya+Vmo05l88m7i3DiJkmvVcd5QuZ0Jlg8sVTCeNFXOCvgMVXon46NJyxchl2kJINgDGgM+8p2pnSaQfHi++B5eLNJoT8Brm36DJ+Lfj9P5goHL8iWaG6DIKPQtrx+aAEHgrwhfso9rKQQ3G0XUVZSENNSQrCSGax7eYsZCCZ64CV1pm2mkGI82ZXJH28kzF2dRqYnO5tlnzblKkGBAvb+niHG6AUWu43U45A3orw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCiqF2mTJ/am/1as/V+LNBtgBNL9ft9OoNEnCDSNHbI=;
 b=vzdgwPEWnGFIzL5Tag94hthMWRNrxcDRnIoYJUAMnCaCoc03XYrve2aeus6mO8QSHBB8T5n9lADoCb+GKOWl6cP8i3IUD9PmjYR5pHz0sQV8JBdpcAhNl1ybtsFsVhhY1owExc9OvqzKw+HDdOKvjjLIItuT4fXg3VJFyyuqUfWj91dG8U4Ia99oPamiM/aVcAuP36qkaJgm62t61h3q3qQiZLrCj+opZEuUDG0mUzx+aPMHtbucm0NhpJPP2nTcHvpOC9+dS9bm0W9bEGnu2ace/Z6rzT5gisEaKVQkQwJiIaV/lqcJQN1j8rEIfP0RNQQva6az/7ma87AHl6Lpag==
Received: from BN8PR03MB5073.namprd03.prod.outlook.com (2603:10b6:408:dc::21)
 by SJ0PR03MB5517.namprd03.prod.outlook.com (2603:10b6:a03:279::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Wed, 16 Apr
 2025 03:13:08 +0000
Received: from BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a]) by BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a%3]) with mapi id 15.20.8632.035; Wed, 16 Apr 2025
 03:13:08 +0000
From: "Ng, Boon Khai" <boon.khai.ng@altera.com>
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, Michal Simek
 <michal.simek@amd.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>, Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, William Zhang
 <william.zhang@broadcom.com>, U-boot Openlist <u-boot@lists.denx.de>
CC: "Hea, Kok Kiang" <kok.kiang.hea@altera.com>, "Maniyam, Dinesh"
 <dinesh.maniyam@altera.com>, "Zamri, Muhammad Hazim Izzat"
 <muhammad.hazim.izzat.zamri@altera.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>
Subject: RE: [CAD QSPI v1] spi: cadence-qspi: Add disable STIG mode quikrs.
Thread-Topic: [CAD QSPI v1] spi: cadence-qspi: Add disable STIG mode quikrs.
Thread-Index: AQHbky6RCL8eOFJt2UGFHujp6NeNdLOkpasAgAEuqQA=
Date: Wed, 16 Apr 2025 03:13:07 +0000
Message-ID: <BN8PR03MB50731AE265DFF33DA1FA66B1B4BD2@BN8PR03MB5073.namprd03.prod.outlook.com>
References: <20250312090944.35977-1-boon.khai.ng@altera.com>
 <LV8PR03MB8137E440D16452E4D494966BA7B22@LV8PR03MB8137.namprd03.prod.outlook.com>
In-Reply-To: <LV8PR03MB8137E440D16452E4D494966BA7B22@LV8PR03MB8137.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR03MB5073:EE_|SJ0PR03MB5517:EE_
x-ms-office365-filtering-correlation-id: 759a4701-b64a-4344-0f59-08dd7c949c9a
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?5OroDLJOqa6t4rhTvMQkX/0w6d3FWSSqbCAc/7ZYQrYEmbMDOZIFLWY2PH?=
 =?iso-8859-1?Q?C3gMgtrfSolXZXIeEJl8TDwdHJlwwwtdgWmCdDJk+G+1Lt+HHlQ3xpEl/q?=
 =?iso-8859-1?Q?mqATVmJ19vedZ4TIvHWsfo+1rgXwIYVib+P1K5buTyn3sf7WzZ6MWj77O/?=
 =?iso-8859-1?Q?gRzX3hNe141O8/Nw/2ZRLoL5429zwhoqWtbga+E/uHvYMchTMu1c8K0QYF?=
 =?iso-8859-1?Q?Y/MVCRlQAR3Dg/ooLkU0BJyZWKOPIBg3+6zkel7YYYsq93lrM4IH2fitdM?=
 =?iso-8859-1?Q?iY8VoMNR5F1f6JEMoS07mucPXPsPDDTiyXHldZUkHhJlnN9ki+rXsWxnIG?=
 =?iso-8859-1?Q?mTgIP1HYWB8fBfI+UpEprA4mG2Kfrv9ZyYITbJxVg5kmQWdKpVgusjGJXG?=
 =?iso-8859-1?Q?IfXq90CVkZ1CEruG2U5fip92mK4kKHdfJRDzM3TUGf49gQMjLPVwrdc1OK?=
 =?iso-8859-1?Q?hZ+P/y8uNhodX7GoF0kRw1EVgTfUSMrBGdwVMkqB1mMRhEHyXjn2BUNnu+?=
 =?iso-8859-1?Q?mChrdOzQUWsodeeVP547HnmA7VcLCDqcmB2q6qRTnKmHsZ/NheQDjJbHWO?=
 =?iso-8859-1?Q?42Jqfn2k/RzUsIK1o79Z4PvItw1syxlxaD3VKS8mhBUjkK+w4bhkZAJAQ+?=
 =?iso-8859-1?Q?zaMB3BP92n9tWy6l+hnpSYt++q1aa6dfwK791iE12WwoJkt6k8DqGueBp5?=
 =?iso-8859-1?Q?FM5mMMYBi1PCf/xBfW/1iFhKFfdwXUiX0G2kyd1lZG3LZHtfgG026c5ZP5?=
 =?iso-8859-1?Q?yX96yn28FkM7lYH5ciPpsMtSxvKo04lJg31A2F4wXWMjmR8bYdOIwN6iUi?=
 =?iso-8859-1?Q?U9E2QavEnMq4DGoINvALp8CXfA5HMjKWW0nh3K2dPcXf2HOnvRL5dRj/dX?=
 =?iso-8859-1?Q?8CYqVtm8aA0vmbPlr1OyDrDB0tvn3qIOqvqnkzOXk9eKVCwpxtt5YUj4pL?=
 =?iso-8859-1?Q?gNqjY+e3Y1d7giSh7X+iFYb+++Dx31gSaAZTobpNAdRWnNgrXwOkrVNksl?=
 =?iso-8859-1?Q?rVt+2A4NWRlpsVpSbdytMciAp8BPRzUhuuiPZE9Xl8y9ftlXGtIc+xwLl2?=
 =?iso-8859-1?Q?Ki52eH7z/q9Ao3/hYqGVTDLRhsxF0b84IFGwp6flH/P1tQ5sv92pCYgw3K?=
 =?iso-8859-1?Q?UCshEMEXPGYh9E69cinTp6g9Aakyulh3uUV9SB7QvnHipc4FnzQRxRG0Ui?=
 =?iso-8859-1?Q?qK89xws4uuJZlS99ztQOhSZa9AbnpG50cpoJrXxTryFUdAwnf7p4+PkXvI?=
 =?iso-8859-1?Q?HhTKlsf/ufvFs+b2CqQQMp5fUdUKNzHEXVKrpjdm6XQH09GSfuGu+vZX5k?=
 =?iso-8859-1?Q?9LS+wyPuKFtSsSy0y4CTLoR/Y3gtkGyK7LIYsYuN+Eki4tLUc7B1tCbgvo?=
 =?iso-8859-1?Q?wEaw9LZ9WbPaPNBEWYvfrqxygcTz+QQWNUhEZeXK0j9h4u5QVfjpp/Qlqm?=
 =?iso-8859-1?Q?9Wg2UetSRbMUq7xxER7eULu1PaVJkUbO+Y5YEsekoShBPhdX0KnTIK2Yjc?=
 =?iso-8859-1?Q?fJehp3TSYfFq3up1vTslVZlPhVIj4r4p1GUhetvOhIO3adC6uZWnH77slY?=
 =?iso-8859-1?Q?BhyHrhT2YMMU1WFefdA0MDIMBJeK?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR03MB5073.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(921020); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+jqqob1EBGYnPSmNNqLzJdaAPcTX4ZZpTH0Zbwzio093w0bp6ZqhwC6Ecp?=
 =?iso-8859-1?Q?SXerNPbpSLCH1pV7sOtdfNjLHwjDSA0qLG16yWTHGJ9ppOb7lksi/bPaSP?=
 =?iso-8859-1?Q?v91DyG2F8K2b6ucd2s6yz8qtJa464q3kDNqt1MFWomRfOFloWpEBNacyHx?=
 =?iso-8859-1?Q?Pa6l5BZ0i1t80PCeLeq4JAXajm+yYtZrP4GxA4e7aA+/mKMEAqgpjNG25c?=
 =?iso-8859-1?Q?XUKBaXfgjVIwXtuLNnUgfGumBj0nWlo4O3vMTW18AkQuuSRgDtfSAftIRq?=
 =?iso-8859-1?Q?ugI4A2v3xrndt+wwpH3oNqthDP91Rqf03wLIiJ5PMYWXz/THO6dD+xAgzE?=
 =?iso-8859-1?Q?xvkgo50u2m07aejp+719VIeEtYrcS3EukE86NXtLJYJ9X3ZW3y/psZv9wm?=
 =?iso-8859-1?Q?WrH4awI+aa999wmOGwPH0+mb+2QKBvxREK9BnHWs/sUuY7lHow1ZQY4EVI?=
 =?iso-8859-1?Q?uWJBBFOvyBUdkUhSgC4/rCbkY6n6PwTZ82s0ciflKJDz7PWlPexdY+4Q5O?=
 =?iso-8859-1?Q?7R++g6gvKlnW9YYTxbXewSioVQNpkR828cENdB1NHWMdBrRycvAhGekYrW?=
 =?iso-8859-1?Q?JDHghCerGWjnX2kVbvsLYlVCY7l8+a0pg+KS7vJPyWnr+Hl17mCMrkQyXU?=
 =?iso-8859-1?Q?iaiv5pqI4kkmzTQ/+1SzeroDo1qEtyBzGbWZbYX9iBnjy6GXccy30STPfv?=
 =?iso-8859-1?Q?N3dj9y40oDP1mGvpbAZYdouxYoIKz2fEAckN/JKVG+3/BRNn6+AKqf1Pli?=
 =?iso-8859-1?Q?Q7w65GWF6aJH395WhjGhYap4V2t3x9imUkessq1hPGjiI2gjLQ0S12H0kv?=
 =?iso-8859-1?Q?6QH0VqTMQZpuhpdcXGScMRzpTZEUL5b9H27kgIuUWYlQd7lt6RmUjiDz32?=
 =?iso-8859-1?Q?C4thXOStKH7HC1Wt5VnCxBAIlS+/bm96sBaV+R22LCf7ClblMpcciQjv6i?=
 =?iso-8859-1?Q?enQAEiwkvmCuR81tS94BR5+hIiZKBZOA8L3uvaEr8RjmGrbhsHhLh10IId?=
 =?iso-8859-1?Q?Zqrp5H6PuGfT+n6VX8in6NgNPYcps5tCnmVqwYAKzKKVsPaieYNuOckEVa?=
 =?iso-8859-1?Q?Zzq2QKjdzQmrzzt/cawqeWYDQrQJpt1m8Yb2wuyFyZvGnTvQ1ijD9M8M9b?=
 =?iso-8859-1?Q?rgoHQTzOfKdwziN2XksRxWt/wbK5O3CE+JQamRHKqTtdSOo3JDv/w8SOa0?=
 =?iso-8859-1?Q?zBfTu6pobfW5Htfc9d1Be5LAZf8iQQkY1pZP8x1/4skdg4uBDH5QcqEodl?=
 =?iso-8859-1?Q?iGYLSjhgleSf+B7Jv4yhSD2dwjRz8RBMVtKcO/Tu0Oo1l5bmV6ZTofDDBT?=
 =?iso-8859-1?Q?4OM3e2pZwe410CEqis35h7AehvVOZat1J33kzF6svw0YfS2AYky+lR4AVy?=
 =?iso-8859-1?Q?6v0fxe+lD3HfyoqewD60qnJVxb9VUbshMObMBBTkS3v81Qxh3+FXkdY3na?=
 =?iso-8859-1?Q?STJA7VEfW52vW8A4KnANJfwj+cdFvF3/JYGitc1kAyEXbAmsCDUB7F3M8o?=
 =?iso-8859-1?Q?bhGKXgJ4ZQVvQYfbE29RRPtivJ2og+ys22L/z4J07+9jbeT6sBRWEZmLK7?=
 =?iso-8859-1?Q?eOG/sZaZQVX/BcGfIoavDGi9RMYu80mqvspOwPGLdQRLw+UGEH0uvYyMOi?=
 =?iso-8859-1?Q?/kMq+5V3CnnIIlV1zpsTFyV2QtEfH2Di4T?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR03MB5073.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 759a4701-b64a-4344-0f59-08dd7c949c9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 03:13:08.0399 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6jqm8Hmm8yZzyFwHxZdwuJGHOxHvAjmHp+PEXFvlcPzqFFrVF61BVBWBLOn/PEspo6FYr/4BsCtwHTPRwZuzqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5517
X-Mailman-Approved-At: Wed, 16 Apr 2025 07:30:37 +0200
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

> I think you can add the reference of the kernel patch
> https://lore.kernel.org/all/20241204063338.296959-1-
> niravkumar.l.rabara@intel.com/T/ you ported to this patch in commit
> message.
>=20

Hi Tien Fong,=20

Sure, will update this in V2.

Regards,
Boon Khai
