Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C7CFC5DF66
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 15:34:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 27E8C407D0;
	Mon, 17 Aug 2026 15:34:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gb063GB3gBOX; Mon, 17 Aug 2026 15:34:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 344FE4072F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786980850;
	bh=6U2A/jURnayq6Nw6wHIaJgwpre5Dlw4hHYO1QnI0hEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i/l9uGjsNKqAsO8CaS8bqPofvd30c5V8V5WFAIYgawL5zdo7NClglCGCV1po4OR2w
	 8AU80Uq+IXsaKGOrDrsghMD8v5OSpAuL5qjqBawXxwgONUpUEX+Jtj3lFtV6vCtynz
	 oiGvM+46siDal6jjUnztoEFwGu+id1wMhNVt/kQB0mj+37QOTUFeqLxX6lUcDFUMoe
	 LFADNZbkf5vh7Loy47pZ0eULTrBKDCFFmhegsxPBOS8CCOe0oqrcCB1F3YPRviZaDJ
	 o61RCKu5TveUr2RLBimumY2+HWyIHdIgAWfQ4t/irRhc2rnGhTfTIbXT8jMBW+7ptj
	 Ivfq6rpI57haQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 344FE4072F;
	Mon, 17 Aug 2026 15:34:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0C14C282
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:34:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E689C4072F
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:34:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rA00h4uDyIAc for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 15:34:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D2C4440791
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D2C4440791
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=JPqO7VQ+
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D2C4440791
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:34:07 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 461D5B00563;
 Mon, 17 Aug 2026 17:33:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1786980845;
 bh=/YIPJD1uM/n8n6F4pbf7m/uxqD/C2Z3JiwuLwlpCqIM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JPqO7VQ+IoQKTYSr0cln58OsI7YCW8OJND05XpJlm7wSDn2I0o5EADk7VZUcS+n1h
 xDZqJT90EylpMXmDHGXZBigjYBBf7t7lPLDMei+iTgEq4OapYLETUvOkIm3Tng21nA
 DBLXZFPkVcWk237fgSGdABANOGAbis0+qDAntFP2he8HhLxFhLJGmALETwBomQfSYj
 Tr5YYnb+/SvMdHXGbWKHyWxI5bOK2vqN3vrxBS0NQShSqD4aVwWQQtnriL+kH/OmIa
 ZJ0EMpvB9oSwTZLqeqB4GxtDr3Zxl4PcvsAJPqp79B/8mR9yc6iCNgMePJ4dMWoQ6P
 w7C0Defanhhcw==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Wasim Khan <wasim.khan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 07/23] board: nbxv3: select carrier at boot
Date: Mon, 17 Aug 2026 17:31:25 +0200
Message-ID: <20260817153144.1951036-8-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817153144.1951036-1-vjardin@free.fr>
References: <20260817153144.1951036-1-vjardin@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The Nodebox v3 CPU module runs on several carriers. They share one
kernel Image but need different DTBs and different DPAA2 DPC/DPL, so
the kernel FIT carries every carrier's set as fdt-<c> / dpc-<c> /
dpl-<c> with a conf-<c> configuration each, and U-Boot picks one:

  mcinitcmd   imxtract ... dpc-${carrier} / dpl-${carrier}
  mc_init     bootm ${kernel_addr_r}#conf-${carrier}

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

 board/nxp/lx2160a/nbxv3/Makefile    |  1 +
 board/nxp/lx2160a/nbxv3/carrier.c   | 87 +++++++++++++++++++++++++++++
 board/nxp/lx2160a/nbxv3/carrier.h   | 17 ++++++
 board/nxp/lx2160a/nbxv3/eth_nbxv3.c | 10 ++++
 4 files changed, 115 insertions(+)
 create mode 100644 board/nxp/lx2160a/nbxv3/carrier.c
 create mode 100644 board/nxp/lx2160a/nbxv3/carrier.h

diff --git a/board/nxp/lx2160a/nbxv3/Makefile b/board/nxp/lx2160a/nbxv3/Makefile
index 68fab9bf18f..4ce2508249d 100644
--- a/board/nxp/lx2160a/nbxv3/Makefile
+++ b/board/nxp/lx2160a/nbxv3/Makefile
@@ -3,6 +3,7 @@
 #
 
 obj-y += eth_nbxv3.o
+obj-y += carrier.o
 obj-y += mps_pmbus.o
 obj-y += psu_pmbus.o
 obj-y += vid_handoff.o
diff --git a/board/nxp/lx2160a/nbxv3/carrier.c b/board/nxp/lx2160a/nbxv3/carrier.c
new file mode 100644
index 00000000000..231aaf1e3f1
--- /dev/null
+++ b/board/nxp/lx2160a/nbxv3/carrier.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 Free Mobile - Vincent Jardin
+ *
+ * Nodebox v3 carrier selector.
+ *
+ * The CPU module is used on several carrier boards (nbv30, nbv32, ...).
+ * They share one kernel Image but need different DTBs and different
+ * DPAA2 DPC/DPL, it is up to the build framework (buildroot, etc.) to
+ * puts all of them into the single kernel FIT.
+ *
+ *   images:         fdt-<carrier>, dpc-<carrier>, dpl-<carrier>
+ *   configurations: conf-<carrier>
+ *
+ * and then the boot env picks one with ${carrier}:
+ *
+ *   mcinitcmd  imxtract ... dpc-${carrier} / dpl-${carrier}
+ *   mc_init    bootm ${kernel_addr_r}#conf-${carrier}
+ *
+ * Change it from the prompt and make it persistent:
+ *
+ *   setenv carrier nbv32 && saveenv && reset
+ *
+ * WHY THIS FILE EXISTS RATHER THAN JUST A DEFAULT IN CFG_EXTRA_ENV_SETTINGS:
+ * A default there only applies when the saved
+ * environment is absent or fails its CRC: env_import() calls himport_r()
+ * WITHOUT H_NOCLEAR, so a valid saved env in NOR replaces the built-in
+ * defaults wholesale rather than merging with them. Every board already
+ * running with a saved env would therefore come up with ${carrier}
+ * EMPTY on the first boot after this feature lands, `bootm
+ * ${kernel_addr_r}#conf-` would fail with
+ * "Could not find configuration node".
+ * Setting
+ * it from C on every boot when it is missing makes any upgrade
+ * invisible, and still lets an explicitly saved value.
+ *
+ * Called from reset_phy() in eth_nbxv3.c ; it is during initr_net,
+ * after initr_env has loaded the saved environment and BEFORE
+ * mc_env_boot() evaluates ${mcinitcmd}, which is the earliest consumer.
+ * (board_late_init() would also be early enough, but it this logic is
+ * specific for the nbx boards, we do not want to touch.
+ * shared arch/arm/cpu/armv8/fsl-layerscape/soc.c
+ *
+ */
+
+#include <env.h>
+#include <linux/kernel.h>
+#include <vsprintf.h>
+
+#include "carrier.h"
+
+#ifndef NBXV3_CARRIER_DEFAULT
+#define NBXV3_CARRIER_DEFAULT "nbv30"
+#endif
+
+/*
+ * Placeholder for strap/EEPROM based identification.
+ * Returning NULL means "cannot tell".
+ */
+static const char *nbxv3_carrier_detect(void)
+{
+	/* TODO, not available yet */
+	return NULL;
+}
+
+void nbxv3_carrier_env_init(void)
+{
+	const char *carrier = env_get("carrier");
+	const char *detected;
+
+	if (carrier && *carrier) {
+		printf("Carrier:       %s (from env)\n", carrier);
+		return;
+	}
+
+	detected = nbxv3_carrier_detect();
+	if (!detected)
+		detected = NBXV3_CARRIER_DEFAULT;
+
+	if (env_set("carrier", detected)) {
+		printf("Carrier:       WARNING: cannot set ${carrier}\n");
+		return;
+	}
+
+	/* Not saved on purpose: saveenv on every boot would burn our NOR */
+	printf("Carrier:       %s (default, not saved - `setenv carrier <name> && saveenv` to pin)\n", detected);
+}
diff --git a/board/nxp/lx2160a/nbxv3/carrier.h b/board/nxp/lx2160a/nbxv3/carrier.h
new file mode 100644
index 00000000000..e7eb42265e4
--- /dev/null
+++ b/board/nxp/lx2160a/nbxv3/carrier.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2026 Free Mobile - Vincent Jardin
+ */
+
+#ifndef __NBXV3_CARRIER_H
+#define __NBXV3_CARRIER_H
+
+/*
+ * Ensure ${carrier} is set before anything consumes it.
+ * It is idempotent, and it never overrides a value already present
+ * in the uboot's environment.
+ * It shall run after initr_env and before ${mcinitcmd} is evaluated.
+ */
+void nbxv3_carrier_env_init(void);
+
+#endif /* __NBXV3_CARRIER_H */
diff --git a/board/nxp/lx2160a/nbxv3/eth_nbxv3.c b/board/nxp/lx2160a/nbxv3/eth_nbxv3.c
index eb91d47add5..58bf8246aa0 100644
--- a/board/nxp/lx2160a/nbxv3/eth_nbxv3.c
+++ b/board/nxp/lx2160a/nbxv3/eth_nbxv3.c
@@ -21,6 +21,8 @@
 #include <exports.h>
 #include <fsl-mc/fsl_mc.h>
 
+#include "carrier.h"
+
 DECLARE_GLOBAL_DATA_PTR;
 
 int board_eth_init(struct bd_info *bis)
@@ -31,6 +33,14 @@ int board_eth_init(struct bd_info *bis)
 #if defined(CONFIG_RESET_PHY_R)
 void reset_phy(void)
 {
+	/*
+	 * MUST come first: mc_env_boot() evaluates ${mcinitcmd}, which
+	 * imxtracts dpc-${carrier} / dpl-${carrier} out of the FIT. If
+	 * ${carrier} is still unset a subimage named "dpc-" and the MC
+	 * firmware never starts.
+	 */
+	nbxv3_carrier_env_init();
+
 #if defined(CONFIG_FSL_MC_ENET)
 	mc_env_boot();
 #endif
-- 
2.43.0

