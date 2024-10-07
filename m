Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B98CFB440
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 11:46:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07E43889AA;
	Mon,  7 Oct 2024 13:46:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="eFohzRg9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3033D87D1A; Mon,  7 Oct 2024 13:46:07 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::618])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 410AE88AB9
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 13:46:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R3rfopRz6A0qQapluA3CC37zC62cdK48ELDsRzi01YW5QjrW3AtaBKR9UheoRekgRUHwn8Wj17Eot/1iWVtwhdVf/nYxWDFuIKn4P3dGRhY/th3Dj/32BwVW7IkdVJBxWYqwvYA/vCjgQFZr5BkzGQNE1VQX/AiSuoV6KW0SwcfKFhIL9+X9i3jj+cvrKH4hwrTDH0i9880ZeKhYdW4Xkca+yHmI4cBjUBGQwfvsj61hV9iNMv7+FcUBAUs4miiop9slZlpy9uWuKJbQmgX19jtj6+fnFy1maxJBeOd3rZxqfcKm0+BWSKEI6JIWYZWpOs9V3dhBidAPIw0f7WMZKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kz+CdsQ/oQZlh0ezEV1oLRal3dVupmGT4DV0uekZX/k=;
 b=wWEe4eU++nrc8ztSqoLhyWYYfPsJ+YSMbJWIGJL3mFT7DB/7gSbyl5ockqMNDHix6F3yMei+8bBzhf80VsaeVtNUMVnwhKKVbu9cwzHUQZSGPFdspGMqkhxEprBYWrv5dnNxG1OKogABoJO3eKTgtMOMAHABrjW1U1EekiAiNqCGtyvSnk/LULLSfitsQo7vV8psm4bBlUZZsV+BbSM+TkuG8SvHwjLHBvehZcO0g17owy8eIdNBTqUZlHKPCS/Ih1knY+1bLYROFn+x+BI9Sy58PHwvnUhyZWzRKEcEyVmQ18mQyb/s7WUZ4L/Yn8KwF4oHtF4sHLaeQ+BRNd1wtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kz+CdsQ/oQZlh0ezEV1oLRal3dVupmGT4DV0uekZX/k=;
 b=eFohzRg9/znHYmcmRMXgZaibj57zeShy6sXj/+cl5lm50PLPecRy+XPYoeHh0w7ZtwXuWenzzxjqTitP8ba9sWriyIlJrefFMeAYsys7MMbHNtuKnq/b7U1Enm/epphjjBesKwLGLFVjum49YyeXXLOHFmkIX/+i5cPTlXDoMM+md6b1vtVVQRmrEZwjFZmXoF5AE1Mfg7PEeemke8QQPqm7nwV2xlXt0HpOHn3VuTFvMnOMDIQfrJnK1uceMgMjdA03xf57NEOhI3sZRjD5vDKqpm8FQ8dln3qRTpgeviCvndkFBUxZzwz6UPXlZtGy7gBO31R2xdH5w6m95lXlvg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS5PR04MB9970.eurprd04.prod.outlook.com (2603:10a6:20b:67e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 11:46:03 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 11:46:03 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
CC: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "sbabic@denx.de" <sbabic@denx.de>,
 "festevam@gmail.com" <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>,
 "Ross, Fedor" <fedor.ross@ifm.com>, Ye Li <ye.li@nxp.com>,
 "seanga2@gmail.com" <seanga2@gmail.com>, Alice Guo <alice.guo@nxp.com>
Subject: RE: [PATCH v1] imx: Kconfig: make IMX8_ROMAPI configurable
Thread-Topic: [PATCH v1] imx: Kconfig: make IMX8_ROMAPI configurable
Thread-Index: AQHbF37kzuMw1Gz0EUuu/Vr5DDF+e7J6PP8AgAASNwCAAAYXAIAA2ENg
Date: Mon, 7 Oct 2024 11:46:03 +0000
Message-ID: <PAXPR04MB8459A51F5CCFC565F8E395FF887D2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241005233116.2781053-1-alice.guo@oss.nxp.com>
 <20241006212332.GQ4737@bill-the-cat>
 <f2f2ff63-e186-4065-8e75-7e0064d16037@denx.de>
 <20241006225032.GS4737@bill-the-cat>
In-Reply-To: <20241006225032.GS4737@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS5PR04MB9970:EE_
x-ms-office365-filtering-correlation-id: a1e0583a-c655-4cd7-66c5-08dce6c59f4e
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ISuvAN8547vI4Ci1BmHrr13gzftGLqnUq1x6m9v1EY3G+07madBrLCO45xQq?=
 =?us-ascii?Q?ATTIy1+dA6DJXrsK+0L48LI3DRn8khNZ3ZEtsCfi3wfkLGMpBZBdEeLlMCLh?=
 =?us-ascii?Q?FygBxkpQt0DTJNknD3E3s8cs/DO5e5D+JR5pkwcghSX0+A07AecedG23M87O?=
 =?us-ascii?Q?nPz6vU3aW13+Udf69mv5MOQvQxqtvjneSpMmWkaRm/3mMN6P8XnBy2qhaRRc?=
 =?us-ascii?Q?KDnzduGv2IAR01voBWxShhOfWsIXkRGmko2NqTpKUzSIZtcTKsOg2ULNAc8X?=
 =?us-ascii?Q?diOjluYfCbunoX7IXU2XGhPdKNCS5q5Vxk7XtxGfUJkKTF9R0DsBsaukEous?=
 =?us-ascii?Q?+NbgaILlhzf5/0PR8/UveQ72kqaC6t0w7mo54Q//Rf3iMH5MuFkJ/SdlCmAx?=
 =?us-ascii?Q?PqZMM0eGugvTEXrL4vFwneWQWfdlrdaFbcvCQsXPNCRKV0LRiUjiDrLk4sI+?=
 =?us-ascii?Q?mvTTpppuaH8VxigcHFV3HjMtp6OA4WxNDuQcfUt7dzL095mktltUjeg1DJ6z?=
 =?us-ascii?Q?NAYO5K2laKjtIcLTmzFJQ+J2FLpr+dhphdo8+9zWWH2HTmuLRRAPlenpM36Z?=
 =?us-ascii?Q?FCU+9g5XAa1uKmEDde+5m9WP430SsSHUabqiDnUDmkeVeV0eUJUNfAqGygvR?=
 =?us-ascii?Q?Pp5CXjL3qaZj9KUDZ0uNYemUIym7Ra19qpAB4gKJHRmyOTWGEmIjO4RM+FbT?=
 =?us-ascii?Q?MP8zJzMfMFgqNJuWiBHF0oV2hs/MuXiRPL1IKrsNcGpZ5ZcBatgF+shD80lW?=
 =?us-ascii?Q?PYltEShq2uQam4ZBvPRceY2LtZhfXdbJUdvn1rT7EhQI9A0T0cjLhlYow5za?=
 =?us-ascii?Q?fBGYjDvUee90TheFPN6vVRC7IwniOEft7t5tIIbrLbuABhn0OVsyD3o2ufaO?=
 =?us-ascii?Q?+vtngTwl5rj2nTEMiYdl+B+i85LI3VC+hJws/dPAAqwfXSiC3UglSAmwP4Ah?=
 =?us-ascii?Q?BUPflsPvyhS7Yd7ytiJUVWoZg7v70sGlmxSz1/R02o0ppC4IqBZu1sLu+YHv?=
 =?us-ascii?Q?rHtXG2+QKJxaLKz3bEK20A4jQYNcYJsD0bYKS0W2+LmfUr0uAzgTKUidiexl?=
 =?us-ascii?Q?PlmdtRZXzub9lkbqSlEj5pTbOrsqBbSIAmbSuE0F+ABiROJr7NnYg93obv0Y?=
 =?us-ascii?Q?3tAyVjoNdfQI7PbpPxWuSQX1OItx/g/LcoLkJojQTZ3TR7hVxADcapWKxgEI?=
 =?us-ascii?Q?Naoxchg4zNooBnlDy2DukdoIe/azK1WFPwmlYAnApYc8ldBAm+465g2qr6dJ?=
 =?us-ascii?Q?yWcQZmUuLnJpLXW/3/J8qXMKAu/aoOuwlxGxHVqm/SddS6Cr9Wmn1NJaGn0t?=
 =?us-ascii?Q?fjwBBG3Rirgagdo8yph/AIjXfxogwhgJDFAldj64iAz23Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AnwLTSootH51hD6njLf9fdc3FJBlL//sL79WjDV9cl2PnPGQvQmEN3BVe2xw?=
 =?us-ascii?Q?ZgDLuvWael875SD581Faa9xruktOMAOrArn0YKxithhv76k+fSBie+T6OpQD?=
 =?us-ascii?Q?68VtvjAB0kz5Jvd7+LmeEbZ2PMTdIUyLuqEVd5SeKim+7/rjmmuy3Xe5V+fw?=
 =?us-ascii?Q?JG0qjVqV3O2mM/Z61HNtAvZEEsuDE9+mg25Akptzp4fshEheKIZoVoQrmRji?=
 =?us-ascii?Q?8LmfLCagLLuDJaY0wcYs0rObDNOZG3sOzG+PJP/jaXvynRZOCYMVi/s2qQFb?=
 =?us-ascii?Q?WldOyqC6xMXFkBRsCwwKeQBFRxwL1lvVWxSx3rmjozFhlFm6gYPEkiBLW0LP?=
 =?us-ascii?Q?bVOX0lzvf9r39ZWNuRDENZdsueqPoo2A3QbQUJvp4zvUhk37iHrouvWasP0/?=
 =?us-ascii?Q?3cwU/RXFqOOWa4zKvbkVSb2yDuzNMlAgSGgGDcpQbJNx9BYM2cvzSpW20ltF?=
 =?us-ascii?Q?rmOS1mx1XmjyUhKahzcpjQPgXxA4uh7apwE7QulbCWXdIcj3kzhPhK5xQYIE?=
 =?us-ascii?Q?jAoD6CFt72/NhzTNjwhzCEp05KYgXMK37m2Pt6MbqCIi0kixpagu7wt+hv28?=
 =?us-ascii?Q?/iuhB5SoVGhnm3wa1a2lj0Che0UqQF6tKMM5+/fySVgML6da4MCflhXo6v30?=
 =?us-ascii?Q?iH23TijwrYrs4v83RfSpURAvFZZqvB+cN5hizVt4hW9sfBzM6Uq8sRfi3Zx3?=
 =?us-ascii?Q?DLlTrNua2b8h3RYzzJ9zhLLRl1lbGBQ09z1J9EkDmPKuL3zyu9sdylw/nJVN?=
 =?us-ascii?Q?c3hhyYH5ii1KR9xQp+4RhQxiDnE4Mr6yFhP+mrKeMswfb6q8HMeojd3tJekf?=
 =?us-ascii?Q?JHiH0n3fPk/pf2A3OMwDqKUYzyLWag2P082nLiLUT21/9fy2pgfzfGQABsip?=
 =?us-ascii?Q?vGURlg5l0G+NwLGhbp0NzwRUFTa/VUMslE6EMshXWuVj5CNUJRtx/LI2BEz/?=
 =?us-ascii?Q?6vd1vA4w3SQAreriGoBRNgrjjNBskEfBOFRr2eLuYaEcfRFnDgTIRzBcDOjy?=
 =?us-ascii?Q?3OR0LMTYsS3A5VMa5NuiKuFaJ9SBmwvSDcxBrKqJZ87SsdTHXjE0PsQdspCJ?=
 =?us-ascii?Q?4TQOBPdrIyHK5oSH5OEDHkXlwe+EZ9pgNU4bsNxBvhkFuOmHblOQPI6+kZUD?=
 =?us-ascii?Q?QXGpjb4JOEmMf8xRVg85cE9h4g5lwPNd0WsgNJOuu6S6p8fWNwldUGEDoaRY?=
 =?us-ascii?Q?mONGY7yXWSxu9f0/VBdXHBy+rPMD7wizqVlgA1bZeDXG04eypwx2c8bCnNFT?=
 =?us-ascii?Q?9saF7MIun2eW5wAGXrh2szQNaATib3YNbZ4ktxEPF3kBTjB435Na9J3z12Ox?=
 =?us-ascii?Q?13w9abeUEhEabaOmEoCLOq5r3o9lmucJ/sdi0PpYF0x+HwZNZ4xWhvY7eVeV?=
 =?us-ascii?Q?yTcnxYXRXWmG411+YH9SO+QurIW4uwcN0cdFYBTteXxhvvz1yBLcU9nptlS9?=
 =?us-ascii?Q?NOvCg2TWDy1j1bJpTk0RYQPCTl5t9HG53NLP14ImHvm+uq9n81H1y7vxfDMq?=
 =?us-ascii?Q?gSksTKkwgDIhjXs66dOglG5qHqo8j97hSxVwnDxY0iOZgB0JQR5AqQ2bCHIz?=
 =?us-ascii?Q?nRGdAil+d8PJ69y5OfY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e0583a-c655-4cd7-66c5-08dce6c59f4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2024 11:46:03.5010 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 19lupsbxCHFGZQAnTZtKQaCw0VFBUElG90z2kEOul0ziPKKm61XtsMZrnWuZg536D4g+zOSOtwtQqyYrkgM4uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9970
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
> Sent: Monday, October 7, 2024 6:51 AM
> To: Marek Vasut <marex@denx.de>
> Cc: Alice Guo (OSS) <alice.guo@oss.nxp.com>; u-boot@lists.denx.de;
> sbabic@denx.de; festevam@gmail.com; dl-uboot-imx <uboot-
> imx@nxp.com>; Peng Fan <peng.fan@nxp.com>; Ross, Fedor
> <fedor.ross@ifm.com>; Ye Li <ye.li@nxp.com>; seanga2@gmail.com;
> Alice Guo <alice.guo@nxp.com>
> Subject: Re: [PATCH v1] imx: Kconfig: make IMX8_ROMAPI
> configurable
>=20
> On Mon, Oct 07, 2024 at 12:28:44AM +0200, Marek Vasut wrote:
> > On 10/6/24 11:23 PM, Tom Rini wrote:
> > > On Sun, Oct 06, 2024 at 07:31:16AM +0800,
> alice.guo@oss.nxp.com wrote:
> > >
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > Make CONFIG_IMX8_ROMAPI could be configured in defconfig.
> > > >
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> > > > Reviewed-by: Ye Li <ye.li@nxp.com>
> > > > ---
> > > >   arch/arm/mach-imx/Kconfig | 3 ++-
> > > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-
> imx/Kconfig
> > > > index 134e42028c..9d3aafd2f8 100644
> > > > --- a/arch/arm/mach-imx/Kconfig
> > > > +++ b/arch/arm/mach-imx/Kconfig
> > > > @@ -179,7 +179,8 @@ config DDRMC_VF610_CALIBRATION
> > > >   	  the ddrmc_cr_setting on relevant board file.
> > > >   config IMX8_ROMAPI
> > > > -	def_bool y
> > > > +	bool "Enable i.MX ROMAPI"
> > > > +	default y
> > > >   	depends on IMX8MN || IMX8MP || IMX8ULP || IMX9
> > >
> > > Since there's no help here, is this truly configurable, or is this
> > > something that should be select'd based on the SoC and
> presumably
> > > some of the newer IMX9 parts cannot use this?
> > I can imagine the MX95 calls into this custom ELE firmware stuff
> > instead of ROMAPI ?
>=20
> Alright. Perhaps this should be depending on the above and !main-ELE-
> symbol instead.

Nope. To i.MX93, ELE and ROMAPI are both valid. There is case that
ROMAPI needs to be false while ELE is still true.

Thanks
Peng.

>=20
> --
> Tom
