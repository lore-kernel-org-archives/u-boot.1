Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66848E77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 09:14:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DA038036B;
	Mon,  6 Jan 2025 10:14:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sKwmR79I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19D088036B; Mon,  6 Jan 2025 10:14:42 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82E088007D
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 10:14:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5d90a5581fcso6259142a12.1
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 01:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736154879; x=1736759679; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fekvTXT6KxcuhA9wVe4hy47NROcJbszbpXrSKT56tXg=;
 b=sKwmR79Iaqfr+gSuMLro3507JpBvi7JoGx7OVDo1gbrQblStsKwg9z1EVItkMRsnLL
 65XgSauMqlwx+s5WZhlO1mW4oOdlXbpK9xAQkvZGLqAdYHD2ktGCVaCVHvj3CAz8oJtA
 tJBxLHHVlP6e8ICowsUPHxCaoZspNTnXmS5F/VWS+kBrg7EeerNMOaDHONU63TNC1JM3
 n0LZUOdzBp+0FNQJPDqW1J5S5kuP3/GN+ldLpw5CrUBYTW40Rn9iPkkgFrdhJ8vxJ0cM
 AnWYcbk4SQR1UiVf6s06G1uTch/fN1K3PZGYiqo3q0jp3rYcwJ5R/Hz42yd1gZahPOtT
 SmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736154879; x=1736759679;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fekvTXT6KxcuhA9wVe4hy47NROcJbszbpXrSKT56tXg=;
 b=l7sHVc84jL9cRiU3xNgBPyvNNo79pXNybYvIOR+FYxLhAVDQ15+BF+FSWG5gnGZZJw
 PKKny6zU7s6y9sR5DjU62VtIaNdu/ivaa1ZBK/UG1HTpI6rxb/VQ13bXcF9ls3hccjuK
 tm9mCbMln9xbxwnZOuB4jWKZ4UEmtBKnriLkhv4i3H7c96mpt7vw+x66ycnOsj/XDCjr
 zEfMQLc+T9kaqdE/+daKCSX7vlUsGLoT8Q/CwMksqo6voMiOBsXI3vsNLU2I4ZduMPr8
 x9UUwaMsM/BoAaWswacG5EzzjmWBByOG4swtENFEhofQ10chf5sC+DKlzDUXLLkoQ+Iu
 VEBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTR19kJY2SXFfmCmHPdc64XS+N15ZPprZC0MJjDy5+hXmYpARPYuVHj1jGN77iAnhH3bDAlkg=@lists.denx.de
X-Gm-Message-State: AOJu0Ywp19VUBjNG2RqTjiXPB1DL7azSncnzsZryzfwhknYtBCcBHmvA
 fujlvjOzMSPNEeIGKu6qjO/04bBWxYHF6nZ8h0gg7ttyCTLj9RmSeraBpfxqXsyS8yxzFQNKrqF
 15j0CxMirltz1Il2SP/pxYFIy+d4ZkYFdipdeMA==
X-Gm-Gg: ASbGncuPzLax3zhJEikq/vY3H4+A9W4n+r+t+Y05yi0d3EKtPqgadF3V3Q2h0uObQO0
 fb00p+mUFjGB2k+LYjIiCjcrcx7qUv04Rimp5Obc=
X-Google-Smtp-Source: AGHT+IFB4N6wgROQ2PeW9EmJ1Goisk4DkJHVY/EnexRwE0uHEIqxEK5ZBfL1aXCNY/+cPd6QZPTC+XLCtb7kWA+nKqE=
X-Received: by 2002:a05:6402:34cc:b0:5d0:cfad:f6b with SMTP id
 4fb4d7f45d1cf-5d81dd8b175mr56518277a12.11.1736154878888; Mon, 06 Jan 2025
 01:14:38 -0800 (PST)
MIME-Version: 1.0
References: <20241203163605.1482152-1-sughosh.ganu@linaro.org>
 <20241203163605.1482152-5-sughosh.ganu@linaro.org>
 <a6c7b22a-290c-44ee-acab-58409e675bc7@gmx.de>
In-Reply-To: <a6c7b22a-290c-44ee-acab-58409e675bc7@gmx.de>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 6 Jan 2025 14:44:27 +0530
Message-ID: <CADg8p94iog+=eNceZxYAH4CXcAC0vev5Eg568Jvf5FFXReHALA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] efi: add helper functions to insert pmem node for
 DT fixup
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Anton Antonov <Anton.Antonov@arm.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>
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

On Fri, 3 Jan 2025 at 22:31, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 03.12.24 17:36, Sughosh Ganu wrote:
> > The EFI HTTP boot puts the iso installer image at some location in
> > memory which needs to be reserved in the devicetree as persistent
> > memory (pmem). Add helper functions which add this pmem node when the
> > EFI_DT_FIXUP protocol's fixup callback is invoked.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since V1:
> > * Use log_err() to print the error message in image_setup_libfdt()
> > * Remove "ERROR:" from the error print in image_setup_libfdt()
> >
> >   boot/image-fdt.c             |  9 +++++++++
> >   include/efi_loader.h         | 17 +++++++++++++++++
> >   lib/efi_loader/efi_bootmgr.c | 21 +++++++++++++++++++++
> >   lib/efi_loader/efi_helper.c  | 12 ++++++++++++
> >   4 files changed, 59 insertions(+)
> >
> > diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> > index 3d5b6f9e2dc..de479d3ffa0 100644
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
> > +             if (fdt_ret) {
> > +                     log_err("HTTP boot pmem fixup failed\n");
> > +                     goto err;
> > +             }
> > +     }
> > +
> >       /* after here we are using a livetree */
> >       if (!of_live_active() && CONFIG_IS_ENABLED(EVENT)) {
> >               struct event_ft_fixup fixup;
> > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > index 24e40799eee..87b9a6e4da0 100644
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
> > index b906e53e26e..db4eb6a7376 100644
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
> > @@ -427,6 +429,7 @@ static efi_status_t efi_bootmgr_release_uridp(struct uridp_context *ctx)
> >
> >       efi_free_pool(ctx->loaded_dp);
> >       free(ctx);
> > +     uctx = NULL;
> >
> >       return ret == EFI_SUCCESS ? ret2 : ret;
> >   }
> > @@ -447,6 +450,23 @@ static void EFIAPI efi_bootmgr_http_return(struct efi_event *event,
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
>
> This function is called if CONFIG_EFI_HTTP_BOOT=y. This configuration
> setting allows booting via HTTP but does not require it. The warning
> makes no sense when booting from a block device.

Okay. I can remove the warning.

>
> The image type is orthogonal to the way you load it. Pmem support in
> Linux is not related to UEFI. Please, remove the dependency of pmem
> support on UEFI HTTP boot.
>
> If the object to be booted is a disk image, we can create a block device
> in memory for it and then should be able to apply all standard boot
> methods on it.

I think this was discussed earlier [1]. As things stand today, the
only context in which an installer ISO image is loaded to memory is
through the EFI HTTP boot path.

-sughosh

[1] - https://lists.denx.de/pipermail/u-boot/2024-November/571335.html

>
> Best regards
>
> Heinrich
>
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
> > @@ -476,6 +496,7 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
> >       if (!ctx)
> >               return EFI_OUT_OF_RESOURCES;
> >
> > +     uctx = ctx;
> >       s = env_get("loadaddr");
> >       if (!s) {
> >               log_err("Error: loadaddr is not set\n");
> > diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> > index bf96f61d3d0..6fae37ad617 100644
> > --- a/lib/efi_loader/efi_helper.c
> > +++ b/lib/efi_loader/efi_helper.c
> > @@ -313,6 +313,18 @@ int efi_unlink_dev(efi_handle_t handle)
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
