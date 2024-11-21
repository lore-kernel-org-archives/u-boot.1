Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B0B8D75BCC
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 07:53:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B218889610;
	Thu, 21 Nov 2024 08:53:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TzAhNmnN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30C5C89616; Thu, 21 Nov 2024 08:53:43 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13B4588F55
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 08:53:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5cfaeed515bso729027a12.1
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 23:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732175620; x=1732780420; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0LHOrhVukzhc7uLvu6iXorvP1WcO7lukzczV3UaRqeI=;
 b=TzAhNmnNZxD+sNl0OkqYAr1sblO7nA+rc4yIsZpyhvxlABnbN0HbayITijiw44nx0A
 Xk/IkwPLHEndiHlX2PBD6Hr2APTsG4rQpQHO90PNXTF3ksSsCVUm8/wd2hDBmnMPfAtX
 /8nPOuYhgtL+buAgNW3Xohci+cdN5Xdx2DqGuZB4o10AXGmYiwXdxr9yQWZ/Y+XjYT1x
 j8csTlmS/pWd3qvgzvs+0lcyxODGUg14trSHhDrLQ20ZNs4fv5jRQVrA044KeHCg6fqe
 h6elbxibqJUf19nCvu7ZF5S8ZWKbZwJyQCtzoZBVt8IiTVSF3gNoYB4NfUalltIW1JFi
 wjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732175620; x=1732780420;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0LHOrhVukzhc7uLvu6iXorvP1WcO7lukzczV3UaRqeI=;
 b=IbUVcbOXywVxvXgObIxkD1turENodwDVZSFYMUvHndJRV+RWtfYMOte4oYVKrRotJ5
 sMX0WBSP7Jo0/7GesYjhdJpZM/Cf3lGVP8JvBOh91vCg1QHKDaFg2I7uqY8aspaVcBUC
 H/NbLVHLN0KLMHIRK7pbNQCZPtCvI0Hy/Xg3tKDNAu7R3tkSMXhJlwnST8O59KsAOPlZ
 Cr4gnbpgr7tMTA/5MSU8bbM35yBr+ybZSCwP1HH/97dORNuWziiAMCJq5khv0ws7CLLp
 mwKttvC00lVwMjqcvjqe3/gLcZuPYqvU1kKZU8F0hv4ue5BL9WGAcB7/q9wC2uU7wFAx
 iOYQ==
X-Gm-Message-State: AOJu0YwbYL0fJ5FrOJtfDkJtG85KTeDFh11tUtxRhxoYTRuSIRa6LraH
 4hj3LcrH18q88jHBT7J4AWhkBtq4TyD1mm3RFYfURq78SFWnHHc9BCV3kfU+D9A6pkE48F3C6Ac
 G5M+Ib9p2TmGCm8mQcHObpujYnY78Y5Tycfi0AoY7M+VInxF0
X-Gm-Gg: ASbGncvwj7yHmG98hQ8JcNvTPn3pgcxSN/vhvjHZS9BTQozgUYv1lkJ880c79gC1ojy
 jiOtth8hT87POwhkkqkLSFOSiUZ4sLFwD
X-Google-Smtp-Source: AGHT+IHu1nFofeXJNtZ2PXDrL9Dq/2dwZjEYaggW+2n2dedO4IjnB8CkWUc+H1/ZIH+WO6JATsmEH79n3+Rco5zwhOs=
X-Received: by 2002:a05:6402:34cc:b0:5cf:c18b:59dc with SMTP id
 4fb4d7f45d1cf-5cff4b17ff6mr4149176a12.6.1732175620467; Wed, 20 Nov 2024
 23:53:40 -0800 (PST)
MIME-Version: 1.0
References: <20241112131830.576864-1-sjg@chromium.org>
In-Reply-To: <20241112131830.576864-1-sjg@chromium.org>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Thu, 21 Nov 2024 13:23:29 +0530
Message-ID: <CADg8p96cKqSEmZWLaOV1-onUwT4uwBp11=t4K7tmmPwZ-6UvXw@mail.gmail.com>
Subject: Re: [PATCH] Revert "efi_memory: do not add U-Boot memory to the
 memory map"
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Tue, 12 Nov 2024 at 18:48, Simon Glass <sjg@chromium.org> wrote:
>
> A bisect of Ubuntu 2022.04 boot-failure on qemu-x86_64 resulted in this
> patch. I am not sure how to investigate it.
>
> The boot hangs at some point during booting of the install image, before
> the Ubuntu logo appears.
>
> I will sent a series with a script showing how it is run.
>
> This reverts commit a68c9ac5d8afc51c619c5d3e865fcf147bea90cb.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---

I did some digging into this issue, and it turns out that the revert
is only masking the real issue. What this revert does is mark the
memory region occupied by U-Boot as EFI_BOOT_SERVICES_CODE. The x86
kernel seems to mark memory regions other than
EFI_{BOOT,RUNTIME}_SERVICES_CODE as not executable -- and this is
precisely why this crash shows up only on x86. The actual cause of
this issue is in the efi runtime functionality of U-Boot. The kernel
is calling the SetVirtualAddressMap() runtime service function, and
that seems to be calling some of the boot service code of U-Boot,
which it shouldn't. We do not get the crash after disabling the
ConvertPointer() and SetVirtualAddressMap() runtime functions.

-sughosh

>
>  lib/efi_loader/efi_memory.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index d2f5d563f2a..c7400ec9854 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -809,6 +809,16 @@ static void add_u_boot_and_runtime(void)
>  {
>         unsigned long runtime_start, runtime_end, runtime_pages;
>         unsigned long runtime_mask = EFI_PAGE_MASK;
> +       unsigned long uboot_start, uboot_pages;
> +       unsigned long uboot_stack_size = CONFIG_STACK_SIZE;
> +
> +       /* Add U-Boot */
> +       uboot_start = ((uintptr_t)map_sysmem(gd->start_addr_sp, 0) -
> +                      uboot_stack_size) & ~EFI_PAGE_MASK;
> +       uboot_pages = ((uintptr_t)map_sysmem(gd->ram_top - 1, 0) -
> +                      uboot_start + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT;
> +       efi_add_memory_map_pg(uboot_start, uboot_pages, EFI_BOOT_SERVICES_CODE,
> +                             false);
>
>  #if defined(__aarch64__)
>         /*
> --
> 2.34.1
>
