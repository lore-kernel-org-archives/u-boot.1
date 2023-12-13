Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5CF8C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 14:22:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2828E86F28;
	Wed, 13 Dec 2023 15:22:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="lETgB7/T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79CC78082A; Wed, 13 Dec 2023 15:22:35 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 206BE86F28
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 15:22:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1702477352; x=1703082152; i=xypron.glpk@gmx.de;
 bh=xw+yN91AN4VCjhwqo5y7qIkNth2dYzegSE33lwtjITY=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=lETgB7/TB3HN9Iqcs6rNMw7P73AA4QU9ExpAacsYlbgil+GEKd9+eFMmtjTKUcGV
 CFxW9QxO/wjlbaqYEHDSRf4tjDO5X2BoOZ+MBJO8JfPJ3PKx0miVb3oSP/2enAa2T
 maSUduJA90dcaVhnJTeXPp4gT+9Ri8CYWaoCb8m82N3YfTpA7iaibbtCi7ZBYU0ny
 BP+wo93fkzD+0ttsP8jo4PZYG2BB0N9YXM9t+JjGugs0hPKO8RrWeyILVNfBd6KKo
 frN94jwFs79SF8XODHm3s6B53i2085vz7VDxxaavcNCzX5SvHWJmvpBshpHHGmQOl
 KkleMm0GNivT0IO9MA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McH5Q-1rlMuB3GUW-00cdex; Wed, 13
 Dec 2023 15:22:31 +0100
Message-ID: <dcc6a681-2ede-49ba-ad0d-069933ad32ca@gmx.de>
Date: Wed, 13 Dec 2023 15:22:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: eliminate efi_disk_obj structure
Content-Language: en-US
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20231213085737.299773-1-masahisa.kojima@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231213085737.299773-1-masahisa.kojima@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i0XXt0S9Q/Urpv5bCeKugCI40WHlb1N+hKRNmtzDwgEaHkC+ovs
 Z4JrAepbTwMTqTS1OeWVnmr/kIcY1iX3t9rZBkU+ppgaAp1xHvo3h9rP+UM7yRFKJsIxHgU
 amNU+wn3i1GeFXE4yFg5ZAgOpEt5aIzGGCxOnl3fhXWFdi9t3s/QPws9eI9A9y/++wMl4OQ
 egkBq62kUALDW5NvTeeUg==
UI-OutboundReport: notjunk:1;M01:P0:CvPV15H5ryE=;MegyudjI0WzSrpS6GqdI8EIuXb9
 YPp8WcjY3jpXPZvk4shqCni8F2iyIBb1AYHajyzgCcljDE/ZlqZuqQ1V+j3GoaemZM1cT8X6D
 q+c6Rso9VSIejWnUNOi5nzXRu84Bl6reGFpxlkVKZwCQWL3LsuUqF9fq1bg0+mkPXXAKiZ1l3
 IBS/NBeIFtqhHaGrT9C1on8W20SWjXRvpDFMO6ELrqb9ZmdNxzYbM6FYrnY6ypz9ueeu9r3dI
 ld4qzgV3BAO++mb8SuAZObklgY7uGVQrW2CP0mZIEeL+OY46vHM+lfYMbBlBohteWZzldJxX2
 ++KLlfgGXuqBA2fozfb28nCFjCY3yrpootq4Kh1qr71sJ/8o1gka0q05gcf4eNss+1F0WGz/v
 e3NWMtLC1MTft66aEAZelmrUTxh13CP3lGgJMZEgfkj7dRt0M7RrlWd456TsnZ7DJQSBch/6h
 ZtkxtmEzwO7q10f3YDsxgrx1hEfH7lVWSHk5BwFTPqwG3QIaKiM07p8FNxVqpV7no4V75eyEE
 dVVGBYgBnDjRcxLPOo67zEJAK4ZRnNIiJ4vS2G0Sbee8CKsokYs3L6E/7E6jtUpaVVGmLYk34
 5rWew8aE7pvrWG6LkHq2Wx8QrZp/rZDNSH4WgVkA0IWgOKY1VRYZHPrgSUkZQBC9Wy0G4+ZVY
 KuB+R2bkeZJhqaX55oONTGabwQmsU7Pj1ziuXUDbay0Pj0Eb5qCf9r6Te+p0avvIWcQBDzbIr
 o9lvPi4C+pppt4sJ1OMEChZFOvblTZmUBURBQ7SPB33/oIjWazuIO5SUVKBxWYyEGvaz13b9H
 icF9Rf3mum/cH1da2OGl/JcJ/D8rmqoEf7dWzvCKRE0yia0KhA0G0qAa6GJ5DIisQvnDOQMUE
 eIaniKs6aGMcQGhOHcC8BBTa0/RAdF1VR1SbP2heYg3FHEQcd/FCDjFw58jj5Z6Gy2K6DpY6m
 X3Fs0ZrwmGxMQujIX+XA4/KLjDM=
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

On 13.12.23 09:57, Masahisa Kojima wrote:
> Current code uses struct efi_disk_obj to keep information
> about block devices and partitions. As the efi handle already
> has a field with the udevice, we should eliminate
> struct efi_disk_obj and use an pointer to struct efi_object
> for the handle.
>
> efi_link_dev() call is moved inside of efi_disk_add_dev() function
> to simplify the cleanup process in case of error.

I agree that using struct efi_disk_obj as a container for protocols of a
block IO device is a bit messy.

But we should keep looking up the handle easy. Currently we use

diskobj =3D container_of(this, struct efi_disk_obj, ops);

Instead we could append a private field with the handle to the
EFI_BLOCK_IO_PROTOCOL structure.

>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---
>   lib/efi_loader/efi_disk.c | 209 +++++++++++++++++++++-----------------
>   1 file changed, 116 insertions(+), 93 deletions(-)
>
> diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> index f0d76113b0..cfb7ace551 100644
> --- a/lib/efi_loader/efi_disk.c
> +++ b/lib/efi_loader/efi_disk.c
> @@ -27,27 +27,24 @@ struct efi_system_partition efi_system_partition =3D=
 {
>   const efi_guid_t efi_block_io_guid =3D EFI_BLOCK_IO_PROTOCOL_GUID;
>   const efi_guid_t efi_system_partition_guid =3D PARTITION_SYSTEM_GUID;
>
> -/**
> - * struct efi_disk_obj - EFI disk object
> - *
> - * @header:	EFI object header
> - * @ops:	EFI disk I/O protocol interface
> - * @dev_index:	device index of block device
> - * @media:	block I/O media information
> - * @dp:		device path to the block device
> - * @part:	partition
> - * @volume:	simple file system protocol of the partition
> - * @dev:	associated DM device
> - */
> -struct efi_disk_obj {
> -	struct efi_object header;
> -	struct efi_block_io ops;
> -	int dev_index;
> -	struct efi_block_io_media media;
> -	struct efi_device_path *dp;
> -	unsigned int part;
> -	struct efi_simple_file_system_protocol *volume;
> -};
> +static efi_handle_t efi_blkio_find_obj(struct efi_block_io *blkio)
> +{
> +	efi_handle_t handle;
> +
> +	list_for_each_entry(handle, &efi_obj_list, link) {
> +		efi_status_t ret;
> +		struct efi_handler *handler;
> +
> +		ret =3D efi_search_protocol(handle, &efi_block_io_guid, &handler);
> +		if (ret !=3D EFI_SUCCESS)
> +			continue;
> +
> +		if (blkio =3D=3D handler->protocol_interface)
> +			return handle;
> +	}

Depending on the number of handles and pointers this will take a
considerable time. A private field for the handle appended to struct
efi_block_io would allow a fast lookup.

EDK II does the same. See the definition of RAM_DISK_PRIVATE_FROM_BLKIO
which uses macro BASE_CR() to find the private fields.

Best regards

Heinrich

> +
> +	return NULL;
> +}
>
>   /**
>    * efi_disk_reset() - reset block device
> @@ -107,13 +104,16 @@ static efi_status_t efi_disk_rw_blocks(struct efi_=
block_io *this,
>   			u32 media_id, u64 lba, unsigned long buffer_size,
>   			void *buffer, enum efi_disk_direction direction)
>   {
> -	struct efi_disk_obj *diskobj;
> +	efi_handle_t handle;
>   	int blksz;
>   	int blocks;
>   	unsigned long n;
>
> -	diskobj =3D container_of(this, struct efi_disk_obj, ops);
> -	blksz =3D diskobj->media.block_size;
> +	handle =3D efi_blkio_find_obj(this);
> +	if (!handle)
> +		return EFI_INVALID_PARAMETER;
> +
> +	blksz =3D this->media->block_size;
>   	blocks =3D buffer_size / blksz;
>
>   	EFI_PRINT("blocks=3D%x lba=3D%llx blksz=3D%x dir=3D%d\n",
> @@ -124,18 +124,16 @@ static efi_status_t efi_disk_rw_blocks(struct efi_=
block_io *this,
>   		return EFI_BAD_BUFFER_SIZE;
>
>   	if (CONFIG_IS_ENABLED(PARTITIONS) &&
> -	    device_get_uclass_id(diskobj->header.dev) =3D=3D UCLASS_PARTITION)=
 {
> +	    device_get_uclass_id(handle->dev) =3D=3D UCLASS_PARTITION) {
>   		if (direction =3D=3D EFI_DISK_READ)
> -			n =3D disk_blk_read(diskobj->header.dev, lba, blocks,
> -					  buffer);
> +			n =3D disk_blk_read(handle->dev, lba, blocks, buffer);
>   		else
> -			n =3D disk_blk_write(diskobj->header.dev, lba, blocks,
> -					   buffer);
> +			n =3D disk_blk_write(handle->dev, lba, blocks, buffer);
>   	} else {
>   		/* dev is a block device (UCLASS_BLK) */
>   		struct blk_desc *desc;
>
> -		desc =3D dev_get_uclass_plat(diskobj->header.dev);
> +		desc =3D dev_get_uclass_plat(handle->dev);
>   		if (direction =3D=3D EFI_DISK_READ)
>   			n =3D blk_dread(desc, lba, blocks, buffer);
>   		else
> @@ -388,6 +386,7 @@ static int efi_fs_exists(struct blk_desc *desc, int =
part)
>    * @part:		partition
>    * @disk:		pointer to receive the created handle
>    * @agent_handle:	handle of the EFI block driver
> + * @dev:		pointer to udevice
>    * Return:		disk object
>    */
>   static efi_status_t efi_disk_add_dev(
> @@ -397,24 +396,33 @@ static efi_status_t efi_disk_add_dev(
>   				int dev_index,
>   				struct disk_partition *part_info,
>   				unsigned int part,
> -				struct efi_disk_obj **disk,
> -				efi_handle_t agent_handle)
> +				efi_handle_t *disk,
> +				efi_handle_t agent_handle,
> +				struct udevice *dev)
>   {
> -	struct efi_disk_obj *diskobj;
> -	struct efi_object *handle;
> +	efi_handle_t handle;
>   	const efi_guid_t *esp_guid =3D NULL;
>   	efi_status_t ret;
> +	struct efi_block_io *blkio;
> +	struct efi_block_io_media *media;
> +	struct efi_device_path *dp =3D NULL;
> +	struct efi_simple_file_system_protocol *volume =3D NULL;
>
>   	/* Don't add empty devices */
>   	if (!desc->lba)
>   		return EFI_NOT_READY;
>
> -	diskobj =3D calloc(1, sizeof(*diskobj));
> -	if (!diskobj)
> +	ret =3D efi_create_handle(&handle);
> +	if (ret !=3D EFI_SUCCESS)
> +		return ret;
> +
> +	blkio =3D calloc(1, sizeof(*blkio));
> +	media =3D calloc(1, sizeof(*media));
> +	if (!blkio || !media)
>   		return EFI_OUT_OF_RESOURCES;
>
> -	/* Hook up to the device list */
> -	efi_add_handle(&diskobj->header);
> +	*blkio =3D block_io_disk_template;
> +	blkio->media =3D media;
>
>   	/* Fill in object data */
>   	if (part_info) {
> @@ -440,23 +448,22 @@ static efi_status_t efi_disk_add_dev(
>   		 * (controller).
>   		 */
>   		ret =3D efi_protocol_open(handler, &protocol_interface, NULL,
> -					&diskobj->header,
> +					handle,
>   					EFI_OPEN_PROTOCOL_BY_CHILD_CONTROLLER);
>   		if (ret !=3D EFI_SUCCESS) {
>   			log_debug("prot open failed\n");
>   			goto error;
>   		}
>
> -		diskobj->dp =3D efi_dp_append_node(dp_parent, node);
> +		dp =3D efi_dp_append_node(dp_parent, node);
>   		efi_free_pool(node);
> -		diskobj->media.last_block =3D part_info->size - 1;
> +		blkio->media->last_block =3D part_info->size - 1;
>   		if (part_info->bootable & PART_EFI_SYSTEM_PARTITION)
>   			esp_guid =3D &efi_system_partition_guid;
>   	} else {
> -		diskobj->dp =3D efi_dp_from_part(desc, part);
> -		diskobj->media.last_block =3D desc->lba - 1;
> +		dp =3D efi_dp_from_part(desc, part);
> +		blkio->media->last_block =3D desc->lba - 1;
>   	}
> -	diskobj->part =3D part;
>
>   	/*
>   	 * Install the device path and the block IO protocol.
> @@ -465,11 +472,10 @@ static efi_status_t efi_disk_add_dev(
>   	 * already installed on an other handle and returns EFI_ALREADY_START=
ED
>   	 * in this case.
>   	 */
> -	handle =3D &diskobj->header;
>   	ret =3D efi_install_multiple_protocol_interfaces(
>   					&handle,
> -					&efi_guid_device_path, diskobj->dp,
> -					&efi_block_io_guid, &diskobj->ops,
> +					&efi_guid_device_path, dp,
> +					&efi_block_io_guid, blkio,
>   					/*
>   					 * esp_guid must be last entry as it
>   					 * can be NULL. Its interface is NULL.
> @@ -487,43 +493,39 @@ static efi_status_t efi_disk_add_dev(
>   	 */
>   	if ((part || desc->part_type =3D=3D PART_TYPE_UNKNOWN) &&
>   	    efi_fs_exists(desc, part)) {
> -		ret =3D efi_create_simple_file_system(desc, part, diskobj->dp,
> -						    &diskobj->volume);
> +		ret =3D efi_create_simple_file_system(desc, part, dp, &volume);
>   		if (ret !=3D EFI_SUCCESS)
>   			goto error;
>
> -		ret =3D efi_add_protocol(&diskobj->header,
> +		ret =3D efi_add_protocol(handle,
>   				       &efi_simple_file_system_protocol_guid,
> -				       diskobj->volume);
> +				       volume);
>   		if (ret !=3D EFI_SUCCESS)
>   			goto error;
>   	}
> -	diskobj->ops =3D block_io_disk_template;
> -	diskobj->dev_index =3D dev_index;
>
>   	/* Fill in EFI IO Media info (for read/write callbacks) */
> -	diskobj->media.removable_media =3D desc->removable;
> -	diskobj->media.media_present =3D 1;
> +	blkio->media->removable_media =3D desc->removable;
> +	blkio->media->media_present =3D 1;
>   	/*
>   	 * MediaID is just an arbitrary counter.
>   	 * We have to change it if the medium is removed or changed.
>   	 */
> -	diskobj->media.media_id =3D 1;
> -	diskobj->media.block_size =3D desc->blksz;
> -	diskobj->media.io_align =3D desc->blksz;
> +	blkio->media->media_id =3D 1;
> +	blkio->media->block_size =3D desc->blksz;
> +	blkio->media->io_align =3D desc->blksz;
>   	if (part)
> -		diskobj->media.logical_partition =3D 1;
> -	diskobj->ops.media =3D &diskobj->media;
> +		blkio->media->logical_partition =3D 1;
>   	if (disk)
> -		*disk =3D diskobj;
> +		*disk =3D handle;
>
>   	EFI_PRINT("BlockIO: part %u, present %d, logical %d, removable %d"
>   		  ", last_block %llu\n",
> -		  diskobj->part,
> -		  diskobj->media.media_present,
> -		  diskobj->media.logical_partition,
> -		  diskobj->media.removable_media,
> -		  diskobj->media.last_block);
> +		  part,
> +		  blkio->media->media_present,
> +		  blkio->media->logical_partition,
> +		  blkio->media->removable_media,
> +		  blkio->media->last_block);
>
>   	/* Store first EFI system partition */
>   	if (part && efi_system_partition.uclass_id =3D=3D UCLASS_INVALID) {
> @@ -536,11 +538,18 @@ static efi_status_t efi_disk_add_dev(
>   				  desc->devnum, part);
>   		}
>   	}
> +
> +	if (efi_link_dev(handle, dev))
> +		goto error;
> +
>   	return EFI_SUCCESS;
>   error:
> -	efi_delete_handle(&diskobj->header);
> -	free(diskobj->volume);
> -	free(diskobj);
> +	efi_delete_handle(handle);
> +	efi_free_pool(dp);
> +	free(blkio);
> +	free(media);
> +	free(volume);
> +
>   	return ret;
>   }
>
> @@ -557,7 +566,7 @@ error:
>    */
>   static int efi_disk_create_raw(struct udevice *dev, efi_handle_t agent=
_handle)
>   {
> -	struct efi_disk_obj *disk;
> +	efi_handle_t disk;
>   	struct blk_desc *desc;
>   	int diskid;
>   	efi_status_t ret;
> @@ -566,7 +575,7 @@ static int efi_disk_create_raw(struct udevice *dev, =
efi_handle_t agent_handle)
>   	diskid =3D desc->devnum;
>
>   	ret =3D efi_disk_add_dev(NULL, NULL, desc,
> -			       diskid, NULL, 0, &disk, agent_handle);
> +			       diskid, NULL, 0, &disk, agent_handle, dev);
>   	if (ret !=3D EFI_SUCCESS) {
>   		if (ret =3D=3D EFI_NOT_READY) {
>   			log_notice("Disk %s not ready\n", dev->name);
> @@ -578,12 +587,6 @@ static int efi_disk_create_raw(struct udevice *dev,=
 efi_handle_t agent_handle)
>
>   		return ret;
>   	}
> -	if (efi_link_dev(&disk->header, dev)) {
> -		efi_free_pool(disk->dp);
> -		efi_delete_handle(&disk->header);
> -
> -		return -EINVAL;
> -	}
>
>   	return 0;
>   }
> @@ -609,7 +612,7 @@ static int efi_disk_create_part(struct udevice *dev,=
 efi_handle_t agent_handle)
>   	int diskid;
>   	struct efi_handler *handler;
>   	struct efi_device_path *dp_parent;
> -	struct efi_disk_obj *disk;
> +	efi_handle_t disk;
>   	efi_status_t ret;
>
>   	if (dev_tag_get_ptr(dev_get_parent(dev), DM_TAG_EFI, (void **)&parent=
))
> @@ -628,17 +631,11 @@ static int efi_disk_create_part(struct udevice *de=
v, efi_handle_t agent_handle)
>   	dp_parent =3D (struct efi_device_path *)handler->protocol_interface;
>
>   	ret =3D efi_disk_add_dev(parent, dp_parent, desc, diskid,
> -			       info, part, &disk, agent_handle);
> +			       info, part, &disk, agent_handle, dev);
>   	if (ret !=3D EFI_SUCCESS) {
>   		log_err("Adding partition for %s failed\n", dev->name);
>   		return -1;
>   	}
> -	if (efi_link_dev(&disk->header, dev)) {
> -		efi_free_pool(disk->dp);
> -		efi_delete_handle(&disk->header);
> -
> -		return -1;
> -	}
>
>   	return 0;
>   }
> @@ -693,13 +690,34 @@ int efi_disk_probe(void *ctx, struct event *event)
>   	return 0;
>   }
>
> +static void get_disk_resources(efi_handle_t handle, struct efi_device_p=
ath **dp,
> +			       struct efi_block_io **blkio,
> +			       struct efi_simple_file_system_protocol **volume)
> +{
> +	efi_status_t ret;
> +	struct efi_handler *handler;
> +
> +	ret =3D efi_search_protocol(handle, &efi_guid_device_path, &handler);
> +	if (ret =3D=3D EFI_SUCCESS)
> +		*dp =3D handler->protocol_interface;
> +
> +	ret =3D efi_search_protocol(handle, &efi_block_io_guid, &handler);
> +	if (ret =3D=3D EFI_SUCCESS)
> +		*blkio =3D handler->protocol_interface;
> +
> +	ret =3D efi_search_protocol(handle, &efi_simple_file_system_protocol_g=
uid,
> +				  &handler);
> +	if (ret =3D=3D EFI_SUCCESS)
> +		*volume =3D handler->protocol_interface;
> +}
> +
>   /**
> - * efi_disk_remove - delete an efi_disk object for a block device or pa=
rtition
> + * efi_disk_remove - delete an efi handle for a block device or partiti=
on
>    *
>    * @ctx:	event context: driver binding protocol
>    * @event:	EV_PM_PRE_REMOVE event
>    *
> - * Delete an efi_disk object which is associated with the UCLASS_BLK or
> + * Delete an efi handle which is associated with the UCLASS_BLK or
>    * UCLASS_PARTITION device for which the EV_PM_PRE_REMOVE event is rai=
sed.
>    *
>    * Return:	0 on success, -1 otherwise
> @@ -710,8 +728,10 @@ int efi_disk_remove(void *ctx, struct event *event)
>   	struct udevice *dev =3D event->data.dm.dev;
>   	efi_handle_t handle;
>   	struct blk_desc *desc;
> -	struct efi_disk_obj *diskobj =3D NULL;
>   	efi_status_t ret;
> +	struct efi_device_path *dp =3D NULL;
> +	struct efi_block_io *blkio =3D NULL;
> +	struct efi_simple_file_system_protocol *volume =3D NULL;
>
>   	if (dev_tag_get_ptr(dev, DM_TAG_EFI, (void **)&handle))
>   		return 0;
> @@ -721,11 +741,11 @@ int efi_disk_remove(void *ctx, struct event *event=
)
>   	case UCLASS_BLK:
>   		desc =3D dev_get_uclass_plat(dev);
>   		if (desc && desc->uclass_id !=3D UCLASS_EFI_LOADER)
> -			diskobj =3D container_of(handle, struct efi_disk_obj,
> -					       header);
> +			get_disk_resources(handle, &dp, &blkio, &volume);
> +
>   		break;
>   	case UCLASS_PARTITION:
> -		diskobj =3D container_of(handle, struct efi_disk_obj, header);
> +		get_disk_resources(handle, &dp, &blkio, &volume);
>   		break;
>   	default:
>   		return 0;
> @@ -736,8 +756,11 @@ int efi_disk_remove(void *ctx, struct event *event)
>   	if (ret !=3D EFI_SUCCESS)
>   		return -1;
>
> -	if (diskobj)
> -		efi_free_pool(diskobj->dp);
> +	efi_free_pool(dp);
> +	if (blkio) {
> +		free(blkio->media);
> +		free(blkio);
> +	}
>
>   	dev_tag_del(dev, DM_TAG_EFI);
>

