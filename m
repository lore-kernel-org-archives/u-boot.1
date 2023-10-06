Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24ED4E81E1B
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 18:17:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0479886B89;
	Fri,  6 Oct 2023 20:17:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HJXIEaQ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFC8C86B8F; Fri,  6 Oct 2023 20:17:47 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5435B86B42
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 20:17:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-59e77e4f707so30210687b3.0
 for <u-boot@lists.denx.de>; Fri, 06 Oct 2023 11:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696616264; x=1697221064; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=N1kuvdFzr7bMP1IyvjWvGqylFglQ5IsaUBjLbA0R1mM=;
 b=HJXIEaQ/jItaWOmg5gFGdvBhyimSr1FR6I+j+wMQHqRrcD9Vd9aRHCD+FitRC9qZv3
 C2iqF2aN0iWCRyG8qikocgjWF4yqh2A6EfvzSIN/5Ne30IUozpi2Eoaz5jfGAV+uc4iH
 4PDlid5QfMcEWbc4kUbIrXVCeDOncJgXzE7hE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696616264; x=1697221064;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N1kuvdFzr7bMP1IyvjWvGqylFglQ5IsaUBjLbA0R1mM=;
 b=sLe1TLUoTQDIWVgFhX2atII8azkrI8rFGeyxEVEWeRjk3qUMj6e1o8IZN9CoXKzhPd
 b5ajVOfyWQEh54Hw4Pu6B7TSv09eG8mmqtaEYjHqgW55MRfuUpPl7kPoOefMWg/KdIoU
 ZycweptnYq8qhevFvEWwS0BQhbrR6Gi7BfEKi/CTfVfA+tyQoW/us4vcoT1BRQUbrsn7
 ElaBGv/CRL+Svdjpqd8R791eHzublmYnarSqufZHSB7GHSdEP590bNPFZKjZLMjbIQoC
 +YQRdRMfPi0Jr1yHy31s0BSCOKCkQnlMZ8yu+nY3tgJ6Jwvfi8sjFn1tY7YWYNqoLtLj
 Seeg==
X-Gm-Message-State: AOJu0Yz3Ex8vJU63JHSrvPMFHdVNnAULNxRNc5FsMfHsT/RLVsAsirgQ
 +LIvQ/oLWiTRI+GuKq0g9OHHC6wy5ma1y0GecKnUlg==
X-Google-Smtp-Source: AGHT+IGIR7IRjqzwhRUNpXjT8dLojncj3fRT3VJBx9+8GCPm7ydQ54cLXAEYShIToVA6nQy5pwi/6OxP9yHrPkR3CRA=
X-Received: by 2002:a81:6d47:0:b0:59f:81c4:631a with SMTP id
 i68-20020a816d47000000b0059f81c4631amr11073507ywc.24.1696616263670; Fri, 06
 Oct 2023 11:17:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230926194242.2732127-1-sjg@chromium.org>
 <20230926194242.2732127-2-sjg@chromium.org>
 <CAPnjgZ0Xf3U1aj32LbU-xiU1AqwnM3JL1F8xX-wZ18oEmg+irw@mail.gmail.com>
 <CAMj1kXEXcX7BkDyfy-6_5Vnch=N+onza-yfWfsVaGLE93h2c+Q@mail.gmail.com>
In-Reply-To: <CAMj1kXEXcX7BkDyfy-6_5Vnch=N+onza-yfWfsVaGLE93h2c+Q@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Oct 2023 12:17:23 -0600
Message-ID: <CAPnjgZ2SEby-ndrs=W_afBJH56eqc=-mhp1F1nwkvWks+=B54Q@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] schemas: Add some common reserved-memory usages
To: Ard Biesheuvel <ardb@kernel.org>
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

Hi Ard,

On Fri, 6 Oct 2023 at 11:33, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 2 Oct 2023 at 19:54, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Rob,
> >
> > On Tue, 26 Sept 2023 at 13:42, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > It is common to split firmware into 'Platform Init', which does the
> > > initial hardware setup and a "Payload" which selects the OS to be booted.
> > > Thus an handover interface is required between these two pieces.
> > >
> > > Where UEFI boot-time services are not available, but UEFI firmware is
> > > present on either side of this interface, information about memory usage
> > > and attributes must be presented to the "Payload" in some form.
> > >
> > > This aims to provide an small schema addition for the memory mapping
> > > needed to keep these two pieces working together well.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > Changes in v7:
> > > - Rename acpi-reclaim to acpi
> > > - Drop individual mention of when memory can be reclaimed
> > > - Rewrite the item descriptions
> > > - Add back the UEFI text (with trepidation)
> >
> > I am again checking on this series. Can it be applied, please?
> >
>
> Apologies for the delay in response. I have been away.

OK, I hope you had a nice trip.

>
> >
> > >
> > > Changes in v6:
> > > - Drop mention of UEFI
> > > - Use compatible strings instead of node names
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
> > >  .../reserved-memory/common-reserved.yaml      | 71 +++++++++++++++++++
> > >  1 file changed, 71 insertions(+)
> > >  create mode 100644 dtschema/schemas/reserved-memory/common-reserved.yaml
> > >
> > > diff --git a/dtschema/schemas/reserved-memory/common-reserved.yaml b/dtschema/schemas/reserved-memory/common-reserved.yaml
> > > new file mode 100644
> > > index 0000000..f7fbdfd
> > > --- /dev/null
> > > +++ b/dtschema/schemas/reserved-memory/common-reserved.yaml
> > > @@ -0,0 +1,71 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/reserved-memory/common-reserved.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Common memory reservations
> > > +
> > > +description: |
> > > +  Specifies that the reserved memory region can be used for the purpose
> > > +  indicated by its compatible string.
> > > +
> > > +  Clients may reuse this reserved memory if they understand what it is for,
> > > +  subject to the notes below.
> > > +
> > > +maintainers:
> > > +  - Simon Glass <sjg@chromium.org>
> > > +
> > > +allOf:
> > > +  - $ref: reserved-memory.yaml
> > > +
> > > +properties:
> > > +  compatible:
> > > +    description: |
> > > +      This describes some common memory reservations, with the compatible
> > > +      string indicating what it is used for:
> > > +
> > > +         acpi: Advanced Configuration and Power Interface (ACPI) tables
> > > +         acpi-nvs: ACPI Non-Volatile-Sleeping Memory (NVS). This is reserved by
> > > +           the firmware for its use and is required to be saved and restored
> > > +           across an NVS sleep
> > > +         boot-code: Contains code used for booting which is not needed by the OS
> > > +         boot-code: Contains data used for booting which is not needed by the OS
> > > +         runtime-code: Contains code used for interacting with the system when
> > > +           running the OS
> > > +         runtime-data: Contains data used for interacting with the system when
> > > +           running the OS
> > > +
> > > +    enum:
> > > +      - acpi
> > > +      - acpi-nvs
> > > +      - boot-code
> > > +      - boot-data
> > > +      - runtime-code
> > > +      - runtime-data
> > > +
>
> As I mentioned a few times already, I don't think these compatibles
> should be introduced here.
>
> A reserved region has a specific purpose, and the compatible should be
> more descriptive than the enum above. If the consumer does not
> understand this purpose, it should simply treat the memory as reserved
> and not touch it. Alternatively, these regions can be referenced from
> other DT nodes using phandles if needed.

We still need some description of what these regions are used for, so
that the payload can use the correct regions. I do not have any other
solution to this problem. We are in v7 at present. At least explain
where you want the compatible strings to be introduced.

What sort of extra detail are you looking for? Please be specific and
preferably add some suggestions so I can close this out ASAP.

>
>
> > > +  reg:
> > > +    description: region of memory that is reserved for the purpose indicated
> > > +      by the compatible string.
> > > +
> > > +required:
> > > +  - reg
> > > +
> > > +unevaluatedProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    reserved-memory {
> > > +        #address-cells = <1>;
> > > +        #size-cells = <1>;
> > > +
> > > +        reserved@12340000 {
> > > +            compatible = "boot-code";
> > > +            reg = <0x12340000 0x00800000>;
> > > +        };
> > > +
> > > +        reserved@43210000 {
> > > +            compatible = "boot-data";
> > > +            reg = <0x43210000 0x00800000>;
> > > +        };
> > > +    };
> > > --
> > > 2.42.0.515.g380fc7ccd1-goog

Regards,
Simon
