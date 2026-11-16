Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71941606A335
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 03:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FRHgKU+z;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=vDD3xIHj
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4DDF3606EA;
	Mon, 16 Nov 2026 03:30:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E5hlwSZSPNnw; Mon, 16 Nov 2026 03:30:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4AD47606E7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794799812;
	b=g18F0bUQV/KZ8TWVrs54/5gsBxVbjZQpPG33o5sxkTaKQ0GDZmdCKbLbgNkMMuFwOIHV
	 Ptv/sX5z1hXt8dcoAYoPKxNv6O4I5F6udUputahPZ5S6pqamUi9vnleicIIMeaVKCc317
	 uwDiIhVAcGpEoEg1v1Rg5WeqoLrwPCf/80Bp3v1urqd7S91AtSe/94BiVs/l9pi9El5II
	 hcEdAojud+DZV2Aij+SfG3Xtl/SxUj90l6yquaaxEgtzF1YkqKFgk2MoZbAMzIgVLk7wk
	 1zvt8sxzphUx3gfzZpzOwn1ViyV2NV7pmELlsEspbj07QHBBjbkwftT++3/OQuqYsPQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794799812;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1cOvXw0vFR1QCbQtuQEVdgi1jhqmL1sIR3vbTp/DLc8=;
	b=JmAsGtkluHoATGM8ncJvHPMhXE0D92lqoqTadM6nAH4Is16UDrPl6ocG9ZjuXru7fzCa
	 xwBIQ/L6dupu3NdUFN3LuUpDpDEIWp5p8xAMdXjfT2245Hu7DUKv72AmZHfQSaIaJei75
	 esCCLu21Bu5NBv3wS2w6/zgVBRA0ZesdBhwd/o4xwIM3koRr6VrD79gYQ/C3CFo4rGZn6
	 d+7JwQXvtKPo/i85DF3Fsj2V/itVpMiw9roQKyNkoewIpUPRMtTrGKm6QjMP8j6EvtWW5
	 uVxnbJZkyT0vkFbLaMIbY3KnEUYFl0aDO1vCzy7CNUtp1MfXWuSrvRYyPXRb7F9QcCA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794799812;
	bh=1cOvXw0vFR1QCbQtuQEVdgi1jhqmL1sIR3vbTp/DLc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FRHgKU+zTf93MwyRA4r8Vix34uIFBU8w5g6P16GmfiePA+XwK4s0rF+ej/EcQlX8k
	 Bdu2qdjjpB3xHcFmtlmyfNZk11ePaghQf6/gxBfrAAczl+MfksT4Kzk/BDURfjiumb
	 14mUgFVKk798rHXo4RYsZ5+rxXCOkdPGm3aGlsCgRc9xF+AmjT7xZDTXuc4fTOU16V
	 Ws22DD0rprKNxw8ZkqgfCNXJc40avimorQP70zP/mxoW6dxBflycDWUfIriFWXiczJ
	 hm1qoY2Od0huOfkcXL7AYIkDXHiX2bpQTlQfFTIJ9Ew7ZdlN2n67Kf4WoRcS7pS67n
	 4BSL1WUxF7Ttw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4AD47606E7;
	Mon, 16 Nov 2026 03:30:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9ABCF1A6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 03:30:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 98CBE4008B
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 03:30:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id arZSMPHhGgVY for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 03:30:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 684614008E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::103; helo=mout-p-103.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=vDD3xIHj
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 684614008E
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 03:29:59 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jSYJh2VM2zKmHQ;
 Mon, 16 Nov 2026 04:29:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794799796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1cOvXw0vFR1QCbQtuQEVdgi1jhqmL1sIR3vbTp/DLc8=;
 b=vDD3xIHjdAiH+DLVW92t9IQZpvjiJM6RmNVAwvLRKLPR9ReWPSryrIsxOysjzQn9O4p/d4
 IY0lOwyTrvpPju8cpXHV+ulssgenBF/t6GlD5ueyBf2esGPdLMSo1nsuaPPrI9F7nD9Nuu
 IT9ksfPN2ZQdaSTZNNli54v4ryDYtqOOORZpBZAgrpMlkXbdr9K4ZlQ/q+SxiwnAqPCUcs
 IKzlKIeg/B6Ggmf8OlOL00XQMnnJ03U9QLplNS5NhO9osb/SnYCbMHg3Uj8ubCSu5OyrDs
 p80DOvWy7KoaD4Gja5lWzjBtOCiffd0JjLrPBvPXT3WLYbUF9VinVKqmhjNEjg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/5] doc: board: renesas: Document Renesas R-Car Gen4
 Cortex-R52 start
Date: Mon, 16 Nov 2026 04:29:06 +0100
Message-ID: <20261116032949.3145053-2-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116032949.3145053-1-marek.vasut+renesas@mailbox.org>
References: <20261116032949.3145053-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 9b34db5a4131cd0070a
X-MBO-RS-META: dbqithog5qqeimus8xt9t5mad4du8bdg
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Document the usage of remoteproc on R-Car Gen4 U-Boot port
and clarify how to start Cortex-R52 cores from U-Boot on
Cortex-A76.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 doc/board/renesas/rcar-gen4-sparrow-hawk.rst | 198 +++++++++++++++++++
 1 file changed, 198 insertions(+)

diff --git a/doc/board/renesas/rcar-gen4-sparrow-hawk.rst b/doc/board/renesas/rcar-gen4-sparrow-hawk.rst
index 6b9e21bdf1b..08f6111a571 100644
--- a/doc/board/renesas/rcar-gen4-sparrow-hawk.rst
+++ b/doc/board/renesas/rcar-gen4-sparrow-hawk.rst
@@ -110,3 +110,201 @@ The bundling is done using U-Boot ``mkimage`` tool:
         -y /path/to/arm-trusted-firmware/build/rcar_gen4/*/bl31.bin \
         -Y 0x46400000 \
         /path/to/output/fitImage
+
+Cortex-R52 core start
+---------------------
+
+The U-Boot for Cortex-A76 remoteproc implementation is capable of
+starting additional CPU cores in the SoC, Cortex-R52 and Cortex-A76.
+This subchapter demonstrates how to start example code on Cortex-R52
+cores using the U-Boot on Cortex-A76 remoteproc.
+
+The piece of position independent assembler code below can be compiled
+for the Cortex-R52 core, can be started from any 4-Byte aligned address
+and prints CPU core program counter (PC) address and MPIDR onto HSCIF0.
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
+    # Wait a bit before printing to avoid corrupting active HSCIF output
+            mov          r0,     #0x00040000
+    1:      sub          r0, r0, #0x00000001
+            cmp          r0,     #0x00000000
+            bne 1b
+
+    # Set up HSCIF output
+    mov                  r0,     #0xe0000000
+    orr                  r0, r0, #0x06000000
+    orr                  r0, r0, #0x00500000
+    orr                  r0, r0, #0x00040000
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
+.. note::
+
+    The example below does use ethernet loading of the Cortex-R52
+    firmware, however, it is perfectly fine to load the firmware from
+    either SD card, NVMe, or other storage media.
+
+.. note::
+
+    The example below does use load address 0x4b000000 for the Cortex-R52
+    firmware. This address is located in DRAM and may be overwritten by
+    other software while the Cortex-R52 is running.
+
+.. code-block:: console
+
+    # Configure ethernet address, adjust as needed:
+    => env set ipaddr 192.168.1.10
+    => env set serverip 192.168.1.1
+    => env set netmask 255.255.255.0
+
+    # Load Cortex-R52 firmware into DRAM at address 0x4b000000
+    => tftp 0x4b000000 output.bin
+    # Configure Cortex-R52 cluster 0 core 0 entry point
+    => rproc load 0 0x4b000000 ${filesize}
+    # Start Cortex-R52 cluster 0 core 0
+    => rproc start 0
+
+The expected output of ``rproc start 0`` a print of both MPIDR and PC register
+values on HSCIF0.
+
+.. code-block:: console
+
+    Load Remote Processor 0 with data@addr=0x4b000000 324 bytes: Success!
+
+    PC:    0x4b000000
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
+    0 - Name:'rcar-apmu-cr52.0-apmu@e6170000' type:'internal memory mapped' supports: load start stop reset is_running
+    1 - Name:'rcar-apmu-cr52.1-apmu@e6170000' type:'internal memory mapped' supports: load start stop reset is_running
+    2 - Name:'rcar-apmu-cr52.2-apmu@e6170000' type:'internal memory mapped' supports: load start stop reset is_running
+    => rproc load 2 0x4b000000 ${filesize} && rproc start 2
+    Load Remote Processor 2 with data@addr=0x4b000000 324 bytes: Success!
+
+    PC:    0x4b000000
+    MPIDR: 0x80000200
+
+.. note::
+
+    The MPIDR register value above is 0x80000200 . Cortex-R52 MPIDR register
+    bit 31 is always set to 1, bitfields AFF2[23:16], AFF1[15:8], AFF0[7:0]
+    describe core affinity, in this case this is cluster 2, core 0.
-- 
2.53.0

