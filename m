Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B29C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 05:59:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61B798889C;
	Wed, 31 Jul 2024 07:59:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="LDjeJDNS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8888F8892B; Wed, 31 Jul 2024 07:59:32 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7EDB88886
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 07:59:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1722405559; x=1723010359; i=xypron.glpk@gmx.de;
 bh=4wEOMddhREEYS0tqhYWH/6uPI8BHB9ebp9Wk2holXRo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=LDjeJDNSecfYAH0QXLVq3Cdnz2wcayjLVbwwA86xsvJygoMvdWuAeCoJYmnL0uLe
 3DYsn3FJIVE5FHTffKV5L8wf0dhCE3q9ptWtrNypL6hSEtcev6QQ/VgEudXAKDPL8
 El5boR9K+GbB5g4yc6brPs5fLSasafNCxVYaIEuO3k47e7a3P98drjRb6s6HAQju8
 24EaVOu8TQwqw/kHWbfNIx8x1ahvAq3viBEFSpuKGAVAN+qizvF8uVWoi2MgCuhrr
 8UvDxb5e0KgBkzDTaZma9H1+vMRpvaXX8nS9t5pOwW+gmWuZqGK+moo3G0Pf1WYya
 HN6W/8LPTNTk7jh7xw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.93.80]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MK3Vu-1sq1ov1TWY-00UBhO; Wed, 31
 Jul 2024 07:59:19 +0200
Message-ID: <0546c5fe-d3b3-4ea7-b65b-215a8c8ff695@gmx.de>
Date: Wed, 31 Jul 2024 07:59:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] doc: stm32mp1: fix/improve basic reStructuredText
 syntax
To: Grzegorz Szymaszek <gszymaszek@short.pl>
References: <41ae952bf3f45545e3c6579463df3d0408f6343a.1722014005.git.gszymaszek@short.pl>
 <2ba7deb4a2ad7bd4216133a95031bbf626af9b1a.1722014005.git.gszymaszek@short.pl>
Content-Language: en-US
Cc: u-boot@lists.denx.de, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 uboot-stm32@st-md-mailman.stormreply.com
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <2ba7deb4a2ad7bd4216133a95031bbf626af9b1a.1722014005.git.gszymaszek@short.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Xl8NQ7qmGHXiKSv4/+K0HcVgUHavFpgqQoYKduiEkR9ykcMnkW2
 ciZYUn4ctxPzNrX38OeKUKs480WfqIfrXzQE7z9QRrpWcfOLqcoDeMdKb/6rvFuo71/eYHA
 5im0zB9xyufsg9Z5501bV6I0EBHrTbdwacA3mONBe3PTlEKNSztC2Olnwtw3TJvOeCpgOyf
 6UPSu55pisTRPpKCzEEQg==
UI-OutboundReport: notjunk:1;M01:P0:H2K0VgwBLfU=;GCem7fZ/8CmYw1VCmpkHpnOc1h0
 Nvx59DERK7pb1WXM8D+Xt2821jzOLFDAhl+0uuaTN1W4vzmbAoESNNQe9HOgwtj4R2pHlVTHp
 +jfPTfMhBOxBDLnHyZVpPkOYJnK4q/UABKldVu3/AKtcqaZ9Xx8UZc7Gl4zSeA1bhryqbxBp5
 Pmf1WE0kDkNOEgnfp10V8O8jj9y1tOKe/P/VMenG1ehd9GFUjszN5taBwF0F+JN7ogmZ3hwlN
 4EnXcOytTMEFBAvG+cBD0m32hsR/sMVRXTQBkfuLmAzDGJW4GnUC94GjPojQizET7jpqWPhvr
 8/iuJb0+y3hV6ibfLJBFnRXzcZb2D16oXiLxrzVzFuyP+Hqv6S2U3UZGp9wEYutT0iFtdk0sy
 uXnAyp+dWIZsy+SgjhzxS4q8Tx6Z5yisH6RTAflJEJik36MomjQs8Ni8b8sK6PYh/M5J31zG0
 OiLo27Wm52OJx0cbbfFLkDe47OXPV/Wy5CStpIiWw/FSAuzkvDFkrGBJNV3Phqb4+YFkpsl7N
 DPqmiRQTIr0O06pv1fIpgH2V7yWlMRVpSGXt/ex0zyCE+xqzzA/MS2XFnVJaKneQWGhfQlgA9
 Y28OSXPaa/2qyUNygNxc+AVZWPCVeGxyaKMleuPsZskQDcFJFKMjhrARdKY355mV+MWKIDFk4
 jjjF8BrmoAxmobn66Ta09qMfSDNq4pSFqaWb3Bkp0iWrDkXupbdRF5l7fvC+alRwgFkE2JDZe
 9IfppN6bpLfsF5UouulPR8u8GebQqHIZid+s5hzygI1Bbeemq/uNw7FH9rhxlYYKx4lQYmRCl
 ghG5oHCmbRfN/RJdYEBiCESw==
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

On 7/26/24 19:18, Grzegorz Szymaszek wrote:
> Drop some unnecessary/unintended blockquotes, improve formatting
> consistency, simplify tables, add some inline literals, fix several
> other minor issues.
>
> Signed-off-by: Grzegorz Szymaszek <gszymaszek@short.pl>
> ---
>   doc/board/st/stm32mp1.rst | 859 +++++++++++++++++++-------------------
>   1 file changed, 421 insertions(+), 438 deletions(-)
>
> diff --git a/doc/board/st/stm32mp1.rst b/doc/board/st/stm32mp1.rst
> index 98167e80618..fc5cc294b51 100644
> --- a/doc/board/st/stm32mp1.rst
> +++ b/doc/board/st/stm32mp1.rst
> @@ -6,20 +6,20 @@ STM32MP1xx boards
>
>   This is a quick instruction for setup STMicroelectronics STM32MP1xx bo=
ards.
>
> -Further information can be found in STMicroelectronics STM32 WIKI_.
> +Further information can be found in STMicroelectronics STM32 Wiki_.
>
>   Supported devices
>   -----------------
>
>   U-Boot supports all the STMicroelectronics MPU with the associated boa=
rds
>
> - - STMP32MP15x SoCs:
> +- STMP32MP15x SoCs:
>
>     - STM32MP157
>     - STM32MP153
>     - STM32MP151
>
> - - STMP32MP13x SoCs:
> +- STMP32MP13x SoCs:
>
>     - STM32MP135
>     - STM32MP133
> @@ -27,25 +27,25 @@ U-Boot supports all the STMicroelectronics MPU with =
the associated boards
>
>   Everything is supported in Linux but U-Boot is limited to the boot dev=
ice:
>
> - 1. UART
> - 2. SD card/MMC controller (SDMMC)
> - 3. NAND controller (FMC)
> - 4. NOR controller (QSPI)
> - 5. USB controller (OTG DWC2)
> - 6. Ethernet controller
> +1. UART
> +2. SD card/MMC controller (SDMMC)
> +3. NAND controller (FMC)
> +4. NOR controller (QSPI)
> +5. USB controller (OTG DWC2)
> +6. Ethernet controller

Why is this enumeration numbered?

>
>   And the necessary drivers
>
> - 1. I2C
> - 2. STPMIC1 (PMIC and regulator)
> - 3. Clock, Reset, Sysreset
> - 4. Fuse (BSEC)
> - 5. OP-TEE
> - 6. ETH
> - 7. USB host
> - 8. WATCHDOG
> - 9. RNG
> - 10. RTC
> +1. I2C
> +2. STPMIC1 (PMIC and regulator)
> +3. Clock, Reset, Sysreset
> +4. Fuse (BSEC)
> +5. OP-TEE
> +6. ETH
> +7. USB host
> +8. WATCHDOG
> +9. RNG
> +10. RTC

ditto

>
>   STM32MP15x
>   ``````````
> @@ -54,37 +54,38 @@ The STM32MP15x is a Cortex-A7 MPU aimed at various a=
pplications.
>
>   It features:
>
> - - Dual core Cortex-A7 application core (Single on STM32MP151)
> - - 2D/3D image composition with GPU (only on STM32MP157)
> - - Standard memories interface support
> - - Standard connectivity, widely inherited from the STM32 MCU family
> - - Comprehensive security support
> - - Cortex M4 coprocessor
> +- Dual core Cortex-A7 application core (Single on STM32MP151)
> +- 2D/3D image composition with GPU (only on STM32MP157)
> +- Standard memories interface support
> +- Standard connectivity, widely inherited from the STM32 MCU family
> +- Comprehensive security support
> +- Cortex M4 coprocessor
>
> -Each line comes with a security option (cryptography & secure boot) and
> -a Cortex-A frequency option:
> +Each line comes with a security option (cryptography & secure boot) and=
 a

%s/line/product line/

> +Cortex-A frequency option:
>
> - - A : Cortex-A7 @ 650 MHz
> - - C : Secure Boot + HW Crypto + Cortex-A7 @ 650 MHz
> - - D : Cortex-A7 @ 800 MHz
> - - F : Secure Boot + HW Crypto + Cortex-A7 @ 800 MHz
> +:A: Cortex-A7 @ 650 MHz
> +:C: Secure Boot + HW Crypto + Cortex-A7 @ 650 MHz
> +:D: Cortex-A7 @ 800 MHz
> +:F: Secure Boot + HW Crypto + Cortex-A7 @ 800 MHz

What does A, C, D, F relate to?

Do you mean:

STM32MP15A
STM32MP15C
STM32MP15D
STM32MP15F

If so, please, add the full name.

>
>   Currently the following boards are supported:
>
> - + stm32mp157a-dk1.dts
> - + stm32mp157c-dk2.dts
> - + stm32mp157c-ed1.dts
> - + stm32mp157c-ev1.dts
> - + stm32mp15xx-dhcor-avenger96.dts
> ++ stm32mp157a-dk1.dts
> ++ stm32mp157c-dk2.dts
> ++ stm32mp157c-ed1.dts
> ++ stm32mp157c-ev1.dts
> ++ stm32mp15xx-dhcor-avenger96.dts
>
>   The SCMI variant of each board is supported by a specific "scmi" devic=
e tree:

Why is this line indented which leads to rendering in bold?

> - + stm32mp157a-dk1-scmi.dts
> - + stm32mp157c-dk2-scmi.dts
> - + stm32mp157c-ed1-scmi.dts
> - + stm32mp157c-ev1-scmi.dts
> +
> ++ stm32mp157a-dk1-scmi.dts
> ++ stm32mp157c-dk2-scmi.dts
> ++ stm32mp157c-ed1-scmi.dts
> ++ stm32mp157c-ev1-scmi.dts
>
>   SCMI variant is used only with stm32mp15_defconfig, when the resources=
 are
> -secured with RCC_TZCR.TZEN=3D1 in OP-TEE. The access to these reset and=
 clock
> +secured with ``RCC_TZCR.TZEN=3D1`` in OP-TEE. The access to these reset=
 and clock
>   resources are provided by OP-TEE and the associated SCMI services.
>
>   STM32MP13x
> @@ -94,157 +95,163 @@ The STM32MP13x is a single Cortex-A7 MPU aimed at =
various applications.
>
>   Currently the following boards are supported:
>
> - + stm32mp135f-dk.dts
> -
> ++ stm32mp135f-dk.dts
>
>   Boot Sequences
>   --------------
>
>   2 boot configurations are supported with:
>
> -+----------+------------------------+-------------------------+--------=
------+
> -| **ROM**  | **FSBL**               | **SSBL**                | **OS** =
      |
> -+ **code** +------------------------+-------------------------+--------=
------+
> -|          | First Stage Bootloader | Second Stage Bootloader | Linux K=
ernel |
> -+          +------------------------+-------------------------+--------=
------+
> -|          | embedded RAM           | DDR                              =
      |
> -+----------+------------------------+-------------------------+--------=
------+
> -| TrustZone|                         secure monitor                    =
      |
> -+----------+------------------------+-------------------------+--------=
------+
> ++--------------+------------------------+-------------------------+----=
----------+
> +| **ROM code** | **FSBL**               | **SSBL**                | **O=
S**       |
> ++              +------------------------+-------------------------+----=
----------+
> +|              | First Stage Bootloader | Second Stage Bootloader | Lin=
ux Kernel |
> ++              +------------------------+-------------------------+----=
----------+
> +|              | embedded RAM           | DDR                          =
          |
> ++--------------+------------------------+-------------------------+----=
----------+
> +| TrustZone    | secure monitor                                        =
          |
> ++--------------+------------------------+-------------------------+----=
----------+
>
>   The trusted boot chain is recommended with:
>
> -- FSBL =3D **TF-A BL2**
> -- Secure monitor =3D **OP-TEE**
> -- SSBL =3D **U-Boot**
> +:FSBL: TF-A BL2
> +:Secure Monitor: OP-TEE
> +:SSBL: U-Boot
>
>   It is the only supported boot chain for STM32MP13x family.
>
> -The **Trusted** boot chain with TF-A_
> -`````````````````````````````````````
> +The Trusted boot chain with TF-A_
> +`````````````````````````````````
> +
> +defconfig_file:
>
> -defconfig_file :
> -   + **stm32mp15_defconfig**  and **stm32mp13_defconfig** (for TF-A_ wi=
th FIP support)
> -   + **stm32mp15_trusted_defconfig** (for TF-A_ without FIP support)
> ++ **stm32mp15_defconfig** and **stm32mp13_defconfig** (for TF-A_ with F=
IP
> +  support)
> ++ **stm32mp15_trusted_defconfig** (for TF-A_ without FIP support)
>
> -    +-------------+--------------------------+------------+-------+
> -    |  ROM code   | FSBL                     | SSBL       | OS    |
> -    +             +--------------------------+------------+-------+
> -    |             |Trusted Firmware-A (TF-A_)| U-Boot     | Linux |
> -    +-------------+--------------------------+------------+-------+
> -    | TrustZone   |secure monitor =3D SPMin or OP-TEE_              |
> -    +-------------+--------------------------+------------+-------+
> ++-----------+----------------------------+------------+-------+
> +| ROM code  | FSBL                       | SSBL       | OS    |
> ++           +----------------------------+------------+-------+
> +|           | Trusted Firmware-A (TF-A_) | U-Boot     | Linux |
> ++-----------+----------------------------+------------+-------+
> +| TrustZone | secure monitor =3D SPMin or OP-TEE_               |
> ++-----------+----------------------------+------------+-------+
>
> -TF-A_ and OP-TEE_ are 2 separate projects, with their git repository;
> -they are compiled separately.
> +TF-A_ and OP-TEE_ are 2 separate projects, with their git repository; t=
hey are
> +compiled separately.
>
> -TF-A_ (BL2) initialize the DDR and loads the next stage binaries from a=
 FIP file:
> -   + BL32: a secure monitor BL32 =3D SPMin provided by TF-A_ or OP-TEE_=
 :
> -     performs a full initialization of Secure peripherals and provides =
service
> -     to normal world
> -   + BL33: a non-trusted firmware =3D U-Boot, running in normal world a=
nd uses
> -     the secure monitor to access to secure resources.
> -   + HW_CONFIG: The hardware configuration file =3D the U-Boot device t=
ree
> +TF-A_ (BL2) initialize the DDR and loads the next stage binaries from a=
 FIP
> +file:
> +
> ++ BL32: a secure monitor BL32 =3D SPMin provided by TF-A_ or OP-TEE_: p=
erforms a
> +  full initialization of Secure peripherals and provides service to nor=
mal world
> ++ BL33: a non-trusted firmware =3D U-Boot, running in normal world and =
uses the
> +  secure monitor to access to secure resources.
> ++ HW_CONFIG: The hardware configuration file =3D the U-Boot device tree
>
>   The scmi variant of each device tree is only support with OP-TEE as se=
cure
>   monitor, with stm32mp15_defconfig.
>
> -The **Basic** boot chain with SPL (for STM32MP15x)
> -``````````````````````````````````````````````````
> +The Basic boot chain with SPL (for STM32MP15x)
> +``````````````````````````````````````````````
> +
> +defconfig_file:
>
> -defconfig_file :
> -   + **stm32mp15_basic_defconfig**
> ++ **stm32mp15_basic_defconfig**
>
> -    +-------------+------------+------------+-------+
> -    |  ROM code   | FSBL       | SSBL       | OS    |
> -    +             +------------+------------+-------+
> -    |             |U-Boot SPL  | U-Boot     | Linux |
> -    +-------------+------------+------------+-------+
> -    | TrustZone   |            | PSCI from U-Boot   |
> -    +-------------+------------+------------+-------+
> ++-----------+------------+------------+-------+
> +| ROM code  | FSBL       | SSBL       | OS    |
> ++           +------------+------------+-------+
> +|           | U-Boot SPL | U-Boot     | Linux |
> ++-----------+------------+------------+-------+
> +| TrustZone |            | PSCI from U-Boot   |
> ++-----------+------------+------------+-------+
>
>   SPL has limited security initialization.
>
> -U-Boot is running in secure mode and provide a secure monitor to the ke=
rnel
> -with only PSCI support (Power State Coordination Interface defined by A=
RM).
> +U-Boot is running in secure mode and provide a secure monitor to the ke=
rnel with
> +only PSCI support (Power State Coordination Interface defined by ARM).
>
> -.. warning:: This alternate **basic** boot chain with SPL is not suppor=
ted/promoted by STMicroelectronics to make product.
> +.. warning:: This alternate **basic** boot chain with SPL is not
> +   supported/promoted by STMicroelectronics to make product.

"to make product" does not sound like proper English.

Do you mean

"This alternative basic boot chain with SPL is neither endorsed nor
supported by STMicroelectronics for product development."

>
>   Device Tree
>   -----------
>
> -All the STM32MP15x and STM32MP13x boards supported by U-Boot use the sa=
me generic board
> -stm32mp1 which supports all the bootable devices.
> +All the STM32MP15x and STM32MP13x boards supported by U-Boot use the sa=
me
> +generic board stm32mp1 which supports all the bootable devices.
>
> -Each STMicroelectronics board is only configured with the associated de=
vice tree.
> +Each STMicroelectronics board is only configured with the associated de=
vice
> +tree.

This sentence is not understandable.

Do you mean

* Each board uses a specific device-tree which is selected by the board
specific defconfig.

or

* The board specific device-tree is selected by SPL.

>
>   STM32MP15x device Tree Selection
>   ````````````````````````````````
> -The supported device trees for STM32MP15x (stm32mp15_trusted_defconfig =
and stm32mp15_basic_defconfig) are:
> +
> +The supported device trees for STM32MP15x (stm32mp15_trusted_defconfig =
and
> +stm32mp15_basic_defconfig) are:
>
>   + ev1: eval board with pmic stpmic1 (ev1 =3D mother board + daughter e=
d1)
>
> -   + stm32mp157c-ev1
> +  + stm32mp157c-ev1
>
>   + ed1: daughter board with pmic stpmic1
>
> -   + stm32mp157c-ed1
> +  + stm32mp157c-ed1
>
>   + dk1: Discovery board
>
> -   + stm32mp157a-dk1
> +  + stm32mp157a-dk1
>
>   + dk2: Discovery board =3D dk1 with a BT/WiFI combo and a DSI panel
>
> -   + stm32mp157c-dk2
> +  + stm32mp157c-dk2
>
>   + avenger96: Avenger96 board from Arrow Electronics based on DH Elec. =
DHCOR SoM
>
> -   + stm32mp15xx-dhcor-avenger96
> +  + stm32mp15xx-dhcor-avenger96
>
>   STM32MP13x device Tree Selection
>   ````````````````````````````````
> +
>   The supported device trees for STM32MP13x (stm32mp13_defconfig) are:
>
>   + dk: Discovery board
>
> -   + stm32mp135f-dk
> -
> +  + stm32mp135f-dk
>
>   Build Procedure
>   ---------------
>
>   1. Install the required tools for U-Boot
>
> -   * install package needed in U-Boot makefile
> -     (libssl-dev, swig, libpython-dev...)
> -
> -   * install ARMv7 toolchain for 32bit Cortex-A (from Linaro,
> -     from SDK for STM32MP15x, or any crosstoolchains from your distribu=
tion)
> -     (you can use any gcc cross compiler compatible with U-Boot)
> +   * install package needed in U-Boot makefile (libssl-dev, swig,
> +     libpython-dev...)

You have to use the plural here:

"install packages needed by U-Boot's Makefile"

> +   * install ARMv7 toolchain for 32-bit Cortex-A (from Linaro, from SDK=
 for
> +     STM32MP15x, or any crosstoolchains from your distribution) (you ca=
n use any
> +     gcc cross compiler compatible with U-Boot)

Please, correct the capitalization and punctuation:

Install the ARMv7 toolchain for 32-bit Cortex-A (from Linaro, from the
SDK for STM32MP15x, or any cross toolchains from your distribution). You
can use any GCC cross-compiler compatible with U-Boot.

>
>   2. Set the cross compiler::
>
> -    # export CROSS_COMPILE=3D/path/to/toolchain/arm-linux-gnueabi-
> +       # export CROSS_COMPILE=3D/path/to/toolchain/arm-linux-gnueabi-
>
>   3. Select the output directory (optional)::
>
> -   # export KBUILD_OUTPUT=3D/path/to/output
> +       # export KBUILD_OUTPUT=3D/path/to/output
>
>      for example: use one output directory for each configuration::

Please, use either

.. code-block:: bash

or

.. prompt:: bash $

>
> -   # export KBUILD_OUTPUT=3Dstm32mp13
> -   # export KBUILD_OUTPUT=3Dstm32mp15
> -   # export KBUILD_OUTPUT=3Dstm32mp15_trusted
> -   # export KBUILD_OUTPUT=3Dstm32mp15_basic
> +       # export KBUILD_OUTPUT=3Dstm32mp13
> +       # export KBUILD_OUTPUT=3Dstm32mp15
> +       # export KBUILD_OUTPUT=3Dstm32mp15_trusted
> +       # export KBUILD_OUTPUT=3Dstm32mp15_basic

You should not suggest to build as root via the '#' prompt.

If you really want to display a prompt use, .. prompt::. This allows
copying the lines without the prompt.

Some readers may find a prompt just distractive.

>
>      you can build outside of code directory::
>
> -   # export KBUILD_OUTPUT=3D../build/stm32mp15
> +       # export KBUILD_OUTPUT=3D../build/stm32mp15
>
>   4. Configure U-Boot::
>
> -   # make <defconfig_file>
> +       # make <defconfig_file>
>
>      with <defconfig_file>:
>
> @@ -255,73 +262,71 @@ Build Procedure
>
>   5. Configure the device-tree and build the U-Boot image::
>
> -   # make DEVICE_TREE=3D<name> all
> +       # make DEVICE_TREE=3D<name> all
>
>      Examples:
>
> -  a) trusted boot with FIP on STM32MP15x ev1::
> +   a) trusted boot with FIP on STM32MP15x ev1::
>
> -     # export KBUILD_OUTPUT=3Dstm32mp15
> -     # make stm32mp15_defconfig
> -     # make DEVICE_TREE=3Dstm32mp157c-ev1-scmi all
> +          # export KBUILD_OUTPUT=3Dstm32mp15
> +          # make stm32mp15_defconfig
> +          # make DEVICE_TREE=3Dstm32mp157c-ev1-scmi all
>
> -    or without SCMI support::
> +      or without SCMI support::
>
> -     # export KBUILD_OUTPUT=3Dstm32mp15
> -     # make stm32mp15_defconfig
> -     # make DEVICE_TREE=3Dstm32mp157c-ev1 all
> +          # export KBUILD_OUTPUT=3Dstm32mp15
> +          # make stm32mp15_defconfig
> +          # make DEVICE_TREE=3Dstm32mp157c-ev1 all
>
> -  b) trusted boot on STM32MP13x discovery board::
> +   b) trusted boot on STM32MP13x discovery board::
>
> -     # export KBUILD_OUTPUT=3Dstm32mp13
> -     # make stm32mp13_defconfig
> -     # make DEVICE_TREE=3Dstm32mp135f-dk all
> +          # export KBUILD_OUTPUT=3Dstm32mp13
> +          # make stm32mp13_defconfig
> +          # make DEVICE_TREE=3Dstm32mp135f-dk all
>
> -    DEVICE_TEE selection is optional as stm32mp135f-dk is the default b=
oard of the defconfig::
> +      DEVICE_TEE selection is optional as stm32mp135f-dk is the default=
 board of
> +      the defconfig::
>
> -     # make stm32mp13_defconfig
> -     # make all
> +          # make stm32mp13_defconfig
> +          # make all
>
> -  c) basic boot on STM32MP15x ev1::
> +   c) basic boot on STM32MP15x ev1::
>
> -      # export KBUILD_OUTPUT=3Dstm32mp15_basic
> -      # make stm32mp15_basic_defconfig
> -      # make DEVICE_TREE=3Dstm32mp157c-ev1 all
> +          # export KBUILD_OUTPUT=3Dstm32mp15_basic
> +          # make stm32mp15_basic_defconfig
> +          # make DEVICE_TREE=3Dstm32mp157c-ev1 all
>
> -  d) basic boot on STM32MP15x ed1::
> +   d) basic boot on STM32MP15x ed1::
>
> -      # export KBUILD_OUTPUT=3Dstm32mp15_basic
> -      # make stm32mp15_basic_defconfig
> -      # make DEVICE_TREE=3Dstm32mp157c-ed1 all
> +          # export KBUILD_OUTPUT=3Dstm32mp15_basic
> +          # make stm32mp15_basic_defconfig
> +          # make DEVICE_TREE=3Dstm32mp157c-ed1 all
>
> -  e) basic boot on STM32MP15x dk1::
> +   e) basic boot on STM32MP15x dk1::
>
> -     # export KBUILD_OUTPUT=3Dstm32mp15_basic
> -     # make stm32mp15_basic_defconfig
> -     # make DEVICE_TREE=3Dstm32mp157a-dk1 all
> +          # export KBUILD_OUTPUT=3Dstm32mp15_basic
> +          # make stm32mp15_basic_defconfig
> +          # make DEVICE_TREE=3Dstm32mp157a-dk1 all
>
> -  f) basic boot on STM32MP15x avenger96::
> +   f) basic boot on STM32MP15x avenger96::
>
> -     # export KBUILD_OUTPUT=3Dstm32mp15_basic
> -     # make stm32mp15_basic_defconfig
> -     # make DEVICE_TREE=3Dstm32mp15xx-dhcor-avenger96 all
> +          # export KBUILD_OUTPUT=3Dstm32mp15_basic
> +          # make stm32mp15_basic_defconfig
> +          # make DEVICE_TREE=3Dstm32mp15xx-dhcor-avenger96 all
>
>   6. U-Boot Output files
>
> -   So in the output directory (selected by KBUILD_OUTPUT),
> -   you can found the needed U-Boot files:
> +   So in the output directory (selected by ``KBUILD_OUTPUT``), you can =
found the
> +   needed U-Boot files:
>
> -     - stm32mp13_defconfig =3D **u-boot-nodtb.bin** and **u-boot.dtb**
> -     - stm32mp15_defconfig =3D **u-boot-nodtb.bin** and **u-boot.dtb**
> +   - stm32mp13_defconfig =3D **u-boot-nodtb.bin** and **u-boot.dtb**
> +   - stm32mp15_defconfig =3D **u-boot-nodtb.bin** and **u-boot.dtb**
> +   - stm32mp15_trusted_defconfig =3D u-boot.stm32
> +   - stm32mp15_basic_defconfig
>
> -     - stm32mp15_trusted_defconfig =3D u-boot.stm32
> -
> -     - stm32mp15_basic_defconfig
> -
> -       - FSBL =3D spl/u-boot-spl.stm32
> -
> -       - SSBL =3D u-boot.img (without CONFIG_SPL_LOAD_FIT) or
> -                u-boot.itb (with CONFIG_SPL_LOAD_FIT=3Dy)
> +     - FSBL =3D spl/u-boot-spl.stm32
> +     - SSBL =3D u-boot.img (without ``CONFIG_SPL_LOAD_FIT``) or u-boot.=
itb (with
> +       ``CONFIG_SPL_LOAD_FIT=3Dy``)
>
>   7. TF-A_ compilation
>
> @@ -333,92 +338,80 @@ Build Procedure
>
>        - with OP-TEE_ support, compile the OP-TEE to generate the binary=
 included
>          in FIP
> -
>        - after TF-A compilation, the used  files are:
>
>          - TF-A_ BL2 =3D> FSBL =3D **tf-a.stm32**
> -
>          - FIP =3D> **fip.bin**
>
>            FIP file includes the 2 files given in arguments of TF-A_ com=
pilation:
>
> -        - BL33=3Du-boot-nodtb.bin
> -        - BL33_CFG=3Du-boot.dtb
> -
> -     You can also update a existing FIP after U-Boot compilation with f=
iptool,
> -     a tool provided by TF-A_::
> +         - ``BL33=3Du-boot-nodtb.bin``
> +         - ``BL33_CFG=3Du-boot.dtb``
>
> -     # fiptool update --nt-fw u-boot-nodtb.bin --hw-config u-boot.dtb f=
ip-stm32mp157c-ev1.bin
> +     You can also update a existing FIP after U-Boot compilation with f=
iptool, a

%s/a existing/an existing/

> +     tool provided by TF-A_::
>
> -   - For TF-A_ without FIP support : **stm32mp15_trusted_defconfig**
> -     SPMin is used and the used files are:
> +         # fiptool update --nt-fw u-boot-nodtb.bin --hw-config u-boot.d=
tb fip-stm32mp157c-ev1.bin
>
> -       - FSBL =3D **tf-a.stm32** (provided by TF-A_ compilation, conten=
ing BL2 and
> -         BL32 =3D SPMin)
> +   - For TF-A_ without FIP support : **stm32mp15_trusted_defconfig** SP=
Min is
> +     used and the used files are:
>
> -       - SSBL =3D **u-boot.stm32** used instead of fip.bin in next chap=
ters
> +     - FSBL =3D **tf-a.stm32** (provided by TF-A_ compilation, contenin=
g BL2 and
> +       BL32 =3D SPMin)
> +     - SSBL =3D **u-boot.stm32** used instead of fip.bin in next chapte=
rs
>
>   8. The bootloaders files
>
> -+ The **ROM code** expects FSBL binaries with STM32 image header =3D
> -  tf-a.stm32 or u-boot-spl.stm32
> +   + The **ROM code** expects FSBL binaries with STM32 image header =3D=
 tf-a.stm32
> +     or u-boot-spl.stm32
>
> -According the FSBL / the boot mode:
> +   According the FSBL / the boot mode:
>
> -+ **TF-A** expect a FIP binary =3D fip.bin, including the OS monitor (S=
PMin or
> -  OP-TEE_) and the U-Boot binary + device tree
> +   + **TF-A** expect a FIP binary =3D fip.bin, including the OS monitor=
 (SPMin or
> +     OP-TEE_) and the U-Boot binary + device tree
>
> -  or, without FIP support, binaries with STM32 image header: U-Boot
> -  =3D u-boot.stm32 and eventually  OP-TEE files (tee-header.stm32, tee-=
pageable.stm32,
> -  tee-pager.stm32)
> +   or, without FIP support, binaries with STM32 image header: U-Boot =
=3D
> +   u-boot.stm32 and eventually OP-TEE files (tee-header.stm32,
> +   tee-pageable.stm32, tee-pager.stm32)
>
> -+ **SPL** expects SSBL =3D U-Boot with uImage header =3D u-boot.img
> -  or FIT =3D u-boot.itb.
> +   + **SPL** expects SSBL =3D U-Boot with uImage header =3D u-boot.img =
or FIT =3D
> +     u-boot.itb.
>
>
>   Switch Setting for Boot Mode
>   ----------------------------
>
> -You can select the boot mode, on the board with one switch, to select
> -the boot pin values =3D BOOT0, BOOT1, BOOT2
> -
> -  +-------------+---------+---------+---------+
> -  |*Boot Mode*  | *BOOT2* | *BOOT1* | *BOOT0* |
> -  +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D+=
=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> -  | Recovery    |  0      |  0      |  0      |
> -  +-------------+---------+---------+---------+
> -  | NOR         |  0      |  0      |  1      |
> -  +-------------+---------+---------+---------+
> -  | eMMC        |  0      |  1      |  0      |
> -  +-------------+---------+---------+---------+
> -  | NAND        |  0      |  1      |  1      |
> -  +-------------+---------+---------+---------+
> -  | Reserved    |  1      |  0      |  0      |
> -  +-------------+---------+---------+---------+
> -  | SD-Card     |  1      |  0      |  1      |
> -  +-------------+---------+---------+---------+
> -  | Recovery    |  1      |  1      |  0      |
> -  +-------------+---------+---------+---------+
> -  | SPI-NAND    |  1      |  1      |  1      |
> -  +-------------+---------+---------+---------+
> +You can select the boot mode, on the board with one switch, to select t=
he boot
> +pin values =3D BOOT0, BOOT1, BOOT2
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=
=3D=3D=3D
> +Boot Mode  BOOT2  BOOT1  BOOT0
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=
=3D=3D=3D
> +Recovery   0      0      0
> +NOR        0      0      1
> +eMMC       0      1      0
> +NAND       0      1      1
> +Reserved   1      0      0
> +SD-Card    1      0      1
> +Recovery   1      1      0
> +SPI-NAND   1      1      1
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=
=3D=3D=3D

Why are you changing the table? In HTML both look the same. In an editor
the previous format is easier to read.

>
>   - on the STM32MP15x **daughter board ed1 =3D MB1263** with the switch =
SW1
> -- on STM32MP15x **Avenger96** with switch S3 (NOR and SPI-NAND are not =
applicable)
> -- on board STM32MP15x **DK1/DK2** with the switch SW1 =3D BOOT0, BOOT2
> -  with only 2 pins available (BOOT1 is forced to 0 and NOR not supporte=
d),
> -  the possible value becomes:
> -
> -    +-------------+---------+---------+
> -    |*Boot Mode*  | *BOOT2* | *BOOT0* |
> -    +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=
=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> -    | Recovery    |  0      |  0      |
> -    +-------------+---------+---------+
> -    | NOR     (NA)|  0      |  1      |
> -    +-------------+---------+---------+
> -    | Reserved    |  1      |  0      |
> -    +-------------+---------+---------+
> -    | SD-Card     |  1      |  1      |
> -    +-------------+---------+---------+
> +- on STM32MP15x **Avenger96** with switch S3 (NOR and SPI-NAND are not
> +  applicable)
> +- on board STM32MP15x **DK1/DK2** with the switch SW1 =3D BOOT0, BOOT2 =
with only 2
> +  pins available (BOOT1 is forced to 0 and NOR not supported), the poss=
ible
> +  value becomes:
> +
> +  =3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D
> +  Boot Mode  BOOT2  BOOT0
> +  =3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D
> +  Recovery   0      0
> +  NOR (NA)   0      1
> +  Reserved   1      0
> +  SD-Card    1      1
> +  =3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D
>
>   Recovery is a boot from serial link (UART/USB) and it is used with
>   STM32CubeProgrammer tool to load executable in RAM and to update the f=
lash
> @@ -426,8 +419,8 @@ devices available on the board (NOR/NAND/eMMC/SD car=
d).
>
>   The communication between HOST and board is based on
>
> -  - for UARTs : the uart protocol used with all MCU STM32
> -  - for USB : based on USB DFU 1.1 (without the ST extensions used on M=
CU STM32)
> +- for UARTs: the uart protocol used with all MCU STM32

%s/uart/UART/

> +- for USB: based on USB DFU 1.1 (without the ST extensions used on MCU =
STM32)
>
>   Prepare an SD card
>   ------------------
> @@ -436,103 +429,97 @@ The minimal requirements for STMP32MP15x and STM3=
2MP13x boot up to U-Boot are:
>
>   - GPT partitioning (with gdisk or with sgdisk)
>   - 2 fsbl partitions, named "fsbl1" and "fsbl2", size at least 256KiB
> -- one partition named "fip" for FIP or U-Boot (TF-A_ search the "fip"
> -  partition and SPL search the 3th partition, because
> -  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=3D3)
> +- one partition named "fip" for FIP or U-Boot (TF-A_ search the "fip" p=
artition
> +  and SPL search the 3th partition, because
> +  ``CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=3D3``)
>
>   The 2 fsbl partitions have the same content and are present to guarant=
ee a

%s/fsbl/FSBL/

> -fail-safe update of FSBL; fsbl2 can be omitted if this ROM code feature=
 is
> -not required.
> +fail-safe update of FSBL; fsbl2 can be omitted if this ROM code feature=
 is not
> +required.
>
> -Without FIP support in TF-A_, the 3rd partition "fip" for u-boot.stm32 =
must
> -be named "ssbl".
> +Without FIP support in TF-A_, the 3rd partition "fip" for u-boot.stm32 =
must be
> +named "ssbl".
>
>   Then the minimal GPT partition is:
>
>   For TF-A_ with FIP support:
>
> -  +-------+--------+---------+------------------------+
> -  | *Num* | *Name* | *Size*  | *Content*              |
> -  +=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=
=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D+
> -  | 1     | fsbl1  | 256 KiB | TF-A_ BL2 (tf-a.stm32) |
> -  +-------+--------+---------+------------------------+
> -  | 2     | fsbl2  | 256 KiB | TF-A_ BL2 (tf-a.stm32) |
> -  +-------+--------+---------+------------------------+
> -  | 3     | fip    | 4MB     | fip.bin                |
> -  +-------+--------+---------+------------------------+
> -  | 4     | <any>  | <any>   | Rootfs                 |
> -  +-------+--------+---------+------------------------+
> +=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Num  Name   Size     Content
> +=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +1    fsbl1  256=C2=A0KiB  TF-A_ BL2 (tf-a.stm32)
> +2    fsbl2  256=C2=A0KiB  TF-A_ BL2 (tf-a.stm32)
> +3    fip    4=C2=A0MiB    fip.bin
> +4    <any>  <any>    Rootfs
> +=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>   or:
>
> -  +-------+--------+---------+------------------------+----------------=
--------+
> -  | *Num* | *Name* | *Size*  | *Trusted boot content* | *Basic boot con=
tent*   |
> -  +=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=
=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D+
> -  | 1     | fsbl1  | 256 KiB | TF-A_ BL2 (tf-a.stm32) | SPL (u-boot-spl=
.stm32) |
> -  +-------+--------+---------+------------------------+----------------=
--------+
> -  | 2     | fsbl2  | 256 KiB | TF-A_ BL2 (tf-a.stm32) | SPL (u-boot-spl=
.stm32) |
> -  +-------+--------+---------+------------------------+----------------=
--------+
> -  | 3     | ssbl   | 2MB     | U-Boot (u-boot.stm32)  | U-Boot (u-boot.=
img)    |
> -  +-------+--------+---------+------------------------+----------------=
--------+
> -  | 4     | <any>  | <any>   | Rootfs                                  =
        |
> -  +-------+--------+---------+------------------------+----------------=
--------+
> +=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Num  Name   Size     Trusted boot content    Basic boot content
> +=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +1    fsbl1  256=C2=A0KiB  TF-A_ BL2 (tf-a.stm32)  SPL (u-boot-spl.stm32=
)
> +2    fsbl2  256=C2=A0KiB  TF-A_ BL2 (tf-a.stm32)  SPL (u-boot-spl.stm32=
)
> +3    ssbl   2=C2=A0MiB    U-Boot (u-boot.stm32)   U-Boot (u-boot.img)
> +4    <any>  <any>    Rootfs
> +=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>   And the 4th partition (Rootfs) is marked bootable with a file extlinux=
.conf
>   following the Generic Distribution feature (see :doc:`../../develop/di=
stro` for
>   use).
>
>   The size of fip or ssbl partition must be enough for the associated bi=
nary file,
> -4MB and 2MB are default values.
> +4=C2=A0MiB and 2=C2=A0MiB are default values.
>
> -According the used card reader select the correct block device
> -(for example /dev/sdx or /dev/mmcblk0), in the next example, it is /dev=
/mmcblk0
> +According the used card reader select the correct block device (for exa=
mple
> +/dev/sdx or /dev/mmcblk0), in the next example, it is /dev/mmcblk0
>
>   For example:
>
>   a) remove previous formatting::
>
> -     # sgdisk -o /dev/<SD card dev>
> +       # sgdisk -o /dev/<SD card dev>
>
>   b) create minimal image for FIP
>
>      For FIP support in TF-A_::
>
> -    # sgdisk --resize-table=3D128 -a 1 \
> -    -n 1:34:545		-c 1:fsbl1 \
> -    -n 2:546:1057		-c 2:fsbl2 \
> -    -n 3:1058:9249		-c 3:fip \
> -    -n 4:9250:			-c 4:rootfs -A 4:set:2 \
> -    -p /dev/<SD card dev>
> +       # sgdisk --resize-table=3D128 -a 1 \
> +         -n 1:34:545    -c 1:fsbl1 \
> +         -n 2:546:1057  -c 2:fsbl2 \
> +         -n 3:1058:9249 -c 3:fip \
> +         -n 4:9250:     -c 4:rootfs -A 4:set:2 \
> +         -p /dev/<SD card dev>
>
>      With gpt table with 128 entries an the partition 4 marked bootable =
(bit 2).
>
>      For basic boot mode or without FIP support in TF-A_::
>
> -    # sgdisk --resize-table=3D128 -a 1 \
> -    -n 1:34:545		-c 1:fsbl1 \
> -    -n 2:546:1057		-c 2:fsbl2 \
> -    -n 3:1058:5153		-c 3:ssbl \
> -    -n 4:5154:		    -c 4:rootfs -A 4:set:2 \
> -    -p /dev/<SD card dev>
> +       # sgdisk --resize-table=3D128 -a 1 \
> +         -n 1:34:545    -c 1:fsbl1 \
> +         -n 2:546:1057  -c 2:fsbl2 \
> +         -n 3:1058:5153 -c 3:ssbl \
> +         -n 4:5154:     -c 4:rootfs -A 4:set:2 \
> +         -p /dev/<SD card dev>
>
> -c) copy the FSBL (2 times) and SSBL file on the correct partition.
> -   in this example in partition 1 to 3
> +c) copy the FSBL (2 times) and SSBL file on the correct partition. In t=
his
> +   example in partition 1 to 3
>
> -   for trusted boot: ::
> +   for trusted boot::

.. code-block:: bash
or
.. prompt:: bash #

>
> -    # dd if=3Dtf-a.stm32 of=3D/dev/mmcblk0p1
> -    # dd if=3Dtf-a.stm32 of=3D/dev/mmcblk0p2
> -    # dd if=3Dfip.bin of=3D/dev/mmcblk0p3
> -      OR
> -      dd if=3Du-boot.stm32 of=3D/dev/mmcblk0p3 # Without FIT support
> +       # dd if=3Dtf-a.stm32 of=3D/dev/mmcblk0p1
> +       # dd if=3Dtf-a.stm32 of=3D/dev/mmcblk0p2
> +       # dd if=3Dfip.bin of=3D/dev/mmcblk0p3
> +         # OR
> +         dd if=3Du-boot.stm32 of=3D/dev/mmcblk0p3 # Without FIT support
>
> -   for basic boot mode : <SD card dev> =3D /dev/mmcblk0::
> +   for basic boot mode: <SD card dev> =3D /dev/mmcblk0::
>
> -    # dd if=3Du-boot-spl.stm32 of=3D/dev/mmcblk0p1
> -    # dd if=3Du-boot-spl.stm32 of=3D/dev/mmcblk0p2
> -    # dd if=3Du-boot.img of=3D/dev/mmcblk0p3 # Without CONFIG_SPL_LOAD_=
FIT
> -      OR
> -      dd if=3Du-boot.itb of=3D/dev/mmcblk0p3 # With CONFIG_SPL_LOAD_FIT=
=3Dy
> +       # dd if=3Du-boot-spl.stm32 of=3D/dev/mmcblk0p1
> +       # dd if=3Du-boot-spl.stm32 of=3D/dev/mmcblk0p2
> +       # dd if=3Du-boot.img of=3D/dev/mmcblk0p3 # Without CONFIG_SPL_LO=
AD_FIT
> +         # OR
> +         dd if=3Du-boot.itb of=3D/dev/mmcblk0p3 # With CONFIG_SPL_LOAD_=
FIT=3Dy
>
>   To boot from SD card, select BootPinMode =3D 1 0 1 and reset.
>
> @@ -541,45 +528,43 @@ Prepare eMMC
>
>   You can use U-Boot to copy binary in eMMC.

%s/copy binary in/copy the binary to eMMC/ ?

>
> -In the next example, you need to boot from SD card and the images
> -(tf-a.stm32, fip.bin / u-boot-spl.stm32, u-boot.img for systems without
> -CONFIG_SPL_LOAD_FIT or u-boot.itb for systems with CONFIG_SPL_LOAD_FIT=
=3Dy) are
> -presents on SD card (mmc 0) in ext4 partition 4 (bootfs)
> +In the next example, you need to boot from SD card and the images (tf-a=
.stm32,
> +fip.bin / u-boot-spl.stm32, u-boot.img for systems without CONFIG_SPL_L=
OAD_FIT
> +or u-boot.itb for systems with ``CONFIG_SPL_LOAD_FIT=3Dy``) are present=
s on SD
> +card (mmc 0) in ext4 partition 4 (bootfs)
>
>   To boot from SD card, select BootPinMode =3D 1 0 1 and reset.

This line should not be indented.

>
> -Then you update the eMMC with the next U-Boot command :
> +Then you update the eMMC with the next U-Boot command:

Stick to the imperative:

%s/Then you/Then/

>
> -a) prepare GPT on eMMC,
> -   example with 3 partitions, fip, bootfs and roots::
> +a) prepare GPT on eMMC, example with 3 partitions, fip, bootfs and root=
s::
>
> -    # setenv emmc_part "name=3Dfip,size=3D4MiB;name=3Dbootfs,type=3Dlin=
ux,bootable,size=3D64MiB;name=3Drootfs,type=3Dlinux,size=3D512"
> -    # gpt write mmc 1 ${emmc_part}
> +       # setenv emmc_part "name=3Dfip,size=3D4MiB;name=3Dbootfs,type=3D=
linux,bootable,size=3D64MiB;name=3Drootfs,type=3Dlinux,size=3D512"
> +       # gpt write mmc 1 ${emmc_part}
>
> -b) copy FSBL, TF-A_ or SPL, on first eMMC boot partition
> -   (SPL max size is 256kB, with LBA 512, 0x200)::
> +b) copy FSBL, TF-A_ or SPL, on first eMMC boot partition (SPL max size =
is
> +   256=C2=A0kB, with LBA 512, 0x200)::

I assume you mean 256 * 1024:

%s/kB/KiB/

>
> -    # ext4load mmc 0:4 0xC0000000 tf-a.stm32

Does ST really use the '#' as prompt in U-Boot?

I saw:
CONFIG_SYS_PROMPT=3D"STM32MP> "

Please, use

.. prompt::

> -    or
> -    # ext4load mmc 0:4 0xC0000000 u-boot-spl.stm32
> +       # ext4load mmc 0:4 0xC0000000 tf-a.stm32
> +         # or
> +       # ext4load mmc 0:4 0xC0000000 u-boot-spl.stm32
>
> -    # mmc dev 1
> -    # mmc partconf 1 1 1 1
> -    # mmc write ${fileaddr} 0 200
> -    # mmc partconf 1 1 1 0
> +       # mmc dev 1
> +       # mmc partconf 1 1 1 1
> +       # mmc write ${fileaddr} 0 200
> +       # mmc partconf 1 1 1 0
>
>   c) copy SSBL, FIP or U-Boot binary, in first GPT partition of eMMC::
>
> -    # ext4load mmc 0:4 0xC0000000 fip.bin
> -    or
> -    # ext4load mmc 0:4 0xC0000000 u-boot.img # Without CONFIG_SPL_LOAD_=
FIT
> -    or
> -    # ext4load mmc 0:4 0xC0000000 u-boot.itb # With CONFIG_SPL_LOAD_FIT=
=3Dy
> +       # ext4load mmc 0:4 0xC0000000 fip.bin
> +         # or
> +       # ext4load mmc 0:4 0xC0000000 u-boot.img # Without CONFIG_SPL_LO=
AD_FIT
> +         # or
> +       # ext4load mmc 0:4 0xC0000000 u-boot.itb # With CONFIG_SPL_LOAD_=
FIT=3Dy
>
> -
> -    # mmc dev 1
> -    # part start mmc 1 1 partstart
> -    # mmc write ${fileaddr} ${partstart} ${filesize}
> +       # mmc dev 1
> +       # part start mmc 1 1 partstart
> +       # mmc write ${fileaddr} ${partstart} ${filesize}
>
>   To boot from eMMC, select BootPinMode =3D 0 1 0 and reset.
>
> @@ -591,20 +576,20 @@ usage. Basically, environment has precedence over =
board specific storage.
>
>   For STMicroelectronics board, it is retrieved in:
>
> - - STM32MP15x OTP:
> +- STM32MP15x OTP:
>
> -   - OTP_57[31:0] =3D MAC_ADDR[31:0]
> -   - OTP_58[15:0] =3D MAC_ADDR[47:32]
> +  :``OTP_57[31:0]``: ``MAC_ADDR[31:0]``
> +  :``OTP_58[15:0]``: ``MAC_ADDR[47:32]``
>
> - - STM32MP13x OTP:
> +- STM32MP13x OTP:
>
> -  - OTP_57[31:0]  =3D MAC_ADDR0[31:0]
> -  - OTP_58[15:0]  =3D MAC_ADDR0[47:32]
> -  - OTP_58[31:16] =3D MAC_ADDR1[15:0]
> -  - OTP_59[31:0]  =3D MAC_ADDR1[47:16]
> +  :``OTP_57[31:0]``:  ``MAC_ADDR0[31:0]``
> +  :``OTP_58[15:0]``:  ``MAC_ADDR0[47:32]``
> +  :``OTP_58[31:16]``: ``MAC_ADDR1[15:0]``
> +  :``OTP_59[31:0]``:  ``MAC_ADDR1[47:16]``
>
> -To program a MAC address on virgin STM32MP15x OTP words above, you can =
use the fuse command
> -on bank 0 to access to internal OTP and lock them:
> +To program a MAC address on virgin STM32MP15x OTP words above, you can =
use the
> +fuse command on bank 0 to access to internal OTP and lock them:
>
>   In the next example we are using the 2 OTPs used on STM32MP15x.
>
> @@ -612,53 +597,52 @@ Prerequisite: check if a MAC address isn't yet pro=
grammed in OTP
>
>   1) check OTP: their value must be equal to 0::
>
> -    STM32MP> fuse sense 0 57 2
> -    Sensing bank 0:
> -    Word 0x00000039: 00000000 00000000
> +       STM32MP> fuse sense 0 57 2
> +       Sensing bank 0:
> +          Word 0x00000039: 00000000 00000000
>
>   2) check environment variable::
>
> -    STM32MP> env print ethaddr
> -    ## Error: "ethaddr" not defined
> +       STM32MP> env print ethaddr
> +       ## Error: "ethaddr" not defined
>
>   3) check lock status of fuse 57 & 58 (at 0x39, 0=3Dunlocked, 0x4000000=
0=3Dlocked)::
>
> -    STM32MP> fuse sense 0 0x10000039 2
> -    Sensing bank 0:
> -       Word 0x10000039: 00000000 00000000
> +       STM32MP> fuse sense 0 0x10000039 2
> +       Sensing bank 0:
> +          Word 0x10000039: 00000000 00000000
>
>   Example to set mac address "12:34:56:78:9a:bc"
>
>   1) Write OTP::
>
> -    STM32MP> fuse prog -y 0 57 0x78563412 0x0000bc9a
> +       STM32MP> fuse prog -y 0 57 0x78563412 0x0000bc9a
>
>   2) Read OTP::
>
> -    STM32MP> fuse sense 0 57 2
> -    Sensing bank 0:
> -    Word 0x00000039: 78563412 0000bc9a
> +       STM32MP> fuse sense 0 57 2
> +       Sensing bank 0:
> +          Word 0x00000039: 78563412 0000bc9a
>
>   3) Lock OTP::
>
> -    STM32MP> fuse prog 0 0x10000039 0x40000000 0x40000000
> +       STM32MP> fuse prog 0 0x10000039 0x40000000 0x40000000
>
> -    STM32MP> fuse sense 0 0x10000039 2
> -    Sensing bank 0:
> -       Word 0x10000039: 40000000 40000000
> +       STM32MP> fuse sense 0 0x10000039 2
> +       Sensing bank 0:
> +          Word 0x10000039: 40000000 40000000
>
>   4) next REBOOT, in the trace::
>
> -    ### Setting environment from OTP MAC address =3D "12:34:56:78:9a:bc=
"
> +       ### Setting environment from OTP MAC address =3D "12:34:56:78:9a=
:bc"
>
>   5) check env update::
>
> -    STM32MP> env print ethaddr
> -    ethaddr=3D12:34:56:78:9a:bc
> +       STM32MP> env print ethaddr
> +       ethaddr=3D12:34:56:78:9a:bc
>
> -.. warning:: This command can't be executed twice on the same board as
> -             OTP are protected. It is already done for the board
> -             provided by STMicroelectronics.
> +.. warning:: This command can't be executed twice on the same board as =
OTP are
> +   protected. It is already done for the board provided by STMicroelect=
ronics.
>
>   Coprocessor firmware on STM32MP15x
>   ----------------------------------
> @@ -669,21 +653,21 @@ a) Manuallly by using rproc commands (update the b=
ootcmd)
>
>      Configurations::
>
> -	# env set name_copro "rproc-m4-fw.elf"
> -	# env set dev_copro 0
> -	# env set loadaddr_copro 0xC1000000
> +       # env set name_copro "rproc-m4-fw.elf"
> +       # env set dev_copro 0
> +       # env set loadaddr_copro 0xC1000000
>
>      Load binary from bootfs partition (number 4) on SD card (mmc 0)::
>
> -	# ext4load mmc 0:4 ${loadaddr_copro} ${name_copro}
> +       # ext4load mmc 0:4 ${loadaddr_copro} ${name_copro}
>
>      =3D> ${filesize} variable is updated with the size of the loaded fi=
le.
>
>      Start M4 firmware with remote proc command::
>
> -	# rproc init
> -	# rproc load ${dev_copro} ${loadaddr_copro} ${filesize}
> -	# rproc start ${dev_copro}"00270033
> +       # rproc init
> +       # rproc load ${dev_copro} ${loadaddr_copro} ${filesize}
> +       # rproc start ${dev_copro}"00270033
>
>   b) Automatically by using FIT feature and generic DISTRO bootcmd
>
> @@ -692,7 +676,7 @@ b) Automatically by using FIT feature and generic DI=
STRO bootcmd
>      Generate FIT including kernel + device tree + M4 firmware with cfg =
with M4
>      boot::
>
> -   $> mkimage -f fit_copro_kernel_dtb.its fit_copro_kernel_dtb.itb
> +       $> mkimage -f fit_copro_kernel_dtb.its fit_copro_kernel_dtb.itb
>
>      Then using DISTRO configuration file: see extlinux.conf to select t=
he correct
>      configuration:
> @@ -705,137 +689,136 @@ DFU support
>
>   The DFU is supported on ST board.
>
> -The env variable dfu_alt_info is automatically build, and all
> -the memory present on the ST boards are exported.
> +The env variable dfu_alt_info is automatically build, and all the memor=
y present
> +on the ST boards are exported.
>
>   The dfu mode is started by the command::
>
> -  STM32MP> dfu 0
> +    STM32MP> dfu 0
>
>   On EV1 board, booting from SD card, without OP-TEE_::
>
> -  STM32MP> dfu 0 list
> -  DFU alt settings list:
> -  dev: RAM alt: 0 name: uImage layout: RAM_ADDR
> -  dev: RAM alt: 1 name: devicetree.dtb layout: RAM_ADDR
> -  dev: RAM alt: 2 name: uramdisk.image.gz layout: RAM_ADDR
> -  dev: eMMC alt: 3 name: mmc0_fsbl1 layout: RAW_ADDR
> -  dev: eMMC alt: 4 name: mmc0_fsbl2 layout: RAW_ADDR
> -  dev: eMMC alt: 5 name: mmc0_fip layout: RAW_ADDR
> -  dev: eMMC alt: 6 name: mmc0_bootfs layout: RAW_ADDR
> -  dev: eMMC alt: 7 name: mmc0_vendorfs layout: RAW_ADDR
> -  dev: eMMC alt: 8 name: mmc0_rootfs layout: RAW_ADDR
> -  dev: eMMC alt: 9 name: mmc0_userfs layout: RAW_ADDR
> -  dev: eMMC alt: 10 name: mmc1_boot1 layout: RAW_ADDR
> -  dev: eMMC alt: 11 name: mmc1_boot2 layout: RAW_ADDR
> -  dev: eMMC alt: 12 name: mmc1_fip layout: RAW_ADDR
> -  dev: eMMC alt: 13 name: mmc1_bootfs layout: RAW_ADDR
> -  dev: eMMC alt: 14 name: mmc1_vendorfs layout: RAW_ADDR
> -  dev: eMMC alt: 15 name: mmc1_rootfs layout: RAW_ADDR
> -  dev: eMMC alt: 16 name: mmc1_userfs layout: RAW_ADDR
> -  dev: MTD alt: 17 name: nor0 layout: RAW_ADDR
> -  dev: MTD alt: 18 name: nor1 layout: RAW_ADDR
> -  dev: MTD alt: 19 name: nand0 layout: RAW_ADDR
> -  dev: VIRT alt: 20 name: OTP layout: RAW_ADDR
> -  dev: VIRT alt: 21 name: PMIC layout: RAW_ADDR
> +    STM32MP> dfu 0 list
> +    DFU alt settings list:
> +    dev: RAM alt: 0 name: uImage layout: RAM_ADDR
> +    dev: RAM alt: 1 name: devicetree.dtb layout: RAM_ADDR
> +    dev: RAM alt: 2 name: uramdisk.image.gz layout: RAM_ADDR
> +    dev: eMMC alt: 3 name: mmc0_fsbl1 layout: RAW_ADDR
> +    dev: eMMC alt: 4 name: mmc0_fsbl2 layout: RAW_ADDR
> +    dev: eMMC alt: 5 name: mmc0_fip layout: RAW_ADDR
> +    dev: eMMC alt: 6 name: mmc0_bootfs layout: RAW_ADDR
> +    dev: eMMC alt: 7 name: mmc0_vendorfs layout: RAW_ADDR
> +    dev: eMMC alt: 8 name: mmc0_rootfs layout: RAW_ADDR
> +    dev: eMMC alt: 9 name: mmc0_userfs layout: RAW_ADDR
> +    dev: eMMC alt: 10 name: mmc1_boot1 layout: RAW_ADDR
> +    dev: eMMC alt: 11 name: mmc1_boot2 layout: RAW_ADDR
> +    dev: eMMC alt: 12 name: mmc1_fip layout: RAW_ADDR
> +    dev: eMMC alt: 13 name: mmc1_bootfs layout: RAW_ADDR
> +    dev: eMMC alt: 14 name: mmc1_vendorfs layout: RAW_ADDR
> +    dev: eMMC alt: 15 name: mmc1_rootfs layout: RAW_ADDR
> +    dev: eMMC alt: 16 name: mmc1_userfs layout: RAW_ADDR
> +    dev: MTD alt: 17 name: nor0 layout: RAW_ADDR
> +    dev: MTD alt: 18 name: nor1 layout: RAW_ADDR
> +    dev: MTD alt: 19 name: nand0 layout: RAW_ADDR
> +    dev: VIRT alt: 20 name: OTP layout: RAW_ADDR
> +    dev: VIRT alt: 21 name: PMIC layout: RAW_ADDR
>
>   All the supported device are exported for dfu-util tool::

%s/dfu-util/the dfu-util/

Best regards

Heinrich

>
> -  $> dfu-util -l
> -  Found DFU: [0483:df11] ver=3D9999, devnum=3D99, cfg=3D1, intf=3D0, al=
t=3D21, name=3D"PMIC", serial=3D"002700333338511934383330"
> -  Found DFU: [0483:df11] ver=3D9999, devnum=3D99, cfg=3D1, intf=3D0, al=
t=3D20, name=3D"OTP", serial=3D"002700333338511934383330"
> -  Found DFU: [0483:df11] ver=3D9999, devnum=3D99, cfg=3D1, intf=3D0, al=
t=3D19, name=3D"nand0", serial=3D"002700333338511934383330"
> -  Found DFU: [0483:df11] ver=3D9999, devnum=3D99, cfg=3D1, intf=3D0, al=
t=3D18, name=3D"nor1", serial=3D"002700333338511934383330"
> -  Found DFU: [0483:df11] ver=3D9999, devnum=3D99, cfg=3D1, intf=3D0, al=
t=3D17, name=3D"nor0", serial=3D"002700333338511934383330"
> -  Found DFU: [0483:df11] ver=3D9999, devnum=3D99, cfg=3D1, intf=3D0, al=
t=3D16, name=3D"mmc1_userfs", serial=3D"002700333338511934383330"
> -  Found DFU: [0483:df11] ver=3D9999, devnum=3D99, cfg=3D1, intf=3D0, al=
t=3D15, name=3D"mmc1_rootfs", serial=3D"002700333338511934383330"
> -  Found DFU: [0483:df11] ver=3D9999, devnum=3D99, cfg=3D1, intf=3D0, al=
t=3D14, name=3D"mmc1_vendorfs", serial=3D"002700333338511934383330"
> -  Found DFU: [0483:df11] ver=3D9999, devnum=3D99, cfg=3D1, intf=3D0, al=
t=3D13, name=3D"mmc1_bootfs", serial=3D"002700333338511934383330"
> -  Found DFU: [0483:df11] ver=3D9999, devnum=3D99, cfg=3D1, intf=3D0, al=
t=3D12, name=3D"mmc1_fip", serial=3D"002700333338511934383330"
> -  Found DFU: [0483:df11] ver=3D9999, devnum=3D99, cfg=3D1, intf=3D0, al=
t=3D11, name=3D"mmc1_boot2", serial=3D"002700333338511934383330"
> -  Found DFU: [0483:df11] ver=3D9999, devnum=3D99, cfg=3D1, intf=3D0, al=
t=3D10, name=3D"mmc1_boot1", serial=3D"002700333338511934383330"
> -  Found DFU: [0483:df11] ver=3D9999, devnum=3D99, cfg=3D1, intf=3D0, al=
t=3D9, name=3D"mmc0_userfs", serial=3D"002700333338511934383330"
> -  Found DFU: [0483:df11] ver=3D9999, devnum=3D99, cfg=3D1, intf=3D0, al=
t=3D8, name=3D"mmc0_rootfs", serial=3D"002700333338511934383330"
> -  Found DFU: [0483:df11] ver=3D9999, devnum=3D99, cfg=3D1, intf=3D0, al=
t=3D7, name=3D"mmc0_vendorfs", serial=3D"002700333338511934383330"
> -  Found DFU: [0483:df11] ver=3D9999, devnum=3D99, cfg=3D1, intf=3D0, al=
t=3D6, name=3D"mmc0_bootfs", serial=3D"002700333338511934383330"
> -  Found DFU: [0483:df11] ver=3D9999, devnum=3D99, cfg=3D1, intf=3D0, al=
t=3D5, name=3D"mmc0_fip", serial=3D"002700333338511934383330"
> -  Found DFU: [0483:df11] ver=3D9999, devnum=3D99, cfg=3D1, intf=3D0, al=
t=3D4, name=3D"mmc0_fsbl2", serial=3D"002700333338511934383330"
> -  Found DFU: [0483:df11] ver=3D9999, devnum=3D99, cfg=3D1, intf=3D0, al=
t=3D3, name=3D"mmc0_fsbl1", serial=3D"002700333338511934383330"
> -  Found DFU: [0483:df11] ver=3D9999, devnum=3D99, cfg=3D1, intf=3D0, al=
t=3D2, name=3D"uramdisk.image.gz", serial=3D"002700333338511934383330"
> -  Found DFU: [0483:df11] ver=3D9999, devnum=3D99, cfg=3D1, intf=3D0, al=
t=3D1, name=3D"devicetree.dtb", serial=3D"002700333338511934383330"
> -  Found DFU: [0483:df11] ver=3D9999, devnum=3D99, cfg=3D1, intf=3D0, al=
t=3D0, name=3D"uImage", serial=3D"002700333338511934383330"
> +    $> dfu-util -l
> +    Found DFU: [0483:df11] ver=3D9999, devnum=3D99, cfg=3D1, intf=3D0, =
alt=3D21, name=3D"PMIC", serial=3D"002700333338511934383330"
> +    Found DFU: [0483:df11] ver=3D9999, devnum=3D99, cfg=3D1, intf=3D0, =
alt=3D20, name=3D"OTP", serial=3D"002700333338511934383330"
> +    Found DFU: [0483:df11] ver=3D9999, devnum=3D99, cfg=3D1, intf=3D0, =
alt=3D19, name=3D"nand0", serial=3D"002700333338511934383330"
> +    Found DFU: [0483:df11] ver=3D9999, devnum=3D99, cfg=3D1, intf=3D0, =
alt=3D18, name=3D"nor1", serial=3D"002700333338511934383330"
> +    Found DFU: [0483:df11] ver=3D9999, devnum=3D99, cfg=3D1, intf=3D0, =
alt=3D17, name=3D"nor0", serial=3D"002700333338511934383330"
> +    Found DFU: [0483:df11] ver=3D9999, devnum=3D99, cfg=3D1, intf=3D0, =
alt=3D16, name=3D"mmc1_userfs", serial=3D"002700333338511934383330"
> +    Found DFU: [0483:df11] ver=3D9999, devnum=3D99, cfg=3D1, intf=3D0, =
alt=3D15, name=3D"mmc1_rootfs", serial=3D"002700333338511934383330"
> +    Found DFU: [0483:df11] ver=3D9999, devnum=3D99, cfg=3D1, intf=3D0, =
alt=3D14, name=3D"mmc1_vendorfs", serial=3D"002700333338511934383330"
> +    Found DFU: [0483:df11] ver=3D9999, devnum=3D99, cfg=3D1, intf=3D0, =
alt=3D13, name=3D"mmc1_bootfs", serial=3D"002700333338511934383330"
> +    Found DFU: [0483:df11] ver=3D9999, devnum=3D99, cfg=3D1, intf=3D0, =
alt=3D12, name=3D"mmc1_fip", serial=3D"002700333338511934383330"
> +    Found DFU: [0483:df11] ver=3D9999, devnum=3D99, cfg=3D1, intf=3D0, =
alt=3D11, name=3D"mmc1_boot2", serial=3D"002700333338511934383330"
> +    Found DFU: [0483:df11] ver=3D9999, devnum=3D99, cfg=3D1, intf=3D0, =
alt=3D10, name=3D"mmc1_boot1", serial=3D"002700333338511934383330"
> +    Found DFU: [0483:df11] ver=3D9999, devnum=3D99, cfg=3D1, intf=3D0, =
alt=3D9, name=3D"mmc0_userfs", serial=3D"002700333338511934383330"
> +    Found DFU: [0483:df11] ver=3D9999, devnum=3D99, cfg=3D1, intf=3D0, =
alt=3D8, name=3D"mmc0_rootfs", serial=3D"002700333338511934383330"
> +    Found DFU: [0483:df11] ver=3D9999, devnum=3D99, cfg=3D1, intf=3D0, =
alt=3D7, name=3D"mmc0_vendorfs", serial=3D"002700333338511934383330"
> +    Found DFU: [0483:df11] ver=3D9999, devnum=3D99, cfg=3D1, intf=3D0, =
alt=3D6, name=3D"mmc0_bootfs", serial=3D"002700333338511934383330"
> +    Found DFU: [0483:df11] ver=3D9999, devnum=3D99, cfg=3D1, intf=3D0, =
alt=3D5, name=3D"mmc0_fip", serial=3D"002700333338511934383330"
> +    Found DFU: [0483:df11] ver=3D9999, devnum=3D99, cfg=3D1, intf=3D0, =
alt=3D4, name=3D"mmc0_fsbl2", serial=3D"002700333338511934383330"
> +    Found DFU: [0483:df11] ver=3D9999, devnum=3D99, cfg=3D1, intf=3D0, =
alt=3D3, name=3D"mmc0_fsbl1", serial=3D"002700333338511934383330"
> +    Found DFU: [0483:df11] ver=3D9999, devnum=3D99, cfg=3D1, intf=3D0, =
alt=3D2, name=3D"uramdisk.image.gz", serial=3D"002700333338511934383330"
> +    Found DFU: [0483:df11] ver=3D9999, devnum=3D99, cfg=3D1, intf=3D0, =
alt=3D1, name=3D"devicetree.dtb", serial=3D"002700333338511934383330"
> +    Found DFU: [0483:df11] ver=3D9999, devnum=3D99, cfg=3D1, intf=3D0, =
alt=3D0, name=3D"uImage", serial=3D"002700333338511934383330"
>
>   You can update the boot device:
>
>   - SD card (mmc0)::
>
> -  $> dfu-util -d 0483:5720 -a 3 -D tf-a-stm32mp157c-ev1.stm32
> -  $> dfu-util -d 0483:5720 -a 4 -D tf-a-stm32mp157c-ev1.stm32
> -  $> dfu-util -d 0483:5720 -a 5 -D fip-stm32mp157c-ev1.bin
> -  $> dfu-util -d 0483:5720 -a 6 -D st-image-bootfs-openstlinux-weston-s=
tm32mp1.ext4
> -  $> dfu-util -d 0483:5720 -a 7 -D st-image-vendorfs-openstlinux-weston=
-stm32mp1.ext4
> -  $> dfu-util -d 0483:5720 -a 8 -D st-image-weston-openstlinux-weston-s=
tm32mp1.ext4
> -  $> dfu-util -d 0483:5720 -a 9 -D st-image-userfs-openstlinux-weston-s=
tm32mp1.ext4
> +      $> dfu-util -d 0483:5720 -a 3 -D tf-a-stm32mp157c-ev1.stm32
> +      $> dfu-util -d 0483:5720 -a 4 -D tf-a-stm32mp157c-ev1.stm32
> +      $> dfu-util -d 0483:5720 -a 5 -D fip-stm32mp157c-ev1.bin
> +      $> dfu-util -d 0483:5720 -a 6 -D st-image-bootfs-openstlinux-west=
on-stm32mp1.ext4
> +      $> dfu-util -d 0483:5720 -a 7 -D st-image-vendorfs-openstlinux-we=
ston-stm32mp1.ext4
> +      $> dfu-util -d 0483:5720 -a 8 -D st-image-weston-openstlinux-west=
on-stm32mp1.ext4
> +      $> dfu-util -d 0483:5720 -a 9 -D st-image-userfs-openstlinux-west=
on-stm32mp1.ext4
>
>   - EMMC (mmc1)::
>
> -  $> dfu-util -d 0483:5720 -a 10 -D tf-a-stm32mp157c-ev1.stm32
> -  $> dfu-util -d 0483:5720 -a 11 -D tf-a-stm32mp157c-ev1.stm32
> -  $> dfu-util -d 0483:5720 -a 12 -D fip-stm32mp157c-ev1.bin
> -  $> dfu-util -d 0483:5720 -a 13 -D st-image-bootfs-openstlinux-weston-=
stm32mp1.ext4
> -  $> dfu-util -d 0483:5720 -a 14 -D st-image-vendorfs-openstlinux-westo=
n-stm32mp1.ext4
> -  $> dfu-util -d 0483:5720 -a 15 -D st-image-weston-openstlinux-weston-=
stm32mp1.ext4
> -  $> dfu-util -d 0483:5720 -a 16 -D st-image-userfs-openstlinux-weston-=
stm32mp1.ext4
> +      $> dfu-util -d 0483:5720 -a 10 -D tf-a-stm32mp157c-ev1.stm32
> +      $> dfu-util -d 0483:5720 -a 11 -D tf-a-stm32mp157c-ev1.stm32
> +      $> dfu-util -d 0483:5720 -a 12 -D fip-stm32mp157c-ev1.bin
> +      $> dfu-util -d 0483:5720 -a 13 -D st-image-bootfs-openstlinux-wes=
ton-stm32mp1.ext4
> +      $> dfu-util -d 0483:5720 -a 14 -D st-image-vendorfs-openstlinux-w=
eston-stm32mp1.ext4
> +      $> dfu-util -d 0483:5720 -a 15 -D st-image-weston-openstlinux-wes=
ton-stm32mp1.ext4
> +      $> dfu-util -d 0483:5720 -a 16 -D st-image-userfs-openstlinux-wes=
ton-stm32mp1.ext4
>
>   - you can also dump the OTP and the PMIC NVM with::
>
> -  $> dfu-util -d 0483:5720 -a 19 -U otp.bin
> -  $> dfu-util -d 0483:5720 -a 20 -U pmic.bin
> -
> +      $> dfu-util -d 0483:5720 -a 19 -U otp.bin
> +      $> dfu-util -d 0483:5720 -a 20 -U pmic.bin
>
> -When the board is booting for nor0 or nand0,
> -only the MTD partition on the boot devices are available, for example:
> +When the board is booting for nor0 or nand0, only the MTD partition on =
the boot
> +devices are available, for example:
>
>   - NOR (nor0 =3D alt 20, nor1 =3D alt 26) & NAND (nand0 =3D alt 27)::
>
> -  $> dfu-util -d 0483:5720 -a 21 -D tf-a-stm32mp157c-ev1.stm32
> -  $> dfu-util -d 0483:5720 -a 22 -D tf-a-stm32mp157c-ev1.stm32
> -  $> dfu-util -d 0483:5720 -a 23 -D fip-stm32mp157c-ev1.bin
> -  $> dfu-util -d 0483:5720 -a 28 -D st-image-weston-openstlinux-weston-=
stm32mp1_nand_4_256_multivolume.ubi
> +      $> dfu-util -d 0483:5720 -a 21 -D tf-a-stm32mp157c-ev1.stm32
> +      $> dfu-util -d 0483:5720 -a 22 -D tf-a-stm32mp157c-ev1.stm32
> +      $> dfu-util -d 0483:5720 -a 23 -D fip-stm32mp157c-ev1.bin
> +      $> dfu-util -d 0483:5720 -a 28 -D st-image-weston-openstlinux-wes=
ton-stm32mp1_nand_4_256_multivolume.ubi
>
>   - NAND (nand0 =3D alt 21)::
>
> -  $> dfu-util -d 0483:5720 -a 22 -D tf-a-stm32mp157c-ev1.stm32
> -  $> dfu-util -d 0483:5720 -a 23 -D fip-stm32mp157c-ev1.bin
> -  $> dfu-util -d 0483:5720 -a 24 -D fip-stm32mp157c-ev1.bin
> -  $> dfu-util -d 0483:5720 -a 25 -D st-image-weston-openstlinux-weston-=
stm32mp1_nand_4_256_multivolume.ubi
> +      $> dfu-util -d 0483:5720 -a 22 -D tf-a-stm32mp157c-ev1.stm32
> +      $> dfu-util -d 0483:5720 -a 23 -D fip-stm32mp157c-ev1.bin
> +      $> dfu-util -d 0483:5720 -a 24 -D fip-stm32mp157c-ev1.bin
> +      $> dfu-util -d 0483:5720 -a 25 -D st-image-weston-openstlinux-wes=
ton-stm32mp1_nand_4_256_multivolume.ubi
>
>   References
>   ----------
>
> -.. _WIKI:
> +.. _Wiki:
>
>   STM32 Arm=C2=AE Cortex=C2=AE-based MPUs user guide
>
> -  + https://wiki.st.com/
> -  + https://wiki.st.com/stm32mpu/wiki/Main_Page
> ++ https://wiki.st.com/
> ++ https://wiki.st.com/stm32mpu/wiki/Main_Page
>
>   .. _TF-A:
>
>   TF-A =3D The Trusted Firmware-A project provides a reference implement=
ation of
>   secure world software for Armv7-A and Armv8-A class processors
>
> -  + https://www.trustedfirmware.org/projects/tf-a/
> -  + https://trustedfirmware-a.readthedocs.io/en/latest/
> -  + https://trustedfirmware-a.readthedocs.io/en/latest/plat/stm32mp1.ht=
ml
> -  + https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/
> ++ https://www.trustedfirmware.org/projects/tf-a/
> ++ https://trustedfirmware-a.readthedocs.io/en/latest/
> ++ https://trustedfirmware-a.readthedocs.io/en/latest/plat/stm32mp1.html
> ++ https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/
>
>   .. _OP-TEE:
>
> -OP-TEE =3D an open source Trusted Execution Environment (TEE) implement=
ing the
> -Arm TrustZone technology
> +OP-TEE =3D an open source Trusted Execution Environment (TEE) implement=
ing the Arm
> +TrustZone technology
>
> -  + https://www.op-tee.org/
> -  + https://optee.readthedocs.io/en/latest/
> -  + https://optee.readthedocs.io/en/latest/building/devices/stm32mp1.ht=
ml
> -  + https://github.com/OP-TEE/optee_os
> ++ https://www.op-tee.org/
> ++ https://optee.readthedocs.io/en/latest/
> ++ https://optee.readthedocs.io/en/latest/building/devices/stm32mp1.html
> ++ https://github.com/OP-TEE/optee_os

