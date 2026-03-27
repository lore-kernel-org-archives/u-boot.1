Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9888810BA435
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 08:15:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D766083DA7;
	Fri, 27 Mar 2026 09:15:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="PFv/2VpQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 568E783E7A; Fri, 27 Mar 2026 09:15:28 +0100 (CET)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DBC583C14
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 09:15:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=guodong@riscstar.com
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-824c9da9928so1641689b3a.3
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 01:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1774599324; x=1775204124;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OjwTP1Jf31hvFTCzlcMnQIE36DW6SY4uTRcMQbG5DCY=;
 b=PFv/2VpQA8Yozk0kgMJHlD9fG5DZ+9nu/UJ5q3BQxs2Esgbmf851OnGxohfdskQ8ap
 1/iO1+W1jHV8hIbWVByYQMXE6stHYE2dL3tz3naNN0yk8mxnLYf3jElj9s8QgtrhDhBY
 NZrldhM+LdhrCTTwNATKSB0iRVGS41vIcHi0k2jyrVAtlzmyR1cxdom1kioutUGgDSST
 TaHyCOo9mgIXh1wVydYCMg0nv6Y0NPn6abJU4C691dLG8sCuBZi9b41P4QLqEMS4xHD1
 yIVdyR90hzdRGBUOTrvoaQsvwhAowGpc1P0syeDdJhocaVAyI3zgLdQeLIZSI1iRiM4t
 orVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774599324; x=1775204124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OjwTP1Jf31hvFTCzlcMnQIE36DW6SY4uTRcMQbG5DCY=;
 b=Gyf1TrKl+7bGTAQfxcSppZIIAUSuYgOBPJ2N8GV/vhnHvWIqy4LP/E2xT54d0a1Okp
 FEHZE0VuUyNV60JoA2rpBVl/UuOh7aZJaFMEU1pX4IGJT3MTPkCLSbclTMhcqOSEQOLe
 w7CCrrtllltwGZTQbuKcnxhF+yEWZRyXgjbapgldC/W4jXVl6Amq4jwS1tR2dKicKpS2
 2msq4QaaTy4tcJPHyVhqGpaRJYuSrsfMcPLDgZKlVJUBN+PgciYh1vYBd468+xMMaIqZ
 IEX90GxaTGCYJiOwEgQWC1E0DqFnh6PZH1mMNAkxCbUXCRPoeLma9eiaH26Lz1i+FqRT
 YqcQ==
X-Gm-Message-State: AOJu0Yxk54Nl1ebbFh9Zo8Ok63EIjzS5zegq+BQ1nGMbZechJEB4FFl9
 eHohGfFuWyl9tIvtU38rQrFa4aAApS+q0kZR0WtiPTVAOz96sdH29PbzWjAkf/J+ELNUD6i4qEa
 OSLzAnJsweeaB
X-Gm-Gg: ATEYQzxmWAWdhcdHOoiFZhhUL/s+bxWaXBaGxXxuoIE6MRAncYSPFbEDoqVW2VBEuBI
 16s1Ri2oq1hQJUjOQcyW7/raX2YqQaAhotTQfrb4HJi35Hcbip6jN5WGOWNxww6Jdxwd36OJ24D
 BpXIWFeQuqvsP7kKwUhf9VsKYKxw6xzeD1nlfn3xqNJztLar3aWRcuYh1YfzIhuaZUl+XHsr4a7
 OI94EZsNIHT0Bsscqkd9dbappAo6XTyLzAe0Tj4+7gqnjj2bpvEKyUpR20OBgh1h7f9bFEHqgGH
 Wn/LoyYbz8ApHd8hoLRpXlKiSRhQyhkhBOrCdeJPiInxl+X1bl94Tv6z/xC6AMQ9x9xcyk7poQL
 1VH0zn0OvizS+G9ecza0V/Cn2SytGi8ohTkWB4GjcUCJ+uN3gOW7eTssuO+7wlwqN28bQUHy+03
 HfHB/HVDkQhNgtjVuNz2Xj+p4bVOEAgmFFnYH5Zps9qB6viceIrgk4SHCF3eedJ3wcY2VFwP9yX
 kiq6HHQ
X-Received: by 2002:a05:6a00:1884:b0:82c:212a:8023 with SMTP id
 d2e1a72fcca58-82c95d42841mr1790272b3a.11.1774599323602; 
 Fri, 27 Mar 2026 01:15:23 -0700 (PDT)
Received: from localhost.localdomain ([45.142.165.89])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82c7d388d11sm4798615b3a.28.2026.03.27.01.15.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 01:15:23 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, heinrich.schuchardt@canonical.com, rick@andestech.com,
 ycliang@andestech.com, raymond.mao@riscstar.com, u-boot-spacemit@groups.io,
 Vincent Legoll <legoll@online.fr>, Guodong Xu <guodong@riscstar.com>
Subject: [PATCH v2] doc: spacemit: add K1 SPL build and test guide
Date: Fri, 27 Mar 2026 16:14:18 +0800
Message-ID: <20260327081418.550546-1-guodong@riscstar.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325223232.1553212-1-raymondmaoca@gmail.com>
References: <20260325223232.1553212-1-raymondmaoca@gmail.com>
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

The K1 SPL patchset requires DDR firmware integration and FSBL signing
steps that are not covered by existing documentation. Add a SoC-level
guide so reviewers and developers can build and test on hardware.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
Changes in v2:
  - Update vendor U-Boot repo from bianbu-linux to spacemit-buildroot,
    and specify the k1-bl-v2.2.y branch
  - Fix fsbl.json path to board/spacemit/k1-x/configs/
  - Add mkdir -p for spl_bin directory in fsbl.sh
  - Replace verbose DDR training log with concise SPL boot output
  - Update expected output notes for SPI NOR availability

 doc/board/spacemit/index.rst  |   1 +
 doc/board/spacemit/k1-spl.rst | 196 ++++++++++++++++++++++++++++++++++
 2 files changed, 197 insertions(+)
 create mode 100644 doc/board/spacemit/k1-spl.rst

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
index 00000000000..6192cbe32b0
--- /dev/null
+++ b/doc/board/spacemit/k1-spl.rst
@@ -0,0 +1,196 @@
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
+Connect a 3.3V USB-to-UART cable to the **J25** header on the BPI-F3.
+Remove all other cables first, then attach UART::
+
+    BPI-F3 top view
+    +--------------------------------------------------+
+    |                                                  |
+    |   J15: USB-C [====]     [FDL] [PWR] [RST]       |
+    |                                                  |
+    |                                                  |
+    |                              J25 (UART header)   |
+    |                              [TXD] [RXD] [GND]  |
+    +--------------------------------------------------+
+
+After UART is connected, attach the USB Type-C cable to J15 to power on.
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
+**2. Build SPL**
+
+.. code-block:: console
+
+   $ export CROSS_COMPILE=riscv64-linux-gnu-
+   $ export ARCH=riscv
+   $ export DDR_FW_FILE=$(pwd)/ddr_fw.bin
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
+**3. Generate signed FSBL image**
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
+   cp ${MAINLINE_UBOOT_IMG_PATH}/u-boot-spl-ddr.bin ${FSBL_PATH}/
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
+1. Disconnect USB Type-C cable from J15 (power off)
+2. **Press and hold** the FDL button (see board layout above)
+3. Reconnect USB Type-C cable while holding the FDL button
+4. Release the FDL button
+
+The serial console should show a BootROM prompt indicating it is ready to
+accept an image via USB.
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
+After successful SPL boot with DDR initialization, the serial console displays::
+
+    U-Boot SPL 2026.04-rc4-00543-g2ba03a569e61 (Mar 26 2026 - 16:48:44 +0100)
+    Fail to detect board:-2
+    vdd_core, value:900000
+    vdd_1v8, value:1800000
+    vdd_1v8_mmc, value:500000
+    DDR firmware: [0xc08159c0]:0xf0227179, size:0x8d98
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
+.. note::
+
+   After DDR init succeeds, SPL proceeds to load U-Boot proper. Since
+   SPI NOR storage driver support is not yet available, SPL cannot
+   transition into U-Boot proper. When U-Boot stage support is ready,
+   this document will be updated.
+
+If SPL hangs before printing DDR messages, verify that ``DDR_FW_FILE`` was set
+during build and that ``ddr_fw.bin`` is not empty.
+
+References
+~~~~~~~~~~~
+
+- `DDR firmware repository <https://github.com/spacemit-com/spacemit-firmware>`_
+- `SpacemiT vendor U-Boot (signing tool) <https://gitee.com/spacemit-buildroot/uboot-2022.10>`_
-- 
2.43.0

