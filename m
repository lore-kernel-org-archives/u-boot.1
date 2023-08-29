Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB7AC6FA8F
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 19:14:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45F2F8056D;
	Tue, 29 Aug 2023 21:14:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=null.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=null.net header.i=ivo.ivanov@null.net header.b="bHufmHgw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F12388056D; Tue, 29 Aug 2023 21:14:00 +0200 (CEST)
Received: from mout.gmx.com (mout.gmx.com [74.208.4.201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7FCA803AB
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 21:13:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=null.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ivo.ivanov@null.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=null.net;
 s=s1089575; t=1693336436; x=1693941236; i=ivo.ivanov@null.net;
 bh=KTlbeSWdKmgNNpQN2xqjJLDvnfqpUEgN+rQmK34PaF4=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=bHufmHgwwk6OEWF3D2Ae5lqDCz/6rkQMKOIDvkyM/dHOdEsr3qj8C85/yL574jHdSqkBG1n
 +rsytsDXrWlXgBVVzHcsibZVUh9Pj88xCs8KB/hX+kX1edPpQrJE1ltA0aNMCRdOhvKabL5ig
 av/F4nkpAzfeL7MH8Y8ItuPQrTkGf6Cbpjw3mpQODpPFqDTXRSimdR/tA3vs4Wa7Uk3y+m2Ry
 uH7ct3hCuInyTsl4S5BKzO5kraJkXe/K1smgEg4VMlar96/2dWufdItlOB7HzlKuN5wBgwQvX
 hehY/371heUC+fyCSGCkK+VuavyO1wcSAQ8bV28ZtY++7k1y2hNw==
X-UI-Sender-Class: f2cb72be-343f-493d-8ec3-b1efb8d6185a
Received: from [192.168.1.106] ([91.139.201.119]) by smtp.mail.com (mrgmxus003
 [74.208.5.15]) with ESMTPSA (Nemesis) id 0MKow2-1qb49z3H3Q-0008AH;
 Tue, 29 Aug 2023 21:13:56 +0200
Message-ID: <0c9cea14-cb3f-d3bb-98f6-2d0907b7cb79@null.net>
Date: Tue, 29 Aug 2023 22:13:53 +0300
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
From: Ivaylo Ivanov <ivo.ivanov@null.net>
In-Reply-To: <878r9trbfn.fsf@bloch.sibelius.xs4all.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9oqqAY+5cCAICF+FDd9WyktcPkfh9Qpsv/5uhDpesrjT5/Pkl3E
 itKjayhtxIA3YohL7ne9dRdHm1Gdibk8rMSYqZtcmmSYO/Lx5NpwLG2HA3GQRTr09UXKTwf
 ggnSPqN/TIF86O482dcWvJI9A4asN6O0RtrF4tuHM6gTcrpRg/37vlApctWXdhsbas8D8NH
 riS3p6VrxqdedPK0ep0ZA==
UI-OutboundReport: notjunk:1;M01:P0:WzzYN20wWGI=;v1UKkZcPhssO9Uai7nX5hRgch1I
 JJVv9YCyUDj4vkWlOLYHElRHkPJnfGZ/j/mZiRPkyudKeJ17NwGnRdN9bWO+js54lYJuAdBDi
 NX0QqhrkidiVusfoCUbxIjGaYYyLugIq1DuvJ3OFivsBF4mDqcKznnHQjDiMPDGYqo8OuQqwn
 z/tvBL6Yd96ijG7iwSvZhNOiREK2+ZWEUIVz8er4x+xlOzQ4uLV6NNitrakR1SZbfTsi1+tkt
 9J+hRglLrqvfuUqJFnevktEjqco6ABu7Xnfy4LetPppEe/juvg2KvYoDU7bXJU/nGu8W2c9zn
 3Qbb7vZkVMRhSyToDUL8VazttuQLY1dfz1Q4yEgRayizInvcAhltEJ0Q3HhmbVf5wZPQNtoaY
 jZRPtSwso+oWRUXTqvra8SvzTLMcsuzKi51RZ9zrB4PL/R6mricgR4Q67Dj5kmN8A7pgMD5Fr
 KsUyvqkVsGgFn4mvk18DGhzsx7SKQ7CM4ypk9fS5SC38KrR5pQeS+BL0fhHu2ibrQvncsRdWm
 7/KBX51vZ04ulo1lG+0pBM2arhQz9L6ePK8IBmaOLXpF9hmN7G6pwl2jAm1nSuMEv9skUPImR
 Pq3GckYq9iqnV4mySOrNumJohOIM7AIvI3Tf/s1k5QJ22jqlRC07yfMzfwL0IHskDtC6PsWC9
 AtFUDwLhGO/XbPgyZoGAs9IVywlkUlLadGb/sf1bkwQ5IoOiCv8kIWl6zRQjQRpkkMTmHILy/
 HFxhdvHv4C4K4gfIgU/ZgynGiXs0juSwRSKGHbDreB/D9B+wZvqa7blMozjRzu/m9DCZPj2Te
 IOOklfDB6ihXpDleCYDssu4Ss8ivMCH1733h27Dh6w3Ql/7+MAw98byE59YTv3OEAua+lRoUW
 gPKObwnPwCrb1bFJp7m5wP1/GSCZaP7wfQq/XJetWBNrb7oo/3nwaVHSDC71B+/nFQC766ASJ
 8N7MxX5+qrGFW13JWnYqGxOVNvY=
X-Mailman-Approved-At: Tue, 29 Aug 2023 21:14:19 +0200
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

I'm currently working on S5L8950X. I also have some T7000 and T8010
devices that I'll work on in the future.

There's a project called freemyipod that has a fork of U-Boot working on
iPod Nano's (specifically the S5L8730 in the iPod Nano 5). I've read
that they're planning on upstreaming it in the near future.

On 8/29/23 20:43, Mark Kettenis wrote:
>> From: ivo.ivanov@null.net
>> Date: Tue, 29 Aug 2023 20:25:19 +0300
>>
>> From: Ivaylo Ivanov <ivo.ivanov@null.net>
>>
>> Currently, mach-apple assumes we're working with M1/M2. Make room for
>> adding support for other Apple SoCs by moving everything from the M1/M2
>> SoC family in "mach-apple/" into "mach-apple/m1/".
>
> Which other Apple SoCs?
>
>> Signed-off-by: Ivaylo Ivanov <ivo.ivanov@null.net>
>> ---
>>  arch/arm/Kconfig                             | 29 --------------
>>  arch/arm/mach-apple/Kconfig                  | 42 ++++++++++++++++++++
>>  arch/arm/mach-apple/Makefile                 |  5 +--
>>  arch/arm/mach-apple/m1/Makefile              |  6 +++
>>  arch/arm/mach-apple/{ =3D> m1}/board.c         |  0
>>  arch/arm/mach-apple/{ =3D> m1}/lowlevel_init.S |  0
>>  arch/arm/mach-apple/{ =3D> m1}/rtkit.c         |  0
>>  arch/arm/mach-apple/{ =3D> m1}/sart.c          |  0
>>  configs/apple_m1_defconfig                   |  1 +
>>  9 files changed, 50 insertions(+), 33 deletions(-)
>>  create mode 100644 arch/arm/mach-apple/m1/Makefile
>>  rename arch/arm/mach-apple/{ =3D> m1}/board.c (100%)
>>  rename arch/arm/mach-apple/{ =3D> m1}/lowlevel_init.S (100%)
>>  rename arch/arm/mach-apple/{ =3D> m1}/rtkit.c (100%)
>>  rename arch/arm/mach-apple/{ =3D> m1}/sart.c (100%)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 97c25b4f14..5339da370c 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -980,38 +980,9 @@ config ARCH_NPCM
>>
>>  config ARCH_APPLE
>>  	bool "Apple SoCs"
>> -	select ARM64
>> -	select CLK
>> -	select CMD_PCI
>> -	select CMD_USB
>>  	select DM
>> -	select DM_GPIO
>> -	select DM_KEYBOARD
>> -	select DM_MAILBOX
>>  	select DM_RESET
>>  	select DM_SERIAL
>> -	select DM_SPI
>> -	select DM_USB
>> -	select VIDEO
>> -	select IOMMU
>> -	select LINUX_KERNEL_IMAGE_HEADER
>> -	select OF_BOARD_SETUP
>> -	select OF_CONTROL
>> -	select PCI
>> -	select PINCTRL
>> -	select POSITION_INDEPENDENT
>> -	select POWER_DOMAIN
>> -	select REGMAP
>> -	select SPI
>> -	select SYSCON
>> -	select SYSRESET
>> -	select SYSRESET_WATCHDOG
>> -	select SYSRESET_WATCHDOG_AUTO
>> -	select USB
>> -	imply CMD_DM
>> -	imply CMD_GPT
>> -	imply DISTRO_DEFAULTS
>> -	imply OF_HAS_PRIOR_STAGE
>>
>>  config ARCH_OWL
>>  	bool "Actions Semi OWL SoCs"
>> diff --git a/arch/arm/mach-apple/Kconfig b/arch/arm/mach-apple/Kconfig
>> index 294690ec0e..a38779b387 100644
>> --- a/arch/arm/mach-apple/Kconfig
>> +++ b/arch/arm/mach-apple/Kconfig
>> @@ -3,6 +3,46 @@ if ARCH_APPLE
>>  config TEXT_BASE
>>  	default 0x00000000
>>
>> +choice
>> +	prompt "Apple Silicon architecture type select"
>> +	optional
>> +
>> +config ARCH_APPLE_M1
>> +	bool "Apple M1/M2 SoC family"
>> +	select ARM64
>> +	select CLK
>> +	select CMD_PCI
>> +	select CMD_USB
>> +	select DM_GPIO
>> +	select DM_KEYBOARD
>> +	select DM_MAILBOX
>> +	select DM_SPI
>> +	select DM_USB
>> +	select VIDEO
>> +	select IOMMU
>> +	select LINUX_KERNEL_IMAGE_HEADER
>> +	select OF_BOARD_SETUP
>> +	select OF_CONTROL
>> +	select PCI
>> +	select PINCTRL
>> +	select POSITION_INDEPENDENT
>> +	select POWER_DOMAIN
>> +	select REGMAP
>> +	select SPI
>> +	select SYSCON
>> +	select SYSRESET
>> +	select SYSRESET_WATCHDOG
>> +	select SYSRESET_WATCHDOG_AUTO
>> +	select USB
>> +	imply CMD_DM
>> +	imply CMD_GPT
>> +	imply DISTRO_DEFAULTS
>> +	imply OF_HAS_PRIOR_STAGE
>> +
>> +endchoice
>> +
>> +if ARCH_APPLE_M1
>> +
>>  config SYS_CONFIG_NAME
>>  	default "apple"
>>
>> @@ -19,3 +59,5 @@ config LNX_KRNL_IMG_TEXT_OFFSET_BASE
>>  	default TEXT_BASE
>>
>>  endif
>> +
>> +endif
>> diff --git a/arch/arm/mach-apple/Makefile b/arch/arm/mach-apple/Makefil=
e
>> index 50b465b947..d147ccdde2 100644
>> --- a/arch/arm/mach-apple/Makefile
>> +++ b/arch/arm/mach-apple/Makefile
>> @@ -1,6 +1,3 @@
>>  # SPDX-License-Identifier: GPL-2.0+
>>
>> -obj-y +=3D board.o
>> -obj-y +=3D lowlevel_init.o
>> -obj-y +=3D rtkit.o
>> -obj-$(CONFIG_NVME_APPLE) +=3D sart.o
>> +obj-$(CONFIG_ARCH_APPLE_M1) +=3D m1/
>> diff --git a/arch/arm/mach-apple/m1/Makefile b/arch/arm/mach-apple/m1/M=
akefile
>> new file mode 100644
>> index 0000000000..50b465b947
>> --- /dev/null
>> +++ b/arch/arm/mach-apple/m1/Makefile
>> @@ -0,0 +1,6 @@
>> +# SPDX-License-Identifier: GPL-2.0+
>> +
>> +obj-y +=3D board.o
>> +obj-y +=3D lowlevel_init.o
>> +obj-y +=3D rtkit.o
>> +obj-$(CONFIG_NVME_APPLE) +=3D sart.o
>> diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/m1/board=
.c
>> similarity index 100%
>> rename from arch/arm/mach-apple/board.c
>> rename to arch/arm/mach-apple/m1/board.c
>> diff --git a/arch/arm/mach-apple/lowlevel_init.S b/arch/arm/mach-apple/=
m1/lowlevel_init.S
>> similarity index 100%
>> rename from arch/arm/mach-apple/lowlevel_init.S
>> rename to arch/arm/mach-apple/m1/lowlevel_init.S
>> diff --git a/arch/arm/mach-apple/rtkit.c b/arch/arm/mach-apple/m1/rtkit=
.c
>> similarity index 100%
>> rename from arch/arm/mach-apple/rtkit.c
>> rename to arch/arm/mach-apple/m1/rtkit.c
>> diff --git a/arch/arm/mach-apple/sart.c b/arch/arm/mach-apple/m1/sart.c
>> similarity index 100%
>> rename from arch/arm/mach-apple/sart.c
>> rename to arch/arm/mach-apple/m1/sart.c
>> diff --git a/configs/apple_m1_defconfig b/configs/apple_m1_defconfig
>> index 755560971e..bd723881da 100644
>> --- a/configs/apple_m1_defconfig
>> +++ b/configs/apple_m1_defconfig
>> @@ -1,5 +1,6 @@
>>  CONFIG_ARM=3Dy
>>  CONFIG_ARCH_APPLE=3Dy
>> +CONFIG_ARCH_APPLE_M1=3Dy
>>  CONFIG_DEFAULT_DEVICE_TREE=3D"t8103-j274"
>>  CONFIG_SYS_LOAD_ADDR=3D0x0
>>  CONFIG_USE_PREBOOT=3Dy
>> --
>> 2.34.1
>>
>>
