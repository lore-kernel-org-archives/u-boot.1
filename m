Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F4CDC4167D
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 07:31:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF620879E3;
	Thu, 14 Dec 2023 08:31:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="DfoPq8Er";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB94187A25; Thu, 14 Dec 2023 08:31:19 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F38B879DC
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 08:31:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1702539076; x=1703143876; i=xypron.glpk@gmx.de;
 bh=5NI5d2AFdqq/E9CHqDqvFp0BWn1IHpoS5NRLNbo0FUQ=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:
 References;
 b=DfoPq8ErFu2OVyHMaRbQha6QN/M9RUWqyeaF2MoGEi4hCkYj7QpXESajYHTMsqiZ
 cC6Aot2Y/6VloRTC6RJGtmjL2DIOiisjtohlvdwdgalfNSWf2MQsjP90KISe4WAV/
 ojZi7vOhSkKJ8t+8fY4KOAzQciG7P5Gskx4cdr/1suJaSuD5VV2QtR1/R7rBnOOmc
 +v70QgCNRrLjYefpmn4pQ7CpAWnxTtyjHzCdlHpVi4qEtfItw0y1V6BO7rk8gArza
 wNBn9r5Rr58keMArewP0a7wkbWlxq/Z9T/Ay9z4z+KmV0GJeKKFTriJqJVbzA8x+x
 bskLCQE39OvDJchncw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhU9j-1ri4zn0V4V-00eaH1; Thu, 14
 Dec 2023 08:31:16 +0100
Date: Thu, 14 Dec 2023 08:31:15 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Masahisa Kojima <masahisa.kojima@linaro.org>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] efi_loader: eliminate efi_disk_obj structure
User-Agent: K-9 Mail for Android
In-Reply-To: <CADQ0-X9cBm4uVyMXNVL++exgoHkgB3RGAH=cPjtPO5JKh+CgHA@mail.gmail.com>
References: <20231213085737.299773-1-masahisa.kojima@linaro.org>
 <dcc6a681-2ede-49ba-ad0d-069933ad32ca@gmx.de>
 <CADQ0-X9cBm4uVyMXNVL++exgoHkgB3RGAH=cPjtPO5JKh+CgHA@mail.gmail.com>
Message-ID: <DE130DBC-CB76-4F6C-966E-1B3FDC63C0B0@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oQpc1gbNRi25BHCal5F8UoeVTAN+QU/72kcX7BSuqAT4h2tko5l
 3/YuuLTDhE0cUJazwZZou2Bx07sHj8Ebju7aZOlGugKIbrGxNzBOGfU+3qzj0VPxCBAnEsT
 GEOIDVobtv1Tq8OOZMkWyOTF8yao+50q095WY7mssQwL9Nm7LZUaX2rH99Bo6DHmk182nLJ
 RjIxx1HtGNAf2Qta+7JyQ==
UI-OutboundReport: notjunk:1;M01:P0:xc210Qtu3hE=;9FAjgabDdl9uSpTlJO8oRetxcUN
 3kdGRwilFjZBEWiELZHY7OMyVlBDRSp1JsgRo8HTWr3EDo70RwzvC3Qss79e4iiQ/EuCxOwji
 KNqdf49UnB7kR8KE5R6wQPpcsnT9BBrXVEnK2qPmN1XSMdooycauE06nS1X1amMRrzg16UaVP
 Dys5UEFKd28AfKV2+1tyiufnlGuot0oVUfi/FaxUeG8Rt6G5utqk4pCDVeDcVVpfbaTmVe51E
 EA9XjGhZvimXMZyGmbCySIefPvKd6wFW6h+0OTAhql2+QazOhDbbGGsLu4sDf3DFvZKUtjhZ3
 RQE3186tXCA1ROhr5fXeCw6eTLMo00IxeRSCSIAOWDXSrqb4An4qZ6S4pOAONZCT4s4EoCR9X
 d7LVb7cnQ6Rk3bhqAq+iVPDLPdMc3a8zKI/WgVSSVrT3v8WpLHkGzuPb1PRyj3iyJ7pTgh0mT
 6k9dyi8ZZdtwZXJ17pEhmTM4GiwuuHufJRC1lc6FkWRurpNWn4jh6dFam6fTtj3H1tKkVKGpU
 ZU/Ycf/NQZncehFlXg61daTZXNeLc6CsN1SyoacsG82PObLgWY65/a1RaVRZ3G3IIRjW+xoXj
 d6YxDf05Pnhrejr6HBj7j0SMt48kMCVjcfMA7Gtx0QSOUH0oMIV7M7rhgwoBe64s9j9T0iPO8
 ZBFHIOwC85WEjZETUYYLxTFU30+R/9IpD7Th8fpQs6oy7fK8xOD2+clzAxj1HhTwBACAbjAgC
 gBCUvsqzUxm4roKt9R2PEdK89o2KTHzm+Du8Tjbn1dFVmM57m4p1gvAK7EUMzgMY/hSIUtGFt
 zXwRjIjye4qGpiD4N9JHW9li0RD+ICE5bgsedvhYpJsJYUu7JfrsQaS/tqGptesik8tCEcNA5
 8bvxboXKk59YWcrSey//P0vkhvIeSMuovsoYOkGhalMubJpSqTQRnHda8+W2ST0AdaLEsSUCF
 ofhUUowEDEX5l/eCQ8NHXzL+mGQ=
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



Am 14=2E Dezember 2023 02:55:27 MEZ schrieb Masahisa Kojima <masahisa=2Eko=
jima@linaro=2Eorg>:
>Hi Heinrich,
>
>On Wed, 13 Dec 2023 at 23:22, Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede=
> wrote:
>>
>> On 13=2E12=2E23 09:57, Masahisa Kojima wrote:
>> > Current code uses struct efi_disk_obj to keep information
>> > about block devices and partitions=2E As the efi handle already
>> > has a field with the udevice, we should eliminate
>> > struct efi_disk_obj and use an pointer to struct efi_object
>> > for the handle=2E
>> >
>> > efi_link_dev() call is moved inside of efi_disk_add_dev() function
>> > to simplify the cleanup process in case of error=2E
>>
>> I agree that using struct efi_disk_obj as a container for protocols of =
a
>> block IO device is a bit messy=2E
>>
>> But we should keep looking up the handle easy=2E Currently we use
>>
>> diskobj =3D container_of(this, struct efi_disk_obj, ops);
>>
>> Instead we could append a private field with the handle to the
>> EFI_BLOCK_IO_PROTOCOL structure=2E
>>
>> >
>> > Signed-off-by: Masahisa Kojima <masahisa=2Ekojima@linaro=2Eorg>
>> > ---
>> >   lib/efi_loader/efi_disk=2Ec | 209 +++++++++++++++++++++------------=
-----
>> >   1 file changed, 116 insertions(+), 93 deletions(-)
>> >
>> > diff --git a/lib/efi_loader/efi_disk=2Ec b/lib/efi_loader/efi_disk=2E=
c
>> > index f0d76113b0=2E=2Ecfb7ace551 100644
>> > --- a/lib/efi_loader/efi_disk=2Ec
>> > +++ b/lib/efi_loader/efi_disk=2Ec
>> > @@ -27,27 +27,24 @@ struct efi_system_partition efi_system_partition =
=3D {
>> >   const efi_guid_t efi_block_io_guid =3D EFI_BLOCK_IO_PROTOCOL_GUID;
>> >   const efi_guid_t efi_system_partition_guid =3D PARTITION_SYSTEM_GUI=
D;
>> >
>> > -/**
>> > - * struct efi_disk_obj - EFI disk object
>> > - *
>> > - * @header:  EFI object header
>> > - * @ops:     EFI disk I/O protocol interface
>> > - * @dev_index:       device index of block device
>> > - * @media:   block I/O media information
>> > - * @dp:              device path to the block device
>> > - * @part:    partition
>> > - * @volume:  simple file system protocol of the partition
>> > - * @dev:     associated DM device
>> > - */
>> > -struct efi_disk_obj {
>> > -     struct efi_object header;
>> > -     struct efi_block_io ops;
>> > -     int dev_index;
>> > -     struct efi_block_io_media media;
>> > -     struct efi_device_path *dp;
>> > -     unsigned int part;
>> > -     struct efi_simple_file_system_protocol *volume;
>> > -};
>> > +static efi_handle_t efi_blkio_find_obj(struct efi_block_io *blkio)
>> > +{
>> > +     efi_handle_t handle;
>> > +
>> > +     list_for_each_entry(handle, &efi_obj_list, link) {
>> > +             efi_status_t ret;
>> > +             struct efi_handler *handler;
>> > +
>> > +             ret =3D efi_search_protocol(handle, &efi_block_io_guid,=
 &handler);
>> > +             if (ret !=3D EFI_SUCCESS)
>> > +                     continue;
>> > +
>> > +             if (blkio =3D=3D handler->protocol_interface)
>> > +                     return handle;
>> > +     }
>>
>> Depending on the number of handles and pointers this will take a
>> considerable time=2E A private field for the handle appended to struct
>> efi_block_io would allow a fast lookup=2E
>>
>> EDK II does the same=2E See the definition of RAM_DISK_PRIVATE_FROM_BLK=
IO
>> which uses macro BASE_CR() to find the private fields=2E
>
>This patch tries to address this issue[0]=2E
>
>If I understand correctly, two options are suggested here=2E
> 1) a private field for the handle appended to struct efi_block_io
> 2) keep the private struct something like current struct
>efi_disk_obj, same as EDK II does

Edk II uses 1) as I indicated above=2E

The UEFI specification prescribes which fields must be in the struct=2E In=
 both 1) and 2) you have private fields at a known offset to the structure=
=2E

EDK II can (this is configurable) additionally add a magic value to verify=
 that the overall structure was provided by EDK II=2E

Best regards

Heinrich


>
>struct efi_block_io is defined in UEFI spec, so probably option#2 is pref=
erable
>and it is almost the same as the current implementation=2E
>I think we can proceed with the minor cleanup of struct efi_disk_obj
>as Akashi-san suggested=2E
>
>[0] https://source=2Edenx=2Ede/u-boot/custodians/u-boot-efi/-/issues/9
>
>Thanks,
>Masahisa Kojima
>
>>
>> Best regards
>>
>> Heinrich
>>
>> > +
>> > +     return NULL;
>> > +}
>> >
>> >   /**
>> >    * efi_disk_reset() - reset block device
>> > @@ -107,13 +104,16 @@ static efi_status_t efi_disk_rw_blocks(struct e=
fi_block_io *this,
>> >                       u32 media_id, u64 lba, unsigned long buffer_siz=
e,
>> >                       void *buffer, enum efi_disk_direction direction=
)
>> >   {
>> > -     struct efi_disk_obj *diskobj;
>> > +     efi_handle_t handle;
>> >       int blksz;
>> >       int blocks;
>> >       unsigned long n;
>> >
>> > -     diskobj =3D container_of(this, struct efi_disk_obj, ops);
>> > -     blksz =3D diskobj->media=2Eblock_size;
>> > +     handle =3D efi_blkio_find_obj(this);
>> > +     if (!handle)
>> > +             return EFI_INVALID_PARAMETER;
>> > +
>> > +     blksz =3D this->media->block_size;
>> >       blocks =3D buffer_size / blksz;
>> >
>> >       EFI_PRINT("blocks=3D%x lba=3D%llx blksz=3D%x dir=3D%d\n",
>> > @@ -124,18 +124,16 @@ static efi_status_t efi_disk_rw_blocks(struct e=
fi_block_io *this,
>> >               return EFI_BAD_BUFFER_SIZE;
>> >
>> >       if (CONFIG_IS_ENABLED(PARTITIONS) &&
>> > -         device_get_uclass_id(diskobj->header=2Edev) =3D=3D UCLASS_P=
ARTITION) {
>> > +         device_get_uclass_id(handle->dev) =3D=3D UCLASS_PARTITION) =
{
>> >               if (direction =3D=3D EFI_DISK_READ)
>> > -                     n =3D disk_blk_read(diskobj->header=2Edev, lba,=
 blocks,
>> > -                                       buffer);
>> > +                     n =3D disk_blk_read(handle->dev, lba, blocks, b=
uffer);
>> >               else
>> > -                     n =3D disk_blk_write(diskobj->header=2Edev, lba=
, blocks,
>> > -                                        buffer);
>> > +                     n =3D disk_blk_write(handle->dev, lba, blocks, =
buffer);
>> >       } else {
>> >               /* dev is a block device (UCLASS_BLK) */
>> >               struct blk_desc *desc;
>> >
>> > -             desc =3D dev_get_uclass_plat(diskobj->header=2Edev);
>> > +             desc =3D dev_get_uclass_plat(handle->dev);
>> >               if (direction =3D=3D EFI_DISK_READ)
>> >                       n =3D blk_dread(desc, lba, blocks, buffer);
>> >               else
>> > @@ -388,6 +386,7 @@ static int efi_fs_exists(struct blk_desc *desc, i=
nt part)
>> >    * @part:           partition
>> >    * @disk:           pointer to receive the created handle
>> >    * @agent_handle:   handle of the EFI block driver
>> > + * @dev:             pointer to udevice
>> >    * Return:          disk object
>> >    */
>> >   static efi_status_t efi_disk_add_dev(
>> > @@ -397,24 +396,33 @@ static efi_status_t efi_disk_add_dev(
>> >                               int dev_index,
>> >                               struct disk_partition *part_info,
>> >                               unsigned int part,
>> > -                             struct efi_disk_obj **disk,
>> > -                             efi_handle_t agent_handle)
>> > +                             efi_handle_t *disk,
>> > +                             efi_handle_t agent_handle,
>> > +                             struct udevice *dev)
>> >   {
>> > -     struct efi_disk_obj *diskobj;
>> > -     struct efi_object *handle;
>> > +     efi_handle_t handle;
>> >       const efi_guid_t *esp_guid =3D NULL;
>> >       efi_status_t ret;
>> > +     struct efi_block_io *blkio;
>> > +     struct efi_block_io_media *media;
>> > +     struct efi_device_path *dp =3D NULL;
>> > +     struct efi_simple_file_system_protocol *volume =3D NULL;
>> >
>> >       /* Don't add empty devices */
>> >       if (!desc->lba)
>> >               return EFI_NOT_READY;
>> >
>> > -     diskobj =3D calloc(1, sizeof(*diskobj));
>> > -     if (!diskobj)
>> > +     ret =3D efi_create_handle(&handle);
>> > +     if (ret !=3D EFI_SUCCESS)
>> > +             return ret;
>> > +
>> > +     blkio =3D calloc(1, sizeof(*blkio));
>> > +     media =3D calloc(1, sizeof(*media));
>> > +     if (!blkio || !media)
>> >               return EFI_OUT_OF_RESOURCES;
>> >
>> > -     /* Hook up to the device list */
>> > -     efi_add_handle(&diskobj->header);
>> > +     *blkio =3D block_io_disk_template;
>> > +     blkio->media =3D media;
>> >
>> >       /* Fill in object data */
>> >       if (part_info) {
>> > @@ -440,23 +448,22 @@ static efi_status_t efi_disk_add_dev(
>> >                * (controller)=2E
>> >                */
>> >               ret =3D efi_protocol_open(handler, &protocol_interface,=
 NULL,
>> > -                                     &diskobj->header,
>> > +                                     handle,
>> >                                       EFI_OPEN_PROTOCOL_BY_CHILD_CONT=
ROLLER);
>> >               if (ret !=3D EFI_SUCCESS) {
>> >                       log_debug("prot open failed\n");
>> >                       goto error;
>> >               }
>> >
>> > -             diskobj->dp =3D efi_dp_append_node(dp_parent, node);
>> > +             dp =3D efi_dp_append_node(dp_parent, node);
>> >               efi_free_pool(node);
>> > -             diskobj->media=2Elast_block =3D part_info->size - 1;
>> > +             blkio->media->last_block =3D part_info->size - 1;
>> >               if (part_info->bootable & PART_EFI_SYSTEM_PARTITION)
>> >                       esp_guid =3D &efi_system_partition_guid;
>> >       } else {
>> > -             diskobj->dp =3D efi_dp_from_part(desc, part);
>> > -             diskobj->media=2Elast_block =3D desc->lba - 1;
>> > +             dp =3D efi_dp_from_part(desc, part);
>> > +             blkio->media->last_block =3D desc->lba - 1;
>> >       }
>> > -     diskobj->part =3D part;
>> >
>> >       /*
>> >        * Install the device path and the block IO protocol=2E
>> > @@ -465,11 +472,10 @@ static efi_status_t efi_disk_add_dev(
>> >        * already installed on an other handle and returns EFI_ALREADY=
_STARTED
>> >        * in this case=2E
>> >        */
>> > -     handle =3D &diskobj->header;
>> >       ret =3D efi_install_multiple_protocol_interfaces(
>> >                                       &handle,
>> > -                                     &efi_guid_device_path, diskobj-=
>dp,
>> > -                                     &efi_block_io_guid, &diskobj->o=
ps,
>> > +                                     &efi_guid_device_path, dp,
>> > +                                     &efi_block_io_guid, blkio,
>> >                                       /*
>> >                                        * esp_guid must be last entry =
as it
>> >                                        * can be NULL=2E Its interface=
 is NULL=2E
>> > @@ -487,43 +493,39 @@ static efi_status_t efi_disk_add_dev(
>> >        */
>> >       if ((part || desc->part_type =3D=3D PART_TYPE_UNKNOWN) &&
>> >           efi_fs_exists(desc, part)) {
>> > -             ret =3D efi_create_simple_file_system(desc, part, disko=
bj->dp,
>> > -                                                 &diskobj->volume);
>> > +             ret =3D efi_create_simple_file_system(desc, part, dp, &=
volume);
>> >               if (ret !=3D EFI_SUCCESS)
>> >                       goto error;
>> >
>> > -             ret =3D efi_add_protocol(&diskobj->header,
>> > +             ret =3D efi_add_protocol(handle,
>> >                                      &efi_simple_file_system_protocol=
_guid,
>> > -                                    diskobj->volume);
>> > +                                    volume);
>> >               if (ret !=3D EFI_SUCCESS)
>> >                       goto error;
>> >       }
>> > -     diskobj->ops =3D block_io_disk_template;
>> > -     diskobj->dev_index =3D dev_index;
>> >
>> >       /* Fill in EFI IO Media info (for read/write callbacks) */
>> > -     diskobj->media=2Eremovable_media =3D desc->removable;
>> > -     diskobj->media=2Emedia_present =3D 1;
>> > +     blkio->media->removable_media =3D desc->removable;
>> > +     blkio->media->media_present =3D 1;
>> >       /*
>> >        * MediaID is just an arbitrary counter=2E
>> >        * We have to change it if the medium is removed or changed=2E
>> >        */
>> > -     diskobj->media=2Emedia_id =3D 1;
>> > -     diskobj->media=2Eblock_size =3D desc->blksz;
>> > -     diskobj->media=2Eio_align =3D desc->blksz;
>> > +     blkio->media->media_id =3D 1;
>> > +     blkio->media->block_size =3D desc->blksz;
>> > +     blkio->media->io_align =3D desc->blksz;
>> >       if (part)
>> > -             diskobj->media=2Elogical_partition =3D 1;
>> > -     diskobj->ops=2Emedia =3D &diskobj->media;
>> > +             blkio->media->logical_partition =3D 1;
>> >       if (disk)
>> > -             *disk =3D diskobj;
>> > +             *disk =3D handle;
>> >
>> >       EFI_PRINT("BlockIO: part %u, present %d, logical %d, removable =
%d"
>> >                 ", last_block %llu\n",
>> > -               diskobj->part,
>> > -               diskobj->media=2Emedia_present,
>> > -               diskobj->media=2Elogical_partition,
>> > -               diskobj->media=2Eremovable_media,
>> > -               diskobj->media=2Elast_block);
>> > +               part,
>> > +               blkio->media->media_present,
>> > +               blkio->media->logical_partition,
>> > +               blkio->media->removable_media,
>> > +               blkio->media->last_block);
>> >
>> >       /* Store first EFI system partition */
>> >       if (part && efi_system_partition=2Euclass_id =3D=3D UCLASS_INVA=
LID) {
>> > @@ -536,11 +538,18 @@ static efi_status_t efi_disk_add_dev(
>> >                                 desc->devnum, part);
>> >               }
>> >       }
>> > +
>> > +     if (efi_link_dev(handle, dev))
>> > +             goto error;
>> > +
>> >       return EFI_SUCCESS;
>> >   error:
>> > -     efi_delete_handle(&diskobj->header);
>> > -     free(diskobj->volume);
>> > -     free(diskobj);
>> > +     efi_delete_handle(handle);
>> > +     efi_free_pool(dp);
>> > +     free(blkio);
>> > +     free(media);
>> > +     free(volume);
>> > +
>> >       return ret;
>> >   }
>> >
>> > @@ -557,7 +566,7 @@ error:
>> >    */
>> >   static int efi_disk_create_raw(struct udevice *dev, efi_handle_t ag=
ent_handle)
>> >   {
>> > -     struct efi_disk_obj *disk;
>> > +     efi_handle_t disk;
>> >       struct blk_desc *desc;
>> >       int diskid;
>> >       efi_status_t ret;
>> > @@ -566,7 +575,7 @@ static int efi_disk_create_raw(struct udevice *de=
v, efi_handle_t agent_handle)
>> >       diskid =3D desc->devnum;
>> >
>> >       ret =3D efi_disk_add_dev(NULL, NULL, desc,
>> > -                            diskid, NULL, 0, &disk, agent_handle);
>> > +                            diskid, NULL, 0, &disk, agent_handle, de=
v);
>> >       if (ret !=3D EFI_SUCCESS) {
>> >               if (ret =3D=3D EFI_NOT_READY) {
>> >                       log_notice("Disk %s not ready\n", dev->name);
>> > @@ -578,12 +587,6 @@ static int efi_disk_create_raw(struct udevice *d=
ev, efi_handle_t agent_handle)
>> >
>> >               return ret;
>> >       }
>> > -     if (efi_link_dev(&disk->header, dev)) {
>> > -             efi_free_pool(disk->dp);
>> > -             efi_delete_handle(&disk->header);
>> > -
>> > -             return -EINVAL;
>> > -     }
>> >
>> >       return 0;
>> >   }
>> > @@ -609,7 +612,7 @@ static int efi_disk_create_part(struct udevice *d=
ev, efi_handle_t agent_handle)
>> >       int diskid;
>> >       struct efi_handler *handler;
>> >       struct efi_device_path *dp_parent;
>> > -     struct efi_disk_obj *disk;
>> > +     efi_handle_t disk;
>> >       efi_status_t ret;
>> >
>> >       if (dev_tag_get_ptr(dev_get_parent(dev), DM_TAG_EFI, (void **)&=
parent))
>> > @@ -628,17 +631,11 @@ static int efi_disk_create_part(struct udevice =
*dev, efi_handle_t agent_handle)
>> >       dp_parent =3D (struct efi_device_path *)handler->protocol_inter=
face;
>> >
>> >       ret =3D efi_disk_add_dev(parent, dp_parent, desc, diskid,
>> > -                            info, part, &disk, agent_handle);
>> > +                            info, part, &disk, agent_handle, dev);
>> >       if (ret !=3D EFI_SUCCESS) {
>> >               log_err("Adding partition for %s failed\n", dev->name);
>> >               return -1;
>> >       }
>> > -     if (efi_link_dev(&disk->header, dev)) {
>> > -             efi_free_pool(disk->dp);
>> > -             efi_delete_handle(&disk->header);
>> > -
>> > -             return -1;
>> > -     }
>> >
>> >       return 0;
>> >   }
>> > @@ -693,13 +690,34 @@ int efi_disk_probe(void *ctx, struct event *eve=
nt)
>> >       return 0;
>> >   }
>> >
>> > +static void get_disk_resources(efi_handle_t handle, struct efi_devic=
e_path **dp,
>> > +                            struct efi_block_io **blkio,
>> > +                            struct efi_simple_file_system_protocol *=
*volume)
>> > +{
>> > +     efi_status_t ret;
>> > +     struct efi_handler *handler;
>> > +
>> > +     ret =3D efi_search_protocol(handle, &efi_guid_device_path, &han=
dler);
>> > +     if (ret =3D=3D EFI_SUCCESS)
>> > +             *dp =3D handler->protocol_interface;
>> > +
>> > +     ret =3D efi_search_protocol(handle, &efi_block_io_guid, &handle=
r);
>> > +     if (ret =3D=3D EFI_SUCCESS)
>> > +             *blkio =3D handler->protocol_interface;
>> > +
>> > +     ret =3D efi_search_protocol(handle, &efi_simple_file_system_pro=
tocol_guid,
>> > +                               &handler);
>> > +     if (ret =3D=3D EFI_SUCCESS)
>> > +             *volume =3D handler->protocol_interface;
>> > +}
>> > +
>> >   /**
>> > - * efi_disk_remove - delete an efi_disk object for a block device or=
 partition
>> > + * efi_disk_remove - delete an efi handle for a block device or part=
ition
>> >    *
>> >    * @ctx:    event context: driver binding protocol
>> >    * @event:  EV_PM_PRE_REMOVE event
>> >    *
>> > - * Delete an efi_disk object which is associated with the UCLASS_BLK=
 or
>> > + * Delete an efi handle which is associated with the UCLASS_BLK or
>> >    * UCLASS_PARTITION device for which the EV_PM_PRE_REMOVE event is =
raised=2E
>> >    *
>> >    * Return:  0 on success, -1 otherwise
>> > @@ -710,8 +728,10 @@ int efi_disk_remove(void *ctx, struct event *eve=
nt)
>> >       struct udevice *dev =3D event->data=2Edm=2Edev;
>> >       efi_handle_t handle;
>> >       struct blk_desc *desc;
>> > -     struct efi_disk_obj *diskobj =3D NULL;
>> >       efi_status_t ret;
>> > +     struct efi_device_path *dp =3D NULL;
>> > +     struct efi_block_io *blkio =3D NULL;
>> > +     struct efi_simple_file_system_protocol *volume =3D NULL;
>> >
>> >       if (dev_tag_get_ptr(dev, DM_TAG_EFI, (void **)&handle))
>> >               return 0;
>> > @@ -721,11 +741,11 @@ int efi_disk_remove(void *ctx, struct event *ev=
ent)
>> >       case UCLASS_BLK:
>> >               desc =3D dev_get_uclass_plat(dev);
>> >               if (desc && desc->uclass_id !=3D UCLASS_EFI_LOADER)
>> > -                     diskobj =3D container_of(handle, struct efi_dis=
k_obj,
>> > -                                            header);
>> > +                     get_disk_resources(handle, &dp, &blkio, &volume=
);
>> > +
>> >               break;
>> >       case UCLASS_PARTITION:
>> > -             diskobj =3D container_of(handle, struct efi_disk_obj, h=
eader);
>> > +             get_disk_resources(handle, &dp, &blkio, &volume);
>> >               break;
>> >       default:
>> >               return 0;
>> > @@ -736,8 +756,11 @@ int efi_disk_remove(void *ctx, struct event *eve=
nt)
>> >       if (ret !=3D EFI_SUCCESS)
>> >               return -1;
>> >
>> > -     if (diskobj)
>> > -             efi_free_pool(diskobj->dp);
>> > +     efi_free_pool(dp);
>> > +     if (blkio) {
>> > +             free(blkio->media);
>> > +             free(blkio);
>> > +     }
>> >
>> >       dev_tag_del(dev, DM_TAG_EFI);
>> >
>>
