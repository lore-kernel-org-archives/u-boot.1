Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF4F606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 01:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WISIfjD6;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=RWMgt9KB;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=1zLDirL6
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7DC01810E8;
	Fri, 30 Oct 2026 01:49:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DUjpCjCjlz0d; Fri, 30 Oct 2026 01:49:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C2CBF810EA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793324979;
	b=CCUtwH8o/iWUttvI7V5XRdh1Z+YhDIaEWrXESe6m0VKYzJCtCr28I6dH61+IUA8QJ+Mo
	 pjcDrjDeVl+AwklGpNOLt34bwq4G3xeKk7Z7CWjfr3n0xHKpKvjR0wSzye30ulqnOjbfy
	 xQuNAveopmrF+BWTxcYAb+CoyVo/Bj/D/MPS2zDgeEOAxyxLNf9WC23U0IPUt3j2owzSB
	 oD1HyUrHlRsAd8TRyXOxFqrK3G+Csh2viavX39XDvtMp9q5S+L9FFSXSqDZIS/+Un5rWJ
	 8pYEH7iVjZuDA3ro5B8SR3rnR4s0CTUX6rVSzpxImFzcGhq2YpBypCzbR9RPkKQ640A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793324979;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=lX/L/zfgcxL0XlyeQ4sxknb6kudFkBQhcjzGNa8Tm7A=;
	b=V7WvepRr7rQ4vMbVZimeTdwvqakINNmXRvuhSpAT1H0GBAXrC559i/DNQsGbWCSmom8n
	 HalN2kPa7RddNCZT10dNu1Rw2A9HB5iKJtMVARqkwclpb4r8aXToeuaa/RYJAMnJUrxAE
	 VKVcikeiQLcg6YqE1gDpIDYkP4Tct00QG0PZ3TM6UR5vSm6DkiPd0L0noAtVhzMqrR37L
	 GgZcChawbmj5JwcG56YXr8+xrHy8BQUqNJ9HHtiFw0CJmFkys9iE4lwH6UmEnWeb95yrm
	 xFL8ujsOgGup66DcD3ZA4J9b3iGV38CAg4j+QbekX+e5HYwDtwEYaJ/A57XHYGPFFjg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793324978;
	bh=lX/L/zfgcxL0XlyeQ4sxknb6kudFkBQhcjzGNa8Tm7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WISIfjD60P6J+G6THdhV2cOfksI7kQy4JUBmkI/hZ2MrYD1gz51UizXr1gmWs/hSk
	 PTFyPVBE7zAzY7tXqiJpy91C0PCgeDF3BEZ4PZ7WbPvhZ3Nl/oTVY+LXQsRucuTfY4
	 UTJAusAGEsP4pnPky11DY2JVDkV+RES6Z2bcUM0sQeKMsVwzVRSXt3L6Z9PazLu+W/
	 ndhHPYxX7heQzhe/D/Fepu9Nojn6M+80tW9GCofq+fd/+Z7Wj22N1pmRf0C+gIeP1q
	 K2PFRbaFOZ4fqzhnaov3JWPN5aYVw8/qhI0aHdfp6WovgWaBTk5xLoPlxXI/tDFHml
	 9Qeb/Ei9wnwUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C2CBF810EA;
	Fri, 30 Oct 2026 01:49:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id F2DEC712
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 01:49:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with UTF8SMTP id DE8C44051A
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 01:49:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id CFSzjZLTpvl4 for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 01:49:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9E71E4051D
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793324969;
 b=RqLrA0HvjPgDZxL9zqpJ4EKhAteH0Ifj0IKckjPLEqtH/jS/tlyDRqbLvLAL+GdtHbzF
 BIP5VB9EpW2dYGjHmXF3rOFB4cw6xXoFh2DRnJZiuPy7m3O6ZANoQPHOPZyMwAX4aVEOV
 RyAhxaJvV+tbv3NRiHdDYyKcazL5FffNWchMFOXTy/jLAQPVaXu6S4IucmSDbu6svgiTl
 Jv45vgEEXAQz5yE3VVzKGlsCUYbsCRBQsOQvf9z5uaMuvuunfvmjrL6/ewz5lS36OkJKc
 We+29FyP82wIS2y6nl9J+tQ+PVK3ljKciegD3s+oTmSuufNlU12Nm/Cqiz5pXSvz/Zw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793324969;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=lX/L/zfgcxL0XlyeQ4sxknb6kudFkBQhcjzGNa8Tm7A=;
 b=FAq7ZNGE/S6KMlObfsx5pIqVChkViTclvIAmuhDfxAyEk+Gi//kPFjuqvHkbgBohu4T8
 e5kQFU5gEsVQj385YnC4+f0oP9qS0c0xFN02E7yZq1y5Z3D/cFqamB4lynVxHBrdnW/26
 nI/K8O+37Rb3k6lLCK9mt9YRCxt3EOHoyhbRp18IjKqsC0QO+hypwPLwNRU1eI0txOlHN
 GWuZi58/imPm6rZ2z5JWjyDZoR5mvch9GTuH3iDKv+sv6AVcmuh53ax5pyVv8UQiYqGzZ
 eA2Lv8RSHheKaKsQwWLNFcRkOU283pW6ALxSrI63N37nYAoyX0IMqvxF1LcVFKgTp6A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=RWMgt9KB; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=1zLDirL6; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=RWMgt9KB; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=1zLDirL6
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp2.osuosl.org (Postfix) with UTF8SMTPS id 9E71E4051D
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 01:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1793324965; bh=lX/L/zfgcxL0XlyeQ4sxknb
 6kudFkBQhcjzGNa8Tm7A=; b=RWMgt9KB8JSk6R9GlX/CzwrWjDYMlm/ol00kfv3UGY7CPtpvUJ
 CT4I9P1qbrdEjz91GNgq7UB/HZdO09gIxNyRq9wDEMP4QGcVDaBECTItv2cA07RqGYlzOTgU5P8
 clNYubNfbCGjIAyYj3/LPGuXUe87VlSaCNtPBDdtWQo2PcGaOs5NWev86HtjdqS/x/6i/jfT1dL
 J63zmRPJV6irfd5VcX8Rg+6gYBcT4Q8ysMkx/IrvzQtuZiaGp4TycFd2PxfiTopKz2uMYHptGXH
 jQY2MnMY19RtyB6WY9okb6R/la9ZOw1bC9xE+5oK3dVYkeCh7eIkKb14vLJd0Iag8fA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1793324965; bh=lX/L/zfgcxL0XlyeQ4sxknb
 6kudFkBQhcjzGNa8Tm7A=; b=1zLDirL6m7b6yPFv0b1zoqR3PuhnXmzqgLr4gN5y0duLhet8ZX
 F6nHl6xznE6ZYvnciy09kkwpJl+FK8vq6iDA==;
From: Bradley Morgan <brads@mainlining.org>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com,
	brads@mainlining.org
Subject: [PATCH 3/3] doc: arch/powerpc: add a PBL guide
Date: Fri, 30 Oct 2026 01:49:25 +0000
Message-ID: <20261030014925.32610-4-brads@mainlining.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261030014925.32610-1-brads@mainlining.org>
References: <20261030014925.32610-1-brads@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The PBL side is the fun part and most of it lives in people's heads.
Explain what the RCW and PBI files are, how to build and flash the
image, what to watch out for before somebody bricks their board, and
what it takes to add PBL support for a new one.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 doc/arch/powerpc/boot.rst    |   2 +
 doc/arch/powerpc/index.rst   |   1 +
 doc/arch/powerpc/pbl.rst     | 144 +++++++++++++++++++++++++++++++++++
 doc/arch/powerpc/powerpc.rst |   1 +
 4 files changed, 148 insertions(+)
 create mode 100644 doc/arch/powerpc/pbl.rst

diff --git a/doc/arch/powerpc/boot.rst b/doc/arch/powerpc/boot.rst
index dd01588db18..f56ce6b1712 100644
--- a/doc/arch/powerpc/boot.rst
+++ b/doc/arch/powerpc/boot.rst
@@ -38,6 +38,8 @@ u-boot.bin:
 * u-boot-with-spl-pbl.bin, when CONFIG_SPL_FSL_PBL is set and an SPL runs
   first
 
+Poking at those images has its own page, see :doc:`/arch/powerpc/pbl`.
+
 NAND
 ----
 
diff --git a/doc/arch/powerpc/index.rst b/doc/arch/powerpc/index.rst
index bfeeb1ed2bb..0663b305af3 100644
--- a/doc/arch/powerpc/index.rst
+++ b/doc/arch/powerpc/index.rst
@@ -9,3 +9,4 @@ PowerPC
 
    powerpc
    boot
+   pbl
diff --git a/doc/arch/powerpc/pbl.rst b/doc/arch/powerpc/pbl.rst
new file mode 100644
index 00000000000..6a4ca5c8fc1
--- /dev/null
+++ b/doc/arch/powerpc/pbl.rst
@@ -0,0 +1,144 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. Copyright (C) 2026, Bradley Morgan <brads@mainlining.org>
+
+Playing with PBL images
+=======================
+
+What this thing is
+------------------
+
+PBL (pre boot loader) is what the QorIQ BootROM deals with on the way to
+U-Boot. The image starts with a PBL preamble, then the RCW (reset
+configuration word), then a list of PBI (pre boot initialization)
+commands, then U-Boot itself. The BootROM applies the RCW and the PBI
+commands, then jumps into U-Boot.
+
+The RCW and PBI are just text files full of "address data" pairs and
+they live next to the board code. For example:
+
+* board/nxp/p2041rdb/p2041rdb_rcw_sd.cfg and board/nxp/p2041rdb/pbi.cfg
+* board/nxp/t102xrdb/t1024_sd_rcw.cfg and board/nxp/t102xrdb/t1024_pbi.cfg
+* board/nxp/t208xrdb/t2080_sd_rcw.cfg and board/nxp/t208xrdb/t2080_pbi.cfg
+
+The RCW file kicks off with the preamble and a header, then the RCW
+words:
+
+.. code-block:: none
+
+   #PBL preamble and RCW header for T1024RDB
+   aa55aa55 010e0100
+   #SerDes Protocol: 0x95
+   #Core/DDR: 1400Mhz/1600MT/s with single source clock
+   0810000c 00000000 00000000 00000000
+   4a800003 80000012 6c027000 21000000
+
+PBI is a straight list of register writes:
+
+.. code-block:: none
+
+   #PBI commands
+   #Configure CPC1 as 256KB SRAM
+   09010100 00000000
+   09010104 fffc0007
+
+Building one
+------------
+
+The defconfig points at both files:
+
+.. code-block:: none
+
+   CONFIG_SYS_FSL_PBL_RCW="board/nxp/p2041rdb/p2041rdb_rcw_sd.cfg"
+   CONFIG_SYS_FSL_PBL_PBI="board/nxp/p2041rdb/pbi.cfg"
+
+and a normal build takes it from there:
+
+.. code-block:: console
+
+   $ make P2041RDB_SDCARD_defconfig
+   $ make
+
+You get u-boot.pbl. On boards that build an SPL too, CONFIG_SPL_FSL_PBL
+switches the output to u-boot-with-spl-pbl.bin: the SPL runs first and
+sets up DDR, then U-Boot proper comes along. With secure boot
+(CONFIG_NXP_ESBC) u-boot.pbl is not built automatically, that image has
+to be built and signed separately.
+
+Flashing it
+-----------
+
+The offsets people actually use:
+
+SPI flash, offset 0:
+
+.. code-block:: none
+
+   => tftp 1000000 u-boot.pbl
+   => sf probe 0
+   => sf erase 0 100000
+   => sf write 1000000 0 $filesize
+
+SD/MMC, offset 0x1000, which is block 8:
+
+.. code-block:: none
+
+   => tftp 1000000 u-boot.pbl
+   => mmc info
+   => mmc write 1000000 8 441
+
+NAND, offset 0:
+
+.. code-block:: none
+
+   => tftp 1000000 u-boot.pbl
+   => nand erase 0 100000
+   => nand write 1000000 0 $filesize
+
+The block count for mmc write and the erase sizes depend on the image
+size and the flash geometry, adjust them for your board. The board
+README files have working numbers, for example
+board/nxp/p2041rdb/README.rst.
+
+Having fun with it
+------------------
+
+Things worth knowing before poking at the RCW:
+
+* The RCW sets the SerDes protocols and the clock setup. Change it wrong
+  and the board comes up dead with no console to tell you why. Keep a way
+  back in, either a boot switch to another medium or JTAG.
+
+* PBI is just register writes, so setting up an extra LAW or bringing an
+  I2C device out of reset before U-Boot starts is a one liner. Watch the
+  addresses, a stray write can take the boot down just as fast.
+
+* Try the image from RAM first. tftp it and run it from an already
+  running U-Boot, or load it over JTAG. A dead SPI flash is a lot less
+  fun than a dead RAM image.
+
+* No board at hand? qemu-ppce500 runs U-Boot fine, no PBL involved, see
+  :doc:`/board/emulation/qemu-ppce500`.
+
+Adding PBL support for a board
+------------------------------
+
+* copy the RCW and PBI files from a board with the same SoC and boot
+  medium into board/<vendor>/<board>/
+
+* set CONFIG_SYS_FSL_PBL_RCW and CONFIG_SYS_FSL_PBL_PBI in the defconfig
+  to point at them
+
+* turn on CONFIG_RAMBOOT_PBL and pick the boot medium in the defconfig
+
+* decide if you want an SPL stage. Without CONFIG_SPL_FSL_PBL the image
+  is a single u-boot.pbl and U-Boot runs from whatever memory the PBI
+  set up. With it, u-boot-with-spl-pbl.bin has the SPL doing DDR init and
+  U-Boot proper running from DDR.
+
+* check CONFIG_TEXT_BASE. Do not just copy it from another board, the
+  single image case usually runs from on chip SRAM.
+
+* try it over JTAG or tftp before writing it to the real medium
+
+doc/README.pblimage has the image format details and the older flashing
+examples.
diff --git a/doc/arch/powerpc/powerpc.rst b/doc/arch/powerpc/powerpc.rst
index 1bc5f629ce3..c058d519dd0 100644
--- a/doc/arch/powerpc/powerpc.rst
+++ b/doc/arch/powerpc/powerpc.rst
@@ -159,6 +159,7 @@ More reading
 ------------
 
 * :doc:`/arch/powerpc/boot`
+* :doc:`/arch/powerpc/pbl`
 * doc/README.pblimage
 * doc/README.ramboot-ppc85xx
 * doc/README.mpc85xx-sd-spi-boot
-- 
2.47.3

