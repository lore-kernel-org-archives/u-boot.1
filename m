Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71425C36018
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 07:25:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6C6881E18;
	Mon, 31 Mar 2025 09:24:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="BxBIUJmc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 522648144A; Mon, 31 Mar 2025 09:24:31 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE5FF81ED8
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 09:24:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-110-051.46.114.pool.telefonica.de
 [46.114.110.51])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id AD0D93FFCC; 
 Mon, 31 Mar 2025 07:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1743405865;
 bh=IrIKiY5hqYDepf6xPnnSvq2fNjD53mS/XRICHLGXfCw=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=BxBIUJmcwn9rEiX/jqIzi2Vk4MJfYht7f7BORN59stnyGt0DMp9L74eCVNl8a4Wlu
 9LuOFoZB1DdsEyYTVkDFtvpJ2L1XQV813mfwCSiMEkoe17paE6McAl9XhlkoiMzVNm
 Y3OhWvERr2Kr3AxtqHBq63fzV0n2f47crN2NcK+p4GmikwTkLpdGFDkMZpRLQKGswO
 GmWhWcqzoeOVxfZtQmAVIawE/YhncE/aEBvv/HxX6dmKrcILAttSlx4J5CFEZp9sf5
 Hsa4XgnEkFBYBFCIJT0zmm/WNhgr+O40dJxVjTNxhoHX6DBkhgVJoWk+uo65IKZUim
 QlkQqTaQ+QbEg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: E Shattow <e@freeshell.de>, E Shattow <lucent@gmail.com>,
 Sumit Garg <sumit.garg@kernel.org>, H Bell <dmoo_dv@protonmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, Simon Glass <sjg@chromium.org>,
 Andreas Schwab <schwab@suse.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 5/8] doc: add DeepComputing FML13V01 documentation
Date: Mon, 31 Mar 2025 09:24:07 +0200
Message-ID: <20250331072410.8662-6-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250331072410.8662-1-heinrich.schuchardt@canonical.com>
References: <20250331072410.8662-1-heinrich.schuchardt@canonical.com>
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

Describe building U-Boot for the board and booting.

Carve out common information for JH7110 boards into an include.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	carve out common information for JH7110 boards into an include
---
 doc/board/starfive/deepcomputing_fml13v01.rst | 80 +++++++++++++++++++
 doc/board/starfive/index.rst                  |  1 +
 doc/board/starfive/jh7110_common.rst          | 66 +++++++++++++++
 3 files changed, 147 insertions(+)
 create mode 100644 doc/board/starfive/deepcomputing_fml13v01.rst
 create mode 100644 doc/board/starfive/jh7110_common.rst

diff --git a/doc/board/starfive/deepcomputing_fml13v01.rst b/doc/board/starfive/deepcomputing_fml13v01.rst
new file mode 100644
index 00000000000..5d9612483b4
--- /dev/null
+++ b/doc/board/starfive/deepcomputing_fml13v01.rst
@@ -0,0 +1,80 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+DeepComputing Framework Motherboard (FLM13V01)
+==============================================
+
+The DeepComputing Framework motherboard (FLM13V01) can be combined with a
+13 inch Framework laptop chassis to provide a complete laptop.
+
+U-Boot for the board uses the same binaries as the VisionFive 2 board.
+Currently only serial console output is supported by mainline U-Boot.
+
+Building
+--------
+
+Setup the cross compilation environment variable:
+
+.. code-block:: bash
+
+   export CROSS_COMPILE=riscv64-linux-gnu-
+
+The M-mode software OpenSBI provides the supervisor binary interface (SBI) and
+is responsible for the switch to S-Mode. It is a prerequisite for building
+U-Boot. Support for the JH7110 was introduced in OpenSBI 1.2. It is recommended
+to use a current release.
+
+.. code-block:: bash
+
+    git clone https://github.com/riscv/opensbi.git
+    cd opensbi
+    make PLATFORM=generic FW_TEXT_START=0x40000000 FW_OPTIONS=0
+    export OPENSBI="$(pwd)/build/platform/generic/firmware/fw_dynamic.bin"
+
+Now build U-Boot SPL and main U-Boot.
+
+.. code-block:: bash
+
+    cd <U-Boot-dir>
+    make starfive_visionfive2_defconfig
+    make
+
+This will generate the U-Boot SPL image (spl/u-boot-spl.bin.normal.out) as well
+as the FIT image (u-boot.itb) with OpenSBI, U-Boot, and device-trees.
+
+Device-tree selection
+---------------------
+
+The product ID stored in the board EEPROM is used by U-Boot SPL to select the
+right configuration and device-tree from the u-boot.itb FIT image.
+
+Furthermore if variable $fdtfile has not been saved in the environment it is
+set based on the product ID to *starfive/jh7110-deepcomputing-fml13v01.dtb*.
+
+To overrule this default the variable can be set manually and saved in the
+environment
+
+.. code-block:: console
+
+    setenv fdtfile my_device-tree.dtb
+    env save
+
+Power switch
+------------
+
+A tiny power switch is located in right upper corner of the board.
+
+Open case detection
+-------------------
+
+The board has an open case detection switch. Red lights will flash and the
+board will not boot if the switch is not held down.
+
+UART
+----
+
+UART 0 is exposed via the side channel contacts SBU1 and SBU2 of the lower,
+right USB C connector. A USB C cable and a breakout board are needed for
+physical access. It depends on the cable orientation on which of SBU1 and SBU2
+you will find RX and TX. The signal voltage is 3.3 V. The baud rate is 115200.
+
+.. include:: jh7110_common.rst
diff --git a/doc/board/starfive/index.rst b/doc/board/starfive/index.rst
index 72ab6ddfbf6..ce0ee4a0a2f 100644
--- a/doc/board/starfive/index.rst
+++ b/doc/board/starfive/index.rst
@@ -6,6 +6,7 @@ StarFive
 .. toctree::
    :maxdepth: 1
 
+   deepcomputing_fml13v01
    milk-v_mars
    milk-v_mars_cm
    pine64_star64
diff --git a/doc/board/starfive/jh7110_common.rst b/doc/board/starfive/jh7110_common.rst
new file mode 100644
index 00000000000..44ccd612ff4
--- /dev/null
+++ b/doc/board/starfive/jh7110_common.rst
@@ -0,0 +1,66 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Boot source selection
+---------------------
+
+The board provides DIP switches to select the device for loading the boot
+firmware.
+
+=========== === ===
+Boot source SW1 SW2
+=========== === ===
+UART        OFF OFF
+SD-card     ON  OFF
+eMMC        OFF ON
+SPI flash   ON  ON
+=========== === ===
+
+Flashing a new U-Boot version
+-----------------------------
+
+U-Boot SPL is provided as file spl/u-boot-spl.bin.normal.out. Main U-Boot is
+in file u-boot.itb.
+
+Assuming your new U-Boot version is on partition 1 of an SD-card you could
+install it to the SPI flash with:
+
+.. code-block:: console
+
+    sf probe
+    load mmc 1:1 $kernel_addr_r u-boot-spl.bin.normal.out
+    sf update $kernel_addr_r 0 $filesize
+    load mmc 1:1 $kernel_addr_r u-boot.itb
+    sf update $kernel_addr_r 0x100000 $filesize
+
+For loading the files from a TFTP server refer to the dhcp and tftpboot
+commands.
+
+After updating U-Boot you may want to erase a saved environment and reboot.
+
+.. code-block:: console
+
+    env erase
+    reset
+
+Booting from SD-Card or eMMC
+----------------------------
+
+The device boot ROM loads U-Boot SPL (u-boot-spl.bin.normal.out) from the
+partition with type GUID 2E54B353-1271-4842-806F-E436D6AF6985. You are free
+to choose any partition number.
+
+With the default configuration U-Boot SPL loads the U-Boot FIT image
+(u-boot.itb) from partition 2 (CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x2).
+When formatting it is recommended to use GUID
+BC13C2FF-59E6-4262-A352-B275FD6F7172 for this partition.
+
+Booting from UART
+-----------------
+
+The boot ROM supports the X-modem protocol to upload
+spl/u-boot-spl.bin.normal.out. U-Boot SPL support loading the FIT image
+u-boot.itb via the Y-modem protocol.
+
+Due to restrictions of the boot ROM not all X-modem implementations are
+compatible. The package tio (https://github.com/tio/tio) has been found to be
+usable.
-- 
2.48.1

