Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88061E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 15:32:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1121080192;
	Thu, 12 Dec 2024 16:32:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="L5Ut55zr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65EED801BE; Thu, 12 Dec 2024 16:32:35 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F5658018E
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 16:32:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-6efa5bf5202so6068217b3.3
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 07:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734017551; x=1734622351; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a8tuOqiDW5D+Hk92uSGd8gsBh/whTjqqwmxHLLrGu48=;
 b=L5Ut55zrByIUb/9Xg4GeAoiLga0+ZZZ8UHJHmRz5Y8uLYgdmsoxW4cJyXF00utsydG
 XI/fO0RvyqgxtJDt5fm4uUMDaSXENgdV1iDxRa2qUibrEnuGFDji89I/pIWR5Pwi8M2G
 1s+1X6vB5zTFMLhuVIT+JM75M116NpXW7SbemFz1dZ4xXzzMvBfub+Tw5JsLz7/vKTls
 DQah4uOXlEgBc2VO6kdV4FIqS4QZ1ouX9G910fCzofAbM96YaMXR/7cA8g1bCNFH8cSl
 PCHFHs1SkQUltlgiiXaeGjNbd8iz0JIkHUkNQjcTOWGFJd0GsOqU0TSFYl3LgDunSLJd
 cSZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734017551; x=1734622351;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a8tuOqiDW5D+Hk92uSGd8gsBh/whTjqqwmxHLLrGu48=;
 b=WH17cmEb033J/Zqhbl12QR+mfXmzT9ri6uNzuGKWLs41YGNl6f3NbdwdKnsMUKd7Fk
 O8WsvLr+4p03JY5DUX6rtnAwWCg8P7zOXVOo/lBZqWDCHoEt3ZVOdlNV6We0s2NH0K9V
 n4L5ZhFhQRWkOpvMVu6/Vpyk6f9+LTNvWcSYyJH+N3B4q9pLMUYIlPercXdOHOSoNzl0
 dyD9jBXNzYjXAosplcpzfqeCHTCVZ+zN2nKr4oUDFhrtZTxdlleVA8RWOk9FMMa6mS7y
 HJnIuIzxQNTbQKkXuN00wF4LewcMI5AfwbsL0rOeriqMqzFQwF514vZ1ddtwWUVrgoWm
 MERQ==
X-Gm-Message-State: AOJu0YxStKh0t+6ixaqgX0g7WOTS37zSW4Twl5NCBCmoSIQtqu/H5fq1
 BkR7dOn1n7q4W2CHXT+440LVKhi19MKdt1tlKm5+6E004ZiuHYr+XMglBAy9ZqQ//q8cj9RrLOk
 GJk3eOCpS4spRUi6MiMI6vP16bmNYQm4X1vTiOA==
X-Gm-Gg: ASbGncscAbhbrSKJ30xZVc/+OawpFmo7c4HkYn/wGbwSxZZy4V/HghzEFI0yEeO1lId
 qLBCN5kHZQjjoxN/h7Iv3S4fXtfWVRAclv9nDSw==
X-Google-Smtp-Source: AGHT+IG+vbTUqszBxJCeyI9azKtvQu3Dsat5+t3ANSOW8srz6gznW2tCrvXcEkTdaqIpPPDT6YPyvKyTtUa49JXAICo=
X-Received: by 2002:a05:690c:6a07:b0:6ef:593e:285c with SMTP id
 00721157ae682-6f275263d45mr8223667b3.3.1734017551192; Thu, 12 Dec 2024
 07:32:31 -0800 (PST)
MIME-Version: 1.0
References: <20241211135418.563803-1-sjg@chromium.org>
 <20241211135418.563803-4-sjg@chromium.org>
 <CAC_iWjLVee69ALVcHixM+H4wvJhM5R03-jDCwL7unipRtr-0Fw@mail.gmail.com>
 <CAFLszTgxbkFP9o+tb-983P3vPmH+qHd8vp7VBym2WafhcwKQLg@mail.gmail.com>
 <CAC_iWjLNvR=TMp9tvuwrxmjqN7+Gz8-CZbaCgq841NcPQNQukA@mail.gmail.com>
 <CAFLszTiirJ9eLJ6R4rJ5LDWA4M2o3Mksdk8z35=NKQM244LKYA@mail.gmail.com>
In-Reply-To: <CAFLszTiirJ9eLJ6R4rJ5LDWA4M2o3Mksdk8z35=NKQM244LKYA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 12 Dec 2024 17:31:55 +0200
Message-ID: <CAC_iWjJRK2wvObHAtDENQQqmZwwbcozexXtWwzbvscmdT_jRfg@mail.gmail.com>
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

On Thu, 12 Dec 2024 at 15:44, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Wed, 11 Dec 2024 at 23:15, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > On Wed, 11 Dec 2024 at 17:58, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Ilias,
> > >
> > > On Wed, 11 Dec 2024 at 07:48, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > On Wed, 11 Dec 2024 at 15:54, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Some functions are passing addresses instead of pointers to the
> > > > > efi_add_memory_map() function. This confusion is understandable since
> > > > > the function arguments indicate an address.
> > > > >
> > > > > Make a note of the 8 places where there are problems, which would break
> > > > > usage in sandbox tests.
> > > > >
> > > > > Future work will resolve these problems.
> > > >
> > > > NAK, this serves no purpose whatsoever. Just send a patch with
> > > > whatever changes you think are needed
> > >
> > > Please see below
> > >
> > > >
> > > > Thanks
> > > > /Ilias
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > > A request was made in v4 to drop this patch, but in the same thread, a
> > > > > query was sent about why we need these addresses, so at least until the
> > > > > series is about to be applied, I've left it in, so we can have that
> > > > > discussion in one place and build a shared understanding of why these
> > > > > addresses are needed, instead of peppering the rest of the series with
> > > > > similar questions.
> > >
> > > I'm quite happy to drop this patch. But I want to first make sure that
> > > you understand that these bugs exist today in the code, albeit they
> > > only matter on sandbox.
> >
> > Thei weird thing is sandbox works perfectly fine in EFI, passes all
> > internal tests, EFI SCT tests, loads binaries etc. Any idea why that
> > works?
>
> From what I can tell, the code mentioned is not tested by sandbox yet.
> It would just segfault. We do have a lot of self tests, but my
> bootflow_efi should allow testing of more features over time. I
> noticed the runtime-code issue when looking at an EFI log.
>
> BTW how are you running that? When I tried it on x86_64 it just
> crashed. Are you using the sandbox build on an Arm64 machine?

Yes, and it passes all the SCT tests.

Thanks
/Ilias
>
> >
> > > You will notice that my future patches don't
> > > change the code mentioned in this file. The bugs are simply resolved
> > > by reworking the EFI-loader memory map to use addresses, instead of
> > > pointers cast to u64
> > >
> > > So can you please confirm this makes sense? (if not, let's discuss
> > > it). Then I can drop this patch and the later one.
> >
> > The ptrs to u64 doesn't make too much sense tbh. I do understand how
> > sandbox works, but EFI deals with physical addresses which are also
> > mapped 1:1
>
> Yes, and that's why (in efi_boottime) the conversion is done in one
> place (from u64 pointers/addresses to U-Boot addresses). It simplifies
> the code and avoids the kind of bugs here.
>
> Regards,
> Simon
>
>
> >
> > Thanks
> > /Ilias
> > >
> > > > >
> > > > > Link: https://lore.kernel.org/u-boot/CAC_iWjLex4Z41CDpx4u07XeCYgjB7H+Ynd8aQYL-wruH7yRmQA@mail.gmail.com/
> > > > >
> > > > > (no changes since v2)
> > > > >
> > > > > Changes in v2:
> > > > > - Add a new patch with comments where incorrect addresses are used
> > > > >
> > > > >  lib/efi_loader/efi_acpi.c    | 2 ++
> > > > >  lib/efi_loader/efi_bootmgr.c | 5 +++++
> > > > >  lib/efi_loader/efi_helper.c  | 1 +
> > > > >  lib/efi_loader/efi_smbios.c  | 6 +++++-
> > > > >  lib/efi_loader/efi_var_mem.c | 2 ++
> > > > >  5 files changed, 15 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
> > > > > index 67bd7f8ca24..ffb360d461b 100644
> > > > > --- a/lib/efi_loader/efi_acpi.c
> > > > > +++ b/lib/efi_loader/efi_acpi.c
> > > > > @@ -28,12 +28,14 @@ efi_status_t efi_acpi_register(void)
> > > > >         /* Mark space used for tables */
> > > > >         start = ALIGN_DOWN(gd->arch.table_start, EFI_PAGE_MASK);
> > > > >         end = ALIGN(gd->arch.table_end, EFI_PAGE_MASK);
> > > > > +       /* TODO(sjg): This should use (ulong)map_sysmem(start, ...) */
> > > > >         ret = efi_add_memory_map(start, end - start, EFI_ACPI_RECLAIM_MEMORY);
> > > > >         if (ret != EFI_SUCCESS)
> > > > >                 return ret;
> > > > >         if (gd->arch.table_start_high) {
> > > > >                 start = ALIGN_DOWN(gd->arch.table_start_high, EFI_PAGE_MASK);
> > > > >                 end = ALIGN(gd->arch.table_end_high, EFI_PAGE_MASK);
> > > > > +               /* TODO(sjg): This should use (ulong)map_sysmem(start, ...) */
> > > > >                 ret = efi_add_memory_map(start, end - start,
> > > > >                                          EFI_ACPI_RECLAIM_MEMORY);
> > > > >                 if (ret != EFI_SUCCESS)
> > > > > diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> > > > > index 8c51a6ef2ed..bb635d77b53 100644
> > > > > --- a/lib/efi_loader/efi_bootmgr.c
> > > > > +++ b/lib/efi_loader/efi_bootmgr.c
> > > > > @@ -365,6 +365,8 @@ static efi_status_t prepare_loaded_image(u16 *label, ulong addr, ulong size,
> > > > >          * TODO: expose the ramdisk to OS.
> > > > >          * Need to pass the ramdisk information by the architecture-specific
> > > > >          * methods such as 'pmem' device-tree node.
> > > > > +        *
> > > > > +        * TODO(sjg): This should use (ulong)map_sysmem(addr)
> > > > >          */
> > > > >         ret = efi_add_memory_map(addr, size, EFI_RESERVED_MEMORY_TYPE);
> > > > >         if (ret != EFI_SUCCESS) {
> > > > > @@ -399,6 +401,7 @@ static efi_status_t efi_bootmgr_release_uridp(struct uridp_context *ctx)
> > > > >
> > > > >         /* cleanup for iso or img image */
> > > > >         if (ctx->ramdisk_blk_dev) {
> > > > > +               /* TODO(sjg): This should use (ulong)map_sysmem(...) */
> > > > >                 ret = efi_add_memory_map(ctx->image_addr, ctx->image_size,
> > > > >                                          EFI_CONVENTIONAL_MEMORY);
> > > > >                 if (ret != EFI_SUCCESS)
> > > > > @@ -506,6 +509,8 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
> > > > >
> > > > >                 source_buffer = NULL;
> > > > >                 source_size = 0;
> > > > > +
> > > > > +       /* TODO(sjg): This does not work on sandbox */
> > > > >         } else if (efi_check_pe((void *)image_addr, image_size, NULL) == EFI_SUCCESS) {
> > > > >                 /*
> > > > >                  * loaded_dp must exist until efi application returns,
> > > > > diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> > > > > index bf96f61d3d0..fd89ef6036f 100644
> > > > > --- a/lib/efi_loader/efi_helper.c
> > > > > +++ b/lib/efi_loader/efi_helper.c
> > > > > @@ -486,6 +486,7 @@ static efi_status_t copy_fdt(void **fdtp)
> > > > >                 log_err("Failed to reserve space for FDT\n");
> > > > >                 goto done;
> > > > >         }
> > > > > +       /* TODO(sjg): This does not work on sandbox */
> > > > >         new_fdt = (void *)(uintptr_t)new_fdt_addr;
> > > > >         memcpy(new_fdt, fdt, fdt_totalsize(fdt));
> > > > >         fdt_set_totalsize(new_fdt, fdt_size);
> > > > > diff --git a/lib/efi_loader/efi_smbios.c b/lib/efi_loader/efi_smbios.c
> > > > > index 8d2ef6deb51..02d4a5dd045 100644
> > > > > --- a/lib/efi_loader/efi_smbios.c
> > > > > +++ b/lib/efi_loader/efi_smbios.c
> > > > > @@ -40,7 +40,11 @@ efi_status_t efi_smbios_register(void)
> > > > >                 return EFI_NOT_FOUND;
> > > > >         }
> > > > >
> > > > > -       /* Mark space used for tables */
> > > > > +       /*
> > > > > +        * Mark space used for tables/
> > > > > +        *
> > > > > +        * TODO(sjg): This should use (ulong)map_sysmem(addr, ...)
> > > > > +        */
> > > > >         ret = efi_add_memory_map(addr, TABLE_SIZE, EFI_RUNTIME_SERVICES_DATA);
> > > > >         if (ret)
> > > > >                 return ret;
> > > > > diff --git a/lib/efi_loader/efi_var_mem.c b/lib/efi_loader/efi_var_mem.c
> > > > > index 139e16aad7c..5c69a1e0f3e 100644
> > > > > --- a/lib/efi_loader/efi_var_mem.c
> > > > > +++ b/lib/efi_loader/efi_var_mem.c
> > > > > @@ -226,6 +226,8 @@ efi_status_t efi_var_mem_init(void)
> > > > >                                  &memory);
> > > > >         if (ret != EFI_SUCCESS)
> > > > >                 return ret;
> > > > > +
> > > > > +       /* TODO(sjg): This does not work on sandbox */
> > > > >         efi_var_buf = (struct efi_var_file *)(uintptr_t)memory;
> > > > >         memset(efi_var_buf, 0, EFI_VAR_BUF_SIZE);
> > > > >         efi_var_buf->magic = EFI_VAR_FILE_MAGIC;
> > > > > --
> > > > > 2.34.1
> > > > >
