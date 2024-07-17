Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0AD1C3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 04:31:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 214A18874A;
	Wed, 17 Jul 2024 06:31:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="AsuqizT1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE78C8871E; Wed, 17 Jul 2024 06:31:36 +0200 (CEST)
Received: from mail-m25497.xmail.ntesmail.com (mail-m25497.xmail.ntesmail.com
 [103.129.254.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B89B888258
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 06:31:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=AsuqizT1CmS+L3jAKrZsaKOuCKFpaV6wEYeN7usQSWjrqk6xfTlAtopn3yUjso/VhduzdKiq0wXgquPgBTHVx3pzPdPvgi8X4WGuezqU6fotcQDxBp8p1zeeoaxYDXoOYN3MPDjBkokMDULe9n8Et8eiGnU+tWyJioDS44WBxzs=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=SjOMZcYTtoOE17yhdrdIwiuzM2eftSbBxUef06WOWBs=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id A7F1E9002B4;
 Wed, 17 Jul 2024 12:31:17 +0800 (CST)
Message-ID: <1d700ac2-0525-4f42-87c6-61a29c54dbef@rock-chips.com>
Date: Wed, 17 Jul 2024 12:31:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] configs: rockchip: reduce diff for rk3308, rk3328, 
 rk3399, rk3568, and rk3588
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, andy.yan@rock-chips.com,
 gajjar04akash@gmail.com, jonas@kwiboo.se
References: <20240618095334.47722-1-naoki@radxa.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240618095334.47722-1-naoki@radxa.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ09CS1ZIQh8fTkxMQkMdQx9WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a90bef57e1203a9kunma7f1e9002b4
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MS46OCo4STI4FBMeMhIyUREi
 SQIwCU1VSlVKTElKSkJLTUxDTk1OVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKTE5CSTcG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Naoki,

On 2024/6/18 17:53, FUKAUMI Naoki wrote:
> this is cosmetic change. no functional change is intended.
>
> - remove redundant white spaces
> - replace white spaces with tab
> - align position of last letter/word
> - sort lines in CFG_EXTRA_ENV_SETTINGS
> - add comment after #endif
>
> Signed-off-by: FUKAUMI Naoki<naoki@radxa.com>
>
> Changes in v2:
> - rewrite whole commit message

1. I can't find the 3/3 in the list, I don't know the reason;

2. How do you generate the change log here? This format is not correct 
because it will be applied in the patch;

I think you miss separator "---" after signature.


Thanks,

- Kever

> ---
>   include/configs/rk3308_common.h | 26 ++++++++++-----------
>   include/configs/rk3328_common.h | 28 +++++++++++------------
>   include/configs/rk3399_common.h | 40 ++++++++++++++++-----------------
>   include/configs/rk3568_common.h | 14 ++++++------
>   include/configs/rk3588_common.h | 12 +++++-----
>   5 files changed, 60 insertions(+), 60 deletions(-)
>
> diff --git a/include/configs/rk3308_common.h b/include/configs/rk3308_common.h
> index 861154fbeb..80113220e4 100644
> --- a/include/configs/rk3308_common.h
> +++ b/include/configs/rk3308_common.h
> @@ -8,24 +8,24 @@
>   
>   #include "rockchip-common.h"
>   
> -#define CFG_IRAM_BASE		0xfff80000
> +#define CFG_IRAM_BASE			0xfff80000
>   
>   #define CFG_SYS_SDRAM_BASE		0
>   #define SDRAM_MAX_SIZE			0xff000000
>   
> -#define ENV_MEM_LAYOUT_SETTINGS \
> -	"scriptaddr=0x00500000\0" \
> -	"pxefile_addr_r=0x00600000\0" \
> -	"fdt_addr_r=0x03e00000\0" \
> -	"fdtoverlay_addr_r=0x03f00000\0" \
> -	"kernel_addr_r=0x00680000\0" \
> +#define ENV_MEM_LAYOUT_SETTINGS		\
> +	"scriptaddr=0x00500000\0"	\
> +	"pxefile_addr_r=0x00600000\0"	\
> +	"fdt_addr_r=0x03e00000\0"	\
> +	"fdtoverlay_addr_r=0x03f00000\0"	\
> +	"kernel_addr_r=0x00680000\0"	\
>   	"ramdisk_addr_r=0x04000000\0"
>   
> -#define CFG_EXTRA_ENV_SETTINGS \
> -	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
> -	ENV_MEM_LAYOUT_SETTINGS \
> -	"partitions=" PARTS_DEFAULT \
> -	ROCKCHIP_DEVICE_SETTINGS \
> +#define CFG_EXTRA_ENV_SETTINGS		\
> +	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0"	\
> +	"partitions=" PARTS_DEFAULT	\
> +	ENV_MEM_LAYOUT_SETTINGS		\
> +	ROCKCHIP_DEVICE_SETTINGS	\
>   	"boot_targets=" BOOT_TARGETS "\0"
>   
> -#endif
> +#endif /* __CONFIG_RK3308_COMMON_H */
> diff --git a/include/configs/rk3328_common.h b/include/configs/rk3328_common.h
> index 2c40674b22..f9e6634c5f 100644
> --- a/include/configs/rk3328_common.h
> +++ b/include/configs/rk3328_common.h
> @@ -8,25 +8,25 @@
>   
>   #include "rockchip-common.h"
>   
> -#define CFG_IRAM_BASE		0xff090000
> +#define CFG_IRAM_BASE			0xff090000
>   
>   #define CFG_SYS_SDRAM_BASE		0
>   #define SDRAM_MAX_SIZE			0xff000000
>   
> -#define ENV_MEM_LAYOUT_SETTINGS \
> -	"scriptaddr=0x00500000\0" \
> -	"pxefile_addr_r=0x00600000\0" \
> -	"fdt_addr_r=0x01f00000\0" \
> -	"kernel_addr_r=0x02080000\0" \
> -	"ramdisk_addr_r=0x06000000\0" \
> -	"kernel_comp_addr_r=0x08000000\0" \
> +#define ENV_MEM_LAYOUT_SETTINGS		\
> +	"scriptaddr=0x00500000\0"	\
> +	"pxefile_addr_r=0x00600000\0"	\
> +	"fdt_addr_r=0x01f00000\0"	\
> +	"kernel_addr_r=0x02080000\0"	\
> +	"ramdisk_addr_r=0x06000000\0"	\
> +	"kernel_comp_addr_r=0x08000000\0"	\
>   	"kernel_comp_size=0x2000000\0"
>   
> -#define CFG_EXTRA_ENV_SETTINGS \
> -	ENV_MEM_LAYOUT_SETTINGS \
> -	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
> -	"partitions=" PARTS_DEFAULT \
> -	ROCKCHIP_DEVICE_SETTINGS \
> +#define CFG_EXTRA_ENV_SETTINGS		\
> +	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0"	\
> +	"partitions=" PARTS_DEFAULT	\
> +	ENV_MEM_LAYOUT_SETTINGS		\
> +	ROCKCHIP_DEVICE_SETTINGS	\
>   	"boot_targets=" BOOT_TARGETS "\0"
>   
> -#endif
> +#endif /* __CONFIG_RK3328_COMMON_H */
> diff --git a/include/configs/rk3399_common.h b/include/configs/rk3399_common.h
> index 4e75771055..62007c8b27 100644
> --- a/include/configs/rk3399_common.h
> +++ b/include/configs/rk3399_common.h
> @@ -8,36 +8,36 @@
>   
>   #include "rockchip-common.h"
>   
> -#define CFG_IRAM_BASE		0xff8c0000
> +#define CFG_IRAM_BASE			0xff8c0000
>   
>   #define CFG_SYS_SDRAM_BASE		0
>   #define SDRAM_MAX_SIZE			0xf8000000
>   
>   #ifndef CONFIG_SPL_BUILD
>   
> -#define ENV_MEM_LAYOUT_SETTINGS \
> -	"scriptaddr=0x00500000\0" \
> -	"script_offset_f=0xffe000\0" \
> -	"script_size_f=0x2000\0" \
> -	"pxefile_addr_r=0x00600000\0" \
> -	"fdt_addr_r=0x01f00000\0" \
> -	"fdtoverlay_addr_r=0x02000000\0" \
> -	"kernel_addr_r=0x02080000\0" \
> -	"ramdisk_addr_r=0x06000000\0" \
> -	"kernel_comp_addr_r=0x08000000\0" \
> -	"kernel_comp_size=0x2000000\0"
> -
>   #ifndef ROCKCHIP_DEVICE_SETTINGS
>   #define ROCKCHIP_DEVICE_SETTINGS
>   #endif
>   
> -#define CFG_EXTRA_ENV_SETTINGS \
> -	ENV_MEM_LAYOUT_SETTINGS \
> -	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
> -	"partitions=" PARTS_DEFAULT \
> -	ROCKCHIP_DEVICE_SETTINGS \
> +#define ENV_MEM_LAYOUT_SETTINGS		\
> +	"scriptaddr=0x00500000\0"	\
> +	"script_offset_f=0xffe000\0"	\
> +	"script_size_f=0x2000\0"	\
> +	"pxefile_addr_r=0x00600000\0"	\
> +	"fdt_addr_r=0x01f00000\0"	\
> +	"fdtoverlay_addr_r=0x02000000\0"	\
> +	"kernel_addr_r=0x02080000\0"	\
> +	"ramdisk_addr_r=0x06000000\0"	\
> +	"kernel_comp_addr_r=0x08000000\0"	\
> +	"kernel_comp_size=0x2000000\0"
> +
> +#define CFG_EXTRA_ENV_SETTINGS		\
> +	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0"	\
> +	"partitions=" PARTS_DEFAULT	\
> +	ENV_MEM_LAYOUT_SETTINGS		\
> +	ROCKCHIP_DEVICE_SETTINGS	\
>   	"boot_targets=" BOOT_TARGETS "\0"
>   
> -#endif
> +#endif /* CONFIG_SPL_BUILD */
>   
> -#endif
> +#endif /* __CONFIG_RK3399_COMMON_H */
> diff --git a/include/configs/rk3568_common.h b/include/configs/rk3568_common.h
> index 48f93083de..09b7b71c6a 100644
> --- a/include/configs/rk3568_common.h
> +++ b/include/configs/rk3568_common.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier:     GPL-2.0+ */
> +/* SPDX-License-Identifier: GPL-2.0+ */
>   /*
>    * (C) Copyright 2021 Rockchip Electronics Co., Ltd
>    */
> @@ -10,7 +10,7 @@
>   
>   #include "rockchip-common.h"
>   
> -#define CFG_IRAM_BASE		0xfdcc0000
> +#define CFG_IRAM_BASE			0xfdcc0000
>   
>   #define CFG_SYS_SDRAM_BASE		0
>   #define SDRAM_MAX_SIZE			0xf0000000
> @@ -28,10 +28,10 @@
>   	"kernel_comp_size=0x8000000\0"
>   
>   #define CFG_EXTRA_ENV_SETTINGS		\
> -	ENV_MEM_LAYOUT_SETTINGS			\
> -	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
> -	"partitions=" PARTS_DEFAULT		\
> -	ROCKCHIP_DEVICE_SETTINGS \
> +	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0"	\
> +	"partitions=" PARTS_DEFAULT	\
> +	ENV_MEM_LAYOUT_SETTINGS		\
> +	ROCKCHIP_DEVICE_SETTINGS	\
>   	"boot_targets=" BOOT_TARGETS "\0"
>   
> -#endif
> +#endif /* __CONFIG_RK3568_COMMON_H */
> diff --git a/include/configs/rk3588_common.h b/include/configs/rk3588_common.h
> index 70430612ef..e6654c275a 100644
> --- a/include/configs/rk3588_common.h
> +++ b/include/configs/rk3588_common.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier:     GPL-2.0+ */
> +/* SPDX-License-Identifier: GPL-2.0+ */
>   /*
>    * (C) Copyright 2021 Rockchip Electronics Co., Ltd
>    * Copyright (c) 2023 Edgeble AI Technologies Pvt. Ltd.
> @@ -26,11 +26,11 @@
>   	"ramdisk_addr_r=0x12180000\0"	\
>   	"kernel_comp_size=0x8000000\0"
>   
> -#define CFG_EXTRA_ENV_SETTINGS \
> -	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
> -	"partitions=" PARTS_DEFAULT		\
> -	ENV_MEM_LAYOUT_SETTINGS			\
> -	ROCKCHIP_DEVICE_SETTINGS \
> +#define CFG_EXTRA_ENV_SETTINGS		\
> +	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0"	\
> +	"partitions=" PARTS_DEFAULT	\
> +	ENV_MEM_LAYOUT_SETTINGS		\
> +	ROCKCHIP_DEVICE_SETTINGS	\
>   	"boot_targets=" BOOT_TARGETS "\0"
>   
>   #endif /* __CONFIG_RK3588_COMMON_H */
