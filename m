Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0648C10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 15:18:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 476F9887A4;
	Tue,  7 May 2024 17:18:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="FGaDMZVy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BBF988746; Tue,  7 May 2024 17:18:11 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09AC988789
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 17:18:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1715095086; x=1717687086;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+dzDY6r7XXMUudXN2yUeKJtKcL+yAaXLSkiKvHI7A2I=;
 b=FGaDMZVypCsRAXwhZjRPFhBEExnRrkLefRIwEU9zowWgKCa33LscRT1gnZHExAHs
 Bgj/al2b1wTSQmeJp1yWIicFwO+zYabP9EY6G60yfvmewSMHKNwGDlEW/+MUhQsM
 LchZ9mBdM0cZVmn4lL79jtGSP+WLirVUTfLQw3/LICE=;
X-AuditID: ac14000a-fbefe7000000290d-a0-663a462e1ac3
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 9A.49.10509.E264A366;
 Tue,  7 May 2024 17:18:06 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 7 May 2024
 17:18:06 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <nm@ti.com>, <bb@ti.com>, <y.moog@phytec.de>,
 <t.remmet@phytec.de>, <d.schultz@phytec.de>, <festevam@gmail.com>,
 <mkorpershoek@baylibre.com>, <joao.goncalves@toradex.com>, <n-jain1@ti.com>,
 <michael@amarulasolutions.com>, <d-gole@ti.com>, <sjg@chromium.org>,
 <clamor95@gmail.com>, <m-chawdhry@ti.com>, <afd@ti.com>, <jma@phytec.com>
Subject: [PATCH 4/5] board: phytec: common: Introduce a method to inject DDR
 timings deltas
Date: Tue, 7 May 2024 17:17:56 +0200
Message-ID: <20240507151757.1202825-5-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240507151757.1202825-1-w.egorov@phytec.de>
References: <20240507151757.1202825-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsWyRpKBR1fPzSrNoHGBqsX7UxPZLea+OcBq
 caC/l9GiZa2HxcOr/hbPOpuYLS7fv8lqcelBqsWpxlYWixfH5rJb9P9/zmTx5sdZJotvW7Yx
 WkydtJnd4u3eTnaL7nfqDgIeaz/eZ/V4f6OV3WN2w0UWj52z7rJ7vDqwit3j7J0djB793S2s
 Hn8uvmP1OH5jO5PHplceAVxRXDYpqTmZZalF+nYJXBlvt0xlL/ilUHFq0nGmBsZZ0l2MHBwS
 AiYSD2eJdzFycggJLGGSODe3uouRC8h+xCgx68dEdpAEm4C6xJ0N31hBbBEBM4lFa8+zgRQx
 C7xjklh/eAobyCBhgWiJ1afABrEIqEh8XNvFAmLzClhK/JvUzAZiSwjIS8y89B1sJqeAlcSU
 FW8YIRZbSjw//pkZol5Q4uTMJ2C9zED1zVtnM0PYEhIHX7xghqiXl3hxaTkLzMxp514zQ9ih
 Ekc2rWaawCg0C8moWUhGzUIyagEj8ypGodzM5OzUosxsvYKMypLUZL2U1E2MoIgUYeDawdg3
 x+MQIxMH4yFGCQ5mJRHeo+3maUK8KYmVValF+fFFpTmpxYcYpTlYlMR5V3cEpwoJpCeWpGan
 phakFsFkmTg4pRoYp26e+WbdXePYvY+reZM1WM43890IPOr+SGlD7T/jC7pTrQ7F1Tqnaocs
 d/t/4n3Brv6SjyFOFzeyZ7FZPruXLOVVVHSlcNnByYonJiRtCZjuW/tw3Uz3u2uvGZmdKLgi
 INd32N9Xb83ylWJPDGy+poaHc79tiL8tNmXro/2xakvv1Ew/ypt8U4mlOCPRUIu5qDgRAP/0
 zZW2AgAA
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

Introduce fdt_apply_ddrss_timings_patch() to allow board code to
override DDR settings in the device tree prior to DDRSS driver probing.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 board/phytec/common/k3/Makefile         |  1 +
 board/phytec/common/k3/k3_ddrss_patch.c | 68 +++++++++++++++++++++++++
 board/phytec/common/k3/k3_ddrss_patch.h | 28 ++++++++++
 board/phytec/phycore_am62x/MAINTAINERS  |  1 +
 4 files changed, 98 insertions(+)
 create mode 100644 board/phytec/common/k3/k3_ddrss_patch.c
 create mode 100644 board/phytec/common/k3/k3_ddrss_patch.h

diff --git a/board/phytec/common/k3/Makefile b/board/phytec/common/k3/Makefile
index bcca1a9f846..40e91a43e99 100644
--- a/board/phytec/common/k3/Makefile
+++ b/board/phytec/common/k3/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0+
 obj-y += board.o
+obj-$(CONFIG_K3_DDRSS) += k3_ddrss_patch.o
diff --git a/board/phytec/common/k3/k3_ddrss_patch.c b/board/phytec/common/k3/k3_ddrss_patch.c
new file mode 100644
index 00000000000..39f7be8dc92
--- /dev/null
+++ b/board/phytec/common/k3/k3_ddrss_patch.c
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2024 PHYTEC Messtechnik GmbH
+ * Author: Wadim Egorov <w.egorov@phytec.de>
+ */
+
+#include "k3_ddrss_patch.h"
+
+#include <fdt_support.h>
+#include <linux/errno.h>
+
+#ifdef CONFIG_K3_AM64_DDRSS
+#define LPDDR4_INTR_CTL_REG_COUNT (423U)
+#define LPDDR4_INTR_PHY_INDEP_REG_COUNT (345U)
+#endif
+
+static int fdt_setprop_inplace_idx_u32(void *fdt, int nodeoffset,
+				       const char *name, uint32_t idx, u32 val)
+{
+	val = cpu_to_be32(val);
+	return fdt_setprop_inplace_namelen_partial(fdt, nodeoffset, name,
+						   strlen(name),
+						   idx * sizeof(val), &val,
+						   sizeof(val));
+}
+
+int fdt_apply_ddrss_timings_patch(void *fdt, struct ddrss *ddrss)
+{
+	int i, j;
+	int ret;
+	int mem_offset;
+
+	mem_offset = fdt_path_offset(fdt, "/memorycontroller@f300000");
+	if (mem_offset < 0)
+		return -ENODEV;
+
+	for (i = 0; i < LPDDR4_INTR_CTL_REG_COUNT; i++)
+		for (j = 0; j < ddrss->ctl_regs_num; j++)
+			if (i == ddrss->ctl_regs[j].off) {
+				ret = fdt_setprop_inplace_idx_u32(fdt,
+						mem_offset, "ti,ctl-data", i,
+						ddrss->ctl_regs[j].val);
+				if (ret)
+					return ret;
+			}
+
+	for (i = 0; i < LPDDR4_INTR_PHY_INDEP_REG_COUNT; i++)
+		for (j = 0; j < ddrss->pi_regs_num; j++)
+			if (i == ddrss->pi_regs[j].off) {
+				ret = fdt_setprop_inplace_idx_u32(fdt,
+						mem_offset, "ti,pi-data", i,
+						ddrss->pi_regs[j].val);
+				if (ret)
+					return ret;
+			}
+
+	for (i = 0; i < LPDDR4_INTR_PHY_INDEP_REG_COUNT; i++)
+		for (j = 0; j < ddrss->phy_regs_num; j++)
+			if (i == ddrss->phy_regs[j].off) {
+				ret = fdt_setprop_inplace_idx_u32(fdt,
+						mem_offset, "ti,phy-data", i,
+						ddrss->phy_regs[j].val);
+				if (ret)
+					return ret;
+			}
+
+	return 0;
+}
diff --git a/board/phytec/common/k3/k3_ddrss_patch.h b/board/phytec/common/k3/k3_ddrss_patch.h
new file mode 100644
index 00000000000..0a47c85116a
--- /dev/null
+++ b/board/phytec/common/k3/k3_ddrss_patch.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2024 PHYTEC Messtechnik GmbH
+ * Author: Wadim Egorov <w.egorov@phytec.de>
+ */
+
+#ifndef K3_DDRSS_PATCH
+#define K3_DDRSS_PATCH
+
+#include <linux/types.h>
+
+struct ddr_reg {
+	u32 off;
+	u32 val;
+};
+
+struct ddrss {
+	struct ddr_reg *ctl_regs;
+	u32 ctl_regs_num;
+	struct ddr_reg *pi_regs;
+	u32 pi_regs_num;
+	struct ddr_reg *phy_regs;
+	u32 phy_regs_num;
+};
+
+int fdt_apply_ddrss_timings_patch(void *fdt, struct ddrss *ddrss);
+
+#endif /* K3_DDRSS_PATCH */
diff --git a/board/phytec/phycore_am62x/MAINTAINERS b/board/phytec/phycore_am62x/MAINTAINERS
index 02ac88e58a4..42463ad054e 100644
--- a/board/phytec/phycore_am62x/MAINTAINERS
+++ b/board/phytec/phycore_am62x/MAINTAINERS
@@ -11,3 +11,4 @@ F:	configs/phycore_am62x_a53_defconfig
 F:	configs/phycore_am62x_r5_defconfig
 F:	include/configs/phycore_am62x.h
 F:	doc/board/phytec/phycore-am62x.rst
+F:	board/phytec/common/k3
-- 
2.34.1

