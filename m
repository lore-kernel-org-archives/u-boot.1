Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C950C54E4A
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 09:25:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C44E988072;
	Fri,  8 Mar 2024 10:25:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="dFHMvUmI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06FCC88055; Fri,  8 Mar 2024 10:25:53 +0100 (CET)
Received: from mail-m121142.qiye.163.com (mail-m121142.qiye.163.com
 [115.236.121.142])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B15DC87FE3
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 10:25:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=dFHMvUmIJI7CsuN3SjDtmEkgync8x54qmvsDAoLl5S4d9g+TOmyjoKLGt5yPzTfB9L8TKfCS4kk9LFU/FIW1kwJZTXXH7JnsGg7uDZlYCzgv4Aj7fh4Jt7i3QAxAmR/q4iOQJ9iOVdKODO54bwOnqugIpfPv3euI5dz2gE8tZkE=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=2TqRLFHfpJFefnQILnIiCwXFZoNbABXXiccSQNa1Sbo=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 87A0290032A;
 Fri,  8 Mar 2024 17:25:32 +0800 (CST)
Message-ID: <42c92843-9121-4724-a5f8-b3d1b25933bc@rock-chips.com>
Date: Fri, 8 Mar 2024 17:25:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] rockchip: board: Prepare for use of DM_USB_GADGET
 with DWC2_OTG
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
References: <20240226230822.2430391-1-jonas@kwiboo.se>
 <20240226230822.2430391-3-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240226230822.2430391-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUxITlZJHhhLQ0JLGUpNShhVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8e1d61ce2d03a9kunm87a0290032a
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PSI6KRw*NTMICj5RTjVOLzUw
 H05PCzBVSlVKTEtCQ0NCQkhISkNOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJQ0lNNwY+
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
> The board_usb_init() and board_usb_cleanup() functions is always
> included when USB_GADGET and USB_GADGET_DWC2_OTG is enabled.
>
> Prepare for a change to use DM_USB_GADGET with DWC2_OTG by adding an
> extra ifdef condition. The extra separate ifdef for USB_GADGET prepare
> for next patch that adds a g_dnl_bind_fixup() function.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/board.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
> index dea5805c4665..f84ff542aea9 100644
> --- a/arch/arm/mach-rockchip/board.c
> +++ b/arch/arm/mach-rockchip/board.c
> @@ -220,7 +220,8 @@ void enable_caches(void)
>   }
>   #endif
>   
> -#if defined(CONFIG_USB_GADGET) && defined(CONFIG_USB_GADGET_DWC2_OTG)
> +#if IS_ENABLED(CONFIG_USB_GADGET)
> +#if IS_ENABLED(CONFIG_USB_GADGET_DWC2_OTG) && !IS_ENABLED(CONFIG_DM_USB_GADGET)
>   #include <usb.h>
>   #include <linux/usb/otg.h>
>   #include <usb/dwc2_udc.h>
> @@ -296,6 +297,7 @@ int board_usb_cleanup(int index, enum usb_init_type init)
>   	return 0;
>   }
>   #endif /* CONFIG_USB_GADGET_DWC2_OTG */
> +#endif /* CONFIG_USB_GADGET */
>   
>   #if IS_ENABLED(CONFIG_FASTBOOT)
>   int fastboot_set_reboot_flag(enum fastboot_reboot_reason reason)
