Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5979DD3B7F5
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 09:12:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A461D8965E;
	Mon, 25 Nov 2024 10:12:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="00a0ZGWv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D8ED895FB; Mon, 25 Nov 2024 10:12:34 +0100 (CET)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::62a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 479A489963
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 10:12:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6dP3YYQ7EDCCkQ2GBuEPu2gKaIM6zChFiPjiCENOgmMUOUHo6g8CsjYhWuWa2bshimvJvPoj+h1c0RLzz7AW14AuktRgn8ccUSu3XutEEtylBlG9sFBXHKdYRtxjylDgFs5t4huwTiL+7WN/OcPsoKjff4zJgr5Q1UGtRHArGOTMMKBsdSdcO6SLyyca590En9D0V7R+Dz9Yvfs4qgQNSkbN9qrkaT9GXLcvPN8RpLMzpxx4O8kuk+KRTMtsw9b7F2eyQdQ8nuIdMOPoW4aRFQ2HzAsOZronVj02yGjw9J1QPER0S1zLmbkjTOrnhQ5TcGOGIetG+cZQFr0AiC7wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oSn9UErqNzILKcSPNsdCkGFjz5usNARDv2VsPOxwm7Y=;
 b=R4UrzPoKQ1dN7K3HxKjqkyn8FLxJ/zDL8OMx/QLGD2PufaOsqZD0bXKp/OoZNu3kt0DsjGKYnWOpWxc/Bac0ZIZ2RIoca/EqpFlp6s0fG4KL0iZlV+0REiz3tg6xJHzX/Ijgj0JQJ1elmj3LWIi7hEmG7gL8C5TfMd2YySF8TcSCWZaFZzzj8aD030Y1hHxU0vfTTzT5TwAHPcRFIPbSn6mYwdJ6ac0pt4tPbfeuKygaa0lK/rGERC5SQW3L4dNoYMe7XZ5JjOcBYyvM47C+Q+aujQvqMntlaes3xl/R7xk23E2SVOHeEGWe/Kn6SSiZ+hpl5AATzlgB0TBFtyVkLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSn9UErqNzILKcSPNsdCkGFjz5usNARDv2VsPOxwm7Y=;
 b=00a0ZGWvdjFiYbIL829rFgDS9Ex/E2Qk0i0ZR3u2GFZMhZh0UrtPEEykoZd271f0flGgkWQyzMyq0s6ZDEqb0hvkwkwNv3ApyW63Hl6y6NEgHk7wFqlWNKSK2a5RxTIX0gskL/DNn9XkdDfbZsW4y3P3oguIO3jbXy1/hxDaEt8=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by IA1PR12MB7517.namprd12.prod.outlook.com (2603:10b6:208:41a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Mon, 25 Nov
 2024 09:12:26 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%4]) with mapi id 15.20.8182.018; Mon, 25 Nov 2024
 09:12:25 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: Prasanth Mantena <p-mantena@ti.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "j-humphreys@ti.com"
 <j-humphreys@ti.com>, "Simek, Michal" <michal.simek@amd.com>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>, "vigneshr@ti.com"
 <vigneshr@ti.com>, "u-kumar1@ti.com" <u-kumar1@ti.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "seanga2@gmail.com" <seanga2@gmail.com>,
 "caleb.connolly@linaro.org" <caleb.connolly@linaro.org>, "sjg@chromium.org"
 <sjg@chromium.org>, "william.zhang@broadcom.com"
 <william.zhang@broadcom.com>, "stefan_b@posteo.net" <stefan_b@posteo.net>,
 "quentin.schulz@cherry.de" <quentin.schulz@cherry.de>,
 "tudor.ambarus@linaro.org" <tudor.ambarus@linaro.org>,
 "Takahiro.Kuwano@infineon.com" <Takahiro.Kuwano@infineon.com>, "git
 (AMD-Xilinx)" <git@amd.com>, Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Subject: RE: [PATCH] mtd: spi-nor: Enable mt35xu512aba_fixups for all mt35xx
 flashes
Thread-Topic: [PATCH] mtd: spi-nor: Enable mt35xu512aba_fixups for all mt35xx
 flashes
Thread-Index: AQHbPMCWS0dDsUoHJ0OAlINbovo5o7LHtFOAgAAFwgA=
Date: Mon, 25 Nov 2024 09:12:25 +0000
Message-ID: <SA1PR12MB8697E660E054185666B19C17982E2@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20241122092619.1376234-1-venkatesh.abbarapu@amd.com>
 <20241125084919.e3mr4nwmoecqj3y7@prasanth-server>
In-Reply-To: <20241125084919.e3mr4nwmoecqj3y7@prasanth-server>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|IA1PR12MB7517:EE_
x-ms-office365-filtering-correlation-id: c3b4911e-62ba-4b91-7049-08dd0d314768
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?x/IJxVaH5s8OLW0LB3KBStMN3u+mR58lsnEVLad7v5ProvLPAtP/Nx156A4A?=
 =?us-ascii?Q?N4JMy/SJqaSeog0W2nVnqWrcRPoEi8BepmySgnrVd+89yOGKclrXyxpQirv4?=
 =?us-ascii?Q?5rGcAaMPnWKOQnXpUxkrWMjj1TpmAfc79AQ+HGywKMTPOvYdvBuZp2IKehel?=
 =?us-ascii?Q?sJ2ICu59CMSTeGRu80SvL81c022cxcaSzCTbvNMfMfym9LoHC6/5J8AEaH5Y?=
 =?us-ascii?Q?0PBx8yIe6Nkgr8kx9XC0ej2t7fAw54k0AhPTE4/x3zs+EPPpKUCaTSAso/GT?=
 =?us-ascii?Q?iWCGeK0usp8t/vvqKPpc6q3T/15toYqW8EoVjNkM95SA3EUmwjIFPgVjmXjU?=
 =?us-ascii?Q?j6InNMSGEtRm9LknuiGBPxDY3BAyPwLoXKyFmfehhxUWQ6xVzpboQY6kT4/N?=
 =?us-ascii?Q?ZY7q1H6dDh7LYUMj3K0fiVKFQyyA2ctDbAIgTTGmrpA3kDG3BUuOX7JzzzOb?=
 =?us-ascii?Q?o4XACowDnICGsRoHFqSciYRkyDHSKJ+/zCaOL1Rz0bx74sIDyWWlwhJAMuIx?=
 =?us-ascii?Q?IM7rrnsXNeQMvZz1eNYDsNudY60TxXUJO1vdqQh6t8JqQSjggBdJQ5u5lbmp?=
 =?us-ascii?Q?gfWl7s2wzBxp/4wUiYpJkSrJriTaaMql7c99Zm4Hg9kRVEbIqHLSGDRvCtn5?=
 =?us-ascii?Q?TEnyrPrTEcKpK0dLEVQIkz34p4RfI90HnMCqwAoJsAl5CH4GUNWw9IVglFVc?=
 =?us-ascii?Q?z3H3HZSRKOUA/IS2Hd3DKtn53n/w7wndch2q30dhUFRg1W/7z38/RdkLqTCJ?=
 =?us-ascii?Q?6QZaJgy268Ki4aEbsXDsLFhUYxkBXT9m7J35PMC5Cpg9TfQXT9ZXLvJC+y+L?=
 =?us-ascii?Q?RLVQ7+aEq+l+ZSL9MojFUZi5RCwJw97L9sKpNbQcudbcNbvqD+hO4J8467UQ?=
 =?us-ascii?Q?oJV3Gp2F5JqulPGTmt8C6ZtUayITI4dfHtlAfjVOvd2FyFFk+vhj9uIttrNP?=
 =?us-ascii?Q?JNh9L5EELtOpJjBsFM4dBBzQGb9LGfQq16DgrVvgwQu/axPqHT4fRvXO2q0U?=
 =?us-ascii?Q?wYCAkv1yREWOwHMY2UMuLMPwtM8CXFPDUv8qyJs5gU0yRRGbAo+2Hdb5jnOn?=
 =?us-ascii?Q?L5JKE0NPKY/+Jv0Qw8v4OQpw5BNmnxWJHsZnsA5tYnlZqGtV/HywvB8bcGCs?=
 =?us-ascii?Q?3/Ryszy7cqN67Q02pPSAtfi6zdh0WSropa2At4sVS22oBIJ7qR+m+zlVkwAl?=
 =?us-ascii?Q?kQi5++HYAvcF9v2Iim0hwVXQxZhTcolpV2m24gupvwDIwBSj5x+miBZU4vLF?=
 =?us-ascii?Q?q/VGbKDoDPyhwxZ2Zy6cqMUN2ACC2gk9fXp83ig2DCzYQf768VcBGkSaFVSG?=
 =?us-ascii?Q?2/NEix0BXOEzTrwqhinTahGrWN0MRkE/se+YmOT5Fn5IprFgc/F7O1saPvtd?=
 =?us-ascii?Q?juaZCPq2ZjaRyNjUncONr3W4YhPWmEsX/5fwWyV1qe/szM0UKQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JDLf8/1d8YJkeruppunqFpwT4yXGcwrWQnevkgVxlp02wbuswPiujUc5WXVa?=
 =?us-ascii?Q?2zY+pU1n60SV9ulUUlN9FrY4O0v4WkUhul8VAqvGKhV9Pr4XAdsk4RSytTqS?=
 =?us-ascii?Q?8MDouHBHLSh2pdsLFV/bV9vUczlvxTguk3hKv/bRDAl4W3HSxspr9jepKM5t?=
 =?us-ascii?Q?hbjp+lDupxu75L1pHbj3zmWO4hsRLutcmnQVDJja39GajfU6/ICcFR7JLqNW?=
 =?us-ascii?Q?HWAor2U/3zPNGLC0WSjj/sN8xlGsm/sE+JFDd9LSqrF+NffnW2fIen5kWN35?=
 =?us-ascii?Q?vIvIQ/3QfSBt73ilNya3+KMbdMBPLQ0xizZ1he0Z74cwLyVbhuMqn+fcq0Qw?=
 =?us-ascii?Q?yFwKdeYVaoEvQtRUXjNRzMU6fok58CjTPcTwWWFQq2xd8NTCvUVZErxd771f?=
 =?us-ascii?Q?nJxzN/SBGzIXX9nyBROEFerCYU8t/kf5DMZ3W9BIxfHNHlay5nkDjYzR5XGd?=
 =?us-ascii?Q?EF+1iS1DzKGxg9TPdbD8JFOC/1fPf1zpGZJJ7tpTSBNh2PHB/NReNL5MODw9?=
 =?us-ascii?Q?ImmgiTl/ZHz0sFg0HFu0r+gSheFaUeUosayz6rQyCmmJviW+6qOApvA0uVYp?=
 =?us-ascii?Q?CHnVzLqcMqEG4xehHk6Bmc57fyhtk8rxD1h/VYibfjEaJfDk4sFug/I6cWat?=
 =?us-ascii?Q?EPK39muqvTcUOj9wsnaPO3KexSqqP3N4pWVqZdKbhG6NSUiYA5nyRHPPaSiZ?=
 =?us-ascii?Q?1cxXKcOHwFbx5KWVcxST6eJx6mnFtz/3YCLLFXS30fNJkQ+GRVmvwummysOC?=
 =?us-ascii?Q?HVApw9xL/v3UcXwbVwSkWM4u/QUL2H5rNVXWd+DtpLZGV+nxSG/fyzPjp2KB?=
 =?us-ascii?Q?liRITZ2BXZTfTHmJanCAC7O/2BIac/2WfgXnCxrov4u6asrzd/Odwc1uMkuF?=
 =?us-ascii?Q?mT/1jB9OQPJN/dJ43PXthug6m4GXx/4QeFsSyL8BLULgIoJ6jMU1Olol2qmM?=
 =?us-ascii?Q?SQUux7IE/KC+Zw5FM4pz9G13iJM65r5IFg+VfUROM0EfrM7A6gBLIKnsZX+6?=
 =?us-ascii?Q?j4Xl2gQ+mm7dNFsp0GUcvJLHr9d7onvusrjMMyGH47+y6OnKNgvneGN3c/hW?=
 =?us-ascii?Q?olNhtAPSboh755EsFETS6BQPAqLxlZeCwbsulWY9v4i4yDfU6zYUv5ZI44xC?=
 =?us-ascii?Q?3T76DLYU4nNA3czkLvDhk7iiHnN9v3ZnlNYVhZ4Oq1o64aULjzQPd8NaOoJt?=
 =?us-ascii?Q?FP8ayXAcDCMNdiHpJEjWBf+3oxXy/dvXwdeQxIW3pWG2CZTafLkH6aEuLcZX?=
 =?us-ascii?Q?2a9uv/RPuBcdE1xon5gbe6IhSul7Bgve+5jF8Ck4LvPFh+KRvnCgxkYu8DQE?=
 =?us-ascii?Q?+CgaToCm31KSLmq7DnruKBm60UfKBfWOVkDBNVndphE7oFuz1/9/mpUXqoCp?=
 =?us-ascii?Q?0o/AUmbxyZJfaGXNhHPztDoEnuiKdthxtYkhf0WgG0ndz28HQoAaIlI5ankf?=
 =?us-ascii?Q?j+gf/asKvbJ+ceVFE0w0Ov6sLxF0Hd+bMOGNmOw8psE8DotWVI8Q0/04moXb?=
 =?us-ascii?Q?1Wyu0xPi1qkJsYBwVFf7U21wYimqoeSTHtnAVpoEb9lU9EFJeDkCp1/TGzHz?=
 =?us-ascii?Q?NYXJWDYflYYq3FaCtqg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b4911e-62ba-4b91-7049-08dd0d314768
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2024 09:12:25.8822 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AwEK8+UyR+cmWzu+2WKdjgFIVyKbk72cUuaL/qKlLFYw8stAEE/dCGaNEI/Wkmkr5sSSCg87bl6wS9TJDXZ9WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7517
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

Hi Prasanth,

> -----Original Message-----
> From: Prasanth Mantena <p-mantena@ti.com>
> Sent: Monday, November 25, 2024 2:19 PM
> To: Abbarapu, Venkatesh <venkatesh.abbarapu@amd.com>
> Cc: u-boot@lists.denx.de; j-humphreys@ti.com; Simek, Michal
> <michal.simek@amd.com>; jagan@amarulasolutions.com; vigneshr@ti.com; u-
> kumar1@ti.com; trini@konsulko.com; seanga2@gmail.com;
> caleb.connolly@linaro.org; sjg@chromium.org; william.zhang@broadcom.com;
> stefan_b@posteo.net; quentin.schulz@cherry.de; tudor.ambarus@linaro.org;
> Takahiro.Kuwano@infineon.com; git (AMD-Xilinx) <git@amd.com>; Ashok Reddy
> Soma <ashok.reddy.soma@amd.com>
> Subject: Re: [PATCH] mtd: spi-nor: Enable mt35xu512aba_fixups for all mt3=
5xx
> flashes
>=20
> On 14:56, Venkatesh Yadav Abbarapu wrote:
> Hi Venkatesh,
> > Enable mt35xu512aba_fixups for all mt35 series flashes to work in DTR
> > mode, and return after nor->fixups is updated, otherwise it will get
> > overwritten with macronix_octal_fixups.
> > This flash works in DTR mode only if CONFIG_SPI_FLASH_MT35XU is
> > enabled and SPI_NOR_OCTAL_DTR_READ flag is set in id table.
> >
> > Additionally, a new flag, "SPI_XFER_SET_DDR", has been introduced to
> > instruct the OSPI controller driver to switch to DDR mode.
> >
> > Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
> > Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> > ---
> >  drivers/mtd/spi/spi-nor-core.c | 8 +++++++-
> >  include/spi.h                  | 1 +
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mtd/spi/spi-nor-core.c
> > b/drivers/mtd/spi/spi-nor-core.c index ec841fb13b..8d201433d5 100644
> > --- a/drivers/mtd/spi/spi-nor-core.c
> > +++ b/drivers/mtd/spi/spi-nor-core.c
> > @@ -4073,6 +4073,7 @@ static int spi_nor_micron_octal_dtr_enable(struct
> spi_nor *nor)
> >  	if (ret)
> >  		return ret;
> >
> > +	nor->spi->flags |=3D SPI_XFER_SET_DDR;
> >  	buf =3D SPINOR_MT_OCT_DTR;
> >  	op =3D (struct spi_mem_op)
> >
> 	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_MT_WR_ANY_REG, 1),
> @@ -4404,8
> > +4405,13 @@ void spi_nor_set_fixups(struct spi_nor *nor)  #endif
> >
> >  #ifdef CONFIG_SPI_FLASH_MT35XU
> > -	if (!strcmp(nor->info->name, "mt35xu512aba"))
> > +	if (!strcmp(nor->info->name, "mt35xu512aba") ||
> > +	    !strcmp(nor->info->name, "mt35xl512aba") ||
> > +	    !strcmp(nor->info->name, "mt35xu01g") ||
> > +	    !strcmp(nor->info->name, "mt35xu02g")) {
> >  		nor->fixups =3D &mt35xu512aba_fixups;
> > +		return;
> > +	}
> >  #endif
> >
> >  #if CONFIG_IS_ENABLED(SPI_FLASH_MACRONIX)
> > diff --git a/include/spi.h b/include/spi.h index
> > 6944773b59..d7fef36662 100644
> > --- a/include/spi.h
> > +++ b/include/spi.h
> > @@ -164,6 +164,7 @@ struct spi_slave {
> >  #define SPI_XFER_U_PAGE		BIT(4)
> >  #define SPI_XFER_STACKED	BIT(5)
> >  #define SPI_XFER_LOWER		BIT(6)
> > +#define SPI_XFER_SET_DDR	BIT(7)
>=20
> Are we using this anywhere in the Controller driver ? What is the signifi=
cance of this
> flag, when we can send the DDR info through the ops.
Yes...we will be checking this=20
If (spi->flags & SPI_XFER_SET_DDR) && op->cmd.dtr) then=20
	setup the DDR mode in controller driver.

I need to send the controller change series.

Thanks
Venkatesh
>=20
> >
> >  	/*
> >  	 * Flag indicating that the spi-controller has multi chip select
> > --
> > 2.25.1
> >
> >
