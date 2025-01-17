Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DB4C02185
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 09:19:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EECA2806FB;
	Fri, 17 Jan 2025 10:19:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rlQntYK/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B15980312; Fri, 17 Jan 2025 10:19:55 +0100 (CET)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1A6180737
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 10:19:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e549dd7201cso3257513276.0
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 01:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737105592; x=1737710392; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zrTQ8fJOAKJn0/TGLbRNMcH9Gf+12aCtQmq6KO21KHk=;
 b=rlQntYK/u1cIofCZrJtJgNeBgG0tiD1+Jidz/eDBsItR/9nbTLV1XcBgv1/XpENl8u
 NDkRIYZZ/Wo5hoVLYocW2EnknUV1pMnM74Fc79YuGAyDj4QSe9JoN79PSD3vwVn77kZu
 ABNokkC5ndjpZbd46kMDW5Wszn2X83PwaatEWfKOuER2adif4S5QGxKormvTnWK+AKRN
 9Gsv6yLmkHFAWLky6PuWIPrr3iZVpi6Im9f5Xy7SHZSnegP9/bTH9VyDfv+LYCtiSo4l
 1sqhMim5fuxNiINVoDS4kvBLA3W3DncKjnE+U6qKPPaKekFqgIxjheLnf9W0dX445F5c
 d+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737105592; x=1737710392;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zrTQ8fJOAKJn0/TGLbRNMcH9Gf+12aCtQmq6KO21KHk=;
 b=Gl0UdpbrraX+31T7mpviDIIYE14oc8aCfdccpFgLDkmkmyIE3HtU0DOW7vyzR7Purg
 XO7YTTeck5d1bfW5cjGljzuwXZzinQRZkK41vHaOdKXTBJ/U2TfXX9PxfTQGuj9dAkT6
 aiiogNcczIT5ODEkWSHwGMjf8A5Ymsd9F1o/pII6nBKgoMDeCrxMawhSL/064Irg7+jm
 JRPtxrHLEHyyT7bo1Y6Fvrlwp1kdNTOSADXf/qznqdbo5SmIcAWe4wrBBrFxHM4+SKnG
 rFFM0mpNYxIp9vwnCW1nryMZygeCQpi1tUBKe17aTbAeioS+s6l/JZH6lJn79aOdGoFN
 BhOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWezwBvay+rXHaZmsc3jDgkC7yvdP10zlGIHtX053W6pmIMHtIwCaKKiKDLw4a9qzWH5J4Zung=@lists.denx.de
X-Gm-Message-State: AOJu0YzZ0k1q9obozIcwMlXumEgd15MBeaulhlEi7Qo3pW415EYV3FUK
 BdXnpObTo3SpgHZpe5HTaX7LbFoXutzLPQhBPRC0cKyoseqh04jIDXFMV4UUasXm5dtyiLFGSdN
 FnVazYFG/eFL9QlJQ2l5+OGx8Z5Iqo1eyM9hN/g==
X-Gm-Gg: ASbGncup+FeSLEvEDp+HxkQ4Z0zQGnHudljd7Izlymjb+kYNibcIX+QKKWP6xwrNfDk
 fldi6jj2NOlfmd4OjlYEpwtFw9/b2n3RsuKs7WA==
X-Google-Smtp-Source: AGHT+IHPBf33AmY/T98wPHl/vzXxbdLcvxdJP/MgJfH6+O+uaA9HgozZgYevoeJk/CG9CtHiS+HF31tZb3j213bpECw=
X-Received: by 2002:a05:690c:9692:b0:6ef:94db:b208 with SMTP id
 00721157ae682-6f6eb919df0mr11781637b3.24.1737105591779; Fri, 17 Jan 2025
 01:19:51 -0800 (PST)
MIME-Version: 1.0
References: <20250116113909.113950-1-heinrich.schuchardt@canonical.com>
 <20250116113909.113950-5-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250116113909.113950-5-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 17 Jan 2025 11:19:14 +0200
X-Gm-Features: AbW1kvYJgAAw9dm3WS6euYU0D_HfKk150Zto3KQjHXmbSK_XKa2YJOpEGURwHOE
Message-ID: <CAC_iWjLEmP-YjiOxhWC6TBx0toEtD5uDiNPOBwjYqunAx02Ctw@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] efi_loader: correct SizeOfCode,
 SizeOfInitializedData
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Michal Simek <michal.simek@amd.com>, Prasad Kummari <prasad.kummari@amd.com>,
 u-boot@lists.denx.de
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

On Thu, 16 Jan 2025 at 13:39, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The fields SizeOfCode, SizeOfInitializedData, and SizeOfUninitializedData
> are define in the PE-COFF specification [1].
>
> * SizeOfCode must match the size of all .text sections.
> * SizeOfInitializedData must match the size of all .data sections.
> * SizeOfUninitializedData must match the size of all .bss sections.
>
> We only have one .text and one .data section. SizeOfCode and
> SizeOfInitializedData have to be calculated as the difference between
> the end and the start of the respective section.
>
> As we don't have any .bss sections in the generated EFI binaries.
> SizeOfUninitializedData must remain 0.
>
> [1] https://learn.microsoft.com/en-us/windows/win32/debug/pe-format
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         new patch
> ---
>  arch/arm/lib/crt0_aarch64_efi.S | 2 +-
>  arch/arm/lib/crt0_arm_efi.S     | 4 ++--
>  arch/riscv/lib/crt0_riscv_efi.S | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/lib/crt0_aarch64_efi.S b/arch/arm/lib/crt0_aarch64_efi.S
> index fe6eca576ec..e21b54fdbcb 100644
> --- a/arch/arm/lib/crt0_aarch64_efi.S
> +++ b/arch/arm/lib/crt0_aarch64_efi.S
> @@ -41,7 +41,7 @@ optional_header:
>         .byte   0x02                            /* MajorLinkerVersion */
>         .byte   0x14                            /* MinorLinkerVersion */
>         .long   _etext - _start                 /* SizeOfCode */
> -       .long   0                               /* SizeOfInitializedData */
> +       .long   _data_size                      /* SizeOfInitializedData */
>         .long   0                               /* SizeOfUninitializedData */
>         .long   _start - ImageBase              /* AddressOfEntryPoint */
>         .long   _start - ImageBase              /* BaseOfCode */
> diff --git a/arch/arm/lib/crt0_arm_efi.S b/arch/arm/lib/crt0_arm_efi.S
> index b5dfd4e3819..3664cce8412 100644
> --- a/arch/arm/lib/crt0_arm_efi.S
> +++ b/arch/arm/lib/crt0_arm_efi.S
> @@ -38,8 +38,8 @@ optional_header:
>         .short  IMAGE_NT_OPTIONAL_HDR32_MAGIC   /* PE32 format */
>         .byte   0x02                            /* MajorLinkerVersion */
>         .byte   0x14                            /* MinorLinkerVersion */
> -       .long   _edata - _start                 /* SizeOfCode */
> -       .long   0                               /* SizeOfInitializedData */
> +       .long   _etext - _start                 /* SizeOfCode */
> +       .long   _data_size                      /* SizeOfInitializedData */
>         .long   0                               /* SizeOfUninitializedData */
>         .long   _start - image_base             /* AddressOfEntryPoint */
>         .long   _start - image_base             /* BaseOfCode */
> diff --git a/arch/riscv/lib/crt0_riscv_efi.S b/arch/riscv/lib/crt0_riscv_efi.S
> index c7a4559eac8..9eacbe4a859 100644
> --- a/arch/riscv/lib/crt0_riscv_efi.S
> +++ b/arch/riscv/lib/crt0_riscv_efi.S
> @@ -63,8 +63,8 @@ optional_header:
>         .short  PE_MAGIC                        /* PE32(+) format */
>         .byte   0x02                            /* MajorLinkerVersion */
>         .byte   0x14                            /* MinorLinkerVersion */
> -       .long   _edata - _start                 /* SizeOfCode */
> -       .long   0                               /* SizeOfInitializedData */
> +       .long   _etext - _start                 /* SizeOfCode */
> +       .long   _data_size                      /* SizeOfInitializedData */
>         .long   0                               /* SizeOfUninitializedData */
>         .long   _start - ImageBase              /* AddressOfEntryPoint */
>         .long   _start - ImageBase              /* BaseOfCode */
> --
> 2.47.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
