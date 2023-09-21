Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F513E7107F
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 14:38:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DD6D86098;
	Thu, 21 Sep 2023 16:38:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l6MLGLiv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAD68864F0; Thu, 21 Sep 2023 16:38:24 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71804807BC
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 16:38:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9ad8bba8125so135503166b.3
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 07:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695307102; x=1695911902; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E19Ekl5PJswibGBQfhab8yclZrAA2HIOFTLdNx9MRjc=;
 b=l6MLGLivzKvhuroNJEth+Z+96BRBYrslxnInhQ7o7R872OIytF6p0Lx216KAG8HGNi
 +46OCimiW3WO/oUr4usm/gYYaciEikR0m58F1EsCPGqOBCdMFmOlaaIO0nPr2rXcIj9r
 qEGd2lrBpztkFqKt4yIUEicC7DDb4T9Arnn+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695307102; x=1695911902;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E19Ekl5PJswibGBQfhab8yclZrAA2HIOFTLdNx9MRjc=;
 b=EaZsDTUW+eiElADzUjx4xfQ5HelXxg05/1sl/1OKmfsshhO77dv2Ocfr1aOO9BG8cD
 9N4mDEQpCFpeF2boTaz2HwtgdD6hBtUML/kpGvlrsewuQobJ6tEnN/i18cMgCD9p9sir
 XtUxugJ5fihwpM80WCLqpUIdCqGjUGIOPOikyYzGZ1wgIPrp61/EB1f8B19tedgT5BtW
 WDEAUUdkQOhqHQFsaKcGwkyFHDekbvW0mrQK+rrjTuydhO0NyJcHwkKKEdnqHmmu+2Du
 8/P3iyw+AsHIuw77kf3U3GvVhAciynHQWNNnl44hIZ37U2YLsQaPNjtAvh5BX0BNDSaO
 nHEQ==
X-Gm-Message-State: AOJu0YwtyTiHakDhaiaujxpiUoOHJKoDclBlDsmumgW0qncHQDA7qvah
 Jb70mx2eS4qP1XtOhGU5xFv6BsN73Mnyiarjbbx8sA==
X-Google-Smtp-Source: AGHT+IHwUSKIHM6d3plJsNARSg6EFircCLQgrlATm9TW4MR3SVA1+Jq7dOWRr7DtrCzzOpccxefsLrqZDnFGCznf4SY=
X-Received: by 2002:a17:906:5a68:b0:9aa:e13:426a with SMTP id
 my40-20020a1709065a6800b009aa0e13426amr4250751ejc.73.1695307101683; Thu, 21
 Sep 2023 07:38:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230907214012.74978-1-sjg@chromium.org>
 <CAL_Jsq+WfWrZErmz4u3_-CoVAuxL21UndcRekfJ1e61ZMMBqRw@mail.gmail.com>
In-Reply-To: <CAL_Jsq+WfWrZErmz4u3_-CoVAuxL21UndcRekfJ1e61ZMMBqRw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 21 Sep 2023 08:38:09 -0600
Message-ID: <CAPnjgZ3ALq9Hr+t4CywO113mKr83xCgFhfz+6=jav3T3R1_TGA@mail.gmail.com>
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

On Thu, 21 Sept 2023 at 08:25, Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Sep 7, 2023 at 4:40=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
> >
> > It is common to split firmware into 'Platform Init', which does the
> > initial hardware setup and a "Payload" which selects the OS to be boote=
d.
> > Thus an handover interface is required between these two pieces.
> >
> > This aims to provide an small schema addition for the memory mapping
> > needed to keep these two pieces working together well.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v6:
> > - Drop mention of UEFI
> > - Use compatible strings instead of node names
> >
> > Changes in v5:
> > - Drop the memory-map node (should have done that in v4)
> > - Tidy up schema a bit
> >
> > Changes in v4:
> > - Make use of the reserved-memory node instead of creating a new one
> >
> > Changes in v3:
> > - Reword commit message again
> > - cc a lot more people, from the FFI patch
> > - Split out the attributes into the /memory nodes
> >
> > Changes in v2:
> > - Reword commit message
> >
> >  .../reserved-memory/common-reserved.yaml      | 71 +++++++++++++++++++
> >  1 file changed, 71 insertions(+)
> >  create mode 100644 dtschema/schemas/reserved-memory/common-reserved.ya=
ml
> >
> > diff --git a/dtschema/schemas/reserved-memory/common-reserved.yaml b/dt=
schema/schemas/reserved-memory/common-reserved.yaml
> > new file mode 100644
> > index 0000000..4889f59
> > --- /dev/null
> > +++ b/dtschema/schemas/reserved-memory/common-reserved.yaml
> > @@ -0,0 +1,71 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/reserved-memory/common-reserved.yam=
l#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Common memory reservations
> > +
> > +description: |
> > +  Specifies that the reserved memory region can be used for the purpos=
e
> > +  indicated by its compatible string.
> > +
> > +  Clients may reuse this reserved memory if they understand what it is=
 for,
> > +  subject to the notes below.
> > +
> > +maintainers:
> > +  - Simon Glass <sjg@chromium.org>
> > +
> > +allOf:
> > +  - $ref: reserved-memory.yaml
> > +
> > +properties:
> > +  compatible:
> > +    description: |
> > +      This describes some common memory reservations:
> > +
> > +         acpi-reclaim: Contains ACPI tables; memory may be reclaimed w=
hen the
> > +           tables are no-longer needed
>
> I think you are mixing 2 things with the name here. What the memory
> contains and what to do with it. You don't need the latter. The
> consumer of the region will know what to do with it if anything based
> on knowing what is in the region. For example, The DTB passed to the
> OS is typically in a reserved region (probably still /mem-reserve/
> though). The DTB may remain there forever or the OS could copy it
> somewhere else and free the reserved region. The Linux kernel does
> both depending on the arch. (Of course there is no "dtb" compatible
> because we have to pass the location of the dtb to even find the
> reserved regions in the first place.)
>
> So the question here is whether just "acpi" (or "acpi-tables"?) would
> be explicit enough?

Yes acpi-tables would be enough.

>
> > +         acpi-nvs: Contains ACPI Non-volatile-storage data; memory may=
 be
> > +           reclaimed when the tables are no-longer needed
>
> No need to say anything about reclaiming.

OK...so what about all that discussion about being able to reclaim the
memory if you know what it is for? Where should that be written? Or is
it somewhere else already?

>
> I know some ACPIisms (e.g. DSDT), but I don't know what NVS or
> "Non-volatile-storage data" is in an ACPI context.
>
> > +         boot-code: Contains code used for booting; memory may be recl=
aimed by
> > +           the OS when it is running
> > +         boot-code: Contains data used for booting; memory may be recl=
aimed by
>
> boot-data?

Yes

>
> > +           the OS when it is running
>
> I thought these were for stages before we get to OS?

Yes...but of course these will be passed on to the OS in some form.
See above re reclaiming.

>
> > +         runtime-code: Contains code used for interacting with the sys=
tem when
> > +           running; memory may be reclaimed if this code is not called
> > +         runtime-data: Contains data used for interacting with the sys=
tem when
> > +           running; memory may be reclaimed if the runtime code is not=
 used
>
> "boot" vs. "runtime" seem too vague. However, if these mean EFI boot
> time services and runtime services, then I understand exactly what
> they are. In that case dropping 'uefi,' was a mistake. But EFI has its
> own way to define these regions, right?

I really don't want to do another round of that circle. I was asked to
drop mention of EFI which I did. If these are too vague, what should I
do instead? Perhaps:

boot-code / data
os-code / data

?

Regards,
Simon
