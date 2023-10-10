Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C14CCD98C5
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 21:17:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC804869CD;
	Tue, 10 Oct 2023 23:17:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="eLtfc9mT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B775686B29; Tue, 10 Oct 2023 23:17:40 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE702864A0
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 23:17:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 6d9a54fd-67b2-11ee-90ec-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 6d9a54fd-67b2-11ee-90ec-00505699b430;
 Tue, 10 Oct 2023 23:17:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=2BolB8QAvvmI76+nAresX+6xPowj9H8eBXIbT1W06Js=;
 b=eLtfc9mTWOqgRWUWNMBtOhF4gXDhIV+Wc1FT/7Ec3OT5kzbFopYAqpUPUuESwt2oI1cs60dBrGZPv
 gJ1qJGPOxLGBCMxRD3JhmwlvubR3n1m1wP+ljj4c2f0iQoXv5zpqWwadt3gzmfY3aRjFcZCcPfH1VU
 Uq5wPFeD3NRKzmp6EHPbz2UT3T5eJAluvR5KlzY2pQK4NcEte1tqp5syqVq9pcYY7rHHP1+osLhKK+
 U7C4SrQt6mDenIvJk7g0sajpPuOaraf/Vx4wV2y1ymDdoV7KlGAnBWs5+GUBwqhMLME//hK+ZAvIAn
 q5c++inp1vBkf1tQir3CqHQ+s3O6htw==
X-KPN-MID: 33|EfNSqll7wrHsVrgy5BZDlIUurqzTTh3JndsAc4xQS+xkiY4BbTue4VqLTs0vjmJ
 USxWtP9LLlyHy9akF8Lf4J2Th9EOlEyRbRmvspQzSbYs=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|JuhWdg9nDldNU0zS5nuMezvCVB9JKSzTUbtAjd7n/g5LFvycgPvvbVl0CCaBNVh
 1bNBp+P7meMqi3pEyxmwsUw==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 6f65a6c7-67b2-11ee-ac79-00505699b758;
 Tue, 10 Oct 2023 23:17:37 +0200 (CEST)
Date: Tue, 10 Oct 2023 23:17:36 +0200
Message-Id: <87wmvufa8f.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Ivaylo Ivanov <ivo.ivanov@null.net>
Cc: u-boot@lists.denx.de, kettenis@openbsd.org
In-Reply-To: <0c9cea14-cb3f-d3bb-98f6-2d0907b7cb79@null.net> (message from
 Ivaylo Ivanov on Tue, 29 Aug 2023 22:13:53 +0300)
Subject: Re: [PATCH] arm: mach-apple: Move M1/M2 specifics into a separate
 folder
References: <20230829172519.72803-1-ivo.ivanov@null.net>
 <878r9trbfn.fsf@bloch.sibelius.xs4all.nl>
 <0c9cea14-cb3f-d3bb-98f6-2d0907b7cb79@null.net>
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

> Date: Tue, 29 Aug 2023 22:13:53 +0300
> From: Ivaylo Ivanov <ivo.ivanov@null.net>
> 
> I'm currently working on S5L8950X. I also have some T7000 and T8010
> devices that I'll work on in the future.
> 
> There's a project called freemyipod that has a fork of U-Boot working on
> iPod Nano's (specifically the S5L8730 in the iPod Nano 5). I've read
> that they're planning on upstreaming it in the near future.

ok, well, most of the code you're moving isn't really M1/M2 specific.
Apple uses RTKit all over the place.  And some of the SoCs you mention
are really close to M1/M2.  And the older ones have a lot of Samsung
heritage so I'm not sure they belong under mach-apple ...

Also, unless you actually have code to support other Apple SoCs, this
just causes disruption for upstreaming more of the M1/M2 code.  So I
think this is best left alone until you actually show your code and we
can see how to integrate it.

> 
> On 8/29/23 20:43, Mark Kettenis wrote:
> >> From: ivo.ivanov@null.net
> >> Date: Tue, 29 Aug 2023 20:25:19 +0300
> >>
> >> From: Ivaylo Ivanov <ivo.ivanov@null.net>
> >>
> >> Currently, mach-apple assumes we're working with M1/M2. Make room for
> >> adding support for other Apple SoCs by moving everything from the M1/M2
> >> SoC family in "mach-apple/" into "mach-apple/m1/".
> >
> > Which other Apple SoCs?
> >
> >> Signed-off-by: Ivaylo Ivanov <ivo.ivanov@null.net>
> >> ---
> >>  arch/arm/Kconfig                             | 29 --------------
> >>  arch/arm/mach-apple/Kconfig                  | 42 ++++++++++++++++++++
> >>  arch/arm/mach-apple/Makefile                 |  5 +--
> >>  arch/arm/mach-apple/m1/Makefile              |  6 +++
> >>  arch/arm/mach-apple/{ => m1}/board.c         |  0
> >>  arch/arm/mach-apple/{ => m1}/lowlevel_init.S |  0
> >>  arch/arm/mach-apple/{ => m1}/rtkit.c         |  0
> >>  arch/arm/mach-apple/{ => m1}/sart.c          |  0
> >>  configs/apple_m1_defconfig                   |  1 +
> >>  9 files changed, 50 insertions(+), 33 deletions(-)
> >>  create mode 100644 arch/arm/mach-apple/m1/Makefile
> >>  rename arch/arm/mach-apple/{ => m1}/board.c (100%)
> >>  rename arch/arm/mach-apple/{ => m1}/lowlevel_init.S (100%)
> >>  rename arch/arm/mach-apple/{ => m1}/rtkit.c (100%)
> >>  rename arch/arm/mach-apple/{ => m1}/sart.c (100%)
> >>
> >> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> >> index 97c25b4f14..5339da370c 100644
> >> --- a/arch/arm/Kconfig
> >> +++ b/arch/arm/Kconfig
> >> @@ -980,38 +980,9 @@ config ARCH_NPCM
> >>
> >>  config ARCH_APPLE
> >>  	bool "Apple SoCs"
> >> -	select ARM64
> >> -	select CLK
> >> -	select CMD_PCI
> >> -	select CMD_USB
> >>  	select DM
> >> -	select DM_GPIO
> >> -	select DM_KEYBOARD
> >> -	select DM_MAILBOX
> >>  	select DM_RESET
> >>  	select DM_SERIAL
> >> -	select DM_SPI
> >> -	select DM_USB
> >> -	select VIDEO
> >> -	select IOMMU
> >> -	select LINUX_KERNEL_IMAGE_HEADER
> >> -	select OF_BOARD_SETUP
> >> -	select OF_CONTROL
> >> -	select PCI
> >> -	select PINCTRL
> >> -	select POSITION_INDEPENDENT
> >> -	select POWER_DOMAIN
> >> -	select REGMAP
> >> -	select SPI
> >> -	select SYSCON
> >> -	select SYSRESET
> >> -	select SYSRESET_WATCHDOG
> >> -	select SYSRESET_WATCHDOG_AUTO
> >> -	select USB
> >> -	imply CMD_DM
> >> -	imply CMD_GPT
> >> -	imply DISTRO_DEFAULTS
> >> -	imply OF_HAS_PRIOR_STAGE
> >>
> >>  config ARCH_OWL
> >>  	bool "Actions Semi OWL SoCs"
> >> diff --git a/arch/arm/mach-apple/Kconfig b/arch/arm/mach-apple/Kconfig
> >> index 294690ec0e..a38779b387 100644
> >> --- a/arch/arm/mach-apple/Kconfig
> >> +++ b/arch/arm/mach-apple/Kconfig
> >> @@ -3,6 +3,46 @@ if ARCH_APPLE
> >>  config TEXT_BASE
> >>  	default 0x00000000
> >>
> >> +choice
> >> +	prompt "Apple Silicon architecture type select"
> >> +	optional
> >> +
> >> +config ARCH_APPLE_M1
> >> +	bool "Apple M1/M2 SoC family"
> >> +	select ARM64
> >> +	select CLK
> >> +	select CMD_PCI
> >> +	select CMD_USB
> >> +	select DM_GPIO
> >> +	select DM_KEYBOARD
> >> +	select DM_MAILBOX
> >> +	select DM_SPI
> >> +	select DM_USB
> >> +	select VIDEO
> >> +	select IOMMU
> >> +	select LINUX_KERNEL_IMAGE_HEADER
> >> +	select OF_BOARD_SETUP
> >> +	select OF_CONTROL
> >> +	select PCI
> >> +	select PINCTRL
> >> +	select POSITION_INDEPENDENT
> >> +	select POWER_DOMAIN
> >> +	select REGMAP
> >> +	select SPI
> >> +	select SYSCON
> >> +	select SYSRESET
> >> +	select SYSRESET_WATCHDOG
> >> +	select SYSRESET_WATCHDOG_AUTO
> >> +	select USB
> >> +	imply CMD_DM
> >> +	imply CMD_GPT
> >> +	imply DISTRO_DEFAULTS
> >> +	imply OF_HAS_PRIOR_STAGE
> >> +
> >> +endchoice
> >> +
> >> +if ARCH_APPLE_M1
> >> +
> >>  config SYS_CONFIG_NAME
> >>  	default "apple"
> >>
> >> @@ -19,3 +59,5 @@ config LNX_KRNL_IMG_TEXT_OFFSET_BASE
> >>  	default TEXT_BASE
> >>
> >>  endif
> >> +
> >> +endif
> >> diff --git a/arch/arm/mach-apple/Makefile b/arch/arm/mach-apple/Makefile
> >> index 50b465b947..d147ccdde2 100644
> >> --- a/arch/arm/mach-apple/Makefile
> >> +++ b/arch/arm/mach-apple/Makefile
> >> @@ -1,6 +1,3 @@
> >>  # SPDX-License-Identifier: GPL-2.0+
> >>
> >> -obj-y += board.o
> >> -obj-y += lowlevel_init.o
> >> -obj-y += rtkit.o
> >> -obj-$(CONFIG_NVME_APPLE) += sart.o
> >> +obj-$(CONFIG_ARCH_APPLE_M1) += m1/
> >> diff --git a/arch/arm/mach-apple/m1/Makefile b/arch/arm/mach-apple/m1/Makefile
> >> new file mode 100644
> >> index 0000000000..50b465b947
> >> --- /dev/null
> >> +++ b/arch/arm/mach-apple/m1/Makefile
> >> @@ -0,0 +1,6 @@
> >> +# SPDX-License-Identifier: GPL-2.0+
> >> +
> >> +obj-y += board.o
> >> +obj-y += lowlevel_init.o
> >> +obj-y += rtkit.o
> >> +obj-$(CONFIG_NVME_APPLE) += sart.o
> >> diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/m1/board.c
> >> similarity index 100%
> >> rename from arch/arm/mach-apple/board.c
> >> rename to arch/arm/mach-apple/m1/board.c
> >> diff --git a/arch/arm/mach-apple/lowlevel_init.S b/arch/arm/mach-apple/m1/lowlevel_init.S
> >> similarity index 100%
> >> rename from arch/arm/mach-apple/lowlevel_init.S
> >> rename to arch/arm/mach-apple/m1/lowlevel_init.S
> >> diff --git a/arch/arm/mach-apple/rtkit.c b/arch/arm/mach-apple/m1/rtkit.c
> >> similarity index 100%
> >> rename from arch/arm/mach-apple/rtkit.c
> >> rename to arch/arm/mach-apple/m1/rtkit.c
> >> diff --git a/arch/arm/mach-apple/sart.c b/arch/arm/mach-apple/m1/sart.c
> >> similarity index 100%
> >> rename from arch/arm/mach-apple/sart.c
> >> rename to arch/arm/mach-apple/m1/sart.c
> >> diff --git a/configs/apple_m1_defconfig b/configs/apple_m1_defconfig
> >> index 755560971e..bd723881da 100644
> >> --- a/configs/apple_m1_defconfig
> >> +++ b/configs/apple_m1_defconfig
> >> @@ -1,5 +1,6 @@
> >>  CONFIG_ARM=y
> >>  CONFIG_ARCH_APPLE=y
> >> +CONFIG_ARCH_APPLE_M1=y
> >>  CONFIG_DEFAULT_DEVICE_TREE="t8103-j274"
> >>  CONFIG_SYS_LOAD_ADDR=0x0
> >>  CONFIG_USE_PREBOOT=y
> >> --
> >> 2.34.1
> >>
> >>
> 
