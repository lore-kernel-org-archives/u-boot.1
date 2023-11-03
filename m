Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C6EC4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 04:40:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 780868758C;
	Fri,  3 Nov 2023 05:40:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tuu+zdQd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7774786F69; Fri,  3 Nov 2023 05:40:39 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61FB6875F5
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 05:40:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A34eSHO061788;
 Thu, 2 Nov 2023 23:40:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698986428;
 bh=dbsAcYF4yFduf1cheKi/BfSd8bKpyOi/fE5xHWsvvP4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=tuu+zdQdjCtXhnkrgig2el6ogXwpkcgiB2x6CVGsbBgPvYNB3afZ8AbbaEF7hlg0E
 9jHSncojb8ZRQAlZW+KAzhvwLTUHOUsDTmwve9sTIt1biOfyIbPMwHMkmZaRS5G3EP
 bgBxVoQo5onlT+aVxZqGnJBkv7CnWkHpJkwVbI90=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A34eSbv032075
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 2 Nov 2023 23:40:28 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 2
 Nov 2023 23:40:27 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 2 Nov 2023 23:40:27 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A34eRVp107794;
 Thu, 2 Nov 2023 23:40:27 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
CC: Neha Malcom Francis <n-francis@ti.com>, Bryan Brattlof <bb@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, <u-boot@lists.denx.de>,
 Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 1/2] doc: board: ti: Use prompt prompt_style to simplify
 documentation
Date: Thu, 2 Nov 2023 23:40:25 -0500
Message-ID: <20231103044026.7743-2-nm@ti.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20231103044026.7743-1-nm@ti.com>
References: <20231103044026.7743-1-nm@ti.com>
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

The sphinx-prompt documentation[0] provides examples on how we can use
prompt as a parameter to simplify the description. Use the same.

While at it, ensure to make all relevant prompts clarified such as gdb
prompts.

[0] http://sbrunner.github.io/sphinx-prompt/

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes since V1:
Squashed up gdb prompt as well to this patch.

V1: https://lore.kernel.org/r/20231103000915.2413501-2-nm@ti.com
 doc/board/ti/am335x_evm.rst | 39 +++++++++++---------------------
 doc/board/ti/dra7xx_evm.rst |  3 +--
 doc/board/ti/k3.rst         | 44 ++++++++++++++++++-------------------
 doc/board/ti/ks2_evm.rst    | 15 +++++--------
 4 files changed, 41 insertions(+), 60 deletions(-)

diff --git a/doc/board/ti/am335x_evm.rst b/doc/board/ti/am335x_evm.rst
index 2ba651eb6df9..769362816b78 100644
--- a/doc/board/ti/am335x_evm.rst
+++ b/doc/board/ti/am335x_evm.rst
@@ -84,8 +84,7 @@ bootable image was not created.
 
 Within the SECDEV package exists an image creation script:
 
-.. prompt:: bash
-   :prompts: $
+.. prompt:: bash $
 
    ${TI_SECURE_DEV_PKG}/scripts/create-boot-image.sh
 
@@ -97,8 +96,7 @@ possible.
 The script is basically the only required interface to the TI SECDEV
 package for creating a bootable SPL image for secure TI devices.
 
-.. prompt:: bash
-   :prompts: $
+.. prompt:: bash $
 
    create-boot-image.sh \
 		<IMAGE_FLAG> <INPUT_FILE> <OUTPUT_FILE> <SPL_LOAD_ADDR>
@@ -184,8 +182,7 @@ The exact details of the how the images are secured is handled by the
 SECDEV package. Within the SECDEV package exists a script to process
 an input binary image:
 
-.. prompt:: bash
-   :prompts: $
+.. prompt:: bash $
 
    ${TI_SECURE_DEV_PKG}/scripts/secure-binary-image.sh
 
@@ -206,8 +203,7 @@ only accessible when the ARM core is operating in the secure mode).
 Invoking the secure-binary-image script for Secure Devices
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-.. prompt:: bash
-   :prompts: $
+.. prompt:: bash $
 
    secure-binary-image.sh <INPUT_FILE> <OUTPUT_FILE>
 
@@ -247,8 +243,7 @@ into memory, then written to NAND.
 
 2. Flashing NAND via MMC/SD
 
-.. prompt:: bash
-   :prompts: =>
+.. prompt:: bash =>
 
    # select BOOTSEL to MMC/SD boot and boot from MMC/SD card
    mmc rescan
@@ -334,8 +329,7 @@ had a FAT partition (such as on a Beaglebone Black) it is not enough to
 write garbage into the area, you must delete it from the partition table
 first.
 
-.. prompt:: bash
-   :prompts: =>
+.. prompt:: bash =>
 
    # Ensure we are able to talk with this mmc device
    mmc rescan
@@ -366,8 +360,7 @@ the FAT filesystem (only the uImage MUST be for this to function
 afterwards) along with a Falcon Mode aware MLO and the FAT partition has
 already been created and marked bootable:
 
-.. prompt:: bash
-   :prompts: =>
+.. prompt:: bash =>
 
    mmc rescan
    # Load kernel and device tree into memory, perform export
@@ -386,8 +379,7 @@ This will print a number of lines and then end with something like:
 
 So then you:
 
-.. prompt:: bash
-   :prompts: =>
+.. prompt:: bash =>
 
    fatwrite mmc 0:1 0x80f80000 args 8928
 
@@ -400,8 +392,7 @@ already located on the NAND somewhere (such as filesystem or mtd partition)
 along with a Falcon Mode aware MLO written to the correct locations for
 booting and mtdparts have been configured correctly for the board:
 
-.. prompt:: bash
-   :prompts: =>
+.. prompt:: bash =>
 
    nand read ${loadaddr} kernel
    load nand rootfs ${fdtaddr} /boot/am335x-evm.dtb
@@ -425,8 +416,7 @@ The output of the 'dm tree' command shows which driver is bound to which
 device, so the user can easily configure their platform differently from
 the command line:
 
-.. prompt:: bash
-   :prompts: =>
+.. prompt:: bash =>
 
    dm tree
 
@@ -444,8 +434,7 @@ the command line:
 Typically here any network command performed using the usb_ether
 interface would work, while using other gadgets would fail:
 
-.. prompt:: bash
-   :prompts: =>
+.. prompt:: bash =>
 
    fastboot usb 0
 
@@ -462,8 +451,7 @@ least from a bootloader point of view). The solution here would be to
 use the unbind command specifying the class and index parameters (as
 shown above in the 'dm tree' output) to target the driver to unbind:
 
-.. prompt:: bash
-   :prompts: =>
+.. prompt:: bash =>
 
    unbind ethernet 1
 
@@ -471,8 +459,7 @@ The output of the 'dm tree' command now shows the availability of the
 first USB device controller, the fastboot gadget will now be able to
 bind with it:
 
-.. prompt:: bash
-   :prompts: =>
+.. prompt:: bash =>
 
    dm tree
 
diff --git a/doc/board/ti/dra7xx_evm.rst b/doc/board/ti/dra7xx_evm.rst
index 4503b5e92229..8e5d95535fa0 100644
--- a/doc/board/ti/dra7xx_evm.rst
+++ b/doc/board/ti/dra7xx_evm.rst
@@ -71,8 +71,7 @@ example we load MLO and u-boot.img from the build into DDR and then use
 'mmc bootbus' to set the required rate (see TRM) and 'mmc partconfig' to
 set boot0 as the boot device.
 
-.. prompt:: bash
-   :prompts: =>
+.. prompt:: bash =>
 
    setenv autoload no
    usb start
diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index 89d70db88647..75ee23883aae 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -197,7 +197,7 @@ All of that to say you will need both a 32bit and 64bit cross compiler
 .. k3_rst_include_end_common_env_vars_desc
 
 .. k3_rst_include_start_common_env_vars_defn
-.. prompt:: bash
+.. prompt:: bash $
 
  export CC32=arm-linux-gnueabihf-
  export CC64=aarch64-linux-gnu-
@@ -247,7 +247,7 @@ Building tiboot3.bin
    uses the split binary flow)
 
 .. k3_rst_include_start_build_steps_spl_r5
-.. prompt:: bash
+.. prompt:: bash $
 
  # inside u-boot source
  make $UBOOT_CFG_CORTEXR
@@ -283,7 +283,7 @@ firmware if your device using a split firmware.
    application cores on the main domain.
 
 .. k3_rst_include_start_build_steps_tfa
-.. prompt:: bash
+.. prompt:: bash $
 
  # inside trusted-firmware-a source
  make CROSS_COMPILE=$CC64 ARCH=aarch64 PLAT=k3 SPD=opteed $TFA_EXTRA_ARGS \
@@ -299,7 +299,7 @@ use the `lite` option.
    using the TrustZone technology built into the core.
 
 .. k3_rst_include_start_build_steps_optee
-.. prompt:: bash
+.. prompt:: bash $
 
  # inside optee_os source
  make CROSS_COMPILE=$CC32 CROSS_COMPILE64=$CC64 CFG_ARM64_core=y $OPTEE_EXTRA_ARGS \
@@ -311,7 +311,7 @@ use the `lite` option.
    64bit core in the main domain.
 
 .. k3_rst_include_start_build_steps_uboot
-.. prompt:: bash
+.. prompt:: bash $
 
  # inside u-boot source
  make $UBOOT_CFG_CORTEXA
@@ -410,14 +410,14 @@ and the same can be extended to other platforms
   be passing to mkimage for signing the fitImage and embedding the key in
   the u-boot dtb.
 
-  .. prompt:: bash
+  .. prompt:: bash $
 
     mkimage -r -f fitImage.its -k $UBOOT_PATH/board/ti/keys -K
     $UBOOT_PATH/build/a72/dts/dt.dtb
 
   For signing a secondary platform, pass the -K parameter to that DTB
 
-  .. prompt:: bash
+  .. prompt:: bash $
 
     mkimage -f fitImage.its -k $UBOOT_PATH/board/ti/keys -K
     $UBOOT_PATH/build/a72/arch/arm/dts/k3-j721e-sk.dtb
@@ -476,8 +476,7 @@ then the saveenv command and can be used across various bootmodes too.
 
 **Writing to MMC/EMMC**
 
-.. prompt:: bash
-  :prompts: =>
+.. prompt:: bash =>
 
   env export -t $loadaddr <list of variables>
   fatwrite mmc ${mmcdev} ${loadaddr} ${bootenvfile} ${filesize}
@@ -490,8 +489,7 @@ mmcdev) and set the environments.
 If manually needs to be done then the environment can be read from the
 filesystem and then imported
 
-.. prompt:: bash
-  :prompts: =>
+.. prompt:: bash =>
 
   fatload mmc ${mmcdev} ${loadaddr} ${bootenvfile}
   env import -t ${loadaddr} ${filesize}
@@ -551,7 +549,7 @@ Refer to the release notes corresponding to the `OpenOCD version
   box support by OpenOCD. The board-specific documentation will
   cover the details and any adapter/dongle recommendations.
 
-.. prompt:: bash
+.. prompt:: bash $
 
  openocd -v
 
@@ -569,7 +567,7 @@ systems, but equivalent instructions should exist for systems with
 other package managers. Please refer to the `OpenOCD Documentation
 <https://openocd.org/>`_ for more recent installation steps.
 
-.. prompt:: bash
+.. prompt:: bash $
 
   # Check the packages to be installed: needs deb-src in sources.list
   sudo apt build-dep openocd
@@ -599,7 +597,7 @@ The step is not necessary if the distribution supports the OpenOCD, but
 if building from a source, ensure that the udev rules are installed
 correctly to ensure a sane system.
 
-.. prompt:: bash
+.. prompt:: bash $
 
   # Go to the OpenOCD source directory
   cd openocd
@@ -617,7 +615,7 @@ Step 2: Setup GDB
 
 Most systems come with gdb-multiarch package.
 
-.. prompt:: bash
+.. prompt:: bash $
 
   # Install gdb-multiarch package
   sudo apt-get install gdb-multiarch
@@ -833,7 +831,7 @@ Startup OpenOCD to debug the platform as follows:
 
 .. k3_rst_include_start_openocd_cfg_XDS110
 
-.. prompt:: bash
+.. prompt:: bash $
 
   openocd -f board/{board_of_choice}.cfg
 
@@ -847,7 +845,7 @@ Startup OpenOCD to debug the platform as follows:
   <https://github.com/openocd-org/openocd/blob/master/tcl/target/ti_k3.cfg#L59>`_
   to decide if the SoC is supported or not.
 
-.. prompt:: bash
+.. prompt:: bash $
 
   openocd -f openocd_connect.cfg
 
@@ -922,13 +920,13 @@ To debug using this server, use GDB directly or your preferred
 GDB-based IDE. To start up GDB in the terminal, run the following
 command.
 
-.. prompt:: bash
+.. prompt:: bash $
 
   gdb-multiarch
 
 To connect to your desired core, run the following command within GDB:
 
-.. code-block:: bash
+.. prompt:: bash (gdb)
 
   target extended-remote localhost:{port for desired core}
 
@@ -945,13 +943,13 @@ To load symbols:
 
 * Prior to relocation:
 
-.. code-block:: bash
+.. prompt:: bash (gdb)
 
   symbol-file {path to elf file}
 
 * After relocation:
 
-.. code-block:: bash
+.. prompt:: bash (gdb)
 
   # Drop old symbol file
   symbol-file
@@ -962,7 +960,7 @@ To load symbols:
 
 In the above example of AM625,
 
-.. code-block:: bash
+.. prompt:: bash (gdb)
 
   target extended-remote localhost:3338     <- R5F (Wakeup Domain)
   target extended-remote localhost:3334     <- A53 (Main Domain)
@@ -982,7 +980,7 @@ breakpoints. To exit the debug loop added above, add any breakpoints
 needed and run the following GDB commands to step out of the debug
 loop set in the ``board_init_f`` function.
 
-.. code-block:: bash
+.. prompt:: bash (gdb)
 
   set x = 0
   continue
diff --git a/doc/board/ti/ks2_evm.rst b/doc/board/ti/ks2_evm.rst
index 0a789037a6a8..c8591484b032 100644
--- a/doc/board/ti/ks2_evm.rst
+++ b/doc/board/ti/ks2_evm.rst
@@ -122,8 +122,7 @@ Don't forget to add CROSS_COMPILE.
 
 To build u-boot.bin, u-boot-spi.gph, MLO:
 
-.. prompt:: bash
-   :prompts: $
+.. prompt:: bash $
 
    make k2hk_evm_defconfig
    make
@@ -197,8 +196,7 @@ instructions:
 4. Free Run the target as described earlier (step 4) to get U-Boot prompt
 5. At the U-Boot console type following to setup U-Boot environment variables.
 
-.. prompt:: bash
-   :prompts: =>
+.. prompt:: bash =>
 
    setenv addr_uboot 0x87000000
    setenv filesize <size in hex of u-boot-spi.gph rounded to hex 0x10000>
@@ -226,8 +224,7 @@ instructions:
 4. Free Run the target as described earlier (step 4) to get U-Boot prompt
 5. At the U-Boot console type following to setup U-Boot environment variables.
 
-.. prompt:: bash
-   :prompts: =>
+.. prompt:: bash =>
 
    setenv filesize <size in hex of MLO rounded to hex 0x10000>
    run burn_uboot_nand
@@ -249,10 +246,10 @@ Open BMC and regular UART terminals.
 1. On the regular UART port start xmodem transfer of the u-boot.bin
 2. Using BMC terminal set the ARM-UART bootmode and reboot the EVM
 
-.. prompt:: bash
+.. prompt:: bash BMC>
 
-   BMC> bootmode #4
-   MBC> reboot
+  bootmode #4
+  reboot
 
 3. When xmodem is complete you should see the U-Boot starts on the UART port
 
-- 
2.37.2

