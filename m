Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41822D2E9D5
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 10:46:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7298289365;
	Mon, 11 Nov 2024 11:46:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Fwagh4cZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DF2B88A0A; Mon, 11 Nov 2024 11:46:14 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D94588936F
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 11:46:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2e2e050b1c3so4044474a91.0
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 02:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731321969; x=1731926769; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vJCR84HY5EvJ3f937LKpp3HCCvSDtgLz3F6U86nNqhs=;
 b=Fwagh4cZRoM60B1lpGSAhc3w0gcYqWXMKZVIv3NWoXmyMz1zDq2a0dcE9wj1K68aU9
 eDsTTYcB9+IQdKe+2bEX3V7snRNw5is8d2/rzndMVJJOSoTWaRMiZWJazd2pmrg/BgjC
 zieWgmlVUXhoTOCdNFJ+vQTqjbY1sskmsuo4ERIpMRwdCpAszJ0wsXklqcBGOdB9qLj1
 MxD0BqgaWwKL+QA+DpNefB2xuxbR2NQpLVtJvU43xlKSef0dwE0X0orOJkxhEHmu1ZUm
 ajDhZoYvKqTgqaUyKkkI76hdtL/w5q/lnOaV+JvOX5I2VnzJgWfSlMz7mqM9CacYVB+P
 1CpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731321969; x=1731926769;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vJCR84HY5EvJ3f937LKpp3HCCvSDtgLz3F6U86nNqhs=;
 b=ZYrgqNlnlBV0er2z6/pDdJrJ5xd7aMmSNuNAn8NBM7+ePs6XNBTnfiFm2CeDRX8Viv
 nUFSRfcl7Y+s4dcdzCCRhuJ2qtO/z2ysvgUi8KnC1UGj2JSbQq/aqLXrrUKxihgGXUc9
 9zHnraKI1VmdxYseNLqJu3QJTLATR5SDsDS5YrWEhi/UW75bl0avsHPtwIQ8jxmKZh+3
 2vYwfEyZ7K99H8gXujSLHStBB/TP/GgCis4ah3rJbvaLhWIsZwJLr0M9iUAptzut1KmI
 WeLesWWU8sRUtyGPZQ0D+vMT8bwhCwHDRFSLwt7F5YrjJfNlLJX1AjtRhuMfAXNvaMq7
 EmDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSZBJXSIWBzlFaWmAFn0vaj2EcqgboWNQ410aXALwBhu0Z0X1odnsVOy8tP3xCb4CPVQBaQgI=@lists.denx.de
X-Gm-Message-State: AOJu0Yxzb4XiAhqS/o2Y87plyxQceaMUnRkI0BCV40oo6xLVqJIF/yQb
 qJt6F3YrSg2FPBT+2+x3Uw27jGSqotP9oKCWAZAlWCzfPRUaBgPG+QSS0KWhkDJ9lK0klSfmZTC
 M9Eu87b0uypnsMgLsClJGV8BtFceuwNcsSKShBHiKwxpIWtCt
X-Google-Smtp-Source: AGHT+IELFOyiZUbmJF68F5Q4ACqDAJHDeybW/74EHjjfQYrhlfouk1K0iYJt7wTQTli40UATy9OmhcEFvIXPGFINtpc=
X-Received: by 2002:a17:90b:4a08:b0:2d8:85fc:464c with SMTP id
 98e67ed59e1d1-2e9b0b178dcmr18301505a91.11.1731321969364; Mon, 11 Nov 2024
 02:46:09 -0800 (PST)
MIME-Version: 1.0
References: <20241025111411.165904-1-sughosh.ganu@linaro.org>
 <20241025111411.165904-5-sughosh.ganu@linaro.org>
 <22d941ba-3452-4e10-ae59-642786f3d92c@gmx.de>
In-Reply-To: <22d941ba-3452-4e10-ae59-642786f3d92c@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 11 Nov 2024 12:45:33 +0200
Message-ID: <CAC_iWjL9QDD55xiSzSYgb5FB7mBfP=m+KLOGAC5JGA_y4O1LUg@mail.gmail.com>
Subject: Re: [PATCH 4/4] efi: add helper functions to insert pmem node for DT
 fixup
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
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

On Mon, 11 Nov 2024 at 10:08, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
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
> I can see no reason why pmem setup should depend on HTTP boot.

The reason is that we *know* we want to preserve image on HTTP
installers. but we should only add it if that image is booted, not
unconditionally if EFI_HTTP is enabled

>
> It should be possible to pass a memory block device to the kernel no
> matter how it was created.

Yes, we can. But how do we know we need to setup a pmem node? In this
specific case, we know http installers need the image.
If we can find similar rules (or perhaps a command line option), we
can preserve it for all images

Thanks
/Ilias
>
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
