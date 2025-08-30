Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D62BCA0EFF
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 14:43:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B6968380E;
	Sat, 30 Aug 2025 16:43:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="bkE5W6R+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1018836B2; Sat, 30 Aug 2025 16:43:42 +0200 (CEST)
Received: from mail-m158242.netease.com (mail-m158242.netease.com
 [47.251.158.242])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 093FE8384E
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 16:43:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [121.204.19.91])
 by smtp.qiye.163.com (Hmail) with ESMTP id 212398736;
 Sat, 30 Aug 2025 22:43:33 +0800 (GMT+08:00)
Message-ID: <e76b441e-ece0-4f61-bd55-3775a734ada5@rock-chips.com>
Date: Sat, 30 Aug 2025 22:43:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] rockchip: Add default USB_GADGET_PRODUCT_NUM for
 RK3576
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de
References: <20250711222132.204344-1-jonas@kwiboo.se>
 <20250711222132.204344-4-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250711222132.204344-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a98fb6f032f03afkunm8351785f409778
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDHRlKVh0fSk9KSkIaSE8dSFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpCVUJKWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=bkE5W6R+3SfTdTs5NPIXj1++NTRlnLlCKi3XuvD6vKtxJSNtu19+EHEtIHZdaPmdmrCDISk4XkSwWMc93Z5dvh1ZPTmoMh+szCgJLRsQ7iOSHosAE8y6JIronHumphkRytMYDyTqJygIfaYFx1GEPhRe2llBa4oNIqex3BYcUDY=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=x/OebE5lEgexrc5Db6lR1TgnsX+ygYovAD1jJcr9NSg=;
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


On 2025/7/12 06:21, Jonas Karlman wrote:
> Use 0x350e as the default USB Product ID for Rockchip RK3576, same PID
> being used by the BootROM when the device is in MASKROM mode.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: New patch
> ---
>   drivers/usb/gadget/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> index 46a83141481f..bab88567ea62 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -86,6 +86,7 @@ config USB_GADGET_PRODUCT_NUM
>   	default 0x350a if ROCKCHIP_RK3568
>   	default 0x350b if ROCKCHIP_RK3588
>   	default 0x350c if ROCKCHIP_RK3528
> +	default 0x350e if ROCKCHIP_RK3576
>   	default 0x0
>   	help
>   	  Product ID of the USB device emulated, reported to the host device.
