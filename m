Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D4EC4828C
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 13:49:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C51887968;
	Thu,  1 Feb 2024 14:49:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SVS5LvcH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32496875B9; Thu,  1 Feb 2024 14:49:45 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94D5487C13
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 14:49:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5112cb6d1e7so1114080e87.0
 for <u-boot@lists.denx.de>; Thu, 01 Feb 2024 05:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1706795382; x=1707400182;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=F1E8Xdu0vkq8MjtwV2TFyz2NJsUnAfEcZbObt+BYsgo=;
 b=SVS5LvcHC9sWNdPTUXtixPq1DmqcHSUT92sjJl0T/NZqnojtDd2eQJvhq7qWj8iWw6
 pJEH3w1Hv7j7/Izya/B3GcW+YwJFxAZALQjAd+aYO6yYNo1Iue4Ux4v+GVtfCFs1YP3m
 JFhNe6PEYi33OcU5o1if4SJ1fNHeuRe8UaJkrCTYDvvJIXyw7ajq1D41FTxdlobeA9Gm
 V6Zi6XdlJouvtUukJIwFkrYq9HQ6z/E+AL5aqAiz3eJV2sgI5wSjjwqwsPD6kn800R2t
 s8i4dff5vy7oQ+xwLyOhkbhZcUqQk+f5grn9qmu5fAIu9ga0xJ9PSjY3M9txw1oOSy37
 5azA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706795382; x=1707400182;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F1E8Xdu0vkq8MjtwV2TFyz2NJsUnAfEcZbObt+BYsgo=;
 b=pozh5/AJ2ljk01Z/SpL3FvXIdmNH1bdQYY+fZyNFtYIjVyd15acJFk54V9ri8YXAdP
 3tj/mI8nCJNxZOaGryzfc7Zjk6nBPvAkxVYFA4T+kpn4DGzGFwyrm07zdCgNoiPj0mQS
 5FAUvx4hGRI0keV00ucXXo1yvcN/9tt3hIZgXZqopJzqBKNfFAGWF0clpJeZVmzYAu4/
 YvxBwTNBlZ1VlQJkBbn5AjtrD4jc0l6YmpmOrqZfJUHJkAAYj3UahDfjEpRoDtvdcGhK
 RK1Ok0/mUnL8BF9xfrPU5YT08/euSTbqPXft6dJSs7RkMEOz1NxTmJ3Cwp9CqGzYqQRT
 lhqg==
X-Gm-Message-State: AOJu0YzY+8hL5HTY/HQJ2mY6d/nTZ8DNk0I5bcjifk5FAUwKyjB6UVj/
 bPlRIa6WVm6Oike6E2UWor7y/rsRg1lAYsYdJpoqRilTRMKNODli2yVE9LXbkRo=
X-Google-Smtp-Source: AGHT+IH5HFTOUAzuQSFXMS0MiiTpy2L9VM4juq3mxNw6VqHALjpyBQACcPchrdSMrnF2UewgKdduQg==
X-Received: by 2002:a05:6512:3e13:b0:511:1fb0:1f71 with SMTP id
 i19-20020a0565123e1300b005111fb01f71mr2863384lfv.51.1706795381726; 
 Thu, 01 Feb 2024 05:49:41 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUYB/I/Le5nJ6gfOkoteuIrqYHzgxjwUNNUxKMN9DiRTqwZ2KogP0vLyXIzT5F6h+JFsKqXgnclNhcN5QWXJe0WnhgBY/duixjF8dhNGxr0TYD8sH0gWPLCYQpTkeAkB7ksRA3dKGhcWK8wRg/3x2+LcT/WT1zxTv7t8Wi6G2XXZcbyw8Xl6hx77QRIvSfUnNsTwg==
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 en8-20020a056000420800b0033940016d6esm12278762wrb.93.2024.02.01.05.49.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 05:49:41 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Caleb
 Connolly <caleb.connolly@linaro.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 4/5] usb: gadget: UMS: support multiple sector sizes
In-Reply-To: <20240131-b4-qcom-usb-v1-4-6438b2a2285e@linaro.org>
References: <20240131-b4-qcom-usb-v1-0-6438b2a2285e@linaro.org>
 <20240131-b4-qcom-usb-v1-4-6438b2a2285e@linaro.org>
Date: Thu, 01 Feb 2024 14:49:40 +0100
Message-ID: <878r44mgzv.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Caleb,

Thank you for the patch.

On mer., janv. 31, 2024 at 14:57, Caleb Connolly <caleb.connolly@linaro.org> wrote:

> UFS storage often uses a 4096-byte sector size, add support for dynamic
> sector sizes based loosely on the Linux implementation.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  cmd/usb_mass_storage.c              |   4 --
>  drivers/usb/gadget/f_mass_storage.c | 101 ++++++++++++++++++++----------------
>  drivers/usb/gadget/storage_common.c |  12 +++--
>  include/usb_mass_storage.h          |   1 -
>  4 files changed, 65 insertions(+), 53 deletions(-)
>
> diff --git a/cmd/usb_mass_storage.c b/cmd/usb_mass_storage.c
> index a8ddeb494628..751701fe73af 100644
> --- a/cmd/usb_mass_storage.c
> +++ b/cmd/usb_mass_storage.c
> @@ -88,10 +88,6 @@ static int ums_init(const char *devtype, const char *devnums_part_str)
>  		if (!strchr(devnum_part_str, ':'))
>  			partnum = 0;
>  
> -		/* f_mass_storage.c assumes SECTOR_SIZE sectors */
> -		if (block_dev->blksz != SECTOR_SIZE)
> -			goto cleanup;
> -
>  		ums_new = realloc(ums, (ums_count + 1) * sizeof(*ums));
>  		if (!ums_new)
>  			goto cleanup;
> diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mass_storage.c
> index c725aed3f626..d880928044f4 100644
> --- a/drivers/usb/gadget/f_mass_storage.c
> +++ b/drivers/usb/gadget/f_mass_storage.c
> @@ -724,12 +724,13 @@ static int do_read(struct fsg_common *common)
>  		curlun->sense_data = SS_LOGICAL_BLOCK_ADDRESS_OUT_OF_RANGE;
>  		return -EINVAL;
>  	}
> -	file_offset = ((loff_t) lba) << 9;
> +	file_offset = ((loff_t)lba) << curlun->blkbits;
>  
>  	/* Carry out the file reads */
>  	amount_left = common->data_size_from_cmnd;
> -	if (unlikely(amount_left == 0))
> +	if (unlikely(amount_left == 0)) {
>  		return -EIO;		/* No default reply */
> +	}
>  
>  	for (;;) {
>  
> @@ -768,13 +769,13 @@ static int do_read(struct fsg_common *common)
>  
>  		/* Perform the read */
>  		rc = ums[common->lun].read_sector(&ums[common->lun],
> -				      file_offset / SECTOR_SIZE,
> -				      amount / SECTOR_SIZE,
> +				      file_offset / curlun->blksize,
> +				      amount / curlun->blksize,
>  				      (char __user *)bh->buf);
>  		if (!rc)
>  			return -EIO;
>  
> -		nread = rc * SECTOR_SIZE;
> +		nread = rc * curlun->blksize;
>  
>  		VLDBG(curlun, "file read %u @ %llu -> %d\n", amount,
>  				(unsigned long long) file_offset,
> @@ -787,7 +788,7 @@ static int do_read(struct fsg_common *common)
>  		} else if (nread < amount) {
>  			LDBG(curlun, "partial file read: %d/%u\n",
>  					(int) nread, amount);
> -			nread -= (nread & 511);	/* Round down to a block */
> +			nread -= (nread & (curlun->blksize - 1));	/* Round down to a block */
>  		}
>  		file_offset  += nread;
>  		amount_left  -= nread;
> @@ -861,7 +862,7 @@ static int do_write(struct fsg_common *common)
>  
>  	/* Carry out the file writes */
>  	get_some_more = 1;
> -	file_offset = usb_offset = ((loff_t) lba) << 9;
> +	file_offset = usb_offset = ((loff_t)lba) << curlun->blkbits;
>  	amount_left_to_req = common->data_size_from_cmnd;
>  	amount_left_to_write = common->data_size_from_cmnd;
>  
> @@ -893,7 +894,7 @@ static int do_write(struct fsg_common *common)
>  				curlun->info_valid = 1;
>  				continue;
>  			}
> -			amount -= (amount & 511);
> +			amount -= (amount & (curlun->blksize - 1));
>  			if (amount == 0) {
>  
>  				/* Why were we were asked to transfer a
> @@ -942,12 +943,12 @@ static int do_write(struct fsg_common *common)
>  
>  			/* Perform the write */
>  			rc = ums[common->lun].write_sector(&ums[common->lun],
> -					       file_offset / SECTOR_SIZE,
> -					       amount / SECTOR_SIZE,
> +					       file_offset / curlun->blksize,
> +					       amount / curlun->blksize,
>  					       (char __user *)bh->buf);
>  			if (!rc)
>  				return -EIO;
> -			nwritten = rc * SECTOR_SIZE;
> +			nwritten = rc * curlun->blksize;
>  
>  			VLDBG(curlun, "file write %u @ %llu -> %d\n", amount,
>  					(unsigned long long) file_offset,
> @@ -960,7 +961,7 @@ static int do_write(struct fsg_common *common)
>  			} else if (nwritten < amount) {
>  				LDBG(curlun, "partial file write: %d/%u\n",
>  						(int) nwritten, amount);
> -				nwritten -= (nwritten & 511);
> +				nwritten -= (nwritten & (curlun->blksize - 1));
>  				/* Round down to a block */
>  			}
>  			file_offset += nwritten;
> @@ -1034,8 +1035,8 @@ static int do_verify(struct fsg_common *common)
>  		return -EIO;		/* No default reply */
>  
>  	/* Prepare to carry out the file verify */
> -	amount_left = verification_length << 9;
> -	file_offset = ((loff_t) lba) << 9;
> +	amount_left = verification_length << curlun->blkbits;
> +	file_offset = ((loff_t) lba) << curlun->blkbits;
>  
>  	/* Write out all the dirty buffers before invalidating them */
>  
> @@ -1058,12 +1059,12 @@ static int do_verify(struct fsg_common *common)
>  
>  		/* Perform the read */
>  		rc = ums[common->lun].read_sector(&ums[common->lun],
> -				      file_offset / SECTOR_SIZE,
> -				      amount / SECTOR_SIZE,
> +				      file_offset / curlun->blksize,
> +				      amount / curlun->blksize,
>  				      (char __user *)bh->buf);
>  		if (!rc)
>  			return -EIO;
> -		nread = rc * SECTOR_SIZE;
> +		nread = rc * curlun->blksize;
>  
>  		VLDBG(curlun, "file read %u @ %llu -> %d\n", amount,
>  				(unsigned long long) file_offset,
> @@ -1075,7 +1076,7 @@ static int do_verify(struct fsg_common *common)
>  		} else if (nread < amount) {
>  			LDBG(curlun, "partial file verify: %d/%u\n",
>  					(int) nread, amount);
> -			nread -= (nread & 511);	/* Round down to a sector */
> +			nread -= (nread & (curlun->blksize - 1));	/* Round down to a sector */
>  		}
>  		if (nread == 0) {
>  			curlun->sense_data = SS_UNRECOVERED_READ_ERROR;
> @@ -1183,7 +1184,7 @@ static int do_read_capacity(struct fsg_common *common, struct fsg_buffhd *bh)
>  
>  	put_unaligned_be32(curlun->num_sectors - 1, &buf[0]);
>  						/* Max logical block */
> -	put_unaligned_be32(512, &buf[4]);	/* Block length */
> +	put_unaligned_be32(curlun->blksize, &buf[4]);	/* Block length */
>  	return 8;
>  }
>  
> @@ -1370,7 +1371,7 @@ static int do_read_format_capacities(struct fsg_common *common,
>  
>  	put_unaligned_be32(curlun->num_sectors, &buf[0]);
>  						/* Number of blocks */
> -	put_unaligned_be32(512, &buf[4]);	/* Block length */
> +	put_unaligned_be32(curlun->blksize, &buf[4]);	/* Block length */
>  	buf[4] = 0x02;				/* Current capacity */
>  	return 12;
>  }
> @@ -1781,6 +1782,16 @@ static int check_command(struct fsg_common *common, int cmnd_size,
>  	return 0;
>  }
>  
> +/* wrapper of check_command for data size in blocks handling */
> +static int check_command_size_in_blocks(struct fsg_common *common,
> +		int cmnd_size, enum data_direction data_dir,
> +		unsigned int mask, int needs_medium, const char *name)
> +{
> +	common->data_size_from_cmnd <<= common->luns[common->lun].blkbits;
> +	return check_command(common, cmnd_size, data_dir,
> +			mask, needs_medium, name);
> +}
> +
>  
>  static int do_scsi_command(struct fsg_common *common)
>  {
> @@ -1865,30 +1876,30 @@ static int do_scsi_command(struct fsg_common *common)
>  
>  	case SC_READ_6:
>  		i = common->cmnd[4];
> -		common->data_size_from_cmnd = (i == 0 ? 256 : i) << 9;
> -		reply = check_command(common, 6, DATA_DIR_TO_HOST,
> -				      (7<<1) | (1<<4), 1,
> -				      "READ(6)");
> +		common->data_size_from_cmnd = (i == 0 ? 256 : i);
> +		reply = check_command_size_in_blocks(common, 6, DATA_DIR_TO_HOST,
> +						     (7<<1) | (1<<4), 1,
> +						     "READ(6)");
>  		if (reply == 0)
>  			reply = do_read(common);
>  		break;
>  
>  	case SC_READ_10:
>  		common->data_size_from_cmnd =
> -				get_unaligned_be16(&common->cmnd[7]) << 9;
> -		reply = check_command(common, 10, DATA_DIR_TO_HOST,
> -				      (1<<1) | (0xf<<2) | (3<<7), 1,
> -				      "READ(10)");
> +				get_unaligned_be16(&common->cmnd[7]);
> +		reply = check_command_size_in_blocks(common, 10, DATA_DIR_TO_HOST,
> +						     (1<<1) | (0xf<<2) | (3<<7), 1,
> +						     "READ(10)");
>  		if (reply == 0)
>  			reply = do_read(common);
>  		break;
>  
>  	case SC_READ_12:
>  		common->data_size_from_cmnd =
> -				get_unaligned_be32(&common->cmnd[6]) << 9;
> -		reply = check_command(common, 12, DATA_DIR_TO_HOST,
> -				      (1<<1) | (0xf<<2) | (0xf<<6), 1,
> -				      "READ(12)");
> +				get_unaligned_be32(&common->cmnd[6]);
> +		reply = check_command_size_in_blocks(common, 12, DATA_DIR_TO_HOST,
> +						     (1<<1) | (0xf<<2) | (0xf<<6), 1,
> +						     "READ(12)");
>  		if (reply == 0)
>  			reply = do_read(common);
>  		break;
> @@ -1983,30 +1994,30 @@ static int do_scsi_command(struct fsg_common *common)
>  
>  	case SC_WRITE_6:
>  		i = common->cmnd[4];
> -		common->data_size_from_cmnd = (i == 0 ? 256 : i) << 9;
> -		reply = check_command(common, 6, DATA_DIR_FROM_HOST,
> -				      (7<<1) | (1<<4), 1,
> -				      "WRITE(6)");
> +		common->data_size_from_cmnd = (i == 0 ? 256 : i);
> +		reply = check_command_size_in_blocks(common, 6, DATA_DIR_FROM_HOST,
> +						     (7<<1) | (1<<4), 1,
> +						     "WRITE(6)");
>  		if (reply == 0)
>  			reply = do_write(common);
>  		break;
>  
>  	case SC_WRITE_10:
>  		common->data_size_from_cmnd =
> -				get_unaligned_be16(&common->cmnd[7]) << 9;
> -		reply = check_command(common, 10, DATA_DIR_FROM_HOST,
> -				      (1<<1) | (0xf<<2) | (3<<7), 1,
> -				      "WRITE(10)");
> +				get_unaligned_be16(&common->cmnd[7]);
> +		reply = check_command_size_in_blocks(common, 10, DATA_DIR_FROM_HOST,
> +						     (1<<1) | (0xf<<2) | (3<<7), 1,
> +						     "WRITE(10)");
>  		if (reply == 0)
>  			reply = do_write(common);
>  		break;
>  
>  	case SC_WRITE_12:
>  		common->data_size_from_cmnd =
> -				get_unaligned_be32(&common->cmnd[6]) << 9;
> -		reply = check_command(common, 12, DATA_DIR_FROM_HOST,
> -				      (1<<1) | (0xf<<2) | (0xf<<6), 1,
> -				      "WRITE(12)");
> +				get_unaligned_be32(&common->cmnd[6]);
> +		reply = check_command_size_in_blocks(common, 12, DATA_DIR_FROM_HOST,
> +						     (1<<1) | (0xf<<2) | (0xf<<6), 1,
> +						     "WRITE(12)");
>  		if (reply == 0)
>  			reply = do_write(common);
>  		break;
> @@ -2497,7 +2508,7 @@ static struct fsg_common *fsg_common_init(struct fsg_common *common,
>  	for (i = 0; i < nluns; i++) {
>  		common->luns[i].removable = 1;
>  
> -		rc = fsg_lun_open(&common->luns[i], ums[i].num_sectors, "");
> +		rc = fsg_lun_open(&common->luns[i], ums[i].num_sectors, ums->block_dev.blksz, "");
>  		if (rc)
>  			goto error_luns;
>  	}
> diff --git a/drivers/usb/gadget/storage_common.c b/drivers/usb/gadget/storage_common.c
> index 5674e8fe4940..97dc6b6f729c 100644
> --- a/drivers/usb/gadget/storage_common.c
> +++ b/drivers/usb/gadget/storage_common.c
> @@ -269,6 +269,7 @@ struct device_attribute { int i; };
>  #define ETOOSMALL	525
>  
>  #include <log.h>
> +#include <linux/log2.h>
>  #include <usb_mass_storage.h>
>  #include <dm/device_compat.h>
>  
> @@ -290,6 +291,8 @@ struct fsg_lun {
>  	u32		sense_data;
>  	u32		sense_data_info;
>  	u32		unit_attention_data;
> +	unsigned int	blkbits;
> +	unsigned int	blksize; /* logical block size of bound block device */
>  
>  	struct device	dev;
>  };
> @@ -566,7 +569,7 @@ static struct usb_gadget_strings	fsg_stringtab = {
>   */
>  
>  static int fsg_lun_open(struct fsg_lun *curlun, unsigned int num_sectors,
> -			const char *filename)
> +			unsigned int sector_size, const char *filename)
>  {
>  	int				ro;
>  
> @@ -574,9 +577,12 @@ static int fsg_lun_open(struct fsg_lun *curlun, unsigned int num_sectors,
>  	ro = curlun->initially_ro;
>  
>  	curlun->ro = ro;
> -	curlun->file_length = num_sectors << 9;
> +	curlun->file_length = num_sectors * sector_size;
>  	curlun->num_sectors = num_sectors;
> -	debug("open backing file: %s\n", filename);
> +	curlun->blksize = sector_size;
> +	curlun->blkbits = order_base_2(sector_size >> 9) + 9;
> +	debug("blksize: %u\n", sector_size);
> +	debug("open backing file: '%s'\n", filename);
>  
>  	return 0;
>  }
> diff --git a/include/usb_mass_storage.h b/include/usb_mass_storage.h
> index 83ab93b530d7..6d83d93cad7f 100644
> --- a/include/usb_mass_storage.h
> +++ b/include/usb_mass_storage.h
> @@ -7,7 +7,6 @@
>  #ifndef __USB_MASS_STORAGE_H__
>  #define __USB_MASS_STORAGE_H__
>  
> -#define SECTOR_SIZE		0x200
>  #include <part.h>
>  #include <linux/usb/composite.h>
>  
>
> -- 
> 2.43.0
