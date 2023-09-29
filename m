Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14965E743F1
	for <u-boot@archiver.kernel.org>; Fri, 29 Sep 2023 07:43:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2968286E8F;
	Fri, 29 Sep 2023 09:43:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cyqKJTQB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF19F86E76; Fri, 29 Sep 2023 09:43:52 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC5BE86E51
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 09:43:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9ad8a822508so1843233766b.0
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 00:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695973429; x=1696578229; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V37Fr2ZHkuCsXmpiV3tgluaeElG+R1/o9hAzHzcttPg=;
 b=cyqKJTQBZG3rgUU2BpuXUHY05yWtSW5tD7sm75U2GRIZflSroNaHWkgsSaDnKDRHmU
 rIQwdl9R8RbDrlgSN9YQ1T9QKwQ+8ETPAPJgdp4UXIDqgi4lyMxbZZzv56S1yL2Ah3ih
 XVRH2dvuXQbekysdfLGt6K1F3/QAOVbCHoZwUVTwVfrf17MHwxdE66CYnm1wgR6Ooi/+
 AMhqzeJRyfsoAig0HYFF99Wr/i0na6l0CFsSVHOM0zaQUbNFnkUpIzL6eEo5OcIlqVRG
 H0o87sy3zXWB8b68uICfKDjIZb5uxl5G+jsbLYGorNDDEd66I85e/UyPz/HrhEnutfXn
 1YLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695973429; x=1696578229;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V37Fr2ZHkuCsXmpiV3tgluaeElG+R1/o9hAzHzcttPg=;
 b=VahgtXYtkSVfkYZpueAxqAaFwMA/YyturVM8SQl0axpZ/IwMlD4FrT7rlY2tGySbiB
 f6RILssHSWUW38L8rzC7x0G0s5c3BIQUp+Ls7JBojjtVupTzeZ+Pd3ZBYjVB29UFP7yY
 IHgrmlH7km2OB6ZcZqAkY8uXhwuQmBCiLVL0pDNmfoF+HvP+g0DBNmZHCf91sPfImb4x
 lGVh/K+Xd8ZsqfMEknu4QhDrXT6JrIy9hdPnQQFMu9J6EwQxHGqBmvPEmvj51lDiAHXl
 7tRN/ye32yys0Iwa8RmTxk6aKKNi1zOxh0wsQmVyH+K9lgHCfi6ONUCUjLedo9Wqffa0
 fbzw==
X-Gm-Message-State: AOJu0YxgaYzrqfkr5KrIvd/wc/ggTAf+EX4yEhwpv5XPmNWayhNySt7S
 +Qesu+GHlOJs/+qfKTYXHk9foofaxOHKqtZW1TX3Ow==
X-Google-Smtp-Source: AGHT+IEwC2X4P1IfHkaibRZ1S52e86LDc3hN68P8s+uS/nRTSxQMpTo/EXUjyVZGHjUJl9NMJ+m+3MTh/MECFH209k8=
X-Received: by 2002:a17:906:73d4:b0:9ae:6744:4591 with SMTP id
 n20-20020a17090673d400b009ae67444591mr2952570ejl.43.1695973429193; Fri, 29
 Sep 2023 00:43:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230922071119.1439482-1-masahisa.kojima@linaro.org>
 <20230922071119.1439482-5-masahisa.kojima@linaro.org> <ZRF/G1+qSllqoNYL@hera>
 <CADQ0-X-H4uzJ61pOAbJjQC6uAwam0HL5EEMUPQupVqdx2Sg0iA@mail.gmail.com>
 <CAD8XO3Y2uXcJOD+cAesNM2FBKgm7=Q+qHAY8RALCttGgKUa+Yw@mail.gmail.com>
 <CADQ0-X84_S8Cg7EFQ6S4gnBnUizzCE4Q5-62pBhpP4vkV0WpNQ@mail.gmail.com>
 <CAD8XO3Ybo6SXbNHdj1H6DVOv=-BxOd8DOwMbQf+ZKD4D+gnB9A@mail.gmail.com>
 <CADQ0-X9Ky13YpXwgfPP0=K62SV3tgnMc7Cz6+S1n4j0VApjOLw@mail.gmail.com>
In-Reply-To: <CADQ0-X9Ky13YpXwgfPP0=K62SV3tgnMc7Cz6+S1n4j0VApjOLw@mail.gmail.com>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Fri, 29 Sep 2023 13:43:37 +0600
Message-ID: <CAD8XO3azgpxb6C3rmZV3MHjMV8KQ=bdXm9fQFYcvE14D=V8uzQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] efi_loader: support boot from URI device path
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Takahiro Akashi <takahiro.akashi@linaro.org>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 29 Sept 2023 at 13:00, Masahisa Kojima <masahisa.kojima@linaro.org>
wrote:

> Hi Maxim,
>
> On Fri, 29 Sept 2023 at 15:24, Maxim Uvarov <maxim.uvarov@linaro.org>
> wrote:
> >
> >
> >
> > On Fri, 29 Sept 2023 at 08:13, Masahisa Kojima <
> masahisa.kojima@linaro.org> wrote:
> >>
> >> Hi Maxim,
> >>
> >> On Thu, 28 Sept 2023 at 20:35, Maxim Uvarov <maxim.uvarov@linaro.org>
> wrote:
> >> >
> >> >
> >> >
> >> > On Tue, 26 Sept 2023 at 09:01, Masahisa Kojima <
> masahisa.kojima@linaro.org> wrote:
> >> >>
> >> >> Hi Ilias,
> >> >>
> >> >> On Mon, 25 Sept 2023 at 21:37, Ilias Apalodimas
> >> >> <ilias.apalodimas@linaro.org> wrote:
> >> >> >
> >> >> > On Fri, Sep 22, 2023 at 04:11:15PM +0900, Masahisa Kojima wrote:
> >> >> > > This supports to boot from the URI device path.
> >> >> > > When user selects the URI device path, bootmgr downloads
> >> >> > > the file using wget into the address specified by loadaddr
> >> >> > > env variable.
> >> >> > > If the file is .iso or .img file, mount the image with blkmap
> >> >> > > then try to boot with the default file(e.g.
> EFI/BOOT/BOOTAA64.EFI).
> >> >> > > If the file is .efi file, load and start the downloaded file.
> >> >> > >
> >> >> > > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> >> >> > > ---
> >> >> > >  lib/efi_loader/efi_bootmgr.c | 189
> +++++++++++++++++++++++++++++++++++
> >> >> > >  1 file changed, 189 insertions(+)
> >> >> > >
> >> >> > > diff --git a/lib/efi_loader/efi_bootmgr.c
> b/lib/efi_loader/efi_bootmgr.c
> >> >> > > index a40762c74c..605be5041e 100644
> >> >> > > --- a/lib/efi_loader/efi_bootmgr.c
> >> >> > > +++ b/lib/efi_loader/efi_bootmgr.c
> >> >> > > @@ -7,10 +7,14 @@
> >> >> > >
> >> >> > >  #define LOG_CATEGORY LOGC_EFI
> >> >> > >
> >> >> > > +#include <blk.h>
> >> >> > > +#include <blkmap.h>
> >> >> > >  #include <common.h>
> >> >> > >  #include <charset.h>
> >> >> > > +#include <dm.h>
> >> >> > >  #include <log.h>
> >> >> > >  #include <malloc.h>
> >> >> > > +#include <net.h>
> >> >> > >  #include <efi_default_filename.h>
> >> >> > >  #include <efi_loader.h>
> >> >> > >  #include <efi_variable.h>
> >> >> > > @@ -168,6 +172,182 @@ out:
> >> >> > >       return ret;
> >> >> > >  }
> >> >> > >
> >> >> > > +/**
> >> >> > > + * mount_image() - mount the image with blkmap
> >> >> > > + *
> >> >> > > + * @lo_label u16 label string of load option
> >> >> > > + * @image_addr:      image address
> >> >> > > + * @image_size       image size
> >> >> > > + * Return:   pointer to the UCLASS_BLK udevice, NULL if failed
> >> >> > > + */
> >> >> > > +static struct udevice *mount_image(u16 *lo_label, ulong
> image_addr, int image_size)
> >> >> > > +{
> >> >> > > +     int err;
> >> >> > > +     struct blkmap *bm;
> >> >> > > +     struct udevice *bm_dev;
> >> >> > > +     char *label = NULL, *p;
> >> >> > > +
> >> >> > > +     label = efi_alloc(utf16_utf8_strlen(lo_label) + 1);
> >> >> > > +     if (!label)
> >> >> > > +             return NULL;
> >> >> > > +
> >> >> > > +     p = label;
> >> >> > > +     utf16_utf8_strcpy(&p, lo_label);
> >> >> > > +     err = blkmap_create_ramdisk(label, image_addr, image_size,
> &bm_dev);
> >> >> > > +     if (err) {
> >> >> > > +             efi_free_pool(label);
> >> >> > > +             return NULL;
> >> >> > > +     }
> >> >> > > +     bm = dev_get_plat(bm_dev);
> >> >> > > +
> >> >> > > +     efi_free_pool(label);
> >> >> > > +
> >> >> > > +     return bm->blk;
> >> >> > > +}
> >> >> > > +
> >> >> > > +/**
> >> >> > > + * try_load_default_file() - try to load the default file
> >> >> > > + *
> >> >> > > + * Search the device having EFI_SIMPLE_FILE_SYSTEM_PROTOCOL,
> >> >> > > + * then try to load with the default boot file(e.g.
> EFI/BOOT/BOOTAA64.EFI).
> >> >> > > + *
> >> >> > > + * @dev                      pointer to the UCLASS_BLK or
> UCLASS_PARTITION udevice
> >> >> > > + * @image_handle:    pointer to handle for newly installed image
> >> >> > > + * Return:           status code
> >> >> > > + */
> >> >> > > +static efi_status_t try_load_default_file(struct udevice *dev,
> >> >> > > +                                       efi_handle_t
> *image_handle)
> >> >> > > +{
> >> >> >
> >> >> > Maybe I misunderstood you on the previous series.  Wasn't the plan
> to merge
> >> >> > the patch that adds boot options automatically when a disk is
> scanned? This
> >> >>
> >> >> Adding the boot option automatically when a disk is scanned was sent
> >> >> separately[1] from this series
> >> >> since this feature is the matter of the timing of automatic boot
> >> >> option creation and not directly related
> >> >> to EFI HTTP Boot.
> >> >> I also included the fixes of the efi_secboot python test failure.
> >> >> Sorry for confusing you.
> >> >>
> >> >> [1]
> https://patchwork.ozlabs.org/project/uboot/patch/20230920084121.1248590-1-masahisa.kojima@linaro.org/
> >> >>
> >> >> > code could only look for a boot option with '1234567' in its load
> options
> >> >> > instead of rescanning all devices with the
> EFI_SIMPLE_FILE_SYSTEM_PROTOCO
> >> >> > installed
> >> >>
> >> >> Now we can scan and load the default file(EFI/BOOT/BOOTAA64.EFI) on
> the fly with
> >> >> load_default_file_from_blk_dev() function.
> >> >> The patch #8 of this series "efi_loader: create BlockIo device boot
> >> >> option" create the boot option
> >> >> for the block device excluding the logical partition,
> >> >>
> >> >> >
> >> >> > > +     efi_status_t ret;
> >> >> > > +     efi_handle_t handle;
> >> >> > > +     struct efi_handler *handler;
> >> >> > > +     struct efi_device_path *file_path;
> >> >> > > +     struct efi_device_path *device_path;
> >> >> > > +
> >> >> > > +     if (dev_tag_get_ptr(dev, DM_TAG_EFI, (void **)&handle)) {
> >> >> > > +             log_warning("DM_TAG_EFI not found\n");
> >> >> > > +             return EFI_INVALID_PARAMETER;
> >> >> > > +     }
> >> >> > > +
> >> >> > > +     ret = efi_search_protocol(handle,
> >> >> > > +
>  &efi_simple_file_system_protocol_guid, &handler);
> >> >> > > +     if (ret != EFI_SUCCESS)
> >> >> > > +             return ret;
> >> >> > > +
> >> >> > > +     ret = EFI_CALL(bs->open_protocol(handle,
> &efi_guid_device_path,
> >> >> > > +                                      (void **)&device_path,
> efi_root, NULL,
> >> >> > > +
> EFI_OPEN_PROTOCOL_GET_PROTOCOL));
> >> >> > > +     if (ret != EFI_SUCCESS)
> >> >> > > +             return ret;
> >> >> > > +
> >> >> > > +     file_path = expand_media_path(device_path);
> >> >> > > +     ret = EFI_CALL(efi_load_image(true, efi_root, file_path,
> NULL, 0,
> >> >> > > +                                   image_handle));
> >> >> > > +
> >> >> > > +     efi_free_pool(file_path);
> >> >> > > +
> >> >> > > +     return ret;
> >> >> > > +}
> >> >> > > +
> >> >> > > +/**
> >> >> > > + * load_default_file_from_blk_dev() - load the default file
> >> >> > > + *
> >> >> > > + * @blk              pointer to the UCLASS_BLK udevice
> >> >> > > + * @handle:  pointer to handle for newly installed image
> >> >> > > + * Return:   status code
> >> >> > > + */
> >> >> > > +static efi_status_t load_default_file_from_blk_dev(struct
> udevice *blk,
> >> >> > > +                                                efi_handle_t
> *handle)
> >> >> > > +{
> >> >> > > +     efi_status_t ret;
> >> >> > > +     struct udevice *partition;
> >> >> > > +
> >> >> > > +     /* image that has no partition table but a file system */
> >> >> > > +     ret = try_load_default_file(blk, handle);
> >> >> > > +     if (ret == EFI_SUCCESS)
> >> >> > > +             return ret;
> >> >> > > +
> >> >> > > +     /* try the partitions */
> >> >> > > +     device_foreach_child(partition, blk) {
> >> >> > > +             enum uclass_id id;
> >> >> > > +
> >> >> > > +             id = device_get_uclass_id(partition);
> >> >> > > +             if (id != UCLASS_PARTITION)
> >> >> > > +                     continue;
> >> >> > > +
> >> >> > > +             ret = try_load_default_file(partition, handle);
> >> >> > > +             if (ret == EFI_SUCCESS)
> >> >> > > +                     return ret;
> >> >> > > +     }
> >> >> > > +
> >> >> > > +     return EFI_NOT_FOUND;
> >> >> > > +}
> >> >> > > +
> >> >> > > +/**
> >> >> > > + * try_load_from_uri_path() - Handle the URI device path
> >> >> > > + *
> >> >> > > + * @uridp:   uri device path
> >> >> > > + * @lo_label label of load option
> >> >> > > + * @handle:  pointer to handle for newly installed image
> >> >> > > + * Return:   status code
> >> >> > > + */
> >> >> > > +static efi_status_t try_load_from_uri_path(struct
> efi_device_path_uri *uridp,
> >> >> > > +                                        u16 *lo_label,
> >> >> > > +                                        efi_handle_t *handle)
> >> >
> >> >
> >> > Maybe this comment is not related to this current commit, but on
> loading http file we do not set maximum size to download. I.e. if the image
> will be too big it will cause segfault I think.
> >>
> >> The patch #1(net: wget: prevent overwriting reserved memory) checks
> valid memory
> >> during wget transfers on the fly, so at least segfault will not occur.
> >> The same checking with LMB is done in TFTP of current U-Boot code.
> >> Anyway, I guess we may need some rework of this valid memory check for
> >> lwip variant.
> >>
> >> >
> >> >>
> >> >> > > +{
> >> >> > > +     char *s;
> >> >> > > +     int uri_len;
> >> >> > > +     int image_size;
> >> >> > > +     efi_status_t ret;
> >> >> > > +     ulong image_addr;
> >> >> > > +
> >> >> > > +     s = env_get("loadaddr");
> >> >> > > +     if (!s) {
> >> >> > > +             log_err("Error: loadaddr is not set\n");
> >> >> > > +             return EFI_INVALID_PARAMETER;
> >> >> > > +     }
> >> >> > > +     image_addr = hextoul(s, NULL);
> >> >> > > +     image_size = wget_with_dns(image_addr, uridp->uri);
> >> >> > > +     if (image_size < 0)
> >> >> > > +             return EFI_INVALID_PARAMETER;
> >> >
> >> >
> >> > maybe something like env_get_hex("filesize", 0); here?
> >> > Size is potentially limited with half of int type here.
> >>
> >> Yes, env_get_hex("filesize", 0); is proper here. Thank you.
> >>
> >> >
> >> >>
> >> >> > > +
> >> >> > > +     /*
> >> >> > > +      * If the file extension is ".iso" or ".img", mount it and
> try to load
> >> >> > > +      * the default file.
> >> >> > > +      * If the file is PE-COFF image, load the downloaded file.
> >> >> > > +      */
> >> >> > > +     uri_len = strlen(uridp->uri); /* todo: directly use
> uridp->uri */
> >> >> > > +     if (!strncmp(&uridp->uri[uri_len - 4], ".iso", 4) ||
> >> >> > > +         !strncmp(&uridp->uri[uri_len - 4], ".img", 4)) {
> >> >
> >> >
> >> > Is it possible to check magic numbers rather than naming?
> >> > I see that at least .iso has one:
> >> > https://en.wikipedia.org/wiki/List_of_file_signatures
> >>
> >> I' not sure how the file signature is common for iso images.
> >> I checked some fedora, suse, debian installer iso images
> >> but these do not have signature at the beginning of files.
> >>
> >> >
> >> >>
> >> >> > > +             struct udevice *blk;
> >> >> > > +
> >> >> > > +             blk = mount_image(lo_label, image_addr,
> image_size);
> >> >> > > +             if (!blk)
> >> >> > > +                     return EFI_INVALID_PARAMETER;
> >> >> > > +
> >> >> > > +             ret = load_default_file_from_blk_dev(blk, handle);
> >> >> > > +     } else if (efi_check_pe((void *)image_addr, image_size,
> NULL) == EFI_SUCCESS) {
> >> >> > > +             efi_handle_t mem_handle = NULL;
> >> >> > > +             struct efi_device_path *file_path = NULL;
> >> >
> >> >
> >> > no need to set file_path to NULL
> >> OK.
> >>
> >> >>
> >> >> > > +
> >> >> > > +             file_path =
> efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
> >> >> > > +                                         (uintptr_t)image_addr,
> image_size);
> >> >> > > +             ret = efi_install_multiple_protocol_interfaces(
> >> >> > > +                     &mem_handle, &efi_guid_device_path,
> file_path, NULL);
> >> >> > > +             if (ret != EFI_SUCCESS)
> >> >> > > +                     return EFI_INVALID_PARAMETER;
> >> >> > > +
> >> >> > > +             ret = EFI_CALL(efi_load_image(false, efi_root,
> file_path,
> >> >> > > +                                           (void *)image_addr,
> image_size,
> >> >> > > +                                           handle));
> >> >> > > +     } else {
> >> >> > > +             log_err("Error: file type is not supported\n");
> >> >> > > +             return EFI_INVALID_PARAMETER;
> >> >
> >> > EFI_UNSUPPORTED or EFI_NO_MEDIA looks more suitable here.
> >> I will change it to EFI_UNSUPPORTED.
> >>
> >> >
> >> >>
> >> >> > > +     }
> >> >> > > +
> >> >> > > +     return ret;
> >> >> > > +}
> >> >> > > +
> >> >> > >  /**
> >> >> > >   * try_load_entry() - try to load image for boot option
> >> >> > >   *
> >> >> > > @@ -211,6 +391,15 @@ static efi_status_t try_load_entry(u16 n,
> efi_handle_t *handle,
> >> >> > >               if (EFI_DP_TYPE(lo.file_path, MEDIA_DEVICE,
> FILE_PATH)) {
> >> >> > >                       /* file_path doesn't contain a device path
> */
> >> >> > >                       ret =
> try_load_from_short_path(lo.file_path, handle);
> >> >> > > +             } else if (EFI_DP_TYPE(lo.file_path,
> MESSAGING_DEVICE, MSG_URI)) {
> >> >> > > +                     if (IS_ENABLED(CONFIG_BLKMAP) &&
> >> >> > > +                         IS_ENABLED(CONFIG_CMD_WGET) &&
> >> >> > > +                         IS_ENABLED(CONFIG_CMD_DNS)) {
> >> >
> >> >
> >> > This looks like too many Kconfig options. Maybe there is a way to
> make some function empty and let LTO do size optimization.
> >>
> >> Sorry, I'm not familiar with LTO, could you give some ideas of
> modification?
> >>
> >
> > LTO is link time optimization. Idea is that if linker understands that
> there is no direct reference for some compiled code it will get rid of it
> in the final binary.
> > In my opinion here if EFI is enabled then CONFIG_BLKMAP,
> CONFIG_CMD_WGET, CONFIG_CMD_DNS has to be also enabled. Or we will have one
> more configuration
> > variant and more likely there will be no users for that optimization.
> It might be make sense to use IS_ENABLED(CONFIG_NET) to enable and disable
> all networking
> > for the EFI. I think if you disable CONFIG_NET then LTO should optimize
> the final binary even if you have all this EFI code, because there will be
> no net rx/tx function for that.
>
> Probably everyone has a different opinion here, I would like to narrow
> down to the EFI HTTP Boot.
> I will create a new Kconfig option CONFIG_EFI_HTTP_BOOT,
> it depends on CONFIG_BLKMAP, CONFIG_CMD_WGET, CONFIG_CMD_DNS.
> efibootmgr only checks if CONFIG_EFI_HTTP_BOOT is enabled.
>
>
I think that will work for now, letter I think CONFIG_CMD_X also can go
away for this case. I mean depend on cmd commands, then functionality.


> Thanks,
> Masahisa Kojima
>
> >
> > BR,
> > Maxim.
> >
> >> Regards,
> >> Masahisa Kojima
> >>
> >>
> >> >
> >> >>
> >> >> > > +                             ret = try_load_from_uri_path(
> >> >> > > +                                     (struct
> efi_device_path_uri *)
> >> >> > > +                                             lo.file_path,
> >> >> > > +                                     lo.label, handle);
> >> >> > > +                     }
> >> >> >
> >> >> > is ret initialized in this function?  Otherwise we need to
> initialize it if
> >> >> > one of the Kconfig options are disabled
> >> >>
> >> >> Thank you, I will add an 'else' statement to set the error here.
> >> >>
> >> >> Thanks,
> >> >> Masahisa Kojima
> >> >>
> >> >> >
> >> >> > >               } else {
> >> >> > >                       file_path =
> expand_media_path(lo.file_path);
> >> >> > >                       ret = EFI_CALL(efi_load_image(true,
> efi_root, file_path,
> >> >> > > --
> >> >> > > 2.34.1
> >> >> > >
> >> >> >
> >> >> > Thanks
> >> >> > /Ilias
>
