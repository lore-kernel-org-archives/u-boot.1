Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A72CE7AEB
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 03:11:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86AA686DFF;
	Thu, 28 Sep 2023 05:11:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="IJgmovFa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD5EC86E01; Thu, 28 Sep 2023 05:11:50 +0200 (CEST)
Received: from mail-m49201.qiye.163.com (mail-m49201.qiye.163.com
 [45.254.49.201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDB6E86B3B
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 05:11:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=IJgmovFaIqD1RcSR4ulXFesESIIMJMOsBYKTZl9e3ljDua5pHJugsI63T1y5Z8//AOrPZoOF/V++3jXIo5X06ZuF3aFFsFtTx3tQjoi/cZ5z+CzhELRL0IKXFGbHQnBDLHhWPgaUwghzR/7n6Za1kSwTsd2xCDiajCTCshp5Tws=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=qAz2cWphEZ7fUiwRDyxcuZKratIKHinhhKCJw0vtucY=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 94180400268;
 Thu, 28 Sep 2023 11:11:00 +0800 (CST)
Message-ID: <ec65c5db-f171-88c3-898a-3f200f585bff@rock-chips.com>
Date: Thu, 28 Sep 2023 11:11:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 3/3] rockchip: cmd: add rockmtd command
Content-Language: en-US
To: Johan Jonker <jbx6244@gmail.com>
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, michael@amarulasolutions.com, 
 dario.binacchi@amarulasolutions.com, u-boot@lists.denx.de
References: <cbbaecb0-19fc-018d-df63-c5f265156024@gmail.com>
 <55066888-6b41-6ae5-2b92-f6f0b37748e9@gmail.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <55066888-6b41-6ae5-2b92-f6f0b37748e9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU1JT1YeH08dQh8ZSR5MS0lVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8ad9c4b08d2eb3kusn94180400268
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NVE6OSo4Njw3DCtPPUsTHjYr
 E0IwFAxVSlVKTUJOQ0xLTU1KT05JVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPQk1DQzcG
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

Hi Johan,

On 2023/8/24 21:29, Johan Jonker wrote:
> Rockmtd creates a virtual block device to transfer Rockchip
> boot block data to and from NAND with block orientated tools
> like "ums" and "rockusb".
>
> It uses the Rockchip MTD driver to scan for boot blocks and copies
> data from the first block in a GPT formated virtual disk.
> Data must be written in U-boot "idbloader.img" format and start at
> partition "loader1" offset 64. The data header is parsed
> for length and offset. When the last sector is received
> it erases up to 5 erase blocks on NAND and writes bootblocks
> in a pattern depending on the NAND ID. Data is then verified.
> When a block turns out bad the block header is discarded.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>   cmd/Kconfig   |    7 +
>   cmd/Makefile  |    1 +
>   cmd/rockmtd.c | 1429 +++++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 1437 insertions(+)
>   create mode 100644 cmd/rockmtd.c
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 2d6e5f993f04..87f862076355 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1553,6 +1553,13 @@ config CMD_USB_SDP
>   	  Enables the command "sdp" which is used to have U-Boot emulating the
>   	  Serial Download Protocol (SDP) via USB.
>
> +config CMD_ROCKMTD
> +	bool "rockmtd"

For most of modules for rockchip platform, it's naming with rockchip_ or 
short with prefix rk**,

so I think it's better to use rkmtd for this command.

rockusb is the only one I know with prefix "rock", which is used with 
very long history before

linux/u-boot driver available.


Thanks,
- Kever
> +	help
> +	  Rockmtd creates a virtual block device to transfer Rockchip
> +	  boot block data to and from NAND with block orientated tools
> +	  like "ums" and "rockusb".
> +
>   config CMD_ROCKUSB
>   	bool "rockusb"
>   	depends on USB_FUNCTION_ROCKUSB
> diff --git a/cmd/Makefile b/cmd/Makefile
> index 9f8c0b058bea..19b609ace782 100644
> --- a/cmd/Makefile
> +++ b/cmd/Makefile
> @@ -150,6 +150,7 @@ obj-$(CONFIG_CMD_REISER) += reiser.o
>   obj-$(CONFIG_CMD_REMOTEPROC) += remoteproc.o
>   obj-$(CONFIG_CMD_RNG) += rng.o
>   obj-$(CONFIG_CMD_KASLRSEED) += kaslrseed.o
> +obj-$(CONFIG_CMD_ROCKMTD) += rockmtd.o
>   obj-$(CONFIG_CMD_ROCKUSB) += rockusb.o
>   obj-$(CONFIG_CMD_RTC) += rtc.o
>   obj-$(CONFIG_SANDBOX) += host.o
> diff --git a/cmd/rockmtd.c b/cmd/rockmtd.c
> new file mode 100644
> index 000000000000..cf5259ecb4d7
> --- /dev/null
> +++ b/cmd/rockmtd.c
> @@ -0,0 +1,1429 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * (C) 2023 Johan Jonker <jbx6244@gmail.com>
> + */
> +
> +#include <blk.h>
> +#include <command.h>
> +#include <common.h>
> +#include <dm.h>
> +#include <dm/device-internal.h>
> +#include <dm/lists.h>
> +#include <dm/root.h>
> +#include <dm/uclass-internal.h>
> +#include <efi_api.h>
> +#include <nand.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/rawnand.h>
> +#include <memalign.h>
> +#include <part.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <u-boot/crc.h>
> +
> +#define LBA			64 + 512 + 33
> +
> +#define RK_TAG			0xFCDC8C3B
> +#define NFC_SYS_DATA_SIZE	4
> +
> +struct nand_para_info {
> +	u8 id_bytes;
> +	u8 nand_id[6];
> +	u8 vendor;
> +	u8 die_per_chip;
> +	u8 sec_per_page;
> +	u16 page_per_blk;
> +	u8 cell;
> +	u8 plane_per_die;
> +	u16 blk_per_plane;
> +	u16 operation_opt;
> +	u8 lsb_mode;
> +	u8 read_retry_mode;
> +	u8 ecc_bits;
> +	u8 access_freq;
> +	u8 opt_mode;
> +	u8 die_gap;
> +	u8 bad_block_mode;
> +	u8 multi_plane_mode;
> +	u8 slc_mode;
> +	u8 reserved[5];
> +};
> +
> +struct bootblk {
> +	int blk;
> +	int boot_size;
> +	int offset;
> +};
> +
> +struct rockmtd_dev {
> +	struct blk_desc *desc;
> +	char *label;
> +	legacy_mbr *mbr;
> +	gpt_header *gpt_h;
> +	gpt_header *gpt_h2;
> +	gpt_entry *gpt_e;
> +	char *check;
> +	char *idb;
> +	char *str;
> +	char uuid_part_str[UUID_STR_LEN + 1];
> +	char uuid_disk_str[UUID_STR_LEN + 1];
> +	char *datbuf;
> +	char *oobbuf;
> +	struct mtd_info *mtd;
> +	struct nand_para_info *info;
> +	u16 page_table[512];
> +	u32 idb_need_write_back;
> +	struct bootblk idblock[5];
> +	u32 blk_counter;
> +	u32 boot_blks;
> +	u32 offset;
> +	u32 boot_size;
> +};
> +
> +struct sector0 {
> +	u32 magic;
> +	u8  reserved[4];
> +	u32 rc4_flag;
> +	u16 boot_code1_offset;
> +	u16 boot_code2_offset;
> +	u8  reserved1[490];
> +	u16 flash_data_size;
> +	u16 flash_boot_size;
> +	u8  reserved2[2];
> +} __packed;
> +
> +struct rk_nfc_nand_chip {
> +	struct nand_chip chip;
> +
> +	u16 boot_blks;
> +	u16 metadata_size;
> +	u32 boot_ecc;
> +	u32 timing;
> +
> +	u8 nsels;
> +	u8 sels[0];
> +	/* Nothing after this field. */
> +};
> +
> +struct nand_para_info nand_para_tbl[] = {
> +	{6, {0x2c, 0x64, 0x44, 0x4b, 0xa9, 0x00}, 4, 1, 16,  256, 2, 2, 2048, 0x01df,  3, 17, 40, 32, 1, 0, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x2c, 0x44, 0x44, 0x4b, 0xa9, 0x00}, 4, 1, 16,  256, 2, 2, 1064, 0x01df,  3, 17, 40, 32, 1, 0, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x2c, 0x68, 0x04, 0x4a, 0xa9, 0x00}, 4, 1,  8,  256, 2, 2, 2048, 0x011f,  1,  0, 24, 32, 1, 0, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{5, {0x2c, 0x88, 0x04, 0x4b, 0xa9, 0x00}, 4, 1, 16,  256, 2, 2, 2048, 0x011f,  1,  0, 24, 32, 1, 0, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x2c, 0xa8, 0x05, 0xcb, 0xa9, 0x00}, 4, 2, 16,  256, 2, 2, 2048, 0x011f,  1,  0, 24, 32, 1, 0, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x2c, 0x68, 0x04, 0x46, 0x89, 0x00}, 4, 1,  8,  256, 2, 2, 2048, 0x011f,  1,  0, 24, 32, 1, 0, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x2c, 0x48, 0x04, 0x4a, 0xa5, 0x00}, 4, 1,  8,  256, 2, 2, 1024, 0x011f,  1,  0, 24, 32, 1, 0, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x2c, 0x84, 0x64, 0x3c, 0xa5, 0x00}, 4, 1, 32,  512, 2, 2, 1024, 0x01df,  3, 17, 40, 32, 1, 0, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{5, {0x2c, 0x84, 0x64, 0x54, 0xa9, 0x00}, 4, 1, 32,  512, 2, 2, 1024, 0x01df,  4, 18, 60, 32, 1, 0, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x2c, 0xd7, 0x94, 0x3e, 0x84, 0x00}, 4, 1,  8,  128, 2, 2, 4096, 0x0117,  1,  0, 24, 32, 1, 0, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x2c, 0x48, 0x04, 0x46, 0x85, 0x00}, 4, 1,  8,  256, 2, 2, 1024, 0x011f,  1,  0, 24, 32, 1, 0, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x2c, 0x88, 0x05, 0xc6, 0x89, 0x00}, 4, 2,  8,  256, 2, 2, 2048, 0x011f,  1,  0, 24, 32, 1, 0, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{5, {0x2c, 0x88, 0x24, 0x4b, 0xa9, 0x00}, 4, 1, 16,  256, 2, 2, 2048, 0x011f,  1,  0, 24, 32, 1, 0, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x2c, 0x68, 0x00, 0x27, 0xa9, 0x00}, 4, 1, 16,  128, 1, 2, 2048, 0x011f,  0,  0, 24, 32, 1, 0, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{5, {0x2c, 0x64, 0x64, 0x56, 0xa5, 0x00}, 4, 1, 24,  512, 2, 2,  700, 0x01df,  4, 18, 60, 32, 1, 0, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x2c, 0x84, 0xc5, 0x4b, 0xa9, 0x00}, 4, 2, 16,  256, 2, 2, 2048, 0x01df,  3, 17, 40, 32, 1, 0, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x2c, 0xd5, 0xd1, 0xa6, 0x68, 0x00}, 4, 2,  8,   64, 1, 2, 2048, 0x0117,  0,  0, 24, 32, 1, 0, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x2c, 0xdc, 0x90, 0xa6, 0x54, 0x00}, 4, 1,  8,   64, 1, 2, 1024, 0x0117,  0,  0, 24, 32, 1, 0, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{5, {0x2c, 0x64, 0x64, 0x54, 0xa4, 0x00}, 4, 1, 32,  512, 2, 1, 1024, 0x01df,  4, 18, 60, 32, 1, 0, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{5, {0x2c, 0x84, 0x44, 0x32, 0xaa, 0x00}, 4, 1, 32,  512, 2, 1, 2184, 0x05c7,  5, 19, 60, 32, 1, 0, 1, 0, 1, {0, 0, 0, 0, 0}},
> +	{5, {0x2c, 0x64, 0x44, 0x32, 0xa5, 0x00}, 4, 1, 32,  512, 2, 1, 1048, 0x05c7,  5, 19, 60, 32, 1, 0, 1, 0, 1, {0, 0, 0, 0, 0}},
> +	{5, {0x2c, 0x64, 0x64, 0x3c, 0xa5, 0x00}, 4, 1, 32,  512, 2, 1, 1044, 0x01df,  3, 17, 40, 32, 1, 0, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{5, {0x2c, 0x84, 0x44, 0x32, 0xaa, 0x00}, 4, 1, 32,  512, 2, 1, 2184, 0x05c7,  5, 19, 60, 32, 1, 0, 4, 0, 1, {0, 0, 0, 0, 0}},
> +	{5, {0x2c, 0x84, 0x44, 0x34, 0xaa, 0x00}, 4, 1, 32,  512, 2, 1, 2184, 0x05c7,  5, 19, 60, 32, 1, 0, 4, 0, 1, {0, 0, 0, 0, 0}},
> +	{5, {0x2c, 0x84, 0xc4, 0x34, 0xaa, 0x00}, 4, 1, 32,  512, 2, 1, 2184, 0x05c7,  5, 19, 60, 32, 1, 0, 1, 0, 1, {0, 0, 0, 0, 0}},
> +	{5, {0x2c, 0x84, 0x44, 0x34, 0xa4, 0x00}, 4, 1, 32,  512, 2, 1, 2184, 0x05c7,  5, 19, 60, 32, 1, 0, 1, 0, 1, {0, 0, 0, 0, 0}},
> +	{5, {0x2c, 0x84, 0x64, 0x3c, 0xa9, 0x00}, 4, 1, 32,  512, 2, 2, 1024, 0x01df,  3, 17, 40, 32, 1, 0, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x2c, 0xa4, 0x64, 0x32, 0xaa, 0x04}, 4, 1, 32, 1024, 2, 1, 2192, 0x05c7, 10, 19, 60, 32, 1, 0, 4, 0, 1, {0, 0, 0, 0, 0}},
> +	{6, {0xad, 0xde, 0x94, 0xd2, 0x04, 0x43}, 2, 1, 16,  256, 2, 2, 2048, 0x01d9,  1,  1, 24, 32, 4, 0, 3, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0xad, 0xd7, 0x94, 0xda, 0x74, 0xc3}, 2, 1, 16,  256, 2, 2, 1024, 0x01d9,  1,  2, 40, 32, 4, 0, 3, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0xad, 0xd7, 0x94, 0x91, 0x60, 0x44}, 2, 1, 16,  256, 2, 2, 1046, 0x01d9,  1,  3, 40, 32, 4, 1, 3, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0xad, 0xde, 0x94, 0xda, 0x74, 0xc4}, 2, 1, 16,  256, 2, 2, 2090, 0x01d9,  1,  4, 40, 32, 4, 1, 3, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0xad, 0xde, 0x94, 0xeb, 0x74, 0x44}, 2, 1, 32,  256, 2, 2, 1066, 0x01d9,  1,  7, 40, 32, 4, 1, 3, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0xad, 0xd5, 0x94, 0xda, 0x74, 0xc4}, 2, 1, 16,  256, 2, 2,  530, 0x01d9,  1,  3, 40, 32, 4, 1, 3, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0xad, 0xd7, 0x94, 0x9a, 0x74, 0x42}, 2, 1, 16,  256, 2, 2, 1024, 0x0119,  1,  0, 24, 32, 4, 0, 3, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0xad, 0xde, 0x14, 0xa7, 0x42, 0x4a}, 2, 1, 32,  256, 2, 2, 1060, 0x01d9,  2,  5, 40, 32, 4, 1, 3, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0xad, 0xd7, 0x14, 0x9e, 0x34, 0x4a}, 2, 1, 16,  256, 2, 2, 1056, 0x01d9,  2,  5, 40, 32, 4, 1, 3, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0xad, 0xde, 0x94, 0xa7, 0x42, 0x48}, 2, 1, 32,  256, 2, 2, 1060, 0x01d9,  2,  5, 40, 32, 4, 1, 3, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0xad, 0xde, 0x14, 0xab, 0x42, 0x4a}, 2, 1, 32,  256, 2, 2, 1056, 0x01d9,  2,  6, 40, 32, 3, 1, 3, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0xad, 0x3a, 0x14, 0xab, 0x42, 0x4a}, 2, 1, 32,  256, 2, 2, 2092, 0x01d9,  2,  5, 40, 32, 3, 1, 3, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0xad, 0xd5, 0x94, 0x9a, 0x74, 0x42}, 2, 1, 16,  256, 2, 1, 1024, 0x0111,  1,  0, 24, 32, 4, 1, 3, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0xad, 0x3a, 0x14, 0x03, 0x08, 0x50}, 2, 1, 32,  388, 2, 2, 1362, 0x01d9,  9,  8, 40, 32, 3, 1, 3, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x89, 0x64, 0x44, 0x4b, 0xa9, 0x00}, 7, 1, 16,  256, 2, 2, 2048, 0x01df,  3, 17, 40, 32, 1, 0, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x89, 0x88, 0x24, 0x4b, 0xa9, 0x84}, 7, 1, 16,  256, 2, 2, 2048, 0x01df,  3, 17, 40, 32, 1, 0, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x89, 0x88, 0x24, 0x4b, 0xa9, 0x00}, 7, 1, 16,  256, 2, 2, 2048, 0x0117,  1,  0, 24, 32, 1, 0, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x89, 0x68, 0x24, 0x4a, 0xa9, 0x00}, 7, 1,  8,  256, 2, 2, 2048, 0x0117,  1,  0, 24, 32, 1, 0, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x89, 0x68, 0x04, 0x4a, 0xa9, 0x00}, 7, 1,  8,  256, 2, 2, 2048, 0x0117,  1,  0, 24, 32, 1, 0, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x89, 0xd7, 0x94, 0x3e, 0x84, 0x00}, 7, 1,  8,  256, 2, 2, 2048, 0x0117,  1,  0, 24, 32, 1, 0, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x89, 0x68, 0x04, 0x46, 0xa9, 0x00}, 7, 1,  8,  256, 2, 2, 2048, 0x0117,  1,  0, 24, 32, 1, 0, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{5, {0x89, 0x64, 0x64, 0x3c, 0xa1, 0x00}, 7, 1, 32,  512, 2, 1, 1024, 0x01c7,  4, 17, 40, 32, 1, 0, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{5, {0x89, 0x84, 0x64, 0x3c, 0xa5, 0x00}, 7, 1, 32,  512, 2, 2, 1024, 0x01c7,  4, 17, 40, 32, 1, 0, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x89, 0x88, 0x24, 0x3b, 0xa9, 0x00}, 7, 1, 16,  192, 2, 2, 2048, 0x0117, 12,  0, 24, 32, 1, 0, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x98, 0xd7, 0x84, 0x93, 0x72, 0x57}, 1, 1, 32,  256, 2, 1, 1060, 0x05c1,  2, 33, 40, 32, 2, 1, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x98, 0xde, 0x84, 0x93, 0x72, 0x57}, 1, 1, 32,  256, 2, 1, 2092, 0x05c1,  2, 33, 40, 32, 2, 1, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x98, 0x3a, 0x85, 0x93, 0x76, 0x57}, 1, 2, 32,  256, 2, 1, 2092, 0x05e1,  2, 33, 40, 32, 2, 1, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x98, 0xd5, 0x84, 0x32, 0x72, 0x56}, 1, 1, 16,  128, 2, 1, 2056, 0x05c1,  2, 33, 40, 32, 2, 1, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x98, 0xd7, 0x94, 0x32, 0x76, 0x56}, 1, 1, 16,  128, 2, 2, 2058, 0x05d1,  2, 33, 40, 32, 2, 1, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x98, 0xde, 0x94, 0x82, 0x76, 0x56}, 1, 1, 16,  256, 2, 2, 2062, 0x05d1,  1, 33, 40, 32, 2, 1, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x98, 0xde, 0x94, 0x93, 0x76, 0x50}, 1, 1, 32,  256, 2, 2, 1066, 0x05d9,  2, 34, 40, 32, 3, 1, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x98, 0x3a, 0x95, 0x93, 0x7a, 0x50}, 1, 2, 32,  256, 2, 2, 1066, 0x05d9,  2, 34, 40, 32, 3, 1, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x98, 0xd7, 0x94, 0x32, 0x76, 0x55}, 1, 1, 16,  128, 2, 2, 2050, 0x0191,  2,  0, 24, 32, 1, 1, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x98, 0xde, 0x94, 0x93, 0x76, 0x57}, 1, 1, 32,  256, 2, 2, 1058, 0x05d9,  2, 33, 40, 32, 3, 1, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x98, 0xd7, 0x84, 0x93, 0x72, 0x50}, 1, 1, 32,  256, 2, 1, 1060, 0x05c1,  2, 34, 40, 32, 3, 1, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x98, 0xde, 0x94, 0x93, 0x76, 0x51}, 1, 1, 32,  256, 2, 2, 1074, 0x05d9,  2, 35, 40, 32, 3, 1, 4, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x98, 0x3a, 0x94, 0x93, 0x76, 0x51}, 1, 1, 32,  256, 2, 2, 2106, 0x05d9,  2, 35, 40, 32, 3, 1, 4, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x98, 0xd7, 0x84, 0x93, 0x72, 0x51}, 1, 1, 32,  256, 2, 1, 1056, 0x05d9,  2, 35, 40, 32, 3, 1, 4, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x98, 0xde, 0x94, 0x93, 0x76, 0xd1}, 1, 1, 32,  256, 2, 2, 1074, 0x05d9,  2, 35, 40, 32, 3, 1, 4, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x45, 0xde, 0x94, 0x93, 0x76, 0x57}, 8, 1, 32,  256, 2, 2, 1058, 0x05d9,  2, 66, 40, 32, 3, 1, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x45, 0xd7, 0x84, 0x93, 0x72, 0x57}, 8, 1, 32,  256, 2, 1, 1060, 0x05c1,  2, 66, 40, 32, 2, 1, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x45, 0xde, 0xa4, 0x82, 0x76, 0x56}, 8, 1, 16,  256, 2, 2, 2082, 0x01d9,  1, 65, 40, 32, 3, 1, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x45, 0xde, 0x94, 0x93, 0x76, 0x50}, 8, 1, 32,  256, 2, 2, 1066, 0x05d9,  2, 67, 40, 32, 3, 1, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x45, 0xd7, 0x84, 0x93, 0x72, 0x50}, 8, 1, 32,  256, 2, 1, 1060, 0x05c1,  2, 67, 40, 32, 3, 1, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x45, 0xde, 0xa4, 0x82, 0x76, 0xd7}, 8, 1, 16,  256, 2, 2, 2090, 0x04d9,  1, 66, 40, 32, 3, 1, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x45, 0xde, 0x84, 0x93, 0x72, 0x57}, 8, 1, 32,  256, 2, 1, 2092, 0x05c1,  2, 66, 40, 32, 3, 1, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x45, 0x3a, 0x94, 0x93, 0x76, 0x51}, 8, 1, 32,  256, 2, 2, 2106, 0x01d9,  2, 68, 40, 32, 3, 1, 4, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x45, 0xde, 0x94, 0x93, 0x76, 0x51}, 8, 1, 32,  256, 2, 2, 1074, 0x01d9,  2, 68, 40, 32, 3, 1, 4, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x45, 0x3a, 0xa4, 0x93, 0x7a, 0x50}, 8, 1, 32,  256, 2, 2, 2138, 0x05d9,  2,  0, 40, 32, 3, 1, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x45, 0xde, 0x94, 0x82, 0x76, 0x56}, 8, 1, 16,  256, 2, 2, 2062, 0x01d9,  1,  0, 40, 32, 3, 1, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0x45, 0xde, 0x94, 0x93, 0x76, 0xd7}, 8, 1, 32,  256, 2, 2, 1058, 0x05d9,  2, 66, 40, 32, 3, 1, 1, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0xec, 0xd7, 0x94, 0x7e, 0x64, 0x44}, 0, 1, 16,  128, 2, 2, 2048, 0x01d9,  2, 49, 60, 36, 3, 0, 3, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0xec, 0xde, 0xd5, 0x7e, 0x68, 0x44}, 0, 2, 16,  128, 2, 2, 2048, 0x01f9,  2, 49, 60, 36, 3, 0, 3, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0xec, 0xd7, 0x94, 0x7a, 0x54, 0x43}, 0, 1, 16,  128, 2, 2, 2076, 0x0199,  2,  0, 40, 36, 3, 1, 3, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0xec, 0xde, 0xd5, 0x7a, 0x58, 0x43}, 0, 2, 16,  128, 2, 2, 2076, 0x01b9,  2,  0, 40, 36, 3, 1, 3, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0xec, 0xd5, 0x94, 0x76, 0x54, 0x43}, 0, 1, 16,  128, 2, 2, 1038, 0x0119,  2,  0, 24, 36, 3, 1, 3, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0xec, 0xd7, 0x14, 0x76, 0x54, 0xc2}, 0, 1, 16,  128, 2, 2, 2076, 0x0491,  2,  0, 24, 40, 3, 1, 3, 0, 0, {0, 0, 0, 0, 0}},
> +	{6, {0xec, 0xde, 0x94, 0xc3, 0xa4, 0xca}, 0, 1, 32,  792, 2, 1,  688, 0x04c1, 11, 50, 40, 32, 3, 1, 1, 0, 1, {0, 0, 0, 0, 0}},
> +};
> +
> +void rockmtd_rc4(u8 *buf, u32 len)
> +{
> +	u8 S[256], K[256], temp;
> +	u32 i, j, t, x;
> +	u8 key[16] = { 124, 78, 3, 4, 85, 5, 9, 7, 45, 44, 123, 56, 23, 13, 23, 17};
> +
> +	j = 0;
> +	for (i = 0; i < 256; i++) {
> +		S[i] = (u8)i;
> +		j &= 0x0f;
> +		K[i] = key[j];
> +		j++;
> +	}
> +
> +	j = 0;
> +	for (i = 0; i < 256; i++) {
> +		j = (j + S[i] + K[i]) % 256;
> +		temp = S[i];
> +		S[i] = S[j];
> +		S[j] = temp;
> +	}
> +
> +	i = 0;
> +	j = 0;
> +	for (x = 0; x < len; x++) {
> +		i = (i + 1) % 256;
> +		j = (j + S[i]) % 256;
> +		temp = S[i];
> +		S[i] = S[j];
> +		S[j] = temp;
> +		t = (S[i] + (S[j] % 256)) % 256;
> +		buf[x] = buf[x] ^ S[t];
> +	}
> +}
> +
> +static int rockmtd_write_oob(struct mtd_info *mtd, ulong off, u_char *datbuf, u_char *oobbuf)
> +{
> +	off &= ~(mtd->writesize - 1);
> +	loff_t addr = (loff_t)off;
> +	struct mtd_oob_ops ops;
> +	int ret;
> +
> +	memset(&ops, 0, sizeof(ops));
> +	ops.datbuf = datbuf;
> +	ops.oobbuf = oobbuf;
> +	ops.len = mtd->writesize;
> +	ops.ooblen = mtd->oobsize;
> +	ops.mode = MTD_OPS_PLACE_OOB;
> +	ret = mtd_write_oob(mtd, addr, &ops);
> +	if (ret < 0) {
> +		debug("Error (%d) writing page %08lx\n", ret, off);
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rockmtd_read_oob(struct mtd_info *mtd, ulong off, u_char *datbuf, u_char *oobbuf)
> +{
> +	off &= ~(mtd->writesize - 1);
> +	loff_t addr = (loff_t)off;
> +	struct mtd_oob_ops ops;
> +	int ret;
> +
> +	memset(&ops, 0, sizeof(ops));
> +	ops.datbuf = datbuf;
> +	ops.oobbuf = oobbuf;
> +	ops.len = mtd->writesize;
> +	ops.ooblen = mtd->oobsize;
> +	ops.mode = MTD_OPS_PLACE_OOB;
> +	ret = mtd_read_oob(mtd, addr, &ops);
> +	if (ret < 0) {
> +		debug("error (%d) reading page %08lx\n", ret, off);
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rockmtd_erase(struct mtd_info *mtd, ulong off)
> +{
> +	off &= ~(mtd->writesize - 1);
> +	loff_t addr = (loff_t)off;
> +	struct erase_info info;
> +	int ret;
> +
> +	memset(&info, 0, sizeof(info));
> +	info.mtd = mtd;
> +	info.addr = addr;
> +	info.len = mtd->erasesize;
> +	info.scrub = 1;
> +	ret = mtd_erase(mtd, &info);
> +	if (ret) {
> +		debug("error (%d) erasing page %08lx\n", ret, off);
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +void rockmtd_scan_block(struct rockmtd_dev *plat)
> +{
> +	u32 blk;
> +
> +	plat->blk_counter = 0;
> +
> +	for (blk = 0; blk < plat->boot_blks; blk++) {
> +		rockmtd_read_oob(plat->mtd, blk * plat->mtd->erasesize, plat->datbuf, plat->oobbuf);
> +		if (*(u32 *)plat->datbuf == RK_TAG) {
> +			struct sector0 *sec0 = (struct sector0 *)plat->datbuf;
> +
> +			rockmtd_rc4(plat->datbuf, 512);
> +
> +			plat->idblock[plat->blk_counter].blk = blk;
> +			plat->idblock[plat->blk_counter].offset = sec0->boot_code1_offset;
> +			plat->idblock[plat->blk_counter].boot_size = sec0->flash_boot_size;
> +
> +			debug("\nblk       : %d\n", plat->idblock[plat->blk_counter].blk);
> +			debug("offset    : %d\n", plat->idblock[plat->blk_counter].offset);
> +			debug("boot_size : %d\n", plat->idblock[plat->blk_counter].boot_size);
> +
> +			plat->blk_counter += 1;
> +
> +			if (plat->blk_counter >= ARRAY_SIZE(plat->idblock))
> +				return;
> +		}
> +	}
> +}
> +
> +void rockmtd_read_block(struct rockmtd_dev *plat, u32 idx, u8 *buf)
> +{
> +	ulong off = plat->idblock[idx].blk * plat->mtd->erasesize;
> +	struct nand_chip *chip = mtd_to_nand(plat->mtd);
> +	struct nand_ecc_ctrl *ecc = &chip->ecc;
> +	int counter = 0;
> +	u32 spare0 = 0;
> +	u32 *p_spare;
> +	int sector;
> +	int page;
> +
> +	rockmtd_read_oob(plat->mtd, off,
> +			 plat->datbuf, plat->oobbuf);
> +
> +	memcpy(buf, plat->datbuf, 2048);
> +
> +	while (counter < plat->idblock[idx].boot_size) {
> +		if (spare0)
> +			page = (plat->idblock[idx].offset + spare0) / 4;
> +		else
> +			page = (plat->idblock[idx].offset + counter) / 4;
> +
> +		rockmtd_read_oob(plat->mtd,
> +				 off + page * plat->mtd->writesize,
> +				 plat->datbuf, plat->oobbuf);
> +
> +		sector = plat->idblock[idx].offset + counter;
> +
> +		memcpy(&buf[(sector / 4) * 2048], plat->datbuf, 2048);
> +
> +		p_spare = (u32 *)&plat->oobbuf[(ecc->steps - 1) * NFC_SYS_DATA_SIZE];
> +
> +		spare0 = *p_spare;
> +		if (spare0 == -1)
> +			break;
> +
> +		counter += 4;
> +	}
> +}
> +
> +void rockmtd_write_block(struct rockmtd_dev *plat, u32 idx, u8 *buf)
> +{
> +	ulong off = plat->idblock[idx].blk * plat->mtd->erasesize;
> +	struct nand_chip *chip = mtd_to_nand(plat->mtd);
> +	struct nand_ecc_ctrl *ecc = &chip->ecc;
> +	int counter = 0;
> +	u32 *p_spare;
> +	int sector;
> +	int page;
> +	int j, w, r;
> +
> +	rockmtd_erase(plat->mtd, off);
> +
> +	memset(plat->datbuf, 0xff, plat->mtd->writesize);
> +	memcpy(plat->datbuf, buf, 2048);
> +	memset(plat->oobbuf, 0xff, plat->mtd->oobsize);
> +
> +	rockmtd_write_oob(plat->mtd, off,
> +			  plat->datbuf, plat->oobbuf);
> +
> +	while (counter < plat->idblock[idx].boot_size) {
> +		sector = plat->idblock[idx].offset + counter;
> +
> +		memset(plat->datbuf, 0xff, plat->mtd->writesize);
> +		memcpy(plat->datbuf, &buf[(sector / 4) * 2048], 2048);
> +		memset(plat->oobbuf, 0xff, plat->mtd->oobsize);
> +
> +		p_spare = (u32 *)&plat->oobbuf[(ecc->steps - 1) * NFC_SYS_DATA_SIZE];
> +
> +		*p_spare = (plat->page_table[sector / 4 + 1] - 1) * 4;
> +
> +		page = plat->page_table[sector / 4];
> +
> +		rockmtd_write_oob(plat->mtd,
> +				  off + page * plat->mtd->writesize,
> +				  plat->datbuf, plat->oobbuf);
> +
> +		counter += 4;
> +	}
> +
> +	memset(plat->check, 0xff, 512 * 512);
> +	rockmtd_read_block(plat, idx, plat->check);
> +
> +	for (j = 0; j < 2048; j++) {
> +		w = *(buf + j);
> +		r = *(plat->check + j);
> +
> +		if (r != w)
> +			goto dumpblock;
> +	}
> +
> +	for (j = 0; j < (plat->idblock[idx].boot_size * 512); j++) {
> +		w = *(buf + plat->idblock[idx].offset * 512 + j);
> +		r = *(plat->check + plat->idblock[idx].offset * 512  + j);
> +
> +		if (r != w)
> +			goto dumpblock;
> +	}
> +
> +	debug("write OK\n");
> +	return;
> +
> +dumpblock:
> +	debug("write and check error:%x r=%x w=%x\n", j, r, w);
> +
> +	plat->idblock[idx].offset = 0;
> +	plat->idblock[idx].boot_size = 0;
> +
> +	memset(plat->datbuf, 0xff, plat->mtd->writesize);
> +	memset(plat->datbuf, 0, 2048);
> +	memset(plat->oobbuf, 0xff, plat->mtd->oobsize);
> +
> +	rockmtd_write_oob(plat->mtd, off, plat->datbuf, plat->oobbuf);
> +}
> +
> +ulong rockmtd_bread(struct udevice *udev, lbaint_t start,
> +		    lbaint_t blkcnt, void *dst)
> +{
> +	struct blk_desc *block_dev = dev_get_uclass_plat(udev);
> +	struct udevice *parent_dev = dev_get_parent(udev);
> +	struct rockmtd_dev *plat = dev_get_plat(parent_dev);
> +	char *buf = dst;
> +	int i;
> +
> +	if (blkcnt == 0)
> +		return 0;
> +
> +	if (start > (block_dev->lba - 1) ||
> +	    (start + blkcnt) > block_dev->lba)
> +		return 0;
> +
> +	memset(dst, 0xff, blkcnt * block_dev->blksz);
> +
> +	for (i = start; i < (start + blkcnt); i++) {
> +		if (i == 0)  {
> +			debug("mbr     : %d\n", i);
> +
> +			memcpy(&buf[(i - start) * block_dev->blksz],
> +			       plat->mbr, sizeof(legacy_mbr));
> +		} else if (i == 1) {
> +			debug("gpt_h   : %d\n", i);
> +
> +			memcpy(&buf[(i - start) * block_dev->blksz],
> +			       plat->gpt_h, sizeof(gpt_header));
> +		} else if (i == (block_dev->lba - 1)) {
> +			debug("gpt_h2  : %d\n", i);
> +
> +			memcpy(&buf[(i - start) * block_dev->blksz],
> +			       plat->gpt_h2, sizeof(gpt_header));
> +		} else if (i == 2 || i == (block_dev->lba - 33)) {
> +			debug("gpt_e   : %d\n", i);
> +
> +			memcpy(&buf[(i - start) * block_dev->blksz],
> +			       plat->gpt_e, sizeof(gpt_entry));
> +		} else if (i >= 64 && i < (block_dev->lba - 33)) {
> +			debug("idb rd  : %d\n", i);
> +
> +			memcpy(&buf[(i - start) * block_dev->blksz],
> +			       &plat->idb[(i - 64) * block_dev->blksz], block_dev->blksz);
> +		}
> +	}
> +
> +	return blkcnt;
> +}
> +
> +ulong rockmtd_bwrite(struct udevice *udev, lbaint_t start,
> +		     lbaint_t blkcnt, const void *src)
> +{
> +	struct blk_desc *block_dev = dev_get_uclass_plat(udev);
> +	struct udevice *parent_dev = dev_get_parent(udev);
> +	struct rockmtd_dev *plat = dev_get_plat(parent_dev);
> +	int i, j;
> +
> +	if (blkcnt == 0)
> +		return 0;
> +
> +	if (start > (block_dev->lba - 1) ||
> +	    (start + blkcnt) > block_dev->lba)
> +		return 0;
> +
> +	for (i = start; i < (start + blkcnt); i++) {
> +		debug("idb wr  : %d\n", i);
> +
> +		if (i >= 64 && i < (block_dev->lba - 33)) {
> +			if (i == 64) {
> +				debug("first block\n");
> +
> +				plat->idb_need_write_back = 1;
> +				memset(plat->idb, 0xff, 512 * 512);
> +			}
> +
> +			if (plat->idb_need_write_back) {
> +				char *buf = (char *)src;
> +
> +				memcpy(&plat->idb[(i - 64) * block_dev->blksz],
> +				       &buf[(i - start) * block_dev->blksz],
> +				       block_dev->blksz);
> +
> +				if (i == 64) {
> +					memcpy(plat->check, plat->idb, 512);
> +
> +					if (*(u32 *)plat->check == RK_TAG) {
> +						struct sector0 *sec0 = (struct sector0 *)plat->check;
> +
> +						rockmtd_rc4(plat->check, 512);
> +
> +						plat->offset = sec0->boot_code1_offset;
> +						plat->boot_size = sec0->flash_boot_size;
> +
> +						if (plat->offset + plat->boot_size > 512) {
> +							debug("max size limit\n");
> +							plat->idb_need_write_back = 0;
> +						}
> +					} else {
> +						debug("no IDB block found\n");
> +						plat->idb_need_write_back = 0;
> +					}
> +				}
> +
> +				if (i == (64 + plat->offset + plat->boot_size - 1)) {
> +					debug("last block\n");
> +
> +					plat->idb_need_write_back = 0;
> +
> +					if (!plat->blk_counter) {
> +						plat->idblock[0].blk = 2;
> +						plat->idblock[1].blk = 3;
> +						plat->idblock[2].blk = 4;
> +						plat->idblock[3].blk = 5;
> +						plat->idblock[4].blk = 6;
> +						plat->blk_counter = 5;
> +					}
> +
> +					for (j = 0; j < plat->blk_counter; j++) {
> +						if (plat->idblock[j].blk < plat->boot_blks) {
> +							plat->idblock[j].offset = plat->offset;
> +							plat->idblock[j].boot_size = plat->boot_size;
> +							rockmtd_write_block(plat, j, plat->idb);
> +						}
> +					}
> +
> +					rockmtd_scan_block(plat);
> +
> +					memset(plat->idb, 0xff, 512 * 512);
> +
> +					if (plat->blk_counter)
> +						rockmtd_read_block(plat, 0, plat->idb);
> +				}
> +			}
> +		} else if (plat->idb_need_write_back) {
> +			plat->idb_need_write_back = 0;
> +
> +			memset(plat->idb, 0xff, 512 * 512);
> +
> +			if (plat->blk_counter)
> +				rockmtd_read_block(plat, 0, plat->idb);
> +		}
> +	}
> +
> +	return blkcnt;
> +}
> +
> +static const struct blk_ops rockmtd_blk_ops = {
> +	.read	= rockmtd_bread,
> +	.write	= rockmtd_bwrite,
> +};
> +
> +U_BOOT_DRIVER(rockmtd_blk) = {
> +	.name		= "rockmtd_blk",
> +	.id		= UCLASS_BLK,
> +	.ops		= &rockmtd_blk_ops,
> +};
> +
> +void rockmtd_build_page_table(struct rockmtd_dev *plat, u32 lsb_mode)
> +{
> +	u32 counter;
> +	u32 counter2;
> +
> +	switch (lsb_mode) {
> +	case 0:
> +		counter = 0;
> +		do {
> +			u16 val = counter;
> +
> +			plat->page_table[counter++] = val;
> +		} while (counter != 512);
> +		break;
> +	case 1:
> +		counter = 0;
> +		do {
> +			u16 val = counter;
> +
> +			if (counter > 3) {
> +				u16 offset;
> +
> +				if (counter & 1)
> +					offset = 3;
> +				else
> +					offset = 2;
> +				val = 2 * counter - offset;
> +			}
> +			plat->page_table[counter++] = val;
> +		} while (counter != 512);
> +		break;
> +	case 2:
> +		counter = 0;
> +		do {
> +			u16 val = counter;
> +
> +			if (counter > 1)
> +				val = 2 * counter - 1;
> +			plat->page_table[counter++] = val;
> +		} while (counter != 512);
> +		break;
> +	case 3:
> +		counter = 0;
> +		do {
> +			u16 val = counter;
> +
> +			if (counter > 5) {
> +				u16 offset;
> +
> +				if (counter & 1)
> +					offset = 5;
> +				else
> +					offset = 4;
> +				val = 2 * counter - offset;
> +			}
> +			plat->page_table[counter++] = val;
> +		} while (counter != 512);
> +		break;
> +	case 4:
> +		counter = 8;
> +		plat->page_table[0] = 0;
> +		plat->page_table[1] = 1;
> +		plat->page_table[2] = 2;
> +		plat->page_table[3] = 3;
> +		plat->page_table[4] = 4;
> +		plat->page_table[5] = 5;
> +		plat->page_table[6] = 7;
> +		plat->page_table[7] = 8;
> +		do {
> +			u32 offset;
> +			u32 val;
> +
> +			if (counter & 1)
> +				offset = 7;
> +			else
> +				offset = 6;
> +			val = 2 * counter - offset;
> +			plat->page_table[counter++] = val;
> +		} while (counter != 512);
> +		break;
> +	case 5:
> +		counter = 0;
> +		counter2 = 16;
> +		do {
> +			u16 val = counter;
> +
> +			plat->page_table[counter++] = val;
> +		} while (counter != 16);
> +		do {
> +			plat->page_table[counter++] = counter2;
> +			counter2 = counter2 + 2;
> +		} while (counter != 512);
> +		break;
> +	case 6:
> +		counter = 0;
> +		counter2 = 0;
> +		do {
> +			u16 val = counter;
> +
> +			if (counter > 5) {
> +				u16 offset;
> +
> +				if (counter & 1)
> +					offset = 12;
> +				else
> +					offset = 10;
> +				val = counter2 - offset;
> +			}
> +			plat->page_table[counter++] = val;
> +			counter2 = counter2 + 3;
> +		} while (counter != 512);
> +		break;
> +	case 9:
> +		counter = 3;
> +		counter2 = 3;
> +		plat->page_table[0] = 0;
> +		plat->page_table[1] = 1;
> +		plat->page_table[2] = 2;
> +		do {
> +			plat->page_table[counter++] = counter2;
> +			counter2 = counter2 + 2;
> +		} while (counter != 512);
> +		break;
> +	case 10:
> +		counter = 0;
> +		counter2 = 63;
> +		do {
> +			u16 val = counter;
> +
> +			plat->page_table[counter++] = val;
> +		} while (counter != 63);
> +		do {
> +			plat->page_table[counter++] = counter2;
> +			counter2 = counter2 + 2;
> +		} while (counter != 512);
> +		break;
> +	case 11:
> +		counter = 0;
> +		do {
> +			u16 val = counter;
> +
> +			plat->page_table[counter++] = val;
> +		} while (counter != 8);
> +		do {
> +			u32 offset;
> +			u32 val;
> +
> +			if (counter & 1)
> +				offset = 7;
> +			else
> +				offset = 6;
> +			val = 2 * counter - offset;
> +			plat->page_table[counter++] = val;
> +		} while (counter != 512);
> +		break;
> +	case 12:
> +		counter = 4;
> +		plat->page_table[0] = 0;
> +		plat->page_table[1] = 1;
> +		plat->page_table[2] = 2;
> +		plat->page_table[3] = 3;
> +		do {
> +			u32 val = counter - 1 + (counter >> 1);
> +
> +			plat->page_table[counter++] = val;
> +		} while (counter != 512);
> +		break;
> +	}
> +}
> +
> +static inline u32 efi_crc32(const void *buf, u32 len)
> +{
> +	return crc32(0, buf, len);
> +}
> +
> +int rockmtd_init_plat(struct udevice *dev)
> +{
> +	static const efi_guid_t partition_basic_data_guid = PARTITION_BASIC_DATA_GUID;
> +	struct rockmtd_dev *plat = dev_get_plat(dev);
> +	size_t efiname_len, dosname_len;
> +	uchar name[] = "loader1";
> +	u32 calc_crc32;
> +	int k;
> +
> +	if (!plat)
> +		debug("no plat ptr!\n");
> +
> +	gen_rand_uuid_str(plat->uuid_disk_str, UUID_STR_FORMAT_GUID);
> +	gen_rand_uuid_str(plat->uuid_part_str, UUID_STR_FORMAT_GUID);
> +
> +	debug("uuid_part_str          : %s\n", plat->uuid_part_str);
> +	debug("uuid_disk_str          : %s\n", plat->uuid_disk_str);
> +
> +	plat->idb = malloc_cache_aligned(512 * 512);
> +
> +	if (!plat->idb) {
> +		debug("idb malloc failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	plat->check = malloc_cache_aligned(512 * 512);
> +
> +	if (!plat->check) {
> +		debug("check malloc failed\n");
> +		free(plat->idb);
> +		return -ENOMEM;
> +	}
> +
> +	plat->mbr = malloc(sizeof(legacy_mbr));
> +
> +	if (!plat->mbr) {
> +		debug("mbr malloc failed\n");
> +		free(plat->idb);
> +		free(plat->check);
> +		return -ENOMEM;
> +	}
> +
> +	plat->gpt_e = malloc(sizeof(gpt_entry));
> +
> +	if (!plat->gpt_e) {
> +		debug("gpt_e malloc failed\n");
> +		free(plat->idb);
> +		free(plat->check);
> +		free(plat->mbr);
> +		return -ENOMEM;
> +	}
> +
> +	plat->gpt_h = malloc(sizeof(gpt_header));
> +
> +	if (!plat->gpt_h) {
> +		debug("gpt_h malloc failed\n");
> +		free(plat->idb);
> +		free(plat->check);
> +		free(plat->mbr);
> +		free(plat->gpt_e);
> +		return -ENOMEM;
> +	}
> +
> +	plat->gpt_h2 = malloc(sizeof(gpt_header));
> +
> +	if (!plat->gpt_h2) {
> +		debug("gpt_h2 malloc failed\n");
> +		free(plat->idb);
> +		free(plat->check);
> +		free(plat->mbr);
> +		free(plat->gpt_e);
> +		free(plat->gpt_h);
> +		return -ENOMEM;
> +	}
> +
> +	/* Init idb */
> +	memset(plat->idb, 0xff, 512 * 512);
> +
> +	/* Init mbr */
> +	memset((char *)plat->mbr, 0, sizeof(legacy_mbr));
> +
> +	plat->mbr->signature = MSDOS_MBR_SIGNATURE;
> +	plat->mbr->partition_record[0].sys_ind = EFI_PMBR_OSTYPE_EFI_GPT;
> +	plat->mbr->partition_record[0].start_sect = 1;
> +	plat->mbr->partition_record[0].nr_sects = LBA - 1;
> +
> +	/* Init gpt_e */
> +	memset(plat->gpt_e, 0, sizeof(gpt_entry));
> +
> +	plat->gpt_e->starting_lba = cpu_to_le64(64);
> +	plat->gpt_e->ending_lba = cpu_to_le64(LBA - 34);
> +
> +	debug("starting_lba           : %llu\n", le64_to_cpu(plat->gpt_e->starting_lba));
> +	debug("ending_lba             : %llu\n", le64_to_cpu(plat->gpt_e->ending_lba));
> +
> +	memcpy(plat->gpt_e->partition_type_guid.b, &partition_basic_data_guid, 16);
> +
> +	uuid_str_to_bin(plat->uuid_part_str, plat->gpt_e->unique_partition_guid.b,
> +			UUID_STR_FORMAT_GUID);
> +
> +	efiname_len = sizeof(plat->gpt_e->partition_name) / sizeof(efi_char16_t);
> +	dosname_len = sizeof(name);
> +
> +	for (k = 0; k < min(dosname_len, efiname_len); k++)
> +		plat->gpt_e->partition_name[k] = (efi_char16_t)(name[k]);
> +
> +	/* Init gpt_h */
> +	memset(plat->gpt_h, 0, sizeof(gpt_header));
> +
> +	plat->gpt_h->signature = cpu_to_le64(GPT_HEADER_SIGNATURE_UBOOT);
> +	plat->gpt_h->revision = cpu_to_le32(GPT_HEADER_REVISION_V1);
> +	plat->gpt_h->header_size = cpu_to_le32(sizeof(gpt_header));
> +	plat->gpt_h->first_usable_lba = cpu_to_le64(64);
> +	plat->gpt_h->last_usable_lba = cpu_to_le64(LBA - 34);
> +	plat->gpt_h->num_partition_entries = cpu_to_le32(1);
> +	plat->gpt_h->sizeof_partition_entry = cpu_to_le32(sizeof(gpt_entry));
> +
> +	uuid_str_to_bin(plat->uuid_disk_str, plat->gpt_h->disk_guid.b,
> +			UUID_STR_FORMAT_GUID);
> +
> +	plat->gpt_h->partition_entry_array_crc32 = 0;
> +	calc_crc32 = efi_crc32((const unsigned char *)plat->gpt_e,
> +			       le32_to_cpu(plat->gpt_h->num_partition_entries) *
> +			       le32_to_cpu(plat->gpt_h->sizeof_partition_entry));
> +	plat->gpt_h->partition_entry_array_crc32 = cpu_to_le32(calc_crc32);
> +
> +	debug("partition crc32        : 0x%08x\n", calc_crc32);
> +
> +	plat->gpt_h->my_lba = cpu_to_le64(1);
> +	plat->gpt_h->partition_entry_lba = cpu_to_le64(2);
> +	plat->gpt_h->alternate_lba = cpu_to_le64(LBA - 1);
> +
> +	plat->gpt_h->header_crc32 = 0;
> +	calc_crc32 = efi_crc32((const unsigned char *)plat->gpt_h,
> +			       le32_to_cpu(plat->gpt_h->header_size));
> +	plat->gpt_h->header_crc32 = cpu_to_le32(calc_crc32);
> +
> +	debug("header h1 crc32        : 0x%08x\n", calc_crc32);
> +
> +	/* Init gpt_h2 */
> +	memcpy(plat->gpt_h2, plat->gpt_h, sizeof(gpt_header));
> +
> +	plat->gpt_h2->my_lba = cpu_to_le64(LBA - 1);
> +	plat->gpt_h2->partition_entry_lba =
> +		cpu_to_le64(le64_to_cpu(plat->gpt_h2->last_usable_lba) + 1);
> +	plat->gpt_h2->alternate_lba = cpu_to_le64(1);
> +
> +	plat->gpt_h2->header_crc32 = 0;
> +	calc_crc32 = efi_crc32((const unsigned char *)plat->gpt_h2,
> +			       le32_to_cpu(plat->gpt_h2->header_size));
> +	plat->gpt_h2->header_crc32 = cpu_to_le32(calc_crc32);
> +
> +	debug("header h2 crc32        : 0x%08x\n", calc_crc32);
> +
> +	part_init(plat->desc);
> +
> +	return 0;
> +}
> +
> +static int rockmtd_sb_bind(struct udevice *dev)
> +{
> +	struct rockmtd_dev *plat = dev_get_plat(dev);
> +	struct udevice *bdev;
> +	struct blk_desc *desc;
> +	int ret;
> +
> +	ret = blk_create_devicef(dev, "rockmtd_blk", "blk", UCLASS_RKMTD,
> +				 -1, 512, 0, &bdev);
> +	if (ret)
> +		return log_msg_ret("blk", ret);
> +
> +	desc = dev_get_uclass_plat(bdev);
> +	desc->lba = LBA;
> +	sprintf(desc->vendor, "0x%.4x", 0x2207);
> +	memcpy(desc->product, "ROCKMTD", sizeof("ROCKMTD"));
> +	memcpy(desc->revision, "V1.00", sizeof("V1.00"));
> +	plat->desc = desc;
> +
> +	return 0;
> +}
> +
> +static inline struct rk_nfc_nand_chip *rk_nfc_to_rknand(struct nand_chip *chip)
> +{
> +	return container_of(chip, struct rk_nfc_nand_chip, chip);
> +}
> +
> +static int rockmtd_sb_attach_mtd(struct udevice *dev)
> +{
> +	struct rockmtd_dev *plat = dev_get_plat(dev);
> +	struct rk_nfc_nand_chip *rknand;
> +	struct nand_chip *chip;
> +	struct mtd_info *mtd;
> +	struct udevice *blk;
> +	int ret;
> +	u8 id[6];
> +	int i, j;
> +
> +	/* Sanity check that rockmtd_sb_bind() has been used */
> +	ret = blk_find_from_parent(dev, &blk);
> +	if (ret)
> +		return ret;
> +
> +	mtd = get_nand_dev_by_index(0);
> +	if (!mtd)
> +		return -ENOSYS;
> +
> +	chip = mtd_to_nand(mtd);
> +	rknand = rk_nfc_to_rknand(chip);
> +	plat->boot_blks = rknand->boot_blks;
> +	plat->mtd = mtd;
> +
> +	if (chip->select_chip)
> +		chip->select_chip(mtd, 0);
> +
> +	nand_readid_op(chip, 0, id, 6);
> +
> +	if (chip->select_chip)
> +		chip->select_chip(mtd, -1);
> +
> +	for (i = 0; i < ARRAY_SIZE(nand_para_tbl); i++) {
> +		plat->info = (struct nand_para_info *)&nand_para_tbl[i];
> +		for (j = 0; j < plat->info->id_bytes; j++) {
> +			if (plat->info->nand_id[j] != id[j])
> +				break;
> +			if (j == plat->info->id_bytes - 1)
> +				goto valid;
> +		}
> +	}
> +
> +	debug("no nand_para_info found\n");
> +	return -ENODEV;
> +valid:
> +	debug("FLASH ID :");
> +
> +	for (j = 0; j < plat->info->id_bytes; j++)
> +		debug(" %x", id[j]);
> +
> +	debug("\n");
> +
> +	rockmtd_build_page_table(plat, plat->info->lsb_mode);
> +
> +	plat->datbuf = malloc(mtd->writesize);
> +	if (!plat->datbuf) {
> +		debug("No memory for page buffer\n");
> +		return -ENOMEM;
> +	}
> +
> +	plat->oobbuf = malloc(mtd->oobsize);
> +	if (!plat->oobbuf) {
> +		debug("No memory for page buffer\n");
> +		free(plat->datbuf);
> +		return -ENOMEM;
> +	}
> +
> +	debug("erasesize     %8d\n", mtd->erasesize);
> +	debug("writesize     %8d\n", mtd->writesize);
> +	debug("oobsize       %8d\n", mtd->oobsize);
> +	debug("boot_blks     %8d\n", rknand->boot_blks);
> +	debug("lsb_mode      %8d\n", plat->info->lsb_mode);
> +
> +	ret = rockmtd_init_plat(dev);
> +	if (ret) {
> +		debug("rockmtd_init_plat failed\n");
> +		free(plat->datbuf);
> +		free(plat->oobbuf);
> +		return -ENOENT;
> +	}
> +
> +	rockmtd_scan_block(plat);
> +
> +	memset(plat->idb, 0xff, 512 * 512);
> +
> +	if (plat->blk_counter)
> +		rockmtd_read_block(plat, 0, plat->idb);
> +
> +	return 0;
> +}
> +
> +int rockmtd_sb_detach_mtd(struct udevice *dev)
> +{
> +	struct rockmtd_dev *plat = dev_get_plat(dev);
> +	int ret;
> +
> +	free(plat->idb);
> +	free(plat->check);
> +	free(plat->mbr);
> +	free(plat->gpt_e);
> +	free(plat->gpt_h);
> +	free(plat->gpt_h2);
> +	free(plat->datbuf);
> +	free(plat->oobbuf);
> +
> +	ret = device_remove(dev, DM_REMOVE_NORMAL);
> +	if (ret)
> +		return log_msg_ret("rem", ret);
> +
> +	ret = device_chld_unbind(dev, NULL);
> +	if (ret)
> +		return log_msg_ret("unb", ret);
> +
> +	return 0;
> +}
> +
> +struct rockmtd_ops {
> +	int (*attach_mtd)(struct udevice *dev);
> +	int (*detach_mtd)(struct udevice *dev);
> +};
> +
> +#define rockmtd_get_ops(dev)        ((struct rockmtd_ops *)(dev)->driver->ops)
> +
> +struct rockmtd_ops rockmtd_sb_ops = {
> +	.attach_mtd	= rockmtd_sb_attach_mtd,
> +	.detach_mtd	= rockmtd_sb_detach_mtd,
> +};
> +
> +U_BOOT_DRIVER(rockmtd_drv) = {
> +	.name		= "rockmtd_drv",
> +	.id		= UCLASS_RKMTD,
> +	.ops		= &rockmtd_sb_ops,
> +	.bind		= rockmtd_sb_bind,
> +	.plat_auto	= sizeof(struct rockmtd_dev),
> +};
> +
> +struct rockmtd_priv {
> +	struct udevice *cur_dev;
> +};
> +
> +struct udevice *rockmtd_get_cur_dev(void)
> +{
> +	struct uclass *uc = uclass_find(UCLASS_RKMTD);
> +
> +	if (uc) {
> +		struct rockmtd_priv *priv = uclass_get_priv(uc);
> +
> +		return priv->cur_dev;
> +	}
> +
> +	return NULL;
> +}
> +
> +void rockmtd_set_cur_dev(struct udevice *dev)
> +{
> +	struct uclass *uc = uclass_find(UCLASS_RKMTD);
> +
> +	if (uc) {
> +		struct rockmtd_priv *priv = uclass_get_priv(uc);
> +
> +		priv->cur_dev = dev;
> +	}
> +}
> +
> +struct udevice *rockmtd_find_by_label(const char *label)
> +{
> +	struct udevice *dev;
> +	struct uclass *uc;
> +
> +	uclass_id_foreach_dev(UCLASS_RKMTD, dev, uc) {
> +		struct rockmtd_dev *plat = dev_get_plat(dev);
> +
> +		if (plat->label && !strcmp(label, plat->label))
> +			return dev;
> +	}
> +
> +	return NULL;
> +}
> +
> +int rockmtd_attach_mtd(struct udevice *dev)
> +{
> +	struct rockmtd_ops *ops = rockmtd_get_ops(dev);
> +
> +	if (!ops->attach_mtd)
> +		return -ENOSYS;
> +
> +	return ops->attach_mtd(dev);
> +}
> +
> +int rockmtd_detach_mtd(struct udevice *dev)
> +{
> +	struct rockmtd_ops *ops = rockmtd_get_ops(dev);
> +
> +	if (!ops->detach_mtd)
> +		return -ENOSYS;
> +
> +	if (dev == rockmtd_get_cur_dev())
> +		rockmtd_set_cur_dev(NULL);
> +
> +	return ops->detach_mtd(dev);
> +}
> +
> +int rockmtd_create_device(const char *label, struct udevice **devp)
> +{
> +	char dev_name[30], *str, *label_new;
> +	struct rockmtd_dev *plat;
> +	struct udevice *dev, *blk;
> +	int ret;
> +
> +	/* unbind any existing device with this label */
> +	dev = rockmtd_find_by_label(label);
> +	if (dev) {
> +		ret = rockmtd_detach_mtd(dev);
> +		if (ret)
> +			return log_msg_ret("det", ret);
> +
> +		ret = device_unbind(dev);
> +		if (ret)
> +			return log_msg_ret("unb", ret);
> +	}
> +
> +	snprintf(dev_name, sizeof(dev_name), "rockmtd-%s", label);
> +	str = strdup(dev_name);
> +	if (!str)
> +		return -ENOMEM;
> +
> +	label_new = strdup(label);
> +	if (!label_new) {
> +		ret = -ENOMEM;
> +		goto no_label;
> +	}
> +
> +	ret = device_bind_driver(dm_root(), "rockmtd_drv", str, &dev);
> +	if (ret)
> +		goto no_dev;
> +
> +	device_set_name_alloced(dev);
> +
> +	if (!blk_find_from_parent(dev, &blk)) {
> +		struct blk_desc *desc = dev_get_uclass_plat(blk);
> +
> +		desc->removable = true;
> +	}
> +
> +	plat = dev_get_plat(dev);
> +	plat->label = label_new;
> +	*devp = dev;
> +
> +	return 0;
> +
> +no_dev:
> +	free(label_new);
> +no_label:
> +	free(str);
> +
> +	return ret;
> +}
> +
> +int rockmtd_create_attach_mtd(const char *label, struct udevice **devp)
> +{
> +	struct udevice *dev;
> +	int ret;
> +
> +	ret = rockmtd_create_device(label, &dev);
> +	if (ret)
> +		return log_msg_ret("cre", ret);
> +
> +	ret = rockmtd_attach_mtd(dev);
> +	if (ret) {
> +		device_unbind(dev);
> +		return log_msg_ret("att", ret);
> +	}
> +	*devp = dev;
> +
> +	return 0;
> +}
> +
> +UCLASS_DRIVER(rockmtd) = {
> +	.name		= "rockmtd",
> +	.id		= UCLASS_RKMTD,
> +	.post_bind	= dm_scan_fdt_dev,
> +	.priv_auto	= sizeof(struct rockmtd_priv),
> +};
> +
> +static int do_rockmtd_bind(struct cmd_tbl *cmdtp, int flag, int argc,
> +			   char *const argv[])
> +{
> +	struct udevice *dev;
> +	const char *label;
> +	int ret;
> +
> +	argc--;
> +	argv++;
> +
> +	if (argc < 1)
> +		return CMD_RET_USAGE;
> +
> +	if (argc > 1)
> +		return CMD_RET_USAGE;
> +
> +	label = argv[0];
> +	ret = rockmtd_create_attach_mtd(label, &dev);
> +	if (ret) {
> +		printf("Cannot create device / bind mtd\n");
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct udevice *parse_rockmtd_label(const char *label)
> +{
> +	struct udevice *dev;
> +
> +	dev = rockmtd_find_by_label(label);
> +	if (!dev) {
> +		int devnum;
> +		char *ep;
> +
> +		devnum = hextoul(label, &ep);
> +		if (*ep ||
> +		    uclass_find_device_by_seq(UCLASS_RKMTD, devnum, &dev)) {
> +			printf("No such device '%s'\n", label);
> +			return NULL;
> +		}
> +	}
> +
> +	return dev;
> +}
> +
> +static int do_rockmtd_unbind(struct cmd_tbl *cmdtp, int flag, int argc,
> +			     char *const argv[])
> +{
> +	struct udevice *dev;
> +	const char *label;
> +	int ret;
> +
> +	if (argc < 2)
> +		return CMD_RET_USAGE;
> +
> +	label = argv[1];
> +	dev = parse_rockmtd_label(label);
> +	if (!dev)
> +		return CMD_RET_FAILURE;
> +
> +	ret = rockmtd_detach_mtd(dev);
> +	if (ret) {
> +		printf("Cannot detach mtd\n");
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	ret = device_unbind(dev);
> +	if (ret) {
> +		printf("Cannot unbind device '%s'\n", dev->name);
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	return 0;
> +}
> +
> +static void show_rockmtd_dev(struct udevice *dev)
> +{
> +	struct rockmtd_dev *plat = dev_get_plat(dev);
> +	struct blk_desc *desc;
> +	struct udevice *blk;
> +	int ret;
> +
> +	printf("%3d ", dev_seq(dev));
> +
> +	ret = blk_get_from_parent(dev, &blk);
> +	if (ret)
> +		return;
> +
> +	desc = dev_get_uclass_plat(blk);
> +	printf("%12lu %-15s\n", (unsigned long)desc->lba, plat->label);
> +}
> +
> +static int do_rockmtd_info(struct cmd_tbl *cmdtp, int flag, int argc,
> +			   char *const argv[])
> +{
> +	struct udevice *dev;
> +
> +	if (argc < 1)
> +		return CMD_RET_USAGE;
> +
> +	dev = NULL;
> +	if (argc >= 2) {
> +		dev = parse_rockmtd_label(argv[1]);
> +		if (!dev)
> +			return CMD_RET_FAILURE;
> +	}
> +
> +	printf("%3s %12s %-15s\n", "dev", "blocks", "label");
> +	if (dev) {
> +		show_rockmtd_dev(dev);
> +	} else {
> +		struct uclass *uc;
> +
> +		uclass_id_foreach_dev(UCLASS_RKMTD, dev, uc)
> +			show_rockmtd_dev(dev);
> +	}
> +
> +	return 0;
> +}
> +
> +static int do_rockmtd_dev(struct cmd_tbl *cmdtp, int flag, int argc,
> +			  char *const argv[])
> +{
> +	struct udevice *dev;
> +	const char *label;
> +
> +	if (argc < 1 || argc > 3)
> +		return CMD_RET_USAGE;
> +
> +	if (argc == 1) {
> +		struct rockmtd_dev *plat;
> +
> +		dev = rockmtd_get_cur_dev();
> +		if (!dev) {
> +			printf("No current rockmtd device\n");
> +			return CMD_RET_FAILURE;
> +		}
> +		plat = dev_get_plat(dev);
> +		printf("Current rockmtd device: %d: %s\n", dev_seq(dev),
> +		       plat->label);
> +		return 0;
> +	}
> +
> +	label = argv[1];
> +	dev = parse_rockmtd_label(argv[1]);
> +	if (!dev)
> +		return CMD_RET_FAILURE;
> +
> +	rockmtd_set_cur_dev(dev);
> +
> +	return 0;
> +}
> +
> +static struct cmd_tbl cmd_rockmtd_sub[] = {
> +	U_BOOT_CMD_MKENT(bind, 4, 0, do_rockmtd_bind, "", ""),
> +	U_BOOT_CMD_MKENT(unbind, 4, 0, do_rockmtd_unbind, "", ""),
> +	U_BOOT_CMD_MKENT(info, 3, 0, do_rockmtd_info, "", ""),
> +	U_BOOT_CMD_MKENT(dev, 0, 1, do_rockmtd_dev, "", ""),
> +};
> +
> +static int do_rockmtd(struct cmd_tbl *cmdtp, int flag, int argc,
> +		      char *const argv[])
> +{
> +	struct cmd_tbl *c;
> +
> +	argc--;
> +	argv++;
> +
> +	c = find_cmd_tbl(argv[0], cmd_rockmtd_sub, ARRAY_SIZE(cmd_rockmtd_sub));
> +
> +	if (c)
> +		return c->cmd(cmdtp, flag, argc, argv);
> +	else
> +		return CMD_RET_USAGE;
> +}
> +
> +U_BOOT_CMD(
> +	rockmtd, 8, 1, do_rockmtd,
> +	"Rockchip MTD sub-system",
> +	"bind <label>      - bind ROCKMTD device\n"
> +	"rockmtd unbind <label>    - unbind ROCKMTD device\n"
> +	"rockmtd info [<label>]    - show all available ROCKMTD devices\n"
> +	"rockmtd dev [<label>]     - show or set current ROCKMTD device\n"
> +);
> --
> 2.30.2
>
