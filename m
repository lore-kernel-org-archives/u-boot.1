Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 546E2C87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 22:39:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A6EA8277D;
	Wed,  6 Aug 2025 00:39:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aSYGWltl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0506E83020; Wed,  6 Aug 2025 00:39:55 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC2F581D5A
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 00:39:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3e3ea9e8154so27728675ab.2
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 15:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754433590; x=1755038390; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dY3TcMuFf+0MYN7NOAZ1/3HCewW2vwkB5kyEVv06wbE=;
 b=aSYGWltl7VkLN23UZ0dMdxm59Qmfse8SU/vHKjYkkInYgX6Pk0Jy7CLM+tkj+DhDhc
 MkV1ZIctD0JT6rOcRDtKX8CMTVAbza329GsWPD1b/CSwXi5tTFwN0PXyLcSK5911U29l
 avFJRLU9SKpDPY9rfQ6jzgttBYjWCd/YHQhEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754433590; x=1755038390;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dY3TcMuFf+0MYN7NOAZ1/3HCewW2vwkB5kyEVv06wbE=;
 b=CjnfhDo+yXMKb9w2XXdoe66ILVbLZ5u0zrLkP+JeRDM7tiGAnsU9CiqGWSzYWbG67U
 hD8AgkOD+j4SKXul6v7E33hYr9Him64NLF+qLz3xw18i8wHZwsMAgWFICAtGdU1ZH3WT
 9c3qowbD0CLI+RT3KX9LWsL3LwwP/ZcRqsUdKPlBrLLcA0bJsbj7Wz+j51gPeps/BM/m
 nsUZB7FOCLpE12eneqZEQoDXZAlPwbaDK6/J02/5YhBm9QLvzDTTzzKvdiwJCFg+thCW
 8RysV0LYxznXLdWZc5qoEdQDmZ8vEVJ0Z+ehrRyoFlIT6t896iGTLxoZlUVRMMYmxfPe
 Ibrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVA0VfZocGK6dGUOYxMntJEkV1V+pfcwmNMyg6a8IkKBJ9O8CtCdZEcneK/YYIOWJR9jibpiHk=@lists.denx.de
X-Gm-Message-State: AOJu0Ywx6pS5o1XPOFnzzt1ID97aleNyvMW5QdO5DeUWcJLjIG0JwcI+
 vEAO0ckTn+eXNs1nkyaI4JUXtMNrN6/z0jS6BWCEccOdkssYtQEX0AFcXG6juxo1vLQ=
X-Gm-Gg: ASbGnculXI9pnGIAZv1PfqHEcEFRIwSRDzqn2gi0exp1NdTKU8/BPjMKifsssSkYY5a
 ki4MeT/FnlvNdWCDYuTsmSGDJ6O23MiG4qmMCjoXlWr/LqgEjZi70z1TN/vuJRDrCCP8i3Kgi9u
 2ekf1J9o65VwmNs2nxYNrepYOqjiOapvgaZEh6Eh0VZWuH8bJGKfk6jT2EhViQSn3xAG4eaoO6Y
 ktUKssYxHLElGT32iw1WgXNQXjJjHlJgiHtJsH1dfLtaoW9sediJAAF3jW1XU4p2VM8CaqNfL3X
 G64nXpij1Q8XAcNzS0fJDhc9cPPFmQqH9c1yaewaqw4IWQmfqFcaswkr1bQ8ZCmIrV7PZFKD1o4
 5ufzNoxMlHNfc4FWhRbvKVKk+rPiD6uMqS1gYZjIrczHeyajG73j8X9hJ
X-Google-Smtp-Source: AGHT+IEGRERyF/U55Lwzk787uqKjwMmIz3OC5cbWuTub7vMdXgVf+2nA/Dlh2wdrjkQRusZ5tJyzpw==
X-Received: by 2002:a05:6e02:2489:b0:3e4:e3f:6031 with SMTP id
 e9e14a558f8ab-3e51b8986e7mr6756135ab.6.1754433590392; 
 Tue, 05 Aug 2025 15:39:50 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3e402b12e8asm55701965ab.48.2025.08.05.15.39.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 15:39:49 -0700 (PDT)
Date: Tue, 5 Aug 2025 16:39:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Judith Mendez <jm@ti.com>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/2] soc: soc_ti_k3: Add support for AM62P variants
Message-ID: <20250805223947.GL124814@bill-the-cat>
References: <20250805161419.1781935-1-jm@ti.com>
 <20250805161419.1781935-2-jm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Xb/aO2sL1sKP4TX0"
Content-Disposition: inline
In-Reply-To: <20250805161419.1781935-2-jm@ti.com>
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


--Xb/aO2sL1sKP4TX0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 05, 2025 at 11:14:18AM -0500, Judith Mendez wrote:
> This adds a support for detecting AM62P SR1.0, SR1.1, SR1.2.
>=20
> On AM62P, silicon revision is discovered with GP_SW1 register instead
> of JTAGID register, so introduce GP_SW register range to determine SoC
> revision for AM62P.
>=20
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
>  drivers/soc/soc_ti_k3.c | 70 ++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 65 insertions(+), 5 deletions(-)
[snip]
> @@ -130,17 +184,23 @@ static const struct soc_ops soc_ti_k3_ops =3D {
>  int soc_ti_k3_probe(struct udevice *dev)
>  {
>  	struct soc_ti_k3_plat *plat =3D dev_get_plat(dev);
> -	u32 idreg;
> +	u32 gp_sw1_val =3D 0;
>  	void *idreg_addr;
> +	u32 idreg;
> =20
> -	idreg_addr =3D dev_read_addr_ptr(dev);
> +	idreg_addr =3D dev_read_addr_index_ptr(dev, 0);
>  	if (!idreg_addr)
>  		return -EINVAL;
> =20
>  	idreg =3D readl(idreg_addr);
> =20
> +#if IS_ENABLED(CONFIG_SOC_K3_AM62P5)
> +	if (soc_ti_k3_variant_in_gp_sw(idreg))
> +		gp_sw1_val =3D soc_ti_k3_get_variant_alternate(dev, idreg);
> +#endif /* CONFIG_SOC_K3_AM62P5 */

This isn't quite what I meant, as it will generate warnings about unused
variables for the tables, on other platforms, yes? What I was thinking
was:
if (IS_ENABLED(CONFIG_SOC_K3_AM62P5) && soc_ti_k3_variant_in_gp_sw(idreg))
	gp_sw1_val =3D soc_ti_k3_get_variant_alternate(dev, idreg);
which shouldn't. And then can we check the other platforms similarly to
save space or no? Or am I unclear with what I'm thinking (or it's not
possible, I didn't dig at the rest of the code much)? Thanks.

--=20
Tom

--Xb/aO2sL1sKP4TX0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaJKILwAKCRAr4qD1Cr/k
Cge1AQCRHDWXuzioYLB3z/4jA49acKEMxMfUO0G19UexXsgcQAD8Cd0GQUgs0Uko
J3vio90DCOuKMDuZTPLj4Cafmp0d1wc=
=3v3Y
-----END PGP SIGNATURE-----

--Xb/aO2sL1sKP4TX0--
