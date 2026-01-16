Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E976C982DE
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 17:56:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B990F8309A;
	Fri, 16 Jan 2026 18:56:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ufPkAxQz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 342BA8367F; Fri, 16 Jan 2026 18:56:09 +0100 (CET)
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com
 [IPv6:2607:f8b0:4864:20::c42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1109D82BF2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 18:56:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc42.google.com with SMTP id
 006d021491bc7-66106a2f8d1so1576594eaf.1
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 09:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768586165; x=1769190965; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/sYXozfwMFnnaVoOhu1nbO/tdBuud6zo3KMxK8cvTp8=;
 b=ufPkAxQzbgAAmJcC7z4JH8OFDl5hW7iJKJl4IGxCSwFyghKQf9WqtdH0YUQjdYIIf2
 H5oAuVBo9PyoCwRBUnrR7rMZKc+0WFMKcjzS2RISrSwWCoVhy3ce7U5zGLsHNZErvoOV
 rzJ9bWlR4i4B2n67faCc8EA9dIWz0xEa+BRg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768586165; x=1769190965;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/sYXozfwMFnnaVoOhu1nbO/tdBuud6zo3KMxK8cvTp8=;
 b=pwzuOjWgljwb9AwMryXqNDdfXghb5gOmJLkBFLjBC1/HIlgc6JoFmN2JcZTO/xy3Gl
 hFaHiZwo2YAmez42HYuDgsBzvz4nMWtJhZRyjmyDEKHrXBxRmMGwgeEzJIIqAzyofXTG
 m5053I1lH27LeU5jfhE5r9C1U0KcrWARVpYVfQMzzZrFoNXexsleDe0e5Fkk40nRV2OY
 zzOchX5SXpX3mieOI6fyD+7vMtrFekt/X1Chq8bhZ59s+XD1vxF7IR9itrzrNH1pHSjt
 K6v1Fq4aAS8RLoe29o7roJX/fHCKUnm8Q2HxF7arAwxa42M8gTfLmh9v2tmzMcXJUDbO
 fvkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCHBjeuw2C9m81IaDuzYjgp9BEA5EbbkL7Z4yugK2t+rfzlooKbIsijiP3agUemDtfLSUxgaY=@lists.denx.de
X-Gm-Message-State: AOJu0Yz5k8fTUtGPXysXS8qb68saRd1gn7OGJmnhS3kEeHNsKhnGkDOG
 jMi5A48Wn6ygNGTNtZFj1DpHMB0NiJ2aIR8117/yXKdtl28P1S/POaQxSOD9gZcetodeWSZ040P
 Nc+U7E/o=
X-Gm-Gg: AY/fxX40SpAbmCBLJ9SkQ91eavBWNASsUp9qN4t7wKFotDCXz1zErVi/iTaCyooExe6
 Ec2dSGJHrFBNQdXqvxry1rF7k0aXNcPo4/Az9HLZv28zn7l/UVjlckCJm2KxXCCtIiG1UcLvT0n
 wN/RTLma7DNhmQFPiAxW0T4gc6zcUhjm035x2BmEfuiR6NXLeIE525lAvj6c3gaX3k+aPCN2ilB
 4T9t2+gCFT49cHRgTi2xhZZe6zW76t2E2ByOWMn4I7qjqAoEoDOG7wy5Q/VafGgJb6UTIN8qqhb
 wokoW2XHPYuxTEbypg38yvL25YQYnpKrlMfwXZUGfIE36Kf9OCyIRXh7x0BRzELIpbpE+K27s3w
 UcwhVgPV12I7IYrwV97uF5UObbZxHTvhtRzIYW607f6eE6YUkYgw0HPjbLvVXiMG5bStnZpwUq4
 bMT57P2ErRB2ZdC+Dt/5OMaaWT0JN1zQH7WEbRmCy29iNZc4HkXfW/i2Yqlr0By76IEzhCbWpB3
 DgR6/d3oT1YhXU2jeMoL1fB/4Z36NdkG2SuFR0=
X-Received: by 2002:a05:6820:2216:b0:65f:6601:b36a with SMTP id
 006d021491bc7-661179ca8f5mr1649952eaf.57.1768586164631; 
 Fri, 16 Jan 2026 09:56:04 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6611890c9aesm1422241eaf.4.2026.01.16.09.56.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 09:56:04 -0800 (PST)
Date: Fri, 16 Jan 2026 11:56:02 -0600
From: Tom Rini <trini@konsulko.com>
To: E Shattow <e@freeshell.de>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH] doc/develop/process.rst: Expand on the Custodian workflow
Message-ID: <20260116175602.GN3416603@bill-the-cat>
References: <20260109172905.1446923-1-trini@konsulko.com>
 <35fe875d-0bcc-452b-bb66-a2158b96629e@cherry.de>
 <20260109183203.GH3416603@bill-the-cat>
 <37d1dc68-9774-44a5-9cf0-0876975d9801@freeshell.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HhR63Vd5GdNg2RFk"
Content-Disposition: inline
In-Reply-To: <37d1dc68-9774-44a5-9cf0-0876975d9801@freeshell.de>
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


--HhR63Vd5GdNg2RFk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 09, 2026 at 05:07:05PM -0800, E Shattow wrote:
> Hi, and thank you Tom, here follows my thoughts on this to consider.
>=20
> On 1/9/26 10:32, Tom Rini wrote:
> > On Fri, Jan 09, 2026 at 07:08:40PM +0100, Quentin Schulz wrote:
> >> Hi Tom,
> >>
> >> On 1/9/26 6:29 PM, Tom Rini wrote:
> >>> As seen with a recent pull request, there have been implicit assumpti=
ons
> >>> about how much custodians can change patches before applying and merg=
ing
> >>> them. This has lead to an unfortunate situation with a contributor be=
ing
> >>> understandably upset about the changes.
> >>>
> >>> To avoid this in the future, document a few things:
> >>> - Non-trivial changes to make something apply need to have at least
> >>>    [name: what] in the commit message.
> >>> - Only trivial and obviously correct changes can be made by the
> >>>    custodian, and ideally this is done in a merge commit and not the
> >>>    patch itself.
> >>> - It is the responsibility of the custodian to gather relevant tags t=
hat
> >>>    have been provided by the community.
> >>>
> >>> Link: https://lore.kernel.org/u-boot/1faefbf2-e8b0-4c94-85f5-02535591=
5e0d@gmx.de/
> >>> Signed-off-by: Tom Rini <trini@konsulko.com>
> >>> ---
> >>> With this, Heinrich, per E Shattow's comment on IRC, can you please
> >>> revert the commit in question, then apply his patch as-is, and then y=
our
> >>> changes as a new patch in order to show correct history?
> >>>
> >>> And I realize at this point the subsection of this document is a bit
> >>> wordy. Maybe a follow-up of restructuring this part of the document
> >>> would be helpful? I'm not sure what would flow better however.
> >>>
> >>> Cc: E Shattow <e@freeshell.de>
> >>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >>> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> >>> ---
> >>>   doc/develop/process.rst | 9 ++++++++-
> >>>   1 file changed, 8 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/doc/develop/process.rst b/doc/develop/process.rst
> >>> index 4bfbf0eb9c63..84ab09132a0b 100644
> >>> --- a/doc/develop/process.rst
> >>> +++ b/doc/develop/process.rst
> >>> @@ -244,7 +244,12 @@ like this:
> >>>         custodian can also accept patches against older code.  It can=
 be
> >>>         difficult to find the correct balance between putting too muc=
h work on
> >>>         the custodian or too much work on an individual submitting a =
patch when
> >>> -      something does not apply cleanly.
> >>> +      something does not apply cleanly. If non-trivial changes need =
to be made
> >>> +      for it to apply the custodian is expected to annotate the comm=
it message
> >>> +      with ``[name: note about changes made]``. Furthermore, only tr=
ivial and
> >>
> >> We should provide an example, I think.
> >>
> >> commit 66be03b7ee19444b23aae3990a434a7470fc1641
> >> Author: J=E9r=E9mie Dautheribes <jeremie.dautheribes@bootlin.com>
> >> Date:   Fri Nov 28 12:03:04 2025 +0100
> >>
> >>     binman: blob_dtb: improve error message when SPL is not found
> >>
> >>     When using binman with the '-a spl-dtb=3Dy' flag, if the SPL blob =
is not
> >>     found, binman throws a cryptic error message:
> >>     binman: 'NoneType' object has no attribute 'startswith'
> >>
> >>     Let's improve the error message to explicitly state which SPL blob=
 is
> >>     missing.
> >>     This is particularly useful when binman is used as a standalone to=
ol
> >>     outside the U-Boot source tree.
> >>
> >>     Signed-off-by: J=E9r=E9mie Dautheribes <jeremie.dautheribes@bootli=
n.com>
> >>     [trini: Add '# pragma: no cover' because coverage doesn't seem to =
like
> >>     the documentation about this error]
> >>     Signed-off-by: Tom Rini <trini@konsulko.com>
> >>
> >> is a good one I think.
> >>
> >> You also added your SoB which isn't mentioned as a requirement here. I
> >> believe it must, because whatever you added/changed, you must comply w=
ith
> >> DCO to do it.
> >>
> >> I'm tempted to say we maybe should add a link to the original (unmerge=
d)
> >> commit so that people can actually do the diff themselves if they want=
 to?
> >>
> >> For the above example, have
> >>
> >> Link: https://lore.kernel.org/u-boot/20251128110304.63138-1-jeremie.da=
utheribes@bootlin.com/
> >>
> >> Maybe? Not sure how much friction we want to put on custodians. There's
> >> probably already a lot to do :)
> >>
> >> I would really like also that custodians *tell* people that they have =
merged
> >> the commits with changes. https://docs.u-boot.org/en/latest/develop/pr=
ocess.html#work-flow-of-a-custodian
> >> says it's only "ideally" they do for merged patches, but I really thin=
k we
> >> should tell people when changes are made to their patches.
> >>
> >>> +      obviously correct changes can be made, no other changes should=
 be made to
> >>> +      the patch itself. Ideally all of these changes will be in a me=
rge commit,
> >>> +      and not the commit itself, but that is not always possible.
> >>
> >> I have never been a maintainer in public spaces, and in private spaces=
 I
> >> enforce a strict rebase policy so I don't have merge commits ever. I
> >> wouldn't know what this means (but maybe custodians do, and that's the=
 most
> >> important as this isn't something contributors need to know?). How are=
 we
> >> supposed to do that? Note also that not everybody know that git log -c=
 (or
> >> --cc? I use -c but it seems to be showing the diff of the whole merge =
and
> >> not necessarily the conflicts?) needs to be used to see the content of=
 a git
> >> merge commit (it won't show with git log -p).
> >>
> >> Can we provide an example here of a good merge commit that highlights =
what
> >> is expected from custodians?
> >>
> >> I cannot really comment on whether this will help custodians do the ri=
ght
> >> thing as I am no custodian.
> >>
> >> We need to set the expectations for contributors as well.
> >>
> >> """
> >> Trivial fixes may be applied by custodians when merging your patches,
> >> sometimes without public notice. The operated changes are explicitly l=
isted
> >> at the end of the commit log or in a merge commit by the custodian.
> >> """
> >>
> >> or something like that? I'm wondering where we should put this though.=
 https://docs.u-boot.org/en/latest/develop/process.html#review-process-git-=
tags
> >> or https://docs.u-boot.org/en/latest/develop/sending_patches.html? I t=
hink
> >> this kind of change should be in the same commit (or one that follows =
after,
> >> but is done now).
> >>
> >> We can have some words about proper etiquette too? Like avoiding big s=
eries,
> >> waiting a bit between versions, not silently ignoring previous reviews=
 for
> >> newer versions (you can disagree but you need to speak your mind publi=
cly
> >> and "resolve the conflict" before sending a newer version (or at the v=
ery
> >> least say why something wasn't done in the cover-letter or under the -=
--
> >> section in a patch), waiting at least a week (more?) to send a ping on=
 yet
> >> unreviewed patches, ... That's what's coming to mind right now, there's
> >> probably more to add? This is a separate topic and I don't want this t=
o be a
> >> blocker for this here.
> >=20
> > That's a lot of feedback, thank you. I think this means for v2, I need
> > to:
> > - Move most of the existing wording to another section, and reference up
> >   to it.
> > - Note that some things we have done before, really shouldn't be (in yo=
ur
> >   good example, maybe I should have pushed back on the contributor to
> >   try and figure out how to convince Python it *had* coverage and not
> >   just pragma past it, to not have the contribution sitting out even
> >   logner).
> > - Incorporate much of the above and try and remove other assumptions I
> >   did make / added in my wording above.
> >=20
>=20
> Expectation-setting is distinct from telling someone how to do some
> task. You may explain clearly each step of a process with provided
> examples and yet there will be mistakes even when following a guide that
> details exactly how to avoid mistakes.
>=20
> Thought experiment: Hypothetical patch handler with commit rights is
> compromised by nation state or employer to insert intentional errors in
> code; or for a modest monthly cash retainer the side-hustle is to be
> on-call to insert changes (or delay the process of accepting specific
> changes) and to conceal this ulterior motivation. Maybe it is the
> project leader themself or personal friend saying "Trust me, we can
> commit this and just make a change quietly, I assure you personally that
> it is not needed disclose alterations in public".
>=20
> Do we want to encourage that? It is not illegal... or maybe not even
> technically against any Code of Conduct. In-fact your employment may
> require it or it may be your patriotic duty is to do so, and you would
> ignore any written rule and specific procedure outlined in documentation
> that we are discussing now...
>=20
> [End of thought experiment]
>=20
> For my part in the (real) incident it is a community trust issue and as
> already stated is a concern of respecting people's time. Misrepresenting
> material changes to any patch in-flight is a fantastic waste of time for
> anyone now and in the future looking at the history of changes. This is
> also just as much of a problem if say, there's some bad tooling
> involved, and quiet changes are being made without consent or
> disclosure; even without knowledge of the handler with commit access.
>=20
> I agree that the norms about notifying when changes are committed are a
> bit lacking however I consider this a tooling issue. If your role is to
> send (x) additional e-mail confirmations manually when handling patch
> submissions then I'd argue that is not reasonable to expect a person to
> do so reliably. By far for my part the most alarming fact is that unless
> I (as the patch author) personally check that the work was applied
> properly it is an unknown. Well, what else might be silently manipulated
> about the code base and misrepresented as if someone else had knowingly
> done so?
>=20
> None of this is new for open source development projects or
> vulnerability disclosure frameworks, but it is quite interesting that no
> one is pointing to earlier malicious instances of this in the U-Boot
> project. I have trusted that patches are applied as reviewed in public
> discussion, and apparently we just assume that is usually true (until now=
?).
>=20
> We should add some kind of reporting to say if code entering the source
> tree is or is not what was reviewed as it landed on patchwork; and this
> should be done in a way that answers the process questions consistently:
>=20
> "What license requirements are suspected to be in conflict, that might
> pertain to required legal handling?"
>=20
> "What national/professional/nepotistic conflicts of interest have been
> identified, that might pertain to required Code of Conduct measures?"
>=20
> "What tooling changes are identified to improve the disclosure cycle?"
>=20
> "What additional requests or delays in a resolution are identified
> beyond a what is able to be promptly resolved by a mulligan (revert,
> re-apply) within one cycle of cooling time or release schedule
> requirements for a patch series?"
>=20
> Separately from the initial handling of patches this effort should be
> expanded that questions asked (such as examples I have given above) when
> something does not go as expected, are common questions asked by all
> involved.
>=20
> Why when I explicitly say "revert my patch 4c105d2ae7b0 and re-apply
> properly" this was not done the same-day, or even within one week now
> that we're still talking about it and other quiet alterations have been
> identified? That is irritating to know we don't fix mistakes as a
> project. We should all be asking the same process questions.

I appreciate the feedback here. At the high level, there's a few things
we as a project need to do. One part is that yes, we do need a code of
conduct, and that has been on the TODO list for a while, and something I
am hopeful SFC can help us with as well.

Another part that yes, it's on me that the commit wasn't reverted
earlier. I apologize for that. I was hoping to get both clarification on
what exactly went wrong, and then for Heinrich to have time to revert it
himself (as he made the first mistake I thought that would be an
appropriate part of the response). But you are correct that it should
have been reverted much quicker than it was.

When it comes to tooling, partly I need to encourage more custodians to
make use of "b4" as it does automate the "this is applied" part of the
problem, and the other part is that I know people are largely unaware
that patchwork can be made to manually link a patch to a commit hash.
This is something I run a script for manually and can be seen at:
https://patchwork.ozlabs.org/project/uboot/patch/20251126190626.3799644-1-t=
rini@konsulko.com/
and does only work when the patch in tree and patch in patchwork match
(patchwork has a tool to hash a patch and find it in patchwork).

That functionality could be used as the start of some other tooling to
see what changes in tree don't 100% match changes in patchwork. But
there will be non-matches because something as trivial as "git am -3"
resolving some merge conflict will mean the patch hash isn't what's in
patchwork, but that's also fine.

--=20
Tom

--HhR63Vd5GdNg2RFk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWp7rgAKCRAr4qD1Cr/k
ClesAQCMbnf8TcatXi58f2iQGMVKk4J3YTouE0T1aw9IVMY7cgD/Sd/askS+QLRI
dTRWryGk6auYh4owMVKxUM9Vq28UhQI=
=fWXk
-----END PGP SIGNATURE-----

--HhR63Vd5GdNg2RFk--
