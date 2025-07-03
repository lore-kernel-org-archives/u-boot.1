Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82028C83F03
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 13:37:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84E0D82ED0;
	Thu,  3 Jul 2025 15:36:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RPZFIQ1D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C47080E9A; Thu,  3 Jul 2025 15:36:31 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C72982ED0
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 15:36:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 563DaQPs018345;
 Thu, 3 Jul 2025 08:36:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1751549786;
 bh=SLnIap3K2QhuIfvYkqSBef2XRyZXOpSXsip2wBDybX4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=RPZFIQ1DHr6coDmrASeS1eKrrp9XGLD8Gyrjcf0d2mPzVxuyAAZ7rJzNnsEzgXto+
 oTOq7R6Wq1bIVyVis+8wFE5xH/bEUfg496RkygA4OBoDywbqRq4+Oq1LSeRYlrzxas
 bduEXldRaxr9MDBqHjMyncrvJRAJWWzUXK+qZJek=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 563DaPRq2380949
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 3 Jul 2025 08:36:25 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 3
 Jul 2025 08:36:24 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 3 Jul 2025 08:36:24 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 563DaN0r912306;
 Thu, 3 Jul 2025 08:36:23 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <nm@ti.com>, <robertcnelson@gmail.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>,
 <m-chawdhry@ti.com>, <a-nandan@ti.com>, <afd@ti.com>, <bb@ti.com>,
 <u-kumar1@ti.com>, <devarsht@ti.com>
Subject: [PATCH v5 4/4] board: add call to k3_mem_map_init for all k3 boards
Date: Thu, 3 Jul 2025 19:05:29 +0530
Message-ID: <20250703133533.104758-5-anshuld@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703133533.104758-1-anshuld@ti.com>
References: <20250703133533.104758-1-anshuld@ti.com>
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

k3_mem_map_init configures the MMU at runtime by querying the
device-tree for DDR size for each bank as well as creating carveouts for
OPTEE and ATF in the first bank.

Therefore add a call to k3_mem_map_init in dram_init for all k3 vendor
boards.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 board/beagle/beagleplay/beagleplay.c         | 9 ++++++++-
 board/phytec/phycore_am62ax/phycore-am62ax.c | 9 ++++++++-
 board/phytec/phycore_am62x/phycore-am62x.c   | 3 ++-
 board/phytec/phycore_am64x/phycore-am64x.c   | 3 ++-
 board/siemens/iot2050/board.c                | 3 ++-
 board/toradex/verdin-am62/verdin-am62.c      | 3 ++-
 6 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/board/beagle/beagleplay/beagleplay.c b/board/beagle/beagleplay/beagleplay.c
index 78635810585..c87ed925da8 100644
--- a/board/beagle/beagleplay/beagleplay.c
+++ b/board/beagle/beagleplay/beagleplay.c
@@ -13,6 +13,7 @@
 #include <spl.h>
 
 #include <asm/arch/hardware.h>
+#include <mach/k3-ddr.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -48,7 +49,13 @@ int board_init(void)
 
 int dram_init(void)
 {
-	return fdtdec_setup_mem_size_base();
+	int ret;
+
+	ret = fdtdec_setup_mem_size_base();
+	if (ret)
+		return ret;
+
+	return k3_mem_map_init();
 }
 
 int dram_init_banksize(void)
diff --git a/board/phytec/phycore_am62ax/phycore-am62ax.c b/board/phytec/phycore_am62ax/phycore-am62ax.c
index 14b8959c07a..5d61866d556 100644
--- a/board/phytec/phycore_am62ax/phycore-am62ax.c
+++ b/board/phytec/phycore_am62ax/phycore-am62ax.c
@@ -8,6 +8,7 @@
 #include <asm/io.h>
 #include <spl.h>
 #include <fdt_support.h>
+#include <mach/k3-ddr.h>
 
 #include "../common/am6_som_detection.h"
 
@@ -18,7 +19,13 @@ int board_init(void)
 
 int dram_init(void)
 {
-	return fdtdec_setup_mem_size_base();
+	int ret;
+
+	ret = fdtdec_setup_mem_size_base();
+	if (ret)
+		return ret;
+
+	return k3_mem_map_init();
 }
 
 int dram_init_banksize(void)
diff --git a/board/phytec/phycore_am62x/phycore-am62x.c b/board/phytec/phycore_am62x/phycore-am62x.c
index b199fdaa59b..ebf7697709d 100644
--- a/board/phytec/phycore_am62x/phycore-am62x.c
+++ b/board/phytec/phycore_am62x/phycore-am62x.c
@@ -9,6 +9,7 @@
 #include <spl.h>
 #include <asm/arch/k3-ddr.h>
 #include <fdt_support.h>
+#include <mach/k3-ddr.h>
 
 #include "phycore-ddr-data.h"
 #include "../common/k3/k3_ddrss_patch.h"
@@ -81,7 +82,7 @@ int dram_init(void)
 		gd->ram_size = 0x80000000;
 	}
 
-	return 0;
+	return k3_mem_map_init();
 }
 
 phys_size_t board_get_usable_ram_top(phys_size_t total_size)
diff --git a/board/phytec/phycore_am64x/phycore-am64x.c b/board/phytec/phycore_am64x/phycore-am64x.c
index f14c87f5c72..4cd44d6e538 100644
--- a/board/phytec/phycore_am64x/phycore-am64x.c
+++ b/board/phytec/phycore_am64x/phycore-am64x.c
@@ -16,6 +16,7 @@
 #include <asm/arch/hardware.h>
 
 #include "../common/am6_som_detection.h"
+#include <mach/k3-ddr.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -64,7 +65,7 @@ int dram_init(void)
 		gd->ram_size = 0x80000000;
 	}
 
-	return 0;
+	return k3_mem_map_init();
 }
 
 int dram_init_banksize(void)
diff --git a/board/siemens/iot2050/board.c b/board/siemens/iot2050/board.c
index d827f728a08..fca8270fda9 100644
--- a/board/siemens/iot2050/board.c
+++ b/board/siemens/iot2050/board.c
@@ -24,6 +24,7 @@
 #include <asm/arch/hardware.h>
 #include <asm/gpio.h>
 #include <asm/io.h>
+#include <mach/k3-ddr.h>
 
 #include "../../../../drivers/sysinfo/iot2050.h"
 
@@ -383,7 +384,7 @@ int dram_init(void)
 
 	gd->ram_size = ((phys_size_t)(ddr_size_mb)) << 20;
 
-	return 0;
+	return k3_mem_map_init();
 }
 
 ulong board_get_usable_ram_top(ulong total_size)
diff --git a/board/toradex/verdin-am62/verdin-am62.c b/board/toradex/verdin-am62/verdin-am62.c
index 7b2eecbf659..4c900663506 100644
--- a/board/toradex/verdin-am62/verdin-am62.c
+++ b/board/toradex/verdin-am62/verdin-am62.c
@@ -16,6 +16,7 @@
 #include <k3-ddrss.h>
 #include <spl.h>
 #include <asm/arch/k3-ddr.h>
+#include <mach/k3-ddr.h>
 
 #include "../common/tdx-cfg-block.h"
 
@@ -33,7 +34,7 @@ int dram_init(void)
 	if (gd->ram_size < SZ_512M)
 		puts("## WARNING: Less than 512MB RAM detected\n");
 
-	return 0;
+	return k3_mem_map_init();
 }
 
 int dram_init_banksize(void)
-- 
2.49.0

