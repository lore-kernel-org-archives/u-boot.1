Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A202EC4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 17:27:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB41087AF1;
	Thu, 14 Dec 2023 18:27:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16F3987AF0; Thu, 14 Dec 2023 18:27:09 +0100 (CET)
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com
 [209.85.161.49])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 799EE8767C
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 18:27:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robherring2@gmail.com
Received: by mail-oo1-f49.google.com with SMTP id
 006d021491bc7-590a2a963baso4003683eaf.2
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 09:27:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702574825; x=1703179625;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bvlPaOvWZi6YT4dBhvJqrCk9Wves4WI6vEv3aL4+FYg=;
 b=hEWGInWrDaSCPG2QQt0WNnYQK1x5HAlef9pOvH3ZlsLE73VPDoQrfKGuwBb4/vq6ep
 XcjzfuDSNsRnByqzeRR13VPjGetUMawFmDlzegd6tRuUNbtpadZcmEvB7oLJIQjhY17M
 bvv/AzfcE/PHZpYn0+ftk9TMiCUFasV7Rk1+aMYt9tLBYVpeoaksEAlJuXyVt/CPck3o
 2KwivrQaGs4y8ba0CRR7DDAkH+cJ4CnGvErx5LmMLQ9Q40H2PKz7tX6A8z0FxdqvCavm
 Z9tPWK+9JqXRsu5CdFkjabptcNL0xqtDiKDIuScHZVg6etWx4PqjK77SajkvtJE2I9EQ
 DveQ==
X-Gm-Message-State: AOJu0YxjHuSIdJ5Noz0afscman3qgRWKADjybew9NEIkQSmMKg/74EjV
 7LKALC+26kFgU2/n2VjYRg==
X-Google-Smtp-Source: AGHT+IHE3yB7iPFgi1CEIf18XQ6wLVZQxOJa4peKJpfxlxe4KfiUfxamVgaQaN9eMO+YHnRGmAJgUg==
X-Received: by 2002:a05:6820:162c:b0:590:6f86:f3c6 with SMTP id
 bb44-20020a056820162c00b005906f86f3c6mr8302579oob.12.1702574825070; 
 Thu, 14 Dec 2023 09:27:05 -0800 (PST)
Received: from herring.priv ([2607:fb91:e6c7:a40:1c2d:b875:912d:c28])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a056820028c00b0058d52d0ef2dsm3456842ood.38.2023.12.14.09.27.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 09:27:04 -0800 (PST)
Received: (nullmailer pid 622570 invoked by uid 1000);
 Thu, 14 Dec 2023 17:27:02 -0000
Date: Thu, 14 Dec 2023 11:27:02 -0600
From: Rob Herring <robh@kernel.org>
To: Simon Glass <sjg@chromium.org>
Cc: devicetree@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-mtd@lists.infradead.org, Tom Rini <trini@konsulko.com>,
 Michael Walle <mwalle@kernel.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Pratyush Yadav <ptyadav@amazon.de>,
 =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/3] dt-bindings: mtd: partitions: Add binman compatible
Message-ID: <20231214172702.GA617226-robh@kernel.org>
References: <20231116172859.393744-1-sjg@chromium.org>
 <20231208150042.GA1278773-robh@kernel.org>
 <CAPnjgZ2i4gvgiUeHPOfHuOdBooV4e=QQEq6iMo0JbDwOS6dCwA@mail.gmail.com>
 <CAL_Jsq+xMZ8yz4H9D59uCSyX4h5W+4ruGF++=wVA=msXz+Y01A@mail.gmail.com>
 <CAPnjgZ1uW8T6woXSqFUNm301=W3zBYOrADREkrz=DuwSW87qZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPnjgZ1uW8T6woXSqFUNm301=W3zBYOrADREkrz=DuwSW87qZg@mail.gmail.com>
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

On Fri, Dec 08, 2023 at 03:58:10PM -0700, Simon Glass wrote:
> Hi Rob,
> 
> On Fri, 8 Dec 2023 at 14:56, Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, Dec 8, 2023 at 11:47 AM Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Rob,
> > >
> > > On Fri, 8 Dec 2023 at 08:00, Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Thu, Nov 16, 2023 at 10:28:50AM -0700, Simon Glass wrote:
> > > > > Add a compatible string for binman, so we can extend fixed-partitions
> > > > > in various ways.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > > (no changes since v5)
> > > > >
> > > > > Changes in v5:
> > > > > - Add #address/size-cells and parternProperties
> > > > > - Drop $ref to fixed-partitions.yaml
> > > > > - Drop 'select: false'
> > > > >
> > > > > Changes in v4:
> > > > > - Change subject line
> > > > >
> > > > > Changes in v3:
> > > > > - Drop fixed-partition additional compatible string
> > > > > - Drop fixed-partitions from the example
> > > > > - Mention use of compatible instead of label
> > > > >
> > > > > Changes in v2:
> > > > > - Drop mention of 'enhanced features' in fixed-partitions.yaml
> > > > > - Mention Binman input and output properties
> > > > > - Use plain partition@xxx for the node name
> > > > >
> > > > >  .../bindings/mtd/partitions/binman.yaml       | 68 +++++++++++++++++++
> > > > >  .../bindings/mtd/partitions/partitions.yaml   |  1 +
> > > > >  MAINTAINERS                                   |  5 ++
> > > > >  3 files changed, 74 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman.yaml
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
> > > > > new file mode 100644
> > > > > index 000000000000..329217550a98
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
> > > > > @@ -0,0 +1,68 @@
> > > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > > +# Copyright 2023 Google LLC
> > > > > +
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/mtd/partitions/binman.yaml#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: Binman firmware layout
> > > > > +
> > > > > +maintainers:
> > > > > +  - Simon Glass <sjg@chromium.org>
> > > > > +
> > > > > +description: |
> > > > > +  The binman node provides a layout for firmware, used when packaging firmware
> > > > > +  from multiple projects. It is based on fixed-partitions, with some
> > > > > +  extensions, but uses 'compatible' to indicate the contents of the node, to
> > > > > +  avoid perturbing or confusing existing installations which use 'label' for a
> > > > > +  particular purpose.
> > > > > +
> > > > > +  Binman supports properties used as inputs to the firmware-packaging process,
> > > > > +  such as those which control alignment of partitions. This binding addresses
> > > > > +  these 'input' properties. For example, it is common for the 'reg' property
> > > > > +  (an 'output' property) to be set by Binman, based on the alignment requested
> > > > > +  in the input.
> > > > > +
> > > > > +  Once processing is complete, input properties have mostly served their
> > > > > +  purpose, at least until the firmware is repacked later, e.g. due to a
> > > > > +  firmware update. The 'fixed-partitions' binding should provide enough
> > > > > +  information to read the firmware at runtime, including decompression if
> > > > > +  needed.
> > > >
> > > > How is this going to work exactly? binman reads these nodes and then
> > > > writes out 'fixed-partitions' nodes. But then you've lost the binman
> > > > specifc parts needed for repacking.
> > >
> > > No, they are the same node. I do want the extra information to stick
> > > around. So long as it is compatible with fixed-partition as well, this
> > > should work OK.
> >
> > How can it be both? The partitions node compatible can be either
> > 'fixed-partitions' or 'binman'.
> 
> Can we not allow it to be both? I have tried to adjust things in
> response to feedback but perhaps the feedback was leading me down the
> wrong path?

Sure, but then the schema has to and that means extending 
fixed-partitions.

Rob
