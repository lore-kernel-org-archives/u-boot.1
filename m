Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3161C48291
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 06:42:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48ACD8786C;
	Mon,  5 Feb 2024 07:42:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="eAC3plvu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B82788792D; Mon,  5 Feb 2024 07:42:30 +0100 (CET)
Received: from mail-m3288.qiye.163.com (mail-m3288.qiye.163.com
 [220.197.32.88])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4005B879FB
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 07:42:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=eAC3plvuGITb4s+aMrGaVA6+J4L9vnU4aEM7DsL0RgSrSa3pSEd2Df1FUc5mpD1oDk91yeuhb4ytr2Xt15CC1uzcAALlCm90yaZcfDWHq8IfiuHN812W+Y44Y695lrFQdD8ftg/Ano139I3aSPH/5musvzcXOL8ZAT5y4ocChmM=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=hFCgcf8ULICVLTbvq/KA/aN1Ja4SGr0QOhnmUxeW2MI=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 25EA790015C;
 Mon,  5 Feb 2024 14:42:19 +0800 (CST)
Message-ID: <494a43cb-aae4-4156-ad44-e3247ea04cca@rock-chips.com>
Date: Mon, 5 Feb 2024 14:42:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] mmc: rockchip_sdhci: Fix HS400 mode write on RK3568
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Weizhao Ouyang <o451686892@gmail.com>, u-boot@lists.denx.de
References: <20240204205312.2342868-1-jonas@kwiboo.se>
 <20240204205312.2342868-4-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240204205312.2342868-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR4eHlZMTh4ZHUMeTh1CGU5VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d7800df9f03a9kunm25ea790015c
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OlE6IRw4SjMJMTw1DD9WCzUS
 My8KCxpVSlVKTEtMSkpOSEhCQkxMVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFIQ01LNwY+
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


On 2024/2/5 04:53, Jonas Karlman wrote:
> Testing has shown that writing to eMMC using HS400 modes on RK3568
> result in an ERROR.
>
> Change the tap number for transmit clock to fix this.
>
> Also stop DLL when config_dll() is called to disable DLL.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> Changes in v2:
> - New patch to fix HS400 mode write on RK3568
> ---
>   drivers/mmc/rockchip_sdhci.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/rockchip_sdhci.c b/drivers/mmc/rockchip_sdhci.c
> index 285332d9f4fd..706fb1235796 100644
> --- a/drivers/mmc/rockchip_sdhci.c
> +++ b/drivers/mmc/rockchip_sdhci.c
> @@ -71,7 +71,6 @@
>   #define DLL_RXCLK_NO_INVERTER		BIT(29)
>   #define DLL_RXCLK_ORI_GATE		BIT(31)
>   #define DLL_TXCLK_TAPNUM_DEFAULT	0x10
> -#define DLL_TXCLK_TAPNUM_90_DEGREES	0x9
>   #define DLL_TXCLK_TAPNUM_FROM_SW	BIT(24)
>   #define DLL_TXCLK_NO_INVERTER		BIT(29)
>   #define DLL_STRBIN_TAPNUM_DEFAULT	0x4
> @@ -314,8 +313,10 @@ static int rk3568_sdhci_config_dll(struct sdhci_host *host, u32 clock, bool enab
>   	int val, ret;
>   	u32 extra, txclk_tapnum;
>   
> -	if (!enable)
> +	if (!enable) {
> +		sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_CTRL);
>   		return 0;
> +	}
>   
>   	if (clock >= 100 * MHz) {
>   		/* reset DLL */
> @@ -648,7 +649,7 @@ static const struct sdhci_data rk3568_data = {
>   	.config_dll = rk3568_sdhci_config_dll,
>   	.flags = FLAG_INVERTER_FLAG_IN_RXCLK,
>   	.hs200_txclk_tapnum = DLL_TXCLK_TAPNUM_DEFAULT,
> -	.hs400_txclk_tapnum = DLL_TXCLK_TAPNUM_DEFAULT,
> +	.hs400_txclk_tapnum = 0x8,
>   };
>   
>   static const struct sdhci_data rk3588_data = {
> @@ -656,7 +657,7 @@ static const struct sdhci_data rk3588_data = {
>   	.set_clock = rk3568_sdhci_set_clock,
>   	.config_dll = rk3568_sdhci_config_dll,
>   	.hs200_txclk_tapnum = DLL_TXCLK_TAPNUM_DEFAULT,
> -	.hs400_txclk_tapnum = DLL_TXCLK_TAPNUM_90_DEGREES,
> +	.hs400_txclk_tapnum = 0x9,
>   };
>   
>   static const struct udevice_id sdhci_ids[] = {
