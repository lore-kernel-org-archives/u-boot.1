Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 318C0C48BF6
	for <u-boot@archiver.kernel.org>; Sun,  3 Mar 2024 13:02:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B560E87F29;
	Sun,  3 Mar 2024 14:01:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Rhqdkygi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2540B87CE8; Sun,  3 Mar 2024 14:01:32 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E495987EFE
 for <u-boot@lists.denx.de>; Sun,  3 Mar 2024 14:01:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-095-222-037-056.um34.pools.vodafone-ip.de
 [95.222.37.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 23BAF41BEC; 
 Sun,  3 Mar 2024 13:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1709470889;
 bh=rrr8Pn78S51t7TZigCRH2Mz9LnAdO68+Fz0nubSXvF4=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Rhqdkygi3DVVB6LUL3DOXVyOZ/8ywYZNdC65utzHgtzGGUral8IMHJ6YrYdwkz6CO
 jjaSxMll93Y+G2pyZQu9GMBu8+kwqp6EVA3l8MYYqQ0oxYzpz49Tn4ffAa9SMzmm/D
 6vZOkJZLCi3P9mBVggv27DMwmOgxMpSH9wEbIRpLYf6cRAPhRucVQGswx6wXOFeqZ3
 XvtgJ68vFB65mNOxvMSaDYxzfMuZ20kR33srnv2KoEKO8JhlveGISffhhNvI/0MIdu
 DvvfDJY03XifHCDF3KGjF6WpVyYyayxrH7PNTeYunhSNRgHYTWJJhI4T5Sz40LcJRq
 vEP6OdPYZxL9A==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Yanhong Wang <yanhong.wang@starfivetech.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Cc: Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Chanho Park <chanho61.park@samsung.com>,
 Shiji Yang <yangshiji66@outlook.com>, Shengyu Qu <wiagn233@outlook.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [RFC 5/5] doc: describe Milk-V Mars board
Date: Sun,  3 Mar 2024 14:01:22 +0100
Message-ID: <20240303130122.29983-6-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240303130122.29983-1-heinrich.schuchardt@canonical.com>
References: <20240303130122.29983-1-heinrich.schuchardt@canonical.com>
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

Add instructions to build U-Boot for the Milk-V Mars board

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/board/starfive/index.rst       |  1 +
 doc/board/starfive/milk-v_mars.rst | 93 ++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+)
 create mode 100644 doc/board/starfive/milk-v_mars.rst

diff --git a/doc/board/starfive/index.rst b/doc/board/starfive/index.rst
index 0c52dc7b095..2762bf74c11 100644
--- a/doc/board/starfive/index.rst
+++ b/doc/board/starfive/index.rst
@@ -6,4 +6,5 @@ StarFive
 .. toctree::
    :maxdepth: 1
 
+   milk-v_mars.rst
    visionfive2
diff --git a/doc/board/starfive/milk-v_mars.rst b/doc/board/starfive/milk-v_mars.rst
new file mode 100644
index 00000000000..9cfd5d7bddd
--- /dev/null
+++ b/doc/board/starfive/milk-v_mars.rst
@@ -0,0 +1,93 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Milk-V Mars
+===========
+
+U-Boot for the Milk-V Mars uses the same U-Boot binaries as the VisionFive 2
+board. In U-Boot SPL the actual board is detected and the device-tree patched
+accordingly.
+
+Building
+~~~~~~~~
+
+1. Add the RISC-V toolchain to your PATH.
+2. Setup ARCH & cross compilation environment variable:
+
+.. code-block:: none
+
+   export CROSS_COMPILE=<riscv64 toolchain prefix>
+
+The M-mode software OpenSBI provides the supervisor binary interface (SBI) and
+is responsible for the switch to S-Mode. It is a prerequisite to build U-Boot.
+Support for the JH7110 was introduced in OpenSBI 1.2. It is recommended to use
+a current release.
+
+.. code-block:: console
+
+	git clone https://github.com/riscv/opensbi.git
+	cd opensbi
+	make PLATFORM=generic FW_TEXT_START=0x40000000 FW_OPTIONS=0
+
+Now build the U-Boot SPL and U-Boot proper.
+
+.. code-block:: console
+
+	cd <U-Boot-dir>
+	make starfive_visionfive2_defconfig
+	make OPENSBI=$(opensbi_dir)/build/platform/generic/firmware/fw_dynamic.bin
+
+This will generate the U-Boot SPL image (spl/u-boot-spl.bin.normal.out) as well
+as the FIT image (u-boot.itb) with OpenSBI and U-Boot.
+
+Boot source selection
+~~~~~~~~~~~~~~~~~~~~~
+
+The board provides the DIP switches MSEL[1:0] to select the boot device out of
+SPI flash, eMMC, SD-card, UART. To select booting from SD-card set the DIP
+switches MSEL[1:0] to 10.
+
+Preparing the SD-Card
+~~~~~~~~~~~~~~~~~~~~~
+
+The device firmware loads U-Boot SPL (u-boot-spl.bin.normal.out) from the
+partition with type GUID 2E54B353-1271-4842-806F-E436D6AF6985. You are free
+to choose any partition number.
+
+With the default configuration U-Boot SPL loads the U-Boot FIT image
+(u-boot.itb) from partition 2 (CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x2).
+When formatting it is recommended to use GUID
+BC13C2FF-59E6-4262-A352-B275FD6F7172 for this partition.
+
+The FIT image (u-boot.itb) is a combination of OpenSBI's fw_dynamic.bin,
+u-boot-nodtb.bin and the device tree blob.
+
+Format the SD card (make sure the disk has GPT, otherwise use gdisk to switch)
+
+.. code-block:: bash
+
+	sudo sgdisk --clear \
+	  --set-alignment=2 \
+	  --new=1:4096:8191 --change-name=1:spl --typecode=1:2E54B353-1271-4842-806F-E436D6AF6985\
+	  --new=2:8192:16383 --change-name=2:uboot --typecode=2:BC13C2FF-59E6-4262-A352-B275FD6F7172  \
+	  --new=3:16384:1654784 --change-name=3:system --typecode=3:EBD0A0A2-B9E5-4433-87C0-68B6B72699C7 \
+	  /dev/sdb
+
+Copy U-Boot to the SD card
+
+.. code-block:: bash
+
+	sudo dd if=u-boot-spl.bin.normal.out of=/dev/sdb1
+	sudo dd if=u-boot.itb of=/dev/sdb2
+
+	sudo mount /dev/sdb3 /mnt/
+	sudo cp u-boot-spl.bin.normal.out /mnt/
+	sudo cp u-boot.itb /mnt/
+	sudo cp Image.gz /mnt/
+	sudo cp initramfs.cpio.gz /mnt/
+	sudo cp jh7110-starfive-visionfive-2.dtb /mnt/
+	sudo umount /mnt
+
+Booting
+~~~~~~~
+
+Once you plugin the sdcard and power up, you should see the U-Boot prompt.
-- 
2.43.0

