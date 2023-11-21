Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15956C5AD4C
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 02:12:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C48B3870F8;
	Tue, 21 Nov 2023 03:12:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="f0uxTc2g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF9C3869F6; Tue, 21 Nov 2023 03:12:31 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21BBB875D6
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 03:12:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-991c786369cso693078466b.1
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 18:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700532747; x=1701137547; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9oErZSNPpRWj6cWya6fUNKL2baOOgkbfElqn5bDFEVg=;
 b=f0uxTc2g+bM8emomnLjI1stwZscbCpuDPArShPFv+AfmQ7PpHl/CayNfLDWQVWQ86m
 UkIvIwEhaYWtH3FQCZSxCiLOm6/9GhsPfYudHNm7qXJlgfhPsegJGu+jzt6x7dIiR1vq
 KWgECP9GHhBQltQJh6KSEsa+3DoZOZyLjAFgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700532747; x=1701137547;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9oErZSNPpRWj6cWya6fUNKL2baOOgkbfElqn5bDFEVg=;
 b=cIIjt9h0kxEbrSg77IdPCmYNeVx2wzPX8JtUDZUMKCjeUlEDFyPtHoK/O1lVa+QwQl
 EyLk7X18M3T3jFDKoltwIntFf/Y0G16w7E++0DrQFheFSiXGxPa4wnbOATLHZKCnoIlP
 BkrGVbPFz7GzyC4Hrx4T208zBckxzA+Hi1rPh1E7HYLYRLwxhPyq8B6s05AXphIQOPKs
 RDn0FnqDnS7WETIoz8r/mXYFE0xUVZYEniv7uFu/Skz7FQcbCEd6eqhxHZd1YEnI8GNN
 qvSmd+AvJJ8U724hIiF0LSTGImbGfSwtwgmtzc6O1I4kREINX22I1xa6nihwL3bz/pAL
 PmJQ==
X-Gm-Message-State: AOJu0YwnTHGBBcBa4q33T2IdQciP9v8uo0P6M7Gy9LBPG1NmYTU3fOR+
 k9y1thNVOB3ZLq2AlcnBBvA9QeaD3jnOrMf1yWTRDg==
X-Google-Smtp-Source: AGHT+IEzZ6s5vb8lIiHxjBh0g3WDopuC29/uf986diynE3D2QSfTI/OYBwO7jAdNcvlEjuiL/tfXN7R6J2D15fFjvM0=
X-Received: by 2002:a17:906:224d:b0:9bf:2f84:5de7 with SMTP id
 13-20020a170906224d00b009bf2f845de7mr6153971ejr.4.1700532747244; Mon, 20 Nov
 2023 18:12:27 -0800 (PST)
MIME-Version: 1.0
References: <20230926194242.2732127-1-sjg@chromium.org>
 <20230926194242.2732127-2-sjg@chromium.org>
 <BN9PR11MB5483FF3039913334C7EA83E1E6AEA@BN9PR11MB5483.namprd11.prod.outlook.com>
 <CAMj1kXFG92NpL7T7YocOup0xLKyopt3MnSCp0RL8cLzozzJz7A@mail.gmail.com>
 <BN9PR11MB548303B09536EB1577472029E6B3A@BN9PR11MB5483.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB548303B09536EB1577472029E6B3A@BN9PR11MB5483.namprd11.prod.outlook.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Nov 2023 19:12:15 -0700
Message-ID: <CAPnjgZ36t8g7E=0MSJyaV8-QKv9RVYe47Jd5E=NU-mFM4LWBQA@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] schemas: Add some common reserved-memory usages
To: "Chiu, Chasel" <chasel.chiu@intel.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, 
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, "Tan, Lean Sheng" <sheng.tan@9elements.com>, 
 lkml <linux-kernel@vger.kernel.org>, Dhaval Sharma <dhaval@rivosinc.com>, 
 "Brune, Maximilian" <maximilian.brune@9elements.com>,
 Yunhui Cui <cuiyunhui@bytedance.com>, 
 "Dong, Guo" <guo.dong@intel.com>, Tom Rini <trini@konsulko.com>, 
 ron minnich <rminnich@gmail.com>, "Guo, Gua" <gua.guo@intel.com>, 
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
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

On Mon, 13 Nov 2023 at 11:09, Chiu, Chasel <chasel.chiu@intel.com> wrote:
>
>
> Hi Ard,
>
> Please see my reply below inline.
>
> Thanks,
> Chasel
>
>
> > -----Original Message-----
> > From: Ard Biesheuvel <ardb@kernel.org>
> > Sent: Saturday, November 11, 2023 3:04 AM
> > To: Chiu, Chasel <chasel.chiu@intel.com>
> > Cc: Simon Glass <sjg@chromium.org>; devicetree@vger.kernel.org; Mark Ru=
tland
> > <mark.rutland@arm.com>; Rob Herring <robh@kernel.org>; Tan, Lean Sheng
> > <sheng.tan@9elements.com>; lkml <linux-kernel@vger.kernel.org>; Dhaval
> > Sharma <dhaval@rivosinc.com>; Brune, Maximilian
> > <maximilian.brune@9elements.com>; Yunhui Cui <cuiyunhui@bytedance.com>;
> > Dong, Guo <guo.dong@intel.com>; Tom Rini <trini@konsulko.com>; ron minn=
ich
> > <rminnich@gmail.com>; Guo, Gua <gua.guo@intel.com>; linux-
> > acpi@vger.kernel.org; U-Boot Mailing List <u-boot@lists.denx.de>
> > Subject: Re: [PATCH v7 2/2] schemas: Add some common reserved-memory
> > usages
> >
> > On Sat, 11 Nov 2023 at 04:20, Chiu, Chasel <chasel.chiu@intel.com> wrot=
e:
> > >
> > >
> > > Just sharing some usage examples from UEFI/EDK2 scenario.
> > > To support ACPI S4/Hibernation, memory map must be consistent before
> > > entering and after resuming from S4, in this case payload may need to
> > > know previous memory map from bootloader (currently generic payload
> > > cannot access platform/bootloader specific non-volatile data, thus
> > > could not save/restore memory map information)
> >
> > So how would EDK2 reconstruct the entire EFI memory map from just these
> > unannotated /reserved-memory nodes? The EFI memory map contains much
> > more information than that, and all of it has to match the pre-hibernat=
e situation,
> > right? Can you given an example?
>
>
> Here we listed only typically memory types that may change cross differen=
t platforms.
> Reserved memory type already can be handled by reserved-memory node, and =
rest of the types usually no need to change cross platforms thus currently =
we could rely on default in generic payload.
> In the future if we see a need to add new memory types we will discuss an=
d add it to FDT schema.
>
>
>
> >
> > > Another usage is to support binary model which generic payload is a p=
rebuilt
> > binary compatible for all platforms/configurations, however the payload=
 default
> > memory map might not always work for all the configurations and we want=
 to
> > allow bootloader to override payload default memory map without recompi=
ling.
> > >
> >
> > Agreed. But can you explain how a EDK2 payload might make meaningful us=
e of
> > 'runtime-code' regions provided via DT  by the non-EDK2 platform init? =
Can you
> > give an example?
>
>
> Runtime-code/data is used by UEFI payload for booting UEFI OS which requi=
red UEFI runtime services.
> Platform Init will select some regions from the usable memory and assign =
it to runtime-code/data for UPL to consume. Or assign same runtime-code/dat=
a from previous boot.
> If UEFI OS is not supported, PlatformInit may not need to provide runtime=
-code/data regions to payload. (always providing runtime-code/data should b=
e supported too)
>
>
> >
> > > Under below assumption:
> > >         FDT OS impact has been evaluated and taken care by relevant
> > experts/stakeholders.
> > > Reviewed-by: Chasel Chiu <chasel.chiu@intel.com>
> > >
> >
> > I am sorry but I don't know what 'FDT OS impact' means. We are talking =
about a
> > firmware-to-firmware abstraction that has the potential to leak into th=
e OS
> > visible interface.
> >
> > I am a maintainer in the Tianocore project myself, so it would help if =
you could
> > explain who these relevant experts and stakeholders are. Was this discu=
ssed on
> > the edk2-devel mailing list? If so, apologies for missing it but I may =
not have been
> > cc'ed perhaps?
>
>
>
>
> I'm not familiar with FDT OS, also I do not know if who from edk2-devel w=
ere supporting FDT OS, I think Simon might be able to connect FDT OS expert=
s/stakeholders.
> We are mostly focusing on payload firmware phase implementation in edk2 (=
and other payloads too), however, since we have aligned the payload FDT and=
 OS FDT months ago, I'm assuming FDT OS impact must be there and we need (o=
r already done?) FDT OS experts to support it. (again, maybe Simon could sh=
are more information about FDT OS)
>
> In edk2 such FDT schema is UefiPayloadPkg internal usage only and payload=
 entry will convert FDT into HOB thus we expected the most of the edk2 gene=
ric code are no-touch/no impact, that's why we only had small group (UefiPa=
yloadPkg) discussion.
> Ard, if you are aware of any edk2 code that's for supporting FDT OS, plea=
se let us know and we can discuss if those code were impacted or not.

We discussed this and just to clarify, 'FDT OS' is not a special OS,
it is just Linux.

So, with the above, are we all on the same page? Can the patch be
applied, perhaps? If not, what other discussion is needed?

Regards,
Simon

>
>
>
>
> >
> >
> > >
> > > > -----Original Message-----
> > > > From: Simon Glass <sjg@chromium.org>
> > > > Sent: Tuesday, September 26, 2023 12:43 PM
> > > > To: devicetree@vger.kernel.org
> > > > Cc: Mark Rutland <mark.rutland@arm.com>; Rob Herring
> > > > <robh@kernel.org>; Tan, Lean Sheng <sheng.tan@9elements.com>; lkml
> > > > <linux- kernel@vger.kernel.org>; Dhaval Sharma
> > > > <dhaval@rivosinc.com>; Brune, Maximilian
> > > > <maximilian.brune@9elements.com>; Yunhui Cui
> > > > <cuiyunhui@bytedance.com>; Dong, Guo <guo.dong@intel.com>; Tom Rini
> > > > <trini@konsulko.com>; ron minnich <rminnich@gmail.com>; Guo, Gua
> > > > <gua.guo@intel.com>; Chiu, Chasel <chasel.chiu@intel.com>; linux-
> > > > acpi@vger.kernel.org; U-Boot Mailing List <u-boot@lists.denx.de>;
> > > > Ard Biesheuvel <ardb@kernel.org>; Simon Glass <sjg@chromium.org>
> > > > Subject: [PATCH v7 2/2] schemas: Add some common reserved-memory
> > > > usages
> > > >
> > > > It is common to split firmware into 'Platform Init', which does the
> > > > initial hardware setup and a "Payload" which selects the OS to be b=
ooted.
> > > > Thus an handover interface is required between these two pieces.
> > > >
> > > > Where UEFI boot-time services are not available, but UEFI firmware
> > > > is present on either side of this interface, information about
> > > > memory usage and attributes must be presented to the "Payload" in s=
ome
> > form.
> > > >
> > > > This aims to provide an small schema addition for the memory mappin=
g
> > > > needed to keep these two pieces working together well.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > Changes in v7:
> > > > - Rename acpi-reclaim to acpi
> > > > - Drop individual mention of when memory can be reclaimed
> > > > - Rewrite the item descriptions
> > > > - Add back the UEFI text (with trepidation)
> > > >
> > > > Changes in v6:
> > > > - Drop mention of UEFI
> > > > - Use compatible strings instead of node names
> > > >
> > > > Changes in v5:
> > > > - Drop the memory-map node (should have done that in v4)
> > > > - Tidy up schema a bit
> > > >
> > > > Changes in v4:
> > > > - Make use of the reserved-memory node instead of creating a new on=
e
> > > >
> > > > Changes in v3:
> > > > - Reword commit message again
> > > > - cc a lot more people, from the FFI patch
> > > > - Split out the attributes into the /memory nodes
> > > >
> > > > Changes in v2:
> > > > - Reword commit message
> > > >
> > > >  .../reserved-memory/common-reserved.yaml      | 71 +++++++++++++++=
++++
> > > >  1 file changed, 71 insertions(+)
> > > >  create mode 100644 dtschema/schemas/reserved-memory/common-
> > > > reserved.yaml
> > > >
> > > > diff --git a/dtschema/schemas/reserved-memory/common-reserved.yaml
> > > > b/dtschema/schemas/reserved-memory/common-reserved.yaml
> > > > new file mode 100644
> > > > index 0000000..f7fbdfd
> > > > --- /dev/null
> > > > +++ b/dtschema/schemas/reserved-memory/common-reserved.yaml
> > > > @@ -0,0 +1,71 @@
> > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause %YAML 1.2
> > > > +---
> > > > +$id:
> > > > +http://devicetree.org/schemas/reserved-memory/common-reserved.yaml=
#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Common memory reservations
> > > > +
> > > > +description: |
> > > > +  Specifies that the reserved memory region can be used for the
> > > > +purpose
> > > > +  indicated by its compatible string.
> > > > +
> > > > +  Clients may reuse this reserved memory if they understand what i=
t
> > > > + is for,  subject to the notes below.
> > > > +
> > > > +maintainers:
> > > > +  - Simon Glass <sjg@chromium.org>
> > > > +
> > > > +allOf:
> > > > +  - $ref: reserved-memory.yaml
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    description: |
> > > > +      This describes some common memory reservations, with the com=
patible
> > > > +      string indicating what it is used for:
> > > > +
> > > > +         acpi: Advanced Configuration and Power Interface (ACPI) t=
ables
> > > > +         acpi-nvs: ACPI Non-Volatile-Sleeping Memory (NVS). This i=
s reserved by
> > > > +           the firmware for its use and is required to be saved an=
d restored
> > > > +           across an NVS sleep
> > > > +         boot-code: Contains code used for booting which is not ne=
eded by the
> > OS
> > > > +         boot-code: Contains data used for booting which is not ne=
eded by the
> > OS
> > > > +         runtime-code: Contains code used for interacting with the=
 system when
> > > > +           running the OS
> > > > +         runtime-data: Contains data used for interacting with the=
 system when
> > > > +           running the OS
> > > > +
> > > > +    enum:
> > > > +      - acpi
> > > > +      - acpi-nvs
> > > > +      - boot-code
> > > > +      - boot-data
> > > > +      - runtime-code
> > > > +      - runtime-data
> > > > +
> > > > +  reg:
> > > > +    description: region of memory that is reserved for the purpose=
 indicated
> > > > +      by the compatible string.
> > > > +
> > > > +required:
> > > > +  - reg
> > > > +
> > > > +unevaluatedProperties: false
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    reserved-memory {
> > > > +        #address-cells =3D <1>;
> > > > +        #size-cells =3D <1>;
> > > > +
> > > > +        reserved@12340000 {
> > > > +            compatible =3D "boot-code";
> > > > +            reg =3D <0x12340000 0x00800000>;
> > > > +        };
> > > > +
> > > > +        reserved@43210000 {
> > > > +            compatible =3D "boot-data";
> > > > +            reg =3D <0x43210000 0x00800000>;
> > > > +        };
> > > > +    };
> > > > --
> > > > 2.42.0.515.g380fc7ccd1-goog
> > >
