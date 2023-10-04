Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD7BE7C4D8
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 16:02:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33BAD8749D;
	Wed,  4 Oct 2023 18:02:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IO3X52pm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D15F874DA; Wed,  4 Oct 2023 18:02:14 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 431A186D3F
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 18:02:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5a2478862dbso28150757b3.2
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 09:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696435326; x=1697040126; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5Sux0RQH+8zf0wpONHva2T2ykKJ4RmBHLqPj436/OUM=;
 b=IO3X52pmXOQBsDXsKL7LcbdLsgzB73pLUxxS8ge54QUsou5eJuxn+DExhioi4BZtF6
 qli0AlI0RhLdGuHCZ+0b0G+EzgQZVG+OowRY0aiKRXUGIooWlg/QHCsCY7+CKT6QJrDD
 Sc1VWMd3CBT9v0IFvYC5FU7CkJutxteLBWUPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696435326; x=1697040126;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Sux0RQH+8zf0wpONHva2T2ykKJ4RmBHLqPj436/OUM=;
 b=tIUq1XgFX4L9AL3J3VjwQg2HPAvXOyjPCfu4NnknFsappPWWzOeJS7gXqE4NbJEK2o
 TwydmIw9t8FihXuIOXBrdtaLxUUsdNG2gvWGgUsfLUIipjJ6M5bo/ldCJtcBZnrtiTy6
 mhmQpIC8tCkwTNHeGLyWNh+apPfLs2e1+lDFrc+GsSTJR8DDHWIR1H+KnjAIcO22KzYb
 jqWmraJgPlY0H7LMUhtnWyRaTm1eLgHLBV3fwh0B1fmmLJ9DsGvhpNonv4O27QR+MDBz
 x5Ves2Ubyty7p+CFxkaFYCpaOVNVuMkkc04N2ypfySro0A9XuvwMYdACGRPCmUzwSuVy
 8z/w==
X-Gm-Message-State: AOJu0Yzph7gJziGw42kO0PWpmYu6NeANBKPAv9L2+/oMtbXrwcznR+9/
 gCi8gZyNAyWpRCBC6o534lmcnw==
X-Google-Smtp-Source: AGHT+IFIpYsY+jeZG0D06ixqO8Pdmn/ruhcerb2uF1fpGt9ORI+uHG/pbmHvvm8ulljfJgN2fSMWCg==
X-Received: by 2002:a05:690c:4813:b0:5a5:65e:b847 with SMTP id
 hc19-20020a05690c481300b005a5065eb847mr291383ywb.34.1696435325794; 
 Wed, 04 Oct 2023 09:02:05 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1e7b-517b-66e6-a4a8.res6.spectrum.com.
 [2603:6081:7b00:6400:1e7b:517b:66e6:a4a8])
 by smtp.gmail.com with ESMTPSA id
 b70-20020a0dd949000000b005a247c18403sm1256246ywe.37.2023.10.04.09.02.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 09:02:05 -0700 (PDT)
Date: Wed, 4 Oct 2023 12:02:03 -0400
From: Tom Rini <trini@konsulko.com>
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: Simon Glass <sjg@google.com>, u-boot@lists.denx.de,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 joe.hershberger@ni.com, rfried.dev@gmail.com, goldsimon@gmx.de
Subject: Re: [PATCHv10 01/15] submodule: add lwIP as git submodule
Message-ID: <20231004160203.GG8465@bill-the-cat>
References: <20230926094124.7024-1-maxim.uvarov@linaro.org>
 <20230926094124.7024-2-maxim.uvarov@linaro.org>
 <CAPnjgZ2OV8ug3+3ji8nEnK7cwONu7KFa2zSyP5urKWUkQvMqJA@mail.gmail.com>
 <20230926134149.GS305624@bill-the-cat>
 <CAPnjgZ1iAG8Rw3jVZvFs16AvnGkO=gCsCM3dF1c30biFk4t2xw@mail.gmail.com>
 <20230926141936.GW305624@bill-the-cat>
 <CAD8XO3aifH+f_NZ1g_nJrxKu_tDmuW9H=Pk2o4v8yTAAn1nfdQ@mail.gmail.com>
 <CAD8XO3Yy1ppSgvUQ3ZZOmVzK2puxruHu2Q4UiCDPUzsWuKA8Vw@mail.gmail.com>
 <CAPnjgZ3aqSjChJqCHQfrO5kxg0=-BR-KV4aC6jquC4ZRTovi0g@mail.gmail.com>
 <CAD8XO3Z87tOqMx4gmipRfwnMY-U9Sr0Bf21GtKCgq=Ay+Jtakw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KNGrlStpoKE43+Hp"
Content-Disposition: inline
In-Reply-To: <CAD8XO3Z87tOqMx4gmipRfwnMY-U9Sr0Bf21GtKCgq=Ay+Jtakw@mail.gmail.com>
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


--KNGrlStpoKE43+Hp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 04, 2023 at 01:52:53PM +0600, Maxim Uvarov wrote:
> On Mon, 2 Oct 2023 at 20:46, Simon Glass <sjg@google.com> wrote:
>=20
> > Hi Maxim,
> >
> > On Mon, 2 Oct 2023 at 05:23, Maxim Uvarov <maxim.uvarov@linaro.org> wro=
te:
> > >
> > > I found what was missing. (reproduced with CI docker.)
> >
> > How about adding a script that copies in the lwip code needed for
> > U-Boot, that you (or whoever the maintainer is) can run each quarter?
> >
> > Alternatively, I think just sending a patch with the code would be
> > helpful, so we can see what you are wanting to include.
> >
> > Regards,
> > Simon
> >
>=20
> Hello Simon,
>=20
> That might also work. lwIP is a little bit special library which we can n=
ot
> just connect as an external library from the repo, because it has
> platform implementation specifics (U-Boot here).
> At this time I'm trying to pass all CI tests. And even if they pass for me
> locally CI has some interesting combinations where the test fails and I'm
> not even sure that it's related to lwip code.
> Once CI will pass all the things I want to take more attention on submodu=
le
> support or patch support. I really hope that submodule will work for us,
> but that also will require Makefile and CI changes.
>=20
> However, review of lwIP code here might be helpful. But I think the maili=
ng
> list will not allow me to send such a big patch, and it's almost impossib=
le
> to do a review project in one email.
> I guess it's better to do a git clone
> https://git.savannah.nongnu.org/git/lwip.git and see what is there.

Yes, the mailing list will hold the message for moderation until I, or
one of the other people with the password approve it.  That's not a
consideration for how we handle the initial lwip integration.  It does
need to be a "just the import" patch as there's no real way to review
the code itself.

--=20
Tom

--KNGrlStpoKE43+Hp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUdjHcACgkQFHw5/5Y0
tyzXWwv/SgQs+2YLa4L4210qcO70gkgSMZI9Up59qH+VAhuI7AN4QtUCdXK/Pqof
OEssVJgWQUhd7cWkoZma8cJkQLXckFuo5HGN0d1kIKYjUaPcNBmCpStlAjB9syDE
2jdyUVpw1eBbo9QbfzX2IJH7XNlVn4+JIN6r1S/S/2eKQxFuUSvn7uD8+P1MoyP/
pajJj2uhVJU7QpXA5Ug1d2tkDEnlf2klQAQemBJijWQz+aC+fmgPtmlXrcfheOMa
jg9Yo9FvJd1N0xRPn2lXcHaswk+n5NVHKV+OWdHhE6pMu88yA0dlIUqCfJ1P4nCo
wr8JGSMF9ZENOZwdAZnu9YFiTyjqMTtHS4sM8s4LHGohCWOVRukPESx9MR7Py1Cj
KxPCZ9kExltacJfj6o9ZO58Tn450Aqvg6wbLbpU/t+VNA2D3VYhlN7zprD0dhWQs
riYCUUhDEiE1v5NTh2SlZEJTTJQLdd5maj1e5Gq3qo39GLBtRNolUVZSa9cg0wZO
XMHpnqma
=nwSt
-----END PGP SIGNATURE-----

--KNGrlStpoKE43+Hp--
