Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23188EE020F
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 22:39:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F07D0867D6;
	Thu, 14 Sep 2023 00:39:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TMzhsHvU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93E00867D2; Thu, 14 Sep 2023 00:39:28 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECE8986B65
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 00:39:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=robh@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 76773B82755
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 22:39:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2357CC433CA
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 22:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1694644764;
 bh=2YWHOtBi6XHsGdMMxWSpu+bQcHw7NBafIAUDqU9ruiI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=TMzhsHvUHaJoevPmiipwiPlhKApEnU7YIiujvnHEhWk7ecBfssBJkqb/Nj2TRCElG
 jCvFR28G2cqbcG7McYTgRH3G/mHP7y2pE/6RlQPdK7ZqUelpi9RvcfKFs5XS735IT/
 CMPM4BkCa9u5It4xYLPQWmNHgZLtXfNNHJuOtUPIYfE/heYUItZJHf2tjrOqCS/AYP
 VBZME85JpnZhoJsnzEHBwkFg/CLkopqXCw83H8i18mwmMa/gOK0WJoTpfHsSn6J1G2
 5CQ8a9uMPLXvra9hhOEZgs7RUUTz+oxv7WWNYUSrVDKigCM65Gh09vcmToBWDfGtt3
 SnaZHVPa5NwvQ==
Received: by mail-lf1-f47.google.com with SMTP id
 2adb3069b0e04-502b0d23f28so487624e87.2
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 15:39:24 -0700 (PDT)
X-Gm-Message-State: AOJu0YwjxhPfgzbEXcjoX5xPrtQ6jZKHNRWNGlQj9DyB8JUWhDekRvLd
 Tzq7fm/QBy6J1MFLHshrKE/GVaDte83JA4PYMg==
X-Google-Smtp-Source: AGHT+IG+8eaubyfhRIhkDrfLKdJ1DUF1zYOzqIwabRdU9EGiKVBLf+wrcCLbZ4Cr+/Q6UxQ5sFSYOHypVKwCl0G+cvc=
X-Received: by 2002:ac2:5f57:0:b0:500:9f85:6e84 with SMTP id
 23-20020ac25f57000000b005009f856e84mr2635042lfz.3.1694644762284; Wed, 13 Sep
 2023 15:39:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
 <CAPnjgZ3HVJ9+-PjmHSKwQRgCMkcNPWAcfMkk5SMMgiHAcY0SsQ@mail.gmail.com>
 <CALeDE9MMiA9HVfbeOV3tGqfAAC9oYf9qvizBW0T=hLmqcYD=qw@mail.gmail.com>
 <CAPnjgZ1pgvxhntJvkuAsxKXUVxcWACNTpuDqgonFCrOLr=934Q@mail.gmail.com>
 <CALeDE9ODEwV0Z9APwb1N8QNZFQSB1dkMTMHPW2p2xTLiUZjQ1A@mail.gmail.com>
 <CAPnjgZ1FiqjjxjL+Ve-s5WEafksOZsSP3XyW4xYdjyP-U_TZzQ@mail.gmail.com>
 <20230906142139.GA1236014-robh@kernel.org> <ZPldgbS8mu+5DG7Q@hera>
 <CAPnjgZ0kcOZp65d_-wwYyjbTwC-aDamvGU50aa34o2PeZjZk6Q@mail.gmail.com>
 <CABb+yY0VJDu+L2C10E1O-uAU-p0OwuTq6XVF2XbYuOc2fBqoww@mail.gmail.com>
 <875y4kh77c.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <875y4kh77c.fsf@bloch.sibelius.xs4all.nl>
From: Rob Herring <robh@kernel.org>
Date: Wed, 13 Sep 2023 17:39:09 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKehgMGReC2GZseCy5JufgL9on9NTu7Bouh9-kUDFmfSQ@mail.gmail.com>
Message-ID: <CAL_JsqKehgMGReC2GZseCy5JufgL9on9NTu7Bouh9-kUDFmfSQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Allow for removal of DT nodes and properties
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, sjg@chromium.org,
 ilias.apalodimas@linaro.org, 
 pbrobinson@gmail.com, sughosh.ganu@linaro.org, u-boot@lists.denx.de, 
 trini@konsulko.com, xypron.glpk@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Sep 8, 2023 at 1:06=E2=80=AFPM Mark Kettenis <mark.kettenis@xs4all.=
nl> wrote:
>
> > From: Jassi Brar <jassisinghbrar@gmail.com>
> > Date: Fri, 8 Sep 2023 09:37:12 -0500
> >
> > Hi Simon,
> >
> > On Thu, Sep 7, 2023 at 3:08=E2=80=AFPM Simon Glass <sjg@chromium.org> w=
rote:
> > > On Wed, 6 Sept 2023 at 23:20, Ilias Apalodimas
> > > >
> > > > > > I beg to differ. Devicetree is more than just hardware and alwa=
ys has
> > > > > > been. See, for example the /chosen and /options nodes.
> > > > >
> > > > > There are exceptions...
> > > > >
> > > >
> > > > We've been this over and over again and frankly it gets a bit annoy=
ing.
> > > > It's called *DEVICE* tree for a reason.  As Rob pointed out there a=
re
> > > > exceptions, but those made a lot of sense.  Having arbitrary intern=
al ABI
> > > > stuff of various projects in the schema just defeats the definition=
 of a
> > > > spec.
> > >
> > > Our efforts should not just be about internal ABI, but working to
> > > provide a consistent configuration system for all firmware elements.
> > >
> > Sure, programmatically we can pass any data/info via DT, however it is
> > only meant to map hardware features onto data structures.
> >
> > devicetree.org  landing page
> >     "The devicetree is a data structure for describing hardware."
> >
> > devicetree-specification-v0.3.pdf  Chapter-2 Line-1
> >    "DTSpec specifies a construct called a devicetree to describe
> > system hardware."
>
> But it doesn't say that it describes *only* hardware.  And it does
> describe more than just hardware.  There is /chosen to specify
> firmware configuration and there are several examples of device tree
> bindings that describe non-discoverable firmware interfaces in the
> Linux tree.  And it has been that way since the days of IEEE 1275.
> There are also bindings describing things like the firmware partition
> layout.

Yes. The exact title for 1275[1] is: IEEE Standard for Boot
(Initialization Configuration)
Firmware: Core Requirements and Practices

I see "configuration" in there. However, in the OF case, it's
generally how firmware configured the hardware and what it discovered.
That's a little different than telling the OS how to configure the
hardware which is what we do with FDT. Then there's stuff that's how
to configure Linux which we try to reject.

Once we get into configuration of the OS/client (including u-boot),
making that an ABI is a lot harder and if we use DT for that, I don't
think it should be an ABI.

> > If we want to digress from the spec, we need the majority of
> > developers to switch sides :)  which is unlikely to happen and rightly
> > so, imho.
>
> It isn't even clear what the spec is.  There is the document you
> reference above, there are the yaml files at
> https://github.com/devicetree-org/dt-schema and then there are
> additional yaml files in the Linux tree.  As far as I know it isn't
> written down anywhere that those are the only places where device tree
> bindings can live.

There's not any restriction.

My intention with dtschema schemas is to only have "spec level"
schemas. (Stuff we'd add to DTSpec (but don't because no one wants to
write specs).) Hardware specific stuff lives somewhere else. That
happens to be the Linux tree because that is where all the h/w support
is (nothing else is close (by far)). Last I checked, we've got ~3700
schemas and ~1500 unconverted bindings.

> Anyway, let's face it, there is some consensus among developers that
> what Simon has done in U-Boot is pushing the use of devicetree beyond
> the point where a significant fraction of developers thinks it makes
> sense.  And I think I agree with that.  But you can't beat him with
> the spec to make your point.
>
> Now the devicetree is cleverly constructed such that it is possible to
> define additional bindings without the risk of conflicting with
> bindings developed by other parties.  In particular if U-Boot is
> augmenting a device tree with properties that are prefixed with
> "u-boot," this isn't going to hurt an operating system that uses such
> an augmented device tree.

Until someone has some great idea to start using them. If the OS
doesn't need something, then why pass it in the first place? What
purpose does it serve? It's an invitation for someone somewhere to
start using them.

The downside of keeping the nodes is it creates an ABI where there
doesn't need to be one necessarily.

> The real problem is that some folks developed a certification program
> that allegedly requires schema verification and now propose adding
> code to U-Boot that doesn't really solve any problem.  My proposed
> solution would be to change said certification program to allow
> firmware to augment the device tree with properties and nodes with
> compatibles that are in the namespace controlled by the firmware.

I don't think we should decide what to do here based on said
certification program. It can adapt to what's decided. Probably, the
/option nodes will be stripped out or ignored for certification.

I accepted u-boot options node schema into dtschema, but now have
second thoughts on that. Now I'm getting more u-boot specific
(perhaps, not clear) stuff and widevine stuff internal to a TEE.

Rob
