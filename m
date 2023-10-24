Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77633C07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 16:16:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16A86864E8;
	Tue, 24 Oct 2023 18:16:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8555086CEC; Tue, 24 Oct 2023 18:16:51 +0200 (CEST)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com
 [209.85.167.169])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 090E68071F
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 18:16:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robherring2@gmail.com
Received: by mail-oi1-f169.google.com with SMTP id
 5614622812f47-3b2e07e5f3aso2880902b6e.0
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 09:16:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698164206; x=1698769006;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RXPrvqhlemMI7g9xIhmWAAMr6+6qbQ1ZU0REA78QcHI=;
 b=oTuUKrWDefPg/Ij1qlZmKG5khCrsm/WVEHj14ftTRBvYbX2jh7nV09a/B06EqEaUaM
 s+9dDyWkj8FwQrXOdmQdQnInMaaOKI12suxdIynGf88X7uTGTsoqwJcNj/kyj8aJtT1o
 4cf8cadrDgOF727sZWB3rB1O1cXvu223osexwABvrU8kmciqhpwF8LCywSC+/SlaNSmD
 W8YgEg8aPOhaiLosLos/fxYIby1kgKNR3zmJixtZVXndaPmY7Bm36eGIPTAus4NIBtTO
 l/hw4VbY/fjYLZ8BRTDSpcivklKEWVFYLoZ0qgTA5Rj2iBCQKLbqYszpTk0Ftjkkp1qA
 oxHA==
X-Gm-Message-State: AOJu0YzqXiYkHQWMV5RQCZI/8FzlhNLoo+tRl2jYeG9AU8aZklVyegei
 sss7Rl1w17CAnGOF6ZLx/A==
X-Google-Smtp-Source: AGHT+IHcKt9w7bZiBt4/3rwDVdR83Ok9yFwzHM6Yw+yCPtpOKiwL2Yodvx6SUVggzi+iygsVFKZgpg==
X-Received: by 2002:a05:6808:1306:b0:3b2:e379:c11d with SMTP id
 y6-20020a056808130600b003b2e379c11dmr10337541oiv.22.1698164206547; 
 Tue, 24 Oct 2023 09:16:46 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 k2-20020a544702000000b003b2f2724c48sm1975040oik.11.2023.10.24.09.16.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 09:16:45 -0700 (PDT)
Received: (nullmailer pid 4031785 invoked by uid 1000);
 Tue, 24 Oct 2023 16:16:44 -0000
Date: Tue, 24 Oct 2023 11:16:44 -0500
From: Rob Herring <robh@kernel.org>
To: Simon Glass <sjg@chromium.org>
Cc: devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
 Miquel Raynal <miquel.raynal@bootlin.com>, Michael Walle <mwalle@kernel.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] dt-bindings: mtd: binman-partition: Add binman
 compatibles
Message-ID: <20231024161644.GB3707756-robh@kernel.org>
References: <20231009220436.2164245-1-sjg@chromium.org>
 <20231009220436.2164245-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009220436.2164245-2-sjg@chromium.org>
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

On Mon, Oct 09, 2023 at 04:04:14PM -0600, Simon Glass wrote:
> Add two compatible for binman entries, as a starting point for the
> schema.
> 
> Note that, after discussion on v2, we decided to keep the existing
> meaning of label so as not to require changes to existing userspace
> software when moving to use binman nodes to specify the firmware
> layout.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changes in v4:
> - Correct selection of multiple compatible strings
> 
> Changes in v3:
> - Drop fixed-partitions from the example
> - Use compatible instead of label
> 
> Changes in v2:
> - Use plain partition@xxx for the node name
> 
>  .../mtd/partitions/binman-partition.yaml      | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
> new file mode 100644
> index 000000000000..35a320359ec1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2023 Google LLC
> +
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/partitions/binman-partition.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Binman partition
> +
> +maintainers:
> +  - Simon Glass <sjg@chromium.org>
> +
> +select: false

So this schema is never used. 'select: false' is only useful if 
something else if referencing the schema.

> +
> +description: |
> +  This corresponds to a binman 'entry'. It is a single partition which holds
> +  data of a defined type.
> +
> +allOf:
> +  - $ref: /schemas/mtd/partitions/partition.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: binman,entry     # generic binman entry

'binman' is not a vendor. You could add it if you think that's useful. 
Probably not with only 1 case...

> +      - items:
> +          - const: u-boot       # u-boot.bin from U-Boot project
> +          - const: atf-bl31     # bl31.bin or bl31.elf from TF-A project

Probably should use the new 'tfa' rather than old 'atf'. Is this the 
only binary for TFA? The naming seems inconsistent in that every image 
goes in (or can go in) a bl?? section. Why does TFA have it but u-boot 
doesn't? Perhaps BL?? is orthogonal to defining what is in each 
partition. Perhaps someone more familar with all this than I am can 
comment.

Once you actually test this, you'll find you are specifying:

compatible = "u-boot", "atf-bl31";


> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    partitions {
> +        compatible = "binman";
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        partition@100000 {
> +            compatible = "u-boot";
> +            reg = <0x100000 0xf00000>;
> +        };
> +
> +        partition@200000 {
> +            compatible = "atf-bl31";
> +            reg = <0x200000 0x100000>;
> +        };
> +    };
> -- 
> 2.42.0.609.gbb76f46606-goog
> 
