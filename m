Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA2B8D2CE01
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 16:49:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B6DD88FD6;
	Tue, 22 Oct 2024 18:49:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys.com header.i=@timesys.com header.b="XK5bEWm0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D09287F19; Tue, 22 Oct 2024 18:49:56 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::72f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6C0588FF1
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 18:49:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x9sJN46T6C0qaVMUb6gldPaOX0QeQzLm7UIOFLD2UnL6VU5H2hpqoJfXZpA2yTbOHXfaqpSTzgFPYOcRSwCgeRgKz6bkMHq0mQpCOEV67nyq4XYJch8o6j7yzYM/+vw39hIkm8XxJFSsGezEIDMi7SgkTlzTsJSJu5GLbg7IQ4HX3G9wnwACnJaFvybtWFlBIUj0Cycy+BjyIlHblJrFmx/a1P3R83wzdq/g8CfONkfPrSVuHQLyiz2lDTcQx6UYZURDggSP19Ol1pCUxbupabxfko8lGLzYVuUFy00YgB78KDFyKoTI1mKUNrVwOqOI9D5KFgI6pf9LLyT7szHtSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zpQui77yb0x9h8+YRM0cH/ERUx3ILCz7SaOyVfsAwME=;
 b=m/HPALFUs6Z9JEQ7fPO2bHZeY2soqCTQ8RDAwtf5aplajaB/BCxRh9H8ojk+Bp4bM2J6nDkXzJaliA4MKYbyMQ8hxfCi6RMbj/7/hbzUwnVJhFb4WZALgU5JNKio1jXaC5eTqx99OL7juffaIwG6xhU+me5pl3pFVaoQrE+XgoNdur8jQCtCoNIRjII+XLxJfSV5jyayu7TG2dTlOMvZBUMRSLzFF/5asvEbcntVlekHACe3sZzKk/cMY20rfIWhU2YKcYR2EoUfe+cjvJGuB2iS2dMDaZzf6Hvunc7vWFIRP+cYf24ZEQ/FC7Em3mGuOj6JxJUIUSVmEJ4smxKpGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=timesys.com; dmarc=pass action=none header.from=timesys.com;
 dkim=pass header.d=timesys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=timesys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpQui77yb0x9h8+YRM0cH/ERUx3ILCz7SaOyVfsAwME=;
 b=XK5bEWm0LAFgNxSoJ31sGUKTNLAaXnABAO7xHMFkqPbflN2VuPWIkGfIPBIjv3zS6sh4jxM61sqwaAde5zfCFlszALHEil6V9YthTEor7ajl+QLQ31I1pn2dIose3c/xBF5JFo/G2bHkAdk0ZaPcEEaVALYOFsZ30bhGDXNUcwZ+25epgRKBkUEorefWNfJA5Iw99neS4twP7fV+EPJtLPe/OZGiC7Bw3z47aq3XIgH6ISuQczirP8WkdgVZo9CJRZvyjp+HRlXq5u1tW62YmtREl7kLM7ZgVuJ/2vjGpOuwf4N4bGlObyk4sYPmoZSCrZudH0eaejwnyCYROw809g==
Received: from CO1PR17MB5372.namprd17.prod.outlook.com (2603:10b6:303:eb::22)
 by CH2PR17MB3974.namprd17.prod.outlook.com (2603:10b6:610:8e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Tue, 22 Oct
 2024 16:49:48 +0000
Received: from CO1PR17MB5372.namprd17.prod.outlook.com
 ([fe80::9f95:3f9e:80c1:a96c]) by CO1PR17MB5372.namprd17.prod.outlook.com
 ([fe80::9f95:3f9e:80c1:a96c%7]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 16:49:45 +0000
From: Greg Malysa <greg.malysa@timesys.com>
To: Tom Rini <trini@konsulko.com>, Nathan Morrison
 <nathan.morrison@timesys.com>, Ian Roberts <ian.roberts@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, Utsav Agarwal
 <utsav.agarwal@analog.com>, Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Marek Vasut <marex@denx.de>, Heiko Schocher <hs@denx.de>, Joe Hershberger
 <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, Stefan Roese
 <sr@denx.de>, Jagan Teki <jagan@amarulasolutions.com>, Peng Fan
 <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "adsp-linux@analog.com"
 <adsp-linux@analog.com>, Oliver Gaskell <Oliver.Gaskell@analog.com>, Angelo
 Dureghello <angelo.dureghello@timesys.com>, Piotr Wojtaszczyk
 <piotr.wojtaszczyk@timesys.com>
Subject: Re: [PATCH v2 10/11] spi: Add support for ADI SC5XX-family processor
 SPI peripherals
Thread-Topic: [PATCH v2 10/11] spi: Add support for ADI SC5XX-family processor
 SPI peripherals
Thread-Index: AQHbI8D5JVklZWZwwEmJINtEbBE9wrKS/Eat
Date: Tue, 22 Oct 2024 16:49:45 +0000
Message-ID: <CO1PR17MB5372901289D50EA5B21BFD16EB4C2@CO1PR17MB5372.namprd17.prod.outlook.com>
References: <20241021-sc5xx-driver-series-v2-0-53e2472e11d0@analog.com>
 <20241021-sc5xx-driver-series-v2-10-53e2472e11d0@analog.com>
In-Reply-To: <20241021-sc5xx-driver-series-v2-10-53e2472e11d0@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=timesys.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR17MB5372:EE_|CH2PR17MB3974:EE_
x-ms-office365-filtering-correlation-id: 1d1a8dac-151c-47c8-12ba-08dcf2b9888a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|366016|7416014|376014|1800799024|921020|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?+WvX0/ywxhF5H/dzj/RE769Tr3YnHAm9MCBdkOcnDDT2oxrX2XFEfM1r7v?=
 =?iso-8859-1?Q?1z86q3soOxHVhGVaxfKqKlatgX54q5W+eHih03NSFN51+oZoSVYA49+PWi?=
 =?iso-8859-1?Q?5HkYRH/AcwqwNko2ZM4Jr7cLFIKbl2WRJp2OeRd+fWuSpgzPatlAai5bPI?=
 =?iso-8859-1?Q?w5QkAUZRAZdVe4Loz+IKMi0Rophht4w804CTvAAJi24wESgWB7HR21Qvr+?=
 =?iso-8859-1?Q?zKg2Vm+QyjO+UG2qOwDHPO3N5l3CTrNShnOi4YPONkkf6YcvWe/4ABXgOi?=
 =?iso-8859-1?Q?c4Z/GZjl8ymkjLdECFQut2Xa0kLmnwctDSRss114Kht7Kkr3Zcrhuoe4Oz?=
 =?iso-8859-1?Q?6n5mhiYS/1uDyHasq5x46anA2gl+iF1lkcU8KeNn/UVhSKOZSv0JJ9luj1?=
 =?iso-8859-1?Q?k34U8aRxs3QbBWo8XYFj72v1yiht4/NH7Gyw15iJHADQ0fAYGFKB+48EuX?=
 =?iso-8859-1?Q?Pw6lm6JOUHHeIvPn4+HKtsKVkWOAn6cLaBJcjf9QFk6WjbvuneX2DCIUPf?=
 =?iso-8859-1?Q?48KByjsgZgZgROIJ1kCPKZfYeuvRTgEbogM5wCY4IDbHCDEaeWRnUPvl2u?=
 =?iso-8859-1?Q?nLM2ZlV9szwoJ0z9Fay8dH6qQ1FKs61lxCE1FcQcewZtiYG3BP3HDtdEi7?=
 =?iso-8859-1?Q?YR6Rl9ALNbRyuGxmgYiYxGOOPoQu357+97GNj5eKuw2mudWEjXnFCQ3x/4?=
 =?iso-8859-1?Q?wmxI9mgCrgn7WVAXLb9zLTNy16S0yJioEySTV/Ykmo1ChG0T//bu5kIIjn?=
 =?iso-8859-1?Q?LQ1DwDW5YKGQEKiK0LOcL1mIWcxOx8g2cZaGC0EjQF0KaIPirIM6Ikhy92?=
 =?iso-8859-1?Q?/leTj1FstQDmxxy2cj1c6l3F8h6AJBn4MwkoaVIL5gtaq3njzkJu3KUlig?=
 =?iso-8859-1?Q?SJhWxTdZ3/a9HSh6nJEyRpE3ckW2lSx1bn3b7Lr1O9dE/UKN/T6q8y5fCB?=
 =?iso-8859-1?Q?vIUJOnjqOzDixZNMPnpWu0ilMJE1kagXvg53lHrdXYbwJytaTdXs52+nHD?=
 =?iso-8859-1?Q?9lmYXhm6f8YGTmIc/01wl0c3iRojSyVARZFY6UHlTJPbmIPUgcmG8UbJpo?=
 =?iso-8859-1?Q?n89v48d1WSRwaeWRT/6QxTndYJPgwl36RlBlVH2O2nC5xc4sGxbGK/KbNj?=
 =?iso-8859-1?Q?SXrpjmdgk5GMKVbP4ZbSiHtHnkzUMEwSemx9ls79KhVsnqc9mKtUI97Jns?=
 =?iso-8859-1?Q?hWcjNxLW3JZK6nfZxvWjQ7lo7m+s2sfJ3xapWfxqW4B/sSX1ITR47o9jtq?=
 =?iso-8859-1?Q?lhnvU3GG0MByCeewcdQ64zfiYYsg6WTrJIycjSKYaj4S1yWsJOaG/s3S2i?=
 =?iso-8859-1?Q?OGUwL4RfNWnkMXUNyH0f/0Fi0K69vq3tIjCvIJV855pFB4n9FO+vdAQxvP?=
 =?iso-8859-1?Q?fEhn0pAuwLeucuPZWxIuwEE6fek86DjZE+bwbQrLq4W458lePlsr3eUKLi?=
 =?iso-8859-1?Q?b2xt2UvG+IC8q2DGNg51OYTW+CsN3mXVpGXEPQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR17MB5372.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(7416014)(376014)(1800799024)(921020)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Kz5Hm474FZkqqnZOcVYlp+2xASRt84NdWi/2dopTCn5E/M4XGKxRvE0Rzi?=
 =?iso-8859-1?Q?FDqdxQFW6N/s5+ATuf2HiDGRky8+MUkLptxVFjfh5Ibh4s5C+XizOjKMfz?=
 =?iso-8859-1?Q?QEKCfsy01WOabnSQ5LGoVX6M4fj0Px2A+aSEAMMu4IcLUDKDWwVU1Zasuf?=
 =?iso-8859-1?Q?jBWCyZ7prNgvB63QaSrsZXz492e+eqaxxQD/f13vZteXYJ2nJOVtWqYtd/?=
 =?iso-8859-1?Q?U4bmC0HmftMX5+ySLjkwCYYr5VoM0GIzhcwlZj9wfsIBR3UFzbFXPKSaOb?=
 =?iso-8859-1?Q?JdkyyHhT/lGVvrUaacaPPA2A8D+VDoWyM0akbCPX80JJogWuezrI35IJcc?=
 =?iso-8859-1?Q?xgpl2QIjsvsyvA0T+KPWTml5WiXWyhWb6fGfrJMG86mD4bAHI6WdFyaIDM?=
 =?iso-8859-1?Q?3WehcvdBh8myaR1FaJL6VEnk98BWCepKOsPvV4sTPgMp/LUi7FE3UrPIGP?=
 =?iso-8859-1?Q?bz7jEBH1/BfEiW5pNrKZOyJV34bjFoFnGTNi1YGytPCk+wnLgBkGrhIXwW?=
 =?iso-8859-1?Q?nQxWJv1AVzOHBBEN5itubKnrUjC7LIxs0xBSNjR/sBp8LH+rjo4Ehhey5W?=
 =?iso-8859-1?Q?Af9wTmQXhG9zWLKrgpBSip42RM2+KR0iuPRu0aCVtm8ztnFzLKYxVbajbT?=
 =?iso-8859-1?Q?p781Njiwx/TetQReBNEyGlaUnWdBdkTrQIoaNVYG3n8nG0LGfnbSixAgyD?=
 =?iso-8859-1?Q?B0GlZMMVwjUhTSym5zd3LNbjGE8kUl7KIawCcq4V3f9Ii/byy6YAaTCHj2?=
 =?iso-8859-1?Q?PYnl5TkiuEKwBIGbIbh7PdXe655koUd/hjwt0Rq9W3rYvuL+0JNpdbotOW?=
 =?iso-8859-1?Q?XTmHZo1Jt8M6+XAZLGyuYJatgylmfIQIE9lbOp2Er3m1RSgosl6He1guSK?=
 =?iso-8859-1?Q?GW9w2q6Ovs5MS4BqjRvLJUx1FCRd2Bsfy3UPTvl4kmr8ojzoD1hu8sbt1v?=
 =?iso-8859-1?Q?9w6MuJCH7GPEw0plIyENOZ6eKOQGqh4TyTu4LM6fc9Mv/FPSJHr+wbWB4z?=
 =?iso-8859-1?Q?xHIfr/DypFdzzDKgaWg1jrlKMDvh2MKpHo4mUQUakr3iWCGt4rVAl55Lm0?=
 =?iso-8859-1?Q?rFSXHAXmZH+WKw8f99pTb1qjUEnkKXrm5LOPlUl88kGAJVBrLbZKn1av7V?=
 =?iso-8859-1?Q?OxFlCv2CriM4sV63x/rSzGm9db+RhHzLL8OnoeACs9gdgYP8y8PtPNeMJX?=
 =?iso-8859-1?Q?t3ojU7VguEltvhmLijbapSai06xOdscSrAZjZ1VSE7bz6c5TTv9CZeWZ/5?=
 =?iso-8859-1?Q?RVWNEwLUDi82PxX+39MmQDNJGtqn15oSH/syLBHg453HM1cZcQ5NQSRc+7?=
 =?iso-8859-1?Q?1wp+5OqrF6O54Y/M4VRkSeMei51QzjFoXzwCl/oHjy0NDYo/pwVyn/l1eq?=
 =?iso-8859-1?Q?+s6CHIPgqEmwxxa5/SLSWm0j9e7FE67IygBK0UsAeIEnZWmNHzdACF1syK?=
 =?iso-8859-1?Q?MTlCtqTKQwC9uTpuKnNH4j0sXJSK+jD8uadOb7aVQMP3YQvSdIX4hD5QpL?=
 =?iso-8859-1?Q?po/E91U6+Z4SycjDFKJaNiws9hAb3LIhOY0NiMoo2M7ZHWlWT3liDLzdkQ?=
 =?iso-8859-1?Q?/S4IFa+oAkzsB7NPxIUen4aTpGG64XBqq3gYvi0HP0mJku2qC8+BmhZ25u?=
 =?iso-8859-1?Q?UUACqRUxqOXJEHt2vSQ2pdUp1XbgVfJUp041u5Uh3xCurJG3Sr7EQOQCdx?=
 =?iso-8859-1?Q?J03aIhRnZ1AOyQx+lY+QAQIJ13ZwLcGVJCGifgvW?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: timesys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR17MB5372.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d1a8dac-151c-47c8-12ba-08dcf2b9888a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 16:49:45.3065 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bcd2f523-b055-4bea-b9ec-dc33b14bbaa1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CrUBVW5aVVMa+J6YLa3mVG14oA4mV7jg+rq3zIDgd6DEFyv/h33+zJWTKaKlTKrTWUeVUmtDaWHh8udn31JIPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR17MB3974
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

Hi Vas,=0A=
=0A=
Last time this series was submitted we received some good feedback from Chr=
istophe (https://patchwork.ozlabs.org/project/uboot/patch/20240515215837.14=
028-11-greg.malysa@timesys.com/), but I don't see the changes applied (or j=
ustifications for why they should not be applied). Let's get those issues a=
ddressed for v3. I can help with this in the coming weeks; I will reach out=
 to you separately to follow up.=0A=
=0A=
Thanks,=0A=
Greg=
