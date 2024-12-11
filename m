Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA6BE7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 14:48:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 968BC80245;
	Wed, 11 Dec 2024 15:48:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mX5Eb0xu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C6B480274; Wed, 11 Dec 2024 15:48:06 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7B2A801A9
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 15:48:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-6f0054cb797so31583607b3.0
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 06:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733928482; x=1734533282; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6REQGCVNkoZ5nFoomNrZmoH33ay7DqekhbfRV9pg6qc=;
 b=mX5Eb0xuno+taMsn14JP6cD8IR74NNFtA15HEFwNwZvTPBENOvkgffnOIGfMX7ON/D
 jU4/SXevjAm3uIozIocdOuIilDxAuO/MKiE6hzxt+Q6Y5WWHP9HdgPxMqUKLTpJvzwGi
 5jbBe/6grrL89XHmuXbaTCFUiS5+x96gtkZ9lcZE440fa0OW9Dyl/gwW3t3Yz4RnvBhE
 wePR5USAvxCig7LxWce40QV7lsdxQmrYnza1QTDT6I1+dZZuGI5i06VVh06vjslyVXFI
 QdRVckwoYI6g5FIBjvwssw1Kk1A96DAPaB9b2N74kAwpHONmYKlbi37qbmtyU+I1TeJi
 LDCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733928482; x=1734533282;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6REQGCVNkoZ5nFoomNrZmoH33ay7DqekhbfRV9pg6qc=;
 b=h3VlBhN/B01iBDQQxLTMbtxxwaqPa9TC+3fuFQS6sZGcamJv2FA3cTs5PgOOmThZ96
 /91RfIUTQPbwtDHCNDeM1n5R+9q0uZRru37kD9ZdhHSov6Z9PSSzd2alunY17qKEBhC7
 5e9ORlXm9p5jGkFkfMmTJ5TetYPJKCQW3wDc6zc2EwG+RmQ9HPxk+HN6WqQtaT9QVU0t
 BMe3+qRwGoNPPb0D4Rq3QCmaGGRbE7a8VgzSfWFtDZbaDZ8Ofnnc/LnsEiKZYkNtolRT
 NZjk3Np11BUL0dl/VnREcSvR0GBHCH6toKbJ6a3H/xm71Wn4lgFQwZo354OajaEYb/Ud
 RFCA==
X-Gm-Message-State: AOJu0Yw+MYH0tBzWwVfxL7Ydrrg3mbeYfQoK6cxrG+XChiw6nkGVr7pa
 mHvTWMJYMMaxrLZuzAeqnG6f1BCAmg0HlBKPeKurQfDL+LH4hyvaZyIvjLtX6ewY98KOc+dzeVm
 vBsnX3QfBCYPG3LjqM2uMYEAagctt+GLBsgqsZw==
X-Gm-Gg: ASbGncvvVROW0C1UMxuhgUA3t1V5m/2/e3FI89pBFhGxZMUhILpb54yqTECSEi1gFD5
 fn+aEY0YGIih9vbFzDVUjpOM6wwaWg0Ez7rU=
X-Google-Smtp-Source: AGHT+IGpdTb9QlumR+8IOKp/ixckyv5STVA6sOZwrsCegm3YEuhel7fdP9iHzCN/fYfvST+xkVc8ekyBc3WgR/PWUfg=
X-Received: by 2002:a05:690c:692:b0:6ef:6f74:9b18 with SMTP id
 00721157ae682-6f14803de39mr33276237b3.32.1733928482598; Wed, 11 Dec 2024
 06:48:02 -0800 (PST)
MIME-Version: 1.0
References: <20241211135418.563803-1-sjg@chromium.org>
 <20241211135418.563803-4-sjg@chromium.org>
In-Reply-To: <20241211135418.563803-4-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 11 Dec 2024 16:47:26 +0200
Message-ID: <CAC_iWjLVee69ALVcHixM+H4wvJhM5R03-jDCwL7unipRtr-0Fw@mail.gmail.com>
Subject: Re: [PATCH v5 03/23] efi_loader: Add comments where incorrect
 addresses are used
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
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

On Wed, 11 Dec 2024 at 15:54, Simon Glass <sjg@chromium.org> wrote:
>
> Some functions are passing addresses instead of pointers to the
> efi_add_memory_map() function. This confusion is understandable since
> the function arguments indicate an address.
>
> Make a note of the 8 places where there are problems, which would break
> usage in sandbox tests.
>
> Future work will resolve these problems.

NAK, this serves no purpose whatsoever. Just send a patch with
whatever changes you think are needed

Thanks
/Ilias
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> A request was made in v4 to drop this patch, but in the same thread, a
> query was sent about why we need these addresses, so at least until the
> series is about to be applied, I've left it in, so we can have that
> discussion in one place and build a shared understanding of why these
> addresses are needed, instead of peppering the rest of the series with
> similar questions.
>
> Link: https://lore.kernel.org/u-boot/CAC_iWjLex4Z41CDpx4u07XeCYgjB7H+Ynd8aQYL-wruH7yRmQA@mail.gmail.com/
>
> (no changes since v2)
>
> Changes in v2:
> - Add a new patch with comments where incorrect addresses are used
>
>  lib/efi_loader/efi_acpi.c    | 2 ++
>  lib/efi_loader/efi_bootmgr.c | 5 +++++
>  lib/efi_loader/efi_helper.c  | 1 +
>  lib/efi_loader/efi_smbios.c  | 6 +++++-
>  lib/efi_loader/efi_var_mem.c | 2 ++
>  5 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
> index 67bd7f8ca24..ffb360d461b 100644
> --- a/lib/efi_loader/efi_acpi.c
> +++ b/lib/efi_loader/efi_acpi.c
> @@ -28,12 +28,14 @@ efi_status_t efi_acpi_register(void)
>         /* Mark space used for tables */
>         start = ALIGN_DOWN(gd->arch.table_start, EFI_PAGE_MASK);
>         end = ALIGN(gd->arch.table_end, EFI_PAGE_MASK);
> +       /* TODO(sjg): This should use (ulong)map_sysmem(start, ...) */
>         ret = efi_add_memory_map(start, end - start, EFI_ACPI_RECLAIM_MEMORY);
>         if (ret != EFI_SUCCESS)
>                 return ret;
>         if (gd->arch.table_start_high) {
>                 start = ALIGN_DOWN(gd->arch.table_start_high, EFI_PAGE_MASK);
>                 end = ALIGN(gd->arch.table_end_high, EFI_PAGE_MASK);
> +               /* TODO(sjg): This should use (ulong)map_sysmem(start, ...) */
>                 ret = efi_add_memory_map(start, end - start,
>                                          EFI_ACPI_RECLAIM_MEMORY);
>                 if (ret != EFI_SUCCESS)
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index 8c51a6ef2ed..bb635d77b53 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -365,6 +365,8 @@ static efi_status_t prepare_loaded_image(u16 *label, ulong addr, ulong size,
>          * TODO: expose the ramdisk to OS.
>          * Need to pass the ramdisk information by the architecture-specific
>          * methods such as 'pmem' device-tree node.
> +        *
> +        * TODO(sjg): This should use (ulong)map_sysmem(addr)
>          */
>         ret = efi_add_memory_map(addr, size, EFI_RESERVED_MEMORY_TYPE);
>         if (ret != EFI_SUCCESS) {
> @@ -399,6 +401,7 @@ static efi_status_t efi_bootmgr_release_uridp(struct uridp_context *ctx)
>
>         /* cleanup for iso or img image */
>         if (ctx->ramdisk_blk_dev) {
> +               /* TODO(sjg): This should use (ulong)map_sysmem(...) */
>                 ret = efi_add_memory_map(ctx->image_addr, ctx->image_size,
>                                          EFI_CONVENTIONAL_MEMORY);
>                 if (ret != EFI_SUCCESS)
> @@ -506,6 +509,8 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
>
>                 source_buffer = NULL;
>                 source_size = 0;
> +
> +       /* TODO(sjg): This does not work on sandbox */
>         } else if (efi_check_pe((void *)image_addr, image_size, NULL) == EFI_SUCCESS) {
>                 /*
>                  * loaded_dp must exist until efi application returns,
> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> index bf96f61d3d0..fd89ef6036f 100644
> --- a/lib/efi_loader/efi_helper.c
> +++ b/lib/efi_loader/efi_helper.c
> @@ -486,6 +486,7 @@ static efi_status_t copy_fdt(void **fdtp)
>                 log_err("Failed to reserve space for FDT\n");
>                 goto done;
>         }
> +       /* TODO(sjg): This does not work on sandbox */
>         new_fdt = (void *)(uintptr_t)new_fdt_addr;
>         memcpy(new_fdt, fdt, fdt_totalsize(fdt));
>         fdt_set_totalsize(new_fdt, fdt_size);
> diff --git a/lib/efi_loader/efi_smbios.c b/lib/efi_loader/efi_smbios.c
> index 8d2ef6deb51..02d4a5dd045 100644
> --- a/lib/efi_loader/efi_smbios.c
> +++ b/lib/efi_loader/efi_smbios.c
> @@ -40,7 +40,11 @@ efi_status_t efi_smbios_register(void)
>                 return EFI_NOT_FOUND;
>         }
>
> -       /* Mark space used for tables */
> +       /*
> +        * Mark space used for tables/
> +        *
> +        * TODO(sjg): This should use (ulong)map_sysmem(addr, ...)
> +        */
>         ret = efi_add_memory_map(addr, TABLE_SIZE, EFI_RUNTIME_SERVICES_DATA);
>         if (ret)
>                 return ret;
> diff --git a/lib/efi_loader/efi_var_mem.c b/lib/efi_loader/efi_var_mem.c
> index 139e16aad7c..5c69a1e0f3e 100644
> --- a/lib/efi_loader/efi_var_mem.c
> +++ b/lib/efi_loader/efi_var_mem.c
> @@ -226,6 +226,8 @@ efi_status_t efi_var_mem_init(void)
>                                  &memory);
>         if (ret != EFI_SUCCESS)
>                 return ret;
> +
> +       /* TODO(sjg): This does not work on sandbox */
>         efi_var_buf = (struct efi_var_file *)(uintptr_t)memory;
>         memset(efi_var_buf, 0, EFI_VAR_BUF_SIZE);
>         efi_var_buf->magic = EFI_VAR_FILE_MAGIC;
> --
> 2.34.1
>
