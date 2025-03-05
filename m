Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CDF6C19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 15:50:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55C5C80F92;
	Wed,  5 Mar 2025 16:50:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uJZ+oO0j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35AF08122F; Wed,  5 Mar 2025 16:50:00 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A79998083E
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 16:49:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e609cff9927so4561729276.3
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 07:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741189796; x=1741794596; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xfXpKuiy/kVnhXS0cGWan0k4A5CC7gHsAEoVlvl27S8=;
 b=uJZ+oO0jb+A57DSIjQsooo9nUND3TgDN6n7EMBiDGEW5LMYx4RsQ0dMi9GDMvpHBBO
 cYPDQPFvGeKBi1TtsVvPohD9OsKKAHCIlxNSqNtkx5qDrKVbUIrSFCv3UE6EKCxE5ttM
 ZRAMin/pWxYSrzaf41RkAw/jfHdc4utuTivQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741189796; x=1741794596;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xfXpKuiy/kVnhXS0cGWan0k4A5CC7gHsAEoVlvl27S8=;
 b=mEdvxekwLakPlkX/OAwx2xBLbwzLHk6qSS4I8POpqYJD+5tFSr2htOQXc3kZ0dbRpT
 Qzxs4RHff4iR4+1K8PK9fKuhaLcGuV09hzBeAASgsKfXLD9WZOz+4HdSAYh7HRASXDJl
 vah1CzUepJJSOyvLQrQkE1HJUKMrwL9xwQYr3Cm/ERk4CWgz1zmf0oCMKdPfH2yKlMLV
 ikXcZrrtyo6JfaWAxxwuJDdd4gHEKfdw3C3QYqN72gbOGPSlXqXChxGBMKfEHD2tkqL5
 wUybdCHC2eCdJZjyQytN+Ya0I1blFEBsq2PuRcRDZmZG6c7XjeXPqchxcdMNDjSIzm9S
 Dxuw==
X-Gm-Message-State: AOJu0Yx9nEn37Q4/Xv8Psm8P4xBKzQ0sP7yXhHkaRZoYXzpA/bmbGKSZ
 a2hof8fhrQMQyz8V3/k+VVvB9KHtsNwZjIDgnnFJr0Hrydk7BebFAaM3Qh2NR7s=
X-Gm-Gg: ASbGnctfposnjFXVUU9xl9f24Oe6h+eW9UBDrOOYsrZ34ITuXbC7tJZVk2VoI74yV22
 34XDnW17ajauveJQSa7YLqHkFmNagNFIbjLaL1qzZncJIrNN/HQdQviHBALSq8F+qi9LnQbaBwq
 MzhjWSbHy5vFzMyrhfJqGSzeM9ymmrQMYQ8oIYGtZ67c7nmG55AA1nJJzaYDUn3p0RZ3Rg6pxzb
 9CygH1O7wIFs6RAKK8HTEY/zID4osi6MmIlPHVlGYcxCiymg1nvxUFedBQ/30XaeqC2xwyJlQVd
 OezAPVnttS/wY5qcRfoE4wRI0UNXpch82NXOfZzj0mHWoQ==
X-Google-Smtp-Source: AGHT+IGz3JpKpu5MOSlLkClzLr11sfzruUPsQbGMOm+fRHHq8i85edFcCXqhC+nRGxYy5jxzRh7RXA==
X-Received: by 2002:a25:1c3:0:b0:e63:4625:1dea with SMTP id
 3f1490d57ef6-e634683e73emr45499276.1.1741189796270; 
 Wed, 05 Mar 2025 07:49:56 -0800 (PST)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e60a3a41ab9sm4446004276.27.2025.03.05.07.49.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 07:49:55 -0800 (PST)
Date: Wed, 5 Mar 2025 09:49:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [RFC PATCH] Kbuild: Always use $(PHASE_)
Message-ID: <20250305154953.GQ2640854@bill-the-cat>
References: <20250304204116.2834889-1-trini@konsulko.com>
 <CAFLszTgzPq8Sdmk0Fqh19n-TkNBAJ+JwscNfYchRzE1kWQjrXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mgjN0e4Q04cNmmgh"
Content-Disposition: inline
In-Reply-To: <CAFLszTgzPq8Sdmk0Fqh19n-TkNBAJ+JwscNfYchRzE1kWQjrXg@mail.gmail.com>
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


--mgjN0e4Q04cNmmgh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 05, 2025 at 07:15:50AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 4 Mar 2025 at 13:41, Tom Rini <trini@konsulko.com> wrote:
> >
> > It is confusing to have both "$(PHASE_)" and "$(XPL_)" be used in our
> > Makefiles as part of the macros to determine when to do something in our
> > Makefiles based on what phase of the build we are in. For consistency,
> > bring this down to a single macro and use "$(PHASE_)" only.
> >
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Cc: Simon Glass <sjg@chromium.org>
> >
> > This leads a little bit of dead code in scripts/Makefile.xpl that I
> > didn't remove as this is an RFC. This also omits expanding on our build
> > documentation slightly.
> >
> > With the following patches applied (which are correct regardless of this
> > RFC and so separate):
> > https://patchwork.ozlabs.org/project/uboot/patch/20250304203235.2834031=
-1-trini@konsulko.com/
> > https://patchwork.ozlabs.org/project/uboot/patch/20250304202436.2783784=
-1-trini@konsulko.com/
> >
> > There's no change in the resulting build before/after this patch.
> >
> > We could do the other direction and drop $(PHASE_) in favour of $(XPL_)
> > but that would require updating the logic of how XPL_ is defined.
>=20
> These are not the same thing at present:
>=20
> XPL_ refers to any xPL phase
> PHASE_ refers to a particular xPL phase
>=20
> Since it doesn't change the build, it must be fine. It's just surprising,=
 to me.

Erm, this is what we have in scripts/Makefile.xpl today:

ifdef CONFIG_XPL_BUILD
XPL_ :=3D SPL_
ifeq ($(CONFIG_VPL_BUILD),y)
PHASE_ :=3D VPL_
else
ifeq ($(CONFIG_TPL_BUILD),y)
PHASE_ :=3D TPL_
else
PHASE_ :=3D SPL_
endif
endif
else
XPL_ :=3D
PHASE_ :=3D
endif

Which is why I sent the two fixes first, for places that relied on
CONFIG_SPL_FOO=3Dy in a TPL (PowerPC and their spl->tpl->U-Boot chain) or
VPL (sandbox didn't set TPL_DM_I2C but did set SPL_DM_I2C) phase of the
build.

--=20
Tom

--mgjN0e4Q04cNmmgh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfIcqEACgkQFHw5/5Y0
tyye9QwAqGAEBKV95glmUH5S/3lmVXn+BnJrC0UGK4qu/3kmi8WwrEQhQjUYKUQ2
2+OBlgkweY6gdb3Tjr83yTbHUQOe3x1vNG/7pByWoJHyd4e3kIGbxz/B0+AlAdhc
FDNsQJnpkffDfekLL88zAl1G41G31m4E9yu3nqD/hAor210Cp6JxLLcObqB0Ms4O
Jg6jVb51HDs4T9R8mS0mI0vrHYumw6CJlPo/ORMqsjGLHlF8sgZP5jMAqY0wR5EM
BptNaf5ncsLKIX7XG8zn614xkquKps/Q/kylNp3sdM7OKr68+KCPO13dJoU83C2z
sTx+ja/VV30JXix9aGp56H6eTdN4cPhXVUrQtOdDBExKKAL5q0wRqJxuJCuRxJG9
h8B7i6bPOG68NMMfCBaWNz457K1QgRcW1Auge1YI0R+C2cSfa2kwyhkB3Js1Oisi
gHgXuYCz9OtsLWH5vHBNG/juwwiwiXiSkYBC78ITXHePGhK7wDMCY1oaHIMSHnFf
VJ9dv7oz
=kcVx
-----END PGP SIGNATURE-----

--mgjN0e4Q04cNmmgh--
