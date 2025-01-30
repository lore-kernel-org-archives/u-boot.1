Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDCFAC0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 19:55:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 397D580EED;
	Thu, 30 Jan 2025 20:55:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ga+TnOpI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6297180F06; Thu, 30 Jan 2025 20:55:47 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B948080EB6
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 20:55:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-71ded02b779so683428a34.2
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 11:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738266943; x=1738871743; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=85Xb/cCO2ppaf/n2uH1loUxviMkCKwfXm9tgKxkgLLA=;
 b=Ga+TnOpIu26QDAttQNKJRm74QezxtD2dK6QlZeChXNUTVG2tdpNIv/aifvGYpd1YIa
 I13MpvSsLupiY4FEljkpZJ5oV2udVkOrnM3IXYMXGNbsiOSllMshP3Os958sxwt7XXGC
 8253aZHaqzOB4TiiEPbH7VM7CUenBVBJMKwA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738266943; x=1738871743;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=85Xb/cCO2ppaf/n2uH1loUxviMkCKwfXm9tgKxkgLLA=;
 b=SSFCpMRk7GEs1dEQWOtDMfQ5mBJv52YNysBRM3X+2MJn177oTJGo82LxGQYiVB7VUQ
 RPkaGUhvWOARpPZtWwEBGfhdwK/uK5S9LzOOOkv12LvOq9ul8A2bnL3PJh2Rf03NtdJ/
 gKscYaGfQWuiwP5MEWGlRG6mTdv5tey64dsnAk7UUxLgqQQTKAsDPsPxXP2CaD25aohh
 a/SZg4bhMGnETjtVjndDSp9RYPRM17M+Avn3Q78J3NALF83hscGjquMB4jgbXGgBafpG
 8+4CkoFD4EAoDLLzd7UpBeowsPOYGdOdbAZetB2BDT8tizdmwHdx/GMk/y4zIhF+7ySG
 He+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUd8KZ1SemDmXyPh0ysLlnWxYCWZuFl1Vr/rpPCaSlcYz2V0LKMQVNMwy5BlDQa4VKug5K1MFs=@lists.denx.de
X-Gm-Message-State: AOJu0YwiSjkrB7km19gJG+WdZZ3UP3xyuK/lj878yXAKx0i48Npn/zoK
 WEIdX9RK6Wywwnr6zUgRw0zNFWV2WMVMpvU2PuqhiuY8xn3NNKaxbi+IaP9iYIc=
X-Gm-Gg: ASbGnctsF3uwAW0UZD4TU7NFvLTMP08zMz0bPWaAoM+N6qPpicNIk2LXIyPuohIY7bd
 wKLEjHn8xdYK/op7R3aqhmdR1aDXQ6hS0f8Gufg1zTT45OUbSllGcL0+aGQbEVxNEMK97jirhdC
 NL7+V/+rn5ZeVuYfVyRfmIQmlLRju1fyBrmuOsS4gvmo5y4DtXQiOiXJVRsI93ODFOHPQgS5SSW
 rn42pHmII5Ilq1pWapMgxQnR15deU8KmHhpbC39rY3zs2dvuHegmARvEwXlSgjh5LBMJlJTNxuc
 UOueyosbXkTBtMQ=
X-Google-Smtp-Source: AGHT+IEsGZJuHw7fpQoOvF29NEY/s/WDHKmzqQSEdwDt3KBIEnQa90JnWWcBIV6DNY2enBXrj3cInQ==
X-Received: by 2002:a05:6830:3114:b0:71e:ab4:6247 with SMTP id
 46e09a7af769-72656777f33mr5234446a34.13.1738266943469; 
 Thu, 30 Jan 2025 11:55:43 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-726616eaf39sm479530a34.0.2025.01.30.11.55.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 11:55:42 -0800 (PST)
Date: Thu, 30 Jan 2025 13:55:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: Re: [PATCH 01/19] mbedtls: Add SHA symbols for VPL
Message-ID: <20250130195540.GL1233568@bill-the-cat>
References: <20250126184333.4058848-1-sjg@chromium.org>
 <20250126184333.4058848-2-sjg@chromium.org>
 <CAEfUkUJPVLGCoThrP3ZcLwY283FYm2CcU52XDEmguKj0mKSc3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CBzSgkeCYGQdvu2g"
Content-Disposition: inline
In-Reply-To: <CAEfUkUJPVLGCoThrP3ZcLwY283FYm2CcU52XDEmguKj0mKSc3Q@mail.gmail.com>
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


--CBzSgkeCYGQdvu2g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 10:23:12AM -0500, Raymond Mao wrote:
> Hi Simon,
>=20
>=20
> On Sun, 26 Jan 2025 at 13:43, Simon Glass <sjg@chromium.org> wrote:
> >
> > Add some symbols for supporting SHA1 etc. for VPL.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  lib/mbedtls/Kconfig | 40 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >
> > diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> > index 78167ffa252..81274786106 100644
> > --- a/lib/mbedtls/Kconfig
> > +++ b/lib/mbedtls/Kconfig
> > @@ -112,6 +112,46 @@ config SPL_MD5_LEGACY
> >
> >  endif # SPL
> >
> > +if VPL
> > +
> > +config VPL_SHA1_LEGACY
> > +       bool "Enable SHA1 support in VPL with legacy crypto library"
> > +       depends on LEGACY_CRYPTO_BASIC && VPL_SHA1
> > +       help
> > +         This option enables support of hashing using SHA1 algorithm
> > +         with legacy crypto library.
> > +
> > +config VPL_SHA256_LEGACY
> > +       bool "Enable SHA256 support in VPL with legacy crypto library"
> > +       depends on LEGACY_CRYPTO_BASIC && VPL_SHA256
> > +       help
> > +         This option enables support of hashing using SHA256 algorithm
> > +         with legacy crypto library.
> > +
> > +config VPL_SHA512_LEGACY
> > +       bool "Enable SHA512 support in VPL with legacy crypto library"
> > +       depends on LEGACY_CRYPTO_BASIC && VPL_SHA512
> > +       help
> > +         This option enables support of hashing using SHA512 algorithm
> > +         with legacy crypto library.
> > +
> > +config VPL_SHA384_LEGACY
> > +       bool "Enable SHA384 support in VPL with legacy crypto library"
> > +       depends on LEGACY_CRYPTO_BASIC && VPL_SHA384
> > +       select VPL_SHA512_LEGACY
> > +       help
> > +         This option enables support of hashing using SHA384 algorithm
> > +         with legacy crypto library.
> > +
> > +config VPL_MD5_LEGACY
> > +       bool "Enable MD5 support in VPL with legacy crypto library"
> > +       depends on LEGACY_CRYPTO_BASIC && VPL_MD5
> > +       help
> > +         This option enables support of hashing using MD5 algorithm
> > +         with legacy crypto library.
> > +
> > +endif # VPL
> > +
>=20
> Do you mind rebasing this patch on top of my series below?
> https://lore.kernel.org/u-boot/20250127151657.648255-1-raymond.mao@linaro=
=2Eorg/
>=20
> My one has refactored the entire mbedtls kconfig submenu, makefile and
> default config file to adapt with XPL, so that users can have
> independent config options in both U-Boot proper and XPLs.

Actually, can you work on top of this one please Raymond? I tried yours
out now and it results in ~4KiB growth so something isn't right there,
but Simon's is fine atm. Thanks!

--=20
Tom

--CBzSgkeCYGQdvu2g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeb2TQACgkQFHw5/5Y0
tyy5PAv+Ic2Zc77tA7Tuhk9aSc/EIljfBT1ZazgDpjMeuEX0Mnnd59oB2OmTYngt
ZGSi82LNcIPl31Lk0O0VSfg/nZA5S10JPUWHYeqF317jBoKBDS9enjRRN1z1m6Sr
UOXX2o2w5b7M/PWWHUiIj0A7XSoP0J4W/2LhSLNlaBaVEdrtlODj3q2z/NLVW0V+
Xe4Y2+8aTgibWDU39VGvD6gf7IsYc8OgJXsP4oCI3p0nNbNo8H7yXhc3dz4kCATK
uPXChhknJ9Bsi2A4KqQQCQ7Ay/g2dIEH46Rcy4ajd6nCVprz8Cht6Q2KJ6X66naB
pMPDAh1JMp96dyNsRfFIMkS4nfdS4fPMO9YmbM/lkfvOUg0+TYN/tCymhm4x6DOh
TBvPkkjoytzCHm9CA6I1nm6689Vo7ikpmcaWTloFeTCeoXKtb1/laidKFUDLUuiI
mdDEwiVNEoTzWApHqNZ3FMhYowAtscnFkiSbctiGmWgqc6B5coPUMI46pwPoaVOx
NDBwUQnO
=O+6c
-----END PGP SIGNATURE-----

--CBzSgkeCYGQdvu2g--
