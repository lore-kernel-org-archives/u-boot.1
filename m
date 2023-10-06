Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240F4E81E1E
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 17:33:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB42B86D41;
	Fri,  6 Oct 2023 19:33:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JLgw/UkC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BB6486C78; Fri,  6 Oct 2023 19:33:39 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 250DC86D41
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 19:33:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ardb@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 35A3661425
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 17:33:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE199C43395
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 17:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1696613613;
 bh=4IY5wvH6Tu8PjK8sB+KMGi/o7CRamiSkVLdDByB8yd8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=JLgw/UkCyfmsvFHkORbsNApmlFxfQIWwAspg7Fgtj7uPVIWdvAhtw04GGiTbDYQgU
 1NcRUUKEdX98ooHi0UShUy8PN3FdMPPaykMmKqJK+nG7EdgTbceY7vSGy9qCM1QQvi
 RkkVLS9B7Kv445176PYUUham34401aZOlX6CwIKbjTM1DmC8nNUKjLfabxIW1VcsMF
 id2cn/dFAO1AG1GG+6/5eS2voYp3c+sXJEDLrfjeWZvg42g2KtTaAdrhU8+EOIOswF
 uvVTpmOpUNHgJrjWPfo/NvPCdZb55r9VdDBIIOpd8W4TUMwcV4GxQxdf92GByJiWNL
 CsSL1voPt3ONQ==
Received: by mail-lf1-f45.google.com with SMTP id
 2adb3069b0e04-5044dd5b561so2928582e87.1
 for <u-boot@lists.denx.de>; Fri, 06 Oct 2023 10:33:33 -0700 (PDT)
X-Gm-Message-State: AOJu0YzW5HMxY9E0O/zDBR+55+Q+ZP+onB2kU/6yOwzl1ycQJpUpy3wJ
 j0fjVTweeMn2MlL/JWT6oHAqImDcpQyzNDpNpIM=
X-Google-Smtp-Source: AGHT+IG2WFsPGJcnl4fQlvIDX23yxE4FYGH11uyJoLwu4bJYLZExy/cAZV6tzSxf3TqK4KzjOHM+0kg+tpgnDaQV7yU=
X-Received: by 2002:a19:c217:0:b0:504:7e12:4846 with SMTP id
 l23-20020a19c217000000b005047e124846mr7273243lfc.30.1696613611592; Fri, 06
 Oct 2023 10:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230926194242.2732127-1-sjg@chromium.org>
 <20230926194242.2732127-2-sjg@chromium.org>
 <CAPnjgZ0Xf3U1aj32LbU-xiU1AqwnM3JL1F8xX-wZ18oEmg+irw@mail.gmail.com>
In-Reply-To: <CAPnjgZ0Xf3U1aj32LbU-xiU1AqwnM3JL1F8xX-wZ18oEmg+irw@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 6 Oct 2023 19:33:20 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEXcX7BkDyfy-6_5Vnch=N+onza-yfWfsVaGLE93h2c+Q@mail.gmail.com>
Message-ID: <CAMj1kXEXcX7BkDyfy-6_5Vnch=N+onza-yfWfsVaGLE93h2c+Q@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] schemas: Add some common reserved-memory usages
To: Simon Glass <sjg@chromium.org>
Cc: devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Lean Sheng Tan <sheng.tan@9elements.com>, 
 lkml <linux-kernel@vger.kernel.org>, Dhaval Sharma <dhaval@rivosinc.com>, 
 Maximilian Brune <maximilian.brune@9elements.com>,
 Yunhui Cui <cuiyunhui@bytedance.com>, 
 Guo Dong <guo.dong@intel.com>, Tom Rini <trini@konsulko.com>, 
 ron minnich <rminnich@gmail.com>, Gua Guo <gua.guo@intel.com>, 
 Chiu Chasel <chasel.chiu@intel.com>, linux-acpi@vger.kernel.org, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

On Mon, 2 Oct 2023 at 19:54, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Rob,
>
> On Tue, 26 Sept 2023 at 13:42, Simon Glass <sjg@chromium.org> wrote:
> >
> > It is common to split firmware into 'Platform Init', which does the
> > initial hardware setup and a "Payload" which selects the OS to be booted.
> > Thus an handover interface is required between these two pieces.
> >
> > Where UEFI boot-time services are not available, but UEFI firmware is
> > present on either side of this interface, information about memory usage
> > and attributes must be presented to the "Payload" in some form.
> >
> > This aims to provide an small schema addition for the memory mapping
> > needed to keep these two pieces working together well.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v7:
> > - Rename acpi-reclaim to acpi
> > - Drop individual mention of when memory can be reclaimed
> > - Rewrite the item descriptions
> > - Add back the UEFI text (with trepidation)
>
> I am again checking on this series. Can it be applied, please?
>

Apologies for the delay in response. I have been away.

>
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
> >  create mode 100644 dtschema/schemas/reserved-memory/common-reserved.yaml
> >
> > diff --git a/dtschema/schemas/reserved-memory/common-reserved.yaml b/dtschema/schemas/reserved-memory/common-reserved.yaml
> > new file mode 100644
> > index 0000000..f7fbdfd
> > --- /dev/null
> > +++ b/dtschema/schemas/reserved-memory/common-reserved.yaml
> > @@ -0,0 +1,71 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/reserved-memory/common-reserved.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Common memory reservations
> > +
> > +description: |
> > +  Specifies that the reserved memory region can be used for the purpose
> > +  indicated by its compatible string.
> > +
> > +  Clients may reuse this reserved memory if they understand what it is for,
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
> > +      This describes some common memory reservations, with the compatible
> > +      string indicating what it is used for:
> > +
> > +         acpi: Advanced Configuration and Power Interface (ACPI) tables
> > +         acpi-nvs: ACPI Non-Volatile-Sleeping Memory (NVS). This is reserved by
> > +           the firmware for its use and is required to be saved and restored
> > +           across an NVS sleep
> > +         boot-code: Contains code used for booting which is not needed by the OS
> > +         boot-code: Contains data used for booting which is not needed by the OS
> > +         runtime-code: Contains code used for interacting with the system when
> > +           running the OS
> > +         runtime-data: Contains data used for interacting with the system when
> > +           running the OS
> > +
> > +    enum:
> > +      - acpi
> > +      - acpi-nvs
> > +      - boot-code
> > +      - boot-data
> > +      - runtime-code
> > +      - runtime-data
> > +

As I mentioned a few times already, I don't think these compatibles
should be introduced here.

A reserved region has a specific purpose, and the compatible should be
more descriptive than the enum above. If the consumer does not
understand this purpose, it should simply treat the memory as reserved
and not touch it. Alternatively, these regions can be referenced from
other DT nodes using phandles if needed.


> > +  reg:
> > +    description: region of memory that is reserved for the purpose indicated
> > +      by the compatible string.
> > +
> > +required:
> > +  - reg
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    reserved-memory {
> > +        #address-cells = <1>;
> > +        #size-cells = <1>;
> > +
> > +        reserved@12340000 {
> > +            compatible = "boot-code";
> > +            reg = <0x12340000 0x00800000>;
> > +        };
> > +
> > +        reserved@43210000 {
> > +            compatible = "boot-data";
> > +            reg = <0x43210000 0x00800000>;
> > +        };
> > +    };
> > --
> > 2.42.0.515.g380fc7ccd1-goog
> >
>
> Regards,
> Simon
