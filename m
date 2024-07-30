Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A995C3DA61
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 07:11:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D6FE887DB;
	Tue, 30 Jul 2024 09:09:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B540888BC; Tue, 30 Jul 2024 09:09:51 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BD028887C
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 09:09:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Zhiqiang.Hou@nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 179102013F1;
 Tue, 30 Jul 2024 09:09:48 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D4D8C2013FD;
 Tue, 30 Jul 2024 09:09:47 +0200 (CEST)
Received: from mega.am.freescale.net (mega.ap.freescale.net [10.192.208.232])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id
 42D01183487B; Tue, 30 Jul 2024 15:09:46 +0800 (+08)
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: u-boot@lists.denx.de, trini@konsulko.com, peng.fan@nxp.com,
 festevam@gmail.com, sjg@chromium.org, marex@denx.de, lukma@denx.de,
 seanga2@gmail.com, xypron.glpk@gmx.de
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv4 11/14] doc: cmd: add documentation for cpu command
Date: Tue, 30 Jul 2024 15:30:00 +0800
Message-Id: <20240730073003.28892-12-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240730073003.28892-1-Zhiqiang.Hou@nxp.com>
References: <20240730073003.28892-1-Zhiqiang.Hou@nxp.com>
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

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Add documentation for the 'cpu' command, taking NXP i.MX 8M Plus
as a example.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V4:
 - Added brief descriptions for each subcommand..

 doc/usage/cmd/cpu.rst | 101 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 doc/usage/cmd/cpu.rst

diff --git a/doc/usage/cmd/cpu.rst b/doc/usage/cmd/cpu.rst
new file mode 100644
index 0000000000..8b0b7d5a69
--- /dev/null
+++ b/doc/usage/cmd/cpu.rst
@@ -0,0 +1,101 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. Copyright 2024 NXP
+
+.. index::
+   single: cpu (command)
+
+cpu command
+===========
+
+Synopsis
+--------
+
+::
+
+    cpu list
+    cpu detail
+    cpu release <core ID> <addr>
+
+Description
+-----------
+
+The *cpu* command prints information about the CPUs, and release a CPU core
+to a given address to run applications.
+
+
+cpu list
+~~~~~~~~
+
+The 'list' subcommand lists and prints brief information of all the CPU cores,
+the CPU information is provided by vendors' CPU driver.
+
+cpu detail
+~~~~~~~~~~
+
+The 'detail' subcommand prints more details about the CPU cores, including
+CPU ID, core frequency and feature list.
+
+cpu release
+~~~~~~~~~~~
+
+The 'release' subcommand is used to release a CPU core to run a baremetal or
+RTOS applications.
+The parameter <core ID> is the sequence number of the CPU core to release.
+The parameter <addr> is the address to run of the specified core after release.
+
+
+Examples
+--------
+
+cpu list
+~~~~~~~~
+
+This example lists all the CPU cores On i.MX8M Plus EVK:
+::
+
+    u-boot=> cpu list
+      0: cpu@0      NXP i.MX8MP Rev1.1 A53 at 1200 MHz at 31C
+      1: cpu@1      NXP i.MX8MP Rev1.1 A53 at 1200 MHz at 30C
+      2: cpu@2      NXP i.MX8MP Rev1.1 A53 at 1200 MHz at 31C
+      3: cpu@3      NXP i.MX8MP Rev1.1 A53 at 1200 MHz at 31C
+
+cpu detail
+~~~~~~~~~~
+
+This example prints the details of the CPU cores On i.MX8M Plus EVK:
+::
+
+    u-boot=> cpu detail
+      0: cpu@0      NXP i.MX8MP Rev1.1 A53 at 1200 MHz at 31C
+            ID = 0, freq = 1.2 GHz: L1 cache, MMU
+      1: cpu@1      NXP i.MX8MP Rev1.1 A53 at 1200 MHz at 30C
+            ID = 0, freq = 1.2 GHz: L1 cache, MMU
+      2: cpu@2      NXP i.MX8MP Rev1.1 A53 at 1200 MHz at 31C
+            ID = 0, freq = 1.2 GHz: L1 cache, MMU
+      3: cpu@3      NXP i.MX8MP Rev1.1 A53 at 1200 MHz at 31C
+            ID = 0, freq = 1.2 GHz: L1 cache, MMU
+
+cpu release
+~~~~~~~~~~~
+
+This example shows release the LAST CPU core to run a RTOS application, on
+i.MX8M Plus EVK:
+::
+
+     u-boot=> load mmc 1:2 c0000000 /hello_world.bin
+     66008 bytes read in 5 ms (12.6 MiB/s)
+     u-boot=> dcache flush; icache flush
+     u-boot=> cpu release 3 c0000000
+     Released CPU core (mpidr: 0x3) to address 0xc0000000
+
+
+Configuration
+-------------
+
+The cpu command is available if CONFIG_CMD_CPU=y.
+
+Return code
+-----------
+
+The return value $? is set to 0 (true) if the command is successful,
+1 (false) otherwise.
-- 
2.17.1

