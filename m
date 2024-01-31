Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D04C47DB3
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 11:45:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3BF487CC0;
	Wed, 31 Jan 2024 12:44:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="q+hBFUQO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCB7B878CB; Wed, 31 Jan 2024 07:02:48 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B17848785F
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 07:02:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40V62hJu071529;
 Wed, 31 Jan 2024 00:02:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706680963;
 bh=b+oWOmgAkdrVHaBqUbLcnOfBLkqjAYM6C/as8kF8+34=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=q+hBFUQOGn3Fd2S8dyzGo/K1qT8mLZWFAUjvJZHGhjh8sSPMbnQKMFRXO6uv7EJJL
 eajOrptRdPcZGjXx50aaRWhh3mQhpFLDJnIZYnobzW3urBt+GhwVuLvBnhO5fQ0C1I
 lIBlYj+P3tIdKmHRW+VrYvu0luWbA0A1CKmDPV8g=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40V62hDj009271
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 31 Jan 2024 00:02:43 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 00:02:43 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 00:02:43 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com
 [172.24.227.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40V62Utg062916;
 Wed, 31 Jan 2024 00:02:42 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <trini@konsulko.com>, <nm@ti.com>, <vigneshr@ti.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH 06/10] board: ti: common: k3-ddr-init: Pull redundant DDR
 functions to a common location
Date: Wed, 31 Jan 2024 11:32:09 +0530
Message-ID: <20240131060213.1128024-7-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131060213.1128024-1-s-k6@ti.com>
References: <20240131060213.1128024-1-s-k6@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Wed, 31 Jan 2024 12:44:04 +0100
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

As there are few redundant functions in board/ti/*/evm.c files, pull
them to a common location of access to reuse.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 board/ti/common/k3-ddr-init.c | 75 +++++++++++++++++++++++++++++++++++
 board/ti/common/k3-ddr-init.h | 15 +++++++
 2 files changed, 90 insertions(+)
 create mode 100644 board/ti/common/k3-ddr-init.c
 create mode 100644 board/ti/common/k3-ddr-init.h

diff --git a/board/ti/common/k3-ddr-init.c b/board/ti/common/k3-ddr-init.c
new file mode 100644
index 000000000000..889db49982ac
--- /dev/null
+++ b/board/ti/common/k3-ddr-init.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023, Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include <fdt_support.h>
+#include <dm/uclass.h>
+#include <k3-ddrss.h>
+#include <spl.h>
+
+#include "k3-ddr-init.h"
+
+int dram_init(void)
+{
+	s32 ret;
+
+	ret = fdtdec_setup_mem_size_base_lowest();
+	if (ret)
+		printf("Error setting up mem size and base. %d\n", ret);
+
+	return ret;
+}
+
+int dram_init_banksize(void)
+{
+	s32 ret;
+
+	ret = fdtdec_setup_memory_banksize();
+	if (ret)
+		printf("Error setting up memory banksize. %d\n", ret);
+
+	return ret;
+}
+
+#if defined(CONFIG_SPL_BUILD)
+
+void fixup_ddr_driver_for_ecc(struct spl_image_info *spl_image)
+{
+	struct udevice *dev;
+	int ret;
+
+	dram_init_banksize();
+
+	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
+	if (ret)
+		panic("Cannnot get RAM device for ddr size fixup: %d\n", ret);
+
+	ret = k3_ddrss_ddr_fdt_fixup(dev, spl_image->fdt_addr, gd->bd);
+	if (ret)
+		printf("Error fixing up ddr node for ECC use! %d\n", ret);
+}
+
+void fixup_memory_node(struct spl_image_info *spl_image)
+{
+	u64 start[CONFIG_NR_DRAM_BANKS];
+	u64 size[CONFIG_NR_DRAM_BANKS];
+	int bank;
+	int ret;
+
+	dram_init();
+	dram_init_banksize();
+
+	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
+		start[bank] = gd->bd->bi_dram[bank].start;
+		size[bank] = gd->bd->bi_dram[bank].size;
+	}
+
+	ret = fdt_fixup_memory_banks(spl_image->fdt_addr, start, size,
+								 CONFIG_NR_DRAM_BANKS);
+
+	if (ret)
+		printf("Error fixing up memory node! %d\n", ret);
+}
+
+#endif
diff --git a/board/ti/common/k3-ddr-init.h b/board/ti/common/k3-ddr-init.h
new file mode 100644
index 000000000000..6be6cb1e5b1f
--- /dev/null
+++ b/board/ti/common/k3-ddr-init.h
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023, Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#ifndef __K3_DDR_INIT_H
+#define __K3_DDR_INIT_H
+
+int dram_init(void);
+int dram_init_banksize(void);
+
+void fixup_ddr_driver_for_ecc(struct spl_image_info *spl_image);
+void fixup_memory_node(struct spl_image_info *spl_image);
+
+#endif /* __K3_DDR_INIT_H */
-- 
2.34.1

