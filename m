Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3D2C25B77
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 03:06:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81A158831F;
	Tue, 21 May 2024 05:06:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a/CLQOxG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F374886E2; Tue, 21 May 2024 05:06:11 +0200 (CEST)
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com
 [IPv6:2607:f8b0:4864:20::a36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89B8388315
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 05:06:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-4df344eecd7so1378983e0c.3
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 20:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716260767; x=1716865567; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aToLeXjHPcFnq5kqSZ+gnOIG1R/ZufuP/Fczkw4UZ4w=;
 b=a/CLQOxGFRdt/KDwWlJ73A6scTLz2KxRu/Sdno2GyN6dsrhhJaRgCXdh0X8StRBNSU
 1bmnKXUs7nyk9rC5/Qp6nvFTqCbQUlKQd2TVeK0f0OGL1D7GhiClod83tRcYrrigpZro
 P6S/F/pb0+F66sOXN8COfqayY6S/862U0NtAPX7FW4Mj+SZ4UB3gBM3HlrB4MfBHk42+
 +nxCfOncD0aUMlpZD5I4dGf7WWWmRYDhdL4aq6FQtzGI2QEQ35NbVDUXQXiQTZ4SUlzo
 wxq7XR6qStsTPwfC1V5Nj1HUyFb3Ll7JPVd/9vpQk4M6Yl2gKEzHxTSNr7fllcW9XXEY
 Wehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716260767; x=1716865567;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aToLeXjHPcFnq5kqSZ+gnOIG1R/ZufuP/Fczkw4UZ4w=;
 b=mOf+joRBLN5wa1C0P1PE4UsuXRh+CL2nU321Iv1+LKUYpIkHwqOKYszKgB8OHpDSi3
 4pgkEUO1Wo+bmMLGEoNvNdg+u8qYx7iF0cOI09CGkhpLFxxuP/nEpZDdLA2tIhwqtY6Y
 s2i9josEb+v9WN76Urtxv3mcN9SiIfGPw2kccXMhVBvLEmOzyQXKmJc9ESYNB1g4Yky6
 ld8yXFt5Ei5qn0uUgW/vddHovks+nqXE1ug4sclRm5G0r+zMbCjTGMdIUHCsU4+Mm5lA
 Di2eeOJd901BAfPgfvGQ4KOqAD3jUTqrHYMa4KeAlOiv6lyDI+onvOLoDBZTYhuLGOqt
 reNA==
X-Gm-Message-State: AOJu0YwC5KDrYrE1zirDtCeVIbk3j06zND9E6LFPfNwBiRfri9RrSgc1
 V36EcVe6ZnEhdQllQhZCEc5oMtvqE2E5AnHCAavzVE9fIBagQYLAH+47UnfsNVUoiVep3IfOsxR
 2dvwHH41MgU1jMcIpUNP4CYc2Lwo=
X-Google-Smtp-Source: AGHT+IGdq10p1k79iKKVzzoxo79URyXStCJqC4M5go5u2sWxXW3s6d82yXiX/U1PUjKmPoPIpFK7zWyPuJtrhvRatzU=
X-Received: by 2002:a05:6122:1da8:b0:4d8:7339:4c35 with SMTP id
 71dfb90a1353d-4df88367d77mr26818863e0c.13.1716260767050; Mon, 20 May 2024
 20:06:07 -0700 (PDT)
MIME-Version: 1.0
References: <AQPxMmhcaeYN5rt7y4Jg392tXwS9syCQiDuYw33ZbtjOpANLCaGUAx9nP2YjKGSDSka8vM5BQkV9DepT_8Q0ipjQO18tbbk_gk8CgPFDnGI=@protonmail.com>
In-Reply-To: <AQPxMmhcaeYN5rt7y4Jg392tXwS9syCQiDuYw33ZbtjOpANLCaGUAx9nP2YjKGSDSka8vM5BQkV9DepT_8Q0ipjQO18tbbk_gk8CgPFDnGI=@protonmail.com>
From: E Shattow <lucent@gmail.com>
Date: Mon, 20 May 2024 20:05:55 -0700
Message-ID: <CANV2PTOj0RHJaZfo=XDryM4=W_6Gxg4qf+COwF1gCYrVAApNfw@mail.gmail.com>
Subject: Re: [PATCH 2/2 v4] board: starfive: support Pine64 Star64 board
To: H Bell <dmoo_dv@protonmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

On Sun, May 19, 2024 at 9:43=E2=80=AFPM H Bell <dmoo_dv@protonmail.com> wro=
te:
>
> Add documentation files
>
> Signed-off-by: Henry Bell <dmoo_dv@protonmail.com>
> Cc: ycliang@andestech.com
> Cc: heinrich.schuchardt@canonical.com
> ---
>
> Changes since v1
>
> - New patch
>
> Changes since v2
>
> - Remove extra params to
> - Clarification on boot section
> - Add entry on MAC adresses and how to correct them
>
> Changes since v3
>
> - Rebase against d678a59d2d
> ---
>  doc/board/starfive/index.rst         |   1 +
>  doc/board/starfive/pine64_star64.rst | 136 +++++++++++++++++++++++++++
>  2 files changed, 137 insertions(+)
>  create mode 100644 doc/board/starfive/pine64_star64.rst
>
> diff --git a/doc/board/starfive/index.rst b/doc/board/starfive/index.rst
> index d369b986cc..72ab6ddfbf 100644
> --- a/doc/board/starfive/index.rst
> +++ b/doc/board/starfive/index.rst
> @@ -8,4 +8,5 @@ StarFive
>
>     milk-v_mars
>     milk-v_mars_cm
> +   pine64_star64
>     visionfive2
> diff --git a/doc/board/starfive/pine64_star64.rst b/doc/board/starfive/pi=
ne64_star64.rst
> new file mode 100644
> index 0000000000..567d1207ba
> --- /dev/null
> +++ b/doc/board/starfive/pine64_star64.rst
> @@ -0,0 +1,136 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +Pine64 Star64
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +U-Boot for the Star64 uses the same U-Boot binaries as the VisionFive 2 =
board.
> +In U-Boot SPL the actual board is detected and the device-tree patched
> +accordingly.
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
> +U-Boot will set variable $fdtfile to starfive/jh7110-pine64-star64.dtb.
> +
> +To overrule this selection the variable can be set manually and saved in=
 the
> +environment
> +
> +::
> +
> +    setenv fdtfile my_device-tree.dtb
> +    env save

Nit: prefer consistent sub-command as:
env set fdtfile my_device-tree.dtb

> +
> +or the configuration variable CONFIG_DEFAULT_FDT_FILE can be used to set=
 to
> +provide a default value.
> +
> +Boot source selection
> +~~~~~~~~~~~~~~~~~~~~~
> +

> +The board provides the DIP switches (marked S1804) adjacent to the 40pin=
 GPIO
> +Bus for boot selection. The ``L`` (0) and ``H`` (1) silk screening to th=
e side
> +of the should be used to determine state (not the ``ON/ONKE`` markings
> +physically on the component). ``GPIO_0`` is channel 2 on the switch, whi=
le
> +``GPIO_1`` is channel 1.

Suggested: "Boot mode is selected by an MSEL-DIP marked S1804 and GPIO_0
position adjacent to the 40pin GPIO header. ON/ONKE and number markings of =
the
MSEL-DIP are misleading; Instead refer to the ``L`` (0) and ``H`` (1)
silkscreen for
accurate selection."

> +
> ++ (QSPI) Flash: 00 ``??``
> ++ SD: 01 ``??``
> ++ EMMC: 10 ``??``
> ++ UART: 11 ``??``
> +
> +Preparing the SD-Card
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +The device firmware loads U-Boot SPL (u-boot-spl.bin.normal.out) from th=
e
> +partition with type GUID 2E54B353-1271-4842-806F-E436D6AF6985. You are f=
ree
> +to choose any partition number.
> +
> +With the default configuration U-Boot SPL loads the U-Boot FIT image
> +(u-boot.itb) from partition 2 (CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITIO=
N=3D0x2).
> +When formatting it is recommended to use GUID
> +BC13C2FF-59E6-4262-A352-B275FD6F7172 for this partition.
> +
> +The FIT image (u-boot.itb) is a combination of OpenSBI's fw_dynamic.bin,
> +u-boot-nodtb.bin and the device tree blob.
> +
> +Format the SD card (make sure the disk has GPT, otherwise use gdisk to s=
witch)
> +
> +.. code-block:: bash
> +
> +       sudo sgdisk --clear \
> +         --set-alignment=3D2 \
> +         --new=3D1:4096:8191 --change-name=3D1:spl --typecode=3D1:2E54B3=
53-1271-4842-806F-E436D6AF6985\
> +         --new=3D2:8192:16383 --change-name=3D2:uboot --typecode=3D2:BC1=
3C2FF-59E6-4262-A352-B275FD6F7172  \
> +         --new=3D3:16384:1654784 --change-name=3D3:system --typecode=3D3=
:EBD0A0A2-B9E5-4433-87C0-68B6B72699C7 \
> +         /dev/sdb
> +
> +Copy U-Boot to the SD card
> +
> +.. code-block:: bash
> +
> +       sudo dd if=3Du-boot-spl.bin.normal.out of=3D/dev/sdb1
> +       sudo dd if=3Du-boot.itb of=3D/dev/sdb2
> +
> +       sudo mount /dev/sdb3 /mnt/
> +       sudo cp u-boot-spl.bin.normal.out /mnt/
> +       sudo cp u-boot.itb /mnt/
> +       sudo cp Image.gz /mnt/
> +       sudo cp initramfs.cpio.gz /mnt/
> +       sudo cp jh7110-starfive-visionfive-2.dtb /mnt/
> +       sudo umount /mnt
> +
> +Booting
> +~~~~~~~
> +
> +Once you plugin the sdcard and power up, you should see the U-Boot promp=
t.
> +
> +MAC address issues

nay "Product ID and MAC address issues"

> +~~~~~~~~~~~~~~~~~~
> +

U-Boot requires valid EEPROM data to determine which board-specific fix-up =
to
apply at runtime. This affects the size of memory initialized, network
mac address
numbering, and tuning of the network PHYs.

Star64 8gb and 4gb models follow a pattern where the last mac address bytes=
 are
a sum of  0x7558 and the serial number (lower port mac0), or a sum of 0x755=
9 and
the serial number (upper port mac1). As tested there are several 4gb model =
units
where the serial number and network mac address numbering was not made
unique when compared to 8gb model units and even other 4gb model units.
Some early Star64 boards shipped with an uninitialized EEPROM and no write
protect pull-up resistor in place. Later units of all 4gb and 8gb models sh=
aring
the same serial number in EEPROM data will have this problem that the netwo=
rk
mac addresses are alike between different models and this may be corrected =
by
defeating the installed write protect pull-up resistor to write new
values. As an
alternative to defeating an installed write protect pull-up resistor
there is a possible
workaround to override mac addresses via U-Boot environment variables.

It is required for any unit having uninitialized EEPROM and recommended for
all later Star64 4gb model units (not properly serialized) to have decided =
on a
new 6-byte serial number. This serial number should be high enough to
avoid collision with other JH7110 boards and low enough not to overflow i.e=
.
between cafe00 and f00d00.

1. Prepare EEPROM data in memory

1a. when there is no error to load existing data:

``mac read_eeprom``

1b. when there is an error to load non-existing data:
"DRAM:  Not a StarFive EEPROM data format - magic error"

``mac initialize``

2. Common Star64 values

``mac vendor PINE64``
``mac pcb_revision c1``
``mac bom_revision A``

3. Unique Star64 values

# Year 2023 week 10 production date, 8GB DRAM, optional eMMC, serial cdef01
mac product_id STAR64V1-2310-D008E000-00cdef01

# Last three bytes mac0: 0x7558 + serial number 0xcdef01
mac mac0_address 6c:cf:39:ce:64:59

# Last three bytes mac1: 0x7559 + serial number 0xcdef01
mac mac1_address 6c:cf:39:ce:64:5a

4. Defeat write-protect pull-up resistor (if installed) and write

# write to EEPROM and clear local copy
mac write_eeprom

MAC address override via U-Boot environment variables:

> +The Star64 does not currently ship with unique serial numbers per-device=
.
> +Devices tested (all 4GiB RAM) have the same serial number of
> +``STAR64V1-2310-D004E000-00000005`` and the mac addresses of
> +``6c:cf:39:00:75:61`` (lower) and ``6c:cf:39:00:75:62`` (upper) port wil=
l be
> +assigned. Shipped models also have the EEPROM set as write protected, so=
 it
> +cannot be changed using ``mac`` commands.
> +
> +The MAC addresses may be "set" as follows by writing as a custom config =
to SPI
> +(Change the last 3 bytes of MAC addreses as appropriate):
> +
> +::
> +
> +       env set ethaddr 6c:cf:39:00:75:63
> +       env set eth1addr 6c:cf:39:00:75:64
> +       env save
> +       reset
> --
> 2.44.0
>
>

That feedback is a bit rough on the edges so hopefully some of that is usef=
ul.

-E
