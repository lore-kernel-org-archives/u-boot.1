Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15854CA0FFF
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 14:57:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C36B838A5;
	Sat, 30 Aug 2025 16:57:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="TpkL76N2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EF138388E; Sat, 30 Aug 2025 16:57:16 +0200 (CEST)
Received: from mail-m49212.qiye.163.com (mail-m49212.qiye.163.com
 [45.254.49.212])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB52A8388E
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 16:57:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [121.204.19.91])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2123c4c74;
 Sat, 30 Aug 2025 22:57:10 +0800 (GMT+08:00)
Message-ID: <810c3424-df41-4869-8619-a7c121fa151e@rock-chips.com>
Date: Sat, 30 Aug 2025 22:57:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] phy: rockchip: usbdp: Add support for RK3576
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Frank Wang <frank.wang@rock-chips.com>
References: <20250801203255.2590535-1-jonas@kwiboo.se>
 <20250801203255.2590535-9-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250801203255.2590535-9-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a98fb7b7ce403afkunmef49efd040d6a4
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDGhoeVktMGh5NGh9OS0hNSVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpCVUJKWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=TpkL76N2M4TodsipPjU2WROIXM9TssUd2Q8AgyKByGIBvQl9OMCIWspWbjC/JdxzNxS+CDSCs+MAf+FgbOAllXxZ4yUTPqozoP8sgeCUnYDPl3H01FCvbg/a7nzPSG0n0AJZrjZ0PZHw12aDHFcZiZ0oIeK12UWq4okNKJUX2Cs=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=6bBRcajDRmM/5pWPHgpDDwjMqVuMdBGqV0BbD8T1UlE=;
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


On 2025/8/2 04:32, Jonas Karlman wrote:
> From: Frank Wang <frank.wang@rock-chips.com>
>
> Add support for the USB3.0+DP PHY used in the RK3576 SoC.
>
> Config values are taken from vendor U-Boot linux-6.1-stan-rkr5 tag.
>
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v3: New patch
> ---
>   drivers/phy/rockchip/phy-rockchip-usbdp.c | 26 +++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-usbdp.c b/drivers/phy/rockchip/phy-rockchip-usbdp.c
> index 6cfbef02b4ac..cca67dd3611d 100644
> --- a/drivers/phy/rockchip/phy-rockchip-usbdp.c
> +++ b/drivers/phy/rockchip/phy-rockchip-usbdp.c
> @@ -762,6 +762,28 @@ static const char * const rk3588_udphy_rst_l[] = {
>   	"init", "cmn", "lane", "pcs_apb", "pma_apb"
>   };
>   
> +static const struct rockchip_udphy_cfg rk3576_udphy_cfgs = {
> +	.num_phys = 1,
> +	.phy_ids = {
> +		0x2b010000,
> +	},
> +	.num_rsts = ARRAY_SIZE(rk3588_udphy_rst_l),
> +	.rst_list = rk3588_udphy_rst_l,
> +	.grfcfg	= {
> +		/* u2phy-grf */
> +		.bvalid_phy_con		= { 0x0010, 1, 0, 0x2, 0x3 },
> +		.bvalid_grf_con		= { 0x0000, 15, 14, 0x1, 0x3 },
> +
> +		/* usb-grf */
> +		.usb3otg0_cfg		= { 0x0030, 15, 0, 0x1100, 0x0188 },
> +
> +		/* usbdpphy-grf */
> +		.low_pwrn		= { 0x0004, 13, 13, 0, 1 },
> +		.rx_lfps		= { 0x0004, 14, 14, 0, 1 },
> +	},
> +	.combophy_init = rk3588_udphy_init,
> +};
> +
>   static const struct rockchip_udphy_cfg rk3588_udphy_cfgs = {
>   	.num_phys = 2,
>   	.phy_ids = {
> @@ -787,6 +809,10 @@ static const struct rockchip_udphy_cfg rk3588_udphy_cfgs = {
>   };
>   
>   static const struct udevice_id rockchip_udphy_dt_match[] = {
> +	{
> +		.compatible = "rockchip,rk3576-usbdp-phy",
> +		.data = (ulong)&rk3576_udphy_cfgs
> +	},
>   	{
>   		.compatible = "rockchip,rk3588-usbdp-phy",
>   		.data = (ulong)&rk3588_udphy_cfgs
