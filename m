Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95EA9C25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 21:42:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23C9B884A9;
	Wed, 22 May 2024 23:42:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lXIGLZnu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98037884B3; Wed, 22 May 2024 23:42:30 +0200 (CEST)
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com
 [IPv6:2607:f8b0:4864:20::a2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09B5688464
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 23:42:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-4df6e7414fdso477906e0c.0
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 14:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716414147; x=1717018947; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2mhUfUsue4Iis2qOA1TyH7U1SRR0VtKVtwCt2uOsgxw=;
 b=lXIGLZnuNxxSlMqmRvRSkJGPppXkQBERlVELEk7Ztim8feFxIDqAIENuKE0bMTWTmO
 VK7qpp2JYIj4R0mVdC0JMtdKCVBFNW0qZnf+p0se6qk+OxBbUKCxz7/EDHDVHltBgjoi
 NedJAmr6UJdrx7QaGKWpYI3OMBqnIdD1S0rI7euxsZ3YGZO0P6ZCOTWoXPiOZ8NVOava
 y1ZaFH9WmwzfAhIeLlcR/N1r3KjngndQWC+O+pdW2//QYcm6vb2dWI306+4FMbO3zRrI
 lrDicsnspWHdLozD/GrCy6eYViW4C1GxU8qilEI74O5IDBG43LHhjOdVfY7fy2134O2K
 EIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716414147; x=1717018947;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2mhUfUsue4Iis2qOA1TyH7U1SRR0VtKVtwCt2uOsgxw=;
 b=JX/KG+yt1JWp1vDfWf5zIEzAn6K2wgWLOGWtvTockQoOEPt35nHjypAj4+RsX96/2L
 3I2yw/3Za8WQUaYoeFrg+3vg45eNoXm/ufRInNT/gWYiZj8nzeBvLQZHXFViSpU51AKT
 HLMBe1iLpQbdsgxmVx5uM+vnOiiHB/uyoXBEKHBIhZwM6YMpiWnLl7IL+jLu6FStYmA2
 7j0QmEDTyux0N+zf9GtXaEOnWSt30IXeOZTaAIchgo7X4os9nwqWMMwXSbOqWHH28bJA
 vRcgIq7732qWcjiYLZEFKJpc4TISWqsT9OvM1gdwbYWz6oG59lYjDG6fTPK5Sv4+r6+d
 lkew==
X-Gm-Message-State: AOJu0YysOor50xY/AsXT1diTefT1oodOzGM3f1lyxsZjbjEbLcNKus1t
 9kSsc6rnyRawOR+Ux/k5lp18mAl0YnYO3ITHUn0LHtBfG6VWQhZDTHH/OfeLQxdwi6OShAsW97X
 5MpQn6Ng00KFtPpKWahfKvforZ3/nwg==
X-Google-Smtp-Source: AGHT+IEqnztM6kxv9f5pBOvfcBmvt1QjInZFJJqpDzbtQXeEY+PU0z2hXLzKJA+IgsIo0+HMyJC0s+CMqEDE+7VSen4=
X-Received: by 2002:a05:6122:1d92:b0:4d3:4ac2:29f4 with SMTP id
 71dfb90a1353d-4e2130d305fmr3282293e0c.2.1716414146704; Wed, 22 May 2024
 14:42:26 -0700 (PDT)
MIME-Version: 1.0
References: <6Yk7L2-xTxcUnQdR0tk_SVFsR-REvvBdSSzDPivTKNeM_3-wlFKeIQtDp1cJTjjOoO9P54bPe_q51mO1PvGF7e6Q-Tqo0k-F2QoLP6Tn8ss=@protonmail.com>
In-Reply-To: <6Yk7L2-xTxcUnQdR0tk_SVFsR-REvvBdSSzDPivTKNeM_3-wlFKeIQtDp1cJTjjOoO9P54bPe_q51mO1PvGF7e6Q-Tqo0k-F2QoLP6Tn8ss=@protonmail.com>
From: E Shattow <lucent@gmail.com>
Date: Wed, 22 May 2024 14:42:15 -0700
Message-ID: <CANV2PTMsbNkPXmUNCbytxfQP8u9qr7=NdYMbfrO3V-_cj6vRFg@mail.gmail.com>
Subject: Re: [PATCH 2/2 v5] board: starfive: support Pine64 Star64 board
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

On Wed, May 22, 2024 at 12:13=E2=80=AFPM H Bell <dmoo_dv@protonmail.com> wr=
ote:
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
>
> Changes since v4
>
> - Rework and expand docs on boot selection switches and overriding
>   MAC addresses
> - Fix warnings and underline width
> ---
>  doc/board/starfive/index.rst         |   1 +
>  doc/board/starfive/pine64_star64.rst | 201 +++++++++++++++++++++++++++
>  2 files changed, 202 insertions(+)
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
> index 0000000000..52e9a90791
> --- /dev/null
> +++ b/doc/board/starfive/pine64_star64.rst
> @@ -0,0 +1,201 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +Pine64 Star64
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
> +    env set fdtfile my_device-tree.dtb
> +    env save
> +
> +or the configuration variable CONFIG_DEFAULT_FDT_FILE can be used to set=
 to
> +provide a default value.
> +
> +Boot source selection
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +Boot mode is selected by an MSEL-DIP marked S1804 and GPIO_0 position ad=
jacent
> +to the 40pin GPIO header. ON/ONKE and number markings of the MSEL-DIP ar=
e
> +misleading; Instead refer to the ``L`` (0) and ``H`` (1) silkscreen for
> +accurate selection.
> +
> ++ (QSPI) Flash: 00
> ++ SD: 01
> ++ EMMC: 10
> ++ UART: 11
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
> +Serial Number and MAC address issues
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +U-Boot requires valid EEPROM data to determine which board-specific fix-=
up to
> +apply at runtime. This affects the size of memory initialized, network m=
ac
> +address numbering, and tuning of the network PHYs.
> +
> +The Star64 does not currently ship with unique serial numbers per-device=
.
> +Devices follow a pattern where the last mac address bytes are a sum of 0=
x7558
> +and the serial number (lower port mac0), or a sum of 0x7559 and the seri=
al
> +number (upper port mac1).
> +
> +As tested there are several 4gb model units where the serial number and =
network
> +mac addresses collide with other devices (serial
> +``STAR64V1-2310-D004E000-00000005``, MACs ``6c:cf:39:00:75:61``,
> +``6c:cf:39:00:75:62``)
> +
> +Some early Star64 boards shipped with an uninitialized EEPROM and no wri=
te
> +protect pull-up resistor in place. Later units of all 4gb and 8gb models
> +sharing the same serial number in EEPROM data will have this problem tha=
t the
> +network mac addresses are alike between different models and this may be
> +corrected by defeating the write protect resistor to write new values. A=
s an
> +alternative to this, it may be worked around by overriding the mac addre=
sses
> +via U-Boot environment variables.
> +
> +It is required for any unit having uninitialized EEPROM and recommended =
for
> +all later Star64 4gb model units (not properly serialized) to have decid=
ed on a
> +new 6-byte serial number. This serial number should be high enough to
> +avoid collision with other JH7110 boards and low enough not to overflow =
i.e.
> +between ``cafe00`` and ``f00d00``.
> +
> +Update EEPROM values
> +^^^^^^^^^^^^^^^^^^^^
> +
> +1. Prepare EEPROM data in memory
> +
> +::
> +
> +       ## When there is no error to load existing data:
> +       mac read_eeprom
> +
> +       ## When there is an error to load non-existing data:
> +       # "DRAM:  Not a StarFive EEPROM data format - magic error"
> +       mac initialize
> +
> +2. Set Star64 values
> +
> +::
> +
> +       ## Common values
> +       mac vendor PINE64
> +       mac pcb_revision c1
> +       mac bom_revision A
> +
> +       ## Device-specific values
> +       # Year 2023 week 10 production date, 8GB DRAM, optional eMMC, ser=
ial cdef01
> +       mac product_id STAR64V1-2310-D008E000-00cdef01
> +
> +       # Last three bytes mac0: 0x7558 + serial number 0xcdef01
> +       mac mac0_address 6c:cf:39:ce:64:59
> +
> +       # Last three bytes mac1: 0x7559 + serial number 0xcdef01
> +       mac mac1_address 6c:cf:39:ce:64:5a
> +
> +3. Defeat write-protect pull-up resistor (if installed) and write to EEP=
ROM
> +
> +::
> +
> +       mac write_eeprom
> +
> +Set Variables in U-Boot
> +^^^^^^^^^^^^^^^^^^^^^^^
> +
> +.. note:: Changing just the serial number will not alter your MAC addres=
s
> +
> +The MAC addresses may be "set" as follows by writing as a custom config =
to SPI
> +(Change the last 3 bytes of MAC addreses as appropriate):
> +
> +::
> +
> +       env set serial# STAR64V1-2310-D008E000-00cdef01
> +       env set ethaddr 6c:cf:39:ce:64:59
> +       env set eth1addr 6c:cf:39:ce:64:5a
> +       env save
> +       reset
> --
> 2.44.0
>
>

I understand setting $serial# environment variable to be more
illustrative than prescriptive. I think this should be a comment to
guide the setting of ethaddr and eth1addr but not itself be set by the
user. With that:

Reviewed-by: E Shattow <lucent@gmail.com>
