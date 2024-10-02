Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA296CEACF3
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 18:09:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14D2288DDD;
	Wed,  2 Oct 2024 20:09:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LTe0Xw9f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F02E88E0A; Wed,  2 Oct 2024 20:09:00 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F96888DCD
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 20:08:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42cbc22e1c4so157565e9.2
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 11:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727892537; x=1728497337; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=q63C564SRzE6DFULhaRgxM/a1xYYbx9JjIvcAKdOBgc=;
 b=LTe0Xw9fYxigZdLmRvGI54K0Tb5dhT21mJNe2Es7OdamBI6HkjKWMGtU7qQtktlzHZ
 bRL01xWg6smWQxqPjUx2TZdp91XfKB5ZoblAINCfMTTXSyCdrvrIBGkRlRmO3mBQ+qbG
 eIUyPsHe3pQdzDGXV7EzI5UVf292f1eZjQMnfj5fmdwneYYSVyiw43wx8+geQO+gVyH9
 j4itPPdzIXZymj8KNm72ehFihatQ/CUj6Jv2wDVWDiS+i2dEjlGeGurLY8UdWbHGffnr
 WfBze4WSbPYrYNC1TihcVUWHnibdqVcnSVdOiMmw5Ei4EBTdqp7qgeZDJePsPo/gUIBO
 CciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727892537; x=1728497337;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q63C564SRzE6DFULhaRgxM/a1xYYbx9JjIvcAKdOBgc=;
 b=j7WONocXggoaSaQcWr0JtJDtuQgoxb5kH12EgUMCMmB2linZ6V1r2yPsTC5xb+s8DO
 SXDuv+jHpySAYJlQC7xZRMDeTaOzPRbsCLLwZNaBgGmXrHvV7MFphtTThDCG2xx8cbG6
 IkpmrNQZOSpfkrel7rudWbGwBQn4blrvJF7x66efAu0rsGYeKMXZC7YTBqxOGvKnYiIX
 JqfowTyFGqSgjf3jeUZQOd4Uv1Ta4GzG5B+ygg6RIybDtuK8JjpOTmURgncNNhwomuk8
 yNPQ8CiVozkdNBNtY52Loy+VTULDAM2j/TKbnDMlz0JaT3NzqqHVrDJSH2rdeY5gqV+c
 G8hA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJcgPRtu4ObJTpbJEtG7XGRhjOxKmBqE23/IQH7n9RZDiA9ybPGJqrenLPnEgSDRkCf7AXG94=@lists.denx.de
X-Gm-Message-State: AOJu0Yy8upDig3eLIORt7rbiRYa0m23xT1jDwFHRUrIVsSUDqiWdtny1
 g+UVNTNzzNY0+Mxn23cskqx0LV7ZSHEPZ0Xho64vlgzs4LkTknnu
X-Google-Smtp-Source: AGHT+IFXZslZpDNEc2yOz7nUynawg9n3lNTI5QMGKaT4JJ+AQo2tuAmJnbd9wfPiIc00Z9IcgvezSg==
X-Received: by 2002:a05:600c:a02:b0:42c:a8f8:1d58 with SMTP id
 5b1f17b1804b1-42f777b5c6amr27392745e9.7.1727892537142; 
 Wed, 02 Oct 2024 11:08:57 -0700 (PDT)
Received: from cypher.home.roving-it.com
 (e.b.8.0.0.0.0.0.0.0.0.0.0.0.0.0.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:fb11:2681::8be]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e6857sm14538160f8f.51.2024.10.02.11.08.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 11:08:56 -0700 (PDT)
From: Peter Robinson <pbrobinson@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] Update the ARM trusted firmware git URL
Date: Wed,  2 Oct 2024 19:08:49 +0100
Message-ID: <20241002180853.227389-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The primary upstream URL for tf-a has moved, in some cases
things like tags are not always pushed to the old URL so
update the URLs to the primary upstream project URL.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 board/rockchip/evb_rk3399/README       | 2 +-
 board/sunxi/README.sunxi64             | 2 +-
 common/spl/Kconfig                     | 2 +-
 doc/README.rockchip                    | 2 +-
 doc/README.uniphier                    | 2 +-
 doc/board/armltd/juno.rst              | 2 +-
 doc/board/bsh/imx8mn_bsh_smm_s2.rst    | 2 +-
 doc/board/hisilicon/hikey.rst          | 4 ++--
 doc/board/hisilicon/hikey960.rst       | 4 ++--
 doc/board/kontron/pitx-imx8m.rst       | 2 +-
 doc/board/rockchip/rockchip.rst        | 2 +-
 doc/board/variscite/imx8mn_var_som.rst | 2 +-
 include/atf_common.h                   | 2 +-
 tools/binman/entries.rst               | 2 +-
 tools/binman/etype/atf_bl31.py         | 2 +-
 tools/binman/fip_util.py               | 4 ++--
 16 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/board/rockchip/evb_rk3399/README b/board/rockchip/evb_rk3399/README
index c6f58203ebe..c7caf1756d6 100644
--- a/board/rockchip/evb_rk3399/README
+++ b/board/rockchip/evb_rk3399/README
@@ -31,7 +31,7 @@ Get the Source and prebuild binary
 
   > mkdir ~/evb_rk3399
   > cd ~/evb_rk3399
-  > git clone https://github.com/ARM-software/arm-trusted-firmware.git
+  > git clone https://github.com/TrustedFirmware-A/trusted-firmware-a.git
   > git clone https://github.com/rockchip-linux/rkbin.git
   > git clone https://github.com/rockchip-linux/rkdeveloptool.git
 
diff --git a/board/sunxi/README.sunxi64 b/board/sunxi/README.sunxi64
index 4803bc9ff2f..1e4fec62b27 100644
--- a/board/sunxi/README.sunxi64
+++ b/board/sunxi/README.sunxi64
@@ -211,6 +211,6 @@ Then write this image to a microSD card, replacing /dev/sdx with the right
 device file (see above):
 $ dd if=firmware.img of=/dev/sdx bs=8k seek=1
 
-[1] https://github.com/ARM-software/arm-trusted-firmware.git
+[1] https://github.com/TrustedFirmware-A/trusted-firmware-a.git
 [2] git://github.com/linux-sunxi/sunxi-tools.git
 [3] https://github.com/apritzel/pine64/
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index c08ff064493..16b0241f770 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1432,7 +1432,7 @@ config SPL_ATF
 	help
 	  ATF(ARM Trusted Firmware) is a component for ARM AArch64 which
 	  is loaded by SPL (which is considered as BL2 in ATF terminology).
-	  More detail at: https://github.com/ARM-software/arm-trusted-firmware
+	  More detail at: https://github.com/TrustedFirmware-A/trusted-firmware-a
 
 config SPL_ATF_LOAD_IMAGE_V2
 	bool "Use the new LOAD_IMAGE_V2 parameter passing"
diff --git a/doc/README.rockchip b/doc/README.rockchip
index 84caff8a24d..5fcbbd1d990 100644
--- a/doc/README.rockchip
+++ b/doc/README.rockchip
@@ -73,7 +73,7 @@ Building
 
    - Compile ATF
 
-     => git clone https://github.com/ARM-software/arm-trusted-firmware.git
+     => git clone https://github.com/TrustedFirmware-A/trusted-firmware-a.git
      => cd arm-trusted-firmware
 
      (export cross compiler path for Cortex-M0 MCU likely arm-none-eabi-)
diff --git a/doc/README.uniphier b/doc/README.uniphier
index af746f6c316..9f72cfa67b5 100644
--- a/doc/README.uniphier
+++ b/doc/README.uniphier
@@ -104,7 +104,7 @@ U-Boot serves as a non-secure boot loader loaded by [ARM Trusted Firmware],
 so you need to provide the `u-boot.bin` to the build command of ARM Trusted
 Firmware.
 
-[ARM Trusted Firmware]: https://github.com/ARM-software/arm-trusted-firmware
+[ARM Trusted Firmware]: https://github.com/TrustedFirmware-A/trusted-firmware-a
 
 
 Verified Boot
diff --git a/doc/board/armltd/juno.rst b/doc/board/armltd/juno.rst
index 761c037f92b..478f826f08a 100644
--- a/doc/board/armltd/juno.rst
+++ b/doc/board/armltd/juno.rst
@@ -110,5 +110,5 @@ to the ``SOFTWARE/`` directory of the SD card.
 
 .. _`Juno development board`: https://developer.arm.com/tools-and-software/development-boards/juno-development-board
 .. _`V2M-Juno TRM`: https://developer.arm.com/documentation/100113/latest
-.. _`fiptool`: https://github.com/ARM-software/arm-trusted-firmware/tree/master/tools/fiptool
+.. _`fiptool`: https://github.com/TrustedFirmware-A/trusted-firmware-a/tree/master/tools/fiptool
 .. _`SCP firmware`: https://github.com/ARM-software/SCP-firmware.git
diff --git a/doc/board/bsh/imx8mn_bsh_smm_s2.rst b/doc/board/bsh/imx8mn_bsh_smm_s2.rst
index 2e85c1a2181..1db1c8299c7 100644
--- a/doc/board/bsh/imx8mn_bsh_smm_s2.rst
+++ b/doc/board/bsh/imx8mn_bsh_smm_s2.rst
@@ -17,7 +17,7 @@ Get and Build the ARM Trusted firmware
 --------------------------------------
 
 Note: srctree is U-Boot source directory
-Get ATF from: https://github.com/ARM-software/arm-trusted-firmware
+Get ATF from: https://github.com/TrustedFirmware-A/trusted-firmware-a
 tag: v2.5
 
 .. code-block:: bash
diff --git a/doc/board/hisilicon/hikey.rst b/doc/board/hisilicon/hikey.rst
index 8038a24fe16..19b69707d32 100644
--- a/doc/board/hisilicon/hikey.rst
+++ b/doc/board/hisilicon/hikey.rst
@@ -41,7 +41,7 @@ First get all the sources
   mkdir -p ~/hikey/src ~/hikey/bin
   cd ~/hikey/src
   git clone https://github.com/96boards-hikey/edk2 -b testing/hikey960_v2.5
-  git clone https://github.com/ARM-software/arm-trusted-firmware
+  git clone https://github.com/TrustedFirmware-A/trusted-firmware-a
   git clone https://github.com/96boards-hikey/l-loader -b testing/hikey960_v1.2
   git clone https://github.com/96boards-hikey/OpenPlatformPkg -b testing/hikey960_v1.3.4
   git clone https://github.com/96boards-hikey/atf-fastboot
@@ -114,7 +114,7 @@ Copy the resulting binaries
   cp recovery.bin ~/hikey/bin
 
 These instructions are adapted from
-https://github.com/ARM-software/arm-trusted-firmware/blob/master/docs/plat/hikey.rst
+https://github.com/TrustedFirmware-A/trusted-firmware-a/blob/master/docs/plat/hikey.rst
 
 Flashing
 ========
diff --git a/doc/board/hisilicon/hikey960.rst b/doc/board/hisilicon/hikey960.rst
index 93e983b99f1..f726fc75039 100644
--- a/doc/board/hisilicon/hikey960.rst
+++ b/doc/board/hisilicon/hikey960.rst
@@ -32,7 +32,7 @@ First get all the sources
 
   mkdir -p ~/hikey960/src ~/hikey960/bin
   cd ~/hikey960/src
-  git clone https://github.com/ARM-software/arm-trusted-firmware
+  git clone https://github.com/TrustedFirmware-A/trusted-firmware-a
   git clone https://github.com/96boards-hikey/OpenPlatformPkg -b testing/hikey960_v1.3.4
   git clone https://github.com/96boards-hikey/l-loader -b testing/hikey960_v1.2
   wget http://snapshots.linaro.org/reference-platform/components/uefi-staging/123/hikey960/release/config
@@ -95,7 +95,7 @@ Copy the resulting binaries
   cp l-loader.bin ~/hikey960/bin
 
 These instructions are adapted from
-https://github.com/ARM-software/arm-trusted-firmware/blob/master/docs/plat/hikey960.rst
+https://github.com/TrustedFirmware-A/trusted-firmware-a/blob/master/docs/plat/hikey960.rst
 
 Setup console
 =============
diff --git a/doc/board/kontron/pitx-imx8m.rst b/doc/board/kontron/pitx-imx8m.rst
index 1f64cbd9b2e..1cde5bd3bb1 100644
--- a/doc/board/kontron/pitx-imx8m.rst
+++ b/doc/board/kontron/pitx-imx8m.rst
@@ -25,7 +25,7 @@ Note: builddir is U-Boot build directory (source directory for in-tree builds)
 
 .. code-block:: bash
 
-    $ git clone https://github.com/ARM-software/arm-trusted-firmware.git
+    $ git clone https://github.com/TrustedFirmware-A/trusted-firmware-a.git
     $ git checkout v2.5
     $ make PLAT=imx8mq ARCH=aarch64 CROSS_COMPILE=aarch64-linux-gnu- bl31
     $ cp build/imx8mq/release/bl31.bin $(builddir)
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 0f9cb404d93..a275e964c63 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -166,7 +166,7 @@ To build TF-A:
 
 .. code-block:: bash
 
-        git clone --depth 1 https://github.com/ARM-software/arm-trusted-firmware.git
+        git clone --depth 1 https://github.com/TrustedFirmware-A/trusted-firmware-a.git
         cd arm-trusted-firmware
         make realclean
         make CROSS_COMPILE=aarch64-linux-gnu- PLAT=rk3399
diff --git a/doc/board/variscite/imx8mn_var_som.rst b/doc/board/variscite/imx8mn_var_som.rst
index aca881ea314..1b656f0be5f 100644
--- a/doc/board/variscite/imx8mn_var_som.rst
+++ b/doc/board/variscite/imx8mn_var_som.rst
@@ -17,7 +17,7 @@ Get and Build the ARM Trusted firmware
 --------------------------------------
 
 Note: srctree is U-Boot source directory
-Get ATF from: https://github.com/ARM-software/arm-trusted-firmware
+Get ATF from: https://github.com/TrustedFirmware-A/trusted-firmware-a
 tag: v2.5
 
 .. code-block:: bash
diff --git a/include/atf_common.h b/include/atf_common.h
index 5ae45090252..03cfcc69cd7 100644
--- a/include/atf_common.h
+++ b/include/atf_common.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause */
 /*
  * This is from the ARM TF Project,
- * Repository: https://github.com/ARM-software/arm-trusted-firmware.git
+ * Repository: https://github.com/TrustedFirmware-A/trusted-firmware-a.git
  * File: include/common/bl_common.h
  * Portions copyright (c) 2013-2016, ARM Limited and Contributors. All rights
  * reserved.
diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index d82f7b89203..a8c0881aa11 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -64,7 +64,7 @@ Properties / Entry arguments:
 
 This entry holds the run-time firmware, typically started by U-Boot SPL.
 See the U-Boot README for your architecture or board for how to use it. See
-https://github.com/ARM-software/arm-trusted-firmware for more information
+https://github.com/TrustedFirmware-A/trusted-firmware-a for more information
 about ATF.
 
 
diff --git a/tools/binman/etype/atf_bl31.py b/tools/binman/etype/atf_bl31.py
index 2041da416c9..a137f8e0b39 100644
--- a/tools/binman/etype/atf_bl31.py
+++ b/tools/binman/etype/atf_bl31.py
@@ -16,7 +16,7 @@ class Entry_atf_bl31(Entry_blob_named_by_arg):
 
     This entry holds the run-time firmware, typically started by U-Boot SPL.
     See the U-Boot README for your architecture or board for how to use it. See
-    https://github.com/ARM-software/arm-trusted-firmware for more information
+    https://github.com/TrustedFirmware-A/trusted-firmware-a for more information
     about ATF.
     """
     def __init__(self, section, etype, node):
diff --git a/tools/binman/fip_util.py b/tools/binman/fip_util.py
index b5caab2d37a..aca21a42d3a 100755
--- a/tools/binman/fip_util.py
+++ b/tools/binman/fip_util.py
@@ -17,7 +17,7 @@ If ATF updates, run this program to update the FIT_TYPE_LIST.
 
 ARM Trusted Firmware is available at:
 
-https://github.com/ARM-software/arm-trusted-firmware.git
+https://github.com/TrustedFirmware-A/trusted-firmware-a.git
 """
 
 from argparse import ArgumentParser
@@ -560,7 +560,7 @@ def parse_atf_source(srcdir, dstfile, oldfile):
 
     Args:
         srcdir (str): Path to 'arm-trusted-firmware' directory. Get this from:
-            https://github.com/ARM-software/arm-trusted-firmware.git
+            https://github.com/TrustedFirmware-A/trusted-firmware-a.git
         dstfile (str): File to write new code to, if an update is needed
         oldfile (str): Python source file to compare against
 
-- 
2.46.2

