Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD4AC3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 15:50:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BE5686596;
	Thu, 24 Aug 2023 17:50:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="tNIzSQM4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9E90865A9; Thu, 24 Aug 2023 17:50:46 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B19748609B
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 17:50:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 597683F171
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 15:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1692892243;
 bh=yEDJOVsCq9NirMC9iK/QjkN582EnX7Ut5bI9F0wTG2o=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=tNIzSQM4cXFC0x9o3PBGGG9XOjXanheBPSKUAJbo1BS1KBWmTl7Gsbj6LfjbfRtsy
 Vhha1U7W9HKPERTA559E22mBdiAZXT3Xx1JPuNZyvp7Rz0DWscbWvbYwtDfcw0SkO8
 K968Wd35T5sBRu7fUH+FO7oiM4X0jXqxTYpNERz1wCzmpPbMzpGiHvLfRhyh5BvRmD
 xqps49T8FHAr7g+t4620Km8dBHffqX6C2RjinTQgK34W0kgUsbrmjBHCeSnGe72ZF7
 CYFoL2qY2+WX2tQ4x/zf5OMlK/Pho/tniROQ4IOV6NdsL4qgA5rVQW1NjktONDVrj8
 /sU0tB8WJL2SA==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3ffa2d2a516so12915695e9.1
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 08:50:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692892243; x=1693497043;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yEDJOVsCq9NirMC9iK/QjkN582EnX7Ut5bI9F0wTG2o=;
 b=U9RQ4bV3rGy4jpnevYJOB8UfObk9r2U51/1FEnXycLSzp8xWOiOeCWzfuJEFm9ELa6
 aPu8yIzPNwFQQotJegugPIPV3+6v+NIweyUZ+xYd8FvHhYsFpkclchV1JvBoDVK9StSe
 p3+yyBiqGMc9Brj82yM2MQzNgIzFNMxHadDMhPJR1AZWzF6t5fS6bTEhbwxh9/xMyxtV
 AgkmW+VRYQ3K/4aX9UNnyDF3ab7PkUhAbkXjwSErR8q1sr2LPFkpPo0KpOJoN7F9EM08
 akcQfOsG9HGBHokqRHrop0C7hqY7Yc5z54Mk9GF5lvC3SZIg0vRQGYZbMBDjjma3k81X
 5E+g==
X-Gm-Message-State: AOJu0Yz2ezzSB5oCNx6gsIjbIEo0M6SandlV7gm2ihFYmAioyBaNJgF5
 7gkUuaxwDdjpQWKtNcWPM76CD6kLtzY0hOHk+eg53ghHetpYn7weZiDUixVJZpOvYxEXg4IKrjM
 ugd9zpNW9ovkGXurrP6hnTNyc/p3axUQ=
X-Received: by 2002:a1c:7c10:0:b0:401:b204:3b98 with SMTP id
 x16-20020a1c7c10000000b00401b2043b98mr846557wmc.19.1692892242966; 
 Thu, 24 Aug 2023 08:50:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXg3FHfWRUShb6URUy1qAEgMDoX3rTTvEZiHEXEIAx+cJQ0rrZ6+laE214RHWhWxNVgAuwvg==
X-Received: by 2002:a1c:7c10:0:b0:401:b204:3b98 with SMTP id
 x16-20020a1c7c10000000b00401b2043b98mr846537wmc.19.1692892242500; 
 Thu, 24 Aug 2023 08:50:42 -0700 (PDT)
Received: from [192.168.123.67] (ip-062-143-244-162.um16.pools.vodafone-ip.de.
 [62.143.244.162]) by smtp.gmail.com with ESMTPSA id
 x1-20020a05600c2a4100b003fefaf299b6sm2979039wme.38.2023.08.24.08.50.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Aug 2023 08:50:42 -0700 (PDT)
Message-ID: <cc5d8c56-546a-4cd7-6a78-1206e9675555@canonical.com>
Date: Thu, 24 Aug 2023 17:50:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 2/2] doc: board: ti: k3: Convert to sphinx-prompt
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>, Neha Francis <n-francis@ti.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>
References: <20230824154036.3650607-1-nm@ti.com>
 <20230824154036.3650607-3-nm@ti.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20230824154036.3650607-3-nm@ti.com>
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

On 24.08.23 17:40, Nishanth Menon wrote:
> Sphinx-prompt provides a handy scheme to provide documentation that
> renders nicely and yet provides a scheme to copy paste for users without
> having to hand-edit the copied text as is the result of code-block
> 
> [1] https://lore.kernel.org/all/87fs48rgto.fsf@baylibre.com/
> Reported-by: Simon Glass <sjg@chromium.org>
> Suggested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>   doc/board/ti/k3.rst | 112 ++++++++++++++++++++++----------------------
>   1 file changed, 57 insertions(+), 55 deletions(-)
> 
> diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
> index 1175b776ad48..ec447358ac39 100644
> --- a/doc/board/ti/k3.rst
> +++ b/doc/board/ti/k3.rst
> @@ -194,13 +194,13 @@ All of that to say you will need both a 32bit and 64bit cross compiler
>   .. k3_rst_include_end_common_env_vars_desc
>   
>   .. k3_rst_include_start_common_env_vars_defn
> -.. code-block:: bash
> +.. prompt:: bash
>   
> - $ export CC32=arm-linux-gnueabihf-
> - $ export CC64=aarch64-linux-gnu-
> - $ export LNX_FW_PATH=path/to/ti-linux-firmware
> - $ export TFA_PATH=path/to/trusted-firmware-a
> - $ export OPTEE_PATH=path/to/optee_os
> + export CC32=arm-linux-gnueabihf-
> + export CC64=aarch64-linux-gnu-
> + export LNX_FW_PATH=path/to/ti-linux-firmware
> + export TFA_PATH=path/to/trusted-firmware-a
> + export OPTEE_PATH=path/to/optee_os
>   .. k3_rst_include_end_common_env_vars_defn
>   
>   We will also need some common environment variables set up for the various
> @@ -244,11 +244,11 @@ Building tiboot3.bin
>      uses the split binary flow)
>   
>   .. k3_rst_include_start_build_steps_spl_r5
> -.. code-block:: bash
> +.. prompt:: bash
>   
> - $ # inside u-boot source
> - $ make $UBOOT_CFG_CORTEXR
> - $ make CROSS_COMPILE=$CC32 BINMAN_INDIRS=$LNX_FW_PATH
> + # inside u-boot source
> + make $UBOOT_CFG_CORTEXR
> + make CROSS_COMPILE=$CC32 BINMAN_INDIRS=$LNX_FW_PATH
>   .. k3_rst_include_end_build_steps_spl_r5
>   
>   At this point you should have all the needed binaries to boot the wakeup
> @@ -280,11 +280,11 @@ firmware if your device using a split firmware.
>      application cores on the main domain.
>   
>   .. k3_rst_include_start_build_steps_tfa
> -.. code-block:: bash
> +.. prompt:: bash
>   
> - $ # inside trusted-firmware-a source
> - $ make CROSS_COMPILE=$CC64 ARCH=aarch64 PLAT=k3 SPD=opteed $TFA_EXTRA_ARGS \
> -        TARGET_BOARD=$TFA_BOARD
> + # inside trusted-firmware-a source
> + make CROSS_COMPILE=$CC64 ARCH=aarch64 PLAT=k3 SPD=opteed $TFA_EXTRA_ARGS \
> +      TARGET_BOARD=$TFA_BOARD
>   .. k3_rst_include_end_build_steps_tfa
>   
>   Typically all `j7*` devices will use `TARGET_BOARD=generic` or `TARGET_BOARD
> @@ -296,11 +296,11 @@ use the `lite` option.
>      using the TrustZone technology built into the core.
>   
>   .. k3_rst_include_start_build_steps_optee
> -.. code-block:: bash
> +.. prompt:: bash
>   
> - $ # inside optee_os source
> - $ make CROSS_COMPILE=$CC32 CROSS_COMPILE64=$CC64 CFG_ARM64_core=y $OPTEE_EXTRA_ARGS \
> -         PLATFORM=$OPTEE_PLATFORM
> + # inside optee_os source
> + make CROSS_COMPILE=$CC32 CROSS_COMPILE64=$CC64 CFG_ARM64_core=y $OPTEE_EXTRA_ARGS \
> +       PLATFORM=$OPTEE_PLATFORM
>   .. k3_rst_include_end_build_steps_optee
>   
>   4. Finally, after TF-A has initialized the main domain and OP-TEE has
> @@ -308,11 +308,11 @@ use the `lite` option.
>      64bit core in the main domain.
>   
>   .. k3_rst_include_start_build_steps_uboot
> -.. code-block:: bash
> +.. prompt:: bash
>   
> - $ # inside u-boot source
> - $ make $UBOOT_CFG_CORTEXA
> - $ make CROSS_COMPILE=$CC64 BINMAN_INDIRS=$LNX_FW_PATH \
> + # inside u-boot source
> + make $UBOOT_CFG_CORTEXA
> + make CROSS_COMPILE=$CC64 BINMAN_INDIRS=$LNX_FW_PATH \
>           BL31=$TFA_PATH/build/k3/$TFA_BOARD/release/bl31.bin \
>           TEE=$OPTEE_PATH/out/arm-plat-k3/core/tee-raw.bin
>   .. k3_rst_include_end_build_steps_uboot
> @@ -407,14 +407,14 @@ and the same can be extended to other platforms
>     be passing to mkimage for signing the fitImage and embedding the key in
>     the u-boot dtb.
>   
> -  .. code-block:: bash
> +  .. prompt:: bash
>   
>       mkimage -r -f fitImage.its -k $UBOOT_PATH/board/ti/keys -K
>       $UBOOT_PATH/build/a72/dts/dt.dtb
>   
>     For signing a secondary platform, pass the -K parameter to that DTB
>   
> -  .. code-block:: bash
> +  .. prompt:: bash
>   
>       mkimage -f fitImage.its -k $UBOOT_PATH/board/ti/keys -K
>       $UBOOT_PATH/build/a72/arch/arm/dts/k3-j721e-sk.dtb
> @@ -473,10 +473,11 @@ then the saveenv command and can be used across various bootmodes too.
>   
>   **Writing to MMC/EMMC**
>   
> -.. code-block::
> +.. prompt:: bash
> +  :prompts: =>
>   
> -  => env export -t $loadaddr <list of variables>
> -  => fatwrite mmc ${mmcdev} ${loadaddr} ${bootenvfile} ${filesize}
> +  env export -t $loadaddr <list of variables>
> +  fatwrite mmc ${mmcdev} ${loadaddr} ${bootenvfile} ${filesize}
>   
>   **Reading from MMC/EMMC**
>   
> @@ -486,10 +487,11 @@ mmcdev) and set the environments.
>   If manually needs to be done then the environment can be read from the
>   filesystem and then imported
>   
> -.. code-block::
> +.. prompt:: bash
> +  :prompts: =>
>   
> -  => fatload mmc ${mmcdev} ${loadaddr} ${bootenvfile}
> -  => env import -t ${loadaddr} ${filesize}
> +  fatload mmc ${mmcdev} ${loadaddr} ${bootenvfile}
> +  env import -t ${loadaddr} ${filesize}
>   
>   .. _k3_rst_refer_openocd:
>   
> @@ -546,7 +548,7 @@ Refer to the release notes corresponding to the `OpenOCD version
>     box support by OpenOCD. The board-specific documentation will
>     cover the details and any adapter/dongle recommendations.
>   
> -.. code-block:: bash
> +.. prompt:: bash
>   
>    openocd -v
>   
> @@ -564,21 +566,21 @@ systems, but equivalent instructions should exist for systems with
>   other package managers. Please refer to the `OpenOCD Documentation
>   <https://openocd.org/>`_ for more recent installation steps.
>   
> -.. code-block:: bash
> +.. prompt:: bash
>   
> -  $ # Check the packages to be installed: needs deb-src in sources.list
> -  $ sudo apt build-dep openocd
> -  $ # The following list is NOT complete - please check the latest
> -  $ sudo apt-get install libtool pkg-config texinfo libusb-dev \
> +  # Check the packages to be installed: needs deb-src in sources.list
> +  sudo apt build-dep openocd
> +  # The following list is NOT complete - please check the latest
> +  sudo apt-get install libtool pkg-config texinfo libusb-dev \
>       libusb-1.0.0-dev libftdi-dev libhidapi-dev autoconf automake
> -  $ git clone https://github.com/openocd-org/openocd.git openocd
> -  $ cd openocd
> -  $ git submodule init
> -  $ git submodule update
> -  $ ./bootstrap
> -  $ ./configure --prefix=/usr/local/
> -  $ make -j`nproc`
> -  $ sudo make install
> +  git clone https://github.com/openocd-org/openocd.git openocd
> +  cd openocd
> +  git submodule init
> +  git submodule update
> +  ./bootstrap
> +  ./configure --prefix=/usr/local/
> +  make -j`nproc`
> +  sudo make install
>   
>   .. note::
>   
> @@ -594,28 +596,28 @@ The step is not necessary if the distribution supports the OpenOCD, but
>   if building from a source, ensure that the udev rules are installed
>   correctly to ensure a sane system.
>   
> -.. code-block:: bash
> +.. prompt:: bash
>   
>     # Go to the OpenOCD source directory
> -  $ cd openocd
> -  # Copy the udev rules to the correct system location
> -  $ sudo cp ./contrib/60-openocd.rules \
> +  cd openocd
> +  Copy the udev rules to the correct system location
> +  sudo cp ./contrib/60-openocd.rules \
>         ./src/jtag/drivers/libjaylink/contrib/99-libjaylink.rules \
>         /etc/udev/rules.d/
>     # Get Udev to load the new rules up
> -  $ sudo udevadm control --reload-rules
> +  sudo udevadm control --reload-rules
>     # Use the new rules on existing connected devices
> -  $ sudo udevadm trigger
> +  sudo udevadm trigger
>   
>   Step 2: Setup GDB
>   ^^^^^^^^^^^^^^^^^
>   
>   Most systems come with gdb-multiarch package.
>   
> -.. code-block:: bash
> +.. prompt:: bash

.. prompt:: bash $
will enforce $ as prompt?

Cf.
http://sbrunner.github.io/sphinx-prompt/

Best regards

Heinrich

>   
>     # Install gdb-multiarch package
> -  $ sudo apt-get install gdb-multiarch
> +  sudo apt-get install gdb-multiarch
>   
>   Though using GDB natively is normal, developers with interest in using IDE
>   may find a few of these interesting:
> @@ -828,7 +830,7 @@ Startup OpenOCD to debug the platform as follows:
>   
>   .. k3_rst_include_start_openocd_cfg_XDS110
>   
> -.. code-block:: bash
> +.. prompt:: bash
>   
>     openocd -f board/{board_of_choice}.cfg
>   
> @@ -842,7 +844,7 @@ Startup OpenOCD to debug the platform as follows:
>     <https://github.com/openocd-org/openocd/blob/master/tcl/target/ti_k3.cfg#L59>`_
>     to decide if the SoC is supported or not.
>   
> -.. code-block:: bash
> +.. prompt:: bash
>   
>     openocd -f openocd_connect.cfg
>   
> @@ -917,7 +919,7 @@ To debug using this server, use GDB directly or your preferred
>   GDB-based IDE. To start up GDB in the terminal, run the following
>   command.
>   
> -.. code-block:: bash
> +.. prompt:: bash
>   
>     gdb-multiarch
>   

