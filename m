Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B633CC10F05
	for <u-boot@archiver.kernel.org>; Fri,  8 Dec 2023 15:00:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E02FA874FB;
	Fri,  8 Dec 2023 16:00:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 869778754A; Fri,  8 Dec 2023 16:00:49 +0100 (CET)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com
 [209.85.210.53])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD5AA803AE
 for <u-boot@lists.denx.de>; Fri,  8 Dec 2023 16:00:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robherring2@gmail.com
Received: by mail-ot1-f53.google.com with SMTP id
 46e09a7af769-6d9dc789f23so1036733a34.3
 for <u-boot@lists.denx.de>; Fri, 08 Dec 2023 07:00:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702047645; x=1702652445;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yhQWuvNrfy0nDTet/URpa1HIQtUWnl4nOPZplCeKz7Q=;
 b=UJ0CzAEgmFIRqeKeijGt/OvI98M9426j+zvD4ukcyxwqMGzkdSUnkOCHC/A3kafKhv
 +/nZOxqdJlmPq2GB+PjUrJRbm1NeTHIhDhoL4V8ViWGCuAWyC74FXVnk8z3K5voeBRCi
 lSsT+3IqLQ3tgNKDa4gxQUvGQ6gXqsmJwOwJlyg1UE88WYlsnBfpZeGNwJIUKagODx0U
 iHYz7oYPjBbwjjp0cmTsqZt/qBS/XdkzukmWoOk2+gYeo+2MxgTaE3ZQkmhCZMgUQ+he
 9T3tPAi+Sei1fwC2qMmkzYrXl3KgfEeVHDFjFNXBdWW5KUf+8BYueK38HL9/+oDzBy8u
 /zNg==
X-Gm-Message-State: AOJu0Ywk7Pv5ciMLspdJV0h7veQMDVTcVt7OUcvl3W8wA7IadHLPzCMh
 0jnEiWHS+e9aea9m75VCrQ==
X-Google-Smtp-Source: AGHT+IFNLtyInrOf9nIFSbmfUtQCKSgkpfe0CHZ/yGXwzd/BlzrMLoh/hXXynLP9bXaT2VnqR+WYNQ==
X-Received: by 2002:a05:6830:110f:b0:6d9:ef4a:82db with SMTP id
 w15-20020a056830110f00b006d9ef4a82dbmr203527otq.13.1702047644628; 
 Fri, 08 Dec 2023 07:00:44 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 bn20-20020a0568300c9400b006d9e756fac2sm283283otb.51.2023.12.08.07.00.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Dec 2023 07:00:43 -0800 (PST)
Received: (nullmailer pid 1287216 invoked by uid 1000);
 Fri, 08 Dec 2023 15:00:42 -0000
Date: Fri, 8 Dec 2023 09:00:42 -0600
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
Message-ID: <20231208150042.GA1278773-robh@kernel.org>
References: <20231116172859.393744-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116172859.393744-1-sjg@chromium.org>
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

On Thu, Nov 16, 2023 at 10:28:50AM -0700, Simon Glass wrote:
> Add a compatible string for binman, so we can extend fixed-partitions
> in various ways.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v5)
> 
> Changes in v5:
> - Add #address/size-cells and parternProperties
> - Drop $ref to fixed-partitions.yaml
> - Drop 'select: false'
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
>  .../bindings/mtd/partitions/binman.yaml       | 68 +++++++++++++++++++
>  .../bindings/mtd/partitions/partitions.yaml   |  1 +
>  MAINTAINERS                                   |  5 ++
>  3 files changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
> new file mode 100644
> index 000000000000..329217550a98
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
> @@ -0,0 +1,68 @@
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

How is this going to work exactly? binman reads these nodes and then 
writes out 'fixed-partitions' nodes. But then you've lost the binman 
specifc parts needed for repacking.

Rob
