Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8293BC3ABC3
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 14:07:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8024C81DD6;
	Mon, 12 May 2025 16:07:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="stQrUtd2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55ED182162; Mon, 12 May 2025 16:07:29 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1005800C1
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 16:07:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7c5b8d13f73so578416585a.0
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 07:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747058845; x=1747663645; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AGd8+9Iq5VSDlh+QUziWF05POUtDYXwcR/pnWd9uuUY=;
 b=stQrUtd2GC/XFhyM1zQWBEC9/M/Yo8zl35wDA1fJhs6tKu49ABHgBgZNSKlqGUnNus
 xAPk76qaPkzi29mXGz2MYp3mlsGlCVkwbOpqAkzJJzLjzw5BnEfTKRV4yHQ1lmCF0ivq
 OUu9GWP3W7IrpISeoUzBo8Dq4SABp6TA80K3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747058845; x=1747663645;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AGd8+9Iq5VSDlh+QUziWF05POUtDYXwcR/pnWd9uuUY=;
 b=MFLboJ0rzPvRy0ZvG730Dr3uAIGKAnGyQFuEA3oD+t9XNPc67gNOcy4WowvBvOnRNr
 ZOkqJbG0tbc60H+kdb9SDmYe/Mne6r1mq8JRnqrVTDK3JgbQcAWhy1EwTKOTd47quSSZ
 7NIjMAPOe9bjB+upXzo5YOmCo6hzj9fLaDK/u4qXCNMDoiR/Q92o6+iBHGfWT38bHDIc
 Zd30nTIHYKXDxJPO01s1CYhU75Wh5HdR9gvtMCPwAxGORmnRkZRLKFdeVWm8h/yN5aYq
 w0OVJwDmUlk2A8ERE3KsAe8B7rTZLDfXzW/N4D09yKZoR56Vox7+mJypDq01IiYp1UQm
 nnAA==
X-Gm-Message-State: AOJu0YxLh6OpeiCwv68OI9csciJ/EDv2sf1Y+OqHtKdgctmc5X7TIFOV
 ty9xcBD2l0kEeLBxFSj5XkdOk7dE+FUzrIvtq9/+F1e08BxOdrRnZvZo7THQejeGatOKUEigk0f
 2FkY=
X-Gm-Gg: ASbGncvaC8U7mDQsbQP/eJyp6TrYKvyo4ffWeuCe20AFLvus0DURm3+BpR1bm3Wnsrk
 X1AuBmrMyfFMC9CFIID62+gMmUWcYs2JvvhRf6jEwGo36lnRetqG37f6ssWtBLWcaj0s2xFpGM2
 q7xsm1Jn8JRtKm3meLslMg2Cbx8q4ESK8kEx1OxRiQShrgHkBNX9D09bXboNKbN4o1NKE7uyAUi
 SyGM7x2KUIywfqpx7qiabgDH4fMxNiUrooi19NfFJSy8V2WeNNfWXRZC6AdxZTChRTnW8Gf3unS
 jmQKgipnKziKLy8pzEaT93wSmMmCIbf9gbi34KhEEe7Gvf3YKFn7pJSRh/H0s41TT/JNIk4SXlE
 Sp9s7v/zwsoYI
X-Google-Smtp-Source: AGHT+IEtDkkxpKpzAG6AtbcYULdyNPA7+jrEkd6moVjiLNbkHYmb3pXYJN+5nAqrh6tEtpJInDgEaA==
X-Received: by 2002:a05:6870:a783:b0:296:a67c:d239 with SMTP id
 586e51a60fabf-2dba42af8bbmr7605088fac.12.1747058832861; 
 Mon, 12 May 2025 07:07:12 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60842b0972csm1625237eaf.26.2025.05.12.07.07.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 07:07:11 -0700 (PDT)
Date: Mon, 12 May 2025 08:07:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2 2/4] doc: pytest: Framework for documenting tests and
 document test_000_version
Message-ID: <20250512140709.GO603748@bill-the-cat>
References: <20250225205003.2640910-1-trini@konsulko.com>
 <20250507221112.518041-1-trini@konsulko.com>
 <20250507221112.518041-3-trini@konsulko.com>
 <383cc638-2db5-470f-8585-13274a338c6f@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nrk1BVR6KZ/T852O"
Content-Disposition: inline
In-Reply-To: <383cc638-2db5-470f-8585-13274a338c6f@cherry.de>
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


--nrk1BVR6KZ/T852O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 11:12:50AM +0200, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 5/8/25 12:08 AM, Tom Rini wrote:
> > In order to easily document pytests, we need to include the autodoc
> > extension. We also need to make sure that for building the docs, CI
> > includes pytest and that we have PYTHONPATH configured such that it will
> > find all of the tests and related files. Finally, we need to have our
> > comments in the test file by in proper pydoc format in order to be
> > included in the output.
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Cc: Simon Glass <sjg@chromium.org>
> > ---
> >   .azure-pipelines.yml                    |  2 +-
> >   .gitlab-ci.yml                          |  2 +-
> >   Makefile                                |  3 ++-
> >   doc/conf.py                             |  2 +-
> >   doc/develop/pytest/index.rst            |  8 ++++++++
> >   doc/develop/pytest/test_000_version.rst |  8 ++++++++
> >   test/py/tests/test_000_version.py       | 10 ++++++----
> >   7 files changed, 27 insertions(+), 8 deletions(-)
> >   create mode 100644 doc/develop/pytest/test_000_version.rst
> >=20
> > diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> > index 5e1938b05262..9c136513bb9e 100644
> > --- a/.azure-pipelines.yml
> > +++ b/.azure-pipelines.yml
> > @@ -92,7 +92,7 @@ stages:
> >             set -e
> >             python3 -m venv /tmp/venvhtml
> >             . /tmp/venvhtml/bin/activate
> > -          pip install -r doc/sphinx/requirements.txt
> > +          pip install -r doc/sphinx/requirements.txt pytest
>=20
> Shouldn't we force a specific version of pytest like we would if it were
> part of doc/sphinx/requirements.txt?

It's a good question. I don't know and I didn't want to drag the whole
of test/py/requirements.txt here nor have to worry about the pin in 2
places. I am hoping that for documentation needs this will be OK.

>=20
> >             make htmldocs KDOC_WERROR=3D1
> >             make infodocs
> > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > index 6f11331514b8..7aadd5d8b735 100644
> > --- a/.gitlab-ci.yml
> > +++ b/.gitlab-ci.yml
> > @@ -164,7 +164,7 @@ docs:
> >     script:
> >       - python3 -m venv /tmp/venvhtml
> >       - . /tmp/venvhtml/bin/activate
> > -    - pip install -r doc/sphinx/requirements.txt
> > +    - pip install -r doc/sphinx/requirements.txt pytest
> >       - make htmldocs KDOC_WERROR=3D1
> >       - make infodocs
> > diff --git a/Makefile b/Makefile
> > index 15c7e633b874..bd136a48982a 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -2448,7 +2448,8 @@ DOC_TARGETS :=3D xmldocs latexdocs pdfdocs htmldo=
cs epubdocs cleandocs \
> >   	       linkcheckdocs dochelp refcheckdocs texinfodocs infodocs
> >   PHONY +=3D $(DOC_TARGETS)
> >   $(DOC_TARGETS): scripts_basic FORCE
> > -	$(Q)$(MAKE) $(build)=3Ddoc $@
> > +	$(Q)PYTHONPATH=3D$(srctree)/test/py/tests:$(srctree)/test/py \
> > +	$(MAKE) $(build)=3Ddoc $@
> >   PHONY +=3D checkstack ubootrelease ubootversion
> > diff --git a/doc/conf.py b/doc/conf.py
> > index 3cb9b2bb65e5..84d028feda83 100644
> > --- a/doc/conf.py
> > +++ b/doc/conf.py
> > @@ -48,7 +48,7 @@ extensions =3D ['kerneldoc', 'rstFlatTable', 'kernel_=
include',
> >                 'kfigure', 'sphinx.ext.ifconfig', # 'automarkup',
> >                 'maintainers_include', 'sphinx.ext.autosectionlabel',
> >                 'kernel_abi', 'kernel_feat', 'sphinx-prompt',
> > -              'sphinx_reredirects' ]
> > +              'sphinx_reredirects', 'sphinx.ext.autodoc' ]
> >   #
> >   # cdomain is badly broken in Sphinx 3+.  Leaving it out generates *mo=
st*
> > diff --git a/doc/develop/pytest/index.rst b/doc/develop/pytest/index.rst
> > index 435d84fc619f..ca45e157d3be 100644
> > --- a/doc/develop/pytest/index.rst
> > +++ b/doc/develop/pytest/index.rst
> > @@ -10,3 +10,11 @@ General
> >      :maxdepth: 1
> >      usage
> > +
> > +Individual tests
> > +----------------
> > +
> > +.. toctree::
> > +   :maxdepth: 1
> > +
> > +   test_000_version
>=20
> Can I recommend using a glob here to avoid having to constantly modify the
> index.rst whenever a new file needs to be added to it?
>=20
> .. toctree::
>    :maxdepth: 1
>    :glob:
>=20
>    test_*
>=20
> for example, c.f. https://www.sphinx-doc.org/en/master/usage/restructured=
text/directives.html#directive-option-toctree-glob

Oh neat. Yes, that should be done instead. I wasn't expecting Heinrich
to pick it all up so quick, do you want to post a patch or should I do
it and Suggested-by you? Thanks!

>=20
> Cheers,
> Quentin

--=20
Tom

--nrk1BVR6KZ/T852O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgiAIoACgkQFHw5/5Y0
tyyZlQv/S7+04Uds4bCpCShB27t9KyyQsG2uE+GcyRoSvzozQj/hDtoWGrlbn1ta
FRLNrWKMqxYb/004wXuus3TSTAKeSed7HVCkDYgHBYZ3ubE/0PV+HOkZkJIeIg1p
r3xt4cnjTtB3dYLboSr+fCO+NkqG8AIcnA2Jtn1bbDhr+/s2qIwlYkrAilhqoMkN
sjRd3Hc+QrL8ZMmt2PhrSMTeX2+1f9uOvow2aZd35W2jo4t2rh+AdxjZWDwX6GGV
Ln0D0c0Wn06WuXTL3Y2/AWyCLyZ1SWz1Gi+KRcC1OdbqGvPdS16sW+9JpKP4LJ3p
PeeigV/H2qMVn242bmS1RA7pu/9T9mg/qiZGWUrUiDQ4pKumRzFsWvlsib/JUqeQ
d9tYde++4Bjxrg/SLvpB3nz5ePT4BIvumH4pmqxHoWaUOMV/JMbZ9XbYFOgtSKpN
kHoeouzI0o1VX/tyUZHQfHTk91e3BiBv3MSuIODKL8KS6KOZ5evDr9d5VwaCsU/w
q2TF2Pz5
=w2IP
-----END PGP SIGNATURE-----

--nrk1BVR6KZ/T852O--
