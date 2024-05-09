Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B963CC10F1A
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 18:02:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E50908826E;
	Thu,  9 May 2024 20:02:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PHmbFtDP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 455128826E; Thu,  9 May 2024 20:02:50 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F4AF88113
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 20:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5ac8c73cf88so672877eaf.2
 for <u-boot@lists.denx.de>; Thu, 09 May 2024 11:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715277766; x=1715882566; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i+S3kGoiBE6R++MpejydIGHGKv2v1e9xWXG1qx58stA=;
 b=PHmbFtDPq5p5QzrCY5/eiplnvY4RrNVne2FM0oGdsmUAwcuHBdnHvMTtynTfjouATU
 gLR6kPAiozbAcyDA5KBbGAQcuqJKzFZcK9inzr6E5ykH+brLHyz8cILtiBODW0pihxQq
 Sf+OpZohAPIFaMzUwbmNW49FQFaXDGc8DZ8YT6okLdDGRLx1P9uxJ16A+BPtNDhH82i8
 7nuzW9RRy/G0ivb+Rwb8G4bV17YfztgY3kEeWj1xiQk8cXEuD50HKMk22wec2gY4AyfL
 Lrho5lgfDPG2tSCLTXihBOzj3PmGMzu1Q8D5aTki1xhJVVBRJvUsejqFqWSoMpf8ZwAN
 tXeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715277766; x=1715882566;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i+S3kGoiBE6R++MpejydIGHGKv2v1e9xWXG1qx58stA=;
 b=QocrEPd6kEeMQzf2w2dvnb5WXN3Ag9QwZvG+8zJ8SYod25UUeU8jYX87vsuN4/mTfx
 dDP618/Vo7WgVtSD70AfwqMJ7z9VOlJvULXglD3fiwnreDF57kFuy4JS0bfy4rOCIukL
 Cnb6G7aQ5CDR/5K8EztN2ug2qmKg5iv7js6sWSMsK3nkBeLX0WoZopxEugS/ceug1Zsb
 tJhCcnZRBMbrIbT/HC3sOzBFfTobl9JFx6+UVHyR2/8siHdbrm/AY91IA1cb01pEmbtO
 L11vjL1fUByLWnjPwaZlqT+5gm74KykS2J2Dj9bOIyEvuXyvN/dLHgqK0dnpDscqVq0L
 ZzqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbo5Egbq438/fTwPAHybTnQtWE1gAT4WhceuK3F7j2Oz7nmka73o8qb0gEUkSCMH/J7ULTUVjkcNeVOz9RSjTLqa/R7g==
X-Gm-Message-State: AOJu0YyJo6aQ6fZbhbFbnXz8CiE2bs74KbnEt3QkKwsWl/f8r4M76Bmk
 A9a5P5HAwBlYTD5oCtdCP6IKG0f6nHPrHUf+MKqJm+sLGzx8D+Y6kAuw2m77i1iyTh2qlxlO7BO
 R6jMTA7nbv+SGFd4p3jRRt4+9v6Q=
X-Google-Smtp-Source: AGHT+IHqbq+rqVG99We2MvQQFvzeDN/hmkVURN29SfiBt2cWM0ixClrXa0eup8+2y8d8h4iUHx/qHOAxkw7ZsWl+i7k=
X-Received: by 2002:a05:6359:459d:b0:186:1eab:832f with SMTP id
 e5c5f4694b2df-193bb63b596mr18942855d.17.1715277766007; Thu, 09 May 2024
 11:02:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240509101155.18666-1-heinrich.schuchardt@canonical.com>
 <20240509101155.18666-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240509101155.18666-4-heinrich.schuchardt@canonical.com>
From: E Shattow <lucent@gmail.com>
Date: Thu, 9 May 2024 11:02:33 -0700
Message-ID: <CANV2PTPbMP5xXEdxsjxf4vFqFW+99fSKT=X+8faHHrwRNKtw0A@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] doc: Milk-V Mars CM and Milk-V Mars CM Lite
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

Hi,

A couple of nits I missed. Good for PR otherwise.

On Thu, May 9, 2024 at 3:12=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Provide a man-page describing the usage of U-Boot on
> the Milk-V Mars CM and Milk-V Mars CM Lite boards.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v3:
>         correct device-tree names
>         suggest not to use mac initialize
>         refer to XMODEM-1K
> v2:
>         refer to tio as tool for booting via UART
>         describe how to update serial number
>         description updates as suggested by E. Shattow
> ---
>  doc/board/starfive/index.rst          |   1 +
>  doc/board/starfive/milk-v_mars_cm.rst | 193 ++++++++++++++++++++++++++
>  2 files changed, 194 insertions(+)
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

File extension is omitted for relative toctree references. See:
https://documatt.com/restructuredtext-reference/element/toctree.html:

"Relative document names are relative to the current document
(containing toctree). Relative document names are those which not
begin with /. For example, transition is transition.rst in the current
folder, or collection/parts is collection/parts.rst, etc."

'milk-v_mars.rst' should also drop the filename extension.

> diff --git a/doc/board/starfive/milk-v_mars_cm.rst b/doc/board/starfive/m=
ilk-v_mars_cm.rst
> new file mode 100644
> index 00000000000..68561adadfc
> --- /dev/null
> +++ b/doc/board/starfive/milk-v_mars_cm.rst
> @@ -0,0 +1,193 @@
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
> +.. note::
> +
> +   The *mac initialize* command overwrites the vendor string and the MAC
> +   addresses. This is why it is avoided here.
> +
> +By default the EEPROM is write protected. The write protection may be ov=
ercome
> +by connecting the "GND" and "EN" test pads on top of the module.
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
> +starfive/jh7110-milkv-mars-cm.dtb (with eMMC storage) or
> +starfive/jh7110-milkv-mars-cm-lite.dtb (without eMMC storage).
> +
> +To overrule this selection the variable can be set manually and saved in=
 the
> +environment
> +
> +::
> +
> +    env set fdtfile my_device-tree.dtb
> +    env save
> +
> +or the configuration variable CONFIG_DEFAULT_FDT_FILE can be used to set=
 to
> +provide a default value.
> +
> +The variable *$fdtfile* is used in the boot process to automatically loa=
d
> +a device-tree provided by the operating system. For details of the boot
> +process refer to the :doc:`U-Boot Standard Boot <../../../develop/bootst=
d>`
> +description.
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
> +Press *ctrl-t x* to initiate XMODEM-1K transfer.
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
> +Press *ctrl-t y* to initiate YMODEM transfer.
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

Nit: This is correct but the word 'connected' is implied by
'disconnected' to be as
'connected in a disconnected state'. Delete the implied word 'connected':

"With nRPIBOOT disconnected from ground for SPI boot, power up the"

> --
> 2.43.0
>

Reviewed-by: E Shattow <lucent@gmail.com>
