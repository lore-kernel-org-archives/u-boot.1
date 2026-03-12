Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BFA6FED2FE
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 10:08:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F55784166;
	Thu, 12 Mar 2026 11:08:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="g1Hjx39G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 491088416C; Thu, 12 Mar 2026 11:08:48 +0100 (CET)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46EF484150
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 11:08:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Max.Merchel@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=DNuKQoTZTwwTTvov1JeCyxbeWWyVSrtrHK6liINwKCg=; b=g1Hjx39GF56Ktjat51IUmgXhUi
 yutDAHIjl7aNN2N81Lhv/AEZDpWJRKKq1WYSUzdy7qQlmIkdRv9hsWCPajpSXpwFS8nB5PuKL5jeP
 e8vhidBDpnazQUnvlarsCoGu9X4dK2FzPGwCNsTI5HgEbtO2e1DOgCfLf8+hbLAXTsr4rK3Q0u2ug
 NaOYqYf1N3duhKlKzvl6uindVAt80jvK3Zo+fE12iszJpxMu30oza0YM/r0fXTwNVplfFdtsSkBxn
 K9cZ/OdQofqz//L9BO2YtSdd6ZuU5BSl50FdJ/7ZlFDt/XfpEsGLZVHxJ8zv2jgUqOxHLaJyb7U/7
 vAFfjcqw==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1w0cyD-000A6P-1r; Thu, 12 Mar 2026 11:08:45 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1w0cnT-000Fyo-0i; Thu, 12 Mar 2026 10:57:39 +0100
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Paul Gerber <Paul.Gerber@ew.tq-group.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, Max Merchel <Max.Merchel@ew.tq-group.com>
Subject: [PATCH 13/13] board: tqma6: update eMMC DSR handling
Date: Thu, 12 Mar 2026 10:57:09 +0100
Message-ID: <20260312095711.3219756-14-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312095711.3219756-1-Max.Merchel@ew.tq-group.com>
References: <20260312095711.3219756-1-Max.Merchel@ew.tq-group.com>
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

From: Paul Gerber <Paul.Gerber@ew.tq-group.com>

New SoM revision use series termination for eMMC signals while older do
not. To prevent signal overshot on older revisions, DSR must be set and
limited. The eMMC type is used to differentiate between revisions.
Keep a table with all types, that are known to require DSR.

Signed-off-by: Paul Gerber <Paul.Gerber@ew.tq-group.com>
Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 board/tq/tqma6/Makefile     |  1 +
 board/tq/tqma6/tqma6.c      | 24 +++++++---
 board/tq/tqma6/tqma6_emmc.c | 88 +++++++++++++++++++++++++++++++++++++
 board/tq/tqma6/tqma6_emmc.h | 19 ++++++++
 4 files changed, 125 insertions(+), 7 deletions(-)
 create mode 100644 board/tq/tqma6/tqma6_emmc.c
 create mode 100644 board/tq/tqma6/tqma6_emmc.h

diff --git a/board/tq/tqma6/Makefile b/board/tq/tqma6/Makefile
index f1b39844ac6..ecebc28315d 100644
--- a/board/tq/tqma6/Makefile
+++ b/board/tq/tqma6/Makefile
@@ -6,6 +6,7 @@
 #
 
 obj-y  := tqma6.o
+obj-y  += tqma6_emmc.o
 
 obj-$(CONFIG_MBA6) += tqma6_mba6.o
 obj-$(CONFIG_WRU4) += tqma6_wru4.o
diff --git a/board/tq/tqma6/tqma6.c b/board/tq/tqma6/tqma6.c
index a3a0a11c42b..005f08c4e5f 100644
--- a/board/tq/tqma6/tqma6.c
+++ b/board/tq/tqma6/tqma6.c
@@ -26,6 +26,7 @@
 #include <power/pfuze100_pmic.h>
 #include <power/pmic.h>
 
+#include "tqma6_emmc.h"
 #include "../common/tq_bb.h"
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -37,8 +38,6 @@ int dram_init(void)
 	return 0;
 }
 
-static const uint16_t tqma6_emmc_dsr = 0x0100;
-
 int board_early_init_f(void)
 {
 	return tq_bb_board_early_init_f();
@@ -46,9 +45,13 @@ int board_early_init_f(void)
 
 int board_init(void)
 {
+	struct mmc *mmc = find_mmc_device(0);
+
 	/* address of boot parameters */
 	gd->bd->bi_boot_params = PHYS_SDRAM + 0x100;
 
+	tqma6_mmc_detect_card_type(mmc);
+
 	tq_bb_board_init();
 
 	return 0;
@@ -111,17 +114,24 @@ int board_late_init(void)
 #define MODELSTRLEN 32u
 int ft_board_setup(void *blob, struct bd_info *bd)
 {
+	struct mmc *mmc = find_mmc_device(0);
 	char modelstr[MODELSTRLEN];
 
 	snprintf(modelstr, MODELSTRLEN, "TQ %s on %s", tqma6_get_boardname(),
 		 tq_bb_get_boardname());
 	do_fixup_by_path_string(blob, "/", "model", modelstr);
 	fdt_fixup_memory(blob, (u64)PHYS_SDRAM, (u64)gd->ram_size);
-	/* bring in eMMC dsr settings */
-	do_fixup_by_path_u32(blob,
-			     "/soc/aips-bus@02100000/usdhc@02198000",
-			     "dsr", tqma6_emmc_dsr, 2);
-	tq_bb_ft_board_setup(blob, bd);
+
+	/* bring in eMMC dsr settings if needed */
+	if (mmc && (!mmc_init(mmc))) {
+		if (tqma6_emmc_need_dsr(mmc) > 0) {
+			tqma6_ft_fixup_emmc_dsr(blob,
+						"/soc/bus@2100000/mmc@2198000",
+						TQMA6_EMMC_DSR);
+		}
+	} else {
+		puts("eMMC: not present?\n");
+	}
 
 	return 0;
 }
diff --git a/board/tq/tqma6/tqma6_emmc.c b/board/tq/tqma6/tqma6_emmc.c
new file mode 100644
index 00000000000..dd7c4d45c5c
--- /dev/null
+++ b/board/tq/tqma6/tqma6_emmc.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2017-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
+ */
+
+#include <fdt_support.h>
+#include <mmc.h>
+
+#include "tqma6_emmc.h"
+
+struct emmc_dsr_lookup {
+	uint mfgid;
+	char *pnm;
+	int dsr_needed;
+};
+
+static const struct emmc_dsr_lookup dsr_tbl[] = {
+	/* Micron, eMMC 4.41 */
+	{ 0xfe, "MMC02G", 1 },
+	{ 0xfe, "MMC04G", 1 },
+	{ 0xfe, "MMC08G", 1 },
+	/* Micron, eMMC 5.0 4 GB*/
+	{ 0x13, "Q1J54A", 1 },
+	{ 0x13, "Q2J54A", 1 },
+	/* Micron, eMMC 5.0 8 GB*/
+	{ 0x13, "Q2J55L", 0 },
+	/* Samsung, eMMC 5.0 */
+	{ 0x15, "8GSD3R", 0 },
+	{ 0x15, "AGSD3R", 0 },
+	{ 0x15, "BGSD3R", 0 },
+	{ 0x15, "CGSD3R", 0 },
+	/* SanDisk, iNAND 7250 5.1 */
+	{ 0x45, "DG4008", 0 },
+	{ 0x45, "DG4016", 0 },
+	{ 0x45, "DG4032", 0 },
+	{ 0x45, "DG4064", 0 },
+	/* Kingston */
+	{ 0x100, "?????", 0 },
+};
+
+int tqma6_emmc_need_dsr(const struct mmc *mmc)
+{
+	uint mfgid = mmc->cid[0] >> 24;
+	char name[7];
+	int ret = -1;
+	size_t i;
+
+	if (IS_SD(mmc))
+		return 0;
+
+	sprintf(name, "%c%c%c%c%c%c", mmc->cid[0] & 0xff, (mmc->cid[1] >> 24),
+		(mmc->cid[1] >> 16) & 0xff, (mmc->cid[1] >> 8) & 0xff,
+		mmc->cid[1] & 0xff, (mmc->cid[2] >> 24));
+
+	for (i = 0; i < ARRAY_SIZE(dsr_tbl) && (ret < 0); ++i) {
+		if (dsr_tbl[i].mfgid == mfgid &&
+		    (!strncmp(name, dsr_tbl[i].pnm, 6))) {
+			ret = dsr_tbl[i].dsr_needed;
+			debug("MFG: %x PNM: %s\n", mfgid, name);
+		}
+	}
+
+	if (ret < 0) {
+		printf("eMMC unknown: MFG: %x PNM: %s\n", mfgid, name);
+		/* request DSR, even if not known if supported to be safe */
+		ret = 1;
+	}
+
+	return ret;
+}
+
+void tqma6_ft_fixup_emmc_dsr(void *blob, const char *path, u32 value)
+{
+	do_fixup_by_path_u32(blob, path, "dsr", value, 1);
+}
+
+void tqma6_mmc_detect_card_type(struct mmc *mmc)
+{
+	struct mmc *emmc = find_mmc_device(0);
+
+	if (emmc != mmc)
+		return;
+
+	if (tqma6_emmc_need_dsr(mmc) > 0)
+		mmc_set_dsr(mmc, TQMA6_EMMC_DSR);
+}
diff --git a/board/tq/tqma6/tqma6_emmc.h b/board/tq/tqma6/tqma6_emmc.h
new file mode 100644
index 00000000000..5ab6c3ac11d
--- /dev/null
+++ b/board/tq/tqma6/tqma6_emmc.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2017-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
+ */
+
+#ifndef __TQMA6_EMMC_H__
+#define __TQMA6_EMMC_H__
+
+#define TQMA6_EMMC_DSR		0x0100
+
+struct mmc;
+
+int tqma6_emmc_need_dsr(const struct mmc *mmc);
+void tqma6_ft_fixup_emmc_dsr(void *blob, const char *path, u32 value);
+void tqma6_mmc_detect_card_type(struct mmc *mmc);
+
+#endif /* __TQMA6_EMMC_H__ */
-- 
2.43.0

