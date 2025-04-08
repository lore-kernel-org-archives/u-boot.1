Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36840C36010
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 02:27:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0D6B82FED;
	Tue,  8 Apr 2025 04:27:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="i8mAzjB+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAFB682E77; Tue,  8 Apr 2025 04:27:15 +0200 (CEST)
Received: from mail-m49203.qiye.163.com (mail-m49203.qiye.163.com
 [45.254.49.203])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39FB982F5A
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 04:27:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 10ff7e333;
 Tue, 8 Apr 2025 10:27:08 +0800 (GMT+08:00)
Message-ID: <e3504696-c5a3-4dbd-8b05-ade0ab8b538a@rock-chips.com>
Date: Tue, 8 Apr 2025 10:27:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/14] pinctrl: rockchip: constify rockchip_pin_ctrl for
 RK3036
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Jagan Teki <jagan@edgeble.ai>,
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20250129-rockchip-pinctrl-const-v1-0-450ccdadfa7e@cherry.de>
 <20250129-rockchip-pinctrl-const-v1-4-450ccdadfa7e@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250129-rockchip-pinctrl-const-v1-4-450ccdadfa7e@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGU8dVk1JSE9JSxoeHUtKGVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a961339105703afkunm10ff7e333
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PjY6Mio4STJJF0MfTFYIOSgs
 Ni4aCiNVSlVKTE9PS0xCSUhLTUpOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUlLTkg3Bg++
DKIM-Signature: a=rsa-sha256;
 b=i8mAzjB+bhf6kmZuwUhNIRC0XdeqSvHfAcnVALWGXIa1tjQQLKmzgYgEhbCCAasKKlW42SnXHTrMmgxE/n1wwpryHvm+8U8Z4fD8eiWM+D73Fo93DiyC9VE3fpzpfg4MUp4HJzErM39688vcdYBcODadWWnrSi9NwcpWafoqGtE=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=SPqlivFpTQnEmjTLmEUnXidVMJlOCO+p36k3TTvnU04=;
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
>   drivers/pinctrl/rockchip/pinctrl-rk3036.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/rockchip/pinctrl-rk3036.c b/drivers/pinctrl/rockchip/pinctrl-rk3036.c
> index b14386ccd937d2fcced72b6c9be6f7809194d3c1..8d0c0e0b6552a28e10758eff178e56e1dd0f865e 100644
> --- a/drivers/pinctrl/rockchip/pinctrl-rk3036.c
> +++ b/drivers/pinctrl/rockchip/pinctrl-rk3036.c
> @@ -80,7 +80,7 @@ static struct rockchip_pin_bank rk3036_pin_banks[] = {
>   	PIN_BANK(2, 32, "gpio2"),
>   };
>   
> -static struct rockchip_pin_ctrl rk3036_pin_ctrl = {
> +static const struct rockchip_pin_ctrl rk3036_pin_ctrl = {
>   	.pin_banks		= rk3036_pin_banks,
>   	.nr_banks		= ARRAY_SIZE(rk3036_pin_banks),
>   	.grf_mux_offset		= 0xa8,
>
