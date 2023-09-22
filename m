Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8089E6FE52
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 15:27:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1F30864DD;
	Fri, 22 Sep 2023 17:27:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bpvl+sJK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0A08864AA; Fri, 22 Sep 2023 17:26:59 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4770686284
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 17:26:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-52bd9ddb741so2726990a12.0
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 08:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695396417; x=1696001217; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ehhS94nOYDx67I5UrhN7dvh/Dlk6jqSDrmSSvlfrbig=;
 b=bpvl+sJKRNksN/BsL0M/5jDB+O/fT3JPtg7Dl6xMdsBqgLH910nbOgeW4UFsB2ol8d
 dpCxI+nLLujYGbsO1mkiRpS74urw/8B/gQuZ3gGUP51gXPD00qCcXd80+HK2pDMgr3C3
 uTsVwo+3P08YMwMcXZmEARyXZlWFVFZplrMpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695396417; x=1696001217;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ehhS94nOYDx67I5UrhN7dvh/Dlk6jqSDrmSSvlfrbig=;
 b=ShbsdHgK8I31RmEyw2nn6TaNEHWWbW3MWQ+vPsgKkZyeVGDa+3I7d8lecg77KhwRoK
 3xdnTrAhcgJaBnKU6l8KjJSVOJ01bSpmmdxjH4cA8U7jYHoMz4Z1mq73UDqkzEbnzErl
 4cWLGK25A8/wSFTWwF9t8HFMxaSRF9MXaYqhX0V0cndgy2LnK54gN2rQqmeOz75NdPtc
 gXWHO5oOo5YoNhrrmOgO7FB6HhcPrz4Q6yqSmrmSa0bTxsXBeol5peu4HxX/LKc+50/s
 BSuIKKzsp8VU9/UKKSvx7F3wANRZQjf7mYwnhJuB8R06E8cS3KWxRdk1z5vTNyfWPBNL
 hEzg==
X-Gm-Message-State: AOJu0Yy894STHdfPzs5b5EE338syfIjWFmKektyGmeRt/051KHBRr+an
 ZRNz6nRMRf3boFHQsEd7T9NY6uicSKedXCuEzll0Lg==
X-Google-Smtp-Source: AGHT+IFoGrL2e/v7oEth7xaYwVHjp41m5T5R1E9Jh7pwjgOEp/hjouucyihvUHkWO43wehoYyZSTEdxlA2dO6pUlS5M=
X-Received: by 2002:aa7:cd18:0:b0:530:c880:9171 with SMTP id
 b24-20020aa7cd18000000b00530c8809171mr8099822edw.27.1695396416625; Fri, 22
 Sep 2023 08:26:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230921124459.1.I91ddcfacf9b234af5cc3eabea4b62edb31153317@changeid>
 <da77e965-2893-097a-b438-85787c43dcb0@linaro.org>
In-Reply-To: <da77e965-2893-097a-b438-85787c43dcb0@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 22 Sep 2023 09:26:38 -0600
Message-ID: <CAPnjgZ2EyWxwCfUi6vHby4tYUfH0Dw6nfC7tOo-g4ahKhTMRjg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mtd: Add a schema for binman
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: devicetree@vger.kernel.org, U-Boot Mailing List <u-boot@lists.denx.de>, 
 linux-mtd@lists.infradead.org, Tom Rini <trini@konsulko.com>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Dhruva Gole <d-gole@ti.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
 Richard Weinberger <richard@nod.at>, Rob Herring <robh+dt@kernel.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
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

Hi Krzysztof,

On Fri, 22 Sept 2023 at 01:02, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 21/09/2023 20:45, Simon Glass wrote:
> > Binman[1] is a tool for creating firmware images. It allows you to
> > combine various binaries and place them in an output file.
> >
> > Binman uses a DT schema to describe an image, in enough detail that
> > it can be automatically built from component parts, disassembled,
> > replaced, listed, etc.
> >
> > Images are typically stored in flash, which is why this binding is
> > targeted at mtd. Previous discussion is at [2] [3].
> >
> > [1] https://u-boot.readthedocs.io/en/stable/develop/package/binman.html
> > [2] https://lore.kernel.org/u-boot/20230821180220.2724080-3-sjg@chromium.org/
> > [3] https://www.spinics.net/lists/devicetree/msg626149.html
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  .../bindings/mtd/partitions/binman.yaml       | 50 +++++++++++++++
> >  .../bindings/mtd/partitions/binman/entry.yaml | 61 +++++++++++++++++++
> >  .../bindings/mtd/partitions/partitions.yaml   |  1 +
> >  MAINTAINERS                                   |  5 ++
> >  4 files changed, 117 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman.yaml
> >  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman/entry.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
> > new file mode 100644
> > index 00000000000000..c792d5a37b700a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
> > @@ -0,0 +1,50 @@
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
> > +  from multiple projects. For now it just supports a very simple set of
> > +  features, as a starting point for discussion.
> > +
> > +  Documentation for Binman is available at:
> > +
> > +  https://u-boot.readthedocs.io/en/latest/develop/package/binman.html
> > +
> > +  with the current image-description format at:
> > +
> > +  https://u-boot.readthedocs.io/en/latest/develop/package/binman.html#image-description-format
> > +
> > +properties:
> > +  compatible:
> > +    const: u-boot,binman
> > +
> > +required:
> > +  - compatible
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    firmware {
> > +      binman {
> > +        compatible = "u-boot,binman";
> > +
> > +        u-boot {
>
> It does not look like you tested the bindings, at least after quick
> look. Please run `make dt_binding_check` (see
> Documentation/devicetree/bindings/writing-schema.rst for instructions).
> Maybe you need to update your dtschema and yamllint.

Yes this came out of dt-schema and I assumed it was similar. I will rework it.

>
>
> > +          size = <0xa0000>;
> > +        };
> > +
> > +        atf-bl31 {
> > +          offset = <0x100000>;
> > +        };
> > +      };
> > +    };
> > diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman/entry.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman/entry.yaml
> > new file mode 100644
> > index 00000000000000..8003eb4f1a994f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/partitions/binman/entry.yaml
> > @@ -0,0 +1,61 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright 2023 Google LLC
> > +
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mtd/partitions/binman/entry.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Binman entry
> > +
> > +maintainers:
> > +  - Simon Glass <sjg@chromium.org>
> > +
> > +description: |
> > +  The entry node specifies a single entry in the firmware.
> > +
> > +  Entries have a specific type, such as "u-boot" or "atf-bl31". If the type
> > +  is missing, the name is used as the type.
> > +
> > +  Note: This definition is intended to be hierarchical, so that entries can
> > +  appear in other entries. Schema for that is TBD.
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: "^[-a-z]+(-[0-9]+)?$"
>
> Why do you need this?

It seemed to be needed in dt-schema. I will drop it.
Regards,
Simon
