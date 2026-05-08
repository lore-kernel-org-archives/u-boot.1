Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E5D5CD3447
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 11:12:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20E8884B56;
	Fri,  8 May 2026 13:12:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="iytYoL4l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6305684AE9; Fri,  8 May 2026 13:11:58 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F92584C7A
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 13:11:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gBmfJ4yvwz9sjG;
 Fri,  8 May 2026 13:11:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778238712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7ASRSSE+dvWnq9D14iNaYEYDRyzJfvDFg06yrFI2220=;
 b=iytYoL4lRAsdxUzN0ukqBQk0HY2E99uo/dNvgmUbHGlS1+GNbKzAE0rpFjkH89SKX6jX99
 3nQBbRXKxnCrCeIRUHh/mKMmLM/eSyBiM+KoVadfe9n4m7hooaVU5dpdh89AZDv80/HtTg
 XJv9q5PZy0sIpQaAPof/ge+tmPH3hmh+1qxZw/S4k8knjynGzgQZxUov8MwJHvpMRvu116
 iV6/0ZleLb7ckFqqtWND+LroK0kva0ttE1TcPJRG0hlVwuyKswZ1oyHxsWS3XdsBycE0pK
 THk0Qw7P3rTpJ6Nauh/TnbaEEYHWnbKA3/8ZTJH9nAwrovc9p0eRrLG1E9SMWw==
Message-ID: <8f6ecb9b-422c-4776-8afd-0f2b1fb0d2af@mailbox.org>
Date: Fri, 8 May 2026 13:11:51 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/5] board: freebox: nbx10g: add device serial and MAC
 address initialization
To: Vincent Jardin <vjardin@free.fr>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <cover.1776762022.git.vjardin@free.fr>
 <a85b2e6bac5df2addc20154d3b2a73f7ec5a9642.1776762022.git.vjardin@free.fr>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <a85b2e6bac5df2addc20154d3b2a73f7ec5a9642.1776762022.git.vjardin@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 38hmeozyhwng3i5kp3y1tjyqswjfd14t
X-MBO-RS-ID: 21626f0b52c55e0e869
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
> Read device identification data from a dedicated eMMC region. This
> provides:
> 
> - Unique device serial number for identification and tracking
> - Factory-programmed MAC address for network interfaces
> - Bundle information for device variant identification
> 
> The serial structure includes CRC32 validation to detect corruption.
> On read failure or invalid data, sensible defaults are used to ensure
> the system remains bootable.
> 
> The fbxserial command provides two subcommands:
> - fbxserial show: Display serial info (default)
> - fbxserial init: Initialize ethaddr from serial info
> 
> Use CONFIG_PREBOOT="fbxserial init" to automatically set MAC addresses
> during boot. This approach avoids patching shared board code.
> 
> Signed-off-by: Vincent Jardin <vjardin@free.fr>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan


> ---
>   board/freebox/nbx10g/Kconfig         |  29 +++
>   board/freebox/nbx10g/Makefile        |   1 +
>   board/freebox/nbx10g/nbx_fbxserial.c | 286 +++++++++++++++++++++++++++
>   board/freebox/nbx10g/nbx_fbxserial.h | 156 +++++++++++++++
>   4 files changed, 472 insertions(+)
>   create mode 100644 board/freebox/nbx10g/nbx_fbxserial.c
>   create mode 100644 board/freebox/nbx10g/nbx_fbxserial.h
> 
> diff --git a/board/freebox/nbx10g/Kconfig b/board/freebox/nbx10g/Kconfig
> index d21153eae75..958c8fdd4c3 100644
> --- a/board/freebox/nbx10g/Kconfig
> +++ b/board/freebox/nbx10g/Kconfig
> @@ -62,4 +62,33 @@ config NBX_MMC_PART_BANK1_SIZE
>   
>   endif
>   
> +config CMD_NBX_FBXSERIAL
> +	bool "fbxserial command"
> +	depends on MMC_SDHCI_XENON
> +	help
> +	  Enable the fbxserial command to read and display device
> +	  serial information from eMMC. This includes:
> +	  - Device serial number (type, version, manufacturer, date, number)
> +	  - MAC address (used to set ethaddr environment variables)
> +	  - Bundle information (if present)
> +
> +	  The serial info is stored at a fixed offset in the eMMC user area.
> +
> +	  Subcommands:
> +	  - fbxserial show: display serial info (default)
> +	  - fbxserial init: initialize ethaddr from serial info
> +
> +	  Use CONFIG_PREBOOT="fbxserial init" to auto-initialize at boot.
> +
> +if CMD_NBX_FBXSERIAL
> +
> +config NBX_MMC_PART_SERIAL_OFFSET
> +	hex "Serial info offset in eMMC"
> +	default 0x800000
> +	help
> +	  Byte offset in eMMC where the serial info structure is stored.
> +	  Default: 0x800000 (8MB)
> +
> +endif
> +
>   endif
> diff --git a/board/freebox/nbx10g/Makefile b/board/freebox/nbx10g/Makefile
> index a3b3d3a1fe3..4b70d94e14d 100644
> --- a/board/freebox/nbx10g/Makefile
> +++ b/board/freebox/nbx10g/Makefile
> @@ -2,3 +2,4 @@
>   
>   obj-y	:= board.o
>   obj-$(CONFIG_CMD_NBX_EMMCBOOT)	+= nbx_emmcboot.o
> +obj-$(CONFIG_CMD_NBX_FBXSERIAL)	+= nbx_fbxserial.o
> diff --git a/board/freebox/nbx10g/nbx_fbxserial.c b/board/freebox/nbx10g/nbx_fbxserial.c
> new file mode 100644
> index 00000000000..088133a9496
> --- /dev/null
> +++ b/board/freebox/nbx10g/nbx_fbxserial.c
> @@ -0,0 +1,286 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * NBX Freebox Serial Info Support
> + *
> + * Copyright (C) 2025 Free Mobile, Freebox
> + *
> + * Reads device serial number and MAC address from eMMC.
> + * The serial info is stored at a fixed offset in the eMMC user area.
> + *
> + * Serial format: TTTT-VV-M-(YY)WW-NN-NNNNN / FLAGS
> + * Where:
> + *   TTTT  = Device type (e.g., 9018)
> + *   VV    = Board version
> + *   M     = Manufacturer code (ASCII)
> + *   YY    = Year (BCD)
> + *   WW    = Week (1-53)
> + *   NNNNN = Serial number
> + *   FLAGS = Feature flags
> + */
> +
> +#include <command.h>
> +#include <dm/device.h>
> +#include <env.h>
> +#include <event.h>
> +#include <mmc.h>
> +#include <malloc.h>
> +#include <memalign.h>
> +#include <vsprintf.h>
> +#include <u-boot/crc.h>
> +#include <asm/byteorder.h>
> +#include <linux/ctype.h>
> +#include <linux/errno.h>
> +#include "nbx_fbxserial.h"
> +
> +/* Partition offset defined in Kconfig (CONFIG_NBX_MMC_PART_SERIAL_OFFSET) */
> +
> +/*
> + * Validate serial info structure
> + */
> +static int nbx_fbx_check_serial(struct nbx_fbx_serial *fs)
> +{
> +	unsigned int sum, len;
> +
> +	/* Check magic first */
> +	if (be32_to_cpu(fs->magic) != NBX_FBXSERIAL_MAGIC) {
> +		printf("Invalid magic for serial info (%08x != %08x)!\n",
> +		       be32_to_cpu(fs->magic), NBX_FBXSERIAL_MAGIC);
> +		return -EINVAL;
> +	}
> +
> +	/* Check struct version */
> +	if (be32_to_cpu(fs->struct_version) > NBX_FBXSERIAL_VERSION) {
> +		printf("Version too big for fbxserial info (0x%08x)!\n",
> +		       be32_to_cpu(fs->struct_version));
> +		return -EINVAL;
> +	}
> +
> +	/* Check for silly len */
> +	len = be32_to_cpu(fs->len);
> +	if (len > NBX_FBXSERIAL_MAX_SIZE) {
> +		printf("Silly len for serial info (%d)\n", len);
> +		return -EINVAL;
> +	}
> +
> +	/* Validate CRC (crc32_no_comp: no one's complement) */
> +	sum = crc32_no_comp(0, (void *)fs + 4, len - 4);
> +	if (be32_to_cpu(fs->crc32) != sum) {
> +		printf("Invalid checksum for serial info (%08x != %08x)\n",
> +		       sum, be32_to_cpu(fs->crc32));
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +int nbx_fbx_read_serial(int dev_num, unsigned long offset,
> +			struct nbx_fbx_serial *fs)
> +{
> +	struct mmc *mmc;
> +	struct blk_desc *bd;
> +	uint blk_start, blk_cnt;
> +	uint n;
> +
> +	ALLOC_CACHE_ALIGN_BUFFER(char, buf, ALIGN(sizeof(*fs), 512));
> +	mmc = find_mmc_device(dev_num);
> +	if (!mmc) {
> +		printf("No MMC device %d found\n", dev_num);
> +		nbx_fbxserial_set_default(fs);
> +		return -ENODEV;
> +	}
> +
> +	if (mmc_init(mmc)) {
> +		puts("MMC init failed\n");
> +		nbx_fbxserial_set_default(fs);
> +		return -EIO;
> +	}
> +
> +	/* Switch to partition 0 (user data area) */
> +	if (blk_select_hwpart_devnum(UCLASS_MMC, dev_num, 0)) {
> +		puts("MMC partition switch failed\n");
> +		nbx_fbxserial_set_default(fs);
> +		return -EIO;
> +	}
> +
> +	bd = mmc_get_blk_desc(mmc);
> +	if (!bd) {
> +		puts("Failed to get MMC block descriptor\n");
> +		nbx_fbxserial_set_default(fs);
> +		return -EIO;
> +	}
> +
> +	blk_start = ALIGN(offset, bd->blksz) / bd->blksz;
> +	blk_cnt = ALIGN(sizeof(*fs), bd->blksz) / bd->blksz;
> +
> +	memset(fs, 0x42, sizeof(*fs));
> +
> +	n = blk_dread(bd, blk_start, blk_cnt, buf);
> +	if (n != blk_cnt) {
> +		printf("Failed to read serial info from MMC\n");
> +		nbx_fbxserial_set_default(fs);
> +		return -EIO;
> +	}
> +
> +	memcpy(fs, buf, sizeof(*fs));
> +
> +	if (nbx_fbx_check_serial(fs) != 0) {
> +		nbx_fbxserial_set_default(fs);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +void nbx_fbx_dump_serial(struct nbx_fbx_serial *fs)
> +{
> +	int i;
> +
> +	printf("Serial: %04u-%02u-%c-(%02u)%02u-%02u-%05u / %08x\n",
> +	       ntohs(fs->type),
> +	       fs->version,
> +	       isprint(fs->manufacturer) ? fs->manufacturer : '?',
> +	       ntohs(fs->year) / 100,
> +	       ntohs(fs->year) % 100,
> +	       fs->week,
> +	       ntohl(fs->number),
> +	       ntohl(fs->flags));
> +
> +	printf("Mac:    %02X:%02X:%02X:%02X:%02X:%02X\n",
> +	       fs->mac_addr_base[0],
> +	       fs->mac_addr_base[1],
> +	       fs->mac_addr_base[2],
> +	       fs->mac_addr_base[3],
> +	       fs->mac_addr_base[4],
> +	       fs->mac_addr_base[5]);
> +
> +	/* Show bundle info */
> +	for (i = 0; i < be32_to_cpu(fs->extinfo_count); i++) {
> +		struct nbx_serial_extinfo *p;
> +
> +		if (i >= NBX_EXTINFO_MAX_COUNT)
> +			break;
> +
> +		p = &fs->extinfos[i];
> +		if (be32_to_cpu(p->type) == NBX_EXTINFO_TYPE_EXTDEV &&
> +		    be32_to_cpu(p->u.extdev.type) == NBX_EXTDEV_TYPE_BUNDLE) {
> +			/* Ensure null termination */
> +			p->u.extdev.serial[sizeof(p->u.extdev.serial) - 1] = 0;
> +			printf("Bundle: %s\n", p->u.extdev.serial);
> +		}
> +	}
> +
> +	printf("\n");
> +}
> +
> +int nbx_fbx_init_ethaddr(int dev_num, unsigned long offset)
> +{
> +	struct nbx_fbx_serial fs;
> +	char mac[32];
> +	int ret;
> +
> +	ret = nbx_fbx_read_serial(dev_num, offset, &fs);
> +
> +	/* Even on error, fs has default values set */
> +	snprintf(mac, sizeof(mac), "%02x:%02x:%02x:%02x:%02x:%02x",
> +		 fs.mac_addr_base[0], fs.mac_addr_base[1],
> +		 fs.mac_addr_base[2], fs.mac_addr_base[3],
> +		 fs.mac_addr_base[4], fs.mac_addr_base[5]);
> +
> +	nbx_fbx_dump_serial(&fs);
> +
> +	env_set("ethaddr", mac);
> +	env_set("eth1addr", mac);
> +	env_set("eth2addr", mac);
> +
> +	return ret;
> +}
> +
> +/*
> + * fbxserial show - display serial info from eMMC
> + */
> +static int do_fbxserial_show(struct cmd_tbl *cmdtp, int flag, int argc,
> +			     char *const argv[])
> +{
> +	struct nbx_fbx_serial fs;
> +	int dev = 0;
> +	unsigned long offset = CONFIG_NBX_MMC_PART_SERIAL_OFFSET;
> +
> +	if (argc >= 1)
> +		dev = dectoul(argv[0], NULL);
> +
> +	if (argc >= 2)
> +		offset = hextoul(argv[1], NULL);
> +
> +	if (nbx_fbx_read_serial(dev, offset, &fs) != 0)
> +		printf("Warning: Using default serial info\n");
> +
> +	nbx_fbx_dump_serial(&fs);
> +
> +	return CMD_RET_SUCCESS;
> +}
> +
> +/*
> + * fbxserial init - initialize ethaddr from serial info
> + */
> +static int do_fbxserial_init(struct cmd_tbl *cmdtp, int flag, int argc,
> +			     char *const argv[])
> +{
> +	int dev = 0;
> +	unsigned long offset = CONFIG_NBX_MMC_PART_SERIAL_OFFSET;
> +
> +	if (argc >= 1)
> +		dev = dectoul(argv[0], NULL);
> +
> +	if (argc >= 2)
> +		offset = hextoul(argv[1], NULL);
> +
> +	return nbx_fbx_init_ethaddr(dev, offset);
> +}
> +
> +static struct cmd_tbl cmd_fbxserial_sub[] = {
> +	U_BOOT_CMD_MKENT(show, 3, 0, do_fbxserial_show, "", ""),
> +	U_BOOT_CMD_MKENT(init, 3, 0, do_fbxserial_init, "", ""),
> +};
> +
> +static int do_fbxserial(struct cmd_tbl *cmdtp, int flag, int argc,
> +			char *const argv[])
> +{
> +	struct cmd_tbl *cp;
> +
> +	/* Default to 'show' if no subcommand */
> +	if (argc < 2)
> +		return do_fbxserial_show(cmdtp, flag, 0, NULL);
> +
> +	cp = find_cmd_tbl(argv[1], cmd_fbxserial_sub,
> +			  ARRAY_SIZE(cmd_fbxserial_sub));
> +
> +	if (!cp)
> +		return CMD_RET_USAGE;
> +
> +	return cp->cmd(cmdtp, flag, argc - 2, argv + 2);
> +}
> +
> +U_BOOT_CMD(
> +	fbxserial, 5, 0, do_fbxserial,
> +	"NBX serial info and MAC address initialization",
> +	"show [dev] [offset] - display serial info from eMMC\n"
> +	"fbxserial init [dev] [offset] - initialize ethaddr from serial info\n"
> +	"    dev    - MMC device number (default 0)\n"
> +	"    offset - offset in eMMC in hex (default from Kconfig)"
> +);
> +
> +/*
> + * Early init hook: Set MAC address from eMMC serial info before
> + * network driver probes. EVT_SETTINGS_R is triggered after MMC
> + * is available but before initr_net().
> + */
> +static int nbx_fbx_settings_r(void)
> +{
> +	if (!of_machine_is_compatible("nbx,armada8040"))
> +		return 0;
> +
> +	nbx_fbx_init_ethaddr(0, CONFIG_NBX_MMC_PART_SERIAL_OFFSET);
> +	return 0;
> +}
> +
> +EVENT_SPY_SIMPLE(EVT_SETTINGS_R, nbx_fbx_settings_r);
> diff --git a/board/freebox/nbx10g/nbx_fbxserial.h b/board/freebox/nbx10g/nbx_fbxserial.h
> new file mode 100644
> index 00000000000..7bcaef09fe3
> --- /dev/null
> +++ b/board/freebox/nbx10g/nbx_fbxserial.h
> @@ -0,0 +1,156 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * NBX Freebox Serial Info Support
> + *
> + * Copyright (C) 2025 Free Mobile, Freebox
> + *
> + * Reads device serial number and MAC address from eMMC.
> + * Used to identify the board and set network MAC addresses.
> + */
> +
> +#ifndef NBX_FBXSERIAL_H
> +#define NBX_FBXSERIAL_H
> +
> +#include <linux/types.h>
> +
> +/*
> + * Extended info structure - variable data depending on type
> + */
> +#define NBX_EXTINFO_SIZE		128
> +#define NBX_EXTINFO_MAX_COUNT		16
> +
> +/* Extended info types */
> +#define NBX_EXTINFO_TYPE_EXTDEV		1
> +
> +/* Extended device types */
> +#define NBX_EXTDEV_TYPE_BUNDLE		1
> +#define NBX_EXTDEV_TYPE_MAX		2
> +
> +struct nbx_serial_extinfo {
> +	u32 type;
> +
> +	union {
> +		/* extdev */
> +		struct {
> +			u32 type;
> +			u32 model;
> +			char serial[64];
> +		} extdev;
> +
> +		/* raw access */
> +		unsigned char data[NBX_EXTINFO_SIZE];
> +	} u;
> +} __packed;
> +
> +/*
> + * Master serial structure
> + */
> +#define NBX_FBXSERIAL_VERSION		1
> +#define NBX_FBXSERIAL_MAGIC		0x2d9521ab
> +
> +#define NBX_MAC_ADDR_SIZE		6
> +#define NBX_RANDOM_DATA_SIZE		32
> +
> +/* Maximum size for CRC validation */
> +#define NBX_FBXSERIAL_MAX_SIZE		8192
> +
> +struct nbx_fbx_serial {
> +	u32 crc32;
> +	u32 magic;
> +	u32 struct_version;
> +	u32 len;
> +
> +	/* Board serial */
> +	u16 type;
> +	u8 version;
> +	u8 manufacturer;
> +	u16 year;
> +	u8 week;
> +	u32 number;
> +	u32 flags;
> +
> +	/* MAC address base */
> +	u8 mac_addr_base[NBX_MAC_ADDR_SIZE];
> +
> +	/* MAC address count */
> +	u8 mac_count;
> +
> +	/* Random data used to derive keys */
> +	u8 random_data[NBX_RANDOM_DATA_SIZE];
> +
> +	/* Last update of data (seconds since epoch) */
> +	u32 last_modified;
> +
> +	/* Count of following extinfo tags */
> +	u32 extinfo_count;
> +
> +	/* Beginning of extended info */
> +	struct nbx_serial_extinfo extinfos[NBX_EXTINFO_MAX_COUNT];
> +} __packed;
> +
> +/**
> + * nbx_fbxserial_set_default() - Initialize serial structure with defaults
> + * @serial: Pointer to serial structure to initialize
> + *
> + * Sets the serial structure to default values (Freebox OUI, type 9018).
> + * Used as fallback when serial info cannot be read from eMMC.
> + */
> +static inline void nbx_fbxserial_set_default(struct nbx_fbx_serial *serial)
> +{
> +	static const struct nbx_fbx_serial def = {
> +		.crc32		= 0,
> +		.magic		= NBX_FBXSERIAL_MAGIC,
> +		.struct_version	= NBX_FBXSERIAL_VERSION,
> +		.len		= sizeof(struct nbx_fbx_serial),
> +		.type		= 9018,
> +		.version	= 0,
> +		.manufacturer	= '_',
> +		.year		= 0,
> +		.week		= 0,
> +		.number		= 0,
> +		.flags		= 0,
> +		.mac_addr_base	= { 0x00, 0x07, 0xCB, 0x00, 0x00, 0xFD },
> +		.mac_count	= 1,
> +		.random_data	= { 0 },
> +		.last_modified	= 0,
> +		.extinfo_count	= 0,
> +	};
> +
> +	memcpy(serial, &def, sizeof(def));
> +}
> +
> +/**
> + * nbx_fbx_read_serial() - Read serial info from eMMC
> + * @dev_num: MMC device number
> + * @offset: Byte offset in eMMC where serial info is stored
> + * @fs: Pointer to serial structure to fill
> + *
> + * Reads and validates the serial info from eMMC. On failure,
> + * the structure is filled with default values.
> + *
> + * Return: 0 on success, negative on error (defaults still set)
> + */
> +int nbx_fbx_read_serial(int dev_num, unsigned long offset,
> +			struct nbx_fbx_serial *fs);
> +
> +/**
> + * nbx_fbx_dump_serial() - Print serial info to console
> + * @fs: Pointer to serial structure to display
> + *
> + * Prints the serial number, MAC address, and bundle info (if present).
> + */
> +void nbx_fbx_dump_serial(struct nbx_fbx_serial *fs);
> +
> +/**
> + * nbx_fbx_init_ethaddr() - Initialize Ethernet addresses from serial info
> + * @dev_num: MMC device number
> + * @offset: Byte offset in eMMC where serial info is stored
> + *
> + * Reads serial info and sets ethaddr, eth1addr, eth2addr environment
> + * variables from the MAC address in the serial structure.
> + *
> + * Return: 0 on success, negative on error
> + */
> +int nbx_fbx_init_ethaddr(int dev_num, unsigned long offset);
> +
> +#endif /* NBX_FBXSERIAL_H */

