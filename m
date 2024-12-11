Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72CD1E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 15:27:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0894F80314;
	Wed, 11 Dec 2024 16:27:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yARE1sV/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2614E80314; Wed, 11 Dec 2024 16:27:53 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D609C802EF
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 16:27:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-6ef81222aaaso55553597b3.3
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 07:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733930870; x=1734535670; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0cOScFA8tcWG24HoyvX7cujsyWjOGl3UJxYF3leZKcY=;
 b=yARE1sV/x1RwAZxiQCEUMu/+ZllwGkGhvoCbmAEv7b5btvIjpSjktroC0DYYBNWFnm
 rL2nqUqGFeube39JErbXs+wYnyLEU3u+/qy2KN182yfLw5aVmIBOIGUf7KJ0IZjZOdEt
 zQXwbmhnkPGikcCrgB6Jdfudx6L4/xskfoF0/XxoNPlFy/NGloK2y8nm5EDCyvQCiY56
 FBgJtKUF+LAcS5U7B1CQ1zMTgOKmF5AoXqAaR1Caq4ECLnEMMtTlnuHEh1iTk6QH7SH4
 ncKRp7Dx9JwGDfl4kYFGG8N6ZcZ3hQ6tgGZ8CZZhp5sAjuUKIoav30iFsszVLuE6DrWo
 mDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733930870; x=1734535670;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0cOScFA8tcWG24HoyvX7cujsyWjOGl3UJxYF3leZKcY=;
 b=LrUEgdrM1Am9y2D0INFp9HvwlnHZEAEd0f8b0QJiNaHmq2w0UEB1gzY7reZNg7JVUF
 0eeJiPEXS4cgsErJQvVweZcxaUHtKxxhbgKKk0uM/cmJ0fbXV3NJ6pPs1KjhRwIPxzwL
 GDdI8ezwjhSUErt4xU5uUwD07cEYSb+rkBlAuG2HvIsjg6Gtp8oEE43NfpLDlC3GWQHy
 2jZjD2WO/0NOo/DOvC5OqwQeEtNoQy/s9uT/liZdCTmYkIErX1XWTcR98juMP3mBuGw+
 J+g5cDWiuM6ZYdvZtCj30wAgK1zrhOu4qGYM4ySHiN6KO9ipc8nBk2p9x9gQwBBDBh0b
 iN+A==
X-Gm-Message-State: AOJu0Yw7sr4YmDIYz0wISbkGCs5jK90jPRreOfOzssb5h8OofRZOpwmV
 CJDzm2kJrAB9o2WxUmr+zSbW2znuhnOqkwCmVpHLiH44GMNtMpFax0N/sgArHJIqc11J4IuDmW4
 qdCFqa0CZwBEh46grwSUQLFuisM6an2DcgziNqA==
X-Gm-Gg: ASbGncusoT2wj6cPMbpcaUwzT1lre2r5WVL6k0pia7J4XDYglt5Sw13jRI8/KaDYW2Y
 SzNrpLJnPpoipWl/uLMbuLctEofD5EVVle/g=
X-Google-Smtp-Source: AGHT+IFCI2lISHAfd4TF6Xq9CGTFLtC8eOZXqbwbw+h8j8d7mDwF7vBH6nESHQcA2Mt5u0w13ht65cfqHM/ksXMN6lY=
X-Received: by 2002:a05:690c:4c09:b0:6ee:65ae:2184 with SMTP id
 00721157ae682-6f148044943mr33855517b3.37.1733930869782; Wed, 11 Dec 2024
 07:27:49 -0800 (PST)
MIME-Version: 1.0
References: <20241211135418.563803-1-sjg@chromium.org>
 <20241211135418.563803-22-sjg@chromium.org>
In-Reply-To: <20241211135418.563803-22-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 11 Dec 2024 17:27:13 +0200
Message-ID: <CAC_iWjJokyp4Rd_hMAY1+VY823zuAZRWUAVJVVJndbwWfLGYgQ@mail.gmail.com>
Subject: Re: [PATCH v5 21/23] efi_loader: Drop comments about incorrect
 addresses
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Tom Rini <trini@konsulko.com>
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

Hi Simon,

On Wed, 11 Dec 2024 at 15:55, Simon Glass <sjg@chromium.org> wrote:
>
> Now that these problems have been resolved, drop the comments.

Please drop this along with the patch that added it

Thanks
/Ilias
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  lib/efi_loader/efi_acpi.c    | 2 --
>  lib/efi_loader/efi_bootmgr.c | 3 ---
>  lib/efi_loader/efi_smbios.c  | 6 +-----
>  3 files changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
> index ffb360d461b..67bd7f8ca24 100644
> --- a/lib/efi_loader/efi_acpi.c
> +++ b/lib/efi_loader/efi_acpi.c
> @@ -28,14 +28,12 @@ efi_status_t efi_acpi_register(void)
>         /* Mark space used for tables */
>         start = ALIGN_DOWN(gd->arch.table_start, EFI_PAGE_MASK);
>         end = ALIGN(gd->arch.table_end, EFI_PAGE_MASK);
> -       /* TODO(sjg): This should use (ulong)map_sysmem(start, ...) */
>         ret = efi_add_memory_map(start, end - start, EFI_ACPI_RECLAIM_MEMORY);
>         if (ret != EFI_SUCCESS)
>                 return ret;
>         if (gd->arch.table_start_high) {
>                 start = ALIGN_DOWN(gd->arch.table_start_high, EFI_PAGE_MASK);
>                 end = ALIGN(gd->arch.table_end_high, EFI_PAGE_MASK);
> -               /* TODO(sjg): This should use (ulong)map_sysmem(start, ...) */
>                 ret = efi_add_memory_map(start, end - start,
>                                          EFI_ACPI_RECLAIM_MEMORY);
>                 if (ret != EFI_SUCCESS)
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index 30d4ce09e7e..9383adbd958 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -366,8 +366,6 @@ static efi_status_t prepare_loaded_image(u16 *label, ulong addr, ulong size,
>          * TODO: expose the ramdisk to OS.
>          * Need to pass the ramdisk information by the architecture-specific
>          * methods such as 'pmem' device-tree node.
> -        *
> -        * TODO(sjg): This should use (ulong)map_sysmem(addr)
>          */
>         ret = efi_add_memory_map(addr, size, EFI_RESERVED_MEMORY_TYPE);
>         if (ret != EFI_SUCCESS) {
> @@ -402,7 +400,6 @@ static efi_status_t efi_bootmgr_release_uridp(struct uridp_context *ctx)
>
>         /* cleanup for iso or img image */
>         if (ctx->ramdisk_blk_dev) {
> -               /* TODO(sjg): This should use (ulong)map_sysmem(...) */
>                 ret = efi_add_memory_map(ctx->image_addr, ctx->image_size,
>                                          EFI_CONVENTIONAL_MEMORY);
>                 if (ret != EFI_SUCCESS)
> diff --git a/lib/efi_loader/efi_smbios.c b/lib/efi_loader/efi_smbios.c
> index 02d4a5dd045..8d2ef6deb51 100644
> --- a/lib/efi_loader/efi_smbios.c
> +++ b/lib/efi_loader/efi_smbios.c
> @@ -40,11 +40,7 @@ efi_status_t efi_smbios_register(void)
>                 return EFI_NOT_FOUND;
>         }
>
> -       /*
> -        * Mark space used for tables/
> -        *
> -        * TODO(sjg): This should use (ulong)map_sysmem(addr, ...)
> -        */
> +       /* Mark space used for tables */
>         ret = efi_add_memory_map(addr, TABLE_SIZE, EFI_RUNTIME_SERVICES_DATA);
>         if (ret)
>                 return ret;
> --
> 2.34.1
>
