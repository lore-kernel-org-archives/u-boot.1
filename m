Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF31D41C1E
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 09:10:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DF4289543;
	Wed, 13 Nov 2024 10:10:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="dVDRnfmJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AB73890FD; Wed, 13 Nov 2024 10:10:50 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::62b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74F51894AB
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 10:10:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pFEs2XhL6JQdSshlHnM1VFizhLiFrt73oGp3hh3fowCQkT3X3z3znfPBuAuud0A4DXTqy2f9KUyRWx5jujChOAimSQoxQmAN/8Tc43ieheQR5t5q5Xbzxz+rhKglEmnKX8WvkNiNxu5c+B4EwAIyhv1v4C3MRo9M17JzsXgYmq9kobgL6W/SQPqFyiTuSuEdrwsCXeHIAYexd/q0oJtk2QQErRdImzz8auM6OFyEWPm0+1W6z14IHySkSYfPs0uIgsqxc0OSj+xSpcTnpGI8eNyfGGU6KiXVxeUx4WwZMbEdmtcyFwUxsqsaGW7aiQrkTGVX6MOFTLKKrouczLDdGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17JfLt1n6wzNM843tw8qoJ6ipsuQ5v82DES0GZ4u6Ds=;
 b=rDISuidY8ja/shfK2cnv+n108KXWVZlAmfhL2j+tnxsYhxNstbF/FvLhgM8edOGDTj4g3j1m2IhsRRY/07xtroqKTAt/w5oGjkcXY77ssfWC6F3pPSWKypC1PNcG6vmgc0IiuWowY8PLTMlh0G5qXP8SCdKXv+/eJOS2whvdjTN+NWr7tZAx+duXoDHv54dXPn5NsQKG40mUywRM1CQw8lPUKTTSVJlX+Z/48CwZemOndL3cfwhI0PiB+tGKD2N2DQ8gX60gITrF8ODXzueKtjvV0IOMXNyXQ7nxS6XDS1mxD4WQbekwO1+3/ojD2Rye+Rde6Ecwy2WyeeSYBKPIhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17JfLt1n6wzNM843tw8qoJ6ipsuQ5v82DES0GZ4u6Ds=;
 b=dVDRnfmJ4IM1uOQrsNv3tWpFzQFb0T3ZH1MOmvIpcY/ga3mQHBIECtpz0QJ1/hLkYOxLdSYfbyDcpEH4eoiNDKyEbYrdFam6ehpuDtclEUqIJUSWbuXBgjYj63W41FGOKBnYUCrZSYvrNZHvOQjNjvLGIEeGTcwBLp0k8pgKHc3Xm9CytJKHhH0j1NEQl0CRR/7aEWUr7AoVsgi5CRHxTXQpzS2+q0fj5v5/VREV5e2Z1+kiyrWQ34BZPmKiJAcs8a5S/eOSbIqPwUu5aRpefunCR0gMTX64sjahNu2WKbxxZIr/NL3K12BK53C5g6ioGCrcsOZUD4QbOF7U8+q+0w==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB9326.eurprd04.prod.outlook.com (2603:10a6:102:2b8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 09:10:46 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 09:10:46 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, Francesco
 Dolcini <francesco.dolcini@toradex.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: RE: [PATCH v1] imx: Fix critical thermal threshold
Thread-Topic: [PATCH v1] imx: Fix critical thermal threshold
Thread-Index: AQHbNSvyid4TMPRFj0OUXUIRLt4zCLK0rtVggAA1poCAAAgO0A==
Date: Wed, 13 Nov 2024 09:10:46 +0000
Message-ID: <PAXPR04MB84592EF185F8F80089BB6796885A2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241112175427.83979-1-francesco@dolcini.it>
 <PAXPR04MB845982FC3C40774BAB0CA92A885A2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <ZzRlhaxjr96CqX8b@gaggiata.pivistrello.it>
In-Reply-To: <ZzRlhaxjr96CqX8b@gaggiata.pivistrello.it>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PAXPR04MB9326:EE_
x-ms-office365-filtering-correlation-id: b33af8bf-3503-4876-4f44-08dd03c30f1c
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ejAybqHj0TZA8NBmO2QpBfyzdXXhA5vmH8l4+l4j4EdGf0pt1kO2hgH3tvl6?=
 =?us-ascii?Q?1MbMKoK+iDcvF3fXPV2sQ1qzPWyP73XIzRbycUWYNQo4MiS4h21lNYInVJu/?=
 =?us-ascii?Q?YQE2irYWJNij6xPzyCCHdnZD90vqNyfC9dqqjIXFHWGvMOL68jZY6ySBU83S?=
 =?us-ascii?Q?UqbyKH9rOWokPs0yy/Kn0bf+0/vUcpmRnb2uEB8lc17XEXu3qQbixU05i8p9?=
 =?us-ascii?Q?CjWHApBYHPO0XiXKhnnIvjh2cmoKnm2b4EwV86iyrTYEGzg5BM4PG0iTsR+N?=
 =?us-ascii?Q?e1vbWGEyVCGCmJOMg2+uJqgnvp8M4LBBilwDemZ5lWhtFK8jCKm6xpEcPbBH?=
 =?us-ascii?Q?3sSGcPzwYeFvkA9XtfT3JReq3Yy+oYBMyDamQOeZ4fuD9SYaV40K6cIR5you?=
 =?us-ascii?Q?MDpurLW1wP8JKHFBke9WvL2vKO2iskBlNBojyPkwucuX4F/aS1nktfo315nI?=
 =?us-ascii?Q?TRDvwQY+N0gjzL6F0B6K8sPR5cJ74rjJOYX14sLwu8uuyCms8Dp5J5OVUJeu?=
 =?us-ascii?Q?AyVB8QyOAbsgtBdHL7Swox51Tm8C0AM1NyoV6V0RppI75k2nwW3xgVSSKHf9?=
 =?us-ascii?Q?WkV2Y5hVlg2TpNsobGN5Eij+ul+Qr4SdxytoQeGHv3Dmltx3RljWcUB+8eK4?=
 =?us-ascii?Q?FBkNaFKJVjDpJI3ZyxXzxzoWw4f+99PxUtJveire2KUj+/qVLCAAooFBC312?=
 =?us-ascii?Q?cOYNIQlLps1roALcoJH8QbEdUrudaBxWm9qSMEk+zID9DPsAefO0CE0t+u85?=
 =?us-ascii?Q?Bvvo2x8o8aJfpsMIHosXiFfo6YzPkfLa1EVfE4eIEpFI4MF1m/VbybJ6KEgo?=
 =?us-ascii?Q?9Be6vT7GlpvWzJ4WaFfQrBq7SxYx21Uz1vTVyepPytyBFcyScLsZ9i4aSNq7?=
 =?us-ascii?Q?ikACubMP5q7wdWCJ9Mw2Wklvcjes5hRPAVia3aAnrNpm/fGjVHqXEUpyNAgj?=
 =?us-ascii?Q?XE0a5oZoniEV58LAvXP57Uhzd9OCi9+RFwK/pn/uZXfiJDcwXjFt7TVSGsD/?=
 =?us-ascii?Q?ZcJhyDgvsyURHWQOxt2UAbLkcsgFXJm3Qdyd4QN56F8hotlN7LyeAbsc1cjz?=
 =?us-ascii?Q?s7puvaKBWD7Q5rCCM22oMaxEMbqFiRcFkuAhjetZGlv603kcD/h9ttSnGGF9?=
 =?us-ascii?Q?NPeoFOADPsHYs0eRHrHPBViP6NOsSUrQSf2FvSZXkw1wD0vpwEVeJ/ybXLAa?=
 =?us-ascii?Q?QcBUPswM1PYIA3PkpRFIHkHun4kRIFtNF5T4agBWsOlV60O5JL8gV/U45Npt?=
 =?us-ascii?Q?2U6GUd7ukh767DwhNyaLuTJYm/ozCsxBGC8u7mv43dG/0Lbq7UQtUDLMaFtq?=
 =?us-ascii?Q?kX320B77opHGa4xu0Pnz7lyS59o2L+naFE+yTF4weuHtm5DYDcVyOITPqJ2c?=
 =?us-ascii?Q?rZDV6l0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?I4CVIaohfn+QpH9ktFEVySri9byDsqSxtCIQNwj+G1X3ucbf6sEMOcwOWzsY?=
 =?us-ascii?Q?EbQJYXvOYAE2kww5y6NwIpB2FLsSUjeBPhXui7Aln0Xvhw/Bb+YyTtpXuWie?=
 =?us-ascii?Q?B/V/1ADnS/K1Azu8GDoYdY10HaUD1izKN6RiHcGJ/KrYFbRWJ5b7ilX3P6tv?=
 =?us-ascii?Q?NB98g6EPmnm/OnPM4nQVq5bQeMdzDbaIuH4yzTUAq93r6IZo1MFue3rqEmRR?=
 =?us-ascii?Q?8ZSe+VbeflZpKOX7UNjH35TK61HmgkczcOzMr5iFINCOeMah7z8o57LQeuzW?=
 =?us-ascii?Q?Fm8aj9LjD7DyXrNloXhontW7i0CUxWy8H+g3y8fjLLnA0DvqIQ3y2xgXw/Sk?=
 =?us-ascii?Q?60ATTv8CoTTjis7Wxq/rKLt8ntzCdbsdxnW+zXNdT+stHBi+rAZwcKqgQwZS?=
 =?us-ascii?Q?kClQQg3QGLaxPSRQrom6YM7vT65WnckKhmS+vBupK2ZH6g2zkIhLZBYBAWWF?=
 =?us-ascii?Q?1ymPIXI2r7iTUY+ShUBFTNEmsMq/iHttMujWhAPNh3gpsOVzMChwQR3oT3KH?=
 =?us-ascii?Q?he+11qWzfzbR7hv2RPLSJNl6xMB5YzgQh+/9fqTqJkLbeYiK3Vk0gVSqwIOU?=
 =?us-ascii?Q?sGQOHIXuS2VLoG0QR3QxV9lvuh5eHhZve8HHe6kmiZatjLQvKD3KCyDeDMIx?=
 =?us-ascii?Q?aEdFQEwkjWIxKL4jlkFEj4pfpsZxGdd4+aGrj37pxpVRQaFtCI8fcfP4L7cz?=
 =?us-ascii?Q?asWHs0lH5rGTu7AyhiQU7er3ibGG8Rtn/mFufxQ8/9f7ekHnEot0OZaz7+Dm?=
 =?us-ascii?Q?HtyBsSOswln79zg9VoXb6CluyH0xzWT6OUuqaogw+O6fSgnjRRzM6+SVTMEY?=
 =?us-ascii?Q?1MOHdivXY05AIJN0t5a08pxEhF8KaT+XmrVb3jzgQEOfAN6RTdAZZl//S95d?=
 =?us-ascii?Q?m7iG4AXVyLd6a+qoObJOunzlv8irluF3ru6UkGJl6UnoVpSeo9KcwQTbLEdn?=
 =?us-ascii?Q?SBlvlA2l5xrKavBVo7W7WGYzseMAQXfGj76ugqnD/zMjPdloD06UW2x4ET0k?=
 =?us-ascii?Q?HG/U6lKTHC6iiO00563TFHNf+z+AkxB6cpSw4J2POhRmWyY2tP7hqV0UBcXG?=
 =?us-ascii?Q?s3i58FHug8IFRFqUQI4aU13fI9+3X1IQ1wtx0jm/QlZ36dbBFOjtgZ3RNgX7?=
 =?us-ascii?Q?IGuKb/czi0dR/lO0J14PrypSLT+YZYKgKoABBFbQhphCrhGSQv92xzPZjjkp?=
 =?us-ascii?Q?yvSwj3g9vokDG9jONL9EI46wdIg2hrfiFEC0S500rnOqVvZHDL5+naqjbLYp?=
 =?us-ascii?Q?Ow6Bws3PvGofb7STN549fIfb0wZJZmuL5WBl9ZCl8wS7k3nFUSZYlXlAY9xC?=
 =?us-ascii?Q?BmCe4346GoOzxtEDPe6gsmmusyQ11jscNNKZ1MvsAQ1KPSbOS+h5wjweR+bT?=
 =?us-ascii?Q?ci04cL6QQYMSQvvNYanHM610lMCbrFEEu+dYR17k//vZU9OPhU+30LnyezXf?=
 =?us-ascii?Q?x7XI0zHa0TWDfnSmI9o5Du/T1jGiJw9b8zLD2FfRi80P63DR1WURFgrQDAMg?=
 =?us-ascii?Q?+yv8q2c6lOvddWUIurm1Q9FxEmnYe5AgSAXNdggpogDSTHoXR4pCL51YtGWE?=
 =?us-ascii?Q?szQuSn2nFQGt0LubX0Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b33af8bf-3503-4876-4f44-08dd03c30f1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 09:10:46.3300 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 75WBxolA7Yd5z6kT06gO6Tt/z+2//qeN9AQ8rs1E162EdhH3kNTTmVTEbR87gGZtbw/yy1MSr3p2x7+MmTgCJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9326
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

> Subject: Re: [PATCH v1] imx: Fix critical thermal threshold
>=20
> Hello Peng,
>=20
> On Wed, Nov 13, 2024 at 05:27:23AM +0000, Peng Fan wrote:
> > > Subject: [PATCH v1] imx: Fix critical thermal threshold
> > >
> > > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > >
> > > Fix the critical thermal threshold for i.MX processors, this was
> > > changed while moving the code from imx8m/imx9 directories into
> a
> > > shared place.
> > >
> > > There is no need to keep the critical threshold 5 degrees less than
> > > the SoC maximum temperature threshold, what is actually going to
> > > happen in practice is that we are going to power-off the board
> when
> > > the SoC is still within its working temperature range.
> >
> > Should we leave some margin for the critical temperature?
>=20
> What's the point of such a margin? For doing what?
>=20
> What is happening is that the OS takes some drastic measure when the
> critical threshold is reached, for example rebooting or shutting down
> the system. Why would I want to deliberately remove 5 Celsius degrees
> of valid working temperature range from my SoC?

The maxc means the maximum temperature that the soc might run at.
If the current temperature >=3D maxc, the chip might be broken.
And temperature sensor may have some deviation.
So leave margin for SW to shutdown the system.=20

Regards,
Peng.
>=20
> Eventually, assuming such a use case would exist, it must be made
> configurable.
> The change you implemented is just creating a regression for existing
> users (this is the reason I noticed, it broke our device functionality).
>=20
> Francesco

