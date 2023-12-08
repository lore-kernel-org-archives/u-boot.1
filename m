Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A66C4167B
	for <u-boot@archiver.kernel.org>; Fri,  8 Dec 2023 17:47:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C4DB8751A;
	Fri,  8 Dec 2023 18:47:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZillBO4M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CEEE8752B; Fri,  8 Dec 2023 18:47:11 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24F2B86EF3
 for <u-boot@lists.denx.de>; Fri,  8 Dec 2023 18:47:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a196f84d217so281813766b.3
 for <u-boot@lists.denx.de>; Fri, 08 Dec 2023 09:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702057628; x=1702662428; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hAJ1WnEzjSjmEz7f7Ppx70QG1I8gsBXxVNcDVYzxKYo=;
 b=ZillBO4MHKKFeNR8YaSaaOQ0HWL5iWHXHjjkTvxDmeDA2VVcP1x8UFXGRREX7lquMV
 YPl2iCGEQUAd5VLosX3+EAD5bLkRm6ieS1tUSshRmCR/w1Mc2AluqPpqblOv9/+0l0Ql
 6G7lJFDRqPdZR6Zco6VPFFl28fIRsc2AlY6kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702057628; x=1702662428;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hAJ1WnEzjSjmEz7f7Ppx70QG1I8gsBXxVNcDVYzxKYo=;
 b=UJVmdl4XvEuORA0jAwFOMUbhAZjtyV0N8z0uKA+0+yfJ2oWalFDPYFufpshAkZ8avm
 RqlQGtFmUV948UqCBw10xDQ9l9BeMbDpQUEDqkII3Z8/X1MvCqqN/nPY6MpmA4OoU+U5
 mVu1kBvQkydtcdZ9dtBhUr6uVf8VityO1cia5033UvfliMTGpCCVXmKXVmhMR70qEiqS
 20KL8S7Xg32T/13PDY7xr1b/wdS0pfqJrjRbHytcpBSlhez077QZu9X6/dEaog2YuafR
 9QvN40quA7MuTSaE7RFN9q5Dae1XbOM3uda5DrfDzjABzUVjmArW/M9zYD5E6Z+AXM45
 pBaw==
X-Gm-Message-State: AOJu0Yzmcqlb5OlvMnqK/qkSN06KGDAxK0iUtyShnPbR9UWFIKHPVyPo
 qxgwwTOtv1siXKpfKjs1Xl2iPdvGmRNYePdF1M5lBg==
X-Google-Smtp-Source: AGHT+IHVlaS5EYXTYlrQruZM+vx0QSh6/N3o/eDY14hRk0UBFA1FHofU1ZiRsQbF3VqXkzoInBKqIDKTJzp/jsjqxTU=
X-Received: by 2002:a17:906:68d9:b0:a19:a1ba:8cfa with SMTP id
 y25-20020a17090668d900b00a19a1ba8cfamr158447ejr.152.1702057628271; Fri, 08
 Dec 2023 09:47:08 -0800 (PST)
MIME-Version: 1.0
References: <20231116172859.393744-1-sjg@chromium.org>
 <20231208150042.GA1278773-robh@kernel.org>
In-Reply-To: <20231208150042.GA1278773-robh@kernel.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 Dec 2023 10:46:51 -0700
Message-ID: <CAPnjgZ2i4gvgiUeHPOfHuOdBooV4e=QQEq6iMo0JbDwOS6dCwA@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: mtd: partitions: Add binman compatible
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>, 
 linux-mtd@lists.infradead.org, Tom Rini <trini@konsulko.com>, 
 Michael Walle <mwalle@kernel.org>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Pratyush Yadav <ptyadav@amazon.de>, 
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-kernel@vger.kernel.org
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

Hi Rob,

On Fri, 8 Dec 2023 at 08:00, Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Nov 16, 2023 at 10:28:50AM -0700, Simon Glass wrote:
> > Add a compatible string for binman, so we can extend fixed-partitions
> > in various ways.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v5)
> >
> > Changes in v5:
> > - Add #address/size-cells and parternProperties
> > - Drop $ref to fixed-partitions.yaml
> > - Drop 'select: false'
> >
> > Changes in v4:
> > - Change subject line
> >
> > Changes in v3:
> > - Drop fixed-partition additional compatible string
> > - Drop fixed-partitions from the example
> > - Mention use of compatible instead of label
> >
> > Changes in v2:
> > - Drop mention of 'enhanced features' in fixed-partitions.yaml
> > - Mention Binman input and output properties
> > - Use plain partition@xxx for the node name
> >
> >  .../bindings/mtd/partitions/binman.yaml       | 68 +++++++++++++++++++
> >  .../bindings/mtd/partitions/partitions.yaml   |  1 +
> >  MAINTAINERS                                   |  5 ++
> >  3 files changed, 74 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
> > new file mode 100644
> > index 000000000000..329217550a98
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
> > @@ -0,0 +1,68 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright 2023 Google LLC
> > +
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mtd/partitions/binman.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Binman firmware layout
> > +
> > +maintainers:
> > +  - Simon Glass <sjg@chromium.org>
> > +
> > +description: |
> > +  The binman node provides a layout for firmware, used when packaging firmware
> > +  from multiple projects. It is based on fixed-partitions, with some
> > +  extensions, but uses 'compatible' to indicate the contents of the node, to
> > +  avoid perturbing or confusing existing installations which use 'label' for a
> > +  particular purpose.
> > +
> > +  Binman supports properties used as inputs to the firmware-packaging process,
> > +  such as those which control alignment of partitions. This binding addresses
> > +  these 'input' properties. For example, it is common for the 'reg' property
> > +  (an 'output' property) to be set by Binman, based on the alignment requested
> > +  in the input.
> > +
> > +  Once processing is complete, input properties have mostly served their
> > +  purpose, at least until the firmware is repacked later, e.g. due to a
> > +  firmware update. The 'fixed-partitions' binding should provide enough
> > +  information to read the firmware at runtime, including decompression if
> > +  needed.
>
> How is this going to work exactly? binman reads these nodes and then
> writes out 'fixed-partitions' nodes. But then you've lost the binman
> specifc parts needed for repacking.

No, they are the same node. I do want the extra information to stick
around. So long as it is compatible with fixed-partition as well, this
should work OK.

Regards,
SImon
