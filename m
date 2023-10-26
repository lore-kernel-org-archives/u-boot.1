Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF8BC25B67
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 12:48:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E33287553;
	Thu, 26 Oct 2023 14:47:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DaLV42tu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BF6287B1A; Thu, 26 Oct 2023 14:47:49 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D2BB875ED
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 14:47:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7781b176131so62539785a.1
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 05:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698324465; x=1698929265; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=It5v5UEWGYkfLmYrINTJ3GJePBA2w4GK7S1bB4oYHx4=;
 b=DaLV42tuXXzts4oCrjYyJ2jq1Ga+BkwoDp84vc+lJvvZ9V57AptcgFx3mFkst1D4Pw
 zrNBAFyPtCS3dXJlTFpsf2XzsBwcH1+ODxOnX9HnfkykSNC0DIKrM5l2JtQ67I961KQd
 Q3J2umpPZTCZMCeWMBEoPZ7ZXFg/0eOiBIcxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698324465; x=1698929265;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=It5v5UEWGYkfLmYrINTJ3GJePBA2w4GK7S1bB4oYHx4=;
 b=eeqQ1P9+9LNzX3eAGvjDnLwJuLviQmK2ao5hQp9wcoDF11QjHgCziFMJQjmnzOObbJ
 IApV3AL7ESVGlQ5XmaVV9NNkudqY0WMUw+0qRL7z/kzZGfQkiwce9Z80iJn/bzQ5nnw5
 ZXnHairu74VoR9Pc4230q+RjXCMkZEgXyjpWHggDgn/6bqXXfKBdAQLY7vEYUYqsRaOC
 igkmNzBJVN/lSs+dVez6bwYnQHZfYAkZAPmTMNNqn8qOcaKdmEEQ6kQ/LGGPFuumWn0C
 dNKRklwiY/cN8saYGujxGvjA3h5sXmcM+BalF/1r8RhPXO4Icl8NLgsj5FB9iOrAB1eu
 uILw==
X-Gm-Message-State: AOJu0Yz0viyR5W4xQjD0xF8twYN5sO0PYT98fNFieVaTNPrUSZZkQmif
 YZqv8rd8C5mnO8NoYRDxnhiXNw==
X-Google-Smtp-Source: AGHT+IFK7l2WDXnx4s1b9pFPY9ABB38G21m23WehC2eMDoEHsiuzSue6STgHyN6h7N1xrJUB/LLTDw==
X-Received: by 2002:a05:620a:454d:b0:775:7535:3ed9 with SMTP id
 u13-20020a05620a454d00b0077575353ed9mr23113945qkp.40.1698324464937; 
 Thu, 26 Oct 2023 05:47:44 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-7a1b-75c0-d849-e3ce.res6.spectrum.com.
 [2603:6081:7b00:6400:7a1b:75c0:d849:e3ce])
 by smtp.gmail.com with ESMTPSA id
 y9-20020a37e309000000b007788dac6b24sm4975465qki.41.2023.10.26.05.47.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 05:47:44 -0700 (PDT)
Date: Thu, 26 Oct 2023 08:47:42 -0400
From: Tom Rini <trini@konsulko.com>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: sjg@chromium.org, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 jbx6244@gmail.com, u-boot@lists.denx.de
Subject: Re: [RFC 13/13] block: rkmtd: select CONFIG_RANDOM_UUID explicitly
Message-ID: <20231026124742.GD496310@bill-the-cat>
References: <20231026053052.622453-1-takahiro.akashi@linaro.org>
 <20231026053052.622453-14-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RM8aBmNKVIlGwDoJ"
Content-Disposition: inline
In-Reply-To: <20231026053052.622453-14-takahiro.akashi@linaro.org>
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


--RM8aBmNKVIlGwDoJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 02:30:52PM +0900, AKASHI Takahiro wrote:

> This option is necessary to compile any way.
>=20
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  drivers/block/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
> index 048a6caef00f..5cda21551043 100644
> --- a/drivers/block/Kconfig
> +++ b/drivers/block/Kconfig
> @@ -265,6 +265,7 @@ config SYS_64BIT_LBA
> =20
>  config RKMTD
>  	bool "Rockchip rkmtd virtual block device"
> +	imply RANDOM_UUID
>  	help
>  	  Enable "rkmtd" class and driver to create a virtual block device
>  	  to transfer Rockchip boot block data to and from NAND with block

Since it's necessary to compile it should be select not imply here,
thanks.

--=20
Tom

--RM8aBmNKVIlGwDoJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU6X+4ACgkQFHw5/5Y0
tyx8qAv+Pi0xAGb26XwA2v8hRHX7fFtl99h2q8+k1SYm8TQydTdoDPKWDNrK/V5Y
glHjEZifAacZ7nVmFqHPu3eTEASZNsVNkXlW76a0wg/5R5eYGyvnjW6gOMTNrOYv
lDYpDiEmSHAM39BTUbLPrqb5DKviuDtc2D4zJu2Rml4Rux+HqZyY8PM2B72wyacj
hGEr3KNW0jW61/lHC9Jyuy5GZsbYRdxyyv9dR3lq73XAmsbRkyNCi6ijyd1sUZb5
zVzksFcuWMli7CjPNJPNSXf3tVG/VzFsFssIgEFaPSvl+8uEY+4+GimAtdIwnFZA
pAgdme7E5CXVGIzSQ+lCP/HPh6/rzYmwyJ3BJEQ7AqO4Ih6K0CBVexdvgivje7zH
zOTbEHdzTm6NPmAHOiMW6VLLFf4dBnHnvFlpZb48pNq4WMS0wIsPyRvIVO76rXiJ
9wVNghRBRZeRuvy9jFKNQx7BcNEY4TRcZjVTS4F1KTFLkJtB1vAGWx3WOvJhr/5+
wHAvk/UF
=McWF
-----END PGP SIGNATURE-----

--RM8aBmNKVIlGwDoJ--
