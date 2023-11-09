Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B6FC4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 10:05:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 775AB87113;
	Thu,  9 Nov 2023 11:05:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1UQz73Fy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39C1187120; Thu,  9 Nov 2023 11:05:04 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13BBD870BE
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 11:05:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-507a62d4788so872188e87.0
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 02:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699524300; x=1700129100;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=jX4wQdHpBuxhJLM1EV7R1x6uUIqMZMcaeLb7wKpYpo4=;
 b=1UQz73FyWGxXQtpQ5sEaH010zRjMtIyk6xb0G4Z0YRKtBStVJX0kz6mqMOViMzRhjZ
 rMYIy+tYEP0JSVDu8SaMBNhKS6a/OVFsasotFCEn8UEEiP1+AsX2tj9oUN96bYT965T+
 SVgsPCWaMLTuL6R4mf/vhOzQD67AtWkTpf03sgqJHple6rOhLqJA+xv2FJRRCfHhoYsG
 Qpg0e6YMNpa5wy5tivlD3zQV66A5bEt4BWCGhsorQ6P7/q/rNLsoBN6Ul4vNdR0PJY5h
 /T6eiOnGYaJfwbCixV7thXxQt2GasXNX4lmCLp+q5rsJ5AdGBhcsazJpG897kTloSzMy
 Jl7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699524300; x=1700129100;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jX4wQdHpBuxhJLM1EV7R1x6uUIqMZMcaeLb7wKpYpo4=;
 b=jpRzWXUH3tQTrqPfjVc12e2GVls7AWfIEZNM3dsnW+OesVr2VZk0QU/2T4t6XvrXcx
 unI7DQ2JiZut963+qqQ5P0qdbxeeMCu4deoU8fGbt96Ix8Eai4CxBx4y9Y1HVoBkA3kt
 6Knzwd7HbBEYcbEpiG1wqRVzAiyGprQq0GRZzGD4splp4jqh/6HbRi0htarVl2xeObfY
 WWljSYQAUBjWPDwwpy0HMWlpySc4Yw8eMpJecpcrmFLpDJTlDsBvd4eFx0qjnC2mk40K
 96f7d+eJF3Wg58EDfuFgS9t2Llj2jC+axwYHzdmDCkCtwpNFflVJzJAERF98oN75ZBKz
 Ie0Q==
X-Gm-Message-State: AOJu0YxjR/kzvkCDMYxEmZnG4lkudjxemoHqzpz9lWVYV2yFXOvtTwSH
 1L5Y/vGGNkQlGqFmeaPeR/V95Q==
X-Google-Smtp-Source: AGHT+IGz0Q49+t5FmZXiSTFpUP6ZR78CcThjetlF4+uMyTebEY5YOSm7zJREPC05NgvGzMosjEE49Q==
X-Received: by 2002:a05:6512:2529:b0:509:7301:5738 with SMTP id
 be41-20020a056512252900b0050973015738mr1403657lfb.62.1699524300207; 
 Thu, 09 Nov 2023 02:05:00 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 a15-20020a5d456f000000b0032fab28e9c9sm7026260wrc.73.2023.11.09.02.04.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 02:04:59 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Dmitrii Merkurev <dimorinny@google.com>, u-boot@lists.denx.de
Cc: rammuthiah@google.com, Dmitrii Merkurev <dimorinny@google.com>, Cody
 Schuffelen <schuffelen@google.com>, Eugeniu Rosca <erosca@de.adit-jv.com>,
 Ying-Chun Liu <paul.liu@linaro.org>, Simon Glass <sjg@chromium.org>, Sean
 Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH 2/2] cmd: bcb: extend BCB C API to allow read/write the
 fields
In-Reply-To: <20231109003634.577152-3-dimorinny@google.com>
References: <20231109003634.577152-1-dimorinny@google.com>
 <20231109003634.577152-3-dimorinny@google.com>
Date: Thu, 09 Nov 2023 11:04:58 +0100
Message-ID: <877cmr9r91.fsf@baylibre.com>
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

Hi Dmitrii,

Thank you for your patch.

On jeu., nov. 09, 2023 at 00:36, Dmitrii Merkurev <dimorinny@google.com> wrote:

> Currently BCB C API only allows to modify 'command' BCB field.
> Extend it so that we can also read and modify all the available
> BCB fields (command, status, recovery, stage).
>
> Co-developed-by: Cody Schuffelen <schuffelen@google.com>
> Signed-off-by: Cody Schuffelen <schuffelen@google.com>
> Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
> Cc: Eugeniu Rosca <erosca@de.adit-jv.com>
> Cc: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Sean Anderson <sean.anderson@seco.com>
> Cc: Cody Schuffelen <schuffelen@google.com>

I could test this after applying the diffs from:
https://lore.kernel.org/all/87a5rn9sdm.fsf@baylibre.com/

I tested with:
$ fastboot reboot bootloader
=> bcb load mmc 2 misc
=> bcb dump command

I also tested
=> bcb set status hello
=> bcb dump status

Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # on vim3

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Some small nitpicks below.
The nitpick do not have to be adressed if you don't want to.

> ---
>  cmd/bcb.c                    | 162 +++++++++++++++++++++++------------
>  drivers/fastboot/fb_common.c |  14 ++-
>  include/bcb.h                |  60 ++++++++++++-
>  3 files changed, 179 insertions(+), 57 deletions(-)
>
> diff --git a/cmd/bcb.c b/cmd/bcb.c
> index 5d8c232663..7a77b7f7b0 100644
> --- a/cmd/bcb.c
> +++ b/cmd/bcb.c
> @@ -25,10 +25,18 @@ enum bcb_cmd {
>  	BCB_CMD_STORE,
>  };
>  
> -static enum uclass_id bcb_uclass_id = UCLASS_INVALID;
> -static int bcb_dev = -1;
> -static int bcb_part = -1;
> +static const char * const fields[] = {
> +	"command",
> +	"status",
> +	"recovery",
> +	"stage"
> +};
> +
>  static struct bootloader_message bcb __aligned(ARCH_DMA_MINALIGN) = { { 0 } };
> +static struct disk_partition partition_data;
> +
> +static struct blk_desc *block;
> +static struct disk_partition *partition = &partition_data;
>  
>  static int bcb_cmd_get(char *cmd)
>  {
> @@ -82,7 +90,7 @@ static int bcb_is_misused(int argc, char *const argv[])
>  		return -1;
>  	}
>  
> -	if (cmd != BCB_CMD_LOAD && (bcb_dev < 0 || bcb_part < 0)) {
> +	if (cmd != BCB_CMD_LOAD && !block) {
>  		printf("Error: Please, load BCB first!\n");
>  		return -1;
>  	}
> @@ -94,7 +102,7 @@ err:
>  	return -1;
>  }
>  
> -static int bcb_field_get(char *name, char **fieldp, int *sizep)
> +static int bcb_field_get(const char *name, char **fieldp, int *sizep)
>  {
>  	if (!strcmp(name, "command")) {
>  		*fieldp = bcb.command;
> @@ -119,16 +127,21 @@ static int bcb_field_get(char *name, char **fieldp, int *sizep)
>  	return 0;
>  }
>  
> -static int __bcb_load(const char *iface, int devnum, const char *partp)
> +static void __bcb_reset(void)
> +{
> +	block = NULL;
> +	partition = &partition_data;
> +	memset(&partition_data, 0, sizeof(struct disk_partition));
> +	memset(&bcb, 0, sizeof(struct bootloader_message));
> +}
> +
> +static int __bcb_initialize(const char *iface, int devnum, const char *partp)
>  {
> -	struct blk_desc *desc;
> -	struct disk_partition info;
> -	u64 cnt;
>  	char *endp;
>  	int part, ret;
>  
> -	desc = blk_get_dev(iface, devnum);
> -	if (!desc) {
> +	block = blk_get_dev(iface, devnum);
> +	if (!block) {
>  		ret = -ENODEV;
>  		goto err_read_fail;
>  	}
> @@ -137,7 +150,7 @@ static int __bcb_load(const char *iface, int devnum, const char *partp)
>  	 * always select the first hwpart in case another
>  	 * blk operation selected a different hwpart
>  	 */
> -	ret = blk_dselect_hwpart(desc, 0);
> +	ret = blk_dselect_hwpart(block, 0);
>  	if (IS_ERR_VALUE(ret)) {
>  		ret = -ENODEV;
>  		goto err_read_fail;
> @@ -145,49 +158,63 @@ static int __bcb_load(const char *iface, int devnum, const char *partp)
>  
>  	part = simple_strtoul(partp, &endp, 0);
>  	if (*endp == '\0') {
> -		ret = part_get_info(desc, part, &info);
> +		ret = part_get_info(block, part, partition);
>  		if (ret)
>  			goto err_read_fail;
>  	} else {
> -		part = part_get_info_by_name(desc, partp, &info);
> +		part = part_get_info_by_name(block, partp, partition);
>  		if (part < 0) {
>  			ret = part;
>  			goto err_read_fail;
>  		}
>  	}
>  
> -	cnt = DIV_ROUND_UP(sizeof(struct bootloader_message), info.blksz);
> -	if (cnt > info.size)
> +	return CMD_RET_SUCCESS;
> +
> +err_read_fail:
> +	printf("Error: %d %d:%s read failed (%d)\n", block->uclass_id,
> +	       block->devnum, partition->name, ret);
> +	goto err;

Nitpick: No need for this goto, we can just fall-through.

> +err:
> +	__bcb_reset();
> +	return CMD_RET_FAILURE;
> +}
> +
> +static int __bcb_load(void)
> +{
> +	u64 cnt;
> +	int ret;
> +
> +	cnt = DIV_ROUND_UP(sizeof(struct bootloader_message), partition->blksz);
> +	if (cnt > partition->size)
>  		goto err_too_small;
>  
> -	if (blk_dread(desc, info.start, cnt, &bcb) != cnt) {
> +	if (blk_dread(block, partition->start, cnt, &bcb) != cnt) {
>  		ret = -EIO;
>  		goto err_read_fail;
>  	}
>  
> -	bcb_uclass_id = desc->uclass_id;
> -	bcb_dev = desc->devnum;
> -	bcb_part = part;
> -	debug("%s: Loaded from %s %d:%d\n", __func__, iface, bcb_dev, bcb_part);
> +	debug("%s: Loaded from %d %d:%s\n", __func__, block->uclass_id,
> +	      block->devnum, partition->name);
>  
>  	return CMD_RET_SUCCESS;
>  err_read_fail:
> -	printf("Error: %s %d:%s read failed (%d)\n", iface, devnum, partp, ret);
> +	printf("Error: %d %d:%s read failed (%d)\n", block->uclass_id,
> +	       block->devnum, partition->name, ret);
>  	goto err;
>  err_too_small:
> -	printf("Error: %s %d:%s too small!", iface, devnum, partp);
> +	printf("Error: %d %d:%s too small!", block->uclass_id,
> +	       block->devnum, partition->name);
>  	goto err;
>  err:
> -	bcb_uclass_id = UCLASS_INVALID;
> -	bcb_dev = -1;
> -	bcb_part = -1;
> -
> +	__bcb_reset();

Nitpick: __bcb_reset() introduction could have been done in a separate patch

>  	return CMD_RET_FAILURE;
>  }
>  
>  static int do_bcb_load(struct cmd_tbl *cmdtp, int flag, int argc,
>  		       char * const argv[])
>  {
> +	int ret;
>  	int devnum;
>  	char *endp;
>  	char *iface = "mcc";
> @@ -204,10 +231,14 @@ static int do_bcb_load(struct cmd_tbl *cmdtp, int flag, int argc,
>  		return CMD_RET_FAILURE;
>  	}
>  
> -	return __bcb_load(iface, devnum, argv[2]);
> +	ret = __bcb_initialize(iface, devnum, argv[2]);
> +	if (ret != CMD_RET_SUCCESS)
> +		return ret;
> +
> +	return __bcb_load();
>  }
>  
> -static int __bcb_set(char *fieldp, const char *valp)
> +static int __bcb_set(const char *fieldp, const char *valp)
>  {
>  	int size, len;
>  	char *field, *str, *found, *tmp;
> @@ -307,31 +338,20 @@ static int do_bcb_dump(struct cmd_tbl *cmdtp, int flag, int argc,
>  
>  static int __bcb_store(void)
>  {
> -	struct blk_desc *desc;
> -	struct disk_partition info;
>  	u64 cnt;
>  	int ret;
>  
> -	desc = blk_get_devnum_by_uclass_id(bcb_uclass_id, bcb_dev);
> -	if (!desc) {
> -		ret = -ENODEV;
> -		goto err;
> -	}
> -
> -	ret = part_get_info(desc, bcb_part, &info);
> -	if (ret)
> -		goto err;
> -
> -	cnt = DIV_ROUND_UP(sizeof(struct bootloader_message), info.blksz);
> +	cnt = DIV_ROUND_UP(sizeof(struct bootloader_message), partition->blksz);
>  
> -	if (blk_dwrite(desc, info.start, cnt, &bcb) != cnt) {
> +	if (blk_dwrite(block, partition->start, cnt, &bcb) != cnt) {
>  		ret = -EIO;
>  		goto err;
>  	}
>  
>  	return CMD_RET_SUCCESS;
>  err:
> -	printf("Error: %d %d:%d write failed (%d)\n", bcb_uclass_id, bcb_dev, bcb_part, ret);
> +	printf("Error: %d %d:%s write failed (%d)\n", block->uclass_id,
> +	       block->devnum, partition->name, ret);
>  
>  	return CMD_RET_FAILURE;
>  }
> @@ -342,23 +362,59 @@ static int do_bcb_store(struct cmd_tbl *cmdtp, int flag, int argc,
>  	return __bcb_store();
>  }
>  
> -int bcb_write_reboot_reason(const char *iface, int devnum, char *partp, const char *reasonp)
> +int bcb_find_partition_and_load(const char *iface, int devnum, char *partp)
>  {
>  	int ret;
>  
> -	ret = __bcb_load(iface, devnum, partp);
> -	if (ret != CMD_RET_SUCCESS)
> -		return ret;
> +	__bcb_reset();
>  
> -	ret = __bcb_set("command", reasonp);
> +	ret = __bcb_initialize(iface, devnum, partp);
>  	if (ret != CMD_RET_SUCCESS)
>  		return ret;
>  
> -	ret = __bcb_store();
> -	if (ret != CMD_RET_SUCCESS)
> -		return ret;
> +	return __bcb_load();
> +}
>  
> -	return 0;
> +int bcb_load(struct blk_desc *block_description, struct disk_partition *disk_partition)
> +{
> +	__bcb_reset();
> +
> +	block = block_description;
> +	partition = disk_partition;
> +
> +	return __bcb_load();
> +}
> +
> +int bcb_set(enum bcb_field field, const char *value)
> +{
> +	if (field > BCB_FIELD_STAGE)
> +		return CMD_RET_FAILURE;
> +	return __bcb_set(fields[field], value);
> +}
> +
> +int bcb_get(enum bcb_field field, char *value_out, size_t value_size)
> +{
> +	int size;
> +	char *field_value;
> +
> +	if (field > BCB_FIELD_STAGE)
> +		return CMD_RET_FAILURE;
> +	if (bcb_field_get(fields[field], &field_value, &size))
> +		return CMD_RET_FAILURE;
> +
> +	strlcpy(value_out, field_value, value_size);
> +
> +	return CMD_RET_SUCCESS;
> +}
> +
> +int bcb_store(void)
> +{
> +	return __bcb_store();
> +}
> +
> +void bcb_reset(void)
> +{
> +	__bcb_reset();
>  }
>  
>  static struct cmd_tbl cmd_bcb_sub[] = {
> diff --git a/drivers/fastboot/fb_common.c b/drivers/fastboot/fb_common.c
> index 2a6608b28c..3576b06772 100644
> --- a/drivers/fastboot/fb_common.c
> +++ b/drivers/fastboot/fb_common.c
> @@ -91,6 +91,7 @@ void fastboot_okay(const char *reason, char *response)
>   */
>  int __weak fastboot_set_reboot_flag(enum fastboot_reboot_reason reason)
>  {
> +	int ret;
>  	static const char * const boot_cmds[] = {
>  		[FASTBOOT_REBOOT_REASON_BOOTLOADER] = "bootonce-bootloader",
>  		[FASTBOOT_REBOOT_REASON_FASTBOOTD] = "boot-fastboot",
> @@ -105,7 +106,18 @@ int __weak fastboot_set_reboot_flag(enum fastboot_reboot_reason reason)
>  	if (reason >= FASTBOOT_REBOOT_REASONS_COUNT)
>  		return -EINVAL;
>  
> -	return bcb_write_reboot_reason("mmc", mmc_dev, "misc", boot_cmds[reason]);
> +	ret = bcb_find_partition_and_load("mmc", mmc_dev, "misc");
> +	if (ret)
> +		goto out;
> +
> +	ret = bcb_set(BCB_FIELD_COMMAND, boot_cmds[reason]);
> +	if (ret)
> +		goto out;
> +
> +	ret = bcb_store();
> +out:
> +	bcb_reset();
> +	return ret;
>  }
>  
>  /**
> diff --git a/include/bcb.h b/include/bcb.h
> index a6326523c4..1941d8c28b 100644
> --- a/include/bcb.h
> +++ b/include/bcb.h
> @@ -8,15 +8,69 @@
>  #ifndef __BCB_H__
>  #define __BCB_H__
>  
> +#include <part.h>
> +
> +enum bcb_field {
> +	BCB_FIELD_COMMAND,
> +	BCB_FIELD_STATUS,
> +	BCB_FIELD_RECOVERY,
> +	BCB_FIELD_STAGE
> +};
> +
>  #if IS_ENABLED(CONFIG_CMD_BCB)
> -int bcb_write_reboot_reason(const char *iface, int devnum, char *partp, const char *reasonp);
> +
> +int bcb_find_partition_and_load(const char *iface,
> +				int devnum, char *partp);
> +int bcb_load(struct blk_desc *block_description,
> +	     struct disk_partition *disk_partition);
> +int bcb_set(enum bcb_field field, const char *value);
> +
> +/**
> + * bcb_get() - get the field value.
> + * @field: field to get
> + * @value_out: buffer to copy bcb field value to
> + * @value_size: buffer size to avoid overflow in case
> + *              value_out is smaller then the field value
> + */
> +int bcb_get(enum bcb_field field, char *value_out, size_t value_size);
> +
> +int bcb_store(void);
> +void bcb_reset(void);
> +
>  #else
> +
>  #include <linux/errno.h>
> -static inline int bcb_write_reboot_reason(const char *iface, int devnum,
> -					  char *partp, const char *reasonp)
> +
> +static inline int bcb_load(struct blk_desc *block_description,
> +			   struct disk_partition *disk_partition)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int bcb_find_partition_and_load(const char *iface,
> +					      int devnum, char *partp)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int bcb_set(enum bcb_field field, const char *value)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int bcb_get(enum bcb_field field, char *value_out)
>  {
>  	return -EOPNOTSUPP;
>  }
> +
> +static inline int bcb_store(void)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline void bcb_reset(void)
> +{
> +}
>  #endif
>  
>  #endif /* __BCB_H__ */
> -- 
> 2.42.0.869.gea05f2083d-goog
