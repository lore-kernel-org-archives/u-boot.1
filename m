Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A81EEC369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 21:57:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6584809A5;
	Thu,  1 May 2025 23:56:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fZwsoglI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4AC4809D4; Thu,  1 May 2025 22:57:15 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D5A98070C
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 22:57:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5ed43460d6bso2105740a12.0
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 13:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746133032; x=1746737832; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i8djcxhvgqqvufHxBmcpnKGDsEQ/3vXtfyiLNDeE7+o=;
 b=fZwsoglIxt+UIPRQ+d8k4wdKM95uU4ZckgpHx59a2paMgStQjaevS7wGYLtmHoGDfO
 7YXYiC3qjCNoCVOg0CzuprSsY1F5Oqnku6Tjn06Wd5TliYIz6ImkJ/LgQ9c4TM8ddo+A
 1e9jJL5krk/XonEQRNf6SH9RS6DXHNcKBdzWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746133032; x=1746737832;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i8djcxhvgqqvufHxBmcpnKGDsEQ/3vXtfyiLNDeE7+o=;
 b=UwfYwvEpfZ3f68FQ+bsYCUAxMJZYo164aT8RDgvEtddLlwj1+edWBDCkwED42o83+C
 YnfX+UNtpebP2zFmxBEWyls0vOIncrjOHqYy+LBdKzJUDZjuTbWpizug7F7x93oakuUS
 C/ldJU+leZeXvctLrWukvv5EN3BUlLcpvhOpPyJgIGvLC4ry411UWDpGFoSNJ+fuyWBG
 BG9lcEgvNFyK3TaMACIe2OQuWMeeSzCYiA44M2AZWo+KZZ96Ejfm/RsjfyUR2VEHzFPn
 t49llbfjn5hEk5upwUdrMUdgf9dqMJULtN0r6kmhE5knvhAULa0H2S/g4h3UAebvuJFh
 ydjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX493BHyHgb0i9eev2I8q+y+CMzz7qOq6dharYHA0FMAZf47r69G75TfP0CJLrvCAudHa2LKV0=@lists.denx.de
X-Gm-Message-State: AOJu0YwP5TLgmVSipo3NxvpvnfWv7PxbVucPWs1/zNnIfuX+w3vv6R80
 yO7xt+zZSyj9DPJm3MxfbwLXGQjRWT40s4V2BmkZ8pnMuii3DE4LbU0JxZ46dPyzFwRsWg5nDXg
 6mp2zMigQ1JZzmE0ARWweFUT2opR3u8kOHWSf
X-Gm-Gg: ASbGncsQjnVtBe45dgnrNsuhsQ1/5Ui1DCqB3J//tWPKKY3FY+4HJ6TKbZJvCpqKiBd
 2igzDnGlBLJIYAy7kazHtSC9cSfQOztoDq0w9vBTiLEVtBJMZX+jaeVYNO+eRBQGrUyXgYamCJ2
 psx3OTVgMvqaY25aU0SyskhNI=
X-Google-Smtp-Source: AGHT+IGJV0top2wP0txKlaw/JXBao+uiW7qtbRx7pi28gg0GE2c5JRPOZHQ3qVZZ5C8ttVu+AeUAhPsu2YI+Vab+c7c=
X-Received: by 2002:a05:6402:26c8:b0:5f3:857f:2b38 with SMTP id
 4fb4d7f45d1cf-5fa7881775fmr211548a12.17.1746133032421; Thu, 01 May 2025
 13:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250417181613.1355024-1-sjg@chromium.org>
 <CAEfUkUJpT8YxOgdakCBbjBo_a6a6pQDR_wh=iqX5LC+cFAFJ0Q@mail.gmail.com>
 <20250429171154.GJ1261075@bill-the-cat>
 <CAFLszTjfq1TVjYSiCQmtSOZK7MoVUOFU5ycOzeBK4-5-zCKxFQ@mail.gmail.com>
 <20250430142931.GQ1261075@bill-the-cat>
 <CAFLszTh0Z_wWj_zdpopphbtzj0qCiTviZsxT9T+M9oaOn70R0g@mail.gmail.com>
 <20250430152056.GS1261075@bill-the-cat>
 <CAFLszTjDMBORfC1bLXFyTEUuKCA7bU53VURO+Jykkb8BRL3d5g@mail.gmail.com>
 <20250501160435.GJ1261075@bill-the-cat>
In-Reply-To: <20250501160435.GJ1261075@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 May 2025 14:57:00 -0600
X-Gm-Features: ATxdqUG2kadm4nwNYfGNgUB-xlF0uHJ12pE5gK8d-vTN0BwpW7hSzVwO4V80W2o
Message-ID: <CAFLszTjZDG-1aqpHv6-LqnFgwU2ZQwuXnaekwsYhABSvN3=yhQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/22] passage: Define a standard for firmware data flow
To: Tom Rini <trini@konsulko.com>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>, 
 =?UTF-8?Q?Fran=C3=A7ois_Ozog?= <francois.ozog@linaro.org>, 
 Bill Mills <bill.mills@linaro.org>, Albert Aribaud <albert.u.boot@aribaud.net>,
 Alex Shumsky <alexthreed@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 Bin Meng <bmeng.cn@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Fabio Estevam <festevam@gmail.com>, 
 Harrison Mutai <harrison.mutai@arm.com>, Jason Liu <jason.hui.liu@nxp.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Joshua Watt <jpewhacker@gmail.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Levi Yun <yeoreum.yun@arm.com>, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 =?UTF-8?B?TWFyZWsgTW9qw61r?= <marek.mojik@nic.cz>, 
 Mario Six <mario.six@gdsys.cc>,
 Maximilian Brune <maximilian.brune@9elements.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Robert Marko <robert.marko@sartura.hr>, 
 Sean Anderson <seanga2@gmail.com>, Stefan Roese <sr@denx.de>,
 Stefano Babic <sbabic@denx.de>, 
 Sumit Garg <sumit.garg@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Thierry Reding <treding@nvidia.com>, 
 This contributor prefers not to receive mails <noreply@example.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Xu Zhang <423756212@qq.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 01 May 2025 23:56:58 +0200
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

On Thu, 1 May 2025 at 10:04, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Apr 30, 2025 at 07:39:29PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 30 Apr 2025 at 09:21, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Apr 30, 2025 at 08:51:53AM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Wed, 30 Apr 2025 at 08:29, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Wed, Apr 30, 2025 at 07:55:01AM -0600, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Tue, 29 Apr 2025 at 11:11, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Mon, Apr 28, 2025 at 10:41:25AM -0400, Raymond Mao wrote:
> > > > > > > > Hi Simon,
> > > > > > > >
> > > > > > > > On Thu, 17 Apr 2025 at 14:16, Simon Glass <sjg@chromium.org> wrote:
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > This series adds a standard way of passing information between different
> > > > > > > > > firmware phases. This already exists in U-Boot at a very basic level, in
> > > > > > > > > the form of a bloblist containing an spl_handoff structure, but the intent
> > > > > > > > > here is to define something useful across projects.
> > > > > > > > >
> > > > > > > > > The need for this is growing as firmware fragments into multiple binaries
> > > > > > > > > each with its own purpose. Without any run-time connection, we must rely
> > > > > > > > > on build-time settings which are brittle and painful to keep in sync.
> > > > > > > > >
> > > > > > > > > This feature is named 'standard passage' since the name is more unique
> > > > > > > > > than many others that could be chosen, it is a passage in the sense that
> > > > > > > > > information is flowing from one place to another and it is standard,
> > > > > > > > > because that is what we want to create.
> > > > > > > > >
> > > > > > > > > The implementation is mostly a pointer to a bloblist in a register, with
> > > > > > > > > an extra register to point to a devicetree, for more complex data. This
> > > > > > > > > should cover all cases (small memory footprint as well as complex data
> > > > > > > > > flow) and be easy enough to implement on all architectures.
> > > > > > > > >
> > > > > > > > > The emphasis is on enabling open communcation between binaries, not
> > > > > > > > > enabling passage of secret, undocumented data, although this is possible
> > > > > > > > > in a private environment.
> > > > > > > > >
> > > > > > > > > This series is available at u-boot-dm/pass-working
> > > > > > > > >
> > > > > > > >
> > > > > > > > First of all, can you group those patches which are necessary for
> > > > > > > > refactoring the "passage" concept into a smaller series for an easy
> > > > > > > > review?
> > > > > > > >
> > > > > > > > Actually as I mentioned in our previous discussions, I don't agree to
> > > > > > > > add a OF_BLOBLIST as this is duplicated with "BLOBLIST +
> > > > > > > > BLOBLIST_PASSAGE_MANDATORY (aka PASSAGE_IN in the context of your
> > > > > > > > patch - I am not sure the reason you prefer to rename it - do we have
> > > > > > > > any other passage approaches other than using bloblist? And do you
> > > > > > > > have any considerations to allow a fallback or not in case passage
> > > > > > > > failures?)"
> > > > > > >
> > > > > > > As preamble, I am actively working to push the changes for
> > > > > > > vexpress_fvp_bloblist to be available in CI and so provide an easier
> > > > > > > testing path.
> > > > > > >
> > > > > > > At the high level, I don't see what the difference is between "BLOBLIST
> > > > > > > + BLOBLIST_PASSAGE_MANDATORY" and "BLOBLIST + OF_BLOBLIST" or "BLOBLIST
> > > > > > > + whatever v4 of this series ends up showing". Everyone seems wildly in
> > > > > > > agreement that if the prior stage is supposed to give us information
> > > > > > > then it must have done so.
> > > > > > >
> > > > > > > One of the long running "jokes" in computer science about naming being
> > > > > > > one of the hardest problems applies here, too.
> > > > > >
> > > > > > I want to use OF_BLOBLIST as it clearly indicates that the devicetree
> > > > > > comes from a bloblist. The BLOBLIST_PASSAGE_MANDATORY thing is a
> > > > > > work-around to try to avoid having OF_BLOBLIST.
> > > > >
> > > > > Or:
> > > > > Other people want to use BLOBLIST_PASSAGE_MANDATORY as it clearly
> > > > > indicates that the standard passage will be present and so include the
> > > > > devicetree and any other required logs/blobs/content. The OF_BLOBLIST
> > > > > thing is a work-around to try and avoid having
> > > > > BLOBLIST_PASSAGE_MANDATORY.
> > > > >
> > > > > It's a naming problem and I don't care as long as we end up with an
> > > > > implementation that's useful. And *that* is where my list of what
> > > > > bloblist needs to have, in the end, comes from.
> > > >
> > > > My approach does the same thing, but allows my x86 boards to work
> > > > without all the confusion. It shows fdt coming from 'standard passage'
> > > > when it is.
> > >
> > > It does not matter. Really. Whatever you're doing with OF_BLOBLIST can
> > > also be done with BLOBLIST_PASSAGE_MANDATORY as it's just a naming
> > > thing. There's nothing confusing here unless you insist on confusing it.
> > > Which gets back to what I was saying before about what changes need to
> > > happen to bloblist.
> > >
> > > > > > > > Secondly I prefer to keep the register convention code as a xferlist
> > > > > > > > library that can be used for arm arches other than split them into
> > > > > > > > different low level assemblies. In case of any firmware handoff
> > > > > > > > specification update, we just need to maintain this library.
> > > > > > >
> > > > > > > Yes, if things can be written in a C file, they should be in a C file,
> > > > > > > not assembler.
> > > > > >
> > > > > > In this case I disagree and if you look at the x86 code, this kind of
> > > > > > approach is just not sensible. Please take a look at the contortions
> > > > > > of xferlist_from_boot_arg(). It was written for one architecture only,
> > > > > > yet purports to be a general API. My approach is simpler. Also, if
> > > > > > save_boot_args() is implemented by the board, then standard passage
> > > > > > will be broken for that board. It's a weak function!
> > > > >
> > > > > I don't see why this has to be in assembly and not C, no. And it's a
> > > > > weak function because it doesn't yet exist on other architectures and
> > > > > everyone hates #if.
> > > >
> > > > We just don't need it, though. If you would like this to work on x86,
> > > > it needs to go.
> > > >
> > > > >
> > > > > > More generally, please decide if you are willing to let me maintain bloblist.
> > > > >
> > > > > Can you be given substantive feedback? Or is only trivial feedback
> > > > > allowed?
> > > >
> > > > I'm happy to discuss it on a call, but if you insist on
> > > > BLOBLIST_PASSAGE_MANDATORY, then it is going to be tricky. The
> > > > OF_BLOBLIST thing has consumed far too much time. If you want Linaro
> > > > to maintain bloblist, please just say so. I had thought you were OK
> > > > with my taking that on again.
> > >
> > > As I've said numerous times now, BLOBLIST_PASSAGE_MANDATORY and
> > > OF_BLOBLIS are just names. Names are one of the hardest problems in
> > > computer science. As I've also said numerous times now, you need to
> > > show ME that you have a good design. That means you need to implement
> > > register passing rather than BLOBLIST_FIXED. You then also likely need
> > > to untie "Is there a bloblist?" from "Make a bloblist" as that's what
> > > complicates things.
> >
> > They are not names, actually. The logic is different. Please look
> > through it carefully. Perhaps we can discuss this on a call?
>
> I don't know how a call would help. They really are just names for the
> same goal. Whatever the symbol is for "board must use standard passage"
> can select OF_BLOBLIST, it does not matter. Especially if you do what I
> asked in the email you link to later.
>
> > As to BLOBLIST_FIXED, I have a path to do that, and convert x86 also.
> > I even have boards in the lab to make sure it all works. I see that
> > you have got the bloblist board into CI as well, so that will make
> > things easier.
>
> Good, lets get rid of BLOBLIST_FIXED as soon as we can. That'll help
> remove some of the overall confusion.
>
> > But that path I'm talking about doesn't run through the xferlist
>
> I cannot understand why:
> https://patchwork.ozlabs.org/project/uboot/patch/20250417121601.v3.10.I56d9d06e5d74724c963eaffbbe1c2aa400b60bb8@changeid/
> is good
> and:
> https://source.denx.de/u-boot/u-boot/-/commit/5103e69344d60eb8c8d2cf804ec00d0ef3975124
> is bad.
>
> And then what you want will enable x86 to be handled, but what we have
> in tree cannot.
>
> > stuff, nor BLOBLIST_PASSAGE_MANDATORY for that matter, so am I not
> > willing to do it before this series is in. I do want to focus my
> > efforts on things which will bear fruit. For whatever reason, this one
> > seems to have generated a lot more heat than light, over a period of
> > 18 months.
> >
> > Another option you have is to take this series and then the following
> > ones for the migration and *then* decide if you want something
> > tweaked. That would be more likely to result in a successful
> > collaboration.
> >
> > The reason I keep asking you about just letting me maintain it is that
> > I thought you agreed to this a few months back:
> >
> > https://lore.kernel.org/u-boot/20250216154801.GZ1233568@bill-the-cat/
> >
> > Please, consider the option of just sending me a 'yes' and I'll sort
> > all this out.
>
> So are you, or are you not doing what I outlined in what you linked
> above? Because looking briefly, again, at v3, and setting aside the
> unintentional breakage, it's not doing much of what I asked. We're
> finally (good!) adding a way to pass between U-Boot phases on ARM. We're
> also not making use of the existing mechanism for doing so, for unclear
> reasons. So yes, before you make a v4 you should explain what's wrong
> with the method we have today.

Can I please first check whether you might be open to an alternative
approach to BLOBLIST_PASSAGE_MANDATORY and using C code for the
register saving?

Regards,
Simon
