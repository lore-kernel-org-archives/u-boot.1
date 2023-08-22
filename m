Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10096EE49B1
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 20:34:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBFCC8648E;
	Tue, 22 Aug 2023 22:34:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bPZRW0Un";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4F818649F; Tue, 22 Aug 2023 22:34:40 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABF278648D
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 22:34:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5230a22cfd1so6198042a12.1
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 13:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692736477; x=1693341277;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xz9r4yHVJPlmq0FQ5zhHfDzA75nwNO0/VTx/JdIInIA=;
 b=bPZRW0UnM/HtazxdIhJKSk+wHiO0PgNwrYul+qpJSxlGcHzdWcrmadxxCf0cs20Ict
 S0gSkcIMe+mnSeapLn/9bGIPSpn1OTgWueGfUQaNBm9m18pAnc/msp5BaQ5EPXBpcVMs
 z/7GF+J4fFSiJdt82LlVy5ZlxhtjLnebLctYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692736477; x=1693341277;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xz9r4yHVJPlmq0FQ5zhHfDzA75nwNO0/VTx/JdIInIA=;
 b=fRzVWk+7IdWwunJvhCcISCz6IAdWF27Q5eoVvCaP04pAuZ7RB0LEF9s077VhlH692h
 zp09xe095VL4XjOwyH3ulxEdrXuEBlykjhJM1mcVmGfPeVLQ5wPEfVwx8GfWT2XhZ2XG
 x7C15pP6XBR0KLyGnS58WUNjbmHCWSBNrSIasADdpmWX1x0y0qtPjGRsW2I7PHHGvTRc
 FjjjuqO9IJsplEFw1m1yS2J/wiG6d1kMoZresVFMW6DMKc/ZGiY3IpWAMU9ksYkuoCJR
 UCRgvx8D4UKg4oPnjOHbyw27C0roK9h5jF4ASRhVbnXPIOejayrYVV6xyoY8tO2q3mhE
 0Cxw==
X-Gm-Message-State: AOJu0YwW9MhGF4g6YgxMYxVOwaQRcZ4EKGXq2qeSCOETLqrMQ+WmVRqB
 00tCeWWkdW7sJY0z1tqEdpBnN+QLSId1i3UC6NGEHA==
X-Google-Smtp-Source: AGHT+IE3JDNsYnOGC7CywTwIPiVA6qAVO5JKtVwDTFQL9LtR8meFQRxaAKJGESt3x7bMREUsu3Qc0knhhK10NckJvEM=
X-Received: by 2002:aa7:cd56:0:b0:523:4057:fa6e with SMTP id
 v22-20020aa7cd56000000b005234057fa6emr6171021edw.42.1692736476988; Tue, 22
 Aug 2023 13:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230821194821.2961213-1-sjg@chromium.org>
 <CAL_Jsq+jYexj8CR86cktxeiXyo7X+8i35+Ao0GBMhinVPNUoEw@mail.gmail.com>
In-Reply-To: <CAL_Jsq+jYexj8CR86cktxeiXyo7X+8i35+Ao0GBMhinVPNUoEw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 22 Aug 2023 14:34:25 -0600
Message-ID: <CAPnjgZ1iXoiByBPvBJfOa+q7qV5mvq4yGm483TmypzSKKy5PYg@mail.gmail.com>
Subject: Re: [PATCH v2] schemas: Add a schema for memory map
To: Rob Herring <robh@kernel.org>
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

Hi Rob,

On Tue, 22 Aug 2023 at 12:53, Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Aug 21, 2023 at 2:48=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > The Devicespec specification skips over handling of a logical view of
> > the memory map, pointing users to the UEFI specification.
>
> It's more that the DT spec defines what is not used with UEFI. If UEFI
> covers more than the DT Spec defined, then we should look at that.
>
> I would look some into (IBM) PowerPC for any prior art in this area.
> Unfortunately, not publicly documented other than any users.

OK, but I'm not sure what you are looking for here. The DT (as
currently specified) is an incomplete description of memory, for
EFI-type firmware. I recall the ePAPR thing, but not much else. Any
pointers?

>
> > It is common to split firmware into 'Platform Init', which does the
> > initial hardware setup and a "Payload" which selects the OS to be boote=
d.
> > Thus an handover interface is required between these two pieces.
> >
> > Where UEFI boot-time services are not available, but UEFI firmware is
> > present on either side of this interface, information about memory usag=
e
> > and attributes must be presented to the "Payload" in some form.
> >
> > This aims to provide an initial schema for this mapping.
> >
> > Note that this is separate from the existing /memory and /reserved-memo=
ry
> > nodes, since it is mostly concerned with what the memory is used for. I=
t
> > may cover only a small fraction of available memory, although it could =
be
> > used to signal which area of memory has ECC.
> >
> > For now, no attempt is made to create an exhaustive binding, so there a=
re
> > some example types lists. This can be completed once this has passed
> > initial review.
>
> I don't have much interest in picking this up unless there's some
> wider agreement. From the previously referenced discussion[1], it
> didn't seem like there was. But none of those folk are Cc'ed here.

Yes, Ron pointed me to that...although it isn't quite the same thing.
That is implementing a way to pass SMBIOS and ACPI tables through to
Linux, right? But it does mention memory types, so I'll send a new
version with those people on cc, in case they don't look at linux-acpi
much.

But note, this is for *firmware* (on both sides of the interface).
Whether it is useful for Linux is another question. But in any case,
we should avoid having things in the DT which Linux cannot validate /
parse.

>
> > ---
> >
> > Changes in v2:
> > - Reword commit message
> >
> >  dtschema/schemas/memory-map.yaml | 51 ++++++++++++++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >  create mode 100644 dtschema/schemas/memory-map.yaml
> >
> > diff --git a/dtschema/schemas/memory-map.yaml b/dtschema/schemas/memory=
-map.yaml
> > new file mode 100644
> > index 0000000..97e531e
> > --- /dev/null
> > +++ b/dtschema/schemas/memory-map.yaml
> > @@ -0,0 +1,51 @@
> > +# SPDX-License-Identifier: BSD-2-Clause
> > +# Copyright 2023 Google LLC
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/memory-map.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: /memory-map nodes
> > +description: |
> > +  Common properties always required in /memory-map nodes. These nodes =
are
> > +  intended to resolve the nonchalant clause 3.4.1 ("/memory node and U=
EFI")
> > +  in the Devicetree Specification.
> > +
> > +maintainers:
> > +  - Simon Glass <sjg@chromium.org>
> > +
> > +properties:
> > +  $nodename:
> > +    const: '/'
>
> This goes in the root node?

I suppose I'm just confused about how the schema is described. I think
it is better to have a /memory-map node with subnodes of that for each
region.

>
> > +  usage:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    description: |
> > +      Describes the usage of the memory region, e.g.:
> > +
> > +        "acpi-reclaim", "acpi-nvs", "bootcode", "bootdata", "bootdata"=
,
> > +        "runtime-code", "runtime-data"
>
> Can't these be covered by reserved-memory? The client is free to
> reclaim any regions if it knows what they are.

I don't see that in the schema, but given what you say, it is
definitely an option.

If the reserved-memory node hiding somewhere?

>
> > +  attr:
> > +    $ref: /schemas/types.yaml#/definitions/string-array
> > +    description: |
> > +      Attributes possessed by this memory region:
> > +
> > +        "single-bit-ecc" - supports single-bit ECC
> > +        "multi-bit-ecc" - supports multiple-bit ECC
> > +        "no-ecc" - non-ECC memory
>
> Isn't this pretty much a property of a memory region as a whole. IOW,
> couldn't it just go into /memory node(s)?

Yes I think so. I wasn't sure if adding it there would break things,
but it seems not.

>
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
> > +    required:
> > +      - reg
> > +
> > +additionalProperties: true
> > +
> > +...
> > --
> > 2.42.0.rc1.204.g551eb34607-goog
>
> [1] https://patches.linaro.org/project/linux-acpi/patch/20230426034001.16=
-1-cuiyunhui@bytedance.com/

I collected email addresses from that thread as best I could, and will
cc them on v3.

Regards,
Simon
