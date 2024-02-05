Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96449C4828D
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 06:59:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AE128775F;
	Mon,  5 Feb 2024 07:59:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="QxfF46JV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD9508777D; Mon,  5 Feb 2024 07:59:41 +0100 (CET)
Received: from mail-m12786.qiye.163.com (mail-m12786.qiye.163.com
 [115.236.127.86])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E356B875E9
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 07:59:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=QxfF46JVWqejsM2DRy4v/otrdS7iELUCrKXnCyDRaN7SoEa15iLKR74qY8yEomgRKwVLIc7yHNSNsFj56zHPCpjkN4XnPMn8rg2Cq+bc+3OpOKAUA/l8mVqSyVfqU82zA7KBKjWeO1syi0obRnJ6pHwCsWbcciPe9VGeCrekBH8=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=86kx6H8kA6ZvQ18ru72gOyrpcBUH/jHXCcp1FaHAl9o=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 92CEB9001A7;
 Mon,  5 Feb 2024 14:59:35 +0800 (CST)
Message-ID: <e65efc29-5cf9-42fc-a9cb-4a51c8231449@rock-chips.com>
Date: Mon, 5 Feb 2024 14:59:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3588-evb: Enable USB support
Content-Language: en-US
To: Andy Yan <andyshrk@163.com>
Cc: jonas@kwiboo.se, u-boot@lists.denx.de, Andy Yan <andy.yan@rock-chips.com>
References: <20240203113107.1945139-1-andyshrk@163.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240203113107.1945139-1-andyshrk@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhgYQ1ZDShlLGh4fQ08fQhlVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d7810af1303a9kunm92ceb9001a7
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ojo6Kxw6ETMKNTwvHFEhExAT
 Lk8wFAJVSlVKTEtMSkpNSExNSkhOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTklONwY+
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


On 2024/2/3 19:31, Andy Yan wrote:
> From: Andy Yan <andy.yan@rock-chips.com>
>
> Enable USB releated config to support
> boot from usb.
>
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/evb-rk3588_defconfig | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/configs/evb-rk3588_defconfig b/configs/evb-rk3588_defconfig
> index 0b7b4f2f627..8a6aa91cb29 100644
> --- a/configs/evb-rk3588_defconfig
> +++ b/configs/evb-rk3588_defconfig
> @@ -40,6 +40,7 @@ CONFIG_SPL_ATF=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
>   CONFIG_CMD_MMC=y
> +CONFIG_CMD_USB=y
>   # CONFIG_CMD_SETEXPR is not set
>   CONFIG_CMD_REGULATOR=y
>   # CONFIG_SPL_DOS_PARTITION is not set
> @@ -61,6 +62,9 @@ CONFIG_MMC_SDHCI_ROCKCHIP=y
>   CONFIG_PHY_REALTEK=y
>   CONFIG_DWC_ETH_QOS=y
>   CONFIG_DWC_ETH_QOS_ROCKCHIP=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> +CONFIG_PHY_ROCKCHIP_USBDP=y
>   CONFIG_REGULATOR_PWM=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_SPL_RAM=y
> @@ -68,4 +72,12 @@ CONFIG_BAUDRATE=1500000
>   CONFIG_DEBUG_UART_SHIFT=2
>   CONFIG_SYS_NS16550_MEM32=y
>   CONFIG_SYSRESET=y
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_USB_OHCI_HCD=y
> +CONFIG_USB_OHCI_GENERIC=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
>   CONFIG_ERRNO_STR=y
