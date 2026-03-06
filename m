Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4936AF51416
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 22:31:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE5B2839A8;
	Fri,  6 Mar 2026 23:31:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fr7qEFzL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6792783F1F; Fri,  6 Mar 2026 23:31:47 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8B2581E18
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 23:31:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7d1959ba05cso4851597a34.2
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 14:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772836303; x=1773441103; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QnztF32I+9WEgs/sYwBMDYOylhXX4TzKkG88Bk/YabQ=;
 b=fr7qEFzLXdgSwhUh+d27zgBVDmDSsfd333r0M1355+355vS2cFawVTVZlRg7qNqhjn
 zwi1n4mA5EV04uOGvTnLW9jCixArF4JnbjPUvlpiPjbI9Mgl5lIIckbJfgnRR9T3EgfK
 0RK61wedPuN+EIiJgh+BYobQqZFum634Rt094=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772836303; x=1773441103;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QnztF32I+9WEgs/sYwBMDYOylhXX4TzKkG88Bk/YabQ=;
 b=sFAOAcBtmSrDUnv4gFsPJIHwbENPON1+rT/Eox9rxJ8PDmWCsCQXr2dV2zBJXnvfnB
 9IArZ4llprPOYvM0dO0qWrc3ONO2bY5TvFNfhVz2Tc/ia6YW2Zc6S9jaZFzR4JkCUPCL
 E2EM1XfUr8niD2J6vSRR2e8YbDY/pyg7P3XW2Bvpx8pfiSbHSu/EySQ9CtNlU8EQsJB5
 YKJf1XNj0nDu8/CHrl0WpkPZqFa+0nEw5yQieTok1GY+LXaDyqpUOpaWVD30338bOJk1
 3/DgovoXY3RNnbA2hpiOMCW2EVc0qhZ68tiZpdZAAPZISiHzmAGFkmlFiI/+AfmZ16vV
 1rjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYckyf5y8gd0arYF/czxetaHCibHEtnxF694rVi0qVEWYLSZaqLAjHBVh/Ok8s8HtP33e86SQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxhSX/KnooNgkFvoTt85GGZ5UWDPf8uK4jdnzJOYZ4BN9Hh/U8A
 NNc5KRFcHL6rWKolr4aPZKXQMZDyW/nqMSE/Pg2wA1KU1WalOKhPr5pz8EGYyrL03p0=
X-Gm-Gg: ATEYQzyaFYEFOLt2VSmGLQuuQ4yKxvuGVgGXKb/ZOFhDF3U8WPbtRJBJLTXhmC/BK+B
 Zxe7dp104/UwUI68wad66l/EgcBrynN6S0PlpZR+pro4bnm6M8tAUjNd44+9MkRw2gY9OimeQ7w
 6eOWfA7xEmW3fw0fco+o0y3/6O0DDkbL99D4VwSvTfd0ErxneyU2JW96tKTzUVf7GY2SWVkSwVC
 dEQSkI1B2gR6OT9U8OWqYxRQywlf3A3nMyeXqz3rYvig47j4SdHKapRzEBKwOmA9s+6S0m/iyp+
 GUcEPgz/2niEsisuYj5nbM3FS2pDqTQ/sC6C9LTR01Rrzkhqxm795bxOHgfpSobUG6onHE2hnXh
 MDyhmFcd26XtAcOCkVoov+kCqOJizxQK4fFIA3Y+g8Iv6PXLKLnEoh+/HC6VoHJaxoJOTryaz36
 ef8QommT8TGNbowrC/FyoEHJY2kw9bz567qZhfaRvRSzu9REge8rvvvQWM2LSn3CmbkerO3p620
 8K1DXq9tj1VU629Tl3BfII5DR9RWSOKA0d9cdeRaNtJwM4PImc=
X-Received: by 2002:a05:6830:4c08:b0:7c5:31b6:435c with SMTP id
 46e09a7af769-7d7270571c9mr2534416a34.29.1772836303452; 
 Fri, 06 Mar 2026 14:31:43 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d728c757cdsm1735320a34.11.2026.03.06.14.31.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 14:31:42 -0800 (PST)
Date: Fri, 6 Mar 2026 16:31:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] Add an initial CONTRIBUTE.rst
Message-ID: <20260306223140.GV1388590@bill-the-cat>
References: <20260303214653.4096007-1-pbrobinson@gmail.com>
 <94ff2577-ee65-4e45-8cfd-315a4669a8db@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Kohtam8JUzvtIVIU"
Content-Disposition: inline
In-Reply-To: <94ff2577-ee65-4e45-8cfd-315a4669a8db@cherry.de>
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


--Kohtam8JUzvtIVIU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 05, 2026 at 06:45:33PM +0100, Quentin Schulz wrote:
> Hi Peter,
>=20
> On 3/3/26 10:46 PM, Peter Robinson wrote:
> > Add a contributors file to provide a high level overview
> > for people who wish to contribute to the project outlining
> > basic details and setting some project expectations.
> >=20
> > This isn't intended to replace any of the existing documentation
> > but rather provide a succinct top level document that's easy
> > to find to enable users to understand the project and get
> > started as quickly as possible.
> >=20
> > Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> > Cc: Tom Rini <trini@konsulko.com>
> > Cc: Neil Armstrong <neil.armstrong@linaro.org>
> > ---
> >   doc/CONTRIBUTE.rst | 70 ++++++++++++++++++++++++++++++++++++++++++++++
> >   doc/index.rst      | 10 +++++++
> >   2 files changed, 80 insertions(+)
> >   create mode 100644 doc/CONTRIBUTE.rst
> >=20
> > diff --git a/doc/CONTRIBUTE.rst b/doc/CONTRIBUTE.rst
> > new file mode 100644
> > index 00000000000..7602e5c5a6a
> > --- /dev/null
> > +++ b/doc/CONTRIBUTE.rst
> > @@ -0,0 +1,70 @@
> > +.. SPDX-License-Identifier: GPL-2.0+
> > +.. sectionauthor:: Peter Robinson <pbrobinson@gmail.com>
> > +
> > +Overview
> > +--------
> > +
> > +This document is a high level contributors overview setting overall ex=
pectations,
> > +so people can get started quickly, the rest of the documentation goes =
into the
> > +details.
> > +
> > +Code of Conduct
> > +---------------
> > +
> > +The U-Boot project doesn't currently have an explicit code of conduct,=
 but all
> > +contributors are expected to act cordially to, and be respectful of, e=
ach others
>=20
> s/others/other's/ ?
>=20
> > +contributions and opinions. There are many code of conducts for open s=
ource
> > +projects available to review if you are unsure of expectations.
> > +
> > +Repository
> > +----------
> > +
> > +The official U-Boot repository is located at https://source.denx.de/u-=
boot/u-boot
> > +> +Contributions
> > +-------------
> > +
> > +Contributions to the project are welcome. The U-Boot project uses a fa=
irly
> > +traditional Linux style development workflow using git and `a mailing =
list
> > +<https://lists.denx.de/listinfo/u-boot>`_.
>=20
> Note that lore.kernel.org/u-boot may be more user-friendly (especially for
> people using b4).

Yes, but that's the official list location, lore is a mirror. And...

> > +Patches should be sent to the mailing list using ``git send-email`` or=
 the
> > +equivilant commands using ``b4`` or ``patman`` with appropriate sign-o=
ff and
> > +attributions for the code in question. Maintainers should be copied on=
 mails
> > +and they can be found with the ``./scripts/get_maintainer.pl 0001-fix.=
patch``
> > +script. Please don't send patches as attchments, and ensure corporate =
mail
>=20
> s/attchments/attachments/
>=20
> > +systems don't reformat patches, append disclaimers or other uneccessar=
y notes.
>=20
> s/uneccessary/unnecessary/
>=20
> > +
> > +Patch Series
> > +------------
> > +
> > +Patch series for a specific subject are welcome but they should be con=
strained
> > +to a single topic with a cover letter outlining the intention of the s=
eries.
> > +
> > +Generally bug fixes for existing bugs should be at the beginning of the
> > +series before any enhancements to allow those patches to be picked up =
early.
> > +
> > +Each iteration of a patch set should be versioned, allow enough time f=
or people
>=20
> Awkward wording here. Maybe switch to a dot instead of a comma?
>=20
> > +to review previous versions of the series and incorporate all the revi=
ew
> > +feedback before sending a new version. A week between larger patch set=
s is
> > +considered as reasonable amount of time.
> > +
> > +Development Branches
> > +--------------------
> > +
> > +The U-Boot developers use two main branches for developing the code. T=
he master
> > +branch is used for the current development cycle, while there is also =
a next
> > +branch intended to land changes for the next release early to enable w=
ider
> > +testing of larger code changes. The next branch is merged to master sh=
ortly
> > +after the tagging of a new major release.
> > +
> > +Similar to Linux there is a two week merge window post release after w=
hich a
> > +release candidate is tagged. There's typically a new release candidate=
 every
> > +two weeks post merge window until the stable generally available relea=
se.
> > +
> > +Release Schedule
> > +----------------
> > +
> > +There is currently four major releases a year in January (.01), April =
(.04),
> > +July (.07) and October (.10). These typically happen on the first Tues=
day of
> > +that month. There is currently no release branches or long term releas=
es.
>=20
> General remark, this doesn't provide links to more extensive documentation
> so it feels a bit like a single-source of truth. We may also unwittingly =
end
> up contradicting ourselves in other parts of the docs.
>=20
> So at the very least can we have links in this docs pointing to the more
> extensive documentation? Especially on the mailing list contribution
> workflow.
>=20
> Another option could be to reuse verbatim other portions of the docs. Move
> current snippets into my-snippet.rst.inc and then in the appropriate plac=
es
> do
>=20
> .. include:: my-snippet.rst.inc
>=20
> Such that it cannot be outdated. Of course, wording or syntax may need to=
 be
> adapted so it's not looking odd in the various places this may be include=
d.

I think we need to have this document be a bit more referential of the
other documents we have. I think the snippet part might get difficult to
word on its own so perhaps more of a style of super brief overview and
link to the full doc. Like for the release schedule just something about
how we have 4 releases per year (typically January, April, July and
October) and their schedule is well defined in advance. For more details
please see :rst-link to doc/develop/release_cycle.rst with appropriate
link text:.

--=20
Tom

--Kohtam8JUzvtIVIU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaatVzAAKCRAr4qD1Cr/k
CsnJAQDBoCngSdbSocfZOCDi4iSSwKtpnU1qTawvpcO5tsPjYwD+JgLpJCN4LOpP
r0TjbhiKsFir/Vr5BE/cUyiKiQpc0gc=
=rKjE
-----END PGP SIGNATURE-----

--Kohtam8JUzvtIVIU--
