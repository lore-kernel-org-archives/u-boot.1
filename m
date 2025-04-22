Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 727D0C369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 14:52:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6047B81273;
	Tue, 22 Apr 2025 16:52:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Ym1rWr/S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 898578206E; Tue, 22 Apr 2025 16:52:18 +0200 (CEST)
Received: from mail-m49203.qiye.163.com (mail-m49203.qiye.163.com
 [45.254.49.203])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B54EA815D1
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 16:52:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.69.12] (unknown [218.17.18.106])
 by smtp.qiye.163.com (Hmail) with ESMTP id 12bf5b438;
 Tue, 22 Apr 2025 22:52:11 +0800 (GMT+08:00)
Message-ID: <bd8a2ff9-71f0-4e45-a6db-aef2ed12db3d@rock-chips.com>
Date: Tue, 22 Apr 2025 22:52:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/15] mmc: rockchip_sdhci: Add support for RK3576
To: Heiko Stuebner <heiko@sntech.de>, sjg@chromium.org,
 philipp.tomsich@vrull.eu
Cc: lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jonas@kwiboo.se, quentin.schulz@cherry.de, detlev.casanova@collabora.com,
 u-boot@lists.denx.de, sebastian.reichel@collabora.com
References: <20250415215128.1475593-1-heiko@sntech.de>
 <20250415215128.1475593-10-heiko@sntech.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250415215128.1475593-10-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZHx5NVk9MHkhOGU5KQ0IfH1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlJSkNVSkxVSkNVSktNWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0NJVUpLS1
 VLWQY+
X-HM-Tid: 0a965dfc324b03afkunm12bf5b438
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PU06Sjo5STJKEkkBAQI9Aysc
 CjNPFBJVSlVKTE9OSEhITkhJQ0tPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlJSkNVSkxVSkNVSktNWVdZCAFZQUlNQ003Bg++
DKIM-Signature: a=rsa-sha256;
 b=Ym1rWr/SRnmkpY8oRlkPVDFvtlsDbU3eLQG3U4yCmw7kF2IyypzqMuCJ2Ai3OSVF6iJnrxo2HVVuItm9If5BkBkgPL9vbVJgm8jPawzPMojMdT2nwmdmQdewou61ydsiJVOrpwhbSH2w2ta0uxuvh9s0X4wh74OmqWScEABVlps=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=WhU8T8alSuL8pH+i9zMIpcFzPdRzY3M0rv/MjpOUNjw=;
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


On 2025/4/16 05:51, Heiko Stuebner wrote:
> Add support for RK3576 to the rockchip sdhci driver.
>
> It's pretty similar to its cousins found in the RK3568 and RK3588 and the
> specific hs400-tx-tap number was taken from the vendor-u-boot.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>
> Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/mmc/rockchip_sdhci.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/drivers/mmc/rockchip_sdhci.c b/drivers/mmc/rockchip_sdhci.c
> index c0f98678436..761e3619329 100644
> --- a/drivers/mmc/rockchip_sdhci.c
> +++ b/drivers/mmc/rockchip_sdhci.c
> @@ -682,6 +682,17 @@ static const struct sdhci_data rk3568_data = {
>   	.ddr50_strbin_delay_num = DLL_STRBIN_DELAY_NUM_DEFAULT,
>   };
>   
> +static const struct sdhci_data rk3576_data = {
> +	.set_ios_post = rk3568_sdhci_set_ios_post,
> +	.set_clock = rk3568_sdhci_set_clock,
> +	.config_dll = rk3568_sdhci_config_dll,
> +	.hs200_txclk_tapnum = DLL_TXCLK_TAPNUM_DEFAULT,
> +	.hs400_txclk_tapnum = 0x7,
> +	.hs400_cmdout_tapnum = 0x7,
> +	.hs400_strbin_tapnum = 0x5,
> +	.ddr50_strbin_delay_num = 0xa,
> +};
> +
>   static const struct sdhci_data rk3588_data = {
>   	.set_ios_post = rk3568_sdhci_set_ios_post,
>   	.set_clock = rk3568_sdhci_set_clock,
> @@ -706,6 +717,10 @@ static const struct udevice_id sdhci_ids[] = {
>   		.compatible = "rockchip,rk3568-dwcmshc",
>   		.data = (ulong)&rk3568_data,
>   	},
> +	{
> +		.compatible = "rockchip,rk3576-dwcmshc",
> +		.data = (ulong)&rk3576_data,
> +	},
>   	{
>   		.compatible = "rockchip,rk3588-dwcmshc",
>   		.data = (ulong)&rk3588_data,
