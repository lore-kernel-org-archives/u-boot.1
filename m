Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9F8C54E5D
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 03:30:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAE9F876E4;
	Thu, 14 Mar 2024 04:30:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Y1KbsCNU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30787870D2; Thu, 14 Mar 2024 04:30:54 +0100 (CET)
Received: from mail-m121149.qiye.163.com (mail-m121149.qiye.163.com
 [115.236.121.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EA7D87F71
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 04:30:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Y1KbsCNUkuxa7no0cx06WzSn5FaAwfg+Y6essrclC3+f/73pbJ2OFMHsFPmMfGiQnP7z+5ztk0KZNrSkzdKBG1KoThlMA+BwJRVX3R9H/Hz+QG2JHm99aILxGVpFPNqG1EhNkjU2ax0+6Wir84ZLjWnl2DhDlcQBjlehp8ZulJk=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=0kRTmW3VQbTIKXtcuhc7BAV+a+mOoVT6jSXp5Of33W4=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 996EC9001EC;
 Thu, 14 Mar 2024 11:30:24 +0800 (CST)
Message-ID: <8b58a960-1a5a-41c5-8507-500067697bb2@rock-chips.com>
Date: Thu, 14 Mar 2024 11:30:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/15] gpio: rockchip: Use gpio alias id as gpio bank id
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Dragan Simic <dsimic@manjaro.org>, Tianling Shen <cnsztl@gmail.com>,
 u-boot@lists.denx.de
References: <20240217002304.2141064-1-jonas@kwiboo.se>
 <20240217002304.2141064-10-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240217002304.2141064-10-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0pDQlZMGR9KHkweSk5NSh9VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8e3b02d45f03a9kunm996ec9001ec
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OjY6Lyo*EzMVNCgeQjQTEjQu
 MBQwFChVSlVKTEpLSENMS0lOSENPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFIS09MNwY+
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


On 2024/2/17 08:22, Jonas Karlman wrote:
> The U-Boot driver try to base the gpio bank id on the gpio-ranges prop
> and fall back to base the bank id on the node name. However, the linux
> driver try to base the bank id on the gpio alias id and fall back on
> node order.
>
> This can cause issues when SoC DT is synced from linux and gpioX@ nodes
> has been renamed to gpio@ and gpio-ranges or a SoC specific alias has
> not been assigned.
>
> Try to use the gpio alias id as first fallback when a gpio-ranges prop
> is missing to ease sync of updated SoC DT. Keep the current fallback on
> node name as a third fallback to not affect any existing unsynced DT.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2:
> - No change
> ---
>   drivers/gpio/rk_gpio.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/rk_gpio.c b/drivers/gpio/rk_gpio.c
> index 4a6ae554bf78..24fedd456353 100644
> --- a/drivers/gpio/rk_gpio.c
> +++ b/drivers/gpio/rk_gpio.c
> @@ -201,8 +201,11 @@ static int rockchip_gpio_probe(struct udevice *dev)
>   		priv->bank = args.args[1] / ROCKCHIP_GPIOS_PER_BANK;
>   	} else {
>   		uc_priv->gpio_count = ROCKCHIP_GPIOS_PER_BANK;
> -		end = strrchr(dev->name, '@');
> -		priv->bank = trailing_strtoln(dev->name, end);
> +		ret = dev_read_alias_seq(dev, &priv->bank);
> +		if (ret) {
> +			end = strrchr(dev->name, '@');
> +			priv->bank = trailing_strtoln(dev->name, end);
> +		}
>   	}
>   
>   	priv->name[0] = 'A' + priv->bank;
