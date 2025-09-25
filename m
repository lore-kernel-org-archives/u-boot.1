Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26AB0CAC5AE
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 02:38:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 631D883678;
	Thu, 25 Sep 2025 04:38:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="hY+MCvAT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12A8C8368E; Thu, 25 Sep 2025 04:38:44 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D977B80819
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 04:38:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i8KSBZFKQIHD48P43tkRoCJ4ObirZBCmjA7Zoh24DOgNs1Cw5zq0kKFkWXRmtXiOKANeoB0KK8Jun7Yevbp7xutC0Jl69DEsFOdxfY8NXMQqhTGCXyd1DzZD1BPv9dqsAhVcid32oOw9sTW3vlGDE9GtczLu6KoQJTwOA9B2yoeMhVFcMa/Q2sSKrKE7N9UPk1yHTRWi8fZ+Uh4MkB12P5PGwwy/NDeALlvBingHZPBtM6nsoIK8VayS7GnyHVicO61XyTNOsB1ZcgwbYqMWkIAsRULcZc9cRabAasMK9rTZtekvzaDQap48rrmKZwBHn27lE4hYCDt0luYptsuBVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4tSD8hv+P6IVnoyvEam6mL/uz1QaPXCsMHEeXs4182A=;
 b=rhFTajN8LoZLmjntbVG6EwqcwiE4WzFh5hpiCfArhZBMKStLRxI+W5QdTck59EGqBz/hMp7JNDaCFpU4hYGfBsB0JuoaHjm3Z2F5VH2jjZHJ/tbRIvbmXzBzQ+6FsawkOtqXprN6ZW9rM5XlOC0Epm6dGFmI9YiysFTYs0E+NhDF6D2IbUT7kkuvV7szQqX+YbPnWxrrb7W/eIqAScyRcNRRDtPG0ge1m9HnRzp8GMgpGZtFYkMNYHMe5oH4mP4PhRXWUcKi1GgG2vhhSPpytCoMT6RTIe0N6iGuNw+0e2Hu8f3BYBP53qGTcJbeP74WbJmFNDbnudFNcX80U6T80A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tSD8hv+P6IVnoyvEam6mL/uz1QaPXCsMHEeXs4182A=;
 b=hY+MCvATuQBrQx1sf4ca9GPareTEEIHN8XiBhzg51jxIiWr9cOuXaFvyEc1ifc6UMQXGkXEX5wpMT9+44bOeGMDLzegoE0wIUQl62V7jeTYPxl2ZLnY/UR1U3ua/876N7EDb+WwPeQE4lFLtuvUXWPkRD0DUobuIsD0oqe0TuJyKj6rI6b8sxL4VwJwPfjC4qjXfdRTgdDNhoHphLe1QBbMwYnSslZ0IZiHP1wjPzBHzZu2RbNtj1qTooP1S87yx4lOGxqYGJmVRF9gomP44ZEWqJsQnYPAVcDJ2cAUbU0lFMK2qPlix87iI87riV/XcBPi9mcyRStO5mkTqBtt1Gw==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SJ2PR03MB7497.namprd03.prod.outlook.com (2603:10b6:a03:566::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 02:38:38 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 02:38:38 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marek.vasut@mailbox.org>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH v4 1/4] arch: arm: dts: Enable USB3.1 for Agilex5
Thread-Topic: [PATCH v4 1/4] arch: arm: dts: Enable USB3.1 for Agilex5
Thread-Index: AQHcLSfY41En1u0Vj0C7rZjLpOctebSjMDMg
Date: Thu, 25 Sep 2025 02:38:38 +0000
Message-ID: <LV8PR03MB81372A8AA90F08FE1CDD5E25A71FA@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250924074911.15538-1-nareshkumar.ravulapalli@altera.com>
 <20250924074911.15538-2-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250924074911.15538-2-nareshkumar.ravulapalli@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|SJ2PR03MB7497:EE_
x-ms-office365-filtering-correlation-id: b3a808a3-e57d-43c9-44ec-08ddfbdca1c0
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?7V93t6QJY/Etpz2pN6U5TLPdlKyrs7owajVbXaU4zN1kkkyBurJPmZSjBL/W?=
 =?us-ascii?Q?Nac97U/2oHRm87nf0RRpVZB9FKi+ZWmHz4EQ4i346Awk6feFZ8tjJUBKLq/o?=
 =?us-ascii?Q?HeEvcWMQgkC134G8GlCLj60u0Pu1mDqotAO/i9xZFI1q6+OwY0sboZmn0PA1?=
 =?us-ascii?Q?a7ZjH+ly60aSxN75i6Xo/qxSK1I/SZWNRwagk4K473brPgEyEyYgmLb0CYvP?=
 =?us-ascii?Q?5D9WrsT2VZhTEhXnfvy/NLQ2dT3w4VdGeuCm0H1jqQtcaZ49wZGakf17gLxZ?=
 =?us-ascii?Q?bID+jMFKt4kamwWQKDScxFmSkDqFm5t5PwLYIbA1pQEh7JEAyo6/u6itAwEA?=
 =?us-ascii?Q?JIa4viXXYo6vcFEMxRs5mW4xUIi8bQv+Hpr1Vu2GJD4q1EpceXBvS7oB2RDR?=
 =?us-ascii?Q?kgVNDpZDE51waC/3JU6akrTqgrlaFhmoMk8yVFF/vKw6En8nohzCrKNC3xH2?=
 =?us-ascii?Q?D6lprB7HbvrNYKcjzAqV0Qi5hyrI2IsJ1QSStjshTs0MBr6DUlm7uJV9Xgws?=
 =?us-ascii?Q?9WJ6BX7ZKdZwI/EN957IaWTdJ8JVgm0nPk2qt3sJXMMvBjqIR5WU0LtTBZvu?=
 =?us-ascii?Q?PIjXF3jt56pRBkaPG2m5T9jWn3EbWmDlwPNif0X/yqkgy5mXgC3+54Yi8jrK?=
 =?us-ascii?Q?02t2cSpFnuwB0AURtkV8lsCrdm13N6gjD9Oz/FOkQsy45ZtjPzqghmZF+HPR?=
 =?us-ascii?Q?Zuza++2hmlACVxHqseq/4BRU8ZMlI9PKyiRdjqOZ2sThnkWYt+d8hfC/Gf7A?=
 =?us-ascii?Q?Y6Wv3sS/5xIPxkNuquOqhfBeGS951r2+Av/i0sPoZi3QW4hlEysBcG5UT6PU?=
 =?us-ascii?Q?QQNusb6OdWySP6MN8kDV17XdlYXuAngUSWrqoP9fAVwuVs5LFQkoLBCy9gRT?=
 =?us-ascii?Q?he6QhDSgGz+SpFg0WesoCC1KWAUJ0/fUP+TV16GeEQDmEYs6F5TroFT0js0u?=
 =?us-ascii?Q?1XxvEnQpmDimYeb29zNxUbK8OINFQ5xPHcHhAEUWUhr3JdvxedCL1K7VadZS?=
 =?us-ascii?Q?G/w0wB4mBFclXS9HZ4bQXQ5GzmKFcJwI/X8BtvLD/cPPwDlBB3IMaKKZ1O8u?=
 =?us-ascii?Q?cv40GQDWJpAzaFjGismUdUYEfRzdw3W0EtgD7kGUPlLkWED8Q65lm1JyrVGQ?=
 =?us-ascii?Q?gb/HEEZBrXHAWkYkbZQi3SGqfQIsNDeITMQp+P0T5fkAseEqVs7V1BhYWCMZ?=
 =?us-ascii?Q?X3pX9K0VszlH/jgm9m8EWrEd9qDjQvcX8SawndgVBX7hWAiZxWVc9I9tYfrX?=
 =?us-ascii?Q?jKTFKGTp/jWUWMIqQ53k4qarOfkv4dh6hxx5KXSQJsaqS+bhtcTWMoyx1h7E?=
 =?us-ascii?Q?lgr1Wxebz/M0nJCOVoAT44NnbR+Mfd1Dqbk5ZwMnUo6rvF63OUWY78BIDryM?=
 =?us-ascii?Q?nJWGARE4lb4mRJrUOAXXiTTh3HMXv7p4G7P+N3+N+xWeKMiiExxpDYenmV+W?=
 =?us-ascii?Q?Y3cQp1Ww7EneNtgyc5bo5EbOU6MV1rbO1mbEeeacrdoLMUlYVkp35gTsKgP5?=
 =?us-ascii?Q?QV18BywDign6kLk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SvPxdleRaOg0kCqzfTYBq2H2yRnqwG8r/JDY2YaNnQgzE0YIfJV1XBSI9lJ6?=
 =?us-ascii?Q?IvWybVZO1t0laR2QmnAMfQJytNhRKWbbBIcMM16KKyopvt42QdA8psA9O2u4?=
 =?us-ascii?Q?/Svr8PbkQHtwqOUmlzqn2D93w3YS6rMlSustnKCyfzURxzbpFFGJ2AWVy59l?=
 =?us-ascii?Q?Yr1D7vOi5FXgA7j4w/hd8wStYLWhaCvK7IoFDjqszKYeDivAzKUbF702cgtg?=
 =?us-ascii?Q?f+zcGY2Q0M8zbLlpRxS8JHGA3aLH3wmNpZFBNKh2df9g7J1NZBMowVaijamK?=
 =?us-ascii?Q?Ela+pDrZcuR2cyT1FTPVtU0Wf3jEsyRbAxCKK+R/KYDN/7TjN19YlJUczZI+?=
 =?us-ascii?Q?A2eEEbhs4vSCikJpPTnxbOpaoumGk3HUGAdxPEssm95bB93L8jE0z0WWTm01?=
 =?us-ascii?Q?FUoC5xKTjxw07IgN8+lgPzYsC+fQNvARhejETwk97k9Z5Y1p38QKCe4u7xve?=
 =?us-ascii?Q?7t5eNVLHu5oiOPFC3IiYTvhIOP/G/N1sPnxHVQ6ukeu7J6RSA0Wh3WHrVPRH?=
 =?us-ascii?Q?liZ4+pgpxACVntkDvykQRBub7J8+FTcza7APZQuYfxEHHMksexUZt6eH7d4z?=
 =?us-ascii?Q?sZj0Y9VtKno4kv80xYCnYwPuHhAcZtpVGIyVi+U/sgtEwUSoT/NEMSNlUsSY?=
 =?us-ascii?Q?AF2xgW2YUC9vDEHLd7QYk8Twk9weRDImwdJ+qTzv+FcNLQB0L8cHd4tylZKv?=
 =?us-ascii?Q?i9o613U7ydDae+18gIbxcCdqQQicATkV1pt+k49LgJt4Lrpzoxv8lFdi8mKZ?=
 =?us-ascii?Q?vpYF+bQIAR5ud34x/zACWiW1pidggFQBDhW7S8DWxAaPiLQWPXgRziDF/LYP?=
 =?us-ascii?Q?XeiIh3oh1tHquFKwmSL6YB99hPKzWDeqpXOA7JNgnYN9+AkWIZxOYn1fEmU0?=
 =?us-ascii?Q?Bz+GjP0GIvW46bCOml91OexF/qYd3kwiM2UADK0WzvqwKE/twEwfCqKqHVOz?=
 =?us-ascii?Q?gwuMSNJi18iYJrmRfKF8hFepG/xgR76BdLHLNH0BuRI+CdvGEBXyQCNHJeM7?=
 =?us-ascii?Q?j1/nBBpwunWRbqh22uOraCMRDj86SgPYEF/Tbx9aDkwMCLtnCoylHRySLcDt?=
 =?us-ascii?Q?WDP6xptuAlwCY7l0XHfYXBkR50GEgcS7zaZ8TS4fCfQ3WvRxUZVIIjz8a/x9?=
 =?us-ascii?Q?hToSfoOYQ4ZAvLTO9Xw5FYQ0d+Bz0jtiQ8AkNddUfySgMGpTmgEjuboWsMGr?=
 =?us-ascii?Q?axOEuiFEbgVzZCJ8g8asyQ+jY6uv2lOQtzdqQaNvIcHmmSMf94hX05Lx3F/j?=
 =?us-ascii?Q?PTXYNWHwg09Mhuz92KC7xNLfsIQQtphZgZgPI1B+CfmELWk8DgPPP7wbq41x?=
 =?us-ascii?Q?/zHa7QXI0zru6fbaM9Jw7ay5dReAkWYDnLSNNewhJ1Cj/aoMIdagB0nPPkXt?=
 =?us-ascii?Q?mU4IwHBJSbVZoMeH/YxWYQ+EGSyaPANeq/t0JLPHFn/nTWxQYu3CK3QnTmH0?=
 =?us-ascii?Q?0oOskf369KWoWlMjZ4/9ZfmYLLVMsomIg9LyzQmSYHFS+LJqVPTEosM9BKB5?=
 =?us-ascii?Q?c3HlbD0IKu5PSTGIDb3P9niwobHEv4MavAY+LtF6XFEWhlON5K/gTxni177I?=
 =?us-ascii?Q?bEEqwkoTAnJeYk0EU7VGnn9sudHjD5QuzfftnbkL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a808a3-e57d-43c9-44ec-08ddfbdca1c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 02:38:38.1154 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YblQjNGrxw/JERELJj2WYF/HhdHRF0SJy5q0dIKXQk+6KCTfGOB4zW9JGt4qByfgV97shtwuUbuHmSeymZvRMha09+5wBIgH4vwf3+NS4Ko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7497
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
> From: Ravulapalli, Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Sent: Wednesday, 24 September, 2025 3:49 PM
> To: u-boot@lists.denx.de
> Cc: Chee, Tien Fong <tien.fong.chee@altera.com>; Marek Vasut
> <marek.vasut@mailbox.org>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Tom Rini <trini@konsulko.com>;
> Ravulapalli, Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Subject: [PATCH v4 1/4] arch: arm: dts: Enable USB3.1 for Agilex5
>=20
> USB 3.1 node is enabled for Agilex5.
>=20
> Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.c=
om>
> ---
>  arch/arm/dts/socfpga_agilex5_socdk.dts | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/arch/arm/dts/socfpga_agilex5_socdk.dts
> b/arch/arm/dts/socfpga_agilex5_socdk.dts
> index 2ab143e38f8..886cc89fdb6 100644
> --- a/arch/arm/dts/socfpga_agilex5_socdk.dts
> +++ b/arch/arm/dts/socfpga_agilex5_socdk.dts
> @@ -87,6 +87,10 @@
>  	disable-over-current;
>  };
>=20
> +&usb31 {
> +	status =3D "okay";
> +};
> +
>  &watchdog0 {
>  	status =3D "okay";
>  };
> --
> 2.35.3

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

