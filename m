Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E17CFA763
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 10:41:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4882C88AC2;
	Fri,  4 Oct 2024 12:41:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R37NrESE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 508F988B0B; Fri,  4 Oct 2024 12:41:06 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5F4388A4C
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 12:41:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42e748f78d6so17936695e9.0
 for <u-boot@lists.denx.de>; Fri, 04 Oct 2024 03:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728038458; x=1728643258; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3nrf7Z5/skP898yFpwpDjfNsIGt2ZnHRbnx9gseDpG8=;
 b=R37NrESEmHKK3pnMllXDCNimNV+kNj3a9aO6RHhxxXOZuRjgBmiqGj3Lka95PTrq2k
 D5yMVVs+o2poLFhp1TcKEEVEVBBaoHDut1zzXOpdymMSuQOHzyfwtRfFIUGj7hKAOF+g
 5ZkMPZVjtR1x9s3Q9q8oDvSeVz/T241pGbk9WC9H5ckRd/8bn+r5EIiAzGTyDqBHOR9u
 f4JXILQweRQmMMSMJg8wldeRZQPbKzvrTQTx6SIYBF8e+DkpvnZ2Q4kOe2TjfPzdK8CU
 7N3xDQp7PPQTMVADoIxSHPITWY9hMsYswQs4jo/8Nirzr9EQ1NWWWCQrKa57JRzqmSb6
 PiKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728038458; x=1728643258;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3nrf7Z5/skP898yFpwpDjfNsIGt2ZnHRbnx9gseDpG8=;
 b=Ncix+ftOSbx1cDCXY39a6a4XbZpchyV0U2lIoFojYaYlH3Br2v23v2v/FwAjpfLi+z
 9MNxZBjoT/TZn45D6f83nGn7TRXhw85ITlZiKeI9y7WHy8phcoPe1tnUlSVmmWancT71
 b86/TJAYY+QLVv15mMhQ3RV8bz4r0dFfzaLjWg/6fQ6GmkVnZGMqUQo6gp+dMEBGnvFp
 S8+t7JqyibZS7aUcCqLo4e8KY1fN1gkSHCH4TOUoECqC1oLCSsTY393u66iZKLQEGIqJ
 +BZw2MlSptFq4er/urC1AJryErwET51/voPKZdIyjMt9pIwh9+Y7nnDQMYzgBZRredpU
 r/nA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBLDBeTPycZqyQ/IKj/8IAnjGKvh9GkCtOBewljlnhltlv/jf47LGPCh9plI2Vm5E3tm+n28Y=@lists.denx.de
X-Gm-Message-State: AOJu0YzfuUvQEm2Wwr1ahxfvkMxOG1pf4ph9jUKhKsCJz4Wlk8AqrBQd
 Fhbp3fifLxXnUYqFBkslO47dORXtCXrvYf7EDalRhNomMWAjOKi9
X-Google-Smtp-Source: AGHT+IEfF2X87/EylSclDjKncI7Y3aL4oGwX7+x8llEwfOs6JHcJD5hYmvsZ85bJg6RuGIlSenNMLg==
X-Received: by 2002:a05:600c:3c90:b0:426:5e91:3920 with SMTP id
 5b1f17b1804b1-42f85af49a0mr15772475e9.29.1728038457946; 
 Fri, 04 Oct 2024 03:40:57 -0700 (PDT)
Received: from cypher.home.roving-it.com
 (e.b.8.0.0.0.0.0.0.0.0.0.0.0.0.0.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:fb11:2681::8be]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-42f86b43f72sm12462505e9.32.2024.10.04.03.40.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 03:40:57 -0700 (PDT)
From: Peter Robinson <pbrobinson@gmail.com>
To: Diederik de Haas <didi.debian@cknow.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] Update directories for new name of TF-A directories
Date: Fri,  4 Oct 2024 11:40:44 +0100
Message-ID: <20241004104055.438529-1-pbrobinson@gmail.com>
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

The TF-A URL was updated, as a result the name of the
directory changed as part of the new git URL and not
all the referenced directories were updated.

Fixes: 0ec0207fe07 ("Update the ARM trusted firmware git URL")
Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 board/rockchip/evb_rk3399/README |  4 ++--
 board/sunxi/README.sunxi64       |  4 ++--
 doc/README.rockchip              |  4 ++--
 doc/board/hisilicon/hikey.rst    |  6 +++---
 doc/board/hisilicon/hikey960.rst |  8 ++++----
 doc/board/kontron/pitx-imx8m.rst |  1 +
 doc/board/rockchip/rockchip.rst  | 12 ++++++------
 tools/binman/entries.rst         |  2 +-
 tools/binman/fip_util.py         | 12 ++++++------
 9 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/board/rockchip/evb_rk3399/README b/board/rockchip/evb_rk3399/README
index c7caf1756d6..de9509e8439 100644
--- a/board/rockchip/evb_rk3399/README
+++ b/board/rockchip/evb_rk3399/README
@@ -39,7 +39,7 @@ Get the Source and prebuild binary
 Compile ATF
 ===========
 
-  > cd arm-trusted-firmware
+  > cd trusted-firmware-a
   > make realclean
   > make CROSS_COMPILE=aarch64-linux-gnu- PLAT=rk3399 bl31
 
@@ -91,7 +91,7 @@ Package the image for U-Boot SPL(option 1)
 Package the image for Rockchip miniloader(option 2)
 ------------------------------------------
   > cd ..
-  > cp arm-trusted-firmware/build/rk3399/release/bl31.elf rkbin/rk33
+  > cp trusted-firmware-a/build/rk3399/release/bl31.elf rkbin/rk33
   > ./rkbin/tools/trust_merger rkbin/tools/RK3399TRUST.ini
   > ./rkbin/tools/loaderimage --pack --uboot u-boot/u-boot-dtb.bin uboot.img
 
diff --git a/board/sunxi/README.sunxi64 b/board/sunxi/README.sunxi64
index 1e4fec62b27..125a2e88e09 100644
--- a/board/sunxi/README.sunxi64
+++ b/board/sunxi/README.sunxi64
@@ -12,7 +12,7 @@ file describes how to make full use of the 64-bit capabilities.
 Quick Start / Overview
 ======================
 - Build the ARM Trusted Firmware binary (see "ARM Trusted Firmware (ATF)" below)
-  $ cd /src/arm-trusted-firmware
+  $ cd /src/trusted-firmware-a
   $ make PLAT=sun50i_a64 DEBUG=1 bl31
 - Build the SCP firmware binary (see "SCP firmware (Crust)" below)
   $ cd /src/crust
@@ -49,7 +49,7 @@ $ make PLAT=sun50i_a64 DEBUG=1 bl31
 The resulting binary is build/sun50i_a64/debug/bl31.bin. Either put the
 location of this file into the BL31 environment variable or copy this to
 the root of your U-Boot build directory (or create a symbolic link).
-$ export BL31=/src/arm-trusted-firmware/build/sun50i_a64/debug/bl31.bin
+$ export BL31=/src/trusted-firmware-a/build/sun50i_a64/debug/bl31.bin
   (adjust the actual path accordingly)
 The platform target "sun50i_a64" covers all boards with either an Allwinner
 A64 or H5 SoC (since they are very similar). For boards with an Allwinner H6
diff --git a/doc/README.rockchip b/doc/README.rockchip
index 5fcbbd1d990..96fa49d697b 100644
--- a/doc/README.rockchip
+++ b/doc/README.rockchip
@@ -74,14 +74,14 @@ Building
    - Compile ATF
 
      => git clone https://github.com/TrustedFirmware-A/trusted-firmware-a.git
-     => cd arm-trusted-firmware
+     => cd trusted-firmware-a
 
      (export cross compiler path for Cortex-M0 MCU likely arm-none-eabi-)
      => make realclean
      => make CROSS_COMPILE=aarch64-linux-gnu- PLAT=rk3399
 
     (export bl31.elf)
-    => export BL31=/path/to/arm-trusted-firmware/build/rk3399/release/bl31/bl31.elf
+    => export BL31=/path/to/trusted-firmware-a/build/rk3399/release/bl31/bl31.elf
 
    - Compile PMU M0 firmware
 
diff --git a/doc/board/hisilicon/hikey.rst b/doc/board/hisilicon/hikey.rst
index 19b69707d32..aec36f34c8f 100644
--- a/doc/board/hisilicon/hikey.rst
+++ b/doc/board/hisilicon/hikey.rst
@@ -75,7 +75,7 @@ Compile ARM Trusted Firmware (ATF)
 
 .. code-block:: bash
 
-  cd ~/hikey/src/arm-trusted-firmware
+  cd ~/hikey/src/trusted-firmware-a
   make CROSS_COMPILE=aarch64-linux-gnu- all fip \
     SCP_BL2=~/hikey/bin/mcuimage.bin \
     BL33=~/hikey/bin/u-boot.bin DEBUG=1 PLAT=hikey
@@ -100,8 +100,8 @@ Compile l-loader
 .. code-block:: bash
 
   cd ~/hikey/src/l-loader
-  ln -sf ~/hikey/src/arm-trusted-firmware/build/hikey/debug/bl1.bin
-  ln -sf ~/hikey/src/arm-trusted-firmware/build/hikey/debug/bl2.bin
+  ln -sf ~/hikey/src/trusted-firmware-a/build/hikey/debug/bl1.bin
+  ln -sf ~/hikey/src/trusted-firmware-a/build/hikey/debug/bl2.bin
   ln -sf ~/hikey/src/atf-fastboot/build/hikey/debug/bl1.bin fastboot.bin
   make hikey PTABLE_LST=aosp-8g
 
diff --git a/doc/board/hisilicon/hikey960.rst b/doc/board/hisilicon/hikey960.rst
index f726fc75039..de846f60f71 100644
--- a/doc/board/hisilicon/hikey960.rst
+++ b/doc/board/hisilicon/hikey960.rst
@@ -64,7 +64,7 @@ Compile ARM Trusted Firmware (ATF)
 
 .. code-block:: bash
 
-  cd ~/hikey960/src/arm-trusted-firmware
+  cd ~/hikey960/src/trusted-firmware-a
   make CROSS_COMPILE=aarch64-linux-gnu- all fip \
     SCP_BL2=~/hikey960/bin/lpm3.img \
     BL33=~/hikey960/bin/u-boot.bin DEBUG=1 PLAT=hikey960
@@ -81,9 +81,9 @@ Compile l-loader
 .. code-block:: bash
 
   cd ~/hikey960/src/l-loader
-  ln -sf ~/hikey960/src/arm-trusted-firmware/build/hikey960/debug/bl1.bin
-  ln -sf ~/hikey960/src/arm-trusted-firmware/build/hikey960/debug/bl2.bin
-  ln -sf ~/hikey960/src/arm-trusted-firmware/build/hikey960/debug/fip.bin
+  ln -sf ~/hikey960/src/trusted-firmware-a/build/hikey960/debug/bl1.bin
+  ln -sf ~/hikey960/src/trusted-firmware-a/build/hikey960/debug/bl2.bin
+  ln -sf ~/hikey960/src/trusted-firmware-a/build/hikey960/debug/fip.bin
   ln -sf ~/hikey960/bin/u-boot.bin
   make hikey960 PTABLE_LST=linux-32g NS_BL1U=u-boot.bin
 
diff --git a/doc/board/kontron/pitx-imx8m.rst b/doc/board/kontron/pitx-imx8m.rst
index 1cde5bd3bb1..b90221b165e 100644
--- a/doc/board/kontron/pitx-imx8m.rst
+++ b/doc/board/kontron/pitx-imx8m.rst
@@ -26,6 +26,7 @@ Note: builddir is U-Boot build directory (source directory for in-tree builds)
 .. code-block:: bash
 
     $ git clone https://github.com/TrustedFirmware-A/trusted-firmware-a.git
+    $ cd trusted-firmware-a
     $ git checkout v2.5
     $ make PLAT=imx8mq ARCH=aarch64 CROSS_COMPILE=aarch64-linux-gnu- bl31
     $ cp build/imx8mq/release/bl31.bin $(builddir)
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index a275e964c63..86d83befb5b 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -167,7 +167,7 @@ To build TF-A:
 .. code-block:: bash
 
         git clone --depth 1 https://github.com/TrustedFirmware-A/trusted-firmware-a.git
-        cd arm-trusted-firmware
+        cd trusted-firmware-a
         make realclean
         make CROSS_COMPILE=aarch64-linux-gnu- PLAT=rk3399
         cd ..
@@ -199,7 +199,7 @@ To build px30 boards:
 
 .. code-block:: bash
 
-        export BL31=../arm-trusted-firmware/build/px30/release/bl31/bl31.elf
+        export BL31=../trusted-firmware-a/build/px30/release/bl31/bl31.elf
         make evb-px30_defconfig
         make CROSS_COMPILE=aarch64-linux-gnu-
 
@@ -230,7 +230,7 @@ To build rk3328 boards:
 
 .. code-block:: bash
 
-        export BL31=../arm-trusted-firmware/build/rk3328/release/bl31/bl31.elf
+        export BL31=../trusted-firmware-a/build/rk3328/release/bl31/bl31.elf
         make evb-rk3328_defconfig
         make CROSS_COMPILE=aarch64-linux-gnu-
 
@@ -238,7 +238,7 @@ To build rk3368 boards:
 
 .. code-block:: bash
 
-        export BL31=../arm-trusted-firmware/build/rk3368/release/bl31/bl31.elf
+        export BL31=../trusted-firmware-a/build/rk3368/release/bl31/bl31.elf
         make evb-px5_defconfig
         make CROSS_COMPILE=aarch64-linux-gnu-
 
@@ -246,7 +246,7 @@ To build rk3399 boards:
 
 .. code-block:: bash
 
-        export BL31=../arm-trusted-firmware/build/rk3399/release/bl31/bl31.elf
+        export BL31=../trusted-firmware-a/build/rk3399/release/bl31/bl31.elf
         make evb-rk3399_defconfig
         make CROSS_COMPILE=aarch64-linux-gnu-
 
@@ -254,7 +254,7 @@ To build rk3568 boards:
 
 .. code-block:: bash
 
-        export BL31=../arm-trusted-firmware/build/rk3568/release/bl31/bl31.elf
+        export BL31=../trusted-firmware-a/build/rk3568/release/bl31/bl31.elf
         [or]export BL31=../rkbin/bin/rk35/rk3568_bl31_v1.34.elf
         export ROCKCHIP_TPL=../rkbin/bin/rk35/rk3568_ddr_1560MHz_v1.13.bin
         make evb-rk3568_defconfig
diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index a8c0881aa11..3006c5914d6 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -197,7 +197,7 @@ source files that the tool examples:
 
 To run the tool::
 
-    $ tools/binman/fip_util.py  -s /path/to/arm-trusted-firmware
+    $ tools/binman/fip_util.py  -s /path/to/trusted-firmware-a
     Warning: UUID 'UUID_NON_TRUSTED_WORLD_KEY_CERT' is not mentioned in tbbr_config.c file
     Existing code in 'tools/binman/fip_util.py' is up-to-date
 
diff --git a/tools/binman/fip_util.py b/tools/binman/fip_util.py
index aca21a42d3a..9d2eec82a0a 100755
--- a/tools/binman/fip_util.py
+++ b/tools/binman/fip_util.py
@@ -427,7 +427,7 @@ def parse_macros(srcdir):
     """parse_macros: Parse the firmware_image_package.h file
 
     Args:
-        srcdir (str): 'arm-trusted-firmware' source directory
+        srcdir (str): 'trusted-firmware-a' source directory
 
     Returns:
         dict:
@@ -472,7 +472,7 @@ def parse_names(srcdir):
     """parse_names: Parse the tbbr_config.c file
 
     Args:
-        srcdir (str): 'arm-trusted-firmware' source directory
+        srcdir (str): 'trusted-firmware-a' source directory
 
     Returns:
         tuple: dict of entries:
@@ -559,7 +559,7 @@ def parse_atf_source(srcdir, dstfile, oldfile):
     """parse_atf_source(): Parse the ATF source tree and update this file
 
     Args:
-        srcdir (str): Path to 'arm-trusted-firmware' directory. Get this from:
+        srcdir (str): Path to 'trusted-firmware-a' directory. Get this from:
             https://github.com/TrustedFirmware-A/trusted-firmware-a.git
         dstfile (str): File to write new code to, if an update is needed
         oldfile (str): Python source file to compare against
@@ -573,7 +573,7 @@ def parse_atf_source(srcdir, dstfile, oldfile):
     if not os.path.exists(readme_fname):
         raise ValueError(
             f"Expected file '{readme_fname}' - try using -s to specify the "
-            'arm-trusted-firmware directory')
+            'trusted-firmware-a directory')
     readme = tools.read_file(readme_fname, binary=False)
     first_line = 'Trusted Firmware-A'
     if readme.splitlines()[0] != first_line:
@@ -603,7 +603,7 @@ def main(argv, oldfile):
         int: 0 (exit code)
     """
     parser = ArgumentParser(epilog='''Creates an updated version of this code,
-with a table of FIP-entry types parsed from the arm-trusted-firmware source
+with a table of FIP-entry types parsed from the trusted-firmware-a source
 directory''')
     parser.add_argument(
         '-D', '--debug', action='store_true',
@@ -613,7 +613,7 @@ directory''')
         help='Output file to write new fip_util.py file to')
     parser.add_argument(
         '-s', '--src', type=str, default='.',
-        help='Directory containing the arm-trusted-firmware source')
+        help='Directory containing the trusted-firmware-a source')
     args = parser.parse_args(argv)
 
     if not args.debug:
-- 
2.46.2

