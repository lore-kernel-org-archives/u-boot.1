Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE92E81810
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 03:01:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48F6486BA8;
	Tue, 26 Sep 2023 05:01:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="u2MzkTZJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A999186B91; Tue, 26 Sep 2023 05:01:32 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A54E08691E
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 05:01:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-27751ac0653so2392467a91.3
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 20:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695697288; x=1696302088; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m/PRhC+hO+4Z5xBKPFRNDwmleyQySo6UQRS2pe7Sxwk=;
 b=u2MzkTZJxszDV7NiXITwhOTFuiITgWGfxRmqHfy6h1e5PoCWB5HXdn2fJ6M4FhuS3a
 zD8ZvoJY8Pj4g55/xxyVgz7Lk5vCrHARaeo1nBof9QnnH1YNdqa2b5Omo9XaSNvOu/th
 Xrv0z+R0dAkxlEWf4/RMHpRGOs9olehDlXXAsSUI+XVZv6KLuLDFUE9WwQOWNKBsqxf1
 ObSdHhGij9itnola7mQZm9m2d7u4ETlw1cbiT74sBTW2LvJNsAwrtJNvSyIQY1clRgY0
 Bv6APxlopGy+ihE6Of0Lz/TOEVXKdYSmsojE4WRUkLT64mtApQvFx4/ZoxO4iSfx+In9
 orug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695697288; x=1696302088;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m/PRhC+hO+4Z5xBKPFRNDwmleyQySo6UQRS2pe7Sxwk=;
 b=TbzJ8EjzTp9MZeJx3sZaj/ahFvYO4I+GyupPq7k0BD6O0ukgR/lTd2DNPhdySNap0f
 XEkVVizzXIGwpURvFaf9OeiiyQKQ9Nj+6KTNF1+pFCzSzVQt9HUX5iKEYgV64GxK22Va
 SGz3XDTXkxPUgbqp9KowHxWdNyw+BWiQthmLZpJvhMji6phbuocuaqzx6cb4j9J7ECWH
 7ZcPAuYBWS2YzDNKJZVIhnRbDuCnV7asVg1iKNajlzFmFE/zRkzGbryjDU7jk7+UvpXv
 3if4kXQUEmiYkezZh/UPLB7ipMdt5QsthVNkV/h/uRna6PZnjnuQJ/xBpqhiYkmJq0Qh
 Da7g==
X-Gm-Message-State: AOJu0YwWSE0rHzVg7xFgWmkt51v/lqZnKaVxq/wxTzvjCob7Ec7Q8xb6
 W0UkMqi+spLtwBLUinTT6ZxH8Ysui81WYjv5eU1huw==
X-Google-Smtp-Source: AGHT+IEBfM68o4Bfoc652zDpC4WK5/ddGlnEEZt4/q+O1Zwc3w5/BAnYJAvzfRcUPuhBtE0HeOCer4bACGSDDtCTpNo=
X-Received: by 2002:a17:90a:73ce:b0:26b:6095:bc3f with SMTP id
 n14-20020a17090a73ce00b0026b6095bc3fmr5776446pjk.33.1695697287826; Mon, 25
 Sep 2023 20:01:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230922071119.1439482-1-masahisa.kojima@linaro.org>
 <20230922071119.1439482-5-masahisa.kojima@linaro.org> <ZRF/G1+qSllqoNYL@hera>
In-Reply-To: <ZRF/G1+qSllqoNYL@hera>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Tue, 26 Sep 2023 12:01:16 +0900
Message-ID: <CADQ0-X-H4uzJ61pOAbJjQC6uAwam0HL5EEMUPQupVqdx2Sg0iA@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] efi_loader: support boot from URI device path
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Takahiro Akashi <takahiro.akashi@linaro.org>
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

Hi Ilias,

On Mon, 25 Sept 2023 at 21:37, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Fri, Sep 22, 2023 at 04:11:15PM +0900, Masahisa Kojima wrote:
> > This supports to boot from the URI device path.
> > When user selects the URI device path, bootmgr downloads
> > the file using wget into the address specified by loadaddr
> > env variable.
> > If the file is .iso or .img file, mount the image with blkmap
> > then try to boot with the default file(e.g. EFI/BOOT/BOOTAA64.EFI).
> > If the file is .efi file, load and start the downloaded file.
> >
> > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> > ---
> >  lib/efi_loader/efi_bootmgr.c | 189 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 189 insertions(+)
> >
> > diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> > index a40762c74c..605be5041e 100644
> > --- a/lib/efi_loader/efi_bootmgr.c
> > +++ b/lib/efi_loader/efi_bootmgr.c
> > @@ -7,10 +7,14 @@
> >
> >  #define LOG_CATEGORY LOGC_EFI
> >
> > +#include <blk.h>
> > +#include <blkmap.h>
> >  #include <common.h>
> >  #include <charset.h>
> > +#include <dm.h>
> >  #include <log.h>
> >  #include <malloc.h>
> > +#include <net.h>
> >  #include <efi_default_filename.h>
> >  #include <efi_loader.h>
> >  #include <efi_variable.h>
> > @@ -168,6 +172,182 @@ out:
> >       return ret;
> >  }
> >
> > +/**
> > + * mount_image() - mount the image with blkmap
> > + *
> > + * @lo_label u16 label string of load option
> > + * @image_addr:      image address
> > + * @image_size       image size
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
> > + * try_load_default_file() - try to load the default file
> > + *
> > + * Search the device having EFI_SIMPLE_FILE_SYSTEM_PROTOCOL,
> > + * then try to load with the default boot file(e.g. EFI/BOOT/BOOTAA64.EFI).
> > + *
> > + * @dev                      pointer to the UCLASS_BLK or UCLASS_PARTITION udevice
> > + * @image_handle:    pointer to handle for newly installed image
> > + * Return:           status code
> > + */
> > +static efi_status_t try_load_default_file(struct udevice *dev,
> > +                                       efi_handle_t *image_handle)
> > +{
>
> Maybe I misunderstood you on the previous series.  Wasn't the plan to merge
> the patch that adds boot options automatically when a disk is scanned? This

Adding the boot option automatically when a disk is scanned was sent
separately[1] from this series
since this feature is the matter of the timing of automatic boot
option creation and not directly related
to EFI HTTP Boot.
I also included the fixes of the efi_secboot python test failure.
Sorry for confusing you.

[1] https://patchwork.ozlabs.org/project/uboot/patch/20230920084121.1248590-1-masahisa.kojima@linaro.org/

> code could only look for a boot option with '1234567' in its load options
> instead of rescanning all devices with the EFI_SIMPLE_FILE_SYSTEM_PROTOCO
> installed

Now we can scan and load the default file(EFI/BOOT/BOOTAA64.EFI) on the fly with
load_default_file_from_blk_dev() function.
The patch #8 of this series "efi_loader: create BlockIo device boot
option" create the boot option
for the block device excluding the logical partition,

>
> > +     efi_status_t ret;
> > +     efi_handle_t handle;
> > +     struct efi_handler *handler;
> > +     struct efi_device_path *file_path;
> > +     struct efi_device_path *device_path;
> > +
> > +     if (dev_tag_get_ptr(dev, DM_TAG_EFI, (void **)&handle)) {
> > +             log_warning("DM_TAG_EFI not found\n");
> > +             return EFI_INVALID_PARAMETER;
> > +     }
> > +
> > +     ret = efi_search_protocol(handle,
> > +                               &efi_simple_file_system_protocol_guid, &handler);
> > +     if (ret != EFI_SUCCESS)
> > +             return ret;
> > +
> > +     ret = EFI_CALL(bs->open_protocol(handle, &efi_guid_device_path,
> > +                                      (void **)&device_path, efi_root, NULL,
> > +                                      EFI_OPEN_PROTOCOL_GET_PROTOCOL));
> > +     if (ret != EFI_SUCCESS)
> > +             return ret;
> > +
> > +     file_path = expand_media_path(device_path);
> > +     ret = EFI_CALL(efi_load_image(true, efi_root, file_path, NULL, 0,
> > +                                   image_handle));
> > +
> > +     efi_free_pool(file_path);
> > +
> > +     return ret;
> > +}
> > +
> > +/**
> > + * load_default_file_from_blk_dev() - load the default file
> > + *
> > + * @blk              pointer to the UCLASS_BLK udevice
> > + * @handle:  pointer to handle for newly installed image
> > + * Return:   status code
> > + */
> > +static efi_status_t load_default_file_from_blk_dev(struct udevice *blk,
> > +                                                efi_handle_t *handle)
> > +{
> > +     efi_status_t ret;
> > +     struct udevice *partition;
> > +
> > +     /* image that has no partition table but a file system */
> > +     ret = try_load_default_file(blk, handle);
> > +     if (ret == EFI_SUCCESS)
> > +             return ret;
> > +
> > +     /* try the partitions */
> > +     device_foreach_child(partition, blk) {
> > +             enum uclass_id id;
> > +
> > +             id = device_get_uclass_id(partition);
> > +             if (id != UCLASS_PARTITION)
> > +                     continue;
> > +
> > +             ret = try_load_default_file(partition, handle);
> > +             if (ret == EFI_SUCCESS)
> > +                     return ret;
> > +     }
> > +
> > +     return EFI_NOT_FOUND;
> > +}
> > +
> > +/**
> > + * try_load_from_uri_path() - Handle the URI device path
> > + *
> > + * @uridp:   uri device path
> > + * @lo_label label of load option
> > + * @handle:  pointer to handle for newly installed image
> > + * Return:   status code
> > + */
> > +static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
> > +                                        u16 *lo_label,
> > +                                        efi_handle_t *handle)
> > +{
> > +     char *s;
> > +     int uri_len;
> > +     int image_size;
> > +     efi_status_t ret;
> > +     ulong image_addr;
> > +
> > +     s = env_get("loadaddr");
> > +     if (!s) {
> > +             log_err("Error: loadaddr is not set\n");
> > +             return EFI_INVALID_PARAMETER;
> > +     }
> > +     image_addr = hextoul(s, NULL);
> > +     image_size = wget_with_dns(image_addr, uridp->uri);
> > +     if (image_size < 0)
> > +             return EFI_INVALID_PARAMETER;
> > +
> > +     /*
> > +      * If the file extension is ".iso" or ".img", mount it and try to load
> > +      * the default file.
> > +      * If the file is PE-COFF image, load the downloaded file.
> > +      */
> > +     uri_len = strlen(uridp->uri); /* todo: directly use uridp->uri */
> > +     if (!strncmp(&uridp->uri[uri_len - 4], ".iso", 4) ||
> > +         !strncmp(&uridp->uri[uri_len - 4], ".img", 4)) {
> > +             struct udevice *blk;
> > +
> > +             blk = mount_image(lo_label, image_addr, image_size);
> > +             if (!blk)
> > +                     return EFI_INVALID_PARAMETER;
> > +
> > +             ret = load_default_file_from_blk_dev(blk, handle);
> > +     } else if (efi_check_pe((void *)image_addr, image_size, NULL) == EFI_SUCCESS) {
> > +             efi_handle_t mem_handle = NULL;
> > +             struct efi_device_path *file_path = NULL;
> > +
> > +             file_path = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
> > +                                         (uintptr_t)image_addr, image_size);
> > +             ret = efi_install_multiple_protocol_interfaces(
> > +                     &mem_handle, &efi_guid_device_path, file_path, NULL);
> > +             if (ret != EFI_SUCCESS)
> > +                     return EFI_INVALID_PARAMETER;
> > +
> > +             ret = EFI_CALL(efi_load_image(false, efi_root, file_path,
> > +                                           (void *)image_addr, image_size,
> > +                                           handle));
> > +     } else {
> > +             log_err("Error: file type is not supported\n");
> > +             return EFI_INVALID_PARAMETER;
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> >  /**
> >   * try_load_entry() - try to load image for boot option
> >   *
> > @@ -211,6 +391,15 @@ static efi_status_t try_load_entry(u16 n, efi_handle_t *handle,
> >               if (EFI_DP_TYPE(lo.file_path, MEDIA_DEVICE, FILE_PATH)) {
> >                       /* file_path doesn't contain a device path */
> >                       ret = try_load_from_short_path(lo.file_path, handle);
> > +             } else if (EFI_DP_TYPE(lo.file_path, MESSAGING_DEVICE, MSG_URI)) {
> > +                     if (IS_ENABLED(CONFIG_BLKMAP) &&
> > +                         IS_ENABLED(CONFIG_CMD_WGET) &&
> > +                         IS_ENABLED(CONFIG_CMD_DNS)) {
> > +                             ret = try_load_from_uri_path(
> > +                                     (struct efi_device_path_uri *)
> > +                                             lo.file_path,
> > +                                     lo.label, handle);
> > +                     }
>
> is ret initialized in this function?  Otherwise we need to initialize it if
> one of the Kconfig options are disabled

Thank you, I will add an 'else' statement to set the error here.

Thanks,
Masahisa Kojima

>
> >               } else {
> >                       file_path = expand_media_path(lo.file_path);
> >                       ret = EFI_CALL(efi_load_image(true, efi_root, file_path,
> > --
> > 2.34.1
> >
>
> Thanks
> /Ilias
