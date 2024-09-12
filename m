Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B17EED617
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 15:53:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64C6789049;
	Thu, 12 Sep 2024 17:51:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lZzBCARZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83F9989021; Thu, 12 Sep 2024 17:51:23 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAA3B89025
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 17:51:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+Oliver.Gaskell.analog.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id A9A13A45700;
 Thu, 12 Sep 2024 15:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C08C2C4CEC6;
 Thu, 12 Sep 2024 15:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1726156274;
 bh=jiudcapLJNwdg9nuscUk9FZ/6DIfkVvPcIlXRKSjEas=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=lZzBCARZQe6mTa8Z0MiP8dOQtHwNTld7fqG+7oV0uiaZGMC7b8XvUk1PGBvuSlzy5
 IXPWC74U0+j+u4ji0H6K8CknvZJoMt52BuFpkk9/OV1jn0WhCLGGtPqCvR4pwKrBoI
 SyuGH9kTe5x/Xi3n8RcosqkwdA3zA3mmRsWZa6OCRvbiOvzB0GgYSxRuN5rJF6DkDR
 E3dmFh6owEduacyOelx1OQdrFiuW40IIW9OunyA23YMStAdtaHcq5uWG1LJg2YlBUC
 xcBJFjNRPY+8DTVrWrlQGTlHIPo5z9i3r8TY/cex7b12dgKX0WvO8xEyf+qHza61vG
 CHKZ6Ga/7FqYQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id B892DEED619;
 Thu, 12 Sep 2024 15:51:14 +0000 (UTC)
From: Oliver Gaskell via B4 Relay
 <devnull+Oliver.Gaskell.analog.com@kernel.org>
Date: Thu, 12 Sep 2024 16:50:51 +0100
Subject: [PATCH v2 10/20] dt-bindings: clock: Add SC5xx clock tree bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240912-sc5xx-upstreaming-patches-v2-10-1185a80df79e@analog.com>
References: <20240912-sc5xx-upstreaming-patches-v2-0-1185a80df79e@analog.com>
In-Reply-To: <20240912-sc5xx-upstreaming-patches-v2-0-1185a80df79e@analog.com>
To: Tom Rini <trini@konsulko.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Greg Malysa <greg.malysa@timesys.com>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc: u-boot@lists.denx.de, adsp-linux@analog.com, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726156261; l=4165;
 i=Oliver.Gaskell@analog.com; s=20240821; h=from:subject:message-id;
 bh=2FEEY7pe26grUqXJDJSVa7JE1wxMnPXrOYMaC4NEUB4=;
 b=64Keh5d0bpxfshK4DTTjPMGXqS2axhgU/MVibP4MiJipd+qw0at18iR5E5jJDcCZu+QVWCgzW
 xx1SEWDbq42BG1jNnL5bROgWObW4Rh0gVnP5jbX2JXSizPvgIYpujSP
X-Developer-Key: i=Oliver.Gaskell@analog.com; a=ed25519;
 pk=Icq9TxwFJ6FePHS28YbBWMvtZpFWxpPQLhLA9cNvZ/Y=
X-Endpoint-Received: by B4 Relay for Oliver.Gaskell@analog.com/20240821
 with auth_id=197
X-Original-From: Oliver Gaskell <Oliver.Gaskell@analog.com>
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
Reply-To: Oliver.Gaskell@analog.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Oliver Gaskell <Oliver.Gaskell@analog.com>

Add devicetree schema for the clock tree on Analog Devices SC5xx series
SoCs.

Co-developed-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Oliver Gaskell <Oliver.Gaskell@analog.com>
---
 MAINTAINERS                                        |   1 +
 .../clock/adi,sc5xx-clocks.yaml                    | 112 +++++++++++++++++++++
 2 files changed, 113 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 38ac172c03..c196368a72 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -608,6 +608,7 @@ F:	arch/arm/dts/sc5*
 F:	arch/arm/include/asm/arch-adi/
 F:	arch/arm/mach-sc5xx/
 F:	doc/device-tree-bindings/arm/adi/adi,sc5xx.yaml
+F:	doc/device-tree-bindings/clock/adi,sc5xx-clocks.yaml
 F:	drivers/clk/adi/
 F:	drivers/serial/serial_adi_uart4.c
 F:	drivers/timer/adi_sc5xx_timer.c
diff --git a/doc/device-tree-bindings/clock/adi,sc5xx-clocks.yaml b/doc/device-tree-bindings/clock/adi,sc5xx-clocks.yaml
new file mode 100644
index 0000000000..9bbd5467a0
--- /dev/null
+++ b/doc/device-tree-bindings/clock/adi,sc5xx-clocks.yaml
@@ -0,0 +1,112 @@
+# SPDX-License-Identifier: (GPL-2.0+)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/adi,sc5xx-clocks.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Clock Tree Drivers for Analog Devices SC5XX Processors
+
+maintainers:
+  - Vasileios Bimpikas <vasileios.bimpikas@analog.com>
+  - Utsav Agarwal <utsav.agarwal@analog.com>
+  - Arturs Artamonovs <arturs.artamonovs@analog.com>
+
+description: |
+  These drivers read in the processors CDU (clock distribution unit)
+  and CGU (clock generation unit) values to determine various clock
+  rates
+
+properties:
+  compatible:
+    enum:
+      - adi,sc5xx-clocks # Any
+      - adi,sc57x-clocks # 32-Bit SC573 processor
+      - adi,sc58x-clocks # 32-Bit SC584, SC589 processors
+      - adi,sc594-clocks # 32-Bit SC594 processor
+      - adi,sc598-clocks # 64-Bit SC598 processor
+
+  '#clock-cells':
+    const: 1
+
+  reg:
+    minItems: 3
+    maxItems: 4
+
+  reg-names:
+    description:
+      String reference names for the reg property
+    minItems: 3
+    maxItems: 4
+
+  clocks:
+    description:
+      Specifies the CLKIN0 and CLKIN1 reference clock(s) from which the
+      output frequencies are derived via CDU+CGU
+    minItems: 2
+    maxItems: 2
+
+  clock-names:
+    description:
+      String reference names for CLKIN0 and CLKIN1
+    minItems: 2
+    maxItems: 2
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#clock-cells'
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    clk0: clocks@3108d000 {
+      compatible = "adi,sc57x-clocks";
+      reg = <0x3108d000 0x1000>,
+            <0x3108e000 0x1000>,
+            <0x3108f000 0x1000>;
+      #clock-cells = <1>;
+      clocks = <&sys_clkin0>, <&sys_clkin1>;
+      clock-names = "sys_clkin0", "sys_clkin1";
+      status = "okay";
+    };
+
+  - |
+    clk1: clocks@3108d000 {
+      compatible = "adi,sc58x-clocks";
+      reg = <0x3108d000 0x1000>,
+            <0x3108e000 0x1000>,
+            <0x3108f000 0x1000>;
+      #clock-cells = <1>;
+      clocks = <&sys_clkin0>, <&sys_clkin1>;
+      clock-names = "sys_clkin0", "sys_clkin1";
+      status = "okay";
+    };
+
+  - |
+    clk2: clocks@3108d000 {
+      compatible = "adi,sc594-clocks";
+      reg = <0x3108d000 0x1000>,
+            <0x3108e000 0x1000>,
+            <0x3108f000 0x1000>;
+      #clock-cells = <1>;
+      clocks = <&sys_clkin0>, <&sys_clkin1>;
+      clock-names = "sys_clkin0", "sys_clkin1";
+      status = "okay";
+    };
+
+  - |
+    clk3: clocks@3108d000 {
+      compatible = "adi,sc598-clocks";
+      reg = <0x3108d000 0x1000>,
+            <0x3108e000 0x1000>,
+            <0x3108f000 0x1000>,
+            <0x310a9000 0x1000>;
+      #clock-cells = <1>;
+      clocks = <&sys_clkin0>, <&sys_clkin1>;
+      clock-names = "sys_clkin0", "sys_clkin1";
+      status = "okay";
+    };
+

-- 
2.34.1


