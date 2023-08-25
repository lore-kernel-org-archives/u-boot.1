Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73209C6787B
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 18:03:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E2FF86AF8;
	Fri, 25 Aug 2023 20:03:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="AsYyVTcI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07F8686AEA; Fri, 25 Aug 2023 20:03:16 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 940D986699
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 20:03:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37PI36ZR114036;
 Fri, 25 Aug 2023 13:03:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692986586;
 bh=tCH3Cxp69Q5m6gMUnpa+UuKXS6wplvm8NUqtcM1OHTw=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=AsYyVTcIzc0sKA24F2wTmORrGxIo7GB/4HkAS53lg3lL3KS+ff9o3M58ndw+MgSYr
 4Sxs3JKAIBoEmrPU5RVg+jlVHBR822ze/47brFRqOZuVm/S6fQ63FnAqzDQI4HW0p7
 sd7rX6T78kmablFBWTLJGndoFxQpmdCgZd6PbVIc=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37PI36J7123994
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 25 Aug 2023 13:03:06 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Aug 2023 13:03:06 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Aug 2023 13:03:06 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37PI36bt038410;
 Fri, 25 Aug 2023 13:03:06 -0500
From: Nishanth Menon <nm@ti.com>
To: Neha Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, Simon
 Glass <sjg@google.com>
CC: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V6 09/20] include: env: ti: ti_armv7_common.env: Rename to
 ti_common.env
Date: Fri, 25 Aug 2023 13:02:54 -0500
Message-ID: <20230825180305.69515-10-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230825180305.69515-1-nm@ti.com>
References: <20230825180305.69515-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

ti_armv7_common does not make any more sense as it is used by armv7
and armv8 TI based platforms.

Reported-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Reviewed-by: Tom Rini <trini@konsulko.com>
Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
No change other than picking up reviews, tested tags along the way.
V5: https://lore.kernel.org/r/20230824031101.3460411-8-nm@ti.com
 board/siemens/iot2050/iot2050.env                     | 2 +-
 board/ti/am62ax/am62ax.env                            | 2 +-
 board/ti/am62x/am62x.env                              | 2 +-
 board/ti/am64x/am64x.env                              | 2 +-
 board/ti/am65x/am65x.env                              | 2 +-
 board/ti/j721e/j721e.env                              | 2 +-
 board/ti/j721s2/j721s2.env                            | 2 +-
 board/ti/ks2_evm/k2e_evm.env                          | 2 +-
 board/ti/ks2_evm/k2g_evm.env                          | 2 +-
 board/ti/ks2_evm/k2hk_evm.env                         | 2 +-
 board/ti/ks2_evm/k2l_evm.env                          | 2 +-
 include/env/ti/{ti_armv7_common.env => ti_common.env} | 0
 12 files changed, 11 insertions(+), 11 deletions(-)
 rename include/env/ti/{ti_armv7_common.env => ti_common.env} (100%)

diff --git a/board/siemens/iot2050/iot2050.env b/board/siemens/iot2050/iot2050.env
index caa9f80e3fca..8bbd7abe98f0 100644
--- a/board/siemens/iot2050/iot2050.env
+++ b/board/siemens/iot2050/iot2050.env
@@ -6,7 +6,7 @@
  *   Jan Kiszka <jan.kiszka@siemens.com>
  */
 
-#include <env/ti/ti_armv7_common.env>
+#include <env/ti/ti_common.env>
 
 usb_pgood_delay=900
 
diff --git a/board/ti/am62ax/am62ax.env b/board/ti/am62ax/am62ax.env
index 3f7c333fa404..bfed7f360844 100644
--- a/board/ti/am62ax/am62ax.env
+++ b/board/ti/am62ax/am62ax.env
@@ -1,4 +1,4 @@
-#include <env/ti/ti_armv7_common.env>
+#include <env/ti/ti_common.env>
 #include <env/ti/mmc.env>
 
 default_device_tree=ti/k3-am62a7-sk.dtb
diff --git a/board/ti/am62x/am62x.env b/board/ti/am62x/am62x.env
index 1cf56dbd8128..1ef948df83d7 100644
--- a/board/ti/am62x/am62x.env
+++ b/board/ti/am62x/am62x.env
@@ -1,4 +1,4 @@
-#include <env/ti/ti_armv7_common.env>
+#include <env/ti/ti_common.env>
 #include <env/ti/mmc.env>
 
 default_device_tree=ti/k3-am625-sk.dtb
diff --git a/board/ti/am64x/am64x.env b/board/ti/am64x/am64x.env
index 1567907fcbdc..68e42222b7f1 100644
--- a/board/ti/am64x/am64x.env
+++ b/board/ti/am64x/am64x.env
@@ -1,4 +1,4 @@
-#include <env/ti/ti_armv7_common.env>
+#include <env/ti/ti_common.env>
 #include <env/ti/mmc.env>
 #include <env/ti/k3_dfu.env>
 
diff --git a/board/ti/am65x/am65x.env b/board/ti/am65x/am65x.env
index 755bff2707c8..286b9c300c05 100644
--- a/board/ti/am65x/am65x.env
+++ b/board/ti/am65x/am65x.env
@@ -1,4 +1,4 @@
-#include <env/ti/ti_armv7_common.env>
+#include <env/ti/ti_common.env>
 #include <env/ti/mmc.env>
 #include <env/ti/k3_dfu.env>
 #if CONFIG_CMD_REMOTEPROC
diff --git a/board/ti/j721e/j721e.env b/board/ti/j721e/j721e.env
index 2f2fb0591279..8cc8232fc131 100644
--- a/board/ti/j721e/j721e.env
+++ b/board/ti/j721e/j721e.env
@@ -1,4 +1,4 @@
-#include <env/ti/ti_armv7_common.env>
+#include <env/ti/ti_common.env>
 #include <env/ti/mmc.env>
 #include <env/ti/ufs.env>
 #include <env/ti/k3_dfu.env>
diff --git a/board/ti/j721s2/j721s2.env b/board/ti/j721s2/j721s2.env
index 6825b1469854..64e3d9da85f0 100644
--- a/board/ti/j721s2/j721s2.env
+++ b/board/ti/j721s2/j721s2.env
@@ -1,4 +1,4 @@
-#include <env/ti/ti_armv7_common.env>
+#include <env/ti/ti_common.env>
 #include <env/ti/mmc.env>
 #include <env/ti/ufs.env>
 #include <env/ti/k3_dfu.env>
diff --git a/board/ti/ks2_evm/k2e_evm.env b/board/ti/ks2_evm/k2e_evm.env
index a145db53e5fa..3dbb7934c59a 100644
--- a/board/ti/ks2_evm/k2e_evm.env
+++ b/board/ti/ks2_evm/k2e_evm.env
@@ -1,4 +1,4 @@
-#include <env/ti/ti_armv7_common.env>
+#include <env/ti/ti_common.env>
 #include <env/ti/ti_armv7_keystone2.env>
 
 findfdt=setenv fdtfile ${name_fdt}
diff --git a/board/ti/ks2_evm/k2g_evm.env b/board/ti/ks2_evm/k2g_evm.env
index 4f4941dd0907..2b500fc6edf6 100644
--- a/board/ti/ks2_evm/k2g_evm.env
+++ b/board/ti/ks2_evm/k2g_evm.env
@@ -1,4 +1,4 @@
-#include <env/ti/ti_armv7_common.env>
+#include <env/ti/ti_common.env>
 #include <env/ti/ti_armv7_keystone2.env>
 #include <env/ti/mmc.env>
 
diff --git a/board/ti/ks2_evm/k2hk_evm.env b/board/ti/ks2_evm/k2hk_evm.env
index 0714a51090ef..9991b76f8fcc 100644
--- a/board/ti/ks2_evm/k2hk_evm.env
+++ b/board/ti/ks2_evm/k2hk_evm.env
@@ -1,4 +1,4 @@
-#include <env/ti/ti_armv7_common.env>
+#include <env/ti/ti_common.env>
 #include <env/ti/ti_armv7_keystone2.env>
 
 findfdt=setenv fdtfile ${name_fdt}
diff --git a/board/ti/ks2_evm/k2l_evm.env b/board/ti/ks2_evm/k2l_evm.env
index e8a803a4ed76..4e2debca4bde 100644
--- a/board/ti/ks2_evm/k2l_evm.env
+++ b/board/ti/ks2_evm/k2l_evm.env
@@ -1,4 +1,4 @@
-#include <env/ti/ti_armv7_common.env>
+#include <env/ti/ti_common.env>
 #include <env/ti/ti_armv7_keystone2.env>
 
 findfdt=setenv fdtfile ${name_fdt}
diff --git a/include/env/ti/ti_armv7_common.env b/include/env/ti/ti_common.env
similarity index 100%
rename from include/env/ti/ti_armv7_common.env
rename to include/env/ti/ti_common.env
-- 
2.40.0

