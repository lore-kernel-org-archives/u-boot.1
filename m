Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C474CE8D49
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 03:55:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5720088D7D;
	Thu, 19 Sep 2024 05:55:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="gKnZxTtg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5427088FC1; Thu, 19 Sep 2024 05:55:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CC9A88D7D
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 05:55:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726718128; x=1758254128;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TAVk2geLTEyuZSHmps6+LFcIiSu5yG8HfynUluWMStI=;
 b=gKnZxTtgXDnsL2/y9PAOFXc+p795xZUXcITsOQ5LMufayLu8e/pxNR1D
 ALEfyksdplxf/wdd4/UufOC2D6fCr73CMJIN6A8iyWYmgQiDk8RVTMUXe
 j41P7uL5r/NNeJkni9kPib3TTQEpJrhU/gfoljAP6QNaL18o7wl0AGHEW
 +yZDkIcBo/wy18ou2eYPttZK6CCYyzUJQOF0NRqcBeQVFPSGoEc/K0WSR
 suvSgy0Bt7kGvlGRQuLSRLnIh+TydmW9amAMCx3r9FflS31F4rv+1mRgC
 HcFBGdwthrkXgcq71WmPUz5ECOQ76mNx9d6PKm+04GNwZNqw9kjkWMLo5 A==;
X-CSE-ConnectionGUID: HYasjP1RQQmGTpDtM9xBzg==
X-CSE-MsgGUID: 1gEVwexURJmduuaPuVJ5Tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="43177924"
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="43177924"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2024 20:55:27 -0700
X-CSE-ConnectionGUID: Sh2/onytQsel1whuGlEA7Q==
X-CSE-MsgGUID: pS+q1rk5TwerDkwtbkryPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="70253698"
Received: from pglc00481.png.intel.com ([10.221.239.164])
 by orviesa007.jf.intel.com with ESMTP; 18 Sep 2024 20:55:22 -0700
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
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Dinesh <dinesh.maniyam@intel.com>, Boon Khai <boon.khai.ng@intel.com>,
 Alif <alif.zakuan.yuslaimi@intel.com>,
 Teik Heng <teik.heng.chong@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Tingting Meng <tingting.meng@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>
Subject: [PATCH 01/19] dt: nand: add cadence nand dt-bindings
Date: Thu, 19 Sep 2024 11:54:54 +0800
Message-Id: <20240919035512.13854-2-dinesh.maniyam@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240919035512.13854-1-dinesh.maniyam@intel.com>
References: <20240919035512.13854-1-dinesh.maniyam@intel.com>
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
2.26.2

