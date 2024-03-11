Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F93C5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 09:23:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B91D87EF5;
	Mon, 11 Mar 2024 10:23:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="YNbmgPlH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0195E87EEF; Mon, 11 Mar 2024 10:23:21 +0100 (CET)
Received: from mail-m49223.qiye.163.com (mail-m49223.qiye.163.com
 [45.254.49.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D00987EF2
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 10:23:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=YNbmgPlHJwRI/ZGHb9S8Dk3iq5600pZoSmYvfpzr8Ig9Jgn289kANHBKBQwgkf1vydPuZ2oI9gwjXP+uSQ0MO/0FcN5t7HFITdg5nZMG7F0wVRRYkzo87mM+Sstq1DbXJuhq+S6yFYxZU2KmZgKISLoaOWUzUp1Kp//AmRtj4dc=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=gLCH/tS3QM/+0xwLqpaYy/wCP6FKBvwIWO8vVnTaRfs=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 4E334900411;
 Mon, 11 Mar 2024 17:23:08 +0800 (CST)
Message-ID: <d896615e-19b0-4099-82af-7347fdcdddca@rock-chips.com>
Date: Mon, 11 Mar 2024 17:23:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] board: rockchip: rk3399: Remove unused
 board_early_init_f functions
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Levin Du <djw@t-chip.com.cn>, Suniel Mahesh <sunil@amarulasolutions.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
References: <20240217183610.2621132-1-jonas@kwiboo.se>
 <20240217183610.2621132-4-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240217183610.2621132-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ01DGFYdQkIaQkhLGkIZTEJVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8e2cd2b08603a9kunm4e334900411
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NCo6GQw5UTMVFjArLUgyAhRI
 Kh5PCh9VSlVKTEpLSk9DQkJLS0JLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFMSUtNNwY+
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


On 2024/2/18 02:35, Jonas Karlman wrote:
> These functions is excluded from SPL build and BOARD_EARLY_INIT_F is not
> enabled for any of the affected boards, so this legacy code is not used.
>
> Rockchip common board code already enable all regulators flagged as
> always-on or boot-on in device tree, and fixed/gpio regulators now have
> basic reference counting support so the original intent of this code is
> no longer valid.
>
> Remove the unneeded and unused code that used to enable usb regulators.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   board/firefly/roc-pc-rk3399/roc-pc-rk3399.c   | 22 +------------------
>   .../pinebook-pro-rk3399/pinebook-pro-rk3399.c | 22 -------------------
>   .../pinephone-pro-rk3399.c                    | 22 -------------------
>   board/rockchip/evb_rk3399/evb-rk3399.c        | 20 -----------------
>   4 files changed, 1 insertion(+), 85 deletions(-)
>
> diff --git a/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c b/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
> index 93e7d776fb2f..590519b32af2 100644
> --- a/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
> +++ b/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
> @@ -9,32 +9,12 @@
>   #include <log.h>
>   #include <spl_gpio.h>
>   #include <asm/io.h>
> -#include <power/regulator.h>
>   
>   #include <asm/arch-rockchip/cru.h>
>   #include <asm/arch-rockchip/gpio.h>
>   #include <asm/arch-rockchip/grf_rk3399.h>
>   
> -#ifndef CONFIG_SPL_BUILD
> -int board_early_init_f(void)
> -{
> -	struct udevice *regulator;
> -	int ret;
> -
> -	ret = regulator_get_by_platname("vcc5v0_host", &regulator);
> -	if (ret) {
> -		debug("%s vcc5v0_host init fail! ret %d\n", __func__, ret);
> -		goto out;
> -	}
> -
> -	ret = regulator_set_enable(regulator, true);
> -	if (ret)
> -		debug("%s vcc5v0-host-en set fail! ret %d\n", __func__, ret);
> -out:
> -	return 0;
> -}
> -
> -#else
> +#ifdef CONFIG_SPL_BUILD
>   
>   #define PMUGRF_BASE	0xff320000
>   #define GPIO0_BASE	0xff720000
> diff --git a/board/pine64/pinebook-pro-rk3399/pinebook-pro-rk3399.c b/board/pine64/pinebook-pro-rk3399/pinebook-pro-rk3399.c
> index 5e758ea6cd92..0001022c62a6 100644
> --- a/board/pine64/pinebook-pro-rk3399/pinebook-pro-rk3399.c
> +++ b/board/pine64/pinebook-pro-rk3399/pinebook-pro-rk3399.c
> @@ -11,32 +11,10 @@
>   #include <asm/arch-rockchip/grf_rk3399.h>
>   #include <asm/arch-rockchip/hardware.h>
>   #include <linux/printk.h>
> -#include <power/regulator.h>
>   
>   #define GRF_IO_VSEL_BT565_SHIFT 0
>   #define PMUGRF_CON0_VSEL_SHIFT 8
>   
> -#ifndef CONFIG_SPL_BUILD
> -int board_early_init_f(void)
> -{
> -	struct udevice *regulator;
> -	int ret;
> -
> -	ret = regulator_get_by_platname("vcc5v0_usb", &regulator);
> -	if (ret) {
> -		pr_debug("%s vcc5v0_usb init fail! ret %d\n", __func__, ret);
> -		goto out;
> -	}
> -
> -	ret = regulator_set_enable(regulator, true);
> -	if (ret)
> -		pr_debug("%s vcc5v0-host-en-gpio set fail! ret %d\n", __func__, ret);
> -
> -out:
> -	return 0;
> -}
> -#endif
> -
>   #ifdef CONFIG_MISC_INIT_R
>   static void setup_iodomain(void)
>   {
> diff --git a/board/pine64/pinephone-pro-rk3399/pinephone-pro-rk3399.c b/board/pine64/pinephone-pro-rk3399/pinephone-pro-rk3399.c
> index c9b0d5a061d6..06dc512c57d8 100644
> --- a/board/pine64/pinephone-pro-rk3399/pinephone-pro-rk3399.c
> +++ b/board/pine64/pinephone-pro-rk3399/pinephone-pro-rk3399.c
> @@ -11,33 +11,11 @@
>   #include <asm/arch-rockchip/clock.h>
>   #include <asm/arch-rockchip/grf_rk3399.h>
>   #include <asm/arch-rockchip/hardware.h>
> -#include <power/regulator.h>
>   
>   #define GRF_IO_VSEL_BT565_GPIO2AB 1
>   #define GRF_IO_VSEL_AUDIO_GPIO3D4A 2
>   #define PMUGRF_CON0_VSEL_SHIFT 8
>   
> -#ifndef CONFIG_SPL_BUILD
> -int board_early_init_f(void)
> -{
> -	struct udevice *regulator;
> -	int ret;
> -
> -	ret = regulator_get_by_platname("vcc5v0_usb", &regulator);
> -	if (ret) {
> -		pr_debug("%s vcc5v0_usb init fail! ret %d\n", __func__, ret);
> -		goto out;
> -	}
> -
> -	ret = regulator_set_enable(regulator, true);
> -	if (ret)
> -		pr_debug("%s vcc5v0-host-en-gpio set fail! ret %d\n", __func__, ret);
> -
> -out:
> -	return 0;
> -}
> -#endif
> -
>   #ifdef CONFIG_MISC_INIT_R
>   static void setup_iodomain(void)
>   {
> diff --git a/board/rockchip/evb_rk3399/evb-rk3399.c b/board/rockchip/evb_rk3399/evb-rk3399.c
> index 3c773d0930cc..ebdd74a7b97f 100644
> --- a/board/rockchip/evb_rk3399/evb-rk3399.c
> +++ b/board/rockchip/evb_rk3399/evb-rk3399.c
> @@ -10,7 +10,6 @@
>   #include <log.h>
>   #include <asm/arch-rockchip/periph.h>
>   #include <linux/kernel.h>
> -#include <power/regulator.h>
>   
>   #define ROCKPI4_UPDATABLE_IMAGES	2
>   
> @@ -25,25 +24,6 @@ struct efi_capsule_update_info update_info = {
>   #endif
>   
>   #ifndef CONFIG_SPL_BUILD
> -int board_early_init_f(void)
> -{
> -	struct udevice *regulator;
> -	int ret;
> -
> -	ret = regulator_get_by_platname("vcc5v0_host", &regulator);
> -	if (ret) {
> -		debug("%s vcc5v0_host init fail! ret %d\n", __func__, ret);
> -		goto out;
> -	}
> -
> -	ret = regulator_set_enable(regulator, true);
> -	if (ret)
> -		debug("%s vcc5v0-host-en set fail! ret %d\n", __func__, ret);
> -
> -out:
> -	return 0;
> -}
> -
>   #if defined(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && defined(CONFIG_EFI_PARTITION)
>   static bool board_is_rockpi_4b(void)
>   {
