Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6CFEE4993
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 08:37:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB9128645D;
	Wed, 23 Aug 2023 10:36:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20221208.gappssmtp.com header.i=@baylibre-com.20221208.gappssmtp.com header.b="WKDLmUwC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E91F86488; Wed, 23 Aug 2023 10:36:58 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F7E48645B
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 10:36:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fee600dce6so36696565e9.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 01:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1692779814; x=1693384614; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=af9c1lNh2/ln0Hu0zZHKb3/YlpbJwiMGOFpM0jSlEjw=;
 b=WKDLmUwCvpe5WSZV3xSeM7ayIpYDiD9D0MfxAfO9LktNxQJoUzwKPp6IAB0CxNCHPS
 tJ/NOhsrflVnWC2fGUnVu4fVuh2PDHjXkQ3dL94X7K9EADTfH7QbTAI4S8VIXELakTQ/
 omOIFUuPzP8ElyfyRxlKz1LkKaGa12LZg/oOhtymM5CRH6s+gjlHK8mVtKmdKHiDI4K/
 76conC7UonDwRaflIRRvT6Rp23Zfkh7/LLhgjICKZQaKf4Ri6MXgIfQEBf3hh8c39el0
 J75tGX/tJFmdj4XqOTnMAsr1KsesHv9kZfl6Hh8Ml7Zapg4+OBjWekmUj3PRRd1dTXu+
 C4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692779814; x=1693384614;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=af9c1lNh2/ln0Hu0zZHKb3/YlpbJwiMGOFpM0jSlEjw=;
 b=f+h0oiRqXtat5MIvvHF8wESgFLDySOenv6/kfgaS6jUWRKaT/uCk3UoRyHjb3QRAtO
 9wosmVV17fJF4h2Y3CQ8sm5gGLHLTjd9yBHLUGIipdb7SbrVw1GOOZF4ZrOE33fm4GjL
 KSecFk4ICH6YlFlwCdWu5cJywrOXPy0frprosg6pJ637KLzt09MYegvoV1BeQce00R8Q
 K8dtzAyRMeViWMW29fV1gXx+pSlwCZq8ENi3/ej0/fLRmCbS3B5o4s039sVdbhrCXVZ2
 1vHzqVxT4P1kEyE97rYF3L9kg4Xtxm/NHKLJWxc3nHZZtx7qTxmmF+tHfp1Y+q6K8XLO
 jY+A==
X-Gm-Message-State: AOJu0YwWzpurFNXVwsDdJ85vsl1YGCiR/Wse6cX6dwJEUGUIhpUohA4d
 Wh69ayWhLKQBSKYMyNb/LzxP9Q==
X-Google-Smtp-Source: AGHT+IFd5Q7DFFnqZUlfeLlWZhihBeG/m6mIt9DSFYuf6y3ELsEp+xSW4SGcPTxSKxoiYkHkclHPtQ==
X-Received: by 2002:a7b:c459:0:b0:3fe:d952:9910 with SMTP id
 l25-20020a7bc459000000b003fed9529910mr9978209wmi.6.1692779814338; 
 Wed, 23 Aug 2023 01:36:54 -0700 (PDT)
Received: from localhost ([2a01:cb19:8704:be00:4f55:bd9d:611a:6c8e])
 by smtp.gmail.com with ESMTPSA id
 v25-20020a7bcb59000000b003fe4548188bsm14034657wmj.48.2023.08.23.01.36.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 01:36:54 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Neha Francis <n-francis@ti.com>, Tom Rini
 <trini@konsulko.com>
Cc: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Jan
 Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>, Heinrich
 Schuchardt <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH V4 8/8] doc: board: ti: Add BeaglePlay documentation
In-Reply-To: <20230822184135.2328409-9-nm@ti.com>
References: <20230822184135.2328409-1-nm@ti.com>
 <20230822184135.2328409-9-nm@ti.com>
Date: Wed, 23 Aug 2023 10:36:53 +0200
Message-ID: <87fs4af93u.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Nishanth,

On mar., ao=C3=BBt 22, 2023 at 13:41, Nishanth Menon <nm@ti.com> wrote:

> Add base documentation for BeaglePlay
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

This is great! Thanks a lot for the documentation update, especially the
"Flash to eMMC" section.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> Changes Since V3:
> * Updated documentation to give a more clear overview of MMC partitions
>   and flashing information.
> * Added OpenOCD debug documentation
> * Added LED status information and indication of various boot stages
>
> V3: https://lore.kernel.org/all/20230815164440.2713726-5-nm@ti.com/
> V2: https://lore.kernel.org/u-boot/20230727234446.3651836-5-nm@ti.com/
> V1: https://lore.kernel.org/all/20230725185253.2123433-7-nm@ti.com/
>
>  doc/board/ti/am62x_beagleplay.rst    | 256 ++++++++++
>  doc/board/ti/img/beagleplay_emmc.svg | 697 +++++++++++++++++++++++++++
>  doc/board/ti/k3.rst                  |   1 +
>  3 files changed, 954 insertions(+)
>  create mode 100644 doc/board/ti/am62x_beagleplay.rst
>  create mode 100644 doc/board/ti/img/beagleplay_emmc.svg
>
> diff --git a/doc/board/ti/am62x_beagleplay.rst b/doc/board/ti/am62x_beagl=
eplay.rst
> new file mode 100644
> index 000000000000..5adb7b4c9ace
> --- /dev/null
> +++ b/doc/board/ti/am62x_beagleplay.rst
> @@ -0,0 +1,256 @@
> +.. SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
> +.. sectionauthor:: Nishanth Menon <nm@ti.com>
> +
> +AM62x Beagleboard.org Beagleplay
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Introduction:
> +-------------
> +
> +BeagleBoard.org BeaglePlay is an easy to use, affordable open source
> +hardware single board computer based on the Texas Instruments AM625
> +SoC that allows you to create connected devices that work even at long
> +distances using IEEE 802.15.4g LR-WPAN and IEEE 802.3cg 10Base-T1L.
> +Expansion is provided over open standards based mikroBUS, Grove and
> +QWIIC headers among other interfaces.
> +
> +Further information can be found at:
> +
> +* Product Page: https://beagleplay.org/
> +* Hardware documentation: https://git.beagleboard.org/beagleplay/beaglep=
lay
> +
> +Boot Flow:
> +----------
> +Below is the pictorial representation of boot flow:
> +
> +.. image:: img/boot_diagram_k3_current.svg
> +  :alt: Boot flow diagram
> +
> +- On this platform, 'TI Foundational Security' (TIFS) functions as the
> +  security enclave master while 'Device Manager' (DM), also known as the
> +  'TISCI server' in "TI terminology", offers all the essential services.
> +  The A53/M4F (Aux core) sends requests to TIFS/DM to accomplish these
> +  services, as illustrated in the diagram above.
> +
> +Sources:
> +--------
> +.. include::  k3.rst
> +    :start-after: .. k3_rst_include_start_boot_sources
> +    :end-before: .. k3_rst_include_end_boot_sources
> +
> +Build procedure:
> +----------------
> +0. Setup the environment variables:
> +
> +.. include::  k3.rst
> +    :start-after: .. k3_rst_include_start_common_env_vars_desc
> +    :end-before: .. k3_rst_include_end_common_env_vars_desc
> +
> +.. include::  k3.rst
> +    :start-after: .. k3_rst_include_start_board_env_vars_desc
> +    :end-before: .. k3_rst_include_end_board_env_vars_desc
> +
> +Set the variables corresponding to this platform:
> +
> +.. include::  k3.rst
> +    :start-after: .. k3_rst_include_start_common_env_vars_defn
> +    :end-before: .. k3_rst_include_end_common_env_vars_defn
> +.. code-block:: bash
> +
> + $ export UBOOT_CFG_CORTEXR=3D"am62x_evm_r5_defconfig beagleplay_r5.conf=
ig"
> + $ export UBOOT_CFG_CORTEXA=3D"am62x_evm_a53_defconfig beagleplay_a53.co=
nfig"
> + $ export TFA_BOARD=3Dlite
> + $ # we dont use any extra TFA parameters
> + $ unset TFA_EXTRA_ARGS
> + $ export OPTEE_PLATFORM=3Dk3-am62x
> + $ export OPTEE_EXTRA_ARGS=3D"CFG_WITH_SOFTWARE_PRNG=3Dy"
> +
> +.. include::  am62x_sk.rst
> +    :start-after: .. am62x_evm_rst_include_start_build_steps
> +    :end-before: .. am62x_evm_rst_include_end_build_steps
> +
> +Target Images
> +--------------
> +Copy the below images to an SD card and boot:
> +
> +* tiboot3-am62x-gp-evm.bin from R5 build as tiboot3.bin
> +* tispl.bin_unsigned from Cortex-A build as tispl.bin
> +* u-boot.img_unsigned from Cortex-A build as uboot.img
> +
> +Image formats:
> +--------------
> +
> +- tiboot3.bin
> +
> +.. image:: img/multi_cert_tiboot3.bin.svg
> +  :alt: tiboot3.bin image format
> +
> +- tispl.bin
> +
> +.. image:: img/dm_tispl.bin.svg
> +  :alt: tispl.bin image format
> +
> +Flash to eMMC
> +-------------
> +
> +The eMMC layout selected is user-friendly for developers. The
> +boot hardware partition of the eMMC only contains the fixed-size
> +tiboot3.bin image. This is because the contents of the boot partitions
> +need to run from the SoC's internal SRAM, which remains a fixed size
> +constant. The other components of the boot sequence, such as tispl.bin
> +and u-boot.img, are located in the /BOOT partition in the User Defined
> +Area (UDA) hardware partition of the eMMC. These components can vary
> +significantly in size, so readjusting the boot partition offsets is
> +not practical.
> +
> +.. image:: img/beagleplay_emmc.svg
> +  :alt: eMMC partitions and boot file organization for BeaglePlay
> +
> +The following are the steps from Linux shell to program eMMC:
> +
> +.. code-block:: bash
> +
> +  # # Enable Boot0 boot
> +  # mmc bootpart enable 1 2 /dev/mmcblk0
> +  # mmc bootbus set single_backward x1 x8 /dev/mmcblk0
> +  # mmc hwreset enable /dev/mmcblk0
> +
> +  # # Clear eMMC boot0
> +  # echo '0' >> /sys/class/block/mmcblk0boot0/force_ro
> +  # dd if=3D/dev/zero of=3D/dev/mmcblk0boot0 count=3D32 bs=3D128k
> +  # # Write tiboot3.bin
> +  # dd if=3Dtiboot3.bin of=3D/dev/mmcblk0boot0 bs=3D128k
> +
> +  # # Copy the rest of the boot binaries
> +  # mount /dev/mmcblk0p1 /boot/firmware
> +  # cp tispl.bin /boot/firmware
> +  # cp u-boot.img /boot/firmware
> +  # sync
> +
> +.. warning ::
> +
> +  The U-Boot is configured to prioritize booting from an SD card if
> +  it detects a valid boot partition and boot files on it, even if the
> +  system initially booted from eMMC. The boot order is set as follows:
> +
> +  * SD/MMC
> +  * eMMC
> +  * USB
> +  * PXE
> +
> +LED patterns during boot
> +------------------------
> +
> +.. list-table:: USR LED status indication
> +   :widths: 16 16
> +   :header-rows: 1
> +
> +   * - USR LEDs (012345)
> +     - Indicates
> +
> +   * - 00000
> +     - Boot failure or R5 image not started up
> +
> +   * - 11111
> +     - A53 SPL/U-boot has started up
> +
> +   * - 10101
> +     - OS boot process has been initiated
> +
> +   * - 01010
> +     - OS boot process failed and drops to U-Boot shell
> +
> +.. note ::
> +
> +  In the table above, 0 indicates LED switched off and 1 indicates LED
> +  switched ON.
> +
> +.. warning ::
> +
> +  If the "red" power LED is not glowing, the system power supply is not
> +  functional. Please refer to `BeaglePlay documentation
> +  <https://beagleplay.org/>`_ for further information.
> +
> +A53 SPL DDR Memory Layout
> +-------------------------
> +
> +.. include::  am62x_sk.rst
> +    :start-after: .. am62x_evm_rst_include_start_ddr_mem_layout
> +    :end-before: .. am62x_evm_rst_include_end_ddr_mem_layout
> +
> +Switch Setting for Boot Mode
> +----------------------------
> +
> +The boot time option is configured via "USR" button on the board.
> +See `Beagleplay Schematics <https://git.beagleboard.org/beagleplay/beagl=
eplay/-/blob/main/BeaglePlay_sch.pdf>`_
> +for details.
> +
> +.. list-table:: Boot Modes
> +   :widths: 16 16 16
> +   :header-rows: 1
> +
> +   * - USR Switch Position
> +     - Primary Boot
> +     - Secondary Boot
> +
> +   * - Not Pressed
> +     - eMMC
> +     - UART
> +
> +   * - Pressed
> +     - SD/MMC File System (FS) mode
> +     - USB Device Firmware Upgrade (DFU) mode
> +
> +To switch to SD card boot mode, hold the USR button while powering on
> +with Type-C power supply, then release when power LED lights up.
> +
> +Debugging U-Boot
> +----------------
> +
> +See :ref:`Common Debugging environment - OpenOCD<k3_rst_refer_openocd>`:=
 for
> +detailed setup and debugging information.
> +
> +.. warning::
> +
> +  **OpenOCD support since**: v0.12.0
> +
> +  If the default package version of OpenOCD in your development
> +  environment's distribution needs to be updated, it might be necessary =
to
> +  build OpenOCD from the source.
> +
> +.. include::  k3.rst
> +    :start-after: .. k3_rst_include_start_openocd_connect_tag_connect
> +    :end-before: .. k3_rst_include_end_openocd_connect_tag_connect
> +
> +.. include::  k3.rst
> +    :start-after: .. k3_rst_include_start_openocd_cfg_external_intro
> +    :end-before: .. k3_rst_include_end_openocd_cfg_external_intro
> +
> +For example, with BeaglePlay (AM62X platform), the openocd_connect.cfg:
> +
> +.. code-block:: tcl
> +
> +  # TUMPA example:
> +  # http://www.tiaowiki.com/w/TIAO_USB_Multi_Protocol_Adapter_User's_Man=
ual
> +  source [find interface/ftdi/tumpa.cfg]
> +
> +  transport select jtag
> +
> +  # default JTAG configuration has only SRST and no TRST
> +  reset_config srst_only srst_push_pull
> +
> +  # delay after SRST goes inactive
> +  adapter srst delay 20
> +
> +  if { ![info exists SOC] } {
> +    # Set the SoC of interest
> +    set SOC am625
> +  }
> +
> +  source [find target/ti_k3.cfg]
> +
> +  ftdi tdo_sample_edge falling
> +
> +  # Speeds for FT2232H are in multiples of 2, and 32MHz is tops
> +  # max speed we seem to achieve is ~20MHz.. so we pick 16MHz
> +  adapter speed 16000
> diff --git a/doc/board/ti/img/beagleplay_emmc.svg b/doc/board/ti/img/beag=
leplay_emmc.svg
> new file mode 100644
> index 000000000000..2dec871d6fdd
> --- /dev/null
> +++ b/doc/board/ti/img/beagleplay_emmc.svg
> @@ -0,0 +1,697 @@
> +<?xml version=3D"1.0" encoding=3D"UTF-8" standalone=3D"no"?>
> +<!--SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause-->
> +
> +<!--Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.c=
om/-->
> +
> +<svg
> +   version=3D"1.1"
> +   width=3D"771px"
> +   height=3D"351px"
> +   viewBox=3D"-0.5 -0.5 771 351"
> +   id=3D"svg142"
> +   sodipodi:docname=3D"beagleplay_emmc.svg"
> +   inkscape:version=3D"1.1.2 (0a00cf5339, 2022-02-04)"
> +   xmlns:inkscape=3D"http://www.inkscape.org/namespaces/inkscape"
> +   xmlns:sodipodi=3D"http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
> +   xmlns:xlink=3D"http://www.w3.org/1999/xlink"
> +   xmlns=3D"http://www.w3.org/2000/svg"
> +   xmlns:svg=3D"http://www.w3.org/2000/svg"
> +   xmlns:xhtml=3D"http://www.w3.org/1999/xhtml">
> +  <sodipodi:namedview
> +     id=3D"namedview144"
> +     pagecolor=3D"#ffffff"
> +     bordercolor=3D"#666666"
> +     borderopacity=3D"1.0"
> +     inkscape:pageshadow=3D"2"
> +     inkscape:pageopacity=3D"0.0"
> +     inkscape:pagecheckerboard=3D"0"
> +     showgrid=3D"false"
> +     inkscape:zoom=3D"1.460441"
> +     inkscape:cx=3D"380.0222"
> +     inkscape:cy=3D"175.28952"
> +     inkscape:window-width=3D"3440"
> +     inkscape:window-height=3D"1416"
> +     inkscape:window-x=3D"0"
> +     inkscape:window-y=3D"0"
> +     inkscape:window-maximized=3D"1"
> +     inkscape:current-layer=3D"g18" />
> +  <defs
> +     id=3D"defs2" />
> +  <g
> +     id=3D"g132">
> +    <rect
> +       x=3D"90"
> +       y=3D"0"
> +       width=3D"120"
> +       height=3D"60"
> +       fill=3D"rgb(255, 255, 255)"
> +       stroke=3D"rgb(0, 0, 0)"
> +       pointer-events=3D"all"
> +       id=3D"rect4" />
> +    <rect
> +       x=3D"210"
> +       y=3D"0"
> +       width=3D"120"
> +       height=3D"60"
> +       fill=3D"rgb(255, 255, 255)"
> +       stroke=3D"rgb(0, 0, 0)"
> +       pointer-events=3D"all"
> +       id=3D"rect6" />
> +    <rect
> +       x=3D"330"
> +       y=3D"0"
> +       width=3D"120"
> +       height=3D"60"
> +       fill=3D"rgb(255, 255, 255)"
> +       stroke=3D"rgb(0, 0, 0)"
> +       pointer-events=3D"all"
> +       id=3D"rect8" />
> +    <rect
> +       x=3D"450"
> +       y=3D"0"
> +       width=3D"320"
> +       height=3D"60"
> +       fill=3D"rgb(255, 255, 255)"
> +       stroke=3D"rgb(0, 0, 0)"
> +       pointer-events=3D"all"
> +       id=3D"rect10" />
> +    <rect
> +       x=3D"120"
> +       y=3D"15"
> +       width=3D"60"
> +       height=3D"30"
> +       fill=3D"none"
> +       stroke=3D"none"
> +       pointer-events=3D"all"
> +       id=3D"rect12" />
> +    <g
> +       transform=3D"translate(-0.5 -0.5)"
> +       id=3D"g18">
> +      <switch
> +         id=3D"switch16">
> +        <foreignObject
> +           pointer-events=3D"none"
> +           width=3D"100%"
> +           height=3D"100%"
> +           requiredFeatures=3D"http://www.w3.org/TR/SVG11/feature#Extens=
ibility"
> +           style=3D"overflow: visible; text-align: left;">
> +          <xhtml:div
> +             style=3D"display: flex; align-items: unsafe center; justify=
-content: unsafe center; width: 58px; height: 1px; padding-top: 30px; margi=
n-left: 121px;">
> +            <xhtml:div
> +               data-drawio-colors=3D"color: rgb(0, 0, 0); "
> +               style=3D"box-sizing: border-box; font-size: 0px; text-ali=
gn: center;">
> +              <xhtml:div
> +                 style=3D"display: inline-block; font-size: 12px; font-f=
amily: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: al=
l; white-space: normal; overflow-wrap: normal;">Boot0</xhtml:div>
> +            </xhtml:div>
> +          </xhtml:div>
> +        </foreignObject>
> +        <text
> +           x=3D"150"
> +           y=3D"34"
> +           fill=3D"#000000"
> +           font-family=3D"Helvetica"
> +           font-size=3D"12px"
> +           text-anchor=3D"middle"
> +           id=3D"text14">Boot0</text>
> +      </switch>
> +    </g>
> +    <rect
> +       x=3D"240"
> +       y=3D"15"
> +       width=3D"60"
> +       height=3D"30"
> +       fill=3D"none"
> +       stroke=3D"none"
> +       pointer-events=3D"all"
> +       id=3D"rect20" />
> +    <g
> +       transform=3D"translate(-0.5 -0.5)"
> +       id=3D"g26">
> +      <switch
> +         id=3D"switch24">
> +        <foreignObject
> +           pointer-events=3D"none"
> +           width=3D"100%"
> +           height=3D"100%"
> +           requiredFeatures=3D"http://www.w3.org/TR/SVG11/feature#Extens=
ibility"
> +           style=3D"overflow: visible; text-align: left;">
> +          <xhtml:div
> +             style=3D"display: flex; align-items: unsafe center; justify=
-content: unsafe center; width: 58px; height: 1px; padding-top: 30px; margi=
n-left: 241px;">
> +            <xhtml:div
> +               data-drawio-colors=3D"color: rgb(0, 0, 0); "
> +               style=3D"box-sizing: border-box; font-size: 0px; text-ali=
gn: center;">
> +              <xhtml:div
> +                 style=3D"display: inline-block; font-size: 12px; font-f=
amily: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: al=
l; white-space: normal; overflow-wrap: normal;">Boot1</xhtml:div>
> +            </xhtml:div>
> +          </xhtml:div>
> +        </foreignObject>
> +        <text
> +           x=3D"270"
> +           y=3D"34"
> +           fill=3D"rgb(0, 0, 0)"
> +           font-family=3D"Helvetica"
> +           font-size=3D"12px"
> +           text-anchor=3D"middle"
> +           id=3D"text22">Boot1</text>
> +      </switch>
> +    </g>
> +    <rect
> +       x=3D"360"
> +       y=3D"15"
> +       width=3D"60"
> +       height=3D"30"
> +       fill=3D"none"
> +       stroke=3D"none"
> +       pointer-events=3D"all"
> +       id=3D"rect28" />
> +    <g
> +       transform=3D"translate(-0.5 -0.5)"
> +       id=3D"g34">
> +      <switch
> +         id=3D"switch32">
> +        <foreignObject
> +           pointer-events=3D"none"
> +           width=3D"100%"
> +           height=3D"100%"
> +           requiredFeatures=3D"http://www.w3.org/TR/SVG11/feature#Extens=
ibility"
> +           style=3D"overflow: visible; text-align: left;">
> +          <xhtml:div
> +             style=3D"display: flex; align-items: unsafe center; justify=
-content: unsafe center; width: 58px; height: 1px; padding-top: 30px; margi=
n-left: 361px;">
> +            <xhtml:div
> +               data-drawio-colors=3D"color: rgb(0, 0, 0); "
> +               style=3D"box-sizing: border-box; font-size: 0px; text-ali=
gn: center;">
> +              <xhtml:div
> +                 style=3D"display: inline-block; font-size: 12px; font-f=
amily: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: al=
l; white-space: normal; overflow-wrap: normal;">RPMB</xhtml:div>
> +            </xhtml:div>
> +          </xhtml:div>
> +        </foreignObject>
> +        <text
> +           x=3D"390"
> +           y=3D"34"
> +           fill=3D"rgb(0, 0, 0)"
> +           font-family=3D"Helvetica"
> +           font-size=3D"12px"
> +           text-anchor=3D"middle"
> +           id=3D"text30">RPMB</text>
> +      </switch>
> +    </g>
> +    <rect
> +       x=3D"480"
> +       y=3D"15"
> +       width=3D"280"
> +       height=3D"30"
> +       fill=3D"none"
> +       stroke=3D"none"
> +       pointer-events=3D"all"
> +       id=3D"rect36" />
> +    <g
> +       transform=3D"translate(-0.5 -0.5)"
> +       id=3D"g42">
> +      <switch
> +         id=3D"switch40">
> +        <foreignObject
> +           pointer-events=3D"none"
> +           width=3D"100%"
> +           height=3D"100%"
> +           requiredFeatures=3D"http://www.w3.org/TR/SVG11/feature#Extens=
ibility"
> +           style=3D"overflow: visible; text-align: left;">
> +          <xhtml:div
> +             style=3D"display: flex; align-items: unsafe center; justify=
-content: unsafe center; width: 278px; height: 1px; padding-top: 30px; marg=
in-left: 481px;">
> +            <xhtml:div
> +               data-drawio-colors=3D"color: rgb(0, 0, 0); "
> +               style=3D"box-sizing: border-box; font-size: 0px; text-ali=
gn: center;">
> +              <xhtml:div
> +                 style=3D"display: inline-block; font-size: 12px; font-f=
amily: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: al=
l; white-space: normal; overflow-wrap: normal;">User Defined Area (UDA)</xh=
tml:div>
> +            </xhtml:div>
> +          </xhtml:div>
> +        </foreignObject>
> +        <text
> +           x=3D"620"
> +           y=3D"34"
> +           fill=3D"rgb(0, 0, 0)"
> +           font-family=3D"Helvetica"
> +           font-size=3D"12px"
> +           text-anchor=3D"middle"
> +           id=3D"text38">User Defined Area (UDA)</text>
> +      </switch>
> +    </g>
> +    <rect
> +       x=3D"450"
> +       y=3D"60"
> +       width=3D"70"
> +       height=3D"60"
> +       rx=3D"9"
> +       ry=3D"9"
> +       fill=3D"rgb(255, 255, 255)"
> +       stroke=3D"rgb(0, 0, 0)"
> +       pointer-events=3D"all"
> +       id=3D"rect44" />
> +    <g
> +       transform=3D"translate(-0.5 -0.5)"
> +       id=3D"g50">
> +      <switch
> +         id=3D"switch48">
> +        <foreignObject
> +           pointer-events=3D"none"
> +           width=3D"100%"
> +           height=3D"100%"
> +           requiredFeatures=3D"http://www.w3.org/TR/SVG11/feature#Extens=
ibility"
> +           style=3D"overflow: visible; text-align: left;">
> +          <xhtml:div
> +             style=3D"display: flex; align-items: unsafe center; justify=
-content: unsafe center; width: 68px; height: 1px; padding-top: 90px; margi=
n-left: 451px;">
> +            <xhtml:div
> +               data-drawio-colors=3D"color: rgb(0, 0, 0); "
> +               style=3D"box-sizing: border-box; font-size: 0px; text-ali=
gn: center;">
> +              <xhtml:div
> +                 style=3D"display: inline-block; font-size: 12px; font-f=
amily: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: al=
l; white-space: normal; overflow-wrap: normal;">BOOT</xhtml:div>
> +            </xhtml:div>
> +          </xhtml:div>
> +        </foreignObject>
> +        <text
> +           x=3D"485"
> +           y=3D"94"
> +           fill=3D"rgb(0, 0, 0)"
> +           font-family=3D"Helvetica"
> +           font-size=3D"12px"
> +           text-anchor=3D"middle"
> +           id=3D"text46">BOOT</text>
> +      </switch>
> +    </g>
> +    <rect
> +       x=3D"520"
> +       y=3D"60"
> +       width=3D"120"
> +       height=3D"60"
> +       rx=3D"9"
> +       ry=3D"9"
> +       fill=3D"rgb(255, 255, 255)"
> +       stroke=3D"rgb(0, 0, 0)"
> +       pointer-events=3D"all"
> +       id=3D"rect52" />
> +    <g
> +       transform=3D"translate(-0.5 -0.5)"
> +       id=3D"g58">
> +      <switch
> +         id=3D"switch56">
> +        <foreignObject
> +           pointer-events=3D"none"
> +           width=3D"100%"
> +           height=3D"100%"
> +           requiredFeatures=3D"http://www.w3.org/TR/SVG11/feature#Extens=
ibility"
> +           style=3D"overflow: visible; text-align: left;">
> +          <xhtml:div
> +             style=3D"display: flex; align-items: unsafe center; justify=
-content: unsafe center; width: 118px; height: 1px; padding-top: 90px; marg=
in-left: 521px;">
> +            <xhtml:div
> +               data-drawio-colors=3D"color: rgb(0, 0, 0); "
> +               style=3D"box-sizing: border-box; font-size: 0px; text-ali=
gn: center;">
> +              <xhtml:div
> +                 style=3D"display: inline-block; font-size: 12px; font-f=
amily: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: al=
l; white-space: normal; overflow-wrap: normal;">rootfs</xhtml:div>
> +            </xhtml:div>
> +          </xhtml:div>
> +        </foreignObject>
> +        <text
> +           x=3D"580"
> +           y=3D"94"
> +           fill=3D"rgb(0, 0, 0)"
> +           font-family=3D"Helvetica"
> +           font-size=3D"12px"
> +           text-anchor=3D"middle"
> +           id=3D"text54">rootfs</text>
> +      </switch>
> +    </g>
> +    <rect
> +       x=3D"700"
> +       y=3D"60"
> +       width=3D"70"
> +       height=3D"60"
> +       rx=3D"9"
> +       ry=3D"9"
> +       fill=3D"rgb(255, 255, 255)"
> +       stroke=3D"rgb(0, 0, 0)"
> +       pointer-events=3D"all"
> +       id=3D"rect60" />
> +    <g
> +       transform=3D"translate(-0.5 -0.5)"
> +       id=3D"g66">
> +      <switch
> +         id=3D"switch64">
> +        <foreignObject
> +           pointer-events=3D"none"
> +           width=3D"100%"
> +           height=3D"100%"
> +           requiredFeatures=3D"http://www.w3.org/TR/SVG11/feature#Extens=
ibility"
> +           style=3D"overflow: visible; text-align: left;">
> +          <xhtml:div
> +             style=3D"display: flex; align-items: unsafe center; justify=
-content: unsafe center; width: 68px; height: 1px; padding-top: 90px; margi=
n-left: 701px;">
> +            <xhtml:div
> +               data-drawio-colors=3D"color: rgb(0, 0, 0); "
> +               style=3D"box-sizing: border-box; font-size: 0px; text-ali=
gn: center;">
> +              <xhtml:div
> +                 style=3D"display: inline-block; font-size: 12px; font-f=
amily: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: al=
l; white-space: normal; overflow-wrap: normal;">swap</xhtml:div>
> +            </xhtml:div>
> +          </xhtml:div>
> +        </foreignObject>
> +        <text
> +           x=3D"735"
> +           y=3D"94"
> +           fill=3D"rgb(0, 0, 0)"
> +           font-family=3D"Helvetica"
> +           font-size=3D"12px"
> +           text-anchor=3D"middle"
> +           id=3D"text62">swap</text>
> +      </switch>
> +    </g>
> +    <rect
> +       x=3D"640"
> +       y=3D"60"
> +       width=3D"60"
> +       height=3D"60"
> +       rx=3D"9"
> +       ry=3D"9"
> +       fill=3D"rgb(255, 255, 255)"
> +       stroke=3D"rgb(0, 0, 0)"
> +       pointer-events=3D"all"
> +       id=3D"rect68" />
> +    <g
> +       transform=3D"translate(-0.5 -0.5)"
> +       id=3D"g74">
> +      <switch
> +         id=3D"switch72">
> +        <foreignObject
> +           pointer-events=3D"none"
> +           width=3D"100%"
> +           height=3D"100%"
> +           requiredFeatures=3D"http://www.w3.org/TR/SVG11/feature#Extens=
ibility"
> +           style=3D"overflow: visible; text-align: left;">
> +          <xhtml:div
> +             style=3D"display: flex; align-items: unsafe center; justify=
-content: unsafe center; width: 58px; height: 1px; padding-top: 90px; margi=
n-left: 641px;">
> +            <xhtml:div
> +               data-drawio-colors=3D"color: rgb(0, 0, 0); "
> +               style=3D"box-sizing: border-box; font-size: 0px; text-ali=
gn: center;">
> +              <xhtml:div
> +                 style=3D"display: inline-block; font-size: 12px; font-f=
amily: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: al=
l; white-space: normal; overflow-wrap: normal;">...</xhtml:div>
> +            </xhtml:div>
> +          </xhtml:div>
> +        </foreignObject>
> +        <text
> +           x=3D"670"
> +           y=3D"94"
> +           fill=3D"rgb(0, 0, 0)"
> +           font-family=3D"Helvetica"
> +           font-size=3D"12px"
> +           text-anchor=3D"middle"
> +           id=3D"text70">...</text>
> +      </switch>
> +    </g>
> +    <path
> +       d=3D"M 130 130 L 180 130 L 180 180 L 100 180 L 100 160 Z"
> +       fill=3D"#f8cecc"
> +       stroke=3D"#b85450"
> +       stroke-miterlimit=3D"10"
> +       pointer-events=3D"all"
> +       id=3D"path76" />
> +    <g
> +       transform=3D"translate(-0.5 -0.5)"
> +       id=3D"g82">
> +      <switch
> +         id=3D"switch80">
> +        <foreignObject
> +           pointer-events=3D"none"
> +           width=3D"100%"
> +           height=3D"100%"
> +           requiredFeatures=3D"http://www.w3.org/TR/SVG11/feature#Extens=
ibility"
> +           style=3D"overflow: visible; text-align: left;">
> +          <xhtml:div
> +             style=3D"display: flex; align-items: unsafe center; justify=
-content: unsafe center; width: 78px; height: 1px; padding-top: 155px; marg=
in-left: 101px;">
> +            <xhtml:div
> +               data-drawio-colors=3D"color: rgb(0, 0, 0); "
> +               style=3D"box-sizing: border-box; font-size: 0px; text-ali=
gn: center;">
> +              <xhtml:div
> +                 style=3D"display: inline-block; font-size: 12px; font-f=
amily: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: al=
l; white-space: normal; overflow-wrap: normal;">tiboot3.bin</xhtml:div>
> +            </xhtml:div>
> +          </xhtml:div>
> +        </foreignObject>
> +        <text
> +           x=3D"140"
> +           y=3D"159"
> +           fill=3D"rgb(0, 0, 0)"
> +           font-family=3D"Helvetica"
> +           font-size=3D"12px"
> +           text-anchor=3D"middle"
> +           id=3D"text78">tiboot3.bin</text>
> +      </switch>
> +    </g>
> +    <path
> +       d=3D"M 470 130 L 520 130 L 520 180 L 440 180 L 440 160 Z"
> +       fill=3D"#d5e8d4"
> +       stroke=3D"#82b366"
> +       stroke-miterlimit=3D"10"
> +       pointer-events=3D"all"
> +       id=3D"path84" />
> +    <g
> +       transform=3D"translate(-0.5 -0.5)"
> +       id=3D"g90">
> +      <switch
> +         id=3D"switch88">
> +        <foreignObject
> +           pointer-events=3D"none"
> +           width=3D"100%"
> +           height=3D"100%"
> +           requiredFeatures=3D"http://www.w3.org/TR/SVG11/feature#Extens=
ibility"
> +           style=3D"overflow: visible; text-align: left;">
> +          <xhtml:div
> +             style=3D"display: flex; align-items: unsafe center; justify=
-content: unsafe center; width: 78px; height: 1px; padding-top: 155px; marg=
in-left: 441px;">
> +            <xhtml:div
> +               data-drawio-colors=3D"color: rgb(0, 0, 0); "
> +               style=3D"box-sizing: border-box; font-size: 0px; text-ali=
gn: center;">
> +              <xhtml:div
> +                 style=3D"display: inline-block; font-size: 12px; font-f=
amily: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: al=
l; white-space: normal; overflow-wrap: normal;">tispl.bin</xhtml:div>
> +            </xhtml:div>
> +          </xhtml:div>
> +        </foreignObject>
> +        <text
> +           x=3D"480"
> +           y=3D"159"
> +           fill=3D"rgb(0, 0, 0)"
> +           font-family=3D"Helvetica"
> +           font-size=3D"12px"
> +           text-anchor=3D"middle"
> +           id=3D"text86">tispl.bin</text>
> +      </switch>
> +    </g>
> +    <path
> +       d=3D"M 470 180 L 520 180 L 520 230 L 440 230 L 440 210 Z"
> +       fill=3D"#d5e8d4"
> +       stroke=3D"#82b366"
> +       stroke-miterlimit=3D"10"
> +       pointer-events=3D"all"
> +       id=3D"path92" />
> +    <g
> +       transform=3D"translate(-0.5 -0.5)"
> +       id=3D"g98">
> +      <switch
> +         id=3D"switch96">
> +        <foreignObject
> +           pointer-events=3D"none"
> +           width=3D"100%"
> +           height=3D"100%"
> +           requiredFeatures=3D"http://www.w3.org/TR/SVG11/feature#Extens=
ibility"
> +           style=3D"overflow: visible; text-align: left;">
> +          <xhtml:div
> +             style=3D"display: flex; align-items: unsafe center; justify=
-content: unsafe center; width: 78px; height: 1px; padding-top: 205px; marg=
in-left: 441px;">
> +            <xhtml:div
> +               data-drawio-colors=3D"color: rgb(0, 0, 0); "
> +               style=3D"box-sizing: border-box; font-size: 0px; text-ali=
gn: center;">
> +              <xhtml:div
> +                 style=3D"display: inline-block; font-size: 12px; font-f=
amily: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: al=
l; white-space: normal; overflow-wrap: normal;">u-boot.img</xhtml:div>
> +            </xhtml:div>
> +          </xhtml:div>
> +        </foreignObject>
> +        <text
> +           x=3D"480"
> +           y=3D"209"
> +           fill=3D"rgb(0, 0, 0)"
> +           font-family=3D"Helvetica"
> +           font-size=3D"12px"
> +           text-anchor=3D"middle"
> +           id=3D"text94">u-boot.img</text>
> +      </switch>
> +    </g>
> +    <path
> +       d=3D"M 420 300 L 520 300 L 520 350 L 390 350 L 390 330 Z"
> +       fill=3D"#e1d5e7"
> +       stroke=3D"#9673a6"
> +       stroke-miterlimit=3D"10"
> +       pointer-events=3D"all"
> +       id=3D"path100" />
> +    <g
> +       transform=3D"translate(-0.5 -0.5)"
> +       id=3D"g106">
> +      <switch
> +         id=3D"switch104">
> +        <foreignObject
> +           pointer-events=3D"none"
> +           width=3D"100%"
> +           height=3D"100%"
> +           requiredFeatures=3D"http://www.w3.org/TR/SVG11/feature#Extens=
ibility"
> +           style=3D"overflow: visible; text-align: left;">
> +          <xhtml:div
> +             style=3D"display: flex; align-items: unsafe center; justify=
-content: unsafe center; width: 128px; height: 1px; padding-top: 325px; mar=
gin-left: 391px;">
> +            <xhtml:div
> +               data-drawio-colors=3D"color: rgb(0, 0, 0); "
> +               style=3D"box-sizing: border-box; font-size: 0px; text-ali=
gn: center;">
> +              <xhtml:div
> +                 style=3D"display: inline-block; font-size: 12px; font-f=
amily: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: al=
l; white-space: normal; overflow-wrap: normal;">extlinux/extlinux.conf</xht=
ml:div>
> +            </xhtml:div>
> +          </xhtml:div>
> +        </foreignObject>
> +        <text
> +           x=3D"455"
> +           y=3D"329"
> +           fill=3D"rgb(0, 0, 0)"
> +           font-family=3D"Helvetica"
> +           font-size=3D"12px"
> +           text-anchor=3D"middle"
> +           id=3D"text102">extlinux/extlinux.conf</text>
> +      </switch>
> +    </g>
> +    <path
> +       d=3D"M 420 240 L 520 240 L 520 290 L 390 290 L 390 270 Z"
> +       fill=3D"#dae8fc"
> +       stroke=3D"#6c8ebf"
> +       stroke-miterlimit=3D"10"
> +       pointer-events=3D"all"
> +       id=3D"path108" />
> +    <g
> +       transform=3D"translate(-0.5 -0.5)"
> +       id=3D"g114">
> +      <switch
> +         id=3D"switch112">
> +        <foreignObject
> +           pointer-events=3D"none"
> +           width=3D"100%"
> +           height=3D"100%"
> +           requiredFeatures=3D"http://www.w3.org/TR/SVG11/feature#Extens=
ibility"
> +           style=3D"overflow: visible; text-align: left;">
> +          <xhtml:div
> +             style=3D"display: flex; align-items: unsafe center; justify=
-content: unsafe center; width: 128px; height: 1px; padding-top: 265px; mar=
gin-left: 391px;">
> +            <xhtml:div
> +               data-drawio-colors=3D"color: rgb(0, 0, 0); "
> +               style=3D"box-sizing: border-box; font-size: 0px; text-ali=
gn: center;">
> +              <xhtml:div
> +                 style=3D"display: inline-block; font-size: 12px; font-f=
amily: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: al=
l; white-space: normal; overflow-wrap: normal;">uEnv.txt / boot.scr<xhtml:b=
r />
> +(optional)</xhtml:div>
> +            </xhtml:div>
> +          </xhtml:div>
> +        </foreignObject>
> +        <text
> +           x=3D"455"
> +           y=3D"269"
> +           fill=3D"rgb(0, 0, 0)"
> +           font-family=3D"Helvetica"
> +           font-size=3D"12px"
> +           text-anchor=3D"middle"
> +           id=3D"text110">uEnv.txt / boot.scr...</text>
> +      </switch>
> +    </g>
> +    <rect
> +       x=3D"0"
> +       y=3D"15"
> +       width=3D"60"
> +       height=3D"30"
> +       fill=3D"none"
> +       stroke=3D"none"
> +       pointer-events=3D"all"
> +       id=3D"rect116" />
> +    <g
> +       transform=3D"translate(-0.5 -0.5)"
> +       id=3D"g122">
> +      <switch
> +         id=3D"switch120">
> +        <foreignObject
> +           pointer-events=3D"none"
> +           width=3D"100%"
> +           height=3D"100%"
> +           requiredFeatures=3D"http://www.w3.org/TR/SVG11/feature#Extens=
ibility"
> +           style=3D"overflow: visible; text-align: left;">
> +          <xhtml:div
> +             style=3D"display: flex; align-items: unsafe center; justify=
-content: unsafe center; width: 58px; height: 1px; padding-top: 30px; margi=
n-left: 1px;">
> +            <xhtml:div
> +               data-drawio-colors=3D"color: rgb(0, 0, 0); "
> +               style=3D"box-sizing: border-box; font-size: 0px; text-ali=
gn: center;">
> +              <xhtml:div
> +                 style=3D"display: inline-block; font-size: 12px; font-f=
amily: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: al=
l; white-space: normal; overflow-wrap: normal;">eMMC<xhtml:br />
> +hardware partitions</xhtml:div>
> +            </xhtml:div>
> +          </xhtml:div>
> +        </foreignObject>
> +        <text
> +           x=3D"30"
> +           y=3D"34"
> +           fill=3D"rgb(0, 0, 0)"
> +           font-family=3D"Helvetica"
> +           font-size=3D"12px"
> +           text-anchor=3D"middle"
> +           id=3D"text118">eMMC...</text>
> +      </switch>
> +    </g>
> +    <rect
> +       x=3D"365"
> +       y=3D"75"
> +       width=3D"60"
> +       height=3D"30"
> +       fill=3D"none"
> +       stroke=3D"none"
> +       pointer-events=3D"all"
> +       id=3D"rect124" />
> +    <g
> +       transform=3D"translate(-0.5 -0.5)"
> +       id=3D"g130">
> +      <switch
> +         id=3D"switch128">
> +        <foreignObject
> +           pointer-events=3D"none"
> +           width=3D"100%"
> +           height=3D"100%"
> +           requiredFeatures=3D"http://www.w3.org/TR/SVG11/feature#Extens=
ibility"
> +           style=3D"overflow: visible; text-align: left;">
> +          <xhtml:div
> +             style=3D"display: flex; align-items: unsafe center; justify=
-content: unsafe center; width: 58px; height: 1px; padding-top: 90px; margi=
n-left: 366px;">
> +            <xhtml:div
> +               data-drawio-colors=3D"color: rgb(0, 0, 0); "
> +               style=3D"box-sizing: border-box; font-size: 0px; text-ali=
gn: center;">
> +              <xhtml:div
> +                 style=3D"display: inline-block; font-size: 12px; font-f=
amily: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: al=
l; white-space: normal; overflow-wrap: normal;">UDA partitions</xhtml:div>
> +            </xhtml:div>
> +          </xhtml:div>
> +        </foreignObject>
> +        <text
> +           x=3D"395"
> +           y=3D"94"
> +           fill=3D"rgb(0, 0, 0)"
> +           font-family=3D"Helvetica"
> +           font-size=3D"12px"
> +           text-anchor=3D"middle"
> +           id=3D"text126">UDA partit...</text>
> +      </switch>
> +    </g>
> +  </g>
> +  <switch
> +     id=3D"switch140">
> +    <g
> +       requiredFeatures=3D"http://www.w3.org/TR/SVG11/feature#Extensibil=
ity"
> +       id=3D"g134" />
> +    <a
> +       transform=3D"translate(0,-5)"
> +       xlink:href=3D"https://www.diagrams.net/doc/faq/svg-export-text-pr=
oblems"
> +       target=3D"_blank"
> +       id=3D"a138">
> +      <text
> +         text-anchor=3D"middle"
> +         font-size=3D"10px"
> +         x=3D"50%"
> +         y=3D"100%"
> +         id=3D"text136">Text is not SVG - cannot display</text>
> +    </a>
> +  </switch>
> +</svg>
> diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
> index 5f9bd4dfcbe9..ef31ccd12a42 100644
> --- a/doc/board/ti/k3.rst
> +++ b/doc/board/ti/k3.rst
> @@ -30,6 +30,7 @@ K3 Based SoCs
>  .. toctree::
>     :maxdepth: 1
>=20=20
> +   am62x_beagleplay
>     am62x_sk
>     ../toradex/verdin-am62
>     am64x_evm
> --=20
> 2.40.0
