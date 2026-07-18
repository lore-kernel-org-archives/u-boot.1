Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF81C44521
	for <u-boot@archiver.kernel.org>; Sat, 18 Jul 2026 23:48:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31C6180433;
	Sun, 19 Jul 2026 01:48:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="DGFeU0x+";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="REqoW0Jt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 304C384105; Sun, 19 Jul 2026 01:48:04 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA3028005D
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 01:48:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4h2k413NVFz8tVt;
 Sun, 19 Jul 2026 01:48:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1784418481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=1KQI3B7BEUv7o3GUC49N2WP2b1dn+Yn8XK1cVSkm14s=;
 b=DGFeU0x+pjh3XHorHEZURO7dFhfJp/FiW60GI8rOawI05Eq1f8ATPn0jgCuYM274fI7/9E
 LCxwh7fnOcC86kIPvj5gG0UgxwOcE9dHQF1NYVaK7RBHTYwOIzJrCNHv16CHZTG4a2SeYQ
 ip1/4ARzgkTYZ8YAkMonEZVWj/6upQyQaO5GeiAiL/LZu8HHhq10ZJZNAWCr9hNOdGL6i/
 B01naPmUZXJr73l5Te5fCaO4d5GeZW5pBWcc8shFGmDvOOaD9DXE7xCLeUjboukWtZu1eI
 ydX7wr+AMolZGvglf32qXGkRfcxTZb3lEwimA+53MJjASf0aD4fU6K41ZYUkFg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1784418479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=1KQI3B7BEUv7o3GUC49N2WP2b1dn+Yn8XK1cVSkm14s=;
 b=REqoW0Jt/UfXKstbur+I9Odjmwz+VfcAcr3cfUeGGiOnKv7P6JVL9ZtiYSmLbgNx58QWir
 lcteuxJDFkN4xZQlSKfnm+Speb8UxHzst1geYCOEQSd6Bpuli0N94qSGldz+wiY765Fl4v
 gJ58F7EydHHKRlcjOltj4TJDbPU8Bc1TMuI8UhhTbtrWO11E+BgjpTlcdgIWub+RUPvLOf
 vWBzbGBqFUp3/Zob6Phs+8yGzuu/Fli00tRy386SSH/Ah3xdt7uaZe3aWVunI24Ymnkr8Z
 GLdplyByh9VFaHvCuzd7yOSiXcBsFfKTPRVsNZg2gmdIE0/VvjrNwPl+dkcb4A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] doc: board: renesas: Document Renesas R-Car Gen5 RSIP
 Cortex-R52 start
Date: Sun, 19 Jul 2026 01:46:49 +0200
Message-ID: <20260718234756.98704-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 94b542e62ce01d2231a
X-MBO-RS-META: j9qjq18k6sw7xhrfbw5f51n1jxb4tp5u
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

Document the usage of remoteproc on R-Car Gen5 RSIP U-Boot port
and clarify how to start Cortex-R52 cores from U-Boot on RSIP.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 doc/board/renesas/rcar-gen5-ironhide.rst | 216 +++++++++++++++++++++++
 1 file changed, 216 insertions(+)

diff --git a/doc/board/renesas/rcar-gen5-ironhide.rst b/doc/board/renesas/rcar-gen5-ironhide.rst
index 39fbfdbfe00..0e2ab7e577c 100644
--- a/doc/board/renesas/rcar-gen5-ironhide.rst
+++ b/doc/board/renesas/rcar-gen5-ironhide.rst
@@ -202,3 +202,219 @@ via TFTP in the same manner as the other components are downloaded:
     U-Boot on RSIP can start non-SCP cores via ``rproc`` command only
     after the SCP got started, because those cores are started via
     SCMI calls to the SCP.
+
+Cortex-R52 core start
+---------------------
+
+The U-Boot for RSIP remoteproc implementation is capable of starting
+the SCP core, and using the SCP it is capable of starting additional
+CPU cores in the SoC, Cortex-R52 and Cortex-A720AE. This subchapter
+demonstrates how to start example code on Cortex-R52 cores using the
+U-Boot on RSIP remoteproc and SCP.
+
+The piece of position independent assembler code below can be compiled
+for the Cortex-R52 core, can be started from any 4-Byte aligned address
+and prints CPU core program counter (PC) address and MPIDR onto HSCIF1.
+The MPIDR register encodes CPU cluster and core position and is useful
+when identifying on which specific CPU core does the code execute. The
+program counter (PC) can be used to determine from which address did
+the code running on the Cortex-R52 core start executing.
+
+.. code-block:: console
+
+    #define HSTDR        0xc
+    #define HSFSR        0x10
+    #define TEND         0x40
+
+    .macro mprintchr, chr, rt
+            mov          \rt, \chr
+            bl           printchr
+    .endm
+
+    .macro mprintnl, rt
+            mprintchr    #'\r', \rt
+            mprintchr    #'\n', \rt
+    .endm
+
+    start:
+
+    # Set up HSCIF1 output
+    mov                  r0,     #0xc0000000
+    orr                  r0, r0, #0x00710000
+    orr                  r0, r0, #0x00004000
+
+    # Print newline
+    mprintnl             r1
+
+    # Print PC:
+    mprintchr            #'P', r1
+    mprintchr            #'C', r1
+    mprintchr            #':', r1
+    mprintchr            #' ', r1
+    bl                   printchr
+    bl                   printchr
+    bl                   printchr
+    mprintchr            #'0', r1
+    mprintchr            #'x', r1
+
+    # Figure out start address and print it
+    adr                  r2, start
+    bl                   printhex
+
+    # Print newline
+    mprintnl             r1
+
+    # Print MPIDR:
+    mprintchr            #'M', r1
+    mprintchr            #'P', r1
+    mprintchr            #'I', r1
+    mprintchr            #'D', r1
+    mprintchr            #'R', r1
+    mprintchr            #':', r1
+    mprintchr            #' ', r1
+    mprintchr            #'0', r1
+    mprintchr            #'x', r1
+
+    # Read MPIDR
+    mrc                  p15, 0, r2, c0, c0, 5
+    bl                   printhex
+
+    # Print newline
+    mprintnl             r1
+
+    # Halt and do nothing
+    3:      wfi
+            b            3b
+
+    # Print char byte of register r1 (clobber: r9)
+    printchr:
+    2:      ldrh         r9, [r0, #HSFSR]
+            tst          r9, #TEND
+            beq          2b
+            strb         r1, [r0, #HSTDR]
+            ldrh         r9, [r0, #HSFSR]
+            bic          r9, #TEND
+            strh         r9, [r0, #HSFSR]
+
+            bx           lr
+
+    # Print hex content of register r2 (clobber: r6, r7, r8, r9)
+    printhex:
+            mov          r8, #8
+
+    1:      and          r1, r2, #0xf0000000
+            lsl          r2, r2, #4
+            lsr          r1, r1, #28
+            add          r1, r1, #'0'
+            cmp          r1, #'9'
+            # >= '9' => add 'a' - ':'
+            addgt        r1, r1, #('a' - ':')
+
+            mov          r6, lr
+            bl           printchr
+            mov          lr, r6
+
+            sub          r8, r8, #1
+            cmp          r8, #0
+            bne          1b
+
+            bx           lr
+
+Compile the piece of position independent assembler code above for
+the Cortex-R52 core as follows:
+
+.. code-block:: console
+
+    $ cpp code.s > temp.S
+    $ arm-linux-gnueabi-as -march=armv8-r -o temp.o temp.S
+    $ arm-linux-gnueabi-objcopy -O binary temp.o output.bin
+
+Load the piece of compiled assembler code into memory, and start the
+code on the Cortex-R52 cluster 0 core 0 as follows:
+
+.. important::
+
+    It is mandatory for the SCP core to be started before the following
+    procedure can be performed, because the Cortex-R52 core is started
+    by the SCP. The SCP is usually started by the default boot command
+    of the U-Boot on RSIP, which contains ``rproc start 0`` invocation to
+    start the SCP core.
+
+.. note::
+
+    The example below does use ethernet loading of the Cortex-R52
+    firmware, however, it is perfectly fine to load the firmware from
+    either HyperFlash, UFS, or other storage media.
+
+.. note::
+
+    The example below does use load address 0x86000000 for the Cortex-R52
+    firmware. This address is located in DRAM and is only ever used as a
+    temporary load buffer. The firmware is copied into the RT-VRAM which
+    is accessible from the RSIP at remapped address 0xb0200000 and from
+    the Cortex-R52 at address 0x10200000, which is also the address from
+    which the firmware executes on Cortex-R52.
+
+.. code-block:: console
+
+    # Configure ethernet address, adjust as needed:
+    => env set ipaddr 192.168.1.10
+    => env set serverip 192.168.1.1
+    => env set netmask 255.255.255.0
+
+    # Load Cortex-R52 firmware into DRAM at address 0x86000000
+    => tftp 0x86000000 output.bin
+    # Copy Cortex-R52 firmware into RT-VRAM
+    => cp.b 0x86000000 0xb0200000 ${filesize}
+    # Configure Cortex-R52 cluster 0 core 0 entry point
+    => rproc load 1 0x10200000 ${filesize}
+    # Start Cortex-R52 cluster 0 core 0
+    => rproc start 1
+
+The expected output of ``rproc start 1`` a print of both MPIDR and PC register
+values on HSCIF1.
+
+.. code-block:: console
+
+    Load Remote Processor 1 with data@addr=0x10200000 304 bytes: Success!
+
+    PC:    0x10200000
+    MPIDR: 0x80000000
+
+.. note::
+
+    The MPIDR register value above is 0x80000000 . Cortex-R52 MPIDR register
+    bit 31 is always set to 1, bitfields AFF2[23:16], AFF1[15:8], AFF0[7:0]
+    describe core affinity, in this case this is cluster 0, core 0.
+
+Other Cortex-R52 cores in other clusters can be started by passing a
+matching core number to both ``rproc load`` and ``rproc start``. Example:
+
+.. code-block:: console
+
+    => rproc list
+    ...
+    1 - Name:'rcar-rsip-cr.0-scp@c1340000' type:'internal memory mapped' supports: load start stop reset is_running
+    2 - Name:'rcar-rsip-cr.1-scp@c1340000' type:'internal memory mapped' supports: load start stop reset is_running
+    3 - Name:'rcar-rsip-cr.2-scp@c1340000' type:'internal memory mapped' supports: load start stop reset is_running
+    4 - Name:'rcar-rsip-cr.3-scp@c1340000' type:'internal memory mapped' supports: load start stop reset is_running
+    5 - Name:'rcar-rsip-cr.4-scp@c1340000' type:'internal memory mapped' supports: load start stop reset is_running
+    6 - Name:'rcar-rsip-cr.5-scp@c1340000' type:'internal memory mapped' supports: load start stop reset is_running
+    7 - Name:'rcar-rsip-cr.6-scp@c1340000' type:'internal memory mapped' supports: load start stop reset is_running
+    8 - Name:'rcar-rsip-cr.7-scp@c1340000' type:'internal memory mapped' supports: load start stop reset is_running
+    9 - Name:'rcar-rsip-cr.8-scp@c1340000' type:'internal memory mapped' supports: load start stop reset is_running
+    10 - Name:'rcar-rsip-cr.9-scp@c1340000' type:'internal memory mapped' supports: load start stop reset is_running
+    11 - Name:'rcar-rsip-cr.10-scp@c1340000' type:'internal memory mapped' supports: load start stop reset is_running
+    12 - Name:'rcar-rsip-cr.11-scp@c1340000' type:'internal memory mapped' supports: load start stop reset is_running
+    ...
+    => rproc load 10 0x10200000 ${filesize} && rproc start 10
+    Load Remote Processor 10 with data@addr=0x10200000 304 bytes: Success!
+
+    PC:    0x10200000
+    MPIDR: 0x80000201
+
+.. note::
+
+    The MPIDR register value above is 0x80000201 . Cortex-R52 MPIDR register
+    bit 31 is always set to 1, bitfields AFF2[23:16], AFF1[15:8], AFF0[7:0]
+    describe core affinity, in this case this is cluster 2, core 1.
-- 
2.53.0

