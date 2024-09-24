Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D44CF9C71
	for <u-boot@archiver.kernel.org>; Tue, 24 Sep 2024 06:05:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5E17886DF;
	Tue, 24 Sep 2024 08:05:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="AH/CKOg3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C516B8855C; Tue, 24 Sep 2024 08:05:39 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AE738870D
 for <u-boot@lists.denx.de>; Tue, 24 Sep 2024 08:05:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QC4QODTdH37V9BksmBzr8iF/QaiPtLLt1Rl2mM77BUKeKE/a7Omwe11dnYKGYRq1o6yOCuGFBoliiVxpBcOr8ek3o1pBE1NC4m4w0ih9/Sdl8h6Kvd3esLNsjKnJGKtyG7XR28wAh97pBFlJxYc0IxFVLSE8R9N/1eJuRsLtTR60AvyydaHc/53sSGj0J3Of4G03E0MN52AVZw3GATCaIFa3rZbAPY+3L7NmQ9huJuN8Et8cVedSggyOeFG5hjRGoctE5pGcZ4FOQ/V9pwtkbohkPoMeOy5K/wpSTjhwwkfZheCAmEvsD8yvDkJmc9f4W0em2FjsPzv57gIOh4XKrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31B1rxa84lQeWqH0Fq/3QRdaIbTRYqdGhQSx/xK7cLA=;
 b=UsvAacWWHgILeoUZmt0UOo1U1ASMyMzRNI6MM7ERLFjvpl4YpVfnEUCm9g7JdUlnlzMLDYUzgL/uFR4OFvM6H3UR8kNLzogW66M9XoGTu6qg8biM0u+CvEaS5S3AsMUJs5KJXG4kuiXzd6uM8HKkP25Alc6xLoNsi7Bc0Q9al5Edt6zCslxElgSp8+oeZqC3qC40PSvPnfeguWb9/pV0MYBv6hLXKLkK0x3Z/ISWMeHGQh+hAM/+R12pId/gRGPxWmmCFCzidl7jIFsFygS2WCi57cIS7TiOMckznjevnCbQeNvY62zRKT2mqdrDiYwNtGT11oR4JTH20M8/IGqS2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31B1rxa84lQeWqH0Fq/3QRdaIbTRYqdGhQSx/xK7cLA=;
 b=AH/CKOg34LfQ1zYJGx6BjPNqpnCmwwJZmOrPH99yb5v6PYjQqO2upKHJ/oXYVVwImjZrtolfE5ydptE639S1nhznXa38MOlHcNgcOS2Of8MOvscOeN26NcKCrsKdC2WI3rGA74ghl7XJydZDBb75DeUvittMxLEDGIiYN1G7l/PCoKBn57Iek5Nhan+Ck4sKz3RGq3RCXkzEVYB/LWO6OzgyLvhJGTrHVABXyfseKm4ElhCOewRTmORSiReberA/0U3tT37ZY3jncLdK3jdbbrCe2AVXBtcBmTxPc4F1s1D7pw4ckprwRI0YRrIfbM242FG9QMeFHUKtwFH+fs1fhQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB7600.eurprd04.prod.outlook.com (2603:10a6:102:f2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 06:05:31 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Tue, 24 Sep 2024
 06:05:31 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Primoz Fiser <primoz.fiser@norik.com>, "Peng Fan (OSS)"
 <peng.fan@oss.nxp.com>, "festevam@gmail.com" <festevam@gmail.com>,
 "sbabic@denx.de" <sbabic@denx.de>, "joe.hershberger@ni.com"
 <joe.hershberger@ni.com>, "rfried.dev@gmail.com" <rfried.dev@gmail.com>, Tom
 Rini <trini@konsulko.com>
CC: dl-uboot-imx <uboot-imx@nxp.com>, Ye Li <ye.li@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH 1/2] net: fec_mxc: Fix clk_ref rate on iMX93
Thread-Topic: [PATCH 1/2] net: fec_mxc: Fix clk_ref rate on iMX93
Thread-Index: AQHbDbGz4BzVcfPZy0Kz80Sb3g9sQrJlWL2AgADmXyCAADSTQA==
Date: Tue, 24 Sep 2024 06:05:31 +0000
Message-ID: <PAXPR04MB845970AB29C2030065118AFC88682@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240923131439.28572-1-peng.fan@oss.nxp.com>
 <b77e571d-e782-4e7b-a9d2-1ca92df5c512@norik.com>
 <PAXPR04MB84597A12EC1885A64E34E04188682@PAXPR04MB8459.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB84597A12EC1885A64E34E04188682@PAXPR04MB8459.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PA4PR04MB7600:EE_
x-ms-office365-filtering-correlation-id: e90b9d49-1396-4f74-41ea-08dcdc5ee571
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?gkWHBrhd8VGeiKjUcOwlZvyYp5GSY4rN6O/tOj0OTWy1rTQanij51Ck9zrv6?=
 =?us-ascii?Q?RWlnTmn7UmqIfXZBCjI6FRfo0Oj9lxNkYhi+rpUFn8ZY9+cmCxhkVz2TBsrQ?=
 =?us-ascii?Q?lr7d1rCTUA7J5Jl/KSz1UaRJBEklYdp3zeiRZ/bU1Jr+ZRLX/P5OUK7IyLW7?=
 =?us-ascii?Q?e2kgyajIv3sBXba+vkPYTvByyyDVKnaQELzg0igVf81MmkOUqxh1KibxBnZF?=
 =?us-ascii?Q?6tqMPbMbIHnvDZaYrd98ZLJhT0FDwVPD3zVhDZGrx599zyvL+vtEG8QnV7+Z?=
 =?us-ascii?Q?Dvp+Az0FnE4rUeXYjchyvR54D/UtcFS9/dgLmkrVROeYC3Aeh796+TzmGjy3?=
 =?us-ascii?Q?bV/psf6tvzxMg4QG5lPwcrbTR132uMXKz58U1eAukOIB1RMLvcY12wjuBlls?=
 =?us-ascii?Q?56KTMwiV2MGQC0SLrn6G4BCMhsyFQbGEn3yNyk7In76DFvU1vkp9DL0jqJmZ?=
 =?us-ascii?Q?//4CK0i/ADeoH/S92kNtOrKI3ARXTzBY9yVy1FGzYt+OCFC5pxKP4x3jO7XT?=
 =?us-ascii?Q?4YXs1ZlkNesHGJBqUY3/lsfQKpjS3LfUq7pG5cJi1atni+mREEiCLqIfMcZj?=
 =?us-ascii?Q?FGaec98muKRVXoIZS+3SAT7Fu2lQMDQ7xjcw2ohdhcfU7CRzqIdyXcUYNipF?=
 =?us-ascii?Q?T7JSvcnx80JrbAQer9vk1lPEB51RUBoSQmTNDe5raD/CQxyHM7X+YUShRGUB?=
 =?us-ascii?Q?W9JU7YJbryvaf6yiuLiuvMRmEobQnvFcfvPwdS03KuHu5GwY33dMitvETFwG?=
 =?us-ascii?Q?pigEe9DMPAo/faSwTffNIK1s/4u3j/feCpg7rps/sGGRRvL+Le47yDCSqID6?=
 =?us-ascii?Q?Nmxj4fneI0ie7nu9+9w9e+O2l9xjNf189Lj4NVdaOqU0QgLXCSVRYwVmDRT8?=
 =?us-ascii?Q?XgXBr5r/D/zxCshneyIrZdWt53fmj8nBccrIUJOMh8IVeOUW7KKUQCbVCdG9?=
 =?us-ascii?Q?zYRim1ey0s4HuPVsZHOU5Q8wvPOzZJOOXkqRTiR0yKlweZyXFy6htmH2drXp?=
 =?us-ascii?Q?toHf7PGHiwixOep+a54SBxhfA8FoHTSlpeM7Tmn5t5ltxmbz+CU0r0ofVkzy?=
 =?us-ascii?Q?urR+87DVdJWzUfd38QC6nuLR/V/gNKdjVhZOxwQ5cNyo2vVWfzro6PBderB+?=
 =?us-ascii?Q?BPXoOse4xsUG/2VV6KdXgwUMMXPVv7GV4OPBi9plkMs45QDAC7xS48H1wGYY?=
 =?us-ascii?Q?iyUJFu7H1A3FB3aTzdXvkfkg4Vg3gZ0jT3r1LXd8/x9iws0OtbVMC3Baa9Dw?=
 =?us-ascii?Q?YiX2stjxnZ7lgLd+XWwBsw+ieKh2/LGfNHQOqjd80g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8vV1aacjT2mxbPYYA2V5e/gIZP7PsEL4Xapnc07P6/oTwrb/iqIk5kdA558z?=
 =?us-ascii?Q?+yTMLAm61InCUCXGRmkJ9b7Qoc5u8VnfcFS5fuOufh1z6oBxSku8EQxHZi8L?=
 =?us-ascii?Q?xPo1poye1ISB8pSuGbfaLM0buQfwkLG620TodQtDXHoc/wvMXGj6NxEEjkaI?=
 =?us-ascii?Q?DM8LloUWhIuYhjy4LZGqg6mvVwbCuHW54kYBF2wutF3/ORW6zzPnDpeQTJu0?=
 =?us-ascii?Q?P/K3Ya6ovUak70Qjflxjdsfioiwtl7pYNdKLhs+d/ItVtDuUiWSa99vVGiku?=
 =?us-ascii?Q?t9yFf8LTBzvtjcLHOybsscni3OTxzJc8M3DSgzDY3DEdKMz7BjI5FxI0gaAP?=
 =?us-ascii?Q?LhoWTRaSLE4Es0hWmPwTlcd1kgIXEBbTRECNpwV8lb+MW8ad1mTCrAGED4au?=
 =?us-ascii?Q?T8qPKjwz6C8ESjcZMyNNrnly1neUZMSfqygdIX9+xeA0OV9hXeHfv2huIDMH?=
 =?us-ascii?Q?eF2+MU77FL6h2eorZw8+bwR2ao2TX5nVG2HPLWiCBikuOo6PIsOyPgE6Cpr9?=
 =?us-ascii?Q?4Ug+GykWqLUZk7GDrcxenlMTW/vLOquXjYc9ipYiCCcKAsDMmLOTokzn4tqR?=
 =?us-ascii?Q?T/3NNVaYBmJKNXlt9K7CAyKZqcPLCTEkMqQPqvN30MnkZymAsQAhp91LRgPJ?=
 =?us-ascii?Q?wf77mH8VnZB5LtoPJlU994JppGmNaCSziZIg7IgIdwG3ct6t5LpZqk94/+lJ?=
 =?us-ascii?Q?eAcFouYVdkenVnxKyd3h3jWQz7h3LbyRxx91lPO6K4prjWqdI9RhZEmcPMY2?=
 =?us-ascii?Q?8kwW0rVaIssef2CKCSfYpXGLrq0Nf16hxpiDE8OrZv0Wo4Vb9p0qkapdWBTp?=
 =?us-ascii?Q?Ovx7iBVNm9tGB1priEXIcMKNKlcpjtua9he1IW5sofy+Ip0lTevS/2YWivcN?=
 =?us-ascii?Q?JdVKSaDKuyxMtEG+9iGG3C8/KhdPSKKdkqG7PMVeUaogKGuBDzJdSIcrlfFP?=
 =?us-ascii?Q?siHy7/YSa375vlLaEY+MJbWIS6gyDIfI5nSk9eVJePO72VaIOmXmwxrkvH/E?=
 =?us-ascii?Q?9Ji6xc37OBiDy0TdFfmIITP/fwoXJD0o/TnDm3y0vdPeVvIbErsSCNIe5bAU?=
 =?us-ascii?Q?6RHLhPRffuSmIXwqLJSBLI5u0IfC2KCLbHkbayYDQmFFSz3E8NgOn/nlmTrs?=
 =?us-ascii?Q?pWV2MCKaNNlu0Z9/vQlAdzhcmUf0Q7pURg3/+lyfCMbM0MbKykcP0iveipg9?=
 =?us-ascii?Q?qSd6QcO4X6hszYrWqp03rOKg0JxTspUo9jDDw4wq83Efc5BABcMifFz3oh80?=
 =?us-ascii?Q?CaYFJJiSKFbsKfCJdAnkspVctPOD4+i+jpWqJpoIAwCYBgChnu/rAiQO+PWg?=
 =?us-ascii?Q?0t2pXAeyb4arnOCClUgjIcNY+MZJaB+wG/OmUGoMeu07gzczVmUTWpRD07wN?=
 =?us-ascii?Q?kRX9CdWbEEBuCVTs1HhKaX5YdjSZ7y8rw8W6KJIRnDvczZE54yyVIg0nykh6?=
 =?us-ascii?Q?W/JANKBpkVCFMW9XZqb3d6XEgivppUgU4PrW92MDfdGmfNfCJ86V/ecDqkTX?=
 =?us-ascii?Q?Nu/F5/wiEqeKZoykQVOrd57hzUxF7OUjD8cK7eMZGLHRduiUadBHfK0/BQa/?=
 =?us-ascii?Q?iv3CkIAua3P2LbkFt2c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e90b9d49-1396-4f74-41ea-08dcdc5ee571
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 06:05:31.3957 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ELFkS87O0+Fo6CrUu0WGHBHIowc72FMyA9OZjSHS2h9xaWZhcOwv88R9vZW2oyHCm60WUuiimm2RhdzkLWaUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7600
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

> Subject: RE: [PATCH 1/2] net: fec_mxc: Fix clk_ref rate on iMX93
>=20
> > Subject: Re: [PATCH 1/2] net: fec_mxc: Fix clk_ref rate on iMX93
> >
> > Hi,
> >
> > On 23. 09. 24 15:14, Peng Fan (OSS) wrote:
> > > From: Ye Li <ye.li@nxp.com>
> > >
> > > Because iMX93 has a internal 1/2 divider before clock input to
> > network
> > > controller, so have to set twice frequency rate
> > >
> > > Fixes: 09de565f76b ("net: fec_mxc: support i.MX93")
> > > Signed-off-by: Ye Li <ye.li@nxp.com>
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  drivers/net/fec_mxc.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/net/fec_mxc.c b/drivers/net/fec_mxc.c index
> > > 0a0d92bc2cd..e5d7f0f3e1e 100644
> > > --- a/drivers/net/fec_mxc.c
> > > +++ b/drivers/net/fec_mxc.c
> > > @@ -1215,6 +1215,9 @@ static int fecmxc_set_ref_clk(struct clk
> > *clk_ref, phy_interface_t interface)
> > >  	else
> > >  		return -EINVAL;
> > >
> > > +	if (is_imx93())
> > > +		freq =3D freq << 1;
> >
> > Humm, but how did it work so far?
> >
> > On phyboard-segin-imx93, this change breaks fec ethernet.
> >
> > I had to revert this already in NXP downstream u-boot.
>=20
> Ah. If you set enet_ref_clk to 250M, then you no need this change.
> Otherwise you need this change.

I see your board set enet_ref to 50MHz, I have no idea why
set to 100M will break your board which is in rmii mode.
If you set enet_ref to 50MHz, the actually clk will be 25MHz

Regards,
Peng.
>=20
> Regards,
> Peng.
>=20
> >
> > BR,
> > Primoz
> >
> >
> > > +
> > >  	ret =3D clk_set_rate(clk_ref, freq);
> > >  	if (ret < 0)
> > >  		return ret;
> >
> > --
> > Primoz Fiser                    | phone: +386-41-390-545
> > <tel:+386-41-390-545> |
> > ---------------------------------------------------------|
> > Norik systems d.o.o.            |
> >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> >
> www.norik.com%2F&data=3D05%7C02%7Cpeng.fan%40nxp.com%7C482
> >
> 464a6990d46e9668808dcdbd135d9%7C686ea1d3bc2b4c6fa92cd99c
> >
> 5c301635%7C0%7C0%7C638626938825379940%7CUnknown%7CTW
> >
> FpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haW
> >
> wiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DkkO%2FnCs8%2FjpZ4ez
> > JYDHo5T57jmUVPdp%2Fs34CnpwrsGM%3D&reserved=3D0
> >
> <https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2
> >
> Fwww.norik.com%2F&data=3D05%7C02%7Cpeng.fan%40nxp.com%7C48
> >
> 2464a6990d46e9668808dcdbd135d9%7C686ea1d3bc2b4c6fa92cd99
> > c5c301635%7C0%7C0%7C638626938825421127%7CUnknown%7CT
> >
> WFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
> >
> WwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3D0YIItswvK9V9zEcn83I
> > h0IRjyzNGvqkM7vq4bXnajRI%3D&reserved=3D0>  | Your embedded
> software
> > partner  | email: info@norik.com <mailto:info@norik.com> |
> > Slovenia, EU                    | phone: +386-41-540-545
> > <tel:+386-41-540-545> |

