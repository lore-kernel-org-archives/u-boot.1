Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 008BA106F30E
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 09:12:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 551A383FB6;
	Thu, 26 Mar 2026 10:12:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Sz9JvQ3K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5E9683F14; Thu, 26 Mar 2026 10:12:04 +0100 (CET)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C03FC80517
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 10:12:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Alexander.Feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=yhhIS4gI+wrvuiF5zWlGwtWWa94iLh36IQXYOm1LKQQ=; b=Sz9JvQ3KROJu5ZdceyuenTvboY
 OMZQTfgAkTstgg7Whx7kpTrKHeuLfnYyJMg1GiPcHUKDnAXEW8IZhgAa2mT8iBhnTwpKlhdWr9eS8
 rUyXpKdpP7S0trWAMgL9MMqZhbUPJhv/t3JiUpc0c7rlSo8s4tknPCLEalVhW0QiLSwYV4wa+8xIz
 uT2OlBLYYOE7t26umQEYb9cOI0zS6kCOyNCsPMNyRj6ZC8fBmv3Nikv25EN/HDUMvSeGUQVw/7/ra
 CUQqVwzwE/6fe8ELsx3VQYYzzfpaVZM8rphRqYp8NckLwlWdNAe6NOw2Ig92FKBidSGRJD7fbMd2F
 h2hdeDww==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1w5gkx-000O70-2w; Thu, 26 Mar 2026 10:11:59 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1w5gkx-000DCP-2F; Thu, 26 Mar 2026 10:11:59 +0100
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Cc: Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>,
 Alexander Feilke <Alexander.Feilke@ew.tq-group.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Max Merchel <Max.Merchel@ew.tq-group.com>
Subject: [PATCH v3 2/8] board/tq: Add common SoM API
Date: Thu, 26 Mar 2026 10:11:30 +0100
Message-Id: <20260326091136.709342-3-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326091136.709342-1-Alexander.Feilke@ew.tq-group.com>
References: <20260326091136.709342-1-Alexander.Feilke@ew.tq-group.com>
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
2.34.1

