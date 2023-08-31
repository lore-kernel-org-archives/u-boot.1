Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F8DC83F01
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 13:28:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BFC486583;
	Thu, 31 Aug 2023 15:28:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="P9Ca3BzC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E37E28657C; Thu, 31 Aug 2023 15:28:09 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF0758658D
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 15:28:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-58df8cab1f2so9740787b3.3
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 06:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693488482; x=1694093282; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XaLo5/rHPKbWFTIRdy2sMN2zXSZ2O7+pcqL5C6HXEMU=;
 b=P9Ca3BzCEW2J4jOKq+Vtl89fjdUtzW0oefjHEkCIWqkicHvRTy9sPEylFHjCvAbekQ
 SpLbk103X7RamjyTEkRKlnRgkhoEWj3C6Yg5IwpSrouVM55XVvX1imNiCK97+hOaJiWF
 UFWYC+8uYakjwW0nvr8s+onA2ABXYPbxcLspU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693488482; x=1694093282;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XaLo5/rHPKbWFTIRdy2sMN2zXSZ2O7+pcqL5C6HXEMU=;
 b=FON2oJKvvRcr31ZS3i8R+/Htp1wf6q0czDaadwQv9EJF+Flu+IHVksax92Mr9O78mx
 KpkRA3snodlpYalFPR+8wOP60etTYhAuYvyb11tfeJjmOiqm/AkF99fG5P+UBQyEVLU6
 mB5MSs30CrQEJcaj0ZDktCOe1iq1XoavDJAzroSO6VDP4oGJqZaX6kiwe/DJv+yo0zl5
 0yCEcs7EVyWtzIDywqd3Xnz+EYJbHdLEp/WuqWwd6sXi+msja71Vm/3n4EROjD9a4vhp
 s0c/MCUsc0uljlZ3B7z6dWgi16QYQgcBJWuUzcDGzEinQKnFzoGIfwHGXwqRiR/ai3vc
 ydTQ==
X-Gm-Message-State: AOJu0YxYi4LtXjCwYbEgDbG83hgFUKTvKbUknhcCDBaq2SECRu5yTH2B
 ZA5+YfkGqoc8rMBvoVTtGNfw2A==
X-Google-Smtp-Source: AGHT+IF+MUG4G4xPNvHiB1oQH/VbMv5ZuRsNfeXJLrmxbqX1KsGgSiYkg5CPl4cq0nX7c7CTpdI5XA==
X-Received: by 2002:a81:6d13:0:b0:583:d9dd:37fd with SMTP id
 i19-20020a816d13000000b00583d9dd37fdmr5221997ywc.31.1693488482584; 
 Thu, 31 Aug 2023 06:28:02 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1cd4-1a46-fd5d-6cab.res6.spectrum.com.
 [2603:6081:7b00:6400:1cd4:1a46:fd5d:6cab])
 by smtp.gmail.com with ESMTPSA id
 e128-20020a0df586000000b00559f1cb8444sm407402ywf.70.2023.08.31.06.28.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 06:28:02 -0700 (PDT)
Date: Thu, 31 Aug 2023 09:28:00 -0400
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [RFC PATCH 5/5] doc: Add a document for non-compliant DT
 node/property removal
Message-ID: <20230831132800.GN3101304@bill-the-cat>
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
 <20230826090633.239342-6-sughosh.ganu@linaro.org>
 <CAPnjgZ3AexW4vfO-A8WYGE0OD5EZnOUA7tA1QP71Bcw51QArBQ@mail.gmail.com>
 <CADg8p96zOXDaVV9CFcbeKgdZwG7pwfCp66GEY_eoYC6FCHeKZA@mail.gmail.com>
 <20230828183936.GN3953269@bill-the-cat>
 <CAC_iWj+d_xLKJS_KHYEExSQb2MuU0K9BYeLDbnHSdp8wF7W+Pw@mail.gmail.com>
 <CAPnjgZ3mobofYNB7B4nmJg8GH12FQSJ7vcEXaVydtWwSLhvfLQ@mail.gmail.com>
 <CAC_iWjKeD72f0giLUbeZZ0aP2h5kgNJw+va1o50bGx8fbqp3iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="i9JI+56ZD+/uBHbD"
Content-Disposition: inline
In-Reply-To: <CAC_iWjKeD72f0giLUbeZZ0aP2h5kgNJw+va1o50bGx8fbqp3iQ@mail.gmail.com>
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


--i9JI+56ZD+/uBHbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 31, 2023 at 10:52:04AM +0300, Ilias Apalodimas wrote:
> Hi Simon,
>=20
> On Thu, 31 Aug 2023 at 05:50, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Wed, 30 Aug 2023 at 01:25, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Tom
> > >
> > > On Mon, 28 Aug 2023 at 21:39, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Aug 29, 2023 at 12:04:53AM +0530, Sughosh Ganu wrote:
>=20
> [...]
>=20
> > > > >
> > > > > Please re-read the document including the last link [1]. If you go
> > > > > through that entire thread, you will notice that this is precisely
> > > > > what Linaro was trying to do here -- upstream the binding for the
> > > > > fwu-mdata node. It is only based on the feedback of the devicetree
> > > > > maintainers that this patchset was required.
> > > > >
> > > > > -sughosh
> > > > >
> > > > > [1] - https://lore.kernel.org/u-boot/CAL_JsqJN4FeHomL7z3yj0WJ9bpx=
1oSE7zf26L_GV2oS6cg-5qg@mail.gmail.com/#t
> > > >
> > > > Please note that this right here, that the explanation of why we ne=
ed to
> > > > delete this node, not being a bright shiny visible object is one of=
 the
> > > > big problems with this patchset and implementation. It cannot be
> > > > footnotes in email threads as to why such-and-such node/property is=
n't
> > > > upstream, it needs to be documented and visible in the code base /
> > > > documentation and an obvious you must do this for future cases.
> > >
> > > I thought we agreed that deleting nodes that won't be accepted
> > > upstream is the right approach since that would break the systemready
> > > 2.0 compatibility.
> >
> > Isn't that controlled by ARM/Linaros, as are the devicetree bindings?
>=20
> The device tree validation happens through the dt schema validation.
> You can read a bit more here [0]
>=20
> > What am I missing? Let's just fix the bindings so they can be
> > accepted.
>=20
> I can go through the mailing lists, but I am pretty sure you've been
> trying to do this for a number of years and got pushback for many of
> those bindings.  Has that changed?

Yes, yes it has changed. It has changed for the better, and we're
all working together to get things accepted.  Hence Simon's big concern
that adding the framework to delete things from the tree easily will
cause people to stop trying.

> Can you guarantee to all the
> vendors that all the bindings will get merged and they won't have a
> problem getting their boards certified?

It certainly seems that, ahem, no reasonable binding will be refused.

--=20
Tom

--i9JI+56ZD+/uBHbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTwlVUACgkQFHw5/5Y0
tyyfOwwAs56Uuzhc0WOdqnqT/OfElbVLkWcKHuSxbu+0FrxG+GRGDoWhS2CFIG38
Og5ng2sPssNy9NybJcglnGKaQi/tHI/A/rr/y9TBJBb9wKFmtnJ1T/O+MfMR+BND
bLeMZv7RlCt87hX1mbhURZOQ0+xkNL/YUsk1DNpBqssO331p9Kbd3+7KM3w77q+B
SzxoLGQn46Md+60KbmmKq4kWtDZk/RM+X3/oskIfWXjw+XvLEl5lFHLRCHHw8eLj
pXFqWsZ8taW0+lk5sRNbjsMU8hjY+SwINPsZUGKgMHKZeL83iVlVSzwb8dHnMp/c
XMb8AUvqagDJMhAQfcaxUtOha+NIlH2evM51aAzR5aS425hcdtn2EqD4ZKndEEe/
KXWqVSnqW8lj4q0BLzuH2vBQuvFuMPankCCwh/0ShfSE7uiu/CSBlYzurHDIOHsU
nQUVWHAa/6M+sDkSakDn5vM0SLZ/u5vRvY8IPnWHm0JxazclCd11lgu+NnCakL8V
8OP2DQZ4
=t3Rq
-----END PGP SIGNATURE-----

--i9JI+56ZD+/uBHbD--
