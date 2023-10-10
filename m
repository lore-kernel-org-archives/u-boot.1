Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF87CD68F5
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 07:08:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C402286D3F;
	Tue, 10 Oct 2023 09:08:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="C8aaU6Nt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 798A486D3F; Tue, 10 Oct 2023 09:08:53 +0200 (CEST)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (mail-os0jpn01on2070f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:700c::70f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83B4F86489
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 09:08:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=biju.das.jz@bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xvi748EVCVpqWHVopqxs+m77YX2Gg5H9g+Lpgw07QzcWPTkw/CXmBYFL2eGNt029mRSh5T1/KsWK4PCllFrge9dejG5j13FjrwJH+1nqx7KDy2Nm2aMJVKrtoYbTBhrBKcYY2b5iJpRb1Zj0hlsrak/vEsXVZnDoSZg840gy2XWGMAfbhs9yjPG/KO9W+fc15ehTueB2Hi0QaXRLeMuGAOST1UexTBYs7D6y1XFPMHLhbMhh5fiWW9gr/eG8R9BeTU0NiM3dFm0U8Vt/vnltGWugtivxzzC8R34cBBT12x1Mp6llRRPQh7TtxMZK90IEUbwKJgwvoAXNIFwU2SoC1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWZc55/lZrKwBssq3SMkEctfREmrTcyvwWkUvGtjHB0=;
 b=TUCah12Popziol/xbzJEo6THqPytpou9fBPzbOBaQpjjCB5RziQv3rnSMGSXUPFzDLs7JDdkJRGhb7lgBUaBIdhupmpmlgKL1gYdMZan3a2vij5YWR2g5q2sCACp16B9VZKXketCFFtN0XgeSqMaycyTyusKS+oX64xcNj+YDgFkap8BOScCkyZqCqGR8Hcg5ErAQ2IWIPiIM4esLWfHnwuwT9n8ROci4dQVtSHfy7F7tm4nsBfOvV/xsnceJwHNfOxSdTJ4Rlp3DaVhnI8m3gukc+hscM8dSS8ytqLaGs9ZOeSJNv12DMXedflZWHd/ztjK6YLm5Tm6fNWiHPUfrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWZc55/lZrKwBssq3SMkEctfREmrTcyvwWkUvGtjHB0=;
 b=C8aaU6NtyFpOR+iWo3iW5XXoT+/r25DjChyltX5FK04Boeqj5ibxChCqXC+NB71etlS35jAa7D5BJoGPxBL3n95FonDXWvOn91ieSecE3a8LBYO+Rfp0C4tmESLDsgME2zN917MpawXLSObkQNaIFfz11xFo7q2GPYBHgkaKOtw=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by OS3PR01MB9604.jpnprd01.prod.outlook.com
 (2603:1096:604:1ca::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 07:08:43 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::db75:e192:bbfa:78a2]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::db75:e192:bbfa:78a2%3]) with mapi id 15.20.6838.040; Tue, 10 Oct 2023
 07:08:42 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Paul Barker <paul.barker.ct@bp.renesas.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
CC: Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: RE: [PATCH v2 11/19] serial: sh: Fix error handling
Thread-Topic: [PATCH v2 11/19] serial: sh: Fix error handling
Thread-Index: AQHZ+tCT+W2BNsHysEakSyEmKwqPE7BCmu7w
Date: Tue, 10 Oct 2023 07:08:42 +0000
Message-ID: <TYCPR01MB1126966A9B8444133495FB75186CDA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20231009164645.164464-1-paul.barker.ct@bp.renesas.com>
 <20231009164645.164464-12-paul.barker.ct@bp.renesas.com>
In-Reply-To: <20231009164645.164464-12-paul.barker.ct@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|OS3PR01MB9604:EE_
x-ms-office365-filtering-correlation-id: 448ec665-83cf-4ad8-c71e-08dbc95fbcb4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QHtMy44c2iIIa91Vlp+RcNRhIPDIqQFd7sSAxGtdRzlYcAWclvt8aOV6CgzE2U2SKPxzwQhNGYiQXG+o2IfrrWL64Hu7wiSNWPpD4P7JM4uI4OwtEgtvt9i8KcsmoZtHKyE5KiweZbwfE/e66NKtKWdFZe6HBLyfoebf67m1FhevqloJ0hlTsWNKrA90G14kD1DA+AcSOohrlkKmEyQRt4rIf5Rem0Wwg4jPcPyeEp9vqonXQbQLKU7EfH4H5AWNMPk58Phxnnqs9PoYBNd8BYnPpv9vQ/TQguuNrvKVPV8B6++VprajCh8oOiYi6AUOOLC9tJEoiDKLWFQVp6Aig92FKnFzTiZp0ThAKAym23LXRcmRFjQrKfyjdc/eRCiCKKZYHWsn2phTk7hNULu0UIolxMunE5B7Zc7WXWyHY63bJWiPjGr7W/HNgzsPFx4bFcA4waYzdhkXaTsKKj6UXZZfRcmTPzPYhxWpkpuquLgppPaXewqjPyQh/fbbx5EmPnmejYhVmH3nE0UQWvYGmkGjOnnU977NlzmMEgTGpNzbMrx9gLgY2m5Y+P5Y7q06iXApP5H3JKhemud4CR510OJbi+i46xCn7rIQ2iq62uanjP5gRp96/F+sf7o1dk+R
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB11269.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(346002)(366004)(376002)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(478600001)(71200400001)(6506007)(55016003)(7696005)(9686003)(83380400001)(316002)(66446008)(76116006)(64756008)(41300700001)(66556008)(66946007)(38070700005)(38100700002)(66476007)(33656002)(122000001)(52536014)(5660300002)(8676002)(8936002)(4326008)(86362001)(2906002)(110136005)(26005)(107886003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rEO5kBydrHNjP26khLyiSOXVcgMwNK2LOck7dc7Nh8bKhb8S+LOdPGpu8cRU?=
 =?us-ascii?Q?PzrVHHYNzJMlM05PLZ1l43DT498NfS0E4SStIHurtngq++RhNC4MQKJ0k7iP?=
 =?us-ascii?Q?buXNLmRz4BvIZNnECFw3xA0uDnbmbkpvTJUpNociJuTwov52lxhIB+99kphc?=
 =?us-ascii?Q?UOSzUKQYtqWq4FmRdxfy2HhMSVOrf2GO0UxF/81eC0c/4BnL3c8jlKbdQL8K?=
 =?us-ascii?Q?+kBv2iGaeP5tj2A0VCjisBgPUOAuN+jjtXI4HwHQMqWBwU4ZTW2jSslkvb+K?=
 =?us-ascii?Q?ijaJJf53/ojYo+TnPFwqgDlsxATu75exDzWV/32JopKrkmvhJtJKJZWFiQ8y?=
 =?us-ascii?Q?bcRkLQJUnWh33+Ocxkqo+Cc7N/S5eaFRe6sEMmwpjVXLtCWk4EaflkFEqtdo?=
 =?us-ascii?Q?Sx/k2FNFoDf1A3WXdKMji9tC+jCmGnEgrvY5DkouvoSG74bBkbjTfjxPYcuf?=
 =?us-ascii?Q?Bw2wQ3w9DswH3PHrwdrZ2Yleybb6AlHKqfVFNyTji7ktJkGSkvQLv/O7KQEq?=
 =?us-ascii?Q?Wy+miEU3OVdC3J+kI9oArT6IUB+3KZ81TE+Q/5odT3TvfdsXxVAE+jcV+ox2?=
 =?us-ascii?Q?16N1eauprfkQhRzDT0qTh7nE2jjyzMkJ5xT7aP2CgrsYye/Arr7IIGdtIrwl?=
 =?us-ascii?Q?rVAsUCwbHUf0jrqth8m3wWe7KpC45wIhFkJ8425nKX6itx0SfoudRnK3KU4a?=
 =?us-ascii?Q?0KFTseE7EAGDip7tPseLOy/5/qrYjYsNBTji/qEfd+vN9U1dcyijtfYB9sQS?=
 =?us-ascii?Q?ianGMemEQi/mri7LKMKfbyrTXulkm3sUsG1TIkducrJZ5Ell5HNQyyTAA+TI?=
 =?us-ascii?Q?pGzVp7TsY6om5QkrdS+xNfg2mXRPMF44alnmfrtvMAFhNmmjRyUSkfHnPXTZ?=
 =?us-ascii?Q?eAhThvjS82uKmVIEpN5KBiAHM5vZ74IKgEBZnxPvX66fJ4Pn2A0vs3Gl0DsP?=
 =?us-ascii?Q?0dk8OuzTF/kKXEAFP1M6rdQ3fLG1v3+pe8vyZYPPx/KMyZD+eAv+4eE5MyOm?=
 =?us-ascii?Q?TIe7z6TRPA7MEYwj2UR8Kk4ER1iMwXR25gARR3kEQAjV0DWJSySnHH1wN0x9?=
 =?us-ascii?Q?MPVsyDaBjn76zjjm5qDh93Ze1iEu9bc/02PU8K7GaBEz8pPSdNAKXbpah8NP?=
 =?us-ascii?Q?rpodPrrt/ve+j1NqKNH3p1vvaMYTTlbTcM9DYQ7I5vFe7kTIesIzNY/yyH6S?=
 =?us-ascii?Q?9a815RSBoM+WKyUE+TXiNxl4hrg1j+jUaWkYeimL4a5yOU/tWK6yVfWHlMtu?=
 =?us-ascii?Q?ws+qwsDE7o2J3MVmpyhk8X/AuCHab9HSNw9TFN3NbvJ9XBi6eq+E3v00lMy1?=
 =?us-ascii?Q?5MwzwFxCfuXIG+WuoVyqyuJbLFKpn9CL+wYj1ovKh2pkivUSJEjeOJ61J9lj?=
 =?us-ascii?Q?1B4rJaQLECzpYXj9VZ1GkJF8TL/fJ3wcS9A9hFbEy4GKIarNI8lnsyEJCnyi?=
 =?us-ascii?Q?JBN5BjpDJgr0ti91pTn6/aWz83KTeZASqvAK3YOL7D37gHOAueUojoVhRrkU?=
 =?us-ascii?Q?nu2bE0mgiLfAT4olh02aaiCIlHwT2KfR60l48HrrgWI5EWey1PT6zxEotxJn?=
 =?us-ascii?Q?irZ+15/ndGWNEwlGMuOV5cbZdiArqxjkkI/hAmov14CcRzEtMsS1cx6YwmMt?=
 =?us-ascii?Q?Yw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 448ec665-83cf-4ad8-c71e-08dbc95fbcb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 07:08:42.7809 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fjmm+BKpLfKQ0EDUig4sx/6TctqqaqAytepxyhld6TJmN2Afnom76TePsuR5cybDXZ/QJuHtgvLGva+JNhzCb4ig/sis6dVKkJpHns2JjWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9604
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

Hi Paul,

Thanks for the patch.

> Subject: [PATCH v2 11/19] serial: sh: Fix error handling
>=20
> The current SCIF error handling is broken for the RZ/G2L. After a break
> condition has been triggered, the current code is unable to clear the err=
or
> and serial port output never resumes.
>=20
> The RZ/G2L datasheet says that most error conditions are cleared by
> resetting the relevant error bits in the FSR & LSR registers to zero.
> To clear framing errors, the invalid data also needs to be read out of th=
e
> receive FIFO.
>=20
> After reviewing datasheets for RZ/G2{H,M,N,E}, R-Car Gen4, R-Car Gen3 and
> even SH7751 SoCs, it's clear that this is the way to clear errors for all
> of these SoCs.
>=20
> While we're here, annotate the handle_error() function with a couple of
> comments as the reads and writes themselves don't immediately make it cle=
ar
> what we're doing.
>=20
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> ---
> v1->v2:
>   * New patch after discussion with Marek & further investigation.
>=20
> I'm not going to put a `Fixes` tag on this, the error handling has been
> writing ones to clear errors since at least 2007 so maybe it was original=
ly
> right for some board. It doesn't seem to apply to any of the current user=
s
> of the SCIF driver though.
>=20
>  drivers/serial/serial_sh.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/serial/serial_sh.c b/drivers/serial/serial_sh.c inde=
x
> 5e543dbf3d58..2b650d458e71 100644
> --- a/drivers/serial/serial_sh.c
> +++ b/drivers/serial/serial_sh.c
> @@ -79,10 +79,22 @@ sh_serial_setbrg_generic(struct uart_port *port, int
> clk, int baudrate)
>=20
>  static void handle_error(struct uart_port *port)  {
> -	sci_in(port, SCxSR);
> -	sci_out(port, SCxSR, SCxSR_ERROR_CLEAR(port));
> +	/*
> +	 * Most errors are cleared by resetting the relevant error bits to
> zero
> +	 * in the FSR & LSR registers. For each register, a read followed by
> a
> +	 * write is needed according to the relevant datasheets.
> +	 */
> +	unsigned short status =3D sci_in(port, SCxSR);
> +	sci_out(port, SCxSR, status & ~SCIF_ERRORS);
>  	sci_in(port, SCLSR);
>  	sci_out(port, SCLSR, 0x00);
> +
> +	/*
> +	 * To clear framing errors, we also need to read and discard a
> +	 * character.
> +	 */
> +	if (status & SCIF_FER)
> +		sci_in(port, SCxRDR);

Do we need to read status again to make sure framing error
is cleared?

Cheers,
Biju

>  }
>=20
>  static int serial_raw_putc(struct uart_port *port, const char c)
> --
> 2.39.2

