Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B21C3601E
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 03:25:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 250FE832B3;
	Tue,  8 Apr 2025 05:23:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="U5FyHYfb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D37883327; Tue,  8 Apr 2025 05:23:47 +0200 (CEST)
Received: from mail-m3268.qiye.163.com (mail-m3268.qiye.163.com
 [220.197.32.68])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE8CD8331D
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 05:23:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 110208b57;
 Tue, 8 Apr 2025 11:23:38 +0800 (GMT+08:00)
Message-ID: <349469ad-4657-4af7-855e-9642599f2262@rock-chips.com>
Date: Tue, 8 Apr 2025 11:23:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/30] mmc: rockchip_sdhci: Extend variant configuration
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de
References: <20250407224743.2423921-1-jonas@kwiboo.se>
 <20250407224743.2423921-21-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250407224743.2423921-21-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ04dHVZCQ05CTk5LSBlNT09WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a96136cca5c03afkunm110208b57
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MUk6Qxw6PjJDSEIrPw8UTigN
 LxIwCS9VSlVKTE9PS0NJTUlLS05IVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFIQktPNwY+
DKIM-Signature: a=rsa-sha256;
 b=U5FyHYfbeWQu/0NkthL9AQZszo1PwOl8RMBw0SUr+YmcvreARuKtX7Pyu7O++CgUQI83tmBdHRfZYY8uVrjhbgwSCcKoh23RojiI8Dm8SKwG12VLT90B5ijg7vrxdEFVpjEWiKA0cDiOzo9gBwnjj/wBNjJ6dV2ZTgOGLk6ucnc=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=p6Wv2WxNMGK3pyTBKcBtyxFCw/4mcEAi7dok4KZcif8=;
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


On 2025/4/8 06:46, Jonas Karlman wrote:
> RK3528 and RK3576 use different tap and delay num for cmdout and strbin.
>
> Move tap and delay num for cmdout and strbin to driver data to prepare
> for adding new SoCs.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: No change
> ---
>   drivers/mmc/rockchip_sdhci.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/rockchip_sdhci.c b/drivers/mmc/rockchip_sdhci.c
> index da630b9d97a2..4968404bfaed 100644
> --- a/drivers/mmc/rockchip_sdhci.c
> +++ b/drivers/mmc/rockchip_sdhci.c
> @@ -156,6 +156,9 @@ struct sdhci_data {
>   	u32 flags;
>   	u8 hs200_txclk_tapnum;
>   	u8 hs400_txclk_tapnum;
> +	u8 hs400_cmdout_tapnum;
> +	u8 hs400_strbin_tapnum;
> +	u8 ddr50_strbin_delay_num;
>   };
>   
>   static void rk3399_emmc_phy_power_on(struct rockchip_emmc_phy *phy, u32 clock)
> @@ -348,7 +351,7 @@ static int rk3568_sdhci_config_dll(struct sdhci_host *host, u32 clock, bool enab
>   			extra = DLL_CMDOUT_SRC_CLK_NEG |
>   				DLL_CMDOUT_BOTH_CLK_EDGE |
>   				DWCMSHC_EMMC_DLL_DLYENA |
> -				DLL_CMDOUT_TAPNUM_90_DEGREES |
> +				data->hs400_cmdout_tapnum |
>   				DLL_CMDOUT_TAPNUM_FROM_SW;
>   			sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_CMDOUT);
>   		}
> @@ -360,7 +363,7 @@ static int rk3568_sdhci_config_dll(struct sdhci_host *host, u32 clock, bool enab
>   		sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_TXCLK);
>   
>   		extra = DWCMSHC_EMMC_DLL_DLYENA |
> -			DLL_STRBIN_TAPNUM_DEFAULT |
> +			data->hs400_strbin_tapnum |
>   			DLL_STRBIN_TAPNUM_FROM_SW;
>   		sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_STRBIN);
>   	} else {
> @@ -380,7 +383,7 @@ static int rk3568_sdhci_config_dll(struct sdhci_host *host, u32 clock, bool enab
>   		 */
>   		extra = DWCMSHC_EMMC_DLL_DLYENA |
>   			DLL_STRBIN_DELAY_NUM_SEL |
> -			DLL_STRBIN_DELAY_NUM_DEFAULT << DLL_STRBIN_DELAY_NUM_OFFSET;
> +			data->ddr50_strbin_delay_num << DLL_STRBIN_DELAY_NUM_OFFSET;
>   		sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_STRBIN);
>   	}
>   
> @@ -654,6 +657,9 @@ static const struct sdhci_data rk3568_data = {
>   	.flags = FLAG_INVERTER_FLAG_IN_RXCLK,
>   	.hs200_txclk_tapnum = DLL_TXCLK_TAPNUM_DEFAULT,
>   	.hs400_txclk_tapnum = 0x8,
> +	.hs400_cmdout_tapnum = DLL_CMDOUT_TAPNUM_90_DEGREES,
> +	.hs400_strbin_tapnum = DLL_STRBIN_TAPNUM_DEFAULT,
> +	.ddr50_strbin_delay_num = DLL_STRBIN_DELAY_NUM_DEFAULT,
>   };
>   
>   static const struct sdhci_data rk3588_data = {
> @@ -662,6 +668,9 @@ static const struct sdhci_data rk3588_data = {
>   	.config_dll = rk3568_sdhci_config_dll,
>   	.hs200_txclk_tapnum = DLL_TXCLK_TAPNUM_DEFAULT,
>   	.hs400_txclk_tapnum = 0x9,
> +	.hs400_cmdout_tapnum = DLL_CMDOUT_TAPNUM_90_DEGREES,
> +	.hs400_strbin_tapnum = DLL_STRBIN_TAPNUM_DEFAULT,
> +	.ddr50_strbin_delay_num = DLL_STRBIN_DELAY_NUM_DEFAULT,
>   };
>   
>   static const struct udevice_id sdhci_ids[] = {
