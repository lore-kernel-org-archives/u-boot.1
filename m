Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E522CD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 14:27:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A089F84841;
	Mon, 25 May 2026 16:27:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="haRoybXX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5896D8484F; Mon, 25 May 2026 16:27:25 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06750846FA
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 16:27:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-4855562f32eso1055408b6e.2
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 07:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779719242; x=1780324042; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yDA3yNyFWgNLztIETG0N2KlKv3AYpq77YH3svm2kJKs=;
 b=haRoybXXCjrs0URfnKTh8lHSWnAUGeXRKpD60oAQG1DHfR4zq76iQfms2kYsdDFIcf
 gjt95fljvXTHlSpaC1zRJZ6reW+yGC5fdEszmWKoiZnIn7fT8pkeUrFjRUaEAq3QSAM6
 JBDnm0OlQ9eNGdAtuJReAhfl9YDGTs6rBsdOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779719242; x=1780324042;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yDA3yNyFWgNLztIETG0N2KlKv3AYpq77YH3svm2kJKs=;
 b=D8pDkDgy3rmW8MOdHArldOjVj3b3COLZL6kAIpW3ve6sBj4egqUqSa758JXllRsPV1
 xguNNSpKMvd3Wkrk45XExFXhpZC5OjsztBnmQ0eWBQYQsukL/TkEXIoVS5abts/3XWk9
 CGdu1tp6EHJAbiMgETAv4mFTdSulB6arhueRMB8PMMeQX+llCxMubm62WlqJA5hU5xya
 ZrIdRCly0StHm6ijMJWG8xKBl1Uhc22d6Z3bavr+U31L5zxpRRU39+X3MRz7eQzNRxK0
 3xdo1X20jh1Oc/agJCdpTiGfX87B1gXzpkrH1rXYclyL9v6D4Yp4R9aPBPclWHoay0+K
 uCrg==
X-Gm-Message-State: AOJu0Yw3v85h1N2iimYgw4eORpZlxRmC94ipYrC0zooICUrPqda67ZXk
 fO/WuKVC7FTCn/66lvoEc8OE5hf+fYmt/0ED6zaCpZKh/wly8Oy0gfk8sUSoAgwbRFI=
X-Gm-Gg: Acq92OHwufNWn9MazeTSR25KQu7zxcbqoX0OwExszY1Rb8HbmPeiLEQgYTHzqQYYAah
 NPGN7/ZkZVk+xO4LFS8GQ6m1OsC2DnCjt2ohx5KUWWcJtwNKRMPKVWbBd+8ewrmiuCjY1sH4Vg5
 cL50tOT9vVIBCYF0H4xh03+lR6AD185MgRJ1oA85C2Zt+pIpO90k+AAUYwcKc2m+tMx39/HEHPJ
 QiV8AQuEdqVJPuIOIUE1vYlmmx7jaOesxEW2G9yBdv47R7STrz1MRCWoT6z/Nk3ptKnmATZeoS3
 VBVHmX5yOo/SeGvzdE2rrNX6DG31AacPRTOIBz8ATxp+OkIIoCdtd0sw61gQ5UQLfp5XzXv9Yzk
 vQlMBkNYT3gSgHx0iA0YtNd+XSZL1quGlGCGsGgIWRmC+MZrRA/mhdRUvLyk2QZRlASOxBWJmbq
 9IelaNNCph71LyCaJ3iuJRaDm1uLOlzGzGBCzjxyrFX00AOWqJ14sL9C2lNqrUbr+rEk5fmsT8F
 wBWjD0jdDiej4yU3SooxYboKK1TAIn2MWy7u3Sar1MVQw==
X-Received: by 2002:a05:6808:5387:b0:485:29ad:d1a9 with SMTP id
 5614622812f47-4854a3fc871mr8061928b6e.37.1779719241617; 
 Mon, 25 May 2026 07:27:21 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4855476cbccsm4788370b6e.18.2026.05.25.07.27.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 07:27:20 -0700 (PDT)
Date: Mon, 25 May 2026 08:27:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Josh Law <josh2@disroot.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>
Subject: Re: AI-assisted review
Message-ID: <20260525142718.GJ1858239@bill-the-cat>
References: <CAFLszTjnL6rn_mTA+jhcrRLF0yEtN4FVwTeGGy9GeGbgdB9fYw@mail.gmail.com>
 <20260515220758.GM1858239@bill-the-cat>
 <46705f94-6cef-4016-ab05-7839514e9257@amd.com>
 <20260518155842.GR1858239@bill-the-cat>
 <CAFLszTj771TqyyvF_MGhNM4tfucQSs6sMOHzXVYDtNKBv_AZxg@mail.gmail.com>
 <73C33414-3094-4A9D-B823-72DDAFA6DEA0@disroot.org>
 <20260525142159.GI1858239@bill-the-cat>
 <1B7720FE-03CB-4CA5-A063-2B4A87B633C5@disroot.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1mnsC3dSn+QBymSb"
Content-Disposition: inline
In-Reply-To: <1B7720FE-03CB-4CA5-A063-2B4A87B633C5@disroot.org>
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


--1mnsC3dSn+QBymSb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 03:25:19PM +0100, Josh Law wrote:
> On May 25, 2026 3:21:59 PM GMT+01:00, Tom Rini <trini@konsulko.com> wrote:
> >On Mon, May 25, 2026 at 03:11:49PM +0100, Josh Law wrote:
> >> On May 25, 2026 3:03:28 PM GMT+01:00, Simon Glass <sjg@chromium.org>
> >wrote:
> >> >Hi Tom,
> >> >
> >> >On Mon, 18 May 2026 at 09:58, Tom Rini <trini@konsulko.com> wrote:
> >> >>
> >> >> On Mon, May 18, 2026 at 10:55:40AM +0200, Michal Simek wrote:
> >> >> >
> >> >> >
> >> >> > On 5/16/26 00:07, Tom Rini wrote:
> >> >> > > On Fri, May 15, 2026 at 03:03:21PM -0600, Simon Glass wrote:
> >> >> > >
> >> >> > > > Hi,
> >> >> > > >
> >> >> > > > There was a query on the call this week about whether I am
> >doing
> >> >> > > > AI-assisted code review. As I said on the call: yes. Here is a
> >> >brief
> >> >> > > > description of how it works.
> >> >> > > >
> >> >> > > > It is built into Patman (on the Concept tree) with a new
> >'patman
> >> >> > > > review' command. You give it the series name / number, or
> >perhaps
> >> >a
> >> >> > > > patch name/number and it applies the patches to a new branch,
> >does
> >> >a
> >> >> > > > review then adds its comments to its database.
> >> >> > > >
> >> >> > > > A '-d' flag can be used to create draft emails in Gmail (sorr=
y,
> >it
> >> >> > > > doesn't support other email programs yet). You then check and
> >> >update
> >> >> > > > the emails and send them (or delete them). I am not an expert
> >in
> >> >> > > > handling the 'user voice' part of AI, but have made an attempt
> >to
> >> >make
> >> >> > > > it follow any provided configuration, as well as to scan rece=
nt
> >> >> > > > reviews to actually create to create a voice.
> >> >> > > >
> >> >> > > > Obviously this is very rudimentary and could be expanded
> >> >considerably.
> >> >> > > > But the mere fact that it creates draft emails is a win for m=
e,
> >> >even
> >> >> > > > if I ultimately delete or rewrite most of the comments. I can
> >> >imagine
> >> >> > > > 10 different ways to improve it to be more useful.
> >> >> > > >
> >> >> > > > I wrote a blog post about it if you want more details, or you
> >can
> >> >ask me here.
> >> >> > > >
> >> >> > > > I am very interested in hearing how others are using these new
> >> >tools
> >> >> > > > for code review.
> >> >> > >
> >> >> > > And the big thing for now is that since we as a project do not
> >yet
> >> >have
> >> >> > > an AI policy aside from "please don't". One of the points I was
> >> >making
> >> >> > > on the call is that there's a difference in value between "Human
> >> >> > > reviewed it, looks fine" and "Human spent some tokens, agent
> >didn't
> >> >see
> >> >> > > any problems".
> >> >> > >
> >> >> > > And I know several other people have been doing at least first
> >pass
> >> >> > > reviews with various agent-tools, it's just no one else has been
> >> >posting
> >> >> > > reviews at your scale. And lessons learned from other projects =
is
> >> >that
> >> >> > > the prompts are more important than whatever wrapper around the
> >> >agent
> >> >> > > one is using.
> >> >> > >
> >> >> >
> >> >> > Don't think scale is the problem. Tool and integration is another
> >> >topic.
> >> >>
> >> >> Simon posted approximately 100 reviews in about 24 hours. That scale
> >is
> >> >> a problem, when most of them are just reviewed-by tags, from someone
> >> >> that has a history of doing human reviews. Reputation is a factor
> >here
> >> >> I'm trying to figure out how best to articulate.
> >> >>
> >> >> I have thoughts on the rest that I want to get back to later, thank=
s.
> >> >
> >> >I should point out that I tend to do reviews locally bit by bit and
> >> >then recheck and send out in batches later, particularly when I need
> >> >to dig into the code and check things. I suspect a lot of the
> >> >'reviewed-by' ones are on revised series where I already reviewed v1,
> >> >etc. For better or worse, patman tends to have something to say on
> >> >most patches (too picky for my style so I often delete comments).
> >> >
> >> >Re the AI policy, I suggest adding it in the project docs (even if it
> >> >is very brief), rather than referencing a URL from another project.
> >> >
> >> >Regards,
> >> >Simon
> >> >
> >>=20
> >> Hey guys, sorry for the unexpected email but I have a question
> >>=20
> >> How would you know the reviewed by tag wasn't just made by a AI
> >>=20
> >> Would like: "Here is the tag from soandso AI"
> >>=20
> >> Or would it be like
> >>=20
> >> "AI reviewed this and it looks fine"
> >>=20
> >> Apologies for the unexpectedness of the email :)
> >
> >That's one of my concerns, yes. And I've been a bit shocked that other,
> >bigger, projects that do allow for AI review haven't come up with
> >something already.
> >
> >
>=20
> Personally Tom, projects like Linux take it slightly different
>=20
> maintainers usually say:
> "AI asked a question" then link the sashiko (AI review tool) link, with
> all of AIs comments
>=20
> The general gist, is if there is any comments, you either fix it, or you
> say why it isn't a bug
>=20
> I have mixed opinions on sashiko tbh.
>=20
> Also, maintainers tend to use their **OWN** review tools.
>=20
> But most projects do generally ban AI anything.
>=20
> Idk what we could do for u-boot when it comes to a sashiko like solution.
>=20
> Maybe we could talk about it?

Proposing a policy for the project about AI (and indeed not just linking
to other projects which have what I find to be helpful references) is on
the TODO list for the project leadership committee. We've just been
busily handling other issues for a while now, unfortunately.

--=20
Tom

--1mnsC3dSn+QBymSb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahRcRgAKCRAr4qD1Cr/k
CqaMAQCl/8ApJdPGyABXCcFaE58eTI6HN+MIkewoq3vZYW+KMQD/YGbHA2WWolOk
QtC7djI6WYRe0aNfRi8sws/f1gwNHwE=
=HJTm
-----END PGP SIGNATURE-----

--1mnsC3dSn+QBymSb--
