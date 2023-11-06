Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D71C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 18:16:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82932870BC;
	Mon,  6 Nov 2023 19:16:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F3C8870BC; Mon,  6 Nov 2023 19:16:48 +0100 (CET)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53AC386BDB
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 19:16:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=csgroup.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christophe.leroy@csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4SPKLQ0Vw1z9t0b;
 Mon,  6 Nov 2023 19:16:46 +0100 (CET)
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lxyWCwY9Qhpd; Mon,  6 Nov 2023 19:16:45 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4SPKLN4KGrz9t0H;
 Mon,  6 Nov 2023 19:16:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 8E3108B770;
 Mon,  6 Nov 2023 19:16:44 +0100 (CET)
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id cu40-f-bAT69; Mon,  6 Nov 2023 19:16:44 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.33])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 47E4D8B76D;
 Mon,  6 Nov 2023 19:16:44 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
 by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 3A6ICDGS057735
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 6 Nov 2023 19:12:13 +0100
Received: (from chleroy@localhost)
 by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 3A6ICDbB057733;
 Mon, 6 Nov 2023 19:12:13 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to
 christophe.leroy@csgroup.eu using -f
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Tom Rini <trini@konsulko.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, u-boot@lists.denx.de
Subject: [PATCH] powerpc: mpc8xx: Remove usage of common.h
Date: Mon,  6 Nov 2023 19:12:04 +0100
Message-ID: <d8ba310b353395a54222b728a4add87c846a2729.1699294227.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Remove inclusion of common.h and add relevant
includes when necessary.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/cpu/mpc8xx/cache.c      | 1 -
 arch/powerpc/cpu/mpc8xx/cpu.c        | 1 -
 arch/powerpc/cpu/mpc8xx/cpu_init.c   | 1 -
 arch/powerpc/cpu/mpc8xx/fdt.c        | 1 -
 arch/powerpc/cpu/mpc8xx/immap.c      | 2 +-
 arch/powerpc/cpu/mpc8xx/interrupts.c | 2 +-
 arch/powerpc/cpu/mpc8xx/speed.c      | 2 +-
 arch/powerpc/cpu/mpc8xx/traps.c      | 2 +-
 8 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/cpu/mpc8xx/cache.c b/arch/powerpc/cpu/mpc8xx/cache.c
index 41559009ca..525c87f37c 100644
--- a/arch/powerpc/cpu/mpc8xx/cache.c
+++ b/arch/powerpc/cpu/mpc8xx/cache.c
@@ -4,7 +4,6 @@
  * Christophe Leroy, CS Systemes d'Information, christophe.leroy@c-s.fr
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <asm/processor.h>
 #include <asm/ppc.h>
diff --git a/arch/powerpc/cpu/mpc8xx/cpu.c b/arch/powerpc/cpu/mpc8xx/cpu.c
index 56383cecde..b9afd312ec 100644
--- a/arch/powerpc/cpu/mpc8xx/cpu.c
+++ b/arch/powerpc/cpu/mpc8xx/cpu.c
@@ -16,7 +16,6 @@
  * Wolfgang Denk <wd@denx.de>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <display_options.h>
 #include <net.h>
diff --git a/arch/powerpc/cpu/mpc8xx/cpu_init.c b/arch/powerpc/cpu/mpc8xx/cpu_init.c
index feef792ee7..aac4203a6e 100644
--- a/arch/powerpc/cpu/mpc8xx/cpu_init.c
+++ b/arch/powerpc/cpu/mpc8xx/cpu_init.c
@@ -4,7 +4,6 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
 #include <init.h>
 #include <watchdog.h>
 
diff --git a/arch/powerpc/cpu/mpc8xx/fdt.c b/arch/powerpc/cpu/mpc8xx/fdt.c
index b4a26efe30..b204a3d751 100644
--- a/arch/powerpc/cpu/mpc8xx/fdt.c
+++ b/arch/powerpc/cpu/mpc8xx/fdt.c
@@ -5,7 +5,6 @@
  * Code copied & edited from Freescale mpc85xx stuff.
  */
 
-#include <common.h>
 #include <time.h>
 #include <asm/global_data.h>
 #include <linux/libfdt.h>
diff --git a/arch/powerpc/cpu/mpc8xx/immap.c b/arch/powerpc/cpu/mpc8xx/immap.c
index 40793c26e1..8c85fc180b 100644
--- a/arch/powerpc/cpu/mpc8xx/immap.c
+++ b/arch/powerpc/cpu/mpc8xx/immap.c
@@ -8,7 +8,6 @@
  * MPC8xx Internal Memory Map Functions
  */
 
-#include <common.h>
 #include <command.h>
 #include <asm/global_data.h>
 
@@ -16,6 +15,7 @@
 #include <asm/cpm_8xx.h>
 #include <asm/iopin_8xx.h>
 #include <asm/io.h>
+#include <asm/ppc.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/powerpc/cpu/mpc8xx/interrupts.c b/arch/powerpc/cpu/mpc8xx/interrupts.c
index eef1951f2f..babef07ffb 100644
--- a/arch/powerpc/cpu/mpc8xx/interrupts.c
+++ b/arch/powerpc/cpu/mpc8xx/interrupts.c
@@ -4,7 +4,7 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
+#include <stdio.h>
 #include <irq_func.h>
 #include <mpc8xx.h>
 #include <mpc8xx_irq.h>
diff --git a/arch/powerpc/cpu/mpc8xx/speed.c b/arch/powerpc/cpu/mpc8xx/speed.c
index 1a882a3882..baf81381b3 100644
--- a/arch/powerpc/cpu/mpc8xx/speed.c
+++ b/arch/powerpc/cpu/mpc8xx/speed.c
@@ -4,12 +4,12 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
 #include <clock_legacy.h>
 #include <mpc8xx.h>
 #include <asm/global_data.h>
 #include <asm/processor.h>
 #include <asm/io.h>
+#include <asm/immap_8xx.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/powerpc/cpu/mpc8xx/traps.c b/arch/powerpc/cpu/mpc8xx/traps.c
index 56794b08a1..5220c560e5 100644
--- a/arch/powerpc/cpu/mpc8xx/traps.c
+++ b/arch/powerpc/cpu/mpc8xx/traps.c
@@ -15,7 +15,7 @@
  * This file handles the architecture-dependent parts of hardware exceptions
  */
 
-#include <common.h>
+#include <vsprintf.h>
 #include <asm/ptrace.h>
 #include <command.h>
 #include <asm/processor.h>
-- 
2.41.0

