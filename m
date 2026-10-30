Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9EB606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 01:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WCwyv/zf;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=g1A3tqM4;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=6wU/OZ4W
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 78FA1810C6;
	Fri, 30 Oct 2026 01:49:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SxocKnAMZywz; Fri, 30 Oct 2026 01:49:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B0357810DF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793324976;
	b=jHfIZdh+A+pAIATMiQOaFll52zVuVy6x3/A30YUfhSpxmTIIUq/6eA2dezoykfNpTuvj
	 +7vw639zLKqNlu1SL7xkhmBnlEwKc1LFS1erJSL86/xiFPC80hXAH3+3OROrpNBaA7vwO
	 kB2PqsNIBwmbFlIRa/D3pYUnm5ZGm8MKIK/Cjis1A4xF9X6xqqIbY8BUv/C/us0SvRxtE
	 9LnVjE9KoAvBfli0N6Xi+yIn5YUuB3d2xdFlwUDzn3Gco7bTaU6T2F3B2qoss0Q2nPGq8
	 zEOx2TYun0I3DEw1svclABcFcH3YsWT3j9TeQroudfQ1fTJEBnfDUuccVgAbVvH7tGA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793324976;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=fGkzDeJnSMegJqgqLFsS4Mug9xCCwcjk37YV5+KtAFQ=;
	b=DOWVkWdwYC8z6fdJ7VqxF+RM21Jr/42mvuIXURs8VX48E8Mk20Gkm5O5C29v0yo3Psu4
	 nz1P3CbyfJO8bE9EyAAtuHUGaXKLMUoNIdJaIYYK87FkGhTH+hwODXierUfPYljMJOprx
	 sht3rW76wNPvawg/+XV5MGDcFTVPmqv2fCoXFJSXmjdU9Zf87mxLhjh3q22R1/RfPVlOI
	 gyeEYL5Dqr12Jxqec6Eb6bWf/cmWyayxYM/Xgqgou1fgwBGCJ8oNaytfE8EoS0EXqISkZ
	 rJ0/sYIrg/z2ALzWr63ef2AoYjeMjKtgsRL9Yu1+rGgZSiQW6vKE2DlclAOSWkYSETQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793324976;
	bh=fGkzDeJnSMegJqgqLFsS4Mug9xCCwcjk37YV5+KtAFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WCwyv/zfOLJdhjIuuYilx0eTJf8tmvJ86UshPJQZMpng39ZCdDBg7WAhvW4nGbKmP
	 s/UHPe7nX0UFFT+n0kjnF94v2QrOiF/TGlRY729PnihgixIWViK2t0cOJ1w1JhR2P5
	 Vrdd4NnNxkwp/C9ogbZ6lZxYtjEZZCMmoiR8ovxmDNvJYjzpk1njFMmjEPKJ9hMW1x
	 d5KKIjkYM3bWeNGfo3Ui1J7l9olOSjkyJ5g3PK6VgA643FoZ/pif3mctUq7R9TYEZQ
	 eZsyZ0Jwl110ye7BYe9E+OZ4WR3ZcdhMIeQ+2MkrNQArQrdvQVMs23CKSafRawaSah
	 tiCqAEDYtlsog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B0357810DF;
	Fri, 30 Oct 2026 01:49:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id C38D7712
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 01:49:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with UTF8SMTP id B58CE4051A
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 01:49:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id tQmScs2WDeWe for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 01:49:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9E7604051E
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793324969;
 b=VEqb2PDuSvtY9B57hMvdrnJQ5HifQf2GzXvB/VTgtkFINW5Yeh9RrAx6I/OnDtW2W9iL
 kzI+YZ8CudMXqkkY67WoLGiT3oJMQboeKpY/n7jNM9OzM48UNO5W+b0QNFSQx4rZzd0FD
 CNrRw+cKmoSvvM1M5GWH2DtdzHMAn9EOXR6Nafl2YuhTZHeRBN6/hESomcEyZ2sfaGu9o
 +uJhvDg1v1Zqte1sbX2jw/Xad231gLLUdJfpvi+3CPywHBgL+xEgYPWqxaaUWdILfGRlF
 DPNDEo5TPQwg5vwlass+OBPHBFWCFKcnikjdSlAZfVoOG1+VB14BK+dYuhQFazoVXmQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793324969;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=fGkzDeJnSMegJqgqLFsS4Mug9xCCwcjk37YV5+KtAFQ=;
 b=O1ydOZZhYS4SRN/Qf865/OLRIjPO5mACiCs7IJfTSO3NrgIFY95BTi14D/UW6x0gtM3m
 +1ub1oXGUWHQIJZEuieSmYn/YDfQX6AzADkJB98J262A8NAUdslpnanD14JFBQ0jb/kZ3
 lmI1plmuQeezSRC1RH86K4qmPgBWRhrvbfNo+4wIlkaHdSWKB8n48POg8ZbXDbef04YGi
 +LD1ZtCcs9Q3FdHplmzX+kmXUkaHjOP++8N8Au65yiJ7E656fiEA1di+mQuu0FKQVoxGF
 S537+zT4WSgq2hfxV+RE0m5+3OF10zROdq3ziD0NMmAqQ3TcFyXKnu+Bdgyn8BgrKxw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=g1A3tqM4; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b="6wU/OZ4W"; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=g1A3tqM4; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=6wU/OZ4W
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp2.osuosl.org (Postfix) with UTF8SMTPS id 9E7604051E
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 01:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1793324964; bh=fGkzDeJnSMegJqgqLFsS4Mu
 g9xCCwcjk37YV5+KtAFQ=; b=g1A3tqM4eYExbVC8zFmhWZGnp75ieBjaomd1ZmglPvQ3GXjCa1
 v8IDhxre7NMVM5Y59KOJFeVZEKMKidBweYAuijd5Gvt3wm/Hfq+y2X9TDeWaSH5BE2QThQ03fov
 STqfVgXZlSOQb1EBo12kHxctWNFjpJbVRzTGx+x/2phLieNWS22sp/Yz7ZOBn+JOYoK0vRg+xcu
 yHQGJZn2ARLeR6rNF80D5mUoR5k9NjUIsfOmHz7sbfe/UciwWugUtSw8N5MUmMkIOdJYLWmH8Bb
 MDkwMtUnm1GuxcQkd514P094/agfe1E3guPwFiPJu9xhUNzCDvdG/iVH94gG+vFbDvg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1793324964; bh=fGkzDeJnSMegJqgqLFsS4Mu
 g9xCCwcjk37YV5+KtAFQ=; b=6wU/OZ4WYF1KOIVbkB05P6Rwi/ymaaj5yknNSfLbIixbeHAjdM
 5WftxxcwpeAK4Ej77NBMhQxyg2IOtQBOOzCQ==;
From: Bradley Morgan <brads@mainlining.org>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com,
	brads@mainlining.org
Subject: [PATCH 1/3] doc: arch/powerpc: add an overview
Date: Fri, 30 Oct 2026 01:49:23 +0000
Message-ID: <20261030014925.32610-2-brads@mainlining.org>
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PowerPC support is split over three CPU families and the only bits
written down are in the README files next to the boards. Add an arch
page covering the families, the boards, how to build and the config
options people keep asking about.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 doc/arch/index.rst           |   1 +
 doc/arch/powerpc/index.rst   |  10 +++
 doc/arch/powerpc/powerpc.rst | 166 +++++++++++++++++++++++++++++++++++
 3 files changed, 177 insertions(+)
 create mode 100644 doc/arch/powerpc/index.rst
 create mode 100644 doc/arch/powerpc/powerpc.rst

diff --git a/doc/arch/index.rst b/doc/arch/index.rst
index 60c93b3b664..4602aac0571 100644
--- a/doc/arch/index.rst
+++ b/doc/arch/index.rst
@@ -12,6 +12,7 @@ Architecture-specific doc
    m68k
    mips
    nios2
+   powerpc/index
    riscv
    sandbox/index
    sh
diff --git a/doc/arch/powerpc/index.rst b/doc/arch/powerpc/index.rst
new file mode 100644
index 00000000000..bf0c46b9408
--- /dev/null
+++ b/doc/arch/powerpc/index.rst
@@ -0,0 +1,10 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. Copyright (C) 2026, Bradley Morgan <brads@mainlining.org>
+
+PowerPC
+=======
+
+.. toctree::
+   :maxdepth: 2
+
+   powerpc
diff --git a/doc/arch/powerpc/powerpc.rst b/doc/arch/powerpc/powerpc.rst
new file mode 100644
index 00000000000..102943383de
--- /dev/null
+++ b/doc/arch/powerpc/powerpc.rst
@@ -0,0 +1,166 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. Copyright (C) 2026, Bradley Morgan <brads@mainlining.org>
+
+PowerPC
+=======
+
+Overview
+--------
+
+U-Boot on PowerPC is always a 32 bit big endian binary, even on the SoCs
+with 64 bit cores (e5500, e6500). The build passes -m32 -melf32ppclinux
+and that is the end of the story.
+
+The port is split by CPU family under arch/powerpc/cpu/:
+
+``mpc8xx``
+   PowerQUICC I. MPC866 and MPC885, CPM and friends.
+
+``mpc83xx``
+   e300 core, which is a 603e derivative. MPC830x, MPC831x, MPC832x,
+   MPC834x, MPC836x and MPC837x.
+
+``mpc85xx``
+   The e500 family: e500v1/v2, e500mc, e5500 and e6500. MPC8544, P1010,
+   P1020, P2020, P2041, T1024, T2080, T4240, that whole crowd.
+
+Stuff shared between mpc83xx and mpc85xx (LAWs, local bus, serdes, I2C, SPI)
+lives in arch/powerpc/cpu/mpc8xxx/.
+
+The PowerPC port is the original one, it came over from PPCBoot. MPC86xx
+was removed in 2026, so patches for it go nowhere.
+
+Supported boards
+----------------
+
+Boards are picked with Kconfig. configs/ has the full list, here are the
+usual suspects:
+
+* MPC8xx: MCR3000 and CMPC885, both from CSSI.
+
+* MPC83xx: CMPCPRO, MPC837XERDB, gazerbeam, and a pile of Keymile boards
+  (kmcoge5ne, kmeter1, kmopti2, kmsupx5, kmtepr2, tuge1, tuxx1).
+
+* MPC85xx: socrates (MPC8544), P1010RDB, P1020RDB, P2041RDB, T1024RDB,
+  T2080QDS, T2080RDB, T4240RDB, Turris 1.x, and qemu-ppce500 if you want
+  to play without hardware.
+
+Some settings still live in include/configs/<board>.h, but the defconfig
+is what actually counts.
+
+Building
+--------
+
+The boring case:
+
+.. code-block:: console
+
+   $ export CROSS_COMPILE=powerpc-linux-gnu-
+   $ make P1020RDB-PC_defconfig
+   $ make
+
+All of them at once:
+
+.. code-block:: console
+
+   $ tools/buildman/buildman powerpc
+
+See :doc:`/build/buildman`. CI builds every PowerPC defconfig and runs the
+test suite on qemu-ppce500, so most breakage shows up there first. See
+:doc:`/develop/ci_testing`.
+
+Toolchains
+----------
+
+The kernel.org crosstool powerpc-linux-gnu toolchains work fine for the
+whole architecture. GCC older than 4.0 is refused by the build, which
+should not surprise anyone in 2026.
+
+CI uses the trini/u-boot-gitlab-ci-runner image.
+
+Configuration options
+---------------------
+
+The ones people actually ask about:
+
+``CONFIG_HIGH_BATS``
+   Turns on BAT registers 4 to 7 where the CPU has them.
+
+``CONFIG_SYS_INIT_RAM_LOCK``
+   Locks part of L1 used for the early stack (MPC83xx, MPC85xx).
+
+``CONFIG_FSL_LBC``
+   Freescale local bus, for SoCs without IFC.
+
+``CONFIG_SYS_SRIO`` and friends
+   Serial RapidIO and booting over it, with CONFIG_SRIO1, CONFIG_SRIO2 and
+   CONFIG_SRIO_PCIE_BOOT_MASTER for the details.
+
+``CONFIG_USE_UBOOTPATH``, ``CONFIG_UBOOTPATH``
+   Sets the default uboot env var, which the default environment scripts
+   use to name the tftp image.
+
+``CONFIG_CACHE_FLUSH_WATCHDOG_THRESHOLD``
+   How many bytes flush_cache() flushes between schedule() calls.
+
+MPC8xx has its own pile:
+
+* CONFIG_MPC866 and CONFIG_MPC885 pick the CPU model.
+
+* CONFIG_SYS_SIUMCR, CONFIG_SYS_SYPCR, CONFIG_SYS_TBSCR, CONFIG_SYS_PISCR,
+  CONFIG_SYS_PLPRCR, CONFIG_SYS_SCCR and CONFIG_SYS_DER set the system
+  interface registers at startup. Get these wrong and you get a very quiet
+  board.
+
+* CONFIG_USB_SOF_UCODE_PATCH and CONFIG_SMC_UCODE_PATCH load CPM
+  microcode, for the CPM15 erratum and parameter RAM relocation.
+
+* CONFIG_CMD_IMMAP adds siuinfo and memcinfo.
+
+MPC85xx:
+
+* CONFIG_CMD_ERRATA, on by default, adds the errata command, which prints
+  the workarounds enabled on the current board.
+
+* CONFIG_SYS_PPC_E500_USE_DEBUG_TLB and CONFIG_SYS_PPC_E500_DEBUG_TLB work
+  around the e500v1/v2 debugger limitations. See doc/README.mpc85xx.
+
+* CONFIG_PPC_SPINTABLE_COMPATIBLE keeps the old spin table around for
+  older OSes, spin_table_compat in the environment flips it at runtime.
+  See doc/README.mpc85xx-spin-table.
+
+* CONFIG_MPC85XX_HAVE_RESET_VECTOR, CONFIG_SYS_MPC85XX_NO_RESETVEC and
+  CONFIG_FSL_PREPBL_ESDHC_BOOT_SECTOR are the image layout knobs.
+
+Device trees
+------------
+
+Most boards use CONFIG_OF_CONTROL with the dts in arch/powerpc/dts/. The
+usual rules apply, see :doc:`/develop/devicetree/control`.
+
+Adding a board
+--------------
+
+Four things:
+
+* a TARGET_* entry in arch/powerpc/cpu/<family>/Kconfig (defconfig selects
+  it), with board specific options coming from board/<vendor>/<board>/Kconfig
+
+* a defconfig in configs/, make savedefconfig is your friend
+
+* board code in board/<vendor>/<board>/
+
+* a dts in arch/powerpc/dts/ if OF_CONTROL is used
+
+No magic here, other architectures do the same.
+
+More reading
+------------
+
+* doc/README.pblimage
+* doc/README.ramboot-ppc85xx
+* doc/README.mpc85xx-sd-spi-boot
+* doc/README.mpc85xx-spin-table
+* doc/README.mpc85xx
+* doc/README.mpc83xx.ddrecc
+* :doc:`/board/emulation/qemu-ppce500`
-- 
2.47.3

