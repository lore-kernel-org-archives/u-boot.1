Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EDC7E7B61D
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 13:57:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06CFC8757D;
	Wed,  4 Oct 2023 15:57:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="sZO2/uzz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BFAA87580; Wed,  4 Oct 2023 15:57:12 +0200 (CEST)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (mail-tycjpn01on20728.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:7010::728])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 033328756B
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 15:57:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=biju.das.jz@bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3tFFTR63N8gljw4OLArY3YRBw5PXZwnoPTi5QPwemXR4vGmgf7F8y1JUJ6hZhu0uhXdVx4HE0oQ8OLBX+CyF8tEkuZwh+ewVHOUFaawh8bYfioZ4gcKrAPvSgdxIFwfu7rGOoJ4ao38Q1G51nQmMrl06hdR5a+H8shKngEXfH5zmtXrgQuD2chiY7ufH9M3ZP+eIbKprUYGcUf5FJTXOOlot58gLXskxlEqVUO1icawqDYQSDz6ro1aDbGxGjZsN7xriTIOpj1Vl11UEBxNN//epbSNi14+37qDnzIwFOld7e5vpMvSpB2ME6IxG+hpFLRBXtZeZvcTi2snfc3IRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7YJLjnr5rY9hJgz3RAkRZ18vhYqw6CFY/txYeVS1lw=;
 b=OsFuSBKVODJihcnk7QdVJfKaY9XyMJcWuk1jXMdu3Vd7bbyCRn8QsI/4PpubuqzQKaOy8xAlhT03KTMB4ibHwfb6slmAuYEPkLw3q5W7ul1TjPjNxRNh8hxa7dOebOxm7qUVZOvTwuxMV0VUiTzz0/8WKiODXnZPyPn6VLUZ63hJyTVAHWNQVYH4SRkAmCxOx5PA/X8lYaoQgcu87nZe8IP+blKLeYkLI1sXzXP8ZqdhTnRwKIL9v5ypVr0ggqT4G/hKGRGcl5JbCGvg3r1ar3TYemOu/3s0hUD9UAisiYhUbLJHK362ulC5PRVO6ZHqcp3YKP5HGYYxSeOss2Gp/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7YJLjnr5rY9hJgz3RAkRZ18vhYqw6CFY/txYeVS1lw=;
 b=sZO2/uzzWd3Ulx7BtBrJ/jr5hF1Ey0GhMekqtSI5W/aqszb5i0YP2itrpSbcCgVAZtMuRFXZMG6A5kpXuHtUB8M6FNKbx66OkQfqo0zfwpHcK5/y+Yef/C57O+nYW8qI5/AIU1shuwLL3BtlF9qpORqrUEqho/oLE9yRfY1I0iQ=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB10007.jpnprd01.prod.outlook.com (2603:1096:400:1eb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Wed, 4 Oct
 2023 13:57:07 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fb78:2e8c:f7f9:5629]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fb78:2e8c:f7f9:5629%7]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 13:57:07 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Paul Barker <paul.barker.ct@bp.renesas.com>
CC: Marek Vasut <marek.vasut@mailbox.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham
 <hai.pham.ud@renesas.com>, Prabhakar Mahadev Lad
 <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 09/16] pinctrl: renesas: Add RZ/G2L PFC driver
Thread-Topic: [PATCH 09/16] pinctrl: renesas: Add RZ/G2L PFC driver
Thread-Index: AQHZ9p5/h6LDzDKBOkyAdtZ4sRQeXLA5jj4AgAAHUmCAAAxyAIAABd7w
Date: Wed, 4 Oct 2023 13:57:07 +0000
Message-ID: <OS0PR01MB59225A3341B28C8B1E6D69D086CBA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-10-paul.barker.ct@bp.renesas.com>
 <b0df977c-75ef-1579-506e-42e48ef2a06b@mailbox.org>
 <8d2eb729-977f-9fd8-669c-25520218880d@bp.renesas.com>
 <ebcddc10-e450-45e0-8f93-585ff440da4a@mailbox.org>
 <OS0PR01MB59226E628EF9E3D0159AB0BB86CBA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20231004133522.3kolus6tueundhci@GBR-5CG2373LKG.adwin.renesas.com>
In-Reply-To: <20231004133522.3kolus6tueundhci@GBR-5CG2373LKG.adwin.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB10007:EE_
x-ms-office365-filtering-correlation-id: 0a95f783-b953-457d-110a-08dbc4e1cbec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 749jaAX/JF1naIoj3RyZ+e9tjDDR2l1uD3p6NVtm1YexvOHOgKofAiOVLr0gGngEQ7VUK0qFk071JLzZj72pn8SIYHQX+hjVLGgW3mom8LE4sPSgmGHfI+FmZ217YsTa9IUO3zXzonqhSuItedeqk3+Rcz3Q0dGvMPd51/LxtE99sL05YBd1/eIoyAYM+EDq05mDP5p29EvFEjUUfFxnsh2bJgJ5MRYDYmmI0gTRJH+FKZuqsQiwrAPbg2G/XfuNPoeVj5NjzKLsPRfCl7zJ8FAEbqHK/17aLvYS5/hykV+pmV2yehFJLRZUipKOK7PWGNVV4bOAC/W4qvD7pe3VAdrkvdJprIAQHwJX/yjZniR0RC/6JnRy0XsCl3iCWZ7ANQgsToVaVly7JCAmiQdYQ43C7eN/wn/J5nuywOE/urT1jxb2GxK7MTN1ATaGCaM21xkzsGw+Bqe8bCjypbFjGvMPlHlkSGpyq1a305X2JO7L97V+CHK8bX8IFL+yvJgsiAB6w/DsivmYxtgcWVKan6OOVq9GPt+dDvw5I9qesCOuLSgKg/5dNlFqN1O+6oXcODsW2dRMyZNjvN6notldJeJh0Dq8qXv/Nf8pQymanV6xbu5E1q4IrE04rGJ9W70G
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS0PR01MB5922.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(55016003)(6506007)(478600001)(71200400001)(53546011)(7696005)(86362001)(122000001)(38100700002)(38070700005)(54906003)(2906002)(41300700001)(83380400001)(107886003)(9686003)(26005)(33656002)(64756008)(66556008)(66476007)(66446008)(5660300002)(76116006)(6636002)(316002)(66946007)(8936002)(6862004)(52536014)(4326008)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BQZv2YjkB6lcBG6b35fZ7far3jET9VuXJXABvjiufNmxk5ElaQ+mJKlXHLp9?=
 =?us-ascii?Q?2cqWjRK+F9jq6KpxOgN6eCzWRsD5I1tOECPV7mJZ39ixFyn6AQyMnX3Q4e15?=
 =?us-ascii?Q?3l9IwH8IhwvORCiXTnVoMt7oso7z/tFuAzniGW7RmYvcMLnk4DPWgUbySZcv?=
 =?us-ascii?Q?bpHecSv+JxodSwc5ZZgk+YcrHGth7wTz+7UGO0hQrqtTMYgrsKhCqRxxSiSB?=
 =?us-ascii?Q?bt8W52Y4Fjx5yF67W6jE962rpGhO/QhmKS7oblyFgRknwwnD3PunXEC4F4AE?=
 =?us-ascii?Q?BHDm6p2dmp8wclaDB7s25Eo0efTihwJDJ1glnxfqlZdDTybO2YibV5Csn7rW?=
 =?us-ascii?Q?thNzJjrkMdiIZHkDVeCv9JI7d/p5t7eUpwl06Uo33UmCO1ro8/yImYRnkfAG?=
 =?us-ascii?Q?MnlJ3RCOOsFIiQQyUaEPBDDujVE4vGf94cO+dXHeVSlTfjsrJNpDGyiKmUGp?=
 =?us-ascii?Q?DG5fVDg634EHhrjhbZdOXgwNTfAS3MX4FSvYMPfQZbabCmDExqi5kCdMnVDx?=
 =?us-ascii?Q?dw8HPlWyNxNNOkNnPSYuOsYxQqNVngjETKIVLEIEHj9CNHqbLLjMR2TCXklU?=
 =?us-ascii?Q?qmcnEznilvQ6BUY5gjeD1/6edNzmJW1xLxwtOrNwY1y0uu8/3y2waPVupxdC?=
 =?us-ascii?Q?aRARcIFghruf2+T4sk5N8Uhhd6gvo4Zs+Rk0yQR3ktnGUHf0LLpTsFrugWe3?=
 =?us-ascii?Q?uPc2R0pmIYPhHg3ROES0EgfxcQr+NLMUsgQMThBBDbZQtLF/pA5Q9V6aLAIq?=
 =?us-ascii?Q?WQaHN/FVJMo8W/3E4AcrdAaMy5qQ8i9jYkPN+hF9sQIzGLSQ/27pr99kFQYd?=
 =?us-ascii?Q?kPPXxpyZ0+RSs6+sPjSRCSG8T/AEbAGK3Obyep9EBK1WkW2pkr+lf1etfU9H?=
 =?us-ascii?Q?Iddn/bzK1Zi5tDO4a2hALgmpywhWFwUYo0GPH7T7Q38u+1xVX1I2TiIoFhad?=
 =?us-ascii?Q?vqoyWylMK7Dyd68e6X2GkPfKH7AAUSDulXN007TWIZULPkCivsg2DWnBSPyf?=
 =?us-ascii?Q?BKOMVN+8QDX1yjv3enhkcN2g3EcxCmhj3eTaZivw2qmY8tC3SVogSSRZS1a0?=
 =?us-ascii?Q?huk4M5RGoaB3t2Mx+Vw4TfuEMbYmLeCxFMmUvuDOZ1Q9ck7pCwWvDOJJcd4o?=
 =?us-ascii?Q?lbqgMwl1o7NzGOR8/S3sqDX6XEN1qLvBggSNy6D0QeN210Bmjb5HSshE6aNv?=
 =?us-ascii?Q?C4ArU+CnH6Aw21L4YmkonoUp4/8YbOCWun/Kq5RypG/sHQlkuFt35xqQtM/x?=
 =?us-ascii?Q?zxUKpGJXIxcmam4aVP6gR8tUpDe7IWEcdtf0yC6DSj4yb99dPdUIMpevq/Vk?=
 =?us-ascii?Q?sexI3chpPYzhomS2s+qZ08iC0fFxZPEy7uL5TeSfj+unszVeB5KG/kt5I2Uw?=
 =?us-ascii?Q?YSDkQPyBnRiZL0SJ1IhBSJyRXZHV5DvROl4Mt6rCn6mapSbKgaFPqeMdr1TT?=
 =?us-ascii?Q?X0XVRuUYq3+HhPS5EmWiVKSlN2I5M93M5dvuAwf1O5kdaD7BVKOLfpUXuYPc?=
 =?us-ascii?Q?LGrcN08HehcuP6rwhY1/dXyJQxnGjuIHqQry5rfXlWNR96IlQKbsNSxuUcuP?=
 =?us-ascii?Q?pOqCKUlcP53c2NDFuYe1aZqI1iqj7iu0dWMxTt4YPRp2rKLWwzYpf94cbHK5?=
 =?us-ascii?Q?8w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a95f783-b953-457d-110a-08dbc4e1cbec
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 13:57:07.0665 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ALku4TQ75186n3jRUhdn2+eCa3/wCR9Hh9nAD+wa2KbvfSdXHz4kXWjEFWCogDTVBwMWQ8xeP273nId+3ej50FOueTH+yyHbtj6qBuGgDKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10007
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

Hi Paul Barker,

> Subject: Re: [PATCH 09/16] pinctrl: renesas: Add RZ/G2L PFC driver
>=20
> On Wed, Oct 04, 2023 at 12:56:14PM +0000, Biju Das wrote:
> > Hi Marek and Paul,
> >
> > > Subject: Re: [PATCH 09/16] pinctrl: renesas: Add RZ/G2L PFC driver
> > >
> > > On 10/4/23 10:40, Paul Barker wrote:
> > > > On 03/10/2023 14:20, Marek Vasut wrote:
> > > >> On 9/20/23 14:42, Paul Barker wrote:
> > > >>> This driver provides pinctrl and gpio control for the Renesas
> > > >>> RZ/G2L
> > > >>> (R9A07G044) SoC.
> > > >>>
> > > >>> This patch is based on the corresponding Linux v6.5 driver.
> > > >>>
> > > >>> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> > > >>> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > >>> Reviewed-by: Lad Prabhakar
> > > >>> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >>> ---
> > > >>>    arch/arm/mach-rmobile/Kconfig       |   1 +
> > > >>>    drivers/pinctrl/renesas/Kconfig     |   9 +
> > > >>>    drivers/pinctrl/renesas/Makefile    |   1 +
> > > >>>    drivers/pinctrl/renesas/rzg2l-pfc.c | 906
> > > ++++++++++++++++++++++++++++
> > > >>>    4 files changed, 917 insertions(+)
> > > >>>    create mode 100644 drivers/pinctrl/renesas/rzg2l-pfc.c
> > > >>>
> > > >>> diff --git a/arch/arm/mach-rmobile/Kconfig
> > > >>> b/arch/arm/mach-rmobile/Kconfig index 91f544c78337..973e84fcf7ba
> > > >>> 100644
> > > >>> --- a/arch/arm/mach-rmobile/Kconfig
> > > >>> +++ b/arch/arm/mach-rmobile/Kconfig
> > > >>> @@ -76,6 +76,7 @@ config RZG2L
> > > >>>    	imply SYS_MALLOC_F
> > > >>>    	imply RENESAS_SDHI
> > > >>>    	imply CLK_RZG2L
> > > >>> +	imply PINCTRL_RZG2L
> > > >>
> > > >> Keep the list sorted
> > > >>
> > > >> [...]
> > > >>
> > > >> Drop the parenthesis around values please, fix globally and in
> > > >> other patches too.
> > > >>
> > > >>> +#define PWPR			(0x3014)
> > > >>> +#define SD_CH(n)		(0x3000 + (n) * 4)
> > > >>> +#define QSPI			(0x3008)
> > > >>> +
> > > >>> +#define PVDD_1800		1	/* I/O domain voltage <=3D 1.8V */
> > > >>> +#define PVDD_3300		0	/* I/O domain voltage >=3D 3.3V */
> > > >>> +
> > > >>> +#define PWPR_B0WI		BIT(7)	/* Bit Write Disable */
> > > >>> +#define PWPR_PFCWE		BIT(6)	/* PFC Register Write Enable */
> > > >>> +
> > > >>> +#define PM_MASK			0x03
> > > >>> +#define PVDD_MASK		0x01
> > > >>> +#define PFC_MASK		0x07
> > > >>> +#define IEN_MASK		0x01
> > > >>> +#define IOLH_MASK		0x03
> > > >>> +
> > > >>> +#define PM_HIGH_Z		0x0
> > > >>> +#define PM_INPUT		0x1
> > > >>> +#define PM_OUTPUT		0x2
> > > >>> +#define PM_OUTPUT_IEN		0x3
> > > >>> +
> > > >>> +struct rzg2l_pfc_driver_data {
> > > >>> +	uint num_dedicated_pins;
> > > >>> +	uint num_ports;
> > > >>> +	const u32 *gpio_configs;
> > > >>> +};
> > > >>> +
> > > >>> +struct rzg2l_pfc_data {
> > > >>> +	void __iomem *base;
> > > >>> +	uint num_dedicated_pins;
> > > >>> +	uint num_ports;
> > > >>> +	uint num_pins;
> > > >>> +	const u32 *gpio_configs;
> > > >>> +	bool pfc_enabled;
> > > >>> +};
> > > >>> +
> > > >>> +struct rzg2l_dedicated_configs {
> > > >>> +	const char *name;
> > > >>> +	u32 config;
> > > >>> +};
> > > >>> +
> > > >>> +/*
> > > >>> + * We need to ensure that the module clock is enabled and all
> > > >>> +resets are
> > > >>> + * de-asserted before using either the gpio or pinctrl
> > > >>> +functionality. Error
> > > >>> + * handling can be quite simple here as if the PFC cannot be
> > > >>> +enabled then we
> > > >>> + * will not be able to progress with the boot anyway.
> > > >>> + */
> > > >>> +static int rzg2l_pfc_enable(struct udevice *dev) {
> > > >>> +	struct rzg2l_pfc_data *data =3D
> > > >>> +		(struct rzg2l_pfc_data *)dev_get_driver_data(dev);
> > > >>> +	struct reset_ctl_bulk rsts;
> > > >>> +	struct clk clk;
> > > >>> +	int ret;
> > > >>> +
> > > >>> +	if (data->pfc_enabled)
> > > >>
> > > >> When does this get triggered ?
> > > >
> > > > This is initialised to false in rzg2l_pfc_bind(), then this
> > > > function
> > > > rzg2l_pfc_enable() sets it to true before a successful return. The
> > > > effect is that the PFC is enabled just once, regardless of whether
> > > > the pinctrl or gpio driver is probed first.
> > >
> > > Why would be call to rzg2l_pfc_enable() a problem in the first place =
?
> > > It just grabs and enables clock and ungates reset, the second time
> > > this is called the impact on harware should be no-op , right ?
> > >
> > > >>> +		return 0;
> > > >>
> > > >> [...]
> > > >>
> > > >>> +static int rzg2l_gpio_set_value(struct udevice *dev, unsigned
> > > >>> +int
> > > offset,
> > > >>> +				int value)
> > > >>> +{
> > > >>> +	struct rzg2l_pfc_data *data =3D
> > > >>> +		(struct rzg2l_pfc_data *)dev_get_driver_data(dev);
> > > >>> +	u32 port =3D RZG2L_PINMUX_TO_PORT(offset);
> > > >>> +	u8 pin =3D RZG2L_PINMUX_TO_PIN(offset);
> > > >>
> > > >> A lot of this can also be const
> > > >
> > > > This is aligned with the Linux driver to make it easier to port
> > > > any future fixes across.
> > >
> > > Maybe send patches to Geert and see what happens ?
> > >
> > > [...]
> > >
> > > >>> +		return -EINVAL;
> > > >>> +	}
> > > >>> +
> > > >>> +	uc_priv->gpio_count =3D args.args[2];
> > > >>> +	return rzg2l_pfc_enable(dev);
> > > >>> +}
> > > >>> +
> > > >>> +U_BOOT_DRIVER(rzg2l_pfc_gpio) =3D {
> > > >>> +	.name		=3D "rzg2l-pfc-gpio",
> > > >>> +	.id		=3D UCLASS_GPIO,
> > > >>> +	.ops		=3D &rzg2l_gpio_ops,
> > > >>> +	.probe		=3D rzg2l_gpio_probe,
> > > >>> +};
> > > >>
> > > >> Can you please split the GPIO and PFC drivers into separate files =
?
> > > >
> > > > I assume you mean gpio and pinctrl here - the PFC handles both. I
> > > > can move the gpio driver out to drivers/gpio.
> > >
> > > Thanks. R-Car already does it that way.
> >
> > RCar has separate GPIO block and Pin control block So we have separate
> > drivers.
> >
> > On RZ/G2L we have only pinctrl block, ie, the reason it is integrated
> > driver in linux.
> >
> > If you make separate driver, how do you plan to share resources in u-
> boot. For eg: register/clock/reset??
>=20
> We already have this broken down into two drivers within the u-boot drive=
r
> module - rzg2l_pfc_bind() calls device_bind_with_driver_data() to bind th=
e
> "rzg2l-pfc-gpio" and "rzg2l-pfc-pinctrl" drivers to the device.
> It should be no trouble to separate the code into two .c files in the rig=
ht
> places.

Thanks for the explanation.

Cheers,
Biju
