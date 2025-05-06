Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50264C3ABBF
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 13:24:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5E878219D;
	Tue,  6 May 2025 15:24:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e4RghYNo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C3E5820F6; Tue,  6 May 2025 15:24:17 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0710E82905
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 15:24:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5eb92df4fcbso10911557a12.0
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 06:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746537852; x=1747142652; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LGEMS2m4N0lVSozlUW4BxXtDYakHllV61QnreyNAgT4=;
 b=e4RghYNoNmSYOWGfMvWhyUPcSu7D+VL66B5JxK6uVtHXOAUJZOC8WFARtj9nxndUEk
 yAK3i12IizR7oDBX8zt2sZ2Ux5p47aYXDD29u+xyWS3iXfLw27EuGWLYdtBZz9rJHtkv
 mWSKU3odvOkybFzAHd2tdNb1qskxanOoVUPK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746537852; x=1747142652;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LGEMS2m4N0lVSozlUW4BxXtDYakHllV61QnreyNAgT4=;
 b=dcPDKZn/mqfIO7IORgWmG+EKJV75CbLR/qrDeeg5s8xiEmq6jaIYVfeOmqVnnnMKIN
 +gwoO286xDvrejxXfE7JKi51PM1l1mKueZ1rYtgUzaQvHHGIx12pfBqXJvJDNN2zxmPX
 0qNc1omaImsGLUkiCQ+66FW0zyhdMn5/T99Cm5+W3MQUC9/6ShFYccNbOYAxKKdGj1a1
 QgnMBgK8FVdzWNWS+F1FY73pIePbxoJRLgG5+KhXbMvbawR4rsnsrU6h8i75h28RyaiZ
 jgX/p36eM0Ub+3KxsTavspPSaXhXrKq3967Y2lNGyqUBd7xD3K3Sm5GEivY+EhnVoYOy
 ZSdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/WnTj/9jH1I0xKk9/3zC+7cu3E9DbGtrJ3huGc843oo1W4EuqWT0G3l8dUVnYqLOomFPEFKg=@lists.denx.de
X-Gm-Message-State: AOJu0YzuZZWxqyNaae3CTnhI9vjnqz4S8I23EE9FblVlHt7puPR7ipyn
 mDr1oA+pZSh7XZXNULHAgOnRVnFGA1AQnKX0Pvh6+u1quiY5S8w2sYgXQK6xYr0TwEMNjbBK8pk
 U4ZGVZWieJsSsfSS9xlqUS6h84wayc+CaerjV+2jmdTa2RKJM8adu7YiCfg==
X-Gm-Gg: ASbGncu2sH2wKphJJleNFcxOvbpdZvy1fOc3/qoNySpEjNtZvMVbQ6J7aw6zz31mAlZ
 nRJBaKhRGXLMgve3Sgts/2zbVhOyqAzo8InYsggdpMHlN1i2jU8KQVKr/po9QbpnI3tQ3vkRy2R
 kKXDdPRmRKHodlXjGM+Oe7PbE=
X-Google-Smtp-Source: AGHT+IGETTM8DMw4JP5hKoik28nhzBMn9XhkxrKPl5R46vXg+MR0/eObcQAiHowaW+AVjqkCAtpapBm7vhpEHJErh2c=
X-Received: by 2002:a17:906:dc90:b0:ace:cb59:6c47 with SMTP id
 a640c23a62f3a-ad1d34c01e7mr318301266b.25.1746537852250; Tue, 06 May 2025
 06:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250502025026.4140184-1-sjg@chromium.org>
 <20250502143359.GS1261075@bill-the-cat>
 <CAFLszTha1wWDCpi=HR4sE-rKjoPQp+Twvyrsb-fCcF=vPW4d8Q@mail.gmail.com>
 <20250502150641.GW1261075@bill-the-cat>
 <18d5e7ee-a63d-4895-abbc-4df7737dccff@gmx.de>
 <20250502193020.GZ1261075@bill-the-cat>
 <45357aad-96d3-4c84-b6be-36cf4bb9dfff@gmx.de>
 <20250502200451.GA1261075@bill-the-cat>
 <CAFLszThgJQvA57g8LH0JH6Bq8wk=hnQUnchaUD0SB6v+0JTezg@mail.gmail.com>
 <20250505181846.GJ5430@bill-the-cat>
In-Reply-To: <20250505181846.GJ5430@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 6 May 2025 15:23:59 +0200
X-Gm-Features: ATxdqUH6wD3ZJb1FnIVCW4jbMq8k5B8qhpppWiRytKNLnskCVeec4kH2U6EDdtc
Message-ID: <CAFLszThgq8afbSL8zHqP6nCoB+F5wU6M0MbAoYRsJh8iMi8orA@mail.gmail.com>
Subject: Re: [PATCH 0/3] RFC: test: Bring in the test hooks
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 5 May 2025 at 20:18, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, May 03, 2025 at 08:29:13AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 2 May 2025 at 14:04, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, May 02, 2025 at 09:42:56PM +0200, Heinrich Schuchardt wrote:
> > > > On 5/2/25 21:30, Tom Rini wrote:
> > > > > On Fri, May 02, 2025 at 07:19:18PM +0200, Heinrich Schuchardt wrote:
> > > > > > On 5/2/25 17:06, Tom Rini wrote:
> > > > > > > On Fri, May 02, 2025 at 08:49:12AM -0600, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Fri, 2 May 2025 at 08:34, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Thu, May 01, 2025 at 08:50:16PM -0600, Simon Glass wrote:
> > > > > > > > >
> > > > > > > > > > During a recent discussion with Heinrich we discussed why the hooks are
> > > > > > > > > > kept in a separate repo.
> > > > > > > > > >
> > > > > > > > > > The amount of code is small, a tenth of the size of the recently added
> > > > > > > > > > lwip, just by way of example. Testing is a critical part of U-Boot and
> > > > > > > > > > one of the things that distinguishes it from firmware projects that have
> > > > > > > > > > not kept up in this area. By having the tests somewhere else, we are
> > > > > > > > > > signalling that it is unusual, or difficult, or optional.
> > > > > > > > > >
> > > > > > > > > > The hooks mechanism also needs something of an update to take account of
> > > > > > > > > > real boards in 2025. That will be much easier to undertake if the code
> > > > > > > > > > that test/py talks to is in the same repo.
> > > > > > > > > >
> > > > > > > > > > This series brings the hook files in as first-class citizens of U-Boot.
> > > > > > > > > >
> > > > > > > > > > If we do go ahead with this, I will send a different series which has
> > > > > > > > > > separate commits (with correct author) in the u-boot-test-hooks repo.
> > > > > > > > >
> > > > > > > > > I think bringing more projects directly in to the repository is a bad
> > > > > > > > > idea. Your example of lwip isn't applicable because it's a read-only
> > > > > > > > > subtree that's maintained outside of the project (same as the dts
> > > > > > > > > subtree). But sure, lets "Say Yes". That said, we still need to:
> > > > > > > > > - Remove needless examples from the tree.
> > > > > > > > > - Not include personal labs directly in the tree.
> > > > > > > > >
> > > > > > > > > That last one is why I really think this is a bad idea. The point of
> > > > > > > > > having the hooks standalone is so that any given lab can easily add
> > > > > > > > > support for their lab and manage it, without worrying about disclosing
> > > > > > > > > internal layout. There's going to be hard coded default passwords there.
> > > > > >
> > > > > > Secrets MUST NEVER reside in git repos.
> > > > > >
> > > > > > I can't imagine that such irresponsible habits would be practiced by any
> > > > > > accountable developer.
> > > > >
> > > > > I agree it shouldn't be done. And just this week was the most recent
> > > > > time I've seen a company do that internally, because it's internal and
> > > > > was just a temporary thing. We helped them stop needing to do that, but
> > > > > assuming it never happens is a bad idea.
> > > > >
> > > > > > Please, have a look at
> > > > > >
> > > > > > https://docs.github.com/en/actions/security-for-github-actions/security-guides/using-secrets-in-github-actions
> > > > > > https://tsi-ccdoc.readthedocs.io/en/master/ResOps/2019/gitlab/07_pass-build-secrets.html
> > > > > >
> > > > > > to see how to do it properly.
> > > > > >
> > > > > > The same is true for a private lab:
> > > > > > Use environment variables that are coming from outside the repository.
> > > > > >
> > > > > > > > > There's going to be repository secrets there. That kind of information
> > > > > > > > > really should not be in a public repository. Integrating the hooks with
> > > > > > > > > mainline will make lab management harder, not easier. The point of the
> > > > > > > > > existing labs in u-boot-test-hooks is to provide samples.
> > > > > > > > >
> > > > > > > > > I think this is all why no, we should not go down this path.
> > > > > > > >
> > > > > > > > Is it worth discussing this, or is your mind made up? I have some
> > > > > > > > thoughts on the last one.
> > > > > > >
> > > > > > > I think it's a terrible idea that I already said:
> > > > > > > > But sure, lets "Say Yes".
> > > > > > >
> > > > > > > But please do spend time explaining your thoughts and perhaps others
> > > > > > > will also agree with you and I'll feel less bad taking this in?
> >
> > Well firstly, we should bring in the whole git history so I don't
> > believe these patches should be applied as is. I did push a branch[1]
> > but can send the commands if it helps.
>
> I don't see how that's relevant here, but OK.
>
> > > > > > Currently when changing a test hook I have to go through these steps:
> > > > > >
> > > > > > * fork u-boot-test-hooks
> > > > > > * push a commit to my fork
> > > > > > * update both .gitlab-ci.yaml and .azure-pipelines.yaml
> > > > > > * commit the change code.denx.de
> > > > > > * create a merge request for github.com/u-boot/u-boot
> > > > > >
> > > > > > If the test hooks were in the same repo as main U-Boot, I could save two
> > > > > > steps.
> > > > >
> > > > > Yes, that's true, the steps for updating our CI are a little bit longer.
> > > > > I would be happy to make u-boot-test-hooks more widely writable (so it
> > > > > would instead be pushing to a branch for step 1+2). But I'm also
> > > > > concerned with external labs (which is both the origin of these scripts,
> > > > > and where they're also used).
> > > > >
> > > > > Today, I have both a "konsulko" branch of u-boot-test-hooks, internally.
> > > > > That has subdirectories for both "sage" and "lootbox" (the two lab
> > > > > hosts), and in turn py and bin subdirectories for each. There's no value
> > > > > in publishing these changes as there's nothing unique about the
> > > > > platforms there, which aren't already in the mainline u-boot-test-hooks.
> > > > >
> > > > > How should I manage these changes moving forward?
> > > >
> > > > You could create two branches based on origin/master u-boot:
> > > >
> > > > One for maintaining your test lab specific u-boot-test changes and one for
> > > > your private u-boot code changes.
> > > >
> > > > Check out the lab specific u-boot-test branch for steering the tests of the
> > > > u-boot code branch.
> > >
> > > So now for a lab you need to maintain a branch of U-Boot itself, and
> > > then to test you need to merge your lab support in? And then if there's
> > > problems work back what git hash you tested on, if reporting either
> > > problems, or as part of the "wouldn't it be nice to collect results
> > > idea" work backwards from there? And bisecting problems then becomes a
> > > real nightmare since each step requires a merge.
> >
> > If you have your own hook scripts, they don't have to be in the U-Boot
> > tree. That is entirely up to you. In my case I would want them in the
> > tree, but in your case you can put them somewhere else.  You can even
>
> But we shouldn't have more "ellesmere" stuff in the tree. That's a
> problem. No ones lab should directly be in upstream. We should be
> documenting and providing examples for others to use. Perhaps that
> fundamental confusion is why you're suggesting this path?

I don't see why ellesmere shouldn't be in there. It is a lab used for
U-Boot and therefore part of the project, as I see it. If we end up
with lots of labs from people then we can worry about that problem
then. Today, we have the opposite problem: not enough labs.

>
> > put them inside the U-Boot directory but without adding them to git,
> > if that helps. But we set up the 'PATH' variable to where things are.
> > If we need to change things to make this easier for people, we can.
> > I'm really not seeing any nightmares here at all.
>
> I don't see how PATH is relevant here either. That won't pick up any of
> the configuration files. Might just be able to get away with two
> directories in PYTHONPATH instead of one.

PATH is enough to run a hook script. Yes you need PYTHONPATH as well
if you have stuff in those files. Nothing changes.

But Neil's comment was 'So this will definitely remove the ability to
have test hooks out of the U-boot tree ?', not 'Do I still have to set
my PYTHONPATH / PATH' to where my tree is ?'.

Regards,
Simon
