Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F53C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 04:30:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C47186D0E;
	Mon, 13 Nov 2023 05:30:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="sFc1L2Hn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 477E286516; Mon, 13 Nov 2023 05:30:35 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB40F86BA8
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 05:30:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AD4UU4j101480;
 Sun, 12 Nov 2023 22:30:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699849830;
 bh=Ean3ZT+OHtDOVwjubJTqHiKxwmuPisFtaevisqxN8Fg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=sFc1L2Hn5a+Gx6WHm1S9wPXpOqQ8iJPVsxqMcg8jtPNaJDo5dk3zPwyTMhKVec8wf
 oWaSWc1rvKjipVFjLd+v5qv/TDHaAs4g0P1ePckNea9UEc2pWiOeNPX++k/mV/y96w
 yM+YFNit9Bq8ZRG21y/HkpzgixLtPn6Zy/RFi0Go=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AD4UUfo001033
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 12 Nov 2023 22:30:30 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 12
 Nov 2023 22:30:30 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 12 Nov 2023 22:30:30 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AD4UOX6119664;
 Sun, 12 Nov 2023 22:30:27 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <nm@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <reidt@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>
Subject: [PATCH 1/2] dt-bindings: misc: Move esm-k3.txt to ti,j721e-esm.yaml
Date: Mon, 13 Nov 2023 10:00:22 +0530
Message-ID: <20231113043023.2126690-2-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231113043023.2126690-1-n-francis@ti.com>
References: <20231113043023.2126690-1-n-francis@ti.com>
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

Move esm-k3.txt to ti,j721e-esm.yaml in line with the devicetree
documentation in kernel.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 doc/device-tree-bindings/misc/esm-k3.txt      | 25 ---------
 .../misc/ti,j721e-esm.yaml                    | 53 +++++++++++++++++++
 2 files changed, 53 insertions(+), 25 deletions(-)
 delete mode 100644 doc/device-tree-bindings/misc/esm-k3.txt
 create mode 100644 doc/device-tree-bindings/misc/ti,j721e-esm.yaml

diff --git a/doc/device-tree-bindings/misc/esm-k3.txt b/doc/device-tree-bindings/misc/esm-k3.txt
deleted file mode 100644
index 01c8b6b294..0000000000
--- a/doc/device-tree-bindings/misc/esm-k3.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Texas Instruments K3 ESM Binding
-======================
-
-ESM (Error Signaling Module) is an IP block on TI K3 devices that allows
-handling of safety events somewhat similar to what interrupt controller
-would do. The safety signals have their separate paths within the SoC,
-and they are handled by the ESM, which routes them to the proper
-destination, which can be system reset, interrupt controller, etc. In
-the simplest configuration the signals are just routed to reset the
-SoC.
-
-Required properties :
-- compatible	: "ti,j721e-esm"
-- ti,esm-pins	: integer array of esm events IDs to route to external event
-		  pin which can be used to reset the SoC. The array can
-		  have arbitrary amount of event IDs listed on it.
-
-Example
-=======
-
-	main_esm: esm@700000 {
-		compatible = "ti,j721e-esm";
-		reg = <0x0 0x700000 0x0 0x1000>;
-		ti,esm-pins = <344>, <345>;
-	};
diff --git a/doc/device-tree-bindings/misc/ti,j721e-esm.yaml b/doc/device-tree-bindings/misc/ti,j721e-esm.yaml
new file mode 100644
index 0000000000..0c9a844484
--- /dev/null
+++ b/doc/device-tree-bindings/misc/ti,j721e-esm.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2022 Texas Instruments Incorporated
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/ti,j721e-esm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments K3 ESM
+
+maintainers:
+  - Neha Malcom Francis <n-francis@ti.com>
+
+description:
+  The ESM (Error Signaling Module) is an IP block on TI K3 devices
+  that allows handling of safety events somewhat similar to what interrupt
+  controller would do. The safety signals have their separate paths within
+  the SoC, and they are handled by the ESM, which routes them to the proper
+  destination, which can be system reset, interrupt controller, etc. In the
+  simplest configuration the signals are just routed to reset the SoC.
+
+properties:
+  compatible:
+    const: ti,j721e-esm
+
+  reg:
+    maxItems: 1
+
+  ti,esm-pins:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      integer array of ESM interrupt pins to route to external event pin
+      which can be used to reset the SoC.
+    minItems: 1
+    maxItems: 255
+
+required:
+  - compatible
+  - reg
+  - ti,esm-pins
+
+additionalProperties: false
+
+examples:
+  - |
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        esm@700000 {
+            compatible = "ti,j721e-esm";
+            reg = <0x0 0x700000 0x0 0x1000>;
+            ti,esm-pins = <344>, <345>;
+        };
+    };
-- 
2.34.1

