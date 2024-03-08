Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D9FC5475B
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 09:23:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCC6687ECA;
	Fri,  8 Mar 2024 10:23:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="McFl9U70";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB42E87FCC; Fri,  8 Mar 2024 10:23:10 +0100 (CET)
Received: from mail-m15599.qiye.163.com (mail-m15599.qiye.163.com
 [101.71.155.99])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B4CB87E87
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 10:23:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=McFl9U706R9Ov/k6LJghy8PVvHdoyHA3Ji6eeOF3uVZFrrC7ZbvvmfA3nNVVlxZl4yn7HpBimbtRE9YL7U/YxYQO718xDP6piv4mZEswh+FX/rQXqNhrwxrmM2pJn8i15O+Tx1g3XL9XPwdRC/kmMyac/D26tdNXBXchFQTXyT4=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=gEC1GgSI02jcgydYXKGBT+nQNzk0UXwZwgAquHXWXkA=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id E00A690032A;
 Fri,  8 Mar 2024 17:22:57 +0800 (CST)
Message-ID: <f1f0abb8-7786-4c56-8e55-772a59bbab82@rock-chips.com>
Date: Fri, 8 Mar 2024 17:22:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] rockchip: Update the default USB Product ID value
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de
References: <20240226230822.2430391-1-jonas@kwiboo.se>
 <20240226230822.2430391-2-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240226230822.2430391-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0NISlYZQx1MSBhIGR0dSx5VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8e1d5f728b03a9kunme00a690032a
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ngw6TSo6FzMOAj5PMEM*Dz4o
 TRowCy5VSlVKTEtCQ0NCTExDTU9NVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFITUhDNwY+
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

Hi Jonas,

     Thanks for your patch.

On 2024/2/27 07:08, Jonas Karlman wrote:
> RK3036 is using the USB product id normally used by RK3066B, and RK3328
> is using the product id normally used by RK3368.
>
> Fix this and update the default USB_GADGET_PRODUCT_NUM Kconfig option
> for remaining supported Rockchip SoCs to match the product id used in
> Mask ROM mode. Also remove a reference to the unknown ROCKCHIP_RK3229
> symbol.

RK3229 belongs to RK322X which is reuse with RK3228.

Note that this ID is used for rockusb gadget, if work as mass storage, 
it should use other

ID, or else it will confuse the driver in host side, eg. the Windows 
driver may not able to

recognize the device if using two different gadget type with the same ID.


Thanks,
- Kever
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
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
