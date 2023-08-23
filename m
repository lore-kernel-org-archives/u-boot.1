Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7D7EE4993
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 08:59:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97882864A6;
	Wed, 23 Aug 2023 10:59:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21359864AA; Wed, 23 Aug 2023 10:59:06 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 8A7DC86489
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 10:59:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.rutland@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E50D1042;
 Wed, 23 Aug 2023 01:59:43 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.3.204])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A51B53F740;
 Wed, 23 Aug 2023 01:59:00 -0700 (PDT)
Date: Wed, 23 Aug 2023 09:58:54 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Simon Glass <sjg@chromium.org>
Cc: devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Chiu Chasel <chasel.chiu@intel.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Gua Guo <gua.guo@intel.com>, linux-acpi@vger.kernel.org,
 lkml <linux-kernel@vger.kernel.org>, Yunhui Cui <cuiyunhui@bytedance.com>,
 ron minnich <rminnich@gmail.com>, Tom Rini <trini@konsulko.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>
Subject: Re: [PATCH v3 1/2] schemas: Add a schema for memory map
Message-ID: <ZOXKTrC_dzN_hUkY@FVFF77S0Q05N>
References: <20230822203446.4111742-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822203446.4111742-1-sjg@chromium.org>
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

On Tue, Aug 22, 2023 at 02:34:42PM -0600, Simon Glass wrote:
> The Devicetree specification skips over handling of a logical view of
> the memory map, pointing users to the UEFI specification.
> 
> It is common to split firmware into 'Platform Init', which does the
> initial hardware setup and a "Payload" which selects the OS to be booted.
> Thus an handover interface is required between these two pieces.
> 
> Where UEFI boot-time services are not available, but UEFI firmware is
> present on either side of this interface, information about memory usage
> and attributes must be presented to the "Payload" in some form.

Today Linux does that by passing:

  /chosen/linux,uefi-mmap-start
  /chosen/linux,uefi-mmap-size
  /chosen/linux,uefi-mmap-desc-size
  /chosen/linux,uefi-mmap-desc-ver

... or /chosen/xen,* variants of those.

Can't we document / genericise that?

Pointing to that rather than re-encoding it in DT means that it stays in-sync
with the EFI spec and we won't back ourselves into a corner where we cannot
encode something due to a structural difference. I don't think it's a good idea
to try to re-encode it, or we're just setting ourselves up for futher pain.

Thanks,
Mark.

> 
> This aims to provide an initial schema for this mapping.
> 
> Note that this is separate from the existing /memory and /reserved-memory
> nodes, since it is mostly concerned with what the memory is used for. It
> may cover only a small fraction of available memory.
> 
> For now, no attempt is made to create an exhaustive binding, so there are
> some example types listed. This can be completed once this has passed
> initial review.
> 
> This binding does not include a binding for the memory 'attribute'
> property, defined by EFI_BOOT_SERVICES.GetMemoryMap(). It may be useful
> to have that as well, but perhaps not as a bit mask.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changes in v3:
> - Reword commit message again
> - cc a lot more people, from the FFI patch
> - Split out the attributes into the /memory nodes
> 
> Changes in v2:
> - Reword commit message
> 
>  dtschema/schemas/memory-map.yaml | 61 ++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 dtschema/schemas/memory-map.yaml
> 
> diff --git a/dtschema/schemas/memory-map.yaml b/dtschema/schemas/memory-map.yaml
> new file mode 100644
> index 0000000..4b06583
> --- /dev/null
> +++ b/dtschema/schemas/memory-map.yaml
> @@ -0,0 +1,61 @@
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
> +    const: 'memory-map'
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
> +      usage:
> +        $ref: /schemas/types.yaml#/definitions/string
> +        description: |
> +          Describes the usage of the memory region, e.g.:
> +
> +            "acpi-reclaim", "acpi-nvs", "bootcode", "bootdata", "bootdata",
> +            "runtime-code", "runtime-data".
> +
> +            See enum EFI_MEMORY_TYPE in "Unified Extensible Firmware Interface
> +            (UEFI) Specification" for all the types. For now there are not
> +            listed here.
> +
> +    required:
> +      - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    memory-map {
> +        acpi@f0000 {
> +            reg = <0xf0000 0x4000>;
> +            usage = "acpi-reclaim";
> +        };
> +
> +        runtime@12300000 {
> +            reg = <0x12300000 0x28000>;
> +            usage = "runtime-code";
> +        };
> +    };
> +...
> -- 
> 2.42.0.rc1.204.g551eb34607-goog
> 
