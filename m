Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8238CC07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 21:41:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D94578706C;
	Tue, 24 Oct 2023 23:41:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cmpoZmjG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE35486FBE; Tue, 24 Oct 2023 23:41:09 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6793C86F69
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 23:41:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5079f3f3d7aso7863202e87.1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 14:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698183666; x=1698788466; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8/l3iCnOIbHxgn209fI6Ue3Dyqs1H9WjYDgBhKPc4nY=;
 b=cmpoZmjGJV77htWeObknbQF1dRveepCKcEiIv/ab5jFkdpIgk+ha3LDzK2o8c4XT89
 5+44V5Hd9Kx8UGLfSqLiE3M2CK1u8JUWvmOnaN9qHK9DYWvOqvCScki9CAeRfsQJJTSv
 IrCc3+m9iGS4C9p4Vubm/sAcLps7W2NLZsmrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698183666; x=1698788466;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8/l3iCnOIbHxgn209fI6Ue3Dyqs1H9WjYDgBhKPc4nY=;
 b=NSVpgUCUVrp1XU2A5b+9EIQFpk69A8uLXtEjtGW8hY3x0D6UFNprPlKAd1qS8W60u5
 T4t9PiFqHkBqEO2+duomAi7fy3JAS+u9HKlcx0A5f40/Ydj7D1ONEFMrXbzAyDNUPGew
 KtIG0CVZROgtE9d+027SqR1goEXTUoRJ330M0HfCBsM61xiUQB5HVhV6DkGgQRt0VWyT
 k1VyLsUutfHF7nqLfc/gts8g9uKx6kCWfnfAAdk3P6/pLXwi/PyqCd1ew30VJ1uxPNR8
 8+hkTAEyDJzOBVk77iF4aYuSbYXMLKYeqELw102yOPzH96rHex6GrbF8eEKc7XhEeJoQ
 7+Qw==
X-Gm-Message-State: AOJu0YxfwVeDnSIFoMCxKjzcgbFzFRab7Fed5IbnznePwBL6PNRi3GQV
 gwKcK+00WJMItFnmF/F9fpWqlU7l1rbQCcylLcHCKQ==
X-Google-Smtp-Source: AGHT+IFScWIum/OTHr5wNhT1S/G7FDAmrtGJXwLdpLF1M/LYqy7vRAiXQHkkcwQgTLFDVP6Hd+bZsDD/O+/8wNKhQNw=
X-Received: by 2002:a05:6512:3a8e:b0:507:a1e5:74fe with SMTP id
 q14-20020a0565123a8e00b00507a1e574femr11574219lfu.54.1698183666243; Tue, 24
 Oct 2023 14:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <20231009220436.2164245-1-sjg@chromium.org>
 <20231009220436.2164245-2-sjg@chromium.org>
 <20231024161644.GB3707756-robh@kernel.org>
In-Reply-To: <20231024161644.GB3707756-robh@kernel.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 24 Oct 2023 14:40:54 -0700
Message-ID: <CAPnjgZ0G3W0a1T5TMuS_8L+4OwqFU3xXBKPnTs+MDDFBWYP_VA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: mtd: binman-partition: Add binman
 compatibles
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-mtd@lists.infradead.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Michael Walle <mwalle@kernel.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Richard Weinberger <richard@nod.at>, 
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

Hi Rob,

On Tue, 24 Oct 2023 at 09:16, Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Oct 09, 2023 at 04:04:14PM -0600, Simon Glass wrote:
> > Add two compatible for binman entries, as a starting point for the
> > schema.
> >
> > Note that, after discussion on v2, we decided to keep the existing
> > meaning of label so as not to require changes to existing userspace
> > software when moving to use binman nodes to specify the firmware
> > layout.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v4:
> > - Correct selection of multiple compatible strings
> >
> > Changes in v3:
> > - Drop fixed-partitions from the example
> > - Use compatible instead of label
> >
> > Changes in v2:
> > - Use plain partition@xxx for the node name
> >
> >  .../mtd/partitions/binman-partition.yaml      | 49 +++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
> > new file mode 100644
> > index 000000000000..35a320359ec1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
> > @@ -0,0 +1,49 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright 2023 Google LLC
> > +
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mtd/partitions/binman-partition.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Binman partition
> > +
> > +maintainers:
> > +  - Simon Glass <sjg@chromium.org>
> > +
> > +select: false
>
> So this schema is never used. 'select: false' is only useful if
> something else if referencing the schema.

OK. Is there a user guide to this somewhere? I really don't understand
it very well.

>
> > +
> > +description: |
> > +  This corresponds to a binman 'entry'. It is a single partition which holds
> > +  data of a defined type.
> > +
> > +allOf:
> > +  - $ref: /schemas/mtd/partitions/partition.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - const: binman,entry     # generic binman entry
>
> 'binman' is not a vendor. You could add it if you think that's useful.
> Probably not with only 1 case...

I think it is best to use this for generic things implemented by
binman, rather than some other project. For example, binman supports a
'fill' region. It also supports sections which are groups of
sub-entries. So we will likely start with half a dozen of these and it
will likely grow: binman,fill, binman,section, binman,files

If we don't use 'binman', what do you suggest?

>
> > +      - items:
> > +          - const: u-boot       # u-boot.bin from U-Boot project
> > +          - const: atf-bl31     # bl31.bin or bl31.elf from TF-A project
>
> Probably should use the new 'tfa' rather than old 'atf'. Is this the
> only binary for TFA? The naming seems inconsistent in that every image
> goes in (or can go in) a bl?? section. Why does TFA have it but u-boot
> doesn't? Perhaps BL?? is orthogonal to defining what is in each
> partition. Perhaps someone more familar with all this than I am can
> comment.

From what I can tell TF-A can produce all sorts of binaries, of which
bl31 is one. U-Boot can also produce lots of binaries, but its naming
is different (u-boot, u-boot-spl, etc.). Bear in mind that U-Boot is
used on ARM, where this terminology is defined, and on x86 (for
example), where it is not.

>
> Once you actually test this, you'll find you are specifying:
>
> compatible = "u-boot", "atf-bl31";

I don't understand that, sorry. I'll send a v5 and see if the problem goes away.

>
>
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    partitions {
> > +        compatible = "binman";
> > +        #address-cells = <1>;
> > +        #size-cells = <1>;
> > +
> > +        partition@100000 {
> > +            compatible = "u-boot";
> > +            reg = <0x100000 0xf00000>;
> > +        };
> > +
> > +        partition@200000 {
> > +            compatible = "atf-bl31";
> > +            reg = <0x200000 0x100000>;
> > +        };
> > +    };
> > --
> > 2.42.0.609.gbb76f46606-goog
> >

Regards,
Simon
