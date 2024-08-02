Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5346AC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 06:10:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B651288717;
	Fri,  2 Aug 2024 08:10:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="An2v4whO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 194548873C; Fri,  2 Aug 2024 08:10:17 +0200 (CEST)
Received: from mail-m49233.qiye.163.com (mail-m49233.qiye.163.com
 [45.254.49.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8101D88617
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 08:10:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=An2v4whOnMYXyQNM165l4X9pmx38VvMBlNfh46IXm9tGwRkU/CYB2Jc6Budi1k1TwqU0mtvO+/p494YzReqMAEHk0tZsj1JNRzcySKoK98BosKvhv9K3aFO6jEEt/vAKnO0224gY1twmAdxUBNHBT2/fJ/ipWOBHmlYemLjgyXk=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=cWAbKICMtsW1+SQi1PBaGfUSFaWUhHsp6Z/APPq0hlI=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 97AB39003DF;
 Fri,  2 Aug 2024 14:10:03 +0800 (CST)
Message-ID: <b919b18a-8e10-4c99-8047-9789533d8f7c@rock-chips.com>
Date: Fri, 2 Aug 2024 14:10:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: rockchip_dw_mmc: Allow 4-bit mode when 8-bit mode is
 supported
To: Jonas Karlman <jonas@kwiboo.se>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240724065538.2735237-1-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240724065538.2735237-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU1JQlZPQ05JGhkaTBpJTB1WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9111b5aa5703a9kunm97ab39003df
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OUk6Nyo*GjIrOSIvAjIcCkwe
 UR5PFAFVSlVKTElJTkxCS0tPT01KVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJT01NNwY+
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


On 2024/7/24 14:55, Jonas Karlman wrote:
> Hosts capable of 8-bit can also do 4 bits, fix use of 4-bit mode when
> 8-bit mode is supported.
>
> This fixes use of 1-bit mode with SD NAND on ROCK Pi S using the DT in
> v6.11-rc1 that chage to use 8-bit bus to also support eMMC. With this
> 4-bit mode is used with SD NAND and 8-bit mode with eMMC, same as in
> Linux kernel.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/mmc/rockchip_dw_mmc.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/rockchip_dw_mmc.c b/drivers/mmc/rockchip_dw_mmc.c
> index 1a10b7057a47..549fb80f1988 100644
> --- a/drivers/mmc/rockchip_dw_mmc.c
> +++ b/drivers/mmc/rockchip_dw_mmc.c
> @@ -159,6 +159,10 @@ static int rockchip_dwmmc_probe(struct udevice *dev)
>   	host->mmc->dev = dev;
>   	upriv->mmc = host->mmc;
>   
> +	/* Hosts capable of 8-bit can also do 4 bits */
> +	if (host->buswidth == 8)
> +		plat->cfg.host_caps |= MMC_MODE_4BIT;
> +
>   	return dwmci_probe(dev);
>   }
>   
