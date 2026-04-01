Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29CE6D35163
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 09:30:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A69383CE3;
	Wed,  1 Apr 2026 11:30:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="mxff+5dc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44BD684020; Wed,  1 Apr 2026 11:30:40 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36C4D80212
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 11:30:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7VsAtpvCh0r1KvDdzLvCpk3c152rCB2y7l3wbSVqrRBP4T0BCqQv9SDyehJ6WbpsrFNPCb1+tTLQBy/T3omNYLHt7khLb4uTsznUw4xXV5rePTTbhWyBmSPIXODF2b9bJxsHJ3ttPNjTQShS9rIPiDia/skdVA1xB7Jt8+HUVZMwRDCmkTbaPUj6g37eRGaW4w6JuO3qu2y0y3EA1N3Y+nqn+n03fQwUM5uwCsChQiA/xVCyCv5pIYPt45mKf7nW6UPi/AnLJjuADlHldzDRlK26gqsem3d6woRvdqAbWGDL3WzINS0TJHO0HiBzEMmnbxv0qx3hMlW3+amD5bWFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xOS0ntz+x1T2bwN2Y6Q4HNfx5oAJspveH5fWKOt5cw=;
 b=ORA1dbGyyQrrfFwOwZdfrKpm7wvqStT+oUau9YmDxLEWFE7PflieUSXzXDyqbPJJmnikgbOT8fKr7W7o+57MuCAiHyJ8bzBi9fooRi4kUNNsZjwrLaiFIi4DxnPtWAGHK5uki9ygS5aMAZXncaTvE/Bp+FSS9S1sg8Fq5k7DtSdE5ZRWG0aQtiIRJAwkmOqQU970d+iEP1Ugo0D1i50sSMcZHKQ6F+t2gAw5URNDzTG0HlxGupFtywEd7iTPJPIPrVOP1qe4XEDV/ygs6Nwxj6rqo0AAcUDPUY6zPztYqrYipj6uEjrDkx3E0LXyg8mxI56S8wKGHVR81Vt9qywkXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xOS0ntz+x1T2bwN2Y6Q4HNfx5oAJspveH5fWKOt5cw=;
 b=mxff+5dclW6eJc6dOg9OkZTqyJYiKeya8S1gwuS2qELLERhdXbO6jt0D8PCuG8BqblSxzMh/pDed8mTh92rLC/TNuXHOZ++EWCc0QhRpq8+rZjn6fwIjiiYD4+bBElPCP6rSkAwZdJr8ZkuJdRIHWH+ft5yyaJxQhZDKFLjPQ2iZgCeaeDaddhOCQgqFmX+TfwQcpIksvb/+wVVmF9sOFvaYQAXCEi12RiLaGcqh7qCTvbw4p4A7W5ouBdDtTe6Pj7UQpyDaCBNLCta3rSxYDE3q13r1Lu/Yj/ehlI53PBungK2lJS9AX4lrWjj+PIEmfdjABXdpAJ9iYh8wru2hFQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8325.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Wed, 1 Apr
 2026 09:30:35 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.030; Wed, 1 Apr 2026
 09:30:35 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Frieder Schrempf <frieder.schrempf@kontron.de>, "Peng Fan (OSS)"
 <peng.fan@oss.nxp.com>
CC: Teresa Remmet <T.remmet@phytec.de>, "sbabic@nabladev.com"
 <sbabic@nabladev.com>, Yannic Moog <Y.Moog@phytec.de>, dl-uboot-imx
 <uboot-imx@nxp.com>, "trini@konsulko.com" <trini@konsulko.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "upstream@lists.phytec.de"
 <upstream@lists.phytec.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>, Leonard
 Anderweit <L.Anderweit@phytec.de>, "emanuele.ghidoli@toradex.com"
 <emanuele.ghidoli@toradex.com>, Benjamin Hahn <B.Hahn@phytec.de>, Francesco
 Dolcini <francesco.dolcini@toradex.com>, matteo.lisi
 <matteo.lisi@engicam.com>, "abbaraju.manojsai@amarulasolutions.com"
 <abbaraju.manojsai@amarulasolutions.com>
Subject: RE: [PATCH 1/4] imx8mp: phyboard-pollux-rdk: Convert to DM_PMIC
Thread-Topic: [PATCH 1/4] imx8mp: phyboard-pollux-rdk: Convert to DM_PMIC
Thread-Index: AQHcu26fu/SKG2qt2keMIyt632OA4bW9odiAgAAMctCAAA7pgIAA1XPAgABLxwCAB4MQgIADgv+AgAAXvdA=
Date: Wed, 1 Apr 2026 09:30:35 +0000
Message-ID: <PAXPR04MB84591263019498DE85D9C0408850A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20260324-power-legacy-v1-0-ed432367817c@nxp.com>
 <20260324-power-legacy-v1-1-ed432367817c@nxp.com>
 <0c16dfd0d1cedc87bbac071030bbb4d6f04ff4af.camel@phytec.de>
 <PAXPR04MB84596009AB3591BBE0AD49F98848A@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <5f44e3d45ac725c16c61a92fff527f9b7bea2fc4.camel@phytec.de>
 <PAXPR04MB845968E9F7A73809AFAE21E18849A@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <fd99509a-315f-4c0d-b300-eba1308f7ff1@kontron.de>
 <acnemXvnI7Ifs3Xp@shlinux89>
 <fb79593d-3017-4169-a91f-85bf265c6039@kontron.de>
In-Reply-To: <fb79593d-3017-4169-a91f-85bf265c6039@kontron.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS8PR04MB8325:EE_
x-ms-office365-filtering-correlation-id: c4f180cb-a9ed-464d-a20f-08de8fd15424
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|7416014|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: ZQzmijuCbfeDNmqVWwSatjRdjooAQzaRjrrNk/IKCdL8EdipN+rNmA/iZybpaBuDmFlrUJvfzkgKFAyEXQbadGus1P6YxBENTCDUKzzppQ32CDIY1R9i32kGH621pNidd7ksmOGjym2lykKfzJudUeB7ACWECczPe5ouk7XoHUhCZCy66S/HD6oYRJ4wQiwBCvRsNdqeLMvxZqtBloUofH2ML6dD94sodoT2RBmJch96e4l0MT4Fq2SXe0RhtYDFdIQfRJy471b8nY29XVBf8z5YJ6GZvCMj48HmOjXdhoNKlrujnPGr6SE7nGIpnA0XwWobRydgYR+WK3t7Wuza9bChp7hyPDccfotIqjmWzUeFctNJz9VtP8T5rURvYajT0Lt6D5ZDWfTjpIiWEbuDOhJsyHgZd+3upgXbM1vFu+RjcuaQE8OSRjHoKUNyrec7EtF08xTVspiPCsa0iwQIUuSgRVU0kNhAcivfI/oDy6Uprvxr2/hmzre+DShtx/BIKkb3SUsRNILcqhgUn4I6juTmH9FFckm1UHOHFAo8H87GFJm4JP5D21nGCIp6zc4EApZfq7ANL8xdji3mL0lgCxK/al1h6jZmQU9ZvIHdhIZIUTNKToGe6z1ERoAzayNTqe0+BHRx3Lz5NQwTSqQL6mTsZl4mE/2mTONqjjyfGFNivl0vZAdzNWk0yqmsa6IF7BY4R0vLnWJLMwKBdgdc2yD0h09JUIf7VWuZdULCoRVwMOEJBgqr5Vm19ywkOZRs/zkMgf97HhtJtTkRDy3m2e5rzQj2/7wuJhdYIhIbKFo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OGYEtZokwmF3sOVfkofwP/Adhb7Ib03ABMFRth5rIUSEDPYvNakT3V6qKZW7?=
 =?us-ascii?Q?kjM02jv/2DRNV98WD+oH60g0eVkotiM/jwyebSd3S+6lq3+I5nEBKB1LwL71?=
 =?us-ascii?Q?gIsqnyqlLX8g0/R5BOa6HkXVYW1nA4lIkJjsUfmj9pymwc6ZI/P/BHVTnlYQ?=
 =?us-ascii?Q?A7ombpLMvSvFfr7rD4aMMZYQIEdE6GNL3lHWyCIn/9XExh20uHhJxMG4ha6m?=
 =?us-ascii?Q?csru6Y49grnKUxtmvmmCJnmde9jN4SsG45OPyyiU/7q6KA3yGEjStUv7PjKi?=
 =?us-ascii?Q?+xx7hRwMDHrp+PXbY+nBd4aQm4CtYB3wnI0IxBJcOwqZOXSFjJ4B/AptXnMm?=
 =?us-ascii?Q?EUrJZEMHL630D+jCKR6zvmoyNU+XK2HDekGO0tXAA900yC8KkMnuZDW8CT0L?=
 =?us-ascii?Q?1FFPReHnB4WNmaXIFZ+NYy5WPOifjg+5odySaUh93WYHr90bg01Srj9kpXiJ?=
 =?us-ascii?Q?reJ3ACZlDS7uwwtUYFwL1QSV17P6clk1Zj52cbsPQE2JoVteN/uw6hiFQkiO?=
 =?us-ascii?Q?ghun+eQpvEnRaAh4z6dCPE3Rg4IoxyAkdd4r4tTlp2qmJqwM9UH2iQ20vG1G?=
 =?us-ascii?Q?4jKF0HYUMbEUGKiUX5vHHPTHfaIUNBL8eKeRaS4yZDfov6PcTuLpDXhg2Z6/?=
 =?us-ascii?Q?vLwvNGQEotfZgrqZe5oP+eDUlVIODdK/3H5DEiZLswvai1rN0o1GAFvKtucf?=
 =?us-ascii?Q?uDzx+CXReBDXV4fz607mqTHPpGGN7bZvmhWTKdNV1+1MFAEyIMXrwNZJcDJ4?=
 =?us-ascii?Q?53N+J6B7mlqGT1tApsogjHjV0vQnjYGuq2RqLEpNukOHwJLeX/vu8oyFe68L?=
 =?us-ascii?Q?TfWusl5cvHQ9yi9MLV7jIp4jhugQ5N9uq3Vx1BkABk575V09TA2BGAWpQpyv?=
 =?us-ascii?Q?ydYa0wNAlbRlIhZN1UXbLarRXGQp5hhMHThbmc3L+jAfzZ9EM1s+sLeUeHn1?=
 =?us-ascii?Q?KGyTEfSjaN5ib1yk7YP51cOi5lM+xCvoUevzlU1+Di5zcF4AXxA1PJelg0xL?=
 =?us-ascii?Q?i2kxYGeLxHwHliNBQBTfFcYaXKpJr9+ZIWDwHozg1JDje6SR5bZN7bMWfkB5?=
 =?us-ascii?Q?T6t6BPMt+pWntBTWC8K57p+i3i1Y7jWdLKHuikYa35fQo6ndZ8eAhM1arnHP?=
 =?us-ascii?Q?3wLpUpb+fB2bdyaFMJNHDLx/+vxVBdWPUgiIvhl7U3tmpusjm42WHbavYFoF?=
 =?us-ascii?Q?F6aE6JQQi/77JqbLYDjgb9NI7vE80Jd0RZWhQDKrXaC18uPpUYhQECFcuIML?=
 =?us-ascii?Q?92w/WnQALBh2NnRacmSyTcYPFuMOxXtTF8PWz+0/SK/Wnz70SgSq35q8nnQL?=
 =?us-ascii?Q?d1lA++h9nqCWNYpu+AWHX3/i1F2Lnsx1ai242WN9pEyctPPau74JIzOpnzXH?=
 =?us-ascii?Q?BA5oa8jcP5HdL5qrO2+loJUm9FItMdGknT96iBTMMWEMpOURQ69owtpxokV2?=
 =?us-ascii?Q?OKOZBPnHZ4+jocjOMD0uRCyMGZvWkw3DRl8FyUzCo0z76U9rI4u+oHg4130M?=
 =?us-ascii?Q?f0i+OWyoSi0RJjAfks8gSN65sbS1g4RlEfZkaCgNa7BbA8vrXF/YZXa75l2H?=
 =?us-ascii?Q?tbHT+LGwT6SI1r40/Qy7mZIARjKNnnxBBUJB6g5BCBEBW2R+ga4tWn4L3fLP?=
 =?us-ascii?Q?WP2+xKvkadDi6nQdU6SLfYhOjg62hCOwu+bh3NnI+pxamZxXmL733p2KWDnR?=
 =?us-ascii?Q?UJ2UmFcKsUDI0iXxgwALPnEfTraGnLEc8/XsoBzMQ/fQPLgQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f180cb-a9ed-464d-a20f-08de8fd15424
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 09:30:35.5404 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /fh9XGWieC5IJITlrFsuXQuuQUwcaeFSCP4J6WDb3x1IaEtpvY95U7xkkx9qurfJOyFeaSwP6AAKAs1EjzykOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8325
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

> Subject: Re: [PATCH 1/4] imx8mp: phyboard-pollux-rdk: Convert to
> DM_PMIC
>=20
> >
> > I think this kernel patchset might be wrong.
> >
> > GPIO1_04 is muxed as SD2_VSEL, reading GPIO1_04 will not able to
> get
> > the PAD value of SD2_VSEL.
> >
> > I also tried in U-Boot on i.MX8MP-EVK.
> > u-boot=3D> mw 0x30330024 0x11 =3D=3D> set SION and MUX as
> SD2_VSELECT
> > u-boot=3D> md 0x30b500c0 1
> > 30b500c0: 2000780b      =3D=3D>BIT 1 is VSEL, already 1                =
       .x.
> > u-boot=3D> md 0x30330284 1
> > 30330284: 000000c0                             ....
> > u-boot=3D> mw 0x30330284 0x1d0  =3D=3D> Configure PAD
> > u-boot=3D> md 0x30200000 4       =3D=3D>Read back GPIO1
> > 30200000: 00001028 00000000 00001028 00000000  (.......(.......
> >
> > value of GPIO1_IO4 is 0, not 1, but VSEL register is 1 in SDHC2.
>=20
> I think you are right. I probably misinterpreted the documentation.
>=20
> >
> > So with your kernel patchset, reading the voltage, it will always
> return 3.3v.
>=20
> Not really. Reading the voltage in U-Boot works fine, which is why I
> thought this is correct. But I probably also misinterpreted my test
> results, as this only works by coincidence. We now always read from
> LDO5CTRL_L and this seems to have the correct value even if
> LDO5CTRL_H is actually in use.
>=20
> UHS card:
>=20
> =3D> mmc dev 1
> switch to partitions #0, OK
> mmc1 is current device
> =3D> mmc info
> Device: FSL_SDHC
> Manufacturer ID: 27
> OEM: 5048
> Name: SD8GB
> Bus Speed: 200000000
> Mode: UHS SDR104 (208MHz)
> Rd Block Len: 512
> SD version 3.0
> High Capacity: Yes
> Capacity: 7.2 GiB
> Bus Width: 4-bit
> Erase Group Size: 512 Bytes
> =3D> regulator dev "NVCC_SD (LDO5)"
> dev: NVCC_SD (LDO5) @ LDO5
> =3D> regulator value
> 1800000 uV
>=20
> HS card:
>=20
> =3D> mmc dev 1
> switch to partitions #0, OK
> mmc1 is current device
> =3D> mmc info
> Device: FSL_SDHC
> Manufacturer ID: 6f
> OEM: 303
> Name: CBADS
> Bus Speed: 50000000
> Mode: SD High Speed (50MHz)
> Rd Block Len: 512
> SD version 3.0
> High Capacity: Yes
> Capacity: 3.8 GiB
> Bus Width: 4-bit
> Erase Group Size: 512 Bytes
> =3D> regulator value
> 3300000 uV

I think the regulator is always configuring LDO5CTRL_L,
whether 1.8 or 3.3v.

You may check the dm_gpio_get_value return value
if you have time. It should always return 0.

I not do test, but I have checked the RTL code,
reading GPIO will not return the value of SD_VSEL
even if SION set.

Regards
Peng.

>=20
>=20

