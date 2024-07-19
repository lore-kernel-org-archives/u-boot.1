Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F55AC3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 07:05:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D3A888B6D;
	Fri, 19 Jul 2024 09:05:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gnNuO962";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3460088B7F; Fri, 19 Jul 2024 09:05:03 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F075C88B64
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 09:04:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46J74pnq034968;
 Fri, 19 Jul 2024 02:04:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1721372691;
 bh=MRKjOCbKUGkvLQnLOdb0as/N72iyl3BU1PcYiDPPNl8=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=gnNuO962Rw5JxgdfVrZOaxH0yQI03ZvrLkO9j9PnPq6DLWiQbRP5IokFCvY/26i04
 2AkRU4fboQHc9QIaq3aQaLdPQhSPNMKxq1fXta29Qt0+4oeJElVM0cJ5mJPjarrsrV
 XRw5AC6Wxtv9gJINxcqghftph5UwaKsCxi/cxPYM=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46J74pco015489
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 19 Jul 2024 02:04:51 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 19
 Jul 2024 02:04:50 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 19 Jul 2024 02:04:51 -0500
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46J74b4q094617;
 Fri, 19 Jul 2024 02:04:47 -0500
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
Subject: [PATCH V6 2/6] doc: ti: k3: Add TIFS Stub documentation
Date: Fri, 19 Jul 2024 12:33:09 +0530
Message-ID: <20240719070312.3771755-3-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240719070312.3771755-1-d-gole@ti.com>
References: <20240719070312.3771755-1-d-gole@ti.com>
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
 doc/board/ti/k3.rst               | 55 ++++++++++++++++++++++---------
 doc/board/toradex/verdin-am62.rst |  4 +++
 5 files changed, 55 insertions(+), 16 deletions(-)

diff --git a/doc/board/ti/am62ax_sk.rst b/doc/board/ti/am62ax_sk.rst
index 60726b6652ce..8e9820ead734 100644
--- a/doc/board/ti/am62ax_sk.rst
+++ b/doc/board/ti/am62ax_sk.rst
@@ -60,6 +60,10 @@ Sources:
     :start-after: .. k3_rst_include_start_boot_sources
     :end-before: .. k3_rst_include_end_boot_sources
 
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_boot_firmwares
+    :end-before: .. k3_rst_include_end_lpm_firmware
+
 Build procedure:
 ----------------
 0. Setup the environment variables:
diff --git a/doc/board/ti/am62px_sk.rst b/doc/board/ti/am62px_sk.rst
index c80b50681176..527c693cb97e 100644
--- a/doc/board/ti/am62px_sk.rst
+++ b/doc/board/ti/am62px_sk.rst
@@ -68,6 +68,10 @@ Sources:
     :start-after: .. k3_rst_include_start_boot_sources
     :end-before: .. k3_rst_include_end_boot_sources
 
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_boot_firmwares
+    :end-before: .. k3_rst_include_end_lpm_firmware
+
 Build procedure:
 ----------------
 
diff --git a/doc/board/ti/am62x_sk.rst b/doc/board/ti/am62x_sk.rst
index 2a25e84f6c97..79e964461986 100644
--- a/doc/board/ti/am62x_sk.rst
+++ b/doc/board/ti/am62x_sk.rst
@@ -59,6 +59,10 @@ Sources:
     :start-after: .. k3_rst_include_start_boot_sources
     :end-before: .. k3_rst_include_end_boot_sources
 
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_boot_firmwares
+    :end-before: .. k3_rst_include_end_lpm_firmware
+
 Build procedure:
 ----------------
 0. Setup the environment variables:
diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index 67b066a07d3a..42631528a6b7 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -182,25 +182,48 @@ online
 
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
+.. k3_rst_include_start_lpm_firmware
+
+* **TIFS Stub** - A small piece of code that helps restore the remaining
+  context and resume the TIFS firmware when resuming from Low Power Modes
+  like Suspend-to-RAM/ Deep Sleep. It is loaded into the ATCM (Tightly
+  Coupled Memory 'A' of the DM R5) during DM startup. The reason it isn't
+  merged with DM is because in HS devices we need to sign the tifs-stub with
+  customer key. The DM cannot have a component signed using a customer key
+  because a HS device customer owns the customer key and only customer
+  has the access for the customer key. Since TIFS Stub signing has to happen
+  from the customer side but the DM is released by TI or built by customer
+  optionally using publicly available sources, we need to allow binman to
+  sign the TIFS Stub and only then package it alongside other firmwares.
+
+.. k3_rst_include_end_lpm_firmware
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
index e8d902732883..3e467f5a7fc3 100644
--- a/doc/board/toradex/verdin-am62.rst
+++ b/doc/board/toradex/verdin-am62.rst
@@ -29,6 +29,10 @@ Sources:
     :start-after: .. k3_rst_include_start_boot_sources
     :end-before: .. k3_rst_include_end_boot_sources
 
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_boot_firmwares
+    :end-before: .. k3_rst_include_end_lpm_firmware
+
 Build procedure:
 ----------------
 
-- 
2.34.1

