Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A764CDB483
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 07:17:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E77C486E43;
	Fri, 13 Oct 2023 09:16:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="WGczafEA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35E9D86E39; Fri, 13 Oct 2023 09:16:45 +0200 (CEST)
Received: from mail-m127228.xmail.ntesmail.com
 (mail-m127228.xmail.ntesmail.com [115.236.127.228])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4D4D86D20
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 09:16:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=WGczafEAfW7CltDa76PiyJ5d8i9QSohwG9WANtcEIuJmzp/fPZwVSAu6DBIH5HQAtGSKHk75VqR++QqV+6G0JbWJq9HagI3KkDTqgxCkUjzbC8F61N4KJbqESbUDWA+5DdhECak6k0NEcQRE9B3rB65E751UQsAzXIRVjfkwLpk=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=p8BfRvunC7IxEhA1yQOyoWUI96It1hv5g2/DetcSOW4=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 3D0424001B9;
 Fri, 13 Oct 2023 15:15:18 +0800 (CST)
Message-ID: <abf43229-e1c6-7a7f-6e60-8febaca2944c@rock-chips.com>
Date: Fri, 13 Oct 2023 15:15:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 3/7] rockchip: block: add rkmtd class and drivers
Content-Language: en-US
To: Johan Jonker <jbx6244@gmail.com>
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 u-boot@lists.denx.de
References: <9fffc997-fd13-eba2-3a73-a8e86816667c@gmail.com>
 <03bb36f8-0fb9-14d6-9b0e-182d0c8cff99@gmail.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <03bb36f8-0fb9-14d6-9b0e-182d0c8cff99@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU5PGlZOHUtITEJCQh9MSExVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSkpLSEpDVUpLS1VLWQ
 Y+
X-HM-Tid: 0a8b27e3bcf52eb3kusn3d0424001b9
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OTI6TQw5FzwrFAkjNyw8Fzoi
 Hy4aChdVSlVKTUJMSkNKSEpCTklIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPQ0pDSzcG
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


On 2023/10/13 04:51, Johan Jonker wrote:
> Add rkmtd class and drivers to create a virtual block device
> to transfer Rockchip boot block data to and from NAND with
> block orientated tools like "ums" and "rockusb".
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>
> Changed V3:
>    New patch
>    Split driver from command
>    Split header
>    Use devm_kzalloc
>    Remove out of memory debug
>    Restyle
> ---
>   drivers/block/Kconfig  |    7 +
>   drivers/block/Makefile |    2 +
>   drivers/block/rkmtd.c  | 1138 ++++++++++++++++++++++++++++++++++++++++
>   include/rkmtd.h        |  190 +++++++
>   4 files changed, 1337 insertions(+)
>   create mode 100644 drivers/block/rkmtd.c
>   create mode 100644 include/rkmtd.h
>
> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
> index 1abea3f10db4..048a6caef00f 100644
> --- a/drivers/block/Kconfig
> +++ b/drivers/block/Kconfig
> @@ -262,3 +262,10 @@ config SYS_64BIT_LBA
>   	help
>   	  Make the block subsystem use 64bit sector addresses, rather than the
>   	  default of 32bit.
> +
> +config RKMTD
> +	bool "Rockchip rkmtd virtual block device"
> +	help
> +	  Enable "rkmtd" class and driver to create a virtual block device
> +	  to transfer Rockchip boot block data to and from NAND with block
> +	  orientate tools like "ums" and "rockusb".
> diff --git a/drivers/block/Makefile b/drivers/block/Makefile
> index a161d145fd39..fdcba5c8318f 100644
> --- a/drivers/block/Makefile
> +++ b/drivers/block/Makefile
> @@ -11,6 +11,7 @@ endif
>
>   ifndef CONFIG_SPL_BUILD
>   obj-$(CONFIG_IDE) += ide.o
> +obj-$(CONFIG_RKMTD) += rkmtd.o
>   endif
>   obj-$(CONFIG_SANDBOX) += sandbox.o host-uclass.o host_dev.o
>   obj-$(CONFIG_$(SPL_TPL_)BLOCK_CACHE) += blkcache.o
> @@ -19,3 +20,4 @@ obj-$(CONFIG_BLKMAP) += blkmap.o
>   obj-$(CONFIG_EFI_MEDIA) += efi-media-uclass.o
>   obj-$(CONFIG_EFI_MEDIA_SANDBOX) += sb_efi_media.o
>   obj-$(CONFIG_EFI_MEDIA_BLK) += efi_blk.o
> +
> diff --git a/drivers/block/rkmtd.c b/drivers/block/rkmtd.c
> new file mode 100644
> index 000000000000..061c8d9b7c1a
> --- /dev/null
> +++ b/drivers/block/rkmtd.c
> @@ -0,0 +1,1138 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Some functions are derived from:
> + * https://github.com/rockchip-linux/u-boot/blob/next-dev/drivers/rknand/rk_ftl_arm_v7.S
> + * Copyright (c) 2016-2018, Fuzhou Rockchip Electronics Co., Ltd
> + *
> + * Driver interface derived from:
> + * /drivers/block/host_dev.c
> + * /drivers/block/host-uclass.c
> + * Copyright 2022 Google LLC
> + * Written by Simon Glass <sjg@chromium.org>
> + *
> + * Copyright (C) 2023 Johan Jonker <jbx6244@gmail.com>
> + */
> +
> +#include <blk.h>
> +#include <dm.h>
> +#include <dm/device-internal.h>
> +#include <dm/devres.h>
> +#include <dm/lists.h>
> +#include <dm/root.h>
> +#include <dm/uclass-internal.h>
> +#include <nand.h>
> +#include <linux/mtd/mtd.h>
> +#if !IS_ENABLED(CONFIG_SANDBOX)
> +#include <linux/mtd/rawnand.h>
> +#endif
> +#include <part.h>
> +#include <rkmtd.h>
> +#include <stddef.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <u-boot/crc.h>
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
> +#if !IS_ENABLED(CONFIG_SANDBOX)
> +static int rkmtd_write_oob(struct rkmtd_dev *plat, ulong off, u_char *datbuf, u_char *oobbuf)
> +{
> +	struct mtd_info *mtd = plat->mtd;
> +	struct mtd_oob_ops ops;
> +	loff_t addr;
> +	int ret;
> +
> +	off &= ~(mtd->writesize - 1);
> +	addr = (loff_t)off;
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
> +static int rkmtd_read_oob(struct rkmtd_dev *plat, ulong off, u_char *datbuf, u_char *oobbuf)
> +{
> +	struct mtd_info *mtd = plat->mtd;
> +	struct mtd_oob_ops ops;
> +	loff_t addr;
> +	int ret;
> +
> +	off &= ~(mtd->writesize - 1);
> +	addr = (loff_t)off;
> +
> +	memset(&ops, 0, sizeof(ops));
> +	ops.datbuf = datbuf;
> +	ops.oobbuf = oobbuf;
> +	ops.len = mtd->writesize;
> +	ops.ooblen = mtd->oobsize;
> +	ops.mode = MTD_OPS_PLACE_OOB;
> +	ret = mtd_read_oob(mtd, addr, &ops);
> +	if (ret < 0) {
> +		debug("Error (%d) reading page %08lx\n", ret, off);
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rkmtd_erase(struct rkmtd_dev *plat, ulong off)
> +{
> +	struct mtd_info *mtd = plat->mtd;
> +	struct erase_info info;
> +	loff_t addr;
> +	int ret;
> +
> +	off &= ~(mtd->writesize - 1);
> +	addr = (loff_t)off;
> +
> +	memset(&info, 0, sizeof(info));
> +	info.mtd = mtd;
> +	info.addr = addr;
> +	info.len = mtd->erasesize;
> +	info.scrub = 1;
> +	ret = mtd_erase(mtd, &info);
> +	if (ret) {
> +		debug("Error (%d) erasing page %08lx\n", ret, off);
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +#endif
> +void rkmtd_scan_block(struct rkmtd_dev *plat)
> +{
> +	plat->blk_counter = 0;
> +
> +#if !IS_ENABLED(CONFIG_SANDBOX)
> +	u32 blk;
> +
> +	for (blk = 0; blk < plat->boot_blks; blk++) {
> +		rkmtd_read_oob(plat, blk * plat->mtd->erasesize, plat->datbuf, plat->oobbuf);
> +		if (*(u32 *)plat->datbuf == RK_TAG) {
> +			struct sector0 *sec0 = (struct sector0 *)plat->datbuf;
> +
> +			rkmtd_rc4(plat->datbuf, 512);
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
> +#endif
> +}
> +
> +void rkmtd_read_block(struct rkmtd_dev *plat, u32 idx, u8 *buf)
> +{
> +#if !IS_ENABLED(CONFIG_SANDBOX)
> +	ulong off = plat->idblock[idx].blk * plat->mtd->erasesize;
> +	struct nand_chip *chip = mtd_to_nand(plat->mtd);
> +	struct nand_ecc_ctrl *ecc = &chip->ecc;
> +	int counter = 0;
> +	u32 spare0 = 0;
> +	u32 *p_spare;
> +	int sector;
> +	int page;
> +
> +	rkmtd_read_oob(plat, off,
> +		       plat->datbuf, plat->oobbuf);
> +
> +	memcpy(buf, plat->datbuf, BLK_SIZE);
> +
> +	while (counter < plat->idblock[idx].boot_size) {
> +		if (spare0)
> +			page = (plat->idblock[idx].offset + spare0) / 4;
> +		else
> +			page = (plat->idblock[idx].offset + counter) / 4;
> +
> +		rkmtd_read_oob(plat,
> +			       off + page * plat->mtd->writesize,
> +			       plat->datbuf, plat->oobbuf);
> +
> +		sector = plat->idblock[idx].offset + counter;
> +
> +		memcpy(&buf[(sector / 4) * BLK_SIZE], plat->datbuf, BLK_SIZE);
> +
> +		p_spare = (u32 *)&plat->oobbuf[(ecc->steps - 1) * NFC_SYS_DATA_SIZE];
> +
> +		spare0 = *p_spare;
> +		if (spare0 == -1)
> +			break;
> +
> +		counter += 4;
> +	}
> +#endif
> +}
> +
> +void rkmtd_write_block(struct rkmtd_dev *plat, u32 idx, u8 *buf)
> +{
> +#if !IS_ENABLED(CONFIG_SANDBOX)
> +	ulong off = plat->idblock[idx].blk * plat->mtd->erasesize;
> +	struct nand_chip *chip = mtd_to_nand(plat->mtd);
> +	struct nand_ecc_ctrl *ecc = &chip->ecc;
> +	int counter = 0;
> +	u32 *p_spare;
> +	int sector;
> +	int page;
> +	int j, w, r;
> +
> +	rkmtd_erase(plat, off);
> +
> +	memset(plat->datbuf, 0xff, plat->mtd->writesize);
> +	memcpy(plat->datbuf, buf, BLK_SIZE);
> +	memset(plat->oobbuf, 0xff, plat->mtd->oobsize);
> +
> +	rkmtd_write_oob(plat, off,
> +			plat->datbuf, plat->oobbuf);
> +
> +	while (counter < plat->idblock[idx].boot_size) {
> +		sector = plat->idblock[idx].offset + counter;
> +
> +		memset(plat->datbuf, 0xff, plat->mtd->writesize);
> +		memcpy(plat->datbuf, &buf[(sector / 4) * BLK_SIZE], BLK_SIZE);
> +		memset(plat->oobbuf, 0xff, plat->mtd->oobsize);
> +
> +		p_spare = (u32 *)&plat->oobbuf[(ecc->steps - 1) * NFC_SYS_DATA_SIZE];
> +
> +		*p_spare = (plat->page_table[sector / 4 + 1] - 1) * 4;
> +
> +		page = plat->page_table[sector / 4];
> +
> +		rkmtd_write_oob(plat,
> +				off + page * plat->mtd->writesize,
> +				plat->datbuf, plat->oobbuf);
> +
> +		counter += 4;
> +	}
> +
> +	memset(plat->check, 0xff, 512 * 512);
> +	rkmtd_read_block(plat, idx, plat->check);
> +
> +	for (j = 0; j < BLK_SIZE; j++) {
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
> +	memset(plat->datbuf, 0, BLK_SIZE);
> +	memset(plat->oobbuf, 0xff, plat->mtd->oobsize);
> +
> +	rkmtd_write_oob(plat, off, plat->datbuf, plat->oobbuf);
> +#endif
> +}
> +
> +ulong rkmtd_bread(struct udevice *udev, lbaint_t start,
> +		  lbaint_t blkcnt, void *dst)
> +{
> +	struct blk_desc *block_dev = dev_get_uclass_plat(udev);
> +	struct udevice *parent_dev = dev_get_parent(udev);
> +	struct rkmtd_dev *plat = dev_get_plat(parent_dev);
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
> +			debug("rd      : %d\n", i);
> +
> +			memcpy(&buf[(i - start) * block_dev->blksz],
> +			       &plat->idb[(i - 64) * block_dev->blksz], block_dev->blksz);
> +		}
> +	}
> +
> +	return blkcnt;
> +}
> +
> +ulong rkmtd_bwrite(struct udevice *udev, lbaint_t start,
> +		   lbaint_t blkcnt, const void *src)
> +{
> +	struct blk_desc *block_dev = dev_get_uclass_plat(udev);
> +	struct udevice *parent_dev = dev_get_parent(udev);
> +	struct rkmtd_dev *plat = dev_get_plat(parent_dev);
> +	struct sector0 *sec0;
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
> +		debug("wr      : %d\n", i);
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
> +						rkmtd_rc4(plat->check, 512);
> +
> +						sec0 = (struct sector0 *)plat->check;
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
> +							rkmtd_write_block(plat, j, plat->idb);
> +						}
> +					}
> +
> +					rkmtd_scan_block(plat);
> +
> +					if (!IS_ENABLED(CONFIG_SANDBOX))
> +						memset(plat->idb, 0xff, 512 * 512);
> +
> +					if (plat->blk_counter)
> +						rkmtd_read_block(plat, 0, plat->idb);
> +				}
> +			}
> +		} else if (plat->idb_need_write_back) {
> +			plat->idb_need_write_back = 0;
> +
> +			memset(plat->idb, 0xff, 512 * 512);
> +
> +			if (plat->blk_counter)
> +				rkmtd_read_block(plat, 0, plat->idb);
> +		}
> +	}
> +
> +	return blkcnt;
> +}
> +
> +static const struct blk_ops rkmtd_blk_ops = {
> +	.read	= rkmtd_bread,
> +	.write	= rkmtd_bwrite,
> +};
> +
> +U_BOOT_DRIVER(rkmtd_blk) = {
> +	.name		= "rkmtd_blk",
> +	.id		= UCLASS_BLK,
> +	.ops		= &rkmtd_blk_ops,
> +};
> +
> +void rkmtd_build_page_table(struct rkmtd_dev *plat)
> +{
> +	u32 counter;
> +	u32 counter2;
> +
> +	switch (plat->lsb_mode) {
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
> +int rkmtd_init_plat(struct udevice *dev)
> +{
> +	static const efi_guid_t partition_basic_data_guid = PARTITION_BASIC_DATA_GUID;
> +	struct rkmtd_dev *plat = dev_get_plat(dev);
> +	size_t efiname_len, dosname_len;
> +	uchar name[] = "loader1";
> +	u32 calc_crc32;
> +	int k;
> +
> +	gen_rand_uuid_str(plat->uuid_disk_str, UUID_STR_FORMAT_GUID);
> +	gen_rand_uuid_str(plat->uuid_part_str, UUID_STR_FORMAT_GUID);
> +
> +	debug("uuid_part_str          : %s\n", plat->uuid_part_str);
> +	debug("uuid_disk_str          : %s\n", plat->uuid_disk_str);
> +
> +	plat->idb = devm_kzalloc(plat->dev, 512 * 512, GFP_KERNEL);
> +	if (!plat->idb)
> +		return -ENOMEM;
> +
> +	plat->check = devm_kzalloc(plat->dev, 512 * 512, GFP_KERNEL);
> +	if (!plat->check)
> +		return -ENOMEM;
> +
> +	plat->mbr = devm_kzalloc(plat->dev, sizeof(legacy_mbr), GFP_KERNEL);
> +	if (!plat->mbr)
> +		return -ENOMEM;
> +
> +	plat->gpt_e = devm_kzalloc(plat->dev, sizeof(gpt_entry), GFP_KERNEL);
> +	if (!plat->gpt_e)
> +		return -ENOMEM;
> +
> +	plat->gpt_h = devm_kzalloc(plat->dev, sizeof(gpt_header), GFP_KERNEL);
> +	if (!plat->gpt_h)
> +		return -ENOMEM;
> +
> +	plat->gpt_h2 = devm_kzalloc(plat->dev, sizeof(gpt_header), GFP_KERNEL);
> +	if (!plat->gpt_h2)
> +		return -ENOMEM;
> +
> +	/* Init idb */
> +	memset(plat->idb, 0xff, 512 * 512);
> +
> +	/* Init mbr */
> +	plat->mbr->signature = MSDOS_MBR_SIGNATURE;
> +	plat->mbr->partition_record[0].sys_ind = EFI_PMBR_OSTYPE_EFI_GPT;
> +	plat->mbr->partition_record[0].start_sect = 1;
> +	plat->mbr->partition_record[0].nr_sects = LBA - 1;
> +
> +	/* Init gpt_e */
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
> +static int rkmtd_bind(struct udevice *dev)
> +{
> +	struct rkmtd_dev *plat = dev_get_plat(dev);
> +	struct udevice *bdev;
> +	struct blk_desc *desc;
> +	int ret;
> +
> +	ret = blk_create_devicef(dev, "rkmtd_blk", "blk", UCLASS_RKMTD,
> +				 -1, 512, 0, &bdev);
> +	if (ret)
> +		return log_msg_ret("blk", ret);
> +
> +	desc = dev_get_uclass_plat(bdev);
> +	desc->lba = LBA;
> +	sprintf(desc->vendor, "0x%.4x", 0x2207);
> +	memcpy(desc->product, "RKMTD", sizeof("RKMTD"));
> +	memcpy(desc->revision, "V1.00", sizeof("V1.00"));
> +	plat->desc = desc;
> +
> +	return 0;
> +}
> +
> +static int rkmtd_attach_mtd(struct udevice *dev)
> +{
> +	struct rkmtd_dev *plat = dev_get_plat(dev);
> +	struct mtd_info *mtd;
> +	struct udevice *blk;
> +	int ret;
> +
> +	plat->dev = dev;
> +
> +	/* Sanity check that rkmtd_bind() has been used */
> +	ret = blk_find_from_parent(dev, &blk);
> +	if (ret)
> +		return ret;
> +
> +#if IS_ENABLED(CONFIG_SANDBOX)
> +	plat->mtd = devm_kzalloc(dev, sizeof(struct mtd_info), GFP_KERNEL);
> +	if (!plat->mtd)
> +		return -ENOMEM;
> +
> +	mtd = plat->mtd;
> +	mtd->erasesize = 2 ^ 3 * BLK_SIZE;
> +	mtd->writesize = BLK_SIZE;
> +	mtd->oobsize = BLK_SIZE / STEP_SIZE * NFC_SYS_DATA_SIZE;
> +	plat->boot_blks = 0;
> +	plat->lsb_mode = 0;
> +#else
> +	struct nand_chip *chip;
> +	u8 id[6];
> +	int i, j;
> +	u32 tmp;
> +
> +	mtd = get_nand_dev_by_index(0);
> +	if (!mtd)
> +		return -ENOSYS;
> +
> +	chip = mtd_to_nand(mtd);
> +
> +	ret = ofnode_read_u32(chip->flash_node, "rockchip,boot-blks", &tmp);
> +	plat->boot_blks = ret ? 0 : tmp;
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
> +	plat->lsb_mode = plat->info->lsb_mode;
> +
> +	debug("FLASH ID :");
> +
> +	for (j = 0; j < plat->info->id_bytes; j++)
> +		debug(" %x", id[j]);
> +
> +	debug("\n");
> +#endif
> +
> +	rkmtd_build_page_table(plat);
> +
> +	plat->datbuf = devm_kzalloc(dev, mtd->writesize, GFP_KERNEL);
> +	if (!plat->datbuf)
> +		return -ENOMEM;
> +
> +	plat->oobbuf = devm_kzalloc(dev, mtd->oobsize, GFP_KERNEL);
> +	if (!plat->oobbuf)
> +		return -ENOMEM;
> +
> +	debug("erasesize     %8d\n", mtd->erasesize);
> +	debug("writesize     %8d\n", mtd->writesize);
> +	debug("oobsize       %8d\n", mtd->oobsize);
> +	debug("boot_blks     %8d\n", plat->boot_blks);
> +	debug("lsb_mode      %8d\n", plat->lsb_mode);
> +
> +	ret = rkmtd_init_plat(dev);
> +	if (ret) {
> +		debug("rkmtd_init_plat failed\n");
> +		return -ENOENT;
> +	}
> +
> +	rkmtd_scan_block(plat);
> +
> +	memset(plat->idb, 0xff, 512 * 512);
> +
> +	if (plat->blk_counter)
> +		rkmtd_read_block(plat, 0, plat->idb);
> +
> +	return 0;
> +}
> +
> +int rkmtd_detach_mtd(struct udevice *dev)
> +{
> +	int ret;
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
> +struct rkmtd_ops rkmtd_ops = {
> +	.attach_mtd	= rkmtd_attach_mtd,
> +	.detach_mtd	= rkmtd_detach_mtd,
> +};
> +
> +U_BOOT_DRIVER(rkmtd_drv) = {
> +	.name		= "rkmtd_drv",
> +	.id		= UCLASS_RKMTD,
> +	.ops		= &rkmtd_ops,
> +	.bind		= rkmtd_bind,
> +	.plat_auto	= sizeof(struct rkmtd_dev),
> +};
> +
> +struct rkmtd_priv {
> +	struct udevice *cur_dev;
> +};
> +
> +void rkmtd_rc4(u8 *buf, u32 len)
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
> +struct udevice *rkmtd_get_cur_dev(void)
> +{
> +	struct uclass *uc = uclass_find(UCLASS_RKMTD);
> +
> +	if (uc) {
> +		struct rkmtd_priv *priv = uclass_get_priv(uc);
> +
> +		return priv->cur_dev;
> +	}
> +
> +	return NULL;
> +}
> +
> +void rkmtd_set_cur_dev(struct udevice *dev)
> +{
> +	struct uclass *uc = uclass_find(UCLASS_RKMTD);
> +
> +	if (uc) {
> +		struct rkmtd_priv *priv = uclass_get_priv(uc);
> +
> +		priv->cur_dev = dev;
> +	}
> +}
> +
> +struct udevice *rkmtd_find_by_label(const char *label)
> +{
> +	struct udevice *dev;
> +	struct uclass *uc;
> +
> +	uclass_id_foreach_dev(UCLASS_RKMTD, dev, uc) {
> +		struct rkmtd_dev *plat = dev_get_plat(dev);
> +
> +		if (plat->label && !strcmp(label, plat->label))
> +			return dev;
> +	}
> +
> +	return NULL;
> +}
> +
> +int rkmtd_attach(struct udevice *dev)
> +{
> +	struct rkmtd_ops *ops = rkmtd_get_ops(dev);
> +
> +	if (!ops->attach_mtd)
> +		return -ENOSYS;
> +
> +	return ops->attach_mtd(dev);
> +}
> +
> +int rkmtd_detach(struct udevice *dev)
> +{
> +	struct rkmtd_ops *ops = rkmtd_get_ops(dev);
> +
> +	if (!ops->detach_mtd)
> +		return -ENOSYS;
> +
> +	if (dev == rkmtd_get_cur_dev())
> +		rkmtd_set_cur_dev(NULL);
> +
> +	return ops->detach_mtd(dev);
> +}
> +
> +static void rkmtd_kmalloc_release(struct udevice *dev, void *res)
> +{
> +	/* noop */
> +}
> +
> +int rkmtd_create_device(const char *label, struct udevice **devp)
> +{
> +	char dev_name[30], *str, *label_new;
> +	struct rkmtd_dev *plat;
> +	struct udevice *dev, *blk;
> +	int ret;
> +
> +	/* unbind any existing device with this label */
> +	dev = rkmtd_find_by_label(label);
> +	if (dev) {
> +		ret = rkmtd_detach(dev);
> +		if (ret)
> +			return log_msg_ret("det", ret);
> +
> +		ret = device_unbind(dev);
> +		if (ret)
> +			return log_msg_ret("unb", ret);
> +	}
> +
> +	snprintf(dev_name, sizeof(dev_name), "rkmtd-%s", label);
> +
> +	str = devres_alloc(rkmtd_kmalloc_release, strlen(dev_name) + 1, GFP_KERNEL);
> +	if (unlikely(!str))
> +		return -ENOMEM;
> +
> +	strcpy(str, dev_name);
> +
> +	ret = device_bind_driver(dm_root(), "rkmtd_drv", str, &dev);
> +	if (ret) {
> +		free(str);
> +		return ret;
> +	}
> +
> +	devres_add(dev, str);
> +
> +	if (!blk_find_from_parent(dev, &blk)) {
> +		struct blk_desc *desc = dev_get_uclass_plat(blk);
> +
> +		desc->removable = true;
> +	}
> +
> +	label_new = devm_kzalloc(dev, strlen(label) + 1, GFP_KERNEL);
> +	if (!label_new)
> +		return -ENOMEM;
> +
> +	strcpy(label_new, label);
> +
> +	plat = dev_get_plat(dev);
> +	plat->label = label_new;
> +	*devp = dev;
> +
> +	return 0;
> +}
> +
> +int rkmtd_create_attach_mtd(const char *label, struct udevice **devp)
> +{
> +	struct udevice *dev;
> +	int ret;
> +
> +	ret = rkmtd_create_device(label, &dev);
> +	if (ret)
> +		return log_msg_ret("cre", ret);
> +
> +	ret = rkmtd_attach(dev);
> +	if (ret) {
> +		device_unbind(dev);
> +		return log_msg_ret("att", ret);
> +	}
> +	*devp = dev;
> +
> +	return 0;
> +}
> +
> +UCLASS_DRIVER(rkmtd) = {
> +	.name		= "rkmtd",
> +	.id		= UCLASS_RKMTD,
> +	.post_bind	= dm_scan_fdt_dev,
> +	.priv_auto	= sizeof(struct rkmtd_priv),
> +};
> diff --git a/include/rkmtd.h b/include/rkmtd.h
> new file mode 100644
> index 000000000000..242efb44ce67
> --- /dev/null
> +++ b/include/rkmtd.h
> @@ -0,0 +1,190 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Driver interface derived from:
> + * /include/sandbox_host.h
> + * Copyright 2022 Google LLC
> + *
> + * Copyright 2023 Johan Jonker <jbx6244@gmail.com>
> + */
> +
> +#ifndef __RKMTD__
> +#define __RKMTD__
> +
> +#include <part_efi.h>
> +#include <uuid.h>
> +
> +#define LBA			64 + 512 + 33
> +
> +#define RK_TAG			0xFCDC8C3B
> +#define NFC_SYS_DATA_SIZE	4
> +#define BLK_SIZE		2048
> +#define STEP_SIZE		1024
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
> +struct rkmtd_dev {
> +	struct udevice *dev;
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
> +	u32 lsb_mode;
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
> +/**
> + * rkmtd_rc4() - Rockchip specific RC4 Encryption Algorithm
> + *
> + * Encrypt Rockchip boot block header version 1 and data
> + *
> + * @buf: Pointer to data buffer
> + * @len: Data buffer size
> + */
> +void rkmtd_rc4(u8 *buf, u32 len);
> +
> +/**
> + * struct rkmtd_ops - operations supported by UCLASS_RKMTD
> + */
> +struct rkmtd_ops {
> +	/**
> +	 * @attach_mtd: - Attach a new rkmtd driver to the device structure
> +	 *
> +	 * @attach_mtd.dev: Device to update
> +	 * @attach_mtd.Returns: 0 if OK, -EEXIST if a driver is already attached,
> +	 * other -ve on other error
> +	 */
> +	int (*attach_mtd)(struct udevice *dev);
> +
> +	/**
> +	 * @detach_mtd: - Detach a rkmtd driver from the device structure
> +	 *
> +	 * @detach_mtd.dev: Device to detach from
> +	 * @detach_mtd.Returns: 0 if OK, -ENOENT if no driver is attached,
> +	 * other -ve on other error
> +	 */
> +	int (*detach_mtd)(struct udevice *dev);
> +};
> +
> +#define rkmtd_get_ops(dev)        ((struct rkmtd_ops *)(dev)->driver->ops)
> +
> +/**
> + * rkmtd_get_cur_dev() - Get the current device
> + *
> + * Returns current device, or NULL if none
> + */
> +struct udevice *rkmtd_get_cur_dev(void);
> +
> +/**
> + * rkmtd_set_cur_dev() - Set the current device
> + *
> + * Sets the current device, or clears it if @dev is NULL
> + *
> + * @dev: Device to set as the current one
> + */
> +void rkmtd_set_cur_dev(struct udevice *dev);
> +
> +/**
> + * rkmtd_find_by_label() - Find a rkmtd device by label
> + *
> + * Searches all rkmtd devices to find one with the given label
> + *
> + * @label: Label to find
> + * Returns: associated device, or NULL if not found
> + */
> +struct udevice *rkmtd_find_by_label(const char *label);
> +
> +/**
> + * rkmtd_attach() - Attach a new rkmtd driver to the device structure
> + *
> + * @dev: Device to update
> + * Returns: 0 if OK, -EEXIST if a file is already attached, other -ve on
> + * other error
> + */
> +int rkmtd_attach(struct udevice *dev);
> +
> +/**
> + * rkmtd_detach() - Detach a rkmtd driver from the device structure
> + *
> + * @dev: Device to detach from
> + * Returns: 0 if OK, -ENOENT if no file is attached, other -ve on other
> + * error
> + */
> +int rkmtd_detach(struct udevice *dev);
> +
> +/**
> + * rkmtd_create_device() - Create a new rkmtd device
> + *
> + * Any existing device with the same label is removed and unbound first
> + *
> + * @label: Label of the attachment, e.g. "test1"
> + * @devp: Returns the device created, on success
> + * Returns: 0 if OK, -ve on error
> + */
> +int rkmtd_create_device(const char *label, struct udevice **devp);
> +
> +/**
> + * rkmtd_create_attach_mtd() - Create a new rkmtd device and attach driver
> + *
> + * @label: Label of the attachment, e.g. "test1"
> + * @devp: Returns the device created, on success
> + * Returns: 0 if OK, -ve on error
> + */
> +int rkmtd_create_attach_mtd(const char *label, struct udevice **devp);
> +
> +#endif /* __RKMTD__ */
> --
> 2.39.2
>
