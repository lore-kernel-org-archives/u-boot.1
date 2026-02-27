Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D94EFEFB55
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 14:08:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72F5F83E76;
	Fri, 27 Feb 2026 15:08:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pKpTSeJw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFCE883E76; Fri, 27 Feb 2026 15:08:05 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6215483CDF
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 15:08:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7d4c9537f90so1470478a34.0
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 06:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772201280; x=1772806080; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TklCZlAjE/xMY6piCQrb9rY7vwOz+6ocEkqlHtu1zt8=;
 b=pKpTSeJw33U7MGvAaV86FGXs56El8JL1yp2R4zINr9oAfaSS9kxn4tby+1XB4JpS5E
 i6BX9+srsnAHmAP4TwHpfkM/GlAiLvFMjeO4Ai4y6npuZNzYfsro9x5txQlycG8g4Zs7
 LYIe+BX94Bo5h0lYR3hD5undUtgBKb+MCCrD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772201280; x=1772806080;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TklCZlAjE/xMY6piCQrb9rY7vwOz+6ocEkqlHtu1zt8=;
 b=jmY+DfohltewiTX9tgNAt+C4xgvAuzmvNhFsqbBou2ybPK5TkJaEY+eP4mZmh4bP54
 +9iECi+89b9XZacIFhVPLGRUQoeqj3pOzFRMw6ZyKMUA+B12F1DfVgRAIR+OhkDGc9If
 lisEkEtM+Su9k2pLKbXWnQ2ClbNu4Jb9sV7h1uwUurOfJWBmPLByFAkiS8TomhyVZMdR
 nJEy5Iu/S/8R8tb9euR2e1QCgStXav0hhLX2TGy9eNXwK8dt3XxbM9T5v2ziqSWgS6mz
 M2u7Ij8pBAxCE0FjICza9wFrU7rcgAoiUYu62qpPlG9f+ciItx7L9tUJI76KlEcDGzC6
 hxrQ==
X-Gm-Message-State: AOJu0Yw3O2ZTBxrV276pdHTuNoWn/ZqcLonZETVljmFY2AEgjJ0XBcqJ
 FQZnNEUBAMxAXxESV2ZgrGjK+76QcRLF6IELR+TWLYuDuM4e8257SXxQiLWikddwpAjnAmZsPPR
 FcOuH
X-Gm-Gg: ATEYQzyMZcQy/3t+2rmmaH20hZygaE1fhgk8cj9BSBAq84TllNycW9Jaule2km8eN9r
 4Ri3zx03x4qZ3fIZe5z/AV7l/A8lXEcubd1JFRJH5dcVZCGafRcdbosfoObS7HsY+EGMTEJWLcl
 AvLjGG+6njy+uLm7yHwq53QY/hgaVdt6AElAcUSxgNexnWF5g9AqqF2j15wonLGelGnsgAOo3H8
 qfkb4vEUJaZGuul03jE1u35HknGH+ewuoUHiqlGz3DX57mVtd1RlfbQtdLtLtpjYGK/2qbw0ksi
 pr7mJDbCyupy4SwhHtlq7oe+QzmcNmLebs5hsMT/k6cHFbVriDhJrRRjv+al1kU1qC2cX3pwkZN
 BVwj1zVJUNS58UzNJY/TMur9FhIQoB11Ac4eEkWy4Tis+764diQiDOl1v2cCFSvjXmi5kYNF/hf
 zTtB/r7BhPF2iU/V8PciSMQESYo1BGp0jXPaU9NIe0q8h/I3bvl6fpqeavpOVm8UFU/3jv/MSPA
 BUKGil5/5LcXxUzt4DqP8iNYRcPdfS6xiYfLrptFc/lJCpFO6k=
X-Received: by 2002:a05:6870:6121:b0:3ff:4bcd:cc37 with SMTP id
 586e51a60fabf-41626f9b095mr1970077fac.30.1772201279847; 
 Fri, 27 Feb 2026 06:07:59 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160d2cc08csm4387787fac.19.2026.02.27.06.07.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 06:07:59 -0800 (PST)
Date: Fri, 27 Feb 2026 08:07:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Boon Khai Ng <boon.khai.ng@altera.com>
Cc: U-boot Openlist <u-boot@lists.denx.de>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: Re: [PATCH v1] spi: designware: add support for bits-per-word DT
 binding
Message-ID: <20260227140756.GP1593142@bill-the-cat>
References: <20260227110434.5058-1-boon.khai.ng@altera.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eJHHAqMTYkbrTF08"
Content-Disposition: inline
In-Reply-To: <20260227110434.5058-1-boon.khai.ng@altera.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--eJHHAqMTYkbrTF08
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 07:04:34PM +0800, Boon Khai Ng wrote:

> Add support for the bits-per-word device tree binding.
>=20
> Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
> ---
>  drivers/spi/designware_spi.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/spi/designware_spi.c b/drivers/spi/designware_spi.c
> index b520c727900..c41436a1dfb 100644
> --- a/drivers/spi/designware_spi.c
> +++ b/drivers/spi/designware_spi.c
> @@ -359,6 +359,7 @@ static int dw_spi_probe(struct udevice *bus)
>  	dw_spi_init_t init =3D (dw_spi_init_t)dev_get_driver_data(bus);
>  	struct dw_spi_plat *plat =3D dev_get_plat(bus);
>  	struct dw_spi_priv *priv =3D dev_get_priv(bus);
> +	u32 bits_per_word =3D 8;
>  	int ret;
>  	u32 version;
> =20
> @@ -384,8 +385,19 @@ static int dw_spi_probe(struct udevice *bus)
>  		version >> 24, version >> 16, version >> 8, version,
>  		priv->max_xfer);
> =20
> -	/* Currently only bits_per_word =3D=3D 8 supported */
> -	priv->bits_per_word =3D 8;
> +	ret =3D ofnode_read_u32(dev_ofnode(bus), "bits-per-word", &bits_per_wor=
d);
> +	if (ret) {
> +		debug("%s no bits-per-word not found\n", __func__);
> +	} else {
> +		if (bits_per_word >=3D 4 && bits_per_word <=3D priv->max_xfer) {
> +			debug("%s %d bits-per-word found\n", __func__, bits_per_word);
> +		} else {
> +			printf("ignoring invalid bits-per-word %d\n", bits_per_word);
> +			bits_per_word =3D 8;
> +		}
> +	}
> +
> +	priv->bits_per_word =3D bits_per_word;
> =20
>  	priv->tmode =3D 0; /* Tx & Rx */
> =20

I don't see this binding in v7.0-rc1, did I miss it? Thanks.

--=20
Tom

--eJHHAqMTYkbrTF08
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaaGlOQAKCRAr4qD1Cr/k
Cph/AQDLzVCWkl6fXpOQJARoVgDn/NjcGBlMoq8XaPnb/JdL5gEA3yQv/QbeBCZg
pvf1l01/cz+64tfCZs4hv+9uvK8K3ww=
=exjS
-----END PGP SIGNATURE-----

--eJHHAqMTYkbrTF08--
