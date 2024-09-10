Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC7EECE582
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 09:40:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0417488FCB;
	Tue, 10 Sep 2024 11:39:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D31988F63; Tue, 10 Sep 2024 11:39:33 +0200 (CEST)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 983A488FA8
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:39:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chiawei_wang@aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 10 Sep
 2024 17:39:21 +0800
Received: from mail.aspeedtech.com (192.168.10.152) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 10 Sep 2024 17:39:21 +0800
From: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
To: <rick@andestech.com>, <ycliang@andestech.com>, <trini@konsulko.com>,
 <ryan_chen@aspeedtech.com>, <joel@jms.id.au>, <u-boot@lists.denx.de>
Subject: [PATCH v2 6/8] board: ibex_ast2700: Add FMC header support
Date: Tue, 10 Sep 2024 17:39:18 +0800
Message-ID: <20240910093920.1142455-7-chiawei_wang@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240910093920.1142455-1-chiawei_wang@aspeedtech.com>
References: <20240910093920.1142455-1-chiawei_wang@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Define and parse the header of the First Mutable Code (FMC)
of AST2700 SoCs at runtime phase.

The FMC header contains the information to load prebuilt binaries
required for device initialization such as DRAM and VGA.

Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 arch/riscv/include/asm/arch-ast2700/fmc_hdr.h | 52 +++++++++++++++
 board/aspeed/ibex_ast2700/Makefile            |  1 +
 board/aspeed/ibex_ast2700/fmc_hdr.c           | 64 +++++++++++++++++++
 3 files changed, 117 insertions(+)
 create mode 100644 arch/riscv/include/asm/arch-ast2700/fmc_hdr.h
 create mode 100644 board/aspeed/ibex_ast2700/fmc_hdr.c

diff --git a/arch/riscv/include/asm/arch-ast2700/fmc_hdr.h b/arch/riscv/include/asm/arch-ast2700/fmc_hdr.h
new file mode 100644
index 00000000000..fbbcdb25cca
--- /dev/null
+++ b/arch/riscv/include/asm/arch-ast2700/fmc_hdr.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) ASPEED Technology Inc.
+ */
+
+#ifndef __ASM_AST2700_FMC_HDR_H__
+#define __ASM_AST2700_FMC_HDR_H__
+
+#include <linux/types.h>
+
+#define HDR_MAGIC		0x48545341	/* ASTH */
+#define HDR_PB_MAX		30
+
+enum prebuilt_type {
+	PBT_END_MARK = 0x0,
+
+	PBT_DDR4_PMU_TRAIN_IMEM,
+	PBT_DDR4_PMU_TRAIN_DMEM,
+	PBT_DDR4_2D_PMU_TRAIN_IMEM,
+	PBT_DDR4_2D_PMU_TRAIN_DMEM,
+	PBT_DDR5_PMU_TRAIN_IMEM,
+	PBT_DDR5_PMU_TRAIN_DMEM,
+	PBT_DP_FW,
+	PBT_UEFI_X64_AST2700,
+
+	PBT_NUM
+};
+
+struct fmc_hdr_preamble {
+	uint32_t magic;
+	uint32_t version;
+};
+
+struct fmc_hdr_body {
+	uint32_t fmc_size;
+	union {
+		struct {
+			uint32_t type;
+			uint32_t size;
+		} pbs[0];
+		uint32_t raz[29];
+	};
+};
+
+struct fmc_hdr {
+	struct fmc_hdr_preamble preamble;
+	struct fmc_hdr_body body;
+} __packed;
+
+int fmc_hdr_get_prebuilt(uint32_t type, uint32_t *ofst, uint32_t *size);
+
+#endif
diff --git a/board/aspeed/ibex_ast2700/Makefile b/board/aspeed/ibex_ast2700/Makefile
index 162f46fd46a..3d8eea9166d 100644
--- a/board/aspeed/ibex_ast2700/Makefile
+++ b/board/aspeed/ibex_ast2700/Makefile
@@ -1,2 +1,3 @@
 obj-y += ibex_ast2700.o
+obj-y += fmc_hdr.o
 obj-y += sli.o
diff --git a/board/aspeed/ibex_ast2700/fmc_hdr.c b/board/aspeed/ibex_ast2700/fmc_hdr.c
new file mode 100644
index 00000000000..2068a906f60
--- /dev/null
+++ b/board/aspeed/ibex_ast2700/fmc_hdr.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) Aspeed Technology Inc.
+ */
+
+#include <asm/arch/fmc_hdr.h>
+#include <asm/io.h>
+#include <asm/sections.h>
+#include <errno.h>
+#include <spl.h>
+#include <string.h>
+
+int fmc_hdr_get_prebuilt(uint32_t type, uint32_t *ofst, uint32_t *size)
+{
+	struct fmc_hdr_preamble *preamble;
+	struct fmc_hdr_body *body;
+	struct fmc_hdr *hdr;
+	uint32_t t, s, o;
+	int i;
+
+	if (type >= PBT_NUM)
+		return -EINVAL;
+
+	if (!ofst || !size)
+		return -EINVAL;
+
+	hdr = (struct fmc_hdr *)(_start - sizeof(*hdr));
+	preamble = &hdr->preamble;
+	body = &hdr->body;
+
+	if (preamble->magic != HDR_MAGIC)
+		return -EIO;
+
+	for (i = 0, o = sizeof(*hdr) + body->fmc_size; i < HDR_PB_MAX; ++i) {
+		t = body->pbs[i].type;
+		s = body->pbs[i].size;
+
+		/* skip if unrecognized, yet */
+		if (t >= PBT_NUM) {
+			o += s;
+			continue;
+		}
+
+		/* prebuilt end mark */
+		if (t == 0 && s == 0)
+			break;
+
+		/* return the prebuilt info if found */
+		if (t == type) {
+			*ofst = o;
+			*size = s;
+
+			goto found;
+		}
+
+		/* update offset for next prebuilt */
+		o += s;
+	}
+
+	return -ENODATA;
+
+found:
+	return 0;
+}
-- 
2.25.1

