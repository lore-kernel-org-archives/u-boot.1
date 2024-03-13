Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3FBEC54791
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 10:44:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A79787EAD;
	Wed, 13 Mar 2024 11:44:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="hEvjNu/k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A49F587EB7; Wed, 13 Mar 2024 11:44:05 +0100 (CET)
Received: from mail-m12740.qiye.163.com (mail-m12740.qiye.163.com
 [115.236.127.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 220F887EAD
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 11:44:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=hEvjNu/kqDfUMqr/nN/iubB82YMsdX/y+XPg/+PLyAVv1Xj9PcQIzwZDpZkb5xcj+vrG1Z8uNB0cqqj1sdWHVbZPWwntZ/9Fno/zimDDCIlyRF+t7GcQrZ4Svq2feux38z7wiksDfXDx7ge7iPlKsPBE8Odu2FTvF9t5ul1n4mk=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=3yJqiJSwx54XADO2ySqz3wsWpqY3gnySmkEfjyGjXsc=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 29B66900405;
 Wed, 13 Mar 2024 18:43:37 +0800 (CST)
Message-ID: <be77b8b1-3f6f-4b58-97e6-0325b14e787c@rock-chips.com>
Date: Wed, 13 Mar 2024 18:43:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] rockchip: Update the default USB Product ID value
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de
References: <20240310185106.665553-1-jonas@kwiboo.se>
 <20240310185106.665553-2-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240310185106.665553-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxlNQ1YeTU5ISUIaSh5CTB5VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8e376915e603a9kunm29b66900405
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kww6USo6CTMVHik9LxFRTBYO
 Oi9PCg1VSlVKTEpLSElNTUpMQ0NJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFISExJNwY+
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


On 2024/3/11 02:50, Jonas Karlman wrote:
> RK3036 is using the USB product id normally used by RK3066B, and RK3328
> is using the product id normally used by RK3368.
>
> Fix this and update the default USB_GADGET_PRODUCT_NUM Kconfig option
> for remaining supported Rockchip SoCs to match the product id used in
> Maskrom mode.
>
> Also remove a reference to an undefined ROCKCHIP_RK3229 Kconfig symbol.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2:
> - Update commit message
> ---
>   drivers/usb/gadget/Kconfig | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> index c72a8047635c..4621a6fd5e64 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -70,12 +70,21 @@ config USB_GADGET_PRODUCT_NUM
>   	hex "Product ID of the USB device"
>   	default 0x701a if ARCH_TEGRA
>   	default 0x1010 if ARCH_SUNXI
> -	default 0x310a if ROCKCHIP_RK3036
> +	default 0x110a if ROCKCHIP_RV1108
> +	default 0x110b if ROCKCHIP_RV1126
>   	default 0x300a if ROCKCHIP_RK3066
> +	default 0x301a if ROCKCHIP_RK3036
> +	default 0x310b if ROCKCHIP_RK3188
>   	default 0x310c if ROCKCHIP_RK3128
> -	default 0x320a if ROCKCHIP_RK3229 || ROCKCHIP_RK3288
> -	default 0x330a if ROCKCHIP_RK3328
> +	default 0x320a if ROCKCHIP_RK3288
> +	default 0x320b if ROCKCHIP_RK322X
> +	default 0x320c if ROCKCHIP_RK3328
> +	default 0x330a if ROCKCHIP_RK3368
>   	default 0x330c if ROCKCHIP_RK3399
> +	default 0x330d if ROCKCHIP_PX30
> +	default 0x330e if ROCKCHIP_RK3308
> +	default 0x350a if ROCKCHIP_RK3568
> +	default 0x350b if ROCKCHIP_RK3588
>   	default 0x0
>   	help
>   	  Product ID of the USB device emulated, reported to the host device.
