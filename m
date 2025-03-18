Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EDDBC28B2F
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 05:02:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 371918129F;
	Tue, 18 Mar 2025 06:02:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ezr1h1GY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B668880F70; Tue, 18 Mar 2025 04:02:44 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::60f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C22680107
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 04:02:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3Y7u//Y1cWLgcXRe65XwrF+zP2kVh/H+MEFyntNSJfHEqkLAQwAdlhLU3SlqX0NaoFrFmAf/wXLU/GxnT4ESgMiabrHB8jSiNKvJ1himQU56VBST+zU/bUHX3ktrWdSYU01anHa7+y02xi9C7BWjbqJC1hE7ldCPrlYft5IOgAj4SxH60j+L99EQstWaw2uu/gu9CTEPPd+M2r8ej3y39vyv+Vhx8sbh09mWpvTK/9UGt7pmesYzEg0tOdbL3gKARl58uBZTr3HPa5MYWosES5oZPSU63ges/PBDcdIO39ByUZgvAoRcAQCbfEUdLYvCIPxwuTAtttKPIwuqJlwJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rPUeClARg69MuF71jazgcF7Pr5fns8IAlmql2P3SqY=;
 b=H0klHfQmF3bdB9F9egiBNf3wzUy7IUt4ZfaJnkKZ40BLrFaRnJf5WxFHjyOSPKysYcBzCJvz+aWg6Zq3e6K46IjC46p0a1bUUkvoZv4hJ+f8cOAZZgniHRQ3Q9uDDw1MpjqtwFJ4uRXQqgtIo26KS9+Hom4nHzMkiAxlGpajpvMWMGb6vgAjJe6FxtHjPHdJVZEziWVXJwAib6CTJq4mzFYCslwXl3EPrgd2aIbYF6dpZnzIO+VTNshd8Q8K1fegMeaW2TXgmTWloE3if8PORS/ZOyjVfCu8H/Cv0XMyWU27MWl71MGfWlsgG72V1Xak4KfKiGGAxKud8NuXDkTX8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rPUeClARg69MuF71jazgcF7Pr5fns8IAlmql2P3SqY=;
 b=ezr1h1GYJimr8aZVWebaUj7syhv7RZVaOqkex9Ik5qbGPHHqPcqcSlhX2hsc4IgTACLFCbS3VJLLpquJTYpUb3XAXoLrTD2QkvqHpUIQTRm1kBCVe27b9Qo0iqEqU1bsgNnXSqo/xdKqU4j/DcV7iKf4TiighP7vYBz5VilZUTbHPlq6Mz8ldtYZwjz6Rbvvi/jSImTJa7x7UMHIuZhl6sY1uD9GU2qUPJ4MhUiv+D+4lpHxZlrVdkxHkTmd/OUmqWJ0N1oyh6mPONTotjBB5SwVrG5+hbu0cz7kYdKJyax+d+hk1WyR8/G0IMrgHljA2gpDld15AmVrMZIUX9aJUw==
Received: from SA1PR03MB6370.namprd03.prod.outlook.com (2603:10b6:806:1b5::16)
 by SN7PR03MB7154.namprd03.prod.outlook.com (2603:10b6:806:321::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 03:02:39 +0000
Received: from SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03]) by SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 03:02:39 +0000
From: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Marek <marex@denx.de>,
 Simon <simon.k.r.goldschmidt@gmail.com>, Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>, Dmitry Rokosov
 <ddrokosov@salutedevices.com>, Jonas Karlman <jonas@kwiboo.se>, Sebastian
 Reichel <sebastian.reichel@collabora.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, "Chee, Tien Fong" <tien.fong.chee@altera.com>,
 "Hea, Kok Kiang" <kok.kiang.hea@altera.com>, "Ng, Boon Khai"
 <boon.khai.ng@altera.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Zamri, Muhammad Hazim Izzat"
 <muhammad.hazim.izzat.zamri@altera.com>, "Lim, Jit Loon"
 <jit.loon.lim@altera.com>, "Tang, Sieu Mun" <sieu.mun.tang@altera.com>
Subject: RE: [resend v2 05/13] drivers: i3c: Enabled Kconfig and Makefile for
 DWI3C
Thread-Topic: [resend v2 05/13] drivers: i3c: Enabled Kconfig and Makefile for
 DWI3C
Thread-Index: AQHblJbzB5UA+/NdJEyo0SznMZqTz7Ny2feAgAVhBBA=
Date: Tue, 18 Mar 2025 03:02:39 +0000
Message-ID: <SA1PR03MB637064611A2C6B26D825227CF7DE2@SA1PR03MB6370.namprd03.prod.outlook.com>
References: <20250314040902.43621-1-dinesh.maniyam@altera.com>
 <20250314040902.43621-6-dinesh.maniyam@altera.com>
 <20250314165313.GY2640854@bill-the-cat>
In-Reply-To: <20250314165313.GY2640854@bill-the-cat>
Accept-Language: en-MW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR03MB6370:EE_|SN7PR03MB7154:EE_
x-ms-office365-filtering-correlation-id: 398c5fec-b330-4876-6e3d-08dd65c957ef
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?HxmEfUf38XvwJNgfF7H8+0fKpgX8TUfhgvOOton/yWCVXVKNXAmBZ/H1J+86?=
 =?us-ascii?Q?+NyIbuWG5QH4he+nb6/EVQW/w9mU1Lz7tZWtEcRWaYoN7+Urk4zXvrdsY4xq?=
 =?us-ascii?Q?Tuv++sc9SCU0YtW52QYMystTFa+/dsc5fIysBhbxKpbL6qhgbvqwY53QcMoX?=
 =?us-ascii?Q?SlzpSdnSKu69aVIX3H6quGUPidmFGDZh8JHimnB1RK3JEV9BBN6zJ5g3R5Ac?=
 =?us-ascii?Q?nS79YM5nG74U53P2ZxkuzImPqlKf7BZ9cpgQECxGwvaDyq0FPWlPtdEo91hI?=
 =?us-ascii?Q?sDSaIgaagKyEvYaKrOeflm7C3zhwdKb8Awr3j7qwzTu10AP1Epoo2MppXCfE?=
 =?us-ascii?Q?IkXD5BnSx0Qi+pRXyeFdnvaHjuncdDnGpJaYkjjfwdOVYLa+dEKG6ZBGhmvW?=
 =?us-ascii?Q?7pUBqbWqde9cxZAvJ7dhqKhbQ4Dav5QwqUDjmSGJKJAzZ8za9I6yCvGo8cQh?=
 =?us-ascii?Q?d8gfRNhn/ps+Q1yhMlV3mHFkyA2N5XHZC0lc6/CThrwFnQwKq+YA3hWCjUKy?=
 =?us-ascii?Q?3wxYXwJGavwGasSLpG8jOsgxgntJe2Uf4jCap1sIvPOUoBLP1OU12sThXE+a?=
 =?us-ascii?Q?rK8TjnWpuwegjHrEZZBD85INDwMUUYj9SWLHG4rZrR99TyNJct+G5oLTx7ji?=
 =?us-ascii?Q?+9dk2BpvaCEq9O5XhiDoo9q9jQhgY9Ir7wZnqCeaGLVuG1dASQLVmhP6IVhG?=
 =?us-ascii?Q?gAl2gS8dTU4aDfBYBzrfVcGPBHzJ2NmIDeh4SzFhZmhFOQAg24zuJVH7CfBu?=
 =?us-ascii?Q?LbIbvAi2AWRVwTEGzEzWYgDUBmxKdzW0szdQzgcF4U/1RR7fH77rSOgaNkrk?=
 =?us-ascii?Q?/wCTH3a/LyzOJ1dTdedyKI20NHor4zYftw7AAIvnHb7UsSPQ8mgTYt3zAdVz?=
 =?us-ascii?Q?TqZ9AESOjARTu6ZPscU+RznLZKtVlh6IcPCdZz9zEDoQbZFuwCJP9/P2Lz/v?=
 =?us-ascii?Q?hhkJ9VLEbNfC6Ip0Re77728xpsdufC92/k7WfMsUAD36tEs3x/d2C1f0S5XR?=
 =?us-ascii?Q?uNlgns1CMIO96xDeG7CTYUGk4uE7zMhbmKs5lL42FnFwl/mSVGYMbqJtgQCe?=
 =?us-ascii?Q?Q581dH6MZ8FG1J1Rq5/5WobSMzhgKrLddxCMviIY+hN2F+EyupQ2MPN7BUGm?=
 =?us-ascii?Q?55T+vhVuwoFhSZgZat7UMkZZEjlhjEnrqbbCph8E+co6f23GPSR7xup7xR57?=
 =?us-ascii?Q?wYKVFHWAg9u1yEHKG68jGOzXF+Jf/VTC/sCLh529mEwZRqQ+xZ4db/kaDEmx?=
 =?us-ascii?Q?yBXvhJykKzKJKl36hq7H3T2rHlSQsq4pZvJx4OWsz2dpDhzuSmie39NlKdTO?=
 =?us-ascii?Q?EaiNTUiKNtPyv1Pnz3spEnhZ9HXkQRk6TkUcWzKpasiojzfOj5qndymjEjIR?=
 =?us-ascii?Q?iVrypkB1ERlmeEAhzdzonQhDyotIiOV5g515CJyAE18PWBJJvfXIrH8Vlbgn?=
 =?us-ascii?Q?530qqjGL7HB3WmnARCOcsdrvGeNbmzEG?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR03MB6370.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EiT/duqHxGZHtKjfqIWoTo3bFBzHp1PkazcvT+X2sdbjmc+mXzphXuAF1g2p?=
 =?us-ascii?Q?eeurRW5XnPWha1dbqaGD1poWIlvyPyU29N3khv2jjsbzAznoCl4b0zrdZMhj?=
 =?us-ascii?Q?OHSTvFAGcoyhOvH3uLjyCfiuoGGMn7rWTudlFRAJ/7zM/2PN+1qwvGpisrET?=
 =?us-ascii?Q?+TMdK7VCmQ1VpclWjnOphcetpLE2cebCN0ha+7DAMBXX2jaISNUd7clAVWQI?=
 =?us-ascii?Q?VSE58FBh30H9d7Df8bso3wsU5lnRhNuVk/Tai7NR9MaeVZ0SG6rFVeLBXiNZ?=
 =?us-ascii?Q?LCDe+2NbFqEwYQlRYarh8G9ZOJPy7l79oHILMnZX4TfnAidWsBmFvMPpcUB+?=
 =?us-ascii?Q?T4NXsuMolCH8RFTc2B0u3tUiIogivYx2dYDAuYf7nXu5M8iU0IcyXHbmcXuQ?=
 =?us-ascii?Q?nWF3X/tsRhUyWeMzSaLaLLTHGm9mSY4yyFKBrudzin4Vi2R2bV+9bSG/QZjA?=
 =?us-ascii?Q?oUFSvzIPT7Rfo9FSp/Fc8joIdq9R95XFIBCG4oWeytmmNgG26SCtiE/FrkAs?=
 =?us-ascii?Q?wd9DQIt+XCsi46dNsC4kbCN4N6wQxp7gn1aSF8QKr88HB+xe+ZwCN5nLh4ig?=
 =?us-ascii?Q?8hWxP1rfXJQLvDONKTa4waI3gyLLWZTOcizHwaFmmW2dh9MmuEh6lnzHTtz/?=
 =?us-ascii?Q?pGVuC4/Spy4HyBhaBrSKi2fmomH6xcglpOVDAp1Xktnyy85F2NBH77I0K9K8?=
 =?us-ascii?Q?C0HquhrhEl4/UpSudnCnHnd5YBJ3CxQmhuXOUj7LY4qfFjyVEUxnw7HcIsrn?=
 =?us-ascii?Q?7QkbQ0G+QFjRk704I2cZimXS7ZT2DZn6VnGQAyIy82/5BXMXToKtk3dfugnn?=
 =?us-ascii?Q?3ooWiSYsvpMJr0jFtfg0iB8D3LfApOg6c8w46U7Qykn/GD6i1YCJXelWrLf+?=
 =?us-ascii?Q?sQmexe8aqHe611+wWRnr3WoUZFrqzjvcJ72ZntegGcvAKdOuPLEVV/SKepGB?=
 =?us-ascii?Q?Y6PdJ3mjGqlz3nj7GE/yrneNOq4og9FwwaDUn6NKAmNDfIxvxw2o4XHpP4uH?=
 =?us-ascii?Q?F0zuI2pgpxMvN4sGK8rdcnOSOfNXnYYHuz/VqbUB2q5q9zM3twb1VAdgIFw8?=
 =?us-ascii?Q?39StjRd+pwE2foTuHv2+ymnlfl4pZramoddn/yPdNv6UKGam3MRgzxA68uoa?=
 =?us-ascii?Q?1KwX2b9V+YpePBDiuNoKkCdcZnxcqTI6sI2TEpjm6n2f55oEB0WEHTNBG2gV?=
 =?us-ascii?Q?wFBo1JpM/1hFlb4JacEilJhVMvAJaqIAOeCpcQdlwgA5FCDC9e0Guny2uifv?=
 =?us-ascii?Q?DL6M+sVtdUAHchLh7yap94r2ZZjLeF2kjTqs1wqUG2lGXd+nHsStU1fSLFFW?=
 =?us-ascii?Q?nBTr2F8UrlT+KRGbV1hxhztzj5pVp5Gw4S6X+OwyN5vgwJJAVelgXJRMF8P7?=
 =?us-ascii?Q?sVZOFPn74bYef8KEFl0JVbty+FKe6ZeYl5yYUKIgcnSUb/oqmpVhnJhuRcVC?=
 =?us-ascii?Q?Gw4t+Ctjac8mvAL24CWOEb1JeiAvsgxnTn7kAGDsOQOsOL3+OX+38ZQOg1Fv?=
 =?us-ascii?Q?mN9EK6WK+r8TFs3Hv5HhqyUooNdJj3L7vRSEA38SzrqdXgWNdfyQ19TtNnGb?=
 =?us-ascii?Q?YQQaAabbCRdK1fIfaxHyAcGsxzeKm4jma0xt+rwMmTm13eyzGxjD+7cIKJTA?=
 =?us-ascii?Q?UD+V8/I7XgphrrELf0S7BJnbY8y+GsKLqJdXi5O8yj3S?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6370.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 398c5fec-b330-4876-6e3d-08dd65c957ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 03:02:39.4334 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ktNJz32OQ7hy471QLhr+QF0JIzIa1Tp04K0Ey32ArsHslmwv+NpdMhQUQ4EYqAe0lgEbsG7JXaOP+8LyGq1dnDaAlXDuW+hV9Lr5Nw0eMmw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR03MB7154
X-Mailman-Approved-At: Tue, 18 Mar 2025 06:02:03 +0100
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
> Sent: Saturday, 15 March 2025 12:53 am
> To: Maniyam, Dinesh <dinesh.maniyam@altera.com>
> Cc: u-boot@lists.denx.de; Marek <marex@denx.de>; Simon
> <simon.k.r.goldschmidt@gmail.com>; Simon Glass <sjg@chromium.org>; Dario
> Binacchi <dario.binacchi@amarulasolutions.com>; Ilias Apalodimas
> <ilias.apalodimas@linaro.org>; Heinrich Schuchardt <xypron.glpk@gmx.de>;
> Jerome Forissier <jerome.forissier@linaro.org>; Mattijs Korpershoek
> <mkorpershoek@baylibre.com>; Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>;
> Michal Simek <michal.simek@amd.com>; Dmitry Rokosov
> <ddrokosov@salutedevices.com>; Jonas Karlman <jonas@kwiboo.se>; Sebastian
> Reichel <sebastian.reichel@collabora.com>; Meng, Tingting
> <tingting.meng@altera.com>; Chee, Tien Fong <tien.fong.chee@altera.com>;
> Hea, Kok Kiang <kok.kiang.hea@altera.com>; Ng, Boon Khai
> <boon.khai.ng@altera.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@altera.com>; Zamri, Muhammad Hazim Izzat
> <muhammad.hazim.izzat.zamri@altera.com>; Lim, Jit Loon
> <jit.loon.lim@altera.com>; Tang, Sieu Mun <sieu.mun.tang@altera.com>
> Subject: Re: [resend v2 05/13] drivers: i3c: Enabled Kconfig and Makefile=
 for
> DWI3C
>=20
> On Fri, Mar 14, 2025 at 12:08:54PM +0800, dinesh.maniyam@altera.com wrote=
:
>=20
> > From: Dinesh Maniyam <dinesh.maniyam@altera.com>
> >
> > Enable the Kconfig and Makefile for the MIPI DWI3C driver.
> >
> > Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> > ---
> >  drivers/i3c/Kconfig         |  3 +++
> >  drivers/i3c/Makefile        |  1 +
> >  drivers/i3c/master/Kconfig  | 11 +++++++++++
> > drivers/i3c/master/Makefile |  3 +++
> >  4 files changed, 18 insertions(+)
> >  create mode 100755 drivers/i3c/master/Kconfig  create mode 100755
> > drivers/i3c/master/Makefile
> >
> > diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig index
> > fa68612787b..8140b530bb5 100755
> > --- a/drivers/i3c/Kconfig
> > +++ b/drivers/i3c/Kconfig
> > @@ -14,3 +14,6 @@ menuconfig I3C
> >  	  If you want I3C support, you should say Y here and also to the
> >  	  specific driver for your bus adapter(s) below.
> >
> > +if I3C
> > +source "drivers/i3c/master/Kconfig"
> > +endif # I3C
>=20
> We should have empty lines around if / endif here.
>=20
> --
> Tom

Noted.
I will add the empty lines for if /endif here.

Dinesh
