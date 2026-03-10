Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC0B0FCC9A2
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 01:19:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A3F183F9A;
	Tue, 10 Mar 2026 02:19:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="L4XmsNIX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1910083BC8; Tue, 10 Mar 2026 02:19:32 +0100 (CET)
Received: from mail-m3278.qiye.163.com (mail-m3278.qiye.163.com
 [220.197.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6960183F9B
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 02:19:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [110.83.51.2])
 by smtp.qiye.163.com (Hmail) with ESMTP id 3653649ab;
 Tue, 10 Mar 2026 09:19:25 +0800 (GMT+08:00)
Message-ID: <431bd4f2-1a11-4d14-a354-013036774ffb@rock-chips.com>
Date: Tue, 10 Mar 2026 09:19:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: rockchip: rk3576: Add CLK_REF_USB3OTGx support
To: Jonas Karlman <jonas@kwiboo.se>, Lukasz Majewski <lukma@denx.de>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20260310010217.611910-1-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20260310010217.611910-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9cd553cea303afkunmb1cc3c1517157d5
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTktNVk9PT0tDQkJDHUgaT1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSktVQ0hVTkpVSVlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSk
 JLS1kG
DKIM-Signature: a=rsa-sha256;
 b=L4XmsNIX08UMnqvOXXBD1w1YpupEFWFSpQ0t46L18TTgdr9B297XtNAKPXNIoSmc5clOuCkF/SEg+ZZ4J6OnjMkNwxD7nGOoZoWk3GJ9OCyds2y3hk00Wn7k3cbFd15M70nDw2E3syt2ZWe3MoEoLathgGDdCjeqaF5SGONrFqA=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=SxR06rAWQnMS9SR1AwEGr22F1f/q73MkW/OujmJAhoQ=;
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


On 2026/3/10 09:02, Jonas Karlman wrote:
> The CLK_REF_USB3OTGx clocks are used as reference clocks for the two
> DWC3 blocks.
>
> Add simple support to get rate of CLK_REF_USB3OTGx clocks to fix
> reference clock period configuration.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> This fixes the ref_clk issue on RK3528 that is also fixed by "usb: dwc3:
> core: Use IS_ERR_VALUE() for ref_clk rate check" [1].
>
> [1] https://lore.kernel.org/u-boot/20260209201415.303190-1-jonas@kwiboo.se/
> ---
>   drivers/clk/rockchip/clk_rk3576.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/clk/rockchip/clk_rk3576.c b/drivers/clk/rockchip/clk_rk3576.c
> index 125b08ee8322..59bdfea74258 100644
> --- a/drivers/clk/rockchip/clk_rk3576.c
> +++ b/drivers/clk/rockchip/clk_rk3576.c
> @@ -1989,6 +1989,8 @@ static ulong rk3576_clk_get_rate(struct clk *clk)
>   	case HCLK_SDIO:
>   		rate = rk3576_mmc_get_clk(priv, clk->id);
>   		break;
> +	case CLK_REF_USB3OTG0:
> +	case CLK_REF_USB3OTG1:
>   	case TCLK_EMMC:
>   	case TCLK_WDT0:
>   		rate = OSC_HZ;
> @@ -2153,6 +2155,8 @@ static ulong rk3576_clk_set_rate(struct clk *clk, ulong rate)
>   	case HCLK_SDIO:
>   		ret = rk3576_mmc_set_clk(priv, clk->id, rate);
>   		break;
> +	case CLK_REF_USB3OTG0:
> +	case CLK_REF_USB3OTG1:
>   	case TCLK_EMMC:
>   	case TCLK_WDT0:
>   		ret = OSC_HZ;
