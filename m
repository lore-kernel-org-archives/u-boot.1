Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE084C3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 03:12:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4C4186574;
	Thu, 24 Aug 2023 05:11:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ljSbPML4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9082C833DB; Thu, 24 Aug 2023 05:11:24 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E37AD8652D
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 05:11:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37O3BAHb053217;
 Wed, 23 Aug 2023 22:11:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692846670;
 bh=5Z1UXbZHOQBTwPqLwfu8TdgbUUhqtO50p6oBdV8HMgE=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=ljSbPML4zEqulKVjlo+ud5j20UWnVrRWCoEnO07TM0Y7nPDjvIKdlGhu3DVTHI0+/
 zivpZjTSB96XIyy7xQ1W6y+0nAI3otSJOCkenb3J1eoc84hddyB6rVjGJ3gHwObeti
 +PbXzlhHou4xI21wJSLGKHJcNIwRf+ILwM4vChOE=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37O3BAY7030865
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 23 Aug 2023 22:11:10 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Aug 2023 22:11:09 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Aug 2023 22:11:09 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37O3B9qk015463;
 Wed, 23 Aug 2023 22:11:10 -0500
From: Nishanth Menon <nm@ti.com>
To: Neha Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, Simon
 Glass <sjg@google.com>
CC: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V5 07/17] include: env: ti: ti_armv7_common.env: Rename to
 ti_common.env
Date: Wed, 23 Aug 2023 22:10:51 -0500
Message-ID: <20230824031101.3460411-8-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230824031101.3460411-1-nm@ti.com>
References: <20230824031101.3460411-1-nm@ti.com>
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
Signed-off-by: Nishanth Menon <nm@ti.com>
---
New patch review comment from:
https://lore.kernel.org/all/20230823144257.GG3953269@bill-the-cat/

ti_common.h does'nt need any header file support if we switch to
bootstd.

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

