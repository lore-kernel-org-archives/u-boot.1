Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D9CD26D85
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 18:32:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A65D78439E;
	Fri,  9 Jan 2026 19:32:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iyTezkz+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C92E843A4; Fri,  9 Jan 2026 19:32:12 +0100 (CET)
Received: from mail-oa1-x42.google.com (mail-oa1-x42.google.com
 [IPv6:2001:4860:4864:20::42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41B6584390
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 19:32:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x42.google.com with SMTP id
 586e51a60fabf-3e3dac349easo4098585fac.2
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 10:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767983527; x=1768588327; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=voBzvUjrDIYf6Rntizgimh0SS0F+wzSXt+4cGvtJmww=;
 b=iyTezkz+hRhgwGBq/QKHw8Iu8BLpp1a6eGHNGmCOGQpfCP8stjGOAIsa+9MF6vEwx6
 fNC762aB7/hRYB8kNFfIa7tUk/dxiKKBmEslR5MVX+jHq3lpeUu2FuDFbzlymanN7hT9
 lbeoTu5ZTG7sb1XjyOotQCPAjbD6A8Q9RDs8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767983527; x=1768588327;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=voBzvUjrDIYf6Rntizgimh0SS0F+wzSXt+4cGvtJmww=;
 b=hOZ6f0B3ZTDoNFTbV7Lme52ZT3YxHYqw9AfjZn4if3CtSI0JEXNbH2eE1ECu1REsEt
 VeDmPMKt7Zv3rg2IpsEvxf7Ke2XkZVjyjgZE3S01cr4VwfAakzxwaAo38ZYVndbL5DNb
 sM1S4b385HB8PyfXM9PM3Di844UryKr47/U0xNemQicauQ2nB7r14or6LCI9J1MsXipN
 RmPBFoaCosPKHO2iSwqvm1AsZCH1OaKPhUUtZX9L5EWcieuy+PGc0aHzh+RmPZcKGNd7
 JRPUACy/JVab0ZcZLQinqrCGjj4DhtMrOBJ/EQxQj0yl/hcbpNyOVMdvcxuomu6cc0BH
 Stig==
X-Gm-Message-State: AOJu0Yz4ng3o5In2VnBQTiK/DuFHQr+fL6Z7Q/2p931vLX0VgWXXEOOD
 L7t3UZOBVzRILn+Ce/4Ii0Y7VwP3a44MiSvkhvqYqHBjYJ0ACLXefoCBYK6S7I0P7/g=
X-Gm-Gg: AY/fxX4d3UEjkjnzEvXlVLweMBoSVYot8qpTzpPq16gSI1Zz7DRGDRMNgoT37WtBn82
 ai+rbMLB0ECSFlbMoqkadjFaipKiy6f6NE2rPoglCgupJzB/KnfZzfREBAono9yav5L5ZbXK3Ny
 z+k8SoJhyDQGAuUBbqNcrPJV+4Gg/ocrO7w1yNClpc6TwrhteyWcQcWlb0Bh7dvcZ3r5tatZ++W
 0kLUU/HbmK+6FuTL+1fQUzT4xFG2sVjf1kyZgg9u/W+WBhYcS9M/JX+AUs+YlpJcP/Uo9TVDiGW
 LkEsauOc2Gpvgg/gJ3mT6OQRGJIe4Sz3/wIMApi6J3cH4Ms0GksSvp5PDzO4OT6can476OSeMn5
 8fY19X0sP3GdJK7T/IrmlZChpx58rcE9Dni1du6ljUlVR5Fe/tXqNJJJK9tOMU8xcyE3cCmFj6V
 L6fJ/GzIbrXqYCMbEAf19llX91d7a8I6NYxX9HTmbjzRPetRWKa2xVfmOxR4Ss5PgSt9L3XkOEY
 ADVwRuSF3lfieU+7kiAIwhGDQUI5r9uefNDlzzu2PRSTJIpjA==
X-Google-Smtp-Source: AGHT+IHzMculg/QI4Xc2aaryoVNPW2/VR28zCHzAImYyhfIjh9TM4/gdGtvSMH6t5nT6CMN+W0Zn2A==
X-Received: by 2002:a4a:d888:0:b0:65f:6535:c55f with SMTP id
 006d021491bc7-65f6535c932mr2448390eaf.29.1767983526768; 
 Fri, 09 Jan 2026 10:32:06 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ffa50dcd81sm7233423fac.17.2026.01.09.10.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 10:32:05 -0800 (PST)
Date: Fri, 9 Jan 2026 12:32:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, E Shattow <e@freeshell.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH] doc/develop/process.rst: Expand on the Custodian workflow
Message-ID: <20260109183203.GH3416603@bill-the-cat>
References: <20260109172905.1446923-1-trini@konsulko.com>
 <35fe875d-0bcc-452b-bb66-a2158b96629e@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rZS7KWIATO1IKE1K"
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


--rZS7KWIATO1IKE1K
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
>=20
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
>=20
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
>=20
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
>=20
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

That's a lot of feedback, thank you. I think this means for v2, I need
to:
- Move most of the existing wording to another section, and reference up
  to it.
- Note that some things we have done before, really shouldn't be (in your
  good example, maybe I should have pushed back on the contributor to
  try and figure out how to convince Python it *had* coverage and not
  just pragma past it, to not have the contribution sitting out even
  logner).
- Incorporate much of the above and try and remove other assumptions I
  did make / added in my wording above.

--=20
Tom

--rZS7KWIATO1IKE1K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWFJoAAKCRAr4qD1Cr/k
Cn8kAP9eO33ooyEmdbnVE3A0+F9jowNITs9uPptLIJMPFHZJjQEA+H+CNJQv8Ne+
Dcp7LxruNNoOskwqZMrNFtHuwLdDgww=
=c3XJ
-----END PGP SIGNATURE-----

--rZS7KWIATO1IKE1K--
