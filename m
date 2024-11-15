Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A4ED65C7E
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 14:27:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02B35896BA;
	Fri, 15 Nov 2024 15:27:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jN2uR2db";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AEAC89348; Fri, 15 Nov 2024 15:27:49 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73A58896C5
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 15:27:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2e9b55b83d2so649739a91.3
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 06:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731680865; x=1732285665; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ogFmpNs7jsX6jLL0fLDH8VSoEh3f7VqbJusx3Z5cVrM=;
 b=jN2uR2dbHFCs1a3zSoxndYgu3LHGC6Q1GQ1O70lClO98xEIKumzfzjRM93PiXPkICV
 PzEySuxAQ0ca+zygBLVsJEhVOGzZVJopwCs+ojN58HLoZ0XNgnn2z4O7twue3yOfFLL1
 ZK/uxe1NEnBQ7W6i0VP8tAMAebjz0zK4oyU3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731680865; x=1732285665;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ogFmpNs7jsX6jLL0fLDH8VSoEh3f7VqbJusx3Z5cVrM=;
 b=GVjcs/i9ly2BfotFrE4rPxfoATLZTyYZmaleZ5CxsFLNF6/Vggw0Vqfqqdx9VyHfQK
 GxxrIM+OZHWetL3HJEVe0szmQkUOYUJbw8RwggqHGCkr4ek+m/omG5f//MwY1ydgAKi0
 aqcsaMgWnbOYUKuqgWcez9JK6IdVLmHw4Z0Vl7RBy//4eFoLdd1EePiS1UfcQVc/GPxC
 VG11pIEHdDcyzNCz9fHNx/mHgNkJHkIpF44ejM5kKk8bMQkOfRwW7kLCSANMvbVKU53A
 uJa+Rl0Zqq0oEaetZJS2yclbksQpJXfFhd/r7WsHmPHuXS3U3S/cqOCtSKKeHAGzaJRt
 edsg==
X-Gm-Message-State: AOJu0YwhWGvURWH8zvtYI+AznqSTT2mgM2eBMUqbUiuXRGFP8mjN9H3C
 Vh0PKlHpJiT3rBQ7BJCbqGIwDCbyXAiFMa3aqhRulLMSZXilW+BZEaEB2j53WxW3IhIqzQsk82s
 gaZgW1xbGLijv9iUCkdctgxu54nAe11IUISlWDOJxPAaNXwE=
X-Google-Smtp-Source: AGHT+IG8EmXvRV73zg/MBoiM2v4qKb93L/IozvXtvImH961plRluabHoAuz37hFGnaffGfRzIiucFPssDd8q4Ruzj4s=
X-Received: by 2002:a17:90b:3c4f:b0:2e2:cd80:4d44 with SMTP id
 98e67ed59e1d1-2ea15587d7bmr2879118a91.28.1731680864901; Fri, 15 Nov 2024
 06:27:44 -0800 (PST)
MIME-Version: 1.0
References: <20241113150938.1534931-1-sjg@chromium.org>
 <20241113150938.1534931-2-sjg@chromium.org>
 <20241113174707.GR3600562@bill-the-cat>
 <CAFLszTjW2bGPRvUQC9pxvhKixpov8u2GxzzeUYeKo1FNFyuHug@mail.gmail.com>
 <20241114142221.GD3600562@bill-the-cat>
In-Reply-To: <20241114142221.GD3600562@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 Nov 2024 07:27:19 -0700
Message-ID: <CAFLszTiJ2tQOddSFCjp+TKsRAgjgjtBFXakSJd+4VShio5OuCQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/8] bootstd: Avoid depending on BLK
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

On Thu, 14 Nov 2024 at 07:22, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Nov 13, 2024 at 08:53:31PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 13 Nov 2024 at 10:47, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Nov 13, 2024 at 08:09:31AM -0700, Simon Glass wrote:
> > >
> > > > In principle bootstd can work without block devices, even if it does
> > > > require driver model to be enabled in that case.
> > > >
> > > > The use of a 'depends on BLK' for BOOTSTD conflicts with the way 'BLK'
> > > > is now defined, producing recursive errors through multiple different
> > > > paths, one of which is this (with Linksprite_pcDuino3 and
> > > > BOOTSTD_DEFAULTS enabled):
> > > >
> > > >   arch/arm/Kconfig:7:error: recursive dependency detected!
> > > >   arch/arm/Kconfig:7: symbol ARM64 is selected by ARCH_UNIPHIER_V8_MULTI
> > > >   arch/arm/mach-uniphier/Kconfig:17: symbol ARCH_UNIPHIER_V8_MULTI is
> > > >      part of choice <choice>
> > > >   arch/arm/mach-uniphier/Kconfig:6: choice <choice> contains symbol
> > > >      ARCH_UNIPHIER_V8_MULTI
> > > >   arch/arm/mach-uniphier/Kconfig:17: symbol ARCH_UNIPHIER_V8_MULTI is
> > > >      part of choice SPL
> > > >   arch/arm/mach-stm32mp/Kconfig:3: symbol SPL depends on SUPPORT_SPL
> > > >   common/spl/Kconfig:1: symbol SUPPORT_SPL is selected by ASPEED_AST2600
> > > >   arch/arm/mach-aspeed/Kconfig:26: symbol ASPEED_AST2600 is part of
> > > >      choice <choice>
> > > >   arch/arm/mach-aspeed/Kconfig:12: choice <choice> contains symbol
> > > >      ASPEED_AST2500
> > > >   arch/arm/mach-aspeed/Kconfig:17: symbol ASPEED_AST2500 is part of
> > > >      choice DM_RESET
> > > >   arch/arm/mach-renesas/Kconfig.rcar3:197: symbol DM_RESET is selected
> > > >      by CLK_RCAR_GEN3
> > > >   drivers/clk/renesas/Kconfig:53: symbol CLK_RCAR_GEN3 depends on
> > > >      CLK_RENESAS
> > > >   drivers/clk/renesas/Kconfig:1: symbol CLK_RENESAS depends on CLK
> > > >   drivers/clk/Kconfig:3: symbol CLK is selected by IMX8M_POWER_DOMAIN
> > > >   drivers/power/domain/Kconfig:35: symbol IMX8M_POWER_DOMAIN depends on
> > > >      POWER_DOMAIN
> > > >   drivers/power/domain/Kconfig:3: symbol POWER_DOMAIN is selected by
> > > >      BCM6318_USBH_PHY
> > > >   drivers/phy/Kconfig:83: symbol BCM6318_USBH_PHY depends on PHY
> > > >   drivers/phy/Kconfig:4: symbol PHY is selected by USB_EHCI_MX7
> > > >   drivers/usb/host/Kconfig:211: symbol USB_EHCI_MX7 depends on USB
> > > >   drivers/usb/Kconfig:1: symbol USB is selected by BOOTSTD_DEFAULTS
> > > >   boot/Kconfig:455: symbol BOOTSTD_DEFAULTS depends on BOOTSTD
> > > >   boot/Kconfig:398: symbol BOOTSTD depends on BLK
> > > >   drivers/block/Kconfig:1: symbol BLK is selected by PVBLOCK
> > > >   drivers/xen/Kconfig:1: symbol PVBLOCK depends on XEN
> > > >   Kconfig:176: symbol XEN depends on ARM64
> > > >
> > > > We don't want to revert the change to BLK, which has been in place for
> > > > a year now. We don't want to select BLK in BOOTSTD since it should
> > > > support booting without block devices. The only realistic option is to
> > > > remove BOOTSTD's dependency on BLK.
> > > >
> > > > Disable standard boot on the one board which fails.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > (no changes since v3)
> > > >
> > > > Changes in v3:
> > > > - Drop wip (work-in-progress) comment in commit
> > > >
> > > > Changes in v2:
> > > > - Add new patch to resolve BOOTSTD->BLK recursion with Kconfig
> > > >
> > > >  boot/Kconfig                                   | 2 +-
> > > >  configs/gardena-smart-gateway-mt7688_defconfig | 1 +
> > > >  2 files changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/boot/Kconfig b/boot/Kconfig
> > > > index 7dd30a030e3..b5433e88f10 100644
> > > > --- a/boot/Kconfig
> > > > +++ b/boot/Kconfig
> > > > @@ -393,7 +393,7 @@ config BOOT_DEFAULTS
> > > >  menuconfig BOOTSTD
> > > >       bool "Standard boot"
> > > >       default y
> > > > -     depends on DM && OF_CONTROL && BLK
> > > > +     depends on DM && OF_CONTROL
> > > >       help
> > > >         U-Boot supports a standard way of locating something to boot,
> > > >         typically an Operating System such as Linux, provided by a distro such
> > >
> > > This ends up being a massive size bloat on all of the boards which did
> > > not use BOOTSTD before, and still can't (because there's no appropriate
> > > methods). You need to not just disable it on the one board that fails
> > > but on everything not currently enabling it, which now does enable it.
> >
> > Looking through the list it is hard to know which boards can't use
> > bootstd, nor what the missing methods are. See [1]. I could perhaps
> > disable bootstd for all of the boards?
>
> Well, since you cannot have a block device without BLK at this point,
> none of them can use bootstd since there's no methods for whatever flash
> they use?

We have SPI flash and FEL, for example. Also, sandbox's hostfs doesn't
use BLK. Plus the network bootmeths are available without it.

>
> > > Or you need to better explain what's going on here, exactly and why
> > > depending on BLK here is wrong, for what you're doing.
> >
> > I tried that already. We had quite a long thread about it.
>
> Yes, can you remind me please? I still don't see why this is required
> for sunxi support. And I think this is another good example of where
> your commit message explains your solution, but not the underlying
> problem you're solving. None of the platforms in [1] are ARCH_SUNXI.

Yes it is at [2]. If you look at BLK it says:

config BLK
   bool # "Support block devices"
   depends on DM
   def_bool y if MMC || USB || SCSI || NVME || IDE || AHCI || SATA
   def_bool y if EFI_MEDIA || VIRTIO_BLK || PVBLOCK

We also have, in the commit message:

symbol BLK is selected by EFI_LOADER

Having a 'select X' and 'depends on X' is known to cause problems. We
really shouldn't do it. So I am removing 'depends on BLK'.

Regards,
Simon

[2] https://patchwork.ozlabs.org/project/uboot/patch/20240901222734.462334-4-sjg@chromium.org/
