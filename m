Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA6BBCDB483
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 08:33:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1381B86A3C;
	Wed, 18 Oct 2023 10:33:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bOuSPp1N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B643786BB8; Wed, 18 Oct 2023 10:32:59 +0200 (CEST)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CA0B86801
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 10:32:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-27d5c71b4d7so3002215a91.1
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 01:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697617975; x=1698222775; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=irQUGit37h33mjDFueIsOmuVRe8uRUnGIVNXGokEKAw=;
 b=bOuSPp1NPLS1ZlFMuLPinlXOrVChWAo9YpsIdmFR//fScjWl+R2FhBImbgtKd3GMxJ
 YAXPQoUFFLxs1j+OXBJpyH0NJzOlXdxI0N82iHcTqRglIWv3SsCMPYfov1fGksjmcjlI
 a6GeJjIQz9KX/VH/N7XUlinr7XNWg+7LIpU1SjgHllWs3/1NTq1Wx+dO5BN8uz3VxtrM
 dgmAMSmFRgXMIhBfW9zN8KRsZkY6+UL5wEOKy+2+FzSsY9UzCrg8aHQGqX+0LOO6b6Sl
 XNTvot9QLAhJnTdzUEKT/vEfmF+D+qc3N/pB4LFuh3sMXTQJpO0W9oQkOHhEERDpJoPf
 qVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697617975; x=1698222775;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=irQUGit37h33mjDFueIsOmuVRe8uRUnGIVNXGokEKAw=;
 b=fUqG7xsiCg6T2BFabas18cySkTXvYuucp1zdZGyDpczAkF6+C3XzxBZIbX675MIiSZ
 +uPxZudFmuYrHOCrM5tHx/EQh2ViRBoS1RhZ30B/Z/clB/LZhu01aApUfR293J2WI82d
 tXlyT1jhNaRG8hKMb4kCSJ2DulVEn9ZdDqu1RNlxs3Nohr/ybT87kt07Qgh5L097+Tm8
 9WBSXO+N/JoGZF44tWwMHrTwj+23DZiyH0lukAyA50CevHQvhNGo/mlGuMeNrLUgr00s
 230DeoQS0Bl84b6NHYmrAHwNnKhg4zKZ3yHSt/nhIxdHGIBrpn0Dch0GZNGRN9oYCpKA
 j5lw==
X-Gm-Message-State: AOJu0YyMS2tXHW05TQr+zpu83Gof0i7gf1gaAinM0scopgnamS9ILTRr
 R9JgZEzN1UnF0CxC6IuSo29sApukvDhZxv8a71meTQ==
X-Google-Smtp-Source: AGHT+IHI6lLzKeueh1gwjToLocmFbyJHmnrVQiX7mU0NjMnJpgXYtdbYMgmkLtY0JTGESee8T7QUJMiimSx+EhICWQA=
X-Received: by 2002:a17:90a:9481:b0:27d:1369:515e with SMTP id
 s1-20020a17090a948100b0027d1369515emr6134358pjo.22.1697617975510; Wed, 18 Oct
 2023 01:32:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231016064526.2410856-1-masahisa.kojima@linaro.org>
 <20231016064526.2410856-6-masahisa.kojima@linaro.org>
 <4da03160-889b-4a7e-8476-0f93cf3998c2@gmx.de>
In-Reply-To: <4da03160-889b-4a7e-8476-0f93cf3998c2@gmx.de>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Wed, 18 Oct 2023 17:32:44 +0900
Message-ID: <CADQ0-X9tQfy0Dq-kwmBz0A1fKCgciiE+hOMrf=krLJ-hn9YZCA@mail.gmail.com>
Subject: Re: [PATCH v7 5/9] efi_loader: support boot from URI device path
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
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


On Wed, 18 Oct 2023 at 09:42, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 16.10.23 08:45, Masahisa Kojima wrote:
> > This supports to boot from the URI device path.
> > When user selects the URI device path, bootmgr downloads
> > the file using wget into the address specified by loadaddr
> > env variable.
> > If the file is .iso or .img file, mount the image with blkmap
> > then try to boot with the default file(e.g. EFI/BOOT/BOOTAA64.EFI).
> > Since boot option indicating the default file is automatically
> > created when new disk is detected, system can boot by selecting
> > the automatically created blkmap boot option.
> > If the file is PE-COFF file, load and start the downloaded file.
> >
> > The buffer used to download the ISO image file must be
> > reserved to avoid the unintended access to the image.
> > For PE-COFF file case, this memory reservation is done
> > in LoadImage Boot Service.
> >
> > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> > ---
> >   include/efi_loader.h          |   2 +
> >   lib/efi_loader/Kconfig        |   9 ++
> >   lib/efi_loader/efi_bootmgr.c  | 198 ++++++++++++++++++++++++++++++++++
> >   lib/efi_loader/efi_dt_fixup.c |   2 +-
> >   4 files changed, 210 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > index e24410505f..106006127b 100644
> > --- a/include/efi_loader.h
> > +++ b/include/efi_loader.h
> > @@ -554,6 +554,8 @@ void efi_runtime_detach(void);
> >   /* efi_convert_pointer() - convert pointer to virtual address */
> >   efi_status_t EFIAPI efi_convert_pointer(efi_uintn_t debug_disposition,
> >                                       void **address);
> > +/* add reserved memory to memory map */
> > +void efi_reserve_memory(u64 addr, u64 size, bool nomap);
> >   /* Carve out DT reserved memory ranges */
> >   void efi_carve_out_dt_rsv(void *fdt);
> >   /* Purge unused kaslr-seed */
> > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > index d20aaab6db..5d99206dc3 100644
> > --- a/lib/efi_loader/Kconfig
> > +++ b/lib/efi_loader/Kconfig
> > @@ -479,4 +479,13 @@ config EFI_RISCV_BOOT_PROTOCOL
> >         replace the transfer via the device-tree. The latter is not
> >         possible on systems using ACPI.
> >
> > +config EFI_HTTP_BOOT
> > +     bool "EFI HTTP Boot support"
> > +     depends on CMD_DNS
> > +     depends on CMD_WGET
> > +     depends on BLKMAP
> > +     help
> > +       Enabling this option adds EFI HTTP Boot support. It allows to
> > +       directly boot from network.
> > +
> >   endif
> > diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> > index c8cf1c5506..c90b68f783 100644
> > --- a/lib/efi_loader/efi_bootmgr.c
> > +++ b/lib/efi_loader/efi_bootmgr.c
> > @@ -7,10 +7,14 @@
> >
> >   #define LOG_CATEGORY LOGC_EFI
> >
> > +#include <blk.h>
> > +#include <blkmap.h>
> >   #include <common.h>
> >   #include <charset.h>
> > +#include <dm.h>
> >   #include <log.h>
> >   #include <malloc.h>
> > +#include <net.h>
> >   #include <efi_default_filename.h>
> >   #include <efi_loader.h>
> >   #include <efi_variable.h>
> > @@ -168,6 +172,192 @@ out:
> >       return ret;
> >   }
> >
> > +/**
> > + * mount_image() - mount the image with blkmap
> > + *
> > + * @lo_label:        u16 label string of load option
> > + * @image_addr:      image address
> > + * @image_size:      image size
> > + * Return:   pointer to the UCLASS_BLK udevice, NULL if failed
> > + */
> > +static struct udevice *mount_image(u16 *lo_label, ulong image_addr, int image_size)
> > +{
> > +     int err;
> > +     struct blkmap *bm;
> > +     struct udevice *bm_dev;
> > +     char *label = NULL, *p;
> > +
> > +     label = efi_alloc(utf16_utf8_strlen(lo_label) + 1);
> > +     if (!label)
> > +             return NULL;
> > +
> > +     p = label;
> > +     utf16_utf8_strcpy(&p, lo_label);
> > +     err = blkmap_create_ramdisk(label, image_addr, image_size, &bm_dev);
> > +     if (err) {
> > +             efi_free_pool(label);
> > +             return NULL;
> > +     }
> > +     bm = dev_get_plat(bm_dev);
> > +
> > +     efi_free_pool(label);
> > +
> > +     return bm->blk;
> > +}
> > +
> > +/**
> > + * load_mounted_image() - load mounted image with default file
> > + *
> > + * @devnum:  target blkmap device
> > + * @handle:  pointer to handle for newly installed image
> > + * Return:   status code
> > + */
> > +static efi_status_t load_mounted_image(int devnum, efi_handle_t *handle)
> > +{
> > +     u32 i;
> > +     u16 *bm_label, *p;
> > +     char device_name[12];
> > +     u16 *bootorder = NULL;
> > +     efi_uintn_t num, size;
> > +     void *load_option = NULL;
> > +     struct efi_load_option lo;
> > +     u16 varname[] = u"Boot####";
> > +     efi_status_t ret = EFI_NOT_FOUND;
> > +
> > +     snprintf(device_name, 12, "blkmap %d", devnum);
> > +     bm_label = calloc(1, (strlen(device_name) + 1) * sizeof(u16));
> > +     if (!bm_label)
> > +             return EFI_OUT_OF_RESOURCES;
> > +
> > +     p = bm_label;
> > +     utf8_utf16_strcpy(&p, device_name);
> > +
> > +     bootorder = efi_get_var(u"BootOrder", &efi_global_variable_guid, &size);
> > +     if (!bootorder)
> > +             goto out;
> > +
> > +     num = size / sizeof(u16);
> > +     for (i = 0; i < num; i++) {
> > +             efi_create_indexed_name(varname, sizeof(varname), "Boot",
> > +                                     bootorder[i]);
> > +             load_option = efi_get_var(varname, &efi_global_variable_guid, &size);
> > +             if (!load_option)
> > +                     continue;
> > +
> > +             ret = efi_deserialize_load_option(&lo, load_option, &size);
> > +             if (ret != EFI_SUCCESS) {
> > +                     free(load_option);
> > +                     continue;
> > +             }
> > +
> > +             /* check whether the label indicates the target blkmap device */
> > +             if (u16_strncmp(bm_label, lo.label, u16_strlen(bm_label))) {
> > +                     free(load_option);
> > +                     continue;
> > +             }
> > +
> > +             /* check whether the boot option is automatically generated */
> > +             if (guidcmp(lo.optional_data, &efi_guid_bootmenu_auto_generated)) {
> > +                     free(load_option);
> > +                     continue;
> > +             }
> > +
> > +             ret = EFI_CALL(efi_load_image(true, efi_root, lo.file_path,
> > +                                           NULL, 0, handle));
> > +             free(load_option);
> > +             goto out;
> > +     }
> > +
> > +     if (i == num)
> > +             ret = EFI_NOT_FOUND;
> > +out:
> > +     free(bm_label);
> > +     free(bootorder);
> > +
> > +     return ret;
> > +}
> > +
> > +/**
> > + * try_load_from_uri_path() - Handle the URI device path
> > + *
> > + * @uridp:   uri device path
> > + * @lo_label:        label of load option
> > + * @handle:  pointer to handle for newly installed image
> > + * Return:   status code
> > + */
> > +static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
> > +                                        u16 *lo_label,
> > +                                        efi_handle_t *handle)
> > +{
> > +     char *s;
> > +     int err;
> > +     int uri_len;
> > +     u32 image_size;
> > +     efi_status_t ret;
> > +     ulong image_addr;
> > +
> > +     s = env_get("loadaddr");
> > +     if (!s) {
> > +             log_err("Error: loadaddr is not set\n");
> > +             return EFI_INVALID_PARAMETER;
> > +     }
> > +     image_addr = hextoul(s, NULL);
> > +     err = wget_with_dns(image_addr, uridp->uri);
> > +     if (err < 0)
> > +             return EFI_INVALID_PARAMETER;
> > +     image_size = env_get_hex("filesize", 0);
> > +     if (!image_size)
> > +             return EFI_INVALID_PARAMETER;
> > +
> > +     /*
> > +      * If the file extension is ".iso" or ".img", mount it and try to load
> > +      * the default file.
> > +      * If the file is PE-COFF image, load the downloaded file.
> > +      */
> > +     uri_len = strlen(uridp->uri);
> > +     if (!strncmp(&uridp->uri[uri_len - 4], ".iso", 4) ||
> > +         !strncmp(&uridp->uri[uri_len - 4], ".img", 4)) {
> > +             struct udevice *blk;
> > +             struct blk_desc *desc;
> > +
> > +             blk = mount_image(lo_label, image_addr, image_size);
> > +             if (!blk)
> > +                     return EFI_LOAD_ERROR;
> > +
> > +             /*
> > +              * When the new disk is detected, boot option is automatically
> > +              * created if it has a default file.
> > +              * Let's load the automatically created boot option.
> > +              */
> > +             desc = dev_get_uclass_plat(blk);
> > +             ret = load_mounted_image(desc->devnum, handle);
> > +             if (ret != EFI_SUCCESS)
> > +                     return ret;
> > +
> > +             /* whole ramdisk must be reserved */
> > +             efi_reserve_memory(image_addr, image_size, true);
>
> This comment is not enough to explain why you make the reservation.
>
> Our blkmap driver is gone after ExitBootServices().
> Why is EFI_LOADER_DATA not good enough?

In current implementation, this ramdisk is not passed to Linux,
so this whole ramdisk is not required to be reserved.

> How will the image be passed to Linux?

If the kernel supports 'pmem'(drivers/nvdimm/of_pmem.c), U-Boot can
expose the ramdisk.
For example, with the following 'pmem' device-tree node,
linux can mount the 256MB ramdisk starting from 0x90000000.

+        pmem@90000000 {
+            compatible = "pmem-region";
+            reg = < 0x0 0x90000000 0x0 0x10000000 >;
+            volatile;
+        };

In my check, SUSE installer supports this pmem feature.
I will try to integrate this in this series.

Thanks,
Masahisa Kojima

>
> Best regards
>
> Heinrich
>
>
> > +     } else if (efi_check_pe((void *)image_addr, image_size, NULL) == EFI_SUCCESS) {
> > +             efi_handle_t mem_handle = NULL;
> > +             struct efi_device_path *file_path;
> > +
> > +             file_path = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
> > +                                         (uintptr_t)image_addr, image_size);
> > +             ret = efi_install_multiple_protocol_interfaces(
> > +                     &mem_handle, &efi_guid_device_path, file_path, NULL);
> > +             if (ret != EFI_SUCCESS)
> > +                     return ret;
> > +
> > +             ret = EFI_CALL(efi_load_image(false, efi_root, file_path,
> > +                                           (void *)image_addr, image_size,
> > +                                           handle));
> > +     } else {
> > +             log_err("Error: file type is not supported\n");
> > +             return EFI_UNSUPPORTED;
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> >   /**
> >    * try_load_entry() - try to load image for boot option
> >    *
> > @@ -211,6 +401,14 @@ static efi_status_t try_load_entry(u16 n, efi_handle_t *handle,
> >               if (EFI_DP_TYPE(lo.file_path, MEDIA_DEVICE, FILE_PATH)) {
> >                       /* file_path doesn't contain a device path */
> >                       ret = try_load_from_short_path(lo.file_path, handle);
> > +             } else if (EFI_DP_TYPE(lo.file_path, MESSAGING_DEVICE, MSG_URI)) {
> > +                     if (IS_ENABLED(CONFIG_EFI_HTTP_BOOT))
> > +                             ret = try_load_from_uri_path(
> > +                                     (struct efi_device_path_uri *)
> > +                                             lo.file_path,
> > +                                     lo.label, handle);
> > +                     else
> > +                             ret = EFI_LOAD_ERROR;
> >               } else {
> >                       file_path = expand_media_path(lo.file_path);
> >                       ret = EFI_CALL(efi_load_image(true, efi_root, file_path,
> > diff --git a/lib/efi_loader/efi_dt_fixup.c b/lib/efi_loader/efi_dt_fixup.c
> > index 838023c78f..edc515b9ff 100644
> > --- a/lib/efi_loader/efi_dt_fixup.c
> > +++ b/lib/efi_loader/efi_dt_fixup.c
> > @@ -22,7 +22,7 @@ const efi_guid_t efi_guid_dt_fixup_protocol = EFI_DT_FIXUP_PROTOCOL_GUID;
> >    * @nomap:  indicates that the memory range shall not be accessed by the
> >    *          UEFI payload
> >    */
> > -static void efi_reserve_memory(u64 addr, u64 size, bool nomap)
> > +void efi_reserve_memory(u64 addr, u64 size, bool nomap)
> >   {
> >       int type;
> >       efi_uintn_t ret;
>
