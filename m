Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA316C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 09:38:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34961882EF;
	Thu, 25 Jul 2024 11:38:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VVaxkl8D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20A37880D1; Thu, 25 Jul 2024 11:38:51 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D460587EDC
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 11:38:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46P9ckgF108841;
 Thu, 25 Jul 2024 04:38:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1721900326;
 bh=NBBetsHXTWDKTHgKLNQBPnhIupTeMLkV5eGlXYmS1MI=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=VVaxkl8DdDASjLij1CooRQmrcXokSAIWKf9E8YMvBef8sdu4msUAOwND0mg+6ntLy
 e/n1E/tYzQcY6y1GjbxFvzuk2qjXzYvNUrwPbmjQ9dmFXVtRLx6sa6dHRs5CJ+A2zS
 1J80/2gLcZHMqHEDBdauLHExehcq4/groDfE74dQ=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46P9ckYf000881
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 25 Jul 2024 04:38:46 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Jul 2024 04:38:45 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Jul 2024 04:38:45 -0500
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46P9ad8T066876;
 Thu, 25 Jul 2024 04:38:41 -0500
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
Subject: [PATCH V7 2/7] doc: ti: k3: Add TIFS Stub documentation
Date: Thu, 25 Jul 2024 15:05:42 +0530
Message-ID: <20240725093546.4193107-3-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240725093546.4193107-1-d-gole@ti.com>
References: <20240725093546.4193107-1-d-gole@ti.com>
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

* Add documentation to briefly explain the role of TIFS Stub in relevant
  K3 SoC's.
* Shed light on why TIFS Stub isn't package with the DM firmware itself.
* Modify the platform docs wherever the TIFS Stub documentation applies.
* Also, refactor and add a few new labels to help split the firmware
  documentation chunks. This will make it easier to include them one by
  one wherever applicable

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 doc/board/ti/am62ax_sk.rst        |  4 +++
 doc/board/ti/am62px_sk.rst        |  4 +++
 doc/board/ti/am62x_sk.rst         |  4 +++
 doc/board/ti/k3.rst               | 51 +++++++++++++++++++++----------
 doc/board/toradex/verdin-am62.rst |  4 +++
 5 files changed, 51 insertions(+), 16 deletions(-)

diff --git a/doc/board/ti/am62ax_sk.rst b/doc/board/ti/am62ax_sk.rst
index 60726b6652ce..72fa5a8d8cdd 100644
--- a/doc/board/ti/am62ax_sk.rst
+++ b/doc/board/ti/am62ax_sk.rst
@@ -60,6 +60,10 @@ Sources:
     :start-after: .. k3_rst_include_start_boot_sources
     :end-before: .. k3_rst_include_end_boot_sources
 
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_boot_firmwares
+    :end-before: .. k3_rst_include_end_tifsstub
+
 Build procedure:
 ----------------
 0. Setup the environment variables:
diff --git a/doc/board/ti/am62px_sk.rst b/doc/board/ti/am62px_sk.rst
index c80b50681176..bcef6653cb92 100644
--- a/doc/board/ti/am62px_sk.rst
+++ b/doc/board/ti/am62px_sk.rst
@@ -68,6 +68,10 @@ Sources:
     :start-after: .. k3_rst_include_start_boot_sources
     :end-before: .. k3_rst_include_end_boot_sources
 
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_boot_firmwares
+    :end-before: .. k3_rst_include_end_tifsstub
+
 Build procedure:
 ----------------
 
diff --git a/doc/board/ti/am62x_sk.rst b/doc/board/ti/am62x_sk.rst
index 2a25e84f6c97..e2a848d159ff 100644
--- a/doc/board/ti/am62x_sk.rst
+++ b/doc/board/ti/am62x_sk.rst
@@ -59,6 +59,10 @@ Sources:
     :start-after: .. k3_rst_include_start_boot_sources
     :end-before: .. k3_rst_include_end_boot_sources
 
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_boot_firmwares
+    :end-before: .. k3_rst_include_end_tifsstub
+
 Build procedure:
 ----------------
 0. Setup the environment variables:
diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index 67b066a07d3a..c3513f0aee20 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -182,25 +182,44 @@ online
 
 .. note::
 
-  The TI Firmware required for functionality of the system can be
-  one of the following combination (see platform specific boot diagram for
-  further information as to which component runs on which processor):
-
-  * **TIFS** - TI Foundational Security Firmware - Consists of purely firmware
-    meant to run on the security enclave.
-  * **DM** - Device Management firmware also called TI System Control Interface
-    server (TISCI Server) - This component purely plays the role of managing
-    device resources such as power, clock, interrupts, dma etc. This firmware
-    runs on a dedicated or multi-use microcontroller outside the security
-    enclave.
-
- OR
-
-  * **SYSFW** - System firmware - consists of both TIFS and DM both running on
-    the security enclave.
+  The TI Firmwares required for functionality of the system are (see
+  platform specific boot diagram for further information as to which
+  component runs on which processor):
 
 .. k3_rst_include_end_boot_sources
 
+.. k3_rst_include_start_boot_firmwares
+
+* **TIFS** - TI Foundational Security Firmware - Consists of purely firmware
+  meant to run on the security enclave.
+* **DM** - Device Management firmware also called TI System Control Interface
+  server (TISCI Server) - This component purely plays the role of managing
+  device resources such as power, clock, interrupts, dma etc. This firmware
+  runs on a dedicated or multi-use microcontroller outside the security
+  enclave.
+
+.. k3_rst_include_end_boot_firmwares
+.. k3_rst_include_start_tifsstub
+
+* **TIFS Stub** - The TIFS stub is a small piece of binary designed to help
+  restore the required security context and resume the TIFS firmware when
+  the system resumes from low-power modes such as suspend-to-RAM/Deep
+  Sleep. This stub uses the same encryption and customer key signing model
+  as TIFS and is loaded into the ATCM (Tightly Coupled Memory 'A' of the
+  DM R5) during DM startup. Due to the independent certificate signing
+  process, the stub is maintained separately from DM.
+
+.. k3_rst_include_end_tifsstub
+
+OR
+
+.. k3_rst_include_start_boot_firmwares_sysfw
+
+* **SYSFW** - System firmware - consists of both TIFS and DM both running on
+  the security enclave.
+
+.. k3_rst_include_end_boot_firmwares_sysfw
+
 Build Procedure
 ---------------
 
diff --git a/doc/board/toradex/verdin-am62.rst b/doc/board/toradex/verdin-am62.rst
index e8d902732883..93912adc896d 100644
--- a/doc/board/toradex/verdin-am62.rst
+++ b/doc/board/toradex/verdin-am62.rst
@@ -29,6 +29,10 @@ Sources:
     :start-after: .. k3_rst_include_start_boot_sources
     :end-before: .. k3_rst_include_end_boot_sources
 
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_boot_firmwares
+    :end-before: .. k3_rst_include_end_tifsstub
+
 Build procedure:
 ----------------
 
-- 
2.34.1

