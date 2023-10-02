Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 860FFE74902
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 17:54:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF41886DBC;
	Mon,  2 Oct 2023 19:54:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mqhqjOxX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 762CB86DF1; Mon,  2 Oct 2023 19:54:10 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44BFC86DAD
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 19:54:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-53406799540so17249425a12.1
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 10:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696269248; x=1696874048; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TsD3ZHZijN9S1sfcV2n15VGsYEU63cv+c2MU+o+0ccc=;
 b=mqhqjOxX5QzZ6H65ebs10S0L1bfftcR2jKBGy1QQpmigbOxd7y+Xx0v0V+FiuuBO8V
 zcOxLnIjdVJAoajLcWRu6+tJzqDRZQAvJQwNDTgXl4/lUNzwOwnwsdWUOIvFBrJwLKL5
 bb4hZMq7rYYQfuGMjPpaPQ8Qc5Mb6BZUeR/Do=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696269248; x=1696874048;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TsD3ZHZijN9S1sfcV2n15VGsYEU63cv+c2MU+o+0ccc=;
 b=TcKE61zcM2DoORpkzce6EiH4ONpNjzHST6/SqK6BmdPanElhdvyx14BhsFNPHd8FU8
 hL5BnTxX/L/fqZ0LBN4wsJIqu0slIM2CQcOqtKv/9bEYxkd7HyVINAKxeo6qAejUZhet
 vmO3RsCd6SwrjmPSyWyqMxke56nqyqtqsrHEDyWofirRavHSUBHkJRiNav5ktgQT3oBI
 SGSq9SHDGZa4HcrW4pn/vvwtRzGpKyYmnmDTQOZZuljIV95FpVggYr8L98gXVAt7k87P
 P3kyMobUrmti9YlrHOhIRXlCcJGEjJ8ZsodhyUBL8eezOPRx5y6Jlrn6mShD2E0yeD7u
 iXxw==
X-Gm-Message-State: AOJu0YzKm3iMptTlFRvvNqj1hrvBtdRDg3ailtpnsOugHPg88qQUzQTc
 Z2c3sRd7MbDf7qx4HU/2O0IRYkoCO2Phw+0C44f3kQ==
X-Google-Smtp-Source: AGHT+IEtCxySMkh42I2CvgUj5aqq7h5MglNyXJ6gmXIzyE5bAMfwobhiZlavHruHjwW8M3Pas9ZdXj3GPE0ymKFjY74=
X-Received: by 2002:a17:906:19:b0:9a3:c4f4:12de with SMTP id
 25-20020a170906001900b009a3c4f412demr11349374eja.37.1696269247617; Mon, 02
 Oct 2023 10:54:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230926194242.2732127-1-sjg@chromium.org>
 <20230926194242.2732127-2-sjg@chromium.org>
In-Reply-To: <20230926194242.2732127-2-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 2 Oct 2023 11:53:56 -0600
Message-ID: <CAPnjgZ0Xf3U1aj32LbU-xiU1AqwnM3JL1F8xX-wZ18oEmg+irw@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] schemas: Add some common reserved-memory usages
To: devicetree@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, 
 Lean Sheng Tan <sheng.tan@9elements.com>, lkml <linux-kernel@vger.kernel.org>, 
 Dhaval Sharma <dhaval@rivosinc.com>,
 Maximilian Brune <maximilian.brune@9elements.com>, 
 Yunhui Cui <cuiyunhui@bytedance.com>, Guo Dong <guo.dong@intel.com>, 
 Tom Rini <trini@konsulko.com>, ron minnich <rminnich@gmail.com>,
 Gua Guo <gua.guo@intel.com>, 
 Chiu Chasel <chasel.chiu@intel.com>, linux-acpi@vger.kernel.org, 
 U-Boot Mailing List <u-boot@lists.denx.de>, Ard Biesheuvel <ardb@kernel.org>
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

On Tue, 26 Sept 2023 at 13:42, Simon Glass <sjg@chromium.org> wrote:
>
> It is common to split firmware into 'Platform Init', which does the
> initial hardware setup and a "Payload" which selects the OS to be booted.
> Thus an handover interface is required between these two pieces.
>
> Where UEFI boot-time services are not available, but UEFI firmware is
> present on either side of this interface, information about memory usage
> and attributes must be presented to the "Payload" in some form.
>
> This aims to provide an small schema addition for the memory mapping
> needed to keep these two pieces working together well.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v7:
> - Rename acpi-reclaim to acpi
> - Drop individual mention of when memory can be reclaimed
> - Rewrite the item descriptions
> - Add back the UEFI text (with trepidation)

I am again checking on this series. Can it be applied, please?


>
> Changes in v6:
> - Drop mention of UEFI
> - Use compatible strings instead of node names
>
> Changes in v5:
> - Drop the memory-map node (should have done that in v4)
> - Tidy up schema a bit
>
> Changes in v4:
> - Make use of the reserved-memory node instead of creating a new one
>
> Changes in v3:
> - Reword commit message again
> - cc a lot more people, from the FFI patch
> - Split out the attributes into the /memory nodes
>
> Changes in v2:
> - Reword commit message
>
>  .../reserved-memory/common-reserved.yaml      | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 dtschema/schemas/reserved-memory/common-reserved.yaml
>
> diff --git a/dtschema/schemas/reserved-memory/common-reserved.yaml b/dtschema/schemas/reserved-memory/common-reserved.yaml
> new file mode 100644
> index 0000000..f7fbdfd
> --- /dev/null
> +++ b/dtschema/schemas/reserved-memory/common-reserved.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reserved-memory/common-reserved.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Common memory reservations
> +
> +description: |
> +  Specifies that the reserved memory region can be used for the purpose
> +  indicated by its compatible string.
> +
> +  Clients may reuse this reserved memory if they understand what it is for,
> +  subject to the notes below.
> +
> +maintainers:
> +  - Simon Glass <sjg@chromium.org>
> +
> +allOf:
> +  - $ref: reserved-memory.yaml
> +
> +properties:
> +  compatible:
> +    description: |
> +      This describes some common memory reservations, with the compatible
> +      string indicating what it is used for:
> +
> +         acpi: Advanced Configuration and Power Interface (ACPI) tables
> +         acpi-nvs: ACPI Non-Volatile-Sleeping Memory (NVS). This is reserved by
> +           the firmware for its use and is required to be saved and restored
> +           across an NVS sleep
> +         boot-code: Contains code used for booting which is not needed by the OS
> +         boot-code: Contains data used for booting which is not needed by the OS
> +         runtime-code: Contains code used for interacting with the system when
> +           running the OS
> +         runtime-data: Contains data used for interacting with the system when
> +           running the OS
> +
> +    enum:
> +      - acpi
> +      - acpi-nvs
> +      - boot-code
> +      - boot-data
> +      - runtime-code
> +      - runtime-data
> +
> +  reg:
> +    description: region of memory that is reserved for the purpose indicated
> +      by the compatible string.
> +
> +required:
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    reserved-memory {
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        reserved@12340000 {
> +            compatible = "boot-code";
> +            reg = <0x12340000 0x00800000>;
> +        };
> +
> +        reserved@43210000 {
> +            compatible = "boot-data";
> +            reg = <0x43210000 0x00800000>;
> +        };
> +    };
> --
> 2.42.0.515.g380fc7ccd1-goog
>

Regards,
Simon
