Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9945F417E5
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 14:34:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B5BD83F20;
	Mon,  9 Mar 2026 15:34:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="PiBatAdL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B4D983F20; Mon,  9 Mar 2026 15:34:16 +0100 (CET)
Received: from mail-m1973198.qiye.163.com (mail-m1973198.qiye.163.com
 [220.197.31.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 278B583F2A
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 15:34:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [120.36.72.154])
 by smtp.qiye.163.com (Hmail) with ESMTP id 3646e8073;
 Mon, 9 Mar 2026 22:34:07 +0800 (GMT+08:00)
Message-ID: <c2246551-3b62-4e8e-a633-0485e7043e46@rock-chips.com>
Date: Mon, 9 Mar 2026 22:34:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rockchip: Reduce size of ramboot usb472 payload
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20260204212922.1611383-1-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20260204212922.1611383-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9cd305036d03afkunm54f2dbf316bb9d2
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSB9LVhgfTkpCTRlJTkJJSlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUtVSE1VTElVSk5PWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=PiBatAdLNHj/TIC7iIx31J+IXOJRMt6ChNtFJD7FroPR0X5XSNwlzcvGnECG3ojXYIh2+WyWimQZ0vANJ+XLFq4oa7LuZQ4pXawpspPSEoFZGMvE+L37N7TiLxE1Mujq+nxHypqb5WeQ2QIl7Pv8oFIw9eoeZNX8YdjVEzkAw6k=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=MLH4DdRFA2PxGxpX4aaMsxPA4mow0nZ768+CMvam7RM=;
 h=date:mime-version:subject:message-id:from;
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


On 2026/2/5 05:29, Jonas Karlman wrote:
> Booting into SPL using ramboot can take several seconds on some SoCs due
> to the large size of the usb472 payload sent over USB to BootROM.
>
> A large chunk of the usb472 payload, around 1-2 MiB, is padding used to
> avoid overlapping when loading e.g. TF-A to 0x40000.
>
> BootROM is likely wasting unnecessary time crc16 validating the padding
> of the payload.
>
> Place the FIT payload directly after SPL and memmove it to the expected
> memory location, SPL_LOAD_FIT_ADDRESS, to avoid excessive padding and
> help speed up ramboot.
>
> Binman symbols are used to get the position and size of the FIT payload
> that is initially loaded into DRAM by the BootROM.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: Drop use of skip-at-start prop, image_pos is already taking
>      SPL_TEXT_BASE into account and was already correct for SoCs not
>      using 0x0 as SPL_TEXT_BASE, e.g. RK3576 and RV1126B
> ---
>   arch/arm/dts/rockchip-u-boot.dtsi |  6 ++--
>   arch/arm/mach-rockchip/spl.c      | 51 +++++++++++++++++++++++++++++++
>   2 files changed, 55 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> index 71d7623fe2ca..4ba6a87e78ab 100644
> --- a/arch/arm/dts/rockchip-u-boot.dtsi
> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> @@ -246,16 +246,18 @@
>   		pad-byte = <0x00>;
>   
>   		u-boot-spl {
> -			no-write-symbols;
>   		};
>   
> +		payload {
> +			type = "section";
> +			align = <CONFIG_SYS_CACHELINE_SIZE>;
>   #ifdef HAS_FIT
>   		fit {
>   			insert-template = <&fit_template>;
>   #else
>   		u-boot-img {
>   #endif
> -			offset = <(CONFIG_SPL_LOAD_FIT_ADDRESS - CFG_SYS_SDRAM_BASE)>;
> +		};
>   		};
>   	};
>   #endif /* CONFIG_ROCKCHIP_MASKROM_IMAGE */
> diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
> index 1ce3a3b05547..a9155dceedb4 100644
> --- a/arch/arm/mach-rockchip/spl.c
> +++ b/arch/arm/mach-rockchip/spl.c
> @@ -3,6 +3,7 @@
>    * (C) Copyright 2019 Rockchip Electronics Co., Ltd
>    */
>   
> +#include <binman_sym.h>
>   #include <cpu_func.h>
>   #include <debug_uart.h>
>   #include <dm.h>
> @@ -10,6 +11,7 @@
>   #include <image.h>
>   #include <init.h>
>   #include <log.h>
> +#include <mapmem.h>
>   #include <ram.h>
>   #include <spl.h>
>   #include <asm/arch-rockchip/bootrom.h>
> @@ -140,3 +142,52 @@ void spl_board_prepare_for_boot(void)
>   
>   	cleanup_before_linux();
>   }
> +
> +#if CONFIG_IS_ENABLED(RAM_DEVICE) && IS_ENABLED(CONFIG_SPL_LOAD_FIT)
> +binman_sym_declare_optional(ulong, payload, image_pos);
> +binman_sym_declare_optional(ulong, payload, size);
> +
> +static ulong ramboot_load_read(struct spl_load_info *load, ulong sector,
> +			       ulong count, void *buf)
> +{
> +	ulong addr = IF_ENABLED_INT(CONFIG_SPL_LOAD_FIT,
> +				    CONFIG_SPL_LOAD_FIT_ADDRESS);
> +
> +	memcpy(buf, map_sysmem(addr + sector, 0), count);
> +	return count;
> +}
> +
> +static int ramboot_load_image(struct spl_image_info *spl_image,
> +			      struct spl_boot_device *bootdev)
> +{
> +	struct legacy_img_hdr *header;
> +	ulong addr = IF_ENABLED_INT(CONFIG_SPL_LOAD_FIT,
> +				    CONFIG_SPL_LOAD_FIT_ADDRESS);
> +	ulong image_pos = binman_sym(ulong, payload, image_pos);
> +	ulong size = binman_sym(ulong, payload, size);
> +
> +	if (addr == CFG_SYS_SDRAM_BASE || addr == CONFIG_SPL_TEXT_BASE)
> +		return -ENODEV;
> +
> +	if (image_pos != BINMAN_SYM_MISSING && size != BINMAN_SYM_MISSING) {
> +		header = map_sysmem(image_pos, 0);
> +		if (image_get_magic(header) == FDT_MAGIC) {
> +			memmove(map_sysmem(addr, 0), header, size);
> +			memset(header, 0, sizeof(*header));
> +		}
> +	}
> +
> +	header = map_sysmem(addr, 0);
> +	if (image_get_magic(header) == FDT_MAGIC) {
> +		struct spl_load_info load;
> +
> +		spl_load_init(&load, ramboot_load_read, NULL, 1);
> +		return spl_load_simple_fit(spl_image, &load, 0, header);
> +	}
> +
> +	return -ENODEV;
> +}
> +
> +/* Use priority and method name that sort before default spl_ram_load_image */
> +SPL_LOAD_IMAGE_METHOD("RAM", 0, BOOT_DEVICE_RAM, ramboot_load_image);
> +#endif
