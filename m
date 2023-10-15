Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A700CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 19:49:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8125D86B8F;
	Sun, 15 Oct 2023 21:49:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="sIgrjoTk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12B0C8691E; Sun, 15 Oct 2023 21:49:42 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF40F8692B
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 21:49:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: ee18aa29-6b93-11ee-90ec-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id ee18aa29-6b93-11ee-90ec-00505699b430;
 Sun, 15 Oct 2023 21:49:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=Sgp5Pa3f1vCciIUrgNDGnPsyeAn581tr5+NO9KXM2Xg=;
 b=sIgrjoTkNQXnBVdJPQNvXuFxnMB386z6C5O53mBaXsNSsQFdsXK/WUH1EUPvZIanrgAdY/hQmU/tn
 mMc980YFUx1/HS47Ne2lBZW659PZMWdaqUJtgTeNkYySqA+0P8v2Dv1jLvv6vXu/BS3DTOXSgLPeV9
 +uV7y5agY3hsROzEYWwVueLvuFf/T9Yf342ocWS9xGOLQ6TSHJnYVe/abaopTp7JkykOMSS/7oC3ft
 9bZvso9SVBULnupseRcPW55lDTgR2ypHtQRu6Got/sDk8Is2LL0YU9O70fzdiJiEVI+I6DRbLjBwm9
 WGPldrjFMgIB+F24eoQbF8ltsCHcGhA==
X-KPN-MID: 33|NmdNRcOa7lfaH16OpsbCdDV4DyI4bMgef4EZUFfOe7GUgl8QNZZpSTW906O9xr0
 heAd0XqCuhCGQDG94z34wrguHVD+6lkAoz/cXfbKPSpo=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|SOPrTxRWPWBCaJ3puo1KxPB7svoq4Vs3rTQaNxqdi3BKv7F3i2BltCIYFaFKYXW
 o2Ad8iAjKN+8fuH/jWW0kow==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id f1962be0-6b93-11ee-ac7a-00505699b758;
 Sun, 15 Oct 2023 21:49:25 +0200 (CEST)
Date: Sun, 15 Oct 2023 21:49:25 +0200
Message-Id: <87zg0jr7i2.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Ivaylo Ivanov <ivo.ivanov@null.net>
Cc: u-boot@lists.denx.de, kettenis@openbsd.org
In-Reply-To: <8699bfe7-af80-eaeb-c6af-5d97a598f1ec@null.net> (message from
 Ivaylo Ivanov on Wed, 11 Oct 2023 07:42:39 +0300)
Subject: Re: [PATCH] arm: mach-apple: Move M1/M2 specifics into a separate
 folder
References: <20230829172519.72803-1-ivo.ivanov@null.net>
 <878r9trbfn.fsf@bloch.sibelius.xs4all.nl>
 <0c9cea14-cb3f-d3bb-98f6-2d0907b7cb79@null.net>
 <87wmvufa8f.fsf@bloch.sibelius.xs4all.nl>
 <8699bfe7-af80-eaeb-c6af-5d97a598f1ec@null.net>
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

> Date: Wed, 11 Oct 2023 07:42:39 +0300
> From: Ivaylo Ivanov <ivo.ivanov@null.net>
> 
> S5L8950X is definitely belongs to the mach-apple folder, since it's the
> first truly apple-made SoC: it uses AIC, DART, Apple GPIO, etc etc. I
> might be wrong but I haven't seen any references of RTKit on S5L8950X.

Yes your device tree has:

    compatible = "samsung,s5l8950", "samsung,s5l89xx";

I do understand that it is hard to tell when Apple hardware changed
from being a Samsung SoC with some Apple hardware blocks into an Apple
SoC with some Samsung hardware blocks.  U-Boot typically follows the
precedent set by the Linux kernel.  So if you're also planning to
upstream Linux support for these devices, it probably is best to sort
this out with the Linux maintainers first.

The U-Boot support for mach-apple was never intended to be
M1-specific.  The goal was always to support a wider range with a
single board.c file as long as that makes sense.  That probably
doesn't make sense for 32-bit SoCs like yours.  And if there are
significant differences in the way U-Boot is started on iPhone/iPad
platforms we probably need a different set of files and configs as
well.

So my preferred approach would be to park this diff until a later
stage where it is more obvious what the best way to split things up
is.

> I have already have gotten u-boot working with AIC timer and partial
> dwc2 support (plug-in detection works, not sure yet why it doesn't
> expose a USB interface to my PC) on the iPhone 5. It's confirmed to also
> work on the 5c, and with a few changes addresses-wise it also works on
> A5. Here's a rough link to my changes (which are still to-be-improved)
> on my github u-boot repo:
> https://github.com/ivoszbg/u-boot/commit/e20958e142cb881488602b7e864c00073dfe32db

Most of the stuff in your board.c file probably doesn't belong there,
but in separate clock and USB glue drivers.

> In my opinion, M1 support shouldn't have been placed in the mach-apple
> folder like that in the first place. It's disrupting the work for a ton
> of Apple SoCs, as if M1 is the only apple SoC in existence.
> 
> On 10/11/23 00:17, Mark Kettenis wrote:
> >> Date: Tue, 29 Aug 2023 22:13:53 +0300
> >> From: Ivaylo Ivanov <ivo.ivanov@null.net>
> >>
> >> I'm currently working on S5L8950X. I also have some T7000 and T8010
> >> devices that I'll work on in the future.
> >>
> >> There's a project called freemyipod that has a fork of U-Boot working on
> >> iPod Nano's (specifically the S5L8730 in the iPod Nano 5). I've read
> >> that they're planning on upstreaming it in the near future.
> >
> > ok, well, most of the code you're moving isn't really M1/M2 specific.
> > Apple uses RTKit all over the place.  And some of the SoCs you mention
> > are really close to M1/M2.  And the older ones have a lot of Samsung
> > heritage so I'm not sure they belong under mach-apple ...
> >
> > Also, unless you actually have code to support other Apple SoCs, this
> > just causes disruption for upstreaming more of the M1/M2 code.  So I
> > think this is best left alone until you actually show your code and we
> > can see how to integrate it.
> >
> >>
> >> On 8/29/23 20:43, Mark Kettenis wrote:
> >>>> From: ivo.ivanov@null.net
> >>>> Date: Tue, 29 Aug 2023 20:25:19 +0300
> >>>>
> >>>> From: Ivaylo Ivanov <ivo.ivanov@null.net>
> >>>>
> >>>> Currently, mach-apple assumes we're working with M1/M2. Make room for
> >>>> adding support for other Apple SoCs by moving everything from the M1/M2
> >>>> SoC family in "mach-apple/" into "mach-apple/m1/".
> >>>
> >>> Which other Apple SoCs?
> >>>
> >>>> Signed-off-by: Ivaylo Ivanov <ivo.ivanov@null.net>
> >>>> ---
> >>>>  arch/arm/Kconfig                             | 29 --------------
> >>>>  arch/arm/mach-apple/Kconfig                  | 42 ++++++++++++++++++++
> >>>>  arch/arm/mach-apple/Makefile                 |  5 +--
> >>>>  arch/arm/mach-apple/m1/Makefile              |  6 +++
> >>>>  arch/arm/mach-apple/{ => m1}/board.c         |  0
> >>>>  arch/arm/mach-apple/{ => m1}/lowlevel_init.S |  0
> >>>>  arch/arm/mach-apple/{ => m1}/rtkit.c         |  0
> >>>>  arch/arm/mach-apple/{ => m1}/sart.c          |  0
> >>>>  configs/apple_m1_defconfig                   |  1 +
> >>>>  9 files changed, 50 insertions(+), 33 deletions(-)
> >>>>  create mode 100644 arch/arm/mach-apple/m1/Makefile
> >>>>  rename arch/arm/mach-apple/{ => m1}/board.c (100%)
> >>>>  rename arch/arm/mach-apple/{ => m1}/lowlevel_init.S (100%)
> >>>>  rename arch/arm/mach-apple/{ => m1}/rtkit.c (100%)
> >>>>  rename arch/arm/mach-apple/{ => m1}/sart.c (100%)
> >>>>
> >>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> >>>> index 97c25b4f14..5339da370c 100644
> >>>> --- a/arch/arm/Kconfig
> >>>> +++ b/arch/arm/Kconfig
> >>>> @@ -980,38 +980,9 @@ config ARCH_NPCM
> >>>>
> >>>>  config ARCH_APPLE
> >>>>  	bool "Apple SoCs"
> >>>> -	select ARM64
> >>>> -	select CLK
> >>>> -	select CMD_PCI
> >>>> -	select CMD_USB
> >>>>  	select DM
> >>>> -	select DM_GPIO
> >>>> -	select DM_KEYBOARD
> >>>> -	select DM_MAILBOX
> >>>>  	select DM_RESET
> >>>>  	select DM_SERIAL
> >>>> -	select DM_SPI
> >>>> -	select DM_USB
> >>>> -	select VIDEO
> >>>> -	select IOMMU
> >>>> -	select LINUX_KERNEL_IMAGE_HEADER
> >>>> -	select OF_BOARD_SETUP
> >>>> -	select OF_CONTROL
> >>>> -	select PCI
> >>>> -	select PINCTRL
> >>>> -	select POSITION_INDEPENDENT
> >>>> -	select POWER_DOMAIN
> >>>> -	select REGMAP
> >>>> -	select SPI
> >>>> -	select SYSCON
> >>>> -	select SYSRESET
> >>>> -	select SYSRESET_WATCHDOG
> >>>> -	select SYSRESET_WATCHDOG_AUTO
> >>>> -	select USB
> >>>> -	imply CMD_DM
> >>>> -	imply CMD_GPT
> >>>> -	imply DISTRO_DEFAULTS
> >>>> -	imply OF_HAS_PRIOR_STAGE
> >>>>
> >>>>  config ARCH_OWL
> >>>>  	bool "Actions Semi OWL SoCs"
> >>>> diff --git a/arch/arm/mach-apple/Kconfig b/arch/arm/mach-apple/Kconfig
> >>>> index 294690ec0e..a38779b387 100644
> >>>> --- a/arch/arm/mach-apple/Kconfig
> >>>> +++ b/arch/arm/mach-apple/Kconfig
> >>>> @@ -3,6 +3,46 @@ if ARCH_APPLE
> >>>>  config TEXT_BASE
> >>>>  	default 0x00000000
> >>>>
> >>>> +choice
> >>>> +	prompt "Apple Silicon architecture type select"
> >>>> +	optional
> >>>> +
> >>>> +config ARCH_APPLE_M1
> >>>> +	bool "Apple M1/M2 SoC family"
> >>>> +	select ARM64
> >>>> +	select CLK
> >>>> +	select CMD_PCI
> >>>> +	select CMD_USB
> >>>> +	select DM_GPIO
> >>>> +	select DM_KEYBOARD
> >>>> +	select DM_MAILBOX
> >>>> +	select DM_SPI
> >>>> +	select DM_USB
> >>>> +	select VIDEO
> >>>> +	select IOMMU
> >>>> +	select LINUX_KERNEL_IMAGE_HEADER
> >>>> +	select OF_BOARD_SETUP
> >>>> +	select OF_CONTROL
> >>>> +	select PCI
> >>>> +	select PINCTRL
> >>>> +	select POSITION_INDEPENDENT
> >>>> +	select POWER_DOMAIN
> >>>> +	select REGMAP
> >>>> +	select SPI
> >>>> +	select SYSCON
> >>>> +	select SYSRESET
> >>>> +	select SYSRESET_WATCHDOG
> >>>> +	select SYSRESET_WATCHDOG_AUTO
> >>>> +	select USB
> >>>> +	imply CMD_DM
> >>>> +	imply CMD_GPT
> >>>> +	imply DISTRO_DEFAULTS
> >>>> +	imply OF_HAS_PRIOR_STAGE
> >>>> +
> >>>> +endchoice
> >>>> +
> >>>> +if ARCH_APPLE_M1
> >>>> +
> >>>>  config SYS_CONFIG_NAME
> >>>>  	default "apple"
> >>>>
> >>>> @@ -19,3 +59,5 @@ config LNX_KRNL_IMG_TEXT_OFFSET_BASE
> >>>>  	default TEXT_BASE
> >>>>
> >>>>  endif
> >>>> +
> >>>> +endif
> >>>> diff --git a/arch/arm/mach-apple/Makefile b/arch/arm/mach-apple/Makefile
> >>>> index 50b465b947..d147ccdde2 100644
> >>>> --- a/arch/arm/mach-apple/Makefile
> >>>> +++ b/arch/arm/mach-apple/Makefile
> >>>> @@ -1,6 +1,3 @@
> >>>>  # SPDX-License-Identifier: GPL-2.0+
> >>>>
> >>>> -obj-y += board.o
> >>>> -obj-y += lowlevel_init.o
> >>>> -obj-y += rtkit.o
> >>>> -obj-$(CONFIG_NVME_APPLE) += sart.o
> >>>> +obj-$(CONFIG_ARCH_APPLE_M1) += m1/
> >>>> diff --git a/arch/arm/mach-apple/m1/Makefile b/arch/arm/mach-apple/m1/Makefile
> >>>> new file mode 100644
> >>>> index 0000000000..50b465b947
> >>>> --- /dev/null
> >>>> +++ b/arch/arm/mach-apple/m1/Makefile
> >>>> @@ -0,0 +1,6 @@
> >>>> +# SPDX-License-Identifier: GPL-2.0+
> >>>> +
> >>>> +obj-y += board.o
> >>>> +obj-y += lowlevel_init.o
> >>>> +obj-y += rtkit.o
> >>>> +obj-$(CONFIG_NVME_APPLE) += sart.o
> >>>> diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/m1/board.c
> >>>> similarity index 100%
> >>>> rename from arch/arm/mach-apple/board.c
> >>>> rename to arch/arm/mach-apple/m1/board.c
> >>>> diff --git a/arch/arm/mach-apple/lowlevel_init.S b/arch/arm/mach-apple/m1/lowlevel_init.S
> >>>> similarity index 100%
> >>>> rename from arch/arm/mach-apple/lowlevel_init.S
> >>>> rename to arch/arm/mach-apple/m1/lowlevel_init.S
> >>>> diff --git a/arch/arm/mach-apple/rtkit.c b/arch/arm/mach-apple/m1/rtkit.c
> >>>> similarity index 100%
> >>>> rename from arch/arm/mach-apple/rtkit.c
> >>>> rename to arch/arm/mach-apple/m1/rtkit.c
> >>>> diff --git a/arch/arm/mach-apple/sart.c b/arch/arm/mach-apple/m1/sart.c
> >>>> similarity index 100%
> >>>> rename from arch/arm/mach-apple/sart.c
> >>>> rename to arch/arm/mach-apple/m1/sart.c
> >>>> diff --git a/configs/apple_m1_defconfig b/configs/apple_m1_defconfig
> >>>> index 755560971e..bd723881da 100644
> >>>> --- a/configs/apple_m1_defconfig
> >>>> +++ b/configs/apple_m1_defconfig
> >>>> @@ -1,5 +1,6 @@
> >>>>  CONFIG_ARM=y
> >>>>  CONFIG_ARCH_APPLE=y
> >>>> +CONFIG_ARCH_APPLE_M1=y
> >>>>  CONFIG_DEFAULT_DEVICE_TREE="t8103-j274"
> >>>>  CONFIG_SYS_LOAD_ADDR=0x0
> >>>>  CONFIG_USE_PREBOOT=y
> >>>> --
> >>>> 2.34.1
> >>>>
> >>>>
> >>
> 
