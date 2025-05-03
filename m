Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D271CC369C2
	for <u-boot@archiver.kernel.org>; Sat,  3 May 2025 14:29:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 091A88214B;
	Sat,  3 May 2025 16:29:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LTJ+MMOq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4E4F8214F; Sat,  3 May 2025 16:29:28 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3983C8210D
 for <u-boot@lists.denx.de>; Sat,  3 May 2025 16:29:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-acbb48bad09so534428166b.0
 for <u-boot@lists.denx.de>; Sat, 03 May 2025 07:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746282565; x=1746887365; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XPvNwDYSbt/NIls4t/wuqXc5pQo+EsOdwqzkGgklv9w=;
 b=LTJ+MMOqEvMDFZCJ9PWTP2S740gJIcNRQMwkxyIgYy3QkJJDLQ4itLwVNbviguy+RR
 k2Flxipjil1628uZazD6NvElrMwX3T83O8rFMzVlMGzn2kCU78nfswlitvzGwiG8PMRV
 eoKq1iKdss5BziS5+7k0h3YU7Wv1FKauhsNH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746282565; x=1746887365;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XPvNwDYSbt/NIls4t/wuqXc5pQo+EsOdwqzkGgklv9w=;
 b=gWopBtMBXw/mHOkXVgragDnAWW1urK3jMd0tqwXmVXIIknj/64LL26x8lFuGlTEvUo
 NVwwLYQt0pnAiVI+mmhazJwUeMrDLCN9g+9mx6pUCb/8ru6AtIxMoyhKvjIr9YMy3ykl
 +f60h7H7pOt/elHUL8nLF5ZQUG1320zJrKl4bnDQKdBX3UKLhtQ3hkUG2FB1pH6BM2q9
 MMVgc+rIWJOl2pKiK96gZd5eFSG/wbGMO1NRXo4olt9LUW6BN8nHUScTNNFVxzVEvIDJ
 MWMJXb5bJizJqCvOyXxAYHv/dLGhsdKfCsOz7DK7w/fHIp6hJYYsiDZcPXtVUTaK87q7
 EY3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJBw0v0dOKbsrMZ++zSODZLCHBo/bj3BFLDZtzQrLv3iystxwIhrFu4ncfc+T8/TTuCz2LHAE=@lists.denx.de
X-Gm-Message-State: AOJu0YwobOeMfUuFP+nwOGGG7s1/GpTs3LSyAiM16u1IhnxMn3iu3knP
 huteQu1vK+zluCrkYkiT2/Ds+8XbysM+39oumkMXsgfLRlH+tnlitbgXh7Urzai2qitdpqGEoR5
 36Y9BKCE6Ft0zgahMlp3jDBfj7QAwPYtsjwbb02l8wZPVJAa+Pw==
X-Gm-Gg: ASbGncuwnXt7bLRYPLm+MSJKSskXg755TrSkxOVMT1oatnqmu/AsP+p8/D4Phs5KXXW
 t417mEvk42EmG4VJyeXKYQky6lildrYDNYL3tzTWjnz5E39gUIBaHmyKxRdE3VheRyhsQtPVFu0
 +nXGZmDV1VfTSCp7fFNOvhNY4=
X-Google-Smtp-Source: AGHT+IHwVS1tLYl12pP2AiG+BZdJIqGp4QpMcpVWUClabjwnBzUQZtomybRh+WDzMg7h0kZ7CbRGEx7bocNEuRA2KOc=
X-Received: by 2002:a17:907:7255:b0:ac1:dfab:d38e with SMTP id
 a640c23a62f3a-ad1a48ea7afmr104599166b.15.1746282565574; Sat, 03 May 2025
 07:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250502025026.4140184-1-sjg@chromium.org>
 <20250502143359.GS1261075@bill-the-cat>
 <CAFLszTha1wWDCpi=HR4sE-rKjoPQp+Twvyrsb-fCcF=vPW4d8Q@mail.gmail.com>
 <20250502150641.GW1261075@bill-the-cat>
 <18d5e7ee-a63d-4895-abbc-4df7737dccff@gmx.de>
 <20250502193020.GZ1261075@bill-the-cat>
 <45357aad-96d3-4c84-b6be-36cf4bb9dfff@gmx.de>
 <20250502200451.GA1261075@bill-the-cat>
In-Reply-To: <20250502200451.GA1261075@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 May 2025 08:29:13 -0600
X-Gm-Features: ATxdqUFAyZ93pwrfppkyyYkNuupd-j73Z_xz9pPeJY4ZhVWcpZJjw7d1_d9Thvk
Message-ID: <CAFLszThgJQvA57g8LH0JH6Bq8wk=hnQUnchaUD0SB6v+0JTezg@mail.gmail.com>
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

On Fri, 2 May 2025 at 14:04, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, May 02, 2025 at 09:42:56PM +0200, Heinrich Schuchardt wrote:
> > On 5/2/25 21:30, Tom Rini wrote:
> > > On Fri, May 02, 2025 at 07:19:18PM +0200, Heinrich Schuchardt wrote:
> > > > On 5/2/25 17:06, Tom Rini wrote:
> > > > > On Fri, May 02, 2025 at 08:49:12AM -0600, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Fri, 2 May 2025 at 08:34, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Thu, May 01, 2025 at 08:50:16PM -0600, Simon Glass wrote:
> > > > > > >
> > > > > > > > During a recent discussion with Heinrich we discussed why the hooks are
> > > > > > > > kept in a separate repo.
> > > > > > > >
> > > > > > > > The amount of code is small, a tenth of the size of the recently added
> > > > > > > > lwip, just by way of example. Testing is a critical part of U-Boot and
> > > > > > > > one of the things that distinguishes it from firmware projects that have
> > > > > > > > not kept up in this area. By having the tests somewhere else, we are
> > > > > > > > signalling that it is unusual, or difficult, or optional.
> > > > > > > >
> > > > > > > > The hooks mechanism also needs something of an update to take account of
> > > > > > > > real boards in 2025. That will be much easier to undertake if the code
> > > > > > > > that test/py talks to is in the same repo.
> > > > > > > >
> > > > > > > > This series brings the hook files in as first-class citizens of U-Boot.
> > > > > > > >
> > > > > > > > If we do go ahead with this, I will send a different series which has
> > > > > > > > separate commits (with correct author) in the u-boot-test-hooks repo.
> > > > > > >
> > > > > > > I think bringing more projects directly in to the repository is a bad
> > > > > > > idea. Your example of lwip isn't applicable because it's a read-only
> > > > > > > subtree that's maintained outside of the project (same as the dts
> > > > > > > subtree). But sure, lets "Say Yes". That said, we still need to:
> > > > > > > - Remove needless examples from the tree.
> > > > > > > - Not include personal labs directly in the tree.
> > > > > > >
> > > > > > > That last one is why I really think this is a bad idea. The point of
> > > > > > > having the hooks standalone is so that any given lab can easily add
> > > > > > > support for their lab and manage it, without worrying about disclosing
> > > > > > > internal layout. There's going to be hard coded default passwords there.
> > > >
> > > > Secrets MUST NEVER reside in git repos.
> > > >
> > > > I can't imagine that such irresponsible habits would be practiced by any
> > > > accountable developer.
> > >
> > > I agree it shouldn't be done. And just this week was the most recent
> > > time I've seen a company do that internally, because it's internal and
> > > was just a temporary thing. We helped them stop needing to do that, but
> > > assuming it never happens is a bad idea.
> > >
> > > > Please, have a look at
> > > >
> > > > https://docs.github.com/en/actions/security-for-github-actions/security-guides/using-secrets-in-github-actions
> > > > https://tsi-ccdoc.readthedocs.io/en/master/ResOps/2019/gitlab/07_pass-build-secrets.html
> > > >
> > > > to see how to do it properly.
> > > >
> > > > The same is true for a private lab:
> > > > Use environment variables that are coming from outside the repository.
> > > >
> > > > > > > There's going to be repository secrets there. That kind of information
> > > > > > > really should not be in a public repository. Integrating the hooks with
> > > > > > > mainline will make lab management harder, not easier. The point of the
> > > > > > > existing labs in u-boot-test-hooks is to provide samples.
> > > > > > >
> > > > > > > I think this is all why no, we should not go down this path.
> > > > > >
> > > > > > Is it worth discussing this, or is your mind made up? I have some
> > > > > > thoughts on the last one.
> > > > >
> > > > > I think it's a terrible idea that I already said:
> > > > > > But sure, lets "Say Yes".
> > > > >
> > > > > But please do spend time explaining your thoughts and perhaps others
> > > > > will also agree with you and I'll feel less bad taking this in?

Well firstly, we should bring in the whole git history so I don't
believe these patches should be applied as is. I did push a branch[1]
but can send the commands if it helps.

> > > > >
> > > >
> > > > Currently when changing a test hook I have to go through these steps:
> > > >
> > > > * fork u-boot-test-hooks
> > > > * push a commit to my fork
> > > > * update both .gitlab-ci.yaml and .azure-pipelines.yaml
> > > > * commit the change code.denx.de
> > > > * create a merge request for github.com/u-boot/u-boot
> > > >
> > > > If the test hooks were in the same repo as main U-Boot, I could save two
> > > > steps.
> > >
> > > Yes, that's true, the steps for updating our CI are a little bit longer.
> > > I would be happy to make u-boot-test-hooks more widely writable (so it
> > > would instead be pushing to a branch for step 1+2). But I'm also
> > > concerned with external labs (which is both the origin of these scripts,
> > > and where they're also used).
> > >
> > > Today, I have both a "konsulko" branch of u-boot-test-hooks, internally.
> > > That has subdirectories for both "sage" and "lootbox" (the two lab
> > > hosts), and in turn py and bin subdirectories for each. There's no value
> > > in publishing these changes as there's nothing unique about the
> > > platforms there, which aren't already in the mainline u-boot-test-hooks.
> > >
> > > How should I manage these changes moving forward?
> >
> > You could create two branches based on origin/master u-boot:
> >
> > One for maintaining your test lab specific u-boot-test changes and one for
> > your private u-boot code changes.
> >
> > Check out the lab specific u-boot-test branch for steering the tests of the
> > u-boot code branch.
>
> So now for a lab you need to maintain a branch of U-Boot itself, and
> then to test you need to merge your lab support in? And then if there's
> problems work back what git hash you tested on, if reporting either
> problems, or as part of the "wouldn't it be nice to collect results
> idea" work backwards from there? And bisecting problems then becomes a
> real nightmare since each step requires a merge.

If you have your own hook scripts, they don't have to be in the U-Boot
tree. That is entirely up to you. In my case I would want them in the
tree, but in your case you can put them somewhere else.  You can even
put them inside the U-Boot directory but without adding them to git,
if that helps. But we set up the 'PATH' variable to where things are.
If we need to change things to make this easier for people, we can.
I'm really not seeing any nightmares here at all.

Regards,
Simon

[1] https://github.com/sjg20/uboot-test-hooks/tree/move
