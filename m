Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 063C8C3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 07:54:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B2D3800D7;
	Tue,  6 May 2025 09:54:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="QYu6sDNm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 614868210D; Tue,  6 May 2025 09:54:53 +0200 (CEST)
Received: from mail-m21467.qiye.163.com (mail-m21467.qiye.163.com
 [117.135.214.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E0DD800C1
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 09:54:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 14172bee1;
 Tue, 6 May 2025 15:54:45 +0800 (GMT+08:00)
Message-ID: <4ef42b38-94d3-4e1a-93fc-fd8f7fa1e9fc@rock-chips.com>
Date: Tue, 6 May 2025 15:54:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/13] pinctrl: rockchip: fix bank's pin_base computing
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Jagan Teki <jagan@edgeble.ai>,
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20250131-rockchip-pinctrl-const-v2-0-59bf93968ce7@cherry.de>
 <20250131-rockchip-pinctrl-const-v2-1-59bf93968ce7@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250131-rockchip-pinctrl-const-v2-1-59bf93968ce7@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGBhMVk5KHU4dHRhPTx1ITFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a96a497110d03afkunm14172bee1
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ni46Aww5KjJKNxczExczHTII
 OhIKFCtVSlVKTE9NTkpDS0NMQ0lKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQU1ISEk3Bg++
DKIM-Signature: a=rsa-sha256;
 b=QYu6sDNmbOUIFf7//Vqc4cbEpoJyicLysJYcmQETLprD4pW6yOzpwBjWNSBYMmEdyCEC029VsoIRkTD3h8WAILoBr+rZg5ggdMpKMxZvv+nk8uQpMLMHG9pc7Qz5x2Spku9YtwlbXXQ+zWhiV61NphMOt4KRFgiExEVcYElR6WM=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=MDYYDZ4fC7QM7oUPopvHFGlQZNvIDmD4fjRScavR7xQ=;
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


On 2025/1/31 18:31, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> The logic in the core reads the nr_pins of the controller and uses it as
> the index of the first pin in the bank (pin_base) it currently parses.
> It then increments the number of pins in the controller before going to
> the next bank.
>
> This works "fine" for controllers where nr_pins isn't defined in their
> rockchip_pin_ctrl struct as it defaults to 0. However, when it is
> already set, it'll make the index pin of each bank offset by the number
> in nr_pins declared in the struct at initialization, and it'll keep
> growing while adding banks, which means the total number of pins in the
> controller will be misrepresented.
>
> Additionally, U-Boot proper may probe this driver twice (pre-reloc and
> true proper) and not reset nr_pins of the controller in-between meaning
> the second probe will have an offset of the actual correct nr_pins.
>
> Instead, let's just store locally the number of pins in the controller
> and make sure it's reset between probes.
>
> Finally, this stops modifying a const struct which will soon be
> triggering a CPU abort at runtime.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/pinctrl/rockchip/pinctrl-rk3568.c        | 1 -
>   drivers/pinctrl/rockchip/pinctrl-rk3588.c        | 1 -
>   drivers/pinctrl/rockchip/pinctrl-rockchip-core.c | 5 +++--
>   drivers/pinctrl/rockchip/pinctrl-rockchip.h      | 1 -
>   drivers/pinctrl/rockchip/pinctrl-rv1126.c        | 1 -
>   5 files changed, 3 insertions(+), 6 deletions(-)
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
> index d449d07d32e74d1dec1978b1405bec94887908a2..4de67aba1c3453673891482babf2f009fa053a97 100644
> --- a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
> +++ b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
> @@ -532,6 +532,7 @@ static struct rockchip_pin_ctrl *rockchip_pinctrl_get_soc_data(struct udevice *d
>   			(struct rockchip_pin_ctrl *)dev_get_driver_data(dev);
>   	struct rockchip_pin_bank *bank;
>   	int grf_offs, pmu_offs, drv_grf_offs, drv_pmu_offs, i, j;
> +	u32 ctrl_nr_pins = 0;
>   
>   	grf_offs = ctrl->grf_mux_offset;
>   	pmu_offs = ctrl->pmu_mux_offset;
> @@ -543,8 +544,8 @@ static struct rockchip_pin_ctrl *rockchip_pinctrl_get_soc_data(struct udevice *d
>   		int bank_pins = 0;
>   
>   		bank->priv = priv;
> -		bank->pin_base = ctrl->nr_pins;
> -		ctrl->nr_pins += bank->nr_pins;
> +		bank->pin_base = ctrl_nr_pins;
> +		ctrl_nr_pins += bank->nr_pins;
>   
>   		/* calculate iomux and drv offsets */
>   		for (j = 0; j < 4; j++) {
> diff --git a/drivers/pinctrl/rockchip/pinctrl-rockchip.h b/drivers/pinctrl/rockchip/pinctrl-rockchip.h
> index df7bc684d29fae4ec650d1e14fe88b35b03244ac..65c7488f8e399b36fda685b281db778cb55ba695 100644
> --- a/drivers/pinctrl/rockchip/pinctrl-rockchip.h
> +++ b/drivers/pinctrl/rockchip/pinctrl-rockchip.h
> @@ -500,7 +500,6 @@ struct rockchip_mux_route_data {
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
