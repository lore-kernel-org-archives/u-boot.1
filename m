Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCFD1CD4F54
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 19:43:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CC2B847C4;
	Wed, 27 May 2026 21:43:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QPkzeVVT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9089984859; Wed, 27 May 2026 21:43:51 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65FD4846D1
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 21:43:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-43c2fbe2117so676713fac.0
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 12:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779911028; x=1780515828; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9uRsE1aNEBECtrDQAnsTqUlcq4XgDoAoqxbsZ6p/FUs=;
 b=QPkzeVVT1SfS4Ck6PbytekM9aI9FzfM4VoX0CaU6nG8/qzX6ZFGECsXW0sNq3MFM74
 UicdjqIkUrVjvK1EmDKHddYF+Vd/z4LjoiQM2He3TuBnkqhC9AmwstdXk0UbrjNfI+2H
 ew1GkRPjW7i5o7+S++ikYBTsq5sYG5dlLGI4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779911028; x=1780515828;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9uRsE1aNEBECtrDQAnsTqUlcq4XgDoAoqxbsZ6p/FUs=;
 b=DQ/U+ydpCLs4g59jaatuAD73zvdFbCH2J+yWOjgP5dFNEp+jjyVZLyZQVmWkrwt6z3
 pm/15iEBtH95QgST+3FnCB/95G9rorqNzmxdF7BiuW6XdDSaqd2vbCWLQMwAul6UpU2n
 lLW9QvQRkY+au2Dgmk2sSpTP9JH6hJCZiY/+/SS4qHyFfWqutDFalnTa4e3aO5TEdKvj
 9B/o2QoYr25aHsC6sg97JlkKDMsU+TyA9d7mGD0fDV4twuYUaN7IbfirUx2Nq0FI4Vbc
 k2DDimjNqNFZQZVkfK47CJwr3dzx615JLqvCJjlmrO/Ni0DXCMEtJkIbYAvjZ58NuvPr
 KWfg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9yBXBClIRLI086Lc/Oh9cb9Je+ieebnYcQfLQasWMOYGXwTLVgvkU2znzkPf7sDwXULtXxOuI=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+qSaynlBxlR/IHgh6GIHl968y1NmjYcMGpAQeDtsarpAKxaXw
 fgRAxzOedHtpjkBHJkK+yL7IJhq+t8f/mastGoLWCG3bEkic4MiGglB+VcrmpteYxTM=
X-Gm-Gg: Acq92OFefXptV6E0e8/dmcd8Ii0SxYXEFfczc629VYDC8lbqOlmX+1q7zPKCwhy2xMK
 dRLmX+Ovxy1SHuDK8Bmzn19obbEML7T5dOiJ92RuSqSbmgaQA2VHXV3NKzo6PM9CtPl6vif6PdR
 NZHhIPZjvN3U1JePHePE+CsQPjXktOsFT/CJe+gaHFiIII120oO4S03Dv8Jp/ROnFGeAG+AnfU5
 GPAVpdiiuyz026rN4paCERT9CRI4kteQP/3SUHVd7kmsWgs2oGi2qLUQnF812TLsy+7cBwK2BUz
 Cfwbpxsf9S6t/vOH2B0tsxGpxWwqsbj2aVtFP6Ep0XEb/fGFmG3CPbXtxVIVgkywewavlvzlcuv
 VetcFY6nmPLT0iUbb0Hht3vnxEU3XfpT9qRJe8uMitqAS9RTkT6+jWRHZsoy8seH7xJMDAIwTQz
 K1dkd9s4rhx1CuUhkGq+DfDrNoDi8m8aRMG/EZxOVDIbB/p+Iq0zMiJJXYmR1Lq78sQMsjK2+i4
 Gj22Kb8m/xUANaEetAbnlOoOl8iOY2XhM14wnIAey4hbytPBZP+Bn1Y
X-Received: by 2002:a05:6820:151c:b0:69d:6ce6:7437 with SMTP id
 006d021491bc7-69d7eb64567mr12777309eaf.19.1779911028072; 
 Wed, 27 May 2026 12:43:48 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43b635d1551sm17579206fac.5.2026.05.27.12.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 12:43:47 -0700 (PDT)
Date: Wed, 27 May 2026 13:43:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 02/13] alist: Allow inclusion from OS headers
Message-ID: <20260527194345.GA93986@bill-the-cat>
References: <20260527161033.3273795-1-sjg@chromium.org>
 <20260527161033.3273795-3-sjg@chromium.org>
 <6fc3e71a-8872-4c35-969a-f54ce2869947@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4i72te7j1rdYEg5Y"
Content-Disposition: inline
In-Reply-To: <6fc3e71a-8872-4c35-969a-f54ce2869947@gmx.de>
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


--4i72te7j1rdYEg5Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 08:36:45PM +0200, Heinrich Schuchardt wrote:
> On 5/27/26 18:10, Simon Glass wrote:
> > Sandbox needs to include system headers in some files, but also wants
> > to use alist. Adjust the headers to permit this.
> >=20
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >=20
> >   include/alist.h | 16 +++++++++++-----
> >   lib/alist.c     |  1 +
> >   2 files changed, 12 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/include/alist.h b/include/alist.h
> > index b00d9ea97d6..69d7cdb722f 100644
> > --- a/include/alist.h
> > +++ b/include/alist.h
> > @@ -10,8 +10,14 @@
> >   #define __ALIST_H
> >   #include <stdbool.h>
> > -#include <linux/bitops.h>
> > +
> > +#ifdef USE_HOSTCC
> > +#include <sys/types.h>
> > +#include <stdint.h>
> > +#else
> >   #include <linux/types.h>
> > +#endif
> > +#define BIT(nr)			(1UL << (nr))
>=20
> BIT(nr) is already defined in include/linux/bitops.h.
>=20
> We must not assume that no module includes both alist.h and linux/bitops.=
h.
> E.g. include/expo.h and include/lmb.h include both alist.h and
> linux/bitops.h. We should avoid redefinitions.
>=20
> The following is an abuse of the enum type:
>=20
> enum alist_flags {
>         ALISTF_FAIL     =3D BIT(0),
> };
>=20
> As this is the only use of BIT(), we could simply use the value "1" here.
>=20
> #define ALISTF_FAIL (1)
>=20
> But as ALISTF_FAIL is the only bit in flags used, the best solution would=
 be
> replacing flags by a boolean called fail.

I see this as another reminder about how frustrating it was that alist
was introduced under the guise of "must have this for an x86 feature"
but instead is a solution in need of a problem to solve, and whenever
it's used for something else, yet another problem with it is shown.

--=20
Tom

--4i72te7j1rdYEg5Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahdJbQAKCRAr4qD1Cr/k
CncfAQDiH8G+KnVieQg1sc75kSr2hV/o9K2Navv6Brnbwsh9lwEAz809TA21EIVd
pX8/3VWHklFpepXvM403U+p75MbKvQQ=
=Ac+a
-----END PGP SIGNATURE-----

--4i72te7j1rdYEg5Y--
