Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA67C3DA7F
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 14:30:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B8568898E;
	Mon,  5 Aug 2024 16:30:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qBsiYhIK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36D8488986; Mon,  5 Aug 2024 16:30:15 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2A44884CC
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 16:30:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 475EUAOW068756;
 Mon, 5 Aug 2024 09:30:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1722868210;
 bh=LocL+YhaXHES0HZl4jFE5Df6/tvQExxvwOxob/ya5rw=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=qBsiYhIKkBjaCBEhm2ER/sRTVLRslVIiaZY5n7HNUReH3DBUrBwdj5q3sHEC7jIGJ
 jqHcqLSWyKK3R+CGSrSucnxTd9LycbmFHLzdYHoydvHd/PO/FJ6gxvAuKyIkF2id2X
 SvjBWIYPge2vF7A6N53iV//Lvt6773E/YalCL8a0=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 475EUAMP111088
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 5 Aug 2024 09:30:10 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Aug 2024 09:30:10 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Aug 2024 09:30:10 -0500
Received: from lcpd911.dhcp.ti.com (lcpd911.dhcp.ti.com [172.24.227.68])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 475ETihq084343;
 Mon, 5 Aug 2024 09:30:06 -0500
From: Dhruva Gole <d-gole@ti.com>
To: Tom Rini <trini@konsulko.com>, Nishant Menon <nm@ti.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>,
 <c-shilwant@ti.com>, <m-chawdhry@ti.com>, <vigneshr@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>,
 Vibhore Vardhan <vibhore@ti.com>, Vishal Mahaveer <vishalm@ti.com>,
 Sebin Francis <sebin.francis@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, <t.remmet@phytec.de>,
 <mkorpershoek@baylibre.com>, Daniel Schultz <d.schultz@phytec.de>,
 Dhruva Gole <d-gole@ti.com>
Subject: [PATCH V8 3/7] doc: board: ti: Update to use the new boot firmware
 labels
Date: Mon, 5 Aug 2024 19:59:33 +0530
Message-ID: <20240805142937.443737-4-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240805142937.443737-1-d-gole@ti.com>
References: <20240805142937.443737-1-d-gole@ti.com>
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

Use the new boot_firmwares labels that help make documentation more
specific as to which firmwares are used in which devices

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 doc/board/beagle/j721e_beagleboneai64.rst | 4 ++++
 doc/board/phytec/phycore-am62x.rst        | 4 ++++
 doc/board/phytec/phycore-am64x.rst        | 4 ++++
 doc/board/ti/am64x_evm.rst                | 4 ++++
 doc/board/ti/am65x_evm.rst                | 4 ++++
 doc/board/ti/j7200_evm.rst                | 4 ++++
 doc/board/ti/j721e_evm.rst                | 4 ++++
 doc/board/ti/j721s2_evm.rst               | 4 ++++
 doc/board/ti/j722s_evm.rst                | 4 ++++
 doc/board/ti/j784s4_evm.rst               | 4 ++++
 10 files changed, 40 insertions(+)

diff --git a/doc/board/beagle/j721e_beagleboneai64.rst b/doc/board/beagle/j721e_beagleboneai64.rst
index d6b9c8ca606a..090b2b3b86ae 100644
--- a/doc/board/beagle/j721e_beagleboneai64.rst
+++ b/doc/board/beagle/j721e_beagleboneai64.rst
@@ -42,6 +42,10 @@ Sources:
     :start-after: .. k3_rst_include_start_boot_sources
     :end-before: .. k3_rst_include_end_boot_sources
 
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_boot_firmwares
+    :end-before: .. k3_rst_include_end_boot_firmwares
+
 Build procedure:
 ----------------
 0. Setup the environment variables:
diff --git a/doc/board/phytec/phycore-am62x.rst b/doc/board/phytec/phycore-am62x.rst
index a7ce2c58825b..af24acf9aac4 100644
--- a/doc/board/phytec/phycore-am62x.rst
+++ b/doc/board/phytec/phycore-am62x.rst
@@ -30,6 +30,10 @@ Sources
     :start-after: .. k3_rst_include_start_boot_sources
     :end-before: .. k3_rst_include_end_boot_sources
 
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_boot_firmwares
+    :end-before: .. k3_rst_include_end_boot_firmwares
+
 Build procedure
 ---------------
 
diff --git a/doc/board/phytec/phycore-am64x.rst b/doc/board/phytec/phycore-am64x.rst
index 68d78ad7c25a..01c42b906607 100644
--- a/doc/board/phytec/phycore-am64x.rst
+++ b/doc/board/phytec/phycore-am64x.rst
@@ -30,6 +30,10 @@ Sources
     :start-after: .. k3_rst_include_start_boot_sources
     :end-before: .. k3_rst_include_end_boot_sources
 
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_boot_firmwares_sysfw
+    :end-before: .. k3_rst_include_end_boot_firmwares_sysfw
+
 Build procedure
 ---------------
 
diff --git a/doc/board/ti/am64x_evm.rst b/doc/board/ti/am64x_evm.rst
index 88997b6a283e..65c4c456528c 100644
--- a/doc/board/ti/am64x_evm.rst
+++ b/doc/board/ti/am64x_evm.rst
@@ -48,6 +48,10 @@ Sources:
     :start-after: .. k3_rst_include_start_boot_sources
     :end-before: .. k3_rst_include_end_boot_sources
 
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_boot_firmwares_sysfw
+    :end-before: .. k3_rst_include_end_boot_firmwares_sysfw
+
 Build procedure:
 ----------------
 0. Setup the environment variables:
diff --git a/doc/board/ti/am65x_evm.rst b/doc/board/ti/am65x_evm.rst
index 89011c08dd46..60b08ceebf0f 100644
--- a/doc/board/ti/am65x_evm.rst
+++ b/doc/board/ti/am65x_evm.rst
@@ -58,6 +58,10 @@ Sources:
     :start-after: .. k3_rst_include_start_boot_sources
     :end-before: .. k3_rst_include_end_boot_sources
 
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_boot_firmwares_sysfw
+    :end-before: .. k3_rst_include_end_boot_firmwares_sysfw
+
 Build procedure:
 ----------------
 0. Setup the environment variables:
diff --git a/doc/board/ti/j7200_evm.rst b/doc/board/ti/j7200_evm.rst
index d4a823fa26ca..4fd2aff83547 100644
--- a/doc/board/ti/j7200_evm.rst
+++ b/doc/board/ti/j7200_evm.rst
@@ -47,6 +47,10 @@ Sources:
     :start-after: .. k3_rst_include_start_boot_sources
     :end-before: .. k3_rst_include_end_boot_sources
 
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_boot_firmwares
+    :end-before: .. k3_rst_include_end_boot_firmwares
+
 Build procedure:
 ----------------
 0. Setup the environment variables:
diff --git a/doc/board/ti/j721e_evm.rst b/doc/board/ti/j721e_evm.rst
index 80d91cafab08..41c8d4c72a8d 100644
--- a/doc/board/ti/j721e_evm.rst
+++ b/doc/board/ti/j721e_evm.rst
@@ -52,6 +52,10 @@ Sources:
     :start-after: .. k3_rst_include_start_boot_sources
     :end-before: .. k3_rst_include_end_boot_sources
 
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_boot_firmwares
+    :end-before: .. k3_rst_include_end_boot_firmwares
+
 Build procedure:
 ----------------
 0. Setup the environment variables:
diff --git a/doc/board/ti/j721s2_evm.rst b/doc/board/ti/j721s2_evm.rst
index f5c48c96a837..21683b90b1a8 100644
--- a/doc/board/ti/j721s2_evm.rst
+++ b/doc/board/ti/j721s2_evm.rst
@@ -60,6 +60,10 @@ Sources:
     :start-after: .. k3_rst_include_start_boot_sources
     :end-before: .. k3_rst_include_end_boot_sources
 
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_boot_firmwares
+    :end-before: .. k3_rst_include_end_boot_firmwares
+
 Build procedure:
 ----------------
 
diff --git a/doc/board/ti/j722s_evm.rst b/doc/board/ti/j722s_evm.rst
index 10b243908a1c..e5a1be50c4fa 100644
--- a/doc/board/ti/j722s_evm.rst
+++ b/doc/board/ti/j722s_evm.rst
@@ -45,6 +45,10 @@ Sources:
     :start-after: .. k3_rst_include_start_boot_sources
     :end-before: .. k3_rst_include_end_boot_sources
 
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_boot_firmwares
+    :end-before: .. k3_rst_include_end_boot_firmwares
+
 Build procedure:
 ----------------
 
diff --git a/doc/board/ti/j784s4_evm.rst b/doc/board/ti/j784s4_evm.rst
index 2ffec3dbd3be..a1e927cb7438 100644
--- a/doc/board/ti/j784s4_evm.rst
+++ b/doc/board/ti/j784s4_evm.rst
@@ -60,6 +60,10 @@ Sources
     :start-after: .. k3_rst_include_start_boot_sources
     :end-before: .. k3_rst_include_end_boot_sources
 
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_boot_firmwares
+    :end-before: .. k3_rst_include_end_boot_firmwares
+
 Build procedure
 ---------------
 0. Setup the environment variables:
-- 
2.34.1

