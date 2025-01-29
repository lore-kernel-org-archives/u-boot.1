Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C74C0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 14:20:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35310800B2;
	Wed, 29 Jan 2025 15:20:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Ne1XIEcW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F110809D4; Wed, 29 Jan 2025 15:20:40 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9848080843
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 15:20:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=e4db=UW=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1738160436;
 bh=W0wnDF1IubFmYeHDAEx+VwaaC12fIPnSFng63HztSUQ=;
 b=Ne1XIEcWorWYkztgYwDdi1HtwIERI7tPeIiH5hZKZHj7OBWsqRuKQb5jf5c+/HE4d+MjMPqZz
 uw76oZfanRQbiPLFgHtD2Vo5xLONJSBW0poo9rAQIpbcwqHoZxFCg07He2TRE4CkMxeZKx3Uf5M
 TEeUsWLxoo2Ugif8V7EZIAARNgU09okhji8mMYYsEPxdx8z4wvX9RCv8PE7gbnb4E3u2+AmkkvZ
 sYqYCUlw/1V0Wqllbts1Krj3CzGUCjd11CAa7uSEGJZE9/CJ/sXEFv9zcakFMZHjusGpG21Prug
 18UZXP4WfukYASh9Zh0FcWRfQCTJuHwZVAMGkvBI2tYw==
X-Forward-Email-ID: 679a3929ce34037031a4c21e
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <0ca2ce57-8efe-4de2-8f83-71623867e51f@kwiboo.se>
Date: Wed, 29 Jan 2025 15:20:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] pinctrl: rockchip: fix editing const struct +
 constify rockchip_pin_ctrl
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jagan Teki <jagan@edgeble.ai>,
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20250129-rockchip-pinctrl-const-v1-0-450ccdadfa7e@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250129-rockchip-pinctrl-const-v1-0-450ccdadfa7e@cherry.de>
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

On 2025-01-29 13:42, Quentin Schulz wrote:
> While testing some WIP work done by Ilias Apalodimas on guaranteeing
> read-only memory areas truly are handled as read-only[1], my RK3588
> Tiger couldn't reach U-Boot CLI anymore because of the pinctrl driver
> modifying a const struct rockchip_pin_ctrl, triggering a CPU abort.
> 
> Instead of going the lazy way and unconstify it, let's fix the actual
> issue in play.
> 
> The member modified in the const is only ever used for setting a member
> from another struct (not const that one). However this other member is
> never read! Therefore we can simply afford to remove it which means the
> sole reader of the member in the const is now gone, thus making it
> possible to remove the member from the const struct as well.
> 
> This also means we should be able to constify the private data of the
> controller device for all Rockchip devices, instead of having those only
> for RK356x, RK3588 and RV1126. With the constify done on top of Ilias
> branch[1], my PX30 Ringneck, RK3399 Puma and RK3588 Tiger all reach
> U-Boot CLI. No further test (like booting into Linux userspace) was
> done.
> 
> [1] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/tree/fix_memory_permissions
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> Quentin Schulz (14):
>       pinctrl: rockchip: remove unused base_pin bank member
>       pinctrl: rockchip: remove unused nr_pins controller member

pin_base and nr_pins is used after my "rockchip: pinctrl: Add support
for pinmux status cmd" series [1].

The pin_base should probably be moved to udevice priv data or similar.
nr_pins can probably also be moved to udevice priv data or constify in
driver data.

Do you want me to re-work/re-store these fields in a different way once
I finally send a v3 of that series?

[1] https://patchwork.ozlabs.org/project/uboot/cover/20240802225705.2640999-1-jonas@kwiboo.se/

Regards,
Jonas

>       pinctrl: rockchip: constify rockchip_pin_ctrl for PX30
>       pinctrl: rockchip: constify rockchip_pin_ctrl for RK3036
>       pinctrl: rockchip: constify rockchip_pin_ctrl for RK3066
>       pinctrl: rockchip: constify rockchip_pin_ctrl for RK3128
>       pinctrl: rockchip: constify rockchip_pin_ctrl for RK3188
>       pinctrl: rockchip: constify rockchip_pin_ctrl for RK3228
>       pinctrl: rockchip: constify rockchip_pin_ctrl for RK3288
>       pinctrl: rockchip: constify rockchip_pin_ctrl for RK3308
>       pinctrl: rockchip: constify rockchip_pin_ctrl for RK3328
>       pinctrl: rockchip: constify rockchip_pin_ctrl for RK3368
>       pinctrl: rockchip: constify rockchip_pin_ctrl for RK3399
>       pinctrl: rockchip: constify rockchip_pin_ctrl for RV1108
> 
>  drivers/pinctrl/rockchip/pinctrl-px30.c          | 2 +-
>  drivers/pinctrl/rockchip/pinctrl-rk3036.c        | 2 +-
>  drivers/pinctrl/rockchip/pinctrl-rk3066.c        | 2 +-
>  drivers/pinctrl/rockchip/pinctrl-rk3128.c        | 2 +-
>  drivers/pinctrl/rockchip/pinctrl-rk3188.c        | 2 +-
>  drivers/pinctrl/rockchip/pinctrl-rk322x.c        | 2 +-
>  drivers/pinctrl/rockchip/pinctrl-rk3288.c        | 2 +-
>  drivers/pinctrl/rockchip/pinctrl-rk3308.c        | 2 +-
>  drivers/pinctrl/rockchip/pinctrl-rk3328.c        | 2 +-
>  drivers/pinctrl/rockchip/pinctrl-rk3368.c        | 2 +-
>  drivers/pinctrl/rockchip/pinctrl-rk3399.c        | 2 +-
>  drivers/pinctrl/rockchip/pinctrl-rk3568.c        | 1 -
>  drivers/pinctrl/rockchip/pinctrl-rk3588.c        | 1 -
>  drivers/pinctrl/rockchip/pinctrl-rockchip-core.c | 2 --
>  drivers/pinctrl/rockchip/pinctrl-rockchip.h      | 3 ---
>  drivers/pinctrl/rockchip/pinctrl-rv1108.c        | 2 +-
>  drivers/pinctrl/rockchip/pinctrl-rv1126.c        | 1 -
>  17 files changed, 12 insertions(+), 20 deletions(-)
> ---
> base-commit: a2b489b170f8382f746202c36616eaf2bc38fe86
> change-id: 20250129-rockchip-pinctrl-const-f4123019a584
> 
> Best regards,

