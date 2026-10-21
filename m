Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B014606A561
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=I0TGvllx;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=O0vgamX1;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=liLpY4CR
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 11B8660AC0;
	Wed, 21 Oct 2026 16:17:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UZNr92apg-_g; Wed, 21 Oct 2026 16:17:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CF50D60AC1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792599404;
	b=o2SXOcLTLCuW8zpjh0FZJckcjCYNdZiWPI6KWAvtQlXK2MRBtcjxRcBCIF6ztFTAgpe4
	 jL29+05+X8sc4tc0GHNj9ztV7MS2yGC8k97RNR0kXgbBEGNZ4HadT5EwjP7EDhSobKZlC
	 WpX2XHS/o+bgwY9iSUtktXbVWdhZwYEbwhZMBcTiRWMKcAVKMSGfJR/3VvSvo5UDlos0k
	 Brd8hgGYcRb2Bx4oqt8oByk10FypaiJOYKnY6kNmyfDY/TXRKrPPG296npZSSSs2Wo9Sg
	 KnMCM6ivvWHtoynPERP/9Lh2vPlHQUwaNhKPZkWn2KVZd3ImgIz/xMJ6PY8bfWtAFAA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599404;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KYN4EhPv8MIApG5ne3ReX+YjgS5hfX1Iz6CPR/4bkvs=;
	b=ImWWR3J0NaJqZoiQnwgeZrfErrgtI+JjmU1Nx05UVKjKFVQQwDQ1y/gjhKh3JmWGLb9y
	 ASM4qbBrx78M3TTHgu8An3EqWz5yJgVBhc8J7xClPOYdgTNza3rqzm9DccC3veHfrJGO3
	 6l6mSVJhiknv6K5Vf9tMjPeOS2BQe1ueDkAMV1JZFMwtE6WNAG0S7zzYACxYmT9YXzdzg
	 S+6JbWH5/qzDjQo4ymekxp6NdpD5xs8J6nm7GALWwzGcMm1lAScECyib27Xv0nSKYv7ZG
	 fspHezhKUH1RiFxpandMJ5C+sSV+Iv+W2Gr9i7Nu7JGrI+uUfYRGt9XxmxqC/E/Mtfg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792599403;
	bh=KYN4EhPv8MIApG5ne3ReX+YjgS5hfX1Iz6CPR/4bkvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I0TGvllxh41/PrlgNrF8app7anbNyvBX+6Xie6HsN+wsumBnIDtPGLXcxzuJxbyu+
	 7y+YKjibkN1BXYrjVjbwFQPzmv0k+5mCq+DbengE/mS0r9uM2LTNCz24Ux9MM0IoKD
	 MJb/K6f2b0/NhDxsxkucf/TK9ecm3uCAHP1qbRRKq6vTkcDFraI0xhV2uhlWJdmCtx
	 jvl0CAS7w4Q2X0FfBSQZFLW4lJMzE5AHok8GuFI8nmz7MpHtE10AL9si5T85TQiCjT
	 j/m9+bs2t6Ed9V3OHwjUnu5BXBnm/oF12GVSmUFQtRamSMExt6FruYBlLsxC3LzH/P
	 IussfXVlZSlGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CF50D60AC1;
	Wed, 21 Oct 2026 16:16:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id 286171E17
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:02:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with UTF8SMTP id 0E720408A1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:02:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id qQST2eJzjvjt for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:02:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5B12C40877
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792598519;
 b=JB0bQb5xALpEwi4BoRgj8xhlt3p1ulOP8xhME6tREB2BRj7AuWzNvrPVdQTkYlbu3eJO
 a7oG9YAGGjOddlQIVnu/YiGNcvRY3vSakof+Kw1xZY9EkkXBy74QzF2Z62+n92ckpXvDf
 aJ9OAFoR+stHjFiwIi3Z+ehRqHHMEC8mJ+/oStL51e7AMp0uQabzsLAxrsF9Z76DkElfX
 z3Pbs1yj9vi6DDUuSTvHxWBJYpsP88prI7Gh3Drko2qN8Ta2wkUfWkr3urdrtDO3TeuEG
 h5ANz5TNrSKYAt2ZnfNABa9gjluR8PIVoX7SAgCQwt5j7GgJ0v/ScmLd5CiIZf+hH+A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792598519;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=KYN4EhPv8MIApG5ne3ReX+YjgS5hfX1Iz6CPR/4bkvs=;
 b=QxaiTvZSunDsu2RjF962ZKk5dN8VwqIY1fXJIWXsZ+5ZtKGBT/wFHu5Ne1/hKScqKuSq
 mLHEBxwh1z8beGrbNKgrp5sDQRSUgUy9KU7LRipvJEmTyKbkCjMIDNlJr1mRauMocme6v
 3+AtvkPHKSuzBdcCUvVMXX4c8/SJtmAC1LY4LpXwiXuJeASdaL+45ojULYK3R1YNWjzYS
 oOpJ52vAPIdodAelYnCwnHLPoPcq5ritcR1Eq5mkCxzR3M3/nI9mlnhhbX6482kog6XQz
 Z1+6xTi0FBtLudAcG+gKaZXxqEN6+ZdWhTrST71pZeieYo65CoGRtQ0UhnV65Q9Vkpg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=O0vgamX1; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=liLpY4CR; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=O0vgamX1; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=liLpY4CR
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp4.osuosl.org (Postfix) with UTF8SMTPS id 5B12C40877
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1792598517; bh=KYN4EhPv8MIApG5ne3ReX+Y
 jgS5hfX1Iz6CPR/4bkvs=; b=O0vgamX1eNCytxK9/J8N2qFynSzD3zdBKyorJO9VhDJpFY05WS
 n/ZMKgA88egpXM1Rkx40tOGnUmpenBM5qm+6yGkVFrXGJCklbMLTHrn7jVTK4D/7oCgqX1c2HSU
 Stvyd1Cly267dVmWwwooel63W2Gou0WICaq0SnD8w1QTLKXntqLK3HmjsYikK27kzdF0saDk6zf
 tZAna9OJXfAJo9MeeBXlVTtU+A0JSg7FDbFXiMyhta8ONsDvMU4G9puB/N3Yd/ZvzMs1mc4dCGQ
 mwaJnZOFDDSPVKnCwxeQZWmuhzGcym/q6m8PpZO31RrDBXCuk0CeAvyJ4osQvTISFeQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1792598517; bh=KYN4EhPv8MIApG5ne3ReX+Y
 jgS5hfX1Iz6CPR/4bkvs=; b=liLpY4CRGDroOQzRrervtlqRB49i/J6VI5EYLFhn7j2C3Afc1E
 akwcB5dCPpv3IKcjV9ztn5N4XnO5IwPdhSBg==;
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Cc: Bradley Morgan <brads@mainlining.org>
Subject: [PATCH v3 25/26] powerpc: Remove MPC86xx support
Date: Wed, 21 Oct 2026 16:01:21 +0000
Message-ID: <20261021160145.10430-26-brads@mainlining.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021160145.10430-1-brads@mainlining.org>
References: <20261021160145.10430-1-brads@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 21 Oct 2026 16:16:07 +0000
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

No target in the tree selects MPC86xx, and the architecture lacks
active community maintenance or testing. Its CPU, PCI and DMA paths
have no consumer. Remove them.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 api/api_platform-powerpc.c             |  2 +-
 arch/powerpc/cpu/Makefile              |  1 -
 arch/powerpc/cpu/mpc8xxx/Makefile      |  1 -
 arch/powerpc/cpu/mpc8xxx/cpu.c         |  8 +-------
 arch/powerpc/cpu/mpc8xxx/fdt.c         |  8 +++-----
 arch/powerpc/cpu/mpc8xxx/srio.c        |  6 ------
 arch/powerpc/include/asm/config.h      |  1 -
 arch/powerpc/include/asm/fsl_lbc.h     |  2 +-
 arch/powerpc/include/asm/fsl_pci.h     |  7 -------
 arch/powerpc/include/asm/global_data.h |  7 +++----
 arch/powerpc/include/asm/ppc.h         | 14 +-------------
 arch/powerpc/include/asm/processor.h   | 18 ++----------------
 arch/powerpc/lib/bdinfo.c              |  2 +-
 arch/powerpc/lib/bootm.c               |  7 -------
 arch/powerpc/lib/ppccache.S            |  4 ++--
 arch/powerpc/lib/stack.c               |  2 +-
 common/board_r.c                       |  2 +-
 drivers/ddr/fsl/Kconfig                |  3 +--
 drivers/ddr/fsl/ctrl_regs.c            |  1 -
 drivers/dma/fsl_dma.c                  |  4 ----
 drivers/gpio/mpc8xxx_gpio.c            |  1 -
 drivers/pci/Kconfig                    |  2 +-
 env/Kconfig                            |  2 +-
 include/asm-generic/u-boot.h           |  2 +-
 include/fsl_immap.h                    |  2 +-
 include/pci_ids.h                      |  4 ----
 include/serial.h                       |  1 -
 27 files changed, 22 insertions(+), 92 deletions(-)

diff --git a/api/api_platform-powerpc.c b/api/api_platform-powerpc.c
index 2c1ab043af6..f789cf40ba1 100644
--- a/api/api_platform-powerpc.c
+++ b/api/api_platform-powerpc.c
@@ -28,7 +28,7 @@ int platform_sys_info(struct sys_info *si)
 	si->clk_bus = gd->bus_clk;
 	si->clk_cpu = gd->cpu_clk;
 
-#if defined(CONFIG_MPC8xx) || defined(CONFIG_E500) || defined(CONFIG_MPC86xx)
+#if defined(CONFIG_MPC8xx) || defined(CONFIG_E500)
 #define bi_bar	bi_immr_base
 #elif defined(CONFIG_MPC83xx)
 #define bi_bar	bi_immrbar
diff --git a/arch/powerpc/cpu/Makefile b/arch/powerpc/cpu/Makefile
index e7f64059277..1a2b6fafa4b 100644
--- a/arch/powerpc/cpu/Makefile
+++ b/arch/powerpc/cpu/Makefile
@@ -2,4 +2,3 @@
 
 obj-$(CONFIG_MPC83xx) += mpc8xxx/
 obj-$(CONFIG_MPC85xx) += mpc8xxx/
-obj-$(CONFIG_MPC86xx) += mpc8xxx/
diff --git a/arch/powerpc/cpu/mpc8xxx/Makefile b/arch/powerpc/cpu/mpc8xxx/Makefile
index a44b5165d74..5373398cf6f 100644
--- a/arch/powerpc/cpu/mpc8xxx/Makefile
+++ b/arch/powerpc/cpu/mpc8xxx/Makefile
@@ -18,7 +18,6 @@ obj-$(CONFIG_FSL_LAW) += law.o
 
 else
 obj-$(CONFIG_MPC85xx) += cpu.o
-obj-$(CONFIG_MPC86xx) += cpu.o
 
 obj-$(CONFIG_OF_LIBFDT) += fdt.o
 obj-$(CONFIG_FSL_LBC) += fsl_lbc.o
diff --git a/arch/powerpc/cpu/mpc8xxx/cpu.c b/arch/powerpc/cpu/mpc8xxx/cpu.c
index 42fbe445935..c25bc8c7e56 100644
--- a/arch/powerpc/cpu/mpc8xxx/cpu.c
+++ b/arch/powerpc/cpu/mpc8xxx/cpu.c
@@ -2,9 +2,7 @@
 /*
  * Copyright 2009-2012 Freescale Semiconductor, Inc.
  *
- * This file is derived from arch/powerpc/cpu/mpc85xx/cpu.c and
- * arch/powerpc/cpu/mpc86xx/cpu.c. Basically this file contains
- * cpu specific common code for 85xx/86xx processors.
+ * This file contains CPU-specific code for MPC85xx processors.
  */
 
 #include <config.h>
@@ -78,10 +76,6 @@ static struct cpu_type cpu_type_list[] = {
 	CPU_TYPE_ENTRY(T2081, T2081, 0),
 	CPU_TYPE_ENTRY(BSC9130, 9130, 1),
 	CPU_TYPE_ENTRY(BSC9232, 9232, 2),
-#elif defined(CONFIG_MPC86xx)
-	CPU_TYPE_ENTRY(8610, 8610, 1),
-	CPU_TYPE_ENTRY(8641, 8641, 2),
-	CPU_TYPE_ENTRY(8641D, 8641D, 2),
 #endif
 };
 
diff --git a/arch/powerpc/cpu/mpc8xxx/fdt.c b/arch/powerpc/cpu/mpc8xxx/fdt.c
index f1c1cbc1c3c..692f89e04c6 100644
--- a/arch/powerpc/cpu/mpc8xxx/fdt.c
+++ b/arch/powerpc/cpu/mpc8xxx/fdt.c
@@ -3,9 +3,7 @@
  * Copyright 2009-2014 Freescale Semiconductor, Inc.
  * Copyright 2020 NXP
  *
- * This file is derived from arch/powerpc/cpu/mpc85xx/cpu.c and
- * arch/powerpc/cpu/mpc86xx/cpu.c. Basically this file contains
- * cpu specific common code for 85xx/86xx processors.
+ * This file contains CPU-specific common code for MPC85xx processors.
  */
 
 #include <cpu_func.h>
@@ -16,7 +14,7 @@
 #include <phy.h>
 #include <hwconfig.h>
 
-#if defined(CONFIG_MP) && (defined(CONFIG_MPC85xx) || defined(CONFIG_MPC86xx))
+#if defined(CONFIG_MP) && defined(CONFIG_MPC85xx)
 static int ft_del_cpuhandle(void *blob, int cpuhandle)
 {
 	int off, ret = -FDT_ERR_NOTFOUND;
@@ -68,7 +66,7 @@ void ft_fixup_num_cores(void *blob) {
 	debug ("deleted %d extra core entry entries from device tree\n",
 								del_cores);
 }
-#endif /* defined(CONFIG_MPC85xx) || defined(CONFIG_MPC86xx) */
+#endif /* defined(CONFIG_MP) && defined(CONFIG_MPC85xx) */
 
 int fdt_fixup_phy_connection(void *blob, int offset, phy_interface_t phyc)
 {
diff --git a/arch/powerpc/cpu/mpc8xxx/srio.c b/arch/powerpc/cpu/mpc8xxx/srio.c
index 0c7288c7574..652411fc3b3 100644
--- a/arch/powerpc/cpu/mpc8xxx/srio.c
+++ b/arch/powerpc/cpu/mpc8xxx/srio.c
@@ -39,12 +39,6 @@
 	#define _DEVDISR_SRIO2 MPC85xx_DEVDISR_SRIO
 	#define _DEVDISR_RMU   MPC85xx_DEVDISR_RMSG
 	#define CFG_SYS_MPC8xxx_GUTS_ADDR CFG_SYS_MPC85xx_GUTS_ADDR
-#elif defined(CONFIG_MPC86xx)
-	#define _DEVDISR_SRIO1 MPC86xx_DEVDISR_SRIO
-	#define _DEVDISR_SRIO2 MPC86xx_DEVDISR_SRIO
-	#define _DEVDISR_RMU   MPC86xx_DEVDISR_RMSG
-	#define CFG_SYS_MPC8xxx_GUTS_ADDR \
-		(&((immap_t *)CONFIG_SYS_IMMR)->im_gur)
 #else
 #error "No defines for DEVDISR_SRIO"
 #endif
diff --git a/arch/powerpc/include/asm/config.h b/arch/powerpc/include/asm/config.h
index 7e53dcf8af5..6dee08c0493 100644
--- a/arch/powerpc/include/asm/config.h
+++ b/arch/powerpc/include/asm/config.h
@@ -16,7 +16,6 @@
 
 #ifndef CFG_MAX_MEM_MAPPED
 #if	defined(CONFIG_E500)		|| \
-	defined(CONFIG_MPC86xx)		|| \
 	defined(CONFIG_E300)
 #define CFG_MAX_MEM_MAPPED	((phys_size_t)2 << 30)
 #else
diff --git a/arch/powerpc/include/asm/fsl_lbc.h b/arch/powerpc/include/asm/fsl_lbc.h
index 37da14c45f1..19dd5c94d60 100644
--- a/arch/powerpc/include/asm/fsl_lbc.h
+++ b/arch/powerpc/include/asm/fsl_lbc.h
@@ -310,7 +310,7 @@ void lbc_sdram_init(void);
 #define LCRR_EADC_2			0x00020000
 #define LCRR_EADC_3			0x00030000
 #define LCRR_EADC_4			0x00000000
-/* CLKDIV is five bits only on 8536, 8572, and 8610, so far, but the fifth bit
+/* CLKDIV is five bits only on 8536 and 8572, so far, but the fifth bit
  * should always be zero on older parts that have a four bit CLKDIV.
  */
 #define LCRR_CLKDIV			0x0000001F
diff --git a/arch/powerpc/include/asm/fsl_pci.h b/arch/powerpc/include/asm/fsl_pci.h
index 6c6e436b6ee..fc7b1779230 100644
--- a/arch/powerpc/include/asm/fsl_pci.h
+++ b/arch/powerpc/include/asm/fsl_pci.h
@@ -258,13 +258,6 @@ int fsl_pcie_init_board(int busno);
 	FT_FSL_PCIE1_SETUP; \
 	FT_FSL_PCIE2_SETUP; \
 	FT_FSL_PCIE3_SETUP;
-#elif defined(CONFIG_MPC86xx)
-#define FSL_PCI_COMPAT	"fsl,mpc8610-pci"
-#define FSL_PCIE_COMPAT	"fsl,mpc8641-pcie"
-#define FT_FSL_PCI_SETUP \
-	FT_FSL_PCI1_SETUP; \
-	FT_FSL_PCIE1_SETUP; \
-	FT_FSL_PCIE2_SETUP;
 #else
 #error FT_FSL_PCI_SETUP not defined
 #endif
diff --git a/arch/powerpc/include/asm/global_data.h b/arch/powerpc/include/asm/global_data.h
index 710d538dad9..0d091fad418 100644
--- a/arch/powerpc/include/asm/global_data.h
+++ b/arch/powerpc/include/asm/global_data.h
@@ -44,12 +44,11 @@ struct arch_global_data {
 # endif /* CONFIG_ARCH_MPC8360 */
 #endif
 #endif
-#if defined(CONFIG_MPC85xx) || defined(CONFIG_MPC86xx)
+#if defined(CONFIG_MPC85xx)
 	u32 lbc_clk;
 	void *cpu;
-#endif /* CONFIG_MPC85xx || CONFIG_MPC86xx */
-#if defined(CONFIG_MPC83xx) || defined(CONFIG_MPC85xx) || \
-		defined(CONFIG_MPC86xx)
+#endif /* CONFIG_MPC85xx */
+#if defined(CONFIG_MPC83xx) || defined(CONFIG_MPC85xx)
 	u32 i2c1_clk;
 	u32 i2c2_clk;
 #endif
diff --git a/arch/powerpc/include/asm/ppc.h b/arch/powerpc/include/asm/ppc.h
index 2923350bd7b..740bcd910eb 100644
--- a/arch/powerpc/include/asm/ppc.h
+++ b/arch/powerpc/include/asm/ppc.h
@@ -50,9 +50,7 @@ static inline uint get_svr(void)
 	return mfspr(SVR);
 }
 
-#if defined(CONFIG_MPC85xx)	|| \
-	defined(CONFIG_MPC86xx)	|| \
-	defined(CONFIG_MPC83xx)
+#if defined(CONFIG_MPC85xx) || defined(CONFIG_MPC83xx)
 unsigned char	in8(unsigned int);
 void		out8(unsigned int, unsigned char);
 unsigned short	in16(unsigned int);
@@ -84,17 +82,7 @@ void get_sys_info(sys_info_t *);
 void ft_fixup_cpu(void *, u64);
 void ft_fixup_num_cores(void *);
 #endif
-#if defined(CONFIG_MPC86xx)
-ulong get_bus_freq(ulong);
-typedef MPC86xx_SYS_INFO sys_info_t;
-void   get_sys_info(sys_info_t *);
-static inline ulong get_ddr_freq(ulong dummy)
-{
-	return get_bus_freq(dummy);
-}
-#else
 ulong get_ddr_freq(ulong);
-#endif
 
 static inline unsigned long get_msr(void)
 {
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 6c274c9ceef..59c9e7a76a6 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -569,11 +569,6 @@
 #define MCSR_IMPE	0x00800000	/* Imprecise Machine Check Exception */
 #define ESR_ST		0x00800000	/* Store Operation */
 
-#if defined(CONFIG_MPC86xx)
-#define SPRN_MSSCR0	0x3f6
-#define SPRN_MSSSR0	0x3f7
-#endif
-
 #define SPRN_HDBCR0	0x3d0
 #define SPRN_HDBCR1	0x3d1
 #define SPRN_HDBCR2	0x3d2
@@ -646,10 +641,7 @@
 #define L2CR	SPRN_L2CR	/* PPC 750 L2 control register */
 #define LR	SPRN_LR
 #define MBAR	SPRN_MBAR	/* System memory base address */
-#if defined(CONFIG_MPC86xx)
-#define MSSCR0	SPRN_MSSCR0
-#endif
-#if defined(CONFIG_E500) || defined(CONFIG_MPC86xx)
+#if defined(CONFIG_E500)
 #define PIR	SPRN_PIR
 #endif
 #define SVR	SPRN_SVR	/* System-On-Chip Version Register */
@@ -959,8 +951,6 @@
 #define PVR_VER_E5500	0x8024
 #define PVR_VER_E6500	0x8040
 
-#define PVR_86xx	0x80040000
-
 #define PVR_VIRTEX5     0x7ff21912
 
 /*
@@ -1065,10 +1055,6 @@
 #define SVR_T2080	0x853000
 #define SVR_T2081	0x853100
 
-#define SVR_8610	0x80A000
-#define SVR_8641	0x809000
-#define SVR_8641D	0x809001
-
 #define SVR_9130	0x860001
 #define SVR_9131	0x860000
 #define SVR_9232	0x861400
@@ -1138,7 +1124,7 @@ int fixup_cpu(void);
 int fsl_qoriq_core_to_cluster(unsigned int core);
 int fsl_qoriq_dsp_core_to_cluster(unsigned int core);
 
-#if defined(CONFIG_MPC85xx) || defined(CONFIG_MPC86xx)
+#if defined(CONFIG_MPC85xx)
 #define CPU_TYPE_ENTRY(n, v, nc) \
 	{ .name = #n, .soc_ver = SVR_##v, .num_cores = (nc), \
 	  .mask = (1 << (nc)) - 1 }
diff --git a/arch/powerpc/lib/bdinfo.c b/arch/powerpc/lib/bdinfo.c
index 6491c210f4e..7c2b1746d0d 100644
--- a/arch/powerpc/lib/bdinfo.c
+++ b/arch/powerpc/lib/bdinfo.c
@@ -15,7 +15,7 @@ int arch_setup_bdinfo(void)
 {
 	struct bd_info *bd = gd->bd;
 
-#if defined(CONFIG_E500) || defined(CONFIG_MPC86xx)
+#if defined(CONFIG_E500)
 	bd->bi_immr_base = CONFIG_SYS_IMMR;	/* base  of IMMR register     */
 #endif
 
diff --git a/arch/powerpc/lib/bootm.c b/arch/powerpc/lib/bootm.c
index f9351a17a48..9b0ce9c4b81 100644
--- a/arch/powerpc/lib/bootm.c
+++ b/arch/powerpc/lib/bootm.c
@@ -21,7 +21,6 @@
 #include <u-boot/zlib.h>
 #include <bzlib.h>
 #include <asm/byteorder.h>
-#include <asm/mp.h>
 #include <bootm.h>
 #include <vxworks.h>
 
@@ -237,12 +236,6 @@ void boot_prep_vxworks(struct bootm_headers *images)
 #if defined(CONFIG_MPC85xx)
 	ft_fixup_cpu(images->ft_addr, base + size);
 	ft_fixup_num_cores(images->ft_addr);
-#elif defined(CONFIG_MPC86xx)
-	off = fdt_add_mem_rsv(images->ft_addr,
-			determine_mp_bootpg(NULL), (u64)4096);
-	if (off < 0)
-		printf("## WARNING %s: %s\n", __func__, fdt_strerror(off));
-	ft_fixup_num_cores(images->ft_addr);
 #endif
 	flush_cache((unsigned long)images->ft_addr, images->ft_len);
 #endif
diff --git a/arch/powerpc/lib/ppccache.S b/arch/powerpc/lib/ppccache.S
index e94b40ead63..b2bed5c17fb 100644
--- a/arch/powerpc/lib/ppccache.S
+++ b/arch/powerpc/lib/ppccache.S
@@ -64,7 +64,7 @@ ppcSync:
  * flush_dcache_range(unsigned long start, unsigned long stop)
  */
 _GLOBAL(flush_dcache_range)
-#if defined(CONFIG_MPC85xx) || defined(CONFIG_MPC86xx)
+#if defined(CONFIG_MPC85xx)
 	li	r5,L1_CACHE_BYTES-1
 	andc	r3,r3,r5
 	subf	r4,r3,r4
@@ -88,7 +88,7 @@ _GLOBAL(flush_dcache_range)
  * invalidate_dcache_range(unsigned long start, unsigned long stop)
  */
 _GLOBAL(invalidate_dcache_range)
-#if defined(CONFIG_MPC85xx) || defined(CONFIG_MPC86xx)
+#if defined(CONFIG_MPC85xx)
 	li	r5,L1_CACHE_BYTES-1
 	andc	r3,r3,r5
 	subf	r4,r3,r4
diff --git a/arch/powerpc/lib/stack.c b/arch/powerpc/lib/stack.c
index afd869e4ac3..232f9758bf5 100644
--- a/arch/powerpc/lib/stack.c
+++ b/arch/powerpc/lib/stack.c
@@ -33,7 +33,7 @@ int arch_reserve_stacks(void)
 
 int arch_setup_dest_addr(void)
 {
-#if defined(CONFIG_MP) && (defined(CONFIG_MPC86xx) || defined(CONFIG_E500))
+#if defined(CONFIG_MP) && defined(CONFIG_E500)
 	/*
 	 * We need to make sure the location we intend to put secondary core
 	 * boot code is reserved and not used by any part of u-boot
diff --git a/common/board_r.c b/common/board_r.c
index a397e20959d..d1b9663aa5b 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -129,7 +129,7 @@ static int initr_reloc_global_data(void)
 #elif !defined(CONFIG_SANDBOX) && !defined(CONFIG_NIOS2)
 	monitor_flash_len = (ulong)__init_end - gd->relocaddr;
 #endif
-#if defined(CONFIG_MPC85xx) || defined(CONFIG_MPC86xx)
+#if defined(CONFIG_MPC85xx)
 	/*
 	 * The gd->cpu pointer is set to an address in flash before relocation.
 	 * We need to update it to point to the same CPU entry in RAM.
diff --git a/drivers/ddr/fsl/Kconfig b/drivers/ddr/fsl/Kconfig
index 7a3aa7e2087..c4b7ec768e8 100644
--- a/drivers/ddr/fsl/Kconfig
+++ b/drivers/ddr/fsl/Kconfig
@@ -93,7 +93,6 @@ config SYS_FSL_DDRC_GEN1
 
 config SYS_FSL_DDRC_GEN2
 	bool
-	depends on !MPC86xx
 	help
 	  Enable Freescale DDR2 controller.
 
@@ -150,7 +149,7 @@ config SYS_FSL_DDR2
 	bool "Freescale DDR2 controller"
 	depends on SYS_FSL_HAS_DDR2
 	imply DDR_SPD
-	select SYS_FSL_DDRC_GEN2 if (!MPC86xx && !SYS_FSL_DDRC_GEN3)
+	select SYS_FSL_DDRC_GEN2 if !SYS_FSL_DDRC_GEN3
 
 config SYS_FSL_DDR1
 	bool "Freescale DDR1 controller"
diff --git a/drivers/ddr/fsl/ctrl_regs.c b/drivers/ddr/fsl/ctrl_regs.c
index fea08c9000f..e8dc6890330 100644
--- a/drivers/ddr/fsl/ctrl_regs.c
+++ b/drivers/ddr/fsl/ctrl_regs.c
@@ -42,7 +42,6 @@
  *	4 = 20 ohm
  *	5 = 30 ohm
  *
- * FIXME: Apparently 8641 needs a value of 2
  * FIXME: Old code seys if 667 MHz or higher, use 3 on 8572
  *
  * FIXME: There was some effort down this line earlier:
diff --git a/drivers/dma/fsl_dma.c b/drivers/dma/fsl_dma.c
index e5d242f4f8f..44ba63f2930 100644
--- a/drivers/dma/fsl_dma.c
+++ b/drivers/dma/fsl_dma.c
@@ -25,8 +25,6 @@
 dma83xx_t *dma_base = (void *)(CFG_SYS_MPC83xx_DMA_ADDR);
 #elif defined(CONFIG_MPC85xx)
 ccsr_dma_t *dma_base = (void *)(CFG_SYS_MPC85xx_DMA_ADDR);
-#elif defined(CONFIG_MPC86xx)
-ccsr_dma_t *dma_base = (void *)(CONFIG_SYS_MPC86xx_DMA_ADDR);
 #else
 #error "Freescale DMA engine not supported on your processor"
 #endif
@@ -35,8 +33,6 @@ static void dma_sync(void)
 {
 #if defined(CONFIG_MPC85xx)
 	asm("sync; isync; msync");
-#elif defined(CONFIG_MPC86xx)
-	asm("sync; isync");
 #endif
 }
 
diff --git a/drivers/gpio/mpc8xxx_gpio.c b/drivers/gpio/mpc8xxx_gpio.c
index 40646407369..bfa62be9dc7 100644
--- a/drivers/gpio/mpc8xxx_gpio.c
+++ b/drivers/gpio/mpc8xxx_gpio.c
@@ -316,7 +316,6 @@ static const struct udevice_id mpc8xxx_gpio_ids[] = {
 	{ .compatible = "fsl,mpc8308-gpio", .data = MPC8XXX_GPIO_TYPE },
 	{ .compatible = "fsl,mpc8349-gpio", .data = MPC8XXX_GPIO_TYPE },
 	{ .compatible = "fsl,mpc8572-gpio", .data = MPC8XXX_GPIO_TYPE},
-	{ .compatible = "fsl,mpc8610-gpio", .data = MPC8XXX_GPIO_TYPE},
 	{ .compatible = "fsl,mpc5121-gpio", .data = MPC5121_GPIO_TYPE, },
 	{ .compatible = "fsl,qoriq-gpio", .data = MPC8XXX_GPIO_TYPE },
 	{ /* sentinel */ }
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 86fafc5a3c7..c32cf344f81 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -187,7 +187,7 @@ config PCIE_FSL
 	depends on PPC
 	help
 	  Say Y here if you want to enable PCIe controller support on FSL
-	  PowerPC MPC85xx, MPC86xx, B series, P series and T series SoCs.
+	  PowerPC MPC85xx, B series, P series and T series SoCs.
 	  This driver does not support SRIO_PCIE_BOOT feature.
 
 config PCI_MPC85XX
diff --git a/env/Kconfig b/env/Kconfig
index fa4cf30af39..08fa5a4ecd0 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -155,7 +155,7 @@ config ENV_IS_IN_FLASH
 	default y if ARCH_INTEGRATOR_CP
 	default y if M548x || M547x || M5282
 	default y if MCF532x || MCF52x2
-	default y if MPC86xx || MPC83xx
+	default y if MPC83xx
 	default y if SH && !CPU_SH4
 	help
 	  Define this if you have a flash device which you want to use for the
diff --git a/include/asm-generic/u-boot.h b/include/asm-generic/u-boot.h
index 931fe2f3274..ead690f6c65 100644
--- a/include/asm-generic/u-boot.h
+++ b/include/asm-generic/u-boot.h
@@ -35,7 +35,7 @@ struct bd_info {
 	unsigned long	bi_dsp_freq; /* dsp core frequency */
 	unsigned long	bi_ddr_freq; /* ddr frequency */
 #endif
-#if defined(CONFIG_MPC8xx) || defined(CONFIG_E500) || defined(CONFIG_MPC86xx)
+#if defined(CONFIG_MPC8xx) || defined(CONFIG_E500)
 	unsigned long	bi_immr_base;	/* base of IMMR register */
 #endif
 #if defined(CONFIG_M68K)
diff --git a/include/fsl_immap.h b/include/fsl_immap.h
index 54d6e0ab377..ea5d214e499 100644
--- a/include/fsl_immap.h
+++ b/include/fsl_immap.h
@@ -12,7 +12,7 @@
 
 /*
  * DDR memory controller registers
- * This structure works for mpc83xx (DDR2 and DDR3), mpc85xx, mpc86xx.
+ * This structure works for mpc83xx (DDR2 and DDR3) and mpc85xx.
  */
 struct ccsr_ddr {
 	u32	cs0_bnds;		/* Chip Select 0 Memory Bounds */
diff --git a/include/pci_ids.h b/include/pci_ids.h
index cfff275daba..96e84a779ff 100644
--- a/include/pci_ids.h
+++ b/include/pci_ids.h
@@ -2509,10 +2509,6 @@
 #define PCI_DEVICE_ID_P5020		0x0421
 #define PCI_DEVICE_ID_P5010E		0x0428
 #define PCI_DEVICE_ID_P5010		0x0429
-#define PCI_DEVICE_ID_MPC8641		0x7010
-#define PCI_DEVICE_ID_MPC8641D		0x7011
-#define PCI_DEVICE_ID_MPC8610		0x7018
-
 #define PCI_VENDOR_ID_PASEMI		0x1959
 
 #define PCI_VENDOR_ID_ATTANSIC		0x1969
diff --git a/include/serial.h b/include/serial.h
index 0a707ca730d..0b0179e6c0b 100644
--- a/include/serial.h
+++ b/include/serial.h
@@ -28,7 +28,6 @@ extern struct serial_device serial_scc_device;
 extern struct serial_device *default_serial_console(void);
 
 #if	defined(CONFIG_MPC83xx) || defined(CONFIG_MPC85xx) || \
-	defined(CONFIG_MPC86xx) || \
 	defined(CONFIG_ARCH_TEGRA) || defined(CONFIG_SYS_COREBOOT) || \
 	defined(CONFIG_MICROBLAZE)
 extern struct serial_device serial0_device;
-- 
2.47.3

