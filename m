Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE077CD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 14:22:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 255978469D;
	Mon, 25 May 2026 16:22:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="quXnuG2K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD61B8469D; Mon, 25 May 2026 16:22:05 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 987B48460E
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 16:22:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-69dc2c38f6dso201342eaf.2
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 07:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779718922; x=1780323722; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=n/h7AK6qYGlBkmE1yCpxKRX7PaE+ITpuNGSBopomhig=;
 b=quXnuG2KQ1mJxzzXCanyn9X2aImwFyAeVIOdTah54Y5ABwub07YWzeUsNoTn/qt4sg
 GLvdWqlImmJ9NfY+IlDtccu7u3B//q36dhGUHuL2soVBYi61yccAM+IWwof1pcl0qt0M
 vOYkPvPabazCxoCxTQgJj83AYTfULlxUSRFLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779718922; x=1780323722;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n/h7AK6qYGlBkmE1yCpxKRX7PaE+ITpuNGSBopomhig=;
 b=Psd2WdRtXsXlhVf9V7ckrmK+FBUp/XkcxE1kHN+Wtsmah8w+gCBTWw3LSZIzYdZH9S
 XrsXBfjzxP3XRxn/mUUAYKnOIxeQEDXS1qWv0EfKbp33wtbrxSrCxTEVW719ebeUX2Ta
 fdegXcPJp//tUw1wzPmNdcizDB5cnPHP2hYa7WI9eeN/+3ANvxfkBhuEOv0uBiVgGXvm
 6Hx4c5qLZ5y7ljV88dFPKiSOj93bRZgbUy2qFMTEwQeweSA7Qv42vKTRGAoqW61uMlhL
 bLGsWf2ctPujh5W760fBt0nsTU85SsdYZHJVinPdvJ2mvCNkTGu4uZ0Mn1r3HJBRiogs
 POIA==
X-Gm-Message-State: AOJu0Ywcr4vImswMYCrL1p7sxkIVKw8cSa6c2dWovDkcX1/p85N1Sob4
 u2YnAvcJS3jcFY+DClBiu/H+V3io0BSidXkwIHA+ejIbxUo/dYlqKbRgFGkhWawySss=
X-Gm-Gg: Acq92OHfao+F76BBsftkT89XmkYnt6RBvbUHUG3OPG2+x9o8oHjET/Gjbp6qG8hOhc2
 5M1vI19UENahu4piqCV73RzcnIKrGW2FoipxApmu5G/bNvwlLllBIKeXpIoACtpKvK5q3FSH/pd
 g1VYNqi1DKFzZcR9cSwZuAi/zWdx9VuyA32kSIJbgvakp6PWqQLjL1Kc0ibOiOy5WkxntYb9oJW
 m9CcAFCdmd+uoTorYx/4Lu/KhJ5k36iAVRvlmnZnkZGbJVgVVgyp0T5Y0q0a9JKktIfVIcRLKe5
 SiI2krwuX7ZOuKaMIghRA0GDQJEqpPfc0RNh42ZmtiYSRWJF0AjjLx32Pw+bnxzncHUwkwAmmNA
 hgwE0oVf6td1CJt9Us+pG/Ug56LxGOT06zuO1UmwCO9geCf5vCfGzAOKLqtRpG824rq2U8goEiT
 dRiD1kUv1pNHMhsH2p9QqzMVMEigq+T/OSsx2Ve1CW2ZI2WN5fc484DZhSRZ2kPPnTPlENNXlln
 caFKaJMDmXKqPvuGTaLDK5Bws9hYK+3/QtT/kNN2d9EWQ==
X-Received: by 2002:a05:6820:2210:b0:696:178e:695b with SMTP id
 006d021491bc7-69d7ecd5395mr7606733eaf.44.1779718922211; 
 Mon, 25 May 2026 07:22:02 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d8c3284c0sm4539331eaf.12.2026.05.25.07.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 07:22:01 -0700 (PDT)
Date: Mon, 25 May 2026 08:21:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Josh Law <josh2@disroot.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>
Subject: Re: AI-assisted review
Message-ID: <20260525142159.GI1858239@bill-the-cat>
References: <CAFLszTjnL6rn_mTA+jhcrRLF0yEtN4FVwTeGGy9GeGbgdB9fYw@mail.gmail.com>
 <20260515220758.GM1858239@bill-the-cat>
 <46705f94-6cef-4016-ab05-7839514e9257@amd.com>
 <20260518155842.GR1858239@bill-the-cat>
 <CAFLszTj771TqyyvF_MGhNM4tfucQSs6sMOHzXVYDtNKBv_AZxg@mail.gmail.com>
 <73C33414-3094-4A9D-B823-72DDAFA6DEA0@disroot.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0sOckEfpim1bodaE"
Content-Disposition: inline
In-Reply-To: <73C33414-3094-4A9D-B823-72DDAFA6DEA0@disroot.org>
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


--0sOckEfpim1bodaE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 03:11:49PM +0100, Josh Law wrote:
> On May 25, 2026 3:03:28 PM GMT+01:00, Simon Glass <sjg@chromium.org> wrot=
e:
> >Hi Tom,
> >
> >On Mon, 18 May 2026 at 09:58, Tom Rini <trini@konsulko.com> wrote:
> >>
> >> On Mon, May 18, 2026 at 10:55:40AM +0200, Michal Simek wrote:
> >> >
> >> >
> >> > On 5/16/26 00:07, Tom Rini wrote:
> >> > > On Fri, May 15, 2026 at 03:03:21PM -0600, Simon Glass wrote:
> >> > >
> >> > > > Hi,
> >> > > >
> >> > > > There was a query on the call this week about whether I am doing
> >> > > > AI-assisted code review. As I said on the call: yes. Here is a
> >brief
> >> > > > description of how it works.
> >> > > >
> >> > > > It is built into Patman (on the Concept tree) with a new 'patman
> >> > > > review' command. You give it the series name / number, or perhaps
> >a
> >> > > > patch name/number and it applies the patches to a new branch, do=
es
> >a
> >> > > > review then adds its comments to its database.
> >> > > >
> >> > > > A '-d' flag can be used to create draft emails in Gmail (sorry, =
it
> >> > > > doesn't support other email programs yet). You then check and
> >update
> >> > > > the emails and send them (or delete them). I am not an expert in
> >> > > > handling the 'user voice' part of AI, but have made an attempt to
> >make
> >> > > > it follow any provided configuration, as well as to scan recent
> >> > > > reviews to actually create to create a voice.
> >> > > >
> >> > > > Obviously this is very rudimentary and could be expanded
> >considerably.
> >> > > > But the mere fact that it creates draft emails is a win for me,
> >even
> >> > > > if I ultimately delete or rewrite most of the comments. I can
> >imagine
> >> > > > 10 different ways to improve it to be more useful.
> >> > > >
> >> > > > I wrote a blog post about it if you want more details, or you can
> >ask me here.
> >> > > >
> >> > > > I am very interested in hearing how others are using these new
> >tools
> >> > > > for code review.
> >> > >
> >> > > And the big thing for now is that since we as a project do not yet
> >have
> >> > > an AI policy aside from "please don't". One of the points I was
> >making
> >> > > on the call is that there's a difference in value between "Human
> >> > > reviewed it, looks fine" and "Human spent some tokens, agent didn't
> >see
> >> > > any problems".
> >> > >
> >> > > And I know several other people have been doing at least first pass
> >> > > reviews with various agent-tools, it's just no one else has been
> >posting
> >> > > reviews at your scale. And lessons learned from other projects is
> >that
> >> > > the prompts are more important than whatever wrapper around the
> >agent
> >> > > one is using.
> >> > >
> >> >
> >> > Don't think scale is the problem. Tool and integration is another
> >topic.
> >>
> >> Simon posted approximately 100 reviews in about 24 hours. That scale is
> >> a problem, when most of them are just reviewed-by tags, from someone
> >> that has a history of doing human reviews. Reputation is a factor here
> >> I'm trying to figure out how best to articulate.
> >>
> >> I have thoughts on the rest that I want to get back to later, thanks.
> >
> >I should point out that I tend to do reviews locally bit by bit and
> >then recheck and send out in batches later, particularly when I need
> >to dig into the code and check things. I suspect a lot of the
> >'reviewed-by' ones are on revised series where I already reviewed v1,
> >etc. For better or worse, patman tends to have something to say on
> >most patches (too picky for my style so I often delete comments).
> >
> >Re the AI policy, I suggest adding it in the project docs (even if it
> >is very brief), rather than referencing a URL from another project.
> >
> >Regards,
> >Simon
> >
>=20
> Hey guys, sorry for the unexpected email but I have a question
>=20
> How would you know the reviewed by tag wasn't just made by a AI
>=20
> Would like: "Here is the tag from soandso AI"
>=20
> Or would it be like
>=20
> "AI reviewed this and it looks fine"
>=20
> Apologies for the unexpectedness of the email :)

That's one of my concerns, yes. And I've been a bit shocked that other,
bigger, projects that do allow for AI review haven't come up with
something already.

--=20
Tom

--0sOckEfpim1bodaE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahRbBwAKCRAr4qD1Cr/k
Ci5QAQDWnf43IwA/K76vOqHYHtJPi+ghSCqr+4Z00LOsLJEKPAEArMEDkP2AKlt3
zR9o4CfOlk24YYEeK8HkCxq+5S9iVAU=
=Sqyc
-----END PGP SIGNATURE-----

--0sOckEfpim1bodaE--
