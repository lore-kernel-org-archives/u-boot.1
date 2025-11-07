Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF96CCFA05
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 13:58:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA66E83D4A;
	Fri,  7 Nov 2025 14:58:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lhM6BwvK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F31283D77; Fri,  7 Nov 2025 14:58:40 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C1CA83D0C
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 14:58:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7c5308f6aedso525384a34.1
 for <u-boot@lists.denx.de>; Fri, 07 Nov 2025 05:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762523917; x=1763128717; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5hjfplU6jTbTej1lwMDzgl3z3OftH9ALUxlRmvJkZak=;
 b=lhM6BwvKlNeQ7Bm2S9QJn9Y4zNfkz9cBH6tn9D9HWGQdOTL9PoDwqQnZ98k+L6pkpg
 O0170zmZwMsM/Wj7LNEB7AikDNPBIJ3GdW1loiomYd/5ttKyeVaescE2kE8ASAhUAQrk
 K4h7gWMl1d5Wa9u2haitZCYGvLy7akXzR8bsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762523917; x=1763128717;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5hjfplU6jTbTej1lwMDzgl3z3OftH9ALUxlRmvJkZak=;
 b=eVMCE5JFVRf2OmqUVZO0jQdI7BHpCyhfIwyzenjn+Ud9ttrPJJdNIF5y1+IXDNXRRa
 Pr0Uu0RpzI6dTjGDM23bPLgt2P1Ih0+b52u7APU2RmG++qpE5KYsfxHj4Asym/jR5xKt
 lydsJgzr6Lyudjvju/LhZNf1Y++kpcAXz06NjeDgTyy7EiE+U0PggbBLAwhWSG1p67Ni
 wJ9in4Tkd7DT/+Z9e2r2MKE3NbdFnLUFVZerDFnMAT54d1xZ8hBV9gXdqbCQpCAqXPer
 6M5+S1IfJZsgKuyuDQ+vufpkXq3ScP9eu9+gPymwOZFRvib58NYaTYaquAkVX9jcIJbS
 Qpdg==
X-Gm-Message-State: AOJu0Yyr9qaprjYiYTeszSdAzJOrBNIw42YF7cqrdXChJC3g/4vQN5uN
 tTzQrbjHPVu57v+MXcTZMAIgYap8Kvabxl62em8sjBRXl14Ukv871TOBz7gusBJllAkTl2u4DCR
 9y3GFoYobaw==
X-Gm-Gg: ASbGncsgprSfwmegZfdhGoqgZc4g2ho5TiTQTcTZCiDVXb8Tng1uj9hR8KjjNVhaIYG
 ezL2jPHOOUjbdBXKMd5i4TfwIaW6qRSl8G5EjFaA9PT3lNDnrScI4Z/dMNFr30DsBudfL0gxCMc
 TF0+OKdss33ostx0IXiT+8FLpHdYsGhPA6wHWpXnPkv0em9DmZIF69/ZnpgVk1qqwiYqJZhzeE4
 Z/POxg33mmrLeuaCrsvg/tE3zxuKeAewMB4RPfA/j80ja7aDGmoTZy5e6mMaXGH3WN3NFl4l3Mc
 D5dltK98xP/8pWprBwbWWbg7ANvv5Rd7kXTNYw/NbsjN3mxdT3lulPwg2GFzSIgVNOVd3WvwZOJ
 1HWZcRGnhjdV9HephhQaRG/y/vO9u14U3osHoZWFrxXuFOBTQtvl9aISN15QAPfUkxQUVnb+iIk
 4O+HiBp1mGJCBAQ3sWV8vHWQSYyAiQzMRo7AzxKtk=
X-Google-Smtp-Source: AGHT+IEuPhXDHgEfhJmh3Vgnu/D8i+Y6g8pDXKCzU9pPjCIenxtUIb1KGgubqKua/1SfKU3Oid1t4w==
X-Received: by 2002:a05:6808:6a97:b0:441:8f74:fd6 with SMTP id
 5614622812f47-45015f830c4mr1714249b6e.67.1762523917079; 
 Fri, 07 Nov 2025 05:58:37 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-656c5713a0fsm2326837eaf.6.2025.11.07.05.58.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 05:58:36 -0800 (PST)
Date: Fri, 7 Nov 2025 07:58:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] buildman: Correct override toolchain support for clang
Message-ID: <20251107135834.GB6688@bill-the-cat>
References: <20251106232836.3243591-1-trini@konsulko.com>
 <CAFLszTixiE+gxoOsV1tc0JLi9pce4pgenp2WGObLhED+txfjRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4B1H4VaHqoI1qxUD"
Content-Disposition: inline
In-Reply-To: <CAFLszTixiE+gxoOsV1tc0JLi9pce4pgenp2WGObLhED+txfjRA@mail.gmail.com>
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


--4B1H4VaHqoI1qxUD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 07, 2025 at 01:23:00PM +0100, Simon Glass wrote:
> On Fri, 7 Nov 2025 at 00:28, Tom Rini <trini@konsulko.com> wrote:
> >
> > When initially adding support for building with clang with buildman,
> > there was some minimum logic in the Makefile to inform clang what the
> > expected target was, without CROSS_COMPILE being set. This has long been
> > deprecated / removed from the Linux kernel, and also not functional in
> > U-Boot. The normal expectation, especially so that an intentional
> > mix-and-match of GNU binutils and LLVM C compiler can be used relies on
> > CROSS_COMPILE also being set and passed. To have buildman do this we
> > only need to remove the logic that was not setting CROSS_COMPILE when
> > we had an override. Correct the comment about what override_toolchain
> > does as it is functional outside of sandbox too.
> >
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Cc: Simon Glass <sjg@chromium.org>
> >
> >  tools/buildman/toolchain.py | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> >
>=20
> Reviewed-by: Simon Glass <sjg@chromium.org>
>=20
> I don't recall trying clang with real boards.

I did for a few years until things broke and I didn't have time nor
incentive to try and fix. Now that someone has fixed clang builds in
general and I've gotten someone to work on labgrid with upstream, we
should have a lab posted shortly and clang will be part of the set of
builds that gets tested.

--=20
Tom

--4B1H4VaHqoI1qxUD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQ37CgAKCRAr4qD1Cr/k
Cn8EAP9+LSdUJ8EeEYVfK6S6eEfV5ZZWDeq1UbNyuIBTxNEpnAEAshGksGArEneI
Coq61s57RMZX+b95eIpCLGTiWNYU6Aw=
=mlZT
-----END PGP SIGNATURE-----

--4B1H4VaHqoI1qxUD--
