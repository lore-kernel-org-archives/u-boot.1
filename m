Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94325CDE038
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 21:50:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0543488EA3;
	Thu, 26 Sep 2024 23:50:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="qIKO0PZK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DF3488E8A; Thu, 26 Sep 2024 23:50:43 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5141288E51
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 23:50:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1727387440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YpwO0zw21NRdmTv4EexASGfSiRE0h6IdxUNamZqDd0s=;
 b=qIKO0PZKJ67BuOvY817rfFH8U0RKU/7q4cqDZTKKayKH/3wGdw0xR6ZsSEJjirknKCY0C3
 +JhEfW35imEW2EWUghdR18OZnLbPu5hMCAkmiKeHl5sImABckM2RTwhuFwXetyXtepQOEc
 PRw4lgQIs0gkudfgYsPk9LWwyRbT15DAKXkh8ozLTTxg+cMSJGWxtStm/a7tZbNR3cv8Ov
 8R3+YcXjHsmyx/FG9fdb8cEBYplJs217gazK/BdUaNFSiHK4MEjR1k9NfzQ2PD+fwSuwbx
 lM3SsiNXeBiDCIf9rkupXuE7ZL+quAdtCTdDHZypZao4/qWGB2zgqvQ+/Fk62Q==
Date: Thu, 26 Sep 2024 23:50:40 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Paul Kocialkowski <paulk@sys-base.io>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>, Quentin
 Schulz <quentin.schulz@cherry.de>, Jonas Karlman <jonas@kwiboo.se>, Chris
 Morgan <macromorgan@hotmail.com>, Tim Lunn <tim@feathertop.org>, Paul
 Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH 4/4] rockchip: Disable DRAM debug by default
In-Reply-To: <ZvXUoaqT8BLIMRTT@shepard>
References: <20240926183111.1324284-1-paulk@sys-base.io>
 <20240926183111.1324284-4-paulk@sys-base.io>
 <21bf0494f4dd9052801c2bacfe014651@manjaro.org> <ZvXJOJb0rKDYnTeQ@collins>
 <72b29cc73709076229b3aa6ae9d0f5da@manjaro.org> <ZvXPHya0NdGRdCiq@collins>
 <acc079de0eb93a32df523f26836339a7@manjaro.org> <ZvXUoaqT8BLIMRTT@shepard>
Message-ID: <6675da43ee27ad6c6a572749fbc8b4df@manjaro.org>
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

On 2024-09-26 23:39, Paul Kocialkowski wrote:
> On Thu 26 Sep 24, 23:24, Dragan Simic wrote:
>> On 2024-09-26 23:16, Paul Kocialkowski wrote:
>> > Le Thu 26 Sep 24, 23:04, Dragan Simic a écrit :
>> > > On 2024-09-26 22:51, Paul Kocialkowski wrote:
>> > > > Le Thu 26 Sep 24, 22:17, Dragan Simic a écrit :
>> > > > > On 2024-09-26 20:31, Paul Kocialkowski wrote:
>> > > > > > From: Paul Kocialkowski <contact@paulk.fr>
>> > > > > >
>> > > > > > Printing debug details about DRAM is not useful in regular use and
>> > > > > > adds visual pollution to the log. Disable it by default.
>> > > > >
>> > > > > With all the respect, I disagree with disabling this by default.
>> > > > > This prints just a couple of lines that can actually be very helpful
>> > > > > when figuring out what's going on in case of some DRAM-related issues
>> > > > > on random devices in the field.
>> > > >
>> > > > Well this rationale could apply to lots of things and we generally don't
>> > > > print debug info about anything else by default.
>> > >
>> > > I'd rather see these messages as some kind of additional verbosity,
>> > > rather than some true debugging messages for the DRAM init.  It's just
>> > > a couple of additional lines printed on the console, in the end.
>> >
>> > It's mostly the fact that it's platform-specific and makes about no
>> > sense
>> > to a non-developer user that makes me think it's not welcome by default.
>> > It's really printing internal variables, not providing user-readable
>> > information
>> > that can be useful outside of the scope of development.
>> 
>> Well, each and every U-Boot build is platform- and device-specific, so
>> I see no problems with some of the messages produced by default being
>> platform- or device-specific.
> 
> I like the idea that U-Boot behaves more or less the same regardless of 
> the
> platform and that there is some consistency in what is shown on the 
> console.
> At least that's how I understand the "universal" aspect of it.

Well, have a look at TF-A for Allwinner A64, for example, and what it
ends up producing in the U-Boot console.  That's highly non-universal,
not just what gets printed out, but also what the TF-A for A64 ends
up doing, such as setting up some voltage regulators.

>> In practice, anything that U-Boot prints on the console has little to 
>> no
>> meaning to the vast majority of people who actually happen to see and
>> register those messages.  As a result, those messages are mostly 
>> useful
>> to the developers only.
> 
> I disagree. Most of what is shown is understandable for technical users 
> and
> provides informative value. I'm obviously not talking about users that 
> are not
> interested in understand how their technology works here, for whom 
> nothing shown
> on the console will have any value.
> 
> There is a fundamental difference between printing status information 
> and
> printing debug information. I think this clearly falls under debug 
> information
> (and the name of the config option agrees).

The config option could be named CONFIG_RAM_ROCKCHIP_VERBOSE instead,
would that change anything?

However, I don't see us agreeing on this, so I think it's best to agree
to disagree and wait for additional opinions from other people.

>> > > > Maybe DRAM is more likely to be a source of issues than other hardware
>> > > > aspects
>> > > > that are maybe more stable, but I don't see what would prevent
>> > > > rebuilding a
>> > > > u-boot binary with debug enabled. If the DRAM config needs tweaking it
>> > > > will be
>> > > > necessary to rebuild a binary anyway.
>> > >
>> > > In theory, rebuilding a U-Boot image and reinstalling it is rather
>> > > easy.
>> > > In practice, it's hardly doable on random devices in the field, and
>> > > it's
>> > > sometimes virtually impossible.  It's simply that not every end user
>> > > is
>> > > willing or capable of doing things like that.
>> >
>> > Well that is more or less what makes me think this is not welcome by
>> > default:
>> > a non-developer user would not be able to do anything useful with this
>> > information, since they won't be able to rebuild a binary to change the
>> > DRAM
>> > config and solve any DRAM-related issue.
>> 
>> A non-developer may be able to forward the messages to a developer, 
>> who
>> in turn may be able to use them to roughly figure out what's going on.
> 
> I don't see how it is useful to have a deeper understanding of some 
> DRAM-related
> issue if nothing can be done about it.
> 
>> > Just knowing this information "on the field" won't help solve any issue
>> > if
>> > there is no possibility to undergo development and build a binary with a
>> > modified DRAM config.
>> >
>> > In what scenario exactly do you think this would be valuable information
>> > to
>> > a non-developer?
>> 
>> I'm actually speaking from experience.  Those messages have already
>> proven to be useful in a few cases that I happened to witness.
> 
> I'd be curious to see cases where this information helped resolve any 
> actual
> issue. Honestly I'm not very convinced and haven't changed my mind.
> 
> Of course it will be up to maintainers to decide whether this change is 
> good
> or not. I can still live with the debug info on by default, I've just 
> been
> annoyed by it for a while and thought most people would better like it 
> gone.
> 
> Thanks for sharing your thoughts!
> 
> Cheers,
> 
> Paul
> 
>> > > > > > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
>> > > > > > ---
>> > > > > >  configs/anbernic-rgxx3-rk3566_defconfig   | 1 -
>> > > > > >  configs/neu2-io-rv1126_defconfig          | 1 -
>> > > > > >  configs/roc-pc-mezzanine-rk3399_defconfig | 1 -
>> > > > > >  configs/roc-pc-rk3399_defconfig           | 1 -
>> > > > > >  configs/rock-pi-n10-rk3399pro_defconfig   | 1 -
>> > > > > >  configs/rock-pi-n8-rk3288_defconfig       | 1 -
>> > > > > >  configs/sonoff-ihost-rv1126_defconfig     | 1 -
>> > > > > >  drivers/ram/rockchip/Kconfig              | 1 -
>> > > > > >  8 files changed, 8 deletions(-)
>> > > > > >
>> > > > > > diff --git a/configs/anbernic-rgxx3-rk3566_defconfig
>> > > > > > b/configs/anbernic-rgxx3-rk3566_defconfig
>> > > > > > index a03509bf4671..5c074cffeb44 100644
>> > > > > > --- a/configs/anbernic-rgxx3-rk3566_defconfig
>> > > > > > +++ b/configs/anbernic-rgxx3-rk3566_defconfig
>> > > > > > @@ -67,7 +67,6 @@ CONFIG_SPL_DM_REGULATOR_FIXED=y
>> > > > > >  CONFIG_REGULATOR_RK8XX=y
>> > > > > >  CONFIG_PWM_ROCKCHIP=y
>> > > > > >  CONFIG_SPL_RAM=y
>> > > > > > -# CONFIG_RAM_ROCKCHIP_DEBUG is not set
>> > > > > >  # CONFIG_RNG_SMCCC_TRNG is not set
>> > > > > >  CONFIG_BAUDRATE=1500000
>> > > > > >  CONFIG_DEBUG_UART_SHIFT=2
>> > > > > > diff --git a/configs/neu2-io-rv1126_defconfig
>> > > > > > b/configs/neu2-io-rv1126_defconfig
>> > > > > > index 2a4c9b45a04f..84e4465f2c5f 100644
>> > > > > > --- a/configs/neu2-io-rv1126_defconfig
>> > > > > > +++ b/configs/neu2-io-rv1126_defconfig
>> > > > > > @@ -45,7 +45,6 @@ CONFIG_MMC_DW=y
>> > > > > >  CONFIG_MMC_DW_ROCKCHIP=y
>> > > > > >  CONFIG_REGULATOR_PWM=y
>> > > > > >  CONFIG_PWM_ROCKCHIP=y
>> > > > > > -# CONFIG_RAM_ROCKCHIP_DEBUG is not set
>> > > > > >  CONFIG_BAUDRATE=1500000
>> > > > > >  CONFIG_DEBUG_UART_SHIFT=2
>> > > > > >  CONFIG_SYSRESET=y
>> > > > > > diff --git a/configs/roc-pc-mezzanine-rk3399_defconfig
>> > > > > > b/configs/roc-pc-mezzanine-rk3399_defconfig
>> > > > > > index a57899bfdfa0..b4041902b381 100644
>> > > > > > --- a/configs/roc-pc-mezzanine-rk3399_defconfig
>> > > > > > +++ b/configs/roc-pc-mezzanine-rk3399_defconfig
>> > > > > > @@ -65,7 +65,6 @@ CONFIG_REGULATOR_PWM=y
>> > > > > >  CONFIG_SPL_DM_REGULATOR_FIXED=y
>> > > > > >  CONFIG_REGULATOR_RK8XX=y
>> > > > > >  CONFIG_PWM_ROCKCHIP=y
>> > > > > > -# CONFIG_RAM_ROCKCHIP_DEBUG is not set
>> > > > > >  CONFIG_RAM_ROCKCHIP_LPDDR4=y
>> > > > > >  CONFIG_BAUDRATE=1500000
>> > > > > >  CONFIG_DEBUG_UART_SHIFT=2
>> > > > > > diff --git a/configs/roc-pc-rk3399_defconfig
>> > > > > > b/configs/roc-pc-rk3399_defconfig
>> > > > > > index b45f0e0a8994..922f67320c20 100644
>> > > > > > --- a/configs/roc-pc-rk3399_defconfig
>> > > > > > +++ b/configs/roc-pc-rk3399_defconfig
>> > > > > > @@ -62,7 +62,6 @@ CONFIG_REGULATOR_PWM=y
>> > > > > >  CONFIG_SPL_DM_REGULATOR_FIXED=y
>> > > > > >  CONFIG_REGULATOR_RK8XX=y
>> > > > > >  CONFIG_PWM_ROCKCHIP=y
>> > > > > > -# CONFIG_RAM_ROCKCHIP_DEBUG is not set
>> > > > > >  CONFIG_RAM_ROCKCHIP_LPDDR4=y
>> > > > > >  CONFIG_BAUDRATE=1500000
>> > > > > >  CONFIG_DEBUG_UART_SHIFT=2
>> > > > > > diff --git a/configs/rock-pi-n10-rk3399pro_defconfig
>> > > > > > b/configs/rock-pi-n10-rk3399pro_defconfig
>> > > > > > index ec995a54a0ee..17fe939ec989 100644
>> > > > > > --- a/configs/rock-pi-n10-rk3399pro_defconfig
>> > > > > > +++ b/configs/rock-pi-n10-rk3399pro_defconfig
>> > > > > > @@ -51,7 +51,6 @@ CONFIG_PHY_ROCKCHIP_TYPEC=y
>> > > > > >  CONFIG_PMIC_RK8XX=y
>> > > > > >  CONFIG_REGULATOR_RK8XX=y
>> > > > > >  CONFIG_PWM_ROCKCHIP=y
>> > > > > > -# CONFIG_RAM_ROCKCHIP_DEBUG is not set
>> > > > > >  CONFIG_BAUDRATE=1500000
>> > > > > >  CONFIG_DEBUG_UART_SHIFT=2
>> > > > > >  CONFIG_SYS_NS16550_MEM32=y
>> > > > > > diff --git a/configs/rock-pi-n8-rk3288_defconfig
>> > > > > > b/configs/rock-pi-n8-rk3288_defconfig
>> > > > > > index 4c09b9137ef8..af0fa8879421 100644
>> > > > > > --- a/configs/rock-pi-n8-rk3288_defconfig
>> > > > > > +++ b/configs/rock-pi-n8-rk3288_defconfig
>> > > > > > @@ -73,7 +73,6 @@ CONFIG_REGULATOR_RK8XX=y
>> > > > > >  CONFIG_PWM_ROCKCHIP=y
>> > > > > >  CONFIG_RAM=y
>> > > > > >  CONFIG_SPL_RAM=y
>> > > > > > -# CONFIG_RAM_ROCKCHIP_DEBUG is not set
>> > > > > >  CONFIG_DEBUG_UART_SHIFT=2
>> > > > > >  CONFIG_SYS_NS16550_MEM32=y
>> > > > > >  CONFIG_SYSRESET=y
>> > > > > > diff --git a/configs/sonoff-ihost-rv1126_defconfig
>> > > > > > b/configs/sonoff-ihost-rv1126_defconfig
>> > > > > > index 4890644c7e6f..739adb49ce93 100644
>> > > > > > --- a/configs/sonoff-ihost-rv1126_defconfig
>> > > > > > +++ b/configs/sonoff-ihost-rv1126_defconfig
>> > > > > > @@ -46,7 +46,6 @@ CONFIG_MMC_DW=y
>> > > > > >  CONFIG_MMC_DW_ROCKCHIP=y
>> > > > > >  CONFIG_REGULATOR_PWM=y
>> > > > > >  CONFIG_PWM_ROCKCHIP=y
>> > > > > > -# CONFIG_RAM_ROCKCHIP_DEBUG is not set
>> > > > > >  CONFIG_BAUDRATE=1500000
>> > > > > >  CONFIG_DEBUG_UART_SHIFT=2
>> > > > > >  CONFIG_SYSRESET=y
>> > > > > > diff --git a/drivers/ram/rockchip/Kconfig b/drivers/ram/rockchip/Kconfig
>> > > > > > index 67c63ecba047..e030c982eccb 100644
>> > > > > > --- a/drivers/ram/rockchip/Kconfig
>> > > > > > +++ b/drivers/ram/rockchip/Kconfig
>> > > > > > @@ -15,7 +15,6 @@ if RAM_ROCKCHIP
>> > > > > >
>> > > > > >  config RAM_ROCKCHIP_DEBUG
>> > > > > >  	bool "Rockchip ram drivers debugging"
>> > > > > > -	default y
>> > > > > >  	help
>> > > > > >  	  This enables debugging ram driver API's for the platforms
>> > > > > >  	  based on Rockchip SoCs.
