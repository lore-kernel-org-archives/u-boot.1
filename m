Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133EAC02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 08:06:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C3E680040;
	Wed, 15 Jan 2025 09:06:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="InRVXLpx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5386880214; Wed, 15 Jan 2025 09:06:42 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1038680027
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 09:06:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e545c1e8a15so10052205276.1
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 00:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736928399; x=1737533199; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mO7C5Mscm5aGsVyTjZKnT2OZO9FdwHOS2Twk/ViOfLw=;
 b=InRVXLpxPcl8kETkMSV7IsUiiMkzuNEhN4I5sdEB0gPZAwTraS1Jv/5/hSlz6BSRhW
 KcI8noFmyCyshRgdVbzsxoweotOiM+e9rcykx4/mPFZxzrkeDD9p+jB0J8IroDV8JcIi
 NPi5zt2fl44PkGaArKpr8XU+y/hGkizUYY2R9I0szr46l3lLaDn4VG9iVC6EXI5pNxKW
 V0wsDHwl9KI8xGhwaCkOptu+q2tcbOTap6mi0KoZVUytF3/k2ZYoOTPZklnOqbN35l72
 UP5HuhjLLOfywtRhjhHz7kXYJaxcFRJTuMspHbjK7LHv+sQn3O4lkPSOWAf6l8HaXhbH
 ROjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736928399; x=1737533199;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mO7C5Mscm5aGsVyTjZKnT2OZO9FdwHOS2Twk/ViOfLw=;
 b=KRolZKA7eWkngGGbG/gAbD17BhOLa5cRGcANaSKRXQhg09SzmkON5Ix4wiNADWITfS
 54DBoNW2H+K9hWsrBfeuitz97tt7CsgkFppBTpXsr0IWfYzM+6xHnWal9OrthuBMyqn0
 c1cJnMZp5h77nZhAzXK282XbVMv4ss1yNuXr5+bskoWs566RsHDNduFywnMCn6qxzQ1k
 UHAn8kYWPyyPannVuqkc51TVunG50LN03oBJVNq5IBPywxCn+tRzE6/4S7pBd0F4KFeT
 s4Kcr6NZchNJei1iiD9hbAK05P1fU2KjgaTQg8cZFmi+yX3HVh9pyAypLAn2O24XZQk/
 /uRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWIvkXiPUsx9Uc2LgqoMqETZRwyW/ksTUMBro4bZy0zzDSihRoaPfCgBjXKFbHyT5Sis0Th5A=@lists.denx.de
X-Gm-Message-State: AOJu0YycEJHVF/7Bys03Y/sH7Eo5RGBaZ17WwxC0PIBWKg+bQ63orxbD
 NZTsj0LFTVsvr9qKya9xbyn5bOOKhhvr7LbsGr3J7KiHhe26cxhOK10y48qXVkkWEyE2qzgt7Jf
 qNrXoydHd4YZEi7V9nh1qi5QuzbqnHAVq9uOhJg==
X-Gm-Gg: ASbGncsv4z1o1CdECkDXnEoRrmJ/CRI8wmyyRgWRTdYwA2o1h4pvL77G5z7f51Dik32
 uNIElbZonZi368VTPZoZXkD7Xu3HbG4qpes75Rg==
X-Google-Smtp-Source: AGHT+IH20z0F6lom3kDMVfqszCj58bzFLAXjVbkXoSDVyjKfVlrrak0/k3kqPAW8TnqarZPGRfc9wdnhCn1+URlyv7g=
X-Received: by 2002:a05:690c:12:b0:6ef:96f8:b609 with SMTP id
 00721157ae682-6f5312a5a55mr230409697b3.31.1736928398871; Wed, 15 Jan 2025
 00:06:38 -0800 (PST)
MIME-Version: 1.0
References: <20250114102953.64381-1-heinrich.schuchardt@canonical.com>
 <20250114102953.64381-5-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250114102953.64381-5-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 15 Jan 2025 10:06:03 +0200
X-Gm-Features: AbW1kvZpU3PNBL19a3ElKYJPSMAlyvex8PXwiJKsaGozlc4gB1NDqU-ftj4LpBg
Message-ID: <CAC_iWjJdT_pn89aq3m1RaZesQSiKRGEqz4dVhoN6ntz4=2xqPg@mail.gmail.com>
Subject: Re: [PATCH 4/4] efi_loader: use include in ARM EFI linker script
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Simon Glass <sjg@chromium.org>, Jonathan Humphreys <j-humphreys@ti.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Prasad Kummari <prasad.kummari@amd.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi Heinrich


On Tue, 14 Jan 2025 at 12:30, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Use the same include as arm64 for the linker script.
>
> Adjust the 32-bit ARM PE-COFF header accordingly and harmonize it with the
> 64-bit ARM header.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  arch/arm/lib/crt0_arm_efi.S  | 37 ++++++++++---------
>  arch/arm/lib/elf_arm_efi.lds | 71 +-----------------------------------
>  2 files changed, 20 insertions(+), 88 deletions(-)
>
> diff --git a/arch/arm/lib/crt0_arm_efi.S b/arch/arm/lib/crt0_arm_efi.S
> index b5dfd4e3819..590fcf515da 100644
> --- a/arch/arm/lib/crt0_arm_efi.S
> +++ b/arch/arm/lib/crt0_arm_efi.S
> @@ -14,11 +14,11 @@
>         /*
>          * Magic "MZ" signature for PE/COFF
>          */
> -       .globl  image_base
> -image_base:
> +       .globl  ImageBase
> +ImageBase:
>         .short  IMAGE_DOS_SIGNATURE             /* 'MZ' */
>         .skip   58                              /* 'MZ' + pad + offset == 64 */
> -       .long   pe_header - image_base          /* Offset to the PE header */
> +       .long   pe_header - ImageBase           /* Offset to the PE header */
>  pe_header:
>         .long   IMAGE_NT_SIGNATURE              /* 'PE' */
>  coff_header:
> @@ -38,16 +38,16 @@ optional_header:
>         .short  IMAGE_NT_OPTIONAL_HDR32_MAGIC   /* PE32 format */
>         .byte   0x02                            /* MajorLinkerVersion */
>         .byte   0x14                            /* MinorLinkerVersion */
> -       .long   _edata - _start                 /* SizeOfCode */
> +       .long   _etext - _start                 /* SizeOfCode */

Was that an error all along? Or the boundaries changed by using the
include file?

>         .long   0                               /* SizeOfInitializedData */
>         .long   0                               /* SizeOfUninitializedData */
> -       .long   _start - image_base             /* AddressOfEntryPoint */
> -       .long   _start - image_base             /* BaseOfCode */
> +       .long   _start - ImageBase              /* AddressOfEntryPoint */
> +       .long   _start - ImageBase              /* BaseOfCode */
>         .long   0                               /* BaseOfData */
[...]

Other than that it looks ok

Thanks for cleaning this up!
/Ilias
