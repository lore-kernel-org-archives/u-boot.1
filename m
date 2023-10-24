Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D68C07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 23:22:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C19087A27;
	Wed, 25 Oct 2023 01:18:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hSsr+s6r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87AE186FE3; Wed, 25 Oct 2023 01:17:04 +0200 (CEST)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D65D879FD
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 01:16:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-d9ca471cf3aso4743608276.2
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 16:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698189406; x=1698794206; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=90//cWGpcNu6X33/luqZzXjbrcB0/uhmEUqtwcQxSbk=;
 b=hSsr+s6rPE+ft86aAInkWUKxXX0LghPzi34/MbTukI2saYqe2DDbtHMZVqeLlWRNes
 oNpmc3KsCmvlvjEt9mK9WDRGW37/+EKdXFjd4vvT1xXPui/HlpY5HghXUpxUKD0vAU4b
 5+GXg1cU9ig8NGC1jn/Gigc+8E4jrf2t7/tvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698189406; x=1698794206;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=90//cWGpcNu6X33/luqZzXjbrcB0/uhmEUqtwcQxSbk=;
 b=XI5uagoLY8IXQw8W1LBqCoENvNVqRw3cAG6SjwJJOfapIwS2rjuOx5EWAKWN9NJ10I
 /wo8YDMbrQWnJXb9qmX57MXW2aPQ7vFqBcXjBRzQzJUXygtqHc602jmMar+2dMiQioD6
 HD/0gzEqSNcnXe0yPaMMKOQuM3UelwOI1iULnBTo5EzoulKVH72kTHXQATUmyiI37pnp
 3kSCDoAdriSgqAwrf3Zdw5Hc3vWXEbMMY57fgvQZVm7DhdjUXGBtIt4FA5xbs34Uol1y
 3meQ2vxRcB8JzOQxACU7mAReo+yIxC/12zzjmLpMXHRuVD6dmCOUna5HXMIckht+XAUv
 ieiQ==
X-Gm-Message-State: AOJu0Yy/F5NE+DEDlRsHuNdpBtN3oO44fTalq3Qb/6oPCAYTU8hXdNt2
 PopK0dx5XWhZt6Yn1PxeFutaPg==
X-Google-Smtp-Source: AGHT+IG1Uy1tKVDzru4pXMk7uEOB+yJokvVY5ikVsZGaoQVaLHIhB3a0syL+gfheWYhVWXCiD7m2qQ==
X-Received: by 2002:a25:6a04:0:b0:d9a:401d:f5da with SMTP id
 f4-20020a256a04000000b00d9a401df5damr11534077ybc.51.1698189406162; 
 Tue, 24 Oct 2023 16:16:46 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-89e7-8c52-372d-17ee.res6.spectrum.com.
 [2603:6081:7b00:6400:89e7:8c52:372d:17ee])
 by smtp.gmail.com with ESMTPSA id
 j191-20020a25d2c8000000b00d9ace05037csm3967708ybg.13.2023.10.24.16.16.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 16:16:45 -0700 (PDT)
Date: Tue, 24 Oct 2023 19:16:44 -0400
From: Tom Rini <trini@konsulko.com>
To: Yurii Monakov <monakov.y@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v3] cli: Consume invalid escape sequences early
Message-ID: <20231024231644.GA496310@bill-the-cat>
References: <775fa336fa5bfb2b9e1e892ee631bd743ea12364.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nCML7YMHp5x54WTN"
Content-Disposition: inline
In-Reply-To: <775fa336fa5bfb2b9e1e892ee631bd743ea12364.camel@gmail.com>
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


--nCML7YMHp5x54WTN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 10, 2023 at 11:16:39AM +0300, Yurii Monakov wrote:

> Unexpected 'Esc' key presses are accumulated internally, even if it is
> already clear that the current escape sequence is invalid. This results
> in weird behaviour. For example, the next character after 'Esc' key
> simply disappears from input and 'Unknown command' is printed
> after 'Enter'.
>=20
> This commit fixes some issues with extra 'Esc' keys entered by user:
>=20
> 1. Sequence <Esc><Esc><Enter> right after autoboot stop gives:
> =3D>
> nknown command 'ry 'help'
> =3D>
> 2. Sequence <Esc><p><r><i><Enter> gives:
> =3D> ri
> Unknown command 'ri' - try 'help'
> =3D>
> 3. Extra 'Esc' key presses break backspace functionality.
>=20
> Signed-off-by: Yurii Monakov <monakov.y@gmail.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--nCML7YMHp5x54WTN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU4UFwACgkQFHw5/5Y0
tyzh6wwAlnV6t1MM9wZlSuL1Of6o0odCCjjhGyCz4aYAjLXrm5HZ+W3NcY8j8emy
+1Rwt+ZKbmjzWQnoMB1nu2g3CEBQM3bkYlMjv+jUZmcWO6TOqyUxomUWVpeU66GG
7FwsToSr07BziR7/AUaI+UY8SnmCLxYxO6XRzC3PPfw3gIWh20OzX7xSvF2JpeRH
KSu8jjdPjny7rSDxS5nJBXBJE2uArzYuu2o7MA2UOJqCoC/vIWCBQMQX8b8AnYnJ
A/xlPiD0CDg85eDIIjSRtqKdoZubJZur67SQeo2Z0H/BRtWj/KUxlScbEEepkfy8
UFelosEqAQMuPm1igj6j4hEuExUELs33m55lJ7djYXC2aKgXiMrlq+naQ33sh9CL
SIk6IFiUfefnXyCdbES9ZDwNhMzruwCl9wVue0bvU+3SpON3eHTuST4d7OPc11dd
cISiok7KwQarkFpOONTg6yjeVmsOoY7nhUL3gDraVagp9FCuMsBJUZspFSOHSZD/
jtSS4PQH
=8ov/
-----END PGP SIGNATURE-----

--nCML7YMHp5x54WTN--
