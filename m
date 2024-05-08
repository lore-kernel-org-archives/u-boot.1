Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F98C25B74
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 04:59:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6143D88478;
	Thu,  9 May 2024 06:59:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="XuKAvmav";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C51187DCD; Wed,  8 May 2024 22:33:50 +0200 (CEST)
Received: from mail-40132.protonmail.ch (mail-40132.protonmail.ch
 [185.70.40.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 883708826C
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 22:33:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dmoo_dv@protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1715200426; x=1715459626;
 bh=4tlZDqqmoFwWQUc1e4RRiXtsY4BQa82utGwajwoX6Hk=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=XuKAvmavYrskv2O5AGB8lV2K25nEvtF/skNIX3UIxiuId1kzhysMCA8nQT/+stLO7
 MBcF7UQTYm6j+0iW0XtljduMoR0a088m/e+vLIwanBHkHpGjgWLuj4blXTq3h5WYFK
 6dsqctWSD+9KWrr6is2D5jMBNuOxw/9Q+SI3WiuU+icCuh162+Jo7MiQRe6ppFuVD+
 wgmrvVukgx3EXfQ8zPkQGEzHAe4aEav34dGCuIyGMB5syM3TwVMUvqo3AZ9yZ5fg0e
 woo0DANB/XPCD9XJE6nXZSGUhyiXQ2ZC1Ymh3f01p725OwS3KHJeyiUXFBw0/zeYGM
 oLkPTQZsgGp8g==
Date: Wed, 08 May 2024 20:33:44 +0000
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
From: H Bell <dmoo_dv@protonmail.com>
Subject: [PATCH 2/2 v2] board: starfive: support Pine64 Star64 board
Message-ID: <4yWrCvGQf7QHU6yyu78zoEYdB14BqDmLpfJrIcPDierL5oQKWT_IWgQPC8k6KbKEuW738-F2xl5D2KFDT8XfOnm7WLt7nldN5_cO5AJ3PL0=@protonmail.com>
Feedback-ID: 106097379:user:proton
X-Pm-Message-ID: b41f26480545584f4c46b7796f64ca03a810576e
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 09 May 2024 06:59:07 +0200
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
---
 doc/board/starfive/index.rst         |   1 +
 doc/board/starfive/pine64_star64.rst | 109 +++++++++++++++++++++++++++
 2 files changed, 110 insertions(+)
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
index 0000000000..047f109028
--- /dev/null
+++ b/doc/board/starfive/pine64_star64.rst
@@ -0,0 +1,109 @@
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
+=09make PLATFORM=3Dgeneric FW_TEXT_START=3D0x40000000 FW_OPTIONS=3D0
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
+The board provides the DIP switches MSEL[1:0] to select the boot device ou=
t of
+SPI flash, eMMC, SD-card, UART. To select booting from SD-card set the DIP
+switches MSEL[1:0] to 10.
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
--=20
2.44.0
