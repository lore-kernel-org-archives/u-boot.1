Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C53AC3ABC3
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 13:52:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 101A0822D7;
	Fri,  9 May 2025 15:52:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IKyWbPQG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E63C826AA; Fri,  9 May 2025 15:52:46 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BB4182162
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 15:52:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5fbc736f0c7so3213472a12.2
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 06:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746798763; x=1747403563; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PVfRbfkRVbSZYHQflenOxcPUzlePmSNAsItDxBwzzKM=;
 b=IKyWbPQGwkec/DAPirGMP0g1brYETcRnyNL77moRKXZUSHUts8Hc2ZucqsLjZxsOS3
 fewjFHPpIXMhEoy/IVRECISwPbU6AJ4I58lJoCov1LyImB01+Rwxl0G283Ufyj9k2ASP
 oxe8siGkAYeVLElJJJVX1cjYUa8Nou2jZT1j8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746798763; x=1747403563;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PVfRbfkRVbSZYHQflenOxcPUzlePmSNAsItDxBwzzKM=;
 b=LBDGyDilaRNvwRwmv0gawbkPs6OaKzX6EzzRsHSWcpgZKG3P6royMVKC5uGigitku/
 WahzOmIJJ/ER0CJkSImu14rbjNqukCrsXdobV7Zxic6KdVkgh6XVQ3iORUZqfZqZeWNr
 kXO0NPMdisSF13E+8IHbobO4QsCpihqbMXjgl1hfemtnIx39VjsoLXuU1EPq3oYLzv2M
 nOKLSUGrEysiiq9WggmJGF2OuqPyMZyCXNK+9NKmfRaQp9dMI3kHsstuuT4ymXd1gnd9
 WLN+t1+sVxl4tf/YtM2lWt0NOESUS6Zj7qdvz9rWNuPAjTNsjUrHwqRgHdPOjE4LzIpo
 sAEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEiEwiKGLwF5lPTShWO9kzUs0EOKTtj118EIbPejGEr52LiFFQfa6flcr8gJCBjGiAw2BhZvk=@lists.denx.de
X-Gm-Message-State: AOJu0Ywuv4DBFuAN4pYjjemhOyOe4UGODIFTIcrAzo7gzE37l+X1jAGY
 h0k74RIjG05QdmJ5GIKK7nUxS9Z+nV2228RVqeQV9SJblxNVuJnxmy0cDUHvDfbh4YKRVpNtkH9
 9vCy47oB9w0IrRCZLgvgQ/3xtw7xcoZfZwqTD
X-Gm-Gg: ASbGncsNGbyizDva1vFV+LV+KrP7rUvi+4mAS7+qk0foA4V0b/NB6ry1jQLxrWmXE8Y
 n9grIVkQt9myclUA0O/NqMSUwHmi28rBy4MF7DPeOaKErApPK21cWR87eShGktKzlpXQnQ135pj
 P44v9FYtPzT/9r/L4mxOX/xjQ=
X-Google-Smtp-Source: AGHT+IH7zYXYFn2Q0rYmP1u8+nM3jQ+QZeVyaGlM0mI5xe9vVCf6qwRkO5Mwbchv06pL4UldtUidBp2k6g/qSjyjm7Y=
X-Received: by 2002:a05:6402:210b:b0:5e6:17fb:d3c6 with SMTP id
 4fb4d7f45d1cf-5fca080a850mr2862630a12.25.1746798762347; Fri, 09 May 2025
 06:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250502150641.GW1261075@bill-the-cat>
 <18d5e7ee-a63d-4895-abbc-4df7737dccff@gmx.de>
 <20250502193020.GZ1261075@bill-the-cat>
 <45357aad-96d3-4c84-b6be-36cf4bb9dfff@gmx.de>
 <20250502200451.GA1261075@bill-the-cat>
 <CAFLszThgJQvA57g8LH0JH6Bq8wk=hnQUnchaUD0SB6v+0JTezg@mail.gmail.com>
 <20250505181846.GJ5430@bill-the-cat>
 <CAFLszThgq8afbSL8zHqP6nCoB+F5wU6M0MbAoYRsJh8iMi8orA@mail.gmail.com>
 <20250506162537.GX5430@bill-the-cat>
 <CAFLszThX4c9qO2cJiYqJ+9v2zfXsLtdkoMwE1-OCubD9Bbgcmw@mail.gmail.com>
 <20250506192759.GG5430@bill-the-cat>
In-Reply-To: <20250506192759.GG5430@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 9 May 2025 15:52:29 +0200
X-Gm-Features: AX0GCFtej_AUs07SLEvWmfUhZMJDd3XgPQkUA5U9rUnhx3i3LbcAj_bl5TgAvDA
Message-ID: <CAFLszTgWjr63nkYky16hsu+_OLenH+VpWQ9w5DJ3ywJcE=VurA@mail.gmail.com>
Subject: Re: [PATCH 0/3] RFC: test: Bring in the test hooks
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Tom,

On Tue, 6 May 2025 at 21:28, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, May 06, 2025 at 08:10:30PM +0200, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 6 May 2025 at 18:25, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, May 06, 2025 at 03:23:59PM +0200, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Mon, 5 May 2025 at 20:18, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sat, May 03, 2025 at 08:29:13AM -0600, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Fri, 2 May 2025 at 14:04, Tom Rini <trini@konsulko.com>
wrote:
> > > > > > >
> > > > > > > On Fri, May 02, 2025 at 09:42:56PM +0200, Heinrich Schuchardt
wrote:
> > > > > > > > On 5/2/25 21:30, Tom Rini wrote:
> > > > > > > > > On Fri, May 02, 2025 at 07:19:18PM +0200, Heinrich
Schuchardt wrote:
> > > > > > > > > > On 5/2/25 17:06, Tom Rini wrote:
> > > > > > > > > > > On Fri, May 02, 2025 at 08:49:12AM -0600, Simon Glass
wrote:
> > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > >
> > > > > > > > > > > > On Fri, 2 May 2025 at 08:34, Tom Rini <
trini@konsulko.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Thu, May 01, 2025 at 08:50:16PM -0600, Simon
Glass wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > > During a recent discussion with Heinrich we
discussed why the hooks are
> > > > > > > > > > > > > > kept in a separate repo.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > The amount of code is small, a tenth of the
size of the recently added
> > > > > > > > > > > > > > lwip, just by way of example. Testing is a
critical part of U-Boot and
> > > > > > > > > > > > > > one of the things that distinguishes it from
firmware projects that have
> > > > > > > > > > > > > > not kept up in this area. By having the tests
somewhere else, we are
> > > > > > > > > > > > > > signalling that it is unusual, or difficult, or
optional.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > The hooks mechanism also needs something of an
update to take account of
> > > > > > > > > > > > > > real boards in 2025. That will be much easier
to undertake if the code
> > > > > > > > > > > > > > that test/py talks to is in the same repo.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > This series brings the hook files in as
first-class citizens of U-Boot.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > If we do go ahead with this, I will send a
different series which has
> > > > > > > > > > > > > > separate commits (with correct author) in the
u-boot-test-hooks repo.
> > > > > > > > > > > > >
> > > > > > > > > > > > > I think bringing more projects directly in to the
repository is a bad
> > > > > > > > > > > > > idea. Your example of lwip isn't applicable
because it's a read-only
> > > > > > > > > > > > > subtree that's maintained outside of the project
(same as the dts
> > > > > > > > > > > > > subtree). But sure, lets "Say Yes". That said, we
still need to:
> > > > > > > > > > > > > - Remove needless examples from the tree.
> > > > > > > > > > > > > - Not include personal labs directly in the tree.
> > > > > > > > > > > > >
> > > > > > > > > > > > > That last one is why I really think this is a bad
idea. The point of
> > > > > > > > > > > > > having the hooks standalone is so that any given
lab can easily add
> > > > > > > > > > > > > support for their lab and manage it, without
worrying about disclosing
> > > > > > > > > > > > > internal layout. There's going to be hard coded
default passwords there.
> > > > > > > > > >
> > > > > > > > > > Secrets MUST NEVER reside in git repos.
> > > > > > > > > >
> > > > > > > > > > I can't imagine that such irresponsible habits would be
practiced by any
> > > > > > > > > > accountable developer.
> > > > > > > > >
> > > > > > > > > I agree it shouldn't be done. And just this week was the
most recent
> > > > > > > > > time I've seen a company do that internally, because it's
internal and
> > > > > > > > > was just a temporary thing. We helped them stop needing
to do that, but
> > > > > > > > > assuming it never happens is a bad idea.
> > > > > > > > >
> > > > > > > > > > Please, have a look at
> > > > > > > > > >
> > > > > > > > > >
https://docs.github.com/en/actions/security-for-github-actions/security-guides/using-secrets-in-github-actions
> > > > > > > > > >
https://tsi-ccdoc.readthedocs.io/en/master/ResOps/2019/gitlab/07_pass-build-secrets.html
> > > > > > > > > >
> > > > > > > > > > to see how to do it properly.
> > > > > > > > > >
> > > > > > > > > > The same is true for a private lab:
> > > > > > > > > > Use environment variables that are coming from outside
the repository.
> > > > > > > > > >
> > > > > > > > > > > > > There's going to be repository secrets there.
That kind of information
> > > > > > > > > > > > > really should not be in a public repository.
Integrating the hooks with
> > > > > > > > > > > > > mainline will make lab management harder, not
easier. The point of the
> > > > > > > > > > > > > existing labs in u-boot-test-hooks is to provide
samples.
> > > > > > > > > > > > >
> > > > > > > > > > > > > I think this is all why no, we should not go down
this path.
> > > > > > > > > > > >
> > > > > > > > > > > > Is it worth discussing this, or is your mind made
up? I have some
> > > > > > > > > > > > thoughts on the last one.
> > > > > > > > > > >
> > > > > > > > > > > I think it's a terrible idea that I already said:
> > > > > > > > > > > > But sure, lets "Say Yes".
> > > > > > > > > > >
> > > > > > > > > > > But please do spend time explaining your thoughts and
perhaps others
> > > > > > > > > > > will also agree with you and I'll feel less bad
taking this in?
> > > > > >
> > > > > > Well firstly, we should bring in the whole git history so I
don't
> > > > > > believe these patches should be applied as is. I did push a
branch[1]
> > > > > > but can send the commands if it helps.
> > > > >
> > > > > I don't see how that's relevant here, but OK.
> > > > >
> > > > > > > > > > Currently when changing a test hook I have to go
through these steps:
> > > > > > > > > >
> > > > > > > > > > * fork u-boot-test-hooks
> > > > > > > > > > * push a commit to my fork
> > > > > > > > > > * update both .gitlab-ci.yaml and .azure-pipelines.yaml
> > > > > > > > > > * commit the change code.denx.de
> > > > > > > > > > * create a merge request for github.com/u-boot/u-boot
> > > > > > > > > >
> > > > > > > > > > If the test hooks were in the same repo as main U-Boot,
I could save two
> > > > > > > > > > steps.
> > > > > > > > >
> > > > > > > > > Yes, that's true, the steps for updating our CI are a
little bit longer.
> > > > > > > > > I would be happy to make u-boot-test-hooks more widely
writable (so it
> > > > > > > > > would instead be pushing to a branch for step 1+2). But
I'm also
> > > > > > > > > concerned with external labs (which is both the origin of
these scripts,
> > > > > > > > > and where they're also used).
> > > > > > > > >
> > > > > > > > > Today, I have both a "konsulko" branch of
u-boot-test-hooks, internally.
> > > > > > > > > That has subdirectories for both "sage" and "lootbox"
(the two lab
> > > > > > > > > hosts), and in turn py and bin subdirectories for each.
There's no value
> > > > > > > > > in publishing these changes as there's nothing unique
about the
> > > > > > > > > platforms there, which aren't already in the mainline
u-boot-test-hooks.
> > > > > > > > >
> > > > > > > > > How should I manage these changes moving forward?
> > > > > > > >
> > > > > > > > You could create two branches based on origin/master u-boot:
> > > > > > > >
> > > > > > > > One for maintaining your test lab specific u-boot-test
changes and one for
> > > > > > > > your private u-boot code changes.
> > > > > > > >
> > > > > > > > Check out the lab specific u-boot-test branch for steering
the tests of the
> > > > > > > > u-boot code branch.
> > > > > > >
> > > > > > > So now for a lab you need to maintain a branch of U-Boot
itself, and
> > > > > > > then to test you need to merge your lab support in? And then
if there's
> > > > > > > problems work back what git hash you tested on, if reporting
either
> > > > > > > problems, or as part of the "wouldn't it be nice to collect
results
> > > > > > > idea" work backwards from there? And bisecting problems then
becomes a
> > > > > > > real nightmare since each step requires a merge.
> > > > > >
> > > > > > If you have your own hook scripts, they don't have to be in the
U-Boot
> > > > > > tree. That is entirely up to you. In my case I would want them
in the
> > > > > > tree, but in your case you can put them somewhere else.  You
can even
> > > > >
> > > > > But we shouldn't have more "ellesmere" stuff in the tree. That's a
> > > > > problem. No ones lab should directly be in upstream. We should be
> > > > > documenting and providing examples for others to use. Perhaps that
> > > > > fundamental confusion is why you're suggesting this path?
> > > >
> > > > I don't see why ellesmere shouldn't be in there. It is a lab used
for
> > > > U-Boot and therefore part of the project, as I see it. If we end up
> > > > with lots of labs from people then we can worry about that problem
> > > > then. Today, we have the opposite problem: not enough labs.
> > >
> > > You're also unaware of the number of labs we have because today
there's
> > > no need for them to post anything. And no, your lab specific
> > > configuration is not appropriate or useful in the general project.
This
> > > is another example of you having a problem seeing the difference
between
> > > "this is good for me" and "this is good for the project". Reference
> > > material should be associated with the project in one way or another,
> > > not your specific lab.
> >
> > That's not quite it. I don't mind seeing other people's labs and in
> > fact it would help a lot. You ended up sending me an email with lots
> > of stuff after I had floundered around for hours trying to
> > reverse-engineer a test. If it had been in-tree I would have solved it
> > in 5 minutes.
>
> Yes, we need better documentation. This has been known for some time.
> It's somewhere on my TODO list to follow up on the RFC I sent before.
>
> > > > > > put them inside the U-Boot directory but without adding them to
git,
> > > > > > if that helps. But we set up the 'PATH' variable to where
things are.
> > > > > > If we need to change things to make this easier for people, we
can.
> > > > > > I'm really not seeing any nightmares here at all.
> > > > >
> > > > > I don't see how PATH is relevant here either. That won't pick up
any of
> > > > > the configuration files. Might just be able to get away with two
> > > > > directories in PYTHONPATH instead of one.
> > > >
> > > > PATH is enough to run a hook script. Yes you need PYTHONPATH as well
> > > > if you have stuff in those files. Nothing changes.
> > > >
> > > > But Neil's comment was 'So this will definitely remove the ability
to
> > > > have test hooks out of the U-boot tree ?', not 'Do I still have to
set
> > > > my PYTHONPATH / PATH' to where my tree is ?'.
> > >
> > > Yes, I think you don't see how everyone else uses this then. If
everyone
> > > else has to set PATH to point to an out of tree copy of
> > > u-boot-test-hooks which is no longer maintained what has anyone
gained?
> >
> > Perhaps access to some useful examples. But they certainly have not
> > lost anything.
> >
> > >
> > > I'm open to suggestions on making the workflow Heinrich outlined for
> > > hooks easier, I'm happy to make the repository writable to other
> > > custodians, but moving them in-tree makes lots of problems and
seemingly
> > > solves few.
> >
> > At this point I believe the hooks should be in-tree and I have not
> > heard any real argument here yet. Neil had the wrong end of the stick
> > and your argument is that people who don't want their hooks in the
> > tree won't gained anything by being allowed to put them in the
> > tree...well, sure.
> >
> > If there is any compelling argument, I'd really like to hear it.
>
> I think the best compelling argument is that you continue to have the
> wrong end of the stick yourself as your labgrid implementation bears
> little resemblance to how the rest of the hooks are implemented and
> used, based on your comments about how nothing would be lost and there
> would be no problems.

There are good reasons for that and I have explained some of them at
length. I continue to feel that the current test hooks need a refresh too,
but it is too hard to take that on while the hooks are out-of-tree.

Since I'm not hearing any strong arguments against, I'm planning to pull
the hooks into my tree, at least. It seems best to preserve the commit
history, so I'll do that too. It is something like 170 commits.

Regards,
Simon
