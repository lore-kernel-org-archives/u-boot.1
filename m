Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E51BC04FFE
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 18:51:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D7848851D;
	Fri, 17 May 2024 20:51:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WohMWEV9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEB1488524; Fri, 17 May 2024 20:51:51 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58767884FD
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 20:51:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-622e32414ffso5122227b3.1
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 11:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715971908; x=1716576708; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gcbzITbjAG0eJrpUDrPtx2/+R/EE+oTiEP09SY4iYts=;
 b=WohMWEV9oYjke4+dOpcJ+CwOgd3yFitGpDnfaS++ou4GFg0pDGMEN3NyHo/VVsQHce
 FDlDVs02o4hK30ECwfJ1+OY6me81K6cQuY3+/UxGqFEC/ER23Zn/qjap/zZUqjPfvo+M
 epwAs8ZZr7FWb2sG31Pn+KFF1/KWNIKhnAuqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715971908; x=1716576708;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gcbzITbjAG0eJrpUDrPtx2/+R/EE+oTiEP09SY4iYts=;
 b=lD8u9tbgrJkNsmSCBB4z1fTaCQ/GjnZeqs/joza+YR+QMMhhS0WxTzmvw4GkpGt9/u
 M7+RtaEslZCcPDnNOs9Ej5SoAqcxlTiIFSm2XWG2vpWpH2rU9JaQ7EqeU4NDNI6EtAE8
 ebWpX0iHd5jtf2D8wVR/DDFS9dS/w5bh3BtTsLcaeoTU/AOfGQCLDQF+N1FpT+vrPNfb
 2wgXqu7ImzhjWNO7VSwJ9F/zMWb+ych5ic4rRmS5556tc9Q5noeGpg27kXDtNBNeKaUv
 mZ8k+dH1sxEvCcUv5POTaTPptYIMB/XlKt2KUq6G0tSxdHKJfkc/cWiJyeAOHA2NxXnr
 XZLw==
X-Gm-Message-State: AOJu0Yz3B63vkTGESGBE5HI0amYB7iS41txO1U8YLm61DBaqusv2X+4k
 cUh6S9cY83pgoGtwHQvBkA8kilYeYJlmXAzue607mka0Cvh32cegywrwrhVo1c0=
X-Google-Smtp-Source: AGHT+IGdxjxyfPI0dYjACRV75EyXFgATsXhS/8rs9IxO8wzETfp79C/kRQ9/Ql3VwBFATefoRJbLNg==
X-Received: by 2002:a05:690c:6906:b0:615:bb7:d59c with SMTP id
 00721157ae682-622aff9d827mr326198597b3.22.1715971908081; 
 Fri, 17 May 2024 11:51:48 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43e25f3ec65sm55992351cf.81.2024.05.17.11.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 May 2024 11:51:47 -0700 (PDT)
Date: Fri, 17 May 2024 12:51:44 -0600
From: Tom Rini <trini@konsulko.com>
To: jasper@fancydomain.eu
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com,
 Michael Glembotzki <Michael.Glembotzki@iris-sensing.com>
Subject: Re: [PATCH] env: Invert gd->env_valid for env_mmc_save
Message-ID: <20240517185144.GM2568172@bill-the-cat>
References: <20240510113834.826783-1-jasper@fancydomain.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="M9nWV3ORUZg4H21A"
Content-Disposition: inline
In-Reply-To: <20240510113834.826783-1-jasper@fancydomain.eu>
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


--M9nWV3ORUZg4H21A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 01:38:34PM +0200, jasper@fancydomain.eu wrote:

> From: Jasper Orschulko <jasper@fancydomain.eu>
>=20
> The A/B update strategy of the env's has a gap in the first 2 calls of sa=
veenv.
> The env's are stored twice on the first memory area if:
> gd->env_valid =3D=3D ENV_INVALID.
>=20
> u-boot=3D> saveenv
> Saving Environment to MMC... Writing to MMC(1)... OK
> u-boot=3D> saveenv
> Saving Environment to MMC... Writing to MMC(1)... OK  <-- !!!
> u-boot=3D> saveenv
> Saving Environment to MMC... Writing to redundant MMC(1)... OK
> u-boot=3D> saveenv
> Saving Environment to MMC... Writing to MMC(1)... OK
>=20
> Signed-off-by: Michael Glembotzki <Michael.Glembotzki@iris-sensing.com>
> Signed-off-by: Jasper Orschulko <jasper@fancydomain.eu>
> ---
>  env/mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/env/mmc.c b/env/mmc.c
> index 7afb733e890..2bef30c973c 100644
> --- a/env/mmc.c
> +++ b/env/mmc.c
> @@ -299,7 +299,7 @@ static int env_mmc_save(void)
>  	ret =3D 0;
> =20
>  	if (IS_ENABLED(CONFIG_SYS_REDUNDAND_ENVIRONMENT))
> -		gd->env_valid =3D gd->env_valid =3D=3D ENV_REDUND ? ENV_VALID : ENV_RE=
DUND;
> +		gd->env_valid =3D gd->env_valid =3D=3D ENV_VALID ? ENV_REDUND : ENV_VA=
LID;
> =20
>  fini:
>  	fini_mmc_for_env(mmc);

Can you please explain a little more on how you get to this problem? The
same code / test exists in env/fat.c, env/sf.c and env/ubi.c. In the
case of env/mmc.c it's been that way since introduction in:
commit d196bd880347373237d73e0d115b4d51c68cf2ad
Author: Michael Heimpold <mhei@heimpold.de>
Date:   Wed Apr 10 10:36:19 2013 +0000

    env_mmc: add support for redundant environment
   =20
    This patch add support for storing the environment redundant on
    mmc devices. Substantially it re-uses the logic from the NAND implement=
ation,
    that means using an incremental counter for marking newer data.
   =20
    Signed-off-by: Michael Heimpold <mhei@heimpold.de>

as well. Thanks!

--=20
Tom

--M9nWV3ORUZg4H21A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZHpzYACgkQFHw5/5Y0
tywJawwAg+fx1/LxcVNynf5oB+Be04TTHkeMGwySjM7TfHcS5BJdb0gKEjv8JUs2
f6PkgQbwhFEI9az1trtc3vA3+yIjlmMQUP1ratmtoXXRNYCdbZNaWBrPmbNn9F8+
6MzGmROW3Bqn7gxq7XDhgl1QOpOR629CKFOPpctF5eH/azDejhJ3vuPBH+tBDJsc
6nTQIl0q5G+KvNxoHRdN1rz32fLfQ6nQh/apQlE7iJxg6AqMzS0xLPHxx4rFhf/d
8mnyeZlBoLZIMjk16X95ee+CmurGjxXULIgXlKVknmOgEKOgw0cIWyW+LjCWruTT
+4iCpqqvNvH1JFn1ZGFOdj1QkKwJtkbNBoQGUmDPbTgIxgl3X3K2AAN7G9+KnUkL
GHKQYB9EKT7dVsV/FPbLM9+X9CoSj/Z5M9apv2Y8HxkbbvyRJu/6rSbC7TGVCYnl
xQqtrVjr3KHSg5Q1PFoavSZNugpW2GcdwYe0OW6CLCikz+MOe/koBTvxRYZnNZVK
8sH6oCji
=XNSM
-----END PGP SIGNATURE-----

--M9nWV3ORUZg4H21A--
