Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE2DCCF9F8
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 08:01:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A080B83B43;
	Sat,  1 Nov 2025 09:00:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Ds8/RgP6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 462A183B48; Sat,  1 Nov 2025 09:00:58 +0100 (CET)
Received: from mail-m49202.qiye.163.com (mail-m49202.qiye.163.com
 [45.254.49.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFFC483AC7
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 09:00:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [124.72.36.229])
 by smtp.qiye.163.com (Hmail) with ESMTP id 27ff799dd;
 Sat, 1 Nov 2025 16:00:51 +0800 (GMT+08:00)
Message-ID: <9e8a0415-7871-4cf6-b75c-9cde0cc996dd@rock-chips.com>
Date: Sat, 1 Nov 2025 16:00:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] rockchip: rk3399: fix TIMER_FMODE constant
To: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Jonas Karlman <jonas@kwiboo.se>,
 Xuhui Lin <xuhui.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Paul Kocialkowski <paulk@sys-base.io>, Chen-Yu Tsai <wens@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20251028-px30-rk3306-common-tpl-v1-0-251aba72de7c@cherry.de>
 <20251028-px30-rk3306-common-tpl-v1-3-251aba72de7c@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20251028-px30-rk3306-common-tpl-v1-3-251aba72de7c@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9a3e6ef96803afkunmcac8c3fe9261de
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaT0saVkwdQxgaHUkaH0NCGlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSU9VTElVSE1VSUlCWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=Ds8/RgP6pGW6woCq2hwSBuwT3zNxKrRibiG9fTcAhhWvPGyZ5cYlhshjXhU7RhKVgpmAL4+dgNU7wKXNBD3IZEKF9TJl0J0u1LIgRRmsanFTQba2Thop74faTL2NTZf1Jp+RDj5uN1OA9zNFG0ro+p6kE0+Dg0MdmV1MqxXnov8=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=iN8trd1reYofb127N2jomdtboY69v23LQwK35MPVUyM=;
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


On 2025/10/29 00:57, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> The free running mode is 0 at bit offset 1. User mode is 1 at bit offset
> 1. Currently, free running mode is 1 at offset 0, which is already the
> case thanks to TIME_EN.
>
> So, this essentially does not change the actual value written to the
> register as it is TIME_EN | TIMER_FMODE which currently is 0x1 | BIT(0)
> = 0b1, and will become 0x1 | (0 << 1) = 0b1.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/rk3399/rk3399.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/rk3399/rk3399.c b/arch/arm/mach-rockchip/rk3399/rk3399.c
> index 43d151708e4..8687a9347ec 100644
> --- a/arch/arm/mach-rockchip/rk3399/rk3399.c
> +++ b/arch/arm/mach-rockchip/rk3399/rk3399.c
> @@ -61,8 +61,8 @@ struct mm_region *mem_map = rk3399_mem_map;
>   #define TIMER_CONTROL_REG	0x1c
>   
>   #define TIMER_EN	0x1
> -#define TIMER_FMODE	BIT(0)
> -#define TIMER_RMODE	BIT(1)
> +#define TIMER_FMODE	(0 << 1)
> +#define TIMER_RMODE	(1 << 1)
>   
>   void rockchip_stimer_init(void)
>   {
>
