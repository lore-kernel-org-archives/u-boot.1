Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC4C7C44536
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 15:07:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 525D48341A;
	Wed, 21 Jan 2026 16:07:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cBybNo/E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B474839DF; Wed, 21 Jan 2026 16:07:02 +0100 (CET)
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 607C483015
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 16:06:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x243.google.com with SMTP id
 5614622812f47-45c78da5936so497767b6e.1
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 07:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769008018; x=1769612818; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kuJ1kBHTuVXBOIDlVM8R9GtCCWgTZVJoANPB0jwI/8s=;
 b=cBybNo/ENOExdIqw0L8KmsUL+zuq9o77Fye3hcwBBcLw9WVqD5cBQoaEMZkgXRJfo/
 qo3jgMETfDZqACtiVpTcD8wLuisdRQrwEo2Zl+zHnb/LMyxsLQy+4YwXwbTGfdclkz7h
 rfyYGA4RVyAQMF7miMB5B+OM2waeWSJ+viB9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769008018; x=1769612818;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kuJ1kBHTuVXBOIDlVM8R9GtCCWgTZVJoANPB0jwI/8s=;
 b=YZBXSkfomwUK5O+YYx1K7j90IIUG9rZVSssXlKtIpQpvw/xd4cNkf+BtccVBK8e55y
 ZRHeyehVEn4TzAxmUW3r8L8DG3SnD1janWLb18l8UIfVgL5b1U598jcyPIcLOadIQz6x
 u7UTM1Ij+9LAJ5riO8Bur7EMWqr3j9bxpFIzU5moox79AtOjFLofU6w9h9FNbx2cvsAI
 XKTpchOSxFFzVig+Jj5PDmTrWv0o90fi6w9v32swESghh47SAANORiZ0TNAXSc4KZ9w6
 5hz3vIlaCrqOnTdUz8fT4l3p6aO9iHIbvhrtfQwBq00GDb6ZuqKKY0RuaH6P53i6Cxxb
 cbVw==
X-Gm-Message-State: AOJu0YzXz6ayMwxnAaw1nIES6B5V80lhf1LnwdaA+fEHEmaqZRR5Q7rB
 vIQgumoaV8IG/1YF9nqY73noMXeAdgsoE4cdOxUUGES2Mj9fgbAtRJkNccGuUzzeLIQ=
X-Gm-Gg: AZuq6aLy6ABNApdqMy1q0asxGjtxcxpDGDmIk5UvPG8YPymrWKJM9ZAmAqtC1zAZMLK
 qS6rtW473SfQ+zidxEL3zI7Wd6xcvNMdtObOE8/VVCkpACAWtZkljxhBqrtgV6YGkN/WBn5CFy9
 DIT5NnG8I7ThlUZQE6henlAQJXvSl4pz8Z6i+PQvGKm9pfk4TBJTW81iE/3MLGbDEPKPUEPKn7f
 jH/g0piwwWkxWz+U8CBH1cyzNp/79CSzOZ3wVmAhyw3ogo0ddTbz5SmbqTc4kM8EXMRTKFnU57E
 HH//3NWy+j45sPBYrs+rdi1azaLXa4PG8jXOQYHyik/acvBekcIbjqcS7++M/cQozcVcJ6JzuN5
 VEAROmxXVqvi+zgKxpxpxcffHQaGBbik+e9afUfwYJE3OJ8GtZVrrZiHCx6J3r6w8EziIe5VCjR
 qrjUzlC7MTOfwv0r0c1IMx64oFBvybw8m63YKsDhTNzgvcj5fqevskfSPnSHOG7e1ajKAOZEs3e
 3DOiHBtEYizDCgpTdwzt332LEzX5psdNFZt8UWQNvSRGBk8nQ==
X-Received: by 2002:a05:6808:2f18:b0:450:d4b5:3527 with SMTP id
 5614622812f47-45c88145592mr9784446b6e.24.1769008017928; 
 Wed, 21 Jan 2026 07:06:57 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4044bd1488esm11599386fac.11.2026.01.21.07.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 07:06:57 -0800 (PST)
Date: Wed, 21 Jan 2026 09:06:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 5/5] doc: develop: process: Document using b4 and
 patchwork for custodians
Message-ID: <20260121150655.GU3416603@bill-the-cat>
References: <20260120223405.469050-1-trini@konsulko.com>
 <20260120223405.469050-6-trini@konsulko.com>
 <1d8efe1e-91d1-4ae4-a680-3e4200042fd9@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Io7Qk6OU+semj0mK"
Content-Disposition: inline
In-Reply-To: <1d8efe1e-91d1-4ae4-a680-3e4200042fd9@cherry.de>
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


--Io7Qk6OU+semj0mK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 12:16:23PM +0100, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 1/20/26 11:31 PM, Tom Rini wrote:
> > - We already have good custodian documentation for patchwork, add a
> >    reference and then link to it here.
> > - Add a reference to the existing b4 documentation, and reference it
> >    here.
> > - Note and link to patchwork integration, am/shazam and ty features of
> >    b4 as these are the most likely useful portions. Be specific about
> >    keeping the default ${summary} as that includes important informatio=
n.
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
>=20
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> Thanks!
>=20
> Additional comments below.
>=20
> > ---
> >   doc/develop/codingstyle.rst     |  2 ++
> >   doc/develop/process.rst         | 29 +++++++++++++++++++++++++++++
> >   doc/develop/sending_patches.rst |  2 ++
> >   3 files changed, 33 insertions(+)
> >=20
> > diff --git a/doc/develop/codingstyle.rst b/doc/develop/codingstyle.rst
> > index 7304eea0056a..2a69162fa95f 100644
> > --- a/doc/develop/codingstyle.rst
> > +++ b/doc/develop/codingstyle.rst
> > @@ -24,6 +24,8 @@ The following rules apply:
> >     <https://peps.python.org/pep-0008/>`_. Use `pylint
> >     <https://github.com/pylint-dev/pylint>`_ for checking the code.
> > +.. _b4_contrib:
> > +
> >   * Use the `b4 <https://b4.docs.kernel.org/en/latest/>`__ tool to prep=
are and
> >     send your patches. b4 has become the preferred tool to sending patc=
hes for many
> >     Linux kernel contributors, and U-Boot ships with a ready-to-use ``.=
b4-config`` that
> > diff --git a/doc/develop/process.rst b/doc/develop/process.rst
> > index f436a98433a7..fd81d9c5ebd4 100644
> > --- a/doc/develop/process.rst
> > +++ b/doc/develop/process.rst
> > @@ -232,6 +232,35 @@ feedback to the submitter of a patch about what is=
 going on:
> >       work on an individual submitting a patch when something does not
> >       apply cleanly.
> > +Tooling
> > +^^^^^^^
> > +
> > +There are a number of tools available to help custodians and
> > +contributors alike with their contributions. As a project we make use =
of
> > +the Patchwork project hosted at `OzLabs <http://patchwork.ozlabs.org/>=
`__
> > +and more discussion on how it is used from both a contributor as well =
as
> > +custodian point of view can be found :ref:`here <patchwork>`.
> > +
> > +Another useful tool is `b4 <https://b4.docs.kernel.org/en/latest/>`__
> > +and is documented from a contributor point of view :ref:`here
> > +<b4_contrib>`. It also has a number of useful features from a custodian
> > +point of view:
> > +
> > +* `Integration with patchwork
> > +  <https://b4.docs.kernel.org/en/latest/config.html#patchwork-integrat=
ion-settings>`__
> > +  which allows for automatic state tracking.
> > +
>=20
> Can we have this integration added to .b4-config so there's less to do for
> custodians? Ideally also with steps to finish the setup so that patchwork=
 is
> fully working for them?

Yes, I can follow-up and add defaults for everything but API key.

> > +* `"am" and "shazam"
> > +  <https://b4.docs.kernel.org/en/latest/maintainer/am-shazam.html>`__
> > +  for applying a patch or series of patches. Of note is that with
> > +  ``shazam`` review tags can be applied automatically and cover letters
> > +  can be integrated as part of merging a series.
> > +
>=20
> Is there any reason for using b4 am? (I only use b4 shazam myself).

I use it from time to time when "shazam"'ing something results in a
merge I have to fixup and so "ty -l" doesn't show the patch. An "am"
will put it back in the ty list.

> Should we hint at --check also?

Not sure. I don't use it because I have something else that runs and
logs checkpatch later.

> """
> Tells b4 to run a series of local checks on each patch of the series and
> display any problems. When b4 finds a valid patchwork project definition =
in
> the configuration settings, it also looks up the CI status of each patch.
> """
>=20
> We can configure which command to run by setting
> b4.am-perpatch-check-cmd in .b4-config
> (https://b4.docs.kernel.org/en/latest/config.html#am-and-shazam-settings)

Right, but we have checkpatch configured already in-tree.

> We should absolutely make clear that both am and shazam fetch the latest
> version of the series, regardless of the link being passed to it (except =
if
> -v or --use-version is used). At least that's my experience with shazam a=
nd
> the docs states it should apply to both am and shazam.
>=20
> I'm assuming the cover-letter being integrated as a merge commit would be
> behind the --merge option?
>=20
> We may want to hint at -P or --cherry-pick as ways to only pick specific
> commits out of the patch series.
>=20
> I'm not sure how much we want to hint at here versus letting custodians
> figure out their workflow on their own.

The last point is the one I agree with most. I know at least Casey and
Mattijs are using b4 as well, so I'd like their feedback on document
here vs expect people to read upstream docs. As for example, I also
didn't mention "mbox" but I use that for both re-reviews as well as "oh,
this patch broke X, I need to reply now". But I would also expect
someone using b4 to see/know about that, or have their own workflow
already.

--=20
Tom

--Io7Qk6OU+semj0mK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXDrjgAKCRAr4qD1Cr/k
Co1GAQCPY/ABdU2g5bYGSHBgDZgkRvrjB6++NBO59U5e5krx+QD/XYdE2YQulWbn
iUf25ogzQHMN7ARc1wBLE/JywFxHZAQ=
=N1pu
-----END PGP SIGNATURE-----

--Io7Qk6OU+semj0mK--
