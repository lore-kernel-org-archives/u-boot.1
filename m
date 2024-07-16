Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A308C3DA4B
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 02:04:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3E568880B;
	Tue, 16 Jul 2024 04:04:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="MZ43vLSn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CE7887E15; Tue, 16 Jul 2024 04:04:52 +0200 (CEST)
Received: from mail-m127211.xmail.ntesmail.com
 (mail-m127211.xmail.ntesmail.com [115.236.127.211])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE3118888F
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 04:04:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=MZ43vLSnlM4PL9CGPK6J9RFOFnwbAusBaRgZYxxD+gPEtJhmgMZR0ZM9KAENLz+PVVkI0UitejHqMzv0+tDH6LqE22TZDlQvalVVHuIG+OeSynCWP/d5USaf8qDWbDLKUErBP/vSSsUJUMRxSs3r0dFEBr9sX9IA/f4yIevVJ/8=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=a/I8ZS+ig2rE/V7TzlfbgtInoCHtvDkKmjNygIUAft4=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id E97B49003B8;
 Tue, 16 Jul 2024 10:04:34 +0800 (CST)
Message-ID: <bfc3d708-0a4d-41ce-a9a7-fe2f435a88e2@rock-chips.com>
Date: Tue, 16 Jul 2024 10:04:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 1/4] rockchip: ringneck-px30: disable broken USB
 gadget
To: Quentin Schulz <foss+uboot@0leil.net>, Klaus Goger
 <klaus.goger@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 =?UTF-8?B?546L5piO5oiQ?= <frank.wang@rock-chips.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20240614-ringneck-no-gadget-v1-0-d3bc6e5088de@cherry.de>
 <20240614-ringneck-no-gadget-v1-1-d3bc6e5088de@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240614-ringneck-no-gadget-v1-1-d3bc6e5088de@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ04dQlZIQ0lJSh1CQk4aTx5WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a90b948d0c603a9kunme97b49003b8
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MCI6Qhw5PzI*Mhg#Ck9ILhw2
 DypPCwxVSlVKTElKS0JOT0xOQklLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPSklONwY+
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

Hi Quentin,

On 2024/6/14 19:04, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> USB gadget simply doesn't work right now on PX30. Tested on PX30 EVB and
> PX30 Ringneck with Linux mainline and Rockchip 5.10 Linux as well as
> U-Boot.
Do you mean for both U-Boot and kernel, including mainline version and 
rockchip version,
and on both PX30 EVB and Ringneck board, all SW&HW have no USB gadget 
working?
So when you test this, does the maskrom mode works? because it sounds 
like maybe
the HOST PC is the one have issue at the moment.


Thanks,

  - Kever

>
> We don't want to our users to assume that USB gadget is supported on Q7
> USB P1 on Ringneck Haikou, so let's remove its support, which also
> removes the ums CLI command, fastboot and Android image booting
> support.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>   configs/ringneck-px30_defconfig | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/configs/ringneck-px30_defconfig b/configs/ringneck-px30_defconfig
> index 23204794205..2ec5f72e47a 100644
> --- a/configs/ringneck-px30_defconfig
> +++ b/configs/ringneck-px30_defconfig
> @@ -15,7 +15,6 @@ CONFIG_DEBUG_UART_BASE=0xFF030000
>   CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_SYS_LOAD_ADDR=0x800800
>   CONFIG_DEBUG_UART=y
> -# CONFIG_ANDROID_BOOT_IMAGE is not set
>   CONFIG_FIT=y
>   CONFIG_FIT_VERBOSE=y
>   CONFIG_SPL_LOAD_FIT=y
> @@ -42,6 +41,7 @@ CONFIG_SPL_ATF=y
>   # CONFIG_CMD_ELF is not set
>   # CONFIG_CMD_LZMADEC is not set
>   # CONFIG_CMD_UNZIP is not set
> +CONFIG_CMD_BIND=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
>   CONFIG_CMD_I2C=y
> @@ -49,7 +49,6 @@ CONFIG_CMD_I2C=y
>   # CONFIG_CMD_LOADS is not set
>   CONFIG_CMD_MMC=y
>   CONFIG_CMD_USB=y
> -CONFIG_CMD_USB_MASS_STORAGE=y
>   # CONFIG_CMD_SETEXPR is not set
>   CONFIG_CMD_PMIC=y
>   CONFIG_CMD_REGULATOR=y
> @@ -73,8 +72,6 @@ CONFIG_BUTTON=y
>   CONFIG_BUTTON_GPIO=y
>   CONFIG_CLK=y
>   CONFIG_SPL_CLK=y
> -CONFIG_FASTBOOT_BUF_ADDR=0x800800
> -CONFIG_FASTBOOT_BUF_SIZE=0x04000000
>   CONFIG_GPIO_HOG=y
>   CONFIG_SPL_GPIO_HOG=y
>   CONFIG_ROCKCHIP_GPIO=y
> @@ -112,8 +109,6 @@ CONFIG_DM_THERMAL=y
>   CONFIG_USB=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
> -CONFIG_USB_GADGET=y
> -CONFIG_USB_GADGET_DWC2_OTG=y
>   CONFIG_SPL_TINY_MEMSET=y
>   CONFIG_TPL_TINY_MEMSET=y
>   CONFIG_LZO=y
>
