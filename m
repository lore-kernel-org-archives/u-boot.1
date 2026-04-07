Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE1DFFEEF35
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 13:07:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3A4184106;
	Tue,  7 Apr 2026 15:07:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="beDCoh1S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AC6384148; Tue,  7 Apr 2026 15:07:28 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2EB98406D
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 15:07:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Alexander.Feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=CKPQzMlgdVJWy3y6Do/4GS/XAIgmwltlxT0b8Zw968o=; b=beDCoh1S7t3g0zsyTTnFvKd2bO
 CPdFQaZLGyr/7rL3rzUxctRgPW7GO2uXGnmd00LS3WwDg1RuBDhL3Mfl6gCIJrQT+xCaEnhVH6xJR
 M04jx9iXweu8hv1BeWLLYWvgGeVu5CXmTCXqWj+foTy3//3Rj2W5tjt+4JBbkd325Ym9Az3CbXNpA
 jxfsd2/J+c8zQY3ZB47nRyvz0qfg/v3FivStJ4Z2Tkh49GpmIqjbgH7EatBCow9QwdJulf9CPTTGq
 0tdI217EV4HgUud8SXp7g1Khp326ssQ/q3YIu/kMroQtvrTqM+yzrA/jwuy8uZwmYrOx+mHZIf2Td
 XQdg/lqg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wA69J-00071y-0m; Tue, 07 Apr 2026 15:07:21 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy02.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wA69I-0007St-1e; Tue, 07 Apr 2026 15:07:20 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Cc: Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>,
 Alexander Feilke <Alexander.Feilke@ew.tq-group.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Max Merchel <Max.Merchel@ew.tq-group.com>
Subject: [PATCH v4 2/8] board/tq: Add common SoM API
Date: Tue,  7 Apr 2026 15:06:45 +0200
Message-ID: <20260407130654.778838-3-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407130654.778838-1-Alexander.Feilke@ew.tq-group.com>
References: <20260407130654.778838-1-Alexander.Feilke@ew.tq-group.com>
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

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
 board/tq/common/Kconfig  |  3 +++
 board/tq/common/Makefile |  1 +
 board/tq/common/tq_som.c | 32 ++++++++++++++++++++++++++++++++
 board/tq/common/tq_som.h | 35 +++++++++++++++++++++++++++++++++++
 4 files changed, 71 insertions(+)
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
index 00000000000..0ab01d51f99
--- /dev/null
+++ b/board/tq/common/tq_som.h
@@ -0,0 +1,35 @@
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
+#include <linux/iopoll.h>
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
+	u32 val;
+	readl_poll_timeout(address, val, (val & mask) == mask, 1000);
+}
+
+#endif /* __TQ_SOM_H */
-- 
2.43.0

