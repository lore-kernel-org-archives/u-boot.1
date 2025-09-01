Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C49CA0FF0
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 06:17:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 530FB83987;
	Mon,  1 Sep 2025 08:17:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xnN9Homb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07171838EE; Mon,  1 Sep 2025 08:17:17 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FBF383980
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 08:17:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-dutta@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5816HBGK2251140;
 Mon, 1 Sep 2025 01:17:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1756707431;
 bh=2jLD4fnyP/GMiV1Z3iacdWnrr7PJFnilpYCu8nQDJ0M=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=xnN9HombyZ/XYNBpY3lCnlmk/M71Gl4gTOlMrrtf+sANGqL1mLwUH2FQaK6EzIWwH
 VY349pjuitpL7NF+hj187bNZTHjwjx39Eg/XGBLXnB8C0FoFs6HqP/+JgfRHFcGt1o
 qv9pGa6GzCXtPbHoTnWcZsmF1NB6kIif2AiVF6LM=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5816HBXX1904164
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 1 Sep 2025 01:17:11 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 1
 Sep 2025 01:17:11 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 1 Sep 2025 01:17:11 -0500
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [10.24.68.237])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5816H0GV1998362;
 Mon, 1 Sep 2025 01:17:09 -0500
From: Anurag Dutta <a-dutta@ti.com>
To: <trini@konsulko.com>, <n-francis@ti.com>
CC: <u-kumar1@ti.com>, <u-boot@lists.denx.de>, <a-dutta@ti.com>
Subject: [PATCH v2 4/4] board: ti: dra7xx: Set fdtfile from C code instead of
 findfdt script
Date: Mon, 1 Sep 2025 11:46:59 +0530
Message-ID: <20250901061659.986164-5-a-dutta@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250901061659.986164-1-a-dutta@ti.com>
References: <20250901061659.986164-1-a-dutta@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

We now can provide a map and have the standard fdtfile variable set from
code itself. This allows for bootstd to "just work".

Signed-off-by: Anurag Dutta <a-dutta@ti.com>
---
 board/ti/dra7xx/evm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/board/ti/dra7xx/evm.c b/board/ti/dra7xx/evm.c
index 98d63e14e29..0966db2bb62 100644
--- a/board/ti/dra7xx/evm.c
+++ b/board/ti/dra7xx/evm.c
@@ -38,6 +38,7 @@
 
 #include "mux_data.h"
 #include "../common/board_detect.h"
+#include "../common/fdt_ops.h"
 
 #define board_is_dra76x_evm()		board_ti_is("DRA76/7x")
 #define board_is_dra74x_evm()		board_ti_is("5777xCPU")
@@ -665,6 +666,15 @@ static int device_okay(const char *path)
 }
 #endif
 
+static struct ti_fdt_map ti_omap_dra7_evm_fdt_map[] = {
+	{"omap5_uevm", "ti/omap/omap5-uevm.dtb"},
+	{"dra7xx", "ti/omap/dra7-evm.dtb"},
+	{"dra72x-revc", "ti/omap/dra72-evm-revc.dtb"},
+	{"dra72x", "ti/omap/dra72-evm.dtb"},
+	{"dra71x", "ti/omap/dra71-evm.dtb"},
+	{"dra76x_acd", "ti/omap/dra76-evm.dtb"},
+};
+
 int board_late_init(void)
 {
 #ifdef CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG
@@ -686,6 +696,7 @@ int board_late_init(void)
 	}
 
 	set_board_info_env(name);
+	ti_set_fdt_env(name, ti_omap_dra7_evm_fdt_map);
 
 	/*
 	 * Default FIT boot on HS devices. Non FIT images are not allowed
-- 
2.34.1

