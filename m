Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8ADE71094
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 16:45:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 213AB86B70;
	Thu, 21 Sep 2023 18:45:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kzb7UivQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42198869F1; Thu, 21 Sep 2023 18:45:27 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0AD9869F1
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 18:45:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2bffd6c1460so18380371fa.3
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 09:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695314724; x=1695919524; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pjXMul1tdG2FysTc47K7K+TQorinOPmi7DblGt9caAM=;
 b=kzb7UivQyqKQRAP02oMeuaIf8b6eSU4Aip1DLTIwHAVbRXUNyt7YVqYFnH0qFZ6OaB
 bM6NGCQ/k9IE1831M8xhxDvJcZee6dd0lOb2PIwKYmetS0FERGNZanGOhSdAoBd+lE13
 QzXomhFsWg8ljrwwXhwA5UgmCq9ujfnkqjrIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695314724; x=1695919524;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pjXMul1tdG2FysTc47K7K+TQorinOPmi7DblGt9caAM=;
 b=VRj+1uyX3eAHSIfYetpLEdRFARRXz66CepQTiuZ+FWHVczBjjQY4A1JVIcyfZTpjnU
 QO1RZwvEWEf9TDdn15snhUkhJVGjOq1IgHHmWx6MAAvSlgKEyUzSQyRUXWgoSkSNW6ar
 08J9jDCJ/C+CFctMBUNxYe4/fQB8jRe7WyjUqaZteUmPgj7fIMe8xBVNY1aFaF8PzO4I
 AHJtkv3V4BsgW7FTxMnafVuCL8qoDuvCIU1TBnHQnuZChIfAs7Eo07b82iSBQm45bfgv
 gAbOwVGOVPq3pAM1AyblEhhMHz5DBCXn4GNTPb/wjRhUWkBfXcz7St/aCLjMwK9IJRCr
 mkuA==
X-Gm-Message-State: AOJu0YyDWLC6zNv7CnD5w8p9jX2BvFHWOO1hiMv4mICN8uHxoHPwvkBi
 MkeI3Z/eMlABY2oj6Xr5Au5HqzsSEH9xIJ09rcrzry0jPkqzALs1NTj7mQ==
X-Google-Smtp-Source: AGHT+IE6bdxf5fLgCFAXw2GZV/Yh2tInQgQq2omDLrwjRZ9HTqPrdSHH9MS39iWHFO+MuEwdhepBYoQe3xF9jtZWVYE=
X-Received: by 2002:a05:6512:10d1:b0:4ff:9a75:211e with SMTP id
 k17-20020a05651210d100b004ff9a75211emr6974838lfg.42.1695314723802; Thu, 21
 Sep 2023 09:45:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230907214012.74978-1-sjg@chromium.org>
 <CAL_Jsq+WfWrZErmz4u3_-CoVAuxL21UndcRekfJ1e61ZMMBqRw@mail.gmail.com>
 <CAPnjgZ3ALq9Hr+t4CywO113mKr83xCgFhfz+6=jav3T3R1_TGA@mail.gmail.com>
 <CAL_JsqJdTR9morobxty1egHFmTwL1-Kh3-sQ5CY7xit80fE2jw@mail.gmail.com>
In-Reply-To: <CAL_JsqJdTR9morobxty1egHFmTwL1-Kh3-sQ5CY7xit80fE2jw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 21 Sep 2023 10:45:11 -0600
Message-ID: <CAPnjgZ37MmqinWHcWWToVsMwn+3TY=bzyXAqLFgz6kZN=tZ54g@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] schemas: Add some common reserved-memory usages
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, Dhaval Sharma <dhaval@rivosinc.com>, 
 Guo Dong <guo.dong@intel.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Yunhui Cui <cuiyunhui@bytedance.com>, Chiu Chasel <chasel.chiu@intel.com>, 
 Mark Rutland <mark.rutland@arm.com>, linux-acpi@vger.kernel.org, 
 Maximilian Brune <maximilian.brune@9elements.com>,
 Ard Biesheuvel <ardb@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Lean Sheng Tan <sheng.tan@9elements.com>, 
 Gua Guo <gua.guo@intel.com>, ron minnich <rminnich@gmail.com>
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

On Thu, 21 Sept 2023 at 09:20, Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Sep 21, 2023 at 9:38=E2=80=AFAM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Rob,
> >
> > On Thu, 21 Sept 2023 at 08:25, Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Thu, Sep 7, 2023 at 4:40=E2=80=AFPM Simon Glass <sjg@chromium.org>=
 wrote:
> > > >
> > > > It is common to split firmware into 'Platform Init', which does the
> > > > initial hardware setup and a "Payload" which selects the OS to be b=
ooted.
> > > > Thus an handover interface is required between these two pieces.
> > > >
> > > > This aims to provide an small schema addition for the memory mappin=
g
> > > > needed to keep these two pieces working together well.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
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
> > > >  create mode 100644 dtschema/schemas/reserved-memory/common-reserve=
d.yaml
> > > >
> > > > diff --git a/dtschema/schemas/reserved-memory/common-reserved.yaml =
b/dtschema/schemas/reserved-memory/common-reserved.yaml
> > > > new file mode 100644
> > > > index 0000000..4889f59
> > > > --- /dev/null
> > > > +++ b/dtschema/schemas/reserved-memory/common-reserved.yaml
> > > > @@ -0,0 +1,71 @@
> > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/reserved-memory/common-reserved=
.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Common memory reservations
> > > > +
> > > > +description: |
> > > > +  Specifies that the reserved memory region can be used for the pu=
rpose
> > > > +  indicated by its compatible string.
> > > > +
> > > > +  Clients may reuse this reserved memory if they understand what i=
t is for,
> > > > +  subject to the notes below.
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
> > > > +      This describes some common memory reservations:
> > > > +
> > > > +         acpi-reclaim: Contains ACPI tables; memory may be reclaim=
ed when the
> > > > +           tables are no-longer needed
> > >
> > > I think you are mixing 2 things with the name here. What the memory
> > > contains and what to do with it. You don't need the latter. The
> > > consumer of the region will know what to do with it if anything based
> > > on knowing what is in the region. For example, The DTB passed to the
> > > OS is typically in a reserved region (probably still /mem-reserve/
> > > though). The DTB may remain there forever or the OS could copy it
> > > somewhere else and free the reserved region. The Linux kernel does
> > > both depending on the arch. (Of course there is no "dtb" compatible
> > > because we have to pass the location of the dtb to even find the
> > > reserved regions in the first place.)
> > >
> > > So the question here is whether just "acpi" (or "acpi-tables"?) would
> > > be explicit enough?
> >
> > Yes acpi-tables would be enough.
> >
> > >
> > > > +         acpi-nvs: Contains ACPI Non-volatile-storage data; memory=
 may be
> > > > +           reclaimed when the tables are no-longer needed
> > >
> > > No need to say anything about reclaiming.
> >
> > OK...so what about all that discussion about being able to reclaim the
> > memory if you know what it is for? Where should that be written? Or is
> > it somewhere else already?
>
> Reclaiming is a policy of the consumer of the data. It belongs in the
> documentation of the consumer if you are going to document it.
>
> The global policy is you can't use reserved regions and you can't
> reclaim them if you don't know what they are. If you want to add
> something to that effect in reserved-memory.yaml or the spec, that's
> fine, but that's not a per compatible thing.

OK I will do that.

>
> > > I know some ACPIisms (e.g. DSDT), but I don't know what NVS or
> > > "Non-volatile-storage data" is in an ACPI context.
> > >
> > > > +         boot-code: Contains code used for booting; memory may be =
reclaimed by
> > > > +           the OS when it is running
> > > > +         boot-code: Contains data used for booting; memory may be =
reclaimed by
> > >
> > > boot-data?
> >
> > Yes
> >
> > >
> > > > +           the OS when it is running
> > >
> > > I thought these were for stages before we get to OS?
> >
> > Yes...but of course these will be passed on to the OS in some form.
> > See above re reclaiming.
> >
> > >
> > > > +         runtime-code: Contains code used for interacting with the=
 system when
> > > > +           running; memory may be reclaimed if this code is not ca=
lled
> > > > +         runtime-data: Contains data used for interacting with the=
 system when
> > > > +           running; memory may be reclaimed if the runtime code is=
 not used
> > >
> > > "boot" vs. "runtime" seem too vague. However, if these mean EFI boot
> > > time services and runtime services, then I understand exactly what
> > > they are. In that case dropping 'uefi,' was a mistake. But EFI has it=
s
> > > own way to define these regions, right?
> >
> > I really don't want to do another round of that circle. I was asked to
> > drop mention of EFI which I did. If these are too vague, what should I
> > do instead? Perhaps:
> >
> > boot-code / data
> > os-code / data
>
> The kernel is boot code (and os code and runtime code). Can I use

What do you mean by that? The kernel is an OS. It might have an EFI
stub or other stuff, but it is not a boot loader. We have to have some
generally accepted terms for what is the OS and what is the firmware.

> these for the kernel image? Certainly not. But they are too vague to
> understand when to use them and when not to. Are they specific to EDK2
> implementation? Then perhaps they need an 'edk2' prefix.
>
> Either these are related to EFI boot time services and runtime
> services or they aren't. Which is it? If they are related, then EFI
> should certainly be mentioned. Review comments are wrong all the time
> when the reasoning is missing or misunderstood. Please back up and
> explain why these are needed. Maybe it's buried in prior threads
> somewhere, but I'm not going back to re-read all that. This patch has
> to stand on its own.

For my email client it is buried in this thread, see the ~20 messages
above, or [1]. I took all the EFI stuff out of here because it was
going nowhere.

The text I removed in this version is:

>>>
It is common to split firmware into 'Platform Init', which does the
initial hardware setup and a "Payload" which selects the OS to be booted.
Thus an handover interface is required between these two pieces.

Where UEFI boot-time services are not available, but UEFI firmware is
present on either side of this interface, information about memory usage
and attributes must be presented to the "Payload" in some form.
<<<

Then I tried to explain it in terms of Tianocore being split into two
parts, one of which does Platform Init (e.g. silicon setup) and the
other which boots the OS. But that got lost is discussion about DXEs,
etc. There is no other communication mechanism between these two
pieces, nor does either piece know (at runtime or build time) whether
the other is there, or whether it is something else (e.g. coreboot or
U-Boot). This allows supporting Platform Init / Payload combinations
like coreboot->Tianocore, Tianocore->Tianocore. coreboot->U-Boot,
etc., i.e. universal compatibility.

IMhO this binding doesn't need to be about EFI. The concept of code
which is used during boot and code which is used by the OS doesn't
seem specific to EFI. After all, ARM has PSCI code which presumably
lives somewhere.

So do you really want it to mention EFI?

I have volunteered to take this on on behalf of the EDK2 people, who
are copied on this thread and hoping / relying on something being
resolved.

Regards,
Simon

[1] https://lore.kernel.org/lkml/CAMj1kXHGpCt8qkd6XYQF8mMdivQkTnEWjv6NzsFK=
=3D+N72LAn=3DQ@mail.gmail.com/
