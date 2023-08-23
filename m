Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 770C9EE4993
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 14:24:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7C2A863F5;
	Wed, 23 Aug 2023 16:23:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="keenKXhd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B0DC863E9; Wed, 23 Aug 2023 16:23:58 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB57B863F6
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 16:23:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ardb@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B2E5A66372
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 14:23:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B25C433AB
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 14:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692800632;
 bh=L6RLKjcjf0wClZapR3eDem9qqnd+Wm/UZw5H508dK38=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=keenKXhdWPmWW/UM6/jrm2f8lqu83XeL3axzHEty84wzUfz6iGm5yF92b4siEMhVs
 x8HPi9BfV6x6Wd1aPa7pAzzLryu8pXkMYpD9/Up/qFNIqQuYpvr/zlHw+XASC82WEU
 c5pL7lAIOfIIIfyL5s+A/KitTVzaJAfYu6FhVYR1T+WtWnQwcWVmevz60wL+ECUAoG
 21tKPiwWMQX9idR8sjPIq5gKfzDz21TiKyuCvYl3kpMHr3tBqJM6wjb9s3tJOtQX6C
 c4t8X13CnFHlr6QBpHjf69YZrPhztbdJhbAJ9TlOu22oqPw0Tjfn7+4bwFY682wkkr
 P9ohjVJcixSCA==
Received: by mail-lf1-f41.google.com with SMTP id
 2adb3069b0e04-50087d47d4dso3687864e87.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 07:23:52 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxabd6ckwM3HIEAJ6wadg54Xc935Wd6kE7EX3+YyoxmSRup0Q+X
 W2byTqjx6Wfw9jAby5/kyCM15kUX3+U3pbcwPWE=
X-Google-Smtp-Source: AGHT+IG+v0ql3xKgaaIRw2aNIMl4q7zemhhsd+/yB6IX6qUsIPOxXeEVctDDZNhBJ7VyqtLoumpqJTdkynEQuahFz/w=
X-Received: by 2002:a19:651d:0:b0:4ff:8fdd:4be4 with SMTP id
 z29-20020a19651d000000b004ff8fdd4be4mr9463042lfb.29.1692800629839; Wed, 23
 Aug 2023 07:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230822203446.4111742-1-sjg@chromium.org>
 <ZOXKTrC_dzN_hUkY@FVFF77S0Q05N>
In-Reply-To: <ZOXKTrC_dzN_hUkY@FVFF77S0Q05N>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 23 Aug 2023 16:23:38 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEHpRjk_YKOm4czCnnpjqgahj2jV8MMfGLx7b1RdnBnVw@mail.gmail.com>
Message-ID: <CAMj1kXEHpRjk_YKOm4czCnnpjqgahj2jV8MMfGLx7b1RdnBnVw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] schemas: Add a schema for memory map
To: Mark Rutland <mark.rutland@arm.com>
Cc: Simon Glass <sjg@chromium.org>, devicetree@vger.kernel.org, 
 Rob Herring <robh@kernel.org>, Chiu Chasel <chasel.chiu@intel.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>, Gua Guo <gua.guo@intel.com>,
 linux-acpi@vger.kernel.org, 
 lkml <linux-kernel@vger.kernel.org>, Yunhui Cui <cuiyunhui@bytedance.com>, 
 ron minnich <rminnich@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Lean Sheng Tan <sheng.tan@9elements.com>
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

On Wed, 23 Aug 2023 at 10:59, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, Aug 22, 2023 at 02:34:42PM -0600, Simon Glass wrote:
> > The Devicetree specification skips over handling of a logical view of
> > the memory map, pointing users to the UEFI specification.
> >
> > It is common to split firmware into 'Platform Init', which does the
> > initial hardware setup and a "Payload" which selects the OS to be booted.
> > Thus an handover interface is required between these two pieces.
> >
> > Where UEFI boot-time services are not available, but UEFI firmware is
> > present on either side of this interface, information about memory usage
> > and attributes must be presented to the "Payload" in some form.

Not quite.

This seems to be intended for consumption by Linux booting in ACPI
mode, but not via UEFI, right? Some proposed changes to support that
were rejected on the basis that ACPI on non-x86 is strictly tied to
ACPI boot, not only because the ACPI root table (rsdp) can only be
discovered via UEFI, but also because the ACPI subsystem in Linux
cross-references any memory mappings created from AML code against the
UEFI memory map.

Unfortunately, having a vague, non-exhaustive approximation of the
UEFI memory map is unlikely to be sufficient here. The existing logic
assumes that addresses not covered by the UEFI memory map are MMIO,
which means that either a) the UEFI memory map needs to describe all
RAM exhaustively or b) the existing logic needs to be modified to take
memblock or other information sources into account as well in order to
reason about whether a certain address requires device or normal
memory attributes.

Note that the ACPI spec only lists EFI as a valid way to obtain the
root table pointer on architectures other than x86. If other ways are
needed, they should be contributed to the spec, rather than being
added to Linux as an ad hoc workaround for bootloaders that have
trouble implementing the spec as is.

>
> Today Linux does that by passing:
>
>   /chosen/linux,uefi-mmap-start
>   /chosen/linux,uefi-mmap-size
>   /chosen/linux,uefi-mmap-desc-size
>   /chosen/linux,uefi-mmap-desc-ver
>
> ... or /chosen/xen,* variants of those.
>
> Can't we document / genericise that?
>

Given the ACPI angle, promoting this to external ABI would introduce a
DT dependency to ACPI boot. So we'll at least have to be very clear
about which takes precedence, or maybe disregard everything except the
/chosen node when doing ACPI boot?

This also argues for not creating an ordinary binding for this (i.e.,
describing it as part of the platform topology), but putting it under
/chosen as a Linux-only boot tweak.

> Pointing to that rather than re-encoding it in DT means that it stays in-sync
> with the EFI spec and we won't back ourselves into a corner where we cannot
> encode something due to a structural difference. I don't think it's a good idea
> to try to re-encode it, or we're just setting ourselves up for futher pain.
>

What I would prefer is to formalize pseudo-EFI boot and define the
bare required minimum (system table + memory map + config tables) in
an arch-agnostic manner. That way, the only thing that needs to be
passed via DT/boot_params/etc is the (pseudo-)EFI system table
address, and everything else (SMBIOS, ACPI as well as the EFI memory
map and even the initrd) can be passed via config tables as usual, all
of which is already supported in (mostly) generic kernel code.

This means that booting via the EFI stub would not be required, nor is
implementing boot services or runtime services or any of the other
things that people appear to hate with such a passion.

I'd actually prefer not to use those /chosen DT nodes, but pass the
memory map via a config table. This, however, requires* that the
runtime services memory regions are mapped 1:1 so it is not something
we can do for all currently supported systems. But for pseudo-EFI
boot, stipulating 1:1 runtime mappings is fine (or no runtime mappings
at all if the firmware does not expose runtime services)

* SetVirtualAddressMap() relocates the config table array, and without
a memory map, it is not possible to convert those address back to
physical. SetVirtualAddressMap() is evil and needs to die, but this is
off-topic for the thread at hand.

> >
> > This aims to provide an initial schema for this mapping.
> >
> > Note that this is separate from the existing /memory and /reserved-memory
> > nodes, since it is mostly concerned with what the memory is used for. It
> > may cover only a small fraction of available memory.
> >
> > For now, no attempt is made to create an exhaustive binding, so there are
> > some example types listed. This can be completed once this has passed
> > initial review.
> >
> > This binding does not include a binding for the memory 'attribute'
> > property, defined by EFI_BOOT_SERVICES.GetMemoryMap(). It may be useful
> > to have that as well, but perhaps not as a bit mask.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v3:
> > - Reword commit message again
> > - cc a lot more people, from the FFI patch
> > - Split out the attributes into the /memory nodes
> >
> > Changes in v2:
> > - Reword commit message
> >
> >  dtschema/schemas/memory-map.yaml | 61 ++++++++++++++++++++++++++++++++
> >  1 file changed, 61 insertions(+)
> >  create mode 100644 dtschema/schemas/memory-map.yaml
> >
> > diff --git a/dtschema/schemas/memory-map.yaml b/dtschema/schemas/memory-map.yaml
> > new file mode 100644
> > index 0000000..4b06583
> > --- /dev/null
> > +++ b/dtschema/schemas/memory-map.yaml
> > @@ -0,0 +1,61 @@
> > +# SPDX-License-Identifier: BSD-2-Clause
> > +# Copyright 2023 Google LLC
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/memory-map.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: /memory-map nodes
> > +description: |
> > +  Common properties always required in /memory-map nodes. These nodes are
> > +  intended to resolve the nonchalant clause 3.4.1 ("/memory node and UEFI")
> > +  in the Devicetree Specification.
> > +
> > +maintainers:
> > +  - Simon Glass <sjg@chromium.org>
> > +
> > +properties:
> > +  $nodename:
> > +    const: 'memory-map'
> > +
> > +patternProperties:
> > +  "^([a-z][a-z0-9\\-]+@[0-9a-f]+)?$":
> > +    type: object
> > +    additionalProperties: false
> > +
> > +    properties:
> > +      reg:
> > +        minItems: 1
> > +        maxItems: 1024
> > +
> > +      usage:
> > +        $ref: /schemas/types.yaml#/definitions/string
> > +        description: |
> > +          Describes the usage of the memory region, e.g.:
> > +
> > +            "acpi-reclaim", "acpi-nvs", "bootcode", "bootdata", "bootdata",
> > +            "runtime-code", "runtime-data".
> > +
> > +            See enum EFI_MEMORY_TYPE in "Unified Extensible Firmware Interface
> > +            (UEFI) Specification" for all the types. For now there are not
> > +            listed here.
> > +
> > +    required:
> > +      - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    memory-map {
> > +        acpi@f0000 {
> > +            reg = <0xf0000 0x4000>;
> > +            usage = "acpi-reclaim";
> > +        };
> > +
> > +        runtime@12300000 {
> > +            reg = <0x12300000 0x28000>;
> > +            usage = "runtime-code";
> > +        };
> > +    };
> > +...
> > --
> > 2.42.0.rc1.204.g551eb34607-goog
> >
