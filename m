Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5483C5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 20:54:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F6F781F0D;
	Fri,  6 Jun 2025 22:54:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VC2EgEas";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E60782145; Fri,  6 Jun 2025 22:54:17 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7CF4807B1
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 22:54:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-4067bab37a1so2065748b6e.1
 for <u-boot@lists.denx.de>; Fri, 06 Jun 2025 13:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749243253; x=1749848053; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7vLnC8n4GbXIJm9tuEit5eesxiVr5kwQY1/d1tvT2Zo=;
 b=VC2EgEasCpA8xnKrgfWeec6+ZluM5aK8j6RHMNOCrWuof+Ig+j+DtuI+hLD3XiAUBE
 GhUXv3CFRYV9Er24l8Q7mK3Nt7KVd4sNKNbJGZixl/uRN/UghAARwsK57IKgFyhHWP7L
 GYw4Thkmgc0n9QQaSbNKca4Q4yPggUOosHLWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749243253; x=1749848053;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7vLnC8n4GbXIJm9tuEit5eesxiVr5kwQY1/d1tvT2Zo=;
 b=oJ27IbDuPhKt1mo8BBntKtfVzJEQpKxu0siQdUKMn24DsvFzqld89sUKMs2OAdNQIq
 pgoC2sSOXc/4mUv2ivr2o+JwJ6l/8fji3HzV8cnpG75+rsPu/HQdsGYzbAJdA/3dqKZz
 V52hz1R4MFg8/vfg+kMUXeMOXrcow2xRN0boVT6uPofumZL6t/Rnbghh7M2qOObl1K8Y
 2QKz39yILM2rCIVGDOBIer2HCBN8oFC+q5Jk6thayvuiI3ZfsuuAz7gJ1JKdAxANSwAa
 +ouS3bvGYD18LOusgT9dDwnzUMYVf4KV/SagI77KZ7jEzvuWy/PkgEFudNaM+x3o95r5
 BzaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5XM09amues1goPn8JDhhSYzd2ty178a3Es0DGpeM8emD4isXv6NP5zdB6scnnWdrp/PXlKN8=@lists.denx.de
X-Gm-Message-State: AOJu0YwYYeZQncsziDl99zScHIlcHUDfRVh45CaWdMXlRei3gEUkipmB
 E7wV1BKvgSxi+D8ofTCyUZVR37hWOkdl1R+K2OCeTXF0NU7scgZjM/z2OY9Q3VtbkHc=
X-Gm-Gg: ASbGncsaB4XC++unM5Ep20c+xyzzOXvrnYMVdwPN1nkYt69iw/szXi/d9LAKj349TYP
 lIbIYdF2Wr7h8wXd5zbe3/7IqiTp9NP7vfBGNSsp6TR0HnqFJNEkHldej4xLCpkWSbhojvsNnnl
 8L6EAyaTrS+vCsyZCLN1UKjmgCooVfWc6I8W3O/1KQ1giy+Xc5uPbwNE8VC68xJxflioWQVcI2v
 caYI0iGw2/U30trBFm1PsdHGBzWWaXnm8v9QJWXH5PYTMpEiQLWhw8kXR2ZsNco7FcmXikk28kB
 nJRKPK9Lk98arm4zqrV0AJifkdM6dqvHLx+YR9cvjPIMsl2q16oEfgSkgyas9Ip7D7K4WlWCC7t
 ZFxeTDqV/qbUX
X-Google-Smtp-Source: AGHT+IGSrzZ9+fQzf29YFyVnWvjZOaX1Tjju/WdzgFScCLGr+FVM2z07GWRsTCDD9/PEtrQZZlxj6Q==
X-Received: by 2002:a05:6808:6a85:b0:403:3195:58cb with SMTP id
 5614622812f47-4090522fc80mr3279230b6e.28.1749243253601; 
 Fri, 06 Jun 2025 13:54:13 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40906a1053fsm497875b6e.38.2025.06.06.13.54.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 13:54:12 -0700 (PDT)
Date: Fri, 6 Jun 2025 14:54:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sam Edwards <cfsworks@gmail.com>, u-boot@lists.denx.de,
 Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH 1/3] common/spl: fix potential out of buffer access in
 spl_fit_get_image_name function
Message-ID: <20250606205410.GC1382132@bill-the-cat>
References: <20250606193524.458095-1-mikhail.kshevetskiy@iopsys.eu>
 <20250606193524.458095-2-mikhail.kshevetskiy@iopsys.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/KMXKMTpBcD3e3LI"
Content-Disposition: inline
In-Reply-To: <20250606193524.458095-2-mikhail.kshevetskiy@iopsys.eu>
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


--/KMXKMTpBcD3e3LI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 06, 2025 at 10:35:22PM +0300, Mikhail Kshevetskiy wrote:

> The current code have two issues:
> 1) ineffective NULL pointer check
>=20
> 	str =3D strchr(str, '\0') + 1
> 	if (!str || ...
>=20
>    The str here will never be NULL (because we add 1 to result of strchr(=
))
>=20
> 2) strchr() may go out of the buffer for the special forms of name variab=
le.
>    It's better use memchr() function here.
>=20
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  common/spl/spl_fit.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> index 86506d6905c..ab277bb2baa 100644
> --- a/common/spl/spl_fit.c
> +++ b/common/spl/spl_fit.c
> @@ -86,11 +86,12 @@ static int spl_fit_get_image_name(const struct spl_fi=
t_info *ctx,
> =20
>  	str =3D name;
>  	for (i =3D 0; i < index; i++) {
> -		str =3D strchr(str, '\0') + 1;
> -		if (!str || (str - name >=3D len)) {
> +		str =3D memchr(str, '\0', name + len - str);
> +		if (!str) {
>  			found =3D false;
>  			break;
>  		}
> +		str++;
>  	}

Looking at the loop, I'm not sure why we're doing what we're doing here.

It's possible I'm missing something else here, but, fdt_getprop is going
to return us the data part of an fdt_property struct. When index is 0,
the normal case, we don't loop here at all? Then if the index is 1, my
head starts hurting. It's unclear if the case where we don't have a
string value returned but find the node works, or maybe it does because
we always try the next hunk of code?

But I think we should try and clean up what's done here now that we're
looking at it right now. Thanks.

--=20
Tom

--/KMXKMTpBcD3e3LI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhDVW4ACgkQFHw5/5Y0
tyxH1gv/QR6cnMlD5wiz1LXU3jR47GJV41wm78qqH7t8+RvqzCvwOUlYWoQT1LZd
QwuymG5q4klDzwpqAkV7lNZBlAN75Md8SBH80gyKR2ImOpUtRQE+EsEp1klgZynf
8df8P850zQpnWr4HNWvcAfrcsZVFT4RGqRbTBU7j6F0UnsUj91L51xn5XStedX9i
huaDwAGoqh1s+dRYRJ0W9/Vr63rfxqTnndhsJvt3A2qQGUFX6PDG7EPw0/PkbIIX
CiZxdK3vHrvueqLAJOx9RtB/KAt6Lx/D24F4Th1Uqbd4tjouUfr3Jl4da9N1qJRU
hUdzAyEafOn+0rJlpw1l5i/al5SK5mJsiO1xK+c7pnSHXe3tGVgvHVp1iwaptjgq
eO9GvtJlfr2H7titTTvgfWoTf6IrkU+UZJHZt/WCHjMXjXGk6792JE8PMUUd2j08
XOgKtsBsnqvrUXa45IETfuKhDHEhC1i2aVNgV0DkYkxhKxFP686qIwAQMkfCGJju
KJ9qFZOe
=3Aek
-----END PGP SIGNATURE-----

--/KMXKMTpBcD3e3LI--
