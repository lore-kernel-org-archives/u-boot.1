Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BCA1C54E71
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 10:14:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A39688AD7;
	Wed, 28 Aug 2024 12:12:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="StDSuLPt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58CE688744; Wed, 28 Aug 2024 12:12:32 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CAED88AB1
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 12:12:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+Oliver.Gaskell.analog.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 2B4ECA434E9;
 Wed, 28 Aug 2024 10:12:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CFDE6C4E678;
 Wed, 28 Aug 2024 10:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1724839448;
 bh=C5sF0QPF01NoXjHhAJUfElhNgBSqSyGMeempLt23Gag=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=StDSuLPtcm9ABngbRm2fYOQwCsg8nB8LDBy2QQAu37RMQW8sLyisigSWWHFZrR8UM
 om/aRXVZwhxaD72p983KxAw37fUa1MO+wZZrGk/jF9hJcPlycJL3GkmS8DtZ2sVRPy
 IpISKL33gDGSSYhHFtUtr+P0iaEK2Slr8wnv6UC/H330hx/+8exX15eBahpy16GGbU
 GsqBmavvYsuMJUSMAU+dGHapbKHMp/SMWCFoIn7IH18nTGbxWwJBS7EDb4+j6tlcFb
 YptnR39ZiTZAeATvE8CB3YVohuBqSktGG8bQ4rQIDagFyYs08w9Tbtsd7oIgaHRjp0
 1VvtI17ZtpUNQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id C8EB1C54E71;
 Wed, 28 Aug 2024 10:04:08 +0000 (UTC)
From: Oliver Gaskell via B4 Relay
 <devnull+Oliver.Gaskell.analog.com@kernel.org>
Date: Wed, 28 Aug 2024 11:02:18 +0100
Subject: [PATCH 10/20] dt-bindings: clock: Add SC5xx clock tree bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-sc5xx-upstreaming-patches-v1-10-44d9adfdf327@analog.com>
References: <20240828-sc5xx-upstreaming-patches-v1-0-44d9adfdf327@analog.com>
In-Reply-To: <20240828-sc5xx-upstreaming-patches-v1-0-44d9adfdf327@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724839434; l=4095;
 i=Oliver.Gaskell@analog.com; s=20240821; h=from:subject:message-id;
 bh=cuAg1O7gfyKVhPAk0NCafanQ9M53hS0+HLqu+jCXmdg=;
 b=4Dc9BZALHaIZPVGBa4rkTTd3ppNC6nnP2e4Sy8b0tgctHvzLE/tO/QiAxML31qr9AZFSwLG05
 R+qC8Ooh2OvCN/fRKRBPtq7BqqBgJgqAJPEwe3ZlFY2j6LtDXArOi13
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
Signed-off-by: Oliver Gaskell <Oliver.Gaskell@analog.com>
---
 MAINTAINERS                                        |   1 +
 .../clock/adi,sc5xx-clocks.yaml                    | 112 +++++++++++++++++++++
 2 files changed, 113 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c283e09901..d5f79097a1 100644
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


