Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E26CA0EC9
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 06:03:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 629CC86E15;
	Tue, 12 Sep 2023 08:03:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MDXLXf97";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7962586DA7; Tue, 12 Sep 2023 08:03:55 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3428A86E1F
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 08:03:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-403061cdf2bso26410765e9.2
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 23:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694498631; x=1695103431; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ReRQejGtTg+NsGUpUn3zFQFzMvuWqvVxfEi6pgG+/7c=;
 b=MDXLXf97euNsTjn37wuo+wtUnsIf2vlomX/PJIXSioyP7ly8HKrhJt/rWrmX80iVaR
 4RFhCxHobD0wqwKNUQRG6LyUAEI1ChCVor7Y3/f0YtnO25ibwDJLW030U2aMMxs+EBo2
 6TgHHP01ilNxk+OKRxkmIhrSQDkUhoSpLofmt9vdLLzzsM/Pj2ExOJPKZxkjavDoX8hJ
 UuixJ1vmzNYXKeiqk96ozu1WjLJnD1kCm3p6Zxwj0Sf01dLDZ5F8QgykLnzTYMvIlpG3
 STy2oeUilcpwVrQZlmzpqke/T6GuYSY7zhvuE/GE5Td65kYMhhHnqRQZ+CxQ2R2ClvH2
 Pwvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694498631; x=1695103431;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ReRQejGtTg+NsGUpUn3zFQFzMvuWqvVxfEi6pgG+/7c=;
 b=VZ3brtbmX7P4P3hmwaD6LCF9oSkn7NbnM3Igk5RQouyq5f8pbSCcrP+KmDh/1ImusG
 s+8bu8IrAYzqEGZtUuTTIDLLCYuS0dQtriAzw3TW7ZHfHEMsnC0+uX8wtVHAx7aCz1WS
 OP84q8B8dXPYdzk9C5ca0NWfp4w/eynXD+Ajy8JMHBcIgYxHeaaRlyNCttZJFfCLyHjn
 AJ5v8N2apUvD43QHebvmHeEpysjX4bIGiDbt60EWz0ivABfkaM/s/8cCNUh1g8WaqvN0
 stf/pH6Ugg/JA7IjpPSO0t1QxZxvTmJqPhAxOpqdoaBj77/lGg34p5tdWjxsb75J/bTk
 Ahpw==
X-Gm-Message-State: AOJu0YynNB5SHDXEjvT+sPQXuwS6Fc1Egszys6aS0jzSYFeNVXaRgf6G
 SNQDYlAyLBby95fEcL1AjdOatQ==
X-Google-Smtp-Source: AGHT+IEhu+GbgUJDYJx8A6nUDEFI/5kVgb1BNCwO8Bj5EUftQav7v9ov/X4R9RH+Y13iKUddlKx5Rw==
X-Received: by 2002:a7b:c7c5:0:b0:3fe:207c:1aea with SMTP id
 z5-20020a7bc7c5000000b003fe207c1aeamr9999959wmk.23.1694498631413; 
 Mon, 11 Sep 2023 23:03:51 -0700 (PDT)
Received: from hera (ppp089210246083.access.hol.gr. [89.210.246.83])
 by smtp.gmail.com with ESMTPSA id
 n22-20020a7bcbd6000000b003fef3180e7asm15113407wmi.44.2023.09.11.23.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 23:03:50 -0700 (PDT)
Date: Tue, 12 Sep 2023 09:03:48 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Rob Herring <robh@kernel.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [RFC PATCH 0/5] Allow for removal of DT nodes and properties
Message-ID: <ZP//RBE8nri1bd0d@hera>
References: <CAPnjgZ1pgvxhntJvkuAsxKXUVxcWACNTpuDqgonFCrOLr=934Q@mail.gmail.com>
 <CALeDE9ODEwV0Z9APwb1N8QNZFQSB1dkMTMHPW2p2xTLiUZjQ1A@mail.gmail.com>
 <CAPnjgZ1FiqjjxjL+Ve-s5WEafksOZsSP3XyW4xYdjyP-U_TZzQ@mail.gmail.com>
 <20230906142139.GA1236014-robh@kernel.org> <ZPldgbS8mu+5DG7Q@hera>
 <CAPnjgZ0kcOZp65d_-wwYyjbTwC-aDamvGU50aa34o2PeZjZk6Q@mail.gmail.com>
 <CAC_iWjKn_xzoCEv8EBghm7-N5Ex1gEJK=nxdV6QvQ_mPm5R=hQ@mail.gmail.com>
 <20230908145418.GG305624@bill-the-cat>
 <CAC_iWjLxd_9ceE8twaxSsh=8paN_tpaA4jiANAsJksUOH8c6yQ@mail.gmail.com>
 <20230911190613.GC305624@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911190613.GC305624@bill-the-cat>
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

[...]

> > > > > > > > > I don't think they should be in DT at all, they don't describe
> > > > > > > > > anything to do with hardware, or generally even the runtime of a
> > > > > > > > > device, they don't even describe the boot/runtime state of the
> > > > > > > > > firmware, they describe build time, so I don't see what that has to do
> > > > > > > > > with device tree? Can you explain that? To me those sorts of things
> > > > > > > > > should live in a build time style config file.
> > > > > > >
> > > > > > > For the record, I tend to agree.
> > > > > > >
> > > > > >
> > > > > > +1
> > > > > >
> > > > > > > > I beg to differ. Devicetree is more than just hardware and always has
> > > > > > > > been. See, for example the /chosen and /options nodes.
> > > > > > >
> > > > > > > There are exceptions...
> > > > > > >
> > > > > >
> > > > > > We've been this over and over again and frankly it gets a bit annoying.
> > > > > > It's called *DEVICE* tree for a reason.  As Rob pointed out there are
> > > > > > exceptions, but those made a lot of sense.  Having arbitrary internal ABI
> > > > > > stuff of various projects in the schema just defeats the definition of a
> > > > > > spec.
> > > > >
> > > > > Our efforts should not just be about internal ABI, but working to
> > > > > provide a consistent configuration system for all firmware elements.
> > > >
> > > > And that's what the firmware handoff was all about.
> > > > I get what you are trying to do here.  I am just aware of any other
> > >
> > > "just not aware" did you mean?
> >
> > Yep, sorry!
> >
> > >
> > > > project apart from U-Boot which uses DT for it's own configuration.
> > > > So trying to standardize some bindings that are useful to all projects
> > > > that use DT is fine. Trying to *enforce* them to use it for config
> > > > isn't IMHO.
> > > >
> > > > >
> > > > > We cannot have it both ways, i.e. refusing to accept non-hardware
> > > > > bindings and then complaining that U-Boot does not pass schema
> > > > > validation. Devicetree should be a shared resource, not just for the
> > > > > use of Linux.
> > > >
> > > > It's not for the use of Linux, I've wasted enough time repeating that
> > > > and so has Rob.  Please go back to previous emails and read the
> > > > arguments.
> > >
> > > Right, it's not just for Linux, but Linux is where most of the
> > > exceptions to the "ONLY HARDWARE" rule got in, because they also make
> > > sense.
> >
> > Exactly.
> >
> > > And the overarching point Simon keeps trying to make I believe
> > > can be boiled down to that too.  There are things that one does not have
> > > a (reasonable) choice about how to do things with when interacting with
> > > the hunk of melted sand on your desk and that information needs to go
> > > somewhere.
> >
> > DT is a big hammer indeed, but that doesn't mean we always need to use
> > it.  I never disagreed with adding nodes that make sense and will be
> > useful for others. For example, the internal Driver model
> > configuration options used to enable a device early etc etc are
> > probably useful to more projects.  On the other hand, if U-Boot is
> > indeed the only project using DT for its internal configuration why
> > should we care?
> >
> > For example, let's imagine you build TF-A, and TF-A is configured and
> > bundled with a device tree that gets passed along to U-Boot (using
> > OF_BOARD).  Why on earth should TF-A be aware of internal DM
> > implementation details and build a device tree containing
> > u-boot,dm-pre-reloc, u-boot,dm-spl, dm-tpl, and every other
> > non-upstreamed nodes we have?
>
> I don't think this is a clear example, sorry.  "dm-pre-reloc" etc are
> the bootph things now that you say could be useful.  So they're an
> example of how (now that things are more receptive) we need to look at
> what U-Boot has that doesn't pass validation and see "does this make
> sense, today" or not.
>

The point here is a bit different though.  We need this in U-Boot *because*
we use the DT to configure things.  They are useful information, but unless
another bootloader uses the same config method, U-Boot is the only consumer.

If we could split those nodes in an internal u-boot .dtsi file that would
be much much cleaner.  But IIRC we'll have problems with patching DTs in
TPL/SPL with limited memory.

> I guess I'm confused as to why it's a theoretical problem for TF-A to
> pass along /binman/ but not a problem to pass along
> /soc/.../snvs/.../linux,snvs_pwrkey on i.MX8.  _Sometimes_ internals

It's the same problem and I don't think it's ok for TF-A to pass those as
either.

> just need to be there.  That also does not mean every single should be
> there.
>

> > Another example would be the public key that we shoehorn on the DT.
> > In commit ddf67daac39d ("efi_capsule: Move signature from DTB to
> > .rodata") I tried to get rid of that because since I was aware of the
> > dt-schema conformance and honestly having the capsule public portion
> > of the key there makes little sense.  Unfortunately, that got reverted
> > in commit 47a25e81d35c8 with a bogus commit message as well.  So again
> > imagine building TF-A, which is a first-stage bootloader and has no
> > understanding of UEFI whatsoever,  asking the TF-A project to start
> > injecting public keys around that has no idea why or how they will be
> > used.
> >
> >  Can you imagine how the device tree would look like in a couple of
> > years from now if we allow *every* project to add its own special
> > config needs in there?  So perhaps we should take a step back, agree
> > that some level of config is needed, identify the common options, and
> > add that to the spec instead of dumping everything that doesn't fit
> > somewhere else in there.
>
> Part of the problem here and now with capsule update stuff seems to be
> that, well, I don't know what the heck we should do.  It's a "lovely"
> specification defined feature and so I honestly don't know how much
> leeway we have for how we can and can't represent and implement the
> portions that are left up to the implementation or board specific.

Heinrich and I can help on that.  In short, the capsule update chapter
doesn't define where the key should be stored.  It should obviously be on a
tamper resistant medium and it has a specific format, but that's as far as
the spec would go.

> I don't see why TF-A would inject something that should have been present
> already?  And/or ...

I am not following you here.  The public key is unique per class of
devices.  If someone builds TF-A and decides to provide a DTB though that,
you then need to, unpack the TF-A binary when you build U-Boot,  amend it
and repack it via binman.  On top of that, those binaries will
probably be signed, so the repacking exercise becomes pretty painful.

>
> > > > > We already have reserved-memory, flash layout and other
> > > > > things which don't relate to hardware. I would love to somehome get
> > > > > past this fundamental discussion which seems to come up every time we
> > > > > get close to making progress
> > > >
> > > > Most of the nodes we already have were used across projects and made
> > > > sense to all of them. U-Boot might need to reserve some memory and so
> > > > does linux etc etc.
> > > > Some other nodes make nosense at all to and they just serve internal
> > > > ABI implementation details.  I can't possibly fathom how these would
> > > > be justifiable.  On top of all that, there's a huge danger here.  How
> > > > are you planning on separating arbitrary entries from various
> > > > projects?
> > >
> > > I think in some ways this is the whole point of at least what I'm asking
> > > for.  It's fine to say "Here is the mechanism to remove nodes /
> > > properties from the device tree".  BUT adding entries to that list MUST
> > > document where someone tried to upstream and explain that this is
> > > something that belongs in the device tree because it is useful to
> > > everyone.

We never disagreed on that.  I already said that the FWU link Sughosh sent
in the cover letter should be added on a doc.  But that's irrelevant to
'hard NAKing' patches [0].  It's also the complete opposite of what we are
discussing here, since AFAICT you are fine with the removal mechanism as
long as the nodes-to-be-removed are documented properly and there has been
an upstream effort of those beforehand.

> >
> > And we don't disagree on that either. That's why the link to the FWU
> > discussion was there (although it should have been in a doc and not in
> > a mail). I am not arguing against adding nodes, I am arguing that we
> > shouldn't rush them and that there's zero chance that we manage to
> > upstream everything and keep some level of sanity on the spec.
> > So, since U-Boot is currently using the DT for its own configuration
> > needs, not having the ability to provide a DT that conforms to the
> > spec and hope that we can upstream everything will just delay all of
> > SystemReady 2.0 conformance efforts (and is unrealistic IMHO).
>
> The first problem is how does the capsule update specification specify
> handling the stuff that we put in the FWU nodes that we then need to
> delete?
>

It doesn't.  The A/B update support is not part of the spec.  FWU and the
A/B updates are designed on top of the EFI spec to provide an easy way to
do firmware updates without bricking the board while at the same time
provide rollback protection.

> The second problem is that I don't want the discussion link to just be
> in the cover letter, I want it in the tree, in documentation and heck,
> an unused-by-the-compiler parameter in the macro that adds a node to
> delete that is the rST file that documents the "we tried, it was
> rejected, this still makes sense" or whatever is appropriate as to why
> we're deleting the node.  Cheaters shall cheat here, yes, but upstream
> will have a record of trying.

Again, we never disagreed on that

[0] https://lore.kernel.org/u-boot/CAPnjgZ3AexW4vfO-A8WYGE0OD5EZnOUA7tA1QP71Bcw51QArBQ@mail.gmail.com/

Thanks
/Ilias

>
> --
> Tom


