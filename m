Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01166C16B13
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 11:03:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C84C9885B0;
	Tue, 23 Apr 2024 13:03:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Rhfp/fZr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0563E885A3; Tue, 23 Apr 2024 13:03:35 +0200 (CEST)
Received: from mail-m127169.xmail.ntesmail.com
 (mail-m127169.xmail.ntesmail.com [115.236.127.169])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 333BD8854A
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 13:03:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Rhfp/fZrhyOTZrpkMcH2vSbhkH6PMSYiFcR0RNfuwBCCKYWgJCoAfK+eCyGvcHixhrScASXWdsk9DNQfIJuDU1DgUv7ugrWa5zt8LuzjDliWLSH/brnIZcKf+n40tPAG1LESEK2VsYr0Y/x1NqFzdT6Ys7evpUKopTn3eUOipE0=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=E1BlHe7ndEfx5xY/C4O7CxjUZpUGqvhgtuMDUVs1c4k=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 30C69900326;
 Tue, 23 Apr 2024 19:03:24 +0800 (CST)
Message-ID: <26b6882e-07a0-4984-89b7-d236a5487954@rock-chips.com>
Date: Tue, 23 Apr 2024 19:03:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/31] clk: rockchip: rk3399: Add dummy support for
 SCLK_PCIEPHY_REF clock
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <20240331202921.262323-14-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240331202921.262323-14-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0oYTVYfGUlLSUMYSkwYGk9VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f0a9feebb03a9kunm30c69900326
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PTY6SCo6ATNKUT0NOUgwGSgU
 QiwKCwJVSlVKTEpIQ0xLSUtPQkpJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFISk1ONwY+
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


On 2024/4/1 04:28, Jonas Karlman wrote:
> rk3399-nanopi-4.dtsi try to set parent of and set rate to 100 MHz of the
> SCLK_PCIEPHY_REF clock.
>
> The existing enable/disable ops for SCLK_PCIEPHY_REF already handles
> setting correct parent once the clock gets enabled. And 100 MHz is the
> default rate used for this clock.
>
> Add dummy support for setting parent, getting and setting clock rate of
> the SCLK_PCIEPHY_REF clock to allow use of PCIe on affected boards.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/clk/rockchip/clk_rk3399.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/clk/rockchip/clk_rk3399.c b/drivers/clk/rockchip/clk_rk3399.c
> index 5934771b4096..29b01abeca06 100644
> --- a/drivers/clk/rockchip/clk_rk3399.c
> +++ b/drivers/clk/rockchip/clk_rk3399.c
> @@ -972,6 +972,7 @@ static ulong rk3399_clk_get_rate(struct clk *clk)
>   	case ACLK_GIC_PRE:
>   	case PCLK_DDR:
>   	case ACLK_VDU:
> +	case SCLK_PCIEPHY_REF:
>   		break;
>   	case PCLK_ALIVE:
>   	case PCLK_WDT:
> @@ -1063,6 +1064,7 @@ static ulong rk3399_clk_set_rate(struct clk *clk, ulong rate)
>   	case ACLK_GIC_PRE:
>   	case PCLK_DDR:
>   	case ACLK_VDU:
> +	case SCLK_PCIEPHY_REF:
>   		return 0;
>   	default:
>   		log_debug("Unknown clock %lu\n", clk->id);
> @@ -1114,6 +1116,8 @@ static int __maybe_unused rk3399_clk_set_parent(struct clk *clk,
>   	switch (clk->id) {
>   	case SCLK_RMII_SRC:
>   		return rk3399_gmac_set_parent(clk, parent);
> +	case SCLK_PCIEPHY_REF:
> +		return 0;
>   	}
>   
>   	debug("%s: unsupported clk %ld\n", __func__, clk->id);
