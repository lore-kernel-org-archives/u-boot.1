Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD894C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 09:40:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67ED088319;
	Tue, 16 Apr 2024 11:40:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Zt5Mha5N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E2608832B; Tue, 16 Apr 2024 11:40:14 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44CB088319
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 11:40:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3455ff1339dso2853584f8f.0
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 02:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713260410; x=1713865210;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=1zGY/kRqtyuwXdp7MqWhnnyEZaoXOxPC9hHZNwePxeQ=;
 b=Zt5Mha5NTbeWKPOP6ciFkMldCWiYt+BUv7acjfwr5D2BSnNssF5jGKcLuYNKJinX9C
 kCqEkfntVNXlNo0HqkvTCcfZIL2iKTeDeZSaJzFpKhe5AxR52dqrWUZOCiyV220Ox/kV
 yIFjv0E0WjpcdkkYPhyPFRkOaVd3uGPDZ8aQhyDsDp95436tZ8h5dBFyq7YArzYvOuKi
 HD/09Gn471i8Xg5lTw1PXPHzD+cP+LPG7otAm3DYUZtAjJro/O0e7I3zgJe5G8DzHNUw
 DPq7M6umwqYHBm2GY5UjG93LGv8MYixkrw5k2K7Wcd7UQjA0jZKHWkYERlUvPeywEOsw
 OEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713260410; x=1713865210;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1zGY/kRqtyuwXdp7MqWhnnyEZaoXOxPC9hHZNwePxeQ=;
 b=wjXox9KIW4S7UA9+U8mAoVJPzGgoqZgZpG4M3VBdpBmhkKMD/acuVxJSvZCjHO369G
 3mmSypqsSeCgMM80p9aUBp6ROCQ8QT4RWkg+wIxfhn5xWcMTC+xLGImH9It4pALNIV1G
 fq7YfCqOmrX9TxEaaTIpt7oIw8qP2AcvM2+/Ss8iURGLQH1Q8dzbgoUt1AjyDe+fHxsR
 ldePdXB6JS3NDTMn839+5FVPlQqZGI69U9m1DJn+gFeKiIy1f9NRF6URA6olGRXo28PL
 2mzTOorSbjzoz65sfOp1LLu+ue1tPc1fgadSD+u9XMJa5qTJyudLCvhzMFUaHkHuif0G
 R3XA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVugBt/Y6WwXKYZdbHtxjxRrC26z0UTgOtBXLlfzvaoIy7iWwtfRxwAYhaHZ2aE3f0xB+ouXtL3wCsU8T0/aMXrBq9F1A==
X-Gm-Message-State: AOJu0YxeWMh3b9SB0A3Uo7Be5Zp9WfqHRaOY17mzLz7JSOQSwQNn+HBs
 ki6nQPitzHpeEO1lxfFEXe13ZlZVDEFV8VM4PlCa8zTz0t2BlQhUKAAYAfdfqf8=
X-Google-Smtp-Source: AGHT+IFiIAIIO3pf9ekRxVY0m10Viw4XB31K6j6tj63TRVVHlA4ZPV2xMdjLaPBd/K7PFKw+4wDbhg==
X-Received: by 2002:a05:6000:89:b0:346:b95e:fd40 with SMTP id
 m9-20020a056000008900b00346b95efd40mr9729140wrx.5.1713260409501; 
 Tue, 16 Apr 2024 02:40:09 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 a14-20020adffb8e000000b00347363b77dasm10119872wrr.33.2024.04.16.02.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 02:40:09 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Lukasz Majewski
 <lukma@denx.de>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg
 <sumit.garg@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>
Subject: Re: [PATCH 1/2] dfu: add scsi backend
In-Reply-To: <20240409-b4-dfu-scsi-v1-1-3e1441a60376@linaro.org>
References: <20240409-b4-dfu-scsi-v1-0-3e1441a60376@linaro.org>
 <20240409-b4-dfu-scsi-v1-1-3e1441a60376@linaro.org>
Date: Tue, 16 Apr 2024 11:40:06 +0200
Message-ID: <87o7a94pe1.fsf@baylibre.com>
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

On mar., avril 09, 2024 at 15:55, Caleb Connolly <caleb.connolly@linaro.org> wrote:

> This is extremely similar to the MMC backend, but there are some notable
> differences.
>
> Works with a DFU string like
>
>     scsi 4=u-boot-bin part 11
>
> Where "4" is the SCSI dev number (sequential LUN across all SCSI devices)
> and "11" is the partition number.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  doc/usage/dfu.rst      |  31 ++++
>  drivers/dfu/Kconfig    |   7 +
>  drivers/dfu/Makefile   |   1 +
>  drivers/dfu/dfu.c      |   5 +-
>  drivers/dfu/dfu_scsi.c | 437 +++++++++++++++++++++++++++++++++++++++++++++++++
>  include/dfu.h          |  26 +++
>  6 files changed, 506 insertions(+), 1 deletion(-)
>
> diff --git a/doc/usage/dfu.rst b/doc/usage/dfu.rst
> index 8cc09c308d82..dc4f8d672f99 100644
> --- a/doc/usage/dfu.rst
> +++ b/doc/usage/dfu.rst
> @@ -166,8 +166,38 @@ mmc

Can we also add this to the summary list at line 22?
"Today the supported DFU backends are:"

Also, please add CONFIG_DFU_SCSI in "Configuration Options" section at
the beginning of this document.

>  
>      Please note that this means the user will be able to execute any
>      arbitrary commands just like in the u-boot's shell.
>  
> +scsi
> +    for UFS storage::
> +
> +        dfu 0 scsi <dev>
> +
> +    each element in *dfu_alt_info* being
> +
> +    * <name> raw <offset> <size>     raw access to SCSI LUN
> +    * <name> part <part_id>          raw access to partition
> +    * <name> fat <part_id>           file in FAT partition
> +    * <name> ext4 <part_id>          file in EXT4 partition
> +    * <name> skip 0 0                ignore flashed data
> +    * <name> script 0 0              execute commands in shell
> +
> +    with
> +
> +    size
> +        is the size of the access area (hexadecimal without "0x")
> +        or 0 which means whole device
> +    partid
> +        is the GPT or DOS partition index.
> +    dev
> +        is the SCSI LU (Logical Unit) index (decimal only)
> +
> +    A value of environment variable *dfu_alt_info* for UFS could be::
> +
> +        u-boot part 4;bl2 raw 0x1e 0x1d
> +
> +    See mmc section above for details on the skip and script types.
> +
>  nand
>      raw slc nand device::
>  
>           dfu 0 nand <dev>
> @@ -277,8 +307,9 @@ alternate list separated by '&' with the same format for each <alt>::
>  
>      mmc <dev>=<alt1>;....;<altN>
>      nand <dev>=<alt1>;....;<altN>
>      ram <dev>=<alt1>;....;<altN>
> +    scsi <dev>=<alt1>;....;<altN>
>      sf <dev>=<alt1>;....;<altN>
>      mtd <dev>=<alt1>;....;<altN>
>      virt <dev>=<alt1>;....;<altN>
>  
> diff --git a/drivers/dfu/Kconfig b/drivers/dfu/Kconfig
> index 0360d9da1427..158c660e6c4e 100644
> --- a/drivers/dfu/Kconfig
> +++ b/drivers/dfu/Kconfig
> @@ -86,8 +86,15 @@ config DFU_VIRT
>  	  This option enables using DFU to read and write to VIRTUAL device
>  	  used at board level to manage specific behavior
>  	  (OTP update for example).
>  
> +config DFU_SCSI
> +	bool "SCSI flash back end for DFU"
> +	help
> +	  This option enables using DFU to read and write to SCSI devices
> +	  used at board level to manage specific behavior
> +	  (OTP update for example).
> +
>  config SET_DFU_ALT_INFO
>  	bool "Dynamic set of DFU alternate information"
>  	help
>  	  This option allows to call the function set_dfu_alt_info to
> diff --git a/drivers/dfu/Makefile b/drivers/dfu/Makefile
> index dfbf64da6677..3b3ba0994b3a 100644
> --- a/drivers/dfu/Makefile
> +++ b/drivers/dfu/Makefile
> @@ -10,4 +10,5 @@ obj-$(CONFIG_$(SPL_)DFU_NAND) += dfu_nand.o
>  obj-$(CONFIG_$(SPL_)DFU_RAM) += dfu_ram.o
>  obj-$(CONFIG_$(SPL_)DFU_SF) += dfu_sf.o
>  obj-$(CONFIG_$(SPL_)DFU_WRITE_ALT) += dfu_alt.o
>  obj-$(CONFIG_$(SPL_)DFU_VIRT) += dfu_virt.o
> +obj-$(CONFIG_$(SPL_)DFU_SCSI) += dfu_scsi.o
> diff --git a/drivers/dfu/dfu.c b/drivers/dfu/dfu.c
> index 2adf26e2fe24..8024ad98a7dc 100644
> --- a/drivers/dfu/dfu.c
> +++ b/drivers/dfu/dfu.c
> @@ -548,8 +548,11 @@ static int dfu_fill_entity(struct dfu_entity *dfu, char *s, int alt,
>  			return -1;
>  	} else if (strcmp(interface, "virt") == 0) {
>  		if (dfu_fill_entity_virt(dfu, devstr, argv, argc))
>  			return -1;
> +	} else if (strcmp(interface, "scsi") == 0) {
> +		if (dfu_fill_entity_scsi(dfu, devstr, argv, argc))
> +			return -1;
>  	} else {
>  		printf("%s: Device %s not (yet) supported!\n",
>  		       __func__,  interface);
>  		return -1;
> @@ -644,9 +647,9 @@ int dfu_config_entities(char *env, char *interface, char *devstr)
>  
>  const char *dfu_get_dev_type(enum dfu_device_type t)
>  {
>  	const char *const dev_t[] = {NULL, "eMMC", "OneNAND", "NAND", "RAM",
> -				     "SF", "MTD", "VIRT"};
> +				     "SF", "MTD", "VIRT", "SCSI"};
>  	return dev_t[t];
>  }
>  
>  const char *dfu_get_layout(enum dfu_layout l)
> diff --git a/drivers/dfu/dfu_scsi.c b/drivers/dfu/dfu_scsi.c
> new file mode 100644
> index 000000000000..63c3bcffe769
> --- /dev/null
> +++ b/drivers/dfu/dfu_scsi.c
> @@ -0,0 +1,437 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * DFU SCSI backend (based on MMC backend).
> + *
> + * Copyright (C) 2012 Samsung Electronics
> + *   author: Lukasz Majewski <l.majewski@samsung.com>
> + * Copyright (C) 2024 Linaro Ltd.
> + */
> +
> +#define LOG_DEBUG

Can we keep debugging disabled by default, please?

> +
> +#include <log.h>
> +#include <malloc.h>
> +#include <errno.h>
> +#include <div64.h>
> +#include <dfu.h>
> +#include <ext4fs.h>
> +#include <fat.h>
> +#include <scsi.h>
> +#include <part.h>
> +#include <command.h>
> +#include <linux/printk.h>
> +
> +static unsigned char *dfu_file_buf;
> +static u64 dfu_file_buf_len;
> +static u64 dfu_file_buf_offset;
> +
> +#define scsi_get_blk_desc(dev) ((struct blk_desc *)dev_get_uclass_plat(dev))
> +
> +#define find_scsi_device(dev_num, scsi) blk_get_device(UCLASS_SCSI, dev_num, scsi)
> +
> +static int scsi_block_op(enum dfu_op op, struct dfu_entity *dfu, u64 offset, void *buf, long *len)
> +{
> +	struct udevice *scsi;
> +	u32 blk_start, blk_count, n = 0;
> +	int ret;
> +
> +	ret = find_scsi_device(dfu->data.scsi.lun, &scsi);
> +	if (ret < 0) {
> +		pr_err("Device SCSI %d - not found!", dfu->data.scsi.lun);
> +		return -ENODEV;
> +	}
> +
> +	/*
> +	 * We must ensure that we work in lba_blk_size chunks, so ALIGN
> +	 * this value.
> +	 */
> +	*len = ALIGN(*len, dfu->data.scsi.lba_blk_size);
> +
> +	blk_start = dfu->data.scsi.lba_start + (u32)lldiv(offset, dfu->data.scsi.lba_blk_size);
> +	blk_count = *len / dfu->data.scsi.lba_blk_size;
> +	if (blk_start + blk_count > dfu->data.scsi.lba_start + dfu->data.scsi.lba_size) {
> +		puts("Request would exceed designated area!\n");
> +		return -EINVAL;
> +	}
> +
> +	debug("%s: %s dev: %d start: %d cnt: %d buf: 0x%p\n", __func__,
> +	      op == DFU_OP_READ ? "scsi READ" : "scsi WRITE", dfu->data.scsi.lun, blk_start,

nitpick: in most debug/error messages, scsi is lowercase, except the
first error message where it's uppercase (SCSI).
Comparing with drivers/dfu/dfu_mmc.c, this is inconsistent.

Please pick one (uppercase/lowercase) and be consistent in all messages accross.

> +	      blk_count, buf);
> +	switch (op) {
> +	case DFU_OP_READ:
> +		n = blk_dread(scsi_get_blk_desc(scsi), blk_start, blk_count, buf);
> +		break;
> +	case DFU_OP_WRITE:
> +		n = blk_dwrite(scsi_get_blk_desc(scsi), blk_start, blk_count, buf);
> +		break;
> +	default:
> +		pr_err("Operation not supported\n");
> +	}
> +
> +	if (n != blk_count) {
> +		pr_err("scsi block operation failed");
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static int scsi_file_op(enum dfu_op op, struct dfu_entity *dfu, u64 offset, void *buf, u64 *len)
> +{
> +	char dev_part_str[8];
> +	int ret;
> +	int fstype;
> +	loff_t size = 0;
> +
> +	switch (dfu->layout) {
> +	case DFU_FS_FAT:
> +		fstype = FS_TYPE_FAT;
> +		break;
> +	case DFU_FS_EXT4:
> +		fstype = FS_TYPE_EXT;
> +		break;
> +	case DFU_SKIP:
> +		return 0;
> +	default:
> +		printf("%s: Layout (%s) not (yet) supported!\n", __func__,
> +		       dfu_get_layout(dfu->layout));
> +		return -1;
> +	}
> +
> +	snprintf(dev_part_str, sizeof(dev_part_str), "%d:%d", dfu->data.scsi.dev,
> +		 dfu->data.scsi.part);
> +
> +	ret = fs_set_blk_dev("scsi", dev_part_str, fstype);
> +	if (ret) {
> +		puts("dfu: fs_set_blk_dev error!\n");
> +		return ret;
> +	}
> +
> +	switch (op) {
> +	case DFU_OP_READ:
> +		ret = fs_read(dfu->name, (size_t)buf, offset, *len, &size);
> +		if (ret) {
> +			puts("dfu: fs_read error!\n");
> +			return ret;
> +		}
> +		*len = size;
> +		break;
> +	case DFU_OP_WRITE:
> +		ret = fs_write(dfu->name, (size_t)buf, offset, *len, &size);
> +		if (ret) {
> +			puts("dfu: fs_write error!\n");
> +			return ret;
> +		}
> +		break;
> +	case DFU_OP_SIZE:
> +		ret = fs_size(dfu->name, &size);
> +		if (ret) {
> +			puts("dfu: fs_size error!\n");
> +			return ret;
> +		}
> +		*len = size;
> +		break;
> +	default:
> +		return -1;
> +	}
> +
> +	return ret;
> +}
> +
> +static int scsi_file_buf_write(struct dfu_entity *dfu, u64 offset, void *buf, long *len)
> +{
> +	int ret = 0;
> +
> +	if (offset == 0) {
> +		dfu_file_buf_len = 0;
> +		dfu_file_buf_offset = 0;
> +	}
> +
> +	/* Add to the current buffer. */
> +	if (dfu_file_buf_len + *len > CONFIG_SYS_DFU_MAX_FILE_SIZE)
> +		*len = CONFIG_SYS_DFU_MAX_FILE_SIZE - dfu_file_buf_len;
> +	memcpy(dfu_file_buf + dfu_file_buf_len, buf, *len);
> +	dfu_file_buf_len += *len;
> +
> +	if (dfu_file_buf_len == CONFIG_SYS_DFU_MAX_FILE_SIZE) {
> +		ret = scsi_file_op(DFU_OP_WRITE, dfu, dfu_file_buf_offset, dfu_file_buf,
> +				   &dfu_file_buf_len);
> +		dfu_file_buf_offset += dfu_file_buf_len;
> +		dfu_file_buf_len = 0;
> +	}
> +
> +	return ret;
> +}
> +
> +static int scsi_file_buf_write_finish(struct dfu_entity *dfu)
> +{
> +	int ret = scsi_file_op(DFU_OP_WRITE, dfu, dfu_file_buf_offset, dfu_file_buf,
> +			       &dfu_file_buf_len);
> +
> +	/* Now that we're done */
> +	dfu_file_buf_len = 0;
> +	dfu_file_buf_offset = 0;
> +
> +	return ret;
> +}
> +
> +int dfu_write_medium_scsi(struct dfu_entity *dfu, u64 offset, void *buf, long *len)
> +{
> +	int ret = -1;
> +
> +	switch (dfu->layout) {
> +	case DFU_RAW_ADDR:
> +		ret = scsi_block_op(DFU_OP_WRITE, dfu, offset, buf, len);
> +		break;
> +	case DFU_FS_FAT:
> +	case DFU_FS_EXT4:
> +		ret = scsi_file_buf_write(dfu, offset, buf, len);
> +		break;
> +	case DFU_SCRIPT:
> +		ret = run_command_list(buf, *len, 0);
> +		break;
> +	case DFU_SKIP:
> +		ret = 0;
> +		break;
> +	default:
> +		printf("%s: Layout (%s) not (yet) supported!\n", __func__,
> +		       dfu_get_layout(dfu->layout));
> +	}
> +
> +	return ret;
> +}
> +
> +int dfu_flush_medium_scsi(struct dfu_entity *dfu)
> +{
> +	int ret = 0;
> +
> +	switch (dfu->layout) {
> +	case DFU_FS_FAT:
> +	case DFU_FS_EXT4:
> +		ret = scsi_file_buf_write_finish(dfu);
> +		break;
> +	case DFU_SCRIPT:
> +		/* script may have changed the dfu_alt_info */
> +		dfu_reinit_needed = true;
> +		break;
> +	case DFU_RAW_ADDR:
> +	case DFU_SKIP:
> +		break;
> +	default:
> +		printf("%s: Layout (%s) not (yet) supported!\n", __func__,
> +		       dfu_get_layout(dfu->layout));
> +	}
> +
> +	return ret;
> +}
> +
> +int dfu_get_medium_size_scsi(struct dfu_entity *dfu, u64 *size)
> +{
> +	int ret;
> +
> +	switch (dfu->layout) {
> +	case DFU_RAW_ADDR:
> +		*size = dfu->data.scsi.lba_size * dfu->data.scsi.lba_blk_size;
> +		return 0;
> +	case DFU_FS_FAT:
> +	case DFU_FS_EXT4:
> +		ret = scsi_file_op(DFU_OP_SIZE, dfu, 0, NULL, size);
> +		if (ret < 0)
> +			return ret;
> +		return 0;
> +	case DFU_SCRIPT:
> +	case DFU_SKIP:
> +		return 0;
> +	default:
> +		printf("%s: Layout (%s) not (yet) supported!\n", __func__,
> +		       dfu_get_layout(dfu->layout));
> +		return -1;
> +	}
> +}
> +
> +static int scsi_file_buf_read(struct dfu_entity *dfu, u64 offset, void *buf, long *len)
> +{
> +	int ret;
> +
> +	if (offset == 0 || offset >= dfu_file_buf_offset + dfu_file_buf_len ||
> +	    offset + *len < dfu_file_buf_offset) {
> +		u64 file_len = CONFIG_SYS_DFU_MAX_FILE_SIZE;
> +
> +		ret = scsi_file_op(DFU_OP_READ, dfu, offset, dfu_file_buf, &file_len);
> +		if (ret < 0)
> +			return ret;
> +		dfu_file_buf_len = file_len;
> +		dfu_file_buf_offset = offset;
> +	}
> +	if (offset + *len > dfu_file_buf_offset + dfu_file_buf_len)
> +		return -EINVAL;
> +
> +	/* Add to the current buffer. */
> +	memcpy(buf, dfu_file_buf + offset - dfu_file_buf_offset, *len);
> +
> +	return 0;
> +}
> +
> +int dfu_read_medium_scsi(struct dfu_entity *dfu, u64 offset, void *buf, long *len)
> +{
> +	int ret = -1;
> +
> +	switch (dfu->layout) {
> +	case DFU_RAW_ADDR:
> +		ret = scsi_block_op(DFU_OP_READ, dfu, offset, buf, len);
> +		break;
> +	case DFU_FS_FAT:
> +	case DFU_FS_EXT4:
> +		ret = scsi_file_buf_read(dfu, offset, buf, len);
> +		break;
> +	default:
> +		printf("%s: Layout (%s) not (yet) supported!\n", __func__,
> +		       dfu_get_layout(dfu->layout));
> +	}
> +
> +	return ret;
> +}
> +
> +void dfu_free_entity_scsi(struct dfu_entity *dfu)
> +{
> +	if (dfu_file_buf) {
> +		free(dfu_file_buf);
> +		dfu_file_buf = NULL;
> +	}
> +}
> +
> +/*
> + * @param s Parameter string containing space-separated arguments:
> + *	1st:
> + *		raw	(raw read/write)
> + *		fat	(files)
> + *		ext4	(^)
> + *		part	(partition image)
> + *	2nd and 3rd:
> + *		lba_start and lba_size, for raw write
> + *		scsi_dev and scsi_part, for filesystems and part
> + */
> +int dfu_fill_entity_scsi(struct dfu_entity *dfu, char *devstr, char **argv, int argc)
> +{
> +	const char *entity_type;
> +	ssize_t second_arg;
> +	ssize_t third_arg = -1;
> +	struct udevice *scsi;
> +	struct blk_desc *blk_dev;
> +	int ret;
> +	char *s;
> +
> +	if (argc < 2) {
> +		pr_err("Need at least one argument\n");
> +		return -EINVAL;
> +	}
> +
> +	dfu->data.scsi.lun = dectoul(devstr, &s);
> +	if (*s)
> +		return -EINVAL;
> +
> +	entity_type = argv[0];
> +	/*
> +	 * Base 0 means we'll accept (prefixed with 0x or 0) base 16, 8,
> +	 * with default 10.
> +	 */
> +	second_arg = simple_strtol(argv[1], &s, 0);
> +	if (*s)
> +		return -EINVAL;
> +	if (argc >= 3) {
> +		third_arg = simple_strtoul(argv[2], &s, 0);
> +		if (*s)
> +			return -EINVAL;
> +	}
> +
> +	if (scsi_scan(false)) {
> +		pr_err("Couldn't init scsi device.\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = find_scsi_device(dfu->data.scsi.lun, &scsi);
> +	if (ret < 0) {
> +		pr_err("Couldn't find scsi device no. %d.\n", dfu->data.scsi.lun);
> +		return -ENODEV;
> +	}
> +
> +	blk_dev = scsi_get_blk_desc(scsi);
> +	if (!blk_dev) {
> +		pr_err("Couldn't get block device for scsi device no. %d.\n", dfu->data.scsi.lun);
> +		return -ENODEV;
> +	}
> +
> +	/* if it's NOT a raw write */
> +	if (strcmp(entity_type, "raw")) {
> +		dfu->data.scsi.dev = (second_arg != -1) ? second_arg : dfu->data.scsi.lun;
> +		dfu->data.scsi.part = third_arg;
> +	}
> +
> +	if (!strcmp(entity_type, "raw")) {
> +		dfu->layout = DFU_RAW_ADDR;
> +		dfu->data.scsi.lba_start = second_arg;
> +		if (third_arg < 0) {
> +			pr_err("raw requires two arguments\n");
> +			return -EINVAL;
> +		}
> +		dfu->data.scsi.lba_size = third_arg;
> +		dfu->data.scsi.lba_blk_size = blk_dev->blksz;
> +
> +		/*
> +		 * In case the size is zero (i.e. scsi raw 0x10 0),
> +		 * assume the user intends to use whole device.
> +		 */
> +		if (third_arg == 0)
> +			dfu->data.scsi.lba_size = blk_dev->lba;
> +
> +	} else if (!strcmp(entity_type, "part")) {
> +		struct disk_partition partinfo;
> +		int scsipart = second_arg;
> +
> +		if (third_arg >= 0) {
> +			pr_err("part only accepts one argument\n");
> +			return -EINVAL;
> +		}
> +
> +		if (part_get_info(blk_dev, scsipart, &partinfo) != 0) {
> +			pr_err("Couldn't find part #%d on scsi device #%d\n", scsipart,
> +			       dfu->data.scsi.lun);
> +			return -ENODEV;
> +		}
> +
> +		dfu->layout = DFU_RAW_ADDR;
> +		dfu->data.scsi.lba_start = partinfo.start;
> +		dfu->data.scsi.lba_size = partinfo.size;
> +		dfu->data.scsi.lba_blk_size = partinfo.blksz;
> +	} else if (!strcmp(entity_type, "fat")) {
> +		dfu->layout = DFU_FS_FAT;
> +	} else if (!strcmp(entity_type, "ext4")) {
> +		dfu->layout = DFU_FS_EXT4;
> +	} else if (!strcmp(entity_type, "skip")) {
> +		dfu->layout = DFU_SKIP;
> +	} else if (!strcmp(entity_type, "script")) {
> +		dfu->layout = DFU_SCRIPT;
> +	} else {
> +		pr_err("Memory layout (%s) not supported!\n", entity_type);
> +		return -ENODEV;
> +	}
> +
> +	dfu->dev_type = DFU_DEV_SCSI;
> +	dfu->get_medium_size = dfu_get_medium_size_scsi;
> +	dfu->read_medium = dfu_read_medium_scsi;
> +	dfu->write_medium = dfu_write_medium_scsi;
> +	dfu->flush_medium = dfu_flush_medium_scsi;
> +	dfu->inited = 0;
> +	dfu->free_entity = dfu_free_entity_scsi;
> +
> +	/* Check if file buffer is ready */
> +	if (!dfu_file_buf) {
> +		dfu_file_buf = memalign(CONFIG_SYS_CACHELINE_SIZE, CONFIG_SYS_DFU_MAX_FILE_SIZE);
> +		if (!dfu_file_buf) {
> +			pr_err("Could not memalign 0x%x bytes\n", CONFIG_SYS_DFU_MAX_FILE_SIZE);
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	return 0;
> +}
> diff --git a/include/dfu.h b/include/dfu.h
> index fa1918cd6635..d7f365a7f1ce 100644
> --- a/include/dfu.h
> +++ b/include/dfu.h
> @@ -23,8 +23,9 @@ enum dfu_device_type {
>  	DFU_DEV_RAM,
>  	DFU_DEV_SF,
>  	DFU_DEV_MTD,
>  	DFU_DEV_VIRT,
> +	DFU_DEV_SCSI,
>  };
>  
>  enum dfu_layout {
>  	DFU_RAW_ADDR = 1,
> @@ -98,8 +99,20 @@ struct sf_internal_data {
>  struct virt_internal_data {
>  	int dev_num;
>  };
>  
> +struct scsi_internal_data {
> +	int lun;
> +
> +	/* RAW programming */
> +	unsigned int lba_start;
> +	unsigned int lba_size;
> +	unsigned int lba_blk_size;
> +
> +	/* FAT/EXT */
> +	unsigned int dev; // Always 0???
> +	unsigned int part;
> +};
>  
>  #if defined(CONFIG_DFU_NAME_MAX_SIZE)
>  #define DFU_NAME_SIZE			CONFIG_DFU_NAME_MAX_SIZE
>  #else
> @@ -126,8 +139,9 @@ struct dfu_entity {
>  		struct nand_internal_data nand;
>  		struct ram_internal_data ram;
>  		struct sf_internal_data sf;
>  		struct virt_internal_data virt;
> +		struct scsi_internal_data scsi;
>  	} data;
>  
>  	int (*get_medium_size)(struct dfu_entity *dfu, u64 *size);
>  
> @@ -516,8 +530,20 @@ static inline int dfu_fill_entity_virt(struct dfu_entity *dfu, char *devstr,
>  	return -1;
>  }
>  #endif
>  
> +#if CONFIG_IS_ENABLED(DFU_SCSI)
> +int dfu_fill_entity_scsi(struct dfu_entity *dfu, char *devstr,
> +			 char **argv, int argc);
> +#else
> +static inline int dfu_fill_entity_scsi(struct dfu_entity *dfu, char *devstr,
> +				       char **argv, int argc)
> +{
> +	puts("SCSI support not available!\n");
> +	return -1;
> +}
> +#endif
> +
>  extern bool dfu_reinit_needed;
>  
>  #if CONFIG_IS_ENABLED(DFU_WRITE_ALT)
>  /**
>
> -- 
> 2.44.0
