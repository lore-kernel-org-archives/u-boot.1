Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E68C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 07:58:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC87388292;
	Tue, 16 Apr 2024 09:58:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BkJJ8AvM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B34F6882C4; Tue, 16 Apr 2024 09:58:53 +0200 (CEST)
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com
 [IPv6:2607:f8b0:4864:20::e2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F320B88020
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 09:58:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-47a1a2c4c7cso538994137.2
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 00:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713254330; x=1713859130; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X5+2tuLsZ2gA4lN9+cv3qZYnQX11/F8Y/KHWwVb84OY=;
 b=BkJJ8AvM2ddJ94H5GCamd63pzIX2zlYZhHQ3SFaoJXmh0tfu747ms7RE+uFUkuefIn
 JtcU7mwvpu6x+Lwv4u1QFmnD++x/nvuRMlxuHpBZLwI1BKs3edEs7vp+kDYbttdryMzi
 KJqNbMg6hMNp11ZVpLBELVvqD4rQWmRYHdovgEb9Z8r25nMUD1cevYflj3PD6Beh3Pig
 Bq2QCZedFs6H26hK3xEZ2of0l/uQlciwh2qohLIgMbUz4WXeAC0YO3j+Y6tr3sVundr8
 kA+qKblAFiMVLMkot6ausH4ykkiCQzJbzZd1JJpUTBN0Mqq9sBCA2Q+qEBe6Zf5N1Aoa
 yWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713254330; x=1713859130;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X5+2tuLsZ2gA4lN9+cv3qZYnQX11/F8Y/KHWwVb84OY=;
 b=D+zvb3SmCECXrHJNTcT7K7UWa9z7ln46X50eWfC92fmafKsFcEg/bmgCffyJg5WZha
 /2iRLH5Ra4wEy786O2Zq9vqTy19ta+eO46uMNYobx4WspKnVtNV6sNnNVPkdVt0p7nfE
 Uz6iM2njEK3pLA1l9xvvwRznYAzHRvcX0H3RbbmMLbr+qbZn5V5VGA+zftuj7+ftHlWt
 i8XUD9/Ol4rg+uJ3KRM0a+ttGMZlZQIVJLKo75WltBji/Er3/dQV2720+8FwzFqFYPPt
 T7h7QT5n1rd/9iC5eUH3uOAOILzg6AH+ELgg2j6O3rexbPtwLi/69Zg9EbkF2xTjw6+y
 rWHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUuhFfu78upbkwgbuSnphfEoWMZeuCjrRLGNgQnkXjDIID0VFPGdDskXP68UCZ8fOQ/63XgN72qMO4pRR8uH46W1CMwQ==
X-Gm-Message-State: AOJu0YwBTsGrhYH0kXlcqL21K6I3+AzW1tT+SVN477MR5d99K3SCfZAm
 zVPviRaN8NXeArjYlJdh/6dKuP2Cni84AxHp7b61cYVS9NLEbhbenTfridDSaA55YYBjGYra2FV
 C+03NDuBREte4i2vBsbEpouiJ/a0=
X-Google-Smtp-Source: AGHT+IFQguBUeCfaF04tR/k1/B7z2qmJNI7JgVXB8bvlgiSg/iuBUh3gd8b/ppn241MM1vo8IWqr5wpuDQrA8orf350=
X-Received: by 2002:a05:6102:3594:b0:47b:9704:2c75 with SMTP id
 h20-20020a056102359400b0047b97042c75mr871648vsu.5.1713254329572; Tue, 16 Apr
 2024 00:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240415115035.46199-1-heinrich.schuchardt@canonical.com>
 <20240415115035.46199-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240415115035.46199-4-heinrich.schuchardt@canonical.com>
From: E Shattow <lucent@gmail.com>
Date: Tue, 16 Apr 2024 00:58:38 -0700
Message-ID: <CANV2PTMjqQCXCpwk5AKwdoVnoV94MADrR3HUK72q88tPzKTyQQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] doc: Milk-V Mars CM and Milk-V Mars CM Lite
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, 
 Shengyu Qu <wiagn233@outlook.com>, Shiji Yang <yangshiji66@outlook.com>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, u-boot@lists.denx.de
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

On Mon, Apr 15, 2024 at 4:50=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Provide a man-page describing the usage of U-Boot on
> the Milk-V Mars CM and Milk-V Mars CM Lite boards.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  doc/board/starfive/index.rst          |   1 +
>  doc/board/starfive/milk-v_mars_cm.rst | 125 ++++++++++++++++++++++++++
>  2 files changed, 126 insertions(+)
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
> index 00000000000..4cd6034281c
> --- /dev/null
> +++ b/doc/board/starfive/milk-v_mars_cm.rst
> @@ -0,0 +1,125 @@
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
> +The Milk-V Mars CM Lite comes without eMMC it needs a different pin muxi=
ng.

JH7110 Technical Reference Manual does list some sdio related mux
function with this GPIO62/GPIO22 substitution. I did not hear back yet
from Milk-V developer support per my request for clarifying why this
is needed and relevant schematics. I want this explained more clearly
in documentation the purpose for this different pin muxing or why it
is needed in the U-Boot phase of the boot process for specifically
Milk-V Mars CM Lite (SD Card non-eMMC version). Previously I thought
it was something about the power regulator not having a complete
device driver in U-Boot but I don't know. Is it a bodge or is it
intentional for easier manufacture?

> +The size of the eMMC shows up in the serial number shown by the *mac* co=
mmand,
> +e.g. MARC-V10-2340-D002E016-00000304. The number after the E is the MMC =
size

The number may have 'T' suffix making this description wrong.
Describing as unit-less "size." is enough, so delete "in GB."

> +in GB. U-Boot takes a value of E000 as an indicator for the Lite version=
.

None of the Lite versions have eMMC so that can be inferred without
naming the specific product. Maybe in future there is some other need
for this config option so keep it generic.

Suggest "U-Boot takes a value of E000 as an indicator for not having an eMM=
C."

> +Unfortunately the vendor has not set this value correctly on some Lite b=
oards.

Milk-V developer support acknowledged 14th Apr 2024 my e-mail inquiry
about wrong EEPROM data, but did not comment (yet) on instructions for
a fix for boards that have wrong EEPROM data.

As for documentation we should have something that describes how to
confirm the data is correct and if it is not then what can be done, in
the case of fixing the EEPROM data and not.

Suggest to add:
"In default operation EEPROM Write Protect is enabled, and may be
disabled connecting the "GND" and "EN" test pads on top of the
module."

and an example of `mac product_id` also `mac write_eeprom` commands.
You can do this with a steady hand and a paperclip, as the pads are
accessible near the board edge even with the heatsink in place. Lest
we be blamed for bad decisions users make with a paperclip though, I
don't know if you want to include this information. I think it was
easy to do and future production runs should have the correct EEPROM
data value for eMMC so it would make sense to want to update this.

> +Please, use CONFIG_STARFIVE_NO_EMMC=3Dy to indicate a Milk-V Mars CM Lit=
e in this
> +case. Otherwise you will not be able to read from eMMC

Suggest: "Please, use CONFIG_STARFIVE_NO_EMMC=3Dy when EEPROM data
indicates eMMC is present on Milk-V Mars CM Lite. Otherwise you will
not be able to read from SD Card."

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
> +       make PLATFORM=3Dgeneric FW_TEXT_START=3D0x40000000 FW_OPTIONS=3D0

Is it needed to pass FW_OPTIONS ?

FW_TEXT_START is deprecated in opensbi commit d4d2582e (8th Apr 2024).
Keep for compatibility but noted here in review.

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
> +
> +To overrule this selection the variable can be set manually and saved in=
 the
> +environment
> +
> +::
> +
> +    setenv fdtfile my_device-tree.dtb
> +    env save
> +
> +or the configuration variable CONFIG_DEFAULT_FDT_FILE can be used to set=
 to
> +provide a default value.
> +
> +Boot source selection
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +The low speed connector nRPIBOOT line is used to switch the boot source.
> +
> +* If nRPIBOOT is connected to ground, the board boots from UART.
> +* If nRPIBOOT is not connected, the board boots from SPI flash.
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
> +install to the SPI flash with:
> +
> +::
> +
> +    sf probe
> +    load mmc 1:1 $kernel_addr_r u-boot-spl.bin.normal.out
> +    sf update $kernel_addr_r 0 $filesize
> +    load mmc 1:1 $kernel_addr_r u-boot.itb

In my testing of Mars CM Lite the SD-Card appears as mmc 0:1 and not
mmc 1:1. If you had eMMC that would be mmc 1:1, I guess, but I don't
have the Mars CM with eMMC version here to confirm. That description
could be changed to refer to eMMC, and/or example reflecting SD Card.
How is this on the Mars, is there both SD and eMMC?

> +    sf update $kernel_addr_r 0x100000 $filesize

I have been using $loadaddr for memory address with spi flash
procedure as less typing and easier to remember than $kernel_addr_r ;
Is there a reason or U-Boot convention for one or the other?

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

Prefix the following to reference the earlier explanation: "With
nRPIBOOT set for UART boot, power the board and upload..."

> +Upload u-boot-spl.bin.normal.out via XMODEM. Then upload u-boot.itb via
> +YMODEM.
> +
> +The XMODEM implementation in the boot ROM is not fully specification com=
pliant.
> +It sends too many NAKs in a row. Some tolerant terminal implementations =
exist.
> +Or use a dedicated recovery tool e.g.
> +https://github.com/xypron/JH71xx-tools/tree/VisionFive2:
> +
> +.. code-block:: bash
> +
> +    # send U-Boot SPL via XMODEM
> +    vf2-recover -D /dev/ttyUSB0 -r u-boot-spl.bin.normal.out
> +    # connect to board to transfer main U-Boot via YMODEM
> +    picocom --send-cmd 'sz -b -vv' --baud 115200 /dev/ttyUSB0
> +    # In Picocom use <CTRL+A>,<CTRL+S> to send u-boot.itb

Comment: I've been using 'tio' serial tool that has its own XMODEM and
YMODEM implementation not depending on 'sz'. Would like to see this as
an additional mention for an all-in-one tool if you can confirm that
it does not hit the JH7110 XMODEM implementation bug - I'm not sure,
but I have had success with it so I think it's okay. 'tio' is widely
available in Linux distros so that may be more convenient for users,
unless it does hit that bug and I haven't noticed it, I just tried a
lot of tools until finding that this seems to work for me.

> +
> +Booting from SPI flash
> +~~~~~~~~~~~~~~~~~~~~~~
> +
> +Once you power up, you should see the U-Boot prompt on the serial consol=
e.
> --
> 2.43.0
>
