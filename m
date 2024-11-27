Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B5F5D6ACE4
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 14:54:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B138897D8;
	Wed, 27 Nov 2024 15:54:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JvLuo9gy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57A4B897D8; Wed, 27 Nov 2024 15:54:11 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C9C9897E5
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 15:54:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4AREs7WF1013245
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Nov 2024 08:54:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732719247;
 bh=cW5AEXtvHiutrtBXiwDQudWmvfWS4td+ylE7hSPSuTA=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=JvLuo9gyk52d+LR5MqAChHz/tNWGzt5/uVq0P2SC1CUWaH7GupRmXcN5Cs+0w9lDI
 PTwEYpTjbs6+Oc0G2BqXCiC2JYXEB/u7pv4Y2YNpRdwhKkDgoObR1NIDNUqV1wIh8C
 zO/nZWBeUmA6QVgO2n7P+EaTtZn+w9Z4HqoFEyuA=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AREs7oc056479
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 27 Nov 2024 08:54:07 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Nov 2024 08:54:07 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Nov 2024 08:54:07 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ARErlpG051687;
 Wed, 27 Nov 2024 08:54:03 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>
CC: <b-padhi@ti.com>, <m-chawdhry@ti.com>, <afd@ti.com>, <hnagalla@ti.com>,
 <j-choudhary@ti.com>, <bb@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <j-keerthy@ti.com>, <u-kumar1@ti.com>, <n-francis@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 4/4] DONOTMERGE: arm: mach-k3: j784s4_init: Trigger LBIST and
 PBIST on MAIN R5 2_0
Date: Wed, 27 Nov 2024 20:23:46 +0530
Message-ID: <20241127145346.2609868-5-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241127145346.2609868-1-n-francis@ti.com>
References: <20241127145346.2609868-1-n-francis@ti.com>
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
 arch/arm/mach-k3/j784s4/j784s4_init.c | 48 +++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/mach-k3/j784s4/j784s4_init.c b/arch/arm/mach-k3/j784s4/j784s4_init.c
index 07b5d7d7504..f9bd13d962b 100644
--- a/arch/arm/mach-k3/j784s4/j784s4_init.c
+++ b/arch/arm/mach-k3/j784s4/j784s4_init.c
@@ -17,6 +17,7 @@
 #include <dm/pinctrl.h>
 #include <mmc.h>
 #include <remoteproc.h>
+#include <k3_bist.h>
 
 #include "../sysfw-loader.h"
 #include "../common.h"
@@ -233,9 +234,56 @@ void k3_mem_init(void)
 
 void board_init_f(ulong dummy)
 {
+	struct udevice *dev;
+	int ret;
+
 	k3_spl_init();
 	k3_mem_init();
 
+	if (!IS_ENABLED(CONFIG_CPU_V7R) && IS_ENABLED(CONFIG_K3_BIST)) {
+		ret = uclass_get_device_by_driver(UCLASS_MISC,
+						  DM_DRIVER_GET(k3_bist),
+						  &dev);
+		if (ret)
+			printf("Failed to run BIST: %d\n", ret);
+
+		struct bist_ops *ops = (struct bist_ops *)device_get_ops(dev);
+		struct ti_sci_handle *handle = get_ti_sci_handle();
+
+		/* get status of HW POST PBIST on MCU1_x */
+		ret = ops->run_pbist_post();
+		if (ret)
+			panic("HW POST LBIST on MCU1_x failed: %d\n", ret);
+
+		/* trigger PBIST tests on MCU4_0 */
+		prepare_pbist(handle);
+		ret = ops->run_pbist_neg();
+		deprepare_pbist(handle);
+
+		prepare_pbist(handle);
+		ret |= ops->run_pbist();
+		deprepare_pbist(handle);
+
+		prepare_pbist(handle);
+		ret |= ops->run_pbist_rom();
+		deprepare_pbist(handle);
+
+		if (ret)
+			panic("PBIST on MCU4_0 failed: %d\n", ret);
+
+		/* get status of HW POST PBIST on MCU1_x */
+		ret = ops->run_lbist_post();
+		if (ret)
+			panic("HW POST LBIST on MCU1_x failed: %d\n", ret);
+
+		/* trigger LBIST tests on MCU1_x */
+		prepare_lbist(handle);
+		ret = ops->run_lbist();
+		deprepare_lbist(handle);
+		if (ret)
+			panic("LBIST on MCU4_0 failed: %d\n", ret);
+	}
+
 	if (IS_ENABLED(CONFIG_CPU_V7R))
 		setup_navss_nb();
 
-- 
2.34.1

