Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2E7C3ABC3
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 13:05:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2689582935;
	Sat, 10 May 2025 15:05:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XBSl7q65";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD5A482952; Sat, 10 May 2025 15:03:54 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30D04826AA
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 15:03:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ad21a5466f6so328666966b.1
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 06:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746882231; x=1747487031; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sBBHGVTJbxlSbl2AiBY8/+i+1OU7zb2qpBSXdHO79JM=;
 b=XBSl7q65Ao7PXj8csaXxg05ADg1xkdeVaW6Zyf+HLiZAT1GoT0uCoFIRxCMiF23Dpa
 uIc/XnZpsH8LNQpmZVVLunikZiOTLnGgXgAaJ7eW2SzJIQtMTw3igrX3ntkD5BSzsFCt
 ibUT+2jBmo2VefLgAgWdAAx82fXHoRRogBA/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746882231; x=1747487031;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sBBHGVTJbxlSbl2AiBY8/+i+1OU7zb2qpBSXdHO79JM=;
 b=EZcnj72efB1i1shCeOmCsAPH6gQLUu3NoaNai7Oh66/LrxvcPAwpOKeAguOa/va+/N
 qS7r16yP10cENBSsezjOL6KWAjYfbXcQgkZRPEtksC8JeEO00Rkad2eouRU/YQzHy0UV
 kRQ6PnDL/oqXgKd5kyDp1QudTGrA8mehELyWhYyvuvKXRAYHgRV+eR1h4Q793U0611bT
 41oYxCELjoqIzaLgU1FiEiBIY8LHU2WWIEO9JgDDexS6evxHnjqn0mScoH+OqP8Gy97E
 +hEtEc5Jcm/d/uInM18AIn99Fm1FuY+FoJlZJ//jxbso/WM1Ti9FDder7cfm5i0NcFlQ
 X8ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKsano1i4FUYCQpDdZ34qGpkrLIcdDXsgVkpeyWalMPx7mwZ069bt65P24Iz1sHmWxewVyF9I=@lists.denx.de
X-Gm-Message-State: AOJu0YzFlEx8QtIoT+lHMbvyp/xQXvaZ0PGiBfY2YjiZbOb8kwvq7n7e
 byP8jD9MyYkASo9elT5Tf4PbwNnVrChOywSYGUXYzKBoZPqhTOf3kIIy46DUT53Dc9NwjH3y6du
 MLBfTqh/gXAkaeIeMKx8ZvAhzOQWdizcAtfIf
X-Gm-Gg: ASbGnctr0SpCjj1HHjNg7GCDS+GxOVZAmqn1R6bh55jf/WUHhUqvXfISMfJ7G9bozAM
 m6IPjZZtGc+g2QkE2AiGobfgAFgi9SfyIrEfQ/p5yLiVABV5UrxwCFxwI75VELD8d/zCXkyGQYG
 pQSriIMeY+mKthPBzUd/nSFgqkACKZc4aA76Vea0e3it+q
X-Google-Smtp-Source: AGHT+IF/YfTsys4sLhJVAq655oSrOSxVx7NUm+2KuxeNI9OP+V5ScmE5wwmcZpH1Cb9Glt3DIzYMcGSx6dQ3pvFoyG4=
X-Received: by 2002:a17:907:c717:b0:ace:d587:2f3b with SMTP id
 a640c23a62f3a-ad21b4264damr577079966b.22.1746882231319; Sat, 10 May 2025
 06:03:51 -0700 (PDT)
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
 <CAFLszTjZDG-1aqpHv6-LqnFgwU2ZQwuXnaekwsYhABSvN3=yhQ@mail.gmail.com>
 <20250501211107.GK1261075@bill-the-cat>
In-Reply-To: <20250501211107.GK1261075@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 10 May 2025 15:03:39 +0200
X-Gm-Features: AX0GCFsTvKkxB5el91QItEjWYxrSgQk80tuq42iRbr0aJjTXoJpBy7E9FcreQmo
Message-ID: <CAFLszTiEvORHGSR9sLyMG_UeBf5QNqeLHG1fvvZukGqy+V3qrQ@mail.gmail.com>
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
X-Mailman-Approved-At: Sat, 10 May 2025 15:05:02 +0200
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

On Thu, 1 May 2025 at 23:11, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, May 01, 2025 at 02:57:00PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 1 May 2025 at 10:04, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Apr 30, 2025 at 07:39:29PM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Wed, 30 Apr 2025 at 09:21, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Wed, Apr 30, 2025 at 08:51:53AM -0600, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Wed, 30 Apr 2025 at 08:29, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Wed, Apr 30, 2025 at 07:55:01AM -0600, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Tue, 29 Apr 2025 at 11:11, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, Apr 28, 2025 at 10:41:25AM -0400, Raymond Mao wrote:
> > > > > > > > > > Hi Simon,
> > > > > > > > > >
> > > > > > > > > > On Thu, 17 Apr 2025 at 14:16, Simon Glass <sjg@chromium.org> wrote:
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > This series adds a standard way of passing information between different
> > > > > > > > > > > firmware phases. This already exists in U-Boot at a very basic level, in
> > > > > > > > > > > the form of a bloblist containing an spl_handoff structure, but the intent
> > > > > > > > > > > here is to define something useful across projects.
> > > > > > > > > > >
> > > > > > > > > > > The need for this is growing as firmware fragments into multiple binaries
> > > > > > > > > > > each with its own purpose. Without any run-time connection, we must rely
> > > > > > > > > > > on build-time settings which are brittle and painful to keep in sync.
> > > > > > > > > > >
> > > > > > > > > > > This feature is named 'standard passage' since the name is more unique
> > > > > > > > > > > than many others that could be chosen, it is a passage in the sense that
> > > > > > > > > > > information is flowing from one place to another and it is standard,
> > > > > > > > > > > because that is what we want to create.
> > > > > > > > > > >
> > > > > > > > > > > The implementation is mostly a pointer to a bloblist in a register, with
> > > > > > > > > > > an extra register to point to a devicetree, for more complex data. This
> > > > > > > > > > > should cover all cases (small memory footprint as well as complex data
> > > > > > > > > > > flow) and be easy enough to implement on all architectures.
> > > > > > > > > > >
> > > > > > > > > > > The emphasis is on enabling open communcation between binaries, not
> > > > > > > > > > > enabling passage of secret, undocumented data, although this is possible
> > > > > > > > > > > in a private environment.
> > > > > > > > > > >
> > > > > > > > > > > This series is available at u-boot-dm/pass-working
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > First of all, can you group those patches which are necessary for
> > > > > > > > > > refactoring the "passage" concept into a smaller series for an easy
> > > > > > > > > > review?
> > > > > > > > > >
> > > > > > > > > > Actually as I mentioned in our previous discussions, I don't agree to
> > > > > > > > > > add a OF_BLOBLIST as this is duplicated with "BLOBLIST +
> > > > > > > > > > BLOBLIST_PASSAGE_MANDATORY (aka PASSAGE_IN in the context of your
> > > > > > > > > > patch - I am not sure the reason you prefer to rename it - do we have
> > > > > > > > > > any other passage approaches other than using bloblist? And do you
> > > > > > > > > > have any considerations to allow a fallback or not in case passage
> > > > > > > > > > failures?)"
> > > > > > > > >
> > > > > > > > > As preamble, I am actively working to push the changes for
> > > > > > > > > vexpress_fvp_bloblist to be available in CI and so provide an easier
> > > > > > > > > testing path.
> > > > > > > > >
> > > > > > > > > At the high level, I don't see what the difference is between "BLOBLIST
> > > > > > > > > + BLOBLIST_PASSAGE_MANDATORY" and "BLOBLIST + OF_BLOBLIST" or "BLOBLIST
> > > > > > > > > + whatever v4 of this series ends up showing". Everyone seems wildly in
> > > > > > > > > agreement that if the prior stage is supposed to give us information
> > > > > > > > > then it must have done so.
> > > > > > > > >
> > > > > > > > > One of the long running "jokes" in computer science about naming being
> > > > > > > > > one of the hardest problems applies here, too.
> > > > > > > >
> > > > > > > > I want to use OF_BLOBLIST as it clearly indicates that the devicetree
> > > > > > > > comes from a bloblist. The BLOBLIST_PASSAGE_MANDATORY thing is a
> > > > > > > > work-around to try to avoid having OF_BLOBLIST.
> > > > > > >
> > > > > > > Or:
> > > > > > > Other people want to use BLOBLIST_PASSAGE_MANDATORY as it clearly
> > > > > > > indicates that the standard passage will be present and so include the
> > > > > > > devicetree and any other required logs/blobs/content. The OF_BLOBLIST
> > > > > > > thing is a work-around to try and avoid having
> > > > > > > BLOBLIST_PASSAGE_MANDATORY.
> > > > > > >
> > > > > > > It's a naming problem and I don't care as long as we end up with an
> > > > > > > implementation that's useful. And *that* is where my list of what
> > > > > > > bloblist needs to have, in the end, comes from.
> > > > > >
> > > > > > My approach does the same thing, but allows my x86 boards to work
> > > > > > without all the confusion. It shows fdt coming from 'standard passage'
> > > > > > when it is.
> > > > >
> > > > > It does not matter. Really. Whatever you're doing with OF_BLOBLIST can
> > > > > also be done with BLOBLIST_PASSAGE_MANDATORY as it's just a naming
> > > > > thing. There's nothing confusing here unless you insist on confusing it.
> > > > > Which gets back to what I was saying before about what changes need to
> > > > > happen to bloblist.
> > > > >
> > > > > > > > > > Secondly I prefer to keep the register convention code as a xferlist
> > > > > > > > > > library that can be used for arm arches other than split them into
> > > > > > > > > > different low level assemblies. In case of any firmware handoff
> > > > > > > > > > specification update, we just need to maintain this library.
> > > > > > > > >
> > > > > > > > > Yes, if things can be written in a C file, they should be in a C file,
> > > > > > > > > not assembler.
> > > > > > > >
> > > > > > > > In this case I disagree and if you look at the x86 code, this kind of
> > > > > > > > approach is just not sensible. Please take a look at the contortions
> > > > > > > > of xferlist_from_boot_arg(). It was written for one architecture only,
> > > > > > > > yet purports to be a general API. My approach is simpler. Also, if
> > > > > > > > save_boot_args() is implemented by the board, then standard passage
> > > > > > > > will be broken for that board. It's a weak function!
> > > > > > >
> > > > > > > I don't see why this has to be in assembly and not C, no. And it's a
> > > > > > > weak function because it doesn't yet exist on other architectures and
> > > > > > > everyone hates #if.
> > > > > >
> > > > > > We just don't need it, though. If you would like this to work on x86,
> > > > > > it needs to go.
> > > > > >
> > > > > > >
> > > > > > > > More generally, please decide if you are willing to let me maintain bloblist.
> > > > > > >
> > > > > > > Can you be given substantive feedback? Or is only trivial feedback
> > > > > > > allowed?
> > > > > >
> > > > > > I'm happy to discuss it on a call, but if you insist on
> > > > > > BLOBLIST_PASSAGE_MANDATORY, then it is going to be tricky. The
> > > > > > OF_BLOBLIST thing has consumed far too much time. If you want Linaro
> > > > > > to maintain bloblist, please just say so. I had thought you were OK
> > > > > > with my taking that on again.
> > > > >
> > > > > As I've said numerous times now, BLOBLIST_PASSAGE_MANDATORY and
> > > > > OF_BLOBLIS are just names. Names are one of the hardest problems in
> > > > > computer science. As I've also said numerous times now, you need to
> > > > > show ME that you have a good design. That means you need to implement
> > > > > register passing rather than BLOBLIST_FIXED. You then also likely need
> > > > > to untie "Is there a bloblist?" from "Make a bloblist" as that's what
> > > > > complicates things.
> > > >
> > > > They are not names, actually. The logic is different. Please look
> > > > through it carefully. Perhaps we can discuss this on a call?
> > >
> > > I don't know how a call would help. They really are just names for the
> > > same goal. Whatever the symbol is for "board must use standard passage"
> > > can select OF_BLOBLIST, it does not matter. Especially if you do what I
> > > asked in the email you link to later.
> > >
> > > > As to BLOBLIST_FIXED, I have a path to do that, and convert x86 also.
> > > > I even have boards in the lab to make sure it all works. I see that
> > > > you have got the bloblist board into CI as well, so that will make
> > > > things easier.
> > >
> > > Good, lets get rid of BLOBLIST_FIXED as soon as we can. That'll help
> > > remove some of the overall confusion.
> > >
> > > > But that path I'm talking about doesn't run through the xferlist
> > >
> > > I cannot understand why:
> > > https://patchwork.ozlabs.org/project/uboot/patch/20250417121601.v3.10.I56d9d06e5d74724c963eaffbbe1c2aa400b60bb8@changeid/
> > > is good
> > > and:
> > > https://source.denx.de/u-boot/u-boot/-/commit/5103e69344d60eb8c8d2cf804ec00d0ef3975124
> > > is bad.
> > >
> > > And then what you want will enable x86 to be handled, but what we have
> > > in tree cannot.
> > >
> > > > stuff, nor BLOBLIST_PASSAGE_MANDATORY for that matter, so am I not
> > > > willing to do it before this series is in. I do want to focus my
> > > > efforts on things which will bear fruit. For whatever reason, this one
> > > > seems to have generated a lot more heat than light, over a period of
> > > > 18 months.
> > > >
> > > > Another option you have is to take this series and then the following
> > > > ones for the migration and *then* decide if you want something
> > > > tweaked. That would be more likely to result in a successful
> > > > collaboration.
> > > >
> > > > The reason I keep asking you about just letting me maintain it is that
> > > > I thought you agreed to this a few months back:
> > > >
> > > > https://lore.kernel.org/u-boot/20250216154801.GZ1233568@bill-the-cat/
> > > >
> > > > Please, consider the option of just sending me a 'yes' and I'll sort
> > > > all this out.
> > >
> > > So are you, or are you not doing what I outlined in what you linked
> > > above? Because looking briefly, again, at v3, and setting aside the
> > > unintentional breakage, it's not doing much of what I asked. We're
> > > finally (good!) adding a way to pass between U-Boot phases on ARM. We're
> > > also not making use of the existing mechanism for doing so, for unclear
> > > reasons. So yes, before you make a v4 you should explain what's wrong
> > > with the method we have today.
> >
> > Can I please first check whether you might be open to an alternative
> > approach to BLOBLIST_PASSAGE_MANDATORY and using C code for the
> > register saving?
>
> I mean, when it's possible, yes? That you remove that code in v3 is part
> of my problem with it. We still have to save the registers in assembly
> since we haven't setup the stack and so forth. But if you can improve
> upon the ratio of assembly to C that's being used today, great!

Well now that you have that FVP board going in CI, this is
considerably easier, so thank you very much for that!

It seems to work fine with my standard passage series, unsurprisingly
I suppose, given that it follows the same spec. But it is so much
easier to test it in CI than with all that TF-A + patches / OP-TEE
confusion.

Regards,
Simon
