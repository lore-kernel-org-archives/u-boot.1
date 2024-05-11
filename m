Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 702F9C04FFE
	for <u-boot@archiver.kernel.org>; Sat, 11 May 2024 05:39:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91BC688583;
	Sat, 11 May 2024 07:39:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ifDoD7ly";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 082F288585; Sat, 11 May 2024 07:39:06 +0200 (CEST)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com
 [IPv6:2607:f8b0:4864:20::92d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24D038857F
 for <u-boot@lists.denx.de>; Sat, 11 May 2024 07:39:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-7f3317ff3c2so879462241.0
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 22:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715405942; x=1716010742; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ms+voc7aX3wcpKa2+NkUplyqzDVIwHB/2ITJBvfnotA=;
 b=ifDoD7lyJSLJe4FLS4tp1EAhCnKLG8RIImMiQibkrElIwzQcbl8sS+FofVBAsx4ZXD
 TEnIDYK2yxW2YBNm0ed8BFWpqs5UXHilxwqqNtsC46wAe7BSZsTt66f25t6LQeSpJybY
 S6cBKc/+qKkGicPo1+qYZEx55PJvOswzER1vNIehYsFzWT3A3MYffBRCmhbegdAiwomj
 zBpzOrMgck/6+oFOGAxO/vWqh6QKoVwuKNxQAw9+i1pw1K81aBEpjT1xlrggDAPr/mFs
 sriEbs/3QkYi1KGzodnQfjcBOq9HbOb/Imc/AYlS28W4g0qKuJMF7ky0FBoMNWHRG7R7
 EUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715405942; x=1716010742;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ms+voc7aX3wcpKa2+NkUplyqzDVIwHB/2ITJBvfnotA=;
 b=ZWnXAd0OXauCwTvF6jjV44q95AwDQFqyqPA24cRmYRku7gblmB90bBRPi9VCvQSNMV
 7Rh+k21518vmRJAwRaO1MwUDO4zsVUv42+ART/wCqKXlkVH4fFgooxMIScx0NkibT4W3
 VlRpO6tzFcPb9EGvg6xjeJUKfYL3yZTPrdaSJS1vr05dLvcMAugl0biTY6iDPnpsLN5L
 VkfUHFfvqNeKhFO2fXF0sUn8Bton19DNCI2yT9GIw+0RqsXQDxWomUWjVd9llB7fJt5D
 6P2ug3rVL7zS8qawqLXUSUER5PDKUIykiZ95AY9iErBj8khn+AUne6G5dF6B1X6Cdqmi
 CD9g==
X-Gm-Message-State: AOJu0YwAipZg92JYv6trDN9Ny9Cgo8IV7ed0KtOWDPR25sbJBCFiTPyT
 IWXejJ4gt8BK2dN+YWybkY1r9fTrryNm8sQRH2WEiRMozhTKCD6rPOmq9JMdnn8JKnUHQndLGgX
 NO9CvzB55Z0uYCJQsotPvnM76iEuok0V1w3c=
X-Google-Smtp-Source: AGHT+IFONDjL9zuNHDJ201DjX8k3rqnX3K44k9V5FlriYF8q66lTRr+oM8bVnXRzhXTOOTVlJl7sbs9ZlmyBlvOA6BY=
X-Received: by 2002:a05:6102:54a7:b0:47f:2f18:43ce with SMTP id
 ada2fe7eead31-48077eaef26mr5197306137.30.1715405941919; Fri, 10 May 2024
 22:39:01 -0700 (PDT)
MIME-Version: 1.0
References: <4yWrCvGQf7QHU6yyu78zoEYdB14BqDmLpfJrIcPDierL5oQKWT_IWgQPC8k6KbKEuW738-F2xl5D2KFDT8XfOnm7WLt7nldN5_cO5AJ3PL0=@protonmail.com>
In-Reply-To: <4yWrCvGQf7QHU6yyu78zoEYdB14BqDmLpfJrIcPDierL5oQKWT_IWgQPC8k6KbKEuW738-F2xl5D2KFDT8XfOnm7WLt7nldN5_cO5AJ3PL0=@protonmail.com>
From: E Shattow <lucent@gmail.com>
Date: Fri, 10 May 2024 22:38:50 -0700
Message-ID: <CANV2PTMBTqZjkxEYV6GZnck63bDtDLoZoTrz=4Xc-N1hCNF-QQ@mail.gmail.com>
Subject: Re: [PATCH 2/2 v2] board: starfive: support Pine64 Star64 board
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

On Wed, May 8, 2024 at 10:15=E2=80=AFPM H Bell <dmoo_dv@protonmail.com> wro=
te:
>
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
> ---
>  doc/board/starfive/index.rst         |   1 +
>  doc/board/starfive/pine64_star64.rst | 109 +++++++++++++++++++++++++++
>  2 files changed, 110 insertions(+)
>  create mode 100644 doc/board/starfive/pine64_star64.rst
>
> diff --git a/doc/board/starfive/index.rst b/doc/board/starfive/index.rst
> index 2762bf74c1..f05f8a0765 100644
> --- a/doc/board/starfive/index.rst
> +++ b/doc/board/starfive/index.rst
> @@ -7,4 +7,5 @@ StarFive
>     :maxdepth: 1
>
>     milk-v_mars.rst
> +   pine64_star64
>     visionfive2

Ack. FYI series 406254 "board: starfive: add Milk-V Mars CM support"
corrects the milk-v_mars.rst listing in index.rst

> diff --git a/doc/board/starfive/pine64_star64.rst b/doc/board/starfive/pi=
ne64_star64.rst
> new file mode 100644
> index 0000000000..047f109028
> --- /dev/null
> +++ b/doc/board/starfive/pine64_star64.rst
> @@ -0,0 +1,109 @@
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
> +       make PLATFORM=3Dgeneric FW_TEXT_START=3D0x40000000 FW_OPTIONS=3D0
> +

Delete FW_OPTIONS. Keep FW_TEXT_START for compatibility.

FW_OPTIONS=3D0 is no-op and FW_TEXT_START is deprecated as of OpenSBI
commit d4d2582e (assume ~6mo release schedule 1.5 could be expected 6-7wks)=
.

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
> +
> +or the configuration variable CONFIG_DEFAULT_FDT_FILE can be used to set=
 to
> +provide a default value.
> +
> +Boot source selection
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +The board provides the DIP switches MSEL[1:0] to select the boot device =
out of
> +SPI flash, eMMC, SD-card, UART. To select booting from SD-card set the D=
IP
> +switches MSEL[1:0] to 10.
> +

Seems unclear to me looking at a picture of the board and reading this
description.

From the Pine64 Wiki page about Star64:
""
Booting from uSD: Component S1804 is adjacent to the 40pin GPIO Bus;
ignore the printed text on S1804 that says "ON" or "ONKE". Do pay
attention to the '1' and '2' printed on S1804. Also pay attention to
the 'L' and 'H' text on the board next to S1804. The 'L' stand for '0'
and the 'H' stands for '1'. You will need to flip switch '1' (GPIO_1)
on S1804 to the 'L' position and switch '2' (GPIO_0) on S1804 to the
'H' position. S1804 maps to the table next to S1804 that has text [
[GPIO_1 | GPIO_0], [0|0] Flash, [0|1] SD, [1|0] EMMC, [1|1] UART ];
""

So the table silkscreen on the board is correct, and in the table 0=3DL 1=
=3DH ?

Also the JH7110 TRM from StarFive officially cautions that booting
from SD is not reliable.

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
> --
> 2.44.0

Would like to see something more Star64-specific since all of the
above is explained in the visionfive2 board docs already. How is the
Star64 different from VisionFive2?

What does the silkscreen say about network port labels? Which node in
'net list' corresponds to each labelled network port?

Can eMMC socket and SD Card be used at the same time? In what order
are they enumerated (SD Card is 0? or 1?)

Does USB work from U-Boot? Mention that unlike visionfive2 there is no
VL805 USB controller.

Are network ports reliable, if no then which port is more reliable at
this time or are both equal?

Early Star64 units shipped with uninitialized EEPROM contents and
these boards will not apply the fdt fixes correctly.  How to fix this
from U-Boot? i.e.

mac initialize  # Use defaults for VisionFive2
mac vendor "PINE64"
mac product_id "STAR64V1-2310-D008E000-01234567"  # 8GB Model, replace
01234567 with random number
mac product_id "STAR64V1-2310-D004E000-01234567   # 4GB Model, replace
01234567 with random number
mac pcb_revision c1  # Star64 V1.1
mac bom_revision "A"
mac mac0_address "6c:cf:39:aa:bb:cc"  # replace aa bb cc with random hex di=
gits
mac mac1_address "6c:cf:39:aa:bb:cc"  # replace aa bb cc with random hex di=
gits
mac write_eeprom

Is EEPROM Write Protect enable high (prevent write) normally?

How to visually identify the board revisions? Are there differences
that affect boot operation?

Do we know what board revisions correspond to with EEPROM data content
or is this not trustworthy?

For someone reading the documentation and not familiar with the board
it will be worth mentioning there is a physical PCIe slot.

-E
