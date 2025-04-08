Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68708C369A1
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 02:27:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 081128304A;
	Tue,  8 Apr 2025 04:26:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Ao6nglB7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9D3C82E35; Tue,  8 Apr 2025 04:26:56 +0200 (CEST)
Received: from mail-m1973171.qiye.163.com (mail-m1973171.qiye.163.com
 [220.197.31.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2499E82F5A
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 04:26:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 10ff609fb;
 Tue, 8 Apr 2025 10:26:47 +0800 (GMT+08:00)
Message-ID: <41c04000-815f-49c0-87fb-2d90885595b7@rock-chips.com>
Date: Tue, 8 Apr 2025 10:26:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] pinctrl: rockchip: remove unused nr_pins controller
 member
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Jagan Teki <jagan@edgeble.ai>,
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20250129-rockchip-pinctrl-const-v1-0-450ccdadfa7e@cherry.de>
 <20250129-rockchip-pinctrl-const-v1-2-450ccdadfa7e@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250129-rockchip-pinctrl-const-v1-2-450ccdadfa7e@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSh5JVktISktJQksdSU9PHlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a961338be9703afkunm10ff609fb
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MjY6Kzo6TjICE0M2H0o2OTch
 Tw5PCj5VSlVKTE9PS0xCSUtCQ0hLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQU5KTU43Bg++
DKIM-Signature: a=rsa-sha256;
 b=Ao6nglB7nKUwBRvBFZY7+hYHAY4Oe4wldIEBb/5vAgJSBvTdl52bnGyUpK5jfyYfSdEyWoMwFGKVB+drB4czjbVHMcvO80pJExlVzpmbg1HqCEdR2UdJiOMNZJn+1C5GV/GtQHDYiD6WmoUTmgdrlXbjy1z+os5PVilM2gpGCC0=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=qU1ZFMema4CV6GjPiKZPBoEQpQ1TF7+MsSRz0xLE2XA=;
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
> Each controller has an nr_pins member that is set either through the
> rockchip_pin_ctrl struct or from the core (or both).
>
> This is an issue because on RK3568, RK3588 and RV1126, the struct is
> const, this means it shouldn't be modified at all. This will trigger a
> CPU abort once we enforce the read-only at the MMU level in a few
> releases, therefore let's remove this useless (and broken, and soon
> breaking) code.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/pinctrl/rockchip/pinctrl-rk3568.c        | 1 -
>   drivers/pinctrl/rockchip/pinctrl-rk3588.c        | 1 -
>   drivers/pinctrl/rockchip/pinctrl-rockchip-core.c | 1 -
>   drivers/pinctrl/rockchip/pinctrl-rockchip.h      | 1 -
>   drivers/pinctrl/rockchip/pinctrl-rv1126.c        | 1 -
>   5 files changed, 5 deletions(-)
>
> diff --git a/drivers/pinctrl/rockchip/pinctrl-rk3568.c b/drivers/pinctrl/rockchip/pinctrl-rk3568.c
> index 5deedc648a41950461b6a468e4852fa0a5384207..c8a91b8bb6e925e0f2e7d6cd09f8a06a58be60dd 100644
> --- a/drivers/pinctrl/rockchip/pinctrl-rk3568.c
> +++ b/drivers/pinctrl/rockchip/pinctrl-rk3568.c
> @@ -345,7 +345,6 @@ static struct rockchip_pin_bank rk3568_pin_banks[] = {
>   static const struct rockchip_pin_ctrl rk3568_pin_ctrl = {
>   	.pin_banks		= rk3568_pin_banks,
>   	.nr_banks		= ARRAY_SIZE(rk3568_pin_banks),
> -	.nr_pins		= 160,
>   	.grf_mux_offset		= 0x0,
>   	.pmu_mux_offset		= 0x0,
>   	.iomux_routes		= rk3568_mux_route_data,
> diff --git a/drivers/pinctrl/rockchip/pinctrl-rk3588.c b/drivers/pinctrl/rockchip/pinctrl-rk3588.c
> index 98ababc7c90700c4b27359fc3625519f20437306..fd8e617b9108c7314b8fdd4bbe1dfae71f1b6449 100644
> --- a/drivers/pinctrl/rockchip/pinctrl-rk3588.c
> +++ b/drivers/pinctrl/rockchip/pinctrl-rk3588.c
> @@ -324,7 +324,6 @@ static struct rockchip_pin_bank rk3588_pin_banks[] = {
>   static const struct rockchip_pin_ctrl rk3588_pin_ctrl = {
>   	.pin_banks		= rk3588_pin_banks,
>   	.nr_banks		= ARRAY_SIZE(rk3588_pin_banks),
> -	.nr_pins		= 160,
>   	.set_mux		= rk3588_set_mux,
>   	.set_pull		= rk3588_set_pull,
>   	.set_drive		= rk3588_set_drive,
> diff --git a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
> index 7369fe12b961290742f6ba24fb32b768531f56f9..b87aed709d62d1e85d0d199c2d6c92aeaec67487 100644
> --- a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
> +++ b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
> @@ -543,7 +543,6 @@ static struct rockchip_pin_ctrl *rockchip_pinctrl_get_soc_data(struct udevice *d
>   		int bank_pins = 0;
>   
>   		bank->priv = priv;
> -		ctrl->nr_pins += bank->nr_pins;
>   
>   		/* calculate iomux and drv offsets */
>   		for (j = 0; j < 4; j++) {
> diff --git a/drivers/pinctrl/rockchip/pinctrl-rockchip.h b/drivers/pinctrl/rockchip/pinctrl-rockchip.h
> index ebd008eede24af32c123634a57f50c0294e76842..2910bbb570d8736487b8cb6c9f87f3e164858b5b 100644
> --- a/drivers/pinctrl/rockchip/pinctrl-rockchip.h
> +++ b/drivers/pinctrl/rockchip/pinctrl-rockchip.h
> @@ -498,7 +498,6 @@ struct rockchip_mux_route_data {
>   struct rockchip_pin_ctrl {
>   	struct rockchip_pin_bank	*pin_banks;
>   	u32				nr_banks;
> -	u32				nr_pins;
>   	int				grf_mux_offset;
>   	int				pmu_mux_offset;
>   	int				grf_drv_offset;
> diff --git a/drivers/pinctrl/rockchip/pinctrl-rv1126.c b/drivers/pinctrl/rockchip/pinctrl-rv1126.c
> index efa2408b204b421ad1c5a36b039d8c07c5b7237e..3878a5420dcc98f591e4eefadd78a2fe98b61c7e 100644
> --- a/drivers/pinctrl/rockchip/pinctrl-rv1126.c
> +++ b/drivers/pinctrl/rockchip/pinctrl-rv1126.c
> @@ -381,7 +381,6 @@ static struct rockchip_pin_bank rv1126_pin_banks[] = {
>   static const struct rockchip_pin_ctrl rv1126_pin_ctrl = {
>   	.pin_banks		= rv1126_pin_banks,
>   	.nr_banks		= ARRAY_SIZE(rv1126_pin_banks),
> -	.nr_pins		= 130,
>   	.grf_mux_offset		= 0x10004, /* mux offset from GPIO0_D0 */
>   	.pmu_mux_offset		= 0x0,
>   	.iomux_routes		= rv1126_mux_route_data,
>
