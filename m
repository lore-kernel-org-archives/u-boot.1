Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5FAEE8013
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 15:28:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D43D886A3F;
	Fri,  8 Sep 2023 17:28:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UqeJvtVW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04D6A86A43; Fri,  8 Sep 2023 17:28:54 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 284FA86A3C
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 17:28:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-500b0f06136so3705729e87.0
 for <u-boot@lists.denx.de>; Fri, 08 Sep 2023 08:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694186930; x=1694791730; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nEnMhF30tUMFB1A4retvhgEMdxN8wwd9E/6n2IkKjPU=;
 b=UqeJvtVW9sghAYjanl8jWGF9oBo2PPKyCNcXYk5tjRGeHA3rJscBIlhRrXrlhPRzOi
 N0L2kTkuT1dUC1JIFnbXe2zNPZr/95DmpUtTSprlTSnwF2vX9/SBvI0LjXqwz7bMFjRq
 4Vzb9bllHUffiXqoEbPHL/b8cGM9Ie/GdxIEFvvJHAX2DsI6JLMIvy7Tz1iHl6P9HDDc
 SGUvWYAGArE6jO6Z/sP+I7OU8Dkx6ZLb9PTOCL1voU1olUUUIfaC+mOseHB7LPSrq9B+
 UAk/h5t2LnYeqhzTFmGO7sTLDs95WM1lnX0nl8rS1ihAZJ9FpE+HjtodK939YpP6pB6P
 cdNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694186930; x=1694791730;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nEnMhF30tUMFB1A4retvhgEMdxN8wwd9E/6n2IkKjPU=;
 b=DzLcqXd3R7wbX9IFhq86IBFeDez9C3kEhRHeXDt9NlIJf+DYtWgRjKbr93TbeTZVAe
 ZWJ/rPyDxk2xlMwnlPAHs7O4KB5MbYeipGoZkvlIGGIAnjw05rhZDCJlv5uUd62sDmfv
 U9vz/pXPPWIpIhNiTf7KwZBnI3865T9bWGj/Q3XhxB8MuXHCg71L+WqfAFmSvlA0OGHz
 bj/sQ9sAxGbXN0CKoKGikhuZiZCmBJAQr2uhNzuAnw8/TS543o4bTrL3Xu6wC+qSo8mN
 xtkOwpcVkyQ2e1P7fHMBSXhzkxS7dVhb8CrVsu5CX8OZ+SDlhYoV3/TTxpt+MoC8FCqU
 XJTA==
X-Gm-Message-State: AOJu0YxnsZUrkviGzkTenC6IVIYv2zOSaf3qVr7zf0lkkYQBqNJ01nNy
 9iuixr0pAC/oGDtj7TDQvMkPIArEtwvYyogzu/9yKA==
X-Google-Smtp-Source: AGHT+IGHnBzYWalKfldSCmpQP8puL9uv21iDXC+XPzDnrqr2tXvTys9XRdaYAt0gpWqOrlSOe6l/mO9l6HmpdROXbuk=
X-Received: by 2002:a05:6512:788:b0:4fb:9e1a:e592 with SMTP id
 x8-20020a056512078800b004fb9e1ae592mr2010542lfr.4.1694186930351; Fri, 08 Sep
 2023 08:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
 <CAPnjgZ3HVJ9+-PjmHSKwQRgCMkcNPWAcfMkk5SMMgiHAcY0SsQ@mail.gmail.com>
 <CALeDE9MMiA9HVfbeOV3tGqfAAC9oYf9qvizBW0T=hLmqcYD=qw@mail.gmail.com>
 <CAPnjgZ1pgvxhntJvkuAsxKXUVxcWACNTpuDqgonFCrOLr=934Q@mail.gmail.com>
 <CALeDE9ODEwV0Z9APwb1N8QNZFQSB1dkMTMHPW2p2xTLiUZjQ1A@mail.gmail.com>
 <CAPnjgZ1FiqjjxjL+Ve-s5WEafksOZsSP3XyW4xYdjyP-U_TZzQ@mail.gmail.com>
 <20230906142139.GA1236014-robh@kernel.org> <ZPldgbS8mu+5DG7Q@hera>
 <CAPnjgZ0kcOZp65d_-wwYyjbTwC-aDamvGU50aa34o2PeZjZk6Q@mail.gmail.com>
 <CAC_iWjKn_xzoCEv8EBghm7-N5Ex1gEJK=nxdV6QvQ_mPm5R=hQ@mail.gmail.com>
 <20230908145418.GG305624@bill-the-cat>
In-Reply-To: <20230908145418.GG305624@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 8 Sep 2023 18:28:14 +0300
Message-ID: <CAC_iWjLxd_9ceE8twaxSsh=8paN_tpaA4jiANAsJksUOH8c6yQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Allow for removal of DT nodes and properties
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Rob Herring <robh@kernel.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Fri, 8 Sept 2023 at 17:54, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Sep 08, 2023 at 01:13:42PM +0300, Ilias Apalodimas wrote:
> > Hi Simon,
> >
> > On Thu, 7 Sept 2023 at 15:23, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Ilias,
> > >
> > > On Wed, 6 Sept 2023 at 23:20, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > Hi Rob,
> > > >
> > > > [...]
> > > >
> > > > > > > > > >
> > > > > > > > > > What is the point of removing them? Instead, we should make sure that
> > > > > > > > > > we upstream the bindings and encourage SoC vendors to sync them. If we
> > > > > > > > > > remove them, no one will bother and U-Boot just becomes a dumping
> > > > > > > > > > ground.
> > > > > > > > >
> > > > > > > > > Well things like the binman entries in DT are U-Boot specific and not
> > > > > > > > > useful for HW related descriptions or for Linux or another OS being
> > > > > > > > > able to deal with HW so arguably we're already a dumping ground to
> > > > > > > > > some degree for not defining hardware.
> > > > > > > >
> > > > > > > > I have started the process to upstream the binman bindings.
> > > > > > >
> > > > > > > I don't think they should be in DT at all, they don't describe
> > > > > > > anything to do with hardware, or generally even the runtime of a
> > > > > > > device, they don't even describe the boot/runtime state of the
> > > > > > > firmware, they describe build time, so I don't see what that has to do
> > > > > > > with device tree? Can you explain that? To me those sorts of things
> > > > > > > should live in a build time style config file.
> > > > >
> > > > > For the record, I tend to agree.
> > > > >
> > > >
> > > > +1
> > > >
> > > > > > I beg to differ. Devicetree is more than just hardware and always has
> > > > > > been. See, for example the /chosen and /options nodes.
> > > > >
> > > > > There are exceptions...
> > > > >
> > > >
> > > > We've been this over and over again and frankly it gets a bit annoying.
> > > > It's called *DEVICE* tree for a reason.  As Rob pointed out there are
> > > > exceptions, but those made a lot of sense.  Having arbitrary internal ABI
> > > > stuff of various projects in the schema just defeats the definition of a
> > > > spec.
> > >
> > > Our efforts should not just be about internal ABI, but working to
> > > provide a consistent configuration system for all firmware elements.
> >
> > And that's what the firmware handoff was all about.
> > I get what you are trying to do here.  I am just aware of any other
>
> "just not aware" did you mean?

Yep, sorry!

>
> > project apart from U-Boot which uses DT for it's own configuration.
> > So trying to standardize some bindings that are useful to all projects
> > that use DT is fine. Trying to *enforce* them to use it for config
> > isn't IMHO.
> >
> > >
> > > We cannot have it both ways, i.e. refusing to accept non-hardware
> > > bindings and then complaining that U-Boot does not pass schema
> > > validation. Devicetree should be a shared resource, not just for the
> > > use of Linux.
> >
> > It's not for the use of Linux, I've wasted enough time repeating that
> > and so has Rob.  Please go back to previous emails and read the
> > arguments.
>
> Right, it's not just for Linux, but Linux is where most of the
> exceptions to the "ONLY HARDWARE" rule got in, because they also make
> sense.

Exactly.

> And the overarching point Simon keeps trying to make I believe
> can be boiled down to that too.  There are things that one does not have
> a (reasonable) choice about how to do things with when interacting with
> the hunk of melted sand on your desk and that information needs to go
> somewhere.

DT is a big hammer indeed, but that doesn't mean we always need to use
it.  I never disagreed with adding nodes that make sense and will be
useful for others. For example, the internal Driver model
configuration options used to enable a device early etc etc are
probably useful to more projects.  On the other hand, if U-Boot is
indeed the only project using DT for its internal configuration why
should we care?

For example, let's imagine you build TF-A, and TF-A is configured and
bundled with a device tree that gets passed along to U-Boot (using
OF_BOARD).  Why on earth should TF-A be aware of internal DM
implementation details and build a device tree containing
u-boot,dm-pre-reloc, u-boot,dm-spl, dm-tpl, and every other
non-upstreamed nodes we have?
Another example would be the public key that we shoehorn on the DT.
In commit ddf67daac39d ("efi_capsule: Move signature from DTB to
.rodata") I tried to get rid of that because since I was aware of the
dt-schema conformance and honestly having the capsule public portion
of the key there makes little sense.  Unfortunately, that got reverted
in commit 47a25e81d35c8 with a bogus commit message as well.  So again
imagine building TF-A, which is a first-stage bootloader and has no
understanding of UEFI whatsoever,  asking the TF-A project to start
injecting public keys around that has no idea why or how they will be
used.

 Can you imagine how the device tree would look like in a couple of
years from now if we allow *every* project to add its own special
config needs in there?  So perhaps we should take a step back, agree
that some level of config is needed, identify the common options, and
add that to the spec instead of dumping everything that doesn't fit
somewhere else in there.

>
> > > We already have reserved-memory, flash layout and other
> > > things which don't relate to hardware. I would love to somehome get
> > > past this fundamental discussion which seems to come up every time we
> > > get close to making progress
> >
> > Most of the nodes we already have were used across projects and made
> > sense to all of them. U-Boot might need to reserve some memory and so
> > does linux etc etc.
> > Some other nodes make nosense at all to and they just serve internal
> > ABI implementation details.  I can't possibly fathom how these would
> > be justifiable.  On top of all that, there's a huge danger here.  How
> > are you planning on separating arbitrary entries from various
> > projects?
>
> I think in some ways this is the whole point of at least what I'm asking
> for.  It's fine to say "Here is the mechanism to remove nodes /
> properties from the device tree".  BUT adding entries to that list MUST
> document where someone tried to upstream and explain that this is
> something that belongs in the device tree because it is useful to
> everyone.

And we don't disagree on that either. That's why the link to the FWU
discussion was there (although it should have been in a doc and not in
a mail). I am not arguing against adding nodes, I am arguing that we
shouldn't rush them and that there's zero chance that we manage to
upstream everything and keep some level of sanity on the spec.
So, since U-Boot is currently using the DT for its own configuration
needs, not having the ability to provide a DT that conforms to the
spec and hope that we can upstream everything will just delay all of
SystemReady 2.0 conformance efforts (and is unrealistic IMHO).
>
> > What I am afraid is going to happen here is simple.  If a project
> > doesn't use DT to configure itself and wants to provide a DT to
> > U-Boot, then are you going to say "Can you please inject various DT
> > nodes in the tree because U-Boot *needs* them and they are now part of
> > the spec"?  Anyway, it's not up to me to decide here, I am just saying
> > what makes sense to me.
>
> What's the difference between that and "If a project doesn't use DT to
> configure itself and wants to provide a DT to Linux, ..." ?

See the example above with TF-A, I hope that clears it up.

Thanks
/Ilias
>
> --
> Tom
