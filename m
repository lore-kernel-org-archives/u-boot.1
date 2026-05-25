Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D618FCD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 14:40:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 694E184862;
	Mon, 25 May 2026 16:39:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XzFYFrpV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDE7C84873; Mon, 25 May 2026 16:39:57 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7528584841
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 16:39:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7e61d8d9a21so962412a34.0
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 07:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779719994; x=1780324794; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=C20d4Jcs7D7SIDSSmqHf2JFUFNIZGeMX4JkVZndvqe0=;
 b=XzFYFrpViz94XxNvNnCaR9Pq8pUm2Yd1Z2cRhMJ8rbpkcSct8sI1G/Om9+vP/O+F2a
 s/siK7z60fCpNQD0gAhqz4gIy9hqpaxeyVTN7EClqDGAJJFZBLr0hcOQ6rF0kRVxp8Lj
 sNmJ7c2Xo6stUgYOzqSTRkYZQBbTyYdyQrJqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779719994; x=1780324794;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C20d4Jcs7D7SIDSSmqHf2JFUFNIZGeMX4JkVZndvqe0=;
 b=osYKW7ke3/STTvVmhqL8pcjkxuRibc9I+6PQxqoEszAHh2mzGf24GsrdL2sQQGHuRJ
 IJYGZTqZKnFKxPdQqo08rvqZ0+v4WYlGfG27mYqhLd5dw8aRg+C3LMlGNxkoxYeEQZ3T
 prvrhWWVW5WtF1HWpQIw5MNTQ0yHk7VA/2emWDRS3rwK+i7gksd3pr8MPDA3rcWbVq4i
 Zr2l9JHQKHZkihZWOORSn7wvEe/pwBQBEMp7HPPXP5FFmyMhdWPBA56U0BfzmDEGfDFw
 rM04lEwYXjeDAyOa6AWJCL9WJoZWN5yQ44aEQpvBj5gbgAokC2quwpAzA0dUd2JyeJIA
 CyNQ==
X-Gm-Message-State: AOJu0YwI7iIhpe7T8LhnEiuRMC+Natxh7cDLQO1ueNJ4D60mhOiJQv09
 IJc3YPj7d31xGLQLFCn7fU55fJ28FY4l1WMsTQBK1FcQNmhV22DqkiUuRR7HGIwVGfE=
X-Gm-Gg: Acq92OF5niaALgQX4VmqqNZqUHyn7UYYX04qAfeLcAxCTBr5ZQOool2+JqvMMmuyOLC
 uFvVioaIogQDjPbpnkJEvlCec7i6XWpB37uoCwAopMvnYNtYvuVYgOOg18Fo4mzUYrcZuL8zKCV
 vYarRtbLAqW+H3ZyKey//ZXx5bBoq/dzSqeHtYfu0q7SwnurkTlusxUaOsVmJ4TLt3aleiAtFus
 GPPEGisF3JwNVrwV6YTZV8j2WcNFLe1Xc5G9ipeX+Q9LexBrmdP8HnwxENhxXWKaOIq/V1XiqKn
 hJvyF+7wF7tt+ysozo56vps2t7W+12H1TLJbbou9O0UVYkUlLsApvGrVRGRLvDKIdidDih69jJL
 9Dj35uVJ+J+AYgsCsgmkGuQ0QQ862cV1km40ud17M8TvozoCYcA1H0h/U8wvwIDMf9S5jhN4yu9
 uNrCclicl+eP9Dzaizm8Vu/PPuEaPxRbM3R45qbdQSATG+6TxaIIJ9P+llsTPlpZ7sxPqxUN5QH
 7Mh7DAX9yrNxnVmidRVBQbK4xtstWrR3ismXqosGP0jvg==
X-Received: by 2002:a05:6830:b83:b0:7dc:c43b:9599 with SMTP id
 46e09a7af769-7e5fece9467mr8309278a34.7.1779719994133; 
 Mon, 25 May 2026 07:39:54 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e60664699csm7420462a34.22.2026.05.25.07.39.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 07:39:53 -0700 (PDT)
Date: Mon, 25 May 2026 08:39:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Josh Law <josh2@disroot.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>
Subject: Re: AI-assisted review
Message-ID: <20260525143951.GK1858239@bill-the-cat>
References: <CAFLszTjnL6rn_mTA+jhcrRLF0yEtN4FVwTeGGy9GeGbgdB9fYw@mail.gmail.com>
 <20260515220758.GM1858239@bill-the-cat>
 <46705f94-6cef-4016-ab05-7839514e9257@amd.com>
 <20260518155842.GR1858239@bill-the-cat>
 <CAFLszTj771TqyyvF_MGhNM4tfucQSs6sMOHzXVYDtNKBv_AZxg@mail.gmail.com>
 <73C33414-3094-4A9D-B823-72DDAFA6DEA0@disroot.org>
 <20260525142159.GI1858239@bill-the-cat>
 <1B7720FE-03CB-4CA5-A063-2B4A87B633C5@disroot.org>
 <20260525142718.GJ1858239@bill-the-cat>
 <7418B716-CA18-4745-A95A-D4C61AA903F7@disroot.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="e4yWN4hbCKRlEy6a"
Content-Disposition: inline
In-Reply-To: <7418B716-CA18-4745-A95A-D4C61AA903F7@disroot.org>
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


--e4yWN4hbCKRlEy6a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 03:29:50PM +0100, Josh Law wrote:
> On May 25, 2026 3:27:18 PM GMT+01:00, Tom Rini <trini@konsulko.com> wrote:
> >On Mon, May 25, 2026 at 03:25:19PM +0100, Josh Law wrote:
> >> On May 25, 2026 3:21:59 PM GMT+01:00, Tom Rini <trini@konsulko.com>
> >wrote:
> >> >On Mon, May 25, 2026 at 03:11:49PM +0100, Josh Law wrote:
> >> >> On May 25, 2026 3:03:28 PM GMT+01:00, Simon Glass <sjg@chromium.org>
> >> >wrote:
> >> >> >Hi Tom,
> >> >> >
> >> >> >On Mon, 18 May 2026 at 09:58, Tom Rini <trini@konsulko.com> wrote:
> >> >> >>
> >> >> >> On Mon, May 18, 2026 at 10:55:40AM +0200, Michal Simek wrote:
> >> >> >> >
> >> >> >> >
> >> >> >> > On 5/16/26 00:07, Tom Rini wrote:
> >> >> >> > > On Fri, May 15, 2026 at 03:03:21PM -0600, Simon Glass wrote:
> >> >> >> > >
> >> >> >> > > > Hi,
> >> >> >> > > >
> >> >> >> > > > There was a query on the call this week about whether I am
> >> >doing
> >> >> >> > > > AI-assisted code review. As I said on the call: yes. Here =
is
> >a
> >> >> >brief
> >> >> >> > > > description of how it works.
> >> >> >> > > >
> >> >> >> > > > It is built into Patman (on the Concept tree) with a new
> >> >'patman
> >> >> >> > > > review' command. You give it the series name / number, or
> >> >perhaps
> >> >> >a
> >> >> >> > > > patch name/number and it applies the patches to a new
> >branch,
> >> >does
> >> >> >a
> >> >> >> > > > review then adds its comments to its database.
> >> >> >> > > >
> >> >> >> > > > A '-d' flag can be used to create draft emails in Gmail
> >(sorry,
> >> >it
> >> >> >> > > > doesn't support other email programs yet). You then check
> >and
> >> >> >update
> >> >> >> > > > the emails and send them (or delete them). I am not an
> >expert
> >> >in
> >> >> >> > > > handling the 'user voice' part of AI, but have made an
> >attempt
> >> >to
> >> >> >make
> >> >> >> > > > it follow any provided configuration, as well as to scan
> >recent
> >> >> >> > > > reviews to actually create to create a voice.
> >> >> >> > > >
> >> >> >> > > > Obviously this is very rudimentary and could be expanded
> >> >> >considerably.
> >> >> >> > > > But the mere fact that it creates draft emails is a win for
> >me,
> >> >> >even
> >> >> >> > > > if I ultimately delete or rewrite most of the comments. I
> >can
> >> >> >imagine
> >> >> >> > > > 10 different ways to improve it to be more useful.
> >> >> >> > > >
> >> >> >> > > > I wrote a blog post about it if you want more details, or
> >you
> >> >can
> >> >> >ask me here.
> >> >> >> > > >
> >> >> >> > > > I am very interested in hearing how others are using these
> >new
> >> >> >tools
> >> >> >> > > > for code review.
> >> >> >> > >
> >> >> >> > > And the big thing for now is that since we as a project do n=
ot
> >> >yet
> >> >> >have
> >> >> >> > > an AI policy aside from "please don't". One of the points I
> >was
> >> >> >making
> >> >> >> > > on the call is that there's a difference in value between
> >"Human
> >> >> >> > > reviewed it, looks fine" and "Human spent some tokens, agent
> >> >didn't
> >> >> >see
> >> >> >> > > any problems".
> >> >> >> > >
> >> >> >> > > And I know several other people have been doing at least fir=
st
> >> >pass
> >> >> >> > > reviews with various agent-tools, it's just no one else has
> >been
> >> >> >posting
> >> >> >> > > reviews at your scale. And lessons learned from other projec=
ts
> >is
> >> >> >that
> >> >> >> > > the prompts are more important than whatever wrapper around
> >the
> >> >> >agent
> >> >> >> > > one is using.
> >> >> >> > >
> >> >> >> >
> >> >> >> > Don't think scale is the problem. Tool and integration is
> >another
> >> >> >topic.
> >> >> >>
> >> >> >> Simon posted approximately 100 reviews in about 24 hours. That
> >scale
> >> >is
> >> >> >> a problem, when most of them are just reviewed-by tags, from
> >someone
> >> >> >> that has a history of doing human reviews. Reputation is a factor
> >> >here
> >> >> >> I'm trying to figure out how best to articulate.
> >> >> >>
> >> >> >> I have thoughts on the rest that I want to get back to later,
> >thanks.
> >> >> >
> >> >> >I should point out that I tend to do reviews locally bit by bit and
> >> >> >then recheck and send out in batches later, particularly when I ne=
ed
> >> >> >to dig into the code and check things. I suspect a lot of the
> >> >> >'reviewed-by' ones are on revised series where I already reviewed
> >v1,
> >> >> >etc. For better or worse, patman tends to have something to say on
> >> >> >most patches (too picky for my style so I often delete comments).
> >> >> >
> >> >> >Re the AI policy, I suggest adding it in the project docs (even if
> >it
> >> >> >is very brief), rather than referencing a URL from another project.
> >> >> >
> >> >> >Regards,
> >> >> >Simon
> >> >> >
> >> >>=20
> >> >> Hey guys, sorry for the unexpected email but I have a question
> >> >>=20
> >> >> How would you know the reviewed by tag wasn't just made by a AI
> >> >>=20
> >> >> Would like: "Here is the tag from soandso AI"
> >> >>=20
> >> >> Or would it be like
> >> >>=20
> >> >> "AI reviewed this and it looks fine"
> >> >>=20
> >> >> Apologies for the unexpectedness of the email :)
> >> >
> >> >That's one of my concerns, yes. And I've been a bit shocked that othe=
r,
> >> >bigger, projects that do allow for AI review haven't come up with
> >> >something already.
> >> >
> >> >
> >>=20
> >> Personally Tom, projects like Linux take it slightly different
> >>=20
> >> maintainers usually say:
> >> "AI asked a question" then link the sashiko (AI review tool) link, with
> >> all of AIs comments
> >>=20
> >> The general gist, is if there is any comments, you either fix it, or y=
ou
> >> say why it isn't a bug
> >>=20
> >> I have mixed opinions on sashiko tbh.
> >>=20
> >> Also, maintainers tend to use their **OWN** review tools.
> >>=20
> >> But most projects do generally ban AI anything.
> >>=20
> >> Idk what we could do for u-boot when it comes to a sashiko like
> >solution.
> >>=20
> >> Maybe we could talk about it?
> >
> >Proposing a policy for the project about AI (and indeed not just linking
> >to other projects which have what I find to be helpful references) is on
> >the TODO list for the project leadership committee. We've just been
> >busily handling other issues for a while now, unfortunately.
> >
> >
>=20
> I could put something into suggestion:
>=20
>=20
> So, for patches: you could do assisted bys, and it depends on the
> maintainer, etc etc like Linux,
>=20
>=20
> And for reviews: that's actually hard to think about, because some
> maintainers love using AI review tools because it's useful, others
> don't particularly like tools like that, maybe a opt-in "reviewman"?
>=20
> But tbh that's up for discussion.

Thanks for offering, but it's going to be a large / contentious enough
issue that we haven't gotten to it yet, unfortunately.

--=20
Tom

--e4yWN4hbCKRlEy6a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahRfMwAKCRAr4qD1Cr/k
CuI9AP9Wdd/z7NeTRw1QiUwD7eSRGn2sTLO3s/pDVHdv7JdGewD3R7mQHWsJYL35
092L1cIxD2YYsaFUJLmt9Uvu7uQ7CA==
=1ErY
-----END PGP SIGNATURE-----

--e4yWN4hbCKRlEy6a--
