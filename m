Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0EB3C4167B
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 14:53:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CB51870D4;
	Thu,  2 Nov 2023 15:53:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lUQw5MVa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00A7186FA2; Thu,  2 Nov 2023 15:53:18 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0DA486F63
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 15:53:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-77891f362cfso85087385a.1
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 07:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698936792; x=1699541592; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eDHepk5E/+xTR2LgoHwL3/WbTMvkvnF4/vtGRTEWFw8=;
 b=lUQw5MVamdyXr+be2J2elD+gAkzfBkS1Whu8WKHokFNGIeMEwpT305eGTo2rTstdhF
 wvnaHzlAkK7GfCscM4LlzvqBZJSjGwhkv7ZS2Je3vwdV3PhLHQYCaOpZYVLgeDNWLW/w
 7mBXWBnOyDPq6ujjy2aMpeoVlvLCUfxSwbybo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698936792; x=1699541592;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eDHepk5E/+xTR2LgoHwL3/WbTMvkvnF4/vtGRTEWFw8=;
 b=nPTSWGB4MYFIfvi9VKqkpe2QyqhiNF/lnAhjfG1HJuRh/ciYYoGtBa9dMn35Z26/Pf
 1rm9oBXvxbZxIzeAQb9Wbi+Cc8G9dcXehHMISnELQyzO5zZcfOAInYvugGJ4T3BGcjbr
 9btuZpLbP4eR1YMY1g23euBYhYmr9WtNpcHXpcGi7uxresFTVFmlNSK6Ms3ieUYKLov6
 ais2/gQmZibjkLaEAdn0fhBPGa5feLOjNJ4wQtT22J8fesRQ5S9Xz7mRjhi1q8FgHuWl
 sx3t0oC7U+m8v7lIVNABSy4Itf1eKImWQiEKTApQJ9B7f/HRtp7sm6ltMhr3muYMoc6Z
 tSHQ==
X-Gm-Message-State: AOJu0YwfkcWQEmSuaePcbMFJvkmsE73kPNRmdLhfzzlKmaaW0KJzvC8i
 AXKopu8abUs+zJarfhYuDwhfNw==
X-Google-Smtp-Source: AGHT+IFsEqhKGKUIsqvYQAkuIGWtOQk/2S0ELpQyTyyt20gh+aHAapWVGxrPNPfEDbfVb10krmQw5w==
X-Received: by 2002:a05:620a:1790:b0:775:92ac:a3d6 with SMTP id
 ay16-20020a05620a179000b0077592aca3d6mr41196qkb.14.1698936792250; 
 Thu, 02 Nov 2023 07:53:12 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 bk31-20020a05620a1a1f00b0076eee688a95sm18888qkb.0.2023.11.02.07.53.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 07:53:11 -0700 (PDT)
Date: Thu, 2 Nov 2023 10:53:09 -0400
From: Tom Rini <trini@konsulko.com>
To: Mark Kettenis <kettenis@openbsd.org>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, sjg@chromium.org
Subject: Re: [PATCH v2] bootstd: Make efi_mgr bootmeth work for non-sandbox
 setups
Message-ID: <20231102145309.GH496310@bill-the-cat>
References: <20230903204000.96999-1-kettenis@openbsd.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YGjH8bAUKypm+uKt"
Content-Disposition: inline
In-Reply-To: <20230903204000.96999-1-kettenis@openbsd.org>
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


--YGjH8bAUKypm+uKt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 03, 2023 at 10:40:00PM +0200, Mark Kettenis wrote:

> Enable the bootflow based on this bootmeth if the BootOrder EFI
> variable is set.
>=20
> Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--YGjH8bAUKypm+uKt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVDt9UACgkQFHw5/5Y0
tyxlkwwAsBPewfBG7dUtNbMN0XT9xU/SyABOavz3Y0EtJjTQf6YEyhSi69lVvp+V
imQQCu7aUBch931FoBWtHO96/3hZOapzFVh3NGAkQKvmv77fdoBHfr0bOaAIPAoy
/lGCxnhjmbFxnwrQvSQE32HWkMDfqm9CHjknSxI+KqSoXEAorsiZih5GtkRiyvaM
0AhCGkLyUNhiWTuHibnaLutci6PhxVzVw1Ol7vQcghp4bXPQGVItw/sMm6TIolN3
ZenWyM1DyHtXlVjbpPZJV/PGSg2yVMMjg1kQIw5x1bhdemm7ya58Mx3VU+cSWBTG
UdUdZgLF6gt+EGniNgKTsIWxzcVHeyHt6pyK6Qojg4mzBU0HnexbY4jvsQOO4u3a
3wgtO+J+UfFHAxAgH7dTmA8fdsIB874p+3ogdJ4owD1eaVhWx0AoL1ErxX+ZVwxm
5VMppSylW/NMU2IWNxYG2cUMvidT93fOvcMjU7OzGi/7Qk59t/o0bfj8fh0m4689
34zKq25R
=3VfU
-----END PGP SIGNATURE-----

--YGjH8bAUKypm+uKt--
