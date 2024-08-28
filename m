Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7926AC54E92
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 10:14:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C814D88AB9;
	Wed, 28 Aug 2024 12:12:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="epLofqNU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A48088B35; Wed, 28 Aug 2024 12:12:31 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B8F888AA4
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 12:12:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+Oliver.Gaskell.analog.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 6BB24CE177D;
 Wed, 28 Aug 2024 10:12:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0B68C4E68F;
 Wed, 28 Aug 2024 10:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1724839448;
 bh=Hf+iLUBE0Z9zCI7oSDXcMWm+uxM6csrWUK4/8MFBEzE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=epLofqNUiZd62i+LKY8r6KoUcj97VbjA3Dnp8SfBZI+th374nl7XBJj8elG5LVJNy
 gkYsEAdPtxM8iXaWn74Yd36QcGeiqzVaFDT/AJb30VJdzoodT7v9Oe7RZS3ZegZK39
 mh5iagNAUTUfH9fPt9YT72XWR27N4MKbic6zYakNZi1hbkPqlRdx1ghdHJ3MtTNNMC
 Yqk8MajYvCAZEQqh5swDgFv/KO6wjLh2s2XfROAC+3HwkxBB2Kk7zAYQK94m9lnoZ3
 LBT/11Apm1vUd+7oR4QtVZimkayaOOoPBPHSbnCC/idAUxlPkQGYaugOz/ZvMBRXWZ
 /D4yVatJ92e2g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id D9883C54E83;
 Wed, 28 Aug 2024 10:04:08 +0000 (UTC)
From: Oliver Gaskell via B4 Relay
 <devnull+Oliver.Gaskell.analog.com@kernel.org>
Date: Wed, 28 Aug 2024 11:02:19 +0100
Subject: [PATCH 11/20] dt-bindings: timer: Add SC5xx Timer bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-sc5xx-upstreaming-patches-v1-11-44d9adfdf327@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724839434; l=1973;
 i=Oliver.Gaskell@analog.com; s=20240821; h=from:subject:message-id;
 bh=I2o0p/xdD0IsHjkuevpLbyfT+kKAvYH0pYLp56N7oms=;
 b=97p4ZUVBqbp7wAsKOsifwHFYFZ+vh+GOTbFQZQrLqgJtw+Xvc6hbF2zICmhoW0sGGaweUdBTr
 Q/gxCXT1WiXC1VlO9mhKBAQFs5ms/L8FJg8geVE2WV4Y4F9hVBUwtup
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

Add devicetree schema for the timer peripheral on Analog Devices SC5xx
series SoCs.

Signed-off-by: Oliver Gaskell <Oliver.Gaskell@analog.com>
---
 MAINTAINERS                                        |  1 +
 .../timer/adi,sc5xx-gptimer.yaml                   | 42 ++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d5f79097a1..823bb5ad92 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -609,6 +609,7 @@ F:	arch/arm/include/asm/arch-adi/
 F:	arch/arm/mach-sc5xx/
 F:	doc/device-tree-bindings/arm/adi/adi,sc5xx.yaml
 F:	doc/device-tree-bindings/clock/adi,sc5xx-clocks.yaml
+F:	doc/device-tree-bindings/timer/adi,sc5xx-gptimer.yaml
 F:	drivers/clk/adi/
 F:	drivers/serial/serial_adi_uart4.c
 F:	drivers/timer/adi_sc5xx_timer.c
diff --git a/doc/device-tree-bindings/timer/adi,sc5xx-gptimer.yaml b/doc/device-tree-bindings/timer/adi,sc5xx-gptimer.yaml
new file mode 100644
index 0000000000..5e313af6fe
--- /dev/null
+++ b/doc/device-tree-bindings/timer/adi,sc5xx-gptimer.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0+)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/adi,sc5xx-gptimer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices SC5XX Series SoC Timer Peripherals
+
+maintainers:
+  - Vasileios Bimpikas <vasileios.bimpikas@analog.com>
+  - Utsav Agarwal <utsav.agarwal@analog.com>
+  - Arturs Artamonovs <arturs.artamonovs@analog.com>
+
+properties:
+  compatible:
+    const: adi,sc5xx-gptimer
+
+  reg:
+    minItems: 2
+    maxItems: 2
+
+  clocks:
+    minItems: 1
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    timer0: timer@31018000 {
+      compatible = "adi,sc5xx-gptimer";
+      reg = <0x31018004 0x100>,
+            <0x31018060 0x100>;
+      status = "okay";
+      bootph-all;
+    };
+

-- 
2.34.1


