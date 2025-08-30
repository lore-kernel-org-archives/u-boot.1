Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB7DCA0FFF
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 15:24:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 430E7838C2;
	Sat, 30 Aug 2025 17:24:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="FIZdSgCV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55A27838C5; Sat, 30 Aug 2025 17:24:56 +0200 (CEST)
Received: from mail-m49233.qiye.163.com (mail-m49233.qiye.163.com
 [45.254.49.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06067838B7
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 17:24:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [121.204.19.91])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2123f9893;
 Sat, 30 Aug 2025 23:24:50 +0800 (GMT+08:00)
Message-ID: <6a406887-e1e9-4f2a-86d4-acdd1ab5aa82@rock-chips.com>
Date: Sat, 30 Aug 2025 23:24:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] rockchip: clk: clk_rk3528: Add dummy
 CLK_REF_PCIE_INNER_PHY support
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de
References: <20250730235301.1774089-1-jonas@kwiboo.se>
 <20250730235301.1774089-6-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250730235301.1774089-6-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a98fb94d10703afkunmc623bf09415697
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGEgZVk1KT04ZSE8eS0JDGlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpCVUJKWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=FIZdSgCVKl13uIKeZGY33mTkJSlGzIUHWHuNbQiUYdgUuF3wnBR5NrzbCFO0Q6+Jfj3d2ra6inLgCuPzDNn+JnP8jKv2gaETz4a3rDMSvs0wRzJ3NCuHv5LaTJDDqd2TGnBkQorHNuQ4Xr1G4N5pBX2dHCEey05WELSOJwv11pI=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=lkzQOCDsA5cRkZI+n0QU2i1AuwePsAjRdlK2kFORMgE=;
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


On 2025/7/31 07:52, Jonas Karlman wrote:
> Add dummy support for the CLK_REF_PCIE_INNER_PHY clock to allow probe of
> the phy-rockchip-naneng-combphy driver on RK3528.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/clk/rockchip/clk_rk3528.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/clk/rockchip/clk_rk3528.c b/drivers/clk/rockchip/clk_rk3528.c
> index 06f20895accf..d58557ff56de 100644
> --- a/drivers/clk/rockchip/clk_rk3528.c
> +++ b/drivers/clk/rockchip/clk_rk3528.c
> @@ -1535,6 +1535,7 @@ static ulong rk3528_clk_set_rate(struct clk *clk, ulong rate)
>   	/* Might occur in cru assigned-clocks, can be ignored here */
>   	case ACLK_BUS_VOPGL_ROOT:
>   	case BCLK_EMMC:
> +	case CLK_REF_PCIE_INNER_PHY:
>   	case XIN_OSC0_DIV:
>   		ret = 0;
>   		break;
