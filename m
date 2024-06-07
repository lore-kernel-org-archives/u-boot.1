Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23CDEC27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 10:26:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49DF587E96;
	Fri,  7 Jun 2024 12:26:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="GMPKAdec";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F295E87FC8; Fri,  7 Jun 2024 12:26:47 +0200 (CEST)
Received: from mail-m12742.qiye.163.com (mail-m12742.qiye.163.com
 [115.236.127.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 534FB87ABC
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 12:26:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=GMPKAdecRCExCPle6pMltWIJw+B/xURzBmfyzGkNxHjqTClJKJfvxS056SZoKl6fKqKDT6Yc+QQ8mYpZqPm9nFBTl2tSE/BvUtLpiVsOK7TbuljR/6OnzIhilO0BJtWMoax+K9D2praCIDx00kS6G+kZolxFuSMmURNbNTEHRS8=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=wTDROMrW2Ak5cThvpi5QyZdA8eUpu4kvn+LrL31OmYU=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 1459C900247;
 Fri,  7 Jun 2024 18:26:36 +0800 (CST)
Message-ID: <39751d76-d6fd-4769-8a28-f7e687c26755@rock-chips.com>
Date: Fri, 7 Jun 2024 18:26:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] pinctrl: rockchip: rk3188: Fix support for
 IOMUX_GPIO_ONLY flag
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Johan Jonker <jbx6244@gmail.com>, Alex Bee <knaerzche@gmail.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de
References: <20240512121633.1632597-1-jonas@kwiboo.se>
 <20240512121633.1632597-2-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240512121633.1632597-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU4aHVZJT0geSU5DSh9CGElVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8ff23c693e03a9kunm1459c900247
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6P0k6Lww4MDNOAikwISo0ETYD
 AzEwFBpVSlVKTEpMTE5OQkJNQkhLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJQ0lJNwY+
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


On 2024/5/12 20:16, Jonas Karlman wrote:
> GPIO0_A0-A7 on RK3188 is IOMUX_GPIO_ONLY, however, trying to set gpio
> mux return an -ENOTSUPP error code. Fix this by validating using the mux
> function type and not the iomux flag.
>
> Based on Linux commit c4a532dee6b6 ("pinctrl: rockchip: handle first
> half of rk3188-bank0 correctly").
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> Based on the old Linux commit and TRM it looks like GPIO0_B0-B7 should
> also be flagged as IOMUX_GPIO_ONLY.
> ---
>   drivers/pinctrl/rockchip/pinctrl-rockchip-core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
> index a423abcafb23..b6e2ab474d0f 100644
> --- a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
> +++ b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
> @@ -189,7 +189,7 @@ static int rockchip_verify_mux(struct rockchip_pin_bank *bank,
>   	}
>   
>   	if (bank->iomux[iomux_num].type & IOMUX_GPIO_ONLY) {
> -		if (mux != IOMUX_GPIO_ONLY) {
> +		if (mux != RK_FUNC_GPIO) {
>   			debug("pin %d only supports a gpio mux\n", pin);
>   			return -ENOTSUPP;
>   		}
