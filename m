Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F652C369D3
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 10:06:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B360280EFB;
	Mon, 28 Apr 2025 12:06:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DX7q+g5d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21908820B7; Mon, 28 Apr 2025 12:06:36 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4AC180EE5
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 12:06:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 15BBCA4AB27;
 Mon, 28 Apr 2025 10:01:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43005C4CEE4;
 Mon, 28 Apr 2025 10:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1745834792;
 bh=GRzluCKGfFU+jIooQVNnsAP7weLX49ITKeielkeJ6Gw=;
 h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
 b=DX7q+g5dJ42GyRR5R0CWhwA95W50mIPFZk1TPaem7I+mJok0fO77KK+a+irxtW/Qg
 27Zk6F3+Xsubq/FBuA2Wggn4MYw50IBwKn+dm0ZEkOVBY4Pl3F4xUa+uFntF7H7pnX
 cnYPLkyjsz+BHPO2/7fVHvW8Tt41PjfWR5xauqf5YFaPIq93g/DgYtopM7B0d0B5EA
 EWj3vsYQcLOApQ7CP6PoSqogpYfVz+6WwBllXoxHdmuUs2gY605LLTRCcgCzVgKVxb
 +3RWu9xcLfZlttPCkVj1T8Jf33u1Z4WIyI0jNbk/Qoov01Oalbs/2KE+ebjtF15wq7
 VeRufyfQ2ZbKg==
Content-Type: multipart/signed;
 boundary=023ce80dd54248dd5f9a7639834dde4601b16c56936be6b2ed251eccbe39;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 28 Apr 2025 12:06:28 +0200
Message-Id: <D9I6S5PD32TJ.3AGU7UM3EUOF6@kernel.org>
Subject: Re: [PATCH] net: fsl_enetc: fix imdio register calculation
Cc: "Joe Hershberger" <joe.hershberger@ni.com>, "Ramon Fried"
 <rfried.dev@gmail.com>, "Tom Rini" <trini@konsulko.com>, "Marek Vasut"
 <marex@denx.de>, "Alice Guo" <alice.guo@nxp.com>, "Ye Li" <ye.li@nxp.com>,
 "Tim Harvey" <tharvey@gateworks.com>, "Thomas Schaefer"
 <thomas.schaefer@kontron.com>, "Vladimir Oltean" <vladimir.oltean@nxp.com>
From: "Michael Walle" <mwalle@kernel.org>
To: "Heiko Thiery" <heiko.thiery@gmail.com>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.16.0
References: <20250428095945.1432389-1-heiko.thiery@gmail.com>
In-Reply-To: <20250428095945.1432389-1-heiko.thiery@gmail.com>
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

--023ce80dd54248dd5f9a7639834dde4601b16c56936be6b2ed251eccbe39
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

[+ Vladimir]

Hi,

nice catch!

> With commit cc4e8af2c552, fsl_enetc register accessors have been split to

With 'commit cc4e8af2c552 ("net: fsl_enetc: Split register accessors")'

> handle different register offsets on different SoCs. However, for
> internal MDIO register calculation, only ENETC_PM_IMDIO_BASE was fixed
> without adding the SoC specific MAC register offset.
>
> As a result, the network support for the Kontron SMARC-sAL28 and
> probably other boards based on the LS1028A CPU is broken.
>
> Add the SoC specific MAC register offset to calculation of imdio.priv to
> fix this.
>
> Fixes: cc4e8af2c552 ("net: fsl_enetc: Split register accessors")
> Signed-off-by: Thomas Schaefer <thomas.schaefer@kontron.com>
> Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>

With the nitpick above:

Reviewed-by: Michael Walle <mwalle@kernel.org>

> ---
>
> But the question that now arises is, does this code path work on the imx
> SoCs as well. Now the imx specific offset 0x5000 is added here and was no=
t
> used before.

Maybe the imx9 doesn't use the internal MDIO controller or the board
which was this tested on doesn't use the PCS?

-michael

> Can someone please test this on an imx9 and confirm?
>
>  drivers/net/fsl_enetc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/fsl_enetc.c b/drivers/net/fsl_enetc.c
> index 52fa820f51..97cccda451 100644
> --- a/drivers/net/fsl_enetc.c
> +++ b/drivers/net/fsl_enetc.c
> @@ -473,13 +473,15 @@ static int enetc_init_sxgmii(struct udevice *dev)
>  /* Apply protocol specific configuration to MAC, serdes as needed */
>  static void enetc_start_pcs(struct udevice *dev)
>  {
> +	struct enetc_data *data =3D (struct enetc_data *)dev_get_driver_data(de=
v);
>  	struct enetc_priv *priv =3D dev_get_priv(dev);
> =20
>  	/* register internal MDIO for debug purposes */
>  	if (enetc_read_pcapr_mdio(dev)) {
>  		priv->imdio.read =3D enetc_mdio_read;
>  		priv->imdio.write =3D enetc_mdio_write;
> -		priv->imdio.priv =3D priv->port_regs + ENETC_PM_IMDIO_BASE;
> +		priv->imdio.priv =3D priv->port_regs + data->reg_offset_mac +
> +		                   ENETC_PM_IMDIO_BASE;
>  		strlcpy(priv->imdio.name, dev->name, MDIO_NAME_LEN);
>  		if (!miiphy_get_dev_by_name(priv->imdio.name))
>  			mdio_register(&priv->imdio);


--023ce80dd54248dd5f9a7639834dde4601b16c56936be6b2ed251eccbe39
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaA9TJBIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/gBoAF/W97SiwDxGWRxqHJbtKl5DSfbyn8OZAxc
SS4NBV4P7UPJAyqUGvRBjNyTWQ48tx43AYCSnwu3EYIV16I/m4wgBvHo/RxTgL2H
TB6wMdvpOrKFto16YAcNqjH40gPQir1BeL0=
=ZDJR
-----END PGP SIGNATURE-----

--023ce80dd54248dd5f9a7639834dde4601b16c56936be6b2ed251eccbe39--
