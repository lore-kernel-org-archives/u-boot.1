Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF7BBC4345F
	for <u-boot@archiver.kernel.org>; Sat, 13 Apr 2024 08:21:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFC7287D64;
	Sat, 13 Apr 2024 10:21:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="IcOJzVRQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9524B87E62; Sat, 13 Apr 2024 10:21:26 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DF9C87C82
 for <u-boot@lists.denx.de>; Sat, 13 Apr 2024 10:21:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=66ce=LS=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1712996470;
 bh=xXGvTSdIkMgsKAD8WP2LeZbYET+dgATqYub/n4gwWEs=;
 b=IcOJzVRQcejTsjwp4zS2fkCTAkH/epX0SwibhOQY+SjEHUXSx19q1sHM5XjfRJDQxAE268LQQ
 bw3WvToterU37A+MDX/RhYpTF8dWC5YAYmhSlRXyKq7V7vGZMaPyRpeOkaEPw0K6W0BZpc/NPHh
 mIT5SVV/SChY1gWl2JyEDbtkJpyOkGVuz6608gNKF+uJUQyeVXCOGN350x5RaL4KAS1fYUWmmGn
 EzZFCkhg00qza+lWfCwkUZ7RP/28eJSiHu7oJBDCau1WedYmmLOJvIVOc9UNCPYTY/6FLdhqTK6
 LuqDMYYPD2ioInk9G8SwpBj+/VMsoLwYks6bJSpS70Gg==
Message-ID: <36387180-d978-4cee-827b-c496672c40ab@kwiboo.se>
Date: Sat, 13 Apr 2024 10:21:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: turing-rk1: disable SPI flash by default
To: Sam Edwards <cfsworks@gmail.com>, Joshua Riek <jjriek@verizon.net>, Tom
 Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>
Cc: Eugen Hristev <eugen.hristev@collabora.com>, Christopher Obbard
 <chris.obbard@collabora.com>, u-boot@lists.denx.de, Florian Klink
 <flokli@flokli.de>
References: <20240413072536.582731-1-CFSworks@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240413072536.582731-1-CFSworks@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 661a40741775dbb2d9478c7a
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

Hi Sam,

On 2024-04-13 09:25, Sam Edwards wrote:
> While the Turing RK1 board has a pad on the PCB for SPI flash, it is
> not populated at the factory: supporting SPI flash boot is a user
> modification, not an out-of-the-box feature. The defconfig for this
> board should therefore not be enabling the SPI flash image nor SPI
> support in the SPL, as it causes confusion among downstream users as to
> whether the SPI image needs to be distributed.
> 
> Fixes: 153ac950a599 ("board: rockchip: Add the Turing RK1 SoM")
> Suggested-by: Florian Klink <flokli@flokli.de>
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> Acked-by: Joshua Riek <jjriek@verizon.net>
> ---
>  configs/turing-rk1-rk3588_defconfig | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/configs/turing-rk1-rk3588_defconfig b/configs/turing-rk1-rk3588_defconfig
> index 07f7b84852..28c3e50ed4 100644
> --- a/configs/turing-rk1-rk3588_defconfig
> +++ b/configs/turing-rk1-rk3588_defconfig
> @@ -8,13 +8,10 @@ CONFIG_SF_DEFAULT_SPEED=24000000
>  CONFIG_SF_DEFAULT_MODE=0x2000
>  CONFIG_DEFAULT_DEVICE_TREE="rk3588-turing-rk1"
>  CONFIG_ROCKCHIP_RK3588=y
> -CONFIG_ROCKCHIP_SPI_IMAGE=y

The device tree synced from linux does not even enable the sfc node, so
please either remove all related config options for spi flash or only
remove the ROCKCHIP_SPI_IMAGE option if the sfc and a flash node will
be enabled/added to upstream linux devicetree.

Additional options related to spi flash not removed in this patch:
- SF_DEFAULT_SPEED
- SF_DEFAULT_MODE
- SF_DEFAULT_BUS
- SPI_FLASH_SFDP_SUPPORT
- SPI_FLASH_MACRONIX
- SPI_FLASH_XMC
- SPI_FLASH_XTX
- ROCKCHIP_SFC

>  CONFIG_SPL_SERIAL=y
>  CONFIG_TARGET_TURINGRK1_RK3588=y
>  CONFIG_DEBUG_UART_BASE=0xFEBC0000
>  CONFIG_DEBUG_UART_CLOCK=24000000
> -CONFIG_SPL_SPI_FLASH_SUPPORT=y
> -CONFIG_SPL_SPI=y
>  CONFIG_SYS_LOAD_ADDR=0xc00800
>  CONFIG_PCI=y
>  CONFIG_DEBUG_UART=y
> @@ -31,8 +28,6 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
>  CONFIG_SPL_MAX_SIZE=0x40000
>  CONFIG_SPL_PAD_TO=0x7f8000
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> -CONFIG_SPL_SPI_LOAD=y
> -CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
>  CONFIG_SPL_ATF=y
>  CONFIG_CMD_GPIO=y
>  CONFIG_CMD_GPT=y
> @@ -109,7 +104,6 @@ CONFIG_USB_ETHER_MCS7830=y
>  CONFIG_USB_ETHER_RTL8152=y
>  CONFIG_USB_ETHER_SMSC95XX=y
>  CONFIG_USB_GADGET=y
> -CONFIG_USB_GADGET_PRODUCT_NUM=0x350b

This is an unrelated change that may cause apply issues if "rockchip:
rk35xx: DropUSB_GADGET_PRODUCT_NUM Kconfig option" [1] or is Tom make a
sync defconfigs commit that is applied before this patch.

[1] https://patchwork.ozlabs.org/patch/1917934/

With above fixed,

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

Regards,
Jonas

>  CONFIG_USB_GADGET_DOWNLOAD=y
>  CONFIG_USB_FUNCTION_ROCKUSB=y
>  CONFIG_ERRNO_STR=y

