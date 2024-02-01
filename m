Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55BA8C47258
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 03:09:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F2DB875EB;
	Thu,  1 Feb 2024 04:09:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="EDOZNytK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A98D587C4B; Thu,  1 Feb 2024 04:09:10 +0100 (CET)
Received: from mail-m32112.qiye.163.com (mail-m32112.qiye.163.com
 [220.197.32.112])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D2FE87C38
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 04:09:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=EDOZNytKzUgJWln7xP8KtgiM1mTqx8UI0p5gu1tUeBOoKpjIozsnCU4JDa84c8IembHeybbHANaNbJl1V7qK6vsN8L0ZAr4qa5pl3/TlEOYmvKP9RqffXEC6prYqqvPNGOYrRIn+iNyqCSDb6O5uc1Wg/6lq+5+78NLZ+8bdpGI=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=IHdbF4bRXTwzlpek7mQ2iF5hWdtg8D+K8blbYFtxSGc=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 28FC69001BB;
 Thu,  1 Feb 2024 11:08:52 +0800 (CST)
Message-ID: <ed87ead5-8e76-45f6-9578-8dfceede1b63@rock-chips.com>
Date: Thu, 1 Feb 2024 11:08:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rockchip: rk3328-rock-pi-e: Enable DM_ETH_PHY and
 PHY_REALTEK
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Simon Glass <sjg@chromium.org>,
 Banglang Huang <banglang.huang@foxmail.com>
Cc: Trevor Woerner <twoerner@gmail.com>, u-boot@lists.denx.de
References: <20240118071949.927089-1-jonas@kwiboo.se>
 <20240118071949.927089-3-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240118071949.927089-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh9JSFYZGE5LGkIYGUIYQkhVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d62a4041703a9kunm28fc69001bb
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NlE6Qzo4PTMPHE0#LUIOFC1R
 TBgKCRxVSlVKTEtNTE5NQkhJQklIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJQ0NJNwY+
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
> Enable the DM_ETH_PHY and PHY_REALTEK now that the designware ethernet
> driver call eth_phy_set_mdio_bus() to assist with resetting the eth PHY
> during probe.
>
> Fixes ethernet on the v1.21 hw revision of Radxa ROCK Pi E:
>
>    => mdio list
>    ethernet@ff540000:
>    1 - RealTek RTL8211F <--> ethernet@ff540000
>    => net list
>    eth0 : ethernet@ff540000 86:e0:c0:ea:fa:a9 active
>    eth1 : ethernet@ff550000 86:e0:c0:ea:fa:a8
>    => dhcp
>    Speed: 1000, full duplex
>    BOOTP broadcast 1
>    BOOTP broadcast 2
>    BOOTP broadcast 3
>    DHCP client bound to address 192.168.1.114 (1004 ms)
>
> Reported-by: Trevor Woerner <twoerner@gmail.com>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/rock-pi-e-rk3328_defconfig | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/configs/rock-pi-e-rk3328_defconfig b/configs/rock-pi-e-rk3328_defconfig
> index c0375beffec3..6dda900a9b42 100644
> --- a/configs/rock-pi-e-rk3328_defconfig
> +++ b/configs/rock-pi-e-rk3328_defconfig
> @@ -76,6 +76,8 @@ CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_MISC=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DM_ETH_PHY=y
>   CONFIG_ETH_DESIGNWARE=y
>   CONFIG_GMAC_ROCKCHIP=y
>   CONFIG_PHY_ROCKCHIP_INNO_USB2=y
