Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 684CDCD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 11:11:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBBB484B56;
	Fri,  8 May 2026 13:11:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="GYbj+PI6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D1CF84C72; Fri,  8 May 2026 13:11:19 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8F0984AE9
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 13:11:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gBmdb1nwbz9svR;
 Fri,  8 May 2026 13:11:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778238675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=et4cfs4TcIC0X9IJFfI8nb3Q1srSyrlXcAb6B11jOsI=;
 b=GYbj+PI6Wsrzg7SDzrGcAdCQrVdKsnS20N3XleUOP4Fe/swDGMR9k1mtE/aZMqJOETO693
 BoqeBEpvWNUePs+XPA3Wn95GythxaKGZGGmGuTz+1UzxkJdoaghEriU4PMjQatritHNXLb
 7Ujk1qX1dMWxIQfk4V6Bv2Z5/sbQr4oY5JbwIWljT7efgidleEknFZcqYZuE94ahm2oSMQ
 dNbYTpKRG+aWKlVu+hgFItL4J2RaMZhUeMmAJ4zdc2DxcC3+exAdWFtyxf+SSTVyAJA8qS
 TQ/x3qz2wwy4xJiC+K5P+lk5u1QcSr75tLw+SEl+PYhL9sW1NiMDiRJxPVLI/w==
Message-ID: <71c7c3e5-9047-4957-95fb-814ca90414e7@mailbox.org>
Date: Fri, 8 May 2026 13:11:14 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/5] board: freebox: nbx10g: add emmcboot for dual-bank
 eMMC boot
To: Vincent Jardin <vjardin@free.fr>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <cover.1776762022.git.vjardin@free.fr>
 <6818abdc90f2ad2fbf8c5fdb0e97aa5ccc577007.1776762022.git.vjardin@free.fr>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <6818abdc90f2ad2fbf8c5fdb0e97aa5ccc577007.1776762022.git.vjardin@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 6jjyortggr3r533scyn3epbxq4kbr4eu
X-MBO-RS-ID: 21b1418e93e274ab1de
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

On 4/21/26 11:04, Vincent Jardin wrote:
> Add the emmcboot command as board-specific support for the Nodebox 10G.
> 
> This is a legacy boot format that has been in production on this board
> for many years so it cannot change anymore. It implements a dual-bank
> boot system for reliable firmware updates:
> 
> - Bank0: Stable/fallback boot image
> - Bank1: Newer/test boot image with reboot tracking
> 
> The boot order depends on the nrboot counter stored in eMMC:
> - Healthy state (counter < 4): Try Bank1 first, then Bank0
> - Degraded state (counter >= 4): Try Bank0 first, then Bank1
> 
> Each bank stores an image tag with CRC32 validation. The counter uses
> a bit-counting scheme for wear leveling and tracks consecutive failed
> boots to trigger automatic fallback.
> 
> Signed-off-by: Vincent Jardin <vjardin@free.fr>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan

> ---
>   board/freebox/nbx10g/Kconfig        |  53 +++++
>   board/freebox/nbx10g/Makefile       |   1 +
>   board/freebox/nbx10g/nbx_emmcboot.c | 357 ++++++++++++++++++++++++++++
>   board/freebox/nbx10g/nbx_imagetag.h |  78 ++++++
>   board/freebox/nbx10g/nbx_nrboot.h   |  34 +++
>   5 files changed, 523 insertions(+)
>   create mode 100644 board/freebox/nbx10g/nbx_emmcboot.c
>   create mode 100644 board/freebox/nbx10g/nbx_imagetag.h
>   create mode 100644 board/freebox/nbx10g/nbx_nrboot.h
> 
> diff --git a/board/freebox/nbx10g/Kconfig b/board/freebox/nbx10g/Kconfig
> index 18a169761b7..d21153eae75 100644
> --- a/board/freebox/nbx10g/Kconfig
> +++ b/board/freebox/nbx10g/Kconfig
> @@ -9,4 +9,57 @@ config SYS_VENDOR
>   config SYS_CONFIG_NAME
>   	default "nbx10g"
>   
> +config CMD_NBX_EMMCBOOT
> +	bool "emmcboot command"
> +	depends on MMC_SDHCI_XENON
> +	help
> +	  Enable the emmcboot command for dual-bank boot from eMMC.
> +	  This is a legacy boot format used on this board for many years.
> +	  It implements a boot system with two image banks and automatic
> +	  fallback on boot failures. The boot order depends on a reboot
> +	  tracking counter (nrboot):
> +	  - If healthy: try Bank1 (newer) first, then Bank0 (stable)
> +	  - If degraded (>= 4 failures): try Bank0 first, then Bank1
> +
> +	  Requires image_addr and fdt_addr environment variables to be set.
> +
> +if CMD_NBX_EMMCBOOT
> +
> +config NBX_MMC_PART_NRBOOT_OFFSET
> +	hex "NRBoot counter offset in eMMC"
> +	default 0x802000
> +	help
> +	  Byte offset in eMMC where the reboot tracking counter is stored.
> +	  Default: 0x802000 (8MB + 8KB)
> +
> +config NBX_MMC_PART_BANK0_OFFSET
> +	hex "Bank0 image offset in eMMC"
> +	default 0x804000
> +	help
> +	  Byte offset in eMMC where the stable (Bank0) boot image starts.
> +	  Default: 0x804000 (8MB + 16KB)
> +
> +config NBX_MMC_PART_BANK0_SIZE
> +	hex "Bank0 image maximum size"
> +	default 0x10000000
> +	help
> +	  Maximum size of the Bank0 boot image.
> +	  Default: 0x10000000 (256MB)
> +
> +config NBX_MMC_PART_BANK1_OFFSET
> +	hex "Bank1 image offset in eMMC"
> +	default 0x10804000
> +	help
> +	  Byte offset in eMMC where the newer (Bank1) boot image starts.
> +	  Default: 0x10804000 (264MB + 16KB)
> +
> +config NBX_MMC_PART_BANK1_SIZE
> +	hex "Bank1 image maximum size"
> +	default 0x10000000
> +	help
> +	  Maximum size of the Bank1 boot image.
> +	  Default: 0x10000000 (256MB)
> +
> +endif
> +
>   endif
> diff --git a/board/freebox/nbx10g/Makefile b/board/freebox/nbx10g/Makefile
> index bf83bdf63ee..a3b3d3a1fe3 100644
> --- a/board/freebox/nbx10g/Makefile
> +++ b/board/freebox/nbx10g/Makefile
> @@ -1,3 +1,4 @@
>   # SPDX-License-Identifier: GPL-2.0+
>   
>   obj-y	:= board.o
> +obj-$(CONFIG_CMD_NBX_EMMCBOOT)	+= nbx_emmcboot.o
> diff --git a/board/freebox/nbx10g/nbx_emmcboot.c b/board/freebox/nbx10g/nbx_emmcboot.c
> new file mode 100644
> index 00000000000..0bea96fadd9
> --- /dev/null
> +++ b/board/freebox/nbx10g/nbx_emmcboot.c
> @@ -0,0 +1,357 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Nodebox 10G dual-bank eMMC boot command with automatic fallback
> + *
> + * Copyright (C) 2026 Free Mobile, Freebox
> + *
> + * This implements a dual-bank boot system with automatic fallback:
> + * - Bank0: Stable/fallback boot image
> + * - Bank1: Newer/test boot image
> + *
> + * The boot order depends on the reboot tracking counter (nrboot):
> + * - If healthy: try Bank1 first, then Bank0
> + * - If degraded (>= 4 failures): try Bank0 first, then Bank1
> + */
> +
> +#include <command.h>
> +#include <env.h>
> +#include <mmc.h>
> +#include <malloc.h>
> +#include <memalign.h>
> +#include <vsprintf.h>
> +#include <u-boot/crc.h>
> +#include <u-boot/schedule.h>
> +#include <asm/byteorder.h>
> +#include <linux/errno.h>
> +#include "nbx_imagetag.h"
> +#include "nbx_nrboot.h"
> +
> +/* Partition offsets defined in Kconfig (CONFIG_NBX_MMC_PART_*) */
> +
> +/* Image Tag Functions */
> +
> +static int mvebu_imagetag_check(struct mvebu_image_tag *tag,
> +				unsigned long maxsize, const char *name)
> +{
> +	if (be32_to_cpu(tag->magic) != MVEBU_IMAGE_TAG_MAGIC) {
> +		if (name)
> +			printf("%s: invalid TAG magic: %.8x\n", name,
> +			       be32_to_cpu(tag->magic));
> +		return -EINVAL;
> +	}
> +
> +	if (be32_to_cpu(tag->version) != MVEBU_IMAGE_TAG_VERSION) {
> +		if (name)
> +			printf("%s: invalid TAG version: %.8x\n", name,
> +			       be32_to_cpu(tag->version));
> +		return -EINVAL;
> +	}
> +
> +	if (be32_to_cpu(tag->total_size) < sizeof(*tag)) {
> +		if (name)
> +			printf("%s: tag size is too small!\n", name);
> +		return -EINVAL;
> +	}
> +
> +	if (be32_to_cpu(tag->total_size) > maxsize) {
> +		if (name)
> +			printf("%s: tag size is too big!\n", name);
> +		return -EINVAL;
> +	}
> +
> +	if (be32_to_cpu(tag->device_tree_offset) < sizeof(*tag) ||
> +	    be32_to_cpu(tag->device_tree_offset) +
> +	    be32_to_cpu(tag->device_tree_size) > maxsize) {
> +		if (name)
> +			printf("%s: bogus device tree offset/size!\n", name);
> +		return -EINVAL;
> +	}
> +
> +	if (be32_to_cpu(tag->kernel_offset) < sizeof(*tag) ||
> +	    be32_to_cpu(tag->kernel_offset) +
> +	    be32_to_cpu(tag->kernel_size) > maxsize) {
> +		if (name)
> +			printf("%s: bogus kernel offset/size!\n", name);
> +		return -EINVAL;
> +	}
> +
> +	if (be32_to_cpu(tag->rootfs_offset) < sizeof(*tag) ||
> +	    be32_to_cpu(tag->rootfs_offset) +
> +	    be32_to_cpu(tag->rootfs_size) > maxsize) {
> +		if (name)
> +			printf("%s: bogus rootfs offset/size!\n", name);
> +		return -EINVAL;
> +	}
> +
> +	if (name) {
> +		/*
> +		 * Ensure null-termination within the 32-byte fields
> +		 * before printing to avoid displaying garbage.
> +		 */
> +		tag->image_name[sizeof(tag->image_name) - 1] = '\0';
> +		tag->build_date[sizeof(tag->build_date) - 1] = '\0';
> +		tag->build_user[sizeof(tag->build_user) - 1] = '\0';
> +
> +		printf("%s: Found valid tag: %s / %s / %s\n", name,
> +		       tag->image_name, tag->build_date, tag->build_user);
> +	}
> +
> +	return 0;
> +}
> +
> +static int mvebu_imagetag_crc(struct mvebu_image_tag *tag, const char *name)
> +{
> +	u32 crc = ~0;
> +
> +	crc = crc32(crc, ((unsigned char *)tag) + 4,
> +		    be32_to_cpu(tag->total_size) - 4);
> +
> +	if (be32_to_cpu(tag->crc) != crc) {
> +		if (name)
> +			printf("%s: invalid tag CRC!\n", name);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +/* NRBoot (Reboot Tracking) Functions */
> +
> +struct mvebu_nrboot {
> +	u16 nrboot;
> +	u16 nrsuccess;
> +};
> +
> +#define MVEBU_MAX_FAILURE	4
> +
> +static int mvebu_count_bits(u16 val)
> +{
> +	int i, found = 0;
> +
> +	for (i = 0; i < 16; i++) {
> +		if (val & (1 << i))
> +			found++;
> +	}
> +	return found;
> +}
> +
> +int mvebu_check_nrboot(struct mmc *mmc, unsigned long offset)
> +{
> +	struct blk_desc *bd = mmc_get_blk_desc(mmc);
> +	struct mvebu_nrboot *nr;
> +	uint blk_start = ALIGN(offset, bd->blksz) / bd->blksz;
> +	uint blk_cnt = ALIGN(sizeof(*nr), bd->blksz) / bd->blksz;
> +	uint n;
> +
> +	ALLOC_CACHE_ALIGN_BUFFER(char, buf, blk_cnt * bd->blksz);
> +	nr = (void *)buf;
> +
> +	n = blk_dread(bd, blk_start, blk_cnt, buf);
> +	if (n != blk_cnt)
> +		return 0;
> +
> +	printf(" - nr.nrboot = %04x\n", nr->nrboot);
> +	printf(" - nr.nrsuccess = %04x\n", nr->nrsuccess);
> +
> +	/* Sanity check on values */
> +	if (mvebu_count_bits(~nr->nrboot + 1) <= 1 &&
> +	    mvebu_count_bits(~nr->nrsuccess + 1) <= 1) {
> +		int boot, success;
> +
> +		boot = 16 - mvebu_count_bits(nr->nrboot);
> +		success = 16 - mvebu_count_bits(nr->nrsuccess);
> +
> +		printf(" - Nrboot: %d / Nrsuccess: %d\n", boot, success);
> +
> +		if (boot == 16 || boot < success ||
> +		    boot - success >= MVEBU_MAX_FAILURE) {
> +			printf(" - Nrboot exceeded\n");
> +			return 0;
> +		}
> +
> +		/* Increment boot attempt counter */
> +		boot++;
> +		nr->nrboot = ~((1 << boot) - 1);
> +
> +		printf(" - Setting Nrboot to %d\n", boot);
> +
> +		n = blk_dwrite(bd, blk_start, blk_cnt, buf);
> +		if (n != blk_cnt)
> +			return 0;
> +
> +		return 1;
> +	}
> +
> +	printf(" - Invalid NR values\n");
> +
> +	return 0;
> +}
> +
> +/* emmcboot Command */
> +
> +static void mvebu_try_emmcboot(struct mmc *mmc, unsigned long offset,
> +			       unsigned long maxsize, const char *bank)
> +{
> +	struct blk_desc *bd = mmc_get_blk_desc(mmc);
> +	struct mvebu_image_tag *tag;
> +	ulong image_addr = 0;
> +	ulong fdt_addr = 0;
> +	ulong tag_addr;
> +	uint tag_blk_start = ALIGN(offset, bd->blksz) / bd->blksz;
> +	uint tag_blk_cnt = ALIGN(sizeof(*tag), bd->blksz) / bd->blksz;
> +	uint n;
> +
> +	ALLOC_CACHE_ALIGN_BUFFER(char, tag_buf, tag_blk_cnt * bd->blksz);
> +	tag = (void *)tag_buf;
> +
> +	schedule();
> +
> +	printf("## Trying %s boot...\n", bank);
> +
> +	/* Load tag header */
> +	n = blk_dread(bd, tag_blk_start, tag_blk_cnt, tag_buf);
> +	if (n != tag_blk_cnt) {
> +		printf("%s: failed to read tag header\n", bank);
> +		return;
> +	}
> +
> +	if (mvebu_imagetag_check(tag, maxsize, bank) != 0)
> +		return;
> +
> +	if (tag->rootfs_size != 0) {
> +		printf("%s: rootfs in tag not supported\n", bank);
> +		return;
> +	}
> +
> +	/* Get image and device tree load addresses from environment */
> +	image_addr = env_get_ulong("image_addr", 16, 0);
> +	if (!image_addr) {
> +		puts("emmcboot needs image_addr\n");
> +		return;
> +	}
> +
> +	fdt_addr = env_get_ulong("fdt_addr", 16, 0);
> +	if (!fdt_addr) {
> +		puts("emmcboot needs fdt_addr\n");
> +		return;
> +	}
> +
> +	tag_addr = image_addr;
> +
> +	/* Load full image, temporarily reuse image_addr for this */
> +	{
> +		uint data_blk_start = ALIGN(offset, bd->blksz) / bd->blksz;
> +		uint data_blk_cnt = ALIGN(mvebu_imagetag_total_size(tag),
> +					  bd->blksz) / bd->blksz;
> +
> +		n = blk_dread(bd, data_blk_start, data_blk_cnt, (void *)tag_addr);
> +		if (n != data_blk_cnt) {
> +			printf("%s: failed to read full image\n", bank);
> +			return;
> +		}
> +
> +		if (mvebu_imagetag_crc((void *)tag_addr, bank) != 0)
> +			return;
> +	}
> +
> +	schedule();
> +
> +	/* Copy image and device tree to the right addresses */
> +	/* We assume that image_addr + tag_size < fdt_addr */
> +	{
> +		tag = (void *)tag_addr;
> +		memcpy((void *)fdt_addr,
> +		       ((void *)tag_addr) + mvebu_imagetag_device_tree_offset(tag),
> +		       mvebu_imagetag_device_tree_size(tag));
> +		memmove((void *)image_addr,
> +			((void *)tag_addr) + mvebu_imagetag_kernel_offset(tag),
> +			mvebu_imagetag_kernel_size(tag));
> +	}
> +
> +	schedule();
> +
> +	/* Set bootargs and boot */
> +	{
> +		char bootargs[256];
> +		char *console_env;
> +
> +		console_env = env_get("console");
> +		if (console_env)
> +			snprintf(bootargs, sizeof(bootargs), "%s bank=%s",
> +				 console_env, bank);
> +		else
> +			snprintf(bootargs, sizeof(bootargs), "bank=%s", bank);
> +
> +		env_set("bootargs", bootargs);
> +
> +		printf("## Booting kernel from %s...\n", bank);
> +		printf("   Image addr: 0x%lx\n", image_addr);
> +		printf("   FDT addr:   0x%lx\n", fdt_addr);
> +
> +		/* Build and run booti command */
> +		{
> +			char cmd[128];
> +
> +			snprintf(cmd, sizeof(cmd), "booti 0x%lx - 0x%lx",
> +				 image_addr, fdt_addr);
> +			run_command(cmd, 0);
> +		}
> +	}
> +
> +	printf("## %s boot failed\n", bank);
> +}
> +
> +static int do_emmcboot(struct cmd_tbl *cmdtp, int flag, int argc,
> +		       char *const argv[])
> +{
> +	int dev;
> +	struct mmc *mmc;
> +
> +	dev = 0;
> +	if (argc >= 2)
> +		dev = dectoul(argv[1], NULL);
> +
> +	mmc = find_mmc_device(dev);
> +	if (!mmc) {
> +		printf("No MMC device %d found\n", dev);
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	if (mmc_init(mmc)) {
> +		puts("MMC init failed\n");
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	/* Switch to partition 0 (user data area) */
> +	if (blk_select_hwpart_devnum(UCLASS_MMC, dev, 0)) {
> +		puts("MMC partition switch failed\n");
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	if (mvebu_check_nrboot(mmc, CONFIG_NBX_MMC_PART_NRBOOT_OFFSET)) {
> +		/* System is healthy: try newer bank first */
> +		mvebu_try_emmcboot(mmc, CONFIG_NBX_MMC_PART_BANK1_OFFSET,
> +				   CONFIG_NBX_MMC_PART_BANK1_SIZE, "bank1");
> +		mvebu_try_emmcboot(mmc, CONFIG_NBX_MMC_PART_BANK0_OFFSET,
> +				   CONFIG_NBX_MMC_PART_BANK0_SIZE, "bank0");
> +	} else {
> +		/* System is degraded: use stable bank first */
> +		mvebu_try_emmcboot(mmc, CONFIG_NBX_MMC_PART_BANK0_OFFSET,
> +				   CONFIG_NBX_MMC_PART_BANK0_SIZE, "bank0");
> +		mvebu_try_emmcboot(mmc, CONFIG_NBX_MMC_PART_BANK1_OFFSET,
> +				   CONFIG_NBX_MMC_PART_BANK1_SIZE, "bank1");
> +	}
> +
> +	puts("emmcboot: all boot attempts failed\n");
> +	return CMD_RET_FAILURE;
> +}
> +
> +U_BOOT_CMD(
> +	emmcboot, 2, 0, do_emmcboot,
> +	"boot from MVEBU eMMC image banks",
> +	"[dev]\n"
> +	"    - Boot from eMMC device <dev> (default 0)\n"
> +	"    - Requires image_addr and fdt_addr environment variables\n"
> +	"    - Uses dual-bank boot with automatic fallback\n"
> +	"    - Bank selection based on reboot tracking (nrboot)"
> +);
> diff --git a/board/freebox/nbx10g/nbx_imagetag.h b/board/freebox/nbx10g/nbx_imagetag.h
> new file mode 100644
> index 00000000000..999293dd58a
> --- /dev/null
> +++ b/board/freebox/nbx10g/nbx_imagetag.h
> @@ -0,0 +1,78 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * MVEBU Image Tag header
> + *
> + * Copyright (C) 2026 Free Mobile, Freebox
> + */
> +
> +#ifndef __MVEBU_IMAGETAG_H
> +#define __MVEBU_IMAGETAG_H
> +
> +#include <linux/types.h>
> +
> +#define MVEBU_IMAGE_TAG_MAGIC	0x8d7c90bc
> +#define MVEBU_IMAGE_TAG_VERSION	1
> +
> +/**
> + * struct mvebu_image_tag - MVEBU boot image tag structure
> + *
> + * All multi-byte fields are stored in big-endian format.
> + */
> +struct mvebu_image_tag {
> +	u32 crc;			/* CRC32-LE checksum (from offset 4) */
> +	u32 magic;			/* Magic: 0x8d7c90bc */
> +	u32 version;			/* Version: 1 */
> +	u32 total_size;			/* Total image size including tag */
> +	u32 flags;			/* Feature flags (reserved) */
> +
> +	u32 device_tree_offset;		/* Offset from tag start to DTB */
> +	u32 device_tree_size;		/* DTB size in bytes */
> +
> +	u32 kernel_offset;		/* Offset from tag start to kernel */
> +	u32 kernel_size;		/* Kernel size in bytes */
> +
> +	u32 rootfs_offset;		/* Offset from tag start to rootfs */
> +	u32 rootfs_size;		/* Rootfs size (must be 0) */
> +
> +	char image_name[32];		/* Image name (null-terminated) */
> +	char build_user[32];		/* Build user info */
> +	char build_date[32];		/* Build date info */
> +};
> +
> +/* Accessor functions for big-endian fields */
> +static inline u32 mvebu_imagetag_device_tree_offset(struct mvebu_image_tag *tag)
> +{
> +	return be32_to_cpu(tag->device_tree_offset);
> +}
> +
> +static inline u32 mvebu_imagetag_device_tree_size(struct mvebu_image_tag *tag)
> +{
> +	return be32_to_cpu(tag->device_tree_size);
> +}
> +
> +static inline u32 mvebu_imagetag_kernel_offset(struct mvebu_image_tag *tag)
> +{
> +	return be32_to_cpu(tag->kernel_offset);
> +}
> +
> +static inline u32 mvebu_imagetag_kernel_size(struct mvebu_image_tag *tag)
> +{
> +	return be32_to_cpu(tag->kernel_size);
> +}
> +
> +static inline u32 mvebu_imagetag_rootfs_offset(struct mvebu_image_tag *tag)
> +{
> +	return be32_to_cpu(tag->rootfs_offset);
> +}
> +
> +static inline u32 mvebu_imagetag_rootfs_size(struct mvebu_image_tag *tag)
> +{
> +	return be32_to_cpu(tag->rootfs_size);
> +}
> +
> +static inline u32 mvebu_imagetag_total_size(struct mvebu_image_tag *tag)
> +{
> +	return be32_to_cpu(tag->total_size);
> +}
> +
> +#endif /* __MVEBU_IMAGETAG_H */
> diff --git a/board/freebox/nbx10g/nbx_nrboot.h b/board/freebox/nbx10g/nbx_nrboot.h
> new file mode 100644
> index 00000000000..91c9fb2e57b
> --- /dev/null
> +++ b/board/freebox/nbx10g/nbx_nrboot.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * MVEBU NRBoot (Number of Reboots) tracking header
> + *
> + * Copyright (C) 2026 Free Mobile, Freebox
> + */
> +
> +#ifndef __MVEBU_NRBOOT_H
> +#define __MVEBU_NRBOOT_H
> +
> +#include <mmc.h>
> +
> +/**
> + * mvebu_check_nrboot() - Check and update reboot tracking counter
> + * @mmc: MMC device
> + * @offset: Byte offset in MMC where nrboot data is stored
> + *
> + * This function reads the reboot tracking counter, checks if we've
> + * exceeded the maximum number of failed boots (4), and updates the
> + * counter for the current boot attempt.
> + *
> + * The counter uses a bit-field encoding:
> + * - nrboot: Running count of boot attempts
> + * - nrsuccess: Count of successful boots
> + *
> + * If boot - success >= MAX_FAILURE (4), the system is considered
> + * degraded and should use the fallback boot bank.
> + *
> + * Return: 1 if system is healthy (try newer bank first),
> + *         0 if system is degraded (use stable bank first)
> + */
> +int mvebu_check_nrboot(struct mmc *mmc, unsigned long offset);
> +
> +#endif /* __MVEBU_NRBOOT_H */

