Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B25BEBFD30
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 10:13:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8988C84119;
	Mon, 13 Apr 2026 12:13:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="piCrhMQL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95D70841A2; Mon, 13 Apr 2026 12:13:45 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63D7583F75
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 12:13:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fCOGAIMtrEpnjGZzb2RkRQG65erS0pLFTKpzFK567bTc2eiwcGiMTsHJhEXM1R60bwkbH7y0miVNsQyAfa+pHBnaVpWYETH6BKoDzGTUaSMJ1v3oXvSfefFcgHkp6VXez8XSA4U2JUbZzqqSR08bNP0Jlm+SNmPljSSoQgoddRdrE/Hb/ygYVVvzK2YjyO5KNOZmmFWPWSAHizpFNejcslPrw5PMoOjE6x0P3Vxg2gs1XRRyMX9G0HdytX/QVQVZYUePkMCJy+K15arYJIW9rYZZBtq7+JzdxxeFpeVED00kthWPcD7hNKzTaREHJM1bV989g+LUP7r4rBBKBAgsuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5EOxECgjYmjcAIDMbMjaatUqu49AeOT2viKXTvAfQU=;
 b=UpFxzJjxEkS3DlT7e5XZ5mgwCliUWECkXmZrZ3qxtoJV3wpv130FqEqk8MkGSiMuS1W9EkYHsul0LiX7ffPshd6uzs45x4JCOk8nfNHrREo/2v3n02aJPQImuV+8Mhzwd1Kf/xsGodwj8urO8Bejg6bOh98EN8qkVG0DSpCAmXlnk5nzNDD+6X/bFkUpPtGlK0UNYGIzyp3QqetdxtHXYV9EFXcmOfkXyANT73oDIfzUPb5HORNe9Xrwci3MUscc+QyFPM+iCdR74+rumbbtLDBIdsDVsksjJwpzBuoiWWVVjVjCSJ+pqhYmszG8Myh/EwLrzEzb/irE9kCYALYS0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5EOxECgjYmjcAIDMbMjaatUqu49AeOT2viKXTvAfQU=;
 b=piCrhMQLPhlZfby1FsccoOujyut6iWbJS59G10wRnQz0/ZGVsewciiexsb2p3DYQsXHBiKwemliiQPG1BckNP/z8NmJK9yFuXvb4wmmziGcLAsXpQdVlyyp0GMy+X7yga/SmHQc8s6lpBnLQIliENJS4VO19UX5k/JwBsk+IojPqZBo/DzBWIAOrmCeyl0ZsokLIORsMcQ9+H6P9h/TGoaoOxKAIcsEnOJr2bpRGRXWU+H57BOVgjqW2qGieCdTeYZ2pXdtjG/hUDueTrMs0mZPnJnUh8UDM5JaLczFsRAn3UkspnNFn7Y5Iw+IVNBYMgJRnDtedjPJd8FxJgLN8Lw==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by DS1PR03MB7869.namprd03.prod.outlook.com (2603:10b6:8:21d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 10:13:38 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 10:13:38 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "MANIYAM, DINESH" <dinesh.maniyam@altera.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>, Lukasz
 Majewski <lukma@denx.de>, "Hea, Kok Kiang" <kok.kiang.hea@altera.com>, "NG,
 BOON KHAI" <boon.khai.ng@altera.com>, "YUSLAIMI, ALIF ZAKUAN"
 <alif.zakuan.yuslaimi@altera.com>
Subject: Re: [PATCH] drivers: clk: altera: arria10: Fix wrong API used for
 memory free
Thread-Topic: [PATCH] drivers: clk: altera: arria10: Fix wrong API used for
 memory free
Thread-Index: AQHcphPK5yfjZyIwSUWCrDLmp9dFErXdCndO
Date: Mon, 13 Apr 2026 10:13:38 +0000
Message-ID: <LV8PR03MB813786F6FD0FD268C1D9B6C2A7242@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20260225050110.14290-1-dinesh.maniyam@altera.com>
In-Reply-To: <20260225050110.14290-1-dinesh.maniyam@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|DS1PR03MB7869:EE_
x-ms-office365-filtering-correlation-id: f0fb77e9-e515-4bef-fbf2-08de994554a8
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|55112099003|56012099003|38070700021;
x-microsoft-antispam-message-info: dZMKiMC3lMuW7o9oAFM1IpZgqvA4SRCUQFANPlJgST4cOY9iG7DFc0D2vg0n9dWl40mGCgVqiDlC8osfg0nmxdr6mtDy2DqoaxEKXFTuKaT9YmMuX2ZTtNnaPTwfxuXYbJwb7BCOgc5XUseX0TxMFMzoJwn2Oi4+gLBzU7ZisP3vXFA57zxxOMuqFfEbkxOpj4zLZp6OW18G5A7uuVgL1i/4qYDYiQ/l0Dh8QBH4NTL3ULEwjrDDXrqMGgZpEWRfgjPvx4HOYXoW0/S70x8Iu+phvI6etiDMQX0oIjMZSxR4FCErJhLIsf5t34DokLSuN1L+LdIxHUYghEZNEzxlax7mlBAw4ZUF9AnWE8ub4KCtIKI2ZdHchbb7BxKuVU5OR6Fb0k34pSJQEboMabba5L1o9c7d8WauG1hnVEQrlJ6UK4xX8zO9nDj4qsiI/A375rp+PsUNrCivSr15dkQvMk5iq/XW9mJGJQDTuUwDD+GuVNVAOkBld+0grtVRUT0QPIhP4IRWYtY8zSLSrYc6YBKvdcMjR5zS20Sld7Spf9yaIc9I8QSLhTQTKNP4xukyWt9JxbHPbCaR2HL0fmLIhaYHEQ/u5DvroiygbEQcD2hLdfCVVzhNNAhz09ys78HdD/PRzd3sd9NqBzTriS3bGs4vvyfPCJFwuEw49vYkwXeOEGxc7A5txMa6KgA4bgl90KpjBSXZjfbicynEggPuq8HpCFIqdKDW+9cLMc/1u5NWDr00tWntTPqb97L5LJ7RK0cMMd5Dr196okcpz1Y+Ct1FLLVkg2VcQpzsywR3J5E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(55112099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?tmBKG5ZCDONpnmHljyLEK2eBxJMOH/QJ79AzmWkIMQmJWfbCytWYaUQj?=
 =?Windows-1252?Q?4cOzqquHp6iR/J3/QqUrlQHQuqGAhnWANdbTNTkEQgm51TRdPvsVkUGc?=
 =?Windows-1252?Q?qbHCIkN9Gr65YVUJ/qml9590QJ8uXQiJgjTMy8Id3rY9LGLLm9Vm755C?=
 =?Windows-1252?Q?0m3laI2DH6ia8bC38hMKuVJSzqAMvnkWQ5JfCYrr0Tg/k7fQv+hBHjWr?=
 =?Windows-1252?Q?udqknkUDpHjmqJOeaW9BWdD9MN84wzqGmngfcGKrZ7zHfKZ2uzkktN3c?=
 =?Windows-1252?Q?8TvBi7g9blZqMMvnpDeaBtME3dbkFkrT407ElFHiUbywCcsZMAlaGVQg?=
 =?Windows-1252?Q?QGLw66wvrnRjGaNsv0zLHUPeoY/ZXnWsv7kncmNw6GyNjt9WnEjP0xYh?=
 =?Windows-1252?Q?dE58OpQHNbW6RCdxLix/tot+tRU8YetgXNoFc+IC80hNtiGHZn9OXdbs?=
 =?Windows-1252?Q?SdgdgxwaryPsSrqupPWuSeTEcbWrQPX49FksfrK0L2XiiIMHjfPZyQht?=
 =?Windows-1252?Q?he4p+8dzEi+ldpad6QBDrhD2F8eyn9Nk2IvlY6NSNmOmD4fXPeN0cb5p?=
 =?Windows-1252?Q?TZU2pqj2eBglIdqf8r38DldQROMf0k7aVR9k/AFHQR9Bqiuc3fPOJx3U?=
 =?Windows-1252?Q?gcZw1pBSprlp4KVz+HEF7kuhuYeRZS8UW3ZOsUMNxxygwxP3qqVEPxzC?=
 =?Windows-1252?Q?Or6WwI+BKFbJaH3lrEyPd3JfSrfcIXEy8xrSufjZc/vtReLQODBJUneN?=
 =?Windows-1252?Q?BuBqDh+2FdUy8WVzSWS1bxafYnyzFHp9+aEW3Z+5KboYOOG79zdxdWOS?=
 =?Windows-1252?Q?0SWDUOuSvV6eVX9UXosAsvlmzs3ihmz3svT99v6ElbTjEI7/sfYhmAKx?=
 =?Windows-1252?Q?vE10cIiTRZ3TKaGmoQ3RPF9YFixJ2tFHCvIx80BIgbiCe8OUvcQuZwSc?=
 =?Windows-1252?Q?Q7ZSZB+oYCOmZpCltbeNgja3N0f8w4ODb/GdGAsMHmj1m2soE1vxhhih?=
 =?Windows-1252?Q?+l7eTHJ1+4r7HbMAfkdM8w3CP6Bgao2O3q5piZj/KAd8xbEjtDuZ3+ma?=
 =?Windows-1252?Q?xWGC/wW7p+XjqVxeF0Jf4cN4JZkkGTBTIM+JoC0NbUJoU4/X8EutHabN?=
 =?Windows-1252?Q?xwcGa2h9LgahEN5BPpOMxaFJ5HwQFOoRYiXFrbXB3z46PoN+2RT75kZe?=
 =?Windows-1252?Q?GJgLp2opFZMMLyINoYYUmTFNUtoGdh7FDBT+kajwg8hgAENzJMhE90UV?=
 =?Windows-1252?Q?d5AIqmaOsnzrfb+RN8bz2W82FAE2Jp3v92B7bVvxJ6ME2cQjAZf0IoOC?=
 =?Windows-1252?Q?4+zHBFyKqPQJLWqQLMNl/wRN8Zf9+9X4Ir0OPJS5zrm6ryJnIPCraz7e?=
 =?Windows-1252?Q?L41Ql9e8rpgXLaPrv7w2+4uIQCesFtAc+MoVweKeslhfz66GI2047+K+?=
 =?Windows-1252?Q?y8AipzVhn5wjHHu4LTCJRuCUjVwPYkX2KU/TJ26005nB476GxpvpkU3J?=
 =?Windows-1252?Q?jdfq9YnxaxI+pFTqU5260JKzlTQewzEZQlVMzPsbyHU7fKGNgFVc//pb?=
 =?Windows-1252?Q?wmdr0s5ifNEhcxURql3trcnkAGlTMHdWeI4DBnB3/hxOykqAp2TktK4b?=
 =?Windows-1252?Q?KfNk5fcDByE1qdtXX7NYPlnbLbLatCk3O3Pgfwt1pw4Y7LZNrkGmdbQD?=
 =?Windows-1252?Q?OFSVOiG3eIz22VrOJMPxKO6XVxE+/n2tjLjPyObpHJ7jvEjGJVhB0/1O?=
 =?Windows-1252?Q?W8NqFswcuhorb3XFOfewBKYQIPPB92RQ5zdAkD5q2rJIchraxo4O8V4E?=
 =?Windows-1252?Q?DvB7qHrKwp82kb9IAZivtomV4sMsC6yEoPBqt+j0D4S86I5duc6WHTBj?=
 =?Windows-1252?Q?JCe/FOyqfWDLEA=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0fb77e9-e515-4bef-fbf2-08de994554a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 10:13:38.4517 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yGtvL7C8vjumwm12Z+hVOFbzFp5TlOXBbhBnceherE0rmdfWaMENTgE1T+2mnThWu594WJyhouxVx+qwCQ6PEwWTkcmERtrkXrGMuU1gBz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR03MB7869
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

Hi Dinesh,=0A=
=0A=
> From:=A0Maniyam, Dinesh <dinesh.maniyam@altera.com>=0A=
> Sent:=A0Wednesday, February 25, 2026 1:01 PM=0A=
> To:=A0u-boot@lists.denx.de <u-boot@lists.denx.de>=0A=
> Cc:=A0Marek Vasut <marex@denx.de>; Simon Goldschmidt=0A=
> <simon.k.r.goldschmidt@gmail.com>; Tom Rini <trini@konsulko.com>; Lukasz=
=0A=
> Majewski <lukma@denx.de>; Chee, Tien Fong <tien.fong.chee@altera.com>; He=
a,=0A=
> Kok Kiang <kok.kiang.hea@altera.com>; Maniyam, Dinesh=0A=
> <dinesh.maniyam@altera.com>; Ng, Boon Khai <boon.khai.ng@altera.com>;=0A=
> Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>=0A=
> Subject:=A0[PATCH] drivers: clk: altera: arria10: Fix wrong API used for =
memory=0A=
> free=0A=
> From: Dinesh Maniyam <dinesh.maniyam@altera.com>=0A=
> Fix the wrong API used for memory free.=0A=
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>=0A=
> ---=0A=
> =A0drivers/clk/altera/clk-arria10.c | 2 +-=0A=
> =A01 file changed, 1 insertion(+), 1 deletion(-)=0A=
> diff --git a/drivers/clk/altera/clk-arria10.c=0A=
> b/drivers/clk/altera/clk-arria10.c=0A=
> index 1840f73beee..e56e94adae0 100644=0A=
> --- a/drivers/clk/altera/clk-arria10.c=0A=
> +++ b/drivers/clk/altera/clk-arria10.c=0A=
> @@ -223,7 +223,7 @@ static void socfpga_a10_handoff_workaround(struct ude=
vice=0A=
> *dev)=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 ret =3D clk_request(dev, &bulk->clks[0]);=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 free(bulk->clks);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 devm_kfree(dev, bulk->clks);=
=0A=
=0A=
you must still reset bulk->clks =3D NULL and bulk->count =3D 0 so nothing r=
eads the old shape, treating pointer/count reset as part of =93secure clean=
up=94=0A=
    bulk->clks =3D NULL;=0A=
    bulk->count =3D 0;=0A=
=0A=
=0A=
> =A0}=0A=
> =A0static int socfpga_a10_clk_bind(struct udevice *dev)=0A=
> --=0A=
> 2.43.7=0A=
=0A=
Best regards,=0A=
Tien Fong=
