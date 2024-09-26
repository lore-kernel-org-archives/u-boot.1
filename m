Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBAECDE038
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 21:04:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA02B88E31;
	Thu, 26 Sep 2024 23:04:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="syEo6z4R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1117D88E36; Thu, 26 Sep 2024 23:04:13 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0A6888DFD
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 23:04:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1727384649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=huW9wXhHPpnMSU0NOoaJJN+MxqAuZAZs86U8FzSBPOc=;
 b=syEo6z4R9xF77BWDpezrM7P2y6FX2z89Pp+aIlWP0uuekPcpICT0TN/YuD0c3poXP2na2x
 HQ81c1/TRyLApUlqsJPbIeEYdnetZGBDhHOELP1uck/pgcXzQW1EXOeCKTEq/0tU84uOnh
 0uEYQXWdfrQicGJTWNxShkD+5IiBVKed6p6PvFnf1tMXuNP4RKWzloBQT/UbUh2vr0z03z
 GIZljaSjML3X12mCQzcZHEqSH/N5fTrz9ASaIlMGdCgE5w0oDB6WX++Ul71byrnuos4TqT
 qI8FVtTv3U+LaoszK2BjXfkR7q885nIHXiP7tb3m5Q7729I8/tARnf7gxepwVQ==
Date: Thu, 26 Sep 2024 23:04:09 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Paul Kocialkowski <paulk@sys-base.io>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>, Quentin
 Schulz <quentin.schulz@cherry.de>, Jonas Karlman <jonas@kwiboo.se>, Chris
 Morgan <macromorgan@hotmail.com>, Tim Lunn <tim@feathertop.org>, Paul
 Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH 4/4] rockchip: Disable DRAM debug by default
In-Reply-To: <ZvXJOJb0rKDYnTeQ@collins>
References: <20240926183111.1324284-1-paulk@sys-base.io>
 <20240926183111.1324284-4-paulk@sys-base.io>
 <21bf0494f4dd9052801c2bacfe014651@manjaro.org> <ZvXJOJb0rKDYnTeQ@collins>
Message-ID: <72b29cc73709076229b3aa6ae9d0f5da@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

On 2024-09-26 22:51, Paul Kocialkowski wrote:
> Le Thu 26 Sep 24, 22:17, Dragan Simic a écrit :
>> On 2024-09-26 20:31, Paul Kocialkowski wrote:
>> > From: Paul Kocialkowski <contact@paulk.fr>
>> >
>> > Printing debug details about DRAM is not useful in regular use and
>> > adds visual pollution to the log. Disable it by default.
>> 
>> With all the respect, I disagree with disabling this by default.
>> This prints just a couple of lines that can actually be very helpful
>> when figuring out what's going on in case of some DRAM-related issues
>> on random devices in the field.
> 
> Well this rationale could apply to lots of things and we generally 
> don't
> print debug info about anything else by default.

I'd rather see these messages as some kind of additional verbosity,
rather than some true debugging messages for the DRAM init.  It's just
a couple of additional lines printed on the console, in the end.

> Maybe DRAM is more likely to be a source of issues than other hardware 
> aspects
> that are maybe more stable, but I don't see what would prevent 
> rebuilding a
> u-boot binary with debug enabled. If the DRAM config needs tweaking it 
> will be
> necessary to rebuild a binary anyway.

In theory, rebuilding a U-Boot image and reinstalling it is rather easy.
In practice, it's hardly doable on random devices in the field, and it's
sometimes virtually impossible.  It's simply that not every end user is
willing or capable of doing things like that.

>> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
>> > ---
>> >  configs/anbernic-rgxx3-rk3566_defconfig   | 1 -
>> >  configs/neu2-io-rv1126_defconfig          | 1 -
>> >  configs/roc-pc-mezzanine-rk3399_defconfig | 1 -
>> >  configs/roc-pc-rk3399_defconfig           | 1 -
>> >  configs/rock-pi-n10-rk3399pro_defconfig   | 1 -
>> >  configs/rock-pi-n8-rk3288_defconfig       | 1 -
>> >  configs/sonoff-ihost-rv1126_defconfig     | 1 -
>> >  drivers/ram/rockchip/Kconfig              | 1 -
>> >  8 files changed, 8 deletions(-)
>> >
>> > diff --git a/configs/anbernic-rgxx3-rk3566_defconfig
>> > b/configs/anbernic-rgxx3-rk3566_defconfig
>> > index a03509bf4671..5c074cffeb44 100644
>> > --- a/configs/anbernic-rgxx3-rk3566_defconfig
>> > +++ b/configs/anbernic-rgxx3-rk3566_defconfig
>> > @@ -67,7 +67,6 @@ CONFIG_SPL_DM_REGULATOR_FIXED=y
>> >  CONFIG_REGULATOR_RK8XX=y
>> >  CONFIG_PWM_ROCKCHIP=y
>> >  CONFIG_SPL_RAM=y
>> > -# CONFIG_RAM_ROCKCHIP_DEBUG is not set
>> >  # CONFIG_RNG_SMCCC_TRNG is not set
>> >  CONFIG_BAUDRATE=1500000
>> >  CONFIG_DEBUG_UART_SHIFT=2
>> > diff --git a/configs/neu2-io-rv1126_defconfig
>> > b/configs/neu2-io-rv1126_defconfig
>> > index 2a4c9b45a04f..84e4465f2c5f 100644
>> > --- a/configs/neu2-io-rv1126_defconfig
>> > +++ b/configs/neu2-io-rv1126_defconfig
>> > @@ -45,7 +45,6 @@ CONFIG_MMC_DW=y
>> >  CONFIG_MMC_DW_ROCKCHIP=y
>> >  CONFIG_REGULATOR_PWM=y
>> >  CONFIG_PWM_ROCKCHIP=y
>> > -# CONFIG_RAM_ROCKCHIP_DEBUG is not set
>> >  CONFIG_BAUDRATE=1500000
>> >  CONFIG_DEBUG_UART_SHIFT=2
>> >  CONFIG_SYSRESET=y
>> > diff --git a/configs/roc-pc-mezzanine-rk3399_defconfig
>> > b/configs/roc-pc-mezzanine-rk3399_defconfig
>> > index a57899bfdfa0..b4041902b381 100644
>> > --- a/configs/roc-pc-mezzanine-rk3399_defconfig
>> > +++ b/configs/roc-pc-mezzanine-rk3399_defconfig
>> > @@ -65,7 +65,6 @@ CONFIG_REGULATOR_PWM=y
>> >  CONFIG_SPL_DM_REGULATOR_FIXED=y
>> >  CONFIG_REGULATOR_RK8XX=y
>> >  CONFIG_PWM_ROCKCHIP=y
>> > -# CONFIG_RAM_ROCKCHIP_DEBUG is not set
>> >  CONFIG_RAM_ROCKCHIP_LPDDR4=y
>> >  CONFIG_BAUDRATE=1500000
>> >  CONFIG_DEBUG_UART_SHIFT=2
>> > diff --git a/configs/roc-pc-rk3399_defconfig
>> > b/configs/roc-pc-rk3399_defconfig
>> > index b45f0e0a8994..922f67320c20 100644
>> > --- a/configs/roc-pc-rk3399_defconfig
>> > +++ b/configs/roc-pc-rk3399_defconfig
>> > @@ -62,7 +62,6 @@ CONFIG_REGULATOR_PWM=y
>> >  CONFIG_SPL_DM_REGULATOR_FIXED=y
>> >  CONFIG_REGULATOR_RK8XX=y
>> >  CONFIG_PWM_ROCKCHIP=y
>> > -# CONFIG_RAM_ROCKCHIP_DEBUG is not set
>> >  CONFIG_RAM_ROCKCHIP_LPDDR4=y
>> >  CONFIG_BAUDRATE=1500000
>> >  CONFIG_DEBUG_UART_SHIFT=2
>> > diff --git a/configs/rock-pi-n10-rk3399pro_defconfig
>> > b/configs/rock-pi-n10-rk3399pro_defconfig
>> > index ec995a54a0ee..17fe939ec989 100644
>> > --- a/configs/rock-pi-n10-rk3399pro_defconfig
>> > +++ b/configs/rock-pi-n10-rk3399pro_defconfig
>> > @@ -51,7 +51,6 @@ CONFIG_PHY_ROCKCHIP_TYPEC=y
>> >  CONFIG_PMIC_RK8XX=y
>> >  CONFIG_REGULATOR_RK8XX=y
>> >  CONFIG_PWM_ROCKCHIP=y
>> > -# CONFIG_RAM_ROCKCHIP_DEBUG is not set
>> >  CONFIG_BAUDRATE=1500000
>> >  CONFIG_DEBUG_UART_SHIFT=2
>> >  CONFIG_SYS_NS16550_MEM32=y
>> > diff --git a/configs/rock-pi-n8-rk3288_defconfig
>> > b/configs/rock-pi-n8-rk3288_defconfig
>> > index 4c09b9137ef8..af0fa8879421 100644
>> > --- a/configs/rock-pi-n8-rk3288_defconfig
>> > +++ b/configs/rock-pi-n8-rk3288_defconfig
>> > @@ -73,7 +73,6 @@ CONFIG_REGULATOR_RK8XX=y
>> >  CONFIG_PWM_ROCKCHIP=y
>> >  CONFIG_RAM=y
>> >  CONFIG_SPL_RAM=y
>> > -# CONFIG_RAM_ROCKCHIP_DEBUG is not set
>> >  CONFIG_DEBUG_UART_SHIFT=2
>> >  CONFIG_SYS_NS16550_MEM32=y
>> >  CONFIG_SYSRESET=y
>> > diff --git a/configs/sonoff-ihost-rv1126_defconfig
>> > b/configs/sonoff-ihost-rv1126_defconfig
>> > index 4890644c7e6f..739adb49ce93 100644
>> > --- a/configs/sonoff-ihost-rv1126_defconfig
>> > +++ b/configs/sonoff-ihost-rv1126_defconfig
>> > @@ -46,7 +46,6 @@ CONFIG_MMC_DW=y
>> >  CONFIG_MMC_DW_ROCKCHIP=y
>> >  CONFIG_REGULATOR_PWM=y
>> >  CONFIG_PWM_ROCKCHIP=y
>> > -# CONFIG_RAM_ROCKCHIP_DEBUG is not set
>> >  CONFIG_BAUDRATE=1500000
>> >  CONFIG_DEBUG_UART_SHIFT=2
>> >  CONFIG_SYSRESET=y
>> > diff --git a/drivers/ram/rockchip/Kconfig b/drivers/ram/rockchip/Kconfig
>> > index 67c63ecba047..e030c982eccb 100644
>> > --- a/drivers/ram/rockchip/Kconfig
>> > +++ b/drivers/ram/rockchip/Kconfig
>> > @@ -15,7 +15,6 @@ if RAM_ROCKCHIP
>> >
>> >  config RAM_ROCKCHIP_DEBUG
>> >  	bool "Rockchip ram drivers debugging"
>> > -	default y
>> >  	help
>> >  	  This enables debugging ram driver API's for the platforms
>> >  	  based on Rockchip SoCs.
