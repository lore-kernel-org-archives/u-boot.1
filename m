Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05657C83F1B
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 06:22:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2FEC83197;
	Wed, 16 Jul 2025 08:22:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PMI4GKWL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47342831A1; Wed, 16 Jul 2025 08:22:14 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22BB083197
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 08:22:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56G6MAvh2437123;
 Wed, 16 Jul 2025 01:22:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1752646930;
 bh=z7OU6vmD2MaYnLSsBtkBk2SDPd1GIKA6AE6AVbdLGGM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=PMI4GKWLe7YkbVsuEJ4FGxmJTAJAU6TcYwHm2TQ8qnSyhv2K3z5jJ8k9U5R218rXt
 WGBlcw+RhUw81jJufVJDqav75PSeBMps6bmYoJ6nqPg8EL4qWlsue+qIPIwPPm3NzE
 Q79T1ZXyr+G62WNsLUXAzzbtit+nO7OuemEhlGuI=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56G6MAHb1156165
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 16 Jul 2025 01:22:10 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 16
 Jul 2025 01:22:09 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 16 Jul 2025 01:22:09 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56G6LvkB4174146;
 Wed, 16 Jul 2025 01:22:06 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>
CC: <b-padhi@ti.com>, <m-chawdhry@ti.com>, <afd@ti.com>, <hnagalla@ti.com>,
 <j-choudhary@ti.com>, <bb@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <j-keerthy@ti.com>, <u-kumar1@ti.com>, <n-francis@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH v4 RESEND 2/2] arm: mach-k3: j784s4_init: Trigger LBIST and
 PBIST on MAIN R5 2_0
Date: Wed, 16 Jul 2025 11:51:56 +0530
Message-ID: <20250716062156.2564297-3-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716062156.2564297-1-n-francis@ti.com>
References: <20250716062156.2564297-1-n-francis@ti.com>
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

Trigger all tests of PBIST and LBIST using appropriate calls to set the
core under test (MAIN R5 2_0) to it's required state.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
No change since v4

 arch/arm/mach-k3/j784s4/j784s4_init.c | 52 +++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm/mach-k3/j784s4/j784s4_init.c b/arch/arm/mach-k3/j784s4/j784s4_init.c
index 0f11511bda0..53f152ccd9c 100644
--- a/arch/arm/mach-k3/j784s4/j784s4_init.c
+++ b/arch/arm/mach-k3/j784s4/j784s4_init.c
@@ -17,6 +17,7 @@
 #include <dm/pinctrl.h>
 #include <mmc.h>
 #include <remoteproc.h>
+#include <k3_bist.h>
 
 #include "../sysfw-loader.h"
 #include "../common.h"
@@ -122,6 +123,48 @@ static void setup_navss_nb(void)
 	writel(NB_THREADMAP_BIT2, (uintptr_t)NAVSS0_NBSS_NB1_CFG_NB_THREADMAP);
 }
 
+/* Execute and check results of BIST executed on MCU1_x and MCU4_O */
+static void run_bist_j784s4(struct udevice *dev)
+{
+	struct bist_ops *ops;
+	struct ti_sci_handle *handle;
+	int ret;
+
+	ops = (struct bist_ops *)device_get_ops(dev);
+	handle = get_ti_sci_handle();
+
+	/* get status of HW POST PBIST on MCU1_x */
+	if (ops->run_pbist_post())
+		panic("HW POST LBIST on MCU1_x failed\n");
+
+	/* trigger PBIST tests on MCU4_0 */
+	ret = prepare_pbist(handle);
+	ret |= ops->run_pbist_neg();
+	ret |= deprepare_pbist(handle);
+
+	ret |= prepare_pbist(handle);
+	ret |= ops->run_pbist();
+	ret |= deprepare_pbist(handle);
+
+	ret |= prepare_pbist(handle);
+	ret |= ops->run_pbist_rom();
+	ret |= deprepare_pbist(handle);
+
+	if (ret)
+		panic("PBIST on MCU4_0 failed: %d\n", ret);
+
+	/* get status of HW POST PBIST on MCU1_x */
+	if (ops->run_lbist_post())
+		panic("HW POST LBIST on MCU1_x failed\n");
+
+	/* trigger LBIST tests on MCU1_x */
+	ret = prepare_lbist(handle);
+	ret |= ops->run_lbist();
+	ret |= deprepare_lbist(handle);
+	if (ret)
+		panic("LBIST on MCU4_0 failed: %d\n", ret);
+}
+
 /*
  * This uninitialized global variable would normal end up in the .bss section,
  * but the .bss is cleared between writing and reading this variable, so move
@@ -266,6 +309,15 @@ void board_init_f(ulong dummy)
 			printf("AVS init failed: %d\n", ret);
 	}
 
+	if (!IS_ENABLED(CONFIG_CPU_V7R) && IS_ENABLED(CONFIG_K3_BIST)) {
+		ret = uclass_get_device_by_driver(UCLASS_MISC,
+						  DM_DRIVER_GET(k3_bist),
+						  &dev);
+		if (ret)
+			panic("Failed to get BIST device: %d\n", ret);
+		run_bist_j784s4(dev);
+	}
+
 	if (IS_ENABLED(CONFIG_CPU_V7R))
 		setup_navss_nb();
 
-- 
2.34.1

