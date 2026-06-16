Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B3ACD98D2
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 23:21:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9C2384895;
	Wed, 17 Jun 2026 01:20:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="LLX/UX6b";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="CvAVr9ZV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 083C4849B4; Wed, 17 Jun 2026 01:20:21 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47EB6849A3
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 01:20:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gg2yp0VZ1z9vDS;
 Wed, 17 Jun 2026 01:20:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781652018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6WKtE34TE3t6LCm1K9tYFNDtANKJ+wnnNCYL1zlcHkQ=;
 b=LLX/UX6bCYFsM+SNDo0VKb44LjqloGOil1BmPzezcGKVvWdDNh1tmExUJgklJN3EjvD0zO
 Z+ONllvuYiMLxNQg11M7Bp6VlFiBlRHDafJRtcxDUsQV7rzGxkkWuKoLAraYUL8LHIqr3d
 l/VpVHX0JLEnS+HF1FNcVE0M3RJgtiMGLJAhSeqJxVbiXDgT47SRPUcx/WULppTyCjtX9M
 VcI2b+pP8+WvXpaIrP9+tpkBqDf8cbVXMjo2KAUSq+VQkCzoNJXJRfLZ0mjOfgZQYmULGF
 FSj4pTUHe/+OAb01VLPdT/MyMbNN/Nuu7sx4p5KmX4mtVVG9F+kWogAHuvFQlw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781652015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6WKtE34TE3t6LCm1K9tYFNDtANKJ+wnnNCYL1zlcHkQ=;
 b=CvAVr9ZVMibMSLj8ZJWRBVS1ys75hzbgr+mMnfdUvg0f0n9NeTdvjFPSHfPq8twGIVbia/
 KXBzBqV8A84ifKl/Nx7wEberTomG4GF8BW3Dwymg1kHienBmsocESuXbOY9Twa2FXwKWGZ
 +/0OqyRp0Ywaah7pmazfHoQL3cmhlp8x9T9qL2xCw4o/4jkhSaZwHYoCQ6eavYRDur7rdd
 15ienMh7n3OJ12T3c5w+SqHMVUJ1gCKKU2f/9r/rpF22ld5v3ZunRPUsjgmK/IZZBZ9NDE
 IE7ATFxsTaU0E3iY8gGwRvedTVbv8LSgTU0izF919LJGCyPWi/bxthBFmlBbPg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 09/11] doc: board: renesas: Document Renesas R-Car Gen5 X5H
 Ironhide board
Date: Wed, 17 Jun 2026 01:18:50 +0200
Message-ID: <20260616231933.44392-10-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260616231933.44392-1-marek.vasut+renesas@mailbox.org>
References: <20260616231933.44392-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: adf4uwcinss8xk5jdsk46nb7wcjnnqmk
X-MBO-RS-ID: b901781ffafd68e39b1
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

Add document which clarifies how to build and install U-Boot on
Renesas R-Car Gen5 X5H Ironhide board.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 doc/board/renesas/index.rst              |   1 +
 doc/board/renesas/rcar-gen5-ironhide.rst | 204 +++++++++++++++++++++++
 doc/board/renesas/renesas.rst            |   4 +-
 3 files changed, 207 insertions(+), 2 deletions(-)
 create mode 100644 doc/board/renesas/rcar-gen5-ironhide.rst

diff --git a/doc/board/renesas/index.rst b/doc/board/renesas/index.rst
index 68b11ebb455..be932aa01fb 100644
--- a/doc/board/renesas/index.rst
+++ b/doc/board/renesas/index.rst
@@ -19,4 +19,5 @@ Renesas
    rcar-gen3-install-hf
    rcar-gen3-install-sf
    rcar-gen4-sparrow-hawk
+   rcar-gen5-ironhide
    rzn1
diff --git a/doc/board/renesas/rcar-gen5-ironhide.rst b/doc/board/renesas/rcar-gen5-ironhide.rst
new file mode 100644
index 00000000000..39fbfdbfe00
--- /dev/null
+++ b/doc/board/renesas/rcar-gen5-ironhide.rst
@@ -0,0 +1,204 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Renesas R-Car Gen5 X5H Ironhide board
+=====================================
+
+Renesas R-Car Gen5 X5H Ironhide board U-Boot can be built for two separate cores:
+
+- Cortex-M33 RSIP core, which is the boot core
+- Cortex-A720AE core, which is the application core
+
+Cortex-A720AE target
+^^^^^^^^^^^^^^^^^^^^
+
+Build U-Boot
+------------
+
+Please follow :doc:`Renesas 64-bit ARM SoC build environment setup <build-env-aarch64>`
+to correctly set up the build environment before attempting to build U-Boot.
+
+Clone up to date U-Boot source code and change directory into the
+newly cloned source directory:
+
+.. code-block:: console
+
+    $ git clone https://source.denx.de/u-boot/u-boot.git/
+    $ cd u-boot
+
+Configure U-Boot:
+
+.. code-block:: console
+
+    $ make r8a78000_ironhide_defconfig
+
+Compile U-Boot:
+
+.. code-block:: console
+
+    $ make
+
+To speed up build process, -jN option can be passed to make to start
+multiple jobs at the same time, this is beneficial especially on SMP
+systems. The following example starts up to number of CPUs in the
+system jobs, which is the recommended amount:
+
+.. code-block:: console
+
+    $ make -j$(nproc)
+
+Install U-Boot
+--------------
+
+In order to install U-Boot for Cortex-A720AE into UFS, first build U-Boot
+for this target and collect ``u-boot-elf.srec`` build artifact.
+
+Next, configure the board for SCIF loader boot. Upload IPL flash_writer
+mot binary. Use the tool to write ``u-boot-elf.srec`` into HyperFlash
+at offset 0x8e300000 . Finally, power off the board and configure the
+board back to HyperFlash boot mode.
+
+Cortex-M33 RSIP target
+^^^^^^^^^^^^^^^^^^^^^^
+
+Build U-Boot
+------------
+
+Please follow :doc:`Renesas 32-bit ARM SoC build environment setup <build-env-aarch32>`
+to correctly set up the build environment before attempting to build U-Boot.
+
+Clone up to date U-Boot source code and change directory into the
+newly cloned source directory:
+
+.. code-block:: console
+
+    $ git clone https://source.denx.de/u-boot/u-boot.git/
+    $ cd u-boot
+
+Configure U-Boot:
+
+.. code-block:: console
+
+    $ make r8a78000_ironhide_cm33_defconfig
+
+Compile U-Boot:
+
+.. code-block:: console
+
+    $ make
+
+To speed up build process, -jN option can be passed to make to start
+multiple jobs at the same time, this is beneficial especially on SMP
+systems. The following example starts up to number of CPUs in the
+system jobs, which is the recommended amount:
+
+.. code-block:: console
+
+    $ make -j$(nproc)
+
+Install U-Boot
+--------------
+
+In order to install U-Boot for RSIP into HyperFlash, first build U-Boot
+for this target and collect ``u-boot-elf.shdr`` and ``u-boot-elf.srec``
+build artifacts.
+
+Next, configure the board for SCIF loader boot. Upload IPL flash_writer
+mot binary. Use the tool to write ``u-boot-elf.shdr`` into HyperFlash
+at offset 0, and ``u-boot-elf.srec`` into HyperFlash at offset 0x40000 .
+Finally, power off the board and configure the board back to HyperFlash
+boot mode.
+
+Power on the board, U-Boot on RSIP will start. Interaction with U-Boot
+on RSIP is possible via HSCIF1, which is the second serial console that
+is available on the USB-to-Serial adapter port. HSCIF1 is used in order
+to avoid interference with software running on the Cortex-A720AE cores,
+which uses HSCIF0.
+
+Ethernet boot of bootloader components
+--------------------------------------
+
+The U-Boot for RSIP is capable of ethernet access, which allows download
+of bootloader components via TFTP. This is useful during development and
+can be used for fast iterative testing of either SCP firmware, TFA BL31,
+OPTEE-OS, U-Boot or Linux on the SCP core and Cortex-A720AE cores
+respectively.
+
+An example U-Boot environment applicable to ``include/configs/rcar-gen5-common.h``
+or executable manually is listed below. The environment script ``rsip_ipl_boot_ca0``
+implements download of SCP firmware ``scp.bin``, TFA BL31 ``bl31.bin``,
+U-Boot ``u-boot.bin`` and Linux ``fitImage`` from TFTP server at address
+``192.168.1.1/24`` and starts those components on the SCP and Cortex-A720AE
+cores respectively. OPTEE-OS is loaded from UFS to retain at least this
+example of UFS loading, however, it perfectly fine to download OPTEE-OS
+via TFTP in the same manner as the other components are downloaded:
+
+.. code-block:: console
+
+    rsip_ipl_params_base=0x8c100000
+    rsip_ipl_params_optee=0x8c100088
+    rsip_ipl_params_uboot=0x8c100030
+    rsip_ipl_scp_ep=0x8c180000
+    rsip_ipl_optee_ep=0x8c400000
+    rsip_ipl_tfa_ep=0x8c200000
+    rsip_ipl_uboot_ep=0x8e300000
+    rsip_ipl_linux_ep=0x91000000
+
+    rsip_ipl_params_write=                       /* Build handoff structure */ \
+            base ${rsip_ipl_params_base} ;                                     \
+            mw 0x00 0 0x9e ;                     /* Clear the area */          \
+            mw 0x00 0x00300103 ;                 /* type, version, size */     \
+            mw 0x20 0x${rsip_ipl_params_uboot} ; /* U-Boot descriptor */       \
+                                                                               \
+            base ${rsip_ipl_params_uboot} ;                                    \
+            mw 0x00 0x00580101 ;                 /* type, version, size */     \
+            mw 0x04 0x00000001 ;                 /* attr */                    \
+            mw 0x08 ${rsip_ipl_uboot_ep} ;       /* U-Boot entry point */      \
+            mw 0x10 0x000003c5 ;                 /* SPSR */                    \
+                                                                               \
+            base ${rsip_ipl_params_optee} ;                                    \
+            mw 0x00 0x00580201 ;                 /* type, version, size */     \
+            mw 0x04 0x00000008 ;                 /* attr */                    \
+            mw 0x08 ${rsip_ipl_optee_ep} ;       /* OPTEE-OS entry point */    \
+            mw 0x10 0x000003c5 ;                 /* SPSR */                    \
+                                                                               \
+            base 0
+
+    rsip_ipl_boot_ca0= /* Start TFA BL31, OPTEE-OS, U-Boot, Linux on Cortex-A720AE core 0 */   \
+            setenv ipaddr 192.168.1.10 &&                                                      \
+            setenv serverip 192.168.1.1 &&                                                     \
+            setenv netmask 255.255.255.0 &&                                                    \
+                                                                                               \
+            tftp ${rsip_ipl_scp_ep} scp.bin &&                                                 \
+            tftp ${rsip_ipl_tfa_ep} bl31.bin &&                                                \
+            tftp ${rsip_ipl_uboot_ep} u-boot.bin &&                                            \
+            tftp ${rsip_ipl_linux_ep} fitImage &&                                              \
+                                                                                               \
+            scsi scan &&                                   /* Scan for UFS devices */          \
+            rproc init &&                                  /* Start remoteproc */              \
+            rproc load 0 ${rsip_ipl_scp_ep} 0x60000 &&     /* Load SCP STCM */                 \
+            rproc start 0 &&                               /* Start SCP */                     \
+            scsi read ${rsip_ipl_optee_ep} 0x5200 0x200 && /* Load OPTEE-OS from UFS */        \
+            run rsip_ipl_params_write &&                   /* Write entry point descriptors */ \
+                                                                                               \
+            rproc load 13 ${rsip_ipl_tfa_ep} 4 &&          /* Set up Cortex-A720AE Core 0 */   \
+            rproc start 13                                 /* Start Cortex-A720AE Core 0 */
+
+
+.. note::
+
+    U-Boot on RSIP environment is not persistent across reboots,
+    but this will likely change in the upcoming U-Boot release.
+
+.. note::
+
+    U-Boot on RSIP can start the SCP core via rproc command, but
+    it can not stop SCP after it was started. This was intended
+    as a safety mechanism, since SCP is central component of the
+    system, however, this will likely change in the upcoming U-Boot
+    release.
+
+.. note::
+
+    U-Boot on RSIP can start non-SCP cores via ``rproc`` command only
+    after the SCP got started, because those cores are started via
+    SCMI calls to the SCP.
diff --git a/doc/board/renesas/renesas.rst b/doc/board/renesas/renesas.rst
index 234094a4259..ef04a4478e1 100644
--- a/doc/board/renesas/renesas.rst
+++ b/doc/board/renesas/renesas.rst
@@ -199,13 +199,13 @@ Renesas is a SoC solutions provider for automotive and industrial applications.
      - r8a779h0_grayhawk_defconfig
 
    * - R-Car Gen5
-     - Ironhide (Cortex-A720AE application core)
+     - :doc:`Ironhide (Cortex-A720AE application core) <rcar-gen5-ironhide>`
      - R8A78000 (X5H)
      - :doc:`arm64 <build-env-aarch64>`
      - r8a78000_ironhide_defconfig
 
    * -
-     - Ironhide (Cortex-M33 RSIP boot core)
+     - :doc:`Ironhide (Cortex-M33 RSIP boot core) <rcar-gen5-ironhide>`
      - R8A78000 (X5H)
      - :doc:`arm64 <build-env-aarch64>`
      - r8a78000_ironhide_cm33_defconfig
-- 
2.53.0

