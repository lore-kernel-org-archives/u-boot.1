Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BCAC0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 23:26:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AF7E80C96;
	Fri, 31 Jan 2025 00:26:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="OKdCkl+b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C91A180F0E; Fri, 31 Jan 2025 00:26:16 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D608880C85
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 00:26:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2de8=UX=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1738279572;
 bh=5cj1D6Bv9u0DoCfbOYiKb1RAJoGj6j2lY6sEIEx56Wk=;
 b=OKdCkl+bxeU58WAPtiNczkiZ6L12/QnLDdSrYmfjpr8Gtf7CpUayJn8SyUhngqaMsbm66CDdy
 IU6lTnAFNo+rojGsCq1qkN+DHMoxmR+4O7WWGpx2YbU3/7PrUM0G9ioG9jx4LHrjkZjBIUhdecY
 3BNDgD1HM2xeCwn5yvwcCwvihRDzouER3zHwZSAlt7GCP+B30VO0PG8AKDop7NLB7ugyiyruKb4
 MgDe+FyzJYK1U/fZWzs9CUkteWAv8oBxZcQs8FKlJn51UFvg4OiJT8i+4atB/g0ABU8aiqzPRT+
 635shxTmexKCwpwc5XUcoFsaHThlvxBa2S1CplIIPX5g==
X-Forward-Email-ID: 679c0a862d70e7e05884070d
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <025cabb1-026d-4adc-a0bf-1f8d53a39221@kwiboo.se>
Date: Fri, 31 Jan 2025 00:25:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/20] mmc: rockchip_sdhci: Add support for RK3576
To: Heiko Stuebner <heiko@sntech.de>
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 joe.hershberger@ni.com, rfried.dev@gmail.com, quentin.schulz@cherry.de,
 detlev.casanova@collabora.com, u-boot@lists.denx.de,
 sebastian.reichel@collabora.com
References: <20241121142731.1202209-1-heiko@sntech.de>
 <20241121142731.1202209-18-heiko@sntech.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20241121142731.1202209-18-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Heiko,

On 2024-11-21 15:27, Heiko Stuebner wrote:
> Add support for RK3576 to the rockchip sdhci driver.
> 
> It's pretty similar to its cousins found in the RK3568 and RK3588 and the
> specific hs400-tx-tap number was taken from the vendor-u-boot.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/mmc/rockchip_sdhci.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/mmc/rockchip_sdhci.c b/drivers/mmc/rockchip_sdhci.c
> index da630b9d97a..9571e7d66c9 100644
> --- a/drivers/mmc/rockchip_sdhci.c
> +++ b/drivers/mmc/rockchip_sdhci.c
> @@ -656,6 +656,14 @@ static const struct sdhci_data rk3568_data = {
>  	.hs400_txclk_tapnum = 0x8,
>  };
>  
> +static const struct sdhci_data rk3576_data = {
> +	.set_ios_post = rk3568_sdhci_set_ios_post,
> +	.set_clock = rk3568_sdhci_set_clock,
> +	.config_dll = rk3568_sdhci_config_dll,
> +	.hs200_txclk_tapnum = DLL_TXCLK_TAPNUM_DEFAULT,
> +	.hs400_txclk_tapnum = 0x7,

Please add following to fix HS200+ mode together with [1] and [2].

  .hs400_cmdout_tapnum = 0x7,
  .hs400_strbin_tapnum = 0x5,
  .ddr50_strbin_delay_num = 0xa,

[1] https://patchwork.ozlabs.org/patch/2038152/
[2] https://patchwork.ozlabs.org/patch/2038155/

Regards,
Jonas

> +};
> +
>  static const struct sdhci_data rk3588_data = {
>  	.set_ios_post = rk3568_sdhci_set_ios_post,
>  	.set_clock = rk3568_sdhci_set_clock,
> @@ -673,6 +681,10 @@ static const struct udevice_id sdhci_ids[] = {
>  		.compatible = "rockchip,rk3568-dwcmshc",
>  		.data = (ulong)&rk3568_data,
>  	},
> +	{
> +		.compatible = "rockchip,rk3576-dwcmshc",
> +		.data = (ulong)&rk3576_data,
> +	},
>  	{
>  		.compatible = "rockchip,rk3588-dwcmshc",
>  		.data = (ulong)&rk3588_data,

