Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 266EBC02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 13:15:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E132807C0;
	Wed,  5 Feb 2025 14:15:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FE38801F5; Wed,  5 Feb 2025 04:20:29 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on20720.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::720])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B97180087
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 04:20:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JstZneHJeuWvNnIIyo3Pb7jc+SVz5kY0uK9ODF03pEsad3bG2SQUd6PCkS95ckYI3ExMvClvl5qC/Dph5D1bIqH0eGKGxI8hg0fhFIYyewooJhc1ew1nSURiwQApsSO2ylpcPvDrPdGbZEJHvHLBxcvMhVO94TEjB5JhdPDy6BoxU/qVL7JlyMDmrg+ACi+CW92SyRFjBq+T46gMlpf+81NL7dA9OGCNXp1sD//ZLY7lsmzG6apDlJ/N29eJBjfwTKK9R1RBYRc/6/3P1szzy+LGWimCcsCHJpUgzp9hOznP6Kuqzbmv+apf/WoCTatf3yB7FBKiF6KSY4kv9wpFlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XfNUBGMZWIsgK7Or8nhbH0O5moaorX3y4rcsfqS0QW8=;
 b=MvoJpwS4SJ8sSX+2SI5Az5qH660QiP95OdbL6fk7VMtWz7hDdFCqEbuKQ8bIGQ7y7UgLdfij+lMzDMw2VjAOl1/+I4mwGdIOncjVdflw3nVEl6z6K2CIJlPQ/6Oit2rq/lOShh0y+vSsISLaUnMZp6iwAr+KPpNxhgpSVjRyC8/Gc4cnmVeJu4M0h44YQND76HEXBVPXnxNKw68KsmZWbNvRTRp3LS1nhMsC/AEAFHIKkTiJMrwXWm7gFN7NruLxTmtmsbehfC2FURDl7YUatyqME4+HeVMLBHXcFbUrDxInsD+3e739KMpW1KVHcqQZrj0+BR+UeEcu0S6kbo8m7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1147.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.14; Wed, 5 Feb
 2025 03:20:18 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%3]) with mapi id 15.20.8398.013; Wed, 5 Feb 2025
 03:20:17 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Tom Rini <trini@konsulko.com>
CC: Leo Yu-Chi Liang <ycliang@andestech.com>, Sumit Garg
 <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>, Minda Chen
 <minda.chen@starfivetech.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH v1] board: starfive: Update the maintainer file for
 VisionFive 2 board
Thread-Topic: [PATCH v1] board: starfive: Update the maintainer file for
 VisionFive 2 board
Thread-Index: AQHbcJb/jiDCAkIga028XGUHmXx967MqzAwAgA1G7GA=
Date: Wed, 5 Feb 2025 03:20:17 +0000
Message-ID: <ZQ2PR01MB1307BA9B9B1CAF15C3731FE3E6F7A@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20250127083814.67839-1-hal.feng@starfivetech.com>
 <20250127161500.GF1233568@bill-the-cat>
In-Reply-To: <20250127161500.GF1233568@bill-the-cat>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1147:EE_
x-ms-office365-filtering-correlation-id: 6185ef6c-a912-4997-a94f-08dd459403e9
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|41320700013|38070700018; 
x-microsoft-antispam-message-info: od26iuIHUdBVvPuH8POkq9EIZoYAMNziVruS3YNArzlCy82jXwCoyM0DJxruyusZnbZ+tQ0EYTzCi8m+7ZAmfIW8Cp0yTKW5kmZIfD/KQLyPHHZrzK2uK+6pOzJLX174EZAdnnqPjmS7y7QyNvMwHMZuKV6bdNQAG9BgiKmOPTZ7YcQefEWHkJH7Rx28DKcXlNOJ6P6/yqc9pc5/1vOzNAMgHy3HEu1hiXlc6J4yM4mW2wmgQ12tnZShLBCmf3mwC+mZ7VVy0GP7reP3Z6Bzhsum8qaG7rld3MbDH1WUTr4BF+FVGb8ctxoumGsa91lri31a3lOm82SgUFYlRoowRzdk2tbSmDlNK0mUQM1UNts+wQKRD2nBMstPj9EOGwwZXjFmUH1U2GFsL5qB5ymUTzH5y7LfCGTtWHfbCmiIEDRC7/BEpgBKuUX5gq8XTn1By+apCzvvRhU6RJI22U9BwQNVwd4Jl0/j42denUhAVoj3KqNVX9rtPWtKiot1JlX2GhFWn6xr99irZ4iFOrXQoS1J7d2YQQPssLdBL7/6dC9JXytvqSIohqBk5XmAP/ZbJcMBd//3+FWQ6xH3XK9fYr7S847G8MkwBmerpI7zpC0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(41320700013)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vKu3AmKvqKjTGicXkhdBZpPXihhuoG+gH5Y3GSiFX11NKOH6tySqBHnyM9CO?=
 =?us-ascii?Q?9lvElSEEG0eRtG2kz2h5AWoDWk07ff763dlev/Pkt3tPDSI5MUlE6YRoTMEA?=
 =?us-ascii?Q?Ni93dbtyB5AvWkTCmc0s8kskKMMq3PvLw68c2CDvrrWExI044KDs7aIDfBAB?=
 =?us-ascii?Q?fnGC7Y6zj2BujkS2G8C5cyYvsfvlIu++HGX6F+Dd0FfucFMtHMmqgZBsGgjj?=
 =?us-ascii?Q?Ed79Q1+g4mOOCAuUuZyy9s/Uv8wyl1fN5BUkEKEKqpxq3bVNdFQCTX0T/QTG?=
 =?us-ascii?Q?pfNjaWX2SBwEqSicIzgzT/8veWC2NmwYbHJf+Or7F/RRKYZErFUWjUtEeUYx?=
 =?us-ascii?Q?VrFVRxBFi/idIrolaSeZW5EQCp1WVEGwnn7fu6xr+C9yIZbBPy3BoczQv/Pe?=
 =?us-ascii?Q?Hhy7ErKbgnc5U4uz6TxTZ+a5VzXUE+f9xAVscajKH+jcgjzZqKSZL8H/SQOC?=
 =?us-ascii?Q?g1JBqYEOtmNUTdmVZudP8MrNtnRLoSB/pxhVUU+ErICl922Tcn8LTvf/CkAk?=
 =?us-ascii?Q?BccM7ciWBb3p+NlASwjLi/UI5JHtcYJsJm8Tfh9SHNlsvWhRZPo63JEb+9Ny?=
 =?us-ascii?Q?KRStsoy5MWK9ma2+OehcRDmB36Gw3FW6W7FTNwLz5ka0vGrMNvypj3+ZNDnN?=
 =?us-ascii?Q?x4mLc8/DrZ5nBrs3e5fcb79Cmrd539dH/AZ6x+mcJ7zexXWGGRvKfKKr12HR?=
 =?us-ascii?Q?Ta1ZTxasMY8gxNfOmdTpomzCOkfZEkjwf6n2Bj7u1RZxLvbG/86cXaFlHLRs?=
 =?us-ascii?Q?LP3Gmp1vOmfUzIa8WrXmu/7nbvBRhtP60Jp579uOx27QxyWxMQpEj02lzCno?=
 =?us-ascii?Q?HzaOt137NhRk7qEH37o6O3rXk/jX6Em4N4gBpod5kNZP/8cYjLXqBIY/6dgx?=
 =?us-ascii?Q?jnWoB9ln2G6fIYIbJcvQXIZEb4UMsFOfghrwvVrA4v/N4ZtcfJ2xX+BvJ+xs?=
 =?us-ascii?Q?K3lBDxhqFADXgbwGtC1S3/ZsEJVxjynMcpLVUY4fZftckJZGLenLi+PW6JTD?=
 =?us-ascii?Q?bFwrwiePDQhYwLD7XqdIX1/2N0K2Sdfd4PBtOdHCznMHfjF+iesGXy8dgA+t?=
 =?us-ascii?Q?1LIyM77oFdE7U1zDEoGTC3cMO5S4QRqSgXN/Htqkj+oERRx4zPsoMbT1OVzg?=
 =?us-ascii?Q?4jNYySeqSl0p8kfibh8LZr8j4hY5yivtJHYbYnEBDy8j3YwKgpj1xWT8MGnS?=
 =?us-ascii?Q?DcoBh6FJciI0C3IvV3waV3PYy113JuMKri3JsGliirj0ZjF1T3HLRJdu9QgD?=
 =?us-ascii?Q?8KzW7pOxZ48q/G+ZELzyXP2r3k+SFRF6Gq++sAejtf21OoXi5yHfdiYbTxr1?=
 =?us-ascii?Q?CSr/nMWptrxX5Mz5YjrFPQ+m+LXwwx07H7SClR5GA3ShXcnojsrVRUTVURs1?=
 =?us-ascii?Q?D5jiRFeRzdBZ9bAWTGGPxaiCx6kObaBJ+7Epc/ZKGGAoMFFyN59BLRGB4VCK?=
 =?us-ascii?Q?Z0BusjCV9HuYmsGOheXMSsyXuIq9TwdNOiNZJP7wqGciyYKQP/oyMDPc8SXY?=
 =?us-ascii?Q?nXGt/SDtb9ee4edXDItSxtw1KOZiFAf0MbClTmNIif1YK00Udt+6q5QzXWBc?=
 =?us-ascii?Q?CH+voB9xo+xRFDYxoopn8U17kcLkRGZ+kt9VzKER?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 6185ef6c-a912-4997-a94f-08dd459403e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 03:20:17.8964 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bC5TsuC9MPKX3blaH7+B5JHjHrsrP8fCgbNY2ObNm7uuXexueOtNsnR87Q2uq0tBhb1he1sEY23wLS/JgkMJ9fc2luAT28l0fohdriWstqY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1147
X-Mailman-Approved-At: Wed, 05 Feb 2025 14:15:26 +0100
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

> On 28.01.25 00:15, Tom Rini wrote:
> On Mon, Jan 27, 2025 at 04:38:14PM +0800, Hal Feng wrote:
> > Update maintainers for StarFive VisionFive 2 board and add the missing
> > drivers to the file list.
> >
> > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> > ---
> >  board/starfive/visionfive2/MAINTAINERS | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/board/starfive/visionfive2/MAINTAINERS
> > b/board/starfive/visionfive2/MAINTAINERS
> > index d7f638f9b41..14fe8368548 100644
> > --- a/board/starfive/visionfive2/MAINTAINERS
> > +++ b/board/starfive/visionfive2/MAINTAINERS
> > @@ -1,8 +1,16 @@
> >  STARFIVE JH7110 VISIONFIVE2 BOARD
> >  M:	Minda Chen <minda.chen@starfivetech.com>
> > +M:	Hal Feng <hal.feng@starfivetech.com>
> >  S:	Maintained
> > +F:	arch/riscv/cpu/jh7110/
> > +F:	arch/riscv/dts/jh7110*
> >  F:	arch/riscv/include/asm/arch-jh7110/
> >  F:	board/starfive/visionfive2/
> > +F:	doc/board/starfive/visionfive2.rst
> >  F:	include/configs/starfive-visionfive2.h
> >  F:	configs/starfive_visionfive2_defconfig
> > +F:	drivers/clk/starfive/clk-jh7110*
> >  F:	drivers/pci/pcie_starfive_jh7110.c
> > +F:	drivers/pinctrl/starfive/pinctrl-jh7110*
> > +F:	drivers/ram/starfive/
> > +F:	drivers/reset/reset-jh7110.c
>=20
> This would be a good place to do something like:
> N:	jh7110
>=20
> As that will catch all files/directories with jh7110 in their name.

Will modify accordingly in v2. Thanks.

Best regards,
Hal
