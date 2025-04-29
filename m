Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C480CC369CB
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 04:26:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74973803CC;
	Tue, 29 Apr 2025 06:26:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="CjIdE+Ay";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 421F982153; Tue, 29 Apr 2025 03:19:16 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::620])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BB5682132
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 03:19:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wei.fang@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TSB8UNwDv1gz5KCmnacTrDrkp/Do+zkgH2rgphnUbnyn4Vuegw3lvs0ySogJucQTi63yO6mRnEPOAef6im56wjiNqQfJOxchXboOiFh0hd7uXXwbv91lNDKCDUYGuAvtcSziYThcbwlKDzvoZFiaOZveJtDSQ+WgrEIlViA0RJ4VMewcU9GgULh+usBn7oZapXku4XiOalrYhEHMc2ZfEiUPz8FHWyRpIOyV1KKGH+EhQfYLG+mYARMrwOgAQ3x8V/JxuFIRypuFTH0pq/UHwKuk6SH5qTh1YsmksfUP5y7VWJP2W3rGulO/6sroFG0RmSjRNTwVsA3VWD+Uue00ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UWhOk95V2XkjTS0isXSRYubSO/iTTQwalWN5/c4wOc=;
 b=aeKRkKeO6hymDI+CFQOwMajjk9ljsyZQOGfPPte8u7q6B0z8ZIB5BdZcbgZTYEd5y5Pc2VX6SLyKxRCxQ9o4qrbLqwZNY7hDJUDN83RxJdFbWWwP0IdL3dSY+YLCeTKiTtrOGiF8JpQPA3aRPCQO94+fjXAlpIkTTCES6WvOvsL7nImdnqg5BR4Cdzj8vNx7jJ0M41umb/HhFkkfHfvTCM1FUEb19N3m8V8TSwpu3w/f+Kt61qM8C+lWbSI+2AHKr6c6Ip5dzetOnafp32YBnSsneQJvhs8m14BCHT4LKrcMv6ZMfXfVHn9S+MFXlMw2UEjeDWQIQvi2R9fG1Q8Hug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UWhOk95V2XkjTS0isXSRYubSO/iTTQwalWN5/c4wOc=;
 b=CjIdE+AyD3PDo2nPKGT1nJFLifGWGowLU+7NACq2Q5VI4QEFuhJA43R6mTxO96Owu6dPr38hr98JKJX15hzhIXKvZH0sEVLVzaweJdpdfkAvfWVUAd9NyjRdMP2k9s+UzU9kR4KYyTE3XsdFaam7+hWvc5IhhuqkkAte1vgMfBnC2mjZoH7rUE37OXWFTSGXlRsXI9UHmmqMANlBks9oGVnknj/rvHCstlEmXHgMQaTktFGWH4XilbahvJDltWxFYrCdJEJxm+x3ijkkpEHXR76nqwtL6TeXved/gJRMyOWWNAmP8NRTgq53GcA0DbXVumZU8vUqpyBBM+R/h7Gn9w==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8884.eurprd04.prod.outlook.com (2603:10a6:20b:42f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Tue, 29 Apr
 2025 01:19:11 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.8678.025; Tue, 29 Apr 2025
 01:19:11 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, Michael Walle
 <mwalle@kernel.org>, Alice Guo <alice.guo@nxp.com>
CC: Heiko Thiery <heiko.thiery@gmail.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, Marek Vasut
 <marex@denx.de>, Ye Li <ye.li@nxp.com>, "tharvey@gateworks.com"
 <tharvey@gateworks.com>, =?iso-8859-1?Q?Thomas_Sch=E4fer?=
 <thomas.schaefer@kontron.com>
Subject: RE: [PATCH] net: fsl_enetc: fix imdio register calculation
Thread-Topic: [PATCH] net: fsl_enetc: fix imdio register calculation
Thread-Index: AQHbuEkYAUQdztOMS069eZJnG1If1LO52I+g
Date: Tue, 29 Apr 2025 01:19:11 +0000
Message-ID: <PAXPR04MB85100048CC9987A31C4B578A88802@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250428095945.1432389-1-heiko.thiery@gmail.com>
 <D9I6S5PD32TJ.3AGU7UM3EUOF6@kernel.org>
 <20250428142316.geminnotbfmbkpxs@skbuf>
In-Reply-To: <20250428142316.geminnotbfmbkpxs@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS8PR04MB8884:EE_
x-ms-office365-filtering-correlation-id: a08cca3c-75d0-4152-4b79-08dd86bbd91b
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|13003099007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?19+kzOBnIGvnJI71mqSIVCuMK0VcSLrSRZt+WJ2vjZ+uEOUrlzDNZ2Kdgf?=
 =?iso-8859-1?Q?mKOz3tcgxm3fIGSYvOr0otKGPU8pOwEg6IcHospHujprsn//+pv/u296BL?=
 =?iso-8859-1?Q?F1RPU/0TrAZbRS/1t2JB7yxtH417/hht0imzMpCkXmGoarEB99Gx2aba2w?=
 =?iso-8859-1?Q?GKxkgspbGi82K2VvEcYCBvDORODDddpihPk5lOMYfywL9mHEtXSwrtiqxn?=
 =?iso-8859-1?Q?3cVY/hT7gQEIICOGnJtDyocRXFEALdtPjf/ozp8QzncBqj+cm6K2uJNmj4?=
 =?iso-8859-1?Q?HWFlMeOOlaxRkde4W1umJzdGuJR5+2cKmouijwB3+dXyCGIhG7/En1vNIr?=
 =?iso-8859-1?Q?2Qv3Vi1G1UXX0L/vPQ0L9xE+YemgapY3z4Lo3FaeMq4qsIZxSXX9Dar95Z?=
 =?iso-8859-1?Q?4Uo1nQNXRO5CYzMAIeXkPoHQ2L0zeaLFD2if3CAbtDUj9gRjZVhing70A/?=
 =?iso-8859-1?Q?CuSp0iRT3eRHq0+cpxVrX50H+gVwE6+9mVOy3aVFbFvEZiJGcCTe4WGWRT?=
 =?iso-8859-1?Q?RZQKQFNX0R3BN5VfPRKZrtH/BW0ISrsh/VsaF1UImppnWKpUzj9NCtjoIC?=
 =?iso-8859-1?Q?z7x82kYIDTEzurcSsO1FK6aejjc6pfSaV7AuAJQWzEgAW5gTeqstZHS+Ku?=
 =?iso-8859-1?Q?SkrLWBZ0/PI72+l1lfA6m1ft4uqFbkV+ZLz3enMMCdE227VBz53wBwChPh?=
 =?iso-8859-1?Q?gFmeeFwHyzk4iMj0RyMNLk17qNnT4Osp5SGlodI60NJikZMfNRdNR/80hO?=
 =?iso-8859-1?Q?98VEXiDGCLcgcBYVTamVDn+QtqYuclJCIW+RfsWmcAoJ0btmX0A/qE2h+X?=
 =?iso-8859-1?Q?WXoo89c/WlL3tlyTSNYjWtBNr+O7CKcYSZ/5fq0UDNx331/ah0tYP1CaZc?=
 =?iso-8859-1?Q?WuA8QFSjBcZn6gKM/pG0sB9QhXLiZmXTq11vf5XSsKjEx/F6Z5EHK5W+EU?=
 =?iso-8859-1?Q?lHmQ56MWkvAo/vu+tSvVdJeg/W6/qXSy2CyKzf/G3arj4ZBNRXLRDbk5Lp?=
 =?iso-8859-1?Q?ELbYple093ePYmoK13K8F2iJn7g8fO0TeTN+7/G7GRTTLKQLhh7zDm13eU?=
 =?iso-8859-1?Q?6WoR8F/sonf9WfqkJjTuDg8f/jaI18xgGx3UN9hLpp73ZMgOfzImTfNGqn?=
 =?iso-8859-1?Q?XagOudYZFkzxBrmOmxf/s+oh9QOv7St2dhEXuE2QK+XjnPy2kMF04P4QKG?=
 =?iso-8859-1?Q?0McUaCQBtbus27J9TY02cQfjR8qWFrF8WNKOCs+rnH2jxcgdPc486+PwaE?=
 =?iso-8859-1?Q?BPfE+fPCcZ3X8953z3+GdniQ/dKWfQDG40MjGUQdoToJNjK04Ogzqh1BCZ?=
 =?iso-8859-1?Q?XwLVe4sqAazqTXAixwPdh3iy5XxeExmBcOfT8VgCngU6BVlkaqVdvLkAfx?=
 =?iso-8859-1?Q?BZEhkMtk+LZrsluGXR0pF8kLzUHHwpAst4AuBPxhio5byPAEnALpOECzJO?=
 =?iso-8859-1?Q?5rUSSMaYvSWTgdIwd4flQKaZarhiVR4DfB/attKCYyOpc7LWDAGzUNk2Q4?=
 =?iso-8859-1?Q?A4S2Z64cvTkU1pR3/fO3G5W4s7eRVw4d42WuJMTao3rp9vzo5O9G6Sb6Vo?=
 =?iso-8859-1?Q?Lpdlm8E=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8510.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(13003099007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Afcv3WN3sYu3hQUHiaD6iGsu/CHWdYy/iXdTgeYOx2CxGCfZwJ1VDPQ2HG?=
 =?iso-8859-1?Q?OZudnRrbp9DUu36XjovLwtALVYQTYuwEUMsm/9hF2YSUGiOZQC6hAGfKUR?=
 =?iso-8859-1?Q?5kInZUU2lT9IW0Hzu/n2hYzB/iHt4OTRXY05b25VzM2cE93jN9FxMpK8AJ?=
 =?iso-8859-1?Q?tC6Jpkny6PqqBDXGGxuCdUuXOI4XgqV/R82KZ+45LIfTm8Mgv5kuLZXU6x?=
 =?iso-8859-1?Q?GGl9jDXHceg3/VARfZdxgmbruLm2Sp0KTEnezNkXTjpvM2qQLtBUxwhAek?=
 =?iso-8859-1?Q?jWHhBJPNWtqo1BTq7lO/CL8mtMeKWzJJMYvb/b//rhUMTPEiwNRXfzpXTp?=
 =?iso-8859-1?Q?b0TUbEci31yNyxm9xRqW4756VXTVHybyndxJ4s4MxgcF1fJLM55QSz5yo5?=
 =?iso-8859-1?Q?4RPgO9lgRQn4JqgpPakA9S2jxcRIKvquqTxNMWmGkOzvPydHgkfg7zSZTV?=
 =?iso-8859-1?Q?CXZAPkB71rHmKGOmjeYIoU3EHtjq49s7gNiQ5FWJYKfAHeJWdmkOd7tRAR?=
 =?iso-8859-1?Q?031ztctR1XRxlERdDoD3Sx6oZpH3XEfpfNb3Z/V/ZhUNzyQ9tcx8Yqri76?=
 =?iso-8859-1?Q?d8fsSGjZvU/hMRV6W6Kv7VdArS+44iTPZEzaML0lG/XwPH1oNF/zzrsRFb?=
 =?iso-8859-1?Q?cuJf9f7jsFo4mTd44zqsVlQ889Lvex6uiC9SEGpa5QGtGuHoz/PtRyiJMl?=
 =?iso-8859-1?Q?1NU/nedEP//Zeu0ouDXlbk9U/jcZKkFyNBDR+GdPHzM/lIZJF1duuqozhZ?=
 =?iso-8859-1?Q?euQ4BwgKdtpp48N0u+D4WWEtX+dfTodRtuHlYeSQ0wyar0vD1EQ7Tifnug?=
 =?iso-8859-1?Q?RT30JsfMq9UYUWWID2Za4C+smP64GDXkHH5J4CuwSanpK/Li0TaEWN1Uol?=
 =?iso-8859-1?Q?rCt/aQwcIwf53C2sWq5/zAexTAU089gaOuUFZFEf9TFjNFDNJk1p84tNJb?=
 =?iso-8859-1?Q?4keFQxP5amKLXQsghgA/aTFDEj3N22uaquRr9rw0kHg26dzrU1AxfZsWw9?=
 =?iso-8859-1?Q?IglBLC2mbhmBrJ1zQHwSltWUcot8mfU2wE3x1ytrGzs1hHEB0Ao2L8OT/U?=
 =?iso-8859-1?Q?xsuWePDM0tAVTUyKL9AetFNXWQzr+oJAtfn904cZGKMJDgel0C+jJZ3YGh?=
 =?iso-8859-1?Q?oOjPrD948YB9LAjn57nkZylI8lofe3J0xRnP0LORZ1nhozRZ0zLIgAsFqK?=
 =?iso-8859-1?Q?Aug7g2og60ARCiIU8Ay8WMQ9gT7UrRmi2w52YZ7s/MPO6Eh47+JX03YFSi?=
 =?iso-8859-1?Q?QEvsu0rLqnKFwxvfjrR3S7R1LS5LJXhiDCLxH4tKyMc0cR21EugIRzU2y4?=
 =?iso-8859-1?Q?2yB/wVNM9rRsiDFDrfFEBOStNIta7LEYxMBqiWxRjCvvWDDse1HMqNYUm5?=
 =?iso-8859-1?Q?pvIhCXUUuaD3+98oGeclGUDCPkzN0PXMclYe+Fm9v1syivvZ4pzgng0Sdg?=
 =?iso-8859-1?Q?ZAB99dfeCyTW5wfFtoFHoOw9J2ljADF9wdqS8vlvXpCi27DnCJSJb2nXSA?=
 =?iso-8859-1?Q?04y9kz/mlCtrbz9DpVwqL3dEgNKLhtiRm3LpibIobnJnL690DlbTZoPan3?=
 =?iso-8859-1?Q?Ya2Iy6FWJHm6RXG0mXZ2xSNoE3pxQ0+L+IdhkyjhteLiMTOx1an2S6P79B?=
 =?iso-8859-1?Q?QKOMEpU6WVOqQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a08cca3c-75d0-4152-4b79-08dd86bbd91b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 01:19:11.5857 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +OH0Ap9UeTFMEG7WgThq7zwA/JXjxY3AaIMrpGyKVPCfE4nwKSvs3aOBfO6WRuwMz2fDfqzndtHB7jJMS4ywCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8884
X-Mailman-Approved-At: Tue, 29 Apr 2025 06:26:35 +0200
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

> > > With commit cc4e8af2c552, fsl_enetc register accessors have been
> > > split to
> >
> > With 'commit cc4e8af2c552 ("net: fsl_enetc: Split register accessors")'
> >
> > > handle different register offsets on different SoCs. However, for
> > > internal MDIO register calculation, only ENETC_PM_IMDIO_BASE was
> > > fixed without adding the SoC specific MAC register offset.
> > >
> > > As a result, the network support for the Kontron SMARC-sAL28 and
> > > probably other boards based on the LS1028A CPU is broken.
> > >
> > > Add the SoC specific MAC register offset to calculation of
> > > imdio.priv to fix this.
> > >
> > > Fixes: cc4e8af2c552 ("net: fsl_enetc: Split register accessors")
> > > Signed-off-by: Thomas Schaefer <thomas.schaefer@kontron.com>
> > > Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
> >
> > With the nitpick above:
> >
> > Reviewed-by: Michael Walle <mwalle@kernel.org>
> >
> > > ---
> > >
> > > But the question that now arises is, does this code path work on the
> > > imx SoCs as well. Now the imx specific offset 0x5000 is added here
> > > and was not used before.
> >
> > Maybe the imx9 doesn't use the internal MDIO controller or the board
> > which was this tested on doesn't use the PCS?
> >
> > -michael
>=20
> The imx specific offset 0x5000 should be correct.
>=20
> In downstream, the ENETC_PM_IMDIO_BASE macro is used in common code, but
> defined twice - there is a conditional include of either fsl_enetc.h, or =
fsl_enetc4.h,
> depending on whether CONFIG_ARCH_IMX9 is defined. Thus,
> ENETC_PM_IMDIO_BASE is replaced either with 0x8030 or 0x5030 in
> downstream.
> https://github.com/nxp-qoriq/u-boot/blob/lf-6.12.3-1.0.0/drivers/net/fsl_=
enetc.
> c#L25
> https://github.com/nxp-qoriq/u-boot/blob/lf-6.12.3-1.0.0/drivers/net/fsl_=
enetc.
> h#L76
> https://github.com/nxp-qoriq/u-boot/blob/lf-6.12.3-1.0.0/drivers/net/fsl_=
enetc
> 4.h#L126
>=20
> I guess Marek fell into the pitfall when upstreaming.
>=20
> > > Can someone please test this on an imx9 and confirm?
> > >
> > >  drivers/net/fsl_enetc.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/fsl_enetc.c b/drivers/net/fsl_enetc.c index
> > > 52fa820f51..97cccda451 100644
> > > --- a/drivers/net/fsl_enetc.c
> > > +++ b/drivers/net/fsl_enetc.c
> > > @@ -473,13 +473,15 @@ static int enetc_init_sxgmii(struct udevice
> > > *dev)
> > >  /* Apply protocol specific configuration to MAC, serdes as needed
> > > */  static void enetc_start_pcs(struct udevice *dev)  {
> > > +	struct enetc_data *data =3D (struct enetc_data
> > > +*)dev_get_driver_data(dev);
> > >  	struct enetc_priv *priv =3D dev_get_priv(dev);
> > >
> > >  	/* register internal MDIO for debug purposes */
> > >  	if (enetc_read_pcapr_mdio(dev)) {
> > >  		priv->imdio.read =3D enetc_mdio_read;
> > >  		priv->imdio.write =3D enetc_mdio_write;
> > > -		priv->imdio.priv =3D priv->port_regs + ENETC_PM_IMDIO_BASE;
> > > +		priv->imdio.priv =3D priv->port_regs + data->reg_offset_mac +
> > > +		                   ENETC_PM_IMDIO_BASE;
> > >  		strlcpy(priv->imdio.name, dev->name, MDIO_NAME_LEN);
> > >  		if (!miiphy_get_dev_by_name(priv->imdio.name))
> > >  			mdio_register(&priv->imdio);
> >
>=20
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com> # LS1028A
>=20
> +Fang Wei to confirm/test for i.MX95.

Hi Alice,

Can you help check this patch on i.MX95?

