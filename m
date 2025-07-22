Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A4A0C83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 08:43:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F13208331C;
	Tue, 22 Jul 2025 10:43:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ppHpvk0W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AAD783346; Tue, 22 Jul 2025 10:43:10 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::627])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EBC4832C8
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 10:43:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hef7H73/viAfOnCWKGCtTuAMjNpY0RvrIYzVGUI55bxXXlUyNZHlaPmPYGdc9NTGpenohAhxsBcfYR+CWWxPr04xElMIYWBF5RbYGeM+dzr50/IJQyUnK8UwO1RimWtQOibnAN3JPRCjO4jaDndKsBmmbS4Cynuv543mXlffVRUBVUFrieYzb9RjFH5uhGAy0VQrzYPDnQuPKJNDbvpCG3cF62oVGu57mLp6phblYCaJhEFz2dSCTN444i3ICCw19xCbnHNuUyUb1pe0TdKBKzaTWlUUf6ZM3rZpDaREcCjgYTrEydWgs+eqzm8gehtkE2DwUP7EnqmdyKz1GTW/NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIpZ95lgr8diJHjGQKYNJiLnEjtd1HleYVPxB13p+/w=;
 b=aKXy+hsRIYYzCsQnBiDZ6W7lJjWY6me3hcYHRDnyc4hyLpNFszgxriIFw8nPPPwHp37iBhhRQ6zedFsPa+/hSONaSUYybh5tKaZKX0ufc0M7FkLCS79o6sIpEO4yTXXNC+OLKLf+IYYv9RdcE/69AkNRny2hD9t5D1XCMOnsleiZ0p0KepgA1KIb2A7pZqI6X+sFqyxnnor5vcS+bEx8EQ1IxKgzMVbXLW8cnufetaAEMDx9fdnfd0cI2M9zPsnJRnA16OgbF9ARt7R8eXDrfm+/+IWZiPcJFTY4sr0kjRiTZbwPVX2gabH0QPIDxNZXME2Gv41gFZqYrDw2DGe+2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIpZ95lgr8diJHjGQKYNJiLnEjtd1HleYVPxB13p+/w=;
 b=ppHpvk0WITRPFPG5EbP1PKfrn+cdU0FVlaSHqW7Yytj+Fg7MZAO31Gj1RB8eq/Tr/6Lrv/1R98ii54lfO/8FeJB0u5U0Bi8rZMLDteBcG0EtCjGljdGK1Eg5O7ab7KlZTlcVeWn3ONN67OjDwAvZhLZP7ipVwuzrpEMU+tMnqw14FbPr7x6I1oxiMJ7AU5WoeHuMiHHK06XYyVUHBDgA8jARfQGLQqdsAD/RJKhgtMUlxs3dI8vz5ZEnBYvTJYnU6sI+dWKR/84gVKG91GNpWAt/DbCboGTL21pCMUYPo+qbBCwl5d/MeNuhN3YCN8L9mpONQzF6vP8T1lIyPuMljA==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by CH0PR03MB5970.namprd03.prod.outlook.com (2603:10b6:610:e1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 08:43:05 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%5]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 08:43:05 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>, Simon
 Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, "Hea, Kok Kiang"
 <kok.kiang.hea@altera.com>, "Ng, Boon Khai" <boon.khai.ng@altera.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>, "Lim, Jit Loon"
 <jit.loon.lim@altera.com>, "Maniyam, Dinesh" <dinesh.maniyam@intel.com>
Subject: RE: [PATCH] arch: arm: dts: agilex5: Set spi-max-freq to 50Mhz
Thread-Topic: [PATCH] arch: arm: dts: agilex5: Set spi-max-freq to 50Mhz
Thread-Index: AQHb8VSnFsQtZMPutEqIdvsjgGMoIrQ95o2g
Date: Tue, 22 Jul 2025 08:43:05 +0000
Message-ID: <LV8PR03MB8137079398F1970EAFA1CAC8A75CA@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250710043924.90780-1-dinesh.maniyam@altera.com>
In-Reply-To: <20250710043924.90780-1-dinesh.maniyam@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|CH0PR03MB5970:EE_
x-ms-office365-filtering-correlation-id: 520a43f0-a40f-47e2-25b2-08ddc8fbc6f3
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?gp1vjF8KMuUDjrPR7h7ms6L2YYCulCzBX/hx+ieYW0FIGMRd9ant+vQBD61p?=
 =?us-ascii?Q?m/ITsKcwzgm6mVGX3ZnTMDzIb4UkzeYpZ69OOmrorL63bDaww5Xz7gC8Y2IZ?=
 =?us-ascii?Q?A1ChmzKwJhlLVVeecJXIiA2ZlRB0LANeov4FP6gfOQcxvhbgLa/vGtFtRuSP?=
 =?us-ascii?Q?8kYBl3FngLZIesaa67RoMZ0EftRIEyq7WaZ7enZDT1eiu2TOnAvw2Pe7UVt3?=
 =?us-ascii?Q?MsFL9GSJzCEqVrayPLgg0HHhdQIwThZcO8PSYRtSncCHINhjuXk+QbrUnSTz?=
 =?us-ascii?Q?RNdYCgvbYwcFprXxYoyfdzDk2VMimXKGXuWjnQ7FBBwTKHuv/O6cyXv7rhFy?=
 =?us-ascii?Q?lxzITGUI+r6zI5HqFtpYFO3eZBLIs3+CX8ECdAqnz1FaQYxZ0aXU1+lgXTwn?=
 =?us-ascii?Q?KjknHAPGQQntS9q/fBCewWdCBQ0bDKeos+Yvz4JQcfuDGPbV0thPzY6aCLBd?=
 =?us-ascii?Q?b8xVq6Zx7y8Fa4QnaJ4dogO9zJH8Wj4CPK9sd1y2S4cDIwJb7kHrri4yLBYL?=
 =?us-ascii?Q?58dO2ehDIEbl5MfoUmw6umRSFJaJEeoUqX/4fB4NHnYoXlLBWhJLiLg5+eSS?=
 =?us-ascii?Q?sjc4cWjUQFJ5yiftSz1XISTnLN6+WKDjjjt+X03ESKh+E0XoCseCRMxCpS2Z?=
 =?us-ascii?Q?bzHzuvCIZ2Kne7cUrYZ3INpC3WZkPOq3Ak6KvxcxHLvPXUMTElyI5e/QMpE3?=
 =?us-ascii?Q?y3G04czeltLN652OmCIogvCisp1O0Bj2afC8dclVKoBqNC1vEkEpO3mgYiwh?=
 =?us-ascii?Q?xUrhUT0hW0xIa50fxSjLRw9eI6UdZtyQK+cYqCDxWlyOpfjlUODY2EbI6pah?=
 =?us-ascii?Q?SNUKWegKAR8V0AxLkdNdgp3GO7yn1teMJZXa4LUaXxBAkeVdpNIiZ3E6zD0M?=
 =?us-ascii?Q?+bY6yTUC1wPB//VSY8Axmrr21H2Z7N2V020bYkQeDqPtk1fzHFGXnh48AfLs?=
 =?us-ascii?Q?Vfx9yNNY2JWS0TFK1xA6dj5a1zq+E1GiosszSBJeXscF+Fs1Z9yud2VvvL1u?=
 =?us-ascii?Q?n/M61aSI8Noe7HeyYDhfoOqxkLIRjrDCHY5g0qNwFVO2Ji0zLE5rZzUBVF/D?=
 =?us-ascii?Q?BWhX1nEu3bn/rMT3fwFk0c45BzSv4FzV2eEv+Jr5yaHrgHgsQbRi/aGHbNcA?=
 =?us-ascii?Q?acO6WnOztfbzK24fEgFnD62TpOn+45B1nUDolfaYcvF1NRo+ejcCagOoBNBu?=
 =?us-ascii?Q?19jW5Dgepcuj2jtBczCxbQFT3LYWjUyo341bwn9O4lUOEwaF/MBjpgdLKnf0?=
 =?us-ascii?Q?0AaUa/T9hbppoVdipaAVFZbnNg0jjsXxg4x9Ou6LolprB7alS86J1oDfufwx?=
 =?us-ascii?Q?GJPYd6JvIVaU4avRPxijwmc3Kb3BeUIDHutAPRFesE5WCzMPs+g96PgdF3PJ?=
 =?us-ascii?Q?WkqOkSX3Dgylxl0lYFc1nuY9Wq+XwkpKLodeh1Xefcr3fCmOnx02gP/BMgrS?=
 =?us-ascii?Q?/RevE199PNQniOlKQw8qxu6V6toegqQNKyq66odVf+tXPXRuyx/lyw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u7qrXDK2TzExVvZZ0m3MzG2kjD+7kSjEEIeHGu9GErr9IJaEHwib3wRgmNC/?=
 =?us-ascii?Q?kgfyP+jujsO4Li9XNN2vM/gzPjrb/TL8xuAaeSDMnKspUyIlrfeqUd+YRtuJ?=
 =?us-ascii?Q?RyiY7lpATnY2RmKC0OIJpXQv5/3cPFGOATiLxyJi8QW2KsYMbmWpjV6sK8Rx?=
 =?us-ascii?Q?AOiHICDJPhuveZViuDi93Bt++lK3HLeaPcAG+dot+XhGsRYTEbK+jStZxzgw?=
 =?us-ascii?Q?H7oUZVH7NS2fPTQru0dXH8m6ho7r56RMPj/lahRdPOrdENjldF5AwJYY8Ad2?=
 =?us-ascii?Q?51S57IsosyBZ1tqm+tOD083hfyQeHtEobsx/uYtwZaD2mg9+WSNj09i3rsf5?=
 =?us-ascii?Q?yucH9VaBdGr6hIIgkhKH1oHvyvq35hwKwh8S2AGpEkUyLGvzsElfrfmotntY?=
 =?us-ascii?Q?Pq/PByn9A9MM0yFbCucWtck+gpUwBPI81kQCojpwuWvEu0akDYNg+00iDwgU?=
 =?us-ascii?Q?o2H5JddnkpK/X0k4bFBZ4OrpjNRG8JQ57N7bDElwzJ9XBRMqCkotkW+wDv9j?=
 =?us-ascii?Q?bc98q64+oHAdENg+DZYPx+1wsdbXof4F4wDx7Nd9+5dnKJIaGGRhPmEUk5fg?=
 =?us-ascii?Q?Xr725mjZruLMWKZlRZVTmkGh/y3n+sZL0LpCi5VYclcseRIokGv2A7wjQW7N?=
 =?us-ascii?Q?IXwZ93oixHCHsCW1T410zEs/N837xLZHdJLugCEAcvEaGWM2bSLRiiUI4pU4?=
 =?us-ascii?Q?2etD4LeOtyDuxoc7yG9OvDGBYC84lKXccEhW6u0dQCqtKnBKzfu2USraDO+X?=
 =?us-ascii?Q?sHPvutZDCR6qJfZPcZhiZ2D0uM233gNkz7D+ywtyUoDt/vXEa9Z7uQQZApOZ?=
 =?us-ascii?Q?Xo0Wez/warPZS+JVl7+5CtBTT63czx5Ze/EoivSNboFO+Ad04rmXJ3qEiiTW?=
 =?us-ascii?Q?WQE3CFo1FxikK1vlSiKrWBMwqPvQKUTtIQTqrIB0KpIc7py37MJ8WFwsSb1z?=
 =?us-ascii?Q?T1Y+XDyvnWB3+whuP2YzMsuavTH/n1c54hiqmZ/DB3qYx7nKcgOGH1cKdAxD?=
 =?us-ascii?Q?XR2CMBsDdmlm/vWiv5ULwztpP/rmUGtfdqSoR75dwGHWFrpX0/RyasyGr/rE?=
 =?us-ascii?Q?7h9VDLjizQg7bKZ5kOvg3G9u7Kx3I2y4wOo41H2DGYnduDQ4ozUkD15R24Zt?=
 =?us-ascii?Q?dpu8iG/Wi2+Stx6AhAhex/PAZrbqzdpHuEyXMnN8chnU1qjRNwG6oADaTz/R?=
 =?us-ascii?Q?+M6oyh7jEWgyycg6prVKdgegbklm08vQfeJQvmTbxCvH5FpFsEC8Inelg2wX?=
 =?us-ascii?Q?gXPW92dRBpVQZvgns4XOZmVlRgCuzihoeuvmBsTb2byOULyGZBk3blxndIsT?=
 =?us-ascii?Q?zJhdzFQ7HRGUpneKgq9HidfEhhUrqLjEQ6xbPsM3JneSWQsSVtOcilc9OgDq?=
 =?us-ascii?Q?jcBskkSHSc1JXPRrjbyk19Wem5MaPXzNF1mAbyNobbl37CAwSWR8h43aeBRD?=
 =?us-ascii?Q?piQLQLqhPBTvf+IifuKRW/VZORpYtNgWS98kNV5lOFxzdDlrAnMcf77yBhfg?=
 =?us-ascii?Q?t6tZxB1VmcDnMPjGaPT9mW31UULF2sPxR6fBTc5RaG5S8+MgO2McvzIU36fG?=
 =?us-ascii?Q?ri4fmShuA92y+5g/IauRfHAfi4e3nLsB6bUZii/T?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 520a43f0-a40f-47e2-25b2-08ddc8fbc6f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 08:43:05.6373 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OIbnHdE5SBqdpfCdIxN09OR2mzwHB1uGhN0jF0YvmRr4L7QrKd1bRwAKte1n50oRXOGPcFLTJQYsmTtGDeFBfGqLS0OQC7cggLlPgsR4W08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB5970
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
> From: Maniyam, Dinesh <dinesh.maniyam@altera.com>
> Sent: Thursday, July 10, 2025 12:39 PM
> To: u-boot@lists.denx.de
> Cc: Marek <marex@denx.de>; Simon <simon.k.r.goldschmidt@gmail.com>;
> Simon Glass <sjg@chromium.org>; Tom Rini <trini@konsulko.com>; Chee,
> Tien Fong <tien.fong.chee@altera.com>; Hea, Kok Kiang
> <kok.kiang.hea@altera.com>; Maniyam, Dinesh
> <dinesh.maniyam@altera.com>; Ng, Boon Khai <boon.khai.ng@altera.com>;
> Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>; Lim, Jit Loon
> <jit.loon.lim@altera.com>; Dinesh Maniyam <dinesh.maniyam@intel.com>
> Subject: [PATCH] arch: arm: dts: agilex5: Set spi-max-freq to 50Mhz
>=20
> From: Dinesh Maniyam <dinesh.maniyam@intel.com>
>=20
> This patch is to set spi-max-freq to 50Mhz. This will add support to the =
driver
> to set the operation speed according to the slave device up to 50Mhz.
> Without this node, the driver just can adjust the operation speed to the
> default speed which is far below the best operation speed of the SPI slav=
e
> device.
>=20
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
> ---
>  arch/arm/dts/socfpga_agilex5.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/arm/dts/socfpga_agilex5.dtsi
> b/arch/arm/dts/socfpga_agilex5.dtsi
> index 86322d7b0ce..9bc3864022b 100644
> --- a/arch/arm/dts/socfpga_agilex5.dtsi
> +++ b/arch/arm/dts/socfpga_agilex5.dtsi
> @@ -388,6 +388,7 @@
>  			reg-io-width =3D <4>;
>  			num-cs =3D <4>;
>  			clocks =3D <&clkmgr AGILEX5_L4_MAIN_CLK>;
> +			spi-max-frequency =3D <50000000>;
>  			status =3D "disabled";
>  		};
>=20
> @@ -402,6 +403,7 @@
>  			reg-io-width =3D <4>;
>  			num-cs =3D <4>;
>  			clocks =3D <&clkmgr AGILEX5_L4_MAIN_CLK>;
> +			spi-max-frequency =3D <50000000>;
>  			status =3D "disabled";
>  		};
>=20
> --
> 2.35.3

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

