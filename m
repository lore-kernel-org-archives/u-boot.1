Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A55FDCFC500
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 07:29:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2124188FD6;
	Mon, 14 Oct 2024 09:29:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="TRO1duri";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6501188835; Mon, 14 Oct 2024 09:29:42 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::624])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2995888FDA
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 09:29:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KygTOOFpsn7uBW7thRRwjLphx0eXo63bMG49DK0i0OnHdzl2L5JRlPgsVWxHLnRzPMcpu7wnyo+ELYO6VUsPkDMy7DCIEU8pxRSVg3JnKP1dyqYbkXncfnf+8sCbEqtNGeHRpsJHUwQiwkpRxjajyLZfIHodydht9/QMHQd8StchZywklCqMWpcpe/2vL0cUWp8+t/oVr14jMdvQwojKvOJMvT7gioh+Zk3y0vBOv6Asg9+zL8MjJ4cWuzrR0ISDLr0MxxoxbIqi84bNbEb2/XBTIej3OtIxkXcetYkMsS0NCessM0OQprFwpdPc8rresQ0K9gdKWZE2wapmh593dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e18gMx9v9b1+gAQKprxijZH6ynZJVGT1TmPBohXpN4k=;
 b=E+Zrn4+bmJ9fllHyMP+qX1rMUhtS33fy33bCvvkGOp6YAHhFdMhqXMHmS8LtyfYwLAkjkE4jyMH9e65knXKsIM1vrKdtJJ0PoTI5Wg6XOYm5CRi2UIFGPy4ek8T+hZ7pZVQc3lu1o79n6nFLZoosS76bw7MPQxsIog3jp++R38QvhT7S5lLA5o/BoJGZGhF0yRRMVj6KUWD/97PKHFyoLuM3MAD7ehWDvrGSTU5glWZaV1130m232xEGnQq9HGT3477Z9KnJNRVET27SFBvMsCDg+wFqL9UDHuMCyMhxEt6kjUgCGB3SMyxJdkflk9eCiJOw4cjPccPTWf91b3CVVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e18gMx9v9b1+gAQKprxijZH6ynZJVGT1TmPBohXpN4k=;
 b=TRO1durilrccmrRDtsIJ15Q03HPd+NJNr4bBP/CH5NqVMAPVzIKqyZ4rnOniXfQEJZju2v7uNRH/3qaHWQ2Tlh6aoTCG5DBKdMLdlSogjqLCgt2xnnyCsTFehw9XK2VfcH5NwgAbasnPg5EayoFJ4Cpn1HZfntaXNjO6y4qJj/sUU0SAW2UD1LEG7qTYDVZl4Shax6YVTtQBNCm8VxXbvz4rJ7A9M1EXgL1wRqIaJz5ukaidlYjwA8BAgdCl3E1zcuaYya8hFrbLPgbLZensFzCc39+FZ1wlw8O7M2FhovJjvQolqH2c4uws6RU95Zs6zGhjkf91SkEFRd0WO2PM5g==
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by AM0PR04MB6866.eurprd04.prod.outlook.com (2603:10a6:208:183::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 07:29:38 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%3]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 07:29:37 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "hs@denx.de" <hs@denx.de>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Fabio Estevam <festevam@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Marek Vasut <marex@denx.de>,
 dl-uboot-imx <uboot-imx@nxp.com>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Stefano Babic <sbabic@denx.de>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>, Tom Rini
 <trini@konsulko.com>
Subject: RE: [RFC PATCH v1] dts: imx8mp-u-boot.dtsi align flash.bin
Thread-Topic: [RFC PATCH v1] dts: imx8mp-u-boot.dtsi align flash.bin
Thread-Index: AQHbGu5qHApW/IG7IUG8V2IKfs12eLKFzl4QgAAFH4CAAAvwoA==
Date: Mon, 14 Oct 2024 07:29:37 +0000
Message-ID: <DB9PR04MB84613CEEBFE7ECE0B249DB6A88442@DB9PR04MB8461.eurprd04.prod.outlook.com>
References: <20241010082831.19983-1-hs@denx.de>
 <DB9PR04MB846127A928CBE4AB1F373DFE88442@DB9PR04MB8461.eurprd04.prod.outlook.com>
 <43ea1972-ee4f-ab25-aa98-2ae3fc4f20fb@denx.de>
In-Reply-To: <43ea1972-ee4f-ab25-aa98-2ae3fc4f20fb@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8461:EE_|AM0PR04MB6866:EE_
x-ms-office365-filtering-correlation-id: 7fd02b41-3ba4-47cf-9441-08dcec21f587
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?koi8-r?Q?9XcP93Tm00zjmayb5gfjHTKkDFh6Saq9q2xBye/Bu5U72hhnrRA4OuiF+BgZnv?=
 =?koi8-r?Q?OK2ZZdE3qC927z31sWIjk2B5+EMrBU2ffW9s96i66RCvxunECz8q1TfEIMIV4T?=
 =?koi8-r?Q?z5zr4Y85o3RUlo+qpx7GdLRX8cxpgl/zN2haiSVdU7n9k/YdOqLkJuRBqKPuRZ?=
 =?koi8-r?Q?HMz1mL8REVekWtno36qGs1qsBEMXytPCwjaNAv+IBCZjyCIPaUS97m0nQrGK7c?=
 =?koi8-r?Q?RCMHPklctSXh8sMRZMkXUkkRVj2uhA5i1SrjBo0C8GX1RQu0QJfgtWKegpJhjs?=
 =?koi8-r?Q?mgyedtCoFphJoZW6OvRGl1htiPClBS3QERKwciMUHvtMCFXPWNz3QFbOygUIKK?=
 =?koi8-r?Q?pVb9mt8FSdpoFTXbfnMxVDZcItfcCo8H3jeS2WzGTctaRaeXKLfPWLHFgqg/a9?=
 =?koi8-r?Q?eqlJdxenKOLMbJkx4fgTRoUlsciXc7zMCAL4jmcZh2WDy9Jzmov1WqQFxgZ1ss?=
 =?koi8-r?Q?TcYgiWYY8Yp8jObwKtTQLuDjNkJoKsYzy/ylzyKuYJqbGF6xW8jx2WGFC1haTR?=
 =?koi8-r?Q?4rMwx1RdATdJMPFutqcVpfWaoHhzHr4XkKKwHR7OABMTlhBypbugqPINygYU+B?=
 =?koi8-r?Q?9KW6vWTQ8FmhhKCmB0hHRI29LUeXg6ecbM0Z2pftlfBqelf72K9L5UBinAHXq+?=
 =?koi8-r?Q?RogNeh5dNvVvXVmELEMw0PE6n80Rz7Cubx/KDvSnI/Ql81kw6KersADGJSIYzK?=
 =?koi8-r?Q?xVIzneO/nYFe2O67TrPMOu5NJEoHvkwTn12EFG35cDiwdl2XL0emanPkq3uZfj?=
 =?koi8-r?Q?3KxIK/m5F8Y8Zy4x1GkqGRPHU3GU9d35MyGGZdKgVFRwEXd6lacToCFONZwKX4?=
 =?koi8-r?Q?UDfRcxLnV9s2W1b6VhkQC1ULrwdJCxola/w1y8KvPnA0KyjtL6Yabb4G6wVcxC?=
 =?koi8-r?Q?HOnpwi7Z72Ip60t8yPs6ISLWeMo8lbQLpOxs5ndt8zEVquITR+SEq9YG09kb/M?=
 =?koi8-r?Q?CsbDIKcGByEuJ72jsZg3Vw2G5MzPZtXdqAgb9BwRMBGV4x/yyH4TxIJWqwDi7C?=
 =?koi8-r?Q?lWGbEs/IOyU8uW93IgGDGiF1Et4xI/4yGdIp66q1p2qoLkmuQOuSzqtVfQmE/B?=
 =?koi8-r?Q?i7lBa23Kig3u8U3xEaFRgqo2KtbZKVYCW+digpznKV1oVTGWDxau4q7Wyl9nNO?=
 =?koi8-r?Q?HmOUvFg8UKXFPOQ80lEJRWjfQCvtKiibCMF508iKvA1MLFL/HJphikRgdNt5u+?=
 =?koi8-r?Q?ZNf80GChY34+wdSsq8wDgSXewi8hPdEtEFNwMtQ+sYBGd+EunK3AiFDfxSy8RQ?=
 =?koi8-r?Q?=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?koi8-r?Q?vOYS/wSApS1Me77p5th+Zoeg/IdSVK27/bu2UN8k3faTfNBW+nSrsfVSGZqDrx?=
 =?koi8-r?Q?NjbSB1elmDmhLcn2Crc5feS1pMBg84uGGgh56bpDb1okoz/q8JvcVErR8Mz5Ez?=
 =?koi8-r?Q?Y4gpGg19dob0WjSi27CeVBOg9/4fCgrB3/by7YjXCT/JUzaw0gm8aTMZtXDBks?=
 =?koi8-r?Q?6LnZ/bECyeiqAWRpW49kBCA1UI6RYtAdE04jzW1DPKY4piMq/Rabbg+FiMh3f/?=
 =?koi8-r?Q?wxAYZCrEyG85egPX8z7NrtNEfpgMRfncdWdz5Ge6GG9J3xT03hkubjfVxccfLE?=
 =?koi8-r?Q?Fgm4nVJKv+Lc334YPiYg3258C1yZu8CI7c70BffbcybpJjEEcUUr4g2DSetELf?=
 =?koi8-r?Q?AAd7xWV2PGYNh0y4SA7YTzGHUlmm5eKnA3I70PqbPDHTr1cdt0P3mm/Odaiz2w?=
 =?koi8-r?Q?wdcuHoxlHbP7UF5NzhtJRnPeWocLwsk9Z0xmUe4Mqp4KAsewiRu3h14bDWU0mr?=
 =?koi8-r?Q?3ZWMNBR0nwE+BfvpDAfMaPf9oCke6cgSsbDzdHzh1DiG9E9twhcDGPNMOxCC6q?=
 =?koi8-r?Q?jceS3AU6ZGOEtJutwIcPJ5WhPkloCncQfPQfeeuowCtrSIgH2YMKsHhfmS0ihm?=
 =?koi8-r?Q?OU8+9I9FKyoWW/TdYJnOHsyPlvWkIyrjqGTSNWlxpM9rqua8F5+QLrFO+dypjk?=
 =?koi8-r?Q?v9gLy0TPr0Xtrv2OtbDhV9eXFez/p0N3lcV5O/ayhHvrtpAcF6tPG5QtOSpFHX?=
 =?koi8-r?Q?xzk+FIFEueWliaoGUQ2bC6LhpAAXlJL7qfbIxAodQ8t+Ot5lMpx2Mb1+xYIKkJ?=
 =?koi8-r?Q?MkIMyiAGLXFXSyOhzDC/9C7xaWQpIQ8miyEsJOck9XjR9iic/RLcx28FWBeOf2?=
 =?koi8-r?Q?R1SYjwrB6z6+CcduLyijixhBl/sL1TOwXw1WDNH6l7asv/BW85udeupi7g1TqN?=
 =?koi8-r?Q?bVkzz3mfCqWQSAmaduouKz+/0n+PogyIBIplP7ay/o2BBmcKi6nKM6DUTQvllZ?=
 =?koi8-r?Q?DpGfwp6V/IqlLN3tQfi3pNzfUM1UeT1foRGwN2UAIIQsc7X6YjApTW3cTtJB11?=
 =?koi8-r?Q?FE9QsHR90N7+W5FoPua2lJsokasKQAb5iXSaNZ0i+sLALMb/WA1Alq4l/fwhaz?=
 =?koi8-r?Q?JFgAkE+NrLRxZn9SLcXH/7mNSoEyjZKQZU28SVs/1gNyFniuViwkMBThhbE9hC?=
 =?koi8-r?Q?711AqMpq22kEBTrvzXncjEk5C+TiQkA4rMMR23fKr2FKEyCHeHqFxrQQu2+xOd?=
 =?koi8-r?Q?MP9Sn+AdkG2PgxTBSFitqNedM4u3bzrgdFNgQW2sSHqZKkiXch1BsKPj+aMYNr?=
 =?koi8-r?Q?+VfAQs/BWDHtOz7NM9UBV4IKVvK71T8MieL8cai8fiRdfRrPm/mcs1hWyv5qYS?=
 =?koi8-r?Q?YCIfVXqJ9Ny0CHoMx9py+o8CsdGWUgm4oJ7bkQD62EaOOsn75nhbiFitjf5194?=
 =?koi8-r?Q?HvONaAwIlzJJ27OgPm8bJ8k8tZpa9OMDGr1PHpuntjdnIYFG7oUv+TReU0Mvhr?=
 =?koi8-r?Q?97hOO2LPPw28YMTfhpkpEfz5AHd2azi24YHeLgjp5UemSkSzppiZ4wE7ZHIx9I?=
 =?koi8-r?Q?8/GMgE6pPYbbLbibvjHKLzhUq+HdA=3D?=
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd02b41-3ba4-47cf-9441-08dcec21f587
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 07:29:37.7044 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wD2nJ12iDnO+JB/Ce5H8zxt4cK48AnapQx8fEVoQKxwNgVrNsGaFemY5eFJ5JrLQMWg3kgIFkWkFKFmZoJYJ1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6866
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

> Subject: Re: [RFC PATCH v1] dts: imx8mp-u-boot.dtsi align flash.bin
>=20
> Hi Peng!
>=20
> On 14.10.24 08:29, Peng Fan wrote:
> > Hi Heiko,
> >
> > With the two applied, with latest U-Boot, uuu works well on
> > i.MX8MP-EVK
> >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> lore
> > .kernel.org%2Fall%2F20241012093410.9069-1-
> peng.fan%40oss.nxp.com%2F&da
> >
> ta=3D05%7C02%7Cpeng.fan%40nxp.com%7C26dd8c31b9ca4276aed108
> dcec1c1dc0%7C6
> >
> 86ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6386448527505
> 72116%7CUnknown
> > %7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI
> 6Ik1haWwiLCJ
> >
> XVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DvZqhJCFei5qbUYZT3Lu2SF5kf
> RwT26lWufHwKZ0
> > ojto%3D&reserved=3D0
> >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> lore
> > .kernel.org%2Fall%2F20241011105827.7729-1-
> peng.fan%40oss.nxp.com%2F&da
> >
> ta=3D05%7C02%7Cpeng.fan%40nxp.com%7C26dd8c31b9ca4276aed108
> dcec1c1dc0%7C6
> >
> 86ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6386448527505
> 91559%7CUnknown
> > %7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI
> 6Ik1haWwiLCJ
> >
> XVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DtIjTPu%2Fq7wQqpzIO2EaoCG
> vgKxM%2Fy2eJoPw
> > miGiBJ9E%3D&reserved=3D0
>=20
> Thanks for verifying! So the problem is for sure on my side...
>=20
> My base is:
> * f919c3a889 - (tag: v2024.10) Prepare v2024.10 (vor 7 Tagen) <Tom
> Rini>
>=20
> So, your patches not applied ... yet.
>=20
> Yes some patches above to introduce board support, mainlining comes
> soon...
>=20
> I tried with your patches, still teh same problem on my side.
>=20
> > Would you share your commit hash and boot log?
>=20
> see below ... I must admit I have enabled IMX_HAB boot, and signing
> works well with binman... may I ask, if you can enable IMX_HAB too?

I use OEM_OPEN part, not have IMX_HAB enabled.

>=20
> here the bootlog:
>=20
> =81   =81    <> U-Boot SPL 2024.10-00017-gdf824fb3d8ef-dirty (Oct 07
> 2024 - 14:54:35 +0000)

So your board boots ok, but uuu has issue?

Regards,
Peng.

> =81   =81    <> DDR:   4096 MiB [0x2]
> =81   =81    <> DDR:   Inline ECC disabled
> =81   =81    <> SEC0:  RNG instantiated
> =81   =81    <> Normal Boot
> =81   =81    <> WDT:   Started watchdog@30280000 with servicing every
> 1000ms (60s timeout)
> =81   =81    <> Trying to boot from BOOTROM
> =81   =81    <> Boot Stage: USB boot
> =81   =81    <> Find img info 0x48021000, size 1493611
> =81   =81    <> Need continue download 1492992
> =81   =81    <> hab fuse not enabled
> =81   =81    <>
> =81   =81    <> Authenticate image from DDR location 0x44000000...
> =81   =81    <> NOTICE:  Do not release JR0 to NS as it can be used by HA=
B
> =81   =81    <> NOTICE:  BL31: v2.11.0(release):v2.10.0-984-gf2735ebcc
> =81   =81    <> NOTICE:  BL31: Built : 11:51:22, May 23 2024
> =81   =81    <>
> =81   =81    <>
> =81   =81    <> U-Boot 2024.10-00017-gdf824fb3d8ef-dirty (Oct 07 2024 -
> 14:54:35 +0000)
> =81   =81    <>
> =81   =81    <> CPU:   Freescale i.MX8MP[8] rev1.1 1800 MHz (running at
> 1200 MHz)
> =81   =81    <> CPU:   Commercial temperature grade (0C to 95C) at 41C
> =81   =81    <> Reset cause: POR
> =81   =81    <> Model: Aristainetos3 ADLink PI SMARC carrier
> =81   =81    <> DRAM:  4 GiB
> =81   =81    <> Core:  172 devices, 36 uclasses, devicetree: separate
> =81   =81    <> WDT:   Started watchdog@30280000 with servicing every
> 1000ms (60s timeout)
> =81   =81    <> FSL_SDHC: 1, FSL_SDHC: 0
> =81   =81    <> Loading Environment from MMC... Reading from MMC(0)...
> OK
> =81   =81    <> In:    serial
> =81   =81    <> Out:   serial
> =81   =81    <> Err:   serial
> =81   =81    <> SEC0:  RNG instantiated
> =81   =81    <> Net:
> =81   =81    <> Warning: ethernet@30bf0000 (eth0) using random MAC
> address - 9a:16:44:b4:19:9f
> =81   =81    <>
> =81   =81    <> Warning: ethernet@30be0000 (eth1) using random MAC
> address - 96:f4:de:9a:49:8f
> =81   =81    <> eth1: ethernet@30be0000, eth0: ethernet@30bf0000
> [PRIME]
> =81   =81    <> Hit any key to stop autoboot:  0
> =81   =81    <> u-boot=3D>
>=20
> bye,
> Heiko
> >
> > Regards,
> > Peng.
> >
> >> Subject: [RFC PATCH v1] dts: imx8mp-u-boot.dtsi align flash.bin
> >>
> >> trying to load current flash.bin with uuu tool leads in not booting
> >> U- Boot as missing some bytes.
> >>
> >> Align flash.bin in this case to 0x800 bytes, to make uuu and ROM
> api
> >> happy.
> >>
> >> Signed-off-by: Heiko Schocher <hs@denx.de>
> >> ---
> >> I am unsure about the value of 0x800 which is twice the value the
> >> code in spl_romapi_load_image_stream(), requests from romapi
> which in
> >> my case on imx8mp is 0x400...
> >>
> >> May I oversee something?
> >>
> >>   arch/arm/dts/imx8mp-u-boot.dtsi | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/arch/arm/dts/imx8mp-u-boot.dtsi
> b/arch/arm/dts/imx8mp-
> >> u-boot.dtsi index 56749ccacd..3c0bf8c4d6 100644
> >> --- a/arch/arm/dts/imx8mp-u-boot.dtsi
> >> +++ b/arch/arm/dts/imx8mp-u-boot.dtsi
> >> @@ -85,6 +85,7 @@
> >>   	filename =3D "flash.bin";
> >>   	section {
> >>   		pad-byte =3D <0x00>;
> >> +		align-size =3D <0x800>;
> >>
> >>   #ifdef CONFIG_IMX_HAB
> >>   		nxp-imx8mcst@0 {
> >> --
> >> 2.20.1
>=20
> --
> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell,
> Germany
> Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email:
> hs@denx.de
