Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81676C3601E
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 02:26:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABE8182E77;
	Tue,  8 Apr 2025 04:26:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="KpWcn4Ld";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDF2C82EFC; Tue,  8 Apr 2025 04:26:48 +0200 (CEST)
Received: from mail-m49226.qiye.163.com (mail-m49226.qiye.163.com
 [45.254.49.226])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C74582E35
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 04:26:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 10ff609ba;
 Tue, 8 Apr 2025 10:26:38 +0800 (GMT+08:00)
Message-ID: <84797a76-81f1-4fcc-9b96-a7ea92a2a61f@rock-chips.com>
Date: Tue, 8 Apr 2025 10:26:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] pinctrl: rockchip: remove unused base_pin bank
 member
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Jagan Teki <jagan@edgeble.ai>,
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20250129-rockchip-pinctrl-const-v1-0-450ccdadfa7e@cherry.de>
 <20250129-rockchip-pinctrl-const-v1-1-450ccdadfa7e@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250129-rockchip-pinctrl-const-v1-1-450ccdadfa7e@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaQkNKVhpKQkoZGE1JS0tNTFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a9613389b2f03afkunm10ff609ba
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NhQ6LTo6KzJOPUNMD0s6Ok8w
 GDcaCz9VSlVKTE9PS0xCSUtLQ0tCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUlDTE83Bg++
DKIM-Signature: a=rsa-sha256;
 b=KpWcn4Ld3W5LqfXBVQAplCNMxBiHXfRoLo0korofXXEh383quF4e3rvGpoeHDohHrWfGhf4fL3857kWb2G2e2a++Iqf8NnIDjVI7NlU7UuMZnxbk5gVhFSHw0FPji4HoPaIEG0ZB4yduJYWavJr+ICYhDKON5U6iQZ0whfEgQo0=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=54h4D8vlRL90faprwbCgNTWOtPeuFOSTeger4RUhFwQ=;
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
> Each bank has a base_pin member that is only set in the core and never
> used, so it can be removed.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/pinctrl/rockchip/pinctrl-rockchip-core.c | 1 -
>   drivers/pinctrl/rockchip/pinctrl-rockchip.h      | 2 --
>   2 files changed, 3 deletions(-)
>
> diff --git a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
> index d449d07d32e74d1dec1978b1405bec94887908a2..7369fe12b961290742f6ba24fb32b768531f56f9 100644
> --- a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
> +++ b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
> @@ -543,7 +543,6 @@ static struct rockchip_pin_ctrl *rockchip_pinctrl_get_soc_data(struct udevice *d
>   		int bank_pins = 0;
>   
>   		bank->priv = priv;
> -		bank->pin_base = ctrl->nr_pins;
>   		ctrl->nr_pins += bank->nr_pins;
>   
>   		/* calculate iomux and drv offsets */
> diff --git a/drivers/pinctrl/rockchip/pinctrl-rockchip.h b/drivers/pinctrl/rockchip/pinctrl-rockchip.h
> index df7bc684d29fae4ec650d1e14fe88b35b03244ac..ebd008eede24af32c123634a57f50c0294e76842 100644
> --- a/drivers/pinctrl/rockchip/pinctrl-rockchip.h
> +++ b/drivers/pinctrl/rockchip/pinctrl-rockchip.h
> @@ -262,7 +262,6 @@ struct rockchip_drv {
>   
>   /**
>    * @priv: common pinctrl private basedata
> - * @pin_base: first pin number
>    * @nr_pins: number of pins in this bank
>    * @name: name of the bank
>    * @bank_num: number of the bank, to account for holes
> @@ -274,7 +273,6 @@ struct rockchip_drv {
>    */
>   struct rockchip_pin_bank {
>   	struct rockchip_pinctrl_priv	*priv;
> -	u32				pin_base;
>   	u8				nr_pins;
>   	char				*name;
>   	u8				bank_num;
>
