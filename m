Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 573F9C46CD4
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 07:33:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB2BB87A17;
	Fri, 29 Dec 2023 08:33:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="So4v8haH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B1A787575; Fri, 29 Dec 2023 08:33:46 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BC2587A17
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 08:33:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-555144cd330so3622442a12.2
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 23:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703835222; x=1704440022; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JqaLCxZfiWpGDvVkQRO+6HxxFJwJGYIq9pvaFRFooGI=;
 b=So4v8haH0bCwHKbkFPhlCwIagzEy/D//eKBo2okuL4CmcMChKZcg+OBMD+SBA9BuIQ
 sMuPka4NqMoMSUuyqNVgKc1XPXt8Xwu9SQg27EsMZ8+yVXTm7rcqeEApRZheeJx0EWnV
 racLWhDYDOizS38ST0uiaLReBDWTdW0yQz/TNYlNy9AkZQ2w7ZxvKqLTyYmh9S+Lddp1
 PV9KwSl4lAsLeaEfBw3h89STnM65bvxY5B0sNa2SaokBuRGbylMfxv7TduzB7fwCW/Hk
 HYx05YUQJEVIXKHGHR8nCa+3MK5oiJGcqEwlz1uuVvKyk3kS88enDPR7TM5NVM27yejR
 80WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703835222; x=1704440022;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JqaLCxZfiWpGDvVkQRO+6HxxFJwJGYIq9pvaFRFooGI=;
 b=kckqr/oPwH7qaL5PoJr9mOuqXDPJPrXXmMtaHkUjJzprAj9/hjdIBIpySZbL7XRWaD
 oamnQhLOGfm8yfOOoPYFtv4rwWI3O22zKfrl3hf+Fx1Zq+V/e9Gbs8q74h55KjntzIEN
 +cJRX1F2dGcOqJMki/kk/D0ts172r+68JzilHMuo1grIrm1+ln7UC3t46osZjgDwEHr1
 EoaL5YRa6ax3CeslU9aGeDXuh15iH4ysw34ovEIInQAHLPmc6g6qpmd7q5RaMHV9Ecma
 nDunqy8A32MLFSR9Nfh3i3XXSGvt0jVD7SgUaxiSI04pFVC7pXpBrTX9DXQhK1ZAalkm
 GZAA==
X-Gm-Message-State: AOJu0Yzp1nmzqnma7ehUE33luUHSPTQnecj2exj9PE5A3EXd5xKcd7XX
 NPCGrsd8X7LseEAB7FgrALgweAfpqcBoW3v28Ao9N6k0A3o=
X-Google-Smtp-Source: AGHT+IHQMtn11fCsBqNdzCI4pbc78xHcqAWjQzMXX3xyhmvzFNALjz4gZ8zGcTZgnQ3g4y428tMUXA==
X-Received: by 2002:a50:cd16:0:b0:554:1171:4495 with SMTP id
 z22-20020a50cd16000000b0055411714495mr7600573edi.23.1703835222436; 
 Thu, 28 Dec 2023 23:33:42 -0800 (PST)
Received: from hades (ppp089210121239.access.hol.gr. [89.210.121.239])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a056402110c00b0054c9211021csm10619772edv.69.2023.12.28.23.33.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 23:33:42 -0800 (PST)
Date: Fri, 29 Dec 2023 09:33:39 +0200
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v4 2/9] acpi: carve out qfw_acpi.c
Message-ID: <ZY52U+OgRMx9dLAl@hades>
References: <20231219150408.10949-1-heinrich.schuchardt@canonical.com>
 <20231219150408.10949-3-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219150408.10949-3-heinrich.schuchardt@canonical.com>
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

On Tue, Dec 19, 2023 at 04:04:01PM +0100, Heinrich Schuchardt wrote:
> Move the code related to copying tables from QEMU to a separate code
> module.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> v4:
> 	no change
> v3:
> 	no change
> v2:
> 	add missing blank line
> ---
>  drivers/misc/Makefile   |   1 +
>  drivers/misc/qfw.c      | 240 -------------------------------------
>  drivers/misc/qfw_acpi.c | 256 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 257 insertions(+), 240 deletions(-)
>  create mode 100644 drivers/misc/qfw_acpi.c

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> 
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index b67b82358a..cda701d38e 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -63,6 +63,7 @@ obj-$(CONFIG_$(SPL_)PWRSEQ) += pwrseq-uclass.o
>  obj-$(CONFIG_QCOM_GENI_SE) += qcom-geni-se.o
>  ifdef CONFIG_QFW
>  obj-y += qfw.o
> +obj-$(CONFIG_QFW_ACPI) += qfw_acpi.o
>  obj-$(CONFIG_QFW_PIO) += qfw_pio.o
>  obj-$(CONFIG_QFW_MMIO) += qfw_mmio.o
>  obj-$(CONFIG_SANDBOX) += qfw_sandbox.o
> diff --git a/drivers/misc/qfw.c b/drivers/misc/qfw.c
> index 307334faf4..db98619fdf 100644
> --- a/drivers/misc/qfw.c
> +++ b/drivers/misc/qfw.c
> @@ -21,246 +21,6 @@
>  #include <tables_csum.h>
>  #include <asm/acpi_table.h>
>  
> -#ifdef QFW_ACPI
> -/*
> - * This function allocates memory for ACPI tables
> - *
> - * @entry : BIOS linker command entry which tells where to allocate memory
> - *          (either high memory or low memory)
> - * @addr  : The address that should be used for low memory allcation. If the
> - *          memory allocation request is 'ZONE_HIGH' then this parameter will
> - *          be ignored.
> - * @return: 0 on success, or negative value on failure
> - */
> -static int bios_linker_allocate(struct udevice *dev,
> -				struct bios_linker_entry *entry, ulong *addr)
> -{
> -	uint32_t size, align;
> -	struct fw_file *file;
> -	unsigned long aligned_addr;
> -
> -	align = le32_to_cpu(entry->alloc.align);
> -	/* align must be power of 2 */
> -	if (align & (align - 1)) {
> -		printf("error: wrong alignment %u\n", align);
> -		return -EINVAL;
> -	}
> -
> -	file = qfw_find_file(dev, entry->alloc.file);
> -	if (!file) {
> -		printf("error: can't find file %s\n", entry->alloc.file);
> -		return -ENOENT;
> -	}
> -
> -	size = be32_to_cpu(file->cfg.size);
> -
> -	/*
> -	 * ZONE_HIGH means we need to allocate from high memory, since
> -	 * malloc space is already at the end of RAM, so we directly use it.
> -	 * If allocation zone is ZONE_FSEG, then we use the 'addr' passed
> -	 * in which is low memory
> -	 */
> -	if (entry->alloc.zone == BIOS_LINKER_LOADER_ALLOC_ZONE_HIGH) {
> -		aligned_addr = (unsigned long)memalign(align, size);
> -		if (!aligned_addr) {
> -			printf("error: allocating resource\n");
> -			return -ENOMEM;
> -		}
> -		if (aligned_addr < gd->arch.table_start_high)
> -			gd->arch.table_start_high = aligned_addr;
> -		if (aligned_addr + size > gd->arch.table_end_high)
> -			gd->arch.table_end_high = aligned_addr + size;
> -
> -	} else if (entry->alloc.zone == BIOS_LINKER_LOADER_ALLOC_ZONE_FSEG) {
> -		aligned_addr = ALIGN(*addr, align);
> -	} else {
> -		printf("error: invalid allocation zone\n");
> -		return -EINVAL;
> -	}
> -
> -	debug("bios_linker_allocate: allocate file %s, size %u, zone %d, align %u, addr 0x%lx\n",
> -	      file->cfg.name, size, entry->alloc.zone, align, aligned_addr);
> -
> -	qfw_read_entry(dev, be16_to_cpu(file->cfg.select), size,
> -		       (void *)aligned_addr);
> -	file->addr = aligned_addr;
> -
> -	/* adjust address for low memory allocation */
> -	if (entry->alloc.zone == BIOS_LINKER_LOADER_ALLOC_ZONE_FSEG)
> -		*addr = (aligned_addr + size);
> -
> -	return 0;
> -}
> -
> -/*
> - * This function patches ACPI tables previously loaded
> - * by bios_linker_allocate()
> - *
> - * @entry : BIOS linker command entry which tells how to patch
> - *          ACPI tables
> - * @return: 0 on success, or negative value on failure
> - */
> -static int bios_linker_add_pointer(struct udevice *dev,
> -				   struct bios_linker_entry *entry)
> -{
> -	struct fw_file *dest, *src;
> -	uint32_t offset = le32_to_cpu(entry->pointer.offset);
> -	uint64_t pointer = 0;
> -
> -	dest = qfw_find_file(dev, entry->pointer.dest_file);
> -	if (!dest || !dest->addr)
> -		return -ENOENT;
> -	src = qfw_find_file(dev, entry->pointer.src_file);
> -	if (!src || !src->addr)
> -		return -ENOENT;
> -
> -	debug("bios_linker_add_pointer: dest->addr 0x%lx, src->addr 0x%lx, offset 0x%x size %u, 0x%llx\n",
> -	      dest->addr, src->addr, offset, entry->pointer.size, pointer);
> -
> -	memcpy(&pointer, (char *)dest->addr + offset, entry->pointer.size);
> -	pointer	= le64_to_cpu(pointer);
> -	pointer += (unsigned long)src->addr;
> -	pointer	= cpu_to_le64(pointer);
> -	memcpy((char *)dest->addr + offset, &pointer, entry->pointer.size);
> -
> -	return 0;
> -}
> -
> -/*
> - * This function updates checksum fields of ACPI tables previously loaded
> - * by bios_linker_allocate()
> - *
> - * @entry : BIOS linker command entry which tells where to update ACPI table
> - *          checksums
> - * @return: 0 on success, or negative value on failure
> - */
> -static int bios_linker_add_checksum(struct udevice *dev,
> -				    struct bios_linker_entry *entry)
> -{
> -	struct fw_file *file;
> -	uint8_t *data, cksum = 0;
> -	uint8_t *cksum_start;
> -
> -	file = qfw_find_file(dev, entry->cksum.file);
> -	if (!file || !file->addr)
> -		return -ENOENT;
> -
> -	data = (uint8_t *)(file->addr + le32_to_cpu(entry->cksum.offset));
> -	cksum_start = (uint8_t *)(file->addr + le32_to_cpu(entry->cksum.start));
> -	cksum = table_compute_checksum(cksum_start,
> -				       le32_to_cpu(entry->cksum.length));
> -	*data = cksum;
> -
> -	return 0;
> -}
> -
> -/* This function loads and patches ACPI tables provided by QEMU */
> -ulong write_acpi_tables(ulong addr)
> -{
> -	int i, ret;
> -	struct fw_file *file;
> -	struct bios_linker_entry *table_loader;
> -	struct bios_linker_entry *entry;
> -	uint32_t size;
> -	struct udevice *dev;
> -
> -	ret = qfw_get_dev(&dev);
> -	if (ret) {
> -		printf("error: no qfw\n");
> -		return addr;
> -	}
> -
> -	/* make sure fw_list is loaded */
> -	ret = qfw_read_firmware_list(dev);
> -	if (ret) {
> -		printf("error: can't read firmware file list\n");
> -		return addr;
> -	}
> -
> -	file = qfw_find_file(dev, "etc/table-loader");
> -	if (!file) {
> -		printf("error: can't find etc/table-loader\n");
> -		return addr;
> -	}
> -
> -	size = be32_to_cpu(file->cfg.size);
> -	if ((size % sizeof(*entry)) != 0) {
> -		printf("error: table-loader maybe corrupted\n");
> -		return addr;
> -	}
> -
> -	table_loader = malloc(size);
> -	if (!table_loader) {
> -		printf("error: no memory for table-loader\n");
> -		return addr;
> -	}
> -
> -	/* QFW always puts tables at high addresses */
> -	gd->arch.table_start_high = (ulong)table_loader;
> -	gd->arch.table_end_high = (ulong)table_loader;
> -
> -	qfw_read_entry(dev, be16_to_cpu(file->cfg.select), size, table_loader);
> -
> -	for (i = 0; i < (size / sizeof(*entry)); i++) {
> -		entry = table_loader + i;
> -		switch (le32_to_cpu(entry->command)) {
> -		case BIOS_LINKER_LOADER_COMMAND_ALLOCATE:
> -			ret = bios_linker_allocate(dev, entry, &addr);
> -			if (ret)
> -				goto out;
> -			break;
> -		case BIOS_LINKER_LOADER_COMMAND_ADD_POINTER:
> -			ret = bios_linker_add_pointer(dev, entry);
> -			if (ret)
> -				goto out;
> -			break;
> -		case BIOS_LINKER_LOADER_COMMAND_ADD_CHECKSUM:
> -			ret = bios_linker_add_checksum(dev, entry);
> -			if (ret)
> -				goto out;
> -			break;
> -		default:
> -			break;
> -		}
> -	}
> -
> -out:
> -	if (ret) {
> -		struct fw_cfg_file_iter iter;
> -		for (file = qfw_file_iter_init(dev, &iter);
> -		     !qfw_file_iter_end(&iter);
> -		     file = qfw_file_iter_next(&iter)) {
> -			if (file->addr) {
> -				free((void *)file->addr);
> -				file->addr = 0;
> -			}
> -		}
> -	}
> -
> -	free(table_loader);
> -
> -	gd_set_acpi_start(acpi_get_rsdp_addr());
> -
> -	return addr;
> -}
> -
> -ulong acpi_get_rsdp_addr(void)
> -{
> -	int ret;
> -	struct fw_file *file;
> -	struct udevice *dev;
> -
> -	ret = qfw_get_dev(&dev);
> -	if (ret) {
> -		printf("error: no qfw\n");
> -		return 0;
> -	}
> -
> -	file = qfw_find_file(dev, "etc/acpi/rsdp");
> -	return file->addr;
> -}
> -#endif /* QFW_ACPI */
> -
>  static void qfw_read_entry_io(struct qfw_dev *qdev, u16 entry, u32 size,
>  			      void *address)
>  {
> diff --git a/drivers/misc/qfw_acpi.c b/drivers/misc/qfw_acpi.c
> new file mode 100644
> index 0000000000..6e14b2a504
> --- /dev/null
> +++ b/drivers/misc/qfw_acpi.c
> @@ -0,0 +1,256 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * (C) Copyright 2015 Miao Yan <yanmiaobest@gmail.com>
> + * (C) Copyright 2021 Asherah Connor <ashe@kivikakk.ee>
> + */
> +
> +#define LOG_CATEGORY UCLASS_QFW
> +
> +#include <acpi/acpi_table.h>
> +#include <errno.h>
> +#include <malloc.h>
> +#include <qfw.h>
> +#include <tables_csum.h>
> +#include <stdio.h>
> +#include <asm/byteorder.h>
> +#include <asm/global_data.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +/*
> + * This function allocates memory for ACPI tables
> + *
> + * @entry : BIOS linker command entry which tells where to allocate memory
> + *          (either high memory or low memory)
> + * @addr  : The address that should be used for low memory allcation. If the
> + *          memory allocation request is 'ZONE_HIGH' then this parameter will
> + *          be ignored.
> + * @return: 0 on success, or negative value on failure
> + */
> +static int bios_linker_allocate(struct udevice *dev,
> +				struct bios_linker_entry *entry, ulong *addr)
> +{
> +	uint32_t size, align;
> +	struct fw_file *file;
> +	unsigned long aligned_addr;
> +
> +	align = le32_to_cpu(entry->alloc.align);
> +	/* align must be power of 2 */
> +	if (align & (align - 1)) {
> +		printf("error: wrong alignment %u\n", align);
> +		return -EINVAL;
> +	}
> +
> +	file = qfw_find_file(dev, entry->alloc.file);
> +	if (!file) {
> +		printf("error: can't find file %s\n", entry->alloc.file);
> +		return -ENOENT;
> +	}
> +
> +	size = be32_to_cpu(file->cfg.size);
> +
> +	/*
> +	 * ZONE_HIGH means we need to allocate from high memory, since
> +	 * malloc space is already at the end of RAM, so we directly use it.
> +	 * If allocation zone is ZONE_FSEG, then we use the 'addr' passed
> +	 * in which is low memory
> +	 */
> +	if (entry->alloc.zone == BIOS_LINKER_LOADER_ALLOC_ZONE_HIGH) {
> +		aligned_addr = (unsigned long)memalign(align, size);
> +		if (!aligned_addr) {
> +			printf("error: allocating resource\n");
> +			return -ENOMEM;
> +		}
> +		if (aligned_addr < gd->arch.table_start_high)
> +			gd->arch.table_start_high = aligned_addr;
> +		if (aligned_addr + size > gd->arch.table_end_high)
> +			gd->arch.table_end_high = aligned_addr + size;
> +
> +	} else if (entry->alloc.zone == BIOS_LINKER_LOADER_ALLOC_ZONE_FSEG) {
> +		aligned_addr = ALIGN(*addr, align);
> +	} else {
> +		printf("error: invalid allocation zone\n");
> +		return -EINVAL;
> +	}
> +
> +	debug("bios_linker_allocate: allocate file %s, size %u, zone %d, align %u, addr 0x%lx\n",
> +	      file->cfg.name, size, entry->alloc.zone, align, aligned_addr);
> +
> +	qfw_read_entry(dev, be16_to_cpu(file->cfg.select), size,
> +		       (void *)aligned_addr);
> +	file->addr = aligned_addr;
> +
> +	/* adjust address for low memory allocation */
> +	if (entry->alloc.zone == BIOS_LINKER_LOADER_ALLOC_ZONE_FSEG)
> +		*addr = (aligned_addr + size);
> +
> +	return 0;
> +}
> +
> +/*
> + * This function patches ACPI tables previously loaded
> + * by bios_linker_allocate()
> + *
> + * @entry : BIOS linker command entry which tells how to patch
> + *          ACPI tables
> + * @return: 0 on success, or negative value on failure
> + */
> +static int bios_linker_add_pointer(struct udevice *dev,
> +				   struct bios_linker_entry *entry)
> +{
> +	struct fw_file *dest, *src;
> +	uint32_t offset = le32_to_cpu(entry->pointer.offset);
> +	uint64_t pointer = 0;
> +
> +	dest = qfw_find_file(dev, entry->pointer.dest_file);
> +	if (!dest || !dest->addr)
> +		return -ENOENT;
> +	src = qfw_find_file(dev, entry->pointer.src_file);
> +	if (!src || !src->addr)
> +		return -ENOENT;
> +
> +	debug("bios_linker_add_pointer: dest->addr 0x%lx, src->addr 0x%lx, offset 0x%x size %u, 0x%llx\n",
> +	      dest->addr, src->addr, offset, entry->pointer.size, pointer);
> +
> +	memcpy(&pointer, (char *)dest->addr + offset, entry->pointer.size);
> +	pointer	= le64_to_cpu(pointer);
> +	pointer += (unsigned long)src->addr;
> +	pointer	= cpu_to_le64(pointer);
> +	memcpy((char *)dest->addr + offset, &pointer, entry->pointer.size);
> +
> +	return 0;
> +}
> +
> +/*
> + * This function updates checksum fields of ACPI tables previously loaded
> + * by bios_linker_allocate()
> + *
> + * @entry : BIOS linker command entry which tells where to update ACPI table
> + *          checksums
> + * @return: 0 on success, or negative value on failure
> + */
> +static int bios_linker_add_checksum(struct udevice *dev,
> +				    struct bios_linker_entry *entry)
> +{
> +	struct fw_file *file;
> +	uint8_t *data, cksum = 0;
> +	uint8_t *cksum_start;
> +
> +	file = qfw_find_file(dev, entry->cksum.file);
> +	if (!file || !file->addr)
> +		return -ENOENT;
> +
> +	data = (uint8_t *)(file->addr + le32_to_cpu(entry->cksum.offset));
> +	cksum_start = (uint8_t *)(file->addr + le32_to_cpu(entry->cksum.start));
> +	cksum = table_compute_checksum(cksum_start,
> +				       le32_to_cpu(entry->cksum.length));
> +	*data = cksum;
> +
> +	return 0;
> +}
> +
> +/* This function loads and patches ACPI tables provided by QEMU */
> +ulong write_acpi_tables(ulong addr)
> +{
> +	int i, ret;
> +	struct fw_file *file;
> +	struct bios_linker_entry *table_loader;
> +	struct bios_linker_entry *entry;
> +	uint32_t size;
> +	struct udevice *dev;
> +
> +	ret = qfw_get_dev(&dev);
> +	if (ret) {
> +		printf("error: no qfw\n");
> +		return addr;
> +	}
> +
> +	/* make sure fw_list is loaded */
> +	ret = qfw_read_firmware_list(dev);
> +	if (ret) {
> +		printf("error: can't read firmware file list\n");
> +		return addr;
> +	}
> +
> +	file = qfw_find_file(dev, "etc/table-loader");
> +	if (!file) {
> +		printf("error: can't find etc/table-loader\n");
> +		return addr;
> +	}
> +
> +	size = be32_to_cpu(file->cfg.size);
> +	if ((size % sizeof(*entry)) != 0) {
> +		printf("error: table-loader maybe corrupted\n");
> +		return addr;
> +	}
> +
> +	table_loader = malloc(size);
> +	if (!table_loader) {
> +		printf("error: no memory for table-loader\n");
> +		return addr;
> +	}
> +
> +	/* QFW always puts tables at high addresses */
> +	gd->arch.table_start_high = (ulong)table_loader;
> +	gd->arch.table_end_high = (ulong)table_loader;
> +
> +	qfw_read_entry(dev, be16_to_cpu(file->cfg.select), size, table_loader);
> +
> +	for (i = 0; i < (size / sizeof(*entry)); i++) {
> +		entry = table_loader + i;
> +		switch (le32_to_cpu(entry->command)) {
> +		case BIOS_LINKER_LOADER_COMMAND_ALLOCATE:
> +			ret = bios_linker_allocate(dev, entry, &addr);
> +			if (ret)
> +				goto out;
> +			break;
> +		case BIOS_LINKER_LOADER_COMMAND_ADD_POINTER:
> +			ret = bios_linker_add_pointer(dev, entry);
> +			if (ret)
> +				goto out;
> +			break;
> +		case BIOS_LINKER_LOADER_COMMAND_ADD_CHECKSUM:
> +			ret = bios_linker_add_checksum(dev, entry);
> +			if (ret)
> +				goto out;
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +out:
> +	if (ret) {
> +		struct fw_cfg_file_iter iter;
> +		for (file = qfw_file_iter_init(dev, &iter);
> +		     !qfw_file_iter_end(&iter);
> +		     file = qfw_file_iter_next(&iter)) {
> +			if (file->addr) {
> +				free((void *)file->addr);
> +				file->addr = 0;
> +			}
> +		}
> +	}
> +
> +	free(table_loader);
> +
> +	gd_set_acpi_start(acpi_get_rsdp_addr());
> +
> +	return addr;
> +}
> +
> +ulong acpi_get_rsdp_addr(void)
> +{
> +	int ret;
> +	struct fw_file *file;
> +	struct udevice *dev;
> +
> +	ret = qfw_get_dev(&dev);
> +	if (ret) {
> +		printf("error: no qfw\n");
> +		return 0;
> +	}
> +
> +	file = qfw_find_file(dev, "etc/acpi/rsdp");
> +	return file->addr;
> +}
> -- 
> 2.40.1
> 
