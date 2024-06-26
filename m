Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083D0C27C4F
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 10:47:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 501D987AEC;
	Wed, 26 Jun 2024 12:47:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="QE8Kojpp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5EC583989; Wed, 26 Jun 2024 12:47:29 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [IPv6:2003:a:e28:26e4::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85A1587FCD
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 12:47:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7FA841486ACB; Wed, 26 Jun 2024 12:47:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1719398845; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=lzeHRDmx2bTIrrsvoccA73MaWc0Ol/zD20X7MHC0p2o=;
 b=QE8KojppXVEfmaAuBmhT2xW3aPbm1Fu5xxg9fMxi6FYI2Iftsim9qVZuVHZ/yNKD1jXZQt
 VDHKZ1/aYxjMqxzayghCqQYJ+L/R/zDqMf1dd1mVkweYGQtYJ1HiyMI93TRco/HNYUquPd
 j2IAoUMJ8HXu45FHzJ8QdUcFUA7X2fi3dAGbBC1w8Hrqq8wQliuVEBrWUFGCqZ52RmzEmq
 ay/yMIQZmujZTspO6UL5+q7Q8JfgO22h73YMvWmM4ayJXbpmUaEGHFAZaBUGIcY7oOUflg
 FoJ93wBIDCGMiDcSzy6+IaQdTc+wdvsn4WFQW65RePYuxlhXM+rsg0s9B6LRqg==
From: Alexander Dahl <ada@thorsis.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Marek Vasut <marex@denx.de>
Subject: [PATCH next] doc: develop: Add a general section on gdb usage
Date: Wed, 26 Jun 2024 12:47:18 +0200
Message-Id: <20240626104718.74965-1-ada@thorsis.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Mashed up from different sources linked below, including the now gone
Wiki and doc/README.arm-relocation file.  Tested on a custom board with
AT91 SAMA5D2 SoC and Segger J-Link Base adapter.  This is only generic
advice here, the usage is not board specific.  Some board docs have more
specific instructions on using gdb with a particular board.

Link: https://www.slideshare.net/slideshow/embedded-recipes-2019-introduction-to-jtag-debugging/177511981
Link: https://boundarydevices.com/debugging-using-segger-j-link-jtag/
Link: https://web.archive.org/web/20141224200032/http://www.denx.de/wiki/view/DULG/DebuggingUBoot
Link: https://web.archive.org/web/20141206064148/http://www.denx.de/wiki/view/DULG/GDBScripts1
Suggested-by: Marek Vasut <marex@denx.de>
Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 doc/develop/gdb.rst   | 154 ++++++++++++++++++++++++++++++++++++++++++
 doc/develop/index.rst |   1 +
 2 files changed, 155 insertions(+)
 create mode 100644 doc/develop/gdb.rst

diff --git a/doc/develop/gdb.rst b/doc/develop/gdb.rst
new file mode 100644
index 00000000000..18d97857ce1
--- /dev/null
+++ b/doc/develop/gdb.rst
@@ -0,0 +1,154 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. Copyright (c) 2024 Alexander Dahl
+
+Debugging U-Boot with gdb
+=========================
+
+Using a JTAG adapter it is possible to debug a running U-Boot with gdb.
+A common way is to connect a debug adapter to the JTAG connector of your
+board, run gdbserver, connect gdb to gdbserver, and use gdb as usual.
+
+Preparing build
+---------------
+
+Building U-Boot with debug symbols and without optimizations is
+recommended for easier debugging::
+
+    CONFIG_CC_OPTIMIZE_FOR_DEBUG=y
+
+Otherwise build, install, and run U-Boot as usual.
+
+Using OpenOCD as GDB server
+---------------------------
+
+[OpenOCD]_ is a FOSS tool supporting hardware debug probes, and
+providing a GDB interface.
+It is readily available in major Linux distributions or you can build it
+from source.
+Example for starting OpenOCD from Debian with a J-Link adapter and a
+board using an AT91 SAMA5D2 SoC:
+
+.. code-block:: console
+
+    % openocd -f interface/jlink.cfg -f target/at91sama5d2.cfg -c 'adapter speed 4000'
+    Open On-Chip Debugger 0.12.0
+    Licensed under GNU GPL v2
+    For bug reports, read
+            http://openocd.org/doc/doxygen/bugs.html
+    Info : auto-selecting first available session transport "jtag". To override use 'transport select <transport>'.
+    adapter speed: 4000 kHz
+
+    Info : Listening on port 6666 for tcl connections
+    Info : Listening on port 4444 for telnet connections
+    Info : J-Link V10 compiled Jan 30 2023 11:28:07
+    Info : Hardware version: 10.10
+    Info : VTarget = 3.244 V
+    Info : clock speed 4000 kHz
+    Info : JTAG tap: at91sama5d2.cpu tap/device found: 0x5ba00477 (mfg: 0x23b (ARM Ltd), part: 0xba00, ver: 0x5)
+    Info : at91sama5d2.cpu_a5.0: hardware has 3 breakpoints, 2 watchpoints
+    Info : at91sama5d2.cpu_a5.0: MPIDR level2 0, cluster 0, core 0, mono core, no SMT
+    Info : starting gdb server for at91sama5d2.cpu_a5.0 on 3333
+    Info : Listening on port 3333 for gdb connections
+
+Notice the port 3333 the OpenOCD server is listening on for gdb
+connections.
+
+Running a gdb session
+----------------------
+
+You need a gdb suited for your target.
+This can be gdb coming with your toolchain or *gdb-multiarch* available
+in your Linux distribution.
+
+.. code-block:: console
+
+    % gdb-multiarch u-boot
+    GNU gdb (Debian 13.1-3) 13.1
+    Copyright (C) 2023 Free Software Foundation, Inc.
+    License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
+    This is free software: you are free to change and redistribute it.
+    There is NO WARRANTY, to the extent permitted by law.
+    Type "show copying" and "show warranty" for details.
+    This GDB was configured as "x86_64-linux-gnu".
+    Type "show configuration" for configuration details.
+    For bug reporting instructions, please see:
+    <https://www.gnu.org/software/gdb/bugs/>.
+    Find the GDB manual and other documentation resources online at:
+        <http://www.gnu.org/software/gdb/documentation/>.
+
+    For help, type "help".
+    Type "apropos word" to search for commands related to "word"...
+    Reading symbols from u-boot...
+    (gdb)
+
+Notice in the above command-line *u-boot* is the binary file from your
+build folder, for which you might need to adapt the path when calling
+gdb.
+
+Connect to the gdb server then:
+
+.. code-block:: console
+
+    (gdb) target extended-remote :3333
+    Remote debugging using :3333
+    0x27fa9ac6 in ?? ()
+    (gdb)
+
+This is fine for running before U-Boot relocates itself.
+For debugging U-Boot after relocation you need to tell gdb.
+You can get the relocation address from U-Boot shell with the command
+*bdinfo* like this:
+
+.. code-block:: console
+
+    U-Boot> bdinfo
+    boot_params = 0x20000100
+    DRAM bank   = 0x00000000
+    -> start    = 0x20000000
+    -> size     = 0x08000000
+    flashstart  = 0x00000000
+    flashsize   = 0x00000000
+    flashoffset = 0x00000000
+    baudrate    = 115200 bps
+    relocaddr   = 0x27f7a000
+    reloc off   = 0x0607a000
+    Build       = 32-bit
+    current eth = ethernet@f8008000
+    ethaddr     = 00:50:c2:31:58:d4
+    IP addr     = <NULL>
+    fdt_blob    = 0x27b36060
+    new_fdt     = 0x27b36060
+    fdt_size    = 0x00003e40
+    lmb_dump_all:
+     memory.cnt = 0x1 / max = 0x10
+     memory[0]      [0x20000000-0x27ffffff], 0x08000000 bytes flags: 0
+     reserved.cnt = 0x1 / max = 0x10
+     reserved[0]    [0x27b31d00-0x27ffffff], 0x004ce300 bytes flags: 0
+    devicetree  = separate
+    arch_number = 0x00000000
+    TLB addr    = 0x27ff0000
+    irq_sp      = 0x27b36050
+    sp start    = 0x27b36040
+    Early malloc usage: cd8 / 2000
+
+Look out for the line starting with *relocaddr* which has the address
+you need, ``0x27f7a000`` in this case.
+In gdb shell discard the previously loaded symbol file and add it once
+again with that relocation address like this:
+
+.. code-block:: console
+
+    (gdb) symbol-file
+    Discard symbol table from `/home/adahl/build/u-boot/v2024.04.x/u-boot'? (y or n) y
+    No symbol file now.
+    (gdb) add-symbol-file u-boot 0x27f7a000
+    add symbol table from file "u-boot" at
+            .text_addr = 0x27f7a000
+    (y or n) y
+    Reading symbols from u-boot...
+    (gdb)
+
+You can now use gdb as usual, setting breakpoints, printing backtraces,
+inspecting variables, stepping through the code, etc.
+
+.. [OpenOCD] https://openocd.org/
diff --git a/doc/develop/index.rst b/doc/develop/index.rst
index f82e148b101..f9c4bf839ee 100644
--- a/doc/develop/index.rst
+++ b/doc/develop/index.rst
@@ -60,6 +60,7 @@ Debugging
    :maxdepth: 1
 
    crash_dumps
+   gdb
    trace
 
 Packaging

base-commit: a7eada24327a40f7ef6c55c220e119839c9d4227
-- 
2.39.2

