Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3AD9C54E76
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 18:44:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E40F86BFA;
	Sat, 18 Nov 2023 19:44:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YN7ZTwlG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD7F186EE5; Sat, 18 Nov 2023 19:44:21 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8B5E863FD
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 19:44:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5a82f176860so33500317b3.1
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 10:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700333056; x=1700937856; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=INZuPQSNqxG4SLbLmwvzwBN/+oJa+Ntovz013HYzA5A=;
 b=YN7ZTwlGNmsXbT7vzsIAUqgbCw7IW61tloHmAIbOllDgvFvQdGfhhglznfTE7LiCPk
 1AtaEqei5YtNiIvW2bQwNTFcqygLFeyg7qxNDiRkajp4lqHVNxCS3QhXBcKdfr8uLCAy
 8ipGu7AwrCefzCIiKU0UD+8ci2kn2nuR9Srkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700333056; x=1700937856;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=INZuPQSNqxG4SLbLmwvzwBN/+oJa+Ntovz013HYzA5A=;
 b=itLAhdmUU+6OiUgoCGyQ5BTbuZ2Q1EyI4/mV9pn/9Jngy5bjwRksCx4P8ONCdUht4y
 sA0Ryx1QbS5OFNWIzyCBcH/EbhETPvB2LboNszlM80ZZ5Nmq6bCTvmmxyyGDVjNDetGQ
 /oTM4cV/UB0Vkv1ZgYe9NA2/Fcf3Jg/4Rgxy9evZRtgVfIW1MEmf7Nt7LXhovVdmV+59
 ocM+JKBZm3dM9fPjsy9BYWqbTzYVyULs9GilZP05yunv1IVttgQZSgwtO1dCOoYbBDLo
 pIng2k7IpR/wZM+epE0PsnQM/Ci+V6bMUbkKyC0TQ+Ez2cxcqt0hx+ZOcNLFXCcggz65
 y22g==
X-Gm-Message-State: AOJu0YzyRB+mf7MZZSrmbt9rUhp5y80GqPcvJuPZb0VYUOYDjdY3vfHM
 5+xsKQnRvGo9u0Mira06IJrNFA==
X-Google-Smtp-Source: AGHT+IEfqCEwzU3tz7RPYoyP11iswFI3zs6x/4s1B+k1TzKxs6WAb2vZT4CT/K+GEcSfg/Tf+ZCk5g==
X-Received: by 2002:a25:ab4f:0:b0:daf:749b:bcd1 with SMTP id
 u73-20020a25ab4f000000b00daf749bbcd1mr2634491ybi.27.1700333055863; 
 Sat, 18 Nov 2023 10:44:15 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-dbd8-aafa-ccfe-bf84.res6.spectrum.com.
 [2603:6081:7b00:6400:dbd8:aafa:ccfe:bf84])
 by smtp.gmail.com with ESMTPSA id
 t23-20020a252d17000000b00daf78e2e63dsm1064201ybt.27.2023.11.18.10.44.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Nov 2023 10:44:15 -0800 (PST)
Date: Sat, 18 Nov 2023 13:44:12 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 4/5] sandbox: Audit config.h and common.h usage
Message-ID: <20231118184412.GK170968@bill-the-cat>
References: <20231117225313.2144665-1-trini@konsulko.com>
 <20231117225313.2144665-4-trini@konsulko.com>
 <CAPnjgZ2N__uy8qdhJfwzrk088dyG8fFGXbsh4-Z4yWa6rkDFNA@mail.gmail.com>
 <20231118174550.GI170968@bill-the-cat>
 <CAPnjgZ2vYJbk_pU9DgnQTfr_DavFM970v4PfWdEpUtjEx441cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oX68s7Rg8WJ8MeFy"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ2vYJbk_pU9DgnQTfr_DavFM970v4PfWdEpUtjEx441cw@mail.gmail.com>
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


--oX68s7Rg8WJ8MeFy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 18, 2023 at 10:58:50AM -0700, Simon Glass wrote:

[snip]
> I found these:
>=20
> https://patchwork.ozlabs.org/project/uboot/list/?series=3D262148&state=3D*
> http://patchwork.ozlabs.org/project/uboot/patch/20210925121958.26001-1-pa=
li@kernel.org/
>=20
> IMO the second one from Pali makes sense, but it was never followed
> up. It doesn't look too difficult.
>=20
> We should have a policy that if people complain about a patch but
> don't follow up, we apply the patch we have.

I think the patch from Pali was the right direction, but as I noted, I
wanted to see it implemented for some other UARTs as well, and it wasn't
high on anyone elses priority list. Covering ns16550-style UARTs too
would be good.

--=20
Tom

--oX68s7Rg8WJ8MeFy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVZBfkACgkQFHw5/5Y0
tyzIoQv/UIEiLHPeeqsGIgNIHXV6l6rm5NLy2x/7vQd1Gi8LKpx3JZhgT0MS9FVp
bOmcBlMBd02XEt7E41ZSpuPp2YcqWcAJga9o1hGdfK+szrXvs0ZGbweJft3bUHRe
YFXfp/zuySdWFjKI0wj8cO95GCt6yrjO4NXdMQqhF5EP61Ypld4JmIyVds4kdC8p
25tXjMJ4QdL6CBvuqZ5aCUGD0L+GXTKcpMebEXIW6FHOP88/jUBlzpOshFMbAzTL
Zq+fZVYs+0Hrnjg2avETHRwPXTG60JyyLaVtzgEemA/wCjG4ANpO1PZsH74t3pAt
1rbS6YKtJUDYKhbQDPC84fieo4zT3ki6xrsneEk4xxK3tlFnysuMxucB3B/6iO4Y
X5pTnKH7CcRnr4IRKnOyK0UmLvJM4EW/IShugNOsBJUCYNk0q3vb7QNOUosGV7s6
MO/QfRh17FNh+PWQCO+x5hhfB+gOfgrZ5bEkTJONhJHrlmKPIZeIAVckkEXo4Ooh
tciwcR0/
=LAYM
-----END PGP SIGNATURE-----

--oX68s7Rg8WJ8MeFy--
