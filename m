Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B7F606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 02:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EwBZB6zV;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=WTrX8ryH;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=hf9PQK3g
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 71B9D810A2;
	Fri, 30 Oct 2026 02:08:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U-8j62bQcDuR; Fri, 30 Oct 2026 02:08:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E0F0D810F2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793326124;
	b=KV1+5z0SyK9NP+L9LMJQ8mGavumGGEdANYOMVHfLoHOcNVbFiWhrK7W8cb/yXplmUO45
	 4fi1bHme0frA1WHoi0HudqNulhi3tlasArzeCSbfJD16PG/XfTC8PSxaF77CZrl5VTJBq
	 X0eFNc8J7Mh5YkybM6akjy/NLvfSnq/YwD7yme47Ym6dE/5cs33/RiKu1zrEF409KyCUT
	 4uKNBY/X1uEE2nXumwfb7TBxFCszW0k+pjKZhF7VPuTdiKiycgyKjL2W0SlBv26Opf3yZ
	 yhtAAVBQ3JQ8kKFj5Fy9lObT+rJ4XBp9kN3VZtJk61kx4KnG59LVkA+5bEcbipviw8A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793326124;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=g9hUIm/P3buDF5eKrt2A9K0w5um8JBSWXvMasOfYNTk=;
	b=EFHobVQGJogJFM7pL9amEpXxGmzVPscCHMJe+owq9Roj/Du6gyKKReHfbNa26mGNRvnH
	 ItoXAu5cbszOxOJ18l68QBygKK498k9Yl1TyWs2/oG3aKjyqK7ozgQPhiNrxfUEKtM3H/
	 1xLZ+P53C8wwPx228O6ONkWB64JqmVeDlGp94k1477bG64sad13Ql3Y/ugBm9nbvKApRK
	 N8Rfv9XN+GpbXtjm5DyrvxLrNYiehakr2uqGx6y/sNxMQizadNBnNZM3ly9i5oC/rOuFp
	 unahWvTaGEpt5JtRWroebs4Kb4oZNwzNyUEYI2HSpE1pa0q+/ugMunZJvSXW88lm+cw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793326124;
	bh=g9hUIm/P3buDF5eKrt2A9K0w5um8JBSWXvMasOfYNTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EwBZB6zVY7bjYy5WfZDG7E1AhmHAHellW1mIA0x7JLpmffPpuojx5LG6Y4NqiZTzB
	 biKYyGVuTyayQG3I9rUfefs48l0xvY7xRyp7yDk7JAM6e1ulvA6oy23/slMHOyuvl/
	 eC8qgQcBlsjYzbkJ3IP623X+tpIf0aVO8iTEuuIF+VNvxR9NQwUDNhoiYzghhPo5x8
	 MttBK7HhYfRlQn+SdMAdqrtK+0Uu+yYsoqXSIcTqMMoOTMAAv4YtxPrWd+VGv8RwYI
	 GNqp3Oh1mwj0MjTWzr6djRFVHeZHdRHcX8KbRzno6B0XQm69Os3VJ1588U37KTJa8A
	 hXSr7fUt7mAUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E0F0D810F2;
	Fri, 30 Oct 2026 02:08:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id 5DBCFD41
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 02:08:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with UTF8SMTP id 4E176405E8
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 02:08:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id mLdPZjStg0PL for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 02:08:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 34059405A1
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793326116;
 b=ZbikN8bNRhn/W69ebQPuodRYaI9RhxB+4IfsgFN2K+jOCM6oIsdFAlPDob1yyXZ1u/CW
 NIIG1vwqY7pWp4kNDOQDkaTzw83lfT/ulLx4MZZg60emtqcXXDp3RBJ5lYjxs+g9y6/87
 +QB44UK+jciSb5wS2/8yssS/kNlJpORmwHLvUafUW0ZF1feUE81qe69Y6bDN7pC3hfccw
 QuPon97oQdQB35vguFuakmGkZ0D3X2seAycAQWGH/Awm4eEZzeA5oUfYDyHPQ1FyiyRXd
 LBVRwqFDg/2O7w+yD7aTpqMu0bA+NIHLCWsS72b72vgKTK6eOYGtDiD7fTKJW8B0e9w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793326116;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=g9hUIm/P3buDF5eKrt2A9K0w5um8JBSWXvMasOfYNTk=;
 b=LDB/wZwJEyCKprYj3MTrJ1pEjTd/qaJ/eHaIZXZlozE+Es196VLxmxNjd5/zoowHhx6r
 20sKeA3QKxVapwyI/GEgkuy2EFQK0ScV4W+ADxe2covnui6hvg0Qq+X/yrcgzc0V2jzsL
 O6hlsn89iRZhRC2aq9Y47nA+Rez/RriTQQ1SgFHP76tfv7cZED2VvqMrUdGBu1JOJo3yq
 fgznk3rmgExoXxTU3qp0KOH125YIKQHo3ME3DUls6fJB6HUKmeQMTi1jDalneTrFNWMXw
 Ls8UM+VEEQHm2QQ38xbmT9XAt+geWdAzTYt8MLUBLYOvE7aHv/yEE+xExMLSQSPK3wQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=WTrX8ryH; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=hf9PQK3g; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=WTrX8ryH; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=hf9PQK3g
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp4.osuosl.org (Postfix) with UTF8SMTPS id 34059405A1
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 02:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1793326111; bh=g9hUIm/P3buDF5eKrt2A9K0
 w5um8JBSWXvMasOfYNTk=; b=WTrX8ryHzVu+A5PekxBa+gPAu/1eMb/pWvwtegnf0SsnQQ0Omw
 p4nF5C5UKPC84ogRRRIzTNNbpT902EVv3x2hc28KWVHc/t9zEJdDPe90NueEDasD4quGdsrvPht
 3MJvh4sd9idsVKIxEixV9SoYA347zLDGg5QlfXSyY9vWP4SoABfJfx3tKK7cOgN0MawgexK8Ha/
 xmkAjhE8NVf72Xx9IkozOQm0RjpTb+cJiKstq3whiaQi/sCmDvsQa2ALo3nvuOdb6hpM8vBFAAq
 7nvFtoxNINq/97BZNI7IW8Y2VOND5Dz0+3h1B99AR2RiJn+6tTu2phP7s93njar+81w==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1793326111; bh=g9hUIm/P3buDF5eKrt2A9K0
 w5um8JBSWXvMasOfYNTk=; b=hf9PQK3gchO4OMmZy9S2B6y26YlNAA+5rg5HyaYQTP+Tqh8fMe
 V9oOJDRXeCMvut+qWWWEJnKO5NC096NHiJCg==;
From: Bradley Morgan <brads@mainlining.org>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com,
	brads@mainlining.org
Subject: [PATCH v2 3/4] doc: arch/powerpc: add a PBL guide
Date: Fri, 30 Oct 2026 02:08:30 +0000
Message-ID: <20261030020832.26572-4-brads@mainlining.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261030020832.26572-1-brads@mainlining.org>
References: <20261030020832.26572-1-brads@mainlining.org>
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
 doc/arch/powerpc/pbl.rst     | 145 +++++++++++++++++++++++++++++++++++
 doc/arch/powerpc/powerpc.rst |   1 +
 4 files changed, 149 insertions(+)
 create mode 100644 doc/arch/powerpc/pbl.rst

diff --git a/doc/arch/powerpc/boot.rst b/doc/arch/powerpc/boot.rst
index f72ed8d8304..48f044a3f78 100644
--- a/doc/arch/powerpc/boot.rst
+++ b/doc/arch/powerpc/boot.rst
@@ -40,6 +40,8 @@ to the build:
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
index 00000000000..a533969d5e6
--- /dev/null
+++ b/doc/arch/powerpc/pbl.rst
@@ -0,0 +1,145 @@
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
+The RCW and PBI are text files that live next to the board code. The
+RCW file is a pile of 32 bit words with the preamble and header first,
+PBI is a list of address data pairs. For example:
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
+   => mmc write 1000000 8 672
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
index 0f1f0148252..8ce28569ebe 100644
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

