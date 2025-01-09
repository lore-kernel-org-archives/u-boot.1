Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 017E6E77197
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 15:02:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 732D78061B;
	Thu,  9 Jan 2025 16:02:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BB1GwMuo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FE728061B; Thu,  9 Jan 2025 16:02:44 +0100 (CET)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26DAC80601
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 16:02:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2f43da61ba9so1419945a91.2
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 07:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736434958; x=1737039758; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=g4gVAVe1sO1fsy1QybDFGhlGudnjDrwwQQ+Ie0gJ8WI=;
 b=BB1GwMuoZUrWsktCIevcDjM9BIPy8PYzVz6sMs7Jd5mmqPLfE9bReJXGQYDJY1LQbx
 NZAfUmsbhz9+POdtX297HLs64J/ZGg9gEOqFhd6wlw0O5y9UZKLpm2TbLlNAGalVyfi9
 gKn/IEpnRKPOQ16AjBqmoxP8BOK7ZXmeR7kP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736434958; x=1737039758;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g4gVAVe1sO1fsy1QybDFGhlGudnjDrwwQQ+Ie0gJ8WI=;
 b=OYdgPNWZ0d+XhRCh/Qlh+XiO+vI2BdtZ7H8DjvJmPuBc4VcApK4VFnPTxgH7KblVkM
 h5W8Lhz7o0DRJY3Azmohhzs1WWZ/qqDgQU7v9ZPWglqf7Y0KKwpC4WsIPhUbABoiCt6i
 0LeUH8cevn0icB2KysNywOofzlEU7lNMm4jjAfG/x8RE7aDpEJv6xrsfxGwQIMUAoekS
 BC93A05lZ4HYuExJUfxn6T7xO49Uit1T6CSSBe2Cb8pm8DCwMiY6LFadbL/jQWwVvwIi
 ETtMJWqARpumPJwtnk9CPmBvl3hgToF7so+zFuQ6SjS4MmDwh9SdvExJFo3KbUyumoDY
 KpPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYVuOiVCQYKDl7jCFZBh6sULTnSK/LCUHUZuqTEhfbBkVwSDsHx4NCEFnzk15mM361VGmmd8w=@lists.denx.de
X-Gm-Message-State: AOJu0YzA7Aa3rIRqFBlQLAan6lA/a7GwG3+FJMety+iXR5z8e3ST9jYd
 poPHZJd0OZlOPsxhRJM1KRn270XANaeXs3LJxr3kenWRzWJOdosINjG1nmxlv3i/i31FkyCho5r
 bVjycouT6P2uUWoG5DKXzev5D5Ap21Z//5Nzz
X-Gm-Gg: ASbGnctRqVm9fZccMAgt4flPQvijEmklToaXv6jRfOESpvCAx7esrr2p2c6oWC00std
 yNILO7K5eBwkm2D9zn56x3v5AoKSnHugdNOmLTUg=
X-Google-Smtp-Source: AGHT+IHC+lLwBuldnFGP14EB2VcMJT0dKPNNVjBBwM1pe9+nX7ED1FdITyjMvD4erePeBsaxuLjkKa6DHid+y9BfTpE=
X-Received: by 2002:a17:90b:2e4b:b0:2ee:d433:7c50 with SMTP id
 98e67ed59e1d1-2f5490bd1cfmr8785118a91.23.1736434957508; Thu, 09 Jan 2025
 07:02:37 -0800 (PST)
MIME-Version: 1.0
References: <20241219023832.1098689-1-sjg@chromium.org>
 <20241219023832.1098689-7-sjg@chromium.org>
 <a7162ab5-ba6a-4b68-9b23-89a195195d51@gmx.de>
In-Reply-To: <a7162ab5-ba6a-4b68-9b23-89a195195d51@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 9 Jan 2025 08:02:11 -0700
X-Gm-Features: AbW1kvbRrhL-RRdz2sdBY7MICEkVmlE2zAUXqfQwjl5gpnuGozAUA_PoGyCcF7g
Message-ID: <CAFLszTgR_X4_OatxU6Z7YQ9zxVkXjWvpujnDBeaW_-OZGYMsUw@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] efi_loader: Pass in the required parameters from
 EFI bootmeth
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Adriano Cordova <adrianox@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Moritz Fischer <moritzf@google.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>, Patrick Wildt <pwildt@google.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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

Hi Heinrich,

On Sun, 22 Dec 2024 at 05:55, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 12/19/24 03:38, Simon Glass wrote:
> > Rather than setting up the global variables and then making the call,
> > pass them into function directly. This cleans up the code and makes it
> > all a bit easier to understand.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v2)
> >
> > Changes in v2:
> > - Use efi_loader tag instead of efi
> > - Drop unnecessary path removal
> > - Fix 'require' typo
> > - Move calculation of dev-name into a separate function
>
> Please, split the patch into logical units.

What do you mean? Are you wanting me to have this patch and then four
more after it to make the changes listed above? If so, why?

>
> >
> >   boot/bootmeth_efi.c          | 49 +------------------------
> >   include/efi_loader.h         | 10 +++++
> >   lib/efi_loader/efi_bootbin.c | 71 ++++++++++++++++++++++++++++++++++++
> >   3 files changed, 83 insertions(+), 47 deletions(-)
> >
> > diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> > index f836aa655f5..fa7f66c9a0b 100644
> > --- a/boot/bootmeth_efi.c
> > +++ b/boot/bootmeth_efi.c
> > @@ -52,40 +52,6 @@ static bool bootmeth_uses_network(struct bootflow *bflow)
> >           device_get_uclass_id(media) == UCLASS_ETH;
> >   }
> >
> > -static void set_efi_bootdev(struct blk_desc *desc, struct bootflow *bflow)
> > -{
> > -     const struct udevice *media_dev;
> > -     int size = bflow->size;
> > -     const char *dev_name;
> > -     char devnum_str[9];
> > -     char dirname[200];
> > -     char *last_slash;
> > -
> > -     /*
> > -      * This is a horrible hack to tell EFI about this boot device. Once we
> > -      * unify EFI with the rest of U-Boot we can clean this up. The same hack
> > -      * exists in multiple places, e.g. in the fs, tftp and load commands.
> > -      *
> > -      * Once we can clean up the EFI code to make proper use of driver model,
> > -      * this can go away.
> > -      */
> > -     media_dev = dev_get_parent(bflow->dev);
> > -     snprintf(devnum_str, sizeof(devnum_str), "%x:%x",
> > -              desc ? desc->devnum : dev_seq(media_dev),
> > -              bflow->part);
> > -
> > -     strlcpy(dirname, bflow->fname, sizeof(dirname));
> > -     last_slash = strrchr(dirname, '/');
> > -     if (last_slash)
> > -             *last_slash = '\0';
> > -
> > -     dev_name = device_get_uclass_id(media_dev) == UCLASS_MASS_STORAGE ?
> > -              "usb" : blk_get_uclass_name(device_get_uclass_id(media_dev));
> > -     log_debug("setting bootdev %s, %s, %s, %p, %x\n",
> > -               dev_name, devnum_str, bflow->fname, bflow->buf, size);
> > -     efi_set_bootdev(dev_name, devnum_str, bflow->fname, bflow->buf, size);
> > -}
> > -
> >   static int efiload_read_file(struct bootflow *bflow, ulong addr)
> >   {
> >       struct blk_desc *desc = NULL;
> > @@ -103,8 +69,6 @@ static int efiload_read_file(struct bootflow *bflow, ulong addr)
> >               return log_msg_ret("read", ret);
> >       bflow->buf = map_sysmem(addr, bflow->size);
> >
> > -     set_efi_bootdev(desc, bflow);
> > -
> >       return 0;
> >   }
> >
> > @@ -342,17 +306,8 @@ static int distro_efi_boot(struct udevice *dev, struct bootflow *bflow)
> >               fdt = env_get_hex("fdt_addr_r", 0);
> >       }
> >
> > -     if (bflow->flags & BOOTFLOWF_USE_BUILTIN_FDT) {
> > -             log_debug("Booting with built-in fdt\n");
> > -             if (efi_binary_run(map_sysmem(kernel, 0), bflow->size,
> > -                                EFI_FDT_USE_INTERNAL))
> > -                     return log_msg_ret("run", -EINVAL);
> > -     } else {
> > -             log_debug("Booting with external fdt\n");
> > -             if (efi_binary_run(map_sysmem(kernel, 0), bflow->size,
> > -                                map_sysmem(fdt, 0)))
> > -                     return log_msg_ret("run", -EINVAL);
> > -     }
> > +     if (efi_bootflow_run(bflow))
> > +             return log_msg_ret("run", -EINVAL);
> >
> >       return 0;
> >   }
> > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > index 9afbec35ebf..a9325b1a9d0 100644
> > --- a/include/efi_loader.h
> > +++ b/include/efi_loader.h
> > @@ -20,6 +20,7 @@
> >   #include <linux/oid_registry.h>
> >
> >   struct blk_desc;
> > +struct bootflow;
> >   struct jmp_buf_data;
> >
> >   #if CONFIG_IS_ENABLED(EFI_LOADER)
> > @@ -578,6 +579,15 @@ efi_status_t efi_install_fdt(void *fdt);
> >   efi_status_t do_bootefi_exec(efi_handle_t handle, void *load_options);
> >   /* Run loaded UEFI image with given fdt */
> >   efi_status_t efi_binary_run(void *image, size_t size, void *fdt);
> > +
> > +/**
> > + * efi_bootflow_run() - Run a bootflow containing an EFI application
> > + *
> > + * @bootflow: Bootflow to run
> > + * Return: Status code, something went wrong
> > + */
> > +efi_status_t efi_bootflow_run(struct bootflow *bootflow);
> > +
> >   /* Initialize variable services */
> >   efi_status_t efi_init_variables(void);
> >   /* Notify ExitBootServices() is called */
> > diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> > index 8332993f421..b5d15a723b4 100644
> > --- a/lib/efi_loader/efi_bootbin.c
> > +++ b/lib/efi_loader/efi_bootbin.c
> > @@ -6,13 +6,16 @@
> >
> >   #define LOG_CATEGORY LOGC_EFI
> >
> > +#include <bootflow.h>
> >   #include <charset.h>
> > +#include <dm.h>
> >   #include <efi.h>
> >   #include <efi_loader.h>
> >   #include <env.h>
> >   #include <image.h>
> >   #include <log.h>
> >   #include <malloc.h>
> > +#include <mapmem.h>
> >
> >   static struct efi_device_path *bootefi_image_path;
> >   static struct efi_device_path *bootefi_device_path;
> > @@ -285,3 +288,71 @@ out:
> >       return ret;
> >   }
> >
> > +/**
> > + * calc_dev_name() - Calculate the device name to give to EFI
> > + *
> > + * If not supported, this shows an error.
> > + *
> > + * Return name, or NULL if not supported
> > + */
> > +static const char *calc_dev_name(struct bootflow *bflow)
> > +{
> > +     const struct udevice *media_dev;
> > +
> > +     media_dev = dev_get_parent(bflow->dev);
> > +
> > +     if (!bflow->blk) {
> > +             log_err("Cannot boot EFI app on media '%s'\n",
> > +                     dev_get_uclass_name(media_dev));
> > +
> > +             return NULL;
> > +     }
> > +
> > +     if (device_get_uclass_id(media_dev) == UCLASS_MASS_STORAGE)
> > +             return "usb";
> > +
> > +     return blk_get_uclass_name(device_get_uclass_id(media_dev));
> > +}
> > +
> > +efi_status_t efi_bootflow_run(struct bootflow *bflow)
> > +{
> > +     struct efi_device_path *device, *image;
> > +     const struct udevice *media_dev;
> > +     struct blk_desc *desc = NULL;
> > +     const char *dev_name;
> > +     char devnum_str[9];
> > +     efi_status_t ret;
> > +     void *fdt;
> > +
> > +     media_dev = dev_get_parent(bflow->dev);
> > +     if (bflow->blk) {
> > +             desc = dev_get_uclass_plat(bflow->blk);
>
> Where do you handle network devices?

That's not supported with bootstd yet. See the last patch in this
series[1]. Also [2]

> > +
> > +             snprintf(devnum_str, sizeof(devnum_str), "%x:%x",
> > +                      desc ? desc->devnum : dev_seq(media_dev), bflow->part);
> > +     } else {
> > +             *devnum_str = '\0';
> > +     }
> > +
> > +     dev_name = calc_dev_name(bflow);
> > +     log_debug("dev_name '%s' devnum_str '%s' fname '%s' media_dev '%s'\n",
> > +               dev_name, devnum_str, bflow->fname, media_dev->name);
> > +     if (!dev_name)
> > +             return EFI_UNSUPPORTED;
> > +     ret = calculate_paths(dev_name, devnum_str, bflow->fname, &device,
> > +                           &image);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (bflow->flags & BOOTFLOWF_USE_BUILTIN_FDT) {
> > +             log_debug("Booting with built-in fdt\n");
> > +             fdt = EFI_FDT_USE_INTERNAL;
> > +     } else {
> > +             log_debug("Booting with external fdt\n");
> > +             fdt = map_sysmem(bflow->fdt_addr, 0);
> > +     }
> > +     ret = _efi_binary_run(bflow->buf, bflow->size, fdt, device, image);
> > +
> > +     return ret;
> > +}
> > +
>

- Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20241219023832.1098689-8-sjg@chromium.org/
[2] https://patchwork.ozlabs.org/project/uboot/list/?series=435516
