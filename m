Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C43E106289F
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 13:15:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF89C84065;
	Wed, 11 Mar 2026 14:14:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="SEfVnxG6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C9B083F9A; Wed, 11 Mar 2026 08:39:01 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C246A83F6D
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 08:38:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=guodong@riscstar.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-439b73f4ab4so10300912f8f.1
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 00:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1773214738; x=1773819538;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lA+IwzWisqD9I9OjeOIKt7ZwfxOtaMhsLp6BWXsp4Yc=;
 b=SEfVnxG6sxckUGksqLDYfCu+IulERlWbN+VDgF9FfFruY+5DYDnFMbKaP7PuADm5H0
 M1iGSmTofCWMeYkIim9aOLVV2hHorNVUNZxV7yjx7mqoicoUxfeV2NDHPAM+2fo2c3Bd
 KDw0QYYa93F8AIcpQGdbx72G6vqySRtwDssK20K6Y7zJpZn1ON2MZx0rfw62QbmzjN7g
 hLqmJrTAz94dzV3UdG2Zy0SMvl6C9RS4nX7FxFv2Xe8yB4DuQkbZv/CakPKk5moj4kSm
 /G1jGJZ1rkESEq1Y0PZiFcsKKmot4FXx1zq6v9Jwg5IhKPMyrSuhmhnH2Z2EAxldjKXT
 paHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773214738; x=1773819538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lA+IwzWisqD9I9OjeOIKt7ZwfxOtaMhsLp6BWXsp4Yc=;
 b=f4gKx5sPqiAse9AQGzQFRoJTykhgm6cHThEnwoLVDErTQRLvOPcypU9IlJyMW8pJ4i
 abjIJzka7EAdEA+ZSEhnftHz0TDgnWyX+6lb22nXJuGf6YtYqdAHGkImNvchwxsjhKYn
 g5EbJM355dfgb24YM+mlPIiv+MEZ4kppbO/NcN3+GdDZHcQ1FLoqfvD7nQ7MyimKKHrn
 JXIuxU0x5cA2Ei/u5CPoh+Ft11LJQfqXQ/ybWkQcqLFVk+d/2O8JMh8HEB+srs0GHrEs
 NO/mJVDR1lCXKxeJhIoqW3VEYIUjSIAAXuH/1eMgKG/ZHGsbgYOJdUSL1CkvG93KjXZk
 a5ug==
X-Gm-Message-State: AOJu0YxFN1UJfKitixP684fTAf4jnwTWeuTXgBcIAgRMp+aO7+OfPZrG
 N5pgMSrWXAhSX83lbRPHowBwy2TYPLR2StLp3380iiEP84Pt8SIS2OfUeJul3ar9TfgAOug8yf+
 J7G9D+XFWBR+v
X-Gm-Gg: ATEYQzxAJ2TmHaFWgTbwQuABIRr/gNlgj/tRFPwsfvYHdGV7B4yn4EtA2QfwZRpR+S5
 ACbZt3gcjsxgi6rRW7eizuIq3KuAq9ssS2S2JBMTzht+ZAKnDFc2sNIX2ocT1NEQY4VSpuV7TLM
 GENkcV5OFQ+0yvZPh4U1WmembMtwEnqz/TJW3vRy3QSZrN1W+F0jR5Ajj++n9QuXJ7J/ycFYClr
 59h1TF0Z40YG9LSTyrLus86ZuUl/o900mUMSh2eVWpddHiMuEGsCBPU2Sk4X+MZBM34edZlrCn8
 ZQVCr8T0HHrF6xXEoQMRO8Y5yj5g5QNe0aWOI33frBeTcwQDJvt/nzDZlbHtykWjhiO0VRegl2p
 tyzP6WZ7oslRjRMeTKYob1DoemG4oSj+ilHK+p4aMVxd55CqMbMDE5DMtDeovY+oXrdbWkAIip/
 TDiAZmgnIguqSeskKwQ8JaWjtoOAjdxiBq1qcOw6VaMMJH8TS144lIkKHoJg==
X-Received: by 2002:a5d:588e:0:b0:439:5c75:dc08 with SMTP id
 ffacd0b85a97d-439f81bc54dmr2962455f8f.10.1773214737815; 
 Wed, 11 Mar 2026 00:38:57 -0700 (PDT)
Received: from localhost.localdomain ([2a0b:89c0::cc:103a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439f8104515sm4214094f8f.0.2026.03.11.00.38.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 00:38:57 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, heinrich.schuchardt@canonical.com, rick@andestech.com,
 ycliang@andestech.com, raymond.mao@riscstar.com, u-boot-spacemit@groups.io,
 Guodong Xu <guodong@riscstar.com>
Subject: [PATCH] doc: spacemit: add K1 SPL build and test guide
Date: Wed, 11 Mar 2026 15:37:41 +0800
Message-ID: <20260311073741.80616-1-guodong@riscstar.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210151459.2348758-1-raymondmaoca@gmail.com>
References: <20260210151459.2348758-1-raymondmaoca@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 11 Mar 2026 14:14:46 +0100
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
Following up on the discussion at yesterday's community meeting, this
patch adds build and test instructions for the K1 SPL patchset [1].

This is placed as a SoC-level guide since the SPL build and flashing
procedure is shared across all K1 boards. The existing bananapi-f3.rst
will be updated to reference this in a future patch as more of the boot
chain is upstreamed.

Link: https://lore.kernel.org/u-boot/20260210151459.2348758-1-raymondmaoca@gmail.com/ [1]

 doc/board/spacemit/index.rst  |   1 +
 doc/board/spacemit/k1-spl.rst | 214 ++++++++++++++++++++++++++++++++++
 2 files changed, 215 insertions(+)
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
index 00000000000..3e22f6dec70
--- /dev/null
+++ b/doc/board/spacemit/k1-spl.rst
@@ -0,0 +1,214 @@
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
+   $ git clone https://gitee.com/bianbu-linux/uboot-2022.10
+
+The script uses ``fsbl_ddr.json`` which may not exist by default. If
+``fsbl_ddr.json`` does not exist in ``uboot-2022.10/spl_bin/configs/``,
+create it by copying ``fsbl.json`` and replacing the reference to
+``u-boot-spl.bin`` with ``u-boot-spl-ddr.bin``:
+
+.. code-block:: console
+
+   $ cd uboot-2022.10/spl_bin/configs
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
+   CONFIG_PATH="{your path}/uboot-2022.10/spl_bin/configs"
+
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
+After successful SPL boot with DDR initialization, the serial console displays
+messages confirming:
+
+- I2C and PMIC initialization
+- DDR training firmware loaded and executed
+- DDR initialization complete
+
+Sample DDR training success log::
+
+    Read Training.....
+    each RX Vref corresponding min margin = 9 10 10 11 11 12 11 11 11 10 10 9 8 4 4 0
+     optimize Rx Vref adjust=5 ,corresponding best margin=12
+    Again!!! training optimize Fine Rx vref step = 5
+    Write Training.....
+    each TX Vref corresponding min margin = 9 9 9 10 9 10 10 10 10 10 10 10 10 10 10 10
+     optimize Tx Vref adjust=24 ,corresponding best margin=10
+    Again!!! training optimize Fine Tx vref step = 24
+    Training status[0xFFFFFFFC0058000]=0x00000000
+    DDR DQ rx margin:
+    0xc083feb0: 0d 0d 0d 0c 0d 0d 0d 0d 0d 0d 0d 0d 0d 0d 0d 0c
+    0xc083fec0: 0d 0d 0d 0d 0c 0d 0c 0d 0c 0c 0c 0d 0d 0d 0d 0d
+    DDR DQ tx margin:
+    0xc083fed0: 0b 0b 0b 0a 0b 0b 0b 0b 0a 0b 0a 0b 0b 0b 0b 0a
+    0xc083fee0: 0c 0b 0b 0a 0b 0b 0b 0b 0a 0a 0a 0b 0a 0b 0a 0a
+    change to 2400MTPS
+    !!!!!ADDR[0xffffffffd4282bb4]=0x00033b40 !!!!
+    frequency change done!!!!
+    ADDR[0xffffffffd4282bb4]=0x00033b40 !!!!
+    150000 KHZ: 1; 150000 KHZ: 1; 200000 KHZ: 1; 266000 KHZ: 1; 300000 KHZ: 1; 400000 KHZ: 1; 600000 KHZ: 2; 666000 KHZ: 3;
+    Change DDR data rate to 2400MT/s
+    ddr_early_init: ret:2400
+
+Key success indicators:
+
+- ``Read Training`` / ``Write Training`` - DDR read/write training completed
+- ``Training status[...]=0x00000000`` - training completed with no errors
+- ``change to 2400MTPS`` and ``frequency change done`` - DDR frequency switch succeeded
+- ``Change DDR data rate to 2400MT/s`` - DDR running at target speed
+- ``ddr_early_init: ret:2400`` - DDR init function returned successfully
+
+.. note::
+
+   After DDR init succeeds, SPL proceeds to load U-Boot proper. If U-Boot
+   proper is not yet available (as in SPL-only testing), you will see
+   ``SPL: failed to boot from all boot devices`` - this is expected and
+   confirms that SPL with DDR init is working correctly.
+
+If SPL hangs before printing DDR messages, verify that ``DDR_FW_FILE`` was set
+during build and that ``ddr_fw.bin`` is not empty.
+
+References
+~~~~~~~~~~~
+
+- `DDR firmware repository <https://github.com/spacemit-com/spacemit-firmware>`_
+- `SpacemiT vendor U-Boot (signing tool) <https://gitee.com/bianbu-linux/uboot-2022.10>`_
-- 
2.43.0

