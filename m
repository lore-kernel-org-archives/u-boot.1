Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2852ED0C603
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 12:31:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A31B88FEC;
	Fri, 25 Oct 2024 14:31:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="VWgfnhLw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49ECA88FEC; Fri, 25 Oct 2024 14:31:36 +0200 (CEST)
Received: from mail-m127214.xmail.ntesmail.com
 (mail-m127214.xmail.ntesmail.com [115.236.127.214])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D41888FFD
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 14:31:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id ec47271;
 Fri, 25 Oct 2024 20:31:18 +0800 (GMT+08:00)
Message-ID: <f13b4566-250c-4b4e-88ad-78e942518db1@rock-chips.com>
Date: Fri, 25 Oct 2024 20:31:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: Migrate to use USB_DWC3_GENERIC on RK3328
To: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 Tianling Shen <cnsztl@gmail.com>, David Bauer <mail@david-bauer.net>
Cc: u-boot@lists.denx.de
References: <20241008192719.2192430-1-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241008192719.2192430-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0xMS1ZOSUtPSENNHU9CGUtWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a92c3a8e52009d6kunmec47271
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MBw6DTo5AjIiHxciKAkVEB41
 GU8KCTZVSlVKTElCQ05CT0xCTUtKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOSk9DNwY+
DKIM-Signature: a=rsa-sha256;
 b=VWgfnhLwzitjBKRqcnxQoq94x3T8L4kNodV97Fu0+g3sgd189/sHczUuH4UG9+EKfce2HOzaenhfZMgSIRctIf/xx3yq25lPK9irc2igogAzOLMYSzEIJ0CtTzx2JWkfQvEvgQw/Gm1+2tLbLOgHJs2qghB2X8SoLoWsgC1l8/U=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=XWTfbWtnHqIR6e9xy8MkDV3aknEPE1z0JXALWuCaTZU=;
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


On 2024/10/9 03:27, Jonas Karlman wrote:
> After the full convertion of usb gadget interrupt handling to
> usb_gadget_generic_ops, it is now possible to use DM_USB_GADGET,
> DWC2_OTG and DWC3_GENERIC together without causing a build error.
>
> Change to use USB_DWC3_GENERIC instead of USB_XHCI_DWC3 to complte the
> migration initiated in commit 1bc4e8eb1d7f ("rockchip: Migrate to use
> DM_USB_GADGET on RK3328"). No functional change is intended.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> This has been tested on a Orange Pi R1 Plus LTS and a NanoPi R2S Plus.
> ---
>   configs/evb-rk3328_defconfig                  | 3 +--
>   configs/nanopi-r2c-plus-rk3328_defconfig      | 3 +--
>   configs/nanopi-r2c-rk3328_defconfig           | 3 +--
>   configs/nanopi-r2s-rk3328_defconfig           | 3 +--
>   configs/orangepi-r1-plus-lts-rk3328_defconfig | 3 +--
>   configs/orangepi-r1-plus-rk3328_defconfig     | 3 +--
>   6 files changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/configs/evb-rk3328_defconfig b/configs/evb-rk3328_defconfig
> index bfb85223437d..b3790c4d4ae2 100644
> --- a/configs/evb-rk3328_defconfig
> +++ b/configs/evb-rk3328_defconfig
> @@ -88,13 +88,12 @@ CONFIG_SYSRESET=y
>   CONFIG_USB=y
>   CONFIG_DM_USB_GADGET=y
>   CONFIG_USB_XHCI_HCD=y
> -CONFIG_USB_XHCI_DWC3=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
>   CONFIG_USB_OHCI_HCD=y
>   CONFIG_USB_OHCI_GENERIC=y
>   CONFIG_USB_DWC3=y
> -# CONFIG_USB_DWC3_GADGET is not set
> +CONFIG_USB_DWC3_GENERIC=y
>   CONFIG_USB_GADGET=y
>   CONFIG_USB_GADGET_DWC2_OTG=y
>   CONFIG_USB_FUNCTION_ROCKUSB=y
> diff --git a/configs/nanopi-r2c-plus-rk3328_defconfig b/configs/nanopi-r2c-plus-rk3328_defconfig
> index f311a0a80ba7..19fab59eff01 100644
> --- a/configs/nanopi-r2c-plus-rk3328_defconfig
> +++ b/configs/nanopi-r2c-plus-rk3328_defconfig
> @@ -94,13 +94,12 @@ CONFIG_SYSRESET=y
>   CONFIG_USB=y
>   CONFIG_DM_USB_GADGET=y
>   CONFIG_USB_XHCI_HCD=y
> -CONFIG_USB_XHCI_DWC3=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
>   CONFIG_USB_OHCI_HCD=y
>   CONFIG_USB_OHCI_GENERIC=y
>   CONFIG_USB_DWC3=y
> -# CONFIG_USB_DWC3_GADGET is not set
> +CONFIG_USB_DWC3_GENERIC=y
>   CONFIG_USB_GADGET=y
>   CONFIG_USB_GADGET_DWC2_OTG=y
>   CONFIG_USB_FUNCTION_ROCKUSB=y
> diff --git a/configs/nanopi-r2c-rk3328_defconfig b/configs/nanopi-r2c-rk3328_defconfig
> index 533dc1029f73..65ffdd34d4d1 100644
> --- a/configs/nanopi-r2c-rk3328_defconfig
> +++ b/configs/nanopi-r2c-rk3328_defconfig
> @@ -94,13 +94,12 @@ CONFIG_SYSRESET=y
>   CONFIG_USB=y
>   CONFIG_DM_USB_GADGET=y
>   CONFIG_USB_XHCI_HCD=y
> -CONFIG_USB_XHCI_DWC3=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
>   CONFIG_USB_OHCI_HCD=y
>   CONFIG_USB_OHCI_GENERIC=y
>   CONFIG_USB_DWC3=y
> -# CONFIG_USB_DWC3_GADGET is not set
> +CONFIG_USB_DWC3_GENERIC=y
>   CONFIG_USB_GADGET=y
>   CONFIG_USB_GADGET_DWC2_OTG=y
>   CONFIG_USB_FUNCTION_ROCKUSB=y
> diff --git a/configs/nanopi-r2s-rk3328_defconfig b/configs/nanopi-r2s-rk3328_defconfig
> index 2591a9cc8ab2..751da1c446d8 100644
> --- a/configs/nanopi-r2s-rk3328_defconfig
> +++ b/configs/nanopi-r2s-rk3328_defconfig
> @@ -94,13 +94,12 @@ CONFIG_SYSRESET=y
>   CONFIG_USB=y
>   CONFIG_DM_USB_GADGET=y
>   CONFIG_USB_XHCI_HCD=y
> -CONFIG_USB_XHCI_DWC3=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
>   CONFIG_USB_OHCI_HCD=y
>   CONFIG_USB_OHCI_GENERIC=y
>   CONFIG_USB_DWC3=y
> -# CONFIG_USB_DWC3_GADGET is not set
> +CONFIG_USB_DWC3_GENERIC=y
>   CONFIG_USB_GADGET=y
>   CONFIG_USB_GADGET_DWC2_OTG=y
>   CONFIG_USB_FUNCTION_ROCKUSB=y
> diff --git a/configs/orangepi-r1-plus-lts-rk3328_defconfig b/configs/orangepi-r1-plus-lts-rk3328_defconfig
> index 14cdbd813c81..7786a3514b4d 100644
> --- a/configs/orangepi-r1-plus-lts-rk3328_defconfig
> +++ b/configs/orangepi-r1-plus-lts-rk3328_defconfig
> @@ -104,13 +104,12 @@ CONFIG_SYSRESET=y
>   CONFIG_USB=y
>   CONFIG_DM_USB_GADGET=y
>   CONFIG_USB_XHCI_HCD=y
> -CONFIG_USB_XHCI_DWC3=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
>   CONFIG_USB_OHCI_HCD=y
>   CONFIG_USB_OHCI_GENERIC=y
>   CONFIG_USB_DWC3=y
> -# CONFIG_USB_DWC3_GADGET is not set
> +CONFIG_USB_DWC3_GENERIC=y
>   CONFIG_USB_GADGET=y
>   CONFIG_USB_GADGET_DWC2_OTG=y
>   CONFIG_USB_FUNCTION_ROCKUSB=y
> diff --git a/configs/orangepi-r1-plus-rk3328_defconfig b/configs/orangepi-r1-plus-rk3328_defconfig
> index 7fe58e7a1467..e2b9ce705ecb 100644
> --- a/configs/orangepi-r1-plus-rk3328_defconfig
> +++ b/configs/orangepi-r1-plus-rk3328_defconfig
> @@ -104,13 +104,12 @@ CONFIG_SYSRESET=y
>   CONFIG_USB=y
>   CONFIG_DM_USB_GADGET=y
>   CONFIG_USB_XHCI_HCD=y
> -CONFIG_USB_XHCI_DWC3=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
>   CONFIG_USB_OHCI_HCD=y
>   CONFIG_USB_OHCI_GENERIC=y
>   CONFIG_USB_DWC3=y
> -# CONFIG_USB_DWC3_GADGET is not set
> +CONFIG_USB_DWC3_GENERIC=y
>   CONFIG_USB_GADGET=y
>   CONFIG_USB_GADGET_DWC2_OTG=y
>   CONFIG_USB_FUNCTION_ROCKUSB=y
