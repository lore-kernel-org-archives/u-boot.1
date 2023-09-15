Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031D6EE021A
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 04:15:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3D4286828;
	Fri, 15 Sep 2023 06:15:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cz/ljcP/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4843B86852; Fri, 15 Sep 2023 06:15:45 +0200 (CEST)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E960867C7
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 06:15:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-68fcb4dc8a9so1611176b3a.2
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 21:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694751340; x=1695356140; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qPsBCbGPxADQFHGGubus0vL72Q/ibTI9+fZYJtg7xNw=;
 b=cz/ljcP/tRhkgzGSLkQMSDlBgMe50do75/K+8oNfS/ff2xcO2enEpw8zZDCmX0AJUu
 /pB4RlcH+QzaTk3lKKwVI2ZbwpGIj6Dtsg6Zw0iXvX91Mxv1OJQQf2UvI0I3sP8q2NTl
 MQInFx5vCG6bkWOU0r/FOxmVD6QEliKwPmbIaDg5hMw8ugayh9HsH26pXu5wluiHAAyJ
 xjU8QEZ6lJNlRqEbcizx4qPj6IDoo4ohXSKJDuAhX1d+8DTOZ5+Qs5UFDb/3HM40M6Y4
 d1IeHeCzMBBIkncldff6rxrnXNRvn937mUsuBGTWVypKFp8RbHko6jNFaNsevG0hBlD0
 c/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694751340; x=1695356140;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qPsBCbGPxADQFHGGubus0vL72Q/ibTI9+fZYJtg7xNw=;
 b=afL2XRnxbcBASl7ixfXHuKgR8Y/OwQE77plnHOy43IZIPmXu8S8J7fDlYAl4M95/lx
 8gxPbflILjdEcOe5+jWxarNXhUtidHh0w7yHFaEINS4OKoNJVQe6FBK+KmdlE1TK92Dw
 nvHMG4X1QXuljiYb6kbJ4ijJvslXadyjgATJ8jY+FsshWQz/l7XLRxeUqrEQwly843A7
 NMmWuBCeUARyH35vX6tK3LMuNE2YgkW+uFvTRPJBjDw9+DkQ6u8vFpUGSyTfFYj6CLvG
 iQezST6gwZ7s9mHGXxdchvyVw7Og7COaGECRqjINpbxWwpRKXB6zCwt8qtfl9f0o6V6v
 5srQ==
X-Gm-Message-State: AOJu0YxKS1MCOsZWUmqz8SPbWX3BouKpG40GM0mYq2uaDNaKeUBSWrfM
 Z0csgYSZ+dUtnbmEsU/L7o75AHi65Rj0M4Od1AzBVQ==
X-Google-Smtp-Source: AGHT+IHSS7XLNA4SvUS2c2hnNmzhFmLtlaNkxfW+OWt/XAP/JaFl55q7zLG/Ik6j9Uw/kwDl3zjCLygGHOO4eUh+65s=
X-Received: by 2002:a05:6a21:3299:b0:159:f39a:54e1 with SMTP id
 yt25-20020a056a21329900b00159f39a54e1mr782139pzb.51.1694751340538; Thu, 14
 Sep 2023 21:15:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230901102542.609239-1-masahisa.kojima@linaro.org>
 <20230901102542.609239-5-masahisa.kojima@linaro.org> <ZQMRB9allzBqrFGX@hera>
In-Reply-To: <ZQMRB9allzBqrFGX@hera>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Fri, 15 Sep 2023 13:15:29 +0900
Message-ID: <CADQ0-X9mDQbRRatGsKuJNYUGVRC8K-N96HAHXuxpR_wMG=HHAA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] efi_loader: support boot from URI device path
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

On Thu, 14 Sept 2023 at 22:56, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Kojima-san
>
> On Fri, Sep 01, 2023 at 07:25:40PM +0900, Masahisa Kojima wrote:
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
> >  lib/efi_loader/efi_bootmgr.c | 197 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 197 insertions(+)
> >
> > diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> > index a40762c74c..0e8d2ca9d1 100644
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
> > @@ -168,6 +172,193 @@ out:
> >       return ret;
> >  }
> >
> > +#if (IS_ENABLED(CONFIG_BLKMAP) && IS_ENABLED(CONFIG_CMD_WGET) && IS_ENABLED(CONFIG_CMD_DNS))
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
> > +     efi_status_t ret;
> > +     efi_handle_t bm_handle;
> > +     struct efi_handler *handler;
> > +     struct efi_device_path *file_path;
> > +     struct efi_device_path *device_path;
> > +
> > +     if (dev_tag_get_ptr(dev, DM_TAG_EFI, (void **)&bm_handle)) {
> > +             log_warning("DM_TAG_EFI not found\n");
> > +             return EFI_INVALID_PARAMETER;
> > +     }
> > +
> > +     ret = efi_search_protocol(bm_handle,
> > +                               &efi_simple_file_system_protocol_guid, &handler);
> > +     if (ret != EFI_SUCCESS)
> > +             return ret;
> > +
> > +     ret = efi_search_protocol(bm_handle, &efi_guid_device_path, &handler);
> > +     if (ret != EFI_SUCCESS)
> > +             return ret;
> > +
> > +     ret = efi_protocol_open(handler, (void **)&device_path, efi_root, NULL,
> > +                             EFI_OPEN_PROTOCOL_GET_PROTOCOL);
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
>
> We need to decide what we want here.  There were recently some patches from
> Raymond [0] which piggybacked on your earlier eficonfig work.  I think the
> last patch of this series hasn't been merged due to a test failing, but we
> should fix it.
> That patch has a different approach.  Everytime a disk appears it will add
> a boot option if the default filepath is found and that's how we fixed the

efi_bootmgr_update_media_device_boot_option() automatically adds the
boot option if the device handle installed EFI_SIMPLE_FILE_SYSTEM_PROTOCOL,
but it does not check whether the default file path is found or not.
When the user selects the automatically created boot option,
expand_media_path()
is called and efibootmgr tries to boot with the default file.

> behaviour of efibootmgr to adhere to the EFI spec.  This patch is doing the
> opposite, trying to detect the BOOTAA64.EFI etc on the fly.  I think I
> prefer the approach you have here, but we should end up with one solution
> to solve both.

This HTTP Boot case is slightly different from the case where the user selects
the automatically added boot option.
In this case, user selects the URI device path boot option. The
efibootmgr downloads the
file, mount the image, and try to boot with the default file name on the fly.
When the patch[0] is merged, it is possible to boot the downloaded iso
image from the
automatically added "blkmap" boot option, but I think efibootmgr needs
to boot with
the URI device path user selected that this series does, not boot
from the "blkmap" boot option.

>
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
>
> Don't we have a better way to validate isos and efi apps instead of
> the extension?  The efi is checked against a valid PE/COFF image so I guess
> we'll really on the mount to fail for isos?

EDK2 reference implementation checks the file type with the following priority.
 1) "Content-Type" header in HTTP response message
 2) Filename Extensions
Documentation is here[1].

Since "Content-Type" is not available in the current U-Boot wget, file extension
is used to identify ISO images.

[1] https://github.com/tianocore/tianocore.github.io/wiki/HTTP-Boot#ram-disk-boot-from-http

Thanks,
Masahisa Kojima


>
> > +      * If the file is ".efi" and PE-COFF image, load the downloaded file.
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
> > +     } else if (!strncmp(&uridp->uri[uri_len - 4], ".efi", 4)) {
> > +             efi_handle_t mem_handle = NULL;
> > +             struct efi_device_path *file_path = NULL;
> > +
> > +             ret = efi_check_pe((void *)image_addr, image_size, NULL);
> > +             if (ret != EFI_SUCCESS) {
> > +                     log_err("Error: downloaded image is not a PE-COFF image\n");
> > +                     return EFI_INVALID_PARAMETER;
> > +             }
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
>
> [0] https://lore.kernel.org/u-boot/20230619212303.128288-1-raymond.mao@linaro.org/
>
> Thanks
> /Ilias
