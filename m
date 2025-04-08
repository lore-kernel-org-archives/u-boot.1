Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE3BCC369A1
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 03:25:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76A5A83388;
	Tue,  8 Apr 2025 05:23:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="DFJO2a8l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7671832FE; Tue,  8 Apr 2025 05:23:52 +0200 (CEST)
Received: from mail-m3280.qiye.163.com (mail-m3280.qiye.163.com
 [220.197.32.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 612A982CE7
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 05:23:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 110208b85;
 Tue, 8 Apr 2025 11:23:45 +0800 (GMT+08:00)
Message-ID: <8a180cab-b07b-4480-b5ae-0a2e4f8471f1@rock-chips.com>
Date: Tue, 8 Apr 2025 11:23:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 21/30] mmc: rockchip_sdhci: Add initial support for
 RK3528
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de
References: <20250407224743.2423921-1-jonas@kwiboo.se>
 <20250407224743.2423921-22-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250407224743.2423921-22-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx0aTFYaTE9CT0JITBpCSklWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a96136ce60603afkunm110208b85
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ORQ6STo4EzJIIUIcAQgpTgo9
 PwtPCklVSlVKTE9PS0NJTUlMT01JVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTUhCNwY+
DKIM-Signature: a=rsa-sha256;
 b=DFJO2a8lExGjnTCXBJi8MW+aQIYvfkjlpBgxft7VQvYA3pIfeXyah2m2JZ7zHq8jrdooSMl0YCEidZqIWRmd4RLhR/OWhz+rOIzKtPyJtyl64shzMn8wFo9Q9U6zIZb+/uGC55Uhx+hXs9pITZjfMko1G1fxhMlWwDqcZiJXFn8=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=oFiOhkgHxyRe3kNFgKA6JE0bEB//ySAyjT/oixbaKL4=;
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
> Add initial support for SDHCI controller in RK3528.
>
> Only MMC Legacy and MMC High Speed (52MHz) mode is supported after this,
> more work is needed to get the faster HS200/HS400/HS400ES modes working.
>
> Variant tap and delay num is copied from vendor Linux tag
> linux-6.1-stan-rkr5.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: No change
> ---
>   drivers/mmc/rockchip_sdhci.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/drivers/mmc/rockchip_sdhci.c b/drivers/mmc/rockchip_sdhci.c
> index 4968404bfaed..2c54b8a942da 100644
> --- a/drivers/mmc/rockchip_sdhci.c
> +++ b/drivers/mmc/rockchip_sdhci.c
> @@ -650,6 +650,17 @@ static const struct sdhci_data rk3399_data = {
>   	.set_enhanced_strobe = rk3399_sdhci_set_enhanced_strobe,
>   };
>   
> +static const struct sdhci_data rk3528_data = {
> +	.set_ios_post = rk3568_sdhci_set_ios_post,
> +	.set_clock = rk3568_sdhci_set_clock,
> +	.config_dll = rk3568_sdhci_config_dll,
> +	.hs200_txclk_tapnum = 0xc,
> +	.hs400_txclk_tapnum = 0x6,
> +	.hs400_cmdout_tapnum = 0x6,
> +	.hs400_strbin_tapnum = 0x3,
> +	.ddr50_strbin_delay_num = 0xa,
> +};
> +
>   static const struct sdhci_data rk3568_data = {
>   	.set_ios_post = rk3568_sdhci_set_ios_post,
>   	.set_clock = rk3568_sdhci_set_clock,
> @@ -678,6 +689,10 @@ static const struct udevice_id sdhci_ids[] = {
>   		.compatible = "arasan,sdhci-5.1",
>   		.data = (ulong)&rk3399_data,
>   	},
> +	{
> +		.compatible = "rockchip,rk3528-dwcmshc",
> +		.data = (ulong)&rk3528_data,
> +	},
>   	{
>   		.compatible = "rockchip,rk3568-dwcmshc",
>   		.data = (ulong)&rk3568_data,
