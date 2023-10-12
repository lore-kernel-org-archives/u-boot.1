Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB29CDB465
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 02:37:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EBBC86D62;
	Thu, 12 Oct 2023 04:18:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="KussoY1S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D632C85DE0; Thu, 12 Oct 2023 04:18:06 +0200 (CEST)
Received: from mail-m11883.qiye.163.com (mail-m11883.qiye.163.com
 [115.236.118.83])
 by phobos.denx.de (Postfix) with ESMTP id 26AB886D21
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 04:18:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=KussoY1SuPlgKQ4dS8BiyMLz52biEZlsaaC7R3KC+IZ9obVZBIQOXLplq6r+/1Mq5e/w/x/q/nlzkCWoeWX/mxZ+UXOpS0MbkAzS4FGF2s89vTXJtVNCR8eTc+wsFcVxmru65pHU8FliICxnhjh8eorfSEJPfqDOe5luljyphfA=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=82myH9gwQiFVG5ilpXicvnxyD0JQHATGcITO4xU31gg=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id CD5B24001E6;
 Thu, 12 Oct 2023 10:16:53 +0800 (CST)
Message-ID: <204c54a9-a23c-bac9-5d30-278d44571650@rock-chips.com>
Date: Thu, 12 Oct 2023 10:16:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/4] rockchip: rk3588-rock-5b: Enable support for PCIe
 SATA cards
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Eugen Hristev <eugen.hristev@collabora.com>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Christopher Obbard <chris.obbard@collabora.com>
References: <20231010222344.3436526-1-jonas@kwiboo.se>
 <20231010222344.3436526-3-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20231010222344.3436526-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxkdQlYZTBhDHhoZGklITRhVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8b21ac2f0a2eb3kusncd5b24001e6
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OU06Mio6KjwrFBRDEz8tKxVK
 CgwwCwtVSlVKTUJMS0xMS0pPQ01CVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFIT0JDNwY+
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


On 2023/10/11 06:23, Jonas Karlman wrote:
> Enable support for PCIe SATA cards and the on-board SATA controller.
>
> This also revert use of CONFIG_PCI_INIT_R in order to speed up boot from
> eMMC or SD-cards. Standard boot will initialize pci after faster boot
> media have been enumerated.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> Cc: Christopher Obbard <chris.obbard@collabora.com>
> ---
>   configs/rock5b-rk3588_defconfig | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
> index 447913faccc4..ec22e70033a0 100644
> --- a/configs/rock5b-rk3588_defconfig
> +++ b/configs/rock5b-rk3588_defconfig
> @@ -26,6 +26,7 @@ CONFIG_SPL_SPI=y
>   CONFIG_SYS_LOAD_ADDR=0xc00800
>   CONFIG_PCI=y
>   CONFIG_DEBUG_UART=y
> +CONFIG_AHCI=y
>   CONFIG_FIT=y
>   CONFIG_FIT_VERBOSE=y
>   CONFIG_SPL_FIT_SIGNATURE=y
> @@ -35,7 +36,6 @@ CONFIG_OF_BOARD_SETUP=y
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-rock-5b.dtb"
>   # CONFIG_DISPLAY_CPUINFO is not set
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
> -CONFIG_PCI_INIT_R=y
>   CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_PAD_TO=0x7f8000
>   CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> @@ -63,6 +63,8 @@ CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigne
>   CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_SPL_REGMAP=y
>   CONFIG_SPL_SYSCON=y
> +CONFIG_AHCI_PCI=y
> +CONFIG_DWC_AHCI=y
>   CONFIG_SPL_CLK=y
>   # CONFIG_USB_FUNCTION_FASTBOOT is not set
>   CONFIG_ROCKCHIP_GPIO=y
> @@ -89,6 +91,8 @@ CONFIG_SPL_PINCTRL=y
>   CONFIG_REGULATOR_PWM=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_SPL_RAM=y
> +CONFIG_SCSI=y
> +CONFIG_DM_SCSI=y
>   CONFIG_BAUDRATE=1500000
>   CONFIG_DEBUG_UART_SHIFT=2
>   CONFIG_SYS_NS16550_MEM32=y
