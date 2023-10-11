Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A304CDB47F
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 19:24:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF7AA86DD9;
	Wed, 11 Oct 2023 21:03:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bF8aHzgV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F351586CF3; Wed, 11 Oct 2023 20:41:14 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86D9586DB0
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:38:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5a7c7262d5eso1957517b3.1
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 11:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697049449; x=1697654249; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XjXnK+XsSzFFzje1VobJE6WXX38c8AevP2oGyP6m8JI=;
 b=bF8aHzgVBlCcUt1DoqB7olCWfwa5tdU3t27MxaNRSGcNAykFGPoXK3XBI9izZhGp0h
 aoNQe9IQw9EUqvd6kWHw66m4s9v4Qt/Bnxubl5Gwxxng+nUBv8OOFe8vWp+NT1965LnF
 Hbn9a3WC3wHI+cl70thlzbpSXxNjU4ZwGqOgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697049449; x=1697654249;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XjXnK+XsSzFFzje1VobJE6WXX38c8AevP2oGyP6m8JI=;
 b=agoIk/CWOJwP4nsr3HwEi1BKuzgAwUiicR30GBVKOxtTDc9A3rUGjWsvpZHVkUMKlE
 a1ajSDqgx2sv19oFLf6SGmYWDQYKxN2cjBV/esyCw0/TefxOd/kVVKEPDa1z04myjy5P
 p0vFBHfHOJA2nPDH6Nf+SsPI94kTdjQcYLzVtKqVI8U0hkPkgFw1JBHe1HI0AhUO+v9J
 olH7206I8Lgmm/QA5mFhk2np5n3QYlG1cjVtPwcz5y5Rnfp0hnUAyQHpU+/SEXmEywMR
 GZT6BlPhhooH8QBZnguUXhfbF1XrgVSqfFnmNRzkjTuA8sYH6AcD2dmlgZhKeO7vmVF+
 chvw==
X-Gm-Message-State: AOJu0YzpCua+QtY2RVmQvT0IkCgori6rklol5mVQRUda/JL/f8yVkYO2
 MeuqNHaVNUxprgx+EXKe5rZ54m818jA7eY4N3y0mWw==
X-Google-Smtp-Source: AGHT+IENDbrAKgp+odfKwoq5xGjRXdTb2Bc41sefQclx2NCG/P/CxjQSpiXMNW8ZMN+X5/XFTcbeZg==
X-Received: by 2002:a0d:caca:0:b0:5a7:d133:370d with SMTP id
 m193-20020a0dcaca000000b005a7d133370dmr5021214ywd.16.1697049449461; 
 Wed, 11 Oct 2023 11:37:29 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2621-cda6-b3e1-0b3d.res6.spectrum.com.
 [2603:6081:7b00:6400:2621:cda6:b3e1:b3d])
 by smtp.gmail.com with ESMTPSA id
 z17-20020a0dd711000000b0057087e7691bsm1155699ywd.56.2023.10.11.11.37.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 11:37:28 -0700 (PDT)
Date: Wed, 11 Oct 2023 14:37:27 -0400
From: Tom Rini <trini@konsulko.com>
To: Janne Grunau <j@jannau.net>
Cc: Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] arm: apple: Add initial Apple M2 Ultra support
Message-ID: <20231011183727.GU3119521@bill-the-cat>
References: <20230906-apple_t6022_m2_ultra-v1-1-7d28623285bc@jannau.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PGsX0Q7N34GnzsBl"
Content-Disposition: inline
In-Reply-To: <20230906-apple_t6022_m2_ultra-v1-1-7d28623285bc@jannau.net>
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


--PGsX0Q7N34GnzsBl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 06, 2023 at 11:50:34PM +0200, Janne Grunau wrote:

> Apple's M2 Ultra SoC are somewhat similar to the M1 Ultra but needs
> a tweaked memory map as the M2 Pro/Max SoCs.  USB, NVMe, UART, WDT
> and PCIe are working with the existing drivers.
>=20
> Signed-off-by: Janne Grunau <j@jannau.net>
> Reviewed-by: Mark Kettenis <kettenis@openbsd.org>

Applied to u-boot/master, thanks!

--=20
Tom

--PGsX0Q7N34GnzsBl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUm62cACgkQFHw5/5Y0
tyyA3Av+PtblD+VzxhFyAb+gFOsg8AdqAJ6CK+ef+RU8MkzTuSSkUebDrhibjwve
J047ifdUe0wdTYJ7mgMim0sVYcYIrnHoc/7bb+VJD4Nsdy1PWCPhywIbQmIGlrzH
1WolNot+t68c/s7m0pIoaG3jpCkwzXHYuhb5CittPgZLvBx2qGHsQJVznK88ayfI
4sOThbdxcoFlNOKaN29HXtW02wmUZJgttk3gjrw+h6OIM9CJOd63rHX2iJjd3rNU
RqsgE3qyychLjniAaXvP/VYhvqgVmw9XKwcF5qUlIgNnvApu+LuxF60OKM2t/t/V
v9BCT/FZ0lWfe6Gn2scGL9KDnuR7/H7YZJ6KS+Qnqt9Uvu5yCezaHA79Dxkiu/ca
CjMn39owTY6UVdT1gWLDxmOOnakJsJYK41gssGHopg3XGM+Wmbj7uWLnHOszkM9V
JvmsQquD6yPfsciD1SDTbDYH3sLhaFlpfjB4tPURcB13ANDkWzr5DvlBS/bCfEh8
UGn8KlO7
=vwWb
-----END PGP SIGNATURE-----

--PGsX0Q7N34GnzsBl--
