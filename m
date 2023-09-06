Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C4CEE14A1
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 14:54:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36D52866DA;
	Wed,  6 Sep 2023 16:54:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ieWFb20L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3458486907; Wed,  6 Sep 2023 16:54:00 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C95B865A0
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 16:53:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9a6190af24aso579332566b.0
 for <u-boot@lists.denx.de>; Wed, 06 Sep 2023 07:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694012036; x=1694616836; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=heM2WIdgYwpyKdVMhVOdDsIpHChYmeGvTy53ja7Lcs8=;
 b=ieWFb20LXaIYCFMoBPx1meYtT01YQfjF0M8DGw2ZHnl1z+TvpobhwBi3ePSdCnQaoT
 1NKCcKn4t0RzGDmHE3Hh4LsrptPEX9TFwKO0qrcp9d6mu1tS05ZpBza9HOJjVlU6F9bd
 Ng3HqA8GaWlB9MKdoHX9ZJxUe8GXP1vs00lcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694012036; x=1694616836;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=heM2WIdgYwpyKdVMhVOdDsIpHChYmeGvTy53ja7Lcs8=;
 b=fcpqjQaN64i/A/2EjgFqTQa88Yfue1By1MX8VeXN2Faj+ZZnS2v3B2m0V1KyrIA9As
 S8LlzYRZusiVHGfnVglX7OqS3OpJdQ3OYqsxUIUBAR1pY8SvEjNswG3GAxwJQM1fSoYY
 fZuz+Zd3iYYZO/49H25tGHIdEe5Fux00wKcvCiJlrKCDYssT3q2VLjuHfGgxOML7dUuE
 32onWUJ+LgpMMq2Zknh+VRgmsfVm0szmhZpgQomWfWzhyEhtROnzKifyNLxs1ODKhbxw
 yqr0tRKtHAhoDDpFFdDtBdr5+8Tm4lcG1BjEQf4sulpLsnqr/6A0gzu6oiMI6F3MH2oQ
 hGpg==
X-Gm-Message-State: AOJu0YyuS2rY0XaokcYJ776iv6ofp9CijETC5t7Yf5nGhaM8l08nc8dH
 HSIydVRUzXEyxpT497Wp9qtPjHE29Odg2T+IjQfhPg==
X-Google-Smtp-Source: AGHT+IEU5UffRYUvDwA0NQm7JOuEQu6yerz5z3/Mhzsxu8B4Hq3armkLEjFFu6wwdpmajrU9Sup7CUTnJTt9lIFlQHI=
X-Received: by 2002:a17:906:10c:b0:9a5:bce9:ffb7 with SMTP id
 12-20020a170906010c00b009a5bce9ffb7mr2596750eje.19.1694012036398; Wed, 06 Sep
 2023 07:53:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230830231758.2561402-1-sjg@chromium.org>
 <20230830231758.2561402-3-sjg@chromium.org>
 <CAMj1kXG5-aqoOtKdPFEdm=_5SdvgUTOhcDOBP1zdARAvKphJtg@mail.gmail.com>
 <CAL_JsqLx0KnXxFc8mFyT_RmA2qeBEutMXj_3nKo_g==cuSeYuQ@mail.gmail.com>
In-Reply-To: <CAL_JsqLx0KnXxFc8mFyT_RmA2qeBEutMXj_3nKo_g==cuSeYuQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 6 Sep 2023 08:53:44 -0600
Message-ID: <CAPnjgZ1U+Gy0Q_Sc63p0ixkWF9iJEEBLhV8-N9-sh7OGNy-OmQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] schemas: Add some common reserved-memory usages
To: Rob Herring <robh@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, devicetree@vger.kernel.org, 
 Maximilian Brune <maximilian.brune@9elements.com>,
 ron minnich <rminnich@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Dhaval Sharma <dhaval@rivosinc.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>, Mark Rutland <mark.rutland@arm.com>,
 Yunhui Cui <cuiyunhui@bytedance.com>, linux-acpi@vger.kernel.org, 
 Gua Guo <gua.guo@intel.com>, Lean Sheng Tan <sheng.tan@9elements.com>, 
 Guo Dong <guo.dong@intel.com>, lkml <linux-kernel@vger.kernel.org>, 
 Chiu Chasel <chasel.chiu@intel.com>
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

Hi Rob, Ard,

On Wed, 6 Sept 2023 at 08:34, Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Sep 5, 2023 at 4:44=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> w=
rote:
> >
> > On Thu, 31 Aug 2023 at 01:18, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > The Devicetree specification skips over handling of a logical view of
> > > the memory map, pointing users to the UEFI specification.
> > >
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
> >
> > I don't think the UEFI references are needed or helpful here.
> >
> > > This aims to provide an small schema addition for this mapping.
> > >
> > > For now, no attempt is made to create an exhaustive binding, so there=
 are
> > > some example types listed. More can be added later.
> > >
> > > The compatible string is not included, since the node name is enough =
to
> > > indicate the purpose of a node, as per the existing reserved-memory
> > > schema.
>
> Node names reflect the 'class', but not what's specifically in the
> node. So really, all reserved-memory nodes should have the same name,
> but that ship already sailed for existing users. 'compatible' is the
> right thing here. As to what the node name should be, well, we haven't
> defined that. I think we just used 'memory' on some platforms.

OK

>
> > > This binding does not include a binding for the memory 'attribute'
> > > property, defined by EFI_BOOT_SERVICES.GetMemoryMap(). It may be usef=
ul
> > > to have that as well, but perhaps not as a bit mask.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > Changes in v5:
> > > - Drop the memory-map node (should have done that in v4)
> > > - Tidy up schema a bit
> > >
> > > Changes in v4:
> > > - Make use of the reserved-memory node instead of creating a new one
> > >
> > > Changes in v3:
> > > - Reword commit message again
> > > - cc a lot more people, from the FFI patch
> > > - Split out the attributes into the /memory nodes
> > >
> > > Changes in v2:
> > > - Reword commit message
> > >
> > >  .../reserved-memory/common-reserved.yaml      | 53 +++++++++++++++++=
++
> > >  1 file changed, 53 insertions(+)
> > >  create mode 100644 dtschema/schemas/reserved-memory/common-reserved.=
yaml
> > >
> > > diff --git a/dtschema/schemas/reserved-memory/common-reserved.yaml b/=
dtschema/schemas/reserved-memory/common-reserved.yaml
> > > new file mode 100644
> > > index 0000000..d1b466b
> > > --- /dev/null
> > > +++ b/dtschema/schemas/reserved-memory/common-reserved.yaml
> > > @@ -0,0 +1,53 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/reserved-memory/common-reserved.y=
aml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Common memory reservations
> > > +
> > > +description: |
> > > +  Specifies that the reserved memory region can be used for the purp=
ose
> > > +  indicated by its node name.
> > > +
> > > +  Clients may reuse this reserved memory if they understand what it =
is for.
> > > +
> > > +maintainers:
> > > +  - Simon Glass <sjg@chromium.org>
> > > +
> > > +allOf:
> > > +  - $ref: reserved-memory.yaml
> > > +
> > > +properties:
> > > +  $nodename:
> > > +    enum:
> > > +      - acpi-reclaim
> > > +      - acpi-nvs
> > > +      - boot-code
> > > +      - boot-data
> > > +      - runtime-code
> > > +      - runtime-data
> > > +
> >
> > These types are used by firmware to describe the nature of certain
> > memory regions to the OS. Boot code and data can be discarded, as well
> > as ACPI reclaim after its contents have been consumed. Runtime code
> > and data need to be mapped for runtime features to work.
> >
> > When one firmware phase communicates the purpose of a certain memory
> > reservation to another, it is typically not limited to whether its
> > needs to be preserved and when it needs to be mapped (and with which
> > attributes). I'd expect a memory reservation appearing under this node
> > to have a clearly defined purpose, and the subsequent phases need to
> > be able to discover this information.
> >
> > For example, a communication buffer for secure<->non-secure
> > communication or a page with spin tables used by PSCI. None of the
> > proposed labels are appropriate for this, and I'd much rather have a
> > compatible string or some other property that clarifies the nature in
> > a more suitable way. Note that 'no-map' already exists to indicate
> > that the CPU should not map this memory unless it does so for the
> > specific purpose that the reservation was made for.
>
> I agree. I think compatible is the better approach. Some property like
> 'discard' may not be sufficient information if the OS needs to consume
> the region first and then discard it. Better to state exactly what's
> there and then the OS can imply the rest.

OK, so what sort of compatible strings?

How about:
"acpi-reclaim" - holds ACPI tables; memory can be reclaimed once the
tables are read and no-longer needed
"boot-code" - holds boot code; memory can be reclaimed once the boot
phase is complete
"runtime-code" - holds runtime code; memory can be reclaimed only if
this code will not be used from that point

etc. We can then have more specific compatibles, like:

"psci-spin-table" - holds PSCI spin tables

so you could do:

compatible =3D "runtime-code", "psci-spin-table";

Regards,
Simon
