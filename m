Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A61C4167B
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 16:58:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FD76870E7;
	Tue,  7 Nov 2023 17:58:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gTT5ogct";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F4115871A0; Tue,  7 Nov 2023 17:57:58 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECE8186EF1
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 17:57:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-53e3b8f906fso9916688a12.2
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 08:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699376275; x=1699981075; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ya+2+6taOcYMazVndyG/Hpkj8Moi4Ilb8BzUHtUH9Hg=;
 b=gTT5ogct3RU/IsR57NeDmXCtleFZmV0FzqqIxKLD5KMWAk/NclKXxOYWmzwfJWOuQO
 YLB8DS31j+iQPwMIpulY6jCiYSBcRjgjjEGw2ggSgS3Vu7ZGdzmunQwUutQSXzM/DFZ6
 A/ctt8TrAs6Gkrft3KxRnJ+powck1miCVxMxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699376275; x=1699981075;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ya+2+6taOcYMazVndyG/Hpkj8Moi4Ilb8BzUHtUH9Hg=;
 b=k7135s+FbMN478sBOtkh87JVDdaJJ8fObO0aYC6QYpS3zpqLXM1biUqQ8cwluvuYOi
 HbBf9qRdBoPnkqWbyeAp2ag3pOWyni5450FYTV02a29R0bSKjvyz8+r8igrnpFm5mtif
 26tOHtyFztiwuvATUNDYiqlykC9gC1SWhCTrsBQJpeFiAGw7f2eOKIf+uPYbdx+dh23F
 eEaBExDLVathnnEIrWfg4MuA5q4fK+0c+csRFDW4c7WiPfeNtQznA8wig3zmg8xTYUPo
 GqLGKd5tQdCAR8BD9z7g++h2joUnH7Xt0XloVGfs7ZqGGwAIhc9cR3HOpzn+3J01isH7
 8YCw==
X-Gm-Message-State: AOJu0YwqgBokY2yFe56O/xyfQqPIun2ZABZShiap2dMtU9+zpnHfa9V4
 I4w4QJ8QHpQ6eqVhenbtlb1ELqvI0ahr1COpAzr5Fw==
X-Google-Smtp-Source: AGHT+IFzT0Yj7s8jOoIKBAlADODMM4QqvdtqenEKQJasAwd1/OYnUK4adWGZBt8VZ0rU0oQN8LNfYUrX0n4JLDMBEzc=
X-Received: by 2002:a50:d0d5:0:b0:542:dcb4:37f with SMTP id
 g21-20020a50d0d5000000b00542dcb4037fmr23411840edf.41.1699376275107; Tue, 07
 Nov 2023 08:57:55 -0800 (PST)
MIME-Version: 1.0
References: <20230926194242.2732127-1-sjg@chromium.org>
 <20230926194242.2732127-2-sjg@chromium.org>
 <CAPnjgZ0Xf3U1aj32LbU-xiU1AqwnM3JL1F8xX-wZ18oEmg+irw@mail.gmail.com>
 <CAMj1kXEXcX7BkDyfy-6_5Vnch=N+onza-yfWfsVaGLE93h2c+Q@mail.gmail.com>
 <CAPnjgZ2SEby-ndrs=W_afBJH56eqc=-mhp1F1nwkvWks+=B54Q@mail.gmail.com>
 <CAMj1kXED3S+0cq+VT7naBrmWrUwT=HZAaZOBRMv8Ui1Pey1QNQ@mail.gmail.com>
 <CAPnjgZ0LrsJ2_ENTYoBrnyFaH3UKdHs3D2XWY=TzBuBpBoTXZA@mail.gmail.com>
 <CAL_Jsq+DQugkEDESW5wySFbLLN8HNqGDJCio8Wpi6fe0LeHKUA@mail.gmail.com>
 <CAPnjgZ0cmKP5hoGCyQ_Rp8ZQXUVwaPYJMWyidXuOOjMVkDoMDw@mail.gmail.com>
 <CAL_JsqJH=vJ40PNTg_i0LoKA-c0hhMJkL8zCC3_bB-tOkFWWsw@mail.gmail.com>
 <CAPnjgZ1FrdGKjGAxUbkQoL2vHwhC_2Oa2KT+0cm25dQAuAjxAQ@mail.gmail.com>
 <CAPnjgZ19-xR6QxS=fR53skz0VuAty2Z2w2vQTjP7g=tbTFpaqw@mail.gmail.com>
In-Reply-To: <CAPnjgZ19-xR6QxS=fR53skz0VuAty2Z2w2vQTjP7g=tbTFpaqw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Nov 2023 09:57:35 -0700
Message-ID: <CAPnjgZ0r6yuiwmQLm-=M5mrtDqHP9J+tL7SrKYH4rtbgUxioRQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] schemas: Add some common reserved-memory usages
To: Rob Herring <robh@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, devicetree@vger.kernel.org, 
 Mark Rutland <mark.rutland@arm.com>, Lean Sheng Tan <sheng.tan@9elements.com>, 
 lkml <linux-kernel@vger.kernel.org>, Dhaval Sharma <dhaval@rivosinc.com>, 
 Maximilian Brune <maximilian.brune@9elements.com>,
 Yunhui Cui <cuiyunhui@bytedance.com>, 
 Guo Dong <guo.dong@intel.com>, Tom Rini <trini@konsulko.com>, 
 ron minnich <rminnich@gmail.com>, Gua Guo <gua.guo@intel.com>, 
 Chiu Chasel <chasel.chiu@intel.com>, linux-acpi@vger.kernel.org, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi,


On Tue, 31 Oct 2023 at 09:56, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Rob,
>
> On Mon, 16 Oct 2023 at 15:54, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Rob,
> >
> > On Mon, 16 Oct 2023 at 10:50, Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Fri, Oct 13, 2023 at 4:09=E2=80=AFPM Simon Glass <sjg@chromium.org=
> wrote:
> > > >
> > > > Hi Rob,
> > > >
> > > > On Fri, 13 Oct 2023 at 13:42, Rob Herring <robh@kernel.org> wrote:
> > > > >
> > > > > On Fri, Oct 6, 2023 at 7:03=E2=80=AFPM Simon Glass <sjg@chromium.=
org> wrote:
> > > > > >
> > > > > > Hi Ard,
> > > > > >
> > > > > > On Fri, 6 Oct 2023 at 17:00, Ard Biesheuvel <ardb@kernel.org> w=
rote:
> > > > > > >
> > > > > > > On Fri, 6 Oct 2023 at 20:17, Simon Glass <sjg@chromium.org> w=
rote:
> > > > > > > >
> > > > > > > > Hi Ard,
> > > > > > > >
> > > > > > > > On Fri, 6 Oct 2023 at 11:33, Ard Biesheuvel <ardb@kernel.or=
g> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, 2 Oct 2023 at 19:54, Simon Glass <sjg@chromium.or=
g> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi Rob,
> > > > > > > > > >
> > > > > > > > > > On Tue, 26 Sept 2023 at 13:42, Simon Glass <sjg@chromiu=
m.org> wrote:
> > > > > > > > > > >
> > > > > > > > > > > It is common to split firmware into 'Platform Init', =
which does the
> > > > > > > > > > > initial hardware setup and a "Payload" which selects =
the OS to be booted.
> > > > > > > > > > > Thus an handover interface is required between these =
two pieces.
> > > > > > > > > > >
> > > > > > > > > > > Where UEFI boot-time services are not available, but =
UEFI firmware is
> > > > > > > > > > > present on either side of this interface, information=
 about memory usage
> > > > > > > > > > > and attributes must be presented to the "Payload" in =
some form.
> > > > > > > > > > >
> > > > > > > > > > > This aims to provide an small schema addition for the=
 memory mapping
> > > > > > > > > > > needed to keep these two pieces working together well=
.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > ---
> > > > > > > > > > >
> > > > > > > > > > > Changes in v7:
> > > > > > > > > > > - Rename acpi-reclaim to acpi
> > > > > > > > > > > - Drop individual mention of when memory can be recla=
imed
> > > > > > > > > > > - Rewrite the item descriptions
> > > > > > > > > > > - Add back the UEFI text (with trepidation)
> > > > > > > > > >
> > > > > > > > > > I am again checking on this series. Can it be applied, =
please?
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > Apologies for the delay in response. I have been away.
> > > > > > > >
> > > > > > > > OK, I hope you had a nice trip.
> > > > > > > >
> > > > > > >
> > > > > > > Thanks, it was wonderful!
> > > > > > >
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Changes in v6:
> > > > > > > > > > > - Drop mention of UEFI
> > > > > > > > > > > - Use compatible strings instead of node names
> > > > > > > > > > >
> > > > > > > > > > > Changes in v5:
> > > > > > > > > > > - Drop the memory-map node (should have done that in =
v4)
> > > > > > > > > > > - Tidy up schema a bit
> > > > > > > > > > >
> > > > > > > > > > > Changes in v4:
> > > > > > > > > > > - Make use of the reserved-memory node instead of cre=
ating a new one
> > > > > > > > > > >
> > > > > > > > > > > Changes in v3:
> > > > > > > > > > > - Reword commit message again
> > > > > > > > > > > - cc a lot more people, from the FFI patch
> > > > > > > > > > > - Split out the attributes into the /memory nodes
> > > > > > > > > > >
> > > > > > > > > > > Changes in v2:
> > > > > > > > > > > - Reword commit message
> > > > > > > > > > >
> > > > > > > > > > >  .../reserved-memory/common-reserved.yaml      | 71 +=
++++++++++++++++++
> > > > > > > > > > >  1 file changed, 71 insertions(+)
> > > > > > > > > > >  create mode 100644 dtschema/schemas/reserved-memory/=
common-reserved.yaml
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/dtschema/schemas/reserved-memory/common-=
reserved.yaml b/dtschema/schemas/reserved-memory/common-reserved.yaml
> > > > > > > > > > > new file mode 100644
> > > > > > > > > > > index 0000000..f7fbdfd
> > > > > > > > > > > --- /dev/null
> > > > > > > > > > > +++ b/dtschema/schemas/reserved-memory/common-reserve=
d.yaml
> > > > > > > > > > > @@ -0,0 +1,71 @@
> > > > > > > > > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Cla=
use
> > > > > > > > > > > +%YAML 1.2
> > > > > > > > > > > +---
> > > > > > > > > > > +$id: http://devicetree.org/schemas/reserved-memory/c=
ommon-reserved.yaml#
> > > > > > > > > > > +$schema: http://devicetree.org/meta-schemas/core.yam=
l#
> > > > > > > > > > > +
> > > > > > > > > > > +title: Common memory reservations
> > > > > > > > > > > +
> > > > > > > > > > > +description: |
> > > > > > > > > > > +  Specifies that the reserved memory region can be u=
sed for the purpose
> > > > > > > > > > > +  indicated by its compatible string.
> > > > > > > > > > > +
> > > > > > > > > > > +  Clients may reuse this reserved memory if they und=
erstand what it is for,
> > > > > > > > > > > +  subject to the notes below.
> > > > > > > > > > > +
> > > > > > > > > > > +maintainers:
> > > > > > > > > > > +  - Simon Glass <sjg@chromium.org>
> > > > > > > > > > > +
> > > > > > > > > > > +allOf:
> > > > > > > > > > > +  - $ref: reserved-memory.yaml
> > > > > > > > > > > +
> > > > > > > > > > > +properties:
> > > > > > > > > > > +  compatible:
> > > > > > > > > > > +    description: |
> > > > > > > > > > > +      This describes some common memory reservations=
, with the compatible
> > > > > > > > > > > +      string indicating what it is used for:
> > > > > > > > > > > +
> > > > > > > > > > > +         acpi: Advanced Configuration and Power Inte=
rface (ACPI) tables
> > > > > > > > > > > +         acpi-nvs: ACPI Non-Volatile-Sleeping Memory=
 (NVS). This is reserved by
> > > > > > > > > > > +           the firmware for its use and is required =
to be saved and restored
> > > > > > > > > > > +           across an NVS sleep
> > > > > > > > > > > +         boot-code: Contains code used for booting w=
hich is not needed by the OS
> > > > > > > > > > > +         boot-code: Contains data used for booting w=
hich is not needed by the OS
> > > > > > > > > > > +         runtime-code: Contains code used for intera=
cting with the system when
> > > > > > > > > > > +           running the OS
> > > > > > > > > > > +         runtime-data: Contains data used for intera=
cting with the system when
> > > > > > > > > > > +           running the OS
> > > > > > > > > > > +
> > > > > > > > > > > +    enum:
> > > > > > > > > > > +      - acpi
> > > > > > > > > > > +      - acpi-nvs
> > > > > > > > > > > +      - boot-code
> > > > > > > > > > > +      - boot-data
> > > > > > > > > > > +      - runtime-code
> > > > > > > > > > > +      - runtime-data
> > > > > > > > > > > +
> > > > > > > > >
> > > > > > > > > As I mentioned a few times already, I don't think these c=
ompatibles
> > > > > > > > > should be introduced here.
> > > > > > > > >
> > > > > > > > > A reserved region has a specific purpose, and the compati=
ble should be
> > > > > > > > > more descriptive than the enum above. If the consumer doe=
s not
> > > > > > > > > understand this purpose, it should simply treat the memor=
y as reserved
> > > > > > > > > and not touch it. Alternatively, these regions can be ref=
erenced from
> > > > > > > > > other DT nodes using phandles if needed.
> > > > > > > >
> > > > > > > > We still need some description of what these regions are us=
ed for, so
> > > > > > > > that the payload can use the correct regions. I do not have=
 any other
> > > > > > > > solution to this problem. We are in v7 at present. At least=
 explain
> > > > > > > > where you want the compatible strings to be introduced.
> > > > > > > >
> > > > > > >
> > > > > > > My point is really that by themselves, these regions are not =
usable by
> > > > > > > either a payload or an OS that consumes this information. Unl=
ess there
> > > > > > > is some other information being provided (via DT I imagine) t=
hat
> > > > > > > describes how these things are supposed to be used, they are =
nothing
> > > > > > > more than memory reservations that should be honored, and pro=
viding
> > > > > > > this arbitrary set of labels is unnecessary.
> > > > > > >
> > > > > > > > What sort of extra detail are you looking for? Please be sp=
ecific and
> > > > > > > > preferably add some suggestions so I can close this out ASA=
P.
> > > > > > > >
> > > > > > >
> > > > > > > A payload or OS can do nothing with a memory reservation call=
ed
> > > > > > > 'runtime-code' it it doesn't know what is inside.
> > > > >
> > > > > Agreed. The question is WHAT runtime-code? The compatible needs t=
o answer that.
> > > > >
> > > > > For example, we have 'ramoops' as a compatible in reserved memory=
.
> > > > > That tells us *exactly* what's there. We know how to parse it. If=
 we
> > > > > know ramoops is not supported, then we know we can toss it out an=
d
> > > > > reclaim the memory.
> > > >
> > > > So if we said:
> > > >
> > > >    compatible =3D "runtime-code-efi"
> > > >
> > > > would that be OK? We seem to be in catch 22 here, because if I don'=
t
> > > > mention EFI unhappy, but if I do, Ard is unhappy.
> > >
> > > Better yes, because then it is for something specific. However, AIUI,
> > > that's setup for the OS and defining that region is already defined b=
y
> > > the EFI memory map. That's Ard's issue. If there's a need outside of
> > > the EFI to OS handoff,
> >
> > There is a need. Here is part of the commit message again. If there is
> > something else you need to know, please ask.
> >
> > >>>>
> > It is common to split firmware into 'Platform Init', which does the
> > initial hardware setup and a "Payload" which selects the OS to be boote=
d.
> > Thus an handover interface is required between these two pieces.
> >
> > Where UEFI boot-time services are not available, but UEFI firmware is
> > present on either side of this interface, information about memory usag=
e
> > and attributes must be presented to the "Payload" in some form.
> > <<<
> >
> > > then you need to define what that usecase looks
> > > like. Describe the problem rather than present your solution.
> > >
> > > If this is all specific to EDK2 then it should say that rather than
> > > 'efi'. I imagine Ard would be happier with something tied to EDK2 tha=
n
> > > *all* UEFI. Though maybe the problem could be any implementation? IDK=
.
> > > Maybe it's TF-A that needs to define where the EFI runtime services
> > > region is and that needs to be passed all the way thru to the EFI
> > > implementation? So again, define the problem.
> >
> > It is not specific to EDK2. Imagine this boot sequence:
> >
> > - Platform Init (U-Boot) starts up
> > - U-Boot uses its platform knowledge to sets some ACPI tables and put
> > various things in memory
> > - U-Boot sets up some runtime code and data for the OS
> > - U-Boot jumps to the Tianocore payload **
> > - Payload (Tianocore) wants to know where the ACPI tables are, for exam=
ple
> > - Tianocore needs to provide boot services to the OS, so needs to know
> > the memory map, etc.
> >
> > ** At this point we want to use DT to pass the required information.
> >
> > Of course, Platform Init could be coreboot or Tianocore or some
> > strange private binary. Payload could be U-Boot or something else.
> > That is the point of this effort, to build interoperability.
> >
> > >
> > > > What about the boottime code....you want to know which project it i=
s from?
> > >
> > > I think it is the same.
> > >
> > > >
> > > > +      - acpi
> > > > +      - acpi-nvs
> > > >
> > > > Those two should be enough info, right?
> > >
> > > I think so. NVS is not a term I've heard in relation to ACPI, but tha=
t
> > > may just be my limited ACPI knowledge.
> >
> > Perhaps it is only an Intel thing. It stands for Non-Volatile-Sleeping
> > Memory and it has various platform settings in a binary format that is
> > normally SoC-specific.
> >
> > >
> > > > +      - boot-code
> > > > +      - boot-data
> > > >
> > > > For these, they don't pertain to the OS, so perhaps they are OK?
> > >
> > > Hard to tell that just from the name... 'boot' could be any component
> > > involved in booting including the OS.
> >
> >  suggested that 'boot' should mean booting the OS. If the OS does lots
> > of fixup stuff at the start of it, I don't know what that is called.
> >
> > So if boot-code is no good, what do you suggest?
> >
> > Alternatively I could remove these for now, if it will help make progre=
ss.
> >
> > >
> > > > In
> > > > any case, using a generic term like this makes some sense to me. We
> > > > can always add a new compatible like "efi-boottime-services" later.=
 It
> > > > may be that the boottime services would be handled by the payload, =
so
> > > > not needed in all cases.
> > >
> > > Why later? You have a specific use in mind and I imagine Ard has
> > > thoughts on that.
> >
> > Because we don't need it right away, and just want to make some progres=
s.
> >
> > Perhaps the problem here is that Linux has tied itself up in knots
> > with its EFI stuff and DT fixups and what-not. But this is not that.
> > It is a simple handoff between two pieces of firmware, Platform Init
> > and Payload. It has nothing to do with the OS. With Tianocore they are
> > typically combined, but with this usage they are split, and we can
> > swap out one project for another on either side of the DT interface.
> >
> > I do have views on the 'EFI' opt-out with reserved-memory, if you are
> > interested, but that relates to the OS. If you are wanting to place
> > some constraints on /reserved-memory and /memory we could do that
> > e.g. that the DT and the map returned by EFI boot services must be
> > consistent. But as it is, the nodes are ignored by the OS when booting
> > with EFI, aren't they?
>
> Can this be applied, please? If there are further comments, please let me=
 know.

Any update, please?

Regards,
Simon
