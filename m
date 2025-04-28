Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D2DEC369D8
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 01:48:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32B6B80F9C;
	Mon, 28 Apr 2025 03:48:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VerJiyIG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E998080FDA; Mon, 28 Apr 2025 03:48:12 +0200 (CEST)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A615380BAD
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 03:48:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-b041afe0ee1so4060226a12.1
 for <u-boot@lists.denx.de>; Sun, 27 Apr 2025 18:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745804888; x=1746409688; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xk4EnUMXCHNwZx/E4nT0um0+zhM0hL1UkYg89ffAlDc=;
 b=VerJiyIGEaEFcXqa0sduX7k29E0yd0scLoHrXz8l+UQmfJHb9d0ymgB9L2RbGkl465
 VLlA5UHAgvuvOI4BAgqQ4hWklUE7Wbh17Bc/RBOtRxGYBwWyqngk0m1VZ+oPuE0HbOdd
 qBuRB/Lygr0MQbcA+P/b+nHOQPsShFyY1hqYfLRv/QYCyLDNi9XX+So6XznGpJ65MV8S
 Tev8FYwq51JFEjC6KWWzg1itRYbrH5fPBzujtUyg27ZgUQtRJRHGnVW+kgRLKNDptR2V
 MlN4ljGNcmFTLikLQRwwaZfRRk3hSns8qcSpQ9i3l0xaGnM9iaSQVxTvLJNlbtLRRVSE
 mQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745804888; x=1746409688;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xk4EnUMXCHNwZx/E4nT0um0+zhM0hL1UkYg89ffAlDc=;
 b=ogVeeUpMfjpIDQ+ioS4GrJzEbXG5fehH4U8ms5YMFXkMj9BeRQB2nTCuouod6K1Ls7
 8kfaCRutNvefkAd86ibn7L5RGlZ4EFeWRFIEbW9hv+2stfPQRFehbJzhV8Sfnbux+E/6
 rBpsuLHyvonbX9mn0u37Wp0N8B6ZBy04a3sIV7tVrk7BummJu+XxvwQSNBndJvlzYdI1
 p7EPN4nyPkTTycw6xL/LOg4ev1ZQkOiTAfbM/K5OMgzAaWvqTXrFE0WF2CJLAN5KFBbd
 OKed/QghKgGW83aTpGl5pnzHUOXkQMT1yV99FR2N8BjSWk/5Eb+08Rz5DQNi7DeMOtaV
 Z1dQ==
X-Gm-Message-State: AOJu0Ywui1OQ4FYQXcZdOeBtOPqxAZpS/mtwb/XV1P7m4m1h15rlMTXK
 ac85xmBO+gI7SKkxFkqHxivOiybbVftQQNAFtJ9i1ywbVnzAQaK87WR5fPCB9odcB3DYUSxc0wJ
 Q4H6+TPR9wFgxNMpYO7DRPuvbg3VlqNeCU+q08w==
X-Gm-Gg: ASbGncuAOMFbsAvEojBPJ2H0mbxf59/nhruLpCOuQBAj/cTHhTZriNedBrhpDQF1VFL
 25TMxLjAixxB1zypVXwFLDpE7Gn9tUC/MV+AmzcGmcPXYR9Jq9BNiK+86U/w1elJ1xbzUnWk4U5
 SSOFMFsE1iMW+Gz4H39gRFUg==
X-Google-Smtp-Source: AGHT+IFCRfh6V1pm/WwASoppvRRSwh0Yo1dGHppBf97CR+jycZSKd4MjeJjCIqOn5fJiAS2GsuZjvW2cHPP7D2W/+/U=
X-Received: by 2002:a17:90a:d888:b0:309:eb54:9ea2 with SMTP id
 98e67ed59e1d1-309f7e00a65mr14350681a91.20.1745804887896; Sun, 27 Apr 2025
 18:48:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250319144501.32277-1-adriano.cordova@canonical.com>
 <20250319144501.32277-3-adriano.cordova@canonical.com>
 <xzymlhbywmmlczgqdleia5jieynvc5ev7gkyms5c3zzvrj5jhm@4ee4fsnkp7ec>
In-Reply-To: <xzymlhbywmmlczgqdleia5jieynvc5ev7gkyms5c3zzvrj5jhm@4ee4fsnkp7ec>
From: =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>
Date: Sun, 27 Apr 2025 21:48:45 -0400
X-Gm-Features: ATxdqUHqYEB_9eTGS_uXd7pJUagG2x0igOr_W4FVyFf2LDevEnTqVLUSCavy-q4
Message-ID: <CAMGU2hW7_LUVFvuc2myw4WcwpAWNJHXDWQmwJfgct39QC0cEog@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] efi_loader: binary_run: register an initrd
To: Weizhao Ouyang <o451686892@gmail.com>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, 
 sjg@chromium.org, trini@konsulko.com, 
 Adriano Cordova <adriano.cordova@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Weizhao,

Thank you for spotting this. I sent a patch, which you can also find here
on top of master:
https://github.com/0n41rd4/u-boot/tree/efi_initrd

Best,
Adriano


El dom, 27 abr 2025 a las 5:08, Weizhao Ouyang (<o451686892@gmail.com>)
escribi=C3=B3:

> On Wed, Mar 19, 2025 at 11:45:00AM -0300, Adriano Cordova wrote:
> > Add support to install an initrd when running an EFI binary
> > with efi_binary_run
> >
> > Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
>
> Hi Adriano,
>
> Recently I bumped U-Boot version on my Debian kit then it crashed while
> booting linux kernel:
>
> GRUB log:
> Loading Linux 6.12.22-arm64 ...
> Loading initial ramdisk ...
> error: failed to install protocols.
>
> Kernel log:
> [    0.794160] VFS: Cannot open root device
> "UUID=3Debb74af9-b4b8-45bf-b1b9-d30d094a071d" or unknown-block(0,0): erro=
r -6
> [    0.795080] Please append a correct "root=3D" boot option; here are th=
e
> available partitions:
> [    0.795814] List of all bdev filesystems:
> [    0.796168]  fuseblk
> [    0.796170]
> [    0.796500] Kernel panic - not syncing: VFS: Unable to mount root fs o=
n
> unknown-block(0,0)
> [    0.797226] CPU: 5 UID: 0 PID: 1 Comm: swapper/0 Not tainted
> 6.12.22-arm64 #1  Debian 6.12.22-1
> [    0.797993] Hardware name: armsom ArmSoM Sige7/ArmSoM Sige7, BIOS
> 2025.04-g36835a9105cf-dirty 04/01/2025
> [    0.798823] Call trace:
> [    0.799041]  dump_backtrace+0xd8/0x130
> [    0.799380]  show_stack+0x20/0x38
> [    0.799675]  dump_stack_lvl+0x60/0x80
> [    0.800003]  dump_stack+0x18/0x28
> [    0.800298]  panic+0x164/0x378
> [    0.800575]  mount_root_generic+0x200/0x2c8
> [    0.800948]  mount_root+0x17c/0x1a8
> [    0.801258]  prepare_namespace+0x1e0/0x250
> [    0.801623]  kernel_init_freeable+0x2c4/0x2f0
> [    0.802010]  kernel_init+0x28/0x150
> [    0.802323]  ret_from_fork+0x10/0x20
> [    0.802643] SMP: stopping secondary CPUs
> [    0.803101] Kernel Offset: 0x48fed5ba0000 from 0xffff800080000000
> [    0.803637] PHYS_OFFSET: 0xfff0f41e80000000
> [    0.804005] CPU features: 0x18,00000017,00280928,4201720b
> [    0.804482] Memory Limit: none
> [    0.804756] ---[ end Kernel panic - not syncing: VFS: Unable to mount
> root fs on unknown-block(0,0) ]---
>
> I git bisect it to this commit. I didn't dive into the details, just did
> a workaround as below, please check it out:
>
> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> index 2cf972343a45..cd947bb525c4 100644
> --- a/lib/efi_loader/efi_bootbin.c
> +++ b/lib/efi_loader/efi_bootbin.c
> @@ -234,6 +234,9 @@ static efi_status_t efi_binary_run_dp(void *image,
> size_t size, void *fdt,
>         if (ret !=3D EFI_SUCCESS)
>                 return ret;
>
> +       if (!initrd)
> +               goto out;
> +
>         dp_initrd =3D efi_dp_from_mem(EFI_LOADER_DATA, (uintptr_t)initrd,
> initd_sz);
>         if (!dp_initrd)
>                 return EFI_OUT_OF_RESOURCES;
> @@ -242,6 +245,7 @@ static efi_status_t efi_binary_run_dp(void *image,
> size_t size, void *fdt,
>         if (ret !=3D EFI_SUCCESS)
>                 return ret;
>
> +out:
>         return efi_run_image(image, size, dp_dev, dp_img);
>  }
>
>
> BR,
> Weizhao
>
> > ---
> >
> > Changes in v2:
> > - Change EFI_RESERVED_MEMORY_TYPE for EFI_LOADER_DATA for dp_initrd
> >
> >  boot/bootm_os.c              |  3 ++-
> >  cmd/bootefi.c                |  2 +-
> >  include/efi_loader.h         |  2 +-
> >  lib/efi_loader/efi_bootbin.c | 20 +++++++++++++++++---
> >  4 files changed, 21 insertions(+), 6 deletions(-)
> >
> > diff --git a/boot/bootm_os.c b/boot/bootm_os.c
> > index e9522cd3299..f403f352be1 100644
> > --- a/boot/bootm_os.c
> > +++ b/boot/bootm_os.c
> > @@ -507,7 +507,8 @@ static int do_bootm_efi(int flag, struct bootm_info
> *bmi)
> >
> >       ret =3D efi_binary_run(image_buf, images->os.image_len,
> >                            images->ft_len
> > -                          ? images->ft_addr : EFI_FDT_USE_INTERNAL);
> > +                          ? images->ft_addr : EFI_FDT_USE_INTERNAL,
> > +                              NULL, 0);
> >
> >       return ret;
> >  }
> > diff --git a/cmd/bootefi.c b/cmd/bootefi.c
> > index c1454ffb948..dce8285b047 100644
> > --- a/cmd/bootefi.c
> > +++ b/cmd/bootefi.c
> > @@ -211,7 +211,7 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int
> flag, int argc,
> >               }
> >       }
> >
> > -     ret =3D efi_binary_run(image_buf, size, fdt);
> > +     ret =3D efi_binary_run(image_buf, size, fdt, NULL, 0);
> >
> >       if (ret !=3D EFI_SUCCESS)
> >               return CMD_RET_FAILURE;
> > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > index cc732dc4807..ad60805ae4f 100644
> > --- a/include/efi_loader.h
> > +++ b/include/efi_loader.h
> > @@ -600,7 +600,7 @@ efi_status_t efi_install_fdt(void *fdt);
> >  /* Execute loaded UEFI image */
> >  efi_status_t do_bootefi_exec(efi_handle_t handle, void *load_options);
> >  /* Run loaded UEFI image with given fdt */
> > -efi_status_t efi_binary_run(void *image, size_t size, void *fdt);
> > +efi_status_t efi_binary_run(void *image, size_t size, void *fdt, void
> *initrd, size_t initrd_sz);
> >
> >  /**
> >   * efi_bootflow_run() - Run a bootflow containing an EFI application
> > diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.=
c
> > index deafb2ce1c2..2cf972343a4 100644
> > --- a/lib/efi_loader/efi_bootbin.c
> > +++ b/lib/efi_loader/efi_bootbin.c
> > @@ -204,6 +204,8 @@ out:
> >   * @image:   memory address of the UEFI image
> >   * @size:    size of the UEFI image
> >   * @fdt:     device-tree
> > + * @initrd:  initrd
> > + * @initrd_sz:       initrd size
> >   * @dp_dev:  EFI device-path
> >   * @dp_img:  EFI image-path
> >   *
> > @@ -213,10 +215,12 @@ out:
> >   * Return:   status code
> >   */
> >  static efi_status_t efi_binary_run_dp(void *image, size_t size, void
> *fdt,
> > +                                   void *initrd, size_t initd_sz,
> >                                     struct efi_device_path *dp_dev,
> >                                     struct efi_device_path *dp_img)
> >  {
> >       efi_status_t ret;
> > +     struct efi_device_path *dp_initrd;
> >
> >       /* Initialize EFI drivers */
> >       ret =3D efi_init_obj_list();
> > @@ -230,6 +234,14 @@ static efi_status_t efi_binary_run_dp(void *image,
> size_t size, void *fdt,
> >       if (ret !=3D EFI_SUCCESS)
> >               return ret;
> >
> > +     dp_initrd =3D efi_dp_from_mem(EFI_LOADER_DATA, (uintptr_t)initrd,
> initd_sz);
> > +     if (!dp_initrd)
> > +             return EFI_OUT_OF_RESOURCES;
> > +
> > +     ret =3D efi_initrd_register(dp_initrd);
> > +     if (ret !=3D EFI_SUCCESS)
> > +             return ret;
> > +
> >       return efi_run_image(image, size, dp_dev, dp_img);
> >  }
> >
> > @@ -239,13 +251,15 @@ static efi_status_t efi_binary_run_dp(void *image=
,
> size_t size, void *fdt,
> >   * @image:   memory address of the UEFI image
> >   * @size:    size of the UEFI image
> >   * @fdt:     device-tree
> > + * @initrd:  initrd
> > + * @initrd_sz:       initrd size
> >   *
> >   * Execute an EFI binary image loaded at @image.
> >   * @size may be zero if the binary is loaded with U-Boot load command.
> >   *
> >   * Return:   status code
> >   */
> > -efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
> > +efi_status_t efi_binary_run(void *image, size_t size, void *fdt, void
> *initrd, size_t initrd_sz)
> >  {
> >       efi_handle_t mem_handle =3D NULL;
> >       struct efi_device_path *file_path =3D NULL;
> > @@ -273,7 +287,7 @@ efi_status_t efi_binary_run(void *image, size_t
> size, void *fdt)
> >               log_debug("Loaded from disk\n");
> >       }
> >
> > -     ret =3D efi_binary_run_dp(image, size, fdt, bootefi_device_path,
> > +     ret =3D efi_binary_run_dp(image, size, fdt, initrd, initrd_sz,
> bootefi_device_path,
> >                               bootefi_image_path);
> >  out:
> >       if (mem_handle) {
> > @@ -355,7 +369,7 @@ efi_status_t efi_bootflow_run(struct bootflow *bflo=
w)
> >               log_debug("Booting with external fdt\n");
> >               fdt =3D map_sysmem(bflow->fdt_addr, 0);
> >       }
> > -     ret =3D efi_binary_run_dp(bflow->buf, bflow->size, fdt, device,
> image);
> > +     ret =3D efi_binary_run_dp(bflow->buf, bflow->size, fdt, NULL, 0,
> device, image);
> >
> >       return ret;
> >  }
> > --
> > 2.48.1
> >
>
