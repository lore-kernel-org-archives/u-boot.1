Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A9DECE582
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 17:22:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2973C88FEB;
	Tue, 10 Sep 2024 19:22:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sZIbKWu/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2E5A89049; Tue, 10 Sep 2024 19:21:58 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3CB988F65
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 19:21:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-457e153cbdcso45003361cf.2
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 10:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725988915; x=1726593715; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KXdD2ngHNmh2XvF4FLrRGKZT1D1Ky2XA9R8kbxH7zgU=;
 b=sZIbKWu/WIMh+GQZ07xRi/RD2WPAUK5T0Wtp9+cP/HRtS5FPaUcVUw5NZZtLK4hoM9
 Zg6V0Bjiomw6iP68wmCBHAwjDEAdE7fNmpqlIsL43jnSe+HBll6NfF6sSA4WlAn8gPvE
 6wkXNPIsuZ+C+fp6r7EmkZV21JRw9ytConJXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725988915; x=1726593715;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KXdD2ngHNmh2XvF4FLrRGKZT1D1Ky2XA9R8kbxH7zgU=;
 b=YBYLHOHWQXR/GorQsGAanKwl2cGdjZFfx7jwUkW7d1YRil+srxsnMu60fIsp/QEtAX
 1ap2u2hyQmKRnMDKo0tcEQiDZY8VPy99FbaVBCNAhfiYXdUIiISvbbNw1dV25J6du9vK
 xCi7VR9cA50hpBwWGv7V3/I4xbsVL1Hmcq0xmXA8aDPLIfXLxdpGzSnSw5sHwC3/341I
 APmU8dRApXsOcYl5Kwr6OkcGnn14TsnEFG8wQg+bpaVVIPSeTshXIxQVuQBXX48RJ3uq
 cspAaP7jytdrbDVoCwff9a6gyBVMXY2LwBMxSIgUhGzfURNvZi/Id9yUOV2KFALWR5XQ
 QuWg==
X-Gm-Message-State: AOJu0Ywt9uTmwWezEk8qd8FiVcegGlItaybUuzncj2CfF4q8v/2/DOgv
 3PZOuBQoBdFx2mWl0nq4TKY5XA9WUBdQh+dySyewxlSb+P+C9+pLawn8CoUfvgY=
X-Google-Smtp-Source: AGHT+IGMSKOFKk3c3lsDXf2+aJafIvU6ddh48rEBPD2kvMYeHOA1pa020T617WWfyweQG19miTahxg==
X-Received: by 2002:a05:622a:613:b0:456:8170:bfa5 with SMTP id
 d75a77b69052e-4580c67052cmr256182981cf.1.1725988915072; 
 Tue, 10 Sep 2024 10:21:55 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45822e7b3a6sm31422251cf.30.2024.09.10.10.21.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 10:21:53 -0700 (PDT)
Date: Tue, 10 Sep 2024 11:21:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: Re: [PATCH] sh: cache: Fill in invalidate_icache_all()
Message-ID: <20240910172151.GG4252@bill-the-cat>
References: <20240910001612.88569-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IVSwh2sAnLBDnxAc"
Content-Disposition: inline
In-Reply-To: <20240910001612.88569-1-marek.vasut+renesas@mailbox.org>
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


--IVSwh2sAnLBDnxAc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 02:15:58AM +0200, Marek Vasut wrote:

> Implement invalidate_icache_all() by clearing all V bits in
> IC and OC. This is done by setting CCR cache control register
> ICI and OCI bits.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  arch/sh/cpu/sh4/cache.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/sh/cpu/sh4/cache.c b/arch/sh/cpu/sh4/cache.c
> index d3c480e79ed..99acc599965 100644
> --- a/arch/sh/cpu/sh4/cache.c
> +++ b/arch/sh/cpu/sh4/cache.c
> @@ -33,8 +33,9 @@ static inline void cache_wback_all(void)
>  	}
>  }
> =20
> -#define CACHE_ENABLE      0
> -#define CACHE_DISABLE     1
> +#define CACHE_ENABLE		0
> +#define CACHE_DISABLE		1
> +#define CACHE_INVALIDATE	2
> =20
>  static int cache_control(unsigned int cmd)
>  {
> @@ -46,7 +47,9 @@ static int cache_control(unsigned int cmd)
>  	if (ccr & CCR_CACHE_ENABLE)
>  		cache_wback_all();
> =20
> -	if (cmd =3D=3D CACHE_DISABLE)
> +	if (cmd =3D=3D CACHE_INVALIDATE)
> +		outl(CCR_CACHE_ICI | ccr, CCR);
> +	else if (cmd =3D=3D CACHE_DISABLE)
>  		outl(CCR_CACHE_STOP, CCR);
>  	else
>  		outl(CCR_CACHE_INIT, CCR);
> @@ -103,7 +106,7 @@ void icache_disable(void)
> =20
>  void invalidate_icache_all(void)
>  {
> -	puts("No arch specific invalidate_icache_all available!\n");
> +	cache_control(CACHE_INVALIDATE);
>  }
> =20
>  int icache_status(void)

Thanks for filling this in, I wasn't sure how the implementation would
look from a quick skim of the linux kernel code.

--=20
Tom

--IVSwh2sAnLBDnxAc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbggCgACgkQFHw5/5Y0
tyxHDAv/cMLQB4n4N61sDOIb9d3/1q6l86cFRTNEEEB+yY0X0GOzCj9Gxn6T1TX5
VdwRCELUAWEjbnv4+NgSjoNFf556rPiqSrhXwXxkqVT2ZOV/QXosBkvNsSi00h1F
9f0kpMUhnVm96XggAFri6832iTIEVy6MOlYAY2NQ2Qs164Iis/0otuC4z5uXLBWD
e9BGFA9xSwOShvD/Od/AoRkHIdJUwIrh3wDctxi+Bqrgv2vlOYXgMSZns+tsR3Au
Sfk21sJyC7/ZiKWbk8e4RUdh/AYA675flIR4aEjPwqws8B2ziws1YRly9Hs2phxH
+IEjWuw0ELecjrxi+1QYsxZAHnA3hYHdLisCjtyl3aCdUR/8v+6S4d3NAfWPZl+V
UCcbzxAz7rPkDNhQ7YipUd/s8B6CiVg2rMs1Xr+hVEK5aY/Vj2F5wtDMG/fAOk7m
ZZ0Hcq+9KGcHXTgO8jXZGQFoDtMn7pumi9KFOQIsWMjRrtTLVRY5MglYTxtlj45R
SjNgRvWg
=znXm
-----END PGP SIGNATURE-----

--IVSwh2sAnLBDnxAc--
