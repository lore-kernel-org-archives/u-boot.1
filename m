Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8C6C3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 17:32:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55E0D88756;
	Fri, 26 Jul 2024 19:30:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48B2588646; Fri, 26 Jul 2024 19:30:35 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C67D87C7E
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 19:30:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Zhiqiang.Hou@nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 20F291A0B57;
 Fri, 26 Jul 2024 19:30:33 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CFD5D1A02C1;
 Fri, 26 Jul 2024 19:30:32 +0200 (CEST)
Received: from mega.am.freescale.net (mega.ap.freescale.net [10.192.208.232])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id
 D82C6183ACAC; Sat, 27 Jul 2024 01:30:31 +0800 (+08)
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: u-boot@lists.denx.de, trini@konsulko.com, peng.fan@nxp.com,
 festevam@gmail.com, sjg@chromium.org
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv3 09/12] doc: cmd: add documentation for cpu command
Date: Sat, 27 Jul 2024 01:51:05 +0800
Message-Id: <20240726175108.34704-10-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240726175108.34704-1-Zhiqiang.Hou@nxp.com>
References: <20240726175108.34704-1-Zhiqiang.Hou@nxp.com>
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
V3:
 - New patch.

 doc/usage/cmd/cpu.rst | 82 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 doc/usage/cmd/cpu.rst

diff --git a/doc/usage/cmd/cpu.rst b/doc/usage/cmd/cpu.rst
new file mode 100644
index 00000000000..0970e57d5b5
--- /dev/null
+++ b/doc/usage/cmd/cpu.rst
@@ -0,0 +1,82 @@
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
+Example
+-------
+
+cpu list
+~~~~~~~~
+List and print brief information of all the CPU cores On i.MX8M Plus EVK:
+::
+
+    u-boot=> cpu list
+      0: cpu@0      NXP i.MX8MP Rev1.1 A53 at 1200 MHz at 31C
+
+      1: cpu@1      NXP i.MX8MP Rev1.1 A53 at 1200 MHz at 30C
+
+      2: cpu@2      NXP i.MX8MP Rev1.1 A53 at 1200 MHz at 31C
+
+      3: cpu@3      NXP i.MX8MP Rev1.1 A53 at 1200 MHz at 31C
+
+cpu detail
+~~~~~~~~~~
+Print more details of all the CPU cores On i.MX8M Plus EVK:
+::
+
+    u-boot=> cpu detail
+      0: cpu@0      NXP i.MX8MP Rev1.1 A53 at 1200 MHz at 31C
+
+            ID = 0, freq = 1.2 GHz: L1 cache, MMU
+      1: cpu@1      NXP i.MX8MP Rev1.1 A53 at 1200 MHz at 30C
+
+            ID = 0, freq = 1.2 GHz: L1 cache, MMU
+      2: cpu@2      NXP i.MX8MP Rev1.1 A53 at 1200 MHz at 31C
+
+            ID = 0, freq = 1.2 GHz: L1 cache, MMU
+      3: cpu@3      NXP i.MX8MP Rev1.1 A53 at 1200 MHz at 31C
+
+            ID = 0, freq = 1.2 GHz: L1 cache, MMU
+
+cpu release
+~~~~~~~~~~~
+On i.MX8M Plus EVK, release the LAST core to run a RTOS application,
+the <core ID> is the sequence number refer to the 'cpu list':
+::
+
+     u-boot=> load mmc 1:2 C0000000 /hello_world.bin
+     66008 bytes read in 5 ms (12.6 MiB/s)
+     u-boot=> dcache flush; icache flush
+     u-boot=> cpu release 3 C0000000
+     Released CPU core (mpidr: 0x3) to address 0xc0000000
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
2.43.0

