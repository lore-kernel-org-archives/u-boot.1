Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8AEBC3DA6F
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 21:00:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 391A886432;
	Wed, 23 Aug 2023 23:00:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IV+voB0G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF5DC8644F; Wed, 23 Aug 2023 23:00:29 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38EE3863B2
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 23:00:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=robh@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D32E561A3F
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 21:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D961C433CC
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 21:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692824425;
 bh=1GUjNlOG+KBoYDglAFVyksE2nk/O4gZ7mJ1bEw2jBKg=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=IV+voB0G0KbhCnH8oRVzLlqIvelRo3Qb7aKgVDPeKPaa8nv7fDu3MqkuUPkU83dcs
 tpNxr2/AmUv3cCJIri0fXXb+JCcgq5yOrehAwltyrx6yLSpx8q8JXkzujdzafUQG1Q
 LrGFXCBxC6un/ITuRIxEBDWwWM30SraT9Xgzuk9UyfPzDEBfO8AC9u1NxYEdD1/L0A
 kXIj4LaXef1NjDvg1spy3bzq5k175sbns4bgrxQl3UQqAllG1eKN+lT45nZSCg8QoI
 tScY6blf2etQOseXJMVcQgAk/rA9qpR5oYzbz8BKTn8dUE9okWtk1GH1VoSIom3A8n
 BexLh2bkWN1+A==
Received: by mail-lj1-f173.google.com with SMTP id
 38308e7fff4ca-2bce552508fso2871051fa.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 14:00:25 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzn8f38u5xo14hYNuNIurGyYX8pxClhs3B7+hYF7yCD666fYWt9
 cPepKa8M+nd92Os7jxfLvuYQE830zwdt2uCt+A==
X-Google-Smtp-Source: AGHT+IFv6lCE+fGtNgK3kYv6M1ccl+19kAPfdjWlF3xtOGLzM78M6RmnVdbW3zISvtaBDaCWim7XM+3GGUisex3UtPE=
X-Received: by 2002:a2e:a316:0:b0:2bc:c846:aa17 with SMTP id
 l22-20020a2ea316000000b002bcc846aa17mr6012102lje.41.1692824422953; Wed, 23
 Aug 2023 14:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230821194821.2961213-1-sjg@chromium.org>
 <CAL_Jsq+jYexj8CR86cktxeiXyo7X+8i35+Ao0GBMhinVPNUoEw@mail.gmail.com>
 <CAPnjgZ1iXoiByBPvBJfOa+q7qV5mvq4yGm483TmypzSKKy5PYg@mail.gmail.com>
In-Reply-To: <CAPnjgZ1iXoiByBPvBJfOa+q7qV5mvq4yGm483TmypzSKKy5PYg@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 23 Aug 2023 16:00:10 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKCYvfme3UURPuukdmQ6BQHAPtF50vksJyQTtu7uc0cfQ@mail.gmail.com>
Message-ID: <CAL_JsqKCYvfme3UURPuukdmQ6BQHAPtF50vksJyQTtu7uc0cfQ@mail.gmail.com>
Subject: Re: [PATCH v2] schemas: Add a schema for memory map
To: Simon Glass <sjg@chromium.org>
Cc: devicetree@vger.kernel.org, Lean Sheng Tan <sheng.tan@9elements.com>, 
 Tom Rini <trini@konsulko.com>, lkml <linux-kernel@vger.kernel.org>, 
 linux-acpi@vger.kernel.org, Chiu Chasel <chasel.chiu@intel.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>, Gua Guo <gua.guo@intel.com>
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

On Tue, Aug 22, 2023 at 3:34=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Rob,
>
> On Tue, 22 Aug 2023 at 12:53, Rob Herring <robh@kernel.org> wrote:
> >
> > On Mon, Aug 21, 2023 at 2:48=E2=80=AFPM Simon Glass <sjg@chromium.org> =
wrote:
> > >
> > > The Devicespec specification skips over handling of a logical view of
> > > the memory map, pointing users to the UEFI specification.
> >
> > It's more that the DT spec defines what is not used with UEFI. If UEFI
> > covers more than the DT Spec defined, then we should look at that.
> >
> > I would look some into (IBM) PowerPC for any prior art in this area.
> > Unfortunately, not publicly documented other than any users.
>
> OK, but I'm not sure what you are looking for here. The DT (as
> currently specified) is an incomplete description of memory, for
> EFI-type firmware.

I thought this was for non-EFI based systems. Confused.

> I recall the ePAPR thing, but not much else. Any
> pointers?

ePAPR is the source of DT Spec. That was mainly FSL PPC, not IBM PPC.
There's something called SPAPR, but no public spec. Otherwise, it's
looking at arch/powerpc in the kernel.

> > > It is common to split firmware into 'Platform Init', which does the
> > > initial hardware setup and a "Payload" which selects the OS to be boo=
ted.
> > > Thus an handover interface is required between these two pieces.
> > >
> > > Where UEFI boot-time services are not available, but UEFI firmware is
> > > present on either side of this interface, information about memory us=
age
> > > and attributes must be presented to the "Payload" in some form.
> > >
> > > This aims to provide an initial schema for this mapping.
> > >
> > > Note that this is separate from the existing /memory and /reserved-me=
mory
> > > nodes, since it is mostly concerned with what the memory is used for.=
 It
> > > may cover only a small fraction of available memory, although it coul=
d be
> > > used to signal which area of memory has ECC.
> > >
> > > For now, no attempt is made to create an exhaustive binding, so there=
 are
> > > some example types lists. This can be completed once this has passed
> > > initial review.
> >
> > I don't have much interest in picking this up unless there's some
> > wider agreement. From the previously referenced discussion[1], it
> > didn't seem like there was. But none of those folk are Cc'ed here.
>
> Yes, Ron pointed me to that...although it isn't quite the same thing.
> That is implementing a way to pass SMBIOS and ACPI tables through to
> Linux, right? But it does mention memory types, so I'll send a new
> version with those people on cc, in case they don't look at linux-acpi
> much.

Both are defining regions of memory to pass from one stage to the
next. Isn't that the same thing?

> But note, this is for *firmware* (on both sides of the interface).
> Whether it is useful for Linux is another question. But in any case,
> we should avoid having things in the DT which Linux cannot validate /
> parse.

Perhaps it is easiest if firmware removes its private stuff. You can
put whatever you want into a DT and I don't care if it's not an ABI
between the components. You may still want to document things and have
a schema for other reasons.

> > > ---
> > >
> > > Changes in v2:
> > > - Reword commit message
> > >
> > >  dtschema/schemas/memory-map.yaml | 51 ++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 51 insertions(+)
> > >  create mode 100644 dtschema/schemas/memory-map.yaml
> > >
> > > diff --git a/dtschema/schemas/memory-map.yaml b/dtschema/schemas/memo=
ry-map.yaml
> > > new file mode 100644
> > > index 0000000..97e531e
> > > --- /dev/null
> > > +++ b/dtschema/schemas/memory-map.yaml
> > > @@ -0,0 +1,51 @@
> > > +# SPDX-License-Identifier: BSD-2-Clause
> > > +# Copyright 2023 Google LLC
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/memory-map.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: /memory-map nodes
> > > +description: |
> > > +  Common properties always required in /memory-map nodes. These node=
s are
> > > +  intended to resolve the nonchalant clause 3.4.1 ("/memory node and=
 UEFI")
> > > +  in the Devicetree Specification.
> > > +
> > > +maintainers:
> > > +  - Simon Glass <sjg@chromium.org>
> > > +
> > > +properties:
> > > +  $nodename:
> > > +    const: '/'
> >
> > This goes in the root node?
>
> I suppose I'm just confused about how the schema is described. I think
> it is better to have a /memory-map node with subnodes of that for each
> region.

What you need is $nodename should be "memory-map", not "/". There is
not a way to say it has to be under the root node other than adding it
to root-node.yaml.

> > > +  usage:
> > > +    $ref: /schemas/types.yaml#/definitions/string
> > > +    description: |
> > > +      Describes the usage of the memory region, e.g.:
> > > +
> > > +        "acpi-reclaim", "acpi-nvs", "bootcode", "bootdata", "bootdat=
a",
> > > +        "runtime-code", "runtime-data"
> >
> > Can't these be covered by reserved-memory? The client is free to
> > reclaim any regions if it knows what they are.
>
> I don't see that in the schema, but given what you say, it is
> definitely an option.
>
> If the reserved-memory node hiding somewhere?

The DT Spec. :)

The schema is in the kernel currently in
Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml.
I need to move it out.

> > > +  attr:
> > > +    $ref: /schemas/types.yaml#/definitions/string-array
> > > +    description: |
> > > +      Attributes possessed by this memory region:
> > > +
> > > +        "single-bit-ecc" - supports single-bit ECC
> > > +        "multi-bit-ecc" - supports multiple-bit ECC
> > > +        "no-ecc" - non-ECC memory
> >
> > Isn't this pretty much a property of a memory region as a whole. IOW,
> > couldn't it just go into /memory node(s)?
>
> Yes I think so. I wasn't sure if adding it there would break things,
> but it seems not.

There's some precedence for other things already. The spec defines the
"hotpluggable" property. lshw will parse some DIMM properties which I
think date back to PowerMacs.

Rob
