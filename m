Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF36BE7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 08:54:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D4A58005B;
	Mon, 16 Dec 2024 09:54:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="XbHEF2id";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7ECFD80104; Mon, 16 Dec 2024 09:54:40 +0100 (CET)
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c406::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8ACD8003E
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 09:54:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=biju.das.jz@bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qGJ6UStJeyMmVl1qGp4bnxmtISxoNghwm1ofDhdOKOS9OSokDQZjT8m3/zLH2QQH6DOxbu2TT0DMk9qaiHPQreIut4LuaFCyu0axe/mKknFa45EddJiz46yHf4U333UKKcs4921RPkaNVLPQeMJQ5NwA4KsvezpSZ55Ym93NrOYnE5kcxe+svMEq93854w3kBhLYZ0wmGPXvIwLgx9yOxS4oSs04yAn26U1g+oF0iFscg0qiy4Wga/fcW5zr+/c7dztQb6+aYMKj+rP6BEgr0ZA+244io7kxGyzoEBKuDNdT0f6ekwKVlhYgL8rx4fC7xYE9kzKfVZ8Ilf2aHlu8DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rivDu+Q08TUz+sOEJzsWS3umpOnSL6t+GfLV4kSn9oA=;
 b=tnrLunvKHxRSXyF5UpqFL9H3RNm8O1dHoGockIpQRKv/wCTsmkG1djqaZqbFZuna/7i92ATi0B+CBTB6N7x76X4+yX6BzQFBFkFvaQ+4SXPHIQLrng7ZuC3Z6kCQqfDCWaudqlwXP++JfJCFlBPuQss39MwW9Z9dCgwm4qbSJe6QT40+KEeLianCaovcwfRhi/f25W82xP1P4CYSDks3Dm/LxD1nRZzE9Jv3UbA8ZqOt6aJeP1NSNvvhq+/33HAhH9GgF7f660USw8gw9zeKEraayg4GQqOvGZikbjNV5PiueqFiVW0+d8p83eqtWTaQ4NIm4YWR78pRdh3lskjJGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rivDu+Q08TUz+sOEJzsWS3umpOnSL6t+GfLV4kSn9oA=;
 b=XbHEF2idgEUfgkQnMbJ7dFj+d6DEvaMCYlwgEP0et5flTXwmcEveycFf1KYEVjFqWOKJbg05obdLglvW63EEHIjd7Fop7302P1UyvmxrQZwIKMPtIv+SB1TcTXyeEXQ1i4EggbMnlgQ5jyQsueWVq1Lvax6yldPj3bVSZf2KVXg=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS7PR01MB11779.jpnprd01.prod.outlook.com (2603:1096:604:244::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 08:54:33 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%5]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 08:54:32 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Chris Paterson <Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini
 <trini@konsulko.com>
Subject: RE: [PATCH 1/3] arm64: Convert core type check macros into inline
 functions
Thread-Topic: [PATCH 1/3] arm64: Convert core type check macros into inline
 functions
Thread-Index: AQHbTnmwjG67vquKBUCMIHR6qTOggrLoku7A
Date: Mon, 16 Dec 2024 08:54:32 +0000
Message-ID: <TY3PR01MB1134681A786D500D575B1D2CE863B2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20241214224344.303452-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241214224344.303452-1-marek.vasut+renesas@mailbox.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS7PR01MB11779:EE_
x-ms-office365-filtering-correlation-id: ff9c6f89-b07a-4f58-1a9b-08dd1daf427b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?c82RQmrcChVS6zTt9fnW42yEEWSVOfnzufHB/ZecgnGhj1oRXX3rkwkiF7gj?=
 =?us-ascii?Q?rDpcn0YHiB/YiL1k/qRW/mAQMYJOyvXciIwXYjAA9T3tJucqg5psmsTfPlNe?=
 =?us-ascii?Q?I0T4wxRrXnjrPpBqX51OFBTJE7sZ/CnMO0B0IO29Aqw6fA7kIjKdnqgtOoJr?=
 =?us-ascii?Q?Go7f/+Z7IKdrI9z+Cm04c86CYzfgXJcLrJ4eBUGWSz76QdYflbF6/j1W4V7E?=
 =?us-ascii?Q?6wpF8K9Nej3yIVx5hGqXba/kfj3oLYHrl36OfFwaY3UP315aArjVAbSiWkkP?=
 =?us-ascii?Q?MwNOLagdDm14hbHI+dVts8jNIRsL7NHrrS7wwvSV8EBP07s3ZSUgnSlqW+5w?=
 =?us-ascii?Q?ytjqu526gWLiQlUXUJ4JzQ7UfEzP6tmL8Ltr8g+EeIxnUitOsbVUDkcf57NF?=
 =?us-ascii?Q?g5X3VQXQoe5pp1lBb9ZG6pAhnHxEkhIxymB98UdliN58qbSbkYrCLdgYM78t?=
 =?us-ascii?Q?RngdCksxWQnUzYPPfjS5hXwWTNfP9TUVqAxwbQryaChN/Qu5HYj6SY3bcN1/?=
 =?us-ascii?Q?YZcSF5qAI80iB7zHmoxmY8EOAw4GIrTWgKTeVIF7n9N6f9W+0QTNDFUErugL?=
 =?us-ascii?Q?CzYsLm+kF7Tj7EttZU3x2Dx4N+ownJCx9Xpje2PHufXTb4xgK7Wrb2KClGZY?=
 =?us-ascii?Q?2NwLV756jCgF/cIx0GAfafRGwGSE9bXCyMZlbv72PmY6Xa5oZJxAg9QmOxO1?=
 =?us-ascii?Q?0sq7Lfb+9m3oTWMaRUXI979PvW7XahRh5ywFqQ3kc0FenR8jBhDsexH4P5dC?=
 =?us-ascii?Q?X2ghkOxY/0ZUOqlKrbnAMjveOKoKCFGgtQovb35pVPuLjpF+Zt7kWnSEn8Qf?=
 =?us-ascii?Q?ydPQSCNpHcy8j1mn0DlTin+cilx0lRYRtbKuuq21xnFD5Lrmzo0boqTYktwe?=
 =?us-ascii?Q?ViAyy1n1z98OmdKw9/6hfGeKtrIqAc70wWss4F9RyfdbVdU7M5pd1WO6Lz8f?=
 =?us-ascii?Q?DQboDedW5bTNV06XzHNumYf7NFal1lhyvfhgydfkWOH5hVo51Xo/Oh2ndNbz?=
 =?us-ascii?Q?uVLVPkaV9lnrw8XAvVDrxK7FYw0XR+9asQO+j/UaWA2CnA5tqCmThGS2uFyu?=
 =?us-ascii?Q?o5k49EhKVat9Jj0zh4qjayl9P1j+loYbuKqUJD0PrTvBbDpJw98foOdSEzaH?=
 =?us-ascii?Q?n5lC3TddqMAANDRW3uagStRgZM7ZNHEJAzVohNRxhs5NAg35QK/1tC4zFpif?=
 =?us-ascii?Q?4L0t14IpCtpKRHewS8OzqR74hBxhUx7tV9x9U18/J/tINvp8jVdYJ5kOQZvS?=
 =?us-ascii?Q?vsiADGquRr3f/iDgKoIhLicsQMRc3rf6TMVTtClWaUxZeqNf+Ns+HtbT0xpo?=
 =?us-ascii?Q?XCvTFW3Y0+rVxy7hGffuJjMo6UxqYixY8/odiLlN+KXogZE+cKlBbyUcR3ht?=
 =?us-ascii?Q?8iKEUL44shUtu2ZAyIX5XynaJJNKJjbLUqAF93Yj+cuvtYqtkLRJ00vqnlDp?=
 =?us-ascii?Q?5bB06VXS6uIqdsUwEXvYsuVKOZiUEnQI?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Djdg1ounX4IjmaV2WYvo4HWdQl1l6rminyPo17zcwlYP2fxN/uKutHb/S3F5?=
 =?us-ascii?Q?X4b6lBM8hnfOIPOBVwVbUqY/nApnbU97uCLMcT/JA4+SzSwk6POAFsRXCCOC?=
 =?us-ascii?Q?AifHvGUYjmpQHPuB4m1LtFtpB9kS3MXgHLBPWG+XRhD4ChJRTrDLJB4aL4oQ?=
 =?us-ascii?Q?+4eHf8SbawCc1In9XlYMI+fJzAyygOv02xxPYawQ5haQAGyOBycEjkmVPbem?=
 =?us-ascii?Q?8qU/TqGpE1qrIrEWHqIp4zPn4uOeTKyQTfrnpzukTUFwxzqAgOYogHFkfGJq?=
 =?us-ascii?Q?7WrPTlQj944DyeRUysNkNv7IGXsZvBRdaPNA5Pxz8kfusmFMRK08+FgKnlWd?=
 =?us-ascii?Q?6NwTwZPP/1Atm7cPUkfTh4h1ilHMk4G0KU7joJhNNeOTaW65bFOmXwBGnPZs?=
 =?us-ascii?Q?qtHoJmhV5G2RChYOrA/ARnsu8+0BodIeIU+XRmtTv42kunxf8uOdHMUbCGKa?=
 =?us-ascii?Q?Hjyarr5WA/UzhgP72IpTRLsBwEVr8Yhdsws8OHxuZ83ow0ASZJML11rbB2YK?=
 =?us-ascii?Q?ZGIGsDrKLBoUtR3ikXOCzDSYYMKJ5IC4g3GM1vckuM8nZvDrdlAEd3hzYbYO?=
 =?us-ascii?Q?fRx+lficWHAXpGVIjGZ401r/kkSL8yUMFH9y7Z/lJfRa9/UyoKv2IH0F1La0?=
 =?us-ascii?Q?I02GPFHqWCLx3WkiB6Zh4avlm4r2y9/thlHhWunpFhKqRV9biveQ5SjHK+xz?=
 =?us-ascii?Q?C6pKk4gYrvYrrtfnJ0tgBbWidGJPwNezCTSLg/Pcuk6JEDTFnihYZ0ntR/xB?=
 =?us-ascii?Q?WU3/1p2N2xwSNB6gCbQDlDMqMZMThMwFI1LmUxxlFDtK2mcZXrI9D7ZQjAfS?=
 =?us-ascii?Q?l3mhgZzIzn+aVOZcE9wTmPzJ/zjd9ZLNhmbptaD1su0ZadARwh1noFt7tPoX?=
 =?us-ascii?Q?Xu4xWGyFHgkJvAuHxGOnKAVsUX3kjief0AB/PeooFegkiprTpeApSAhV1rTq?=
 =?us-ascii?Q?700B7WUVbuSNSwMBynd4vqRPcofnSO6Wry5Q0eclUamE/ZaQCMiNTXNgXQY8?=
 =?us-ascii?Q?oR+nxJI7xlH1yFuUdBZ+zJNv2HXToGff2QBvXNwVHr3kmW9aXQ1qglqZqIYt?=
 =?us-ascii?Q?MDgvjaoCx96EVpzT3Lw9AEIYat0Lhn5EkdI9RfvFz3w+blFy3D7zQvQQozQu?=
 =?us-ascii?Q?GHNZYa9o2j25lhLW+CoqGi+BVH0nRfUjYOefpeBYVUGLP9gC1zcZboexaESy?=
 =?us-ascii?Q?noV9nAdqNQ5OoFE/FkxR+nVF4tJPMfnXXr6/im4kinD21uPJO447sn/GQJ/8?=
 =?us-ascii?Q?Pd5GJ7/anb8oPvs8qMlKktxefjITgc+ZcZivGe+mEcTrJOSQxkoZq4tgdVfU?=
 =?us-ascii?Q?n5hX+gpaqH5zSxAormOyA++cvbhdSxBbY7O6Zn7z/qx6qSTl0KJlEmOwE4oF?=
 =?us-ascii?Q?0YyenlWX8EevtvyYGqXJuf1mWhJJ4W9zbF0do/BCGX23WTM2RywEJ7GzjiTK?=
 =?us-ascii?Q?F86v6K/ub9a4dyWVr/oF/yfC2787dmtr0dx8Urhg/N9+khmgJBFOWORyuGkd?=
 =?us-ascii?Q?DvkN8SSbD002K8mNWPbQE4+et61PV9VjYFIunS5sK3/HWyFK48c+0bIwRlMO?=
 =?us-ascii?Q?N779fh424S1+ioH/OczE5Rex/RCoehLlLCNkzoZI1ER4CNMw4+leh/j6nIsC?=
 =?us-ascii?Q?Qw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff9c6f89-b07a-4f58-1a9b-08dd1daf427b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2024 08:54:32.8267 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p3qMu1JomMA+Nb5j+AkxxU0tfqfS8q2plCmkAjMkNIekfft/lqMhaMUr2tI2H27tJt56EQxtGhD/c6agNDfv0Vh04WAz5ly7HiIWMOMpk7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11779
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

Hi Marek,

Thanks for the patch.

> -----Original Message-----
> From: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Sent: 14 December 2024 22:43
> Subject: [PATCH 1/3] arm64: Convert core type check macros into inline fu=
nctions
>=20
> Turn the core type check macros into inline functions to perform better t=
ype checking on them. The
> inline functions get optimized out in case they are not used. Indent the =
MIDR_PARTNUM_CORTEX_An macros
> in preparation for addition of future three-digit cores and use MIDR_PART=
NUM_SHIFT in
> MIDR_PARTNUM_MASK to be consistent.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: Chris Paterson <chris.paterson2@renesas.com>
> Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  arch/arm/include/asm/armv8/cpu.h | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
>=20
> diff --git a/arch/arm/include/asm/armv8/cpu.h b/arch/arm/include/asm/armv=
8/cpu.h
> index 40d54dc85ab..aa1470bb72d 100644
> --- a/arch/arm/include/asm/armv8/cpu.h
> +++ b/arch/arm/include/asm/armv8/cpu.h
> @@ -3,11 +3,11 @@
>   * Copyright 2018 NXP
>   */
>=20
> -#define MIDR_PARTNUM_CORTEX_A35	0xD04
> -#define MIDR_PARTNUM_CORTEX_A53	0xD03
> -#define MIDR_PARTNUM_CORTEX_A72	0xD08
> -#define MIDR_PARTNUM_SHIFT	0x4
> -#define MIDR_PARTNUM_MASK	(0xFFF << 0x4)
> +#define MIDR_PARTNUM_CORTEX_A35		0xD04
> +#define MIDR_PARTNUM_CORTEX_A53		0xD03
> +#define MIDR_PARTNUM_CORTEX_A72		0xD08
> +#define MIDR_PARTNUM_SHIFT		0x4
> +#define MIDR_PARTNUM_MASK		(0xFFF << MIDR_PARTNUM_SHIFT)
>=20
>  static inline unsigned int read_midr(void)  { @@ -18,9 +18,15 @@ static =
inline unsigned int
> read_midr(void)
>  	return val;
>  }
>=20
> -#define is_cortex_a35() (((read_midr() & MIDR_PARTNUM_MASK) >> \
> -			 MIDR_PARTNUM_SHIFT) =3D=3D MIDR_PARTNUM_CORTEX_A35)
> -#define is_cortex_a53() (((read_midr() & MIDR_PARTNUM_MASK) >> \
> -			 MIDR_PARTNUM_SHIFT) =3D=3D MIDR_PARTNUM_CORTEX_A53)
> -#define is_cortex_a72() (((read_midr() & MIDR_PARTNUM_MASK) >>\
> -			 MIDR_PARTNUM_SHIFT) =3D=3D MIDR_PARTNUM_CORTEX_A72)
> +#define is_cortex_a(__n)					\
> +	static inline int is_cortex_a##__n(void)		\
> +	{							\
> +		unsigned int midr =3D read_midr();		\

Maybe unsigned int midr =3D read_midr() & MIDR_PARTNUM_MASK, to reduce one =
store=20
Operation???

Cheers,
Biju

> +		midr &=3D MIDR_PARTNUM_MASK;			\
> +		midr >>=3D MIDR_PARTNUM_SHIFT;			\
> +		return midr =3D=3D MIDR_PARTNUM_CORTEX_A##__n;	\
> +	}
> +
> +is_cortex_a(35)
> +is_cortex_a(53)
> +is_cortex_a(72)
> --
> 2.45.2

