Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07336C25B77
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 07:55:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9BCB884FA;
	Wed, 22 May 2024 09:55:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="jD1bDhmV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 121F288287; Wed, 22 May 2024 09:55:18 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7965788456
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 09:55:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1716364514; x=1718956514;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zcJRoMdtTU7omFgy2zzOmXUHAvo8dNx8+B38qkP1S0Y=;
 b=jD1bDhmVZStv2Cm5pGAwNeB5hRdGKWHOMu56u07Jvi8JGUdbA0qtf3uL221Ud2sz
 W4JvP2LcWSMHKTidVQ5ooVASj6lupvKGdn3Vk4Qx9kyD/6NFw+D03Yc9E1T20Bdt
 oUK7fx+qRbIhlSl3n1t0f5KdASBh3Ph4J8E81MNp6w0=;
X-AuditID: ac14000a-03e52700000021bc-b1-664da4e28e51
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 18.F0.08636.2E4AD466;
 Wed, 22 May 2024 09:55:14 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 22 May
 2024 09:55:14 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <nm@ti.com>, <trini@konsulko.com>, <clamor95@gmail.com>,
 <d.schultz@phytec.de>, <bb@ti.com>, <jma@phytec.com>,
 <mkorpershoek@baylibre.com>, <d-gole@ti.com>, <m-chawdhry@ti.com>,
 <n-jain1@ti.com>, <afd@ti.com>, <joao.goncalves@toradex.com>,
 <michael@amarulasolutions.com>, <festevam@gmail.com>, <sjg@chromium.org>
Subject: [PATCH v2 4/5] board: phytec: common: Introduce a method to inject
 DDR timings deltas
Date: Wed, 22 May 2024 09:55:04 +0200
Message-ID: <20240522075505.3339347-5-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240522075505.3339347-1-w.egorov@phytec.de>
References: <20240522075505.3339347-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsWyRpKBR/fREt80g1cNEhbvT01kt5j75gCr
 xYH+XkaLlrUeFg+v+ls862xitrh8/yarxaUHqRanGltZLF4cm8tu0f//OZPFmx9nmSy+bdnG
 aDF10mZ2i7d7O9ktut+pOwh4rP14n9Xj/Y1Wdo/ZDRdZPHbOusvu8erAKnaPs3d2MHr0d7ew
 evy5+I7V4/iN7Uwem155BHBFcdmkpOZklqUW6dslcGU0XljCWrBFreL2ujVMDYyv5LsYOTkk
 BEwkrn06xdzFyMUhJLCESWLSj38sEM5jRomZrzaxgVSxCahL3NnwjRXEFhEwk1i09jwbSBGz
 wBEmicen9jGCJIQF4iQmnboLZHNwsAioSmyabAwS5hWwlLhwfQoTxDZ5iZmXvrOD2JwCVhIz
 tqxhAbGFgGpOX57ADFEvKHFy5hOwODNQffPW2cwQtoTEwRcvmCHq5SVeXFrOAjNz2rnXzBB2
 qMTWL9uZJjAKzUIyahaSUbOQjFrAyLyKUSg3Mzk7tSgzW68go7IkNVkvJXUTIygqRRi4djD2
 zfE4xMjEwXiIUYKDWUmEd9MWzzQh3pTEyqrUovz4otKc1OJDjNIcLErivKs7glOFBNITS1Kz
 U1MLUotgskwcnFINjGvjDy35/ehQcfv2NQELA24tksxNM+23ea+yV1au6ucH/b9Tb8yuYxXR
 W6zC8DzyaOOkNWvNHwV2HXi4g2XpnBdxWgsnvntwluHXwob0M5mL/E78ndz968eut8GGMnsj
 tks90WJfyr1X+s7Eum/ubUfDw1jYwwzOL2Tm8PB7omZh6G+eGLZWKFmJpTgj0VCLuag4EQCE
 FY7VuAIAAA==
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
Tested-by: John Ma <jma@phytec.com>
---
v2:
  - Make board/phytec/common/k3 always compile for CONFIG_ARCH_K3
---
 board/phytec/common/Makefile            |  4 +-
 board/phytec/common/k3/Makefile         |  1 +
 board/phytec/common/k3/k3_ddrss_patch.c | 68 +++++++++++++++++++++++++
 board/phytec/common/k3/k3_ddrss_patch.h | 28 ++++++++++
 board/phytec/phycore_am62x/MAINTAINERS  |  1 +
 5 files changed, 99 insertions(+), 3 deletions(-)
 create mode 100644 board/phytec/common/k3/k3_ddrss_patch.c
 create mode 100644 board/phytec/common/k3/k3_ddrss_patch.h

diff --git a/board/phytec/common/Makefile b/board/phytec/common/Makefile
index c34fc503059..988c5742db5 100644
--- a/board/phytec/common/Makefile
+++ b/board/phytec/common/Makefile
@@ -5,10 +5,8 @@
 ifdef CONFIG_SPL_BUILD
 # necessary to create built-in.o
 obj- := __dummy__.o
-else
-obj-$(CONFIG_ARCH_K3) += k3/
 endif
 
 obj-y += phytec_som_detection.o
-obj-$(CONFIG_ARCH_K3) += am6_som_detection.o
+obj-$(CONFIG_ARCH_K3) += am6_som_detection.o k3/
 obj-$(CONFIG_ARCH_IMX8M) += imx8m_som_detection.o
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

