Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1828C83F17
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 08:08:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3656864A2;
	Mon, 28 Aug 2023 10:08:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20221208.gappssmtp.com header.i=@baylibre-com.20221208.gappssmtp.com header.b="gBgSVi1C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5783F8649F; Mon, 28 Aug 2023 10:08:00 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E4B5803AB
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 10:07:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-401b393df02so28176305e9.1
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 01:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1693210076; x=1693814876; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aeG5xvuFOO7KjyzK6f1YG7kzoIZ/hXJMwafvWsLoCos=;
 b=gBgSVi1CFrElNa/SP50I4W2NfqUYkUVXiMq9DcWR3rl8IkdkrcpkCW4tJnK8zZ9i2I
 KgsPQvf9hVPfVZTGGy+5aulA7FllEje5vzPotpZIMfUcNtPWCl9vEAOx0CrO9bDX9zaU
 YBtIlNgjfYf1TH2bt6G267OrQp78fHAJd1xSTGJXLms0HbImhNpP6YICbDz7oJnR8WgJ
 skeup/ddQcGWdlqGd7Kie60YsJ5NNtv2sIDohNZQT80C4H035I6DeW50JIhy8wkKUfAN
 yyxzeRhjm+iIWAVHNo8p7mnRfmzSWeQlmFbRFRQtoPcHZUsxGms0gbs0+ruoXbqK3jJG
 jgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693210076; x=1693814876;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aeG5xvuFOO7KjyzK6f1YG7kzoIZ/hXJMwafvWsLoCos=;
 b=gN8zM1dMp+zDseVwBF1N8ooPSNTspC0px+nsMnxuY6cFbEEZDoBg4yQ7nG7fWf12sM
 tt+Kjyx0BJm7WKemgXE9kE6vP6vY20Lu6riMd4cVTZii4c+JSAYMFKBWHly9WC6CayaM
 jiYC5Ryg8RkRFIlMRqhXrocoPpQcgJN81v08CPaX2GIRbed6uacmwxr6iRe4AS+SWWLx
 PN5E2RThzN2wCLW4aoAlHoW9y0/EdVM4SeoBIWDRXzdrPVybhN7jMFP6Q8EmLsF9tXX0
 2fEty6WlWWosi79YwesgnC8Y00wVKIIoP2p2I4+Vnqn3dFA7S24Sf4c+1bPaJdZmhbMS
 pdrQ==
X-Gm-Message-State: AOJu0YxsmhgYsxxwSVRzwBCW4oee1UVlvzbKYpuS0FpdAa/h0wiaZGvJ
 tT3By+nIhzadscmWr8ndFGuE2A==
X-Google-Smtp-Source: AGHT+IGh5U/rXKWw0GQH+oml13QCckEMzhFPrrGDReCgroUvxfBp+IsWLe7/2UW48rkpTtl3AYKz8g==
X-Received: by 2002:a7b:c8d0:0:b0:3fc:7d2:e0c0 with SMTP id
 f16-20020a7bc8d0000000b003fc07d2e0c0mr19030213wml.27.1693210076549; 
 Mon, 28 Aug 2023 01:07:56 -0700 (PDT)
Received: from localhost ([2a01:cb19:8704:be00:4f55:bd9d:611a:6c8e])
 by smtp.gmail.com with ESMTPSA id
 x10-20020a05600c21ca00b003fef3180e7asm13080174wmj.44.2023.08.28.01.07.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 01:07:56 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>, Neha Francis <n-francis@ti.com>, Tom
 Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, Nishanth Menon
 <nm@ti.com>
Subject: Re: [RFC PATCH 2/2] doc: board: ti: k3: Convert to sphinx-prompt
In-Reply-To: <20230824154036.3650607-3-nm@ti.com>
References: <20230824154036.3650607-1-nm@ti.com>
 <20230824154036.3650607-3-nm@ti.com>
Date: Mon, 28 Aug 2023 10:07:55 +0200
Message-ID: <87v8czwpwk.fsf@baylibre.com>
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

On jeu., ao=C3=BBt 24, 2023 at 10:40, Nishanth Menon <nm@ti.com> wrote:

> Sphinx-prompt provides a handy scheme to provide documentation that
> renders nicely and yet provides a scheme to copy paste for users without
> having to hand-edit the copied text as is the result of code-block
>
> [1] https://lore.kernel.org/all/87fs48rgto.fsf@baylibre.com/
> Reported-by: Simon Glass <sjg@chromium.org>
> Suggested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Small nitpick below, which is probably a matter of preference

> ---
>  doc/board/ti/k3.rst | 112 ++++++++++++++++++++++----------------------
>  1 file changed, 57 insertions(+), 55 deletions(-)
>
> diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
> index 1175b776ad48..ec447358ac39 100644
> --- a/doc/board/ti/k3.rst
> +++ b/doc/board/ti/k3.rst
> @@ -194,13 +194,13 @@ All of that to say you will need both a 32bit and 6=
4bit cross compiler
>  .. k3_rst_include_end_common_env_vars_desc
>=20=20
>  .. k3_rst_include_start_common_env_vars_defn
> -.. code-block:: bash
> +.. prompt:: bash
>=20=20
> - $ export CC32=3Darm-linux-gnueabihf-
> - $ export CC64=3Daarch64-linux-gnu-
> - $ export LNX_FW_PATH=3Dpath/to/ti-linux-firmware
> - $ export TFA_PATH=3Dpath/to/trusted-firmware-a
> - $ export OPTEE_PATH=3Dpath/to/optee_os
> + export CC32=3Darm-linux-gnueabihf-
> + export CC64=3Daarch64-linux-gnu-
> + export LNX_FW_PATH=3Dpath/to/ti-linux-firmware
> + export TFA_PATH=3Dpath/to/trusted-firmware-a
> + export OPTEE_PATH=3Dpath/to/optee_os
>  .. k3_rst_include_end_common_env_vars_defn
>=20=20
>  We will also need some common environment variables set up for the vario=
us
> @@ -244,11 +244,11 @@ Building tiboot3.bin
>     uses the split binary flow)
>=20=20
>  .. k3_rst_include_start_build_steps_spl_r5
> -.. code-block:: bash
> +.. prompt:: bash
>=20=20
> - $ # inside u-boot source
> - $ make $UBOOT_CFG_CORTEXR
> - $ make CROSS_COMPILE=3D$CC32 BINMAN_INDIRS=3D$LNX_FW_PATH
> + # inside u-boot source
> + make $UBOOT_CFG_CORTEXR
> + make CROSS_COMPILE=3D$CC32 BINMAN_INDIRS=3D$LNX_FW_PATH
>  .. k3_rst_include_end_build_steps_spl_r5
>=20=20
>  At this point you should have all the needed binaries to boot the wakeup
> @@ -280,11 +280,11 @@ firmware if your device using a split firmware.
>     application cores on the main domain.
>=20=20
>  .. k3_rst_include_start_build_steps_tfa
> -.. code-block:: bash
> +.. prompt:: bash
>=20=20
> - $ # inside trusted-firmware-a source
> - $ make CROSS_COMPILE=3D$CC64 ARCH=3Daarch64 PLAT=3Dk3 SPD=3Dopteed $TFA=
_EXTRA_ARGS \
> -        TARGET_BOARD=3D$TFA_BOARD
> + # inside trusted-firmware-a source
> + make CROSS_COMPILE=3D$CC64 ARCH=3Daarch64 PLAT=3Dk3 SPD=3Dopteed $TFA_E=
XTRA_ARGS \
> +      TARGET_BOARD=3D$TFA_BOARD
>  .. k3_rst_include_end_build_steps_tfa
>=20=20
>  Typically all `j7*` devices will use `TARGET_BOARD=3Dgeneric` or `TARGET=
_BOARD
> @@ -296,11 +296,11 @@ use the `lite` option.
>     using the TrustZone technology built into the core.
>=20=20
>  .. k3_rst_include_start_build_steps_optee
> -.. code-block:: bash
> +.. prompt:: bash
>=20=20
> - $ # inside optee_os source
> - $ make CROSS_COMPILE=3D$CC32 CROSS_COMPILE64=3D$CC64 CFG_ARM64_core=3Dy=
 $OPTEE_EXTRA_ARGS \
> -         PLATFORM=3D$OPTEE_PLATFORM
> + # inside optee_os source
> + make CROSS_COMPILE=3D$CC32 CROSS_COMPILE64=3D$CC64 CFG_ARM64_core=3Dy $=
OPTEE_EXTRA_ARGS \
> +       PLATFORM=3D$OPTEE_PLATFORM
>  .. k3_rst_include_end_build_steps_optee
>=20=20
>  4. Finally, after TF-A has initialized the main domain and OP-TEE has
> @@ -308,11 +308,11 @@ use the `lite` option.
>     64bit core in the main domain.
>=20=20
>  .. k3_rst_include_start_build_steps_uboot
> -.. code-block:: bash
> +.. prompt:: bash
>=20=20
> - $ # inside u-boot source
> - $ make $UBOOT_CFG_CORTEXA
> - $ make CROSS_COMPILE=3D$CC64 BINMAN_INDIRS=3D$LNX_FW_PATH \
> + # inside u-boot source
> + make $UBOOT_CFG_CORTEXA
> + make CROSS_COMPILE=3D$CC64 BINMAN_INDIRS=3D$LNX_FW_PATH \
>          BL31=3D$TFA_PATH/build/k3/$TFA_BOARD/release/bl31.bin \
>          TEE=3D$OPTEE_PATH/out/arm-plat-k3/core/tee-raw.bin
>  .. k3_rst_include_end_build_steps_uboot
> @@ -407,14 +407,14 @@ and the same can be extended to other platforms
>    be passing to mkimage for signing the fitImage and embedding the key in
>    the u-boot dtb.
>=20=20
> -  .. code-block:: bash
> +  .. prompt:: bash
>=20=20
>      mkimage -r -f fitImage.its -k $UBOOT_PATH/board/ti/keys -K
>      $UBOOT_PATH/build/a72/dts/dt.dtb
>=20=20
>    For signing a secondary platform, pass the -K parameter to that DTB
>=20=20
> -  .. code-block:: bash
> +  .. prompt:: bash
>=20=20
>      mkimage -f fitImage.its -k $UBOOT_PATH/board/ti/keys -K
>      $UBOOT_PATH/build/a72/arch/arm/dts/k3-j721e-sk.dtb
> @@ -473,10 +473,11 @@ then the saveenv command and can be used across var=
ious bootmodes too.
>=20=20
>  **Writing to MMC/EMMC**
>=20=20
> -.. code-block::
> +.. prompt:: bash
> +  :prompts: =3D>

nitpick: This can be a one-liner by using the "prompts" positional argument

 .. prompt:: bash =3D>


>=20=20
> -  =3D> env export -t $loadaddr <list of variables>
> -  =3D> fatwrite mmc ${mmcdev} ${loadaddr} ${bootenvfile} ${filesize}
> +  env export -t $loadaddr <list of variables>
> +  fatwrite mmc ${mmcdev} ${loadaddr} ${bootenvfile} ${filesize}
>=20=20
>  **Reading from MMC/EMMC**
>=20=20
> @@ -486,10 +487,11 @@ mmcdev) and set the environments.
>  If manually needs to be done then the environment can be read from the
>  filesystem and then imported
>=20=20
> -.. code-block::
> +.. prompt:: bash
> +  :prompts: =3D>

nitpick: Same here

>=20=20
> -  =3D> fatload mmc ${mmcdev} ${loadaddr} ${bootenvfile}
> -  =3D> env import -t ${loadaddr} ${filesize}
> +  fatload mmc ${mmcdev} ${loadaddr} ${bootenvfile}
> +  env import -t ${loadaddr} ${filesize}
>=20=20
>  .. _k3_rst_refer_openocd:
>=20=20
> @@ -546,7 +548,7 @@ Refer to the release notes corresponding to the `Open=
OCD version
>    box support by OpenOCD. The board-specific documentation will
>    cover the details and any adapter/dongle recommendations.
>=20=20
> -.. code-block:: bash
> +.. prompt:: bash
>=20=20
>   openocd -v
>=20=20
> @@ -564,21 +566,21 @@ systems, but equivalent instructions should exist f=
or systems with
>  other package managers. Please refer to the `OpenOCD Documentation
>  <https://openocd.org/>`_ for more recent installation steps.
>=20=20
> -.. code-block:: bash
> +.. prompt:: bash
>=20=20
> -  $ # Check the packages to be installed: needs deb-src in sources.list
> -  $ sudo apt build-dep openocd
> -  $ # The following list is NOT complete - please check the latest
> -  $ sudo apt-get install libtool pkg-config texinfo libusb-dev \
> +  # Check the packages to be installed: needs deb-src in sources.list
> +  sudo apt build-dep openocd
> +  # The following list is NOT complete - please check the latest
> +  sudo apt-get install libtool pkg-config texinfo libusb-dev \
>      libusb-1.0.0-dev libftdi-dev libhidapi-dev autoconf automake
> -  $ git clone https://github.com/openocd-org/openocd.git openocd
> -  $ cd openocd
> -  $ git submodule init
> -  $ git submodule update
> -  $ ./bootstrap
> -  $ ./configure --prefix=3D/usr/local/
> -  $ make -j`nproc`
> -  $ sudo make install
> +  git clone https://github.com/openocd-org/openocd.git openocd
> +  cd openocd
> +  git submodule init
> +  git submodule update
> +  ./bootstrap
> +  ./configure --prefix=3D/usr/local/
> +  make -j`nproc`
> +  sudo make install
>=20=20
>  .. note::
>=20=20
> @@ -594,28 +596,28 @@ The step is not necessary if the distribution suppo=
rts the OpenOCD, but
>  if building from a source, ensure that the udev rules are installed
>  correctly to ensure a sane system.
>=20=20
> -.. code-block:: bash
> +.. prompt:: bash
>=20=20
>    # Go to the OpenOCD source directory
> -  $ cd openocd
> -  # Copy the udev rules to the correct system location
> -  $ sudo cp ./contrib/60-openocd.rules \
> +  cd openocd
> +  Copy the udev rules to the correct system location
> +  sudo cp ./contrib/60-openocd.rules \
>        ./src/jtag/drivers/libjaylink/contrib/99-libjaylink.rules \
>        /etc/udev/rules.d/
>    # Get Udev to load the new rules up
> -  $ sudo udevadm control --reload-rules
> +  sudo udevadm control --reload-rules
>    # Use the new rules on existing connected devices
> -  $ sudo udevadm trigger
> +  sudo udevadm trigger
>=20=20
>  Step 2: Setup GDB
>  ^^^^^^^^^^^^^^^^^
>=20=20
>  Most systems come with gdb-multiarch package.
>=20=20
> -.. code-block:: bash
> +.. prompt:: bash
>=20=20
>    # Install gdb-multiarch package
> -  $ sudo apt-get install gdb-multiarch
> +  sudo apt-get install gdb-multiarch
>=20=20
>  Though using GDB natively is normal, developers with interest in using I=
DE
>  may find a few of these interesting:
> @@ -828,7 +830,7 @@ Startup OpenOCD to debug the platform as follows:
>=20=20
>  .. k3_rst_include_start_openocd_cfg_XDS110
>=20=20
> -.. code-block:: bash
> +.. prompt:: bash
>=20=20
>    openocd -f board/{board_of_choice}.cfg
>=20=20
> @@ -842,7 +844,7 @@ Startup OpenOCD to debug the platform as follows:
>    <https://github.com/openocd-org/openocd/blob/master/tcl/target/ti_k3.c=
fg#L59>`_
>    to decide if the SoC is supported or not.
>=20=20
> -.. code-block:: bash
> +.. prompt:: bash
>=20=20
>    openocd -f openocd_connect.cfg
>=20=20
> @@ -917,7 +919,7 @@ To debug using this server, use GDB directly or your =
preferred
>  GDB-based IDE. To start up GDB in the terminal, run the following
>  command.
>=20=20
> -.. code-block:: bash
> +.. prompt:: bash
>=20=20
>    gdb-multiarch
>=20=20
> --=20
> 2.40.0
