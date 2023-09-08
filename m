Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53786EE57EE
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 10:14:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66D1F869B9;
	Fri,  8 Sep 2023 12:14:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bPAsO8k2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2AB0869BC; Fri,  8 Sep 2023 12:14:22 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A9AB865D0
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 12:14:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-501be2d45e0so3170957e87.3
 for <u-boot@lists.denx.de>; Fri, 08 Sep 2023 03:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694168058; x=1694772858; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+pt1NK9GEXRMJScSUTTHm4Eb23ayudW39K/hmJP7rxI=;
 b=bPAsO8k2NF3sslBRpQ/nYEE5zReoWHTUvFOpihCDgOh7ndi2Qx1/4mkrrtdInATpHd
 g5/SlQy6pzLXjoC8YZ6s31MwoP11bjlxiDtRU7/gHLgShYBPx7GVS67HZXeQgbi0lqL9
 kNlkrNPNhpGcQuen3rM9SMX2W1P6ET85/wivhOCTDEw3FhPydzxd9LPNsYwzU5g09vCh
 BVJc5EyKHcQBlhOKC+zIqahWgrbMmhOaAviHEAVnWyQtznWTeDzuntRCeynwwEZjweIW
 uQW3WT/J7tgpjaWGLATZevcYeoUivD87wTHdZ0dWbVkvJCmiRqIilmht7ncTaI1Tdw7f
 sPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694168058; x=1694772858;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+pt1NK9GEXRMJScSUTTHm4Eb23ayudW39K/hmJP7rxI=;
 b=K/uSKv34uEHGleN1nY3rPu6HVSh5QPgNZZQuc7aWnreDf9fTD+7lTQk9eIQh1chTFH
 BqhVSWHAZbVPB1Kvw0fxCv3kwn10f0xv4xJcQzgYG4DKH1DJoqqG7b8OgfIveqKpbQ3t
 mpsX/4Gv67xP8jTCvEmkNlO6LGraZDU58eEt9gulxe+eq0zQOdlrAcQw0qGqn/LGpAVr
 2mWA/PNKrJkCDGXNh2XQf2J7MqkTmYHzc4x/ViQFABJL6QTijAaJptyXmZft/vgISPck
 wqGI0JW44BDTlSwrNCfOtos6PfkGOZuT0jzlAKC0Loy5QPZA8v9JClVGZ6MZtGMxLgaX
 ckag==
X-Gm-Message-State: AOJu0YwNPzOlevv80QxZNC9cJ/NWenvJy8M0F7G5SlPQP5gJrBA/Z0Rg
 XEckIVlykAgymlyhxreDD7I04GVNoukTcnUeqeXKHQ==
X-Google-Smtp-Source: AGHT+IFQeJ5+RcwvmrwdnlVW6anc80hOiod0CeSiemwBWx9CMKtRc5TydvN8Fnc405hGCV2E+iDPNdIj6M7VVnFqDfI=
X-Received: by 2002:a19:4f46:0:b0:500:7e70:ddf5 with SMTP id
 a6-20020a194f46000000b005007e70ddf5mr1257367lfk.43.1694168058494; Fri, 08 Sep
 2023 03:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
 <CAPnjgZ3HVJ9+-PjmHSKwQRgCMkcNPWAcfMkk5SMMgiHAcY0SsQ@mail.gmail.com>
 <CALeDE9MMiA9HVfbeOV3tGqfAAC9oYf9qvizBW0T=hLmqcYD=qw@mail.gmail.com>
 <CAPnjgZ1pgvxhntJvkuAsxKXUVxcWACNTpuDqgonFCrOLr=934Q@mail.gmail.com>
 <CALeDE9ODEwV0Z9APwb1N8QNZFQSB1dkMTMHPW2p2xTLiUZjQ1A@mail.gmail.com>
 <CAPnjgZ1FiqjjxjL+Ve-s5WEafksOZsSP3XyW4xYdjyP-U_TZzQ@mail.gmail.com>
 <20230906142139.GA1236014-robh@kernel.org> <ZPldgbS8mu+5DG7Q@hera>
 <CAPnjgZ0kcOZp65d_-wwYyjbTwC-aDamvGU50aa34o2PeZjZk6Q@mail.gmail.com>
In-Reply-To: <CAPnjgZ0kcOZp65d_-wwYyjbTwC-aDamvGU50aa34o2PeZjZk6Q@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 8 Sep 2023 13:13:42 +0300
Message-ID: <CAC_iWjKn_xzoCEv8EBghm7-N5Ex1gEJK=nxdV6QvQ_mPm5R=hQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Allow for removal of DT nodes and properties
To: Simon Glass <sjg@chromium.org>
Cc: Rob Herring <robh@kernel.org>, Peter Robinson <pbrobinson@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Simon,

On Thu, 7 Sept 2023 at 15:23, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Wed, 6 Sept 2023 at 23:20, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Rob,
> >
> > [...]
> >
> > > > > > > >
> > > > > > > > What is the point of removing them? Instead, we should make sure that
> > > > > > > > we upstream the bindings and encourage SoC vendors to sync them. If we
> > > > > > > > remove them, no one will bother and U-Boot just becomes a dumping
> > > > > > > > ground.
> > > > > > >
> > > > > > > Well things like the binman entries in DT are U-Boot specific and not
> > > > > > > useful for HW related descriptions or for Linux or another OS being
> > > > > > > able to deal with HW so arguably we're already a dumping ground to
> > > > > > > some degree for not defining hardware.
> > > > > >
> > > > > > I have started the process to upstream the binman bindings.
> > > > >
> > > > > I don't think they should be in DT at all, they don't describe
> > > > > anything to do with hardware, or generally even the runtime of a
> > > > > device, they don't even describe the boot/runtime state of the
> > > > > firmware, they describe build time, so I don't see what that has to do
> > > > > with device tree? Can you explain that? To me those sorts of things
> > > > > should live in a build time style config file.
> > >
> > > For the record, I tend to agree.
> > >
> >
> > +1
> >
> > > > I beg to differ. Devicetree is more than just hardware and always has
> > > > been. See, for example the /chosen and /options nodes.
> > >
> > > There are exceptions...
> > >
> >
> > We've been this over and over again and frankly it gets a bit annoying.
> > It's called *DEVICE* tree for a reason.  As Rob pointed out there are
> > exceptions, but those made a lot of sense.  Having arbitrary internal ABI
> > stuff of various projects in the schema just defeats the definition of a
> > spec.
>
> Our efforts should not just be about internal ABI, but working to
> provide a consistent configuration system for all firmware elements.

And that's what the firmware handoff was all about.
I get what you are trying to do here.  I am just aware of any other
project apart from U-Boot which uses DT for it's own configuration.
So trying to standardize some bindings that are useful to all projects
that use DT is fine. Trying to *enforce* them to use it for config
isn't IMHO.

>
> We cannot have it both ways, i.e. refusing to accept non-hardware
> bindings and then complaining that U-Boot does not pass schema
> validation. Devicetree should be a shared resource, not just for the
> use of Linux.

It's not for the use of Linux, I've wasted enough time repeating that
and so has Rob.  Please go back to previous emails and read the
arguments.

> We already have reserved-memory, flash layout and other
> things which don't relate to hardware. I would love to somehome get
> past this fundamental discussion which seems to come up every time we
> get close to making progress

Most of the nodes we already have were used across projects and made
sense to all of them. U-Boot might need to reserve some memory and so
does linux etc etc.
Some other nodes make nosense at all to and they just serve internal
ABI implementation details.  I can't possibly fathom how these would
be justifiable.  On top of all that, there's a huge danger here.  How
are you planning on separating arbitrary entries from various
projects?

What I am afraid is going to happen here is simple.  If a project
doesn't use DT to configure itself and wants to provide a DT to
U-Boot, then are you going to say "Can you please inject various DT
nodes in the tree because U-Boot *needs* them and they are now part of
the spec"?  Anyway, it's not up to me to decide here, I am just saying
what makes sense to me.

>
> >
> > > > We need run-time configuration here, since we cannot know at build
> > > > time what we will be asked to do by a previous firmware phase.
> > >
> > > Really, I don't want to have to care about the binman binding. If it is
> > > u-boot specific, then it should stay in u-boot. I took /options/u-boot/,
> > > but now I'm starting to have second thoughts on that being in dtschema
> > > if it is going to be continually and frequently extended. Validating it
> > > in SR does little. If a vendor is abusing /options/u-boot/ in some way
> > > they could just as easily remove the node in their u-boot fork to pass.
> > > SR is certainly not going to require the node be there.
> > >
> > > On A/B updates, that really doesn't seem like a u-boot specific problem
> > > to me. No one wants A/B updates in EDK2 or anything else?
> >
> > A/B updates might be implemented in EDK2 or any other bootloader that
> > chooses to implement it.  The metadata information a bootloader needs
> > to implement it are documented here [0].  Those metadata are not part of
> > the DT.  If they were it would make sense to add them on the schema.  The
> > DT entry we are using though serves a different purpose.  It tells the
> > bootloader the location of the metadata (iow where can I read them from the
> > disk).  Since bootloaders have a different way of storing their
> > configuration, I don't think this needs to be in the spec.  EDK2 for
> > example doesn't always use a DT and I don't think they'll ever use it to
> > store configuration information.
>
> In another thread with Rob involved, we are trying to provide bindings
> for EDK2 to use.
>
> Whatever the efforts of those trying to fragment the firmware
> industry, there are efforts to bring it together with a consistent
> configuration story. Ultimately I believe these will have to prevail,
> as the complexity increases.


Regards
/Ilias
