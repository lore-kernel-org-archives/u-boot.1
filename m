Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0920109E545
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 09:32:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32B8583DA7;
	Fri, 27 Mar 2026 10:32:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="p7EJ6NKl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A2AA83DBF; Fri, 27 Mar 2026 10:32:25 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70A6383C14
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 10:32:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 19B3B3F5D7
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 09:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1774603942;
 bh=uhiBS+6hxb9xSX4Y0vjfUD0kZRtRKx82X2k892u6yhU=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=p7EJ6NKl3iREm0XjaJ16IJ/FKdR0J0+eWlUkfdaagPBp6Rzvdm/fY29okHacp5z14
 b+dx0VFyyGkh8+AhLntjncrN3UYwrKPqIaKxgbR4bpYm0j7batUxygapXie0aFxLOG
 yRUbYJKsBk/SkzSM0G+JnuwbymOvDkZ9XroSEUYla1oT0q1KQMDXBpi3qtMci8RsGJ
 7sTF92WrSSDBX4WuGEH9TECKTjASMtRJnBuyWBpRE6MeNrgIgU5qbTwCNdNYHuXHWE
 R/2/o95jUGpquILmJNII7+LneREFf3hl9PJIIwSoc3M1efJEYnN9meKyzxK6DoUpqg
 1aRZJiTIFGr84GfphgngFCrcZezWtWpTyZFuRmjei9k2yVh/U4GcFMK80CYKrmF8nq
 av/+e/hpZzdxLUi9v2cj+TpzlHskMq5B3gYTJEzidEnZ0KqbB6boBF1qAvyKPsVu3Y
 cQuMfR3IMcg7nRJyjnuUzCGCbUw+En+Tte683rJhPLQhSK/S9Pl+ybT9xmz4GuyHCs
 V7QVhGFkxiV0nSvWaz0BKFOcAYqN8oEJ+WXWYo7yi+FlsgK9fnyEzOT7eZASjJJz60
 pZco3spLo3vk6LGyGL+tU3OumNe2OkmZhTrGcoN5iGpuazJv7300YW8tlnvUMeFekO
 ciBTKBJRrh8cngHngG4ulSug=
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-483786a09b1so24382125e9.3
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 02:32:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774603942; x=1775208742;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uhiBS+6hxb9xSX4Y0vjfUD0kZRtRKx82X2k892u6yhU=;
 b=T+Y3YPMDFphvCwh+gjH1TzTxHaGcmLxslmpKEH04Js0WZj4i9C+ePfBmgASLhn5YFH
 j1ZCfouIY2uzi/2S4OHm9sWeY4txTQF2DWbwXhHCSEuN9ySEY/a0bnNTmlF2jm6o85bc
 QqY7vjOP/GLAfvBT6QV8MjhaUK+QIAjrDV9/Zjpigke7aGFBZTJG1+rWR4IwTfkTlVoT
 dwNIVUUSYjtQDEKlJ5E7wDTUGCrs/L2yuGY+hxcLIDUVGe/PvPiPUduT0T4Fz+pomg3B
 hEsdHP7QK1vcr3bWa9JAtCG/tOj2ZvVHHz7Ud7FT84NNUJidvt7eZOA4Lv64FFMlstb0
 Zk1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVQZ0I3EeUsDfZl4UO4sVyKRy+wteNWtaBKVBgUU3ZXotK3G2a3yXFRieZty5bUVr/D3aVgrY=@lists.denx.de
X-Gm-Message-State: AOJu0YybiHXJFLRniTM9YufdjXHlWvYh0/gLuiMF6/FHgKqmXO/lK5zS
 K+oEH9EHiOyCkwvMFFIoI8V0tUlS+jr8M9/7DgGRdzf4lUanuBajXO0O0+NmpxEJY17VmHLJUKS
 DIXc/eclFJ/NIYytTprUH3VGRZrZ+umNwRrDEChFy+QvbtX8CzmJSzGquP0rBhQE6F8bjnZs=
X-Gm-Gg: ATEYQzyVw9sD3RLwKg68ysiImYv9qcI9D8tZpFuZYRYv/XO3SlxioReGcZ2biFmZqE4
 fL9QhE2lVsMZktu4Puo03OmZHCa2W36TS4YTUmL8yyJGiCqz7TBVt4Zvl/aZXejnzRSJfLsK63o
 jNIapgwJsAv/PwrHfLLBVKJ0g3CeVXBWouDQ3rp+wpYfOgm8MfJqQPJDf5A6QAyevlAv12+zykb
 gQ5jkU71oXuVF93uEpghNO99GBw7AM8mXfiaV1MbLT1jQvQKoH0GxXpKiVehfQ1tHVTIB9qq5cz
 C0GoD2cVMz7XxUb1L1yYslSXY/UQW/Kkfr2K/PnSH4QGl0iK10K+x8HcVyhR47Y/pryiIp57pfa
 /ao1DRbvwvkfKxcYqrMcZSaenXSPkqiDnnU5dRFx3f2nbDNvr8DW6bhU+GmQZEfX8YEgPULVV/k
 jk8YhRyqx1kn65FHJW78ChiIQT5dII/+VzQCLVDsQzdhOB8Ygip+c=
X-Received: by 2002:a05:600c:1d1c:b0:483:7903:c3b1 with SMTP id
 5b1f17b1804b1-48727efacb3mr26308825e9.20.1774603941394; 
 Fri, 27 Mar 2026 02:32:21 -0700 (PDT)
X-Received: by 2002:a05:600c:1d1c:b0:483:7903:c3b1 with SMTP id
 5b1f17b1804b1-48727efacb3mr26307635e9.20.1774603940443; 
 Fri, 27 Mar 2026 02:32:20 -0700 (PDT)
Received: from [192.168.123.154]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722be608bsm106062695e9.0.2026.03.27.02.32.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 02:32:19 -0700 (PDT)
Message-ID: <52281343-9c46-4050-845d-9963c10266f3@canonical.com>
Date: Fri, 27 Mar 2026 10:32:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] doc: spacemit: add K1 SPL build and test guide
To: Guodong Xu <guodong@riscstar.com>
Cc: trini@konsulko.com, rick@andestech.com, ycliang@andestech.com,
 raymond.mao@riscstar.com, u-boot-spacemit@groups.io,
 Vincent Legoll <legoll@online.fr>, u-boot@lists.denx.de
References: <20260325223232.1553212-1-raymondmaoca@gmail.com>
 <20260327081418.550546-1-guodong@riscstar.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20260327081418.550546-1-guodong@riscstar.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 3/27/26 09:14, Guodong Xu wrote:
> The K1 SPL patchset requires DDR firmware integration and FSBL signing
> steps that are not covered by existing documentation. Add a SoC-level
> guide so reviewers and developers can build and test on hardware.
> 
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> ---
> Changes in v2:
>    - Update vendor U-Boot repo from bianbu-linux to spacemit-buildroot,
>      and specify the k1-bl-v2.2.y branch
>    - Fix fsbl.json path to board/spacemit/k1-x/configs/
>    - Add mkdir -p for spl_bin directory in fsbl.sh
>    - Replace verbose DDR training log with concise SPL boot output
>    - Update expected output notes for SPI NOR availability
> 
>   doc/board/spacemit/index.rst  |   1 +
>   doc/board/spacemit/k1-spl.rst | 196 ++++++++++++++++++++++++++++++++++
>   2 files changed, 197 insertions(+)
>   create mode 100644 doc/board/spacemit/k1-spl.rst
> 
> diff --git a/doc/board/spacemit/index.rst b/doc/board/spacemit/index.rst
> index e7d3d94e459..a5e35ee12ab 100644
> --- a/doc/board/spacemit/index.rst
> +++ b/doc/board/spacemit/index.rst
> @@ -6,4 +6,5 @@ SpacemiT
>      :maxdepth: 1
>   
>      bananapi-f3
> +   k1-spl
>   
> diff --git a/doc/board/spacemit/k1-spl.rst b/doc/board/spacemit/k1-spl.rst
> new file mode 100644
> index 00000000000..6192cbe32b0
> --- /dev/null
> +++ b/doc/board/spacemit/k1-spl.rst
> @@ -0,0 +1,196 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +SpacemiT K1 SPL Build and Test Guide
> +=====================================
> +
> +This guide explains how to build and test U-Boot SPL on SpacemiT K1 based
> +boards. It covers building SPL with DDR initialization, generating the signed
> +FSBL image, and deploying via USB fastboot.

Thanks a lot for providing this documentation.

> +
> +Tested boards: Banana Pi BPI-F3, MusePi Pro.
> +
> +Prerequisites
> +~~~~~~~~~~~~~
> +
> +- A SpacemiT K1 board with USB Type-C and UART access
> +- USB-to-UART adapter (3.3V TTL)
> +- ``minicom`` or equivalent serial terminal, configured at 115200 8N1
> +- ``fastboot`` tool on the host
> +
> +Hardware Setup
> +~~~~~~~~~~~~~~
> +
> +**1. UART Connection**
> +
> +Connect a 3.3V USB-to-UART cable to the **J25** header on the BPI-F3.

Isn't this documentation meant to apply to all K1 boards?

How about:

Connect a 3.3V USB-to-UART cable to the board's UART header (J25 on the 
BPI-F3).

> +Remove all other cables first, then attach UART::

This sentence should precede before "Connect a 3.3V ....".

> +
> +    BPI-F3 top view
> +    +--------------------------------------------------+
> +    |                                                  |
> +    |   J15: USB-C [====]     [FDL] [PWR] [RST]       |
> +    |                                                  |
> +    |                                                  |
> +    |                              J25 (UART header)   |
> +    |                              [TXD] [RXD] [GND]  |
> +    +--------------------------------------------------+

I guess the ragged right border is not intentional.

> +
> +After UART is connected, attach the USB Type-C cable to J15 to power on.
> +
> +**2. Serial Console**
> +
> +.. code-block:: console
> +
> +   $ minicom -D /dev/ttyUSB0
> +
> +Default baudrate: 115200.
> +
> +Building U-Boot SPL
> +~~~~~~~~~~~~~~~~~~~~
> +
> +**1. Obtain the DDR training firmware**
> +
> +The DDR training firmware is a proprietary binary provided by SpacemiT. It is
> +not included in U-Boot and must be downloaded separately from:
> +
> +https://github.com/spacemit-com/spacemit-firmware/tree/master/k1/v0.2
> +
> +Download ``ddr_fw.bin`` from that directory.
> +
> +This binary is integrated into the SPL image at build time via the binman
> +framework. When the SPL image is loaded to SRAM (e.g., via USB fastboot),
> +the SPL executes the DDR firmware from SRAM to perform DDR initialization.
> +
> +**2. Build SPL**
> +
> +.. code-block:: console
> +
> +   $ export CROSS_COMPILE=riscv64-linux-gnu-
> +   $ export ARCH=riscv
> +   $ export DDR_FW_FILE=$(pwd)/ddr_fw.bin
> +   $ make spacemit_k1_defconfig
> +   $ make
> +
> +Output: ``u-boot-spl-ddr.bin`` in the build directory. This image contains the
> +SPL code and the DDR firmware blob packaged together via binman.
> +
> +.. note::
> +
> +   If ``DDR_FW_FILE`` is not set, the build completes with an empty
> +   placeholder. The resulting SPL will boot but cannot initialize DDR.
> +
> +**3. Generate signed FSBL image**
> +
> +The K1 BootROM requires a signed first-stage bootloader (FSBL). The signing
> +tool (``tools/build_binary_file.py``) is in SpacemiT's vendor U-Boot repository:
> +
> +.. code-block:: console
> +
> +   $ git clone -b k1-bl-v2.2.y https://gitee.com/spacemit-buildroot/uboot-2022.10
> +
> +The script uses ``fsbl_ddr.json`` which may not exist by default. If
> +``fsbl_ddr.json`` does not exist in
> +``uboot-2022.10/board/spacemit/k1-x/configs/``,
> +create it by copying ``fsbl.json`` and replacing the reference to
> +``u-boot-spl.bin`` with ``u-boot-spl-ddr.bin``:
> +
> +.. code-block:: console
> +
> +   $ cd uboot-2022.10/board/spacemit/k1-x/configs
> +   $ cp fsbl.json fsbl_ddr.json
> +   $ sed -i 's/u-boot-spl\.bin/u-boot-spl-ddr.bin/g' fsbl_ddr.json
> +
> +Create the ``fsbl.sh`` script below in the ``uboot-2022.10`` directory.
> +Update the path variables to match your local setup:
> +
> +.. code-block:: bash
> +
> +   #!/bin/sh
> +   MAINLINE_UBOOT_IMG_PATH="{your path}/u-boot"
> +   MAINLINE_SPL_IMG_PATH="{your path}/u-boot/spl"
> +   FSBL_PATH="{your path}/uboot-2022.10/spl_bin"
> +   KEY_TOOL_PATH="{your path}/uboot-2022.10/tools"
> +   CONFIG_PATH="{your path}/uboot-2022.10/board/spacemit/k1-x/configs"
> +
> +   mkdir -p ${FSBL_PATH}
> +   echo "Clean binaries in ${FSBL_PATH}"
> +   rm -f ${FSBL_PATH}/u-boot-spl-ddr.bin
> +   rm -f ${FSBL_PATH}/u-boot-spl.bin
> +
> +   if [ ! -d ${MAINLINE_SPL_IMG_PATH} ]; then
> +           MAINLINE_UBOOT_IMG_PATH="{your path}/build"
> +           MAINLINE_SPL_IMG_PATH="{your path}/build/spl"
> +   fi
> +
> +   cp ${MAINLINE_UBOOT_IMG_PATH}/u-boot-spl-ddr.bin ${FSBL_PATH}/
> +   python3 ${KEY_TOOL_PATH}/build_binary_file.py \
> +       -c ${CONFIG_PATH}/fsbl_ddr.json \
> +       -o ${FSBL_PATH}/FSBL.bin
> +
> +Then run:
> +
> +.. code-block:: console
> +
> +   $ chmod +x fsbl.sh
> +   $ ./fsbl.sh
> +
> +Output: ``FSBL.bin`` in the ``spl_bin`` directory, ready for deployment.
> +
> +Deploying via USB Fastboot
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +To enter BootROM fastboot mode:
> +
> +1. Disconnect USB Type-C cable from J15 (power off)

J15 is only the designation on the BPI-F3. A more generic term may be 
needed.

How about:

Power of the board by disconnecting the OTG port (J15 on BPI-F3) and any 
additional power supply (12 V on BPI-F3).

> +2. **Press and hold** the FDL button (see board layout above)
> +3. Reconnect USB Type-C cable while holding the FDL button

How about:

While holding the FDL button use an USB cable to connect the OTG port to 
your host. This cable will be used by fastboot to upload the firmware.

The OTG USB should be detected as

361c:1001 DFU USB download gadget


> +4. Release the FDL button

https://docs.banana-pi.org/en/BPI-F3/GettingStarted_BPI-F3 has additionally:

(If you are worried about insufficient USB power, you can first plug in 
the power, then release the button, and then plug in the USB cable)

> +
> +The serial console should show a BootROM prompt indicating it is ready to
> +accept an image via USB.
> +
> +On the host:
> +
> +.. code-block:: console
> +
> +   $ sudo fastboot stage FSBL.bin

Maybe a minimum tested version of fastboot should be indicated, cf.
https://gist.github.com/orangecms/8624aa82bab4931f787b5eee572f7668

> +   $ sudo fastboot continue
> +
> +Expected Output
> +~~~~~~~~~~~~~~~~
> +
> +After successful SPL boot with DDR initialization, the serial console displays::

At least the first line will be different.

%s/After/During/
%s/displays/shows output like/

> +
> +    U-Boot SPL 2026.04-rc4-00543-g2ba03a569e61 (Mar 26 2026 - 16:48:44 +0100)
 > +    Fail to detect board:-2> +    vdd_core, value:900000
> +    vdd_1v8, value:1800000
> +    vdd_1v8_mmc, value:500000
> +    DDR firmware: [0xc08159c0]:0xf0227179, size:0x8d98
> +    DDR is ready
> +    SPL: Unsupported Boot Device!
> +    SPL: failed to boot from all boot devices
> +    ### ERROR ### Please RESET the board ###
> +
> +To walk through the key lines:
> +
> +- ``DDR firmware: [...], size:0x8d98`` - DDR firmware loaded successfully
> +- ``DDR is ready`` - DDR initialization completed
> +- ``SPL: failed to boot from all boot devices`` - expected at this stage,
> +  confirms that SPL with DDR init is working correctly
> +
> +.. note::
> +
> +   After DDR init succeeds, SPL proceeds to load U-Boot proper. Since
> +   SPI NOR storage driver support is not yet available, SPL cannot
> +   transition into U-Boot proper. When U-Boot stage support is ready,
> +   this document will be updated.

Please, move the note to the top of the document so that reader does not 
discover at the end of the process that their board does not boot anymore.

Best regards

Heinrich

> +
> +If SPL hangs before printing DDR messages, verify that ``DDR_FW_FILE`` was set
> +during build and that ``ddr_fw.bin`` is not empty.
> +
> +References
> +~~~~~~~~~~~
> +
> +- `DDR firmware repository <https://github.com/spacemit-com/spacemit-firmware>`_
> +- `SpacemiT vendor U-Boot (signing tool) <https://gitee.com/spacemit-buildroot/uboot-2022.10>`_
