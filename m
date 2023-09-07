Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A50EC8734
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 14:50:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDFA986863;
	Thu,  7 Sep 2023 16:50:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ay6JgVsm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5BA7869B5; Thu,  7 Sep 2023 16:50:26 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6769B86722
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 16:50:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3ab244e7113so707912b6e.3
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 07:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694098222; x=1694703022; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sAsUek4rRB5i1GAfjkgZBmGSLTRpHX956NVUEoy+33g=;
 b=ay6JgVsmIIFnAK7jlJQ7hGaCif/XeU1glQXBgoF7a+oXtnezSy/i7gwY8eVpzaTZJq
 ngyIiD7k6VoKUIuQ3GgXT9kJfeYDn1O29HHqqpNDS+BAGOk7aSVweMCpapzm3LFQt5U2
 x3TTQU2PCk0cp5qP8tX2GWwV7gLmKi7drNNJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694098222; x=1694703022;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sAsUek4rRB5i1GAfjkgZBmGSLTRpHX956NVUEoy+33g=;
 b=d3pRW7PffOOFiFH9HAVhJC4gVXyU7gQQzmFsPV1RkStCtit9DMMFIAQblfxuVmrMDN
 NewPfrjs9Ig/PzuO5JuvcwT+WTFCTE7Y/Dj70iYGvE9s7h81R49HqMT5A6j2nZu6xPe0
 Inkd9S6250UB/TPvBGWoI1xfcOzMliqED/qC58X4P9yvMt8HAuHCpaHu7LFw0qJjeI2e
 X/jbMJoc7kTCmSbCHU1nuZ/yNKJ3lYSZHvmMrslvVtaqFcCPho48xmb9rFBHxP2+GTSP
 IbNCyv5liO1SkNArMwtBi4YfM7bJstj+sEx8b56FxyIfPZcP/rnP6pg9g//ze5SeXbBG
 Lu3g==
X-Gm-Message-State: AOJu0Yxv4zdpaICxiM0cvzZslMgIHxzYVDPdVa3Y6/QlMx5UCmeSgLwW
 6y92FxosuhEpe+1mnW+HrYGEjZTTiqvBgwdyIqOFzA==
X-Google-Smtp-Source: AGHT+IHXYgVOnAZiETy3nJZ4DUuVhJT00UfRP/E+34Fp31Gnu1ibFFdaW0tjDIdjWplOnmORsgHlwIbMMRaOZgkfZpQ=
X-Received: by 2002:a05:6808:1288:b0:3a7:38c5:bc18 with SMTP id
 a8-20020a056808128800b003a738c5bc18mr26683493oiw.32.1694098221713; Thu, 07
 Sep 2023 07:50:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230830231758.2561402-1-sjg@chromium.org>
 <20230830231758.2561402-3-sjg@chromium.org>
 <CAMj1kXG5-aqoOtKdPFEdm=_5SdvgUTOhcDOBP1zdARAvKphJtg@mail.gmail.com>
 <CAL_JsqLx0KnXxFc8mFyT_RmA2qeBEutMXj_3nKo_g==cuSeYuQ@mail.gmail.com>
 <CAPnjgZ1U+Gy0Q_Sc63p0ixkWF9iJEEBLhV8-N9-sh7OGNy-OmQ@mail.gmail.com>
 <CAMj1kXG9vM0haSOu19j7ujQCBEN6CBeXVAH96nm+gixt9FmMrA@mail.gmail.com>
 <CAPnjgZ1oGF0Ni3RhK4fv6mJk40YjqyFVJxt6FfS9AW2rkcs9iA@mail.gmail.com>
 <CAMj1kXEZ4fDvbtgXKjF+L7si-=C-5E0XcjutoEF8pU9a-BGN-g@mail.gmail.com>
 <CAPnjgZ0vv+s00xvY2FqP+Fxb12tHuVWg-nwyWTrvuG+Mo4PaWg@mail.gmail.com>
 <CAMj1kXHGpCt8qkd6XYQF8mMdivQkTnEWjv6NzsFK=+N72LAn=Q@mail.gmail.com>
In-Reply-To: <CAMj1kXHGpCt8qkd6XYQF8mMdivQkTnEWjv6NzsFK=+N72LAn=Q@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 Sep 2023 08:50:02 -0600
Message-ID: <CAPnjgZ1vBaXfBa+FWvASi15=Py0DLbEK5XsRHLrJc02K2Yr_RQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] schemas: Add some common reserved-memory usages
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
 Devicetree Discuss <devicetree@vger.kernel.org>, 
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

Hi Ard,

On Thu, 7 Sept 2023 at 08:12, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 7 Sept 2023 at 15:56, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ard,
> >
> > On Thu, 7 Sept 2023 at 07:31, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Wed, 6 Sept 2023 at 18:50, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Ard,
> > > >
> > > > On Wed, Sep 6, 2023, 10:09 Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >>
> > > >> On Wed, 6 Sept 2023 at 16:54, Simon Glass <sjg@chromium.org> wrote=
:
> > > >> >
> > > >> > Hi Rob, Ard,
> > > >> >
> > > >> > On Wed, 6 Sept 2023 at 08:34, Rob Herring <robh@kernel.org> wrot=
e:
> > > >> > >
> > > >> > > On Tue, Sep 5, 2023 at 4:44=E2=80=AFPM Ard Biesheuvel <ardb@ke=
rnel.org> wrote:
> > > >> > > >
> > > >> > > > On Thu, 31 Aug 2023 at 01:18, Simon Glass <sjg@chromium.org>=
 wrote:
> > > >> > > > >
> > > >> > > > > The Devicetree specification skips over handling of a logi=
cal view of
> > > >> > > > > the memory map, pointing users to the UEFI specification.
> > > >> > > > >
> > > >> > > > > It is common to split firmware into 'Platform Init', which=
 does the
> > > >> > > > > initial hardware setup and a "Payload" which selects the O=
S to be booted.
> > > >> > > > > Thus an handover interface is required between these two p=
ieces.
> > > >> > > > >
> > > >> > > > > Where UEFI boot-time services are not available, but UEFI =
firmware is
> > > >> > > > > present on either side of this interface, information abou=
t memory usage
> > > >> > > > > and attributes must be presented to the "Payload" in some =
form.
> > > >> > > > >
> > > >> > > >
> > > >> > > > I don't think the UEFI references are needed or helpful here=
.
> > > >> > > >
> > > >> > > > > This aims to provide an small schema addition for this map=
ping.
> > > >> > > > >
> > > >> > > > > For now, no attempt is made to create an exhaustive bindin=
g, so there are
> > > >> > > > > some example types listed. More can be added later.
> > > >> > > > >
> > > >> > > > > The compatible string is not included, since the node name=
 is enough to
> > > >> > > > > indicate the purpose of a node, as per the existing reserv=
ed-memory
> > > >> > > > > schema.
> > > >> > >
> > > >> > > Node names reflect the 'class', but not what's specifically in=
 the
> > > >> > > node. So really, all reserved-memory nodes should have the sam=
e name,
> > > >> > > but that ship already sailed for existing users. 'compatible' =
is the
> > > >> > > right thing here. As to what the node name should be, well, we=
 haven't
> > > >> > > defined that. I think we just used 'memory' on some platforms.
> > > >> >
> > > >> > OK
> > > >> >
> > > >> > >
> > > >> > > > > This binding does not include a binding for the memory 'at=
tribute'
> > > >> > > > > property, defined by EFI_BOOT_SERVICES.GetMemoryMap(). It =
may be useful
> > > >> > > > > to have that as well, but perhaps not as a bit mask.
> > > >> > > > >
> > > >> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > >> > > > > ---
> > > >> > > > >
> > > >> > > > > Changes in v5:
> > > >> > > > > - Drop the memory-map node (should have done that in v4)
> > > >> > > > > - Tidy up schema a bit
> > > >> > > > >
> > > >> > > > > Changes in v4:
> > > >> > > > > - Make use of the reserved-memory node instead of creating=
 a new one
> > > >> > > > >
> > > >> > > > > Changes in v3:
> > > >> > > > > - Reword commit message again
> > > >> > > > > - cc a lot more people, from the FFI patch
> > > >> > > > > - Split out the attributes into the /memory nodes
> > > >> > > > >
> > > >> > > > > Changes in v2:
> > > >> > > > > - Reword commit message
> > > >> > > > >
> > > >> > > > >  .../reserved-memory/common-reserved.yaml      | 53 ++++++=
+++++++++++++
> > > >> > > > >  1 file changed, 53 insertions(+)
> > > >> > > > >  create mode 100644 dtschema/schemas/reserved-memory/commo=
n-reserved.yaml
> > > >> > > > >
> > > >> > > > > diff --git a/dtschema/schemas/reserved-memory/common-reser=
ved.yaml b/dtschema/schemas/reserved-memory/common-reserved.yaml
> > > >> > > > > new file mode 100644
> > > >> > > > > index 0000000..d1b466b
> > > >> > > > > --- /dev/null
> > > >> > > > > +++ b/dtschema/schemas/reserved-memory/common-reserved.yam=
l
> > > >> > > > > @@ -0,0 +1,53 @@
> > > >> > > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > >> > > > > +%YAML 1.2
> > > >> > > > > +---
> > > >> > > > > +$id: http://devicetree.org/schemas/reserved-memory/common=
-reserved.yaml#
> > > >> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > >> > > > > +
> > > >> > > > > +title: Common memory reservations
> > > >> > > > > +
> > > >> > > > > +description: |
> > > >> > > > > +  Specifies that the reserved memory region can be used f=
or the purpose
> > > >> > > > > +  indicated by its node name.
> > > >> > > > > +
> > > >> > > > > +  Clients may reuse this reserved memory if they understa=
nd what it is for.
> > > >> > > > > +
> > > >> > > > > +maintainers:
> > > >> > > > > +  - Simon Glass <sjg@chromium.org>
> > > >> > > > > +
> > > >> > > > > +allOf:
> > > >> > > > > +  - $ref: reserved-memory.yaml
> > > >> > > > > +
> > > >> > > > > +properties:
> > > >> > > > > +  $nodename:
> > > >> > > > > +    enum:
> > > >> > > > > +      - acpi-reclaim
> > > >> > > > > +      - acpi-nvs
> > > >> > > > > +      - boot-code
> > > >> > > > > +      - boot-data
> > > >> > > > > +      - runtime-code
> > > >> > > > > +      - runtime-data
> > > >> > > > > +
> > > >> > > >
> > > >> > > > These types are used by firmware to describe the nature of c=
ertain
> > > >> > > > memory regions to the OS. Boot code and data can be discarde=
d, as well
> > > >> > > > as ACPI reclaim after its contents have been consumed. Runti=
me code
> > > >> > > > and data need to be mapped for runtime features to work.
> > > >> > > >
> > > >> > > > When one firmware phase communicates the purpose of a certai=
n memory
> > > >> > > > reservation to another, it is typically not limited to wheth=
er its
> > > >> > > > needs to be preserved and when it needs to be mapped (and wi=
th which
> > > >> > > > attributes). I'd expect a memory reservation appearing under=
 this node
> > > >> > > > to have a clearly defined purpose, and the subsequent phases=
 need to
> > > >> > > > be able to discover this information.
> > > >> > > >
> > > >> > > > For example, a communication buffer for secure<->non-secure
> > > >> > > > communication or a page with spin tables used by PSCI. None =
of the
> > > >> > > > proposed labels are appropriate for this, and I'd much rathe=
r have a
> > > >> > > > compatible string or some other property that clarifies the =
nature in
> > > >> > > > a more suitable way. Note that 'no-map' already exists to in=
dicate
> > > >> > > > that the CPU should not map this memory unless it does so fo=
r the
> > > >> > > > specific purpose that the reservation was made for.
> > > >> > >
> > > >> > > I agree. I think compatible is the better approach. Some prope=
rty like
> > > >> > > 'discard' may not be sufficient information if the OS needs to=
 consume
> > > >> > > the region first and then discard it. Better to state exactly =
what's
> > > >> > > there and then the OS can imply the rest.
> > > >> >
> > > >> > OK, so what sort of compatible strings?
> > > >> >
> > > >> > How about:
> > > >> > "acpi-reclaim" - holds ACPI tables; memory can be reclaimed once=
 the
> > > >> > tables are read and no-longer needed
> > > >>
> > > >> ACPI reclaim is a policy, not a purpose. This memory could contain
> > > >> many different things.
> > > >>
> > > >> > "boot-code" - holds boot code; memory can be reclaimed once the =
boot
> > > >> > phase is complete
> > > >> > "runtime-code" - holds runtime code; memory can be reclaimed onl=
y if
> > > >> > this code will not be used from that point
> > > >> >
> > > >>
> > > >> These are also policies. They can be inferred from the purpose.
> > > >>
> > > >> > etc. We can then have more specific compatibles, like:
> > > >> >
> > > >> > "psci-spin-table" - holds PSCI spin tables
> > > >> >
> > > >> > so you could do:
> > > >> >
> > > >> > compatible =3D "runtime-code", "psci-spin-table";
> > > >> >
> > > >>
> > > >> I understand that this binding targets firmware<->firmware rather =
than
> > > >> firmware<->OS, which makes it much more difficult to keep it both
> > > >> generic and sufficiently descriptive.
> > > >>
> > > >> However, I still feel that all the overlap with UEFI memory types =
is
> > > >> not what we want here. UEFI knows how to manage its own memory map=
,
> > > >> what it needs to know is what memory is already in use and for whi=
ch
> > > >> exact purpose. Whether or not that implies that the memory can be
> > > >> freed at some point or can be mapped or not should follow from tha=
t.
> > > >
> > > >
> > > > Can you please make a suggestion? I am unsure what you are looking =
for.
> > > >
> > >
> > > I'm happy to help flesh this out, but you still have not provided us
> > > with an actual use case, so I can only draw from my own experience
> > > putting together firmware for virtual and physical ARM machines.
> >
> > I did explain that this is needed when Tianocore is on both sides of
> > the interface, since Platform Init places some things in memory and
> > the Payload needs to preserve them there, and/or know where they are.
> >
> > I think the problem might be that you don't agree with that, but it
> > seems to be a fact, so I am not sure how I can alter it.
> >
> > Please can you clearly explain which part of the use case you are missi=
ng.
> >
>
> 'Tianocore on both sides of the interface' means that Tianocore runs
> as the platform init code, and uses a bespoke DT based protocol to
> launch another instance of Tianocore as the payload, right?

Not another instance, no. Just the other half of Tianocore. The first
half does platform init and the second half does the loading of the
OS.

>
> Tianocore/EDK2 already implements methods to reinvoke itself if needed
> (e.g., during a firmware update), and does so by launching a new DXE
> core. So the boot sequence looks like
>
> SEC -> PEI -> DXE -> BDS -> app that invokes UpdateCapsule() -> DXE ->
> firmware update
>
> So please elaborate on how this Tianocore on both sides of the
> interface is put together when it uses this DT based handover. We
> really need a better understanding of this in order to design a DT
> binding that meets its needs.

Are you familiar with building Tianocore as a coreboot payload, for
example? That shows Tianocore running as just the Payload, with
coreboot doing the platform init. So the use case I am talking about
is similar to that.

>
> ...
> > >
> > > So on one side, there is the requirement for each memory reservation
> > > to be described with sufficient detail so that a subsequent boot stag=
e
> > > (firmware or OS) can use it for its intended purpose, provided that
> > > this boot stage is aware of its purpose (i.e., it has a driver that
> > > matches on the compatible string in question, and actually maps/uses
> > > the memory)
> > >
> > > On the other side, we need to describe how a memory reservation shoul=
d
> > > be treated if the boot stage doesn't know its purpose, has no interes=
t
> > > in using it or has consumed the contents and has no longer a need for
> > > the region. We already have no-map to describe that the memory should
> > > never be mapped (and this may be disregarded by an actual driver for
> > > the region). I imagine we might add 'discardable' as a boolean DT
> > > property, meaning that stage N may use the memory whichever way it
> > > wants if it is not going to use it for its intended purpose, provided
> > > that it deletes the node from the DT before passing it on to stage
> > > N+1.
> >
> > OK. For now I think that everything is discardable, so long as the
> > Payload knows the purpose and that it not needed. That is what Rob
> > seemed to be saying. If we add 'discardable', does that mean that
> > things default to non-discardable? Would that not be a change of
> > behaviour for existing users?
> >
>
> Excellent question. I always assumed that /reserved-memory nodes with
> a defined base address would be honored regardless.

OK, anyway I think we can park that for now so as not to add more
loose ends here.

>
> > >
> > > One thing that needs to be clarified is how this binding interacts
> > > with /memory nodes. I assume that currently, /reserved-memory is
> > > independent, i.e., it could describe mappable memory that is not
> > > covered by /memory at all. If this is the case, we have to decide
> > > whether or not discardable regions can be treated in the same way, or
> > > whether we should require that discardable regions are covered by
> > > /memory.
> >
> > I would expect all memory to be described in /memory nodes. What is
> > the use case for omitting it? Are you thinking of SRAM, etc?
> >
>
> Indeed.
>
> For example, the SynQuacer platform has SRAM that it uses for
> platform-specific purposes (early stack and heap, passing information
> between secure and non-secure at boot), but it is not wired into the
> hardware cache coherency protocol, so it only tolerates non-shareable
> mappings. Describing this as discardable would be accurate (given that
> it is only used early in the boot), but that doesn't mean it can be
> used as general purpose memory by the OS.

OK.

Regards,
Simon
