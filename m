Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D068C47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 09:32:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51B8E878EE;
	Wed, 17 Jan 2024 10:32:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="jS/JcKJp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6AD087A07; Wed, 17 Jan 2024 10:32:55 +0100 (CET)
Received: from mail-m12762.qiye.163.com (mail-m12762.qiye.163.com
 [115.236.127.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA3A586CF4
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 10:32:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=jS/JcKJp/3C1EUtLX6ORSDDUD7nrnY1LL6k9Qnf666+bwJ0uNCgEOieIGI4mYuLmITQe+i+gB41jcDrksgUPH0kYnBxrDV0b1UeGumbkKOnMh/9vK0AepZTIP8Fc6kyIem1kQTGoqv/y8QT+WMvJ/KqZtbhNPVBkSudlC7K465k=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=vKcA1Lrc9zthbIjI+s1h1x68A7XppnEmIzsKc7fuPnA=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11880.qiye.163.com (Hmail) with ESMTPA id BC33F208D5;
 Wed, 17 Jan 2024 17:32:45 +0800 (CST)
Message-ID: <b2cca69d-693d-4470-ad8f-466804e6f3fb@rock-chips.com>
Date: Wed, 17 Jan 2024 17:32:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next v2 5/6] rockchip: remove unused global data ptr
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: u-boot@lists.denx.de, jonas@kwiboo.se,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, heiko@sntech.de
References: <20231108-rk3588-spl-boot-dev-v2-0-e67e26202c85@theobroma-systems.com>
 <20231108-rk3588-spl-boot-dev-v2-5-e67e26202c85@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20231108-rk3588-spl-boot-dev-v2-5-e67e26202c85@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk5PTFZLHk1PT04dQ0MYSE9VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d16c415ee2eb6kusnbc33f208d5
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OAg6FRw5CjwhNhNNGSM*OggT
 PB4aCkNVSlVKTEtOT0NIQk1NTkJLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFNTU1KNwY+
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


On 2023/11/9 01:25, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>
> Remove leftover import and global data ptr from files since they aren't
> used anymore.
>
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/board.c         | 3 ---
>   arch/arm/mach-rockchip/rk3128/rk3128.c | 3 ---
>   arch/arm/mach-rockchip/rk3308/rk3308.c | 3 ---
>   arch/arm/mach-rockchip/rk3328/rk3328.c | 3 ---
>   arch/arm/mach-rockchip/rk3368/rk3368.c | 3 ---
>   arch/arm/mach-rockchip/rk3399/rk3399.c | 3 ---
>   arch/arm/mach-rockchip/rk3588/rk3588.c | 2 --
>   7 files changed, 20 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
> index 57f08e0be0e..6a9d297e6ff 100644
> --- a/arch/arm/mach-rockchip/board.c
> +++ b/arch/arm/mach-rockchip/board.c
> @@ -16,7 +16,6 @@
>   #include <syscon.h>
>   #include <uuid.h>
>   #include <asm/cache.h>
> -#include <asm/global_data.h>
>   #include <asm/io.h>
>   #include <asm/arch-rockchip/boot_mode.h>
>   #include <asm/arch-rockchip/clock.h>
> @@ -24,8 +23,6 @@
>   #include <asm/arch-rockchip/misc.h>
>   #include <power/regulator.h>
>   
> -DECLARE_GLOBAL_DATA_PTR;
> -
>   #if defined(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && defined(CONFIG_EFI_PARTITION)
>   
>   #define DFU_ALT_BUF_LEN			SZ_1K
> diff --git a/arch/arm/mach-rockchip/rk3128/rk3128.c b/arch/arm/mach-rockchip/rk3128/rk3128.c
> index 01dbfa75cb2..8f8f4951bae 100644
> --- a/arch/arm/mach-rockchip/rk3128/rk3128.c
> +++ b/arch/arm/mach-rockchip/rk3128/rk3128.c
> @@ -4,9 +4,6 @@
>    */
>   #include <common.h>
>   #include <init.h>
> -#include <asm/global_data.h>
> -
> -DECLARE_GLOBAL_DATA_PTR;
>   
>   int arch_cpu_init(void)
>   {
> diff --git a/arch/arm/mach-rockchip/rk3308/rk3308.c b/arch/arm/mach-rockchip/rk3308/rk3308.c
> index 5763604dc3e..6f121bf1304 100644
> --- a/arch/arm/mach-rockchip/rk3308/rk3308.c
> +++ b/arch/arm/mach-rockchip/rk3308/rk3308.c
> @@ -5,7 +5,6 @@
>   #include <common.h>
>   #include <init.h>
>   #include <malloc.h>
> -#include <asm/global_data.h>
>   #include <asm/io.h>
>   #include <asm/arch/grf_rk3308.h>
>   #include <asm/arch-rockchip/bootrom.h>
> @@ -14,8 +13,6 @@
>   #include <debug_uart.h>
>   #include <linux/bitops.h>
>   
> -DECLARE_GLOBAL_DATA_PTR;
> -
>   #include <asm/armv8/mmu.h>
>   static struct mm_region rk3308_mem_map[] = {
>   	{
> diff --git a/arch/arm/mach-rockchip/rk3328/rk3328.c b/arch/arm/mach-rockchip/rk3328/rk3328.c
> index de17b886827..02821c9e51d 100644
> --- a/arch/arm/mach-rockchip/rk3328/rk3328.c
> +++ b/arch/arm/mach-rockchip/rk3328/rk3328.c
> @@ -10,11 +10,8 @@
>   #include <asm/arch-rockchip/grf_rk3328.h>
>   #include <asm/arch-rockchip/uart.h>
>   #include <asm/armv8/mmu.h>
> -#include <asm/global_data.h>
>   #include <asm/io.h>
>   
> -DECLARE_GLOBAL_DATA_PTR;
> -
>   #define CRU_BASE		0xFF440000
>   #define GRF_BASE		0xFF100000
>   #define UART2_BASE		0xFF130000
> diff --git a/arch/arm/mach-rockchip/rk3368/rk3368.c b/arch/arm/mach-rockchip/rk3368/rk3368.c
> index d0a6107e5e0..d009b8758e5 100644
> --- a/arch/arm/mach-rockchip/rk3368/rk3368.c
> +++ b/arch/arm/mach-rockchip/rk3368/rk3368.c
> @@ -8,7 +8,6 @@
>   #include <init.h>
>   #include <syscon.h>
>   #include <asm/armv8/mmu.h>
> -#include <asm/global_data.h>
>   #include <asm/io.h>
>   #include <asm/arch-rockchip/bootrom.h>
>   #include <asm/arch-rockchip/clock.h>
> @@ -18,8 +17,6 @@
>   #include <linux/bitops.h>
>   #include <linux/delay.h>
>   
> -DECLARE_GLOBAL_DATA_PTR;
> -
>   #define IMEM_BASE                  0xFF8C0000
>   
>   /* Max MCU's SRAM value is 8K, begin at (IMEM_BASE + 4K) */
> diff --git a/arch/arm/mach-rockchip/rk3399/rk3399.c b/arch/arm/mach-rockchip/rk3399/rk3399.c
> index 6929de5603c..a13855f5ee2 100644
> --- a/arch/arm/mach-rockchip/rk3399/rk3399.c
> +++ b/arch/arm/mach-rockchip/rk3399/rk3399.c
> @@ -11,7 +11,6 @@
>   #include <spl_gpio.h>
>   #include <syscon.h>
>   #include <asm/armv8/mmu.h>
> -#include <asm/global_data.h>
>   #include <asm/io.h>
>   #include <asm/arch-rockchip/bootrom.h>
>   #include <asm/arch-rockchip/clock.h>
> @@ -23,8 +22,6 @@
>   #include <linux/printk.h>
>   #include <power/regulator.h>
>   
> -DECLARE_GLOBAL_DATA_PTR;
> -
>   #define GRF_EMMCCORE_CON11 0xff77f02c
>   #define GRF_BASE	0xff770000
>   
> diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
> index fde5f281b0a..093b2d1ba88 100644
> --- a/arch/arm/mach-rockchip/rk3588/rk3588.c
> +++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
> @@ -12,8 +12,6 @@
>   #include <asm/arch-rockchip/hardware.h>
>   #include <asm/arch-rockchip/ioc_rk3588.h>
>   
> -DECLARE_GLOBAL_DATA_PTR;
> -
>   #define FIREWALL_DDR_BASE		0xfe030000
>   #define FW_DDR_MST5_REG			0x54
>   #define FW_DDR_MST13_REG		0x74
>
