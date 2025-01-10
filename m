Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF53E77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 06:51:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4394800D0;
	Fri, 10 Jan 2025 07:51:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="bx8Z7W4J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B83F80027; Fri, 10 Jan 2025 07:50:59 +0100 (CET)
Received: from mail-m11867.qiye.163.com (mail-m11867.qiye.163.com
 [115.236.118.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC89580027
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 07:50:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 84f875ee;
 Fri, 10 Jan 2025 14:50:50 +0800 (GMT+08:00)
Message-ID: <4c453cc6-5af7-4b6c-a901-cc863ddcb9c7@rock-chips.com>
Date: Fri, 10 Jan 2025 14:50:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] rockchip: clk: rk3288: Drop use of SCLK_MAC_PLL
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
References: <20241109210427.884888-1-jonas@kwiboo.se>
 <20241109210427.884888-3-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241109210427.884888-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRgZSVZKGR9DS0JOSR9IHUNWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a944efadae303afkunm84f875ee
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MBg6Cjo*NzITLQ8uEhUuLgoD
 QxAKCRhVSlVKTEhNT0JKQ05KTENLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKTE9MNwY+
DKIM-Signature: a=rsa-sha256;
 b=bx8Z7W4JxfgD95Sm8LAeWu7IIJPiU97O+HDbYTEv4HjEntZa5be3yqhxQ3rzqiP1zZr/jhWZpjxwSvJaYw4KY0Knd3rnbJz0cX+spdeGwYpOPXWnEsahYYzXbMSzTcBZ1+rW+2PwmNIQcHSnxvPn64/T0aQ3vdDjDQqpzY9Nxfw=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=61VC0OSxYTpmeAigUeyWk3ykChc2ry+hOHOTlJF9F0k=;
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


On 2024/11/10 05:04, Jonas Karlman wrote:
> The SCLK_MAC_PLL id is not exported or referenced upstream. It is also
> not referenced in vendor U-Boot or vendor kernel 4.4, 4.19, 5.10 or 6.1.
>
> Relax the check for parent id SCLK_MAC_PLL when using internal clock
> source for gmac to allow use of clock/rk3288-cru.h from dts/upstream.
>
> All in-tree and upstream rk3288 DTs use an external clock as parent,
> so no functional change to boards is expected with this change.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: New patch to keep code for use of gmac internal clock source
> ---
>   drivers/clk/rockchip/clk_rk3288.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/clk/rockchip/clk_rk3288.c b/drivers/clk/rockchip/clk_rk3288.c
> index 43c44fadbe7a..a4ff1c41abb8 100644
> --- a/drivers/clk/rockchip/clk_rk3288.c
> +++ b/drivers/clk/rockchip/clk_rk3288.c
> @@ -903,11 +903,11 @@ static int __maybe_unused rk3288_gmac_set_parent(struct clk *clk, struct clk *pa
>   	int ret;
>   
>   	/*
> -	 * If the requested parent is in the same clock-controller and
> -	 * the id is SCLK_MAC_PLL ("mac_pll_src"), switch to the internal
> -	 * clock.
> +	 * If the requested parent is in the same clock-controller the
> +	 * likely parent is the unexported SCLK_MAC_PLL ("mac_pll_src"),
> +	 * switch to the internal clock.
>   	 */
> -	if ((parent->dev == clk->dev) && (parent->id == SCLK_MAC_PLL)) {
> +	if (parent->dev == clk->dev) {
>   		debug("%s: switching GAMC to SCLK_MAC_PLL\n", __func__);
>   		rk_clrsetreg(&cru->cru_clksel_con[21], RMII_EXTCLK_MASK, 0);
>   		return 0;
