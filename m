Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B35CEC43602
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 01:21:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4404584B06;
	Tue, 30 Jun 2026 03:20:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="tRCVGsSH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B126484A6D; Tue, 30 Jun 2026 03:20:44 +0200 (CEST)
Received: from mail-dl1-x122e.google.com (mail-dl1-x122e.google.com
 [IPv6:2607:f8b0:4864:20::122e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E30A184B07
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 03:20:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-dl1-x122e.google.com with SMTP id
 a92af1059eb24-1384ebe7a10so7287344c88.1
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 18:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1782782440; x=1783387240;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Asq8b1PvlSsSmlEeQtXL0fGj8vHiMU24gUeC02dXUUo=;
 b=tRCVGsSHFNKfZlyuediw5842Crbyf4m0Tm7JwqcY/PgDjM4eXrEtrvTIBIhUtKZG45
 AJOQ8QqZV9/IR4JpELcrVSXW3rURjsr9StvX3PEVAg57CopMx3KHAxb7PZq7zdxp7T4n
 248T5t6v5eIckLd93psCjBelE6HedNlknEIKDnlTZFg2MdPQvIN6Sz58/2nNqut2b99j
 4GMUNdNIpmN31vW2yRiQwtWmLNBlTuRdaPkGtgfDXS/J5oJSGZxZQkl7nIyIs5KwZGhw
 +cYOSasCsR25WxBGCU7nOLElNPzuDMdRb/eC/Np2TjhO1xKqBAgp/ufHEArwl98hP7Nv
 vZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782782440; x=1783387240;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Asq8b1PvlSsSmlEeQtXL0fGj8vHiMU24gUeC02dXUUo=;
 b=rAqBev8E/10qFkC01Oisr4DxtRolT/sjTdNioT75qEOy71a0yU/XFXFtFi3gaWA+S2
 AKs9RyjerenwRVGEBFLIWkPMsPa594koWmI4iTaBIhexPF8fjPA6sc3cj1o/gP0ftNDV
 Jwisw9ij344aHytC+Jm329XGhOK6DWoP0FEvn9grdPHnZxcxP9D/rfMwhPjAIk7yM0jA
 dvxM1AOgQVvG+03MEnAD6XsoAoR9CxOFAGYfXubK1rfWLkRHsJNavKrGH5t3Aw3vow5d
 c6aIXr5nGH7msuL7kszn0cdnyI0ZVbr6e/d2nF54wJYPLY7b49XP9wYp+ejCMoFBq1Z+
 PKEA==
X-Gm-Message-State: AOJu0YzL4L3oB1zOfYBx6HRq7UFvScII3OqMiDKvjaG0DKNDyFRD8zjG
 xodQsVMzHlgvc46n5AUN17Fd3gLkdGmNWSCn1QqiAvcl8ub6jWC3i/kcVrlaW3CZhdo=
X-Gm-Gg: AfdE7ck4jFGlt8A9W9eEn90rrg8GHbPSiSAYpCTdwh545Rmc1gJkYIes4Um1vtkKjMZ
 4EXFE1dlYH3MK5ViVLEb6xdsRqKO0ck0qnk5N3c5JVp1e0Uc/IHkfH3oCzwyAa8gj8OUE0lfNlL
 AvmEUHLKp+BL9wPqhgFcAvcz3c4CTLv5qM4bCNO4h5CK5EIvszoRMgQyjv7BHczGJG8LvwJ7WCO
 w1WHxJ7Yd8vm1o1qj/yJVF/sf0QfMTGCZm9GFwEVzv5MRngJ5mvfoRjBGYI5CpbaFzWcnJI+pr4
 abmP4x+dZCtfIN2yuTVBY24TNY8F/MkV+GHR8xuKf738i56YHl/Jv2U+owC1pG7g2zJ/NWK6JQ+
 qHSkGrtqzfPVqsq3eDhUWYGloRKSjLIO5pvL9zZ/PUAsrAAwzYoXw2mf8N9asphpHs1aIRSTLjj
 7UtrN/3DWAMj9ubsBnLi1Ab67NsKU3u/3W27kPg6Gm7/WnNeEARcFU3dmnUx2kZdEfXvP7O+I8W
 QQl7S6NZykuMekggp9LghVJcv84jlel5KH6RvZi5I1ZEvKhVjWxYQ==
X-Received: by 2002:a05:7022:3d14:b0:139:ed5d:3ae with SMTP id
 a92af1059eb24-13b2a1c33d8mr881066c88.39.1782782440124; 
 Mon, 29 Jun 2026 18:20:40 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2a9b425asm2806974c88.0.2026.06.29.18.20.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 18:20:39 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Tue, 30 Jun 2026 09:19:15 +0800
Subject: [PATCH v5 14/14] doc: spacemit: add K1 SPL build and test guide
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-m1-v1-14-83f13347b3ba@riscstar.com>
References: <20260630-m1-v1-0-83f13347b3ba@riscstar.com>
In-Reply-To: <20260630-m1-v1-0-83f13347b3ba@riscstar.com>
To: u-boot@lists.denx.de, u-boot-spacemit@groups.io, 
 Yixun Lan <dlan@gentoo.org>
Cc: Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Tom Rini <trini@konsulko.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Randolph Sheng-Kai Lin <randolph@andestech.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Yao Zi <me@ziyao.cc>, 
 Peng Fan <peng.fan@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Heiko Schocher <hs@nabladev.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Justin Swartz <justin.swartz@risingedge.co.za>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Henrik Grimler <henrik@grimler.se>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Eric Chung <eric.chung@riscstar.com>, Guodong Xu <guodong@riscstar.com>, 
 Songsong Zhang <sszhang@vsit.ai>
X-Mailer: b4 0.15.2
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

From: Guodong Xu <guodong@riscstar.com>

The K1 SPL patchset requires DDR firmware integration and FSBL signing
steps that are not covered by existing documentation. Add a SoC-level
guide so reviewers and developers can build and test on hardware.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
Tested-by: Songsong Zhang <sszhang@vsit.ai>
---
 doc/board/spacemit/index.rst  |   1 +
 doc/board/spacemit/k1-spl.rst | 243 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 244 insertions(+)

diff --git a/doc/board/spacemit/index.rst b/doc/board/spacemit/index.rst
index e7d3d94e459..a5e35ee12ab 100644
--- a/doc/board/spacemit/index.rst
+++ b/doc/board/spacemit/index.rst
@@ -6,4 +6,5 @@ SpacemiT
    :maxdepth: 1
 
    bananapi-f3
+   k1-spl
 
diff --git a/doc/board/spacemit/k1-spl.rst b/doc/board/spacemit/k1-spl.rst
new file mode 100644
index 00000000000..187eed56e8e
--- /dev/null
+++ b/doc/board/spacemit/k1-spl.rst
@@ -0,0 +1,243 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+SpacemiT K1 SPL Build and Test Guide
+=====================================
+
+This guide explains how to build and test U-Boot SPL on SpacemiT K1 based
+boards. It covers building SPL with DDR initialization, generating the signed
+FSBL image, and deploying via USB fastboot.
+
+Tested boards: Banana Pi BPI-F3, MusePi Pro.
+
+.. note::
+
+   The procedure described here loads SPL into SRAM via USB fastboot and
+   does not modify the on-board flash, so a power cycle restores the
+   board's normal boot path.
+
+   At this stage of the patchset, SPL initializes DDR and then halts with
+   "SPL: Unsupported Boot Device!" because SPI NOR storage support is not
+   yet available in U-Boot proper. This document will be updated when
+   U-Boot stage support is ready.
+
+Prerequisites
+~~~~~~~~~~~~~
+
+- A SpacemiT K1 board with USB Type-C and UART access
+- USB-to-UART adapter (3.3V TTL)
+- ``minicom`` or equivalent serial terminal, configured at 115200 8N1
+- ``fastboot`` tool on the host
+
+Hardware Setup
+~~~~~~~~~~~~~~
+
+**1. UART Connection**
+
+Remove all other cables first, then attach UART. Connect a 3.3V
+USB-to-UART cable to the board's UART header (J25 on the BPI-F3)::
+
+    BPI-F3 top view
+    +--------------------------------------------------+
+    |                                                  |
+    |   J15: USB-C [====]     [FDL] [PWR] [RST]        |
+    |                                                  |
+    |                                                  |
+    |                              J25 (UART header)   |
+    |                              [TXD] [RXD] [GND]   |
+    +--------------------------------------------------+
+
+After UART is connected, attach the USB Type-C cable to the OTG port
+(J15 on BPI-F3) to power on.
+
+**2. Serial Console**
+
+.. code-block:: console
+
+   $ minicom -D /dev/ttyUSB0
+
+Default baudrate: 115200.
+
+Building U-Boot SPL
+~~~~~~~~~~~~~~~~~~~~
+
+**1. Obtain the DDR training firmware**
+
+The DDR training firmware is a proprietary binary provided by SpacemiT. It is
+not included in U-Boot and must be downloaded separately from:
+
+https://github.com/spacemit-com/spacemit-firmware/tree/master/k1/v0.2
+
+Download ``ddr_fw.bin`` from that directory.
+
+This binary is integrated into the SPL image at build time via the binman
+framework. When the SPL image is loaded to SRAM (e.g., via USB fastboot),
+the SPL executes the DDR firmware from SRAM to perform DDR initialization.
+
+**2. Obtain OpenSBI fw_dynamic.bin**
+
+Any pre-built ``fw_dynamic.bin`` is sufficient. Upstream OpenSBI
+sources are at https://github.com/riscv-software-src/opensbi if you
+need to build one.
+
+At this stage of the patchset, SPL halts before invoking OpenSBI,
+but U-Boot's binman still packages ``fw_dynamic.bin`` into
+``u-boot.itb`` and the build fails if it is missing.
+
+**3. Build SPL**
+
+.. code-block:: console
+
+   $ export CROSS_COMPILE=riscv64-linux-gnu-
+   $ export ARCH=riscv
+   $ export DDR_FW_FILE=$(pwd)/ddr_fw.bin
+   $ export OPENSBI=/path/to/fw_dynamic.bin
+   $ make spacemit_k1_defconfig
+   $ make
+
+Output: ``u-boot-spl-ddr.bin`` in the build directory. This image contains the
+SPL code and the DDR firmware blob packaged together via binman.
+
+.. note::
+
+   If ``DDR_FW_FILE`` is not set, the build completes with an empty
+   placeholder. The resulting SPL will boot but cannot initialize DDR.
+
+**4. Generate signed FSBL image**
+
+The K1 BootROM requires a signed first-stage bootloader (FSBL). The signing
+tool (``tools/build_binary_file.py``) is in SpacemiT's vendor U-Boot repository:
+
+.. code-block:: console
+
+   $ git clone -b k1-bl-v2.2.y https://gitee.com/spacemit-buildroot/uboot-2022.10
+
+The script uses ``fsbl_ddr.json`` which may not exist by default. If
+``fsbl_ddr.json`` does not exist in
+``uboot-2022.10/board/spacemit/k1-x/configs/``,
+create it by copying ``fsbl.json`` and replacing the reference to
+``u-boot-spl.bin`` with ``u-boot-spl-ddr.bin``:
+
+.. code-block:: console
+
+   $ cd uboot-2022.10/board/spacemit/k1-x/configs
+   $ cp fsbl.json fsbl_ddr.json
+   $ sed -i 's/u-boot-spl\.bin/u-boot-spl-ddr.bin/g' fsbl_ddr.json
+
+Create the ``fsbl.sh`` script below in the ``uboot-2022.10`` directory.
+Update the path variables to match your local setup:
+
+.. code-block:: bash
+
+   #!/bin/sh
+   MAINLINE_UBOOT_IMG_PATH="{your path}/u-boot"
+   MAINLINE_SPL_IMG_PATH="{your path}/u-boot/spl"
+   FSBL_PATH="{your path}/uboot-2022.10/spl_bin"
+   KEY_TOOL_PATH="{your path}/uboot-2022.10/tools"
+   CONFIG_PATH="{your path}/uboot-2022.10/board/spacemit/k1-x/configs"
+
+   mkdir -p ${FSBL_PATH}
+   echo "Clean binaries in ${FSBL_PATH}"
+   rm -f ${FSBL_PATH}/u-boot-spl-ddr.bin
+   rm -f ${FSBL_PATH}/u-boot-spl.bin
+
+   if [ ! -d ${MAINLINE_SPL_IMG_PATH} ]; then
+           MAINLINE_UBOOT_IMG_PATH="{your path}/build"
+           MAINLINE_SPL_IMG_PATH="{your path}/build/spl"
+   fi
+
+   # The signing tool reads u-boot-spl-ddr.bin from the path declared in
+   # fsbl_ddr.json's "source" field, which is resolved relative to the
+   # JSON file's directory -- i.e. one level up from CONFIG_PATH, not
+   # FSBL_PATH. Stage the unsigned binary there before signing.
+   cp ${MAINLINE_UBOOT_IMG_PATH}/u-boot-spl-ddr.bin ${CONFIG_PATH}/../
+   python3 ${KEY_TOOL_PATH}/build_binary_file.py \
+       -c ${CONFIG_PATH}/fsbl_ddr.json \
+       -o ${FSBL_PATH}/FSBL.bin
+
+Then run:
+
+.. code-block:: console
+
+   $ chmod +x fsbl.sh
+   $ ./fsbl.sh
+
+Output: ``FSBL.bin`` in the ``spl_bin`` directory, ready for deployment.
+
+Deploying via USB Fastboot
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+To enter BootROM fastboot mode:
+
+1. Power off the board by unplugging its power supply.
+2. **Press and hold** the FDL button (called "Boot Key" on some boards;
+   see the board layout above for the BPI-F3).
+3. While holding the button, use a USB cable to connect the OTG port to
+   your host. This cable is also used by fastboot to upload the firmware.
+4. Release the button.
+
+On the host, ``fastboot devices`` should list the board::
+
+    dfu-device     DFU download
+
+The serial console shows the BootROM's USB download handler trace,
+including a line like::
+
+    usb2d_initialize : enter
+
+This indicates the board is ready to accept an image via USB.
+
+.. tip::
+
+   If you are worried about insufficient USB power, you can first plug
+   in the power, then release the button, and then plug in the USB
+   cable.
+
+On the host:
+
+.. code-block:: console
+
+   $ sudo fastboot stage FSBL.bin
+   $ sudo fastboot continue
+
+Expected Output
+~~~~~~~~~~~~~~~~
+
+During successful SPL boot with DDR initialization, the serial console
+shows output like::
+
+    <debug_uart>
+
+    U-Boot SPL 2026.04-rc4-00430-g8b84b1ed8ea9 (May 08 2026 - 09:08:27 -0400)
+    Fail to detect board:-19
+    vdd_core, value:900000
+    vdd_1v8, value:1800000
+    vdd_1v8_mmc, value:1800000
+    DDR firmware: [0xc0815840]:0xf0227179, size:0x8d98
+    DDR is ready
+    SPL: Unsupported Boot Device!
+    SPL: failed to boot from all boot devices
+    ### ERROR ### Please RESET the board ###
+
+To walk through the key lines:
+
+- ``DDR firmware: [...], size:0x8d98`` - DDR firmware loaded successfully
+- ``DDR is ready`` - DDR initialization completed
+- ``SPL: failed to boot from all boot devices`` - expected at this stage,
+  confirms that SPL with DDR init is working correctly
+
+If SPL hangs before printing DDR messages, verify that ``DDR_FW_FILE`` was set
+during build and that ``ddr_fw.bin`` is not empty.
+
+.. tip::
+
+   To see verbose DDR training output from the DDR firmware (per-phase
+   training pass/fail logs), add ``#define DEBUG`` at the top of
+   ``board/spacemit/k1/spl.c`` and rebuild. SPL then passes ``puts`` as
+   the firmware's log callback; otherwise the callback is ``NULL`` and
+   the firmware runs silently.
+
+References
+~~~~~~~~~~~
+
+- `DDR firmware repository <https://github.com/spacemit-com/spacemit-firmware>`_
+- `SpacemiT vendor U-Boot (signing tool) <https://gitee.com/spacemit-buildroot/uboot-2022.10>`_

-- 
2.51.0

