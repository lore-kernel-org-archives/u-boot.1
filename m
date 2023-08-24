Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDDAC3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 15:41:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E1F58675B;
	Thu, 24 Aug 2023 17:40:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TFbvwDZh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38FEF86703; Thu, 24 Aug 2023 17:40:50 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 826D18657C
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 17:40:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37OFecdm075122;
 Thu, 24 Aug 2023 10:40:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692891638;
 bh=ISbZnm6jGTFKC6UOTxozWlYcxwnF07kEZC/kfRo6qeM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=TFbvwDZhDTiqCOWdj0JGPeXL3VuAL8bmSUmk0vF9nFyV2mPnGmR8c9CLDHFB1v/oW
 2FzUUzg7r3VO8h2mI2BXBc9r+WSoahd0MHYAeyeCXWyR2eZu83XYgW/WLz9Sh3Tlpz
 0BKUngHS3TzjnLYts5ReWm3SKCnPTsLQk+eur4gw=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37OFec0N056626
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 24 Aug 2023 10:40:38 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Aug 2023 10:40:37 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Aug 2023 10:40:37 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37OFebMC009851;
 Thu, 24 Aug 2023 10:40:37 -0500
From: Nishanth Menon <nm@ti.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Neha Francis
 <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Nishanth Menon <nm@ti.com>
Subject: [RFC PATCH 2/2] doc: board: ti: k3: Convert to sphinx-prompt
Date: Thu, 24 Aug 2023 10:40:36 -0500
Message-ID: <20230824154036.3650607-3-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230824154036.3650607-1-nm@ti.com>
References: <20230824154036.3650607-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Sphinx-prompt provides a handy scheme to provide documentation that
renders nicely and yet provides a scheme to copy paste for users without
having to hand-edit the copied text as is the result of code-block

[1] https://lore.kernel.org/all/87fs48rgto.fsf@baylibre.com/
Reported-by: Simon Glass <sjg@chromium.org>
Suggested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 doc/board/ti/k3.rst | 112 ++++++++++++++++++++++----------------------
 1 file changed, 57 insertions(+), 55 deletions(-)

diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index 1175b776ad48..ec447358ac39 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -194,13 +194,13 @@ All of that to say you will need both a 32bit and 64bit cross compiler
 .. k3_rst_include_end_common_env_vars_desc
 
 .. k3_rst_include_start_common_env_vars_defn
-.. code-block:: bash
+.. prompt:: bash
 
- $ export CC32=arm-linux-gnueabihf-
- $ export CC64=aarch64-linux-gnu-
- $ export LNX_FW_PATH=path/to/ti-linux-firmware
- $ export TFA_PATH=path/to/trusted-firmware-a
- $ export OPTEE_PATH=path/to/optee_os
+ export CC32=arm-linux-gnueabihf-
+ export CC64=aarch64-linux-gnu-
+ export LNX_FW_PATH=path/to/ti-linux-firmware
+ export TFA_PATH=path/to/trusted-firmware-a
+ export OPTEE_PATH=path/to/optee_os
 .. k3_rst_include_end_common_env_vars_defn
 
 We will also need some common environment variables set up for the various
@@ -244,11 +244,11 @@ Building tiboot3.bin
    uses the split binary flow)
 
 .. k3_rst_include_start_build_steps_spl_r5
-.. code-block:: bash
+.. prompt:: bash
 
- $ # inside u-boot source
- $ make $UBOOT_CFG_CORTEXR
- $ make CROSS_COMPILE=$CC32 BINMAN_INDIRS=$LNX_FW_PATH
+ # inside u-boot source
+ make $UBOOT_CFG_CORTEXR
+ make CROSS_COMPILE=$CC32 BINMAN_INDIRS=$LNX_FW_PATH
 .. k3_rst_include_end_build_steps_spl_r5
 
 At this point you should have all the needed binaries to boot the wakeup
@@ -280,11 +280,11 @@ firmware if your device using a split firmware.
    application cores on the main domain.
 
 .. k3_rst_include_start_build_steps_tfa
-.. code-block:: bash
+.. prompt:: bash
 
- $ # inside trusted-firmware-a source
- $ make CROSS_COMPILE=$CC64 ARCH=aarch64 PLAT=k3 SPD=opteed $TFA_EXTRA_ARGS \
-        TARGET_BOARD=$TFA_BOARD
+ # inside trusted-firmware-a source
+ make CROSS_COMPILE=$CC64 ARCH=aarch64 PLAT=k3 SPD=opteed $TFA_EXTRA_ARGS \
+      TARGET_BOARD=$TFA_BOARD
 .. k3_rst_include_end_build_steps_tfa
 
 Typically all `j7*` devices will use `TARGET_BOARD=generic` or `TARGET_BOARD
@@ -296,11 +296,11 @@ use the `lite` option.
    using the TrustZone technology built into the core.
 
 .. k3_rst_include_start_build_steps_optee
-.. code-block:: bash
+.. prompt:: bash
 
- $ # inside optee_os source
- $ make CROSS_COMPILE=$CC32 CROSS_COMPILE64=$CC64 CFG_ARM64_core=y $OPTEE_EXTRA_ARGS \
-         PLATFORM=$OPTEE_PLATFORM
+ # inside optee_os source
+ make CROSS_COMPILE=$CC32 CROSS_COMPILE64=$CC64 CFG_ARM64_core=y $OPTEE_EXTRA_ARGS \
+       PLATFORM=$OPTEE_PLATFORM
 .. k3_rst_include_end_build_steps_optee
 
 4. Finally, after TF-A has initialized the main domain and OP-TEE has
@@ -308,11 +308,11 @@ use the `lite` option.
    64bit core in the main domain.
 
 .. k3_rst_include_start_build_steps_uboot
-.. code-block:: bash
+.. prompt:: bash
 
- $ # inside u-boot source
- $ make $UBOOT_CFG_CORTEXA
- $ make CROSS_COMPILE=$CC64 BINMAN_INDIRS=$LNX_FW_PATH \
+ # inside u-boot source
+ make $UBOOT_CFG_CORTEXA
+ make CROSS_COMPILE=$CC64 BINMAN_INDIRS=$LNX_FW_PATH \
         BL31=$TFA_PATH/build/k3/$TFA_BOARD/release/bl31.bin \
         TEE=$OPTEE_PATH/out/arm-plat-k3/core/tee-raw.bin
 .. k3_rst_include_end_build_steps_uboot
@@ -407,14 +407,14 @@ and the same can be extended to other platforms
   be passing to mkimage for signing the fitImage and embedding the key in
   the u-boot dtb.
 
-  .. code-block:: bash
+  .. prompt:: bash
 
     mkimage -r -f fitImage.its -k $UBOOT_PATH/board/ti/keys -K
     $UBOOT_PATH/build/a72/dts/dt.dtb
 
   For signing a secondary platform, pass the -K parameter to that DTB
 
-  .. code-block:: bash
+  .. prompt:: bash
 
     mkimage -f fitImage.its -k $UBOOT_PATH/board/ti/keys -K
     $UBOOT_PATH/build/a72/arch/arm/dts/k3-j721e-sk.dtb
@@ -473,10 +473,11 @@ then the saveenv command and can be used across various bootmodes too.
 
 **Writing to MMC/EMMC**
 
-.. code-block::
+.. prompt:: bash
+  :prompts: =>
 
-  => env export -t $loadaddr <list of variables>
-  => fatwrite mmc ${mmcdev} ${loadaddr} ${bootenvfile} ${filesize}
+  env export -t $loadaddr <list of variables>
+  fatwrite mmc ${mmcdev} ${loadaddr} ${bootenvfile} ${filesize}
 
 **Reading from MMC/EMMC**
 
@@ -486,10 +487,11 @@ mmcdev) and set the environments.
 If manually needs to be done then the environment can be read from the
 filesystem and then imported
 
-.. code-block::
+.. prompt:: bash
+  :prompts: =>
 
-  => fatload mmc ${mmcdev} ${loadaddr} ${bootenvfile}
-  => env import -t ${loadaddr} ${filesize}
+  fatload mmc ${mmcdev} ${loadaddr} ${bootenvfile}
+  env import -t ${loadaddr} ${filesize}
 
 .. _k3_rst_refer_openocd:
 
@@ -546,7 +548,7 @@ Refer to the release notes corresponding to the `OpenOCD version
   box support by OpenOCD. The board-specific documentation will
   cover the details and any adapter/dongle recommendations.
 
-.. code-block:: bash
+.. prompt:: bash
 
  openocd -v
 
@@ -564,21 +566,21 @@ systems, but equivalent instructions should exist for systems with
 other package managers. Please refer to the `OpenOCD Documentation
 <https://openocd.org/>`_ for more recent installation steps.
 
-.. code-block:: bash
+.. prompt:: bash
 
-  $ # Check the packages to be installed: needs deb-src in sources.list
-  $ sudo apt build-dep openocd
-  $ # The following list is NOT complete - please check the latest
-  $ sudo apt-get install libtool pkg-config texinfo libusb-dev \
+  # Check the packages to be installed: needs deb-src in sources.list
+  sudo apt build-dep openocd
+  # The following list is NOT complete - please check the latest
+  sudo apt-get install libtool pkg-config texinfo libusb-dev \
     libusb-1.0.0-dev libftdi-dev libhidapi-dev autoconf automake
-  $ git clone https://github.com/openocd-org/openocd.git openocd
-  $ cd openocd
-  $ git submodule init
-  $ git submodule update
-  $ ./bootstrap
-  $ ./configure --prefix=/usr/local/
-  $ make -j`nproc`
-  $ sudo make install
+  git clone https://github.com/openocd-org/openocd.git openocd
+  cd openocd
+  git submodule init
+  git submodule update
+  ./bootstrap
+  ./configure --prefix=/usr/local/
+  make -j`nproc`
+  sudo make install
 
 .. note::
 
@@ -594,28 +596,28 @@ The step is not necessary if the distribution supports the OpenOCD, but
 if building from a source, ensure that the udev rules are installed
 correctly to ensure a sane system.
 
-.. code-block:: bash
+.. prompt:: bash
 
   # Go to the OpenOCD source directory
-  $ cd openocd
-  # Copy the udev rules to the correct system location
-  $ sudo cp ./contrib/60-openocd.rules \
+  cd openocd
+  Copy the udev rules to the correct system location
+  sudo cp ./contrib/60-openocd.rules \
       ./src/jtag/drivers/libjaylink/contrib/99-libjaylink.rules \
       /etc/udev/rules.d/
   # Get Udev to load the new rules up
-  $ sudo udevadm control --reload-rules
+  sudo udevadm control --reload-rules
   # Use the new rules on existing connected devices
-  $ sudo udevadm trigger
+  sudo udevadm trigger
 
 Step 2: Setup GDB
 ^^^^^^^^^^^^^^^^^
 
 Most systems come with gdb-multiarch package.
 
-.. code-block:: bash
+.. prompt:: bash
 
   # Install gdb-multiarch package
-  $ sudo apt-get install gdb-multiarch
+  sudo apt-get install gdb-multiarch
 
 Though using GDB natively is normal, developers with interest in using IDE
 may find a few of these interesting:
@@ -828,7 +830,7 @@ Startup OpenOCD to debug the platform as follows:
 
 .. k3_rst_include_start_openocd_cfg_XDS110
 
-.. code-block:: bash
+.. prompt:: bash
 
   openocd -f board/{board_of_choice}.cfg
 
@@ -842,7 +844,7 @@ Startup OpenOCD to debug the platform as follows:
   <https://github.com/openocd-org/openocd/blob/master/tcl/target/ti_k3.cfg#L59>`_
   to decide if the SoC is supported or not.
 
-.. code-block:: bash
+.. prompt:: bash
 
   openocd -f openocd_connect.cfg
 
@@ -917,7 +919,7 @@ To debug using this server, use GDB directly or your preferred
 GDB-based IDE. To start up GDB in the terminal, run the following
 command.
 
-.. code-block:: bash
+.. prompt:: bash
 
   gdb-multiarch
 
-- 
2.40.0

