Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 733C2D0D79C
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 14:24:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCF5A8931F;
	Fri, 11 Oct 2024 16:24:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CloNK4Tk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1A50890FD; Fri, 11 Oct 2024 16:24:36 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D39F0890FD
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 16:24:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5398d171fa2so2760856e87.0
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 07:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728656674; x=1729261474;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=CpC57p9l+JWhKb/HekGjjYuv8Eb4T62/JeWjLA9R/kI=;
 b=CloNK4TksHG3hkcfjPWPkgb86Ed8fLyaJpuGM/oPdT1NnaYEAdYlYCE+nAnDQW/22L
 CEzBgjRDP8vkPzs7/sDx+5nrIS3Wk0DYGbr2fRuNCIjbb9VbwOLPjVekwqphHvYNsWaH
 Y9BTW2Yh326+Sa0J+L5/qfhiRf4kqzf0Ilm7alqQqQ87daplEGfG2thN9tPoM8WIRNsO
 S06C45C9DfQN2NGcv6GC7xMMSRh5V4alihR8itvPEmWtrFjip3GlmxO7fVaHoMb6pVNO
 I+GvnD5b9+XuMrpVbpf0YeJpzxfG+QDnk6JFm8It7AML9u39LHpos2CvxlsezF8Taa5a
 z0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728656674; x=1729261474;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CpC57p9l+JWhKb/HekGjjYuv8Eb4T62/JeWjLA9R/kI=;
 b=QQl+L3CclpaaOF1eksoi999CUpTmUwWxx2CvNENz2QKYRVC2CxjIMs6JFNV6qX3uAX
 ephORr0QbC/q0NZ93xJMk+Wq/XtiWqvA20E6Yn06DtqNN+7Gybt/yfBhIudxl0VTojnR
 pg6DYBkadTgK59ZE8nN08TnOSSij1qgXDSq/JoPV9feUjsgmJ6qpa5hdnPmx1t8h0r+H
 UuIH8IslOtz/Xc1X3o8DcHZov9rrv72kOTaRKjOz6KIJoHw1NWnOkWvq3ubgxb3AORNH
 0IvhPNK+lTQvUTzCV2Eyt5zpppj6H7DCUCcDoAnw5CHxC750IErKEjEcpHGgczYTPdcl
 suKQ==
X-Gm-Message-State: AOJu0Yw/4gTSQsS8ZXNI+qcVmeL1z4TMv3gvmcl2YCIYkfUMO6OrggjX
 Sa+nJkqjvMT2WXmBNhI1D4Niz7zl43nRIEmTmyqo3yFZBPvfHE5J26AnnjMYxs8=
X-Google-Smtp-Source: AGHT+IFON9goHQawzpuybPTl1d/yWmgJNMg9INGWDVwJlQdnScOduyL1iDkmW1r9fvOfBeqn7kBwXw==
X-Received: by 2002:a05:6512:39d6:b0:536:550e:7804 with SMTP id
 2adb3069b0e04-539da3c6a00mr1838232e87.18.1728656673918; 
 Fri, 11 Oct 2024 07:24:33 -0700 (PDT)
Received: from localhost ([2a01:cb19:8941:9800:3dae:610e:6435:d98e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4311835d95bsm43704685e9.47.2024.10.11.07.24.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 07:24:33 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>, Igor Opaniuk
 <igor.opaniuk@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>, Tom
 Rini <trini@konsulko.com>, "Andrew F. Davis" <afd@ti.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, Mario Six
 <mario.six@gdsys.cc>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, rockosov@gmail.com,
 kernel@salutedevices.com, Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: Re: [PATCH v3 4/6] cmd: bcb: introduce 'ab_dump' command to print
 BCB block content
In-Reply-To: <20241008-android_ab_master-v3-4-f292c45a33e4@salutedevices.com>
References: <20241008-android_ab_master-v3-0-f292c45a33e4@salutedevices.com>
 <20241008-android_ab_master-v3-4-f292c45a33e4@salutedevices.com>
Date: Fri, 11 Oct 2024 16:24:30 +0200
Message-ID: <878quuhg4h.fsf@baylibre.com>
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

Hi Dmitry,

Thank you for the patch.

On mar., oct. 08, 2024 at 23:18, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:

> It's really helpful to have the ability to dump BCB block for debugging
> A/B logic on the board supported this partition schema.
>
> Command 'bcb ab_dump' prints all fields of bootloader_control struct
> including slot_metadata for all presented slots.
>
> Output example:
> =====
>> board# bcb ab_dump ubi 0#misc
>> Read 512 bytes from volume misc to 000000000bf07580
>> Read 512 bytes from volume misc to 000000000bf42f40
>> Bootloader Control:       [misc]
>> Active Slot:              _a
>> Magic Number:             0x42414342
>> Version:                  1
>> Number of Slots:          2
>> Recovery Tries Remaining: 0
>> CRC:                      0x2c8b50bc (Valid)
>>
>> Slot[0] Metadata:
>> 	- Priority:         15
>> 	- Tries Remaining:  0
>> 	- Successful Boot:  1
>> 	- Verity Corrupted: 0
>>
>> Slot[1] Metadata:
>> 	- Priority:         14
>> 	- Tries Remaining:  7
>> 	- Successful Boot:  0
>> 	- Verity Corrupted: 0
> ====
>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  boot/android_ab.c    | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  cmd/bcb.c            | 35 +++++++++++++++++++++++++++
>  include/android_ab.h | 10 ++++++++
>  3 files changed, 113 insertions(+)
>
> diff --git a/boot/android_ab.c b/boot/android_ab.c
> index 0045c8133a8e164f1fdd4c0f9b683de0f13f26e0..c93e51541019d0fe793303c4b3d5286df061906f 100644
> --- a/boot/android_ab.c
> +++ b/boot/android_ab.c
> @@ -372,3 +372,71 @@ int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
>  
>  	return slot;
>  }
> +
> +int ab_dump_abc(struct blk_desc *dev_desc, struct disk_partition *part_info)
> +{
> +	struct bootloader_control *abc;
> +	u32 crc32_le;
> +	int i, ret;
> +	struct slot_metadata *slot;
> +
> +	if (!dev_desc || !part_info) {
> +		log_err("ANDROID: Empty device descriptor or partition info\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = ab_control_create_from_disk(dev_desc, part_info, &abc, 0);
> +	if (ret < 0) {
> +		log_err("ANDROID: Cannot create bcb from disk %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (abc->magic != BOOT_CTRL_MAGIC) {
> +		log_err("ANDROID: Unknown A/B metadata: %.8x\n", abc->magic);
> +		ret = -ENODATA;
> +		goto error;
> +	}
> +
> +	if (abc->version > BOOT_CTRL_VERSION) {
> +		log_err("ANDROID: Unsupported A/B metadata version: %.8x\n",
> +			abc->version);
> +		ret = -ENODATA;
> +		goto error;
> +	}
> +
> +	if (abc->nb_slot > ARRAY_SIZE(abc->slot_info)) {
> +		log_err("ANDROID: Wrong number of slots %u, expected %zu\n",
> +			abc->nb_slot, ARRAY_SIZE(abc->slot_info));
> +		ret = -ENODATA;
> +		goto error;
> +	}
> +
> +	printf("Bootloader Control:       [%s]\n", part_info->name);
> +	printf("Active Slot:              %s\n", abc->slot_suffix);
> +	printf("Magic Number:             0x%x\n", abc->magic);
> +	printf("Version:                  %u\n", abc->version);
> +	printf("Number of Slots:          %u\n", abc->nb_slot);
> +	printf("Recovery Tries Remaining: %u\n", abc->recovery_tries_remaining);
> +
> +	printf("CRC:                      0x%.8x", abc->crc32_le);
> +
> +	crc32_le = ab_control_compute_crc(abc);
> +	if (abc->crc32_le != crc32_le)
> +		printf(" (Invalid, Expected: 0x%.8x)\n", crc32_le);
> +	else
> +		printf(" (Valid)\n");
> +
> +	for (i = 0; i < abc->nb_slot; ++i) {
> +		slot = &abc->slot_info[i];
> +		printf("\nSlot[%d] Metadata:\n", i);
> +		printf("\t- Priority:         %u\n", slot->priority);
> +		printf("\t- Tries Remaining:  %u\n", slot->tries_remaining);
> +		printf("\t- Successful Boot:  %u\n", slot->successful_boot);
> +		printf("\t- Verity Corrupted: %u\n", slot->verity_corrupted);
> +	}
> +
> +error:
> +	free(abc);
> +
> +	return ret;
> +}
> diff --git a/cmd/bcb.c b/cmd/bcb.c
> index 970c58e56cba0e1bdff21b7cd099f69151f0c5b8..4fd32186ae654915b5a42c26d755e5727c211c63 100644
> --- a/cmd/bcb.c
> +++ b/cmd/bcb.c
> @@ -25,6 +25,7 @@ enum bcb_cmd {
>  	BCB_CMD_FIELD_DUMP,
>  	BCB_CMD_STORE,
>  	BCB_CMD_AB_SELECT,
> +	BCB_CMD_AB_DUMP,
>  };
>  
>  static const char * const fields[] = {
> @@ -56,6 +57,8 @@ static int bcb_cmd_get(char *cmd)
>  		return BCB_CMD_FIELD_DUMP;
>  	if (!strcmp(cmd, "ab_select"))
>  		return BCB_CMD_AB_SELECT;
> +	if (!strcmp(cmd, "ab_dump"))
> +		return BCB_CMD_AB_DUMP;
>  	else
>  		return -1;
>  }
> @@ -93,6 +96,10 @@ static int bcb_is_misused(int argc, char *const argv[])
>  		if (argc != 4 && argc != 5)
>  			goto err;
>  		return 0;
> +	case BCB_CMD_AB_DUMP:
> +		if (argc != 3)
> +			goto err;
> +		return 0;
>  	default:
>  		printf("Error: 'bcb %s' not supported\n", argv[0]);
>  		return -1;
> @@ -460,6 +467,28 @@ static int do_bcb_ab_select(struct cmd_tbl *cmdtp, int flag, int argc,
>  	return CMD_RET_SUCCESS;
>  }
>  
> +static int do_bcb_ab_dump(struct cmd_tbl *cmdtp, int flag, int argc,
> +			  char *const argv[])
> +{
> +	int ret;
> +	struct blk_desc *dev_desc;
> +	struct disk_partition part_info;
> +
> +	if (part_get_info_by_dev_and_name_or_num(argv[1], argv[2],
> +						 &dev_desc, &part_info,
> +						 false) < 0) {
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	ret = ab_dump_abc(dev_desc, &part_info);
> +	if (ret < 0) {
> +		printf("Cannot dump ABC data, error %d.\n", ret);
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	return CMD_RET_SUCCESS;
> +}
> +
>  static struct cmd_tbl cmd_bcb_sub[] = {
>  	U_BOOT_CMD_MKENT(load, CONFIG_SYS_MAXARGS, 1, do_bcb_load, "", ""),
>  	U_BOOT_CMD_MKENT(set, CONFIG_SYS_MAXARGS, 1, do_bcb_set, "", ""),
> @@ -469,6 +498,8 @@ static struct cmd_tbl cmd_bcb_sub[] = {
>  	U_BOOT_CMD_MKENT(store, CONFIG_SYS_MAXARGS, 1, do_bcb_store, "", ""),
>  	U_BOOT_CMD_MKENT(ab_select, CONFIG_SYS_MAXARGS, 1,
>  			 do_bcb_ab_select, "", ""),
> +	U_BOOT_CMD_MKENT(ab_dump, CONFIG_SYS_MAXARGS, 1,
> +			 do_bcb_ab_dump, "", ""),
>  };
>  
>  static int do_bcb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> @@ -523,6 +554,10 @@ U_BOOT_CMD(
>  	"    - If '--no-dec' is set, the number of tries remaining will not\n"
>  	"      decremented for the selected boot slot\n"
>  	"\n"
> +	"bcb ab_dump -\n"
> +	"    Dump boot_control information from specific partition.\n"
> +	"    <interface> <dev[:part|#part_name]>\n"
> +	"\n"
>  	"Legend:\n"
>  	"<interface> - storage device interface (virtio, mmc, etc)\n"
>  	"<dev>       - storage device index containing the BCB partition\n"
> diff --git a/include/android_ab.h b/include/android_ab.h
> index 1e53879a25f145a9d18ac0a6553d8c217123aa6f..838230e06f8cbf7a5d79d9d84d9ebe9f96aca10d 100644
> --- a/include/android_ab.h
> +++ b/include/android_ab.h
> @@ -36,4 +36,14 @@ struct disk_partition;
>  int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
>                     bool dec_tries);
>  
> +/**
> + * ab_dump_abc() - Dump ABC information for specific partition.
> + *
> + * @dev_desc: Device description pointer
> + * @part_info: Partition information
> + *
> + * Return: 0 on success, or a negative on error
> + */
> +int ab_dump_abc(struct blk_desc *dev_desc, struct disk_partition *part_info);
> +
>  #endif /* __ANDROID_AB_H */
>
> -- 
> 2.43.0
