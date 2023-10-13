Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FC1CDB482
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 07:44:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DA0E86E88;
	Fri, 13 Oct 2023 09:44:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="ApkoWaWQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF02B86B35; Fri, 13 Oct 2023 09:44:15 +0200 (CEST)
Received: from mail-m49246.qiye.163.com (mail-m49246.qiye.163.com
 [45.254.49.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 521AF86E84
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 09:44:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=ApkoWaWQKqJhoJCGdGNLDaBRj/CD+9khzixoRPTt5oaELj2zwW9GIJjiQCvdyelyc80eBLyT4bYaInNraKo0yL16Yi2TJsGBuhd6mrvHMe65GppVX9PFdeS9Rzgus9oXVj9huajyUGRbGQCiCdy4UQCkMSHPjPDjH6VRQREI+k8=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=SMbEyfW2uYa9LmJVLdLayZEreMvgJ3vhKmL7pXhqJKc=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id A7C3A40031B;
 Fri, 13 Oct 2023 15:43:29 +0800 (CST)
Message-ID: <c9fdddc9-89e1-052a-841c-dbe7864d7187@rock-chips.com>
Date: Fri, 13 Oct 2023 15:43:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/5] clk: rk3588: Add 742.5M parameter for PLL
Content-Language: en-US
To: Elaine Zhang <zhangqing@rock-chips.com>, lukma@denx.de,
 seanga2@gmail.com, philipp.tomsich@vrull.eu, sjg@chromium.org
Cc: u-boot@lists.denx.de, chenjh@rock-chips.com,
 Guochun Huang <hero.huang@rock-chips.com>
References: <20231011102947.21188-1-zhangqing@rock-chips.com>
 <20231011102947.21188-3-zhangqing@rock-chips.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20231011102947.21188-3-zhangqing@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ01DSFZLQ0wZGk4aQhkdGkpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8b27fd8d872eb3kusna7c3a40031b
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MjY6Tzo5DzwxEAkCHzALFTg3
 PBgaC0JVSlVKTUJMSkNIS0pLTEJPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTk1JNwY+
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


On 2023/10/11 18:29, Elaine Zhang wrote:
> From: Guochun Huang <hero.huang@rock-chips.com>
>
> For a specific frequency.
>
> Signed-off-by: Guochun Huang <hero.huang@rock-chips.com>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/clk/rockchip/clk_rk3588.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
> index 119b1337bdf2..c86176264147 100644
> --- a/drivers/clk/rockchip/clk_rk3588.c
> +++ b/drivers/clk/rockchip/clk_rk3588.c
> @@ -36,6 +36,7 @@ static struct rockchip_pll_rate_table rk3588_pll_rates[] = {
>   	RK3588_PLL_RATE(816000000, 2, 272, 2, 0),
>   	RK3588_PLL_RATE(786432000, 2, 262, 2, 9437),
>   	RK3588_PLL_RATE(786000000, 1, 131, 2, 0),
> +	RK3588_PLL_RATE(742500000, 4, 495, 2, 0),
>   	RK3588_PLL_RATE(722534400, 8, 963, 2, 24850),
>   	RK3588_PLL_RATE(600000000, 2, 200, 2, 0),
>   	RK3588_PLL_RATE(594000000, 2, 198, 2, 0),
