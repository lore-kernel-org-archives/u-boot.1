Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA0FC0015E
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 19:03:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD80A8671F;
	Tue, 15 Aug 2023 21:03:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YL2Ho28H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA91086384; Tue, 15 Aug 2023 21:03:44 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFB9686994
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 21:03:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2b9d3dacb33so89517661fa.1
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 12:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692126221; x=1692731021;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xNf/vg0VHgK6MAJZ+4f3hn/wGev5cCXSUtoD0fHhHKg=;
 b=YL2Ho28HTU0VMkKopaQe1YQVne2FuShMJ8d5drwy4TFR6mBfyzM4mYE75iyS9rxjv7
 CNFEdvJgN4d+yvE81r8lclwQVlpdipcrNfqrsV/MXw8MukNknV1/yOtEyW3tyytkCoaf
 7/wBox5i/p2Y6EMm+YJfJUaiL2YnQsECfWRVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692126221; x=1692731021;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xNf/vg0VHgK6MAJZ+4f3hn/wGev5cCXSUtoD0fHhHKg=;
 b=GwBfJ9XDxBotgHCAFH062uUIYqidJuvvf8JzYS/8ukT8RJOOsNF9HcATk/3/TrfvnX
 GfuGGnVjjMnMHOykg6ugS/w9KjPp6zNv1nHvMiNomw5UhLj9wt5j9Aor4v5kIJn6Qqy1
 5zLN1pr8XXvae/z65r2zghuxh4yYcAiFDUmJHamgFAOn57CcPBGjoDFeZJ91xA141jNn
 atP/hlBAkoa63yg0wEfqTg/wCA9MZVEsV4XQucB9JVg66ykcbXVDYSl+xHJuq/6KfbJF
 fpCgnwK/GA7JRm0z7FEPsxurly+08xMci+dGsg1ZAaDI125szii7oqI/jI5edzyneP5M
 0cRA==
X-Gm-Message-State: AOJu0Yxm/ZlcESfYgsaqBuD9jVEOxd2KE0gTaEGO8uRZUifgZMftrRKA
 mTdbsvv5VyzL/d6W8ZClrD+t6dCh0og3PYSA3Hu9dg==
X-Google-Smtp-Source: AGHT+IF+MSgmvtFzLKRmsmGwyzCr/GNhleam5Atw6PVSg5ipNeWXL2evwmeogJ/jFjhP/wgge5H4A/7rmcPuA0UVwDs=
X-Received: by 2002:a2e:8950:0:b0:2bb:8d96:6041 with SMTP id
 b16-20020a2e8950000000b002bb8d966041mr1825415ljk.45.1692126220858; Tue, 15
 Aug 2023 12:03:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230811215743.3111594-1-sjg@chromium.org>
In-Reply-To: <20230811215743.3111594-1-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 15 Aug 2023 13:03:29 -0600
Message-ID: <CAPnjgZ3O=iYnU1ghMNXxQOtnMR+DTs6jwaHN+KrYzjy_Z-mG0Q@mail.gmail.com>
Subject: Re: [PATCH] schemas: Add a schema for memory map
To: Devicetree Discuss <devicetree@vger.kernel.org>
Cc: Rob Herring <robh@kernel.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Gua Guo <gua.guo@intel.com>, 
 Lean Sheng Tan <sheng.tan@9elements.com>, Tom Rini <trini@konsulko.com>, 
 Chiu Chasel <chasel.chiu@intel.com>
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

+linux-acpi@vger.kernel.org
+lk

Since there was a related discussion here:
https://patches.linaro.org/project/linux-acpi/patch/20230426034001.16-1-cuiyunhui@bytedance.com/

On Fri, 11 Aug 2023 at 15:57, Simon Glass <sjg@chromium.org> wrote:
>
> The Devicespec specification skips over handling of a logical view of
> the memory map, pointing users to the UEFI specification.
>
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
> For now, no attempt is made to create an exhaustive binding, but this can
> be completed once this has passed initial review.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  dtschema/schemas/memory-map.yaml | 51 ++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 dtschema/schemas/memory-map.yaml
>
> diff --git a/dtschema/schemas/memory-map.yaml b/dtschema/schemas/memory-map.yaml
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
> +  Common properties always required in /memory-map nodes. These nodes are
> +  intended to resolve the nonchalant clause 3.4.1 ("/memory node and UEFI")
> +  in the Devicetree Specification.
> +
> +maintainers:
> +  - Simon Glass <sjg@chromium.org>
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  usage:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: |
> +      Describes the usage of the memory region, e.g.:
> +
> +        "acpi-reclaim", "acpi-nvs", "bootcode", "bootdata", "bootdata",
> +        "runtime-code", "runtime-data"
> +  attr:
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +    description: |
> +      Attributes possessed by this memory region:
> +
> +        "single-bit-ecc" - supports single-bit ECC
> +        "multi-bit-ecc" - supports multiple-bit ECC
> +        "no-ecc" - non-ECC memory
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
> 2.41.0.694.ge786442a9b-goog
>
