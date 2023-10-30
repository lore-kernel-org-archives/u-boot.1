Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65319C4332F
	for <u-boot@archiver.kernel.org>; Mon, 30 Oct 2023 08:53:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D587B879FA;
	Mon, 30 Oct 2023 09:53:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698656032;
	bh=BJN8loP0A7Hd3fyg6VqX/W3eQuwK/rkLh5Kwkm2Bs4k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nz8/L+IoSOL5s8yqV2T+wA4gV7yHzQs34xCkWnxp7u2pdioUvpd5NC0jbEAlmAp21
	 sApo3gmW4q1wk/J9y4fKnAy7fLRSZ7W7clk4ACudIW7wipjYsjUM6AmmLW9mlMzo0M
	 G8FL1ctYL9Tia4GAiUbP26rGdYJsfTVccdTpmeOCJHeGf1dsbp7hrbR+sUgRu+e8Gc
	 6b5g/ahLIqW9FQs/g4Z/LRzttD9OJ/N63Av3gz2G5+z2pBvAYrKRI2lw6Js5ab1/qG
	 WFgrD/c2wx6ZrUplVlrAVE5fjYBeNe0noc2+p8FI0MhOxYQz/5Q0aCEix9s7RRLlQo
	 jttyw29B6Nc8g==
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 30B68871D4;
 Mon, 30 Oct 2023 09:53:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698656031;
 bh=BJN8loP0A7Hd3fyg6VqX/W3eQuwK/rkLh5Kwkm2Bs4k=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=rO9+mdcFmzcJM8saUOXhDlFEAQ66EVAzHyGixI50NLg/KR5K5tshc7oYQAI/3PYbB
 O++fw81oHS5G3x0j9p7Roq1z3T+wf9t9X6oj5yC9WItxZEJecYuYTRDADb8HnVLs9M
 UoA09bPGkt1E0ahE+10qa3rM1dUSd0qly5sm0M04p+wKwwtxTuGoiTlEMHJvGTevzl
 OIKQmeVzJ87TMb8+hJvNGfHyoBEkgOLmPDj4YfDZKgvU8DyccMH6X5n20jHLKaOdUP
 I7xXAUD29Wx+imtCzuT9Ev7QaDduIk8EICAW4G3HIY447Mgdv7hiRnQBTjkAqZn4/Z
 xTtI+Blpz9NJA==
Date: Mon, 30 Oct 2023 09:53:43 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] dfu: mmc: Add support for exposing whole mmc device
Message-ID: <20231030095343.5a4d9570@wsk>
In-Reply-To: <20231029223740.284149-1-marex@denx.de>
References: <20231029223740.284149-1-marex@denx.de>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.fvW0QEZm79jk1YVWx3AX4T";
 protocol="application/pgp-signature"; micalg=pgp-sha512
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

--Sig_/.fvW0QEZm79jk1YVWx3AX4T
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 29 Oct 2023 23:37:22 +0100
Marek Vasut <marex@denx.de> wrote:

> Add support for exposing the whole mmc device by setting the 'size'
> parameter to 0. This can be useful in case it is not clear what the
> total device size is up front. Update the documentation accordingly.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Lukasz Majewski <lukma@denx.de>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>  doc/usage/dfu.rst     |  5 +++++
>  drivers/dfu/dfu_mmc.c | 10 ++++++++++
>  2 files changed, 15 insertions(+)
>=20
> diff --git a/doc/usage/dfu.rst b/doc/usage/dfu.rst
> index 68cacbbef66..8845a71df36 100644
> --- a/doc/usage/dfu.rst
> +++ b/doc/usage/dfu.rst
> @@ -121,6 +121,11 @@ mmc
> =20
>      with
> =20
> +    offset
> +        is the offset in the device (hexadecimal without "0x")
> +    size
> +        is the size of the access area (hexadecimal without "0x")
> +        or 0 which means whole device
>      partid
>          being the GPT or DOS partition index,
>      num
> diff --git a/drivers/dfu/dfu_mmc.c b/drivers/dfu/dfu_mmc.c
> index cdb3c18b01d..12c54e90ef7 100644
> --- a/drivers/dfu/dfu_mmc.c
> +++ b/drivers/dfu/dfu_mmc.c
> @@ -386,6 +386,16 @@ int dfu_fill_entity_mmc(struct dfu_entity *dfu,
> char *devstr, char **argv, int a dfu->data.mmc.lba_size
> 	=3D third_arg; dfu->data.mmc.lba_blk_size	=3D
> mmc->read_bl_len;=20
> +		/*
> +		 * In case the size is zero (i.e. mmc raw 0x10 0),
> +		 * assume the user intends to use whole device.
> +		 */
> +		if (third_arg =3D=3D 0) {
> +			struct blk_desc *blk_dev =3D
> mmc_get_blk_desc(mmc); +
> +			dfu->data.mmc.lba_size =3D blk_dev->lba;
> +		}
> +
>  		/*
>  		 * Check for an extra entry at dfu_alt_info env
> variable
>  		 * specifying the mmc HW defined partition number

Reviewed-by: Lukasz Majewski <lukma@denx.de>


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/.fvW0QEZm79jk1YVWx3AX4T
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmU/bxcACgkQAR8vZIA0
zr0XRQf/WikF6D1sZEwc6+NWlHUc+Rwhc15NYK08ZPwci6iCj+EbCTKyk+oprKvb
6zNntAW237wL/GB2uY6RIdqaQX12yGRtVpCbLl+HFbzqhmgC35c7vqRGokglRuWz
CmWYsIFlC/eElFdxKtvftyZj1QOcpWOvXZhLlE//VPU5Rd0t8W6kUqyD9GNLJw0D
73Z9eQIDefAINrAz4He19117k6y0rlD5niHCnlD6rgornD3GhjL9+dV2uplM5IAo
SGBqy5A+FskHYQgTLp8xGLEUFu5SnOysHHAjmIVFG4hpQoNb8kQbqowgBpHUnfRq
5vEn0+Z4BeFYMbdmkrry64BV+do9PA==
=SRCw
-----END PGP SIGNATURE-----

--Sig_/.fvW0QEZm79jk1YVWx3AX4T--
