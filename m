Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 938F6C982D1
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 17:31:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E6FA83015;
	Fri, 16 Jan 2026 18:31:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tiAbt2+B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 939998309A; Fri, 16 Jan 2026 18:31:39 +0100 (CET)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDD9382BF2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 18:31:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x341.google.com with SMTP id
 46e09a7af769-7cfd8ca8191so725634a34.3
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 09:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768584695; x=1769189495; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Mt0MUA5PWBRz+F1hiGde3AJsg9X/nK/86FhlmQL90LM=;
 b=tiAbt2+BQywwYvm5y4/uSNHEECi+83UHHzr9I+x8oYe7szDZxI8WDY03VeLqUllf/s
 vnngXGmj1dBGHpkJbL7RNKb/jCbDOsZO802qL79oc/IU6c2SNdzRvtL9VBhEfyC2BZsY
 N6xVtHDrP+Zj9dQDbtMH8uXOp7j+NP2tGMKtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768584695; x=1769189495;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mt0MUA5PWBRz+F1hiGde3AJsg9X/nK/86FhlmQL90LM=;
 b=SOlc3wrIzobIut7W9TFh2N9fygOz/YBHvepYnCK3S2x1pXZqpQB//YL7zx2n18jzxa
 6EIGt8iiyDmvyDsICpgCEvU1Xgzayit3R2QCc8OsQzrVcy7NgHJJM8M9vvsojBrV0Xoq
 8OfDKpBqt7Wm3+YJ8hpBMcWTlGnIkCCnwQgQ6r/YZzFq3R66fz3qa9bKZpz8VfzQS+GD
 /hytuXcljxeoYgOMWsT8JqBBPLvc4Pge2zWS+fIjTFGH/+cNpw/d8n8+Ki1cOdsZoy22
 Y3VJEA/inLctMa+WVlma4Wi+tzbM7nFfmFmpy9a/swgRxlT0tvxDlQ8h5A0+t9pBE/AY
 rx4g==
X-Gm-Message-State: AOJu0YwMOJGXfRaipfJoTdPAhgMndKsSz0SjaJhsFwV29kc+5iX68KR0
 0WRoPJnL5zqgQ2EmiSzYtkdptxtx5DNdLcorWHkL2L/eI8Yov6dUPAJ+14BJYygrO7g=
X-Gm-Gg: AY/fxX5nHiGCdlxxLYDZUBSAS5crVmzNBs3v96OKjIJn+htEgUHvvi3wkTSQQ2q1sYK
 IxH4Ljz8Ju6idQnRw4a0NRLSFDr7tG4HrgUen34sxsyB9M5jwSlURIAKVpHn3+AWZ41OCpb0Bzt
 gboz51vw5hW3J+LhKhajEaw3KB8Fz6CVCDvwrsGGcCtGoKUm3xRggFIbetgWDjac6nd+nWEOMZx
 qLMTyeOi2hrAhOVeb0rXG2/nWLc2pPRKTBW1fptHrciJ2R1HDKz+sZxAM8OL9HJ4lHJZ9jLAZRw
 5Iet79ZGmmlplHRVwrhU2K/XARUkjFjYXAtTp6D60QOldQL1EE2lmEmOyi+B0NQXZteQPLTlPDc
 C93j2p7IpB12N741udAoh8D894Nuof8U4FKg25OaH2ZcpN8FkWyz7zg0boDYGgS1O4asem/lDtL
 J5pj2I9MdN5F18UtmCTlk0K04rDZnKeVPGf2hvsCkkRIHhP525JVbpe6b/lJ82IBJAiWgWWB+8N
 skkYgeuJDvkn3GOJMGI0iB6CJG17N9alRO0A+Q=
X-Received: by 2002:a05:6830:f85:b0:7cf:dcee:3db5 with SMTP id
 46e09a7af769-7cfe00d8da1mr1410969a34.1.1768584695469; 
 Fri, 16 Jan 2026 09:31:35 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf0d8b28sm2059378a34.2.2026.01.16.09.31.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 09:31:34 -0800 (PST)
Date: Fri, 16 Jan 2026 11:31:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, E Shattow <e@freeshell.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH] doc/develop/process.rst: Expand on the Custodian workflow
Message-ID: <20260116173132.GM3416603@bill-the-cat>
References: <20260109172905.1446923-1-trini@konsulko.com>
 <35fe875d-0bcc-452b-bb66-a2158b96629e@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KHRf8phLsStO7gJ+"
Content-Disposition: inline
In-Reply-To: <35fe875d-0bcc-452b-bb66-a2158b96629e@cherry.de>
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


--KHRf8phLsStO7gJ+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 09, 2026 at 07:08:40PM +0100, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 1/9/26 6:29 PM, Tom Rini wrote:
> > As seen with a recent pull request, there have been implicit assumptions
> > about how much custodians can change patches before applying and merging
> > them. This has lead to an unfortunate situation with a contributor being
> > understandably upset about the changes.
> >=20
> > To avoid this in the future, document a few things:
> > - Non-trivial changes to make something apply need to have at least
> >    [name: what] in the commit message.
> > - Only trivial and obviously correct changes can be made by the
> >    custodian, and ideally this is done in a merge commit and not the
> >    patch itself.
> > - It is the responsibility of the custodian to gather relevant tags that
> >    have been provided by the community.
> >=20
> > Link: https://lore.kernel.org/u-boot/1faefbf2-e8b0-4c94-85f5-025355915e=
0d@gmx.de/
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > With this, Heinrich, per E Shattow's comment on IRC, can you please
> > revert the commit in question, then apply his patch as-is, and then your
> > changes as a new patch in order to show correct history?
> >=20
> > And I realize at this point the subsection of this document is a bit
> > wordy. Maybe a follow-up of restructuring this part of the document
> > would be helpful? I'm not sure what would flow better however.
> >=20
> > Cc: E Shattow <e@freeshell.de>
> > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Cc: Quentin Schulz <quentin.schulz@cherry.de>
> > ---
> >   doc/develop/process.rst | 9 ++++++++-
> >   1 file changed, 8 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/doc/develop/process.rst b/doc/develop/process.rst
> > index 4bfbf0eb9c63..84ab09132a0b 100644
> > --- a/doc/develop/process.rst
> > +++ b/doc/develop/process.rst
> > @@ -244,7 +244,12 @@ like this:
> >         custodian can also accept patches against older code.  It can be
> >         difficult to find the correct balance between putting too much =
work on
> >         the custodian or too much work on an individual submitting a pa=
tch when
> > -      something does not apply cleanly.
> > +      something does not apply cleanly. If non-trivial changes need to=
 be made
> > +      for it to apply the custodian is expected to annotate the commit=
 message
> > +      with ``[name: note about changes made]``. Furthermore, only triv=
ial and

As I'm actively working on v2 right now, a few more comments.

> We should provide an example, I think.
>=20
> commit 66be03b7ee19444b23aae3990a434a7470fc1641
> Author: J=E9r=E9mie Dautheribes <jeremie.dautheribes@bootlin.com>
> Date:   Fri Nov 28 12:03:04 2025 +0100
>=20
>     binman: blob_dtb: improve error message when SPL is not found
>=20
>     When using binman with the '-a spl-dtb=3Dy' flag, if the SPL blob is =
not
>     found, binman throws a cryptic error message:
>     binman: 'NoneType' object has no attribute 'startswith'
>=20
>     Let's improve the error message to explicitly state which SPL blob is
>     missing.
>     This is particularly useful when binman is used as a standalone tool
>     outside the U-Boot source tree.
>=20
>     Signed-off-by: J=E9r=E9mie Dautheribes <jeremie.dautheribes@bootlin.c=
om>
>     [trini: Add '# pragma: no cover' because coverage doesn't seem to like
>     the documentation about this error]
>     Signed-off-by: Tom Rini <trini@konsulko.com>
>=20
> is a good one I think.

As I said earlier, I think this is actually a bad example from me, and
I'm rewording things to say not to do that.

> You also added your SoB which isn't mentioned as a requirement here. I
> believe it must, because whatever you added/changed, you must comply with
> DCO to do it.
>=20
> I'm tempted to say we maybe should add a link to the original (unmerged)
> commit so that people can actually do the diff themselves if they want to?
>=20
> For the above example, have
>=20
> Link: https://lore.kernel.org/u-boot/20251128110304.63138-1-jeremie.dauth=
eribes@bootlin.com/
>=20
> Maybe? Not sure how much friction we want to put on custodians. There's
> probably already a lot to do :)

And part of why I'm writing "don't do that" is because it's a lot easier
and clearer than trying to list all of the "do this" and "don't do
this". It's also a more clear and fair practice I think to say that all
"development" happens on the list in public and Custodians don't have a
special place to make final tweaks.

> I would really like also that custodians *tell* people that they have mer=
ged
> the commits with changes. https://docs.u-boot.org/en/latest/develop/proce=
ss.html#work-flow-of-a-custodian
> says it's only "ideally" they do for merged patches, but I really think we
> should tell people when changes are made to their patches.
>=20
> > +      obviously correct changes can be made, no other changes should b=
e made to
> > +      the patch itself. Ideally all of these changes will be in a merg=
e commit,
> > +      and not the commit itself, but that is not always possible.
>=20
> I have never been a maintainer in public spaces, and in private spaces I
> enforce a strict rebase policy so I don't have merge commits ever. I
> wouldn't know what this means (but maybe custodians do, and that's the mo=
st
> important as this isn't something contributors need to know?). How are we
> supposed to do that? Note also that not everybody know that git log -c (or
> --cc? I use -c but it seems to be showing the diff of the whole merge and
> not necessarily the conflicts?) needs to be used to see the content of a =
git
> merge commit (it won't show with git log -p).

For both of these points, an update talking about b4 from the custodian
perspective, to mirror how doc/develop/codingstyle.rst talks about it
=66rom the submitter point of view, is needed. Sending out "applied your
patch" emails without b4 was a pain, but "b4 ty -S -t 1" is easy.
Similarly, a submitter writing a cover letter and custodian using a
merge commit (like say commit 476c59be74c2eadcd32fc3032fb7ac362f02e441
in master) is done with "b4 shazam -SM message-id" and both easy and
provides more in-tree history.

> Can we provide an example here of a good merge commit that highlights what
> is expected from custodians?
>=20
> I cannot really comment on whether this will help custodians do the right
> thing as I am no custodian.
>=20
> We need to set the expectations for contributors as well.
>=20
> """
> Trivial fixes may be applied by custodians when merging your patches,
> sometimes without public notice. The operated changes are explicitly list=
ed
> at the end of the commit log or in a merge commit by the custodian.
> """
>=20
> or something like that? I'm wondering where we should put this though. ht=
tps://docs.u-boot.org/en/latest/develop/process.html#review-process-git-tags
> or https://docs.u-boot.org/en/latest/develop/sending_patches.html? I think
> this kind of change should be in the same commit (or one that follows aft=
er,
> but is done now).
>=20
> We can have some words about proper etiquette too? Like avoiding big seri=
es,
> waiting a bit between versions, not silently ignoring previous reviews for
> newer versions (you can disagree but you need to speak your mind publicly
> and "resolve the conflict" before sending a newer version (or at the very
> least say why something wasn't done in the cover-letter or under the ---
> section in a patch), waiting at least a week (more?) to send a ping on yet
> unreviewed patches, ... That's what's coming to mind right now, there's
> probably more to add? This is a separate topic and I don't want this to b=
e a
> blocker for this here.

This is also another long outstanding need, that's not been forgotten.

--=20
Tom

--KHRf8phLsStO7gJ+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWp18QAKCRAr4qD1Cr/k
ChscAPwNhvaMZKKeXdL2x/J40INQimu43Z0UAhCS8a74oqozIAD/RgelM2fZw61d
1qDT6pZjGUBpS1+4zaR8msADyZKzyQI=
=lIZW
-----END PGP SIGNATURE-----

--KHRf8phLsStO7gJ+--
