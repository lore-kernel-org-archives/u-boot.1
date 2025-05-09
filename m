Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C595AC3ABC3
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 14:41:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D81F82905;
	Fri,  9 May 2025 16:41:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="i9FnqCdA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E5E982935; Fri,  9 May 2025 16:41:57 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 397208283E
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 16:41:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2d5e5e21b92so1483173fac.0
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 07:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746801713; x=1747406513; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HAQQL89PpZiu7kcGNBoWPJooKJL6dz0MZASaOo+IaVg=;
 b=i9FnqCdAgrPjxmEeyILuv7meeYRDxCuxIaKnzngUhc5KeCSeD0nkv5xouEf4uUxBXd
 iAFuO6FUqjTn8sVD20AmyRmXaXdguN/cvWPfnEZhjbI/qmJ5hjcBUPbc+Gul0THVN9Hw
 lbmswzIVG6GuhokkH6Gngw6+aqGN5DuQTAMUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746801713; x=1747406513;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HAQQL89PpZiu7kcGNBoWPJooKJL6dz0MZASaOo+IaVg=;
 b=oe/nwYrtnKeSSavchBSqY+MnGWT/3SDulySsAih1KF0uR8E08NocdM7c0aOJZlFzNu
 glK6Z/q8qJrjSeRj80zn8ArwBSjM3b+6D1w7m5Lw9fZNk6fGcpQZpPOJMsJUbL28rcL4
 aMrYuE3Pl+Y3wo3oXzAOxYJVj9onLAgfiXbRo9S0/JRakiGlRVMNCX5KLwNsh3mVdloL
 foLK3Qp+JJu6Ox1Z3rY4pmfJ2PNWXsBJzK9aCIZ6ysRBxFs8VXX3GUVvXGlbM+ACcFPF
 +MRNF8WXPkkvGvNNB8C5L5O8xYvQ6Pg3urFlN8IwuW47XR62K4I7oIM8rAlJyBryQB+2
 xrGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDEDlykHLPWF4zwMeWZk74Fsr/OJDFwmTEvr+usoqy3U0rN7vUfPUuM49ot/v4YtgFDBNHrkk=@lists.denx.de
X-Gm-Message-State: AOJu0YwoJQbsXRBXzWbDNKPojXi3btQmyWsTs4kC5sWhma5SlDq1xkQC
 PBAnEIszb32BTqea+SfeaoB5kfbPGBbwWfP61rNr7hkhj37FM8Ae1YVKZHudtwIFTqnuwSfXPoo
 R
X-Gm-Gg: ASbGncsx52s0d7rIWP95sNevBuHq7lMb1srCkwzJ7z/upGQ6jPAhlCG2awjQZb785Wo
 J8TjFngZU8cdQ6TducVIfvlof2QSTcKsp06IcHbY11z9yAosrhmBHDqhxQaCpbaDBneIL/9X8UJ
 9TdrwoX9bKuTwaEpUJNBMHtiDOE7QxKRmTWh0iWDPuzE3gxz+hq0/128kORN/zMyWQYAYiBvbmf
 B7i1qGNcCK2I5mw658NSoH5R/uGEEHJaqpWtRmQ+tifTc6YiN3JzDfKpdUjxqoLNBLdzoco3Cns
 IsR93KM0WS2MscjD1OXjlb7xwggpI1Nq0O4bhBOptyAIIaQ7Bcsnwo6UwjZmrWfugNkxM9M8luO
 FdQ==
X-Google-Smtp-Source: AGHT+IEqZwVHhYQUBfp5PxWSOHhYpxOhn/qK5kZX4YjGmclUYShthsqi3IawYvix2V96sHqfrmZ63A==
X-Received: by 2002:a05:6870:891c:b0:2c2:541d:2cd6 with SMTP id
 586e51a60fabf-2dba4213e7emr2187251fac.6.1746801712647; 
 Fri, 09 May 2025 07:41:52 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-732265cd8e7sm548139a34.47.2025.05.09.07.41.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 07:41:51 -0700 (PDT)
Date: Fri, 9 May 2025 08:41:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 0/3] RFC: test: Bring in the test hooks
Message-ID: <20250509144150.GH603748@bill-the-cat>
References: <20250502193020.GZ1261075@bill-the-cat>
 <45357aad-96d3-4c84-b6be-36cf4bb9dfff@gmx.de>
 <20250502200451.GA1261075@bill-the-cat>
 <CAFLszThgJQvA57g8LH0JH6Bq8wk=hnQUnchaUD0SB6v+0JTezg@mail.gmail.com>
 <20250505181846.GJ5430@bill-the-cat>
 <CAFLszThgq8afbSL8zHqP6nCoB+F5wU6M0MbAoYRsJh8iMi8orA@mail.gmail.com>
 <20250506162537.GX5430@bill-the-cat>
 <CAFLszThX4c9qO2cJiYqJ+9v2zfXsLtdkoMwE1-OCubD9Bbgcmw@mail.gmail.com>
 <20250506192759.GG5430@bill-the-cat>
 <CAFLszTgWjr63nkYky16hsu+_OLenH+VpWQ9w5DJ3ywJcE=VurA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jZ8xyQ8mPBdh4GL9"
Content-Disposition: inline
In-Reply-To: <CAFLszTgWjr63nkYky16hsu+_OLenH+VpWQ9w5DJ3ywJcE=VurA@mail.gmail.com>
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


--jZ8xyQ8mPBdh4GL9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 09, 2025 at 03:52:29PM +0200, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 6 May 2025 at 21:28, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, May 06, 2025 at 08:10:30PM +0200, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 6 May 2025 at 18:25, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, May 06, 2025 at 03:23:59PM +0200, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Mon, 5 May 2025 at 20:18, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Sat, May 03, 2025 at 08:29:13AM -0600, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Fri, 2 May 2025 at 14:04, Tom Rini <trini@konsulko.com>
> wrote:
> > > > > > > >
> > > > > > > > On Fri, May 02, 2025 at 09:42:56PM +0200, Heinrich Schuchar=
dt
> wrote:
> > > > > > > > > On 5/2/25 21:30, Tom Rini wrote:
> > > > > > > > > > On Fri, May 02, 2025 at 07:19:18PM +0200, Heinrich
> Schuchardt wrote:
> > > > > > > > > > > On 5/2/25 17:06, Tom Rini wrote:
> > > > > > > > > > > > On Fri, May 02, 2025 at 08:49:12AM -0600, Simon Gla=
ss
> wrote:
> > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Fri, 2 May 2025 at 08:34, Tom Rini <
> trini@konsulko.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Thu, May 01, 2025 at 08:50:16PM -0600, Simon
> Glass wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > During a recent discussion with Heinrich we
> discussed why the hooks are
> > > > > > > > > > > > > > > kept in a separate repo.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > The amount of code is small, a tenth of the
> size of the recently added
> > > > > > > > > > > > > > > lwip, just by way of example. Testing is a
> critical part of U-Boot and
> > > > > > > > > > > > > > > one of the things that distinguishes it from
> firmware projects that have
> > > > > > > > > > > > > > > not kept up in this area. By having the tests
> somewhere else, we are
> > > > > > > > > > > > > > > signalling that it is unusual, or difficult, =
or
> optional.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > The hooks mechanism also needs something of an
> update to take account of
> > > > > > > > > > > > > > > real boards in 2025. That will be much easier
> to undertake if the code
> > > > > > > > > > > > > > > that test/py talks to is in the same repo.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > This series brings the hook files in as
> first-class citizens of U-Boot.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > If we do go ahead with this, I will send a
> different series which has
> > > > > > > > > > > > > > > separate commits (with correct author) in the
> u-boot-test-hooks repo.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I think bringing more projects directly in to t=
he
> repository is a bad
> > > > > > > > > > > > > > idea. Your example of lwip isn't applicable
> because it's a read-only
> > > > > > > > > > > > > > subtree that's maintained outside of the project
> (same as the dts
> > > > > > > > > > > > > > subtree). But sure, lets "Say Yes". That said, =
we
> still need to:
> > > > > > > > > > > > > > - Remove needless examples from the tree.
> > > > > > > > > > > > > > - Not include personal labs directly in the tre=
e.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > That last one is why I really think this is a b=
ad
> idea. The point of
> > > > > > > > > > > > > > having the hooks standalone is so that any given
> lab can easily add
> > > > > > > > > > > > > > support for their lab and manage it, without
> worrying about disclosing
> > > > > > > > > > > > > > internal layout. There's going to be hard coded
> default passwords there.
> > > > > > > > > > >
> > > > > > > > > > > Secrets MUST NEVER reside in git repos.
> > > > > > > > > > >
> > > > > > > > > > > I can't imagine that such irresponsible habits would =
be
> practiced by any
> > > > > > > > > > > accountable developer.
> > > > > > > > > >
> > > > > > > > > > I agree it shouldn't be done. And just this week was the
> most recent
> > > > > > > > > > time I've seen a company do that internally, because it=
's
> internal and
> > > > > > > > > > was just a temporary thing. We helped them stop needing
> to do that, but
> > > > > > > > > > assuming it never happens is a bad idea.
> > > > > > > > > >
> > > > > > > > > > > Please, have a look at
> > > > > > > > > > >
> > > > > > > > > > >
> https://docs.github.com/en/actions/security-for-github-actions/security-g=
uides/using-secrets-in-github-actions
> > > > > > > > > > >
> https://tsi-ccdoc.readthedocs.io/en/master/ResOps/2019/gitlab/07_pass-bui=
ld-secrets.html
> > > > > > > > > > >
> > > > > > > > > > > to see how to do it properly.
> > > > > > > > > > >
> > > > > > > > > > > The same is true for a private lab:
> > > > > > > > > > > Use environment variables that are coming from outside
> the repository.
> > > > > > > > > > >
> > > > > > > > > > > > > > There's going to be repository secrets there.
> That kind of information
> > > > > > > > > > > > > > really should not be in a public repository.
> Integrating the hooks with
> > > > > > > > > > > > > > mainline will make lab management harder, not
> easier. The point of the
> > > > > > > > > > > > > > existing labs in u-boot-test-hooks is to provide
> samples.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I think this is all why no, we should not go do=
wn
> this path.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Is it worth discussing this, or is your mind made
> up? I have some
> > > > > > > > > > > > > thoughts on the last one.
> > > > > > > > > > > >
> > > > > > > > > > > > I think it's a terrible idea that I already said:
> > > > > > > > > > > > > But sure, lets "Say Yes".
> > > > > > > > > > > >
> > > > > > > > > > > > But please do spend time explaining your thoughts a=
nd
> perhaps others
> > > > > > > > > > > > will also agree with you and I'll feel less bad
> taking this in?
> > > > > > >
> > > > > > > Well firstly, we should bring in the whole git history so I
> don't
> > > > > > > believe these patches should be applied as is. I did push a
> branch[1]
> > > > > > > but can send the commands if it helps.
> > > > > >
> > > > > > I don't see how that's relevant here, but OK.
> > > > > >
> > > > > > > > > > > Currently when changing a test hook I have to go
> through these steps:
> > > > > > > > > > >
> > > > > > > > > > > * fork u-boot-test-hooks
> > > > > > > > > > > * push a commit to my fork
> > > > > > > > > > > * update both .gitlab-ci.yaml and .azure-pipelines.ya=
ml
> > > > > > > > > > > * commit the change code.denx.de
> > > > > > > > > > > * create a merge request for github.com/u-boot/u-boot
> > > > > > > > > > >
> > > > > > > > > > > If the test hooks were in the same repo as main U-Boo=
t,
> I could save two
> > > > > > > > > > > steps.
> > > > > > > > > >
> > > > > > > > > > Yes, that's true, the steps for updating our CI are a
> little bit longer.
> > > > > > > > > > I would be happy to make u-boot-test-hooks more widely
> writable (so it
> > > > > > > > > > would instead be pushing to a branch for step 1+2). But
> I'm also
> > > > > > > > > > concerned with external labs (which is both the origin =
of
> these scripts,
> > > > > > > > > > and where they're also used).
> > > > > > > > > >
> > > > > > > > > > Today, I have both a "konsulko" branch of
> u-boot-test-hooks, internally.
> > > > > > > > > > That has subdirectories for both "sage" and "lootbox"
> (the two lab
> > > > > > > > > > hosts), and in turn py and bin subdirectories for each.
> There's no value
> > > > > > > > > > in publishing these changes as there's nothing unique
> about the
> > > > > > > > > > platforms there, which aren't already in the mainline
> u-boot-test-hooks.
> > > > > > > > > >
> > > > > > > > > > How should I manage these changes moving forward?
> > > > > > > > >
> > > > > > > > > You could create two branches based on origin/master u-bo=
ot:
> > > > > > > > >
> > > > > > > > > One for maintaining your test lab specific u-boot-test
> changes and one for
> > > > > > > > > your private u-boot code changes.
> > > > > > > > >
> > > > > > > > > Check out the lab specific u-boot-test branch for steering
> the tests of the
> > > > > > > > > u-boot code branch.
> > > > > > > >
> > > > > > > > So now for a lab you need to maintain a branch of U-Boot
> itself, and
> > > > > > > > then to test you need to merge your lab support in? And then
> if there's
> > > > > > > > problems work back what git hash you tested on, if reporting
> either
> > > > > > > > problems, or as part of the "wouldn't it be nice to collect
> results
> > > > > > > > idea" work backwards from there? And bisecting problems then
> becomes a
> > > > > > > > real nightmare since each step requires a merge.
> > > > > > >
> > > > > > > If you have your own hook scripts, they don't have to be in t=
he
> U-Boot
> > > > > > > tree. That is entirely up to you. In my case I would want them
> in the
> > > > > > > tree, but in your case you can put them somewhere else.  You
> can even
> > > > > >
> > > > > > But we shouldn't have more "ellesmere" stuff in the tree. That'=
s a
> > > > > > problem. No ones lab should directly be in upstream. We should =
be
> > > > > > documenting and providing examples for others to use. Perhaps t=
hat
> > > > > > fundamental confusion is why you're suggesting this path?
> > > > >
> > > > > I don't see why ellesmere shouldn't be in there. It is a lab used
> for
> > > > > U-Boot and therefore part of the project, as I see it. If we end =
up
> > > > > with lots of labs from people then we can worry about that problem
> > > > > then. Today, we have the opposite problem: not enough labs.
> > > >
> > > > You're also unaware of the number of labs we have because today
> there's
> > > > no need for them to post anything. And no, your lab specific
> > > > configuration is not appropriate or useful in the general project.
> This
> > > > is another example of you having a problem seeing the difference
> between
> > > > "this is good for me" and "this is good for the project". Reference
> > > > material should be associated with the project in one way or anothe=
r,
> > > > not your specific lab.
> > >
> > > That's not quite it. I don't mind seeing other people's labs and in
> > > fact it would help a lot. You ended up sending me an email with lots
> > > of stuff after I had floundered around for hours trying to
> > > reverse-engineer a test. If it had been in-tree I would have solved it
> > > in 5 minutes.
> >
> > Yes, we need better documentation. This has been known for some time.
> > It's somewhere on my TODO list to follow up on the RFC I sent before.
> >
> > > > > > > put them inside the U-Boot directory but without adding them =
to
> git,
> > > > > > > if that helps. But we set up the 'PATH' variable to where
> things are.
> > > > > > > If we need to change things to make this easier for people, we
> can.
> > > > > > > I'm really not seeing any nightmares here at all.
> > > > > >
> > > > > > I don't see how PATH is relevant here either. That won't pick up
> any of
> > > > > > the configuration files. Might just be able to get away with two
> > > > > > directories in PYTHONPATH instead of one.
> > > > >
> > > > > PATH is enough to run a hook script. Yes you need PYTHONPATH as w=
ell
> > > > > if you have stuff in those files. Nothing changes.
> > > > >
> > > > > But Neil's comment was 'So this will definitely remove the ability
> to
> > > > > have test hooks out of the U-boot tree ?', not 'Do I still have to
> set
> > > > > my PYTHONPATH / PATH' to where my tree is ?'.
> > > >
> > > > Yes, I think you don't see how everyone else uses this then. If
> everyone
> > > > else has to set PATH to point to an out of tree copy of
> > > > u-boot-test-hooks which is no longer maintained what has anyone
> gained?
> > >
> > > Perhaps access to some useful examples. But they certainly have not
> > > lost anything.
> > >
> > > >
> > > > I'm open to suggestions on making the workflow Heinrich outlined for
> > > > hooks easier, I'm happy to make the repository writable to other
> > > > custodians, but moving them in-tree makes lots of problems and
> seemingly
> > > > solves few.
> > >
> > > At this point I believe the hooks should be in-tree and I have not
> > > heard any real argument here yet. Neil had the wrong end of the stick
> > > and your argument is that people who don't want their hooks in the
> > > tree won't gained anything by being allowed to put them in the
> > > tree...well, sure.
> > >
> > > If there is any compelling argument, I'd really like to hear it.
> >
> > I think the best compelling argument is that you continue to have the
> > wrong end of the stick yourself as your labgrid implementation bears
> > little resemblance to how the rest of the hooks are implemented and
> > used, based on your comments about how nothing would be lost and there
> > would be no problems.
>=20
> There are good reasons for that and I have explained some of them at
> length. I continue to feel that the current test hooks need a refresh too,
> but it is too hard to take that on while the hooks are out-of-tree.
=20
> Since I'm not hearing any strong arguments against, I'm planning to pull
> the hooks into my tree, at least. It seems best to preserve the commit
> history, so I'll do that too. It is something like 170 commits.

How about you don't make your personal tree even more different from
mainline? I swear, I really think you should just leave. I am sick and
tired of this.

--=20
Tom

--jZ8xyQ8mPBdh4GL9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgeFC4ACgkQFHw5/5Y0
tyxZywwAiuW//9NEdu2HDSlftA4ErCSJIWZyIYC4v/DhRwy6dKc3y1xkdHRljNku
wVX+1nxwOJhD/M9GELGNY0EUJGGzBFiadLNcLqFSr9WcRtR6Q8tZc1XOyYwnyWb8
xlXTi9X1vEyfNvxLhBvD7uTwDHtddBZq5afco2KitjnOj4KGcsXaJXBeK6+UJi5S
mM+hqSHxZK4RLErtb5KBmqF5ArAc27XCsRLNm6dZAeqq84VYGQB5ZjOKpHdeWFKe
UxnnDfaM1XtDxLL0nH55W+umnM3BwQcVR5ZVe1gXKxDDihHGuekBEdka7TWHEhY7
yy5la0ngALgsWJKLlpdqIZxs3jrEnES4ncRElYL1mFBlZm4m42jjxIyugHZ4wWZh
S1QgKHyf576Riw5SvTz45q0AnIAv5zj1xQ5dl/8V0ec6Wd/s+1k/DSGYiuOVsg+x
OcLMw88DmqFPLZ7EFddL0Ok0vGQ5+8Zbehoa5Ak/j8+vJurWUI6SXfKDqFEcF9VU
LJckjURl
=CX7c
-----END PGP SIGNATURE-----

--jZ8xyQ8mPBdh4GL9--
