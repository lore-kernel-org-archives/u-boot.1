Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC70FCC9A5
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 01:19:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E6C883CF3;
	Tue, 10 Mar 2026 02:19:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="LD450Rq2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32AA983F75; Tue, 10 Mar 2026 02:19:14 +0100 (CET)
Received: from mail-m49242.qiye.163.com (mail-m49242.qiye.163.com
 [45.254.49.242])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 022DF83BC8
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 02:19:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [110.83.51.2])
 by smtp.qiye.163.com (Hmail) with ESMTP id 36536495e;
 Tue, 10 Mar 2026 09:19:07 +0800 (GMT+08:00)
Message-ID: <cfdee678-cead-413a-b9d6-f5063156e268@rock-chips.com>
Date: Tue, 10 Mar 2026 09:19:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: rockchip: rk3528: Add CLK_REF_USB3OTG support
To: Jonas Karlman <jonas@kwiboo.se>, Lukasz Majewski <lukma@denx.de>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20260310010041.611322-1-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20260310010041.611322-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9cd55386ff03afkunmc94b89d917156bc
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaHxkfVhkZSk8fSU9KTU9MQlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSktVQ0hVTkpVSVlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSk
 JLS1kG
DKIM-Signature: a=rsa-sha256;
 b=LD450Rq2R9sBFsm5ntGIpkn8Qy89lP+xK06MHAmp42EGa5cCMh3qG0Lfbl7VDz6Nsuv5le/zwa6maROTZwBCPUOBFIV4bLiHAWQmF3rKq6HQHvq8sCuG6BEgJcaL8CgGtSlAGgq1esOgjOKtOMJtQaxzkIqnzblEmvmDLsZ54P4=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=E4Se1azUtaVUYA//xNicq3RY+V7aDpD/AtGQczKk6qc=;
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


On 2026/3/10 09:00, Jonas Karlman wrote:
> The CLK_REF_USB3OTG clock is used as reference clock for the DWC3 block.
>
> Add simple support to get rate of CLK_REF_USB3OTG clock to fix reference
> clock period configuration.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> This fixes the ref_clk issue on RK3528 that is also fixed by "usb: dwc3:
> core: Use IS_ERR_VALUE() for ref_clk rate check" [1].
> ---
>   drivers/clk/rockchip/clk_rk3528.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/clk/rockchip/clk_rk3528.c b/drivers/clk/rockchip/clk_rk3528.c
> index d58557ff56de..e1a84b38ad87 100644
> --- a/drivers/clk/rockchip/clk_rk3528.c
> +++ b/drivers/clk/rockchip/clk_rk3528.c
> @@ -1337,6 +1337,7 @@ static ulong rk3528_clk_get_rate(struct clk *clk)
>   					     DPLL);
>   		break;
>   
> +	case CLK_REF_USB3OTG:
>   	case TCLK_EMMC:
>   	case TCLK_WDT_NS:
>   		rate = OSC_HZ;
> @@ -1457,6 +1458,7 @@ static ulong rk3528_clk_set_rate(struct clk *clk, ulong rate)
>   		priv->ppll_hz = rockchip_pll_get_rate(&rk3528_pll_clks[PPLL],
>   						      priv->cru, PPLL);
>   		break;
> +	case CLK_REF_USB3OTG:
>   	case TCLK_EMMC:
>   	case TCLK_WDT_NS:
>   		return (rate == OSC_HZ) ? 0 : -EINVAL;
