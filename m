Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E23E9C48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 13:56:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3790E87FB2;
	Tue, 20 Feb 2024 14:56:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xmwoiqX8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93F5187FB4; Tue, 20 Feb 2024 14:56:09 +0100 (CET)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com
 [IPv6:2607:f8b0:4864:20::92d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDD1587FA7
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 14:55:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-7d5c25267deso2647071241.3
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 05:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708437351; x=1709042151; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jxvE32FRHraBRIXD+jP1CVrpco7/CRZr6YKYKE8vOVQ=;
 b=xmwoiqX8b4l5oqZyX66NqTVHumW531TQYUqhL9KVwwIoroC2NW18BmLvJCg6PCrfaI
 6LY/iAdc/nl3NAmZq9H0nz5VyJEmiDuQzj/m9AJeo76hmPhFzLYNLFh2Rfp6zo5HsWXI
 oyBB7KT6JEdi1/vrx7vpm/W56Kz68uP7GRvBMe7VNtzfj85Fdw+2JlWnJV4UtkRrNsov
 kxuJUmQIp4DbclGlmSfEjpognQQ4oikh1I4SoXn2OyNmECjrv2JjIjO+rrcQXoLFtD4y
 S1ZAotD09iS5U/LZNTKyxtk5gzhX4XY7QUlAVHVj4T+IzBtBdTH/9OHWGSfXLSBUF3uj
 X/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708437351; x=1709042151;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jxvE32FRHraBRIXD+jP1CVrpco7/CRZr6YKYKE8vOVQ=;
 b=PUG4ornEIhFF7mxVitONPkG+SShu2TynDg4xLNmbYg5305yUBPsiOq4Hwx3pOBLCQu
 HGIn0LH9nqMt8NMO3OUmhcEPZ/uL8SKCpqueK7l2sxhTNPe//nC4gwYKeA0TYZm+QZ2R
 7Ve+I3gI17MJpn4ygTC0bQr5SI5RzXnFMku4Ynv7K8erij7FW8JWO4c5NQqpHBdc3sfQ
 q8ZJ+Jngk8v3F1kOn6U0tBfZd+vVVnDNsLnYhjQAOE6quZ1KsDm7YLguN+PvAl5DV8SV
 LdCzw58rulgsYP5ypjizZJ/HgBz7rR+ad5Fyc6qrnh9OIR6f/iEbRaWTlWqyFk6B4Q7k
 dRfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrDYCJ4M7y/0V1z76dGp0BJVnwNwUET/AQnVK8urmd3F2ZIKi8ba4EZfX7D9ckXTgLQoPnGDpUDhPnrr64Pphj/IUBFQ==
X-Gm-Message-State: AOJu0YzWtt72aOk9T5tccw+3jrAZuPdKuqGRaGsFOPW4+4IMM87z7JnZ
 +lMLzyDBVzHbCeGZ+HHg0LICjhpiNE6gttiQZEeX8ZGU4sDpUINZKTK6Xr9pgLjtC4rxAyYoeU2
 020tH09JdpautoHG1Y9Od42e5ZQeTGA7i+q6RlA==
X-Google-Smtp-Source: AGHT+IEZi4SDToNinoTU56MAZAvByxlqzexw9cD1oWFfS5AtLnmFTGmLfBNqQvhPvj2gHCAvFE2+j/IHtSuiLDyISx0=
X-Received: by 2002:a67:f60f:0:b0:46d:30b0:af9f with SMTP id
 k15-20020a67f60f000000b0046d30b0af9fmr12752155vso.9.1708437349848; Tue, 20
 Feb 2024 05:55:49 -0800 (PST)
MIME-Version: 1.0
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
 <20240215-b4-qcom-common-target-v4-25-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-25-ed06355c634a@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 20 Feb 2024 19:25:39 +0530
Message-ID: <CAFA6WYMUaL97tVwvxy0=QgTC+5+OTA-c+f7rMS65+TFk0FtDDQ@mail.gmail.com>
Subject: Re: [PATCH v4 25/39] doc: board/qualcomm: document generic targets
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 16 Feb 2024 at 02:22, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Replace the board specific docs with a generic board.rst file which
> documents the build/boot process for the sdm845 and qcs404 boards now
> that the only differences are the DTB in use.
>
> At the same time, create a debugging page to document some useful
> snippets and tips for working with Qualcomm platforms.
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  doc/board/qualcomm/board.rst     | 125 +++++++++++++++++++++++++++++
>  doc/board/qualcomm/debugging.rst |  61 ++++++++++++++
>  doc/board/qualcomm/index.rst     |   4 +-
>  doc/board/qualcomm/qcs404.rst    |  79 ------------------
>  doc/board/qualcomm/sdm845.rst    | 167 ---------------------------------------
>  5 files changed, 188 insertions(+), 248 deletions(-)
>

Apart from minor nits below, feel free to add:

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/doc/board/qualcomm/board.rst b/doc/board/qualcomm/board.rst
> new file mode 100644
> index 000000000000..4d793209f9e3
> --- /dev/null
> +++ b/doc/board/qualcomm/board.rst
> @@ -0,0 +1,125 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +.. sectionauthor:: Dzmitry Sankouski <dsankouski@gmail.com>
> +
> +Qualcomm generic boards
> +=======================
> +
> +About this
> +----------
> +This document describes how to build and run U-Boot for Qualcomm generic
> +boards. Right now the generic target supports the Snapdragon 845 SoC, however
> +it's expected to support more SoCs going forward.
> +
> +SDM845 - high-end qualcomm chip, introduced in late 2017.
> +Mostly used in flagship phones and tablets of 2018.
> +
> +The current boot flow support loading u-boot as an Android boot image via

s/support/supports/

> +Qualcomm's UEFI-based ABL (Android) Bootloader. The DTB used by U-Boot will
> +be appended to the U-Boot image the same way as when booting Linux. U-Boot
> +will then retrieve the DTB during init. This way the memory layout and KASLR
> +offset will be populated by ABL.
> +
> +Installation
> +------------
> +Build
> +^^^^^
> +
> +       $ ./tools/buildman/buildman -o .output qcom
> +
> +This will build ``.output/u-boot-nodtb.bin`` using the ``qcom_defconfig``.
> +
> +Generate FIT image (optional)
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +See doc/uImage.FIT for more details
> +
> +Pack android boot image
> +^^^^^^^^^^^^^^^^^^^^^^^
> +We'll assemble android boot image with ``u-boot-nodtb.bin`` instead of linux kernel,
> +and FIT image instead of ``initramfs``. Android bootloader expect gzipped kernel

s/expect/expects/

> +with appended dtb, so let's mimic linux to satisfy stock bootloader.
> +
> +Boards
> +------
> +
> +starqlte
> +^^^^^^^^
> +
> +The starqltechn is a production board for Samsung S9 (SM-G9600) phone,
> +based on the Qualcomm SDM845 SoC.
> +
> +This device is supported by the common qcom_defconfig.
> +
> +The DTB is called "sdm845-samsung-starqltechn.dtb"
> +
> +More information can be found on the `Samsung S9 page`_.
> +
> +dragonboard845c
> +^^^^^^^^^^^^^^^
> +
> +The dragonboard845c is a Qualcomm Robotics RB3 Development Platform, based on
> +the Qualcomm SDM845 SoC.
> +
> +This device is supported by the common qcom_defconfig
> +
> +The DTB is called "sdm845-db845c.dtb"
> +
> +More information can be found on the `DragonBoard 845c page`_.
> +
> +qcs404-evb
> +^^^^^^^^^^
> +
> +The QCS404 EvB is a Qualcomm Development Platform, based on the Qualcomm QCS404 SoC.
> +
> +This device is supported by the common qcom_defconfig
> +
> +The DTB is called "qcs404-evb-4000.dtb"
> +
> +Building steps
> +--------------
> +
> +Steps:
> +
> +- Build u-boot
> +
> +As above::
> +
> +       ./tools/buildman/buildman -o .output qcom
> +
> +Or for db410c (and other boards not supported by the generic target)::
> +
> +       make CROSS_COMPILE=aarch64-linux-gnu- O=.output dragonboard410c_defconfig
> +       make O=.output -j$(nproc)
> +
> +- gzip u-boot::
> +
> +       gzip u-boot-nodtb.bin
> +
> +- Append dtb to gzipped u-boot::
> +
> +       cat u-boot-nodtb.bin.gz arch/arm/dts/your-board.dtb > u-boot-nodtb.bin.gz-dtb
> +
> +- If you chose to build a FIT image, A ``qcom.its`` file can be found in ``board/qualcomm/generic/``

s/chose/choose/


> +  directory. It expects a folder as ``qcom_imgs/`` in the main directory containing pre-built kernel,
> +  dts and ramdisk images. See ``qcom.its`` for full path to images::
> +
> +       mkimage -f qcom.its qcom.itb
> +
> +- Now we've got everything to build android boot image::
> +
> +       mkbootimg --kernel u-boot-nodtb.bin.gz-dtb --ramdisk db845c.itb \
> +       --output boot.img --pagesize 4096 --base 0x80000000
> +
> +Or with no FIT image::
> +
> +       mkbootimg --kernel u-boot-nodtb.bin.gz-dtb \
> +       --output boot.img --pagesize 4096 --base 0x80000000
> +
> +- Flash boot.img using fastboot and erase dtbo to avoid conflicts with our DTB:
> +
> +  .. code-block:: bash
> +
> +       fastboot flash boot boot.img
> +       fastboot erase dtbo
> +
> +.. _Samsung S9 page: https://en.wikipedia.org/wiki/Samsung_Galaxy_S9
> +.. _DragonBoard 845c page: https://www.96boards.org/product/rb3-platform/
> diff --git a/doc/board/qualcomm/debugging.rst b/doc/board/qualcomm/debugging.rst
> new file mode 100644
> index 000000000000..1c35d1909d12
> --- /dev/null
> +++ b/doc/board/qualcomm/debugging.rst
> @@ -0,0 +1,61 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +.. sectionauthor:: Caleb Connolly <caleb.connolly@linaro.org>
> +
> +Qualcomm debugging
> +==================
> +
> +About this
> +----------
> +
> +This page describes how to enable early UART and other debugging techniques
> +for Qualcomm boards.
> +
> +Enable debug UART
> +-----------------
> +
> +Newer boards (SDM845 and newer, those with GENI SE UART)
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Open ``configs/qcom_defconfig`` and add the following snippet to the bottom:
> +
> +       CONFIG_BAUDRATE=115200
> +
> +       # Uncomment to enable UART pre-relocation
> +       CONFIG_DEBUG_UART=y
> +       CONFIG_DEBUG_UART_ANNOUNCE=y
> +       # This is the address of the debug-uart peripheral
> +       # The value here is for SDM845, other platforms will vary
> +       CONFIG_DEBUG_UART_BASE=0xa84000
> +       # Boards older than ~2018 pre-date the GENI driver and unfortunately
> +       # aren't supported here
> +       CONFIG_DEBUG_UART_MSM_GENI=y
> +       # For sdm845 this is the UART clock rate
> +       CONFIG_DEBUG_UART_CLOCK=7372800
> +       # Most newer boards have an oversampling value of 16 instead
> +       # of 32, they need the clock rate to be doubled
> +       #CONFIG_DEBUG_UART_CLOCK=14745600
> +
> +Then build as normal (don't forget to ``make qcom_defconfig``` again).
> +
> +Older boards (db410c and db820c)
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Open ``configs/dragonboard<BOARD>_defconfig``
> +

In case you don't plan to enable debug UART when U-Boot is the first
stage bootloader then it should atleast be documented here that only
chainloaded configuration supports it.

-Sumit

> +       CONFIG_BAUDRATE=115200
> +       CONFIG_DEBUG_UART=y
> +       CONFIG_DEBUG_UART_ANNOUNCE=y
> +       # db410c - 0x78b0000
> +       # db820c - 0x75b0000
> +       CONFIG_DEBUG_UART_BASE=0x75b0000
> +       CONFIG_DEBUG_UART_MSM=y
> +       CONFIG_DEBUG_UART_CLOCK=7372800
> +       #CONFIG_DEBUG_UART_SKIP_INIT=y
> +
> +       CONFIG_LOG=y
> +       CONFIG_HEXDUMP=y
> +       CONFIG_CMD_LOG=y
> +       CONFIG_LOG_MAX_LEVEL=9
> +       CONFIG_LOG_DEFAULT_LEVEL=9
> +       CONFIG_LOGLEVEL=9
> +
> diff --git a/doc/board/qualcomm/index.rst b/doc/board/qualcomm/index.rst
> index 0f9c4299569a..4955274a39bc 100644
> --- a/doc/board/qualcomm/index.rst
> +++ b/doc/board/qualcomm/index.rst
> @@ -7,5 +7,5 @@ Qualcomm
>     :maxdepth: 2
>
>     dragonboard410c
> -   sdm845
> -   qcs404
> +   board
> +   debugging
> diff --git a/doc/board/qualcomm/qcs404.rst b/doc/board/qualcomm/qcs404.rst
> deleted file mode 100644
> index 0cb71d97c987..000000000000
> --- a/doc/board/qualcomm/qcs404.rst
> +++ /dev/null
> @@ -1,79 +0,0 @@
> -.. SPDX-License-Identifier: GPL-2.0+
> -.. sectionauthor:: Sumit Garg <sumit.garg@linaro.org>
> -
> -QCS404 EVB
> -==========
> -
> -About this
> -----------
> -This document describes the information about Qualcomm QCS404 evaluation board
> -and it's usage steps.
> -
> -The current boot flow support loading u-boot as an Android boot image via
> -Qualcomm's UEFI-based ABL (Android) Bootloader.
> -
> -Installation
> -------------
> -Build
> -^^^^^
> -Setup ``CROSS_COMPILE`` for aarch64 and build U-Boot for your board::
> -
> -       $ export CROSS_COMPILE=<aarch64 toolchain prefix>
> -       $ make qcs404evb_defconfig
> -       $ make
> -
> -This will build ``u-boot.bin`` in the configured output directory.
> -
> -Generate FIT image
> -^^^^^^^^^^^^^^^^^^
> -A ``qcs404.its`` file can be found in ``board/qualcomm/qcs404-evb/`` directory.
> -It expects a folder as ``qcs404_imgs/`` in the main directory containing
> -pre-built kernel, dts and ramdisk images. See ``qcs404.its`` for full path to
> -images.
> -
> -- Build FIT image::
> -
> -       mkimage -f qcs404-evb.its qcs404-evb.itb
> -
> -Pack android boot image
> -^^^^^^^^^^^^^^^^^^^^^^^
> -We'll assemble android boot image with ``u-boot.bin`` instead of linux kernel,
> -and FIT image instead of ``initramfs``. Android bootloader expect gzipped kernel
> -with appended dtb, so let's mimic linux to satisfy stock bootloader:
> -
> -- create dump dtb::
> -
> -       workdir=/tmp/prepare_payload
> -       mkdir -p "$workdir"
> -       cd "$workdir"
> -       mock_dtb="$workdir"/payload_mock.dtb
> -
> -       dtc -I dts -O dtb -o "$mock_dtb" << EOF
> -       /dts-v1/;
> -       / {
> -               model = "Qualcomm Technologies, Inc. QCS404 EVB 4000";
> -               compatible = "qcom,qcs404-evb-4000", "qcom,qcs404-evb", "qcom,qcs404";
> -
> -               #address-cells = <2>;
> -               #size-cells = <2>;
> -
> -               memory@80000000 {
> -                       device_type = "memory";
> -                       /* We expect the bootloader to fill in the size */
> -                       reg = <0 0x80000000 0 0>;
> -               };
> -
> -               chosen { };
> -       };
> -       EOF
> -
> -- gzip u-boot ``gzip u-boot.bin``
> -- append dtb to gzipped u-boot: ``cat u-boot.bin.gz "$mock_dtb" > u-boot.bin.gz-dtb``
> -
> -Now we've got everything to build android boot image:::
> -
> -       mkbootimg --kernel u-boot.bin.gz-dtb \
> -       --ramdisk qcs404-evb.itb --pagesize 4096 \
> -       --base 0x80000000 --output boot.img
> -
> -Flash image on qcs404-evb using fastboot method.
> diff --git a/doc/board/qualcomm/sdm845.rst b/doc/board/qualcomm/sdm845.rst
> deleted file mode 100644
> index a65f00df39f5..000000000000
> --- a/doc/board/qualcomm/sdm845.rst
> +++ /dev/null
> @@ -1,167 +0,0 @@
> -.. SPDX-License-Identifier: GPL-2.0+
> -.. sectionauthor:: Dzmitry Sankouski <dsankouski@gmail.com>
> -
> -Snapdragon 845
> -==============
> -
> -About this
> -----------
> -
> -This document describes the information about Qualcomm Snapdragon 845
> -supported boards and it's usage steps.
> -
> -SDM845 - hi-end qualcomm chip, introduced in late 2017.
> -Mostly used in flagship phones and tablets of 2018.
> -
> -The current boot flow support loading u-boot as an Android boot image via
> -Qualcomm's UEFI-based ABL (Android) Bootloader.
> -
> -Installation
> -------------
> -
> -Build
> -^^^^^
> -
> -Setup ``CROSS_COMPILE`` for aarch64 and build U-Boot for your board::
> -
> -       $ export CROSS_COMPILE=<aarch64 toolchain prefix>
> -       $ make <your board name here, see Boards section>_defconfig
> -       $ make
> -
> -This will build ``u-boot.bin`` in the configured output directory.
> -
> -Generate FIT image
> -^^^^^^^^^^^^^^^^^^
> -
> -See doc/uImage.FIT for more details
> -
> -Pack android boot image
> -^^^^^^^^^^^^^^^^^^^^^^^
> -
> -We'll assemble android boot image with ``u-boot.bin`` instead of linux kernel,
> -and FIT image instead of ``initramfs``. Android bootloader expect gzipped kernel
> -with appended dtb, so let's mimic linux to satisfy stock bootloader.
> -
> -Boards
> -------
> -
> -starqlte
> -^^^^^^^^
> -
> -The starqltechn is a production board for Samsung S9 (SM-G9600) phone,
> -based on the Qualcomm SDM845 SoC.
> -
> -Steps:
> -
> -- Build u-boot::
> -
> -       $ export CROSS_COMPILE=<aarch64 toolchain prefix>
> -       $ make starqltechn_defconfig
> -       $ make
> -
> -- Create dump dtb::
> -
> -       workdir=/tmp/prepare_payload
> -       mkdir -p "$workdir"
> -       cd "$workdir"
> -       mock_dtb="$workdir"/payload_mock.dtb
> -
> -       dtc -I dts -O dtb -o "$mock_dtb" << EOF
> -       /dts-v1/;
> -       / {
> -               memory {
> -                       /* We expect the bootloader to fill in the size */
> -                       reg = <0 0 0 0>;
> -               };
> -
> -               chosen { };
> -       };
> -       EOF
> -
> -- gzip u-boot::
> -
> -       gzip u-boot.bin
> -
> -- Append dtb to gzipped u-boot::
> -
> -       cat u-boot.bin.gz "$mock_dtb" > u-boot.bin.gz-dtb
> -
> -- Now we've got everything to build android boot image::
> -
> -       mkbootimg --base 0x0 --kernel_offset 0x00008000 \
> -       --ramdisk_offset 0x02000000 --tags_offset 0x01e00000 \
> -       --pagesize 4096 --second_offset 0x00f00000 \
> -       --ramdisk "$fit_image" \
> -       --kernel u-boot.bin.gz-dtb \
> -       -o boot.img
> -
> -- Flash image with your phone's flashing method.
> -
> -More information can be found on the `Samsung S9 page`_.
> -
> -dragonboard845c
> -^^^^^^^^^^^^^^^
> -
> -The dragonboard845c is a Qualcomm Robotics RB3 Development Platform, based on
> -the Qualcomm SDM845 SoC.
> -
> -Steps:
> -
> -- Build u-boot::
> -
> -       $ export CROSS_COMPILE=<aarch64 toolchain prefix>
> -       $ make dragonboard845c_defconfig
> -       $ make
> -
> -- Create dummy dtb::
> -
> -       workdir=/tmp/prepare_payload
> -       mkdir -p "$workdir"
> -       mock_dtb="$workdir"/payload_mock.dtb
> -
> -       dtc -I dts -O dtb -o "$mock_dtb" << EOF
> -       /dts-v1/;
> -       / {
> -               #address-cells = <2>;
> -               #size-cells = <2>;
> -
> -               memory@80000000 {
> -                       device_type = "memory";
> -                       /* We expect the bootloader to fill in the size */
> -                       reg = <0 0x80000000 0 0>;
> -               };
> -
> -               chosen { };
> -       };
> -       EOF
> -
> -- gzip u-boot::
> -
> -       gzip u-boot.bin
> -
> -- Append dtb to gzipped u-boot::
> -
> -        cat u-boot.bin.gz "$mock_dtb" > u-boot.bin.gz-dtb
> -
> -- A ``db845c.its`` file can be found in ``board/qualcomm/dragonboard845c/``
> -  directory. It expects a folder as ``db845c_imgs/`` in the main directory
> -  containing pre-built kernel, dts and ramdisk images. See ``db845c.its``
> -  for full path to images::
> -
> -       mkimage -f db845c.its db845c.itb
> -
> -- Now we've got everything to build android boot image::
> -
> -       mkbootimg --kernel u-boot.bin.gz-dtb --ramdisk db845c.itb \
> -       --output boot.img --pagesize 4096 --base 0x80000000
> -
> -- Flash boot.img using db845c fastboot method:
> -
> -  .. code-block:: bash
> -
> -      sudo fastboot flash boot boot.img
> -
> -More information can be found on the `DragonBoard 845c page`_.
> -
> -.. _Samsung S9 page: https://en.wikipedia.org/wiki/Samsung_Galaxy_S9
> -.. _DragonBoard 845c page: https://www.96boards.org/product/rb3-platform/
>
> --
> 2.43.1
>
