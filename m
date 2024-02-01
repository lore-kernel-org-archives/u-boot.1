Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D2A0C47258
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 03:09:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E191687C02;
	Thu,  1 Feb 2024 04:08:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="fdc5P0xx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67E9087C09; Thu,  1 Feb 2024 04:08:58 +0100 (CET)
Received: from mail-m3293.qiye.163.com (mail-m3293.qiye.163.com
 [220.197.32.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96F6F875EB
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 04:08:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=fdc5P0xxxCVqdqawZwUk95dGOGX+Yj8PrcPEL2Bb9Q77X15d4k+YRf5qaX0WgiucQ8ETqMYFFF55kHTTiJk+na16KYko7AkDiBU+dnAiPO6mUI1DbXPs/spa4Mn8EenOPNjzX/1uu/Nw1Wa3FdJpfl6nWcWkd/VB2LMzoR+y5e0=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=0ct9rhSZImerQHO//fK3bYarUDvs5D2Rk7HahCKBREM=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 56424900112;
 Thu,  1 Feb 2024 11:08:41 +0800 (CST)
Message-ID: <3094002a-5daf-4b9f-bf74-e5b23a34fb2e@rock-chips.com>
Date: Thu, 1 Feb 2024 11:08:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net: designware: Reset eth phy before phy connect
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Simon Glass <sjg@chromium.org>,
 Banglang Huang <banglang.huang@foxmail.com>
Cc: Trevor Woerner <twoerner@gmail.com>, u-boot@lists.denx.de
References: <20240118071949.927089-1-jonas@kwiboo.se>
 <20240118071949.927089-2-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240118071949.927089-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU9NGFZDTk1ISB5NHRhCTUtVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d62a3db5003a9kunm56424900112
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MQg6HSo4HjMRNk0vF0MoFDwa
 CilPClZVSlVKTEtNTE5NQklJT0xOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFIT0NKNwY+
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


On 2024/1/18 15:19, Jonas Karlman wrote:
> Some ethernet PHY require being reset before a phy-id can be read back
> on the MDIO bus. This can result in the following message being show
> on e.g. a Radxa ROCK Pi E v1.21 with a RTL8211F ethernet PHY.
>
>    Could not get PHY for ethernet@ff540000: addr -1
>
> Add support to designware ethernet driver to reset eth phy by calling
> the eth phy uclass function eth_phy_set_mdio_bus(). The call use NULL
> as bus parameter to not set a shared mdio bus reference that would be
> freed when probe fails. Also add a eth_phy_get_addr() call to try and
> get the phy addr from DT when DM_MDIO is disabled.
>
> This help fix ethernet on Radxa ROCK Pi E v1.21:
>
>    => mdio list
>    ethernet@ff540000:
>    1 - RealTek RTL8211F <--> ethernet@ff540000
>
> Reported-by: Trevor Woerner <twoerner@gmail.com>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/net/designware.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/net/designware.c b/drivers/net/designware.c
> index a174344b3ef5..9aa5d8a1409e 100644
> --- a/drivers/net/designware.c
> +++ b/drivers/net/designware.c
> @@ -13,6 +13,7 @@
>   #include <cpu_func.h>
>   #include <dm.h>
>   #include <errno.h>
> +#include <eth_phy.h>
>   #include <log.h>
>   #include <miiphy.h>
>   #include <malloc.h>
> @@ -576,6 +577,9 @@ static int dw_phy_init(struct dw_eth_dev *priv, void *dev)
>   	struct phy_device *phydev;
>   	int ret;
>   
> +	if (IS_ENABLED(CONFIG_DM_ETH_PHY))
> +		eth_phy_set_mdio_bus(dev, NULL);
> +
>   #if IS_ENABLED(CONFIG_DM_MDIO)
>   	phydev = dm_eth_phy_connect(dev);
>   	if (!phydev)
> @@ -583,6 +587,9 @@ static int dw_phy_init(struct dw_eth_dev *priv, void *dev)
>   #else
>   	int phy_addr = -1;
>   
> +	if (IS_ENABLED(CONFIG_DM_ETH_PHY))
> +		phy_addr = eth_phy_get_addr(dev);
> +
>   #ifdef CONFIG_PHY_ADDR
>   	phy_addr = CONFIG_PHY_ADDR;
>   #endif
