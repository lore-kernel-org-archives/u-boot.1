Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 503EFCA0FFF
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 16:45:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66F888380E;
	Sat, 30 Aug 2025 18:45:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="P078xT1a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37C888383A; Sat, 30 Aug 2025 18:45:47 +0200 (CEST)
Received: from mail-m25493.xmail.ntesmail.com (mail-m25493.xmail.ntesmail.com
 [103.129.254.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22BF1836B2
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 18:45:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [121.204.19.91])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2124a624a;
 Sun, 31 Aug 2025 00:45:38 +0800 (GMT+08:00)
Message-ID: <fb91dada-51b2-4ec8-ace1-073c39c2a9d9@rock-chips.com>
Date: Sun, 31 Aug 2025 00:45:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] phy: rockchip: usbdp: Fix Generic PHY reference
 counting
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250721220734.1617117-1-jonas@kwiboo.se>
 <20250721220734.1617117-2-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250721220734.1617117-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a98fbdeca6503afkunm720accff42cbb9
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDTU5NVkpKT0IYGR8fGk1KHlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpCVUJKWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=P078xT1a27hrPpS5M+LTP/Izh/kS78cKiLapIYz2L2qVJWuBiUROfThykQWL3HMIZD4bUBXEU4r1feR6Pwe5wChcXoibZl25Qj9x8u46jlm5akrmgxtNxx3V+f8xAHCz5PdWps8mdbgfpkMQAhDWd42eU0eUkt3QuKVQY1tbULA=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=S1dqr3HdRKZk2tqPwNwUexfDt8x+gcsbpOKF0PByvtw=;
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


On 2025/7/22 06:07, Jonas Karlman wrote:
> Generic PHY reference counting helps ensure driver ops for init/exit and
> power on/off are called at correct state. For this to work the PHY
> driver must initialize PHY-id to a persistent value in of_xlate ops.
>
> The Rockchip USBDP PHY driver does not initialize the PHY-id field, this
> typically lead to use of unshared reference counting among different
> struct phy instances.
>
> Initialize the PHY-id in of_xlate ops to ensure use of shared reference
> counting among all struct phy instances.
>
> E.g. on a ROCK 5B following could be observed:
>
>    => usb start
>    starting USB...
>    [...]
>    Bus usb@fc400000: 2 USB Device(s) found
>           scanning usb for storage devices... 1 Storage Device(s) found
>
>    => usb reset
>    resetting USB...
>    [...]
>    rockchip_udphy phy@fed90000: cmn ana lcpll lock timeout
>    rockchip_udphy phy@fed90000: failed to init usbdp combophy
>    rockchip_udphy phy@fed90000: PHY: Failed to init phy@fed90000: -110.
>    Can't init PHY1
>    Bus usb@fc400000: probe failed, error -110
>           scanning usb for storage devices... 0 Storage Device(s) found
>
> With shared reference counting this is fixed:
>
>    => usb reset
>    resetting USB...
>    [...]
>    Bus usb@fc400000: 2 USB Device(s) found
>           scanning usb for storage devices... 1 Storage Device(s) found
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/phy/rockchip/phy-rockchip-usbdp.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-usbdp.c b/drivers/phy/rockchip/phy-rockchip-usbdp.c
> index 9deec47ae462..56963c87183e 100644
> --- a/drivers/phy/rockchip/phy-rockchip-usbdp.c
> +++ b/drivers/phy/rockchip/phy-rockchip-usbdp.c
> @@ -587,12 +587,16 @@ static int udphy_power_off(struct rockchip_udphy *udphy, u8 mode)
>   static int rockchip_u3phy_of_xlate(struct phy *phy,
>   				   struct ofnode_phandle_args *args)
>   {
> +	struct rockchip_udphy *udphy = dev_get_priv(phy->dev);
> +
>   	if (args->args_count == 0)
>   		return -EINVAL;
>   
>   	if (args->args[0] != PHY_TYPE_USB3)
>   		return -EINVAL;
>   
> +	phy->id = udphy->id;
> +
>   	return 0;
>   }
>   
