Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 491C5C5475B
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 09:26:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9122C8807E;
	Fri,  8 Mar 2024 10:26:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="MgnaAdG7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C2D588092; Fri,  8 Mar 2024 10:26:01 +0100 (CET)
Received: from mail-m127163.xmail.ntesmail.com
 (mail-m127163.xmail.ntesmail.com [115.236.127.163])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E1E888079
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 10:25:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=MgnaAdG7M0gHauhftZgjzNK5prXDxIaQ5mYUtHOZFC+oz/7e1lWdOO7kO2p2T78Uzd0f0NajOw0PG6OBYoRdjBFy0IkAMdGwR+mU+WU7+XXzqxkt2joch6/8vct5iJaZy0+cH+OgejkYM3KZq9F0Di1hMABdmeLqKk8nnTl0ZrY=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=IK8e3Jmcet8B2CrfythfHfYdEYiJHnsDSDED8v1YxKo=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id DDB2D900206;
 Fri,  8 Mar 2024 17:25:45 +0800 (CST)
Message-ID: <1d9a6c48-0ec4-4457-9284-9d338f80657c@rock-chips.com>
Date: Fri, 8 Mar 2024 17:25:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] rockchip: board: Use a common USB Product ID for UMS
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
References: <20240226230822.2430391-1-jonas@kwiboo.se>
 <20240226230822.2430391-4-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240226230822.2430391-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkJKQlYfTBlPTh1OGB5OQ0NVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8e1d62031a03a9kunmddb2d900206
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OSI6CBw6EjMTAj40CTZCLzBO
 LDcwCilVSlVKTEtCQ0NCQk9NTE5PVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJQ01JNwY+
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


On 2024/2/27 07:08, Jonas Karlman wrote:
> Change to use the common Product ID 0x0010 when the ums command is used.
>
> This matches downstream vendor U-Boot and is a Product ID that tools
> such as rkdeveloptool and RKDevTool will identify as MSC mode.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/board.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
> index f84ff542aea9..e9cfba756639 100644
> --- a/arch/arm/mach-rockchip/board.c
> +++ b/arch/arm/mach-rockchip/board.c
> @@ -221,8 +221,23 @@ void enable_caches(void)
>   #endif
>   
>   #if IS_ENABLED(CONFIG_USB_GADGET)
> -#if IS_ENABLED(CONFIG_USB_GADGET_DWC2_OTG) && !IS_ENABLED(CONFIG_DM_USB_GADGET)
>   #include <usb.h>
> +
> +#if IS_ENABLED(CONFIG_USB_GADGET_DOWNLOAD)
> +#define ROCKCHIP_G_DNL_UMS_PRODUCT_NUM	0x0010
> +
> +int g_dnl_bind_fixup(struct usb_device_descriptor *dev, const char *name)
> +{
> +	if (!strcmp(name, "usb_dnl_ums"))
> +		put_unaligned(ROCKCHIP_G_DNL_UMS_PRODUCT_NUM, &dev->idProduct);
> +	else
> +		put_unaligned(CONFIG_USB_GADGET_PRODUCT_NUM, &dev->idProduct);
> +
> +	return 0;
> +}
> +#endif /* CONFIG_USB_GADGET_DOWNLOAD */
> +
> +#if IS_ENABLED(CONFIG_USB_GADGET_DWC2_OTG) && !IS_ENABLED(CONFIG_DM_USB_GADGET)
>   #include <linux/usb/otg.h>
>   #include <usb/dwc2_udc.h>
>   
