Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93691CD3427
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 17:08:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DE9A80F0E;
	Mon,  4 May 2026 19:08:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KwY/Up7O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FB3E845E3; Mon,  4 May 2026 19:08:10 +0200 (CEST)
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com
 [IPv6:2001:4860:4864:20::44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE95C80077
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 19:08:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x44.google.com with SMTP id
 586e51a60fabf-40ede943bf0so3078905fac.2
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 10:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777914484; x=1778519284; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rhZLQ65N8hXfSNnyRjuEJe7DZKSj2dXsJHv82CkmMy8=;
 b=KwY/Up7OMYVIe8U1Eay+463wXaZeizCyfuaNzutFBx6jym79E+ZrZlMl0VHCKqygh6
 GHwqfRicMqIEe20CIvud6tCQ2Yl9Dfq/Tc9pwWNNEdIMzf0zLALuCzBE1X/HVfB1rx7p
 hU3knaiAXby6SwjoN5b/h38s2glWRdhHKBFSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777914484; x=1778519284;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rhZLQ65N8hXfSNnyRjuEJe7DZKSj2dXsJHv82CkmMy8=;
 b=K3zZR9wsLZ+Mou8rBjkswN/Jlnmsa7Og70HJ+uLbMmCpFjaCw49gx+KKGhLtsk+4Kr
 3n/5/y73pQswo+ikYPq3+sJOJwZXpW7/epxSt9fAm3C0kyFaziStjTy/CAAneutBoe0z
 YiDMNmdWvuKzydkcnKfAK9EW2rrNGlZNayNNh2gB6D7GnXg2Iih6br+XfKl+HMJjm20m
 pO76u3yrV23uLm++xg73YSGHArbGGWfsEV9hZy06MEXba7rh6BoFb/dfzhd9SFJQ2bei
 2cVQ9auGfgTferpSdMu6yotClNty40eMFnA8KB5/BnQeRWSyrUp94ogylqn2N3YA69xL
 wfzQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9gQf2lZTUDzKkO2Y/blQtofpcECSTMW0+xY6EI2qrftlehr/M8svzQOLi44oYgcByt9RqVeao=@lists.denx.de
X-Gm-Message-State: AOJu0Yy/rYFiMmQD1slsviZb4gOqrhg5CcIwqwkyvc52YXZ9xq/5iEwv
 ggBN8Ldfupppnp/+7hwEp8qKkhb53FFtJhS8ZqInQDScZy9LFXBZLpPF5uM4zaGoqb8=
X-Gm-Gg: AeBDievgfwV8Zv47xnLpDCh6GkB/OGA49zDG1gPzxW5MWDaBfWTnAwjRqUoUbLZ8LfO
 pJWSdSndTdnHrdGUGJpQrszXyJWtInKf2YLGFWRpdC36Eh0hPXiCXM4gih/IAUvirCuhOKZluBH
 LVe93/x0s7s1znmfEyf6Q54UAA4mYJ2sFVBZStB1yQEvAJ9tZ/VyKCdnk/bGz+nJvb3BgkaHrIT
 g1l9chAOpYPvn5jY6kW9ke1xF+5JulAMMHQ9x7YxfwZmd8kB9Jv0ZAvFHqghRSPX4IUVml40fuY
 IF3cb923ux2IibJ7JpKnFsNfTiUK67/6dW6/fDdzM266+VJ5fZD+JrdbDJLjXxOgX3h+h+pg1Uj
 H9sstRpX/IB5G7NezIJVdI1vW6mEtBNWXvte8myMdp4JyCQJqrw1l1Jf480asW9CxDmCjQT2aHj
 xCwVtHz+Q0jQZp0Hwith/piuKgoefdo8cv15YNSnjr1tGsDbnhtNSukZXVZLYJe/Pa4qj0Ub5ih
 eQ0jFZADv12vHs+IRmLilP1ilq1izdUiWxthKRKx0z4QlpA+mpJ+t7IY/7b5w==
X-Received: by 2002:a05:6870:a108:b0:42f:b84b:87d5 with SMTP id
 586e51a60fabf-4347628f4e7mr5250720fac.36.1777914484366; 
 Mon, 04 May 2026 10:08:04 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43454951a95sm11055842fac.7.2026.05.04.10.08.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 10:08:03 -0700 (PDT)
Date: Mon, 4 May 2026 11:08:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Franz Schnyder <fra.schnyder@gmail.com>, u-boot@lists.denx.de,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Franz Schnyder <franz.schnyder@toradex.com>
Subject: Re: [PATCH] board: toradex: Quote variables in `test` cmd expression
Message-ID: <20260504170801.GH1614990@bill-the-cat>
References: <20260331-fix-test-cmd-empty-v1-1-56cb93fc8f43@toradex.com>
 <20260401051027.GA4471@francesco-nb>
 <20260402233029.GI41863@bill-the-cat>
 <ac-ADDwtwS-xuFTE@livingston.pivistrello.it>
 <87v7e0o624.fsf@prevas.dk> <20260504045636.GA5660@francesco-nb>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/zcZm1KeUyWRqcp4"
Content-Disposition: inline
In-Reply-To: <20260504045636.GA5660@francesco-nb>
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


--/zcZm1KeUyWRqcp4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 04, 2026 at 06:56:36AM +0200, Francesco Dolcini wrote:
> +Simon
>=20
> Hello Tom,
>=20
> On Thu, Apr 09, 2026 at 11:07:31AM +0200, Rasmus Villemoes wrote:
> > On Fri, Apr 03 2026, Francesco Dolcini <francesco@dolcini.it> wrote:
> > > On Thu, Apr 02, 2026 at 05:30:29PM -0600, Tom Rini wrote:
> > >> On Wed, Apr 01, 2026 at 07:10:27AM +0200, Francesco Dolcini wrote:
> > >> > On Tue, Mar 31, 2026 at 10:10:10AM +0200, Franz Schnyder wrote:
> > >> > > From: Franz Schnyder <franz.schnyder@toradex.com>
> > >> > >=20
> > >> > > With correct POSIX handling, unquoted empty variables can turn t=
he
> > >> > > expression like
> > >> > > 	test -n ${fdtfile}
> > >> > > into
> > >> > > 	test -n
> > >> > >=20
> > >> > > The POSIX handling for single argument `test` evaluates it as tr=
ue,
> > >> > > so the fallback initialization will be skipped unexpectedly.
> > >> > > Quoting variable expansions in `test` expressions will always re=
sult in
> > >> > > correct behavior for empty and non-empty values.
> > >> > > This change was triggered by
> > >> > > commit 8b0619579b22 ("cmd: test: fix handling of single-argument=
 form of test")
> > >> > > The aim is to have a less fragile codebase that is not dependent=
 on a
> > >> > > quirk of the shell implementation.
> > >> > >=20
> > >> > > Use quoted variable expansions in `test` expressions throughout.
> > >> > >=20
> > >> > > Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
> > >> >=20
> > >> > Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > >>=20
> > >> I've decided to go with:
> > >> https://patchwork.ozlabs.org/project/uboot/patch/20260330140106.4018=
76-1-ravi@prevas.dk/
> > >> to make sure that everyone that might hit this problem doesn't end up
> > >> broken, thanks.
> > >
> > > I am wondering if you should apply this in any case. This change is g=
enerally correct.
> >=20
> > I agree. And note that this really isn't anything to do with the 'test'
> > command per se, it's simply that using any variable whose value can be
> > empty or contain spaces is prone to produce something other than exactly
> > 1 word, exactly as in userspace shell, and once the shell has done its
> > parsing and word splitting, the called command really has no way of
> > knowing that there's an empty argument missing.
>=20
> Tom? I think this should be applied, see also the related change from
> Simon.

I did drop this, sorry, I'll pick it up now.

--=20
Tom

--/zcZm1KeUyWRqcp4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCafjScQAKCRAr4qD1Cr/k
CoomAP4wDHfJQDnlIHFif40Sy3+shupRzTh2LAzATZspPRDvxwEAsldGLE/kaocP
GoVCkZpmQYL9nNPaIEXKgF/ggBvSxAg=
=0OjT
-----END PGP SIGNATURE-----

--/zcZm1KeUyWRqcp4--
