Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4963C36010
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 02:27:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5421382F6A;
	Tue,  8 Apr 2025 04:27:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="QCDtNjHM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AD0882F6A; Tue,  8 Apr 2025 04:27:32 +0200 (CEST)
Received: from mail-m3286.qiye.163.com (mail-m3286.qiye.163.com
 [220.197.32.86])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABD9182F5A
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 04:27:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 10ff7e395;
 Tue, 8 Apr 2025 10:27:22 +0800 (GMT+08:00)
Message-ID: <962682d3-818e-40c3-a203-9a38af8da326@rock-chips.com>
Date: Tue, 8 Apr 2025 10:27:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/14] pinctrl: rockchip: constify rockchip_pin_ctrl for
 RK3128
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Jagan Teki <jagan@edgeble.ai>,
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20250129-rockchip-pinctrl-const-v1-0-450ccdadfa7e@cherry.de>
 <20250129-rockchip-pinctrl-const-v1-6-450ccdadfa7e@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250129-rockchip-pinctrl-const-v1-6-450ccdadfa7e@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDH0xPVkIaQkJJGR1MGR1CH1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a96133945e103afkunm10ff7e395
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MCI6OBw6TzIMPUMTD0lMAkIJ
 Fx8aFEhVSlVKTE9PS0xCSU9OT0pPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUlLTk43Bg++
DKIM-Signature: a=rsa-sha256;
 b=QCDtNjHMJX51VOgmVH8fxlv1ZtJBM7uw5ZW9AWOJGUz3Op5Cs5vYVfrUVTe8g/8T2yh9kr6I1QcuLJ3B4AowW4P6nQnx8VMTzXJPqmrVuDIDsnXX2p7Tix+UjYKsYJbF3VsqgiyEipyW12mvXXWv+BETCy9/mkvTUKTSjHMmuwY=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=y4+6qEPlAMkwya8e2yjyqOCZBOGF388lh0UoOFhRNOI=;
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


On 2025/1/29 20:42, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> There's no need to modify private data from the controller, so let's
> make that struct const.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/pinctrl/rockchip/pinctrl-rk3128.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/rockchip/pinctrl-rk3128.c b/drivers/pinctrl/rockchip/pinctrl-rk3128.c
> index d00fc3da8b234667a86d0afea10e47b700cb1e00..9f9c358694ac615f78011b196c22e1b597771c97 100644
> --- a/drivers/pinctrl/rockchip/pinctrl-rk3128.c
> +++ b/drivers/pinctrl/rockchip/pinctrl-rk3128.c
> @@ -171,7 +171,7 @@ static struct rockchip_pin_bank rk3128_pin_banks[] = {
>   	PIN_BANK(3, 32, "gpio3"),
>   };
>   
> -static struct rockchip_pin_ctrl rk3128_pin_ctrl = {
> +static const struct rockchip_pin_ctrl rk3128_pin_ctrl = {
>   	.pin_banks		= rk3128_pin_banks,
>   	.nr_banks		= ARRAY_SIZE(rk3128_pin_banks),
>   	.grf_mux_offset		= 0xa8,
>
