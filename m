Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6C4EE57EC
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 09:39:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05F7B8620C;
	Fri,  8 Sep 2023 11:39:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KxPhPZ37";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24AAD85E44; Fri,  8 Sep 2023 11:39:22 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7212086410
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 11:39:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2bd0d19a304so32810761fa.1
 for <u-boot@lists.denx.de>; Fri, 08 Sep 2023 02:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694165959; x=1694770759; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gmNsFLpdzT7HD0s5ZXq/w5dV3nJ64Nz1IklRYrFXDFk=;
 b=KxPhPZ37SwCAaRQ0gNsRTV/REhuofVd4BRmMKUjnqL0gMwOUYpen5l+jeUvq1nCACV
 TpxWNnvE5IHK+AkOJxmX974ItMmikz16Ph0+ZJExyzMCI+WOMp00wbmbaRcdPrqR2XZn
 VLn4n+lVr4CHITIjY2+K1KIlT6+lG+4scRopcYnpEeysgQX0/mYsxrn/FSVXzin5LFxG
 goPJ9nStqUBi+pLdf/zdgXElbg9JF7O3idqQibPM7eLYsHCp8UshfU5tQqSIqMzr4TuQ
 nfP2cwiFwChDXXIFKNveWp3XmwduL+bgzNaYfXmdxnUPDuQljuTHn9Cb/hn2Ly5eO7Ui
 nrtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694165959; x=1694770759;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gmNsFLpdzT7HD0s5ZXq/w5dV3nJ64Nz1IklRYrFXDFk=;
 b=tqeYjcVN5viCJeVuD9fYHXt2y1k8lSXLYVo9nR58EMUW4si0xUKxAtXz+DH0xkPxX6
 z1idh7p1CkFSqb193pvRo5BzjxCeGogb5sisVWLlXAGmiJQmeF21bCsYU5rFTSZ/MzER
 KES8uHX3pNNfyJGO7H5WkioIn6rvPAuBefMmDyAqxXI2N1px0PmuOR4iVkma7BSwgzwc
 cnKR/VygH0UVHvF9o5AxdrH5laCKrkH3jh4Wo8knT4mcOnDrw+qymPmazvDyts11LH5Z
 /kOO79TKN5Z3QTvPJ0oz82gAyIWiGaRAAlsBLrFiaUSzglhKkwKe5IhWYLUWbR7DYY+j
 HujQ==
X-Gm-Message-State: AOJu0Yzw1t506zNg72GwLPXITNjbCXwi/B8g1rISh7GSqB+JuIftdXDS
 fNTu2YEgBACUuhZ+0zcOa/a3mx6O0xLQlJI7e1w=
X-Google-Smtp-Source: AGHT+IFjfGA9NdJS6OhiKH64cF2dg48YPknpqmQwImslm67FtorC5iz65zDqt4aJedeew0m5WTNkHCX1TLGmUzaOvdw=
X-Received: by 2002:a2e:9b4b:0:b0:2bd:d34:f892 with SMTP id
 o11-20020a2e9b4b000000b002bd0d34f892mr1397188ljj.3.1694165958609; Fri, 08 Sep
 2023 02:39:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230907214012.74978-1-sjg@chromium.org>
 <20230907214012.74978-2-sjg@chromium.org>
In-Reply-To: <20230907214012.74978-2-sjg@chromium.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 8 Sep 2023 10:39:07 +0100
Message-ID: <CALeDE9NwvFRoq7_WQdYAPcurRwOpenEsYt+PKrckaR6asB2TdQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] schemas: memory: Add ECC properties
To: Simon Glass <sjg@chromium.org>
Cc: devicetree@vger.kernel.org, Dhaval Sharma <dhaval@rivosinc.com>, 
 Guo Dong <guo.dong@intel.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Yunhui Cui <cuiyunhui@bytedance.com>, Chiu Chasel <chasel.chiu@intel.com>, 
 Mark Rutland <mark.rutland@arm.com>, linux-acpi@vger.kernel.org, 
 Rob Herring <robh@kernel.org>,
 Maximilian Brune <maximilian.brune@9elements.com>, 
 Ard Biesheuvel <ardb@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Lean Sheng Tan <sheng.tan@9elements.com>, Gua Guo <gua.guo@intel.com>, 
 ron minnich <rminnich@gmail.com>
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

On Thu, Sep 7, 2023 at 11:57=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Some memories provide ECC detection and/or correction. For software which
> wants to check memory, it is helpful to see which regions provide this
> feature.
>
> Add this as a property of the /memory nodes, since it presumably follows
> the hardware-level memory system.

Have these been accepted upstream? A grep of bindings in the upstream
kernel I don't see them.

> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v6:
> - Use a number of bits instead of a string property
> - Fix inidcates typo
>
> Changes in v5:
> - Redo to make this property specific to ECC
> - Provide properties both for detection and correction
>
> Changes in v3:
> - Add new patch to update the /memory nodes
>
>  dtschema/schemas/memory.yaml | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/dtschema/schemas/memory.yaml b/dtschema/schemas/memory.yaml
> index 1d74410..1a48b1c 100644
> --- a/dtschema/schemas/memory.yaml
> +++ b/dtschema/schemas/memory.yaml
> @@ -31,10 +31,21 @@ patternProperties:
>
>        numa-node-id:
>          $ref: types.yaml#/definitions/uint32
> -        description:
> +        description: |
>            For the purpose of identification, each NUMA node is associate=
d with
>            a unique token known as a node id.
> -
> +      ecc-detection-bits:
> +        default: 0
> +        description: |
> +          If present, this indicates the number of bits of memory error =
which
> +          can be detected and reported by the Error-Correction Code (ECC=
) memory
> +          subsystem (typically 0, 1 or 2).
> +      ecc-correction-bits:
> +        default: 0
> +        description: |
> +          If present, this indicates the number of bits of memory error =
which
> +          can be corrected by the Error-Correction Code (ECC) memory sub=
system
> +          (typically 0, 1 or 2).
>
>      required:
>        - device_type
> --
> 2.42.0.283.g2d96d420d3-goog
>
