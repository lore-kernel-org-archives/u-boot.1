Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC761C0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 21:20:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D506D809A4;
	Thu, 30 Jan 2025 22:20:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Vehp//xT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17644809D0; Thu, 30 Jan 2025 22:20:21 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFEF680243
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 22:20:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2de8=UX=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1738272016;
 bh=+cZkS7KDSvmFwFuYw0uS2UzB8Z/DkuzvzZEOSAVS1Cw=;
 b=Vehp//xT6Z1c87pc6DrOvaUCFLDV0dA8epFO3Qr2IKWKX7gWruDqlYvCYvSW+OzD3L5IuYlFP
 FI0WPXWXXiZiidXojFZOrchf7wo87/nVFH8XtekQE68+WMq+ex0GdpsRje2Xwj7DTZ9sTHxDwU3
 VAK4Nmw1U44Ha9lStbjeUYu17gjPgl6dpSRLFZlPch1EO+oH+KHvc/dbxGMkqoORqOXhuPp0aX1
 L6thEUCMf7QkmQ4vZmfPCnaeeJFeSR7ZsYG7ALs1+6xWBzXHOIpl2+tDU0w7Erm1VOV4cWfQMkk
 EOUQnKGbIN1JhZ508fKiYLgMSQ2fhRKMRQmJpfDESfpg==
X-Forward-Email-ID: 679bed062d70e7e05883e8f6
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <02557bff-3a8e-48ce-8bcd-e9a0cf81f51b@kwiboo.se>
Date: Thu, 30 Jan 2025 22:20:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] pinctrl: rockchip: fix editing const struct +
 constify rockchip_pin_ctrl
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <foss+uboot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jagan Teki <jagan@edgeble.ai>,
 u-boot@lists.denx.de
References: <20250129-rockchip-pinctrl-const-v1-0-450ccdadfa7e@cherry.de>
 <0ca2ce57-8efe-4de2-8f83-71623867e51f@kwiboo.se>
 <70588c5a-fca5-4600-a229-f30b8d97ac6b@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <70588c5a-fca5-4600-a229-f30b8d97ac6b@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Quentin,

On 2025-01-30 15:16, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 1/29/25 3:20 PM, Jonas Karlman wrote:
>> Hi Quentin,
>>
>> On 2025-01-29 13:42, Quentin Schulz wrote:
>>> While testing some WIP work done by Ilias Apalodimas on guaranteeing
>>> read-only memory areas truly are handled as read-only[1], my RK3588
>>> Tiger couldn't reach U-Boot CLI anymore because of the pinctrl driver
>>> modifying a const struct rockchip_pin_ctrl, triggering a CPU abort.
>>>
>>> Instead of going the lazy way and unconstify it, let's fix the actual
>>> issue in play.
>>>
>>> The member modified in the const is only ever used for setting a member
>>> from another struct (not const that one). However this other member is
>>> never read! Therefore we can simply afford to remove it which means the
>>> sole reader of the member in the const is now gone, thus making it
>>> possible to remove the member from the const struct as well.
>>>
>>> This also means we should be able to constify the private data of the
>>> controller device for all Rockchip devices, instead of having those only
>>> for RK356x, RK3588 and RV1126. With the constify done on top of Ilias
>>> branch[1], my PX30 Ringneck, RK3399 Puma and RK3588 Tiger all reach
>>> U-Boot CLI. No further test (like booting into Linux userspace) was
>>> done.
>>>
>>> [1] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/tree/fix_memory_permissions
>>>
>>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>>> ---
>>> Quentin Schulz (14):
>>>        pinctrl: rockchip: remove unused base_pin bank member
>>>        pinctrl: rockchip: remove unused nr_pins controller member
>>
>> pin_base and nr_pins is used after my "rockchip: pinctrl: Add support
>> for pinmux status cmd" series [1].
>>
>> The pin_base should probably be moved to udevice priv data or similar.
>> nr_pins can probably also be moved to udevice priv data or constify in
>> driver data.
>>
>> Do you want me to re-work/re-store these fields in a different way once
>> I finally send a v3 of that series?
>>
> 
> What I can suggest is to remove the setting of ctrl->nr_pins as I 
> believe we shouldn't be modifying it and we don't need to store it, even 
> in your patch series as we discussed on IRC, and keep pin_base from the 
> bank.
> 
> What I can offer instead is to use a local variable to replace the one 
> from the controller struct.
> 
> """
> diff --git a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c 
> b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
> index d449d07d32e..14aba6f370b 100644
> --- a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
> +++ b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
> @@ -531,20 +531,22 @@ static struct rockchip_pin_ctrl 
> *rockchip_pinctrl_get_soc_data(struct udevice *d
>   	struct rockchip_pin_ctrl *ctrl =
>   			(struct rockchip_pin_ctrl *)dev_get_driver_data(dev);
>   	struct rockchip_pin_bank *bank;
> -	int grf_offs, pmu_offs, drv_grf_offs, drv_pmu_offs, i, j;
> +	int grf_offs, pmu_offs, drv_grf_offs, drv_pmu_offs, ctrl_nr_pins, i, j;
> 
>   	grf_offs = ctrl->grf_mux_offset;
>   	pmu_offs = ctrl->pmu_mux_offset;
>   	drv_pmu_offs = ctrl->pmu_drv_offset;
>   	drv_grf_offs = ctrl->grf_drv_offset;
>   	bank = ctrl->pin_banks;
> +	ctrl_nr_pins = 0;
> +
> 
>   	for (i = 0; i < ctrl->nr_banks; ++i, ++bank) {
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
> """
> 
> Something like that to replace patches 1 and 2. This should allow you to 
> keep working on your other patch series without me making it too much 
> more difficult for you to rebase?

Thanks for taking a look, and I agree this should help when I pick up
and re-spin my series.

> 
> We need this patch series in before 
> https://lore.kernel.org/u-boot/20250130072100.27297-1-ilias.apalodimas@linaro.org/T/#t 
> gets is otherwise we don't be able to boot anymore on RK356x, RK3588 and 
> RV1126. I don't think there's going to be much bikeshedding or 
> controversy about my series here (in v2 if you agree with the above 
> diff), the pinctrl series from last August seems like it could be 
> opening many can of worms so better not rebase this series on top of 
> that series. Do you agree with that?

I fully agree, better to get this in first, I will try to re-spin my
series on top of this sometime later once this has landed.

Regards,
Jonas

> 
> Cheers,
> Quentin

