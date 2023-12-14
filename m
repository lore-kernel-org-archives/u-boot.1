Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7454EC4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 01:24:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 408248797D;
	Thu, 14 Dec 2023 02:24:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hDx/mKD1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C92C387863; Thu, 14 Dec 2023 02:24:37 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB38687979
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 02:24:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d1cb7651a9so15406815ad.1
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 17:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702517073; x=1703121873; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jkHVq18ZwYV+cH06F5C0NEiEtxBNxWQxkSHN1cs5JQI=;
 b=hDx/mKD1Fzlc2HXZ+lbsrDl0jbYsA2Ntu1GZIvIvyRmeH2iIqjUHobaBPoyvzyYOMR
 rhivFYY8UFeR39RYwgnBClgluRqv/oeHz9kannwdEN/73fOgAl+Vq+fxYGG55EFThHVb
 T+D4qUrjzfO77xmFZ/hh4oIl1IOYNcLAH1szBRaS7iWN6313GIJV+mRu7OWpyDv2/lYE
 j9c10CSkUewoB47Rj/9ur/jm51k6Rfdj1D+VKHmqcY1sHhNxv3MzjYZlL4cAcGzhR/tK
 yX/UELPHarzvoNxNMbfkK9ofxuHcbKYCZavTIHZsxhRnajRVEVK+GKi/c/Ln0OSV/Bq6
 teSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702517073; x=1703121873;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jkHVq18ZwYV+cH06F5C0NEiEtxBNxWQxkSHN1cs5JQI=;
 b=A62/OL7Y/F53tWJs9hS2NSt0MXSC8OHwawHoYQ8n2pTUn+jf0jJnjcqE5hhmnzdaL2
 2lJbSWFr7gN68IWzg/NPU7u8OtmtcNBHTElumCHsSZF1mkbRxVg3ap0s+IaaLLz+6rZU
 WlIYJAOkboN8zWapCBXD7vzeTu6X48Mr0g+hiYyDfhgqEH7x0K7qovaqoplXlFFdnr0w
 IYxLr2h7tYp1NT9S/2YnvupsjJ1Q55APHEHA7V+VrjfTjsQpMUg2bfUBEjvlC0IBZmsP
 68Wamz6Zoxl/mDl9BqvAXPPcR1jEjRMHFe86OjXyzVcb4QbUgnRzvUKKUdBMWFoU3ukK
 StLw==
X-Gm-Message-State: AOJu0YzswvJOSNgTQFfBRvV/+NDS6FDxyF9jfiMj/2u9kn1nzNJGmsBl
 6t62bOiYNMNpNUWO086RuH0cgw==
X-Google-Smtp-Source: AGHT+IGlkIAy2NFh79yLxOBRREBYoneWFmREn9ExB1A09BJLvzkWJavIQu6iTlVXFO5gDV5+Jba1vw==
X-Received: by 2002:a17:902:8a88:b0:1d0:8f0d:b6e0 with SMTP id
 p8-20020a1709028a8800b001d08f0db6e0mr17313930plo.1.1702517072677; 
 Wed, 13 Dec 2023 17:24:32 -0800 (PST)
Received: from octopus ([2400:4050:c3e1:100:4bd4:12c2:e27f:b688])
 by smtp.gmail.com with ESMTPSA id
 u15-20020a17090341cf00b001cf5d4f8f26sm11189965ple.248.2023.12.13.17.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Dec 2023 17:24:32 -0800 (PST)
Date: Thu, 14 Dec 2023 10:24:28 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] efi_loader: eliminate efi_disk_obj structure
Message-ID: <ZXpZTCR8FCHlNrSG@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20231213085737.299773-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213085737.299773-1-masahisa.kojima@linaro.org>
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

Hi Kojima-san,

On Wed, Dec 13, 2023 at 05:57:37PM +0900, Masahisa Kojima wrote:
> Current code uses struct efi_disk_obj to keep information
> about block devices and partitions. As the efi handle already
> has a field with the udevice, we should eliminate
> struct efi_disk_obj and use an pointer to struct efi_object
> for the handle.

I don't still understand what is an advantage of your approach.

> efi_link_dev() call is moved inside of efi_disk_add_dev() function
> to simplify the cleanup process in case of error.
> 
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---
>  lib/efi_loader/efi_disk.c | 209 +++++++++++++++++++++-----------------
>  1 file changed, 116 insertions(+), 93 deletions(-)
> 
> diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> index f0d76113b0..cfb7ace551 100644
> --- a/lib/efi_loader/efi_disk.c
> +++ b/lib/efi_loader/efi_disk.c
> @@ -27,27 +27,24 @@ struct efi_system_partition efi_system_partition = {
>  const efi_guid_t efi_block_io_guid = EFI_BLOCK_IO_PROTOCOL_GUID;
>  const efi_guid_t efi_system_partition_guid = PARTITION_SYSTEM_GUID;
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

This is a handy way of making it ease to dereference from an internal
structure to an external reference as Heinrich mentioned.

> -	struct efi_block_io ops;

Along with "header" and "media", this allows us to congregate
a couple of "malloc" calls, instead of your change, into one.

> -	int dev_index;
> -	struct efi_device_path *dp;
> -	unsigned int part;
> -	struct efi_simple_file_system_protocol *volume;

If we carefully look into the base code, we will no longer have to
have those fields in this structure because they are mostly used in
a single internal function (if I'm correct).
So we can simply replace them with local variables (with some extra
changes).

-Takahiro Akashi

> -};
> +static efi_handle_t efi_blkio_find_obj(struct efi_block_io *blkio)
> +{
> +	efi_handle_t handle;
> +
> +	list_for_each_entry(handle, &efi_obj_list, link) {
> +		efi_status_t ret;
> +		struct efi_handler *handler;
> +
> +		ret = efi_search_protocol(handle, &efi_block_io_guid, &handler);
> +		if (ret != EFI_SUCCESS)
> +			continue;
> +
> +		if (blkio == handler->protocol_interface)
> +			return handle;
> +	}
> +
> +	return NULL;
> +}
>  
>  /**
>   * efi_disk_reset() - reset block device
> @@ -107,13 +104,16 @@ static efi_status_t efi_disk_rw_blocks(struct efi_block_io *this,
>  			u32 media_id, u64 lba, unsigned long buffer_size,
>  			void *buffer, enum efi_disk_direction direction)
>  {
> -	struct efi_disk_obj *diskobj;
> +	efi_handle_t handle;
>  	int blksz;
>  	int blocks;
>  	unsigned long n;
>  
> -	diskobj = container_of(this, struct efi_disk_obj, ops);
> -	blksz = diskobj->media.block_size;
> +	handle = efi_blkio_find_obj(this);
> +	if (!handle)
> +		return EFI_INVALID_PARAMETER;
> +
> +	blksz = this->media->block_size;
>  	blocks = buffer_size / blksz;
>  
>  	EFI_PRINT("blocks=%x lba=%llx blksz=%x dir=%d\n",
> @@ -124,18 +124,16 @@ static efi_status_t efi_disk_rw_blocks(struct efi_block_io *this,
>  		return EFI_BAD_BUFFER_SIZE;
>  
>  	if (CONFIG_IS_ENABLED(PARTITIONS) &&
> -	    device_get_uclass_id(diskobj->header.dev) == UCLASS_PARTITION) {
> +	    device_get_uclass_id(handle->dev) == UCLASS_PARTITION) {
>  		if (direction == EFI_DISK_READ)
> -			n = disk_blk_read(diskobj->header.dev, lba, blocks,
> -					  buffer);
> +			n = disk_blk_read(handle->dev, lba, blocks, buffer);
>  		else
> -			n = disk_blk_write(diskobj->header.dev, lba, blocks,
> -					   buffer);
> +			n = disk_blk_write(handle->dev, lba, blocks, buffer);
>  	} else {
>  		/* dev is a block device (UCLASS_BLK) */
>  		struct blk_desc *desc;
>  
> -		desc = dev_get_uclass_plat(diskobj->header.dev);
> +		desc = dev_get_uclass_plat(handle->dev);
>  		if (direction == EFI_DISK_READ)
>  			n = blk_dread(desc, lba, blocks, buffer);
>  		else
> @@ -388,6 +386,7 @@ static int efi_fs_exists(struct blk_desc *desc, int part)
>   * @part:		partition
>   * @disk:		pointer to receive the created handle
>   * @agent_handle:	handle of the EFI block driver
> + * @dev:		pointer to udevice
>   * Return:		disk object
>   */
>  static efi_status_t efi_disk_add_dev(
> @@ -397,24 +396,33 @@ static efi_status_t efi_disk_add_dev(
>  				int dev_index,
>  				struct disk_partition *part_info,
>  				unsigned int part,
> -				struct efi_disk_obj **disk,
> -				efi_handle_t agent_handle)
> +				efi_handle_t *disk,
> +				efi_handle_t agent_handle,
> +				struct udevice *dev)
>  {
> -	struct efi_disk_obj *diskobj;
> -	struct efi_object *handle;
> +	efi_handle_t handle;
>  	const efi_guid_t *esp_guid = NULL;
>  	efi_status_t ret;
> +	struct efi_block_io *blkio;
> +	struct efi_block_io_media *media;
> +	struct efi_device_path *dp = NULL;
> +	struct efi_simple_file_system_protocol *volume = NULL;
>  
>  	/* Don't add empty devices */
>  	if (!desc->lba)
>  		return EFI_NOT_READY;
>  
> -	diskobj = calloc(1, sizeof(*diskobj));
> -	if (!diskobj)
> +	ret = efi_create_handle(&handle);
> +	if (ret != EFI_SUCCESS)
> +		return ret;
> +
> +	blkio = calloc(1, sizeof(*blkio));
> +	media = calloc(1, sizeof(*media));
> +	if (!blkio || !media)
>  		return EFI_OUT_OF_RESOURCES;
>  
> -	/* Hook up to the device list */
> -	efi_add_handle(&diskobj->header);
> +	*blkio = block_io_disk_template;
> +	blkio->media = media;
>  
>  	/* Fill in object data */
>  	if (part_info) {
> @@ -440,23 +448,22 @@ static efi_status_t efi_disk_add_dev(
>  		 * (controller).
>  		 */
>  		ret = efi_protocol_open(handler, &protocol_interface, NULL,
> -					&diskobj->header,
> +					handle,
>  					EFI_OPEN_PROTOCOL_BY_CHILD_CONTROLLER);
>  		if (ret != EFI_SUCCESS) {
>  			log_debug("prot open failed\n");
>  			goto error;
>  		}
>  
> -		diskobj->dp = efi_dp_append_node(dp_parent, node);
> +		dp = efi_dp_append_node(dp_parent, node);
>  		efi_free_pool(node);
> -		diskobj->media.last_block = part_info->size - 1;
> +		blkio->media->last_block = part_info->size - 1;
>  		if (part_info->bootable & PART_EFI_SYSTEM_PARTITION)
>  			esp_guid = &efi_system_partition_guid;
>  	} else {
> -		diskobj->dp = efi_dp_from_part(desc, part);
> -		diskobj->media.last_block = desc->lba - 1;
> +		dp = efi_dp_from_part(desc, part);
> +		blkio->media->last_block = desc->lba - 1;
>  	}
> -	diskobj->part = part;
>  
>  	/*
>  	 * Install the device path and the block IO protocol.
> @@ -465,11 +472,10 @@ static efi_status_t efi_disk_add_dev(
>  	 * already installed on an other handle and returns EFI_ALREADY_STARTED
>  	 * in this case.
>  	 */
> -	handle = &diskobj->header;
>  	ret = efi_install_multiple_protocol_interfaces(
>  					&handle,
> -					&efi_guid_device_path, diskobj->dp,
> -					&efi_block_io_guid, &diskobj->ops,
> +					&efi_guid_device_path, dp,
> +					&efi_block_io_guid, blkio,
>  					/*
>  					 * esp_guid must be last entry as it
>  					 * can be NULL. Its interface is NULL.
> @@ -487,43 +493,39 @@ static efi_status_t efi_disk_add_dev(
>  	 */
>  	if ((part || desc->part_type == PART_TYPE_UNKNOWN) &&
>  	    efi_fs_exists(desc, part)) {
> -		ret = efi_create_simple_file_system(desc, part, diskobj->dp,
> -						    &diskobj->volume);
> +		ret = efi_create_simple_file_system(desc, part, dp, &volume);
>  		if (ret != EFI_SUCCESS)
>  			goto error;
>  
> -		ret = efi_add_protocol(&diskobj->header,
> +		ret = efi_add_protocol(handle,
>  				       &efi_simple_file_system_protocol_guid,
> -				       diskobj->volume);
> +				       volume);
>  		if (ret != EFI_SUCCESS)
>  			goto error;
>  	}
> -	diskobj->ops = block_io_disk_template;
> -	diskobj->dev_index = dev_index;
>  
>  	/* Fill in EFI IO Media info (for read/write callbacks) */
> -	diskobj->media.removable_media = desc->removable;
> -	diskobj->media.media_present = 1;
> +	blkio->media->removable_media = desc->removable;
> +	blkio->media->media_present = 1;
>  	/*
>  	 * MediaID is just an arbitrary counter.
>  	 * We have to change it if the medium is removed or changed.
>  	 */
> -	diskobj->media.media_id = 1;
> -	diskobj->media.block_size = desc->blksz;
> -	diskobj->media.io_align = desc->blksz;
> +	blkio->media->media_id = 1;
> +	blkio->media->block_size = desc->blksz;
> +	blkio->media->io_align = desc->blksz;
>  	if (part)
> -		diskobj->media.logical_partition = 1;
> -	diskobj->ops.media = &diskobj->media;
> +		blkio->media->logical_partition = 1;
>  	if (disk)
> -		*disk = diskobj;
> +		*disk = handle;
>  
>  	EFI_PRINT("BlockIO: part %u, present %d, logical %d, removable %d"
>  		  ", last_block %llu\n",
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
>  	/* Store first EFI system partition */
>  	if (part && efi_system_partition.uclass_id == UCLASS_INVALID) {
> @@ -536,11 +538,18 @@ static efi_status_t efi_disk_add_dev(
>  				  desc->devnum, part);
>  		}
>  	}
> +
> +	if (efi_link_dev(handle, dev))
> +		goto error;
> +
>  	return EFI_SUCCESS;
>  error:
> -	efi_delete_handle(&diskobj->header);
> -	free(diskobj->volume);
> -	free(diskobj);
> +	efi_delete_handle(handle);
> +	efi_free_pool(dp);
> +	free(blkio);
> +	free(media);
> +	free(volume);
> +
>  	return ret;
>  }
>  
> @@ -557,7 +566,7 @@ error:
>   */
>  static int efi_disk_create_raw(struct udevice *dev, efi_handle_t agent_handle)
>  {
> -	struct efi_disk_obj *disk;
> +	efi_handle_t disk;
>  	struct blk_desc *desc;
>  	int diskid;
>  	efi_status_t ret;
> @@ -566,7 +575,7 @@ static int efi_disk_create_raw(struct udevice *dev, efi_handle_t agent_handle)
>  	diskid = desc->devnum;
>  
>  	ret = efi_disk_add_dev(NULL, NULL, desc,
> -			       diskid, NULL, 0, &disk, agent_handle);
> +			       diskid, NULL, 0, &disk, agent_handle, dev);
>  	if (ret != EFI_SUCCESS) {
>  		if (ret == EFI_NOT_READY) {
>  			log_notice("Disk %s not ready\n", dev->name);
> @@ -578,12 +587,6 @@ static int efi_disk_create_raw(struct udevice *dev, efi_handle_t agent_handle)
>  
>  		return ret;
>  	}
> -	if (efi_link_dev(&disk->header, dev)) {
> -		efi_free_pool(disk->dp);
> -		efi_delete_handle(&disk->header);
> -
> -		return -EINVAL;
> -	}
>  
>  	return 0;
>  }
> @@ -609,7 +612,7 @@ static int efi_disk_create_part(struct udevice *dev, efi_handle_t agent_handle)
>  	int diskid;
>  	struct efi_handler *handler;
>  	struct efi_device_path *dp_parent;
> -	struct efi_disk_obj *disk;
> +	efi_handle_t disk;
>  	efi_status_t ret;
>  
>  	if (dev_tag_get_ptr(dev_get_parent(dev), DM_TAG_EFI, (void **)&parent))
> @@ -628,17 +631,11 @@ static int efi_disk_create_part(struct udevice *dev, efi_handle_t agent_handle)
>  	dp_parent = (struct efi_device_path *)handler->protocol_interface;
>  
>  	ret = efi_disk_add_dev(parent, dp_parent, desc, diskid,
> -			       info, part, &disk, agent_handle);
> +			       info, part, &disk, agent_handle, dev);
>  	if (ret != EFI_SUCCESS) {
>  		log_err("Adding partition for %s failed\n", dev->name);
>  		return -1;
>  	}
> -	if (efi_link_dev(&disk->header, dev)) {
> -		efi_free_pool(disk->dp);
> -		efi_delete_handle(&disk->header);
> -
> -		return -1;
> -	}
>  
>  	return 0;
>  }
> @@ -693,13 +690,34 @@ int efi_disk_probe(void *ctx, struct event *event)
>  	return 0;
>  }
>  
> +static void get_disk_resources(efi_handle_t handle, struct efi_device_path **dp,
> +			       struct efi_block_io **blkio,
> +			       struct efi_simple_file_system_protocol **volume)
> +{
> +	efi_status_t ret;
> +	struct efi_handler *handler;
> +
> +	ret = efi_search_protocol(handle, &efi_guid_device_path, &handler);
> +	if (ret == EFI_SUCCESS)
> +		*dp = handler->protocol_interface;
> +
> +	ret = efi_search_protocol(handle, &efi_block_io_guid, &handler);
> +	if (ret == EFI_SUCCESS)
> +		*blkio = handler->protocol_interface;
> +
> +	ret = efi_search_protocol(handle, &efi_simple_file_system_protocol_guid,
> +				  &handler);
> +	if (ret == EFI_SUCCESS)
> +		*volume = handler->protocol_interface;
> +}
> +
>  /**
> - * efi_disk_remove - delete an efi_disk object for a block device or partition
> + * efi_disk_remove - delete an efi handle for a block device or partition
>   *
>   * @ctx:	event context: driver binding protocol
>   * @event:	EV_PM_PRE_REMOVE event
>   *
> - * Delete an efi_disk object which is associated with the UCLASS_BLK or
> + * Delete an efi handle which is associated with the UCLASS_BLK or
>   * UCLASS_PARTITION device for which the EV_PM_PRE_REMOVE event is raised.
>   *
>   * Return:	0 on success, -1 otherwise
> @@ -710,8 +728,10 @@ int efi_disk_remove(void *ctx, struct event *event)
>  	struct udevice *dev = event->data.dm.dev;
>  	efi_handle_t handle;
>  	struct blk_desc *desc;
> -	struct efi_disk_obj *diskobj = NULL;
>  	efi_status_t ret;
> +	struct efi_device_path *dp = NULL;
> +	struct efi_block_io *blkio = NULL;
> +	struct efi_simple_file_system_protocol *volume = NULL;
>  
>  	if (dev_tag_get_ptr(dev, DM_TAG_EFI, (void **)&handle))
>  		return 0;
> @@ -721,11 +741,11 @@ int efi_disk_remove(void *ctx, struct event *event)
>  	case UCLASS_BLK:
>  		desc = dev_get_uclass_plat(dev);
>  		if (desc && desc->uclass_id != UCLASS_EFI_LOADER)
> -			diskobj = container_of(handle, struct efi_disk_obj,
> -					       header);
> +			get_disk_resources(handle, &dp, &blkio, &volume);
> +
>  		break;
>  	case UCLASS_PARTITION:
> -		diskobj = container_of(handle, struct efi_disk_obj, header);
> +		get_disk_resources(handle, &dp, &blkio, &volume);
>  		break;
>  	default:
>  		return 0;
> @@ -736,8 +756,11 @@ int efi_disk_remove(void *ctx, struct event *event)
>  	if (ret != EFI_SUCCESS)
>  		return -1;
>  
> -	if (diskobj)
> -		efi_free_pool(diskobj->dp);
> +	efi_free_pool(dp);
> +	if (blkio) {
> +		free(blkio->media);
> +		free(blkio);
> +	}
>  
>  	dev_tag_del(dev, DM_TAG_EFI);
>  
> -- 
> 2.34.1
> 
