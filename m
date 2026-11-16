Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D876A606A881
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 03:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jRDnDyIY;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=CAsEwX+/
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B3BDC80D91;
	Mon, 16 Nov 2026 03:30:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1vxcS_kX6RJa; Mon, 16 Nov 2026 03:30:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9CC6D80DE1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794799810;
	b=oakZGgwFAgVDMpZGlYhtIx29S+mcBcCyOvrbrglUfwPc5RhfnZZD/2UXEm0h9TEYgUa7
	 FRCqTmMrUlk4XJ498/xS16AToPDl8lpI5f7KHYQFpXe4Vcc2GqlyfEIEz7jzsHLWIao71
	 OOl8tt5cwbJV71ziFSW3/5ONYUOumJqBuDVbzdjA8XYna1GDQaihnL7YVe76DQyvuylxP
	 AddHyuzFijcYW0kzJ76b4lAgntvWO611nlGEhaSXiOLH0iAPZlzqhVPu0ulomLHZzlQhk
	 iGlsPc28uz8Zsu0vzNhxI7t2Qc0Fd+t+H2LutnU41WP2sRAGlJWCb/oq20OlbT4MifA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794799810;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=w0Vi6X0Y52d38kUwvhSupS+YB2Wnw/UWiQXVYBAsie8=;
	b=m+XgpmUujMHAm4kQyH2xcYJtchwrq8kbgDY5ptZhu55RGBJfC0/u1/heKhecWo+/zfKX
	 CycbEaU+sxLJAj5iX9EZMRnsVaHEMS5TqpYPga0fao9amU82hkypHMUtCgvmWnqWfZ0DH
	 QHUBhfrO2qYNM15IU9Vbzq+OXxmsncJjnVrcXCttoLnpCrLHqMwEQ7l+nLA4Qifd0hqOP
	 sMxK8i77y4x3LWHV8YZEyjlKREFkURhVjHdU07bTJ0sheRq70RmF31Oc09jH9b0JFThGQ
	 Jj8Cp0xdAKTwDSbaV0nowltK3bTaoaMgmyPRCWKJOJOvw6xmA56DHj2ejRvKemjur6g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794799810;
	bh=w0Vi6X0Y52d38kUwvhSupS+YB2Wnw/UWiQXVYBAsie8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jRDnDyIYEZIaJjBccwz8nh2wo5CW9CCzVMUDcW8hLjBJXscW/5epyGbNk56uE1dxT
	 ZW2kJiROUKAz2ENXLPjMtqanPJa+X/jZ/t1G27f6mp2alznlaxQQS5JzNGImi9ieRu
	 7hklBvDBMQ3nuLnV+2Gy/WvZLK3B/1J7HXpAhysz48Vm3VXGIXCNuyBc8aRDEHnf5W
	 PQ0IseSR4Pzr4I5fo3HPol/KWvT8JqQ3VDLbBeCj4aifAUODJrr+XQ2l+3FCVEW4+0
	 nixisdc/LBAuLg6PRRZaWRMBHxHLViaRi8/o+x3tJjuS5ob3q5QDYTNBhbNuyh2rC/
	 jAhLfmW6SIkcg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9CC6D80DE1;
	Mon, 16 Nov 2026 03:30:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3D1BF4AB
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 03:30:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2F2CF4008B
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 03:30:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id npVwz3DRUDBQ for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 03:30:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3745E4008C
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::101"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=CAsEwX+/
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3745E4008C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 03:30:01 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jSYJk35m2z8vWy;
 Mon, 16 Nov 2026 04:29:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794799798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w0Vi6X0Y52d38kUwvhSupS+YB2Wnw/UWiQXVYBAsie8=;
 b=CAsEwX+/KeCVMV0kel8F+KOJZUrvmPBHrfQyywz/nim73Ty+4y15nhE5HmEcfp1U6Y9DLK
 0svJi1JOtS026ix3c1OJKeLsWTEpq3KjSoEUqAiKMimd9G0efBELi0/3dxtC2+dBcmf6/8
 cMl5D5wJgEpos7Dbzbr2WREod71eulqrm8L4LaqzT5V1F5gNrs8YVOYXCrNrDceGSiwsmL
 EsRRTgOVoRaIep9MKPpdg2fuXCXPpEoqnDxG7a/hWWB3Dbkri8k0OPyBunLLw6C3M/k7s1
 LlLwgxsA1DacQ0jipN0S+YlNWrgJxmrzJT/OdvoqtXhfrvTY5LecYm4ZlR3lgA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 5/5] doc: board: renesas: Document Renesas R-Car Gen4
 Cortex-A76 start
Date: Mon, 16 Nov 2026 04:29:09 +0100
Message-ID: <20261116032949.3145053-5-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116032949.3145053-1-marek.vasut+renesas@mailbox.org>
References: <20261116032949.3145053-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 0cff6b3590c8d9e2f68
X-MBO-RS-META: wppmkk48eg6o9paysfwd8x6bf6tjmcmq
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
and clarify how to start Cortex-A76 cores from U-Boot on
Cortex-A76.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 doc/board/renesas/rcar-gen4-sparrow-hawk.rst | 240 +++++++++++++++++++
 1 file changed, 240 insertions(+)

diff --git a/doc/board/renesas/rcar-gen4-sparrow-hawk.rst b/doc/board/renesas/rcar-gen4-sparrow-hawk.rst
index 08f6111a571..420431d2153 100644
--- a/doc/board/renesas/rcar-gen4-sparrow-hawk.rst
+++ b/doc/board/renesas/rcar-gen4-sparrow-hawk.rst
@@ -308,3 +308,243 @@ matching core number to both ``rproc load`` and ``rproc start``. Example:
     The MPIDR register value above is 0x80000200 . Cortex-R52 MPIDR register
     bit 31 is always set to 1, bitfields AFF2[23:16], AFF1[15:8], AFF0[7:0]
     describe core affinity, in this case this is cluster 2, core 0.
+
+Cortex-A76 core start
+---------------------
+
+The U-Boot for Cortex-A76 remoteproc implementation is capable of
+starting additional CPU cores in the SoC, Cortex-R52 and Cortex-A76.
+This subchapter demonstrates how to start example code on Cortex-A76
+cores using the U-Boot on Cortex-A76 remoteproc.
+
+The piece of position independent assembler code below can be compiled
+for the Cortex-A76 core, can be started from any 4-Byte aligned address
+and prints CPU core program counter (PC) address and MPIDR onto HSCIF0.
+The MPIDR register encodes CPU cluster and core position and is useful
+when identifying on which specific CPU core does the code execute. The
+program counter (PC) can be used to determine from which address did
+the code running on the Cortex-A76 core start executing.
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
+            mov          x0,     #0x00040000
+    1:      sub          x0, x0, #0x00000001
+            cmp          x0,     #0x00000000
+            bne 1b
+
+    # Set up HSCIF output
+    mov                  x0,     #0xe0000000
+    orr                  x0, x0, #0x06000000
+    orr                  x0, x0, #0x00400000
+    orr                  x0, x0, #0x00100000
+    orr                  x0, x0, #0x00040000
+
+    # Print newline
+    mprintnl             w1
+
+    # Print PC:
+    mprintchr            #'P', w1
+    mprintchr            #'C', w1
+    mprintchr            #':', w1
+    mprintchr            #' ', w1
+    bl                   printchr
+    bl                   printchr
+    bl                   printchr
+    mprintchr            #'0', w1
+    mprintchr            #'x', w1
+
+    # Figure out start address and print it
+    adr                  x2, start
+    bl                   printhex16
+
+    # Print newline
+    mprintnl             w1
+
+    # Print MPIDR:
+    mprintchr            #'M', w1
+    mprintchr            #'P', w1
+    mprintchr            #'I', w1
+    mprintchr            #'D', w1
+    mprintchr            #'R', w1
+    mprintchr            #':', w1
+    mprintchr            #' ', w1
+    mprintchr            #'0', w1
+    mprintchr            #'x', w1
+
+    # Read MPIDR
+    mrs                  x2, mpidr_el1
+    bl                   printhex8
+
+    # Print newline
+    mprintnl             w1
+
+    # Prepare core power off, used by rproc stop
+    mov                  x2, #1
+    msr                  S3_0_C15_C2_7, x2
+
+    # Halt and do nothing
+    3:      wfi
+            b            3b
+
+    # Print char byte of register w1 (clobber: w9)
+    printchr:
+    2:      ldrh         w9, [x0, #HSFSR]
+            tst          w9, #TEND
+            beq          2b
+            strb         w1, [x0, #HSTDR]
+            ldrh         w9, [x0, #HSFSR]
+            bic          w9, w9, #TEND
+            strh         w9, [x0, #HSFSR]
+
+            ret
+
+    # Print hex content of register x2 (clobber: x6, x7, x8, x9)
+    printhex16:
+            mov          x8, #16
+
+    1:      and          x1, x2, #0xf000000000000000
+            lsl          x2, x2, #4
+            lsr          x1, x1, #60
+            add          x1, x1, #'0'
+            cmp          x1, #'9'
+            # >= '9' => add 'a' - ':'
+            blt          4f
+            add          x1, x1, #('a' - ':')
+    4:
+            mov          x6, lr
+            bl           printchr
+            mov          lr, x6
+
+            sub          x8, x8, #1
+            cmp          x8, #0
+            bne          1b
+
+            ret
+
+    # Print hex content of register x2 (clobber: x6, x7, x8, x9)
+    printhex8:
+            mov          x8, #8
+
+    1:      and          x1, x2, #0xf0000000
+            lsl          x2, x2, #4
+            lsr          x1, x1, #28
+            add          x1, x1, #'0'
+            cmp          x1, #'9'
+            # >= '9' => add 'a' - ':'
+            blt          4f
+            add          x1, x1, #('a' - ':')
+    4:
+            mov          x6, lr
+            bl           printchr
+            mov          lr, x6
+
+            sub          x8, x8, #1
+            cmp          x8, #0
+            bne          1b
+
+            ret
+
+Compile the piece of position independent assembler code above for
+the Cortex-A76 core as follows:
+
+.. code-block:: console
+
+    $ cpp code.s > temp.S
+    $ aarch64-linux-gnu-as -march=armv8-a -o temp.o temp.S
+    $ aarch64-linux-gnu-objcopy -O binary temp.o output.bin
+
+Load the piece of compiled assembler code into memory, and start the
+code on the Cortex-A76 cluster 1 core 1 as follows:
+
+.. note::
+
+    The example below does use ethernet loading of the Cortex-A76
+    firmware, however, it is perfectly fine to load the firmware from
+    either SD card, NVMe, or other storage media.
+
+.. note::
+
+    The example below does use load address 0x4b000000 for the Cortex-A76
+    firmware. This address is located in DRAM and may be overwritten by
+    other software while the Cortex-A76 is running.
+
+.. note::
+
+    The example code does invoke ``msr S3_0_C15_C2_7, x2`` instruction with
+    register ``x2`` set to ``1`` before invoking the ``wfi`` instruction.
+    This sets per-CPU ``CPUPWRCTRL`` register bit 0 ``CPUPWRCTLR_PWDN``,
+    which must be set on the CPU core in order to power off the CPU core
+    when the ``wfi`` instruction is invoked. This setting is mandatory for
+    the correct behavior of ``rproc stop N`` of the CPU core N, in case of
+    this example, that is ``rproc stop 6`` for CPU core 6. In case the bit
+    ``CPUPWRCTLR_PWDN`` is not set, the CPU core remains in power on state.
+
+.. code-block:: console
+
+    # Configure ethernet address, adjust as needed:
+    => env set ipaddr 192.168.1.10
+    => env set serverip 192.168.1.1
+    => env set netmask 255.255.255.0
+
+    # Load Cortex-A76 firmware into DRAM at address 0x4b000000
+    => tftp 0x4b000000 output.bin
+    # Configure Cortex-A76 cluster 1 core 1 entry point
+    => rproc load 6 0x4b000000 ${filesize}
+    # Start Cortex-A76 cluster 1 core 1
+    => rproc start 6
+
+The expected output of ``rproc start 6`` a print of both MPIDR and PC register
+values on HSCIF0.
+
+.. code-block:: console
+
+    Load Remote Processor 6 with data@addr=0x4b000000 448 bytes: Success!
+
+    PC:    0x000000004b000000
+    MPIDR: 0x81010100
+
+.. note::
+
+    The MPIDR register value above is 0x81010100 . Cortex-A76 MPIDR register
+    bit 31 is always set to 1, bitfields AFF2[23:16], AFF1[15:8] describe
+    cluster and core affinity, in this case this is cluster 1, core 1.
+
+Other Cortex-A76 cores in other clusters can be started by passing a
+matching core number to both ``rproc load`` and ``rproc start``. Example:
+
+.. code-block:: console
+
+    => rproc list
+    ...
+    3 - Name:'rcar-apmu-ca76.0-apmu@e6170000' type:'internal memory mapped' supports: load start stop reset is_running
+    4 - Name:'rcar-apmu-ca76.1-apmu@e6170000' type:'internal memory mapped' supports: load start stop reset is_running
+    5 - Name:'rcar-apmu-ca76.2-apmu@e6170000' type:'internal memory mapped' supports: load start stop reset is_running
+    6 - Name:'rcar-apmu-ca76.3-apmu@e6170000' type:'internal memory mapped' supports: load start stop reset is_running
+    => rproc load 5 0x4b000000 ${filesize} && rproc start 5
+    Load Remote Processor 5 with data@addr=0x4b000000 448 bytes: Success!
+
+    PC:    0x000000004b000000
+    MPIDR: 0x81010000
+
+.. note::
+
+    The MPIDR register value above is 0x81010000 . Cortex-A76 MPIDR register
+    bit 31 is always set to 1, bitfields AFF2[23:16], AFF1[15:8] describe
+    cluster and core affinity, in this case this is cluster 1, core 0.
-- 
2.53.0

