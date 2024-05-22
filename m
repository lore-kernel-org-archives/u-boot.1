Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3945C25B79
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 19:13:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E509884BD;
	Wed, 22 May 2024 21:13:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="jfScjvNN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91487884B3; Wed, 22 May 2024 21:13:02 +0200 (CEST)
Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCA1188464
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 21:12:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dmoo_dv@protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1716405178; x=1716664378;
 bh=stWa+v70pdzCHb1O0rAJzRa+KGXN6cUuHqLCNOUq0g8=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=jfScjvNNYlGoPi5qyEpkNLc4mpgWTrl7mZOLohibFvNBoQMq7jahCsdG4ge3nHYfm
 wu+IryuEbUfe9NoUMMtf4YsFSYj8DTBoD/34aM270GRcwIOb+z6D3r+Cwwf71vslM8
 rccaG8q7OtfzVHm+asncjMF4nAbL3SApJjKCBiPQF8v9WBI20fNQKEvwqCFPiFlpvV
 hiVJ4r0sQ4P9p9gkynlHexAiXJc/XeICMDEcmvZEYM69OlP+5CIUJl/oKentB1i3Bf
 N88LKjnA3PjhIUV7t+hjpYt5WOS3LHsXsoX8i1A13ZJxU2BLX6pKV/wKFRhZ0yH5p9
 mPplFsTX4P4PQ==
Date: Wed, 22 May 2024 19:12:51 +0000
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
From: H Bell <dmoo_dv@protonmail.com>
Subject: [PATCH 2/2 v5] board: starfive: support Pine64 Star64 board
Message-ID: <6Yk7L2-xTxcUnQdR0tk_SVFsR-REvvBdSSzDPivTKNeM_3-wlFKeIQtDp1cJTjjOoO9P54bPe_q51mO1PvGF7e6Q-Tqo0k-F2QoLP6Tn8ss=@protonmail.com>
Feedback-ID: 106097379:user:proton
X-Pm-Message-ID: 321a4a4908452d942aec16ceeed2cb9577a6610c
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Add documentation files

Signed-off-by: Henry Bell <dmoo_dv@protonmail.com>
Cc: ycliang@andestech.com
Cc: heinrich.schuchardt@canonical.com
---

Changes since v1

- New patch

Changes since v2

- Remove extra params to
- Clarification on boot section
- Add entry on MAC adresses and how to correct them

Changes=09since v3

- Rebase against d678a59d2d

Changes since v4

- Rework and expand docs on boot selection switches and overriding
  MAC addresses
- Fix warnings and underline width
---
 doc/board/starfive/index.rst         |   1 +
 doc/board/starfive/pine64_star64.rst | 201 +++++++++++++++++++++++++++
 2 files changed, 202 insertions(+)
 create mode 100644 doc/board/starfive/pine64_star64.rst

diff --git a/doc/board/starfive/index.rst b/doc/board/starfive/index.rst
index d369b986cc..72ab6ddfbf 100644
--- a/doc/board/starfive/index.rst
+++ b/doc/board/starfive/index.rst
@@ -8,4 +8,5 @@ StarFive
=20
    milk-v_mars
    milk-v_mars_cm
+   pine64_star64
    visionfive2
diff --git a/doc/board/starfive/pine64_star64.rst b/doc/board/starfive/pine=
64_star64.rst
new file mode 100644
index 0000000000..52e9a90791
--- /dev/null
+++ b/doc/board/starfive/pine64_star64.rst
@@ -0,0 +1,201 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Pine64 Star64
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+U-Boot for the Star64 uses the same U-Boot binaries as the VisionFive 2 bo=
ard.
+In U-Boot SPL the actual board is detected and the device-tree patched
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
+   export CROSS_COMPILE=3D<riscv64 toolchain prefix>
+
+The M-mode software OpenSBI provides the supervisor binary interface (SBI)=
 and
+is responsible for the switch to S-Mode. It is a prerequisite to build U-B=
oot.
+Support for the JH7110 was introduced in OpenSBI 1.2. It is recommended to=
 use
+a current release.
+
+.. code-block:: console
+
+=09git clone https://github.com/riscv/opensbi.git
+=09cd opensbi
+=09make PLATFORM=3Dgeneric FW_TEXT_START=3D0x40000000
+
+Now build the U-Boot SPL and U-Boot proper.
+
+.. code-block:: console
+
+=09cd <U-Boot-dir>
+=09make starfive_visionfive2_defconfig
+=09make OPENSBI=3D$(opensbi_dir)/build/platform/generic/firmware/fw_dynami=
c.bin
+
+This will generate the U-Boot SPL image (spl/u-boot-spl.bin.normal.out) as=
 well
+as the FIT image (u-boot.itb) with OpenSBI and U-Boot.
+
+Device-tree selection
+~~~~~~~~~~~~~~~~~~~~~
+
+U-Boot will set variable $fdtfile to starfive/jh7110-pine64-star64.dtb.
+
+To overrule this selection the variable can be set manually and saved in t=
he
+environment
+
+::
+
+    env set fdtfile my_device-tree.dtb
+    env save
+
+or the configuration variable CONFIG_DEFAULT_FDT_FILE can be used to set t=
o
+provide a default value.
+
+Boot source selection
+~~~~~~~~~~~~~~~~~~~~~
+
+Boot mode is selected by an MSEL-DIP marked S1804 and GPIO_0 position adja=
cent
+to the 40pin GPIO header. ON/ONKE and number markings of the MSEL-DIP are
+misleading; Instead refer to the ``L`` (0) and ``H`` (1) silkscreen for
+accurate selection.
+
++ (QSPI) Flash: 00
++ SD: 01
++ EMMC: 10
++ UART: 11
+
+Preparing the SD-Card
+~~~~~~~~~~~~~~~~~~~~~
+
+The device firmware loads U-Boot SPL (u-boot-spl.bin.normal.out) from the
+partition with type GUID 2E54B353-1271-4842-806F-E436D6AF6985. You are fre=
e
+to choose any partition number.
+
+With the default configuration U-Boot SPL loads the U-Boot FIT image
+(u-boot.itb) from partition 2 (CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=
=3D0x2).
+When formatting it is recommended to use GUID
+BC13C2FF-59E6-4262-A352-B275FD6F7172 for this partition.
+
+The FIT image (u-boot.itb) is a combination of OpenSBI's fw_dynamic.bin,
+u-boot-nodtb.bin and the device tree blob.
+
+Format the SD card (make sure the disk has GPT, otherwise use gdisk to swi=
tch)
+
+.. code-block:: bash
+
+=09sudo sgdisk --clear \
+=09  --set-alignment=3D2 \
+=09  --new=3D1:4096:8191 --change-name=3D1:spl --typecode=3D1:2E54B353-127=
1-4842-806F-E436D6AF6985\
+=09  --new=3D2:8192:16383 --change-name=3D2:uboot --typecode=3D2:BC13C2FF-=
59E6-4262-A352-B275FD6F7172  \
+=09  --new=3D3:16384:1654784 --change-name=3D3:system --typecode=3D3:EBD0A=
0A2-B9E5-4433-87C0-68B6B72699C7 \
+=09  /dev/sdb
+
+Copy U-Boot to the SD card
+
+.. code-block:: bash
+
+=09sudo dd if=3Du-boot-spl.bin.normal.out of=3D/dev/sdb1
+=09sudo dd if=3Du-boot.itb of=3D/dev/sdb2
+
+=09sudo mount /dev/sdb3 /mnt/
+=09sudo cp u-boot-spl.bin.normal.out /mnt/
+=09sudo cp u-boot.itb /mnt/
+=09sudo cp Image.gz /mnt/
+=09sudo cp initramfs.cpio.gz /mnt/
+=09sudo cp jh7110-starfive-visionfive-2.dtb /mnt/
+=09sudo umount /mnt
+
+Booting
+~~~~~~~
+
+Once you plugin the sdcard and power up, you should see the U-Boot prompt.
+
+Serial Number and MAC address issues
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+U-Boot requires valid EEPROM data to determine which board-specific fix-up=
 to
+apply at runtime. This affects the size of memory initialized, network mac
+address numbering, and tuning of the network PHYs.
+
+The Star64 does not currently ship with unique serial numbers per-device.
+Devices follow a pattern where the last mac address bytes are a sum of 0x7=
558
+and the serial number (lower port mac0), or a sum of 0x7559 and the serial
+number (upper port mac1).
+
+As tested there are several 4gb model units where the serial number and ne=
twork
+mac addresses collide with other devices (serial
+``STAR64V1-2310-D004E000-00000005``, MACs ``6c:cf:39:00:75:61``,
+``6c:cf:39:00:75:62``)
+
+Some early Star64 boards shipped with an uninitialized EEPROM and no write
+protect pull-up resistor in place. Later units of all 4gb and 8gb models
+sharing the same serial number in EEPROM data will have this problem that =
the
+network mac addresses are alike between different models and this may be
+corrected by defeating the write protect resistor to write new values. As =
an
+alternative to this, it may be worked around by overriding the mac address=
es
+via U-Boot environment variables.
+
+It is required for any unit having uninitialized EEPROM and recommended fo=
r
+all later Star64 4gb model units (not properly serialized) to have decided=
 on a
+new 6-byte serial number. This serial number should be high enough to
+avoid collision with other JH7110 boards and low enough not to overflow i.=
e.
+between ``cafe00`` and ``f00d00``.
+
+Update EEPROM values
+^^^^^^^^^^^^^^^^^^^^
+
+1. Prepare EEPROM data in memory
+
+::
+
+=09## When there is no error to load existing data:
+=09mac read_eeprom
+
+=09## When there is an error to load non-existing data:
+=09# "DRAM:  Not a StarFive EEPROM data format - magic error"
+=09mac initialize
+
+2. Set Star64 values
+
+::
+
+=09## Common values
+=09mac vendor PINE64
+=09mac pcb_revision c1
+=09mac bom_revision A
+
+=09## Device-specific values
+=09# Year 2023 week 10 production date, 8GB DRAM, optional eMMC, serial cd=
ef01
+=09mac product_id STAR64V1-2310-D008E000-00cdef01
+
+=09# Last three bytes mac0: 0x7558 + serial number 0xcdef01
+=09mac mac0_address 6c:cf:39:ce:64:59
+
+=09# Last three bytes mac1: 0x7559 + serial number 0xcdef01
+=09mac mac1_address 6c:cf:39:ce:64:5a
+
+3. Defeat write-protect pull-up resistor (if installed) and write to EEPRO=
M
+
+::
+
+=09mac write_eeprom
+
+Set Variables in U-Boot
+^^^^^^^^^^^^^^^^^^^^^^^
+
+.. note:: Changing just the serial number will not alter your MAC address
+
+The MAC addresses may be "set" as follows by writing as a custom config to=
 SPI
+(Change the last 3 bytes of MAC addreses as appropriate):
+
+::
+
+=09env set serial# STAR64V1-2310-D008E000-00cdef01
+=09env set ethaddr 6c:cf:39:ce:64:59
+=09env set eth1addr 6c:cf:39:ce:64:5a
+=09env save
+=09reset
--=20
2.44.0


