Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE95F41807
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 15:54:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 983F983F9A;
	Mon,  9 Mar 2026 16:54:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xs5M2SgO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62E3C83F82; Mon,  9 Mar 2026 16:54:13 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E59183F6E
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 16:54:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso20793425e9.3
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 08:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773071650; x=1773676450; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VlYHr6DV1+lzIJfEtwTWpstQfr4dYTfU6NHtm/K2IGs=;
 b=Xs5M2SgOuj/dgl+r/cpzQ/W11slARgsRP2WhVqohYU+a7DsX0GE1QSpEkVJTP44otR
 P7EevEwhaguHGJ4n2g4ywrrlY6ZvHin2EMdyRZvC/cY9mKWQMZyCWBN7vNbVzPpZC03k
 qNxry9J0mw/hVa2Z67MgztOCPwl6DAmodzx0jN7xzYxbHe7e/xa2kLtxEyViEnqcS/z3
 hLjSdV3ULxw88Wig1heY9rWzDfCcllnT2RpHwJMpA/KXxYKC2EP+YY7KcrEIHMmYXvKd
 ksla1sbwY7Kssx3o3oOwNJwmKiDSU+sH3ORGrZa2z91zCrDUE8aUCpweGKbm+nzSNlgA
 M1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071650; x=1773676450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VlYHr6DV1+lzIJfEtwTWpstQfr4dYTfU6NHtm/K2IGs=;
 b=eNjvMvGmkQQUj9+6++F5y4/hGmFi1xj+siRa4HGrBYC2lT10HLsXAGWa3tJhKBuQxq
 XsQUTiPZw5gMij1RO6Q13umhG0JIfcvjlL6q+A97V3Uivj4S6iuT8aEO+LQEAn8gz/2s
 qslfEkGgHpah5zKW9q1pmcul4VJnqE2166CFNPGwDjGgpzon4RwbUnz+uedwW5tWaQee
 NAs7etcLxRB8fiMbfCyc1D/lv/t4Q1pwtGNAL/6Pjg7PcarjysNfwPtJVF9cxnsssY8c
 eieNA+ZQtl0mwAeAtexkkLvDl1Ywm31dZS+FmUFY2rfZhFkhQDkdwndrzZh/2TnJWZpt
 YxLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaUerZ5Jn2QJlFc1UfBoiR1xTWj5qluJuCTKf1k1UAtSoNZeUhb5k7NGxEA7XpQbSJJy2AwEE=@lists.denx.de
X-Gm-Message-State: AOJu0Yyh/pW/0bW45I4W6QC/fqCYwKf6OALxpyqzzT8bi/0EZ0MyPvFR
 gCCRkVX2jf7GVl3vrVOp9s7UxVHB13g1edBEZvI3B1Tx0NI+3W9FT8HrlIizfR8pztU=
X-Gm-Gg: ATEYQzxKxCpsfqB/lmDbDMwIVLxVNWzdIFkMDxwt2kA6ah5lXnciViTL/bh+D+mUFd7
 lMyfhYKlxtTQgRsREQ3dh17okGC2PuFPZOOHiWUi9xPZ9217CXA6DrLXP0L8AxnoHTyDmhTKm3P
 EuOQ9vJL8rtooeP72KFfuVrkg/jv31f1A852M2V/OYPt7GfXzmUNqykXWJSVi0h7jkcGvlnJ50f
 lm2JW8+DDgBtmg9+SQE7wVRD9CGh77URhRwLWiUvxNGf2RLfGhSS4Sg1gSVe7fxlcWpGpq5zQs6
 XHZpbl3GaqlZWESwhkzpmT1/rgSaR7gY9GcZ+9QeiCN9gq/DPlOqXRy6Yl69ljz0zw4paG1+Oni
 EGm/c1MQyhCeUvNCeJuwC9Kl4zQ2+ZZ4gY5eZy4X3u8p+vdNPsABtldAn2D8lBa4DME2iB5XKqj
 /Lvp1XVnRJ4TwtqzcLOCUPyjDEWybh+w1Hrtvs+EjwirycAS4CaGV2+RByKJAeUVd6RFPjkB+Kg
 /ISk3bIYxBs/J7nWSueVQNbIaVPxS/XlKZUm8c8xWKC
X-Received: by 2002:a05:600c:1d0b:b0:485:4136:99a8 with SMTP id
 5b1f17b1804b1-48541369c0cmr11145895e9.22.1773071649398; 
 Mon, 09 Mar 2026 08:54:09 -0700 (PDT)
Received: from emanueleg-nb.corp.toradex.com
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485358cd26bsm84408215e9.8.2026.03.09.08.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 08:54:09 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1 2/2] board: toradex: aquila-am69: Add support for 16GB dual
 rank memory configuration
Date: Mon,  9 Mar 2026 16:53:08 +0100
Message-ID: <20260309155342.145432-3-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309155342.145432-1-ghidoliemanuele@gmail.com>
References: <20260309155342.145432-1-ghidoliemanuele@gmail.com>
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Move the existing 16GB single-rank configuration to HW_CFG 0x03 and use
the previous HW_CFG 0x01 value for the new 16GB dual-rank configuration.

There is no hardware using the former 16GB single-rank configuration,
so reuse the HW_CFG value for the new 16GB dual-rank configuration,
which will be used in production.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 board/toradex/aquila-am69/Makefile            |  1 +
 board/toradex/aquila-am69/aquila-am69.c       |  8 ++-
 board/toradex/aquila-am69/aquila_ddrs.h       |  1 +
 .../aquila-am69/aquila_ddrs_16GB_rank_2.c     | 54 +++++++++++++++++++
 4 files changed, 63 insertions(+), 1 deletion(-)
 create mode 100644 board/toradex/aquila-am69/aquila_ddrs_16GB_rank_2.c

diff --git a/board/toradex/aquila-am69/Makefile b/board/toradex/aquila-am69/Makefile
index aa71c4bbb210..aa657ac8a420 100644
--- a/board/toradex/aquila-am69/Makefile
+++ b/board/toradex/aquila-am69/Makefile
@@ -6,4 +6,5 @@
 obj-y	+= aquila-am69.o
 obj-y	+= ddrs_patch.o
 obj-y	+= aquila_ddrs_16GB.o
+obj-y	+= aquila_ddrs_16GB_rank_2.o
 obj-y	+= aquila_ddrs_8GB.o
diff --git a/board/toradex/aquila-am69/aquila-am69.c b/board/toradex/aquila-am69/aquila-am69.c
index c3df14fc7c96..0c7123a059e4 100644
--- a/board/toradex/aquila-am69/aquila-am69.c
+++ b/board/toradex/aquila-am69/aquila-am69.c
@@ -23,8 +23,9 @@
 #define CTRL_MMR_CFG0_MCU_ADC1_CTRL	0x40F040B4
 
 #define HW_CFG_MEM_SZ_32GB		0x00
-#define HW_CFG_MEM_SZ_16GB		0x01
+#define HW_CFG_MEM_SZ_16GB_RANK_2	0x01
 #define HW_CFG_MEM_SZ_8GB		0x02
+#define HW_CFG_MEM_SZ_16GB		0x03
 
 #define HW_CFG_MEM_CFG_MASK		0x03
 
@@ -41,6 +42,7 @@ static u64 aquila_am69_memory_size(void)
 	switch (aquila_am69_memory_cfg()) {
 	case HW_CFG_MEM_SZ_32GB:
 		return SZ_32G;
+	case HW_CFG_MEM_SZ_16GB_RANK_2:
 	case HW_CFG_MEM_SZ_16GB:
 		return SZ_16G;
 	case HW_CFG_MEM_SZ_8GB:
@@ -88,6 +90,10 @@ static void update_ddr_timings(void)
 		ret = aquila_am69_fdt_apply_ddr_patch(fdt, aquila_am69_ddrss_patch_8GB,
 						      MULTI_DDR_CFG_INTRLV_SIZE_8GB);
 		break;
+	case HW_CFG_MEM_SZ_16GB_RANK_2:
+		ret = aquila_am69_fdt_apply_ddr_patch(fdt, aquila_am69_ddrss_patch_16GB_rank_2,
+						      MULTI_DDR_CFG_INTRLV_SIZE_16GB);
+		break;
 	case HW_CFG_MEM_SZ_16GB:
 		ret = aquila_am69_fdt_apply_ddr_patch(fdt, aquila_am69_ddrss_patch_16GB,
 						      MULTI_DDR_CFG_INTRLV_SIZE_16GB);
diff --git a/board/toradex/aquila-am69/aquila_ddrs.h b/board/toradex/aquila-am69/aquila_ddrs.h
index 3f6cecf5405f..7a58be3fd299 100644
--- a/board/toradex/aquila-am69/aquila_ddrs.h
+++ b/board/toradex/aquila-am69/aquila_ddrs.h
@@ -10,5 +10,6 @@
 
 extern struct ddrss_patch *aquila_am69_ddrss_patch_8GB[4];
 extern struct ddrss_patch *aquila_am69_ddrss_patch_16GB[4];
+extern struct ddrss_patch *aquila_am69_ddrss_patch_16GB_rank_2[4];
 
 #endif // __AQUILA_DDRS_H
diff --git a/board/toradex/aquila-am69/aquila_ddrs_16GB_rank_2.c b/board/toradex/aquila-am69/aquila_ddrs_16GB_rank_2.c
new file mode 100644
index 000000000000..c24e22b620b5
--- /dev/null
+++ b/board/toradex/aquila-am69/aquila_ddrs_16GB_rank_2.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Toradex - https://www.toradex.com/
+ * This contains a diff against the 32GB register settings created from
+ * the 16GB dual rank tool output.
+
+ * The 16GB dtsi file was generated with the following tool revisions:
+ *     - SysConfig: Revision 1.26.2+4477
+ *     - Jacinto7_DDRSS_RegConfigTool: Revision 0.12.0
+ * This file was generated on Fri Mar 06 2026 10:39:50 GMT+0100 (Central European Standard Time)
+ */
+
+#include <asm/u-boot.h>
+#include <linux/kernel.h>
+#include "ddrs_patch.h"
+
+#define DDRSS_PLL_FHS_CNT 3
+
+#define DDRSS_CTL_268_DATA 0x01010000
+#define DDRSS_CTL_270_DATA 0x00000FFF
+#define DDRSS_CTL_271_DATA 0x1FFF1000
+#define DDRSS_CTL_272_DATA 0x01FF0000
+#define DDRSS_CTL_273_DATA 0x000101FF
+
+#define DDRSS_PI_73_DATA 0x00080100
+
+static struct ddr_reg_patch ctl_patch[] = {
+	{ 268, DDRSS_CTL_268_DATA},
+	{ 270, DDRSS_CTL_270_DATA},
+	{ 271, DDRSS_CTL_271_DATA},
+	{ 272, DDRSS_CTL_272_DATA},
+	{ 273, DDRSS_CTL_273_DATA}
+};
+
+static struct ddr_reg_patch pi_patch[] = {
+	{ 73, DDRSS_PI_73_DATA},
+};
+
+static struct ddrss_patch ddrss_ctrl_patch = {
+	.ddr_fhs_cnt = DDRSS_PLL_FHS_CNT,
+	.ctl_patch = ctl_patch,
+	.ctl_patch_num = ARRAY_SIZE(ctl_patch),
+	.pi_patch = pi_patch,
+	.pi_patch_num = ARRAY_SIZE(pi_patch),
+	.phy_patch = NULL,
+	.phy_patch_num = 0
+};
+
+struct ddrss_patch *aquila_am69_ddrss_patch_16GB_rank_2[4] = {
+	&ddrss_ctrl_patch,
+	&ddrss_ctrl_patch,
+	&ddrss_ctrl_patch,
+	&ddrss_ctrl_patch
+};
-- 
2.43.0

