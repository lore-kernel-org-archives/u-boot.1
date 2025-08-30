Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15DBCCA0FFF
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 16:46:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7AC483906;
	Sat, 30 Aug 2025 18:46:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="IAOwaJw8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86C4983903; Sat, 30 Aug 2025 18:46:44 +0200 (CEST)
Received: from mail-m2438.xmail.ntesmail.com (mail-m2438.xmail.ntesmail.com
 [45.195.24.38])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D10A83906
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 18:46:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [121.204.19.91])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2124a625e;
 Sun, 31 Aug 2025 00:46:37 +0800 (GMT+08:00)
Message-ID: <4eca4aae-dcbd-47f1-bacf-d4c5018ca1dc@rock-chips.com>
Date: Sun, 31 Aug 2025 00:46:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] phy: rockchip: inno-usb2: Fix improper use of
 UCLASS_PHY
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250721220734.1617117-1-jonas@kwiboo.se>
 <20250721220734.1617117-7-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250721220734.1617117-7-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a98fbdfb0f403afkunm976c8fe442cffd
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSkIdVk4fSUsaTU4YTB9MHlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpCVUJKWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=IAOwaJw8aAFyMquEjwntOCt2x7xnoOEOLm/3FD5ZLK/B+d4U0oLHzcGGn3ir+whav2YrD4HQDzfx92t5fCzLh5YOVg6KjlXGtzyKOBLKwyXRfIT0nr4xGxmJAWuMCu8xlSgF3OPusEiNhieSFzyXU+2R1YtQ9rSnB2pAb11zeOo=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=yxHvwIX1WAAdC0WjO2Rb0j5Kv3+XM77J1m+n1aCO9w0=;
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
> The Rockchip USB2PHY glue driver improperly present itself as a
> UCLASS_PHY driver, without ever implementing the required phy_ops.
>
> This is something that in special circumstances can lead to a NULL
> pointer dereference followed by a SError crash.
>
> Change the glue driver to use UCLASS_NOP to fix this.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> index 88b33de1b2a0..d6ce12b5e83d 100644
> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> @@ -538,7 +538,7 @@ U_BOOT_DRIVER(rockchip_usb2phy_clock) = {
>   
>   U_BOOT_DRIVER(rockchip_usb2phy) = {
>   	.name	= "rockchip_usb2phy",
> -	.id	= UCLASS_PHY,
> +	.id	= UCLASS_NOP,
>   	.of_match = rockchip_usb2phy_ids,
>   	.probe = rockchip_usb2phy_probe,
>   	.bind = rockchip_usb2phy_bind,
