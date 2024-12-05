Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB29E77170
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 09:23:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88AE389326;
	Thu,  5 Dec 2024 10:23:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="k2jZuoBB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 106A3892DC; Thu,  5 Dec 2024 10:23:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F771892B5
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 10:23:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733390618; x=1764926618;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mS91d8EX+UU7uFzTh3SjznWbY+d9MN3r86BnUcUcaEs=;
 b=k2jZuoBB1nXEegTSw7QgFPs32U5JKqD5VxA1HKJL0B6PtmnRQ60Qmysf
 eqzlQTiGSofpIwcy32SiLb5eZfw4ckNZtb9IUh2OTcRO74p+Rt7Sl5hq3
 tDg/qW0CF5vaVsLCnQRaF7illsQlpXr259t94tPFWF6QEQUzNFqVHcP/F
 ELg90kLD4cRTgIr8cVH/rMIFfQXk8yK03xtY0JQ6CT1IBSed6BoDPkodD
 wFjcb45KEec1+rh33Y+kQwUokHU208B7McLha3M8gRGFYtfRZtxYdtNMF
 27eKY98yfGlcJ3+qW3aXK1CJ3GJ9Bzj9iqZ8dG7Bdcxb+8P5ikRMaWYjL w==;
X-CSE-ConnectionGUID: ZB4nttEvTbuehA8+07z8Xw==
X-CSE-MsgGUID: xUI8jJIeRK2oHRj5Ue1cNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33610110"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="33610110"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2024 01:23:37 -0800
X-CSE-ConnectionGUID: ja0knxxxSXersGPOCLP9cA==
X-CSE-MsgGUID: Uh/ndn3OSu+V/3Vt3KRrxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="94121786"
Received: from apgcp0d551111.png.altera.com ([10.244.77.49])
 by orviesa006.jf.intel.com with ESMTP; 05 Dec 2024 01:23:32 -0800
From: dinesh.maniyam@intel.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Johan Jonker <jbx6244@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Alexander Dahl <ada@thorsis.com>,
 William Zhang <william.zhang@broadcom.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Tingting Meng <tingting.meng@intel.com>,
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Dinesh <dinesh.maniyam@intel.com>, Boon Khai <boon.khai.ng@intel.com>,
 Alif <alif.zakuan.yuslaimi@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>
Subject: [resend v2 01/19] dt: nand: add cadence nand dt-bindings
Date: Thu,  5 Dec 2024 17:22:57 +0800
Message-Id: <20241205092315.25060-2-dinesh.maniyam@intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20241205092315.25060-1-dinesh.maniyam@intel.com>
References: <20241205092315.25060-1-dinesh.maniyam@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Dinesh Maniyam <dinesh.maniyam@intel.com>

The Cadence NAND is a configurable mtd raw block which
supports multiple options for chipsets, clocking and reset structure, and
feature list.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
---
 .../mtd/cadence,nand.yaml                     | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)
 create mode 100644 doc/device-tree-bindings/mtd/cadence,nand.yaml

diff --git a/doc/device-tree-bindings/mtd/cadence,nand.yaml b/doc/device-tree-bindings/mtd/cadence,nand.yaml
new file mode 100644
index 0000000000..11ce023ec6
--- /dev/null
+++ b/doc/device-tree-bindings/mtd/cadence,nand.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/cadence,nand.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cadence NAND controller
+
+maintainers:
+  - Dinesh Maniyam <dinesh.maniyam@intel.com>
+
+properties:
+  compatible:
+    enum:
+      - cdns,nand
+
+  reg-names:
+    description: |
+      There are two register regions:
+        reg:  register interface
+        sdma: host data/command interface
+    items:
+      - const: reg
+      - const: sdma
+
+  reg:
+    minItems: 2
+    maxItems: 2
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    description: |
+      There is one controller core clock
+    maxItems: 1
+
+  resets:
+    description: |
+      There are two resets:
+        controller core reset
+        combo-phy register reset
+    minItems: 1
+    maxItems: 2
+
+  cdns,board-delay-ps:
+     description: |
+        Estimated Board delay. The value includes the total
+        round trip delay for the signals and is used for deciding on values
+        associated with data read capture. The example formula for SDR mode is
+        the following:
+        board delay = RE#PAD delay + PCB trace to device + PCB trace from device
+        + DQ PAD delay
+     enum:
+       - 4830
+
+patternProperties:
+  "^nand@[a-f0-9]$":
+    type: object
+    properties:
+      compatible:
+        const: cdns,nand
+
+      reg:
+        maxItems: 1
+
+      label:
+        maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - cdns,board-delay-ps
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    nand-controller@60000000 {
+        compatible = "cdns,nand";
+        reg = <0x60000000 0x10000>, <0x80000000 0x1000>;
+        reg-names = "reg", "sdma";
+        #address-cells = <1>;
+        #size-cells = <0>;
+        clocks = <&clk>;
+        cdns,board-delay-ps = <4830>;
+        interrupts = <2 0>;
+        nand@0 {
+            label = "nand-0";
+            reg = <0>;
+        };
+        nand@1 {
+            label = "nand-1";
+            reg = <1>;
+        };
+    };
-- 
2.19.0

