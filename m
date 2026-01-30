Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39F6D73EB2
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 02:06:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E36784131;
	Fri, 30 Jan 2026 03:06:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="fm4jMYAu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 104C884175; Fri, 30 Jan 2026 03:06:10 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB14E840BE
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 03:06:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wAKLwrzPQ6a07h/bQDg90XxzIINgyUxHr89KbMC5C1p90IhM8FneSqSGq1tyZPGPhRF+CmEcZnMBu20bJeYT1ahSQ0LhxH1Okobk0ISWX5Vs3YIrV7BXMyEi8NKlEFO8ZSvWvPpFP3I79ve019zenfSMvakIUw4ad1EgdEeOLA2H+ocwozWMd5prP6ue3rague11FHvURTdjYcDLvr+Brury3t8g9pKDUd3/if8/8bd50EElnqoJ0eHyTa7E4zFf3ddVW5w3aQ3K94y+djwnj0drQWVaF7wHtCIXhEX430kF223gvAAeEfeYj/m8gGIPA3nJj6JdSSNB1NHdbsJseQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5FkPbgK9SDRjp4B4lkl6O3dlu0ijCubBUZHkRzJGKQ=;
 b=fpI4ROgfu6F+hDM/s/y1Xcn14cL2H4yZlJqKBMsUxvKkj4rZVBXsIAmM2lanE4dSABejZEFy+8L6/XnuFCRCSX8DcdoZziVH/zmoGkdlL5jJlHpcj3HAU2gFfosDNaUpahoazYzvhJ8pSaAaktOrkkN9EA9sGIirRaB1y5xgeXZzqaSjW5jBrpP8NMr2Rhu9FBLF79zAY/Ey8RYltPFalP8uqxEZEKFo8/amqYhx88EWSShigO0Q7qwuBLgV4EHRIy8ygZNWVbFidrx1HpY5+d8AO+wuQZpVvJz0IbgFVLEp+dyd3pe+4zfcw8Bt76j9n9SLuMLWYah/msAP1aWKnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5FkPbgK9SDRjp4B4lkl6O3dlu0ijCubBUZHkRzJGKQ=;
 b=fm4jMYAuA/phPvd2wQmM4sdBlKb97IFdzuv1TbrQpuLSi+87tYMKf4ICpS3J89n0nDiozw6IthsUg0NTplIJrkxt/Qd76qWS5hw8b36LILrAwWLTyVRv1yoSQo5VK8hpzqSx9z76O11XU8p0Kq9o+UT+O62CtMzZ1hjTho2f7MSr53dZ9cTwV26y0D//6cAW1M50nMyxNeShlx0XQKT9yM7w5dAzNuG6jRczSxAHovM8qTKY+6F9LifgozLaKdz0JG6mXSicC2sJTGQ4TugpLabP0WiBxNpKb/DylGWybtx+bnp2F3zfeAyg6ly6rk0ItOelfuBSCsp5zwSBPGqE/w==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB9401.eurprd04.prod.outlook.com (2603:10a6:10:36b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 02:06:05 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Fri, 30 Jan 2026
 02:06:05 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>, "Peng Fan (OSS)"
 <peng.fan@oss.nxp.com>
CC: dl-uboot-imx <uboot-imx@nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Stefano Babic <sbabic@nabladev.com>, Fabio Estevam
 <festevam@gmail.com>, Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>
Subject: RE: [PATCH 4/4] imx9: Kconfig: Enable remoteproc for i.MX95 EVK
Thread-Topic: [PATCH 4/4] imx9: Kconfig: Enable remoteproc for i.MX95 EVK
Thread-Index: AQHckP8gjlp8yRpp4E6TJFNIXWiKdLVo6oCAgAEL+zA=
Date: Fri, 30 Jan 2026 02:06:04 +0000
Message-ID: <PAXPR04MB84591087BC940470B1AC0227889FA@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20260129-imx95-rproc-v1-0-035b2dbf3e57@nxp.com>
 <20260129-imx95-rproc-v1-4-035b2dbf3e57@nxp.com>
 <20260129100133.GA30853@francesco-nb>
In-Reply-To: <20260129100133.GA30853@francesco-nb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DB9PR04MB9401:EE_
x-ms-office365-filtering-correlation-id: 7aabe0ce-0354-44ab-ffc9-08de5fa42007
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|19092799006|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?6f22+qRGIUum1mR3/IAmaUKEYNUHIIt1AXIlB/6hwLShBWpjZnNLJatUh3Zq?=
 =?us-ascii?Q?Vll9yXUf0+eTuuHNPGSEdzPkMJtvi6dV/ul341HZIwEzYiwtuBmOhDb7eNAh?=
 =?us-ascii?Q?ndnyARxFfn0VI+Zl6gzumKYE2LXOio6djPxqGyHjkUZ3D/r72jgVJ513PVzM?=
 =?us-ascii?Q?D6ew3ok9DPP8PPGHxEIEUJnm7Rsu5cakWuA6Ui6qSkU4TKHX9XCeByGx2QFW?=
 =?us-ascii?Q?vFbE3hbSUT37gEu3JSe9+gwEStDLE2BpNsYXN/c6kQq+JdIXNSov5ShFe96Y?=
 =?us-ascii?Q?AfMtmmCVHLy6m5Ief69zKJHED2zkwxjONYlZHsOylOZg41MRFJ0gK6iLtQJO?=
 =?us-ascii?Q?loXIUXFHHieA1H2b5r00R1Ak1UshbjBe3jhZyDSZDllOC2UnwS65j9zCGnQn?=
 =?us-ascii?Q?LfRC3JALLttZUONdFZZikWsMEgcivvgAZD/wpSpJ5aC5bd7SOpzjN5CMynAj?=
 =?us-ascii?Q?50erxsg6vBIPZrHVtl5W7Q14NgQuOxO+jY3Fz80R9hgDWReb6Wr/atwTiub1?=
 =?us-ascii?Q?WsuyMbwxZJht2rU3h7VUw0+spR0h4N2e9ysEcuc4/oWEAAIYrnJ9TzbRmKF7?=
 =?us-ascii?Q?zclulfuC8XsTEKnJXzz4e8mccaVALcSqxs8Ycju0XTJUxILoCDZ6DUyqjAqb?=
 =?us-ascii?Q?Zan1t9ykUD6Ts2ypyEzylCqzIhCZfuW+AEj1jpqHynD0MRGSDJX6jqEYzLx3?=
 =?us-ascii?Q?7wQ2v600iLOYoiQnooRkeBYjprpCitHjFXnFMGNIbweRFRchI1HERZ+lf9t7?=
 =?us-ascii?Q?p0HX63DK7FzGslyu5DTbToUiqf/8BFgJMZKQucVyAlw7CYcZ4Y5xrP1d+wys?=
 =?us-ascii?Q?7Mx4nbWqC5xbyZjI6Zt2FAX1AxkeIKVHttLO8nTVOprlpQoD/QxSezxYoEvZ?=
 =?us-ascii?Q?mJFEMAuZfdB3Jkv6YbSl4X0mnBL4Pb5RbkOKVBfhFadF+sIu0Z4FsrtWsAuF?=
 =?us-ascii?Q?uLA88ns7YRHWDMbcHHylwB1z4kgctaVo6DeBwxyO8GRnfFOIMClMh9x9Ehva?=
 =?us-ascii?Q?Uv0KXuFIjuuTqFQURsjPf37QuQHdDVJYedAOwC5R/iOxa2CqsMM3hwcgnNZD?=
 =?us-ascii?Q?UJFwORQp6O4xrEGS/fIcHl4fyGp3WwQfWAhAJrqPZmlTMYisssQixpO6OqvF?=
 =?us-ascii?Q?eJgC4FE8h3Kcj237RL2JUY2CzxUzHegmG+J7YGHa+afBsq5zMpVhasmHmhdh?=
 =?us-ascii?Q?dTqKeQwL4k61B4NdtF0FELSjTWFBR/h3JDQEyrnrHVXaM4HaX9/JpLRf9I2p?=
 =?us-ascii?Q?aW5Uh9W7wc4CvE5xziJ91QqszzcLN6pC+Nsg0eost8uZhqwc25N9hp7/uwRR?=
 =?us-ascii?Q?i1z9ask3rY2PS23g41zo/aJphPcbazkqts5xHB+3M5iZ44cMmxDsarKVsOgZ?=
 =?us-ascii?Q?h6HVfLNLZRZ1B5B4m7cGb8NY6HSxxsVgOUdR7OybxftL+NpgPaaOkxPXJ1eR?=
 =?us-ascii?Q?eMTg1i+1p3K1HcTppFjLkUmq+6awiccXgNhG34HiP1vx2sAPdul9QNSuVqr1?=
 =?us-ascii?Q?KCPRcGxxX7T+GavFuR+4A+ypi2CqFdlNK1mbNopDg2fv69A8P49J7VBASXNm?=
 =?us-ascii?Q?szHFaYEBQ8KkHuICvwe5U2ZUOhdVPafCKvIXgn1YIZxoDxKta788VcBGHFIa?=
 =?us-ascii?Q?WGl/bFylLsQMydGZ7BbnY30=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Fx9S73SzS15xZknAxhnHsHVvS2jEAbJ5LOxqXOEvoDsjHZmHU8KRjOEtsbW6?=
 =?us-ascii?Q?woCy4zg47efxtVZKu07L5xft36XfVglsnYf3SjzAPukth/O5a0OqQBHUh8SE?=
 =?us-ascii?Q?mAAymg+A0jFEp3ti+/H8V39SajAxhYKPAgi3r8ITPE8xnPASwjvgZcmcaMt9?=
 =?us-ascii?Q?L7JpNyyvu4xd0nIBPaV3q53JvGcAFE9wTpw1tf7qX7e7Ftfci+Y1wZeaWfsj?=
 =?us-ascii?Q?bGKbp1D3mIeMVDhfHw4Z/nUbEMnS5GlDjENoEcf+CzMPKUlfnthUsOZThHBS?=
 =?us-ascii?Q?vYkhbHGh9gDiNBeY+dOp2oxaLbfWJVYKaMPN/QHpTt162EwQ4UNvhF3eaKYH?=
 =?us-ascii?Q?J/04VTu97byxP52pE9egGcMshqtuF9Pl+g46Aev05lJhpiyUsAfZB+3nXE7J?=
 =?us-ascii?Q?tFW8pp5MfKA0jNLZ5pSL1BXF1w1HugjF3162WdKja3l2pOO9BBScvERPl1ha?=
 =?us-ascii?Q?nsGs/8jO+3VAGyViF+YVEde9XV8zgiV/g3+G4RKnZF+TCJDV7tMvR/BjDz5U?=
 =?us-ascii?Q?8SqgAhKX5vRw16/4h0mlNgaO4UNOmSg5c9uxeIKYwV1QEOrl5iFCefFcDFy4?=
 =?us-ascii?Q?HXa2sR5pMjnuWnRaAUXErgZu5bff1J30VM9qO3LP0E0I3co79BB/5S5i1Qfy?=
 =?us-ascii?Q?yi1lKzzj/ZYGTPD4OHWaX8+syDf00HjuX67IulTwxCXvedqX9Vh1TDLQl0Bf?=
 =?us-ascii?Q?fOqpHINrtj7tfapdZq1Na4fTrOg7KrB1qSQQyP5alqS57QpvShnvWEofAX+G?=
 =?us-ascii?Q?0qm15iwJHxKuEixFrIq1lUlui0VMsGSf9ITf00dWgxWqB2TJn4Ki9Lgu+Lvu?=
 =?us-ascii?Q?8qqSyeExVr40GfGxW9J9KBtHJ1BHqFW4Lrp71U1BKQ2Wkr1w4P0M6w38AhpD?=
 =?us-ascii?Q?Ha0vmovPDfojXQQIa6+ebJ5kIDLLnmp1cY/j/HLWRIlbLsZju6o28AbY/KbH?=
 =?us-ascii?Q?Tr65r1Y1CgJ5EhCOTD4GsSIMcVt9hnprT6nkIBTE37V1RGXL8IFeupxMnSL8?=
 =?us-ascii?Q?otLUSiaHB8iDpAQFpAjNi4677001wswZBb0yoEeOAbqMFDhZLl2dM6p5GezS?=
 =?us-ascii?Q?zJPN1ZwE5SK9N9s3ad/MV+nnKuh6LD/yvyCDuUiq2/w19nkTeoD119uC1DZ3?=
 =?us-ascii?Q?fog9Hu68RikuJiyBh7/mSvxyujcs5hK4tKZLUXl6s/eqzZjUMR8K77biImBN?=
 =?us-ascii?Q?p2Aw2pyYqMP24Jrrnn2sA/5y7bSeKhvXh6bmXWBibIfrJVmdiAN+6td3Zbii?=
 =?us-ascii?Q?OxGfopfKehw5tdFjoAaksUk5rp4LkYqkZkA1gtEPON+XmfCcuchxWIkna31Q?=
 =?us-ascii?Q?7mu5aHCinY7gr+neEajEcGSObIEprdVeEsC9AKHxbI+upf1sjoZrJ0gyISTS?=
 =?us-ascii?Q?BV8FcG+XIYHR9/EB9ylmqRiuWbsOOwedRU27of3CDChXRUiwL0Au+DFRzM9N?=
 =?us-ascii?Q?E2dTUIooc8/jENk0VG2z/vEXfCBAkaKPLqh3AIEtyd4N+h21+kri1LSLX2iT?=
 =?us-ascii?Q?CRxY2N9PtSfZNiw0JUWr4elnx0PWv+KXSc5mCNdGanDs4iMs0Yw0fIxO4P0R?=
 =?us-ascii?Q?7mfCo7QiCarWidEfumloN5ldPNGMUOTEkr9+JbJly2aBA3NwgB3L/mvQx7iZ?=
 =?us-ascii?Q?oqG+ShrI1b8vTgxAxCcY15FNuY8Hso4+PKkSz47gwBSf1sbnZciJ9dW3EIpx?=
 =?us-ascii?Q?zrwzpJMsouwCvwMN0V1o/2lLEzTGm3PApxWw9lmszY/A4dj+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aabe0ce-0354-44ab-ffc9-08de5fa42007
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2026 02:06:04.9761 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BRSgf/HPjLQkkbGn+RIRFfocHi8wpcFWB9Lo4tcpcsP2f34V5M9gRyrEbsbxRmkRFoXd0yTyzD4qmi4n0sz82w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9401
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

Hi Francesco,

> Subject: Re: [PATCH 4/4] imx9: Kconfig: Enable remoteproc for i.MX95
...
> >
> > diff --git a/arch/arm/mach-imx/imx9/Kconfig
> > b/arch/arm/mach-imx/imx9/Kconfig index
> d9f97e4328c..7051e086072 100644
> > --- a/arch/arm/mach-imx/imx9/Kconfig
> > +++ b/arch/arm/mach-imx/imx9/Kconfig
> > @@ -134,6 +134,12 @@ config TARGET_IMX95_19X19_EVK
> >  	imply BOOTSTD_BOOTCOMMAND
> >  	imply BOOTSTD_FULL
> >  	imply OF_UPSTREAM
> > +	select CMD_REMOTEPROC
> > +	select REMOTEPROC_IMX
> > +	select REGMAP
> > +	select SYSCON
> > +	select IMX_SM_LMM
> > +	select IMX_SM_CPU
>=20
> Why doing this with a select in the Kconfig?
>=20
> I would expect either
>  - you enable what you need in the defconfig
>  - you add the select to the imx95 soc

There are many defconfigs in NXP downstream for
a single board:
$ls -l configs/imx95_19x19_* | wc -l
21
I would not changes so many defconfigs.

I understand there is only 1 defconfig for this
board in upstream, but to ease NXP upgrading U-Boot
to new version, I choose to change Kconfig.

Changing to upstream defconfig in upstream is fine
for now.

Fabio,

What's your opinion here?

Thanks,
Peng.=20

>=20
> Francesco

