Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E38C5CA0FFF
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 14:57:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7446838CE;
	Sat, 30 Aug 2025 16:57:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="gPm9enPK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAED983893; Sat, 30 Aug 2025 16:57:27 +0200 (CEST)
Received: from mail-m49215.qiye.163.com (mail-m49215.qiye.163.com
 [45.254.49.215])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4E2E838D2
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 16:57:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [121.204.19.91])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2123c4c78;
 Sat, 30 Aug 2025 22:57:20 +0800 (GMT+08:00)
Message-ID: <bfd45fe8-f77c-412d-ac3d-1e5e65537c33@rock-chips.com>
Date: Sat, 30 Aug 2025 22:57:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] rockchip: clk: clk_rk3576: Add dummy
 CLK_REF_PCIEx_PHY support
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, u-boot@lists.denx.de
References: <20250801204345.2603723-1-jonas@kwiboo.se>
 <20250801204345.2603723-2-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250801204345.2603723-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a98fb7ba17803afkunm2001621f40d756
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaQkgaVklCTk0ZQh5DSk5KSlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpCVUJKWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=gPm9enPK8UFBJ/kZH+LqCLblbdBIka6LNx9tvva1Lk0N+qly1r72jZzyzW5Me1UrK+UDQ3p9wploOGvV6aQAtKWVj4KkV4CVTmbgyQNJXO8i3qSmpYcSX31tXOh/Cs3uxKvH/dZbL1Mk5rF972eZ3KIsYrZkArfJRbWjYDl7IIY=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=dcXi15kw32GbsiFDBuVwj0oQuzBtQy+8+hCETM21SwM=;
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


On 2025/8/2 04:43, Jonas Karlman wrote:
> Add dummy support for the CLK_REF_PCIEx_PHY clocks to allow probe of the
> phy-rockchip-naneng-combphy driver on RK3576.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v3: No change
> v2: New patch
> ---
>   drivers/clk/rockchip/clk_rk3576.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/clk/rockchip/clk_rk3576.c b/drivers/clk/rockchip/clk_rk3576.c
> index e84a0943a940..125b08ee8322 100644
> --- a/drivers/clk/rockchip/clk_rk3576.c
> +++ b/drivers/clk/rockchip/clk_rk3576.c
> @@ -2168,6 +2168,8 @@ static ulong rk3576_clk_set_rate(struct clk *clk, ulong rate)
>   	case CLK_CPLL_DIV10:
>   	case FCLK_DDR_CM0_CORE:
>   	case ACLK_PHP_ROOT:
> +	case CLK_REF_PCIE0_PHY:
> +	case CLK_REF_PCIE1_PHY:
>   		ret = 0;
>   		break;
>   #ifndef CONFIG_SPL_BUILD
