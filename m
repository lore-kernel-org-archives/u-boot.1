Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24374FEA83D
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 09:59:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02B8C83FDC;
	Wed, 25 Mar 2026 10:58:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="ZSiH/O9O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AF1F81E18; Wed, 25 Mar 2026 10:58:20 +0100 (CET)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA91C83E4C
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 10:58:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Alexander.Feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=t9BpzXB3en9RK5VxsGqjTqOxAYQeC301QyKT8yBqrno=; b=ZSiH/O9OlYMFihIGOKGgABgOK9
 +D/eWnQqlCfk/gMmjsS1bC8odjd98cLb6YZPVIbhfAlMEe30ZeP/vUIXyLToiNikZGHX1eNndLdyw
 ycNOKMZb9EZ5KQxNcw7S6Mlt+XTog9HBzX+GAIf/wpf54wmb9LzSkk51LTsLJI8wBZIT5MzKYs23C
 H3z0cJmvHi2rASFE0875kiI4GzoWWZe66xRS6BhzZScREXyPXgio7ImWPFSI9Tk9C3eNMeSZ/2/zn
 XidDbTk11E76yO12C67z5Pw1pIi8Njz4axVfymHPaebAcBKtG9Lzp2gOABP7aEr+Th5KFzAFyha+e
 4IX3R/jA==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1w5L08-0009ly-0i; Wed, 25 Mar 2026 10:58:12 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1w5L07-000HPv-3A; Wed, 25 Mar 2026 10:58:11 +0100
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Cc: Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 Alexander Feilke <Alexander.Feilke@ew.tq-group.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Max Merchel <Max.Merchel@ew.tq-group.com>
Subject: [PATCH v2 2/8] board/tq: Add common SoM API
Date: Wed, 25 Mar 2026 10:57:55 +0100
Message-Id: <20260325095801.47706-3-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325095801.47706-1-Alexander.Feilke@ew.tq-group.com>
References: <20260325095801.47706-1-Alexander.Feilke@ew.tq-group.com>
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

From: Alexander Feilke <alexander.feilke@ew.tq-group.com>

Reduce code duplication by adding a default implementation.

Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 board/tq/common/Kconfig  |  3 +++
 board/tq/common/Makefile |  1 +
 board/tq/common/tq_som.c | 32 ++++++++++++++++++++++++++++++++
 board/tq/common/tq_som.h | 34 ++++++++++++++++++++++++++++++++++
 4 files changed, 70 insertions(+)
 create mode 100644 board/tq/common/tq_som.c
 create mode 100644 board/tq/common/tq_som.h

diff --git a/board/tq/common/Kconfig b/board/tq/common/Kconfig
index a1896929ea3..2fe2ca30072 100644
--- a/board/tq/common/Kconfig
+++ b/board/tq/common/Kconfig
@@ -11,3 +11,6 @@ config TQ_COMMON_BB
 
 config TQ_COMMON_SDMMC
 	bool
+
+config TQ_COMMON_SOM
+	bool
diff --git a/board/tq/common/Makefile b/board/tq/common/Makefile
index ac564a713fd..4af9207da4a 100644
--- a/board/tq/common/Makefile
+++ b/board/tq/common/Makefile
@@ -6,4 +6,5 @@
 #
 
 obj-$(CONFIG_TQ_COMMON_BB) += tq_bb.o
+obj-$(CONFIG_TQ_COMMON_SOM) += tq_som.o
 obj-$(CONFIG_TQ_COMMON_SDMMC) += tq_sdmmc.o
diff --git a/board/tq/common/tq_som.c b/board/tq/common/tq_som.c
new file mode 100644
index 00000000000..6fb4839109b
--- /dev/null
+++ b/board/tq/common/tq_som.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Alexander Feilke, Max Merchel
+ */
+
+#include <init.h>
+#include <asm/io.h>
+#include <linux/sizes.h>
+
+#include "tq_som.h"
+
+void __weak tq_som_ram_init(void)
+{
+	;
+}
+
+/*
+ * checks if the accessible range equals the requested RAM size.
+ * returns true if successful, false otherwise
+ */
+bool tq_som_ram_check_size(long ram_size)
+{
+	long size;
+
+	size = get_ram_size((void *)PHYS_SDRAM, ram_size);
+	debug("SPL: requested RAM size %lu MiB. accessible %lu MiB\n",
+	      ram_size / (SZ_1M), size / (SZ_1M));
+
+	return (size == ram_size);
+}
diff --git a/board/tq/common/tq_som.h b/board/tq/common/tq_som.h
new file mode 100644
index 00000000000..d7168eb7e46
--- /dev/null
+++ b/board/tq/common/tq_som.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2025-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Alexander Feilke, Max Merchel
+ */
+
+#ifndef __TQ_SOM_H
+#define __TQ_SOM_H
+
+#include <init.h>
+#include <asm/io.h>
+
+void tq_som_ram_init(void);
+
+/* used as a wrapper to write to specific register addresses */
+static inline void tq_som_init_write_reg(u32 address, u32 value)
+{
+	writel_relaxed(value, address);
+}
+
+/*
+ * checks if the accessible range equals the requested ram size.
+ * returns true if successful, false otherwise
+ */
+bool tq_som_ram_check_size(long ram_size);
+
+static inline void tq_som_check_bits_set(u32 address, u32 mask)
+{
+	while ((readl(address) & mask) != mask)
+		;
+}
+
+#endif /* __TQ_SOM_H */
-- 
2.34.1

