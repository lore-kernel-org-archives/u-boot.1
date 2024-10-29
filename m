Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A804ED339A2
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 07:34:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28BFE88D5C;
	Tue, 29 Oct 2024 08:34:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="J9pBxLOG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDC90890D1; Tue, 29 Oct 2024 08:34:23 +0100 (CET)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7258888C05
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 08:34:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-71e7086c231so3949468b3a.0
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 00:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730187260; x=1730792060; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TWN88xzNmcLf7zqasSz/m+kWNawJFX8pgRuddQmmLn4=;
 b=J9pBxLOGCNCTKcjaaZ32SJ4thyZahNc4BJ3Ol0bExavdiSKJ++ZwmfV1fNwVNvnjZ2
 1bov5xWmm3wH18oBZ3Yhg2xlYa5OYFdpFHgg9q52902po4/ox0O3cs5fAuRLLjz87G7Y
 sGCHB6lsiRAZxX6b2vHGKtO4LkJ2f4aQU89RuIOb/tg7af0crFBohaqxkklYT6oFY2rG
 HzY0BP6uR6lXdwthOf57J5N/289bG592qoZfYqAOosTcHd5dOdcrwTJZu3VCz0/yRSSR
 c2mjg1vCHtCtXeaYkhM68ezcybnJXrbKWunJ6zUpHFmk7ql2SwIUPs122t12vb8Ed7wR
 fePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730187260; x=1730792060;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TWN88xzNmcLf7zqasSz/m+kWNawJFX8pgRuddQmmLn4=;
 b=WgzSSKY8ENHDTd+V8NpqIon2ULTm7t2Vj0II/NPoMmjj5gfu7VwYf7tPFJ2fJKDlLh
 DvcY/+CGVk68knDrntW3r0YJ0PfoUJ736y1qQ92vGYFR9J45ybNJ4yy8jLfnv83SW3qs
 DzTfyA2gcipFoQdtX1Ws4N1zBxAmKz2m3Q0cYcVrcN2RJSHUARVe5jMrUhCxB93R2Q5y
 w0OAaXIAoV0xKSrPlZdyTxhq7lWOXxKl32TRhY/moBKZ+6Udel0bzTUcfh4+kgbfsF2n
 +Ua7NZHE9usxr+FNIrw1/QSTj1Q5rYbr0WZnCxdkG0p4aVvmNb/7hB4pSIYryQjiSG3D
 zRnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOwraQsJxvwwl8E6dnwevtZDiatYCL5RCdy1xIiEWZ21xu4Eyy7xU5tEoPUZhcELbODUyLozs=@lists.denx.de
X-Gm-Message-State: AOJu0Yzm3bpk3OAR1Mre7/0Wl7/fQIPOg7yZdNnqv6xysuzhDdBVoRqe
 h8b2GQtCiJNROmuDRdpwrPrgUll2FNETie140iix8BexKWIQKQTceuLPR/5i++7Ct92AT1Tpi9o
 vIBpdfJdTHG8E7efAEo5Cu6D4GPPGxVe3c6A+GOH622MoyVUGMQ0=
X-Google-Smtp-Source: AGHT+IEcZpe/tlaP/rJRPgE9Ewp5RwWRjSixJBkmQfO9yGAtdmFAFIx8IJkHnuHcfzC344MBbZPZjy0F39mUMcQSn1M=
X-Received: by 2002:a05:6a00:3cc8:b0:71e:780e:9c1 with SMTP id
 d2e1a72fcca58-7206306ecf4mr15175111b3a.18.1730187259797; Tue, 29 Oct 2024
 00:34:19 -0700 (PDT)
MIME-Version: 1.0
References: <20241025111411.165904-1-sughosh.ganu@linaro.org>
 <20241025111411.165904-5-sughosh.ganu@linaro.org>
 <c0046b33-b224-4d87-90d9-6a78eeab0624@gmx.de>
In-Reply-To: <c0046b33-b224-4d87-90d9-6a78eeab0624@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 29 Oct 2024 09:33:43 +0200
Message-ID: <CAC_iWjJxGqDzmLqphbEseknDqR97-bJ=ahOf3HO6TH1Q72HfXQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] efi: add helper functions to insert pmem node for DT
 fixup
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Sughosh Ganu <sughosh.ganu@linaro.org>
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

On Mon, 28 Oct 2024 at 08:57, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 10/25/24 13:14, Sughosh Ganu wrote:
> > The EFI HTTP boot puts the iso installer image at some location in
> > memory which needs to be reserved in the devicetree as persistent
> > memory (pmem). Add helper functions which add this pmem node when the
> > EFI_DT_FIXUP protocol's fixup callback is invoked.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> >   boot/image-fdt.c             |  9 +++++++++
> >   include/efi_loader.h         | 17 +++++++++++++++++
> >   lib/efi_loader/efi_bootmgr.c | 21 +++++++++++++++++++++
> >   lib/efi_loader/efi_helper.c  | 12 ++++++++++++
> >   4 files changed, 59 insertions(+)
> >
> > diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> > index 8eda521693..b39e81ad30 100644
> > --- a/boot/image-fdt.c
> > +++ b/boot/image-fdt.c
> > @@ -11,6 +11,7 @@
> >   #include <command.h>
> >   #include <fdt_support.h>
> >   #include <fdtdec.h>
> > +#include <efi_loader.h>
> >   #include <env.h>
> >   #include <errno.h>
> >   #include <image.h>
> > @@ -648,6 +649,14 @@ int image_setup_libfdt(struct bootm_headers *images, void *blob, bool lmb)
> >       if (!ft_verify_fdt(blob))
> >               goto err;
> >
> > +     if (CONFIG_IS_ENABLED(EFI_HTTP_BOOT)) {
> > +             fdt_ret = fdt_efi_pmem_setup(blob);
>
> Having EFI_HTTP_BOOT is not the only way to load an image to memory. You
> could have downloaded it via TFTP or taken it from a block device. So
> this config check looks wrong. Why don't you check for the presence of
> memory block devices here?

If it's an existing block device (e.g a USB), there's no need to
preserve the .iso. The installer will scan the disks and find it
again.
TFTP might make sense, but this only applies to booting EFI images, so
scanning the memory block devices is not enough.

Sughosh can you take a look and see if scanning memory blocks is doable?

>
> You need to check if the board is using ACPI, if yes, provide the ACPI
> table.

The ACPI table is out of scope on these patches. We need to add a
check and only do the fixup if we are booting with a DT, but we dont
currently plan on fixing NFIT ACPI tables.

Thanks
/Ilias

> Best regards
>
> Heinrich
>
> > +             if (fdt_ret) {
> > +                     printf("ERROR: HTTP boot pmem fixup failed\n");
> > +                     goto err;
> > +             }
> > +     }
> > +
> >       /* after here we are using a livetree */
> >       if (!of_live_active() && CONFIG_IS_ENABLED(EVENT)) {
> >               struct event_ft_fixup fixup;
> > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > index d450e304c6..031de18746 100644
> > --- a/include/efi_loader.h
> > +++ b/include/efi_loader.h
> > @@ -748,6 +748,15 @@ bool efi_varname_is_load_option(u16 *var_name16, int *index);
> >   efi_status_t efi_next_variable_name(efi_uintn_t *size, u16 **buf,
> >                                   efi_guid_t *guid);
> >
> > +/**
> > + * fdt_efi_pmem_setup() - Setup the pmem node in the devicetree
> > + *
> > + * @fdt:     Pointer to the devicetree
> > + *
> > + * Return:   0 on success, negative on failure
> > + */
> > +int fdt_efi_pmem_setup(void *fdt);
> > +
> >   /**
> >    * efi_size_in_pages() - convert size in bytes to size in pages
> >    *
> > @@ -964,6 +973,14 @@ efi_status_t efi_set_load_options(efi_handle_t handle,
> >                                 void *load_options);
> >   efi_status_t efi_bootmgr_load(efi_handle_t *handle, void **load_options);
> >
> > +/**
> > + * efi_bootmgr_pmem_setup() - Put a pmem node for UEFI HTTP installers
> > + *
> > + * @fdt:     Pointer to the DT blob
> > + * Return:   status code
> > + */
> > +efi_status_t efi_bootmgr_pmem_setup(void *fdt);
> > +
> >   /**
> >    * struct efi_image_regions - A list of memory regions
> >    *
> > diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> > index 16f75555f6..1d9246be61 100644
> > --- a/lib/efi_loader/efi_bootmgr.c
> > +++ b/lib/efi_loader/efi_bootmgr.c
> > @@ -41,6 +41,8 @@ struct uridp_context {
> >       efi_handle_t mem_handle;
> >   };
> >
> > +static struct uridp_context *uctx;
> > +
> >   const efi_guid_t efi_guid_bootmenu_auto_generated =
> >               EFICONFIG_AUTO_GENERATED_ENTRY_GUID;
> >
> > @@ -423,6 +425,7 @@ efi_status_t efi_bootmgr_release_uridp(struct uridp_context *ctx)
> >
> >       efi_free_pool(ctx->loaded_dp);
> >       free(ctx);
> > +     uctx = NULL;
> >
> >       return ret == EFI_SUCCESS ? ret2 : ret;
> >   }
> > @@ -443,6 +446,23 @@ static void EFIAPI efi_bootmgr_http_return(struct efi_event *event,
> >       EFI_EXIT(ret);
> >   }
> >
> > +/**
> > + * efi_bootmgr_pmem_setup() - Put a pmem node for UEFI HTTP installers
> > + *
> > + * @fdt:     Pointer to the DT blob
> > + * Return:   status code
> > + */
> > +efi_status_t efi_bootmgr_pmem_setup(void *fdt)
> > +{
> > +     if (!uctx) {
> > +             log_warning("No EFI HTTP boot context found\n");
> > +             return EFI_SUCCESS;
> > +     }
> > +
> > +     return !fdt_fixup_pmem_region(fdt, uctx->image_addr, uctx->image_size) ?
> > +             EFI_SUCCESS : EFI_INVALID_PARAMETER;
> > +}
> > +
> >   /**
> >    * try_load_from_uri_path() - Handle the URI device path
> >    *
> > @@ -472,6 +492,7 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
> >       if (!ctx)
> >               return EFI_OUT_OF_RESOURCES;
> >
> > +     uctx = ctx;
> >       s = env_get("loadaddr");
> >       if (!s) {
> >               log_err("Error: loadaddr is not set\n");
> > diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> > index 00167bd2a1..33cd8b9a50 100644
> > --- a/lib/efi_loader/efi_helper.c
> > +++ b/lib/efi_loader/efi_helper.c
> > @@ -242,6 +242,18 @@ int efi_unlink_dev(efi_handle_t handle)
> >       return 0;
> >   }
> >
> > +/**
> > + * fdt_efi_pmem_setup() - Setup the pmem node in the devicetree
> > + *
> > + * @fdt:     Pointer to the devicetree
> > + *
> > + * Return:   0 on success, negative on failure
> > + */
> > +int fdt_efi_pmem_setup(void *fdt)
> > +{
> > +     return efi_bootmgr_pmem_setup(fdt) == EFI_SUCCESS ? 0 : -1;
> > +}
> > +
> >   static int u16_tohex(u16 c)
> >   {
> >       if (c >= '0' && c <= '9')
>
