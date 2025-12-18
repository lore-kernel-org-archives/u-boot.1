Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4444FD6ACED
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 11:45:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E2D583DBF;
	Thu, 18 Dec 2025 12:44:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0183183D8A; Thu, 18 Dec 2025 12:44:54 +0100 (CET)
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch
 [45.157.188.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32A6483D90
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 12:44:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dX83Q5SJPzGxH;
 Thu, 18 Dec 2025 12:44:50 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dX83Q1gQlzgj8; Thu, 18 Dec 2025 12:44:50 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Thu, 18 Dec 2025 12:44:43 +0100
Subject: [PATCH v2 3/3] doc: cmd: bdinfo: document options
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-b4-bdinfo-doc-v2-3-2fb328750026@cherry.de>
References: <20251218-b4-bdinfo-doc-v2-0-2fb328750026@cherry.de>
In-Reply-To: <20251218-b4-bdinfo-doc-v2-0-2fb328750026@cherry.de>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

bdinfo may also have -a, -e and -m options depending on some symbols
being set. Document all this and provide an example on how to use them
and what they typically output.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/usage/cmd/bdinfo.rst | 54 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/doc/usage/cmd/bdinfo.rst b/doc/usage/cmd/bdinfo.rst
index 2a5873a400a..b0d636d4b01 100644
--- a/doc/usage/cmd/bdinfo.rst
+++ b/doc/usage/cmd/bdinfo.rst
@@ -13,12 +13,22 @@ Synopsis
 ::
 
     bdinfo
+    bdinfo -a
+    bdinfo -e
+    bdinfo -m
 
 Description
 -----------
 
 The *bdinfo* command prints information about the board.
 
+``bdinfo -a`` command is an alias of the ``bdinfo`` command and prints all
+information about the board.
+
+``bdinfo -e`` command prints network-related information about the board.
+
+``bdinfo -m`` command prints the DRAM-related information about the board.
+
 Example
 -------
 
@@ -54,7 +64,44 @@ Example
     irq_sp      = 0x000000013edbada0
     sp start    = 0x000000013edbada0
     Early malloc usage: 3a8 / 2000
-    =>
+    => bdinfo -a
+    boot_params = 0x0000000000000000
+    DRAM bank   = 0x0000000000000000
+    -> start    = 0x0000000040000000
+    -> size     = 0x0000000100000000
+    flashstart  = 0x0000000000000000
+    flashsize   = 0x0000000004000000
+    flashoffset = 0x00000000000e87f8
+    baudrate    = 115200 bps
+    relocaddr   = 0x000000013fefb000
+    reloc off   = 0x000000013fefb000
+    Build       = 64-bit
+    current eth = virtio-net#32
+    ethaddr     = 52:52:52:52:52:52
+    IP addr     = 10.0.2.15
+    fdt_blob    = 0x000000013edbadb0
+    new_fdt     = 0x000000013edbadb0
+    fdt_size    = 0x0000000000100000
+    lmb_dump_all:
+     memory.cnt  = 0x1
+     memory[0]      [0x40000000-0x13fffffff], 0x100000000 bytes flags: 0
+     reserved.cnt  = 0x2
+     reserved[0]    [0x13ddb3000-0x13fffffff], 0x0224d000 bytes flags: 0
+     reserved[1]    [0x13edb6930-0x13fffffff], 0x012496d0 bytes flags: 0
+    devicetree  = board
+    arch_number = 0x0000000000000000
+    TLB addr    = 0x000000013fff0000
+    irq_sp      = 0x000000013edbada0
+    sp start    = 0x000000013edbada0
+    Early malloc usage: 3a8 / 2000
+    => bdinfo -e
+    current eth = virtio-net#32
+    ethaddr     = 52:52:52:52:52:52
+    IP addr     = 10.0.2.15
+    => bdinfo -m
+    DRAM bank   = 0x0000000000000000
+    -> start    = 0x0000000040000000
+    -> size     = 0x0000000100000000
 
 boot_params
     address of the memory area for boot parameters
@@ -121,3 +168,8 @@ Configuration
 -------------
 
 The bdinfo command is available if CONFIG_CMD_BDI=y.
+
+The options to bdinfo are only available if CONFIG_GETOPT=y.
+
+The ``-e`` option is additionally only available if CONFIG_NET=y or
+CONFIG_NET_LWIP=y.

-- 
2.52.0

