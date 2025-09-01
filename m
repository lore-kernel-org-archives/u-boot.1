Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE0C7CA0FFD
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 06:17:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A880838EE;
	Mon,  1 Sep 2025 08:17:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="iDyrHfej";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC651831B4; Mon,  1 Sep 2025 08:17:16 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11AEC83984
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 08:17:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-dutta@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5816H9Sl2745392;
 Mon, 1 Sep 2025 01:17:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1756707429;
 bh=jn+L6kE4XRuUOBhW+MSODEoIGhFV//cXRPfFtO1Yxbk=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=iDyrHfej0Wme4A7z93FgebQO/ECro1mVWkcg03bum0vvLP0ACGkfq9qqCGddr7eQf
 qT/D0NarRJf51/QaUXQOaeE7qJVsXD4RRqkivotCr4/1q2QZe+WOBhgF49b3Gt+pki
 pIMMg8cRRJej9nW3SJRLHWeYgVaE/W7a3Jjj91JM=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5816H9W31904152
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 1 Sep 2025 01:17:09 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 1
 Sep 2025 01:17:09 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 1 Sep 2025 01:17:09 -0500
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [10.24.68.237])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5816H0GU1998362;
 Mon, 1 Sep 2025 01:17:07 -0500
From: Anurag Dutta <a-dutta@ti.com>
To: <trini@konsulko.com>, <n-francis@ti.com>
CC: <u-kumar1@ti.com>, <u-boot@lists.denx.de>, <a-dutta@ti.com>
Subject: [PATCH v2 3/4] board: ti: am57xx: Set fdtfile from C code instead of
 findfdt script
Date: Mon, 1 Sep 2025 11:46:58 +0530
Message-ID: <20250901061659.986164-4-a-dutta@ti.com>
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
 board/ti/am57xx/board.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/board/ti/am57xx/board.c b/board/ti/am57xx/board.c
index fc0d87daae4..4091601d4f2 100644
--- a/board/ti/am57xx/board.c
+++ b/board/ti/am57xx/board.c
@@ -42,6 +42,7 @@
 
 #include "../common/board_detect.h"
 #include "../common/cape_detect.h"
+#include "../common/fdt_ops.h"
 #include "mux_data.h"
 
 #ifdef CONFIG_SUPPORT_EMMC_BOOT
@@ -577,6 +578,18 @@ void do_board_detect(void)
 			 "Board: %s REV %s\n", bname, board_ti_get_rev());
 }
 
+static struct ti_fdt_map ti_omap_am57_evm_fdt_map[] = {
+	{"beagle_x15", "ti/omap/am57xx-beagle-x15.dtb"},
+	{"beagle_x15_revb1", "ti/omap/am57xx-beagle-x15-revb1.dtb"},
+	{"beagle_x15_revc", "ti/omap/am57xx-beagle-x15-revc.dtb"},
+	{"am5729_beagleboneai", "ti/omap/am5729-beagleboneai.dtb"},
+	{"am572x_idk", "ti/omap/am572x-idk.dtb"},
+	{"am574x_idk", "ti/omap/am574x-idk.dtb"},
+	{"am57xx_evm", "ti/omap/am57xx-beagle-x15.dtb"},
+	{"am57xx_evm_reva3", "ti/omap/am57xx-beagle-x15.dtb"},
+	{"am571x_idk", "ti/omap/am571x-idk.dtb"},
+};
+
 static void setup_board_eeprom_env(void)
 {
 	char *name = "beagle_x15";
@@ -614,6 +627,7 @@ static void setup_board_eeprom_env(void)
 
 invalid_eeprom:
 	set_board_info_env(name);
+	ti_set_fdt_env(name, ti_omap_am57_evm_fdt_map);
 }
 
 #endif	/* CONFIG_XPL_BUILD */
-- 
2.34.1

