Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D60F3C25B75
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 18:58:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3D68881AD;
	Sun, 19 May 2024 20:58:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="jeE7OGkv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 762D788047; Sun, 19 May 2024 16:45:49 +0200 (CEST)
Received: from mail-40141.protonmail.ch (mail-40141.protonmail.ch
 [185.70.40.141])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3539B882A3
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 16:45:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dmoo_dv@protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1716129946; x=1716389146;
 bh=CVeUw3sIlGmaKQPZ+8+7r43FTpMgkdHdPJV+IMmb8tY=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=jeE7OGkvsEIE5KQQJ+j+AJF8zpL0n/nE6e2LyNuVArFCiN/tdl+w0xPjs1iUrowt6
 i3VSX1elz3vhRefBs91AI8Nn7YfMZRZ1WBWoWbZsvsYYvZABfq43VcWjlktvWAfNYh
 5UQF3pxE9W5aRq4EcapvQaVWnLPL+ax5M/lx7FowdHd26S7wLr9v1/rPLJReklvaGT
 oWvFLUCA47p16KU+iYKlSTWqD1dnyQ2y8YWIw1DCaX/aDt4zrYUKDa6YUGzCnj6q4Q
 ooMDRvzQl0WVR3Vg9o5UD5HFJFjplkfVHvOfU1Ktx+mG5PBmajBVMiSrEOv4cJEkJb
 oSWRl1VK+LoZg==
Date: Sun, 19 May 2024 14:45:42 +0000
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
From: H Bell <dmoo_dv@protonmail.com>
Subject: [PATCH 2/2 v3] board: starfive: support Pine64 Star64 board
Message-ID: <He9LjenN3BIOT1eTqM0rLb5TWBPZ8wNo5t-QcW22B5JxYIv7PbpXySfAwiqqK6VIYkKnDyPjDrlDklZWM5kbq0e0BEk4xSUqypWZjHHYQF4=@protonmail.com>
Feedback-ID: 106097379:user:proton
X-Pm-Message-ID: fcbbc23ffbd9a38e6a260956ee8f41fbd79c773c
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 19 May 2024 20:58:11 +0200
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
---
 doc/board/starfive/index.rst         |   1 +
 doc/board/starfive/pine64_star64.rst | 136 +++++++++++++++++++++++++++
 2 files changed, 137 insertions(+)
 create mode 100644 doc/board/starfive/pine64_star64.rst

diff --git a/doc/board/starfive/index.rst b/doc/board/starfive/index.rst
index 2762bf74c1..f05f8a0765 100644
--- a/doc/board/starfive/index.rst
+++ b/doc/board/starfive/index.rst
@@ -7,4 +7,5 @@ StarFive
    :maxdepth: 1
=20
    milk-v_mars.rst
+   pine64_star64
    visionfive2
diff --git a/doc/board/starfive/pine64_star64.rst b/doc/board/starfive/pine=
64_star64.rst
new file mode 100644
index 0000000000..567d1207ba
--- /dev/null
+++ b/doc/board/starfive/pine64_star64.rst
@@ -0,0 +1,136 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Pine64 Star64
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
+    setenv fdtfile my_device-tree.dtb
+    env save
+
+or the configuration variable CONFIG_DEFAULT_FDT_FILE can be used to set t=
o
+provide a default value.
+
+Boot source selection
+~~~~~~~~~~~~~~~~~~~~~
+
+The board provides the DIP switches (marked S1804) adjacent to the 40pin G=
PIO
+Bus for boot selection. The ``L`` (0) and ``H`` (1) silk screening to the =
side
+of the should be used to determine state (not the ``ON/ONKE`` markings
+physically on the component). ``GPIO_0`` is channel 2 on the switch, while
+``GPIO_1`` is channel 1.
+
++ (QSPI) Flash: 00 ``??``
++ SD: 01 ``??``
++ EMMC: 10 ``??``
++ UART: 11 ``??``
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
+MAC address issues
+~~~~~~~~~~~~~~~~~~
+
+The Star64 does not currently ship with unique serial numbers per-device.
+Devices tested (all 4GiB RAM) have the same serial number of
+``STAR64V1-2310-D004E000-00000005`` and the mac addresses of
+``6c:cf:39:00:75:61`` (lower) and ``6c:cf:39:00:75:62`` (upper) port will =
be
+assigned. Shipped models also have the EEPROM set as write protected, so i=
t
+cannot be changed using ``mac`` commands.
+
+The MAC addresses may be "set" as follows by writing as a custom config to=
 SPI
+(Change the last 3 bytes of MAC addreses as appropriate):
+
+::
+
+=09env set ethaddr 6c:cf:39:00:75:63
+=09env set eth1addr 6c:cf:39:00:75:64
+=09env save
+=09reset
--=20
2.44.0


