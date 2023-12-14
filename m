Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA55C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 01:55:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD5D687995;
	Thu, 14 Dec 2023 02:55:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kssJJsQW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 654EA87995; Thu, 14 Dec 2023 02:55:42 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84DD487990
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 02:55:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5522ba3f94aso1368625a12.1
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 17:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702518939; x=1703123739; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zhZ0HSKlB5ID/cNeANceXjDlwiMCEV0TTdIfqEWH0UI=;
 b=kssJJsQWgc0NUFo+Ywu+DCpkV4R02ujIQWlukwy+8ry1V0UreqanVAFq0p4jHXL7d2
 bshBqvi/UbkfDdbWodRBMC9bAvWJpIFQTzMX1JfRGa2BFueg6tgr/oHClX555NfnJSpt
 CtywTNkDcijKsdkQcCtLTUW5g/2MARvjVrUKR0wmlKxJPFoqJbirspSR6p/EF84UgSS5
 N7xEWzESqC4KNByCSIAh+5C30oboOrR8oydess0zea6qZQ8fq07ryfCSq1bmRlxsYBK3
 HH3noUEI07eeVJJHozZEvlZbJK3evNZY9dkd2YDpdtKDlsYGJkpSJQOZtvSLNgaEbVlm
 ZWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702518939; x=1703123739;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zhZ0HSKlB5ID/cNeANceXjDlwiMCEV0TTdIfqEWH0UI=;
 b=LPui17GOXbxySYF4VGPWonwqAyYs8oMp5eYGhxu2xmsPz3AFcgLJta9+8NtUfZxvtG
 cU4UXIaSLSwlkD+E4cMCr745uSqEoVicIwK3+O9E2mCDIrHU7S9RrdKps0Bod62VVU5/
 j4Fs18n4uxVJX3OY9qegrfkgLcSDXMOvLl3LnMdYkPT+MYOZ9cuiHJA9k6yct1YPJicN
 oUEFz8SFTc/BpS57Z4PN0Bh6fwPBuGytLBPo0ZTvglRkEmpQZWxSGFsP6lpc6se3njsD
 EdfIjYZyZ/ogOagv1m6Q1R3nLvSItCbEoAbf9w4t/dAtxnIoXW5IEpkmtneX5ucG/P3M
 XpHg==
X-Gm-Message-State: AOJu0YyNl08tPgKeSNFf/W5S2t6IdAkemJGKhfZ4algNKFp7tqPneV66
 AOc3K02cy44+gFHl7HoBjLm3SwvJujJ+94utf6jgViLyZ7YyZ58O5TY=
X-Google-Smtp-Source: AGHT+IGxgG10rncJnuj+A2SKXw+Vxk9xRl/vpAbFhGrIG5uraQ6m9950zcT27MwyvLoORBdW0IJFBsdTYXPFU3DjvFE=
X-Received: by 2002:a05:6402:2316:b0:552:2d50:581e with SMTP id
 l22-20020a056402231600b005522d50581emr392880eda.171.1702518938820; Wed, 13
 Dec 2023 17:55:38 -0800 (PST)
MIME-Version: 1.0
References: <20231213085737.299773-1-masahisa.kojima@linaro.org>
 <dcc6a681-2ede-49ba-ad0d-069933ad32ca@gmx.de>
In-Reply-To: <dcc6a681-2ede-49ba-ad0d-069933ad32ca@gmx.de>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Thu, 14 Dec 2023 10:55:27 +0900
Message-ID: <CADQ0-X9cBm4uVyMXNVL++exgoHkgB3RGAH=cPjtPO5JKh+CgHA@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: eliminate efi_disk_obj structure
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

On Wed, 13 Dec 2023 at 23:22, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 13.12.23 09:57, Masahisa Kojima wrote:
> > Current code uses struct efi_disk_obj to keep information
> > about block devices and partitions. As the efi handle already
> > has a field with the udevice, we should eliminate
> > struct efi_disk_obj and use an pointer to struct efi_object
> > for the handle.
> >
> > efi_link_dev() call is moved inside of efi_disk_add_dev() function
> > to simplify the cleanup process in case of error.
>
> I agree that using struct efi_disk_obj as a container for protocols of a
> block IO device is a bit messy.
>
> But we should keep looking up the handle easy. Currently we use
>
> diskobj = container_of(this, struct efi_disk_obj, ops);
>
> Instead we could append a private field with the handle to the
> EFI_BLOCK_IO_PROTOCOL structure.
>
> >
> > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> > ---
> >   lib/efi_loader/efi_disk.c | 209 +++++++++++++++++++++-----------------
> >   1 file changed, 116 insertions(+), 93 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> > index f0d76113b0..cfb7ace551 100644
> > --- a/lib/efi_loader/efi_disk.c
> > +++ b/lib/efi_loader/efi_disk.c
> > @@ -27,27 +27,24 @@ struct efi_system_partition efi_system_partition = {
> >   const efi_guid_t efi_block_io_guid = EFI_BLOCK_IO_PROTOCOL_GUID;
> >   const efi_guid_t efi_system_partition_guid = PARTITION_SYSTEM_GUID;
> >
> > -/**
> > - * struct efi_disk_obj - EFI disk object
> > - *
> > - * @header:  EFI object header
> > - * @ops:     EFI disk I/O protocol interface
> > - * @dev_index:       device index of block device
> > - * @media:   block I/O media information
> > - * @dp:              device path to the block device
> > - * @part:    partition
> > - * @volume:  simple file system protocol of the partition
> > - * @dev:     associated DM device
> > - */
> > -struct efi_disk_obj {
> > -     struct efi_object header;
> > -     struct efi_block_io ops;
> > -     int dev_index;
> > -     struct efi_block_io_media media;
> > -     struct efi_device_path *dp;
> > -     unsigned int part;
> > -     struct efi_simple_file_system_protocol *volume;
> > -};
> > +static efi_handle_t efi_blkio_find_obj(struct efi_block_io *blkio)
> > +{
> > +     efi_handle_t handle;
> > +
> > +     list_for_each_entry(handle, &efi_obj_list, link) {
> > +             efi_status_t ret;
> > +             struct efi_handler *handler;
> > +
> > +             ret = efi_search_protocol(handle, &efi_block_io_guid, &handler);
> > +             if (ret != EFI_SUCCESS)
> > +                     continue;
> > +
> > +             if (blkio == handler->protocol_interface)
> > +                     return handle;
> > +     }
>
> Depending on the number of handles and pointers this will take a
> considerable time. A private field for the handle appended to struct
> efi_block_io would allow a fast lookup.
>
> EDK II does the same. See the definition of RAM_DISK_PRIVATE_FROM_BLKIO
> which uses macro BASE_CR() to find the private fields.

This patch tries to address this issue[0].

If I understand correctly, two options are suggested here.
 1) a private field for the handle appended to struct efi_block_io
 2) keep the private struct something like current struct
efi_disk_obj, same as EDK II does

struct efi_block_io is defined in UEFI spec, so probably option#2 is preferable
and it is almost the same as the current implementation.
I think we can proceed with the minor cleanup of struct efi_disk_obj
as Akashi-san suggested.

[0] https://source.denx.de/u-boot/custodians/u-boot-efi/-/issues/9

Thanks,
Masahisa Kojima

>
> Best regards
>
> Heinrich
>
> > +
> > +     return NULL;
> > +}
> >
> >   /**
> >    * efi_disk_reset() - reset block device
> > @@ -107,13 +104,16 @@ static efi_status_t efi_disk_rw_blocks(struct efi_block_io *this,
> >                       u32 media_id, u64 lba, unsigned long buffer_size,
> >                       void *buffer, enum efi_disk_direction direction)
> >   {
> > -     struct efi_disk_obj *diskobj;
> > +     efi_handle_t handle;
> >       int blksz;
> >       int blocks;
> >       unsigned long n;
> >
> > -     diskobj = container_of(this, struct efi_disk_obj, ops);
> > -     blksz = diskobj->media.block_size;
> > +     handle = efi_blkio_find_obj(this);
> > +     if (!handle)
> > +             return EFI_INVALID_PARAMETER;
> > +
> > +     blksz = this->media->block_size;
> >       blocks = buffer_size / blksz;
> >
> >       EFI_PRINT("blocks=%x lba=%llx blksz=%x dir=%d\n",
> > @@ -124,18 +124,16 @@ static efi_status_t efi_disk_rw_blocks(struct efi_block_io *this,
> >               return EFI_BAD_BUFFER_SIZE;
> >
> >       if (CONFIG_IS_ENABLED(PARTITIONS) &&
> > -         device_get_uclass_id(diskobj->header.dev) == UCLASS_PARTITION) {
> > +         device_get_uclass_id(handle->dev) == UCLASS_PARTITION) {
> >               if (direction == EFI_DISK_READ)
> > -                     n = disk_blk_read(diskobj->header.dev, lba, blocks,
> > -                                       buffer);
> > +                     n = disk_blk_read(handle->dev, lba, blocks, buffer);
> >               else
> > -                     n = disk_blk_write(diskobj->header.dev, lba, blocks,
> > -                                        buffer);
> > +                     n = disk_blk_write(handle->dev, lba, blocks, buffer);
> >       } else {
> >               /* dev is a block device (UCLASS_BLK) */
> >               struct blk_desc *desc;
> >
> > -             desc = dev_get_uclass_plat(diskobj->header.dev);
> > +             desc = dev_get_uclass_plat(handle->dev);
> >               if (direction == EFI_DISK_READ)
> >                       n = blk_dread(desc, lba, blocks, buffer);
> >               else
> > @@ -388,6 +386,7 @@ static int efi_fs_exists(struct blk_desc *desc, int part)
> >    * @part:           partition
> >    * @disk:           pointer to receive the created handle
> >    * @agent_handle:   handle of the EFI block driver
> > + * @dev:             pointer to udevice
> >    * Return:          disk object
> >    */
> >   static efi_status_t efi_disk_add_dev(
> > @@ -397,24 +396,33 @@ static efi_status_t efi_disk_add_dev(
> >                               int dev_index,
> >                               struct disk_partition *part_info,
> >                               unsigned int part,
> > -                             struct efi_disk_obj **disk,
> > -                             efi_handle_t agent_handle)
> > +                             efi_handle_t *disk,
> > +                             efi_handle_t agent_handle,
> > +                             struct udevice *dev)
> >   {
> > -     struct efi_disk_obj *diskobj;
> > -     struct efi_object *handle;
> > +     efi_handle_t handle;
> >       const efi_guid_t *esp_guid = NULL;
> >       efi_status_t ret;
> > +     struct efi_block_io *blkio;
> > +     struct efi_block_io_media *media;
> > +     struct efi_device_path *dp = NULL;
> > +     struct efi_simple_file_system_protocol *volume = NULL;
> >
> >       /* Don't add empty devices */
> >       if (!desc->lba)
> >               return EFI_NOT_READY;
> >
> > -     diskobj = calloc(1, sizeof(*diskobj));
> > -     if (!diskobj)
> > +     ret = efi_create_handle(&handle);
> > +     if (ret != EFI_SUCCESS)
> > +             return ret;
> > +
> > +     blkio = calloc(1, sizeof(*blkio));
> > +     media = calloc(1, sizeof(*media));
> > +     if (!blkio || !media)
> >               return EFI_OUT_OF_RESOURCES;
> >
> > -     /* Hook up to the device list */
> > -     efi_add_handle(&diskobj->header);
> > +     *blkio = block_io_disk_template;
> > +     blkio->media = media;
> >
> >       /* Fill in object data */
> >       if (part_info) {
> > @@ -440,23 +448,22 @@ static efi_status_t efi_disk_add_dev(
> >                * (controller).
> >                */
> >               ret = efi_protocol_open(handler, &protocol_interface, NULL,
> > -                                     &diskobj->header,
> > +                                     handle,
> >                                       EFI_OPEN_PROTOCOL_BY_CHILD_CONTROLLER);
> >               if (ret != EFI_SUCCESS) {
> >                       log_debug("prot open failed\n");
> >                       goto error;
> >               }
> >
> > -             diskobj->dp = efi_dp_append_node(dp_parent, node);
> > +             dp = efi_dp_append_node(dp_parent, node);
> >               efi_free_pool(node);
> > -             diskobj->media.last_block = part_info->size - 1;
> > +             blkio->media->last_block = part_info->size - 1;
> >               if (part_info->bootable & PART_EFI_SYSTEM_PARTITION)
> >                       esp_guid = &efi_system_partition_guid;
> >       } else {
> > -             diskobj->dp = efi_dp_from_part(desc, part);
> > -             diskobj->media.last_block = desc->lba - 1;
> > +             dp = efi_dp_from_part(desc, part);
> > +             blkio->media->last_block = desc->lba - 1;
> >       }
> > -     diskobj->part = part;
> >
> >       /*
> >        * Install the device path and the block IO protocol.
> > @@ -465,11 +472,10 @@ static efi_status_t efi_disk_add_dev(
> >        * already installed on an other handle and returns EFI_ALREADY_STARTED
> >        * in this case.
> >        */
> > -     handle = &diskobj->header;
> >       ret = efi_install_multiple_protocol_interfaces(
> >                                       &handle,
> > -                                     &efi_guid_device_path, diskobj->dp,
> > -                                     &efi_block_io_guid, &diskobj->ops,
> > +                                     &efi_guid_device_path, dp,
> > +                                     &efi_block_io_guid, blkio,
> >                                       /*
> >                                        * esp_guid must be last entry as it
> >                                        * can be NULL. Its interface is NULL.
> > @@ -487,43 +493,39 @@ static efi_status_t efi_disk_add_dev(
> >        */
> >       if ((part || desc->part_type == PART_TYPE_UNKNOWN) &&
> >           efi_fs_exists(desc, part)) {
> > -             ret = efi_create_simple_file_system(desc, part, diskobj->dp,
> > -                                                 &diskobj->volume);
> > +             ret = efi_create_simple_file_system(desc, part, dp, &volume);
> >               if (ret != EFI_SUCCESS)
> >                       goto error;
> >
> > -             ret = efi_add_protocol(&diskobj->header,
> > +             ret = efi_add_protocol(handle,
> >                                      &efi_simple_file_system_protocol_guid,
> > -                                    diskobj->volume);
> > +                                    volume);
> >               if (ret != EFI_SUCCESS)
> >                       goto error;
> >       }
> > -     diskobj->ops = block_io_disk_template;
> > -     diskobj->dev_index = dev_index;
> >
> >       /* Fill in EFI IO Media info (for read/write callbacks) */
> > -     diskobj->media.removable_media = desc->removable;
> > -     diskobj->media.media_present = 1;
> > +     blkio->media->removable_media = desc->removable;
> > +     blkio->media->media_present = 1;
> >       /*
> >        * MediaID is just an arbitrary counter.
> >        * We have to change it if the medium is removed or changed.
> >        */
> > -     diskobj->media.media_id = 1;
> > -     diskobj->media.block_size = desc->blksz;
> > -     diskobj->media.io_align = desc->blksz;
> > +     blkio->media->media_id = 1;
> > +     blkio->media->block_size = desc->blksz;
> > +     blkio->media->io_align = desc->blksz;
> >       if (part)
> > -             diskobj->media.logical_partition = 1;
> > -     diskobj->ops.media = &diskobj->media;
> > +             blkio->media->logical_partition = 1;
> >       if (disk)
> > -             *disk = diskobj;
> > +             *disk = handle;
> >
> >       EFI_PRINT("BlockIO: part %u, present %d, logical %d, removable %d"
> >                 ", last_block %llu\n",
> > -               diskobj->part,
> > -               diskobj->media.media_present,
> > -               diskobj->media.logical_partition,
> > -               diskobj->media.removable_media,
> > -               diskobj->media.last_block);
> > +               part,
> > +               blkio->media->media_present,
> > +               blkio->media->logical_partition,
> > +               blkio->media->removable_media,
> > +               blkio->media->last_block);
> >
> >       /* Store first EFI system partition */
> >       if (part && efi_system_partition.uclass_id == UCLASS_INVALID) {
> > @@ -536,11 +538,18 @@ static efi_status_t efi_disk_add_dev(
> >                                 desc->devnum, part);
> >               }
> >       }
> > +
> > +     if (efi_link_dev(handle, dev))
> > +             goto error;
> > +
> >       return EFI_SUCCESS;
> >   error:
> > -     efi_delete_handle(&diskobj->header);
> > -     free(diskobj->volume);
> > -     free(diskobj);
> > +     efi_delete_handle(handle);
> > +     efi_free_pool(dp);
> > +     free(blkio);
> > +     free(media);
> > +     free(volume);
> > +
> >       return ret;
> >   }
> >
> > @@ -557,7 +566,7 @@ error:
> >    */
> >   static int efi_disk_create_raw(struct udevice *dev, efi_handle_t agent_handle)
> >   {
> > -     struct efi_disk_obj *disk;
> > +     efi_handle_t disk;
> >       struct blk_desc *desc;
> >       int diskid;
> >       efi_status_t ret;
> > @@ -566,7 +575,7 @@ static int efi_disk_create_raw(struct udevice *dev, efi_handle_t agent_handle)
> >       diskid = desc->devnum;
> >
> >       ret = efi_disk_add_dev(NULL, NULL, desc,
> > -                            diskid, NULL, 0, &disk, agent_handle);
> > +                            diskid, NULL, 0, &disk, agent_handle, dev);
> >       if (ret != EFI_SUCCESS) {
> >               if (ret == EFI_NOT_READY) {
> >                       log_notice("Disk %s not ready\n", dev->name);
> > @@ -578,12 +587,6 @@ static int efi_disk_create_raw(struct udevice *dev, efi_handle_t agent_handle)
> >
> >               return ret;
> >       }
> > -     if (efi_link_dev(&disk->header, dev)) {
> > -             efi_free_pool(disk->dp);
> > -             efi_delete_handle(&disk->header);
> > -
> > -             return -EINVAL;
> > -     }
> >
> >       return 0;
> >   }
> > @@ -609,7 +612,7 @@ static int efi_disk_create_part(struct udevice *dev, efi_handle_t agent_handle)
> >       int diskid;
> >       struct efi_handler *handler;
> >       struct efi_device_path *dp_parent;
> > -     struct efi_disk_obj *disk;
> > +     efi_handle_t disk;
> >       efi_status_t ret;
> >
> >       if (dev_tag_get_ptr(dev_get_parent(dev), DM_TAG_EFI, (void **)&parent))
> > @@ -628,17 +631,11 @@ static int efi_disk_create_part(struct udevice *dev, efi_handle_t agent_handle)
> >       dp_parent = (struct efi_device_path *)handler->protocol_interface;
> >
> >       ret = efi_disk_add_dev(parent, dp_parent, desc, diskid,
> > -                            info, part, &disk, agent_handle);
> > +                            info, part, &disk, agent_handle, dev);
> >       if (ret != EFI_SUCCESS) {
> >               log_err("Adding partition for %s failed\n", dev->name);
> >               return -1;
> >       }
> > -     if (efi_link_dev(&disk->header, dev)) {
> > -             efi_free_pool(disk->dp);
> > -             efi_delete_handle(&disk->header);
> > -
> > -             return -1;
> > -     }
> >
> >       return 0;
> >   }
> > @@ -693,13 +690,34 @@ int efi_disk_probe(void *ctx, struct event *event)
> >       return 0;
> >   }
> >
> > +static void get_disk_resources(efi_handle_t handle, struct efi_device_path **dp,
> > +                            struct efi_block_io **blkio,
> > +                            struct efi_simple_file_system_protocol **volume)
> > +{
> > +     efi_status_t ret;
> > +     struct efi_handler *handler;
> > +
> > +     ret = efi_search_protocol(handle, &efi_guid_device_path, &handler);
> > +     if (ret == EFI_SUCCESS)
> > +             *dp = handler->protocol_interface;
> > +
> > +     ret = efi_search_protocol(handle, &efi_block_io_guid, &handler);
> > +     if (ret == EFI_SUCCESS)
> > +             *blkio = handler->protocol_interface;
> > +
> > +     ret = efi_search_protocol(handle, &efi_simple_file_system_protocol_guid,
> > +                               &handler);
> > +     if (ret == EFI_SUCCESS)
> > +             *volume = handler->protocol_interface;
> > +}
> > +
> >   /**
> > - * efi_disk_remove - delete an efi_disk object for a block device or partition
> > + * efi_disk_remove - delete an efi handle for a block device or partition
> >    *
> >    * @ctx:    event context: driver binding protocol
> >    * @event:  EV_PM_PRE_REMOVE event
> >    *
> > - * Delete an efi_disk object which is associated with the UCLASS_BLK or
> > + * Delete an efi handle which is associated with the UCLASS_BLK or
> >    * UCLASS_PARTITION device for which the EV_PM_PRE_REMOVE event is raised.
> >    *
> >    * Return:  0 on success, -1 otherwise
> > @@ -710,8 +728,10 @@ int efi_disk_remove(void *ctx, struct event *event)
> >       struct udevice *dev = event->data.dm.dev;
> >       efi_handle_t handle;
> >       struct blk_desc *desc;
> > -     struct efi_disk_obj *diskobj = NULL;
> >       efi_status_t ret;
> > +     struct efi_device_path *dp = NULL;
> > +     struct efi_block_io *blkio = NULL;
> > +     struct efi_simple_file_system_protocol *volume = NULL;
> >
> >       if (dev_tag_get_ptr(dev, DM_TAG_EFI, (void **)&handle))
> >               return 0;
> > @@ -721,11 +741,11 @@ int efi_disk_remove(void *ctx, struct event *event)
> >       case UCLASS_BLK:
> >               desc = dev_get_uclass_plat(dev);
> >               if (desc && desc->uclass_id != UCLASS_EFI_LOADER)
> > -                     diskobj = container_of(handle, struct efi_disk_obj,
> > -                                            header);
> > +                     get_disk_resources(handle, &dp, &blkio, &volume);
> > +
> >               break;
> >       case UCLASS_PARTITION:
> > -             diskobj = container_of(handle, struct efi_disk_obj, header);
> > +             get_disk_resources(handle, &dp, &blkio, &volume);
> >               break;
> >       default:
> >               return 0;
> > @@ -736,8 +756,11 @@ int efi_disk_remove(void *ctx, struct event *event)
> >       if (ret != EFI_SUCCESS)
> >               return -1;
> >
> > -     if (diskobj)
> > -             efi_free_pool(diskobj->dp);
> > +     efi_free_pool(dp);
> > +     if (blkio) {
> > +             free(blkio->media);
> > +             free(blkio);
> > +     }
> >
> >       dev_tag_del(dev, DM_TAG_EFI);
> >
>
