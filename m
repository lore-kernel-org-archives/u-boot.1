Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E5C4D2E9E0
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 12:15:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7539989386;
	Mon, 11 Nov 2024 13:15:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="H2Kd9kdA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BD0889387; Mon, 11 Nov 2024 13:15:09 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30F2A8919A
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 13:15:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2e2ed59a35eso3613651a91.0
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 04:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731327306; x=1731932106; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ftlpbE3S/+EbR86Z4y9ikWRC9vKf9O+rgka13cN2HE0=;
 b=H2Kd9kdAJsrGARnERQhu5xoQ+9dr9Ycw/v0yZ3CxCqpNlWF/hkBGGlrtawR6ZFpQO0
 /rwuaACFBaxhAdWvadijUydbwQR21GUPk4ablD9sS39qLDsTjm0+dWB1KqHMJCCvRZD5
 dhXG3ywBd596rtRp797m0XnQvxFfRiVadRuIUgTilwTsQ9uSnOIXZ+ht7I+Ok4Q2Z2jD
 90QrboM0pMGc6l/er7tnwGAWQcWuLczoNOdJDix8KEN3Ft6J4O/OcWUgYu2MMK3MyDla
 vKOweBxLliEtyKt6zqeoQntbgMiBeLz2XauvEon8cA7fRHrng+VaK1nS/mm72MPo7x/8
 sPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731327306; x=1731932106;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ftlpbE3S/+EbR86Z4y9ikWRC9vKf9O+rgka13cN2HE0=;
 b=OaxGAiNQt8B9USAkdQItcYEOfhODfHLJyFNoqLBPB/gc/2nS2hfuMIpLstUrvwTAwI
 IZXQoGsYJ60kFiw8G18Q/Xhrg58sEFBhNlgWXq+hF7V8LfFDSmXXCj+aQm+QHbX4aV57
 xIVMD8ybq5OTCWDl4ZthDwZ30iseJMZEM6Uzf/ZOjW0axyw5lTqLICggK/PI2fp16U+u
 hsL2l12ojbxrjB4yw1CFlztXTLPHxVdoU0Khaep266vqLMtvcCcYATCRySeh5TBqgtIO
 gUJDC0zNTnNTb5iSMP0yroWLFvufQW6msU4B7TcomnkqoK54jl4GBbEYm+3YhvLoOQZ7
 ErlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWb90xCkk3OK9+lpDAn8Cq2XTbuzBp7+xIFyz27u4kdMyZk+xW2Td/Yq828ncY5yyBbXhBOdbY=@lists.denx.de
X-Gm-Message-State: AOJu0YweuTB4rOuvjhGwxE8CYOrfYTO5wf+twCuV+B7BLuQEPmGsYN/B
 08/RCBiWuGszAlq/iWZ1TAByHiEKOFz9TblzaE+5PI6U4HUYPcFa63PNUTZzeIE39pDBJaauU5r
 yqxvr6OUkaMkTku24/AxtbbOIyAcbtYW1mc6OqQ==
X-Google-Smtp-Source: AGHT+IEWHVwyLraHLycxACqiaCvEp6+6OA1UyG91/fy8oji9HdT5Z/wcGK72GwGn5zM+Yk7aZZNDDD8NxJdfaKKflYE=
X-Received: by 2002:a17:90b:5405:b0:2e2:c252:f861 with SMTP id
 98e67ed59e1d1-2e9b177bb29mr17566127a91.28.1731327305642; Mon, 11 Nov 2024
 04:15:05 -0800 (PST)
MIME-Version: 1.0
References: <20241025111411.165904-1-sughosh.ganu@linaro.org>
 <20241025111411.165904-5-sughosh.ganu@linaro.org>
 <22d941ba-3452-4e10-ae59-642786f3d92c@gmx.de>
 <CAC_iWjL9QDD55xiSzSYgb5FB7mBfP=m+KLOGAC5JGA_y4O1LUg@mail.gmail.com>
 <4fc7c91c-d228-4711-ba87-e8436736ae2e@gmx.de>
In-Reply-To: <4fc7c91c-d228-4711-ba87-e8436736ae2e@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 11 Nov 2024 14:14:29 +0200
Message-ID: <CAC_iWjJ9zm9eARy_GnecDSrfHPihRWjfZN-s9hz3_FHzFwjNyQ@mail.gmail.com>
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

On Mon, 11 Nov 2024 at 13:33, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 11/11/24 11:45, Ilias Apalodimas wrote:
> > Hi Heinrich
> >
> > On Mon, 11 Nov 2024 at 10:08, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >>
> >> On 10/25/24 13:14, Sughosh Ganuefi_bootmgr_pmem_setup wrote:
> >>> The EFI HTTP boot puts the iso installer image at some location in
> >>> memory which needs to be reserved in the devicetree as persistent
> >>> memory (pmem). Add helper functions which add this pmem node when the
> >>> EFI_DT_FIXUP protocol's fixup callback is invoked.
> >>>
> >>> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> >>> ---
> >>>    boot/image-fdt.c             |  9 +++++++++
> >>>    include/efi_loader.h         | 17 +++++++++++++++++
> >>>    lib/efi_loader/efi_bootmgr.c | 21 +++++++++++++++++++++
> >>>    lib/efi_loader/efi_helper.c  | 12 ++++++++++++
> >>>    4 files changed, 59 insertions(+)
> >>>
> >>> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> >>> index 8eda521693..b39e81ad30 100644
> >>> --- a/boot/image-fdt.c
> >>> +++ b/boot/image-fdt.c
> >>> @@ -11,6 +11,7 @@
> >>>    #include <command.h>
> >>>    #include <fdt_support.h>
> >>>    #include <fdtdec.h>
> >>> +#include <efi_loader.h>
> >>>    #include <env.h>
> >>>    #include <errno.h>
> >>>    #include <image.h>
> >>> @@ -648,6 +649,14 @@ int image_setup_libfdt(struct bootm_headers *images, void *blob, bool lmb)
> >>>        if (!ft_verify_fdt(blob))
> >>>                goto err;
> >>>
> >>> +     if (CONFIG_IS_ENABLED(EFI_HTTP_BOOT)) {
> >>> +             fdt_ret = fdt_efi_pmem_setup(blob);
> >>
> >> I can see no reason why pmem setup should depend on HTTP boot.
> >
> > The reason is that we *know* we want to preserve image on HTTP
> > installers. but we should only add it if that image is booted, not
> > unconditionally if EFI_HTTP is enabled
> >
> >>
> >> It should be possible to pass a memory block device to the kernel no
> >> matter how it was created.
> >
> > Yes, we can. But how do we know we need to setup a pmem node? In this
> > specific case, we know http installers need the image.
> > If we can find similar rules (or perhaps a command line option), we
> > can preserve it for all images
>
> Simon is working on patches to track loaded images. I guess there we
> would need to add the detection of image types including bare kernels,
> EFI binaries, and ISOs.
>

Yes that sounds like a good idea.

> >
> > Thanks
> > /Ilias
> >>
> >> Best regards
> >>
> >> Heinrich
> >>
> >>> +             if (fdt_ret) {
> >>> +                     printf("ERROR: HTTP boot pmem fixup failed\n");
>
> Please, use log_err() and remove "ERROR: ".
>
> >>> +                     goto err;
> >>> +             }
> >>> +     }
> >>> +
> >>>        /* after here we are using a livetree */
> >>>        if (!of_live_active() && CONFIG_IS_ENABLED(EVENT)) {
> >>>                struct event_ft_fixup fixup;
> >>> diff --git a/include/efi_loader.h b/include/efi_loader.h
> >>> index d450e304c6..031de18746 100644
> >>> --- a/include/efi_loader.h
> >>> +++ b/include/efi_loader.h
> >>> @@ -748,6 +748,15 @@ bool efi_varname_is_load_option(u16 *var_name16, int *index);
> >>>    efi_status_t efi_next_variable_name(efi_uintn_t *size, u16 **buf,
> >>>                                    efi_guid_t *guid);
> >>>
> >>> +/**
> >>> + * fdt_efi_pmem_setup() - Setup the pmem node in the devicetree
> >>> + *
> >>> + * @fdt:     Pointer to the devicetree
> >>> + *
> >>> + * Return:   0 on success, negative on failure
> >>> + */
> >>> +int fdt_efi_pmem_setup(void *fdt);
> >>> +
> >>>    /**
> >>>     * efi_size_in_pages() - convert size in bytes to size in pages
> >>>     *
> >>> @@ -964,6 +973,14 @@ efi_status_t efi_set_load_options(efi_handle_t handle,
> >>>                                  void *load_options);
> >>>    efi_status_t efi_bootmgr_load(efi_handle_t *handle, void **load_options);
> >>>
> >>> +/**
> >>> + * efi_bootmgr_pmem_setup() - Put a pmem node for UEFI HTTP installers
> >>> + *
> >>> + * @fdt:     Pointer to the DT blob
> >>> + * Return:   status code
> >>> + */
> >>> +efi_status_t efi_bootmgr_pmem_setup(void *fdt);
> >>> +
> >>>    /**
> >>>     * struct efi_image_regions - A list of memory regions
> >>>     *
> >>> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> >>> index 16f75555f6..1d9246be61 100644
> >>> --- a/lib/efi_loader/efi_bootmgr.c
> >>> +++ b/lib/efi_loader/efi_bootmgr.c
> >>> @@ -41,6 +41,8 @@ struct uridp_context {
> >>>        efi_handle_t mem_handle;
> >>>    };
> >>>
> >>> +static struct uridp_context *uctx;
> >>> +
> >>>    const efi_guid_t efi_guid_bootmenu_auto_generated =
> >>>                EFICONFIG_AUTO_GENERATED_ENTRY_GUID;
> >>>
> >>> @@ -423,6 +425,7 @@ efi_status_t efi_bootmgr_release_uridp(struct uridp_context *ctx)
> >>>
> >>>        efi_free_pool(ctx->loaded_dp);
> >>>        free(ctx);
> >>> +     uctx = NULL;
> >>>
> >>>        return ret == EFI_SUCCESS ? ret2 : ret;
> >>>    }
> >>> @@ -443,6 +446,23 @@ static void EFIAPI efi_bootmgr_http_return(struct efi_event *event,
> >>>        EFI_EXIT(ret);
> >>>    }
> >>>
> >>> +/**
> >>> + * efi_bootmgr_pmem_setup() - Put a pmem node for UEFI HTTP installers
> >>> + *
> >>> + * @fdt:     Pointer to the DT blob
> >>> + * Return:   status code
> >>> + */
> >>> +efi_status_t efi_bootmgr_pmem_setup(void *fdt)
> >>> +{
> >>> +     if (!uctx) {
> >>> +             log_warning("No EFI HTTP boot context found\n");
>
> Are we writing a warning here when loading grubriscv64.efi from disk and
> executing it?

Probably, that links to my previous comment. This should only execute
when we *know* we boot an EFI image via HTTP, not for any load.
Since we only setup that context for EFI images, simply removing the
print works for now. But as you mentioned we should plug this better
in the future once Simon series land

Thanks
/Ilias
>
> Best regards
>
> Heinrich
>
> >>> +             return EFI_SUCCESS;
> >>> +     }
> >>> +
> >>> +     return !fdt_fixup_pmem_region(fdt, uctx->image_addr, uctx->image_size) ?
> >>> +             EFI_SUCCESS : EFI_INVALID_PARAMETER;
> >>> +}
> >>> +
> >>>    /**
> >>>     * try_load_from_uri_path() - Handle the URI device path
> >>>     *
> >>> @@ -472,6 +492,7 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
> >>>        if (!ctx)
> >>>                return EFI_OUT_OF_RESOURCES;
> >>>
> >>> +     uctx = ctx;
> >>>        s = env_get("loadaddr");
> >>>        if (!s) {
> >>>                log_err("Error: loadaddr is not set\n");
> >>> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> >>> index 00167bd2a1..33cd8b9a50 100644
> >>> --- a/lib/efi_loader/efi_helper.c
> >>> +++ b/lib/efi_loader/efi_helper.c
> >>> @@ -242,6 +242,18 @@ int efi_unlink_dev(efi_handle_t handle)
> >>>        return 0;
> >>>    }
> >>>
> >>> +/**
> >>> + * fdt_efi_pmem_setup() - Setup the pmem node in the devicetree
> >>> + *
> >>> + * @fdt:     Pointer to the devicetree
> >>> + *
> >>> + * Return:   0 on success, negative on failure
> >>> + */
> >>> +int fdt_efi_pmem_setup(void *fdt)
> >>> +{
> >>> +     return efi_bootmgr_pmem_setup(fdt) == EFI_SUCCESS ? 0 : -1;
> >>> +}
> >>> +
> >>>    static int u16_tohex(u16 c)
> >>>    {
> >>>        if (c >= '0' && c <= '9')
> >>
>
