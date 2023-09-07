Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6116EEC8743
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 16:58:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AC8986410;
	Thu,  7 Sep 2023 18:58:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HZSOww+G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE0D3869E1; Thu,  7 Sep 2023 18:58:26 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BA3385DD2
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 18:58:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=robh@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id C8AFEB81E82
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 16:58:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65084C433B7
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 16:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1694105901;
 bh=9H8krLtYfLzgGeA5i0zuj9qgIuh5eWibHtX4rliuuxQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=HZSOww+G/B17lm44Q4pK901JIvTJ+z2HSd8QVDZnTmfMHtw4A/FdMMdg0G9fWUG8n
 VgwoarbRzt5ypjQeRKWF1UtKEO/iIScBixMwuctbelX+fXPN7iNwDDQkBf/gnAUYkx
 mf6r1j0bJ0GDOXTs7goJT5QasJ1jlDe/wPpJKZAcuzxHRagM7PMKEn32dCanO0a57H
 BtndR0lM1QbhEN3hLC1d6wDNm0i/GQHtxpbo5HFx1mhzL5rO/aiEqNINT5VrCu3Wi8
 xES8vBcm83QU9L+UKQa6B4ed3Ba6vkmpyDuJT0GGJXIAZvb3mgxws/PkYis79hfx4E
 V0qByRzTyJTSg==
Received: by mail-lj1-f180.google.com with SMTP id
 38308e7fff4ca-2b9c907bc68so20219461fa.2
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 09:58:21 -0700 (PDT)
X-Gm-Message-State: AOJu0YxadTHvqF13EcS0l1NYFWPDo7WdObpGnhUae5MfCZ91bP3kr+DO
 RUWk8T1D1HGXiteKmyB9ilzaskuTSE7JDBulqw==
X-Google-Smtp-Source: AGHT+IHLKsGi67L1BWMr0evQdFmmKrCxPICw4WCCL86IJN0XnEYKyZyPOVddUmJXTpGASiUH1k4Vzk7Q+KRVgc7tkH4=
X-Received: by 2002:a2e:965a:0:b0:2bc:b815:d64d with SMTP id
 z26-20020a2e965a000000b002bcb815d64dmr5383234ljh.30.1694105899386; Thu, 07
 Sep 2023 09:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230830231758.2561402-1-sjg@chromium.org>
 <20230830231758.2561402-4-sjg@chromium.org>
In-Reply-To: <20230830231758.2561402-4-sjg@chromium.org>
From: Rob Herring <robh@kernel.org>
Date: Thu, 7 Sep 2023 11:58:07 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKEbqUtWHpHXmiDSZBY7-Nw4-fLs23BEqomBevSDNBprQ@mail.gmail.com>
Message-ID: <CAL_JsqKEbqUtWHpHXmiDSZBY7-Nw4-fLs23BEqomBevSDNBprQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] memory: Add ECC properties
To: Simon Glass <sjg@chromium.org>
Cc: devicetree@vger.kernel.org, 
 Maximilian Brune <maximilian.brune@9elements.com>,
 ron minnich <rminnich@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Dhaval Sharma <dhaval@rivosinc.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>, Mark Rutland <mark.rutland@arm.com>,
 Yunhui Cui <cuiyunhui@bytedance.com>, linux-acpi@vger.kernel.org, 
 Ard Biesheuvel <ardb@kernel.org>, Gua Guo <gua.guo@intel.com>, 
 Lean Sheng Tan <sheng.tan@9elements.com>, Guo Dong <guo.dong@intel.com>, 
 lkml <linux-kernel@vger.kernel.org>, Chiu Chasel <chasel.chiu@intel.com>
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

On Wed, Aug 30, 2023 at 6:18=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Some memories provide ECC detection and/or correction. For software which
> wants to check memory, it is helpful to see which regions provide this
> feature.
>
> Add this as a property of the /memory nodes, since it presumably follows
> the hardware-level memory system.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v5:
> - Redo to make this property specific to ECC
> - Provide properties both for detection and correction
>
> Changes in v3:
> - Add new patch to update the /memory nodes
>
>  dtschema/schemas/memory.yaml | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/dtschema/schemas/memory.yaml b/dtschema/schemas/memory.yaml
> index 1d74410..944aa9f 100644
> --- a/dtschema/schemas/memory.yaml
> +++ b/dtschema/schemas/memory.yaml
> @@ -34,7 +34,37 @@ patternProperties:
>          description:
>            For the purpose of identification, each NUMA node is associate=
d with
>            a unique token known as a node id.
> +      ecc-detection:
> +        $ref: /schemas/types.yaml#/definitions/string
> +        enum:
> +          - none
> +          - single-bit
> +          - multi-bit
> +        description: |
> +          If present, this inidcates the type of memory errors which can=
 be

typo

> +          detected and reported by the Error-Correction Code (ECC) memor=
y
> +          subsystem:
>
> +            none       - No error detection is possible
> +            single-bit - Detects and reports single-bit ECC errors
> +            multi-bit  - Detects and reports multiple-bit ECC errors

I don't think 'multi' is specific enough. Perhaps this should be an
int instead with how many bits. (And '-bits' is a standard unit suffix
so a type isn't needed)

> +
> +          If not present, this is equivalent to 'none'.

Can be expressed as schema:

default: none

Though if that's the default why have it as a value? (It's fine though)

> +      ecc-correction:
> +        $ref: /schemas/types.yaml#/definitions/string
> +        enum:
> +          - none
> +          - single-bit
> +          - multi-bit
> +        description: |
> +          If present, this inidcates the type of memory errors which can=
 be

typo

> +          corrected by the Error-Correction Code (ECC) memory subsystem:
> +
> +            none       - No error correction is possible
> +            single-bit - Corrects single-bit ECC errors
> +            multi-bit  - Corrects multiple-bit ECC errors
> +
> +          If not present, this is equivalent to 'none'.

One issue is with 2 properties nonsensical combinations are allowed.
Not really any way to handle that in the schema though.

Rob
