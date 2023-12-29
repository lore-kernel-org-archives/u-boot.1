Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70199C46CD3
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 10:48:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A4D487B18;
	Fri, 29 Dec 2023 11:47:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qID9mY+V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89A2887B18; Fri, 29 Dec 2023 11:47:11 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C725876B2
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 11:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BTAl3fK008516;
 Fri, 29 Dec 2023 04:47:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703846823;
 bh=8A9T2xirNrqFLcmPb8q1uA/wvzaBnMLIkBMNcHhIT+M=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=qID9mY+V5gFGPavWjLxNOz4ZSec/Sk8D8wFQ4LOmEw5r11Ae9+Hy29tj+FO30x3HD
 KqsVA07nMASml5J991iG22V/ez8apQ5/GNGAgLa3BNv09IxAW2Wpq/WZ50uHjrowv4
 SpwX7Zr9M6L/QgBv1oFyUK/vA8j29I+Zx7vfXwtQ=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BTAl3sY019614
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Dec 2023 04:47:03 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Dec 2023 04:47:03 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Dec 2023 04:47:03 -0600
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.69.44])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BTAkT7m072641;
 Fri, 29 Dec 2023 04:46:59 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Fri, 29 Dec 2023 16:16:32 +0530
Subject: [PATCH v7 8/9] docs: board: ti: k3: Cleanup FIT signature
 documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231229-binman-firewalling-v7-8-47ed4af303fe@ti.com>
References: <20231229-binman-firewalling-v7-0-47ed4af303fe@ti.com>
In-Reply-To: <20231229-binman-firewalling-v7-0-47ed4af303fe@ti.com>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew
 Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri
 <praneeth@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon
 <nm@ti.com>, Thomas Richard <thomas.richard@bootlin.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703846789; l=13414;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=GJgF1LXa5D/TDJwkojuh/rddiDF5gLRl8/6OYpLDor4=;
 b=BCkXf//W5kfeXGlWQWssyRn1vcTohLt7cBpsNsYRQotKLRx8UZr0jDjZ3tbQM7bFb1X0S3MH7
 2GvgC16cTddDm1laB+EUoOqzZTZAudSSscF2tJNKcJSlVJtdMLxMupL
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
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

The previous documentation had been very crude so refactor it to make it
cleaner and concise.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 doc/board/ti/k3.rst | 270 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 171 insertions(+), 99 deletions(-)

diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index f19ee56f296e..1064c21b5a1d 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -248,6 +248,8 @@ Building tiboot3.bin
    the final `tiboot3.bin` binary. (or the `sysfw.itb` if your device
    uses the split binary flow)
 
+.. _k3_rst_include_start_build_steps_spl_r5:
+
 .. k3_rst_include_start_build_steps_spl_r5
 .. prompt:: bash $
 
@@ -312,6 +314,8 @@ use the `lite` option.
    finished, we can jump back into U-Boot again, this time running on a
    64bit core in the main domain.
 
+.. _k3_rst_include_start_build_steps_uboot:
+
 .. k3_rst_include_start_build_steps_uboot
 .. prompt:: bash $
 
@@ -337,144 +341,212 @@ wakeup and main domain and to boot to the U-Boot prompt
    | `tispl.bin` for HS devices or `tispl.bin_unsigned` for GP devices
    | `u-boot.img` for HS devices or `u-boot.img_unsigned` for GP devices
 
-Fit Signature Signing
+FIT signature signing
 ---------------------
 
-K3 Platforms have fit signature signing enabled by default on their primary
-platforms. Here we'll take an example for creating fit image for J721e platform
+K3 platforms have FIT signature signing enabled by default on their primary
+platforms. Here we'll take an example for creating FIT Image for J721E platform
 and the same can be extended to other platforms
 
-1. Describing FIT source
+Pre-requisites:
+
+* U-boot build (:ref:`U-boot build <k3_rst_include_start_build_steps_spl_r5>`)
+* Linux Image and Linux DTB prebuilt
+
+Describing FIT source
+^^^^^^^^^^^^^^^^^^^^^
 
-  .. code-block:: bash
+FIT Image is a packed structure containing binary blobs and configurations.
+The Kernel FIT Image that we have has Kernel Image, DTB and the DTBOs.  It
+supports packing multiple images and configurations that allow you to
+choose any configuration at runtime to boot from.
+
+.. code-block::
 
     /dts-v1/;
 
     / {
-            description = "Kernel fitImage for j721e-hs-evm";
-            #address-cells = <1>;
-
-            images {
-                    kernel-1 {
-                            description = "Linux kernel";
-                            data = /incbin/("Image");
-                            type = "kernel";
-                            arch = "arm64";
-                            os = "linux";
-                            compression = "none";
-                            load = <0x80080000>;
-                            entry = <0x80080000>;
-                            hash-1 {
-                                    algo = "sha512";
-                            };
-
-                    };
-                    fdt-ti_k3-j721e-common-proc-board.dtb {
-                            description = "Flattened Device Tree blob";
-                            data = /incbin/("k3-j721e-common-proc-board.dtb");
-                            type = "flat_dt";
-                            arch = "arm64";
-                            compression = "none";
-                            load = <0x83000000>;
-                            hash-1 {
-                                    algo = "sha512";
-                            };
-
-                    };
+        description = "FIT Image description";
+        #address-cells = <1>;
+
+        images {
+            [image-1]
+            [image-2]
+            [fdt-1]
+            [fdt-2]
+        }
+
+        configurations {
+            default = <conf-1>
+            [conf-1: image-1,fdt-1]
+            [conf-2: image-2,fdt-1]
+        }
+    }
+
+* Sample Images
+
+.. code-block::
+
+    kernel-1 {
+            description = "Linux kernel";
+            data = /incbin/("linux.bin");
+            type = "kernel";
+            arch = "arm64";
+            os = "linux";
+            compression = "gzip";
+            load = <0x81000000>;
+            entry = <0x81000000>;
+            hash-1 {
+                    algo = "sha512";
             };
-
-            configurations {
-                    default = "conf-ti_k3-j721e-common-proc-board.dtb";
-                    conf-ti_k3-j721e-common-proc-board.dtb {
-                            description = "Linux kernel, FDT blob";
-                            fdt = "fdt-ti_k3-j721e-common-proc-board.dtb";
-                            kernel = "kernel-1";
-                            signature-1 {
-                                    algo = "sha512,rsa4096";
-                                    key-name-hint = "custMpk";
-                                    sign-images = "kernel", "fdt";
-                            };
-                    };
+    };
+    fdt-ti_k3-j721e-common-proc-board.dtb {
+            description = "Flattened Device Tree blob";
+            data = /incbin/("arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dtb");
+            type = "flat_dt";
+            arch = "arm64";
+            compression = "none";
+            load = <0x83000000>;
+            hash-1 {
+                    algo = "sha512";
             };
     };
+    # Optional images
+    fdt-ti_k3-j721e-evm-virt-mac-client.dtbo {
+            description = "Flattened Device Tree blob";
+            data = /incbin/("arch/arm64/boot/dts/ti/k3-j721e-evm-virt-mac-client.dtbo");
+            type = "flat_dt";
+            arch = "arm64";
+            compression = "none";
+            load = <0x83080000>;
+            hash-1 {
+                    algo = "sha512";
+            };
+    };
+
+.. note::
+
+    Change the path in data variables to point to the respective files in your
+    local machine. For e.g change "linux.bin" to "<path-to-kernel-image>".
 
-  You would require to change the '/incbin/' lines to point to the respective
-  files in your local machine and the key-name-hint also needs to be changed
-  if you are using some other key other than the TI dummy key that we are
-  using for this example.
+For enabling usage of FIT signature, add the signature node to the
+corresponding configuration node as follows.
 
-2. Compile U-boot for the respective board
+* Sample Configurations
 
-.. include::  k3.rst
-    :start-after: .. k3_rst_include_start_build_steps_uboot
-    :end-before: .. k3_rst_include_end_build_steps_uboot
+.. code-block::
+
+    conf-ti_k3-j721e-common-proc-board.dtb {
+            description = "Linux kernel, FDT blob";
+            fdt = "fdt-ti_k3-j721e-common-proc-board.dtb";
+            kernel = "kernel-1";
+            signature-1 {
+                    algo = "sha512,rsa4096";
+                    key-name-hint = "custMpk";
+                    sign-images = "kernel", "fdt";
+            };
+    };
+    # Optional configurations
+    conf-ti_k3-j721e-evm-virt-mac-client.dtbo {
+            description = "FDTO blob";
+            fdt = "fdt-ti_k3-j721e-evm-virt-mac-client.dtbo";
+
+            signature-1 {
+                    algo = "sha512,rsa4096";
+                    key-name-hint = "custMpk";
+                    sign-images = "fdt";
+            };
+    };
+
+Specify all images you need the signature to authenticate as a part of
+sign-images. The key-name-hint needs to be changed if you are using some
+other key other than the TI dummy key that we are using for this example.
+It should be the name of the file containing the keys.
 
 .. note::
 
-    The changes only affect a72 binaries so the example just builds that
+    Generating new set of keys:
+
+    .. prompt:: bash $
 
-3. Sign the fit image and embed the dtb in uboot
+        mkdir keys
+        openssl genpkey -algorithm RSA -out keys/dev.key \
+        -pkeyopt rsa_keygen_bits:4096 -pkeyopt rsa_keygen_pubexp:65537
+        openssl req -batch -new -x509 -key keys/dev.key -out keys/dev.crt
 
-  Now once the build is done, you'll have a dtb for your board that you'll
-  be passing to mkimage for signing the fitImage and embedding the key in
-  the u-boot dtb.
+Generating the fitImage
+^^^^^^^^^^^^^^^^^^^^^^^
 
-  .. prompt:: bash $
+.. note::
+
+    For signing a secondary platform like SK boards, you'll require
+    additional steps
+
+    - Change the CONFIG_DEFAULT_DEVICE_TREE
 
-    mkimage -r -f fitImage.its -k $UBOOT_PATH/board/ti/keys -K
-    $UBOOT_PATH/build/a72/dts/dt.dtb
+        For e.g
 
-  For signing a secondary platform, pass the -K parameter to that DTB
+        .. code-block::
 
-  .. prompt:: bash $
+            diff --git a/configs/j721e_evm_a72_defconfig b/configs/j721e_evm_a72_defconfig
+            index a5c1df7e0054..6d0126d955ef 100644
+            --- a/configs/j721e_evm_a72_defconfig
+            +++ b/configs/j721e_evm_a72_defconfig
+            @@ -13,7 +13,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80480000
+             CONFIG_ENV_SIZE=0x20000
+             CONFIG_DM_GPIO=y
+             CONFIG_SPL_DM_SPI=y
+            -CONFIG_DEFAULT_DEVICE_TREE="k3-j721e-common-proc-board"
+            +CONFIG_DEFAULT_DEVICE_TREE="k3-j721e-sk"
+             CONFIG_SPL_TEXT_BASE=0x80080000
+             CONFIG_DM_RESET=y
+             CONFIG_SPL_MMC=y
 
-    mkimage -f fitImage.its -k $UBOOT_PATH/board/ti/keys -K
-    $UBOOT_PATH/build/a72/arch/arm/dts/k3-j721e-sk.dtb
+    - Change the binman nodes to package u-boot.dtb for the correct set of platform
 
-  .. note::
+        For e.g
 
-    If changing `CONFIG_DEFAULT_DEVICE_TREE` to the secondary platform,
-    binman changes would also be required so that correct dtb gets packaged.
+        .. code-block::
 
-    .. code-block:: bash
+            diff --git a/arch/arm/dts/k3-j721e-binman.dtsi b/arch/arm/dts/k3-j721e-binman.dtsi
+                  index 673be646b1e3..752fa805fe8d 100644
+                  --- a/arch/arm/dts/k3-j721e-binman.dtsi
+                  +++ b/arch/arm/dts/k3-j721e-binman.dtsi
+                  @@ -299,8 +299,8 @@
+                   #define SPL_J721E_SK_DTB "spl/dts/k3-j721e-sk.dtb"
 
-      diff --git a/arch/arm/dts/k3-j721e-binman.dtsi b/arch/arm/dts/k3-j721e-binman.dtsi
-      index 673be646b1e3..752fa805fe8d 100644
-      --- a/arch/arm/dts/k3-j721e-binman.dtsi
-      +++ b/arch/arm/dts/k3-j721e-binman.dtsi
-      @@ -299,8 +299,8 @@
-       #define SPL_J721E_SK_DTB "spl/dts/k3-j721e-sk.dtb"
+                   #define UBOOT_NODTB "u-boot-nodtb.bin"
+                  -#define J721E_EVM_DTB "u-boot.dtb"
+                  -#define J721E_SK_DTB "arch/arm/dts/k3-j721e-sk.dtb"
+                  +#define J721E_EVM_DTB "arch/arm/dts/k3-j721e-common-proc-board.dtb"
+                  +#define J721E_SK_DTB "u-boot.dtb"
 
-       #define UBOOT_NODTB "u-boot-nodtb.bin"
-      -#define J721E_EVM_DTB "u-boot.dtb"
-      -#define J721E_SK_DTB "arch/arm/dts/k3-j721e-sk.dtb"
-      +#define J721E_EVM_DTB "arch/arm/dts/k3-j721e-common-proc-board.dtb"
-      +#define J721E_SK_DTB "u-boot.dtb"
+This step will embed the public key in the u-boot.dtb file that was already
+built during the initial u-boot build.
 
-5. Rebuilt u-boot
+.. prompt:: bash $
 
-   This is required so that the modified dtb gets updated in u-boot.img
+    mkimage -r -f fitImage.its -k $UBOOT_PATH/board/ti/keys -K $UBOOT_PATH/build/$ARMV8/dts/dt.dtb fitImage
 
-.. include::  k3.rst
-    :start-after: .. k3_rst_include_start_build_steps_uboot
-    :end-before: .. k3_rst_include_end_build_steps_uboot
+.. note::
 
-6. (Optional) Enabled FIT_SIGNATURE_ENFORCED
+    If you have another set of keys then change the -k argument to point to
+    the folder where your keys are present, the build requires the presence
+    of both .key and .crt file.
 
-   By default u-boot will boot up the fit image without any authentication as
-   such if the public key is not embedded properly, to check if the public key
-   nodes are proper you can enable FIT_SIGNATURE_ENFORCED that would not rely
-   on the dtb for anything else then the signature node for checking the fit
-   image, rest other things will be enforced such as the property of
-   required-keys. This is not an extensive check so do manual checks also
+Build u-boot again
+^^^^^^^^^^^^^^^^^^
 
-   This is by default enabled for devices with TI_SECURE_DEVICE enabled.
+The updated u-boot.dtb needs to be packed in u-boot.img for authentication
+so rebuild U-boot ARMV8 without changing any parameters.
+Refer (:ref:`U-boot ARMV8 build <k3_rst_include_start_build_steps_uboot>`)
 
 .. note::
 
-   The devices now also have distroboot enabled so if the fit image doesn't
-   work then the fallback to normal distroboot will be there on hs devices,
-   this will need to be explicitly disabled by changing the boot_targets.
+   The devices now also have distroboot enabled so if the FIT image doesn't
+   work then the fallback to normal distroboot will be there on HS devices.
+   This will need to be explicitly disabled by changing the boot_targets to
+   disallow fallback during testing.
 
 Saving environment
 ------------------

-- 
2.43.0

