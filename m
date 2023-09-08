Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF30EE57FC
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 11:46:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08DA7869F9;
	Fri,  8 Sep 2023 13:46:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BPEtcWZr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F30DF86A04; Fri,  8 Sep 2023 13:46:07 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24E4E86501
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 13:46:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=robh@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 52CAD6149D
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 11:45:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20BFC433C9
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 11:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1694173557;
 bh=aODHL6mbNW0WLyQo2/gZhYlzuWIMAbhDYth1ivLfiJs=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=BPEtcWZrdC/o+gbIBKtuvpPZ1GJmKxqF8z7Tz15gNxu4UNu+zchX6c78qd3GRiBv6
 4admkoRJfGJ1JRASdiZVyzOAzbVD15sV9Au+hZXXr1Ki+RGk0otXyHn9GIHe3tpviv
 xuPclUkDl/eHCxBguoAm9ALCQdoAtY9kgQ3qOjO8bNIkVsaB9sHidwYoSs3pIYqzHs
 hFPvYxIicGPwDlT3cylZmTxfyJ8t+rJsH+XXd6eM9sKjPP7N42uE9LdASVzOz/1lMI
 MWVhybkcBY41VIQkAT5IOwzG0RmDpCZ6nw4VpoSnrr6ETXoZhycu+mxWc/zEOPAXj3
 tH2as6Q8nzqZA==
Received: by mail-lj1-f173.google.com with SMTP id
 38308e7fff4ca-2b974031aeaso34957621fa.0
 for <u-boot@lists.denx.de>; Fri, 08 Sep 2023 04:45:57 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx3pPNU46V9RX35/TJvq9kd4u1Ka6ddnp8SQj4oMBXogf4VZx13
 5XbnmEMtwXlNJk1OmxWEoHwosJql0/rILKfY4g==
X-Google-Smtp-Source: AGHT+IGGKjJmemgNHpyI56G1+q2fUiJV4ppgzoy9LEO/x9T0+wAy75B+QGXgy5XYMiqRpu3pH/RANsVfOlTDWayxIDc=
X-Received: by 2002:a2e:7801:0:b0:2bc:b0c3:9e8d with SMTP id
 t1-20020a2e7801000000b002bcb0c39e8dmr1610795ljc.41.1694173555929; Fri, 08 Sep
 2023 04:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230907214012.74978-1-sjg@chromium.org>
 <20230907214012.74978-2-sjg@chromium.org>
In-Reply-To: <20230907214012.74978-2-sjg@chromium.org>
From: Rob Herring <robh@kernel.org>
Date: Fri, 8 Sep 2023 06:45:43 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+N1=XuZqFsVEgBeVpJzTBJRJ+w76roOUBtbP2Y8f3bEw@mail.gmail.com>
Message-ID: <CAL_Jsq+N1=XuZqFsVEgBeVpJzTBJRJ+w76roOUBtbP2Y8f3bEw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] schemas: memory: Add ECC properties
To: Simon Glass <sjg@chromium.org>
Cc: devicetree@vger.kernel.org, Dhaval Sharma <dhaval@rivosinc.com>, 
 Guo Dong <guo.dong@intel.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Yunhui Cui <cuiyunhui@bytedance.com>, Chiu Chasel <chasel.chiu@intel.com>, 
 Mark Rutland <mark.rutland@arm.com>, linux-acpi@vger.kernel.org, 
 Maximilian Brune <maximilian.brune@9elements.com>,
 Ard Biesheuvel <ardb@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Lean Sheng Tan <sheng.tan@9elements.com>, 
 Gua Guo <gua.guo@intel.com>, ron minnich <rminnich@gmail.com>
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

On Thu, Sep 7, 2023 at 4:40=E2=80=AFPM Simon Glass <sjg@chromium.org> wrote=
:
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

Why? '|' is not needed for any of these.

>            For the purpose of identification, each NUMA node is associate=
d with
>            a unique token known as a node id.
> -

blank line between properties.

I can fix these up when applying.

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
