Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52078C41513
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 13:43:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B418480842;
	Wed, 16 Aug 2023 15:43:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="Qib4/2KU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9955F86784; Wed, 16 Aug 2023 15:43:29 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8C7580778
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 15:43:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Date: Wed, 16 Aug 2023 15:42:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1692193406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CWWFF9xZ3ex7vvAm54d5jhkYq/VlvA2MjRozJBHXZxE=;
 b=Qib4/2KU6Klx6NYYzNqKbg5WBHAREPmLgbdkgm8M+XN0Iwt90Xj1oyRZYUzmZPS7WR1uV+
 Qa8dgoS0MdMZxQY6pxf+7YbiNARerAFx0gd1Cr4xYHRQt0xqirAcrl528hz26NvyYAxqW0
 p77PF/e6X9WnehCzp8aQLHBnWHXaH/o0sx8wtRbdbLpBxp6QG95TwIHxTtpypyOzZ3f6To
 bad+wQMBuX0/RCKjny12DHmZFDo1R9zL2Q5jY4GLyZ8FEFi/s/QYkXSi2Ek/6AJ0BjuF8R
 V67ry7su8lJ9VXi1vevC54KbXcvdmwWWTS0LnqlDm6gtcsf0Jo/JATrONX/zGg==
From: Alexander Dahl <ada@thorsis.com>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: Alexander Dahl <ada@thorsis.com>,
 Durai Manickam KR <durai.manickamkr@microchip.com>,
 Sandeep Sheriker M <sandeep.sheriker@microchip.com>,
 u-boot@lists.denx.de, Mihai Sain <mihai.sain@microchip.com>
Subject: Re: [PATCH 2/4] configs: at91: sam9x60: Switch to new reset driver
Message-ID: <20230816-onscreen-detective-13352326d0df@ifak-system.com>
Mail-Followup-To: Eugen Hristev <eugen.hristev@collabora.com>,
 Durai Manickam KR <durai.manickamkr@microchip.com>,
 Sandeep Sheriker M <sandeep.sheriker@microchip.com>,
 u-boot@lists.denx.de, Mihai Sain <mihai.sain@microchip.com>
References: <20230809141622.231247-1-ada@thorsis.com>
 <20230809141622.231247-3-ada@thorsis.com>
 <b3185256-aff2-eb6e-eae3-7ce9fe2ddd87@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3185256-aff2-eb6e-eae3-7ce9fe2ddd87@collabora.com>
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

Hei hei,

Am Wed, Aug 16, 2023 at 03:48:25PM +0300 schrieb Eugen Hristev:
> 
> Hi Alexander,
> 
> On 8/9/23 17:16, Alexander Dahl wrote:
> > Since commit 61040097a9d1 ("reset: at91: Add reset driver for basic
> > assert/deassert operations") the compatible "microchip,sam9x60-rstc" for
> > the sam9x60 reset controller in sam9x60.dtsi is not handled by
> > CONFIG_SYSRESET_AT91 anymore, but by CONFIG_RESET_AT91 now.  This
> > resulted in the following error message, when trying to reset from
> > U-Boot shell:
> > 
> >      U-Boot> reset
> >      resetting ...
> >      System reset not supported on this platform
> >      ### ERROR ### Please RESET the board ###
> > 
> > Fixed with the switch to the new driver.  Tested on sam9x60-curiosity
> > board.  Defconfigs for sam9x60ek adapted in the same way, but without
> > testing.  These should be all sam9x60 boards affected in U-Boot here.
> 
> From what I remember from the top of my head, it makes sense to use the new
> reset driver, however, you should not remove the old SYSRESET driver,
> because that driver handles different kind of resets on the SoC and PHYs.
> Can you double check that?

Had a look into it and TBH it's very confusing to me.  I found no help
in documentation.  There are two different uclass which from the
outside seem to do the same thing.  The Kconfig help texts do not
explain what the purpose is of one over the other.  As a user this
creates very bad user experience: Do I need one or the other or both? 

Then there's CONFIG_SYSRESET_CMD_RESET which implicates there are more
than one possible implementations for cmd 'reset' … but which is the
right one.  The help text does not explain.

I though sysreset is old and reset is new and assumed things get
migrated like in other subsystems.  But here it seems we have two
entangled subsystems where one hooks into the other (as reset_at91
does).

So, I can of course _just_ enable CONFIG_RESET_AT91 and hope for the
best here, keeping SYSRESET_CMD_RESET as is … but it would be very
nice if someone else could explain the what and why in help texts and
documentation!

Greets
Alex

P.S.: I would have added sysreset or reset subsystem maintainer to Cc,
but according to MAINTAINERS there is none.

> > Signed-off-by: Alexander Dahl <ada@thorsis.com>
> > ---
> >   configs/sam9x60_curiosity_mmc1_defconfig | 4 ++--
> >   configs/sam9x60_curiosity_mmc_defconfig  | 4 ++--
> >   configs/sam9x60ek_mmc_defconfig          | 4 ++--
> >   configs/sam9x60ek_nandflash_defconfig    | 4 ++--
> >   configs/sam9x60ek_qspiflash_defconfig    | 4 ++--
> >   5 files changed, 10 insertions(+), 10 deletions(-)
> > 
> > diff --git a/configs/sam9x60_curiosity_mmc1_defconfig b/configs/sam9x60_curiosity_mmc1_defconfig
> > index 21b2cc2edd..e8781b363b 100644
> > --- a/configs/sam9x60_curiosity_mmc1_defconfig
> > +++ b/configs/sam9x60_curiosity_mmc1_defconfig
> > @@ -14,6 +14,7 @@ CONFIG_DM_GPIO=y
> >   CONFIG_DEFAULT_DEVICE_TREE="at91-sam9x60_curiosity"
> >   CONFIG_SYS_PROMPT="U-Boot> "
> >   CONFIG_OF_LIBFDT_OVERLAY=y
> > +CONFIG_DM_RESET=y
> >   CONFIG_DEBUG_UART_BASE=0xfffff200
> >   CONFIG_DEBUG_UART_CLOCK=200000000
> >   CONFIG_DEBUG_UART_BOARD_INIT=y
> > @@ -79,11 +80,10 @@ CONFIG_PHY_MICREL=y
> >   CONFIG_MACB=y
> >   CONFIG_PINCTRL=y
> >   CONFIG_PINCTRL_AT91=y
> > +CONFIG_RESET_AT91=y
> >   CONFIG_DM_SERIAL=y
> >   CONFIG_DEBUG_UART_ANNOUNCE=y
> >   CONFIG_ATMEL_USART=y
> > -CONFIG_SYSRESET=y
> > -CONFIG_SYSRESET_AT91=y
> >   CONFIG_TIMER=y
> >   CONFIG_MCHP_PIT64B_TIMER=y
> >   CONFIG_W1=y
> > diff --git a/configs/sam9x60_curiosity_mmc_defconfig b/configs/sam9x60_curiosity_mmc_defconfig
> > index 269f015989..0f57588d8b 100644
> > --- a/configs/sam9x60_curiosity_mmc_defconfig
> > +++ b/configs/sam9x60_curiosity_mmc_defconfig
> > @@ -14,6 +14,7 @@ CONFIG_DM_GPIO=y
> >   CONFIG_DEFAULT_DEVICE_TREE="at91-sam9x60_curiosity"
> >   CONFIG_SYS_PROMPT="U-Boot> "
> >   CONFIG_OF_LIBFDT_OVERLAY=y
> > +CONFIG_DM_RESET=y
> >   CONFIG_DEBUG_UART_BASE=0xfffff200
> >   CONFIG_DEBUG_UART_CLOCK=200000000
> >   CONFIG_DEBUG_UART_BOARD_INIT=y
> > @@ -79,11 +80,10 @@ CONFIG_PHY_MICREL=y
> >   CONFIG_MACB=y
> >   CONFIG_PINCTRL=y
> >   CONFIG_PINCTRL_AT91=y
> > +CONFIG_RESET_AT91=y
> >   CONFIG_DM_SERIAL=y
> >   CONFIG_DEBUG_UART_ANNOUNCE=y
> >   CONFIG_ATMEL_USART=y
> > -CONFIG_SYSRESET=y
> > -CONFIG_SYSRESET_AT91=y
> >   CONFIG_TIMER=y
> >   CONFIG_MCHP_PIT64B_TIMER=y
> >   CONFIG_W1=y
> > diff --git a/configs/sam9x60ek_mmc_defconfig b/configs/sam9x60ek_mmc_defconfig
> > index 2a1399748c..446caceba0 100644
> > --- a/configs/sam9x60ek_mmc_defconfig
> > +++ b/configs/sam9x60ek_mmc_defconfig
> > @@ -15,6 +15,7 @@ CONFIG_DM_GPIO=y
> >   CONFIG_DEFAULT_DEVICE_TREE="sam9x60ek"
> >   CONFIG_SYS_PROMPT="U-Boot> "
> >   CONFIG_OF_LIBFDT_OVERLAY=y
> > +CONFIG_DM_RESET=y
> >   CONFIG_DEBUG_UART_BASE=0xfffff200
> >   CONFIG_DEBUG_UART_CLOCK=200000000
> >   CONFIG_DEBUG_UART_BOARD_INIT=y
> > @@ -87,14 +88,13 @@ CONFIG_PHY_MICREL=y
> >   CONFIG_MACB=y
> >   CONFIG_PINCTRL=y
> >   CONFIG_PINCTRL_AT91=y
> > +CONFIG_RESET_AT91=y
> >   CONFIG_DM_SERIAL=y
> >   CONFIG_DEBUG_UART_ANNOUNCE=y
> >   CONFIG_ATMEL_USART=y
> >   CONFIG_SPI=y
> >   CONFIG_DM_SPI=y
> >   CONFIG_ATMEL_QSPI=y
> > -CONFIG_SYSRESET=y
> > -CONFIG_SYSRESET_AT91=y
> >   CONFIG_TIMER=y
> >   CONFIG_ATMEL_PIT_TIMER=y
> >   CONFIG_W1=y
> > diff --git a/configs/sam9x60ek_nandflash_defconfig b/configs/sam9x60ek_nandflash_defconfig
> > index c6c4686658..acaa16ee49 100644
> > --- a/configs/sam9x60ek_nandflash_defconfig
> > +++ b/configs/sam9x60ek_nandflash_defconfig
> > @@ -14,6 +14,7 @@ CONFIG_DM_GPIO=y
> >   CONFIG_DEFAULT_DEVICE_TREE="sam9x60ek"
> >   CONFIG_SYS_PROMPT="U-Boot> "
> >   CONFIG_OF_LIBFDT_OVERLAY=y
> > +CONFIG_DM_RESET=y
> >   CONFIG_DEBUG_UART_BASE=0xfffff200
> >   CONFIG_DEBUG_UART_CLOCK=200000000
> >   CONFIG_DEBUG_UART_BOARD_INIT=y
> > @@ -89,14 +90,13 @@ CONFIG_PHY_MICREL=y
> >   CONFIG_MACB=y
> >   CONFIG_PINCTRL=y
> >   CONFIG_PINCTRL_AT91=y
> > +CONFIG_RESET_AT91=y
> >   CONFIG_DM_SERIAL=y
> >   CONFIG_DEBUG_UART_ANNOUNCE=y
> >   CONFIG_ATMEL_USART=y
> >   CONFIG_SPI=y
> >   CONFIG_DM_SPI=y
> >   CONFIG_ATMEL_QSPI=y
> > -CONFIG_SYSRESET=y
> > -CONFIG_SYSRESET_AT91=y
> >   CONFIG_TIMER=y
> >   CONFIG_ATMEL_PIT_TIMER=y
> >   CONFIG_W1=y
> > diff --git a/configs/sam9x60ek_qspiflash_defconfig b/configs/sam9x60ek_qspiflash_defconfig
> > index ef2e2db8b8..6fb79214e5 100644
> > --- a/configs/sam9x60ek_qspiflash_defconfig
> > +++ b/configs/sam9x60ek_qspiflash_defconfig
> > @@ -14,6 +14,7 @@ CONFIG_DM_GPIO=y
> >   CONFIG_DEFAULT_DEVICE_TREE="sam9x60ek"
> >   CONFIG_SYS_PROMPT="U-Boot> "
> >   CONFIG_OF_LIBFDT_OVERLAY=y
> > +CONFIG_DM_RESET=y
> >   CONFIG_DEBUG_UART_BASE=0xfffff200
> >   CONFIG_DEBUG_UART_CLOCK=200000000
> >   CONFIG_DEBUG_UART_BOARD_INIT=y
> > @@ -88,14 +89,13 @@ CONFIG_PHY_MICREL=y
> >   CONFIG_MACB=y
> >   CONFIG_PINCTRL=y
> >   CONFIG_PINCTRL_AT91=y
> > +CONFIG_RESET_AT91=y
> >   CONFIG_DM_SERIAL=y
> >   CONFIG_DEBUG_UART_ANNOUNCE=y
> >   CONFIG_ATMEL_USART=y
> >   CONFIG_SPI=y
> >   CONFIG_DM_SPI=y
> >   CONFIG_ATMEL_QSPI=y
> > -CONFIG_SYSRESET=y
> > -CONFIG_SYSRESET_AT91=y
> >   CONFIG_TIMER=y
> >   CONFIG_ATMEL_PIT_TIMER=y
> >   CONFIG_W1=y
> 
