Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE583C25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 08:42:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F26E87B56;
	Thu, 26 Oct 2023 10:42:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=renesas.com header.i=@renesas.com header.b="OYQjkgJ5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1199886DFF; Thu, 26 Oct 2023 10:42:30 +0200 (CEST)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (mail-tycjpn01on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2019::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E749086E54
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 10:42:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emSRQ+lRy03Rqz0wuqKjEPHULslQ/5eZlaZjCW8xUbsUaObS/CssCkeUifQHJVEv4IsoU4MbLwuS7s0EaLuhqm05TmndckUBFnPfZeyBtK9XpN+G/aMoe1DrhOV2xVtQkT+gIdmPzllYQD3e0QIpeWuB1Jpmj39GWe2UZkMPPhyP9jSszkSJiFQAsujFuSjH92Io63xLd/gif3Hi6IdY/fdHUsq5W8YpDmGKWVLw2mJXUSgnRkFKC+4pz96T4BSGeJ9SwMzl6hBpxvKmU5H7VBSn2W9mhGlFpQ2AOp31E2DrpiHnctZND8tjGk/y5OZJleyg6IVm/xOBxPmbkoIhjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWDgQd8w09wmQtw0Zwni0nUHkJoYlIInEijX5k371HY=;
 b=Gf1g9B0L/DkeUDw62k9x898w5hNZjtAVYdaGhu8Gs4+JlQ8p0CUFE+0YOHg6Hk8UHiWc+qtG4t/+DIenUR1nCDKIQaUJo+co/gaH2QGL8CMnywMonxbf5x6J8U4/cMsu94Q2+te5scN++f7TENjE7ZTvW4HHxQonl3iPZbSd2k2ZON2JOa0Dm6xJO6CAvEBwrdciWtCWFw5xECm3rqmESeb6znqAzuVVZdPwiDqztDH+Tfr+TkkdvxnaKHVbly+WtEhiygRjNWN0ndWRViLeWPJ5itnjn5hzXOTZONFJ3DBl6t+UnGL0ruF36gVG9794R41Hi06aScluJUv9oal7SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWDgQd8w09wmQtw0Zwni0nUHkJoYlIInEijX5k371HY=;
 b=OYQjkgJ5SHNSrWbE1KMGglX9vsmdrhHN7aGaQ1UkHdpMxgo73wKR2liq/g3N2j6VsxRjStEH5iULQfucx3vuNvlGqK1cAV/3ReGwjcW4VDCYD/gKBMwW5+QP2VEkyeksu84ooWCuFZMYfQ1DnWmABirJPN14tfBQ0D5m6yCctAk=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYVPR01MB11131.jpnprd01.prod.outlook.com
 (2603:1096:400:367::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 08:42:24 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::206a:4c02:8a6e:160]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::206a:4c02:8a6e:160%4]) with mapi id 15.20.6933.019; Thu, 26 Oct 2023
 08:42:23 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Jaehoon Chung <jh80.chung@samsung.com>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan
 <peng.fan@nxp.com>, Nguyen Hong Thuan <thuan.nguyen-hong@banvien.com.vn>
Subject: RE: [PATCH] mmc: tmio: Disable 1/1024 clock divider on Renesas R-Car
 platforms
Thread-Topic: [PATCH] mmc: tmio: Disable 1/1024 clock divider on Renesas R-Car
 platforms
Thread-Index: AQHaBTCHTw2dcvvS0EaFmlNJMM9IzbBbxeRA
Date: Thu, 26 Oct 2023 08:42:23 +0000
Message-ID: <TYBPR01MB534191E7BE487D28877D60FFD8DDA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20231022214057.102051-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20231022214057.102051-1-marek.vasut+renesas@mailbox.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYVPR01MB11131:EE_
x-ms-office365-filtering-correlation-id: 33f70874-3e52-42e8-0d58-08dbd5ff79c5
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pJegfr7jZxHFj3uerZMmd+uwZQLMttIAD+e/cw6cflbJNoqBRQN3YMBKBqOeCjLdkoJato0O1jQG2cs222LVIDOSqSo8FFNdqSE4DHUfXO6+qT+duVC8PHaphVpzvb6eueBpEXw6TMIw8cMzmeGUkpPd9bde0ey02h2bRWAxrngX7mWp/sIWAIOoZcV9f8f7tHMrcbG9K+5sHlRyNtuSAZMVtoyFlKxjQL0tqvihN9yCVX1f+38haHdVZaEQdikUmWt/98uYGinrUtT7ke60lc/Vbt50QSXxMxW5e/AxE/KmpnG2NDNNl499Ux0chuNC2zk36mw9BrcocjCr50ml7aRHtcO/GmvkibWjMoR15XSIHTwQXfKAUsDyEqF+WApR+fE5xuMC4AwPBJ9ENWlRVKRddrJNHZPGT9wLJ/el8Y6iTyXrp8pa2MeTyKtgFFUeruO2qKh9WzH6PW2pQTjEtmCg1vW3EleOib1AWMo5nWdkyQOUaImsBexZf6vTVgRNUFhS5JQ0wy99Fwmswyb4TvhiyBvdzCmIAh6SHatv25C70MzKGqjpoOEu1/3b8tsRAWYo+v6hpxKjJXFTdxRiOYUwiVywnZ5LrOul1HRnMNW3y9yGpQWPJK3VuzSv6Gyj
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYBPR01MB5341.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(39860400002)(396003)(366004)(346002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(38070700009)(38100700002)(41300700001)(2906002)(110136005)(55016003)(86362001)(52536014)(4326008)(8936002)(8676002)(33656002)(478600001)(64756008)(66446008)(7696005)(6506007)(71200400001)(76116006)(66946007)(316002)(54906003)(66556008)(122000001)(66476007)(83380400001)(9686003)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w//igJtJY11R+kC380ltnxOUL8LAlZAg7UeKRywjNx0zKuCyhzISscQUkfjd?=
 =?us-ascii?Q?Xtm135aeWoizxNg99LC+C6l8DLuKXYdgR+t6Nu8RdMj0hqSmRYtb6FM28Aax?=
 =?us-ascii?Q?U2a4+hd1vGew5qihKO+ytHzO2OnbUv4O+WR0xZrgskuh3N6PpEqpmSiBOPsy?=
 =?us-ascii?Q?fbUYS24vpOZunp6piasfsbbLa9W1guDkgl8DbbW1bvDlYxbriRCy9fPjtE8e?=
 =?us-ascii?Q?IOsRz36+jAmcW4EGn4QsnWqN3Qk/CGn45ALUBX7lvQIjaTxZwYXnnZNs4lUj?=
 =?us-ascii?Q?+oIe4XFE4Eft/r/7PUajiGdWmI91LcVwlGMBu6Z+IzcKOce4xAyfx/bJJxEQ?=
 =?us-ascii?Q?EBDs/9y3l9+hb9vY3Yv+cC4Fbld4ysoQl8ArqEyRGZtX6LNqCgJUFE/StlAe?=
 =?us-ascii?Q?Yq/8Ha8Uqxmk385Mnd4tFSt6o7Rg56lplUEyAw+HMy0aAs1XQW3Mnk8VRxNh?=
 =?us-ascii?Q?su7r+3tZV6a3mq3E4/TkwULbsWdvK382xAaecmREgYt8My3XPqScCUdIIWUA?=
 =?us-ascii?Q?RRR4/TWr5gh+LfkYzNPN2Swc38glb08WnKL+oE4Nyo64fGL4/k854bubpIde?=
 =?us-ascii?Q?626/1YI0bUkithX5hhjsRYzWhjjXwZxk/I9ZKAzm6NWvW1TB0NVdCPDiiC7m?=
 =?us-ascii?Q?RfSCcpuzNbHSZvC9n7nmYOxWLahPW8Eda5YwZ7GJm9d8xXp9rPe5h70FFgeo?=
 =?us-ascii?Q?TmqjBV1DjtJcsah6n1rvJT8kTZK+ymGepCe/jPmRorLfD9JMVphG9GofVYdw?=
 =?us-ascii?Q?glL3N8uQupR5zk53yiucvW0hV4xtRu5Jgi1WNk9Ihh9kGoPO5RI+QY63RDf2?=
 =?us-ascii?Q?q/GHnh91WmJVE/0brQb44GdOJpMAgXDLjNxeq8nFceBRnZRCia8VhHieQs3t?=
 =?us-ascii?Q?+0N7Ra86N3LMTLmkDk3kXugzULNRrPpLYwuA2qVlzX1hMtjN/tig5lz/lI5D?=
 =?us-ascii?Q?qMvmUZWYAbYG3WKfUfZM/lJnZB4rpxqRc/AJROS4n6lbSqJMVgBCVKOvo4oq?=
 =?us-ascii?Q?4TAbZEx7zrG27wtTahP9IGTIPiDLjxnPu1hJRpyyOHdPmw1+5mL0qreDBN8T?=
 =?us-ascii?Q?dwNqvD+gkDtBmZlyGyp33YVKrQ+cgZxVuyEas4Zmg/cQdqWmLMnmafNKHFy4?=
 =?us-ascii?Q?xs4F5/tFAV9gxhPWYO2Ww9WD/uDWbwD0YzL0vj4vlRBnwae2zLWTwigoCb4g?=
 =?us-ascii?Q?joXo8GQmFVKEnLtabOWnu+xOA9yEXlxQgw5aeiHWy1rxIasWaaPHDJJ71BRJ?=
 =?us-ascii?Q?cMkP+dSdVlX2fCQZCBCHoTQekHP4L7a/auWkqLS4cfvelC0gKbYWjCWnKLRl?=
 =?us-ascii?Q?TWT4RDX0yt7ieumhuAQyCBZv2+2iD+uLvkWao5nYWJaDQXA3veonnljgIDzq?=
 =?us-ascii?Q?vTqs4yzg2JoYPmC1OTHxoW7712nQtjdj+eh3VnxoyCv1Vo6F+rQpqSMAyvXC?=
 =?us-ascii?Q?EfXNrrxkC1MOIs6bX+AhO8R/xJxb0ZPCXQGuRZUUVAz38uz3vUp4/ufSlKXf?=
 =?us-ascii?Q?dHhcTVCLioUiL7xY4Fz3gqdug+10U9ZQL9pUCHql60NO82bv9wIkb6N477Oz?=
 =?us-ascii?Q?2lw8n5KFBzmets5mUp3KF5ea1Dy08vBYBVl5wnnSORJu45lnFEHahRs4FDKI?=
 =?us-ascii?Q?1UInKSh4b9ZdCGzetxpWRvKYioey8gy8F/DATTPDoZrxd4yVq/rh+oDgL7JI?=
 =?us-ascii?Q?GhNzNQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f70874-3e52-42e8-0d58-08dbd5ff79c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 08:42:23.9035 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i+eDScgNboSmw8Dol3UgnTx+1hQtl2xDeqRu8f9TWA2YymI0MLZFbjU2SxrKEi1DOTCdG2OqMxzslXB0mcqOPcGMyUAZnQ2xUwLA7GqJFBch3HtYu6OMye3CKoPX+PiS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11131
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

Hello Marek-san,

> From: U-Boot  On Behalf Of Marek Vasut, Sent: Monday, October 23, 2023 6:=
41 AM
>=20
> The R-Car Gen3 SD_CLK_CTRL register does not use BIT(16) to implement
> divider 1/1024, instead BIT(16) is reserved bit and divider 1/1024 is
> not supported. The divider 1/1024 is specific to Socionext variant of
> the IP, as is indicated by Linux commit:
>=20
> 0196c8db8363 ("mmc: tmio: move tmio_mmc_set_clock() to platform hook")
> "
> Socionext (and Panasonic) uses bit 10 (CLKSEL) for 1/1.  Also, newer
> versions of UniPhier SoC variants use bit 16 for 1/1024.
> "
>=20
> Do not set the TMIO_SD_CAP_DIV1024 on Renesas R-Car platforms even if
> the IP VERSION register does exist, and indicates IP version is newer
> or equal to version 1.0 . The IP version 1.0 or newer does not imply
> presence of the 1/1024 divider.
>=20
> Since the TMIO driver is used exactly by two supported platforms, that
> is Renesas R-Car and Socionext UniPhier, it is OK to check whether the
> TMIO_SD_CAP_RCAR capability is not set to identify the UniPhier platform
> and add the capability only on that platform.
>=20
> Fixes: 58c35b17aa8f ("mmc: matsushita-common: Always check controller ver=
sion")
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thank you for the patch. It looks good to me. So,

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Also, our outsourcing member tested it on R-Car H3 Salvator-XS and
it works without any regression. So,

Tested-by: Thuan Nguyen Hong <thuan.nguyen-hong@banvien.com.vn>

Best regards,
Yoshihiro Shimoda

> ---
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/mmc/tmio-common.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/tmio-common.c b/drivers/mmc/tmio-common.c
> index 83eaf361f0c..890c496b535 100644
> --- a/drivers/mmc/tmio-common.c
> +++ b/drivers/mmc/tmio-common.c
> @@ -759,7 +759,8 @@ int tmio_sd_probe(struct udevice *dev, u32 quirks)
>  	dev_dbg(dev, "version %x\n", priv->version);
>  	if (priv->version >=3D 0x10) {
>  		priv->caps |=3D TMIO_SD_CAP_DMA_INTERNAL;
> -		priv->caps |=3D TMIO_SD_CAP_DIV1024;
> +		if (!(priv->caps & TMIO_SD_CAP_RCAR))
> +			priv->caps |=3D TMIO_SD_CAP_DIV1024;
>  	}
>=20
>  	if (fdt_get_property(gd->fdt_blob, dev_of_offset(dev), "non-removable",
> --
> 2.42.0

