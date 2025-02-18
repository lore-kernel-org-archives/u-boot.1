Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38068C021AA
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 02:57:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5107280F42;
	Tue, 18 Feb 2025 03:57:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Lrt6Ru5E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFC9580F1C; Tue, 18 Feb 2025 03:57:30 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8AF480ADF
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 03:57:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739847448; x=1771383448;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rggogbX44phn6cdhO8dJEqdtDf64YUbeYEOg6zEsM5g=;
 b=Lrt6Ru5EV6y4beWBujwVULE2eInetyXvpEG8jreAikMB7qpdYisyFk5a
 DLPiFINhrrgmPzgLKlYFD10thArnYf7fLG0QI/TAgyF0aiXPGxQVMtP0J
 jhSTkF84lZnz9wb+yTeJDLcoeUKvsYnBbFhjEZt2CBfLxrtxbs2/yn5Dh
 1vy2RQfUJz5/5oif9Cq+hEGJmQtGq9bHZWNyqOqjK+Jc1aQkN0XpYj470
 LwglJxOzghpLC3iAwgnKWb6BLZ6mgZf7HvSnI4g1go7+lDnBlW9y8PWZq
 UUs7u6S5JuG0r6hmfMyGto0kpmuah5HTstC3LBCkveAlZrXDty0/aI1Hg w==;
X-CSE-ConnectionGUID: 3gma2OXlTQiTAtohk+u9Kw==
X-CSE-MsgGUID: B9kLR7/lSYOMjbawRu5AAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="51174119"
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; d="scan'208";a="51174119"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 18:57:27 -0800
X-CSE-ConnectionGUID: GajcoV6DQcexm+7pW0zmqA==
X-CSE-MsgGUID: 7DoF5dQKTCKtOqL85x2BPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; d="scan'208";a="119259253"
Received: from apgcp0c530105.png.altera.com ([10.244.76.183])
 by orviesa004.jf.intel.com with ESMTP; 17 Feb 2025 18:57:21 -0800
From: dinesh.maniyam@intel.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Wang Jie <dave.wang@rock-chips.com>,
 Tingting Meng <tingting.meng@intel.com>,
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Dinesh <dinesh.maniyam@intel.com>, Boon Khai <boon.khai.ng@intel.com>,
 Alif <alif.zakuan.yuslaimi@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>
Subject: [PATCH 01/10] dt-bindings: i3c: Add YAML schema for Cadence I3C
 controller
Date: Tue, 18 Feb 2025 10:56:56 +0800
Message-Id: <20250218025705.50051-2-dinesh.maniyam@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250218025705.50051-1-dinesh.maniyam@intel.com>
References: <20250218025705.50051-1-dinesh.maniyam@intel.com>
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

Add a YAML device tree binding schema for the Cadence I3C controller,
defining required and optional properties for proper integration
and validation with dt-schema.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
---
 .../i3c/cdns,i3c-master.yaml                  |  51 +++++
 doc/device-tree-bindings/i3c/i3c.yaml         | 186 ++++++++++++++++++
 2 files changed, 237 insertions(+)
 create mode 100644 doc/device-tree-bindings/i3c/cdns,i3c-master.yaml
 create mode 100644 doc/device-tree-bindings/i3c/i3c.yaml

diff --git a/doc/device-tree-bindings/i3c/cdns,i3c-master.yaml b/doc/device-tree-bindings/i3c/cdns,i3c-master.yaml
new file mode 100644
index 0000000000..0eda16482e
--- /dev/null
+++ b/doc/device-tree-bindings/i3c/cdns,i3c-master.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i3c/cdns,i3c-master.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cadence I3C master block
+
+maintainers:
+  - Dinesh Maniyam <dinesh.maniyam@intel.com>
+
+allOf:
+  - $ref: i3c.yaml#
+
+properties:
+  compatible:
+    const: snps,dw-i3c-master-1.00a
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 2
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i3c-master@2000 {
+        compatible = "snps,dw-i3c-master-1.00a";
+        reg = <0x02000 0x1000>;
+        interrupts = <0>;
+        clocks = <&i3cclk>;
+        #address-cells = <2>;
+        #size-cells = <0>;
+
+        eeprom@57{
+            compatible = "atmel,24c01";
+            reg = <0x57 0x0 0x10>;
+            pagesize = <0x8>;
+        };
+    };
diff --git a/doc/device-tree-bindings/i3c/i3c.yaml b/doc/device-tree-bindings/i3c/i3c.yaml
new file mode 100644
index 0000000000..8f9c440db2
--- /dev/null
+++ b/doc/device-tree-bindings/i3c/i3c.yaml
@@ -0,0 +1,186 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i3c/i3c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: I3C bus
+
+maintainers:
+  - Dinesh Maniyam <dinesh.maniyam@intel.com>
+
+description: |
+  I3C busses can be described with a node for the primary I3C controller device
+  and a set of child nodes for each I2C or I3C slave on the bus. Each of them
+  may, during the life of the bus, request mastership.
+
+properties:
+  $nodename:
+    pattern: "^i3c-master@[0-9a-f]+$"
+
+  "#address-cells":
+    const: 3
+    description: |
+      Each I2C device connected to the bus should be described in a subnode.
+
+      All I3C devices are supposed to support DAA (Dynamic Address Assignment),
+      and are thus discoverable. So, by default, I3C devices do not have to be
+      described in the device tree. This being said, one might want to attach
+      extra resources to these devices, and those resources may have to be
+      described in the device tree, which in turn means we have to describe
+      I3C devices.
+
+      Another use case for describing an I3C device in the device tree is when
+      this I3C device has a static I2C address and we want to assign it a
+      specific I3C dynamic address before the DAA takes place (so that other
+      devices on the bus can't take this dynamic address).
+
+  "#size-cells":
+    const: 0
+
+  i3c-scl-hz:
+    description: |
+      Frequency of the SCL signal used for I3C transfers. When undefined, the
+      default value should be 12.5MHz.
+
+      May not be supported by all controllers.
+
+  i2c-scl-hz:
+    description: |
+      Frequency of the SCL signal used for I2C transfers. When undefined, the
+      default should be to look at LVR (Legacy Virtual Register) values of
+      I2C devices described in the device tree to determine the maximum I2C
+      frequency.
+
+      May not be supported by all controllers.
+
+required:
+  - "#address-cells"
+  - "#size-cells"
+
+patternProperties:
+  "@[0-9a-f]+$":
+    type: object
+    description: |
+      I2C child, should be named: <device-type>@<i2c-address>
+
+      All properties described in Documentation/devicetree/bindings/i2c/i2c.txt
+      are valid here, except the reg property whose content is changed.
+
+    properties:
+      compatible:
+        description:
+          Compatible of the I2C device.
+
+      reg:
+        items:
+          - items:
+              - description: |
+                  I2C address. 10 bit addressing is not supported. Devices with
+                  10-bit address can't be properly passed through DEFSLVS
+                  command.
+                minimum: 0
+                maximum: 0x7f
+              - const: 0
+              - description: |
+                  Shall encode the I3C LVR (Legacy Virtual Register):
+                    bit[31:8]: unused/ignored
+                    bit[7:5]: I2C device index. Possible values:
+                      * 0: I2C device has a 50 ns spike filter
+                      * 1: I2C device does not have a 50 ns spike filter but
+                           supports high frequency on SCL
+                      * 2: I2C device does not have a 50 ns spike filter and is
+                           not tolerant to high frequencies
+                      * 3-7: reserved
+                    bit[4]: tell whether the device operates in FM (Fast Mode)
+                            or FM+ mode:
+                      * 0: FM+ mode
+                      * 1: FM mode
+                    bit[3:0]: device type
+                      * 0-15: reserved
+
+    required:
+      - compatible
+      - reg
+
+  "@[0-9a-f]+,[0-9a-f]+$":
+    type: object
+    description: |
+      I3C child, should be named: <device-type>@<static-i2c-address>,<i3c-pid>
+
+    properties:
+      reg:
+        items:
+          - items:
+              - description: |
+                  Encodes the static I2C address. Should be 0 if the device does
+                  not have one (0 is not a valid I2C address).
+                minimum: 0
+                maximum: 0x7f
+              - description: |
+                  First half of the Provisional ID (following the PID
+                  definition provided by the I3C specification).
+
+                  Contains the manufacturer ID left-shifted by 1.
+              - description: |
+                  Second half of the Provisional ID (following the PID
+                  definition provided by the I3C specification).
+
+                  Contains the ORing of the part ID left-shifted by 16,
+                  the instance ID left-shifted by 12 and extra information.
+
+      assigned-address:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0x1
+        maximum: 0xff
+        description: |
+          Dynamic address to be assigned to this device. In case static address is
+          present (first cell of the reg property != 0), this address is assigned
+          through SETDASA. If static address is not present, this address is assigned
+          through SETNEWDA after assigning a temporary address via ENTDAA.
+
+    required:
+      - reg
+
+additionalProperties: true
+
+examples:
+  - |
+    i3c-master@d040000 {
+        compatible = "cdns,i3c-master";
+        clocks = <&coreclock>, <&i3csysclock>;
+        clock-names = "pclk", "sysclk";
+        interrupts = <3 0>;
+        reg = <0x0d040000 0x1000>;
+        #address-cells = <3>;
+        #size-cells = <0>;
+        i2c-scl-hz = <100000>;
+
+        /* I2C device. */
+        eeprom@57 {
+            compatible = "atmel,24c01";
+            reg = <0x57 0x0 0x10>;
+            pagesize = <0x8>;
+        };
+
+        /* I3C device with a static I2C address and assigned address. */
+        thermal_sensor: sensor@68,39200144004 {
+            reg = <0x68 0x392 0x144004>;
+            assigned-address = <0xa>;
+        };
+
+        /* I3C device with only assigned address. */
+        pressure_sensor: sensor@0,39200124004 {
+            reg = <0x0 0x392 0x124000>;
+            assigned-address = <0xc>;
+        };
+
+        /*
+         * I3C device without a static I2C address but requiring
+         * resources described in the DT.
+         */
+        sensor@0,39200154004 {
+            reg = <0x0 0x392 0x154004>;
+            clocks = <&clock_provider 0>;
+        };
+    };
-- 
2.26.2

