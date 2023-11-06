Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF99EC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 18:16:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94F118701C;
	Mon,  6 Nov 2023 19:16:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9AEF8702F; Mon,  6 Nov 2023 19:16:46 +0100 (CET)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA1F786BA9
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 19:16:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=csgroup.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christophe.leroy@csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4SPKLN2Nvvz9t0b;
 Mon,  6 Nov 2023 19:16:44 +0100 (CET)
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f6KudTG_MYdx; Mon,  6 Nov 2023 19:16:44 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4SPKLN1gQJz9t0H;
 Mon,  6 Nov 2023 19:16:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 340038B770;
 Mon,  6 Nov 2023 19:16:44 +0100 (CET)
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id Rx4RoT4rHlXg; Mon,  6 Nov 2023 19:16:44 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.33])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 013238B76D;
 Mon,  6 Nov 2023 19:16:43 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
 by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 3A6ICFaB057744
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 6 Nov 2023 19:12:15 +0100
Received: (from chleroy@localhost)
 by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 3A6ICFN8057743;
 Mon, 6 Nov 2023 19:12:15 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to
 christophe.leroy@csgroup.eu using -f
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Tom Rini <trini@konsulko.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, u-boot@lists.denx.de
Subject: [PATCH] board: cssi: Remove usage of common.h
Date: Mon,  6 Nov 2023 19:12:05 +0100
Message-ID: <76cdb4a9954d8686a0bdf7c165152e4fcbf9bd3c.1699294233.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <d8ba310b353395a54222b728a4add87c846a2729.1699294227.git.christophe.leroy@csgroup.eu>
References: <d8ba310b353395a54222b728a4add87c846a2729.1699294227.git.christophe.leroy@csgroup.eu>
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
 board/cssi/cmpc885/cmpc885.c | 1 -
 board/cssi/cmpc885/nand.c    | 1 -
 board/cssi/cmpc885/sdram.c   | 3 ++-
 board/cssi/cmpcpro/cmpcpro.c | 1 -
 board/cssi/mcr3000/mcr3000.c | 1 -
 board/cssi/mcr3000/nand.c    | 1 -
 6 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/board/cssi/cmpc885/cmpc885.c b/board/cssi/cmpc885/cmpc885.c
index 5e6aa8b8cf..e11cfafaa5 100644
--- a/board/cssi/cmpc885/cmpc885.c
+++ b/board/cssi/cmpc885/cmpc885.c
@@ -9,7 +9,6 @@
  */
 
 #include <env.h>
-#include <common.h>
 #include <mpc8xx.h>
 #include <asm/cpm_8xx.h>
 #include <asm/io.h>
diff --git a/board/cssi/cmpc885/nand.c b/board/cssi/cmpc885/nand.c
index 38100046df..b8989f226b 100644
--- a/board/cssi/cmpc885/nand.c
+++ b/board/cssi/cmpc885/nand.c
@@ -7,7 +7,6 @@
  */
 
 #include <config.h>
-#include <common.h>
 #include <nand.h>
 #include <linux/bitops.h>
 #include <linux/mtd/rawnand.h>
diff --git a/board/cssi/cmpc885/sdram.c b/board/cssi/cmpc885/sdram.c
index 7349b85ed2..11a50c3a52 100644
--- a/board/cssi/cmpc885/sdram.c
+++ b/board/cssi/cmpc885/sdram.c
@@ -4,13 +4,14 @@
  * Charles Frey <charles.frey@c-s.fr>
  */
 
-#include <common.h>
 #include <linux/sizes.h>
 #include <linux/delay.h>
 #include <init.h>
 #include <asm/io.h>
 #include <mpc8xx.h>
 #include <watchdog.h>
+#include <asm/ppc.h>
+#include <asm/immap_8xx.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/cssi/cmpcpro/cmpcpro.c b/board/cssi/cmpcpro/cmpcpro.c
index 8a30c48e35..ef30412456 100644
--- a/board/cssi/cmpcpro/cmpcpro.c
+++ b/board/cssi/cmpcpro/cmpcpro.c
@@ -4,7 +4,6 @@
  */
 
 #include <command.h>
-#include <common.h>
 #include <dm.h>
 #include <env.h>
 #include <env_internal.h>
diff --git a/board/cssi/mcr3000/mcr3000.c b/board/cssi/mcr3000/mcr3000.c
index 3514f67490..8857c9e42c 100644
--- a/board/cssi/mcr3000/mcr3000.c
+++ b/board/cssi/mcr3000/mcr3000.c
@@ -7,7 +7,6 @@
  * Board specific routines for the MCR3000 board
  */
 
-#include <common.h>
 #include <env.h>
 #include <hwconfig.h>
 #include <init.h>
diff --git a/board/cssi/mcr3000/nand.c b/board/cssi/mcr3000/nand.c
index 11aca4ff73..5b01d30fef 100644
--- a/board/cssi/mcr3000/nand.c
+++ b/board/cssi/mcr3000/nand.c
@@ -6,7 +6,6 @@
  */
 
 #include <config.h>
-#include <common.h>
 #include <nand.h>
 #include <linux/mtd/rawnand.h>
 #include <asm/io.h>
-- 
2.41.0

