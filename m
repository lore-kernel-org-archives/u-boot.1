Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E94C44536
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 15:17:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B65AE8341A;
	Wed, 21 Jan 2026 16:17:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mSB/fFii";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81CCE839D5; Wed, 21 Jan 2026 16:17:01 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 017F383015
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 16:16:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7d122733808so1563330a34.2
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 07:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769008612; x=1769613412; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=r5VFeR885KSqunL2wFjOX4JlASFRDvlJhDDqnuMJLnQ=;
 b=mSB/fFiiefjnjeC/AcSfByHKFjHAntc/J+kZJ6nI5HYXrDijNypfDb5KDvt4jBUIwW
 8pVpWRXz9t9NLThayfVR74prHIUCWlOOIoAf0v3EEwFAnhPvrGNukuF+0r00uN3gfxlL
 ppUVh558qrMPmSaOmdL1PDDiJSMHrEM023XRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769008612; x=1769613412;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r5VFeR885KSqunL2wFjOX4JlASFRDvlJhDDqnuMJLnQ=;
 b=eiu/tUM2wfud2EaWZ3XHEGHg9rZU5U5e2kYZEF8e89BOqwVbKdQ4hArPI/UdPK1hZ8
 UdVdCcXqAs9IuwuYWoFlcwZHNWeGYJDt4Ae+0zgMnBrGmCtt0MBSXonMoP8l8iVBWI1A
 QMlGpKlIMPKLJpt4dxc/uDGHqWDktxjrjHjhvtB4rk/2l8h+oUEaKtkJNzlWJB+futSk
 OVLMfUM8DJjAmXGRcu97utgMBJJGoqKPEzoKggH9KZ9mf0bGtxkgaT7FaOKlYUS4+7T3
 MFs6LcziftUFpchXETaqupRZoN9oY2zy3LzNn767NGi9fsWC/oDYcLPitkhuRSGT/LLp
 0IpQ==
X-Gm-Message-State: AOJu0Yyrn0jWEXaBzB29meVV2xAYz2qW9a7Vyghr/0mAgUr5+FlgsxxW
 dcpJww3hrlwyPqsq6YrAm++Fhu2F10Pz2FQ4HBEvT2mL7MM9lmC9PBfOwk8kFawwih7wz+f7OQf
 LSWpHwsU=
X-Gm-Gg: AZuq6aKp1jbvgRc+F4D7KEHTQ+tQoUzfN+a/po2OCwJUFr0nMHX6KMIr1I0lEFMIr4F
 Sf4sv/aF271fJl78k7a6gwIo2eLeJCZN+fogGfg8DssW2d3tBgzoFGpxOfM7baBJ0fowfTigWxv
 M/P+opAAqln3Tba7oh/zl4CLek6AAfaKAAtmRtdAhsPpZKVKvXuWci3Io/zenkVu1OOfbh3yFuo
 NNpAhKTvU4SB1I+y4dlQ72cbst1tuKuq47d9fOfGn5dpo08S2C8p6j/goARsGQfRmw/tZoY/0II
 rxBhbKsd0sLeX9bW6aN14+qLxquixNO6iqUk5yQFw6LEPvjMoLNrDO86s0CJmf8vELfOBFhsNKJ
 7lvIiQ5ra/lNtBjZLK0HDvc5vVZ070IKm5pYcl06/AlT4CU1NWuVAPvaLXhqdX/XQob7Rt46Jr8
 ruGkWE3j/YjiLhkgVfIGXIt7VYHpfjLpvwjt3nl38EPBquTHR7TJc6CBYO+LkhXiQjTrHzwlPEO
 qqt20fONV40fT3kNPSyaJggAQnOG9WgeyNd+l8=
X-Received: by 2002:a05:6830:64cb:b0:7cf:d7ec:1893 with SMTP id
 46e09a7af769-7cfe0229ea0mr7052266a34.25.1769008612427; 
 Wed, 21 Jan 2026 07:16:52 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf000b80sm10684600a34.0.2026.01.21.07.16.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 07:16:51 -0800 (PST)
Date: Wed, 21 Jan 2026 09:16:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] armv8: u-boot-spl.lds: Place binman symbols at end of
 binary
Message-ID: <20260121151650.GA565300@bill-the-cat>
References: <20260112235832.3043626-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SBfOt6LPXwf0KsRA"
Content-Disposition: inline
In-Reply-To: <20260112235832.3043626-1-jonas@kwiboo.se>
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


--SBfOt6LPXwf0KsRA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 11:58:29PM +0000, Jonas Karlman wrote:

> It can be useful in xPL to access symbols from binman, such as the
> offset/position and size of a binman entry.
>=20
> Place these binman symbols together at the end of the xPL binary for
> ARMv8, similar to ARM and RISC-V.
>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  arch/arm/cpu/armv8/u-boot-spl.lds | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/arch/arm/cpu/armv8/u-boot-spl.lds b/arch/arm/cpu/armv8/u-boo=
t-spl.lds
> index c4f83ec9cfc4..4c7252f942c9 100644
> --- a/arch/arm/cpu/armv8/u-boot-spl.lds
> +++ b/arch/arm/cpu/armv8/u-boot-spl.lds
> @@ -54,6 +54,13 @@ SECTIONS
>  		KEEP(*(SORT(__u_boot_list*)));
>  	} >.sram
> =20
> +	.binman_sym_table : {
> +		. =3D ALIGN(8);
> +		__binman_sym_start =3D .;
> +		KEEP(*(SORT(.binman_sym*)));
> +		__binman_sym_end =3D .;
> +	} > .sram
> +
>  	. =3D ALIGN(8);
>  	__image_copy_end =3D .;
>  	_end =3D .;

This needs to be rebased and reworked to take in to account commit
8b0ebe054bb3 ("arm: Update linker scripts to ensure appended device tree
is aligned"), thanks.

--=20
Tom

--SBfOt6LPXwf0KsRA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXDt4QAKCRAr4qD1Cr/k
Co4KAQCP59R0y1QN8KuJpLmxfTnfAzXMsvRkWoycPQelElsu7wEA8baLL75a2X+d
BhJqkHuEYOaTBITBOeyBtWcdy65JxQw=
=cFC8
-----END PGP SIGNATURE-----

--SBfOt6LPXwf0KsRA--
