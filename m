Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BAAC4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 21:46:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6731F88198;
	Fri,  3 May 2024 23:46:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QYnI31Rn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E624E881A6; Fri,  3 May 2024 23:46:20 +0200 (CEST)
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com
 [IPv6:2607:f8b0:4864:20::a2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 584F888176
 for <u-boot@lists.denx.de>; Fri,  3 May 2024 23:46:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-4df2fcafc19so82297e0c.0
 for <u-boot@lists.denx.de>; Fri, 03 May 2024 14:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714772777; x=1715377577; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=15yWRj4mtzbBxXl5ETNqpfulYiWV+jD2py99kaLSFuo=;
 b=QYnI31RnX+7K0JMuEb8MvirUJeNLrVKmHhFPDuVKQyuIR5cWUewluJw7wAeJ8hhmJ4
 VZ0JTCVq9ruSLncVk5SsiXCIwNeiHXDjA8y7B2Eofoh7ksw/G5MdiIrYYAJPKdqs2rTb
 q6j9HJWGdRGA0KiwsHeLL1uwm8ZA5QiicSm02IfQuqh6wBRDGVNnUvSoq0eNaGZiwCZM
 DpkM6VwI2KIBOfvfjDuCTsOJVODxThRSGWGirM1Gvr1NLugQB3uXDNWXdxJPFt3cgJIS
 kbwm5pcQZpSQi95g5I2LvkNP6gule1vWQB17K5Da4q+8mCap3Bz9VKoyeUfTkDSlsj7O
 UaNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714772777; x=1715377577;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=15yWRj4mtzbBxXl5ETNqpfulYiWV+jD2py99kaLSFuo=;
 b=oFLeRWDlBD3GAkadM1a9645FiKEtb2ZDQigHJFFuqG229LAyquzqhv4Nb8cJaLWHfF
 fiQf5NA639Jj+LUk7PkTtw4HBDWr2HFv3rwvVkxLfQwHfX7uIZhqI7A6SavIpJiyYS2u
 1nC/TP4nGYOMFylzdcqhCuPm7XTHipwaEz9GCq2/6yJjLSL+PTdRgG7dN1tIHavioEUA
 WOhaFODjQB4NnG9gcT8AVn6JIu+6cJVGntZZEX0ChrSgDGvOfzHrC62mMnEvCQWpu5CZ
 vbM9Fuw24EsdgCElbMTaMG9mnp1siAX5SWQw/OXAGQehsnn5MQ/qtrfil9VzuoXWjbip
 PMvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUSWVdKR6q63eX3NRnyZaPs5jh9MWvV/QnbUal9NO4eSaUWRtSfCfIRvGfFifmcumoGOI5ydSpeuxz7EsXZPQ7246W8g==
X-Gm-Message-State: AOJu0YxgJ3bNS0c2imKEvRO7yyPUT8Cc5XZZ+Mxuhmnr3kabArI4GN4+
 EWRVHGYLI8VTkXWrQi15iioNF9lLQJAC7eMtOQzd4ZtytmysiBRT83iiPEkSxJmXfH6UySJWakm
 10rfTBmlrwZuG8kipD0K1sE+31no=
X-Google-Smtp-Source: AGHT+IEXJaNRwmRMp2YHx3/vhUHvH6EWi8xUNr/O5IErJxs2T9Nb2XZCVvi/kXDaclkuiPMFbbEJTlio7ymH4LFVSlA=
X-Received: by 2002:a05:6122:2018:b0:4d3:3a8c:13ad with SMTP id
 l24-20020a056122201800b004d33a8c13admr4524504vkd.8.1714772777074; Fri, 03 May
 2024 14:46:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240503090011.37849-1-heinrich.schuchardt@canonical.com>
 <20240503090011.37849-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240503090011.37849-4-heinrich.schuchardt@canonical.com>
From: E Shattow <lucent@gmail.com>
Date: Fri, 3 May 2024 14:46:06 -0700
Message-ID: <CANV2PTM-qYtggRbNoT27=q1yWLVsVHBkvte_MkwkA5d5QZOWGA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] doc: Milk-V Mars CM and Milk-V Mars CM Lite
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Aurelien Jarno <aurelien@aurel32.net>,
 Lukasz Tekieli <tekieli.lukasz@gmail.com>, 
 Lukas Funke <lukas.funke@weidmueller.com>, Shiji Yang <yangshiji66@outlook.com>,
 Shengyu Qu <wiagn233@outlook.com>, Michal Simek <michal.simek@amd.com>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, Mason Huo <mason.huo@starfivetech.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi, looking good to me except $fdtfile filename changes were missed to
match the code, and then testing inspires a few more things to
suggest.

On Fri, May 3, 2024 at 2:01=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Provide a man-page describing the usage of U-Boot on
> the Milk-V Mars CM and Milk-V Mars CM Lite boards.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         refer to tio as tool for booting via UART
>         describe how to update serial number
>         description updates as suggested by E. Shattow
> ---
>  doc/board/starfive/index.rst          |   1 +
>  doc/board/starfive/milk-v_mars_cm.rst | 183 ++++++++++++++++++++++++++
>  2 files changed, 184 insertions(+)
>  create mode 100644 doc/board/starfive/milk-v_mars_cm.rst
>
> diff --git a/doc/board/starfive/index.rst b/doc/board/starfive/index.rst
> index 2762bf74c11..afa85ad2540 100644
> --- a/doc/board/starfive/index.rst
> +++ b/doc/board/starfive/index.rst
> @@ -7,4 +7,5 @@ StarFive
>     :maxdepth: 1
>
>     milk-v_mars.rst
> +   milk-v_mars_cm.rst
>     visionfive2
> diff --git a/doc/board/starfive/milk-v_mars_cm.rst b/doc/board/starfive/m=
ilk-v_mars_cm.rst
> new file mode 100644
> index 00000000000..d2be064d94c
> --- /dev/null
> +++ b/doc/board/starfive/milk-v_mars_cm.rst
> @@ -0,0 +1,183 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +Milk-V Mars CM
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +U-Boot for the Milk-V Mars CM uses the same U-Boot binaries as the Visio=
nFive 2
> +board. In U-Boot SPL the actual board is detected and the device-tree pa=
tched
> +accordingly.
> +
> +The Milk-V Mars CM Lite comes without eMMC and needs a different pin mux=
ing
> +than the Milk-V Mars CM. The availability and size of the eMMC shows up =
in the
> +serial number displayed by the *mac* command, e.g.
> +MARC-V10-2340-D002E016-00000304. The number after the E is the MMC size.=
 U-Boot
> +takes a value of E000 as an indicator for the Lite version. Unfortunatel=
y the
> +vendor has not set this value correctly on some Lite boards.
> +
> +Please, use CONFIG_STARFIVE_NO_EMMC=3Dy if EEPROM data indicates eMMC is=
 present
> +on the Milk-V Mars CM Lite. Otherwise you will not be able to read from =
the
> +SD-card.
> +
> +The serial number can be corrected using the *mac* command:
> +
> +.. code-block::
> +
> +    mac read_eeprom
> +    mac product_id MARC-V10-2340-D002E000-00000304
> +    mac write_eeprom
> +
> +By default the EEPROM is write protected. The write protection may be ov=
ercome
> +by connecting the "GND" and "EN" test pads on top of the module.

With adding boards based on VisionFive2 and having different vendor
info in EEPROM, the mac command should be extended for setting vendor
info from user input. Vendor info is currently not changeable back to
"MILK-V" after *mac initialize* sets vendor as  "StarFive Technology
Co., Ltd." If mac command can be extended then the documentation here
is sufficient, else some description warning the user not to *mac
initialize* on platforms other than VisionFive2 from StarFive.

> +
> +Building
> +~~~~~~~~
> +
> +1. Add the RISC-V toolchain to your PATH.
> +2. Setup ARCH & cross compilation environment variable:
> +
> +.. code-block:: none
> +
> +   export CROSS_COMPILE=3D<riscv64 toolchain prefix>
> +
> +The M-mode software OpenSBI provides the supervisor binary interface (SB=
I) and
> +is responsible for the switch to S-Mode. It is a prerequisite to build U=
-Boot.
> +Support for the JH7110 was introduced in OpenSBI 1.2. It is recommended =
to use
> +a current release.
> +
> +.. code-block:: console
> +
> +       git clone https://github.com/riscv/opensbi.git
> +       cd opensbi
> +       make PLATFORM=3Dgeneric FW_TEXT_START=3D0x40000000
> +
> +(*FW_TEXT_START* is not needed anymore after OpenSBI patch d4d2582eef7a
> +"firmware: remove FW_TEXT_START" which should appear in OpenSBI 1.5.)
> +
> +Now build the U-Boot SPL and U-Boot proper.
> +
> +.. code-block:: console
> +
> +       cd <U-Boot-dir>
> +       make starfive_visionfive2_defconfig
> +       make OPENSBI=3D$(opensbi_dir)/build/platform/generic/firmware/fw_=
dynamic.bin
> +
> +This will generate the U-Boot SPL image (spl/u-boot-spl.bin.normal.out) =
as well
> +as the FIT image (u-boot.itb) with OpenSBI and U-Boot.
> +
> +Device-tree selection
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +Depending on the board version U-Boot sets variable $fdtfile to either
> +starfive/jh7110-milkv-mars-cm-emmc.dtb (for the generic version or
> +starfive/jh7110-milkv-mars-cm-sdcard.dtb (for the Lite version).

"Depending on the board version U-Boot sets variable $fdtfile to either
starfive/jh7110-milkv-mars-cm.dtb (with eMMC storage) or
starfive/jh7110-milkv-mars-cm-lite.dtb (without eMMC storage)."

> +
> +To overrule this selection the variable can be set manually and saved in=
 the
> +environment
> +
> +::
> +
> +    setenv fdtfile my_device-tree.dtb
> +    env save

env set fdtfile my_device-tree.dtb
env save

> +
> +or the configuration variable CONFIG_DEFAULT_FDT_FILE can be used to set=
 to
> +provide a default value.

An additional hint will be helpful here for context of why $fdtfile is
set to a filename, i.e. "refer to X documentation for search path and
details on how $fdtfile affects the boot process." if/when
documentation exists.

> +
> +Boot source selection
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +The low speed connector nRPIBOOT line is used to switch the boot source.
> +
> +* If nRPIBOOT is connected to ground, the board boots from UART.
> +* If nRPIBOOT is not connected, the board boots from SPI flash.
> +
> +Compute module boards typically have a switch or jumper for this line.
> +
> +Flashing a new U-Boot version
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +U-Boot SPL is provided as file spl/u-boot-spl.bin.normal.out. Main U-Boo=
t is
> +in file u-boot.itb.
> +
> +Assuming your new U-Boot version is on partition 1 of an SD-card you cou=
ld
> +install it to the SPI flash with:
> +
> +::
> +
> +    sf probe
> +    load mmc 0:1 $kernel_addr_r u-boot-spl.bin.normal.out
> +    sf update $kernel_addr_r 0 $filesize
> +    load mmc 0:1 $kernel_addr_r u-boot.itb
> +    sf update $kernel_addr_r 0x100000 $filesize
> +
> +For loading the files from a TFTP server refer to the dhcp and tftpboot
> +commands.
> +
> +After updating U-Boot you may want to reboot and reset the environment t=
o the
> +default.
> +
> +::
> +
> +    env default -f -a
> +    env save
> +
> +Booting from UART
> +~~~~~~~~~~~~~~~~~
> +
> +For booting via UART U-Boot must be built with CONFIG_SPL_YMODEM_SUPPORT=
=3Dy.
> +
> +With nRPIBOOT connected to ground for UART boot, power the board and upl=
oad
> +u-boot-spl.bin.normal.out via XMODEM. Then upload u-boot.itb via YMODEM.
> +
> +The XMODEM implementation in the boot ROM is not fully specification com=
pliant.
> +It sends too many NAKs in a row. Tio is a terminal emulation that tolera=
tes
> +these faults.
> +
> +::
> +
> +    $ tio -b 115200 --databits 8 --flow none --stopbits 1 /dev/ttyUSB0
> +    [08:14:54.700] tio v2.7
> +    [08:14:54.700] Press ctrl-t q to quit
> +    [08:14:54.701] Connected
> +
> +    (C)StarFive
> +    CCC
> +    (C)StarFive
> +    CCCCCCCC
> +
> +Press *ctrl-t x* to initate XMODEM transfer.

Correct spelling and include hint of which XMODEM variant mode to
choose in tio v2.8+ XMODEM upload menu:

"Press *ctrl-t x* to initiate XMODEM (XMODEM-1K) transfer."

> +
> +::
> +
> +    [08:15:14.778] Send file with XMODEM
> +    [08:15:22.459] Sending file 'u-boot-spl.bin.normal.out'
> +    [08:15:22.459] Press any key to abort transfer
> +    ....................................................................=
....
> +    ....................................................................=
...|
> +    [08:15:22.459] Done
> +
> +    U-Boot SPL 2024.07-rc1-00075-gd6a4ab20097 (Apr 25 2024 - 16:32:10 +0=
200)
> +    DDR version: dc2e84f0.
> +    Trying to boot from UART
> +    CC
> +
> +Press *ctrl-t y* to initate YMODEM transfer.

Correct spelling:

"Press *ctrl-t y* to initiate YMODEM transfer."

> +
> +::
> +
> +    [08:15:50.331] Send file with YMODEM
> +    [08:15:53.540] Sending file 'u-boot.itb'
> +    [08:15:53.540] Press any key to abort transfer
> +    ....................................................................=
....
> +    =E2=80=A6
> +    ...............|
> +    [08:15:53.540] Done
> +    Loaded 1040599 bytes
> +
> +
> +    U-Boot 2024.07-rc1-00075-gd6a4ab20097 (Apr 25 2024 - 16:32:10 +0200)
> +
> +Booting from SPI flash
> +~~~~~~~~~~~~~~~~~~~~~~
> +
> +With nRPIBOOT connected disconnected from ground for SPI boot, power up =
the
> +board. You should see the U-Boot prompt on the serial console.
> --
> 2.43.0
>

-E
