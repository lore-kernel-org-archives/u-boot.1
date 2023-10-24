Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57989C00A8F
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 15:57:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFB49871ED;
	Tue, 24 Oct 2023 17:57:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1320875B1; Tue, 24 Oct 2023 17:57:33 +0200 (CEST)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 360D186FFE
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 17:57:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robherring2@gmail.com
Received: by mail-ot1-f47.google.com with SMTP id
 46e09a7af769-6ce2de8da87so3039711a34.1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 08:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698163050; x=1698767850;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NHcRvpJFapb0Q3P+9BlCR7HD1XqDuZe4P3/x1wWBCyM=;
 b=rAEtcQocNPmipUBtlhtZA5NZ9fmJBDRKoUhbfzPSLTpJ4BqgDMVQYTEvtoLM2+6LtF
 gWygqpiD4lIDQMa/IAIDUiyTVRkhRXYSK52Bg4Af6YL+YmjGkoEuRmcthlEdWU+fI7cJ
 XUsHmy/ugv3d+GJ7Y9W4leXwnxROEv3k7957gNxZ22EpP745W3FYc6b7bwc/nSSkemBc
 1KMq7xi3ih9AppOAsbUAGgjvwYqQ7druuxtVWb82lwx09ix7E8AIXTQE5J2vaH2NU4eP
 H60YCdc5uEriXNPOEaJVHJIVHfhe/DEj76XhN8nPZgvmcdNC8j1qCUoO43C8rQerL3bk
 Whnw==
X-Gm-Message-State: AOJu0Yxy2VXSPf9GSCvMUYo3skRSB6gQXcE1Dh7x0+/8cdvb0jE+KiIL
 lWh6OmlX7e6/Jy6eDZueXw==
X-Google-Smtp-Source: AGHT+IGHYmHNXEiTTfwOzmFz01R3ZgSU10kI3zUH744k0D8HWbiWLtUy7kIW318y+4z87Hn4RJxUqA==
X-Received: by 2002:a9d:618d:0:b0:6b9:26ce:5e5c with SMTP id
 g13-20020a9d618d000000b006b926ce5e5cmr13881917otk.31.1698163049764; 
 Tue, 24 Oct 2023 08:57:29 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 f3-20020a4ae603000000b0057b74352e3asm1986286oot.25.2023.10.24.08.57.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 08:57:29 -0700 (PDT)
Received: (nullmailer pid 3929057 invoked by uid 1000);
 Tue, 24 Oct 2023 15:57:28 -0000
Date: Tue, 24 Oct 2023 10:57:28 -0500
From: Rob Herring <robh@kernel.org>
To: Simon Glass <sjg@chromium.org>
Cc: devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
 Miquel Raynal <miquel.raynal@bootlin.com>, Michael Walle <mwalle@kernel.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>,
 Conor Dooley <conor+dt@kernel.org>, Dhruva Gole <d-gole@ti.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: mtd: partitions: Add binman compatible
Message-ID: <20231024155728.GA3707756-robh@kernel.org>
References: <20231009220436.2164245-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009220436.2164245-1-sjg@chromium.org>
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

On Mon, Oct 09, 2023 at 04:04:13PM -0600, Simon Glass wrote:
> Add a compatible string for binman, so we can extend fixed-partitions
> in various ways.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changes in v4:
> - Change subject line
> 
> Changes in v3:
> - Drop fixed-partition additional compatible string
> - Drop fixed-partitions from the example
> - Mention use of compatible instead of label
> 
> Changes in v2:
> - Drop mention of 'enhanced features' in fixed-partitions.yaml
> - Mention Binman input and output properties
> - Use plain partition@xxx for the node name
> 
>  .../bindings/mtd/partitions/binman.yaml       | 63 +++++++++++++++++++
>  .../bindings/mtd/partitions/partitions.yaml   |  1 +
>  MAINTAINERS                                   |  5 ++
>  3 files changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
> new file mode 100644
> index 000000000000..7d6c8bd738f5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2023 Google LLC
> +
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/partitions/binman.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Binman firmware layout
> +
> +maintainers:
> +  - Simon Glass <sjg@chromium.org>
> +
> +select: false
> +
> +description: |
> +  The binman node provides a layout for firmware, used when packaging firmware
> +  from multiple projects. It is based on fixed-partitions, with some
> +  extensions, but uses 'compatible' to indicate the contents of the node, to
> +  avoid perturbing or confusing existing installations which use 'label' for a
> +  particular purpose.
> +
> +  Binman supports properties used as inputs to the firmware-packaging process,
> +  such as those which control alignment of partitions. This binding addresses
> +  these 'input' properties. For example, it is common for the 'reg' property
> +  (an 'output' property) to be set by Binman, based on the alignment requested
> +  in the input.
> +
> +  Once processing is complete, input properties have mostly served their
> +  purpose, at least until the firmware is repacked later, e.g. due to a
> +  firmware update. The 'fixed-partitions' binding should provide enough
> +  information to read the firmware at runtime, including decompression if
> +  needed.
> +
> +  Documentation for Binman is available at:
> +
> +  https://u-boot.readthedocs.io/en/latest/develop/package/binman.html
> +
> +  with the current image-description format at:
> +
> +  https://u-boot.readthedocs.io/en/latest/develop/package/binman.html#image-description-format
> +
> +allOf:
> +  - $ref: /schemas/mtd/partitions/fixed-partitions.yaml#
> +
> +properties:
> +  compatible:
> +    const: binman

This couldn't possibly pass validation. Including fixed-partitions.yaml 
says the compatible must be one thing and this says something else.

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
> +            label = "u-boot";
> +            reg = <0x100000 0xf00000>;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
> index 1dda2c80747b..849fd15d085c 100644
> --- a/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
> +++ b/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
> @@ -15,6 +15,7 @@ maintainers:
>  
>  oneOf:
>    - $ref: arm,arm-firmware-suite.yaml
> +  - $ref: binman.yaml
>    - $ref: brcm,bcm4908-partitions.yaml
>    - $ref: brcm,bcm947xx-cfe-partitions.yaml
>    - $ref: fixed-partitions.yaml
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c934244acc31..ebc8158fe67d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3536,6 +3536,11 @@ F:	Documentation/filesystems/bfs.rst
>  F:	fs/bfs/
>  F:	include/uapi/linux/bfs_fs.h
>  
> +BINMAN
> +M:	Simon Glass <sjg@chromium.org>
> +S:	Supported
> +F:	Documentation/devicetree/bindings/mtd/partitions/binman*
> +
>  BITMAP API
>  M:	Yury Norov <yury.norov@gmail.com>
>  R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> -- 
> 2.42.0.609.gbb76f46606-goog
> 
