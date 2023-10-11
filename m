Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29E1CD98C7
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 04:42:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A51186B6D;
	Wed, 11 Oct 2023 06:42:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=null.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=null.net header.i=ivo.ivanov@null.net header.b="aPe56BOO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 758C586B75; Wed, 11 Oct 2023 06:42:48 +0200 (CEST)
Received: from mout.gmx.com (mout.gmx.com [74.208.4.201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D36586A02
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 06:42:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=null.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ivo.ivanov@null.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=null.net; s=s1089575;
 t=1696999363; x=1697604163; i=ivo.ivanov@null.net;
 bh=6Euta1TLSPf4SPgt0q8JtHOYoJgt0nnruqun/q3aYYk=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=aPe56BOOtNbZO+jBgqmIMIIlrP+ZL8L6EqqMNTY6D1VXiH4Mu/FUEh47USsRLDvbXE7lWoTsRHW
 h2TlXDRL84eZZ3/UcJzJySA2CVYtMaKlO8JSMGOG+QTokyhNFbDldDTG7qLXJYf7g8TEQ2BQiZX4U
 plo1+zcwxx9PJW7V02eBM3I9+0o2P3u4/708JDUeSmF7x74A1NiIqiRWnppN45wYdYaEdEuPOPxeh
 uUnX6nAkgkVnzWIX/AQjoYqgORfBlE/2c2gREl4AIPPdnnVDc9+vYTpl1H9ox38N2G91nLhWf0/Fe
 hvxHfcfOEFUUe7JkkbJZPybZ6KXgtJ50FBzw==
X-UI-Sender-Class: f2cb72be-343f-493d-8ec3-b1efb8d6185a
Received: from [192.168.1.106] ([91.139.201.119]) by smtp.mail.com (mrgmxus005
 [74.208.5.15]) with ESMTPSA (Nemesis) id 0LpcuW-1rSWxw2c8U-00fUSY;
 Wed, 11 Oct 2023 06:42:42 +0200
Message-ID: <8699bfe7-af80-eaeb-c6af-5d97a598f1ec@null.net>
Date: Wed, 11 Oct 2023 07:42:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] arm: mach-apple: Move M1/M2 specifics into a separate
 folder
Content-Language: en-US
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: u-boot@lists.denx.de, kettenis@openbsd.org
References: <20230829172519.72803-1-ivo.ivanov@null.net>
 <878r9trbfn.fsf@bloch.sibelius.xs4all.nl>
 <0c9cea14-cb3f-d3bb-98f6-2d0907b7cb79@null.net>
 <87wmvufa8f.fsf@bloch.sibelius.xs4all.nl>
From: Ivaylo Ivanov <ivo.ivanov@null.net>
In-Reply-To: <87wmvufa8f.fsf@bloch.sibelius.xs4all.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+3rQQ7qa3XIAsuIcp1pNq/gg7yVcNrqtqRy2sESfwZKiHcoBMA5
 AzOnu1hZzxvmqGar/XU/fEdB2AjrRFoVSCCrzQijC2S9L54KlIhhm0AZ37EdXVbNAzzOjhm
 ej9CtmHe2gvx2Kgv96V+l+ugx+IeTiuro2tsoCOKTALnHxukKe0uG7POR9gQ2XgxladE4kS
 OwyG75R1cs1s5P3a+Kcog==
UI-OutboundReport: notjunk:1;M01:P0:wsq0VlPoQ3o=;GqLs2bytqD4Awpkxy5NT9ldhqvK
 coY87GBxxPUoOEq0yMCxIUMO4C4iCru2Kr4dtWrJGQ72Nw9FnVsOl+x7Vd0M5CZRPcDHJXs7D
 XTz6FU+u3s0k0RuXU37I77o1fwrgMvDPIRwk3/E8lTZ/QNmCnQXVCYq2CC7/2SmU/YPBt707g
 acVywxWg6xstbFoi0SpEIBlEBJRDft/UD5I+t/Cm9fliydz5aZSq37oiRwRn3HN+2R+PPfG1x
 k/yaMZK2qIx3OLfGviD0BJh4cYIJuWTJWCJonjHYA4V6uGXGws9OKJB4J5F22jvWf05zyRUI3
 E5w6wpnh96vCnVVhhS6f5EAT8bLIU82PXwTNhOPQizur02kJjnYSGVCoDdzN/tDvtocyU4CE2
 94kKuk/I9TBBcC+VbbN6fB+CDsqs1iKM5a3d4PwTAGPRxEutBvsMhYepZzaw6XY0eVzIstIwW
 vnn5g1tCgIbFFSXIim0XxOYtQgINsHM2jNr+wMmOm5O/ff0EQWzaNBzGDqB+p9SXDcyJVaRLq
 XovhEJeCJ3C3BbMl8OGlHFtRhz7PnnFT7UEaaKUH3QqvEk1nj3YOgMK6n8O3Rz6sNRkXtIpIT
 KWiuAyap9hFsYD3TmeEcHBfoc+loztGu6hfMR6a5w9EA7C22S4c4xrh4eGvf4/bFQvxOXsSMA
 64s1ObQqtk/kVMsREqdSOErZXg0GFRSz6TF8zNWg3nPkC0vzZGUcP9zuldRHLG6Z/y956ZRL/
 PFGXt5lUs3y26LMNvBKKuZFVe1kOcwGPvN2dX53YZvJMA1KoudJ9oEV1dpgLmS3eN2CO12wkS
 Ld5TlGkKp6Er/YD7cWEMGKdi6c97CieC6R4yrsTOgpLJfzCrDjaBmlh0B40mNfNa5+27csuo6
 obSDZVmLtHU/dBy0nVZ1j3PVdlcQs69ZvfooHwB2RBX1rCuZ4V+ooPrt3dbwVOrNMkPSmbMWD
 Y0HmxcFfqNwpZ2Lw6zGBSjLqQI4=
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

S5L8950X is definitely belongs to the mach-apple folder, since it's the
first truly apple-made SoC: it uses AIC, DART, Apple GPIO, etc etc. I
might be wrong but I haven't seen any references of RTKit on S5L8950X.

I have already have gotten u-boot working with AIC timer and partial
dwc2 support (plug-in detection works, not sure yet why it doesn't
expose a USB interface to my PC) on the iPhone 5. It's confirmed to also
work on the 5c, and with a few changes addresses-wise it also works on
A5. Here's a rough link to my changes (which are still to-be-improved)
on my github u-boot repo:
https://github.com/ivoszbg/u-boot/commit/e20958e142cb881488602b7e864c00073=
dfe32db

In my opinion, M1 support shouldn't have been placed in the mach-apple
folder like that in the first place. It's disrupting the work for a ton
of Apple SoCs, as if M1 is the only apple SoC in existence.

On 10/11/23 00:17, Mark Kettenis wrote:
>> Date: Tue, 29 Aug 2023 22:13:53 +0300
>> From: Ivaylo Ivanov <ivo.ivanov@null.net>
>>
>> I'm currently working on S5L8950X. I also have some T7000 and T8010
>> devices that I'll work on in the future.
>>
>> There's a project called freemyipod that has a fork of U-Boot working o=
n
>> iPod Nano's (specifically the S5L8730 in the iPod Nano 5). I've read
>> that they're planning on upstreaming it in the near future.
>
> ok, well, most of the code you're moving isn't really M1/M2 specific.
> Apple uses RTKit all over the place.  And some of the SoCs you mention
> are really close to M1/M2.  And the older ones have a lot of Samsung
> heritage so I'm not sure they belong under mach-apple ...
>
> Also, unless you actually have code to support other Apple SoCs, this
> just causes disruption for upstreaming more of the M1/M2 code.  So I
> think this is best left alone until you actually show your code and we
> can see how to integrate it.
>
>>
>> On 8/29/23 20:43, Mark Kettenis wrote:
>>>> From: ivo.ivanov@null.net
>>>> Date: Tue, 29 Aug 2023 20:25:19 +0300
>>>>
>>>> From: Ivaylo Ivanov <ivo.ivanov@null.net>
>>>>
>>>> Currently, mach-apple assumes we're working with M1/M2. Make room for
>>>> adding support for other Apple SoCs by moving everything from the M1/=
M2
>>>> SoC family in "mach-apple/" into "mach-apple/m1/".
>>>
>>> Which other Apple SoCs?
>>>
>>>> Signed-off-by: Ivaylo Ivanov <ivo.ivanov@null.net>
>>>> ---
>>>>  arch/arm/Kconfig                             | 29 --------------
>>>>  arch/arm/mach-apple/Kconfig                  | 42 ++++++++++++++++++=
++
>>>>  arch/arm/mach-apple/Makefile                 |  5 +--
>>>>  arch/arm/mach-apple/m1/Makefile              |  6 +++
>>>>  arch/arm/mach-apple/{ =3D> m1}/board.c         |  0
>>>>  arch/arm/mach-apple/{ =3D> m1}/lowlevel_init.S |  0
>>>>  arch/arm/mach-apple/{ =3D> m1}/rtkit.c         |  0
>>>>  arch/arm/mach-apple/{ =3D> m1}/sart.c          |  0
>>>>  configs/apple_m1_defconfig                   |  1 +
>>>>  9 files changed, 50 insertions(+), 33 deletions(-)
>>>>  create mode 100644 arch/arm/mach-apple/m1/Makefile
>>>>  rename arch/arm/mach-apple/{ =3D> m1}/board.c (100%)
>>>>  rename arch/arm/mach-apple/{ =3D> m1}/lowlevel_init.S (100%)
>>>>  rename arch/arm/mach-apple/{ =3D> m1}/rtkit.c (100%)
>>>>  rename arch/arm/mach-apple/{ =3D> m1}/sart.c (100%)
>>>>
>>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>>>> index 97c25b4f14..5339da370c 100644
>>>> --- a/arch/arm/Kconfig
>>>> +++ b/arch/arm/Kconfig
>>>> @@ -980,38 +980,9 @@ config ARCH_NPCM
>>>>
>>>>  config ARCH_APPLE
>>>>  	bool "Apple SoCs"
>>>> -	select ARM64
>>>> -	select CLK
>>>> -	select CMD_PCI
>>>> -	select CMD_USB
>>>>  	select DM
>>>> -	select DM_GPIO
>>>> -	select DM_KEYBOARD
>>>> -	select DM_MAILBOX
>>>>  	select DM_RESET
>>>>  	select DM_SERIAL
>>>> -	select DM_SPI
>>>> -	select DM_USB
>>>> -	select VIDEO
>>>> -	select IOMMU
>>>> -	select LINUX_KERNEL_IMAGE_HEADER
>>>> -	select OF_BOARD_SETUP
>>>> -	select OF_CONTROL
>>>> -	select PCI
>>>> -	select PINCTRL
>>>> -	select POSITION_INDEPENDENT
>>>> -	select POWER_DOMAIN
>>>> -	select REGMAP
>>>> -	select SPI
>>>> -	select SYSCON
>>>> -	select SYSRESET
>>>> -	select SYSRESET_WATCHDOG
>>>> -	select SYSRESET_WATCHDOG_AUTO
>>>> -	select USB
>>>> -	imply CMD_DM
>>>> -	imply CMD_GPT
>>>> -	imply DISTRO_DEFAULTS
>>>> -	imply OF_HAS_PRIOR_STAGE
>>>>
>>>>  config ARCH_OWL
>>>>  	bool "Actions Semi OWL SoCs"
>>>> diff --git a/arch/arm/mach-apple/Kconfig b/arch/arm/mach-apple/Kconfi=
g
>>>> index 294690ec0e..a38779b387 100644
>>>> --- a/arch/arm/mach-apple/Kconfig
>>>> +++ b/arch/arm/mach-apple/Kconfig
>>>> @@ -3,6 +3,46 @@ if ARCH_APPLE
>>>>  config TEXT_BASE
>>>>  	default 0x00000000
>>>>
>>>> +choice
>>>> +	prompt "Apple Silicon architecture type select"
>>>> +	optional
>>>> +
>>>> +config ARCH_APPLE_M1
>>>> +	bool "Apple M1/M2 SoC family"
>>>> +	select ARM64
>>>> +	select CLK
>>>> +	select CMD_PCI
>>>> +	select CMD_USB
>>>> +	select DM_GPIO
>>>> +	select DM_KEYBOARD
>>>> +	select DM_MAILBOX
>>>> +	select DM_SPI
>>>> +	select DM_USB
>>>> +	select VIDEO
>>>> +	select IOMMU
>>>> +	select LINUX_KERNEL_IMAGE_HEADER
>>>> +	select OF_BOARD_SETUP
>>>> +	select OF_CONTROL
>>>> +	select PCI
>>>> +	select PINCTRL
>>>> +	select POSITION_INDEPENDENT
>>>> +	select POWER_DOMAIN
>>>> +	select REGMAP
>>>> +	select SPI
>>>> +	select SYSCON
>>>> +	select SYSRESET
>>>> +	select SYSRESET_WATCHDOG
>>>> +	select SYSRESET_WATCHDOG_AUTO
>>>> +	select USB
>>>> +	imply CMD_DM
>>>> +	imply CMD_GPT
>>>> +	imply DISTRO_DEFAULTS
>>>> +	imply OF_HAS_PRIOR_STAGE
>>>> +
>>>> +endchoice
>>>> +
>>>> +if ARCH_APPLE_M1
>>>> +
>>>>  config SYS_CONFIG_NAME
>>>>  	default "apple"
>>>>
>>>> @@ -19,3 +59,5 @@ config LNX_KRNL_IMG_TEXT_OFFSET_BASE
>>>>  	default TEXT_BASE
>>>>
>>>>  endif
>>>> +
>>>> +endif
>>>> diff --git a/arch/arm/mach-apple/Makefile b/arch/arm/mach-apple/Makef=
ile
>>>> index 50b465b947..d147ccdde2 100644
>>>> --- a/arch/arm/mach-apple/Makefile
>>>> +++ b/arch/arm/mach-apple/Makefile
>>>> @@ -1,6 +1,3 @@
>>>>  # SPDX-License-Identifier: GPL-2.0+
>>>>
>>>> -obj-y +=3D board.o
>>>> -obj-y +=3D lowlevel_init.o
>>>> -obj-y +=3D rtkit.o
>>>> -obj-$(CONFIG_NVME_APPLE) +=3D sart.o
>>>> +obj-$(CONFIG_ARCH_APPLE_M1) +=3D m1/
>>>> diff --git a/arch/arm/mach-apple/m1/Makefile b/arch/arm/mach-apple/m1=
/Makefile
>>>> new file mode 100644
>>>> index 0000000000..50b465b947
>>>> --- /dev/null
>>>> +++ b/arch/arm/mach-apple/m1/Makefile
>>>> @@ -0,0 +1,6 @@
>>>> +# SPDX-License-Identifier: GPL-2.0+
>>>> +
>>>> +obj-y +=3D board.o
>>>> +obj-y +=3D lowlevel_init.o
>>>> +obj-y +=3D rtkit.o
>>>> +obj-$(CONFIG_NVME_APPLE) +=3D sart.o
>>>> diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/m1/boa=
rd.c
>>>> similarity index 100%
>>>> rename from arch/arm/mach-apple/board.c
>>>> rename to arch/arm/mach-apple/m1/board.c
>>>> diff --git a/arch/arm/mach-apple/lowlevel_init.S b/arch/arm/mach-appl=
e/m1/lowlevel_init.S
>>>> similarity index 100%
>>>> rename from arch/arm/mach-apple/lowlevel_init.S
>>>> rename to arch/arm/mach-apple/m1/lowlevel_init.S
>>>> diff --git a/arch/arm/mach-apple/rtkit.c b/arch/arm/mach-apple/m1/rtk=
it.c
>>>> similarity index 100%
>>>> rename from arch/arm/mach-apple/rtkit.c
>>>> rename to arch/arm/mach-apple/m1/rtkit.c
>>>> diff --git a/arch/arm/mach-apple/sart.c b/arch/arm/mach-apple/m1/sart=
.c
>>>> similarity index 100%
>>>> rename from arch/arm/mach-apple/sart.c
>>>> rename to arch/arm/mach-apple/m1/sart.c
>>>> diff --git a/configs/apple_m1_defconfig b/configs/apple_m1_defconfig
>>>> index 755560971e..bd723881da 100644
>>>> --- a/configs/apple_m1_defconfig
>>>> +++ b/configs/apple_m1_defconfig
>>>> @@ -1,5 +1,6 @@
>>>>  CONFIG_ARM=3Dy
>>>>  CONFIG_ARCH_APPLE=3Dy
>>>> +CONFIG_ARCH_APPLE_M1=3Dy
>>>>  CONFIG_DEFAULT_DEVICE_TREE=3D"t8103-j274"
>>>>  CONFIG_SYS_LOAD_ADDR=3D0x0
>>>>  CONFIG_USE_PREBOOT=3Dy
>>>> --
>>>> 2.34.1
>>>>
>>>>
>>
