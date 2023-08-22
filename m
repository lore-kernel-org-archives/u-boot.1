Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBFFEEE49AB
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 18:53:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50A6185CB5;
	Tue, 22 Aug 2023 20:53:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mNV0oY6d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45A9C864A6; Tue, 22 Aug 2023 20:53:01 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED802855CE
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 20:52:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=robh@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 1ECC665D48
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 18:52:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81991C433C7
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 18:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692730375;
 bh=y2UELRC+XrfrXIM+d1BDwygTgdYn21N6QRXFuKS7+aI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=mNV0oY6dloiYoJX/7q5qbg/uqnNeprKkg4mGaVd7UTCBTwxf7z9L5nAapNlV90Rss
 sDE/cMuDC326VPLmunXf68EHPmsUaRD/BRkYr8gtZjanH0jNeA95x+zB6Yi26tg1SM
 O3UuuvrrEPciTyvjX7Yb+aXvKepEcc04c7ozzej+TG3DdfvPZhAg4nL8Vyzn3RJPYh
 ZXgJjQqQpE/pe3adSfqZQ/nf/3KpSwOZU6DG4kmjmmdjlzsYpQrggC0O89LkUYJgmk
 xM5ACCkUkqAfU7e3OcZMLyiAW5MJfFl8iqT9REnaBgUU5QSnqM64VHVVCLv6XngA77
 gWenBzj5gZuzQ==
Received: by mail-lj1-f178.google.com with SMTP id
 38308e7fff4ca-2bcb89b476bso44422951fa.1
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 11:52:55 -0700 (PDT)
X-Gm-Message-State: AOJu0YxXq6pqoUPS9I0+KvmJssEUWyqweUgP8ej2Cj9u6ggCPu/AzSe3
 Ll51dDRm3cL1Xe7DtPXsxmJlRtnOLbji5ITefg==
X-Google-Smtp-Source: AGHT+IEEMIR41THd0LMOBZubTsjgagaLMHV572WPlVXzbt4x3ZGS4hiPTCQhKUt6KcVET9reHOKhSgkJ+dgKFh2X5wU=
X-Received: by 2002:a2e:b049:0:b0:2bc:c38a:bd7c with SMTP id
 d9-20020a2eb049000000b002bcc38abd7cmr4455281ljl.33.1692730373473; Tue, 22 Aug
 2023 11:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230821194821.2961213-1-sjg@chromium.org>
In-Reply-To: <20230821194821.2961213-1-sjg@chromium.org>
From: Rob Herring <robh@kernel.org>
Date: Tue, 22 Aug 2023 13:52:40 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+jYexj8CR86cktxeiXyo7X+8i35+Ao0GBMhinVPNUoEw@mail.gmail.com>
Message-ID: <CAL_Jsq+jYexj8CR86cktxeiXyo7X+8i35+Ao0GBMhinVPNUoEw@mail.gmail.com>
Subject: Re: [PATCH v2] schemas: Add a schema for memory map
To: Simon Glass <sjg@chromium.org>
Cc: devicetree@vger.kernel.org, Lean Sheng Tan <sheng.tan@9elements.com>, 
 Tom Rini <trini@konsulko.com>, lkml <linux-kernel@vger.kernel.org>, 
 linux-acpi@vger.kernel.org, Chiu Chasel <chasel.chiu@intel.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>, Gua Guo <gua.guo@intel.com>
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

On Mon, Aug 21, 2023 at 2:48=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> The Devicespec specification skips over handling of a logical view of
> the memory map, pointing users to the UEFI specification.

It's more that the DT spec defines what is not used with UEFI. If UEFI
covers more than the DT Spec defined, then we should look at that.

I would look some into (IBM) PowerPC for any prior art in this area.
Unfortunately, not publicly documented other than any users.

> It is common to split firmware into 'Platform Init', which does the
> initial hardware setup and a "Payload" which selects the OS to be booted.
> Thus an handover interface is required between these two pieces.
>
> Where UEFI boot-time services are not available, but UEFI firmware is
> present on either side of this interface, information about memory usage
> and attributes must be presented to the "Payload" in some form.
>
> This aims to provide an initial schema for this mapping.
>
> Note that this is separate from the existing /memory and /reserved-memory
> nodes, since it is mostly concerned with what the memory is used for. It
> may cover only a small fraction of available memory, although it could be
> used to signal which area of memory has ECC.
>
> For now, no attempt is made to create an exhaustive binding, so there are
> some example types lists. This can be completed once this has passed
> initial review.

I don't have much interest in picking this up unless there's some
wider agreement. From the previously referenced discussion[1], it
didn't seem like there was. But none of those folk are Cc'ed here.

> ---
>
> Changes in v2:
> - Reword commit message
>
>  dtschema/schemas/memory-map.yaml | 51 ++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 dtschema/schemas/memory-map.yaml
>
> diff --git a/dtschema/schemas/memory-map.yaml b/dtschema/schemas/memory-m=
ap.yaml
> new file mode 100644
> index 0000000..97e531e
> --- /dev/null
> +++ b/dtschema/schemas/memory-map.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: BSD-2-Clause
> +# Copyright 2023 Google LLC
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/memory-map.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: /memory-map nodes
> +description: |
> +  Common properties always required in /memory-map nodes. These nodes ar=
e
> +  intended to resolve the nonchalant clause 3.4.1 ("/memory node and UEF=
I")
> +  in the Devicetree Specification.
> +
> +maintainers:
> +  - Simon Glass <sjg@chromium.org>
> +
> +properties:
> +  $nodename:
> +    const: '/'

This goes in the root node?

> +  usage:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: |
> +      Describes the usage of the memory region, e.g.:
> +
> +        "acpi-reclaim", "acpi-nvs", "bootcode", "bootdata", "bootdata",
> +        "runtime-code", "runtime-data"

Can't these be covered by reserved-memory? The client is free to
reclaim any regions if it knows what they are.

> +  attr:
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +    description: |
> +      Attributes possessed by this memory region:
> +
> +        "single-bit-ecc" - supports single-bit ECC
> +        "multi-bit-ecc" - supports multiple-bit ECC
> +        "no-ecc" - non-ECC memory

Isn't this pretty much a property of a memory region as a whole. IOW,
couldn't it just go into /memory node(s)?

> +
> +patternProperties:
> +  "^([a-z][a-z0-9\\-]+@[0-9a-f]+)?$":
> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      reg:
> +        minItems: 1
> +        maxItems: 1024
> +
> +    required:
> +      - reg
> +
> +additionalProperties: true
> +
> +...
> --
> 2.42.0.rc1.204.g551eb34607-goog

[1] https://patches.linaro.org/project/linux-acpi/patch/20230426034001.16-1=
-cuiyunhui@bytedance.com/
